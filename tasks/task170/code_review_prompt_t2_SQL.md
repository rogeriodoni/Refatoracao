# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3616 linhas total):

*-- Linhas 427 a 462:
427: 
428:         *-- Grid de lista (Grade no legado: abaixo dos filtros)
429:         *-- Top=160 (abaixo dos filtros ~135+21=156); Width=form.Width-15; Height=450
430:         *-- ColumnCount e RecordSource/ControlSource: definidos FORA de WITH (Problema 36)
431:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
432:         loc_oGrid = loc_oPagina.grd_4c_Lista
433: 
434:         loc_oGrid.Top          = 160
435:         loc_oGrid.Left         = 5
436:         loc_oGrid.Width        = THIS.Width - 15
437:         loc_oGrid.Height       = 450
438:         loc_oGrid.ColumnCount  = 6
439:         loc_oGrid.FontName     = "Verdana"
440:         loc_oGrid.FontSize     = 8
441:         loc_oGrid.ForeColor    = RGB(90, 90, 90)
442:         loc_oGrid.BackColor    = RGB(255, 255, 255)
443:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
444:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
445:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
446:         loc_oGrid.HighlightStyle     = 2
447:         loc_oGrid.DeleteMark   = .F.
448:         loc_oGrid.RecordMark   = .F.
449:         loc_oGrid.RowHeight    = 16
450:         loc_oGrid.ScrollBars   = 3
451:         loc_oGrid.GridLines    = 3
452:         loc_oGrid.Visible      = .T.
453: 
454:         *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
455:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
456:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
457:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
458:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
459:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
460:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
461: 
462:         *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)

*-- Linhas 922 a 954:
922: 
923:         *-- Grid grd_4c_Estoque (top=206, left=307, width=545, height=340, 6 colunas)
924:         *-- Problema 36: ColumnCount FORA do WITH (criacao imediata das colunas)
925:         *-- Headers definidos aqui; RecordSource/ControlSource definidos em CarregarGradeEstoque
926:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
927:         loc_oPage.grd_4c_Estoque.ColumnCount = 6
928:         WITH loc_oPage.grd_4c_Estoque
929:             .Top       = 206
930:             .Left      = 307
931:             .Width     = 545
932:             .Height    = 340
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8
935:             .GridLines = 1
936:             .ReadOnly  = .T.
937:             .Visible   = .T.
938:             .RecordMark   = .F.
939:             .DeleteMark   = .F.
940:         ENDWITH
941:         WITH loc_oPage.grd_4c_Estoque.Column1
942:             .Width     = 25
943:             .Resizable = .F.
944:         ENDWITH
945:         loc_oPage.grd_4c_Estoque.Column1.Header1.Caption = ""
946:         WITH loc_oPage.grd_4c_Estoque.Column2
947:             .Width = 65
948:         ENDWITH
949:         loc_oPage.grd_4c_Estoque.Column2.Header1.Caption = "Empresa"
950:         WITH loc_oPage.grd_4c_Estoque.Column3
951:             .Width = 120
952:         ENDWITH
953:         loc_oPage.grd_4c_Estoque.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
954:         WITH loc_oPage.grd_4c_Estoque.Column4

*-- Linhas 1129 a 1147:
1129:             .GridLines = 1
1130:             .Visible   = .T.
1131:             .RecordMark   = .F.
1132:             .DeleteMark   = .F.
1133:         ENDWITH
1134:         WITH loc_oPage.grd_4c_Disponivel.Column1
1135:             .Width = 80
1136:         ENDWITH
1137:         WITH loc_oPage.grd_4c_Disponivel.Column2
1138:             .Width = 200
1139:         ENDWITH
1140:         WITH loc_oPage.grd_4c_Disponivel.Column3
1141:             .Width = 80
1142:         ENDWITH
1143:         WITH loc_oPage.grd_4c_Disponivel.Column4
1144:             .Width = 70
1145:         ENDWITH
1146:         WITH loc_oPage.grd_4c_Disponivel.Column5
1147:             .Width = 80

*-- Linhas 1166 a 1184:
1166:             .GridLines = 1
1167:             .Visible   = .T.
1168:             .RecordMark   = .F.
1169:             .DeleteMark   = .F.
1170:         ENDWITH
1171:         WITH loc_oPage.grd_4c_ItemXml.Column1
1172:             .Width = 100
1173:         ENDWITH
1174:         WITH loc_oPage.grd_4c_ItemXml.Column2
1175:             .Width = 220
1176:         ENDWITH
1177:         WITH loc_oPage.grd_4c_ItemXml.Column3
1178:             .Width = 80
1179:         ENDWITH
1180:         WITH loc_oPage.grd_4c_ItemXml.Column4
1181:             .Width = 93
1182:         ENDWITH
1183: 
1184:         *-- CommandButton btnExcluirSis (top=479, left=663, width=40, height=37)

*-- Linhas 1505 a 1524:
1505:         ENDIF
1506: 
1507:         TRY
1508:             loc_nRet = SQLEXEC(gnConnHandle, ;
1509:                 "SELECT TOP 1 Codigos FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo), ;
1510:                 "cursor_4c_BuscaGrupo")
1511: 
1512:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaGrupo") AND !EOF("cursor_4c_BuscaGrupo")
1513:                 *-- Grupo valido
1514:             ELSE
1515:                 THIS.AbrirBuscaGrupoAba()
1516:             ENDIF
1517: 
1518:             IF USED("cursor_4c_BuscaGrupo")
1519:                 USE IN cursor_4c_BuscaGrupo
1520:             ENDIF
1521:         CATCH TO loException
1522:             MsgErro(loException.Message, "Erro em ValidarGrupoAba")
1523:         ENDTRY
1524:     ENDPROC

*-- Linhas 1551 a 1570:
1551: 
1552:         TRY
1553:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1554:                 "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos LIKE " + ;
1555:                     EscaparSQL(loc_cGrupo + "%") + " ORDER BY Codigos", ;
1556:                 "cursor_4c_BusGrupo", ;
1557:                 gnConnHandle)
1558: 
1559:             IF VARTYPE(loc_oBusca) = "O"
1560:                 loc_oBusca.mAddColuna("Codigos", "@!", "Grupo")
1561:                 loc_oBusca.mAddColuna("Descrs",  "",   "Descri" + CHR(231) + CHR(227) + "o")
1562:                 loc_oBusca.Show()
1563: 
1564:                 IF loc_oBusca.this_lSelecionou
1565:                     IF USED("cursor_4c_BusGrupo") AND !EOF("cursor_4c_BusGrupo")
1566:                         loc_oPage.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BusGrupo.Codigos)
1567:                     ENDIF
1568:                 ELSE
1569:                     loc_oPage.txt_4c_Grupo.Value = ""
1570:                 ENDIF

