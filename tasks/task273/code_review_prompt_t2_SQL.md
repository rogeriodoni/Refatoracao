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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS SQL (3779 linhas total):

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
1477:                         loc_oGrid.Column1.Header1.Caption = "N" + CHR(250) + "mero"
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

*-- Linhas 1630 a 1656:
1630:             IF USED("cursor_4c_BuscaGrp")
1631:                 USE IN cursor_4c_BuscaGrp
1632:             ENDIF
1633:             =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1634:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGrp", ;
1635:                 "cursor_4c_BuscaGrp", "cgrus", loc_cGrupo, "Grupo", .T., .T., "")
1636:             IF VARTYPE(loc_oBusca) = "O"
1637:                 IF !loc_oBusca.this_lSelecionou
1638:                     IF USED("cursor_4c_BuscaGrp")
1639:                         USE IN cursor_4c_BuscaGrp
1640:                     ENDIF
1641:                     =SQLEXEC(gnConnHandle, "SELECT cgrus, dgrus FROM SigCdGrp ORDER BY cgrus", "cursor_4c_BuscaGrp")
1642:                     loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
1643:                     loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
1644:                     loc_oBusca.Show()
1645:                 ENDIF
1646:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1647:                     loc_oPg2P1.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1648:                     THIS.this_oBusinessObject.this_cGrupo = ALLTRIM(cursor_4c_BuscaGrp.cgrus)
1649:                 ENDIF
1650:                 IF USED("cursor_4c_BuscaGrp")
1651:                     USE IN cursor_4c_BuscaGrp
1652:                 ENDIF
1653:                 loc_oBusca.Release()
1654:             ENDIF
1655:         CATCH TO loc_oErro
1656:             MsgErro("Erro em FormSigPrCtr.AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1687 a 1713:
1687:             IF USED("cursor_4c_BuscaCli")
1688:                 USE IN cursor_4c_BuscaCli
1689:             ENDIF
1690:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1691:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1692:                 "cursor_4c_BuscaCli", "Iclis", loc_cConta, "Fornecedor", .T., .T., "")
1693:             IF VARTYPE(loc_oBusca) = "O"
1694:                 IF !loc_oBusca.this_lSelecionou
1695:                     IF USED("cursor_4c_BuscaCli")
1696:                         USE IN cursor_4c_BuscaCli
1697:                     ENDIF
1698:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", "cursor_4c_BuscaCli")
1699:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1700:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1701:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1702:                     loc_oBusca.Show()
1703:                 ENDIF
1704:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1705:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1706:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1707:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1708:                     ENDIF
1709:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1710:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1711:                     ENDIF
1712:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1713:                 ENDIF

*-- Linhas 1751 a 1777:
1751:             IF USED("cursor_4c_BuscaCli")
1752:                 USE IN cursor_4c_BuscaCli
1753:             ENDIF
1754:             =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1755:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1756:                 "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
1757:             IF VARTYPE(loc_oBusca) = "O"
1758:                 IF !loc_oBusca.this_lSelecionou
1759:                     IF USED("cursor_4c_BuscaCli")
1760:                         USE IN cursor_4c_BuscaCli
1761:                     ENDIF
1762:                     =SQLEXEC(gnConnHandle, "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", "cursor_4c_BuscaCli")
1763:                     loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1764:                     loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1765:                     loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1766:                     loc_oBusca.Show()
1767:                 ENDIF
1768:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1769:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
1770:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1771:                     ENDIF
1772:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1773:                     IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1774:                         loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1775:                     ENDIF
1776:                     THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)
1777:                 ENDIF

*-- Linhas 1815 a 1841:
1815:             IF USED("cursor_4c_BuscaMoe")
1816:                 USE IN cursor_4c_BuscaMoe
1817:             ENDIF
1818:             =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1819:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
1820:                 "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
1821:             IF VARTYPE(loc_oBusca) = "O"
1822:                 IF !loc_oBusca.this_lSelecionou
1823:                     IF USED("cursor_4c_BuscaMoe")
1824:                         USE IN cursor_4c_BuscaMoe
1825:                     ENDIF
1826:                     =SQLEXEC(gnConnHandle, "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", "cursor_4c_BuscaMoe")
1827:                     loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
1828:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1829:                     loc_oBusca.Show()
1830:                 ENDIF
1831:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1832:                     loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1833:                 ENDIF
1834:                 IF USED("cursor_4c_BuscaMoe")
1835:                     USE IN cursor_4c_BuscaMoe
1836:                 ENDIF
1837:                 loc_oBusca.Release()
1838:             ENDIF
1839:         CATCH TO loc_oErro
1840:             MsgErro("Erro em FormSigPrCtr.AbrirLookupMoeda:" + CHR(13) + loc_oErro.Message, "Erro")
1841:         ENDTRY

*-- Linhas 1882 a 1903:
1882:             IF USED("cursor_4c_BuscaCli")
1883:                 USE IN cursor_4c_BuscaCli
1884:             ENDIF
1885:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1886:                        " WHERE LTRIM(RTRIM(Iclis)) = " + EscaparSQL(loc_cConta) + ;
1887:                        " ORDER BY Iclis"
1888:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1889: 
1890:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
1891:                RECCOUNT("cursor_4c_BuscaCli") > 0
1892:                 loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1893:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1894:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1895:                 ENDIF
1896:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1897:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1898:                 ENDIF
1899:                 IF USED("cursor_4c_BuscaCli")
1900:                     USE IN cursor_4c_BuscaCli
1901:                 ENDIF
1902:                 THIS.CarregarMovimentosPendentes(loc_cConta, .T.)
1903:             ELSE

*-- Linhas 1912 a 1939:
1912:                         IF USED("cursor_4c_BuscaCli")
1913:                             USE IN cursor_4c_BuscaCli
1914:                         ENDIF
1915:                         loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1916:                                    " WHERE CAST(Iclis AS VARCHAR(20)) LIKE " + ;
1917:                                    EscaparSQL(loc_cConta + "%") + " ORDER BY Iclis"
1918:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli") < 1 OR ;
1919:                            !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
1920:                             IF USED("cursor_4c_BuscaCli")
1921:                                 USE IN cursor_4c_BuscaCli
1922:                             ENDIF
1923:                             =SQLEXEC(gnConnHandle, ;
1924:                                 "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Iclis", ;
1925:                                 "cursor_4c_BuscaCli")
1926:                         ENDIF
1927:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1928:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
1929:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
1930:                         loc_oBusca.Show()
1931:                     ENDIF
1932:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
1933:                         loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
1934:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
1935:                             loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
1936:                         ENDIF
1937:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
1938:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
1939:                         ENDIF

