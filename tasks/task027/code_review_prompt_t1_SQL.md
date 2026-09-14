# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-ASPAS] Linha 368: Concatenacao direta de variavel em SQL sem EscaparSQL(). CORRIGIR: usar EscaparSQL(variavel) que ja retorna com aspas. Linha: "WHERE EmpGruEsts = '" + loc_cEGEs + "' AND Datas <= ?loc_tDtFin " + ;

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
	Insert Into TmpEstoque (Emps,Grupos,Estos) Values (Padr(lcEmpEst,3),Padr(lcGruEst,10),Padr(lcEstEst,10))
	lStrQuery = [Select Emps,Grupos,Estos From SigMvEst ]+;
	If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpEstoque') < 1
Select TmpEstoque
lcQuery = [Select a.cIdChaves, a.Emps, a.Grupos, a.Estos, a.Cpros, c.Mercs as GGrupo ] + ;
			[From SigMvEst a, SigCdPro b, SigCdGrp c ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [TmpSigMvEst]) < 1)
Select TmpSigMvEst
	Insert Into TmpEst From MemVar
Select TmpEst
			Select SigMvHst
	Select TmpEstoque
		loBarraHis.Update(.T.)
		lStrQuery = [Select Emps,Grupos,Estos,CPros,Dopes,Numes,Datas,Qtds,Opers,SQtds,EmpGruEsts,CIdChaves ]+;
					  [From SigMvHst ]+;
		If ThisForm.poDataMgr.SqlExecute(lStrQuery,'CsHis') < 1
		Select CsHis
			Insert Into CrSigMvHst From MemVar
	Select CrSigMvHst
Select TmpEst
	loBarraEst.Update(.T.,'Produto: ' + TmpEst.cpros)
		Select SigMvHst
		Select Top 1 Emps,Grupos,Estos,CPros,Datas,SQtds ;
		From CrSigMvHst ;
		Select CrTmpHis
Select Emps, GGrupo, Max(Grupos) as Grupos, Max(Estos) as Estos, Sum(SalIni) as Saldo ;
  From TmpEst ;
Select csSaldoIni
Select TmpEst
	loBarraEst.Update(.T.,'Produto: ' + TmpEst.cpros)
		Select SigMvHst
		Select Top 1 Emps,Grupos,Estos,CPros,Datas,SQtds ;
		From CrSigMvHst ;
		Select CrTmpHis
	Select TmpEst
Select Emps, GGrupo, Max(Grupos) as Grupos, Max(Estos) as Estos, Sum(SalAtu) as Saldo ;
  From TmpEst ;
Select csSaldoFin
	Select a.Emps,a.Grupos,a.Estos,a.Dopes,a.Numes,a.CPros,a.Qtds,a.Opers,'   ' As ggrupo ;
	  From SigMvHst a ;
	Select a.Emps,a.Grupos,a.Estos,a.Dopes,a.Numes,a.CPros,a.Qtds,a.Opers,'   ' As ggrupo ;
	  From CrSigMvHst a ;
Select TmpHis
	loBarraHis.Update(.T.)
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cpros,cgrus From SigCdPro Where cpros = ']+TmpHis.cpros+[' ],'TmpPro')
	Select TmpPro
		If Seek(TmpPro.cgrus,'CrSigCdGrp','cgrus')
Select Emps, GGrupo, Dopes, Numes, ;
  From TmpHis ;
Select Emps, GGrupo, Dopes, Numes, ;
  From TmpHis ;
Select Emps, GGrupo, Dopes, Sum(Entradas) as Entradas, Sum(Saidas) as Saidas ;
  From csHist ;
