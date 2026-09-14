# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (14)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3782 linhas total):

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

*-- Linhas 875 a 893:
875:             .GridLineColor     = RGB(238, 238, 238)
876:             .AllowHeaderSizing = .F.
877:             .AllowRowSizing    = .F.
878:             .DeleteMark        = .F.
879:             .RecordMark        = .F.
880:             .RowHeight         = 16
881:             .ScrollBars        = 2
882:             .Visible           = .T.
883:             .Column1.Width = 70
884:             .Column1.Header1.Caption = "Empresa"
885:             .Column2.Width = 200
886:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
887:             .Column3.Width = 80
888:             .Column3.Header1.Caption = "Numero"
889:             .Column4.Width = 80
890:             .Column4.Header1.Caption = "Grupo"
891:             .Column5.Width = 80
892:             .Column5.Header1.Caption = "Conta"
893:             .Column4.ReadOnly = .T.

*-- Linhas 1154 a 1174:
1154:         THIS.CarregarLista()
1155:     ENDPROC
1156: 
1157:     *--------------------------------------------------------------------------
1158:     * BtnSalvarClick - Grava o lote: monta cursor_4c_Linhas a partir do JOIN
1159:     * de cursor_4c_Movimentos x cursor_4c_Distribui, entao chama Salvar()
1160:     *--------------------------------------------------------------------------
1161:     PROCEDURE BtnSalvarClick()
1162:         LOCAL loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc
1163:         LOCAL loc_oPg2P1, loc_nQtdOs, loc_lSalvoOK, loc_oErro
1164:         loc_cConta   = ""
1165:         loc_cArquivo = ""
1166:         loc_cMoeda   = ""
1167:         loc_nOpc     = 0
1168:         loc_lSalvoOK = .F.
1169:         loc_oPg2P1   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1170: 
1171:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1172:             loc_cConta = ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value)
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Arquivo", 5)

*-- Linhas 1185 a 1258:
1185:             MsgAviso("Informe o fornecedor antes de salvar.", ;
1186:                      "Campo Obrigat" + CHR(243) + "rio")
1187:             RETURN
1188:         ENDIF
1189: 
1190:         IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
1191:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " movimentos para gravar.", "Aviso")
1192:             RETURN
1193:         ENDIF
1194: 
1195:         IF !USED("cursor_4c_Distribui") OR RECCOUNT("cursor_4c_Distribui") = 0
1196:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " distribui" + CHR(231) + CHR(227) + ;
1197:                      "o para gravar.", "Aviso")
1198:             RETURN
1199:         ENDIF
1200: 
1201:         TRY
1202:             *-- Monta cursor_4c_Linhas: JOIN movimentos x distribui onde qtd > 0 e saldo > 0
1203:             IF USED("cursor_4c_TmpJoin")
1204:                 USE IN cursor_4c_TmpJoin
1205:             ENDIF
1206: 
1207:             SELECT a.Cpros, a.Qtds, a.OriDopNums, a.CidChaves, b.Qtds AS QtdXml ;
1208:                 FROM cursor_4c_Movimentos a ;
1209:                 JOIN cursor_4c_Distribui b ON ALLTRIM(a.Cpros) = ALLTRIM(b.Cpros) ;
1210:                 INTO CURSOR cursor_4c_TmpJoin READWRITE
1211: 
1212:             IF USED("cursor_4c_Linhas")
1213:                 ZAP IN cursor_4c_Linhas
1214:             ELSE
1215:                 SET NULL ON
1216:                 CREATE CURSOR cursor_4c_Linhas ;
1217:                     (Cpros    C(14), CodCors C(4),   CodTams  C(4),  ;
1218:                      OriDopNums C(29), Qtds N(12,2), QtdOs    N(12,2), ;
1219:                      Contas   C(10),  Arquivo C(200), Moedas  C(3),   ;
1220:                      Precific N(12,2), FkChaves C(20))
1221:                 SET NULL OFF
1222:             ENDIF
1223: 
1224:             IF USED("cursor_4c_TmpJoin") AND RECCOUNT("cursor_4c_TmpJoin") > 0
1225:                 SELECT cursor_4c_TmpJoin
1226:                 GO TOP
1227:                 SCAN
1228:                     loc_nQtdOs = IIF(cursor_4c_TmpJoin.QtdXml > cursor_4c_TmpJoin.Qtds, ;
1229:                                      cursor_4c_TmpJoin.Qtds, cursor_4c_TmpJoin.QtdXml)
1230:                     INSERT INTO cursor_4c_Linhas ;
1231:                         (Cpros, CodCors, CodTams, OriDopNums, Qtds, QtdOs, ;
1232:                          Contas, Arquivo, Moedas, Precific, FkChaves) ;
1233:                         VALUES ;
1234:                         (cursor_4c_TmpJoin.Cpros, "", "", cursor_4c_TmpJoin.OriDopNums, ;
1235:                          cursor_4c_TmpJoin.Qtds, loc_nQtdOs, ;
1236:                          loc_cConta, loc_cArquivo, loc_cMoeda, loc_nOpc, ;
1237:                          cursor_4c_TmpJoin.CidChaves)
1238:                     SELECT cursor_4c_TmpJoin
1239:                 ENDSCAN
1240:             ENDIF
1241: 
1242:             IF USED("cursor_4c_TmpJoin")
1243:                 USE IN cursor_4c_TmpJoin
1244:             ENDIF
1245: 
1246:             IF !USED("cursor_4c_Linhas") OR RECCOUNT("cursor_4c_Linhas") = 0
1247:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " linhas v" + CHR(225) + ;
1248:                          "lidas para gravar (verifique saldo e distribui" + CHR(231) + CHR(227) + "o).", ;
1249:                          "Aviso")
1250:             ELSE
1251:                 THIS.FormParaBO()
1252:                 IF THIS.this_oBusinessObject.Salvar()
1253:                     MsgInfo("Lote gravado com sucesso!", "Sucesso")
1254:                     loc_lSalvoOK = .T.
1255:                 ENDIF
1256:             ENDIF
1257:         CATCH TO loc_oErro
1258:             MsgErro("Erro em FormSigPrCtr.BtnSalvarClick:" + CHR(13) + ;

*-- Linhas 1468 a 1491:
1468:                         loc_oGrid = loc_oPg1.grd_4c_Dados
1469:                         loc_oGrid.ColumnCount = 6
1470:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1471:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1472:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Datas"
1473:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Contas"
1474:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Rclis"
1475:                         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Usuars"
1476:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.OriDopNums"
1477:                         loc_oGrid.Column1.Header1.Caption = "Numero"
1478:                         loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1479:                         loc_oGrid.Column3.Header1.Caption = "Conta"
1480:                         loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1481:                         loc_oGrid.Column5.Header1.Caption = "Grupo"
1482:                         loc_oGrid.Column6.Header1.Caption = "Empresa"
1483: 
1484:                         THIS.FormatarGridLista(loc_oGrid)
1485:                     ENDIF
1486: 
1487:                     loc_lResultado = .T.
1488:                 ENDIF
1489:             ENDIF
1490:         CATCH TO loc_oErro
1491:             MsgErro("Erro em FormSigPrCtr.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1511 a 1566:
1511:             THIS.this_oBusinessObject.this_nPrecific = loc_oPg2P1.opt_4c_Custo.Value
1512:         ENDIF
1513:     ENDPROC
1514: 
1515:     *--------------------------------------------------------------------------
1516:     * OptFilInteractiveChange - Reaplicar filtro opt_4c_Fil ao cursor_4c_Movimentos
1517:     *--------------------------------------------------------------------------
1518:     PROCEDURE OptFilInteractiveChange()
1519:         LOCAL loc_oPg2P1, loc_nTipo, loc_oErro
1520:         loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1521:         loc_nTipo  = 3
1522:         IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
1523:             loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
1524:         ENDIF
1525: 
1526:         TRY
1527:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
1528:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
1529:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
1530:                 IF USED("cursor_4c_MovFiltro")
1531:                     USE IN cursor_4c_MovFiltro
1532:                 ENDIF
1533:                 IF loc_nTipo = 1
1534:                     SELECT * FROM cursor_4c_Movimentos ;
1535:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
1536:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
1537:                 ELSE
1538:                     SELECT * FROM cursor_4c_Movimentos ;
1539:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
1540:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
1541:                 ENDIF
1542:                 SELECT cursor_4c_Movimentos
1543:                 ZAP
1544:                 IF USED("cursor_4c_MovFiltro") AND RECCOUNT("cursor_4c_MovFiltro") > 0
1545:                     APPEND FROM DBF("cursor_4c_MovFiltro")
1546:                 ENDIF
1547:                 IF USED("cursor_4c_MovFiltro")
1548:                     USE IN cursor_4c_MovFiltro
1549:                 ENDIF
1550:                 IF USED("cursor_4c_Movimentos")
1551:                     GO TOP IN cursor_4c_Movimentos
1552:                 ENDIF
1553:             ENDIF
1554:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2, "grd_4c_Disponivel", 5)
1555:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_Disponivel.Refresh()
1556:             ENDIF
1557:         CATCH TO loc_oErro
1558:             MsgErro("Erro em FormSigPrCtr.OptFilInteractiveChange:" + CHR(13) + ;
1559:                     loc_oErro.Message, "Erro")
1560:         ENDTRY
1561:     ENDPROC
1562: 
1563:     *--------------------------------------------------------------------------
1564:     * FormatarGridLista - Formata visual da grade de lotes (Page1)
1565:     *--------------------------------------------------------------------------
1566:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)

