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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpPck.prg) - TRECHOS RELEVANTES PARA PASS SQL (2605 linhas total):

*-- Linhas 247 a 265:
247:     * de registros.
248:     *
249:     * As 3 grades sao ligadas a cursores PLACEHOLDER (estrutura final, sem
250:     * linhas) - regra #41 do CLAUDE.md: Column.ControlSource de cursor
251:     * inexistente derruba o Init. A populacao real via SQL (SigCdTom/
252:     * SigCdGpr/SigCdGrp) fica para fase posterior (CarregarFiltros() no BO
253:     * - ver cabecalho de SigOpPckBO.prg).
254:     *--------------------------------------------------------------------------
255:     PROTECTED PROCEDURE ConfigurarPaginaLista()
256:         LOCAL loc_oPag, loc_lAcessoPorTipo
257: 
258:         loc_oPag           = THIS.pgf_4c_Paginas.Page1
259:         loc_lAcessoPorTipo = THIS.this_oBusinessObject.this_lAcessoPorTipo
260: 
261:         THIS.CriarCursoresFiltroPlaceholder()
262: 
263:         *-- Faixa do cabecalho (legado: cntSombra) - regra #11, PRIMEIRO
264:         *-- AddObject da pagina. AddObject do filho e o WITH que configura
265:         *-- suas propriedades ficam FORA do WITH do container (regra #44 -

*-- Linhas 510 a 528:
510:             .FontName       = "Tahoma"
511:             .FontSize       = 8
512:             .AllowRowSizing = .F.
513:             .DeleteMark     = .F.
514:             .RecordMark     = .F.
515:             .GridLines      = 3
516:             .HeaderHeight   = 16
517:             .RowHeight      = 16
518:             .ScrollBars     = 2
519:             .TabStop        = .F.
520:             .Left           = 720
521:             .Top            = 426
522:             .Height         = 195
523:             .Width          = 323
524:             .ForeColor      = RGB(0, 0, 0)
525:             .GridLineColor  = RGB(238, 238, 238)
526:             .Themes         = .F.
527:             .Visible        = .T.
528:         ENDWITH

*-- Linhas 544 a 584:
544:             .Check1.Height    = 17
545:             .Check1.Width     = 17
546:             .CurrentControl  = "Check1"
547:             .ControlSource   = THIS.this_oBusinessObject.this_cCursorGrdGru + ".nMarcas"
548:             .Header1.Caption = ""
549:         ENDWITH
550: 
551:         WITH loc_oPag.grd_4c_GrdGru.Column2
552:             .FontName          = "Tahoma"
553:             .FontSize          = 8
554:             .Width             = 30
555:             .Movable           = .F.
556:             .Resizable         = .F.
557:             .ReadOnly          = .T.
558:             .ForeColor         = RGB(0, 0, 0)
559:             .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".Mercs"
560:             .Header1.Alignment = 2
561:             .Header1.Caption   = "Gde"
562:         ENDWITH
563: 
564:         WITH loc_oPag.grd_4c_GrdGru.Column3
565:             .FontName          = "Tahoma"
566:             .FontSize          = 8
567:             .Width             = 252
568:             .ForeColor         = RGB(0, 0, 0)
569:             .ControlSource     = THIS.this_oBusinessObject.this_cCursorGrdGru + ".CDescricaos"
570:             .Header1.Alignment = 2
571:             .Header1.Caption   = "Grupo de Produto"
572:         ENDWITH
573: 
574:         loc_oPag.AddObject("cmd_4c_BtnMarGrp", "CommandButton")
575:         THIS.ConfigurarBotaoMarcar(loc_oPag.cmd_4c_BtnMarGrp, 1046, 477, "Selecionar")
576: 
577:         loc_oPag.AddObject("cmd_4c_BtnDesGrp", "CommandButton")
578:         THIS.ConfigurarBotaoDesmarcar(loc_oPag.cmd_4c_BtnDesGrp, 1046, 522, "Desmarcar")
579: 
580:         *-- CommandGroup de acao: Consultar / Sair (legado: cmgFiltros)
581:         loc_oPag.AddObject("obj_4c_CmgFiltros", "CommandGroup")
582:         WITH loc_oPag.obj_4c_CmgFiltros
583:             .ButtonCount   = 2
584:             .BackStyle     = 0

*-- Linhas 659 a 720:
659:     * linhas), os cursores que alimentam as 3 grades de filtro da Page1. A
660:     * populacao real via SQL (SigCdTom/SigCdGpr/SigCdGrp) fica para fase
661:     * posterior (CarregarFiltros() no BO) - sem o placeholder aqui, ligar
662:     * Column.ControlSource a um cursor inexistente derruba o Init (regra
663:     * #41 do CLAUDE.md).
664:     *--------------------------------------------------------------------------
665:     PROTECTED PROCEDURE CriarCursoresFiltroPlaceholder()
666:         LOCAL loc_cCursorTipos, loc_cCursorGrdGpr, loc_cCursorGrdGru
667: 
668:         loc_cCursorTipos  = THIS.this_oBusinessObject.this_cCursorTipos
669:         loc_cCursorGrdGpr = THIS.this_oBusinessObject.this_cCursorGrdGpr
670:         loc_cCursorGrdGru = THIS.this_oBusinessObject.this_cCursorGrdGru
671: 
672:         IF USED(loc_cCursorTipos)
673:             USE IN (loc_cCursorTipos)
674:         ENDIF
675:         CREATE CURSOR (loc_cCursorTipos) (nMarcas N(1,0), CCodigos C(2), CDescricaos C(50))
676: 
677:         IF USED(loc_cCursorGrdGpr)
678:             USE IN (loc_cCursorGrdGpr)
679:         ENDIF
680:         CREATE CURSOR (loc_cCursorGrdGpr) (nMarcas N(1,0), Codigos C(3), CDescricaos C(50))
681: 
682:         IF USED(loc_cCursorGrdGru)
683:             USE IN (loc_cCursorGrdGru)
684:         ENDIF
685:         CREATE CURSOR (loc_cCursorGrdGru) (nMarcas N(1,0), Mercs C(3), Codigos C(3), CDescricaos C(50))
686:     ENDPROC
687: 
688:     *--------------------------------------------------------------------------
689:     * ConfigurarGradeFiltro - Helper para as grades de filtro de 2 colunas
690:     * (Check + Descricao): Tipos de Operacao (grdTipo) e Grande Grupo
691:     * (grdMercs). Padrao canonico: Column1 = CheckBox ligado a "nMarcas"
692:     * (regra #18 - AddObject + CurrentControl + Sparse = .F.), Column2 =
693:     * descricao combinada codigo-descricao (ReadOnly). Referencia:
694:     * Formsigrepes.prg ConfigurarGrdP2.
695:     *--------------------------------------------------------------------------
696:     PROTECTED PROCEDURE ConfigurarGradeFiltro(par_oGrd, par_cCursor, par_nLeft, par_nTop, ;
697:             par_nHeight, par_nWidth, par_nCol2Width, par_cCaptionCol2)
698: 
699:         WITH par_oGrd
700:             .RecordSource   = par_cCursor
701:             .ColumnCount    = 2
702:             .FontName       = "Tahoma"
703:             .FontSize       = 8
704:             .AllowRowSizing = .F.
705:             .DeleteMark     = .F.
706:             .RecordMark     = .F.
707:             .GridLines      = 3
708:             .HeaderHeight   = 16
709:             .RowHeight      = 16
710:             .ScrollBars     = 2
711:             .TabStop        = .F.
712:             .Left           = par_nLeft
713:             .Top            = par_nTop
714:             .Height         = par_nHeight
715:             .Width          = par_nWidth
716:             .ForeColor      = RGB(0, 0, 0)
717:             .GridLineColor  = RGB(238, 238, 238)
718:             .Themes         = .F.
719:             .Visible        = .T.
720:         ENDWITH

*-- Linhas 738 a 768:
738:             .Check1.Height    = 17
739:             .Check1.Width     = 17
740:             .CurrentControl  = "Check1"
741:             .ControlSource   = par_cCursor + ".nMarcas"
742:             .Header1.Caption = ""
743:         ENDWITH
744: 
745:         WITH par_oGrd.Column2
746:             .FontName          = "Tahoma"
747:             .FontSize          = 8
748:             .Width             = par_nCol2Width
749:             .Movable           = .F.
750:             .Resizable         = .F.
751:             .ReadOnly          = .T.
752:             .ForeColor         = RGB(0, 0, 0)
753:             .ControlSource     = par_cCursor + ".CDescricaos"
754:             .Header1.Alignment = 2
755:             .Header1.Caption   = par_cCaptionCol2
756:         ENDWITH
757:     ENDPROC
758: 
759:     *--------------------------------------------------------------------------
760:     * ConfigurarBotaoMarcar / ConfigurarBotaoDesmarcar - Helpers para os
761:     * botoes "Selecionar"/"Desmarcar Tudo" ao lado de cada grade de filtro
762:     * (legado: btnMarca/btnMarGde/btnMarGrp e btnDesmarca/btnDesGde/
763:     * btnDesGrp - mesmo icone/propriedades nos 3 pares).
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE ConfigurarBotaoMarcar(par_oBtn, par_nLeft, par_nTop, par_cToolTip)
766:         WITH par_oBtn
767:             .Top         = par_nTop
768:             .Left        = par_nLeft

*-- Linhas 880 a 909:
880:     * ConfigurarPaginaDados - Monta a METADE INICIAL do conteudo da Page2
881:     * (pgDados): o PageFrame interno pgResults (legado, 1 pagina - pgRes01,
882:     * Caption "Detalhamento dos Produtos"), a grade de resultado
883:     * (grdDados1, 16 colunas - ControlSource transcrito EXATO do metodo
884:     * Processamento do legado, SigOpPck_form_codigo_fonte.txt:2509-2526;
885:     * Header/Width/cor de cada coluna do dump de propriedades, :1288-1390
886:     * e :1405-1780) e o painel de observacao do item (Say3/getObsItn) com
887:     * a imagem do produto (ImgFigJpg). A segunda metade (campo de busca,
888:     * botoes da pagina de resultado - btnRestaurar/btnProduto/cmdOperacao/
889:     * SubNiveis - e os botoes de Retornar/Visualizar/Excel/Imprimir do
890:     * nivel pgDados) fica para a fase seguinte.
891:     *
892:     * O cursor placeholder (cursor_4c_Dados) tem de existir ANTES do
893:     * ControlSource da grade ser atribuido - regra #41 do CLAUDE.md
894:     * (Column.ControlSource de cursor inexistente derruba o Init). A
895:     * populacao real via SQL (processamento dos movimentos filtrados)
896:     * fica para fase posterior (Processar() no BO).
897:     *--------------------------------------------------------------------------
898:     PROTECTED PROCEDURE ConfigurarPaginaDados()
899:         LOCAL loc_oPag, loc_cCursor
900: 
901:         loc_oPag    = THIS.pgf_4c_Paginas.Page2
902:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
903: 
904:         THIS.CriarCursorDadosPlaceholder()
905: 
906:         *-- PageFrame interno (legado: pgResults, 1 pagina - pgRes01)
907:         loc_oPag.AddObject("pgf_4c_Resultados", "PageFrame")
908:         WITH loc_oPag.pgf_4c_Resultados
909:             .Top       = 2

*-- Linhas 1211 a 1296:
1211:     * CriarCursorDadosPlaceholder - Cria, com a estrutura final (sem
1212:     * linhas), o cursor que alimenta a grade de resultado (grdDados1,
1213:     * legado: crPgRes01 - "Detalhamento dos Produtos"). Colunas EXATAS do
1214:     * Create Cursor do legado (SigOpPck_form_codigo_fonte.txt:2761-2770),
1215:     * na MESMA ordem - regra do CLAUDE.md sobre CREATE CURSOR repetido em
1216:     * mais de um local (aqui so ha este, mas a ordem tem de casar com as
1217:     * propriedades this_Res* do BO, que leem/escrevem por NOME de coluna
1218:     * via EVALUATE em CarregarDoCursor). A populacao real fica para fase
1219:     * posterior (Processar() no BO).
1220:     *--------------------------------------------------------------------------
1221:     PROTECTED PROCEDURE CriarCursorDadosPlaceholder()
1222:         LOCAL loc_cCursor
1223:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
1224: 
1225:         IF USED(loc_cCursor)
1226:             USE IN (loc_cCursor)
1227:         ENDIF
1228: 
1229:         CREATE CURSOR (loc_cCursor) ( ;
1230:             Ordem C(1), Filtro N(1,0), Empresa C(3), Movimentacao C(20), Numero N(6,0), ;
1231:             Data_Venda D, Codigo_Vendedora C(10), Item N(10,0), Codigo_Item C(14), ;
1232:             Desc_Item C(40), Obs_Item M, Quantidade N(16,2), Val_Unitario N(16,2), ;
1233:             Total N(16,2), Total_Geral N(16,2), Moeda C(3), Operacao C(1), Barras N(14,0), ;
1234:             Gde_Grupo C(3), Grupo C(3), SubGrupo C(60), Custo_Cadastro N(16,2), ;
1235:             Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), Moe_Vda_Cadastro C(3), ;
1236:             Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), Nome_Cliente C(50), ;
1237:             Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), Ref_Fornecedor C(20), ;
1238:             Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), Parcelas N(3,0), ;
1239:             Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), CpfCli C(20), ;
1240:             Pedidoweb C(20), pStatus C(1), Dias N(5,0), Descritivo C(45), Local C(10), ;
1241:             Qtde N(12,0), Colecao C(60), Destino C(3), ContaOrigem C(10))
1242: 
1243:         *-- Tags EXATOS do legado (Load(), codigo_fonte.txt:2772-2775). Com
1244:         *-- Filtro/Perc_Diferenca sempre 0 nesta tela (regra de "diferenca"
1245:         *-- nao exercitada aqui), Ordem1/Ordem2 ficam sempre vazios e
1246:         *-- Ordem3 sempre com tudo - SigOpPckBO.MontarCursorDados() usa
1247:         *-- Ordem3 ao final do processamento (legado: Thisform.Filtros(1,3)).
1248:         SELECT (loc_cCursor)
1249:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1250:             FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
1251:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1252:             FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
1253:         INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
1254:             FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3
1255:         INDEX ON Data_Venda TAG Ordem4
1256:     ENDPROC
1257: 
1258:     *--------------------------------------------------------------------------
1259:     * ConfigurarGrdDados - Grade de resultado "Detalhamento dos Produtos"
1260:     * (legado: grdDados1), 16 colunas SOMENTE LEITURA (legado:
1261:     * Movable/Resizable/ReadOnly = .F./.F./.T. para TODAS as colunas,
1262:     * codigo_fonte.txt:2495-2504 - via loop, aqui via SetAll). ControlSource
1263:     * de cada coluna transcrito EXATO do metodo Processamento do legado
1264:     * (:2509-2526); Width/Header de cada coluna do dump de propriedades
1265:     * (:1288-1390, :1405-1780).
1266:     *
1267:     * Column1 (header "Emp") liga em Destino, Column11 (header "Categoria")
1268:     * liga em Colecao e Column16 (header "Cole" + CHR(231) + CHR(227) +
1269:     * "o") liga em Subgrupo - parece trocado, mas eh exatamente o que o
1270:     * legado faz (ControlSource explicito no metodo Processamento) -
1271:     * TRANSCREVER, nao "corrigir" (regra #17 do CLAUDE.md).
1272:     *--------------------------------------------------------------------------
1273:     PROTECTED PROCEDURE ConfigurarGrdDados(par_oGrd, par_cCursor)
1274:         WITH par_oGrd
1275:             .RecordSource      = par_cCursor
1276:             .ColumnCount       = 16
1277:             .FontName          = "Tahoma"
1278:             .FontSize          = 7
1279:             .AllowHeaderSizing = .F.
1280:             .AllowRowSizing    = .F.
1281:             .DeleteMark        = .F.
1282:             .RecordMark        = .F.
1283:             .HeaderHeight      = 21
1284:             .RowHeight         = 15
1285:             .ScrollBars        = 3
1286:             .Left              = 4
1287:             .Top               = 320
1288:             .Width             = 1292
1289:             .Height            = 251
1290:             .GridLineColor     = RGB(238, 238, 238)
1291:             .Themes            = .F.
1292:             .Visible           = .T.
1293: 
1294:             *-- Negrito dinamico nas linhas cuja Ordem nao eh "A" (legado:
1295:             *-- MontaGrades, .SetAll([DynamicFontBold], [crPgRes01.Ordem
1296:             *-- <> 'A'], [Column])).

*-- Linhas 1307 a 1481:
1307: 
1308:         WITH par_oGrd.Column1
1309:             .Width               = 31
1310:             .ControlSource       = par_cCursor + ".Destino"
1311:             .Header1.Alignment   = 2
1312:             .Header1.FontBold    = .T.
1313:             .Header1.ForeColor   = RGB(90, 90, 90)
1314:             .Header1.Caption     = "Emp"
1315:         ENDWITH
1316: 
1317:         WITH par_oGrd.Column2
1318:             .Width               = 150
1319:             .ControlSource       = par_cCursor + ".Movimentacao"
1320:             .Header1.Alignment   = 2
1321:             .Header1.FontBold    = .T.
1322:             .Header1.ForeColor   = RGB(90, 90, 90)
1323:             .Header1.Caption     = "Movimenta" + CHR(231) + CHR(227) + "o"
1324:         ENDWITH
1325: 
1326:         WITH par_oGrd.Column3
1327:             .Width               = 55
1328:             .ControlSource       = par_cCursor + ".Numero"
1329:             .Header1.Alignment   = 2
1330:             .Header1.FontBold    = .T.
1331:             .Header1.ForeColor   = RGB(90, 90, 90)
1332:             .Header1.Caption     = "C" + CHR(243) + "digo"
1333:         ENDWITH
1334: 
1335:         WITH par_oGrd.Column4
1336:             .Width               = 71
1337:             .ControlSource       = "IIF(EMPTY(" + par_cCursor + ".Data_Venda), SPACE(10), DTOC(" + par_cCursor + ".Data_Venda))"
1338:             .Text1.Alignment     = 2
1339:             .Header1.Alignment   = 2
1340:             .Header1.FontBold    = .T.
1341:             .Header1.ForeColor   = RGB(90, 90, 90)
1342:             .Header1.Caption     = "Data"
1343:         ENDWITH
1344: 
1345:         WITH par_oGrd.Column5
1346:             .Width               = 150
1347:             .ControlSource       = par_cCursor + ".Pedidoweb"
1348:             .Header1.Alignment   = 2
1349:             .Header1.FontBold    = .T.
1350:             .Header1.ForeColor   = RGB(90, 90, 90)
1351:             .Header1.Caption     = "Pedido Web"
1352:         ENDWITH
1353: 
1354:         WITH par_oGrd.Column6
1355:             .Width               = 80
1356:             .ControlSource       = par_cCursor + ".Barras"
1357:             .Header1.Alignment   = 2
1358:             .Header1.FontBold    = .T.
1359:             .Header1.ForeColor   = RGB(90, 90, 90)
1360:             .Header1.Caption     = "Barra"
1361:         ENDWITH
1362: 
1363:         WITH par_oGrd.Column7
1364:             .Width                 = 110
1365:             .ControlSource         = par_cCursor + ".Codigo_Item"
1366:             .Text1.FontBold        = .T.
1367:             .Text1.FontUnderline   = .T.
1368:             .Text1.ForeColor       = RGB(0, 0, 255)
1369:             .Header1.Alignment     = 2
1370:             .Header1.FontBold      = .T.
1371:             .Header1.ForeColor     = RGB(90, 90, 90)
1372:             .Header1.Caption       = "Produto"
1373:         ENDWITH
1374: 
1375:         WITH par_oGrd.Column8
1376:             .Width               = 296
1377:             .ControlSource       = par_cCursor + ".Desc_Item"
1378:             .Header1.Alignment   = 2
1379:             .Header1.FontBold    = .T.
1380:             .Header1.ForeColor   = RGB(90, 90, 90)
1381:             .Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o do Produto"
1382:         ENDWITH
1383: 
1384:         WITH par_oGrd.Column9
1385:             .Width               = 35
1386:             .ControlSource       = par_cCursor + ".Cor"
1387:             .Header1.Alignment   = 2
1388:             .Header1.FontBold    = .T.
1389:             .Header1.ForeColor   = RGB(90, 90, 90)
1390:             .Header1.Caption     = "Cor"
1391:         ENDWITH
1392: 
1393:         *-- Coluna "Tam" eh clicavel no legado (FontBold/FontUnderline/
1394:         *-- ForeColor azul no proprio Column, nao no Text1 - dump confirma
1395:         *-- as propriedades no nivel da Column)
1396:         WITH par_oGrd.Column10
1397:             .Width               = 35
1398:             .FontBold            = .T.
1399:             .FontUnderline       = .T.
1400:             .Alignment           = 2
1401:             .ForeColor           = RGB(0, 0, 255)
1402:             .ControlSource       = par_cCursor + ".Tamanho"
1403:             .Header1.Alignment   = 2
1404:             .Header1.FontBold    = .T.
1405:             .Header1.ForeColor   = RGB(90, 90, 90)
1406:             .Header1.Caption     = "Tam"
1407:         ENDWITH
1408: 
1409:         WITH par_oGrd.Column11
1410:             .Width               = 213
1411:             .ControlSource       = par_cCursor + ".Colecao"
1412:             .Header1.Alignment   = 2
1413:             .Header1.FontBold    = .T.
1414:             .Header1.ForeColor   = RGB(90, 90, 90)
1415:             .Header1.Caption     = "Categoria"
1416:         ENDWITH
1417: 
1418:         WITH par_oGrd.Column12
1419:             .Width               = 60
1420:             .ControlSource       = par_cCursor + ".Local"
1421:             .Text1.Alignment     = 3
1422:             .Header1.Alignment   = 2
1423:             .Header1.FontBold    = .T.
1424:             .Header1.ForeColor   = RGB(90, 90, 90)
1425:             .Header1.Caption     = "Local"
1426:         ENDWITH
1427: 
1428:         WITH par_oGrd.Column13
1429:             .Width               = 60
1430:             .ControlSource       = par_cCursor + ".Qtde"
1431:             .Header1.Alignment   = 2
1432:             .Header1.FontBold    = .T.
1433:             .Header1.ForeColor   = RGB(90, 90, 90)
1434:             .Header1.Caption     = "Qtd. Local"
1435:         ENDWITH
1436: 
1437:         WITH par_oGrd.Column14
1438:             .Width               = 164
1439:             .ControlSource       = par_cCursor + ".Descritivo"
1440:             .Header1.Alignment   = 2
1441:             .Header1.FontBold    = .T.
1442:             .Header1.ForeColor   = RGB(90, 90, 90)
1443:             .Header1.Caption     = "Descritivo"
1444:         ENDWITH
1445: 
1446:         WITH par_oGrd.Column15
1447:             .Width               = 100
1448:             .ControlSource       = par_cCursor + ".Quantidade"
1449:             .Header1.Alignment   = 2
1450:             .Header1.FontBold    = .T.
1451:             .Header1.ForeColor   = RGB(90, 90, 90)
1452:             .Header1.Caption     = "Quantidade"
1453:         ENDWITH
1454: 
1455:         WITH par_oGrd.Column16
1456:             .Width               = 141
1457:             .ControlSource       = par_cCursor + ".Subgrupo"
1458:             .Text1.Alignment     = 2
1459:             .Header1.Alignment   = 2
1460:             .Header1.FontBold    = .T.
1461:             .Header1.ForeColor   = RGB(90, 90, 90)
1462:             .Header1.Caption     = "Cole" + CHR(231) + CHR(227) + "o"
1463:         ENDWITH
1464: 
1465:         *-- ORDEM de exibicao das colunas - vai por ULTIMO, depois de
1466:         *-- RecordSource/ControlSource/Width (mesma razao da Width: mexer na
1467:         *-- fonte do grid faz o VFP recalcular a ordem).
1468:         THIS.AplicarOrdemColunasDados(par_oGrd)
1469:     ENDPROC
1470: 
1471:     *--------------------------------------------------------------------------
1472:     * AplicarOrdemColunasDados - Ordem de exibicao das 16 colunas da grade
1473:     * de resultado, transcrita do SCX legado (Column<N>.ColumnOrder).
1474:     *
1475:     * ATENCAO: no SCX os SLOTS de coluna estao RENOMEADOS - o slot
1476:     * "Column16" tem Name = "Column10", o slot "Column10" tem Name =
1477:     * "Column11", etc. Os valores abaixo sao resolvidos pelo NOME de
1478:     * runtime (que eh o que .ColumnN alcanca em VFP9), nao pelo numero do
1479:     * slot: Column1=1, Column2=9, Column3=2, Column4=3, Column5=11,
1480:     * Column6=4, Column7=6, Column8=7, Column9=8, Column10=12,
1481:     * Column11=13, Column12=14, Column13=15, Column14=10, Column15=5,

*-- Linhas 1802 a 1883:
1802:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1803: 
1804:         IF USED(loc_cCursor)
1805:             UPDATE (loc_cCursor) SET nMarcas = 1
1806:             GO TOP IN (loc_cCursor)
1807:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1808:         ENDIF
1809:     ENDPROC
1810: 
1811:     PROCEDURE BtnDesmarcaClick()
1812:         LOCAL loc_cCursor
1813:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorTipos
1814: 
1815:         IF USED(loc_cCursor)
1816:             UPDATE (loc_cCursor) SET nMarcas = 0
1817:             GO TOP IN (loc_cCursor)
1818:             THIS.pgf_4c_Paginas.Page1.grd_4c_Tipo.Refresh()
1819:         ENDIF
1820:     ENDPROC
1821: 
1822:     *--------------------------------------------------------------------------
1823:     * BtnMarGdeClick / BtnDesGdeClick - Marcar/Desmarcar Tudo na grade de
1824:     * Grande Grupo (legado: btnMarGde.Click / btnDesGde.Click).
1825:     *--------------------------------------------------------------------------
1826:     PROCEDURE BtnMarGdeClick()
1827:         LOCAL loc_cCursor
1828:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1829: 
1830:         IF USED(loc_cCursor)
1831:             UPDATE (loc_cCursor) SET nMarcas = 1
1832:             GO TOP IN (loc_cCursor)
1833:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1834:         ENDIF
1835:     ENDPROC
1836: 
1837:     PROCEDURE BtnDesGdeClick()
1838:         LOCAL loc_cCursor
1839:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGpr
1840: 
1841:         IF USED(loc_cCursor)
1842:             UPDATE (loc_cCursor) SET nMarcas = 0
1843:             GO TOP IN (loc_cCursor)
1844:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGpr.Refresh()
1845:         ENDIF
1846:     ENDPROC
1847: 
1848:     *--------------------------------------------------------------------------
1849:     * BtnMarGrpClick / BtnDesGrpClick - Marcar/Desmarcar Tudo na grade de
1850:     * Grupo de Produto (legado: btnMarGrp.Click / btnDesGrp.Click).
1851:     *--------------------------------------------------------------------------
1852:     PROCEDURE BtnMarGrpClick()
1853:         LOCAL loc_cCursor
1854:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1855: 
1856:         IF USED(loc_cCursor)
1857:             UPDATE (loc_cCursor) SET nMarcas = 1
1858:             GO TOP IN (loc_cCursor)
1859:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1860:         ENDIF
1861:     ENDPROC
1862: 
1863:     PROCEDURE BtnDesGrpClick()
1864:         LOCAL loc_cCursor
1865:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrdGru
1866: 
1867:         IF USED(loc_cCursor)
1868:             UPDATE (loc_cCursor) SET nMarcas = 0
1869:             GO TOP IN (loc_cCursor)
1870:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdGru.Refresh()
1871:         ENDIF
1872:     ENDPROC
1873: 
1874:     *--------------------------------------------------------------------------
1875:     * BtnConsultarClick - Valida o periodo informado (legado: cmgFiltros.
1876:     * Command1.Click) e processa os movimentos filtrados (legado:
1877:     * ThisForm.Processamento(), chamado apos as mesmas 3 validacoes de
1878:     * data). Com sucesso, segue para a pagina de Dados e repinta a grade
1879:     * de resultado (legado: ActivePage=2 + AfterRowColChange, codigo_
1880:     * fonte.txt:2729-2733).
1881:     *--------------------------------------------------------------------------
1882:     PROCEDURE BtnConsultarClick()
1883:         LOCAL loc_oPag, loc_dIni, loc_dFim

*-- Linhas 2041 a 2060:
2041:             USE IN cursor_4c_BuscaEmp
2042:         ENDIF
2043: 
2044:         loc_cSQL       = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cCodigo)
2045:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaEmp")
2046: 
2047:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaEmp") AND RECCOUNT("cursor_4c_BuscaEmp") > 0
2048:             loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2049:             loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2050:         ELSE
2051:             THIS.AbrirLookupEmpresa()
2052:         ENDIF
2053: 
2054:         IF USED("cursor_4c_BuscaEmp")
2055:             USE IN cursor_4c_BuscaEmp
2056:         ENDIF
2057:     ENDPROC
2058: 
2059:     *--------------------------------------------------------------------------
2060:     * EmpOsKeyPress - F4 abre o picker de Empresa direto (regra #47 - so com

*-- Linhas 2096 a 2114:
2096:                 ENDIF
2097: 
2098:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2099:                     SELECT cursor_4c_BuscaEmp
2100:                     loc_oPag.txt_4c_EmpOs.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2101:                     loc_oPag.txt_4c_DEmpOs.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
2102:                 ENDIF
2103: 
2104:                 loc_oBusca.Release()
2105:             ENDIF
2106: 
2107:             IF USED("cursor_4c_BuscaEmp")
2108:                 USE IN cursor_4c_BuscaEmp
2109:             ENDIF
2110:         CATCH TO loc_oErro
2111:             MsgErro(loc_oErro.Message, "Erro")
2112:         ENDTRY
2113: 
2114:         THIS.this_lEmLookupEmpresa = .F.

*-- Linhas 2139 a 2158:
2139:             USE IN cursor_4c_BuscaOpe
2140:         ENDIF
2141: 
2142:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cCodigo)
2143:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaOpe")
2144: 
2145:         IF loc_nResultado > 0 AND USED("cursor_4c_BuscaOpe") AND RECCOUNT("cursor_4c_BuscaOpe") > 0
2146:             loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2147:         ELSE
2148:             THIS.AbrirLookupOperacao()
2149:         ENDIF
2150: 
2151:         IF USED("cursor_4c_BuscaOpe")
2152:             USE IN cursor_4c_BuscaOpe
2153:         ENDIF
2154:     ENDPROC
2155: 
2156:     *--------------------------------------------------------------------------
2157:     * OperacaoKeyPress - F4 abre o picker de Operacao direto.
2158:     *--------------------------------------------------------------------------

