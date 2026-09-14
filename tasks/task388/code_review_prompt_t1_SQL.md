# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna '1' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CODIGOS, DESCS, ESTADOS, LNCNT, ICLIS, DTALTS, LNERR, GRUCONTAS, CONTAS, PNRETORNO, CPFS, CARACTER, COLETORS, LIMESTOQS, LCTMPICLI, ITRAS, CODS, TPCODS, AUTOS, CARACTERIS, PCTPCADCLI, TPCADS, FISCAIS, EMPRESAS, CONTABS, INFCADS, REFBANCS, FOLLOWUPS, I, USUAR, TOTA, PCESCOLHA, CODCL, UFIBGES
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, CODIGOS, DESCS, ESTADOS, LNCNT, ICLIS, DTALTS, LNERR, GRUCONTAS, CONTAS, PNRETORNO, CPFS, CARACTER, COLETORS, LIMESTOQS, LCTMPICLI, ITRAS, CODS, TPCODS, AUTOS, CARACTERIS, PCTPCADCLI, TPCADS, FISCAIS, EMPRESAS, CONTABS, INFCADS, REFBANCS, FOLLOWUPS, I, USUAR, TOTA, PCESCOLHA, CODCL, UFIBGES

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
  pgframeDados.pgframeDados1.GetDatNas.ControlSource = "crSigCdCli.nascs"
  pgframeDados.pgframeDados1.Get_Idconta.ControlSource = "crSigCdCli.idcontas"
  pgframeDados.pgframeDados5.op_vincula.ControlSource = "crSigCdCli.Vinculas"
	Select LocalSct
	lcQuery = [Select Descs ] + ;
			    [From SigCdClc ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalClc]) < 1)
	Select LocalClc
	lcQuery = [Select Descrs ] + ;
			    [From SigCdCst ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCst]) < 1)
	Select LocalCst
		If (ThisForm.poDataMgr.SqlExecute([Select Descrs From SigOpTdz Where Codigos ='] + crSigCdCli.TabDs + ['], [crTmp]) < 1)
		If (ThisForm.poDataMgr.SqlExecute([Select Descrs From SigOpTdz Where Codigos ='] + crSigCdCli.TabD2s + ['], [crTmp]) < 1)
lcQuery = [Select a.Codigos ] + ;
		    [From SigCdMun a, SigCdUfs b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalMunic]) < 1)
Select LocalMunic
lcQuery = [Select UFIBGEs ] + ;
		    [From SigCdUfs ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalUF]) < 1)
Select LocalUF
			lcQuery = [Select RClis From SigCdCli Where IClis = '] + Padr(loObj.getCdContas.Value, 10) + [']
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
Select crSigCdGcr
	Select crSigCdCli
			Delete In crSigCdCli
