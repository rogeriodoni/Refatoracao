# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (10)
- [GRID-SQL] Campo 'nMarca' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Emps' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Dopes' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Numes' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [GRID-SQL] Campo 'Grupos' usado em ControlSource de cursor_4c_Estoque mas NAO aparece no SELECT SQL
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CMOES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SITUAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3527 linhas total):

*-- Linhas 423 a 458:
423: 
424:         *-- Grid de lista (Grade no legado: abaixo dos filtros)
425:         *-- Top=160 (abaixo dos filtros ~135+21=156); Width=form.Width-15; Height=450
426:         *-- ColumnCount e RecordSource/ControlSource: definidos FORA de WITH (Problema 36)
427:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
428:         loc_oGrid = loc_oPagina.grd_4c_Lista
429: 
430:         loc_oGrid.Top          = 160
431:         loc_oGrid.Left         = 5
432:         loc_oGrid.Width        = THIS.Width - 15
433:         loc_oGrid.Height       = 450
434:         loc_oGrid.ColumnCount  = 6
435:         loc_oGrid.FontName     = "Verdana"
436:         loc_oGrid.FontSize     = 8
437:         loc_oGrid.ForeColor    = RGB(90, 90, 90)
438:         loc_oGrid.BackColor    = RGB(255, 255, 255)
439:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
440:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
441:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
442:         loc_oGrid.HighlightStyle     = 2
443:         loc_oGrid.DeleteMark   = .F.
444:         loc_oGrid.RecordMark   = .F.
445:         loc_oGrid.RowHeight    = 16
446:         loc_oGrid.ScrollBars   = 3
447:         loc_oGrid.GridLines    = 3
448:         loc_oGrid.Visible      = .T.
449: 
450:         *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
451:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
452:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
453:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
454:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
455:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
456:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
457: 
458:         *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)

*-- Linhas 918 a 950:
918: 
919:         *-- Grid grd_4c_Estoque (top=206, left=307, width=545, height=340, 6 colunas)
920:         *-- Problema 36: ColumnCount FORA do WITH (criacao imediata das colunas)
921:         *-- Headers definidos aqui; RecordSource/ControlSource definidos em CarregarGradeEstoque
922:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
923:         loc_oPage.grd_4c_Estoque.ColumnCount = 6
924:         WITH loc_oPage.grd_4c_Estoque
925:             .Top       = 206
926:             .Left      = 307
927:             .Width     = 545
928:             .Height    = 340
929:             .FontName  = "Tahoma"
930:             .FontSize  = 8
931:             .GridLines = 1
932:             .ReadOnly  = .T.
933:             .Visible   = .T.
934:             .RecordMark   = .F.
935:             .DeleteMark   = .F.
936:         ENDWITH
937:         WITH loc_oPage.grd_4c_Estoque.Column1
938:             .Width     = 25
939:             .Resizable = .F.
940:         ENDWITH
941:         loc_oPage.grd_4c_Estoque.Column1.Header1.Caption = " "
942:         WITH loc_oPage.grd_4c_Estoque.Column2
943:             .Width = 65
944:         ENDWITH
945:         loc_oPage.grd_4c_Estoque.Column2.Header1.Caption = "Empresa"
946:         WITH loc_oPage.grd_4c_Estoque.Column3
947:             .Width = 120
948:         ENDWITH
949:         loc_oPage.grd_4c_Estoque.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
950:         WITH loc_oPage.grd_4c_Estoque.Column4

*-- Linhas 1123 a 1141:
1123:             .GridLines = 1
1124:             .Visible   = .T.
1125:             .RecordMark   = .F.
1126:             .DeleteMark   = .F.
1127:         ENDWITH
1128:         WITH loc_oPage.grd_4c_Disponivel.Column1
1129:             .Width = 80
1130:         ENDWITH
1131:         WITH loc_oPage.grd_4c_Disponivel.Column2
1132:             .Width = 200
1133:         ENDWITH
1134:         WITH loc_oPage.grd_4c_Disponivel.Column3
1135:             .Width = 80
1136:         ENDWITH
1137:         WITH loc_oPage.grd_4c_Disponivel.Column4
1138:             .Width = 70
1139:         ENDWITH
1140:         WITH loc_oPage.grd_4c_Disponivel.Column5
1141:             .Width = 80

*-- Linhas 1160 a 1178:
1160:             .GridLines = 1
1161:             .Visible   = .T.
1162:             .RecordMark   = .F.
1163:             .DeleteMark   = .F.
1164:         ENDWITH
1165:         WITH loc_oPage.grd_4c_ItemXml.Column1
1166:             .Width = 100
1167:         ENDWITH
1168:         WITH loc_oPage.grd_4c_ItemXml.Column2
1169:             .Width = 220
1170:         ENDWITH
1171:         WITH loc_oPage.grd_4c_ItemXml.Column3
1172:             .Width = 80
1173:         ENDWITH
1174:         WITH loc_oPage.grd_4c_ItemXml.Column4
1175:             .Width = 93
1176:         ENDWITH
1177: 
1178:         *-- CommandButton btnExcluirSis (top=479, left=663, width=40, height=37)

*-- Linhas 1499 a 1518:
1499:         ENDIF
1500: 
1501:         TRY
1502:             loc_nRet = SQLEXEC(gnConnHandle, ;
1503:                 "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), ;
1504:                 "cursor_4c_BuscaGrupo")
1505: 
1506:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaGrupo") AND !EOF("cursor_4c_BuscaGrupo")
1507:                 *-- Grupo valido
1508:             ELSE
1509:                 THIS.AbrirBuscaGrupoAba()
1510:             ENDIF
1511: 
1512:             IF USED("cursor_4c_BuscaGrupo")
1513:                 USE IN cursor_4c_BuscaGrupo
1514:             ENDIF
1515:         CATCH TO loException
1516:             MsgErro(loException.Message, "Erro em ValidarGrupoAba")
1517:         ENDTRY
1518:     ENDPROC

*-- Linhas 1545 a 1564:
1545: 
1546:         TRY
1547:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1548:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos LIKE " + ;
1549:                     EscaparSQL(loc_cGrupo + "%") + " ORDER BY Codigos", ;
1550:                 "cursor_4c_BusGrupo", ;
1551:                 gnConnHandle)
1552: 
1553:             IF VARTYPE(loc_oBusca) = "O"
1554:                 loc_oBusca.mAddColuna("Codigos", "@!", "Grupo")
1555:                 loc_oBusca.mAddColuna("Descrs",  "",   "Descri" + CHR(231) + CHR(227) + "o")
1556:                 loc_oBusca.Show()
1557: 
1558:                 IF loc_oBusca.this_lSelecionou
1559:                     IF USED("cursor_4c_BusGrupo") AND !EOF("cursor_4c_BusGrupo")
1560:                         loc_oPage.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BusGrupo.Codigos)
1561:                     ENDIF
1562:                 ELSE
1563:                     loc_oPage.txt_4c_Grupo.Value = ""
1564:                 ENDIF

