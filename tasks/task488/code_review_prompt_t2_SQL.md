# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: ICLIS, CODIGOS, CODS, OPERACAOS, TIPOS, VALUE, CONGVS, INFOS, EMICHQS, PARCELAS, PRIORS

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
  ControlSource = "crSigCdOpt.opants"
  ControlSource = "crSigCdOpt.Destinos"
  ControlSource = "crSigCdOpt.tpdatas"
  ControlSource = "crSigCdOpt.operacaos"
  ControlSource = "crSigCdOpt.descrs"
  ControlSource = "crSigCdOpt.tipos"
  ControlSource = "crSigCdOpt.opauts"
  ControlSource = "crSigCdOpt.dopcs"
  ControlSource = "crSigCdOpt.ordens"
  ControlSource = "crSigCdOpt.VencUtil"
  ControlSource = "crSigCdOpt.Cartdbs"
  ControlSource = "crSigCdOpt.congvs"
  ControlSource = "crSigCdOpt.valpends"
  ControlSource = "crSigCdOpt.vvectos"
  ControlSource = "crSigCdOpt.bxpends"
  ControlSource = "crSigCdOpt.fazcontas"
  ControlSource = "crSigCdOpt.valpend2s"
  ControlSource = "crSigCdOpt.grupot"
  ControlSource = ""
  ControlSource = "crSigCdOpt.grudeps"
  ControlSource = ""
  ControlSource = "crSigCdOpt.condeps"
  ControlSource = "crSigCdOpt.Ccentrals"
  ControlSource = "crSigCdOpt.hists"
  ControlSource = ""
  ControlSource = "crSigCdOpt.HistClis"
  ControlSource = "crSigCdOpt.Obs"
  ControlSource = "crSigCdOpt.AltDados"
  ControlSource = "crSigCdOpt.prorrogas"
  ControlSource = "crSigCdOpt.tphists"
  ControlSource = "crSigCdOpt.Empinds"
  ControlSource = "crSigCdOpt.EmiCarts"
  ControlSource = "crSigCdOpt.Origems"
  ControlSource = "crSigCdOpt.Devolvidos"
  ControlSource = "crSigCdOpt.EmiProts"
  ControlSource = "crSigCdOpt.CadEmis"
  ControlSource = "crSigCdOpt.Alineas"
  ControlSource = "crSigCdOpt.EmiInds"
  ControlSource = "crSigCdOpt.GrupoOs"
  ControlSource = "crSigCdOpt.descontos"
  ControlSource = "crSigCdOpt.respons"
  ControlSource = "crSigCdOpt.GruEMis"
  ControlSource = ""
  ControlSource = "crSigCdOpt.ContaOs"
  ControlSource = ""
  ControlSource = "crSigCdOpt.geranarqs"
  ControlSource = "crSigCdOpt.pefins"
  ControlSource = "crSigCdOpt.anasits"
  ControlSource = "crSigCdOpt.comiss"
  ControlSource = "crSigCdOpt.Parcelas"
  ControlSource = "crSigCdOpt.Consolidas"
  ControlSource = "crSigCdOpt.FPags"
  ControlSource = "crSigCdOpt.OpEntradas"
  ControlSource = "crSigCdOpt.situas"
  ControlSource = "crSigCdOpt.tpEmiss"
  ControlSource = "crSigCdOpt.TpLeituras"
  ControlSource = "crSigCdOpt.LeProts"
  ControlSource = "crSigCdOpt.nDtEmiss"
  ControlSource = "crSigCdOpt.Moedas"
  ControlSource = "crSigCdOpt.Inativas"
	If Thisform.PoDatamgr.SQLExecute([Select Rclis from SigCdCli where Iclis = '] + CrSigCdOpt.ContaOs + [' ],'CrSigCdCli') > 0
	If Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdGcr where Codigos = '] + CrSigCdOpt.GrupoOs + [' ],'CrSigCdGcr') > 0
	If Thisform.PoDatamgr.SQLExecute([Select Rclis from SigCdCli where Iclis = '] + CrSigCdOpt.Condeps + [' ],'CrSigCdCli') > 0
	If Thisform.PoDatamgr.SQLExecute([Select Descrs from SigCdGcr where Codigos = '] + CrSigCdOpt.Grudeps + [' ],'CrSigCdGcr') > 0
	if Thisform.PoDatamgr.SQLExecute([Select Descs from SIGCCCCO where Cods = '] + CrSigCdOpt.Ccentrals + [' ],'CrSIGCCCCO') > 0
Select CrSigCdOpt
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdOpt Where operacaos = '] + lcOpEntradas + [' ],'csOpEntradas')
	If Thisform.PoDatamgr.SQLExecute([Select Tipos, Operacaos from SigCdOpt where Operacaos = '] + CrSigCdOpt.opants + [' ],'CnSigCdOpt') < 0
	ThisForm.podatamgr.SqlExecute([Select * From SIGOPOPE Where Congvs = ?pTru],'TmpOpe')
	Select TmpOpe
	If !Seek( This.Value )
select CrSigCdOpt
select CrSigCdOpt
select CrSigCdOpt
select CrSigCdOpt
		select CrSigCdOpt
	select CrSigCdOpt
		select CrSigCdOpt
	select CrSigCdOpt
select CrSigCdOpt
Select CrSigCdOpt
select CrSigCdOpt
select CrSigCdOpt
		select CrSigCdOpt
	select CrSigCdOpt
		select CrSigCdOpt
	select CrSigCdOpt
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigOpFp Where Infos = 'C' ] + [ And EmiChqs <> ] + '1','CrSigOpFp')
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select * From SigCdOpt Where operacaos <> '] + lcCodigo + [' And tipos <> '] + lctipo + [' ],'CnSigCdOpt')
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.codigos, a.descrs, a.priors From SigCdCst a Where a.Priors Between 1 And 998],'CrSigCdCst')
Select CrSigCdCst

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOpt.prg) - TRECHOS RELEVANTES PARA PASS SQL (4622 linhas total):

*-- Linhas 350 a 368:
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .DeleteMark         = .F.
354:             .RecordMark         = .F.
355:             .RowHeight          = 16
356:             .ScrollBars         = 2
357:             .GridLines          = 3
358:             .ReadOnly           = .T.
359:             .Visible            = .T.
360:         ENDWITH
361: 
362:         WITH loc_oGrid.Column1
363:             .Header1.Caption = "Movimento"
364:             .Width           = 140
365:             .ReadOnly        = .T.
366:         ENDWITH
367: 
368:         WITH loc_oGrid.Column2