*-- Linhas 1992 a 2048:
1992:             IF USED("cursor_4c_BuscaCli")
1993:                 USE IN cursor_4c_BuscaCli
1994:             ENDIF
1995:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
1996:                        " WHERE Rclis LIKE " + EscaparSQL(loc_cDconta + "%") + ;
1997:                        " ORDER BY Rclis"
1998:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
1999: 
2000:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2001:                RECCOUNT("cursor_4c_BuscaCli") = 1
2002:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2003:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2004:                 ENDIF
2005:                 loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2006:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2007:                     loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2008:                 ENDIF
2009:                 IF USED("cursor_4c_BuscaCli")
2010:                     USE IN cursor_4c_BuscaCli
2011:                 ENDIF
2012:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2013:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)
2014:                 ENDIF
2015:             ELSE
2016:                 *-- Multiplos ou nenhum: abre picker
2017:                 IF !USED("cursor_4c_BuscaCli") OR RECCOUNT("cursor_4c_BuscaCli") = 0
2018:                     IF USED("cursor_4c_BuscaCli")
2019:                         USE IN cursor_4c_BuscaCli
2020:                     ENDIF
2021:                     =SQLEXEC(gnConnHandle, ;
2022:                         "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2023:                         "cursor_4c_BuscaCli")
2024:                 ENDIF
2025:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
2026:                     "cursor_4c_BuscaCli", "Rclis", loc_cDconta, "Fornecedor", .T., .T., "")
2027:                 IF VARTYPE(loc_oBusca) = "O"
2028:                     IF !loc_oBusca.this_lSelecionou
2029:                         IF USED("cursor_4c_BuscaCli")
2030:                             USE IN cursor_4c_BuscaCli
2031:                         ENDIF
2032:                         =SQLEXEC(gnConnHandle, ;
2033:                             "SELECT Iclis, Rclis, Cpfs FROM SigCdCli ORDER BY Rclis", ;
2034:                             "cursor_4c_BuscaCli")
2035:                         loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2036:                         loc_oBusca.mAddColuna("Rclis", "", "Fornecedor")
2037:                         loc_oBusca.mAddColuna("Cpfs",  "", "CPF/CNPJ")
2038:                         loc_oBusca.Show()
2039:                     ENDIF
2040:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
2041:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2042:                             loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2043:                         ENDIF
2044:                         loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2045:                         IF PEMSTATUS(loc_oPg2P1, "txt_4c_Cpf", 5)
2046:                             loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2047:                         ENDIF
2048:                         THIS.CarregarMovimentosPendentes(ALLTRIM(cursor_4c_BuscaCli.Iclis), .T.)

*-- Linhas 2095 a 2116:
2095:             IF USED("cursor_4c_BuscaCli")
2096:                 USE IN cursor_4c_BuscaCli
2097:             ENDIF
2098:             loc_cSQL = "SELECT Iclis, Rclis, Cpfs FROM SigCdCli" + ;
2099:                        " WHERE LTRIM(RTRIM(Cpfs)) = " + EscaparSQL(loc_cCpfLimpo) + ;
2100:                        " ORDER BY Iclis"
2101:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCli")
2102: 
2103:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaCli") AND ;
2104:                RECCOUNT("cursor_4c_BuscaCli") > 0
2105:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2106:                     loc_oPg2P1.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaCli.Iclis)
2107:                 ENDIF
2108:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Dconta", 5)
2109:                     loc_oPg2P1.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.Rclis)
2110:                 ENDIF
2111:                 loc_oPg2P1.txt_4c_Cpf.Value = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2112:                 IF USED("cursor_4c_BuscaCli")
2113:                     USE IN cursor_4c_BuscaCli
2114:                 ENDIF
2115:                 IF PEMSTATUS(loc_oPg2P1, "txt_4c_Conta", 5)
2116:                     THIS.CarregarMovimentosPendentes(ALLTRIM(loc_oPg2P1.txt_4c_Conta.Value), .T.)

*-- Linhas 2149 a 2202:
2149:             IF USED("cursor_4c_BuscaMoe")
2150:                 USE IN cursor_4c_BuscaMoe
2151:             ENDIF
2152:             loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2153:                        " WHERE LTRIM(RTRIM(CMoes)) = " + EscaparSQL(loc_cMoeda) + ;
2154:                        " ORDER BY CMoes"
2155:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe")
2156: 
2157:             IF loc_nResult >= 0 AND USED("cursor_4c_BuscaMoe") AND ;
2158:                RECCOUNT("cursor_4c_BuscaMoe") > 0
2159:                 loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2160:                 IF USED("cursor_4c_BuscaMoe")
2161:                     USE IN cursor_4c_BuscaMoe
2162:                 ENDIF
2163:             ELSE
2164:                 IF USED("cursor_4c_BuscaMoe")
2165:                     USE IN cursor_4c_BuscaMoe
2166:                 ENDIF
2167:                 loc_cSQL = "SELECT CMoes, DMoes FROM SigCdMoe" + ;
2168:                            " WHERE CAST(CMoes AS VARCHAR(10)) LIKE " + ;
2169:                            EscaparSQL(loc_cMoeda + "%") + " ORDER BY CMoes"
2170:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaMoe") < 1 OR ;
2171:                    !USED("cursor_4c_BuscaMoe") OR RECCOUNT("cursor_4c_BuscaMoe") = 0
2172:                     IF USED("cursor_4c_BuscaMoe")
2173:                         USE IN cursor_4c_BuscaMoe
2174:                     ENDIF
2175:                     =SQLEXEC(gnConnHandle, ;
2176:                         "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2177:                         "cursor_4c_BuscaMoe")
2178:                 ENDIF
2179:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
2180:                     "cursor_4c_BuscaMoe", "CMoes", loc_cMoeda, "Moeda", .T., .T., "")
2181:                 IF VARTYPE(loc_oBusca) = "O"
2182:                     IF !loc_oBusca.this_lSelecionou
2183:                         IF USED("cursor_4c_BuscaMoe")
2184:                             USE IN cursor_4c_BuscaMoe
2185:                         ENDIF
2186:                         =SQLEXEC(gnConnHandle, ;
2187:                             "SELECT CMoes, DMoes FROM SigCdMoe ORDER BY CMoes", ;
2188:                             "cursor_4c_BuscaMoe")
2189:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2190:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2191:                         loc_oBusca.Show()
2192:                     ENDIF
2193:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
2194:                         loc_oPg2P1.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
2195:                     ELSE
2196:                         loc_oPg2P1.txt_4c_Moeda.Value = ""
2197:                     ENDIF
2198:                     IF USED("cursor_4c_BuscaMoe")
2199:                         USE IN cursor_4c_BuscaMoe
2200:                     ENDIF
2201:                     loc_oBusca.Release()
2202:                 ENDIF

*-- Linhas 2282 a 2335:
2282:     * CmdOperacaoClick - Abre movimentacao para o registro selecionado no grdEstoque
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE CmdOperacaoClick()
2285:         LOCAL loc_cDopes, loc_cNumes, loc_cEmps, loc_cSQL, loc_nResult, loc_oErro
2286: 
2287:         IF !USED("cursor_4c_Pendentes") OR EOF("cursor_4c_Pendentes") OR ;
2288:            RECCOUNT("cursor_4c_Pendentes") = 0
2289:             MsgAviso("Selecione uma movimenta" + CHR(231) + CHR(227) + "o na grade.", "Aviso")
2290:             RETURN
2291:         ENDIF
2292: 
2293:         TRY
2294:             SELECT cursor_4c_Pendentes
2295:             loc_cEmps  = ALLTRIM(cursor_4c_Pendentes.Emps)
2296:             loc_cDopes = ALLTRIM(cursor_4c_Pendentes.Dopes)
2297:             loc_cNumes = ALLTRIM(cursor_4c_Pendentes.Numes)
2298: 
2299:             IF EMPTY(loc_cEmps) OR EMPTY(loc_cDopes) OR EMPTY(loc_cNumes)
2300:                 MsgAviso("Selecione um registro v" + CHR(225) + "lido na grade.", "Aviso")
2301:                 RETURN
2302:             ENDIF
2303: 
2304:             loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE LTRIM(RTRIM(Dopes)) = " + ;
2305:                        EscaparSQL(loc_cDopes)
2306:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2307: 
2308:             IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpe") AND ;
2309:                RECCOUNT("cursor_4c_TmpOpe") > 0
2310:                 IF USED("cursor_4c_TmpOpe")
2311:                     USE IN cursor_4c_TmpOpe
2312:                 ENDIF
2313:                 DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2314:             ELSE
2315:                 IF USED("cursor_4c_TmpOpe")
2316:                     USE IN cursor_4c_TmpOpe
2317:                 ENDIF
2318:                 loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE LTRIM(RTRIM(Dopps)) = " + ;
2319:                            EscaparSQL(loc_cDopes)
2320:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")
2321:                 IF loc_nResult >= 0 AND USED("cursor_4c_TmpOpd") AND ;
2322:                    RECCOUNT("cursor_4c_TmpOpd") > 0
2323:                     IF USED("cursor_4c_TmpOpd")
2324:                         USE IN cursor_4c_TmpOpd
2325:                     ENDIF
2326:                     DO FORM FormSigMvExp WITH loc_cDopes, "C", loc_cNumes, loc_cEmps, .T.
2327:                 ELSE
2328:                     IF USED("cursor_4c_TmpOpd")
2329:                         USE IN cursor_4c_TmpOpd
2330:                     ENDIF
2331:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
2332:                              "o encontrada no cadastro.", "Aviso")
2333:                 ENDIF
2334:             ENDIF
2335:         CATCH TO loc_oErro

