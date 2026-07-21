# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [GRID-SQL] Campo 'Descricaos' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Programas' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Marcas' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Parametros' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, TEXTO, EXPANDI, I, CCAMPOS, GRUPOS, CTIPOS, LNERRO1, PKCHAVES, USUARIOS, 0, PARAMETROS, C, MARCAS, PROGRAMAS, NSTATUS

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
  DeleteMark = .F.
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = "TmpBarra.Descricaos"
  Column2.ControlSource = "TmpBarra.SelBarras"
  ControlSource = "TmpBarra.Descricaos"
  ControlSource = "TmpBarra.SelBarras"
  ControlSource = "crsigcdgra.grupos"
  ControlSource = "crsigcdgra.ncomps"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "TmpBarra.Descricaos"
Select crOrigem
Select crDestino
	Select crDestino
	Delete From TmpBarra Where Programas + Parametros Not In (Select b.Programas + b.Parametros From crDestino b Where Not Empty(b.Grupos))
Select crDestino
	If Not Empty(m.BarraForms) And Not Seek(m.Programas + m.Parametros, 'TmpBarra', 'ProPar')
		Insert Into TmpBarra From Memvar
Select TmpBarra
PROCEDURE selectall
	oList.Selected(lnCnt) = .t.
	Select crTodossigcdprg
Select TmpOri
	Select crTodossigcdprg
			Select TmpOri
Select crAcCamp
	Select a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps, Nvl(b.nStatus,1) as nStatus, Nvl(b.Grupos,'') as Grupos, Nvl(b.Usuarios,'') as Usuarios, ;
		from crAcCamp a Left Join crTmpAcTel b On a.cCodigos = b.cCodigos And a.cCampos = b.cCampos ;
	.column2.ControlSource = [crSigAcTel.cDescTelas]
	.column3.ControlSource = [crSigAcTel.cDescCamps]
	.column4.ControlSource = [crSigAcTel.nStatus]
Select crsigcdgra
	m.lnErro1 = Iif(ThisForm.poDatamgr.Update('crsigcdgra'),1,-1)
	m.lnErro1 = ThisForm.poDataMgr2.SQLExecute([Delete From sigcdacg Where Grupos = ?pGru])
	m.lnErro1 = ThisForm.poDataMgr2.SQLExecute([Delete From sigcdacu Where Grupos = ?pGru])
