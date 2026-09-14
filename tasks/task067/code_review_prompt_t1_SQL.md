# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LCQRYEMP, CEMPS, CODIGOS, ICLIS, CONTAS, EMPS, SGRUPOS, SCONTAS, MOEDAS, NOPERS, TIPOS, OPERS, GRUPOS, VENCS, _X, VALPENDS, PARCS, 0, EMPDOPNUMS, MOEFPGS, FPAGS, VPAGS, BANCOS, OPERACAOS, AGENCIAS, NCHEQUES

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lcQryEmp = [Select CEmps,Razas From SigCdEmp Where CEmps=']+_Empr+[']
If (ThisForm.poDataMgr.SqlExecute(lcQryEmp, 'crSigCdEmp') < 1)
insert into CsCabecalho (cb_empresa,cb_titulo,cb_periodo) values (lcCbEmpresa,lcCbTitulo,lcCbPeriodo)
lcQrySigCdGcr = [Select * From SigCdGcr ]+Iif(!IsEmpty(lcGrupo),[ Where Codigos=']+lcGrupo+['],[])+[ Order By Codigos ]
If (ThisForm.poDataMgr.SqlExecute(lcQrySigCdGcr, 'crSigCdGcr') < 1)
Select crSigCdGcr
	  Select crSigMvCcr
	lcSigMvCcr = [Select a.contas, a.grupos, a.Nopers, a.Tipos, a.Emps, a.Dopes, a.Numes, a.opers, a.Datas, ]+;
				[ From SigMvCcr a, SigCdCli b ]+;
	If (ThisForm.poDataMgr.SqlExecute(lcSigMvCcr, 'crSigMvCcr') < 1)
	Select crSigMvCcr
			Insert Into Resultado ( Tipo, Grupo, Conta, Nome, Empresa, Data, Vecto, Historico, Integral, Pendente, Moeda ) ;
		lcQrySigMvCab = [Select a.empdopnums, a.]+_Grupo+[, a.]+_Conta+[, a.Datas, ]+;
   					   [ From SigMvCab a, SigCdOpe b, SigCdCli c ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQrySigMvCab, 'crSigMvCab') < 1)
		Select crSigMvCab
			lcQrySigMvPar = [Select  a.empdopnums, a.VPags, a.Valos, a.FPags, a.Moefpgs, ]+;
			              [ From SigMvPar a ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQrySigMvPar, 'crSigMvPar') < 1)
			Select crSigMvPar
				lcQrySigOpFps = [Select a.FPags, a.ValPends, a.Infos, a.Grupods, a.contads ]+;
				              [ From SigOpFp a ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQrySigOpFps, 'crSigOpFps') < 1)
					lcQrySigChe = [Select a.UMovs ] + ;
					              [ From SigChe a ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQrySigChe,'CrSigChe') < 1)
					lcQuery = [Select a.operacaos ] + ;
					          [ From SigCdOpt a ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdOpt') < 1)
					Select crSigCdOpt
				Insert Into Resultado ( Tipo, Grupo, Conta, Nome, Empresa, Data, Vecto, Historico, Integral, Pendente, Moeda ) ;
            Select crSigMvCab
Select crSigCdGcr
Select Resultado
Select Moeda, Sum(Integral) as Integral, Sum(Pendente) as Pendente ;
  From Resultado ;
Select Totaliza
	Insert Into Resultado ( Tipo, Moeda, Pendente, Integral ) ;
Select Resultado

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecrp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1661 linhas total):

*-- Linhas 812 a 835:
812:             RETURN
813:         ENDIF
814: 
815:         loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
816:                       "WHERE Codigos = " + EscaparSQL(loc_cValor)
817:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoVal")
818: 
819:         IF loc_nResult > 0
820:             SELECT cursor_4c_GrupoVal
821:             IF !EOF()
822:                 loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
823:                 loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
824:                 USE IN cursor_4c_GrupoVal
825:                 RETURN
826:             ENDIF
827:             USE IN cursor_4c_GrupoVal
828:         ENDIF
829: 
830:         loc_oPag.txt_4c__Ds_Grupo.Value = ""
831:         THIS.AbrirBuscaGrupoCont()
832:     ENDPROC
833: 
834:     *--------------------------------------------------------------------------
835:     * AbrirBuscaGrupoCont - FormBuscaAuxiliar para SigCdGcr (Codigos / Descrs)

*-- Linhas 847 a 875:
847:         IF VARTYPE(loc_oBusca) = "O"
848:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
849:                 IF USED("cursor_4c_BuscaGCont")
850:                     SELECT cursor_4c_BuscaGCont
851:                     loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
852:                     loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
853:                 ENDIF
854:             ELSE
855:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
856:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
857:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
858:                 loc_oBusca.Show()
859:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGCont")
860:                     SELECT cursor_4c_BuscaGCont
861:                     loc_oPag.txt_4c_Grupo.Value     = ALLTRIM(Codigos)
862:                     loc_oPag.txt_4c__Ds_Grupo.Value = ALLTRIM(Descrs)
863:                 ENDIF
864:                 ENDIF
865:             ENDIF
866:             loc_oBusca.Release()
867:         ENDIF
868: 
869:         IF USED("cursor_4c_BuscaGCont")
870:             USE IN cursor_4c_BuscaGCont
871:         ENDIF
872:     ENDPROC
873: 
874:     *--------------------------------------------------------------------------
875:     * ValidarContaCodigo - Valida codigo digitado em txt_4c_Conta

