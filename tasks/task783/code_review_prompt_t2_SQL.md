# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'USUAR' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, I, EMPDOPNUMS, CITENS, CODTAMS, EMPOS, GRUPOS, CONTAS, CUNIS, ETIQS, EMPS, DATAS, PSTATUS, FILTRO, MERCS, CODIGOS, NUMERO, DOPES, DOPPS, DATAALTS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDPARAMS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, I, EMPDOPNUMS, CITENS, CODTAMS, EMPOS, GRUPOS, CONTAS, CUNIS, ETIQS, EMPS, DATAS, PSTATUS, FILTRO, MERCS, CODIGOS, NUMERO, DOPES, DOPPS, DATAALTS, FPAGS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'VALUE' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNCNT, CPROS, NMARCAS, GDE_GRUPO, GRUPO, LNCOL, CEMPS, USUARIOS, EMPRESA, I, EMPDOPNUMS, CITENS, CODTAMS, EMPOS, GRUPOS, CONTAS, CUNIS, ETIQS, EMPS, DATAS, PSTATUS, FILTRO, MERCS, CODIGOS, NUMERO, DOPES, DOPPS, DATAALTS, FPAGS

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
  Column1.ControlSource = ""
  Column2.ControlSource = ""
  DeleteMark = .F.
  DeleteMark = .F.
  DeleteMark = .F.
  Column1.ControlSource = ""
  Column10.ControlSource = ""
  Column16.ControlSource = ""
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
			Select * From crPgRes01 ;
	Select crExcel
	lcQuery = [Select e.CEmps as Emps ] + ;
				[From SigCdEmp e ] + ;
			   		 [Select a.Emps From SigCdAce a Where a.Usuarios = '] + Usuar + [')]
	Select LocalEmps
		Delete From &pCur. Where Empresa = LocalEmps.Emps
	.Column1.ControlSource = [crTpOpe.nMarcas]
	.Column2.ControlSource = [crTpOpe.cDescricaos]
	.Column1.ControlSource = [crGrdGpr.nMarcas]
	.Column2.ControlSource = [crGrdGpr.cDescricaos]
	.Column1.ControlSource = [crGrdGru.nMarcas]
	.Column2.ControlSource = [crGrdGru.Mercs]
	.Column3.ControlSource = [crGrdGru.cDescricaos]
	.Column1.ControlSource   = [crPgRes01.Destino]
	.Column2.ControlSource   = [crPgRes01.Movimentacao]
	.Column3.ControlSource   = [crPgRes01.Numero]
	.Column4.ControlSource   = [Iif(Empty(crPgRes01.Data_Venda), Space(10), Dtoc(crPgRes01.Data_Venda))]
	.Column5.ControlSource   = [crPgRes01.Pedidoweb]
	.Column6.ControlSource   = [crPgRes01.Barras]
	.Column7.ControlSource   = [crPgRes01.Codigo_Item]
	.Column8.ControlSource   = [crPgRes01.Desc_Item]
	.Column9.ControlSource   = [crPgRes01.Cor]
	.Column10.ControlSource  = [crPgRes01.Tamanho]
	.Column11.ControlSource  = [crPgRes01.Colecao]
	.Column12.ControlSource  = [crPgRes01.Local]
	.Column13.ControlSource  = [crPgRes01.Qtde]
	.Column14.ControlSource  = [crPgRes01.Descritivo]
	.Column15.ControlSource  = [crPgRes01.Quantidade]
	.Column16.ControlSource  = [crPgRes01.Subgrupo]
Select crPgRes01
Select crCursor1
	lcQuery = [Select p.EmpDopNums, p.FPags, p.TParcs, p.Datas, p.Vencs, f.Infos ] + ;
				[From SigMvPar p, SigOpFp f ] + ;
	Insert Into crPgRes01 From Memvar
Select crPgRes01
Select CCodigos ;
	From crTpOpe ;
	Select LocalTpOpe