Select crCadBarra
		m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From SigCdAcB Where pkChaves = '] + crCadBarra.pkChaves + ['])
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From SigAcTel Where Grupos = ?pGru])
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdacg'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdacu'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigCdAcB'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigAcTel'),1,-1)
Select ('crsigcdgra')
Delete 
Delete From crsigcdacg
Delete From crsigcdacu
Delete From crSigCdAcB
	m.lnErro1 = Iif(ThisForm.poDataMgr.Update('crsigcdgra'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdacg'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdacu'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigCdAcB'),1,-1)
lcQryGrupo = [Select * From sigcdgra ]
lcQryUsuar = [Select * From sigcdusu ]
lcQryProgr = [Select * From sigcdprg Order By Descricaos, Programas, Parametros ]
lcQryBarra = [Select * From SigCdAcB Where Grupos = ?pGru ]
lcQryAcess = [Select * From sigcdacu Where Grupos = ?pGru ]
lcQryGrupU = [Select * From sigcdacg Where Grupos = ?pGru ]
lcQryAcTel = [Select * From SigAcTel Where Grupos = ?pGru ] && #Programador - 16/05/2014 - SRCOM - Acesso campo nas telas
		lcSQLCmd = [Select a.Descricaos, a.Programas, a.Parametros, a.BarraForms ] + ;
					 [From sigcdprg a ] + ;
		If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crTodossigcdprg') < 1)
		SELECT *, 0 as expandi,  0 as Inseriu, RECNO() as npos from crTodossigcdprg into cursor crorigem
		Select * from crSigAcTel into cursor crTmpAcTel		
		Select crsigcdusu
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.endes], [This.pgframeDados.pgframeDados1.getendereço], [Endereço],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.fpubls], [This.pgframeDados.pgframeDados1.getcodfun], [Forma de publicidade],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.nacionals], [This.pgframeDados.pgframeDados1.getnacionals], [Nacionalidade],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.estcivils], [This.pgframeDados.pgframeDados1.cmbestcivils], [Estado civil],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.conjuges], [This.pgframeDados.pgframeDados1.getconjuges], [Cônjuge],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.ultcomps], [This.pgframeDados.pgframeDados1.getultcom], [Última compra],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.codsegs], [This.pgframeDados.pgframeDados1.get_seg], [Segmento],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.profiss], [This.pgframeDados.pgframeDados1.getpro], [Profissão],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.DtVals], [This.pgframeDados.pgframeDados1.getdtvals], [Validade],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.tel1s], [This.pgframeDados.pgframeDados1.gettel1], [Telefone],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.emails], [This.pgframeDados.pgframeDados1.getemail], [E-mail],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.contato], [This.pgframeDados.pgframeDados1.get_contato], [Contato],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.CTELEMS], [This.pgframeDados.pgframeDados1.gettelem], [Telemarketing],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.codigos], [This.pgframeDados.pgframeDados1.getclacod], [Classificação],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.sexos], [This.pgframeDados.pgframeDados1.getsexo], [Sexo],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.obs], [This.pgframeDados.pgframeDados1.memofun], [Observação],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.pastas], [This.pgframeDados.pgframeDados1.getpastas], [Pasta],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.nascs], [This.pgframeDados.pgframeDados1.getdatnas], [Nascimento],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.idcontas], [This.pgframeDados.pgframeDados1.get_idconta], [ID],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.CCargs], [This.pgframeDados.pgframeDados5.get_cargo], [Cargo],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.grupovens], [This.pgframeDados.pgframeDados5.get_grupoven], [C/C - Centro de Custo],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.vinculas], [This.pgframeDados.pgframeDados5.op_vincula], [Conta Vinculada ],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.patrietqs], [This.pgframeDados.pgframeDados5.opt_patrim], [Patrimonial por Etiqueta],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCDCLI.Concilias], [This.pgframeDados.pgframeDados5.op_concilia], [Conta Conciliável],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCLCRC.Caracteris], [This.pgframeDados.pgframeDados11.getComples], [Característica Conta],0)
Insert into crAcCamp(cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps, nStatus) values ([SIGCDCLI], [Cadastro Contas], [CRSIGCLJOB.JOBS], [This.pgframeDados.pgframeDados11.grdAceMovs], [Acesso Jobs],0)
Select crsigcdgra
					Select Distinct a.usuarios;
						From crTmpUsua a;
						Where Not a.cativos='N' And Not a.Usuarios In (Select Distinct b.Usuarios From crTmpGrUsua b);
					Select crTmp
				lcSQLCmd = [Select Distinct Usuarios ] + ;
							 [From sigcdacg ] + ;
				If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crTmp') < 1)
				Select crTmp
		lcSQLCmd = [Select Distinct a.Descricaos, a.Programas, a.Parametros, a.BarraForms, ] + ;
				   [From sigcdprg a ] + ;
				   [Inner Join sigcdacu c On a.Programas + a.Parametros = c.Programas + c.Parametros ] + ;
		If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crListAce') < 1)
		Select crListAce
		lcSQLCmd = [Select Distinct a.Descricaos, a.Programas, a.Parametros, a.BarraForms, ] + ;
					[From sigcdprg a ] + ;
					Iif(Thisform.pcEscolha = [INSERIR], [], [Where Not Exists (Select b.pkChaves From sigcdacu b ] + ;
					[Select Distinct a.Descricaos, a.Programas, a.Parametros, a.BarraForms, ] + ;
					[From sigcdprg a ] + ;
					[Inner Join sigcdacu c On a.Programas + a.Parametros = c.Programas + c.Parametros ] + ;
		If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crOrigem') < 1)
		SELECT *, 0 as expandi, RECNO() as npos from crorigem into cursor crorigem readwrite
		Select crDestino
		Select crOrigem
		Select crDestino
		lcQuery = [Select 0 as Marcas, 0 as Filtro, barraforms,barrapict,descricaos,parametros,programas,max(pkchaves) as pkchaves from SigCdPrg group by barraforms,barrapict,descricaos,parametros,programas ]
		Thisform.poDatamgr.SqlExecute(lcQuery,[crSigCdPrg])
		.Acesso.grdAcesso.column1.ControlSource = [crSigCdPrg.Descricaos]
		.Acesso.grdAcesso.column2.ControlSource = [crSigCdPrg.Programas]
		.Acesso.grdAcesso.column3.ControlSource = [crSigCdPrg.Marcas]
		.Acesso.grdAcesso.column4.ControlSource = [crSigCdPrg.Parametros]
		Select crSigCdPrg
		Select crListAce
			If Seek(crListAce.fkChaves,[crSigCdPrg],[pkchaves])
		Select crSigCdPrg
			lcSQLCmd = [Select b.* ] + ;
						 [From sigcdacu a, SigCdAcB b ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crListBarra') < 1)
			Select crListBarra
				Select crListBarra
				If Not Seek(m.Programas+m.Parametros,'TmpBarra','ProPar')
					Insert Into TmpBarra From Memvar
		Select crOrigem
		Select crDestino
		lcQuery = [Select * From SigAcTel a Where ] + Iif(ThisForm.pcEscolha=='INSERIR' Or Empty(ThisForm.Grupos),[0=1],[a.Grupos = '] + Padr(ThisForm.Grupos, 10) + [' Order By cCodigos])
		If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmpAcTel') < 1)
Select crLogData
Select crsigcdgra
		Insert Into crsigcdacg From Memvar
	Select crDestino
	Select crsigcdacg
	Select crsigcdacu
	Select crSigCdAcB
	Select crListAce
	Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select crListBarra
	Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select crOrigem
	Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select crDestino	
	Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select TmpBarra
	Locate For .F. && incluido apenas p/ executar tableupdate, pois este cursor e' BUFFERMODE=3...
	Select crSigCdPrg
	Select * from crSigCdPrg Where Marcas = 1 Into Cursor csTmpCdPrg ReadWrite 
	Select csTmpCdPrg 
		Insert Into crsigcdacu From Memvar
	Select 'E' As cTipos, a.pkchaves, a.Programas, a.Parametros From crListBarra a ;
		Left Join TmpBarra b On b.Programas = a.Programas And b.Parametros = a.Parametros;
	Select 'I' As cTipos, Space(20) As pkChaves, a.Programas, a.Parametros from TmpBarra a ;
		Where a.SelBarras And Not Exists (Select b.Programas From crListBarra b Where b.SelBarras And b.Programas = a.Programas And b.Parametros = a.Parametros) ; 
	Select crCadBarra
		If Seek(crCadBarra.Programas + crCadBarra.Parametros, 'TmpBarra', 'ProPar')
			Select TmpBarra
			Insert Into crSigCdAcB From Memvar
	Select crSigAcTel
	Delete For nStatus = 1
Select crsigcdgra
Select crsigcdgra
lcSQLCmd = [Select a.Usuarios, a.Parametros, a.Programas ] + ;
			 [From sigcdacu a ] + ;
		  [(Select b.Programas + b.Parametros ] + ;
		     [From sigcdacu b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'Tmpsigcdacus') < 1)
lcSQLCmd = [Select a.* ] + ;
			 [From SigCdAcB a ] + ;
		  [(Select b.Programas + b.Parametros ] + ;
		  	 [From SigCdAcB b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'TmpSigCdAcB') < 1)
Select Tmpsigcdacus
	Insert Into crsigcdacu (Grupos, Parametros, Programas, Usuarios, pkChaves) ;
	Select crLogData
		Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
Select TmpSigCdAcB
	Insert Into crSigCdAcB (Grupos, Parametros, Programas, Usuarios, Descricaos, ;
lcQuery = [Select * From SigAcTel Where Grupos = '] + lcGruOri + [' ]
Thisform.poDatamgr.SqlExecute(lcQuery,'TmpCopAcTel')
Select TmpCopAcTel
	Insert into crSigAcTel from Memvar
	If Not ThisForm.poDataMgr2.Update('crsigcdacu')
	If Not ThisForm.poDataMgr2.Update('crSigCdAcB')
	If Not ThisForm.poDataMgr2.Update('crSigAcTel')
	Select crLogData
Select TmpBarra
Select crSigCdPrg
	Select crSigCdPrg
	Select pkchaves From crSigCdPrg Where Alltrim(lcFiltro) $ Upper(descricaos) Into Cursor csFiltra ReadWrite 
	Select csFiltra
		If .Usuario.Selected(nCnt)
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
					Delete 
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 
		If .UsuarioSl.Selected(nCnt)
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
					Delete 
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 
	Select crLogData
		Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
			Delete 
	ThisForm.SelectAll(This)
ThisForm.poDataMgr.SqlExecute([Select cAtivos From sigcdusu Where Usuarios = '] + Alltrim(This.List(This.ListIndex)) + ['], [crTmpUsu])
ThisForm.poDataMgr.SqlExecute([Select cAtivos From sigcdusu Where Usuarios = '] + Alltrim(This.List(This.ListIndex)) + ['], [crTmpUsu])
	Select crLogData
		Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
			Delete 
	ThisForm.SelectAll(This)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formacg.prg) - TRECHOS RELEVANTES PARA PASS SQL (1739 linhas total):

*-- Linhas 348 a 366:
348:             .ColumnCount     = 2
349:             .RecordSourceType = 1
350:             .ReadOnly        = .T.
351:             .DeleteMark      = .F.
352:             .RecordMark      = .F.
353:             .ScrollBars      = 3
354:             .GridLines       = 3
355:             .AllowHeaderSizing = .T.
356:             .FontName        = "Tahoma"
357:             .FontSize        = 8
358:             .GridLineColor   = RGB(238,238,238)
359:             .Visible         = .T.
360:             .Column1.Width   = 120
361:             .Column1.Header1.Caption = ""
362:             .Column2.Width   = 500
363:             .Column2.Header1.Caption = ""
364:         ENDWITH
365: 
366:         THIS.TornarControlesVisiveis(loc_oP1)

*-- Linhas 576 a 594:
576:             .Left          = 80
577:             .Width         = 200
578:             .Height        = 350
579:             .MultiSelect   = .T.
580:             .RowSourceType = 0
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .Visible       = .T.
584:         ENDWITH
585:         BINDEVENT(loc_oAba.lbx_4c_Disponiveis, "Click", THIS, "LbxDisponiveisClick")
586: 
587:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
588:         WITH loc_oAba.lbl_4c_Label3
589:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
590:             .Top       = 382
591:             .Left      = 80
592:             .Width     = 60
593:             .Height    = 15
594:             .AutoSize  = .F.

*-- Linhas 698 a 716:
698:             .Left          = 356
699:             .Width         = 200
700:             .Height        = 350
701:             .MultiSelect   = .T.
702:             .RowSourceType = 0
703:             .FontName      = "Tahoma"
704:             .FontSize      = 8
705:             .Visible       = .T.
706:         ENDWITH
707:         BINDEVENT(loc_oAba.lbx_4c_Selecionados, "Click", THIS, "LbxSelecionadosClick")
708: 
709:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
710:         WITH loc_oAba.lbl_4c_Label5
711:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
712:             .Top       = 382
713:             .Left      = 356
714:             .Width     = 60
715:             .Height    = 15
716:             .AutoSize  = .F.

*-- Linhas 780 a 798:
780:             .ColumnCount      = 4
781:             .RecordSourceType = 1
782:             .ReadOnly         = .F.
783:             .DeleteMark       = .F.
784:             .RecordMark       = .F.
785:             .ScrollBars       = 3
786:             .GridLines        = 3
787:             .AllowHeaderSizing = .T.
788:             .FontName         = "Tahoma"
789:             .FontSize         = 8
790:             .GridLineColor    = RGB(238,238,238)
791:             .Visible          = .T.
792:             .Column1.Width    = 380
793:             .Column1.ReadOnly = .T.
794:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
795:             .Column2.Width    = 120
796:             .Column2.ReadOnly = .T.
797:             .Column2.Header1.Caption = "Programa"
798:             .Column3.Width    = 65

*-- Linhas 833 a 851:
833:             .ColumnCount      = 2
834:             .RecordSourceType = 1
835:             .ReadOnly         = .F.
836:             .DeleteMark       = .F.
837:             .RecordMark       = .F.
838:             .ScrollBars       = 3
839:             .GridLines        = 3
840:             .AllowHeaderSizing = .T.
841:             .FontName         = "Tahoma"
842:             .FontSize         = 8
843:             .GridLineColor    = RGB(238,238,238)
844:             .Visible          = .T.
845:             .Column1.Width    = 550
846:             .Column1.ReadOnly = .T.
847:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
848:             .Column2.Width    = 80
849:             .Column2.ReadOnly = .F.
850:             .Column2.Sparse   = .F.
851:             .Column2.Header1.Caption = ""

*-- Linhas 881 a 899:
881:             .ColumnCount       = 3
882:             .RecordSourceType  = 1
883:             .ReadOnly          = .F.
884:             .DeleteMark        = .F.
885:             .RecordMark        = .F.
886:             .ScrollBars        = 2
887:             .GridLines         = 3
888:             .AllowHeaderSizing = .F.
889:             .AllowRowSizing    = .F.
890:             .FontName          = "Tahoma"
891:             .FontSize          = 8
892:             .GridLineColor     = RGB(238,238,238)
893:             .RowHeight         = 16
894:             .Visible           = .T.
895:             .Column1.Width     = 360
896:             .Column1.ReadOnly  = .T.
897:             .Column1.Header1.Caption = "Tela"
898:             .Column2.Width     = 360
899:             .Column2.ReadOnly  = .T.

*-- Linhas 933 a 952:
933:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
934:                 loc_oGrid.ColumnCount = 2
935:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
936:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
937:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
938:                 loc_oGrid.Column1.Header1.Caption = "Grupo"
939:                 loc_oGrid.Column2.Header1.Caption = "Nome"
940:                 loc_oGrid.Column1.Width = 120
941:                 loc_oGrid.Column2.Width = 500
942:                 loc_oGrid.FontName = "Tahoma"
943:                 loc_oGrid.FontSize = 8
944:                 loc_oGrid.Refresh()
945:                 loc_lSucesso = .T.
946:             ENDIF
947:         CATCH TO loc_oErro
948:             MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
949:         ENDTRY
950:         RETURN loc_lSucesso
951:     ENDPROC
952: 

*-- Linhas 989 a 1050:
989: 
990:             *-- Carregar todos os usuarios do sistema
991:             IF THIS.this_oBusinessObject.BuscarTodosUsuarios() AND USED("cursor_4c_TodosUsuarios")
992:                 SELECT cursor_4c_TodosUsuarios
993:                 GO TOP
994:                 SCAN
995:                     loc_cUsu = ALLTRIM(Usuarios)
996:                     loc_lNaGrupo = .F.
997:                     IF !loc_lNovoGrupo AND USED("cursor_4c_UsuariosGrupo")
998:                         SELECT cursor_4c_UsuariosGrupo
999:                         LOCATE FOR ALLTRIM(Usuarios) == m.loc_cUsu
1000:                         IF !EOF()
1001:                             loc_lNaGrupo = .T.
1002:                         ENDIF
1003:                     ENDIF
1004:                     SELECT cursor_4c_TodosUsuarios
1005:                     IF loc_lNaGrupo
1006:                         loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
1007:                     ELSE
1008:                         loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
1009:                     ENDIF
1010:                 ENDSCAN
1011:             ENDIF
1012:         CATCH TO loc_oErro
1013:             MsgErro("Erro ao carregar usu" + CHR(225) + "rios: " + loc_oErro.Message, "Erro")
1014:         ENDTRY
1015:     ENDPROC
1016: 
1017:     *==========================================================================
1018:     * CarregarProgramasAba - Vincula cursor_4c_Programas ao grd_4c_Programas
1019:     *==========================================================================
1020:     PROCEDURE CarregarProgramasAba(par_cGrupos)
1021:         LOCAL loc_oGrid
1022:         TRY
1023:             IF THIS.this_oBusinessObject.CarregarProgramas(par_cGrupos)
1024:                 THIS.this_cFiltroPrograma = ""
1025:                 IF USED("cursor_4c_Programas")
1026:                     SELECT cursor_4c_Programas
1027:                     SET FILTER TO
1028:                 ENDIF
1029:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas
1030:                 loc_oGrid.ColumnCount = 4
1031:                 loc_oGrid.RecordSource = "cursor_4c_Programas"
1032:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.Descricaos"
1033:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
1034:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
1035:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
1036:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1037:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1038:                 loc_oGrid.Column3.Header1.Caption = ""
1039:                 loc_oGrid.Column4.Header1.Caption = "Parametro"
1040:                 loc_oGrid.Column1.Width = 380
1041:                 loc_oGrid.Column2.Width = 120
1042:                 loc_oGrid.Column3.Width = 65
1043:                 loc_oGrid.Column4.Width = 120
1044:                 loc_oGrid.FontName = "Tahoma"
1045:                 loc_oGrid.FontSize = 8
1046:                 loc_oGrid.Refresh()
1047:             ENDIF
1048:         CATCH TO loc_oErro
1049:             MsgErro("Erro ao carregar programas: " + loc_oErro.Message, "Erro")
1050:         ENDTRY

*-- Linhas 1060 a 1079:
1060:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra
1061:                 loc_oGrid.ColumnCount = 2
1062:                 loc_oGrid.RecordSource = "TmpBarra"
1063:                 loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
1064:                 loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
1065:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1066:                 loc_oGrid.Column2.Header1.Caption = ""
1067:                 loc_oGrid.Column1.Width = 550
1068:                 loc_oGrid.Column2.Width = 80
1069:                 loc_oGrid.FontName = "Tahoma"
1070:                 loc_oGrid.FontSize = 8
1071:                 loc_oGrid.Refresh()
1072:             ENDIF
1073:         CATCH TO loc_oErro
1074:             MsgErro("Erro ao carregar barra: " + loc_oErro.Message, "Erro")
1075:         ENDTRY
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * CarregarTelasAba - Vincula crSigAcTel ao grd_4c_Telas

*-- Linhas 1085 a 1105:
1085:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Telas
1086:                 loc_oGrid.ColumnCount = 3
1087:                 loc_oGrid.RecordSource = "crSigAcTel"
1088:                 loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
1089:                 loc_oGrid.Column2.ControlSource = "crSigAcTel.cDescCamps"
1090:                 loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
1091:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1092:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1093:                 loc_oGrid.Column3.Header1.Caption = "Status"
1094:                 loc_oGrid.Column1.Width = 360
1095:                 loc_oGrid.Column2.Width = 360
1096:                 loc_oGrid.Column3.Width = 168
1097:                 loc_oGrid.Column3.cbo_4c_CmbStatus.RowSourceType = 1
1098:                 loc_oGrid.Column3.cbo_4c_CmbStatus.RowSource = "Padr" + CHR(227) + "o," + ;
1099:                     "Invis" + CHR(237) + "vel," + ;
1100:                     "N" + CHR(227) + "o Edit" + CHR(225) + "vel," + ;
1101:                     "Obrigat" + CHR(243) + "rio"
1102:                 loc_oGrid.FontName = "Tahoma"
1103:                 loc_oGrid.FontSize = 8
1104:                 loc_oGrid.Refresh()
1105:             ENDIF

*-- Linhas 1245 a 1284:
1245:                 USE IN cursor_4c_UsrSalvar
1246:             ENDIF
1247:             SET NULL ON
1248:             CREATE CURSOR cursor_4c_UsrSalvar (Usuarios C(10))
1249:             SET NULL OFF
1250:             FOR loc_nI = 1 TO loc_oAba1.lbx_4c_Selecionados.ListCount
1251:                 loc_cUsu = ALLTRIM(loc_oAba1.lbx_4c_Selecionados.List(loc_nI))
1252:                 IF !EMPTY(loc_cUsu)
1253:                     INSERT INTO cursor_4c_UsrSalvar VALUES (m.loc_cUsu)
1254:                 ENDIF
1255:             ENDFOR
1256: 
1257:             IF !THIS.this_oBusinessObject.SalvarUsuarios(par_cGrupos, "cursor_4c_UsrSalvar")
1258:                 loc_lSucesso = .F.
1259:             ENDIF
1260:             IF USED("cursor_4c_UsrSalvar")
1261:                 USE IN cursor_4c_UsrSalvar
1262:             ENDIF
1263: 
1264:             *-- Salvar programas (limpar filtro antes)
1265:             IF USED("cursor_4c_Programas")
1266:                 SELECT cursor_4c_Programas
1267:                 SET FILTER TO
1268:                 GO TOP
1269:                 IF !THIS.this_oBusinessObject.SalvarProgramas(par_cGrupos, "cursor_4c_Programas")
1270:                     loc_lSucesso = .F.
1271:                 ENDIF
1272:             ENDIF
1273: 
1274:             *-- Salvar barra
1275:             IF USED("TmpBarra")
1276:                 IF !THIS.this_oBusinessObject.SalvarBarra(par_cGrupos, "TmpBarra")
1277:                     loc_lSucesso = .F.
1278:                 ENDIF
1279:             ENDIF
1280: 
1281:             *-- Salvar acesso a telas
1282:             IF USED("crSigAcTel")
1283:                 IF !THIS.this_oBusinessObject.SalvarAcessoTelas(par_cGrupos, "crSigAcTel")
1284:                     loc_lSucesso = .F.

*-- Linhas 1298 a 1320:
1298:         LOCAL loc_cStatus, loc_nResult
1299:         loc_cStatus = ""
1300:         TRY
1301:             loc_nResult = SQLEXEC(gnConnHandle, ;
1302:                 "SELECT cAtivos FROM sigcdusu WHERE Usuarios = " + EscaparSQL(ALLTRIM(par_cUsuarios)), ;
1303:                 "cursor_4c_TmpUsu")
1304:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpUsu") AND RECCOUNT("cursor_4c_TmpUsu") > 0
1305:                 SELECT cursor_4c_TmpUsu
1306:                 IF ALLTRIM(cAtivos) = "N"
1307:                     loc_cStatus = "Inativo"
1308:                 ELSE
1309:                     loc_cStatus = "Ativo"
1310:                 ENDIF
1311:             ENDIF
1312:             IF USED("cursor_4c_TmpUsu")
1313:                 USE IN cursor_4c_TmpUsu
1314:             ENDIF
1315:         CATCH TO loc_oErro
1316:             MsgErro("Erro ao obter status do usu" + CHR(225) + "rio: " + loc_oErro.Message, "Erro")
1317:         ENDTRY
1318:         RETURN loc_cStatus
1319:     ENDPROC
1320: 

*-- Linhas 1338 a 1399:
1338:             MsgAviso("Selecione um grupo na lista.")
1339:             RETURN
1340:         ENDIF
1341:         SELECT cursor_4c_Dados
1342:         loc_cGrupos = ALLTRIM(Grupos)
1343:         IF EMPTY(loc_cGrupos)
1344:             MsgAviso("Selecione um grupo na lista.")
1345:             RETURN
1346:         ENDIF
1347:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1348:             THIS.this_oBusinessObject.EditarRegistro()
1349:             THIS.BOParaForm()
1350:             THIS.this_cModoAtual = "ALTERAR"
1351:             THIS.HabilitarCampos(.T.)
1352:             THIS.CarregarDadosGrupo(loc_cGrupos)
1353:             THIS.AlternarPagina(2)
1354:         ENDIF
1355:     ENDPROC
1356: 
1357:     PROCEDURE BtnVisualizarClick()
1358:         LOCAL loc_cGrupos
1359:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1360:             MsgAviso("Selecione um grupo na lista.")
1361:             RETURN
1362:         ENDIF
1363:         SELECT cursor_4c_Dados
1364:         loc_cGrupos = ALLTRIM(Grupos)
1365:         IF EMPTY(loc_cGrupos)
1366:             MsgAviso("Selecione um grupo na lista.")
1367:             RETURN
1368:         ENDIF
1369:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1370:             THIS.BOParaForm()
1371:             THIS.this_cModoAtual = "VISUALIZAR"
1372:             THIS.HabilitarCampos(.F.)
1373:             THIS.CarregarDadosGrupo(loc_cGrupos)
1374:             THIS.AlternarPagina(2)
1375:         ENDIF
1376:     ENDPROC
1377: 
1378:     PROCEDURE BtnExcluirClick()
1379:         LOCAL loc_cGrupos
1380:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1381:             MsgAviso("Selecione um grupo na lista.")
1382:             RETURN
1383:         ENDIF
1384:         SELECT cursor_4c_Dados
1385:         loc_cGrupos = ALLTRIM(Grupos)
1386:         IF EMPTY(loc_cGrupos)
1387:             MsgAviso("Selecione um grupo na lista.")
1388:             RETURN
1389:         ENDIF
1390:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o do grupo " + loc_cGrupos + "?")
1391:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
1392:                 IF THIS.this_oBusinessObject.Excluir()
1393:                     MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso.")
1394:                     THIS.CarregarLista()
1395:                 ENDIF
1396:             ENDIF
1397:         ENDIF
1398:     ENDPROC
1399: 

*-- Linhas 1406 a 1431:
1406:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1407:             loc_oBusca.Show()
1408:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1409:                 SELECT cursor_4c_Busca
1410:                 loc_cGrupoSel = ALLTRIM(Grupos)
1411:                 USE IN cursor_4c_Busca
1412:                 THIS.this_oBusinessObject.Buscar(loc_cGrupoSel)
1413:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 2
1414:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1415:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
1416:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"
1417:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Grupo"
1418:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Nome"
1419:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1420:             ELSE
1421:                 IF USED("cursor_4c_Busca")
1422:                     USE IN cursor_4c_Busca
1423:                 ENDIF
1424:             ENDIF
1425:         CATCH TO loc_oErro
1426:             MsgErro("Erro ao buscar grupo: " + loc_oErro.Message, "Erro")
1427:         ENDTRY
1428:     ENDPROC
1429: 
1430:     PROCEDURE BtnSalvarClick()
1431:         LOCAL loc_cGrupos, loc_cNome

*-- Linhas 1503 a 1521:
1503:             loc_oBusca.mAddColuna("NComps", "", "Nome")
1504:             loc_oBusca.Show()
1505:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrigem")
1506:                 SELECT cursor_4c_BuscaOrigem
1507:                 loc_oTxt.Value = ALLTRIM(Grupos)
1508:                 USE IN cursor_4c_BuscaOrigem
1509:             ELSE
1510:                 IF USED("cursor_4c_BuscaOrigem")
1511:                     USE IN cursor_4c_BuscaOrigem
1512:                 ENDIF
1513:             ENDIF
1514:         CATCH TO loc_oErro
1515:             MsgErro("Erro ao buscar grupo de origem: " + loc_oErro.Message, "Erro")
1516:         ENDTRY
1517:     ENDPROC
1518: 
1519:     *==========================================================================
1520:     * BtnCopiarOkClick - Executa copia de acessos entre grupos
1521:     *==========================================================================

*-- Linhas 1531 a 1549:
1531:             THIS.pgf_4c_Paginas.Page1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem.SetFocus()
1532:             RETURN
1533:         ENDIF
1534:         SELECT cursor_4c_Dados
1535:         loc_cGrupoDestino = ALLTRIM(Grupos)
1536:         IF UPPER(loc_cGrupoOrigem) = UPPER(loc_cGrupoDestino)
1537:             MsgAviso("Grupo de origem e destino s" + CHR(227) + "o iguais.")
1538:             RETURN
1539:         ENDIF
1540:         IF MsgConfirma("Copiar acessos de [" + loc_cGrupoOrigem + "] para [" + loc_cGrupoDestino + "]?")
1541:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupoDestino)
1542:                 IF THIS.this_oBusinessObject.CopiarAcessos(loc_cGrupoOrigem)
1543:                     MsgInfo("Acessos copiados com sucesso.")
1544:                     THIS.AtivaCopia(.F.)
1545:                 ENDIF
1546:             ENDIF
1547:         ENDIF
1548:     ENDPROC
1549: 

*-- Linhas 1588 a 1606:
1588:         ENDIF
1589:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1590:         FOR loc_nI = loc_oAba.lbx_4c_Disponiveis.ListCount TO 1 STEP -1
1591:             IF loc_oAba.lbx_4c_Disponiveis.Selected(loc_nI)
1592:                 loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI))
1593:                 loc_oAba.lbx_4c_Selecionados.AddItem(loc_cUsu)
1594:                 loc_oAba.lbx_4c_Disponiveis.RemoveItem(loc_nI)
1595:             ENDIF
1596:         ENDFOR
1597:     ENDPROC
1598: 
1599:     PROCEDURE BtnAddAllUsuClick()
1600:         LOCAL loc_oAba, loc_nI
1601:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1602:             RETURN
1603:         ENDIF
1604:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1605:         FOR loc_nI = 1 TO loc_oAba.lbx_4c_Disponiveis.ListCount
1606:             loc_oAba.lbx_4c_Selecionados.AddItem(ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_nI)))

