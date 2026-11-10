# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: NUMLOTES, I, TITULOS, TIPOS, DATAS, CODS, CPFS, ICLIS

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
  DeleteMark = .F.
	Select crSigPrLii
	Select a.Emps, a.Datas, a.Contas, b.Bancos, b.Agencias, b.NContas, ;
	  From crSigPrLit a, crSigPrLii b, crSigOpIns c ;
	Select Emps, Datas, Contas, Bancos, Agencias, NContas, NCheques, Titulos, IClis, Borderos, ;
	  From crInstrucao ;
	Select crClientes
	Select Emps, Datas, Space(50) as Envio, Contas, Bancos, Agencias, NContas, NCheques, ;
	  From crClientes ;
	Select crEnvios
	Select Nvl(b.RazSocs, Space(50)) as Remetes, a.Envio, a.Datas, a.Mensas, a.Bancos, ;
	  From crEnvios a Left Join crSigCdEmp b On a.Emps = b.Cemps ;
	Select csImpressao
Select crSigPrLii
	.getUsuar.ControlSource 	  = 'crSigPrLit.Usuarios'
	.getLote.ControlSource 		  = 'crSigPrLit.NumLotes'
	.getData.ControlSource		  = 'crSigPrLit.Datas'
	.getInstrucao.ControlSource   = 'crSigPrLit.Cods'
	.getCdGrEstoque.ControlSource = 'crSigPrLit.Grupos'
	.getCdEstoque.ControlSource   = 'crSigPrLit.Contas'
	.Column1.ControlSource  = 'crSigPrLii.Bancos'
	.Column2.ControlSource  = 'crSigPrLii.Agencias'
	.Column3.ControlSource  = 'crSigPrLii.NContas'
	.Column4.ControlSource  = 'crSigPrLii.NCheques'
	.Column5.ControlSource  = 'crSigPrLii.DtVencs'
	.Column6.ControlSource  = 'crSigPrLii.PrVencs'
	.Column7.ControlSource  = 'crSigPrLii.Valors'
	.Column8.ControlSource  = 'crSigPrLii.Moedas'
	.Column9.ControlSource  = 'crSigPrLii.IClis'
	.Column10.ControlSource = 'crSigPrLii.Borderos'
	.getBanco.ControlSource   = 'crSigPrLii.Bancos'
	.getAgencia.ControlSource = 'crSigPrLii.Agencias'
	.getConta.ControlSource   = 'crSigPrLii.NContas'
	.getCheque.ControlSource  = 'crSigPrLii.NCheques'
	.getDtVencs.ControlSource = 'crSigPrLii.DtVencs'
	.getPrVencs.ControlSource = 'crSigPrLii.PrVencs'
	.getValor.ControlSource   = 'crSigPrLii.Valors'
	.getMoeda.ControlSource   = 'crSigPrLii.Moedas'
	.getBordero.ControlSource = 'crSigPrLii.Borderos'
	.getIClis.ControlSource   = 'crSigPrLii.IClis'
	.getCpf.ControlSource     = 'crSigPrLii.Cpfs'
	.getDConta.ControlSource  = 'crSigPrLii.RClis'
	.Column1.ControlSource  = 'crSigPrLii.Titulos'
	.Column2.ControlSource  = 'crSigPrLii.DtVencs'
	.Column3.ControlSource  = 'crSigPrLii.PrVencs'
	.Column4.ControlSource  = 'crSigPrLii.Valors'
	.Column5.ControlSource  = 'crSigPrLii.Moedas'
	.Column6.ControlSource  = 'crSigPrLii.IClis'
	.Column7.ControlSource  = 'crSigPrLii.Borderos'
	.getTitulo.ControlSource  = 'crSigPrLii.Titulos'
	.getDtVencs.ControlSource = 'crSigPrLii.DtVencs'
	.getPrVencs.ControlSource = 'crSigPrLii.PrVencs'
	.getValor.ControlSource   = 'crSigPrLii.Valors'
	.getMoeda.ControlSource   = 'crSigPrLii.Moedas'
	.getBordero.ControlSource = 'crSigPrLii.Borderos'
	.getIClis.ControlSource   = 'crSigPrLii.IClis'
	.getCpf.ControlSource     = 'crSigPrLii.Cpfs'
	.getDConta.ControlSource  = 'crSigPrLii.RClis'
