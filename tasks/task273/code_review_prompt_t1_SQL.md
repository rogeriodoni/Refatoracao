# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (15)
- [GRID-SQL] Campo 'Emps' usado em ControlSource de cursor_4c_Pendentes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dopes' usado em ControlSource de cursor_4c_Pendentes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Numes' usado em ControlSource de cursor_4c_Pendentes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Grupos' usado em ControlSource de cursor_4c_Pendentes mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Cpros' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dpros' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Units' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Qtds' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtBaixas' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'QtReservas' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Saldo' usado em ControlSource de cursor_4c_Movimentos mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTDOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SALDO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN

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
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
lnOldSel = Select()
	lcNota   	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/nNF").Text
	lcSerie  	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/serie").Text
	lcEmis 	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/dhEmi").Text
	lcUf	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/cUF").Text
	lcNatOp  	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/natOp").Text
	lcCodMun 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/ide/cMunFG").Text
	lcEmissor 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/xNome").Text
	lcCnpj		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/CNPJ").Text
	lcIe 	 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/IE").Text
	lcCrt		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/CRT").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/CRT").Text, '')
	lcEndes	 	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xLgr").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xLgr").Text, '')
	lcNumero	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/nro").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/nro").Text, '')
	lcBairro	= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xBairro").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xBairro").Text, '')
	lcCmun		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/cMun").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/cMun").Text, '')
	lcMunic		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xMun").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xMun").Text, '')
	lcEstas		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/UF").Length > 0		,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/UF").Text, '')
	lcCEP		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/CEP").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/CEP").Text, '')
	lcPais		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/xPais").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/xPais").Text, '')
	lcFone		= Iif(OXML.SelectNodes("//nfeProc/NFe/infNFe/emit/enderEmit/fone").Length > 0	,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/emit/enderEmit/fone").Text, '')
	lcDest		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/xNome").Text
	lcCNPJDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/CNPJ").Text
	lcIEDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/IE").Text
	lcEndDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xLgr").Text
	lcNumDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/nro").Text
	lcBaiDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xBairro").Text
	lcCMunDest 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/cMun").Text
	lcMunicDest = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xMun").Text
	lcUfDest	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/UF").Text
	lcCEPDest	= Iif(OXML.SelectNodes("/nfeProc/NFe/infNFe/dest/enderDest/CEP").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/CEP").Text, '')
	lcPaisDest	= Iif(OXML.SelectNodes("/nfeProc/NFe/infNFe/dest/enderDest/xPais").Length > 0,OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/dest/enderDest/xPais").Text, '')
	lcBaseCalc 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vBC").Text
	lcICMS 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vICMS").Text
	lcBaseST 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vBCST").Text
	lcICMSST 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vST").Text
	lcValorUnit = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vProd").Text
	lcFrete 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vFrete").Text
	lcSeguro 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vSeg").Text
	lcDescontos = OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vDesc").Text
	lcIImport 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vII").Text
	lcIPI 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vIPI").Text
	lcPIS 		= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vPIS").Text
	lcCOFINS 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vCOFINS").Text
	lcOUTROS 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vOutro").Text
	lcVTOTAL 	= OXML.SELECTSINGLENODE("/nfeProc/NFe/infNFe/total/ICMSTot/vNF").Text
	lcChave		= OXML.SELECTSINGLENODE("/nfeProc/protNFe/infProt/chNFe").Text
	Select crItens
	qt_itens = OXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length && conta quantidade de itens na nota
		oXmlTemp = OXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(i)
		Replace codigo		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").Item(i).Text
		Replace Descr		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").Item(i).Text
		Replace quant		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").Item(i).Text
		Replace valor_uni	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").Item(i).Text
		Replace valor_tot	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").Item(i).Text
		Replace unid		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").Item(i).Text
		Replace cfop		With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").Item(i).Text
		Replace ncm			With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").Item(i).Text
		If oXmlTemp.SelectNodes("prod/vDesc").Length > 0
			Replace desconto	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").Item(lnContaDesconto).Text
		If oXmlTemp.SelectNodes("prod/vFrete").Length > 0
			Replace frete	With OXML.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").Item(i).Text
Select(lnOldSel)
lnOldSel = Select()
Select crItens
		lcQuery = [Select * From SigCdPro Where Reffs = '] + lcProd + [']
		If (Thisform.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
		Select ProdImport
			lcQuery = [Select * From SigCdPro Where Cpros = '] + lcProd + [']
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
		Select ProdImport
			lcQuery = [Select * From SigCdPro Where dpros = '] + lcProd + [']
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
		Select ProdImport
			lcQuery = [Select * From SigCdPro Where dpro2s = '] + lcProd + [']
			If (Thisform.poDataMgr.SqlExecute(lcQuery, 'ProdImport') < 1)
			lcQuery = [Select * From SigCdUni Where CUnis = '] + lcCunis + [' Order By Etiqs]
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpUni') < 1)
			lcQuery = [Select TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr ] + ;
					    [From SigCdGrp ] + ;
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpGru') < 1)
				lcQuery = [Select * From SigCdTam Where Cods = ']+lcTam+[' ]
				If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpTam') < 1)
				Select crTmpTam
				lcQuery = [Select * From SigCdCor Where Cods = ']+lcCor+[' ]
				If (Thisform.poDataMgr.SqlExecute(lcQuery, 'crTmpCor') < 1)
				Select crTmpCor
			Select crResultado 
			Select csPrNAOCad
	Select crItens
Select csPrNAOCad
	Select csPrNAOCad
Select crItens
lcQuery = [Select 0 as nMarca, a.Emps, a.Dopes, a.Numes, a.EmpDopNums as OriDopNums, a.grupoOs as Grupos, a.contaOs as Contas From SigMvCab a ] + ;
	[join sigcdope b on a.dopes = b.dopes ] + ;
	[join SigOpCdd c on b.dopes = c.dopes ] + ;
If Thisform.podatamgr.SqlExecute(lcQuery,'csSigPrCtr') < 1
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column2.ControlSource = [csSigPrCtr.Emps]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column3.ControlSource = [csSigPrCtr.Dopes]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column4.ControlSource = [csSigPrCtr.Numes]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column5.ControlSource = [csSigPrCtr.Grupos]
Thisform.pagina.dados.pageframe1.page1.grdEstoque.column6.ControlSource = [csSigPrCtr.Contas]
Select crSigPrCtr
If Not ThisForm.poDataMgr.Update('crSigPrCtr')
	If (ThisForm.poDataMgr.SQLExecute([Delete From SigPrCtr Where Codigos = ?_Codigo], '') < 1)
	If Not ThisForm.poDataMgr.Update('crSigPrCtr')
		lcQueryLista = [Select Distinct a.Codigos, max(a.Datas) as Datas, a.OriDopNums, a.Usuars, a.contas, b.rclis ] + ;
							[from SigPrCtr a ] + ;
							[join SigCdCli b on a.contas = b.iclis where Datas Between ?ldDatai And ?ldDataF ] + ; 
		lcQueryPrCtr = [Select * from SigPrCtr where Codigos = ?_Codigo]
		lcSql = [Select * From SigCdPam ]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdPam')
		lcSql = [Select * From SigCdPac ]
		.poDataMgr.Sqlexecute(lcsql,'crSigCdPac')
		Select crSigCdCot
		Select crSigCdMoe
	Select TmpSigPrCtr
		Select 0
		Select a.Cpros, f.Dpros, a.units, 
			from SigmvItn a 
			join SigMvCab c on a.EmpDopNums = c.EmpDopNums
			join sigcdope d on c.dopes = d.dopes
			join SigOpCdd e on d.dopes = e.dopes
			Join SigCdpro f on a.Cpros = f.Cpros
			join sigprctr g on a.empdopnums = g.oridopnums and a.cpros = g.cpros and g.fkchaves = a.cidchaves 
	If Thisform.podatamgr.SqlExecute(lcSQL, [crMovimentos] ) < 1
		Messagebox( [Problemas no Select dos Produtos da Movimentação], 48, "Atenção" )
	Select crMovimentos
	Select crMovimentos
	Select Cpros, Dpros, Sum(qtdos) as Qtds, Max(Units) as Units, 0 as Total ;
	from crMovimentos ;
	Select crDistribui
Select TmpSigPrCtr
	Select crSigPrCtr
	Select crMovimentos
	Select crDistribui
	Select a.cpros, a.dpros, a.qtds, a.qtbaixas, a.qtreservas, a.saldo, a.oridopnums, b.qtds As qtdXml, a.cidchaves ;
	from crMovimentos a ;
	join crdistribui b on a.cpros = b.cpros ;
	Select TmpPrCtr 	
		Insert Into crSigPrCtr (Codigos, Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, Contas, Arquivo, Moedas, Precific, fkChaves) Values ;
		lcUpdate = [Update SigMvItn set qtReservas = (qtReservas + ?lnQtd ) where cidchaves = ']+TmpPrCtr.CidChaves+[' ]
		If Thisform.podatamgr.SqlExecute(lcUpdate) < 1
			Messagebox( [Problemas no Update dos Produtos da Movimentação], 48, "Atenção" )
		Select TmpPrCtr 
		Select crMovimentos
		Select crDistribui
		Select crMovimentos
		lcQuery = [Select * From SigMvItn Where EmpDopNums = ']+crMovimentos.oridopnums+[' ]
		If Thisform.podatamgr.SqlExecute(lcQuery,[crTmpItn]) < 1
			Messagebox( [Problemas no Select dos Produtos da Movimentação], 48, "Atenção" )
		Select crTmpItn
		Select a.cpros, a.dpros, a.qtds, a.qtbaixas, a.qtreservas, a.oridopnums, b.qtds As qtdXml, a.cidchaves ;
		from crMovimentos a ;
		join crdistribui b on a.cpros = b.cpros ;
		Select TmpPrCtrEx 	
			If Seek(TmpPrCtrEx.CidChaves,[crTmpItn],[cidchaves])
			lcUpdate = [Update SigMvItn set qtReservas = ?lnQtd where cidchaves = ']+TmpPrCtrEx.CidChaves+[' ]
			If Thisform.podatamgr.SqlExecute(lcUpdate) < 1
				Messagebox( [Problemas no Update dos Produtos da Movimentação], 48, "Atenção" )
			Select TmpPrCtrEx 
Select csSigPrCtr
Select 0
Select csSigPrCtr
	Select a.Cpros, f.Dpros, a.units, Sum(a.qtds) as qtds, Sum(a.qtbaixas) As qtbaixas, Sum(a.qtreservas) As qtreservas, (Sum(a.qtds) - Sum(a.qtbaixas) - Sum(a.qtreservas)) as Saldo, 
		from SigmvItn a 
		join SigMvCab c on a.EmpDopNums = c.EmpDopNums
		join sigcdope d on c.dopes = d.dopes
		join SigOpCdd e on d.dopes = e.dopes
		Join SigCdpro f on a.Cpros = f.Cpros
If Thisform.podatamgr.SqlExecute(lcSQL, [crMovimentos] ) < 1
	Messagebox( [Problemas no Select dos Produtos da Movimentação], 48, "Atenção" )
Select crMovimentos
Select crItens
Select csPrNAOCad
Select crResultado
Select crResultado 
Select Cpros, Dpros, Sum(Qtds) as Qtds, Max(Units) as Units, Sum(Total) as Total ;
from crResultado ;
Select crDistribui
Select crMovimentos
		Delete From crMovimentos where Cpros Not In (Select Cpros from crDistribui)
	Delete From crMovimentos where Cpros In (Select Cpros from crDistribui)
Scan for !Deleted()
	Select crMovimentos
		Select CqSigCdCli
Select csSigPrCtr
Select csSigPrCtr
Select csSigPrCtr
Select csSigPrCtr
Select csSigPrCtr
	lcSql = [Select Dopes From SigCdOpe Where Dopes = ']+csSigPrCtr.Dopes+[']
	If thisform.Podatamgr.SqlExecute(lcsql,'TmpOpe') > 0 And Reccount('TmpOpe') > 0
		lcSql = [Select Dopps From SigCdOpd Where Dopps = ']+csSigPrCtr.Dopes+[']
		If Thisform.Podatamgr.SqlExecute(lcsql,'TmpOpp') > 0 And Reccount('TmpOpp') > 0
m.SelectPro   = [Select a.cpros,a.cgrus,a.dpros,a.sgrus,a.cunis,a.cunips,a.ifors,a.reffs,a.qmins,a.valors,a.moedas,a.icms,]+;
	[From SigCdPro a ]+;
	[Left Join SigCdGrp g On a.cgrus = g.cgrus ]+;
	[Left Join SigCdUni u On a.cunis = u.cunis ]+;
	[Left Join SigCdCol b On a.colecoes = b.colecoes ]+;
	[Left Join SigCdLin l On a.linhas = l.linhas ]+;
	[Left Join SigPrFti f On a.cftios = f.cods ]+;
	[Left Join SigCdCli c On a.ifors = c.iclis ]+;
	[Left Join SigCdGpr h On a.Mercs= h.codigos ]+;
	[left join SigCdFip i On a.CodFinP = i.Cods ]+;
lnQueryOk = Thisform.poDataMgr.SqlExecute(m.SelectPro,'CrTSigPro')
Select CrTSigPro
If Thisform.poDataMgr.SqlExecute([Select s.codigos,s.descricaos From SigCdPsg s Where s.cgrus = ']+lcCodGru+[' And s.codigos = ']+lcCodSgru+[' ],'Tmp_Sgru') < 1
	Select CrTSigPro
		Select CrSigCdCot
		Select CrSigCdCot
Select crMovimentos
lcSql = [Select a.cpros,a.FigJpgs From SigCdPro a Where a.cpros = ']+lcCodPro+[' ]
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrTmpPro')
	Select crMovimentos
		Delete
	Select crDistribui
		Delete
	Select crMovimentos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3681 linhas total):

*-- Linhas 428 a 446:
428:             .HighlightBackColor = RGB(255, 255, 255)
429:             .HighlightForeColor = RGB(15, 41, 104)
430:             .HighlightStyle     = 2
431:             .DeleteMark         = .F.
432:             .RecordMark         = .F.
433:             .RowHeight          = 16
434:             .ScrollBars         = 2
435:             .GridLines          = 3
436:             .Visible            = .T.
437:             .Column1.Width = 80
438:             .Column2.Width = 90
439:             .Column3.Width = 90
440:             .Column4.Width = 320
441:             .Column5.Width = 120
442:             .Column6.Width = 120
443:         ENDWITH
444: 
445:         THIS.TornarControlesVisiveis(loc_oPagina)
446:     ENDPROC

*-- Linhas 868 a 886:
868:             .GridLineColor     = RGB(238, 238, 238)
869:             .AllowHeaderSizing = .F.
870:             .AllowRowSizing    = .F.
871:             .DeleteMark        = .F.
872:             .RecordMark        = .F.
873:             .RowHeight         = 16
874:             .ScrollBars        = 2
875:             .Visible           = .T.
876:             .Column1.Width = 70
877:             .Column1.Header1.Caption = "Empresa"
878:             .Column2.Width = 200
879:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
880:             .Column3.Width = 80
881:             .Column3.Header1.Caption = "Numero"
882:             .Column4.Width = 80
883:             .Column4.Header1.Caption = "Grupo"
884:             .Column5.Width = 80
885:             .Column5.Header1.Caption = "Conta"
886:             .Column4.ReadOnly = .T.

*-- Linhas 1147 a 1167:
1147:         THIS.CarregarLista()
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * BtnSalvarClick - Grava o lote: monta cursor_4c_Linhas a partir do JOIN
1152:     * de cursor_4c_Movimentos x cursor_4c_Distribui, entao chama Salvar()
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnSalvarClick()
1155:         LOCAL loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc
1156:         LOCAL loc_oPg2P1, loc_nQtdOs, loc_lSalvoOK, loc_oErro
1157:         loc_cConta   = ""
1158:         loc_cArquivo = ""
1159:         loc_cMoeda   = ""
1160:         loc_nOpc     = 0
1161:         loc_lSalvoOK = .F.
1162:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1163: 
1164:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1165:             loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1166:         ENDIF
1167:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)

*-- Linhas 1178 a 1250:
1178:             MsgAviso("Informe o fornecedor antes de salvar.", ;
1179:                      "Campo Obrigat" + CHR(243) + "rio")
1180:             RETURN
1181:         ENDIF
1182: 
1183:         IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
1184:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " movimentos para gravar.", "Aviso")
1185:             RETURN
1186:         ENDIF
1187: 
1188:         IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
1189:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " distribui" + CHR(231) + CHR(227) + ;
1190:                      "o para gravar.", "Aviso")
1191:             RETURN
1192:         ENDIF
1193: 
1194:         TRY
1195:             *-- Monta cursor_4c_Linhas: JOIN movimentos x distribui onde qtd > 0 e saldo > 0
1196:             IF USED("cursor_4c_TmpJoin")
1197:                 USE IN cursor_4c_TmpJoin
1198:             ENDIF
1199: 
1200:             SELECT a.Cpros, a.Qtds, a.OriDopNums, a.CidChaves, b.Qtds AS QtdXml ;
1201:                 FROM cursor_4c_Movimentos a ;
1202:                 JOIN cursor_4c_Distribui b ON ALLTRIM(a.Cpros) = ALLTRIM(b.Cpros) ;
1203:                 WHERE b.Qtds <> 0 AND a.Saldo > 0 ;
1204:                 INTO CURSOR cursor_4c_TmpJoin READWRITE
1205: 
1206:             IF USED("cursor_4c_Linhas")
1207:                 ZAP IN cursor_4c_Linhas
1208:             ELSE
1209:                 CREATE CURSOR cursor_4c_Linhas ;
1210:                     (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
1211:                      OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
1212:                      Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
1213:                      Precific N(12,2), FkChaves C(20))
1214:             ENDIF
1215: 
1216:             IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
1217:                 SELECT cursor_4c_TmpJoin
1218:                 GO TOP
1219:                 SCAN
1220:                     loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
1221:                                      cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
1222:                     INSERT INTO cursor_4c_Linhas ;
1223:                         (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
1224:                          Contas, Arquivo, Moedas, Precific, FkChaves) ;
1225:                         VALUES ;
1226:                         (cursor_4c_TmpJoin.Cpros, "", "", cursor_4c_TmpJoin.OriDopNums, ;
1227:                          cursor_4c_TmpJoin.Qtds, loc_nQtdOs, ;
1228:                          loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc, ;
1229:                          cursor_4c_TmpJoin.CidChaves)
1230:                     SELECT cursor_4c_TmpJoin
1231:                 ENDSCAN
1232:             ENDIF
1233: 
1234:             IF USED("cursor_4c_TmpJoin")
1235:                 USE IN cursor_4c_TmpJoin
1236:             ENDIF
1237: 
1238:             IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
1239:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " linhas v" + CHR(225) + ;
1240:                          "lidas para gravar (verifique saldo e distribui" + CHR(231) + CHR(227) + "o).", ;
1241:                          "Aviso")
1242:             ELSE
1243:                 THIS.FormParaBO()
1244:                 IF THIS.this_oBusinessObject.Salvar()
1245:                     MsgInfo("Lote gravado com sucesso!", "Sucesso")
1246:                     loc_lSalvoOK = .T.
1247:                 ENDIF
1248:             ENDIF
1249:         CATCH TO loc_oErro
1250:             MsgErro("Erro em FormSigPrCtr.BtnSalvarClick:" + CHR(13) + ;

*-- Linhas 1462 a 1485:
1462:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1463: 
1464:                         WITH loc_oGrid
1465:                             .Column1.ControlSource = "cursor_4c_Dados.Codigos"
1466:                             .Column2.ControlSource = "cursor_4c_Dados.Datas"
1467:                             .Column3.ControlSource = "cursor_4c_Dados.Contas"
1468:                             .Column4.ControlSource = "cursor_4c_Dados.Rclis"
1469:                             .Column5.ControlSource = "cursor_4c_Dados.Usuars"
1470:                             .Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1471: 
1472:                             .Column1.Header1.Caption = "Lote"
1473:                             .Column2.Header1.Caption = "Data"
1474:                             .Column3.Header1.Caption = "Conta"
1475:                             .Column4.Header1.Caption = "Fornecedor"
1476:                             .Column5.Header1.Caption = "Usu" + CHR(225) + "rio"
1477:                             .Column6.Header1.Caption = "Origem"
1478:                         ENDWITH
1479: 
1480:                         THIS.FormatarGridLista(loc_oGrid)
1481:                     ENDIF
1482: 
1483:                     loc_lResultado = .T.
1484:                 ENDIF
1485:             ENDIF

*-- Linhas 1565 a 1591:
1565:             IF USED("cursor_4c_BuscaGrp")
1566:                 USE IN cursor_4c_BuscaGrp
1567:             ENDIF
1568:             =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1569:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1570:                 "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
1571:             IF VARTYPE(loc_oBusca) = "O"
1572:                 IF !loc_oBusca.this_lSelecionou
1573:                     IF USED("cursor_4c_BuscaGrp")
1574:                         USE IN cursor_4c_BuscaGrp
1575:                     ENDIF
1576:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1577:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1578:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1579:                     loc_oBusca.Show()
1580:                 ENDIF
1581:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1582:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1583:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1584:                 ENDIF
1585:                 IF USED("cursor_4c_BuscaGrp")
1586:                     USE IN cursor_4c_BuscaGrp
1587:                 ENDIF
1588:                 loc_oBusca.Release()
1589:             ENDIF
1590:         CATCH TO loc_oErro
1591:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1622 a 1648:
1622:             IF USED("cursor_4c_BuscaCli")
1623:                 USE IN cursor_4c_BuscaCli
1624:             ENDIF
1625:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1626:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1627:                 "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1628:             IF VARTYPE(loc_oBusca) = "O"
1629:                 IF !loc_oBusca.this_lSelecionou
1630:                     IF USED("cursor_4c_BuscaCli")
1631:                         USE IN cursor_4c_BuscaCli
1632:                     ENDIF
1633:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1634:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1635:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1636:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1637:                     loc_oBusca.Show()
1638:                 ENDIF
1639:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1640:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1641:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1642:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1643:                     ENDIF
1644:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1645:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1646:                     ENDIF
1647:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1648:                 ENDIF

*-- Linhas 1686 a 1712:
1686:             IF USED("cursor_4c_BuscaCli")
1687:                 USE IN cursor_4c_BuscaCli
1688:             ENDIF
1689:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1690:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1691:                 "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1692:             IF VARTYPE(loc_oBusca) = "O"
1693:                 IF !loc_oBusca.this_lSelecionou
1694:                     IF USED("cursor_4c_BuscaCli")
1695:                         USE IN cursor_4c_BuscaCli
1696:                     ENDIF
1697:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1698:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1699:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1700:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1701:                     loc_oBusca.Show()
1702:                 ENDIF
1703:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1704:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1705:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1706:                     ENDIF
1707:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1708:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1709:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1710:                     ENDIF
1711:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1712:                 ENDIF

*-- Linhas 1750 a 1776:
1750:             IF USED("cursor_4c_BuscaMoe")
1751:                 USE IN cursor_4c_BuscaMoe
1752:             ENDIF
1753:             =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1754:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1755:                 "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
1756:             IF VARTYPE(loc_oBusca) = "O"
1757:                 IF !loc_oBusca.this_lSelecionou
1758:                     IF USED("cursor_4c_BuscaMoe")
1759:                         USE IN cursor_4c_BuscaMoe
1760:                     ENDIF
1761:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1762:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1763:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1764:                     loc_oBusca.Show()
1765:                 ENDIF
1766:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1767:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1768:                 ENDIF
1769:                 IF USED("cursor_4c_BuscaMoe")
1770:                     USE IN cursor_4c_BuscaMoe
1771:                 ENDIF
1772:                 loc_oBusca.Release()
1773:             ENDIF
1774:         CATCH TO loc_oErro
1775:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1776:         ENDTRY

*-- Linhas 1817 a 1838:
1817:             IF USED("cursor_4c_BuscaCli")
1818:                 USE IN cursor_4c_BuscaCli
1819:             ENDIF
1820:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1821:                        " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
1822:                        " ORDER BY Iclis"
1823:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1824: 
1825:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1826:                RECCOUNT("cursor_4c_BuscaCli") > 0
1827:                 loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1828:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1829:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1830:                 ENDIF
1831:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1832:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1833:                 ENDIF
1834:                 IF USED("cursor_4c_BuscaCli")
1835:                     USE IN cursor_4c_BuscaCli
1836:                 ENDIF
1837:                 THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
1838:             ELSE

*-- Linhas 1847 a 1874:
1847:                         IF USED("cursor_4c_BuscaCli")
1848:                             USE IN cursor_4c_BuscaCli
1849:                         ENDIF
1850:                         loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1851:                                    " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
1852:                                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
1853:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
1854:                            !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1855:                             IF USED("cursor_4c_BuscaCli")
1856:                                 USE IN cursor_4c_BuscaCli
1857:                             ENDIF
1858:                             =SQLEXEC(gnConnHandle, ;
1859:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1860:                                 "cursor_4c_BuscaCli")
1861:                         ENDIF
1862:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1863:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1864:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1865:                         loc_oBusca.Show()
1866:                     ENDIF
1867:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1868:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1869:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1870:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1871:                         ENDIF
1872:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1873:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1874:                         ENDIF

*-- Linhas 1927 a 1983:
1927:             IF USED("cursor_4c_BuscaCli")
1928:                 USE IN cursor_4c_BuscaCli
1929:             ENDIF
1930:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1931:                        " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
1932:                        " ORDER BY Rclis"
1933:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1934: 
1935:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1936:                RECCOUNT("cursor_4c_BuscaCli") = 1
1937:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1938:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1939:                 ENDIF
1940:                 loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1941:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1942:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1943:                 ENDIF
1944:                 IF USED("cursor_4c_BuscaCli")
1945:                     USE IN cursor_4c_BuscaCli
1946:                 ENDIF
1947:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1948:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
1949:                 ENDIF
1950:             ELSE
1951:                 *-- Multiplos ou nenhum: abre picker
1952:                 IF !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1953:                     IF USED("cursor_4c_BuscaCli")
1954:                         USE IN cursor_4c_BuscaCli
1955:                     ENDIF
1956:                     =SQLEXEC(gnConnHandle, ;
1957:                         "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
1958:                         "cursor_4c_BuscaCli")
1959:                 ENDIF
1960:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1961:                     "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1962:                 IF VARTYPE(loc_oBusca) = "O"
1963:                     IF !loc_oBusca.this_lSelecionou
1964:                         IF USED("cursor_4c_BuscaCli")
1965:                             USE IN cursor_4c_BuscaCli
1966:                         ENDIF
1967:                         =SQLEXEC(gnConnHandle, ;
1968:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
1969:                             "cursor_4c_BuscaCli")
1970:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1971:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1972:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1973:                         loc_oBusca.Show()
1974:                     ENDIF
1975:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1976:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1977:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1978:                         ENDIF
1979:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1980:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1981:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1982:                         ENDIF
1983:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)

