# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'FLAGCTABS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LMARCAS, LNSITUACAO, CGRUS, COLECOES, MOEVS

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
  Column1.ControlSource = ""
Select CrSigCdLpi
If ThisForm.ParentForm.poDataMGr.SqlExecute([Select 0 As lMarcas,linhas,descs From SigCdLin ],'CsSigCdLin') < 1
	.Column1.ControlSource = 'CsSigCdLin.lMarcas'
	.Column2.ControlSource = 'CsSigCdLin.linhas'
	.Column3.ControlSource = 'CsSigCdLin.descs'
	.Column1.ControlSource = 'CsSigCdPro.flagctabs'
	.Column2.ControlSource = 'CsSigCdPro.cpros'
	.Column3.ControlSource = 'CsSigCdPro.dpros'
	.Column4.ControlSource = 'CsSigCdPro.pvens'
	.Column5.ControlSource = 'CsSigCdPro.moevs'
	.Column6.ControlSource = 'CsSigCdPro.pliqs'
Select CsSigCdLin
Select CsSigCdLin
Delete From CrSigCdLpi Where Empty(cpros)
Select CsSigCdPro
	If CsSigCdPro.flagctabs = 1 And CsSigCdPro.lMarcas = 0 And !Seek(CsSigCdPro.cpros,'CrSigCdLpi','CPros')
	    Insert Into CrSigCdLpi From MemVar
	Select CsSigCdPro
Select CsSigCdLin
	Select CsSigCdLin
lStrQuery = [Select flagctabs,cpros,dpros,pvens,moevs,situas,cgrus,colecoes,linhas ]+;
			[From SigCdPro ]+;
If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'TmpPro') < 1
Select TmpPro
	m.flagctabs = Iif(Seek(TmpPro.cpros,'CrSigCdLpi','CPros'),1,0)
	Insert Into CsSigCdPro From MemVar
	Select TmpPro
Select CsSigCdPro
Select CsSigCdPro
Select CsSigCdPro

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopsep.prg) - TRECHOS RELEVANTES PARA PASS SQL (2194 linhas total):