*-- Linhas 1605 a 1624:
1605:         ENDIF
1606: 
1607:         TRY
1608:             loc_nRet = SQLEXEC(gnConnHandle, ;
1609:                 "SELECT TOP 1 Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
1610:                 "cursor_4c_BuscaConta")
1611: 
1612:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaConta") AND !EOF("cursor_4c_BuscaConta")
1613:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1614:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Rclis, ""))
1615:                 ENDIF
1616:                 IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
1617:                     loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BuscaConta.Cpfs, ""))
1618:                 ENDIF
1619:             ELSE
1620:                 THIS.AbrirBuscaContaAba()
1621:             ENDIF
1622: 
1623:             IF USED("cursor_4c_BuscaConta")
1624:                 USE IN cursor_4c_BuscaConta

*-- Linhas 1655 a 1674:
1655: 
1656:         TRY
1657:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1658:                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli WHERE Iclis LIKE " + ;
1659:                     EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis", ;
1660:                 "cursor_4c_BusConta", ;
1661:                 gnConnHandle)
1662: 
1663:             IF VARTYPE(loc_oBusca) = "O"
1664:                 loc_oBusca.mAddColuna("Iclis", "@!", "C" + CHR(243) + "digo")
1665:                 loc_oBusca.mAddColuna("Rclis", "",   "Nome")
1666:                 loc_oBusca.mAddColuna("Cpfs",  "@!", "CPF/CNPJ")
1667:                 loc_oBusca.Show()
1668: 
1669:                 IF loc_oBusca.this_lSelecionou
1670:                     IF USED("cursor_4c_BusConta") AND !EOF("cursor_4c_BusConta")
1671:                         loc_oPage.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BusConta.Iclis)
1672:                         IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1673:                             loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BusConta.Rclis, ""))
1674:                         ENDIF

*-- Linhas 1730 a 1749:
1730: 
1731:         *-- Busca reversa: SigCdCli por Cpfs -> preenche Conta e Dconta
1732:         TRY
1733:             loc_nRet = SQLEXEC(gnConnHandle, ;
1734:                 "SELECT TOP 1 Iclis, Rclis FROM SigCdCli WHERE Cpfs = " + EscaparSQL(loc_cCpf), ;
1735:                 "cursor_4c_BuscaCpf")
1736: 
1737:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaCpf") AND !EOF("cursor_4c_BuscaCpf")
1738:                 IF TYPE("loc_oPage.txt_4c_Conta") = "O"
1739:                     loc_oPage.txt_4c_Conta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Iclis, ""))
1740:                 ENDIF
1741:                 IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
1742:                     loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BuscaCpf.Rclis, ""))
1743:                 ENDIF
1744:             ENDIF
1745: 
1746:             IF USED("cursor_4c_BuscaCpf")
1747:                 USE IN cursor_4c_BuscaCpf
1748:             ENDIF
1749:         CATCH TO loException

*-- Linhas 1772 a 1791:
1772:         ENDIF
1773: 
1774:         TRY
1775:             loc_nRet = SQLEXEC(gnConnHandle, ;
1776:                 "SELECT TOP 1 CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cMoeda), ;
1777:                 "cursor_4c_BuscaMoeda")
1778: 
1779:             IF loc_nRet > 0 AND USED("cursor_4c_BuscaMoeda") AND !EOF("cursor_4c_BuscaMoeda")
1780:                 *-- Moeda valida
1781:             ELSE
1782:                 THIS.AbrirBuscaMoedaAba()
1783:             ENDIF
1784: 
1785:             IF USED("cursor_4c_BuscaMoeda")
1786:                 USE IN cursor_4c_BuscaMoeda
1787:             ENDIF
1788:         CATCH TO loException
1789:             MsgErro(loException.Message, "Erro em ValidarMoedaAba")
1790:         ENDTRY
1791:     ENDPROC

*-- Linhas 1817 a 1836:
1817: 
1818:         TRY
1819:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
1820:                 "SELECT CMoes, DMoes FROM SigCdMoe WHERE CMoes LIKE " + ;
1821:                     EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes", ;
1822:                 "cursor_4c_BusMoeda", ;
1823:                 gnConnHandle)
1824: 
1825:             IF VARTYPE(loc_oBusca) = "O"
1826:                 loc_oBusca.mAddColuna("CMoes", "@!", "C" + CHR(243) + "digo")
1827:                 loc_oBusca.mAddColuna("DMoes", "",   "Descri" + CHR(231) + CHR(227) + "o")
1828:                 loc_oBusca.Show()
1829: 
1830:                 IF loc_oBusca.this_lSelecionou
1831:                     IF USED("cursor_4c_BusMoeda") AND !EOF("cursor_4c_BusMoeda")
1832:                         loc_oPage.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BusMoeda.CMoes)
1833:                     ENDIF
1834:                 ELSE
1835:                     loc_oPage.txt_4c_Moeda.Value = ""
1836:                 ENDIF

*-- Linhas 1931 a 1969:
1931:             RETURN
1932:         ENDIF
1933: 
1934:         SELECT cursor_4c_Estoque
1935:         loc_cEmps  = ALLTRIM(NVL(cursor_4c_Estoque.Emps,  ""))
1936:         loc_cDopes = ALLTRIM(NVL(cursor_4c_Estoque.Dopes, ""))
1937:         loc_cNumes = ALLTRIM(NVL(cursor_4c_Estoque.Numes, ""))
1938: 
1939:         IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
1940:             MsgAviso("Selecione um registro na grade!", "Aten" + CHR(231) + CHR(227) + "o!")
1941:             RETURN
1942:         ENDIF
1943: 
1944:         TRY
1945:             loc_nRet = SQLEXEC(gnConnHandle, ;
1946:                 "SELECT TOP 1 Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), ;
1947:                 "cursor_4c_TmpOpe")
1948: 
1949:             IF loc_nRet > 0 AND USED("cursor_4c_TmpOpe") AND !EOF("cursor_4c_TmpOpe")
1950:                 MsgAviso("Formul" + CHR(225) + "rio SigMvExp ainda n" + CHR(227) + "o migrado.", ;
1951:                     "Indispon" + CHR(237) + "vel")
1952:             ELSE
1953:                 loc_nRet = SQLEXEC(gnConnHandle, ;
1954:                     "SELECT TOP 1 Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), ;
1955:                     "cursor_4c_TmpOpd")
1956: 
1957:                 IF loc_nRet > 0 AND USED("cursor_4c_TmpOpd") AND !EOF("cursor_4c_TmpOpd")
1958:                     MsgAviso("Formul" + CHR(225) + "rio SigMvObj ainda n" + CHR(227) + "o migrado.", ;
1959:                         "Indispon" + CHR(237) + "vel")
1960:                 ELSE
1961:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdOpe/SigCdOpd.", ;
1962:                         "Aviso")
1963:                 ENDIF
1964:             ENDIF
1965:         CATCH TO loException
1966:             MsgErro(loException.Message, "Erro em CgpOperacaoClick")
1967:         ENDTRY
1968: 
1969:         IF USED("cursor_4c_TmpOpe")

