# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPPS, NUMPS, GRUPOOS, CONTAOS, GRUPODS, CONTADS, NOPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPPS, NUMPS, GRUPOOS, CONTAOS, GRUPODS, CONTADS, NOPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS, DOPPS, NUMPS, GRUPOOS, CONTAOS, GRUPODS, CONTADS, NOPS

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
Insert Into dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
lcQuery = [Select distinct 1 as Tipo, a.emps, a.dopps, a.numps, b.CidChaves,a.Nops as Nenvs, a.EmpDnPs, b.Datas, ]+;
	[from SigCdNei a ]+;
	[inner join SigCdNec b on a.empdnps = b.empdnps ]+; 
	[inner join SigCdPro c on a.cmats = c.cpros ]+; 
	[left join SigOpPic d on a.Nops = d.Nops ]+;
	[left join SigCdPro e on d.Cpros = e.Cpros ]+; 
	[inner join SigPdMvf f on a.EmpDnPs = f.EmpDnPs ]+;
	[Select distinct 1 as Tipo, a.emps, a.dopps, a.numps, b.CidChaves,a.Nenvs, a.EmpDnPs, b.Datas, ]+;
	[from SigCdNei a ]+;
	[inner join SigCdNec b on a.empdnps = b.empdnps ]+; 
	[inner join SigCdPro c on a.cmats = c.cpros ]+; 
	[left join SigOpPic d on a.Nops = d.Nops ]+;
	[left join SigCdPro e on d.Cpros = e.Cpros ]+; 
	[inner join SigPdMvf f on a.EmpDnPs = f.EmpDnPs ]+;
If Thisform.podatamgr.SqlExecute(lcQuery,'TmpNensi') < 1
Select TmpNensi
select Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips, max(cidchaves) as cidchaves, max(pesos) as pesos, max(peso2s) as peso2s, max(qtds) as Qtds, MAX(qtd) as qtd ;
from TmpNensi ;
Select crNensi
select 2 as Tipo, nenvs, cmats, max(pesos) as pesos, max(peso2s) as peso2s, max(qtds) as Qtds ;
from crNensi ;
Select crNensi2
select 3 as Tipo, nenvs, max(qtd) as Qtd ;
from crNensi ;
Select crNensi3
Select crNensi
	select 9 as Tipo, '' as Dopps, cmats, dpros, cunips, cunis, 0 as Qtd, Sum(qtds) as Qtds, Sum(pesos) as pesos, Sum(peso2s) as peso2s ;
		from crNensi ;
	Select crTmpNensi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGRECPM.prg) - TRECHOS RELEVANTES PARA PASS SQL (1474 linhas total):

