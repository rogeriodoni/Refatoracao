# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (14)
- [GRID-SQL] Campo 'marca' usado em ControlSource de cursor_4c_GruposGrid mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'grupos' usado em ControlSource de cursor_4c_GruposGrid mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'descrs' usado em ControlSource de cursor_4c_GruposGrid mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'marcas' usado em ControlSource de cursor_4c_EmpresasGrid mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Razas' usado em ControlSource de cursor_4c_EmpresasGrid mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'marcas' usado em ControlSource de cursor_4c_Barra mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'programas' usado em ControlSource de cursor_4c_Barra mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'descricaos' usado em ControlSource de cursor_4c_Barra mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'barratips' usado em ControlSource de cursor_4c_Barra mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'marcas' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'programas' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'descricaos' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'parametros' usado em ControlSource de cursor_4c_Programas mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MARCA' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, TEXTO, EXPANDI, I, CCAMPOS, USUARIOS, CTIPOS, LNERRO1, PKCHAVES, 0, PROGRAMAS, PARAMETROS, ICLIS, MARCAS, NSTATUS, ICL, GRUPOS, EMPS

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
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = "TmpBarra.SelBarras"
  ControlSource = "TmpBarra.Descricaos"
  ControlSource = ""
  ControlSource = ""
  ControlSource = "TmpBarra.SelBarras"
  ControlSource = "crsigcdusu.usuarios"
  ControlSource = "crsigcdusu.ncomps"
  ControlSource = "crsigcdusu.CCargs"
  ControlSource = "crsigcdusu.Deptos"
  ControlSource = "crsigcdusu.Setores"
  ControlSource = "crSigCdUsu.IClis"
  ControlSource = "crSigCdUsu.ObrigSenhas"
  ControlSource = "crSigCdUsu.LiberaMov"
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  ControlSource = "TmpBarra.Descricaos"
  ControlSource = "TmpBarra.SelBarras"
  DeleteMark = .F.
  Column1.ControlSource = ""
  ControlSource = "TmpBarra.Descricaos"
Select crOrigem
Select crDestino
	Select crDestino
	Delete From TmpBarra Where Programas + Parametros Not In (Select b.Programas + b.Parametros From crDestino b Where Not Empty(b.Usuarios))
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
	Select a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps, Nvl(b.nStatus,1) As nStatus, Nvl(b.Grupos,'') As Grupos, Nvl(b.Usuarios,'') As Usuarios, ;
		from crAcCamp a Left Join crTmpAcTel b On a.cCodigos = b.cCodigos And a.cCampos = b.cCampos ;
	.column2.ControlSource = [crSigAcTel.cDescTelas]
	.column3.ControlSource = [crSigAcTel.cDescCamps]
	.column4.ControlSource = [crSigAcTel.nStatus]
Select crsigcdusu
	SELECT crGruAce
	m.lnErro1 = Iif(ThisForm.poDataMgr.Update('crsigcdusu'),1,-1)
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From SigCdAcG Where Usuarios = ?pUsu])
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From sigcdace Where Usuarios = ?pUsu])
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From SigAcTel Where Usuarios = ?pUsu])
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From sigcdacu Where Usuarios = ?pUsu])
Select crCadBarra
		m.lnErro1 = ThisForm.poDatamgr2.SQLExecute([Delete From SigCdAcB Where pkChaves = '] + crCadBarra.pkChaves + ['])
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigCdAcG'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdace'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdacu'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigCdAcB'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigAcTel'),1,-1)
Select ('crsigcdusu')
Delete 
	m.lnErro1 = Iif(ThisForm.poDataMgr.Update('crsigcdusu'),1,-1)
Select crSigCdAcG
Delete All
SELECT crsigcdace
DELETE All
lcQuery = [Delete From sigcdacu Where Usuarios = '] + pUsu + [']
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute(lcQuery)
lcQuery = [Delete From SigCdAcB Where Usuarios = '] + pUsu + [']
	m.lnErro1 = ThisForm.poDatamgr2.SQLExecute(lcQuery)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crSigCdAcG'),1,-1)
	m.lnErro1 = Iif(ThisForm.poDatamgr2.Update('crsigcdace'),1,-1)
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
lcQryUsuar = 'Select * From sigcdusu'
lcQryGrupo = 'Select * From sigcdgra Order By Grupos'
lcQryProgr = 'Select * From sigcdprg Order By Descricaos, Programas, Parametros'
lcQryBarra = 'Select * From SigCdAcB Where Usuarios = ?pUsu'
lcQryAcess = 'Select * From sigcdacu Where Usuarios = ?pUsu'
lcQryGrupU = 'Select * From SigCdAcG Where Usuarios = ?pUsu'
lcQryEmpUs = 'Select * From sigcdace Where Usuarios = ?pUsu'
lcQryAcTel = [Select * From SigAcTel Where Usuarios = ?pUsu] && #Programador - 16/05/2014 - SRCOM - Acesso campo nas telas
		lcSQLCmd = [Select Distinct Descricaos, Programas, Parametros, BarraForms ] + ;
					 [From sigcdprg ] + ;
		If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crTodossigcdprg') < 1)
		SELECT *, 0 as expandi from crTodossigcdprg into cursor crorigem
		Select * from crSigAcTel into cursor crTmpAcTel
		SELECT *, 0 as marca from crSigCdGrA into cursor crGruAce
		Select crsigcdusu