ThisForm.poDataMgr.pfSqlTabela(1).pcStrquery = ('Select grupos,dtalts,iclis,rclis,rgs,situas,cpfs,ultcomps,usualts,inativas,ddds,tel1s From SigCdCli Where Grupos = "'+lcGru+'" and DtAlts BetWeen ?ldDtI And ?ldDtF')
ThisForm.poDataMgr.pfSqlTabela(1).pcStrquery = ('Select * From SigCdCli Where Grupos = "'+lcGru+'" and DtAlts BetWeen ?ldDtI And ?ldDtF')
Update crSigCdCli Set DtAlts= Ctod("") Where IsNull(DtAlts)
Update crSigCdCli Set ultcomps= Ctod("") Where IsNull(ultcomps)
				Select crSigCdPam
						Select crSigCdGcr
							Select crChkCli
								Select crSigCdGcr
						Select crSigCdGcr
		.poDataMgr.pfSqlTabela(1).pcStrquery = ('Select grupos,dtalts,iclis,rclis,rgs,situas,cpfs,ultcomps,usualts,Inativas,ddds,tel1s From SigCdCli Where Grupos = "'+lcGru+'" and DtAlts BetWeen ?ldDtI And ?ldDtF')
		.poDataMgr.pfSqlTabela(1).pcStrquery = ('Select * From SigCdCli Where Grupos = "'+lcGru+'" and DtAlts BetWeen ?ldDtI And ?ldDtF')
		Select crSigCdCli
			Select crSigCdCli
			Select crProcurar
				If Not Seek(lcChv, 'crSigCdCli', 'IClis')
					m.lcSQL1 = 'Select grupos,dtalts,iclis,rclis,rgs,situas,cpfs,ultcomps,usualts,inativas,ddds,tel1s From SigCdCli Where Iclis = "' + lcChv + '"'
						m.lnErro1 = .poDataMgr.SQLExecute(m.lcSQL1, 'crTmpCli')
						Select crTmpCli
					 	Insert Into crSigCdCli From MemVar
		Select crSigCdCli
		Update crSigCdCli Set DtAlts= Ctod("") Where IsNull(DtAlts)
		Update crSigCdCli Set ultcomps= Ctod("") Where IsNull(ultcomps)
		Select crSigCdCli
		.Pagina.Dados.cntConta.Visible = .f. && coloca visible como falso devido o cursor crSigCdCli nao ter todos os campos que estao em controlsource na pagina dados...
	If Not .Delete('crSigCdCli')
	If (.SQLExecute('Delete From SigCdCeb Where Grucontas = ?lcGrC', '') < 1)
	If (.SQLExecute('Delete From SigCdClh  Where GruContas = ?lcGrC', '') < 1)
	If (.SQLExecute('Delete From SigClCrc Where IClis = ?lcCli', '') < 1)
	If (.SQLExecute('Delete From SigClLcr Where GruContas = ?lcGrC', '') < 1)
	If (.SQLExecute('Delete From SigCdCem Where GruContas = ?lcGrC', '') < 1)
	If (.SQLExecute('Delete From SigClLan  Where GruContas = ?lcGrC', '') < 1)
	If (.SQLExecute('Delete From SigTelLg  Where Grupos = ?lcGru And Contas = ?lcCli', '') < 1)
	If (.SQLExecute('Delete From SigClInf Where Contas    = ?lcCli', '') < 1)
	If (.SQLExecute('Delete From SigCdCe Where IClis = ?lcCli', '') < 1)
	If (.SQLExecute('Delete From SigCdCeT Where IClis = ?lcCli', '') < 1)
	If (.SQLExecute('Delete From SigClStp Where IClis = ?lcCli', '') < 1)
					lcQuery = [Select * ] + ;
							    [From SigCdCli ] + ;
					ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
	Select Caracteris from crSigClCrc where !IsEmpty(Caracteris) Into Cursor crProcCarac ReadWrite
					lcQuery = [Select * ] + ;
							    [From SigCdCli ] + ;
					ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
				lcQuery = [Select * ] + ;
						    [From SigCdCli ] + ;
				ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
					lcQuery = [Select * ] + ;
							    [From SigCdCli ] + ;
					ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
					lcQuery = [Select * ] + ;
							    [From SigCdCli ] + ;
					ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
				Select crProcCarac
				lcQuery = [Select a.* ] + ;
						    [From SigCdCli a Inner Join SigClCrc b On a.Iclis = b.Iclis ] + ;
				ThisForm.poDataMgr.SqlExecute(lcQuery, [crTmp])
	Select crTmp
	Select crTmp
		If Not Seek(lcChv, 'crProcurar', 'IClis')
		 	Insert Into crProcurar From MemVar
If (InList(This.Value, 1, 5) Or Not Eof('crSigCdCli')) && executa o requery p/ trazer todos os campos do SigCdCli, p/ nao causar erro no ControlSource do objetos da pagina DADOS...
		Select crSigCdCli
		Insert Into crSigCdCli From Memvar
		Insert Into crSigClLcr (Contas, Grupos, cIdChaves, GruContas, limcres, moedas) ;
			Select crSigCdGcr
			Select crSigCdGcr
Select crSigCdPam
Select crSigCdPaC
Select crSigCdCli
Locate For .f. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
With This.pgframeDados && incluido p/ atualizar a propriedade ControlSource...
Select crSigCdGcr
Select crSigCdCli
	Select crSigCdCli
	Insert into crSigCdCll from MemVar
	= Seek(_Empr, 'crSigCdEmp', 'CEmps')
	Select crSigCdCli
			If (ThisForm.poDataMgr.SqlExecute([Select a.RClis From SigCdCli a Where a.IClis='] + lcTmpIcli + ['], 'crTmp') < 1)
			If (ThisForm.poDataMgr.SqlExecute([Select a.RClis From SigCdCli a Where a.IClis='] + lcTmpIcli + ['], 'crTmp') < 1)
			If (ThisForm.poDataMgr.SqlExecute([Select a.Razaos From SigPrTrp a Where a.ITras='] + lcTmpIcli + ['], 'crTmp') < 1)
			If (ThisForm.poDataMgr.SqlExecute([Select a.Descricaos From SigCdTif a Where a.Codigos='] + lcTmpIcli + ['], 'crTmp') < 1)
			If (ThisForm.poDataMgr.SqlExecute([Select a.Descs From SigCdFpb a Where a.Cods='] + lcTmpIcli + ['], 'crTmp') < 1)
		Insert Into crSigCdCeb (Grupos, Iclis, cIdChaves, GruContas) ;
		Insert Into crSigCdClh (Grupos, Iclis, Datas, cIdChaves, GruContas) ;
		Select crSigCrRac
				Select crTmpCrCli
					Insert Into crTmpCrCli (Iclis, cIdChaves, Caracteris) Values (crSigCdCli.IClis, fUniqueIds(), crSigCrRac.Descrs)
			Insert Into crSigClCrc (Iclis, cIdChaves) Values (crSigCdCli.IClis, fUniqueIds())
		Select crSigCdCli
