# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: GRUPOS, ICLIS, DOPPS, PROGRAMAS, PKCHAVES, PARAMETROS, VALUE, ETIQS, CODIGOS

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
  ControlSource = "crSigCdMpd.subns"
  ControlSource = "crSigCdMpd.agregas"
  ControlSource = "crSigCdMpd.nivels"
  ControlSource = "crSigCdMpd.Tnivels"
  ControlSource = "crSigCdMpd.Artigos"
  ControlSource = "crSigCdMpd.cArqIcones"
  ControlSource = "crSigCdMpd.imagems"
  ControlSource = "crSigCdMpd.boletos"
  ControlSource = "crSigCdMpd.menus"
  ControlSource = "crSigCdMpd.autos"
  ControlSource = "crSigCdMpd.bxautos"
  ControlSource = "crSigCdMpd.btnpags"
  ControlSource = "crSigCdMpd.BuscaEnvs"
  ControlSource = "crSigCdMpd.apontas"
  ControlSource = "crSigCdMpd.ChkDests"
  ControlSource = "crSigCdMpd.cestoqs"
  ControlSource = "crSigCdMpd.chkfases"
  ControlSource = "crSigCdMpd.seqs"
  ControlSource = "crSigCdMpd.Inibmens"
  ControlSource = "crSigCdMpd.hists"
  ControlSource = "crSigCdMpd.Menfalhas"
  ControlSource = "crSigCdMpd.btnrets"
  ControlSource = "crSigCdMpd.btnincs"
  ControlSource = "crSigCdMpd.exclsubns"
  ControlSource = "crSigCdMpd.etiqenvs"
  ControlSource = "crSigCdMpd.chkTemSubn"
  ControlSource = "crSigCdMpd.dopemphs"
  ControlSource = "crSigCdMpd.emplancs"
  ControlSource = "crSigCdMpd.bolops"
  ControlSource = "crSigCdMpd.bolcomps"
  ControlSource = "crSigCdMpd.Docus"
  ControlSource = "crSigCdMpd.EstOrigs"
  ControlSource = "crSigCdMpd.Destinos"
  ControlSource = "crSigCdMpd.EstDests"
  ControlSource = "crSigCdMpd.CRepls"
  ControlSource = "crSigCdMpd.Origems"
  ControlSource = "crSigCdMpd.Vends"
  ControlSource = "crSigCdMpd.FixGOrigs"
  ControlSource = "crSigCdMpd.FixCOrigs"
  ControlSource = "crSigCdMpd.FixGDests"
  ControlSource = "crSigCdMpd.FixCDests"
  ControlSource = "crSigCdMpd.conosubs"
  ControlSource = "crSigCdMpd.condsubs"
  ControlSource = "crSigCdMpd.BxOEsts"
  ControlSource = "crSigCdMpd.BxDEsts"
  ControlSource = "crSigCdMpd.GruOrigs"
  ControlSource = "crSigCdMpd.GruDests"
  ControlSource = "crSigCdMpd.grvends"
  ControlSource = "crSigCdMpd.ConOrigs"
  ControlSource = "crSigCdMpd.ConDests"
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = "crSigCdMpd.FixGVends"
  ControlSource = "crSigCdMpd.Senhaos"
  ControlSource = "crSigCdMpd.Senhads"
  ControlSource = "crSigCdMpd.mascos"
  ControlSource = "crSigCdMpd.mascds"
  ControlSource = "crSigCdMpd.Numeras"
  ControlSource = "crSigCdMpd.grcomps"
  ControlSource = "crSigCdMpd.etiqs"
  ControlSource = "crSigCdMpd.chkfunds"
  ControlSource = "crSigCdMpd.grodns"
  ControlSource = "crSigCdMpd.reinops"
  ControlSource = "crSigCdMpd.MatPrncDif"
  ControlSource = "crSigCdMpd.ResumoPOp"
  ControlSource = "crSigCdMpd.QtdNegs"
  ControlSource = "crSigCdMpd.seppedras"
  ControlSource = "crSigCdMpd.trfpesas"
  ControlSource = "crSigCdMpd.Pqs"
  ControlSource = "crSigCdMpd.PesoBals"
  ControlSource = "crSigCdMpd.EnvObrigs"
  ControlSource = "crSigCdMpd.mensagens"
  ControlSource = "crSigCdMpd.pagservs"
  ControlSource = "crSigCdMpd.grprods"
  ControlSource = "crSigCdMpd.compagrus"
  ControlSource = "crSigCdMpd.pesofixs"
  ControlSource = "crSigCdMpd.CHKQTDPS"
  ControlSource = "crSigCdMpd.TpPadraos"
  ControlSource = "crSigCdMpd.retalhos"
  ControlSource = "crSigCdMpd.ValObrigs"
  ControlSource = "crSigCdMpd.BxPedFins"
  ControlSource = "crSigCdMpd.PccFases"
  ControlSource = "crSigCdMpd.LimQtds"
  ControlSource = "crSigCdMpd.diflancs"
  ControlSource = "crSigCdMpd.difpesags"
  ControlSource = "crSigCdMpd.Sinals"
  ControlSource = "crSigCdMpd.Librpqs"
  ControlSource = "crSigCdMpd.agseps"
  ControlSource = "crSigCdMpd.quebras"
  ControlSource = "crSigCdMpd.CravCers"
  ControlSource = "crSigCdMpd.SolCdlbs"
  ControlSource = "crSigCdMpd.nCarQtds"
  ControlSource = "crSigCdMpd.MatPads"
  ControlSource = "crSigCdMpd.chkPesos"
  ControlSource = "crSigCdMpd.ChkMtPrs"
  ControlSource = "crSigCdMpd.chkMetal"
  ControlSource = "crSigCdMpd.dckcabec"
  ControlSource = "crSigCdMpd.dckItens"
  ControlSource = "crSigCdMpd.dckResu"
  ControlSource = "crSigCdMpd.CasQtds"
  ControlSource = "crSigCdMpd.obspads"
  ControlSource = "crSigCdMpd.obsinis"
  ControlSource = "crSigCdMpd.obsfins"
  ControlSource = "crSigCdMpd.CtrLotes"
  ControlSource = "crSigCdMpd.AcEnvs"
  ControlSource = "crSigCdMpd.envelopes"
  ControlSource = "crSigCdMpd.chkunis"
  ControlSource = "crSigCdMpd.grufins"
  ControlSource = "crSigCdMpd.chkPesoTot"
  ControlSource = "crSigCdMpd.dopcs"
  ControlSource = "crSigCdMpd.pccs"
  ControlSource = "crSigCdMpd.pesmatps"
  ControlSource = "crSigCdMpd.InibAlts"
  ControlSource = "crSigCdMpd.ChkCtDes"
  ControlSource = "crSigCdMpd.CodTgOps"
  ControlSource = "crSigCdMpd.gruccus"
  ControlSource = "crSigCdMpd.contaccus"
  ControlSource = "crSigCdMpd.chkOpLts"
  ControlSource = "crSigCdMpd.DopSemis"
  ControlSource = "crSigCdMpd.ChkSenExc"
  ControlSource = "crSigCdMpd.TpSenExc"
  ControlSource = "crSigCdMpd.dopps"
  ControlSource = "crSigCdMpd.ndopps"
  ControlSource = "crSigCdMpd.ordes"
lcQuery = [Select grupos,iclis,rclis ] + ;
		    [From SigCdCli] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crPesqSigCdCli') < 1)
Select crPesqSigCdCli
	Select crPesqSigCdCli
lcQuery = [Select grupos,iclis,rclis ] + ;
		    [From SigCdCli] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crPesqSigCdCli') < 1)
