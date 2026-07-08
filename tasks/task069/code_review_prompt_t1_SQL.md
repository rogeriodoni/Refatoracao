# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (6)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RAZAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DCARGS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CEMPS, CCOMIS, BXCOMIS, DATAS, EMPS, NOPT, GRRESPS, RESPS, FCOMIS, VENDS, GRVENDS, CONTAS, EMPDOPNUMS, INFOS

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
lcQrySigCdEmp   = [Select cemps,razas From SigCdEmp Where cemps=']+_Empr+[']
lcQrySigCdPam = [Select MoedaPs From SigCdPam ]
lcQrySigCdMoe   = [Select cmoes,dmoes,cotas,datatrans,fmults,nordrels,disfpres,valadics,grumoes,moeqs,qtdeqs,submoes ]+;
				  [ From SigCdMoe ] + ;
	lcQueryCot   = [Select * From SigCdCot ]
	lcQueRyMoe   = [Select * From SigCdMoe ] 
		Select CrSigCdCot
		Select CrSigCdMoe
		Select crSigCdMoe
		if Seek(crSigCdPam.MoedaPs,"crSigCdMoe","CMOES")
Insert   Into cabecalho (pNmEmp,pRelTitulo,pRelTitul2,pPeriodo) values (cNomeEmpresa,cRelTitulo,cRelTitul2,cPeriodo)
lcQuery = [ Select a.emps,a.vends,a.datas,a.dopes,a.numes,a.empdopnums, ] + ;
		  [ From SigMvCab a Inner Join SigMvPar d On d.empdopnums=a.empdopnums ] +;
		  [ Inner Join SigCdOpe b On d.dopes = b.dopes And b.ccomis = 1 ] +;
		  [ Inner Join SigOpFp c On d.fpags = c.fpags And c.bxcomis = 1 ] +;
		  [ Inner Join SigCdEmp e On a.emps = e.cemps ] +;
		  [ Left Join SigCdCli h On a.Resps = h.Iclis ] +;
		  [ Left Join SigCdCli f On a.Vends = f.iclis ] +; 
		  [ Left join SigCdCrg g On f.ccargs = g.ccargs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTemp') < 1)
	Select vends,datas,emps,fpcomiss,fpags,rclis,razas,rclis as nvens,ccargs,infos,fComis, aComis,;
	From crTemp ;
	Select Resps as vends,datas,emps,fpcomiss,fpags,DResps as rclis,razas, DResps as nvens,CcargResps as ccargs,infos,fComis, aComis,;
	From crTemp Where !Empty(Resps) And Vends <> Resps ;	
	Select dopes,vends,datas,emps,numes,fpcomiss,fpags,rclis,razas,rclis as nvens,ccargs,infos,;
	From crTemp ;
	Select dopes,Resps as vends,datas,emps,numes,fpcomiss,fpags,DResps as rclis,razas,DResps as nvens,ccargs,infos,;
	From crTemp Where !Empty(Resps) And Vends <> Resps ;
	lcQuery = [ Select *, b.rclis as nvens  from sigcdcmm a, sigcdcli b where a.datas between ?dDataIni1 and ?dDataFim2 and a.contas = b.iclis]
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crCmm1') < 1)
	SELECT empdopnums, COUNT(contas) as qtdv from Crcmm1 group by empdopnums into cursor crCmm2
	SELECT a.*, b.qtdv from crCmm1 a, crCmm2 b where a.empdopnums = b.Empdopnums into cursor crCdCmm
	Select a.dopes,b.contas as vends,a.datas,a.emps,a.numes,a.fpcomiss,a.fpags,a.rclis,a.razas,nvens,a.ccargs,a.infos,;
	From crTemp a, crCdCmm b ;
	Delete From Tempo Where ( Round( Tots * FpComiss * FatComis /100, 2 ) = 0)
Select tempo
	lcQuery = [Select * From SigPrInf ]
	If ThisForm.PodataMgr.SqlExecute(lcquery,'TmpInfo') < 0
	Select a.Emps, a.Vends, Max(a.nvens) as nvens, a.Infos, Max(b.descrs) as descrs, ;
	  From Tempo a, tmpInfo b ;
    If .Not.Seek(This.Value,'crSigCdMoe','Dmoes')
    If .Not.Seek(This.Value,'crSigCdMoe','Cmoes')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecsm.prg) - TRECHOS RELEVANTES PARA PASS SQL (1624 linhas total):