*-- Linhas 1631 a 1657:
1631:             IF USED("cursor_4c_BuscaGrp")
1632:                 USE IN cursor_4c_BuscaGrp
1633:             ENDIF
1634:             =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1635:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1636:                 "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
1637:             IF VARTYPE(loc_oBusca) = "O"
1638:                 IF !loc_oBusca.this_lSelecionou
1639:                     IF USED("cursor_4c_BuscaGrp")
1640:                         USE IN cursor_4c_BuscaGrp
1641:                     ENDIF
1642:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1643:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1644:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1645:                     loc_oBusca.Show()
1646:                 ENDIF
1647:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1648:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1649:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1650:                 ENDIF
1651:                 IF USED("cursor_4c_BuscaGrp")
1652:                     USE IN cursor_4c_BuscaGrp
1653:                 ENDIF
1654:                 loc_oBusca.Release()
1655:             ENDIF
1656:         CATCH TO loc_oErro
1657:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1688 a 1714:
1688:             IF USED("cursor_4c_BuscaCli")
1689:                 USE IN cursor_4c_BuscaCli
1690:             ENDIF
1691:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1692:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1693:                 "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1694:             IF VARTYPE(loc_oBusca) = "O"
1695:                 IF !loc_oBusca.this_lSelecionou
1696:                     IF USED("cursor_4c_BuscaCli")
1697:                         USE IN cursor_4c_BuscaCli
1698:                     ENDIF
1699:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1700:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1701:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1702:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1703:                     loc_oBusca.Show()
1704:                 ENDIF
1705:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1706:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1707:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1708:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1709:                     ENDIF
1710:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1711:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1712:                     ENDIF
1713:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1714:                 ENDIF

*-- Linhas 1752 a 1778:
1752:             IF USED("cursor_4c_BuscaCli")
1753:                 USE IN cursor_4c_BuscaCli
1754:             ENDIF
1755:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1756:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1757:                 "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1758:             IF VARTYPE(loc_oBusca) = "O"
1759:                 IF !loc_oBusca.this_lSelecionou
1760:                     IF USED("cursor_4c_BuscaCli")
1761:                         USE IN cursor_4c_BuscaCli
1762:                     ENDIF
1763:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1764:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1765:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1766:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1767:                     loc_oBusca.Show()
1768:                 ENDIF
1769:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1770:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1771:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1772:                     ENDIF
1773:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1774:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1775:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1776:                     ENDIF
1777:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1778:                 ENDIF

*-- Linhas 1816 a 1842:
1816:             IF USED("cursor_4c_BuscaMoe")
1817:                 USE IN cursor_4c_BuscaMoe
1818:             ENDIF
1819:             =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1820:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1821:                 "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
1822:             IF VARTYPE(loc_oBusca) = "O"
1823:                 IF !loc_oBusca.this_lSelecionou
1824:                     IF USED("cursor_4c_BuscaMoe")
1825:                         USE IN cursor_4c_BuscaMoe
1826:                     ENDIF
1827:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1828:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1829:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1830:                     loc_oBusca.Show()
1831:                 ENDIF
1832:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1833:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1834:                 ENDIF
1835:                 IF USED("cursor_4c_BuscaMoe")
1836:                     USE IN cursor_4c_BuscaMoe
1837:                 ENDIF
1838:                 loc_oBusca.Release()
1839:             ENDIF
1840:         CATCH TO loc_oErro
1841:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1842:         ENDTRY

