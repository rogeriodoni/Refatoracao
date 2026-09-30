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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3470 linhas total):

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

*-- Linhas 473 a 537:
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
486:             loc_dDataIni     = ConverterParaData(loc_oPagina.txt_4c_Dt_inicial.Value)
487:             loc_dDataFimBase = ConverterParaData(loc_oPagina.txt_4c_Dt_final.Value)
488:             loc_tDataFim = DATETIME(YEAR(loc_dDataFimBase), MONTH(loc_dDataFimBase), ;
489:                 DAY(loc_dDataFimBase), 23, 59, 59)
490: 
491:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
492:                 SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas, a.OriDopNums,
493:                     a.Usuars, a.Contas, b.Rclis
494:                 FROM SigPrCtr a
495:                 JOIN SigCdCli b ON a.Contas = b.Iclis
496:                 WHERE a.Datas BETWEEN <<FormatarDataSQL(loc_dDataIni)>> AND <<FormatarDataSQL(loc_tDataFim)>>
497:                 GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis
498:             ENDTEXT
499: 
500:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
501: 
502:             IF loc_nResultado >= 0
503:                 loc_oGrid.ColumnCount           = 6
504:                 loc_oGrid.RecordSource          = "cursor_4c_Lista"
505:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.Codigos"
506:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.Datas"
507:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.OriDopNums"
508:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.Usuars"
509:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.Contas"
510:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"
511: 
512:                 *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
513:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
514:                 loc_oGrid.Column2.Header1.Caption = "Data"
515:                 loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
516:                 loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
517:                 loc_oGrid.Column5.Header1.Caption = "Fornecedor"
518:                 loc_oGrid.Column6.Header1.Caption = "Nome"
519: 
520:                 THIS.FormatarGridLista(loc_oGrid)
521: 
522:                 *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
523:                 *-- recalculam a largura para o default 90 - so fica se atribuido
524:                 *-- DEPOIS do FormatarGridLista)
525:                 loc_oGrid.Column1.Width = 80
526:                 loc_oGrid.Column2.Width = 75
527:                 loc_oGrid.Column3.Width = 280
528:                 loc_oGrid.Column4.Width = 80
529:                 loc_oGrid.Column5.Width = 80
530:                 loc_oGrid.Column6.Width = 180
531: 
532:                 IF USED("cursor_4c_Lista")
533:                     GO TOP IN cursor_4c_Lista
534:                 ENDIF
535:                 loc_oGrid.Refresh()
536:                 loc_lResultado = .T.
537:             ELSE

*-- Linhas 1086 a 1104:
1086:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
1087:         loc_oGrid.AllowHeaderSizing  = .F.
1088:         loc_oGrid.AllowRowSizing     = .F.
1089:         loc_oGrid.DeleteMark         = .F.
1090:         loc_oGrid.RecordMark         = .T.
1091:         loc_oGrid.RowHeight          = 16
1092:         loc_oGrid.ScrollBars         = 2
1093:         loc_oGrid.GridLines          = 3
1094:         loc_oGrid.ReadOnly           = .T.
1095:         WITH loc_oGrid
1096:             .Column1.Width               = 70
1097:             .Column1.Header1.Alignment   = 2
1098:             .Column1.Header1.Caption     = "Empresa"
1099:             .Column1.Header1.ForeColor   = RGB(90, 90, 90)
1100:             .Column1.Header1.BackColor   = RGB(192, 192, 192)
1101: 
1102:             .Column2.Width               = 200
1103:             .Column2.Header1.Alignment   = 2
1104:             .Column2.Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"

*-- Linhas 1654 a 1672:
1654:     * img_4c_FigJpg (foto do produto) e os botoes de exclusao de linha
1655:     * (btnExcluirSis/btnExcluirArq). Os demais controles desta aba (labels e
1656:     * TextBox de exibicao) ja foram criados em ConfigurarPaginaDados.
1657:     * ControlSource dos grids NAO e atribuido aqui - crMovimentos/crDistribui
1658:     * ainda nao existem neste ponto do Init (regra #41); e feito em
1659:     * ExecutarProcessamentoXml, quando os cursores ja foram criados.
1660:     *===========================================================================
1661:     PROTECTED PROCEDURE ConfigurarPgPage2()
1662:         LOCAL loc_oAba2, loc_oGrid
1663:         loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
1664: 
1665:         *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
1666:         loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
1667:         WITH loc_oAba2.shp_4c_Shape5
1668:             .Top         = 1
1669:             .Left        = 424
1670:             .Width       = 282
1671:             .Height      = 113
1672:             .BackStyle   = 0

*-- Linhas 1903 a 1941:
1903:             loc_oGrid.RecordSource = ""
1904: 
1905:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
1906:                 SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes,
1907:                     a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas
1908:                 FROM SigMvCab a
1909:                 JOIN SigCdOpe b ON a.dopes = b.dopes
1910:                 JOIN SigOpCdd c ON b.dopes = c.dopes
1911:                 WHERE c.Distribui = 3
1912:                     AND a.chksubn = 0
1913:                     AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)
1914:                     <<IIF(par_lFiltra AND !EMPTY(loc_cConta), " AND a.ContaOs = " + EscaparSQL(loc_cConta), "")>>
1915:             ENDTEXT
1916: 
1917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
1918: 
1919:             IF loc_nResultado >= 0
1920:                 loc_oGrid.ColumnCount            = 5
1921:                 loc_oGrid.RecordSource           = "cursor_4c_Estoque"
1922:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Estoque.Emps"
1923:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Dopes"
1924:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Numes"
1925:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
1926:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"
1927: 
1928:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1929:                 loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1930:                 loc_oGrid.Column3.Header1.Caption = "Numero"
1931:                 loc_oGrid.Column4.Header1.Caption = "Grupo"
1932:                 loc_oGrid.Column5.Header1.Caption = "Conta"
1933: 
1934:                 loc_oGrid.Column1.Width = 70
1935:                 loc_oGrid.Column2.Width = 200
1936:                 loc_oGrid.Column3.Width = 80
1937:                 loc_oGrid.Column4.Width = 80
1938:                 loc_oGrid.Column5.Width = 80
1939: 
1940:                 IF USED("cursor_4c_Estoque")
1941:                     GO TOP IN cursor_4c_Estoque