oProg1.Update(.T.)
lcQuery = [Select c.empds as Destino, c.emps as Empresa, c.Dopes as Movimentacao, c.Numes as Numero, c.Datas as Data_Venda, i.CPros as Codigo_Item, ] + ;
	[From SigMvCab c ] + ;
	[Left Join SigCdOpe o On c.Dopes = o.Dopes ] + ;
	[Left Join SigWbPed w On c.PedidoWeb = w.Pedido ] + ;
	[left join SigCdCli x on w.cpfcli = replace(replace(replace(x.cpfs,'-',''),'.',''),'/','') ] + ;
	[LEFT JOIN (select max(datapgt) as DtPagto, Pedido from sigwbpar group by pedido ) n on c.pedidoweb = n.pedido ] + ;
	[Left Join SigMvItn i On c.EmpDopNums = i.EmpDopNums ] + ;
	[Left Join SigMvIts s On i.EmpDopNums = s.EmpDopNums And i.CItens = s.CItens and i.cpros = s.cpros ] + ;
	[Left Join SigPrTam t On s.CPros = t.CPros And s.CodTams = t.CodTams ] + ;
	[Left Join SigCdPro p On i.CPros = p.CPros ] + ;
	[Left Join SigCdCli c1 On c1.ICLis = c.ContaDs ] + ;
	[Left Join SigCdCli c2 On c2.ICLis = p.IFors ] + ;
	[Left Join SigCdPsg sg On sg.CGruCods = p.CGrus + p.SGrus ] + ;
	[left join SigCdCol Co on p.colecoes = co.colecoes ] + ;
	[left join (select a.cpros, a.codtams, a.codcors, a.empos as emps, a.localizas as local, sum(qtde) as qtde ] + ;
	[from (Select a.cpros, a.codtams, a.codcors, a.empos, localizas, Count(1) As qtde From SigOpEtq A  ] + ;
	[left join (Select Cpros,Cgrus,Mercs,Colecoes,SGrus from SigCdPro) B on b.cpros = a.cpros ] + ;
	[Select a.cpros, '' as codtams, '' as codcors, a.emps, a.locals, sum(sqtds) as qtde From SigMvesl a, SigCdpro b, SigCdUni c ] + ;
oProg1.Update(.T.)
oProg1.Update(.T.)
		lcQuery = [Select * From SigCdEmp where Cemps= ']+_Empr+[' ]
		lcQuery = [Select * From SigCdPac]
		lcQuery = [Select Codigos, Descrs, GerGdmis From SigCdTom]
		Select Iif(GerGdmis = 1, 1, 0) as nMarcas, ;
		  From crSigCdTom a ;
		lcQuery = [Select Codigos, Descs From SigCdGpr]
		Select 1 as nMarcas, a.Codigos, ;
		  From crSigCdGpr a ;
		lcQuery = [Select Mercs, CGrus as Codigos, DGrus as Descs From SigCdGrp]
		Select 1 as nMarcas, a.Mercs, a.Codigos, ;
		  From crSigCdGrp a ;
		lcQuery = [Select Distinct a.Grupo as GruEmps, b.Tipos ] + ;
					[From SigCdEmp a, SigCdGre b ] + ;
				   		 [a.CEmps In (Select g.Emps From SigCdAce g Where g.Usuarios = '] + Usuar + [')]
UpDate crTpOpe Set nMarcas = 1
UpDate crTpOpe Set nMarcas = 0
UpDate crGrdGpr Set nMarcas = 1
UpDate crGrdGru Set nMarcas = 1
	Update crGrdGru Set nMarcas = crGrdGpr.nMarcas Where Mercs = crGrdGpr.Codigos
	Select crGrdGru
UpDate crGrdGpr Set nMarcas = 0 
UpDate crGrdGru Set nMarcas = 0 
UpDate crGrdGru Set nMarcas = 1 ;
 Where Mercs In (Select Codigos as Mercs From crGrdGpr Where nMarcas = 1)
	Select * From crGrdGpr Where Codigos = crGrdGru.Mercs Into Cursor crBus
UpDate crGrdGru Set nMarcas = 0 
Select CCodigos ;
  From crTpOpe ;
Select Codigos ;
  From crGrdGpr ;
	Select crPgRes01
	lcQuery = [Select Dopes From SigCdOpe Where Dopes = '] + crPgRes01.Movimentacao + [']
	Select TmpOpe
		lcQuery = [Select Dopps From SigCdOpd Where Dopps = '] + crPgRes01.Movimentacao + [']
		Select TmpOpe
Select crPgRes01
Select crPgRes01
Select crPgRes01

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPck.prg) - TRECHOS RELEVANTES PARA PASS SQL (2633 linhas total):

*-- Linhas 257 a 275:
257:     * de registros.
258:     *
259:     * As 3 grades sao ligadas a cursores PLACEHOLDER (estrutura final, sem
260:     * linhas) - regra #41 do CLAUDE.md: Column.ControlSource de cursor
261:     * inexistente derruba o Init. A populacao real via SQL (SigCdTom/
262:     * SigCdGpr/SigCdGrp) fica para fase posterior (CarregarFiltros() no BO
263:     * - ver cabecalho de SigOpPckBO.prg).
264:     *--------------------------------------------------------------------------
265:     PROTECTED PROCEDURE ConfigurarPaginaLista()
266:         LOCAL loc_oPag, loc_lAcessoPorTipo
267: 
268:         loc_oPag           = THIS.pgf_4c_Paginas.Page1
269:         loc_lAcessoPorTipo = THIS.this_oBusinessObject.this_lAcessoPorTipo
270: 
271:         THIS.CriarCursoresFiltroPlaceholder()
272: 
273:         *-- Faixa do cabecalho (legado: cntSombra) - regra #11, PRIMEIRO
274:         *-- AddObject da pagina. AddObject do filho e o WITH que configura
275:         *-- suas propriedades ficam FORA do WITH do container (regra #44 -

*-- Linhas 520 a 538:
520:             .FontName       = "Tahoma"
521:             .FontSize       = 8
522:             .AllowRowSizing = .F.
523:             .DeleteMark     = .F.
524:             .RecordMark     = .F.
525:             .GridLines      = 3
526:             .HeaderHeight   = 16
527:             .RowHeight      = 16
528:             .ScrollBars     = 2
529:             .TabStop        = .F.
530:             .Left           = 720
531:             .Top            = 426
532:             .Height         = 195
533:             .Width          = 323
534:             .ForeColor      = RGB(0, 0, 0)
535:             .GridLineColor  = RGB(238, 238, 238)
536:             .Themes         = .F.
537:             .Visible        = .T.
538:         ENDWITH

*-- Linhas 554 a 594:
554:             .Check1.Height    = 17
555:             .Check1.Width     = 17
556:             .CurrentControl  = "Check1"
557:             .ControlSource   = THIS.this_oBusinessObject.this_cCursorGrdGru + ".nMarcas"
558:             .Header1.Caption = ""
559:         ENDWITH
560: 
561:         WITH loc_oPag.grd_4c_GrdGru.Column2
562:             .FontName          = "Tahoma"
563:             .FontSize          = 8
564:             .Width             = 30
565:             .Movable           = .F.
566:             .Resizable         = .F.
567:             .ReadOnly          = .T.
568:             .ForeColor         = RGB(0, 0, 0)
569:             .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".Mercs"
570:             .Header1.Alignment = 2
571:             .Header1.Caption   = "Gde"
572:         ENDWITH
573: 
574:         WITH loc_oPag.grd_4c_GrdGru.Column3
575:             .FontName          = "Tahoma"
576:             .FontSize          = 8
577:             .Width             = 252
578:             .ForeColor         = RGB(0, 0, 0)
579:             .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".CDescricaos"
580:             .Header1.Alignment = 2
581:             .Header1.Caption   = "Grupo de Produto"
582:         ENDWITH
583: 
584:         loc_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
585:         THIS.ConfigurarBotaoMarcar(loc_oPag.cmd_4c_BtnMarGrp, 1046, 477, "Selecionar")
586: 
587:         loc_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
588:         THIS.ConfigurarBotaoDesmarcar(loc_oPag.cmd_4c_BtnDesGrp, 1046, 522, "Desmarcar")
589: 
590:         *-- CommandGroup de acao: Consultar / Sair (legado: cmgFiltros)
591:         loc_oPag.AddObject("obj_4c_CmgFiltros", "CommandGroup")
592:         WITH loc_oPag.obj_4c_CmgFiltros
593:             .ButtonCount   = 2
594:             .BackStyle     = 0

*-- Linhas 669 a 730:
669:     * linhas), os cursores que alimentam as 3 grades de filtro da Page1. A
670:     * populacao real via SQL (SigCdTom/SigCdGpr/SigCdGrp) fica para fase
671:     * posterior (CarregarFiltros() no BO) - sem o placeholder aqui, ligar
672:     * Column.ControlSource a um cursor inexistente derruba o Init (regra
673:     * #41 do CLAUDE.md).
674:     *--------------------------------------------------------------------------
675:     PROTECTED PROCEDURE CriarCursoresFiltroPlaceholder()
676:         LOCAL loc_cCursorTipos, loc_cCursorGrdGpr, loc_cCursorGrdGru
677: 
678:         loc_cCursorTipos  = THIS.this_oBusinessObject.this_cCursorTipos
679:         loc_cCursorGrdGpr = THIS.this_oBusinessObject.this_cCursorGrdGpr
680:         loc_cCursorGrdGru = THIS.this_oBusinessObject.this_cCursorGrdGru
681: 
682:         IF USED(loc_cCursorTipos)
683:             USE IN (loc_cCursorTipos)
684:         ENDIF
685:         CREATE CURSOR (loc_cCursorTipos) (nMarcas N(1,0), CCodigos C(2), CDescricaos C(50))
686: 
687:         IF USED(loc_cCursorGrdGpr)
688:             USE IN (loc_cCursorGrdGpr)
689:         ENDIF
690:         CREATE CURSOR (loc_cCursorGrdGpr) (nMarcas N(1,0), Codigos C(3), CDescricaos C(50))
691: 
692:         IF USED(loc_cCursorGrdGru)
693:             USE IN (loc_cCursorGrdGru)
694:         ENDIF
695:         CREATE CURSOR (loc_cCursorGrdGru) (nMarcas N(1,0), Mercs C(3), Codigos C(3), CDescricaos C(50))
696:     ENDPROC
697: 
698:     *--------------------------------------------------------------------------
699:     * ConfigurarGradeFiltro - Helper para as grades de filtro de 2 colunas
700:     * (Check + Descricao): Tipos de Operacao (grdTipo) e Grande Grupo
701:     * (grdMercs). Padrao canonico: Column1 = CheckBox ligado a "nMarcas"
702:     * (regra #18 - AddObject + CurrentControl + Sparse = .F.), Column2 =
703:     * descricao combinada codigo-descricao (ReadOnly). Referencia:
704:     * Formsigrepes.prg ConfigurarGrdP2.
705:     *--------------------------------------------------------------------------
706:     PROTECTED PROCEDURE ConfigurarGradeFiltro(par_oGrd, par_cCursor, par_nLeft, par_nTop, ;
707:             par_nHeight, par_nWidth, par_nCol2Width, par_cCaptionCol2)
708: 
709:         WITH par_oGrd
710:             .RecordSource   = par_cCursor
711:             .ColumnCount    = 2
712:             .FontName       = "Tahoma"
713:             .FontSize       = 8
714:             .AllowRowSizing = .F.
715:             .DeleteMark     = .F.
716:             .RecordMark     = .F.
717:             .GridLines      = 3
718:             .HeaderHeight   = 16
719:             .RowHeight      = 16
720:             .ScrollBars     = 2
721:             .TabStop        = .F.
722:             .Left           = par_nLeft
723:             .Top            = par_nTop
724:             .Height         = par_nHeight
725:             .Width          = par_nWidth
726:             .ForeColor      = RGB(0, 0, 0)
727:             .GridLineColor  = RGB(238, 238, 238)
728:             .Themes         = .F.
729:             .Visible        = .T.
730:         ENDWITH

*-- Linhas 748 a 778:
748:             .Check1.Height    = 17
749:             .Check1.Width     = 17
750:             .CurrentControl  = "Check1"
751:             .ControlSource   = par_cCursor + ".nMarcas"
752:             .Header1.Caption = ""
753:         ENDWITH
754: 
755:         WITH par_oGrd.Column2
756:             .FontName          = "Tahoma"
757:             .FontSize          = 8
758:             .Width             = par_nCol2Width
759:             .Movable           = .F.
760:             .Resizable         = .F.
761:             .ReadOnly          = .T.
762:             .ForeColor         = RGB(0, 0, 0)
763:             .ControlSource     = par_cCursor + ".CDescricaos"
764:             .Header1.Alignment = 2
765:             .Header1.Caption   = par_cCaptionCol2
766:         ENDWITH
767:     ENDPROC
768: 
769:     *--------------------------------------------------------------------------
770:     * ConfigurarBotaoMarcar / ConfigurarBotaoDesmarcar - Helpers para os
771:     * botoes "Selecionar"/"Desmarcar Tudo" ao lado de cada grade de filtro
772:     * (legado: btnMarca/btnMarGde/btnMarGrp e btnDesmarca/btnDesGde/
773:     * btnDesGrp - mesmo icone/propriedades nos 3 pares).
774:     *--------------------------------------------------------------------------
775:     PROTECTED PROCEDURE ConfigurarBotaoMarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
776:         WITH par_oBtn
777:             .Top         = par_nTop
778:             .Left        = par_nLeft

*-- Linhas 890 a 919:
890:     * ConfigurarPaginaDados - Monta a METADE INICIAL do conteudo da Page2
891:     * (pgDados): o PageFrame interno pgResults (legado, 1 pagina - pgRes01,
892:     * Caption "Detalhamento dos Produtos"), a grade de resultado
893:     * (grdDados1, 16 colunas - ControlSource transcrito EXATO do metodo
894:     * Processamento do legado, SigOpPck_form_codigo_fonte.txt:2509-2526;
895:     * Header/Width/cor de cada coluna do dump de propriedades, :1288-1390
896:     * e :1405-1780) e o painel de observacao do item (Say3/getObsItn) com
897:     * a imagem do produto (ImgFigJpg). A segunda metade (campo de busca,
898:     * botoes da pagina de resultado - btnRestaurar/btnProduto/cmdOperacao/
899:     * SubNiveis - e os botoes de Retornar/Visualizar/Excel/Imprimir do
900:     * nivel pgDados) fica para a fase seguinte.
901:     *
902:     * O cursor placeholder (cursor_4c_Dados) tem de existir ANTES do
903:     * ControlSource da grade ser atribuido - regra #41 do CLAUDE.md
904:     * (Column.ControlSource de cursor inexistente derruba o Init). A
905:     * populacao real via SQL (processamento dos movimentos filtrados)
906:     * fica para fase posterior (Processar() no BO).
907:     *--------------------------------------------------------------------------
908:     PROTECTED PROCEDURE ConfigurarPaginaDados()
909:         LOCAL loc_oPag, loc_cCursor
910: 
911:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
912:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
913: 
914:         THIS.CriarCursorDadosPlaceholder()
915: 
916:         *-- PageFrame interno (legado: pgResults, 1 pagina - pgRes01)
917:         loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
918:         WITH loc_oPag.pgf_4c_Resultados
919:             .Top       = 2

*-- Linhas 1221 a 1306:
1221:     * CriarCursorDadosPlaceholder - Cria, com a estrutura final (sem
1222:     * linhas), o cursor que alimenta a grade de resultado (grdDados1,
1223:     * legado: crPgRes01 - "Detalhamento dos Produtos"). Colunas EXATAS do
1224:     * Create Cursor do legado (SigOpPck_form_codigo_fonte.txt:2761-2770),
1225:     * na MESMA ordem - regra do CLAUDE.md sobre CREATE CURSOR repetido em
1226:     * mais de um local (aqui so ha este, mas a ordem tem de casar com as
1227:     * propriedades this_Res* do BO, que leem/escrevem por NOME de coluna
1228:     * via EVALUATE em CarregarDoCursor). A populacao real fica para fase
1229:     * posterior (Processar() no BO).
1230:     *--------------------------------------------------------------------------
1231:     PROTECTED PROCEDURE CriarCursorDadosPlaceholder()
1232:         LOCAL loc_cCursor
1233:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1234: 
1235:         IF USED(loc_cCursor)
1236:             USE IN (loc_cCursor)
1237:         ENDIF
1238: 
1239:         CREATE CURSOR (loc_cCursor) ( ;
1240:             Ordem C(1), Filtro N(1,0), Empresa C(3), Movimentacao C(20), Numero N(6,0), ;
1241:             Data_Venda D, Codigo_Vendedora C(10), Item N(10,0), Codigo_Item C(14), ;
1242:             Desc_Item C(40), Obs_Item M, Quantidade N(16,2), Val_Unitario N(16,2), ;
1243:             Total N(16,2), Total_Geral N(16,2), Moeda C(3), Operacao C(1), Barras N(14,0), ;
1244:             Gde_Grupo C(3), Grupo C(3), SubGrupo C(60), Custo_Cadastro N(16,2), ;
1245:             Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), Moe_Vda_Cadastro C(3), ;
1246:             Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), Nome_Cliente C(50), ;
1247:             Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), Ref_Fornecedor C(20), ;
1248:             Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), Parcelas N(3,0), ;
1249:             Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), CpfCli C(20), ;
1250:             Pedidoweb C(20), pStatus C(1), Dias N(5,0), Descritivo C(45), Local C(10), ;
1251:             Qtde N(12,0), Colecao C(60), Destino C(3), ContaOrigem C(10))
1252: 
1253:         *-- Tags EXATOS do legado (Load(), codigo_fonte.txt:2772-2775). Com
1254:         *-- Filtro/Perc_Diferenca sempre 0 nesta tela (regra de "diferenca"
1255:         *-- nao exercitada aqui), Ordem1/Ordem2 ficam sempre vazios e
1256:         *-- Ordem3 sempre com tudo - SigOpPckBO.MontarCursorDados() usa
1257:         *-- Ordem3 ao final do processamento (legado: Thisform.Filtros(1,3)).
1258:         SELECT (loc_cCursor)
1259:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1260:             FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
1261:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1262:             FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
1263:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1264:             FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3
1265:         INDEX ON Data_Venda TAG Ordem4
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * ConfigurarGrdDados - Grade de resultado "Detalhamento dos Produtos"
1270:     * (legado: grdDados1), 16 colunas SOMENTE LEITURA (legado:
1271:     * Movable/Resizable/ReadOnly = .F./.F./.T. para TODAS as colunas,
1272:     * codigo_fonte.txt:2495-2504 - via loop, aqui via SetAll). ControlSource
1273:     * de cada coluna transcrito EXATO do metodo Processamento do legado
1274:     * (:2509-2526); Width/Header de cada coluna do dump de propriedades
1275:     * (:1288-1390, :1405-1780).
1276:     *
1277:     * Column1 (header "Emp") liga em Destino, Column11 (header "Categoria")
1278:     * liga em Colecao e Column16 (header "Cole" + CHR(231) + CHR(227) +
1279:     * "o") liga em Subgrupo - parece trocado, mas eh exatamente o que o
1280:     * legado faz (ControlSource explicito no metodo Processamento) -
1281:     * TRANSCREVER, nao "corrigir" (regra #17 do CLAUDE.md).
1282:     *--------------------------------------------------------------------------
1283:     PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd, par_cCursor)
1284:         WITH par_oGrd
1285:             .RecordSource      = par_cCursor
1286:             .ColumnCount       = 16
1287:             .FontName          = "Tahoma"
1288:             .FontSize          = 7
1289:             .AllowHeaderSizing = .F.
1290:             .AllowRowSizing    = .F.
1291:             .DeleteMark        = .F.
1292:             .RecordMark        = .F.
1293:             .HeaderHeight      = 21
1294:             .RowHeight         = 15
1295:             .ScrollBars        = 3
1296:             .Left              = 4
1297:             .Top               = 320
1298:             .Width             = 1292
1299:             .Height            = 251
1300:             .GridLineColor     = RGB(238, 238, 238)
1301:             .Themes            = .F.
1302:             .Visible           = .T.
1303: 
1304:             *-- Negrito dinamico nas linhas cuja Ordem nao eh "A" (legado:
1305:             *-- MontaGrades, .SetAll([DynamicFontBold], [crPgRes01.Ordem
1306:             *-- <> 'A'], [Column])).

