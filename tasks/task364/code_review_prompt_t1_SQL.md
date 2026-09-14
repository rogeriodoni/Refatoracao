# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FPAGS, LNCNT

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
  ControlSource = "crSigOpFp.FPags"
  ControlSource = "crSigOpFp.Descrs"
  ControlSource = "crSigCnFbl.nlnlocals"
  ControlSource = "crSigCnFbl.ncllocals"
  ControlSource = "crSigCnFbl.nlndtvencs"
  ControlSource = ""
  ControlSource = "crSigCnFbl.ncldtvencs"
  ControlSource = "crSigCnFbl.nlndtdocs"
  ControlSource = "crSigCnFbl.ncldtdocs"
  ControlSource = "crSigCnFbl.nlnnrdocs"
  ControlSource = "crSigCnFbl.nclnrdocs"
  ControlSource = "crSigCnFbl.nlnvldocs"
  ControlSource = "crSigCnFbl.nclvldocs"
  ControlSource = "crSigCnFbl.nlntxtcds"
  ControlSource = "crSigCnFbl.ncltxtcds"
  ControlSource = "crSigCnFbl.nlnrazclis"
  ControlSource = "crSigCnFbl.nclrazclis"
  ControlSource = "crSigCnFbl.nlncgcclis"
  ControlSource = "crSigCnFbl.nclcgcclis"
  ControlSource = "crSigCnFbl.nlnendcobs"
  ControlSource = "crSigCnFbl.nclendcobs"
  ControlSource = "crSigCnFbl.nlnbaicobs"
  ControlSource = "crSigCnFbl.nclbaicobs"
  ControlSource = "crSigCnFbl.nlncidcobs"
  ControlSource = "crSigCnFbl.nclcidcobs"
  ControlSource = "crSigCnFbl.nlnestcobs"
  ControlSource = "crSigCnFbl.nclestcobs"
  ControlSource = "crSigCnFbl.nlncepcobs"
  ControlSource = "crSigCnFbl.nclcepcobs"
  ControlSource = "crSigCnFbl.ntxtcols"
  ControlSource = "crSigCnFbl.ntxtlins"
  ControlSource = "crSigCnFbl.cnomeimps"
  ControlSource = "crSigCnFbl.cfontepdrs"
  ControlSource = "crSigCnFbl.ntamfontes"
lcQryFPag = [Select Distinct a.FPags, a.Descrs, b.FPags as TemDados ] + ;
		      [From SigOpFp a ] + ;
		  	  [Left Join SigCnFBl b ] + ;
lcQryCfgBl = [Select * From SigCnFBl Where FPags = ?pFpg]
Select crSigOpFp
Select crSigOpFp
	Insert Into crSigCnFBl (FPags, cIdChaves) Values (crSigOpFp.FPags, fUniqueIds())
Select crSigCnFBl
	Delete From crSigCnFBl
lcQuery = [Delete From SigCnFBl Where FPags = ?pFpg]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
	=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Delete)')
	If Not ThisForm.poDataMgr.Update('crSigCnFBl')
		=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update - crSigCnFBl)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCfb.prg) - TRECHOS RELEVANTES PARA PASS SQL (2781 linhas total):

*-- Linhas 2 a 21:
2: * FormCfb.PRG - Fase 7/8: Form - Eventos Principais (completo)
3: * Formulario de Configuracao de Boletos Bancarios (SIGCDCFB)
4: *
5: * Tabela: SIGCNFBL (leitura via SigOpFp com LEFT JOIN)
6: * Tipo: CRUD especial - somente ALTERAR (INSERT proibido pelo legado)
7: * BO: CfbBO
8: *==============================================================================
9: 
10: DEFINE CLASS FormCfb AS FormBase
11: 
12:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
13:     Height      = 600
14:     Width       = 1000
15:     Caption     = "Configura" + CHR(231) + CHR(227) + "o de Boletos Banc" + CHR(225) + "rios"
16:     AutoCenter  = .T.
17:     ShowWindow  = 1
18:     WindowType  = 1
19:     ControlBox  = .F.
20:     Closable    = .F.
21:     MaxButton   = .F.