Select crSigPrLit
Update crSigPrLit Set Datas = Ctod('') Where IsNull(Datas)
Update crSigPrLit Set Obs   = '' Where IsNull(Obs)
Select crSigPrLit
SELECT crSigPrLii
	Select Tipos ;
	  From crSigPrLii ;
	Select Bancos, Agencias, NContas, NCheques ;
	  From crSigPrLii ;
	Select Tipos ;
	  From crSigPrLii ;
	Select Titulos ;
	  From crSigPrLii ;
	Insert Into crSigPrLii (Tipos, NumLotes, Cods, cIdChaves) ;
	ThisForm.poDataMgr.SqlExecute('Select * From SigPrLit Where NumLotes = ?lnLot And Tipos = ?lnTip', 'crTmp')
		Select crTmp
			If Not Seek(lcChv, 'crProcurar', 'NumLotes')
			 	Insert Into crProcurar From MemVar
If Not ThisForm.poDataMgr.Update('crSigPrLit')
If Not ThisForm.poDataMgr.Update('crSigPrLii')
If (ThisForm.poDataMgr.SqlExecute('Delete From SigPrLit Where NumLotes = ?pLot And Tipos = ?pTip', '') < 1)
If (ThisForm.poDataMgr.SqlExecute('Delete From SigPrLii Where NumLotes = ?pLot And Tipos = ?pTip', '') < 1)
Delete From crProcurar Where NumLotes = pLot
If (ThisForm.poDataMgr.SqlExecute('Delete From SigPrLit Where NumLotes = ?pLot And Tipos = ?pTip', '') < 1)
If Not ThisForm.poDataMgr.Update('crSigPrLit')
If (ThisForm.poDataMgr.SqlExecute('Delete From SigPrLii Where NumLotes = ?pLot And Tipos = ?pTip', '') < 1)
If Not ThisForm.poDataMgr.Update('crSigPrLii')
Select crSigPrLit
	Select crProcurar
		If Not Seek(lcChv, 'crSigPrLit', 'NumLotes')
		 	Insert Into crSigPrLit From MemVar
Select crSigPrLit
lcQryLInst = [Select * From SigPrLit Where Datas BetWeen ?pDtI And ?pDtF And Tipos = ?pTip]
lcQryLInsI = [Select *, '] + Space(20) + [' as Cpfs, '] + Space(50) + [' as RClis ] + ;
			   [From SigPrLii Where NumLotes = ?pLot And Tipos = ?pTip]
lcQryParam = [Select * From SigCdPam]
lcQryInstr = [Select * From SigOpIns Where Tipos = ?pTip]
lcQryEmp   = [Select Cemps, Razas, RazSocs From SigCdEmp]
Select * From crSigPrLit Into Cursor crProcurar ReadWrite
Select crSigPrLit
Select crSigOpIns
Select crSigOpIns
Select crSigPrLit
	Select crSigPrLii
		Select crSigPrLit
	Insert Into crSigPrLii (Tipos, NumLotes, Cods, cIdChaves) ;
