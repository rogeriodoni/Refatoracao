# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CITENS, CGRUS, SERVICOS, DTSITUAS, SITUAS, 0, IDECPROS, LPRECOS, VALUE, DPROS, ICONFS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'QTD' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, CITENS, CGRUS, SERVICOS, DTSITUAS, SITUAS, 0, IDECPROS, LPRECOS, VALUE, DPROS, ICONFS

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
  Column3.ControlSource = ""
  Column4.ControlSource = ""
  Column5.ControlSource = ""
  Column6.ControlSource = ""
  Column7.ControlSource = ""
  ControlSource = "crTpmMvItn.citens"
Select crTpmMvItn3
Select crTpmMvItn3
	Insert Into crTpmMvItn3(Emps, Dopes, Numes, Citens) ;
	Insert Into csTmpDesc (nControle, nLInhas) Values (RecNo([crTpmMvItn3]), ThisForm.nCItem2)
Select crTpmMvItn3 
Select crTpmMvItn3
Select crTpmMvItn3
	Select * From crTpmMvItn3 Where CItens = crTpmMvItn.CItens And IsEmpty(Qtds) Into Cursor csTemp
		Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens  ) ;
Select crTpmMvItn3
Select crTpmMvItn3 
	Insert Into csTmpDesc ( nControle, nLinhas ) Values ;
Select crTpmMvItn3
Select crTpmMvItn3
Select crTpmMvItn3 
	Select crTpmMvItn3 
	.Item.ControlSource       = "csTmpDesc.nLinhas"
	.Produto.Controlsource    = 'crTpmMvItn3.cpros'
	.Qtd.Controlsource        = 'crTpmMvItn3.qtds'
	.Valor.Controlsource      = 'crTpmMvItn3.units'
	.Moeda.Controlsource      = 'crTpmMvItn3.moedas'
	.Total.Controlsource      = 'crTpmMvItn3.totas'
	.Descricao.Controlsource  = 'crTpmMvItn3.Dpros'
	lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a, SigCdGrp b ]+;
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CsSigCdPro') < 1
	lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a Where 0=1 ]
	If Thisform.ParentForm.PodataMgr.SqlExecute(lcQuery,'CsSigCdPro') < 1
Select csSigCdPro
Select csSigCdPro
Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite 
Select csSigCdPro 
Select crTpmMvItn3
Select crTpmMvItn3
Select crTpmMvItn3
	Select csSigCdPro 
	If !Seek(This.Value,[csSigCdPro],[IdeCPros])
		select crTpmMvItn3
		Select crTpmMvItn3
			lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
			Select CrSigCdLpi
				Select crTpmMvItn3
		Select crTpmMvItn3
		Select crTpmMvItn3
Select crTpmMvItn3
Select crTpmMvItn3
Select crTpmMvItn3
	Select csSigCdPro 
		select crTpmMvItn3
		Select crTpmMvItn3
			lcwhere = [Select * From SigCdLpi Where Cpros = ']+CrTmpPro.Cpros+[' And LPrecos = ']+TprMvCab.lPrecos+[']
			lnErro = ThisForm.parentform.podatamgr.SqlExecute(lcWhere,'CrSigCdLpi')
			Select CrSigCdLpi
				Select crTpmMvItn3
		Select crTpmMvItn3
Select crTpmMvItn
	lnOldSel=Select()
	Select crTpmMvItn3
	Select Count(1) as Qtd From crTpmMvItn3 Where iConfs = .T. and (Empty(TamDe) or Empty(TamPara)) Into Cursor csValConfs ReadWrite
	Select csValConfs
			Select(lnOldSel)
	Select(lnOldSel)
Select crTpmMvItn3
Select crTpmMvItn3

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopser.prg) - TRECHOS RELEVANTES PARA PASS SQL (4656 linhas total):

*-- Linhas 305 a 323:
305:                 THIS.ConfigurarCabecalho()
306: 
307:                 *-- Grade de servicos (fwGrade); so a estrutura visual - o
308:                 *-- RecordSource e os ControlSource ficam em CarregarLista,
309:                 *-- porque os cursores ainda nao existem neste ponto
310:                 THIS.ConfigurarGrade()
311: 
312:                 *-- Os tres botoes de servico (btnTotItens / btnCotacao /
313:                 *-- btnAltImps), que nascem OCULTOS como no SCX legado
314:                 THIS.ConfigurarBotoesServico()
315: 
316:                 *-- Botao Retornar (cntOK); vem DEPOIS do cabecalho porque se
317:                 *-- sobrepoe a faixa (Top = -2..83 contra 0..80) e precisa
318:                 *-- desenhar por cima dela
319:                 THIS.ConfigurarBotaoRetornar()
320: 
321:                 *-- Painel "Tamanho" (cntTamanho); os dois campos com lookup
322:                 *-- em SigCdTam foram acrescentados a ele na Fase 6
323:                 *-- (ConfigurarCamposTamanho, chamada logo abaixo)

*-- Linhas 555 a 573:
555:     *
556:     * Legado (SIGOPSER.fwGrade, classe fwgrade):
557:     *   ColumnCount=7 FontName="Verdana" FontSize=8 AllowAddNew=.F.
558:     *   AllowHeaderSizing=.F. DeleteMark=.F. HeaderHeight=20 RowHeight=16
559:     *   ScrollBars=2 Top=172 Left=12 Width=986 Height=408 Visible=.T.
560:     *   ToolTipText="Grade de Itens"
561:     * Mais o que vem da CLASSE fwgrade (docs\FRAMEWORK_class_codigo_fonte.txt):
562:     *   AllowRowSizing=.F. GridLineColor=238,238,238 HighlightBackColor=90,90,90
563:     *
564:     * As SETE colunas, na ordem dos registros do SCX (Column1..Column7) e com o
565:     * ColumnOrder que define a ordem em que o usuario as VE:
566:     *
567:     *   Column  Nome legado  ColumnOrder  Width  Header
568:     *   ------  -----------  -----------  -----  -------------------------
569:     *   6       item               1         31  (sem caption)
570:     *   1       PRODUTO            2        120  "Servico"
571:     *   7       Descricao          3        404  "Descricao do Servico"
572:     *   2       QTD                4        120  "Quantidade"
573:     *   3       VALOR              5        120  "Valor"

*-- Linhas 579 a 662:
579:     * cada uma vai em comentario, que eh o que permite rastrear o dump.
580:     *
581:     * Aqui entra SO o que NAO depende de dado. O RecordSource, os sete
582:     * ControlSource, a InputMask calculada da coluna VALOR e o DynamicForeColor
583:     * da coluna QTD ficam em CarregarLista: neste ponto do Init os cursores do
584:     * chamador ainda nao foram alcancados e amarrar Column.ControlSource a um
585:     * alias inexistente derruba o Init - o CREATEOBJECT devolveria .F. e o
586:     * usuario acionaria o menu sem nada acontecer.
587:     *
588:     * GRID NASCE AUTO-LIGADO AO ALIAS CORRENTE - E ISSO GRAVA NO CURSOR
589:     * ---------------------------------------------------------------
590:     * Medido no VFP9: AddObject("grd", "Grid") com um alias selecionado devolve
591:     * a grade JA ligada a ele - RecordSourceType = 1 e RecordSource com o nome
592:     * do alias, ColumnCount igual ao numero de campos do cursor. Ao reduzir o
593:     * ColumnCount para 7 as colunas continuam ligadas, cada uma a um campo do
594:     * cursor acidental (Column1 -> 1o campo, Column2 -> 2o, ...). A partir dai
595:     * QUALQUER atribuicao a Column<N>.Text1.Value ESCREVE no cursor atraves do
596:     * vinculo. Com as duas que o dump pede (Column5 e Column6 com Value = 0) o
597:     * resultado medido foi o 5o campo do cursor corrente virando 0 e o 6o
598:     * virando "0" - sem erro, sem log, sem aviso. Este dialogo abre a partir de
599:     * um form de movimento e roda na sessao de dados DELE, entao o alias
600:     * corrente eh um cursor VIVO do documento: o estrago seria corromper dois
601:     * campos do registro corrente do chamador so por abrir a tela.
602:     *
603:     * Por isso, logo depois do ColumnCount, o vinculo acidental eh desfeito -
604:     * RecordSource vazio e ControlSource de TODAS as colunas em branco - ANTES
605:     * de qualquer propriedade de Text1. Medido: com o vinculo desfeito o cursor
606:     * fica intacto, o ColumnCount continua 7, e a ligacao de verdade feita em
607:     * CarregarLista funciona normalmente. Isso tambem evita que a grade EXIBA um
608:     * cursor alheio quando a tela abre sem os cursores do chamador (ai
609:     * VincularGrade sai cedo e, sem esta limpeza, a grade mostraria o que
610:     * estivesse selecionado).
611:     *
612:     * RecordMark = .F. acompanha o DeleteMark = .F. do dump: eh o canonico dos
613:     * grids criados por AddObject em form OPERACIONAL, e sem ele a barra de
614:     * marcacao aparece na lateral esquerda, que o legado nao tem.
615:     *
616:     * O TabIndex = 5 do dump NAO eh transcrito aqui de proposito: com AddObject
617:     * o VFP9 numera pela ordem de criacao, e atribuir um valor isolado (ou
618:     * duplicado, ou fora da faixa de controles que ja existem) eh DESCARTADO em
619:     * silencio. A ordem de tabulacao exige um passe unico sobre TODOS os
620:     * controles focalizaveis, em ordem ascendente, depois do ultimo AddObject -
621:     * o que so pode acontecer quando os campos da Fase 5 existirem.
622:     *--------------------------------------------------------------------------
623:     PROTECTED PROCEDURE ConfigurarGrade()
624:         LOCAL loc_nI
625: 
626:         THIS.AddObject("grd_4c_Dados", "Grid")
627: 
628:         *-- Desfaz o vinculo que a grade herda do alias corrente (ver nota
629:         *-- acima): sem isto, as atribuicoes a Text1.Value abaixo GRAVAM no
630:         *-- cursor do chamador. Tem de vir ANTES de tudo o que mexe em Text1.
631:         THIS.grd_4c_Dados.ColumnCount  = 7
632:         THIS.grd_4c_Dados.RecordSource = ""
633: 
634:         FOR loc_nI = 1 TO THIS.grd_4c_Dados.ColumnCount
635:             THIS.grd_4c_Dados.Columns(loc_nI).ControlSource = ""
636:         ENDFOR
637: 
638:         WITH THIS.grd_4c_Dados
639:             .Top                = 172
640:             .Left               = 12
641:             .Width              = 986
642:             .Height             = 408
643:             .FontName           = "Tahoma"
644:             .FontSize           = 8
645:             .AllowHeaderSizing  = .F.
646:             .AllowRowSizing     = .F.
647:             .DeleteMark         = .F.
648:             .RecordMark         = .F.
649:             .HeaderHeight       = 20
650:             .RowHeight          = 18
651:             .ScrollBars         = 2
652:             .GridLineColor      = RGB(238, 238, 238)
653:             .HighlightBackColor = RGB(90, 90, 90)
654:             .ToolTipText        = "Grade de Itens"
655:             .Visible            = .T.
656:         ENDWITH
657: 
658:         *-- Column1 = PRODUTO ("Servico") - codigo do servico, char(14) na
659:         *-- tabela; o dump limita a digitacao em 10 (MaxLength do Text1), que eh
660:         *-- o que se transcreve - 10 cabe em char(14) e nao trunca na gravacao
661:         WITH THIS.grd_4c_Dados.Column1
662:             .FontName    = "Verdana"

*-- Linhas 1551 a 1569:
1551:             ENDIF
1552: 
1553:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
1554:                 SELECT cursor_4c_BuscaTam
1555:                 loc_cCodigo = ALLTRIM(cods)
1556:             ELSE
1557:                 *-- Legado: Lastkey() = 27 (ESC) limpa o campo
1558:                 loc_cCodigo = ""
1559:             ENDIF
1560: 
1561:             IF USED("cursor_4c_BuscaTam")
1562:                 USE IN cursor_4c_BuscaTam
1563:             ENDIF
1564: 
1565:             loc_oBusca.Release()
1566:         ENDIF
1567: 
1568:         RETURN loc_cCodigo
1569:     ENDPROC