Select crTmpCrCli
	Select crTmpCrCli
	Insert Into crSigClCrc From Memvar
		Insert Into crSigClCrc (Iclis, cIdChaves) Values (crSigCdCli.IClis, fUniqueIds())
		Insert Into crSigClCrc (Iclis, cIdChaves) Values (crSigCdCli.IClis, fUniqueIds())	
	Insert Into crSigCdCe (Iclis) Values (crSigCdCli.IClis)
	= Seek(crSigCdCli.Emps, 'crSigCdEmp', 'CEmps')
Select crSigCdCeb
Locate For .f. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
Select crSigClCrc
Locate For .f. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
Select crSigCdCe
Locate For .f. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
Select crSigCdGcr
Select crSigCdCli
Locate For .f. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select Grupos, Contas, Sum(1) as TT From crSigTelLg Where Grupos = crSigCdCli.Grupos And Contas = crSigCdCli.Iclis Group by 1,2 Into cursor Totais ReadWrite 
	Select Totais
Update crSigCdCli set Senhas = ''
LOCAL lnSelect
	lnSelect = SELECT()	
	SELECT vrlimcre, molimcre, limcres from crSigCdGcr where codigos =crSigClLcr.grupos into cursor crAux
	SELECT(lnSelect)
	lcQuery = [Select * ] + ;
			    [From SigCdGcr ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalGcr]) < 1)
	Select LocalGcr
				lcQuery = [Select RClis From SigCdCli Where IClis = '] + Padr(loObj.getCdContas.Value, 10) + [']
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCTA.prg) - TRECHOS RELEVANTES PARA PASS SQL (6065 linhas total):

*-- Linhas 471 a 489:
471:             .HighlightBackColor = RGB(255, 255, 255)
472:             .HighlightForeColor = RGB(15, 41, 104)
473:             .HighlightStyle     = 2
474:             .DeleteMark         = .F.
475:             .RecordMark         = .F.
476:             .RowHeight          = 16
477:             .ScrollBars         = 2
478:             .GridLines          = 3
479:             .Visible            = .T.
480: 
481:             *-- Coluna 1: Codigo (IClis) Width=100
482:             .Column1.Width      = 100
483:             .Column1.Movable    = .F.
484:             .Column1.Resizable  = .F.
485:             .Column1.ReadOnly   = .T.
486:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
487:             .Column1.Header1.FontName  = "Tahoma"
488:             .Column1.Header1.FontSize  = 8
489:             .Column1.Header1.Alignment = 2

*-- Linhas 4329 a 4364:
4329:             ENDIF
4330: 
4331:             IF !EMPTY(loc_cGrupo)
4332:                 loc_cFiltro = "a.Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10)) + ;
4333:                     " AND a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
4334:                     " AND " + FormatarDataSQL(loc_dDtFim)
4335:                 THIS.this_oBusinessObject.BuscarComFiltro(loc_cGrupo, loc_dDtIni, loc_dDtFim)
4336:             ELSE
4337:                 loc_cFiltro = "a.DtAlts BETWEEN " + FormatarDataSQL(loc_dDtIni) + ;
4338:                     " AND " + FormatarDataSQL(loc_dDtFim)
4339:                 THIS.this_oBusinessObject.Buscar(loc_cFiltro)
4340:             ENDIF
4341: 
4342:             IF USED("cursor_4c_Dados")
4343:                 WITH loc_oPg1.grd_4c_Lista
4344:                     .RecordSource            = "cursor_4c_Dados"
4345:                     .Column1.ControlSource   = "cursor_4c_Dados.IClis"
4346:                     .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
4347:                     .Column3.ControlSource   = "cursor_4c_Dados.Cpfs"
4348:                     .Column4.ControlSource   = "cursor_4c_Dados.Ultcomps"
4349:                     .Column5.ControlSource   = "cursor_4c_Dados.DtAlts"
4350:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
4351:                     .Column2.Header1.Caption = "Nome"
4352:                     .Column3.Header1.Caption = "CPF / CNPJ"
4353:                     .Column4.Header1.Caption = CHR(218) + "lt.Compra"
4354:                     .Column5.Header1.Caption = "Alterado em"
4355:                     .Refresh()
4356:                 ENDWITH
4357:             ENDIF
4358: 
4359:         CATCH TO loException
4360:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
4361:         ENDTRY
4362:     ENDPROC
4363: 
4364:     *===========================================================================