*-- Linhas 1960 a 1978:
1960:         LOCAL loc_oGrid, loc_nI
1961:         TRY
1962:             IF USED("cursor_4c_Estoque")
1963:                 SELECT cursor_4c_Estoque
1964:                 INDEX ON &par_cCampo TAG (par_cCampo)
1965:             ENDIF
1966: 
1967:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1968:             FOR loc_nI = 1 TO loc_oGrid.ColumnCount
1969:                 loc_oGrid.Columns(loc_nI).Header1.BackColor = IIF(loc_nI = par_nColuna, ;
1970:                     RGB(251, 253, 176), RGB(192, 192, 192))
1971:             ENDFOR
1972:             loc_oGrid.Refresh()
1973:         CATCH TO loException
1974:             MostrarErro(loException, "FormSigPrCtr.OrdenarEstoquePorCampo")
1975:         ENDTRY
1976:     ENDPROC
1977: 
1978:     PROCEDURE OrdenarEstoquePorEmpresa()

*-- Linhas 2106 a 2134:
2106:                 IF USED("cursor_4c_TmpOpe")
2107:                     USE IN cursor_4c_TmpOpe
2108:                 ENDIF
2109:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2110:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpe")
2111: 
2112:                 IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2113:                     loc_cClasseForm = "FormSigMvExp"
2114:                 ELSE
2115:                     IF USED("cursor_4c_TmpOpd")
2116:                         USE IN cursor_4c_TmpOpd
2117:                     ENDIF
2118:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2119:                         "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpd")
2120: 
2121:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpd") AND RECCOUNT("cursor_4c_TmpOpd") > 0
2122:                         loc_cClasseForm = "FormSigMvPdt"
2123:                     ENDIF
2124:                 ENDIF
2125: 
2126:                 IF USED("cursor_4c_TmpOpe")
2127:                     USE IN cursor_4c_TmpOpe
2128:                 ENDIF
2129:                 IF USED("cursor_4c_TmpOpd")
2130:                     USE IN cursor_4c_TmpOpd
2131:                 ENDIF
2132:             ENDIF
2133:         CATCH TO loException
2134:             MostrarErro(loException, "FormSigPrCtr.AbrirMovimentoSelecionado")

*-- Linhas 2158 a 2186:
2158:     *===========================================================================
2159:     PROTECTED PROCEDURE CriarCursoresXml()
2160:         IF !USED("csPrNAOCad")
2161:             CREATE CURSOR csPrNAOCad (Referencia C(25), Unidade C(3), Qtds N(12,2), Pesos N(12,2), Valor N(12,2))
2162:         ENDIF
2163: 
2164:         IF !USED("crItens")
2165:             CREATE CURSOR crItens (codigo C(15), Descr C(30), quant C(15), valor_uni C(15), valor_tot C(15), ;
2166:                 base_icm C(15), valor_icm C(15), aliq_icm C(15), base_ipi C(15), valor_ipi C(15), aliq_ipi C(15), ;
2167:                 unid C(5), cfop C(4), ncm C(8), desconto C(15), frete C(15))
2168:         ENDIF
2169: 
2170:         IF !USED("crResultado")
2171:             CREATE CURSOR crResultado (xTp C(1), cpros C(14), dpros C(60), Qtds N(12,2), Units N(12,2), Total N(12,2))
2172:         ENDIF
2173:     ENDPROC
2174: 
2175:     *===========================================================================
2176:     * CarregarArquivosXml - Confere o CPF/CNPJ do fornecedor contra a chave de
2177:     * acesso do XML e decide se prossegue com a leitura (legado: PROCEDURE
2178:     * carregaarquivos - o parametro pTipo legado so controla se Lerxml roda).
2179:     *===========================================================================
2180:     PROTECTED PROCEDURE CarregarArquivosXml(par_lProcessar)
2181:         LOCAL loc_oPagina, loc_cArquivo, loc_cCgc, loc_cConteudo, loc_cChave, ;
2182:             loc_cCgcXml, loc_lOk, loc_cMsg
2183: 
2184:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2185: 
2186:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))