*-- Linhas 1317 a 1491:
1317: 
1318:         WITH par_oGrd.Column1
1319:             .Width               = 31
1320:             .ControlSource       = par_cCursor + ".Destino"
1321:             .Header1.Alignment   = 2
1322:             .Header1.FontBold    = .T.
1323:             .Header1.ForeColor   = RGB(90, 90, 90)
1324:             .Header1.Caption     = "Emp"
1325:         ENDWITH
1326: 
1327:         WITH par_oGrd.Column2
1328:             .Width               = 150
1329:             .ControlSource       = par_cCursor + ".Movimentacao"
1330:             .Header1.Alignment   = 2
1331:             .Header1.FontBold    = .T.
1332:             .Header1.ForeColor   = RGB(90, 90, 90)
1333:             .Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
1334:         ENDWITH
1335: 
1336:         WITH par_oGrd.Column3
1337:             .Width               = 55
1338:             .ControlSource       = par_cCursor + ".Numero"
1339:             .Header1.Alignment   = 2
1340:             .Header1.FontBold    = .T.
1341:             .Header1.ForeColor   = RGB(90, 90, 90)
1342:             .Header1.Caption     = "C" + CHR(243) + "digo"
1343:         ENDWITH
1344: 
1345:         WITH par_oGrd.Column4
1346:             .Width               = 71
1347:             .ControlSource       = "IIF(EMPTY(" + par_cCursor + ".Data_Venda), SPACE(10), DTOC(" + par_cCursor + ".Data_Venda))"
1348:             .Text1.Alignment     = 2
1349:             .Header1.Alignment   = 2
1350:             .Header1.FontBold    = .T.
1351:             .Header1.ForeColor   = RGB(90, 90, 90)
1352:             .Header1.Caption     = "Data"
1353:         ENDWITH
1354: 
1355:         WITH par_oGrd.Column5
1356:             .Width               = 150
1357:             .ControlSource       = par_cCursor + ".Pedidoweb"
1358:             .Header1.Alignment   = 2
1359:             .Header1.FontBold    = .T.
1360:             .Header1.ForeColor   = RGB(90, 90, 90)
1361:             .Header1.Caption     = "Pedido Web"
1362:         ENDWITH
1363: 
1364:         WITH par_oGrd.Column6
1365:             .Width               = 80
1366:             .ControlSource       = par_cCursor + ".Barras"
1367:             .Header1.Alignment   = 2
1368:             .Header1.FontBold    = .T.
1369:             .Header1.ForeColor   = RGB(90, 90, 90)
1370:             .Header1.Caption     = "Barra"
1371:         ENDWITH
1372: 
1373:         WITH par_oGrd.Column7
1374:             .Width                 = 110
1375:             .ControlSource         = par_cCursor + ".Codigo_Item"
1376:             .Text1.FontBold        = .T.
1377:             .Text1.FontUnderline   = .T.
1378:             .Text1.ForeColor       = RGB(0, 0, 255)
1379:             .Header1.Alignment     = 2
1380:             .Header1.FontBold      = .T.
1381:             .Header1.ForeColor     = RGB(90, 90, 90)
1382:             .Header1.Caption       = "Produto"
1383:         ENDWITH
1384: 
1385:         WITH par_oGrd.Column8
1386:             .Width               = 296
1387:             .ControlSource       = par_cCursor + ".Desc_Item"
1388:             .Header1.Alignment   = 2
1389:             .Header1.FontBold    = .T.
1390:             .Header1.ForeColor   = RGB(90, 90, 90)
1391:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1392:         ENDWITH
1393: 
1394:         WITH par_oGrd.Column9
1395:             .Width               = 35
1396:             .ControlSource       = par_cCursor + ".Cor"
1397:             .Header1.Alignment   = 2
1398:             .Header1.FontBold    = .T.
1399:             .Header1.ForeColor   = RGB(90, 90, 90)
1400:             .Header1.Caption     = "Cor"
1401:         ENDWITH
1402: 
1403:         *-- Coluna "Tam" eh clicavel no legado (FontBold/FontUnderline/
1404:         *-- ForeColor azul no proprio Column, nao no Text1 - dump confirma
1405:         *-- as propriedades no nivel da Column)
1406:         WITH par_oGrd.Column10
1407:             .Width               = 35
1408:             .FontBold            = .T.
1409:             .FontUnderline       = .T.
1410:             .Alignment           = 2
1411:             .ForeColor           = RGB(0, 0, 255)
1412:             .ControlSource       = par_cCursor + ".Tamanho"
1413:             .Header1.Alignment   = 2
1414:             .Header1.FontBold    = .T.
1415:             .Header1.ForeColor   = RGB(90, 90, 90)
1416:             .Header1.Caption     = "Tam"
1417:         ENDWITH
1418: 
1419:         WITH par_oGrd.Column11
1420:             .Width               = 213
1421:             .ControlSource       = par_cCursor + ".Colecao"
1422:             .Header1.Alignment   = 2
1423:             .Header1.FontBold    = .T.
1424:             .Header1.ForeColor   = RGB(90, 90, 90)
1425:             .Header1.Caption     = "Categoria"
1426:         ENDWITH
1427: 
1428:         WITH par_oGrd.Column12
1429:             .Width               = 60
1430:             .ControlSource       = par_cCursor + ".Local"
1431:             .Text1.Alignment     = 3
1432:             .Header1.Alignment   = 2
1433:             .Header1.FontBold    = .T.
1434:             .Header1.ForeColor   = RGB(90, 90, 90)
1435:             .Header1.Caption     = "Local"
1436:         ENDWITH
1437: 
1438:         WITH par_oGrd.Column13
1439:             .Width               = 60
1440:             .ControlSource       = par_cCursor + ".Qtde"
1441:             .Header1.Alignment   = 2
1442:             .Header1.FontBold    = .T.
1443:             .Header1.ForeColor   = RGB(90, 90, 90)
1444:             .Header1.Caption     = "Qtd. Local"
1445:         ENDWITH
1446: 
1447:         WITH par_oGrd.Column14
1448:             .Width               = 164
1449:             .ControlSource       = par_cCursor + ".Descritivo"
1450:             .Header1.Alignment   = 2
1451:             .Header1.FontBold    = .T.
1452:             .Header1.ForeColor   = RGB(90, 90, 90)
1453:             .Header1.Caption     = "Descritivo"
1454:         ENDWITH
1455: 
1456:         WITH par_oGrd.Column15
1457:             .Width               = 100
1458:             .ControlSource       = par_cCursor + ".Quantidade"
1459:             .Header1.Alignment   = 2
1460:             .Header1.FontBold    = .T.
1461:             .Header1.ForeColor   = RGB(90, 90, 90)
1462:             .Header1.Caption     = "Quantidade"
1463:         ENDWITH
1464: 
1465:         WITH par_oGrd.Column16
1466:             .Width               = 141
1467:             .ControlSource       = par_cCursor + ".Subgrupo"
1468:             .Text1.Alignment     = 2
1469:             .Header1.Alignment   = 2
1470:             .Header1.FontBold    = .T.
1471:             .Header1.ForeColor   = RGB(90, 90, 90)
1472:             .Header1.Caption     = "Cole" + CHR(231) + CHR(227) + "o"
1473:         ENDWITH
1474: 
1475:         *-- ORDEM de exibicao das colunas - vai por ULTIMO, depois de
1476:         *-- RecordSource/ControlSource/Width (mesma razao da Width: mexer na
1477:         *-- fonte do grid faz o VFP recalcular a ordem).
1478:         THIS.AplicarOrdemColunasDados(par_oGrd)
1479:     ENDPROC
1480: 
1481:     *--------------------------------------------------------------------------
1482:     * AplicarOrdemColunasDados - Ordem de exibicao das 16 colunas da grade
1483:     * de resultado, transcrita do SCX legado (Column<N>.ColumnOrder).
1484:     *
1485:     * ATENCAO: no SCX os SLOTS de coluna estao RENOMEADOS - o slot
1486:     * "Column16" tem Name = "Column10", o slot "Column10" tem Name =
1487:     * "Column11", etc. Os valores abaixo sao resolvidos pelo NOME de
1488:     * runtime (que eh o que .ColumnN alcanca em VFP9), nao pelo numero do
1489:     * slot: Column1=1, Column2=9, Column3=2, Column4=3, Column5=11,
1490:     * Column6=4, Column7=6, Column8=7, Column9=8, Column10=12,
1491:     * Column11=13, Column12=14, Column13=15, Column14=10, Column15=5,

