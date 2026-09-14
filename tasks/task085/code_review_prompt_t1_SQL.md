# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-ASPAS] Linha 479: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: " WHERE EmpGruEsts = '" + loc_cEGEs + "'" + ;
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CONTAS, DATAS, CPROS, CGRUS, MERCS, EMPGRUESTS, ETIQS, SALDO, DESCS, CEMPS, CODIGOS, ICLIS

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
lcSql = [Select a.cidchaves,a.emps,a.grupos,a.estos,a.cpros,a.sqtds As saldo,]+;
		[From SigMvEst a, SigCdPro b, SigCdGrp c Left Join SigCdGpr D On d.Codigos = c.Mercs ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'TmpEst')
	Select TmpEst
			Select SigMvHst
	Select TmpEst
		loBarraEst.Update(.T.,'Produto: ' + TmpEst.cpros)
			Delete In TmpEst
			Select SigMvHst
			lStrQuery = [Select Top 1 Emps,Grupos,Estos,CPros,Datas,SQtds ]+;
						[From SigMvHst ]+;
			lStrQuery = [Select Top 1 EmpGruEsts, Cpros, CidChaves, Sqtds, tSqtds, tEqtds From SigMvHst ]+;
			If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpHis') < 1
			Select TmpHis
		Select TmpEst
Select Max(Emps) as Emps, Grupos, Estos, GGrupo, Padr(Nvl(Descs,''),40) as Descs, MoeCusFs, cUnis, ;
From TmpEst ;
	lcSql = [Select a.cbars,a.empos,a.grupos,a.contas,a.cpros,a.qtds As etiqs,c.mercs As ggrupo, ]+;
			[From SigOpEtq a, SigCdPro b, SigCdGrp c Left Join SigCdGpr d On d.Codigos = c.Mercs ]+;
	lnQueryOk = ThisForm.poDataMgr.SqlExecute(lcSql,'TmpEti')
	Select Max(Empos) as Emps, Grupos, Contas as Estos, GGrupo, Padr(Nvl(Descs,''),40) as Descs, MoeCusFs, cUnis, ;
	From TmpEti ;
	Select * From CsEst ;
	Select * From CsEti ;
	Select * From CsEst Into Cursor TmpRelatorio ReadWrite
		Select TmpRelatorio
	Select 1 as Tps,Emps, Grupos, Estos, GGrupo, Grupos as GrupoI, Estos as EstoI, GGrupo as GGrupoI, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Select 2 as Tps,Emps, Grupos, Space(10) as Estos, '   ' as GGrupo, Space(10) as GrupoI, Space(10) as EstoI, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Select 3 as Tps,Emps, Replicate(Chr(254),10) as Grupos, Space(10) as Estos, '   ' as GGrupo, Space(10) as GrupoI, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Select 1 as Tps, Emps, Grupos, Estos, GGrupo, Grupos as GrupoI, Estos as EstoI, GGrupo as GGrupoI, cUnis, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Select 2 as Tps,Emps, Grupos, Space(10) as Estos, '   ' as GGrupo, Space(10) as GrupoI, Space(10) as EstoI, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Select 3 as Tps,Emps, Replicate(Chr(254),10) as Grupos, Space(10) as Estos, '   ' as GGrupo, Space(10) as GrupoI, ;
	From TmpRelatorio Group By 1,2,3,4,5,6,7,8,9,10,11 ;
	Delete From CsRel Where (saldo = 0 And etiqs = 0)
	Delete From CsRel Where saldo = 0
Select CsRel
Select CsRel
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas,ativas From SigCdEmp ],'CrSigCdEmp')
Select CrSigCdEmp
lcNomeEmpresa = _Empr + IIf(Seek(_Empr,'CrSigCdEmp','cemps'),' - ' + CrSigCdEmp.razas,'')
Insert Into CsCabecalho (nomeempresa,titulo1,titulo2,periodo,impetiq, Impcusto);
	Select CrSigCdEmp
		loBarraEmp.Update(.T.,'Empresa: ' + CrSigCdEmp.cemps + ' - ' + CrSigCdEmp.razas)
				Select * From CsRel Into Cursor CsRelatorio ReadWrite
				Select CsRel
					Insert Into CsRelatorio From MemVar
					Select CsRel
		Select CrSigCdEmp
	Select * From CsRel Into Cursor CsRelatorio ReadWrite
