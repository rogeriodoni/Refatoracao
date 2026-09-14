# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (7)
- [SQL-ASPAS] Linha 357: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE b.EmpDopNums = '" + loc_lcEdn + "'"
- [SQL-ASPAS] Linha 641: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE b.EmpDopNums = '" + loc_lcEdn + "'"
- [SQL-ASPAS] Linha 929: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE b.EmpDopNums = '" + loc_lcEdn + "'"
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '2' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SERVICOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOEDATA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUARIOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPDOPNUMS, ICLIS, LNTIP, VENDS, CEMPS, 1, CMOES, 0, VENDAS, CALCFECS, CAIXAS, COPERS, RELFECHAS, CPROS, CGRUS, GRUPOS, DATAS, FPAGS

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecom.prg) - TRECHOS RELEVANTES PARA PASS SQL (1396 linhas total):

*-- Linhas 343 a 373:
343:             .MaxLength   = 10
344:             .SpecialEffect = 1
345:             .BorderStyle = 1
346:             .Visible     = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oPagina.txt_4c_DtFinal, "KeyPress", THIS, "TeclaDataFinal")
349: 
350:         *-- Moeda
351:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
352:         WITH loc_oPagina.lbl_4c_Moeda
353:             .Top       = 32
354:             .Left      = 219
355:             .Width     = 42
356:             .Height    = 18
357:             .Caption   = "Moeda :"
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .ForeColor = RGB(90, 90, 90)
361:             .BackStyle = 0
362:             .Visible   = .T.
363:         ENDWITH
364: 
365:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
366:         WITH loc_oPagina.txt_4c_CdMoeda
367:             .Top           = 28
368:             .Left          = 264
369:             .Width         = 31
370:             .Height        = 23
371:             .Value         = ""
372:             .FontName      = "Tahoma"
373:             .FontSize      = 8

*-- Linhas 627 a 657:
627:                 .AutoSize  = .T.
628:                 .BackStyle = 0
629:                 .FontName  = "Tahoma"
630:                 .FontSize  = 8
631:                 .ForeColor = RGB(90, 90, 90)
632:             ENDWITH
633:         ENDWITH
634: 
635:         *-- Valor Base (Itens / Movimentacao / Movimentacao S/ST)
636:         loc_oPagina.AddObject("lbl_4c_Base", "Label")
637:         WITH loc_oPagina.lbl_4c_Base
638:             .Top       = 152
639:             .Left      = 201
640:             .Width     = 56
641:             .Height    = 18
642:             .Caption   = "Valor Base :"
643:             .FontName  = "Tahoma"
644:             .FontSize  = 8
645:             .ForeColor = RGB(90, 90, 90)
646:             .BackStyle = 0
647:             .Visible   = .T.
648:         ENDWITH
649: 
650:         loc_oPagina.AddObject("opt_4c_Base", "OptionGroup")
651:         WITH loc_oPagina.opt_4c_Base
652:             .Top         = 148
653:             .Left        = 259
654:             .Width       = 364
655:             .Height      = 23
656:             .ButtonCount = 3
657:             .AutoSize    = .F.

*-- Linhas 915 a 945:
915:             .this_nOrdem     = loc_oPagina.opt_4c_Ordem.Value
916:         ENDWITH
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * BtnVisualizarClick - Preview do relatorio na tela
921:     *--------------------------------------------------------------------------
922:     PROCEDURE BtnVisualizarClick()
923:         LOCAL loc_oErro, loc_lContinuar
924:         loc_lContinuar = .T.
925:         TRY
926:             IF EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value) OR ;
927:                EMPTY(THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value)
928:                 MsgAviso("Informe o per" + CHR(237) + "odo.", ;
929:                          "Valida" + CHR(231) + CHR(227) + "o")
930:                 loc_lContinuar = .F.
931:             ENDIF
932:             IF loc_lContinuar
933:                 THIS.FormParaRelatorio()
934:                 IF !THIS.this_oRelatorio.Visualizar()
935:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
936:                             "Erro ao Visualizar")
937:                 ENDIF
938:             ENDIF
939:         CATCH TO loc_oErro
940:             MsgErro(loc_oErro.Message + CHR(13) + ;
941:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Detalhado")
942:         ENDTRY
943:     ENDPROC
944: 
945:     *--------------------------------------------------------------------------

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

*-- Linhas 1124 a 1151:
1124: 
1125:         TRY
1126:             IF !EMPTY(loc_cValor)
1127:                 loc_cSQL = "SELECT a.usuarios, a.NComps FROM SigCdUsu a " + ;
1128:                            "WHERE NOT a.cAtivos = 'N' " + ;
1129:                            "AND NOT a.Senhas = '" + SPACE(6) + "' " + ;
1130:                            "AND a.usuarios = " + EscaparSQL(loc_cValor)
1131:                 IF USED("cursor_4c_UsuVal")
1132:                     USE IN cursor_4c_UsuVal
1133:                 ENDIF
1134:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuVal")
1135:                 IF loc_nResult > 0 AND !EOF("cursor_4c_UsuVal")
1136:                     SELECT cursor_4c_UsuVal
1137:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ;
1138:                         ALLTRIM(cursor_4c_UsuVal.usuarios)
1139:                     loc_lEncontrou = .T.
1140:                 ENDIF
1141:                 IF USED("cursor_4c_UsuVal")
1142:                     USE IN cursor_4c_UsuVal
1143:                 ENDIF
1144:                 IF !loc_lEncontrou
1145:                     THIS.pgf_4c_Paginas.Page1.txt_4c_Vendedor.Value = ""
1146:                     THIS.AbrirBuscaVendedor()
1147:                 ENDIF
1148:             ENDIF
1149:         CATCH TO loc_oErro
1150:             MsgErro(loc_oErro.Message, "ValidarVendedor")
1151:         ENDTRY

*-- Linhas 1188 a 1206:
1188: 
1189:                 IF loc_oBusca.this_lSelecionou
1190:                     IF USED("cursor_4c_BuscaMoe")
1191:                         SELECT cursor_4c_BuscaMoe
1192:                         loc_oPagina.txt_4c_CdMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1193:                         loc_oPagina.txt_4c_DsMoeda.Value = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
1194:                     ENDIF
1195:                 ELSE
1196:                     IF loc_cCampo = "cmoes"
1197:                         loc_oPagina.txt_4c_CdMoeda.Value = ""
1198:                     ENDIF
1199:                     loc_oPagina.txt_4c_DsMoeda.Value = ""
1200:                 ENDIF
1201: 
1202:                 IF USED("cursor_4c_BuscaMoe")
1203:                     USE IN cursor_4c_BuscaMoe
1204:                 ENDIF
1205:                 loc_oBusca.Release()
1206:             ENDIF

*-- Linhas 1235 a 1253:
1235: 
1236:                 IF loc_oBusca.this_lSelecionou
1237:                     IF USED("cursor_4c_BuscaUsu")
1238:                         SELECT cursor_4c_BuscaUsu
1239:                         loc_oPagina.txt_4c_Vendedor.Value = ;
1240:                             ALLTRIM(cursor_4c_BuscaUsu.usuarios)
1241:                     ENDIF
1242:                 ENDIF
1243: 
1244:                 IF USED("cursor_4c_BuscaUsu")
1245:                     USE IN cursor_4c_BuscaUsu
1246:                 ENDIF
1247:                 loc_oBusca.Release()
1248:             ENDIF
1249:         CATCH TO loc_oErro
1250:             MsgErro(loc_oErro.Message, "AbrirBuscaVendedor")
1251:         ENDTRY
1252:     ENDPROC
1253: 