*-- Linhas 1580 a 1655:
1580:     *   ThisForm.Get_Mercs.Value     = CrTmpPro.Mercs
1581:     *   ...
1582:     *   lcMercs = Iif(Not InList(CrTmpPro.Mercs,[JOI],[REL]),[JOI],CrTmpPro.Mercs)
1583:     *   Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite
1584:     *   Index On DPros Tag DPros / Index On Cpros Tag Cpros
1585:     *   Index On Cpros + IdeCPros Tag IdeCPros / Index On DPros + IdeCPros Tag IdeDPros
1586:     *
1587:     * A expressao de lcMercs eh transcrita LITERAL: quando a mercadoria do
1588:     * produto dono dos servicos nao eh JOI nem REL, o legado usa JOI - nao eh
1589:     * um default de conveniencia, eh regra (o universo de servicos de joia
1590:     * atende tambem as demais mercadorias).
1591:     *
1592:     * Os QUATRO indices do legado sao criados, mas os lookups usam LOCATE e nao
1593:     * SEEK: os dois compostos (Cpros + IdeCPros) tem chave maior do que o valor
1594:     * digitado, e o projeto roda com SET EXACT ON - SEEK de chave PARCIAL em
1595:     * indice COMPOSTO devolve .F. SEMPRE, em silencio. O legado escapa disso
1596:     * por rodar com outra configuracao; aqui a busca eh por LOCATE, que da o
1597:     * mesmo resultado sem depender do estado de EXACT.
1598:     *--------------------------------------------------------------------------
1599:     PROTECTED PROCEDURE CarregarServicosDisponiveis()
1600:         LOCAL loc_cCpros, loc_cMercs, loc_cMercsFiltro, loc_cLista, loc_nAreaAnterior
1601: 
1602:         loc_nAreaAnterior = SELECT()
1603:         loc_cLista        = THIS.this_cCursorLista
1604:         loc_cCpros        = ""
1605: 
1606:         *-- Codigo do produto dono dos servicos (crTpmMvItn.Cpros no legado)
1607:         IF USED(THIS.this_cCursorItem)
1608:             SELECT (THIS.this_cCursorItem)
1609: 
1610:             IF !EOF() AND TYPE(THIS.this_cCursorItem + ".cpros") = "C"
1611:                 loc_cCpros = ALLTRIM(cpros)
1612:             ENDIF
1613:         ENDIF
1614: 
1615:         *-- Mercadoria do produto; a descricao dele vem de carona, como no
1616:         *-- Cursorquery legado que traz dpros junto com Mercs. As tres ficam
1617:         *-- nas propriedades de ITEM do BO (this_c*Item), separadas das da
1618:         *-- linha de servico
1619:         THIS.this_oBusinessObject.this_cCprosItem = loc_cCpros
1620:         loc_cMercs = THIS.this_oBusinessObject.ObterMercadoriaProduto(loc_cCpros)
1621: 
1622:         *-- O default "JOI" vale so para FILTRAR o universo de servicos: o
1623:         *-- legado exibe em Get_Mercs a mercadoria CRUA do produto e so depois
1624:         *-- calcula lcMercs para o Select de csSigCdPro
1625:         loc_cMercsFiltro = IIF(!INLIST(loc_cMercs, "JOI", "REL"), "JOI", loc_cMercs)
1626: 
1627:         *-- Os tres campos de identificacao do produto, como no Init legado
1628:         THIS.BOParaForm()
1629: 
1630:         IF THIS.this_oBusinessObject.CarregarServicosDisponiveis(loc_cLista, loc_cMercsFiltro)
1631:             SELECT (loc_cLista)
1632:             INDEX ON DPros TAG DPros
1633:             INDEX ON Cpros TAG Cpros
1634:             INDEX ON Cpros + IdeCPros TAG IdeCPros
1635:             INDEX ON DPros + IdeCPros TAG IdeDPros
1636:             GO TOP
1637:         ENDIF
1638: 
1639:         IF loc_nAreaAnterior > 0
1640:             SELECT (loc_nAreaAnterior)
1641:         ENDIF
1642: 
1643:         RETURN
1644:     ENDPROC
1645: 
1646:     *--------------------------------------------------------------------------
1647:     * InstalarCelulasLookup - poe nas colunas "Servico" (Column1) e "Descricao"
1648:     * (Column7) os TextBox que carregam o When/Valid do legado.
1649:     *
1650:     * O legado tem o lookup no Valid do Text1 de CADA coluna. BINDEVENT em
1651:     * "Valid" de TextBox de Column NAO eh confiavel (regra #46), por isso o
1652:     * evento mora numa SUBCLASSE de TextBox posta na Column com AddObject +
1653:     * CurrentControl + Sparse = .F. (regra #18 - sem o CurrentControl o
1654:     * controle eh criado e a coluna continua desenhando o Text1 dela).
1655:     *

*-- Linhas 1663 a 1681:
1663:     *   duplo clique fora dela   -> BINDEVENT(grade, "DblClick", ...)
1664:     *
1665:     * Chamado por VincularGrade, nao so na inicializacao: atribuir
1666:     * RecordSource/ControlSource devolve Sparse e CurrentControl ao default, e
1667:     * a celula voltaria a ser o Text1 original sem o lookup.
1668:     *
1669:     * As propriedades visuais repetem as do Text1 configurado na Fase 4 - eh o
1670:     * controle da subclasse que passa a desenhar a celula, entao sem elas a
1671:     * coluna perderia fonte, mascara e borda.
1672:     *--------------------------------------------------------------------------
1673:     PROTECTED PROCEDURE InstalarCelulasLookup()
1674:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_CelServico", 5)
1675:             THIS.grd_4c_Dados.Column1.AddObject("txt_4c_CelServico", "TextBoxServicoSer_4c")
1676:         ENDIF
1677: 
1678:         WITH THIS.grd_4c_Dados.Column1.txt_4c_CelServico
1679:             .FontName       = "Verdana"
1680:             .FontSize       = 8
1681:             .BorderStyle    = 0

*-- Linhas 1731 a 1749:
1731:     * CelulaServicoLiberada / CelulaDescricaoLiberada - o When de cada coluna.
1732:     *
1733:     * Legado (PRODUTO.Text1.When):
1734:     *   Select crTpmMvItn3
1735:     *   ThisForm.AntCPro = This.Value
1736:     *   ThisForm.AntValu = crTpmMvItn.Units
1737:     *   Return Inlist(ThisForm.Op_Escolha, [INSERIR], [ALTERAR])
1738:     *
1739:     * Legado (Descricao.Text1.When): identico, mas o Return traz
1740:     *   And Empty(crTpmMvItn3.Cpros) - a descricao so aceita digitacao enquanto
1741:     * a linha NAO tem codigo; preenchido o codigo, a descricao vem dele.
1742:     *
1743:     * PUBLIC: sao chamados pela subclasse de TextBox, de FORA desta classe.
1744:     *--------------------------------------------------------------------------
1745:     PROCEDURE CelulaServicoLiberada(par_oTxt)
1746:         THIS.GuardarValorAnterior(par_oTxt)
1747: 
1748:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
1749:     ENDPROC

*-- Linhas 1756 a 1792:
1756:         loc_lSemCodigo = .T.
1757: 
1758:         IF USED(THIS.this_cCursorServicos)
1759:             SELECT (THIS.this_cCursorServicos)
1760:             loc_lSemCodigo = EOF() OR EMPTY(ALLTRIM(cpros))
1761:         ENDIF
1762: 
1763:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") AND loc_lSemCodigo
1764:     ENDPROC
1765: 
1766:     *--------------------------------------------------------------------------
1767:     * GuardarValorAnterior - as duas primeiras linhas do When das duas colunas.
1768:     * AntCPro guarda o que havia na celula antes da edicao (o Valid compara os
1769:     * dois para saber se o servico mudou) e AntValu, o valor unitario do item.
1770:     *--------------------------------------------------------------------------
1771:     PROTECTED PROCEDURE GuardarValorAnterior(par_oTxt)
1772:         IF VARTYPE(par_oTxt) = "O"
1773:             THIS.this_cAntCPro = par_oTxt.Value
1774:         ENDIF
1775: 
1776:         IF USED(THIS.this_cCursorItem)
1777:             SELECT (THIS.this_cCursorItem)
1778: 
1779:             IF !EOF() AND TYPE(THIS.this_cCursorItem + ".units") = "N"
1780:                 THIS.this_cAntValu = units
1781:             ENDIF
1782:         ENDIF
1783: 
1784:         RETURN
1785:     ENDPROC
1786: 
1787:     *--------------------------------------------------------------------------
1788:     * ValidarCelulaServico / ValidarCelulaDescricao - o Valid de cada coluna.
1789:     *
1790:     * Wrapper fino da guarda de reentrancia: o picker eh modal, devolve o foco
1791:     * a celula e faria o Valid disparar de novo. A flag eh liberada no wrapper,
1792:     * e nao no corpo, porque o corpo tem RETURN antecipado - liberar la dentro

*-- Linhas 1848 a 1866:
1848:     * AbrirBuscaServicoGrade - lookup da coluna "Servico" em csSigCdPro.
1849:     *
1850:     * Legado (PRODUTO.Text1.Valid):
1851:     *   Select csSigCdPro
1852:     *   Set Order to CPros
1853:     *   If !Seek(This.Value,[csSigCdPro],[IdeCPros])
1854:     *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','Cpros',This.Value,
1855:     *                               'Cadastro de Produtos')
1856:     *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
1857:     *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
1858:     *       loBrowse.Show
1859:     *       This.Value = CsSigCdPro.Cpros
1860:     *   Endif
1861:     *   Replace crTpmMvItn3.cpros with CrTmpPro.CPROS in crTpmMvItn3
1862:     *
1863:     * O browse eh sobre CURSOR LOCAL ja populado (fwbuscasel, nao fwbuscaext):
1864:     * a forma equivalente no projeto eh o FormBuscaAuxiliar sem parametros +
1865:     * DefinirCursor + Mostrar() - o Init com parametros consultaria o SQL
1866:     * Server e ignoraria o universo que CarregarServicosDisponiveis montou.

