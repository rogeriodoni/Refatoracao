# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOEDATA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS

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
	lcQuery = [Select a.MoeVs, Sum(a.Totas + a.ValRats) as Valos ] + ;
			    [From Sigmvitn a, sigcdpro b, sigcdgrp c ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalItens]) < 1)
	Select LocalItens
			lcQuery = [Select Grupos, IClis, RClis, Comis, CCargs ] + ;
		    		    [From Sigcdcli ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigcdcli') < 1)
			Select crSigCdCrg
		Select crAnalitico
				lcQuery = [Select a.EmpDopNums, a.Codigos, a.Emps, o.Dopes, Right(a.Codigos, 6) as Numes ] + ;
							[From SigMvPec a, SigMvCab b, SigCdOpe o ] + ;
								 [Not a.EmpDopNums In (Select n.EmpDopNums From SigMvNfi n ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSub]) < 1)
				Select LocalSub
					lcQuery = [Select b.NFis, b.EmpDopNums ] + ;
								[From SigMvNfi b ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNF]) < 1)
					Select LocalNF
				Select crAnalitico
			lcQuery = [Select RClis ] + ;
			    		[From Sigcdcli ] + ; 
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
			select Localcli
	lcQuery = [Select Emps, Dopes, Datas, Numes, Notas, Valos, GrVends, Vends, EmpDopNums, ContaDs ] + ;
			    [From SigMvCab ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvCab') < 1)
lcQuery = [Select a.cotfpgs, a.Empdopnums, a.dopes, a.fpags, a.moefpgs, ] + ;
     		[From SigMvPar a, SigOpFp b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigMvPar') < 1)
	lcQuery = [Select a.icmss from sigmvnfi a Where a.Empdopnums='] + crSigMvCab.empdopnums + [']
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crnfi') < 1)
Select crSigMvPar
	select parcela
	=seek(crSigMvPar.dopes,'crSigCdOpe','dopes')
	Select crSigOpFp
	select parcela
		lcQuery = [Select Grupos, IClis, RClis, Comis, CCargs ] + ;
	    		    [From SigCdCli ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCli') < 1)
		select crSigCdCli
			Select crSigCdCrg
		select crAnalitico
				lcQuery = [Select a.EmpDopNums, a.Codigos, a.Emps, o.Dopes, Right(a.Codigos, 6) as Numes ] + ;
							[From SigMvPec a, SigMvCab b, SigCdOpe o ] + ;
								 [Not a.EmpDopNums In (Select n.EmpDopNums From SigMvNfi n ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSub]) < 1)
				Select LocalSub
					lcQuery = [Select b.NFis, b.EmpDopNums ] + ;
								[From SigMvNfi b ] + ;
					If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNF]) < 1)
					Select LocalNF
				select crAnalitico
			lcQuery = [Select RClis ] + ;
			    		[From SigCdCli ] + ; 
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalCli') < 1)
			select Localcli
	select crSigMvPar
lcQrySigCdOpe = [Select ordes,dopes,cmoes,copers,ccomis,comcargs,vendas,calcfecs,relfechas,caixas From SigCdOpe ] + ;
lcQrySigCdEmp = [Select cemps,razas From SigCdEmp Where cemps=']+_Empr+[']
lcQrySigMvPar = [Select * From SigMvPar Where 1=0 ]
lcQrySigCdMoe = [Select cmoes,dmoes,cotas,datatrans,fmults,nordrels,disfpres,valadics,grumoes,moeqs,qtdeqs,submoes ]+;
			  [ From SigCdMoe ] + ;
lcQrySigCdCot = [Select cmoes,datas,horas,valos,cidchaves,usuars,dtalts From SigCdCot ]+;
		lcSql = [Select TitOpcS, TitOpcN, TitOpcA From SigCdPac]
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac') < 1
		Select LocalParac
		Select crSigCdOpe
		Select crSigCdMoe
		lcSql = [Select DMoes From SigCdMoe where cmoes = 'R  ']
		If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalMoe') < 1
		Select LocalMoe
		Select crSigCdCot
		lcQuery = [Select Fpags, Descs, Infos, FPComiss ] + ;
			        [From SigOpFp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigOpFp') < 1)
		Select crSigOpFp
		lcQuery = [Select CCargs, Comis ] + ;
	    		    [From SigCdCrg ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crSigCdCrg') < 1)
		Select crSigCdCrg
insert into dbcabecalho (NomeEmpresa,Titulo) Values (lcNmEmpresa,lcNmTitulo)
Select *, Valos as ValoAvs, Valos as Devols, Space(6) as Tipo ;
  From crSigMvPar ;
Select Parcela
select crSigCdOpe
	Select crSigMvCab
		select crSigMvCab
	select crSigCdOpe
select crSigCdOpe
	Select crSigMvCab
		select crSigMvCab		
	select crSigCdOpe	
select crSigCdOpe
	Select crSigMvCab
		select crSigMvCab		
	select crSigCdOpe	
select crSigCdOpe
	Select crSigMvCab
		select crSigMvCab		
	select crSigCdOpe	
	Select crAnalitico
		lcQuery = [Select a.EmpDopNums, a.Codigos, a.Emps, o.Dopes, Right(a.Codigos, 6) as Numes ] + ;
					[From SigMvPec a, SigMvCab b, SigCdOpe o ] + ;
						 [Not a.EmpDopNums In (Select n.EmpDopNums From SigMvNfi n ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalSub]) < 1)
		Select LocalSub
			lcQuery = [Select b.NFis, b.EmpDopNums ] + ;
						[From SigMvNfi b ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalNF]) < 1)
			Select LocalNF
	Select *, 000000.000 as qtds from crAnalitico into cursor crMedia readwrite
	SELECT crMedia
		lcQuery = [Select SUM(qtds) as Qtds from SigMvItn Where EmpDopNums = '] + crMedia.EmpDopNums + [' group by empdopnums]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalItn]) < 1)
	SELECT Vends, SUM(valos) as valos, COUNT(empdopnums) as Vendas, SUM(Qtds) as Qtds, SUM(comis) as comis from crMedia group by vends into cursor crMedia
	lcQ=[SELECT Vends, Qtds, valos/qtds, Vendas, valos/vendas, comis, valos from crMedia order by ] + ALLTRIM(STR(thisform.optOrdem.Value)) + [ into cursor crMedia]
	SELECT crMedia
	Select crAnalitico