*-- Linhas 2249 a 2291:
2249:                 MsgErro(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2250:             ELSE
2251:                 IF UPPER(loc_oXml.DocumentElement.BaseName) = "NFEPROC"
2252:                     loc_nQtdItens      = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2253:                     loc_nContaDesconto = 0
2254: 
2255:                     SELECT crItens
2256:                     FOR loc_nI = 0 TO loc_nQtdItens - 1
2257:                         loc_oItem = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_nI)
2258: 
2259:                         APPEND BLANK IN crItens
2260:                         REPLACE codigo    WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").ItemText, ;
2261:                                 Descr     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").ItemText, ;
2262:                                 quant     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").ItemText, ;
2263:                                 valor_uni WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").ItemText, ;
2264:                                 valor_tot WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").ItemText, ;
2265:                                 unid      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").ItemText, ;
2266:                                 cfop      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").ItemText, ;
2267:                                 ncm       WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").ItemText ;
2268:                                 IN crItens
2269: 
2270:                         IF loc_oItem.SelectNodes("prod/vDesc").Length > 0
2271:                             REPLACE desconto WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").ItemText IN crItens
2272:                             loc_nContaDesconto = loc_nContaDesconto + 1
2273:                         ENDIF
2274: 
2275:                         IF loc_oItem.SelectNodes("prod/vFrete").Length > 0
2276:                             REPLACE frete WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").ItemText IN crItens
2277:                         ENDIF
2278:                     ENDFOR
2279: 
2280:                     loc_lSucesso = .T.
2281:                 ELSE
2282:                     MsgAviso(par_cArquivo + " n" + CHR(227) + "o " + CHR(233) + " uma nota fiscal com autoriza" + CHR(231) + CHR(227) + "o!", "Aviso")
2283:                 ENDIF
2284:             ENDIF
2285:         CATCH TO loException
2286:             MostrarErro(loException, "FormSigPrCtr.LerArquivoXml")
2287:         ENDTRY
2288: 
2289:         RETURN loc_lSucesso
2290:     ENDPROC
2291: 