*-- Linhas 2019 a 2037:
2019:         ENDIF
2020: 
2021:         TRY
2022:             loc_oChild = par_oNode.selectSingleNode(".//" + par_cTag)
2023:             IF !ISNULL(loc_oChild) AND VARTYPE(loc_oChild) = "O"
2024:                 loc_cResult = NVL(loc_oChild.text, "")
2025:             ENDIF
2026:         CATCH TO loException
2027:             *-- Node pode nao existir neste XML
2028:         ENDTRY
2029: 
2030:         RETURN loc_cResult
2031:     ENDPROC
2032: 
2033:     *--------------------------------------------------------------------------
2034:     * XmlGetAnyNodeText - Tenta multiplas tags em ordem; retorna primeiro nao-vazio
2035:     * par_cTags: lista de tags separadas por virgula (ex: "vDesc,vdesc")
2036:     *--------------------------------------------------------------------------
2037:     PROTECTED PROCEDURE XmlGetAnyNodeText(par_oNode, par_cTags)

*-- Linhas 2064 a 2084:
2064: 
2065:     *--------------------------------------------------------------------------
2066:     * CarregarGradeEstoque - Popula grd_4c_Estoque com SigMvCab disponiveis
2067:     * Original: MontaGrade (25 linhas) -> SELECT SigMvCab + joins + filtros
2068:     * Problema 36: ColumnCount FORA WITH; Problema 32: Headers APOS RecordSource
2069:     * Problema 48: ControlSource APOS RecordSource
2070:     *--------------------------------------------------------------------------
2071:     PROCEDURE CarregarGradeEstoque()
2072:         LOCAL loc_oPage, loc_oGrd, loc_cConta, loc_nOpt, loc_nRet
2073:         LOCAL loc_cSql, loc_cFiltro
2074:         loc_oPage  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2075:         loc_cConta = ""
2076:         loc_nOpt   = 1
2077:         loc_nRet   = 0
2078:         loc_cSql   = ""
2079:         loc_cFiltro = ""
2080: 
2081:         IF TYPE("loc_oPage.grd_4c_Estoque") != "O"
2082:             RETURN
2083:         ENDIF
2084: 

*-- Linhas 2092 a 2163:
2092: 
2093:         *-- Montar filtro por Conta
2094:         IF !EMPTY(loc_cConta)
2095:             loc_cFiltro = " AND a.ContaOs = " + EscaparSQL(loc_cConta)
2096:         ENDIF
2097: 
2098:         loc_cSql = "SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes, " + ;
2099:             "a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas " + ;
2100:             "FROM SigMvCab a " + ;
2101:             "JOIN sigcdope b ON a.dopes = b.dopes " + ;
2102:             "JOIN SigOpCdd c ON b.dopes = c.dopes " + ;
2103:             "WHERE Distribui = 3 AND a.chksubn = 0 " + ;
2104:             "AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)" + ;
2105:             loc_cFiltro
2106: 
2107:         TRY
2108:             *-- GRID-SQLEXEC: SQLEXEC em cursor temporario para preservar colunas do Grid
2109:             loc_oPage.grd_4c_Estoque.RecordSource = ""
2110: 
2111:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EstoqueTemp")
2112: 
2113:             IF loc_nRet > 0 AND USED("cursor_4c_EstoqueTemp")
2114:                 loc_oGrd = loc_oPage.grd_4c_Estoque
2115: 
2116:                 IF USED("cursor_4c_Estoque")
2117:                     *-- Reload: ZAP + APPEND FROM temp preserva definicao das colunas
2118:                     SELECT cursor_4c_Estoque
2119:                     ZAP
2120:                     APPEND FROM DBF("cursor_4c_EstoqueTemp")
2121:                 ELSE
2122:                     *-- Primeira carga: criar cursor definitivo a partir do temp
2123:                     SELECT * FROM cursor_4c_EstoqueTemp INTO CURSOR cursor_4c_Estoque READWRITE NOFILTER
2124:                 ENDIF
2125: 
2126:                 IF USED("cursor_4c_EstoqueTemp")
2127:                     USE IN cursor_4c_EstoqueTemp
2128:                 ENDIF
2129: 
2130:                 *-- Configurar colunas APOS RecordSource (Problema 36/32/48)
2131:                 loc_oGrd.ColumnCount  = 6
2132:                 loc_oGrd.RecordSource = "cursor_4c_Estoque"
2133: 
2134:                 *-- Headers APOS RecordSource (Problema 32)
2135:                 loc_oGrd.Column1.Header1.Caption = ""
2136:                 loc_oGrd.Column2.Header1.Caption = "Empresa"
2137:                 loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2138:                 loc_oGrd.Column4.Header1.Caption = "Numero"
2139:                 loc_oGrd.Column5.Header1.Caption = "Grupo"
2140:                 loc_oGrd.Column6.Header1.Caption = "Conta"
2141: 
2142:                 *-- ControlSource APOS RecordSource (Problema 48)
2143:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
2144:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
2145:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"
2146:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Estoque.Numes"
2147:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Estoque.Grupos"
2148:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Estoque.Contas"
2149: 
2150:                 WITH loc_oGrd
2151:                     .Column1.Width = 25
2152:                     .Column2.Width = 65
2153:                     .Column3.Width = 120
2154:                     .Column4.Width = 80
2155:                     .Column5.Width = 130
2156:                     .Column6.Width = 125
2157:                     .ReadOnly      = .T.
2158:                 ENDWITH
2159: 
2160:                 loc_oGrd.Refresh()
2161:             ENDIF
2162:         CATCH TO loException
2163:             IF USED("cursor_4c_EstoqueTemp")