*-- Linhas 1883 a 1904:
1883:             IF USED("cursor_4c_BuscaCli")
1884:                 USE IN cursor_4c_BuscaCli
1885:             ENDIF
1886:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1887:                        " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
1888:                        " ORDER BY Iclis"
1889:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1890: 
1891:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1892:                RECCOUNT("cursor_4c_BuscaCli") > 0
1893:                 loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1894:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1895:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1896:                 ENDIF
1897:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1898:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1899:                 ENDIF
1900:                 IF USED("cursor_4c_BuscaCli")
1901:                     USE IN cursor_4c_BuscaCli
1902:                 ENDIF
1903:                 THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
1904:             ELSE

*-- Linhas 1913 a 1940:
1913:                         IF USED("cursor_4c_BuscaCli")
1914:                             USE IN cursor_4c_BuscaCli
1915:                         ENDIF
1916:                         loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1917:                                    " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
1918:                                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
1919:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
1920:                            !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1921:                             IF USED("cursor_4c_BuscaCli")
1922:                                 USE IN cursor_4c_BuscaCli
1923:                             ENDIF
1924:                             =SQLEXEC(gnConnHandle, ;
1925:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1926:                                 "cursor_4c_BuscaCli")
1927:                         ENDIF
1928:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1929:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1930:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1931:                         loc_oBusca.Show()
1932:                     ENDIF
1933:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1934:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1935:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1936:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1937:                         ENDIF
1938:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1939:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1940:                         ENDIF

*-- Linhas 1993 a 2049:
1993:             IF USED("cursor_4c_BuscaCli")
1994:                 USE IN cursor_4c_BuscaCli
1995:             ENDIF
1996:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1997:                        " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
1998:                        " ORDER BY Rclis"
1999:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2000: 
2001:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2002:                RECCOUNT("cursor_4c_BuscaCli") = 1
2003:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2004:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2005:                 ENDIF
2006:                 loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2007:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2008:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2009:                 ENDIF
2010:                 IF USED("cursor_4c_BuscaCli")
2011:                     USE IN cursor_4c_BuscaCli
2012:                 ENDIF
2013:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2014:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
2015:                 ENDIF
2016:             ELSE
2017:                 *-- Multiplos ou nenhum: abre picker
2018:                 IF !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
2019:                     IF USED("cursor_4c_BuscaCli")
2020:                         USE IN cursor_4c_BuscaCli
2021:                     ENDIF
2022:                     =SQLEXEC(gnConnHandle, ;
2023:                         "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2024:                         "cursor_4c_BuscaCli")
2025:                 ENDIF
2026:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2027:                     "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
2028:                 IF VARTYPE(loc_oBusca) = "O"
2029:                     IF !loc_oBusca.this_lSelecionou
2030:                         IF USED("cursor_4c_BuscaCli")
2031:                             USE IN cursor_4c_BuscaCli
2032:                         ENDIF
2033:                         =SQLEXEC(gnConnHandle, ;
2034:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2035:                             "cursor_4c_BuscaCli")
2036:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2037:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
2038:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2039:                         loc_oBusca.Show()
2040:                     ENDIF
2041:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2042:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2043:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2044:                         ENDIF
2045:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2046:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2047:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2048:                         ENDIF
2049:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)

*-- Linhas 2096 a 2117:
2096:             IF USED("cursor_4c_BuscaCli")
2097:                 USE IN cursor_4c_BuscaCli
2098:             ENDIF
2099:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
2100:                        " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
2101:                        " ORDER BY Iclis"
2102:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2103: 
2104:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2105:                RECCOUNT("cursor_4c_BuscaCli") > 0
2106:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2107:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2108:                 ENDIF
2109:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
2110:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2111:                 ENDIF
2112:                 loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2113:                 IF USED("cursor_4c_BuscaCli")
2114:                     USE IN cursor_4c_BuscaCli
2115:                 ENDIF
2116:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2117:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)

*-- Linhas 2150 a 2203:
2150:             IF USED("cursor_4c_BuscaMoe")
2151:                 USE IN cursor_4c_BuscaMoe
2152:             ENDIF
2153:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2154:                        " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
2155:                        " ORDER BY CMoes"
2156:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
2157: 
2158:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
2159:                RECCOUNT("cursor_4c_BuscaMoe") > 0
2160:                 loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2161:                 IF USED("cursor_4c_BuscaMoe")
2162:                     USE IN cursor_4c_BuscaMoe
2163:                 ENDIF
2164:             ELSE
2165:                 IF USED("cursor_4c_BuscaMoe")
2166:                     USE IN cursor_4c_BuscaMoe
2167:                 ENDIF
2168:                 loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2169:                            " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
2170:                            EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
2171:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
2172:                    !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
2173:                     IF USED("cursor_4c_BuscaMoe")
2174:                         USE IN cursor_4c_BuscaMoe
2175:                     ENDIF
2176:                     =SQLEXEC(gnConnHandle, ;
2177:                         "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2178:                         "cursor_4c_BuscaMoe")
2179:                 ENDIF
2180:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2181:                     "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
2182:                 IF VARTYPE(loc_oBusca) = "O"
2183:                     IF !loc_oBusca.this_lSelecionou
2184:                         IF USED("cursor_4c_BuscaMoe")
2185:                             USE IN cursor_4c_BuscaMoe
2186:                         ENDIF
2187:                         =SQLEXEC(gnConnHandle, ;
2188:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2189:                             "cursor_4c_BuscaMoe")
2190:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2191:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2192:                         loc_oBusca.Show()
2193:                     ENDIF
2194:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2195:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2196:                     ELSE
2197:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2198:                     ENDIF
2199:                     IF USED("cursor_4c_BuscaMoe")
2200:                         USE IN cursor_4c_BuscaMoe
2201:                     ENDIF
2202:                     loc_oBusca.Release()
2203:                 ENDIF

*-- Linhas 2283 a 2336:
2283:     * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
2284:     *--------------------------------------------------------------------------
2285:     PROCEDURE CmdOperacaoClick()
2286:         LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro
2287: 
2288:         IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
2289:            RECCOUNT("cursor_4c_Pendentes") = 0
2290:             MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
2291:             RETURN
2292:         ENDIF
2293: 
2294:         TRY
2295:             SELECT cursor_4c_Pendentes
2296:             loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
2297:             loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
2298:             loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)
2299: 
2300:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
2301:                 MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
2302:                 RETURN
2303:             ENDIF
2304: 
2305:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
2306:                        EscaparSQL(loc_cDopes)
2307:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2308: 
2309:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
2310:                RECCOUNT("cursor_4c_TmpOpe") > 0
2311:                 IF USED("cursor_4c_TmpOpe")
2312:                     USE IN cursor_4c_TmpOpe
2313:                 ENDIF
2314:                 DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2315:             ELSE
2316:                 IF USED("cursor_4c_TmpOpe")
2317:                     USE IN cursor_4c_TmpOpe
2318:                 ENDIF
2319:                 loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
2320:                            EscaparSQL(loc_cDopes)
2321:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
2322:                 IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
2323:                    RECCOUNT("cursor_4c_TmpOpd") > 0
2324:                     IF USED("cursor_4c_TmpOpd")
2325:                         USE IN cursor_4c_TmpOpd
2326:                     ENDIF
2327:                     DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2328:                 ELSE
2329:                     IF USED("cursor_4c_TmpOpd")
2330:                         USE IN cursor_4c_TmpOpd
2331:                     ENDIF
2332:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2333:                              "o encontrada no cadastro.", "Aviso")
2334:                 ENDIF
2335:             ENDIF
2336:         CATCH TO loc_oErro

