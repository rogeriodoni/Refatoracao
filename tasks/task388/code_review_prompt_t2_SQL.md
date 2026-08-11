# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCTA.prg) - TRECHOS RELEVANTES PARA PASS SQL (6072 linhas total):

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

*-- Linhas 4329 a 4365:
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
4343:                 loc_oPg1.grd_4c_Lista.ColumnCount = 3
4344:                 loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
4345:                 WITH loc_oPg1.grd_4c_Lista
4346:                     .Column1.ControlSource   = "cursor_4c_Dados.IClis"
4347:                     .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
4348:                     .Column3.ControlSource   = "cursor_4c_Dados.Cpfs"
4349:                     .Column4.ControlSource   = "cursor_4c_Dados.Ultcomps"
4350:                     .Column5.ControlSource   = "cursor_4c_Dados.DtAlts"
4351:                     .Column1.Header1.Caption = "C" + CHR(243) + "digo"
4352:                     .Column2.Header1.Caption = "Nome"
4353:                     .Column3.Header1.Caption = "CPF / CNPJ"
4354:                     .Column4.Header1.Caption = CHR(218) + "lt.Compra"
4355:                     .Column5.Header1.Caption = "Alterado em"
4356:                     .Refresh()
4357:                 ENDWITH
4358:             ENDIF
4359: 
4360:         CATCH TO loException
4361:             MsgErro("Erro ao carregar lista:" + CHR(13) + loException.Message, "Erro")
4362:         ENDTRY
4363:     ENDPROC
4364: 
4365:     *===========================================================================

*-- Linhas 5258 a 5299:
5258:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5259:             RETURN
5260:         ENDIF
5261:         SELECT cursor_4c_Dados
5262:         LOCAL loc_cCodigo
5263:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5264:         IF EMPTY(loc_cCodigo)
5265:             MsgAviso("Selecione um registro para visualizar.", "Visualizar")
5266:             RETURN
5267:         ENDIF
5268: 
5269:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5270:             THIS.BOParaForm()
5271:             THIS.HabilitarCampos(.F.)
5272:             THIS.AlternarPagina("DADOS")
5273:             THIS.MostrarSubPagina(1)
5274:         ELSE
5275:             MsgAviso("Erro ao carregar conta selecionada.", "Visualizar")
5276:         ENDIF
5277:     ENDPROC
5278: 
5279:     PROCEDURE BtnAlterarClick()
5280:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
5281:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5282:             RETURN
5283:         ENDIF
5284:         SELECT cursor_4c_Dados
5285:         LOCAL loc_cCodigo
5286:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5287:         IF EMPTY(loc_cCodigo)
5288:             MsgAviso("Selecione um registro para alterar.", "Alterar")
5289:             RETURN
5290:         ENDIF
5291: 
5292:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
5293:             THIS.this_oBusinessObject.EditarRegistro()
5294:             THIS.BOParaForm()
5295:             THIS.HabilitarCampos(.T.)
5296:             THIS.AlternarPagina("DADOS")
5297:             THIS.MostrarSubPagina(1)
5298:         ELSE
5299:             MsgAviso("Erro ao carregar conta para edi" + CHR(231) + CHR(227) + "o.", "Alterar")

*-- Linhas 5305 a 5323:
5305:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5306:             RETURN
5307:         ENDIF
5308:         SELECT cursor_4c_Dados
5309:         LOCAL loc_cCodigo, loc_cNome, loc_lConfirma
5310:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.IClis, ""))
5311:         loc_cNome   = ALLTRIM(NVL(cursor_4c_Dados.Rclis, ""))
5312:         IF EMPTY(loc_cCodigo)
5313:             MsgAviso("Selecione um registro para excluir.", "Excluir")
5314:             RETURN
5315:         ENDIF
5316: 
5317:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da conta:" + CHR(13) + ;
5318:             loc_cNome + " [" + loc_cCodigo + "] ?", "Excluir Conta")
5319:         IF !loc_lConfirma
5320:             RETURN
5321:         ENDIF
5322: 
5323:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)

*-- Linhas 5354 a 5372:
5354:                 loc_oBusca.Show()
5355:                 IF loc_oBusca.this_lSelecionou
5356:                     IF USED("cursor_4c_Busca")
5357:                         SELECT cursor_4c_Busca
5358:                         LOCAL loc_cSel
5359:                         loc_cSel = ALLTRIM(NVL(cursor_4c_Busca.IClis, ""))
5360:                         USE IN cursor_4c_Busca
5361:                         IF !EMPTY(loc_cSel) AND PEMSTATUS(loc_oPg1.cnt_4c_Filtros, "txt_4c_Grupo", 5)
5362:                             loc_oPg1.cnt_4c_Filtros.txt_4c_Grupo.Value = loc_cSel
5363:                             THIS.CarregarLista()
5364:                         ENDIF
5365:                     ENDIF
5366:                 ENDIF
5367:             ENDIF
5368:         CATCH TO loException
5369:             MsgErro("Erro na busca:" + CHR(13) + loException.Message, "Erro")
5370:         ENDTRY
5371:     ENDPROC
5372: 