Select crPesqSigCdCli
lcQryOpp = [Select * From SigCdOpd ]
			.AddCursor('SigOpOeo','cidchaves','crSigOpOeo','cidchaves',.f.,[Select * From SigOpOeo Where Dopps = ?crSigCdMpd.Dopps Order by Dopps,dopes])
			.AddCursor('SigCdPrg','pkChaves','crSigCdPrg','programas',.f.,[Select * from SigCdPrg where Programas = ?lcProg])			
			lcQuery = [Select Codigos, Descrs ] + ;
					    [From SigCdToi ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalTOpp') < 1)
			Select LocalTOpp
		m.lcMcrSql1 = [Select ndopes,dopes From SigCdOpe ]
		ThisForm.poDatamgr.Sqlexecute(m.lcMcrSql1,'LocalOpe')
		Select ('Localope')
		Select crSigCdMpd
	Select crSigCdPrg
	Delete All
		m.lnErro1 = ThisForm.Podatamgr.SQLExecute([Select pkChaves From SigCdAcb Where Programas='] + m.lcProg + ['], 'crTmpSigCdAcb')
	Select crTmpSigCdAcb
		m.lnErro1 = ThisForm.Podatamgr.SQLExecute([Delete From SigCdAcb Where pkChaves='] + crTmpSigCdAcb.pkChaves + ['])
	Select crSigOpOeo
	Delete All
	Select crSigCdMpd
	Delete 
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdMpd'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpOeo'),1,-1)
		m.lnErro1 = Iif(.poDataMgr.UpDate('crSigCdPrg'),1,-1)
		Select ('crSIGCDICN1')
				Delete File (m.lcArqIcone1)
Select dopps,ndopps From crSigCdMpd Into Cursor Nivel
select crSigCdMpd
select crSigCdMpd
		Select LocalTOpp
Select crSigCdMpd
	Select ('crTmpIcone')
Select crSigCdMpd
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Inserir]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Alterar]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Excluir]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Listar]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Retrabalho]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Não Conforme]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Pagamento]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Alterar Cmp Agregado]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Inserir Componente]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Alterar Componente]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Excluir Componente]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Custo Encerramento]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Insert Into SigCdPrg (descricaos, parametros, programas, barraforms, barrapict,pkchaves) ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
		lcQuery = [Update SigCdPrg Set Descricaos = ']+_Desc+' [Saldo Lote]'+[', BarraForms = ']+lcBarraForm+[',BarraPict=']+crSigCdMpd.cArqIcones+[' Where Programas=']+_Prog+[' ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, '') < 1)
select crSigCdMpd
		Select crSigCdMpd
	Select crSigCdMpd
Select crSigCdMpd
	SELECT nivel
	IF not SEEK(this.value)
		m.lcMcrSql1 = ([select a.carqicones,a.marqicones,']+Space(128)+[' as ctmpicones from SIGCDICN a order by 1])
			m.lnErro1 = .poDatamgr.SQLExecute(m.lcMcrSql1,'crSIGCDICN1')
			Select ('crSIGCDICN1')
				Insert Into crSIGCDICN1 (carqicones) Values (' < Nenhum >')
	Insert Into crProg2 (descricaos,barrapict) Values (crSigCdMpd.dopps,This.Parent.getArqIcone.Value)
	If (Seek(This.Parent.getArqIcone.Value,'crSIGCDICN1','carqicones') And;
	If !seek(this.value,'Localope','dopes')
select crSigCdMpd
select crSigCdMpd
select crSigCdMpd
		select crSigCdMpd
	select crSigCdMpd
		select crSigCdMpd
	select crSigCdMpd
		select crSigCdMpd
	select crSigCdMpd
select crSigCdMpd
		select crSigCdMpd
	select crSigCdMpd
select crSigCdMpd
select crSigCdMpd
select crSigCdMpd
select crSigCdMpd
select crSigCdMpd
	If !seek(this.value,'Localope','dopes')
	Select crSigCdMpd
SELECT csSigCdMpd
SELECT crSigCdMpd

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPD.prg) - TRECHOS RELEVANTES PARA PASS SQL (5323 linhas total):

*-- Linhas 350 a 368:
350:                 .RowHeight    = 20
351:                 .HeaderHeight = 25
352:                 .ScrollBars   = 3
353:                 .DeleteMark   = .F.
354:                 .Themes       = .F.
355:                 .FontName     = "Verdana"
356:                 .FontSize     = 8
357:                 .ColumnCount  = 4
358:                 .Visible      = .T.
359:                 .RecordMark   = .F.
360:             ENDWITH
361:             THIS.CarregarLista()
362:         CATCH TO loException
363:             MostrarErro(loException, "FormMPD.ConfigurarPaginaLista")
364:         ENDTRY
365:     ENDPROC
366: 
367:     PROCEDURE CarregarLista()
368:         LOCAL loc_lSucesso

*-- Linhas 375 a 402:
375:             IF USED("cursor_4c_Dados")
376:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
377:                     .RecordSource            = "cursor_4c_Dados"
378:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
379:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
380:                     .Column1.Width           = 300
381:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
382:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
383:                     .Column2.Width           = 80
384:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
385:                     .Column3.Header1.Caption = "Ordem"
386:                     .Column3.Width           = 60
387:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
388:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
389:                     .Column4.Width           = 420
390:                 ENDWITH
391:                 loc_lSucesso = .T.
392:             ENDIF
393:             THIS.AjustarBotoesPorModo()
394:         CATCH TO loException
395:             MostrarErro(loException, "FormMPD.CarregarLista")
396:         ENDTRY
397:         RETURN loc_lSucesso
398:     ENDPROC
399: 
400:     PROCEDURE AlternarPagina(par_nPagina)
401:         TRY
402:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina

*-- Linhas 488 a 515:
488:             IF USED("cursor_4c_Dados")
489:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
490:                     .RecordSource            = "cursor_4c_Dados"
491:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
492:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
493:                     .Column1.Width           = 300
494:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
495:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
496:                     .Column2.Width           = 80
497:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
498:                     .Column3.Header1.Caption = "Ordem"
499:                     .Column3.Width           = 60
500:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
501:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
502:                     .Column4.Width           = 420
503:                 ENDWITH
504:             ENDIF
505:         CATCH TO loException
506:             MostrarErro(loException, "FormMPD.BtnBuscarClick")
507:         ENDTRY
508:     ENDPROC
509: 
510:     PROCEDURE BtnEncerrarClick()
511:         TRY
512:             THIS.Release()
513:         CATCH TO loException
514:             MostrarErro(loException, "FormMPD.BtnEncerrarClick")
515:         ENDTRY

*-- Linhas 1722 a 1769:
1722:     PROCEDURE CmdGarqiconeClick()
1723:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1724:         TRY
1725:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn " + ;
1726:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1727:                        " ORDER BY codigos"
1728:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn")
1729:             IF loc_nResult >= 0
1730:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1731:                 loc_oFrm.DefinirCursor("cursor_4c_Icn", "codigos", "descrs", CHR(205) + "cone")
1732:                 loc_oFrm.Mostrar()
1733:                 IF loc_oFrm.this_lSelecionou
1734:                     loc_oPg = THIS.pgf_4c_Paginas.Page2
1735:                     loc_oPg.txt_4c_Desc.Value = loc_oFrm.cCodigoSelecionado
1736:                 ENDIF
1737:                 IF USED("cursor_4c_Icn")
1738:                     USE IN cursor_4c_Icn
1739:                 ENDIF
1740:             ELSE
1741:                 MsgErro("Erro ao buscar " + CHR(237) + "cones.", "Erro")
1742:             ENDIF
1743:         CATCH TO loException
1744:             MostrarErro(loException, "FormMPD.CmdGarqiconeClick")
1745:         ENDTRY
1746:     ENDPROC
1747: 
1748:     PROCEDURE CmdIconeClick()
1749:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
1750:         TRY
1751:             loc_cSQL = "SELECT codigos, descrs FROM SigCdIcn " + ;
1752:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
1753:                        " ORDER BY codigos"
1754:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Icn2")
1755:             IF loc_nResult >= 0
1756:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
1757:                 loc_oFrm.DefinirCursor("cursor_4c_Icn2", "codigos", "descrs", CHR(205) + "cone Barra")
1758:                 loc_oFrm.Mostrar()
1759:                 IF loc_oFrm.this_lSelecionou
1760:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
1761:                     loc_oPg.txt_4c_ArqIcone.Value = loc_oFrm.cCodigoSelecionado
1762:                     IF !EMPTY(loc_oFrm.cCodigoSelecionado)
1763:                         loc_oPg.img_4c_ImgIcone.Picture = gc_4c_CaminhoIcones + ALLTRIM(loc_oFrm.cCodigoSelecionado)
1764:                     ENDIF
1765:                 ENDIF
1766:                 IF USED("cursor_4c_Icn2")
1767:                     USE IN cursor_4c_Icn2
1768:                 ENDIF
1769:             ELSE