*-- Linhas 2415 a 2558:
2415:             ENDIF
2416: 
2417:             *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
2418:             IF !loc_lAbortou
2419:                 loc_cListaOriDopNums = ""
2420:                 IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0
2421:                     SELECT cursor_4c_Pendentes
2422:                     GO TOP
2423:                     SCAN
2424:                         loc_cListaOriDopNums = loc_cListaOriDopNums + ;
2425:                             IIF(EMPTY(loc_cListaOriDopNums), "", ",") + ;
2426:                             EscaparSQL(ALLTRIM(cursor_4c_Pendentes.OriDopNums))
2427:                     ENDSCAN
2428:                 ENDIF
2429:             ENDIF
2430: 
2431:             *-- Passo 4: busca estoque de distribuicao via SigMvItn
2432:             *-- SQLEXEC em cursor temporario para nao destruir colunas de grd_4c_Disponivel
2433:             IF !loc_lAbortou AND !EMPTY(loc_cListaOriDopNums)
2434:                 loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
2435:                            " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
2436:                            " SUM(a.QtReservas) AS QtReservas," + ;
2437:                            " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
2438:                            " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
2439:                            " a.CidChaves, a.Moedas" + ;
2440:                            " FROM SigMvItn a" + ;
2441:                            " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
2442:                            " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
2443:                            " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
2444:                            " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
2445:                            " WHERE e.Distribui = 3" + ;
2446:                            " AND c.GrupoOs <> SPACE(10) AND c.ContaOs <> SPACE(10)" + ;
2447:                            " AND a.CItem2 = 0 AND a.Qtds <> a.QtBaixas" + ;
2448:                            " AND a.EmpDopNums IN (" + loc_cListaOriDopNums + ")" + ;
2449:                            " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
2450:                            "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"
2451:                 IF USED("cursor_4c_MovTmp")
2452:                     USE IN cursor_4c_MovTmp
2453:                 ENDIF
2454:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTmp")
2455:                 IF loc_nResult < 0
2456:                     MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
2457:                     loc_lAbortou = .T.
2458:                 ELSE
2459:                     IF USED("cursor_4c_Movimentos")
2460:                         SELECT cursor_4c_Movimentos
2461:                         ZAP
2462:                         APPEND FROM DBF("cursor_4c_MovTmp")
2463:                     ELSE
2464:                         SELECT * FROM cursor_4c_MovTmp INTO CURSOR cursor_4c_Movimentos READWRITE
2465:                     ENDIF
2466:                     IF USED("cursor_4c_MovTmp")
2467:                         USE IN cursor_4c_MovTmp
2468:                     ENDIF
2469:                     GO TOP IN cursor_4c_Movimentos
2470:                 ENDIF
2471:             ENDIF
2472: 
2473:             IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
2474:                 loc_cListaOriDopNums = ""  && keep var in scope
2475:                 IF !USED("cursor_4c_Movimentos")
2476:                     SET NULL ON
2477:                     CREATE CURSOR cursor_4c_Movimentos ;
2478:                         ( Cpros C(14), Dpros C(30), Units N(12,4), ;
2479:                           Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
2480:                           OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
2481:                           CidChaves C(20), Moedas C(3) )
2482:                     SET NULL OFF
2483:                 ELSE
2484:                     ZAP IN cursor_4c_Movimentos
2485:                 ENDIF
2486:             ENDIF
2487: 
2488:             *-- Passo 5: aplica filtro Opt_Fil
2489:             loc_nTipo = 3
2490:             IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
2491:                 loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
2492:             ENDIF
2493: 
2494:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
2495:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
2496:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
2497:                 IF USED("cursor_4c_MovFiltro")
2498:                     USE IN cursor_4c_MovFiltro
2499:                 ENDIF
2500:                 IF loc_nTipo = 1
2501:                     SELECT * FROM cursor_4c_Movimentos ;
2502:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2503:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2504:                 ELSE
2505:                     SELECT * FROM cursor_4c_Movimentos ;
2506:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2507:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2508:                 ENDIF
2509:                 IF USED("cursor_4c_Movimentos")
2510:                     USE IN cursor_4c_Movimentos
2511:                 ENDIF
2512:                 IF USED("cursor_4c_MovFiltro")
2513:                     SELECT * FROM cursor_4c_MovFiltro ;
2514:                         INTO CURSOR cursor_4c_Movimentos READWRITE
2515:                     USE IN cursor_4c_MovFiltro
2516:                     GO TOP IN cursor_4c_Movimentos
2517:                 ENDIF
2518:             ENDIF
2519: 
2520:             *-- Passo 6: vincula grids de Page2 e muda para ela
2521:             IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
2522:                 loc_oPgDados.Page2.grd_4c_Disponivel.RecordSourceType = 1
2523:                 loc_oPgDados.Page2.grd_4c_Disponivel.ColumnCount = 7
2524:                 loc_oPgDados.Page2.grd_4c_Disponivel.RecordSource = "cursor_4c_Movimentos"
2525:                 WITH loc_oPgDados.Page2.grd_4c_Disponivel
2526:                     .Column1.ControlSource = "cursor_4c_Movimentos.Cpros"
2527:                     .Column2.ControlSource = "cursor_4c_Movimentos.Dpros"
2528:                     .Column3.ControlSource = "cursor_4c_Movimentos.Units"
2529:                     .Column4.ControlSource = "cursor_4c_Movimentos.Qtds"
2530:                     .Column5.ControlSource = "cursor_4c_Movimentos.QtBaixas"
2531:                     .Column6.ControlSource = "cursor_4c_Movimentos.QtReservas"
2532:                     .Column7.ControlSource = "cursor_4c_Movimentos.Saldo"
2533:                 ENDWITH
2534:             ENDIF
2535:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2536:                 loc_oPgDados.Page2.grd_4c_ItemXml.RecordSourceType = 1
2537:                 loc_oPgDados.Page2.grd_4c_ItemXml.ColumnCount = 4
2538:                 loc_oPgDados.Page2.grd_4c_ItemXml.RecordSource = "cursor_4c_Distribui"
2539:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2540:                     .Column1.ControlSource = "cursor_4c_Distribui.Cpros"
2541:                     .Column2.ControlSource = "cursor_4c_Distribui.Dpros"
2542:                     .Column3.ControlSource = "cursor_4c_Distribui.Qtds"
2543:                     .Column4.ControlSource = "cursor_4c_Distribui.Total"
2544:                 ENDWITH
2545:             ENDIF
2546:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2547:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2548:             ENDIF
2549:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2550:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2551:             ENDIF
2552:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)
2553:                 loc_oPgDados.ActivePage = 2
2554:             ENDIF
2555: 
2556:         CATCH TO loc_oErro
2557:             MsgErro("Erro em FormSigPrCtr.CmdProcessarClick:" + CHR(13) + ;
2558:                     loc_oErro.Message, "Erro")