*-- Linhas 2414 a 2555:
2414:             ENDIF
2415: 
2416:             *-- Passo 3: monta lista de OriDopNums das movimentacoes para IN clause
2417:             IF !loc_lAbortou
2418:                 loc_cListaOriDopNums = ""
2419:                 IF USED("cursor_4c_Pendentes") AND RECCOUNT("cursor_4c_Pendentes") > 0
2420:                     SELECT cursor_4c_Pendentes
2421:                     GO TOP
2422:                     SCAN
2423:                         loc_cListaOriDopNums = loc_cListaOriDopNums + ;
2424:                             IIF(EMPTY(loc_cListaOriDopNums), "", ",") + ;
2425:                             EscaparSQL(ALLTRIM(cursor_4c_Pendentes.OriDopNums))
2426:                     ENDSCAN
2427:                 ENDIF
2428:             ENDIF
2429: 
2430:             *-- Passo 4: busca estoque de distribuicao via SigMvItn
2431:             *-- SQLEXEC em cursor temporario para nao destruir colunas de grd_4c_Disponivel
2432:             IF !loc_lAbortou AND !EMPTY(loc_cListaOriDopNums)
2433:                 loc_cSQL = "SELECT a.Cpros, f.Dpros, a.Units," + ;
2434:                            " SUM(a.Qtds) AS Qtds, SUM(a.QtBaixas) AS QtBaixas," + ;
2435:                            " SUM(a.QtReservas) AS QtReservas," + ;
2436:                            " (SUM(a.Qtds) - SUM(a.QtBaixas) - SUM(a.QtReservas)) AS Saldo," + ;
2437:                            " a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus," + ;
2438:                            " a.CidChaves, a.Moedas" + ;
2439:                            " FROM SigMvItn a" + ;
2440:                            " JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums" + ;
2441:                            " JOIN SigCdOpe d ON c.Dopes = d.Dopes" + ;
2442:                            " JOIN SigOpCdd e ON d.Dopes = e.Dopes" + ;
2443:                            " JOIN SigCdPro f ON a.Cpros = f.Cpros" + ;
2444:                            " WHERE e.Distribui = 3" + ;
2445:                            " AND c.GrupoOs <> SPACE(10) AND c.ContaOs <> SPACE(10)" + ;
2446:                            " AND a.CItem2 = 0 AND a.Qtds <> a.QtBaixas" + ;
2447:                            " AND a.EmpDopNums IN (" + loc_cListaOriDopNums + ")" + ;
2448:                            " GROUP BY a.Cpros, f.Dpros, f.Cgrus, f.Sgrus," + ;
2449:                            "   a.EmpDopNums, a.Units, a.CidChaves, a.Moedas"
2450:                 IF USED("cursor_4c_MovTmp")
2451:                     USE IN cursor_4c_MovTmp
2452:                 ENDIF
2453:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MovTmp")
2454:                 IF loc_nResult < 0
2455:                     MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
2456:                     loc_lAbortou = .T.
2457:                 ELSE
2458:                     IF USED("cursor_4c_Movimentos")
2459:                         SELECT cursor_4c_Movimentos
2460:                         ZAP
2461:                         APPEND FROM DBF("cursor_4c_MovTmp")
2462:                     ELSE
2463:                         SELECT * FROM cursor_4c_MovTmp INTO CURSOR cursor_4c_Movimentos READWRITE
2464:                     ENDIF
2465:                     IF USED("cursor_4c_MovTmp")
2466:                         USE IN cursor_4c_MovTmp
2467:                     ENDIF
2468:                     GO TOP IN cursor_4c_Movimentos
2469:                 ENDIF
2470:             ENDIF
2471: 
2472:             IF !loc_lAbortou AND EMPTY(loc_cListaOriDopNums)
2473:                 loc_cListaOriDopNums = ""  && keep var in scope
2474:                 IF !USED("cursor_4c_Movimentos")
2475:                     SET NULL ON
2476:                     CREATE CURSOR cursor_4c_Movimentos ;
2477:                         ( Cpros C(14), Dpros C(30), Units N(12,4), ;
2478:                           Qtds N(12,2), QtBaixas N(12,2), QtReservas N(12,2), Saldo N(12,2), ;
2479:                           OriDopNums C(29), Cgrus C(10), Sgrus C(10), ;
2480:                           CidChaves C(20), Moedas C(3) )
2481:                     SET NULL OFF
2482:                 ELSE
2483:                     ZAP IN cursor_4c_Movimentos
2484:                 ENDIF
2485:             ENDIF
2486: 
2487:             *-- Passo 5: aplica filtro Opt_Fil
2488:             loc_nTipo = 3
2489:             IF PEMSTATUS(loc_oPg2P1, "opt_4c_Fil", 5)
2490:                 loc_nTipo = loc_oPg2P1.opt_4c_Fil.Value
2491:             ENDIF
2492: 
2493:             IF loc_nTipo != 3 AND USED("cursor_4c_Distribui") AND ;
2494:                RECCOUNT("cursor_4c_Distribui") > 0 AND ;
2495:                USED("cursor_4c_Movimentos") AND RECCOUNT("cursor_4c_Movimentos") > 0
2496:                 IF USED("cursor_4c_MovFiltro")
2497:                     USE IN cursor_4c_MovFiltro
2498:                 ENDIF
2499:                 IF loc_nTipo = 1
2500:                     SELECT * FROM cursor_4c_Movimentos ;
2501:                         WHERE Cpros IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2502:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2503:                 ELSE
2504:                     SELECT * FROM cursor_4c_Movimentos ;
2505:                         WHERE Cpros NOT IN (SELECT Cpros FROM cursor_4c_Distribui) ;
2506:                         INTO CURSOR cursor_4c_MovFiltro READWRITE
2507:                 ENDIF
2508:                 IF USED("cursor_4c_Movimentos")
2509:                     USE IN cursor_4c_Movimentos
2510:                 ENDIF
2511:                 IF USED("cursor_4c_MovFiltro")
2512:                     SELECT * FROM cursor_4c_MovFiltro ;
2513:                         INTO CURSOR cursor_4c_Movimentos READWRITE
2514:                     USE IN cursor_4c_MovFiltro
2515:                     GO TOP IN cursor_4c_Movimentos
2516:                 ENDIF
2517:             ENDIF
2518: 
2519:             *-- Passo 6: vincula grids de Page2 e muda para ela
2520:             IF USED("cursor_4c_Movimentos") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_Disponivel", 5)
2521:                 WITH loc_oPgDados.Page2.grd_4c_Disponivel
2522:                     .RecordSourceType = 1
2523:                     .RecordSource     = "cursor_4c_Movimentos"
2524:                     .Column1.ControlSource = "cursor_4c_Movimentos.Cpros"
2525:                     .Column2.ControlSource = "cursor_4c_Movimentos.Dpros"
2526:                     .Column3.ControlSource = "cursor_4c_Movimentos.Units"
2527:                     .Column4.ControlSource = "cursor_4c_Movimentos.Qtds"
2528:                     .Column5.ControlSource = "cursor_4c_Movimentos.QtBaixas"
2529:                     .Column6.ControlSource = "cursor_4c_Movimentos.QtReservas"
2530:                     .Column7.ControlSource = "cursor_4c_Movimentos.Saldo"
2531:                 ENDWITH
2532:             ENDIF
2533:             IF USED("cursor_4c_Distribui") AND PEMSTATUS(loc_oPgDados.Page2, "grd_4c_ItemXml", 5)
2534:                 WITH loc_oPgDados.Page2.grd_4c_ItemXml
2535:                     .RecordSourceType = 1
2536:                     .RecordSource     = "cursor_4c_Distribui"
2537:                     .Column1.ControlSource = "cursor_4c_Distribui.Cpros"
2538:                     .Column2.ControlSource = "cursor_4c_Distribui.Dpros"
2539:                     .Column3.ControlSource = "cursor_4c_Distribui.Qtds"
2540:                     .Column4.ControlSource = "cursor_4c_Distribui.Total"
2541:                 ENDWITH
2542:             ENDIF
2543:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Sistema", 5)
2544:                 loc_oPgDados.Page2.txt_4c_Sistema.Value = "Sistema"
2545:             ENDIF
2546:             IF PEMSTATUS(loc_oPgDados.Page2, "txt_4c_Arquivo", 5)
2547:                 loc_oPgDados.Page2.txt_4c_Arquivo.Value = "Arquivo"
2548:             ENDIF
2549:             IF PEMSTATUS(loc_oPgDados, "ActivePage", 5)
2550:                 loc_oPgDados.ActivePage = 2
2551:             ENDIF
2552: 
2553:         CATCH TO loc_oErro
2554:             MsgErro("Erro em FormSigPrCtr.CmdProcessarClick:" + CHR(13) + ;
2555:                     loc_oErro.Message, "Erro")