Select TmpEstoque
	loBarraEst.Update(.T.)
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cidchaves,a.empdopnums,a.grupoos,a.grupods,a.contaos,a.contads,]+;
				[From SigMvCab a, SigCdOpe o ]+;
	Select TmpMvO
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cidchaves,a.empdopnums,a.grupoos,a.grupods,a.contaos,a.contads,]+;
				[From SigMvCab a, SigCdOpe o ]+;
	Select TmpMvD
	lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cidchaves,a.empds,a.emps,a.dopes,a.numes,a.grupoos,a.grupods,]+;
				[From SigMvCab a, SigCdOpe o ]+;
	Select TmpTrf
	Select a.empdopnums,a.grupoos,a.grupods,a.contaos,a.contads,a.opers,a.origems,a.destinos,a.estorigs,a.estdests ;
	  From TmpMvO a ;
	Select b.empdopnums,b.grupoos,b.grupods,b.contaos,b.contads,b.opers,b.origems,b.destinos,b.estorigs,b.estdests ;
	  From TmpMvD b ;
	Select c.emps+c.dopes+Str(c.numes,6) As empdopnums,c.grupoos,c.grupods,c.contaos,c.contads,c.opers,c.origems,;
	  From TmpTrf c ;
	Select empdopnums,Max(grupoos) as grupoos,Max(grupods) as grupods,Max(contaos) as contaos, ;
	From CsEest ;
	Select TprMvCab
		loBarEest.Update(.T.,Substr(lcEDNs,1,3) + ' - ' + AllTrim(Substr(lcEDNs,4,20)) + ' - ' + Alltrim(Substr(lcEDNs,24,6)))
		lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.cidchaves,a.emps,a.dopes,a.numes,a.cpros,a.opers,a.qtds,a.qtds * a.pesos as Pesos,p.cgrus ]+;
					[From SigMvItn a, SigCdPro p ]+;
		Select crLclMvItn
			=Seek(crLclMvItn.cgrus,'CrSigCdGrp','cgrus')
				Select crLclMvItn
				Insert Into CsMov From MemVar
			Select crLclMvItn
	Select TmpEstoque
Select CsMov
Select Emps, GGrupo, Dopes, Numes, ;
  From CsMov ;
Select csMovimento
Select Emps, GGrupo, Dopes, Numes, ;
  From CsMov ;
Select csmovs
Select Emps, GGrupo, Dopes, Sum(Entradas) as Entradas, Sum(Saidas) as Saidas, Sum(PesoEs) as PesoEs, Sum(PesoSs) as PesoSs ;
  From csMovs ;
Select csTotMov
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopps As dopes,a.numps As numes,b.codpds As cpros,b.qtds,]+;
			[From SigCdNec a, SigPdMvf b, SigCdPro c ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopps As dopes,a.numps As numes,b.codpds As cpros,b.qtds,]+;
			[From SigCdNec a, SigPdMvf b, SigCdPro c ]+;
Select TmpPdE
	m.ggrupo = Iif(Seek(TmpPdE.cgrus,'CrSigCdGrp','cgrus'),CrSigCdGrp.mercs,'')
	Insert Into CsPrd From MemVar
Select TmpPdE2
	m.ggrupo = Iif(Seek(TmpPdE2.cgrus,'CrSigCdGrp','cgrus'),CrSigCdGrp.mercs,'')
	Insert Into CsPrd From MemVar
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopps As dopes,a.numps As numes,b.cmats As cpros,b.qtds,]+;
			[From SigCdNec a, SigCdNei b, SigCdPro c ]+;
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select a.emps,a.dopps As dopes,a.numps As numes,b.cmats As cpros,b.qtds,]+;
			[From SigCdNec a, SigCdNei b, SigCdPro c ]+;
Select * From TmpEnc ;
Select * From TmpFun ;
Select TmpPdS
	If Seek(TmpPdS.cgrus,'CrSigCdGrp','cgrus')
		Insert Into CsPrd From MemVar
Select Emps, GGrupo, Dopes, Numes, ;
  From csPrd ;
Select Emps, GGrupo, Dopes, Numes, ;
  From csPrd ;
Select Emps, GGrupo, Dopes, Sum(Entradas) as Entradas, Sum(Saidas) as Saidas ;
  From csPrds ;
Select a.emps,a.ggrupo,a.dopes,a.entradas As entmov,a.saidas As saimov,00000000.000 As enthis,00000000.000 As saihis, ;
  From CsTotMov a ;
Select a.emps,a.ggrupo,a.dopes,a.entradas As entmov,a.saidas As saimov,00000000.000 As enthis,00000000.000 As saihis, ;
  From CsTotPrd a ;
