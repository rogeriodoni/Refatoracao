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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAUP.prg) - TRECHOS RELEVANTES PARA PASS SQL (1606 linhas total):

*-- Linhas 946 a 969:
946:             RETURN
947:         ENDIF
948: 
949:         loc_cSQL   = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
950:                      "WHERE Codigos = " + EscaparSQL(loc_cValor)
951:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcbVal")
952: 
953:         IF loc_nResult > 0 AND !EOF("cursor_4c_GcbVal")
954:             SELECT cursor_4c_GcbVal
955:             loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbVal.Codigos)
956:             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbVal.Descrs)
957:             IF USED("cursor_4c_GcbVal")
958:                 USE IN cursor_4c_GcbVal
959:             ENDIF
960:         ELSE
961:             IF USED("cursor_4c_GcbVal")
962:                 USE IN cursor_4c_GcbVal
963:             ENDIF
964:             THIS.AbrirBuscaGrupo()
965:             RETURN
966:         ENDIF
967: 
968:         THIS.AtualizarEstadoCampos()
969:     ENDPROC

*-- Linhas 985 a 1009:
985:             RETURN
986:         ENDIF
987: 
988:         loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
989:                    "WHERE Descrs LIKE " + EscaparSQL(loc_cValor + "%") + ;
990:                    " ORDER BY Descrs"
991:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcbDVal")
992: 
993:         IF loc_nResult > 0 AND !EOF("cursor_4c_GcbDVal")
994:             SELECT cursor_4c_GcbDVal
995:             loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDVal.Codigos)
996:             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDVal.Descrs)
997:             IF USED("cursor_4c_GcbDVal")
998:                 USE IN cursor_4c_GcbDVal
999:             ENDIF
1000:         ELSE
1001:             IF USED("cursor_4c_GcbDVal")
1002:                 USE IN cursor_4c_GcbDVal
1003:             ENDIF
1004:             THIS.AbrirBuscaDGrupo()
1005:             RETURN
1006:         ENDIF
1007: 
1008:         THIS.AtualizarEstadoCampos()
1009:     ENDPROC

*-- Linhas 1025 a 1048:
1025:             RETURN
1026:         ENDIF
1027: 
1028:         loc_cSQL = "SELECT IClis, RClis FROM SigCdCli " + ;
1029:                    "WHERE IClis = " + EscaparSQL(loc_cValor)
1030:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
1031: 
1032:         IF loc_nResult > 0 AND !EOF("cursor_4c_CliVal")
1033:             SELECT cursor_4c_CliVal
1034:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliVal.IClis)
1035:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliVal.RClis)
1036:             IF USED("cursor_4c_CliVal")
1037:                 USE IN cursor_4c_CliVal
1038:             ENDIF
1039:         ELSE
1040:             IF USED("cursor_4c_CliVal")
1041:                 USE IN cursor_4c_CliVal
1042:             ENDIF
1043:             THIS.AbrirBuscaConta()
1044:             RETURN
1045:         ENDIF
1046: 
1047:         THIS.AtualizarEstadoCampos()
1048:     ENDPROC

*-- Linhas 1064 a 1088:
1064:             RETURN
1065:         ENDIF
1066: 
1067:         loc_cSQL = "SELECT TOP 1 IClis, RClis FROM SigCdCli " + ;
1068:                    "WHERE RClis LIKE " + EscaparSQL(loc_cValor + "%") + ;
1069:                    " ORDER BY RClis"
1070:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDVal")
1071: 
1072:         IF loc_nResult > 0 AND !EOF("cursor_4c_CliDVal")
1073:             SELECT cursor_4c_CliDVal
1074:             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDVal.IClis)
1075:             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDVal.RClis)
1076:             IF USED("cursor_4c_CliDVal")
1077:                 USE IN cursor_4c_CliDVal
1078:             ENDIF
1079:         ELSE
1080:             IF USED("cursor_4c_CliDVal")
1081:                 USE IN cursor_4c_CliDVal
1082:             ENDIF
1083:             THIS.AbrirBuscaDConta()
1084:             RETURN
1085:         ENDIF
1086: 
1087:         THIS.AtualizarEstadoCampos()
1088:     ENDPROC