*-- Linhas 343 a 361:
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)
345:             .BackColor          = RGB(255, 255, 255)
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .GridLines          = 3
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .Visible            = .T.
356:         ENDWITH
357: 
358:         WITH loc_oGrid.Column1
359:             .Width           = 100
360:             .Resizable       = .T.
361:             .Alignment       = 0

*-- Linhas 1560 a 1580:
1560:                     *-- RecordSource FORA do WITH para garantir criacao imediata das colunas
1561:                     loc_oGrid.ColumnCount = 3
1562:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1563:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
1564:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1565:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1566: 
1567:                     *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
1568:                     loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1569:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1570:                     loc_oGrid.Column3.Header1.Caption = "Configurado"
1571: 
1572:                     THIS.FormatarGridLista(loc_oGrid)
1573:                     loc_lResultado = .T.
1574:                 ENDIF
1575:             ENDIF
1576:         CATCH TO loc_oErro
1577:             MsgErro(loc_oErro.Message, "FormCfb.CarregarLista")
1578:             loc_lResultado = .F.
1579:         ENDTRY
1580: 

*-- Linhas 1678 a 1696:
1678:             RETURN
1679:         ENDIF
1680: 
1681:         SELECT cursor_4c_Dados
1682:         loc_cFPags  = ALLTRIM(cursor_4c_Dados.FPags)
1683:         loc_cDescrs = ALLTRIM(cursor_4c_Dados.Descrs)
1684: 
1685:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
1686:             THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
1687:             THIS.this_oBusinessObject.EditarRegistro()
1688:             THIS.this_cModoAtual = "ALTERAR"
1689:             THIS.BOParaForm()
1690:             THIS.HabilitarCampos(.T.)
1691:             THIS.AlternarPagina(2)
1692:         ELSE
1693:             MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o encontrada para " + ;
1694:                 "esta condi" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
1695:                 "O registro ser" + CHR(225) + " criado ao salvar.", "")
1696:             THIS.this_oBusinessObject.NovoRegistro()

*-- Linhas 1716 a 1734:
1716:             RETURN
1717:         ENDIF
1718: 
1719:         SELECT cursor_4c_Dados
1720:         loc_cFPags  = ALLTRIM(cursor_4c_Dados.FPags)
1721:         loc_cDescrs = ALLTRIM(cursor_4c_Dados.Descrs)
1722: 
1723:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
1724:             MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o encontrada para " + ;
1725:                 "esta condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
1726:             RETURN
1727:         ENDIF
1728: 
1729:         THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
1730:         THIS.this_cModoAtual = "VISUALIZAR"
1731:         THIS.BOParaForm()
1732:         THIS.HabilitarCampos(.F.)
1733:         THIS.AlternarPagina(2)
1734:     ENDPROC

*-- Linhas 1744 a 1762:
1744:             RETURN
1745:         ENDIF
1746: 
1747:         SELECT cursor_4c_Dados
1748:         IF EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
1749:             MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
1750:                 "o possui configura" + CHR(231) + CHR(227) + "o de boleto.", "")
1751:             RETURN
1752:         ENDIF
1753: 
1754:         loc_cFPags = ALLTRIM(cursor_4c_Dados.FPags)
1755: 
1756:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da configura" + CHR(231) + ;
1757:                 CHR(227) + "o de boleto para:" + CHR(13) + loc_cFPags + "?", ;
1758:                 "Confirmar Exclus" + CHR(227) + "o")
1759:             RETURN
1760:         ENDIF
1761: 
1762:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)

*-- Linhas 1784 a 1804:
1784:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1785:         loc_oGrid.ColumnCount = 3
1786:         loc_oGrid.RecordSource = "cursor_4c_Dados"
1787:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
1788:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1789:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1790:         loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1791:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1792:         loc_oGrid.Column3.Header1.Caption = "Configurado"
1793:         THIS.FormatarGridLista(loc_oGrid)
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * FormParaBO - Transfere valores dos campos do Form para o BO
1798:     * Fase 5: Secoes Condicao de Pagamento + Cabecalho + Texto Responsabilidade
1799:     *--------------------------------------------------------------------------
1800:     PROTECTED PROCEDURE FormParaBO()
1801:         LOCAL loc_oPg2
1802:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1803: 
1804:         TRY