*-- Linhas 2190 a 2208:
2190:                 ENDIF
2191: 
2192:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
2193:                     SELECT cursor_4c_BuscaOpe
2194:                     loc_oPag.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
2195:                 ENDIF
2196: 
2197:                 loc_oBusca.Release()
2198:             ENDIF
2199: 
2200:             IF USED("cursor_4c_BuscaOpe")
2201:                 USE IN cursor_4c_BuscaOpe
2202:             ENDIF
2203:         CATCH TO loc_oErro
2204:             MsgErro(loc_oErro.Message, "Erro")
2205:         ENDTRY
2206: 
2207:         THIS.this_lEmLookupOperacao = .F.
2208:     ENDPROC

*-- Linhas 2261 a 2279:
2261:     *--------------------------------------------------------------------------
2262:     * GrdDadosAfterRowColChange - Espelha a linha corrente da grade de
2263:     * resultado nas propriedades this_Res* do BO (CarregarDoCursor) e
2264:     * atualiza o painel de observacao/imagem do item (legado: ControlSource
2265:     * direto de getObsItn/ImgFigJpg em crPgRes01, que se atualizava sozinho
2266:     * ao mudar de linha). Sem filtro de coluna, igual aos outros 11 dos 12
2267:     * handlers do projeto que usam AfterRowColChange para carregar detalhe
2268:     * da linha corrente (regra #46 do CLAUDE.md).
2269:     *--------------------------------------------------------------------------
2270:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
2271:         THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorDados)
2272:         THIS.AtualizarDetalheItem()
2273:     ENDPROC
2274: 
2275:     *--------------------------------------------------------------------------
2276:     * AtualizarDetalheItem - Copia this_cResObsItem para o EditBox e decodifica
2277:     * this_cResImagem (base64, com os 3 prefixos data:image/... do legado) para
2278:     * um arquivo temporario, exibindo-o no Image (legado: ImgFigJpg.Click).
2279:     *--------------------------------------------------------------------------