*-- Linhas 1599 a 1618:
1599:         ENDIF
1600: 
1601:         TRY
1602:             loc_nRet = SQLEXEC(gnConnHandle, ;
1603:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
1604:                 "cursor_4c_BuscaConta")
1605: 
1606:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaConta") AND !EOF("cursor_4c_BuscaConta")
1607:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1608:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Rclis, ""))
1609:                 ENDIF
1610:                 IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1611:                     loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Cpfs, ""))
1612:                 ENDIF
1613:             ELSE
1614:                 THIS.AbrirBuscaContaAba()
1615:             ENDIF
1616: 
1617:             IF USED("cursor_4c_BuscaConta")
1618:                 USE IN cursor_4c_BuscaConta

*-- Linhas 1649 a 1668:
1649: 
1650:         TRY
1651:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1652:                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis LIKE " + ;
1653:                     EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis", ;
1654:                 "cursor_4c_BusConta", ;
1655:                 gnConnHandle)
1656: 
1657:             IF VARTYPE(loc_oBusca) = "O"
1658:                 loc_oBusca.mAddColuna("Iclis", "@!", "C" + CHR(243) + "digo")
1659:                 loc_oBusca.mAddColuna("Rclis", "",   "Nome")
1660:                 loc_oBusca.mAddColuna("Cpfs",  "@!", "CPF/CNPJ")
1661:                 loc_oBusca.Show()
1662: 
1663:                 IF loc_oBusca.this_lSelecionou
1664:                     IF USED("cursor_4c_BusConta") AND !EOF("cursor_4c_BusConta")
1665:                         loc_oPage.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BusConta.Iclis)
1666:                         IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1667:                             loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BusConta.Rclis, ""))
1668:                         ENDIF

*-- Linhas 1724 a 1743:
1724: 
1725:         *-- Busca reversa: SigCdCli por Cpfs -> preenche Conta e Dconta
1726:         TRY
1727:             loc_nRet = SQLEXEC(gnConnHandle, ;
1728:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cCpf), ;
1729:                 "cursor_4c_BuscaCpf")
1730: 
1731:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaCpf") AND !EOF("cursor_4c_BuscaCpf")
1732:                 IF TYPE("loc_oPage.txt_4c_Conta") = "O"
1733:                     loc_oPage.txt_4c_Conta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Iclis, ""))
1734:                 ENDIF
1735:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1736:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Rclis, ""))
1737:                 ENDIF
1738:             ENDIF
1739: 
1740:             IF USED("cursor_4c_BuscaCpf")
1741:                 USE IN cursor_4c_BuscaCpf
1742:             ENDIF
1743:         CATCH TO loException

*-- Linhas 1766 a 1785:
1766:         ENDIF
1767: 
1768:         TRY
1769:             loc_nRet = SQLEXEC(gnConnHandle, ;
1770:                 "SELECT TOP 1 CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), ;
1771:                 "cursor_4c_BuscaMoeda")
1772: 
1773:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaMoeda") AND !EOF("cursor_4c_BuscaMoeda")
1774:                 *-- Moeda valida
1775:             ELSE
1776:                 THIS.AbrirBuscaMoedaAba()
1777:             ENDIF
1778: 
1779:             IF USED("cursor_4c_BuscaMoeda")
1780:                 USE IN cursor_4c_BuscaMoeda
1781:             ENDIF
1782:         CATCH TO loException
1783:             MsgErro(loException.Message, "Erro em ValidarMoedaAba")
1784:         ENDTRY
1785:     ENDPROC

*-- Linhas 1811 a 1830:
1811: 
1812:         TRY
1813:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1814:                 "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes LIKE " + ;
1815:                     EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes", ;
1816:                 "cursor_4c_BusMoeda", ;
1817:                 gnConnHandle)
1818: 
1819:             IF VARTYPE(loc_oBusca) = "O"
1820:                 loc_oBusca.mAddColuna("CMoes", "@!", "C" + CHR(243) + "digo")
1821:                 loc_oBusca.mAddColuna("DMoes", "",   "Descri" + CHR(231) + CHR(227) + "o")
1822:                 loc_oBusca.Show()
1823: 
1824:                 IF loc_oBusca.this_lSelecionou
1825:                     IF USED("cursor_4c_BusMoeda") AND !EOF("cursor_4c_BusMoeda")
1826:                         loc_oPage.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BusMoeda.CMoes)
1827:                     ENDIF
1828:                 ELSE
1829:                     loc_oPage.txt_4c_Moeda.Value = ""
1830:                 ENDIF

*-- Linhas 1918 a 1963:
1918:         loc_cEmps  = ""
1919:         loc_cDopes = ""
1920:         loc_cNumes = ""
1921:         loc_nRet   = 0
1922: 
1923:         IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
1924:             MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
1925:             RETURN
1926:         ENDIF
1927: 
1928:         SELECT cursor_4c_Estoque
1929:         loc_cEmps  = ALLTRIM(NVL(cursor_4c_Estoque.Emps,  ""))
1930:         loc_cDopes = ALLTRIM(NVL(cursor_4c_Estoque.Dopes, ""))
1931:         loc_cNumes = ALLTRIM(NVL(cursor_4c_Estoque.Numes, ""))
1932: 
1933:         IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
1934:             MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
1935:             RETURN
1936:         ENDIF
1937: 
1938:         TRY
1939:             loc_nRet = SQLEXEC(gnConnHandle, ;
1940:                 "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
1941:                 "cursor_4c_TmpOpe")
1942: 
1943:             IF loc_nRet > 0 AND USED("cursor_4c_TmpOpe") AND !EOF("cursor_4c_TmpOpe")
1944:                 MsgAviso("Formul" + CHR(225) + "rio SigMvExp ainda n" + CHR(227) + "o migrado.", ;
1945:                     "Indispon" + CHR(237) + "vel")
1946:             ELSE
1947:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1948:                     "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), ;
1949:                     "cursor_4c_TmpOpd")
1950: 
1951:                 IF loc_nRet > 0 AND USED("cursor_4c_TmpOpd") AND !EOF("cursor_4c_TmpOpd")
1952:                     MsgAviso("Formul" + CHR(225) + "rio SigMvObj ainda n" + CHR(227) + "o migrado.", ;
1953:                         "Indispon" + CHR(237) + "vel")
1954:                 ELSE
1955:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdOpe/SigCdOpd.", ;
1956:                         "Aviso")
1957:                 ENDIF
1958:             ENDIF
1959:         CATCH TO loException
1960:             MsgErro(loException.Message, "Erro em CgpOperacaoClick")
1961:         ENDTRY
1962: 
1963:         IF USED("cursor_4c_TmpOpe")

