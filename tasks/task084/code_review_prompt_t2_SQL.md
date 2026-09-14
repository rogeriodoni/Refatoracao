# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, CIDCHAVES, FPAGS, EMPS, EMPDOPNCS, GRUPOS, NOPERS, OPERS, LX, EMPDOPNUMS, NCHEQUES, IMPVERSOS, IMPCPCHQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, CIDCHAVES, FPAGS, EMPS, EMPDOPNCS, GRUPOS, NOPERS, OPERS, LX, EMPDOPNUMS, NCHEQUES, IMPVERSOS, IMPCPCHQS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: TIPOS, CIDCHAVES, FPAGS, EMPS, EMPDOPNCS, GRUPOS, NOPERS, OPERS, LX, EMPDOPNUMS, NCHEQUES, IMPVERSOS, IMPCPCHQS

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
  ControlSource = "crSigCqChi.favos"
  ControlSource = "crpar.bancos"
  ControlSource = "crpar.agencias"
  ControlSource = "crpar.numeros"
  ControlSource = "crpar.contas"
  ControlSource = "crpar.valos"
  ControlSource = "crpar.vencs"
  ControlSource = "crSigCqChi.NCopias"
  ControlSource = "crSigCqChi.Versos"
Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom ReadWrite
Select CrTmpCfCom
=Seek( _Empr, 'CrSigCdEmp','Cemps' )
lcSql = [Update SigCqChi Set Emitidos = ?llEmit, Favos = ']+CrSigCqChi.Favos+[', nEmissoes = ]+Str(CrSigCqChi.nEmissoes)+[ Where CidChaves = ']+CrSigCqChi.CidChaves+[']
=ThisForm.Podatamgr.Sqlexecute(lcSql,'')
=Seek( _Empr, 'crSigCdEmp','Cemps' )
Select CrTmpParam
lcQuery = [Select Descrs ] + ;
		    [From SigOpFpp ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalFPag]) < 1)
Select * From TmpConta Where Flag ;
Select TmpTmp
	lcWher = [Select Emps, Dopcs, Numcs, Nopers, CidChaves From SigMvCcr Where Emps=']+lcEmp+['And ]+;
	lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'CrMccr')
	Select CrMccr
		lcWher = [Select '1' as Ordem, Opers, Titulos, Vencs, Contems, Grupos, ]+;
				 [From SigMvCcr Where EmpDopncs = ?lcEDN And Not Tipos = "O" Union all ]+;
		         [Select '2' as Ordem, Opers, Titulos, Vencs, Contems, Grupos, ]+;
				 [From SigMvCcr Where EmpDopncs = ?lcEDN And Tipos = "O" And Grupos <> ?lcGrupo Order By 1,2,3,4,5,6,7]
		lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'Tmp')
		lcWher = [Select '1' as Ordem, Opers, Titulos, Vencs, Contems, Grupos, ]+;
				[From SigMvCcr Where Emps=']+lcEmp+['And Nopers=]+Str(lnNopers,9)+[ ]+;
		lnErro = ThisForm.podatamgr.SqlExecute(lcWher,'Tmp')
	Select Tmp
				Insert Into TmpConta2 (Titulo, Vencimento, Fornecedor, DescriForn, ;
					Select TmpConta2
					Insert Into TmpConta2 (Titulo, Vencimento, Despesa, DescriDesp, Valor, ;
		Select Tmp
	Select TmpTmp
Select TmpConta2
	Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom ReadWrite
	Select CrTmpCfCom
	=Seek( _Empr , 'crSigCdEmp', 'Cemps' )
	lcSql = [Update SigCqChi Set ImpVersos = 1 Where CidChaves = ']+CrSigCqChi.CidChaves+[']
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'')
lcQueryChi = [Select * From SigCqChi Where EmpDopNums = ?lcEDN ]+;
lcQueryEmp = [Select Cemps,Cidas From SigCdEmp ]
Select CrSigCdEmp
Select CrSigCqChi
Select CrPar
=Seek(CrSigCqChi.Bancos + CrSigCqChi.Agencias + CrSigCqChi.ncontas + CrSigCqChi.nCheques)
	lcSql = [Update SigCqChi Set versos = ']+This.Value+[' Where CidChaves = ']+CrSigCqChi.CidChaves+[']
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'')
	lcSql = [Update SigCqChi Set Emitidos = ?llEmit, Favos = ']+CrSigCqChi.Favos+[', nEmissoes = ]+Str(CrSigCqChi.nEmissoes)+[ Where CidChaves = ']+CrSigCqChi.CidChaves+[']
	=ThisForm.Podatamgr.Sqlexecute(lcSql,'')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg) - TRECHOS RELEVANTES PARA PASS SQL (1562 linhas total):