*-- Linhas 5257 a 5298:
5257:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5258:             RETURN
5259:         ENDIF
5260:         SELECT cursor_4c_Dados
5261:         LOCAL loc_cCodigo
5262:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5263:         IF EMPTY(loc_cCodigo)
5264:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5265:             RETURN
5266:         ENDIF
5267: 
5268:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5269:             THIS.BOParaForm()
5270:             THIS.HabilitarCampos(.F.)
5271:             THIS.AlternarPagina("DADOS")
5272:             THIS.MostrarSubPagina(1)
5273:         ELSE
5274:             MsgAviso("Erro ao carregar conta selecionada.", "Visualizar")
5275:         ENDIF
5276:     ENDPROC
5277: 
5278:     PROCEDURE BtnAlterarClick()
5279:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
5280:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5281:             RETURN
5282:         ENDIF
5283:         SELECT cursor_4c_Dados
5284:         LOCAL loc_cCodigo
5285:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5286:         IF EMPTY(loc_cCodigo)
5287:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5288:             RETURN
5289:         ENDIF
5290: 
5291:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5292:             THIS.this_oBusinessObject.EditarRegistro()
5293:             THIS.BOParaForm()
5294:             THIS.HabilitarCampos(.T.)
5295:             THIS.AlternarPagina("DADOS")
5296:             THIS.MostrarSubPagina(1)
5297:         ELSE
5298:             MsgAviso("Erro ao carregar conta para edi" + CHR(231) + CHR(227) + "o.", "Alterar")

*-- Linhas 5304 a 5322:
5304:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5305:             RETURN
5306:         ENDIF
5307:         SELECT cursor_4c_Dados
5308:         LOCAL loc_cCodigo, loc_cNome, loc_lConfirma
5309:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5310:         loc_cNome   = ALLTRIM(NVL(cursor_4c_Dados.Rclis, ""))
5311:         IF EMPTY(loc_cCodigo)
5312:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5313:             RETURN
5314:         ENDIF
5315: 
5316:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da conta:" + CHR(13) + ;
5317:             loc_cNome + " [" + loc_cCodigo + "] ?", "Excluir Conta")
5318:         IF !loc_lConfirma
5319:             RETURN
5320:         ENDIF
5321: 
5322:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 5353 a 5371:
5353:                 loc_oBusca.Show()
5354:                 IF loc_oBusca.this_lSelecionou
5355:                     IF USED("cursor_4c_Busca")
5356:                         SELECT cursor_4c_Busca
5357:                         LOCAL loc_cSel
5358:                         loc_cSel = ALLTRIM(NVL(cursor_4c_Busca.IClis, ""))
5359:                         USE IN cursor_4c_Busca
5360:                         IF !EMPTY(loc_cSel) AND PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
5361:                             loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value = loc_cSel
5362:                             THIS.CarregarLista()
5363:                         ENDIF
5364:                     ENDIF
5365:                 ENDIF
5366:             ENDIF
5367:         CATCH TO loException
5368:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
5369:         ENDTRY
5370:     ENDPROC
5371: 

*-- Linhas 5435 a 5458:
5435:         ENDIF
5436:         *-- Validar grupo via lookup SigCdGrc
5437:         LOCAL loc_nRet2
5438:         loc_nRet2 = SQLEXEC(gnConnHandle, ;
5439:             "SELECT TOP 1 codigos, descrs FROM SigCdGrc WHERE codigos = " + ;
5440:             EscaparSQL(PADR(loc_cGrupo, 10)), ;
5441:             "cursor_4c_GrupoValida")
5442:         IF loc_nRet2 > 0 AND RECCOUNT("cursor_4c_GrupoValida") > 0
5443:             SELECT cursor_4c_GrupoValida
5444:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value = ALLTRIM(codigos)
5445:             USE IN cursor_4c_GrupoValida
5446:         ELSE
5447:             IF USED("cursor_4c_GrupoValida")
5448:                 USE IN cursor_4c_GrupoValida
5449:             ENDIF
5450:         ENDIF
5451:     ENDPROC
5452: 
5453:     *===========================================================================
5454:     * TxtDGrupoFiltroKeyPress - KeyPress no campo descricao do grupo filtro
5455:     *===========================================================================
5456:     PROCEDURE TxtDGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5457:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
5458:             THIS.AbrirLookupGrupoFiltro(.T.)

