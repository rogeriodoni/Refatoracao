# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 1, MARCAS, USUAR, EMPS, DATAS, CODS, VENDS, LOCALS, EMPOS, LOCALIZAS, CONTAS, CPROS, ESTOS, GRUPOS, 0, ICLIS, JOBS, USUARS, INATIVAS

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
lnOldSel = Select()
Select &pcCursor.
Select cidchaves, Cods, Descs, 0 as Marcas, Space(4) as Codigo From &pcCursor. Where 1=0 Into Cursor CrAux ReadWrite
Select &pcCursor.	
		Select CrAux
			Select &pcCurDest.
			Select CrAux	
Select &pcNivAnt.
Select(lnOldSel)
		lcQuery = [Select * From SigLcNv1]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel1])
		lcQuery = [Select * From SigLcNv2]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel2])
		lcQuery = [Select * From SigLcNv3]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel3])
		lcQuery = [Select * From SigLcNv4]
		ThisForm.podatamgr.SqlExecute(lcQuery,[csNivel4])
		Select csNivel1
		Select *, Space(4) as Codigo From csNivel1 Where 1=0 Into Cursor crSigLcNv1 ReadWrite
		Select csNivel2
		Select *, Space(4) as Codigo From csNivel2 Where 1=0 Into Cursor crSigLcNv2 ReadWrite
		Select csNivel3
		Select *, Space(4) as Codigo From csNivel3 Where 1=0 Into Cursor crSigLcNv3 ReadWrite
		Select csNivel4
		Select *, Space(4) as Codigo From csNivel4 Where 1=0 Into Cursor crSigLcNv4 ReadWrite
Insert Into csCabecalho (NomeEmpresa, Titulo, Titulo2) Values (lcEmpresa, lcTitulo, lcTitulo2)
lcQuery = [select a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque ] + ;
			[from sigcdcnl a ] + ;
			[join sigcdcni b on a.cods = b.cods ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery,[crSigCdCnl])<1)
Select crSigCdCnl
lcQuery = [Select localizas ,grupos,contas,empos, Sum(Qtde) As qtde, convert(numeric(5,0),0) as QtdCtg  ] + ;
			[From ( Select localizas,a.grupos,a.contas,a.empos, Count(1) As qtde ] + ;
			[From SigOpEtq A ] + ;
			[left join (Select Cpros,Cgrus,Mercs,Colecoes,SGrus from SigCdPro) B on b.cpros = a.cpros ] + ;  
			[Select a.locals, a.grupos, a.estos, a.emps, sum(sqtds) as Total ] + ;
			[From SigMvesl a, SigCdpro b ] + ;  
			[And a.cpros + a.locals not in(select cpros + localizas from sigopetq) ] + ;
If (Thisform.poDataMgr.SqlExecute(lcQuery,[crTmpLocal])<1)
Select crTmpLocal
	If Not Seek(crTmpLocal.localizas,[crSigCdCnl],[Locals])
		Delete 
	Select crTmpLocal
Select crTmpLocal
Select Localizas, Sum(Qtde) As Qtds From crTmpLocal Where 0=0 Group By Localizas Into Cursor csTotLocal Readwrite
Select csTotLocal
	Select Distinct a.DataS, Nvl(a.Locals,'') As Locals, ;
		From crTmpLocal b  ;
		full outer join crSigCdCnl a On a.Locals = b.Localizas ;
	Select Distinct a.DataS, Nvl(a.Locals,'') As Locals, ;
		From crSigCdCnl a ;
		left Join crTmpLocal b On a.Locals = b.Localizas ;
	Select Distinct a.DataS, Nvl(a.Locals,'') As Locals, ;
		From crTmpLocal b ;
		left Join crSigCdCnl a On a.Locals = b.Localizas ;
	Select Distinct a.DataS, Nvl(a.Locals,'') As Locals, ;
		From crTmpLocal b ;
		left Join crSigCdCnl a On a.Locals = b.Localizas ;
Select csRel
Select Datas, Locals, Vends, Empos, Localizas, Sum(Qtds) As Qtds, Sum(Qtde) As Qtde, Space(100) as Descr, ;
	From csRel ;
Select crRel
		Select csNivel3
	Select crRel
Select crRel
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+This.Value+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVends
	If Seek(Padr(This.Value,10),'CrSigVends','Iclis')
	Select * From CrSigLcNv2 Where Cods = lcNivel ;
	Select LocalNivel
	If !Seek(This.Value)
	lcSql = [Select a.iclis,a.rclis,a.grupos,a.situas,a.Cpfs,a.inativas,a.ContaMats,a.Emps ] + ;
			[From SigCdCli a ] + ;  
			[Inner Join SigCdGcr b On a.Grupos = b.Codigos  ] + ;
			[And a.IClis Not In (Select Distinct c.Jobs From SigCdAcJ c ] + ;
									[Where c.Jobs Not In (Select Distinct d.Jobs From SigCdAcJ d Where d.Usuars = ']+lcVends+[')))) ] + ;
	=ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigVends')
	Select CrSigVendsf
	If Seek(This.Value,'CrSigVends','Rclis')
	Select * From CrSigLcNv3 Where Cods = lcNivel ;
	Select LocalNivel
	If !Seek(This.Value)
	Select * From CrSigLcNv4 Where Cods = lcNivel Into Cursor LocalNivel Readwrite
	Select LocalNivel
	If !Seek(This.Value)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecnt.prg) - TRECHOS RELEVANTES PARA PASS SQL (1457 linhas total):