*-- Linhas 2195 a 2228:
2195:             ENDIF
2196: 
2197:             SET NULL ON
2198:             CREATE CURSOR crItens ;
2199:                 (codigo C(15), Descr C(50), quant N(12,3), valor_uni N(12,4), ;
2200:                  valor_tot N(12,4), unid C(5), cfop C(4), ncm C(8), ;
2201:                  desconto N(12,2), frete N(12,2))
2202:             SET NULL OFF
2203: 
2204:             loc_oXml       = CREATEOBJECT("MSXML.DOMDOCUMENT")
2205:             loc_oXml.Async = .F.
2206: 
2207:             IF !loc_oXml.Load(par_cArquivo)
2208:                 MsgAviso(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2209:                 loc_lResultado = .F.
2210:             ENDIF
2211: 
2212:             IF loc_lResultado
2213:                 loc_oItens = loc_oXml.selectNodes("//det")
2214:                 IF ISNULL(loc_oItens)
2215:                     MsgAviso("Nenhum item encontrado no XML.", "Aviso")
2216:                     loc_lResultado = .F.
2217:                 ENDIF
2218:             ENDIF
2219: 
2220:             IF loc_lResultado
2221:                 loc_nTotal = loc_oItens.length
2222: 
2223:                 DO WHILE loc_i < loc_nTotal
2224:                     loc_oDet    = loc_oItens.item(loc_i)
2225: 
2226:                     loc_cProd   = THIS.XmlGetNodeText(loc_oDet, "cProd")
2227:                     loc_cDescr  = THIS.XmlGetNodeText(loc_oDet, "xProd")
2228:                     loc_nQtd    = VAL(THIS.XmlGetNodeText(loc_oDet, "qCom"))

*-- Linhas 2234 a 2253:
2234:                     loc_nDesc   = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vDesc,vdesc"))
2235:                     loc_nFrete  = VAL(THIS.XmlGetAnyNodeText(loc_oDet, "vFrete,vfrete"))
2236: 
2237:                     SELECT crItens
2238:                     INSERT INTO crItens VALUES ;
2239:                         (PADR(ALLTRIM(NVL(loc_cProd,  "")), 15), ;
2240:                          PADR(ALLTRIM(NVL(loc_cDescr, "")), 50), ;
2241:                          loc_nQtd, loc_nValUni, loc_nValTot, ;
2242:                          PADR(ALLTRIM(NVL(loc_cUnid, "")), 5), ;
2243:                          PADR(ALLTRIM(NVL(loc_cCfop, "")), 4), ;
2244:                          PADR(ALLTRIM(NVL(loc_cNcm,  "")), 8), ;
2245:                          loc_nDesc, loc_nFrete)
2246: 
2247:                     loc_i = loc_i + 1
2248:                 ENDDO
2249:             ENDIF
2250: 
2251:         CATCH TO loException
2252:             MsgErro(loException.Message, "Erro em CarregarArquivosXml")
2253:         ENDTRY

*-- Linhas 2266 a 2284:
2266:         loc_cResult = ""
2267: 
2268:         TRY
2269:             loc_oNode = par_oParent.selectSingleNode(".//" + par_cTag)
2270:             IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
2271:                 loc_cResult = NVL(loc_oNode.text, "")
2272:             ENDIF
2273:         CATCH TO loException
2274:             *-- Tag ausente ou objeto invalido; retorna "" sem interromper o parsing
2275:             MsgErro(loException.Message, "XmlGetNodeText [" + par_cTag + "]")
2276:         ENDTRY
2277: 
2278:         loc_oNode = .NULL.
2279:         RETURN loc_cResult
2280:     ENDFUNC
2281: 
2282:     *--------------------------------------------------------------------------
2283:     * XmlGetAnyNodeText - Helper: tenta multiplos tags (lista separada por virgula)
2284:     *--------------------------------------------------------------------------

*-- Linhas 2293 a 2311:
2293:             FOR loc_i = 1 TO loc_nCount
2294:                 loc_cTag = ALLTRIM(loc_aTags[loc_i])
2295:                 IF !EMPTY(loc_cTag)
2296:                     loc_oNode = par_oParent.selectSingleNode(".//" + loc_cTag)
2297:                     IF !ISNULL(loc_oNode) AND VARTYPE(loc_oNode) = "O"
2298:                         loc_cResult = NVL(loc_oNode.text, "")
2299:                         IF !EMPTY(loc_cResult)
2300:                             EXIT
2301:                         ENDIF
2302:                     ENDIF
2303:                 ENDIF
2304:             ENDFOR
2305:         CATCH TO loException
2306:             MsgErro(loException.Message, "Erro em XmlGetAnyNodeText")
2307:         ENDTRY
2308: 
2309:         loc_oNode = .NULL.
2310:         RETURN loc_cResult
2311:     ENDFUNC

*-- Linhas 2349 a 2454:
2349:             ENDIF
2350: 
2351:             SET NULL ON
2352:             CREATE CURSOR crMovimentos ;
2353:                 (Cpros C(15), Dpros C(50), reffs C(25), pesoms N(12,3), ;
2354:                  pvens N(12,2), moevs C(3), custofs N(12,2), moecusfs C(3), ;
2355:                  fcustos N(12,2), Emps C(4), Dopes C(10), Numes C(10), ;
2356:                  CodCors C(5), CdChaves C(36), Qtds N(12,3), ;
2357:                  QtdBaixa N(12,3), QtdRes N(12,3), QtdSaldo N(12,3))
2358: 
2359:             CREATE CURSOR crDistribui ;
2360:                 (refForn C(25), Descr C(50), Qtds N(12,3), Valor N(12,2))
2361:             SET NULL OFF
2362: 
2363:             *-- Iterar crItens e tentar localizar em SigCdPro por ifors (ref fornecedor)
2364:             SELECT crItens
2365:             GO TOP IN crItens
2366:             SCAN
2367:                 loc_cProd   = ALLTRIM(NVL(crItens.codigo, ""))
2368:                 loc_nQtd    = NVL(crItens.quant, 0)
2369:                 loc_nValTot = NVL(crItens.valor_tot, 0)
2370:                 loc_cDescr  = ALLTRIM(NVL(crItens.Descr, ""))
2371: 
2372:                 IF EMPTY(loc_cProd)
2373:                     SELECT crItens
2374:                     LOOP
2375:                 ENDIF
2376: 
2377:                 loc_nRet = SQLEXEC(gnConnHandle, ;
2378:                     "SELECT TOP 1 a.cpros, a.dpros, a.reffs, a.pesoms, a.pvens, a.moevs, " + ;
2379:                     "a.custofs, a.moecusfs, a.fcustos, a.CodCors " + ;
2380:                     "FROM SigCdPro a " + ;
2381:                     "WHERE a.ifors = " + EscaparSQL(loc_cProd) + " AND a.situas <> 'I'", ;
2382:                     "cursor_4c_BusPro")
2383: 
2384:                 IF loc_nRet > 0 AND USED("cursor_4c_BusPro") AND !EOF("cursor_4c_BusPro")
2385:                     *-- Produto encontrado -> crMovimentos (exceto quando Opt=3=Nao Cad.)
2386:                     IF loc_nOpt <> 3
2387:                         loc_cCpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.cpros,    "")), 15)
2388:                         loc_cDpros    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.dpros,    "")), 50)
2389:                         loc_cReffs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.reffs,    "")), 25)
2390:                         loc_nPesoms   = NVL(cursor_4c_BusPro.pesoms,   0)
2391:                         loc_nPvens    = NVL(cursor_4c_BusPro.pvens,    0)
2392:                         loc_cMoevs    = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moevs,    "")), 3)
2393:                         loc_nCustofs  = NVL(cursor_4c_BusPro.custofs,  0)
2394:                         loc_cMoecusfs = PADR(ALLTRIM(NVL(cursor_4c_BusPro.moecusfs, "")), 3)
2395:                         loc_nFcustos  = NVL(cursor_4c_BusPro.fcustos,  0)
2396:                         loc_cCodCors  = PADR(ALLTRIM(NVL(cursor_4c_BusPro.CodCors,  "")), 5)
2397: 
2398:                         SELECT crMovimentos
2399:                         INSERT INTO crMovimentos VALUES ;
2400:                             (loc_cCpros, loc_cDpros, loc_cReffs, ;
2401:                              loc_nPesoms, loc_nPvens, loc_cMoevs, ;
2402:                              loc_nCustofs, loc_cMoecusfs, loc_nFcustos, ;
2403:                              PADR("", 4), PADR("", 10), PADR("", 10), ;
2404:                              loc_cCodCors, PADR("", 36), ;
2405:                              loc_nQtd, 0, 0, 0)
2406:                     ENDIF
2407:                 ELSE
2408:                     *-- Produto NAO encontrado -> crDistribui (exceto quando Opt=2=Cadastrados)
2409:                     IF loc_nOpt <> 2
2410:                         SELECT crDistribui
2411:                         INSERT INTO crDistribui VALUES ;
2412:                             (PADR(ALLTRIM(loc_cProd), 25), ;
2413:                              PADR(ALLTRIM(loc_cDescr), 50), ;
2414:                              loc_nQtd, loc_nValTot)
2415:                     ENDIF
2416:                 ENDIF
2417: 
2418:                 IF USED("cursor_4c_BusPro")
2419:                     USE IN cursor_4c_BusPro
2420:                 ENDIF
2421: 
2422:                 SELECT crItens
2423:             ENDSCAN
2424: 
2425:             loc_lResultado = .T.
2426: 
2427:         CATCH TO loException
2428:             MsgErro(loException.Message, "Erro em CarregarItemXML")
2429:         ENDTRY
2430: 
2431:         IF loc_lResultado
2432:             THIS.CarregarGradeDisponivel()
2433:             THIS.CarregarGradeItemXml()
2434:         ENDIF
2435:     ENDPROC
2436: 
2437:     *--------------------------------------------------------------------------
2438:     * CarregarGradeDisponivel - Seta RecordSource de grd_4c_Disponivel -> crMovimentos
2439:     * Problema 36/32/48: ColumnCount/RecordSource/ControlSource na ordem certa
2440:     *--------------------------------------------------------------------------
2441:     PROCEDURE CarregarGradeDisponivel()
2442:         LOCAL loc_oPage2, loc_oGrd
2443:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2444:         loc_oGrd   = .NULL.
2445: 
2446:         IF TYPE("loc_oPage2.grd_4c_Disponivel") != "O"
2447:             RETURN
2448:         ENDIF
2449: 
2450:         IF !USED("crMovimentos")
2451:             RETURN
2452:         ENDIF
2453: 
2454:         TRY

