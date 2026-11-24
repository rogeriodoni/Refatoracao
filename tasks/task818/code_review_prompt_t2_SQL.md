# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (4)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'IMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, EMPS, I, EMPDOPNUMS, INFOS, LNADI, 0, FILTRO, ORDEM, DOPES, CITENS, CODTAMS, COLECOES, SGRUS, CODIGOS, MERCS, NUMERO, DOPPS, DATAALTS, FPAGS, RCL, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TIPOOPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, EMPS, I, EMPDOPNUMS, INFOS, LNADI, 0, FILTRO, ORDEM, DOPES, CITENS, CODTAMS, COLECOES, SGRUS, CODIGOS, MERCS, NUMERO, DOPPS, DATAALTS, FPAGS, RCL, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'WIDTH' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, EMPS, I, EMPDOPNUMS, INFOS, LNADI, 0, FILTRO, ORDEM, DOPES, CITENS, CODTAMS, COLECOES, SGRUS, CODIGOS, MERCS, NUMERO, DOPPS, DATAALTS, FPAGS, RCL, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, EMPS, I, EMPDOPNUMS, INFOS, LNADI, 0, FILTRO, ORDEM, DOPES, CITENS, CODTAMS, COLECOES, SGRUS, CODIGOS, MERCS, NUMERO, DOPPS, DATAALTS, FPAGS, RCL, DATAS

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
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
  ControlSource = ""
  ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  Column8.ControlSource = ""
  Column9.ControlSource = ""
  Column10.ControlSource = ""
  Column11.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  Column3.ControlSource = ""
Select crCursor1
	oProg2.Update(.t.)
	lcQuery = [Select Top 1 ] + ;
				[From SigCdPrc p ] + ;
	Select crAntigo1
		lcQuery = [Select Top 1 ] + ;
					[From SigPrTa2 t ] + ;
		Select crAntigo1
Select crGrdGpr
Select Codigos ;
  From crGrdGpr ;
Select crNaoMarcados
	Delete From crCursor1 Where Gde_Grupo = crNaoMarcados.Codigos
Select crGrdGru
Select Codigos ;
  From crGrdGru ;
Select crNaoMarcados
	Delete From crCursor1 Where Grupo = crNaoMarcados.Codigos
	Select crPgRes01
				Select crPgRes01
				Select crPgRes02
				Select crPgRes03
			Select Empresa, Numero, Data_Venda, Codigo_Vendedora, Barras, ;
			  From crPgRes01 ;
			Select Empresa, Movimentacao, Valor_Diferenca, Perc_Diferenca, ;
			  From crPgRes02 ;
			Select Empresa, Codigo_Vendedora, Valor_Diferenca, Perc_Diferenca, ;
			  From crPgRes03 ;
	Select crExcel
	lcQuery = [Select e.CEmps as Emps ] + ;
				[From SigCdEmp e ] + ;
			   		 [Select a.Emps From SigCdAce a Where a.Usuarios = '] + Usuar + [')]
	Select LocalEmps
		Delete From &pCur. Where Empresa = LocalEmps.Emps
Select crSigCdEmp 
Select Cemps ;
  From crSigCdEmp ;
		Select LocalEmps
	.Column1.ControlSource = [crTpOpe.nMarcas]
	.Column2.ControlSource = [crTpOpe.cDescricaos]
	.Column1.ControlSource = [CrOpera.nMarcas]
	.Column2.ControlSource = [CrOpera.Dopes]
	.Column1.ControlSource = [crGrdGpr.nMarcas]
	.Column2.ControlSource = [crGrdGpr.cDescricaos]
	.Column1.ControlSource = [crGrdGru.nMarcas]
	.Column2.ControlSource = [crGrdGru.Mercs]
	.Column3.ControlSource = [crGrdGru.cDescricaos]
	.Column1.ControlSource   = [crPgRes01.Empresa]
	.Column3.ControlSource   = [crPgRes01.Numero]
	.Column4.ControlSource   = [Iif(Empty(crPgRes01.Data_Venda), Space(10), Dtoc(crPgRes01.Data_Venda))]
	.Column5.ControlSource   = [crPgRes01.Codigo_Vendedora]
	.Column6.ControlSource   = [crPgRes01.Barras]
	.Column7.ControlSource   = [crPgRes01.Codigo_Item]
	.Column8.ControlSource   = [crPgRes01.Desc_Item]
	.Column9.ControlSource   = [crPgRes01.Cor]
	.Column10.ControlSource  = [crPgRes01.Tamanho]
	.Column17.ControlSource  = [crPgRes01.Custo_Cadastro]
	.Column14.ControlSource  = [crPgRes01.Val_Unitario]
	.Column29.ControlSource  = [crPgRes01.Markup]
	.Column11.ControlSource  = [crPgRes01.Valor_Diferenca]
	.Column12.ControlSource  = [Alltrim(crPgRes01.Pct_Dif_Chr)]
	.Column13.ControlSource  = [crPgRes01.Venda_Cadastro]
	.Column16.ControlSource  = [crPgRes01.Total]
	.Column30.ControlSource  = [crPgRes01.Total_Geral]
	.Column27.ControlSource  = [crPgRes01.Parcelas]
	.Column28.ControlSource  = [crPgRes01.Cond_Pagto]
	.Column25.ControlSource  = [crPgRes01.Cod_Cliente]
	.Column26.ControlSource  = [crPgRes01.Nome_Cliente]
	.Column18.ControlSource  = [crPgRes01.Cod_Fornecedor]
	.Column19.ControlSource  = [crPgRes01.Nome_Fornecedor]
	.Column23.ControlSource  = [crPgRes01.SubGrupo]
	.Column20.ControlSource  = [crPgRes01.Ref_Fornecedor]
	.Column21.ControlSource  = [crPgRes01.Gde_Grupo]
	.Column22.ControlSource  = [crPgRes01.Grupo]
	.Column15.ControlSource  = [crPgRes01.Quantidade]
	.Column2.ControlSource   = [crPgRes01.Movimentacao]
	.Column24.ControlSource  = [crPgRes01.Operacao]
	.Column31.ControlSource  = [crPgRes01.local_itn]
	.Column32.ControlSource   = [crPgRes01.Equivalente]
	.Column33.ControlSource   = [crPgRes01.Categoria]
	.Column34.ControlSource   = [crPgRes01.Nome_Vendedora]
	.Column35.ControlSource   = [crPgRes01.Desc_Categoria]
	.Column1.ControlSource  = [crPgRes02.Empresa]
	.Column2.ControlSource  = [crPgRes02.Movimentacao]
	.Column3.ControlSource  = [crPgRes02.Valor_Diferenca]
	.Column4.ControlSource  = [crPgRes02.Perc_Diferenca]
	.Column5.ControlSource  = [crPgRes02.Venda_Cadastro]
	.Column6.ControlSource  = [crPgRes02.Quantidade]
	.Column7.ControlSource  = [crPgRes02.Total]
	.Column8.ControlSource  = [crPgRes02.Custo_Cadastro]
	.Column9.ControlSource  = [crPgRes02.Tkt_Medio]
	.Column10.ControlSource = [crPgRes02.Markup]
	.DeleteMark        = .F.
	.Column1.ControlSource   = 'crSigCdEmp.Imps'
	.Column2.ControlSource   = 'crSigCdEmp.cEmps'
	.Column3.ControlSource   = 'crSigCdEmp.Razas'
	.Column1.ControlSource  = [crPgRes03.Empresa]
	.Column2.ControlSource  = [crPgRes03.Codigo_Vendedora]
	.Column3.ControlSource  = [crPgRes03.Valor_Diferenca]
	.Column4.ControlSource  = [crPgRes03.Perc_Diferenca]
	.Column5.ControlSource  = [crPgRes03.Venda_Cadastro]
	.Column6.ControlSource  = [crPgRes03.Quantidade]
	.Column7.ControlSource  = [crPgRes03.Total]
	.Column8.ControlSource  = [crPgRes03.Custo_Cadastro]
	.Column9.ControlSource  = [crPgRes03.Tkt_Medio]
	.Column10.ControlSource = [crPgRes03.Markup]
Select crPgRes01
Select crCursor1
	lcQuery = [Select p.EmpDopNums, p.FPags, p.TParcs, p.Datas, p.Vencs, f.Infos ] + ;
				[From SigMvPar p, SigOpFp f ] + ;
	Select * From LocalParcs Where Ttod(Datas) = Ttod(Vencs) Or Infos = 'T' Into Cursor LocalEnts
	Select Distinct FPags From LocalParcs Order By FPags Into Cursor LocalParcs1  
	Select LocalParcs1
	Select Max(TParcs) as TParcs From LocalParcs Into Cursor LocalParcs2
	Insert Into crPgRes01 From Memvar