*-- Linhas 892 a 944:
892:             loc_cGrPadVens = ALLTRIM(THIS.this_oRelatorio.this_cGrPadVens)
893:         ENDIF
894: 
895:         loc_cSQL = "SELECT a.iclis AS Cods, a.rclis AS Descs " + ;
896:                    "FROM SigCdCli a " + ;
897:                    "INNER JOIN SigCdGcr b ON a.Grupos = b.Codigos " + ;
898:                    "AND (b.Coletors <> 10 " + ;
899:                    "OR (b.Coletors = 10 " + ;
900:                    "AND a.IClis NOT IN (" + ;
901:                    "SELECT DISTINCT c.Jobs FROM SigCdAcJ c " + ;
902:                    "WHERE c.Jobs NOT IN (" + ;
903:                    "SELECT DISTINCT d.Jobs FROM SigCdAcJ d " + ;
904:                    "WHERE d.Usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "))))"
905:         IF !EMPTY(loc_cGrPadVens)
906:             loc_cSQL = loc_cSQL + " AND a.grupos = " + EscaparSQL(loc_cGrPadVens)
907:         ENDIF
908:         loc_cSQL = loc_cSQL + " ORDER BY a.rclis"
909: 
910:         IF USED("cursor_4c_BuscaVend")
911:             USE IN SELECT("cursor_4c_BuscaVend")
912:         ENDIF
913:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaVend")
914:         IF loc_nResult > 0
915:             IF RECCOUNT("cursor_4c_BuscaVend") > 0
916:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
917:                 IF VARTYPE(loc_oLookup) = "O"
918:                     loc_oLookup.DefinirCursor("cursor_4c_BuscaVend", "Cods", "Descs", ;
919:                         "Sele" + CHR(231) + CHR(227) + "o de Vendedor")
920:                     IF loc_oLookup.Mostrar()
921:                         loc_oPag.txt_4c_Conta.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
922:                         loc_oPag.txt_4c_DConta.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
923:                     ENDIF
924:                 ENDIF
925:             ELSE
926:                 MsgAviso("Nenhum vendedor encontrado.", "Aviso")
927:             ENDIF
928:             IF USED("cursor_4c_BuscaVend")
929:                 USE IN SELECT("cursor_4c_BuscaVend")
930:             ENDIF
931:         ELSE
932:             MsgErro("Erro ao buscar vendedores.", "Erro")
933:         ENDIF
934:     ENDPROC
935: 
936:     *--------------------------------------------------------------------------
937:     * TeclaDescVendedor - Handler KeyPress de txt_4c_DConta (nome do vendedor)
938:     *   getDConta.When legado: campo habilitado apenas quando getConta eh vazio.
939:     *   ENTER(13) / TAB(9) / F4(115): abre busca de vendedor por nome.
940:     *--------------------------------------------------------------------------
941:     PROCEDURE TeclaDescVendedor(par_nKeyCode, par_nShiftAltCtrl)
942:         LOCAL loc_oPag
943:         loc_oPag = THIS.pgf_4c_Paginas.Page1
944:         IF !EMPTY(ALLTRIM(loc_oPag.txt_4c_Conta.Value))