*-- Linhas 871 a 903:
871:                 MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
872:                         CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
873:             ELSE
874:             loc_cSQL      = "SELECT ImpCheqs FROM SigCdPam"
875: 
876:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
877:                 SELECT cursor_4c_Param
878:                 GO TOP
879:                 loc_nImpCheqs = NVL(ImpCheqs, 1)
880:                 USE IN cursor_4c_Param
881:             ENDIF
882: 
883:             MsgInfo("Posicione o cheque na impressora...", "IMPRIME CHEQUE")
884: 
885:             loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
886:                        "WHERE Tipos = 'Impressora de Cheque'"
887:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
888:                 SELECT cursor_4c_CfCom
889:                 GO TOP
890:                 IF !EOF()
891:                     IF !THIS.obj_4c_OModem.portopen
892:                         THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
893:                         THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
894:                         THIS.obj_4c_OModem.Inputlen = 1
895:                     ENDIF
896:                 ENDIF
897:                 USE IN cursor_4c_CfCom
898:                 THIS.obj_4c_OModem.PortOpen = .T.
899: 
900:                 IF loc_nImpCheqs = 2
901:                     loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos * 100, "@L 99999999999999"))
902:                     loc_cData  = TRANSFORM(DAY(loc_oBO.this_dParVencs),   "@L 99") + ;
903:                                  TRANSFORM(MONTH(loc_oBO.this_dParVencs), "@L 99") + ;

*-- Linhas 969 a 1001:
969:                     MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
970:                             CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
971:                 ELSE
972:                 loc_cSQL = "SELECT ImpCheqs FROM SigCdPam"
973:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
974:                     SELECT cursor_4c_Param
975:                     GO TOP
976:                     loc_nImpCheqs = NVL(ImpCheqs, 1)
977:                     USE IN cursor_4c_Param
978:                 ENDIF
979: 
980:                 MsgInfo("Posicione o cheque na impressora para impress" + CHR(227) + "o do verso...", ;
981:                         "IMPRIME CHEQUE")
982: 
983:                 loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
984:                            "WHERE Tipos = 'Impressora de Cheque'"
985:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
986:                     SELECT cursor_4c_CfCom
987:                     GO TOP
988:                     IF !EOF()
989:                         IF !THIS.obj_4c_OModem.portopen
990:                             THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
991:                             THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
992:                             THIS.obj_4c_OModem.Inputlen = 1
993:                         ENDIF
994:                     ENDIF
995:                     USE IN cursor_4c_CfCom
996:                     THIS.obj_4c_OModem.PortOpen = .T.
997: 
998:                     loc_cVerso = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
999:                                      THIS.obj_4c_Get_Verso.Value, ;
1000:                                      loc_oBO.this_cVersos)
1001: 