*-- Linhas 1615 a 1633:
1615:         ENDIF
1616:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1617:         FOR loc_nI = loc_oAba.lbx_4c_Selecionados.ListCount TO 1 STEP -1
1618:             IF loc_oAba.lbx_4c_Selecionados.Selected(loc_nI)
1619:                 loc_cUsu = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI))
1620:                 loc_oAba.lbx_4c_Disponiveis.AddItem(loc_cUsu)
1621:                 loc_oAba.lbx_4c_Selecionados.RemoveItem(loc_nI)
1622:             ENDIF
1623:         ENDFOR
1624:     ENDPROC
1625: 
1626:     PROCEDURE BtnRemAllUsuClick()
1627:         LOCAL loc_oAba, loc_nI
1628:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1629:             RETURN
1630:         ENDIF
1631:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1632:         FOR loc_nI = 1 TO loc_oAba.lbx_4c_Selecionados.ListCount
1633:             loc_oAba.lbx_4c_Disponiveis.AddItem(ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_nI)))

*-- Linhas 1639 a 1660:
1639:     * TxtFiltroAcessoValid - Aplica filtro na grid de programas
1640:     *==========================================================================
1641:     PROCEDURE TxtFiltroAcessoValid()
1642:         THIS.this_cFiltroPrograma = UPPER(ALLTRIM( ;
1643:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.txt_4c_FiltroAcesso.Value))
1644:         IF USED("cursor_4c_Programas")
1645:             SELECT cursor_4c_Programas
1646:             IF EMPTY(THIS.this_cFiltroPrograma)
1647:                 SET FILTER TO
1648:             ELSE
1649:                 SET FILTER TO THISFORM.this_cFiltroPrograma $ UPPER(ALLTRIM(Descricaos))
1650:             ENDIF
1651:             GO TOP
1652:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Refresh()
1653:         ENDIF
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
1658:     *==========================================================================
1659:     PROCEDURE ChkMarcasWhen()
1660:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")