Select crSigPrLit
	Select crSigPrLii
			Delete In crSigPrLii
	Select crSigPrLii
		lcQuery = 'Select Iclis, Cpfs, Rclis, Grupos From SigCdCli Where Cpfs = ?pCgc Order By Iclis, Cpfs, Rclis, Grupos'
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		Select crSigCdCli
		lcQuery = 'Select * From SigPrLii Where Bancos + Agencias + NContas + NCheques = ?lcBus'
		lcQuery = 'Select * From SigPrLii Where IClis = ?lcBus'
	ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp')
		Select crTmp
			ThisForm.poDataMgr.SqlExecute('Select * From SigPrLit Where NumLotes = ?lcChv', 'crTmp2')
				If Not Seek(lcChv, 'crProcurar', 'NumLotes')
					Select crTmp2
				 	Insert Into crProcurar From MemVar
				If Not Seek(lcChv, 'crSigPrLit', 'NumLotes')
					Select crTmp2
				 	Insert Into crSigPrLit From MemVar
			Select crTmp
	=Seek(ThisForm.NumLotes, 'crSigPrLit', 'NumLotes')
	Select crSigPrLii
	lcQuery = 'Select * From SigPrLii Where Titulos = ?lcBus And NumLotes > ?lnLot'
	ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmp')
		Select crTmp
			If Not Seek(lcChv, 'crProcurar', 'NumLotes')
				Select crTmp
			 	Insert Into crProcurar From MemVar
			If Not Seek(lcChv, 'crSigPrLit', 'NumLotes')
				Select crTmp
			 	Insert Into crSigPrLit From MemVar
		=Seek(ThisForm.NumLotes, 'crSigPrLit', 'NumLotes')
	Select crSigPrLit
		lcQuery = 'Select Iclis, Cpfs, Rclis, Grupos From SigCdCli Where Cpfs = ?pCgc Order By Iclis, Cpfs, Rclis, Grupos'
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		Select crSigCdCli
	Delete In crSigPrLii
If Not Empty(This.Value) And Not Seek(This.Value, 'crSigOpIns', 'Cods')
		lcQuery = 'Select Iclis, Cpfs, Rclis, Grupos From SigCdCli Where Cpfs = ?pCgc Order By Iclis, Cpfs, Rclis, Grupos'
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		Select crSigCdCli
	Delete In crSigPrLii

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigoplin.prg) - TRECHOS RELEVANTES PARA PASS SQL (1512 linhas total):

*-- Linhas 384 a 402:
384:             .HighlightBackColor = RGB(255, 255, 255)
385:             .HighlightForeColor = RGB(15, 41, 104)
386:             .HighlightStyle     = 2
387:             .DeleteMark         = .F.
388:             .RecordMark         = .F.
389:             .RowHeight          = 16
390:             .ScrollBars         = 2
391:             .GridLines          = 3
392:             .ReadOnly           = .T.
393:             .Visible            = .T.
394:         ENDWITH
395: 
396:         *-- ColumnCount FORA do WITH para criar colunas imediatamente (Problema 36)
397:         loc_oPagina.grd_4c_Lista.ColumnCount = 8
398: 
399:         WITH loc_oPagina.grd_4c_Lista
400:             .Column1.Header1.Caption = "Tipo"
401:             .Column1.Width           = 60
402:             .Column1.Alignment       = 2

*-- Linhas 964 a 982:
964:             RETURN .F.
965:         ENDIF
966: 
967:         SELECT cursor_4c_Dados
968:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
969: 
970:         TRY
971:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
972:                 THIS.BOParaForm()
973:                 THIS.this_cModoAtual = "VISUALIZAR"
974:                 THIS.HabilitarCampos(.F.)
975:                 THIS.AjustarBotoesPorModo()
976:                 THIS.AlternarPagina(2)
977:                 loc_lResultado = .T.
978:             ENDIF
979:         CATCH TO loc_oErro
980:             MsgErro(loc_oErro.Message, "Formsigoplin.BtnVisualizarClick")
981:         ENDTRY
982: 

*-- Linhas 995 a 1013:
995:             RETURN .F.
996:         ENDIF
997: 
998:         SELECT cursor_4c_Dados
999:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1000: 
1001:         TRY
1002:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1003:                 THIS.this_oBusinessObject.EditarRegistro()
1004:                 THIS.BOParaForm()
1005:                 THIS.this_cModoAtual = "ALTERAR"
1006:                 THIS.HabilitarCampos(.T.)
1007:                 THIS.AjustarBotoesPorModo()
1008:                 THIS.AlternarPagina(2)
1009:                 loc_lResultado = .T.
1010:             ENDIF
1011:         CATCH TO loc_oErro
1012:             MsgErro(loc_oErro.Message, "Formsigoplin.BtnAlterarClick")
1013:         ENDTRY

