# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'COTAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'PKCHAVE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CUSTOFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPFS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, REFFS, CPROS, DPROS, DPRO2S, CUNIS, CGRUS, CODS, DISTRIBUI, CHKSUBN, GRUPOOS, CONTAOS, CODIGOS, DATAS, FKCHAVES, GRUPODS, CONTADS, QTDS, CITEM2, CIDCHAVES, EMPDOPNUMS, DOPES, DOPPS, LCCUN

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3480 linhas total):

*-- Linhas 120 a 154:
120:             IF USED("crSigCdPam")
121:                 USE IN crSigCdPam
122:             ENDIF
123:             SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "crSigCdPam")
124: 
125:             IF USED("crSigCdMoe")
126:                 USE IN crSigCdMoe
127:             ENDIF
128:             SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe", "crSigCdMoe")
129:             IF USED("crSigCdMoe")
130:                 SELECT crSigCdMoe
131:                 INDEX ON CMoes TAG CMoes
132:             ENDIF
133: 
134:             IF USED("crSigCdCot")
135:                 USE IN crSigCdCot
136:             ENDIF
137:             SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "crSigCdCot")
138:             IF USED("crSigCdCot")
139:                 SELECT crSigCdCot
140:                 INDEX ON CMoes + DTOS(Datas) TAG CMoeData DESCENDING
141:                 SET ORDER TO CMoeData DESCENDING
142:             ENDIF
143:         CATCH TO loException
144:             MostrarErro(loException, "FormSigPrCtr.CarregarCursoresGlobais")
145:         ENDTRY
146:     ENDPROC
147: 
148:     *===========================================================================
149:     * ConfigurarPaginaLista - Page1 completa (FASE 4)
150:     * Cabecalho (faixa cinza, regra #11) + filtro de periodo (legado:
151:     * Pagina.Lista.Dt_inicial/Dt_final) + Grid (legado: Pagina.Lista.Grade,
152:     * alimentada pela query lcQueryLista do Init) + container de botoes CRUD
153:     * (Incluir/Visualizar/Alterar/Excluir/Buscar) + container de saida
154:     * (Encerrar - padrao canonico, regra #10).

*-- Linhas 439 a 457:
439:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
440:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
441:         loc_oGrid.HighlightStyle     = 2
442:         loc_oGrid.DeleteMark         = .F.
443:         loc_oGrid.RecordMark         = .F.
444:         loc_oGrid.RowHeight          = 16
445:         loc_oGrid.ScrollBars         = 2
446:         loc_oGrid.GridLines          = 3
447:         loc_oGrid.ReadOnly           = .T.
448:         WITH loc_oGrid
449:             .Column1.Width = 80
450:             .Column2.Width = 75
451:             .Column3.Width = 280
452:             .Column4.Width = 80
453:             .Column5.Width = 80
454:             .Column6.Width = 180
455:         ENDWITH
456: 
457:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 473 a 542:
473:                 USE IN cursor_4c_Lista
474:             ENDIF
475:             SET NULL ON
476:             CREATE CURSOR cursor_4c_Lista ;
477:                 (Codigos C(10), Datas T, OriDopNums C(29), Usuars C(10), Contas C(10), Rclis C(50))
478:             SET NULL OFF
479:             RETURN .T.
480:         ENDIF
481: 
482:         TRY
483:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
484:             loc_oGrid   = loc_oPagina.grd_4c_Lista
485: 
486:             *-- Desvincula o Grid ANTES de requerer no mesmo nome de cursor
487:             *-- (mesmo padrao ja usado em MontaGrade) - evita que o Grid
488:             *-- fique preso ao cursor durante o SQLEXEC que o recria.
489:             loc_oGrid.RecordSource = ""
490: 
491:             loc_dDataIni     = ConverterParaData(loc_oPagina.txt_4c_Dt_inicial.Value)
492:             loc_dDataFimBase = ConverterParaData(loc_oPagina.txt_4c_Dt_final.Value)
493:             loc_tDataFim = DATETIME(YEAR(loc_dDataFimBase), MONTH(loc_dDataFimBase), ;
494:                 DAY(loc_dDataFimBase), 23, 59, 59)
495: 
496:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
497:                 SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas, a.OriDopNums,
498:                     a.Usuars, a.Contas, b.Rclis
499:                 FROM SigPrCtr a
500:                 JOIN SigCdCli b ON a.Contas = b.Iclis
501:                 WHERE a.Datas BETWEEN <<FormatarDataSQL(loc_dDataIni)>> AND <<FormatarDataSQL(loc_tDataFim)>>
502:                 GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis
503:             ENDTEXT
504: 
505:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
506: 
507:             IF loc_nResultado >= 0
508:                 loc_oGrid.ColumnCount           = 6
509:                 loc_oGrid.RecordSource          = "cursor_4c_Lista"
510:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.Codigos"
511:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.Datas"
512:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.OriDopNums"
513:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.Usuars"
514:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.Contas"
515:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"
516: 
517:                 *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
518:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
519:                 loc_oGrid.Column2.Header1.Caption = "Data"
520:                 loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
521:                 loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
522:                 loc_oGrid.Column5.Header1.Caption = "Fornecedor"
523:                 loc_oGrid.Column6.Header1.Caption = "Nome"
524: 
525:                 THIS.FormatarGridLista(loc_oGrid)
526: 
527:                 *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
528:                 *-- recalculam a largura para o default 90 - so fica se atribuido
529:                 *-- DEPOIS do FormatarGridLista)
530:                 loc_oGrid.Column1.Width = 80
531:                 loc_oGrid.Column2.Width = 75
532:                 loc_oGrid.Column3.Width = 280
533:                 loc_oGrid.Column4.Width = 80
534:                 loc_oGrid.Column5.Width = 80
535:                 loc_oGrid.Column6.Width = 180
536: 
537:                 IF USED("cursor_4c_Lista")
538:                     GO TOP IN cursor_4c_Lista
539:                 ENDIF
540:                 loc_oGrid.Refresh()
541:                 loc_lResultado = .T.
542:             ELSE