*-- Linhas 639 a 660:
639:         *-- Moeda padrao: SigCdPam.MoedaPs
640:         IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
641:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
642:                 loc_cSQL    = "SELECT MoedaPs FROM SigCdPam"
643:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmPam")
644:                 IF loc_nResult > 0
645:                     SELECT cursor_4c_CsmPam
646:                     IF !EOF() AND !EMPTY(cursor_4c_CsmPam.MoedaPs)
647:                         THIS.txt_4c_Cmoeda.Value = ALLTRIM(cursor_4c_CsmPam.MoedaPs)
648:                         IF USED("cursor_4c_CsmPam")
649:                             USE IN cursor_4c_CsmPam
650:                         ENDIF
651:                         THIS.ValidarMoedaCod()
652:                     ELSE
653:                         IF USED("cursor_4c_CsmPam")
654:                             USE IN cursor_4c_CsmPam
655:                         ENDIF
656:                     ENDIF
657:                 ENDIF
658:             ENDIF
659:         ENDIF
660:     ENDPROC

*-- Linhas 773 a 794:
773:             THIS.AtualizarEstadoEmpresaDesc()
774:             RETURN
775:         ENDIF
776:         loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cValor)
777:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
778:         IF loc_nResult > 0
779:             SELECT cursor_4c_EmpVal
780:             IF !EOF()
781:                 THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
782:             ELSE
783:                 THIS.txt_4c__empresa_desc.Value = ""
784:                 THIS.AbrirBuscaEmpresaCod()
785:             ENDIF
786:         ELSE
787:             THIS.txt_4c__empresa_desc.Value = ""
788:             THIS.AbrirBuscaEmpresaCod()
789:         ENDIF
790:         IF USED("cursor_4c_EmpVal")
791:             USE IN cursor_4c_EmpVal
792:         ENDIF
793:         THIS.AtualizarEstadoEmpresaDesc()
794:     ENDPROC

*-- Linhas 850 a 871:
850:             THIS.AtualizarEstadoEmpresaDesc()
851:             RETURN
852:         ENDIF
853:         loc_cSQL    = "SELECT Cemps, Razas FROM SigCdEmp WHERE Razas LIKE " + EscaparSQL(loc_cValor + "%")
854:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDescVal")
855:         IF loc_nResult > 0
856:             SELECT cursor_4c_EmpDescVal
857:             IF !EOF()
858:                 THIS.txt_4c__empresa.Value      = ALLTRIM(Cemps)
859:                 THIS.txt_4c__empresa_desc.Value = ALLTRIM(Razas)
860:             ELSE
861:                 THIS.AbrirBuscaEmpresaDesc()
862:             ENDIF
863:         ELSE
864:             THIS.AbrirBuscaEmpresaDesc()
865:         ENDIF
866:         IF USED("cursor_4c_EmpDescVal")
867:             USE IN cursor_4c_EmpDescVal
868:         ENDIF
869:         THIS.AtualizarEstadoEmpresaDesc()
870:     ENDPROC
871: 

*-- Linhas 926 a 947:
926:             THIS.AtualizarEstadoContaDesc()
927:             RETURN
928:         ENDIF
929:         loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
930:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpVal")
931:         IF loc_nResult > 0
932:             SELECT cursor_4c_GrpVal
933:             IF !EOF()
934:                 THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
935:             ELSE
936:                 THIS.txt_4c__Ds_GrEstoque.Value = ""
937:                 THIS.AbrirBuscaGrupoCod()
938:             ENDIF
939:         ELSE
940:             THIS.txt_4c__Ds_GrEstoque.Value = ""
941:             THIS.AbrirBuscaGrupoCod()
942:         ENDIF
943:         IF USED("cursor_4c_GrpVal")
944:             USE IN cursor_4c_GrpVal
945:         ENDIF
946:         THIS.AtualizarEstadoGrupoDesc()
947:         THIS.AtualizarEstadoContaCd()

*-- Linhas 1011 a 1032:
1011:             THIS.AtualizarEstadoContaDesc()
1012:             RETURN
1013:         ENDIF
1014:         loc_cSQL    = "SELECT ccargs, dcargs FROM SigCdCrg WHERE dcargs LIKE " + EscaparSQL(loc_cValor + "%")
1015:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDescVal")
1016:         IF loc_nResult > 0
1017:             SELECT cursor_4c_GrpDescVal
1018:             IF !EOF()
1019:                 THIS.txt_4c__Cd_GrEstoque.Value = ALLTRIM(ccargs)
1020:                 THIS.txt_4c__Ds_GrEstoque.Value = ALLTRIM(dcargs)
1021:             ELSE
1022:                 THIS.AbrirBuscaGrupoDesc()
1023:             ENDIF
1024:         ELSE
1025:             THIS.AbrirBuscaGrupoDesc()
1026:         ENDIF
1027:         IF USED("cursor_4c_GrpDescVal")
1028:             USE IN cursor_4c_GrpDescVal
1029:         ENDIF
1030:         THIS.AtualizarEstadoGrupoDesc()
1031:         THIS.AtualizarEstadoContaCd()
1032:         THIS.AtualizarEstadoContaDesc()