*-- Linhas 886 a 909:
886:             RETURN
887:         ENDIF
888: 
889:         loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli " + ;
890:                       "WHERE iclis = " + EscaparSQL(loc_cValor)
891:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaVal")
892: 
893:         IF loc_nResult > 0
894:             SELECT cursor_4c_ContaVal
895:             IF !EOF()
896:                 loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
897:                 loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
898:                 USE IN cursor_4c_ContaVal
899:                 RETURN
900:             ENDIF
901:             USE IN cursor_4c_ContaVal
902:         ENDIF
903: 
904:         loc_oPag.txt_4c_DCONTA.Value = ""
905:         THIS.AbrirBuscaContaCont()
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * AbrirBuscaContaCont - FormBuscaAuxiliar para SigCdCli (iclis / rclis)

*-- Linhas 921 a 949:
921:         IF VARTYPE(loc_oBusca) = "O"
922:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
923:                 IF USED("cursor_4c_BuscaCCont")
924:                     SELECT cursor_4c_BuscaCCont
925:                     loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
926:                     loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
927:                 ENDIF
928:             ELSE
929:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
930:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
931:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
932:                 loc_oBusca.Show()
933:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCCont")
934:                     SELECT cursor_4c_BuscaCCont
935:                     loc_oPag.txt_4c_Conta.Value  = ALLTRIM(iclis)
936:                     loc_oPag.txt_4c_DCONTA.Value = ALLTRIM(rclis)
937:                 ENDIF
938:                 ENDIF
939:             ENDIF
940:             loc_oBusca.Release()
941:         ENDIF
942: 
943:         IF USED("cursor_4c_BuscaCCont")
944:             USE IN cursor_4c_BuscaCCont
945:         ENDIF
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * TeclaSgrupoCod - KeyPress em txt_4c_Sgrupo (codigo do subgrupo CP)

*-- Linhas 984 a 1007:
984:             RETURN
985:         ENDIF
986: 
987:         loc_cSQL    = "SELECT Codigos, Descrs FROM SigCdGcr " + ;
988:                       "WHERE Codigos = " + EscaparSQL(loc_cValor)
989:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SgrupoVal")
990: 
991:         IF loc_nResult > 0
992:             SELECT cursor_4c_SgrupoVal
993:             IF !EOF()
994:                 loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
995:                 loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
996:                 USE IN cursor_4c_SgrupoVal
997:                 RETURN
998:             ENDIF
999:             USE IN cursor_4c_SgrupoVal
1000:         ENDIF
1001: 
1002:         loc_oPag.txt_4c_Dsgrupo.Value = ""
1003:         THIS.AbrirBuscaSgrupoCont()
1004:     ENDPROC
1005: 
1006:     *--------------------------------------------------------------------------
1007:     * AbrirBuscaSgrupoCont - FormBuscaAuxiliar para SigCdGcr (Codigos / Descrs)

*-- Linhas 1019 a 1047:
1019:         IF VARTYPE(loc_oBusca) = "O"
1020:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1021:                 IF USED("cursor_4c_BuscaSGCont")
1022:                     SELECT cursor_4c_BuscaSGCont
1023:                     loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
1024:                     loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
1025:                 ENDIF
1026:             ELSE
1027:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
1028:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1029:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1030:                 loc_oBusca.Show()
1031:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSGCont")
1032:                     SELECT cursor_4c_BuscaSGCont
1033:                     loc_oPag.txt_4c_Sgrupo.Value  = ALLTRIM(Codigos)
1034:                     loc_oPag.txt_4c_Dsgrupo.Value = ALLTRIM(Descrs)
1035:                 ENDIF
1036:                 ENDIF
1037:             ENDIF
1038:             loc_oBusca.Release()
1039:         ENDIF
1040: 
1041:         IF USED("cursor_4c_BuscaSGCont")
1042:             USE IN cursor_4c_BuscaSGCont
1043:         ENDIF
1044:     ENDPROC
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * TeclaScontaCod - KeyPress em txt_4c_Sconta (codigo da subconta CP)

*-- Linhas 1082 a 1105:
1082:             RETURN
1083:         ENDIF
1084: 
1085:         loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli " + ;
1086:                       "WHERE iclis = " + EscaparSQL(loc_cValor)
1087:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ScontaVal")
1088: 
1089:         IF loc_nResult > 0
1090:             SELECT cursor_4c_ScontaVal
1091:             IF !EOF()
1092:                 loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
1093:                 loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
1094:                 USE IN cursor_4c_ScontaVal
1095:                 RETURN
1096:             ENDIF
1097:             USE IN cursor_4c_ScontaVal
1098:         ENDIF
1099: 
1100:         loc_oPag.txt_4c_DsConta.Value = ""
1101:         THIS.AbrirBuscaSconta()
1102:     ENDPROC
1103: 
1104:     *--------------------------------------------------------------------------
1105:     * AbrirBuscaSconta - FormBuscaAuxiliar para SigCdCli (iclis / rclis)