*-- Linhas 5492 a 5510:
5492:                 loc_oLookup.Show()
5493: 
5494:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoFiltro")
5495:                     SELECT cursor_4c_GrupoFiltro
5496:                     loc_oFiltros.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Codigos, ""))
5497:                     loc_oFiltros.txt_4c_DGrupo.Value = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Descrs, ""))
5498:                     USE IN cursor_4c_GrupoFiltro
5499:                     THIS.CarregarLista()
5500:                     loc_lResultado = .T.
5501:                 ELSE
5502:                     IF USED("cursor_4c_GrupoFiltro")
5503:                         USE IN cursor_4c_GrupoFiltro
5504:                     ENDIF
5505:                 ENDIF
5506:                 loc_oLookup.Release()
5507:                 loc_oLookup = .NULL.
5508:             ENDIF
5509: 
5510:         CATCH TO loErr

*-- Linhas 5539 a 5557:
5539:                 loc_oLookup.Show()
5540: 
5541:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoContaLkp")
5542:                     SELECT cursor_4c_GrupoContaLkp
5543:                     loc_oPg1Cnt.txt_4c_Grupos.Value = ALLTRIM(NVL(cursor_4c_GrupoContaLkp.Codigos, ""))
5544:                     USE IN cursor_4c_GrupoContaLkp
5545:                     loc_lResultado = .T.
5546:                 ELSE
5547:                     IF USED("cursor_4c_GrupoContaLkp")
5548:                         USE IN cursor_4c_GrupoContaLkp
5549:                     ENDIF
5550:                 ENDIF
5551:                 loc_oLookup.Release()
5552:                 loc_oLookup = .NULL.
5553:             ENDIF
5554: 
5555:         CATCH TO loErr
5556:             IF USED("cursor_4c_GrupoContaLkp")
5557:                 USE IN cursor_4c_GrupoContaLkp

*-- Linhas 5607 a 5625:
5607:                 loc_oLookup.Show()
5608: 
5609:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxGruLkp")
5610:                     SELECT cursor_4c_TaxGruLkp
5611:                     LOCAL loc_cGruSel
5612:                     loc_cGruSel = ALLTRIM(NVL(cursor_4c_TaxGruLkp.Codigos, ""))
5613:                     USE IN cursor_4c_TaxGruLkp
5614:                     loc_oGru.Value = loc_cGruSel
5615:                     IF VARTYPE(loc_oCd) = "O"
5616:                         loc_oCd.Value = ""
5617:                     ENDIF
5618:                     IF VARTYPE(loc_oDs) = "O"
5619:                         loc_oDs.Value = ""
5620:                     ENDIF
5621:                     loc_lResultado = .T.
5622:                 ELSE
5623:                     IF USED("cursor_4c_TaxGruLkp")
5624:                         USE IN cursor_4c_TaxGruLkp
5625:                     ENDIF

*-- Linhas 5684 a 5715:
5684:             ENDIF
5685: 
5686:             LOCAL loc_cFiltroGrupo
5687:             loc_cFiltroGrupo = "Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
5688: 
5689:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5690:                 "SigCdCli", "cursor_4c_TaxContaLkp", "IClis", loc_cValor, ;
5691:                 "Conta - " + par_cTrib + " (Grupo: " + ALLTRIM(loc_cGrupo) + ")", ;
5692:                 .F., .T., loc_cFiltroGrupo)
5693: 
5694:             IF VARTYPE(loc_oLookup) = "O"
5695:                 loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
5696:                 loc_oLookup.mAddColuna("Rclis",  "", "Nome")
5697:                 loc_oLookup.Show()
5698: 
5699:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxContaLkp")
5700:                     SELECT cursor_4c_TaxContaLkp
5701:                     loc_oCd.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.IClis, ""))
5702:                     IF VARTYPE(loc_oDs) = "O"
5703:                         loc_oDs.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.Rclis, ""))
5704:                     ENDIF
5705:                     USE IN cursor_4c_TaxContaLkp
5706:                     loc_lResultado = .T.
5707:                 ELSE
5708:                     IF USED("cursor_4c_TaxContaLkp")
5709:                         USE IN cursor_4c_TaxContaLkp
5710:                     ENDIF
5711:                 ENDIF
5712:                 loc_oLookup.Release()
5713:                 loc_oLookup = .NULL.
5714:             ENDIF
5715: 