*-- Linhas 1890 a 1908:
1890: 
1891:         *-- Seek do legado, feito por LOCATE (ver nota de EXACT em
1892:         *-- CarregarServicosDisponiveis)
1893:         SELECT (loc_cLista)
1894:         GO TOP
1895:         LOCATE FOR ALLTRIM(Cpros) == loc_cDigitado
1896:         loc_lAchou = FOUND()
1897: 
1898:         IF !loc_lAchou
1899:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1900: 
1901:             IF VARTYPE(loc_oBusca) = "O"
1902:                 loc_oBusca.DefinirCursor(loc_cLista, "Cpros", "Dpros", ;
1903:                                          "Cadastro de Produtos")
1904:                 loc_oBusca.this_nColunas = 0
1905:                 loc_oBusca.mAddColuna("Cpros", "", "C" + CHR(243) + "digo")
1906:                 loc_oBusca.mAddColuna("Dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1907: 
1908:                 IF loc_oBusca.Mostrar()

*-- Linhas 1925 a 1943:
1925:     * AbrirBuscaDescricaoGrade - lookup da coluna "Descricao" em csSigCdPro.
1926:     *
1927:     * Legado (Descricao.Text1.Valid):
1928:     *   Select csSigCdPro
1929:     *   Go Top In csSigCdPro
1930:     *   Locate For DPros = This.Value
1931:     *   If Eof([csSigCdPro])
1932:     *       loBrowse = CreateObject('fwbuscasel','csSigCdPro','DPros',This.Value,
1933:     *                               'Cadastro de Produtos')
1934:     *       loBrowse.AddColuna('DPros','','Descricao', .T.,'DPros')
1935:     *       loBrowse.AddColuna('CPros','','Codigo', .t.,'CPros')
1936:     *       loBrowse.Show
1937:     *       This.Value = CsSigCdPro.DPros
1938:     *   Endif
1939:     *
1940:     * A ORDEM das colunas eh invertida de proposito: na busca por descricao o
1941:     * legado poe Descricao na frente, e eh o que o usuario ve no picker.
1942:     *
1943:     * O Locate do legado usa "=" (comparacao por PREFIXO quando EXACT esta

*-- Linhas 1959 a 1977:
1959:             RETURN
1960:         ENDIF
1961: 
1962:         SELECT (loc_cLista)
1963:         GO TOP
1964:         LOCATE FOR ALLTRIM(Dpros) == loc_cDigitado
1965: 
1966:         IF !FOUND()
1967:             GO TOP
1968:             LOCATE FOR UPPER(ALLTRIM(Dpros)) = UPPER(loc_cDigitado)
1969:         ENDIF
1970: 
1971:         loc_lAchou = FOUND()
1972: 
1973:         IF !loc_lAchou
1974:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1975: 
1976:             IF VARTYPE(loc_oBusca) = "O"
1977:                 loc_oBusca.DefinirCursor(loc_cLista, "Dpros", "Cpros", ;

*-- Linhas 2019 a 2048:
2019:             RETURN
2020:         ENDIF
2021: 
2022:         SELECT (loc_cLista)
2023:         GO TOP
2024:         LOCATE FOR ALLTRIM(Cpros) == loc_cCodigo
2025: 
2026:         IF !FOUND()
2027:             RETURN
2028:         ENDIF
2029: 
2030:         loc_cDescricao = ALLTRIM(EVALUATE(loc_cLista + ".Dpros"))
2031: 
2032:         IF USED(THIS.this_cCursorServicos)
2033:             SELECT (THIS.this_cCursorServicos)
2034: 
2035:             IF !EOF()
2036:                 REPLACE cpros WITH loc_cCodigo, ;
2037:                         dpros WITH loc_cDescricao
2038:             ENDIF
2039:         ENDIF
2040: 
2041:         WITH THIS.grd_4c_Dados
2042:             IF PEMSTATUS(.Column1, "txt_4c_CelServico", 5)
2043:                 .Column1.txt_4c_CelServico.Value = loc_cCodigo
2044:             ENDIF
2045: 
2046:             IF PEMSTATUS(.Column7, "txt_4c_CelDescricao", 5)
2047:                 .Column7.txt_4c_CelDescricao.Value = loc_cDescricao
2048:             ENDIF

*-- Linhas 2122 a 2278:
2122:     * Legado (Init):
2123:     *   Thisform.CItem   = crTpmMvItn.CItens
2124:     *   Thisform.nCItem2 = 1
2125:     *   Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens) Values ;
2126:     *       ( crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CItens )
2127:     *
2128:     * Os quatro valores desse Insert sao exatamente o contexto que o BO precisa
2129:     * para montar linha nova (sigopserBO.Inserir): empresa, operacao, numero do
2130:     * movimento e o item de produto dono dos servicos. Eles sao LIDOS aqui, uma
2131:     * vez, do cursor do item - e do cabecalho quando o item nao os traz, que eh
2132:     * de onde o mInsereLinha legado os le (TprMvCab.Emps/Dopes/Numes).
2133:     *
2134:     * Toda leitura eh guardada por USED()/EOF(): em modo de teste e em
2135:     * validacao de UI os cursores do chamador nao existem, e a tela tem de
2136:     * abrir do mesmo jeito. O alias da grade de servicos eh repassado ao BO
2137:     * sempre, porque eh ele que diz ao BO onde inserir e atualizar as linhas.
2138:     *
2139:     * A area de trabalho corrente eh salva e restaurada: este metodo roda
2140:     * dentro do Init do dialogo, na sessao de dados do CHAMADOR, e deixar outra
2141:     * area selecionada mudaria o alias corrente de quem abriu a tela.
2142:     *--------------------------------------------------------------------------
2143:     PROTECTED PROCEDURE ConfigurarContextoBO()
2144:         LOCAL loc_nAreaAnterior
2145: 
2146:         loc_nAreaAnterior = SELECT()
2147: 
2148:         WITH THIS.this_oBusinessObject
2149:             .this_cCursorAlias       = THIS.this_cCursorServicos
2150:             .this_lGarantia          = THIS.this_lGarantia
2151:             .this_lValorZeroGarantia = THIS.this_lValorZeroGarantia
2152:         ENDWITH
2153: 
2154:         *-- Legado: Thisform.CItem = crTpmMvItn.CItens
2155:         IF USED(THIS.this_cCursorItem)
2156:             SELECT (THIS.this_cCursorItem)
2157: 
2158:             IF !EOF()
2159:                 THIS.this_nCItem = TratarNulo(citens, 0)
2160: 
2161:                 WITH THIS.this_oBusinessObject
2162:                     .this_nCitemProduto = THIS.this_nCItem
2163:                     .this_cEmps         = TratarNulo(emps, "")
2164:                     .this_cDopes        = TratarNulo(dopes, "")
2165:                     .this_nNumes        = TratarNulo(numes, 0)
2166:                 ENDWITH
2167:             ENDIF
2168:         ENDIF
2169: 
2170:         *-- Cabecalho do movimento: eh de TprMvCab que o mInsereLinha legado le
2171:         *-- Emps/Dopes/Numes quando o cursor do item nao esta posicionado
2172:         IF EMPTY(THIS.this_oBusinessObject.this_cDopes) AND USED(THIS.this_cCursorCabecalho)
2173:             SELECT (THIS.this_cCursorCabecalho)
2174: 
2175:             IF !EOF()
2176:                 WITH THIS.this_oBusinessObject
2177:                     .this_cEmps  = TratarNulo(emps, "")
2178:                     .this_cDopes = TratarNulo(dopes, "")
2179:                     .this_nNumes = TratarNulo(numes, 0)
2180:                 ENDWITH
2181:             ENDIF
2182:         ENDIF
2183: 
2184:         *-- Legado: Thisform.nCItem2 = 1 (contador de linhas de csTmpDesc,
2185:         *-- reiniciado a cada abertura do dialogo)
2186:         THIS.this_nCItem2 = 1
2187: 
2188:         IF loc_nAreaAnterior > 0
2189:             SELECT (loc_nAreaAnterior)
2190:         ENDIF
2191: 
2192:         RETURN
2193:     ENDPROC
2194: 
2195:     *--------------------------------------------------------------------------
2196:     * CarregarLista - Monta e repinta a grade de servicos.
2197:     *
2198:     * Eh a transcricao da metade final do Init legado, na MESMA ordem:
2199:     *
2200:     *   1. Cursorquery('SigCdOpe','CrSigCdOpe',...)  -> CarregarConfiguracaoOperacao
2201:     *   2. Create Cursor csTmpDesc + Index iControle -> CriarCursorDescricoes
2202:     *   3. If INSERIR/ALTERAR ... Insert Into        -> GarantirLinhaEmBranco
2203:     *   4. Set Order/Set Key + Scan + Set Relation   -> MontarDescricoesPorLinha
2204:     *   5. Scan ... replace iconfs With .T.          -> MarcarConfirmacaoTamanho
2205:     *   6. With Thisform.fwgrade ... .Refresh        -> VincularGrade
2206:     *   7. Goto Bottom / Goto Top                    -> PosicionarGrade
2207:     *
2208:     * PUBLIC de proposito: eh chamada de FORA da classe (pelo harness de teste
2209:     * automatizado) e pelos handlers que repopulam a grade na Fase 7. Metodo
2210:     * PROTECTED chamado de fora estoura em runtime, e PEMSTATUS devolve .T.
2211:     * mesmo para o protegido, entao o teste entraria no ramo e so quebraria ao
2212:     * executar.
2213:     *
2214:     * Cada etapa eh guardada por USED(): em modo de teste e em validacao de UI
2215:     * os cursores do chamador nao existem, e a tela tem de abrir do mesmo jeito -
2216:     * com a grade vazia, como o legado tambem faz quando a consulta nao traz
2217:     * linha. O retorno .F. nao impede a abertura.
2218:     *--------------------------------------------------------------------------
2219:     PROCEDURE CarregarLista()
2220:         LOCAL loc_lSucesso, loc_nAreaAnterior, loc_oErro
2221: 
2222:         loc_lSucesso      = .F.
2223:         loc_nAreaAnterior = SELECT()
2224: 
2225:         TRY
2226:             *-- 1. Configuracao da operacao (casas decimais, moeda, filtros)
2227:             THIS.CarregarConfiguracaoOperacao()
2228: 
2229:             *-- 1.1 Universo de servicos consultado pelos dois lookups da
2230:             *--     grade (csSigCdPro). Depende de HabServs/ItSituas, lidos
2231:             *--     no passo anterior
2232:             THIS.CarregarServicosDisponiveis()
2233: 
2234:             *-- 2. Cursor das descricoes por linha (csTmpDesc)
2235:             THIS.CriarCursorDescricoes()
2236: 
2237:             *-- 3. Linha em branco para digitacao, so em INSERIR/ALTERAR
2238:             THIS.GarantirLinhaEmBranco()
2239: 
2240:             *-- 4. Numeracao das linhas + relacao com a grade
2241:             THIS.MontarDescricoesPorLinha()
2242: 
2243:             *-- 5. Marca as linhas que ja tem faixa de tamanho preenchida
2244:             THIS.MarcarConfirmacaoTamanho()
2245: 
2246:             *-- 6. RecordSource, ControlSource das 7 colunas e mascara do valor
2247:             THIS.VincularGrade()
2248: 
2249:             *-- 7. Posiciona e REPINTA (cursor cheio nao redesenha a grade
2250:             *--    sozinho: sem GO + Refresh a grade fica visualmente vazia)
2251:             THIS.PosicionarGrade()
2252: 
2253:             loc_lSucesso = .T.
2254:         CATCH TO loc_oErro
2255:             THIS.this_cMensagemErro = loc_oErro.Message
2256:             MsgErro(loc_oErro.Message + CHR(13) + ;
2257:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2258:                     "Procedure: " + loc_oErro.Procedure, ;
2259:                     "Erro ao carregar a grade de servi" + CHR(231) + "os")
2260:         ENDTRY
2261: 
2262:         IF loc_nAreaAnterior > 0
2263:             SELECT (loc_nAreaAnterior)
2264:         ENDIF
2265: 
2266:         RETURN loc_lSucesso
2267:     ENDPROC
2268: 
2269:     *--------------------------------------------------------------------------
2270:     * CarregarConfiguracaoOperacao - CrSigCdOpe do legado.
2271:     *
2272:     * Legado:
2273:     *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe', ;
2274:     *                                              'Dopes', TprMvCab.Dopes)
2275:     *
2276:     * De CrSigCdOpe saem as casas decimais do valor unitario (usadas na mascara
2277:     * da coluna VALOR), a moeda padrao, os flags de preco e os dois filtros que
2278:     * CarregarServicosDisponiveis usa para montar o universo de servicos

*-- Linhas 2297 a 2351:
2297: 
2298:         *-- (a) cursor da operacao que o chamador ja montou
2299:         IF USED(THIS.this_cCursorOperacao)
2300:             SELECT (THIS.this_cCursorOperacao)
2301: 
2302:             IF !EMPTY(loc_cDopes)
2303:                 LOCATE FOR ALLTRIM(dopes) == loc_cDopes
2304:             ELSE
2305:                 GO TOP
2306:             ENDIF
2307: 
2308:             loc_lAchou = !EOF()
2309:         ENDIF
2310: 
2311:         *-- (b) consulta propria - o Cursorquery do legado
2312:         IF !loc_lAchou AND !EMPTY(loc_cDopes) ;
2313:            AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2314: 
2315:             loc_cSQL = "SELECT Dopes, Casas, ZerQtds, PrecoAuts," + ;
2316:                        " PrecoPs, Precops, CMoes, ItSituas, HabServs" + ;
2317:                        " FROM SigCdOpe" + ;
2318:                        " WHERE Dopes = " + EscaparSQL(loc_cDopes)
2319: 
2320:             IF USED(THIS.this_cCursorOperacao)
2321:                 IF CURSORGETPROP("Buffering", THIS.this_cCursorOperacao) > 1
2322:                     TABLEREVERT(.T., THIS.this_cCursorOperacao)
2323:                 ENDIF
2324:                 USE IN (THIS.this_cCursorOperacao)
2325:             ENDIF
2326: 
2327:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)
2328: 
2329:             IF loc_nResultado < 0
2330:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
2331:                         "configura" + CHR(231) + CHR(227) + "o da opera" + ;
2332:                         CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), ;
2333:                         "Erro SQL")
2334:             ELSE
2335:                 IF USED(THIS.this_cCursorOperacao)
2336:                     SELECT (THIS.this_cCursorOperacao)
2337:                     GO TOP
2338:                     loc_lAchou = !EOF()
2339:                 ENDIF
2340:             ENDIF
2341:         ENDIF
2342: 
2343:         IF loc_lAchou
2344:             WITH THIS.this_oBusinessObject
2345:                 .this_nCasas     = TratarNulo(casas, 0)
2346:                 .this_nZerQtds   = TratarNulo(zerqtds, 0)
2347:                 .this_nPrecoAuts = TratarNulo(precoauts, 0)
2348:                 .this_cCMoes     = TratarNulo(cmoes, "")
2349:                 .this_nItSituas  = TratarNulo(itsituas, 0)
2350:                 .this_nHabServs  = TratarNulo(habservs, 0)
2351: 

*-- Linhas 2366 a 2530:
2366:     * CriarCursorDescricoes - csTmpDesc do legado.
2367:     *
2368:     * Legado:
2369:     *   Create Cursor csTmpDesc ( nLinhas N(4), nControle N(8), ;
2370:     *                             cDescTams C(20), cDescCors C(40), ;
2371:     *                             cDescEmbs C(20) )
2372:     *   Index On Str(nControle,8) Tag iControle
2373:     *
2374:     * nControle guarda o RECNO() da linha da grade e eh a chave da relacao que
2375:     * faz a coluna "item" acompanhar a linha corrente; nLinhas eh o numero
2376:     * sequencial que o usuario ve. As tres colunas de descricao (tamanho, cor e
2377:     * embalagem) vem do legado e sao preenchidas pelos handlers de tamanho.
2378:     *
2379:     * A estrutura eh transcrita LITERAL e num unico lugar: cursor recriado com
2380:     * ordem de campos diferente em outro ponto do form quebraria o
2381:     * APPEND FROM/ControlSource que casam por NOME.
2382:     *
2383:     * TABLEREVERT exige buffering - sem buffering ele dispara o erro 1586, e
2384:     * USE IN fecha o alias mesmo com buffer sujo. Por isso o teste de
2385:     * CURSORGETPROP antes.
2386:     *--------------------------------------------------------------------------
2387:     PROTECTED PROCEDURE CriarCursorDescricoes()
2388:         IF USED(THIS.this_cCursorDescricoes)
2389:             IF CURSORGETPROP("Buffering", THIS.this_cCursorDescricoes) > 1
2390:                 TABLEREVERT(.T., THIS.this_cCursorDescricoes)
2391:             ENDIF
2392:             USE IN (THIS.this_cCursorDescricoes)
2393:         ENDIF
2394: 
2395:         CREATE CURSOR csTmpDesc ( nLinhas   N(4), ;
2396:                                   nControle N(8), ;
2397:                                   cDescTams C(20), ;
2398:                                   cDescCors C(40), ;
2399:                                   cDescEmbs C(20) )
2400: 
2401:         INDEX ON STR(nControle, 8) TAG iControle
2402: 
2403:         RETURN
2404:     ENDPROC
2405: 
2406:     *--------------------------------------------------------------------------
2407:     * GarantirLinhaEmBranco - a linha vazia para digitacao.
2408:     *
2409:     * Legado (Init):
2410:     *   If InList(Thisform.Op_Escolha,'INSERIR','ALTERAR')
2411:     *       Select * From crTpmMvItn3 ;
2412:     *              Where CItens = crTpmMvItn.CItens And IsEmpty(Qtds) ;
2413:     *              Into Cursor csTemp
2414:     *       If _Tally = 0
2415:     *           Insert Into crTpmMvItn3 (Emps, Dopes, Numes, CItens) Values ;
2416:     *                  ( crTpmMvItn.Emps, crTpmMvItn.Dopes, ;
2417:     *                    crTpmMvItn.Numes, crTpmMvItn.CItens )
2418:     *       Endif
2419:     *   EndIf
2420:     *
2421:     * Ou seja: em INSERIR/ALTERAR a grade sempre termina com UMA linha de
2422:     * quantidade zerada, que eh onde o usuario digita o proximo servico - e so
2423:     * UMA, dai a contagem antes de inserir. Em VISUALIZAR nada eh acrescentado.
2424:     *
2425:     * A insercao vai pelo BO (sigopserBO.Inserir), que grava exatamente as
2426:     * mesmas quatro colunas de contexto; as demais propriedades de LINHA sao
2427:     * zeradas antes para a linha nascer em branco mesmo quando o BO acabou de
2428:     * carregar outro servico (CarregarLista eh chamada de novo pelos handlers).
2429:     *
2430:     * O SELECT de contagem leva WHERE proprio porque SELECT IGNORA o SET KEY /
2431:     * SET FILTER que escopa a grade - contar sem o WHERE traria os servicos de
2432:     * TODOS os itens do documento e a linha em branco nunca seria criada.
2433:     *--------------------------------------------------------------------------
2434:     PROTECTED PROCEDURE GarantirLinhaEmBranco()
2435:         LOCAL loc_nVazias, loc_nAreaAnterior, loc_cServicos, loc_nItem
2436: 
2437:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2438:             RETURN
2439:         ENDIF
2440: 
2441:         IF !USED(THIS.this_cCursorServicos)
2442:             RETURN
2443:         ENDIF
2444: 
2445:         loc_nAreaAnterior = SELECT()
2446:         loc_cServicos     = THIS.this_cCursorServicos
2447:         loc_nItem         = THIS.this_nCItem
2448: 
2449:         *-- O alias entra por MACRO: a clausula FROM do SELECT do VFP nao aceita
2450:         *-- nome entre parenteses (ao contrario do comando SELECT <alias>), e
2451:         *-- "&var." expande ANTES do parse, deixando o nome literal na consulta.
2452:         *-- O item vai numa variavel com prefixo "m." para o VFP nao tentar
2453:         *-- resolver o nome como COLUNA do cursor.
2454:         SELECT COUNT(*) AS nVazias ;
2455:             FROM &loc_cServicos. ;
2456:             WHERE citens = m.loc_nItem AND EMPTY(qtds) ;
2457:             INTO CURSOR cursor_4c_SerVazias NOFILTER
2458: 
2459:         loc_nVazias = 0
2460: 
2461:         IF USED("cursor_4c_SerVazias")
2462:             SELECT cursor_4c_SerVazias
2463:             IF !EOF()
2464:                 loc_nVazias = TratarNulo(nVazias, 0)
2465:             ENDIF
2466:             USE IN cursor_4c_SerVazias
2467:         ENDIF
2468: 
2469:         IF loc_nVazias = 0
2470:             *-- Linha NOVA: as colunas de servico tem de estar limpas, senao a
2471:             *-- linha nasceria com os dados do servico lido por ultimo
2472:             THIS.LimparDadosLinhaBO()
2473: 
2474:             IF !THIS.this_oBusinessObject.Inserir()
2475:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
2476:                         "Erro ao preparar a grade de servi" + CHR(231) + "os")
2477:             ENDIF
2478:         ENDIF
2479: 
2480:         IF loc_nAreaAnterior > 0
2481:             SELECT (loc_nAreaAnterior)
2482:         ENDIF
2483: 
2484:         RETURN
2485:     ENDPROC
2486: 
2487:     *--------------------------------------------------------------------------
2488:     * AplicarEscopoItem - restringe a grade aos servicos do item corrente.
2489:     *
2490:     * Legado: Select crTpmMvItn3 / Set Order To CItens / Set Key To <item>
2491:     *
2492:     * O SET KEY eh o que faz a grade mostrar SO os servicos deste item de
2493:     * produto - sem ele o usuario veria os servicos de todos os itens do
2494:     * documento. Depende do tag "CItens", que eh criado pelo form CHAMADOR ao
2495:     * montar o cursor; quando ele nao existe (cursor montado de outra forma, ou
2496:     * harness de teste), o escopo eh obtido com SET FILTER, que produz o MESMO
2497:     * conjunto de linhas - so sem a ordenacao pelo indice.
2498:     *
2499:     * Testar o tag em vez de confiar nele: SET ORDER TO sobre tag inexistente
2500:     * derruba a carga inteira.
2501:     *--------------------------------------------------------------------------
2502:     * As duas clausulas sao aplicadas na AREA CORRENTE (o SELECT abaixo), sem
2503:     * clausula "IN", e o SET FILTER eh montado por MACRO: SET FILTER GUARDA a
2504:     * expressao e a reavalia a cada movimento do cursor, quando este metodo ja
2505:     * terminou e "THIS" nao existe mais - a expressao tem de sair daqui com o
2506:     * NUMERO do item ja embutido.
2507:     *--------------------------------------------------------------------------
2508:     PROTECTED PROCEDURE AplicarEscopoItem()
2509:         LOCAL loc_nI, loc_lTemTag, loc_cFiltro, loc_nItem
2510: 
2511:         IF !USED(THIS.this_cCursorServicos)
2512:             RETURN
2513:         ENDIF
2514: 
2515:         SELECT (THIS.this_cCursorServicos)
2516: 
2517:         loc_nItem   = THIS.this_nCItem
2518:         loc_lTemTag = .F.
2519: 
2520:         FOR loc_nI = 1 TO TAGCOUNT("", THIS.this_cCursorServicos)
2521:             IF UPPER(ALLTRIM(TAG(loc_nI, THIS.this_cCursorServicos))) == "CITENS"
2522:                 loc_lTemTag = .T.
2523:                 EXIT
2524:             ENDIF
2525:         ENDFOR
2526: 
2527:         IF loc_lTemTag
2528:             SET ORDER TO TAG CItens
2529:             SET KEY TO loc_nItem
2530:         ELSE