*-- Linhas 2030 a 2051:
2030:             IF USED("cursor_4c_BuscaCli")
2031:                 USE IN cursor_4c_BuscaCli
2032:             ENDIF
2033:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
2034:                        " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
2035:                        " ORDER BY Iclis"
2036:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2037: 
2038:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2039:                RECCOUNT("cursor_4c_BuscaCli") > 0
2040:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2041:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2042:                 ENDIF
2043:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
2044:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2045:                 ENDIF
2046:                 loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2047:                 IF USED("cursor_4c_BuscaCli")
2048:                     USE IN cursor_4c_BuscaCli
2049:                 ENDIF
2050:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2051:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)

*-- Linhas 2084 a 2137:
2084:             IF USED("cursor_4c_BuscaMoe")
2085:                 USE IN cursor_4c_BuscaMoe
2086:             ENDIF
2087:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2088:                        " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
2089:                        " ORDER BY CMoes"
2090:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
2091: 
2092:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
2093:                RECCOUNT("cursor_4c_BuscaMoe") > 0
2094:                 loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2095:                 IF USED("cursor_4c_BuscaMoe")
2096:                     USE IN cursor_4c_BuscaMoe
2097:                 ENDIF
2098:             ELSE
2099:                 IF USED("cursor_4c_BuscaMoe")
2100:                     USE IN cursor_4c_BuscaMoe
2101:                 ENDIF
2102:                 loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2103:                            " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
2104:                            EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
2105:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
2106:                    !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
2107:                     IF USED("cursor_4c_BuscaMoe")
2108:                         USE IN cursor_4c_BuscaMoe
2109:                     ENDIF
2110:                     =SQLEXEC(gnConnHandle, ;
2111:                         "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2112:                         "cursor_4c_BuscaMoe")
2113:                 ENDIF
2114:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2115:                     "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
2116:                 IF VARTYPE(loc_oBusca) = "O"
2117:                     IF !loc_oBusca.this_lSelecionou
2118:                         IF USED("cursor_4c_BuscaMoe")
2119:                             USE IN cursor_4c_BuscaMoe
2120:                         ENDIF
2121:                         =SQLEXEC(gnConnHandle, ;
2122:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2123:                             "cursor_4c_BuscaMoe")
2124:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2125:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2126:                         loc_oBusca.Show()
2127:                     ENDIF
2128:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2129:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2130:                     ELSE
2131:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2132:                     ENDIF
2133:                     IF USED("cursor_4c_BuscaMoe")
2134:                         USE IN cursor_4c_BuscaMoe
2135:                     ENDIF
2136:                     loc_oBusca.Release()
2137:                 ENDIF

*-- Linhas 2217 a 2270:
2217:     * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
2218:     *--------------------------------------------------------------------------
2219:     PROCEDURE CmdOperacaoClick()
2220:         LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro
2221: 
2222:         IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
2223:            RECCOUNT("cursor_4c_Pendentes") = 0
2224:             MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
2225:             RETURN
2226:         ENDIF
2227: 
2228:         TRY
2229:             SELECT cursor_4c_Pendentes
2230:             loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
2231:             loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
2232:             loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)
2233: 
2234:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
2235:                 MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
2236:                 RETURN
2237:             ENDIF
2238: 
2239:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
2240:                        EscaparSQL(loc_cDopes)
2241:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2242: 
2243:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
2244:                RECCOUNT("cursor_4c_TmpOpe") > 0
2245:                 IF USED("cursor_4c_TmpOpe")
2246:                     USE IN cursor_4c_TmpOpe
2247:                 ENDIF
2248:                 DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2249:             ELSE
2250:                 IF USED("cursor_4c_TmpOpe")
2251:                     USE IN cursor_4c_TmpOpe
2252:                 ENDIF
2253:                 loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
2254:                            EscaparSQL(loc_cDopes)
2255:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
2256:                 IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
2257:                    RECCOUNT("cursor_4c_TmpOpd") > 0
2258:                     IF USED("cursor_4c_TmpOpd")
2259:                         USE IN cursor_4c_TmpOpd
2260:                     ENDIF
2261:                     DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2262:                 ELSE
2263:                     IF USED("cursor_4c_TmpOpd")
2264:                         USE IN cursor_4c_TmpOpd
2265:                     ENDIF
2266:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2267:                              "o encontrada no cadastro.", "Aviso")
2268:                 ENDIF
2269:             ENDIF
2270:         CATCH TO loc_oErro