Select CsRelatorio

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEGG.prg) - TRECHOS RELEVANTES PARA PASS SQL (1395 linhas total):

*-- Linhas 298 a 320:
298:             IF USED("cursor_4c_SigCdEmp")
299:                 USE IN cursor_4c_SigCdEmp
300:             ENDIF
301:             loc_nResult = SQLEXEC(gnConnHandle, ;
302:                 "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
303:                 "cursor_4c_SigCdEmp")
304:             IF loc_nResult > 0
305:                 SELECT cursor_4c_SigCdEmp
306:                 INDEX ON cemps TAG cemps ADDITIVE
307:                 GO TOP
308:             ELSE
309:                 MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
310:                     "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
311:                     CHR(225) + " consulta direta.", "Aviso")
312:             ENDIF
313:         CATCH TO loc_oErro
314:             MsgErro(loc_oErro.Message, "Erro")
315:         ENDTRY
316:     ENDPROC
317: 
318:     *--------------------------------------------------------------------------
319:     * ConfigurarPaginaDados - Campos de filtro em Page1
320:     *   Tops ajustados: Top_page = Top_original - 85 (PageFrame.Top=85)

*-- Linhas 465 a 495:
465:             .AutoSize  = .T.
466:             .Caption   = "Grande Grupo :"
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .ForeColor = RGB(90, 90, 90)
470:             .BackStyle = 0
471:             .Visible   = .T.
472:         ENDWITH
473: 
474:         loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
475:         WITH loc_oPagina.txt_4c_CdGGrupo
476:             .Top       = 102
477:             .Left      = 267
478:             .Width     = 80
479:             .Height    = 23
480:             .MaxLength = 10
481:             .Value     = ""
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .BackColor = RGB(255, 255, 255)
485:             .ForeColor = RGB(0, 0, 0)
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
490:         WITH loc_oPagina.txt_4c_DsGGrupo
491:             .Top       = 102
492:             .Left      = 349
493:             .Width     = 290
494:             .Height    = 23
495:             .MaxLength = 40

*-- Linhas 837 a 855:
837:                 loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
838:                 loc_oBusca.Show()
839:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
840:                     SELECT (loc_cCursor)
841:                     loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cemps)
842:                     loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(razas)
843:                 ENDIF
844:                 loc_oBusca.Release()
845:             ENDIF
846:         CATCH TO loc_oErro
847:             MsgErro(loc_oErro.Message, "Erro")
848:         ENDTRY
849:         IF USED(loc_cCursor)
850:             USE IN (loc_cCursor)
851:         ENDIF
852:     ENDPROC
853: 
854:     *==========================================================================
855:     * VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)

*-- Linhas 867 a 889:
867:                 loc_oPagina.txt_4c_DsEstoque.Value   = ""
868:                 RETURN
869:             ENDIF
870:             loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
871:                        EscaparSQL(loc_cCodigo)
872:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrVal")
873:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGcrVal")
874:                 SELECT cursor_4c_SigreEggGcrVal
875:                 loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.codigos)
876:                 loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreEggGcrVal.descs)
877:             ELSE
878:                 MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
879:                          "Grupo de Estoque")
880:                 loc_oPagina.txt_4c_CdGrEstoque.Value = ""
881:                 loc_oPagina.txt_4c_DsGrEstoque.Value = ""
882:                 THIS.AbrirBuscaGrEstoque()
883:             ENDIF
884:             IF USED("cursor_4c_SigreEggGcrVal")
885:                 USE IN cursor_4c_SigreEggGcrVal
886:             ENDIF
887:         CATCH TO loc_oErro
888:             MsgErro(loc_oErro.Message, "Erro")
889:         ENDTRY

*-- Linhas 904 a 922:
904:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
905:                 loc_oBusca.Show()
906:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
907:                     SELECT (loc_cCursor)
908:                     loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
909:                     loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)
910:                     loc_oPagina.txt_4c_CdEstoque.Value   = ""
911:                     loc_oPagina.txt_4c_DsEstoque.Value   = ""
912:                 ENDIF
913:                 loc_oBusca.Release()
914:             ENDIF
915:         CATCH TO loc_oErro
916:             MsgErro(loc_oErro.Message, "Erro")
917:         ENDTRY
918:         IF USED(loc_cCursor)
919:             USE IN (loc_cCursor)
920:         ENDIF
921:     ENDPROC
922: 