*-- Linhas 2572 a 2590:
2572:                 USE IN cursor_4c_Itens
2573:             ENDIF
2574:             SET NULL ON
2575:             CREATE CURSOR cursor_4c_Itens ;
2576:                 ( codigo C(15), Descr C(60), quant C(15), valor_uni C(15), ;
2577:                   valor_tot C(15), unid C(5), cfop C(4), ncm C(8), ;
2578:                   desconto C(15), frete C(15) )
2579:             SET NULL OFF
2580: 
2581:             loc_oXML = CREATEOBJECT("MSXML2.DOMDocument")
2582:             IF VARTYPE(loc_oXML) != "O"
2583:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
2584:                         "vel criar objeto MSXML2.DOMDocument.", "Erro COM")
2585:             ELSE
2586:                 loc_oXML.async = .F.
2587:                 WAIT WINDOW "Carregando: " + JUSTFNAME(par_cArquivo) NOWAIT
2588: 
2589:                 IF !loc_oXML.Load(par_cArquivo)
2590:                     MsgErro(JUSTFNAME(par_cArquivo) + " est" + CHR(225) + ;

*-- Linhas 2597 a 2643:
2597:                             CHR(227) + "o!", "Formato Inv" + CHR(225) + "lido")
2598:                     WAIT CLEAR
2599:                 ELSE
2600:                     loc_nItems = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2601:                     FOR loc_i = 0 TO loc_nItems - 1
2602:                         loc_oNode = loc_oXML.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_i)
2603:                         APPEND BLANK IN cursor_4c_Itens
2604:                         REPLACE codigo    WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/cProd")), 15) ;
2605:                                 IN cursor_4c_Itens
2606:                         REPLACE Descr     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/xProd")), 60) ;
2607:                                 IN cursor_4c_Itens
2608:                         REPLACE quant     WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/qCom")),  15) ;
2609:                                 IN cursor_4c_Itens
2610:                         REPLACE valor_uni WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vUnCom")),15) ;
2611:                                 IN cursor_4c_Itens
2612:                         REPLACE valor_tot WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vProd")), 15) ;
2613:                                 IN cursor_4c_Itens
2614:                         REPLACE unid      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/uCom")),   5) ;
2615:                                 IN cursor_4c_Itens
2616:                         REPLACE cfop      WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/CFOP")),   4) ;
2617:                                 IN cursor_4c_Itens
2618:                         REPLACE ncm       WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/NCM")),    8) ;
2619:                                 IN cursor_4c_Itens
2620:                         IF loc_oNode.SelectNodes("prod/vDesc").Length > 0
2621:                             REPLACE desconto WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vDesc")), 15) ;
2622:                                     IN cursor_4c_Itens
2623:                         ENDIF
2624:                         IF loc_oNode.SelectNodes("prod/vFrete").Length > 0
2625:                             REPLACE frete WITH LEFT(ALLTRIM(THIS.ObterNodeValue(loc_oNode, "prod/vFrete")), 15) ;
2626:                                     IN cursor_4c_Itens
2627:                         ENDIF
2628:                         SELECT cursor_4c_Itens
2629:                     ENDFOR
2630: 
2631:                     WAIT CLEAR
2632:                     GO TOP IN cursor_4c_Itens
2633:                     loc_lResultado = .T.
2634:                     ENDIF
2635:                 ENDIF
2636:             ENDIF
2637: 
2638:         CATCH TO loc_oErro
2639:             WAIT CLEAR
2640:             MsgErro("Erro em FormSigPrCtr.ProcessarArquivoXML:" + CHR(13) + ;
2641:                     loc_oErro.Message, "Erro")
2642:         ENDTRY
2643: 

