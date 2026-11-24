# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CBLOCOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, EMPDOPNUMS, CPROS, DUN
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NDOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CITENS, EMPDOPNUMS, CPROS, DUN

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
  ControlSource = "crSigMvOrc.DPros"
  DeleteMark = .F.
	Select crSigMvOrp
	Select Datas, Sum(Valos) as Valos, Sum(VlBaixas) as VlBaixas, Sum(Valos - VlBaixas) as VlPends From crSigMvOrp Group By Datas Into Cursor crTmpTotOrp
	Select crSigMvOrp
	Select crTmpTotOrp
			.Column1.ControlSource = 'crTmpTotOrp.Datas'
			.Column2.ControlSource = 'crTmpTotOrp.Valos'
			.Column3.ControlSource = 'crTmpTotOrp.VlBaixas'
			.Column4.ControlSource = 'crTmpTotOrp.VlPends'
	Select Sum(Valos) as Valos, Sum(VlBaixas) as VlBaixas, Sum(Valos - VlBaixas) as VlPends From crSigMvOrp Into Cursor crTmpTotOrp2
	Select Citens, Dpros, Sum(tota1s + tota2s + tota3s) as Tota1s ;
		from crSigMvOrc ;
	Select crTmpTotal
			.Column1.ControlSource = 'crTmpTotal.Dpros'
			.Column2.ControlSource = 'crTmpTotal.Tota1s'
		lcSqlEstPe = [Select b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds, c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas, c.totas, ] +;
		             [From SigMvItn a Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums ] +;
		             [Inner Join SigMvOrc c On a.EmpDopNums = c.EmpDopNums And a.Citens = c.Citens ] +;
		             [Inner Join SigCdUni d On a.Cunis = d.Cunis ] +;
		             [Inner Join SigCdUni e On a.Cunips = e.Cunis ] +;
		If (ThisForm.Parentform.ParentForm.poDataMgr.SqlExecute(lcSqlEstPe, 'crMvPec') < 1)
		Select crMvPec
		Insert into TmpItePen from Memvar
	Select TmpItePen
		.Column1.ControlSource = [TmpItePen.DopeNums]
		.Column6.ControlSource = [TmpItePen.Datas]		
		.Column2.ControlSource = [TmpItePen.Qtds]
		.Column8.ControlSource = [TmpItePen.Dcunis]	
		.Column3.ControlSource = [TmpItePen.Pesos]
		.Column9.ControlSource = [TmpItePen.DcuniPs]
		.Column7.ControlSource = [TmpItePen.Fators]
		.Column4.ControlSource = [TmpItePen.Units]
		.Column10.ControlSource = [TmpItePen.Totas]

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPTOR.prg) - TRECHOS RELEVANTES PARA PASS SQL (1758 linhas total):

*-- Linhas 9 a 27:
9: *   BD   -> SigMvOrp/SigMvOrc/SigCdOpe/SigMvItn/SigMvCab/SigCdUni, consultadas
10: *           via SIGOPTORBO (ver cabecalho desse BO para o detalhamento das
11: *           duas queries); esta tela eh SOMENTE LEITURA, sem nenhum
12: *           INSERT/UPDATE/DELETE
13: *   CODE -> arquitetura em camadas (FormBase / SIGOPTORBO)
14: *
15: * O QUE ESTA TELA EH
16: *   Dialogo FILHO que o form pai de Orcamento/Pre-Custo abre via
17: *   "Do Form SigOpTor With ThisForm, nDataSession, pcVisual". O legado
18: *   recebe (pform, datses, pVisual), faz "Set Datasession To DatSes" para
19: *   ler os cursores do pai (crSigMvOrp/crSigMvOrc/crSigOpCdd/crSigCdOpe) SEM
20: *   trocar de maquina de consulta, e normaliza pVisual: quando o parametro
21: *   nao eh informado (chega como Logico, tipo default do LPARAMETERS
22: *   omitido) o modo vira "P" (Total Previsao); qualquer outro valor Char eh
23: *   "Itens Subnivel".
24: *
25: *   Modo "P" liga a grade GrdTotPrev (Data/Previsto/Realizado/Diferenca) +
26: *   os 3 totalizadores (getTotPrev/getTotReal/getTotDif) + a grade grdTotal
27: *   (Item/Total NFs), e ESCONDE grdItem/Say2/getDProd. Modo != "P" monta a

