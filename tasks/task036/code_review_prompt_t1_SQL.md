# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, DATAS, EMPS, CPROS, GRUPOS, CONTAS, CODS, NENVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, DATAS, EMPS, CPROS, GRUPOS, CONTAS, CODS, NENVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DESCRS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, DATAS, EMPS, CPROS, GRUPOS, CONTAS, CODS, NENVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, DATAS, EMPS, CPROS, GRUPOS, CONTAS, CODS, NENVS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GERBALS, DATAS, EMPS, CPROS, GRUPOS, CONTAS, CODS, NENVS

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
lcQuery = [Select IClis, RClis, Inativas ] + ;
		    [From SigCdCli ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
Select crSigCdCli
lcQuery = [Select Codigos, Descrs, GerBals ] + ;
		    [From SigCdGcr]
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdGcr') < 1)
Select crSigCdGcr
Insert Into dbCabecalho (Titulo, SubTitulo, NomeEmpresa) Values (lcCab, lcSub, lcEmp)
lcQuery = [Select a.*, d.RClis, b.Descs as DescTabs, b.fixos ] + ;
		  [From SigOpInc a, SigCdNcf b, SigCdCli d ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpInc') < 1)
	Select CrSigOpInc
	Select Cods, Iif(Fixos<>2,DescTabs,Descs) as DescTabs, Iif(lnQbr=1,Grupos,Space(10)) as Grupos, Iif(lnQbr=1,Contas,Space(10)) as Contas,;
	Sum(1) as Qtds, Sum(1 / wQtd * 100.00) as Percs From CrSigOpInc ;
	Select Iif(lnQbr=1,Grupos + '/'+Contas+'-'+Rclis,Cods+'-'+Iif(fixos<>2,DescTabs,Descs)) as Quebra1,;
	Iif(lnQbr=1,Cods+'-'+DescTabs,Grupos + '/'+Contas+'-'+Rclis) as Quebra2, Iif(fixos<>2,DescTabs,Descs) as DescTabs,* From CrSigOpInc ;
	Select Selecao
	Select crSigCdGcr
	If Not Seek(This.Value)
	Select crSigCdGcr
	If Not Seek(This.Value)
	lcSql = [Select * From SigCdNcf Where Emps = ']+_Empr+[' Or Emps = ' ' ]
	If Thisform.Podatamgr.Sqlexecute(lcSql,'CsSelecao') < 1
	Select CsSelecao
	If Not Seek(This.Value)
	Select crSigCdCli
	If Not Seek(This.Value)
	Select crSigCdCli
	If Not Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAUP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1608 linhas total):

*-- Linhas 946 a 970:
946:             RETURN
947:         ENDIF
948: 
949:         loc_cSQL   = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
950:                      "WHERE Codigos = " + EscaparSQL(loc_cValor) + ;
951:                      " AND GerBals = 1"
952:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcbVal")
953: 
954:         IF loc_nResult > 0 AND !EOF("cursor_4c_GcbVal")
955:             SELECT cursor_4c_GcbVal
956:             loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbVal.Codigos)
957:             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbVal.Descrs)
958:             IF USED("cursor_4c_GcbVal")
959:                 USE IN cursor_4c_GcbVal
960:             ENDIF
961:         ELSE
962:             IF USED("cursor_4c_GcbVal")
963:                 USE IN cursor_4c_GcbVal
964:             ENDIF
965:             THIS.AbrirBuscaGrupo()
966:             RETURN
967:         ENDIF
968: 
969:         THIS.AtualizarEstadoCampos()
970:     ENDPROC

*-- Linhas 986 a 1010:
986:             RETURN
987:         ENDIF
988: 
989:         loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
990:                    "WHERE Descrs LIKE " + EscaparSQL(loc_cValor + "%") + ;
991:                    " AND GerBals = 1 ORDER BY Descrs"
992:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcbDVal")
993: 
994:         IF loc_nResult > 0 AND !EOF("cursor_4c_GcbDVal")
995:             SELECT cursor_4c_GcbDVal
996:             loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDVal.Codigos)
997:             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDVal.Descrs)
998:             IF USED("cursor_4c_GcbDVal")
999:                 USE IN cursor_4c_GcbDVal
1000:             ENDIF
1001:         ELSE
1002:             IF USED("cursor_4c_GcbDVal")
1003:                 USE IN cursor_4c_GcbDVal
1004:             ENDIF
1005:             THIS.AbrirBuscaDGrupo()
1006:             RETURN
1007:         ENDIF
1008: 
1009:         THIS.AtualizarEstadoCampos()
1010:     ENDPROC