*-- Linhas 2655 a 2745:
2655:             USE IN cursor_4c_Distribui
2656:         ENDIF
2657:         SET NULL ON
2658:         CREATE CURSOR cursor_4c_Distribui ;
2659:             ( Cpros C(14), Dpros C(30), Qtds N(12,2), Units N(12,4), Total N(14,2) )
2660:         SET NULL OFF
2661: 
2662:         IF !USED("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
2663:             RETURN
2664:         ENDIF
2665: 
2666:         TRY
2667:             SELECT cursor_4c_Itens
2668:             GO TOP
2669: 
2670:             SCAN
2671:                 loc_cCodigo = ALLTRIM(cursor_4c_Itens.codigo)
2672:                 loc_nQtd    = VAL(ALLTRIM(cursor_4c_Itens.quant))
2673:                 loc_nVal    = VAL(ALLTRIM(cursor_4c_Itens.valor_uni))
2674:                 loc_nTot    = VAL(ALLTRIM(cursor_4c_Itens.valor_tot))
2675: 
2676:                 IF !EMPTY(loc_cCodigo)
2677:                     IF USED("cursor_4c_ProdImport")
2678:                         USE IN cursor_4c_ProdImport
2679:                     ENDIF
2680: 
2681:                     loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2682:                                " WHERE Reffs = " + EscaparSQL(loc_cCodigo)
2683:                     loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2684: 
2685:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2686:                        RECCOUNT("cursor_4c_ProdImport") = 0
2687:                         IF USED("cursor_4c_ProdImport")
2688:                             USE IN cursor_4c_ProdImport
2689:                         ENDIF
2690:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2691:                                    " WHERE Cpros = " + EscaparSQL(loc_cCodigo)
2692:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2693:                     ENDIF
2694: 
2695:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2696:                        RECCOUNT("cursor_4c_ProdImport") = 0
2697:                         IF USED("cursor_4c_ProdImport")
2698:                             USE IN cursor_4c_ProdImport
2699:                         ENDIF
2700:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2701:                                    " WHERE Dpros = " + EscaparSQL(loc_cCodigo)
2702:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2703:                     ENDIF
2704: 
2705:                     IF loc_nResult < 0 OR !USED("cursor_4c_ProdImport") OR ;
2706:                        RECCOUNT("cursor_4c_ProdImport") = 0
2707:                         IF USED("cursor_4c_ProdImport")
2708:                             USE IN cursor_4c_ProdImport
2709:                         ENDIF
2710:                         loc_cSQL = "SELECT TOP 1 Cpros, Dpros FROM SigCdPro" + ;
2711:                                    " WHERE DPro2s = " + EscaparSQL(loc_cCodigo)
2712:                         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdImport")
2713:                     ENDIF
2714: 
2715:                     IF USED("cursor_4c_ProdImport") AND RECCOUNT("cursor_4c_ProdImport") > 0
2716:                         SELECT cursor_4c_Distribui
2717:                         APPEND BLANK
2718:                         REPLACE Cpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Cpros), 14), ;
2719:                                 Dpros WITH LEFT(ALLTRIM(cursor_4c_ProdImport.Dpros), 30), ;
2720:                                 Qtds  WITH loc_nQtd, ;
2721:                                 Units WITH loc_nVal, ;
2722:                                 Total WITH loc_nTot
2723:                     ENDIF
2724: 
2725:                     IF USED("cursor_4c_ProdImport")
2726:                         USE IN cursor_4c_ProdImport
2727:                     ENDIF
2728:                 ENDIF
2729: 
2730:                 SELECT cursor_4c_Itens
2731:             ENDSCAN
2732: 
2733:             IF USED("cursor_4c_Distribui")
2734:                 GO TOP IN cursor_4c_Distribui
2735:             ENDIF
2736: 
2737:         CATCH TO loc_oErro
2738:             MsgErro("Erro em FormSigPrCtr.CarregarItensXML:" + CHR(13) + ;
2739:                     loc_oErro.Message, "Erro")
2740:         ENDTRY
2741:     ENDPROC
2742: 
2743:     *--------------------------------------------------------------------------
2744:     *   Chama BO e vincula grd_4c_Estoque com dados de movimentacao
2745:     *--------------------------------------------------------------------------

*-- Linhas 2751 a 2799:
2751:             IF THIS.this_oBusinessObject.BuscarMovimentosPendentes(par_cConta, par_lFiltrar)
2752:                 loc_oPg2P1 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2753:                 IF PEMSTATUS(loc_oPg2P1, "grd_4c_Estoque", 5)
2754:                     loc_oGrid = loc_oPg2P1.grd_4c_Estoque
2755:                     loc_oGrid.ColumnCount = 5
2756:                     loc_oGrid.RecordSource = "cursor_4c_Pendentes"
2757:                     WITH loc_oGrid
2758:                         .Column1.ControlSource = "cursor_4c_Pendentes.Emps"
2759:                         .Column2.ControlSource = "cursor_4c_Pendentes.Dopes"
2760:                         .Column3.ControlSource = "cursor_4c_Pendentes.Numes"
2761:                         .Column4.ControlSource = "cursor_4c_Pendentes.Grupos"
2762:                         .Column5.ControlSource = "cursor_4c_Pendentes.Contas"
2763:                     ENDWITH
2764:                 ENDIF
2765:                 loc_lResultado = .T.
2766:             ENDIF
2767:         CATCH TO loc_oErro
2768:             MsgErro("Erro em FormSigPrCtr.CarregarMovimentosPendentes:" + CHR(13) + ;
2769:                     loc_oErro.Message, "Erro")
2770:         ENDTRY
2771: 
2772:         RETURN loc_lResultado
2773:     ENDPROC
2774: 
2775:     *--------------------------------------------------------------------------
2776:     * ObterNodeValue - Retorna o texto de um no XML filho de par_oParent
2777:     *--------------------------------------------------------------------------
2778:     PROTECTED FUNCTION ObterNodeValue(par_oParent, par_cXPath)
2779:         LOCAL loc_oNode, loc_cResult, loc_oErro
2780:         loc_cResult = ""
2781: 
2782:         TRY
2783:             IF VARTYPE(par_oParent) = "O" AND !ISNULL(par_oParent)
2784:                 loc_oNode = par_oParent.SelectSingleNode(par_cXPath)
2785:                 IF VARTYPE(loc_oNode) = "O" AND !ISNULL(loc_oNode)
2786:                     loc_cResult = NVL(loc_oNode.Text, "")
2787:                 ENDIF
2788:             ENDIF
2789:         CATCH TO loc_oErro
2790:             MsgErro("Erro ao ler n" + CHR(243) + "XML '" + par_cXPath + ;
2791:                     "': " + loc_oErro.Message, "Erro XML")
2792:             loc_cResult = ""
2793:         ENDTRY
2794: 
2795:         RETURN loc_cResult
2796:     ENDFUNC
2797: 
2798:     *--------------------------------------------------------------------------
2799:     * ConfigurarPaginaDadosDetalhe - Controles do pgf_4c_Dados.Page2 (Detalhe)