*-- Linhas 1091 a 1109:
1091:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
1092:         loc_oGrid.AllowHeaderSizing  = .F.
1093:         loc_oGrid.AllowRowSizing     = .F.
1094:         loc_oGrid.DeleteMark         = .F.
1095:         loc_oGrid.RecordMark         = .T.
1096:         loc_oGrid.RowHeight          = 16
1097:         loc_oGrid.ScrollBars         = 2
1098:         loc_oGrid.GridLines          = 3
1099:         loc_oGrid.ReadOnly           = .T.
1100:         WITH loc_oGrid
1101:             .Column1.Width               = 70
1102:             .Column1.Header1.Alignment   = 2
1103:             .Column1.Header1.Caption     = "Empresa"
1104:             .Column1.Header1.ForeColor   = RGB(90, 90, 90)
1105:             .Column1.Header1.BackColor   = RGB(192, 192, 192)
1106: 
1107:             .Column2.Width               = 200
1108:             .Column2.Header1.Alignment   = 2
1109:             .Column2.Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"

*-- Linhas 1659 a 1677:
1659:     * img_4c_FigJpg (foto do produto) e os botoes de exclusao de linha
1660:     * (btnExcluirSis/btnExcluirArq). Os demais controles desta aba (labels e
1661:     * TextBox de exibicao) ja foram criados em ConfigurarPaginaDados.
1662:     * ControlSource dos grids NAO e atribuido aqui - crMovimentos/crDistribui
1663:     * ainda nao existem neste ponto do Init (regra #41); e feito em
1664:     * ExecutarProcessamentoXml, quando os cursores ja foram criados.
1665:     *===========================================================================
1666:     PROTECTED PROCEDURE ConfigurarPgPage2()
1667:         LOCAL loc_oAba2, loc_oGrid
1668:         loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
1669: 
1670:         *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
1671:         loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
1672:         WITH loc_oAba2.shp_4c_Shape5
1673:             .Top         = 1
1674:             .Left        = 424
1675:             .Width       = 282
1676:             .Height      = 113
1677:             .BackStyle   = 0

*-- Linhas 1908 a 1946:
1908:             loc_oGrid.RecordSource = ""
1909: 
1910:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
1911:                 SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes,
1912:                     a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas
1913:                 FROM SigMvCab a
1914:                 JOIN SigCdOpe b ON a.dopes = b.dopes
1915:                 JOIN SigOpCdd c ON b.dopes = c.dopes
1916:                 WHERE c.Distribui = 3
1917:                     AND a.chksubn = 0
1918:                     AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)
1919:                     <<IIF(par_lFiltra AND !EMPTY(loc_cConta), " AND a.ContaOs = " + EscaparSQL(loc_cConta), "")>>
1920:             ENDTEXT
1921: 
1922:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
1923: 
1924:             IF loc_nResultado >= 0
1925:                 loc_oGrid.ColumnCount            = 5
1926:                 loc_oGrid.RecordSource           = "cursor_4c_Estoque"
1927:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Estoque.Emps"
1928:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Dopes"
1929:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Numes"
1930:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
1931:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"
1932: 
1933:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1934:                 loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1935:                 loc_oGrid.Column3.Header1.Caption = "Numero"
1936:                 loc_oGrid.Column4.Header1.Caption = "Grupo"
1937:                 loc_oGrid.Column5.Header1.Caption = "Conta"
1938: 
1939:                 loc_oGrid.Column1.Width = 70
1940:                 loc_oGrid.Column2.Width = 200
1941:                 loc_oGrid.Column3.Width = 80
1942:                 loc_oGrid.Column4.Width = 80
1943:                 loc_oGrid.Column5.Width = 80
1944: 
1945:                 IF USED("cursor_4c_Estoque")
1946:                     GO TOP IN cursor_4c_Estoque

*-- Linhas 1965 a 1983:
1965:         LOCAL loc_oGrid, loc_nI
1966:         TRY
1967:             IF USED("cursor_4c_Estoque")
1968:                 SELECT cursor_4c_Estoque
1969:                 INDEX ON &par_cCampo TAG (par_cCampo)
1970:             ENDIF
1971: 
1972:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1973:             FOR loc_nI = 1 TO loc_oGrid.ColumnCount
1974:                 loc_oGrid.Columns(loc_nI).Header1.BackColor = IIF(loc_nI = par_nColuna, ;
1975:                     RGB(251, 253, 176), RGB(192, 192, 192))
1976:             ENDFOR
1977:             loc_oGrid.Refresh()
1978:         CATCH TO loException
1979:             MostrarErro(loException, "FormSigPrCtr.OrdenarEstoquePorCampo")
1980:         ENDTRY
1981:     ENDPROC
1982: 
1983:     PROCEDURE OrdenarEstoquePorEmpresa()

*-- Linhas 2111 a 2139:
2111:                 IF USED("cursor_4c_TmpOpe")
2112:                     USE IN cursor_4c_TmpOpe
2113:                 ENDIF
2114:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2115:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpe")
2116: 
2117:                 IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2118:                     loc_cClasseForm = "FormSigMvExp"
2119:                 ELSE
2120:                     IF USED("cursor_4c_TmpOpd")
2121:                         USE IN cursor_4c_TmpOpd
2122:                     ENDIF
2123:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2124:                         "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpd")
2125: 
2126:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpd") AND RECCOUNT("cursor_4c_TmpOpd") > 0
2127:                         loc_cClasseForm = "FormSigMvPdt"
2128:                     ENDIF
2129:                 ENDIF
2130: 
2131:                 IF USED("cursor_4c_TmpOpe")
2132:                     USE IN cursor_4c_TmpOpe
2133:                 ENDIF
2134:                 IF USED("cursor_4c_TmpOpd")
2135:                     USE IN cursor_4c_TmpOpd
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loException
2139:             MostrarErro(loException, "FormSigPrCtr.AbrirMovimentoSelecionado")