*-- Linhas 1117 a 1145:
1117:         IF VARTYPE(loc_oBusca) = "O"
1118:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1119:                 IF USED("cursor_4c_BuscaSConta")
1120:                     SELECT cursor_4c_BuscaSConta
1121:                     loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
1122:                     loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
1123:                 ENDIF
1124:             ELSE
1125:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
1126:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1127:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1128:                 loc_oBusca.Show()
1129:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSConta")
1130:                     SELECT cursor_4c_BuscaSConta
1131:                     loc_oPag.txt_4c_Sconta.Value  = ALLTRIM(iclis)
1132:                     loc_oPag.txt_4c_DsConta.Value = ALLTRIM(rclis)
1133:                 ENDIF
1134:                 ENDIF
1135:             ENDIF
1136:             loc_oBusca.Release()
1137:         ENDIF
1138: 
1139:         IF USED("cursor_4c_BuscaSConta")
1140:             USE IN cursor_4c_BuscaSConta
1141:         ENDIF
1142:     ENDPROC
1143: 
1144:     *--------------------------------------------------------------------------
1145:     * TeclaEmpresaCod - KeyPress em txt_4c__cd_empresa (codigo da empresa)

*-- Linhas 1180 a 1203:
1180:             RETURN
1181:         ENDIF
1182: 
1183:         loc_cSQL    = "SELECT cemps, razas FROM sigcdemp " + ;
1184:                       "WHERE cemps = " + EscaparSQL(loc_cValor)
1185:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresaVal")
1186: 
1187:         IF loc_nResult > 0
1188:             SELECT cursor_4c_EmpresaVal
1189:             IF !EOF()
1190:                 loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
1191:                 loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
1192:                 USE IN cursor_4c_EmpresaVal
1193:                 RETURN
1194:             ENDIF
1195:             USE IN cursor_4c_EmpresaVal
1196:         ENDIF
1197: 
1198:         loc_oPag.txt_4c__ds_empresa.Value = ""
1199:         THIS.AbrirBuscaEmpresa()
1200:     ENDPROC
1201: 
1202:     *--------------------------------------------------------------------------
1203:     * AbrirBuscaEmpresa - FormBuscaAuxiliar para sigcdemp (cemps / razas)

*-- Linhas 1215 a 1243:
1215:         IF VARTYPE(loc_oBusca) = "O"
1216:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1217:                 IF USED("cursor_4c_BuscaEmpresa")
1218:                     SELECT cursor_4c_BuscaEmpresa
1219:                     loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
1220:                     loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
1221:                 ENDIF
1222:             ELSE
1223:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
1224:                 loc_oBusca.mAddColuna("cemps", "", "C" + CHR(243) + "digo")
1225:                 loc_oBusca.mAddColuna("razas", "", "Empresa")
1226:                 loc_oBusca.Show()
1227:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmpresa")
1228:                     SELECT cursor_4c_BuscaEmpresa
1229:                     loc_oPag.txt_4c__cd_empresa.Value = ALLTRIM(cemps)
1230:                     loc_oPag.txt_4c__ds_empresa.Value = ALLTRIM(razas)
1231:                 ENDIF
1232:                 ENDIF
1233:             ENDIF
1234:             loc_oBusca.Release()
1235:         ENDIF
1236: 
1237:         IF USED("cursor_4c_BuscaEmpresa")
1238:             USE IN cursor_4c_BuscaEmpresa
1239:         ENDIF
1240:     ENDPROC
1241: 
1242:     *--------------------------------------------------------------------------
1243:     * TeclaMoedaCod - KeyPress em txt_4c__cd_moeda (codigo da moeda)

*-- Linhas 1278 a 1301:
1278:             RETURN
1279:         ENDIF
1280: 
1281:         loc_cSQL    = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
1282:                       "WHERE cmoes = " + EscaparSQL(loc_cValor)
1283:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaVal")
1284: 
1285:         IF loc_nResult > 0
1286:             SELECT cursor_4c_MoedaVal
1287:             IF !EOF()
1288:                 loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1289:                 loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1290:                 USE IN cursor_4c_MoedaVal
1291:                 RETURN
1292:             ENDIF
1293:             USE IN cursor_4c_MoedaVal
1294:         ENDIF
1295: 
1296:         loc_oPag.txt_4c__ds_moeda.Value = ""
1297:         THIS.AbrirBuscaMoeda()
1298:     ENDPROC
1299: 
1300:     *--------------------------------------------------------------------------
1301:     * AbrirBuscaMoeda - FormBuscaAuxiliar para SigCdMoe (cmoes / dmoes)