*-- Linhas 938 a 962:
938:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
939:             loc_cFiltro = ""
940:             IF !EMPTY(loc_cGrupo)
941:                 loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
942:             ENDIF
943:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
944:                        EscaparSQL(loc_cCodigo) + loc_cFiltro
945:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliVal")
946:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggCliVal")
947:                 SELECT cursor_4c_SigreEggCliVal
948:                 loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.iclis)
949:                 loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreEggCliVal.rclis)
950:             ELSE
951:                 MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
952:                          "Conta de Estoque")
953:                 loc_oPagina.txt_4c_CdEstoque.Value = ""
954:                 loc_oPagina.txt_4c_DsEstoque.Value = ""
955:                 THIS.AbrirBuscaEstoque()
956:             ENDIF
957:             IF USED("cursor_4c_SigreEggCliVal")
958:                 USE IN cursor_4c_SigreEggCliVal
959:             ENDIF
960:         CATCH TO loc_oErro
961:             MsgErro(loc_oErro.Message, "Erro")
962:         ENDTRY

*-- Linhas 971 a 1000:
971:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
972:             loc_cFiltro = ""
973:             IF !EMPTY(loc_cGrupo)
974:                 loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
975:             ENDIF
976: 
977:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
978:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
979:                 "Selecionar Conta de Estoque", loc_cFiltro)
980:             IF VARTYPE(loc_oBusca) = "O"
981:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
982:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
983:                 loc_oBusca.Show()
984:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
985:                     SELECT (loc_cCursor)
986:                     loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
987:                     loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
988:                 ENDIF
989:                 loc_oBusca.Release()
990:             ENDIF
991:         CATCH TO loc_oErro
992:             MsgErro(loc_oErro.Message, "Erro")
993:         ENDTRY
994:         IF USED(loc_cCursor)
995:             USE IN (loc_cCursor)
996:         ENDIF
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)

*-- Linhas 1010 a 1032:
1010:                 loc_oPagina.txt_4c_DsGGrupo.Value = ""
1011:                 RETURN
1012:             ENDIF
1013:             loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + ;
1014:                        EscaparSQL(loc_cCodigo)
1015:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprVal")
1016:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggGprVal")
1017:                 SELECT cursor_4c_SigreEggGprVal
1018:                 loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.codigos)
1019:                 loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreEggGprVal.descs)
1020:             ELSE
1021:                 MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado.", "Grande Grupo")
1022:                 loc_oPagina.txt_4c_CdGGrupo.Value = ""
1023:                 loc_oPagina.txt_4c_DsGGrupo.Value = ""
1024:                 THIS.AbrirBuscaGGrupo()
1025:             ENDIF
1026:             IF USED("cursor_4c_SigreEggGprVal")
1027:                 USE IN cursor_4c_SigreEggGprVal
1028:             ENDIF
1029:         CATCH TO loc_oErro
1030:             MsgErro(loc_oErro.Message, "Erro")
1031:         ENDTRY
1032:     ENDPROC

*-- Linhas 1046 a 1064:
1046:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1047:                 loc_oBusca.Show()
1048:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1049:                     SELECT (loc_cCursor)
1050:                     loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(codigos)
1051:                     loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(descs)
1052:                 ENDIF
1053:                 loc_oBusca.Release()
1054:             ENDIF
1055:         CATCH TO loc_oErro
1056:             MsgErro(loc_oErro.Message, "Erro")
1057:         ENDTRY
1058:         IF USED(loc_cCursor)
1059:             USE IN (loc_cCursor)
1060:         ENDIF
1061:     ENDPROC
1062: 
1063:     *==========================================================================
1064:     * VALIDACAO + LOOKUP - Moeda (SigCdMoe)