*-- Linhas 2481 a 2519:
2481: 
2482:     *--------------------------------------------------------------------------
2483:     * CarregarLista - Carrega grid de condicoes de pagamento com indicador
2484:     * de configuracao (LEFT JOIN SigOpFp + SIGCNFBL via Buscar)
2485:     *--------------------------------------------------------------------------
2486:     PROCEDURE CarregarLista()
2487:         LOCAL loc_lResultado, loc_oGrid
2488:         loc_lResultado = .F.
2489: 
2490:         TRY
2491:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2492:                 loc_lResultado = .T.
2493:             ENDIF
2494: 
2495:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2496: 
2497:             IF !THIS.this_oBusinessObject.Buscar("")
2498:                 loc_lResultado = .F.
2499:             ELSE
2500:                 loc_oGrid.ColumnCount = 3
2501:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2502:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
2503:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2504:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2505: 
2506:                 loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2507:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2508:                 loc_oGrid.Column3.Header1.Caption = "Configurado"
2509: 
2510:                 THIS.FormatarGridLista(loc_oGrid)
2511:                 loc_lResultado = .T.
2512:             ENDIF
2513:         CATCH TO loc_oErro
2514:             MsgErro(loc_oErro.Message, "FormCfb.CarregarLista")
2515:             loc_lResultado = .F.
2516:         ENDTRY
2517: 
2518:         RETURN loc_lResultado
2519:     ENDPROC

*-- Linhas 2546 a 2588:
2546:     ENDPROC
2547: 
2548:     *--------------------------------------------------------------------------
2549:     * BtnIncluirClick - INSERT proibido neste cadastro (regra de negocio legada)
2550:     * Original: "Nao e Possivel Inserir Dados Atraves Deste Cadastro!!!"
2551:     *--------------------------------------------------------------------------
2552:     PROCEDURE BtnIncluirClick()
2553:         MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Inserir Dados Atrav" + ;
2554:             CHR(233) + "s Deste Cadastro!!!" + CHR(13) + ;
2555:             "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o Cadastro de Condi" + ;
2556:             CHR(231) + CHR(245) + "es de Pagamento.", ;
2557:             "Opera" + CHR(231) + CHR(227) + "o Bloqueada")
2558:     ENDPROC
2559: 
2560:     *--------------------------------------------------------------------------
2561:     * BtnAlterarClick - Carrega configuracao do boleto para edicao
2562:     * Se nao existir registro em SIGCNFBL, prepara para INSERT
2563:     *--------------------------------------------------------------------------
2564:     PROCEDURE BtnAlterarClick()
2565:         LOCAL loc_cFPags, loc_cDescrs, loc_lTemDados
2566: 
2567:         TRY
2568:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2569:                 MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
2570:                 RETURN
2571:             ENDIF
2572: 
2573:             SELECT cursor_4c_Dados
2574:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2575:             loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
2576:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2577: 
2578:             IF loc_lTemDados
2579:                 *-- Registro existe -> Atualizar
2580:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
2581:                     MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
2582:                     RETURN
2583:                 ENDIF
2584:                 THIS.this_oBusinessObject.EditarRegistro()
2585:             ELSE
2586:                 *-- Registro nao existe -> Inserir (neste caso o legado permitia via Alterar)
2587:                 THIS.this_oBusinessObject.NovoRegistro()
2588:                 THIS.this_oBusinessObject.this_cFPags   = loc_cFPags

*-- Linhas 2612 a 2630:
2612:                 RETURN
2613:             ENDIF
2614: 
2615:             SELECT cursor_4c_Dados
2616:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2617:             loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
2618:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2619: 
2620:             IF !loc_lTemDados
2621:                 MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento ainda n" + ;
2622:                     CHR(227) + "o foi configurada.", "")
2623:                 RETURN
2624:             ENDIF
2625: 
2626:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
2627:                 MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
2628:                 RETURN
2629:             ENDIF
2630: 