Update crPgRes01 Set Total_Geral = 0
Select Empresa, Movimentacao, Numero, Sum(Total * Iif(Operacao = [E], -1, 1)) as Total ;
  From crPgRes01 ;
Select TmpTotGer
	Update crPgRes01 ;
Select * From crPgRes01 Where 0 = 1 Into Cursor TmpTotais1 Readwrite
	Select Empresa, ;
	  From crPgRes01 ;
	Select LocalTot01
		Insert Into TmpTotais1 (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
Select TmpTotais1
	Insert Into crPgRes01 (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
Select crPgRes01
Select crPgRes02
Select * ;
  From crPgRes01 ;
Select TmpRes01
	Select Distinct Empresa, Movimentacao, Numero ;
	  From crPgRes01 ;
	Insert Into crPgRes02 From Memvar
Select Chr(255) as Empresa, ;
  From crPgRes02 ;
Select LocalTot02
	Select Distinct Empresa, Movimentacao, Numero ;
	  From crPgRes01 ;
	Insert Into crPgRes02 (Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
Select crPgRes02
Select crPgRes03
Select Empresa, ;
  From crPgRes01 ;
Select Empresa, ;
  From crPgRes02 ;
Select LocalTot03
Select LocalTot03
		Select Distinct Empresa, Movimentacao, Numero ;
		  From crPgRes01 ;
	Insert Into crPgRes03 (Empresa, Codigo_Vendedora, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
Select crPgRes03
Select crPgRes01
Select crPgRes02
Select crPgRes03
Select crTpOpe
Select CCodigos ;
  From crTpOpe ;
Select LocalTpOpe
Select crOpera
Select Dopes From crOpera Where nMarcas = 1 ;
Select LocalOpera
oProg1.Update(.t.)
lcQuery = [Select c.Emps as Empresa, ] + ;
			[From SigMvCab c ] + ;
		    [Left Join SigCdOpe o On c.Dopes = o.Dopes ] + ;
			[Left Join SigMvItn i On c.EmpDopNums = i.EmpDopNums ] + ;
			[Left Join SigMvIts s On i.EmpDopNums = s.EmpDopNums And i.CItens = s.CItens and s.cpros = i.cpros ] + ;
			[Left Join SigMvItp b On i.EmpDopNums = b.EmpDopNums And i.CItens = b.CItens ] + ;
			[Left Join SigPrTam t On s.CPros = t.CPros And s.CodTams = t.CodTams ] + ;
			[Left Join SigCdPro p On i.CPros = p.CPros ] + ;
			[Left Join SigCdCtg g On g.Cods = p.Categoria ] + ;
			[Left Join SigCdCli c1 On c1.ICLis = c.ContaDs ] + ;
			[Left Join SigCdCli c2 On c2.ICLis = p.IFors ] + ;
			[Left Join SigCdPsg sg On sg.CGruCods = p.CGrus + p.SGrus ] + ;
			[Left Join SigCdCli c3 On c3.ICLis = c.Vends ] + ;
			[left join SigCdCol Co on p.colecoes = co.colecoes ] + ;
oProg1.Update(.t.)
oProg1.Update(.t.)
oProg1.Update(.t.)
oProg1.Update(.t.)
oProg1.Update(.t.)
oProg1.Update(.t.)
oProg1.Update(.t.)
		lcQuery = [Select Codigos, Descrs, GerGdmis From SigCdTom]
		Select 0 As nMarcas, ;
			From crSigCdTom a ;
		lcQuery = [Select Codigos, Descs From SigCdGpr]
		Select 1 As nMarcas, a.Codigos, ;
			From crSigCdGpr a ;
		lcQuery = [Select Mercs, CGrus as Codigos, DGrus as Descs From SigCdGrp]
		Select 1 As nMarcas, a.Mercs, a.Codigos, ;
			From crSigCdGrp a ;
		If ThisForm.poDataMgr.SqlExecute([Select 0 as nMarcas, * From SigCdOpe],'CrOpera') < 1
		Select CrOpera
		If Thisform.poDataMgr.SQLExecute([select Convert(bit,0) as Imps, cemps, razas from SigCdEmp Order by cEmps],'crSigCdEmp') < 1 Then
		Select crSigCdEmp
			lcQuery = [Select Convert(bit,0) as Imps, a.Emps as Cemps, b.razas From SigCdAce a join SigCdEmp b on a.emps = b.cemps Where a.Usuarios = ']+Usuar+[']
			If Thisform.poDataMgr.SQLExecute(lcQuery,'crAuxCdEmp') < 1 Then
			Select crAuxCdEmp
				Select crSigCdEmp
				Select crAuxCdEmp
					Select crSigCdEmp
					Select crAuxCdEmp
		Select crSigCdEmp
		lcQuery = [Select Distinct a.Grupo as GruEmps, b.Tipos ] + ;
			[From SigCdEmp a, SigCdGre b ] + ;
			[a.CEmps In (Select g.Emps From SigCdAce g Where g.Usuarios = '] + Usuar + [')]
		lcQuery = [Select CMoes, DMoes, nOrdRels ] + ;
			[From SigCdMoe ] + ;
Select * From crPgRes01 Into Cursor crPgRes02 ReadWrite
Select crPgRes02
Select * From crPgRes01 Into Cursor crPgRes03 ReadWrite
Select crPgRes03
Select CCodigos ;
  From crTpOpe ;
Select Codigos ;
  From crGrdGpr ;
UpDate crOpera Set nMarcas = 1 Where crTpOpe.Codigos = crOpera.TipoOps
UpDate crOpera Set nMarcas = 0 Where crTpOpe.Codigos = crOpera.TipoOps
UpDate crTpOpe Set nMarcas = 0
UpDate crOpera Set nMarcas = 0
UpDate crTpOpe Set nMarcas = 1
UpDate crOpera Set nMarcas = 1
Select CrOpera
Select crTpOpe
	UpDate crOpera Set crOpera.nMarcas = crTpOpe.nMarcas Where crTpOpe.Codigos = crOpera.TipoOps
	Update crGrdGru Set nMarcas = crGrdGpr.nMarcas Where Mercs = crGrdGpr.Codigos
	Select crGrdGru
UpDate crGrdGpr Set nMarcas = 0 
UpDate crGrdGru Set nMarcas = 0 
	Select * From crGrdGpr Where Codigos = crGrdGru.Mercs Into Cursor crBus
UpDate crGrdGru Set nMarcas = 0 
Update crSigCdEmp Set Imps = (This.Value = 1)
UpDate crGrdGpr Set nMarcas = 1
UpDate crGrdGru Set nMarcas = 1
UpDate crGrdGru Set nMarcas = 1 ;
 Where Mercs In (Select Codigos as Mercs From crGrdGpr Where nMarcas = 1)
	Select crPgRes01
	lcQuery = [Select Dopes From SigCdOpe Where Dopes = '] + crPgRes01.Movimentacao + [']
	Select TmpOpe
		lcQuery = [Select Dopps From SigCdOpd Where Dopps = '] + crPgRes01.Movimentacao + [']
		Select TmpOpe
Select crPgRes01
Select crPgRes01
Select crPgRes01

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpVdi.prg) - TRECHOS RELEVANTES PARA PASS SQL (3850 linhas total):

*-- Linhas 572 a 590:
572:     *
573:     * O Init de FormBuscaAuxiliar JA tenta o match EXATO (regra #37):
574:     * achando 1 registro, resolve sozinho (this_lAchouRegistro +
575:     * this_lSelecionou) sem exibir dialogo - por isso NAO ha SQLEXEC proprio
576:     * de pre-checagem aqui (regra #37 - duplicar a checagem so cria caminho
577:     * para divergir). Universo vazio NUNCA avisa nem apaga o digitado
578:     * (regra #50) - so abre o picker, que ja mostra a lista completa.
579:     *==========================================================================
580:     PROCEDURE AbrirLookupMoeda(par_cCampoBusca, par_cValorBusca)
581:         LOCAL loc_oPag, loc_oBusca, loc_oErro
582:         loc_oPag = THIS.pgf_4c_Paginas.Page1
583: 
584:         TRY
585:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
586:                 "SigCdMoe", "cursor_4c_BuscaMoeda", par_cCampoBusca, par_cValorBusca, ;
587:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda", .F., .T., "")
588: 
589:             IF VARTYPE(loc_oBusca) = "O"
590:                 IF !loc_oBusca.this_lAchouRegistro

*-- Linhas 829 a 847:
829:     * (cmgFiltros no legado). Cria so a CASCA dos grids (sem RecordSource -
830:     * os cursores ainda nao existem aqui): THIS.CarregarDados() liga
831:     * o RecordSource depois que this_oBusinessObject.CarregarFiltrosIniciais()
832:     * roda (regra #41 - ControlSource antes do cursor existir derruba o Init).
833:     *
834:     * Nomes dos grids NAO seguem mapeamento.json (que colide os 5 grids em
835:     * "grd_4c_Dados" - mapeamento gerado automaticamente por classe-base,
836:     * sem distinguir irmaos): usar os nomes conceituais, os mesmos dos
837:     * cursores do BO (cursor_4c_Empresas/TiposOperacao/GrandeGrupo/
838:     * GrupoProduto/Operacoes).
839:     *==========================================================================
840:     * O CheckBox de LINHA de cada grade NAO nasce aqui: criar
841:     * Column1.AddObject("Check1","CheckBox") neste ponto estoura
842:     * "Error with CHECK1 - Value : Data type mismatch" e a tela nao abre,
843:     * porque o Grid sem RecordSource se auto-liga ao alias CORRENTE quando o
844:     * ColumnCount e definido. O CheckBox e instalado no funil CarregarDados,
845:     * depois do bind - ver o comentario la.
846:     *==========================================================================
847:     PROTECTED PROCEDURE ConfigurarGradesMarcacao(par_oPag)

*-- Linhas 863 a 881:
863:             .FontSize          = 8
864:             .AllowHeaderSizing = .F.
865:             .AllowRowSizing    = .F.
866:             .DeleteMark        = .F.
867:             .RecordMark        = .F.
868:             .RowHeight         = 17
869:             .ScrollBars        = 2
870:             .ForeColor         = RGB(0, 0, 0)
871:             .GridLineColor     = RGB(238, 238, 238)
872:             *-- Grid.ReadOnly ANTES dos Column.ReadOnly (regra #18): o do grid
873:             *-- propaga para as colunas e sobrescreveria o que vem depois.
874:             *-- .F. transcrito do montagrades legado (grdEmps e a UNICA das 5
875:             *-- grades cuja Column1 e editavel nativamente - as outras 4
876:             *-- travam Column1 e alternam so pelos handlers com NODEFAULT).
877:             .ReadOnly          = .F.
878:             .Visible           = .T.
879:         ENDWITH
880:         WITH par_oPag.grd_4c_Empresas.Column1
881:             .Width     = 15

*-- Linhas 981 a 999:
981:             .FontName       = "Tahoma"
982:             .FontSize       = 8
983:             .AllowRowSizing = .F.
984:             .DeleteMark     = .F.
985:             .GridLines      = 3
986:             .HeaderHeight   = 16
987:             .RowHeight      = 16
988:             .ScrollBars     = 2
989:             .TabStop        = .F.
990:             .ForeColor      = RGB(0, 0, 0)
991:             .BackColor      = RGB(255, 255, 244)
992:             .GridLineColor  = RGB(238, 238, 238)
993:             .Themes         = .F.
994:             .Visible        = .T.
995:             .RecordMark   = .F.
996:         ENDWITH
997:         WITH par_oPag.grd_4c_Tipos.Column1
998:             .Width     = 18
999:             .Alignment = 0

*-- Linhas 1137 a 1155:
1137:             .FontName       = "Tahoma"
1138:             .FontSize       = 8
1139:             .AllowRowSizing = .F.
1140:             .DeleteMark     = .F.
1141:             .GridLines      = 3
1142:             .HeaderHeight   = 16
1143:             .RowHeight      = 16
1144:             .ScrollBars     = 2
1145:             .TabStop        = .F.
1146:             .ForeColor      = RGB(0, 0, 0)
1147:             .GridLineColor  = RGB(238, 238, 238)
1148:             .Themes         = .F.
1149:             .Visible        = .T.
1150:             .RecordMark   = .F.
1151:         ENDWITH
1152:         WITH par_oPag.grd_4c_GrandeGrupo.Column1
1153:             .Width     = 18
1154:             .Alignment = 0
1155:             .FontName  = "Tahoma"

*-- Linhas 1239 a 1257:
1239:             .FontName       = "Tahoma"
1240:             .FontSize       = 8
1241:             .AllowRowSizing = .F.
1242:             .DeleteMark     = .F.
1243:             .GridLines      = 3
1244:             .HeaderHeight   = 16
1245:             .RowHeight      = 16
1246:             .ScrollBars     = 2
1247:             .TabStop        = .F.
1248:             .ForeColor      = RGB(0, 0, 0)
1249:             .GridLineColor  = RGB(238, 238, 238)
1250:             .Themes         = .F.
1251:             .Visible        = .T.
1252:             .RecordMark   = .F.
1253:         ENDWITH
1254:         WITH par_oPag.grd_4c_GrupoProduto.Column1
1255:             .Width     = 18
1256:             .Alignment = 0
1257:             .FontName  = "Tahoma"

*-- Linhas 1353 a 1371:
1353:             .FontName       = "Tahoma"
1354:             .FontSize       = 8
1355:             .AllowRowSizing = .F.
1356:             .DeleteMark     = .F.
1357:             .GridLines      = 3
1358:             .HeaderHeight   = 16
1359:             .RowHeight      = 16
1360:             .ScrollBars     = 2
1361:             .TabStop        = .F.
1362:             .ForeColor      = RGB(0, 0, 0)
1363:             .BackColor      = RGB(255, 255, 244)
1364:             .GridLineColor  = RGB(238, 238, 238)
1365:             .Themes         = .F.
1366:             .Visible        = .T.
1367:             .RecordMark   = .F.
1368:         ENDWITH
1369:         WITH par_oPag.grd_4c_Operacoes.Column1
1370:             .Width     = 18
1371:             .Alignment = 0

*-- Linhas 1448 a 1473:
1448:     * este bind para grdTipo/grdOpera/grdMercs/grdCGrus/grdEmps.
1449:     *
1450:     * A ORDEM abaixo e OBRIGATORIA e foi medida no VFP9:
1451:     *   ColumnCount -> RecordSource -> ControlSource de TODAS as colunas ->
1452:     *   AddObject do CheckBox (+ .Value = 0) -> Sparse + CurrentControl ->
1453:     *   Grid.ReadOnly -> Column.ReadOnly -> Width -> Header1.Caption
1454:     *
1455:     * Por que o CheckBox NAO pode nascer em ConfigurarGradesMarcacao: Grid
1456:     * sem RecordSource atribuida se liga sozinho ao alias CORRENTE no momento
1457:     * em que o ColumnCount e definido. Com isso a Column1 herda o
1458:     * ControlSource de uma coluna qualquer desse alias; se ela for CHARACTER,
1459:     * o Column1.AddObject("Check1","CheckBox") estoura no PROPRIO AddObject
1460:     * com "Error with CHECK1 - Value : Data type mismatch", o erro cai no TRY
1461:     * do InicializarForm, CREATEOBJECT devolve .F. e a TELA NAO ABRE - sem
1462:     * erro visivel e compilando limpo (medido no probe desta fase).
1463:     *
1464:     * E por que o funil, e nao o ConfigurarGrid: fechar/recriar o alias que e
1465:     * RecordSource do Grid DESTROI o objeto posto por Column.AddObject (a
1466:     * Column volta a desenhar o Text1 e o usuario ve 0/1 cru, sem como
1467:     * marcar). Por isso a instalacao do CheckBox e IDEMPOTENTE
1468:     * (GarantirCheckBoxColuna) e os BINDEVENT vao JUNTO com ela - objeto
1469:     * recriado e outro objeto, e as ligacoes do anterior morreram com ele.
1470:     *
1471:     * Fecha cada grade com GO TOP + Refresh: popular o cursor NAO repinta a
1472:     * grade sozinho.
1473:     *

*-- Linhas 1487 a 1507:
1487:             WITH loc_oPag.grd_4c_Empresas
1488:                 .ColumnCount             = 3
1489:                 .RecordSource            = "cursor_4c_Empresas"
1490:                 .Column1.ControlSource   = "cursor_4c_Empresas.Imps"
1491:                 .Column2.ControlSource   = "cursor_4c_Empresas.cemps"
1492:                 .Column3.ControlSource   = "cursor_4c_Empresas.razas"
1493:             ENDWITH
1494:             *-- sem prefixo de handler: no SCX legado os 4 handlers de
1495:             *-- grdEmps.Column1.Check1 estao COMENTADOS, ou seja o toggle
1496:             *-- individual e nativo (Column1.ReadOnly = .F.) e a marcacao em
1497:             *-- lote vem de cmg_4c_Empresas / chk_4c_Ck_MarcaEmp.
1498:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Empresas.Column1, "", .F., .F.)
1499:             WITH loc_oPag.grd_4c_Empresas
1500:                 .Column1.Sparse           = .F.
1501:                 .AddObject("Check1", "CheckBox")
1502:                 .Check1.Caption = ""
1503:                 .Check1.Alignment = 0
1504:                 .Check1.ReadOnly  = .F.
1505:                 .Check1.Visible   = .T.
1506:                 .Check1.Top       = 9
1507:                 .Check1.Left      = 2

*-- Linhas 1527 a 1546:
1527:             WITH loc_oPag.grd_4c_Tipos
1528:                 .ColumnCount             = 2
1529:                 .RecordSource            = "cursor_4c_TiposOperacao"
1530:                 .Column1.ControlSource   = "cursor_4c_TiposOperacao.nMarcas"
1531:                 .Column2.ControlSource   = "cursor_4c_TiposOperacao.CDescricaos"
1532:             ENDWITH
1533:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Tipos.Column1, "ChkTipo", .T., .T.)
1534:             WITH loc_oPag.grd_4c_Tipos
1535:                 .Column1.Sparse           = .F.
1536:                 .AddObject("Check1", "CheckBox")
1537:                 .Check1.Caption = ""
1538:                 .Check1.Alignment = 0
1539:                 .Check1.ReadOnly  = .F.
1540:                 .Check1.Visible   = .T.
1541:                 .Check1.Top       = 9
1542:                 .Check1.Left      = 2
1543:                 .Check1.Height    = 17
1544:                 .Check1.Width     = 22
1545:                 .Column1.CurrentControl   = "Check1"
1546:                 .Column1.ReadOnly         = .T.

*-- Linhas 1558 a 1577:
1558:             WITH loc_oPag.grd_4c_GrandeGrupo
1559:                 .ColumnCount             = 2
1560:                 .RecordSource            = "cursor_4c_GrandeGrupo"
1561:                 .Column1.ControlSource   = "cursor_4c_GrandeGrupo.nMarcas"
1562:                 .Column2.ControlSource   = "cursor_4c_GrandeGrupo.CDescricaos"
1563:             ENDWITH
1564:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrandeGrupo.Column1, "ChkGrandeGrupo", .T., .F.)
1565:             WITH loc_oPag.grd_4c_GrandeGrupo
1566:                 .Column1.Sparse           = .F.
1567:                 .AddObject("Check1", "CheckBox")
1568:                 .Check1.Caption = ""
1569:                 .Check1.Alignment = 0
1570:                 .Check1.ReadOnly  = .F.
1571:                 .Check1.Visible   = .T.
1572:                 .Check1.Top       = 9
1573:                 .Check1.Left      = 2
1574:                 .Check1.Height    = 17
1575:                 .Check1.Width     = 22
1576:                 .Column1.CurrentControl   = "Check1"
1577:                 .Column1.ReadOnly         = .T.

*-- Linhas 1589 a 1609:
1589:             WITH loc_oPag.grd_4c_GrupoProduto
1590:                 .ColumnCount             = 3
1591:                 .RecordSource            = "cursor_4c_GrupoProduto"
1592:                 .Column1.ControlSource   = "cursor_4c_GrupoProduto.nMarcas"
1593:                 .Column2.ControlSource   = "cursor_4c_GrupoProduto.Mercs"
1594:                 .Column3.ControlSource   = "cursor_4c_GrupoProduto.CDescricaos"
1595:             ENDWITH
1596:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_GrupoProduto.Column1, "ChkGrupoProduto", .T., .F.)
1597:             WITH loc_oPag.grd_4c_GrupoProduto
1598:                 .Column1.Sparse           = .F.
1599:                 .AddObject("Check1", "CheckBox")
1600:                 .Check1.Caption = ""
1601:                 .Check1.Alignment = 0
1602:                 .Check1.ReadOnly  = .F.
1603:                 .Check1.Visible   = .T.
1604:                 .Check1.Top       = 9
1605:                 .Check1.Left      = 2
1606:                 .Check1.Height    = 17
1607:                 .Check1.Width     = 22
1608:                 .Column1.CurrentControl   = "Check1"
1609:                 .Column1.ReadOnly         = .T.

*-- Linhas 1624 a 1643:
1624:             WITH loc_oPag.grd_4c_Operacoes
1625:                 .ColumnCount             = 2
1626:                 .RecordSource            = "cursor_4c_Operacoes"
1627:                 .Column1.ControlSource   = "cursor_4c_Operacoes.nMarcas"
1628:                 .Column2.ControlSource   = "cursor_4c_Operacoes.Dopes"
1629:             ENDWITH
1630:             THIS.GarantirCheckBoxColuna(loc_oPag.grd_4c_Operacoes.Column1, "ChkOperacao", .T., .T.)
1631:             WITH loc_oPag.grd_4c_Operacoes
1632:                 .Column1.Sparse           = .F.
1633:                 .AddObject("Check1", "CheckBox")
1634:                 .Check1.Caption = ""
1635:                 .Check1.Alignment = 0
1636:                 .Check1.ReadOnly  = .F.
1637:                 .Check1.Visible   = .T.
1638:                 .Check1.Top       = 9
1639:                 .Check1.Left      = 2
1640:                 .Check1.Height    = 17
1641:                 .Check1.Width     = 22
1642:                 .Column1.CurrentControl   = "Check1"
1643:                 .Column1.ReadOnly         = .T.

*-- Linhas 1653 a 1671:
1653: 
1654:     *==========================================================================
1655:     * GarantirCheckBoxColuna - instalador IDEMPOTENTE do CheckBox de marcacao
1656:     * de uma Column de Grid. Chamado SO depois de RecordSource/ControlSource
1657:     * estarem ligados (ver comentario de CarregarDados).
1658:     *
1659:     *   par_oColuna    - a Column que recebe o controle
1660:     *   par_cPrefixo   - prefixo dos handlers de alternancia ("ChkTipo", ...);
1661:     *                    vazio = coluna com toggle NATIVO, sem BINDEVENT
1662:     *   par_lGeometria - transcreve Top/Left/Width/Height/Alignment do SCX
1663:     *   par_lBackColor - transcreve BackColor branco do SCX
1664:     *
1665:     * Sai sem fazer nada se o controle ainda existe: AddObject repetido com o
1666:     * mesmo nome estoura "Object CHECK1 is already defined". Os BINDEVENT vao
1667:     * JUNTO porque um objeto recriado e outro objeto - sem religar, os quatro
1668:     * handlers de alternancia ficam MUDOS (o CheckBox aparece e nao alterna).
1669:     *==========================================================================
1670:     PROTECTED PROCEDURE GarantirCheckBoxColuna(par_oColuna, par_cPrefixo, par_lGeometria, par_lBackColor)
1671:         IF PEMSTATUS(par_oColuna, "Check1", 5)

*-- Linhas 1760 a 1844:
1760:     *==========================================================================
1761:     * GrdTiposAfterRowColChange - grdTipo.AfterRowColChange no legado:
1762:     *
1763:     *   Select CrOpera
1764:     *   Set Key To crTpOpe.Codigos
1765:     *   Go Top
1766:     *   This.parent.GrdOpera.Refresh
1767:     *   Select crTpOpe
1768:     *
1769:     * Ao trocar de linha na grade de TIPOS, a grade de OPERACOES passa a
1770:     * mostrar SOMENTE as operacoes daquele tipo. O SET KEY depende da TAG
1771:     * IdxTipoOps (criada em BO.CarregarFiltrosIniciais, igual ao Init
1772:     * legado); o SET ORDER explicito abaixo NAO esta no legado - la o tag
1773:     * recem-criado ainda e o controlador - mas aqui garante o resultado
1774:     * mesmo que algum outro ponto troque a ordem do cursor.
1775:     *
1776:     * Chave de UM campo NUMERICO inteiro (SigCdOpe.tipoops numeric(2,0) x
1777:     * SigCdTom.codigos numeric(2,0)): e match EXATO de chave COMPLETA,
1778:     * portanto imune ao SET EXACT ON global do config.prg (a armadilha
1779:     * medida vale para SET KEY com valor PARCIAL de chave composta).
1780:     *
1781:     * Os filtros do Consultar continuam enxergando o cursor INTEIRO: o
1782:     * BO monta a lista de operacoes marcadas com SQL SELECT, e SELECT do
1783:     * VFP9 ignora SET KEY/SET FILTER (medido) - mesma razao pela qual o
1784:     * legado podia conviver com este SET KEY permanente.
1785:     *
1786:     * PUBLIC (sem PROTECTED) por ser alvo de BINDEVENT - regra #3. A
1787:     * assinatura declara o parametro que AfterRowColChange passa.
1788:     *==========================================================================
1789:     PROCEDURE GrdTiposAfterRowColChange(par_nColIndex)
1790:         LOCAL loc_oPag, loc_oErro
1791: 
1792:         IF !USED("cursor_4c_Operacoes") OR !USED("cursor_4c_TiposOperacao")
1793:             RETURN
1794:         ENDIF
1795: 
1796:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1797: 
1798:         *-- TRY sem RETURN dentro (regra #1): o handler roda a CADA troca de
1799:         *-- linha e fora de qualquer TRY do chamador - sem isto, cursor sem
1800:         *-- a TAG IdxTipoOps viraria Program Error cru a cada clique.
1801:         TRY
1802:             SELECT cursor_4c_Operacoes
1803:             SET ORDER TO TAG IdxTipoOps
1804:             SET KEY TO cursor_4c_TiposOperacao.Codigos
1805:             GO TOP
1806: 
1807:             loc_oPag.grd_4c_Operacoes.Refresh()
1808:         CATCH TO loc_oErro
1809:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1810:                 "Procedure: " + loc_oErro.Procedure, "Erro ao filtrar Opera" + CHR(231) + CHR(245) + "es")
1811:         ENDTRY
1812: 
1813:         SELECT cursor_4c_TiposOperacao
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * GRADE TIPOS DE OPERACAO - checkbox Column1 (grdTipo.Column1.Check1 no
1818:     * legado). Ao marcar/desmarcar um Tipo, cascateia para as Operacoes
1819:     * (cursor_4c_Operacoes.nMarcas) daquele Tipo - igual ao legado.
1820:     *==========================================================================
1821:     PROCEDURE ChkTipoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1822:         LOCAL loc_oPag
1823:         IF INLIST(par_nKeyCode, 13, 32)
1824:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1825:             IF USED("cursor_4c_TiposOperacao")
1826:                 REPLACE cursor_4c_TiposOperacao.nMarcas WITH IIF(cursor_4c_TiposOperacao.nMarcas = 0, 1, 0)
1827:                 loc_oPag.grd_4c_Tipos.Refresh()
1828:                 IF USED("cursor_4c_Operacoes")
1829:                     UPDATE cursor_4c_Operacoes SET nMarcas = cursor_4c_TiposOperacao.nMarcas ;
1830:                         WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1831:                     loc_oPag.grd_4c_Operacoes.Refresh()
1832:                 ENDIF
1833:             ENDIF
1834:             NODEFAULT
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     PROCEDURE ChkTipoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1839:         THIS.ChkTipoKeyPress(13, 0)
1840:         NODEFAULT
1841:     ENDPROC
1842: 
1843:     PROCEDURE ChkTipoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1844:         NODEFAULT

*-- Linhas 1861 a 1879:
1861:                 REPLACE cursor_4c_GrandeGrupo.nMarcas WITH IIF(cursor_4c_GrandeGrupo.nMarcas = 0, 1, 0)
1862:                 loc_oPag.grd_4c_GrandeGrupo.Refresh()
1863:                 IF USED("cursor_4c_GrupoProduto")
1864:                     UPDATE cursor_4c_GrupoProduto SET nMarcas = cursor_4c_GrandeGrupo.nMarcas ;
1865:                         WHERE Mercs = cursor_4c_GrandeGrupo.Codigos
1866:                     loc_oPag.grd_4c_GrupoProduto.Refresh()
1867:                 ENDIF
1868:             ENDIF
1869:             NODEFAULT
1870:         ENDIF
1871:     ENDPROC
1872: 
1873:     PROCEDURE ChkGrandeGrupoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1874:         THIS.ChkGrandeGrupoKeyPress(13, 0)
1875:         NODEFAULT
1876:     ENDPROC
1877: 
1878:     PROCEDURE ChkGrandeGrupoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1879:         NODEFAULT

*-- Linhas 1898 a 1926:
1898: 
1899:                 IF cursor_4c_GrupoProduto.nMarcas = 1 AND USED("cursor_4c_GrandeGrupo")
1900:                     loc_cMercsPai = cursor_4c_GrupoProduto.Mercs
1901:                     SELECT cursor_4c_GrandeGrupo
1902:                     LOCATE FOR Codigos = loc_cMercsPai
1903:                     IF !FOUND() OR cursor_4c_GrandeGrupo.nMarcas = 0
1904:                         SELECT cursor_4c_GrupoProduto
1905:                         REPLACE nMarcas WITH 0
1906:                         MsgAviso("O Grande Grupo " + CHR(34) + ALLTRIM(loc_cMercsPai) + CHR(34) + " N" + CHR(227) + "o Foi Selecionado." + CHR(13) + ;
1907:                             "Para Selecionar Esse Grupo, Ajuste o Grande Grupo!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
1908:                     ENDIF
1909:                 ENDIF
1910: 
1911:                 SELECT cursor_4c_GrupoProduto
1912:                 loc_oPag.grd_4c_GrupoProduto.Refresh()
1913:             ENDIF
1914:             NODEFAULT
1915:         ENDIF
1916:     ENDPROC
1917: 
1918:     PROCEDURE ChkGrupoProdutoMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1919:         THIS.ChkGrupoProdutoKeyPress(13, 0)
1920:         NODEFAULT
1921:     ENDPROC
1922: 
1923:     PROCEDURE ChkGrupoProdutoMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1924:         NODEFAULT
1925:     ENDPROC
1926: 

*-- Linhas 1964 a 2103:
1964:         LOCAL loc_oPag
1965:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1966:         IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
1967:             UPDATE cursor_4c_Operacoes SET nMarcas = 1 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1968:             GO TOP IN cursor_4c_Operacoes
1969:             loc_oPag.grd_4c_Operacoes.Refresh()
1970:         ENDIF
1971:     ENDPROC
1972: 
1973:     PROCEDURE Command2Click()
1974:         LOCAL loc_oPag
1975:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1976:         IF USED("cursor_4c_Operacoes") AND USED("cursor_4c_TiposOperacao")
1977:             UPDATE cursor_4c_Operacoes SET nMarcas = 0 WHERE TipoOps = cursor_4c_TiposOperacao.Codigos
1978:             GO TOP IN cursor_4c_Operacoes
1979:             loc_oPag.grd_4c_Operacoes.Refresh()
1980:         ENDIF
1981:     ENDPROC
1982: 
1983:     *==========================================================================
1984:     * BtnMarcaClick / BtnDesmarcaClick - marcam/desmarcam TODOS os Tipos de
1985:     * Operacao e TODAS as Operacoes (btnMarca/btnDesmarca no legado)
1986:     *==========================================================================
1987:     PROCEDURE BtnMarcaClick()
1988:         LOCAL loc_oPag
1989:         loc_oPag = THIS.pgf_4c_Paginas.Page1
1990:         IF USED("cursor_4c_TiposOperacao")
1991:             UPDATE cursor_4c_TiposOperacao SET nMarcas = 1
1992:             GO TOP IN cursor_4c_TiposOperacao
1993:             loc_oPag.grd_4c_Tipos.Refresh()
1994:         ENDIF
1995:         IF USED("cursor_4c_Operacoes")
1996:             UPDATE cursor_4c_Operacoes SET nMarcas = 1
1997:             GO TOP IN cursor_4c_Operacoes
1998:             loc_oPag.grd_4c_Operacoes.Refresh()
1999:         ENDIF
2000:     ENDPROC
2001: 
2002:     PROCEDURE BtnDesmarcaClick()
2003:         LOCAL loc_oPag
2004:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2005:         IF USED("cursor_4c_TiposOperacao")
2006:             UPDATE cursor_4c_TiposOperacao SET nMarcas = 0
2007:             GO TOP IN cursor_4c_TiposOperacao
2008:             loc_oPag.grd_4c_Tipos.Refresh()
2009:         ENDIF
2010:         IF USED("cursor_4c_Operacoes")
2011:             UPDATE cursor_4c_Operacoes SET nMarcas = 0
2012:             GO TOP IN cursor_4c_Operacoes
2013:             loc_oPag.grd_4c_Operacoes.Refresh()
2014:         ENDIF
2015:     ENDPROC
2016: 
2017:     *==========================================================================
2018:     * BtnMarGdeClick / BtnDesGdeClick - marcam/desmarcam TODO o Grande Grupo
2019:     * e TODO o Grupo de Produto (btnMarGde/btnDesGde no legado)
2020:     *==========================================================================
2021:     PROCEDURE BtnMarGdeClick()
2022:         LOCAL loc_oPag
2023:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2024:         IF USED("cursor_4c_GrandeGrupo")
2025:             UPDATE cursor_4c_GrandeGrupo SET nMarcas = 1
2026:             GO TOP IN cursor_4c_GrandeGrupo
2027:             loc_oPag.grd_4c_GrandeGrupo.Refresh()
2028:         ENDIF
2029:         IF USED("cursor_4c_GrupoProduto")
2030:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 1
2031:             GO TOP IN cursor_4c_GrupoProduto
2032:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2033:         ENDIF
2034:     ENDPROC
2035: 
2036:     PROCEDURE BtnDesGdeClick()
2037:         LOCAL loc_oPag
2038:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2039:         IF USED("cursor_4c_GrandeGrupo")
2040:             UPDATE cursor_4c_GrandeGrupo SET nMarcas = 0
2041:             GO TOP IN cursor_4c_GrandeGrupo
2042:             loc_oPag.grd_4c_GrandeGrupo.Refresh()
2043:         ENDIF
2044:         IF USED("cursor_4c_GrupoProduto")
2045:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
2046:             GO TOP IN cursor_4c_GrupoProduto
2047:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2048:         ENDIF
2049:     ENDPROC
2050: 
2051:     *==========================================================================
2052:     * BtnMarGrpClick / BtnDesGrpClick - marcam/desmarcam o Grupo de Produto
2053:     * (btnMarGrp/btnDesGrp no legado). Marcar so afeta linhas cujo Grande
2054:     * Grupo pai JA ESTA marcado (igual ao legado).
2055:     *==========================================================================
2056:     PROCEDURE BtnMarGrpClick()
2057:         LOCAL loc_oPag
2058:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2059:         IF USED("cursor_4c_GrupoProduto") AND USED("cursor_4c_GrandeGrupo")
2060:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 1 ;
2061:                 WHERE Mercs IN (SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1)
2062:             GO TOP IN cursor_4c_GrupoProduto
2063:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2064:         ENDIF
2065:     ENDPROC
2066: 
2067:     PROCEDURE BtnDesGrpClick()
2068:         LOCAL loc_oPag
2069:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2070:         IF USED("cursor_4c_GrupoProduto")
2071:             UPDATE cursor_4c_GrupoProduto SET nMarcas = 0
2072:             GO TOP IN cursor_4c_GrupoProduto
2073:             loc_oPag.grd_4c_GrupoProduto.Refresh()
2074:         ENDIF
2075:     ENDPROC
2076: 
2077:     *==========================================================================
2078:     * CmdEmpsClick - cmg_4c_Empresas (cmdEmps no legado): Buttons(1) marca
2079:     * Imps = 1 em todas as Empresas, Buttons(2) desmarca (Imps = 0).
2080:     * O legado escreve "Set Imps = (This.Value = 1)" porque la a coluna eh
2081:     * bit/logica; aqui Imps eh NUMERICA (CheckBox.Value eh numerico), por
2082:     * isso o IIF explicito - atribuir o Logico direto estoura type mismatch.
2083:     *==========================================================================
2084:     PROCEDURE CmdEmpsClick()
2085:         LOCAL loc_oPag
2086:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2087:         IF USED("cursor_4c_Empresas")
2088:             UPDATE cursor_4c_Empresas SET Imps = IIF(loc_oPag.cmg_4c_Empresas.Value = 1, 1, 0)
2089:             GO TOP IN cursor_4c_Empresas
2090:             loc_oPag.grd_4c_Empresas.Refresh()
2091:         ENDIF
2092:     ENDPROC
2093: 
2094:     *==========================================================================
2095:     * CkMarcaEmpClick - chk_4c_Ck_MarcaEmp (ck_MarcaEmp no legado): marca/
2096:     * desmarca TODAS as Empresas de uma vez
2097:     *==========================================================================
2098:     PROCEDURE CkMarcaEmpClick()
2099:         LOCAL loc_oPag
2100:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2101:         IF USED("cursor_4c_Empresas")
2102:             *-- Imps eh NUMERICA (CheckBox.Value eh numerico): 1/0, nao .T./.F.
2103:             IF loc_oPag.chk_4c_Ck_MarcaEmp.Value = 1

*-- Linhas 2165 a 2193:
2165:         ENDIF
2166: 
2167:         IF USED("cursor_4c_TiposOperacao")
2168:             SELECT CCodigos FROM cursor_4c_TiposOperacao WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaTipos
2169:             IF RECCOUNT("cursor_4c_VerificaTipos") = 0
2170:                 USE IN cursor_4c_VerificaTipos
2171:                 MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
2172:                 RETURN .F.
2173:             ENDIF
2174:             USE IN cursor_4c_VerificaTipos
2175:         ENDIF
2176: 
2177:         IF USED("cursor_4c_GrandeGrupo")
2178:             SELECT Codigos FROM cursor_4c_GrandeGrupo WHERE nMarcas = 1 INTO CURSOR cursor_4c_VerificaGde
2179:             IF RECCOUNT("cursor_4c_VerificaGde") = 0
2180:                 USE IN cursor_4c_VerificaGde
2181:                 MsgAviso("Nenhum Grande Grupo Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
2182:                 RETURN .F.
2183:             ENDIF
2184:             USE IN cursor_4c_VerificaGde
2185:         ENDIF
2186: 
2187:         loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dIni, loc_dFim, ;
2188:             THIS.this_oBusinessObject.this_cMoeda, THIS.this_oBusinessObject.this_cGrupoVenda, ;
2189:             THIS.this_oBusinessObject.this_cSubGrupo)
2190: 
2191:         IF loc_lSucesso
2192:             THIS.this_oBusinessObject.this_nTipoValor = 3
2193:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.optValor1.Value = 3

*-- Linhas 2321 a 2352:
2321: 
2322:     *==========================================================================
2323:     * ConfigurarAbaDetalhamento - pgRes01 (Detalhamento dos Produtos):
2324:     * grd_4c_Dados1 (35 colunas, ControlSource/Width/Alignment EXATOS do
2325:     * dump - SECAO 2, nao do runtime GradePadrao(), que esta desatualizado
2326:     * em relacao ao SCX - ver GradePadrao() mais abaixo) + o painel lateral
2327:     * (imagem, observacao, preco atual, desconto/acrescimo, busca por
2328:     * codigo, filtro positivas/negativas/sem-filtro) + os botoes de acao
2329:     * (Restaurar Grade, Cadastro do Produto, Movimento, Subniveis, Conta,
2330:     * Visualizar, Imprimir).
2331:     *
2332:     * Cursor_4c_Detalhe (crPgRes01) JA EXISTE neste ponto - criado pelo
2333:     * Init() do BO (CriarCursoresResultado), chamado ANTES de
2334:     * ConfigurarPageFrame em InicializarForm. Por isso o bind
2335:     * (RecordSource/ControlSource) pode ser feito aqui, direto, sem o funil
2336:     * deferido que as grades de filtro da Pagina 1 precisam (regra #41) -
2337:     * BtnConsultarClick so faz ZAP+INSERT no MESMO cursor (nunca fecha/
2338:     * reabre o alias), entao o RecordSource nunca se perde.
2339:     *==========================================================================
2340:     PROTECTED PROCEDURE ConfigurarAbaDetalhamento(par_oPag)
2341:         LOCAL loc_nCol
2342:         DIMENSION loc_aLargura(35)
2343:         DIMENSION loc_aCaption(35)
2344: 
2345:         loc_aCaption( 1) = "Emp"
2346:         loc_aLargura( 1) =  31
2347:         loc_aCaption( 2) = "Movimenta" + CHR(231) + CHR(227) + "o"
2348:         loc_aLargura( 2) = 150
2349:         loc_aCaption( 3) = "C" + CHR(243) + "digo"
2350:         loc_aLargura( 3) =  55
2351:         loc_aCaption( 4) = "Data"
2352:         loc_aLargura( 4) =  71

*-- Linhas 2428 a 2489:
2428:             .FontSize          = 7
2429:             .AllowHeaderSizing = .F.
2430:             .AllowRowSizing    = .F.
2431:             .DeleteMark        = .F.
2432:             .RecordMark        = .F.
2433:             .HeaderHeight      = 21
2434:             .RowHeight         = 15
2435:             .ScrollBars        = 3
2436:             .GridLineColor     = RGB(238, 238, 238)
2437:             *-- RecordSource ANTES do ControlSource (regra #41) - o cursor
2438:             *-- ja existe (CriarCursoresResultado roda no Init do BO).
2439:             .RecordSource      = "cursor_4c_Detalhe"
2440:             .Column1.ControlSource  = "cursor_4c_Detalhe.Empresa"
2441:             .Column2.ControlSource  = "cursor_4c_Detalhe.Movimentacao"
2442:             .Column3.ControlSource  = "cursor_4c_Detalhe.Numero"
2443:             .Column4.ControlSource  = "IIF(EMPTY(cursor_4c_Detalhe.Data_Venda), SPACE(10), DTOC(cursor_4c_Detalhe.Data_Venda))"
2444:             .Column5.ControlSource  = "cursor_4c_Detalhe.Codigo_Vendedora"
2445:             .Column6.ControlSource  = "cursor_4c_Detalhe.Barras"
2446:             .Column7.ControlSource  = "cursor_4c_Detalhe.Codigo_Item"
2447:             .Column8.ControlSource  = "cursor_4c_Detalhe.Desc_Item"
2448:             .Column9.ControlSource  = "cursor_4c_Detalhe.Cor"
2449:             .Column10.ControlSource = "cursor_4c_Detalhe.Tamanho"
2450:             .Column11.ControlSource = "cursor_4c_Detalhe.Valor_Diferenca"
2451:             .Column12.ControlSource = "ALLTRIM(cursor_4c_Detalhe.Pct_Dif_Chr)"
2452:             .Column13.ControlSource = "cursor_4c_Detalhe.Venda_Cadastro"
2453:             .Column14.ControlSource = "cursor_4c_Detalhe.Val_Unitario"
2454:             .Column15.ControlSource = "cursor_4c_Detalhe.Quantidade"
2455:             .Column16.ControlSource = "cursor_4c_Detalhe.Total"
2456:             .Column17.ControlSource = "cursor_4c_Detalhe.Custo_Cadastro"
2457:             .Column18.ControlSource = "cursor_4c_Detalhe.Cod_Fornecedor"
2458:             .Column19.ControlSource = "cursor_4c_Detalhe.Nome_Fornecedor"
2459:             .Column20.ControlSource = "cursor_4c_Detalhe.Ref_Fornecedor"
2460:             .Column21.ControlSource = "cursor_4c_Detalhe.Gde_Grupo"
2461:             .Column22.ControlSource = "cursor_4c_Detalhe.Grupo"
2462:             .Column23.ControlSource = "cursor_4c_Detalhe.SubGrupo"
2463:             .Column24.ControlSource = "cursor_4c_Detalhe.Operacao"
2464:             .Column25.ControlSource = "cursor_4c_Detalhe.Cod_Cliente"
2465:             .Column26.ControlSource = "cursor_4c_Detalhe.Nome_Cliente"
2466:             .Column27.ControlSource = "cursor_4c_Detalhe.Parcelas"
2467:             .Column28.ControlSource = "cursor_4c_Detalhe.Cond_Pagto"
2468:             .Column29.ControlSource = "cursor_4c_Detalhe.Markup"
2469:             .Column30.ControlSource = "cursor_4c_Detalhe.Total_Geral"
2470:             .Column31.ControlSource = "cursor_4c_Detalhe.Local_Itn"
2471:             .Column32.ControlSource = "cursor_4c_Detalhe.Equivalente"
2472:             .Column33.ControlSource = "cursor_4c_Detalhe.Categoria"
2473:             .Column34.ControlSource = "cursor_4c_Detalhe.Nome_Vendedora"
2474:             .Column35.ControlSource = "cursor_4c_Detalhe.Desc_Categoria"
2475: 
2476:             .Column4.Alignment  = 2
2477:             .Column12.Alignment = 1
2478:             .Column24.Alignment = 2
2479:             .Column27.Alignment = 1
2480: 
2481:             *-- Codigo_Item (7) e Equivalente (32): estilo "link" do legado
2482:             *-- (FontBold+Underline+azul). O clique e de verdade: o DblClick
2483:             *-- do Text1 das duas colunas abre a Pesquisa Global de Produtos
2484:             *-- filtrada pelo codigo da celula (ver
2485:             *-- ConfigurarBindEventsResultados / AbrirPesquisaGlobalProduto),
2486:             *-- igual ao legado.
2487:             .Column7.FontBold       = .T.
2488:             .Column7.FontUnderline  = .T.
2489:             .Column7.ForeColor      = RGB(0, 0, 255)

*-- Linhas 2878 a 2896:
2878:     *==========================================================================
2879:     * ConfigurarAbaTotalEmpresa - pgRes02 (Totais por Empresa): grd_4c_Dados2
2880:     * (10 colunas, cursor_4c_TotalEmpresa). O legado NAO define Width por
2881:     * coluna aqui (soh ControlSource/ReadOnly/InputMask em montagrades) -
2882:     * os valores abaixo vem do design-time do SCX (SECAO 2).
2883:     *==========================================================================
2884:     PROTECTED PROCEDURE ConfigurarAbaTotalEmpresa(par_oPag)
2885:         LOCAL loc_nCol
2886:         DIMENSION loc_aLargura(10)
2887:         DIMENSION loc_aCaption(10)
2888: 
2889:         loc_aCaption( 1) = "Emp"
2890:         loc_aLargura( 1) =  31
2891:         loc_aCaption( 2) = "Descritivo"
2892:         loc_aLargura( 2) = 150
2893:         loc_aCaption( 3) = "Valor da Diferen" + CHR(231) + "a"
2894:         loc_aLargura( 3) = 100
2895:         loc_aCaption( 4) = "% Dif."
2896:         loc_aLargura( 4) =  45

*-- Linhas 2922 a 2956:
2922:             .FontSize          = 7
2923:             .AllowHeaderSizing = .F.
2924:             .AllowRowSizing    = .F.
2925:             .DeleteMark        = .F.
2926:             .RecordMark        = .F.
2927:             .HeaderHeight      = 21
2928:             .RowHeight         = 15
2929:             .ScrollBars        = 3
2930:             .GridLineColor     = RGB(238, 238, 238)
2931:             .RecordSource      = "cursor_4c_TotalEmpresa"
2932:             .Column1.ControlSource  = "cursor_4c_TotalEmpresa.Empresa"
2933:             .Column2.ControlSource  = "cursor_4c_TotalEmpresa.Movimentacao"
2934:             .Column3.ControlSource  = "cursor_4c_TotalEmpresa.Valor_Diferenca"
2935:             .Column4.ControlSource  = "cursor_4c_TotalEmpresa.Perc_Diferenca"
2936:             .Column5.ControlSource  = "cursor_4c_TotalEmpresa.Venda_Cadastro"
2937:             .Column6.ControlSource  = "cursor_4c_TotalEmpresa.Quantidade"
2938:             .Column7.ControlSource  = "cursor_4c_TotalEmpresa.Total"
2939:             .Column8.ControlSource  = "cursor_4c_TotalEmpresa.Custo_Cadastro"
2940:             .Column9.ControlSource  = "cursor_4c_TotalEmpresa.Tkt_Medio"
2941:             .Column10.ControlSource = "cursor_4c_TotalEmpresa.Markup"
2942: 
2943:             FOR loc_nCol = 1 TO 10
2944:                 THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados2, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
2945:             ENDFOR
2946: 
2947:             .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalEmpresa.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
2948:             .SetAll("DynamicFontBold",  "cursor_4c_TotalEmpresa.Ordem <> 'A'", "Column")
2949:             .Column3.DynamicBackColor = "RGB(255,255,240)"
2950:             .Column4.DynamicBackColor = "RGB(255,255,240)"
2951: 
2952:             .Visible = .T.
2953:         ENDWITH
2954:     ENDPROC
2955: 
2956:     *==========================================================================

*-- Linhas 2998 a 3032:
2998:             .FontSize          = 7
2999:             .AllowHeaderSizing = .F.
3000:             .AllowRowSizing    = .F.
3001:             .DeleteMark        = .F.
3002:             .RecordMark        = .F.
3003:             .HeaderHeight      = 21
3004:             .RowHeight         = 15
3005:             .ScrollBars        = 3
3006:             .GridLineColor     = RGB(238, 238, 238)
3007:             .RecordSource      = "cursor_4c_TotalVendedora"
3008:             .Column1.ControlSource  = "cursor_4c_TotalVendedora.Empresa"
3009:             .Column2.ControlSource  = "cursor_4c_TotalVendedora.Codigo_Vendedora"
3010:             .Column3.ControlSource  = "cursor_4c_TotalVendedora.Valor_Diferenca"
3011:             .Column4.ControlSource  = "cursor_4c_TotalVendedora.Perc_Diferenca"
3012:             .Column5.ControlSource  = "cursor_4c_TotalVendedora.Venda_Cadastro"
3013:             .Column6.ControlSource  = "cursor_4c_TotalVendedora.Quantidade"
3014:             .Column7.ControlSource  = "cursor_4c_TotalVendedora.Total"
3015:             .Column8.ControlSource  = "cursor_4c_TotalVendedora.Custo_Cadastro"
3016:             .Column9.ControlSource  = "cursor_4c_TotalVendedora.Tkt_Medio"
3017:             .Column10.ControlSource = "cursor_4c_TotalVendedora.Markup"
3018: 
3019:             FOR loc_nCol = 1 TO 10
3020:                 THIS.ConfigurarColunaResultado(par_oPag.grd_4c_Dados3, loc_nCol, loc_aCaption(loc_nCol), loc_aLargura(loc_nCol), (loc_nCol >= 3))
3021:             ENDFOR
3022: 
3023:             .SetAll("DynamicBackColor", "IIF(cursor_4c_TotalVendedora.Ordem <> 'A', RGB(255,255,240), RGB(255,255,255))", "Column")
3024:             .SetAll("DynamicFontBold",  "cursor_4c_TotalVendedora.Ordem <> 'A'", "Column")
3025:             .Column3.DynamicBackColor = "RGB(255,255,240)"
3026:             .Column4.DynamicBackColor = "RGB(255,255,240)"
3027: 
3028:             .Visible = .T.
3029:         ENDWITH
3030:     ENDPROC
3031: 
3032:     *==========================================================================

*-- Linhas 3289 a 3307:
3289: 
3290:         IF !EMPTY(loc_cValor)
3291:             IF PADR(loc_oPagRes01.txt_4c_Busca.Tag, 10) != PADR(loc_cValor, 10) AND USED("cursor_4c_Detalhe")
3292:                 SELECT cursor_4c_Detalhe
3293:                 GO TOP
3294:                 LOCATE FOR Numero = VAL(loc_cValor)
3295:             ENDIF
3296:             loc_oPagRes01.grd_4c_Dados1.Refresh()
3297:         ENDIF
3298:     ENDPROC
3299: 
3300:     *==========================================================================
3301:     * OptValor1InteractiveChange - optValor1 (Positivas/Negativas/Sem
3302:     * Filtro) no legado chama Filtros(1, This.Value) a cada troca.
3303:     *==========================================================================
3304:     PROCEDURE OptValor1InteractiveChange()
3305:         LOCAL loc_nValor
3306:         loc_nValor = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1.obj_4c_OptValor1.Value
3307:         THIS.this_oBusinessObject.this_nTipoValor = loc_nValor

*-- Linhas 3319 a 3337:
3319: 
3320:         IF par_nPagina = 1
3321:             IF USED("cursor_4c_Detalhe")
3322:                 SELECT cursor_4c_Detalhe
3323:                 SET ORDER TO ("Ordem" + TRANSFORM(par_nOrdem))
3324:                 GO TOP
3325:             ENDIF
3326:             loc_oPagRes01 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Resultados.Page1
3327:             loc_oPagRes01.grd_4c_Dados1.Refresh()
3328:         ENDIF
3329:     ENDPROC
3330: 
3331:     *==========================================================================
3332:     * BtnRestaurarClick - btnRestaurar.Click no legado: confirma, restaura
3333:     * a largura/visibilidade padrao (GradePadrao) e persiste
3334:     * (AcertaColunas('GRAVAR')).
3335:     *==========================================================================
3336:     PROCEDURE BtnRestaurarClick()
3337:         IF MsgConfirma("Deseja Restaurar as Colunas da Grade (Ocultas e Larguras)?", "Restaurar Grade")

*-- Linhas 3694 a 3722:
3694:                     "Cliente" + CHR(9) + "Nome do Cliente" + CHR(9) + "Fornecedor" + CHR(9) + "Nome do Fornecedor" + CHR(9) + ;
3695:                     "Subgrupo" + CHR(9) + "Refer" + CHR(234) + "ncia" + CHR(9) + "Gde Grupo" + CHR(9) + "Grupo" + CHR(9) + ;
3696:                     "Quantidade" + CHR(9) + "Movimenta" + CHR(231) + CHR(227) + "o" + CHR(9) + "Opera" + CHR(231) + CHR(227) + "o" + CHR(9)
3697:                 SELECT cursor_4c_Detalhe
3698:             CASE loc_nPagina = 2
3699:                 loc_cStr = "Empresa" + CHR(9) + "Descritivo" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
3700:                     "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
3701:                     "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
3702:                 SELECT cursor_4c_TotalEmpresa
3703:             CASE loc_nPagina = 3
3704:                 loc_cStr = "Empresa" + CHR(9) + "Vendedora" + CHR(9) + "Valor da Diferen" + CHR(231) + "a" + CHR(9) + ;
3705:                     "% Diferen" + CHR(231) + "a" + CHR(9) + "Valor do Cadastro" + CHR(9) + "Quantidade" + CHR(9) + ;
3706:                     "Total da Venda" + CHR(9) + "Custo do Cadastro" + CHR(9) + "Ticket M" + CHR(233) + "dio" + CHR(9)
3707:                 SELECT cursor_4c_TotalVendedora
3708:         ENDCASE
3709: 
3710:         loc_cStr = loc_cStr + CHR(13)
3711:         STRTOFILE(loc_cStr, loc_cArquivo, 1)
3712: 
3713:         SCAN
3714:             loc_cStr = ""
3715:             DO CASE
3716:                 CASE loc_nPagina = 1
3717:                     loc_cStr = loc_cStr + ;
3718:                         THIS.FLimpa(cursor_4c_Detalhe.Empresa, "C") + ;
3719:                         THIS.FLimpa(STR(cursor_4c_Detalhe.Numero, 10), "C") + ;
3720:                         THIS.FLimpa(DTOC(cursor_4c_Detalhe.Data_Venda), "C") + ;
3721:                         THIS.FLimpa(cursor_4c_Detalhe.Codigo_Vendedora, "C") + ;
3722:                         THIS.FLimpa(STR(cursor_4c_Detalhe.Barras, 14), "C") + ;

*-- Linhas 3798 a 3850:
3798: 
3799:         DO CASE
3800:             CASE loc_nPagina = 1
3801:                 *-- Local_Itn nao faz parte do SELECT do legado (ver
3802:                 *-- gerarxls() - Tam_De/Tam_Para sim) - transcrito literal.
3803:                 *-- Nomes de Movimentacao de TOTAL conforme gravados pelo
3804:                 *-- proprio BO (MontarResultadoDetalhe: "TOTAL DE ENTRADAS"/
3805:                 *-- "TOTAL DE SAIDAS", sem acento - regra de comparacao
3806:                 *-- exact-safe via ALLTRIM em vez do literal com padding
3807:                 *-- fixo do dump legado).
3808:                 SELECT Empresa, Numero, Data_Venda, Codigo_Vendedora, Barras, ;
3809:                        Tipo, Codigo_Item, Desc_Item, Equivalente, Cor, Tamanho, ;
3810:                        Tam_De, Tam_Para, Custo_Cadastro, ;
3811:                        Val_Unitario, Markup, Valor_Diferenca, Perc_Diferenca, ;
3812:                        Venda_Cadastro, Total, Parcelas, Cond_Pagto, Cod_Cliente, ;
3813:                        Nome_Cliente, Cod_Fornecedor, Nome_Fornecedor, SubGrupo, ;
3814:                        Ref_Fornecedor, Gde_Grupo, Grupo, Quantidade, Movimentacao ;
3815:                   FROM cursor_4c_Detalhe ;
3816:                  WHERE !INLIST(ALLTRIM(Movimentacao), "TOTAL DE ENTRADAS", "TOTAL DE SAIDAS") ;
3817:                  ORDER BY Empresa, Ordem, Data_Venda, Movimentacao, Numero, Item ;
3818:                   INTO CURSOR cursor_4c_Excel
3819:             CASE loc_nPagina = 2
3820:                 SELECT Empresa, Movimentacao, Valor_Diferenca, Perc_Diferenca, ;
3821:                        Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
3822:                   FROM cursor_4c_TotalEmpresa ;
3823:                  ORDER BY Empresa, Ordem, Movimentacao ;
3824:                   INTO CURSOR cursor_4c_Excel
3825:             CASE loc_nPagina = 3
3826:                 SELECT Empresa, Codigo_Vendedora, Valor_Diferenca, Perc_Diferenca, ;
3827:                        Venda_Cadastro, Quantidade, Total, Custo_Cadastro, Tkt_Medio ;
3828:                   FROM cursor_4c_TotalVendedora ;
3829:                  ORDER BY Empresa, Ordem, Codigo_Vendedora ;
3830:                   INTO CURSOR cursor_4c_Excel
3831:             OTHERWISE
3832:                 RETURN
3833:         ENDCASE
3834: 
3835:         SELECT cursor_4c_Excel
3836:         COPY TO (loc_cArquivo) TYPE XL5
3837:         USE IN cursor_4c_Excel
3838: 
3839:         MsgInfo("O Arquivo " + CHR(34) + ALLTRIM(loc_cArquivo) + CHR(34) + " Foi Gerado!!!", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
3840:     ENDPROC
3841: 
3842:     *==========================================================================
3843:     * DESTROY - Destrutor. FormBase.Destroy ja cuida da liberacao do BO e do
3844:     * fix de menu-shrinks (Erro58) - esta subclasse so precisa encadear.
3845:     *==========================================================================
3846:     PROCEDURE Destroy()
3847:         RETURN DODEFAULT()
3848:     ENDPROC
3849: 
3850: ENDDEFINE