*-- Linhas 2539 a 2561:
2539:     * MontarDescricoesPorLinha - numeracao das linhas e relacao com a grade.
2540:     *
2541:     * Legado (Init):
2542:     *   Select crTpmMvItn3 / Set Order To Citens / Set Key to ThisForm.CItem
2543:     *   Goto Bott
2544:     *   Thisform.nCItem2 = 1
2545:     *   Scan
2546:     *       Insert Into csTmpDesc ( nControle, nLinhas ) Values ;
2547:     *              ( RecNo('crTpmMvItn3'), Thisform.nCItem2 )
2548:     *       Thisform.nCItem2 = Thisform.nCItem2 + 1
2549:     *   EndScan
2550:     *   Goto Top
2551:     *   Set Relation To Str(Recno('crTpmMvItn3'),8) Into csTmpDesc
2552:     *
2553:     * O contador nCItem2 comeca em 1 e sobra apontando para a PROXIMA linha:
2554:     * eh esse valor que o mInsereLinha do legado usa ao acrescentar uma linha
2555:     * nova, e por isso ele continua guardado na propriedade do form.
2556:     *
2557:     * A RELACAO eh o que liga a coluna "item" (csTmpDesc.nLinhas) a linha
2558:     * corrente da grade: sem ela a coluna exibiria sempre o mesmo numero.
2559:     * Ela exige csTmpDesc na ordem do tag iControle, que eh a mesma expressao
2560:     * STR(nControle,8) usada do outro lado.
2561:     *

*-- Linhas 2573 a 2702:
2573:         *-- Legado: Thisform.nCItem2 = 1 antes de percorrer
2574:         THIS.this_nCItem2 = 1
2575: 
2576:         SELECT (THIS.this_cCursorServicos)
2577:         GO TOP
2578: 
2579:         SCAN
2580:             INSERT INTO csTmpDesc (nControle, nLinhas) ;
2581:                 VALUES (RECNO(THIS.this_cCursorServicos), THIS.this_nCItem2)
2582: 
2583:             THIS.this_nCItem2 = THIS.this_nCItem2 + 1
2584: 
2585:             SELECT (THIS.this_cCursorServicos)
2586:         ENDSCAN
2587: 
2588:         SELECT (THIS.this_cCursorServicos)
2589:         GO TOP
2590: 
2591:         *-- SET ORDER do lado FILHO + SET RELATION, em metodo unico porque o
2592:         *-- legado repete os dois comandos tambem no mInsereLinha
2593:         THIS.AplicarRelacaoDescricoes()
2594: 
2595:         RETURN
2596:     ENDPROC
2597: 
2598:     *--------------------------------------------------------------------------
2599:     * MarcarConfirmacaoTamanho - o iconfs das linhas que ja tem faixa.
2600:     *
2601:     * Legado (Init):
2602:     *   Select crTpmMvItn3 / Go Top
2603:     *   Scan
2604:     *       If Not Empty(TamDe) and Not Empty(TamPara)
2605:     *           replace iconfs With .T. In crTpmMvItn3
2606:     *       EndIf
2607:     *       Select crTpmMvItn3
2608:     *   EndScan
2609:     *
2610:     * iconfs eh o que faz o painel "Tamanho" aparecer na linha (handler
2611:     * AfterRowColChange, Fase 7) e o que o botao Retornar confere antes de
2612:     * fechar: linha marcada sem De/Para preenchidos eh recusada. Marcar aqui,
2613:     * na abertura, eh como o legado garante que linha vinda do banco com faixa
2614:     * preenchida ja chegue confirmada.
2615:     *
2616:     * A coluna eh "bit" no SQL Server e chega ao cursor VFP ora como Logico ora
2617:     * como Numerico, conforme o driver: o tipo eh medido UMA vez e o REPLACE usa
2618:     * o valor compativel - comparar ou gravar o tipo errado dispara
2619:     * "Operator/operand type mismatch".
2620:     *--------------------------------------------------------------------------
2621:     PROTECTED PROCEDURE MarcarConfirmacaoTamanho()
2622:         LOCAL loc_lColunaLogica
2623: 
2624:         IF !USED(THIS.this_cCursorServicos)
2625:             RETURN
2626:         ENDIF
2627: 
2628:         SELECT (THIS.this_cCursorServicos)
2629:         GO TOP
2630: 
2631:         IF EOF()
2632:             RETURN
2633:         ENDIF
2634: 
2635:         loc_lColunaLogica = (VARTYPE(iconfs) = "L")
2636: 
2637:         *-- O "In crTpmMvItn3" do legado eh redundante aqui: o SCAN roda sobre a
2638:         *-- area que acabou de ser selecionada, entao o REPLACE sem clausula IN
2639:         *-- atinge exatamente o mesmo registro
2640:         SCAN
2641:             IF !EMPTY(tamde) AND !EMPTY(tampara)
2642:                 IF loc_lColunaLogica
2643:                     REPLACE iconfs WITH .T.
2644:                 ELSE
2645:                     REPLACE iconfs WITH 1
2646:                 ENDIF
2647:             ENDIF
2648: 
2649:             SELECT (THIS.this_cCursorServicos)
2650:         ENDSCAN
2651: 
2652:         RETURN
2653:     ENDPROC
2654: 
2655:     *--------------------------------------------------------------------------
2656:     * VincularGrade - RecordSource e ControlSource das sete colunas.
2657:     *
2658:     * Legado (Init):
2659:     *   With Thisform.fwgrade
2660:     *       .Recordsource            = 'crTpmMvItn3'
2661:     *       .Item.ControlSource      = "csTmpDesc.nLinhas"
2662:     *       .Produto.Controlsource   = 'crTpmMvItn3.cpros'
2663:     *       .Qtd.Controlsource       = 'crTpmMvItn3.qtds'
2664:     *       .Valor.Controlsource     = 'crTpmMvItn3.units'
2665:     *       lcMask = '99999999.' + Repl( '9', iif(CrSigCdOpe.Casas < 2, 2, CrSigCdOpe.Casas) )
2666:     *       lcMask = Right( lcMask, 11 )
2667:     *       .Valor.Inputmask         = lcMask
2668:     *       .Valor.Text1.Inputmask   = lcMask
2669:     *       .Moeda.Controlsource     = 'crTpmMvItn3.moedas'
2670:     *       .Total.Controlsource     = 'crTpmMvItn3.totas'
2671:     *       .Descricao.Controlsource = 'crTpmMvItn3.Dpros'
2672:     *       .Refresh
2673:     *   EndWith
2674:     *
2675:     * A formula da mascara eh TRANSCRITA, nao reescrita: o piso de 2 casas e o
2676:     * RIGHT(...,11) que limita o tamanho total sao regra de negocio - a coluna
2677:     * units tem 6 decimais no banco, e uma mascara mais larga do que o legado
2678:     * deixaria o usuario digitar o que a tela nao grava.
2679:     *
2680:     * Ordem obrigatoria: RecordSource -> ControlSource -> Width -> Header,
2681:     * porque mexer no RecordSource RECALCULA as larguras das colunas para o
2682:     * default 90 e limpa os captions dos headers. Nao se toca em ColumnCount
2683:     * aqui: qualquer atribuicao a ColumnCount RECRIA os objetos Column e
2684:     * destruiria tudo o que ConfigurarGrade montou.
2685:     *
2686:     * A coluna "item" so eh amarrada quando csTmpDesc existe - Column.
2687:     * ControlSource apontando para alias inexistente derruba a carga.
2688:     *
2689:     * DynamicForeColor da coluna QTD: o SCX declara
2690:     *   "iif(crTpmMvItn.iconfs=.t.,rgb(0,0,255),rgb(0,0,0))"
2691:     * citando o cursor do ITEM (crTpmMvItn), e nao o da grade (crTpmMvItn3).
2692:     * Transcrito como esta - a expressao eh avaliada a cada repintura e "corrigi
2693:     * -la" para o cursor da grade mudaria a cor que o usuario ve hoje. So eh
2694:     * atribuida quando aquele cursor esta aberto: expressao dinamica sobre alias
2695:     * fechado estoura no Refresh.
2696:     *--------------------------------------------------------------------------
2697:     PROTECTED PROCEDURE VincularGrade()
2698:         LOCAL loc_cMascara, loc_nCasas, loc_cServicos
2699: 
2700:         IF !USED(THIS.this_cCursorServicos)
2701:             RETURN
2702:         ENDIF

*-- Linhas 2711 a 2739:
2711:         WITH THIS.grd_4c_Dados
2712:             .RecordSource = loc_cServicos
2713: 
2714:             .Column1.ControlSource = loc_cServicos + ".cpros"
2715:             .Column2.ControlSource = loc_cServicos + ".qtds"
2716:             .Column3.ControlSource = loc_cServicos + ".units"
2717:             .Column4.ControlSource = loc_cServicos + ".moedas"
2718:             .Column5.ControlSource = loc_cServicos + ".totas"
2719:             .Column7.ControlSource = loc_cServicos + ".dpros"
2720:         ENDWITH
2721: 
2722:         *-- Coluna "item": numero sequencial vindo de csTmpDesc pela relacao
2723:         IF USED(THIS.this_cCursorDescricoes)
2724:             THIS.grd_4c_Dados.Column6.ControlSource = ;
2725:                 THIS.this_cCursorDescricoes + ".nLinhas"
2726:         ENDIF
2727: 
2728:         *-- Mascara calculada, na Column E no Text1 que desenha a celula
2729:         THIS.grd_4c_Dados.Column3.InputMask       = loc_cMascara
2730:         THIS.grd_4c_Dados.Column3.Text1.InputMask = loc_cMascara
2731: 
2732:         *-- Larguras REAPLICADAS: o RecordSource acima as devolveu ao default
2733:         WITH THIS.grd_4c_Dados
2734:             .Column1.Width = 120    && PRODUTO
2735:             .Column2.Width = 120    && QTD
2736:             .Column3.Width = 120    && VALOR
2737:             .Column4.Width = 33     && MOEDA
2738:             .Column5.Width = 120    && TOTAL
2739:             .Column6.Width = 31     && item

