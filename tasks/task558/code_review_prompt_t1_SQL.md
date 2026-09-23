# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKIDCHAVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: RCLIS, GRUPOS, ICLIS, DATAS, ICL

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
  ControlSource = "crSigCdVis.vendas"
  ControlSource = "crSigCdVis.pedidos"
  ControlSource = "crSigCdVis.obss"
  ControlSource = "crSigCdVis.contas"
  ControlSource = "crSigCdVis.grupos"
  ControlSource = "crSigCdVis.iclis"
  ControlSource = "crSigCdVis.datas"
	Select crSigCdVis
	lcQryPar = [Select GrPadVens From SigCdPam]	
	If (.poDataMgr.SqlExecute(lcQryPar, 'crSigCdPam') < 1)
			lcQryCta = [Select iclis,rclis From SigCdCli ] + ;
			If (.poDataMgr.SqlExecute(lcQryCta, 'crSigCdCli') < 1)
	lcQryVis = [Select a.*, b.rclis as descri, c.rclis as repr, ] + ;
	      [From SigCdVis a ] + ;
	      [Inner Join SigCdCli b on a.iclis=b.iclis ] + ;
	      [Inner Join SigCdCli c on a.Contas=c.iclis ] + ;	      
		Select crSigCdVis
	Select crSigCdVis
		Select crTmp	
				If not Seek(lcChv, [crSigCdVis], [pkIdChave])
				 	Insert Into crSigCdVis From MemVar
lcQuery = [Select a.*, b.rclis as descri, c.rclis as repr, ] + ;
	      [From SigCdVis a ] + ;
	      [Inner Join SigCdCli b on a.iclis=b.iclis ] + ;
	      [Inner Join SigCdCli c on a.Contas=c.iclis ] + ;	      
ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
Select crtmp
	lcQuery = [Select rclis From SigCdCli ] + ;
	If (thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
	lcQuery = [Select rclis From SigCdCli ] + ;
	If (thisform.poDataMgr.SqlExecute(lcQuery, 'crSigCdCll') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormVis.prg) - TRECHOS RELEVANTES PARA PASS SQL (1533 linhas total):

*-- Linhas 351 a 369:
351:             .HighlightBackColor = RGB(255, 255, 255)
352:             .HighlightForeColor = RGB(15, 41, 104)
353:             .HighlightStyle     = 2
354:             .DeleteMark         = .F.
355:             .RecordMark         = .F.
356:             .RowHeight          = 16
357:             .ScrollBars         = 2
358:             .GridLines          = 3
359:             .Visible            = .T.
360:         ENDWITH
361: 
362:         THIS.TornarControlesVisiveis(loc_oPagina)
363:     ENDPROC
364: 
365:     *===========================================================================
366:     * ConfigurarPaginaDados - Estrutura base de Page2 (Dados)
367:     * Cabecalho + container de botoes de acao vazio (campos/lookups nas proximas fases)
368:     *===========================================================================
369:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 826 a 854:
826:             ELSE
827:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
828: 
829:                 *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH - Problema 36)
830:                 loc_oGrid.ColumnCount = 6
831:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
832: 
833:                 *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
834:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Datas"
835:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Repr"
836:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Iclis"
837:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Descri"
838:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.DescVendas"
839:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.DescPedidos"
840: 
841:                 loc_oGrid.Column1.Width = 80
842:                 loc_oGrid.Column2.Width = 150
843:                 loc_oGrid.Column3.Width = 80
844:                 loc_oGrid.Column4.Width = 150
845:                 loc_oGrid.Column5.Width = 31
846:                 loc_oGrid.Column6.Width = 31
847: 
848:                 *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
849:                 loc_oGrid.Column1.Header1.Caption = "Data"
850:                 loc_oGrid.Column2.Header1.Caption = "Representante"
851:                 loc_oGrid.Column3.Header1.Caption = "Conta"
852:                 loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
853:                 loc_oGrid.Column5.Header1.Caption = "Venda"
854:                 loc_oGrid.Column6.Header1.Caption = "Pedido"