*-- Linhas 1026 a 1050:
1026:             RETURN
1027:         ENDIF
1028: 
1029:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1030:                    "WHERE IClis = " + EscaparSQL(loc_cValor) + ;
1031:                    " AND GerBals = 1"
1032:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
1033: 
1034:         IF loc_nResult > 0 AND !EOF("cursor_4c_CliVal")
1035:             SELECT cursor_4c_CliVal
1036:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliVal.IClis)
1037:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliVal.RClis)
1038:             IF USED("cursor_4c_CliVal")
1039:                 USE IN cursor_4c_CliVal
1040:             ENDIF
1041:         ELSE
1042:             IF USED("cursor_4c_CliVal")
1043:                 USE IN cursor_4c_CliVal
1044:             ENDIF
1045:             THIS.AbrirBuscaConta()
1046:             RETURN
1047:         ENDIF
1048: 
1049:         THIS.AtualizarEstadoCampos()
1050:     ENDPROC

*-- Linhas 1066 a 1090:
1066:             RETURN
1067:         ENDIF
1068: 
1069:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
1070:                    "WHERE RClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1071:                    " AND GerBals = 1 ORDER BY RClis"
1072:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDVal")
1073: 
1074:         IF loc_nResult > 0 AND !EOF("cursor_4c_CliDVal")
1075:             SELECT cursor_4c_CliDVal
1076:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDVal.IClis)
1077:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDVal.RClis)
1078:             IF USED("cursor_4c_CliDVal")
1079:                 USE IN cursor_4c_CliDVal
1080:             ENDIF
1081:         ELSE
1082:             IF USED("cursor_4c_CliDVal")
1083:                 USE IN cursor_4c_CliDVal
1084:             ENDIF
1085:             THIS.AbrirBuscaDConta()
1086:             RETURN
1087:         ENDIF
1088: 
1089:         THIS.AtualizarEstadoCampos()
1090:     ENDPROC

*-- Linhas 1104 a 1129:
1104:             RETURN
1105:         ENDIF
1106: 
1107:         loc_cSQL = "SELECT Cods, Descs FROM SigCdNcf " + ;
1108:                    "WHERE Cods = " + EscaparSQL(loc_cValor) + ;
1109:                    " AND (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1110:                    " OR Emps = '  ')"
1111:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NcfVal")
1112: 
1113:         IF loc_nResult > 0 AND !EOF("cursor_4c_NcfVal")
1114:             SELECT cursor_4c_NcfVal
1115:             loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfVal.Cods)
1116:             IF USED("cursor_4c_NcfVal")
1117:                 USE IN cursor_4c_NcfVal
1118:             ENDIF
1119:         ELSE
1120:             IF USED("cursor_4c_NcfVal")
1121:                 USE IN cursor_4c_NcfVal
1122:             ENDIF
1123:             THIS.AbrirBuscaNCF()
1124:         ENDIF
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr por codigo
1129:     *--------------------------------------------------------------------------

*-- Linhas 1142 a 1171:
1142:         ENDIF
1143: 
1144:         IF loc_oForm.this_lAchouRegistro
1145:             SELECT cursor_4c_GcbBusca
1146:             IF !EOF("cursor_4c_GcbBusca")
1147:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
1148:                 loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
1149:             ENDIF
1150:         ELSE
1151:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1152:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1153:             loc_oForm.Show()
1154:             IF loc_oForm.this_lSelecionou
1155:                 IF USED("cursor_4c_GcbBusca")
1156:                     SELECT cursor_4c_GcbBusca
1157:                     IF !EOF("cursor_4c_GcbBusca")
1158:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
1159:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
1160:                     ENDIF
1161:                 ENDIF
1162:             ENDIF
1163:         ENDIF
1164: 
1165:         IF USED("cursor_4c_GcbBusca")
1166:             USE IN cursor_4c_GcbBusca
1167:         ENDIF
1168:         IF VARTYPE(loc_oForm) = "O"
1169:             loc_oForm.Release()
1170:         ENDIF
1171: 