*-- Linhas 2651 a 2669:
2651:                 RETURN
2652:             ENDIF
2653: 
2654:             SELECT cursor_4c_Dados
2655:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2656:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2657: 
2658:             IF !loc_lTemDados
2659:                 MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento n" + CHR(227) + ;
2660:                     "o possui configura" + CHR(231) + CHR(227) + "o de boleto.", "")
2661:                 RETURN
2662:             ENDIF
2663: 
2664:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da configura" + ;
2665:                 CHR(231) + CHR(227) + "o de boleto para a condi" + CHR(231) + CHR(227) + ;
2666:                 "o [" + loc_cFPags + "]?", "Confirmar Exclus" + CHR(227) + "o")
2667: 
2668:             IF !loc_lConfirma
2669:                 RETURN

*-- Linhas 2691 a 2741:
2691:             loc_cFiltro = ""
2692: 
2693:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2694:                 SELECT cursor_4c_Dados
2695:                 loc_cFiltro = ALLTRIM(cursor_4c_Dados.FPags)
2696:             ENDIF
2697: 
2698:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2699:                 RETURN
2700:             ENDIF
2701: 
2702:             loc_oGrid.ColumnCount = 3
2703:             loc_oGrid.RecordSource = "cursor_4c_Dados"
2704:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
2705:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2706:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2707: 
2708:             loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2709:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2710:             loc_oGrid.Column3.Header1.Caption = "Configurado"
2711: 
2712:             THIS.FormatarGridLista(loc_oGrid)
2713:         CATCH TO loc_oErro
2714:             MsgErro(loc_oErro.Message, "FormCfb.BtnBuscarClick")
2715:         ENDTRY
2716:     ENDPROC
2717: 
2718:     *--------------------------------------------------------------------------
2719:     * BtnEncerrarClick - Fecha o formulario
2720:     *--------------------------------------------------------------------------
2721:     PROCEDURE BtnEncerrarClick()
2722:         THIS.Release()
2723:     ENDPROC
2724: 
2725:     *--------------------------------------------------------------------------
2726:     * BtnSalvarClick - Salva configuracao de boleto (INSERT ou UPDATE)
2727:     * Equivalente ao botao Confirmar na Page2
2728:     *--------------------------------------------------------------------------
2729:     PROCEDURE BtnSalvarClick()
2730:         LOCAL loc_lResultado
2731: 
2732:         THIS.FormParaBO()
2733: 
2734:         TRY
2735:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
2736:             IF loc_lResultado
2737:                 MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso!")
2738:                 THIS.AlternarPagina(1)
2739:             ENDIF
2740:         CATCH TO loc_oErro
2741:             MsgErro(loc_oErro.Message, "FormCfb.BtnSalvarClick")