*-- Linhas 1704 a 1725:
1704:     *==========================================================================
1705:     PROCEDURE Destroy()
1706:         IF USED("cursor_4c_Dados")
1707:             USE IN cursor_4c_Dados
1708:         ENDIF
1709:         IF USED("cursor_4c_Programas")
1710:             USE IN cursor_4c_Programas
1711:         ENDIF
1712:         IF USED("TmpBarra")
1713:             USE IN TmpBarra
1714:         ENDIF
1715:         IF USED("crSigAcTel")
1716:             USE IN crSigAcTel
1717:         ENDIF
1718:         IF USED("cursor_4c_TodosUsuarios")
1719:             USE IN cursor_4c_TodosUsuarios
1720:         ENDIF
1721:         IF USED("cursor_4c_UsuariosGrupo")
1722:             USE IN cursor_4c_UsuariosGrupo
1723:         ENDIF
1724:         IF USED("cursor_4c_UsrSalvar")
1725:             USE IN cursor_4c_UsrSalvar


### BO (C:\4c\projeto\app\classes\acgBO.prg):
*==============================================================================
* acgBO.prg - Business Object para Acesso de Grupos (SIGCDACG)
* Tabela Principal: sigcdgra (PK: Grupos)
* Tabelas Relacionadas:
*   - sigcdacg (usuarios do grupo)
*   - sigcdacu (acessos de programa por grupo/usuario)
*   - sigcdacb (barra de ferramentas por grupo)
*   - sigactel (acesso a campos em telas por grupo)
*   - sigcdprg (programas disponiveis)
*   - sigcdusu (usuarios cadastrados)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS acgBO AS BusinessBase

    *-- Propriedades: sigcdgra
    this_cGrupos    = ""   && grupos char(10) NOT NULL - PK
    this_cNComps    = ""   && ncomps char(30) NOT NULL - nome do grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(Grupos, "C")
            THIS.this_cNComps = TratarNulo(NComps, "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos com filtro opcional para exibir no grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Grupos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega grupo pela PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT sigcdgra (registro principal)
    * Dados relacionados sao salvos separadamente via SalvarUsuarios,
    * SalvarProgramas, SalvarBarra, SalvarAcessoTelas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigcdgra (Grupos, NComps) VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigcdgra (registro principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigcdgra SET NComps = " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ;
                " WHERE Grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigcdgra e todas as tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        TRY
            *-- Excluir dependencias (ordem importa para FK)
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del1")
            IF USED("cursor_4c_Del1")
                USE IN cursor_4c_Del1
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del2")
            IF USED("cursor_4c_Del2")
                USE IN cursor_4c_Del2
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del3")
            IF USED("cursor_4c_Del3")
                USE IN cursor_4c_Del3
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del4")
            IF USED("cursor_4c_Del4")
                USE IN cursor_4c_Del4
            ENDIF

            *-- Excluir registro principal
            loc_cSQL = "DELETE FROM sigcdgra WHERE Grupos = " + loc_cGrupoSQL
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del5")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                IF USED("cursor_4c_Del5")
                    USE IN cursor_4c_Del5
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosGrupos - Lista todos os grupos (para listbox de copia)
    * Retorna cursor: cursor_4c_ListaGrupos (Grupos, NComps)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosGrupos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaGrupos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_ListaGrupos")
                    SELECT cursor_4c_ListaGrupos
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosUsuarios - Lista todos os usuarios do sistema
    * Retorna cursor: cursor_4c_TodosUsuarios (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosUsuarios()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Usuarios, NComps, cAtivos FROM sigcdusu ORDER BY NComps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosUsuarios")
            IF loc_nResult >= 0
                IF USED("cursor_4c_TodosUsuarios")
                    SELECT cursor_4c_TodosUsuarios
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUsuariosDoGrupo - Carrega usuarios pertencentes ao grupo
    * Retorna cursor: cursor_4c_UsuariosGrupo (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUsuariosDoGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Usuarios, u.NComps, u.cAtivos" + ;
                " FROM sigcdacg a" + ;
                " LEFT JOIN sigcdusu u ON u.Usuarios = a.Usuarios" + ;
                " WHERE a.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " ORDER BY a.Usuarios"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")
            IF loc_nResult >= 0
                IF USED("cursor_4c_UsuariosGrupo")
                    SELECT cursor_4c_UsuariosGrupo
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Carrega programas disponiveis com marcacao do grupo
    * Retorna cursor: cursor_4c_Programas (Descricaos, Programas, Parametros,
    *                 BarraForms, Marcas)
    * Marcas=1: programa ja liberado ao grupo; Marcas=0: nao liberado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProgramas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Descricaos, a.Programas, a.Parametros, a.BarraForms," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS Marcas" + ;
                " FROM sigcdprg a" + ;
                " LEFT JOIN sigcdacu b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " ORDER BY a.Descricaos, a.Programas, a.Parametros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarra - Carrega itens de barra de ferramentas com marcacao do grupo
    * Retorna cursor: TmpBarra (BarraOrdem, Descricaos, BarraForms, Programas,
    *                           Parametros, SelBarras, Usuarios)
    * SelBarras=1: item ativo no grupo; SelBarras=0: inativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarra(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DISTINCT a.BarraOrdem, a.Descricaos, a.BarraForms," + ;
                " a.Programas, a.Parametros," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS SelBarras," + ;
                " '' AS Usuarios" + ;
                " FROM sigcdacb a" + ;
                " LEFT JOIN sigcdacb b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                " ORDER BY a.BarraOrdem, a.Descricaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpBarra")
            IF loc_nResult >= 0
                IF USED("TmpBarra")
                    SELECT TmpBarra
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessoTelas - Carrega controle de acesso a campos nas telas
    * par_cGrupos: codigo do grupo (vazio = inserindo novo, traz template com nStatus=1)
    * Retorna cursor: crSigAcTel (cCodigos, cDescTelas, cCampos, cObjetos,
    *                              cDescCamps, nStatus, Grupos, Usuarios, pkchaves)
    * nStatus=0: campo liberado; nStatus=1: campo bloqueado (default)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessoTelas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(ALLTRIM(par_cGrupos))
        TRY
            IF EMPTY(ALLTRIM(par_cGrupos))
                *-- Novo grupo: retorna template com todos os campos bloqueados
                loc_cSQL = "SELECT cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps," + ;
                    " 1 AS nStatus, '' AS Grupos, '' AS Usuarios, '' AS pkchaves" + ;
                    " FROM sigactel WHERE grupos = '' AND usuarios = ''" + ;
                    " ORDER BY cCodigos"
            ELSE
                *-- Grupo existente: mostra estado real com defaults bloqueados
                loc_cSQL = "SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps," + ;
                    " ISNULL(b.nStatus, 1) AS nStatus," + ;
                    " ISNULL(b.Grupos, '') AS Grupos," + ;
                    " ISNULL(b.Usuarios, '') AS Usuarios," + ;
                    " ISNULL(b.pkchaves, '') AS pkchaves" + ;
                    " FROM sigactel a" + ;
                    " LEFT JOIN sigactel b ON b.cCodigos = a.cCodigos" + ;
                    " AND b.cCampos = a.cCampos" + ;
                    " AND b.grupos = " + loc_cGrupoSQL + ;
                    " AND b.usuarios = ''" + ;
                    " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                    " ORDER BY a.cCodigos"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigAcTel")
            IF loc_nResult >= 0
                IF USED("crSigAcTel")
                    SELECT crSigAcTel
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar acesso telas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarUsuarios - Salva lista de usuarios do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorUsuarios: cursor com campo Usuarios char(10)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarUsuarios(par_cGrupos, par_cCursorUsuarios)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL, loc_cUsuario
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar usuarios existentes do grupo
            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcg")
            IF USED("cursor_4c_DelAcg")
                USE IN cursor_4c_DelAcg
            ENDIF

            *-- Reinserir usuarios selecionados
            IF USED(par_cCursorUsuarios) AND RECCOUNT(par_cCursorUsuarios) > 0
                SELECT (par_cCursorUsuarios)
                GO TOP
                SCAN
                    loc_cUsuario = ALLTRIM(Usuarios)
                    IF !EMPTY(loc_cUsuario)
                        loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cUsuario, 10)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorUsuarios)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarProgramas - Salva acessos de programa do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorProgramas: cursor com campos Programas, Parametros, Marcas
    *   Marcas=1: programa liberado ao grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarProgramas(par_cGrupos, par_cCursorProgramas)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cProg, loc_cParam, loc_nMarcas
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar acessos de programa do grupo (somente nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcu")
            IF USED("cursor_4c_DelAcu")
                USE IN cursor_4c_DelAcu
            ENDIF

            *-- Reinserir programas selecionados (Marcas=1)
            IF USED(par_cCursorProgramas) AND RECCOUNT(par_cCursorProgramas) > 0
                SELECT (par_cCursorProgramas)
                GO TOP
                SCAN
                    loc_nMarcas = Marcas
                    loc_cProg   = ALLTRIM(Programas)
                    loc_cParam  = ALLTRIM(Parametros)
                    IF loc_nMarcas = 1 AND !EMPTY(loc_cProg)
                        loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", '', " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorProgramas)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar programas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Salva configuracao da barra de ferramentas do grupo
    * par_cGrupos: codigo do grupo
    * par_cCursorBarra: cursor TmpBarra com campos BarraOrdem, Descricaos,
    *   BarraForms, Programas, Parametros, SelBarras
    *   SelBarras=.T./1: item selecionado para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cGrupos, par_cCursorBarra)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cDescricaos, loc_cBarraForms, loc_nBarraOrdem
        LOCAL loc_cProg, loc_cParam, loc_lSel
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar barra existente do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcb")
            IF USED("cursor_4c_DelAcb")
                USE IN cursor_4c_DelAcb
            ENDIF

            *-- Reinserir itens selecionados
            IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                SELECT (par_cCursorBarra)
                GO TOP
                SCAN
                    loc_lSel        = SelBarras
                    loc_cDescricaos = ALLTRIM(Descricaos)
                    loc_cBarraForms = ALLTRIM(BarraForms)
                    loc_nBarraOrdem = BarraOrdem
                    loc_cProg       = ALLTRIM(Programas)
                    loc_cParam      = ALLTRIM(Parametros)
                    IF loc_lSel
                        loc_cSQL = "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", '', " + ;
                            EscaparSQL(LEFT(loc_cDescricaos, 73)) + ", " + ;
                            EscaparSQL(LEFT(loc_cBarraForms, 50)) + ", " + ;
                            FormatarNumeroSQL(loc_nBarraOrdem) + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", 1, " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorBarra)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar barra:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessoTelas - Salva configuracao de acesso a campos nas telas
    * par_cGrupos: codigo do grupo
    * par_cCursorAcTel: cursor crSigAcTel com campos cCodigos, cDescTelas,
    *   cCampos, cObjetos, cDescCamps, nStatus
    *   nStatus=0: campo liberado (salva); nStatus=1: bloqueado (nao salva)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessoTelas(par_cGrupos, par_cCursorAcTel)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cCampos, loc_cCodigos, loc_cDescCamps, loc_cDescTelas
        LOCAL loc_cObjetos, loc_nStatus
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar registros existentes do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcTel")
            IF USED("cursor_4c_DelAcTel")
                USE IN cursor_4c_DelAcTel
            ENDIF

            *-- Reinserir apenas campos liberados (nStatus=0)
            IF USED(par_cCursorAcTel) AND RECCOUNT(par_cCursorAcTel) > 0
                SELECT (par_cCursorAcTel)
                GO TOP
                SCAN
                    loc_nStatus    = nStatus
                    loc_cCodigos   = ALLTRIM(cCodigos)
                    loc_cCampos    = ALLTRIM(cCampos)
                    loc_cDescCamps = ALLTRIM(cDescCamps)
                    loc_cDescTelas = ALLTRIM(cDescTelas)
                    loc_cObjetos   = ALLTRIM(cObjetos)
                    IF loc_nStatus <> 1
                        loc_cSQL = "INSERT INTO sigactel" + ;
                            " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                            " VALUES (" + ;
                            EscaparSQL(LEFT(loc_cCampos, 30)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCodigos, 10)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescCamps, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescTelas, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cObjetos, 100)) + ", " + ;
                            FormatarNumeroSQL(loc_nStatus) + ", " + ;
                            loc_cGrupoSQL + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcTel")
                        IF USED("cursor_4c_InsAcTel")
                            USE IN cursor_4c_InsAcTel
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorAcTel)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia todos os acessos de par_cGrupoOrigem para THIS.this_cGrupos
    * Usa INSERT ... SELECT direto no SQL Server para eficiencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cGrupoOrigem)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupoDest, loc_cGrupoOri
        loc_lResultado = .F.
        loc_cGrupoDest = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        loc_cGrupoOri  = EscaparSQL(LEFT(ALLTRIM(par_cGrupoOrigem), 10))
        TRY
            *-- Copiar usuarios: apenas os que o destino ainda nao tem
            loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.usuarios, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacg a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacg b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = a.usuarios)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcg")
            IF USED("cursor_4c_CpAcg")
                USE IN cursor_4c_CpAcg
            ENDIF

            *-- Copiar acessos de programa (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.programas, a.parametros, '', LEFT(NEWID(), 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacu b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            *-- Copiar barra de ferramentas (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacb" + ;
                " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", '', a.descricaos, a.barraforms, a.barraordem," + ;
                " a.programas, a.parametros, a.selbarras, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacb a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacb b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcb")
            IF USED("cursor_4c_CpAcb")
                USE IN cursor_4c_CpAcb
            ENDIF

            *-- Copiar acesso a telas (nivel grupo)
            loc_cSQL = "INSERT INTO sigactel" + ;
                " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                " SELECT a.ccampos, a.ccodigos, a.cdesccamps, a.cdesctelas, a.cobjetos," + ;
                " a.nstatus, " + loc_cGrupoDest + ", LEFT(NEWID(), 20), ''" + ;
                " FROM sigactel a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigactel b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.ccodigos = a.ccodigos AND b.ccampos = a.ccampos)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcTel")
            IF USED("cursor_4c_CpAcTel")
                USE IN cursor_4c_CpAcTel
            ENDIF

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao copiar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo de grupo ja existe
    * Retorna .T. se ja existe (duplicado), .F. se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            loc_cSQL = "SELECT Grupos FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    loc_lDuplicado = .T.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

ENDDEFINE