*-- Linhas 1812 a 1893:
1812:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1813: 
1814:         IF USED(loc_cCursor)
1815:             UPDATE (loc_cCursor) SET nMarcas = 1
1816:             GO TOP IN (loc_cCursor)
1817:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1818:         ENDIF
1819:     ENDPROC
1820: 
1821:     PROCEDURE BtnDesmarcaClick()
1822:         LOCAL loc_cCursor
1823:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1824: 
1825:         IF USED(loc_cCursor)
1826:             UPDATE (loc_cCursor) SET nMarcas = 0
1827:             GO TOP IN (loc_cCursor)
1828:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1829:         ENDIF
1830:     ENDPROC
1831: 
1832:     *--------------------------------------------------------------------------
1833:     * BtnMarGdeClick / BtnDesGdeClick - Marcar/Desmarcar Tudo na grade de
1834:     * Grande Grupo (legado: btnMarGde.Click / btnDesGde.Click).
1835:     *--------------------------------------------------------------------------
1836:     PROCEDURE BtnMarGdeClick()
1837:         LOCAL loc_cCursor
1838:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1839: 
1840:         IF USED(loc_cCursor)
1841:             UPDATE (loc_cCursor) SET nMarcas = 1
1842:             GO TOP IN (loc_cCursor)
1843:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1844:         ENDIF
1845:     ENDPROC
1846: 
1847:     PROCEDURE BtnDesGdeClick()
1848:         LOCAL loc_cCursor
1849:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1850: 
1851:         IF USED(loc_cCursor)
1852:             UPDATE (loc_cCursor) SET nMarcas = 0
1853:             GO TOP IN (loc_cCursor)
1854:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1855:         ENDIF
1856:     ENDPROC
1857: 
1858:     *--------------------------------------------------------------------------
1859:     * BtnMarGrpClick / BtnDesGrpClick - Marcar/Desmarcar Tudo na grade de
1860:     * Grupo de Produto (legado: btnMarGrp.Click / btnDesGrp.Click).
1861:     *--------------------------------------------------------------------------
1862:     PROCEDURE BtnMarGrpClick()
1863:         LOCAL loc_cCursor
1864:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1865: 
1866:         IF USED(loc_cCursor)
1867:             UPDATE (loc_cCursor) SET nMarcas = 1
1868:             GO TOP IN (loc_cCursor)
1869:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1870:         ENDIF
1871:     ENDPROC
1872: 
1873:     PROCEDURE BtnDesGrpClick()
1874:         LOCAL loc_cCursor
1875:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1876: 
1877:         IF USED(loc_cCursor)
1878:             UPDATE (loc_cCursor) SET nMarcas = 0
1879:             GO TOP IN (loc_cCursor)
1880:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1881:         ENDIF
1882:     ENDPROC
1883: 
1884:     *--------------------------------------------------------------------------
1885:     * BtnConsultarClick - Valida o periodo informado (legado: cmgFiltros.
1886:     * Command1.Click) e processa os movimentos filtrados (legado:
1887:     * ThisForm.Processamento(), chamado apos as mesmas 3 validacoes de
1888:     * data). Com sucesso, segue para a pagina de Dados e repinta a grade
1889:     * de resultado (legado: ActivePage=2 + AfterRowColChange, codigo_
1890:     * fonte.txt:2729-2733).
1891:     *--------------------------------------------------------------------------
1892:     PROCEDURE BtnConsultarClick()
1893:         LOCAL loc_oPag, loc_dIni, loc_dFim