*-- Linhas 2457 a 2478:
2457:             ENDWITH
2458:             * Popula ComboBox Tipo Operacao (SigCdToi)
2459:             LOCAL loc_cSqlToi, loc_nResToi, loc_cCodToi
2460:             loc_cSqlToi = "SELECT Codigos, Descrs FROM SigCdToi ORDER BY Codigos"
2461:             loc_nResToi = SQLEXEC(gnConnHandle, loc_cSqlToi, "cursor_4c_Toi")
2462:             IF loc_nResToi >= 0
2463:                 SELECT cursor_4c_Toi
2464:                 SCAN
2465:                     IF VARTYPE(cursor_4c_Toi.Codigos) = "N"
2466:                         loc_cCodToi = PADL(ALLTRIM(cursor_4c_Toi.Codigos), 2, "0")
2467:                     ELSE
2468:                         loc_cCodToi = PADL(ALLTRIM(cursor_4c_Toi.Codigos), 2, "0")
2469:                     ENDIF
2470:                     loc_oPg.cbo_4c_CmbTOpers.AddItem(loc_cCodToi + "-" + ALLTRIM(cursor_4c_Toi.Descrs))
2471:                 ENDSCAN
2472:                 IF USED("cursor_4c_Toi")
2473:                     USE IN cursor_4c_Toi
2474:                 ENDIF
2475:             ENDIF
2476:             * BINDEVENTs lookups Estoque
2477:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "KeyPress", THIS, "GrupoOrigKeyPress")
2478:             BINDEVENT(loc_oPg.txt_4c_GrupoOrig, "DblClick", THIS, "AbrirLookupGrupoOrig")

*-- Linhas 4561 a 4580:
4561:     PROCEDURE AbrirLookupNivel()
4562:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4563:         TRY
4564:             loc_cSQL = "SELECT Dopps, Ndopps FROM SigCdOpd ORDER BY Dopps"
4565:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Nivel")
4566:             IF loc_nResult >= 0
4567:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4568:                 loc_oFrm.DefinirCursor("cursor_4c_Nivel", "Dopps", "Ndopps", "SubN" + CHR(237) + "vel")
4569:                 loc_oFrm.Mostrar()
4570:                 IF loc_oFrm.this_lSelecionou
4571:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4572:                     loc_oPg.txt_4c_Nivel.Value = loc_oFrm.cCodigoSelecionado
4573:                 ENDIF
4574:                 IF USED("cursor_4c_Nivel")
4575:                     USE IN cursor_4c_Nivel
4576:                 ENDIF
4577:             ELSE
4578:                 MsgErro("Erro ao buscar n" + CHR(237) + "veis.", "Erro")
4579:             ENDIF
4580:         CATCH TO loc_oErro