*-- Linhas 2349 a 2459:
2349:             ENDIF
2350: 
2351:             *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
2352:             IF !loc_lAbortou
2353:                 loc_cListaOriDopNums = ""
2354:                 IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0
2355:                     SELECT cursor_4c_Pendentes
2356:                     GO TOP
2357:                     SCAN
2358:                         loc_cListaOriDopNums = loc_cListaOriDopNums + ;
2359:                             IIF(EMPTY(loc_cListaOriDopNums), "", ",") + ;
2360:                             EscaparSQL(ALLTRIM(cursor_4c_Pendentes.OriDopNums))
2361:                     ENDSCAN
2362:                 ENDIF
2363:             ENDIF
2364: 
2365:             *-- Passo 4: busca estoque de distribuicao via SigMvItn
2366:             IF !loc_lAbortou
2367:                 IF USED("cursor_4c_Movimentos")
2368:                     USE IN cursor_4c_Movimentos
2369:                 ENDIF
2370:             ENDIF
2371: 
2372:             IF !loc_lAbortou AND !EMPTY(loc_cListaOriDopNums)
2373:                 loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
2374:                            " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
2375:                            " SUM(a.QtReservas) AS QtReservas," + ;
2376:                            " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
2377:                            " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
2378:                            " a.CidChaves, a.Moedas" + ;
2379:                            " FROM SigMvItn a" + ;
2380:                            " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
2381:                            " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
2382:                            " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
2383:                            " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
2384:                            " WHERE e.Distribui = 3" + ;
2385:                            " AND c.GrupoOs <> SPACE(10) AND c.ContaOs <> SPACE(10)" + ;
2386:                            " AND a.CItem2 = 0 AND a.Qtds <> a.QtBaixas" + ;
2387:                            " AND a.EmpDopNums IN (" + loc_cListaOriDopNums + ")" + ;
2388:                            " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
2389:                            "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"
2390:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
2391:                 IF loc_nResult < 0
2392:                     MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
2393:                     loc_lAbortou = .T.
2394:                 ELSE
2395:                     GO TOP IN cursor_4c_Movimentos
2396:                 ENDIF
2397:             ENDIF
2398: 
2399:             IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
2400:                 loc_cListaOriDopNums = ""  && keep var in scope
2401:                 CREATE CURSOR cursor_4c_Movimentos ;
2402:                     ( Cpros C(14), Dpros C(30), Units N(12,4), ;
2403:                       Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
2404:                       OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
2405:                       CidChaves C(20), Moedas C(3) )
2406:             ENDIF
2407: 
2408:             *-- Passo 5: aplica filtro Opt_Fil
2409:             loc_nTipo = 3
2410:             IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
2411:                 loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
2412:             ENDIF
2413: 
2414:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
2415:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
2416:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
2417:                 IF USED("cursor_4c_MovFiltro")
2418:                     USE IN cursor_4c_MovFiltro
2419:                 ENDIF
2420:                 IF loc_nTipo = 1
2421:                     SELECT * FROM cursor_4c_Movimentos ;
2422:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2423:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2424:                 ELSE
2425:                     SELECT * FROM cursor_4c_Movimentos ;
2426:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2427:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2428:                 ENDIF
2429:                 IF USED("cursor_4c_Movimentos")
2430:                     USE IN cursor_4c_Movimentos
2431:                 ENDIF
2432:                 IF USED("cursor_4c_MovFiltro")
2433:                     SELECT * FROM cursor_4c_MovFiltro ;
2434:                         INTO CURSOR cursor_4c_Movimentos READWRITE
2435:                     USE IN cursor_4c_MovFiltro
2436:                     GO TOP IN cursor_4c_Movimentos
2437:                 ENDIF
2438:             ENDIF
2439: 
2440:             *-- Passo 6: vincula grids de Page2 e muda para ela
2441:             IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
2442:                 WITH loc_oPgDados.Page2.grd_4c_Disponivel
2443:                     .RecordSourceType = 1
2444:                     .RecordSource     = "cursor_4c_Movimentos"
2445:                 ENDWITH
2446:             ENDIF
2447:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2448:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2449:                     .RecordSourceType = 1
2450:                     .RecordSource     = "cursor_4c_Distribui"
2451:                 ENDWITH
2452:             ENDIF
2453:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2454:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2455:             ENDIF
2456:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2457:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2458:             ENDIF
2459:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)