*-- Linhas 2058 a 2077:
2058:             USE IN cursor_4c_BuscaEmp
2059:         ENDIF
2060: 
2061:         loc_cSQL       = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodigo)
2062:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
2063: 
2064:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
2065:             loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2066:             loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2067:         ELSE
2068:             THIS.AbrirLookupEmpresa()
2069:         ENDIF
2070: 
2071:         IF USED("cursor_4c_BuscaEmp")
2072:             USE IN cursor_4c_BuscaEmp
2073:         ENDIF
2074: 
2075:         THIS.this_cUltimoValidarEmpOsLostFocusValidado = ALLTRIM(loc_oPag.txt_4c_EmpOs.Value)
2076:     ENDPROC
2077: 

*-- Linhas 2115 a 2133:
2115:                 ENDIF
2116: 
2117:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2118:                     SELECT cursor_4c_BuscaEmp
2119:                     loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2120:                     loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2121:                 ENDIF
2122: 
2123:                 loc_oBusca.Release()
2124:             ENDIF
2125: 
2126:             IF USED("cursor_4c_BuscaEmp")
2127:                 USE IN cursor_4c_BuscaEmp
2128:             ENDIF
2129:         CATCH TO loc_oErro
2130:             MsgErro(loc_oErro.Message, "Erro")
2131:         ENDTRY
2132: 
2133:         THIS.this_lEmLookupEmpresa = .F.