*-- Linhas 2163 a 2191:
2163:     *===========================================================================
2164:     PROTECTED PROCEDURE CriarCursoresXml()
2165:         IF !USED("csPrNAOCad")
2166:             CREATE CURSOR csPrNAOCad (Referencia C(25), Unidade C(3), Qtds N(12,2), Pesos N(12,2), Valor N(12,2))
2167:         ENDIF
2168: 
2169:         IF !USED("crItens")
2170:             CREATE CURSOR crItens (codigo C(15), Descr C(30), quant C(15), valor_uni C(15), valor_tot C(15), ;
2171:                 base_icm C(15), valor_icm C(15), aliq_icm C(15), base_ipi C(15), valor_ipi C(15), aliq_ipi C(15), ;
2172:                 unid C(5), cfop C(4), ncm C(8), desconto C(15), frete C(15))
2173:         ENDIF
2174: 
2175:         IF !USED("crResultado")
2176:             CREATE CURSOR crResultado (xTp C(1), cpros C(14), dpros C(60), Qtds N(12,2), Units N(12,2), Total N(12,2))
2177:         ENDIF
2178:     ENDPROC
2179: 
2180:     *===========================================================================
2181:     * CarregarArquivosXml - Confere o CPF/CNPJ do fornecedor contra a chave de
2182:     * acesso do XML e decide se prossegue com a leitura (legado: PROCEDURE
2183:     * carregaarquivos - o parametro pTipo legado so controla se Lerxml roda).
2184:     *===========================================================================
2185:     PROTECTED PROCEDURE CarregarArquivosXml(par_lProcessar)
2186:         LOCAL loc_oPagina, loc_cArquivo, loc_cCgc, loc_cConteudo, loc_cChave, ;
2187:             loc_cCgcXml, loc_lOk, loc_cMsg
2188: 
2189:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2190: 
2191:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))

*-- Linhas 2254 a 2296:
2254:                 MsgErro(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2255:             ELSE
2256:                 IF UPPER(loc_oXml.DocumentElement.BaseName) = "NFEPROC"
2257:                     loc_nQtdItens      = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2258:                     loc_nContaDesconto = 0
2259: 
2260:                     SELECT crItens
2261:                     FOR loc_nI = 0 TO loc_nQtdItens - 1
2262:                         loc_oItem = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_nI)
2263: 
2264:                         APPEND BLANK IN crItens
2265:                         REPLACE codigo    WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").ItemText, ;
2266:                                 Descr     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").ItemText, ;
2267:                                 quant     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").ItemText, ;
2268:                                 valor_uni WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").ItemText, ;
2269:                                 valor_tot WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").ItemText, ;
2270:                                 unid      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").ItemText, ;
2271:                                 cfop      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").ItemText, ;
2272:                                 ncm       WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").ItemText ;
2273:                                 IN crItens
2274: 
2275:                         IF loc_oItem.SelectNodes("prod/vDesc").Length > 0
2276:                             REPLACE desconto WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").ItemText IN crItens
2277:                             loc_nContaDesconto = loc_nContaDesconto + 1
2278:                         ENDIF
2279: 
2280:                         IF loc_oItem.SelectNodes("prod/vFrete").Length > 0
2281:                             REPLACE frete WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").ItemText IN crItens
2282:                         ENDIF
2283:                     ENDFOR
2284: 
2285:                     loc_lSucesso = .T.
2286:                 ELSE
2287:                     MsgAviso(par_cArquivo + " n" + CHR(227) + "o " + CHR(233) + " uma nota fiscal com autoriza" + CHR(231) + CHR(227) + "o!", "Aviso")
2288:                 ENDIF
2289:             ENDIF
2290:         CATCH TO loException
2291:             MostrarErro(loException, "FormSigPrCtr.LerArquivoXml")
2292:         ENDTRY
2293: 
2294:         RETURN loc_lSucesso
2295:     ENDPROC
2296: 