*-- Linhas 5436 a 5459:
5436:         ENDIF
5437:         *-- Validar grupo via lookup SigCdGrc
5438:         LOCAL loc_nRet2
5439:         loc_nRet2 = SQLEXEC(gnConnHandle, ;
5440:             "SELECT TOP 1 codigos, descrs FROM SigCdGrc WHERE codigos = " + ;
5441:             EscaparSQL(PADR(loc_cGrupo, 10)), ;
5442:             "cursor_4c_GrupoValida")
5443:         IF loc_nRet2 > 0 AND RECCOUNT("cursor_4c_GrupoValida") > 0
5444:             SELECT cursor_4c_GrupoValida
5445:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Pg1.txt_4c_Grupos.Value = ALLTRIM(codigos)
5446:             USE IN cursor_4c_GrupoValida
5447:         ELSE
5448:             IF USED("cursor_4c_GrupoValida")
5449:                 USE IN cursor_4c_GrupoValida
5450:             ENDIF
5451:         ENDIF
5452:     ENDPROC
5453: 
5454:     *===========================================================================
5455:     * TxtDGrupoFiltroKeyPress - KeyPress no campo descricao do grupo filtro
5456:     *===========================================================================
5457:     PROCEDURE TxtDGrupoFiltroKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5458:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
5459:             THIS.AbrirLookupGrupoFiltro(.T.)

*-- Linhas 5493 a 5511:
5493:                 loc_oLookup.Show()
5494: 
5495:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoFiltro")
5496:                     SELECT cursor_4c_GrupoFiltro
5497:                     loc_oFiltros.txt_4c_Grupo.Value  = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Codigos, ""))
5498:                     loc_oFiltros.txt_4c_DGrupo.Value = ALLTRIM(NVL(cursor_4c_GrupoFiltro.Descrs, ""))
5499:                     USE IN cursor_4c_GrupoFiltro
5500:                     THIS.CarregarLista()
5501:                     loc_lResultado = .T.
5502:                 ELSE
5503:                     IF USED("cursor_4c_GrupoFiltro")
5504:                         USE IN cursor_4c_GrupoFiltro
5505:                     ENDIF
5506:                 ENDIF
5507:                 loc_oLookup.Release()
5508:                 loc_oLookup = .NULL.
5509:             ENDIF
5510: 
5511:         CATCH TO loErr

*-- Linhas 5540 a 5558:
5540:                 loc_oLookup.Show()
5541: 
5542:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoContaLkp")
5543:                     SELECT cursor_4c_GrupoContaLkp
5544:                     loc_oPg1Cnt.txt_4c_Grupos.Value = ALLTRIM(NVL(cursor_4c_GrupoContaLkp.Codigos, ""))
5545:                     USE IN cursor_4c_GrupoContaLkp
5546:                     loc_lResultado = .T.
5547:                 ELSE
5548:                     IF USED("cursor_4c_GrupoContaLkp")
5549:                         USE IN cursor_4c_GrupoContaLkp
5550:                     ENDIF
5551:                 ENDIF
5552:                 loc_oLookup.Release()
5553:                 loc_oLookup = .NULL.
5554:             ENDIF
5555: 
5556:         CATCH TO loErr
5557:             IF USED("cursor_4c_GrupoContaLkp")
5558:                 USE IN cursor_4c_GrupoContaLkp

*-- Linhas 5608 a 5626:
5608:                 loc_oLookup.Show()
5609: 
5610:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxGruLkp")
5611:                     SELECT cursor_4c_TaxGruLkp
5612:                     LOCAL loc_cGruSel
5613:                     loc_cGruSel = ALLTRIM(NVL(cursor_4c_TaxGruLkp.Codigos, ""))
5614:                     USE IN cursor_4c_TaxGruLkp
5615:                     loc_oGru.Value = loc_cGruSel
5616:                     IF VARTYPE(loc_oCd) = "O"
5617:                         loc_oCd.Value = ""
5618:                     ENDIF
5619:                     IF VARTYPE(loc_oDs) = "O"
5620:                         loc_oDs.Value = ""
5621:                     ENDIF
5622:                     loc_lResultado = .T.
5623:                 ELSE
5624:                     IF USED("cursor_4c_TaxGruLkp")
5625:                         USE IN cursor_4c_TaxGruLkp
5626:                     ENDIF

*-- Linhas 5685 a 5716:
5685:             ENDIF
5686: 
5687:             LOCAL loc_cFiltroGrupo
5688:             loc_cFiltroGrupo = "Grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
5689: 
5690:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
5691:                 "SigCdCli", "cursor_4c_TaxContaLkp", "IClis", loc_cValor, ;
5692:                 "Conta - " + par_cTrib + " (Grupo: " + ALLTRIM(loc_cGrupo) + ")", ;
5693:                 .F., .T., loc_cFiltroGrupo)
5694: 
5695:             IF VARTYPE(loc_oLookup) = "O"
5696:                 loc_oLookup.mAddColuna("IClis",  "", "C" + CHR(243) + "digo")
5697:                 loc_oLookup.mAddColuna("Rclis",  "", "Nome")
5698:                 loc_oLookup.Show()
5699: 
5700:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_TaxContaLkp")
5701:                     SELECT cursor_4c_TaxContaLkp
5702:                     loc_oCd.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.IClis, ""))
5703:                     IF VARTYPE(loc_oDs) = "O"
5704:                         loc_oDs.Value = ALLTRIM(NVL(cursor_4c_TaxContaLkp.Rclis, ""))
5705:                     ENDIF
5706:                     USE IN cursor_4c_TaxContaLkp
5707:                     loc_lResultado = .T.
5708:                 ELSE
5709:                     IF USED("cursor_4c_TaxContaLkp")
5710:                         USE IN cursor_4c_TaxContaLkp
5711:                     ENDIF
5712:                 ENDIF
5713:                 loc_oLookup.Release()
5714:                 loc_oLookup = .NULL.
5715:             ENDIF
5716: 