*-- Linhas 1056 a 1074:
1056:         loc_cValor  = ALLTRIM(THIS.txt_4c__cd_estoque.Value)
1057:         loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
1058:                           "", ;
1059:                           "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
1060:         loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1061:             "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
1062:             "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
1063:             .F., .T., loc_cWhere)
1064:         IF VARTYPE(loc_oBusca) = "O"
1065:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1066:                 THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1067:                 THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1068:             ELSE
1069:                 IF !loc_oBusca.this_lAchouRegistro
1070:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1071:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1072:                     loc_oBusca.Show()
1073:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1074:                         THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)

*-- Linhas 1092 a 1113:
1092:             THIS.AtualizarEstadoContaDesc()
1093:             RETURN
1094:         ENDIF
1095:         loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
1096:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
1097:         IF loc_nResult > 0
1098:             SELECT cursor_4c_CliVal
1099:             IF !EOF()
1100:                 THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
1101:             ELSE
1102:                 THIS.txt_4c__ds_estoque.Value = ""
1103:                 THIS.AbrirBuscaContaCod()
1104:             ENDIF
1105:         ELSE
1106:             THIS.txt_4c__ds_estoque.Value = ""
1107:             THIS.AbrirBuscaContaCod()
1108:         ENDIF
1109:         IF USED("cursor_4c_CliVal")
1110:             USE IN cursor_4c_CliVal
1111:         ENDIF
1112:         THIS.AtualizarEstadoContaDesc()
1113:     ENDPROC

*-- Linhas 1136 a 1154:
1136:         loc_cValor  = ALLTRIM(THIS.txt_4c__ds_estoque.Value)
1137:         loc_cWhere  = IIF(EMPTY(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)), ;
1138:                           "", ;
1139:                           "ccargs = " + EscaparSQL(ALLTRIM(THIS.txt_4c__Cd_GrEstoque.Value)))
1140:         loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1141:             "SigCdCli", "cursor_4c_BuscaCliD", "rclis", loc_cValor, ;
1142:             "Sele" + CHR(231) + CHR(227) + "o de Conta/Vendedor", ;
1143:             .F., .T., loc_cWhere)
1144:         IF VARTYPE(loc_oBusca) = "O"
1145:             IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
1146:                 THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)
1147:                 THIS.txt_4c__ds_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.rclis)
1148:             ELSE
1149:                 IF !loc_oBusca.this_lAchouRegistro
1150:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1151:                     loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1152:                     loc_oBusca.Show()
1153:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCliD")
1154:                         THIS.txt_4c__cd_estoque.Value = ALLTRIM(cursor_4c_BuscaCliD.iclis)

*-- Linhas 1172 a 1193:
1172:             THIS.AtualizarEstadoContaDesc()
1173:             RETURN
1174:         ENDIF
1175:         loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE rclis LIKE " + EscaparSQL(loc_cValor + "%")
1176:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDescVal")
1177:         IF loc_nResult > 0
1178:             SELECT cursor_4c_CliDescVal
1179:             IF !EOF()
1180:                 THIS.txt_4c__cd_estoque.Value = ALLTRIM(iclis)
1181:                 THIS.txt_4c__ds_estoque.Value = ALLTRIM(rclis)
1182:             ELSE
1183:                 THIS.AbrirBuscaContaDesc()
1184:             ENDIF
1185:         ELSE
1186:             THIS.AbrirBuscaContaDesc()
1187:         ENDIF
1188:         IF USED("cursor_4c_CliDescVal")
1189:             USE IN cursor_4c_CliDescVal
1190:         ENDIF
1191:         THIS.AtualizarEstadoContaDesc()
1192:     ENDPROC
1193: 

*-- Linhas 1242 a 1263:
1242:             THIS.AtualizarEstadoMoedaDesc()
1243:             RETURN
1244:         ENDIF
1245:         loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cValor)
1246:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1247:         IF loc_nResult > 0
1248:             SELECT cursor_4c_MoeVal
1249:             IF !EOF()
1250:                 THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
1251:             ELSE
1252:                 THIS.txt_4c_Dmoeda.Value = ""
1253:                 THIS.AbrirBuscaMoedaCod()
1254:             ENDIF
1255:         ELSE
1256:             THIS.txt_4c_Dmoeda.Value = ""
1257:             THIS.AbrirBuscaMoedaCod()
1258:         ENDIF
1259:         IF USED("cursor_4c_MoeVal")
1260:             USE IN cursor_4c_MoeVal
1261:         ENDIF
1262:         THIS.AtualizarEstadoMoedaDesc()
1263:     ENDPROC