*-- Linhas 2311 a 2452:
2311:         ENDIF
2312: 
2313:         TRY
2314:             SELECT crItens
2315:             GO TOP IN crItens
2316:             SCAN
2317:                 loc_cProd  = NVL(crItens.codigo, "")
2318:                 loc_nQtds  = IIF(TYPE("crItens.quant") = "N", NVL(crItens.quant, 0), VAL(NVL(crItens.quant, "")))
2319:                 loc_cCunis = IIF(INLIST(TYPE("crItens.unid"), "C", "M"), NVL(crItens.unid, ""), "")
2320:                 loc_nVal   = IIF(INLIST(TYPE("crItens.valor_uni"), "C", "M"), VAL(NVL(crItens.valor_uni, "")), ;
2321:                     IIF(TYPE("crItens.valor_uni") = "N", NVL(crItens.valor_uni, 0), 0))
2322:                 loc_nTot   = IIF(INLIST(TYPE("crItens.valor_tot"), "C", "M"), VAL(NVL(crItens.valor_tot, "")), ;
2323:                     IIF(TYPE("crItens.valor_tot") = "N", NVL(crItens.valor_tot, 0), 0))
2324:                 loc_nBaseIcm  = IIF(INLIST(TYPE("crItens.base_icm"), "C", "M"), VAL(NVL(crItens.base_icm, "")), ;
2325:                     IIF(TYPE("crItens.base_icm") = "N", NVL(crItens.base_icm, 0), 0))
2326:                 loc_nValorIpi = IIF(INLIST(TYPE("crItens.valor_ipi"), "C", "M"), VAL(NVL(crItens.valor_ipi, "")), ;
2327:                     IIF(TYPE("crItens.valor_ipi") = "N", NVL(crItens.valor_ipi, 0), 0))
2328: 
2329:                 IF !EMPTY(loc_cProd)
2330:                     IF USED("ProdImport")
2331:                         USE IN ProdImport
2332:                     ENDIF
2333:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2334:                         "SELECT * FROM SigCdPro WHERE Reffs = " + EscaparSQL(loc_cProd), "ProdImport")
2335:                     IF loc_nResultado < 1
2336:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2337:                         LOOP
2338:                     ENDIF
2339: 
2340:                     IF RECCOUNT("ProdImport") = 0
2341:                         USE IN ProdImport
2342:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2343:                             "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cProd), "ProdImport")
2344:                         IF loc_nResultado < 1
2345:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2346:                             LOOP
2347:                         ENDIF
2348:                     ENDIF
2349: 
2350:                     IF RECCOUNT("ProdImport") = 0
2351:                         USE IN ProdImport
2352:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2353:                             "SELECT * FROM SigCdPro WHERE Dpros = " + EscaparSQL(loc_cProd), "ProdImport")
2354:                         IF loc_nResultado < 1
2355:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2356:                             LOOP
2357:                         ENDIF
2358:                     ENDIF
2359: 
2360:                     IF RECCOUNT("ProdImport") = 0
2361:                         USE IN ProdImport
2362:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2363:                             "SELECT * FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(loc_cProd), "ProdImport")
2364:                         IF loc_nResultado < 1
2365:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2366:                             LOOP
2367:                         ENDIF
2368:                     ENDIF
2369: 
2370:                     IF USED("ProdImport") AND !EMPTY(NVL(ProdImport.Cpros, ""))
2371:                         loc_cCunis = IIF(EMPTY(ProdImport.Cunis), loc_cCunis, ProdImport.Cunis)
2372: 
2373:                         IF USED("crTmpUni")
2374:                             USE IN crTmpUni
2375:                         ENDIF
2376:                         SQLEXEC(gnConnHandle, ;
2377:                             "SELECT * FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cCunis) + " ORDER BY Etiqs", "crTmpUni")
2378: 
2379:                         IF USED("crTmpGru")
2380:                             USE IN crTmpGru
2381:                         ENDIF
2382:                         SQLEXEC(gnConnHandle, ;
2383:                             "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr " + ;
2384:                             "FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ProdImport.CGrus) + ;
2385:                             " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas", "crTmpGru")
2386: 
2387:                         loc_cTp = " "
2388:                         IF (loc_nBaseIcm + loc_nValorIpi) != 0 AND ProdImport.CustoFs != (loc_nBaseIcm + loc_nValorIpi)
2389:                             loc_nVariaProd = ROUND(ProdImport.CustoFs * 0.05, 2) + ProdImport.CustoFs
2390:                             IF loc_nVariaProd < (loc_nBaseIcm + loc_nValorIpi)
2391:                                 loc_cTp = "X"
2392:                             ENDIF
2393:                         ENDIF
2394: 
2395:                         SELECT crResultado
2396:                         APPEND BLANK
2397:                         REPLACE Cpros WITH ProdImport.Cpros, ;
2398:                                 dpros WITH ProdImport.Dpros, ;
2399:                                 xTp   WITH loc_cTp, ;
2400:                                 Qtds  WITH loc_nQtds, ;
2401:                                 Units WITH loc_nVal, ;
2402:                                 Total WITH loc_nTot IN crResultado
2403:                     ELSE
2404:                         SELECT csPrNAOCad
2405:                         APPEND BLANK
2406:                         REPLACE Referencia WITH NVL(loc_cProd, ""), ;
2407:                                 Qtds       WITH NVL(loc_nQtds, 0), ;
2408:                                 Pesos      WITH 0, ;
2409:                                 Unidade    WITH NVL(loc_cCunis, ""), ;
2410:                                 Valor      WITH NVL(loc_nVal, 0) IN csPrNAOCad
2411:                     ENDIF
2412: 
2413:                     IF USED("ProdImport")
2414:                         USE IN ProdImport
2415:                     ENDIF
2416:                 ENDIF
2417: 
2418:                 SELECT crItens
2419:             ENDSCAN
2420:         CATCH TO loException
2421:             MostrarErro(loException, "FormSigPrCtr.CarregarItensXmlNaGrade")
2422:         ENDTRY
2423: 
2424:         IF USED("csPrNAOCad")
2425:             SELECT csPrNAOCad
2426:             GO TOP
2427:             IF RECCOUNT("csPrNAOCad") > 0
2428:                 loc_cArquivoSaida = ADDBS(SYS(5) + SYS(2003)) + "Produtos_Nao_Localizados"
2429:                 MsgAviso("Houve produtos n" + CHR(227) + "o Localizados" + CHR(13) + CHR(13) + ;
2430:                     "Arquivo : " + loc_cArquivoSaida + ".XLS", "Aten" + CHR(231) + CHR(227) + "o")
2431:                 SELECT csPrNAOCad
2432:                 COPY TO (loc_cArquivoSaida) XL5
2433:             ENDIF
2434:         ENDIF
2435: 
2436:         IF USED("crItens")
2437:             SELECT crItens
2438:             GO TOP
2439:         ENDIF
2440: 
2441:         RETURN .T.
2442:     ENDPROC
2443: 
2444:     *===========================================================================
2445:     * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
2446:     * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
2447:     *===========================================================================
2448:     PROCEDURE ProcessarArquivoXmlClick()
2449:         LOCAL loc_oPagina
2450:         TRY
2451:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2452: 

*-- Linhas 2503 a 2619:
2503:             loc_nCotaMoe   = THIS.this_oBusinessObject.CarregarCambio(loc_cMoedaBase, DATE())
2504: 
2505:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2506:                 SELECT a.Cpros, f.Dpros, a.units,
2507:                     SUM(a.qtds) AS qtds, SUM(a.qtbaixas) AS qtbaixas, SUM(a.qtreservas) AS qtreservas,
2508:                     (SUM(a.qtds) - SUM(a.qtbaixas) - SUM(a.qtreservas)) AS Saldo,
2509:                     a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus, a.cidchaves, a.Moedas
2510:                 FROM SigMvItn a
2511:                 JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums
2512:                 JOIN SigCdOpe d ON c.dopes = d.dopes
2513:                 JOIN SigOpCdd e ON d.dopes = e.dopes
2514:                 JOIN SigCdPro f ON a.Cpros = f.Cpros
2515:                 WHERE e.Distribui = 3
2516:                     AND c.GrupoOs <> SPACE(10)
2517:                     AND c.ContaOs <> SPACE(10)
2518:                     AND a.citem2 = 0
2519:                     AND a.qtds <> a.qtbaixas
2520:                     AND a.EmpDopNums IN (<<EscaparSQL(loc_cOriDopNums)>>)
2521:                 GROUP BY a.CPros, f.Dpros, f.Cgrus, f.Sgrus, a.EmpDopNums, a.units, a.cidchaves, a.Moedas
2522:             ENDTEXT
2523: 
2524:             IF USED("crMovimentos")
2525:                 USE IN crMovimentos
2526:             ENDIF
2527:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMovimentos")
2528: 
2529:             IF loc_nResultado < 1
2530:                 MsgAviso("Problemas no Select dos Produtos da Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2531:             ELSE
2532:                 SELECT crMovimentos
2533:                 INDEX ON Cgrus TAG Cgrus
2534:                 INDEX ON Cpros TAG Cpros
2535:                 SET ORDER TO Cpros
2536:                 GO TOP
2537: 
2538:                 THIS.CriarCursoresXml()
2539:                 SELECT crItens
2540:                 ZAP
2541:                 SELECT csPrNAOCad
2542:                 ZAP
2543:                 SELECT crResultado
2544:                 ZAP
2545: 
2546:                 THIS.CarregarArquivosXml(.T.)
2547:                 THIS.CarregarItensXmlNaGrade()
2548: 
2549:                 IF USED("crDistribui")
2550:                     USE IN crDistribui
2551:                 ENDIF
2552:                 SELECT Cpros, Dpros, SUM(Qtds) AS Qtds, MAX(Units) AS Units, SUM(Total) AS Total ;
2553:                     FROM crResultado ;
2554:                     GROUP BY Cpros, Dpros ;
2555:                     INTO CURSOR crDistribui READWRITE
2556: 
2557:                 SELECT crDistribui
2558:                 INDEX ON cPros TAG Tag1
2559:                 SET ORDER TO Tag1
2560: 
2561:                 loc_oGridItem.RecordSource          = "crDistribui"
2562:                 loc_oGridItem.Column1.ControlSource = "crDistribui.Cpros"
2563:                 loc_oGridItem.Column2.ControlSource = "crDistribui.Dpros"
2564:                 loc_oGridItem.Column3.ControlSource = "crDistribui.Qtds"
2565:                 loc_oGridItem.Column4.ControlSource = "crDistribui.Units"
2566: 
2567:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2568:                 *-- reaplicar OS DOIS depois do ControlSource
2569:                 loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2570:                 loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2571:                 loc_oGridItem.Column3.Header1.Caption = "Quantidade"
2572:                 loc_oGridItem.Column4.Header1.Caption = "Valor"
2573:                 loc_oGridItem.Column1.Width = 100
2574:                 loc_oGridItem.Column2.Width = 235
2575:                 loc_oGridItem.Column3.Width = 63
2576:                 loc_oGridItem.Column4.Width = 70
2577: 
2578:                 SELECT crMovimentos
2579:                 DO CASE
2580:                     CASE loc_nTipo = 1
2581:                         DELETE FROM crMovimentos WHERE Cpros NOT IN (SELECT Cpros FROM crDistribui)
2582:                     CASE loc_nTipo = 2
2583:                         DELETE FROM crMovimentos WHERE Cpros IN (SELECT Cpros FROM crDistribui)
2584:                 ENDCASE
2585:                 GO TOP IN crMovimentos
2586: 
2587:                 SELECT crMovimentos
2588:                 SCAN FOR !DELETED()
2589:                     loc_nCotacao = THIS.this_oBusinessObject.CarregarCambio(crMovimentos.Moedas, DATE())
2590:                     loc_nUnits   = ROUND(crMovimentos.Units * loc_nCotacao / loc_nCotaMoe, 2)
2591:                     REPLACE Units WITH loc_nUnits IN crMovimentos
2592:                 ENDSCAN
2593: 
2594:                 loc_oGridDisp.RecordSource          = "crMovimentos"
2595:                 loc_oGridDisp.Column1.ControlSource = "crMovimentos.Cpros"
2596:                 loc_oGridDisp.Column2.ControlSource = "crMovimentos.Dpros"
2597:                 loc_oGridDisp.Column3.ControlSource = "crMovimentos.units"
2598:                 loc_oGridDisp.Column4.ControlSource = "crMovimentos.qtds"
2599:                 loc_oGridDisp.Column5.ControlSource = "crMovimentos.qtbaixas"
2600:                 loc_oGridDisp.Column6.ControlSource = "crMovimentos.qtreservas"
2601:                 loc_oGridDisp.Column7.ControlSource = "crMovimentos.Saldo"
2602: 
2603:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2604:                 *-- reaplicar OS DOIS depois do ControlSource
2605:                 loc_oGridDisp.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2606:                 loc_oGridDisp.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2607:                 loc_oGridDisp.Column3.Header1.Caption = "Valor"
2608:                 loc_oGridDisp.Column4.Header1.Caption = "Quantidade"
2609:                 loc_oGridDisp.Column5.Header1.Caption = "Baixado"
2610:                 loc_oGridDisp.Column6.Header1.Caption = "Reservado"
2611:                 loc_oGridDisp.Column7.Header1.Caption = "Saldo"
2612:                 loc_oGridDisp.Column1.Width = 100
2613:                 loc_oGridDisp.Column2.Width = 235
2614:                 loc_oGridDisp.Column3.Width = 70
2615:                 loc_oGridDisp.Column4.Width = 63
2616:                 loc_oGridDisp.Column5.Width = 63
2617:                 loc_oGridDisp.Column6.Width = 63
2618:                 loc_oGridDisp.Column7.Width = 63
2619: 

*-- Linhas 2645 a 2664:
2645:                 IF USED("cursor_4c_TmpCli")
2646:                     USE IN cursor_4c_TmpCli
2647:                 ENDIF
2648:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2649:                     "SELECT Cpfs, Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
2650:                     "cursor_4c_TmpCli")
2651: 
2652:                 IF loc_nResultado >= 0 AND USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
2653:                     par_oPagina.txt_4c_Cpf.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Cpfs, ""))
2654:                     IF EMPTY(ALLTRIM(par_oPagina.txt_4c_Grupo.Value))
2655:                         par_oPagina.txt_4c_Grupo.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
2656:                     ENDIF
2657:                 ENDIF
2658: 
2659:                 IF USED("cursor_4c_TmpCli")
2660:                     USE IN cursor_4c_TmpCli
2661:                 ENDIF
2662: 
2663:                 THIS.MontaGrade(.T.)
2664:             ENDIF