*-- Linhas 1973 a 2004:
1973:     * par_nColIndex obrigatorio para BINDEVENT AfterRowColChange (Problema 38)
1974:     *--------------------------------------------------------------------------
1975:     PROCEDURE GrdEstoqueAfterRowColChange(par_nColIndex)
1976:         LOCAL loc_oPage, loc_lTemRegistro
1977:         loc_oPage        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1978:         loc_lTemRegistro = USED("cursor_4c_Estoque") AND !EOF("cursor_4c_Estoque")
1979: 
1980:         IF TYPE("loc_oPage.cgp_4c_Operacao") = "O"
1981:             loc_oPage.cgp_4c_Operacao.Enabled = loc_lTemRegistro
1982:         ENDIF
1983:     ENDPROC
1984: 
1985:     *--------------------------------------------------------------------------
1986:     * CarregarGradeEstoque - Popula grd_4c_Estoque com SigMvCab disponiveis
1987:     * Original: MontaGrade (25 linhas) -> SELECT SigMvCab + joins + filtros
1988:     * Problema 36: ColumnCount FORA WITH; Problema 32: Headers APOS RecordSource
1989:     * Problema 48: ControlSource APOS RecordSource
1990:     *--------------------------------------------------------------------------
1991:     PROCEDURE CarregarGradeEstoque()
1992:         LOCAL loc_oPage, loc_oGrd, loc_cConta, loc_nOpt, loc_nRet
1993:         LOCAL loc_cSql, loc_cFiltro
1994:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1995:         loc_cConta = ""
1996:         loc_nOpt   = 1
1997:         loc_nRet   = 0
1998:         loc_cSql   = ""
1999:         loc_cFiltro = ""
2000: 
2001:         IF TYPE("loc_oPage.grd_4c_Estoque") != "O"
2002:             RETURN
2003:         ENDIF
2004: 

*-- Linhas 2012 a 2083:
2012: 
2013:         *-- Montar filtro por Conta
2014:         IF !EMPTY(loc_cConta)
2015:             loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(loc_cConta)
2016:         ENDIF
2017: 
2018:         *-- Filtro por Opt_Fil: 2=Cadastrados, 3=Nao Cadastrados
2019:         DO CASE
2020:             CASE loc_nOpt = 2
2021:                 loc_cFiltro = loc_cFiltro + " AND a.EmpDopNums IN (SELECT cpros FROM SigCdPro WHERE situas <> 'I')"
2022:             CASE loc_nOpt = 3
2023:                 loc_cFiltro = loc_cFiltro + " AND a.EmpDopNums NOT IN (SELECT cpros FROM SigCdPro WHERE situas <> 'I')"
2024:         ENDCASE
2025: 
2026:         loc_cSql = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes, " + ;
2027:             "a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas " + ;
2028:             "FROM SigMvCab a " + ;
2029:             "JOIN sigcdope b ON a.dopes = b.dopes " + ;
2030:             "JOIN SigOpCdd c ON b.dopes = c.dopes " + ;
2031:             "WHERE Distribui = 3 AND a.chksubn = 0 " + ;
2032:             "AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)" + ;
2033:             loc_cFiltro
2034: 
2035:         TRY
2036:             *-- Limpar RecordSource antes de recriar (Problema 36)
2037:             loc_oPage.grd_4c_Estoque.RecordSource = ""
2038: 
2039:             IF USED("cursor_4c_Estoque")
2040:                 USE IN cursor_4c_Estoque
2041:             ENDIF
2042: 
2043:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Estoque")
2044: 
2045:             IF loc_nRet > 0 AND USED("cursor_4c_Estoque")
2046:                 loc_oGrd = loc_oPage.grd_4c_Estoque
2047: 
2048:                 *-- Problema 36: ColumnCount FORA de WITH
2049:                 loc_oGrd.ColumnCount = 6
2050:                 *-- Problema 36: RecordSource FORA de WITH
2051:                 loc_oGrd.ColumnCount = 5
2052:                 loc_oGrd.RecordSource = "cursor_4c_Estoque"
2053: 
2054:                 *-- Problema 32: Headers APOS RecordSource
2055:                 loc_oGrd.Column1.Header1.Caption = " "
2056:                 loc_oGrd.Column2.Header1.Caption = "Empresa"
2057:                 loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2058:                 loc_oGrd.Column4.Header1.Caption = "Numero"
2059:                 loc_oGrd.Column5.Header1.Caption = "Grupo"
2060:                 loc_oGrd.Column6.Header1.Caption = "Conta"
2061: 
2062:                 *-- Problema 48: ControlSource APOS RecordSource
2063:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
2064:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
2065:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"
2066:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Estoque.Numes"
2067:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Estoque.Grupos"
2068:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Estoque.Contas"
2069: 
2070:                 WITH loc_oGrd
2071:                     .Column1.Width = 25
2072:                     .Column2.Width = 65
2073:                     .Column3.Width = 120
2074:                     .Column4.Width = 80
2075:                     .Column5.Width = 130
2076:                     .Column6.Width = 125
2077:                     .ReadOnly      = .T.
2078:                 ENDWITH
2079: 
2080:                 loc_oGrd.Refresh()
2081:             ENDIF
2082:         CATCH TO loException
2083:             MsgErro(loException.Message, "Erro em CarregarGradeEstoque")