*-- Linhas 1190 a 1219:
1190:         ENDIF
1191: 
1192:         IF loc_oForm.this_lAchouRegistro
1193:             SELECT cursor_4c_GcbDescBusca
1194:             IF !EOF("cursor_4c_GcbDescBusca")
1195:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
1196:                 loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
1197:             ENDIF
1198:         ELSE
1199:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1200:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1201:             loc_oForm.Show()
1202:             IF loc_oForm.this_lSelecionou
1203:                 IF USED("cursor_4c_GcbDescBusca")
1204:                     SELECT cursor_4c_GcbDescBusca
1205:                     IF !EOF("cursor_4c_GcbDescBusca")
1206:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
1207:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
1208:                     ENDIF
1209:                 ENDIF
1210:             ENDIF
1211:         ENDIF
1212: 
1213:         IF USED("cursor_4c_GcbDescBusca")
1214:             USE IN cursor_4c_GcbDescBusca
1215:         ENDIF
1216:         IF VARTYPE(loc_oForm) = "O"
1217:             loc_oForm.Release()
1218:         ENDIF
1219: 

*-- Linhas 1238 a 1267:
1238:         ENDIF
1239: 
1240:         IF loc_oForm.this_lAchouRegistro
1241:             SELECT cursor_4c_CliBusca
1242:             IF !EOF("cursor_4c_CliBusca")
1243:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
1244:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
1245:             ENDIF
1246:         ELSE
1247:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1248:             loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1249:             loc_oForm.Show()
1250:             IF loc_oForm.this_lSelecionou
1251:                 IF USED("cursor_4c_CliBusca")
1252:                     SELECT cursor_4c_CliBusca
1253:                     IF !EOF("cursor_4c_CliBusca")
1254:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
1255:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
1256:                     ENDIF
1257:                 ENDIF
1258:             ENDIF
1259:         ENDIF
1260: 
1261:         IF USED("cursor_4c_CliBusca")
1262:             USE IN cursor_4c_CliBusca
1263:         ENDIF
1264:         IF VARTYPE(loc_oForm) = "O"
1265:             loc_oForm.Release()
1266:         ENDIF
1267: 

*-- Linhas 1286 a 1315:
1286:         ENDIF
1287: 
1288:         IF loc_oForm.this_lAchouRegistro
1289:             SELECT cursor_4c_CliDescBusca
1290:             IF !EOF("cursor_4c_CliDescBusca")
1291:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
1292:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
1293:             ENDIF
1294:         ELSE
1295:             loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1296:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1297:             loc_oForm.Show()
1298:             IF loc_oForm.this_lSelecionou
1299:                 IF USED("cursor_4c_CliDescBusca")
1300:                     SELECT cursor_4c_CliDescBusca
1301:                     IF !EOF("cursor_4c_CliDescBusca")
1302:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
1303:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
1304:                     ENDIF
1305:                 ENDIF
1306:             ENDIF
1307:         ENDIF
1308: 
1309:         IF USED("cursor_4c_CliDescBusca")
1310:             USE IN cursor_4c_CliDescBusca
1311:         ENDIF
1312:         IF VARTYPE(loc_oForm) = "O"
1313:             loc_oForm.Release()
1314:         ENDIF
1315: 

*-- Linhas 1419 a 1447:
1419:         ENDIF
1420: 
1421:         IF loc_oForm.this_lAchouRegistro
1422:             SELECT cursor_4c_NcfBusca
1423:             IF !EOF("cursor_4c_NcfBusca")
1424:                 loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
1425:             ENDIF
1426:         ELSE
1427:             loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1428:             loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1429:             loc_oForm.Show()
1430:             IF loc_oForm.this_lSelecionou
1431:                 IF USED("cursor_4c_NcfBusca")
1432:                     SELECT cursor_4c_NcfBusca
1433:                     IF !EOF("cursor_4c_NcfBusca")
1434:                         loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
1435:                     ENDIF
1436:                 ENDIF
1437:             ENDIF
1438:         ENDIF
1439: 
1440:         IF USED("cursor_4c_NcfBusca")
1441:             USE IN cursor_4c_NcfBusca
1442:         ENDIF
1443:         IF VARTYPE(loc_oForm) = "O"
1444:             loc_oForm.Release()
1445:         ENDIF
1446:     ENDPROC
1447: 


### BO (C:\4c\projeto\app\classes\SIGREAUPBO.prg):
*==============================================================================
* SIGREAUPBO.PRG
* Business Object - Relatorio de Tipos de Autorizacoes de Producao
* Herda de RelatorioBase
*
* Filtros: Periodo, Grupo, Conta, Envelope, Codigo NCF, Ordem, Percentual
* Tabela principal: SigOpInc (joins: SigCdNcf, SigCdCli)
* Reports: SigReAu1 (listagem), SigReAu2 (percentual)
*==============================================================================