*-- Linhas 926 a 944:
926:         loc_cCodigo = ""
927: 
928:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
929:             SELECT cursor_4c_Dados
930:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
931:         ENDIF
932: 
933:         IF EMPTY(loc_cCodigo)
934:             MsgAviso("Selecione um registro para visualizar.")
935:         ELSE
936:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
937:                 THIS.this_cModoAtual = "VISUALIZAR"
938:                 THIS.BOParaForm()
939:                 THIS.HabilitarCampos(.F.)
940:                 THIS.AjustarBotoesPorModo()
941:                 THIS.AlternarPagina(2)
942:             ENDIF
943:         ENDIF
944:     ENDPROC

*-- Linhas 952 a 970:
952:         loc_cCodigo = ""
953: 
954:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
955:             SELECT cursor_4c_Dados
956:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
957:         ENDIF
958: 
959:         IF EMPTY(loc_cCodigo)
960:             MsgAviso("Selecione um registro para alterar.")
961:         ELSE
962:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
963:                 THIS.this_oBusinessObject.EditarRegistro()
964:                 THIS.this_cModoAtual = "ALTERAR"
965:                 THIS.BOParaForm()
966:                 THIS.HabilitarCampos(.T.)
967:                 THIS.AjustarBotoesPorModo()
968:                 THIS.AlternarPagina(2)
969:             ENDIF
970:         ENDIF

*-- Linhas 979 a 997:
979:         loc_cCodigo = ""
980: 
981:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
982:             SELECT cursor_4c_Dados
983:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.pkidchave)
984:         ENDIF
985: 
986:         IF EMPTY(loc_cCodigo)
987:             MsgAviso("Selecione um registro para excluir.")
988:         ELSE
989:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
990:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da visita selecionada?", ;
991:                     "Confirmar Exclus" + CHR(227) + "o")
992:                     IF THIS.this_oBusinessObject.Excluir()
993:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
994:                         THIS.CarregarLista()
995:                     ENDIF
996:                 ENDIF
997:             ENDIF

*-- Linhas 1018 a 1048:
1018:                 loc_oBusca.Show()
1019: 
1020:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaVis")
1021:                     SELECT cursor_4c_BuscaVis
1022:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaVis.pkidchave)
1023:                 ENDIF
1024: 
1025:                 loc_oBusca.Release()
1026:             ENDIF
1027: 
1028:             IF USED("cursor_4c_BuscaVis")
1029:                 USE IN cursor_4c_BuscaVis
1030:             ENDIF
1031: 
1032:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
1033:                 SELECT cursor_4c_Dados
1034:                 LOCATE FOR ALLTRIM(pkidchave) == loc_cCodigo
1035:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1036:             ENDIF
1037: 
1038:         CATCH TO loException
1039:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormVis.BtnBuscarClick")
1040:             IF USED("cursor_4c_BuscaVis")
1041:                 USE IN cursor_4c_BuscaVis
1042:             ENDIF
1043:         ENDTRY
1044:     ENDPROC
1045: 
1046:     *===========================================================================
1047:     * BtnEncerrarClick - Fecha o formulario
1048:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)