*-- Linhas 2165 a 2184:
2165:             USE IN cursor_4c_BuscaOpe
2166:         ENDIF
2167: 
2168:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo)
2169:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
2170: 
2171:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
2172:             loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2173:         ELSE
2174:             THIS.AbrirLookupOperacao()
2175:         ENDIF
2176: 
2177:         IF USED("cursor_4c_BuscaOpe")
2178:             USE IN cursor_4c_BuscaOpe
2179:         ENDIF
2180: 
2181:         THIS.this_cUltimoValidarOperacaoLostFocusValidado = ALLTRIM(loc_oPag.txt_4c_Operacao.Value)
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------

*-- Linhas 2218 a 2236:
2218:                 ENDIF
2219: 
2220:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2221:                     SELECT cursor_4c_BuscaOpe
2222:                     loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2223:                 ENDIF
2224: 
2225:                 loc_oBusca.Release()
2226:             ENDIF
2227: 
2228:             IF USED("cursor_4c_BuscaOpe")
2229:                 USE IN cursor_4c_BuscaOpe
2230:             ENDIF
2231:         CATCH TO loc_oErro
2232:             MsgErro(loc_oErro.Message, "Erro")
2233:         ENDTRY
2234: 
2235:         THIS.this_lEmLookupOperacao = .F.
2236:     ENDPROC