*-- Linhas 1028 a 1046:
1028:             RETURN .F.
1029:         ENDIF
1030: 
1031:         SELECT cursor_4c_Dados
1032:         loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1033:         loc_nNumlotes  = cursor_4c_Dados.numlotes
1034: 
1035:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1036:             RETURN .F.
1037:         ENDIF
1038: 
1039:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do lote " + TRANSFORM(loc_nNumlotes) + "?", "Excluir")
1040:             RETURN .F.
1041:         ENDIF
1042: 
1043:         TRY
1044:             IF THIS.this_oBusinessObject.Excluir()
1045:                 MsgInfo("Lote de instru" + CHR(231) + CHR(245) + "es exclu" + CHR(237) + "do com sucesso!")
1046:                 THIS.CarregarLista()

*-- Linhas 1075 a 1128:
1075:                 loc_oBusca.Show()
1076: 
1077:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLote")
1078:                     SELECT cursor_4c_BuscaLote
1079:                     loc_cCidchaves = ALLTRIM(cursor_4c_BuscaLote.cidchaves)
1080:                 ENDIF
1081: 
1082:                 loc_oBusca.Release()
1083:             ENDIF
1084: 
1085:             IF USED("cursor_4c_BuscaLote")
1086:                 USE IN cursor_4c_BuscaLote
1087:             ENDIF
1088: 
1089:             IF !EMPTY(loc_cCidchaves) AND USED("cursor_4c_Dados")
1090:                 SELECT cursor_4c_Dados
1091:                 LOCATE FOR ALLTRIM(cidchaves) == loc_cCidchaves
1092:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1093:             ENDIF
1094: 
1095:         CATCH TO loException
1096:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "Formsigoplin.BtnBuscarClick")
1097:             IF USED("cursor_4c_BuscaLote")
1098:                 USE IN cursor_4c_BuscaLote
1099:             ENDIF
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *===========================================================================
1104:     * BtnEncerrarClick - Fecha o formulario
1105:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
1106:     *===========================================================================
1107:     PROCEDURE BtnEncerrarClick()
1108:         THIS.Release()
1109:     ENDPROC
1110: 
1111:     *===========================================================================
1112:     * BtnSalvarClick - Confirma e grava o lote atual (INCLUIR/ALTERAR).
1113:     * FormParaBO() + Salvar(): BusinessBase.Salvar() decide INSERT/UPDATE
1114:     * via this_lNovoRegistro e ja chama ExibirFalha() em qualquer caminho de
1115:     * falha - NAO precisa de ELSE aqui (memoria SalvarsemELSE).
1116:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17).
1117:     *===========================================================================
1118:     PROCEDURE BtnSalvarClick()
1119:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1120:             RETURN
1121:         ENDIF
1122: 
1123:         THIS.FormParaBO()
1124: 
1125:         IF THIS.this_oBusinessObject.Salvar()
1126:             MsgInfo("Lote de instru" + CHR(231) + CHR(245) + "es salvo com sucesso!")
1127:             THIS.AlternarPagina(1)
1128:         ENDIF

*-- Linhas 1275 a 1293:
1275:             IF !EMPTY(loc_cConta)
1276:                 loc_cFiltro = ""
1277:                 IF !EMPTY(loc_cGrupo)
1278:                     loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
1279:                 ENDIF
1280: 
1281:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1282:                     "SigCdCli", "cursor_4c_BuscaCtEstoque", "Iclis", loc_cConta, ;
1283:                     "Contas de Estoque", .F., .F., loc_cFiltro)
1284: 
1285:                 IF VARTYPE(loc_oBusca) = "O"
1286:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1287:                         IF USED("cursor_4c_BuscaCtEstoque")
1288:                             loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
1289:                             loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
1290:                         ENDIF
1291:                     ELSE
1292:                         IF !loc_oBusca.this_lAchouRegistro
1293:                             loc_oBusca.mAddColuna("Iclis", "", "Conta")