*-- Linhas 1319 a 1340:
1319:             THIS.AtualizarEstadoMoedaDesc()
1320:             RETURN
1321:         ENDIF
1322:         loc_cSQL    = "SELECT CMoes, DMoes FROM SigCdMoe WHERE DMoes LIKE " + EscaparSQL(loc_cValor + "%")
1323:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeDescVal")
1324:         IF loc_nResult > 0
1325:             SELECT cursor_4c_MoeDescVal
1326:             IF !EOF()
1327:                 THIS.txt_4c_Cmoeda.Value = ALLTRIM(CMoes)
1328:                 THIS.txt_4c_Dmoeda.Value = ALLTRIM(DMoes)
1329:             ELSE
1330:                 THIS.AbrirBuscaMoedaDesc()
1331:             ENDIF
1332:         ELSE
1333:             THIS.AbrirBuscaMoedaDesc()
1334:         ENDIF
1335:         IF USED("cursor_4c_MoeDescVal")
1336:             USE IN cursor_4c_MoeDescVal
1337:         ENDIF
1338:         THIS.AtualizarEstadoMoedaDesc()
1339:     ENDPROC
1340: 

*-- Linhas 1430 a 1448:
1430:                     IF USED("tempo") AND RECCOUNT("tempo") > 0
1431:                         loc_cArquivo = ADDBS(SYS(2023)) + "Comissao_" + DTOS(DATE()) + ;
1432:                                        "_" + STRTRAN(TIME(), ":", "") + ".xls"
1433:                         SELECT tempo
1434:                         COPY TO (loc_cArquivo) TYPE XLS
1435: 
1436:                         IF FILE(loc_cArquivo)
1437:                             DECLARE INTEGER ShellExecute IN shell32.dll ;
1438:                                 INTEGER hndWin, STRING cAction, ;
1439:                                 STRING cFileName, STRING cParams, ;
1440:                                 STRING cDir, INTEGER nShowWin
1441:                             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
1442:                         ELSE
1443:                             MsgErro("Erro ao gerar arquivo Excel.", "Comiss" + CHR(227) + "o")
1444:                         ENDIF
1445:                     ELSE
1446:                         MsgAviso("Nenhum dado para exportar.", "Comiss" + CHR(227) + "o")
1447:                     ENDIF
1448:                 ELSE


### BO (C:\4c\projeto\app\classes\sigrecsmBO.prg):
*==============================================================================
* SIGRECSMBO.PRG
* Business Object - Relatorio de Comissao por Condicao de Pagamento
* Herda de RelatorioBase
*
* Formulario original: SIGRECSM.SCX (frmrelatorio)
* Tabelas: SigMvCab, SigMvPar, SigCdOpe, SigOpFp, SigCdEmp, SigCdCli, SigCdCrg
* Relatorios FRX: SigReCs1 (Condicao Pgto), SigReCs2 (Sintetico/Analitico/Dividido)
*
* Cursores FRX (nomes fixos para compatibilidade):
*   cabecalho - cabecalho do relatorio (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo)
*   tempo     - dados principais para nOpt=1,2,4
*   tempo2    - dados agrupados por condicao de pagamento para nOpt=3
*==============================================================================