*-- Linhas 2306 a 2447:
2306:         ENDIF
2307: 
2308:         TRY
2309:             SELECT crItens
2310:             GO TOP IN crItens
2311:             SCAN
2312:                 loc_cProd  = NVL(crItens.codigo, "")
2313:                 loc_nQtds  = IIF(TYPE("crItens.quant") = "N", NVL(crItens.quant, 0), VAL(NVL(crItens.quant, "")))
2314:                 loc_cCunis = IIF(INLIST(TYPE("crItens.unid"), "C", "M"), NVL(crItens.unid, ""), "")
2315:                 loc_nVal   = IIF(INLIST(TYPE("crItens.valor_uni"), "C", "M"), VAL(NVL(crItens.valor_uni, "")), ;
2316:                     IIF(TYPE("crItens.valor_uni") = "N", NVL(crItens.valor_uni, 0), 0))
2317:                 loc_nTot   = IIF(INLIST(TYPE("crItens.valor_tot"), "C", "M"), VAL(NVL(crItens.valor_tot, "")), ;
2318:                     IIF(TYPE("crItens.valor_tot") = "N", NVL(crItens.valor_tot, 0), 0))
2319:                 loc_nBaseIcm  = IIF(INLIST(TYPE("crItens.base_icm"), "C", "M"), VAL(NVL(crItens.base_icm, "")), ;
2320:                     IIF(TYPE("crItens.base_icm") = "N", NVL(crItens.base_icm, 0), 0))
2321:                 loc_nValorIpi = IIF(INLIST(TYPE("crItens.valor_ipi"), "C", "M"), VAL(NVL(crItens.valor_ipi, "")), ;
2322:                     IIF(TYPE("crItens.valor_ipi") = "N", NVL(crItens.valor_ipi, 0), 0))
2323: 
2324:                 IF !EMPTY(loc_cProd)
2325:                     IF USED("ProdImport")
2326:                         USE IN ProdImport
2327:                     ENDIF
2328:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2329:                         "SELECT * FROM SigCdPro WHERE Reffs = " + EscaparSQL(loc_cProd), "ProdImport")
2330:                     IF loc_nResultado < 1
2331:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2332:                         LOOP
2333:                     ENDIF
2334: 
2335:                     IF RECCOUNT("ProdImport") = 0
2336:                         USE IN ProdImport
2337:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2338:                             "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cProd), "ProdImport")
2339:                         IF loc_nResultado < 1
2340:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2341:                             LOOP
2342:                         ENDIF
2343:                     ENDIF
2344: 
2345:                     IF RECCOUNT("ProdImport") = 0
2346:                         USE IN ProdImport
2347:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2348:                             "SELECT * FROM SigCdPro WHERE Dpros = " + EscaparSQL(loc_cProd), "ProdImport")
2349:                         IF loc_nResultado < 1
2350:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2351:                             LOOP
2352:                         ENDIF
2353:                     ENDIF
2354: 
2355:                     IF RECCOUNT("ProdImport") = 0
2356:                         USE IN ProdImport
2357:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2358:                             "SELECT * FROM SigCdPro WHERE Dpro2s = " + EscaparSQL(loc_cProd), "ProdImport")
2359:                         IF loc_nResultado < 1
2360:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2361:                             LOOP
2362:                         ENDIF
2363:                     ENDIF
2364: 
2365:                     IF USED("ProdImport") AND !EMPTY(NVL(ProdImport.Cpros, ""))
2366:                         loc_cCunis = IIF(EMPTY(ProdImport.Cunis), loc_cCunis, ProdImport.Cunis)
2367: 
2368:                         IF USED("crTmpUni")
2369:                             USE IN crTmpUni
2370:                         ENDIF
2371:                         SQLEXEC(gnConnHandle, ;
2372:                             "SELECT * FROM SigCdUni WHERE CUnis = " + EscaparSQL(loc_cCunis) + " ORDER BY Etiqs", "crTmpUni")
2373: 
2374:                         IF USED("crTmpGru")
2375:                             USE IN crTmpGru
2376:                         ENDIF
2377:                         SQLEXEC(gnConnHandle, ;
2378:                             "SELECT TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas, mtPrimas, LocalPdr " + ;
2379:                             "FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ProdImport.CGrus) + ;
2380:                             " ORDER BY TipoEstos, Mercs, Cores, Tams, Embs, Cgrus, Dgrus, Pesos, Entregas", "crTmpGru")
2381: 
2382:                         loc_cTp = " "
2383:                         IF (loc_nBaseIcm + loc_nValorIpi) != 0 AND ProdImport.CustoFs != (loc_nBaseIcm + loc_nValorIpi)
2384:                             loc_nVariaProd = ROUND(ProdImport.CustoFs * 0.05, 2) + ProdImport.CustoFs
2385:                             IF loc_nVariaProd < (loc_nBaseIcm + loc_nValorIpi)
2386:                                 loc_cTp = "X"
2387:                             ENDIF
2388:                         ENDIF
2389: 
2390:                         SELECT crResultado
2391:                         APPEND BLANK
2392:                         REPLACE Cpros WITH ProdImport.Cpros, ;
2393:                                 dpros WITH ProdImport.Dpros, ;
2394:                                 xTp   WITH loc_cTp, ;
2395:                                 Qtds  WITH loc_nQtds, ;
2396:                                 Units WITH loc_nVal, ;
2397:                                 Total WITH loc_nTot IN crResultado
2398:                     ELSE
2399:                         SELECT csPrNAOCad
2400:                         APPEND BLANK
2401:                         REPLACE Referencia WITH NVL(loc_cProd, ""), ;
2402:                                 Qtds       WITH NVL(loc_nQtds, 0), ;
2403:                                 Pesos      WITH 0, ;
2404:                                 Unidade    WITH NVL(loc_cCunis, ""), ;
2405:                                 Valor      WITH NVL(loc_nVal, 0) IN csPrNAOCad
2406:                     ENDIF
2407: 
2408:                     IF USED("ProdImport")
2409:                         USE IN ProdImport
2410:                     ENDIF
2411:                 ENDIF
2412: 
2413:                 SELECT crItens
2414:             ENDSCAN
2415:         CATCH TO loException
2416:             MostrarErro(loException, "FormSigPrCtr.CarregarItensXmlNaGrade")
2417:         ENDTRY
2418: 
2419:         IF USED("csPrNAOCad")
2420:             SELECT csPrNAOCad
2421:             GO TOP
2422:             IF RECCOUNT("csPrNAOCad") > 0
2423:                 loc_cArquivoSaida = ADDBS(SYS(5) + SYS(2003)) + "Produtos_Nao_Localizados"
2424:                 MsgAviso("Houve produtos n" + CHR(227) + "o Localizados" + CHR(13) + CHR(13) + ;
2425:                     "Arquivo : " + loc_cArquivoSaida + ".XLS", "Aten" + CHR(231) + CHR(227) + "o")
2426:                 SELECT csPrNAOCad
2427:                 COPY TO (loc_cArquivoSaida) XL5
2428:             ENDIF
2429:         ENDIF
2430: 
2431:         IF USED("crItens")
2432:             SELECT crItens
2433:             GO TOP
2434:         ENDIF
2435: 
2436:         RETURN .T.
2437:     ENDPROC
2438: 
2439:     *===========================================================================
2440:     * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
2441:     * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
2442:     *===========================================================================
2443:     PROCEDURE ProcessarArquivoXmlClick()
2444:         LOCAL loc_oPagina
2445:         TRY
2446:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2447: 