*-- Linhas 964 a 1013:
964:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Empresa.Value)
965: 
966:         IF !EMPTY(loc_cValor)
967:             loc_cSQL = "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
968:                        EscaparSQL(loc_cValor)
969:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
970:             IF loc_nRes > 0
971:                 SELECT cursor_4c_EmpVal
972:                 IF !EOF()
973:                     loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
974:                     USE IN cursor_4c_EmpVal
975:                     RETURN
976:                 ENDIF
977:             ENDIF
978:             IF USED("cursor_4c_EmpVal")
979:                 USE IN cursor_4c_EmpVal
980:             ENDIF
981:         ENDIF
982: 
983:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
984:             "SigCdEmp", "cursor_4c_EmpBusca", "cemps", loc_cValor, "Empresa")
985:         IF VARTYPE(loc_oForm) != "O"
986:             RETURN
987:         ENDIF
988:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
989:             SELECT cursor_4c_EmpBusca
990:             loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
991:             loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
992:         ELSE
993:             IF !loc_oForm.this_lAchouRegistro
994:             loc_oForm.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
995:             loc_oForm.mAddColuna("razas", "", "Descri" + CHR(231) + CHR(227) + "o")
996:             loc_oForm.Show()
997:             IF loc_oForm.this_lSelecionou
998:                 SELECT cursor_4c_EmpBusca
999:                 loc_oPag.txt_4c_Empresa.Value  = ALLTRIM(cemps)
1000:                 loc_oPag.txt_4c_DEmpresa.Value = ALLTRIM(razas)
1001:             ENDIF
1002:             ENDIF
1003:         ENDIF
1004:         IF USED("cursor_4c_EmpBusca")
1005:             USE IN cursor_4c_EmpBusca
1006:         ENDIF
1007:         loc_oForm.Release()
1008:     ENDPROC
1009: 
1010:     PROCEDURE TeclaDEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1011:         LOCAL loc_oPag
1012:         IF INLIST(par_nKeyCode, 13, 9, 115)
1013:             loc_oPag = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1033 a 1080:
1033:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
1034: 
1035:         IF !EMPTY(loc_cValor)
1036:             loc_cSQL = "SELECT dopps FROM SigCdOpd WHERE dopps = " + ;
1037:                        EscaparSQL(loc_cValor)
1038:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpdVal")
1039:             IF loc_nRes > 0
1040:                 SELECT cursor_4c_OpdVal
1041:                 IF !EOF()
1042:                     USE IN cursor_4c_OpdVal
1043:                     RETURN
1044:                 ENDIF
1045:             ENDIF
1046:             IF USED("cursor_4c_OpdVal")
1047:                 USE IN cursor_4c_OpdVal
1048:             ENDIF
1049:         ENDIF
1050: 
1051:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1052:             "SigCdOpd", "cursor_4c_OpdBusca", "dopps", loc_cValor, ;
1053:             "Movimenta" + CHR(231) + CHR(227) + "o")
1054:         IF VARTYPE(loc_oForm) != "O"
1055:             RETURN
1056:         ENDIF
1057:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1058:             SELECT cursor_4c_OpdBusca
1059:             loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
1060:         ELSE
1061:             IF !loc_oForm.this_lAchouRegistro
1062:             loc_oForm.mAddColuna("dopps", "", "Movimenta" + CHR(231) + CHR(227) + "o")
1063:             loc_oForm.Show()
1064:             IF loc_oForm.this_lSelecionou
1065:                 SELECT cursor_4c_OpdBusca
1066:                 loc_oPag.txt_4c_Operacao.Value = ALLTRIM(dopps)
1067:             ENDIF
1068:             ENDIF
1069:         ENDIF
1070:         IF USED("cursor_4c_OpdBusca")
1071:             USE IN cursor_4c_OpdBusca
1072:         ENDIF
1073:         loc_oForm.Release()
1074:     ENDPROC
1075: 
1076:     PROCEDURE TeclaOperacaoI(par_nKeyCode, par_nShiftAltCtrl)
1077:         LOCAL loc_oPag
1078:         IF INLIST(par_nKeyCode, 13, 9)
1079:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1080:             IF loc_oPag.txt_4c_OperacaoI.Value <> 0 AND ;