*-- Linhas 2289 a 2307:
2289:     *--------------------------------------------------------------------------
2290:     * GrdDadosAfterRowColChange - Espelha a linha corrente da grade de
2291:     * resultado nas propriedades this_Res* do BO (CarregarDoCursor) e
2292:     * atualiza o painel de observacao/imagem do item (legado: ControlSource
2293:     * direto de getObsItn/ImgFigJpg em crPgRes01, que se atualizava sozinho
2294:     * ao mudar de linha). Sem filtro de coluna, igual aos outros 11 dos 12
2295:     * handlers do projeto que usam AfterRowColChange para carregar detalhe
2296:     * da linha corrente (regra #46 do CLAUDE.md).
2297:     *--------------------------------------------------------------------------
2298:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2299:         THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
2300:         THIS.AtualizarDetalheItem()
2301:     ENDPROC
2302: 
2303:     *--------------------------------------------------------------------------
2304:     * AtualizarDetalheItem - Copia this_cResObsItem para o EditBox e decodifica
2305:     * this_cResImagem (base64, com os 3 prefixos data:image/... do legado) para
2306:     * um arquivo temporario, exibindo-o no Image (legado: ImgFigJpg.Click).
2307:     *--------------------------------------------------------------------------

*-- Linhas 2342 a 2360:
2342:             loc_nValor  = loc_oPagRes.txt_4c_Busca.Value
2343: 
2344:             IF loc_nValor > 0 AND USED(loc_cCursor)
2345:                 SELECT (loc_cCursor)
2346:                 GO TOP
2347:                 LOCATE FOR Numero = loc_nValor
2348:                 loc_oPagRes.grd_4c_Dados.Refresh()
2349: 
2350:                 IF par_nKeyCode = 13
2351:                     loc_oPagRes.grd_4c_Dados.Column3.SetFocus()
2352:                 ENDIF
2353:             ENDIF
2354:         ENDIF
2355:     ENDPROC
2356: 
2357:     *--------------------------------------------------------------------------
2358:     * BtnRestaurarClick - Restaura larguras/visibilidade das colunas da
2359:     * grade de resultado para o padrao do legado e REGRAVA o layout
2360:     * (legado: btnRestaurar.Click = If MessageBox(...) = 6 / GradePadrao() /

*-- Linhas 2431 a 2468:
2431:             USE IN cursor_4c_TmpOpe
2432:         ENDIF
2433: 
2434:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cMovimentacao)
2435:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2436: 
2437:         IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2438:             IF USED("cursor_4c_TmpOpe")
2439:                 USE IN cursor_4c_TmpOpe
2440:             ENDIF
2441: 
2442:             GarantirClasse("FormSigMvExp")
2443:             loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2444:             IF VARTYPE(loc_oForm) = "O"
2445:                 loc_oForm.Show()
2446:             ENDIF
2447:         ELSE
2448:             IF USED("cursor_4c_TmpOpe")
2449:                 USE IN cursor_4c_TmpOpe
2450:             ENDIF
2451: 
2452:             loc_cSQL       = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cMovimentacao)
2453:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2454: 
2455:             IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2456:                 GarantirClasse("FormSigMvPdt")
2457:                 loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2458:                 IF VARTYPE(loc_oForm) = "O"
2459:                     loc_oForm.Show()
2460:                 ENDIF
2461:             ENDIF
2462: 
2463:             IF USED("cursor_4c_TmpOpe")
2464:                 USE IN cursor_4c_TmpOpe
2465:             ENDIF
2466:         ENDIF
2467:     ENDPROC
2468: 