*-- Linhas 2760 a 2815:
2760:         ENDIF
2761: 
2762:         *-- REINSTALADAS aqui, e nao so na inicializacao: o RecordSource/
2763:         *-- ControlSource atribuidos acima devolvem Sparse e CurrentControl ao
2764:         *-- default, e as duas celulas de lookup voltariam a ser o Text1 da
2765:         *-- coluna, sem o When/Valid do legado
2766:         THIS.InstalarCelulasLookup()
2767: 
2768:         *-- Idem para as celulas de quantidade e de valor, e para o ReadOnly
2769:         *-- das tres colunas somente-exibicao (o "Return .f." do When delas)
2770:         THIS.InstalarCelulasEdicao()
2771: 
2772:         RETURN
2773:     ENDPROC
2774: 
2775:     *--------------------------------------------------------------------------
2776:     * PosicionarGrade - posiciona a linha corrente e REPINTA a grade.
2777:     *
2778:     * Legado (Init):
2779:     *   Select crTpmMvItn3
2780:     *   If InList( Thisform.Op_Escolha, 'INSERIR', 'ALTERAR' )
2781:     *       Goto Bottom
2782:     *   Else
2783:     *       Goto Top
2784:     *   EndIf
2785:     *
2786:     * O criterio eh do legado e tem razao de ser: em INSERIR/ALTERAR a ultima
2787:     * linha eh justamente a linha em branco criada por GarantirLinhaEmBranco,
2788:     * onde o usuario vai digitar; em VISUALIZAR a grade abre no primeiro
2789:     * servico. No legado esse trecho vem ANTES do Scan de iconfs, que percorre o
2790:     * cursor inteiro e o deixa em EOF - o posicionamento eh reaplicado aqui, no
2791:     * FIM da carga, para que a grade abra na linha que o legado escolheu em vez
2792:     * de abrir sem linha corrente.
2793:     *
2794:     * O Refresh eh obrigatorio: encher o cursor NAO repinta a grade sozinha, e
2795:     * sem ele a tela aparece vazia com o cursor cheio - sintoma que manda o
2796:     * diagnostico para o SQL quando o problema eh so de repintura.
2797:     *--------------------------------------------------------------------------
2798:     PROTECTED PROCEDURE PosicionarGrade()
2799:         IF USED(THIS.this_cCursorServicos)
2800:             SELECT (THIS.this_cCursorServicos)
2801: 
2802:             IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2803:                 GO BOTTOM
2804:             ELSE
2805:                 GO TOP
2806:             ENDIF
2807:         ENDIF
2808: 
2809:         THIS.grd_4c_Dados.Refresh()
2810: 
2811:         RETURN
2812:     ENDPROC
2813: 
2814:     *--------------------------------------------------------------------------
2815:     * Activate - foco inicial na grade.

*-- Linhas 3000 a 3049:
3000:         LOCAL loc_lTemLinha, loc_nAreaAnterior
3001: 
3002:         loc_lTemLinha     = .F.
3003:         loc_nAreaAnterior = SELECT()
3004: 
3005:         IF USED(THIS.this_cCursorServicos)
3006:             SELECT (THIS.this_cCursorServicos)
3007: 
3008:             IF !EOF()
3009:                 loc_lTemLinha = THIS.this_oBusinessObject.CarregarDoCursor( ;
3010:                                     THIS.this_cCursorServicos)
3011:             ENDIF
3012:         ENDIF
3013: 
3014:         *-- Sem linha corrente o legado deixa os dois campos vazios: as
3015:         *-- propriedades da LINHA sao zeradas para que BOParaForm as espelhe
3016:         IF !loc_lTemLinha
3017:             THIS.LimparDadosLinhaBO()
3018:         ENDIF
3019: 
3020:         IF loc_nAreaAnterior > 0
3021:             SELECT (loc_nAreaAnterior)
3022:         ENDIF
3023: 
3024:         THIS.BOParaForm()
3025: 
3026:         RETURN
3027:     ENDPROC
3028: 
3029:     *--------------------------------------------------------------------------
3030:     * GradeAfterRowColChange - fwGrade.AfterRowColChange do legado.
3031:     *
3032:     * Legado:
3033:     *   LPARAMETERS nColIndex
3034:     *   Select crTpmMvItn3
3035:     *   If crTpmMvItn3.iconfs
3036:     *       ThisForm.cntTamanho.Visible = .T.
3037:     *   Else
3038:     *       ThisForm.cntTamanho.Visible = .F.
3039:     *   EndIf
3040:     *   ThisForm.cntTamanho.getTamDe.Value   = crTpmMvItn3.TamDe
3041:     *   ThisForm.cntTamanho.getTamPara.Value = crTpmMvItn3.TamPara
3042:     *
3043:     * Este eh o uso CERTO de AfterRowColChange: carregar o detalhe da linha
3044:     * CORRENTE. O que nao se faz aqui eh validar celula por nColIndex - ali o
3045:     * indice recebido eh o da coluna de DESTINO e a validacao rodaria na linha
3046:     * errada (regra #46); a validacao das celulas de servico mora no Valid das
3047:     * subclasses instaladas por InstalarCelulasLookup.
3048:     *
3049:     * iconfs vem de coluna "bit" do SQL Server e chega ao VFP ora Logico ora

*-- Linhas 3060 a 3078:
3060:         loc_lConfirma = .F.
3061: 
3062:         IF USED(THIS.this_cCursorServicos)
3063:             SELECT (THIS.this_cCursorServicos)
3064: 
3065:             IF !EOF()
3066:                 DO CASE
3067:                 CASE VARTYPE(iconfs) = "L"
3068:                     loc_lConfirma = iconfs
3069:                 CASE VARTYPE(iconfs) = "N"
3070:                     loc_lConfirma = (iconfs <> 0)
3071:                 CASE VARTYPE(iconfs) = "C"
3072:                     loc_lConfirma = (UPPER(LEFT(ALLTRIM(iconfs), 1)) == "S")
3073:                 ENDCASE
3074:             ENDIF
3075:         ENDIF
3076: 
3077:         THIS.cnt_4c_Tamanho.Visible = loc_lConfirma
3078: 

*-- Linhas 3179 a 3197:
3179:     *
3180:     * Legado:
3181:     *   Do Form SigOpCot With ThisForm.ParentForm, TprMvCab.Datas
3182:     *   Select crTpmMvItn
3183:     *   Set Order To
3184:     *   Scan
3185:     *       If Not ThisForm.ParentForm.PodataMgr.CursorQuery([SigCdPro],
3186:     *                                 [crTmpPro], [CPros], crTpmMvItn.CPros)
3187:     *           Loop
3188:     *       EndIf
3189:     *       Replace AltImpost With .f. In crTpmMvItn
3190:     *       ThisForm.Calc_Valite()
3191:     *   EndScan
3192:     *
3193:     * O Caption diz "Excluir Servicos" mas o Click NAO exclui nada: abre a tela
3194:     * de Cambio (SigOpCot) e, na volta, zera a marca de imposto alterado de
3195:     * cada item cujo produto ainda existe em SigCdPro, remontando o total. O
3196:     * nome do botao esta errado no legado; o COMPORTAMENTO eh este, e eh ele
3197:     * que se transcreve.

*-- Linhas 3219 a 3295:
3219: 
3220:         *-- Legado: TprMvCab.Datas (data do cabecalho do movimento)
3221:         IF USED(THIS.this_cCursorCabecalho)
3222:             loc_nAreaAnterior = SELECT()
3223:             SELECT (THIS.this_cCursorCabecalho)
3224: 
3225:             IF !EOF() AND INLIST(TYPE(THIS.this_cCursorCabecalho + ".datas"), "D", "T")
3226:                 loc_dDatas = ConverterParaData(datas)
3227:             ENDIF
3228: 
3229:             IF loc_nAreaAnterior > 0
3230:                 SELECT (loc_nAreaAnterior)
3231:             ENDIF
3232:         ENDIF
3233: 
3234:         TRY
3235:             loc_oForm = CREATEOBJECT("FormSigOpCot", THIS.this_oFormPai, loc_dDatas)
3236:         CATCH TO loc_oErro
3237:             MostrarErro("Erro ao abrir C" + CHR(226) + "mbio:" + CHR(13) + ;
3238:                         loc_oErro.Message, "Erro")
3239:             loc_oForm = .NULL.
3240:         ENDTRY
3241: 
3242:         IF VARTYPE(loc_oForm) = "O"
3243:             loc_oForm.Show()
3244:         ENDIF
3245: 
3246:         *-- Volta do cambio: refaz a marca de imposto e o total de cada item
3247:         IF USED(THIS.this_cCursorItem)
3248:             loc_nAreaAnterior = SELECT()
3249: 
3250:             SELECT (THIS.this_cCursorItem)
3251:             SET ORDER TO
3252: 
3253:             loc_cTipoAltImpost = TYPE(THIS.this_cCursorItem + ".altimpost")
3254: 
3255:             SCAN
3256:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))
3257: 
3258:                 IF !THIS.ProdutoExisteNoCadastro(loc_cCpros)
3259:                     SELECT (THIS.this_cCursorItem)
3260:                     LOOP
3261:                 ENDIF
3262: 
3263:                 SELECT (THIS.this_cCursorItem)
3264: 
3265:                 DO CASE
3266:                 CASE loc_cTipoAltImpost = "L"
3267:                     REPLACE altimpost WITH .F.
3268:                 CASE loc_cTipoAltImpost = "N"
3269:                     REPLACE altimpost WITH 0
3270:                 CASE loc_cTipoAltImpost = "C"
3271:                     REPLACE altimpost WITH "N"
3272:                 ENDCASE
3273: 
3274:                 THIS.TotalizarLinha()
3275: 
3276:                 SELECT (THIS.this_cCursorItem)
3277:             ENDSCAN
3278: 
3279:             IF loc_nAreaAnterior > 0
3280:                 SELECT (loc_nAreaAnterior)
3281:             ENDIF
3282:         ENDIF
3283: 
3284:         THIS.grd_4c_Dados.Refresh()
3285: 
3286:         RETURN
3287:     ENDPROC
3288: 
3289:     *--------------------------------------------------------------------------
3290:     * ProdutoExisteNoCadastro - o CursorQuery([SigCdPro],[crTmpPro],[CPros],..)
3291:     * do legado, reduzido ao que o chamador precisa saber: o produto existe?
3292:     *
3293:     * O cursor de destino mantem o nome do legado (crTmpPro) e as mesmas
3294:     * colunas, porque o form de Movimentacao que abriu este dialogo tambem o
3295:     * consulta - trocar o nome quebraria o contrato com ele.

*-- Linhas 3301 a 3356:
3301:         LOCAL loc_lExiste, loc_cSQL, loc_nResultado, loc_nAreaAnterior, loc_oErro
3302: 
3303:         loc_lExiste       = .F.
3304:         loc_nAreaAnterior = SELECT()
3305: 
3306:         TRY
3307:             IF VARTYPE(par_cCpros) = "C" AND !EMPTY(ALLTRIM(par_cCpros)) ;
3308:                AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
3309: 
3310:                 loc_cSQL = "SELECT cpros, dpros, mercs FROM SigCdPro" + ;
3311:                            " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
3312: 
3313:                 IF USED("crTmpPro")
3314:                     IF CURSORGETPROP("Buffering", "crTmpPro") > 1
3315:                         TABLEREVERT(.T., "crTmpPro")
3316:                     ENDIF
3317:                     USE IN crTmpPro
3318:                 ENDIF
3319: 
3320:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crTmpPro")
3321: 
3322:                 IF loc_nResultado < 0
3323:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
3324:                             "produto do item." + CHR(13) + CapturarErroSQL(), "Erro SQL")
3325:                 ELSE
3326:                     IF USED("crTmpPro")
3327:                         SELECT crTmpPro
3328:                         GO TOP
3329:                         loc_lExiste = !EOF()
3330:                     ENDIF
3331:                 ENDIF
3332:             ENDIF
3333:         CATCH TO loc_oErro
3334:             MsgErro(loc_oErro.Message + CHR(13) + ;
3335:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3336:                     "Procedure: " + loc_oErro.Procedure, ;
3337:                     "Erro ao consultar o produto")
3338:         ENDTRY
3339: 
3340:         IF loc_nAreaAnterior > 0
3341:             SELECT (loc_nAreaAnterior)
3342:         ENDIF
3343: 
3344:         RETURN loc_lExiste
3345:     ENDFUNC
3346: 
3347:     *--------------------------------------------------------------------------
3348:     * BtnAltImpsClick - btnAltImps.Click do legado ("Alterar Valores").
3349:     *
3350:     * Legado:
3351:     *   If Not Empty(crTpmMvItn3.CPros)
3352:     *       _Retorno = [*] + Usuar
3353:     *       ThisForm.lAutPreco = (Left(_Retorno, 1) = [*])
3354:     *       If ThisForm.lAutPreco
3355:     *           ThisForm.fwgrade.SetFocus
3356:     *           ThisForm.fwgrade.Valor.SetFocus

*-- Linhas 3377 a 3403:
3377:         loc_cCpros = ""
3378: 
3379:         IF USED(THIS.this_cCursorServicos)
3380:             loc_nAreaAnterior = SELECT()
3381:             SELECT (THIS.this_cCursorServicos)
3382: 
3383:             IF !EOF()
3384:                 loc_cCpros = ALLTRIM(TratarNulo(cpros, ""))
3385:             ENDIF
3386: 
3387:             IF loc_nAreaAnterior > 0
3388:                 SELECT (loc_nAreaAnterior)
3389:             ENDIF
3390:         ENDIF
3391: 
3392:         IF EMPTY(loc_cCpros)
3393:             MsgAviso("Selecione um Produto Para Ter o Pre" + CHR(231) + "o Alterado", ;
3394:                      "Aten" + CHR(231) + CHR(227) + "o!!!")
3395:             RETURN
3396:         ENDIF
3397: 
3398:         loc_cRetorno        = "*" + gc_4c_UsuarioLogado
3399:         THIS.this_lAutPreco = (LEFT(loc_cRetorno, 1) == "*")
3400: 
3401:         IF THIS.this_lAutPreco
3402:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.Enabled
3403:                 THIS.grd_4c_Dados.SetFocus()