*-- Linhas 2771 a 2791:
2771:                     IF USED("cursor_4c_BuscaCli")
2772:                         USE IN cursor_4c_BuscaCli
2773:                     ENDIF
2774:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2775:                         "SELECT IClis, RClis, Cpfs, Grupos FROM SigCdCli WHERE Cpfs = " + ;
2776:                         EscaparSQL(PADR(ALLTRIM(loc_cCgcFmt), 20)), "cursor_4c_BuscaCli")
2777: 
2778:                     IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaCli") AND !EOF("cursor_4c_BuscaCli")
2779:                         loc_cGrupo = loc_oPagina.txt_4c_Grupo.Value
2780:                         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ;
2781:                                 ALLTRIM(cursor_4c_BuscaCli.IClis), loc_oPagina.txt_4c_Conta.Value, loc_oPagina.txt_4c_Dconta.Value)
2782:                             MsgErro("Acesso Negado !!", "Aviso")
2783:                             loc_oPagina.txt_4c_Conta.Value  = ""
2784:                             loc_oPagina.txt_4c_Dconta.Value = ""
2785:                             loc_oPagina.txt_4c_Cpf.Value    = ""
2786:                         ELSE
2787:                             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.IClis)
2788:                             loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
2789:                             loc_oPagina.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2790: 
2791:                             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))