### BO (C:\4c\projeto\app\classes\CfbBO.prg):
*==============================================================================
* CfbBO.prg - Business Object: Configura??o de Boletos Banc?rios
* Tabela: SIGCNFBL
* PK: cidchaves (t?cnica) | Chave de neg?cio: fpags (FK SigOpFp)
*==============================================================================
DEFINE CLASS CfbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chaves
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) - PK t?cnica
    this_cFPags     = ""    && fpags     char(12) - chave de neg?cio (FK SigOpFp)

    *--------------------------------------------------------------------------
    * Propriedades - Audi/Controle
    *--------------------------------------------------------------------------
    this_cCEmps     = ""    && cemps      char(3)
    this_dDDatas    = {}    && ddatas     datetime
    this_cCHoras    = ""    && choras     char(8)
    this_cCUsuarios = ""    && cusuarios  char(20)

    *--------------------------------------------------------------------------
    * Propriedades - Texto livre (sem binding UI, preservado na grava??o)
    *--------------------------------------------------------------------------
    this_cCLocals   = ""    && clocals    char(100) - local de pagamento (texto)
    this_cCTxtCds   = ""    && ctxtcds    text      - texto de resp. do cedente

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Cabe?alho (Local de Pagamento)
    *--------------------------------------------------------------------------
    this_nNlnLocals = 0     && nlnlocals  numeric(5,2) - linha
    this_nNclLocals = 0     && ncllocals  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Vencimento
    *--------------------------------------------------------------------------
    this_nNlnDtVencs = 0    && nlndtvencs numeric(5,2) - linha
    this_nNclDtVencs = 0    && ncldtvencs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Data Documento
    *--------------------------------------------------------------------------
    this_nNlnDtDocs = 0     && nlndtdocs  numeric(5,2) - linha
    this_nNclDtDocs = 0     && ncldtdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o N? do Documento
    *--------------------------------------------------------------------------
    this_nNlnNrDocs = 0     && nlnnrdocs  numeric(5,2) - linha
    this_nNclNrDocs = 0     && nclnrdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Valor do Documento
    *--------------------------------------------------------------------------
    this_nNlnVlDocs = 0     && nlnvldocs  numeric(5,2) - linha
    this_nNclVlDocs = 0     && nclvldocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Texto de Responsabilidade
    *--------------------------------------------------------------------------
    this_nNlnTxtCds = 0     && nlntxtcds  numeric(5,2) - linha
    this_nNclTxtCds = 0     && ncltxtcds  numeric(5,2) - coluna
    this_nNTxtLins  = 0     && ntxtlins   numeric(3,0) - n? de linhas
    this_nNTxtCols  = 0     && ntxtcols   numeric(3,0) - n? de colunas

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Raz?o Social
    *--------------------------------------------------------------------------
    this_nNlnRazClis = 0    && nlnrazclis numeric(5,2) - linha
    this_nNclRazClis = 0    && nclrazclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.G.C./C.P.F.
    *--------------------------------------------------------------------------
    this_nNlnCgcClis = 0    && nlncgcclis numeric(5,2) - linha
    this_nNclCgcClis = 0    && nclcgcclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Endere?o
    *--------------------------------------------------------------------------
    this_nNlnEndCobs = 0    && nlnendcobs numeric(5,2) - linha
    this_nNclEndCobs = 0    && nclendcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Bairro
    *--------------------------------------------------------------------------
    this_nNlnBaiCobs = 0    && nlnbaicobs numeric(5,2) - linha
    this_nNclBaiCobs = 0    && nclbaicobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Cidade
    *--------------------------------------------------------------------------
    this_nNlnCidCobs = 0    && nlncidcobs numeric(5,2) - linha
    this_nNclCidCobs = 0    && nclcidcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: U.F.
    *--------------------------------------------------------------------------
    this_nNlnEstCobs = 0    && nlnestcobs numeric(5,2) - linha
    this_nNclEstCobs = 0    && nclestcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.E.P.
    *--------------------------------------------------------------------------
    this_nNlnCepCobs = 0    && nlncepcobs numeric(5,2) - linha
    this_nNclCepCobs = 0    && nclcepcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Impressora / Fonte
    *--------------------------------------------------------------------------
    this_cCNomeImps  = ""   && cnomeimps  char(128) - nome da impressora
    this_cCFontePdrs = ""   && cfontepdrs char(128) - fonte padr?o
    this_nNTamFontes = 0    && ntamfontes numeric(3,0) - tamanho da fonte
    this_cCTamFolha  = ""   && ctamfolha  char(50)  - tamanho da folha

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (display only, n?o persistidas em SIGCNFBL)
    *--------------------------------------------------------------------------
    this_cDescrs = ""       && Descrs de SigOpFp (descri??o da condi??o de pgto)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SIGCNFBL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista condi??es de pagamento com indicador de configura??o
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " ORDER BY a.FPags"
            ELSE
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " WHERE a.FPags = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                    " OR a.Descrs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY a.FPags"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega configura??o de boleto pelo fpags
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha" + ;
                " FROM SIGCNFBL" + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(par_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
            THIS.this_cFPags        = TratarNulo(fpags,        "C")
            THIS.this_cCEmps        = TratarNulo(cemps,        "C")
            THIS.this_dDDatas       = TratarNulo(ddatas,       "D")
            THIS.this_cCHoras       = TratarNulo(choras,       "C")
            THIS.this_cCUsuarios    = TratarNulo(cusuarios,    "C")
            THIS.this_cCTxtCds      = TratarNulo(ctxtcds,      "C")
            THIS.this_cCLocals      = TratarNulo(clocals,      "C")
            THIS.this_nNlnLocals    = TratarNulo(nlnlocals,    "N")
            THIS.this_nNclLocals    = TratarNulo(ncllocals,    "N")
            THIS.this_nNlnDtVencs   = TratarNulo(nlndtvencs,   "N")
            THIS.this_nNclDtVencs   = TratarNulo(ncldtvencs,   "N")
            THIS.this_nNlnDtDocs    = TratarNulo(nlndtdocs,    "N")
            THIS.this_nNclDtDocs    = TratarNulo(ncldtdocs,    "N")
            THIS.this_nNlnNrDocs    = TratarNulo(nlnnrdocs,    "N")
            THIS.this_nNclNrDocs    = TratarNulo(nclnrdocs,    "N")
            THIS.this_nNlnVlDocs    = TratarNulo(nlnvldocs,    "N")
            THIS.this_nNclVlDocs    = TratarNulo(nclvldocs,    "N")
            THIS.this_nNlnTxtCds    = TratarNulo(nlntxtcds,    "N")
            THIS.this_nNclTxtCds    = TratarNulo(ncltxtcds,    "N")
            THIS.this_nNTxtLins     = TratarNulo(ntxtlins,     "N")
            THIS.this_nNTxtCols     = TratarNulo(ntxtcols,     "N")
            THIS.this_nNlnRazClis   = TratarNulo(nlnrazclis,   "N")
            THIS.this_nNclRazClis   = TratarNulo(nclrazclis,   "N")
            THIS.this_nNlnCgcClis   = TratarNulo(nlncgcclis,   "N")
            THIS.this_nNclCgcClis   = TratarNulo(nclcgcclis,   "N")
            THIS.this_nNlnEndCobs   = TratarNulo(nlnendcobs,   "N")
            THIS.this_nNclEndCobs   = TratarNulo(nclendcobs,   "N")
            THIS.this_nNlnBaiCobs   = TratarNulo(nlnbaicobs,   "N")
            THIS.this_nNclBaiCobs   = TratarNulo(nclbaicobs,   "N")
            THIS.this_nNlnCidCobs   = TratarNulo(nlncidcobs,   "N")
            THIS.this_nNclCidCobs   = TratarNulo(nclcidcobs,   "N")
            THIS.this_nNlnEstCobs   = TratarNulo(nlnestcobs,   "N")
            THIS.this_nNclEstCobs   = TratarNulo(nclestcobs,   "N")
            THIS.this_nNlnCepCobs   = TratarNulo(nlncepcobs,   "N")
            THIS.this_nNclCepCobs   = TratarNulo(nclcepcobs,   "N")
            THIS.this_cCNomeImps    = TratarNulo(cnomeimps,    "C")
            THIS.this_cCFontePdrs   = TratarNulo(cfontepdrs,   "C")
            THIS.this_nNTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cCTamFolha    = TratarNulo(ctamfolha,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCNFBL" + ;
                " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha)"

            loc_cVals = " VALUES (LEFT(NEWID(), 20)," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cFPags)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " GETDATE()," + ;
                " " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL + loc_cVals, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza configura??o de boleto bancario existente
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCNFBL SET" + ;
                " cemps = " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " ddatas = GETDATE()," + ;
                " choras = " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " cusuarios = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " ctxtcds = " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " clocals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " ncllocals = " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " ntxtlins = " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " ntxtcols = " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " cnomeimps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " cfontepdrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " ntamfontes = " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " ctamfolha = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCNFBL WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