*-- Linhas 3417 a 3526:
3417:     *
3418:     * Legado (cntOK.btnSair.Click):
3419:     *   If InList(Thisform.op_escolha,[INSERIR],[ALTERAR])
3420:     *       lnOldSel = Select()
3421:     *       If Used([csValConfs]) / Use in csValConfs / EndIf
3422:     *       Select crTpmMvItn3
3423:     *       Select Count(1) as Qtd From crTpmMvItn3
3424:     *           Where iConfs = .T. and (Empty(TamDe) or Empty(TamPara))
3425:     *           Into Cursor csValConfs ReadWrite
3426:     *       Select csValConfs
3427:     *       If Reccount([csValConfs])>0 And csValConfs.Qtd > 0
3428:     *           MessageBox([Existe Servicos sem Informar os campos :] + Chr(13) +
3429:     *                      [TAMANHO DE ou o TAMANHO PARA.] + Chr(13) +
3430:     *                      [Favor Verificar!!!],0+48,[Aviso])
3431:     *           Select(lnOldSel)
3432:     *           Return .F.
3433:     *       EndIf
3434:     *       Select(lnOldSel)
3435:     *   EndIf
3436:     *
3437:     * So vale em INSERIR/ALTERAR - em VISUALIZAR o usuario sai sempre, como no
3438:     * legado.
3439:     *
3440:     * O cursor conserva o nome csValConfs do legado e a area de trabalho
3441:     * anterior eh restaurada (lnOldSel), porque este dialogo roda na sessao de
3442:     * dados do CHAMADOR e deixar outra area selecionada mudaria o alias
3443:     * corrente dele.
3444:     *
3445:     * A condicao "iConfs = .T." vai por MACRO porque a coluna chega Logica ou
3446:     * Numerica conforme o driver que montou o cursor - comparar Logico com
3447:     * numero estoura "Operator/operand type mismatch" (regra #13).
3448:     *
3449:     * O alias da grade tambem entra por macro: a clausula FROM do SELECT do VFP
3450:     * nao aceita nome entre parenteses.
3451:     *--------------------------------------------------------------------------
3452:     PROTECTED FUNCTION ValidarTamanhosInformados()
3453:         LOCAL loc_lOk, loc_nOldSel, loc_cServicos, loc_cCondIconfs, loc_nQtd
3454: 
3455:         loc_lOk = .T.
3456: 
3457:         IF !INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3458:             RETURN .T.
3459:         ENDIF
3460: 
3461:         IF !USED(THIS.this_cCursorServicos)
3462:             RETURN .T.
3463:         ENDIF
3464: 
3465:         loc_nOldSel   = SELECT()
3466:         loc_cServicos = THIS.this_cCursorServicos
3467: 
3468:         SELECT (loc_cServicos)
3469: 
3470:         DO CASE
3471:         CASE VARTYPE(iconfs) = "L"
3472:             loc_cCondIconfs = "iconfs"
3473:         CASE VARTYPE(iconfs) = "N"
3474:             loc_cCondIconfs = "iconfs <> 0"
3475:         OTHERWISE
3476:             loc_cCondIconfs = "UPPER(LEFT(ALLTRIM(iconfs), 1)) == 'S'"
3477:         ENDCASE
3478: 
3479:         IF USED("csValConfs")
3480:             USE IN csValConfs
3481:         ENDIF
3482: 
3483:         SELECT COUNT(1) AS Qtd ;
3484:             FROM &loc_cServicos. ;
3485:             WHERE &loc_cCondIconfs. AND (EMPTY(tamde) OR EMPTY(tampara)) ;
3486:             INTO CURSOR csValConfs READWRITE
3487: 
3488:         loc_nQtd = 0
3489: 
3490:         IF USED("csValConfs")
3491:             SELECT csValConfs
3492: 
3493:             IF RECCOUNT("csValConfs") > 0
3494:                 GO TOP
3495:                 loc_nQtd = TratarNulo(Qtd, 0)
3496:             ENDIF
3497:         ENDIF
3498: 
3499:         IF loc_nQtd > 0
3500:             MsgAviso("Existe Servi" + CHR(231) + "os sem Informar os campos :" + ;
3501:                      CHR(13) + "TAMANHO DE ou o TAMANHO PARA." + CHR(13) + ;
3502:                      "Favor Verificar!!!", "Aviso")
3503:             loc_lOk = .F.
3504:         ENDIF
3505: 
3506:         IF USED("csValConfs")
3507:             USE IN csValConfs
3508:         ENDIF
3509: 
3510:         IF loc_nOldSel > 0
3511:             SELECT (loc_nOldSel)
3512:         ENDIF
3513: 
3514:         RETURN loc_lOk
3515:     ENDFUNC
3516: 
3517:     *--------------------------------------------------------------------------
3518:     * BtnRetornarClick - cntOK.btnSair.Click do legado (o botao "Retornar").
3519:     *
3520:     * Legado, depois da validacao acima:
3521:     *   ThisForm.poForm.Enabled = .t.
3522:     *   ThisForm.Release
3523:     *
3524:     * Validacao reprovada ABORTA o fechamento - eh o "Return .F." do legado, e
3525:     * eh o que mantem o usuario na tela para completar a faixa de tamanho.
3526:     *

*-- Linhas 3596 a 3614:
3596:     * o valor posto aqui (regra #18).
3597:     *
3598:     * Chamado por VincularGrade, logo apos InstalarCelulasLookup e pelo mesmo
3599:     * motivo: atribuir RecordSource/ControlSource devolve Sparse e
3600:     * CurrentControl ao default, e as celulas voltariam a ser o Text1 original,
3601:     * sem os eventos do legado.
3602:     *
3603:     * A mascara do valor eh LIDA da Column3 em vez de repetida: ela eh
3604:     * calculada em VincularGrade a partir das casas decimais da operacao, e
3605:     * duplicar o numero aqui faria as duas copias divergirem.
3606:     *--------------------------------------------------------------------------
3607:     PROTECTED PROCEDURE InstalarCelulasEdicao()
3608:         LOCAL loc_cMascaraValor
3609: 
3610:         *-- Column2 = QTD
3611:         IF !PEMSTATUS(THIS.grd_4c_Dados.Column2, "txt_4c_CelQtd", 5)
3612:             THIS.grd_4c_Dados.Column2.AddObject("txt_4c_CelQtd", "TextBoxQtdSer_4c")
3613:         ENDIF
3614: 

*-- Linhas 3684 a 3718:
3684:         loc_lTemServico = .F.
3685: 
3686:         IF USED(THIS.this_cCursorServicos)
3687:             SELECT (THIS.this_cCursorServicos)
3688:             loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
3689:         ENDIF
3690: 
3691:         RETURN loc_lTemServico AND INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3692:     ENDPROC
3693: 
3694:     *--------------------------------------------------------------------------
3695:     * ValidarCelulaQtd - o Valid da coluna "Quantidade".
3696:     *
3697:     * Legado (QTD.Text1.Valid):
3698:     *   =ThisForm.Parentform.poDataMgr.Cursorquery('SigCdOpe','CrSigCdOpe',
3699:     *                                              'Dopes', TprMvCab.Dopes)
3700:     *   If Inlist( Thisform.Op_escolha, 'INSERIR', 'ALTERAR' )
3701:     *       If Lastkey()=13
3702:     *           llNovaLinha = .t.
3703:     *           Select crTpmMvItn3
3704:     *           Thisform.Foco = 'fwgrade.Produto'
3705:     *           Thisform.mInsereLinha()
3706:     *       Endif
3707:     *   EndIf
3708:     *   Thisform.Calc_ValIte()
3709:     *
3710:     * O Cursorquery do topo eh a releitura da configuracao da operacao, que
3711:     * aqui mora em CarregarConfiguracaoOperacao - o metodo faz exatamente o que
3712:     * o Cursorquery fazia (le SigCdOpe pela Dopes do cabecalho e guarda o
3713:     * resultado nas propriedades do BO).
3714:     *
3715:     * llNovaLinha eh declarada e atribuida no legado e NUNCA lida - por isso
3716:     * nao tem equivalente aqui.
3717:     *
3718:     * Devolve .T. sempre: o legado nao tem Return nenhum neste Valid, e Valid

*-- Linhas 3726 a 3744:
3726:         IF INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3727:             IF LASTKEY() = 13
3728:                 IF USED(THIS.this_cCursorServicos)
3729:                     SELECT (THIS.this_cCursorServicos)
3730:                 ENDIF
3731: 
3732:                 THIS.this_cFoco = "fwgrade.Produto"
3733:                 THIS.InserirLinhaServico()
3734:             ENDIF
3735:         ENDIF
3736: 
3737:         THIS.TotalizarLinha()
3738: 
3739:         RETURN .T.
3740:     ENDPROC
3741: 
3742:     *--------------------------------------------------------------------------
3743:     * CelulaValorLiberada - o When da coluna "Valor".
3744:     *

*-- Linhas 3766 a 3784:
3766:         loc_lTemServico = .F.
3767: 
3768:         IF USED(THIS.this_cCursorServicos)
3769:             SELECT (THIS.this_cCursorServicos)
3770:             loc_lTemServico = !EOF() AND !EMPTY(ALLTRIM(cpros))
3771:         ENDIF
3772: 
3773:         RETURN INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR") ;
3774:                AND loc_lTemServico AND THIS.this_lAutPreco
3775:     ENDPROC
3776: 
3777:     *--------------------------------------------------------------------------
3778:     * ValidarCelulaValor - o Valid da coluna "Valor".
3779:     *
3780:     * Legado (VALOR.Text1.Valid), transcrito linha a linha:
3781:     *   lnCasas = CrSigCdOpe.Casas
3782:     *   Thisform.Foco = ''
3783:     *   This.Value = Round( This.Value, lnCasas )
3784:     *   If This.Value < 0

*-- Linhas 3868 a 3908:
3868:     *
3869:     * Legado (VALOR.Text1.LostFocus):
3870:     *   Thisform.lAutPreco = .F.
3871:     *   Select crTpmMvItn3
3872:     *   If Not IsEmpty(Thisform.Foco)
3873:     *       lcFoco = AllTrim(Thisform.Foco)
3874:     *       Thisform.Foco = ''
3875:     *       Thisform.&lcFoco..Refresh
3876:     *       Thisform.&lcFoco..SetFocus
3877:     *   EndIf
3878:     *
3879:     * Desligar lAutPreco ao SAIR da celula eh o que faz a autorizacao dada pelo
3880:     * botao "Alterar Valores" valer por UMA edicao so.
3881:     *
3882:     * O desvio do foco esta em AplicarFoco: o nome guardado em this_cFoco eh o
3883:     * do objeto LEGADO ("fwgrade.Produto"), que no migrado se chama
3884:     * grd_4c_Dados.Column1 (PILAR 3) - a macro do legado nao tem como ser
3885:     * transcrita literalmente.
3886:     *
3887:     * PUBLIC: eh chamado pela subclasse de TextBox, de FORA desta classe.
3888:     *--------------------------------------------------------------------------
3889:     PROCEDURE CelulaValorLostFocus()
3890:         THIS.this_lAutPreco = .F.
3891: 
3892:         IF USED(THIS.this_cCursorServicos)
3893:             SELECT (THIS.this_cCursorServicos)
3894:         ENDIF
3895: 
3896:         THIS.AplicarFoco()
3897: 
3898:         RETURN
3899:     ENDPROC
3900: 
3901:     *--------------------------------------------------------------------------
3902:     * AplicarFoco - o "Thisform.&lcFoco..Refresh / .SetFocus" do legado.
3903:     *
3904:     * this_cFoco guarda o nome do objeto do LEGADO, exatamente como as duas
3905:     * unicas atribuicoes do dump o escrevem ('fwgrade.Produto', nos Valid de
3906:     * QTD e de VALOR). Aqui o nome eh TRADUZIDO para o objeto migrado em vez de
3907:     * expandido por macro: os nomes do migrado sao diferentes por imposicao do
3908:     * PILAR 3, e "&lcFoco" apontaria para objeto inexistente.

*-- Linhas 3999 a 4094:
3999:     * InserirLinhaServico - o "mInsereLinha" do legado (metodo de form).
4000:     *
4001:     * Legado:
4002:     *   Select crTpmMvItn3
4003:     *   Locate For cpros = Space(14)
4004:     *   If Eof()
4005:     *       Insert Into crTpmMvItn3(Emps, Dopes, Numes, Citens) ;
4006:     *              Values (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes,
4007:     *                      ThisForm.Citem)
4008:     *       Insert Into csTmpDesc (nControle, nLInhas) ;
4009:     *              Values (RecNo([crTpmMvItn3]), ThisForm.nCItem2)
4010:     *       ThisForm.nCItem2 = ThisForm.nCItem2 + 1
4011:     *   EndIf
4012:     *   Select crTpmMvItn3 / Set Order To CItens / Set Key To ThisForm.Citem
4013:     *   Select crTpmMvItn3 / Set Relation To Str(Recno([crTpmMvItn3]),8)
4014:     *                                        Into csTmpDesc
4015:     *   Select crTpmMvItn3
4016:     *   If Not ThisForm.lAutPreco
4017:     *       Keyboard [{DNARROW}]
4018:     *   EndIf
4019:     *   Keyboard [{DNARROW}]
4020:     *   ThisForm.OldCodBarras = []
4021:     *   ThisForm.AntCPro = Space(10)
4022:     *   ThisForm.AntValu = Space(3)
4023:     *
4024:     * "Locate For cpros = Space(14)" procura a linha AINDA EM BRANCO: se ja
4025:     * existe uma, nao se cria outra. Transcrito como EMPTY(cpros), que produz o
4026:     * mesmo conjunto e nao depende do SET EXACT em vigor - o projeto roda com
4027:     * SET EXACT ON, em que a comparacao com Space(14) passa a exigir tamanho
4028:     * igual, e EMPTY eh imune aos dois casos.
4029:     *
4030:     * O INSERT vai pelo BO, como em GarantirLinhaEmBranco: eh o BO que conhece
4031:     * as colunas da linha e o contexto do movimento (Emps/Dopes/Numes vindos de
4032:     * TprMvCab e Citens vindo do item), e as propriedades da linha sao limpas
4033:     * antes para a linha nova nao nascer com os dados do servico anterior.
4034:     *
4035:     * Os DOIS "Keyboard {DNARROW}" sao transcritos como estao: o primeiro, que
4036:     * so acontece quando o preco NAO foi liberado, pula a coluna do valor; o
4037:     * segundo desce para a linha seguinte. Sao o que leva o cursor de digitacao
4038:     * ate a linha nova.
4039:     *
4040:     * PUBLIC: eh chamado pelos Valid das celulas de quantidade e de valor, que
4041:     * moram nas subclasses de TextBox - de FORA desta classe.
4042:     *--------------------------------------------------------------------------
4043:     PROCEDURE InserirLinhaServico()
4044:         LOCAL loc_cServicos, loc_nRegistro
4045: 
4046:         loc_cServicos = THIS.this_cCursorServicos
4047: 
4048:         IF !USED(loc_cServicos)
4049:             RETURN
4050:         ENDIF
4051: 
4052:         SELECT (loc_cServicos)
4053:         LOCATE FOR EMPTY(cpros)
4054: 
4055:         IF EOF()
4056:             THIS.LimparDadosLinhaBO()
4057: 
4058:             IF THIS.this_oBusinessObject.Inserir()
4059:                 loc_nRegistro = RECNO(loc_cServicos)
4060: 
4061:                 IF USED(THIS.this_cCursorDescricoes)
4062:                     INSERT INTO csTmpDesc (nControle, nLinhas) ;
4063:                         VALUES (loc_nRegistro, THIS.this_nCItem2)
4064:                 ENDIF
4065: 
4066:                 THIS.this_nCItem2 = THIS.this_nCItem2 + 1
4067:             ELSE
4068:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
4069:                         "Erro ao incluir linha de servi" + CHR(231) + "o")
4070:             ENDIF
4071:         ENDIF
4072: 
4073:         *-- Set Order To CItens + Set Key To <item> do legado
4074:         THIS.AplicarEscopoItem()
4075: 
4076:         *-- Set Relation To Str(Recno(...),8) Into csTmpDesc do legado
4077:         THIS.AplicarRelacaoDescricoes()
4078: 
4079:         SELECT (loc_cServicos)
4080: 
4081:         IF !THIS.this_lAutPreco
4082:             KEYBOARD "{DNARROW}"
4083:         ENDIF
4084: 
4085:         KEYBOARD "{DNARROW}"
4086: 
4087:         THIS.this_cOldCodBarras = ""
4088:         THIS.this_cAntCPro      = SPACE(10)
4089:         THIS.this_cAntValu      = SPACE(3)
4090: 
4091:         RETURN
4092:     ENDPROC
4093: 
4094:     *--------------------------------------------------------------------------

*-- Linhas 4148 a 4181:
4148:             RETURN
4149:         ENDIF
4150: 
4151:         SELECT (THIS.this_cCursorDescricoes)
4152:         SET ORDER TO TAG iControle
4153: 
4154:         loc_cRelacao = "STR(RECNO('" + THIS.this_cCursorServicos + "'), 8)"
4155: 
4156:         SELECT (THIS.this_cCursorServicos)
4157:         SET RELATION TO &loc_cRelacao. INTO csTmpDesc
4158: 
4159:         RETURN
4160:     ENDPROC
4161: 
4162:     *--------------------------------------------------------------------------
4163:     * LimparCampos - o "apaite" do legado (metodo de form).
4164:     *
4165:     * Legado:
4166:     *   Select crTpmMvItn3
4167:     *   Replace DPros With [], Obs With [], CodBarras With 00, Utilizas With 00,
4168:     *           TamDe With [], TamPara With [], iConfs With .F.,
4169:     *           Notas With [] In crTpmMvItn3
4170:     *   With Thisform.fwGrade
4171:     *       .Produto.Text1.Value = [] / .Qtd.Text1.Value   = 0
4172:     *       .Valor.Text1.Value   = 0  / .Moeda.Text1.Value = ''
4173:     *       .Total.Text1.Value   = 0
4174:     *       (Refresh de cada um e da grade)
4175:     *   EndWith
4176:     *
4177:     * Limpa a linha CORRENTE: as colunas descritivas do cursor e o conteudo
4178:     * exibido nas cinco primeiras celulas. O codigo do servico (cpros) e a
4179:     * quantidade (qtds) NAO sao apagados do CURSOR pelo legado - so da tela -,
4180:     * e isso eh transcrito como esta.
4181:     *

*-- Linhas 4197 a 4215:
4197:         loc_cServicos = THIS.this_cCursorServicos
4198: 
4199:         IF USED(loc_cServicos)
4200:             SELECT (loc_cServicos)
4201: 
4202:             IF !EOF()
4203:                 REPLACE dpros     WITH "", ;
4204:                         obs       WITH "", ;
4205:                         codbarras WITH 0, ;
4206:                         utilizas  WITH 0, ;
4207:                         tamde     WITH "", ;
4208:                         tampara   WITH "", ;
4209:                         notas     WITH ""
4210: 
4211:                 IF VARTYPE(iconfs) = "L"
4212:                     REPLACE iconfs WITH .F.
4213:                 ELSE
4214:                     REPLACE iconfs WITH 0
4215:                 ENDIF

*-- Linhas 4258 a 4323:
4258:     * edita. Por isso a transferencia tem tres partes:
4259:     *
4260:     *   1. a linha corrente do cursor de grade, que eh o que as celulas ja
4261:     *      gravaram (grade ligada por ControlSource escreve DIRETO no cursor),
4262:     *      lida pelo CarregarDoCursor do BO;
4263:     *   2. os dois campos que NAO estao na grade - TamDe e TamPara, do painel
4264:     *      "Tamanho" -, que sobrescrevem o que veio do cursor justamente para
4265:     *      capturar o que o usuario digitou e ainda nao foi gravado;
4266:     *   3. o contexto do dialogo (item dono dos servicos e os dois flags de
4267:     *      garantia recebidos do chamador).
4268:     *
4269:     * Devolve .F. quando nao ha linha corrente de onde ler - o chamador decide
4270:     * o que fazer, como o legado faz ao testar Eof([crTpmMvItn3]).
4271:     *
4272:     * PUBLIC: eh um dos dois hooks canonicos de transferencia e eh chamado de
4273:     * fora da classe (pelo botao Retornar e pelo harness de teste).
4274:     *--------------------------------------------------------------------------
4275:     FUNCTION FormParaBO()
4276:         LOCAL loc_lSucesso, loc_nAreaAnterior
4277: 
4278:         loc_lSucesso = .F.
4279: 
4280:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4281:             RETURN .F.
4282:         ENDIF
4283: 
4284:         loc_nAreaAnterior = SELECT()
4285: 
4286:         *-- 1. Linha corrente da grade
4287:         IF USED(THIS.this_cCursorServicos)
4288:             SELECT (THIS.this_cCursorServicos)
4289: 
4290:             IF !EOF()
4291:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarDoCursor( ;
4292:                                    THIS.this_cCursorServicos)
4293:             ENDIF
4294:         ENDIF
4295: 
4296:         WITH THIS.this_oBusinessObject
4297:             *-- 2. Painel "Tamanho" (fora da grade, logo fora do cursor)
4298:             .this_cTamDe   = ALLTRIM(THIS.cnt_4c_Tamanho.txt_4c_TamDe.Value)
4299:             .this_cTamPara = ALLTRIM(THIS.cnt_4c_Tamanho.txt_4c_TamPara.Value)
4300: 
4301:             *-- 3. Contexto do dialogo
4302:             .this_nCitemProduto      = THIS.this_nCItem
4303:             .this_lGarantia          = THIS.this_lGarantia
4304:             .this_lValorZeroGarantia = THIS.this_lValorZeroGarantia
4305:         ENDWITH
4306: 
4307:         IF loc_nAreaAnterior > 0
4308:             SELECT (loc_nAreaAnterior)
4309:         ENDIF
4310: 
4311:         RETURN loc_lSucesso
4312:     ENDFUNC
4313: 
4314:     *--------------------------------------------------------------------------
4315:     * GravarLinhaCorrente - leva para o cursor de grade o que esta na TELA.
4316:     *
4317:     * Eh o "Replace TamDe/TamPara With This.Value In crTpmMvItn3" que o legado
4318:     * faz no Valid dos dois campos do painel "Tamanho", escrito pela camada: a
4319:     * tela vai para o BO (FormParaBO) e eh o BO que grava (AtualizarTamanhos).
4320:     *
4321:     * AtualizarTamanhos, e nao Atualizar: esta ultima regrava a LINHA INTEIRA,
4322:     * e o legado toca aqui SOMENTE as duas colunas do painel - ampliar a
4323:     * escrita para as outras 16 colunas levaria junto iconfs, cujo tipo varia

*-- Linhas 4332 a 4350:
4332:             RETURN
4333:         ENDIF
4334: 
4335:         SELECT (THIS.this_cCursorServicos)
4336: 
4337:         IF EOF()
4338:             RETURN
4339:         ENDIF
4340: 
4341:         IF THIS.FormParaBO()
4342:             IF !THIS.this_oBusinessObject.AtualizarTamanhos()
4343:                 MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
4344:                         "Erro ao gravar o tamanho do servi" + CHR(231) + "o")
4345:             ENDIF
4346:         ENDIF
4347: 
4348:         RETURN
4349:     ENDPROC
4350: 