*-- Linhas 1313 a 1341:
1313:         IF VARTYPE(loc_oBusca) = "O"
1314:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1315:                 IF USED("cursor_4c_BuscaMoeda")
1316:                     SELECT cursor_4c_BuscaMoeda
1317:                     loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1318:                     loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1319:                 ENDIF
1320:             ELSE
1321:                 IF !loc_oBusca.this_lAchouRegistro OR EMPTY(loc_cValor)
1322:                 loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1323:                 loc_oBusca.mAddColuna("dmoes", "", "Moeda")
1324:                 loc_oBusca.Show()
1325:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
1326:                     SELECT cursor_4c_BuscaMoeda
1327:                     loc_oPag.txt_4c__cd_moeda.Value = ALLTRIM(cmoes)
1328:                     loc_oPag.txt_4c__ds_moeda.Value = ALLTRIM(dmoes)
1329:                 ENDIF
1330:                 ENDIF
1331:             ENDIF
1332:             loc_oBusca.Release()
1333:         ENDIF
1334: 
1335:         IF USED("cursor_4c_BuscaMoeda")
1336:             USE IN cursor_4c_BuscaMoeda
1337:         ENDIF
1338:     ENDPROC
1339: 
1340:     *--------------------------------------------------------------------------
1341:     * FormParaRelatorio - Transfere valores dos controles para as propriedades do BO