DEFINE CLASS sigrecsmBO AS RelatorioBase

    *-- Filtros: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: empresa (SigCdEmp - cemps / razas)
    this_cCemps         = ""
    this_cRazas         = ""

    *-- Filtros: grupo de vendedor (get_cd_grestoque / get_Ds_GrEstoque)
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""

    *-- Filtros: vendedor / conta (get_cd_estoque / get_ds_estoque)
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""

    *-- Filtros: moeda (SigCdMoe - cmoes / dmoes)
    this_cCmoes         = ""
    this_cDmoes         = ""

    *-- Opcao de relatorio: 1=Sintetico, 2=Analitico, 3=Cond.Pgto, 4=Comissao Dividida
    this_nOptRel        = 1

    *-- Nao incluir comissao zerada (FwChkComissao)
    this_lChkComissao   = .F.

    *-- Cursor de dados principal (nome FRX-compativel)
    this_cCursorDados       = "tempo"
    this_cCursorCabecalho   = "cabecalho"

    *-- Caminhos dos FRX
    *-- FRX1: nOpt=3 (Condicao de Pagamento)
    *-- FRX2: nOpt=1,2,4 (Sintetico, Analitico, Comissao Dividida)
    this_cCaminhoFrx1   = ""
    this_cCaminhoFrx2   = ""

    *--------------------------------------------------------------------------
    * Init - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_cCaminhoFrx1 = gc_4c_CaminhoReports + "SigReCs1.frx"
            THIS.this_cCaminhoFrx2 = gc_4c_CaminhoReports + "SigReCs2.frx"

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecsmBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa filtros e monta cursores para o relatorio
    * Equivalente ao PROCEDURE processamento do sistema legado (SIGRECSM)
    *
    * Fluxo:
    *   1. Carrega SigCdCot em cursor_4c_CsmCot (para CarregarCambioCSM)
    *   2. Busca nome da empresa para cabecalho
    *   3. Cria cursor cabecalho com dados do titulo do relatorio
    *   4. SQLEXEC query principal (SigMvCab/Par/Ope/Fp/Emp/Cli/Crg) em cursor_4c_CsmTemp
    *   5. SELECT local de cursor_4c_CsmTemp para cursor tempo (por nOpt)
    *   6. Se this_lChkComissao: remove registros com comissao zero
    *   7. Se nOpt=3: JOIN com SigPrInf para agrupar por condicao pagto em tempo2
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cDGrupo, loc_cConta, loc_cCmoes, loc_cDmoes
        LOCAL loc_nOpt
        LOCAL loc_cDataIni, loc_cDataFim
        LOCAL loc_cEmpWhere, loc_cGrupoWhere, loc_cContaWhere
        LOCAL loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo
        LOCAL loc_cVerVendedor

        loc_lSucesso = .F.

        TRY
            *-- Le filtros do BO
            loc_cEmpresa = PADR(ALLTRIM(THIS.this_cCemps), 3)
            loc_cGrupo   = PADR(ALLTRIM(THIS.this_cCdGrEstoque), 10)
            loc_cDGrupo  = PADR(ALLTRIM(THIS.this_cDsGrEstoque), 20)
            loc_cConta   = PADR(ALLTRIM(THIS.this_cCdEstoque), 10)
            loc_cCmoes   = PADR(ALLTRIM(THIS.this_cCmoes), 3)
            loc_cDmoes   = PADR(ALLTRIM(THIS.this_cDmoes), 15)
            loc_nOpt     = THIS.this_nOptRel

            *-- Formata datas para SQL Server
            loc_cDataIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDataFim = "'" + STR(YEAR(THIS.this_dDtFinal), 4) + "-" + ;
                           PADL(LTRIM(STR(MONTH(THIS.this_dDtFinal))), 2, "0") + "-" + ;
                           PADL(LTRIM(STR(DAY(THIS.this_dDtFinal))), 2, "0") + " 23:59:59'"

            *-- ================================================================
            *-- STEP 1: Carrega cotacoes para conversao de moeda (CarregarCambioCSM)
            *-- ================================================================
            IF USED("cursor_4c_CsmCot")
                USE IN cursor_4c_CsmCot
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CMoes, Datas, Valos FROM SigCdCot", ;
                "cursor_4c_CsmCot")
            IF loc_nResult > 0
                SELECT cursor_4c_CsmCot
                INDEX ON CMoes + DTOS(Datas) TAG CMoeData
            ENDIF

            *-- ================================================================
            *-- STEP 2: Busca nome da empresa para cabecalho do relatorio
            *-- ================================================================
            loc_cNomeEmpresa = ""
            IF USED("cursor_4c_CsmEmp")
                USE IN cursor_4c_CsmEmp
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas FROM SigCdEmp WHERE cemps = " + ;
                EscaparSQL(ALLTRIM(loc_cEmpresa)), ;
                "cursor_4c_CsmEmp")
            IF loc_nResult > 0 AND !EOF("cursor_4c_CsmEmp")
                SELECT cursor_4c_CsmEmp
                loc_cNomeEmpresa = ALLTRIM(cursor_4c_CsmEmp.razas)
            ENDIF

            *-- ================================================================
            *-- STEP 3: Monta strings do cabecalho e cria cursor cabecalho
            *-- ================================================================
            loc_cRelTitulo = "Relat" + CHR(243) + "rio de Comiss" + CHR(227) + ;
                             "o de Vendedor por Condi" + CHR(231) + CHR(227) + ;
                             "o de Pagamento"
            loc_cRelTitul2 = "Relat" + CHR(243) + "rio " + ;
                             IIF(loc_nOpt = 1, "Sint" + CHR(233) + "tico", ;
                             IIF(loc_nOpt = 2, "Anal" + CHR(237) + "tico", ;
                             "Tipo Cond.Pagto")) + "  -  " + ;
                             IIF(EMPTY(ALLTRIM(loc_cGrupo)), ;
                             "Todos os Grupos", ;
                             "Grupo :" + ALLTRIM(loc_cGrupo) + ;
                             " - " + ALLTRIM(loc_cDGrupo)) + "  -  " + ;
                             ALLTRIM(loc_cCmoes) + "- " + ALLTRIM(loc_cDmoes)
            loc_cPeriodo   = "Per" + CHR(237) + "odo: " + ;
                             DTOC(THIS.this_dDtInicial) + ;
                             " " + CHR(160) + " " + DTOC(THIS.this_dDtFinal)

            IF USED("cabecalho")
                USE IN cabecalho
            ENDIF
            CREATE CURSOR cabecalho ;
                (pNmEmp C(80), pRelTitulo C(80), pRelTitul2 C(80), pPeriodo C(80))
            INSERT INTO cabecalho (pNmEmp, pRelTitulo, pRelTitul2, pPeriodo) ;
                VALUES (loc_cNomeEmpresa, loc_cRelTitulo, loc_cRelTitul2, loc_cPeriodo)

            *-- ================================================================
            *-- STEP 4: Query principal contra SQL Server
            *-- ================================================================
            loc_cEmpWhere   = IIF(EMPTY(ALLTRIM(loc_cEmpresa)), "", ;
                              " AND a.emps = " + EscaparSQL(ALLTRIM(loc_cEmpresa)))
            loc_cGrupoWhere = IIF(EMPTY(ALLTRIM(loc_cGrupo)) OR loc_nOpt = 4, "", ;
                              " AND (a.GrVends = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ;
                              " OR a.GrResps = " + EscaparSQL(ALLTRIM(loc_cGrupo)) + ")")
            loc_cContaWhere = IIF(EMPTY(ALLTRIM(loc_cConta)) OR loc_nOpt = 4, "", ;
                              " AND (a.Vends = " + EscaparSQL(ALLTRIM(loc_cConta)) + ;
                              " OR a.Resps = " + EscaparSQL(ALLTRIM(loc_cConta)) + ")")

            IF USED("cursor_4c_CsmTemp")
                USE IN cursor_4c_CsmTemp
            ENDIF

            loc_cSQL = "SELECT a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes, a.empdopnums," + ;
                       " b.copers, c.Trocos, c.fpcomiss," + ;
                       " c.fpags, c.infos, d.valos," + ;
                       " d.Moefpgs, d.cotfpgs, e.razas," + ;
                       " f.iClis, f.rclis, f.CCargs," + ;
                       " g.FComis, g.acomis," + ;
                       " a.Resps, h.rclis AS DResps," + ;
                       " h.Ccargs AS CcargResps, a.grvends" + ;
                       " FROM SigMvCab a" + ;
                       " INNER JOIN SigMvPar d ON d.empdopnums = a.empdopnums" + ;
                       " INNER JOIN SigCdOpe b ON d.dopes = b.dopes" + ;
                       " AND b.ccomis = 1" + ;
                       " INNER JOIN SigOpFp c ON d.fpags = c.fpags" + ;
                       " AND c.bxcomis = 1" + ;
                       " INNER JOIN SigCdEmp e ON a.emps = e.cemps" + ;
                       " LEFT JOIN SigCdCli h ON a.Resps = h.Iclis" + ;
                       " LEFT JOIN SigCdCli f ON a.Vends = f.iclis" + ;
                       " LEFT JOIN SigCdCrg g ON f.ccargs = g.ccargs" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFim + ;
                       loc_cEmpWhere + loc_cGrupoWhere + loc_cContaWhere + ;
                       " ORDER BY a.emps, a.vends, a.datas," + ;
                       " a.dopes, a.numes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmTemp")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de comiss" + CHR(227) + "o"
                MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados")
                loc_lSucesso = .F.
            ENDIF

            *-- ================================================================
            *-- STEP 5: Processa cursor temporario conforme opcao do relatorio
            *-- ================================================================
            IF USED("tempo")
                USE IN tempo
            ENDIF

            IF loc_nOpt = 1
                *-- Sintetico: vendedor como vends + UNION com responsavel (Resps)
                SELECT vends, datas, emps, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                UNION ;
                SELECT Resps AS vends, datas, emps, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots, ;
                       "S" AS OptRel ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 ;
                ORDER BY 3, 1, 2, 5 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF INLIST(loc_nOpt, 2, 3)
                *-- Analitico / Condicao Pagto: inclui dopes e numes no agrupamento
                SELECT dopes, vends, datas, emps, numes, fpcomiss, fpags, ;
                       rclis, razas, rclis AS nvens, CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                UNION ;
                SELECT dopes, Resps AS vends, datas, emps, numes, fpcomiss, fpags, ;
                       DResps AS rclis, razas, DResps AS nvens, ;
                       CcargResps AS CCargs, infos, ;
                       FComis, acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(CCargs) AND !ISNULL(FComis) AND FComis = "S", ;
                           acomis / 100.0, ;
                           IIF(!EMPTY(Resps) AND vends <> Resps, ;
                               0.5, 1.0)) AS fatComis, ;
                       SUM(valos * CarregarCambioCSM(Moefpgs, datas) / ;
                           CarregarCambioCSM(loc_cCmoes, datas) * ;
                           IIF(copers = 1, 1.0, -1.0) * ;
                           IIF(Trocos = 1, -1.0, 1.0)) AS tots ;
                FROM cursor_4c_CsmTemp ;
                WHERE !EMPTY(Resps) AND vends <> Resps ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            IF loc_nOpt = 4
                *-- Comissao dividida: usa grade de comissoes (SigCdCmm) como base
                loc_cVerVendedor = IIF(EMPTY(ALLTRIM(loc_cGrupo)), "", ;
                                   " AND ALLTRIM(a.grvends) = '" + ;
                                   ALLTRIM(loc_cGrupo) + "'")
                loc_cVerVendedor = loc_cVerVendedor + ;
                                   IIF(EMPTY(ALLTRIM(loc_cConta)), "", ;
                                   " AND ALLTRIM(b.contas) = '" + ;
                                   ALLTRIM(loc_cConta) + "'")

                IF USED("cursor_4c_CsmCmm1")
                    USE IN cursor_4c_CsmCmm1
                ENDIF
                loc_cSQL = "SELECT a.*, b.rclis AS nvens" + ;
                           " FROM SigCdCmm a, SigCdCli b" + ;
                           " WHERE a.datas BETWEEN " + loc_cDataIni + ;
                           " AND " + loc_cDataFim + ;
                           " AND a.contas = b.iclis"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsmCmm1")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigCdCmm"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=4)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("cursor_4c_CsmCmm2")
                    USE IN cursor_4c_CsmCmm2
                ENDIF
                SELECT empdopnums, COUNT(contas) AS qtdv ;
                FROM cursor_4c_CsmCmm1 ;
                GROUP BY empdopnums ;
                INTO CURSOR cursor_4c_CsmCmm2

                IF USED("cursor_4c_CsmCdCmm")
                    USE IN cursor_4c_CsmCdCmm
                ENDIF
                SELECT a.*, b.qtdv ;
                FROM cursor_4c_CsmCmm1 a, cursor_4c_CsmCmm2 b ;
                WHERE a.empdopnums = b.empdopnums ;
                INTO CURSOR cursor_4c_CsmCdCmm

                SELECT a.dopes, b.contas AS vends, a.datas, a.emps, a.numes, ;
                       a.fpcomiss, a.fpags, a.rclis, a.razas, b.nvens, ;
                       a.CCargs, a.infos, a.FComis, ;
                       b.percs AS acomis, "A" AS OptRel, ;
                       IIF(!EMPTY(a.CCargs) AND !ISNULL(a.FComis) AND a.FComis = "S", ;
                           b.percs / 100.0, 1.0) AS fatComis, ;
                       SUM(a.valos / b.qtdv * a.cotfpgs / ;
                           CarregarCambioCSM(loc_cCmoes, a.datas)) AS tots ;
                FROM cursor_4c_CsmTemp a, cursor_4c_CsmCdCmm b ;
                WHERE a.empdopnums = b.empdopnums &loc_cVerVendedor ;
                GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ;
                ORDER BY 4, 2, 3, 1, 5, 7 ;
                INTO CURSOR tempo READWRITE
            ENDIF

            *-- ================================================================
            *-- STEP 6: Filtro de comissao zerada (FwChkComissao)
            *-- SET DELETED ON (config.prg) ignora registros deletados no REPORT
            *-- ================================================================
            IF THIS.this_lChkComissao AND USED("tempo") AND RECCOUNT("tempo") > 0
                SELECT tempo
                DELETE FROM tempo WHERE ROUND(tots * fpcomiss * fatComis / 100.0, 2) = 0
            ENDIF

            *-- ================================================================
            *-- STEP 7: Para nOpt=3, agrupa por condicao de pagamento (SigPrInf)
            *-- ================================================================
            IF loc_nOpt = 3
                IF USED("cursor_4c_CsmInf")
                    USE IN cursor_4c_CsmInf
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigPrInf", "cursor_4c_CsmInf")
                IF loc_nResult < 0
                    THIS.this_cMensagemErro = "Erro ao buscar SigPrInf"
                    MsgErro(THIS.this_cMensagemErro, "sigrecsmBO.PrepararDados (nOpt=3)")
                    loc_lSucesso = .F.
                ENDIF

                IF USED("tempo2")
                    USE IN tempo2
                ENDIF
                SELECT a.emps, a.vends, MAX(a.nvens) AS nvens, ;
                       a.infos, MAX(b.descrs) AS descrs, ;
                       SUM(tots) AS tots, ;
                       MAX(a.razas) AS razas, MAX(a.CCargs) AS ccargs ;
                FROM tempo a, cursor_4c_CsmInf b ;
                WHERE a.infos = b.infos ;
                GROUP BY 1, 2, 4 ;
                ORDER BY 1, 2, 5 ;
                INTO CURSOR tempo2
            ENDIF

            SELECT tempo
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.PrepararDados")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) TO PRINTER PROMPT NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) TO PRINTER PROMPT NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOptRel = 3
                    REPORT FORM (THIS.this_cCaminhoFrx1) PREVIEW NOCONSOLE
                ELSE
                    REPORT FORM (THIS.this_cCaminhoFrx2) PREVIEW NOCONSOLE
                ENDIF
                IF USED("cabecalho")
                    USE IN cabecalho
                ENDIF
                IF USED("tempo")
                    USE IN tempo
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecsmBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN DTOC(THIS.this_dDtInicial) + "|" + DTOC(THIS.this_dDtFinal) + ;
               "|" + ALLTRIM(THIS.this_cCemps) + "|" + ;
               STR(THIS.this_nOptRel, 1)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel (relatorio nao persiste dados)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
                                  "o n" + CHR(227) + "o aplic" + CHR(225) + ;
                                  "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores locais criados pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores[9], loc_i
        loc_aCursores[1] = "cursor_4c_CsmTemp"
        loc_aCursores[2] = "cursor_4c_CsmCot"
        loc_aCursores[3] = "cursor_4c_CsmEmp"
        loc_aCursores[4] = "cursor_4c_CsmCmm1"
        loc_aCursores[5] = "cursor_4c_CsmCmm2"
        loc_aCursores[6] = "cursor_4c_CsmCdCmm"
        loc_aCursores[7] = "cursor_4c_CsmInf"
        loc_aCursores[8] = "cabecalho"
        loc_aCursores[9] = "tempo"

        FOR loc_i = 1 TO 9
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        ENDFOR

        IF USED("tempo2")
            USE IN tempo2
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