*-- Linhas 2742 a 2775:
2742: 
2743:     *==========================================================================
2744:     * CarregarLista - Carrega dados no grid da Page1
2745:     * SELECT conforme colunas do legado: Operacaos, Tipos, OpAnts, GrupoOs
2746:     *==========================================================================
2747:     PROCEDURE CarregarLista()
2748:         LOCAL loc_lResultado, loc_oGrid
2749:         loc_lResultado = .F.
2750: 
2751:         TRY
2752:             IF THIS.this_oBusinessObject.Buscar("")
2753:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2754: 
2755:                 loc_oGrid.ColumnCount = 4
2756:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
2757:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Operacaos"
2758:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Tipos"
2759:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OpAnts"
2760:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.GrupoOs"
2761: 
2762:                 *-- Reconfigurar cabecalhos apos RecordSource (VFP reseta Headers)
2763:                 loc_oGrid.Column1.Header1.Caption = "Movimento"
2764:                 loc_oGrid.Column2.Header1.Caption = "Tipo"
2765:                 loc_oGrid.Column3.Header1.Caption = "Mv. Anterior"
2766:                 loc_oGrid.Column4.Header1.Caption = "Grupo/Ori"
2767: 
2768:                 loc_oGrid.Column1.Width = 140
2769:                 loc_oGrid.Column2.Width = 60
2770:                 loc_oGrid.Column3.Width = 140
2771:                 loc_oGrid.Column4.Width = 80
2772: 
2773:                 THIS.FormatarGridLista(loc_oGrid)
2774:                 loc_lResultado = .T.
2775:             ENDIF

*-- Linhas 2841 a 2859:
2841:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2842:                 MsgAviso("Selecione um registro para visualizar.", "")
2843:             ELSE
2844:                 SELECT cursor_4c_Dados
2845:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2846: 
2847:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2848:                     THIS.this_cModoAtual = "VISUALIZAR"
2849:                     THIS.BOParaForm()
2850:                     THIS.HabilitarCampos(.F.)
2851:                     THIS.pgf_4c_Paginas.ActivePage = 2
2852:                     loc_lResultado = .T.
2853:                 ELSE
2854:                     MsgErro("Erro ao carregar registro para visualizar.", ;
2855:                         "FormOpt.BtnVisualizarClick")
2856:                 ENDIF
2857:             ENDIF
2858:         CATCH TO loc_oErro
2859:             MsgErro("Erro ao visualizar:" + CHR(13) + loc_oErro.Message, ;

*-- Linhas 2874 a 2892:
2874:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2875:                 MsgAviso("Selecione um registro para alterar.", "")
2876:             ELSE
2877:                 SELECT cursor_4c_Dados
2878:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2879: 
2880:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2881:                     THIS.this_oBusinessObject.EditarRegistro()
2882:                     THIS.this_cModoAtual = "ALTERAR"
2883:                     THIS.BOParaForm()
2884:                     THIS.HabilitarCampos(.T.)
2885:                     THIS.pgf_4c_Paginas.ActivePage = 2
2886:                     loc_lResultado = .T.
2887:                 ELSE
2888:                     MsgErro("Erro ao carregar registro para alterar.", ;
2889:                         "FormOpt.BtnAlterarClick")
2890:                 ENDIF
2891:             ENDIF
2892:         CATCH TO loc_oErro

*-- Linhas 2908 a 2926:
2908:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2909:                 MsgAviso("Selecione um registro para excluir.", "")
2910:             ELSE
2911:                 SELECT cursor_4c_Dados
2912:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.Operacaos)
2913: 
2914:                 loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + ;
2915:                     "o do registro '" + loc_cCodigo + "'?", ;
2916:                     "Confirmar Exclus" + CHR(227) + CHR(227) + "o")
2917: 
2918:                 IF loc_lConfirmou
2919:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2920:                         IF THIS.this_oBusinessObject.Excluir()
2921:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", ;
2922:                                 "Sucesso")
2923:                             THIS.CarregarLista()
2924:                         ELSE
2925:                             MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2926:                                 "vel excluir o registro.", "FormOpt.BtnExcluirClick")

*-- Linhas 2959 a 2977:
2959:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
2960:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaOpt.Operacaos)
2961:                     IF USED("cursor_4c_Dados")
2962:                         SELECT cursor_4c_Dados
2963:                         LOCATE FOR ALLTRIM(Operacaos) == loc_cCodigo
2964:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2965:                     ENDIF
2966:                 ENDIF
2967: 
2968:                 loc_oBusca.Release()
2969:             ENDIF
2970: 
2971:             IF USED("cursor_4c_BuscaOpt")
2972:                 USE IN cursor_4c_BuscaOpt
2973:             ENDIF
2974: 
2975:             loc_lResultado = .T.
2976:         CATCH TO loc_oErro
2977:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, ;