*-- Linhas 1074 a 1096:
1074:                 loc_oPagina.txt_4c_DsMoeda.Value = ""
1075:                 RETURN
1076:             ENDIF
1077:             loc_cSQL = "SELECT TOP 1 CMoes, DMoes FROM SigCdMoe WHERE CMoes = " + ;
1078:                        EscaparSQL(loc_cCodigo)
1079:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggMoeVal")
1080:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreEggMoeVal")
1081:                 SELECT cursor_4c_SigreEggMoeVal
1082:                 loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_SigreEggMoeVal.CMoes)
1083:                 loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_SigreEggMoeVal.DMoes)
1084:             ELSE
1085:                 MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "Moeda")
1086:                 loc_oPagina.txt_4c_CdMoeda.Value = ""
1087:                 loc_oPagina.txt_4c_DsMoeda.Value = ""
1088:                 THIS.AbrirBuscaMoeda()
1089:             ENDIF
1090:             IF USED("cursor_4c_SigreEggMoeVal")
1091:                 USE IN cursor_4c_SigreEggMoeVal
1092:             ENDIF
1093:         CATCH TO loc_oErro
1094:             MsgErro(loc_oErro.Message, "Erro")
1095:         ENDTRY
1096:     ENDPROC

*-- Linhas 1110 a 1128:
1110:                 loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1111:                 loc_oBusca.Show()
1112:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1113:                     SELECT (loc_cCursor)
1114:                     loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(CMoes)
1115:                     loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(DMoes)
1116:                 ENDIF
1117:                 loc_oBusca.Release()
1118:             ENDIF
1119:         CATCH TO loc_oErro
1120:             MsgErro(loc_oErro.Message, "Erro")
1121:         ENDTRY
1122:         IF USED(loc_cCursor)
1123:             USE IN (loc_cCursor)
1124:         ENDIF
1125:     ENDPROC
1126: 
1127:     *==========================================================================
1128:     * TRANSFERENCIA FORM -> BO

*-- Linhas 1176 a 1237:
1176:             *-- Valida Grupo de Estoque (se informado)
1177:             loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
1178:             IF !EMPTY(loc_cCodigo)
1179:                 loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + ;
1180:                               EscaparSQL(loc_cCodigo)
1181:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGcrChk")
1182:                 IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGcrChk")
1183:                     MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
1184:                     IF USED("cursor_4c_SigreEggGcrChk")
1185:                         USE IN cursor_4c_SigreEggGcrChk
1186:                     ENDIF
1187:                     loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
1188:                     loc_lResultado = .F.
1189:                 ENDIF
1190:                 IF USED("cursor_4c_SigreEggGcrChk")
1191:                     USE IN cursor_4c_SigreEggGcrChk
1192:                 ENDIF
1193:             ENDIF
1194: 
1195:             *-- Valida Conta de Estoque (se informada)
1196:             IF loc_lResultado
1197:                 loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
1198:                 IF !EMPTY(loc_cCodigo)
1199:                     loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
1200:                                   EscaparSQL(loc_cCodigo)
1201:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggCliChk")
1202:                     IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggCliChk")
1203:                         MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
1204:                         IF USED("cursor_4c_SigreEggCliChk")
1205:                             USE IN cursor_4c_SigreEggCliChk
1206:                         ENDIF
1207:                         loc_oPagina.txt_4c_CdEstoque.SetFocus()
1208:                         loc_lResultado = .F.
1209:                     ENDIF
1210:                     IF USED("cursor_4c_SigreEggCliChk")
1211:                         USE IN cursor_4c_SigreEggCliChk
1212:                     ENDIF
1213:                 ENDIF
1214:             ENDIF
1215: 
1216:             *-- Valida Grande Grupo (se informado)
1217:             IF loc_lResultado
1218:                 loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
1219:                 IF !EMPTY(loc_cCodigo)
1220:                     loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
1221:                                   EscaparSQL(loc_cCodigo)
1222:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreEggGprChk")
1223:                     IF loc_nResult < 1 OR EOF("cursor_4c_SigreEggGprChk")
1224:                         MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
1225:                         IF USED("cursor_4c_SigreEggGprChk")
1226:                             USE IN cursor_4c_SigreEggGprChk
1227:                         ENDIF
1228:                         loc_oPagina.txt_4c_CdGGrupo.SetFocus()
1229:                         loc_lResultado = .F.
1230:                     ENDIF
1231:                     IF USED("cursor_4c_SigreEggGprChk")
1232:                         USE IN cursor_4c_SigreEggGprChk
1233:                     ENDIF
1234:                 ENDIF
1235:             ENDIF
1236: 
1237:             *-- Valida data de posicao (obrigatoria)