*-- Linhas 2466 a 2491:
2466:             loc_oGrd.Column6.Header1.Caption = "Reservado"
2467:             loc_oGrd.Column7.Header1.Caption = "Saldo"
2468: 
2469:             *-- Problema 48: ControlSource APOS RecordSource
2470:             loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
2471:             loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
2472:             loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"
2473:             loc_oGrd.Column4.ControlSource = "crMovimentos.Qtds"
2474:             loc_oGrd.Column5.ControlSource = "crMovimentos.QtdBaixa"
2475:             loc_oGrd.Column6.ControlSource = "crMovimentos.QtdRes"
2476:             loc_oGrd.Column7.ControlSource = "crMovimentos.QtdSaldo"
2477: 
2478:             WITH loc_oGrd
2479:                 .Column1.Width = 80
2480:                 .Column2.Width = 200
2481:                 .Column3.Width = 80
2482:                 .Column4.Width = 70
2483:                 .Column5.Width = 80
2484:                 .Column6.Width = 80
2485:                 .Column7.Width = 94
2486:             ENDWITH
2487: 
2488:             loc_oGrd.Refresh()
2489: 
2490:             *-- Disparar handler para popular campos de detalhe da 1a linha
2491:             IF !EOF("crMovimentos")

*-- Linhas 2524 a 2545:
2524:             loc_oGrd.Column3.Header1.Caption = "Quantidade"
2525:             loc_oGrd.Column4.Header1.Caption = "Valor"
2526: 
2527:             loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
2528:             loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
2529:             loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
2530:             loc_oGrd.Column4.ControlSource = "crDistribui.Valor"
2531: 
2532:             WITH loc_oGrd
2533:                 .Column1.Width = 100
2534:                 .Column2.Width = 220
2535:                 .Column3.Width = 80
2536:                 .Column4.Width = 93
2537:             ENDWITH
2538: 
2539:             loc_oGrd.Refresh()
2540: 
2541:         CATCH TO loException
2542:             MsgErro(loException.Message, "Erro em CarregarGradeItemXml")
2543:         ENDTRY
2544:     ENDPROC
2545: 

*-- Linhas 2559 a 2577:
2559:             RETURN
2560:         ENDIF
2561: 
2562:         SELECT crMovimentos
2563: 
2564:         *-- Atualizar campos de detalhe na Page2 a partir de crMovimentos
2565:         IF TYPE("loc_oPage2.txt_4c_RefFornecedor") = "O"
2566:             loc_oPage2.txt_4c_RefFornecedor.Value = ALLTRIM(NVL(crMovimentos.reffs,    ""))
2567:         ENDIF
2568:         IF TYPE("loc_oPage2.txt_4c_PrVenda") = "O"
2569:             loc_oPage2.txt_4c_PrVenda.Value       = NVL(crMovimentos.pvens, 0)
2570:         ENDIF
2571:         IF TYPE("loc_oPage2.txt_4c_PrVendaMoeda") = "O"
2572:             loc_oPage2.txt_4c_PrVendaMoeda.Value  = ALLTRIM(NVL(crMovimentos.moevs,    ""))
2573:         ENDIF
2574:         IF TYPE("loc_oPage2.txt_4c_PesoMedio") = "O"
2575:             loc_oPage2.txt_4c_PesoMedio.Value     = NVL(crMovimentos.pesoms, 0)
2576:         ENDIF
2577:         IF TYPE("loc_oPage2.txt_4c_Custofs") = "O"