*-- Linhas 2112 a 2145:
2112:             ENDIF
2113: 
2114:             SET NULL ON
2115:             CREATE CURSOR crItens ;
2116:                 (codigo C(15), Descr C(50), quant N(12,3), valor_uni N(12,4), ;
2117:                  valor_tot N(12,4), unid C(5), cfop C(4), ncm C(8), ;
2118:                  desconto N(12,2), frete N(12,2))
2119:             SET NULL OFF
2120: 
2121:             loc_oXml       = CREATEOBJECT("MSXML.DOMDOCUMENT")
2122:             loc_oXml.Async = .F.
2123: 
2124:             IF !loc_oXml.Load(par_cArquivo)
2125:                 MsgAviso(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2126:                 loc_lResultado = .F.
2127:             ENDIF
2128: 
2129:             IF loc_lResultado
2130:                 loc_oItens = loc_oXml.selectNodes("//det")
2131:                 IF ISNULL(loc_oItens)
2132:                     MsgAviso("Nenhum item encontrado no XML.", "Aviso")
2133:                     loc_lResultado = .F.
2134:                 ENDIF
2135:             ENDIF
2136: 
2137:             IF loc_lResultado
2138:                 loc_nTotal = loc_oItens.length
2139: 
2140:                 DO WHILE loc_i < loc_nTotal
2141:                     loc_oDet    = loc_oItens.item(loc_i)
2142: 
2143:                     loc_cProd   = THIS.XmlGetNodeText(loc_oDet, "cProd")
2144:                     loc_cDescr  = THIS.XmlGetNodeText(loc_oDet, "xProd")
2145:                     loc_nQtd    = VAL(THIS.XmlGetNodeText(loc_oDet, "qCom"))

*-- Linhas 2151 a 2170:
2151:                     loc_nDesc   = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vDesc,vdesc"))
2152:                     loc_nFrete  = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vFrete,vfrete"))
2153: 
2154:                     SELECT crItens
2155:                     INSERT INTO crItens VALUES ;
2156:                         (PADR(ALLTRIM(NVL(loc_cProd,  "")), 15), ;
2157:                          PADR(ALLTRIM(NVL(loc_cDescr, "")), 50), ;
2158:                          loc_nQtd, loc_nValUni, loc_nValTot, ;
2159:                          PADR(ALLTRIM(NVL(loc_cUnid, "")), 5), ;
2160:                          PADR(ALLTRIM(NVL(loc_cCfop, "")), 4), ;
2161:                          PADR(ALLTRIM(NVL(loc_cNcm,  "")), 8), ;
2162:                          loc_nDesc, loc_nFrete)
2163: 
2164:                     loc_i = loc_i + 1
2165:                 ENDDO
2166:             ENDIF
2167: 
2168:         CATCH TO loException
2169:             MsgErro(loException.Message, "Erro em CarregarArquivosXml")
2170:         ENDTRY

*-- Linhas 2183 a 2201:
2183:         loc_cResult = ""
2184: 
2185:         TRY
2186:             loc_oNode = par_oParent.selectSingleNode(".//" + par_cTag)
2187:             IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
2188:                 loc_cResult = NVL(loc_oNode.text, "")
2189:             ENDIF
2190:         CATCH TO loException
2191:             *-- Tag ausente ou objeto invalido; retorna "" sem interromper o parsing
2192:             MsgErro(loException.Message, "XmlGetNodeText [" + par_cTag + "]")
2193:         ENDTRY
2194: 
2195:         loc_oNode = .NULL.
2196:         RETURN loc_cResult
2197:     ENDFUNC
2198: 
2199:     *--------------------------------------------------------------------------
2200:     * XmlGetAnyNodeText - Helper: tenta multiplos tags (lista separada por virgula)
2201:     *--------------------------------------------------------------------------

*-- Linhas 2210 a 2228:
2210:             FOR loc_i = 1 TO loc_nCount
2211:                 loc_cTag = ALLTRIM(loc_aTags[loc_i])
2212:                 IF !EMPTY(loc_cTag)
2213:                     loc_oNode = par_oParent.selectSingleNode(".//" + loc_cTag)
2214:                     IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
2215:                         loc_cResult = NVL(loc_oNode.text, "")
2216:                         IF !EMPTY(loc_cResult)
2217:                             EXIT
2218:                         ENDIF
2219:                     ENDIF
2220:                 ENDIF
2221:             ENDFOR
2222:         CATCH TO loException
2223:             MsgErro(loException.Message, "Erro em XmlGetAnyNodeText")
2224:         ENDTRY
2225: 
2226:         loc_oNode = .NULL.
2227:         RETURN loc_cResult
2228:     ENDFUNC

*-- Linhas 2266 a 2371:
2266:             ENDIF
2267: 
2268:             SET NULL ON
2269:             CREATE CURSOR crMovimentos ;
2270:                 (Cpros C(15), Dpros C(50), reffs C(25), pesoms N(12,3), ;
2271:                  pvens N(12,2), moevs C(3), custofs N(12,2), moecusfs C(3), ;
2272:                  fcustos N(12,2), Emps C(4), Dopes C(10), Numes C(10), ;
2273:                  CodCors C(5), CdChaves C(36), Qtds N(12,3), ;
2274:                  QtdBaixa N(12,3), QtdRes N(12,3), QtdSaldo N(12,3))
2275: 
2276:             CREATE CURSOR crDistribui ;
2277:                 (refForn C(25), Descr C(50), Qtds N(12,3), Valor N(12,2))
2278:             SET NULL OFF
2279: 
2280:             *-- Iterar crItens e tentar localizar em SigCdPro por ifors (ref fornecedor)
2281:             SELECT crItens
2282:             GO TOP IN crItens
2283:             SCAN
2284:                 loc_cProd   = ALLTRIM(NVL(crItens.codigo, ""))
2285:                 loc_nQtd    = NVL(crItens.quant, 0)
2286:                 loc_nValTot = NVL(crItens.valor_tot, 0)
2287:                 loc_cDescr  = ALLTRIM(NVL(crItens.Descr, ""))
2288: 
2289:                 IF EMPTY(loc_cProd)
2290:                     SELECT crItens
2291:                     LOOP
2292:                 ENDIF
2293: 
2294:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2295:                     "SELECT TOP 1 a.cpros, a.dpros, a.reffs, a.pesoms, a.pvens, a.moevs, " + ;
2296:                     "a.custofs, a.moecusfs, a.fcustos, a.CodCors " + ;
2297:                     "FROM SigCdPro a " + ;
2298:                     "WHERE a.ifors = " + EscaparSQL(loc_cProd) + " AND a.situas <> 'I'", ;
2299:                     "cursor_4c_BusPro")
2300: 
2301:                 IF loc_nRet > 0 AND USED("cursor_4c_BusPro") AND !EOF("cursor_4c_BusPro")
2302:                     *-- Produto encontrado -> crMovimentos (exceto quando Opt=3=Nao Cad.)
2303:                     IF loc_nOpt <> 3
2304:                         loc_cCpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.cpros,    "")), 15)
2305:                         loc_cDpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.dpros,    "")), 50)
2306:                         loc_cReffs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.reffs,    "")), 25)
2307:                         loc_nPesoms   = NVL(cursor_4c_BusPro.pesoms,   0)
2308:                         loc_nPvens    = NVL(cursor_4c_BusPro.pvens,    0)
2309:                         loc_cMoevs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moevs,    "")), 3)
2310:                         loc_nCustofs  = NVL(cursor_4c_BusPro.custofs,  0)
2311:                         loc_cMoecusfs = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moecusfs, "")), 3)
2312:                         loc_nFcustos  = NVL(cursor_4c_BusPro.fcustos,  0)
2313:                         loc_cCodCors  = PADR(ALLTRIM(NVL(cursor_4c_BusPro.CodCors,  "")), 5)
2314: 
2315:                         SELECT crMovimentos
2316:                         INSERT INTO crMovimentos VALUES ;
2317:                             (loc_cCpros, loc_cDpros, loc_cReffs, ;
2318:                              loc_nPesoms, loc_nPvens, loc_cMoevs, ;
2319:                              loc_nCustofs, loc_cMoecusfs, loc_nFcustos, ;
2320:                              PADR("", 4), PADR("", 10), PADR("", 10), ;
2321:                              loc_cCodCors, PADR("", 36), ;
2322:                              loc_nQtd, 0, 0, 0)
2323:                     ENDIF
2324:                 ELSE
2325:                     *-- Produto NAO encontrado -> crDistribui (exceto quando Opt=2=Cadastrados)
2326:                     IF loc_nOpt <> 2
2327:                         SELECT crDistribui
2328:                         INSERT INTO crDistribui VALUES ;
2329:                             (PADR(ALLTRIM(loc_cProd), 25), ;
2330:                              PADR(ALLTRIM(loc_cDescr), 50), ;
2331:                              loc_nQtd, loc_nValTot)
2332:                     ENDIF
2333:                 ENDIF
2334: 
2335:                 IF USED("cursor_4c_BusPro")
2336:                     USE IN cursor_4c_BusPro
2337:                 ENDIF
2338: 
2339:                 SELECT crItens
2340:             ENDSCAN
2341: 
2342:             loc_lResultado = .T.
2343: 
2344:         CATCH TO loException
2345:             MsgErro(loException.Message, "Erro em CarregarItemXML")
2346:         ENDTRY
2347: 
2348:         IF loc_lResultado
2349:             THIS.CarregarGradeDisponivel()
2350:             THIS.CarregarGradeItemXml()
2351:         ENDIF
2352:     ENDPROC
2353: 
2354:     *--------------------------------------------------------------------------
2355:     * CarregarGradeDisponivel - Seta RecordSource de grd_4c_Disponivel -> crMovimentos
2356:     * Problema 36/32/48: ColumnCount/RecordSource/ControlSource na ordem certa
2357:     *--------------------------------------------------------------------------
2358:     PROCEDURE CarregarGradeDisponivel()
2359:         LOCAL loc_oPage2, loc_oGrd
2360:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2361:         loc_oGrd   = .NULL.
2362: 
2363:         IF TYPE("loc_oPage2.grd_4c_Disponivel") != "O"
2364:             RETURN
2365:         ENDIF
2366: 
2367:         IF !USED("crMovimentos")
2368:             RETURN
2369:         ENDIF
2370: 
2371:         TRY