*-- Linhas 2927 a 3023:
2927:                 .FontBold = .T.
2928:                 .FontUnderline = .T.
2929:                 .Header1.Caption = "C" + CHR(243) + "digo"
2930:                 .Header1.Alignment = 2
2931:                 .Header1.ForeColor = RGB(90, 90, 90)
2932:                 .ControlSource = "cursor_4c_Movimentos.Cpros"
2933:             ENDWITH
2934: 
2935:             WITH .Column2
2936:                 .Width = 235
2937:                 .Movable = .F.
2938:                 .Resizable = .F.
2939:                 .ReadOnly = .T.
2940:                 .BackColor = RGB(237, 242, 243)
2941:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2942:                 .Header1.Alignment = 2
2943:                 .Header1.ForeColor = RGB(90, 90, 90)
2944:                 .ControlSource = "cursor_4c_Movimentos.Dpros"
2945:             ENDWITH
2946: 
2947:             WITH .Column3
2948:                 .Width = 70
2949:                 .Movable = .F.
2950:                 .Resizable = .F.
2951:                 .ReadOnly = .T.
2952:                 .BackColor = RGB(237, 242, 243)
2953:                 .Header1.Caption = "Valor"
2954:                 .Header1.Alignment = 2
2955:                 .Header1.ForeColor = RGB(90, 90, 90)
2956:                 .ControlSource = "cursor_4c_Movimentos.Units"
2957:             ENDWITH
2958: 
2959:             WITH .Column4
2960:                 .Width = 63
2961:                 .Movable = .F.
2962:                 .Resizable = .F.
2963:                 .ReadOnly = .T.
2964:                 .BackColor = RGB(237, 242, 243)
2965:                 .FontBold = .T.
2966:                 .Header1.Caption = "Quantidade"
2967:                 .Header1.Alignment = 2
2968:                 .Header1.ForeColor = RGB(90, 90, 90)
2969:                 .ControlSource = "cursor_4c_Movimentos.Qtds"
2970:             ENDWITH
2971: 
2972:             WITH .Column5
2973:                 .Width = 63
2974:                 .Movable = .F.
2975:                 .Resizable = .F.
2976:                 .ReadOnly = .T.
2977:                 .BackColor = RGB(237, 242, 243)
2978:                 .FontBold = .T.
2979:                 .Header1.Caption = "Baixado"
2980:                 .Header1.Alignment = 2
2981:                 .Header1.ForeColor = RGB(90, 90, 90)
2982:                 .ControlSource = "cursor_4c_Movimentos.QtBaixas"
2983:             ENDWITH
2984: 
2985:             WITH .Column6
2986:                 .Width = 63
2987:                 .Movable = .F.
2988:                 .Resizable = .F.
2989:                 .ReadOnly = .T.
2990:                 .BackColor = RGB(237, 242, 243)
2991:                 .FontBold = .T.
2992:                 .Header1.Caption = "Reservado"
2993:                 .Header1.Alignment = 2
2994:                 .Header1.ForeColor = RGB(90, 90, 90)
2995:                 .ControlSource = "cursor_4c_Movimentos.QtReservas"
2996:             ENDWITH
2997: 
2998:             WITH .Column7
2999:                 .Width = 63
3000:                 .Movable = .F.
3001:                 .Resizable = .F.
3002:                 .ReadOnly = .T.
3003:                 .BackColor = RGB(237, 242, 243)
3004:                 .FontBold = .T.
3005:                 .Header1.Caption = "Saldo"
3006:                 .Header1.Alignment = 2
3007:                 .Header1.ForeColor = RGB(90, 90, 90)
3008:                 .ControlSource = "cursor_4c_Movimentos.Saldo"
3009:             ENDWITH
3010:         ENDWITH
3011:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
3012:         BINDEVENT(loc_oPg2P2.grd_4c_Disponivel, "DblClick", THIS, "GrdDisponivelDblClick")
3013: 
3014:         *-- Grid XML / grd_4c_ItemXml (4 colunas, top=134+29=163)
3015:         loc_oPg2P2.AddObject("grd_4c_ItemXml", "Grid")
3016:         loc_oPg2P2.grd_4c_ItemXml.ColumnCount = 4
3017:         loc_oPg2P2.grd_4c_ItemXml.Top         = 163
3018:         loc_oPg2P2.grd_4c_ItemXml.Left        = 693
3019:         loc_oPg2P2.grd_4c_ItemXml.Width       = 493
3020:         loc_oPg2P2.grd_4c_ItemXml.Height      = 344
3021:         WITH loc_oPg2P2.grd_4c_ItemXml
3022:             .FontName  = "Tahoma"
3023:             .FontSize = 8

*-- Linhas 3041 a 3100:
3041:                 .Header1.Caption = "C" + CHR(243) + "digo"
3042:                 .Header1.Alignment = 2
3043:                 .Header1.ForeColor = RGB(90, 90, 90)
3044:                 .ControlSource = "cursor_4c_Distribui.Cpros"
3045:             ENDWITH
3046: 
3047:             WITH .Column2
3048:                 .Width = 235
3049:                 .Movable = .F.
3050:                 .Resizable = .F.
3051:                 .ReadOnly = .T.
3052:                 .Enabled = .F.
3053:                 .ForeColor = RGB(0, 0, 0)
3054:                 .BackColor = RGB(237, 242, 243)
3055:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
3056:                 .Header1.Alignment = 2
3057:                 .Header1.ForeColor = RGB(90, 90, 90)
3058:                 .ControlSource = "cursor_4c_Distribui.Dpros"
3059:             ENDWITH
3060: 
3061:             WITH .Column3
3062:                 .Width = 63
3063:                 .Movable = .F.
3064:                 .Resizable = .F.
3065:                 .InputMask = "999999"
3066:                 .ForeColor = RGB(0, 0, 0)
3067:                 .BackColor = RGB(237, 242, 243)
3068:                 .Header1.Caption = "Quantidade"
3069:                 .Header1.Alignment = 2
3070:                 .Header1.ForeColor = RGB(90, 90, 90)
3071:                 .ControlSource = "cursor_4c_Distribui.Qtds"
3072:             ENDWITH
3073: 
3074:             WITH .Column4
3075:                 .Width = 70
3076:                 .Movable = .F.
3077:                 .Resizable = .F.
3078:                 .ReadOnly = .T.
3079:                 .Enabled = .F.
3080:                 .ForeColor = RGB(0, 0, 0)
3081:                 .BackColor = RGB(237, 242, 243)
3082:                 .Header1.Caption = "Valor"
3083:                 .Header1.Alignment = 2
3084:                 .Header1.ForeColor = RGB(90, 90, 90)
3085:                 .ControlSource = "cursor_4c_Distribui.Total"
3086:             ENDWITH
3087:         ENDWITH
3088: 
3089:         *-- Botao excluir Grade Sistema / cmd_4c_BtnExcluirSis (top=479+29=508)
3090:         loc_oPg2P2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
3091:         WITH loc_oPg2P2.cmd_4c_BtnExcluirSis
3092:             .Caption = ""
3093:             .Themes = .F.
3094:             .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
3095:             .Top = 508
3096:             .Left = 663
3097:             .Width = 40
3098:             .Height = 37
3099:             .ForeColor = RGB(255, 0, 0)
3100:             .BackColor = RGB(255, 255, 255)