*-- Linhas 1102 a 1127:
1102:             RETURN
1103:         ENDIF
1104: 
1105:         loc_cSQL = "SELECT Cods, Descs FROM SigCdNcf " + ;
1106:                    "WHERE Cods = " + EscaparSQL(loc_cValor) + ;
1107:                    " AND (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1108:                    " OR Emps = '  ')"
1109:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NcfVal")
1110: 
1111:         IF loc_nResult > 0 AND !EOF("cursor_4c_NcfVal")
1112:             SELECT cursor_4c_NcfVal
1113:             loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfVal.Cods)
1114:             IF USED("cursor_4c_NcfVal")
1115:                 USE IN cursor_4c_NcfVal
1116:             ENDIF
1117:         ELSE
1118:             IF USED("cursor_4c_NcfVal")
1119:                 USE IN cursor_4c_NcfVal
1120:             ENDIF
1121:             THIS.AbrirBuscaNCF()
1122:         ENDIF
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------
1126:     * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr por codigo
1127:     *--------------------------------------------------------------------------

*-- Linhas 1140 a 1169:
1140:         ENDIF
1141: 
1142:         IF loc_oForm.this_lAchouRegistro
1143:             SELECT cursor_4c_GcbBusca
1144:             IF !EOF("cursor_4c_GcbBusca")
1145:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
1146:                 loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
1147:             ENDIF
1148:         ELSE
1149:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1150:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1151:             loc_oForm.Show()
1152:             IF loc_oForm.this_lSelecionou
1153:                 IF USED("cursor_4c_GcbBusca")
1154:                     SELECT cursor_4c_GcbBusca
1155:                     IF !EOF("cursor_4c_GcbBusca")
1156:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbBusca.Codigos)
1157:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbBusca.Descrs)
1158:                     ENDIF
1159:                 ENDIF
1160:             ENDIF
1161:         ENDIF
1162: 
1163:         IF USED("cursor_4c_GcbBusca")
1164:             USE IN cursor_4c_GcbBusca
1165:         ENDIF
1166:         IF VARTYPE(loc_oForm) = "O"
1167:             loc_oForm.Release()
1168:         ENDIF
1169: 

*-- Linhas 1188 a 1217:
1188:         ENDIF
1189: 
1190:         IF loc_oForm.this_lAchouRegistro
1191:             SELECT cursor_4c_GcbDescBusca
1192:             IF !EOF("cursor_4c_GcbDescBusca")
1193:                 loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
1194:                 loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
1195:             ENDIF
1196:         ELSE
1197:             loc_oForm.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1198:             loc_oForm.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1199:             loc_oForm.Show()
1200:             IF loc_oForm.this_lSelecionou
1201:                 IF USED("cursor_4c_GcbDescBusca")
1202:                     SELECT cursor_4c_GcbDescBusca
1203:                     IF !EOF("cursor_4c_GcbDescBusca")
1204:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GcbDescBusca.Codigos)
1205:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GcbDescBusca.Descrs)
1206:                     ENDIF
1207:                 ENDIF
1208:             ENDIF
1209:         ENDIF
1210: 
1211:         IF USED("cursor_4c_GcbDescBusca")
1212:             USE IN cursor_4c_GcbDescBusca
1213:         ENDIF
1214:         IF VARTYPE(loc_oForm) = "O"
1215:             loc_oForm.Release()
1216:         ENDIF
1217: 