*-- Linhas 2383 a 2408:
2383:             loc_oGrd.Column6.Header1.Caption = "Reservado"
2384:             loc_oGrd.Column7.Header1.Caption = "Saldo"
2385: 
2386:             *-- Problema 48: ControlSource APOS RecordSource
2387:             loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
2388:             loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
2389:             loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"
2390:             loc_oGrd.Column4.ControlSource = "crMovimentos.Qtds"
2391:             loc_oGrd.Column5.ControlSource = "crMovimentos.QtdBaixa"
2392:             loc_oGrd.Column6.ControlSource = "crMovimentos.QtdRes"
2393:             loc_oGrd.Column7.ControlSource = "crMovimentos.QtdSaldo"
2394: 
2395:             WITH loc_oGrd
2396:                 .Column1.Width = 80
2397:                 .Column2.Width = 200
2398:                 .Column3.Width = 80
2399:                 .Column4.Width = 70
2400:                 .Column5.Width = 80
2401:                 .Column6.Width = 80
2402:                 .Column7.Width = 94
2403:             ENDWITH
2404: 
2405:             loc_oGrd.Refresh()
2406: 
2407:             *-- Disparar handler para popular campos de detalhe da 1a linha
2408:             IF !EOF("crMovimentos")

*-- Linhas 2441 a 2462:
2441:             loc_oGrd.Column3.Header1.Caption = "Quantidade"
2442:             loc_oGrd.Column4.Header1.Caption = "Valor"
2443: 
2444:             loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
2445:             loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
2446:             loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
2447:             loc_oGrd.Column4.ControlSource = "crDistribui.Valor"
2448: 
2449:             WITH loc_oGrd
2450:                 .Column1.Width = 100
2451:                 .Column2.Width = 220
2452:                 .Column3.Width = 80
2453:                 .Column4.Width = 93
2454:             ENDWITH
2455: 
2456:             loc_oGrd.Refresh()
2457: 
2458:         CATCH TO loException
2459:             MsgErro(loException.Message, "Erro em CarregarGradeItemXml")
2460:         ENDTRY
2461:     ENDPROC
2462: 

*-- Linhas 2476 a 2494:
2476:             RETURN
2477:         ENDIF
2478: 
2479:         SELECT crMovimentos
2480: 
2481:         *-- Atualizar campos de detalhe na Page2 a partir de crMovimentos
2482:         IF TYPE("loc_oPage2.txt_4c_RefFornecedor") = "O"
2483:             loc_oPage2.txt_4c_RefFornecedor.Value = ALLTRIM(NVL(crMovimentos.reffs,    ""))
2484:         ENDIF
2485:         IF TYPE("loc_oPage2.txt_4c_PrVenda") = "O"
2486:             loc_oPage2.txt_4c_PrVenda.Value       = NVL(crMovimentos.pvens, 0)
2487:         ENDIF
2488:         IF TYPE("loc_oPage2.txt_4c_PrVendaMoeda") = "O"
2489:             loc_oPage2.txt_4c_PrVendaMoeda.Value  = ALLTRIM(NVL(crMovimentos.moevs,    ""))
2490:         ENDIF
2491:         IF TYPE("loc_oPage2.txt_4c_PesoMedio") = "O"
2492:             loc_oPage2.txt_4c_PesoMedio.Value     = NVL(crMovimentos.pesoms, 0)
2493:         ENDIF
2494:         IF TYPE("loc_oPage2.txt_4c_Custofs") = "O"

*-- Linhas 2520 a 2602:
2520:     ENDPROC
2521: 
2522:     *--------------------------------------------------------------------------
2523:     * BtnExcluirSisClick - Original: btnExcluirSis.Click -> DELETE em crMovimentos
2524:     *--------------------------------------------------------------------------
2525:     PROCEDURE BtnExcluirSisClick()
2526:         LOCAL loc_oPage2, loc_oGrd
2527:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2528: 
2529:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2530:             RETURN
2531:         ENDIF
2532: 
2533:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2534:             RETURN
2535:         ENDIF
2536: 
2537:         TRY
2538:             SELECT crMovimentos
2539:             IF !EOF()
2540:                 DELETE
2541:             ENDIF
2542: 
2543:             *-- Posicionar no proximo registro disponivel
2544:             SET DELETED ON
2545:             IF !EOF()
2546:                 SKIP
2547:                 SKIP -1
2548:             ELSE
2549:                 GO TOP
2550:             ENDIF
2551: 
2552:             *-- Atualizar grade e campos de detalhe
2553:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2554:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2555:             ENDIF
2556: 
2557:             IF !EOF("crMovimentos")
2558:                 THIS.GrdDisponivelAfterRowColChange(1)
2559:             ENDIF
2560: 
2561:         CATCH TO loException
2562:             MsgErro(loException.Message, "Erro em BtnExcluirSisClick")
2563:         ENDTRY
2564:     ENDPROC
2565: 
2566:     *--------------------------------------------------------------------------
2567:     * BtnExcluirArqClick - Original: btnExcluirArq.Click -> DELETE em crDistribui
2568:     *--------------------------------------------------------------------------
2569:     PROCEDURE BtnExcluirArqClick()
2570:         LOCAL loc_oPage2
2571:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2572: 
2573:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2574:             RETURN
2575:         ENDIF
2576: 
2577:         IF !USED("crDistribui") OR EOF("crDistribui")
2578:             RETURN
2579:         ENDIF
2580: 
2581:         TRY
2582:             SELECT crDistribui
2583:             IF !EOF()
2584:                 DELETE
2585:             ENDIF
2586: 
2587:             SET DELETED ON
2588:             IF !EOF()
2589:                 SKIP
2590:                 SKIP -1
2591:             ELSE
2592:                 GO TOP
2593:             ENDIF
2594: 
2595:             IF TYPE("loc_oPage2.grd_4c_ItemXml") = "O"
2596:                 loc_oPage2.grd_4c_ItemXml.Refresh()
2597:             ENDIF
2598: 
2599:         CATCH TO loException
2600:             MsgErro(loException.Message, "Erro em BtnExcluirArqClick")
2601:         ENDTRY
2602:     ENDPROC