*-- Linhas 3448 a 3541:
3448:         LOCAL loc_cMoeDetqs, loc_cMoeVenda, loc_nCotAlvo, loc_nCotVenda, loc_nValVenda
3449:         LOCAL loc_lAbortou, loc_oErro
3450:         loc_lAbortou = .F.
3451: 
3452:         TRY
3453:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3454:                 loc_lAbortou = .T.
3455:             ENDIF
3456: 
3457:             IF !loc_lAbortou
3458:                 loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3459:                 loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3460:                 IF EMPTY(loc_cCpros)
3461:                     loc_lAbortou = .T.
3462:                 ENDIF
3463:             ENDIF
3464: 
3465:             IF !loc_lAbortou
3466:                 loc_cSQL = "SELECT a.cpros, a.reffs, a.pesoms, a.moecusfs, a.custofs," + ;
3467:                            " a.pcuss, a.pvens, a.moevs, a.FigJpgs" + ;
3468:                            " FROM SigCdPro a WHERE a.cpros = " + EscaparSQL(loc_cCpros)
3469:                 IF USED("cursor_4c_TmpPro")
3470:                     USE IN cursor_4c_TmpPro
3471:                 ENDIF
3472:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3473:                 IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3474:                     loc_lAbortou = .T.
3475:                 ENDIF
3476:             ENDIF
3477: 
3478:             IF !loc_lAbortou
3479:                 SELECT cursor_4c_TmpPro
3480:                 GO TOP
3481: 
3482:                 *-- Campos detalhe produto
3483:                 loc_oPg2P2.txt_4c__ref_fornecedor.Value = ALLTRIM(NVL(cursor_4c_TmpPro.reffs, ""))
3484:                 loc_oPg2P2.txt_4c__peso_medio.Value     = NVL(cursor_4c_TmpPro.pesoms, 0)
3485:                 loc_oPg2P2.txt_4c__moecusfs.Value       = ALLTRIM(NVL(cursor_4c_TmpPro.moecusfs, ""))
3486:                 loc_oPg2P2.txt_4c__custofs.Value        = NVL(cursor_4c_TmpPro.custofs, 0)
3487:                 loc_oPg2P2.txt_4c__precoMov.Value       = NVL(cursor_4c_TmpPro.pcuss, 0)
3488:                 loc_oPg2P2.txt_4c_CIdChaves.Value       = ALLTRIM(NVL(cursor_4c_Movimentos.CidChaves, ""))
3489:                 loc_oPg2P2.txt_4c_Emps.Value            = SUBSTR(cursor_4c_Movimentos.OriDopNums, 1, 3)
3490:                 loc_oPg2P2.txt_4c_Dopes.Value           = SUBSTR(cursor_4c_Movimentos.OriDopNums, 4, 20)
3491:                 loc_oPg2P2.txt_4c_Numes.Value           = ALLTRIM(RIGHT(cursor_4c_Movimentos.OriDopNums, 6))
3492: 
3493:                 *-- Preco de venda: converte para moeda padrao se configurada
3494:                 loc_cMoeDetqs = ""
3495:                 IF USED("cursor_4c_TmpPam")
3496:                     USE IN cursor_4c_TmpPam
3497:                 ENDIF
3498:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 moedetqs FROM SigCdPam", "cursor_4c_TmpPam") > 0 ;
3499:                    AND USED("cursor_4c_TmpPam") AND RECCOUNT("cursor_4c_TmpPam") > 0
3500:                     loc_cMoeDetqs = ALLTRIM(NVL(cursor_4c_TmpPam.moedetqs, ""))
3501:                     USE IN cursor_4c_TmpPam
3502:                 ENDIF
3503: 
3504:                 IF EMPTY(loc_cMoeDetqs)
3505:                     loc_oPg2P2.txt_4c__pr_venda.Value       = NVL(cursor_4c_TmpPro.pvens, 0)
3506:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3507:                 ELSE
3508:                     loc_nCotAlvo  = 1
3509:                     loc_nCotVenda = 1
3510:                     IF USED("cursor_4c_TmpCot")
3511:                         USE IN cursor_4c_TmpCot
3512:                     ENDIF
3513:                     IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3514:                                EscaparSQL(loc_cMoeDetqs) + " ORDER BY datas DESC", ;
3515:                                "cursor_4c_TmpCot") > 0 ;
3516:                        AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3517:                         loc_nCotAlvo = NVL(cursor_4c_TmpCot.valos, 1)
3518:                         USE IN cursor_4c_TmpCot
3519:                     ENDIF
3520:                     loc_cMoeVenda = ALLTRIM(NVL(cursor_4c_TmpPro.moevs, ""))
3521:                     IF !EMPTY(loc_cMoeVenda)
3522:                         IF USED("cursor_4c_TmpCot")
3523:                             USE IN cursor_4c_TmpCot
3524:                         ENDIF
3525:                         IF SQLEXEC(gnConnHandle, "SELECT TOP 1 valos FROM SigCdCot WHERE cmoes = " + ;
3526:                                    EscaparSQL(loc_cMoeVenda) + " ORDER BY datas DESC", ;
3527:                                    "cursor_4c_TmpCot") > 0 ;
3528:                            AND USED("cursor_4c_TmpCot") AND RECCOUNT("cursor_4c_TmpCot") > 0
3529:                             loc_nCotVenda = NVL(cursor_4c_TmpCot.valos, 1)
3530:                             USE IN cursor_4c_TmpCot
3531:                         ENDIF
3532:                     ENDIF
3533:                     loc_nValVenda = ROUND(NVL(cursor_4c_TmpPro.pvens, 0) * loc_nCotVenda / ;
3534:                                          IIF(loc_nCotAlvo = 0, 1, loc_nCotAlvo), 2)
3535:                     loc_oPg2P2.txt_4c__pr_venda.Value       = loc_nValVenda
3536:                     loc_oPg2P2.txt_4c__pr_venda_moeda.Value = loc_cMoeDetqs
3537:                 ENDIF
3538: 
3539:                 *-- FigJpg: imagem do produto (base64 em SigCdPro.FigJpgs)
3540:                 loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3541:                 loc_lTemFig  = !EMPTY(loc_cFigJpgs) AND !ISNULL(cursor_4c_TmpPro.FigJpgs)