DEFINE CLASS SIGREAUPBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigOpInc"
    this_cCampoChave    = ""
    this_cMensagemErro  = ""

    *-- Filtros de periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro de grupo (codigo + descricao para lookup bidirecional)
    this_cGrupo         = ""
    this_cDGrupo        = ""

    *-- Filtro de conta (codigo + descricao para lookup bidirecional)
    this_cConta         = ""
    this_cDConta        = ""

    *-- Filtro de envelope (numerico)
    this_nEnvelope      = 0

    *-- Filtro de codigo NCF
    this_cCodigo        = ""

    *-- Opcao de ordem: 1=Grupo/Conta, 2=Tipo de Autorizacao
    this_nOrdem         = 1

    *-- Exibir em percentual: 0=nao, 1=sim
    this_nPercent       = 0

    *-- Nome do cursor principal de dados gerado por PrepararDados
    this_cCursorDados   = "cursor_4c_SigOpInc"

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida filtros obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data Inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data Final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "A Data Final n" + CHR(227) + "o pode ser menor que a Inicial!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta cursores para o relatorio
    * Replica logica do procedimento 'processamento' do legado:
    *   1. Carrega nome da empresa para cabecalho
    *   2. Cria cursor_4c_Cabecalho com titulo/subtitulo
    *   3. Executa query principal em SigOpInc (joins SigCdNcf, SigCdCli)
    *   4. Transforma cursor: percentual (TmpInc) ou listagem (Selecao+index)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cEmp, loc_cCab, loc_cSub, loc_cSQLEmp
        LOCAL loc_nQbr, loc_nWQtd

        loc_lSucesso  = .F.
        loc_nWQtd     = 0
        loc_nQbr      = THIS.this_nOrdem
        THIS.this_cMensagemErro = ""

        TRY
            *-- 1. Nome da empresa para cabecalho
            loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigCdEmp")
            SELECT cursor_4c_SigCdEmp
            loc_cEmp = go_4c_Sistema.cCodEmpresa + " - " + ;
                       IIF(EOF("cursor_4c_SigCdEmp"), "", ALLTRIM(cursor_4c_SigCdEmp.Razas))
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF

            *-- 2. Monta cabecalho e subtitulo do relatorio
            loc_cCab = "Relat" + CHR(243) + "rio de Tipo de Autoriza" + ;
                       CHR(231) + CHR(245) + "es"
            loc_cSub = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                       " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal)
            IF !EMPTY(THIS.this_cGrupo)
                loc_cSub = loc_cSub + " - Grupo : " + ALLTRIM(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cSub = loc_cSub + " - Contas : " + ALLTRIM(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cSub = loc_cSub + " - Envelope : " + ALLTRIM(STR(THIS.this_nEnvelope))
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cSub = loc_cSub + " - C" + CHR(243) + "digo : " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho ;
                (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)

            *-- 3. Monta clausula WHERE da query principal
            loc_cWhere = "a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                         " AND a.Datas < DATEADD(day, 1, " + ;
                         FormatarDataSQL(THIS.this_dDtFinal) + ")" + ;
                         " AND a.Cods = b.Cods" + ;
                         " AND (b.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                         " OR b.Emps = '  ')" + ;
                         " AND a.Contas = d.IClis" + ;
                         " AND a.Cpros = ' '"

            IF !EMPTY(THIS.this_cGrupo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Grupos = " + EscaparSQL(THIS.this_cGrupo)
            ENDIF
            IF !EMPTY(THIS.this_cConta)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Contas = " + EscaparSQL(THIS.this_cConta)
            ENDIF
            IF !EMPTY(THIS.this_cCodigo)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Cods = " + EscaparSQL(THIS.this_cCodigo)
            ENDIF
            IF !EMPTY(THIS.this_nEnvelope)
                loc_cWhere = loc_cWhere + ;
                             " AND a.Nenvs = " + TRANSFORM(THIS.this_nEnvelope)
            ENDIF

            *-- 4. Query principal: SigOpInc + SigCdNcf + SigCdCli
            loc_cSQL = "SELECT a.*, d.RClis, b.Descs AS DescTabs, b.fixos " + ;
                       "FROM SigOpInc a, SigCdNcf b, SigCdCli d " + ;
                       "WHERE " + loc_cWhere + " " + ;
                       "ORDER BY a.Grupos, a.Contas, a.Datas, a.Nenvs, a.Cods"

            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de autoriza" + ;
                    CHR(231) + CHR(245) + "es de produ" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- 5. Transforma cursor conforme modo: percentual ou listagem
            IF THIS.this_nPercent = 1

                SELECT (THIS.this_cCursorDados)
                SUM 1 TO loc_nWQtd

                IF loc_nWQtd > 0
                    SELECT Cods, ;
                           IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, ;
                           IIF(loc_nQbr = 1, Grupos, SPACE(10)) AS Grupos, ;
                           IIF(loc_nQbr = 1, Contas, SPACE(10)) AS Contas, ;
                           SUM(1) AS Qtds, ;
                           SUM(1 / loc_nWQtd * 100.00) AS Percs ;
                    FROM (THIS.this_cCursorDados) ;
                    INTO CURSOR cursor_4c_TmpInc ;
                    GROUP BY 1, 2, 3, 4 ;
                    ORDER BY 1, 2, 3, 4
                ELSE
                    CREATE CURSOR cursor_4c_TmpInc ;
                        (Cods C(10), DescTabs C(50), Grupos C(10), ;
                         Contas C(10), Qtds N(10,0), Percs N(10,2))
                ENDIF

            ELSE

                SELECT IIF(loc_nQbr = 1, ;
                           Grupos + "/" + Contas + "-" + RClis, ;
                           Cods + "-" + IIF(fixos <> 2, DescTabs, Descs)) AS Quebra1, ;
                       IIF(loc_nQbr = 1, ;
                           Cods + "-" + DescTabs, ;
                           Grupos + "/" + Contas + "-" + RClis) AS Quebra2, ;
                       IIF(fixos <> 2, DescTabs, Descs) AS DescTabs, * ;
                FROM (THIS.this_cCursorDados) ;
                INTO CURSOR cursor_4c_Selecao

                SELECT cursor_4c_Selecao
                INDEX ON Quebra1 + Quebra2 + DTOS(Datas) + STR(Nenvs, 10) TAG Ordem
                GO TOP

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) PREVIEW NOCONSOLE
            THIS.RegistrarAuditoria("VISUALIZAR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.RegistrarAuditoria("IMPRIMIR")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Documento - Prepara dados e envia direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Documento()
        LOCAL loc_lSucesso, loc_cRelatorio

        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            loc_cRelatorio = gc_4c_CaminhoReports + ;
                             IIF(THIS.this_nPercent = 1, "SigReAu2", "SigReAu1")

            REPORT FORM (loc_cRelatorio) TO PRINT NOCONSOLE
            THIS.RegistrarAuditoria("DOCUMENTO")
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros principais + periodo
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa, loc_cTipo

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cTipo = IIF(THIS.this_nPercent = 1, "PERCENT", "LISTAGEM") + ;
                    "/ORD" + ALLTRIM(STR(THIS.this_nOrdem))

        loc_cChave = loc_cEmpresa + "/" + loc_cTipo + "/" + ;
                     DTOC(THIS.this_dDtInicial) + "/" + ;
                     DTOC(THIS.this_dDtFinal)

        IF !EMPTY(THIS.this_cGrupo)
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(THIS.this_cConta)
            loc_cChave = loc_cChave + "/C:" + ALLTRIM(THIS.this_cConta)
        ENDIF

        IF !EMPTY(THIS.this_cCodigo)
            loc_cChave = loc_cChave + "/N:" + ALLTRIM(THIS.this_cCodigo)
        ENDIF

        IF THIS.this_nEnvelope > 0
            loc_cChave = loc_cChave + "/E:" + ALLTRIM(STR(THIS.this_nEnvelope))
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    * par_cOperacao: VISUALIZAR, IMPRIMIR, DOCUMENTO, EXPORTAR
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAUP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao.
    *
    * Para relatorios, o fluxo correto eh:
    *   - PrepararDados() monta os cursores de saida via SQLEXEC sobre o
    *     periodo filtrado (cursor_4c_Cabecalho, cursor_4c_TmpInc, cursor_4c_Selecao)
    *   - Imprimir() / Visualizar() / Documento() consomem esses cursores
    *     atraves dos .FRX SigReAu1 (listagem) / SigReAu2 (percentual)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores auxiliares abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_SigOpInc")
            USE IN cursor_4c_SigOpInc
        ENDIF
        IF USED("cursor_4c_TmpInc")
            USE IN cursor_4c_TmpInc
        ENDIF
        IF USED("cursor_4c_Selecao")
            USE IN cursor_4c_Selecao
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