*-- Linhas 2603 a 2685:
2603:     ENDPROC
2604: 
2605:     *--------------------------------------------------------------------------
2606:     * BtnExcluirSisClick - Original: btnExcluirSis.Click -> DELETE em crMovimentos
2607:     *--------------------------------------------------------------------------
2608:     PROCEDURE BtnExcluirSisClick()
2609:         LOCAL loc_oPage2, loc_oGrd
2610:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2611: 
2612:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2613:             RETURN
2614:         ENDIF
2615: 
2616:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2617:             RETURN
2618:         ENDIF
2619: 
2620:         TRY
2621:             SELECT crMovimentos
2622:             IF !EOF()
2623:                 DELETE
2624:             ENDIF
2625: 
2626:             *-- Posicionar no proximo registro disponivel
2627:             SET DELETED ON
2628:             IF !EOF()
2629:                 SKIP
2630:                 SKIP -1
2631:             ELSE
2632:                 GO TOP
2633:             ENDIF
2634: 
2635:             *-- Atualizar grade e campos de detalhe
2636:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2637:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2638:             ENDIF
2639: 
2640:             IF !EOF("crMovimentos")
2641:                 THIS.GrdDisponivelAfterRowColChange(1)
2642:             ENDIF
2643: 
2644:         CATCH TO loException
2645:             MsgErro(loException.Message, "Erro em BtnExcluirSisClick")
2646:         ENDTRY
2647:     ENDPROC
2648: 
2649:     *--------------------------------------------------------------------------
2650:     * BtnExcluirArqClick - Original: btnExcluirArq.Click -> DELETE em crDistribui
2651:     *--------------------------------------------------------------------------
2652:     PROCEDURE BtnExcluirArqClick()
2653:         LOCAL loc_oPage2
2654:         loc_oPage2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
2655: 
2656:         IF !INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
2657:             RETURN
2658:         ENDIF
2659: 
2660:         IF !USED("crDistribui") OR EOF("crDistribui")
2661:             RETURN
2662:         ENDIF
2663: 
2664:         TRY
2665:             SELECT crDistribui
2666:             IF !EOF()
2667:                 DELETE
2668:             ENDIF
2669: 
2670:             SET DELETED ON
2671:             IF !EOF()
2672:                 SKIP
2673:                 SKIP -1
2674:             ELSE
2675:                 GO TOP
2676:             ENDIF
2677: 
2678:             IF TYPE("loc_oPage2.grd_4c_ItemXml") = "O"
2679:                 loc_oPage2.grd_4c_ItemXml.Refresh()
2680:             ENDIF
2681: 
2682:         CATCH TO loException
2683:             MsgErro(loException.Message, "Erro em BtnExcluirArqClick")
2684:         ENDTRY
2685:     ENDPROC

*-- Linhas 2705 a 2723:
2705:         ENDIF
2706: 
2707:         TRY
2708:             SELECT crMovimentos
2709:             loc_nRec = RECNO()
2710:             GO TOP
2711: 
2712:             LOCATE FOR Cpros = PADR(loc_cProd, 15)
2713: 
2714:             IF EOF()
2715:                 GO loc_nRec
2716:             ENDIF
2717: 
2718:             IF TYPE("loc_oPage2.grd_4c_Disponivel") = "O"
2719:                 loc_oPage2.grd_4c_Disponivel.Refresh()
2720:             ENDIF
2721: 
2722:             THIS.GrdDisponivelAfterRowColChange(1)
2723: 

*-- Linhas 2741 a 2793:
2741:             RETURN
2742:         ENDIF
2743: 
2744:         SELECT crMovimentos
2745:         loc_cCpros = ALLTRIM(NVL(crMovimentos.Cpros, ""))
2746: 
2747:         IF EMPTY(loc_cCpros)
2748:             RETURN
2749:         ENDIF
2750: 
2751:         TRY
2752:             loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
2753: 
2754:             loc_nRet = SQLEXEC(gnConnHandle, ;
2755:                 "SELECT TOP 1 a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros), ;
2756:                 "cursor_4c_TmpFig")
2757: 
2758:             IF loc_nRet > 0 AND USED("cursor_4c_TmpFig") AND !EOF("cursor_4c_TmpFig")
2759:                 IF !ISNULL(cursor_4c_TmpFig.FigJpgs) AND !EMPTY(cursor_4c_TmpFig.FigJpgs)
2760:                     STRTOFILE(cursor_4c_TmpFig.FigJpgs, loc_cArqTemp)
2761:                     IF FILE(loc_cArqTemp) AND TYPE("loc_oPage2.img_4c_FigJpg") = "O"
2762:                         loc_oPage2.img_4c_FigJpg.Picture = loc_cArqTemp
2763:                     ENDIF
2764:                 ENDIF
2765:             ENDIF
2766: 
2767:             IF USED("cursor_4c_TmpFig")
2768:                 USE IN cursor_4c_TmpFig
2769:             ENDIF
2770: 
2771:         CATCH TO loException
2772:             MsgErro(loException.Message, "Erro em ImgFigJpgClick")
2773:         ENDTRY
2774:     ENDPROC
2775: 
2776:     *--------------------------------------------------------------------------
2777:     * GravarSessaoXml - Grava todos os produtos de crMovimentos como linhas SigPrCtr
2778:     * Original: cgp_Salva.salva.Click (106 linhas) - padrao multi-row INSERT
2779:     * Para cada linha de crMovimentos (nao deletadas): chama BO.Inserir()
2780:     *--------------------------------------------------------------------------
2781:     PROCEDURE GravarSessaoXml()
2782:         LOCAL loc_oPage, loc_cCodigos, loc_cConta, loc_cArquivo, loc_cMoeda
2783:         LOCAL loc_nOpt, loc_lResultado, loc_nContador
2784:         LOCAL loc_cCpros, loc_cCodCors, loc_nQtds, loc_cEmps, loc_cDopes
2785:         LOCAL loc_cNumes, loc_cCdChaves, loc_cDescr
2786:         loc_oPage      = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
2787:         loc_lResultado = .F.
2788:         loc_nContador  = 0
2789:         loc_cCodigos   = ""
2790:         loc_cConta     = ""
2791:         loc_cArquivo   = ""
2792:         loc_cMoeda     = ""
2793:         loc_nOpt       = 1