*-- Linhas 2888 a 2932:
2888:     *
2889:     * Colunas de SigCdPro lidas no legado mas NUNCA consumidas depois
2890:     * (cgrus/sgrus/CodCors - so alimentavam a consulta morta a SigCdPsg/
2891:     * Tmp_Sgru) e os LEFT JOINs com SigCdUni/SigCdCol/SigCdLin/SigPrFti/
2892:     * SigCdCli/SigCdGpr/SigCdFip (cujas colunas tambem nunca sao lidas) sao
2893:     * leitura morta - omitidas aqui, mesmo criterio ja aplicado em
2894:     * LerArquivoXml para os campos de cabecalho da NF-e nao referenciados.
2895:     *===========================================================================
2896:     PROCEDURE AtualizarDetalhesProdutoSelecionado(par_nColIndex)
2897:         LOCAL loc_oAba2, loc_cSQL, loc_nResultado, loc_cArquivoImg, loc_cFoto, ;
2898:             loc_nCotacao, loc_nCotVen, loc_nPrVenda, loc_cPrVendaMoeda, ;
2899:             loc_nFatArred, loc_nSoma
2900: 
2901:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2902:             RETURN
2903:         ENDIF
2904: 
2905:         TRY
2906:             loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2907: 
2908:             IF USED("CrTSigPro")
2909:                 USE IN CrTSigPro
2910:             ENDIF
2911: 
2912:             loc_cSQL = "SELECT a.Cpros, a.Reffs, a.Pesoms, a.Moecusfs, a.Custofs, a.Pcuss, " + ;
2913:                 "a.Pvens, a.Moevs, a.FigJpgs, g.Arreds " + ;
2914:                 "FROM SigCdPro a LEFT JOIN SigCdGrp g ON a.Cgrus = g.Cgrus " + ;
2915:                 "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(crMovimentos.Cpros))
2916: 
2917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrTSigPro")
2918: 
2919:             IF loc_nResultado < 1 OR !USED("CrTSigPro") OR EOF("CrTSigPro")
2920:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
2921:             ELSE
2922:                 loc_oAba2.txt_4c_RefFornecedor.Value = TratarNulo(CrTSigPro.Reffs, "")
2923:                 loc_oAba2.txt_4c_PesoMedio.Value      = TratarNulo(CrTSigPro.Pesoms, 0)
2924:                 loc_oAba2.txt_4c_MoeCusFs.Value        = TratarNulo(CrTSigPro.Moecusfs, "")
2925:                 loc_oAba2.txt_4c_CustoFs.Value          = TratarNulo(CrTSigPro.Custofs, 0)
2926:                 loc_oAba2.txt_4c_PrecoMov.Value         = TratarNulo(CrTSigPro.Pcuss, 0)
2927: 
2928:                 loc_oAba2.txt_4c_MovCidChaves.Value = TratarNulo(crMovimentos.cidchaves, "")
2929:                 loc_oAba2.txt_4c_MovEmps.Value       = SUBSTR(crMovimentos.OriDopNums, 1, 3)
2930:                 loc_oAba2.txt_4c_MovDopes.Value      = SUBSTR(crMovimentos.OriDopNums, 4, 20)
2931:                 loc_oAba2.txt_4c_MovNumes.Value      = ALLTRIM(RIGHT(crMovimentos.OriDopNums, 6))
2932: 

*-- Linhas 2952 a 2975:
2952:                     loc_nPrVenda      = TratarNulo(CrTSigPro.Pvens, 0)
2953:                     loc_cPrVendaMoeda = TratarNulo(CrTSigPro.Moevs, "")
2954:                 ELSE
2955:                     SELECT crSigCdCot
2956:                     GO TOP
2957:                     LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(crSigCdPam.moedetqs)
2958:                     loc_nCotacao = IIF(FOUND(), crSigCdCot.valos, 1)
2959: 
2960:                     SELECT crSigCdCot
2961:                     GO TOP
2962:                     LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(CrTSigPro.Moevs)
2963:                     loc_nCotVen  = IIF(FOUND(), crSigCdCot.valos, 1)
2964: 
2965:                     loc_nPrVenda      = ROUND(CrTSigPro.Pvens * loc_nCotVen / loc_nCotacao, 2)
2966:                     loc_cPrVendaMoeda = ALLTRIM(crSigCdPam.moedetqs)
2967:                 ENDIF
2968: 
2969:                 IF CrTSigPro.Arreds != 0
2970:                     loc_nFatArred = CrTSigPro.Arreds
2971:                     loc_nSoma     = loc_nFatArred
2972:                     DO WHILE loc_nSoma < loc_nPrVenda
2973:                         loc_nSoma = loc_nSoma + loc_nFatArred
2974:                     ENDDO
2975:                     loc_nPrVenda = loc_nSoma