*-- Linhas 100 a 118:
100: *   - ConfigurarGrade()         grdItem/GrdTotPrev/grdTotal do legado ->
101: *                                grd_4c_ItensPendentes/grd_4c_TotalPorData/
102: *                                grd_4c_TotalGeral (SO o que nao depende de
103: *                                dado - ControlSource/RecordSource ficam em
104: *                                CarregarLista, regra #41)
105: *   - AplicarFormatoGradeItem/TotPrev/Total()  FONTE UNICA de Column.Width/
106: *                                Header1.Caption/ColumnOrder - RecordSource
107: *                                zera esses valores (Problema 48), entao
108: *                                CarregarLista reaplica depois do bind
109: *   - ConfigurarBotoes()         OK.btnSair do legado -> cmg_4c_OK
110: *                                (CommandGroup, ButtonCount=1) + Buttons(1)
111: *                                "Retornar"
112: *   - BtnRetornarClick()         btnSair.Click do legado (reabilita o pai +
113: *                                Release) - entrou junto com o botao: eh o
114: *                                UNICO botao da tela (ControlBox=.F.,
115: *                                TitleBar=0) e deixa-lo inerte tiraria a
116: *                                saida pelo mouse
117: *   - CarregarLista()            funil: despacha para o modo "P" (Total
118: *                                Previsao, duas grades) ou "Itens

*-- Linhas 211 a 229:
211: *   - FormParaBO()/BOParaForm() -> NAO SE APLICAM: este dialogo eh SOMENTE
212: *     LEITURA em AMBOS os modos (ver cabecalho de SIGOPTORBO.prg - todas
213: *     as colunas das 3 grades sao ReadOnly=.T. no SCX, sem nenhum
214: *     INSERT/UPDATE/DELETE), entao nao ha "form -> BO" para gravar nem
215: *     "BO -> form" de edicao alem do que CarregarModoPrevisaoNaTela/
216: *     CarregarModoItensSubnivelNaTela (Fase 4) ja fazem ao popular as
217: *     grades e os totalizadores a partir do BO.
218: *   - HabilitarCampos()/LimparCampos() -> NAO SE APLICAM: nao ha campo
219: *     editavel nenhum na tela (os 2 TextBox soltos - txt_4c_DProd e os 3
220: *     txt_4c_Tot* - tem When = .F. e nunca recebem foco, Fases 5-6), nem
221: *     modo INCLUIR/ALTERAR/VISUALIZAR a transicionar.
222: *   - CarregarLista() -> JA EXISTE e esta COMPLETO desde a Fase 4 (funil
223: *     que despacha para CarregarModoPrevisaoNaTela/
224: *     CarregarModoItensSubnivelNaTela conforme this_cModoVisual), chamado
225: *     pelo proprio InicializarForm (Fase 3) fora de modo teste/validacao
226: *     de UI - nao ha "segunda metade" desta fase para completar.
227: *   - AjustarBotoesPorModo() -> NAO SE APLICA: nao ha modo LISTA/INCLUIR/
228: *     ALTERAR/VISUALIZAR/EXCLUIR neste dialogo (this_cModoVisual eh
229: *     "P"/Itens Subnivel, um toggle de EXIBICAO entre duas composicoes de

*-- Linhas 559 a 643:
559:     * elas nao eh critica - preservada so por fidelidade ao dump.
560:     *
561:     * Aqui ficam SO as propriedades que NAO dependem de dado (regra #41):
562:     * ControlSource/RecordSource moram em CarregarLista, porque atribuir
563:     * ControlSource de alias que ainda nao existe derruba o Init.
564:     *
565:     * RecordMark = .F. em todas (grade de form OPERACIONAL criada por
566:     * AddObject - regra do projeto, sem isso a barra de marcacao aparece
567:     * na lateral e come largura util). grdItem.RecordMark nao consta do
568:     * dump (herda o default); GrdTotPrev/grdTotal declaram DeleteMark=.F.
569:     * explicito - RecordMark = .F. acompanha por fidelidade ao padrao.
570:     *==========================================================================
571:     PROTECTED PROCEDURE ConfigurarGrade
572:         *-- grdItem -> grd_4c_ItensPendentes (TmpItePen no legado) - Modo
573:         *-- "Itens Subnivel". ReadOnly = .F. no GRID (literal do dump) -
574:         *-- cada Column.ReadOnly = .T. sobrescreve depois, em
575:         *-- AplicarFormatoGradeItem (regra #18: Column.ReadOnly DEPOIS do
576:         *-- Grid.ReadOnly)
577:         THIS.AddObject("grd_4c_ItensPendentes", "Grid")
578:         WITH THIS.grd_4c_ItensPendentes
579:             .ColumnCount   = 9
580:             .FontName      = "Tahoma"
581:             .FontSize      = 8
582:             .HeaderHeight  = 22
583:             .Top           = 192
584:             .Left          = 1
585:             .Width         = 997
586:             .Height        = 365
587:             .RowHeight     = 16
588:             .ReadOnly      = .F.
589:             .RecordMark    = .F.
590:             .DeleteMark    = .F.
591:             .TabIndex      = 2
592:             .Visible       = .T.
593:         ENDWITH
594: 
595:         *-- GrdTotPrev -> grd_4c_TotalPorData (crTmpTotOrp no legado) -
596:         *-- Modo "P", 1a grade (Data/Previsto/Realizado/Diferenca)
597:         THIS.AddObject("grd_4c_TotalPorData", "Grid")
598:         WITH THIS.grd_4c_TotalPorData
599:             .ColumnCount   = 4
600:             .FontName      = "Tahoma"
601:             .FontSize      = 8
602:             .Top           = 193
603:             .Left          = 259
604:             .Width         = 479
605:             .Height        = 364
606:             .RowHeight     = 16
607:             .ScrollBars    = 2
608:             .DeleteMark    = .F.
609:             .RecordMark    = .F.
610:             .ReadOnly      = .T.
611:             .TabIndex      = 4
612:             .Visible       = .T.
613:         ENDWITH
614: 
615:         *-- grdTotal -> grd_4c_TotalGeral (crTmpTotal no legado) - Modo
616:         *-- "P", 2a grade (Item/Total NFs)
617:         THIS.AddObject("grd_4c_TotalGeral", "Grid")
618:         WITH THIS.grd_4c_TotalGeral
619:             .ColumnCount   = 2
620:             .FontName      = "Tahoma"
621:             .FontSize      = 8
622:             .Top           = 88
623:             .Left          = 259
624:             .Width         = 479
625:             .Height        = 97
626:             .RowHeight     = 16
627:             .ScrollBars    = 2
628:             .DeleteMark    = .F.
629:             .RecordMark    = .F.
630:             .ReadOnly      = .T.
631:             .TabIndex      = 4
632:             .Visible       = .T.
633:         ENDWITH
634: 
635:         *-- Largura/cabecalho/ordem das colunas NAO ficam neste bloco: moram
636:         *-- nos metodos abaixo, FONTE UNICA desses numeros, que CarregarLista
637:         *-- reaplica depois do RecordSource (que os zera - Problema 48 /
638:         *-- regra #41)
639:         THIS.AplicarFormatoGradeItem()
640:         THIS.AplicarFormatoGradeTotPrev()
641:         THIS.AplicarFormatoGradeTotal()
642:     ENDPROC
643: 

*-- Linhas 892 a 910:
892:     * grd_4c_TotalPorData (SIGOPTOR.GrdTotPrev)
893:     *
894:     * Transcricao do dump (SIGOPTOR.GrdTotPrev):
895:     *   Column1  Width=80  "Data"       (ControlSource: crTmpTotOrp.Datas)
896:     *   Column2  Width=122 "Previsto"   InputMask="99,999,999.99" (Valos)
897:     *   Column3  Width=122 "Realizado"  InputMask="99,999,999.99" (VlBaixas)
898:     *   Column4  Width=122 "Diferenca"  InputMask="99,999,999.99" na Column
899:     *            E "999999"/MaxLength=6/ReadOnly=.T. no Text1 (dois niveis
900:     *            distintos no dump - transcritos os dois, regra #17)
901:     *==========================================================================
902:     PROCEDURE AplicarFormatoGradeTotPrev
903:         LOCAL loc_lAplicou
904:         loc_lAplicou = .F.
905: 
906:         IF PEMSTATUS(THIS, "grd_4c_TotalPorData", 5)
907:             WITH THIS.grd_4c_TotalPorData
908:                 .Column1.Width             = 80
909:                 .Column1.Movable           = .F.
910:                 .Column1.Resizable         = .F.

*-- Linhas 985 a 1003:
985:     * grd_4c_TotalGeral (SIGOPTOR.grdTotal)
986:     *
987:     * Transcricao do dump (SIGOPTOR.grdTotal):
988:     *   Column1  Width=200 "Item"      (ControlSource: crTmpTotal.Dpros)
989:     *   Column2  Width=122 "Total NFs" InputMask="99,999,999.99" (Tota1s)
990:     *==========================================================================
991:     PROCEDURE AplicarFormatoGradeTotal
992:         LOCAL loc_lAplicou
993:         loc_lAplicou = .F.
994: 
995:         IF PEMSTATUS(THIS, "grd_4c_TotalGeral", 5)
996:             WITH THIS.grd_4c_TotalGeral
997:                 .Column1.Width             = 200
998:                 .Column1.Movable           = .F.
999:                 .Column1.Resizable         = .F.
1000:                 .Column1.FontName          = "Tahoma"
1001:                 .Column1.FontSize          = 8
1002:                 .Column1.ReadOnly          = .T.
1003:                 .Column1.Header1.Caption   = "Item"

*-- Linhas 1050 a 1072:
1050:     * Label criado por AddObject, por isso Width/Height explicitos abaixo
1051:     * (texto curto, uma linha), com Alignment=0 (esquerda, como o legado).
1052:     *
1053:     * txt_4c_DProd (getDProd): ControlSource = "crSigMvOrc.DPros" no dump -
1054:     * cursor do FORM PAI, visivel aqui porque este dialogo roda na mesma
1055:     * DataSession (DataSession=1, Fase 3). Guardado por USED(): em modo
1056:     * teste/validacao de UI o cursor do pai nao existe, e sem a guarda a
1057:     * atribuicao de ControlSource estouraria "Alias nao encontrado" dentro
1058:     * do TRY de InicializarForm.
1059:     *
1060:     * When = .F. (dump: "PROCEDURE When / Return .f.") - o campo nunca
1061:     * recebe foco via Tab/clique, so exibe. O LostFocus do dump ("If
1062:     * ThisForm.fwGrade.Visible / ThisForm.fwGrade.SetFocus / EndIf")
1063:     * referencia um objeto "fwGrade" que NAO existe neste SCX (nenhum grid
1064:     * do form se chama assim) - boilerplate de classe-base nunca
1065:     * customizado para esta instancia; como When=.F. ja bloqueia o foco,
1066:     * esse LostFocus eh inalcancavel por construcao e NAO foi reproduzido
1067:     * (regra #13 - nunca referenciar objeto que nao existe).
1068:     *==========================================================================
1069:     PROTECTED PROCEDURE ConfigurarCamposPrincipais
1070:         *-- Say2 -> lbl_4c_Label2 ("Descricao")
1071:         THIS.AddObject("lbl_4c_Label2", "Label")
1072:         WITH THIS.lbl_4c_Label2

*-- Linhas 1105 a 1123:
1105:             .Value             = ""
1106: 
1107:             IF USED("crSigMvOrc")
1108:                 .ControlSource = "crSigMvOrc.DPros"
1109:             ENDIF
1110: 
1111:             .Visible = .T.
1112:         ENDWITH
1113: 
1114:         *-- getDProd.When do legado - metodo PUBLIC (regra #3: BINDEVENT
1115:         *-- exige metodo PUBLIC, PROTECTED falha em silencio)
1116:         BINDEVENT(THIS.txt_4c_DProd, "When", THIS, "TxtDProdWhen")
1117:     ENDPROC
1118: 
1119:     *==========================================================================
1120:     * TxtDProdWhen - getDProd.When do legado ("PROCEDURE When / Return
1121:     * .f."): o campo nunca recebe foco, eh so exibicao.
1122:     *==========================================================================
1123:     PROCEDURE TxtDProdWhen

*-- Linhas 1157 a 1175:
1157:     *
1158:     * .Value inicializado como 0 (NUMERICO - os 3 campos exibem soma
1159:     * monetaria via Nvl(...,0) no legado, nunca texto), e SEM
1160:     * ControlSource (o legado tambem nao liga por ControlSource: atribui
1161:     * .Value direto no Init a partir de crTmpTotOrp2).
1162:     *
1163:     * When = .F. nos 3 (dump: "PROCEDURE When / Return .f." repetido em
1164:     * getTotPrev/getTotReal/getTotDif) - mesmo padrao de getDProd (Fase 5).
1165:     *==========================================================================
1166:     PROTECTED PROCEDURE ConfigurarCamposTotalizadores
1167:         *-- getTotPrev -> txt_4c_TotPrev
1168:         THIS.AddObject("txt_4c_TotPrev", "TextBox")
1169:         WITH THIS.txt_4c_TotPrev
1170:             .FontName          = "Tahoma"
1171:             .FontSize          = 8
1172:             .Format            = "K!"
1173:             .Top               = 568
1174:             .Left              = 315
1175:             .Width             = 122

*-- Linhas 1507 a 1560:
1507:         THIS.grd_4c_TotalPorData.RecordSource = loc_cAlias
1508: 
1509:         WITH THIS.grd_4c_TotalPorData
1510:             .Column1.ControlSource = loc_cAlias + ".Datas"
1511:             .Column2.ControlSource = loc_cAlias + ".Valos"
1512:             .Column3.ControlSource = loc_cAlias + ".VlBaixas"
1513:             .Column4.ControlSource = loc_cAlias + ".VlPends"
1514:         ENDWITH
1515: 
1516:         *-- Reaplica largura/cabecalho, que o RecordSource zerou
1517:         THIS.AplicarFormatoGradeTotPrev()
1518: 
1519:         *-- Legado: Select crTmpTotOrp / Go Top (a grade ja refresca sozinha
1520:         *-- ao religar RecordSource, mas o GO TOP + Refresh explicito segue
1521:         *-- a regra #21a do projeto)
1522:         SELECT (loc_cAlias)
1523:         GO TOP
1524:         THIS.grd_4c_TotalPorData.Refresh()
1525:     ENDPROC
1526: 
1527:     *==========================================================================
1528:     * VincularGradeTotal - bind de grd_4c_TotalGeral ao cursor que o BO
1529:     * acabou de montar. Mesma ressalva do GRIDWITHFP acima.
1530:     *==========================================================================
1531:     PROTECTED PROCEDURE VincularGradeTotal
1532:         LOCAL loc_cAlias
1533:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorTotalGeral
1534: 
1535:         THIS.grd_4c_TotalGeral.ColumnCount  = 2
1536:         THIS.grd_4c_TotalGeral.RecordSource = loc_cAlias
1537: 
1538:         WITH THIS.grd_4c_TotalGeral
1539:             .Column1.ControlSource = loc_cAlias + ".Dpros"
1540:             .Column2.ControlSource = loc_cAlias + ".Tota1s"
1541:         ENDWITH
1542: 
1543:         THIS.AplicarFormatoGradeTotal()
1544: 
1545:         SELECT (loc_cAlias)
1546:         GO TOP
1547:         THIS.grd_4c_TotalGeral.Refresh()
1548:     ENDPROC
1549: 
1550:     *==========================================================================
1551:     * CarregarModoItensSubnivelNaTela - Modo "Itens Subnivel" (legado: ramo
1552:     * ELSE do Init, comentario "Tiago - 14/04/2014 - SRCOM"). Le o contexto
1553:     * (nCodigos/Cpros/Emps) de crSigMvOrc - cursor do form pai, ja na
1554:     * DataSession compartilhada - chama SIGOPTORBO.CarregarModoItensSubnivel
1555:     * (Fases 1-2) e faz o bind de grdItem.
1556:     *
1557:     * Legado: "If Eof([TmpItePen]) / ThisForm.ParentForm.Enabled = .t. /
1558:     * Return .f. / Endif" - quando a cadeia de subniveis nao acha NENHUM
1559:     * item, o Init aborta (devolve .F., e CREATEOBJECT no chamador nunca
1560:     * chega a existir). Reproduzido aqui: RETURN .F. propaga para

*-- Linhas 1660 a 1691:
1660:         THIS.grd_4c_ItensPendentes.RecordSource = loc_cAlias
1661: 
1662:         WITH THIS.grd_4c_ItensPendentes
1663:             .Column1.ControlSource = loc_cAlias + ".DopeNums"
1664:             .Column2.ControlSource = loc_cAlias + ".Qtds"
1665:             .Column3.ControlSource = loc_cAlias + ".Pesos"
1666:             .Column4.ControlSource = loc_cAlias + ".Units"
1667:             .Column5.ControlSource = loc_cAlias + ".Datas"
1668:             .Column6.ControlSource = loc_cAlias + ".Fators"
1669:             .Column7.ControlSource = loc_cAlias + ".Dcunis"
1670:             .Column8.ControlSource = loc_cAlias + ".Dcunips"
1671:             .Column9.ControlSource = loc_cAlias + ".Totas"
1672:         ENDWITH
1673: 
1674:         THIS.AplicarFormatoGradeItem()
1675: 
1676:         SELECT (loc_cAlias)
1677:         GO TOP
1678:         THIS.grd_4c_ItensPendentes.Refresh()
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * AtualizarCaptionCabecalho - propaga THIS.Caption (ja atualizado por
1683:     * CarregarModoPrevisaoNaTela/CarregarModoItensSubnivelNaTela) para os
1684:     * dois labels do cabecalho (legado: os dois Caption de cntSombra
1685:     * seguem ThisForm.Caption, que o Init tambem reatribui dentro de cada
1686:     * ramo do IF).
1687:     *==========================================================================
1688:     PROTECTED PROCEDURE AtualizarCaptionCabecalho
1689:         IF PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1690:             IF PEMSTATUS(THIS.cnt_4c_Cabecalho, "lbl_4c_Sombra", 5)
1691:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption


### BO (C:\4c\projeto\app\classes\SIGOPTORBO.prg):
*==============================================================================
* SIGOPTORBO.PRG
* Business Object para o dialogo "Total" (SIGOPTOR) - dialogo filho MODAL
* aberto pelo form pai de Orcamento/Pre-Custo via
* "Do Form SigOpTor With ThisForm, nDataSession, pcVisual", NAO acessivel
* direto pelo menu.
*
* NATUREZA DESTE DIALOGO (lido do legado, SIGOPTOR.Init):
*   O Init recebe (pform, datses, pVisual): pform e o form PAI, datses e a
*   DataSession do pai (o dialogo faz "Set Datasession To DatSes" para
*   conseguir ler os cursores do pai - crSigMvOrp/crSigMvOrc/crSigOpCdd/
*   crSigCdOpe - ANTES de qualquer coisa; NAO abre DataSession propria,
*   apesar de DataSession = 2 declarado no SCX).
*
*   pVisual = "P"  -> modo "Total Previsao":
*     - Select Datas, Sum(Valos) as Valos, Sum(VlBaixas) as VlBaixas,
*       Sum(Valos - VlBaixas) as VlPends From crSigMvOrp Group By Datas
*       (SQL LOCAL do VFP sobre cursor ja carregado pelo pai - NAO usa
*       gnConnHandle) alimenta a grade grdTotPrev (Data/Previsto/
*       Realizado/Diferenca).
*     - Select Sum(Valos), Sum(VlBaixas), Sum(Valos - VlBaixas) From
*       crSigMvOrp (sem Group By) alimenta os totalizadores
*       getTotPrev/getTotReal/getTotDif.
*     - Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) From crSigMvOrc
*       Where cBlocos In ('SUBTOTAIS','TAXA','TOTAL','IMPOSTO',
*       'TOTALGERAL') Group By Citens, Dpros alimenta a grade grdTotal
*       (Item/Total NFs).
*
*   pVisual <> "P" -> modo "Itens Subnivel" (Tiago - 14/04/2014 - SRCOM):
*     busca todos os subniveis que o item (crSigMvOrc.nCodigos) passou,
*     subindo a cadeia via SigCdOpe.Dopes + Str(Nume,6) = EmpDopNums e
*     consultando (via poDataMgr do form AVO, nao gnConnHandle direto):
*       Select b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds,
*         c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas,
*         c.totas, d.Dunis as Dcunis, e.Dunis as Dcunips
*       From SigMvItn a
*       Inner Join SigMvCab b On a.EmpDopNums = b.EmpDopNums
*       Inner Join SigMvOrc c On a.EmpDopNums = c.EmpDopNums
*                             And a.Citens = c.Citens
*       Inner Join SigCdUni d On a.Cunis = d.Cunis
*       Inner Join SigCdUni e On a.Cunips = e.Cunis
*       Where a.EmpDopNums = '<Emps+Dopes+Str(Nume,6)>'
*         And a.Cpros = '<crSigMvOrc.Cpros>'
*     repetido em loop (Do While llAchou) at? o proximo nCodigos nao
*     encontrar mais SigCdOpe correspondente - cada linha alimenta a
*     grade grdItem (Movimentacao/Quantidade/Periodo/Unitario/Data/
*     Turno/Unidade/Unidade/Total).
*
*   O dialogo e SOMENTE LEITURA em AMBOS os modos (todas as colunas das
*   tres grades tem ReadOnly = .T. no SCX, sem nenhum botao de gravacao) -
*   o unico botao e OK.btnSair (Caption "Retornar"), que reabilita o form
*   pai e libera o dialogo:
*     ThisForm.ParentForm.Enabled = .T.
*     ThisForm.Release()
*
*   Por isso este BO NAO sobrescreve Inserir()/Atualizar()/
*   ExecutarExclusao(): o comportamento padrao herdado de BusinessBase
*   (recusar a operacao e reportar pelo ExibirFalha do Salvar) ja eh o
*   correto, e inventar INSERT/UPDATE aqui violaria a regra #22 do
*   CLAUDE.md (a lista de colunas vem do schema, nunca de adivinhacao).
*
* Tabela de contexto : SigMvOrc (orcamento/pre-custo) - usada para montar
*                       o filtro do modo Itens Subnivel (crSigMvOrc.Cpros/
*                       nCodigos/DPros, vindos do form pai) e consultada
*                       via JOIN com SigMvItn/SigMvCab/SigCdUni/SigCdOpe.
* Chave Real (contexto): Citens  CHAR - identifica a linha de orcamento
*                       corrente no form pai (SigMvOrc.Citens).
*==============================================================================

DEFINE CLASS SIGOPTORBO AS BusinessBase

    *--------------------------------------------------------------------------
    * MODO DE EXIBICAO - espelha o parametro pVisual recebido pelo Form
    * "P" = Total Previsao | qualquer outro valor = Itens Subnivel
    *--------------------------------------------------------------------------
    this_cModoExibicao          = ""  && pVisual - "P" ou vazio/outro
    this_cTituloDialogo          = ""  && Caption montado conforme o modo

    *--------------------------------------------------------------------------
    * CONTEXTO - SigMvOrc (crSigMvOrc no legado, cursor do form pai)
    * Linha corrente de orcamento que originou a abertura do dialogo.
    *--------------------------------------------------------------------------
    this_nCodigoAtual            = 0   && nCodigos  N      - ponto de partida do loop Itens Subnivel
    this_cProdutoAtual           = ""  && Cpros     CHAR(14) - filtro a.Cpros nas consultas do modo item
    this_cDescricaoProduto       = ""  && DPros     CHAR(40) - getDProd.Value (contexto, so leitura)

    *--------------------------------------------------------------------------
    * MODO "P" - TOTAIS GERAIS (crTmpTotOrp2 no legado, linha unica)
    * Alimentam getTotPrev/getTotReal/getTotDif.
    *--------------------------------------------------------------------------
    this_nTotalPrevisto          = 0   && Sum(Valos) de crSigMvOrp         - getTotPrev.Value
    this_nTotalRealizado         = 0   && Sum(VlBaixas) de crSigMvOrp      - getTotReal.Value
    this_nTotalDiferenca         = 0   && Sum(Valos - VlBaixas)            - getTotDif.Value

    *--------------------------------------------------------------------------
    * CURSORES DE GRADE (nascem vazios no InicializarForm; populados pelos
    * metodos Carregar* nas fases seguintes)
    *--------------------------------------------------------------------------
    this_cCursorTotalPorData     = "cursor_4c_TotalPorData"     && grdTotPrev <- crTmpTotOrp  (Datas, Valos, VlBaixas, VlPends)
    this_cCursorTotalGeral       = "cursor_4c_TotalGeral"       && grdTotal   <- crTmpTotal    (Dpros, Tota1s)
    this_cCursorItensPendentes   = "cursor_4c_ItensPendentes"   && grdItem    <- TmpItePen     (DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, Units, Moedas, Totas, Datas, Dcunis, Dcunips)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotPrev (cursor_4c_TotalPorData)
    *--------------------------------------------------------------------------
    this_dDatasTotal             = {}  && Datas     D        - data do agrupamento
    this_nValos                  = 0   && Valos     N(15,2)  - total previsto do dia
    this_nVlBaixas                = 0   && VlBaixas  N(15,2)  - total realizado (baixado) do dia
    this_nVlPends                = 0   && VlPends   N(15,2)  - diferenca (Valos - VlBaixas)

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdTotal (cursor_4c_TotalGeral)
    *--------------------------------------------------------------------------
    this_cDprosTotal              = ""  && Dpros     CHAR(40) - descricao do item de total (subtotais/taxa/imposto/total geral)
    this_nTota1s                  = 0   && Tota1s    N(15,2)  - Sum(tota1s + tota2s + tota3s) do item

    *--------------------------------------------------------------------------
    * LINHA CORRENTE - grdItem (cursor_4c_ItensPendentes / TmpItePen)
    *--------------------------------------------------------------------------
    this_cDopeNums                = ""  && DopeNums  CHAR(26) - Dopes + Str(Nume,6), identifica a movimentacao
    this_cCPros                   = ""  && CPros     CHAR(14) - codigo do produto da linha
    this_cDpros                   = ""  && Dpros     CHAR(40) - descricao do produto da linha
    this_nQtds                    = 0   && Qtds      N(12,3)  - quantidade movimentada
    this_cCunis                   = ""  && Cunis     CHAR(3)  - unidade da quantidade
    this_nPesos                   = 0   && Pesos     N(12,3)  - peso movimentado
    this_cCuniPs                  = ""  && CuniPs    CHAR(3)  - unidade do peso
    this_nFators                  = 0   && Fators    N(12,3)  - fator de conversao
    this_nUnits                   = 0   && Units     N(12,3)  - valor unitario
    this_cMoedas                  = ""  && Moedas    CHAR(3)  - moeda do valor
    this_nTotas                   = 0   && Totas     N(15,2)  - valor total da linha
    this_dDatas                   = {}  && Datas     D        - data da movimentacao
    this_cDcunis                  = ""  && Dcunis    CHAR(20) - descricao da unidade da quantidade (SigCdUni.Dunis)
    this_cDcunips                 = ""  && Dcunips   CHAR(20) - descricao da unidade do peso (SigCdUni.Dunis)

    *--------------------------------------------------------------------------
    * ESTADO DO DIALOGO
    *--------------------------------------------------------------------------
    this_nTotalRegistrosTotPrev   = 0   && RECCOUNT de cursor_4c_TotalPorData apos a carga
    this_nTotalRegistrosTotal     = 0   && RECCOUNT de cursor_4c_TotalGeral apos a carga
    this_nTotalRegistrosItens     = 0   && RECCOUNT de cursor_4c_ItensPendentes apos a carga

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * DODEFAULT() sem parametro: nao instancia DataAccess, porque este
    * dialogo nao grava em tabela remota (ver cabecalho). this_cTabela e
    * this_cCampoChave apontam para a tabela de contexto/consulta
    * (SigMvOrc), usada para montar as duas grades.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigMvOrc"
        THIS.this_cCampoChave = "Citens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalPorData - Modo "P" (Total Previsao), 1a grade (grdTotPrev).
    * Replica "Select Datas, Sum(Valos) ..., Group By Datas" do Init legado,
    * agregando LOCALMENTE (sem gnConnHandle) sobre o cursor de movimentacao
    * (equivalente a crSigMvOrp) que o Form ja recebe populado do form pai.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalPorData(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalPorData)
                USE IN (THIS.this_cCursorTotalPorData)
            ENDIF

            SELECT Datas, SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                GROUP BY Datas ;
                INTO CURSOR (THIS.this_cCursorTotalPorData) READWRITE

            SELECT (THIS.this_cCursorTotalPorData)
            GO TOP

            THIS.this_nTotalRegistrosTotPrev = RECCOUNT(THIS.this_cCursorTotalPorData)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total por data: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotaisGerais - Modo "P", totalizadores getTotPrev/getTotReal/
    * getTotDif. Replica "Select Sum(Valos), Sum(VlBaixas), Sum(Valos-VlBaixas)
    * From crSigMvOrp" (sem Group By - uma unica linha) do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotaisGerais(par_cCursorOrigemOrp)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrp)
            THIS.this_cMensagemErro = "Cursor de movimenta" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrp
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TmpTotOrp2")
                USE IN cursor_4c_TmpTotOrp2
            ENDIF

            SELECT SUM(Valos) AS Valos, SUM(VlBaixas) AS VlBaixas, ;
                    SUM(Valos - VlBaixas) AS VlPends ;
                FROM (par_cCursorOrigemOrp) ;
                INTO CURSOR cursor_4c_TmpTotOrp2 READWRITE

            THIS.this_nTotalPrevisto  = TratarNulo(cursor_4c_TmpTotOrp2.Valos, 0)
            THIS.this_nTotalRealizado = TratarNulo(cursor_4c_TmpTotOrp2.VlBaixas, 0)
            THIS.this_nTotalDiferenca = TratarNulo(cursor_4c_TmpTotOrp2.VlPends, 0)

            USE IN cursor_4c_TmpTotOrp2

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os totais gerais: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTotalGeral - Modo "P", 2a grade (grdTotal). Replica
    * "Select Citens, Dpros, Sum(tota1s+tota2s+tota3s) ... Where cBlocos
    * In (...) Group By Citens, Dpros" do Init legado, sobre o cursor de
    * orcamento (equivalente a crSigMvOrc).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTotalGeral(par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cCursorOrigemOrc)
            THIS.this_cMensagemErro = "Cursor de or" + CHR(231) + "amento n" + ;
                CHR(227) + "o est" + CHR(225) + " aberto: " + par_cCursorOrigemOrc
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorTotalGeral)
                USE IN (THIS.this_cCursorTotalGeral)
            ENDIF

            SELECT Citens, Dpros, SUM(tota1s + tota2s + tota3s) AS Tota1s ;
                FROM (par_cCursorOrigemOrc) ;
                WHERE INLIST(cBlocos, "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "TOTALGERAL") ;
                GROUP BY Citens, Dpros ;
                INTO CURSOR (THIS.this_cCursorTotalGeral) READWRITE

            SELECT (THIS.this_cCursorTotalGeral)
            GO TOP

            THIS.this_nTotalRegistrosTotal = RECCOUNT(THIS.this_cCursorTotalGeral)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar o total geral: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoPrevisao - Orquestra o modo "P" (Total Previsao) completo:
    * as duas grades (grdTotPrev/grdTotal) e os 3 totalizadores.
    * par_cCursorOrigemOrp / par_cCursorOrigemOrc sao os aliases (ja abertos
    * pelo Form, recebidos do form pai) equivalentes a crSigMvOrp/crSigMvOrc.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoPrevisao(par_cCursorOrigemOrp, par_cCursorOrigemOrc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "P"
        THIS.this_cTituloDialogo = "Total Previs" + CHR(227) + "o"

        IF THIS.CarregarTotalPorData(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotaisGerais(par_cCursorOrigemOrp) AND ;
           THIS.CarregarTotalGeral(par_cCursorOrigemOrc)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarModoItensSubnivel - Modo "Itens Subnivel" (grdItem). Replica o
    * loop "Do While llAchou" do Init legado (Tiago - 14/04/2014 - SRCOM):
    * sobe a cadeia de subniveis que o item (par_nCodigoInicial) passou,
    * resolvendo Dopes via SigCdOpe.Ndopes e consultando SigMvItn/SigMvCab/
    * SigMvOrc/SigCdUni, ate o proximo nCodigos nao encontrar mais nenhum
    * item (ou falha de conexao).
    *
    * Aqui, diferente do modo "P" (que agrega cursores LOCAIS ja carregados),
    * cada passo da cadeia e uma consulta REMOTA via gnConnHandle - o legado
    * tambem faz assim (ThisForm.Parentform.ParentForm.poDataMgr.SqlExecute).
    *
    * par_cEmps substitui o "TprMvCab.Emps" do legado: o dump original le a
    * empresa de um cursor global (TprMvCab) aberto por um ancestral do form
    * pai que nao faz parte deste acervo isolado (SIGOPTOR e um dialogo
    * filho de um form de Orcamento/Pre-Custo nao migrado nesta tarefa). O
    * Form (Fase 3) deve repassar aqui a empresa do registro de origem (ex.:
    * o Emps do cursor de orcamento do form pai, ou
    * go_4c_Sistema.cCodEmpresa como fallback).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarModoItensSubnivel(par_nCodigoInicial, par_cCpros, par_cEmps)
        LOCAL loc_lSucesso, loc_lErroFatal, loc_nCodigo, loc_lAchou, ;
              loc_nDope, loc_nNume, loc_cDope, loc_cEDN, loc_cSQL, loc_nResultado

        loc_lSucesso   = .F.
        loc_lErroFatal = .F.

        THIS.this_cMensagemErro  = ""
        THIS.this_cModoExibicao  = "I"
        THIS.this_cTituloDialogo = "Itens Subn" + CHR(237) + "vel"
        THIS.this_nCodigoAtual   = par_nCodigoInicial
        THIS.this_cProdutoAtual  = par_cCpros

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED(THIS.this_cCursorItensPendentes)
                USE IN (THIS.this_cCursorItensPendentes)
            ENDIF

            SET NULL ON
            CREATE CURSOR (THIS.this_cCursorItensPendentes) ( ;
                DopeNums C(26), CPros C(14), Dpros C(65), Qtds N(9,3), Cunis C(3), ;
                Pesos N(9,3), CuniPs C(3), Fators N(8,3), Units N(15,6), Moedas C(3), ;
                Totas N(11,2), Datas D, Dcunis C(20), Dcunips C(20))
            SET NULL OFF
            INDEX ON Datas TAG Datas

            loc_nCodigo = par_nCodigoInicial
            loc_lAchou  = .T.

            DO WHILE loc_lAchou
                loc_nDope = VAL(LEFT(STR(loc_nCodigo, 10), 4))
                loc_nNume = VAL(RIGHT(STR(loc_nCodigo, 10), 6))

                IF USED("cursor_4c_OpeSubnTmp")
                    USE IN cursor_4c_OpeSubnTmp
                ENDIF
                loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (SigCdOpe)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_OpeSubnTmp") OR EOF("cursor_4c_OpeSubnTmp")
                    * Nao ha mais SigCdOpe correspondente - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                loc_cDope = cursor_4c_OpeSubnTmp.Dopes
                USE IN cursor_4c_OpeSubnTmp

                *-- SEM ALLTRIM nas partes: chave posicional de 29 caracteres
                *-- (Emps(3) + Dopes(20) + Str(Numes,6) = EmpDopNums - regra #42)
                loc_cEDN = PADR(NVL(par_cEmps, ""), 3) + loc_cDope + STR(loc_nNume, 6)

                IF USED("cursor_4c_MvPecSubnTmp")
                    USE IN cursor_4c_MvPecSubnTmp
                ENDIF

                loc_cSQL = "SELECT b.Datas, a.nCodigos, c.citens, c.cpros, c.dpros, c.qtds, " + ;
                    "c.cunis, c.pesos, c.cunips, c.fators, c.units, c.moedas, c.totas, " + ;
                    "d.Dunis AS Dcunis, e.Dunis AS Dcunips " + ;
                    "FROM SigMvItn a " + ;
                    "INNER JOIN SigMvCab b ON a.EmpDopNums = b.EmpDopNums " + ;
                    "INNER JOIN SigMvOrc c ON a.EmpDopNums = c.EmpDopNums AND a.Citens = c.Citens " + ;
                    "INNER JOIN SigCdUni d ON a.Cunis = d.Cunis " + ;
                    "INNER JOIN SigCdUni e ON a.Cunips = e.Cunis " + ;
                    "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEDN) + " " + ;
                    "AND a.Cpros = " + EscaparSQL(par_cCpros) + " " + ;
                    "ORDER BY c.Citens"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvPecSubnTmp")

                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor reinicializar o processo. (Itens do Subn" + CHR(237) + "vel)"
                    loc_lErroFatal = .T.
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                IF !USED("cursor_4c_MvPecSubnTmp") OR EOF("cursor_4c_MvPecSubnTmp")
                    * Nao ha mais item upstream - fim normal da cadeia
                    loc_lAchou = .F.
                    EXIT
                ENDIF

                INSERT INTO (THIS.this_cCursorItensPendentes) ( ;
                        DopeNums, CPros, Dpros, Qtds, Cunis, Pesos, CuniPs, Fators, ;
                        Units, Moedas, Totas, Datas, Dcunis, Dcunips) ;
                    VALUES ( ;
                        loc_cDope + STR(loc_nNume, 6), ;
                        cursor_4c_MvPecSubnTmp.cpros, ;
                        cursor_4c_MvPecSubnTmp.dpros, ;
                        cursor_4c_MvPecSubnTmp.qtds, ;
                        cursor_4c_MvPecSubnTmp.cunis, ;
                        cursor_4c_MvPecSubnTmp.pesos, ;
                        cursor_4c_MvPecSubnTmp.cunips, ;
                        cursor_4c_MvPecSubnTmp.fators, ;
                        cursor_4c_MvPecSubnTmp.units, ;
                        cursor_4c_MvPecSubnTmp.moedas, ;
                        cursor_4c_MvPecSubnTmp.totas, ;
                        cursor_4c_MvPecSubnTmp.datas, ;
                        cursor_4c_MvPecSubnTmp.dcunis, ;
                        cursor_4c_MvPecSubnTmp.dcunips)

                loc_nCodigo = cursor_4c_MvPecSubnTmp.nCodigos

                USE IN cursor_4c_MvPecSubnTmp
            ENDDO

            SELECT (THIS.this_cCursorItensPendentes)
            GO TOP

            THIS.this_nTotalRegistrosItens = RECCOUNT(THIS.this_cCursorItensPendentes)
            loc_lSucesso = !loc_lErroFatal

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao montar os itens do subn" + CHR(237) + "vel: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia a LINHA CORRENTE de qualquer uma das 3 grades
    * (identificada pelo alias recebido) para as properties "linha corrente"
    * declaradas na Fase 1. Dialogo e somente leitura (ver cabecalho do
    * arquivo) - usado so para inspecionar/auditar a linha ativa, nunca para
    * gravar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        DO CASE
        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorItensPendentes)
            THIS.this_cDopeNums = TratarNulo(DopeNums, "")
            THIS.this_cCPros    = TratarNulo(CPros, "")
            THIS.this_cDpros    = TratarNulo(Dpros, "")
            THIS.this_nQtds     = TratarNulo(Qtds, 0)
            THIS.this_cCunis    = TratarNulo(Cunis, "")
            THIS.this_nPesos    = TratarNulo(Pesos, 0)
            THIS.this_cCuniPs   = TratarNulo(CuniPs, "")
            THIS.this_nFators   = TratarNulo(Fators, 0)
            THIS.this_nUnits    = TratarNulo(Units, 0)
            THIS.this_cMoedas   = TratarNulo(Moedas, "")
            THIS.this_nTotas    = TratarNulo(Totas, 0)
            THIS.this_dDatas    = Datas
            THIS.this_cDcunis   = TratarNulo(Dcunis, "")
            THIS.this_cDcunips  = TratarNulo(Dcunips, "")

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalPorData)
            THIS.this_dDatasTotal = Datas
            THIS.this_nValos      = TratarNulo(Valos, 0)
            THIS.this_nVlBaixas   = TratarNulo(VlBaixas, 0)
            THIS.this_nVlPends    = TratarNulo(VlPends, 0)

        CASE UPPER(par_cAliasCursor) == UPPER(THIS.this_cCursorTotalGeral)
            THIS.this_cDprosTotal = TratarNulo(Dpros, "")
            THIS.this_nTota1s     = TratarNulo(Tota1s, 0)

        ENDCASE

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresGrade - Fecha os 3 cursores das grades. Replica o
    * PROCEDURE Release do SIGOPTOR legado (Use In crTmpTotOrp/crTmpTotOrp2/
    * TmpItePen) - o Form (Fase 3) chama isto no proprio Release/Destroy.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresGrade()
        IF USED(THIS.this_cCursorTotalPorData)
            USE IN (THIS.this_cCursorTotalPorData)
        ENDIF
        IF USED(THIS.this_cCursorTotalGeral)
            USE IN (THIS.this_cCursorTotalGeral)
        ENDIF
        IF USED(THIS.this_cCursorItensPendentes)
            USE IN (THIS.this_cCursorItensPendentes)
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave de CONTEXTO (nao de persistencia: este
    * dialogo e somente leitura, ver cabecalho do arquivo - Salvar/Excluir/
    * RegistrarAuditoria nunca sao chamados aqui). A sobrescrita existe so
    * para documentar qual seria a chave do item em exibicao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigoAtual)
    ENDPROC

ENDDEFINE

