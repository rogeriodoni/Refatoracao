# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CANCEL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS, MERCS, CGRUS, SGRUS, COLECOES, LINHAS, IFORS, EMPS, DTHRS

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
		.Column1.ControlSource = [crProdutos.CPros]
		.Column2.ControlSource = [crProdutos.DPros]
		Select * ;
		  From crProdutos ;
		Select crProdutos
		Select * ;
		  From crProdutos ;
		Select * ;
		  From crProdutos ;
			Select crProdutos
		Select crProdutos
		Select * ;
		  From crProdutos ;
		Select * ;
		  From crProdutos ;
			Select crProdutos
Select crProdutos
Select * ;
  From crProdutos ;
	Select crProdutos
Select crProdutos
	Delete In crProdutos
Delete From crProdutos Where Empty(CPros)
		lcQuery = [Select Distinct a.CPros, p.DPros ] + ;
					[From SigMvItn a ] + ;
				   [Inner Join SigCdPro p On a.CPros = p.CPros ] + ;
				   		 [a.CPros Not In (Select l.CPros From SigPrIvl l Where l.Emps = '] + _Empr + [' And l.DtHrs >= ?pDat) ] + ;
		lcQuery = [Select Distinct a.CPros, p.DPros ] + ;
					[From SigMvEst a ] + ;
				   [Inner Join SigCdPro p On a.CPros = p.CPros ] + ;
				   		 [a.CPros Not In (Select l.CPros From SigPrIvl l Where l.Emps = '] + _Empr + [' And l.DtHrs >= ?pDat) ] + ;
		lcQuery = [Select Distinct p.CPros, p.DPros ] + ;
					[From SigCdPro p ] + ;
				   [Where p.CPros Not In (Select l.CPros From SigPrIvl l Where l.Emps = '] + _Empr + [' And l.DtHrs >= ?pDat) ] + lcWhe + ;
If (ThisForm.ParentForm.poDataMgr.SqlExecute(lcQuery, [LocalCPros]) < 1)
Delete From crProdutos Where Empty(CPros)
Select LocalCPros
		Select crProdutos
			Insert Into crProdutos From Memvar
Select crProdutos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpSpr.prg) - TRECHOS RELEVANTES PARA PASS SQL (2756 linhas total):

*-- Linhas 54 a 91:
54: *                    .Name           - usado em UPPER(.Name) = "SIGCDBAL"
55: *                    .DataSessionId  - legado: Set DataSession To
56: *                    .loFil.<Faixa>I/F - filtros herdados (fase 4+)
57: *                    .poDataMgr      - conexao/SqlExecute do pai (fase 6+)
58: *
59: * FASE 3: estrutura base do form - DEFINE CLASS com as
60: * propriedades visuais transcritas do SCX, a propriedade de estado
61: * this_oFormPai (espelho do poForm/ParentForm do Init legado), Init com o
62: * parametro, ValidarParametros, InicializarForm, CarregarContextoFormPai
63: * (migra o contexto do pai para o BO, equivalente a "Set DataSession To
64: * poForm.DataSessionId" + leitura de pcEscolha/Name/loFil), ConfigurarDecoracao
65: * (Picture), ConfigurarCabecalho (cntSombra), TornarControlesVisiveis e
66: * Destroy (reabilita o form pai - legado: .ParentForm.Enabled = .f. no
67: * Init / = .t. no btnSair.Click; aqui a reabilitacao tambem fica como
68: * rede de seguranca no Destroy).
69: *
70: * FASE 4 (esta fase): grdProdutos -> grd_4c_Dados (ConfigurarGrade +
71: * AplicarFormatoGrade), os CommandGroup cmg_4c_CmdEscolha (Inserir/
72: * Excluir) e cmg_4c_CmdSalva (Encerrar) com as barrinhas img_4c_ImgBarra1/
73: * img_4c_ImgBarra2 (ConfigurarBotoesAcao), a visibilidade condicional de
74: * cmdEscolha (AplicarVisibilidadePorContexto) e o FUNIL de carga da grade
75: * (CarregarDados + GarantirLinhaEmBranco), que transcreve o bloco do Init
76: * legado: Go Top + RecordSource/ControlSource + linha em branco no fim +
77: * Refresh. Os botoes sao criados DEPOIS do cabecalho (regra #11 do
78: * CLAUDE.md: cmdEscolha/cmdSalva/cmdProcessar ficam em Top = -1..84,
79: * dentro da faixa Top 0..80, e tem de ser criados depois dela para
80: * desenhar por cima). Os Click dos botoes sao da fase 7.
81: *
82: * FASE 5 (esta fase): cmg_4c_CmdProcessar (3 botoes de lote - btnEstI/
83: * btnEst/btnGeral), txt_4c_Dias/lbl_4c_LblDias (getDias/lblDias) e
84: * cnt_4c_CnpProcessando ("Selecionando Produtos..." - legado posiciona em
85: * Top = 500 ao final do Init, nao no Top = 300 do dump; NAO eh um toggle
86: * de Visible (fica sempre Visible = .T.) e por isso nao entra no filtro de
87: * TornarControlesVisiveis - so sobe para Top = 120 durante o processamento,
88: * fase 8). Tambem a visibilidade condicional do Init legado que faltava
89: * (cmdProcessar/lblDias/getDias.Visible = InList(pcEscolha,INSERIR,ALTERAR)
90: * And Upper(ParentForm.Name) = "SIGCDBAL"), calculada a partir do contexto
91: * ja carregado em CarregarContextoFormPai (fase 3).

*-- Linhas 100 a 130:
100: * Os Buttons(N) mantem o nome default do VFP, entao o Click deles so
101: * dispara por BINDEVENT (ConfigurarEventosBotoes). Entregues:
102: * BtnInserirClick (reusa PosicionarProximaLinha, da fase 6 - o bloco
103: * "Select LocalBrancos -> Locate / Append Blank" do legado),
104: * BtnExcluirClick (Delete + Skip/Skip -1 na linha corrente),
105: * RemoverLinhasEmBranco (o "Delete From crProdutos Where Empty(CPros)",
106: * que o Click de cmdProcessar tambem usa) e BtnEncerrarClick (limpa as
107: * linhas em branco, reabilita o form pai e fecha o dialogo), mais a cauda
108: * comum FocarGradeProdutos (Column1.SetFocus + Refresh).
109: *
110: * FASE 8 (esta fase): Click de cmg_4c_CmdProcessar (os 3 botoes de lote -
111: * BtnProcessarLoteClick), unico "PROCEDURE Click" do CommandGroup no
112: * legado, despachado por This.Value (1/2/3), diferente do par
113: * btnInserir/btnExcluir de cmg_4c_CmdEscolha (fase 7), que tem um Click por
114: * botao. Usa THIS.this_oBusinessObject.ObterProdutosEmLote (ja
115: * implementado no BO) e faz o SCAN + Insert no cursor_4c_Produtos do pai
116: * aqui no Form, que eh manipulacao de cursor VFP (ver cabecalho de
117: * SigOpSprBO.prg). Esta eh a FASE FINAL do form - nao ha metodos
118: * "BtnSalvarClick/BtnCancelarClick/FormParaBO/BOParaForm/HabilitarCampos/
119: * CarregarLista" porque este dialogo nao eh CRUD (nao tem entidade propria
120: * para persistir nem modos Incluir/Alterar/Visualizar): toda a gravacao
121: * final eh do form PAI, no cursor local que ele mesmo abriu antes do
122: * "Do Form SigOpSpr With ThisForm". Os equivalentes deste dialogo sao:
123: * BtnEncerrarClick (saida/"confirmar", fase 7), BtnInserirClick/
124: * BtnExcluirClick (edicao de linha, fase 7) e CarregarDados (funil de
125: * carga da grade, fase 4).
126: *==============================================================================
127: 
128: DEFINE CLASS FormSigOpSpr AS FormBase
129: 
130:     *==========================================================================