*-- Linhas 2802 a 2825:
2802:             RETURN
2803:         ENDIF
2804: 
2805:         *-- Verificar se ha registros em crMovimentos (RECCOUNT ignora SET DELETED)
2806:         IF RECCOUNT("crMovimentos") = 0
2807:             MsgAviso("Nenhum produto para salvar. Processe um arquivo XML primeiro.", "Aviso")
2808:             RETURN
2809:         ENDIF
2810:         SET DELETED ON
2811: 
2812:         *-- Ler campos da Page1
2813:         IF TYPE("loc_oPage.txt_4c_Conta") = "O"
2814:             loc_cConta = ALLTRIM(NVL(loc_oPage.txt_4c_Conta.Value, ""))
2815:         ENDIF
2816:         IF TYPE("loc_oPage.txt_4c_Arquivo") = "O"
2817:             loc_cArquivo = ALLTRIM(NVL(loc_oPage.txt_4c_Arquivo.Value, ""))
2818:         ENDIF
2819:         IF TYPE("loc_oPage.txt_4c_Moeda") = "O"
2820:             loc_cMoeda = ALLTRIM(NVL(loc_oPage.txt_4c_Moeda.Value, ""))
2821:         ENDIF
2822:         IF TYPE("loc_oPage.opt_4c_Custo") = "O"
2823:             loc_nOpt = NVL(loc_oPage.opt_4c_Custo.Value, 1)
2824:         ENDIF
2825: 

*-- Linhas 2845 a 2904:
2845:                 loc_lResultado = .F.
2846:             ELSE
2847:                 *-- Inserir cada linha de crMovimentos (nao deletados)
2848:                 SELECT crMovimentos
2849:                 GO TOP IN crMovimentos
2850:                 SCAN
2851:                     loc_cCpros    = ALLTRIM(NVL(crMovimentos.Cpros,    ""))
2852:                     loc_cCodCors  = ALLTRIM(NVL(crMovimentos.CodCors,  ""))
2853:                     loc_nQtds     = NVL(crMovimentos.Qtds, 0)
2854:                     loc_cEmps     = ALLTRIM(NVL(crMovimentos.Emps,     ""))
2855:                     loc_cDopes    = ALLTRIM(NVL(crMovimentos.Dopes,    ""))
2856:                     loc_cNumes    = ALLTRIM(NVL(crMovimentos.Numes,    ""))
2857:                     loc_cCdChaves = ALLTRIM(NVL(crMovimentos.CdChaves, ""))
2858: 
2859:                     IF EMPTY(loc_cCpros)
2860:                         SELECT crMovimentos
2861:                         LOOP
2862:                     ENDIF
2863: 
2864:                     THIS.this_oBusinessObject.this_cCodigos    = loc_cCodigos
2865:                     THIS.this_oBusinessObject.this_cCpros      = loc_cCpros
2866:                     THIS.this_oBusinessObject.this_cCodCors    = loc_cCodCors
2867:                     THIS.this_oBusinessObject.this_cCodTams    = ""
2868:                     THIS.this_oBusinessObject.this_cOriDopNums = PADR(loc_cEmps,5) + PADR(loc_cDopes,10) + PADR(loc_cNumes,10)
2869:                     THIS.this_oBusinessObject.this_cFkChaves   = loc_cCdChaves
2870:                     THIS.this_oBusinessObject.this_nQtds       = loc_nQtds
2871:                     THIS.this_oBusinessObject.this_nQtdOs      = 0
2872:                     THIS.this_oBusinessObject.this_cContas     = loc_cConta
2873:                     THIS.this_oBusinessObject.this_cArquivo    = loc_cArquivo
2874:                     THIS.this_oBusinessObject.this_cMoedas     = loc_cMoeda
2875:                     THIS.this_oBusinessObject.this_nPrecific   = loc_nOpt
2876:                     THIS.this_oBusinessObject.this_dDatas      = DATE()
2877:                     THIS.this_oBusinessObject.this_cUsuars     = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
2878: 
2879:                     IF !THIS.this_oBusinessObject.Inserir()
2880:                         MsgErro("Falha ao inserir produto " + loc_cCpros + ".", "Erro")
2881:                         loc_lResultado = .F.
2882:                         SELECT crMovimentos
2883:                         EXIT
2884:                     ELSE
2885:                         loc_nContador = loc_nContador + 1
2886:                         loc_lResultado = .T.
2887:                     ENDIF
2888: 
2889:                     SELECT crMovimentos
2890:                 ENDSCAN
2891:             ENDIF
2892: 
2893:         CATCH TO loException
2894:             MsgErro(loException.Message, "Erro em GravarSessaoXml")
2895:         ENDTRY
2896: 
2897:         IF loc_lResultado AND loc_nContador > 0
2898:             MsgInfo(LTRIM(STR(loc_nContador)) + " produto(s) salvo(s) com sucesso!", "Sucesso")
2899:             THIS.this_cModoAtual = "LISTA"
2900:             THIS.AlternarPagina(1)
2901:             THIS.CarregarLista()
2902:         ENDIF
2903:     ENDPROC
2904: 

*-- Linhas 2987 a 3034:
2987:     *--------------------------------------------------------------------------
2988:     * CarregarLista - Carrega cursor_4c_Dados e configura grd_4c_Lista
2989:     * Chama Buscar() no BO, seta RecordSource e redefine cabecalhos
2990:     * REGRA: ControlSource APOS RecordSource (evita auto-bind - Problema 48)
2991:     * REGRA: Header1.Caption APOS RecordSource (evita reset - Problema 32)
2992:     *--------------------------------------------------------------------------
2993:     PROCEDURE CarregarLista()
2994:         LOCAL loc_lResultado, loc_oGrid
2995:         loc_lResultado = .F.
2996:         loc_oGrid      = .NULL.
2997: 
2998:         TRY
2999:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
3000:                 loc_lResultado = .T.
3001:             ELSE
3002:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
3003:                     THIS.this_oBusinessObject.this_dFiltroInicio = THIS.this_dDtInicio
3004:                     THIS.this_oBusinessObject.this_dFiltroFim    = THIS.this_dDtFim
3005: 
3006:                     IF THIS.this_oBusinessObject.Buscar("")
3007:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
3008: 
3009:                         *-- RecordSource FORA de WITH (Problema 36: criacao imediata das colunas)
3010:                         loc_oGrid.ColumnCount = 6
3011:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
3012: 
3013:                         *-- ControlSource APOS RecordSource (Problema 48: auto-bind)
3014:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
3015:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
3016:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.OriDopNums"
3017:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Usuars"
3018:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Contas"
3019:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.Rclis"
3020: 
3021:                         loc_oGrid.Column1.Width = 80
3022:                         loc_oGrid.Column2.Width = 120
3023:                         loc_oGrid.Column3.Width = 100
3024:                         loc_oGrid.Column4.Width = 100
3025:                         loc_oGrid.Column5.Width = 100
3026:                         loc_oGrid.Column6.Width = 680
3027: 
3028:                         *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
3029:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3030:                         loc_oGrid.Column2.Header1.Caption = "Data"
3031:                         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
3032:                         loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
3033:                         loc_oGrid.Column5.Header1.Caption = "Fornecedor"
3034:                         loc_oGrid.Column6.Header1.Caption = "Nome"