*-- Linhas 2314 a 2332:
2314:             loc_nValor  = loc_oPagRes.txt_4c_Busca.Value
2315: 
2316:             IF loc_nValor > 0 AND USED(loc_cCursor)
2317:                 SELECT (loc_cCursor)
2318:                 GO TOP
2319:                 LOCATE FOR Numero = loc_nValor
2320:                 loc_oPagRes.grd_4c_Dados.Refresh()
2321: 
2322:                 IF par_nKeyCode = 13
2323:                     loc_oPagRes.grd_4c_Dados.Column3.SetFocus()
2324:                 ENDIF
2325:             ENDIF
2326:         ENDIF
2327:     ENDPROC
2328: 
2329:     *--------------------------------------------------------------------------
2330:     * BtnRestaurarClick - Restaura larguras/visibilidade das colunas da
2331:     * grade de resultado para o padrao do legado e REGRAVA o layout
2332:     * (legado: btnRestaurar.Click = If MessageBox(...) = 6 / GradePadrao() /

*-- Linhas 2403 a 2440:
2403:             USE IN cursor_4c_TmpOpe
2404:         ENDIF
2405: 
2406:         loc_cSQL       = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cMovimentacao)
2407:         loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2408: 
2409:         IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2410:             IF USED("cursor_4c_TmpOpe")
2411:                 USE IN cursor_4c_TmpOpe
2412:             ENDIF
2413: 
2414:             GarantirClasse("FormSigMvExp")
2415:             loc_oForm = CREATEOBJECT("FormSigMvExp", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2416:             IF VARTYPE(loc_oForm) = "O"
2417:                 loc_oForm.Show()
2418:             ENDIF
2419:         ELSE
2420:             IF USED("cursor_4c_TmpOpe")
2421:                 USE IN cursor_4c_TmpOpe
2422:             ENDIF
2423: 
2424:             loc_cSQL       = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cMovimentacao)
2425:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpe")
2426: 
2427:             IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2428:                 GarantirClasse("FormSigMvPdt")
2429:                 loc_oForm = CREATEOBJECT("FormSigMvPdt", loc_cMovimentacao, "C", loc_nNumero, loc_cEmpresa, .T.)
2430:                 IF VARTYPE(loc_oForm) = "O"
2431:                     loc_oForm.Show()
2432:                 ENDIF
2433:             ENDIF
2434: 
2435:             IF USED("cursor_4c_TmpOpe")
2436:                 USE IN cursor_4c_TmpOpe
2437:             ENDIF
2438:         ENDIF
2439:     ENDPROC
2440: 