*-- Linhas 2575 a 2593:
2575:                 USE IN cursor_4c_Itens
2576:             ENDIF
2577:             SET NULL ON
2578:             CREATE CURSOR cursor_4c_Itens ;
2579:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2580:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2581:                   desconto C(15), frete C(15) )
2582:             SET NULL OFF
2583: 
2584:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2585:             IF VARTYPE(loc_oXML) != "O"
2586:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2587:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2588:             ELSE
2589:                 loc_oXML.async = .F.
2590:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2591: 
2592:                 IF !loc_oXML.Load(par_cArquivo)
2593:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;

*-- Linhas 2600 a 2646:
2600:                             CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
2601:                     WAIT CLEAR
2602:                 ELSE
2603:                     loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2604:                     FOR loc_i = 0 TO loc_nItems - 1
2605:                         loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
2606:                         APPEND BLANK IN cursor_4c_Itens
2607:                         REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
2608:                                 IN cursor_4c_Itens
2609:                         REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
2610:                                 IN cursor_4c_Itens
2611:                         REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
2612:                                 IN cursor_4c_Itens
2613:                         REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
2614:                                 IN cursor_4c_Itens
2615:                         REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
2616:                                 IN cursor_4c_Itens
2617:                         REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
2618:                                 IN cursor_4c_Itens
2619:                         REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
2620:                                 IN cursor_4c_Itens
2621:                         REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
2622:                                 IN cursor_4c_Itens
2623:                         IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
2624:                             REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;
2625:                                     IN cursor_4c_Itens
2626:                         ENDIF
2627:                         IF loc_oNode.SelectNodes("prod/vFrete").Length > 0
2628:                             REPLACE frete WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vFrete")), 15) ;
2629:                                     IN cursor_4c_Itens
2630:                         ENDIF
2631:                         SELECT cursor_4c_Itens
2632:                     ENDFOR
2633: 
2634:                     WAIT CLEAR
2635:                     GO TOP IN cursor_4c_Itens
2636:                     loc_lResultado = .T.
2637:                     ENDIF
2638:                 ENDIF
2639:             ENDIF
2640: 
2641:         CATCH TO loc_oErro
2642:             WAIT CLEAR
2643:             MsgErro("Erro em FormSigPrCtr.ProcessarArquivoXML:" + CHR(13) + ;
2644:                     loc_oErro.Message, "Erro")
2645:         ENDTRY
2646: 

*-- Linhas 2658 a 2748:
2658:             USE IN cursor_4c_Distribui
2659:         ENDIF
2660:         SET NULL ON
2661:         CREATE CURSOR cursor_4c_Distribui ;
2662:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2663:         SET NULL OFF
2664: 
2665:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2666:             RETURN
2667:         ENDIF
2668: 
2669:         TRY
2670:             SELECT cursor_4c_Itens
2671:             GO TOP
2672: 
2673:             SCAN
2674:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2675:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2676:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2677:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))
2678: 
2679:                 IF !EMPTY(loc_cCodigo)
2680:                     IF USED("cursor_4c_ProdImport")
2681:                         USE IN cursor_4c_ProdImport
2682:                     ENDIF
2683: 
2684:                     loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2685:                                " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
2686:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2687: 
2688:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2689:                        RECCOUNT("cursor_4c_ProdImport") = 0
2690:                         IF USED("cursor_4c_ProdImport")
2691:                             USE IN cursor_4c_ProdImport
2692:                         ENDIF
2693:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2694:                                    " WHERE Cpros = " + EscaparSQL(loc_cCodigo)
2695:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2696:                     ENDIF
2697: 
2698:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2699:                        RECCOUNT("cursor_4c_ProdImport") = 0
2700:                         IF USED("cursor_4c_ProdImport")
2701:                             USE IN cursor_4c_ProdImport
2702:                         ENDIF
2703:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2704:                                    " WHERE Dpros = " + EscaparSQL(loc_cCodigo)
2705:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2706:                     ENDIF
2707: 
2708:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2709:                        RECCOUNT("cursor_4c_ProdImport") = 0
2710:                         IF USED("cursor_4c_ProdImport")
2711:                             USE IN cursor_4c_ProdImport
2712:                         ENDIF
2713:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2714:                                    " WHERE DPro2s = " + EscaparSQL(loc_cCodigo)
2715:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2716:                     ENDIF
2717: 
2718:                     IF USED("cursor_4c_ProdImport") AND RECCOUNT("cursor_4c_ProdImport") > 0
2719:                         SELECT cursor_4c_Distribui
2720:                         APPEND BLANK
2721:                         REPLACE Cpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Cpros), 14), ;
2722:                                 Dpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Dpros), 30), ;
2723:                                 Qtds  WITH loc_nQtd, ;
2724:                                 Units WITH loc_nVal, ;
2725:                                 Total WITH loc_nTot
2726:                     ENDIF
2727: 
2728:                     IF USED("cursor_4c_ProdImport")
2729:                         USE IN cursor_4c_ProdImport
2730:                     ENDIF
2731:                 ENDIF
2732: 
2733:                 SELECT cursor_4c_Itens
2734:             ENDSCAN
2735: 
2736:             IF USED("cursor_4c_Distribui")
2737:                 GO TOP IN cursor_4c_Distribui
2738:             ENDIF
2739: 
2740:         CATCH TO loc_oErro
2741:             MsgErro("Erro em FormSigPrCtr.CarregarItensXML:" + CHR(13) + ;
2742:                     loc_oErro.Message, "Erro")
2743:         ENDTRY
2744:     ENDPROC
2745: 
2746:     *--------------------------------------------------------------------------
2747:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2748:     *--------------------------------------------------------------------------