*-- Linhas 3123 a 3163:
3123:             RETURN
3124:         ENDIF
3125: 
3126:         *-- Preparar BO para INSERT; setar modo ANTES de HabilitarCampos (Problema 19)
3127:         THIS.this_oBusinessObject.NovoRegistro()
3128:         THIS.this_cModoAtual = "INCLUIR"
3129:         THIS.LimparCampos()
3130:         THIS.HabilitarCampos(.T.)
3131:         THIS.AjustarBotoesPorModo()
3132:         THIS.AlternarPagina(2)
3133:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3134:     ENDPROC
3135: 
3136:     *--------------------------------------------------------------------------
3137:     * BtnVisualizarClick - Abre sessao selecionada em modo somente leitura
3138:     *--------------------------------------------------------------------------
3139:     PROCEDURE BtnVisualizarClick()
3140:         LOCAL loc_cCodigo
3141:         loc_cCodigo = ""
3142: 
3143:         IF NOT USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
3144:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3145:             RETURN
3146:         ENDIF
3147: 
3148:         SELECT cursor_4c_Dados
3149:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3150: 
3151:         IF EMPTY(loc_cCodigo)
3152:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3153:             RETURN
3154:         ENDIF
3155: 
3156:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3157:             RETURN
3158:         ENDIF
3159: 
3160:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3161:             THIS.BOParaForm()
3162:             THIS.this_cModoAtual = "VISUALIZAR"
3163:             THIS.HabilitarCampos(.F.)

*-- Linhas 3181 a 3212:
3181:             RETURN
3182:         ENDIF
3183: 
3184:         SELECT cursor_4c_Dados
3185:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3186: 
3187:         IF EMPTY(loc_cCodigo)
3188:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3189:             RETURN
3190:         ENDIF
3191: 
3192:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3193:             RETURN
3194:         ENDIF
3195: 
3196:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3197:             *-- EditarRegistro prepara BO para UPDATE (Problema 18)
3198:             THIS.this_oBusinessObject.EditarRegistro()
3199:             THIS.BOParaForm()
3200:             THIS.this_cModoAtual = "ALTERAR"
3201:             THIS.HabilitarCampos(.T.)
3202:             THIS.AjustarBotoesPorModo()
3203:             THIS.AlternarPagina(2)
3204:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.ActivePage = 1
3205:         ELSE
3206:             MsgErro("Erro ao carregar registro para edi" + CHR(231) + CHR(227) + "o.", "Erro")
3207:         ENDIF
3208:     ENDPROC
3209: 
3210:     *--------------------------------------------------------------------------
3211:     * BtnExcluirClick - Exclui sessao selecionada apos confirmacao
3212:     *--------------------------------------------------------------------------

*-- Linhas 3220 a 3238:
3220:             RETURN
3221:         ENDIF
3222: 
3223:         SELECT cursor_4c_Dados
3224:         loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.Codigos, ""))
3225: 
3226:         IF EMPTY(loc_cCodigo)
3227:             MsgAviso("Nenhum registro selecionado!", "Aten" + CHR(231) + CHR(227) + "o")
3228:             RETURN
3229:         ENDIF
3230: 
3231:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3232:             RETURN
3233:         ENDIF
3234: 
3235:         *-- MsgConfirma retorna LOGICAL (.T./.F.) - nunca comparar com = 6 (Problema 50)
3236:         loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro" + ;
3237:             CHR(13) + "C" + CHR(243) + "digo: " + loc_cCodigo + " ?", ;
3238:             "Confirmar Exclus" + CHR(227) + "o")

*-- Linhas 3291 a 3309:
3291:     ENDPROC
3292: 
3293:     *--------------------------------------------------------------------------
3294:     * BtnSalvarClick - Salva sessao XML: padrao multi-row (DELETE + loop INSERT)
3295:     * SigPrCtr armazena multiplas linhas por sessao (uma por produto)
3296:     * Delega para GravarSessaoXml que faz ExcluirLinhasSessao + BO.Inserir por linha
3297:     *--------------------------------------------------------------------------
3298:     PROCEDURE BtnSalvarClick()
3299:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3300:             RETURN
3301:         ENDIF
3302: 
3303:         THIS.GravarSessaoXml()
3304:     ENDPROC
3305: 
3306:     *--------------------------------------------------------------------------
3307:     * BtnCancelarClick - Cancela edicao e retorna para lista
3308:     *--------------------------------------------------------------------------
3309:     PROCEDURE BtnCancelarClick()

*-- Linhas 3510 a 3529:
3510:         *-- Buscar Dconta (Rclis) e Cpf (Cpfs) de SigCdCli para campos display-only
3511:         IF !EMPTY(loc_cConta)
3512:             TRY
3513:                 loc_nRet = SQLEXEC(gnConnHandle, ;
3514:                     "SELECT TOP 1 Rclis, Cpfs FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta), ;
3515:                     "cursor_4c_BoParaForm")
3516: 
3517:                 IF loc_nRet > 0 AND USED("cursor_4c_BoParaForm") AND !EOF("cursor_4c_BoParaForm")
3518:                     IF TYPE("loc_oPage.txt_4c_Dconta") = "O"
3519:                         loc_oPage.txt_4c_Dconta.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Rclis, ""))
3520:                     ENDIF
3521:                     IF TYPE("loc_oPage.txt_4c_Cpf") = "O"
3522:                         loc_oPage.txt_4c_Cpf.Value = ALLTRIM(NVL(cursor_4c_BoParaForm.Cpfs, ""))
3523:                     ENDIF
3524:                 ENDIF
3525: 
3526:                 IF USED("cursor_4c_BoParaForm")
3527:                     USE IN cursor_4c_BoParaForm
3528:                 ENDIF
3529:             CATCH TO loException


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
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = PADR(ALLTRIM(SYS(2015)), 20)
            ENDIF

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