*-- Linhas 2498 a 2614:
2498:             loc_nCotaMoe   = THIS.this_oBusinessObject.CarregarCambio(loc_cMoedaBase, DATE())
2499: 
2500:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2501:                 SELECT a.Cpros, f.Dpros, a.units,
2502:                     SUM(a.qtds) AS qtds, SUM(a.qtbaixas) AS qtbaixas, SUM(a.qtreservas) AS qtreservas,
2503:                     (SUM(a.qtds) - SUM(a.qtbaixas) - SUM(a.qtreservas)) AS Saldo,
2504:                     a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus, a.cidchaves, a.Moedas
2505:                 FROM SigMvItn a
2506:                 JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums
2507:                 JOIN SigCdOpe d ON c.dopes = d.dopes
2508:                 JOIN SigOpCdd e ON d.dopes = e.dopes
2509:                 JOIN SigCdPro f ON a.Cpros = f.Cpros
2510:                 WHERE e.Distribui = 3
2511:                     AND c.GrupoOs <> SPACE(10)
2512:                     AND c.ContaOs <> SPACE(10)
2513:                     AND a.citem2 = 0
2514:                     AND a.qtds <> a.qtbaixas
2515:                     AND a.EmpDopNums IN (<<EscaparSQL(loc_cOriDopNums)>>)
2516:                 GROUP BY a.CPros, f.Dpros, f.Cgrus, f.Sgrus, a.EmpDopNums, a.units, a.cidchaves, a.Moedas
2517:             ENDTEXT
2518: 
2519:             IF USED("crMovimentos")
2520:                 USE IN crMovimentos
2521:             ENDIF
2522:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMovimentos")
2523: 
2524:             IF loc_nResultado < 1
2525:                 MsgAviso("Problemas no Select dos Produtos da Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2526:             ELSE
2527:                 SELECT crMovimentos
2528:                 INDEX ON Cgrus TAG Cgrus
2529:                 INDEX ON Cpros TAG Cpros
2530:                 SET ORDER TO Cpros
2531:                 GO TOP
2532: 
2533:                 THIS.CriarCursoresXml()
2534:                 SELECT crItens
2535:                 ZAP
2536:                 SELECT csPrNAOCad
2537:                 ZAP
2538:                 SELECT crResultado
2539:                 ZAP
2540: 
2541:                 THIS.CarregarArquivosXml(.T.)
2542:                 THIS.CarregarItensXmlNaGrade()
2543: 
2544:                 IF USED("crDistribui")
2545:                     USE IN crDistribui
2546:                 ENDIF
2547:                 SELECT Cpros, Dpros, SUM(Qtds) AS Qtds, MAX(Units) AS Units, SUM(Total) AS Total ;
2548:                     FROM crResultado ;
2549:                     GROUP BY Cpros, Dpros ;
2550:                     INTO CURSOR crDistribui READWRITE
2551: 
2552:                 SELECT crDistribui
2553:                 INDEX ON cPros TAG Tag1
2554:                 SET ORDER TO Tag1
2555: 
2556:                 loc_oGridItem.RecordSource          = "crDistribui"
2557:                 loc_oGridItem.Column1.ControlSource = "crDistribui.Cpros"
2558:                 loc_oGridItem.Column2.ControlSource = "crDistribui.Dpros"
2559:                 loc_oGridItem.Column3.ControlSource = "crDistribui.Qtds"
2560:                 loc_oGridItem.Column4.ControlSource = "crDistribui.Units"
2561: 
2562:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2563:                 *-- reaplicar OS DOIS depois do ControlSource
2564:                 loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2565:                 loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2566:                 loc_oGridItem.Column3.Header1.Caption = "Quantidade"
2567:                 loc_oGridItem.Column4.Header1.Caption = "Valor"
2568:                 loc_oGridItem.Column1.Width = 100
2569:                 loc_oGridItem.Column2.Width = 235
2570:                 loc_oGridItem.Column3.Width = 63
2571:                 loc_oGridItem.Column4.Width = 70
2572: 
2573:                 SELECT crMovimentos
2574:                 DO CASE
2575:                     CASE loc_nTipo = 1
2576:                         DELETE FROM crMovimentos WHERE Cpros NOT IN (SELECT Cpros FROM crDistribui)
2577:                     CASE loc_nTipo = 2
2578:                         DELETE FROM crMovimentos WHERE Cpros IN (SELECT Cpros FROM crDistribui)
2579:                 ENDCASE
2580:                 GO TOP IN crMovimentos
2581: 
2582:                 SELECT crMovimentos
2583:                 SCAN FOR !DELETED()
2584:                     loc_nCotacao = THIS.this_oBusinessObject.CarregarCambio(crMovimentos.Moedas, DATE())
2585:                     loc_nUnits   = ROUND(crMovimentos.Units * loc_nCotacao / loc_nCotaMoe, 2)
2586:                     REPLACE Units WITH loc_nUnits IN crMovimentos
2587:                 ENDSCAN
2588: 
2589:                 loc_oGridDisp.RecordSource          = "crMovimentos"
2590:                 loc_oGridDisp.Column1.ControlSource = "crMovimentos.Cpros"
2591:                 loc_oGridDisp.Column2.ControlSource = "crMovimentos.Dpros"
2592:                 loc_oGridDisp.Column3.ControlSource = "crMovimentos.units"
2593:                 loc_oGridDisp.Column4.ControlSource = "crMovimentos.qtds"
2594:                 loc_oGridDisp.Column5.ControlSource = "crMovimentos.qtbaixas"
2595:                 loc_oGridDisp.Column6.ControlSource = "crMovimentos.qtreservas"
2596:                 loc_oGridDisp.Column7.ControlSource = "crMovimentos.Saldo"
2597: 
2598:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2599:                 *-- reaplicar OS DOIS depois do ControlSource
2600:                 loc_oGridDisp.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2601:                 loc_oGridDisp.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2602:                 loc_oGridDisp.Column3.Header1.Caption = "Valor"
2603:                 loc_oGridDisp.Column4.Header1.Caption = "Quantidade"
2604:                 loc_oGridDisp.Column5.Header1.Caption = "Baixado"
2605:                 loc_oGridDisp.Column6.Header1.Caption = "Reservado"
2606:                 loc_oGridDisp.Column7.Header1.Caption = "Saldo"
2607:                 loc_oGridDisp.Column1.Width = 100
2608:                 loc_oGridDisp.Column2.Width = 235
2609:                 loc_oGridDisp.Column3.Width = 70
2610:                 loc_oGridDisp.Column4.Width = 63
2611:                 loc_oGridDisp.Column5.Width = 63
2612:                 loc_oGridDisp.Column6.Width = 63
2613:                 loc_oGridDisp.Column7.Width = 63
2614: 

*-- Linhas 2640 a 2659:
2640:                 IF USED("cursor_4c_TmpCli")
2641:                     USE IN cursor_4c_TmpCli
2642:                 ENDIF
2643:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2644:                     "SELECT Cpfs, Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
2645:                     "cursor_4c_TmpCli")
2646: 
2647:                 IF loc_nResultado >= 0 AND USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
2648:                     par_oPagina.txt_4c_Cpf.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Cpfs, ""))
2649:                     IF EMPTY(ALLTRIM(par_oPagina.txt_4c_Grupo.Value))
2650:                         par_oPagina.txt_4c_Grupo.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
2651:                     ENDIF
2652:                 ENDIF
2653: 
2654:                 IF USED("cursor_4c_TmpCli")
2655:                     USE IN cursor_4c_TmpCli
2656:                 ENDIF
2657: 
2658:                 THIS.MontaGrade(.T.)
2659:             ENDIF