*-- Linhas 1394 a 1412:
1394:                 IF THIS.this_oRelatorio.PrepararDados()
1395:                     loc_cArquivo = SYS(2023) + "\sigrecrp_" + ;
1396:                                    STRTRAN(DTOC(DATE()), "/", "") + ".xls"
1397:                     SELECT cursor_4c_Dados
1398:                     COPY TO (loc_cArquivo) TYPE XL5
1399:                     MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, ;
1400:                         "Exportar Excel")
1401:                 ENDIF
1402:             ENDIF
1403:         CATCH TO loc_oErro
1404:             MsgErro(loc_oErro.Message + CHR(13) + ;
1405:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro ao Exportar")
1406:         ENDTRY
1407:     ENDPROC
1408: 
1409:     *--------------------------------------------------------------------------
1410:     * BtnEncerrarClick - Buttons(4) click (Cancel=.T. dispara no ESC): fecha form
1411:     *--------------------------------------------------------------------------
1412:     PROCEDURE BtnEncerrarClick()


### BO (C:\4c\projeto\app\classes\sigrecrpBO.prg):
*==============================================================================
* SIGRECRPBO.PRG
* Business Object para SIGRECRP - Debitos e Creditos em Aberto
* Herda de RelatorioBase
*==============================================================================

DEFINE CLASS sigrecrpBO AS RelatorioBase

    this_cArquivoFRX    = ""
    this_cTitulo        = ""
    this_cCursorDados   = "cursor_4c_Dados"
    this_lMensagemAviso = .F.

    *-- Opcao: 1=Debito (D), 2=Credito (C)
    this_nOper          = 1

    *-- Grupo conta contabil principal
    this_cGrupo         = ""
    this_cDsGrupo       = ""

    *-- Conta contabil principal
    this_cConta         = ""
    this_cDConta        = ""

    *-- Subgrupo contra partida
    this_cSgrupo        = ""
    this_cDsgrupo       = ""

    *-- Subconta contra partida
    this_cSconta        = ""
    this_cDsConta       = ""

    *-- Empresa
    this_cCdEmpresa     = ""
    this_cDsEmpresa     = ""

    *-- Periodo de vencimento
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Moeda
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSigrecrp.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de D" + CHR(233) + "bitos/Cr" + CHR(233) + "ditos Pendentes"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa processamento e popula cursor_4c_Dados e cursor_4c_Cabecalho
    * Replica logica completa do procedimento "processamento" do SIGRECRP.SCX
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_nResult, loc_cSQL
        LOCAL loc_nOper, loc_cOperacao
        LOCAL loc_cGrupo, loc_cConta, loc_cSgrupo, loc_cSconta
        LOCAL loc_cCdEmpresa, loc_cMoeda
        LOCAL loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo
        LOCAL loc_nX, loc_cCampoGrupo, loc_cCampoConta
        LOCAL loc_cCodigoGrupo
        LOCAL loc_cContasCab, loc_cNomeCab, loc_dDataCab, loc_cEmpdopnums
        LOCAL loc_cEmps, loc_cDopes, loc_cNumes, loc_cHist
        LOCAL loc_nValor, loc_nTipo, loc_cOpers
        LOCAL ldInicial, ldFinal

        THIS.this_cMensagemErro  = ""
        THIS.this_lMensagemAviso = .F.

        *-- Mapear filtros das propriedades
        loc_nOper      = THIS.this_nOper
        loc_cGrupo     = ALLTRIM(THIS.this_cGrupo)
        loc_cConta     = ALLTRIM(THIS.this_cConta)
        loc_cSgrupo    = ALLTRIM(THIS.this_cSgrupo)
        loc_cSconta    = ALLTRIM(THIS.this_cSconta)
        loc_cCdEmpresa = ALLTRIM(THIS.this_cCdEmpresa)
        loc_cMoeda     = ALLTRIM(THIS.this_cCdMoeda)
        ldInicial      = THIS.this_dDtInicial
        ldFinal        = THIS.this_dDtFinal

        *-- Busca dados da empresa para cabecalho
        loc_cSQL = "SELECT CEmps, Razas FROM SigCdEmp" + ;
                   " WHERE CEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpEmp")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdEmp)"
            RETURN .F.
        ENDIF
        loc_cCbEmpresa = ""
        SELECT cursor_4c_SigrecrpEmp
        IF !EOF()
            loc_cCbEmpresa = ALLTRIM(cursor_4c_SigrecrpEmp.Razas)
        ENDIF
        USE IN cursor_4c_SigrecrpEmp

        *-- Monta strings de cabecalho
        loc_cOperacao  = IIF(loc_nOper = 1, "D", "C")
        loc_cCbTitulo  = "Relat" + CHR(243) + "rio de " + ;
                         IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                         " Pendentes"
        loc_cCbPeriodo = " de " + DTOC(ldInicial) + " " + CHR(224) + " " + DTOC(ldFinal)
        loc_cCbTitulo  = loc_cCbTitulo + loc_cCbPeriodo

        *-- Cursor de cabecalho para o relatorio
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        CREATE CURSOR cursor_4c_Cabecalho (cb_empresa C(80), cb_titulo C(80), cb_periodo C(80))
        INSERT INTO cursor_4c_Cabecalho (cb_empresa, cb_titulo, cb_periodo) ;
            VALUES (loc_cCbEmpresa, loc_cCbTitulo, loc_cCbPeriodo)

        *-- Cursor principal de resultado
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        CREATE CURSOR cursor_4c_Dados ( ;
            Tipo      N(1), ;
            Grupo     C(10), ;
            Conta     C(10), ;
            Nome      C(40), ;
            Empresa   C(3), ;
            Data      D, ;
            Vecto     D, ;
            Historico C(40), ;
            Integral  N(12,2), ;
            Pendente  N(12,2), ;
            Moeda     C(3))

        *-- Busca grupos contabeis conforme filtro
        loc_cSQL = "SELECT * FROM SigCdGcr" + ;
                   IIF(!EMPTY(loc_cGrupo), " WHERE Codigos = " + EscaparSQL(loc_cGrupo), "") + ;
                   " ORDER BY Codigos"
        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpGcr")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                      "Falha na Conex" + CHR(227) + "o (SigCdGcr)"
            RETURN .F.
        ENDIF

        *-- Itera grupos contabeis
        SELECT cursor_4c_SigrecrpGcr
        SCAN
            loc_cCodigoGrupo = ALLTRIM(cursor_4c_SigrecrpGcr.Codigos)

            IF USED("cursor_4c_SigrecrpMvCcr")
                SELECT cursor_4c_SigrecrpMvCcr
                ZAP
                USE IN cursor_4c_SigrecrpMvCcr
            ENDIF

            *-- Busca movimentos conta corrente (SigMvCcr)
            loc_cSQL = "SELECT a.contas, a.grupos, a.Nopers, a.Tipos," + ;
                       " a.Emps, a.Dopes, a.Numes, a.opers, a.Datas," + ;
                       " a.Valors, a.ValPags, a.Moedas, a.Vencs, a.Hists," + ;
                       " b.iclis, b.rclis" + ;
                       " FROM SigMvCcr a, SigCdCli b" + ;
                       " WHERE b.iclis = a.contas" + ;
                       IIF(!EMPTY(loc_cConta),     " AND a.Contas = "  + EscaparSQL(loc_cConta), " ") + ;
                       IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = "    + EscaparSQL(loc_cCdEmpresa), "") + ;
                       IIF(!EMPTY(loc_cSgrupo),    " AND a.Sgrupos = " + EscaparSQL(loc_cSgrupo), " ") + ;
                       IIF(!EMPTY(loc_cSconta),    " AND a.SContas = " + EscaparSQL(loc_cSconta), " ") + ;
                       IIF(!EMPTY(loc_cMoeda),     " AND a.Moedas = "  + EscaparSQL(loc_cMoeda), " ") + ;
                       " AND a.Nopers <> 0 AND (a.Tipos = ' ' OR a.Tipos = 'X')" + ;
                       " AND a.Opers = " + EscaparSQL(loc_cOperacao) + ;
                       " AND a.grupos = " + EscaparSQL(loc_cCodigoGrupo) + ;
                       " AND a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                       " ORDER BY GruConMoes"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCcr")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                          "Falha na Conex" + CHR(227) + "o (SigMvCcr)"
                RETURN .F.
            ENDIF

            *-- Processa movimentos conta corrente
            SELECT cursor_4c_SigrecrpMvCcr
            SCAN
                IF !EMPTY(cursor_4c_SigrecrpMvCcr.Dopes) AND ;
                   !EMPTY(cursor_4c_SigrecrpMvCcr.Numes) AND ;
                   ALLTRIM(cursor_4c_SigrecrpMvCcr.Tipos) <> "X"
                    LOOP
                ENDIF
                loc_nValor = cursor_4c_SigrecrpMvCcr.Valors - cursor_4c_SigrecrpMvCcr.ValPags
                IF loc_nValor <> 0
                    INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                        Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                        VALUES (1, loc_cCodigoGrupo, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Contas), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.RClis), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Emps), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Datas, CTOD(SPACE(8))), ;
                            NVL(cursor_4c_SigrecrpMvCcr.Vencs, CTOD(SPACE(8))), ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Hists), ;
                            cursor_4c_SigrecrpMvCcr.Valors, ;
                            loc_nValor, ;
                            ALLTRIM(cursor_4c_SigrecrpMvCcr.Moedas))
                ENDIF
            ENDSCAN

            *-- Loop x=1 (Grupods/Contads) e x=2 (Grupoos/Contaos) - SigMvCab
            FOR loc_nX = 1 TO 2
                IF loc_nX = 1
                    loc_cCampoGrupo = "Grupods"
                    loc_cCampoConta = "Contads"
                ELSE
                    loc_cCampoGrupo = "Grupoos"
                    loc_cCampoConta = "Contaos"
                ENDIF

                loc_cSQL = "SELECT a.empdopnums, a." + loc_cCampoGrupo + ;
                           ", a." + loc_cCampoConta + ", a.Datas," + ;
                           " b.Dopes, b.ValPends, b.parcs, b.Copers, c.iclis, c.rclis" + ;
                           " FROM SigMvCab a, SigCdOpe b, SigCdCli c" + ;
                           " WHERE a." + loc_cCampoGrupo + " = " + EscaparSQL(loc_cCodigoGrupo) + ;
                           IIF(!EMPTY(loc_cConta), " AND a." + loc_cCampoConta + " = " + EscaparSQL(loc_cConta), "") + ;
                           " AND (b.Dopes = a.Dopes AND b.ValPends = 1 AND b.parcs = 1)" + ;
                           IIF(!EMPTY(loc_cCdEmpresa), " AND a.Emps = " + EscaparSQL(loc_cCdEmpresa), "") + ;
                           IIF(!EMPTY(loc_cSgrupo), " AND 0 = 1", "") + ;
                           IIF(!EMPTY(loc_cSconta), " AND 0 = 1", "") + ;
                           " AND c.iclis = a." + loc_cCampoConta + ;
                           " ORDER BY " + loc_cCampoGrupo + ", " + loc_cCampoConta
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvCab")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                              "Falha na Conex" + CHR(227) + "o (SigMvCab)"
                    RETURN .F.
                ENDIF

                SELECT cursor_4c_SigrecrpMvCab
                GO TOP
                SCAN
                    *-- Captura valores da linha atual de MvCab antes de entrar no SCAN interno
                    loc_cContasCab  = EVALUATE("cursor_4c_SigrecrpMvCab." + loc_cCampoConta)
                    loc_cNomeCab    = ALLTRIM(cursor_4c_SigrecrpMvCab.rclis)
                    loc_dDataCab    = cursor_4c_SigrecrpMvCab.Datas
                    loc_cEmpdopnums = ALLTRIM(cursor_4c_SigrecrpMvCab.empdopnums)

                    loc_cSQL = "SELECT a.empdopnums, a.VPags, a.Valos, a.FPags, a.Moefpgs," + ;
                               " a.Bancos, a.Agencias, a.Contas, a.Numeros, a.Nopers, a.Vencs" + ;
                               " FROM SigMvPar a" + ;
                               " WHERE a.Vencs BETWEEN ?ldInicial AND ?ldFinal" + ;
                               " AND a.empdopnums = " + EscaparSQL(loc_cEmpdopnums) + ;
                               IIF(EMPTY(loc_cMoeda), "", " AND a.Moefpgs = " + EscaparSQL(loc_cMoeda))
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpMvPar")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                  "Falha na Conex" + CHR(227) + "o (SigMvPar)"
                        RETURN .F.
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvPar
                    SCAN
                        loc_cSQL = "SELECT a.FPags, a.ValPends, a.Infos, a.Grupods, a.contads" + ;
                                   " FROM SigOpFp a" + ;
                                   " WHERE a.FPags = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.FPags))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpFp")
                        IF loc_nResult < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                      "Falha na Conex" + CHR(227) + "o (SigOpFps)"
                            RETURN .F.
                        ENDIF

                        IF (cursor_4c_SigrecrpOpFp.Valpends <> 1 OR ;
                            cursor_4c_SigrecrpMvPar.Nopers = 0) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF
                        IF !EMPTY(cursor_4c_SigrecrpOpFp.Grupods) AND ;
                           !EMPTY(cursor_4c_SigrecrpOpFp.Contads) AND ;
                           cursor_4c_SigrecrpMvPar.VPags = cursor_4c_SigrecrpMvPar.Valos
                            LOOP
                        ENDIF

                        *-- Verifica cheque se forma de pagamento = "C"
                        IF ALLTRIM(cursor_4c_SigrecrpOpFp.Infos) = "C"
                            loc_cSQL = "SELECT a.UMovs FROM SigChe a" + ;
                                       " WHERE a.Bancos = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Bancos)) + ;
                                       " AND a.Agencias = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Agencias)) + ;
                                       " AND a.Contas = "     + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Contas)) + ;
                                       " AND a.ncheques = "   + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpMvPar.Numeros))
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpChe")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigChe)"
                                RETURN .F.
                            ENDIF

                            loc_cSQL = "SELECT a.operacaos FROM SigCdOpt a" + ;
                                       " WHERE a.Operacaos = " + EscaparSQL(ALLTRIM(cursor_4c_SigrecrpChe.UMovs)) + ;
                                       " AND a.Tipos = 'DB'"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigrecrpOpt")
                            IF loc_nResult < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                                          "Falha na Conex" + CHR(227) + "o (SigCdOpt)"
                                RETURN .F.
                            ENDIF

                            SELECT cursor_4c_SigrecrpOpt
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_SigrecrpMvPar
                                LOOP
                            ENDIF
                        ENDIF

                        *-- Determina direcao da operacao (D=debito, C=credito)
                        IF cursor_4c_SigrecrpOpFp.Valpends <> 1 AND ;
                           cursor_4c_SigrecrpMvPar.VPags <> cursor_4c_SigrecrpMvPar.Valos
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "C", "D")
                        ELSE
                            loc_cOpers = IIF(cursor_4c_SigrecrpMvCab.Copers = 1, "D", "C")
                        ENDIF

                        *-- Filtra por tipo de operacao solicitado
                        IF (loc_nOper = 1 AND loc_cOpers = "C") OR ;
                           (loc_nOper = 2 AND loc_cOpers = "D")
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        loc_cEmps  = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 1, 3)
                        loc_cDopes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 4, 20)
                        loc_cNumes = SUBSTR(ALLTRIM(cursor_4c_SigrecrpMvPar.empdopnums), 24, 6)
                        loc_cHist  = ALLTRIM(cursor_4c_SigrecrpMvPar.FPags) + " " + ;
                                     loc_cEmps + ALLTRIM(loc_cDopes) + " " + ALLTRIM(loc_cNumes)
                        loc_nValor = cursor_4c_SigrecrpMvPar.Valos - cursor_4c_SigrecrpMvPar.VPags

                        IF loc_nValor = 0
                            SELECT cursor_4c_SigrecrpMvPar
                            LOOP
                        ENDIF

                        INSERT INTO cursor_4c_Dados (Tipo, Grupo, Conta, Nome, Empresa, ;
                            Data, Vecto, Historico, Integral, Pendente, Moeda) ;
                            VALUES (1, loc_cCodigoGrupo, ALLTRIM(loc_cContasCab), ;
                                ALLTRIM(loc_cNomeCab), ALLTRIM(loc_cEmps), ;
                                loc_dDataCab, cursor_4c_SigrecrpMvPar.Vencs, ;
                                ALLTRIM(loc_cHist), cursor_4c_SigrecrpMvPar.Valos, ;
                                loc_nValor, ALLTRIM(cursor_4c_SigrecrpMvPar.Moefpgs))

                        SELECT cursor_4c_SigrecrpMvPar
                    ENDSCAN

                    IF USED("cursor_4c_SigrecrpMvPar")
                        USE IN cursor_4c_SigrecrpMvPar
                    ENDIF

                    SELECT cursor_4c_SigrecrpMvCab
                ENDSCAN

                IF USED("cursor_4c_SigrecrpMvCab")
                    USE IN cursor_4c_SigrecrpMvCab
                ENDIF
            ENDFOR

            SELECT cursor_4c_SigrecrpGcr
        ENDSCAN

        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF

        *-- Verifica se ha dados no resultado
        SELECT cursor_4c_Dados
        INDEX ON STR(Tipo, 1) + Empresa + Grupo + Conta + DTOS(Vecto) TAG GruConVec
        GO TOP
        IF EOF()
            THIS.this_cMensagemErro  = "N" + CHR(227) + "o h" + CHR(225) + " " + ;
                IIF(loc_nOper = 1, "D" + CHR(233) + "bitos", "Cr" + CHR(233) + "ditos") + ;
                " pendente nesta conta!"
            THIS.this_lMensagemAviso = .T.
            RETURN .F.
        ENDIF

        *-- Totaliza por moeda e insere linhas de totalizacao
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        SELECT Moeda, SUM(Integral) AS Integral, SUM(Pendente) AS Pendente ;
            FROM cursor_4c_Dados ;
            GROUP BY Moeda ;
            ORDER BY Moeda ;
            INTO CURSOR cursor_4c_SigrecrpTotaliza

        loc_nTipo = 2
        SELECT cursor_4c_SigrecrpTotaliza
        SCAN
            SELECT cursor_4c_Dados
            INSERT INTO cursor_4c_Dados (Tipo, Moeda, Pendente, Integral) ;
                VALUES (loc_nTipo, ALLTRIM(cursor_4c_SigrecrpTotaliza.Moeda), ;
                    cursor_4c_SigrecrpTotaliza.Pendente, ;
                    cursor_4c_SigrecrpTotaliza.Integral)
            IF loc_nTipo = 2
                loc_nTipo = 3
            ENDIF
            SELECT cursor_4c_SigrecrpTotaliza
        ENDSCAN

        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF

        SELECT cursor_4c_Dados
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe relatorio em tela (preview)
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio na impressora com dialogo de escolha
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
                    IF THIS.this_lMensagemAviso
                        MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                    ENDIF
                    THIS.this_cMensagemErro = ""
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave logica do relatorio (filtros aplicados)
    * Relatorios nao tem PK fisica - chave eh composta pelos filtros.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "SIGRECRP|" + ;
                     STR(THIS.this_nOper, 1) + "|" + ;
                     DTOS(THIS.this_dDtInicial) + "|" + ;
                     DTOS(THIS.this_dDtFinal) + "|" + ;
                     ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta) + "|" + ;
                     ALLTRIM(THIS.this_cSgrupo) + "|" + ;
                     ALLTRIM(THIS.this_cSconta) + "|" + ;
                     ALLTRIM(THIS.this_cCdMoeda)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de cursor
    * Permite restaurar configuracao de filtros previamente salva.
    * par_cAliasCursor: alias do cursor com colunas Oper, DtInicial, DtFinal,
    *   CdEmpresa, DsEmpresa, Grupo, DsGrupo, Conta, DConta, Sgrupo, Dsgrupo,
    *   Sconta, DsConta, CdMoeda, DsMoeda
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErr, loc_cAlias
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                                      CHR(227) + "o dispon" + CHR(237) + "vel: " + ;
                                      TRANSFORM(par_cAliasCursor)
            RETURN .F.
        ENDIF

        loc_cAlias = par_cAliasCursor

        TRY
            SELECT (loc_cAlias)
            IF !EOF()
                IF TYPE(loc_cAlias + ".Oper") = "N"
                    THIS.this_nOper = EVALUATE(loc_cAlias + ".Oper")
                ENDIF
                IF TYPE(loc_cAlias + ".DtInicial") = "D"
                    THIS.this_dDtInicial = EVALUATE(loc_cAlias + ".DtInicial")
                ENDIF
                IF TYPE(loc_cAlias + ".DtFinal") = "D"
                    THIS.this_dDtFinal = EVALUATE(loc_cAlias + ".DtFinal")
                ENDIF
                IF TYPE(loc_cAlias + ".CdEmpresa") = "C"
                    THIS.this_cCdEmpresa = EVALUATE(loc_cAlias + ".CdEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".DsEmpresa") = "C"
                    THIS.this_cDsEmpresa = EVALUATE(loc_cAlias + ".DsEmpresa")
                ENDIF
                IF TYPE(loc_cAlias + ".Grupo") = "C"
                    THIS.this_cGrupo = EVALUATE(loc_cAlias + ".Grupo")
                ENDIF
                IF TYPE(loc_cAlias + ".DsGrupo") = "C"
                    THIS.this_cDsGrupo = EVALUATE(loc_cAlias + ".DsGrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Conta") = "C"
                    THIS.this_cConta = EVALUATE(loc_cAlias + ".Conta")
                ENDIF
                IF TYPE(loc_cAlias + ".DConta") = "C"
                    THIS.this_cDConta = EVALUATE(loc_cAlias + ".DConta")
                ENDIF
                IF TYPE(loc_cAlias + ".Sgrupo") = "C"
                    THIS.this_cSgrupo = EVALUATE(loc_cAlias + ".Sgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Dsgrupo") = "C"
                    THIS.this_cDsgrupo = EVALUATE(loc_cAlias + ".Dsgrupo")
                ENDIF
                IF TYPE(loc_cAlias + ".Sconta") = "C"
                    THIS.this_cSconta = EVALUATE(loc_cAlias + ".Sconta")
                ENDIF
                IF TYPE(loc_cAlias + ".DsConta") = "C"
                    THIS.this_cDsConta = EVALUATE(loc_cAlias + ".DsConta")
                ENDIF
                IF TYPE(loc_cAlias + ".CdMoeda") = "C"
                    THIS.this_cCdMoeda = EVALUATE(loc_cAlias + ".CdMoeda")
                ENDIF
                IF TYPE(loc_cAlias + ".DsMoeda") = "C"
                    THIS.this_cDsMoeda = EVALUATE(loc_cAlias + ".DsMoeda")
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + ;
                                          "metros vazio"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra execucao do relatorio em LogAuditoria
    * Para relatorios, "Inserir" significa registrar nova execucao,
    * permitindo rastrear quem rodou qual relatorio e quando.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar execu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Inserir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Registra reexecucao do relatorio em LogAuditoria
    * Para relatorios, "Atualizar" significa registrar uma reexecucao
    * (usuario alterou filtros e gerou o relatorio novamente).
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_oErr
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.RegistrarAuditoria("REPORT_RERUN")
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao registrar reexecu" + ;
                                          CHR(231) + CHR(227) + "o do relat" + ;
                                          CHR(243) + "rio em LogAuditoria"
            ENDIF
        CATCH TO loc_oErr
            THIS.this_cMensagemErro = loc_oErr.Message
            MsgErro(loc_oErr.Message, "Atualizar")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigrecrpEmp")
            USE IN cursor_4c_SigrecrpEmp
        ENDIF
        IF USED("cursor_4c_SigrecrpGcr")
            USE IN cursor_4c_SigrecrpGcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCcr")
            USE IN cursor_4c_SigrecrpMvCcr
        ENDIF
        IF USED("cursor_4c_SigrecrpMvCab")
            USE IN cursor_4c_SigrecrpMvCab
        ENDIF
        IF USED("cursor_4c_SigrecrpMvPar")
            USE IN cursor_4c_SigrecrpMvPar
        ENDIF
        IF USED("cursor_4c_SigrecrpOpFp")
            USE IN cursor_4c_SigrecrpOpFp
        ENDIF
        IF USED("cursor_4c_SigrecrpChe")
            USE IN cursor_4c_SigrecrpChe
        ENDIF
        IF USED("cursor_4c_SigrecrpOpt")
            USE IN cursor_4c_SigrecrpOpt
        ENDIF
        IF USED("cursor_4c_SigrecrpTotaliza")
            USE IN cursor_4c_SigrecrpTotaliza
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