*-- Linhas 4361 a 4379:
4361:     *   2. o painel "Tamanho" da linha corrente.
4362:     *
4363:     * As celulas da GRADE ficam de fora de proposito: elas estao ligadas ao
4364:     * cursor por ControlSource e se desenham sozinhas a partir dele - escrever
4365:     * .Value numa celula ligada GRAVARIA de volta no cursor, que eh justamente
4366:     * de onde o valor acabou de vir. O que esta tela precisa aqui eh so
4367:     * REPINTAR a grade.
4368:     *
4369:     * A VISIBILIDADE do painel "Tamanho" NAO eh tocada aqui: quem a decide eh o
4370:     * AfterRowColChange da grade, que eh onde o legado a decide. Mexer nela
4371:     * aqui faria o painel aparecer ja na abertura da tela, que eh exatamente o
4372:     * que o legado nao faz.
4373:     *
4374:     * PUBLIC: eh um dos dois hooks canonicos de transferencia e eh chamado de
4375:     * fora da classe (pelo funil de carga da linha e pelo harness de teste).
4376:     *--------------------------------------------------------------------------
4377:     PROCEDURE BOParaForm()
4378:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4379:             RETURN


### BO (C:\4c\projeto\app\classes\sigopserBO.prg):
*==============================================================================
* sigopserBO.prg - Business Object para Servicos do Item (SIGOPSER)
* Tabela principal: SigMvItn (linhas de servico do item de movimento)
* Tabela relacionada: SigMvItp (TamDe/TamPara - tamanho exigido do servico)
* Dialogo modal aberto pelo form pai (ex.: SigOpPed) para detalhar os
* servicos vinculados a um item de produto (ThisForm.ParentForm.Citem).
*==============================================================================