Select b.emps,b.ggrupo,b.dopes,00000000.000 As entmov,00000000.000 As saimov,b.entradas As enthis,b.saidas As saihis, ;
  From CsTotHis b ;
Select Emps, GGrupo, Dopes, Sum(EntMov) as EntMov, Sum(SaiMov) as SaiMov, Sum(EntHis) as EntHis, ;
  From TmpMovHis ;
Select CsMovHis
Select CsSaldoIni
	loBarraMov.Update(.T.)
	=Seek(CsSaldoIni.GGrupo, 'CsSaldoFin', 'ggrupo')
	Select CsMovHis
	If Seek(CsSaldoIni.ggrupo,'CsMovHis','ggrupo')
			Insert Into CsRel From MemVar
			Select CsMovHis
		Select CsRel
	Select CsSaldoIni
Select * ;
  From CsMovimento ;
Select *, 00000000.000 as PesoEs, 00000000.000 as PesoSs ;
  From CsProducao ;
Select Emps, Dopes, Numes, GGrupo, Sum(Entradas) as Entradas, Sum(Saidas) as Saidas, Sum(PesoEs) as PesoEs, Sum(PesoSs) as PesoSs ;
  From CsMovPrd ;
Select a.emps,a.dopes,a.numes,a.GGrupo,a.entradas As entmov,a.saidas As saimov,b.entradas As enthis,b.saidas As saihis, a.PesoEs, a.PesoSs ;
  From CsMoviProd a, csHistorico b ;
Select a.emps,a.dopes,a.numes,a.GGrupo,a.entradas As entmov,a.saidas As saimov,00000000.000 As enthis,00000000.000 As saihis, ;
  From CsMoviProd a ;
 Where a.emps+a.dopes+Str(a.numes,6)+a.GGrupo Not In (Select b.emps+b.dopes+Str(b.numes,6)+b.GGrupo As empdopnums From CsHistorico b) ;
Select a.emps,a.dopes,a.numes,a.GGrupo,00000000.000 As entmov,00000000.000 As saimov,a.entradas As enthis,a.saidas As saihis, ;
  From CsHistorico a ;
 Where a.emps+a.dopes+Str(a.numes,6)+a.GGrupo Not In (Select b.emps+b.dopes+Str(b.numes,6)+b.GGrupo As empdopnums From CsMoviProd b) ;
Select CsDif
Select CsRel
Select CsDiferenca
lcNomeEmpresa = _Empr + IIf(Seek(_Empr,'CrSigCdEmp','cemps'),' - ' + CrSigCdEmp.razas,'')
Insert Into CsCabecalho (nomeempresa,titulo1,titulo2,periodo);
	Select CrSigCdEmp
		loBarraEmp.Update(.T.,'Empresa: ' + CrSigCdEmp.cemps + ' - ' + CrSigCdEmp.razas)
				Select * From CsRel Into Cursor CsRelatorio ReadWrite
				Select * From CsDif Into Cursor CsDiferenca ReadWrite
				Select CsRel
					Insert Into CsRelatorio From MemVar
				Select CsDif
					Insert Into CsDiferenca From MemVar
	Select * From CsRel Into Cursor CsRelatorio ReadWrite
	Select * From CsDif Into Cursor CsDiferenca ReadWrite
Select CsDiferenca
Select CsRelatorio
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cemps,razas,ativas From SigCdEmp ],'CrSigCdEmp')
Select CrSigCdEmp
lnQueryOk = ThisForm.poDataMgr.SqlExecute([Select cgrus,mercs,cestoqs From SigCdGrp ],'CrSigCdGrp')
Select CrSigCdGrp
Select CsDiferenca

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREAEG.prg) - TRECHOS RELEVANTES PARA PASS SQL (1325 linhas total):