*-- Linhas 551 a 591:
551:     * ConfigurarGrade - grdProdutos do legado -> grd_4c_Dados
552:     *
553:     * Transcricao do dump (SIGOPSPR.grdProdutos):
554:     *   ColumnCount=2  FontName="Tahoma"  DeleteMark=.F.  RecordMark=.F.
555:     *   HeaderHeight=17  RowHeight=17  ScrollBars=2  TabIndex=1
556:     *   Top=192  Left=190  Width=420  Height=309
557:     *   GridLineColor=238,238,238
558:     *
559:     * O grid NAO eh somente-leitura: o dump nao declara ReadOnly no Grid e
560:     * declara Column2.Text1.ReadOnly = .F. - esta eh a grade em que o
561:     * usuario DIGITA o produto (o lookup das duas colunas entra na fase 6).
562:     *
563:     * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
564:     * geometria, ColumnCount, fontes e cores. Largura de coluna e caption de
565:     * cabecalho moram em AplicarFormatoGrade, que eh a FONTE UNICA desses
566:     * numeros e eh reusada pelo CarregarDados depois do RecordSource
567:     * (atribuir RecordSource zera Column.Width e Header1.Caption - Problema
568:     * 48 / regra #41).
569:     *==========================================================================
570:     PROTECTED PROCEDURE ConfigurarGrade
571:         THIS.AddObject("grd_4c_Dados", "Grid")
572:         WITH THIS.grd_4c_Dados
573:             .ColumnCount   = 2
574:             .FontName      = "Tahoma"
575:             .FontSize      = 8
576:             .DeleteMark    = .F.
577:             .RecordMark    = .F.
578:             .HeaderHeight  = 17
579:             .RowHeight     = 17
580:             .ScrollBars    = 2
581:             .GridLineColor = RGB(238, 238, 238)
582:             .Top           = 192
583:             .Left          = 190
584:             .Width         = 420
585:             .Height        = 309
586:             .TabIndex      = 1
587:             .ReadOnly      = .F.
588:             .Visible       = .T.
589:         ENDWITH
590: 
591:         *-- Column.ReadOnly vai DEPOIS do Grid.ReadOnly (o do grid propaga

*-- Linhas 1135 a 1153:
1135:     *            Caption="Dias :" Top=511 Left=197 Width=32 Height=15
1136:     *            TabIndex=2 ForeColor=90,90,90
1137:     *
1138:     * getDias NAO tem ControlSource no dump: eh um valor de trabalho lido
1139:     * direto pelo Click de cmdProcessar (ThisForm.getDias.Value), nao uma
1140:     * coluna de tabela - por isso nao ha bind a SigOpSprBO.this_nDias aqui;
1141:     * a fase 8 (Click dos botoes de lote) le THIS.txt_4c_Dias.Value e grava
1142:     * em THIS.this_oBusinessObject.this_nDias antes de chamar
1143:     * ObterProdutosEmLote().
1144:     *
1145:     * AutoSize = .F. explicito no label (regra #23 - AutoSize eh NO-OP em
1146:     * Label criado por AddObject): Width/Height vem do dump, ja calculados
1147:     * pelo Form Designer para a legenda "Dias :".
1148:     *
1149:     * A visibilidade real (Visible = InList(pcEscolha,INSERIR,ALTERAR) And
1150:     * Upper(ParentForm.Name) = "SIGCDBAL") eh aplicada depois de
1151:     * TornarControlesVisiveis, em AplicarVisibilidadePorContexto.
1152:     *==========================================================================
1153:     PROTECTED PROCEDURE ConfigurarDias

*-- Linhas 1407 a 1435:
1407:     *     Go Top In crProdutos
1408:     *     With .grdProdutos
1409:     *         .RecordSource          = [crProdutos]
1410:     *         .Column1.ControlSource = [crProdutos.CPros]
1411:     *         .Column2.ControlSource = [crProdutos.DPros]
1412:     *         .Refresh
1413:     *         <garante uma linha em branco - ver GarantirLinhaEmBranco>
1414:     *         .Column1.SetFocus
1415:     *         .Refresh
1416:     *     EndWith
1417:     *
1418:     * crProdutos NAO pertence a este dialogo: eh um cursor LOCAL do form
1419:     * chamador (cursor_4c_Produtos), aberto por ele antes do Do Form. Por
1420:     * isso aqui nao ha SQLEXEC - nao ha consulta propria a fazer, so o
1421:     * binding. Pela mesma razao o Destroy NAO fecha esse alias: ele eh do
1422:     * pai, que depende dele depois deste dialogo fechar.
1423:     *
1424:     * Sem o cursor aberto o binding NAO eh aplicado - atribuir RecordSource
1425:     * de alias inexistente derruba o Init (regra #41). Devolve .F. nesse
1426:     * caso, sem estourar: eh o caminho normal do harness, que instancia o
1427:     * form sem chamador.
1428:     *
1429:     * O SetFocus do legado NAO eh reproduzido aqui: o Init do VFP9 roda com
1430:     * o form ainda nao exibido e SetFocus em controle invisivel estoura
1431:     * "Cannot access a visible or enabled control" - o foco inicial fica com
1432:     * o TabIndex = 1 da grade, que eh o mesmo controle.
1433:     *
1434:     * Fecha com GO TOP + Refresh (regra #21a): ligar/popular cursor NAO
1435:     * repinta a grade sozinho.

*-- Linhas 1456 a 1490:
1456: 
1457:         TRY
1458:             *-- Legado: Go Top In crProdutos (antes do binding)
1459:             SELECT (loc_cCursor)
1460:             GO TOP
1461: 
1462:             WITH THIS.grd_4c_Dados
1463:                 *-- ColumnCount antes do RecordSource. Reatribuir o MESMO
1464:                 *-- valor nao recria as Column (nao ha controle posto por
1465:                 *-- Column.AddObject nesta grade a perder)
1466:                 .ColumnCount = 2
1467: 
1468:                 .RecordSource = loc_cCursor
1469: 
1470:                 *-- Column1 = CPros (codigo), Column2 = DPros (descricao)
1471:                 .Column1.ControlSource = loc_cCursor + ".CPros"
1472:                 .Column2.ControlSource = loc_cCursor + ".DPros"
1473:             ENDWITH
1474: 
1475:             *-- Rede de seguranca do Problema 48: RecordSource/ControlSource
1476:             *-- zeram Column.Width e Header1.Caption. Mesma fonte usada na
1477:             *-- montagem, entao nao ha numero duplicado aqui
1478:             THIS.AplicarFormatoGrade()
1479: 
1480:             *-- Legado: a linha em branco no fim da lista eh o que permite
1481:             *-- comecar a digitar assim que a tela abre
1482:             THIS.GarantirLinhaEmBranco()
1483: 
1484:             *-- Legado: .Refresh (o Init chama duas vezes, antes e depois do
1485:             *-- bloco da linha em branco - o efeito util eh o ultimo)
1486:             THIS.grd_4c_Dados.Refresh()
1487: 
1488:             loc_lCarregou = .T.
1489: 
1490:         CATCH TO loc_oErro

*-- Linhas 1502 a 1520:
1502:     *==========================================================================
1503:     * GarantirLinhaEmBranco - transcricao do bloco do Init legado:
1504:     *
1505:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
1506:     *     Go Top In LocalBrancos
1507:     *     If Eof([LocalBrancos])
1508:     *         Append Blank In crProdutos
1509:     *         Go Bottom In crProdutos
1510:     *     EndIf
1511:     *
1512:     * Ou seja: se NAO existe nenhuma linha com codigo vazio, acrescenta uma,
1513:     * para o usuario ter sempre onde digitar o proximo produto. Se ja existe,
1514:     * nao mexe.
1515:     *
1516:     * O APPEND BLANK age no cursor LOCAL do form pai, nao no SQL Server:
1517:     * esta tela nao persiste nada - quem grava eh o pai, depois que o
1518:     * dialogo fecha.
1519:     *
1520:     * O mesmo bloco reaparece no btnInserir.Click do legado, com um ELSE a

*-- Linhas 1543 a 1580:
1543:                 USE IN (loc_cBrancos)
1544:             ENDIF
1545: 
1546:             SELECT * ;
1547:               FROM (loc_cCursor) ;
1548:              WHERE EMPTY(CPros) ;
1549:               INTO CURSOR (loc_cBrancos)
1550: 
1551:             GO TOP IN (loc_cBrancos)
1552: 
1553:             IF EOF(loc_cBrancos)
1554:                 SELECT (loc_cCursor)
1555:                 APPEND BLANK
1556:                 GO BOTTOM
1557:                 loc_lIncluiu = .T.
1558:             ENDIF
1559: 
1560:             IF USED(loc_cBrancos)
1561:                 USE IN (loc_cBrancos)
1562:             ENDIF
1563: 
1564:             *-- Deixa o cursor do pai como area corrente, igual ao legado
1565:             SELECT (loc_cCursor)
1566: 
1567:         CATCH TO loc_oErro
1568:             THIS.this_cMensagemErro = loc_oErro.Message
1569:             MsgErro("Erro ao preparar a linha em branco da grade: " + ;
1570:                     loc_oErro.Message + ;
1571:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1572:                     " | Proc: " + loc_oErro.Procedure, ;
1573:                     "Selecionar Produtos")
1574:             loc_lIncluiu = .F.
1575:         ENDTRY
1576: 
1577:         RETURN loc_lIncluiu
1578:     ENDPROC
1579: 
1580:     *==========================================================================

*-- Linhas 1794 a 1836:
1794:             ENDIF
1795: 
1796:             IF loc_oBusca.this_lSelecionou AND USED(loc_cCursorBusca)
1797:                 *-- Alias em variavel: SELECT (alias) e depois campo NU -
1798:                 *-- campo eh sintaxe INVALIDA em VFP9
1799:                 SELECT (loc_cCursorBusca)
1800:                 loc_cCodigo    = ALLTRIM(NVL(CPros, ""))
1801:                 loc_cDescricao = ALLTRIM(NVL(DPros, ""))
1802: 
1803:                 *-- Codigo vazio nao conta como resolvido: CPros eh a chave de
1804:                 *-- SigCdPro (NOT NULL) e so viria em branco se o cursor
1805:                 *-- estivesse fora de linha. Sem este teste, o REPLACE adiante
1806:                 *-- LIMPARIA a linha que o usuario acabou de preencher - em
1807:                 *-- silencio, porque nenhuma validacao recusa branco aqui
1808:                 loc_lResolveu = !EMPTY(loc_cCodigo)
1809:             ENDIF
1810: 
1811:             loc_oBusca.Release()
1812:         ENDIF
1813: 
1814:         IF USED(loc_cCursorBusca)
1815:             USE IN (loc_cCursorBusca)
1816:         ENDIF
1817: 
1818:         *-- Legado: Use In crListaRemota e o cursor da grade volta a ser a
1819:         *-- area corrente
1820:         IF USED(loc_cCursor)
1821:             SELECT (loc_cCursor)
1822:         ENDIF
1823: 
1824:         *-- Cancelou/nao achou: o digitado FICA (regra #50) e o foco eh
1825:         *-- liberado - esta tela nao trata universo vazio como erro
1826:         IF !loc_lResolveu
1827:             RETURN .T.
1828:         ENDIF
1829: 
1830:         *-- Sem o cursor do pai (harness) so o proprio campo recebe o valor
1831:         IF !USED(loc_cCursor)
1832:             par_oTxt.Value = IIF(par_cCelula == "DESCRICAO", loc_cDescricao, loc_cCodigo)
1833:             RETURN .T.
1834:         ENDIF
1835: 
1836:         *-- Legado: MessageBox([Produto Ja Selecionado!!!], 0+16,

*-- Linhas 1853 a 1871:
1853:         *-- cursor (unico caminho confiavel para a coluna que nao esta em
1854:         *-- edicao) e so depois aos controles
1855:         IF !EOF(loc_cCursor)
1856:             SELECT (loc_cCursor)
1857:             REPLACE CPros WITH LEFT(loc_cCodigo, 14), ;
1858:                     DPros WITH LEFT(loc_cDescricao, 65)
1859:         ENDIF
1860: 
1861:         par_oTxt.Value = IIF(par_cCelula == "DESCRICAO", loc_cDescricao, loc_cCodigo)
1862:         THIS.EspelharCelulasProduto(loc_cCodigo, loc_cDescricao)
1863: 
1864:         *-- Legado: posiciona na proxima linha em branco (criando uma se
1865:         *-- preciso), repinta a grade e, no ENTER, desce uma linha
1866:         THIS.PosicionarProximaLinha()
1867: 
1868:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1869:             THIS.grd_4c_Dados.Refresh()
1870:             THIS.grd_4c_Dados.Column1.Refresh()
1871:         ENDIF

*-- Linhas 1881 a 1930:
1881:     * ProdutoJaSelecionado - checagem de duplicidade do legado:
1882:     *
1883:     *     lnRec = Recno([crProdutos])
1884:     *     Select * From crProdutos
1885:     *      Where CPros = This.Value And Recno() <> lnRec
1886:     *       Into Cursor LocalBrancos
1887:     *     If Not Eof([LocalBrancos]) -> "Produto Ja Selecionado!!!"
1888:     *
1889:     * Ou seja: o mesmo codigo em QUALQUER outra linha do cursor do pai (a
1890:     * propria linha corrente eh excluida, senao reeditar uma linha acusaria
1891:     * duplicidade de si mesma).
1892:     *
1893:     * Feito com SCAN em vez de SELECT ... INTO CURSOR de proposito: o
1894:     * criterio compara uma variavel LOCAL com a coluna, e em SELECT VFP
1895:     * local isso exige prefixo m. em toda referencia (nome solto eh lido
1896:     * como COLUNA). O SCAN sobre o alias eh equivalente - inclusive quanto a
1897:     * registros excluidos, porque SET DELETED esta ON (config.prg) e tanto o
1898:     * SCAN quanto o SELECT os ignoram - e nao tem essa armadilha.
1899:     *
1900:     * REPOE o ponteiro do cursor ao sair: quem chama esta no meio do Valid e
1901:     * conta com a linha corrente preservada.
1902:     *
1903:     * Metodo PUBLIC: o form pai pode reusar a checagem antes de persistir.
1904:     *==========================================================================
1905:     PROCEDURE ProdutoJaSelecionado(par_cCodigo)
1906:         LOCAL loc_lDuplicado, loc_cCursor, loc_cCodigo, loc_nRec, loc_nTotal
1907:         loc_lDuplicado = .F.
1908:         loc_cCursor    = THIS.ObterCursorProdutos()
1909:         loc_cCodigo    = ALLTRIM(TRANSFORM(NVL(par_cCodigo, "")))
1910: 
1911:         IF EMPTY(loc_cCodigo) OR !USED(loc_cCursor)
1912:             RETURN .F.
1913:         ENDIF
1914: 
1915:         SELECT (loc_cCursor)
1916:         loc_nRec   = RECNO()
1917:         loc_nTotal = RECCOUNT()
1918: 
1919:         SCAN
1920:             IF RECNO() != loc_nRec AND ALLTRIM(NVL(CPros, "")) == loc_cCodigo
1921:                 loc_lDuplicado = .T.
1922:                 EXIT
1923:             ENDIF
1924:         ENDSCAN
1925: 
1926:         *-- Repoe o ponteiro. Em EOF o RECNO() vale RECCOUNT()+1, que GO nao
1927:         *-- aceita: nesse caso volta ao fim e sai do ultimo registro, que eh
1928:         *-- o mesmo estado de antes
1929:         DO CASE
1930:         CASE loc_nRec >= 1 AND loc_nRec <= loc_nTotal

*-- Linhas 2001 a 2019:
2001: 
2002:         IF USED(loc_cCursor)
2003:             IF !EOF(loc_cCursor)
2004:                 SELECT (loc_cCursor)
2005: 
2006:                 IF par_cCelula == "DESCRICAO"
2007:                     REPLACE CPros WITH ""
2008:                 ELSE
2009:                     REPLACE DPros WITH ""
2010:                 ENDIF
2011:             ENDIF
2012:         ENDIF
2013: 
2014:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
2015:             RETURN .F.
2016:         ENDIF
2017: 
2018:         IF par_cCelula == "DESCRICAO"
2019:             IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "txt_4c_Codigo", 5)

*-- Linhas 2034 a 2055:
2034:     * PosicionarProximaLinha - bloco que fecha os dois Valid do legado (e
2035:     * tambem o btnInserir.Click, da fase 7):
2036:     *
2037:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
2038:     *     Go Top In LocalBrancos
2039:     *     If Not Eof([LocalBrancos])
2040:     *         Select crProdutos
2041:     *         Locate For Empty(CPros)      && ja existe linha livre: vai nela
2042:     *     Else
2043:     *         Append Blank In crProdutos   && nao existe: cria uma
2044:     *         Go Bottom In crProdutos
2045:     *     EndIf
2046:     *
2047:     * Depois de confirmar um produto o usuario tem de cair numa linha vazia
2048:     * para digitar o proximo, sem reclicar em Inserir.
2049:     *
2050:     * Reusa GarantirLinhaEmBranco, que JA eh o ramo Else (acrescenta a linha
2051:     * e vai para o fim quando NAO ha nenhuma vazia) e devolve .T. nesse
2052:     * caso; so o ramo positivo (Locate) fica aqui. Assim o APPEND BLANK
2053:     * existe num lugar unico.
2054:     *
2055:     * Metodo PUBLIC: o Click do botao Inserir (fase 7) entra por aqui.

*-- Linhas 2067 a 2085:
2067:         *-- ja deixou o ponteiro nela (Go Bottom). .F. = ja existia: basta
2068:         *-- ir ate ela, como o Locate do legado
2069:         IF !THIS.GarantirLinhaEmBranco()
2070:             SELECT (loc_cCursor)
2071:             LOCATE FOR EMPTY(NVL(CPros, ""))
2072:         ENDIF
2073: 
2074:         RETURN .T.
2075:     ENDPROC
2076: 
2077:     *==========================================================================
2078:     * ConfigurarEventosBotoes - liga o Click de cada botao dos CommandGroup ao
2079:     * handler correspondente deste form.
2080:     *
2081:     * Os Buttons(N) sao criados por AddObject e ficam com o nome default do
2082:     * VFP (Command1/Command2/...): nao existe metodo de classe onde escrever o
2083:     * codigo, como havia no SCX (btnInserir.Click, btnExcluir.Click,
2084:     * btnSair.Click), por isso o Click desses botoes SO dispara via BINDEVENT.
2085:     *

*-- Linhas 2159 a 2182:
2159:     * BtnInserirClick - btnInserir.Click do legado (Buttons(1) de cmdEscolha,
2160:     * Caption "\<Inserir"):
2161:     *
2162:     *     Select crProdutos
2163:     *     Go Top In crProdutos
2164:     *     Select * From crProdutos Where Empty(CPros) Into Cursor LocalBrancos
2165:     *     Go Top In LocalBrancos
2166:     *     If Not Eof([LocalBrancos])
2167:     *         Select crProdutos
2168:     *         Locate For Empty(CPros)
2169:     *     Else
2170:     *         Append Blank In crProdutos
2171:     *         Go Bottom In crProdutos
2172:     *     EndIf
2173:     *     ThisForm.grdProdutos.Column1.SetFocus
2174:     *     ThisForm.grdProdutos.Refresh
2175:     *
2176:     * O bloco do meio eh EXATAMENTE PosicionarProximaLinha (entregue na fase
2177:     * 6, que o reusa no fim do Valid das celulas): se ja existe linha com
2178:     * codigo vazio, vai nela; se nao existe, acrescenta uma e vai para o fim.
2179:     * Chamar o metodo em vez de repetir o bloco mantem o APPEND BLANK num
2180:     * lugar unico - os dois caminhos nunca divergem.
2181:     *
2182:     * O APPEND BLANK age no cursor LOCAL do form pai (cursor_4c_Produtos), nao

*-- Linhas 2213 a 2235:
2213:         ENDIF
2214: 
2215:         TRY
2216:             *-- Legado: Select crProdutos / Go Top In crProdutos
2217:             SELECT (loc_cCursor)
2218:             GO TOP
2219: 
2220:             *-- Legado: bloco Select LocalBrancos -> Locate / Append Blank
2221:             THIS.PosicionarProximaLinha()
2222: 
2223:             *-- Legado: Column1.SetFocus + grdProdutos.Refresh
2224:             THIS.FocarGradeProdutos()
2225: 
2226:             loc_lSucesso = .T.
2227: 
2228:         CATCH TO loc_oErro
2229:             THIS.this_cMensagemErro = loc_oErro.Message
2230:             MsgErro("Erro ao inserir a linha de produto: " + loc_oErro.Message + ;
2231:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2232:                     " | Proc: " + loc_oErro.Procedure, ;
2233:                     "Selecionar Produtos")
2234:             loc_lSucesso = .F.
2235:         ENDTRY

*-- Linhas 2241 a 2274:
2241:     * BtnExcluirClick - btnExcluir.Click do legado (Buttons(2) de cmdEscolha,
2242:     * Caption "\<Excluir"):
2243:     *
2244:     *     Select crProdutos
2245:     *     If Not Eof([crProdutos])
2246:     *         Delete In crProdutos
2247:     *         Skip
2248:     *         Skip - 1
2249:     *     EndIf
2250:     *     ThisForm.grdProdutos.Column1.SetFocus
2251:     *     ThisForm.grdProdutos.Refresh
2252:     *
2253:     * Apaga a linha CORRENTE da grade - um item da lista de produtos do pai,
2254:     * nao um registro de tabela: nao ha DELETE em SQL Server neste caminho (e
2255:     * por isso tambem nao ha MsgConfirma, que o legado nao tem - a lista eh de
2256:     * trabalho e a linha se reinsere em um clique).
2257:     *
2258:     * O par SKIP / SKIP -1 eh o idioma do legado para sair de cima do registro
2259:     * recem-apagado: com SET DELETED ON (config.prg) o SKIP pula o que foi
2260:     * marcado e o SKIP -1 volta uma linha VISIVEL, deixando o ponteiro numa
2261:     * linha valida. Transcrito literal - no ultimo registro o SKIP chega a
2262:     * EOF() e o SKIP -1 devolve a ultima linha visivel, que eh o resultado
2263:     * pretendido.
2264:     *
2265:     * Mesma guarda de modo de BtnInserirClick, pela mesma razao (o legado
2266:     * conta com cmdEscolha oculto em PROCURAR, e o atalho Alt+E segue
2267:     * alcancavel).
2268:     *
2269:     * Metodo PUBLIC (regra #3): alvo de BINDEVENT, e o harness o chama de fora.
2270:     *==========================================================================
2271:     PROCEDURE BtnExcluirClick
2272:         LOCAL loc_lSucesso, loc_cCursor, loc_oErro
2273: 
2274:         loc_lSucesso = .F.

*-- Linhas 2284 a 2307:
2284:         ENDIF
2285: 
2286:         TRY
2287:             *-- Legado: Select crProdutos / If Not Eof([crProdutos])
2288:             SELECT (loc_cCursor)
2289: 
2290:             IF !EOF()
2291:                 *-- Legado: Delete In crProdutos / Skip / Skip - 1
2292:                 DELETE
2293:                 SKIP
2294:                 SKIP -1
2295:             ENDIF
2296: 
2297:             *-- Legado: Column1.SetFocus + grdProdutos.Refresh
2298:             THIS.FocarGradeProdutos()
2299: 
2300:             loc_lSucesso = .T.
2301: 
2302:         CATCH TO loc_oErro
2303:             THIS.this_cMensagemErro = loc_oErro.Message
2304:             MsgErro("Erro ao excluir a linha de produto: " + loc_oErro.Message + ;
2305:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2306:                     " | Proc: " + loc_oErro.Procedure, ;
2307:                     "Selecionar Produtos")

*-- Linhas 2314 a 2386:
2314:     *==========================================================================
2315:     * RemoverLinhasEmBranco - primeira linha de btnSair.Click do legado:
2316:     *
2317:     *     Delete From crProdutos Where Empty(CPros)
2318:     *
2319:     * Descarta as linhas que nasceram em branco (a que o Init cria para o
2320:     * usuario digitar, e as que ele inseriu e abandonou) ANTES de devolver o
2321:     * cursor ao form pai - sem isso o pai gravaria itens de produto vazios (o
2322:     * SIGCDBAL percorre crProdutos com Scan e faz um Insert por linha).
2323:     *
2324:     * Escrito com SELECT (alias) + DELETE FOR, nao com DELETE FROM <alias>
2325:     * WHERE: o alias mora numa variavel (ObterCursorProdutos) e comando SQL do
2326:     * VFP9 nao aceita name expression no lugar do nome da tabela. A forma
2327:     * xBase age sobre a area corrente e eh equivalente - mesmo padrao de
2328:     * FormSigOpSno.BtnSairClick.
2329:     *
2330:     * NVL em volta de CPros porque o cursor do pai vem de consulta remota e a
2331:     * coluna pode chegar NULL (EMPTY(.NULL.) eh .F. no VFP, logo sem o NVL a
2332:     * linha nula NAO seria apagada).
2333:     *
2334:     * O ponteiro fica onde o DELETE FOR o deixar, como no legado: o pai
2335:     * percorre o cursor com Scan, cujo escopo ALL reposiciona sozinho.
2336:     *
2337:     * Metodo PUBLIC: o Click de cmdProcessar (fase 8) repete esta MESMA linha
2338:     * no legado e entra por aqui, e o form pai pode reusar a limpeza.
2339:     *==========================================================================
2340:     PROCEDURE RemoverLinhasEmBranco
2341:         LOCAL loc_lRemoveu, loc_cCursor, loc_oErro
2342: 
2343:         loc_lRemoveu = .F.
2344:         loc_cCursor  = THIS.ObterCursorProdutos()
2345: 
2346:         IF EMPTY(loc_cCursor) OR !USED(loc_cCursor)
2347:             RETURN .F.
2348:         ENDIF
2349: 
2350:         TRY
2351:             SELECT (loc_cCursor)
2352:             DELETE FOR EMPTY(NVL(CPros, ""))
2353:             loc_lRemoveu = .T.
2354: 
2355:         CATCH TO loc_oErro
2356:             THIS.this_cMensagemErro = loc_oErro.Message
2357:             MsgErro("Erro ao descartar as linhas em branco: " + loc_oErro.Message + ;
2358:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2359:                     " | Proc: " + loc_oErro.Procedure, ;
2360:                     "Selecionar Produtos")
2361:             loc_lRemoveu = .F.
2362:         ENDTRY
2363: 
2364:         RETURN loc_lRemoveu
2365:     ENDPROC
2366: 
2367:     *==========================================================================
2368:     * BtnEncerrarClick - btnSair.Click do legado (Buttons(1) de cmdSalva,
2369:     * Caption "Encerrar", Cancel = .T.):
2370:     *
2371:     *     Delete From crProdutos Where Empty(CPros)
2372:     *     ThisForm.ParentForm.Enabled = .t.
2373:     *     ThisForm.Release
2374:     *
2375:     * Sem TitleBar e sem ControlBox (propriedades do form, transcritas do
2376:     * SCX), este botao - e o ESC, por Cancel = .T. - eh a UNICA saida da tela.
2377:     *
2378:     * NAO ha par Confirmar/Cancelar aqui, e isso eh do legado: a lista JA foi
2379:     * editada no cursor do pai a cada linha, entao encerrar eh aceitar. Pela
2380:     * mesma razao nao ha propriedade de retorno - o resultado inteiro esta no
2381:     * cursor_4c_Produtos, que eh do pai.
2382:     *
2383:     * O THIS.Release() fica FORA do TRY de proposito: se a limpeza das linhas
2384:     * em branco falhar, o dialogo ainda tem de fechar - do contrario o usuario
2385:     * ficaria preso numa tela sem outra saida, com o form pai desabilitado.
2386:     *

*-- Linhas 2400 a 2418:
2400:         LOCAL loc_oErro
2401: 
2402:         TRY
2403:             *-- Legado: Delete From crProdutos Where Empty(CPros)
2404:             THIS.RemoverLinhasEmBranco()
2405: 
2406:             *-- Legado: ThisForm.ParentForm.Enabled = .t.
2407:             IF VARTYPE(THIS.this_oFormPai) = "O"
2408:                 IF PEMSTATUS(THIS.this_oFormPai, "Enabled", 5)
2409:                     THIS.this_oFormPai.Enabled = .T.
2410:                 ENDIF
2411:             ENDIF
2412: 
2413:         CATCH TO loc_oErro
2414:             THIS.this_cMensagemErro = loc_oErro.Message
2415:             MsgErro("Erro ao encerrar a sele" + CHR(231) + CHR(227) + "o de produtos: " + ;
2416:                     loc_oErro.Message + ;
2417:                     " | Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
2418:                     " | Proc: " + loc_oErro.Procedure, ;

*-- Linhas 2440 a 2501:
2440:     *     pDat = fDtoSQL(Date() - ThisForm.getDias.Value)
2441:     *     ThisForm.cnpProcessando.Top = 120
2442:     *     <monta lcWhe a partir de ParentForm.loFil.*>
2443:     *     Do Case (This.Value = 1/2/3) -> lcQuery -> SqlExecute(lcQuery,'LocalCPros')
2444:     *     If (...SqlExecute(...) < 1)
2445:     *         =MessageBox([Favor Reinicializar o Processo!!!], 16, ...)
2446:     *         Return .f.
2447:     *     EndIf
2448:     *     Delete From crProdutos Where Empty(CPros)
2449:     *     lnCnt = 0
2450:     *     Select LocalCPros
2451:     *     Scan
2452:     *         If Not Empty(LocalCPros.CPros)
2453:     *             Scatter Memvar Memo
2454:     *             Select crProdutos
2455:     *             Go Top In crProdutos
2456:     *             Locate For CPros = LocalCPros.CPros
2457:     *             If Eof([crProdutos])
2458:     *                 lnCnt = lnCnt + 1
2459:     *                 Insert Into crProdutos From Memvar
2460:     *             EndIf
2461:     *         EndIf
2462:     *     EndScan
2463:     *     ThisForm.cnpProcessando.Top = 500
2464:     *     =MessageBox([Foram Selecionados ]+Alltrim(Str(lnCnt,10))+[ Produtos!!!], 0+64, ...)
2465:     *     Select crProdutos / Go Top In crProdutos / grdProdutos.Refresh
2466:     *     Go Bottom In crProdutos / grdProdutos.Refresh
2467:     *
2468:     * Equivalencias:
2469:     *
2470:     *  a) "pDat = fDtoSQL(Date()-Dias)" e o "Do Case -> lcQuery -> SqlExecute"
2471:     *     inteiros vivem no BO (SigOpSprBO.ObterProdutosEmLote, fases 1-2):
2472:     *     este metodo so le THIS.txt_4c_Dias.Value, grava em
2473:     *     this_oBusinessObject.this_nDias e delega. O lcWhe (faixas do pai)
2474:     *     ja foi migrado para o BO em CarregarContextoFormPai (fase 3) e
2475:     *     MontarFiltroFaixas.
2476:     *
2477:     *  b) "Delete From crProdutos Where Empty(CPros)" ANTES do Scan e
2478:     *     RemoverLinhasEmBranco (fase 7) - mesma linha, metodo unico.
2479:     *
2480:     *  c) "Locate For CPros = LocalCPros.CPros" no legado roda sobre o
2481:     *     cursor INTEIRO (as linhas em branco ja foram removidas no passo
2482:     *     acima) - por isso aqui NAO se reusa ProdutoJaSelecionado (que
2483:     *     exclui a linha CORRENTE pelo RECNO, pensado para o Valid de uma
2484:     *     UNICA celula, fase 6): o lote confere contra TODAS as linhas.
2485:     *
2486:     *  d) "Insert Into crProdutos From Memvar" (Scatter Memvar de
2487:     *     LocalCPros, que so tem CPros/DPros) equivale a APPEND BLANK +
2488:     *     REPLACE dos mesmos dois campos - cursor_4c_Produtos (crProdutos)
2489:     *     tem exatamente essas duas colunas (regra #19: LEFT nas larguras
2490:     *     do schema, CPros char(14) / DPros char(65), ja usadas em
2491:     *     ResolverCelulaSpr).
2492:     *
2493:     *  e) cnpProcessando.Top = 120/500 (mostrar/esconder o aviso "Selecionando
2494:     *     Produtos...", fase 5) fica dentro do MESMO TRY que faz a consulta e
2495:     *     o Scan, com o Top = 500 repetido no CATCH - sem isso um erro no
2496:     *     meio do processamento deixaria o aviso cobrindo a tela para sempre.
2497:     *
2498:     *  f) Depois do Scan o legado garante foco na grade so por via do
2499:     *     Refresh (Go Top/Go Bottom); aqui GarantirLinhaEmBranco (fase 4)
2500:     *     tambem roda, para a tela continuar com uma linha livre para
2501:     *     digitacao - mesmo efeito que o Init e o btnInserir.Click (fase 7)

*-- Linhas 2570 a 2654:
2570:             THIS.this_oBusinessObject.this_nDias = loc_nDias
2571: 
2572:             *-- Legado: pDat = fDtoSQL(...) + Do Case(This.Value) -> lcQuery
2573:             *-- -> SqlExecute(lcQuery,'LocalCPros') - tudo isso no BO
2574:             loc_nResultado = THIS.this_oBusinessObject.ObterProdutosEmLote(loc_nOpcao)
2575: 
2576:             IF loc_nResultado < 0
2577:                 *-- Legado: MessageBox([Favor Reinicializar o Processo!!!],16,...)
2578:                 MsgErro("Favor Reinicializar o Processo!!!", ;
2579:                         "Falha na Conex" + CHR(227) + "o (LocalCPros)")
2580:             ELSE
2581:                 loc_cCursorProcessa = ALLTRIM(THIS.this_oBusinessObject.this_cCursorProcessa)
2582: 
2583:                 *-- Legado: Delete From crProdutos Where Empty(CPros), ANTES
2584:                 *-- do Scan (mesma linha de RemoverLinhasEmBranco, fase 7)
2585:                 THIS.RemoverLinhasEmBranco()
2586: 
2587:                 IF USED(loc_cCursorProcessa)
2588:                     *-- Legado: Select LocalCPros / Scan
2589:                     SELECT (loc_cCursorProcessa)
2590:                     SCAN
2591:                         *-- Legado: If Not Empty(LocalCPros.CPros)
2592:                         loc_cCodigo    = ALLTRIM(NVL(CPros, ""))
2593:                         loc_cDescricao = ALLTRIM(NVL(DPros, ""))
2594: 
2595:                         IF !EMPTY(loc_cCodigo)
2596:                             *-- Legado: Select crProdutos / Go Top In crProdutos
2597:                             *-- / Locate For CPros = LocalCPros.CPros - sobre o
2598:                             *-- cursor INTEIRO, pois as linhas em branco ja
2599:                             *-- foram removidas acima (item c do cabecalho)
2600:                             SELECT (loc_cCursorProdutos)
2601:                             GO TOP
2602:                             LOCATE FOR ALLTRIM(NVL(CPros, "")) == loc_cCodigo
2603: 
2604:                             *-- Legado: If Eof([crProdutos]) -> Insert Into
2605:                             *-- crProdutos From Memvar (Scatter de CPros/DPros)
2606:                             IF EOF()
2607:                                 APPEND BLANK
2608:                                 REPLACE CPros WITH LEFT(loc_cCodigo, 14), ;
2609:                                         DPros WITH LEFT(loc_cDescricao, 65)
2610:                                 loc_nInseridos = loc_nInseridos + 1
2611:                             ENDIF
2612: 
2613:                             *-- Volta para o cursor de resultado, para o SCAN
2614:                             *-- continuar sobre o alias certo
2615:                             SELECT (loc_cCursorProcessa)
2616:                         ENDIF
2617:                     ENDSCAN
2618: 
2619:                     USE IN (loc_cCursorProcessa)
2620:                 ENDIF
2621: 
2622:                 THIS.this_oBusinessObject.this_nQtdSelecionados = loc_nInseridos
2623: 
2624:                 *-- Legado: ThisForm.cnpProcessando.Top = 500
2625:                 IF PEMSTATUS(THIS, "cnt_4c_CnpProcessando", 5)
2626:                     THIS.cnt_4c_CnpProcessando.Top = 500
2627:                 ENDIF
2628: 
2629:                 *-- Legado nao repete este bloco aqui (ja rodou no Init), mas
2630:                 *-- sem ele uma selecao que preencheu TODAS as linhas em
2631:                 *-- branco deixaria a grade sem onde digitar o proximo
2632:                 *-- produto (item f do cabecalho)
2633:                 THIS.GarantirLinhaEmBranco()
2634: 
2635:                 *-- Legado: Select crProdutos / Go Top In crProdutos /
2636:                 *-- grdProdutos.Refresh / Go Bottom In crProdutos /
2637:                 *-- grdProdutos.Refresh
2638:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
2639:                     SELECT (loc_cCursorProdutos)
2640:                     GO TOP
2641:                     THIS.grd_4c_Dados.Refresh()
2642:                     GO BOTTOM
2643:                     THIS.grd_4c_Dados.Refresh()
2644:                 ENDIF
2645: 
2646:                 *-- Legado: MessageBox([Foram Selecionados ]+Alltrim(Str(lnCnt,10))+
2647:                 *-- [ Produtos!!!], 0+64, [Selecao Concluida!!!])
2648:                 MsgInfo("Foram Selecionados " + ALLTRIM(STR(loc_nInseridos, 10)) + ;
2649:                         " Produtos!!!", ;
2650:                         "Sele" + CHR(231) + CHR(227) + "o Conclu" + CHR(237) + "da!!!")
2651:             ENDIF
2652: 
2653:         CATCH TO loc_oErro
2654:             THIS.this_cMensagemErro = loc_oErro.Message


### BO (C:\4c\projeto\app\classes\SigOpSprBO.prg):
*==============================================================================
* SigOpSprBO.prg - Business Object para "Selecionar Produtos" (SIGOPSPR)
*
* Origem legado : SigOpSpr.SCX  (tasks\task805)
* Tipo de form  : OPERACIONAL (dialogo FILHO, chamado pelo form pai)
* Tabela base   : SigCdPro | PK: CPros
* Herda de      : BusinessBase
*
* O QUE A TELA FAZ (legado)
* -------------------------
* Dialogo filho que monta a lista de produtos do form pai (o legado recebe
* "poForm" no Init, troca para a DataSession do pai e manipula o cursor
* LOCAL "crProdutos", que pertence ao pai - no migrado esse alias fica em
* THIS.this_cCursorProdutos). O usuario pode:
*   1) Inserir/Excluir linhas na grade e digitar o produto (lookup em
*      SigCdPro por CPros ou por DPros - fwBuscaExt do legado);
*   2) Processar em LOTE (tres botoes, so quando o pai eh o SIGCDBAL e
*      pcEscolha esta em INSERIR/ALTERAR):
*        Value = 1 "Produtos com Mov."  -> SigMvItn
*        Value = 2 "Produtos nao Inv."  -> SigMvEst com SQtds <> 0
*        Value = 3 "Todos nao Inv."     -> SigCdPro
*      Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
*      corte (Date() - Dias) e aplicam as faixas de filtro herdadas do pai
*      (loFil: Mercs / CGrus / SGrus / Colecoes / Linhas / IFors).
*
* GRAVACAO
* --------
* Toda escrita do legado tem por destino o CURSOR LOCAL do form pai
* (Append Blank / Insert Into crProdutos From Memvar / Delete In crProdutos);
* o acesso ao SQL Server eh 100% de leitura (Select). Por isso este BO NAO
* sobrescreve Inserir() / Atualizar() / ExecutarExclusao(): o comportamento
* padrao herdado de BusinessBase ja eh o correto, e inventar INSERT/UPDATE
* aqui violaria a regra #22 (a lista de colunas vem do schema, nunca de
* adivinhacao).
*
* METODOS DE DADOS (equivalentes a CRUD para este form de leitura)
* ------------------------------------------------------------------
*   CarregarDoCursor(par_cAliasCursor) - mapeia CPros/DPros de uma linha de
*       lookup para this_cCPros/this_cDPros.
*   MontarFiltroFaixas()               - helper PROTECTED: monta o lcWhe do
*       legado a partir das faixas herdadas do pai.
*   ObterProdutosEmLote(par_nOpcao)    - equivalente ao cmdProcessar.Click
*       (as 3 consultas SigMvItn/SigMvEst/SigCdPro). O Form faz o SCAN e o
*       Insert Into no cursor local do pai (manipulacao de cursor VFP, fora
*       deste BO).
*
* LARGURAS DO SCHEMA (docs\schema.sql) - usadas em MaxLength e LEFT()
* -------------------------------------------------------------------
*   SigCdPro.CPros    char(14)   SigCdPro.Mercs    char(3)
*   SigCdPro.DPros    char(65)   SigCdPro.CGrus    char(3)
*   SigMvItn.Emps     char(3)    SigCdPro.SGrus    char(6)
*   SigMvEst.Emps     char(3)    SigCdPro.Colecoes char(10)
*   SigPrIvl.Emps     char(3)    SigCdPro.Linhas   char(10)
*   SigPrIvl.DtHrs    datetime   SigCdPro.IFors    char(10)
*   SigMvEst.SQtds    numeric(11,3)
*==============================================================================