*-- Linhas 1088 a 1162:
1088:             loc_oPagina.edt_4c_Obs.Value     = .this_cObservacao
1089:         ENDWITH
1090: 
1091:         *-- Descricoes (Nome do Representante/Conta) nao vem do BO (SELECT so em SigCdVis)
1092:         *-- Recarrega via lookup exato pelo codigo, espelhando SIGCDVIS.Pagina.Lista.Grupo_Op.Click
1093:         THIS.AtualizarDescricaoRepresentante()
1094:         THIS.AtualizarDescricaoConta()
1095:     ENDPROC
1096: 
1097:     *===========================================================================
1098:     * AtualizarDescricaoRepresentante - Busca o nome (rclis) do Representante
1099:     * atual (txt_4c_CodCli) em SigCdCli, espelhando o SELECT feito pelo legado
1100:     * em Grupo_Op.Click nos modos ALTERAR/VISUALIZAR/EXCLUIR
1101:     *===========================================================================
1102:     PROTECTED PROCEDURE AtualizarDescricaoRepresentante()
1103:         LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResultado
1104:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1105:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1106: 
1107:         IF EMPTY(loc_cCodigo)
1108:             loc_oPagina.txt_4c_DesCli.Value = ""
1109:             RETURN
1110:         ENDIF
1111: 
1112:         TRY
1113:             loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
1114:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescRepr")
1115: 
1116:             IF loc_nResultado >= 0 AND USED("cursor_4c_DescRepr") AND !EOF("cursor_4c_DescRepr")
1117:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(TratarNulo(cursor_4c_DescRepr.rclis, "C"))
1118:             ELSE
1119:                 loc_oPagina.txt_4c_DesCli.Value = ""
1120:             ENDIF
1121: 
1122:             IF USED("cursor_4c_DescRepr")
1123:                 USE IN cursor_4c_DescRepr
1124:             ENDIF
1125:         CATCH TO loException
1126:             MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do representante:" + CHR(13) + ;
1127:                 loException.Message, "FormVis.AtualizarDescricaoRepresentante")
1128:         ENDTRY
1129:     ENDPROC
1130: 
1131:     *===========================================================================
1132:     * AtualizarDescricaoConta - Busca o nome (rclis) da Conta atual (txt_4c_CodCta)
1133:     * em SigCdCli, espelhando o SELECT feito pelo legado em Grupo_Op.Click
1134:     *===========================================================================
1135:     PROTECTED PROCEDURE AtualizarDescricaoConta()
1136:         LOCAL loc_oPagina, loc_cCodigo, loc_cSQL, loc_nResultado
1137:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1138:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodCta.Value)
1139: 
1140:         IF EMPTY(loc_cCodigo)
1141:             loc_oPagina.txt_4c_DesCta.Value = ""
1142:             RETURN
1143:         ENDIF
1144: 
1145:         TRY
1146:             loc_cSQL = "SELECT rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cCodigo)
1147:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescConta")
1148: 
1149:             IF loc_nResultado >= 0 AND USED("cursor_4c_DescConta") AND !EOF("cursor_4c_DescConta")
1150:                 loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(TratarNulo(cursor_4c_DescConta.rclis, "C"))
1151:             ELSE
1152:                 loc_oPagina.txt_4c_DesCta.Value = ""
1153:             ENDIF
1154: 
1155:             IF USED("cursor_4c_DescConta")
1156:                 USE IN cursor_4c_DescConta
1157:             ENDIF
1158:         CATCH TO loException
1159:             MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o da conta:" + CHR(13) + ;
1160:                 loException.Message, "FormVis.AtualizarDescricaoConta")
1161:         ENDTRY
1162:     ENDPROC

*-- Linhas 1221 a 1255:
1221:         ENDIF
1222: 
1223:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1224:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1225:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1226: 
1227:         TRY
1228:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1229:                 "SigCdCli", "cursor_4c_BuscaRepr", "iclis", loc_cValor, ;
1230:                 "Sele" + CHR(231) + CHR(227) + "o de Representante", .T., .F., loc_cFiltro)
1231: 
1232:             IF VARTYPE(loc_oBusca) = "O"
1233:                 IF !loc_oBusca.this_lAchouRegistro
1234:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1235:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1236:                     loc_oBusca.Show()
1237:                 ENDIF
1238: 
1239:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1240:                     SELECT cursor_4c_BuscaRepr
1241:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1242:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1243:                 ENDIF
1244: 
1245:                 loc_oBusca.Release()
1246:             ENDIF
1247: 
1248:             IF USED("cursor_4c_BuscaRepr")
1249:                 USE IN cursor_4c_BuscaRepr
1250:             ENDIF
1251:         CATCH TO loException
1252:             MostrarErro("Erro ao buscar representante:" + CHR(13) + loException.Message, ;
1253:                 "FormVis.AbrirLookupRepresentantePorCodigo")
1254:             IF USED("cursor_4c_BuscaRepr")
1255:                 USE IN cursor_4c_BuscaRepr