*-- Linhas 1336 a 1354:
1336:             IF !EMPTY(loc_cDesc)
1337:                 loc_cFiltro = ""
1338:                 IF !EMPTY(loc_cGrupo)
1339:                     loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
1340:                 ENDIF
1341: 
1342:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1343:                     "SigCdCli", "cursor_4c_BuscaCtEstoque", "Rclis", loc_cDesc, ;
1344:                     "Contas de Estoque", .F., .F., loc_cFiltro)
1345: 
1346:                 IF VARTYPE(loc_oBusca) = "O"
1347:                     IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1348:                         IF USED("cursor_4c_BuscaCtEstoque")
1349:                             loc_oPg2.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Rclis)
1350:                             loc_oPg2.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_BuscaCtEstoque.Iclis)
1351:                         ENDIF
1352:                     ELSE
1353:                         IF !loc_oBusca.this_lAchouRegistro
1354:                             loc_oBusca.mAddColuna("Rclis", "", "Nome")

*-- Linhas 1451 a 1476:
1451:             IF THIS.this_oBusinessObject.Buscar("")
1452:                 loc_oGrid.ColumnCount = 8
1453:                 loc_oGrid.RecordSource          = "cursor_4c_Dados"
1454:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.tipos"
1455:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.numlotes"
1456:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cods"
1457:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
1458:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.grupos"
1459:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.contas"
1460:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Dados.valors"
1461:                 loc_oGrid.Column8.ControlSource = "cursor_4c_Dados.moedas"
1462: 
1463:                 *-- Reconfigurar headers e larguras APOS RecordSource (reseta captions/Width)
1464:                 loc_oGrid.Column1.Header1.Caption = "Tipo"
1465:                 loc_oGrid.Column2.Header1.Caption = "Lote"
1466:                 loc_oGrid.Column3.Header1.Caption = "Instru" + CHR(231) + CHR(227) + "o"
1467:                 loc_oGrid.Column4.Header1.Caption = "Data"
1468:                 loc_oGrid.Column5.Header1.Caption = "Grupo"
1469:                 loc_oGrid.Column6.Header1.Caption = "Conta"
1470:                 loc_oGrid.Column7.Header1.Caption = "Valor"
1471:                 loc_oGrid.Column8.Header1.Caption = "Moeda"
1472: 
1473:                 loc_oGrid.Column1.Width = 60
1474:                 loc_oGrid.Column2.Width = 90
1475:                 loc_oGrid.Column3.Width = 90
1476:                 loc_oGrid.Column4.Width = 90


### BO (C:\4c\projeto\app\classes\sigoplinBO.prg):
*====================================================================
* sigoplinBO.prg
*
* Business Object para Lote de Instrucoes (Cheques/Titulos)
* Tabela principal : SigPrLit  (PK: cidchaves char(20))
* Tabela detalhe   : SigPrLii  (PK: cidchaves char(20), FK logica: tipos+numlotes)
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*====================================================================