*-- Linhas 2622 a 2640:
2622:         ENDIF
2623: 
2624:         TRY
2625:             SELECT crMovimentos
2626:             loc_nRec = RECNO()
2627:             GO TOP
2628: 
2629:             LOCATE FOR Cpros = PADR(loc_cProd, 15)
2630: 
2631:             IF EOF()
2632:                 GO loc_nRec
2633:             ENDIF
2634: 
2635:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2636:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2637:             ENDIF
2638: 
2639:             THIS.GrdDisponivelAfterRowColChange(1)
2640: 

*-- Linhas 2658 a 2710:
2658:             RETURN
2659:         ENDIF
2660: 
2661:         SELECT crMovimentos
2662:         loc_cCpros = ALLTRIM(NVL(crMovimentos.Cpros, ""))
2663: 
2664:         IF EMPTY(loc_cCpros)
2665:             RETURN
2666:         ENDIF
2667: 
2668:         TRY
2669:             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
2670: 
2671:             loc_nRet = SQLEXEC(gnConnHandle, ;
2672:                 "SELECT TOP 1 a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
2673:                 "cursor_4c_TmpFig")
2674: 
2675:             IF loc_nRet > 0 AND USED("cursor_4c_TmpFig") AND !EOF("cursor_4c_TmpFig")
2676:                 IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
2677:                     STRTOFILE(cursor_4c_TmpFig.FigJpgs, loc_cArqTemp)
2678:                     IF FILE(loc_cArqTemp) AND TYPE("loc_oPage2.img_4c_FigJpg") = "O"
2679:                         loc_oPage2.img_4c_FigJpg.Picture = loc_cArqTemp
2680:                     ENDIF
2681:                 ENDIF
2682:             ENDIF
2683: 
2684:             IF USED("cursor_4c_TmpFig")
2685:                 USE IN cursor_4c_TmpFig
2686:             ENDIF
2687: 
2688:         CATCH TO loException
2689:             MsgErro(loException.Message, "Erro em ImgFigJpgClick")
2690:         ENDTRY
2691:     ENDPROC
2692: 
2693:     *--------------------------------------------------------------------------
2694:     * GravarSessaoXml - Grava todos os produtos de crMovimentos como linhas SigPrCtr
2695:     * Original: cgp_Salva.salva.Click (106 linhas) - padrao multi-row INSERT
2696:     * Para cada linha de crMovimentos (nao deletadas): chama BO.Inserir()
2697:     *--------------------------------------------------------------------------
2698:     PROCEDURE GravarSessaoXml()
2699:         LOCAL loc_oPage, loc_cCodigos, loc_cConta, loc_cArquivo, loc_cMoeda
2700:         LOCAL loc_nOpt, loc_lResultado, loc_nContador
2701:         LOCAL loc_cCpros, loc_cCodCors, loc_nQtds, loc_cEmps, loc_cDopes
2702:         LOCAL loc_cNumes, loc_cCdChaves, loc_cDescr
2703:         loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2704:         loc_lResultado = .F.
2705:         loc_nContador  = 0
2706:         loc_cCodigos   = ""
2707:         loc_cConta     = ""
2708:         loc_cArquivo   = ""
2709:         loc_cMoeda     = ""
2710:         loc_nOpt       = 1

*-- Linhas 2719 a 2742:
2719:             RETURN
2720:         ENDIF
2721: 
2722:         *-- Verificar se ha registros em crMovimentos (RECCOUNT ignora SET DELETED)
2723:         IF RECCOUNT("crMovimentos") = 0
2724:             MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
2725:             RETURN
2726:         ENDIF
2727:         SET DELETED ON
2728: 
2729:         *-- Ler campos da Page1
2730:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2731:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
2732:         ENDIF
2733:         IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
2734:             loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
2735:         ENDIF
2736:         IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
2737:             loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
2738:         ENDIF
2739:         IF TYPE("loc_oPage.opt_4c_Custo") = "O"
2740:             loc_nOpt = NVL(loc_oPage.opt_4c_Custo.Value, 1)
2741:         ENDIF
2742: 

*-- Linhas 2762 a 2821:
2762:                 loc_lResultado = .F.
2763:             ELSE
2764:                 *-- Inserir cada linha de crMovimentos (nao deletados)
2765:                 SELECT crMovimentos
2766:                 GO TOP IN crMovimentos
2767:                 SCAN
2768:                     loc_cCpros    = ALLTRIM(NVL(crMovimentos.Cpros,    ""))
2769:                     loc_cCodCors  = ALLTRIM(NVL(crMovimentos.CodCors,  ""))
2770:                     loc_nQtds     = NVL(crMovimentos.Qtds, 0)
2771:                     loc_cEmps     = ALLTRIM(NVL(crMovimentos.Emps,     ""))
2772:                     loc_cDopes    = ALLTRIM(NVL(crMovimentos.Dopes,    ""))
2773:                     loc_cNumes    = ALLTRIM(NVL(crMovimentos.Numes,    ""))
2774:                     loc_cCdChaves = ALLTRIM(NVL(crMovimentos.CdChaves, ""))
2775: 
2776:                     IF EMPTY(loc_cCpros)
2777:                         SELECT crMovimentos
2778:                         LOOP
2779:                     ENDIF
2780: 
2781:                     THIS.this_oBusinessObject.this_cCodigos    = loc_cCodigos
2782:                     THIS.this_oBusinessObject.this_cCpros      = loc_cCpros
2783:                     THIS.this_oBusinessObject.this_cCodCors    = loc_cCodCors
2784:                     THIS.this_oBusinessObject.this_cCodTams    = ""
2785:                     THIS.this_oBusinessObject.this_cOriDopNums = PADR(loc_cEmps,5) + PADR(loc_cDopes,10) + PADR(loc_cNumes,10)
2786:                     THIS.this_oBusinessObject.this_cFkChaves   = loc_cCdChaves
2787:                     THIS.this_oBusinessObject.this_nQtds       = loc_nQtds
2788:                     THIS.this_oBusinessObject.this_nQtdOs      = 0
2789:                     THIS.this_oBusinessObject.this_cContas     = loc_cConta
2790:                     THIS.this_oBusinessObject.this_cArquivo    = loc_cArquivo
2791:                     THIS.this_oBusinessObject.this_cMoedas     = loc_cMoeda
2792:                     THIS.this_oBusinessObject.this_nPrecific   = loc_nOpt
2793:                     THIS.this_oBusinessObject.this_dDatas      = DATE()
2794:                     THIS.this_oBusinessObject.this_cUsuars     = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
2795: 
2796:                     IF !THIS.this_oBusinessObject.Inserir()
2797:                         MsgErro("Falha ao inserir produto " + loc_cCpros + ".", "Erro")
2798:                         loc_lResultado = .F.
2799:                         SELECT crMovimentos
2800:                         EXIT
2801:                     ELSE
2802:                         loc_nContador = loc_nContador + 1
2803:                         loc_lResultado = .T.
2804:                     ENDIF
2805: 
2806:                     SELECT crMovimentos
2807:                 ENDSCAN
2808:             ENDIF
2809: 
2810:         CATCH TO loException
2811:             MsgErro(loException.Message, "Erro em GravarSessaoXml")
2812:         ENDTRY
2813: 
2814:         IF loc_lResultado AND loc_nContador > 0
2815:             MsgInfo(LTRIM(STR(loc_nContador)) + " produto(s) salvo(s) com sucesso!", "Sucesso")
2816:             THIS.this_cModoAtual = "LISTA"
2817:             THIS.AlternarPagina(1)
2818:             THIS.CarregarLista()
2819:         ENDIF
2820:     ENDPROC
2821: 