*==============================================================================
* CarregarCambioCSM - UDF standalone para calculo de cambio
* Equivalente a fCarregarCambio() do sistema legado, especifico para sigrecsmBO
* Acessivel de dentro de SELECT VFP (nao pode ser metodo de objeto)
*
* Acessa cursor_4c_CsmCot (carregado por sigrecsmBO.PrepararDados)
* Retorna cotacao da moeda na data informada (ou na data imediatamente anterior)
*==============================================================================
FUNCTION CarregarCambioCSM(par_cMoeda, par_dData)
    LOCAL loc_nCotacao, loc_cMoeda, loc_dData

    loc_nCotacao = 1

    IF VARTYPE(par_cMoeda) <> "C" OR EMPTY(par_cMoeda)
        RETURN 1
    ENDIF

    loc_cMoeda = PADR(ALLTRIM(par_cMoeda), 3)

    DO CASE
        CASE VARTYPE(par_dData) = "D"
            loc_dData = par_dData
        CASE VARTYPE(par_dData) = "T"
            loc_dData = TTOD(par_dData)
        OTHERWISE
            loc_dData = DATE()
    ENDCASE

    IF USED("cursor_4c_CsmCot") AND !EMPTY(loc_cMoeda) AND !EMPTY(loc_dData)
        SELECT cursor_4c_CsmCot
        SET ORDER TO CMoeData

        *-- Busca exata na data
        IF SEEK(loc_cMoeda + DTOS(loc_dData))
            loc_nCotacao = cursor_4c_CsmCot.Valos
        ELSE
            *-- Nao encontrou: busca com NEAR para posicionar no mais proximo
            SET NEAR ON
            SEEK(loc_cMoeda + DTOS(loc_dData))
            SET NEAR OFF
            *-- Volta um registro para pegar a taxa mais recente anterior
            IF !BOF()
                SKIP -1
            ENDIF
            IF !BOF() AND ALLTRIM(cursor_4c_CsmCot.CMoes) = ALLTRIM(loc_cMoeda)
                loc_nCotacao = cursor_4c_CsmCot.Valos
            ENDIF
        ENDIF
    ENDIF

    RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
ENDFUNC