*-- Linhas 2754 a 2802:
2754:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2755:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2756:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2757:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2758:                     loc_oGrid.ColumnCount = 5
2759:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2760:                     WITH loc_oGrid
2761:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2762:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2763:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2764:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2765:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2766:                     ENDWITH
2767:                 ENDIF
2768:                 loc_lResultado = .T.
2769:             ENDIF
2770:         CATCH TO loc_oErro
2771:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2772:                     loc_oErro.Message, "Erro")
2773:         ENDTRY
2774: 
2775:         RETURN loc_lResultado
2776:     ENDPROC
2777: 
2778:     *--------------------------------------------------------------------------
2779:     * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
2780:     *--------------------------------------------------------------------------
2781:     PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
2782:         LOCAL loc_oNode, loc_cResult, loc_oErro
2783:         loc_cResult = ""
2784: 
2785:         TRY
2786:             IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
2787:                 loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
2788:                 IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
2789:                     loc_cResult = NVL(loc_oNode.Text, "")
2790:                 ENDIF
2791:             ENDIF
2792:         CATCH TO loc_oErro
2793:             MsgErro("Erro ao ler n" + CHR(243) + "XML '" + par_cXPath + ;
2794:                     "': " + loc_oErro.Message, "Erro XML")
2795:             loc_cResult = ""
2796:         ENDTRY
2797: 
2798:         RETURN loc_cResult
2799:     ENDFUNC
2800: 
2801:     *--------------------------------------------------------------------------
2802:     * ConfigurarPaginaDadosDetalhe - Controles do pgf_4c_Dados.Page2 (Detalhe)

*-- Linhas 2930 a 3026:
2930:                 .FontBold = .T.
2931:                 .FontUnderline = .T.
2932:                 .Header1.Caption = "C" + CHR(243) + "digo"
2933:                 .Header1.Alignment = 2
2934:                 .Header1.ForeColor = RGB(90, 90, 90)
2935:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2936:             ENDWITH
2937: 
2938:             WITH .Column2
2939:                 .Width = 235
2940:                 .Movable = .F.
2941:                 .Resizable = .F.
2942:                 .ReadOnly = .T.
2943:                 .BackColor = RGB(237, 242, 243)
2944:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2945:                 .Header1.Alignment = 2
2946:                 .Header1.ForeColor = RGB(90, 90, 90)
2947:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2948:             ENDWITH
2949: 
2950:             WITH .Column3
2951:                 .Width = 70
2952:                 .Movable = .F.
2953:                 .Resizable = .F.
2954:                 .ReadOnly = .T.
2955:                 .BackColor = RGB(237, 242, 243)
2956:                 .Header1.Caption = "Valor"
2957:                 .Header1.Alignment = 2
2958:                 .Header1.ForeColor = RGB(90, 90, 90)
2959:                 .ControlSource = "cursor_4c_Movimentos.Units"
2960:             ENDWITH
2961: 
2962:             WITH .Column4
2963:                 .Width = 63
2964:                 .Movable = .F.
2965:                 .Resizable = .F.
2966:                 .ReadOnly = .T.
2967:                 .BackColor = RGB(237, 242, 243)
2968:                 .FontBold = .T.
2969:                 .Header1.Caption = "Quantidade"
2970:                 .Header1.Alignment = 2
2971:                 .Header1.ForeColor = RGB(90, 90, 90)
2972:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2973:             ENDWITH
2974: 
2975:             WITH .Column5
2976:                 .Width = 63
2977:                 .Movable = .F.
2978:                 .Resizable = .F.
2979:                 .ReadOnly = .T.
2980:                 .BackColor = RGB(237, 242, 243)
2981:                 .FontBold = .T.
2982:                 .Header1.Caption = "Baixado"
2983:                 .Header1.Alignment = 2
2984:                 .Header1.ForeColor = RGB(90, 90, 90)
2985:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2986:             ENDWITH
2987: 
2988:             WITH .Column6
2989:                 .Width = 63
2990:                 .Movable = .F.
2991:                 .Resizable = .F.
2992:                 .ReadOnly = .T.
2993:                 .BackColor = RGB(237, 242, 243)
2994:                 .FontBold = .T.
2995:                 .Header1.Caption = "Reservado"
2996:                 .Header1.Alignment = 2
2997:                 .Header1.ForeColor = RGB(90, 90, 90)
2998:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2999:             ENDWITH
3000: 
3001:             WITH .Column7
3002:                 .Width = 63
3003:                 .Movable = .F.
3004:                 .Resizable = .F.
3005:                 .ReadOnly = .T.
3006:                 .BackColor = RGB(237, 242, 243)
3007:                 .FontBold = .T.
3008:                 .Header1.Caption = "Saldo"
3009:                 .Header1.Alignment = 2
3010:                 .Header1.ForeColor = RGB(90, 90, 90)
3011:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
3012:             ENDWITH
3013:         ENDWITH
3014:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
3015:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
3016: 
3017:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
3018:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
3019:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
3020:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
3021:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
3022:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
3023:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
3024:         WITH loc_oPg2P2.grd_4c_ItemXml
3025:             .FontName  = "Tahoma"
3026:             .FontSize = 8