*-- Linhas 1266 a 1300:
1266:         ENDIF
1267: 
1268:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1269:         loc_cFiltro = IIF(!EMPTY(loc_cGrupo), "Grupos = " + EscaparSQL(loc_cGrupo), "")
1270:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1271: 
1272:         TRY
1273:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1274:                 "SigCdCli", "cursor_4c_BuscaRepr", "rclis", loc_cValor, ;
1275:                 "Sele" + CHR(231) + CHR(227) + "o de Representante", .T., .F., loc_cFiltro)
1276: 
1277:             IF VARTYPE(loc_oBusca) = "O"
1278:                 IF !loc_oBusca.this_lAchouRegistro
1279:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1280:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1281:                     loc_oBusca.Show()
1282:                 ENDIF
1283: 
1284:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRepr")
1285:                     SELECT cursor_4c_BuscaRepr
1286:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaRepr.rclis)
1287:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaRepr.iclis)
1288:                 ENDIF
1289: 
1290:                 loc_oBusca.Release()
1291:             ENDIF
1292: 
1293:             IF USED("cursor_4c_BuscaRepr")
1294:                 USE IN cursor_4c_BuscaRepr
1295:             ENDIF
1296:         CATCH TO loException
1297:             MostrarErro("Erro ao buscar representante:" + CHR(13) + loException.Message, ;
1298:                 "FormVis.AbrirLookupRepresentantePorNome")
1299:             IF USED("cursor_4c_BuscaRepr")
1300:                 USE IN cursor_4c_BuscaRepr

*-- Linhas 1349 a 1367:
1349:                 ENDIF
1350: 
1351:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1352:                     SELECT cursor_4c_BuscaConta
1353:                     loc_oPagina.txt_4c_CodCta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
1354:                     loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1355:                 ENDIF
1356: 
1357:                 loc_oBusca.Release()
1358:             ENDIF
1359: 
1360:             IF USED("cursor_4c_BuscaConta")
1361:                 USE IN cursor_4c_BuscaConta
1362:             ENDIF
1363:         CATCH TO loException
1364:             MostrarErro("Erro ao buscar conta:" + CHR(13) + loException.Message, ;
1365:                 "FormVis.AbrirLookupContaPorCodigo")
1366:             IF USED("cursor_4c_BuscaConta")
1367:                 USE IN cursor_4c_BuscaConta

*-- Linhas 1392 a 1410:
1392:                 ENDIF
1393: 
1394:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1395:                     SELECT cursor_4c_BuscaConta
1396:                     loc_oPagina.txt_4c_DesCta.Value = ALLTRIM(cursor_4c_BuscaConta.rclis)
1397:                     loc_oPagina.txt_4c_CodCta.Value = ALLTRIM(cursor_4c_BuscaConta.iclis)
1398:                 ENDIF
1399: 
1400:                 loc_oBusca.Release()
1401:             ENDIF
1402: 
1403:             IF USED("cursor_4c_BuscaConta")
1404:                 USE IN cursor_4c_BuscaConta
1405:             ENDIF
1406:         CATCH TO loException
1407:             MostrarErro("Erro ao buscar conta:" + CHR(13) + loException.Message, ;
1408:                 "FormVis.AbrirLookupContaPorNome")
1409:             IF USED("cursor_4c_BuscaConta")
1410:                 USE IN cursor_4c_BuscaConta