*-- Linhas 2481 a 2499:
2481:             IF USED("cursor_4c_Itens")
2482:                 USE IN cursor_4c_Itens
2483:             ENDIF
2484:             CREATE CURSOR cursor_4c_Itens ;
2485:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2486:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2487:                   desconto C(15), frete C(15) )
2488: 
2489:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2490:             IF VARTYPE(loc_oXML) != "O"
2491:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2492:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2493:             ELSE
2494:                 loc_oXML.async = .F.
2495:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2496: 
2497:                 IF !loc_oXML.Load(par_cArquivo)
2498:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;
2499:                             " corrompido.", "Erro XML")

*-- Linhas 2505 a 2551:
2505:                             CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
2506:                     WAIT CLEAR
2507:                 ELSE
2508:                     loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2509:                     FOR loc_i = 0 TO loc_nItems - 1
2510:                         loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
2511:                         APPEND BLANK IN cursor_4c_Itens
2512:                         REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
2513:                                 IN cursor_4c_Itens
2514:                         REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
2515:                                 IN cursor_4c_Itens
2516:                         REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
2517:                                 IN cursor_4c_Itens
2518:                         REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
2519:                                 IN cursor_4c_Itens
2520:                         REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
2521:                                 IN cursor_4c_Itens
2522:                         REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
2523:                                 IN cursor_4c_Itens
2524:                         REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
2525:                                 IN cursor_4c_Itens
2526:                         REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
2527:                                 IN cursor_4c_Itens
2528:                         IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
2529:                             REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;
2530:                                     IN cursor_4c_Itens
2531:                         ENDIF
2532:                         IF loc_oNode.SelectNodes("prod/vFrete").Length > 0
2533:                             REPLACE frete WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vFrete")), 15) ;
2534:                                     IN cursor_4c_Itens
2535:                         ENDIF
2536:                         SELECT cursor_4c_Itens
2537:                     ENDFOR
2538: 
2539:                     WAIT CLEAR
2540:                     GO TOP IN cursor_4c_Itens
2541:                     loc_lResultado = .T.
2542:                     ENDIF
2543:                 ENDIF
2544:             ENDIF
2545: 
2546:         CATCH TO loc_oErro
2547:             WAIT CLEAR
2548:             MsgErro("Erro em FormSigPrCtr.ProcessarArquivoXML:" + CHR(13) + ;
2549:                     loc_oErro.Message, "Erro")
2550:         ENDTRY
2551: 