DEFINE CLASS sigopserBO AS BusinessBase

    *-- Identificacao do movimento/operacao pai (contexto recebido do form
    *-- que abriu o dialogo - TprMvCab/crTpmMvItn do legado) --------------
    this_cEmps            = ""    && char(3)  - Empresa
    this_cDopes           = ""    && char(20) - Operacao do movimento (TprMvCab.Dopes)
    this_nNumes           = 0     && N(6,0)   - Numero sequencial do movimento (TprMvCab.Numes)
    this_nCitemProduto    = 0     && N(10,0)  - Citens do item de produto ao qual os servicos pertencem (ThisForm.Citem)
    this_cCursorAlias     = ""    && Alias do cursor de grade compartilhado com o form pai (crTpmMvItn3 no
                                   && legado), setado pelo Form antes de chamar CarregarDoCursor/Inserir/Atualizar

    *-- Configuracao da operacao (SigCdOpe) - carregada uma vez por sessao
    *-- do dialogo e reutilizada nas validacoes de preco/quantidade -------
    this_nCasas           = 0     && N(1,0)  - Casas decimais do preco unitario (CrSigCdOpe.Casas)
    this_nZerQtds         = 0     && N(1,0)  - Zera a quantidade ao trocar de produto (CrSigCdOpe.ZerQtds)
    this_nPrecoAuts       = 0     && N(1,0)  - Busca preco de lista automaticamente (CrSigCdOpe.PrecoAuts)
    this_nPrecoPs         = 0     && N(2,0)  - Fonte do preco quando nao ha lista vigente (CrSigCdOpe.PrecoPs)
    this_nPrecops         = 0     && N(1,0)  - Define a moeda de faturamento do item (CrSigCdOpe.Precops)
    this_cCMoes           = ""    && char(3) - Moeda padrao da operacao (CrSigCdOpe.CMoes)
    this_nItSituas        = 0     && N(1,0)  - Filtro de situacao do produto/servico (CrSigCdOpe.ItSituas)
    this_nHabServs        = 0     && N(1,0)  - Indica se a operacao habilita servicos (CrSigCdOpe.HabServs)

    *-- Flags de garantia recebidos do form pai no Init do dialogo --------
    this_lGarantia            = .F.   && Indica fluxo de garantia (par_lGarantia)
    this_lValorZeroGarantia   = .F.   && Zera o valor unitario quando em garantia (par_lVlrZeroGarantia)

    *-- Identificacao do PRODUTO dono dos servicos (crTpmMvItn + SigCdPro do
    *-- legado), exibida no cabecalho do dialogo nos campos Get_Produto /
    *-- Get_Descricao / Get_Mercs. Propriedades SEPARADAS das da linha
    *-- (this_cCpros/this_cDpros) de proposito: aquelas descrevem o SERVICO da
    *-- linha corrente da grade e mudam a cada troca de linha, estas descrevem
    *-- o item do documento e valem para o dialogo inteiro - reaproveitar as
    *-- primeiras faria a descricao do produto sobrescrever a do servico.
    this_cCprosItem       = ""    && char(14) - Codigo do produto do item (crTpmMvItn.Cpros)
    this_cDprosItem       = ""    && char(65) - Descricao do produto do item (SigCdPro.dpros)
    this_cMercsItem       = ""    && char(3)  - Mercadoria do produto do item (SigCdPro.mercs)

    *-- Dados do item de servico (linha corrente de SigMvItn + SigMvItp) --
    this_cCidChaves       = ""    && char(20) - Chave unica do item (PK)
    this_nCitens          = 0     && N(10,0)  - Item (mesmo citens do produto pai)
    this_cCpros           = ""    && char(14) - Codigo do servico
    this_cDpros           = ""    && char(65) - Descricao do servico
    this_cCunis           = ""    && char(3)  - Unidade
    this_nQtds            = 0     && N(9,3)   - Quantidade
    this_nUnits           = 0     && N(15,6)  - Valor unitario
    this_nUnivals         = 0     && N(15,6)  - Valor unitario de venda (tabela de preco)
    this_nTotas           = 0     && N(11,2)  - Total do item
    this_cMoedas          = ""    && char(3)  - Moeda do item
    this_cMoefats         = ""    && char(3)  - Moeda de faturamento
    this_cMoevs           = ""    && char(3)  - Moeda de venda
    this_nMoevals         = 0     && N(15,6)  - Valor na moeda de venda
    this_lIconfs          = .F.   && bit      - Exige confirmacao de tamanho
    this_nCodBarras       = 0     && N(14,0)  - Codigo de barras
    this_nUtilizas        = 0     && N(4,0)   - Utilizas
    this_cNotas           = ""    && char(6)  - Notas
    this_cObs             = ""    && memo     - Observacao
    this_cTamDe           = ""    && char(3)  - Tamanho De (SigMvItp)
    this_cTamPara         = ""    && char(3)  - Tamanho Para (SigMvItp)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvItn"
            THIS.this_cCampoChave = "cidchaves"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar sigopserBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega as propriedades do servico a partir do
    * registro corrente do cursor informado (equivalente a leitura de
    * crTpmMvItn3 feita pelos handlers Valid/AfterRowColChange do legado).
    * par_cCursor eh o alias do cursor de grade compartilhado com o form pai.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor) AND USED(par_cCursor)

            SELECT (par_cCursor)

            IF !EOF()
                TRY
                    THIS.this_cCursorAlias = par_cCursor

                    THIS.this_cCidChaves   = TratarNulo(cidchaves, "")
                    THIS.this_cEmps        = TratarNulo(emps, "")
                    THIS.this_cDopes       = TratarNulo(dopes, "")
                    THIS.this_nNumes       = TratarNulo(numes, 0)
                    THIS.this_nCitens      = TratarNulo(citens, 0)
                    THIS.this_cCpros       = TratarNulo(cpros, "")
                    THIS.this_cDpros       = TratarNulo(dpros, "")
                    THIS.this_cCunis       = TratarNulo(cunis, "")
                    THIS.this_nQtds        = TratarNulo(qtds, 0)
                    THIS.this_nUnits       = TratarNulo(units, 0)
                    THIS.this_nUnivals     = TratarNulo(univals, 0)
                    THIS.this_nTotas       = TratarNulo(totas, 0)
                    THIS.this_cMoedas      = TratarNulo(moedas, "")
                    THIS.this_cMoefats     = TratarNulo(moefats, "")
                    THIS.this_cMoevs       = TratarNulo(moevs, "")
                    THIS.this_nMoevals     = TratarNulo(moevals, 0)
                    THIS.this_lIconfs      = ConverterParaLogico(iconfs)
                    THIS.this_nCodBarras   = TratarNulo(codbarras, 0)
                    THIS.this_nUtilizas    = TratarNulo(utilizas, 0)
                    THIS.this_cNotas       = TratarNulo(notas, "")
                    THIS.this_cObs         = TratarNulo(obs, "")
                    THIS.this_cTamDe       = TratarNulo(tamde, "")
                    THIS.this_cTamPara     = TratarNulo(tampara, "")

                    loc_lResultado = .T.

                CATCH TO loc_oErro
                    MsgErro("Erro ao carregar linha de servi" + CHR(231) + "o do cursor: " + loc_oErro.Message, "Erro")
                    loc_lResultado = .F.
                ENDTRY
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - Adiciona uma nova linha de servico ao cursor de grade
    * compartilhado com o formulario pai (equivalente ao mInsereLinha() do
    * legado, que faz "Insert Into crTpmMvItn3(...) Values (...)").
    *
    * Este dialogo NUNCA grava diretamente em SigMvItn/SigMvItp: no legado,
    * o Init monta e o cntOK.btnSair apenas valida/fecha o cursor compartilhado
    * crTpmMvItn3 - a persistencia definitiva (e a auditoria correspondente)
    * acontece quando o formulario pai salva o documento (pedido) por completo.
    * Por isso THIS.RegistrarAuditoria() nao e chamado aqui.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)
            APPEND BLANK

            REPLACE emps      WITH THIS.this_cEmps, ;
                    dopes     WITH THIS.this_cDopes, ;
                    numes     WITH THIS.this_nNumes, ;
                    citens    WITH THIS.this_nCitemProduto, ;
                    cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            THIS.this_nCitens = THIS.this_nCitemProduto
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - Grava as alteracoes do servico corrente no registro
    * posicionado do cursor de grade compartilhado (equivalente aos blocos
    * "Replace ... In crTpmMvItn3" dos handlers Valid/LostFocus do legado:
    * PRODUTO.Valid, QTD.Valid, VALOR.Valid, Descricao.Valid, getTamDe/
    * getTamPara.Valid). Mesma observacao da Inserir() quanto a auditoria.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE cpros     WITH THIS.this_cCpros, ;
                    dpros     WITH THIS.this_cDpros, ;
                    cunis     WITH THIS.this_cCunis, ;
                    qtds      WITH THIS.this_nQtds, ;
                    units     WITH THIS.this_nUnits, ;
                    univals   WITH THIS.this_nUnivals, ;
                    totas     WITH THIS.this_nTotas, ;
                    moedas    WITH THIS.this_cMoedas, ;
                    moefats   WITH THIS.this_cMoefats, ;
                    moevs     WITH THIS.this_cMoevs, ;
                    moevals   WITH THIS.this_nMoevals, ;
                    iconfs    WITH THIS.this_lIconfs, ;
                    codbarras WITH THIS.this_nCodBarras, ;
                    utilizas  WITH THIS.this_nUtilizas, ;
                    notas     WITH THIS.this_cNotas, ;
                    obs       WITH THIS.this_cObs, ;
                    tamde     WITH THIS.this_cTamDe, ;
                    tampara   WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar linha de servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AtualizarTamanhos - Grava NO registro posicionado do cursor de grade
    * apenas as duas colunas do painel "Tamanho" (SigMvItp.TamDe/TamPara).
    *
    * Equivalente exato do "Replace TamDe With This.Value In crTpmMvItn3" que o
    * legado faz no Valid de cada um dos dois campos. Existe ao lado de
    * Atualizar() - e nao no lugar dela - porque Atualizar() regrava a LINHA
    * INTEIRA: usa-la aqui ampliaria a escrita para 18 colunas que o legado nao
    * toca neste caminho, inclusive iconfs, cujo tipo varia conforme o driver
    * que montou o cursor do chamador.
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51).
    *==========================================================================
    PROCEDURE AtualizarTamanhos()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_cCursorAlias) OR !USED(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Cursor de servi" + CHR(231) + "os n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            RETURN .F.
        ENDIF

        IF EOF(THIS.this_cCursorAlias)
            THIS.this_cMensagemErro = "Nenhuma linha de servi" + CHR(231) + "o posicionada para atualiza" + CHR(231) + CHR(227) + "o."
            RETURN .F.
        ENDIF

        TRY
            SELECT (THIS.this_cCursorAlias)

            REPLACE tamde   WITH THIS.this_cTamDe, ;
                    tampara WITH THIS.this_cTamPara

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gravar o tamanho do servi" + CHR(231) + "o: " + loc_oErro.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterMercadoriaProduto - Mercadoria (SigCdPro.mercs) do produto dono dos
    * servicos. Eh o que o legado obtinha junto com a descricao do item:
    *
    *   =ThisForm.Parentform.Podatamgr.Cursorquery('SigCdPro','CrTmpPro', ;
    *                                   'Cpros', crTpmMvItn.Cpros,[dpros, Mercs])
    *
    * Metodo PUBLIC de proposito: eh chamado pelo Form (regra #51). Devolve ""
    * quando nao ha conexao ou o produto nao existe - o chamador decide o
    * default, como o legado faz no Iif de lcMercs.
    *==========================================================================
    PROCEDURE ObterMercadoriaProduto(par_cCpros)
        LOCAL loc_cMercs, loc_cSQL, loc_nResultado, loc_nAreaAnterior, loc_oErro

        loc_cMercs        = ""
        loc_nAreaAnterior = SELECT()

        TRY
            IF VARTYPE(par_cCpros) = "C" AND !EMPTY(ALLTRIM(par_cCpros)) ;
               AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                loc_cSQL = "SELECT dpros, mercs FROM SigCdPro" + ;
                           " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

                IF USED("cursor_4c_ProdutoItem")
                    USE IN cursor_4c_ProdutoItem
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdutoItem")

                IF loc_nResultado < 0
                    MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler o " + ;
                            "produto do item." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_ProdutoItem")
                        SELECT cursor_4c_ProdutoItem
                        GO TOP

                        IF !EOF()
                            loc_cMercs = ALLTRIM(TratarNulo(mercs, ""))

                            *-- Identificacao do PRODUTO do item, nas
                            *-- propriedades proprias dele: this_cDpros
                            *-- descreve o SERVICO da linha corrente e seria
                            *-- sobrescrita aqui, fazendo a grade exibir a
                            *-- descricao do produto no lugar da do servico.
                            *-- this_cCprosItem eh escrita pelo Form, que eh
                            *-- quem le o codigo no cursor do item
                            THIS.this_cDprosItem = ALLTRIM(TratarNulo(dpros, ""))
                            THIS.this_cMercsItem = loc_cMercs
                        ENDIF

                        USE IN cursor_4c_ProdutoItem
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao ler o produto do item")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_cMercs
    ENDPROC

    *==========================================================================
    * CarregarServicosDisponiveis - monta csSigCdPro, o UNIVERSO dos servicos
    * que o usuario pode escolher nas colunas "Servico" e "Descricao" da grade.
    *
    * Legado (Init de SIGOPSER), transcrito:
    *
    *   If (crSigCdOpe.HabServs = 1)
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a, SigCdGrp b ]+;
    *                [Where a.Cgrus = b.Cgrus And b.Servicos = 1 ]+;
    *          Iif(crSigCdOpe.ItSituas=1,[ And (Not a.Situas = 2 Or (a.Situas = 2 And
    *                    (Not a.DtSituas Is Null And a.DtSituas < ?pDat)))], ;
    *          Iif(crSigCdOpe.ItSituas=2,[ And a.Situas = 2 ],[]))
    *   Else
    *      lcQuery = [Select a.Cpros, a.Dpros, a.IdeCPros From SigCdPro a Where 0=1 ]
    *   EndIf
    *   ...
    *   Select * From csSigCdPro Where IdeCpros = lcMercs Into Cursor csSigCdPro ReadWrite
    *
    * O "Where 0=1" do ramo Else NAO eh defeito: operacao que nao habilita
    * servicos tem universo VAZIO de proposito, e o legado monta o cursor assim
    * mesmo para que a estrutura exista e os indices possam ser criados.
    *
    * O filtro por mercadoria eh o re-Select que o legado faz logo depois; aqui
    * ele entra no proprio WHERE porque o resultado eh o mesmo e evita uma
    * segunda passagem sobre o cursor inteiro. Quando o chamador nao consegue
    * resolver a mercadoria (par_cMercs vazio), o filtro NAO eh aplicado - o
    * legado nunca chega a esse caso porque sempre cai no default 'JOI'.
    *
    * O cursor sai READWRITE porque o Form cria indices sobre ele (Cpros/DPros)
    * e o cursor de SQLEXEC nasce somente-leitura; por isso o SQLEXEC vai para
    * um alias TEMPORARIO e o resultado eh convertido.
    *
    * pDat do legado eh Datetime() do cliente, nao GETDATE() do servidor:
    * transcrito como GETDATE().
    *==========================================================================
    PROCEDURE CarregarServicosDisponiveis(par_cCursor, par_cMercs)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor, loc_nResultado
        LOCAL loc_nAreaAnterior, loc_oErro

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cCursor       = IIF(VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor), ;
                                par_cCursor, "csSigCdPro")

        TRY
            IF THIS.this_nHabServs = 1
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a, SigCdGrp b" + ;
                           " WHERE a.Cgrus = b.Cgrus AND b.Servicos = 1"

                DO CASE
                    CASE THIS.this_nItSituas = 1
                        loc_cSQL = loc_cSQL + ;
                            " AND (NOT a.Situas = 2 OR (a.Situas = 2" + ;
                            " AND (NOT a.DtSituas IS NULL" + ;
                            " AND a.DtSituas < " + GETDATE() + ")))"
                    CASE THIS.this_nItSituas = 2
                        loc_cSQL = loc_cSQL + " AND a.Situas = 2"
                ENDCASE
            ELSE
                loc_cSQL = "SELECT a.Cpros, a.Dpros, a.IdeCPros" + ;
                           " FROM SigCdPro a WHERE 0 = 1"
            ENDIF

            IF VARTYPE(par_cMercs) = "C" AND !EMPTY(ALLTRIM(par_cMercs))
                loc_cSQL = loc_cSQL + ;
                           " AND a.IdeCPros = " + EscaparSQL(ALLTRIM(par_cMercs))
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Cpros"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED("cursor_4c_ServicosTmp")
                    USE IN cursor_4c_ServicosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ServicosTmp")

                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                            THIS.this_cMensagemErro, ;
                            "Falha na Conex" + CHR(227) + "o (csSigCdPro)")
                ELSE
                    IF USED(loc_cCursor)
                        IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                            TABLEREVERT(.T., loc_cCursor)
                        ENDIF
                        USE IN (loc_cCursor)
                    ENDIF

                    SELECT Cpros, Dpros, IdeCPros ;
                        FROM cursor_4c_ServicosTmp ;
                        INTO CURSOR (loc_cCursor) READWRITE

                    IF USED("cursor_4c_ServicosTmp")
                        USE IN cursor_4c_ServicosTmp
                    ENDIF

                    loc_lSucesso = USED(loc_cCursor)
                ENDIF
            ELSE
                *-- Sem conexao (harness de teste / validacao de UI): o cursor
                *-- existe VAZIO, com a mesma estrutura, para que a grade e os
                *-- lookups encontrem o alias em vez de estourar
                IF USED(loc_cCursor)
                    IF CURSORGETPROP("Buffering", loc_cCursor) > 1
                        TABLEREVERT(.T., loc_cCursor)
                    ENDIF
                    USE IN (loc_cCursor)
                ENDIF

                CREATE CURSOR (loc_cCursor) ( Cpros    C(14), ;
                                              Dpros    C(65), ;
                                              IdeCPros C(3) )

                loc_lSucesso = USED(loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao montar a lista de servi" + CHR(231) + "os")
        ENDTRY

        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave primaria do item corrente, usada
    * pela RegistrarAuditoria() da BusinessBase
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

ENDDEFINE