*-- Linhas 125 a 143:
125: *   - cmd_4c_Encerrar Click -> THIS.Release() (literal)
126: *
127: * O QUE CONTINUA DEFERIDO (documentado desde a Fase 3, linhas 35-39): a
128: * gravacao real em CrSigCdLpi - Delete From CrSigCdLpi Where Empty(cpros),
129: * cidchaves via fUniqueIds(), lprecos do cabecalho CrSigCdLpc, flagutabs,
130: * vencis/vencfs, e o arredondamento condicional via fArredondamento
131: * (NAO portada - this_oFormPai so guarda a referencia, gnConnHandle. PILAR
132: * 3 impede acessar objeto do pai por nome fixo (Pagina.Dados.Grade), e
133: * nenhum form SIGOPPxx desta familia foi migrado ainda para expor um
134: * CONTRATO conhecido. BtnCopiaListaClick entrega o cursor ja filtrado
135: * (cursor_4c_ProdutosCopia) ao pai atraves de um metodo PUBLIC opcional
136: * (AdicionarProdutosSelecionados), chamado de forma DEFENSIVA via
137: * PEMSTATUS - o mesmo padrao ja usado em ReabilitarFormPai/RepintarFormPai
138: * (e em FormSigOpCrd.LerTextoDoPai) para nunca estourar enquanto o pai nao
139: * existir. BtnProcessarClick passa par_cCursorListaPrecos = "" pelo mesmo
140: * motivo (equivalente a "lista ainda vazia" no legado).
141: *
142: *------------------------------------------------------------------------------
143: * Fase 8/8 (ESTA FASE) - consolidacao final.

*-- Linhas 288 a 306:
288:                 *-- Replica o fecho do SIGOPSEP.Init: popula CsSigCdLin
289:                 *-- (cursor_4c_Linhas), cria CsSigCdPro (cursor_4c_Produtos)
290:                 *-- vazio e liga as DUAS grades. Entra so aqui, depois de
291:                 *-- TornarControlesVisiveis, porque RecordSource/ControlSource
292:                 *-- exigem o cursor ja criado (regra #41) e o CheckBox das
293:                 *-- colunas de marcacao exige o bind feito (ver CarregarLinhas).
294:                 *-- As duas cargas sao independentes: a falha da primeira nao
295:                 *-- deve mascarar o resultado da segunda, por isso o AND vem
296:                 *-- depois das duas chamadas, nao em curto-circuito.
297:                 loc_lSucesso = THIS.CarregarLinhas()
298:                 loc_lSucesso = THIS.CarregarDados() AND loc_lSucesso
299:             ELSE
300:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
301:                         "vel criar o objeto de neg" + CHR(243) + "cio sigopsepBO.", ;
302:                         "Erro ao Inicializar")
303:             ENDIF
304: 
305:         CATCH TO loc_oErro
306:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 428 a 454:
428:     * explicita que caiba o texto (regra #23/#12). AutoSize=.T. NAO entra:
429:     * eh no-op em Label criado por AddObject.
430:     *
431:     * obj_4c_Situacao (Opc_situacao): OptionGroup com ControlSource
432:     * NUMERICO - Value = INDICE do botao (1=Ativos, 2=Inativos, 3=Todos),
433:     * NUNCA 0/1 (regra #45/#188). Legenda/ordem/Top de cada botao
434:     * transcritos do dump, nunca inventados.
435:     *
436:     * grd_4c_Linhas: estrutura so (ColumnCount, fontes, larguras, headers);
437:     * ControlSource e RecordSource ficam para CarregarLinhas(), chamado
438:     * depois de TornarControlesVisiveis() em InicializarForm - atribuir
439:     * ControlSource contra cursor_4c_Linhas aqui derrubaria o Init, porque
440:     * o cursor ainda nao existe (regra #41).
441:     *==========================================================================
442:     PROTECTED PROCEDURE ConfigurarPaginaLista()
443:         THIS.AddObject("cnt_4c_Filtro", "Container")
444:         WITH THIS.cnt_4c_Filtro
445:             .Top           = 130
446:             .Left          = 62
447:             .Width         = 656
448:             .Height        = 182
449:             .BackStyle     = 0
450:             .BorderWidth   = 0
451:             .SpecialEffect = 2
452:             .Visible       = .T.
453:         ENDWITH
454: 

*-- Linhas 733 a 765:
733:         ENDWITH
734: 
735:         *-- Grade de Linhas (GradeLinhas do legado) - estrutura (ColumnCount,
736:         *-- fontes, larguras, headers); RecordSource/ControlSource entram em
737:         *-- CarregarLinhas() (regra #41). HeaderHeight=0 e fiel ao dump (o
738:         *-- legado esconde a linha de header desta grade).
739:         THIS.cnt_4c_Filtro.AddObject("grd_4c_Linhas", "Grid")
740:         WITH THIS.cnt_4c_Filtro.grd_4c_Linhas
741:             .Top          = 79
742:             .Left         = 109
743:             .Width        = 454
744:             .Height       = 94
745:             .ColumnCount  = 3
746:             .FontName     = "Courier New"
747:             .HeaderHeight = 0
748:             .ReadOnly     = .F.
749:             .RecordMark   = .F.
750:             .DeleteMark   = .F.
751:             .TabIndex     = 10
752:             .Visible      = .T.
753: 
754:             .Column1.FontName          = "Courier New"
755:             .Column1.Width             = 20
756:             .Column1.Movable           = .F.
757:             .Column1.Resizable         = .F.
758:             .Column1.ReadOnly          = .F.
759:             .Column1.Sparse            = .F.
760:             .Column1.Visible           = .T.
761:             .Column1.Header1.Caption   = ""
762:             .Column1.Header1.FontName  = "Tahoma"
763:             .Column1.Header1.FontSize  = 8
764: 
765:             .Column2.FontName          = "Courier New"

*-- Linhas 847 a 868:
847:     *
848:     * Replica o trecho do SIGOPSEP.Init que popula CsSigCdLin e liga a grade.
849:     * A ORDEM aqui e regra medida, nao estilo:
850:     *   RecordSource -> ControlSource de TODAS as colunas -> Column.AddObject
851:     *   do CheckBox + .Value = 0 -> Sparse = .F. + CurrentControl -> Width /
852:     *   Header1.Caption.
853:     * Motivos: (a) atribuir ControlSource antes do cursor existir estoura
854:     * "Alias not found" dentro do TRY do InicializarForm e a tela nao abre
855:     * (regra #41); (b) Grid sem RecordSource AUTO-BINDA na area de trabalho
856:     * CORRENTE quando o ColumnCount e definido, e um AddObject de CheckBox
857:     * sobre coluna de texto estoura "Data type mismatch" - por isso o CheckBox
858:     * e instalado AQUI, depois do bind, e nao em ConfigurarPaginaLista;
859:     * (c) BuscarLinhas faz USE IN no alias, o que DESTROI o controle posto por
860:     * Column.AddObject (CurrentControl volta a "Text1") preservando
861:     * ColumnCount/Width/Header - perda PARCIAL e silenciosa, por isso a
862:     * instalacao e reentrante; (d) RecordSource reseta Width/Header1.Caption
863:     * para o default (Problema 48), que tem de ser reaplicados DEPOIS do bind.
864:     *==========================================================================
865:     PROTECTED PROCEDURE CarregarLinhas()
866:         LOCAL loc_oGrid
867: 
868:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 881 a 922:
881:         loc_oGrid.RecordSource = ""
882:         loc_oGrid.ColumnCount = 3
883:         loc_oGrid.RecordSource = "cursor_4c_Linhas"
884:         loc_oGrid.Column1.ControlSource = "cursor_4c_Linhas.lMarcas"
885:         loc_oGrid.Column2.ControlSource = "cursor_4c_Linhas.linhas"
886:         loc_oGrid.Column3.ControlSource = "cursor_4c_Linhas.descs"
887: 
888:         *-- Column1.Check1 do dump: a coluna de marcacao das Linhas
889:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaLinha")
890: 
891:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em
892:         *-- 2026-11-17, atribuir Grid.FontName/FontSize PROPAGA para
893:         *-- Column.FontName E para Column.Header1.FontName, sobrescrevendo o
894:         *-- Tahoma 8 que o dump declara por Header1 (ficava Courier New 9).
895:         THIS.FormatarGridLista(loc_oGrid)
896: 
897:         *-- RecordSource reseta Width/Header1.Caption para o default, e a
898:         *-- fonte do grid acabou de achatar o Header1 - reaplicar os dois
899:         *-- (Problema 48). Header1: Tahoma 8 em todas, Alignment 2 nas de
900:         *-- texto, como no dump de GradeLinhas.
901:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column1,  20, "", 0, -1)
902:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column2, 120, ;
903:             "C" + CHR(243) + "digo", 2, -1)
904:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column3, 290, ;
905:             "Descri" + CHR(231) + CHR(227) + "o do Produto", 2, -1)
906: 
907:         SELECT cursor_4c_Linhas
908:         GO TOP
909:         loc_oGrid.Refresh()
910: 
911:         RETURN .T.
912:     ENDPROC
913: 
914: 
915:     *==========================================================================
916:     * FiltroAlterado - InteractiveChange dos 6 campos de cnt_4c_Filtro (os 3
917:     * pares codigo/descricao: GrVenda/DgrVenda, GrProduto/DgrProduto,
918:     * MoeVenda/DmoeVenda). Legado: as SEIS propriedades InteractiveChange do
919:     * SCX fazem so "ThisForm.CopiaLista.Enabled = .F." - qualquer alteracao
920:     * no filtro, pelo codigo OU pela descricao, invalida a selecao de
921:     * produtos ja feita.
922:     *==========================================================================

*-- Linhas 1353 a 1409:
1353:     * (Sair/CopiaLista/Processar/cmdMarcaProd/cmdDesmarcaProd).
1354:     *
1355:     * APENAS a estrutura da grade (ColumnCount, fontes, larguras, headers):
1356:     * RecordSource/ControlSource e o CheckBox da Column1 ficam no funil
1357:     * CarregarDados(), pela sequencia medida que esta documentada la.
1358:     *
1359:     * Sair/CopiaLista/Processar sao fwbtng no legado e o SCX sobrepoe apenas
1360:     * Top/Left/Picture/Caption/Cancel/ToolTipText/PicturePosition; o resto vem
1361:     * da classe ("Comic Sans MS" 8 bold+italic, ForeColor 90,90,90, BackColor
1362:     * branco, WordWrap, MousePointer 15).
1363:     *
1364:     * Width/Height = 75: e o canonico do projeto para botao de acao (regra #10 e
1365:     * framework_frmcadastro_layout.md) e e o que FECHA a geometria do dump - os
1366:     * Left do legado sao 576/651/725, isto e, passo de 75, e 725 + 75 = 800 =
1367:     * Form.Width exato; com Height = 75 a linha de botoes termina em 78, dentro
1368:     * da faixa de 80 do cabecalho. O 80x100 do fwbtng em framework.vcx e o
1369:     * default da classe-exemplo ("Grande"), que o projeto sobrepoe - adotado ali
1370:     * deixaria Sair 5px FORA do form e 23px abaixo da faixa.
1371:     * cmdMarcaProd/cmdDesmarcaProd sao fwbtnp (classe: 40x40), icone-only.
1372:     * Picture: todos TRANSCRITOS do dump (regra #25), conferidos em vbmp\.
1373:     *==========================================================================
1374:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1375:         *----------------------------------------------------------------------
1376:         * GradeItens -> grd_4c_Itens (dump: Top=316 Left=64 Width=673
1377:         * Height=130 ColumnCount=6 FontName="Courier New" TabIndex=2)
1378:         *
1379:         * RecordMark/DeleteMark nao sao declarados no dump desta grade (ao
1380:         * contrario de GradeLinhas, que declara RecordMark = .F.); ficam .F.
1381:         * por serem o canonico do projeto para grade de dados em OPERACIONAL.
1382:         *----------------------------------------------------------------------
1383:         THIS.AddObject("grd_4c_Itens", "Grid")
1384:         WITH THIS.grd_4c_Itens
1385:             .Top         = 316
1386:             .Left        = 64
1387:             .Width       = 673
1388:             .Height      = 130
1389:             .ColumnCount = 6
1390:             .FontName    = "Courier New"
1391:             .FontSize    = 9
1392:             .ReadOnly    = .F.
1393:             .RecordMark  = .F.
1394:             .DeleteMark  = .F.
1395:             .TabIndex    = 2
1396:             .Visible     = .T.
1397:         ENDWITH
1398: 
1399:         *-- Column1: marcacao (CheckBox). O ReadOnly da COLUNA vem DEPOIS do
1400:         *-- ReadOnly do GRID, que propaga e sobrescreveria (regra #18).
1401:         WITH THIS.grd_4c_Itens.Column1
1402:             .FontName          = "Courier New"
1403:             .Width             = 20
1404:             .Movable           = .F.
1405:             .Resizable         = .F.
1406:             .Sparse            = .F.
1407:             .ReadOnly          = .F.
1408:             .Visible           = .T.
1409:             .Header1.Caption   = ""

*-- Linhas 1666 a 1737:
1666:     * habilita, quando trouxer produtos).
1667:     *
1668:     * A estrutura do cursor mora UNICAMENTE no BO (CriarCursorProdutos):
1669:     * repetir o CREATE CURSOR aqui criaria duas versoes do mesmo cursor, e
1670:     * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
1671:     * ControlSource. Serve a toda repintura (aqui e, na fase de eventos, em
1672:     * Processar), pela mesma sequencia medida que CarregarLinhas documenta.
1673:     *==========================================================================
1674:     PROTECTED PROCEDURE CarregarDados()
1675:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1676:             RETURN .F.
1677:         ENDIF
1678: 
1679:         *-- Sem o cursor, atribuir ControlSource estoura "Alias not found"
1680:         *-- dentro do TRY do InicializarForm e a tela nao abre (regra #41)
1681:         THIS.this_oBusinessObject.CriarCursorProdutos()
1682: 
1683:         IF !THIS.ReligarGradeItens()
1684:             RETURN .F.
1685:         ENDIF
1686: 
1687:         *-- SIGOPSEP.Init termina com CopiaLista.Enabled = .F.
1688:         THIS.cmd_4c_CopiaLista.Enabled = .F.
1689: 
1690:         RETURN .T.
1691:     ENDPROC
1692: 
1693: 
1694:     *==========================================================================
1695:     * ReligarGradeItens - (re)liga grd_4c_Itens a cursor_4c_Produtos
1696:     *
1697:     * Fatorado de CarregarDados (Fase 4) porque BO.BuscarProdutos (Fase 7,
1698:     * usado em BtnProcessarClick) RECRIA cursor_4c_Produtos (USE IN +
1699:     * CREATE CURSOR, via CriarCursorProdutos) para popula-lo com dados
1700:     * reais - a MESMA razao, ja documentada em InstalarCheckBoxColuna, pela
1701:     * qual fechar/recriar o alias do RecordSource destroi o CheckBox posto
1702:     * por Column.AddObject. Por isso o bind tem de ser refeito do ZERO
1703:     * depois de QUALQUER recriacao do cursor, nao so na carga inicial.
1704:     *==========================================================================
1705:     PROTECTED PROCEDURE ReligarGradeItens()
1706:         LOCAL loc_oGrid
1707: 
1708:         IF !USED("cursor_4c_Produtos")
1709:             RETURN .F.
1710:         ENDIF
1711: 
1712:         loc_oGrid = THIS.grd_4c_Itens
1713: 
1714:         loc_oGrid.RecordSource = ""
1715:         loc_oGrid.ColumnCount = 6
1716:         loc_oGrid.RecordSource = "cursor_4c_Produtos"
1717:         loc_oGrid.Column1.ControlSource = "cursor_4c_Produtos.flagctabs"
1718:         loc_oGrid.Column2.ControlSource = "cursor_4c_Produtos.cpros"
1719:         loc_oGrid.Column3.ControlSource = "cursor_4c_Produtos.dpros"
1720:         loc_oGrid.Column4.ControlSource = "cursor_4c_Produtos.pvens"
1721:         loc_oGrid.Column5.ControlSource = "cursor_4c_Produtos.moevs"
1722:         loc_oGrid.Column6.ControlSource = "cursor_4c_Produtos.pliqs"
1723: 
1724:         *-- Column1.Check1 do dump: a coluna de marcacao dos Produtos. O
1725:         *-- objeto acabou de nascer de novo (RecordSource acima destruiu o
1726:         *-- anterior) - religar o When (GradeItens.Column1.Check1.When do
1727:         *-- legado: "Return(CsSigCdPro.lMarcas = 0)") no objeto NOVO.
1728:         THIS.InstalarCheckBoxColuna(loc_oGrid.Column1, "chk_4c_MarcaProduto")
1729:         BINDEVENT(loc_oGrid.Column1.chk_4c_MarcaProduto, "When", THIS, "WhenMarcaProduto")
1730: 
1731:         *-- DynamicForeColor do legado: azul no produto que JA esta na lista de
1732:         *-- precos do form pai (lMarcas = 1), preto nos demais. Transcrito do
1733:         *-- SIGOPSEP.Init, com o nome do cursor migrado.
1734:         loc_oGrid.SetAll("DynamicForeColor", ;
1735:             "RGB(0,0,IIF(cursor_4c_Produtos.lMarcas = 0,0,255))", "Column")
1736: 
1737:         *-- A fonte do GRID vai ANTES dos cabecalhos: medido no VFP9 em

*-- Linhas 1756 a 1774:
1756:         THIS.AplicarCabecalhoColuna(loc_oGrid.Column6, 110, ;
1757:             "Pre" + CHR(231) + "o de Venda (L)", 2, RGB(0, 0, 0))
1758: 
1759:         SELECT cursor_4c_Produtos
1760:         GO TOP
1761:         loc_oGrid.Refresh()
1762: 
1763:         RETURN .T.
1764:     ENDPROC
1765: 
1766: 
1767:     *==========================================================================
1768:     * WhenMarcaProduto - When do CheckBox de marcacao de grd_4c_Itens
1769:     * (GradeItens.Column1.Check1.When do legado: "Return(CsSigCdPro.lMarcas
1770:     * = 0)", literal). So permite editar a celula quando o produto AINDA
1771:     * NAO esta na lista de precos do pai - produto ja presente (lMarcas=1)
1772:     * fica travado, visualmente distinguido pelo DynamicForeColor azul de
1773:     * ReligarGradeItens.
1774:     *==========================================================================

*-- Linhas 1929 a 1947:
1929:     * silenciosa. Por isso o AddObject so corre quando o membro sumiu, e todo
1930:     * o resto e sempre reaplicado.
1931:     *
1932:     * par_oColuna - objeto Column, JA ligado via ControlSource
1933:     * par_cNome   - nome do CheckBox a instalar nessa coluna
1934:     *==========================================================================
1935:     PROTECTED PROCEDURE InstalarCheckBoxColuna(par_oColuna, par_cNome)
1936:         LOCAL loc_oChk
1937: 
1938:         IF VARTYPE(par_oColuna) != "O" OR VARTYPE(par_cNome) != "C" OR EMPTY(par_cNome)
1939:             RETURN .F.
1940:         ENDIF
1941: 
1942:         IF !PEMSTATUS(par_oColuna, par_cNome, 5)
1943:             par_oColuna.AddObject(par_cNome, "CheckBox")
1944:         ENDIF
1945: 
1946:         *-- Membro alcancado por NOME: EVALUATE na leitura. Controls(<nome>) e
1947:         *-- indexado por NUMERO e estouraria em runtime (regras #15/#34).


### BO (C:\4c\projeto\app\classes\sigopsepBO.prg):
*==============================================================================
* SIGOPSEPBO.PRG
* Business Object - Selecao de Produtos para Lista de Preco
* Origem: SIGOPSEP.SCX (form filho, chamado por ThisForm.ParentForm)
*==============================================================================

DEFINE CLASS sigopsepBO AS BusinessBase

    *-- Filtro: Grupo de Venda (colecoes - SigCdCol)
    this_cGrupoVenda = ""
    this_cDescGrupoVenda = ""

    *-- Filtro: Grupo de Produto (cgrus - SigCdGrp)
    this_cGrupoProduto = ""
    this_cDescGrupoProduto = ""

    *-- Filtro: Moeda de Venda (cmoes - SigCdMoe)
    this_cMoedaVenda = ""
    this_cDescMoedaVenda = ""

    *-- Filtro: Acrescimo/Desconto percentual
    this_nAcrescimoDesconto = 0

    *-- Filtro: Arredondamento
    this_nArredondamento = 0

    *-- Filtro: Situacao (1=Ativos, 2=Inativos, 3=Todos)
    this_nSituacao = 1

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT("SigCdPro")

        THIS.this_cCampoChave = "cpros"

        THIS.this_cGrupoVenda = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cGrupoProduto = ""
        THIS.this_cDescGrupoProduto = ""
        THIS.this_cMoedaVenda = ""
        THIS.this_cDescMoedaVenda = ""
        THIS.this_nAcrescimoDesconto = 0
        THIS.this_nArredondamento = 0
        THIS.this_nSituacao = 1

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhas - Carrega cursor_4c_Linhas (SigCdLin) para a grade de
    * marcacao de linhas do filtro (SIGOPSEP.Init: CsSigCdLin).
    * SQLEXEC() devolve cursor SOMENTE-LEITURA; como a grade marca/desmarca
    * via REPLACE, convertemos para READWRITE antes de expor o cursor.
    *
    * O bypass de teste vem no TOPO porque o TesteAutomatico.prg e o
    * ValidarUIFidelity.prg NAO conectam ao SQL Server (definem gnConnHandle
    * como SENTINELA). Sem ele a falha de conexao devolveria .F., o
    * InicializarForm do Form devolveria .F., CREATEOBJECT devolveria o
    * LOGICO .F. e a tela simplesmente nao abriria no harness - com uma
    * mensagem de conexao que nao corresponde a falha de rede nenhuma. O
    * cursor VAZIO e criado com a MESMA estrutura e ordem de campos do SELECT
    * abaixo (lMarcas, linhas C(10), descs C(40) - larguras de SigCdLin no
    * schema), para a grade ter o que ligar em ControlSource.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhas()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
           (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Linhas (lMarcas N(1), linhas C(10), descs C(40))
            SET NULL OFF
            SELECT cursor_4c_Linhas
            GO TOP
            RETURN .T.
        ENDIF

        TRY
            IF USED("cursor_4c_LinhasTmp")
                USE IN cursor_4c_LinhasTmp
            ENDIF
            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, linhas, descs FROM SigCdLin"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LinhasTmp")

            IF loc_nResultado >= 0
                SET NULL ON
                SELECT * FROM cursor_4c_LinhasTmp INTO CURSOR cursor_4c_Linhas READWRITE
                SET NULL OFF

                IF USED("cursor_4c_LinhasTmp")
                    USE IN cursor_4c_LinhasTmp
                ENDIF

                SELECT cursor_4c_Linhas
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodasLinhas - Replica Marcar.Click/Desmarcar.Click (Replace All
    * lMarcas With <valor> In CsSigCdLin).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodasLinhas(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                REPLACE ALL lMarcas WITH par_nValor
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorProdutos - Estrutura identica ao "Create Cursor CsSigCdPro"
    * do SIGOPSEP.Init. Cursor local (nao vem de SQLEXEC), por isso ja nasce
    * READWRITE - suporta o CheckBox da coluna flagctabs (Column1) e os
    * REPLACE de MarcarTodosProdutos/ObterProdutosParaCopia.
    *
    * PUBLIC de proposito: o Form chama este metodo para criar o cursor VAZIO
    * antes de ligar a grade de produtos (o SIGOPSEP.Init legado faz o
    * "Create Cursor" inline, antes do RecordSource/ControlSource). Deixar a
    * estrutura do cursor SO aqui evita duas versoes do mesmo CREATE CURSOR -
    * divergencia de ordem/nome de campo quebra em silencio o APPEND e o
    * ControlSource da grade. Metodo que o Form chama de fora NAO pode ser
    * PROTECTED em nenhum nivel da heranca (regra #51): a chamada compila
    * limpo e estoura em runtime com "Property ... is not found".
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursorProdutos()
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Produtos (flagctabs N(1), cpros C(14), dpros C(40), pvens N(12,2), ;
            pliqs N(12,2), moevs C(3), situas N(1), cgrus C(3), colecoes C(10), linhas C(10), lMarcas N(1))
        SET NULL OFF

        INDEX ON cpros + cgrus TAG CProGrus
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Replica SIGOPSEP.Processar.Click: monta o WHERE a
    * partir dos filtros (this_cGrupoProduto/this_cGrupoVenda/
    * this_cMoedaVenda) e das linhas marcadas em cursor_4c_Linhas, consulta
    * SigCdPro e recria cursor_4c_Produtos com pliqs calculado
    * (this_nAcrescimoDesconto/this_nArredondamento).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (equivalente a
    * CrSigCdLpi) - usado so para marcar flagctabs/lMarcas = 1 quando o
    * produto ja esta na lista de precos (Seek por CPros, igual ao legado).
    * Passar "" quando o form pai ainda nao disponibilizar esse cursor.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_cWhere, loc_cLinhas, loc_cSQL, loc_nResultado, ;
            loc_nVariacao, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cWhere = "0 = 0 "

            IF !EMPTY(THIS.this_cGrupoProduto)
                loc_cWhere = loc_cWhere + "AND cgrus = " + EscaparSQL(THIS.this_cGrupoProduto) + " "
            ENDIF
            IF !EMPTY(THIS.this_cGrupoVenda)
                loc_cWhere = loc_cWhere + "AND colecoes = " + EscaparSQL(THIS.this_cGrupoVenda) + " "
            ENDIF
            IF !EMPTY(THIS.this_cMoedaVenda)
                loc_cWhere = loc_cWhere + "AND moevs = " + EscaparSQL(THIS.this_cMoedaVenda) + " "
            ENDIF

            loc_cLinhas = ""
            IF USED("cursor_4c_Linhas")
                SELECT cursor_4c_Linhas
                GO TOP
                SCAN
                    IF cursor_4c_Linhas.lMarcas = 1
                        loc_cLinhas = loc_cLinhas + "linhas = " + EscaparSQL(cursor_4c_Linhas.linhas) + " OR "
                    ENDIF
                ENDSCAN
            ENDIF
            IF !EMPTY(loc_cLinhas)
                loc_cWhere = loc_cWhere + "AND (" + LEFT(loc_cLinhas, LEN(loc_cLinhas) - 3) + ") "
            ENDIF

            loc_cSQL = "SELECT flagctabs, cpros, dpros, pvens, moevs, situas, cgrus, colecoes, linhas " + ;
                       "FROM SigCdPro " + ;
                       "WHERE " + loc_cWhere + ;
                       "ORDER BY cpros, cgrus, flagctabs, dpros, pvens, moevs, situas, colecoes, linhas"

            IF USED("cursor_4c_ProdutosTmp")
                USE IN cursor_4c_ProdutosTmp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutosTmp")

            IF loc_nResultado >= 0
                THIS.CriarCursorProdutos()

                loc_nVariacao = 1 + (THIS.this_nAcrescimoDesconto / 100)

                SELECT cursor_4c_ProdutosTmp
                GO TOP
                SCAN
                    SCATTER MEMVAR

                    IF !EMPTY(par_cCursorListaPrecos) AND USED(par_cCursorListaPrecos) ;
                            AND SEEK(cursor_4c_ProdutosTmp.cpros, par_cCursorListaPrecos, "CPros")
                        m.flagctabs = 1
                    ELSE
                        m.flagctabs = 0
                    ENDIF
                    m.lMarcas = m.flagctabs

                    m.pliqs = ROUND(cursor_4c_ProdutosTmp.pvens * loc_nVariacao, 2)
                    IF THIS.this_nArredondamento <> 0
                        m.pliqs = ROUND(m.pliqs / THIS.this_nArredondamento, 0) * THIS.this_nArredondamento
                    ENDIF

                    INSERT INTO cursor_4c_Produtos FROM MEMVAR

                    SELECT cursor_4c_ProdutosTmp
                ENDSCAN

                IF USED("cursor_4c_ProdutosTmp")
                    USE IN cursor_4c_ProdutosTmp
                ENDIF

                SELECT cursor_4c_Produtos
                GO TOP

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosProdutos - Replica cmdMarcaProd.Click/cmdDesmarcaProd.Click
    * (Replace All flagctabs With <valor> For lMarcas = 0).
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosProdutos(par_nValor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                REPLACE ALL flagctabs WITH par_nValor FOR lMarcas = 0
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterProdutosParaCopia - Replica o SCAN de SIGOPSEP.CopiaLista.Click:
    * seleciona os produtos marcados pelo usuario (flagctabs=1) que ainda
    * nao estavam na lista (lMarcas=0), respeitando o filtro de situacao
    * (this_nSituacao: 3=Todos), e reconfere que nao foram copiados nesse
    * meio-tempo (Seek por CPros no cursor do form pai).
    *
    * par_cCursorListaPrecos: cursor VFP do form pai (CrSigCdLpi).
    *
    * A INSERCAO final nesse cursor (cidchaves=fUniqueIds(), lprecos do
    * cabecalho CrSigCdLpc, vencis/vencfs={}, flagutabs=.T., pvens=pliqs)
    * fica por conta do Form: a estrutura de CrSigCdLpi/CrSigCdLpc pertence
    * ao form pai (fora do escopo deste BO, que so enxerga SigCdPro/
    * SigCdLin). fArredondamento(pvens, poDataMgr) do legado NAO foi
    * portada (funcao global Fortyus ausente do acervo, SIGFUNCS.PRG) -
    * fica de fora de proposito; o Form aplica essa funcao, quando portada,
    * somente quando o form pai indicar CompVenda <> "C" (mesmo guard do
    * legado). NUNCA substituir por ROUND/INT/CEILING.
    *
    * Popula cursor_4c_ProdutosCopia com cpros/dpros/pvens/pliqs/moevs.
    *--------------------------------------------------------------------------
    PROCEDURE ObterProdutosParaCopia(par_cCursorListaPrecos)
        LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        THIS.this_cMensagemErro = ""

        IF !USED("cursor_4c_Produtos")
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                IF USED("cursor_4c_ProdutosCopia")
                    USE IN cursor_4c_ProdutosCopia
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_ProdutosCopia (cpros C(14), dpros C(40), pvens N(12,2), ;
                    pliqs N(12,2), moevs C(3))
                SET NULL OFF

                SELECT cursor_4c_Produtos
                GO TOP
                SCAN FOR cursor_4c_Produtos.flagctabs = 1 AND cursor_4c_Produtos.lMarcas = 0
                    IF THIS.this_nSituacao = 3 OR THIS.this_nSituacao = cursor_4c_Produtos.situas
                        IF EMPTY(par_cCursorListaPrecos) OR !USED(par_cCursorListaPrecos) ;
                                OR !SEEK(cursor_4c_Produtos.cpros, par_cCursorListaPrecos, "CPros")
                            INSERT INTO cursor_4c_ProdutosCopia (cpros, dpros, pvens, pliqs, moevs) VALUES ;
                                (cursor_4c_Produtos.cpros, cursor_4c_Produtos.dpros, cursor_4c_Produtos.pvens, ;
                                 cursor_4c_Produtos.pliqs, cursor_4c_Produtos.moevs)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_Produtos
                ENDSCAN

                SELECT cursor_4c_ProdutosCopia
                GO TOP

                loc_lSucesso = .T.

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores locais abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED("cursor_4c_Linhas")
            USE IN cursor_4c_Linhas
        ENDIF
        IF USED("cursor_4c_Produtos")
            USE IN cursor_4c_Produtos
        ENDIF
        IF USED("cursor_4c_ProdutosCopia")
            USE IN cursor_4c_ProdutosCopia
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores locais ao destruir o BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * Este BO NAO persiste nenhuma tabela propria: o SIGOPSEP legado apenas
    * CONSULTA SigCdPro/SigCdLin (filtros + grade de selecao) e copia os
    * produtos marcados para o cursor de ITENS do form pai (CrSigCdLpi,
    * fora do escopo deste BO) - nunca grava em SigCdPro. Por isso
    * Inserir()/Atualizar()/ExecutarExclusao()/RegistrarAuditoria()/
    * CarregarDoCursor()/ObterChavePrimaria() NAO sao sobrescritos aqui - o
    * comportamento padrao herdado de BusinessBase ja eh o correto para
    * este caso (mesmo padrao de SigOpCtsBO.prg/SigOpAutBO.prg, outras
    * telas operacionais sem tabela mestre propria).
    *==========================================================================

ENDDEFINE