*-- Linhas 3044 a 3103:
3044:                 .Header1.Caption = "C" + CHR(243) + "digo"
3045:                 .Header1.Alignment = 2
3046:                 .Header1.ForeColor = RGB(90, 90, 90)
3047:                 .ControlSource = "cursor_4c_Distribui.Cpros"
3048:             ENDWITH
3049: 
3050:             WITH .Column2
3051:                 .Width = 235
3052:                 .Movable = .F.
3053:                 .Resizable = .F.
3054:                 .ReadOnly = .T.
3055:                 .Enabled = .F.
3056:                 .ForeColor = RGB(0, 0, 0)
3057:                 .BackColor = RGB(237, 242, 243)
3058:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3059:                 .Header1.Alignment = 2
3060:                 .Header1.ForeColor = RGB(90, 90, 90)
3061:                 .ControlSource = "cursor_4c_Distribui.Dpros"
3062:             ENDWITH
3063: 
3064:             WITH .Column3
3065:                 .Width = 63
3066:                 .Movable = .F.
3067:                 .Resizable = .F.
3068:                 .InputMask = "999999"
3069:                 .ForeColor = RGB(0, 0, 0)
3070:                 .BackColor = RGB(237, 242, 243)
3071:                 .Header1.Caption = "Quantidade"
3072:                 .Header1.Alignment = 2
3073:                 .Header1.ForeColor = RGB(90, 90, 90)
3074:                 .ControlSource = "cursor_4c_Distribui.Qtds"
3075:             ENDWITH
3076: 
3077:             WITH .Column4
3078:                 .Width = 70
3079:                 .Movable = .F.
3080:                 .Resizable = .F.
3081:                 .ReadOnly = .T.
3082:                 .Enabled = .F.
3083:                 .ForeColor = RGB(0, 0, 0)
3084:                 .BackColor = RGB(237, 242, 243)
3085:                 .Header1.Caption = "Valor"
3086:                 .Header1.Alignment = 2
3087:                 .Header1.ForeColor = RGB(90, 90, 90)
3088:                 .ControlSource = "cursor_4c_Distribui.Total"
3089:             ENDWITH
3090:         ENDWITH
3091: 
3092:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
3093:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
3094:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
3095:             .Caption = ""
3096:             .Themes = .F.
3097:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3098:             .Top = 508
3099:             .Left = 663
3100:             .Width = 40
3101:             .Height = 37
3102:             .ForeColor = RGB(255, 0, 0)
3103:             .BackColor = RGB(255, 255, 255)