DEFINE CLASS sigoplinBO AS BusinessBase

    *-- Propriedades da entidade (SigPrLit)
    *-- PK
    this_cCidchaves = ""    && cidchaves char(20) - PK (chave unica)
    *-- Identificacao do lote
    this_nTipos     = 0     && tipos numeric(1,0)    - 1=Cheques, 2=Titulos
    this_nNumlotes  = 0     && numlotes numeric(8,0) - numero do lote
    this_cCods      = ""    && cods char(10)         - codigo da instrucao (FK SigOpIns.Cods)
    this_dDatas     = {}    && datas datetime NULL   - data da instrucao
    this_cEmps      = ""    && emps char(3)          - empresa
    this_cGrupos    = ""    && grupos char(10)       - grupo de estoque/contabil (SigCdGcr)
    this_cContas    = ""    && contas char(10)       - conta de estoque/contabil (SigCdCli)
    this_nValors    = 0     && valors numeric(11,2)  - valor total do lote
    this_cMoedas    = ""    && moedas char(3)        - moeda (SigCdMoe.CMoes)
    this_cObs       = ""    && obs text NULL         - observacao
    this_cUsuarios  = ""    && usuarios char(10)     - usuario que gerou o lote

    *-- Propriedades de exibicao - nao armazenadas no banco
    this_cDGrupos   = ""    && descricao do grupo de estoque (exibicao)
    this_cDContas   = ""    && descricao da conta de estoque (exibicao)
    this_cDMoedas   = ""    && descricao da moeda (exibicao)
    this_nQtdeItens = 0     && quantidade de itens do detalhe (calculada)

    *-- Alias do cursor de detalhe (SigPrLii)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *====================================================================
    * Init - Inicializa Business Object configurando tabela e chave primaria
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrLit"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades para um novo registro.
    * Chamado por NovoRegistro() (BusinessBase) antes de
    * InicializarValoresPadrao() - sem este override, um registro
    * carregado anteriormente (Alterar/Visualizar) deixaria lixo nas
    * properties ao clicar Incluir em seguida.
    *====================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidchaves = ""
        THIS.this_nTipos     = 0
        THIS.this_nNumlotes  = 0
        THIS.this_cCods      = ""
        THIS.this_dDatas     = {}
        THIS.this_cEmps      = ""
        THIS.this_cGrupos    = ""
        THIS.this_cContas    = ""
        THIS.this_nValors    = 0
        THIS.this_cMoedas    = ""
        THIS.this_cObs       = ""
        THIS.this_cUsuarios  = ""

        THIS.this_cDGrupos   = ""
        THIS.this_cDContas   = ""
        THIS.this_cDMoedas   = ""
        THIS.this_nQtdeItens = 0
    ENDPROC

    *====================================================================
    * ValidarDados - Transcricao da unica validacao do mestre feita no
    * Salva.Click legado (SIGOPLIN.Pagina.Dados.Grupo_Salva.Salva.Click):
    * "If Empty(ThisForm.Pagina.Dados.getInstrucao.Value) -> 'Instrucao
    * Invalida!!!'". As validacoes de linha do detalhe (cheque/titulo com
    * dados incompletos) pertencem ao Grid/Form (Fase 4+), nao ao mestre.
    *====================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCods))
            MsgAviso("Instru" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * Mapeia TODAS as colunas de SigPrLit. REGRA CRITICA: SELECT
    * (par_cAliasCursor) ANTES de acessar campos (sem alias).
    * TratarNulo recebe o VALOR PADRAO real do tipo da coluna - NUNCA o
    * codigo de tipo "C"/"N"/"D" (regra CLAUDE.md / feedback
    * tratarnulo_2o_arg_eh_valor_padrao).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nTipos    = TratarNulo(tipos,     0)
                THIS.this_nNumlotes = TratarNulo(numlotes,  0)
                THIS.this_cCods     = TratarNulo(cods,      "")
                THIS.this_dDatas    = TratarNulo(datas,     {})
                THIS.this_cEmps     = TratarNulo(emps,      "")
                THIS.this_cGrupos   = TratarNulo(grupos,    "")
                THIS.this_cContas   = TratarNulo(contas,    "")
                THIS.this_nValors   = TratarNulo(valors,    0)
                THIS.this_cMoedas   = TratarNulo(moedas,    "")
                THIS.this_cObs      = TratarNulo(obs,       "")
                THIS.this_cUsuarios = TratarNulo(usuarios,  "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo lote de instrucoes na tabela SigPrLit.
    *
    * Transcricao do Case 'INSERIR' do PROCEDURE ChamarMLeDados legado
    * (Replace Tipos, NumLotes, Emps, Usuarios, Datas, Valors, Moedas,
    * cIdChaves In crSigPrLit): cidchaves (PK Fortyus) e numlotes
    * (sequencia por tipo: 'LOTEINSTCHQ'/'LOTEINSTTIT') sao gerados aqui
    * quando ainda nao foram atribuidos, igual ao legado
    * (fUniqueIds()/fGerUniqueKey('LOTEINST' + Iif(Tipos=1,'CHQ','TIT'))).
    * Emps usa go_4c_Sistema.cCodEmpresa - NUNCA a global legado _Empr
    * (CLAUDE.md: _EMPR NUNCA usar). Usuarios usa gc_4c_UsuarioLogado no
    * lugar da memvar Usuar do legado.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            IF THIS.this_nNumlotes = 0
                THIS.this_nNumlotes = fGerUniqueKey("LOTEINST" + IIF(THIS.this_nTipos = 1, "CHQ", "TIT"))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cEmps))
                THIS.this_cEmps = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", go_4c_Sistema.cCodEmpresa, "")
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cUsuarios))
                THIS.this_cUsuarios = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrLit (tipos, numlotes, cods, datas, emps, grupos, contas, valors, moedas, obs, usuarios, cidchaves)
                VALUES (
                    <<FormatarNumeroSQL(THIS.this_nTipos, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nNumlotes, 0)>>,
                    <<EscaparSQL(THIS.this_cCods)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cObs)>>,
                    <<EscaparSQL(THIS.this_cUsuarios)>>,
                    <<EscaparSQL(THIS.this_cCidchaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza lote de instrucoes existente na tabela
    * SigPrLit. Tipos/Numlotes/Emps/Usuarios/Cidchaves sao identidade do
    * registro e NAO sao regravados no Alterar (o legado tambem so os
    * atribui no Case 'INSERIR').
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrLit
                SET cods   = <<EscaparSQL(THIS.this_cCods)>>,
                    datas  = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    grupos = <<EscaparSQL(THIS.this_cGrupos)>>,
                    contas = <<EscaparSQL(THIS.this_cContas)>>,
                    valors = <<FormatarNumeroSQL(THIS.this_nValors, 2)>>,
                    moedas = <<EscaparSQL(THIS.this_cMoedas)>>,
                    obs    = <<EscaparSQL(THIS.this_cObs)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidchaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o lote de instrucoes e seus itens.
    * O legado exclui por NumLotes+Tipos (Delete From SigPrLit Where
    * NumLotes = ?pLot And Tipos = ?pTip) depois de limpar crSigPrLii do
    * mesmo lote; aqui o mestre e excluido pela PK real (cidchaves) e o
    * detalhe (SigPrLii) e excluido primeiro, pela chave de negocio
    * Tipos+NumLotes que os dois compartilham (SigPrLii nao tem FK para
    * SigPrLit.cidchaves no schema).
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrLii" + ;
                " WHERE tipos = " + FormatarNumeroSQL(THIS.this_nTipos, 0) + ;
                " AND numlotes = " + FormatarNumeroSQL(THIS.this_nNumlotes, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_cSQL = "DELETE FROM SigPrLit WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MostrarErro("Erro ao excluir itens do lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca lotes de instrucoes com filtro opcional (ex.:
    * "tipos = 1" para a aba Cheques, ou faixa de datas da Pagina.Lista
    * legada). Retorna cursor_4c_Dados com as colunas usadas na grade.
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (tipos N(1,0), numlotes N(8,0), cods C(10), ;
                        datas T, grupos C(10), contas C(10), valors N(11,2), moedas C(3), cidchaves C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT tipos, numlotes, cods, datas, grupos, contas, valors, moedas, cidchaves" + ;
                    " FROM SigPrLit"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY numlotes DESC"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar lotes de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega o lote pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT tipos, numlotes, cods, datas, emps, grupos, contas, valors, moedas, obs, usuarios, cidchaves" + ;
                " FROM SigPrLit WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Lote de instru" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar lote de instru" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "sigoplinBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * DECISAO DE PROJETO (Fase 2 - CRUD):
    * O detalhe (SigPrLii: itens de cheque/titulo do lote, ligados por
    * Tipos+NumLotes) nao tem CRUD proprio nesta fase - carga/gravacao do
    * grid (cntGradeCheques/cntGradeTitulos) e responsabilidade das fases
    * de Form/Grid (3-8), que populam this_cCursorDetalhe diretamente via
    * SQLEXEC, igual ao padrao de outras telas mestre-detalhe do projeto.
    * ExecutarExclusao() acima ja remove os itens do detalhe ao excluir o
    * lote inteiro.
    *====================================================================

ENDDEFINE