*-- Linhas 2766 a 2786:
2766:                     IF USED("cursor_4c_BuscaCli")
2767:                         USE IN cursor_4c_BuscaCli
2768:                     ENDIF
2769:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2770:                         "SELECT IClis, RClis, Cpfs, Grupos FROM SigCdCli WHERE Cpfs = " + ;
2771:                         EscaparSQL(PADR(ALLTRIM(loc_cCgcFmt), 20)), "cursor_4c_BuscaCli")
2772: 
2773:                     IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaCli") AND !EOF("cursor_4c_BuscaCli")
2774:                         loc_cGrupo = loc_oPagina.txt_4c_Grupo.Value
2775:                         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ;
2776:                                 ALLTRIM(cursor_4c_BuscaCli.IClis), loc_oPagina.txt_4c_Conta.Value, loc_oPagina.txt_4c_Dconta.Value)
2777:                             MsgErro("Acesso Negado !!", "Aviso")
2778:                             loc_oPagina.txt_4c_Conta.Value  = ""
2779:                             loc_oPagina.txt_4c_Dconta.Value = ""
2780:                             loc_oPagina.txt_4c_Cpf.Value    = ""
2781:                         ELSE
2782:                             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.IClis)
2783:                             loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
2784:                             loc_oPagina.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2785: 
2786:                             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))