*-- Linhas 3563 a 3696:
3563:                     loc_oErro.Message, "Erro")
3564:         ENDTRY
3565:     ENDPROC
3566: 
3567:     *--------------------------------------------------------------------------
3568:     * BtnExcluirSisClick - Delete linha corrente de cursor_4c_Movimentos
3569:     *--------------------------------------------------------------------------
3570:     PROCEDURE BtnExcluirSisClick()
3571:         LOCAL loc_oPg2P2, loc_oErro
3572:         TRY
3573:             IF USED("cursor_4c_Movimentos") AND !EOF("cursor_4c_Movimentos")
3574:                 SELECT cursor_4c_Movimentos
3575:                 DELETE
3576:                 IF !EOF("cursor_4c_Movimentos")
3577:                     SKIP
3578:                     SKIP -1
3579:                 ENDIF
3580:                 GO TOP IN cursor_4c_Movimentos
3581:             ENDIF
3582:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3583:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3584:                 loc_oPg2P2.grd_4c_Disponivel.SetFocus()
3585:                 loc_oPg2P2.grd_4c_Disponivel.Refresh()
3586:             ENDIF
3587:         CATCH TO loc_oErro
3588:             MsgErro("Erro em FormSigPrCtr.BtnExcluirSisClick:" + CHR(13) + loc_oErro.Message, "Erro")
3589:         ENDTRY
3590:     ENDPROC
3591: 
3592:     *--------------------------------------------------------------------------
3593:     * BtnExcluirArqClick - Delete linha corrente de cursor_4c_Distribui
3594:     *--------------------------------------------------------------------------
3595:     PROCEDURE BtnExcluirArqClick()
3596:         LOCAL loc_oPg2P2, loc_oErro
3597:         TRY
3598:             IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
3599:                 SELECT cursor_4c_Distribui
3600:                 DELETE
3601:                 IF !EOF("cursor_4c_Distribui")
3602:                     SKIP
3603:                     SKIP -1
3604:                 ENDIF
3605:                 GO TOP IN cursor_4c_Distribui
3606:             ENDIF
3607:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3608:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_ItemXml", 5)
3609:                 loc_oPg2P2.grd_4c_ItemXml.SetFocus()
3610:                 loc_oPg2P2.grd_4c_ItemXml.Refresh()
3611:             ENDIF
3612:         CATCH TO loc_oErro
3613:             MsgErro("Erro em FormSigPrCtr.BtnExcluirArqClick:" + CHR(13) + loc_oErro.Message, "Erro")
3614:         ENDTRY
3615:     ENDPROC
3616: 
3617:     *--------------------------------------------------------------------------
3618:     * TxtProdutoInicialLostFocus - Localiza produto em cursor_4c_Movimentos
3619:     *--------------------------------------------------------------------------
3620:     PROCEDURE TxtProdutoInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3621:         LOCAL loc_oPg2P2, loc_cValor, loc_nRecno, loc_oErro
3622:         TRY
3623:             loc_oPg2P2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
3624:             IF PEMSTATUS(loc_oPg2P2, "txt_4c__produto_inicial", 5)
3625:                 loc_cValor = ALLTRIM(loc_oPg2P2.txt_4c__produto_inicial.Value)
3626:                 IF !EMPTY(loc_cValor) AND USED("cursor_4c_Movimentos")
3627:                     SELECT cursor_4c_Movimentos
3628:                     loc_nRecno = RECNO()
3629:                     GO TOP
3630:                     LOCATE FOR ALLTRIM(cursor_4c_Movimentos.Cpros) = loc_cValor
3631:                     IF EOF()
3632:                         GO loc_nRecno
3633:                     ENDIF
3634:                 ENDIF
3635:             ENDIF
3636:         CATCH TO loc_oErro
3637:             MsgErro("Erro em FormSigPrCtr.TxtProdutoInicialLostFocus:" + CHR(13) + ;
3638:                     loc_oErro.Message, "Erro")
3639:         ENDTRY
3640:     ENDPROC
3641: 
3642:     *--------------------------------------------------------------------------
3643:     * ImgFigJpgDblClick - Abre zoom da foto do produto (SigOpZom)
3644:     *--------------------------------------------------------------------------
3645:     PROCEDURE ImgFigJpgDblClick()
3646:         LOCAL loc_oPg2P2, loc_cCpros, loc_cSQL, loc_nResult
3647:         LOCAL loc_cFigJpgs, loc_cArqTemp, loc_cFoto, loc_cCaption, loc_oErro
3648:         TRY
3649:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3650:                 RETURN
3651:             ENDIF
3652:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3653:             IF EMPTY(loc_cCpros)
3654:                 RETURN
3655:             ENDIF
3656:             loc_cSQL = "SELECT a.cpros, a.FigJpgs FROM SigCdPro a WHERE a.cpros = " + ;
3657:                        EscaparSQL(loc_cCpros)
3658:             IF USED("cursor_4c_TmpPro")
3659:                 USE IN cursor_4c_TmpPro
3660:             ENDIF
3661:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro")
3662:             IF loc_nResult < 0 OR !USED("cursor_4c_TmpPro") OR RECCOUNT("cursor_4c_TmpPro") = 0
3663:                 RETURN
3664:             ENDIF
3665:             SELECT cursor_4c_TmpPro
3666:             GO TOP
3667:             loc_cFigJpgs = NVL(cursor_4c_TmpPro.FigJpgs, "")
3668:             IF USED("cursor_4c_TmpPro")
3669:                 USE IN cursor_4c_TmpPro
3670:             ENDIF
3671:             IF !EMPTY(loc_cFigJpgs) AND !ISNULL(loc_cFigJpgs)
3672:                 loc_cArqTemp = SYS(2023) + "\" + SYS(2015) + ".jpg"
3673:                 loc_cFoto = STRCONV(;
3674:                     STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
3675:                         "data:image/png;base64,", ""), ;
3676:                         "data:image/jpeg;base64,", ""), ;
3677:                         "data:image/jpg;base64,", ""), 14)
3678:                 STRTOFILE(loc_cFoto, loc_cArqTemp)
3679:                 IF FILE(loc_cArqTemp)
3680:                     loc_cCaption = "Produto : " + loc_cCpros + " - " + ;
3681:                                    ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, ""))
3682:                     IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") OR ;
3683:                        FILE(gc_4c_CaminhoForms + "FormSigOpZom.prg")
3684:                         DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpZom.prg") ;
3685:                             WITH loc_cArqTemp, loc_cCaption, " "
3686:                     ELSE
3687:                         DECLARE INTEGER ShellExecute IN shell32.dll ;
3688:                             INTEGER hWnd, STRING lpOperation, STRING lpFile, ;
3689:                             STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
3690:                         ShellExecute(0, "open", loc_cArqTemp, "", "", 1)
3691:                     ENDIF
3692:                 ENDIF
3693:             ENDIF
3694:         CATCH TO loc_oErro
3695:             MsgErro("Erro em FormSigPrCtr.ImgFigJpgDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3696:         ENDTRY

*-- Linhas 3706 a 3777:
3706:             IF PEMSTATUS(loc_oPg2P2, "grd_4c_Disponivel", 5)
3707:                 IF loc_oPg2P2.grd_4c_Disponivel.ActiveColumn # 1
3708:                     RETURN
3709:                 ENDIF
3710:             ENDIF
3711:             IF !USED("cursor_4c_Movimentos") OR RECCOUNT("cursor_4c_Movimentos") = 0
3712:                 RETURN
3713:             ENDIF
3714:             loc_cCpros = ALLTRIM(NVL(cursor_4c_Movimentos.Cpros, ""))
3715:             IF EMPTY(loc_cCpros)
3716:                 RETURN
3717:             ENDIF
3718:             IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg") OR ;
3719:                FILE(gc_4c_CaminhoForms + "FormSigOpCgp.prg")
3720:                 DO FORM (gc_4c_CaminhoForms + "operacionais\FormSigOpCgp.prg")
3721:             ELSE
3722:                 MsgInfo("Produto: " + loc_cCpros + CHR(13) + ;
3723:                         ALLTRIM(NVL(cursor_4c_Movimentos.Dpros, "")), "Produto")
3724:             ENDIF
3725:         CATCH TO loc_oErro
3726:             MsgErro("Erro em FormSigPrCtr.GrdDisponivelDblClick:" + CHR(13) + loc_oErro.Message, "Erro")
3727:         ENDTRY
3728:     ENDPROC
3729: 
3730:     *--------------------------------------------------------------------------
3731:     * Destroy - Libera BO e fecha cursores
3732:     *--------------------------------------------------------------------------
3733:     PROCEDURE Destroy()
3734:         LOCAL loc_oErro
3735: 
3736:         TRY
3737:             IF USED("cursor_4c_Dados")
3738:                 USE IN cursor_4c_Dados
3739:             ENDIF
3740: 
3741:             IF USED("cursor_4c_Movimentos")
3742:                 USE IN cursor_4c_Movimentos
3743:             ENDIF
3744: 
3745:             IF USED("cursor_4c_Pendentes")
3746:                 USE IN cursor_4c_Pendentes
3747:             ENDIF
3748: 
3749:             IF USED("cursor_4c_Linhas")
3750:                 USE IN cursor_4c_Linhas
3751:             ENDIF
3752: 
3753:             IF USED("cursor_4c_Itens")
3754:                 USE IN cursor_4c_Itens
3755:             ENDIF
3756: 
3757:             IF USED("cursor_4c_Distribui")
3758:                 USE IN cursor_4c_Distribui
3759:             ENDIF
3760: 
3761:             IF USED("cursor_4c_TmpJoin")
3762:                 USE IN cursor_4c_TmpJoin
3763:             ENDIF
3764: 
3765:             IF USED("cursor_4c_MovTmp")
3766:                 USE IN cursor_4c_MovTmp
3767:             ENDIF
3768: 
3769:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3770:                 THIS.this_oBusinessObject = .NULL.
3771:             ENDIF
3772:         CATCH TO loc_oErro
3773:             MsgErro("Erro em FormSigPrCtr.Destroy:" + CHR(13) + loc_oErro.Message, "Erro")
3774:         ENDTRY
3775: 
3776:         DODEFAULT()
3777:     ENDPROC


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