*-- Linhas 4523 a 4593:
4523:             ENDIF
4524: 
4525:             *-- Passo 1: busca exata via SQL no caller (DataSession=2)
4526:             loc_cSQL = "SELECT " + par_cCampoCod
4527:             IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
4528:                 loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
4529:             ENDIF
4530:             loc_cSQL = loc_cSQL + " FROM " + par_cTabela + ;
4531:                 " WHERE CAST(" + par_cCampoCod + " AS VARCHAR(50)) = " + ;
4532:                 EscaparSQL(UPPER(ALLTRIM(par_cValor))) + loc_cWhere
4533: 
4534:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)
4535: 
4536:             IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND RECCOUNT(loc_cCursorBusca) = 1
4537:                 *-- Exato encontrado: popula controles diretamente
4538:                 SELECT (loc_cCursorBusca)
4539:                 IF VARTYPE(par_oCtrlCod) = "O"
4540:                     par_oCtrlCod.Value = ALLTRIM(&par_cCampoCod)
4541:                 ENDIF
4542:                 IF VARTYPE(par_oCtrlDesc) = "O" AND !EMPTY(par_cCampoDesc) ;
4543:                         AND par_cCampoDesc != par_cCampoCod
4544:                     par_oCtrlDesc.Value = ALLTRIM(&par_cCampoDesc)
4545:                 ENDIF
4546:                 loc_lResultado = .T.
4547:             ELSE
4548:                 *-- Nao encontrou exato: busca parcial para picker
4549:                 IF USED(loc_cCursorBusca)
4550:                     USE IN (loc_cCursorBusca)
4551:                 ENDIF
4552: 
4553:                 loc_cSQL = "SELECT " + par_cCampoCod
4554:                 IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
4555:                     loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
4556:                 ENDIF
4557:                 loc_cSQL = loc_cSQL + " FROM " + par_cTabela + ;
4558:                     " WHERE CAST(" + par_cCampoCod + " AS VARCHAR(50)) LIKE " + ;
4559:                     EscaparSQL(UPPER(ALLTRIM(par_cValor)) + "%") + loc_cWhere + ;
4560:                     " ORDER BY " + par_cCampoCod
4561:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)
4562: 
4563:                 IF loc_nResult <= 0 OR !USED(loc_cCursorBusca) OR ;
4564:                         RECCOUNT(loc_cCursorBusca) = 0
4565:                     *-- Fallback show-all (sem filtro de valor, respeita par_cFiltro)
4566:                     IF USED(loc_cCursorBusca)
4567:                         USE IN (loc_cCursorBusca)
4568:                     ENDIF
4569:                     loc_cSQL = "SELECT " + par_cCampoCod
4570:                     IF !EMPTY(par_cCampoDesc) AND par_cCampoDesc != par_cCampoCod
4571:                         loc_cSQL = loc_cSQL + ", " + par_cCampoDesc
4572:                     ENDIF
4573:                     loc_cSQL = loc_cSQL + " FROM " + par_cTabela
4574:                     IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
4575:                         loc_cSQL = loc_cSQL + " WHERE (" + par_cFiltro + ")"
4576:                     ENDIF
4577:                     loc_cSQL = loc_cSQL + " ORDER BY " + par_cCampoCod
4578:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorBusca)
4579:                 ENDIF
4580: 
4581:                 IF loc_nResult > 0 AND USED(loc_cCursorBusca) AND ;
4582:                         RECCOUNT(loc_cCursorBusca) > 0
4583:                     *-- Abre picker sem params (Pattern A canonico)
4584:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4585:                     IF VARTYPE(loc_oBusca) = "O"
4586:                         loc_oBusca.DefinirCursor(loc_cCursorBusca, par_cCampoCod, ;
4587:                             IIF(!EMPTY(par_cCampoDesc), par_cCampoDesc, par_cCampoCod), ;
4588:                             par_cTitulo)
4589:                         loc_oBusca.this_cCursorDestino = loc_cCursorBusca
4590:                         loc_oBusca.Mostrar()
4591:                         IF !EMPTY(loc_oBusca.cCodigoSelecionado)
4592:                             IF VARTYPE(par_oCtrlCod) = "O"
4593:                                 par_oCtrlCod.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)