DEFINE CLASS SigOpSprBO AS BusinessBase

    *--------------------------------------------------------------------------
    * ENTIDADE - linha de produto selecionado
    * (colunas do cursor de produtos do form pai, espelhando SigCdPro)
    *--------------------------------------------------------------------------
    this_cCPros              = ""      && CPros char(14) - codigo do produto
    this_cDPros              = ""      && DPros char(65) - descricao do produto

    *--------------------------------------------------------------------------
    * CONTEXTO HERDADO DO FORM PAI
    * Legado: ThisForm.ParentForm.<x> / Set DataSession To poForm.DataSessionId
    *--------------------------------------------------------------------------
    this_cEscolha            = ""      && pcEscolha do pai: INSERIR / ALTERAR / PROCURAR
    this_cNomeFormPai        = ""      && Upper(ParentForm.Name) - lote so quando "SIGCDBAL"
    this_nDataSessionPai     = 0       && DataSessionId do pai (poForm.DataSessionId)
    this_cEmps               = ""      && Emps char(3) - empresa corrente (go_4c_Sistema.cCodEmpresa do legado)

    *--------------------------------------------------------------------------
    * PARAMETROS DO PROCESSAMENTO EM LOTE (cmdProcessar)
    *--------------------------------------------------------------------------
    this_nOpcaoProcessamento = 0       && 1=SigMvItn  2=SigMvEst  3=SigCdPro
    this_nDias               = 0       && getDias.Value - numeric(4), InputMask "9999"
    this_dDataCorte          = {}      && Date() - Dias  (pDat do legado, via fDtoSQL)
    this_nQtdSelecionados    = 0       && lnCnt - produtos efetivamente incluidos
    this_nMaxRegistrosBusca  = 1000    && limite do fwBuscaExt legado (ultimo argumento)

    *--------------------------------------------------------------------------
    * FAIXAS DE FILTRO HERDADAS DO PAI (ParentForm.loFil)
    * Cada par monta "And p.<col> >= 'I'" / "And p.<col> <= 'F'" somente quando
    * nao esta vazio - exatamente como o legado monta lcWhe.
    *--------------------------------------------------------------------------
    this_cMercsI             = ""      && Mercs    char(3)  - inicial
    this_cMercsF             = ""      && Mercs    char(3)  - final
    this_cCGrusI             = ""      && CGrus    char(3)  - inicial
    this_cCGrusF             = ""      && CGrus    char(3)  - final
    this_cSGrusI             = ""      && SGrus    char(6)  - inicial
    this_cSGrusF             = ""      && SGrus    char(6)  - final
    this_cColecoesI          = ""      && Colecoes char(10) - inicial
    this_cColecoesF          = ""      && Colecoes char(10) - final
    this_cLinhasI            = ""      && Linhas   char(10) - inicial
    this_cLinhasF            = ""      && Linhas   char(10) - final
    this_cIForsI             = ""      && IFors    char(10) - inicial
    this_cIForsF             = ""      && IFors    char(10) - final

    *--------------------------------------------------------------------------
    * ALIASES DE CURSOR
    * (nomes do legado entre parenteses - PILAR 3 manda renomear)
    *--------------------------------------------------------------------------
    this_cCursorProdutos     = "cursor_4c_Produtos"       && crProdutos    - cursor do PAI, editado pela grade
    this_cCursorProcessa     = "cursor_4c_ProdProcessa"   && LocalCPros    - resultado do SELECT em lote
    this_cCursorBrancos      = "cursor_4c_LinhasBrancas"  && LocalBrancos  - linhas com CPros vazio
    this_cCursorBusca        = "cursor_4c_BuscaProduto"   && crListaRemota - lookup de SigCdPro

    *--------------------------------------------------------------------------
    * ESTADO DA SESSAO DO DIALOGO
    * Legado: propriedades customizadas lhouveins / lhouveexcl do SIGOPSPR
    *--------------------------------------------------------------------------
    this_lHouveInclusao      = .F.     && lhouveins  - houve inclusao de linha
    this_lHouveExclusao      = .F.     && lhouveexcl - houve exclusao de linha

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *
    * Define a tabela/chave de leitura (SigCdPro.CPros), herda a empresa
    * corrente (o _Empr do legado) e repoe os valores iniciais que o legado
    * tem no proprio SCX: getDias.Value = 0 e cmdProcessar.Value = 0.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"

        *-- Empresa corrente: o legado usa a PUBLIC _Empr; no sistema novo o
        *-- equivalente eh go_4c_Sistema.cCodEmpresa (ver CLAUDE.md).
        IF TYPE("go_4c_Sistema") = "O" AND !ISNULL(go_4c_Sistema)
            THIS.this_cEmps = ALLTRIM(go_4c_Sistema.cCodEmpresa)
        ELSE
            THIS.this_cEmps = ""
        ENDIF

        *-- Valores iniciais identicos aos do SCX legado
        THIS.this_nDias               = 0
        THIS.this_nOpcaoProcessamento = 0
        THIS.this_nQtdSelecionados    = 0
        THIS.this_dDataCorte          = DATE()
        THIS.this_lHouveInclusao      = .F.
        THIS.this_lHouveExclusao      = .F.

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave para a auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCPros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de uma linha de SigCdPro (CPros,
    * DPros) para as propriedades do BO. Usado depois de um SELECT de
    * verificacao/lookup (ex.: cursor_4c_BuscaProduto) para o Form ler o
    * produto corrente sem acessar o cursor diretamente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCPros = TratarNulo(CPros, "C")
            THIS.this_cDPros = TratarNulo(DPros, "C")
            RETURN .T.
        ENDIF

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarFiltroFaixas - Monta o trecho "AND p.<col> >= '..' AND p.<col>
    * <= '..'" a partir das faixas herdadas do pai (loFil do legado),
    * exatamente como o cmdProcessar.Click monta lcWhe: cada faixa so entra
    * quando NAO esta vazia.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarFiltroFaixas()
        LOCAL loc_cWhe
        loc_cWhe = ""

        IF !EMPTY(THIS.this_cMercsI)
            loc_cWhe = loc_cWhe + " AND p.Mercs >= " + EscaparSQL(ALLTRIM(THIS.this_cMercsI))
        ENDIF
        IF !EMPTY(THIS.this_cMercsF)
            loc_cWhe = loc_cWhe + " AND p.Mercs <= " + EscaparSQL(ALLTRIM(THIS.this_cMercsF))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusI)
            loc_cWhe = loc_cWhe + " AND p.CGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cCGrusF)
            loc_cWhe = loc_cWhe + " AND p.CGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cCGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusI)
            loc_cWhe = loc_cWhe + " AND p.SGrus >= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusI))
        ENDIF
        IF !EMPTY(THIS.this_cSGrusF)
            loc_cWhe = loc_cWhe + " AND p.SGrus <= " + EscaparSQL(ALLTRIM(THIS.this_cSGrusF))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesI)
            loc_cWhe = loc_cWhe + " AND p.Colecoes >= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesI))
        ENDIF
        IF !EMPTY(THIS.this_cColecoesF)
            loc_cWhe = loc_cWhe + " AND p.Colecoes <= " + EscaparSQL(ALLTRIM(THIS.this_cColecoesF))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasI)
            loc_cWhe = loc_cWhe + " AND p.Linhas >= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasI))
        ENDIF
        IF !EMPTY(THIS.this_cLinhasF)
            loc_cWhe = loc_cWhe + " AND p.Linhas <= " + EscaparSQL(ALLTRIM(THIS.this_cLinhasF))
        ENDIF
        IF !EMPTY(THIS.this_cIForsI)
            loc_cWhe = loc_cWhe + " AND p.IFors >= " + EscaparSQL(ALLTRIM(THIS.this_cIForsI))
        ENDIF
        IF !EMPTY(THIS.this_cIForsF)
            loc_cWhe = loc_cWhe + " AND p.IFors <= " + EscaparSQL(ALLTRIM(THIS.this_cIForsF))
        ENDIF

        RETURN loc_cWhe
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterProdutosEmLote - Equivalente ao cmdProcessar.Click do legado.
    * par_nOpcao: 1 = "Produtos com Mov." (SigMvItn)
    *             2 = "Produtos nao Inv." (SigMvEst com SQtds <> 0)
    *             3 = "Todos nao Inv."    (SigCdPro)
    * Os tres excluem o que ja foi inventariado em SigPrIvl desde a data de
    * corte (Date() - Dias) e aplicam as faixas herdadas do pai. Resultado
    * fica em THIS.this_cCursorProcessa (equivalente a LocalCPros); quem
    * chama (o Form) faz o SCAN e o Insert Into no cursor local do pai -
    * esse ultimo passo eh manipulacao de cursor VFP, nao SQL, e por isso
    * fica fora deste BO (ver cabecalho: toda escrita vai para o cursor do
    * form pai).
    *
    * Retorna o numero de linhas (>= 0) ou -1 em falha de conexao/opcao
    * invalida - igual ao "< 1" do SqlExecute legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterProdutosEmLote(par_nOpcao)
        LOCAL loc_cSQL, loc_cWhe, loc_cDataCorte, loc_nResultado

        IF THIS.this_nDias < 1
            RETURN -1
        ENDIF

        THIS.this_nOpcaoProcessamento = par_nOpcao
        THIS.this_dDataCorte          = DATE() - THIS.this_nDias
        loc_cDataCorte                = FormatarDataSQL(THIS.this_dDataCorte)
        loc_cWhe                      = THIS.MontarFiltroFaixas()

        DO CASE
            CASE par_nOpcao = 1
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvItn a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 2
                loc_cSQL = "SELECT DISTINCT a.CPros, p.DPros" +;
                           " FROM SigMvEst a" +;
                           " INNER JOIN SigCdPro p ON a.CPros = p.CPros" +;
                           " WHERE a.Emps = " + EscaparSQL(THIS.this_cEmps) + loc_cWhe +;
                           " AND NOT a.SQtds = 0" +;
                           " AND a.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" +;
                           " ORDER BY a.CPros"

            CASE par_nOpcao = 3
                loc_cSQL = "SELECT DISTINCT p.CPros, p.DPros" +;
                           " FROM SigCdPro p" +;
                           " WHERE p.CPros NOT IN (SELECT l.CPros FROM SigPrIvl l" +;
                           " WHERE l.Emps = " + EscaparSQL(THIS.this_cEmps) +;
                           " AND l.DtHrs >= " + loc_cDataCorte + ")" + loc_cWhe +;
                           " ORDER BY p.CPros"

            OTHERWISE
                RETURN -1
        ENDCASE

        IF USED(THIS.this_cCursorProcessa)
            USE IN (THIS.this_cCursorProcessa)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProcessa)

        RETURN loc_nResultado
    ENDFUNC

ENDDEFINE