*-- Linhas 1236 a 1265:
1236:         ENDIF
1237: 
1238:         IF loc_oForm.this_lAchouRegistro
1239:             SELECT cursor_4c_CliBusca
1240:             IF !EOF("cursor_4c_CliBusca")
1241:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
1242:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
1243:             ENDIF
1244:         ELSE
1245:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1246:             loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1247:             loc_oForm.Show()
1248:             IF loc_oForm.this_lSelecionou
1249:                 IF USED("cursor_4c_CliBusca")
1250:                     SELECT cursor_4c_CliBusca
1251:                     IF !EOF("cursor_4c_CliBusca")
1252:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliBusca.IClis)
1253:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliBusca.RClis)
1254:                     ENDIF
1255:                 ENDIF
1256:             ENDIF
1257:         ENDIF
1258: 
1259:         IF USED("cursor_4c_CliBusca")
1260:             USE IN cursor_4c_CliBusca
1261:         ENDIF
1262:         IF VARTYPE(loc_oForm) = "O"
1263:             loc_oForm.Release()
1264:         ENDIF
1265: 

*-- Linhas 1284 a 1313:
1284:         ENDIF
1285: 
1286:         IF loc_oForm.this_lAchouRegistro
1287:             SELECT cursor_4c_CliDescBusca
1288:             IF !EOF("cursor_4c_CliDescBusca")
1289:                 loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
1290:                 loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
1291:             ENDIF
1292:         ELSE
1293:             loc_oForm.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
1294:             loc_oForm.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
1295:             loc_oForm.Show()
1296:             IF loc_oForm.this_lSelecionou
1297:                 IF USED("cursor_4c_CliDescBusca")
1298:                     SELECT cursor_4c_CliDescBusca
1299:                     IF !EOF("cursor_4c_CliDescBusca")
1300:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDescBusca.IClis)
1301:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_CliDescBusca.RClis)
1302:                     ENDIF
1303:                 ENDIF
1304:             ENDIF
1305:         ENDIF
1306: 
1307:         IF USED("cursor_4c_CliDescBusca")
1308:             USE IN cursor_4c_CliDescBusca
1309:         ENDIF
1310:         IF VARTYPE(loc_oForm) = "O"
1311:             loc_oForm.Release()
1312:         ENDIF
1313: 

*-- Linhas 1417 a 1445:
1417:         ENDIF
1418: 
1419:         IF loc_oForm.this_lAchouRegistro
1420:             SELECT cursor_4c_NcfBusca
1421:             IF !EOF("cursor_4c_NcfBusca")
1422:                 loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
1423:             ENDIF
1424:         ELSE
1425:             loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1426:             loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1427:             loc_oForm.Show()
1428:             IF loc_oForm.this_lSelecionou
1429:                 IF USED("cursor_4c_NcfBusca")
1430:                     SELECT cursor_4c_NcfBusca
1431:                     IF !EOF("cursor_4c_NcfBusca")
1432:                         loc_oPagina.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_NcfBusca.Cods)
1433:                     ENDIF
1434:                 ENDIF
1435:             ENDIF
1436:         ENDIF
1437: 
1438:         IF USED("cursor_4c_NcfBusca")
1439:             USE IN cursor_4c_NcfBusca
1440:         ENDIF
1441:         IF VARTYPE(loc_oForm) = "O"
1442:             loc_oForm.Release()
1443:         ENDIF
1444:     ENDPROC
1445: 


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
            SET NULL ON
            CREATE CURSOR cursor_4c_Cabecalho ;
                (Titulo C(100), SubTitulo C(100), NomeEmpresa C(100))
            INSERT INTO cursor_4c_Cabecalho (Titulo, SubTitulo, NomeEmpresa) ;
                VALUES (loc_cCab, loc_cSub, loc_cEmp)
            SET NULL OFF

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
                    SET NULL ON
                    CREATE CURSOR cursor_4c_TmpInc ;
                        (Cods C(10), DescTabs C(50), Grupos C(10), ;
                         Contas C(10), Qtds N(10,0), Percs N(10,2))
                    SET NULL OFF
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