*-- Linhas 2904 a 2951:
2904:     *--------------------------------------------------------------------------
2905:     * CarregarLista - Carrega cursor_4c_Dados e configura grd_4c_Lista
2906:     * Chama Buscar() no BO, seta RecordSource e redefine cabecalhos
2907:     * REGRA: ControlSource APOS RecordSource (evita auto-bind - Problema 48)
2908:     * REGRA: Header1.Caption APOS RecordSource (evita reset - Problema 32)
2909:     *--------------------------------------------------------------------------
2910:     PROCEDURE CarregarLista()
2911:         LOCAL loc_lResultado, loc_oGrid
2912:         loc_lResultado = .F.
2913:         loc_oGrid      = .NULL.
2914: 
2915:         TRY
2916:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2917:                 loc_lResultado = .T.
2918:             ELSE
2919:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
2920:                     THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
2921:                     THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim
2922: 
2923:                     IF THIS.this_oBusinessObject.Buscar("")
2924:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2925: 
2926:                         *-- RecordSource FORA de WITH (Problema 36: criacao imediata das colunas)
2927:                         loc_oGrid.ColumnCount = 6
2928:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2929: 
2930:                         *-- ControlSource APOS RecordSource (Problema 48: auto-bind)
2931:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2932:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
2933:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OriDopNums"
2934:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Usuars"
2935:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Contas"
2936:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Rclis"
2937: 
2938:                         loc_oGrid.Column1.Width = 80
2939:                         loc_oGrid.Column2.Width = 120
2940:                         loc_oGrid.Column3.Width = 100
2941:                         loc_oGrid.Column4.Width = 100
2942:                         loc_oGrid.Column5.Width = 100
2943:                         loc_oGrid.Column6.Width = 680
2944: 
2945:                         *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
2946:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2947:                         loc_oGrid.Column2.Header1.Caption = "Data"
2948:                         loc_oGrid.Column3.Header1.Caption = "Mov. Origem"
2949:                         loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
2950:                         loc_oGrid.Column5.Header1.Caption = "Conta"
2951:                         loc_oGrid.Column6.Header1.Caption = "Nome"

*-- Linhas 3040 a 3080:
3040:             RETURN
3041:         ENDIF
3042: 
3043:         *-- Preparar BO para INSERT; setar modo ANTES de HabilitarCampos (Problema 19)
3044:         THIS.this_oBusinessObject.NovoRegistro()
3045:         THIS.this_cModoAtual = "INCLUIR"
3046:         THIS.LimparCampos()
3047:         THIS.HabilitarCampos(.T.)
3048:         THIS.AjustarBotoesPorModo()
3049:         THIS.AlternarPagina(2)
3050:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3051:     ENDPROC
3052: 
3053:     *--------------------------------------------------------------------------
3054:     * BtnVisualizarClick - Abre sessao selecionada em modo somente leitura
3055:     *--------------------------------------------------------------------------
3056:     PROCEDURE BtnVisualizarClick()
3057:         LOCAL loc_cCodigo
3058:         loc_cCodigo = ""
3059: 
3060:         IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3061:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3062:             RETURN
3063:         ENDIF
3064: 
3065:         SELECT cursor_4c_Dados
3066:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3067: 
3068:         IF EMPTY(loc_cCodigo)
3069:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3070:             RETURN
3071:         ENDIF
3072: 
3073:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3074:             RETURN
3075:         ENDIF
3076: 
3077:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3078:             THIS.BOParaForm()
3079:             THIS.this_cModoAtual = "VISUALIZAR"
3080:             THIS.HabilitarCampos(.F.)

*-- Linhas 3098 a 3129:
3098:             RETURN
3099:         ENDIF
3100: 
3101:         SELECT cursor_4c_Dados
3102:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3103: 
3104:         IF EMPTY(loc_cCodigo)
3105:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3106:             RETURN
3107:         ENDIF
3108: 
3109:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3110:             RETURN
3111:         ENDIF
3112: 
3113:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3114:             *-- EditarRegistro prepara BO para UPDATE (Problema 18)
3115:             THIS.this_oBusinessObject.EditarRegistro()
3116:             THIS.BOParaForm()
3117:             THIS.this_cModoAtual = "ALTERAR"
3118:             THIS.HabilitarCampos(.T.)
3119:             THIS.AjustarBotoesPorModo()
3120:             THIS.AlternarPagina(2)
3121:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3122:         ELSE
3123:             MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Erro")
3124:         ENDIF
3125:     ENDPROC
3126: 
3127:     *--------------------------------------------------------------------------
3128:     * BtnExcluirClick - Exclui sessao selecionada apos confirmacao
3129:     *--------------------------------------------------------------------------

*-- Linhas 3137 a 3155:
3137:             RETURN
3138:         ENDIF
3139: 
3140:         SELECT cursor_4c_Dados
3141:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3142: 
3143:         IF EMPTY(loc_cCodigo)
3144:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3145:             RETURN
3146:         ENDIF
3147: 
3148:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3149:             RETURN
3150:         ENDIF
3151: 
3152:         *-- MsgConfirma retorna LOGICAL (.T./.F.) - nunca comparar com = 6 (Problema 50)
3153:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro" + ;
3154:             CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + " ?", ;
3155:             "Confirmar Exclus" + CHR(227) + "o")

*-- Linhas 3208 a 3226:
3208:     ENDPROC
3209: 
3210:     *--------------------------------------------------------------------------
3211:     * BtnSalvarClick - Salva sessao XML: padrao multi-row (DELETE + loop INSERT)
3212:     * SigPrCtr armazena multiplas linhas por sessao (uma por produto)
3213:     * Delega para GravarSessaoXml que faz ExcluirLinhasSessao + BO.Inserir por linha
3214:     *--------------------------------------------------------------------------
3215:     PROCEDURE BtnSalvarClick()
3216:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3217:             RETURN
3218:         ENDIF
3219: 
3220:         THIS.GravarSessaoXml()
3221:     ENDPROC
3222: 
3223:     *--------------------------------------------------------------------------
3224:     * BtnCancelarClick - Cancela edicao e retorna para lista
3225:     *--------------------------------------------------------------------------
3226:     PROCEDURE BtnCancelarClick()