*-- Linhas 2520 a 2538:
2520:             RETURN
2521:         ENDIF
2522: 
2523:         SELECT (loc_cCursor)
2524: 
2525:         *-- O legado reindexa SO no Visualizar (btnVisualizar.Click = Index
2526:         *-- on SubGrupo + Codigo_Item Tag Ordem1 + Go Top + Report Form ...
2527:         *-- Preview); o Imprimir (BtnImprimir.Click) faz apenas Go Top +
2528:         *-- Report Form ... To PRINTER Prompt, mantendo a ordem corrente
2529:         *-- (Ordem3, posta por SigOpPckBO.MontarCursorDados). Reindexar nos
2530:         *-- dois mudaria a ordem do relatorio IMPRESSO.
2531:         IF par_cModo = "PREVIEW"
2532:             INDEX ON SubGrupo + Codigo_Item TAG Ordem1
2533:         ENDIF
2534: 
2535:         GO TOP
2536: 
2537:         loc_cPointAnt     = SET("POINT")
2538:         loc_cSeparatorAnt = SET("SEPARATOR")

*-- Linhas 2559 a 2602:
2559: 
2560:     *--------------------------------------------------------------------------
2561:     * GerarXLS - Exporta o cursor de resultado para planilha XLS (legado:
2562:     * ThisForm.GerarXLS() = PutFile + Select ... Order By ... Into Cursor
2563:     * crExcel + Copy To ... Type Xl5).
2564:     *--------------------------------------------------------------------------
2565:     PROCEDURE GerarXLS()
2566:         LOCAL loc_cCursor, loc_cArquivo
2567: 
2568:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorDados
2569: 
2570:         IF !USED(loc_cCursor) OR RECCOUNT(loc_cCursor) = 0
2571:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", ;
2572:                 "Exporta" + CHR(231) + CHR(227) + "o")
2573:             RETURN
2574:         ENDIF
2575: 
2576:         loc_cArquivo = PUTFILE("Nome da Planilha", "", "XLS")
2577: 
2578:         IF !EMPTY(loc_cArquivo)
2579:             IF USED("cursor_4c_Excel")
2580:                 USE IN cursor_4c_Excel
2581:             ENDIF
2582: 
2583:             SELECT * FROM (loc_cCursor) ;
2584:                 ORDER BY Destino, Ordem, Data_Venda, Movimentacao, Numero ;
2585:                 INTO CURSOR cursor_4c_Excel
2586: 
2587:             SELECT cursor_4c_Excel
2588:             COPY TO (loc_cArquivo) TYPE XL5
2589:             USE IN cursor_4c_Excel
2590: 
2591:             MsgInfo('O Arquivo "' + ALLTRIM(loc_cArquivo) + '" Foi Gerado!!!', ;
2592:                 "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
2593:         ENDIF
2594:     ENDPROC
2595: 
2596:     *--------------------------------------------------------------------------
2597:     * Destroy - this_oBusinessObject e o restauro do menu ja sao tratados em
2598:     * FormBase.Destroy(); DODEFAULT() tem de ser a ULTIMA linha (regra do
2599:     * fix menu-shrinks, Erro58).
2600:     *--------------------------------------------------------------------------
2601:     PROCEDURE Destroy()
2602:         DODEFAULT()