*-- Linhas 304 a 384:
304:     *--------------------------------------------------------------------------
305:     * ConfigurarPaginaLista - Carrega cursores de referencia em memoria
306:     *   Form de relatorio nao tem grid CRUD; esta fase carrega os cursores que
307:     *   o original carregava no Init via poDataMgr.SqlExecute:
308:     *     CrSigCdEmp (cemps/razas/ativas) -> indexado por cemps para SEEK em ValidarEmpresa
309:     *     CrSigCdGrp (cgrus/mercs/cestoqs) -> referencia de grupos de estoque
310:     *   Se a carga falhar, as validacoes fazem fallback para SQLEXEC direto.
311:     *--------------------------------------------------------------------------
312:     PROTECTED PROCEDURE ConfigurarPaginaLista()
313:         LOCAL loc_nResult
314:         TRY
315:             *-- Cursor de empresas: usado por ValidarEmpresa() via SEEK(cemps)
316:             IF USED("cursor_4c_SigCdEmp")
317:                 USE IN cursor_4c_SigCdEmp
318:             ENDIF
319:             loc_nResult = SQLEXEC(gnConnHandle, ;
320:                 "SELECT cemps, razas, ativas FROM SigCdEmp ORDER BY cemps", ;
321:                 "cursor_4c_SigCdEmp")
322:             IF loc_nResult > 0
323:                 SELECT cursor_4c_SigCdEmp
324:                 INDEX ON cemps TAG cemps ADDITIVE
325:                 GO TOP
326:             ELSE
327:                 MsgAviso("Falha ao carregar empresas." + CHR(13) + ;
328:                     "Valida" + CHR(231) + CHR(227) + "o de empresa usar" + ;
329:                     CHR(225) + " consulta direta.", "Aviso")
330:             ENDIF
331: 
332:             *-- Cursor de grupos de estoque: referencia carregada no Init original
333:             IF USED("cursor_4c_SigCdGrp")
334:                 USE IN cursor_4c_SigCdGrp
335:             ENDIF
336:             loc_nResult = SQLEXEC(gnConnHandle, ;
337:                 "SELECT cgrus, mercs, cestoqs FROM SigCdGrp ORDER BY cgrus", ;
338:                 "cursor_4c_SigCdGrp")
339:             IF loc_nResult < 1
340:                 MsgAviso("Falha ao carregar grupos de estoque." + CHR(13) + ;
341:                     "Valida" + CHR(231) + CHR(227) + "o usar" + CHR(225) + ;
342:                     " consulta direta.", "Aviso")
343:             ENDIF
344:         CATCH TO loc_oErro
345:             MsgErro(loc_oErro.Message, "Erro")
346:         ENDTRY
347:     ENDPROC
348: 
349:     *--------------------------------------------------------------------------
350:     * ConfigurarPaginaDados - Todos os campos de filtro do relatorio em Page1
351:     *   Ajuste de Top: Top_Page1 = Top_original - 85 (PageFrame inicia em Top=85)
352:     *   Empresa (top=120->35), GGrupo (top=145->60), GrEstoque (top=172->87),
353:     *   Estoque (top=199->114), Periodo (top=226->141)
354:     *--------------------------------------------------------------------------
355:     PROTECTED PROCEDURE ConfigurarPaginaDados()
356:         LOCAL loc_oPagina
357:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
358: 
359:         *-- EMPRESA (original Say5 top=123->38, getEmpresa top=120->35, getDesEmpresa top=120->35)
360:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
361:         WITH loc_oPagina.lbl_4c_Empresa
362:             .Top       = 38
363:             .Left      = 224
364:             .AutoSize  = .T.
365:             .Caption   = "Empresa :"
366:             .FontName  = "Tahoma"
367:             .FontSize  = 8
368:             .ForeColor = RGB(90, 90, 90)
369:             .BackStyle = 0
370:             .Visible   = .T.
371:         ENDWITH
372: 
373:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
374:         WITH loc_oPagina.txt_4c_Empresa
375:             .Top       = 35
376:             .Left      = 279
377:             .Width     = 31
378:             .Height    = 23
379:             .MaxLength = 3
380:             .Value     = ""
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .BackColor = RGB(255, 255, 255)
384:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 792 a 810:
792:                 loc_oBusca.mAddColuna("razas", "", "Raz" + CHR(227) + "o Social")
793:                 loc_oBusca.Show()
794:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
795:                     SELECT (loc_cCursor)
796:                     loc_oPagina.txt_4c_Empresa.Value    = ALLTRIM(cemps)
797:                     loc_oPagina.txt_4c_DesEmpresa.Value = ALLTRIM(razas)
798:                 ENDIF
799:                 loc_oBusca.Release()
800:             ENDIF
801:         CATCH TO loc_oErro
802:             MsgErro(loc_oErro.Message, "Erro")
803:         ENDTRY
804:         IF USED(loc_cCursor)
805:             USE IN (loc_cCursor)
806:         ENDIF
807:     ENDPROC
808: 
809:     *==========================================================================
810:     *  VALIDACAO + LOOKUP - Grande Grupo (SigCdGpr)