*-- Linhas 4591 a 4610:
4591:     PROCEDURE AbrirLookupEmpenho()
4592:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4593:         TRY
4594:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
4595:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empenho")
4596:             IF loc_nResult >= 0
4597:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4598:                 loc_oFrm.DefinirCursor("cursor_4c_Empenho", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Empenho")
4599:                 loc_oFrm.Mostrar()
4600:                 IF loc_oFrm.this_lSelecionou
4601:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4602:                     loc_oPg.txt_4c__Empenho.Value = loc_oFrm.cCodigoSelecionado
4603:                 ENDIF
4604:                 IF USED("cursor_4c_Empenho")
4605:                     USE IN cursor_4c_Empenho
4606:                 ENDIF
4607:             ELSE
4608:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
4609:             ENDIF
4610:         CATCH TO loc_oErro

*-- Linhas 4621 a 4640:
4621:     PROCEDURE AbrirLookupEmpLanc()
4622:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4623:         TRY
4624:             loc_cSQL = "SELECT cemps, razas FROM SigCdEmp ORDER BY cemps"
4625:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpLanc")
4626:             IF loc_nResult >= 0
4627:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4628:                 loc_oFrm.DefinirCursor("cursor_4c_EmpLanc", "cemps", "razas", "Empresa")
4629:                 loc_oFrm.Mostrar()
4630:                 IF loc_oFrm.this_lSelecionou
4631:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page1
4632:                     loc_oPg.txt_4c_EmpLanc.Value = loc_oFrm.cCodigoSelecionado
4633:                 ENDIF
4634:                 IF USED("cursor_4c_EmpLanc")
4635:                     USE IN cursor_4c_EmpLanc
4636:                 ENDIF
4637:             ELSE
4638:                 MsgErro("Erro ao buscar empresas.", "Erro")
4639:             ENDIF
4640:         CATCH TO loc_oErro

*-- Linhas 4654 a 4674:
4654:     PROCEDURE AbrirLookupGrupoOrig()
4655:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4656:         TRY
4657:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4658:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4659:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoO")
4660:             IF loc_nResult >= 0
4661:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4662:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoO", "codigos", "descrs", "Grupo Orig.")
4663:                 loc_oFrm.Mostrar()
4664:                 IF loc_oFrm.this_lSelecionou
4665:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4666:                     loc_oPg.txt_4c_GrupoOrig.Value = loc_oFrm.cCodigoSelecionado
4667:                     loc_oPg.txt_4c_Dgrupoo.Value   = loc_oFrm.cDescricaoSelecionada
4668:                 ENDIF
4669:                 IF USED("cursor_4c_GrupoO")
4670:                     USE IN cursor_4c_GrupoO
4671:                 ENDIF
4672:             ELSE
4673:                 MsgErro("Erro ao buscar grupos.", "Erro")
4674:             ENDIF

*-- Linhas 4686 a 4706:
4686:     PROCEDURE AbrirLookupContaOrig()
4687:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4688:         TRY
4689:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4690:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4691:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaO")
4692:             IF loc_nResult >= 0
4693:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4694:                 loc_oFrm.DefinirCursor("cursor_4c_ContaO", "codigos", "descrs", "Conta Orig.")
4695:                 loc_oFrm.Mostrar()
4696:                 IF loc_oFrm.this_lSelecionou
4697:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4698:                     loc_oPg.txt_4c_ContaOrig.Value = loc_oFrm.cCodigoSelecionado
4699:                     loc_oPg.txt_4c_Dcontao.Value   = loc_oFrm.cDescricaoSelecionada
4700:                 ENDIF
4701:                 IF USED("cursor_4c_ContaO")
4702:                     USE IN cursor_4c_ContaO
4703:                 ENDIF
4704:             ELSE
4705:                 MsgErro("Erro ao buscar contas.", "Erro")
4706:             ENDIF

*-- Linhas 4718 a 4738:
4718:     PROCEDURE AbrirLookupGrupoDest()
4719:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4720:         TRY
4721:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4722:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4723:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoD")
4724:             IF loc_nResult >= 0
4725:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4726:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoD", "codigos", "descrs", "Grupo Dest.")
4727:                 loc_oFrm.Mostrar()
4728:                 IF loc_oFrm.this_lSelecionou
4729:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4730:                     loc_oPg.txt_4c_GrupoDest.Value = loc_oFrm.cCodigoSelecionado
4731:                     loc_oPg.txt_4c_Dgrupod.Value   = loc_oFrm.cDescricaoSelecionada
4732:                 ENDIF
4733:                 IF USED("cursor_4c_GrupoD")
4734:                     USE IN cursor_4c_GrupoD
4735:                 ENDIF
4736:             ELSE
4737:                 MsgErro("Erro ao buscar grupos.", "Erro")
4738:             ENDIF

*-- Linhas 4750 a 4770:
4750:     PROCEDURE AbrirLookupContaDest()
4751:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4752:         TRY
4753:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4754:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4755:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ContaD")
4756:             IF loc_nResult >= 0
4757:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4758:                 loc_oFrm.DefinirCursor("cursor_4c_ContaD", "codigos", "descrs", "Conta Dest.")
4759:                 loc_oFrm.Mostrar()
4760:                 IF loc_oFrm.this_lSelecionou
4761:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4762:                     loc_oPg.txt_4c_ContaDest.Value = loc_oFrm.cCodigoSelecionado
4763:                     loc_oPg.txt_4c_Dcontad.Value   = loc_oFrm.cDescricaoSelecionada
4764:                 ENDIF
4765:                 IF USED("cursor_4c_ContaD")
4766:                     USE IN cursor_4c_ContaD
4767:                 ENDIF
4768:             ELSE
4769:                 MsgErro("Erro ao buscar contas.", "Erro")
4770:             ENDIF

*-- Linhas 4782 a 4802:
4782:     PROCEDURE AbrirLookupGrupoVend()
4783:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4784:         TRY
4785:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4786:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4787:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoV")
4788:             IF loc_nResult >= 0
4789:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4790:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoV", "codigos", "descrs", "Grupo Venda")
4791:                 loc_oFrm.Mostrar()
4792:                 IF loc_oFrm.this_lSelecionou
4793:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page2
4794:                     loc_oPg.txt_4c_GrupoVend.Value = loc_oFrm.cCodigoSelecionado
4795:                     loc_oPg.txt_4c_Dgrupov.Value   = loc_oFrm.cDescricaoSelecionada
4796:                 ENDIF
4797:                 IF USED("cursor_4c_GrupoV")
4798:                     USE IN cursor_4c_GrupoV
4799:                 ENDIF
4800:             ELSE
4801:                 MsgErro("Erro ao buscar grupos.", "Erro")
4802:             ENDIF

*-- Linhas 4898 a 4918:
4898:     PROCEDURE AbrirLookupTpPadrao()
4899:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4900:         TRY
4901:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt " + ;
4902:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Cods"
4903:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpPad")
4904:             IF loc_nResult >= 0
4905:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4906:                 loc_oFrm.DefinirCursor("cursor_4c_TpPad", "Cods", "Descrs", "Tipo Padr" + CHR(227) + "o")
4907:                 loc_oFrm.Mostrar()
4908:                 IF loc_oFrm.this_lSelecionou
4909:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4910:                     loc_oPg.txt_4c_TpPadrao.Value = loc_oFrm.cCodigoSelecionado
4911:                 ENDIF
4912:                 IF USED("cursor_4c_TpPad")
4913:                     USE IN cursor_4c_TpPad
4914:                 ENDIF
4915:             ELSE
4916:                 MsgErro("Erro ao buscar tipos.", "Erro")
4917:             ENDIF
4918:         CATCH TO loc_oErro

*-- Linhas 4929 a 4949:
4929:     PROCEDURE AbrirLookupRetalho()
4930:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4931:         TRY
4932:             loc_cSQL = "SELECT Cods, Descrs FROM SigOpOpt " + ;
4933:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Cods"
4934:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Retalho")
4935:             IF loc_nResult >= 0
4936:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4937:                 loc_oFrm.DefinirCursor("cursor_4c_Retalho", "Cods", "Descrs", "Retalho")
4938:                 loc_oFrm.Mostrar()
4939:                 IF loc_oFrm.this_lSelecionou
4940:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4941:                     loc_oPg.txt_4c_Retalho.Value = loc_oFrm.cCodigoSelecionado
4942:                 ENDIF
4943:                 IF USED("cursor_4c_Retalho")
4944:                     USE IN cursor_4c_Retalho
4945:                 ENDIF
4946:             ELSE
4947:                 MsgErro("Erro ao buscar retalhos.", "Erro")
4948:             ENDIF
4949:         CATCH TO loc_oErro

*-- Linhas 4960 a 4980:
4960:     PROCEDURE AbrirLookupGrupoPcc()
4961:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4962:         TRY
4963:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
4964:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
4965:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoPcc")
4966:             IF loc_nResult >= 0
4967:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4968:                 loc_oFrm.DefinirCursor("cursor_4c_GrupoPcc", "codigos", "descrs", "Fase PCC")
4969:                 loc_oFrm.Mostrar()
4970:                 IF loc_oFrm.this_lSelecionou
4971:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
4972:                     loc_oPg.txt_4c_GrupoPcc.Value = loc_oFrm.cCodigoSelecionado
4973:                 ENDIF
4974:                 IF USED("cursor_4c_GrupoPcc")
4975:                     USE IN cursor_4c_GrupoPcc
4976:                 ENDIF
4977:             ELSE
4978:                 MsgErro("Erro ao buscar grupos.", "Erro")
4979:             ENDIF
4980:         CATCH TO loc_oErro

*-- Linhas 4991 a 5011:
4991:     PROCEDURE AbrirLookupProduto()
4992:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
4993:         TRY
4994:             loc_cSQL = "SELECT cpros, dpros FROM SigCdPro " + ;
4995:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY cpros"
4996:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")
4997:             IF loc_nResult >= 0
4998:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
4999:                 loc_oFrm.DefinirCursor("cursor_4c_Produto", "cpros", "dpros", "Material Padr" + CHR(227) + "o")
5000:                 loc_oFrm.Mostrar()
5001:                 IF loc_oFrm.this_lSelecionou
5002:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
5003:                     loc_oPg.txt_4c__produto.Value = loc_oFrm.cCodigoSelecionado
5004:                 ENDIF
5005:                 IF USED("cursor_4c_Produto")
5006:                     USE IN cursor_4c_Produto
5007:                 ENDIF
5008:             ELSE
5009:                 MsgErro("Erro ao buscar produtos.", "Erro")
5010:             ENDIF
5011:         CATCH TO loc_oErro

*-- Linhas 5025 a 5045:
5025:     PROCEDURE AbrirLookupObspads()
5026:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5027:         TRY
5028:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs " + ;
5029:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Codigos"
5030:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsPad")
5031:             IF loc_nResult >= 0
5032:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5033:                 loc_oFrm.DefinirCursor("cursor_4c_ObsPad", "Codigos", "Descrs", "Observa" + CHR(231) + CHR(227) + "o")
5034:                 loc_oFrm.Mostrar()
5035:                 IF loc_oFrm.this_lSelecionou
5036:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5037:                     loc_oPg.txt_4c_Obspads.Value = loc_oFrm.cCodigoSelecionado
5038:                 ENDIF
5039:                 IF USED("cursor_4c_ObsPad")
5040:                     USE IN cursor_4c_ObsPad
5041:                 ENDIF
5042:             ELSE
5043:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5044:             ENDIF
5045:         CATCH TO loc_oErro

*-- Linhas 5056 a 5076:
5056:     PROCEDURE AbrirLookupObsInis()
5057:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5058:         TRY
5059:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs " + ;
5060:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Codigos"
5061:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsIni")
5062:             IF loc_nResult >= 0
5063:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5064:                 loc_oFrm.DefinirCursor("cursor_4c_ObsIni", "Codigos", "Descrs", "Obs. Inicial")
5065:                 loc_oFrm.Mostrar()
5066:                 IF loc_oFrm.this_lSelecionou
5067:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5068:                     loc_oPg.txt_4c_ObsInis.Value = loc_oFrm.cCodigoSelecionado
5069:                 ENDIF
5070:                 IF USED("cursor_4c_ObsIni")
5071:                     USE IN cursor_4c_ObsIni
5072:                 ENDIF
5073:             ELSE
5074:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5075:             ENDIF
5076:         CATCH TO loc_oErro

*-- Linhas 5087 a 5107:
5087:     PROCEDURE AbrirLookupObsFins()
5088:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5089:         TRY
5090:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdObs " + ;
5091:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Codigos"
5092:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ObsFin")
5093:             IF loc_nResult >= 0
5094:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5095:                 loc_oFrm.DefinirCursor("cursor_4c_ObsFin", "Codigos", "Descrs", "Obs. Final")
5096:                 loc_oFrm.Mostrar()
5097:                 IF loc_oFrm.this_lSelecionou
5098:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5099:                     loc_oPg.txt_4c_ObsFins.Value = loc_oFrm.cCodigoSelecionado
5100:                 ENDIF
5101:                 IF USED("cursor_4c_ObsFin")
5102:                     USE IN cursor_4c_ObsFin
5103:                 ENDIF
5104:             ELSE
5105:                 MsgErro("Erro ao buscar observa" + CHR(231) + CHR(245) + "es.", "Erro")
5106:             ENDIF
5107:         CATCH TO loc_oErro

*-- Linhas 5118 a 5138:
5118:     PROCEDURE AbrirLookupGruFin()
5119:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5120:         TRY
5121:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
5122:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
5123:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruFin")
5124:             IF loc_nResult >= 0
5125:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5126:                 loc_oFrm.DefinirCursor("cursor_4c_GruFin", "codigos", "descrs", "Grupo Financeiro")
5127:                 loc_oFrm.Mostrar()
5128:                 IF loc_oFrm.this_lSelecionou
5129:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5130:                     loc_oPg.txt_4c_GruFin.Value  = loc_oFrm.cCodigoSelecionado
5131:                     loc_oPg.txt_4c_DGruFin.Value = loc_oFrm.cDescricaoSelecionada
5132:                 ENDIF
5133:                 IF USED("cursor_4c_GruFin")
5134:                     USE IN cursor_4c_GruFin
5135:                 ENDIF
5136:             ELSE
5137:                 MsgErro("Erro ao buscar grupos.", "Erro")
5138:             ENDIF

*-- Linhas 5150 a 5170:
5150:     PROCEDURE AbrirLookupOpConta()
5151:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5152:         TRY
5153:             loc_cSQL = "SELECT Dopes, Ndopes FROM SigOpOpe " + ;
5154:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY Dopes"
5155:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpConta")
5156:             IF loc_nResult >= 0
5157:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5158:                 loc_oFrm.DefinirCursor("cursor_4c_OpConta", "Dopes", "Ndopes", "Opera" + CHR(231) + CHR(227) + "o Contas")
5159:                 loc_oFrm.Mostrar()
5160:                 IF loc_oFrm.this_lSelecionou
5161:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5162:                     loc_oPg.txt_4c_OpConta.Value = loc_oFrm.cCodigoSelecionado
5163:                 ENDIF
5164:                 IF USED("cursor_4c_OpConta")
5165:                     USE IN cursor_4c_OpConta
5166:                 ENDIF
5167:             ELSE
5168:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5169:             ENDIF
5170:         CATCH TO loc_oErro

*-- Linhas 5181 a 5200:
5181:     PROCEDURE AbrirLookupTpOp()
5182:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5183:         TRY
5184:             loc_cSQL = "SELECT Codigos, Descrs FROM SigInTgo ORDER BY Codigos"
5185:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpOp")
5186:             IF loc_nResult >= 0
5187:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5188:                 loc_oFrm.DefinirCursor("cursor_4c_TpOp", "Codigos", "Descrs", "Tipo de Ordem")
5189:                 loc_oFrm.Mostrar()
5190:                 IF loc_oFrm.this_lSelecionou
5191:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5192:                     loc_oPg.txt_4c_TpOp.Value = loc_oFrm.cCodigoSelecionado
5193:                 ENDIF
5194:                 IF USED("cursor_4c_TpOp")
5195:                     USE IN cursor_4c_TpOp
5196:                 ENDIF
5197:             ELSE
5198:                 MsgErro("Erro ao buscar tipos.", "Erro")
5199:             ENDIF
5200:         CATCH TO loc_oErro

*-- Linhas 5211 a 5231:
5211:     PROCEDURE AbrirLookupGruccus()
5212:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5213:         TRY
5214:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
5215:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
5216:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Gruccus")
5217:             IF loc_nResult >= 0
5218:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5219:                 loc_oFrm.DefinirCursor("cursor_4c_Gruccus", "codigos", "descrs", "Grupo C.C.")
5220:                 loc_oFrm.Mostrar()
5221:                 IF loc_oFrm.this_lSelecionou
5222:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5223:                     loc_oPg.txt_4c__gruccus.Value  = loc_oFrm.cCodigoSelecionado
5224:                     loc_oPg.txt_4c__dgruccus.Value = loc_oFrm.cDescricaoSelecionada
5225:                 ENDIF
5226:                 IF USED("cursor_4c_Gruccus")
5227:                     USE IN cursor_4c_Gruccus
5228:                 ENDIF
5229:             ELSE
5230:                 MsgErro("Erro ao buscar grupos.", "Erro")
5231:             ENDIF

*-- Linhas 5243 a 5263:
5243:     PROCEDURE AbrirLookupContaccus()
5244:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5245:         TRY
5246:             loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr " + ;
5247:                        "WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + " ORDER BY codigos"
5248:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contaccus")
5249:             IF loc_nResult >= 0
5250:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5251:                 loc_oFrm.DefinirCursor("cursor_4c_Contaccus", "codigos", "descrs", "Conta C.C.")
5252:                 loc_oFrm.Mostrar()
5253:                 IF loc_oFrm.this_lSelecionou
5254:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5255:                     loc_oPg.txt_4c__contaccus.Value  = loc_oFrm.cCodigoSelecionado
5256:                     loc_oPg.txt_4c__dcontaccus.Value = loc_oFrm.cDescricaoSelecionada
5257:                 ENDIF
5258:                 IF USED("cursor_4c_Contaccus")
5259:                     USE IN cursor_4c_Contaccus
5260:                 ENDIF
5261:             ELSE
5262:                 MsgErro("Erro ao buscar contas.", "Erro")
5263:             ENDIF

*-- Linhas 5275 a 5294:
5275:     PROCEDURE AbrirLookupSemi()
5276:         LOCAL loc_oFrm, loc_cSQL, loc_nResult, loc_oPg
5277:         TRY
5278:             loc_cSQL = "SELECT Dopps, hists FROM SigCdOpd ORDER BY Dopps"
5279:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Semi")
5280:             IF loc_nResult >= 0
5281:                 loc_oFrm = CREATEOBJECT("FormBuscaAuxiliar")
5282:                 loc_oFrm.DefinirCursor("cursor_4c_Semi", "Dopps", "hists", "Opera" + CHR(231) + CHR(227) + "o Semiacabados")
5283:                 loc_oFrm.Mostrar()
5284:                 IF loc_oFrm.this_lSelecionou
5285:                     loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page5
5286:                     loc_oPg.txt_4c_Semi.Value = loc_oFrm.cCodigoSelecionado
5287:                 ENDIF
5288:                 IF USED("cursor_4c_Semi")
5289:                     USE IN cursor_4c_Semi
5290:                 ENDIF
5291:             ELSE
5292:                 MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es.", "Erro")
5293:             ENDIF
5294:         CATCH TO loc_oErro


### BO (C:\4c\projeto\app\classes\MPDBO.prg):
* MPDBO.prg
* BO: Movimentacoes de Producao (SigCdOpd)

DEFINE CLASS MPDBO AS BusinessBase

  * ============================================================
  * IDENTIFICACAO
  * ============================================================
  this_cDopps      = ""    && char(20) - codigo da operacao (chave de negocio)
  this_nNdopps     = 0     && numeric(3) - numero da operacao
  this_nOrdes      = 0     && numeric(3) - ordem
  this_cCidchaves  = ""    && char(20) - PK tecnica do banco

  * ============================================================
  * ABA OPERACAO
  * ============================================================
  this_nSubns      = 0     && numeric(1) - tem subnivel (1=Sim 2=Nao)
  this_cNivels     = ""    && char(20) - subnivel
  this_cTnivels    = ""    && char(15) - titulo do subnivel
  this_cArtigos    = ""    && char(1)  - artigo do subnivel
  this_cCarqIcones = ""    && char(64) - arquivo icone
  this_nImagems    = 0     && numeric(1) - usa imagem
  this_nBoletos    = 0     && numeric(1) - gera boleto
  this_nMenus      = 0     && numeric(1) - exibe no menu
  this_nAutos      = 0     && numeric(1) - lancamento automatico
  this_nBxautos    = 0     && numeric(1) - baixa automatica
  this_nBtnpags    = 0     && numeric(1) - botao pagamento
  this_nBuscaenvs  = 0     && numeric(1) - busca envio
  this_nApontas    = 0     && numeric(1) - apontamento
  this_nChkdests   = 0     && numeric(2) - checkdests
  this_nCestoqs    = 0     && numeric(1) - centraliza estoques
  this_nChkfases   = 0     && numeric(1) - check fases
  this_nSeqs       = 0     && numeric(1) - sequencia
  this_nInibmens   = 0     && numeric(1) - inibe mensagem
  this_cHists      = ""    && char(30) - historico
  this_nMenfalhas  = 0     && numeric(1) - mensagem de falhas
  this_nBtnrets    = 0     && numeric(1) - botao retrabalho
  this_nBtnincs    = 0     && numeric(1) - botao inserir componente
  this_nExclsubns  = 0     && numeric(1) - excluir subnivel
  this_nEtiqenvs   = 0     && numeric(1) - etiqueta envio
  this_nChktemsubn = 0     && numeric(1) - tem subnivel check
  this_cDopemphs   = ""    && char(20) - operacao empenho
  this_cEmplancs   = ""    && char(3)  - empresa lancamento
  this_nBolops     = 0     && numeric(1) - boleto operacao
  this_nBolcomps   = 0     && numeric(1) - boleto componente
  this_nAgregas    = 0     && numeric(1) - agrega
  this_nTipoops    = 0     && numeric(2) - tipo operacao

  * ============================================================
  * ABA ESTOQUE
  * ============================================================
  this_nDocus      = 0     && numeric(1) - documentos
  this_nEstorigs   = 0     && numeric(1) - estoque origem
  this_nDestinos   = 0     && numeric(1) - destino
  this_nEstdests   = 0     && numeric(1) - estoque destino
  this_nCrepls     = 0     && numeric(1) - crepls
  this_nOrigems    = 0     && numeric(1) - origem (1=usa)
  this_nVends      = 0     && numeric(1) - venda
  this_nFixgorigs  = 0     && bit - fixa grupo origem
  this_nFixcorigs  = 0     && bit - fixa conta origem
  this_nFixgdests  = 0     && bit - fixa grupo destino
  this_nFixcdests  = 0     && bit - fixa conta destino
  this_nConosubs   = 0     && numeric(1) - con ori sub
  this_nCondsubs   = 0     && numeric(1) - con dest sub
  this_nBxoests    = 0     && numeric(1) - baixa estoque origem
  this_nBxdests    = 0     && numeric(1) - baixa estoque destino
  this_cGruorigs   = ""    && char(10) - grupo origem
  this_cGrudests   = ""    && char(10) - grupo destino
  this_cGrvends    = ""    && char(10) - grupo venda
  this_cConorigs   = ""    && char(10) - conta origem
  this_cCondests   = ""    && char(10) - conta destino
  this_nFixgvends  = 0     && bit - fixa grupo venda
  this_nSenhaos    = 0     && numeric(1) - senha origem
  this_nSenhads    = 0     && numeric(1) - senha destino
  this_cMascos     = ""    && char(10) - mascara origem
  this_cMascds     = ""    && char(10) - mascara destino
  this_nNumeras    = 0     && numeric(1) - numeracao

  * ============================================================
  * ABA COMPONENTE
  * ============================================================
  this_nGrcomps    = 0     && numeric(1) - grade componente
  this_nEtiqs      = 0     && numeric(1) - etiqueta
  this_nChkfunds   = 0     && numeric(1) - check fundo
  this_nGrodns     = 0     && numeric(1) - grade ordem
  this_nReinops    = 0     && numeric(1) - reinoperacao
  this_nMatprncdif = 0     && numeric(1) - mat principal diferente
  this_nResumopop  = 0     && numeric(1) - resumo op
  this_nQtdnegs    = 0     && numeric(1) - quantidade negativa
  this_nSeppedras  = 0     && numeric(1) - separacao pedras (1/3/4=sim)
  this_nTrfpesas   = 0     && numeric(1) - transfere pesas
  this_cPqs        = ""    && char(1) - pqs
  this_nPesobals   = 0     && numeric(1) - peso balanca
  this_nEnvobrigs  = 0     && numeric(1) - envio obrigatorio
  this_nMensagens  = 0     && numeric(1) - mensagens
  this_nPagservs   = 0     && numeric(1) - pagamento servico
  this_nGrprods    = 0     && numeric(1) - grade produto
  this_nCompagrus  = 0     && numeric(1) - componente agrupado
  this_nPesofixs   = 0     && numeric(1) - peso fixo
  this_nChkqtdps   = 0     && numeric(1) - chk qtd pcs
  this_cTppadraos  = ""    && char(15) - tipo padrao
  this_cRetalhos   = ""    && char(15) - retalho
  this_nValobrigs  = 0     && numeric(1) - valor obrigatorio
  this_nBxpedfins  = 0     && numeric(1) - baixa ped fins
  this_cPccfases   = ""    && char(10) - pcc fases
  this_nLimqtds    = 0     && numeric(9,3) - limite quantidade
  this_nDiflancs   = 0     && numeric(4,2) - diferenca lancamentos
  this_nDifpesags  = 0     && numeric(9,3) - diferenca pesagem
  this_nSinals     = 0     && numeric(1) - sinal
  this_nLibrpqs    = 0     && numeric(1) - libera pqs
  this_nAgseps     = 0     && numeric(1) - agrupamento separacao
  this_nQuebras    = 0     && numeric(1) - quebra
  this_nCravcers   = 0     && numeric(1) - cravacao cera
  this_nSolcdlbs   = 0     && numeric(1) - sol cd libs
  this_nNcarqtds   = 0     && numeric(1) - n car qtds
  this_cMatpads    = ""    && char(14) - material padrao
  this_nChkpesos   = 0     && numeric(1) - check pesos
  this_nChkmtprs   = 0     && numeric(1) - check mat principal
  this_nChkmetal   = 0     && numeric(1) - check metal

  * ============================================================
  * ABA DOCUMENTO
  * ============================================================
  this_nDckcabec   = 0     && numeric(1) - dck cabecalho
  this_nDckitens   = 0     && numeric(1) - dck itens
  this_nDckresu    = 0     && numeric(1) - dck resumo

  * ============================================================
  * ABA DIVERSAS
  * ============================================================
  this_nCasqtds    = 0     && numeric(2) - casas decimais qtd
  this_nObspads    = 0     && numeric(3) - obs padrao
  this_nObsinis    = 0     && numeric(3) - obs iniciais
  this_nObsfins    = 0     && numeric(3) - obs finais
  this_nCtrlotes   = 0     && numeric(1) - controle lotes
  this_nAcenvs     = 0     && numeric(1) - ac envios
  this_nEnvelopes  = 0     && numeric(1) - envelopes
  this_nChkunis    = 0     && numeric(1) - check unidade
  this_cGrufins    = ""    && char(10) - grupo financeiro
  this_nChkpesotot = 0     && numeric(1) - check peso total
  this_cDopcs      = ""    && char(20) - dop cs
  this_nPccs       = 0     && bit - pccs
  this_nPesmatps   = 0     && bit - peso mat principal
  this_nInibAlts   = 0     && bit - inibe alteracao
  this_nChkctdes   = 0     && numeric(1) - check ct des
  this_cCodtgops   = ""    && char(10) - cod tg ops
  this_cGruccus    = ""    && char(10) - grupo custo cus
  this_cContaccus  = ""    && char(10) - conta custo cus
  this_nChkoplts   = 0     && numeric(1) - check op lotes
  this_cDopsemis   = ""    && char(20) - dop semis
  this_nChksenexc  = 0     && numeric(1) - check senha exclusao
  this_nTpsenexc   = 0     && numeric(1) - tipo senha exclusao

  * ============================================================
  * INIT
  * ============================================================
  FUNCTION Init()
    DODEFAULT()
    this_cTabela     = "SigCdOpd"
    this_cCampoChave = "Dopps"
  ENDFUNC

  *--------------------------------------------------------------------------
  FUNCTION ObterChavePrimaria()
    RETURN THIS.this_cDopps
  ENDFUNC

  *--------------------------------------------------------------------------
  PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT Dopps, Ndopps, Ordes, hists FROM SigCdOpd"
      IF !EMPTY(ALLTRIM(par_cFiltro))
        loc_cSQL = loc_cSQL + " WHERE Dopps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
      ENDIF
      loc_cSQL = loc_cSQL + " ORDER BY Ndopps, Ordes"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
      IF loc_nResultado >= 0
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROCEDURE CarregarPorCodigo(par_cDopps)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(par_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
      IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
        THIS.this_lNovoRegistro = .F.
      ENDIF
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    IF USED(par_cAliasCursor)
      SELECT (par_cAliasCursor)
      THIS.this_cDopps        = TratarNulo(Dopps,        "C")
      THIS.this_nNdopps       = TratarNulo(Ndopps,       "N")
      THIS.this_nOrdes        = TratarNulo(Ordes,        "N")
      THIS.this_cCidchaves    = TratarNulo(Cidchaves,    "C")
      THIS.this_nSubns        = TratarNulo(subns,        "N")
      THIS.this_nAgregas      = TratarNulo(agregas,      "N")
      THIS.this_cNivels       = TratarNulo(nivels,       "C")
      THIS.this_cTnivels      = TratarNulo(Tnivels,      "C")
      THIS.this_cArtigos      = TratarNulo(Artigos,      "C")
      THIS.this_cCarqIcones   = TratarNulo(cArqIcones,   "C")
      THIS.this_nImagems      = TratarNulo(imagems,      "N")
      THIS.this_nBoletos      = TratarNulo(boletos,      "N")
      THIS.this_nMenus        = TratarNulo(menus,        "N")
      THIS.this_nAutos        = TratarNulo(autos,        "N")
      THIS.this_nBxautos      = TratarNulo(bxautos,      "N")
      THIS.this_nBtnpags      = TratarNulo(btnpags,      "N")
      THIS.this_nBuscaenvs    = TratarNulo(BuscaEnvs,    "N")
      THIS.this_nApontas      = TratarNulo(apontas,      "N")
      THIS.this_nChkdests     = TratarNulo(ChkDests,     "N")
      THIS.this_nCestoqs      = TratarNulo(cestoqs,      "N")
      THIS.this_nChkfases     = TratarNulo(chkfases,     "N")
      THIS.this_nSeqs         = TratarNulo(seqs,         "N")
      THIS.this_nInibmens     = TratarNulo(Inibmens,     "N")
      THIS.this_cHists        = TratarNulo(hists,        "C")
      THIS.this_nMenfalhas    = TratarNulo(Menfalhas,    "N")
      THIS.this_nBtnrets      = TratarNulo(btnrets,      "N")
      THIS.this_nBtnincs      = TratarNulo(btnincs,      "N")
      THIS.this_nExclsubns    = TratarNulo(exclsubns,    "N")
      THIS.this_nEtiqenvs     = TratarNulo(etiqenvs,     "N")
      THIS.this_nChktemsubn   = TratarNulo(chkTemSubn,   "N")
      THIS.this_cDopemphs     = TratarNulo(dopemphs,     "C")
      THIS.this_cEmplancs     = TratarNulo(emplancs,     "C")
      THIS.this_nBolops       = TratarNulo(bolops,       "N")
      THIS.this_nBolcomps     = TratarNulo(bolcomps,     "N")
      THIS.this_nTipoops      = TratarNulo(tipoops,      "N")
      THIS.this_nDocus        = TratarNulo(Docus,        "N")
      THIS.this_nEstorigs     = TratarNulo(EstOrigs,     "N")
      THIS.this_nDestinos     = TratarNulo(Destinos,     "N")
      THIS.this_nEstdests     = TratarNulo(EstDests,     "N")
      THIS.this_nCrepls       = TratarNulo(CRepls,       "N")
      THIS.this_nOrigems      = TratarNulo(Origems,      "N")
      THIS.this_nVends        = TratarNulo(Vends,        "N")
      THIS.this_nFixgorigs    = TratarNulo(FixGOrigs,    "N")
      THIS.this_nFixcorigs    = TratarNulo(FixCOrigs,    "N")
      THIS.this_nFixgdests    = TratarNulo(FixGDests,    "N")
      THIS.this_nFixcdests    = TratarNulo(FixCDests,    "N")
      THIS.this_nConosubs     = TratarNulo(conosubs,     "N")
      THIS.this_nCondsubs     = TratarNulo(condsubs,     "N")
      THIS.this_nBxoests      = TratarNulo(BxOEsts,      "N")
      THIS.this_nBxdests      = TratarNulo(BxDEsts,      "N")
      THIS.this_cGruorigs     = TratarNulo(GruOrigs,     "C")
      THIS.this_cGrudests     = TratarNulo(GruDests,     "C")
      THIS.this_cGrvends      = TratarNulo(grvends,      "C")
      THIS.this_cConorigs     = TratarNulo(ConOrigs,     "C")
      THIS.this_cCondests     = TratarNulo(ConDests,     "C")
      THIS.this_nFixgvends    = TratarNulo(FixGVends,    "N")
      THIS.this_nSenhaos      = TratarNulo(Senhaos,      "N")
      THIS.this_nSenhads      = TratarNulo(Senhads,      "N")
      THIS.this_cMascos       = TratarNulo(mascos,       "C")
      THIS.this_cMascds       = TratarNulo(mascds,       "C")
      THIS.this_nNumeras      = TratarNulo(Numeras,      "N")
      THIS.this_nGrcomps      = TratarNulo(grcomps,      "N")
      THIS.this_nEtiqs        = TratarNulo(etiqs,        "N")
      THIS.this_nChkfunds     = TratarNulo(chkfunds,     "N")
      THIS.this_nGrodns       = TratarNulo(grodns,       "N")
      THIS.this_nReinops      = TratarNulo(reinops,      "N")
      THIS.this_nMatprncdif   = TratarNulo(MatPrncDif,   "N")
      THIS.this_nResumopop    = TratarNulo(ResumoPOp,    "N")
      THIS.this_nQtdnegs      = TratarNulo(QtdNegs,      "N")
      THIS.this_nSeppedras    = TratarNulo(seppedras,    "N")
      THIS.this_nTrfpesas     = TratarNulo(trfpesas,     "N")
      THIS.this_cPqs          = TratarNulo(Pqs,          "C")
      THIS.this_nPesobals     = TratarNulo(PesoBals,     "N")
      THIS.this_nEnvobrigs    = TratarNulo(EnvObrigs,    "N")
      THIS.this_nMensagens    = TratarNulo(mensagens,    "N")
      THIS.this_nPagservs     = TratarNulo(pagservs,     "N")
      THIS.this_nGrprods      = TratarNulo(grprods,      "N")
      THIS.this_nCompagrus    = TratarNulo(compagrus,    "N")
      THIS.this_nPesofixs     = TratarNulo(pesofixs,     "N")
      THIS.this_nChkqtdps     = TratarNulo(CHKQTDPS,    "N")
      THIS.this_cTppadraos    = TratarNulo(TpPadraos,    "C")
      THIS.this_cRetalhos     = TratarNulo(retalhos,     "C")
      THIS.this_nValobrigs    = TratarNulo(ValObrigs,    "N")
      THIS.this_nBxpedfins    = TratarNulo(BxPedFins,    "N")
      THIS.this_cPccfases     = TratarNulo(PccFases,     "C")
      THIS.this_nLimqtds      = TratarNulo(LimQtds,      "N")
      THIS.this_nDiflancs     = TratarNulo(diflancs,     "N")
      THIS.this_nDifpesags    = TratarNulo(difpesags,    "N")
      THIS.this_nSinals       = TratarNulo(Sinals,       "N")
      THIS.this_nLibrpqs      = TratarNulo(Librpqs,      "N")
      THIS.this_nAgseps       = TratarNulo(agseps,       "N")
      THIS.this_nQuebras      = TratarNulo(quebras,      "N")
      THIS.this_nCravcers     = TratarNulo(CravCers,     "N")
      THIS.this_nSolcdlbs     = TratarNulo(SolCdlbs,    "N")
      THIS.this_nNcarqtds     = TratarNulo(nCarQtds,    "N")
      THIS.this_cMatpads      = TratarNulo(MatPads,     "C")
      THIS.this_nChkpesos     = TratarNulo(chkPesos,    "N")
      THIS.this_nChkmtprs     = TratarNulo(ChkMtPrs,    "N")
      THIS.this_nChkmetal     = TratarNulo(chkMetal,    "N")
      THIS.this_nDckcabec     = TratarNulo(dckcabec,    "N")
      THIS.this_nDckitens     = TratarNulo(dckItens,    "N")
      THIS.this_nDckresu      = TratarNulo(dckResu,     "N")
      THIS.this_nCasqtds      = TratarNulo(CasQtds,    "N")
      THIS.this_nObspads      = TratarNulo(obspads,     "N")
      THIS.this_nObsinis      = TratarNulo(obsinis,     "N")
      THIS.this_nObsfins      = TratarNulo(obsfins,     "N")
      THIS.this_nCtrlotes     = TratarNulo(CtrLotes,    "N")
      THIS.this_nAcenvs       = TratarNulo(AcEnvs,      "N")
      THIS.this_nEnvelopes    = TratarNulo(envelopes,   "N")
      THIS.this_nChkunis      = TratarNulo(chkunis,     "N")
      THIS.this_cGrufins      = TratarNulo(grufins,     "C")
      THIS.this_nChkpesotot   = TratarNulo(chkPesoTot, "N")
      THIS.this_cDopcs        = TratarNulo(dopcs,       "C")
      THIS.this_nPccs         = TratarNulo(pccs,        "N")
      THIS.this_nPesmatps     = TratarNulo(pesmatps,    "N")
      THIS.this_nInibAlts     = TratarNulo(InibAlts,    "N")
      THIS.this_nChkctdes     = TratarNulo(ChkCtDes,   "N")
      THIS.this_cCodtgops     = TratarNulo(CodTgOps,   "C")
      THIS.this_cGruccus      = TratarNulo(gruccus,    "C")
      THIS.this_cContaccus    = TratarNulo(contaccus,  "C")
      THIS.this_nChkoplts     = TratarNulo(chkoplts,   "N")
      THIS.this_cDopsemis     = TratarNulo(dopsemis,   "C")
      THIS.this_nChksenexc    = TratarNulo(chksenexc,  "N")
      THIS.this_nTpsenexc     = TratarNulo(tpsenexc,   "N")
      loc_lSucesso = .T.
    ENDIF
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "INSERT INTO SigCdOpd (" + ;
                 "Dopps, Ndopps, Ordes, Cidchaves," + ;
                 " subns, agregas, nivels, Tnivels, Artigos, cArqIcones," + ;
                 " imagems, boletos, menus, autos, bxautos, btnpags, BuscaEnvs," + ;
                 " apontas, ChkDests, cestoqs, chkfases, seqs, Inibmens, hists," + ;
                 " Menfalhas, btnrets, btnincs, exclsubns, etiqenvs, chkTemSubn," + ;
                 " dopemphs, emplancs, bolops, bolcomps, tipoops," + ;
                 " Docus, EstOrigs, Destinos, EstDests, CRepls, Origems, Vends," + ;
                 " FixGOrigs, FixCOrigs, FixGDests, FixCDests, conosubs, condsubs," + ;
                 " BxOEsts, BxDEsts, GruOrigs, GruDests, grvends, ConOrigs, ConDests," + ;
                 " FixGVends, Senhaos, Senhads, mascos, mascds, Numeras," + ;
                 " grcomps, etiqs, chkfunds, grodns, reinops, MatPrncDif, ResumoPOp," + ;
                 " QtdNegs, seppedras, trfpesas, Pqs, PesoBals, EnvObrigs, mensagens," + ;
                 " pagservs, grprods, compagrus, pesofixs, CHKQTDPS, TpPadraos, retalhos," + ;
                 " ValObrigs, BxPedFins, PccFases, LimQtds, diflancs, difpesags, Sinals," + ;
                 " Librpqs, agseps, quebras, CravCers, SolCdlbs, nCarQtds, MatPads," + ;
                 " chkPesos, ChkMtPrs, chkMetal," + ;
                 " dckcabec, dckItens, dckResu," + ;
                 " CasQtds, obspads, obsinis, obsfins, CtrLotes, AcEnvs, envelopes," + ;
                 " chkunis, grufins, chkPesoTot, dopcs, pccs, pesmatps, InibAlts," + ;
                 " ChkCtDes, CodTgOps, gruccus, contaccus, chkoplts, dopsemis, chksenexc, tpsenexc" + ;
                 ") VALUES (" + ;
                 EscaparSQL(THIS.this_cDopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 EscaparSQL(THIS.this_cCidchaves) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 EscaparSQL(THIS.this_cNivels) + "," + ;
                 EscaparSQL(THIS.this_cTnivels) + "," + ;
                 EscaparSQL(THIS.this_cArtigos) + "," + ;
                 EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 EscaparSQL(THIS.this_cHists) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 EscaparSQL(THIS.this_cGrudests) + "," + ;
                 EscaparSQL(THIS.this_cGrvends) + "," + ;
                 EscaparSQL(THIS.this_cConorigs) + "," + ;
                 EscaparSQL(THIS.this_cCondests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 EscaparSQL(THIS.this_cMascos) + "," + ;
                 EscaparSQL(THIS.this_cMascds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 EscaparSQL(THIS.this_cPqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 EscaparSQL(THIS.this_cPccfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 EscaparSQL(THIS.this_cMatpads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 EscaparSQL(THIS.this_cGrufins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 EscaparSQL(THIS.this_cDopcs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 EscaparSQL(THIS.this_cGruccus) + "," + ;
                 EscaparSQL(THIS.this_cContaccus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 ")"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "UPDATE SigCdOpd SET" + ;
                 " Ndopps = " + FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 " Ordes = " + FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 " subns = " + FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 " agregas = " + FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                 " Tnivels = " + EscaparSQL(THIS.this_cTnivels) + "," + ;
                 " Artigos = " + EscaparSQL(THIS.this_cArtigos) + "," + ;
                 " cArqIcones = " + EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 " imagems = " + FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 " boletos = " + FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 " menus = " + FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 " autos = " + FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 " bxautos = " + FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 " btnpags = " + FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 " BuscaEnvs = " + FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 " apontas = " + FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 " ChkDests = " + FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 " cestoqs = " + FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 " chkfases = " + FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 " seqs = " + FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 " Inibmens = " + FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 " hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                 " Menfalhas = " + FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 " btnrets = " + FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 " btnincs = " + FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 " exclsubns = " + FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 " etiqenvs = " + FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 " chkTemSubn = " + FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 " dopemphs = " + EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 " emplancs = " + EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 " bolops = " + FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 " bolcomps = " + FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 " tipoops = " + FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 " Docus = " + FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 " EstOrigs = " + FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 " Destinos = " + FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 " EstDests = " + FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 " CRepls = " + FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 " Origems = " + FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 " Vends = " + FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 " FixGOrigs = " + FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 " FixCOrigs = " + FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 " FixGDests = " + FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 " FixCDests = " + FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 " conosubs = " + FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 " condsubs = " + FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 " BxOEsts = " + FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 " BxDEsts = " + FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 " GruOrigs = " + EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 " GruDests = " + EscaparSQL(THIS.this_cGrudests) + "," + ;
                 " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                 " ConOrigs = " + EscaparSQL(THIS.this_cConorigs) + "," + ;
                 " ConDests = " + EscaparSQL(THIS.this_cCondests) + "," + ;
                 " FixGVends = " + FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 " Senhaos = " + FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 " Senhads = " + FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 " mascos = " + EscaparSQL(THIS.this_cMascos) + "," + ;
                 " mascds = " + EscaparSQL(THIS.this_cMascds) + "," + ;
                 " Numeras = " + FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 " grcomps = " + FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 " etiqs = " + FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 " chkfunds = " + FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 " grodns = " + FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 " reinops = " + FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 " MatPrncDif = " + FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 " ResumoPOp = " + FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 " QtdNegs = " + FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 " seppedras = " + FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 " trfpesas = " + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 " Pqs = " + EscaparSQL(THIS.this_cPqs) + "," + ;
                 " PesoBals = " + FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 " EnvObrigs = " + FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 " mensagens = " + FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 " pagservs = " + FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 " grprods = " + FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 " compagrus = " + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 " pesofixs = " + FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 " CHKQTDPS = " + FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 " TpPadraos = " + EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 " retalhos = " + EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 " ValObrigs = " + FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 " BxPedFins = " + FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 " PccFases = " + EscaparSQL(THIS.this_cPccfases) + "," + ;
                 " LimQtds = " + FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 " diflancs = " + FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 " difpesags = " + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 " Sinals = " + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 " Librpqs = " + FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 " agseps = " + FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 " quebras = " + FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 " CravCers = " + FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 " SolCdlbs = " + FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 " nCarQtds = " + FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 " MatPads = " + EscaparSQL(THIS.this_cMatpads) + "," + ;
                 " chkPesos = " + FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 " ChkMtPrs = " + FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 " chkMetal = " + FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 " dckcabec = " + FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 " dckItens = " + FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 " dckResu = " + FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 " CasQtds = " + FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 " obspads = " + FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 " obsinis = " + FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 " obsfins = " + FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 " CtrLotes = " + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 " AcEnvs = " + FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 " envelopes = " + FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 " chkunis = " + FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 " grufins = " + EscaparSQL(THIS.this_cGrufins) + "," + ;
                 " chkPesoTot = " + FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 " dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                 " pccs = " + FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 " pesmatps = " + FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 " InibAlts = " + FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 " ChkCtDes = " + FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 " CodTgOps = " + EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 " gruccus = " + EscaparSQL(THIS.this_cGruccus) + "," + ;
                 " contaccus = " + EscaparSQL(THIS.this_cContaccus) + "," + ;
                 " chkoplts = " + FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 " dopsemis = " + EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 " chksenexc = " + FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 " tpsenexc = " + FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 " WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "DELETE FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

ENDDEFINE