*-- Linhas 3039 a 3059:
3039:             IF USED("cursor_4c_FotoZoom")
3040:                 USE IN cursor_4c_FotoZoom
3041:             ENDIF
3042:             loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
3043:                 EscaparSQL(ALLTRIM(crMovimentos.Cpros))
3044:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoZoom")
3045: 
3046:             IF loc_nResultado >= 0 AND USED("cursor_4c_FotoZoom") AND !EOF("cursor_4c_FotoZoom") ;
3047:                     AND !ISNULL(cursor_4c_FotoZoom.FigJpgs) AND !EMPTY(cursor_4c_FotoZoom.FigJpgs)
3048:                 STRTOFILE(cursor_4c_FotoZoom.FigJpgs, loc_cArquivo)
3049:             ELSE
3050:                 loc_cArquivo = ""
3051:             ENDIF
3052: 
3053:             IF USED("cursor_4c_FotoZoom")
3054:                 USE IN cursor_4c_FotoZoom
3055:             ENDIF
3056:         CATCH TO loException
3057:             MostrarErro(loException, "FormSigPrCtr.FigJpgDblClick")
3058:             loc_cArquivo = ""
3059:         ENDTRY

*-- Linhas 3090 a 3110:
3090:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crMovimentos")
3091:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3092: 
3093:                 SELECT crMovimentos
3094:                 IF !EOF()
3095:                     DELETE
3096:                 ENDIF
3097:                 IF !EOF()
3098:                     SKIP
3099:                     SKIP -1
3100:                 ENDIF
3101:                 GO TOP
3102:                 loc_oAba2.grd_4c_Disponivel.SetFocus()
3103:                 loc_oAba2.grd_4c_Disponivel.Refresh()
3104:             ENDIF
3105:         CATCH TO loException
3106:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirSisClick")
3107:         ENDTRY
3108:     ENDPROC
3109: 
3110:     *===========================================================================

*-- Linhas 3118 a 3138:
3118:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crDistribui")
3119:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3120: 
3121:                 SELECT crDistribui
3122:                 IF !EOF()
3123:                     DELETE
3124:                 ENDIF
3125:                 IF !EOF()
3126:                     SKIP
3127:                     SKIP -1
3128:                 ENDIF
3129:                 GO TOP
3130:                 loc_oAba2.grd_4c_ItemXml.SetFocus()
3131:                 loc_oAba2.grd_4c_ItemXml.Refresh()
3132:             ENDIF
3133:         CATCH TO loException
3134:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirArqClick")
3135:         ENDTRY
3136:     ENDPROC
3137: 
3138:     *===========================================================================

*-- Linhas 3294 a 3312:
3294:             IF !loc_lTemSelecao
3295:                 MsgAviso("Selecione um registro na lista para alterar.", "Aviso")
3296:             ELSE
3297:                 SELECT cursor_4c_Lista
3298:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3299: 
3300:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3301:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3302:                 ELSE
3303:                     THIS.this_oBusinessObject.EditarRegistro()
3304:                     THIS.BOParaForm()
3305:                     THIS.this_cModoAtual = "ALTERAR"
3306:                     THIS.HabilitarCampos(.T.)
3307:                     THIS.AjustarBotoesPorModo()
3308:                     THIS.AlternarPagina(2)
3309:                 ENDIF
3310:             ENDIF
3311:         CATCH TO loException
3312:             MostrarErro(loException, "FormSigPrCtr.BtnAlterarClick")