*-- Linhas 823 a 845:
823:                 loc_oPagina.txt_4c_DsGGrupo.Value = ""
824:                 RETURN
825:             ENDIF
826:             loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGpr WHERE codigos = " + ;
827:                        EscaparSQL(loc_cCodigo)
828:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpVal")
829:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGGrpVal")
830:                 SELECT cursor_4c_SigreaGGrpVal
831:                 loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.codigos)
832:                 loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(cursor_4c_SigreaGGrpVal.descs)
833:             ELSE
834:                 MsgAviso("Grande Grupo n" + CHR(227) + "o encontrado.", "Grande Grupo")
835:                 loc_oPagina.txt_4c_CdGGrupo.Value = ""
836:                 loc_oPagina.txt_4c_DsGGrupo.Value = ""
837:                 THIS.AbrirBuscaGGrupo()
838:             ENDIF
839:             IF USED("cursor_4c_SigreaGGrpVal")
840:                 USE IN cursor_4c_SigreaGGrpVal
841:             ENDIF
842:         CATCH TO loc_oErro
843:             MsgErro(loc_oErro.Message, "Erro")
844:         ENDTRY
845:     ENDPROC

*-- Linhas 863 a 881:
863:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
864:                 loc_oBusca.Show()
865:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
866:                     SELECT (loc_cCursor)
867:                     loc_oPagina.txt_4c_CdGGrupo.Value = ALLTRIM(codigos)
868:                     loc_oPagina.txt_4c_DsGGrupo.Value = ALLTRIM(descs)
869:                 ENDIF
870:                 loc_oBusca.Release()
871:             ENDIF
872:         CATCH TO loc_oErro
873:             MsgErro(loc_oErro.Message, "Erro")
874:         ENDTRY
875:         IF USED(loc_cCursor)
876:             USE IN (loc_cCursor)
877:         ENDIF
878:     ENDPROC
879: 
880:     *==========================================================================
881:     *  VALIDACAO + LOOKUP - Grupo de Estoque (SigCdGcr)

*-- Linhas 896 a 918:
896:                 loc_oPagina.txt_4c_DsEstoque.Value   = ""
897:                 RETURN
898:             ENDIF
899:             loc_cSQL = "SELECT TOP 1 codigos, descs FROM SigCdGcr WHERE codigos = " + ;
900:                        EscaparSQL(loc_cCodigo)
901:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrVal")
902:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaGcrVal")
903:                 SELECT cursor_4c_SigreaGcrVal
904:                 loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.codigos)
905:                 loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(cursor_4c_SigreaGcrVal.descs)
906:             ELSE
907:                 MsgAviso("Grupo de Estoque n" + CHR(227) + "o encontrado.", ;
908:                          "Grupo de Estoque")
909:                 loc_oPagina.txt_4c_CdGrEstoque.Value = ""
910:                 loc_oPagina.txt_4c_DsGrEstoque.Value = ""
911:                 THIS.AbrirBuscaGrEstoque()
912:             ENDIF
913:             IF USED("cursor_4c_SigreaGcrVal")
914:                 USE IN cursor_4c_SigreaGcrVal
915:             ENDIF
916:         CATCH TO loc_oErro
917:             MsgErro(loc_oErro.Message, "Erro")
918:         ENDTRY