*-- Linhas 986 a 1050:
986:             RETURN
987:         ENDIF
988:         IF USED("cursor_4c_SigLcNv1")
989:             SELECT cursor_4c_SigLcNv1
990:             LOCATE FOR ALLTRIM(Cods) = loc_cValor
991:             IF FOUND()
992:                 loc_oPag.txt_4c_DBase.Value = ALLTRIM(Descs)
993:             ELSE
994:                 THIS.AbrirBuscaBase()
995:             ENDIF
996:         ELSE
997:             THIS.AbrirBuscaBase()
998:         ENDIF
999:     ENDPROC
1000: 
1001:     *--------------------------------------------------------------------------
1002:     * AbrirBuscaBase - Lista opcoes de base (nivel 1 de localizacao)
1003:     *   Usa cursor_4c_SigLcNv1 do BO; fallback para SQLEXEC se nao disponivel.
1004:     *--------------------------------------------------------------------------
1005:     PROCEDURE AbrirBuscaBase()
1006:         LOCAL loc_cSQL, loc_nResult, loc_oLookup, loc_oPag
1007:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1008:         IF USED("cursor_4c_BuscaBase")
1009:             USE IN SELECT("cursor_4c_BuscaBase")
1010:         ENDIF
1011:         IF USED("cursor_4c_SigLcNv1")
1012:             SELECT Cods, Descs FROM cursor_4c_SigLcNv1 ;
1013:                 ORDER BY Cods ;
1014:                 INTO CURSOR cursor_4c_BuscaBase READWRITE
1015:         ELSE
1016:             loc_cSQL    = "SELECT Cods, Descs FROM SigLcNv1 ORDER BY Cods"
1017:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaBase")
1018:             IF loc_nResult < 1
1019:                 MsgErro("Erro ao buscar bases de localiza" + CHR(231) + ;
1020:                     CHR(227) + "o.", "Erro")
1021:                 RETURN
1022:             ENDIF
1023:         ENDIF
1024:         loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1025:         IF VARTYPE(loc_oLookup) = "O"
1026:             loc_oLookup.DefinirCursor("cursor_4c_BuscaBase", "Cods", "Descs", ;
1027:                 "Localiza" + CHR(231) + CHR(227) + "o Base")
1028:             IF loc_oLookup.Mostrar()
1029:                 loc_oPag.txt_4c_Base.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)
1030:                 loc_oPag.txt_4c_DBase.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
1031:                 THIS.LimparBaseDescendentes()
1032:             ENDIF
1033:         ENDIF
1034:         IF USED("cursor_4c_BuscaBase")
1035:             USE IN SELECT("cursor_4c_BuscaBase")
1036:         ENDIF
1037:     ENDPROC
1038: 
1039:     *--------------------------------------------------------------------------
1040:     * LimparBaseDescendentes - Limpa todos os niveis filhos de Base
1041:     *   Equivalente ao getBase.InteractiveChange do legado.
1042:     *--------------------------------------------------------------------------
1043:     PROCEDURE LimparBaseDescendentes()
1044:         LOCAL loc_oPag
1045:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1046:         loc_oPag.txt_4c_DBase.Value  = ""
1047:         loc_oPag.txt_4c_Nvl2.Value   = ""
1048:         loc_oPag.txt_4c_DNvl2.Value  = ""
1049:         loc_oPag.txt_4c_Nvl3.Value   = ""
1050:         loc_oPag.txt_4c_DNvl3.Value  = ""

*-- Linhas 1084 a 1126:
1084:             RETURN
1085:         ENDIF
1086:         IF USED("cursor_4c_SigLcNv2")
1087:             SELECT cursor_4c_SigLcNv2
1088:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1089:             IF FOUND()
1090:                 loc_oPag.txt_4c_DNvl2.Value = ALLTRIM(Descs)
1091:             ELSE
1092:                 THIS.AbrirBuscaNvl2()
1093:             ENDIF
1094:         ELSE
1095:             THIS.AbrirBuscaNvl2()
1096:         ENDIF
1097:     ENDPROC
1098: 
1099:     *--------------------------------------------------------------------------
1100:     * AbrirBuscaNvl2 - Lista opcoes de nivel 2 filtradas pela Base atual
1101:     *   Equivalente ao fwBuscaSel em CrSigLcNv2 do legado.
1102:     *--------------------------------------------------------------------------
1103:     PROCEDURE AbrirBuscaNvl2()
1104:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1105:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1106:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Base.Value)
1107:         IF USED("cursor_4c_BuscaNvl2")
1108:             USE IN SELECT("cursor_4c_BuscaNvl2")
1109:         ENDIF
1110:         IF USED("cursor_4c_SigLcNv2")
1111:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv2 ;
1112:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1113:                 ORDER BY Codigo ;
1114:                 INTO CURSOR cursor_4c_BuscaNvl2 READWRITE
1115:         ELSE
1116:             MsgErro("Cursor de n" + CHR(237) + "vel 2 n" + CHR(227) + ;
1117:                 "o dispon" + CHR(237) + "vel.", "Erro")
1118:             RETURN
1119:         ENDIF
1120:         IF RECCOUNT("cursor_4c_BuscaNvl2") > 0
1121:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1122:             IF VARTYPE(loc_oLookup) = "O"
1123:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl2", "Codigo", "Descs", ;
1124:                     "Segundo N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1125:                 IF loc_oLookup.Mostrar()
1126:                     loc_oPag.txt_4c_Nvl2.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)