*-- Linhas 3427 a 3446:
3427:         *-- Buscar Dconta (Rclis) e Cpf (Cpfs) de SigCdCli para campos display-only
3428:         IF !EMPTY(loc_cConta)
3429:             TRY
3430:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3431:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
3432:                     "cursor_4c_BoParaForm")
3433: 
3434:                 IF loc_nRet > 0 AND USED("cursor_4c_BoParaForm") AND !EOF("cursor_4c_BoParaForm")
3435:                     IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
3436:                         loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Rclis, ""))
3437:                     ENDIF
3438:                     IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
3439:                         loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Cpfs, ""))
3440:                     ENDIF
3441:                 ENDIF
3442: 
3443:                 IF USED("cursor_4c_BoParaForm")
3444:                     USE IN cursor_4c_BoParaForm
3445:                 ENDIF
3446:             CATCH TO loException


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object: Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Chave: Codigos (identificador de sessao de processamento)
*
* Cada sessao (Codigos) agrupa multiplas linhas em SigPrCtr,
* uma por produto processado no XML. O padrao de gravacao e:
*   DELETE todas as linhas do Codigos + INSERT novas linhas.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Identificacao da sessao de processamento (grupo de linhas)
    this_cCodigos   = ""    && C(10) - Chave da sessao (PK do grupo)

    *-- Chave individual de cada linha
    this_cPkChave   = ""    && C(15) - Chave unica por linha (fUniqueIds)

    *-- Produto
    this_cCpros     = ""    && C(15) - Codigo do produto
    this_cCodCors   = ""    && C(6)  - Codigo da cor
    this_cCodTams   = ""    && C(6)  - Codigo do tamanho

    *-- Movimento de origem
    this_cOriDopNums = ""   && C(30) - Numero(s) de DOP de origem
    this_cFkChaves   = ""   && C(15) - FK para SigMvItn.cidchaves

    *-- Quantidades
    this_nQtds   = 0        && N(12,2) - Quantidade total do XML
    this_nQtdOs  = 0        && N(12,2) - Quantidade disponivel/OS

    *-- Identificacao do fornecedor/conta
    this_cContas = ""       && C(10) - Codigo da conta (fornecedor)

    *-- Arquivo XML processado
    this_cArquivo = ""      && C(255) - Caminho do arquivo XML

    *-- Moeda e precificacao
    this_cMoedas  = ""      && C(10) - Codigo da moeda
    this_nPrecific = 0      && N(2,0) - Opcao de precificacao (1=Custo Total, 2=Composicao)

    *-- Auditoria de insercao
    this_dDatas  = {/ /}    && T - Data/hora de processamento (INSERT)
    this_cUsuars = ""       && C(6)  - Usuario que processou (INSERT)

    *-- Auditoria de alteracao
    this_dDtAlts  = {/ /}   && T - Data/hora da alteracao
    this_cUsuAlts = ""       && C(6)  - Usuario que alterou

    *-- Filtros de periodo para Buscar()
    this_dFiltroInicio = {}  && Data inicial do filtro
    this_dFiltroFim    = {}  && Data final do filtro

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCtr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista sessoes agrupadas por periodo
    * par_cFiltro: filtro adicional de data (formato "ldDatai" e "ldDataf")
    * Retorna cursor_4c_Dados: Codigos, Datas, OriDopNums, Usuars, Contas, Rclis
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        LOCAL ldDatai, ldDataf
        loc_lSucesso = .F.

        TRY
            ldDatai = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroInicio), THIS.this_dFiltroInicio, DATE()))
            ldDataf = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroFim), THIS.this_dFiltroFim, DATE()))

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                       " WHERE a.Datas >= " + ldDatai + ;
                       " AND a.Datas < DATEADD(day, 1, " + ldDataf + ")"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " ORDER BY MAX(a.Datas) DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar sessoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhasSessao - Carrega todas as linhas de uma sessao (para grid Page1)
    * Retorna cursor_4c_Linhas: todas as colunas de SigPrCtr para o Codigos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY a.Cpros"

            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Linhas")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.BuscarLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega a primeira linha de uma sessao pelo Codigos
    * Usado para validacao e para preencher campos de cabecalho da sessao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cFkChaves   = TratarNulo(fkChaves,   "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuAlts    = TratarNulo(UsuAlts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere UMA linha na tabela SigPrCtr (chamada em loop pela form)
    * PROTECTED - chamado por BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCtr" + ;
                       " (Codigos, PkChave, Cpros, CodCors, CodTams," + ;
                       "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                       "  Moedas, Precific, fkChaves, Datas, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPkChave)) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       EscaparSQL(THIS.this_cContas) + ", " + ;
                       EscaparSQL(THIS.this_cArquivo) + ", " + ;
                       EscaparSQL(THIS.this_cMoedas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecific) + ", " + ;
                       EscaparSQL(THIS.this_cFkChaves) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza campos de auditoria de uma linha existente
    * PROTECTED - Para o padrao de edicao: DELETE + re-INSERT via GravarSessao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCtr SET" + ;
                       " Qtds = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " QtdOs = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Arquivo = " + EscaparSQL(THIS.this_cArquivo) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Precific = " + FormatarNumeroSQL(THIS.this_nPrecific) + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE PkChave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove TODAS as linhas da sessao (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhasSessao - Remove TODAS as linhas de uma sessao (PUBLIC)
    * Usado pela form no inicio do ciclo de gravacao (ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigos))
                MsgErro("Codigos nao informado para exclusao de linhas.", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExcluirLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovoCodigos - Gera um novo identificador numerico de sessao
    * Retorna string C(10) com numero sequencial unico para SigPrCtr
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovoCodigos()
        LOCAL loc_cCodigos, loc_cSQL, loc_nResult, loc_nMaxCod
        loc_cCodigos = ""
        loc_nMaxCod  = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS BIGINT)), 0) + 1" + ;
                       " AS NovoCodigos FROM SigPrCtr"

            IF USED("cursor_4c_NovoCod")
                USE IN cursor_4c_NovoCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovoCod")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_NovoCod") > 0
                SELECT cursor_4c_NovoCod
                loc_nMaxCod = cursor_4c_NovoCod.NovoCodigos
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.GerarNovoCodigos")
        ENDTRY

        IF USED("cursor_4c_NovoCod")
            USE IN cursor_4c_NovoCod
        ENDIF

        IF loc_nMaxCod > 0
            loc_cCodigos = ALLTRIM(STR(loc_nMaxCod, 10))
        ENDIF

        RETURN loc_cCodigos
    ENDPROC

ENDDEFINE