*-- Linhas 2878 a 2922:
2878:     *
2879:     * Colunas de SigCdPro lidas no legado mas NUNCA consumidas depois
2880:     * (cgrus/sgrus/CodCors - so alimentavam a consulta morta a SigCdPsg/
2881:     * Tmp_Sgru) e os LEFT JOINs com SigCdUni/SigCdCol/SigCdLin/SigPrFti/
2882:     * SigCdCli/SigCdGpr/SigCdFip (cujas colunas tambem nunca sao lidas) sao
2883:     * leitura morta - omitidas aqui, mesmo criterio ja aplicado em
2884:     * LerArquivoXml para os campos de cabecalho da NF-e nao referenciados.
2885:     *===========================================================================
2886:     PROCEDURE AtualizarDetalhesProdutoSelecionado(par_nColIndex)
2887:         LOCAL loc_oAba2, loc_cSQL, loc_nResultado, loc_cArquivoImg, loc_cFoto, ;
2888:             loc_nCotacao, loc_nCotVen, loc_nPrVenda, loc_cPrVendaMoeda, ;
2889:             loc_nFatArred, loc_nSoma
2890: 
2891:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2892:             RETURN
2893:         ENDIF
2894: 
2895:         TRY
2896:             loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2897: 
2898:             IF USED("CrTSigPro")
2899:                 USE IN CrTSigPro
2900:             ENDIF
2901: 
2902:             loc_cSQL = "SELECT a.Cpros, a.Reffs, a.Pesoms, a.Moecusfs, a.Custofs, a.Pcuss, " + ;
2903:                 "a.Pvens, a.Moevs, a.FigJpgs, g.Arreds " + ;
2904:                 "FROM SigCdPro a LEFT JOIN SigCdGrp g ON a.Cgrus = g.Cgrus " + ;
2905:                 "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(crMovimentos.Cpros))
2906: 
2907:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrTSigPro")
2908: 
2909:             IF loc_nResultado < 1 OR !USED("CrTSigPro") OR EOF("CrTSigPro")
2910:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
2911:             ELSE
2912:                 loc_oAba2.txt_4c_RefFornecedor.Value = TratarNulo(CrTSigPro.Reffs, "")
2913:                 loc_oAba2.txt_4c_PesoMedio.Value      = TratarNulo(CrTSigPro.Pesoms, 0)
2914:                 loc_oAba2.txt_4c_MoeCusFs.Value        = TratarNulo(CrTSigPro.Moecusfs, "")
2915:                 loc_oAba2.txt_4c_CustoFs.Value          = TratarNulo(CrTSigPro.Custofs, 0)
2916:                 loc_oAba2.txt_4c_PrecoMov.Value         = TratarNulo(CrTSigPro.Pcuss, 0)
2917: 
2918:                 loc_oAba2.txt_4c_MovCidChaves.Value = TratarNulo(crMovimentos.cidchaves, "")
2919:                 loc_oAba2.txt_4c_MovEmps.Value       = SUBSTR(crMovimentos.OriDopNums, 1, 3)
2920:                 loc_oAba2.txt_4c_MovDopes.Value      = SUBSTR(crMovimentos.OriDopNums, 4, 20)
2921:                 loc_oAba2.txt_4c_MovNumes.Value      = ALLTRIM(RIGHT(crMovimentos.OriDopNums, 6))
2922: 

*-- Linhas 2942 a 2965:
2942:                     loc_nPrVenda      = TratarNulo(CrTSigPro.Pvens, 0)
2943:                     loc_cPrVendaMoeda = TratarNulo(CrTSigPro.Moevs, "")
2944:                 ELSE
2945:                     SELECT crSigCdCot
2946:                     GO TOP
2947:                     LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(crSigCdPam.moedetqs)
2948:                     loc_nCotacao = IIF(FOUND(), crSigCdCot.valos, 1)
2949: 
2950:                     SELECT crSigCdCot
2951:                     GO TOP
2952:                     LOCATE FOR ALLTRIM(cmoes) == ALLTRIM(CrTSigPro.Moevs)
2953:                     loc_nCotVen  = IIF(FOUND(), crSigCdCot.valos, 1)
2954: 
2955:                     loc_nPrVenda      = ROUND(CrTSigPro.Pvens * loc_nCotVen / loc_nCotacao, 2)
2956:                     loc_cPrVendaMoeda = ALLTRIM(crSigCdPam.moedetqs)
2957:                 ENDIF
2958: 
2959:                 IF CrTSigPro.Arreds != 0
2960:                     loc_nFatArred = CrTSigPro.Arreds
2961:                     loc_nSoma     = loc_nFatArred
2962:                     DO WHILE loc_nSoma < loc_nPrVenda
2963:                         loc_nSoma = loc_nSoma + loc_nFatArred
2964:                     ENDDO
2965:                     loc_nPrVenda = loc_nSoma

*-- Linhas 3029 a 3049:
3029:             IF USED("cursor_4c_FotoZoom")
3030:                 USE IN cursor_4c_FotoZoom
3031:             ENDIF
3032:             loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
3033:                 EscaparSQL(ALLTRIM(crMovimentos.Cpros))
3034:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoZoom")
3035: 
3036:             IF loc_nResultado >= 0 AND USED("cursor_4c_FotoZoom") AND !EOF("cursor_4c_FotoZoom") ;
3037:                     AND !ISNULL(cursor_4c_FotoZoom.FigJpgs) AND !EMPTY(cursor_4c_FotoZoom.FigJpgs)
3038:                 STRTOFILE(cursor_4c_FotoZoom.FigJpgs, loc_cArquivo)
3039:             ELSE
3040:                 loc_cArquivo = ""
3041:             ENDIF
3042: 
3043:             IF USED("cursor_4c_FotoZoom")
3044:                 USE IN cursor_4c_FotoZoom
3045:             ENDIF
3046:         CATCH TO loException
3047:             MostrarErro(loException, "FormSigPrCtr.FigJpgDblClick")
3048:             loc_cArquivo = ""
3049:         ENDTRY