*-- Linhas 1133 a 1151:
1133:                 "para a base informada.", "Aviso")
1134:         ENDIF
1135:         IF USED("cursor_4c_BuscaNvl2")
1136:             USE IN SELECT("cursor_4c_BuscaNvl2")
1137:         ENDIF
1138:     ENDPROC
1139: 
1140:     *--------------------------------------------------------------------------
1141:     * LimparNvl2Descendentes - Limpa niveis filhos de Nvl2
1142:     *   Equivalente ao getNvl2.InteractiveChange do legado.
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE LimparNvl2Descendentes()
1145:         LOCAL loc_oPag
1146:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1147:         loc_oPag.txt_4c_DNvl2.Value = ""
1148:         loc_oPag.txt_4c_Nvl3.Value  = ""
1149:         loc_oPag.txt_4c_DNvl3.Value = ""
1150:         loc_oPag.txt_4c_Nvl4.Value  = ""
1151:         loc_oPag.txt_4c_DNvl4.Value = ""

*-- Linhas 1183 a 1225:
1183:             RETURN
1184:         ENDIF
1185:         IF USED("cursor_4c_SigLcNv3")
1186:             SELECT cursor_4c_SigLcNv3
1187:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1188:             IF FOUND()
1189:                 loc_oPag.txt_4c_DNvl3.Value = ALLTRIM(Descs)
1190:             ELSE
1191:                 THIS.AbrirBuscaNvl3()
1192:             ENDIF
1193:         ELSE
1194:             THIS.AbrirBuscaNvl3()
1195:         ENDIF
1196:     ENDPROC
1197: 
1198:     *--------------------------------------------------------------------------
1199:     * AbrirBuscaNvl3 - Lista opcoes de nivel 3 filtradas pelo Nvl2 atual
1200:     *   Equivalente ao fwBuscaSel em CrSigLcNv3 do legado.
1201:     *--------------------------------------------------------------------------
1202:     PROCEDURE AbrirBuscaNvl3()
1203:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1204:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1205:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl2.Value)
1206:         IF USED("cursor_4c_BuscaNvl3")
1207:             USE IN SELECT("cursor_4c_BuscaNvl3")
1208:         ENDIF
1209:         IF USED("cursor_4c_SigLcNv3")
1210:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv3 ;
1211:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1212:                 ORDER BY Codigo ;
1213:                 INTO CURSOR cursor_4c_BuscaNvl3 READWRITE
1214:         ELSE
1215:             MsgErro("Cursor de n" + CHR(237) + "vel 3 n" + CHR(227) + ;
1216:                 "o dispon" + CHR(237) + "vel.", "Erro")
1217:             RETURN
1218:         ENDIF
1219:         IF RECCOUNT("cursor_4c_BuscaNvl3") > 0
1220:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1221:             IF VARTYPE(loc_oLookup) = "O"
1222:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl3", "Codigo", "Descs", ;
1223:                     "Terceiro N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1224:                 IF loc_oLookup.Mostrar()
1225:                     loc_oPag.txt_4c_Nvl3.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)

*-- Linhas 1232 a 1250:
1232:                 "para o segundo n" + CHR(237) + "vel informado.", "Aviso")
1233:         ENDIF
1234:         IF USED("cursor_4c_BuscaNvl3")
1235:             USE IN SELECT("cursor_4c_BuscaNvl3")
1236:         ENDIF
1237:     ENDPROC
1238: 
1239:     *--------------------------------------------------------------------------
1240:     * LimparNvl3Descendentes - Limpa niveis filhos de Nvl3
1241:     *   Equivalente ao getNvl3.InteractiveChange do legado.
1242:     *--------------------------------------------------------------------------
1243:     PROCEDURE LimparNvl3Descendentes()
1244:         LOCAL loc_oPag
1245:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1246:         loc_oPag.txt_4c_DNvl3.Value = ""
1247:         loc_oPag.txt_4c_Nvl4.Value  = ""
1248:         loc_oPag.txt_4c_DNvl4.Value = ""
1249:     ENDPROC
1250: 