### BO (C:\4c\projeto\app\classes\OptBO.prg):
*==============================================================================
* OptBO.prg - Business Object para Cadastro de Movimentacoes de Cheques
* Tabela: SigCdOpt | PK: operacaos
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OptBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpt"
    this_cCampoChave  = "operacaos"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpt (todas as colunas da tabela)
    *--------------------------------------------------------------------------
    *-- Identificacao / chave primaria
    this_cOperacaos   = ""    && operacaos  char(15)     - Codigo / chave primaria
    this_cDescrs      = ""    && descrs     char(20)     - Descricao
    this_cTipos       = ""    && tipos      char(2)      - Tipo (CR/DB/TR)

    *-- Operacoes relacionadas
    this_cOpAnts      = ""    && opants     char(15)     - Movimento anterior
    this_cOpEntradas  = ""    && opentradas char(15)     - Movimento de entrada
    this_cDopcs       = ""    && dopcs      char(20)     - Movimento de titulos (SIGOPOPE.Dopes)
    this_cDevolvidos  = ""    && devolvidos char(1)      - Operacao de devolvido (S/N)

    *-- Ordem e configuracao basica
    this_nOrdens      = 0     && ordens     numeric(1,0) - Ordem
    this_cOpAuts      = ""    && opauts     char(1)      - Movimento automatico (S/N)
    this_nTpDatas     = 0     && tpdatas    numeric(1,0) - Tipo de data contabil
    this_nDtContab    = 0     && dtcontab   numeric(1,0) - Data contabil option
    this_nDestinos    = 0     && destinos   numeric(1,0) - Destino option
    this_nOrigems     = 0     && origems    numeric(1,0) - Origem option

    *-- Grupo e Conta de Destino (contabilidade)
    this_cGruDeps     = ""    && grudeps    char(10)     - Grupo destino
    this_cConDeps     = ""    && condeps    char(10)     - Conta destino

    *-- Grupo e Conta de Origem (contabilidade - OS)
    this_cGrupoOs     = ""    && grupoos    char(10)     - Grupo origem
    this_cContaOs     = ""    && contaos    char(10)     - Conta origem

    *-- Grupo Terceiro (contabilidade)
    this_cGrupoT      = ""    && grupot     char(10)     - Grupo terceiro

    *-- Central de Credito
    this_cCCentrals   = ""    && ccentrals  char(2)      - Central de credito

    *-- Historico
    this_cHists       = ""    && hists      char(30)     - Historico padrao
    this_nTpHists     = 0     && tphists    numeric(1,0) - Tipo historico
    this_cHistClis    = ""    && histclis   char(1)      - Lanca historico cliente (S/N)

    *-- Responsavel e Emissor
    this_cRespons     = ""    && respons    char(10)     - Responsavel (conta contabil)
    this_cGruEmis     = ""    && gruemis    char(10)     - Grupo emissor default
    this_cEmpInds     = ""    && empinds    char(1)      - Empresa individual (S/N)
    this_cEmiInds     = ""    && emiinds    char(1)      - Emissor individual (S/N)
    this_cCademis     = ""    && cademis    char(1)      - Cadastra emissor (S/N)
    this_nTpEmiss     = 0     && tpemiss    numeric(1,0) - Tipo emissor option

    *-- Forma de Pagamento e Parcelas
    this_cFPags       = ""    && fpags      char(12)     - Condicao de pagamento
    this_cParcelas    = ""    && parcelas   char(1)      - Parcelas (S/N)

    *-- Pendencias e Valores
    this_cValPends    = ""    && valpends   char(1)      - Valor pendente emissor (S/N)
    this_cValPend2s   = ""    && valpend2s  char(1)      - Valor pendente deposito (S/N)
    this_cBxPends     = ""    && bxpends    char(1)      - Baixa pendencias (S/N)
    this_cVVectos     = ""    && vvectos    char(1)      - Verifica vencimento (S/N)
    this_cFazContas   = ""    && fazcontas  char(1)      - Lanca conta corrente (S/N)

    *-- Situacao e Observacao
    this_cSituas      = ""    && situas     char(3)      - Situacao do cliente
    this_cObs         = ""    && obs        char(1)      - Observacao (S/N/C)

    *-- Carta e Protocolo
    this_cEmiCarts    = ""    && emicarts   char(1)      - Emite carta (S/N)
    this_cEmiProts    = ""    && emiprots   char(1)      - Emite protocolo (S/N)
    this_cAlineas     = ""    && alineas    char(1)      - Tem alinea (S/N)

    *-- Leitura e Geracao
    this_nTpLeituras  = 0     && tpleituras numeric(1,0) - Tipo leitura de cheque
    this_nLeProts     = 0     && leprots    numeric(1,0) - Leitura protocolo option
    this_nGeranarqs   = 0     && geranarqs  numeric(1,0) - Gera numero arquivo option
    this_cGerCnabs    = ""    && gercnabs   char(1)      - Gera CNAB (S/N)
    this_cValidaChqs  = ""    && validachqs char(1)      - Valida cheques (S/N)

    *-- Data de Emissao
    this_nNdtEmiss    = 0     && ndtemiss   numeric(1,0) - Data emissao padrao option

    *-- Descontos e Comissao
    this_nDescontos   = 0     && descontos  numeric(4,2) - Percentual comissao
    this_nComiss      = 0     && comiss     numeric(1,0) - Calculo de comissao option
    this_nIndProds    = 0     && indprods   numeric(4,2) - Indicador de producao

    *-- Pendencias Financeiras e Situacao Global
    this_nPeFins      = 0     && pefins     numeric(1,0) - Pendencias financeiras option
    this_nAnaSits     = 0     && anasits    numeric(1,0) - Cons. global situacao option

    *-- Carteira e Prorrogacao
    this_nCartDbs     = 0     && cartdbs    numeric(1,0) - Carteira tipo (CR) option
    this_nProrrogas   = 0     && prorrogas  numeric(1,0) - Prorrogar tipo (CR) option
    this_cLimpCarts   = ""    && limpcarts  char(1)      - Limpa carteira (S/N)

    *-- Consolidacao e Alteracao
    this_cConsolidas  = ""    && consolidas char(1)      - Consolida lancamentos (S/N)
    this_nAltDados    = 0     && altdados   numeric(1,0) - Altera dados option

    *-- Vencimento e Moeda
    this_cCongvs      = ""    && congvs     char(1)      - Vencimento dia util (S/N)
    this_nVencUtil    = 0     && vencutil   numeric(1,0) - Vencimento dia util option
    this_cMoedas      = ""    && moedas     char(3)      - Moeda

    *-- Inativa
    this_nInativas    = 0     && inativas   numeric(1,0) - Inativa (0=Ativo, 1=Inativo)

    *-- Juros
    this_nChkJuros    = 0     && chkjuros   numeric(1,0) - Cobra juros option
    this_nPerJuros    = 0     && perjuros   numeric(4,2) - Percentual de juros
    this_nChkSmtJuro  = 0     && chksmtjuro numeric(1,0) - Somatorio de juros option

    *-- Configuracoes avancadas
    this_nImpChDev    = 0     && impchdev   numeric(1,0) - Imprime cheque devolvido option
    this_nLancCobr    = 0     && lanccobr   numeric(1,0) - Lanca cobranca option
    this_nAltConfSit  = 0     && altconfsit numeric(1,0) - Altera confirmacao situacao option
    this_cAltSituas   = ""    && altsituas  char(3)      - Altera situacao para
    this_nChkPortChq  = 0     && chkPortChq numeric(1,0) - Portador cheque option

    *-- Flags de fixacao de grupos/contas
    this_lFixGOrigs   = .F.   && fixgorigs  bit          - Fixa grupo origem
    this_lFixCOrigs   = .F.   && fixcorigs  bit          - Fixa conta origem
    this_lFixGDests   = .F.   && fixgdests  bit          - Fixa grupo destino
    this_lFixCDests   = .F.   && fixcdests  bit          - Fixa conta destino

    *-- Flags gerais
    this_lFlags       = .F.   && flags      bit          - Flag geral
    this_lLComis      = .F.   && lcomis     bit          - Lanca comissao flag

    *-- Cabecalho e Rodape (text/memo)
    this_cCabs        = ""    && cabs       text         - Cabecalho
    this_cRods        = ""    && rods       text         - Rodape

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpt"
        THIS.this_cCampoChave = "operacaos"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cOperacaos)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    * REGRA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cOperacaos   = TratarNulo(Operacaos,  "C")
                THIS.this_cDescrs      = TratarNulo(Descrs,     "C")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cOpAnts      = TratarNulo(OpAnts,     "C")
                THIS.this_cOpEntradas  = TratarNulo(OpEntradas, "C")
                THIS.this_cDopcs       = TratarNulo(Dopcs,      "C")
                THIS.this_cDevolvidos  = TratarNulo(Devolvidos, "C")
                THIS.this_nOrdens      = TratarNulo(Ordens,     "N")
                THIS.this_cOpAuts      = TratarNulo(OpAuts,     "C")
                THIS.this_nTpDatas     = TratarNulo(TpDatas,    "N")
                THIS.this_nDtContab    = TratarNulo(DtContab,   "N")
                THIS.this_nDestinos    = TratarNulo(Destinos,   "N")
                THIS.this_nOrigems     = TratarNulo(Origems,    "N")
                THIS.this_cGruDeps     = TratarNulo(GruDeps,    "C")
                THIS.this_cConDeps     = TratarNulo(ConDeps,    "C")
                THIS.this_cGrupoOs     = TratarNulo(GrupoOs,    "C")
                THIS.this_cContaOs     = TratarNulo(ContaOs,    "C")
                THIS.this_cGrupoT      = TratarNulo(GrupoT,     "C")
                THIS.this_cCCentrals   = TratarNulo(CCentrals,  "C")
                THIS.this_cHists       = TratarNulo(Hists,      "C")
                THIS.this_nTpHists     = TratarNulo(TpHists,    "N")
                THIS.this_cHistClis    = TratarNulo(HistClis,   "C")
                THIS.this_cRespons     = TratarNulo(Respons,    "C")
                THIS.this_cGruEmis     = TratarNulo(GruEmis,    "C")
                THIS.this_cEmpInds     = TratarNulo(EmpInds,    "C")
                THIS.this_cEmiInds     = TratarNulo(EmiInds,    "C")
                THIS.this_cCademis     = TratarNulo(Cademis,    "C")
                THIS.this_nTpEmiss     = TratarNulo(TpEmiss,    "N")
                THIS.this_cFPags       = TratarNulo(FPags,      "C")
                THIS.this_cParcelas    = TratarNulo(Parcelas,   "C")
                THIS.this_cValPends    = TratarNulo(ValPends,   "C")
                THIS.this_cValPend2s   = TratarNulo(ValPend2s,  "C")
                THIS.this_cBxPends     = TratarNulo(BxPends,    "C")
                THIS.this_cVVectos     = TratarNulo(VVectos,    "C")
                THIS.this_cFazContas   = TratarNulo(FazContas,  "C")
                THIS.this_cSituas      = TratarNulo(Situas,     "C")
                THIS.this_cObs         = TratarNulo(Obs,        "C")
                THIS.this_cEmiCarts    = TratarNulo(EmiCarts,   "C")
                THIS.this_cEmiProts    = TratarNulo(EmiProts,   "C")
                THIS.this_cAlineas     = TratarNulo(Alineas,    "C")
                THIS.this_nTpLeituras  = TratarNulo(TpLeituras, "N")
                THIS.this_nLeProts     = TratarNulo(LeProts,    "N")
                THIS.this_nGeranarqs   = TratarNulo(Geranarqs,  "N")
                THIS.this_cGerCnabs    = TratarNulo(GerCnabs,   "C")
                THIS.this_cValidaChqs  = TratarNulo(ValidaChqs, "C")
                THIS.this_nNdtEmiss    = TratarNulo(NdtEmiss,   "N")
                THIS.this_nDescontos   = TratarNulo(Descontos,  "N")
                THIS.this_nComiss      = TratarNulo(Comiss,     "N")
                THIS.this_nIndProds    = TratarNulo(IndProds,   "N")
                THIS.this_nPeFins      = TratarNulo(PeFins,     "N")
                THIS.this_nAnaSits     = TratarNulo(AnaSits,    "N")
                THIS.this_nCartDbs     = TratarNulo(CartDbs,    "N")
                THIS.this_nProrrogas   = TratarNulo(Prorrogas,  "N")
                THIS.this_cLimpCarts   = TratarNulo(LimpCarts,  "C")
                THIS.this_cConsolidas  = TratarNulo(Consolidas, "C")
                THIS.this_nAltDados    = TratarNulo(AltDados,   "N")
                THIS.this_cCongvs      = TratarNulo(Congvs,     "C")
                THIS.this_nVencUtil    = TratarNulo(VencUtil,   "N")
                THIS.this_cMoedas      = TratarNulo(Moedas,     "C")
                THIS.this_nInativas    = TratarNulo(Inativas,   "N")
                THIS.this_nChkJuros    = TratarNulo(ChkJuros,   "N")
                THIS.this_nPerJuros    = TratarNulo(PerJuros,   "N")
                THIS.this_nChkSmtJuro  = TratarNulo(ChkSmtJuro, "N")
                THIS.this_nImpChDev    = TratarNulo(ImpChDev,   "N")
                THIS.this_nLancCobr    = TratarNulo(LancCobr,   "N")
                THIS.this_nAltConfSit  = TratarNulo(AltConfSit, "N")
                THIS.this_cAltSituas   = TratarNulo(AltSituas,  "C")
                THIS.this_nChkPortChq  = TratarNulo(ChkPortChq, "N")
                IF VARTYPE(FixGOrigs) = "L"
                    THIS.this_lFixGOrigs = FixGOrigs
                ELSE
                    THIS.this_lFixGOrigs = (NVL(FixGOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixCOrigs) = "L"
                    THIS.this_lFixCOrigs = FixCOrigs
                ELSE
                    THIS.this_lFixCOrigs = (NVL(FixCOrigs, 0) = 1)
                ENDIF
                IF VARTYPE(FixGDests) = "L"
                    THIS.this_lFixGDests = FixGDests
                ELSE
                    THIS.this_lFixGDests = (NVL(FixGDests, 0) = 1)
                ENDIF
                IF VARTYPE(FixCDests) = "L"
                    THIS.this_lFixCDests = FixCDests
                ELSE
                    THIS.this_lFixCDests = (NVL(FixCDests, 0) = 1)
                ENDIF
                IF VARTYPE(Flags) = "L"
                    THIS.this_lFlags = Flags
                ELSE
                    THIS.this_lFlags = (NVL(Flags, 0) = 1)
                ENDIF
                IF VARTYPE(LComis) = "L"
                    THIS.this_lLComis = LComis
                ELSE
                    THIS.this_lLComis = (NVL(LComis, 0) = 1)
                ENDIF
                IF TYPE("Cabs") != "U"
                    THIS.this_cCabs    = TratarNulo(Cabs, "C")
                ENDIF
                IF TYPE("Rods") != "U"
                    THIS.this_cRods    = TratarNulo(Rods, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cOperacaos))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescrs))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !INLIST(UPPER(ALLTRIM(THIS.this_cTipos)), "CR", "DB", "TR")
            MsgAviso("Tipo inv" + CHR(225) + "lido! Use CR, DB ou TR.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cOperacaos)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND ALLTRIM(THIS.this_cParcelas) = "S"
            IF UPPER(ALLTRIM(THIS.this_cTipos)) # "CR"
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o com Parcelas permite apenas CR.")
                loc_lValido = .F.
            ENDIF
            IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cOpEntradas))
                MsgAviso("Obrigat" + CHR(243) + "rio informar Opera" + CHR(231) + CHR(227) + "o de Entrada de Cheques.")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND INLIST(THIS.this_nComiss, 2, 3) AND THIS.this_nDescontos = 0
            MsgAviso("Percentual de Desconto/Recupera" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lido!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se operacaos ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOpt")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOpt")
                SELECT cursor_4c_ChkOpt
                loc_lExiste = (NVL(cursor_4c_ChkOpt.qtd, 0) > 0)
                USE IN cursor_4c_ChkOpt
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OptBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * Inserir - INSERT INTO SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOpt (" + ;
                "Operacaos, Descrs, Tipos, OpAnts, OpEntradas, Dopcs, Devolvidos," + ;
                " Ordens, OpAuts, TpDatas, DtContab, Destinos, Origems," + ;
                " GruDeps, ConDeps, GrupoOs, ContaOs, GrupoT, CCentrals," + ;
                " Hists, TpHists, HistClis, Respons, GruEmis, EmpInds, EmiInds," + ;
                " Cademis, TpEmiss, FPags, Parcelas," + ;
                " ValPends, ValPend2s, BxPends, VVectos, FazContas," + ;
                " Situas, Obs, EmiCarts, EmiProts, Alineas," + ;
                " TpLeituras, LeProts, Geranarqs, GerCnabs, ValidaChqs, NdtEmiss," + ;
                " Descontos, Comiss, IndProds, PeFins, AnaSits," + ;
                " CartDbs, Prorrogas, LimpCarts, Consolidas, AltDados," + ;
                " Congvs, VencUtil, Moedas, Inativas," + ;
                " ChkJuros, PerJuros, ChkSmtJuro, ImpChDev, LancCobr," + ;
                " AltConfSit, AltSituas, ChkPortChq," + ;
                " FixGOrigs, FixCOrigs, FixGDests, FixCDests, Flags, LComis," + ;
                " Cabs, Rods)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cOperacaos)) + "," + ;
                EscaparSQL(THIS.this_cDescrs)             + "," + ;
                EscaparSQL(THIS.this_cTipos)              + "," + ;
                EscaparSQL(THIS.this_cOpAnts)             + "," + ;
                EscaparSQL(THIS.this_cOpEntradas)         + "," + ;
                EscaparSQL(THIS.this_cDopcs)              + "," + ;
                EscaparSQL(THIS.this_cDevolvidos)         + "," + ;
                FormatarNumeroSQL(THIS.this_nOrdens, 0)   + "," + ;
                EscaparSQL(THIS.this_cOpAuts)             + "," + ;
                FormatarNumeroSQL(THIS.this_nTpDatas, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nDtContab, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDestinos, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nOrigems, 0)  + "," + ;
                EscaparSQL(THIS.this_cGruDeps)            + "," + ;
                EscaparSQL(THIS.this_cConDeps)            + "," + ;
                EscaparSQL(THIS.this_cGrupoOs)            + "," + ;
                EscaparSQL(THIS.this_cContaOs)            + "," + ;
                EscaparSQL(THIS.this_cGrupoT)             + "," + ;
                EscaparSQL(THIS.this_cCCentrals)          + "," + ;
                EscaparSQL(THIS.this_cHists)              + "," + ;
                FormatarNumeroSQL(THIS.this_nTpHists, 0)  + "," + ;
                EscaparSQL(THIS.this_cHistClis)           + "," + ;
                EscaparSQL(THIS.this_cRespons)            + "," + ;
                EscaparSQL(THIS.this_cGruEmis)            + "," + ;
                EscaparSQL(THIS.this_cEmpInds)            + "," + ;
                EscaparSQL(THIS.this_cEmiInds)            + "," + ;
                EscaparSQL(THIS.this_cCademis)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpEmiss, 0)  + "," + ;
                EscaparSQL(THIS.this_cFPags)              + "," + ;
                EscaparSQL(THIS.this_cParcelas)           + "," + ;
                EscaparSQL(THIS.this_cValPends)           + "," + ;
                EscaparSQL(THIS.this_cValPend2s)          + "," + ;
                EscaparSQL(THIS.this_cBxPends)            + "," + ;
                EscaparSQL(THIS.this_cVVectos)            + "," + ;
                EscaparSQL(THIS.this_cFazContas)          + "," + ;
                EscaparSQL(THIS.this_cSituas)             + "," + ;
                EscaparSQL(THIS.this_cObs)                + "," + ;
                EscaparSQL(THIS.this_cEmiCarts)           + "," + ;
                EscaparSQL(THIS.this_cEmiProts)           + "," + ;
                EscaparSQL(THIS.this_cAlineas)            + "," + ;
                FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLeProts, 0)    + "," + ;
                FormatarNumeroSQL(THIS.this_nGeranarqs, 0)  + "," + ;
                EscaparSQL(THIS.this_cGerCnabs)           + "," + ;
                EscaparSQL(THIS.this_cValidaChqs)         + "," + ;
                FormatarNumeroSQL(THIS.this_nNdtEmiss, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nComiss, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nIndProds, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nPeFins, 0)   + "," + ;
                FormatarNumeroSQL(THIS.this_nAnaSits, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nCartDbs, 0)  + "," + ;
                FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                EscaparSQL(THIS.this_cLimpCarts)          + "," + ;
                EscaparSQL(THIS.this_cConsolidas)         + "," + ;
                FormatarNumeroSQL(THIS.this_nAltDados, 0) + "," + ;
                EscaparSQL(THIS.this_cCongvs)             + "," + ;
                FormatarNumeroSQL(THIS.this_nVencUtil, 0) + "," + ;
                EscaparSQL(THIS.this_cMoedas)             + "," + ;
                FormatarNumeroSQL(THIS.this_nInativas, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkJuros, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nPerJuros, 2) + "," + ;
                FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpChDev, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nLancCobr, 0) + "," + ;
                FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                EscaparSQL(THIS.this_cAltSituas)          + "," + ;
                FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                EscaparSQL(THIS.this_cCabs)               + "," + ;
                EscaparSQL(THIS.this_cRods)               + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE SigCdOpt
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpt SET" + ;
                " Descrs      = " + EscaparSQL(THIS.this_cDescrs)              + "," + ;
                " Tipos       = " + EscaparSQL(THIS.this_cTipos)               + "," + ;
                " OpAnts      = " + EscaparSQL(THIS.this_cOpAnts)              + "," + ;
                " OpEntradas  = " + EscaparSQL(THIS.this_cOpEntradas)          + "," + ;
                " Dopcs       = " + EscaparSQL(THIS.this_cDopcs)               + "," + ;
                " Devolvidos  = " + EscaparSQL(THIS.this_cDevolvidos)          + "," + ;
                " Ordens      = " + FormatarNumeroSQL(THIS.this_nOrdens, 0)    + "," + ;
                " OpAuts      = " + EscaparSQL(THIS.this_cOpAuts)              + "," + ;
                " TpDatas     = " + FormatarNumeroSQL(THIS.this_nTpDatas, 0)   + "," + ;
                " DtContab    = " + FormatarNumeroSQL(THIS.this_nDtContab, 0)  + "," + ;
                " Destinos    = " + FormatarNumeroSQL(THIS.this_nDestinos, 0)  + "," + ;
                " Origems     = " + FormatarNumeroSQL(THIS.this_nOrigems, 0)   + "," + ;
                " GruDeps     = " + EscaparSQL(THIS.this_cGruDeps)             + "," + ;
                " ConDeps     = " + EscaparSQL(THIS.this_cConDeps)             + "," + ;
                " GrupoOs     = " + EscaparSQL(THIS.this_cGrupoOs)             + "," + ;
                " ContaOs     = " + EscaparSQL(THIS.this_cContaOs)             + "," + ;
                " GrupoT      = " + EscaparSQL(THIS.this_cGrupoT)              + "," + ;
                " CCentrals   = " + EscaparSQL(THIS.this_cCCentrals)           + "," + ;
                " Hists       = " + EscaparSQL(THIS.this_cHists)               + "," + ;
                " TpHists     = " + FormatarNumeroSQL(THIS.this_nTpHists, 0)   + "," + ;
                " HistClis    = " + EscaparSQL(THIS.this_cHistClis)            + "," + ;
                " Respons     = " + EscaparSQL(THIS.this_cRespons)             + "," + ;
                " GruEmis     = " + EscaparSQL(THIS.this_cGruEmis)             + "," + ;
                " EmpInds     = " + EscaparSQL(THIS.this_cEmpInds)             + "," + ;
                " EmiInds     = " + EscaparSQL(THIS.this_cEmiInds)             + "," + ;
                " Cademis     = " + EscaparSQL(THIS.this_cCademis)             + "," + ;
                " TpEmiss     = " + FormatarNumeroSQL(THIS.this_nTpEmiss, 0)   + "," + ;
                " FPags       = " + EscaparSQL(THIS.this_cFPags)               + "," + ;
                " Parcelas    = " + EscaparSQL(THIS.this_cParcelas)            + "," + ;
                " ValPends    = " + EscaparSQL(THIS.this_cValPends)            + "," + ;
                " ValPend2s   = " + EscaparSQL(THIS.this_cValPend2s)           + "," + ;
                " BxPends     = " + EscaparSQL(THIS.this_cBxPends)             + "," + ;
                " VVectos     = " + EscaparSQL(THIS.this_cVVectos)             + "," + ;
                " FazContas   = " + EscaparSQL(THIS.this_cFazContas)           + "," + ;
                " Situas      = " + EscaparSQL(THIS.this_cSituas)              + "," + ;
                " Obs         = " + EscaparSQL(THIS.this_cObs)                 + "," + ;
                " EmiCarts    = " + EscaparSQL(THIS.this_cEmiCarts)            + "," + ;
                " EmiProts    = " + EscaparSQL(THIS.this_cEmiProts)            + "," + ;
                " Alineas     = " + EscaparSQL(THIS.this_cAlineas)             + "," + ;
                " TpLeituras  = " + FormatarNumeroSQL(THIS.this_nTpLeituras, 0) + "," + ;
                " LeProts     = " + FormatarNumeroSQL(THIS.this_nLeProts, 0)   + "," + ;
                " Geranarqs   = " + FormatarNumeroSQL(THIS.this_nGeranarqs, 0) + "," + ;
                " GerCnabs    = " + EscaparSQL(THIS.this_cGerCnabs)            + "," + ;
                " ValidaChqs  = " + EscaparSQL(THIS.this_cValidaChqs)          + "," + ;
                " NdtEmiss    = " + FormatarNumeroSQL(THIS.this_nNdtEmiss, 0)  + "," + ;
                " Descontos   = " + FormatarNumeroSQL(THIS.this_nDescontos, 2) + "," + ;
                " Comiss      = " + FormatarNumeroSQL(THIS.this_nComiss, 0)    + "," + ;
                " IndProds    = " + FormatarNumeroSQL(THIS.this_nIndProds, 2)  + "," + ;
                " PeFins      = " + FormatarNumeroSQL(THIS.this_nPeFins, 0)    + "," + ;
                " AnaSits     = " + FormatarNumeroSQL(THIS.this_nAnaSits, 0)   + "," + ;
                " CartDbs     = " + FormatarNumeroSQL(THIS.this_nCartDbs, 0)   + "," + ;
                " Prorrogas   = " + FormatarNumeroSQL(THIS.this_nProrrogas, 0) + "," + ;
                " LimpCarts   = " + EscaparSQL(THIS.this_cLimpCarts)           + "," + ;
                " Consolidas  = " + EscaparSQL(THIS.this_cConsolidas)          + "," + ;
                " AltDados    = " + FormatarNumeroSQL(THIS.this_nAltDados, 0)  + "," + ;
                " Congvs      = " + EscaparSQL(THIS.this_cCongvs)              + "," + ;
                " VencUtil    = " + FormatarNumeroSQL(THIS.this_nVencUtil, 0)  + "," + ;
                " Moedas      = " + EscaparSQL(THIS.this_cMoedas)              + "," + ;
                " Inativas    = " + FormatarNumeroSQL(THIS.this_nInativas, 0)  + "," + ;
                " ChkJuros    = " + FormatarNumeroSQL(THIS.this_nChkJuros, 0)  + "," + ;
                " PerJuros    = " + FormatarNumeroSQL(THIS.this_nPerJuros, 2)  + "," + ;
                " ChkSmtJuro  = " + FormatarNumeroSQL(THIS.this_nChkSmtJuro, 0) + "," + ;
                " ImpChDev    = " + FormatarNumeroSQL(THIS.this_nImpChDev, 0)  + "," + ;
                " LancCobr    = " + FormatarNumeroSQL(THIS.this_nLancCobr, 0)  + "," + ;
                " AltConfSit  = " + FormatarNumeroSQL(THIS.this_nAltConfSit, 0) + "," + ;
                " AltSituas   = " + EscaparSQL(THIS.this_cAltSituas)           + "," + ;
                " ChkPortChq  = " + FormatarNumeroSQL(THIS.this_nChkPortChq, 0) + "," + ;
                " FixGOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGOrigs, 1, 0), 0) + "," + ;
                " FixCOrigs   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCOrigs, 1, 0), 0) + "," + ;
                " FixGDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixGDests, 1, 0), 0) + "," + ;
                " FixCDests   = " + FormatarNumeroSQL(IIF(THIS.this_lFixCDests, 1, 0), 0) + "," + ;
                " Flags       = " + FormatarNumeroSQL(IIF(THIS.this_lFlags,     1, 0), 0) + "," + ;
                " LComis      = " + FormatarNumeroSQL(IIF(THIS.this_lLComis,    1, 0), 0) + "," + ;
                " Cabs        = " + EscaparSQL(THIS.this_cCabs)                + "," + ;
                " Rods        = " + EscaparSQL(THIS.this_cRods)                + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE FROM SigCdOpt (verifica uso em lancamentos)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SIGCQDEV" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkUso")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkUso")
                SELECT cursor_4c_ChkUso
                loc_nUso = NVL(cursor_4c_ChkUso.qtd, 0)
                USE IN cursor_4c_ChkUso
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                loc_cSQL = "DELETE FROM SigCdOpt" + ;
                    " WHERE Operacaos = " + EscaparSQL(ALLTRIM(THIS.this_cOperacaos))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista movimentacoes de cheques para o grid
    * par_cFiltro: "" = todos | expressao SQL WHERE adicional
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Operacaos C(15), Tipos C(2), ;
                        OpAnts C(15), GrupoOs C(10), ContaOs C(10), ;
                        GruDeps C(10), ConDeps C(10), ValPends C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                    loc_cWhere = " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = "SELECT a.Operacaos, a.Tipos, a.OpAnts," + ;
                    " a.GrupoOs, a.ContaOs, a.GruDeps, a.ConDeps, a.ValPends" + ;
                    " FROM SigCdOpt a" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Operacaos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        IF RECCOUNT("cursor_4c_DadosTmp") > 0
                            APPEND FROM DBF("cursor_4c_DadosTmp")
                        ENDIF
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "OptBO.Buscar")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro completo por PK
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigCdOpt" + ;
                " WHERE Operacaos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "OptBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message + ;
                " (Linha: " + TRANSFORM(loException.LineNo) + ")", "OptBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescGrupoContab - Retorna descricao de grupo contabil (SigCdGcr)
    *==========================================================================
    PROCEDURE BuscarDescGrupoContab(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescGrpCtb")
            IF loc_nResult > 0 AND USED("cursor_4c_DescGrpCtb") AND RECCOUNT("cursor_4c_DescGrpCtb") > 0
                SELECT cursor_4c_DescGrpCtb
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescGrpCtb.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescGrupoContab")
        ENDTRY

        IF USED("cursor_4c_DescGrpCtb")
            USE IN cursor_4c_DescGrpCtb
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescContaContab - Retorna descricao de conta contabil
    *==========================================================================
    PROCEDURE BuscarDescContaContab(par_cGrupo, par_cConta)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(ALLTRIM(par_cConta)), ;
                "cursor_4c_DescCtaCli")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCtaCli") AND RECCOUNT("cursor_4c_DescCtaCli") > 0
                SELECT cursor_4c_DescCtaCli
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCtaCli.Rclis, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescContaContab")
        ENDTRY

        IF USED("cursor_4c_DescCtaCli")
            USE IN cursor_4c_DescCtaCli
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescCentral - Retorna descricao da central de credito (SIGCCCCO)
    *==========================================================================
    PROCEDURE BuscarDescCentral(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descs FROM SIGCCCCO WHERE Cods = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescCentral")
            IF loc_nResult > 0 AND USED("cursor_4c_DescCentral") AND RECCOUNT("cursor_4c_DescCentral") > 0
                SELECT cursor_4c_DescCentral
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescCentral.Descs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescCentral")
        ENDTRY

        IF USED("cursor_4c_DescCentral")
            USE IN cursor_4c_DescCentral
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescSituacao - Retorna descricao de situacao do cliente (SigCdCst)
    *==========================================================================
    PROCEDURE BuscarDescSituacao(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT Descrs FROM SigCdCst WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo)) + ;
                " AND Priors BETWEEN 1 AND 998", ;
                "cursor_4c_DescSit")
            IF loc_nResult > 0 AND USED("cursor_4c_DescSit") AND RECCOUNT("cursor_4c_DescSit") > 0
                SELECT cursor_4c_DescSit
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescSit.Descrs, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescSituacao")
        ENDTRY

        IF USED("cursor_4c_DescSit")
            USE IN cursor_4c_DescSit
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarDescMoeda - Retorna descricao de moeda (SigCdMoe)
    *==========================================================================
    PROCEDURE BuscarDescMoeda(par_cCodigo)
        LOCAL loc_cDesc, loc_nResult
        loc_cDesc = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(ALLTRIM(par_cCodigo)), ;
                "cursor_4c_DescMoe")
            IF loc_nResult > 0 AND USED("cursor_4c_DescMoe") AND RECCOUNT("cursor_4c_DescMoe") > 0
                SELECT cursor_4c_DescMoe
                loc_cDesc = ALLTRIM(NVL(cursor_4c_DescMoe.DMoes, ""))
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarDescMoeda")
        ENDTRY

        IF USED("cursor_4c_DescMoe")
            USE IN cursor_4c_DescMoe
        ENDIF

        RETURN loc_cDesc
    ENDPROC

    *==========================================================================
    * BuscarOpContas - Busca operacoes de titulo (SIGOPOPE) para lookup Mov.Titulos
    *==========================================================================
    PROCEDURE BuscarOpContas(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Dopes, Descrs FROM SIGOPOPE WHERE Congvs = 1" + ;
                " ORDER BY Dopes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpContas")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarOpContas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarCondicaoPagamento - Busca condicoes de pagamento (SigOpFp)
    *==========================================================================
    PROCEDURE BuscarCondicaoPagamento(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT FPags, Descrs FROM SigOpFp" + ;
                " WHERE Infos = 'C' AND EmiChqs <> 1" + ;
                " ORDER BY FPags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaFpg")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException.Message, "OptBO.BuscarCondicaoPagamento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