*-- Linhas 1100 a 1149:
1100:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrOrigem.Value)
1101: 
1102:         IF !EMPTY(loc_cValor)
1103:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1104:                        EscaparSQL(loc_cValor)
1105:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1106:             IF loc_nRes > 0
1107:                 SELECT cursor_4c_GcrVal
1108:                 IF !EOF()
1109:                     loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
1110:                     USE IN cursor_4c_GcrVal
1111:                     RETURN
1112:                 ENDIF
1113:             ENDIF
1114:             IF USED("cursor_4c_GcrVal")
1115:                 USE IN cursor_4c_GcrVal
1116:             ENDIF
1117:         ENDIF
1118: 
1119:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1120:             "SigCdGcr", "cursor_4c_GcrBuscaO", "codigos", loc_cValor, "Grupo")
1121:         IF VARTYPE(loc_oForm) != "O"
1122:             RETURN
1123:         ENDIF
1124:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1125:             SELECT cursor_4c_GcrBuscaO
1126:             loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
1127:             loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
1128:         ELSE
1129:             IF !loc_oForm.this_lAchouRegistro
1130:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1131:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1132:             loc_oForm.Show()
1133:             IF loc_oForm.this_lSelecionou
1134:                 SELECT cursor_4c_GcrBuscaO
1135:                 loc_oPag.txt_4c_GrOrigem.Value   = ALLTRIM(codigos)
1136:                 loc_oPag.txt_4c_DsGrOrigem.Value = ALLTRIM(descrs)
1137:             ENDIF
1138:             ENDIF
1139:         ENDIF
1140:         IF USED("cursor_4c_GcrBuscaO")
1141:             USE IN cursor_4c_GcrBuscaO
1142:         ENDIF
1143:         loc_oForm.Release()
1144:     ENDPROC
1145: 
1146:     PROCEDURE TeclaDsGrOrigem(par_nKeyCode, par_nShiftAltCtrl)
1147:         LOCAL loc_oPag
1148:         IF INLIST(par_nKeyCode, 13, 9, 115)
1149:             loc_oPag = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1169 a 1219:
1169:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
1170: 
1171:         IF !EMPTY(loc_cValor)
1172:             loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
1173:                        EscaparSQL(loc_cValor)
1174:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaOVal")
1175:             IF loc_nRes > 0
1176:                 SELECT cursor_4c_ContaOVal
1177:                 IF !EOF()
1178:                     loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
1179:                     USE IN cursor_4c_ContaOVal
1180:                     RETURN
1181:                 ENDIF
1182:             ENDIF
1183:             IF USED("cursor_4c_ContaOVal")
1184:                 USE IN cursor_4c_ContaOVal
1185:             ENDIF
1186:         ENDIF
1187: 
1188:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1189:             "SigReCtb", "cursor_4c_ContaOBusca", "contas", loc_cValor, ;
1190:             "Conta Origem")
1191:         IF VARTYPE(loc_oForm) != "O"
1192:             RETURN
1193:         ENDIF
1194:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1195:             SELECT cursor_4c_ContaOBusca
1196:             loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(contas)
1197:             loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
1198:         ELSE
1199:             IF !loc_oForm.this_lAchouRegistro
1200:             loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
1201:             loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1202:             loc_oForm.Show()
1203:             IF loc_oForm.this_lSelecionou
1204:                 SELECT cursor_4c_ContaOBusca
1205:                 loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(contas)
1206:                 loc_oPag.txt_4c_DContaO.Value = ALLTRIM(descs)
1207:             ENDIF
1208:             ENDIF
1209:         ENDIF
1210:         IF USED("cursor_4c_ContaOBusca")
1211:             USE IN cursor_4c_ContaOBusca
1212:         ENDIF
1213:         loc_oForm.Release()
1214:     ENDPROC
1215: 
1216:     PROCEDURE TeclaDContaO(par_nKeyCode, par_nShiftAltCtrl)
1217:         LOCAL loc_oPag
1218:         IF INLIST(par_nKeyCode, 13, 9, 115)
1219:             loc_oPag = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1239 a 1288:
1239:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_GrDestino.Value)
1240: 
1241:         IF !EMPTY(loc_cValor)
1242:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
1243:                        EscaparSQL(loc_cValor)
1244:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDVal")
1245:             IF loc_nRes > 0
1246:                 SELECT cursor_4c_GcrDVal
1247:                 IF !EOF()
1248:                     loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
1249:                     USE IN cursor_4c_GcrDVal
1250:                     RETURN
1251:                 ENDIF
1252:             ENDIF
1253:             IF USED("cursor_4c_GcrDVal")
1254:                 USE IN cursor_4c_GcrDVal
1255:             ENDIF
1256:         ENDIF
1257: 
1258:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1259:             "SigCdGcr", "cursor_4c_GcrBuscaD", "codigos", loc_cValor, "Grupo")
1260:         IF VARTYPE(loc_oForm) != "O"
1261:             RETURN
1262:         ENDIF
1263:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1264:             SELECT cursor_4c_GcrBuscaD
1265:             loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
1266:             loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
1267:         ELSE
1268:             IF !loc_oForm.this_lAchouRegistro
1269:             loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1270:             loc_oForm.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1271:             loc_oForm.Show()
1272:             IF loc_oForm.this_lSelecionou
1273:                 SELECT cursor_4c_GcrBuscaD
1274:                 loc_oPag.txt_4c_GrDestino.Value   = ALLTRIM(codigos)
1275:                 loc_oPag.txt_4c_DsGrDestino.Value = ALLTRIM(descrs)
1276:             ENDIF
1277:             ENDIF
1278:         ENDIF
1279:         IF USED("cursor_4c_GcrBuscaD")
1280:             USE IN cursor_4c_GcrBuscaD
1281:         ENDIF
1282:         loc_oForm.Release()
1283:     ENDPROC
1284: 
1285:     PROCEDURE TeclaDsGrDestino(par_nKeyCode, par_nShiftAltCtrl)
1286:         LOCAL loc_oPag
1287:         IF INLIST(par_nKeyCode, 13, 9, 115)
1288:             loc_oPag = THIS.pgf_4c_Paginas.Page1