*-- Linhas 1280 a 1322:
1280:             RETURN
1281:         ENDIF
1282:         IF USED("cursor_4c_SigLcNv4")
1283:             SELECT cursor_4c_SigLcNv4
1284:             LOCATE FOR ALLTRIM(Cods) = loc_cNivel AND ALLTRIM(Codigo) = loc_cValor
1285:             IF FOUND()
1286:                 loc_oPag.txt_4c_DNvl4.Value = ALLTRIM(Descs)
1287:             ELSE
1288:                 THIS.AbrirBuscaNvl4()
1289:             ENDIF
1290:         ELSE
1291:             THIS.AbrirBuscaNvl4()
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *--------------------------------------------------------------------------
1296:     * AbrirBuscaNvl4 - Lista opcoes de nivel 4 filtradas pelo Nvl3 atual
1297:     *   Equivalente ao fwBuscaSel em CrSigLcNv4 do legado.
1298:     *--------------------------------------------------------------------------
1299:     PROCEDURE AbrirBuscaNvl4()
1300:         LOCAL loc_cNivel, loc_oLookup, loc_oPag
1301:         loc_oPag   = THIS.pgf_4c_Paginas.Page1
1302:         loc_cNivel = ALLTRIM(loc_oPag.txt_4c_Nvl3.Value)
1303:         IF USED("cursor_4c_BuscaNvl4")
1304:             USE IN SELECT("cursor_4c_BuscaNvl4")
1305:         ENDIF
1306:         IF USED("cursor_4c_SigLcNv4")
1307:             SELECT Codigo, Descs FROM cursor_4c_SigLcNv4 ;
1308:                 WHERE ALLTRIM(Cods) = loc_cNivel ;
1309:                 ORDER BY Codigo ;
1310:                 INTO CURSOR cursor_4c_BuscaNvl4 READWRITE
1311:         ELSE
1312:             MsgErro("Cursor de n" + CHR(237) + "vel 4 n" + CHR(227) + ;
1313:                 "o dispon" + CHR(237) + "vel.", "Erro")
1314:             RETURN
1315:         ENDIF
1316:         IF RECCOUNT("cursor_4c_BuscaNvl4") > 0
1317:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
1318:             IF VARTYPE(loc_oLookup) = "O"
1319:                 loc_oLookup.DefinirCursor("cursor_4c_BuscaNvl4", "Codigo", "Descs", ;
1320:                     "Quarto N" + CHR(237) + "vel de Localiza" + CHR(231) + CHR(227) + "o")
1321:                 IF loc_oLookup.Mostrar()
1322:                     loc_oPag.txt_4c_Nvl4.Value  = ALLTRIM(loc_oLookup.cCodigoSelecionado)

*-- Linhas 1328 a 1346:
1328:                 "para o terceiro n" + CHR(237) + "vel informado.", "Aviso")
1329:         ENDIF
1330:         IF USED("cursor_4c_BuscaNvl4")
1331:             USE IN SELECT("cursor_4c_BuscaNvl4")
1332:         ENDIF
1333:     ENDPROC
1334: 
1335:     *--------------------------------------------------------------------------
1336:     * LimparNvl4Descendentes - Limpa descricao de nivel 4
1337:     *   Equivalente ao getNvl4.InteractiveChange do legado.
1338:     *--------------------------------------------------------------------------
1339:     PROCEDURE LimparNvl4Descendentes()
1340:         LOCAL loc_oPag
1341:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1342:         loc_oPag.txt_4c_DNvl4.Value = ""
1343:     ENDPROC
1344: 
1345:     *--------------------------------------------------------------------------
1346:     * ValidarDataParaRelatorio - Valida se data foi informada (obrigatoria)


### BO (C:\4c\projeto\app\classes\sigrecntBO.prg):
*==============================================================================
* SIGRECNTBO.PRG
* Business Object para Relatorio de Contagem por Localizacao
*
* Herda de: RelatorioBase
* Form: Formsigrecnt.prg
* Relatorio original: sigrecnt.SCX / SigReCnt.FRX
*==============================================================================