*-- Linhas 937 a 955:
937:                 loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
938:                 loc_oBusca.Show()
939:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
940:                     SELECT (loc_cCursor)
941:                     loc_oPagina.txt_4c_CdGrEstoque.Value = ALLTRIM(codigos)
942:                     loc_oPagina.txt_4c_DsGrEstoque.Value = ALLTRIM(descs)
943:                     *-- Limpar conta de estoque ao trocar grupo (comportamento do original)
944:                     loc_oPagina.txt_4c_CdEstoque.Value = ""
945:                     loc_oPagina.txt_4c_DsEstoque.Value = ""
946:                 ENDIF
947:                 loc_oBusca.Release()
948:             ENDIF
949:         CATCH TO loc_oErro
950:             MsgErro(loc_oErro.Message, "Erro")
951:         ENDTRY
952:         IF USED(loc_cCursor)
953:             USE IN (loc_cCursor)
954:         ENDIF
955:     ENDPROC

*-- Linhas 975 a 999:
975:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
976:             loc_cFiltro = ""
977:             IF !EMPTY(loc_cGrupo)
978:                 loc_cFiltro = " AND iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
979:             ENDIF
980:             loc_cSQL = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE iclis = " + ;
981:                        EscaparSQL(loc_cCodigo) + loc_cFiltro
982:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliVal")
983:             IF loc_nResult > 0 AND !EOF("cursor_4c_SigreaCliVal")
984:                 SELECT cursor_4c_SigreaCliVal
985:                 loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.iclis)
986:                 loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(cursor_4c_SigreaCliVal.rclis)
987:             ELSE
988:                 MsgAviso("Conta de Estoque n" + CHR(227) + "o encontrada.", ;
989:                          "Conta de Estoque")
990:                 loc_oPagina.txt_4c_CdEstoque.Value = ""
991:                 loc_oPagina.txt_4c_DsEstoque.Value = ""
992:                 THIS.AbrirBuscaEstoque()
993:             ENDIF
994:             IF USED("cursor_4c_SigreaCliVal")
995:                 USE IN cursor_4c_SigreaCliVal
996:             ENDIF
997:         CATCH TO loc_oErro
998:             MsgErro(loc_oErro.Message, "Erro")
999:         ENDTRY

*-- Linhas 1013 a 1042:
1013:             loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
1014:             loc_cFiltro = ""
1015:             IF !EMPTY(loc_cGrupo)
1016:                 loc_cFiltro = "iclis LIKE " + EscaparSQL(loc_cGrupo + "%")
1017:             ENDIF
1018: 
1019:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1020:                 "SigCdCli", loc_cCursor, "iclis", loc_cValor, ;
1021:                 "Selecionar Conta de Estoque", loc_cFiltro)
1022:             IF VARTYPE(loc_oBusca) = "O"
1023:                 loc_oBusca.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1024:                 loc_oBusca.mAddColuna("rclis", "", "Nome")
1025:                 loc_oBusca.Show()
1026:                 IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
1027:                     SELECT (loc_cCursor)
1028:                     loc_oPagina.txt_4c_CdEstoque.Value = ALLTRIM(iclis)
1029:                     loc_oPagina.txt_4c_DsEstoque.Value = ALLTRIM(rclis)
1030:                 ENDIF
1031:                 loc_oBusca.Release()
1032:             ENDIF
1033:         CATCH TO loc_oErro
1034:             MsgErro(loc_oErro.Message, "Erro")
1035:         ENDTRY
1036:         IF USED(loc_cCursor)
1037:             USE IN (loc_cCursor)
1038:         ENDIF
1039:     ENDPROC
1040: 
1041:     *==========================================================================
1042:     *  TRANSFERENCIA DE DADOS - Form -> BO