*-- Linhas 3080 a 3100:
3080:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crMovimentos")
3081:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3082: 
3083:                 SELECT crMovimentos
3084:                 IF !EOF()
3085:                     DELETE
3086:                 ENDIF
3087:                 IF !EOF()
3088:                     SKIP
3089:                     SKIP -1
3090:                 ENDIF
3091:                 GO TOP
3092:                 loc_oAba2.grd_4c_Disponivel.SetFocus()
3093:                 loc_oAba2.grd_4c_Disponivel.Refresh()
3094:             ENDIF
3095:         CATCH TO loException
3096:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirSisClick")
3097:         ENDTRY
3098:     ENDPROC
3099: 
3100:     *===========================================================================

*-- Linhas 3108 a 3128:
3108:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crDistribui")
3109:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3110: 
3111:                 SELECT crDistribui
3112:                 IF !EOF()
3113:                     DELETE
3114:                 ENDIF
3115:                 IF !EOF()
3116:                     SKIP
3117:                     SKIP -1
3118:                 ENDIF
3119:                 GO TOP
3120:                 loc_oAba2.grd_4c_ItemXml.SetFocus()
3121:                 loc_oAba2.grd_4c_ItemXml.Refresh()
3122:             ENDIF
3123:         CATCH TO loException
3124:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirArqClick")
3125:         ENDTRY
3126:     ENDPROC
3127: 
3128:     *===========================================================================

*-- Linhas 3284 a 3302:
3284:             IF !loc_lTemSelecao
3285:                 MsgAviso("Selecione um registro na lista para alterar.", "Aviso")
3286:             ELSE
3287:                 SELECT cursor_4c_Lista
3288:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3289: 
3290:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3291:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3292:                 ELSE
3293:                     THIS.this_oBusinessObject.EditarRegistro()
3294:                     THIS.BOParaForm()
3295:                     THIS.this_cModoAtual = "ALTERAR"
3296:                     THIS.HabilitarCampos(.T.)
3297:                     THIS.AjustarBotoesPorModo()
3298:                     THIS.AlternarPagina(2)
3299:                 ENDIF
3300:             ENDIF
3301:         CATCH TO loException
3302:             MostrarErro(loException, "FormSigPrCtr.BtnAlterarClick")

*-- Linhas 3321 a 3377:
3321:             IF !loc_lTemSelecao
3322:                 MsgAviso("Selecione um registro na lista para visualizar.", "Aviso")
3323:             ELSE
3324:                 SELECT cursor_4c_Lista
3325:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3326: 
3327:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3328:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3329:                 ELSE
3330:                     THIS.BOParaForm()
3331:                     THIS.this_cModoAtual = "VISUALIZAR"
3332:                     THIS.HabilitarCampos(.F.)
3333:                     THIS.AjustarBotoesPorModo()
3334:                     THIS.AlternarPagina(2)
3335:                 ENDIF
3336:             ENDIF
3337:         CATCH TO loException
3338:             MostrarErro(loException, "FormSigPrCtr.BtnVisualizarClick")
3339:         ENDTRY
3340:     ENDPROC
3341: 
3342:     *===========================================================================
3343:     * BtnExcluirClick - Exclui o lote selecionado (todas as linhas do mesmo
3344:     * Codigos - legado: "Delete From SigPrCtr Where Codigos = ?_Codigo").
3345:     * Falha de gravacao nunca eh muda (regra #20) - BusinessBase.Excluir()
3346:     * ja chama MsgErro internamente quando necessario.
3347:     *===========================================================================
3348:     PROCEDURE BtnExcluirClick()
3349:         LOCAL loc_cCodigo, loc_lTemSelecao
3350:         loc_lTemSelecao = .F.
3351: 
3352:         TRY
3353:             IF USED("cursor_4c_Lista")
3354:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3355:                     loc_lTemSelecao = .T.
3356:                 ENDIF
3357:             ENDIF
3358: 
3359:             IF !loc_lTemSelecao
3360:                 MsgAviso("Selecione um registro na lista para excluir.", "Aviso")
3361:             ELSE
3362:                 SELECT cursor_4c_Lista
3363:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3364: 
3365:                 IF MsgConfirma("Deseja realmente excluir o registro " + loc_cCodigo + "?", ;
3366:                         "Confirmar Exclus" + CHR(227) + "o")
3367: 
3368:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3369:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3370:                     ELSE
3371:                         IF THIS.this_oBusinessObject.Excluir()
3372:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
3373:                             THIS.CarregarLista()
3374:                         ELSE
3375:                             IF !THIS.this_oBusinessObject.this_lErroExibido
3376:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
3377:                             ENDIF


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