lcQuery = [Select a.* From SigCdUsu a ]+;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpUsu') < 1)
Select TmpUsu
	select tmpusu
	if not seek(this.Value)
	select tmpusu

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecom.prg) - TRECHOS RELEVANTES PARA PASS SQL (1398 linhas total):

*-- Linhas 1069 a 1094:
1069:             IF EMPTY(loc_cValor)
1070:                 THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
1071:             ELSE
1072:                 loc_cSQL = "SELECT cmoes, dmoes FROM SigCdMoe " + ;
1073:                            "WHERE cmoes = " + EscaparSQL(PADR(loc_cValor, 3))
1074:                 IF USED("cursor_4c_MoeVal")
1075:                     USE IN cursor_4c_MoeVal
1076:                 ENDIF
1077:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoeVal")
1078:                 IF loc_nResult > 0 AND !EOF("cursor_4c_MoeVal")
1079:                     SELECT cursor_4c_MoeVal
1080:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ;
1081:                         ALLTRIM(cursor_4c_MoeVal.cmoes)
1082:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ;
1083:                         ALLTRIM(cursor_4c_MoeVal.dmoes)
1084:                 ELSE
1085:                     THIS.pgf_4c_Paginas.Page1.txt_4c_CdMoeda.Value = ""
1086:                     THIS.pgf_4c_Paginas.Page1.txt_4c_DsMoeda.Value = ""
1087:                     THIS.AbrirBuscaMoeda("cmoes")
1088:                 ENDIF
1089:                 IF USED("cursor_4c_MoeVal")
1090:                     USE IN cursor_4c_MoeVal
1091:                 ENDIF
1092:             ENDIF
1093:         CATCH TO loc_oErro
1094:             MsgErro(loc_oErro.Message, "ValidarCdMoeda")

*-- Linhas 1124 a 1150:
1124: 
1125:         TRY
1126:             IF !EMPTY(loc_cValor)
1127:                 loc_cSQL = "SELECT a.usuarios, a.NComps FROM SigCdUsu a " + ;
1128:                            "WHERE NOT a.cAtivos = 'N' " + ;
1129:                            "AND NOT a.Senhas = '" + SPACE(6) + "'"
1130:                 IF USED("cursor_4c_UsuVal")
1131:                     USE IN cursor_4c_UsuVal
1132:                 ENDIF
1133:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
1134:                 IF loc_nResult > 0
1135:                     SELECT cursor_4c_UsuVal
1136:                     LOCATE FOR ALLTRIM(cursor_4c_UsuVal.usuarios) == ALLTRIM(loc_cValor)
1137:                     IF !EOF("cursor_4c_UsuVal")
1138:                         THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ;
1139:                             ALLTRIM(cursor_4c_UsuVal.usuarios)
1140:                         loc_lEncontrou = .T.
1141:                     ENDIF
1142:                 ENDIF
1143:                 IF USED("cursor_4c_UsuVal")
1144:                     USE IN cursor_4c_UsuVal
1145:                 ENDIF
1146:                 IF !loc_lEncontrou
1147:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ""
1148:                     THIS.AbrirBuscaVendedor()
1149:                 ENDIF
1150:             ENDIF

*-- Linhas 1190 a 1208:
1190: 
1191:                 IF loc_oBusca.this_lSelecionou
1192:                     IF USED("cursor_4c_BuscaMoe")
1193:                         SELECT cursor_4c_BuscaMoe
1194:                         loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1195:                         loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
1196:                     ENDIF
1197:                 ELSE
1198:                     IF loc_cCampo = "cmoes"
1199:                         loc_oPagina.txt_4c_CdMoeda.Value = ""
1200:                     ENDIF
1201:                     loc_oPagina.txt_4c_DsMoeda.Value = ""
1202:                 ENDIF
1203: 
1204:                 IF USED("cursor_4c_BuscaMoe")
1205:                     USE IN cursor_4c_BuscaMoe
1206:                 ENDIF
1207:                 loc_oBusca.Release()
1208:             ENDIF

*-- Linhas 1237 a 1255:
1237: 
1238:                 IF loc_oBusca.this_lSelecionou
1239:                     IF USED("cursor_4c_BuscaUsu")
1240:                         SELECT cursor_4c_BuscaUsu
1241:                         loc_oPagina.txt_4c_Vendedor.Value = ;
1242:                             ALLTRIM(cursor_4c_BuscaUsu.usuarios)
1243:                     ENDIF
1244:                 ENDIF
1245: 
1246:                 IF USED("cursor_4c_BuscaUsu")
1247:                     USE IN cursor_4c_BuscaUsu
1248:                 ENDIF
1249:                 loc_oBusca.Release()
1250:             ENDIF
1251:         CATCH TO loc_oErro
1252:             MsgErro(loc_oErro.Message, "AbrirBuscaVendedor")
1253:         ENDTRY
1254:     ENDPROC
1255: 