*-- Linhas 2562 a 2651:
2562:         IF USED("cursor_4c_Distribui")
2563:             USE IN cursor_4c_Distribui
2564:         ENDIF
2565:         CREATE CURSOR cursor_4c_Distribui ;
2566:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2567: 
2568:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2569:             RETURN
2570:         ENDIF
2571: 
2572:         TRY
2573:             SELECT cursor_4c_Itens
2574:             GO TOP
2575: 
2576:             SCAN
2577:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2578:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2579:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2580:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))
2581: 
2582:                 IF !EMPTY(loc_cCodigo)
2583:                     IF USED("cursor_4c_ProdImport")
2584:                         USE IN cursor_4c_ProdImport
2585:                     ENDIF
2586: 
2587:                     loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2588:                                " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
2589:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2590: 
2591:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2592:                        RECCOUNT("cursor_4c_ProdImport") = 0
2593:                         IF USED("cursor_4c_ProdImport")
2594:                             USE IN cursor_4c_ProdImport
2595:                         ENDIF
2596:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2597:                                    " WHERE Cpros = " + EscaparSQL(loc_cCodigo)
2598:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2599:                     ENDIF
2600: 
2601:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2602:                        RECCOUNT("cursor_4c_ProdImport") = 0
2603:                         IF USED("cursor_4c_ProdImport")
2604:                             USE IN cursor_4c_ProdImport
2605:                         ENDIF
2606:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2607:                                    " WHERE Dpros = " + EscaparSQL(loc_cCodigo)
2608:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2609:                     ENDIF
2610: 
2611:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2612:                        RECCOUNT("cursor_4c_ProdImport") = 0
2613:                         IF USED("cursor_4c_ProdImport")
2614:                             USE IN cursor_4c_ProdImport
2615:                         ENDIF
2616:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2617:                                    " WHERE DPro2s = " + EscaparSQL(loc_cCodigo)
2618:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2619:                     ENDIF
2620: 
2621:                     IF USED("cursor_4c_ProdImport") AND RECCOUNT("cursor_4c_ProdImport") > 0
2622:                         SELECT cursor_4c_Distribui
2623:                         APPEND BLANK
2624:                         REPLACE Cpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Cpros), 14), ;
2625:                                 Dpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Dpros), 30), ;
2626:                                 Qtds  WITH loc_nQtd, ;
2627:                                 Units WITH loc_nVal, ;
2628:                                 Total WITH loc_nTot
2629:                     ENDIF
2630: 
2631:                     IF USED("cursor_4c_ProdImport")
2632:                         USE IN cursor_4c_ProdImport
2633:                     ENDIF
2634:                 ENDIF
2635: 
2636:                 SELECT cursor_4c_Itens
2637:             ENDSCAN
2638: 
2639:             IF USED("cursor_4c_Distribui")
2640:                 GO TOP IN cursor_4c_Distribui
2641:             ENDIF
2642: 
2643:         CATCH TO loc_oErro
2644:             MsgErro("Erro em FormSigPrCtr.CarregarItensXML:" + CHR(13) + ;
2645:                     loc_oErro.Message, "Erro")
2646:         ENDTRY
2647:     ENDPROC
2648: 
2649:     *--------------------------------------------------------------------------
2650:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2651:     *--------------------------------------------------------------------------

*-- Linhas 2657 a 2705:
2657:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2658:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2659:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2660:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2661:                     loc_oGrid.ColumnCount = 3
2662:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2663:                     WITH loc_oGrid
2664:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2665:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2666:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2667:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2668:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2669:                     ENDWITH
2670:                 ENDIF
2671:                 loc_lResultado = .T.
2672:             ENDIF
2673:         CATCH TO loc_oErro
2674:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2675:                     loc_oErro.Message, "Erro")
2676:         ENDTRY
2677: 
2678:         RETURN loc_lResultado
2679:     ENDPROC
2680: 
2681:     *--------------------------------------------------------------------------
2682:     * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
2683:     *--------------------------------------------------------------------------
2684:     PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
2685:         LOCAL loc_oNode, loc_cResult, loc_oErro
2686:         loc_cResult = ""
2687: 
2688:         TRY
2689:             IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
2690:                 loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
2691:                 IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
2692:                     loc_cResult = NVL(loc_oNode.Text, "")
2693:                 ENDIF
2694:             ENDIF
2695:         CATCH TO loc_oErro
2696:             MsgErro("Erro ao ler n" + CHR(243) + "XML '" + par_cXPath + ;
2697:                     "': " + loc_oErro.Message, "Erro XML")
2698:             loc_cResult = ""
2699:         ENDTRY
2700: 
2701:         RETURN loc_cResult
2702:     ENDFUNC
2703: 
2704:     *--------------------------------------------------------------------------
2705:     * ConfigurarPaginaDadosDetalhe - Controles do pgf_4c_Dados.Page2 (Detalhe)