*-- Linhas 1069 a 1251:
1069:                 _Mes = fMesExtenso(loc_oBO.this_dParVencs)
1070:             ENDIF
1071: 
1072:             loc_cSQL = "SELECT GrupoRecs, ContaRecs FROM SigCdPam"
1073:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
1074:                 SELECT cursor_4c_Pam
1075:                 GO TOP
1076:                 loc_cGrupoRecs = NVL(ALLTRIM(GrupoRecs), "")
1077:                 loc_cContaRecs = NVL(ALLTRIM(ContaRecs), "")
1078:                 USE IN cursor_4c_Pam
1079:             ENDIF
1080: 
1081:             loc_cPagDesc = ""
1082:             IF !EMPTY(ALLTRIM(loc_oBO.this_cParFPags))
1083:                 loc_cSQL = "SELECT Descrs FROM SigOpFpp " + ;
1084:                            "WHERE FPags = " + EscaparSQL(loc_oBO.this_cParFPags) + ;
1085:                            " AND ImpCpChqs = 2"
1086:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPag") > 0
1087:                     SELECT cursor_4c_FPag
1088:                     GO TOP
1089:                     IF !EOF()
1090:                         loc_cPagDesc = NVL(ALLTRIM(Descrs), "")
1091:                     ENDIF
1092:                     USE IN cursor_4c_FPag
1093:                 ENDIF
1094:             ENDIF
1095: 
1096:             SET NULL ON
1097:             CREATE CURSOR TmpConta2 (Titulo C(10) NULL, Vencimento D(8) NULL, ;
1098:                 Fornecedor C(10) NULL, DescriForn C(50) NULL, Despesa C(10) NULL, ;
1099:                 DescriDesp C(50) NULL, Valor N(12,2) NULL, Moeda C(3) NULL, ;
1100:                 Hists C(40) NULL, Hist2s C(40) NULL, Imprime L(1) NULL, ;
1101:                 Emps C(3) NULL, Pagamento C(6) NULL, Fim L(1) NULL, ;
1102:                 bGrupos C(10) NULL, Numcs N(6,0) NULL, Tipos C(1) NULL, ;
1103:                 Ordem C(1) NULL, Opers C(1) NULL, Vencs D(8) NULL, ;
1104:                 nbgrupos C(30) NULL, CodSegs C(10) NULL, ;
1105:                 OrdCopChs N(3,0) NULL, ChDescrs C(30) NULL)
1106:             SET NULL OFF
1107: 
1108:             loc_cSQL = "SELECT '1' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
1109:                        "Contas, Valors, Moedas, Hists, Hist2s, Emps, bgrupos, Numcs, " + ;
1110:                        "Tipos, OrdCopChs " + ;
1111:                        "FROM SigMvCcr " + ;
1112:                        "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
1113:                        " AND NOT Tipos = 'O' " + ;
1114:                        "UNION ALL " + ;
1115:                        "SELECT '2' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
1116:                        "Contas, (Valors + Valocurs) * -1 AS Valors, Moedas, Hists, Hist2s, " + ;
1117:                        "Emps, bgrupos, Numcs, Tipos, OrdCopChs " + ;
1118:                        "FROM SigMvCcr " + ;
1119:                        "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
1120:                        " AND Tipos = 'O' AND Grupos <> " + EscaparSQL(loc_cGrupoRecs) + ;
1121:                        " ORDER BY 1, 2, 3, 4, 5, 6, 7"
1122: 
1123:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvs") < 1
1124:                 IF USED("TmpConta2")
1125:                     USE IN TmpConta2
1126:                 ENDIF
1127:                 MsgErro("Falha ao carregar movimentos para impress" + CHR(227) + "o de c" + ;
1128:                         CHR(243) + "pia.", "Erro")
1129:             ELSE
1130:                 SELECT cursor_4c_Mvs
1131:                 GO TOP
1132:                 loc_lcChv = ""
1133:                 loc_lnCnt = 0
1134: 
1135:                 DO WHILE !EOF("cursor_4c_Mvs")
1136:                     SELECT cursor_4c_Mvs
1137:                     loc_cHist  = STRTRAN(STRTRAN(cursor_4c_Mvs.Hists,  CHR(13), " "), CHR(10), " ")
1138:                     loc_cHist2 = STRTRAN(STRTRAN(cursor_4c_Mvs.Hist2s, CHR(13), " "), CHR(10), " ")
1139: 
1140:                     IF cursor_4c_Mvs.Grupos <> loc_cGrupoRecs AND ;
1141:                        cursor_4c_Mvs.Contas <> loc_cContaRecs
1142: 
1143:                         loc_lcFornece = ""
1144:                         loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
1145:                                    "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contems)
1146:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliF") > 0
1147:                             SELECT cursor_4c_CliF
1148:                             GO TOP
1149:                             IF !EOF()
1150:                                 loc_lcFornece = NVL(ALLTRIM(Rclis), "")
1151:                             ENDIF
1152:                             USE IN cursor_4c_CliF
1153:                         ENDIF
1154: 
1155:                         loc_lcCliente = ""
1156:                         loc_lcCodSeg  = ""
1157:                         loc_cSQL = "SELECT Rclis, CodSegs FROM SigCdCli " + ;
1158:                                    "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contas)
1159:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliC") > 0
1160:                             SELECT cursor_4c_CliC
1161:                             GO TOP
1162:                             IF !EOF()
1163:                                 loc_lcCliente = NVL(ALLTRIM(Rclis), "")
1164:                                 loc_lcCodSeg  = NVL(ALLTRIM(CodSegs), "")
1165:                             ENDIF
1166:                             USE IN cursor_4c_CliC
1167:                         ENDIF
1168: 
1169:                         loc_lcPagto = ""
1170:                         loc_lcEDNI  = loc_oBO.this_cEmps + loc_oBO.this_cDopes + ;
1171:                                       STR(loc_oBO.this_nNumes, 6)
1172:                         loc_cSQL = "SELECT EmpDopNums FROM SigCdPgr " + ;
1173:                                    "WHERE EmpDopNums = " + EscaparSQL(loc_lcEDNI)
1174:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") > 0
1175:                             SELECT cursor_4c_Pgr
1176:                             GO TOP
1177:                             IF !EOF()
1178:                                 loc_lcPagto = STR(loc_oBO.this_nNumes, 6)
1179:                             ENDIF
1180:                             USE IN cursor_4c_Pgr
1181:                         ENDIF
1182: 
1183:                         SELECT cursor_4c_Mvs
1184: 
1185:                         IF cursor_4c_Mvs.Opers = "C"
1186:                             INSERT INTO TmpConta2 (Titulo, Vencimento, Fornecedor, DescriForn, ;
1187:                                 Despesa, DescriDesp, Valor, Moeda, Imprime, Emps, ;
1188:                                 Hists, Hist2s, Pagamento, bGrupos, Numcs, Tipos, ;
1189:                                 Ordem, Opers, Vencs, CodSegs, OrdCopChs, ChDescrs) ;
1190:                             VALUES (cursor_4c_Mvs.Titulos, NVL(cursor_4c_Mvs.Vencs, {}), ;
1191:                                 cursor_4c_Mvs.Contems, loc_lcFornece, ;
1192:                                 cursor_4c_Mvs.Contas, loc_lcCliente, ;
1193:                                 cursor_4c_Mvs.Valors, cursor_4c_Mvs.Moedas, ;
1194:                                 IIF(loc_lcChv <> cursor_4c_Mvs.Titulos + ;
1195:                                     DTOC(cursor_4c_Mvs.Vencs) + cursor_4c_Mvs.Contems, .T., .F.), ;
1196:                                 cursor_4c_Mvs.Emps, loc_cHist, loc_cHist2, ;
1197:                                 loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
1198:                                 cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
1199:                                 cursor_4c_Mvs.Vencs, loc_lcCodSeg, ;
1200:                                 NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
1201:                         ELSE
1202:                             IF loc_lnCnt = 0 AND cursor_4c_Mvs.Tipos <> "O"
1203:                                 SELECT TmpConta2
1204:                                 GO BOTTOM
1205:                                 REPLACE Despesa    WITH cursor_4c_Mvs.Contas, ;
1206:                                         DescriDesp WITH loc_lcCliente, ;
1207:                                         Hists      WITH loc_cHist, ;
1208:                                         Hist2s     WITH loc_cHist2, ;
1209:                                         Valor      WITH cursor_4c_Mvs.Valors, ;
1210:                                         ChDescrs   WITH loc_cPagDesc
1211:                             ELSE
1212:                                 INSERT INTO TmpConta2 (Titulo, Vencimento, Despesa, DescriDesp, ;
1213:                                     Valor, Moeda, Hists, Hist2s, Imprime, Emps, ;
1214:                                     Pagamento, bGrupos, Numcs, Tipos, Ordem, Opers, ;
1215:                                     Vencs, OrdCopChs, ChDescrs) ;
1216:                                 VALUES (cursor_4c_Mvs.Titulos, cursor_4c_Mvs.Vencs, ;
1217:                                     cursor_4c_Mvs.Contas, loc_lcCliente, ;
1218:                                     ABS(cursor_4c_Mvs.Valors), cursor_4c_Mvs.Moedas, ;
1219:                                     loc_cHist, loc_cHist2, .F., cursor_4c_Mvs.Emps, ;
1220:                                     loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
1221:                                     cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
1222:                                     cursor_4c_Mvs.Vencs, NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
1223:                             ENDIF
1224:                             loc_lnCnt = loc_lnCnt + 1
1225:                         ENDIF
1226:                         loc_lcChv = cursor_4c_Mvs.Titulos + DTOC(cursor_4c_Mvs.Vencs) + ;
1227:                                     cursor_4c_Mvs.Contems
1228:                     ENDIF
1229: 
1230:                     SELECT cursor_4c_Mvs
1231:                     SKIP
1232:                 ENDDO
1233: 
1234:                 USE IN cursor_4c_Mvs
1235: 
1236:                 SELECT TmpConta2
1237:                 GO BOTTOM
1238:                 REPLACE Fim WITH .T.
1239:                 INDEX ON STR(NVL(OrdCopChs, 0), 3) + Titulo + ;
1240:                          DTOS(NVL(Vencimento, {})) + Ordem + Opers TAG Impressao
1241:                 GO TOP
1242: 
1243:                 IF THIS.enviaimp
1244:                     REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") TO PRINT PROMPT NOCONSOLE
1245:                 ELSE
1246:                     REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") PREVIEW NOCONSOLE
1247:                 ENDIF
1248: 
1249:                 IF USED("TmpConta2")
1250:                     USE IN TmpConta2
1251:                 ENDIF

*-- Linhas 1478 a 1496:
1478: 
1479:     *==========================================================================
1480:     * BtnSalvarClick - Grava favorecido e verso no banco (SigCqChi)
1481:     * Sincroniza form->BO e executa UPDATE via SalvarStatusSaida + AtualizarVerso.
1482:     *==========================================================================
1483:     PROCEDURE BtnSalvarClick()
1484:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1485:         TRY
1486:             loc_oBO = THIS.this_oBusinessObject
1487:             IF VARTYPE(loc_oBO) != "O"
1488:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1489:             ELSE
1490:                 IF !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
1491:                     MsgAviso("Cheque em modo somente leitura. " + ;
1492:                              "Acione Alterar antes de salvar.", "Aviso")
1493:                 ELSE
1494:                     *-- Form -> BO (favorecido e verso)
1495:                     THIS.FormParaBO()
1496: 


### BO (C:\4c\projeto\app\classes\SigReEchBO.prg):
*------------------------------------------------------------------------------
* SigReEchBO.prg - Business Object para Emissao de Cheque
* Tabela principal: SIGCQCHI
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS SigReEchBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela      = "SigCqChi"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    *-- Propriedades de SIGCQCHI (cheque)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""    && cidchaves  char(20) - chave primaria
    this_cEmpDopNums  = ""    && empdopnums char(29) - chave composta emps+dopes+numes
    this_cEmps        = ""    && emps       char(3)  - empresa
    this_cDopes       = ""    && dopes      char(20) - documento operacao
    this_nNumes       = 0     && numes      numeric(6,0)
    this_cBancos      = ""    && bancos     char(3)
    this_cAgencias    = ""    && agencias   char(4)
    this_cContas      = ""    && contas     char(10)
    this_cNContas     = ""    && ncontas    char(10) - numero da conta
    this_cNCheques    = ""    && ncheques   char(6)  - numero do cheque
    this_cFavos       = ""    && favos      char(40) - favorecido
    this_nValors      = 0     && valors     numeric(11,2)
    this_dVencs       = {}    && vencs      datetime - vencimento
    this_cVersos      = ""    && versos     text     - verso do cheque
    this_lEmitidos    = .F.   && emitidos   bit      - se ja foi emitido
    this_nNEmissoes   = 0     && nemissoes  numeric(2,0) - numero de emissoes
    this_nNCopias     = 0     && ncopias    numeric(6,0) - numero de copias
    this_nImpVersos   = 0     && impversos  numeric(1,0) - se verso foi impresso
    this_lCancelas    = .F.   && cancelas   bit      - se cancelado
    this_cGrupos      = ""    && grupos     char(10)
    this_dDatas       = {}    && datas      datetime
    this_cJustCanc    = ""    && justcanc   text     - justificativa cancelamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigMvPar (parcela vinculada ao cheque - cursor CrPar)
    *--------------------------------------------------------------------------
    this_cParBancos   = ""    && bancos    char(3)
    this_cParAgencias = ""    && agencias  char(4)
    this_cParContas   = ""    && contas    char(10)
    this_cParNumeros  = ""    && numeros   char(6)
    this_nParValos    = 0     && valos     numeric(11,2) - valor da parcela
    this_dParVencs    = {}    && vencs     datetime      - vencimento da parcela
    this_cParFPags    = ""    && fpags     char(12)      - forma de pagamento

    *--------------------------------------------------------------------------
    *-- Propriedades de SigCdEmp (empresa - cursor CrSigCdEmp)
    *--------------------------------------------------------------------------
    this_cCidEmps     = ""    && cidas char(30) - cidade da empresa

    *--------------------------------------------------------------------------
    *-- Parametros e estado de execucao do formulario
    *--------------------------------------------------------------------------
    this_cOpEscolha    = ""   && INSERIR, ALTERAR - modo do form ao abrir
    this_cNchequeParam = ""   && _ncheque filtro inicial (opcional)
    this_lEnviaImp     = .F.  && .T.=imprimir fisicamente, .F.=preview em video
    this_cPeAntValue   = ""   && valor anterior do campo verso (para detectar mudanca)

    *--------------------------------------------------------------------------
    PROCEDURE Init
        THIS.this_cTabela     = "SigCqChi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigCqChi para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
            THIS.this_cEmpDopNums = NVL(ALLTRIM(empdopnums), "")
            THIS.this_cEmps       = NVL(ALLTRIM(emps), "")
            THIS.this_cDopes      = NVL(ALLTRIM(dopes), "")
            THIS.this_nNumes      = NVL(numes, 0)
            THIS.this_cBancos     = NVL(ALLTRIM(bancos), "")
            THIS.this_cAgencias   = NVL(ALLTRIM(agencias), "")
            THIS.this_cContas     = NVL(ALLTRIM(contas), "")
            THIS.this_cNContas    = NVL(ALLTRIM(ncontas), "")
            THIS.this_cNCheques   = NVL(ALLTRIM(ncheques), "")
            THIS.this_cFavos      = NVL(ALLTRIM(favos), "")
            THIS.this_nValors     = NVL(valors, 0)
            THIS.this_dVencs      = NVL(vencs, {})
            THIS.this_cVersos     = NVL(versos, "")
            IF VARTYPE(emitidos) = "L"
                THIS.this_lEmitidos = emitidos
            ELSE
                THIS.this_lEmitidos = IIF(NVL(emitidos, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_nNEmissoes  = NVL(nemissoes, 0)
            THIS.this_nNCopias    = NVL(ncopias, 0)
            THIS.this_nImpVersos  = NVL(impversos, 0)
            IF VARTYPE(cancelas) = "L"
                THIS.this_lCancelas = cancelas
            ELSE
                THIS.this_lCancelas = IIF(NVL(cancelas, 0) = 1, .T., .F.)
            ENDIF
            THIS.this_cGrupos     = NVL(ALLTRIM(grupos), "")
            THIS.this_dDatas      = NVL(datas, {})
            THIS.this_cJustCanc   = NVL(justcanc, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carrega cheque de SigCqChi por emps+dopes+numes
    *--------------------------------------------------------------------------
    FUNCTION CarregarDados(par_cEmps, par_cDopes, par_nNumes, par_cNcheque)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEDN, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cEDN = par_cEmps + PADR(par_cDopes, 20) + STR(par_nNumes, 6)
            loc_cSQL = "SELECT agencias, bancos, cancelas, contas, datas, " + ;
                       "dopes, emitidos, emps, favos, grupos, ncheques, " + ;
                       "ncontas, ncopias, nemissoes, numes, valors, vencs, " + ;
                       "versos, cidchaves, empdopnums, justcanc, impversos " + ;
                       "FROM SigCqChi " + ;
                       "WHERE empdopnums = " + EscaparSQL(loc_cEDN)
            IF !EMPTY(ALLTRIM(par_cNcheque))
                loc_cSQL = loc_cSQL + " AND ncheques = " + EscaparSQL(par_cNcheque)
            ENDIF

            IF USED("cursor_4c_ChiDados")
                TABLEREVERT(.T., "cursor_4c_ChiDados")
                USE IN cursor_4c_ChiDados
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChiDados") > 0
                SELECT cursor_4c_ChiDados
                GO TOP
                IF !EOF()
                    THIS.CarregarDoCursor("cursor_4c_ChiDados")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcela - Carrega parcela vinculada ao cheque (SigMvPar)
    *--------------------------------------------------------------------------
    FUNCTION CarregarParcela(par_cEmpDopNums)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT bancos, agencias, contas, numeros, valos, vencs, fpags " + ;
                       "FROM SigMvPar " + ;
                       "WHERE empdopnums = " + EscaparSQL(par_cEmpDopNums)

            IF USED("cursor_4c_Par")
                TABLEREVERT(.T., "cursor_4c_Par")
                USE IN cursor_4c_Par
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Par") > 0
                SELECT cursor_4c_Par
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Par
                    THIS.this_cParBancos   = NVL(ALLTRIM(bancos), "")
                    THIS.this_cParAgencias = NVL(ALLTRIM(agencias), "")
                    THIS.this_cParContas   = NVL(ALLTRIM(contas), "")
                    THIS.this_cParNumeros  = NVL(ALLTRIM(numeros), "")
                    THIS.this_nParValos    = NVL(valos, 0)
                    THIS.this_dParVencs    = NVL(vencs, {})
                    THIS.this_cParFPags    = NVL(ALLTRIM(fpags), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - Carrega dados da empresa (SigCdEmp)
    *--------------------------------------------------------------------------
    FUNCTION CarregarEmpresa(par_cEmps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT cemps, cidas FROM SigCdEmp " + ;
                       "WHERE cemps = " + EscaparSQL(par_cEmps)

            IF USED("cursor_4c_Emp")
                TABLEREVERT(.T., "cursor_4c_Emp")
                USE IN cursor_4c_Emp
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emp") > 0
                SELECT cursor_4c_Emp
                GO TOP
                IF !EOF()
                    SELECT cursor_4c_Emp
                    THIS.this_cCidEmps = NVL(ALLTRIM(cidas), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_cCidChaves  = LEFT(THIS.this_cEmps + SYS(2015) + PADR(SYS(1), 7, "0"), 20)
            THIS.this_cEmpDopNums = THIS.this_cEmps + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

            loc_cSQL = "INSERT INTO SigCqChi " + ;
                       "(cidchaves, empdopnums, emps, dopes, numes, " + ;
                       "agencias, bancos, contas, ncontas, ncheques, " + ;
                       "favos, valors, vencs, versos, emitidos, " + ;
                       "nemissoes, ncopias, impversos, cancelas, " + ;
                       "grupos, datas, justcanc) VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       EscaparSQL(THIS.this_cEmps) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       EscaparSQL(THIS.this_cVersos) + ", " + ;
                       IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(THIS.this_cJustCanc) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro em SigCqChi
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi SET " + ;
                       "empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums) + ", " + ;
                       "emps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
                       "dopes = " + EscaparSQL(PADR(THIS.this_cDopes, 20)) + ", " + ;
                       "numes = " + FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
                       "agencias = " + EscaparSQL(PADR(THIS.this_cAgencias, 4)) + ", " + ;
                       "bancos = " + EscaparSQL(PADR(THIS.this_cBancos, 3)) + ", " + ;
                       "contas = " + EscaparSQL(PADR(THIS.this_cContas, 10)) + ", " + ;
                       "ncontas = " + EscaparSQL(PADR(THIS.this_cNContas, 10)) + ", " + ;
                       "ncheques = " + EscaparSQL(PADR(THIS.this_cNCheques, 6)) + ", " + ;
                       "favos = " + EscaparSQL(PADR(THIS.this_cFavos, 40)) + ", " + ;
                       "valors = " + FormatarNumeroSQL(THIS.this_nValors) + ", " + ;
                       "vencs = " + IIF(EMPTY(THIS.this_dVencs), "NULL", FormatarDataSQL(THIS.this_dVencs)) + ", " + ;
                       "versos = " + EscaparSQL(THIS.this_cVersos) + ", " + ;
                       "emitidos = " + IIF(THIS.this_lEmitidos, "1", "0") + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(THIS.this_nNEmissoes) + ", " + ;
                       "ncopias = " + FormatarNumeroSQL(THIS.this_nNCopias) + ", " + ;
                       "impversos = " + FormatarNumeroSQL(THIS.this_nImpVersos) + ", " + ;
                       "cancelas = " + IIF(THIS.this_lCancelas, "1", "0") + ", " + ;
                       "grupos = " + EscaparSQL(PADR(THIS.this_cGrupos, 10)) + ", " + ;
                       "datas = " + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "justcanc = " + EscaparSQL(THIS.this_cJustCanc) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarEmitido - Marca cheque como emitido e incrementa emissoes
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmitido(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 1, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * MarcarVersoImpresso - Marca verso do cheque como impresso (impversos=1)
    *--------------------------------------------------------------------------
    FUNCTION MarcarVersoImpresso(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET impversos = 1 " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizarVerso - Atualiza texto do verso do cheque
    *--------------------------------------------------------------------------
    FUNCTION AtualizarVerso(par_cCidChaves, par_cVerso)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET versos = " + EscaparSQL(par_cVerso) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarStatusSaida - Salva status ao sair sem emitir (emitidos=0)
    *--------------------------------------------------------------------------
    FUNCTION SalvarStatusSaida(par_cCidChaves, par_cFavos, par_nNEmissoes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCqChi " + ;
                       "SET emitidos = 0, " + ;
                       "favos = " + EscaparSQL(PADR(par_cFavos, 40)) + ", " + ;
                       "nemissoes = " + FormatarNumeroSQL(par_nNEmissoes) + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