*-- Linhas 3331 a 3387:
3331:             IF !loc_lTemSelecao
3332:                 MsgAviso("Selecione um registro na lista para visualizar.", "Aviso")
3333:             ELSE
3334:                 SELECT cursor_4c_Lista
3335:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3336: 
3337:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3338:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3339:                 ELSE
3340:                     THIS.BOParaForm()
3341:                     THIS.this_cModoAtual = "VISUALIZAR"
3342:                     THIS.HabilitarCampos(.F.)
3343:                     THIS.AjustarBotoesPorModo()
3344:                     THIS.AlternarPagina(2)
3345:                 ENDIF
3346:             ENDIF
3347:         CATCH TO loException
3348:             MostrarErro(loException, "FormSigPrCtr.BtnVisualizarClick")
3349:         ENDTRY
3350:     ENDPROC
3351: 
3352:     *===========================================================================
3353:     * BtnExcluirClick - Exclui o lote selecionado (todas as linhas do mesmo
3354:     * Codigos - legado: "Delete From SigPrCtr Where Codigos = ?_Codigo").
3355:     * Falha de gravacao nunca eh muda (regra #20) - BusinessBase.Excluir()
3356:     * ja chama MsgErro internamente quando necessario.
3357:     *===========================================================================
3358:     PROCEDURE BtnExcluirClick()
3359:         LOCAL loc_cCodigo, loc_lTemSelecao
3360:         loc_lTemSelecao = .F.
3361: 
3362:         TRY
3363:             IF USED("cursor_4c_Lista")
3364:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3365:                     loc_lTemSelecao = .T.
3366:                 ENDIF
3367:             ENDIF
3368: 
3369:             IF !loc_lTemSelecao
3370:                 MsgAviso("Selecione um registro na lista para excluir.", "Aviso")
3371:             ELSE
3372:                 SELECT cursor_4c_Lista
3373:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3374: 
3375:                 IF MsgConfirma("Deseja realmente excluir o registro " + loc_cCodigo + "?", ;
3376:                         "Confirmar Exclus" + CHR(227) + "o")
3377: 
3378:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3379:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3380:                     ELSE
3381:                         IF THIS.this_oBusinessObject.Excluir()
3382:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
3383:                             THIS.CarregarLista()
3384:                         ELSE
3385:                             IF !THIS.this_oBusinessObject.this_lErroExibido
3386:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
3387:                             ENDIF


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*====================================================================
* SigPrCtrBO.prg
*
* Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCtr)
    this_cPkChave     = ""    && pkchave    char(20)  - PK
    this_cCodCors     = ""    && codcors    char(4)
    this_cCodigos     = ""    && codigos    char(10)
    this_cCodTams     = ""    && codtams    char(4)
    this_cCpros       = ""    && cpros      char(14)
    this_dDatas       = {}    && datas      datetime  NULL
    this_dDtAlts      = {}    && dtalts     datetime  NULL
    this_nQtdos       = 0     && qtdos      numeric(10,2)
    this_nQtds        = 0     && qtds       numeric(10,2)
    this_cUsuAlts     = ""    && usualts    char(10)
    this_cUsuars      = ""    && usuars     char(10)
    this_cOriDopNums  = ""    && oridopnums char(29)
    this_cContas      = ""    && contas     char(10)
    this_nPrecific    = 0     && precific   numeric(1,0)
    this_cMoedas      = ""    && moedas     char(3)
    this_cArquivo     = ""    && arquivo    char(200)
    this_cFkChaves    = ""    && fkchaves   char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCtr"
            THIS.this_cCampoChave = "pkchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCtrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do registro atual (RegistrarAuditoria)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
    ENDFUNC

    *====================================================================
    * CarregarCambio - fCarregarCambio (SIGFUNCS.PRG) do legado NAO foi
    * portada para utils/functions.prg (memoria: fCarregarCambio_nao_portada).
    * Usa os cursores crSigCdCot/crSigCdMoe (carregados pelo Form no Init,
    * mesma sessao - FormSigPrCtr nao declara DataSession proprio). PUBLIC
    * (nao PROTECTED) - chamada pelo Form em ExecutarProcessamentoXml.
    *====================================================================
    FUNCTION CarregarCambio(par_cMoeda, par_xData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(par_cMoeda)

        DO CASE
            CASE VARTYPE(par_xData) == "T"
                loc_dData = ConverterParaData(par_xData)
            CASE VARTYPE(par_xData) == "D"
                loc_dData = par_xData
            OTHERWISE
                loc_dData = DATE()
        ENDCASE

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(loc_cMoeda) AND crSigCdMoe.Cotas <> 0
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK loc_cMoeda + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda
                            loc_nCotacao = crSigCdCot.Valos
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *====================================================================
    * ValidarDados - Validacao chamada pelo BusinessBase.Salvar() antes de
    * Inserir/Atualizar (legado: "Favor Informar uma Conta." - guard no
    * inicio do Lerxml/processar do Pageframe1.Page1 - comportamento.json).
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cContas))
            THIS.this_cMensagemErro = "Favor Informar uma Conta."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor (estrutura de dbo.SigPrCtr - docs/schema.sql).
    * REGRA: OriDopNums eh chave POSICIONAL (Emps char(3)+Dopes char(20)+
    * Str(Numes,6) = 29) - NUNCA aplicar ALLTRIM nela, o padding faz parte
    * da chave usada para casar com SigMvCab.EmpDopNums.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChave    = ALLTRIM(TratarNulo(pkchave, ""))
            THIS.this_cCodCors    = ALLTRIM(TratarNulo(codcors, ""))
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos, ""))
            THIS.this_cCodTams    = ALLTRIM(TratarNulo(codtams, ""))
            THIS.this_cCpros      = ALLTRIM(TratarNulo(cpros, ""))
            THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_nQtdos      = TratarNulo(qtdos, 0)
            THIS.this_nQtds       = TratarNulo(qtds, 0)
            THIS.this_cUsuAlts    = ALLTRIM(TratarNulo(usualts, ""))
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
            THIS.this_cOriDopNums = TratarNulo(oridopnums, "")
            THIS.this_cContas     = ALLTRIM(TratarNulo(contas, ""))
            THIS.this_nPrecific   = TratarNulo(precific, 0)
            THIS.this_cMoedas     = ALLTRIM(TratarNulo(moedas, ""))
            THIS.this_cArquivo    = ALLTRIM(TratarNulo(arquivo, ""))
            THIS.this_cFkChaves   = ALLTRIM(TratarNulo(fkchaves, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrCtr
    * Espelha o "Insert Into crSigPrCtr (...)" + "Replace PkChave With
    * fUniqueIds()" do Grupo_Salva.Salva.Click legado (modo INSERIR):
    * a chave primaria (pkchave) e o codigo de agrupamento (codigos) sao
    * gerados aqui quando ainda nao foram atribuidos pelo chamador.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigos = fGerMascara(fGerUniqueKey("SigPrCtr"))
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            THIS.this_cUsuars = IIF(!EMPTY(ALLTRIM(THIS.this_cUsuars)), THIS.this_cUsuars, ;
                IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCtr (pkchave, codcors, codigos, codtams, cpros,
                    datas, dtalts, qtdos, qtds, usualts, usuars, oridopnums,
                    contas, precific, moedas, arquivo, fkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cCodCors)>>,
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cArquivo)>>,
                    <<EscaparSQL(THIS.this_cFkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrCtr (WHERE pkchave)
    * Espelha "Replace DtAlts With Datetime() / UsuAlts With m.usuar" do
    * Grupo_Salva.Salva.Click legado (modo ALTERAR).
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDtAlts  = DATETIME()
            THIS.this_cUsuAlts = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, THIS.this_cUsuAlts)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCtr
                SET codcors    = <<EscaparSQL(THIS.this_cCodCors)>>,
                    codigos    = <<EscaparSQL(THIS.this_cCodigos)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTams)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCpros)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    dtalts     = <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    usualts    = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    precific   = <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoedas)>>,
                    arquivo    = <<EscaparSQL(THIS.this_cArquivo)>>,
                    fkchaves   = <<EscaparSQL(THIS.this_cFkChaves)>>
                WHERE pkchave = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega a linha mais representativa do agrupamento
    * "Codigos" (legado: crSigPrCtr requerido pela Grade da Lista, que
    * agrupa por Codigos - regra #42/comportamento.json). Usada por
    * Alterar/Visualizar/Excluir para trazer Conta/Moeda/Arquivo/Precific
    * do "cabecalho" do lote antes de reconstruir as linhas em Confirmar.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrCtr WHERE codigos = " + ;
                EscaparSQL(par_cCodigo) + " ORDER BY pkchave"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaCtr")

            IF loc_nResultado >= 0 AND USED("cursor_4c_CarregaCtr") AND RECCOUNT("cursor_4c_CarregaCtr") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CarregaCtr")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui TODAS as linhas do lote "Codigos" (transcrito
    * literalmente do legado: "Delete From SigPrCtr Where Codigos = ?_Codigo",
    * msv_Alterar - comportamento.json). A Lista agrupa por Codigos (regra
    * #42), entao excluir eh excluir o lote inteiro, nao so a linha this_cPkChave.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