### BO (C:\4c\projeto\app\classes\VisBO.prg):
*====================================================================
* VisBO.prg
*
* Business Object para Cadastro de Visitas de Representantes
* Tabela: SigCdVis
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS VisBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdVis)
    this_cChave          = ""    && pkidchave char(20) - PK
    this_dData           = {}    && datas datetime
    this_cGrupo          = ""    && grupos char(10)
    this_cContas         = ""    && contas char(10) - codigo do representante
    this_cConta          = ""    && iclis char(10) - codigo da conta
    this_nVendas         = 0     && vendas numeric(1,0)
    this_nPedidos        = 0     && pedidos numeric(1,0)
    this_cObservacao     = ""    && obss text
    this_dDataAlteracao  = {}    && dtalts datetime

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdVis"
            THIS.this_cCampoChave = "pkidchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "VisBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cChave)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChave         = TratarNulo(pkidchave, "C")
                THIS.this_dData          = TratarNulo(datas,     "D")
                THIS.this_cGrupo         = TratarNulo(grupos,    "C")
                THIS.this_cContas        = TratarNulo(contas,    "C")
                THIS.this_cConta         = TratarNulo(iclis,     "C")
                THIS.this_nVendas        = TratarNulo(vendas,    "N")
                THIS.this_nPedidos       = TratarNulo(pedidos,   "N")
                THIS.this_cObservacao    = TratarNulo(obss,      "C")
                THIS.this_dDataAlteracao = TratarNulo(dtalts,    "D")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "VisBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdVis
    * pkidchave (PK) eh gerada via fUniqueIds() - o legado faz
    * "replace pkidchave with fUniqueIds() ... in crSigCdVis" no INSERIR
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cChave))
                THIS.this_cChave = fUniqueIds()
            ENDIF

            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdVis (pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts)
                VALUES (
                    <<EscaparSQL(THIS.this_cChave)>>,
                    <<FormatarDataSQL(THIS.this_dData)>>,
                    <<EscaparSQL(THIS.this_cGrupo)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<EscaparSQL(THIS.this_cConta)>>,
                    <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    <<EscaparSQL(THIS.this_cObservacao)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "VisBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDataAlteracao = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdVis
                SET datas    = <<FormatarDataSQL(THIS.this_dData)>>,
                    grupos   = <<EscaparSQL(THIS.this_cGrupo)>>,
                    contas   = <<EscaparSQL(THIS.this_cContas)>>,
                    iclis    = <<EscaparSQL(THIS.this_cConta)>>,
                    vendas   = <<FormatarNumeroSQL(THIS.this_nVendas, 0)>>,
                    pedidos  = <<FormatarNumeroSQL(THIS.this_nPedidos, 0)>>,
                    obss     = <<EscaparSQL(THIS.this_cObservacao)>>,
                    dtalts   = <<FormatarDataSQL(THIS.this_dDataAlteracao)>>
                WHERE pkidchave = <<EscaparSQL(THIS.this_cChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "VisBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdVis
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdVis WHERE pkidchave = " + EscaparSQL(THIS.this_cChave)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "VisBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o Grid da Lista
    * Retorna cursor_4c_Dados com a.* (SigCdVis) + Descri (conta), Repr (representante),
    * DescVendas/DescPedidos (Sim/Nao) - espelha EXATAMENTE o AddCursor/pColuna do legado
    * (SigCdVis.Init, query lcQryVis)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkidchave C(20), Datas T, Grupos C(10), ;
                        Contas C(10), Iclis C(10), Vendas N(1,0), Pedidos N(1,0), Obss M, ;
                        Dtalts T, Descri C(40), Repr C(40), DescVendas C(3), DescPedidos C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.*, b.rclis AS Descri, c.rclis AS Repr," + ;
                    " CASE WHEN a.vendas = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescVendas," + ;
                    " CASE WHEN a.pedidos = 1 THEN 'Sim' ELSE 'N" + CHR(227) + "o' END AS DescPedidos" + ;
                    " FROM SigCdVis a" + ;
                    " INNER JOIN SigCdCli b ON a.iclis = b.iclis" + ;
                    " INNER JOIN SigCdCli c ON a.Contas = c.iclis"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.pkidchave"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar visitas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "VisBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (pkidchave)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkidchave, datas, grupos, contas, iclis, vendas, pedidos, obss, dtalts" + ;
                " FROM SigCdVis WHERE pkidchave = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Visita n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar visita:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "VisBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