*-- Linhas 1306 a 1324:
1306:                 MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
1307:                 RETURN
1308:             ENDIF
1309:             SELECT cursor_4c_Relatorio
1310:             loc_cArquivo = PUTFILE("Salvar como...", "RelPosicaoEstoqueGGrupo", "xls")
1311:             IF EMPTY(loc_cArquivo)
1312:                 RETURN
1313:             ENDIF
1314:             COPY TO (loc_cArquivo) TYPE XL5
1315:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
1316:         CATCH TO loc_oErro
1317:             MsgErro(loc_oErro.Message, "Erro")
1318:         ENDTRY
1319:     ENDPROC
1320: 
1321:     *--------------------------------------------------------------------------
1322:     * BtnEncerrarClick - Fecha o formulario
1323:     *   Equivale ao btnReport.Sair (Cancel=.T., ESC tambem fecha) do original
1324:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SIGREEGGBO.prg):
*==============================================================================
* SIGREEGGBO.PRG
* BO do Relatorio: Posicao de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREEGG.SCX (frmrelatorio)
* Relatorio FRX: SigReEgg.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque (codigo + descricao via fAcessoContab)
*   - Conta de Estoque (codigo + descricao via fAcessoContas)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Data de Posicao (data unica)
*   - Opcao de Custo (1=Sim / 2=Nao, default=2)
*   - Moeda (codigo + descricao via SigCdMoe)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*
* Cursor de resultado produzido por PrepararDados():
*   cursor_4c_Relatorio - dados agrupados para REPORT FORM SigReEgg
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto
*==============================================================================

