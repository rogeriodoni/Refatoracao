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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReEch.prg) - TRECHOS RELEVANTES PARA PASS SQL (1557 linhas total):

*-- Linhas 866 a 898:
866:                 MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
867:                         CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
868:             ELSE
869:             loc_cSQL      = "SELECT ImpCheqs FROM SigCdPam"
870: 
871:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
872:                 SELECT cursor_4c_Param
873:                 GO TOP
874:                 loc_nImpCheqs = NVL(ImpCheqs, 1)
875:                 USE IN cursor_4c_Param
876:             ENDIF
877: 
878:             MsgInfo("Posicione o cheque na impressora...", "IMPRIME CHEQUE")
879: 
880:             loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
881:                        "WHERE Tipos = 'Impressora de Cheque'"
882:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
883:                 SELECT cursor_4c_CfCom
884:                 GO TOP
885:                 IF !EOF()
886:                     IF !THIS.obj_4c_OModem.portopen
887:                         THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
888:                         THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
889:                         THIS.obj_4c_OModem.Inputlen = 1
890:                     ENDIF
891:                 ENDIF
892:                 USE IN cursor_4c_CfCom
893:                 THIS.obj_4c_OModem.PortOpen = .T.
894: 
895:                 IF loc_nImpCheqs = 2
896:                     loc_cValor = ALLTRIM(TRANSFORM(loc_oBO.this_nParValos * 100, "@L 99999999999999"))
897:                     loc_cData  = TRANSFORM(DAY(loc_oBO.this_dParVencs),   "@L 99") + ;
898:                                  TRANSFORM(MONTH(loc_oBO.this_dParVencs), "@L 99") + ;

*-- Linhas 964 a 996:
964:                     MsgErro("Impressora de cheque n" + CHR(227) + "o dispon" + CHR(237) + "vel." + ;
965:                             CHR(13) + "Controle MSComm n" + CHR(227) + "o carregado.", "Erro")
966:                 ELSE
967:                 loc_cSQL = "SELECT ImpCheqs FROM SigCdPam"
968:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Param") > 0
969:                     SELECT cursor_4c_Param
970:                     GO TOP
971:                     loc_nImpCheqs = NVL(ImpCheqs, 1)
972:                     USE IN cursor_4c_Param
973:                 ENDIF
974: 
975:                 MsgInfo("Posicione o cheque na impressora para impress" + CHR(227) + "o do verso...", ;
976:                         "IMPRIME CHEQUE")
977: 
978:                 loc_cSQL = "SELECT Portas, Settings FROM SigSyCom " + ;
979:                            "WHERE Tipos = 'Impressora de Cheque'"
980:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfCom") > 0 AND USED("cursor_4c_CfCom")
981:                     SELECT cursor_4c_CfCom
982:                     GO TOP
983:                     IF !EOF()
984:                         IF !THIS.obj_4c_OModem.portopen
985:                             THIS.obj_4c_OModem.commport = cursor_4c_CfCom.Portas
986:                             THIS.obj_4c_OModem.Settings = ALLTRIM(cursor_4c_CfCom.Settings)
987:                             THIS.obj_4c_OModem.Inputlen = 1
988:                         ENDIF
989:                     ENDIF
990:                     USE IN cursor_4c_CfCom
991:                     THIS.obj_4c_OModem.PortOpen = .T.
992: 
993:                     loc_cVerso = IIF(VARTYPE(THIS.obj_4c_Get_Verso) = "O", ;
994:                                      THIS.obj_4c_Get_Verso.Value, ;
995:                                      loc_oBO.this_cVersos)
996: 