Select crsigcdusu
			lcQuery = [Select Distinct a.Grupos ] + ;
						[From SigCdAcG a ] + ;
						[inner join sigcdgra b on a.grupos = b.grupos ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmp') < 1)
			lcQuery = [Select Distinct a.Grupos From sigcdgra a Where not a.Grupos in ] + ;
						[(Select Distinct b.Grupos ] + ;
						[From SigCdAcG b ] + ;
						[inner join sigcdgra c on b.grupos = c.grupos ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmp2') < 1)
			SELECT *, 1 as marca  from crtmp ;
			SELECT *, 0 as marca from crtmp2 ;
			lcQuery = [Select Distinct a.Emps, b.razas ] + ;
						[From sigcdace a inner join SigCdEmp b on a.emps=b.cemps ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmp') < 1)
			lcQuery = [Select Distinct a.cEmps, a.Razas From SigCdEmp a Where not a.cEmps in ] + ;
						[(Select Distinct b.Emps ] + ;
						[From sigcdace b ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmp2') < 1)
			SELECT *, 1 as marca from crtmp ;
			SELECT *, 0 as marca from crtmp2 ;
			thisform.pagina.dados.pagina.empresa.grade.column1.ControlSource = [crEmpAce.marca]
			thisform.pagina.dados.pagina.empresa.grade.column2.ControlSource = [crEmpAce.razas]
			lcSQLCmd = [Select Distinct a.Descricaos, a.Programas, a.Parametros, a.BarraForms, ] + ;
					   [From sigcdprg a ] + ;
					   [Inner Join sigcdacu c On a.Programas + a.Parametros = c.Programas + c.Parametros ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crListAce') < 1)
			Select crListAce
			lcSQLCmd = [Select Distinct a.Descricaos, a.Programas, a.Parametros, a.BarraForms, ] + ;
					   [From sigcdprg a ] + ;
					   Iif(ThisForm.pcEscolha = [INSERIR], [], [Where Not Exists (Select b.pkChaves From sigcdacu b ] + ;
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
			ThisForm.Pagina.Dados.Pagina.Acesso.grdAcesso.column1.ControlSource = [crSigCdPrg.Descricaos]
			ThisForm.Pagina.Dados.Pagina.Acesso.grdAcesso.column2.ControlSource = [crSigCdPrg.Programas]
			ThisForm.Pagina.Dados.Pagina.Acesso.grdAcesso.column3.ControlSource = [crSigCdPrg.Marcas]
			ThisForm.Pagina.Dados.Pagina.Acesso.grdAcesso.column4.ControlSource = [crSigCdPrg.Parametros]
			Select crSigCdPrg
			Select crListAce
				If Seek(crListAce.fkChaves,[crSigCdPrg],[pkchaves])
			Select crSigCdPrg
			lcQuery = [Select * From SigAcTel a Where ] + Iif(ThisForm.pcEscolha=='INSERIR' Or Empty(ThisForm.Usuarios), [0=1],[a.Usuarios = '] + Padr(ThisForm.Usuarios, 10) + [' Order By cCodigos])
			If (ThisForm.poDataMgr2.SQLExecute(lcQuery, 'crTmpAcTel') < 1)
			lcSQLCmd = [Select b.* ] + ;
						 [From sigcdacu a, SigCdAcB b ] + ;
			If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'crListBarra') < 1)
			Select crListBarra
				Select crListBarra
				If Not Seek(m.Programas+m.Parametros,'TmpBarra','ProPar')
					Insert Into TmpBarra From Memvar
		Select crOrigem
		Select crDestino
	lcQuery = [Select RClis ] + ;
			    [From SigCdCli ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalBus]) < 1)
Select crLogData
Select crsigcdusu
	SELECT crGruAce
			Insert Into crSigcdAcG From Memvar
	SELECT crEmpAce
			Insert Into crSigCdAcE From Memvar
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
	Select 'E' As cTipos, a.pkChaves, a.Programas, a.Parametros From crListBarra a ;
		Left Join TmpBarra b On b.Programas = a.Programas And b.Parametros = a.Parametros;
	Select 'I' As cTipos, Space(20) As pkChaves, a.Programas, a.Parametros from TmpBarra a ;
		Where a.SelBarras And Not Exists (Select b.Programas From crListBarra b Where b.SelBarras And b.Programas = a.Programas And b.Parametros = a.Parametros) ; 
	Select crCadBarra
		If Seek(crCadBarra.Programas + crCadBarra.Parametros, 'TmpBarra', 'ProPar')
			Select TmpBarra
			Insert Into crSigCdAcB From Memvar
	Select crSigAcTel
	Delete For nStatus = 1
Select crsigcdusu
Select crsigcdusu
		m.lcMcrSql1 = [update sigcdusu set senhas='] + Space(10) + [' where usuarios='] + crsigcdusu.Usuarios + [']
			m.lnErro1 = m.loDataMgr1.SQLExecute(m.lcMcrSql1)
lcSQLCmd = [Select a.Grupos, a.Parametros, a.Programas ] + ;
			 [From sigcdacu a ] + ;
		  [(Select b.Programas + b.Parametros ] + ;
		     [From sigcdacu b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'Tmpsigcdacus') < 1)
lcSQLCmd = [Select a.Grupos ] + ;
			 [From SigCdAcG a ] + ;
		  [(Select b.Grupos ] + ;
		     [From SigCdAcG b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'TmpSigCdAcG') < 1)
lcSQLCmd = [Select a.Emps ] + ;
			 [From sigcdace a ] + ;
		  [(Select b.Emps ] + ;
		     [From sigcdace b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'Tmpsigcdace') < 1)
lcSQLCmd = [Select a.* ] + ;
			 [From SigCdAcB a ] + ;
		  [(Select b.Programas + b.Parametros ] + ;
		  	 [From SigCdAcB b ] + ;
If (ThisForm.poDataMgr2.SQLExecute(lcSQLCmd, 'TmpSigCdAcB') < 1)
Select TmpSigCdAcG
	Insert Into crSigCdAcG (Grupos, Usuarios, pkChaves) ;
	Select crLogData
		Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
Select Tmpsigcdace
	Insert Into crsigcdace (Emps, Usuarios, pkChaves) ;
	Select crLogData
		Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
Select Tmpsigcdacus
	Insert Into crsigcdacu (Grupos, Parametros, Programas, Usuarios, pkChaves) ;
		lcQuery = [Select descricaos From sigcdprg Where programas = ']+Tmpsigcdacus.Programas+[' ]+;
		Thisform.poDatamgr.SqlExecute(lcQuery,'cssigcdprgs')
		Select cssigcdprgs
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
			Select crLogData
				Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
Select TmpSigCdAcB
	Insert Into crSigCdAcB (Grupos, Parametros, Programas, Usuarios, Descricaos, ;
lcQuery = [Select * From SigAcTel Where Usuarios = '] + lcUsuOri + [' ]
Thisform.poDatamgr.SqlExecute(lcQuery,'TmpCopAcTel')
Select TmpCopAcTel
	Insert into crSigAcTel from Memvar	
	If Not ThisForm.poDataMgr2.Update('crsigcdacu')
	If Not ThisForm.poDataMgr2.Update('crSigCdAcG')
	If Not ThisForm.poDataMgr2.Update('crsigcdace')
	If Not ThisForm.poDataMgr2.Update('crSigCdAcB')
	If Not ThisForm.poDataMgr2.Update('crSigAcTel')
	Select crLogData
Select TmpBarra
Select crSigCdPrg
	Select crSigCdPrg
	Select pkchaves From crSigCdPrg Where Alltrim(lcFiltro) $ Upper(descricaos) Into Cursor csFiltra ReadWrite 
	Select csFiltra
	SELECT crGruAce
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 
		Select crLogData
			Insert Into crLogData (cIdChaves, cOcors, cTipos) ;
				Delete 

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formacu.prg) - TRECHOS RELEVANTES PARA PASS SQL (2596 linhas total):

*-- Linhas 348 a 366:
348:             .HighlightBackColor = RGB(255, 255, 255)
349:             .HighlightForeColor = RGB(15, 41, 104)
350:             .HighlightStyle     = 2
351:             .DeleteMark         = .F.
352:             .RecordMark         = .F.
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .GridLines          = 3
356:             .Visible            = .T.
357:         ENDWITH
358: 
359:         *-- Container "Copiar Acesso" (flutuante sobre grid, inicia oculto)
360:         *-- Top=246+29=275, Left=351 (layout.json original)
361:         loc_oPagina.AddObject("cnt_4c_CopiarAcesso", "Container")
362:         WITH loc_oPagina.cnt_4c_CopiarAcesso
363:             .Top         = 275
364:             .Left        = 351
365:             .Width       = 294
366:             .Height      = 91

*-- Linhas 659 a 677:
659:             loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
660:             loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
661:             loc_oGrid.HighlightStyle     = 2
662:             loc_oGrid.DeleteMark         = .F.
663:             loc_oGrid.RecordMark         = .F.
664:             loc_oGrid.GridLines          = 3
665:             loc_oGrid.RowHeight          = 16
666:             loc_oGrid.ScrollBars         = 3
667:             loc_oGrid.ColumnCount        = 4
668:             loc_oGrid.Visible            = .T.
669: 
670:             WITH loc_oGrid
671:                 .Column1.Width           = 350
672:                 .Column1.ReadOnly        = .T.
673:                 .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
674: 
675:                 .Column2.Width           = 150
676:                 .Column2.ReadOnly        = .T.
677:                 .Column2.Header1.Caption = "Programa"

*-- Linhas 725 a 743:
725:             loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
726:             loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
727:             loc_oGrid.HighlightStyle     = 2
728:             loc_oGrid.DeleteMark         = .F.
729:             loc_oGrid.RecordMark         = .F.
730:             loc_oGrid.GridLines          = 3
731:             loc_oGrid.RowHeight          = 16
732:             loc_oGrid.ScrollBars         = 3
733:             loc_oGrid.ColumnCount        = 4
734:             loc_oGrid.Visible            = .T.
735: 
736:             WITH loc_oGrid
737:                 .Column1.Width           = 300
738:                 .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
739: 
740:                 .Column2.Width           = 170
741:                 .Column2.Header1.Caption = "Tool Tip Text"
742: 
743:                 .Column3.Width           = 130

*-- Linhas 779 a 820:
779:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
780:                 loc_oGrid.ColumnCount  = 5
781: 
782:                 *-- Problema 48: ControlSource APOS RecordSource (auto-bind por ordem)
783:                 *-- Problema 32: Header1.Caption APOS RecordSource (RecordSource reseta headers)
784:                 WITH loc_oGrid
785:                     .Column1.ControlSource   = "cursor_4c_Dados.usuarios"
786:                     .Column1.Width           = 90
787:                     .Column1.ReadOnly        = .T.
788:                     .Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
789: 
790:                     .Column2.ControlSource   = "cursor_4c_Dados.ncomps"
791:                     .Column2.Width           = 300
792:                     .Column2.ReadOnly        = .T.
793:                     .Column2.Header1.Caption = "Nome"
794: 
795:                     .Column3.ControlSource   = "cursor_4c_Dados.ccargs"
796:                     .Column3.Width           = 80
797:                     .Column3.ReadOnly        = .T.
798:                     .Column3.Header1.Caption = "Cargo"
799: 
800:                     .Column4.ControlSource   = "cursor_4c_Dados.deptos"
801:                     .Column4.Width           = 100
802:                     .Column4.ReadOnly        = .T.
803:                     .Column4.Header1.Caption = "Departamento"
804: 
805:                     .Column5.ControlSource   = "cursor_4c_Dados.cativos"
806:                     .Column5.Width           = 50
807:                     .Column5.ReadOnly        = .T.
808:                     .Column5.Header1.Caption = "Ativo"
809:                 ENDWITH
810: 
811:                 THIS.FormatarGridLista(loc_oGrid)
812:                 loc_lSucesso = .T.
813:             ENDIF
814:         CATCH TO loException
815:             MsgErro("Erro em Formacu.CarregarLista:" + CHR(13) + loException.Message, "Erro")
816:             loc_lSucesso = .F.
817:         ENDTRY
818: 
819:         RETURN loc_lSucesso
820:     ENDPROC

*-- Linhas 893 a 914:
893:         TRY
894:             loc_oAba    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
895:             loc_oGrid   = loc_oAba.grd_4c_Programas
896:             loc_cFiltro = UPPER(ALLTRIM(loc_oAba.txt_4c_Filtro.Value))
897: 
898:             IF USED("cursor_4c_Programas")
899:                 SELECT cursor_4c_Programas
900:                 IF EMPTY(m.loc_cFiltro)
901:                     SET FILTER TO
902:                 ELSE
903:                     SET FILTER TO m.loc_cFiltro $ UPPER(ALLTRIM(descricaos)) ;
904:                                OR m.loc_cFiltro $ UPPER(ALLTRIM(programas))  ;
905:                                OR m.loc_cFiltro $ UPPER(ALLTRIM(parametros))
906:                 ENDIF
907:                 GO TOP
908:                 loc_oGrid.Refresh()
909:             ENDIF
910: 
911:         CATCH TO loException
912:             MsgErro("Erro em Formacu.FiltrarProgramasAcesso:" + CHR(13) + loException.Message, "Erro")
913:         ENDTRY
914:     ENDPROC

*-- Linhas 932 a 974:
932:         ENDIF
933: 
934:         IF USED("cursor_4c_Dados")
935:             USE IN cursor_4c_Dados
936:         ENDIF
937:         IF USED("cursor_4c_Programas")
938:             USE IN cursor_4c_Programas
939:         ENDIF
940:         IF USED("cursor_4c_Grupos")
941:             USE IN cursor_4c_Grupos
942:         ENDIF
943:         IF USED("cursor_4c_Acessos")
944:             USE IN cursor_4c_Acessos
945:         ENDIF
946:         IF USED("cursor_4c_GruposUsu")
947:             USE IN cursor_4c_GruposUsu
948:         ENDIF
949:         IF USED("cursor_4c_EmpresasUsu")
950:             USE IN cursor_4c_EmpresasUsu
951:         ENDIF
952:         IF USED("cursor_4c_Barra")
953:             USE IN cursor_4c_Barra
954:         ENDIF
955:         IF USED("cursor_4c_GruposGrid")
956:             USE IN cursor_4c_GruposGrid
957:         ENDIF
958:         IF USED("cursor_4c_EmpresasGrid")
959:             USE IN cursor_4c_EmpresasGrid
960:         ENDIF
961:         IF USED("cursor_4c_AcCamp")
962:             USE IN cursor_4c_AcCamp
963:         ENDIF
964: 
965:         DODEFAULT()
966:     ENDPROC
967: 
968:     *--------------------------------------------------------------------------
969:     * ConfigurarAbaCadastro - Aba "Cadastro" (Page3 do pgf_4c_Abas)
970:     * Dados pessoais do usuario + grupos de acesso (grid substitui OLE TreeView)
971:     *--------------------------------------------------------------------------
972:     PROTECTED PROCEDURE ConfigurarAbaCadastro()
973:         LOCAL loc_oAba, loc_oGrid, loc_oCol
974:         loc_oAba  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3

*-- Linhas 1492 a 1510:
1492:                 .HighlightBackColor = RGB(255, 255, 255)
1493:                 .HighlightForeColor = RGB(15, 41, 104)
1494:                 .HighlightStyle     = 2
1495:                 .DeleteMark         = .F.
1496:                 .RecordMark         = .F.
1497:                 .RowHeight          = 16
1498:                 .ScrollBars         = 2
1499:                 .Visible            = .T.
1500:             ENDWITH
1501: 
1502:             *-- Coluna 1: Tela (original column2, ColumnOrder=1, Width=360)
1503:             WITH loc_oGrid.Column1
1504:                 .Width           = 360
1505:                 .Movable         = .F.
1506:                 .Resizable       = .F.
1507:                 .ReadOnly        = .T.
1508:                 .Header1.Caption = "Tela"
1509:                 .Header1.FontName = "Tahoma"
1510:                 .Header1.FontSize = 8

*-- Linhas 1556 a 1674:
1556:     *--------------------------------------------------------------------------
1557:     * InicializarCursorAcCamp - Cria cursor local com definicao dos campos
1558:     * configurados para controle de acesso por usuario (26 campos SIGCDCLI)
1559:     * Espelha o bloco CREATE CURSOR + INSERT do procedimento Load do original
1560:     *--------------------------------------------------------------------------
1561:     PROCEDURE InicializarCursorAcCamp()
1562:         IF USED("crAcCamp")
1563:             USE IN crAcCamp
1564:         ENDIF
1565: 
1566:         CREATE CURSOR crAcCamp (cCodigos c(10), cDescTelas c(50), cCampos c(30), ;
1567:                                 cObjetos c(100), cDescCamps c(50), nStatus n(1))
1568:         INDEX ON cCodigos TAG cCodigos
1569: 
1570:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1571:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.endes",     "Endere" + CHR(231) + "o", 0)
1572:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1573:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.fpubls",    "Forma de publicidade", 0)
1574:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1575:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.nacionals",  "Nacionalidade", 0)
1576:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1577:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.estcivils",  "Estado civil", 0)
1578:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1579:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.conjuges",   "C" + CHR(244) + "njuge", 0)
1580:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1581:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.ultcomps",   CHR(218) + "ltima compra", 0)
1582:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1583:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.codsegs",    "Segmento", 0)
1584:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1585:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.profiss",    "Profiss" + CHR(227) + "o", 0)
1586:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1587:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.DtVals",     "Validade", 0)
1588:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1589:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.tel1s",      "Telefone", 0)
1590:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1591:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.emails",     "E-mail", 0)
1592:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1593:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.contato",    "Contato", 0)
1594:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1595:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.CTELEMS",    "Telemarketing", 0)
1596:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1597:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.codigos",    "Classifica" + CHR(231) + CHR(227) + "o", 0)
1598:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1599:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.sexos",      "Sexo", 0)
1600:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1601:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.obs",        "Observa" + CHR(231) + CHR(227) + "o", 0)
1602:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1603:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.pastas",     "Pasta", 0)
1604:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1605:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.nascs",      "Nascimento", 0)
1606:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1607:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.idcontas",   "ID", 0)
1608:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1609:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.CCargs",     "Cargo", 0)
1610:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1611:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.grupovens",  "C/C - Centro de Custo", 0)
1612:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1613:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.vinculas",   "Conta Vinculada", 0)
1614:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1615:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.patrietqs",  "Patrimonial por Etiqueta", 0)
1616:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1617:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCDCLI.Concilias",  "Conta Concili" + CHR(225) + "vel", 0)
1618:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1619:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCLCRC.Caracteris", "Caracter" + CHR(237) + "stica Conta", 0)
1620:         INSERT INTO crAcCamp (cCodigos, cDescTelas, cCampos, cDescCamps, nStatus) VALUES ;
1621:             ("SIGCDCLI", "Cadastro Contas", "CRSIGCLJOB.JOBS",       "Acesso Jobs", 0)
1622:     ENDPROC
1623: 
1624:     *--------------------------------------------------------------------------
1625:     * CarregarAbasUsuario - Carrega dados de todas as abas para o usuario
1626:     *--------------------------------------------------------------------------
1627:     PROCEDURE CarregarAbasUsuario(par_cUsuarios)
1628:         THIS.CarregarGruposGrid(par_cUsuarios)
1629:         THIS.CarregarEmpresasGrid(par_cUsuarios)
1630:         THIS.CarregarAcessosGrid(par_cUsuarios)
1631:         THIS.CarregarBarraGrid(par_cUsuarios)
1632:         THIS.CarregarCamposGrid(par_cUsuarios)
1633:     ENDPROC
1634: 
1635:     *--------------------------------------------------------------------------
1636:     * CarregarGruposGrid - Grupos de acesso com marca de selecao
1637:     *--------------------------------------------------------------------------
1638:     PROCEDURE CarregarGruposGrid(par_cUsuarios)
1639:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1640:         loc_lResultado = .F.
1641: 
1642:         TRY
1643:             loc_cSQL = "SELECT g.grupos, g.descrs, " + ;
1644:                        "CAST(CASE WHEN ag.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marca " + ;
1645:                        "FROM sigcdgra g " + ;
1646:                        "LEFT JOIN sigcdacg ag ON ag.grupos = g.grupos AND ag.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1647:                        "ORDER BY g.grupos"
1648: 
1649:             IF USED("cursor_4c_GruposGrid")
1650:                 USE IN cursor_4c_GruposGrid
1651:             ENDIF
1652: 
1653:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposGrid") > 0
1654:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Grupos
1655:                 loc_oGrid.ColumnCount = 3
1656:                 loc_oGrid.RecordSource          = "cursor_4c_GruposGrid"
1657:                 loc_oGrid.Column1.ControlSource = "cursor_4c_GruposGrid.marca"
1658:                 loc_oGrid.Column2.ControlSource = "cursor_4c_GruposGrid.grupos"
1659:                 loc_oGrid.Column3.ControlSource = "cursor_4c_GruposGrid.descrs"
1660:                 loc_oGrid.Column1.Header1.Caption = ""
1661:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1662:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1663:                 loc_lResultado = .T.
1664:             ELSE
1665:                 MsgErro("Erro ao carregar grupos de acesso.", "Erro")
1666:             ENDIF
1667: 
1668:         CATCH TO loException
1669:             MsgErro("Erro em Formacu.CarregarGruposGrid:" + CHR(13) + loException.Message, "Erro")
1670:         ENDTRY
1671: 
1672:         RETURN loc_lResultado
1673:     ENDPROC
1674: 

*-- Linhas 1680 a 1754:
1680:         loc_lResultado = .F.
1681: 
1682:         TRY
1683:             loc_cSQL = "SELECT e.Cemps AS emps, e.Razas, " + ;
1684:                        "CAST(CASE WHEN ae.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas " + ;
1685:                        "FROM SigCdEmp e " + ;
1686:                        "LEFT JOIN sigcdace ae ON ae.emps = e.Cemps AND ae.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1687:                        "ORDER BY e.Cemps"
1688: 
1689:             IF USED("cursor_4c_EmpresasGrid")
1690:                 USE IN cursor_4c_EmpresasGrid
1691:             ENDIF
1692: 
1693:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasGrid") > 0
1694:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4.grd_4c_Empresas
1695:                 loc_oGrid.ColumnCount = 2
1696:                 loc_oGrid.RecordSource          = "cursor_4c_EmpresasGrid"
1697:                 loc_oGrid.Column1.ControlSource = "cursor_4c_EmpresasGrid.marcas"
1698:                 loc_oGrid.Column2.ControlSource = "cursor_4c_EmpresasGrid.Razas"
1699:                 loc_oGrid.Column1.Header1.Caption = ""
1700:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
1701:                 loc_lResultado = .T.
1702:             ELSE
1703:                 MsgErro("Erro ao carregar empresas.", "Erro")
1704:             ENDIF
1705: 
1706:         CATCH TO loException
1707:             MsgErro("Erro em Formacu.CarregarEmpresasGrid:" + CHR(13) + loException.Message, "Erro")
1708:         ENDTRY
1709: 
1710:         RETURN loc_lResultado
1711:     ENDPROC
1712: 
1713:     *--------------------------------------------------------------------------
1714:     * CarregarAcessosGrid - Programas com marca de acesso (aba Acesso)
1715:     *--------------------------------------------------------------------------
1716:     PROCEDURE CarregarAcessosGrid(par_cUsuarios)
1717:         LOCAL loc_cSQL, loc_oGrid, loc_lResultado
1718:         loc_lResultado = .F.
1719: 
1720:         TRY
1721:             loc_cSQL = "SELECT p.programas, p.descricaos, p.grupos, p.parametros, " + ;
1722:                        "CAST(CASE WHEN a.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas, " + ;
1723:                        "ISNULL(a.usuarios, '') AS usuarios " + ;
1724:                        "FROM sigcdprg p " + ;
1725:                        "LEFT JOIN sigcdacu a ON a.programas = p.programas AND a.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1726:                        "ORDER BY p.grupos, p.programas"
1727: 
1728:             IF USED("cursor_4c_Programas")
1729:                 USE IN cursor_4c_Programas
1730:             ENDIF
1731: 
1732:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas") > 0
1733:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1.grd_4c_Programas
1734:                 loc_oGrid.ColumnCount = 4
1735:                 loc_oGrid.RecordSource          = "cursor_4c_Programas"
1736:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Programas.marcas"
1737:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.programas"
1738:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.descricaos"
1739:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.parametros"
1740:                 loc_oGrid.Column1.Header1.Caption = ""
1741:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1742:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1743:                 loc_oGrid.Column4.Header1.Caption = "Par" + CHR(226) + "metro"
1744:                 loc_lResultado = .T.
1745:             ELSE
1746:                 MsgErro("Erro ao carregar programas de acesso.", "Erro")
1747:             ENDIF
1748: 
1749:         CATCH TO loException
1750:             MsgErro("Erro em Formacu.CarregarAcessosGrid:" + CHR(13) + loException.Message, "Erro")
1751:         ENDTRY
1752: 
1753:         RETURN loc_lResultado
1754:     ENDPROC

*-- Linhas 1761 a 1798:
1761:         loc_lResultado = .F.
1762: 
1763:         TRY
1764:             loc_cSQL = "SELECT p.programas, p.descricaos, " + ;
1765:                        "ISNULL(b.barratips, '') AS barratips, " + ;
1766:                        "ISNULL(b.barrapicts, '') AS barrapicts, " + ;
1767:                        "CAST(CASE WHEN b.usuarios IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS marcas " + ;
1768:                        "FROM sigcdprg p " + ;
1769:                        "LEFT JOIN sigcdacb b ON b.programas = p.programas AND b.usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1770:                        "ORDER BY p.programas"
1771: 
1772:             IF USED("cursor_4c_Barra")
1773:                 USE IN cursor_4c_Barra
1774:             ENDIF
1775: 
1776:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Barra") > 0
1777:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Barra
1778:                 loc_oGrid.ColumnCount = 4
1779:                 loc_oGrid.RecordSource          = "cursor_4c_Barra"
1780:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Barra.marcas"
1781:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Barra.programas"
1782:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Barra.descricaos"
1783:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Barra.barratips"
1784:                 loc_oGrid.Column1.Header1.Caption = ""
1785:                 loc_oGrid.Column2.Header1.Caption = "Programa"
1786:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1787:                 loc_oGrid.Column4.Header1.Caption = "Tooltip"
1788:                 loc_lResultado = .T.
1789:             ELSE
1790:                 MsgErro("Erro ao carregar barra de ferramentas.", "Erro")
1791:             ENDIF
1792: 
1793:         CATCH TO loException
1794:             MsgErro("Erro em Formacu.CarregarBarraGrid:" + CHR(13) + loException.Message, "Erro")
1795:         ENDTRY
1796: 
1797:         RETURN loc_lResultado
1798:     ENDPROC

*-- Linhas 1807 a 1853:
1807:         TRY
1808:             THIS.InicializarCursorAcCamp()
1809: 
1810:             loc_cSQL = "SELECT cCodigos, cCampos, nStatus, Grupos, Usuarios, PkChaves " + ;
1811:                        "FROM SigAcTel " + ;
1812:                        "WHERE Usuarios = " + EscaparSQL(par_cUsuarios) + " " + ;
1813:                        "ORDER BY cCodigos"
1814: 
1815:             IF USED("crTmpAcTel")
1816:                 USE IN crTmpAcTel
1817:             ENDIF
1818: 
1819:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpAcTel") > 0
1820:                 IF USED("crSigAcTel")
1821:                     USE IN crSigAcTel
1822:                 ENDIF
1823: 
1824:                 SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps, ;
1825:                        IIF(ISNULL(b.nStatus), 1, b.nStatus) AS nStatus, ;
1826:                        IIF(ISNULL(b.Grupos),    "", b.Grupos)    AS Grupos, ;
1827:                        IIF(ISNULL(b.Usuarios),  "", b.Usuarios)  AS Usuarios, ;
1828:                        IIF(ISNULL(b.PkChaves),  "", b.PkChaves)  AS PkChaves ;
1829:                        FROM crAcCamp a ;
1830:                        LEFT JOIN crTmpAcTel b ON a.cCodigos = b.cCodigos AND a.cCampos = b.cCampos ;
1831:                        INTO CURSOR crSigAcTel READWRITE
1832: 
1833:                 loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5.grd_4c_AcCamp
1834:                 loc_oGrid.RecordSource = ""
1835:                 loc_oGrid.RecordSource = "crSigAcTel"
1836:                 loc_oGrid.Column1.ControlSource   = "crSigAcTel.cDescTelas"
1837:                 loc_oGrid.Column2.ControlSource   = "crSigAcTel.cDescCamps"
1838:                 loc_oGrid.Column3.ControlSource   = "crSigAcTel.nStatus"
1839:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1840:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1841:                 loc_oGrid.Column3.Header1.Caption = "Status"
1842:                 loc_lResultado = .T.
1843:             ELSE
1844:                 MsgErro("Erro ao carregar campos de acesso.", "Erro")
1845:             ENDIF
1846: 
1847:         CATCH TO loException
1848:             MsgErro("Erro em Formacu.CarregarCamposGrid:" + CHR(13) + loException.Message, "Erro")
1849:         ENDTRY
1850: 
1851:         RETURN loc_lResultado
1852:     ENDPROC
1853: 

*-- Linhas 1977 a 2007:
1977:             loc_oAba.opt_4c_ObrigSenha.Value   = 2
1978:             loc_oAba.opt_4c_LibQtMin.Value     = 2
1979:             loc_oAba.opt_4c_Supervisao.Value   = 2
1980: 
1981:             *-- Limpar grids (registros em branco)
1982:             IF USED("cursor_4c_GruposGrid")
1983:                 USE IN cursor_4c_GruposGrid
1984:             ENDIF
1985:             IF USED("cursor_4c_EmpresasGrid")
1986:                 USE IN cursor_4c_EmpresasGrid
1987:             ENDIF
1988:             IF USED("cursor_4c_Programas")
1989:                 USE IN cursor_4c_Programas
1990:             ENDIF
1991:             IF USED("cursor_4c_Barra")
1992:                 USE IN cursor_4c_Barra
1993:             ENDIF
1994:             IF USED("cursor_4c_AcCamp")
1995:                 USE IN cursor_4c_AcCamp
1996:             ENDIF
1997: 
1998:         CATCH TO loException
1999:             MsgErro("Erro em Formacu.LimparCampos:" + CHR(13) + loException.Message, "Erro")
2000:         ENDTRY
2001:     ENDPROC
2002: 
2003:     *--------------------------------------------------------------------------
2004:     * AjustarBotoesPorModo - Habilita/desabilita botoes CRUD conforme modo
2005:     *--------------------------------------------------------------------------
2006:     PROCEDURE AjustarBotoesPorModo()
2007:         LOCAL loc_oCnt, loc_lTemRegistro

*-- Linhas 2212 a 2239:
2212:                 ELSE
2213:                     loc_lResultado = THIS.this_oBusinessObject.Atualizar()
2214:                 ENDIF
2215: 
2216:                 IF loc_lResultado
2217:                     IF USED("cursor_4c_Programas")
2218:                         THIS.this_oBusinessObject.SalvarAcessos(loc_cUsuarios, "cursor_4c_Programas")
2219:                     ENDIF
2220:                     IF USED("cursor_4c_GruposGrid")
2221:                         THIS.this_oBusinessObject.SalvarGrupos(loc_cUsuarios, "cursor_4c_GruposGrid")
2222:                     ENDIF
2223:                     IF USED("cursor_4c_EmpresasGrid")
2224:                         THIS.this_oBusinessObject.SalvarEmpresas(loc_cUsuarios, "cursor_4c_EmpresasGrid")
2225:                     ENDIF
2226: 
2227:                     MsgInfo("Usu" + CHR(225) + "rio salvo com sucesso.")
2228:                     THIS.this_cModoAtual    = "LISTA"
2229:                     THIS.this_cUsuarioAtual = loc_cUsuarios
2230:                     THIS.pgf_4c_Paginas.ActivePage = 1
2231:                     THIS.BtnBuscarClick()
2232:                 ELSE
2233:                     MsgErro("Erro ao salvar dados do usu" + CHR(225) + "rio.", "Erro")
2234:                 ENDIF
2235: 
2236:             CATCH TO loException
2237:                 MsgErro("Erro em Formacu.BtnSalvarClick:" + CHR(13) + loException.Message, "Erro")
2238:             ENDTRY
2239:         ENDIF

*-- Linhas 2382 a 2409:
2382: 
2383:         TRY
2384:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2385:                 "SELECT CCargs, DCargs FROM SigCdCrg ORDER BY CCargs", ;
2386:                 "cursor_4c_BuscaCargo")
2387: 
2388:             IF VARTYPE(loc_oLookup) = "O"
2389:                 loc_oLookup.mAddColuna("CCargs", "@!", "C" + CHR(243) + "digo")
2390:                 loc_oLookup.mAddColuna("DCargs", "@!",  "Descri" + CHR(231) + CHR(227) + "o")
2391:                 loc_oLookup.Show()
2392: 
2393:                 IF loc_oLookup.this_lSelecionou
2394:                     SELECT cursor_4c_BuscaCargo
2395:                     loc_oAba.txt_4c_Cargo.Value = ALLTRIM(cursor_4c_BuscaCargo.CCargs)
2396:                 ENDIF
2397: 
2398:                 loc_oLookup.Release()
2399:                 IF USED("cursor_4c_BuscaCargo")
2400:                     USE IN cursor_4c_BuscaCargo
2401:                 ENDIF
2402:             ENDIF
2403: 
2404:         CATCH TO loException
2405:             MsgErro("Erro em Formacu.AbrirLookupCargo:" + CHR(13) + loException.Message, "Erro")
2406:         ENDTRY
2407:     ENDPROC
2408: 
2409:     *==========================================================================

*-- Linhas 2426 a 2453:
2426: 
2427:         TRY
2428:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2429:                 "SELECT codigos, Descricaos FROM SigCdDpt ORDER BY codigos", ;
2430:                 "cursor_4c_BuscaDept")
2431: 
2432:             IF VARTYPE(loc_oLookup) = "O"
2433:                 loc_oLookup.mAddColuna("codigos",     "@!", "C" + CHR(243) + "digo")
2434:                 loc_oLookup.mAddColuna("Descricaos",  "@!", "Descri" + CHR(231) + CHR(227) + "o")
2435:                 loc_oLookup.Show()
2436: 
2437:                 IF loc_oLookup.this_lSelecionou
2438:                     SELECT cursor_4c_BuscaDept
2439:                     loc_oAba.txt_4c_Departamento.Value = ALLTRIM(cursor_4c_BuscaDept.codigos)
2440:                 ENDIF
2441: 
2442:                 loc_oLookup.Release()
2443:                 IF USED("cursor_4c_BuscaDept")
2444:                     USE IN cursor_4c_BuscaDept
2445:                 ENDIF
2446:             ENDIF
2447: 
2448:         CATCH TO loException
2449:             MsgErro("Erro em Formacu.AbrirLookupDepartamento:" + CHR(13) + loException.Message, "Erro")
2450:         ENDTRY
2451:     ENDPROC
2452: 
2453:     *==========================================================================

*-- Linhas 2470 a 2497:
2470: 
2471:         TRY
2472:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2473:                 "SELECT Setores, Descrs FROM SigCdSet ORDER BY Setores", ;
2474:                 "cursor_4c_BuscaSetor")
2475: 
2476:             IF VARTYPE(loc_oLookup) = "O"
2477:                 loc_oLookup.mAddColuna("Setores", "@!", "Setor")
2478:                 loc_oLookup.mAddColuna("Descrs",  "@!", "Descri" + CHR(231) + CHR(227) + "o")
2479:                 loc_oLookup.Show()
2480: 
2481:                 IF loc_oLookup.this_lSelecionou
2482:                     SELECT cursor_4c_BuscaSetor
2483:                     loc_oAba.txt_4c_Setores.Value = ALLTRIM(cursor_4c_BuscaSetor.Setores)
2484:                 ENDIF
2485: 
2486:                 loc_oLookup.Release()
2487:                 IF USED("cursor_4c_BuscaSetor")
2488:                     USE IN cursor_4c_BuscaSetor
2489:                 ENDIF
2490:             ENDIF
2491: 
2492:         CATCH TO loException
2493:             MsgErro("Erro em Formacu.AbrirLookupSetores:" + CHR(13) + loException.Message, "Erro")
2494:         ENDTRY
2495:     ENDPROC
2496: 
2497:     *==========================================================================

*-- Linhas 2524 a 2551:
2524: 
2525:         TRY
2526:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2527:                 "SELECT IClis, RClis FROM SigCdCli ORDER BY IClis", ;
2528:                 "cursor_4c_BuscaCli")
2529: 
2530:             IF VARTYPE(loc_oLookup) = "O"
2531:                 loc_oLookup.mAddColuna("IClis", "@!", CHR(205) + "ndice")
2532:                 loc_oLookup.mAddColuna("RClis", "@!", "Raz" + CHR(227) + "o")
2533:                 loc_oLookup.Show()
2534: 
2535:                 IF loc_oLookup.this_lSelecionou
2536:                     SELECT cursor_4c_BuscaCli
2537:                     loc_oAba.txt_4c_IClis.Value = ALLTRIM(cursor_4c_BuscaCli.IClis)
2538:                     loc_oAba.txt_4c_RClis.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
2539:                 ENDIF
2540: 
2541:                 loc_oLookup.Release()
2542:                 IF USED("cursor_4c_BuscaCli")
2543:                     USE IN cursor_4c_BuscaCli
2544:                 ENDIF
2545:             ENDIF
2546: 
2547:         CATCH TO loException
2548:             MsgErro("Erro em Formacu.AbrirLookupCli:" + CHR(13) + loException.Message, "Erro")
2549:         ENDTRY
2550:     ENDPROC
2551: 

*-- Linhas 2569 a 2596:
2569: 
2570:         TRY
2571:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
2572:                 "SELECT usuarios, NComps FROM sigcdusu ORDER BY usuarios", ;
2573:                 "cursor_4c_BuscaUsu")
2574: 
2575:             IF VARTYPE(loc_oLookup) = "O"
2576:                 loc_oLookup.mAddColuna("usuarios", "@!", "Usu" + CHR(225) + "rio")
2577:                 loc_oLookup.mAddColuna("NComps",   "@!", "Nome")
2578:                 loc_oLookup.Show()
2579: 
2580:                 IF loc_oLookup.this_lSelecionou
2581:                     SELECT cursor_4c_BuscaUsu
2582:                     loc_oPagina.cnt_4c_CopiarAcesso.txt_4c_CopiarAcessos.Value = ALLTRIM(cursor_4c_BuscaUsu.usuarios)
2583:                 ENDIF
2584: 
2585:                 loc_oLookup.Release()
2586:                 IF USED("cursor_4c_BuscaUsu")
2587:                     USE IN cursor_4c_BuscaUsu
2588:                 ENDIF
2589:             ENDIF
2590: 
2591:         CATCH TO loException
2592:             MsgErro("Erro em Formacu.AbrirLookupCopiarUsuario:" + CHR(13) + loException.Message, "Erro")
2593:         ENDTRY
2594:     ENDPROC
2595: 
2596: ENDDEFINE


### BO (C:\4c\projeto\app\classes\acuBO.prg):
*******************************************************************************
* acuBO.prg - Business Object para Cadastro de Usuarios
* Tabela principal: sigcdusu (PK: usuarios)
* Tabelas relacionadas: sigcdacg, sigcdace, sigcdacu, sigcdacb
*******************************************************************************

DEFINE CLASS acuBO AS BusinessBase

    *-- Propriedades da tabela sigcdusu
    this_cUsuarios    = ""  && usuarios char(10) - PK
    this_cNComps      = ""  && ncomps char(30) - nome completo
    this_cSenhas      = ""  && senhas char(10)
    this_cCCargs      = ""  && ccargs char(10) - codigo do cargo
    this_cLimDescs    = ""  && limdescs char(1) - senha do dia (S/N)
    this_cDeptos      = ""  && deptos char(10) - departamento
    this_cLibPess     = ""  && libpess char(1) - libera pesagem (S/N)
    this_cLibProds    = ""  && libprods char(1) - libera producao (S/N)
    this_cSetores     = ""  && setores char(10)
    this_cCativos     = ""  && cativos char(1) - ativo (S/N)
    this_cSupervis    = ""  && supervis char(1)
    this_cMbioDigs    = ""  && mbiodigs text NULL
    this_dTdtSenhas   = {}  && tdtsenhas datetime NULL - data/hora troca senha
    this_cIClis       = ""  && iclis char(10) - codigo cliente vinculado
    this_nObrigSenhas = 0   && obrigsenhas numeric(1,0) - obriga cadastro de senha
    this_cLibQtMins   = ""  && libqtmins char(1) - libera movimentacao (S/N)
    this_cFigJpgSuser = ""  && figjpgsuser text NULL - foto do usuario

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdusu"
        THIS.this_cCampoChave = "usuarios"
        RETURN .T.
    ENDPROC

    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cUsuarios)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cUsuarios    = TratarNulo(usuarios,    "C")
            THIS.this_cNComps      = TratarNulo(ncomps,      "C")
            THIS.this_cSenhas      = TratarNulo(senhas,      "C")
            THIS.this_cCCargs      = TratarNulo(ccargs,      "C")
            THIS.this_cLimDescs    = TratarNulo(limdescs,    "C")
            THIS.this_cDeptos      = TratarNulo(deptos,      "C")
            THIS.this_cLibPess     = TratarNulo(libpess,     "C")
            THIS.this_cLibProds    = TratarNulo(libprods,    "C")
            THIS.this_cSetores     = TratarNulo(setores,     "C")
            THIS.this_cCativos     = TratarNulo(cativos,     "C")
            THIS.this_cSupervis    = TratarNulo(supervis,    "C")
            THIS.this_cIClis       = TratarNulo(iclis,       "C")
            THIS.this_nObrigSenhas = TratarNulo(obrigsenhas, "N")
            THIS.this_cLibQtMins   = TratarNulo(libqtmins,   "C")
            IF !ISNULL(tdtsenhas)
                THIS.this_dTdtSenhas = tdtsenhas
            ELSE
                THIS.this_dTdtSenhas = {}
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista usuarios com filtro opcional (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " ORDER BY usuarios"
            ELSE
                loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, cativos" + ;
                           " FROM sigcdusu" + ;
                           " WHERE UPPER(usuarios) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " OR UPPER(ncomps) LIKE UPPER(" + EscaparSQL("%" + par_cFiltro + "%") + ")" + ;
                           " ORDER BY usuarios"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega usuario pelo codigo (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cUsuarios)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM sigcdusu" + ;
                       " WHERE usuarios = " + EscaparSQL(par_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdusu" + ;
                       " (usuarios, ncomps, senhas, ccargs, limdescs, deptos," + ;
                       "  libpess, libprods, setores, cativos, supervis, iclis," + ;
                       "  obrigsenhas, libqtmins)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cUsuarios)    + "," + ;
                       EscaparSQL(THIS.this_cNComps)      + "," + ;
                       EscaparSQL(THIS.this_cSenhas)      + "," + ;
                       EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       EscaparSQL(THIS.this_cSetores)     + "," + ;
                       EscaparSQL(THIS.this_cCativos)     + "," + ;
                       EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       EscaparSQL(THIS.this_cIClis)       + "," + ;
                       FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       EscaparSQL(THIS.this_cLibQtMins)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela sigcdusu (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE sigcdusu SET" + ;
                       "  ncomps      = " + EscaparSQL(THIS.this_cNComps)      + "," + ;
                       "  ccargs      = " + EscaparSQL(THIS.this_cCCargs)      + "," + ;
                       "  limdescs    = " + EscaparSQL(THIS.this_cLimDescs)    + "," + ;
                       "  deptos      = " + EscaparSQL(THIS.this_cDeptos)      + "," + ;
                       "  libpess     = " + EscaparSQL(THIS.this_cLibPess)     + "," + ;
                       "  libprods    = " + EscaparSQL(THIS.this_cLibProds)    + "," + ;
                       "  setores     = " + EscaparSQL(THIS.this_cSetores)     + "," + ;
                       "  cativos     = " + EscaparSQL(THIS.this_cCativos)     + "," + ;
                       "  supervis    = " + EscaparSQL(THIS.this_cSupervis)    + "," + ;
                       "  iclis       = " + EscaparSQL(THIS.this_cIClis)       + "," + ;
                       "  obrigsenhas = " + FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
                       "  libqtmins   = " + EscaparSQL(THIS.this_cLibQtMins)   + ;
                       " WHERE usuarios = " + EscaparSQL(THIS.this_cUsuarios)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em cascata (sigcdacu,sigcdacg,sigcdace,sigcdacb,sigcdusu)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cUsuarios, loc_nResultado
        loc_lSucesso = .F.
        loc_cUsuarios = EscaparSQL(THIS.this_cUsuarios)

        TRY
            *-- Remover acessos relacionados em cascata
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcu")
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_DlAcu")
                    USE IN cursor_4c_DlAcu
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM sigcdacg WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcg")
                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_DlAcg")
                        USE IN cursor_4c_DlAcg
                    ENDIF

                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "DELETE FROM sigcdace WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAce")
                    IF loc_nResultado < 0
                        MsgErro("Erro ao excluir empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_DlAce")
                            USE IN cursor_4c_DlAce
                        ENDIF

                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "DELETE FROM sigcdacb WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlAcb")
                        IF loc_nResultado < 0
                            MsgErro("Erro ao excluir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            IF USED("cursor_4c_DlAcb")
                                USE IN cursor_4c_DlAcb
                            ENDIF

                            loc_nResultado = SQLEXEC(gnConnHandle, ;
                                "DELETE FROM sigcdusu WHERE usuarios = " + loc_cUsuarios, "cursor_4c_DlUsu")
                            IF loc_nResultado >= 0
                                THIS.RegistrarAuditoria("DELETE")
                                loc_lSucesso = .T.
                            ELSE
                                MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            ENDIF
                            IF USED("cursor_4c_DlUsu")
                                USE IN cursor_4c_DlUsu
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega todos os grupos de acesso (sigcdgra)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarGrupos()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, dgrus FROM sigcdgra ORDER BY grupos", ;
                "cursor_4c_Grupos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProgramas - Carrega todos os programas (sigcdprg)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProgramas()
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Programas")
                USE IN cursor_4c_Programas
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, descricaos, programas, parametros, barraforms," + ;
                " barratips, barrapicts, pkchaves, 0 AS marcas" + ;
                " FROM sigcdprg" + ;
                " ORDER BY descricaos, programas, parametros", ;
                "cursor_4c_Programas")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.BuscarProgramas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessosPorUsuario - Carrega acessos do usuario (sigcdacu)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessosPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Acessos")
                USE IN cursor_4c_Acessos
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, programas, parametros, usuarios, pkchaves" + ;
                " FROM sigcdacu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_Acessos")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarAcessosPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposPorUsuario - Carrega grupos do usuario (sigcdacg)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_GruposUsu")
                USE IN cursor_4c_GruposUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, pkchaves" + ;
                " FROM sigcdacg" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_GruposUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarGruposPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresasPorUsuario - Carrega empresas do usuario (sigcdace)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresasPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_EmpresasUsu")
                USE IN cursor_4c_EmpresasUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT e.usuarios, e.emps, e.pkchaves, c.razas" + ;
                " FROM sigcdace e" + ;
                " LEFT JOIN sigcdemp c ON RTRIM(c.cemps) = RTRIM(e.cemps)" + ;
                " WHERE e.usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_EmpresasUsu")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarEmpresasPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarraPorUsuario - Carrega barra de acesso do usuario (sigcdacb)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarraPorUsuario(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Barra")
                USE IN cursor_4c_Barra
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT grupos, usuarios, descricaos, barraforms, barraordem," + ;
                " programas, parametros, selbarras, pkchaves" + ;
                " FROM sigcdacb" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios) + ;
                " ORDER BY barraordem", ;
                "cursor_4c_Barra")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar barra do usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CarregarBarraPorUsuario:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessos - Grava programas marcados em sigcdacu (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorPrg: cursor com programas (campo marcas=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessos(par_cUsuarios, par_cCursorPrg)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga acessos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacu WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcu2")
            IF USED("cursor_4c_DlAcu2")
                USE IN cursor_4c_DlAcu2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Insere apenas os programas marcados
                IF USED(par_cCursorPrg) AND RECCOUNT(par_cCursorPrg) > 0
                    SELECT (par_cCursorPrg)
                    GO TOP
                    SCAN FOR marcas = 1
                        loc_cPK = ALLTRIM(usuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))     + "," + ;
                            EscaparSQL(ALLTRIM(parametros)) + "," + ;
                            EscaparSQL(ALLTRIM(programas))  + "," + ;
                            EscaparSQL(par_cUsuarios)       + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 45))   + ;
                            ")", "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir acesso:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Grava grupos marcados em sigcdacg (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorGru: cursor com grupos (campo marca=1 = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGrupos(par_cUsuarios, par_cCursorGru)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            *-- Apaga grupos existentes do usuario
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacg WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcg2")
            IF USED("cursor_4c_DlAcg2")
                USE IN cursor_4c_DlAcg2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorGru) AND RECCOUNT(par_cCursorGru) > 0
                    SELECT (par_cCursorGru)
                    GO TOP
                    SCAN FOR marca = 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos)) + "," + ;
                            EscaparSQL(par_cUsuarios)   + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20)) + ;
                            ")", "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarGrupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarEmpresas - Grava empresas marcadas em sigcdace (substitui todas)
    * par_cUsuarios: codigo do usuario
    * par_cCursorEmp: cursor com empresas (campo marcas=.T. = tem acesso)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarEmpresas(par_cUsuarios, par_cCursorEmp)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdace WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAce2")
            IF USED("cursor_4c_DlAce2")
                USE IN cursor_4c_DlAce2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorEmp) AND RECCOUNT(par_cCursorEmp) > 0
                    SELECT (par_cCursorEmp)
                    GO TOP
                    SCAN FOR marcas
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(emps)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(ALLTRIM(emps))        + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 13))    + ;
                            ")", "cursor_4c_InsAce")
                        IF USED("cursor_4c_InsAce")
                            USE IN cursor_4c_InsAce
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Grava barra selecionada em sigcdacb (substitui todos)
    * par_cUsuarios: codigo do usuario
    * par_cCursorBarra: cursor TmpBarra com campos SelBarras, Usuarios, etc.
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cUsuarios, par_cCursorBarra)
        LOCAL loc_lSucesso, loc_nResultado, loc_cPK, loc_nOrdem
        loc_lSucesso = .F.
        loc_nOrdem   = 0

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "DELETE FROM sigcdacb WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_DlAcb2")
            IF USED("cursor_4c_DlAcb2")
                USE IN cursor_4c_DlAcb2
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                    SELECT (par_cCursorBarra)
                    SET ORDER TO BarraOrdem
                    GO TOP
                    SCAN FOR !EMPTY(ALLTRIM(usuarios))
                        loc_nOrdem = loc_nOrdem + 1
                        loc_cPK = ALLTRIM(par_cUsuarios) + ALLTRIM(grupos) + ;
                                  ALLTRIM(programas) + ALLTRIM(parametros)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + ;
                            EscaparSQL(ALLTRIM(grupos))      + "," + ;
                            EscaparSQL(par_cUsuarios)        + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(descricaos), 73)) + "," + ;
                            EscaparSQL(LEFT(ALLTRIM(barraforms), 50)) + "," + ;
                            FormatarNumeroSQL(loc_nOrdem)    + "," + ;
                            EscaparSQL(ALLTRIM(programas))   + "," + ;
                            EscaparSQL(ALLTRIM(parametros))  + "," + ;
                            IIF(selbarras, "1", "0")         + "," + ;
                            EscaparSQL(LEFT(loc_cPK, 20))    + ;
                            ")", "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResultado < 0
                            MsgErro("Erro ao inserir barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.SalvarBarra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparSenha - Reseta a senha do usuario para vazio
    *--------------------------------------------------------------------------
    PROCEDURE LimparSenha(par_cUsuarios)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "UPDATE sigcdusu SET senhas = ''" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_LimSen")
            IF USED("cursor_4c_LimSen")
                USE IN cursor_4c_LimSen
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE-SENHA")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao limpar senha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.LimparSenha:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarUsuarioExistente - Verifica se um usuario ja esta cadastrado
    *--------------------------------------------------------------------------
    PROCEDURE VerificarUsuarioExistente(par_cUsuarios)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_VerUsu")
                USE IN cursor_4c_VerUsu
            ENDIF
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 usuarios FROM sigcdusu" + ;
                " WHERE usuarios = " + EscaparSQL(par_cUsuarios), ;
                "cursor_4c_VerUsu")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VerUsu") > 0
                loc_lExiste = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.VerificarUsuarioExistente:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VerUsu")
            USE IN cursor_4c_VerUsu
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia acessos de um usuario para outro
    * par_cUsuOri: usuario de origem
    * par_cUsuDes: usuario de destino
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cUsuOri, par_cUsuDes)
        LOCAL loc_lSucesso, loc_nResultado
        loc_lSucesso = .F.

        TRY
            *-- Copiar sigcdacu (programas/acessos)
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "INSERT INTO sigcdacu (grupos, parametros, programas, usuarios, pkchaves)" + ;
                " SELECT a.grupos, a.parametros, a.programas," + ;
                " " + EscaparSQL(par_cUsuDes) + "," + ;
                " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                " AND a.programas + a.parametros NOT IN" + ;
                " (SELECT b.programas + b.parametros FROM sigcdacu b" + ;
                "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            IF loc_nResultado < 0
                MsgErro("Erro ao copiar acessos (acu):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                *-- Copiar sigcdacg (grupos)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                    " SELECT a.grupos," + ;
                    " " + EscaparSQL(par_cUsuDes) + "," + ;
                    " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos, 20)" + ;
                    " FROM sigcdacg a" + ;
                    " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                    " AND a.grupos NOT IN" + ;
                    " (SELECT b.grupos FROM sigcdacg b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                    "cursor_4c_CpAcg")
                IF USED("cursor_4c_CpAcg")
                    USE IN cursor_4c_CpAcg
                ENDIF

                IF loc_nResultado < 0
                    MsgErro("Erro ao copiar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Copiar sigcdace (empresas)
                    loc_nResultado = SQLEXEC(gnConnHandle, ;
                        "INSERT INTO sigcdace (usuarios, emps, pkchaves)" + ;
                        " SELECT " + EscaparSQL(par_cUsuDes) + ", a.emps," + ;
                        " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.emps, 13)" + ;
                        " FROM sigcdace a" + ;
                        " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                        " AND a.emps NOT IN" + ;
                        " (SELECT b.emps FROM sigcdace b WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                        "cursor_4c_CpAce")
                    IF USED("cursor_4c_CpAce")
                        USE IN cursor_4c_CpAce
                    ENDIF

                    IF loc_nResultado < 0
                        MsgErro("Erro ao copiar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Copiar sigcdacb (barra)
                        loc_nResultado = SQLEXEC(gnConnHandle, ;
                            "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem," + ;
                            "  programas, parametros, selbarras, pkchaves)" + ;
                            " SELECT a.grupos, " + EscaparSQL(par_cUsuDes) + "," + ;
                            " a.descricaos, a.barraforms, a.barraordem," + ;
                            " a.programas, a.parametros, a.selbarras," + ;
                            " LEFT(" + EscaparSQL(par_cUsuDes) + " + a.grupos + a.programas + a.parametros, 20)" + ;
                            " FROM sigcdacb a" + ;
                            " WHERE a.usuarios = " + EscaparSQL(par_cUsuOri) + ;
                            " AND a.programas + a.parametros NOT IN" + ;
                            " (SELECT b.programas + b.parametros FROM sigcdacb b" + ;
                            "  WHERE b.usuarios = " + EscaparSQL(par_cUsuDes) + ")", ;
                            "cursor_4c_CpAcb")
                        IF USED("cursor_4c_CpAcb")
                            USE IN cursor_4c_CpAcb
                        ENDIF

                        IF loc_nResultado < 0
                            MsgErro("Erro ao copiar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em acuBO.CopiarAcessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