*-- Linhas 1090 a 1151:
1090:             *-- Valida Grupo de Estoque (se informado)
1091:             loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGrEstoque.Value)
1092:             IF !EMPTY(loc_cCodigo)
1093:                 loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGcr WHERE codigos = " + ;
1094:                               EscaparSQL(loc_cCodigo)
1095:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGcrChk")
1096:                 IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGcrChk")
1097:                     MsgErro("Grupo de Estoque Inv" + CHR(225) + "lido.", "")
1098:                     IF USED("cursor_4c_SigreaGcrChk")
1099:                         USE IN cursor_4c_SigreaGcrChk
1100:                     ENDIF
1101:                     loc_oPagina.txt_4c_CdGrEstoque.SetFocus()
1102:                     loc_lResultado = .F.
1103:                 ENDIF
1104:                 IF USED("cursor_4c_SigreaGcrChk")
1105:                     USE IN cursor_4c_SigreaGcrChk
1106:                 ENDIF
1107:             ENDIF
1108: 
1109:             *-- Valida Conta de Estoque (se informado)
1110:             IF loc_lResultado
1111:                 loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdEstoque.Value)
1112:                 IF !EMPTY(loc_cCodigo)
1113:                     loc_cSQL    = "SELECT TOP 1 iclis FROM SigCdCli WHERE iclis = " + ;
1114:                                   EscaparSQL(loc_cCodigo)
1115:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaCliChk")
1116:                     IF loc_nResult < 1 OR EOF("cursor_4c_SigreaCliChk")
1117:                         MsgErro("Conta de Estoque Inv" + CHR(225) + "lida.", "")
1118:                         IF USED("cursor_4c_SigreaCliChk")
1119:                             USE IN cursor_4c_SigreaCliChk
1120:                         ENDIF
1121:                         loc_oPagina.txt_4c_CdEstoque.SetFocus()
1122:                         loc_lResultado = .F.
1123:                     ENDIF
1124:                     IF USED("cursor_4c_SigreaCliChk")
1125:                         USE IN cursor_4c_SigreaCliChk
1126:                     ENDIF
1127:                 ENDIF
1128:             ENDIF
1129: 
1130:             *-- Valida Grande Grupo (se informado)
1131:             IF loc_lResultado
1132:                 loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CdGGrupo.Value)
1133:                 IF !EMPTY(loc_cCodigo)
1134:                     loc_cSQL    = "SELECT TOP 1 codigos FROM SigCdGpr WHERE codigos = " + ;
1135:                                   EscaparSQL(loc_cCodigo)
1136:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigreaGGrpChk")
1137:                     IF loc_nResult < 1 OR EOF("cursor_4c_SigreaGGrpChk")
1138:                         MsgErro("Grande Grupo Inv" + CHR(225) + "lido.", "")
1139:                         IF USED("cursor_4c_SigreaGGrpChk")
1140:                             USE IN cursor_4c_SigreaGGrpChk
1141:                         ENDIF
1142:                         loc_oPagina.txt_4c_CdGGrupo.SetFocus()
1143:                         loc_lResultado = .F.
1144:                     ENDIF
1145:                     IF USED("cursor_4c_SigreaGGrpChk")
1146:                         USE IN cursor_4c_SigreaGGrpChk
1147:                     ENDIF
1148:                 ENDIF
1149:             ENDIF
1150: 
1151:             *-- Valida data inicial

*-- Linhas 1233 a 1251:
1233:                 MsgAviso("Nenhum dado encontrado para os filtros selecionados.", "Excel")
1234:                 RETURN
1235:             ENDIF
1236:             SELECT CsRelatorio
1237:             loc_cArquivo = PUTFILE("Salvar como...", "RelAnaliseEstoque", "xls")
1238:             IF EMPTY(loc_cArquivo)
1239:                 RETURN
1240:             ENDIF
1241:             COPY TO (loc_cArquivo) TYPE XL5
1242:             MsgInfo("Arquivo exportado com sucesso:" + CHR(13) + loc_cArquivo, "Excel")
1243:         CATCH TO loc_oErro
1244:             MsgErro(loc_oErro.Message, "Erro")
1245:         ENDTRY
1246:     ENDPROC
1247: 
1248:     *--------------------------------------------------------------------------
1249:     * BtnEncerrarClick - Fecha o formulario de relatorio
1250:     *   Equivale ao btnReport.Sair (Cancel=.T. no framework, ESC tambem fecha)
1251:     *--------------------------------------------------------------------------