*-- Linhas 1064 a 1246:
1064:                 _Mes = fMesExtenso(loc_oBO.this_dParVencs)
1065:             ENDIF
1066: 
1067:             loc_cSQL = "SELECT GrupoRecs, ContaRecs FROM SigCdPam"
1068:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
1069:                 SELECT cursor_4c_Pam
1070:                 GO TOP
1071:                 loc_cGrupoRecs = NVL(ALLTRIM(GrupoRecs), "")
1072:                 loc_cContaRecs = NVL(ALLTRIM(ContaRecs), "")
1073:                 USE IN cursor_4c_Pam
1074:             ENDIF
1075: 
1076:             loc_cPagDesc = ""
1077:             IF !EMPTY(ALLTRIM(loc_oBO.this_cParFPags))
1078:                 loc_cSQL = "SELECT Descrs FROM SigOpFpp " + ;
1079:                            "WHERE FPags = " + EscaparSQL(loc_oBO.this_cParFPags) + ;
1080:                            " AND ImpCpChqs = 2"
1081:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FPag") > 0
1082:                     SELECT cursor_4c_FPag
1083:                     GO TOP
1084:                     IF !EOF()
1085:                         loc_cPagDesc = NVL(ALLTRIM(Descrs), "")
1086:                     ENDIF
1087:                     USE IN cursor_4c_FPag
1088:                 ENDIF
1089:             ENDIF
1090: 
1091:             SET NULL ON
1092:             CREATE CURSOR TmpConta2 (Titulo C(10) NULL, Vencimento D(8) NULL, ;
1093:                 Fornecedor C(10) NULL, DescriForn C(50) NULL, Despesa C(10) NULL, ;
1094:                 DescriDesp C(50) NULL, Valor N(12,2) NULL, Moeda C(3) NULL, ;
1095:                 Hists C(40) NULL, Hist2s C(40) NULL, Imprime L(1) NULL, ;
1096:                 Emps C(3) NULL, Pagamento C(6) NULL, Fim L(1) NULL, ;
1097:                 bGrupos C(10) NULL, Numcs N(6,0) NULL, Tipos C(1) NULL, ;
1098:                 Ordem C(1) NULL, Opers C(1) NULL, Vencs D(8) NULL, ;
1099:                 nbgrupos C(30) NULL, CodSegs C(10) NULL, ;
1100:                 OrdCopChs N(3,0) NULL, ChDescrs C(30) NULL)
1101:             SET NULL OFF
1102: 
1103:             loc_cSQL = "SELECT '1' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
1104:                        "Contas, Valors, Moedas, Hists, Hist2s, Emps, bgrupos, Numcs, " + ;
1105:                        "Tipos, OrdCopChs " + ;
1106:                        "FROM SigMvCcr " + ;
1107:                        "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
1108:                        " AND NOT Tipos = 'O' " + ;
1109:                        "UNION ALL " + ;
1110:                        "SELECT '2' AS Ordem, Opers, Titulos, Vencs, Contems, Grupos, " + ;
1111:                        "Contas, (Valors + Valocurs) * -1 AS Valors, Moedas, Hists, Hist2s, " + ;
1112:                        "Emps, bgrupos, Numcs, Tipos, OrdCopChs " + ;
1113:                        "FROM SigMvCcr " + ;
1114:                        "WHERE EmpDopncs = " + EscaparSQL(loc_oBO.this_cEmpDopNums) + ;
1115:                        " AND Tipos = 'O' AND Grupos <> " + EscaparSQL(loc_cGrupoRecs) + ;
1116:                        " ORDER BY 1, 2, 3, 4, 5, 6, 7"
1117: 
1118:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Mvs") < 1
1119:                 IF USED("TmpConta2")
1120:                     USE IN TmpConta2
1121:                 ENDIF
1122:                 MsgErro("Falha ao carregar movimentos para impress" + CHR(227) + "o de c" + ;
1123:                         CHR(243) + "pia.", "Erro")
1124:             ELSE
1125:                 SELECT cursor_4c_Mvs
1126:                 GO TOP
1127:                 loc_lcChv = ""
1128:                 loc_lnCnt = 0
1129: 
1130:                 DO WHILE !EOF("cursor_4c_Mvs")
1131:                     SELECT cursor_4c_Mvs
1132:                     loc_cHist  = STRTRAN(STRTRAN(cursor_4c_Mvs.Hists,  CHR(13), " "), CHR(10), " ")
1133:                     loc_cHist2 = STRTRAN(STRTRAN(cursor_4c_Mvs.Hist2s, CHR(13), " "), CHR(10), " ")
1134: 
1135:                     IF cursor_4c_Mvs.Grupos <> loc_cGrupoRecs AND ;
1136:                        cursor_4c_Mvs.Contas <> loc_cContaRecs
1137: 
1138:                         loc_lcFornece = ""
1139:                         loc_cSQL = "SELECT Rclis FROM SigCdCli " + ;
1140:                                    "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contems)
1141:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliF") > 0
1142:                             SELECT cursor_4c_CliF
1143:                             GO TOP
1144:                             IF !EOF()
1145:                                 loc_lcFornece = NVL(ALLTRIM(Rclis), "")
1146:                             ENDIF
1147:                             USE IN cursor_4c_CliF
1148:                         ENDIF
1149: 
1150:                         loc_lcCliente = ""
1151:                         loc_lcCodSeg  = ""
1152:                         loc_cSQL = "SELECT Rclis, CodSegs FROM SigCdCli " + ;
1153:                                    "WHERE Iclis = " + EscaparSQL(cursor_4c_Mvs.Contas)
1154:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliC") > 0
1155:                             SELECT cursor_4c_CliC
1156:                             GO TOP
1157:                             IF !EOF()
1158:                                 loc_lcCliente = NVL(ALLTRIM(Rclis), "")
1159:                                 loc_lcCodSeg  = NVL(ALLTRIM(CodSegs), "")
1160:                             ENDIF
1161:                             USE IN cursor_4c_CliC
1162:                         ENDIF
1163: 
1164:                         loc_lcPagto = ""
1165:                         loc_lcEDNI  = loc_oBO.this_cEmps + loc_oBO.this_cDopes + ;
1166:                                       STR(loc_oBO.this_nNumes, 6)
1167:                         loc_cSQL = "SELECT EmpDopNums FROM SigCdPgr " + ;
1168:                                    "WHERE EmpDopNums = " + EscaparSQL(loc_lcEDNI)
1169:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pgr") > 0
1170:                             SELECT cursor_4c_Pgr
1171:                             GO TOP
1172:                             IF !EOF()
1173:                                 loc_lcPagto = STR(loc_oBO.this_nNumes, 6)
1174:                             ENDIF
1175:                             USE IN cursor_4c_Pgr
1176:                         ENDIF
1177: 
1178:                         SELECT cursor_4c_Mvs
1179: 
1180:                         IF cursor_4c_Mvs.Opers = "C"
1181:                             INSERT INTO TmpConta2 (Titulo, Vencimento, Fornecedor, DescriForn, ;
1182:                                 Despesa, DescriDesp, Valor, Moeda, Imprime, Emps, ;
1183:                                 Hists, Hist2s, Pagamento, bGrupos, Numcs, Tipos, ;
1184:                                 Ordem, Opers, Vencs, CodSegs, OrdCopChs, ChDescrs) ;
1185:                             VALUES (cursor_4c_Mvs.Titulos, NVL(cursor_4c_Mvs.Vencs, {}), ;
1186:                                 cursor_4c_Mvs.Contems, loc_lcFornece, ;
1187:                                 cursor_4c_Mvs.Contas, loc_lcCliente, ;
1188:                                 cursor_4c_Mvs.Valors, cursor_4c_Mvs.Moedas, ;
1189:                                 IIF(loc_lcChv <> cursor_4c_Mvs.Titulos + ;
1190:                                     DTOC(cursor_4c_Mvs.Vencs) + cursor_4c_Mvs.Contems, .T., .F.), ;
1191:                                 cursor_4c_Mvs.Emps, loc_cHist, loc_cHist2, ;
1192:                                 loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
1193:                                 cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
1194:                                 cursor_4c_Mvs.Vencs, loc_lcCodSeg, ;
1195:                                 NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
1196:                         ELSE
1197:                             IF loc_lnCnt = 0 AND cursor_4c_Mvs.Tipos <> "O"
1198:                                 SELECT TmpConta2
1199:                                 GO BOTTOM
1200:                                 REPLACE Despesa    WITH cursor_4c_Mvs.Contas, ;
1201:                                         DescriDesp WITH loc_lcCliente, ;
1202:                                         Hists      WITH loc_cHist, ;
1203:                                         Hist2s     WITH loc_cHist2, ;
1204:                                         Valor      WITH cursor_4c_Mvs.Valors, ;
1205:                                         ChDescrs   WITH loc_cPagDesc
1206:                             ELSE
1207:                                 INSERT INTO TmpConta2 (Titulo, Vencimento, Despesa, DescriDesp, ;
1208:                                     Valor, Moeda, Hists, Hist2s, Imprime, Emps, ;
1209:                                     Pagamento, bGrupos, Numcs, Tipos, Ordem, Opers, ;
1210:                                     Vencs, OrdCopChs, ChDescrs) ;
1211:                                 VALUES (cursor_4c_Mvs.Titulos, cursor_4c_Mvs.Vencs, ;
1212:                                     cursor_4c_Mvs.Contas, loc_lcCliente, ;
1213:                                     ABS(cursor_4c_Mvs.Valors), cursor_4c_Mvs.Moedas, ;
1214:                                     loc_cHist, loc_cHist2, .F., cursor_4c_Mvs.Emps, ;
1215:                                     loc_lcPagto, cursor_4c_Mvs.bGrupos, cursor_4c_Mvs.Numcs, ;
1216:                                     cursor_4c_Mvs.Tipos, cursor_4c_Mvs.Ordem, cursor_4c_Mvs.Opers, ;
1217:                                     cursor_4c_Mvs.Vencs, NVL(cursor_4c_Mvs.OrdCopChs, 0), loc_cPagDesc)
1218:                             ENDIF
1219:                             loc_lnCnt = loc_lnCnt + 1
1220:                         ENDIF
1221:                         loc_lcChv = cursor_4c_Mvs.Titulos + DTOC(cursor_4c_Mvs.Vencs) + ;
1222:                                     cursor_4c_Mvs.Contems
1223:                     ENDIF
1224: 
1225:                     SELECT cursor_4c_Mvs
1226:                     SKIP
1227:                 ENDDO
1228: 
1229:                 USE IN cursor_4c_Mvs
1230: 
1231:                 SELECT TmpConta2
1232:                 GO BOTTOM
1233:                 REPLACE Fim WITH .T.
1234:                 INDEX ON STR(NVL(OrdCopChs, 0), 3) + Titulo + ;
1235:                          DTOS(NVL(Vencimento, {})) + Ordem + Opers TAG Impressao
1236:                 GO TOP
1237: 
1238:                 IF THIS.enviaimp
1239:                     REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") TO PRINT PROMPT NOCONSOLE
1240:                 ELSE
1241:                     REPORT FORM (gc_4c_CaminhoReports + "SigOpCq2") PREVIEW NOCONSOLE
1242:                 ENDIF
1243: 
1244:                 IF USED("TmpConta2")
1245:                     USE IN TmpConta2
1246:                 ENDIF

*-- Linhas 1473 a 1491:
1473: 
1474:     *==========================================================================
1475:     * BtnSalvarClick - Grava favorecido e verso no banco (SigCqChi)
1476:     * Sincroniza form->BO e executa UPDATE via SalvarStatusSaida + AtualizarVerso.
1477:     *==========================================================================
1478:     PROCEDURE BtnSalvarClick()
1479:         LOCAL loc_oBO, loc_cVersoAtual, loc_oErro
1480:         TRY
1481:             loc_oBO = THIS.this_oBusinessObject
1482:             IF VARTYPE(loc_oBO) != "O"
1483:                 MsgErro("Business Object n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Erro")
1484:             ELSE
1485:                 IF !INLIST(THIS.op_escolha, "INSERIR", "ALTERAR")
1486:                     MsgAviso("Cheque em modo somente leitura. " + ;
1487:                              "Acione Alterar antes de salvar.", "Aviso")
1488:                 ELSE
1489:                     *-- Form -> BO (favorecido e verso)
1490:                     THIS.FormParaBO()
1491: 


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