*-- Linhas 2548 a 2566:
2548:             RETURN
2549:         ENDIF
2550: 
2551:         SELECT (loc_cCursor)
2552: 
2553:         *-- O legado reindexa SO no Visualizar (btnVisualizar.Click = Index
2554:         *-- on SubGrupo + Codigo_Item Tag Ordem1 + Go Top + Report Form ...
2555:         *-- Preview); o Imprimir (BtnImprimir.Click) faz apenas Go Top +
2556:         *-- Report Form ... To PRINTER Prompt, mantendo a ordem corrente
2557:         *-- (Ordem3, posta por SigOpPckBO.MontarCursorDados). Reindexar nos
2558:         *-- dois mudaria a ordem do relatorio IMPRESSO.
2559:         IF par_cModo = "PREVIEW"
2560:             INDEX ON SubGrupo + Codigo_Item TAG Ordem1
2561:         ENDIF
2562: 
2563:         GO TOP
2564: 
2565:         loc_cPointAnt     = SET("POINT")
2566:         loc_cSeparatorAnt = SET("SEPARATOR")

*-- Linhas 2587 a 2630:
2587: 
2588:     *--------------------------------------------------------------------------
2589:     * GerarXLS - Exporta o cursor de resultado para planilha XLS (legado:
2590:     * ThisForm.GerarXLS() = PutFile + Select ... Order By ... Into Cursor
2591:     * crExcel + Copy To ... Type Xl5).
2592:     *--------------------------------------------------------------------------
2593:     PROCEDURE GerarXLS()
2594:         LOCAL loc_cCursor, loc_cArquivo
2595: 
2596:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2597: 
2598:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
2599:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", ;
2600:                 "Exporta" + CHR(231) + CHR(227) + "o")
2601:             RETURN
2602:         ENDIF
2603: 
2604:         loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")
2605: 
2606:         IF !EMPTY(loc_cArquivo)
2607:             IF USED("cursor_4c_Excel")
2608:                 USE IN cursor_4c_Excel
2609:             ENDIF
2610: 
2611:             SELECT * FROM (loc_cCursor) ;
2612:                 ORDER BY Destino, Ordem, Data_Venda, Movimentacao, Numero ;
2613:                 INTO CURSOR cursor_4c_Excel
2614: 
2615:             SELECT cursor_4c_Excel
2616:             COPY TO (loc_cArquivo) TYPE XL5
2617:             USE IN cursor_4c_Excel
2618: 
2619:             MsgInfo('O Arquivo "' + ALLTRIM(loc_cArquivo) + '" Foi Gerado!!!', ;
2620:                 "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
2621:         ENDIF
2622:     ENDPROC
2623: 
2624:     *--------------------------------------------------------------------------
2625:     * Destroy - this_oBusinessObject e o restauro do menu ja sao tratados em
2626:     * FormBase.Destroy(); DODEFAULT() tem de ser a ULTIMA linha (regra do
2627:     * fix menu-shrinks, Erro58).
2628:     *--------------------------------------------------------------------------
2629:     PROCEDURE Destroy()
2630:         DODEFAULT()