DEFINE CLASS SIGREEGGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDataPos       = {}
    this_nOptCusto      = 2
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Nome do cursor de resultado
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursor de empresas para processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDataPos    = DATE()
            THIS.this_nOptCusto   = 2
            THIS.this_cTabela     = "SigMvEst"
            THIS.this_cCampoChave = ""

            *-- Carregar empresas (usadas em Processar/ProcessarEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                "cursor_4c_SigCdEmp")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREEGGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa dados por empresa
    * Equivalente aos metodos processamento + processa do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar
    * Equivalente as validacoes em btnReport.Click do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount

        loc_lSucesso = .F.
        TRY
            *-- Validar data de posicao (obrigatoria)
            IF EMPTY(THIS.this_dDataPos)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Validar Grupo de Estoque (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGrEst
                    loc_nCount = NVL(cursor_4c_ValGrEst.nExiste, 0)
                    USE IN cursor_4c_ValGrEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grupo de Estoque Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGrEst
                ENDIF
            ENDIF

            *-- Validar Conta de Estoque (se preenchida)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValEst
                    loc_nCount = NVL(cursor_4c_ValEst.nExiste, 0)
                    USE IN cursor_4c_ValEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + ;
                            CHR(225) + "lida."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValEst
                ENDIF
            ENDIF

            *-- Validar Grande Grupo (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGpr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGGrp
                    loc_nCount = NVL(cursor_4c_ValGGrp.nExiste, 0)
                    USE IN cursor_4c_ValGGrp
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grande Grupo Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2
        LOCAL loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp
        LOCAL loc_ldDataPos

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque  = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp     = ALLTRIM(THIS.this_cCdGGrupo)
            loc_ldDataPos = THIS.this_dDataPos

            *-- Nome da empresa logada
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                        " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
                ENDIF
            ENDIF

            *-- Titulos do relatorio
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo"

            loc_cTitulo2 = "Grupo: " + IIF(EMPTY(loc_cGrupo), "Todos", ;
                loc_cGrupo + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + IIF(EMPTY(loc_cEstoque), "Todos", ;
                loc_cEstoque + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + IIF(EMPTY(loc_cGGrp), "Todos", loc_cGGrp)

            loc_cPeriodo   = "Estoque Existente em " + DTOC(loc_ldDataPos)
            loc_llImpEtiq  = (loc_ldDataPos = DATE())
            loc_llImpCusto = (THIS.this_nOptCusto = 1)

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), titulo2 C(150), ;
                 periodo C(80), impetiq L, Impcusto L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, ;
                        loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Orquestra o processamento por empresa.
    * Se empresa vazia: itera todas as empresas ativas de cursor_4c_SigCdEmp.
    * Se empresa especificada: processa apenas ela.
    * Acumula resultados em cursor_4c_Relatorio.
    * Equivalente ao corpo de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_llInicio, loc_llProcessa
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp, loc_cCodEmp

        loc_lSucesso = .F.
        loc_llInicio = .T.

        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp    = ALLTRIM(THIS.this_cCdGGrupo)

            *-- Fechar cursor de relatorio anterior
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF EMPTY(loc_cEmpresa)
                *-- Processar todas as empresas ativas (exceto 999 e ESC)
                IF !USED("cursor_4c_SigCdEmp")
                    THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                    loc_lSucesso = .F.
                ENDIF
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    loc_cCodEmp = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                    IF cursor_4c_SigCdEmp.ativas = 1 ;
                            AND loc_cCodEmp <> "999" ;
                            AND loc_cCodEmp <> "ESC"
                        loc_llProcessa = THIS.ProcessarEmpresa(loc_cCodEmp, ;
                            loc_cGrupo, loc_cEstoque, loc_cGGrp)
                        IF !loc_llProcessa
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_llInicio
                            SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
                            loc_llInicio = .F.
                        ELSE
                            SELECT CsRel
                            GO TOP
                            SCAN
                                SCATTER MEMO MEMVAR
                                INSERT INTO cursor_4c_Relatorio FROM MEMVAR
                                SELECT CsRel
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCdEmp
                ENDSCAN
            ELSE
                *-- Processar empresa unica
                loc_llProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, ;
                    loc_cGrupo, loc_cEstoque, loc_cGGrp)
                IF !loc_llProcessa
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
            ENDIF

            IF USED("cursor_4c_Relatorio")
                SELECT cursor_4c_Relatorio
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa as queries de estoque/etiquetas para uma empresa,
    * constroi os cursores intermediarios e gera o cursor CsRel agrupado.
    * Equivalente a PROCEDURE processa do legado SIGREEGG.
    *
    * Parametros:
    *   par_cEmpEst  - Codigo da empresa (3 chars)
    *   par_cGruEst  - Grupo de estoque (10 chars, pode ser vazio)
    *   par_cEstEst  - Conta de estoque (10 chars, pode ser vazio)
    *   par_cGGrupo  - Grande grupo (3 chars, pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_cFiltro, loc_cFilEti, loc_cDataPosSQL
        LOCAL loc_ldDataPos, loc_lnCotCus, loc_lnSQtds, loc_lnCot, loc_lnCus
        LOCAL loc_cEGEs, loc_cSQLHis

        loc_lSucesso  = .F.
        loc_ldDataPos = THIS.this_dDataPos

        TRY
            *-- Formatar data/hora SQL: 'YYYY-MM-DD 23:59:59'
            loc_cDataPosSQL = "'" + ;
                PADL(YEAR(loc_ldDataPos),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataPos), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataPos),   2, "0") + " 23:59:59'"

            *-- Cotacao da moeda selecionada na data de posicao
            loc_lnCotCus = 1
            IF !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                loc_lnCotCus = fBuscarCotacao(ALLTRIM(THIS.this_cCdMoeda), ;
                    loc_ldDataPos, gnConnHandle)
                IF loc_lnCotCus = 0
                    loc_lnCotCus = 1
                ENDIF
            ENDIF

            *-- Faixas de filtro (PADR garante comprimento fixo para BETWEEN/=)
            loc_cEmpIni = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), SPACE(3))
            loc_cEmpFin = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), REPLICATE(CHR(254), 3))
            loc_cGruIni = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), SPACE(10))
            loc_cGruFin = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), REPLICATE(CHR(254), 10))
            loc_cEstIni = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), SPACE(10))
            loc_cEstFin = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), REPLICATE(CHR(254), 10))

            *-- Filtro principal: empgruests = emp(3) + grupos(10) + estos(10)
            IF !EMPTY(ALLTRIM(par_cEmpEst)) AND ;
               !EMPTY(ALLTRIM(par_cGruEst)) AND ;
               !EMPTY(ALLTRIM(par_cEstEst))
                loc_cFiltro = "a.empgruests = '" + ;
                    PADR(ALLTRIM(par_cEmpEst), 3) + ;
                    PADR(ALLTRIM(par_cGruEst), 10) + ;
                    PADR(ALLTRIM(par_cEstEst), 10) + "'"
            ELSE
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                    loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                    "' AND '" + ;
                    loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Filtro etiquetas: usa colunas separadas (empos, grupos, contas)
            loc_cFilEti = "a.empos BETWEEN '" + ;
                    loc_cEmpIni + "' AND '" + loc_cEmpFin + "'" + ;
                " AND a.grupos BETWEEN '" + ;
                    loc_cGruIni + "' AND '" + loc_cGruFin + "'" + ;
                " AND a.contas BETWEEN '" + ;
                    loc_cEstIni + "' AND '" + loc_cEstFin + "'"
            IF loc_ldDataPos <> DATE()
                loc_cFilEti = loc_cFilEti + " AND a.datas <= " + loc_cDataPosSQL
            ENDIF

            *-- Fechar cursor temporario anterior
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Query principal: SigMvEst com joins SigCdPro, SigCdGrp, SigCdGpr
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds AS saldo," + ;
                " c.mercs AS ggrupo, b.CustoFs, b.MoeCusFs, b.cUnis, d.Descs" + ;
                " FROM SigMvEst a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                " WHERE " + loc_cFiltro
            IF !EMPTY(ALLTRIM(par_cGGrupo))
                loc_cSQL = loc_cSQL + ;
                    " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
            ENDIF
            loc_cSQL = loc_cSQL + ;
                " GROUP BY a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds, c.mercs, b.CustoFs, b.MoeCusFs, d.Descs, b.cUnis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar produtos do estoque"
                loc_lSucesso = .F.
            ENDIF

            *-- Se data diferente de hoje: recalcular saldo historico a partir de SigMvHst
            IF loc_ldDataPos <> DATE()
                SELECT TmpEst
                GO TOP
                SCAN
                    IF EMPTY(TmpEst.emps) OR EMPTY(TmpEst.grupos) OR EMPTY(TmpEst.estos)
                        DELETE
                        LOOP
                    ENDIF

                    loc_lnSQtds = 0

                    *-- Chave composta: emps(3) + grupos(10) + estos(10) = 23 chars
                    loc_cEGEs = PADR(ALLTRIM(TmpEst.emps), 3) + ;
                        PADR(ALLTRIM(TmpEst.grupos), 10) + ;
                        PADR(ALLTRIM(TmpEst.estos), 10)

                    IF USED("TmpHis")
                        USE IN TmpHis
                    ENDIF

                    loc_cSQLHis = "SELECT TOP 1 EmpGruEsts, Cpros, CidChaves, Sqtds" + ;
                        " FROM SigMvHst" + ;
                        " WHERE EmpGruEsts = '" + loc_cEGEs + "'" + ;
                        " AND CPros = '" + ALLTRIM(TmpEst.cpros) + "'" + ;
                        " AND Datas <= " + loc_cDataPosSQL + ;
                        " ORDER BY EmpGruEsts ASC, Cpros ASC, CidChaves DESC"

                    IF SQLEXEC(gnConnHandle, loc_cSQLHis, "TmpHis") >= 1
                        SELECT TmpHis
                        GO TOP
                        IF !EOF()
                            loc_lnSQtds = TmpHis.SQtds
                        ENDIF
                    ENDIF

                    SELECT TmpEst
                    REPLACE TmpEst.saldo WITH loc_lnSQtds
                ENDSCAN

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
            ENDIF

            *-- Agrupar TmpEst -> CsEst
            IF USED("CsEst")
                USE IN CsEst
            ENDIF

            SELECT MAX(emps) AS emps, grupos, estos, ggrupo, ;
                PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                SUM(saldo) AS saldo, SUM(0.000) AS etiqs, ;
                SUM(CustoFs * saldo) AS CustoFs ;
                FROM TmpEst ;
                GROUP BY 2, 3, 4, 5, 6, 7 ;
                INTO CURSOR CsEst READWRITE

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Se data = hoje: buscar etiquetas de SigOpEtq
            IF loc_ldDataPos = DATE()
                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF

                loc_cSQL = "SELECT a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds AS etiqs, c.mercs AS ggrupo," + ;
                    " d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis" + ;
                    " FROM SigOpEtq a" + ;
                    " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                    " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                    " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                    " WHERE " + loc_cFilEti
                IF !EMPTY(ALLTRIM(par_cGGrupo))
                    loc_cSQL = loc_cSQL + ;
                        " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
                ENDIF
                loc_cSQL = loc_cSQL + ;
                    " GROUP BY a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds, c.mercs, d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")

                IF loc_nResult >= 1
                    IF USED("CsEti")
                        USE IN CsEti
                    ENDIF
                    SELECT MAX(empos) AS emps, grupos, contas AS estos, ggrupo, ;
                        PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                        SUM(0.000) AS saldo, SUM(etiqs) AS etiqs, ;
                        SUM(0.000) AS CustoFs ;
                        FROM TmpEti ;
                        WHERE !EMPTY(grupos) AND !EMPTY(contas) ;
                        GROUP BY 2, 3, 4, 5, 6, 7 ;
                        INTO CURSOR CsEti READWRITE
                ENDIF

                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF
            ENDIF

            *-- Montar TmpRelatorio: UNION ALL CsEst + CsEti (ou apenas CsEst)
            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            IF loc_ldDataPos = DATE() AND USED("CsEti")
                SELECT * FROM CsEst ;
                UNION ALL ;
                SELECT * FROM CsEti ;
                INTO CURSOR TmpRelatorio READWRITE
            ELSE
                SELECT * FROM CsEst INTO CURSOR TmpRelatorio READWRITE
            ENDIF

            IF USED("CsEst")
                USE IN CsEst
            ENDIF
            IF USED("CsEti")
                USE IN CsEti
            ENDIF

            *-- Converter custo para moeda selecionada (se opt_custo = 1)
            IF THIS.this_nOptCusto = 1 AND !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                SELECT TmpRelatorio
                SCAN
                    loc_lnCot = fBuscarCotacao(ALLTRIM(TmpRelatorio.MoeCusFs), ;
                        loc_ldDataPos, gnConnHandle)
                    IF loc_lnCot = 0
                        loc_lnCot = 1
                    ENDIF
                    loc_lnCus = TmpRelatorio.CustoFs * loc_lnCot / loc_lnCotCus
                    REPLACE TmpRelatorio.CustoFs WITH loc_lnCus, ;
                            TmpRelatorio.MoeCusFs WITH PADR(ALLTRIM(THIS.this_cCdMoeda), 3)
                ENDSCAN
            ENDIF

            *-- UNION ALL final com 3 tipos: detalhe(1), total grupo(2), total empresa(3)
            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            IF THIS.this_nOptCusto = 1
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ELSE
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, " " AS MoeCusFs, 0 AS CustoFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ENDIF

            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            *-- Remover linhas com saldo = 0 (e etiqs = 0 se for hoje)
            IF loc_ldDataPos = DATE()
                DELETE FROM CsRel WHERE saldo = 0 AND etiqs = 0
            ELSE
                DELETE FROM CsRel WHERE saldo = 0
            ENDIF

            *-- Marcar ImpLinha: linha anterior a cada "Total ..." recebe .T.
            SELECT CsRel
            GO TOP
            LOCAL loc_nVz, loc_cDescAtual
            loc_nVz = 1
            DO WHILE !EOF()
                IF loc_nVz = 1
                    LOCATE FOR Descs = "Total "
                ELSE
                    CONTINUE
                ENDIF
                IF !EOF()
                    SKIP -1
                    IF !DELETED()
                        REPLACE ImpLinha WITH .T.
                    ENDIF
                    SKIP
                    loc_cDescAtual = Descs
                    DO WHILE Descs = loc_cDescAtual AND !EOF()
                        SKIP
                    ENDDO
                    IF !EOF()
                        SKIP -1
                    ENDIF
                ENDIF
                loc_nVz = 2
            ENDDO

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "TmpEst"
        loc_aCursores[2] = "TmpEti"
        loc_aCursores[3] = "TmpHis"
        loc_aCursores[4] = "TmpRelatorio"
        loc_aCursores[5] = "CsEst"
        loc_aCursores[6] = "CsEti"
        loc_aCursores[7] = "CsRel"
        loc_aCursores[8] = "CsCabecalho"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia e intermediarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