*-- Linhas 1308 a 1358:
1308:         loc_cValor = ALLTRIM(loc_oPag.txt_4c_ContaD.Value)
1309: 
1310:         IF !EMPTY(loc_cValor)
1311:             loc_cSQL = "SELECT contas, descs FROM SigReCtb WHERE contas = " + ;
1312:                        EscaparSQL(loc_cValor)
1313:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaDVal")
1314:             IF loc_nRes > 0
1315:                 SELECT cursor_4c_ContaDVal
1316:                 IF !EOF()
1317:                     loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
1318:                     USE IN cursor_4c_ContaDVal
1319:                     RETURN
1320:                 ENDIF
1321:             ENDIF
1322:             IF USED("cursor_4c_ContaDVal")
1323:                 USE IN cursor_4c_ContaDVal
1324:             ENDIF
1325:         ENDIF
1326: 
1327:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1328:             "SigReCtb", "cursor_4c_ContaDBusca", "contas", loc_cValor, ;
1329:             "Conta Destino")
1330:         IF VARTYPE(loc_oForm) != "O"
1331:             RETURN
1332:         ENDIF
1333:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1334:             SELECT cursor_4c_ContaDBusca
1335:             loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(contas)
1336:             loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
1337:         ELSE
1338:             IF !loc_oForm.this_lAchouRegistro
1339:             loc_oForm.mAddColuna("contas", "", "C" + CHR(243) + "digo")
1340:             loc_oForm.mAddColuna("descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1341:             loc_oForm.Show()
1342:             IF loc_oForm.this_lSelecionou
1343:                 SELECT cursor_4c_ContaDBusca
1344:                 loc_oPag.txt_4c_ContaD.Value  = ALLTRIM(contas)
1345:                 loc_oPag.txt_4c_DContaD.Value = ALLTRIM(descs)
1346:             ENDIF
1347:             ENDIF
1348:         ENDIF
1349:         IF USED("cursor_4c_ContaDBusca")
1350:             USE IN cursor_4c_ContaDBusca
1351:         ENDIF
1352:         loc_oForm.Release()
1353:     ENDPROC
1354: 
1355:     PROCEDURE TeclaDContaD(par_nKeyCode, par_nShiftAltCtrl)
1356:         LOCAL loc_oPag
1357:         IF INLIST(par_nKeyCode, 13, 9, 115)
1358:             loc_oPag = THIS.pgf_4c_Paginas.Page1


### BO (C:\4c\projeto\app\classes\SIGRECPMBO.prg):
*==============================================================================
* SIGRECPMBO.PRG
* Business Object para Relatorio de Composicao por OP (SIGRECPM)
* Herda de RelatorioBase
*
* Relatorio: Listagem de Composicao por OP (Analitico/Sintetico)
* FRX Analitico: SigReCPM.frx
* FRX Sintetico: SigReC2P.frx
* Tabelas: SigCdNei, SigCdNec, SigCdPro, SigOpPic, SigPdMvf, SigCdEmp
*==============================================================================

DEFINE CLASS SIGRECPMBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtro: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: Movimentacao/Operacao
    this_cOperacao      = ""

    *-- Filtro: Conta Origem
    this_cContaO        = ""
    this_cDContaO       = ""

    *-- Filtro: Conta Destino
    this_cContaD        = ""
    this_cDContaD       = ""

    *-- Filtro: Grupo Origem
    this_cGrOrigem      = ""
    this_cDsGrOrigem    = ""

    *-- Filtro: Grupo Destino
    this_cGrDestino     = ""
    this_cDsGrDestino   = ""

    *-- Filtro: Faixa de Numeros de Operacao
    this_nOperacaoI     = 0
    this_nOperacaoF     = 0

    *-- Filtro: Numero da OP
    this_nOP            = 0

    *-- Tipo de relatorio: 1=Analitico, 2=Sintetico
    this_nTipo          = 1

    *-- Flags e acumuladores (equivalentes a llope, npeso2s, npesos, nqtd do form legado)
    this_lLlope         = .F.
    this_nPeso2s        = 0
    this_nPesos         = 0
    this_nQtd           = 0

    *-- Cursor principal de dados
    this_cCursorDados   = "cursor_4c_SigRecPM"

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_dDtInicial = DATE()
        THIS.this_dDtFinal   = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal e processa cursors intermediarios
    * Replica logica do PROCEDURE processamento do legado SIGRECPM
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQLEmp, loc_nResEmp, loc_cNomeEmpresa
        LOCAL loc_cTitulo, loc_cPeriodo, loc_cSubTit, loc_cNopRange
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_nAno, loc_nMes, loc_nDia
        LOCAL loc_cWhere, loc_cWhereNop1, loc_cWhereNop2
        LOCAL loc_cSQL1, loc_cSQL2, loc_cSQLUnion
        LOCAL loc_nResult
        LOCAL loc_nPesos, loc_nPeso2s, loc_nQtd

        loc_lSucesso = .F.
        TRY
            *-- Busca nome da empresa quando filtrado
            loc_cNomeEmpresa = ""
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQLEmp = "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa)
                loc_nResEmp = SQLEXEC(gnConnHandle, loc_cSQLEmp, "cursor_4c_SigRecPM_Emp")
                IF loc_nResEmp > 0
                    SELECT cursor_4c_SigRecPM_Emp
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(Razas)
                    ENDIF
                    USE IN cursor_4c_SigRecPM_Emp
                ENDIF
            ENDIF

            *-- Monta cabecalho do relatorio (dbCabecalho usado pelo FRX)
            IF USED("dbCabecalho")
                USE IN dbCabecalho
            ENDIF
            CREATE CURSOR dbCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(150), SubTitulo C(80), ;
                                       lCompo L, Total M(4))

            loc_cTitulo = "Listagem de Composi" + CHR(231) + CHR(227) + "o por OP - " + ;
                          IIF(THIS.this_nTipo = 2, "Sint" + CHR(233) + "tico", ;
                              "Anal" + CHR(237) + "tico")

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(THIS.this_cEmpresa), "Geral", ;
                           THIS.this_cEmpresa + " - " + ALLTRIM(THIS.this_cDEmpresa))

            loc_cSubTit = IIF(THIS.this_nOP <> 0, ;
                              "OP: " + ALLTRIM(STR(THIS.this_nOP, 10)), "")

            IF !EMPTY(THIS.this_cOperacao)
                loc_cNopRange = ""
                IF THIS.this_nOperacaoI <> 0
                    loc_cNopRange = ":" + ALLTRIM(STR(THIS.this_nOperacaoI, 6))
                    IF THIS.this_nOperacaoF <> 0
                        loc_cNopRange = loc_cNopRange + " " + CHR(224) + " " + ;
                                        ALLTRIM(STR(THIS.this_nOperacaoF, 6))
                    ENDIF
                ENDIF
                loc_cSubTit = loc_cSubTit + IIF(!EMPTY(loc_cSubTit), " ", "") + ;
                              "Movimenta" + CHR(231) + CHR(227) + "o (" + ;
                              ALLTRIM(THIS.this_cOperacao) + loc_cNopRange + ")"
            ENDIF

            INSERT INTO dbCabecalho (NomeEmpresa, Titulo, Periodo, SubTitulo) ;
                   VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cSubTit)

            *-- Datas para o WHERE: inicio normal, fim com 23:59:59 para cobrir dia inteiro
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_nAno   = YEAR(THIS.this_dDtFinal)
            loc_nMes   = MONTH(THIS.this_dDtFinal)
            loc_nDia   = DAY(THIS.this_dDtFinal)
            loc_cDtFim = "'" + PADL(LTRIM(STR(loc_nAno)), 4, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nMes)), 2, "0") + "-" + ;
                         PADL(LTRIM(STR(loc_nDia)), 2, "0") + " 23:59:59'"

            *-- WHERE base (compartilhado pelas duas partes do UNION)
            loc_cWhere = " WHERE b.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim
            IF !EMPTY(THIS.this_cEmpresa)
                loc_cWhere = loc_cWhere + " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)
            ENDIF
            IF !EMPTY(THIS.this_cOperacao)
                loc_cWhere = loc_cWhere + " AND a.Dopps = " + EscaparSQL(THIS.this_cOperacao)
            ENDIF
            IF THIS.this_nOperacaoI <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps >= " + ALLTRIM(STR(THIS.this_nOperacaoI))
            ENDIF
            IF THIS.this_nOperacaoF <> 0
                loc_cWhere = loc_cWhere + " AND a.Numps <= " + ALLTRIM(STR(THIS.this_nOperacaoF))
            ENDIF
            IF !EMPTY(THIS.this_cGrOrigem)
                loc_cWhere = loc_cWhere + " AND b.GrupoOs = " + EscaparSQL(THIS.this_cGrOrigem)
            ENDIF
            IF !EMPTY(THIS.this_cContaO)
                loc_cWhere = loc_cWhere + " AND b.ContaOs = " + EscaparSQL(THIS.this_cContaO)
            ENDIF
            IF !EMPTY(THIS.this_cGrDestino)
                loc_cWhere = loc_cWhere + " AND b.GrupoDs = " + EscaparSQL(THIS.this_cGrDestino)
            ENDIF
            IF !EMPTY(THIS.this_cContaD)
                loc_cWhere = loc_cWhere + " AND b.ContaDs = " + EscaparSQL(THIS.this_cContaD)
            ENDIF

            *-- WHERE para parte 1: filtra por Nops (OP direta)
            loc_cWhereNop1 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop1 = loc_cWhereNop1 + ;
                                 " AND a.Nops = " + ALLTRIM(STR(THIS.this_nOP))
            ENDIF

            *-- WHERE para parte 2: filtra por Nenvs (sub-ordens da OP)
            loc_cWhereNop2 = loc_cWhere
            IF THIS.this_nOP <> 0
                loc_cWhereNop2 = loc_cWhereNop2 + ;
                                 " AND (a.Nenvs = " + ALLTRIM(STR(THIS.this_nOP)) + ;
                                 " AND a.Nops <> " + ALLTRIM(STR(THIS.this_nOP)) + ")"
            ENDIF

            *-- Parte 1 do UNION: Nops como OP direta (a.Nops AS Nenvs)
            loc_cSQL1 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nops AS Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL1 = loc_cSQL1 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL1 = loc_cSQL1 + ;
                        " FROM SigCdNei a"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL1 = loc_cSQL1 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL1 = loc_cSQL1 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL1 = loc_cSQL1 + loc_cWhereNop1

            *-- Parte 2 do UNION: Nenvs real (sub-ordens)
            loc_cSQL2 = "SELECT DISTINCT 1 AS Tipo, a.emps, a.dopps, a.numps," + ;
                        " b.CidChaves, a.Nenvs, a.EmpDnPs, b.Datas,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " b.Grupoos, b.Contaos, b.grupods, b.contads,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " a.servicos, 0 AS Nops, a.cmats, c.dpros, a.Qtds,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " c.cunis, a.peso2s, c.cunips, a.Pesos,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(d.Cpros,'') AS Cpros, ISNULL(d.NopMaes,0) AS NopMaes,"
            loc_cSQL2 = loc_cSQL2 + ;
                        " ISNULL(e.dpros,'') AS DescPro, f.qtds AS Qtd"
            loc_cSQL2 = loc_cSQL2 + ;
                        " FROM SigCdNei a"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdNec b ON a.empdnps = b.empdnps"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigCdPro c ON a.cmats = c.cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigOpPic d ON a.Nops = d.Nops"
            loc_cSQL2 = loc_cSQL2 + ;
                        " LEFT JOIN SigCdPro e ON d.Cpros = e.Cpros"
            loc_cSQL2 = loc_cSQL2 + ;
                        " INNER JOIN SigPdMvf f ON a.EmpDnPs = f.EmpDnPs"
            loc_cSQL2 = loc_cSQL2 + loc_cWhereNop2

            loc_cSQLUnion = loc_cSQL1 + " UNION " + loc_cSQL2

            *-- Executa query principal no SQL Server
            IF USED("TmpNensi")
                USE IN TmpNensi
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLUnion, "TmpNensi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE

            *-- Agrupa por material/OP para eliminar duplicatas e calcular totais
            IF USED("crNensi")
                USE IN crNensi
            ENDIF
            SELECT Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips, ;
                   MAX(cidchaves) AS cidchaves, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds, MAX(qtd) AS qtd ;
                   FROM TmpNensi ;
                   GROUP BY Tipo, Nenvs, dopps, cpros, descpro, cmats, dpros, cunis, cunips ;
                   INTO CURSOR crNensi READWRITE

            SELECT crNensi
            INDEX ON STR(nenvs, 10) + STR(Tipo) + cidchaves + dopps + cmats TAG Mov
            GO TOP

            *-- Agrega por material para calcular totais de peso
            IF USED("crNensi2")
                USE IN crNensi2
            ENDIF
            SELECT 2 AS Tipo, nenvs, cmats, MAX(pesos) AS pesos, ;
                   MAX(peso2s) AS peso2s, MAX(qtds) AS Qtds ;
                   FROM crNensi ;
                   GROUP BY Nenvs, cmats ;
                   INTO CURSOR crNensi2 READWRITE

            SELECT crNensi2
            loc_nPesos  = 0
            loc_nPeso2s = 0
            SUM pesos, peso2s TO loc_nPesos, loc_nPeso2s
            THIS.this_nPesos  = loc_nPesos
            THIS.this_nPeso2s = loc_nPeso2s

            *-- Agrega por OP para calcular total de quantidade
            IF USED("crNensi3")
                USE IN crNensi3
            ENDIF
            SELECT 3 AS Tipo, nenvs, MAX(qtd) AS Qtd ;
                   FROM crNensi ;
                   GROUP BY Nenvs ;
                   INTO CURSOR crNensi3 READWRITE

            SELECT crNensi3
            loc_nQtd = 0
            SUM Qtd TO loc_nQtd
            THIS.this_nQtd = loc_nQtd

            *-- Modo Sintetico: reagrupa por material eliminando detalhe de OP
            IF THIS.this_nTipo = 2
                IF USED("crTmpNensi")
                    USE IN crTmpNensi
                ENDIF
                SELECT 9 AS Tipo, '' AS Dopps, cmats, dpros, cunips, cunis, ;
                       0 AS Qtd, SUM(qtds) AS Qtds, SUM(pesos) AS pesos, ;
                       SUM(peso2s) AS peso2s ;
                       FROM crNensi ;
                       GROUP BY cmats, dpros, cunis, cunips ;
                       ORDER BY cmats ;
                       INTO CURSOR crTmpNensi READWRITE

                SELECT crTmpNensi
                GO TOP
            ELSE
                SELECT crNensi
                GO TOP
            ENDIF

            THIS.this_lLlope = EMPTY(THIS.this_cOperacao)

            loc_lSucesso = .T.
            ENDIF  && loc_nResult >= 1
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") PREVIEW NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime o relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nTipo = 1
                    REPORT FORM (gc_4c_CaminhoReports + "SigReCPM.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (gc_4c_CaminhoReports + "SigReC2P.frx") ;
                           TO PRINTER PROMPT NOCONSOLE
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir - SIGRECPMBO")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * Util para restaurar conjuntos de filtros salvos (presets)
    * O cursor deve conter colunas com os mesmos nomes dos filtros do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Empresa
            IF TYPE(par_cAliasCursor + ".Emps") != "U"
                THIS.this_cEmpresa = TratarNulo(Emps, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DEmps") != "U"
                THIS.this_cDEmpresa = TratarNulo(DEmps, "C")
            ENDIF

            *-- Periodo
            IF TYPE(par_cAliasCursor + ".DtIni") != "U"
                THIS.this_dDtInicial = TratarNulo(DtIni, "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DtFim") != "U"
                THIS.this_dDtFinal = TratarNulo(DtFim, "D")
            ENDIF

            *-- Operacao
            IF TYPE(par_cAliasCursor + ".Dopps") != "U"
                THIS.this_cOperacao = TratarNulo(Dopps, "C")
            ENDIF

            *-- Contas
            IF TYPE(par_cAliasCursor + ".Contaos") != "U"
                THIS.this_cContaO = TratarNulo(Contaos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaO") != "U"
                THIS.this_cDContaO = TratarNulo(DContaO, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Contads") != "U"
                THIS.this_cContaD = TratarNulo(Contads, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DContaD") != "U"
                THIS.this_cDContaD = TratarNulo(DContaD, "C")
            ENDIF

            *-- Grupos
            IF TYPE(par_cAliasCursor + ".Grupoos") != "U"
                THIS.this_cGrOrigem = TratarNulo(Grupoos, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoOs") != "U"
                THIS.this_cDsGrOrigem = TratarNulo(DGrupoOs, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Grupods") != "U"
                THIS.this_cGrDestino = TratarNulo(Grupods, "C")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DGrupoDs") != "U"
                THIS.this_cDsGrDestino = TratarNulo(DGrupoDs, "C")
            ENDIF

            *-- Faixa de Operacao
            IF TYPE(par_cAliasCursor + ".NumPsI") != "U"
                THIS.this_nOperacaoI = TratarNulo(NumPsI, "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".NumPsF") != "U"
                THIS.this_nOperacaoF = TratarNulo(NumPsF, "N")
            ENDIF

            *-- OP
            IF TYPE(par_cAliasCursor + ".Nops") != "U"
                THIS.this_nOP = TratarNulo(Nops, "N")
            ENDIF

            *-- Tipo
            IF TYPE(par_cAliasCursor + ".TipoRel") != "U"
                THIS.this_nTipo = TratarNulo(TipoRel, "N")
                IF THIS.this_nTipo < 1 OR THIS.this_nTipo > 2
                    THIS.this_nTipo = 1
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor - SIGRECPMBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao NAO aplicavel para BOs de relatorio
    * Relatorios nao persistem registros; existem apenas para gerar saida.
    * Sobrescreve para garantir que chamadas indevidas vindas de codigo
    * generico (sweepers, framework) falhem com mensagem clara e auditavel.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inclus" + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao NAO aplicavel para BOs de relatorio
    * (mesma justificativa de Inserir())
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + ;
                                  CHR(227) + "o n" + CHR(227) + "o aplic" + CHR(225) + "vel para o relat" + ;
                                  CHR(243) + "rio de Composi" + CHR(231) + CHR(227) + "o por OP"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do conjunto de filtros atual
    * Relatorios nao tem chave de registro - usa-se o hash dos filtros
    * para identificar a execucao (util em auditoria/log).
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECPM|" + ;
                     ALLTRIM(THIS.this_cEmpresa) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cOperacao) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoI, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOperacaoF, 10)) + "|" + ;
                     ALLTRIM(THIS.this_cContaO) + "|" + ;
                     ALLTRIM(THIS.this_cContaD) + "|" + ;
                     ALLTRIM(THIS.this_cGrOrigem) + "|" + ;
                     ALLTRIM(THIS.this_cGrDestino) + "|" + ;
                     ALLTRIM(STR(THIS.this_nOP, 10)) + "|" + ;
                     ALLTRIM(STR(THIS.this_nTipo, 2))
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na auditoria
    * par_cOperacao: "VISUALIZAR" ou "IMPRIMIR"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cChave, loc_cUsuario
        LOCAL loc_cOperacao, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cOperacao = IIF(EMPTY(par_cOperacao), "EXECUTAR", UPPER(ALLTRIM(par_cOperacao)))

            loc_cChave    = THIS.ObterChavePrimaria()
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                                gc_4c_UsuarioLogado, "SYSTEM")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Chave, Usuario, DataHora)" + ;
                       " VALUES (" + EscaparSQL("SIGRECPM") + ", " + ;
                       EscaparSQL(loc_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar auditoria do relat" + ;
                                          CHR(243) + "rio"
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nunca deve interromper o relatorio; apenas registra erro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