DEFINE CLASS sigrecntBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigReCnt"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario
    this_dData              = {}
    this_cConta             = ""
    this_cDConta            = ""
    this_cBase              = ""
    this_cNvl2              = ""
    this_cNvl3              = ""
    this_cNvl4              = ""
    this_cCods              = ""
    this_nOptLocal          = 0
    this_nOptOrdem          = 0

    *-- Estado / controle
    this_lVisualizaCtg      = .F.
    this_cGrPadVens         = ""

    *-- Cursor principal gerado por PrepararDados
    this_cCursorDados       = "crRel"

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Rela" + CHR(231) + CHR(227) + "o de " + ;
                                     "Contagem por Localiza" + CHR(231) + CHR(227) + "o"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega GrPadVens e cursores de nivel para o form
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                loc_cSQL = "SELECT TOP 1 GrPadVens FROM SigCdPam " + ;
                           "WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPam")
                IF loc_nResult > 0
                    SELECT cursor_4c_LocalPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrPadVens = ALLTRIM(NVL(cursor_4c_LocalPam.GrPadVens, ""))
                    ENDIF
                ENDIF

                IF EMPTY(THIS.this_cGrPadVens)
                    THIS.this_cMensagemErro = "O Grupo Padr" + CHR(227) + "o de Vendedores " + ;
                        "N" + CHR(227) + "o Est" + CHR(225) + " Configurado nos " + ;
                        "Par" + CHR(226) + "metros do Sistema."
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv1", "cursor_4c_SigLcNv1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 1"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv2", "cursor_4c_SigLcNv2")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 2"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv3", "cursor_4c_SigLcNv3")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 3"
                    EXIT
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, "SELECT * FROM SigLcNv4", "cursor_4c_SigLcNv4")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Erro ao carregar n" + CHR(237) + "vel 4"
                    EXIT
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida parametros obrigatorios antes de processar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa todo o processamento do relatorio de contagem
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        LOCAL loc_lcLocalizacao, loc_lcBase, loc_lcNvl2, loc_lcNvl3, loc_lcNvl4
        LOCAL loc_lcVends, loc_lnLocal, loc_lnOrdem, loc_lcCods
        LOCAL loc_cDtI, loc_cDtF
        LOCAL loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2
        LOCAL loc_lcNvl3Tmp
        loc_lSucesso = .F.
        TRY
            DO WHILE .T.
                IF !THIS.ValidarFiltros()
                    EXIT
                ENDIF

                loc_lcBase        = ALLTRIM(THIS.this_cBase)
                loc_lcNvl2        = ALLTRIM(THIS.this_cNvl2)
                loc_lcNvl3        = ALLTRIM(THIS.this_cNvl3)
                loc_lcNvl4        = ALLTRIM(THIS.this_cNvl4)
                loc_lcLocalizacao = loc_lcBase + loc_lcNvl2 + loc_lcNvl3 + loc_lcNvl4
                loc_lcVends       = ALLTRIM(THIS.this_cConta)
                loc_lnLocal       = THIS.this_nOptLocal
                loc_lnOrdem       = THIS.this_nOptOrdem
                loc_lcCods        = ALLTRIM(THIS.this_cCods)

                loc_cDtI = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 00:00:00', 120)"
                loc_cDtF = "CONVERT(DATETIME, '" + DTOC(THIS.this_dData, 1) + " 23:59:59', 120)"

                IF USED("csRel")
                    USE IN csRel
                ENDIF
                IF USED("crRel")
                    USE IN crRel
                ENDIF
                IF USED("crTmpLocal")
                    USE IN crTmpLocal
                ENDIF
                IF USED("crSigCdCnl")
                    USE IN crSigCdCnl
                ENDIF
                IF USED("csTotLocal")
                    USE IN csTotLocal
                ENDIF
                IF USED("csCabecalho")
                    USE IN csCabecalho
                ENDIF

                CREATE CURSOR csCabecalho (NomeEmpresa C(80), Titulo C(200), Titulo2 C(200), Figura C(10))

                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT TOP 1 Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), "cursor_4c_EmpCnt")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpCnt
                    GO TOP
                    loc_lcEmpresa = go_4c_Sistema.cCodEmpresa + " - " + ;
                                    ALLTRIM(NVL(cursor_4c_EmpCnt.Razas, ""))
                ELSE
                    loc_lcEmpresa = go_4c_Sistema.cCodEmpresa
                ENDIF

                loc_lcTitulo  = "Rela" + CHR(231) + CHR(227) + "o de Localiza" + CHR(231) + CHR(227) + "o"
                loc_lcTitulo2 = IIF(!EMPTY(THIS.this_cConta), ;
                    "Vendedor - " + THIS.this_cConta + " " + THIS.this_cDConta, "")
                INSERT INTO csCabecalho (NomeEmpresa, Titulo, Titulo2) ;
                    VALUES (loc_lcEmpresa, loc_lcTitulo, loc_lcTitulo2)

                *-- Contagens realizadas (sigcdcnl + sigcdcni)
                loc_cSQL = "SELECT a.cods, a.datas, a.vends, a.emps, b.locals, b.qtds, b.estoque " + ;
                           "FROM sigcdcnl a " + ;
                           "JOIN sigcdcni b ON a.cods = b.cods " + ;
                           "WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF

                IF !EMPTY(loc_lcCods)
                    loc_cSQL = loc_cSQL + " AND A.Cods = " + EscaparSQL(loc_lcCods)
                ENDIF
                IF !EMPTY(loc_lcVends)
                    loc_cSQL = loc_cSQL + " AND A.Vends = " + EscaparSQL(loc_lcVends)
                ENDIF
                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND b.locals LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnl")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar contagens."
                    EXIT
                ENDIF

                SELECT crSigCdCnl
                INDEX ON Locals TAG Locals
                GO TOP

                IF RECCOUNT("crSigCdCnl") = 0
                    THIS.this_cMensagemErro = "Nenhuma contagem encontrada para os filtros informados."
                    EXIT
                ENDIF

                *-- Estoque por localizacao (SigOpEtq UNION ALL SigMvesl)
                loc_cSQL = "SELECT localizas, grupos, contas, empos, Sum(Qtde) AS qtde, " + ;
                           "CONVERT(NUMERIC(5,0), 0) AS QtdCtg " + ;
                           "FROM (" + ;
                           " SELECT localizas, a.grupos, a.contas, a.empos, COUNT(1) AS qtde " + ;
                           " FROM SigOpEtq A " + ;
                           " LEFT JOIN (SELECT Cpros,Cgrus,Mercs,Colecoes,SGrus FROM SigCdPro) B " + ;
                           "  ON b.cpros = a.cpros " + ;
                           " WHERE a.empos = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.contas NOT IN ('15000100','15000141') " + ;
                           " GROUP BY A.localizas, a.grupos, a.contas, a.empos " + ;
                           " UNION ALL " + ;
                           " SELECT a.locals, a.grupos, a.estos, a.emps, SUM(sqtds) AS Total " + ;
                           " FROM SigMvesl a, SigCdpro b " + ;
                           " WHERE a.CPros = b.Cpros " + ;
                           " AND a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                           " AND a.estos NOT IN ('15000100','15000141') " + ;
                           " AND a.cpros + a.locals NOT IN " + ;
                           "  (SELECT cpros + localizas FROM sigopetq) " + ;
                           " GROUP BY a.locals, a.grupos, a.estos, a.emps" + ;
                           ") a WHERE Grupos <> SPACE(10)"

                IF !EMPTY(loc_lcLocalizacao)
                    loc_cSQL = loc_cSQL + " AND a.localizas LIKE " + ;
                               EscaparSQL(loc_lcLocalizacao + "%")
                ENDIF

                loc_cSQL = loc_cSQL + ;
                           " GROUP BY localizas, grupos, contas, empos" + ;
                           " HAVING SUM(qtde) <> 0"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpLocal")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha ao consultar estoque por localiza" + ;
                                              CHR(231) + CHR(227) + "o."
                    EXIT
                ENDIF

                *-- Filtra crTmpLocal: manter apenas localizacoes com contagem
                SELECT crTmpLocal
                GO TOP
                SCAN
                    IF !SEEK(crTmpLocal.localizas, "crSigCdCnl", "Locals")
                        DELETE
                        LOOP
                    ENDIF
                    SELECT crTmpLocal
                ENDSCAN

                SELECT Localizas, SUM(Qtde) AS Qtds ;
                    FROM crTmpLocal WHERE 0=0 ;
                    GROUP BY Localizas ;
                    INTO CURSOR csTotLocal READWRITE

                IF RECCOUNT("csTotLocal") = 0
                    THIS.this_cMensagemErro = "Nenhum estoque encontrado para as " + ;
                        "localiza" + CHR(231) + CHR(245) + "es contadas."
                    EXIT
                ENDIF

                SELECT csTotLocal
                INDEX ON Localizas TAG Locals
                GO TOP

                *-- Gera cursor de resultado conforme OptLocal
                DO CASE
                CASE loc_lnLocal = 1
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        FULL OUTER JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 2
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crSigCdCnl a ;
                        LEFT JOIN crTmpLocal b ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 3
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) = 0 ;
                        INTO CURSOR csRel READWRITE
                CASE loc_lnLocal = 4
                    SELECT DISTINCT a.DataS, ;
                        NVL(a.Locals, "") AS Locals, ;
                        NVL(a.Qtds, 0) AS Qtds, ;
                        NVL(a.vends, "") AS vends, ;
                        NVL(b.empos, "") AS empos, ;
                        NVL(b.Localizas, "") AS Localizas, ;
                        IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) AS Qtde ;
                        FROM crTmpLocal b ;
                        LEFT JOIN crSigCdCnl a ON a.Locals = b.Localizas ;
                        WHERE NVL(a.Qtds, 0) <> ;
                            IIF(NVL(a.estoque,0)<>0, NVL(a.estoque,0), NVL(b.Qtde,0)) ;
                        INTO CURSOR csRel READWRITE
                ENDCASE

                *-- Agrega resultado final com campos de nivel decompostos
                SELECT Datas, Locals, Vends, Empos, Localizas, ;
                    SUM(Qtds) AS Qtds, SUM(Qtde) AS Qtde, ;
                    SPACE(100) AS Descr, ;
                    LEFT(Locals, 2) AS Nivel1s, ;
                    SUBSTR(Locals, 3, 2) AS Nivel2s, ;
                    SUBSTR(Locals, 5, 2) AS Nivel3s, ;
                    SUBSTR(Locals, 7, 3) AS Nivel4s ;
                    FROM csRel ;
                    GROUP BY Datas, Locals, Vends, Empos, Localizas ;
                    INTO CURSOR crRel READWRITE

                *-- Enriquece descricao com nivel 3
                IF !USED("cursor_4c_SigLcNv3")
                    SQLEXEC(gnConnHandle, "SELECT Cods, Descs FROM SigLcNv3", "cursor_4c_SigLcNv3")
                ENDIF

                SELECT crRel
                INDEX ON Vends + Locals TAG Locals
                GO TOP
                SCAN
                    loc_lcNvl3Tmp = SUBSTR(crRel.Locals, 5, 2)
                    IF !EMPTY(loc_lcNvl3Tmp)
                        SELECT cursor_4c_SigLcNv3
                        LOCATE FOR ALLTRIM(Cods) = ALLTRIM(loc_lcNvl3Tmp)
                        IF FOUND()
                            REPLACE Descr WITH ALLTRIM(cursor_4c_SigLcNv3.Descs) IN crRel
                        ENDIF
                    ENDIF
                    SELECT crRel
                ENDSCAN

                *-- Aplica ordenacao final
                SELECT crRel
                DO CASE
                CASE loc_lnOrdem = 1
                    INDEX ON Locals TAG Locals
                CASE loc_lnOrdem = 2
                    INDEX ON Nivel2s TAG Nivel2s
                CASE loc_lnOrdem = 3
                    INDEX ON Nivel3s TAG Nivel3s
                CASE loc_lnOrdem = 4
                    INDEX ON Nivel4s TAG Nivel4s
                ENDCASE
                GO TOP

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                    TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Prepara dados e exporta para planilha Excel
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                    "contagem_localizacao", "xls")
                IF !EMPTY(loc_cArquivo)
                    SELECT crRel
                    COPY TO (loc_cArquivo) TYPE XLS
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro registrada
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros default a partir de um cursor de
    * parametros (ex: SigCdPam). Para o relatorio de Contagem, o unico
    * parametro persistido eh GrPadVens, usado nos lookups de vendedor.
    * Retorna .T. se carregou, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + CHR(227) + ;
                                       "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF
        TRY
            SELECT (par_cAliasCursor)
            GO TOP
            IF !EOF()
                IF TYPE("&par_cAliasCursor..GrPadVens") = "C"
                    THIS.this_cGrPadVens = ALLTRIM(NVL(EVALUATE(par_cAliasCursor + ".GrPadVens"), ""))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao nao aplicavel em BO de relatorio. O relatorio de
    * Contagem por Localizacao eh apenas leitura: consulta SigCdCnl/SigCdCnI/
    * SigOpEtq/SigMvesl e gera preview via REPORT FORM. Retorna .F. para
    * satisfazer contrato de BO e sinalizar que operacao nao se aplica.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao nao aplicavel em BO de relatorio. Vide observacao
    * em Inserir(). Retorna .F. e seta this_cMensagemErro.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + ;
            CHR(227) + "o n" + CHR(227) + "o se aplica ao relat" + CHR(243) + "rio de " + ;
            "Contagem por Localiza" + CHR(231) + CHR(227) + "o (somente leitura)."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador do relatorio (composto pela
    * data, empresa e filtro de localizacao) para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "RELCNT|" + ;
                     IIF(EMPTY(THIS.this_dData), "        ", DTOS(THIS.this_dData)) + "|" + ;
                     ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cBase) + ;
                     ALLTRIM(THIS.this_cNvl2) + ;
                     ALLTRIM(THIS.this_cNvl3) + ;
                     ALLTRIM(THIS.this_cNvl4)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de execucao do relatorio na
    * tabela LogAuditoria (Empresa, Usuario, DataHora, Operacao, Detalhes).
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cChave
        loc_lSucesso = .F.
        IF EMPTY(par_cOperacao)
            par_cOperacao = "VISUALIZAR"
        ENDIF
        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Empresa, Usuario, DataHora, Tabela, ChavePrimaria, Operacao, Detalhes) " + ;
                       "VALUES (" + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL("Relatorio_Contagem") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.this_cTituloRelatorio) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