*-- Linhas 3451 a 3544:
3451:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3452:         LOCAL loc_lAbortou, loc_oErro
3453:         loc_lAbortou = .F.
3454: 
3455:         TRY
3456:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3457:                 loc_lAbortou = .T.
3458:             ENDIF
3459: 
3460:             IF !loc_lAbortou
3461:                 loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3462:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3463:                 IF EMPTY(loc_cCpros)
3464:                     loc_lAbortou = .T.
3465:                 ENDIF
3466:             ENDIF
3467: 
3468:             IF !loc_lAbortou
3469:                 loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
3470:                            " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
3471:                            " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3472:                 IF USED("cursor_4c_TmpPro")
3473:                     USE IN cursor_4c_TmpPro
3474:                 ENDIF
3475:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3476:                 IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3477:                     loc_lAbortou = .T.
3478:                 ENDIF
3479:             ENDIF
3480: 
3481:             IF !loc_lAbortou
3482:                 SELECT cursor_4c_TmpPro
3483:                 GO TOP
3484: 
3485:                 *-- Campos detalhe produto
3486:                 loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
3487:                 loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
3488:                 loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))
3489:                 loc_oPg2P2.txt_4c__custofs.Value        = NVL(cursor_4c_TmpPro.custofs, 0)
3490:                 loc_oPg2P2.txt_4c__precoMov.Value       = NVL(cursor_4c_TmpPro.pcuss, 0)
3491:                 loc_oPg2P2.txt_4c_CIdChaves.Value       = ALLTRIM(NVL(cursor_4c_Movimentos.CidChaves, ""))
3492:                 loc_oPg2P2.txt_4c_Emps.Value            = SUBSTR(cursor_4c_Movimentos.OriDopNums, 1, 3)
3493:                 loc_oPg2P2.txt_4c_Dopes.Value           = SUBSTR(cursor_4c_Movimentos.OriDopNums, 4, 20)
3494:                 loc_oPg2P2.txt_4c_Numes.Value           = ALLTRIM(RIGHT(cursor_4c_Movimentos.OriDopNums, 6))
3495: 
3496:                 *-- Preco de venda: converte para moeda padrao se configurada
3497:                 loc_cMoeDetqs = ""
3498:                 IF USED("cursor_4c_TmpPam")
3499:                     USE IN cursor_4c_TmpPam
3500:                 ENDIF
3501:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_TmpPam") > 0 ;
3502:                    AND USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
3503:                     loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_TmpPam.moedetqs, ""))
3504:                     USE IN cursor_4c_TmpPam
3505:                 ENDIF
3506: 
3507:                 IF EMPTY(loc_cMoeDetqs)
3508:                     loc_oPg2P2.txt_4c__pr_venda.Value       = NVL(cursor_4c_TmpPro.pvens, 0)
3509:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3510:                 ELSE
3511:                     loc_nCotAlvo  = 1
3512:                     loc_nCotVenda = 1
3513:                     IF USED("cursor_4c_TmpCot")
3514:                         USE IN cursor_4c_TmpCot
3515:                     ENDIF
3516:                     IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3517:                                EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", ;
3518:                                "cursor_4c_TmpCot") > 0 ;
3519:                        AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3520:                         loc_nCotAlvo = NVL(cursor_4c_TmpCot.valos, 1)
3521:                         USE IN cursor_4c_TmpCot
3522:                     ENDIF
3523:                     loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3524:                     IF !EMPTY(loc_cMoeVenda)
3525:                         IF USED("cursor_4c_TmpCot")
3526:                             USE IN cursor_4c_TmpCot
3527:                         ENDIF
3528:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3529:                                    EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", ;
3530:                                    "cursor_4c_TmpCot") > 0 ;
3531:                            AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3532:                             loc_nCotVenda = NVL(cursor_4c_TmpCot.valos, 1)
3533:                             USE IN cursor_4c_TmpCot
3534:                         ENDIF
3535:                     ENDIF
3536:                     loc_nValVenda = ROUND(NVL(cursor_4c_TmpPro.pvens, 0) * loc_nCotVenda / ;
3537:                                          IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
3538:                     loc_oPg2P2.txt_4c__pr_venda.Value       = loc_nValVenda
3539:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = loc_cMoeDetqs
3540:                 ENDIF
3541: 
3542:                 *-- FigJpg: imagem do produto (base64 em SigCdPro.FigJpgs)
3543:                 loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3544:                 loc_lTemFig  = !EMPTY(loc_cFigJpgs) AND !ISNULL(cursor_4c_TmpPro.FigJpgs)

*-- Linhas 3566 a 3699:
3566:                     loc_oErro.Message, "Erro")
3567:         ENDTRY
3568:     ENDPROC
3569: 
3570:     *--------------------------------------------------------------------------
3571:     * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
3572:     *--------------------------------------------------------------------------
3573:     PROCEDURE BtnExcluirSisClick()
3574:         LOCAL loc_oPg2P2, loc_oErro
3575:         TRY
3576:             IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
3577:                 SELECT cursor_4c_Movimentos
3578:                 DELETE
3579:                 IF !EOF("cursor_4c_Movimentos")
3580:                     SKIP
3581:                     SKIP -1
3582:                 ENDIF
3583:                 GO TOP IN cursor_4c_Movimentos
3584:             ENDIF
3585:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3586:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3587:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3588:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3589:             ENDIF
3590:         CATCH TO loc_oErro
3591:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3592:         ENDTRY
3593:     ENDPROC
3594: 
3595:     *--------------------------------------------------------------------------
3596:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3597:     *--------------------------------------------------------------------------
3598:     PROCEDURE BtnExcluirArqClick()
3599:         LOCAL loc_oPg2P2, loc_oErro
3600:         TRY
3601:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3602:                 SELECT cursor_4c_Distribui
3603:                 DELETE
3604:                 IF !EOF("cursor_4c_Distribui")
3605:                     SKIP
3606:                     SKIP -1
3607:                 ENDIF
3608:                 GO TOP IN cursor_4c_Distribui
3609:             ENDIF
3610:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3611:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3612:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3613:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3614:             ENDIF
3615:         CATCH TO loc_oErro
3616:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3617:         ENDTRY
3618:     ENDPROC
3619: 
3620:     *--------------------------------------------------------------------------
3621:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3622:     *--------------------------------------------------------------------------
3623:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3624:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3625:         TRY
3626:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3627:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3628:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
3629:                 IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
3630:                     SELECT cursor_4c_Movimentos
3631:                     loc_nRecno = RECNO()
3632:                     GO TOP
3633:                     LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
3634:                     IF EOF()
3635:                         GO loc_nRecno
3636:                     ENDIF
3637:                 ENDIF
3638:             ENDIF
3639:         CATCH TO loc_oErro
3640:             MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
3641:                     loc_oErro.Message, "Erro")
3642:         ENDTRY
3643:     ENDPROC
3644: 
3645:     *--------------------------------------------------------------------------
3646:     * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
3647:     *--------------------------------------------------------------------------
3648:     PROCEDURE ImgFigJpgDblClick()
3649:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
3650:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
3651:         TRY
3652:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3653:                 RETURN
3654:             ENDIF
3655:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3656:             IF EMPTY(loc_cCpros)
3657:                 RETURN
3658:             ENDIF
3659:             loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
3660:                        EscaparSQL(loc_cCpros)
3661:             IF USED("cursor_4c_TmpPro")
3662:                 USE IN cursor_4c_TmpPro
3663:             ENDIF
3664:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3665:             IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3666:                 RETURN
3667:             ENDIF
3668:             SELECT cursor_4c_TmpPro
3669:             GO TOP
3670:             loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3671:             IF USED("cursor_4c_TmpPro")
3672:                 USE IN cursor_4c_TmpPro
3673:             ENDIF
3674:             IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
3675:                 loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3676:                 loc_cFoto = STRCONV(;
3677:                     STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3678:                         "data:image/png;base64,", ""), ;
3679:                         "data:image/jpeg;base64,", ""), ;
3680:                         "data:image/jpg;base64,", ""), 14)
3681:                 STRTOFILE(loc_cFoto, loc_cArqTemp)
3682:                 IF FILE(loc_cArqTemp)
3683:                     loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
3684:                                    ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
3685:                     IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
3686:                        FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
3687:                         DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
3688:                             WITH loc_cArqTemp, loc_cCaption, " "
3689:                     ELSE
3690:                         DECLARE INTEGER ShellExecute IN shell32.dll ;
3691:                             INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
3692:                             STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
3693:                         ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
3694:                     ENDIF
3695:                 ENDIF
3696:             ENDIF
3697:         CATCH TO loc_oErro
3698:             MsgErro("Erro em FormSigPrCtr.ImgFigJpgDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3699:         ENDTRY

*-- Linhas 3709 a 3780:
3709:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3710:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3711:                     RETURN
3712:                 ENDIF
3713:             ENDIF
3714:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3715:                 RETURN
3716:             ENDIF
3717:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3718:             IF EMPTY(loc_cCpros)
3719:                 RETURN
3720:             ENDIF
3721:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3722:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3723:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3724:             ELSE
3725:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
3726:                         ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
3727:             ENDIF
3728:         CATCH TO loc_oErro
3729:             MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3730:         ENDTRY
3731:     ENDPROC
3732: 
3733:     *--------------------------------------------------------------------------
3734:     * Destroy - Libera BO e fecha cursores
3735:     *--------------------------------------------------------------------------
3736:     PROCEDURE Destroy()
3737:         LOCAL loc_oErro
3738: 
3739:         TRY
3740:             IF USED("cursor_4c_Dados")
3741:                 USE IN cursor_4c_Dados
3742:             ENDIF
3743: 
3744:             IF USED("cursor_4c_Movimentos")
3745:                 USE IN cursor_4c_Movimentos
3746:             ENDIF
3747: 
3748:             IF USED("cursor_4c_Pendentes")
3749:                 USE IN cursor_4c_Pendentes
3750:             ENDIF
3751: 
3752:             IF USED("cursor_4c_Linhas")
3753:                 USE IN cursor_4c_Linhas
3754:             ENDIF
3755: 
3756:             IF USED("cursor_4c_Itens")
3757:                 USE IN cursor_4c_Itens
3758:             ENDIF
3759: 
3760:             IF USED("cursor_4c_Distribui")
3761:                 USE IN cursor_4c_Distribui
3762:             ENDIF
3763: 
3764:             IF USED("cursor_4c_TmpJoin")
3765:                 USE IN cursor_4c_TmpJoin
3766:             ENDIF
3767: 
3768:             IF USED("cursor_4c_MovTmp")
3769:                 USE IN cursor_4c_MovTmp
3770:             ENDIF
3771: 
3772:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3773:                 THIS.this_oBusinessObject = .NULL.
3774:             ENDIF
3775:         CATCH TO loc_oErro
3776:             MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
3777:         ENDTRY
3778: 
3779:         DODEFAULT()
3780:     ENDPROC


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