*-- Linhas 2833 a 2929:
2833:                 .FontBold = .T.
2834:                 .FontUnderline = .T.
2835:                 .Header1.Caption = "C" + CHR(243) + "digo"
2836:                 .Header1.Alignment = 2
2837:                 .Header1.ForeColor = RGB(90, 90, 90)
2838:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2839:             ENDWITH
2840: 
2841:             WITH .Column2
2842:                 .Width = 235
2843:                 .Movable = .F.
2844:                 .Resizable = .F.
2845:                 .ReadOnly = .T.
2846:                 .BackColor = RGB(237, 242, 243)
2847:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2848:                 .Header1.Alignment = 2
2849:                 .Header1.ForeColor = RGB(90, 90, 90)
2850:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2851:             ENDWITH
2852: 
2853:             WITH .Column3
2854:                 .Width = 70
2855:                 .Movable = .F.
2856:                 .Resizable = .F.
2857:                 .ReadOnly = .T.
2858:                 .BackColor = RGB(237, 242, 243)
2859:                 .Header1.Caption = "Valor"
2860:                 .Header1.Alignment = 2
2861:                 .Header1.ForeColor = RGB(90, 90, 90)
2862:                 .ControlSource = "cursor_4c_Movimentos.Units"
2863:             ENDWITH
2864: 
2865:             WITH .Column4
2866:                 .Width = 63
2867:                 .Movable = .F.
2868:                 .Resizable = .F.
2869:                 .ReadOnly = .T.
2870:                 .BackColor = RGB(237, 242, 243)
2871:                 .FontBold = .T.
2872:                 .Header1.Caption = "Quantidade"
2873:                 .Header1.Alignment = 2
2874:                 .Header1.ForeColor = RGB(90, 90, 90)
2875:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2876:             ENDWITH
2877: 
2878:             WITH .Column5
2879:                 .Width = 63
2880:                 .Movable = .F.
2881:                 .Resizable = .F.
2882:                 .ReadOnly = .T.
2883:                 .BackColor = RGB(237, 242, 243)
2884:                 .FontBold = .T.
2885:                 .Header1.Caption = "Baixado"
2886:                 .Header1.Alignment = 2
2887:                 .Header1.ForeColor = RGB(90, 90, 90)
2888:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2889:             ENDWITH
2890: 
2891:             WITH .Column6
2892:                 .Width = 63
2893:                 .Movable = .F.
2894:                 .Resizable = .F.
2895:                 .ReadOnly = .T.
2896:                 .BackColor = RGB(237, 242, 243)
2897:                 .FontBold = .T.
2898:                 .Header1.Caption = "Reservado"
2899:                 .Header1.Alignment = 2
2900:                 .Header1.ForeColor = RGB(90, 90, 90)
2901:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2902:             ENDWITH
2903: 
2904:             WITH .Column7
2905:                 .Width = 63
2906:                 .Movable = .F.
2907:                 .Resizable = .F.
2908:                 .ReadOnly = .T.
2909:                 .BackColor = RGB(237, 242, 243)
2910:                 .FontBold = .T.
2911:                 .Header1.Caption = "Saldo"
2912:                 .Header1.Alignment = 2
2913:                 .Header1.ForeColor = RGB(90, 90, 90)
2914:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
2915:             ENDWITH
2916:         ENDWITH
2917:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
2918:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
2919: 
2920:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
2921:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
2922:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
2923:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
2924:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
2925:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
2926:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
2927:         WITH loc_oPg2P2.grd_4c_ItemXml
2928:             .FontName  = "Tahoma"
2929:             .FontSize = 8

*-- Linhas 2947 a 3006:
2947:                 .Header1.Caption = "C" + CHR(243) + "digo"
2948:                 .Header1.Alignment = 2
2949:                 .Header1.ForeColor = RGB(90, 90, 90)
2950:                 .ControlSource = "cursor_4c_Distribui.Cpros"
2951:             ENDWITH
2952: 
2953:             WITH .Column2
2954:                 .Width = 235
2955:                 .Movable = .F.
2956:                 .Resizable = .F.
2957:                 .ReadOnly = .T.
2958:                 .Enabled = .F.
2959:                 .ForeColor = RGB(0, 0, 0)
2960:                 .BackColor = RGB(237, 242, 243)
2961:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2962:                 .Header1.Alignment = 2
2963:                 .Header1.ForeColor = RGB(90, 90, 90)
2964:                 .ControlSource = "cursor_4c_Distribui.Dpros"
2965:             ENDWITH
2966: 
2967:             WITH .Column3
2968:                 .Width = 63
2969:                 .Movable = .F.
2970:                 .Resizable = .F.
2971:                 .InputMask = "999999"
2972:                 .ForeColor = RGB(0, 0, 0)
2973:                 .BackColor = RGB(237, 242, 243)
2974:                 .Header1.Caption = "Quantidade"
2975:                 .Header1.Alignment = 2
2976:                 .Header1.ForeColor = RGB(90, 90, 90)
2977:                 .ControlSource = "cursor_4c_Distribui.Qtds"
2978:             ENDWITH
2979: 
2980:             WITH .Column4
2981:                 .Width = 70
2982:                 .Movable = .F.
2983:                 .Resizable = .F.
2984:                 .ReadOnly = .T.
2985:                 .Enabled = .F.
2986:                 .ForeColor = RGB(0, 0, 0)
2987:                 .BackColor = RGB(237, 242, 243)
2988:                 .Header1.Caption = "Valor"
2989:                 .Header1.Alignment = 2
2990:                 .Header1.ForeColor = RGB(90, 90, 90)
2991:                 .ControlSource = "cursor_4c_Distribui.Total"
2992:             ENDWITH
2993:         ENDWITH
2994: 
2995:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
2996:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
2997:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
2998:             .Caption = ""
2999:             .Themes = .F.
3000:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3001:             .Top = 508
3002:             .Left = 663
3003:             .Width = 40
3004:             .Height = 37
3005:             .ForeColor = RGB(255, 0, 0)
3006:             .BackColor = RGB(255, 255, 255)

*-- Linhas 3354 a 3447:
3354:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3355:         LOCAL loc_lAbortou, loc_oErro
3356:         loc_lAbortou = .F.
3357: 
3358:         TRY
3359:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3360:                 loc_lAbortou = .T.
3361:             ENDIF
3362: 
3363:             IF !loc_lAbortou
3364:                 loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3365:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3366:                 IF EMPTY(loc_cCpros)
3367:                     loc_lAbortou = .T.
3368:                 ENDIF
3369:             ENDIF
3370: 
3371:             IF !loc_lAbortou
3372:                 loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
3373:                            " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
3374:                            " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3375:                 IF USED("cursor_4c_TmpPro")
3376:                     USE IN cursor_4c_TmpPro
3377:                 ENDIF
3378:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3379:                 IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3380:                     loc_lAbortou = .T.
3381:                 ENDIF
3382:             ENDIF
3383: 
3384:             IF !loc_lAbortou
3385:                 SELECT cursor_4c_TmpPro
3386:                 GO TOP
3387: 
3388:                 *-- Campos detalhe produto
3389:                 loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
3390:                 loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
3391:                 loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))
3392:                 loc_oPg2P2.txt_4c__custofs.Value        = NVL(cursor_4c_TmpPro.custofs, 0)
3393:                 loc_oPg2P2.txt_4c__precoMov.Value       = NVL(cursor_4c_TmpPro.pcuss, 0)
3394:                 loc_oPg2P2.txt_4c_CIdChaves.Value       = ALLTRIM(NVL(cursor_4c_Movimentos.CidChaves, ""))
3395:                 loc_oPg2P2.txt_4c_Emps.Value            = SUBSTR(cursor_4c_Movimentos.OriDopNums, 1, 3)
3396:                 loc_oPg2P2.txt_4c_Dopes.Value           = SUBSTR(cursor_4c_Movimentos.OriDopNums, 4, 20)
3397:                 loc_oPg2P2.txt_4c_Numes.Value           = ALLTRIM(RIGHT(cursor_4c_Movimentos.OriDopNums, 6))
3398: 
3399:                 *-- Preco de venda: converte para moeda padrao se configurada
3400:                 loc_cMoeDetqs = ""
3401:                 IF USED("cursor_4c_TmpPam")
3402:                     USE IN cursor_4c_TmpPam
3403:                 ENDIF
3404:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_TmpPam") > 0 ;
3405:                    AND USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
3406:                     loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_TmpPam.moedetqs, ""))
3407:                     USE IN cursor_4c_TmpPam
3408:                 ENDIF
3409: 
3410:                 IF EMPTY(loc_cMoeDetqs)
3411:                     loc_oPg2P2.txt_4c__pr_venda.Value       = NVL(cursor_4c_TmpPro.pvens, 0)
3412:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3413:                 ELSE
3414:                     loc_nCotAlvo  = 1
3415:                     loc_nCotVenda = 1
3416:                     IF USED("cursor_4c_TmpCot")
3417:                         USE IN cursor_4c_TmpCot
3418:                     ENDIF
3419:                     IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3420:                                EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", ;
3421:                                "cursor_4c_TmpCot") > 0 ;
3422:                        AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3423:                         loc_nCotAlvo = NVL(cursor_4c_TmpCot.valos, 1)
3424:                         USE IN cursor_4c_TmpCot
3425:                     ENDIF
3426:                     loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3427:                     IF !EMPTY(loc_cMoeVenda)
3428:                         IF USED("cursor_4c_TmpCot")
3429:                             USE IN cursor_4c_TmpCot
3430:                         ENDIF
3431:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3432:                                    EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", ;
3433:                                    "cursor_4c_TmpCot") > 0 ;
3434:                            AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3435:                             loc_nCotVenda = NVL(cursor_4c_TmpCot.valos, 1)
3436:                             USE IN cursor_4c_TmpCot
3437:                         ENDIF
3438:                     ENDIF
3439:                     loc_nValVenda = ROUND(NVL(cursor_4c_TmpPro.pvens, 0) * loc_nCotVenda / ;
3440:                                          IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
3441:                     loc_oPg2P2.txt_4c__pr_venda.Value       = loc_nValVenda
3442:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = loc_cMoeDetqs
3443:                 ENDIF
3444: 
3445:                 *-- FigJpg: imagem do produto (base64 em SigCdPro.FigJpgs)
3446:                 loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3447:                 loc_lTemFig  = !EMPTY(loc_cFigJpgs) AND !ISNULL(cursor_4c_TmpPro.FigJpgs)

*-- Linhas 3469 a 3602:
3469:                     loc_oErro.Message, "Erro")
3470:         ENDTRY
3471:     ENDPROC
3472: 
3473:     *--------------------------------------------------------------------------
3474:     * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
3475:     *--------------------------------------------------------------------------
3476:     PROCEDURE BtnExcluirSisClick()
3477:         LOCAL loc_oPg2P2, loc_oErro
3478:         TRY
3479:             IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
3480:                 SELECT cursor_4c_Movimentos
3481:                 DELETE
3482:                 IF !EOF("cursor_4c_Movimentos")
3483:                     SKIP
3484:                     SKIP -1
3485:                 ENDIF
3486:                 GO TOP IN cursor_4c_Movimentos
3487:             ENDIF
3488:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3489:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3490:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3491:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3492:             ENDIF
3493:         CATCH TO loc_oErro
3494:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3495:         ENDTRY
3496:     ENDPROC
3497: 
3498:     *--------------------------------------------------------------------------
3499:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3500:     *--------------------------------------------------------------------------
3501:     PROCEDURE BtnExcluirArqClick()
3502:         LOCAL loc_oPg2P2, loc_oErro
3503:         TRY
3504:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3505:                 SELECT cursor_4c_Distribui
3506:                 DELETE
3507:                 IF !EOF("cursor_4c_Distribui")
3508:                     SKIP
3509:                     SKIP -1
3510:                 ENDIF
3511:                 GO TOP IN cursor_4c_Distribui
3512:             ENDIF
3513:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3514:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3515:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3516:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3517:             ENDIF
3518:         CATCH TO loc_oErro
3519:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3520:         ENDTRY
3521:     ENDPROC
3522: 
3523:     *--------------------------------------------------------------------------
3524:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3525:     *--------------------------------------------------------------------------
3526:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3527:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3528:         TRY
3529:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3530:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3531:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
3532:                 IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
3533:                     SELECT cursor_4c_Movimentos
3534:                     loc_nRecno = RECNO()
3535:                     GO TOP
3536:                     LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
3537:                     IF EOF()
3538:                         GO loc_nRecno
3539:                     ENDIF
3540:                 ENDIF
3541:             ENDIF
3542:         CATCH TO loc_oErro
3543:             MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
3544:                     loc_oErro.Message, "Erro")
3545:         ENDTRY
3546:     ENDPROC
3547: 
3548:     *--------------------------------------------------------------------------
3549:     * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
3550:     *--------------------------------------------------------------------------
3551:     PROCEDURE ImgFigJpgDblClick()
3552:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
3553:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
3554:         TRY
3555:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3556:                 RETURN
3557:             ENDIF
3558:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3559:             IF EMPTY(loc_cCpros)
3560:                 RETURN
3561:             ENDIF
3562:             loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
3563:                        EscaparSQL(loc_cCpros)
3564:             IF USED("cursor_4c_TmpPro")
3565:                 USE IN cursor_4c_TmpPro
3566:             ENDIF
3567:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3568:             IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3569:                 RETURN
3570:             ENDIF
3571:             SELECT cursor_4c_TmpPro
3572:             GO TOP
3573:             loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3574:             IF USED("cursor_4c_TmpPro")
3575:                 USE IN cursor_4c_TmpPro
3576:             ENDIF
3577:             IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
3578:                 loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3579:                 loc_cFoto = STRCONV(;
3580:                     STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3581:                         "data:image/png;base64,", ""), ;
3582:                         "data:image/jpeg;base64,", ""), ;
3583:                         "data:image/jpg;base64,", ""), 14)
3584:                 STRTOFILE(loc_cFoto, loc_cArqTemp)
3585:                 IF FILE(loc_cArqTemp)
3586:                     loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
3587:                                    ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
3588:                     IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
3589:                        FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
3590:                         DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
3591:                             WITH loc_cArqTemp, loc_cCaption, " "
3592:                     ELSE
3593:                         DECLARE INTEGER ShellExecute IN shell32.dll ;
3594:                             INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
3595:                             STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
3596:                         ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
3597:                     ENDIF
3598:                 ENDIF
3599:             ENDIF
3600:         CATCH TO loc_oErro
3601:             MsgErro("Erro em FormSigPrCtr.ImgFigJpgDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3602:         ENDTRY

*-- Linhas 3612 a 3681:
3612:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3613:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3614:                     RETURN
3615:                 ENDIF
3616:             ENDIF
3617:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3618:                 RETURN
3619:             ENDIF
3620:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3621:             IF EMPTY(loc_cCpros)
3622:                 RETURN
3623:             ENDIF
3624:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3625:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3626:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3627:             ELSE
3628:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
3629:                         ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
3630:             ENDIF
3631:         CATCH TO loc_oErro
3632:             MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3633:         ENDTRY
3634:     ENDPROC
3635: 
3636:     *--------------------------------------------------------------------------
3637:     * Destroy - Libera BO e fecha cursores
3638:     *--------------------------------------------------------------------------
3639:     PROCEDURE Destroy()
3640:         LOCAL loc_oErro
3641: 
3642:         TRY
3643:             IF USED("cursor_4c_Dados")
3644:                 USE IN cursor_4c_Dados
3645:             ENDIF
3646: 
3647:             IF USED("cursor_4c_Movimentos")
3648:                 USE IN cursor_4c_Movimentos
3649:             ENDIF
3650: 
3651:             IF USED("cursor_4c_Pendentes")
3652:                 USE IN cursor_4c_Pendentes
3653:             ENDIF
3654: 
3655:             IF USED("cursor_4c_Linhas")
3656:                 USE IN cursor_4c_Linhas
3657:             ENDIF
3658: 
3659:             IF USED("cursor_4c_Itens")
3660:                 USE IN cursor_4c_Itens
3661:             ENDIF
3662: 
3663:             IF USED("cursor_4c_Distribui")
3664:                 USE IN cursor_4c_Distribui
3665:             ENDIF
3666: 
3667:             IF USED("cursor_4c_TmpJoin")
3668:                 USE IN cursor_4c_TmpJoin
3669:             ENDIF
3670: 
3671:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3672:                 THIS.this_oBusinessObject = .NULL.
3673:             ENDIF
3674:         CATCH TO loc_oErro
3675:             MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
3676:         ENDTRY
3677: 
3678:         DODEFAULT()
3679:     ENDPROC
3680: 
3681: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*
* Descricao: Gerencia lotes de distribuicao de produtos via XML.
*   Cada "Codigos" representa um lote que agrupa N linhas em SigPrCtr
*   (uma por produto distribuido). A exclusao/atualizacao opera por Codigos
*   (DELETE WHERE Codigos = ?), nao por PkChave.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Chave primaria real da tabela (unica por linha)
    this_cPkChave    = ""  && char(20) - PRIMARY KEY
    *-- Chave de lote: identifica o conjunto de linhas do processamento
    this_cCodigos    = ""  && char(10) - identificador do lote
    *-- Campos do produto na linha
    this_cCodCors    = ""  && char(4)  - codigo da cor
    this_cCodTams    = ""  && char(4)  - codigo do tamanho
    this_cCpros      = ""  && char(14) - codigo do produto
    *-- Quantidades
    this_nQtds       = 0   && numeric(10,2) - quantidade XML
    this_nQtdOs      = 0   && numeric(10,2) - quantidade OS/distribuida
    *-- Referencia de origem
    this_cOriDopNums = ""  && char(29) - EmpDopNums da movimentacao de origem
    this_cFkChaves   = ""  && char(20) - cidchaves do item de movimentacao
    *-- Dados do fornecedor/conta
    this_cContas     = ""  && char(10) - codigo da conta/fornecedor
    *-- Opcoes de processamento
    this_nPrecific   = 0   && numeric(1,0) - tipo de precificacao (Opt_Custo)
    this_cMoedas     = ""  && char(3)  - codigo da moeda
    this_cArquivo    = ""  && char(200) - caminho do arquivo XML
    *-- Auditoria
    this_dDatas      = {}  && datetime - data/hora do processamento
    this_dDtAlts     = {}  && datetime - data/hora da ultima alteracao
    this_cUsuars     = ""  && char(10) - usuario que criou
    this_cUsualts    = ""  && char(10) - usuario da ultima alteracao

    *-- Campos operacionais do formulario (nao persistidos diretamente)
    this_cGrupo      = ""  && grupo contabil (Get_Grupo - GrPadFors de SigCdPam)
    this_cDconta     = ""  && descricao da conta (Get_Dconta)
    this_cCpf        = ""  && CPF/CNPJ do fornecedor (Get_cpf)

    *-- Filtro de data para a lista principal
    this_dDataInicial = {}
    this_dDataFinal   = {}

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigPrCtr"
            THIS.this_cCampoChave  = "PkChave"
            THIS.this_dDataInicial = DATE()
            THIS.this_dDataFinal   = DATE()
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro("Erro ao inicializar SigPrCtrBO: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de lote para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Grava novo lote (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN THIS.SalvarLote("", .T.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza lote existente (delega para SalvarLote)
    *   Form deve popular cursor_4c_Linhas antes de chamar BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN THIS.SalvarLote(THIS.this_cCodigos, .F.)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Seleciona lotes distintos de SigPrCtr filtrados por data
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFin, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicial)
            loc_cDataFin = FormatarDataSQL(THIS.this_dDataFinal)

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON b.Iclis = a.Contas" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDataIni + ;
                       " AND " + loc_cDataFin + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " HAVING " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo Codigos
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                IF THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                    loc_lResultado = .T.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_cFkChaves   = TratarNulo(FkChaves,   "C")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_cUsualts    = TratarNulo(UsuAlts,    "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.CarregarDoCursor: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMovimentosDistribuiveis - Produtos do lote para grdDisponivel (Page2)
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosDistribuiveis(par_cCodigos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
                       " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
                       " SUM(a.QtReservas) AS QtReservas," + ;
                       " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
                       " SUM(g.QtdOs) AS QtdOs," + ;
                       " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
                       " a.CidChaves, a.Moedas" + ;
                       " FROM SigMvItn a" + ;
                       " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
                       " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
                       " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
                       " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
                       " JOIN SigPrCtr g ON a.EmpDopNums = g.OriDopNums" + ;
                       "   AND a.Cpros = g.Cpros AND g.FkChaves = a.CidChaves" + ;
                       " WHERE e.Distribui = 3" + ;
                       " AND c.GrupoDs <> SPACE(10)" + ;
                       " AND c.ContaDs <> SPACE(10)" + ;
                       " AND a.Qtds <> a.QtBaixas" + ;
                       " AND a.CItem2 = 0" + ;
                       " AND g.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
                       "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Movimentos")
                TABLEREVERT(.T., "cursor_4c_Movimentos")
                USE IN cursor_4c_Movimentos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Movimentos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Movimentos")
                    GO TOP IN cursor_4c_Movimentos
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosDistribuiveis: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    *   Retorna movimentacoes distribuiveis para grdEstoque (Page1)
    *   par_cConta   : filtra por fornecedor (vazio = todos)
    *   par_lFiltrar : .T. aplica filtro de conta
    *--------------------------------------------------------------------------
    FUNCTION BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cFiltro
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_cFiltro = ""
            IF par_lFiltrar AND !EMPTY(ALLTRIM(par_cConta))
                loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(par_cConta)
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes," + ;
                       " a.EmpDopNums AS OriDopNums," + ;
                       " a.GrupoOs AS Grupos, a.ContaOs AS Contas" + ;
                       " FROM SigMvCab a" + ;
                       " JOIN SigCdOpe b ON a.Dopes = b.Dopes" + ;
                       " JOIN SigOpCdd c ON b.Dopes = c.Dopes" + ;
                       " WHERE c.Distribui = 3" + ;
                       " AND a.ChkSubn = 0" + ;
                       " AND a.GrupoOs <> SPACE(10)" + ;
                       " AND a.ContaOs <> SPACE(10)" + ;
                       loc_cFiltro

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Pendentes")
                TABLEREVERT(.T., "cursor_4c_Pendentes")
                USE IN cursor_4c_Pendentes
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pendentes")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Pendentes")
                    GO TOP IN cursor_4c_Pendentes
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar pendentes: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.BuscarMovimentosPendentes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarLote - Persiste linhas de cursor_4c_Linhas no banco.
    *   Modo INSERIR (par_lNovoLote=.T.): gera novo Codigos, insere linhas
    *   Modo ALTERAR (par_lNovoLote=.F.): deleta lote antigo, insere novas linhas
    *
    *   cursor_4c_Linhas deve conter os campos:
    *     Cpros(C14), CodCors(C4), CodTams(C4), OriDopNums(C29),
    *     Qtds(N), QtdOs(N), Contas(C10), Arquivo(C200),
    *     Moedas(C3), Precific(N), FkChaves(C20)
    *--------------------------------------------------------------------------
    FUNCTION SalvarLote(par_cCodigos, par_lNovoLote)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigos, loc_lScanOK
        loc_lResultado = .F.
        loc_cCodigos   = ""

        IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
            MsgErro("Nenhuma linha para gravar no lote.", "Aviso")
            RETURN loc_lResultado
        ENDIF

        TRY
            loc_lResultado = .T.

            *-- Modo ALTERAR: exclui linhas do lote anterior antes de reinserir
            IF !par_lNovoLote AND !EMPTY(ALLTRIM(par_cCodigos))
                loc_cSQL   = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lote anterior: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            *-- Modo INSERIR: gera novo Codigos sequencial
            IF loc_lResultado AND par_lNovoLote
                loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS INT)), 0) + 1" + ;
                           " AS ProxCod FROM SigPrCtr"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MaxCod")
                    TABLEREVERT(.T., "cursor_4c_MaxCod")
                    USE IN cursor_4c_MaxCod
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
                    SELECT cursor_4c_MaxCod
                    loc_cCodigos = PADL(ALLTRIM(TRANSFORM(cursor_4c_MaxCod.ProxCod)), 10)
                    USE IN cursor_4c_MaxCod
                ELSE
                    MsgErro("Erro ao gerar codigo de lote: " + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ENDIF
            ENDIF

            IF loc_lResultado AND !par_lNovoLote
                loc_cCodigos = par_cCodigos
            ENDIF

            *-- Insere cada linha do cursor no banco
            IF loc_lResultado
                SELECT cursor_4c_Linhas
                GO TOP
                loc_lScanOK = .T.
                SCAN WHILE loc_lScanOK
                    loc_cSQL = "INSERT INTO SigPrCtr" + ;
                               " (PkChave, Codigos, Cpros, CodCors, CodTams," + ;
                               "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                               "  Moedas, Precific, FkChaves, Datas, Usuars)" + ;
                               " VALUES (" + ;
                               " NEWID()," + ;
                               EscaparSQL(loc_cCodigos) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Cpros), 14)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodCors), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.CodTams), 4)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.OriDopNums), 29)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Qtds) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Contas), 10)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Arquivo), 200)) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.Moedas), 3)) + "," + ;
                               FormatarNumeroSQL(cursor_4c_Linhas.Precific) + "," + ;
                               EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20)) + "," + ;
                               "GETDATE()," + ;
                               EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)) + ")"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao inserir linha do lote: " + CapturarErroSQL(), "Erro SQL")
                        loc_lScanOK = .F.
                        EXIT
                    ENDIF

                    *-- Acumula reserva em SigMvItn (espelha logica legada Salva.Click)
                    IF !EMPTY(ALLTRIM(cursor_4c_Linhas.FkChaves)) AND cursor_4c_Linhas.QtdOs > 0
                        loc_cSQL = "UPDATE SigMvItn SET QtReservas = (QtReservas + " + ;
                                   FormatarNumeroSQL(cursor_4c_Linhas.QtdOs) + ")" + ;
                                   " WHERE CidChaves = " + ;
                                   EscaparSQL(LEFT(ALLTRIM(cursor_4c_Linhas.FkChaves), 20))
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao atualizar reserva em SigMvItn: " + CapturarErroSQL(), "Erro SQL")
                            loc_lScanOK = .F.
                            EXIT
                        ENDIF
                    ENDIF

                    SELECT cursor_4c_Linhas
                ENDSCAN

                loc_lResultado = loc_lScanOK
            ENDIF

            IF loc_lResultado
                THIS.this_cCodigos = loc_cCodigos
                THIS.RegistrarAuditoria(IIF(par_lNovoLote, "INSERT", "UPDATE"))
            ENDIF

        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.SalvarLote: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todas as linhas do lote e restaura QtReservas.
    *   Chamado internamente por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_lScanOK
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                MsgErro("Codigo do lote nao informado para exclusao.", "Aviso")
            ELSE
                *-- Carrega linhas para restaurar QtReservas em SigMvItn
                loc_cSQL = "SELECT FkChaves, QtdOs FROM SigPrCtr" + ;
                           " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ExclLote")
                    TABLEREVERT(.T., "cursor_4c_ExclLote")
                    USE IN cursor_4c_ExclLote
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExclLote")

                IF loc_nResult < 0
                    MsgErro("Erro ao carregar lote para exclusao: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lScanOK = .T.
                    IF USED("cursor_4c_ExclLote") AND RECCOUNT("cursor_4c_ExclLote") > 0
                        SELECT cursor_4c_ExclLote
                        GO TOP
                        SCAN WHILE loc_lScanOK
                            loc_cSQL = "UPDATE SigMvItn SET QtReservas =" + ;
                                       " CASE WHEN (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ;
                                       ") < 0 THEN 0" + ;
                                       " ELSE (QtReservas - " + ;
                                       FormatarNumeroSQL(cursor_4c_ExclLote.QtdOs) + ")" + ;
                                       " END" + ;
                                       " WHERE CidChaves = " + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_ExclLote.FkChaves))

                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResult < 0
                                MsgErro("Erro ao restaurar QtReservas: " + CapturarErroSQL(), "Erro SQL")
                                loc_lScanOK = .F.
                                EXIT
                            ENDIF
                            SELECT cursor_4c_ExclLote
                        ENDSCAN
                        USE IN cursor_4c_ExclLote
                    ENDIF

                    IF loc_lScanOK
                        loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir lote: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigPrCtrBO.ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

