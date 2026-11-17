# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigoporc.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (5195 linhas total):

*-- Linhas 20 a 41:
20: * botoes, campos de percentual) sao filhos DIRETOS do form. Este form
21: * migrado segue a mesma estrutura flat (excecao documentada em CLAUDE.md
22: * para o Gate da Fase 3 quando o legado nao tem PageFrame - nao inventar
23: * Page1/Page2 que o original nao possui; referencia: FormSigMvSbn.prg).
24: * O UNICO container do legado e cntSombra (faixa do cabecalho),
25: * reproduzido aqui como cnt_4c_Sombra.
26: *
27: * FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
28: * Init/InicializarForm, BO e o cabecalho).
29: *
30: * FASE 4/8 - GRADES E BOTOES DE LINHA: as DUAS grades do legado e os
31: * botoes que operam linha nelas, mais o funil de carga:
32: *   grdItem    -> grd_4c_Itens     (30 colunas) + cmd_4c_IncluirLinha /
33: *                                    cmd_4c_ExcluirLinha (btnIncluir/
34: *                                    btnExcluir do legado)
35: *   grdParcela -> grd_4c_Parcelas  (7 colunas)  + cmd_4c_IncluirParcela /
36: *                                    cmd_4c_ExcluirParcela (btnIncluirp/
37: *                                    btnExcluirp do legado)
38: *
39: * Cada grade tem o par Configurar<X> (so o que NAO depende de dado) +
40: * Vincular<X> (RecordSource/ControlSource sob USED, e depois deles
41: * Width/Header1.Caption) - separados porque atribuir RecordSource RESETA

*-- Linhas 47 a 65:
47: * FASE 5/8 - CAMPOS PRINCIPAIS (PARTE 1): os campos de percentual/calculo
48: * do topo (Say5/getPmargem, say4/getPtax2, say1/getPtaxa, Say3/getPTax1,
49: * say2/getPimposto, Say6/getPservico - migrados para
50: * lbl_4c_Margem/txt_4c_Margem, lbl_4c_Contingente/txt_4c_Contingente,
51: * lbl_4c_TaxaAdm/txt_4c_TaxaAdm, lbl_4c_BV/txt_4c_BV, lbl_4c_Imposto/
52: * txt_4c_Imposto, lbl_4c_ImpostoServico/txt_4c_ImpostoServico) + Shape4
53: * (shp_4c_Painel) + get_NewGrp/Say_NewGrp (txt_4c_NovoGrupo/
54: * lbl_4c_NovoGrupo, com o lookup de Grupo transcrito) + getDescritivo
55: * (edt_4c_DescritivoRodape) + TotalizarItn() (motor de calculo chamado
56: * pelos 5 campos editaveis).
57: *
58: * FASE 6/8 - CAMPOS RESTANTES E LOOKUPS (PARTE 2): getDpros/getDpro2s/
59: * btnProcura (busca textual na grade de itens, migrados para
60: * txt_4c_ProcuraDpros/edt_4c_ProcuraDpro2s/cmd_4c_Procurar) + imgProds
61: * (pre-visualizacao da foto do produto, migrado para img_4c_Produto,
62: * com zoom via ImgProdutoDblClick - SigOpZom nao migrado, fallback
63: * ShellExecute igual ao de Formsigprccp.FigJpgDblClick) + os lookups de
64: * CELULA de unidade (grdItem.Column4/Column6 - SigCdUni, compartilhando
65: * ValidarUnidadeGenerica) e de acabamento (grdItem.Column30 - SigCdAca).

*-- Linhas 93 a 102:
93: * orcamento (BO.CarregarItens/CarregarParcelas, chamadas em
94: * CarregarDados - ate aqui os cursores existiam mas ficavam sempre
95: * vazios), os botoes de acao do rodape (btnIteSub/btnTotItens/btnInsBlo/
96: * btnInsSub/btnCadPro/OK -> cmd_4c_IteSub/cmd_4c_TotItens/cmd_4c_InsBlo/
97: * cmd_4c_InsSub/cmd_4c_CadPro/obj_4c_OK) e a gravacao da grade inteira no
98: * SQL Server ao confirmar (BtnSalvarClick).
99: *
100: * DOIS GAPS DOCUMENTADOS (nao silenciosos - ver cabecalho de cada
101: * metodo):
102: *   - btnIteSub/btnTotItens abrem "SigOpTor", dialogo legado SEPARADO

*-- Linhas 296 a 311:
296: 				MsgErro("Erro ao criar sigoporcBO. VARTYPE retornou: " + ;
297: 					VARTYPE(THIS.this_oBusinessObject), "Formsigoporc.InicializarForm")
298: 			ELSE
299: 				*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+
300: 				*-- Alltrim(MascNum)+' - Itens'. Em validacao de UI / modo teste nao
301: 				*-- recalcula: o comparador confere contra o Caption ESTATICO do SCX
302: 				*-- ("Itens"), e Emps/Dopes/MascNum chegam vazios nesses modos (sem
303: 				*-- form pai nem conexao SQL) - recalcular so trocaria o texto fiel
304: 				*-- por outro tambem incorreto.
305: 				IF !loc_lModoValidacaoOuTeste
306: 					THIS.Caption = THIS.this_oBusinessObject.this_cCaption
307: 				ENDIF
308: 
309: 				IF !loc_lModoValidacaoOuTeste
310: 					THIS.this_oBusinessObject.CarregarConfiguracao()
311: 					IF THIS.this_oBusinessObject.this_nDigItens = 5

*-- Linhas 365 a 418:
365: 	* igual ao SCX legado.
366: 	*==========================================================================
367: 	PROTECTED PROCEDURE ConfigurarCabecalho()
368: 		LOCAL loc_oCnt
369: 
370: 		THIS.AddObject("cnt_4c_Sombra", "Container")
371: 		loc_oCnt = THIS.cnt_4c_Sombra
372: 		WITH loc_oCnt
373: 			.Top         = 0
374: 			.Left        = 0
375: 			.Width       = THIS.Width
376: 			.Height      = 80
377: 			.BorderWidth = 0
378: 			.BackColor   = RGB(100, 100, 100)
379: 			.Visible     = .T.
380: 		ENDWITH
381: 
382: 		loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
383: 		WITH loc_oCnt.lbl_4c_Sombra
384: 			.FontBold      = .T.
385: 			.FontName      = "Tahoma"
386: 			.FontSize      = 18
387: 			.FontUnderline = .F.
388: 			.WordWrap      = .T.
389: 			.Alignment     = 0
390: 			.BackStyle     = 0
391: 			.AutoSize      = .F.
392: 			.Caption       = THIS.Caption
393: 			.Height        = 40
394: 			.Left          = 10
395: 			.Top           = 18
396: 			.Width         = 769
397: 			.ForeColor     = RGB(0, 0, 0)
398: 			.Visible       = .T.
399: 		ENDWITH
400: 
401: 		loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
402: 		WITH loc_oCnt.lbl_4c_Titulo
403: 			.FontBold  = .T.
404: 			.FontName  = "Tahoma"
405: 			.FontSize  = 18
406: 			.WordWrap  = .T.
407: 			.Alignment = 0
408: 			.BackStyle = 0
409: 			.AutoSize  = .F.
410: 			.Caption   = THIS.Caption
411: 			.Height    = 46
412: 			.Left      = 10
413: 			.Top       = 17
414: 			.Width     = 769
415: 			.ForeColor = RGB(255, 255, 255)
416: 			.Visible   = .T.
417: 		ENDWITH
418: 	ENDPROC

*-- Linhas 544 a 553:
544: 		THIS.grd_4c_Itens.ColumnCount  = 30
545: 
546: 		WITH THIS.grd_4c_Itens
547: 			.Top          = 218
548: 			.Left         = 5
549: 			.Width        = 989
550: 			.Height       = 258
551: 			.FontSize     = 8
552: 			.HeaderHeight = 16
553: 			.RowHeight    = 16

*-- Linhas 584 a 593:
584: 			.Column2.Header1.Alignment = 2
585: 			.Column2.Header1.FontSize  = 8
586: 			.Column2.AddObject("edt_4c_Descritivo", "EditBox")
587: 			.Column2.edt_4c_Descritivo.Top          = 42
588: 			.Column2.edt_4c_Descritivo.Left         = 41
589: 			.Column2.edt_4c_Descritivo.FontName     = "Arial"
590: 			.Column2.edt_4c_Descritivo.FontSize     = 8
591: 			.Column2.edt_4c_Descritivo.BorderStyle  = 0
592: 			.Column2.edt_4c_Descritivo.SpecialEffect = 1
593: 			.Column2.CurrentControl = "edt_4c_Descritivo"

*-- Linhas 755 a 764:
755: 			.Column16.Header1.Alignment = 2
756: 			.Column16.Header1.FontSize  = 8
757: 			.Column16.AddObject("edt_4c_Observacao", "EditBox")
758: 			.Column16.edt_4c_Observacao.Top          = 42
759: 			.Column16.edt_4c_Observacao.Left         = 17
760: 			.Column16.edt_4c_Observacao.FontName     = "Arial"
761: 			.Column16.edt_4c_Observacao.FontSize     = 8
762: 			.Column16.edt_4c_Observacao.BorderStyle  = 0
763: 			.Column16.edt_4c_Observacao.SpecialEffect = 1
764: 			.Column16.CurrentControl = "edt_4c_Observacao"

*-- Linhas 878 a 915:
878: 			.Column26.Text1.BackColor   = RGB(255, 255, 255)
879: 			.Column26.ReadOnly = loc_lSoLeitura
880: 
881: 			*-- Column27 (S/Servico - servicos, checkbox) - oculta por padrao
882: 			*-- (so aparece em modo P&G/Criacao - regra deferida, ver cabecalho)
883: 			.Column27.AddObject("chk_4c_Servico", "CheckBox")
884: 			.Column27.chk_4c_Servico.Caption = ""
885: 			.Column27.CurrentControl   = "chk_4c_Servico"
886: 			.Column27.ColumnOrder      = 23
887: 			.Column27.FontSize         = 8
888: 			.Column27.Header1.Alignment = 2
889: 			.Column27.Header1.FontSize = 8
890: 			.Column27.Header1.ToolTipText = "Servi" + CHR(231) + "o"
891: 			.Column27.Sparse   = .F.
892: 			.Column27.Visible  = .F.
893: 			.Column27.ReadOnly = loc_lSoLeitura
894: 
895: 			*-- Column28 (D/Debito - debitos, checkbox) - oculta por padrao
896: 			.Column28.AddObject("chk_4c_Debito", "CheckBox")
897: 			.Column28.chk_4c_Debito.Caption = ""
898: 			.Column28.CurrentControl   = "chk_4c_Debito"
899: 			.Column28.ColumnOrder      = 24
900: 			.Column28.FontSize         = 8
901: 			.Column28.Header1.Alignment = 2
902: 			.Column28.Header1.FontSize = 8
903: 			.Column28.Header1.ToolTipText = "D" + CHR(233) + "bito"
904: 			.Column28.Sparse   = .F.
905: 			.Column28.Visible  = .F.
906: 			.Column28.ReadOnly = loc_lSoLeitura
907: 
908: 			*-- Column29 (Fee/Taxa - taxas, checkbox)
909: 			.Column29.AddObject("chk_4c_Fee", "CheckBox")
910: 			.Column29.chk_4c_Fee.Caption = ""
911: 			.Column29.CurrentControl   = "chk_4c_Fee"
912: 			.Column29.ColumnOrder      = 11
913: 			.Column29.FontSize         = 8
914: 			.Column29.Header1.FontSize = 8
915: 			.Column29.Sparse   = .F.

*-- Linhas 1577 a 1646:
1577: 			*-- Width/Header1.Caption SEMPRE depois do bind (RecordSource reseta
1578: 			*-- os dois para 90 / "Column<N>"). Transcritos do dump do legado.
1579: 			.Column1.Width           = 290
1580: 			.Column1.Header1.Caption = "Item"
1581: 			.Column2.Width           = 290
1582: 			.Column2.Header1.Caption = "Descritivo"
1583: 			.Column3.Width           = 122
1584: 			.Column3.Header1.Caption = "Quantidade"
1585: 			.Column4.Width           = 150
1586: 			.Column4.Header1.Caption = "Unidade"
1587: 			.Column5.Width           = 45
1588: 			.Column5.Header1.Caption = "Per" + CHR(237) + "odo"
1589: 			.Column6.Width           = 150
1590: 			.Column6.Header1.Caption = "Unidade"
1591: 			.Column7.Width           = 45
1592: 			.Column7.Header1.Caption = "Turno"
1593: 			.Column8.Width           = 122
1594: 			.Column8.Header1.Caption = "Unit" + CHR(225) + "rio"
1595: 			.Column9.Width           = 122
1596: 			.Column9.Header1.Caption = "Total"
1597: 			.Column10.Width           = 122
1598: 			.Column10.Header1.Caption = "Total NF SRCOM"
1599: 			.Column11.Width           = 122
1600: 			.Column11.Header1.Caption = "Total SRCOM Custos Internos"
1601: 			.Column12.Width           = 122
1602: 			.Column12.Header1.Caption = "Total Fornecedor"
1603: 			.Column13.Width           = 122
1604: 			.Column13.Header1.Caption = "ICMS"
1605: 			.Column14.Width           = 122
1606: 			.Column14.Header1.Caption = "Rouanet"
1607: 			.Column15.Width           = 122
1608: 			.Column15.Header1.Caption = "Outras"
1609: 			.Column16.Width           = 290
1610: 			.Column16.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
1611: 			.Column17.Width           = 122
1612: 			.Column17.Header1.Caption = "Real SRCOM Custos Internos"
1613: 			.Column18.Width           = 122
1614: 			.Column18.Header1.Caption = "Real Fornecedor"
1615: 			.Column19.Width           = 122
1616: 			.Column19.Header1.Caption = "Saldo Real SRCOM Custos Internos"
1617: 			.Column20.Width           = 122
1618: 			.Column20.Header1.Caption = "Saldo Real Fornecedor"
1619: 			*-- Column21: o dump do legado NAO declara Width (so no ramo P&G, com
1620: 			*-- Width = 0). Fixado no default 90 do VFP para que um rebind nao
1621: 			*-- altere a largura que a tela ja mostrava.
1622: 			.Column21.Width           = 90
1623: 			.Column21.Header1.Caption = "Nota"
1624: 			.Column22.Width           = 52
1625: 			.Column22.Header1.Caption = "%"
1626: 			.Column23.Width           = 52
1627: 			.Column23.Header1.Caption = "%"
1628: 			.Column24.Width           = 52
1629: 			.Column24.Header1.Caption = "%"
1630: 			.Column25.Width           = 52
1631: 			.Column25.Header1.Caption = "%"
1632: 			.Column26.Width           = 52
1633: 			.Column26.Header1.Caption = "%"
1634: 			.Column27.Width           = 17
1635: 			.Column27.Header1.Caption = "S"
1636: 			.Column28.Width           = 17
1637: 			.Column28.Header1.Caption = "D"
1638: 			.Column29.Width           = 22
1639: 			.Column29.Header1.Caption = "Fee"
1640: 			.Column30.Width           = 150
1641: 			.Column30.Header1.Caption = "Acabamento"
1642: 		ENDWITH
1643: 
1644: 		*-- Reinstala as celulas de LOOKUP depois do bind: atribuir
1645: 		*-- RecordSource reseta Column.CurrentControl/Sparse/ReadOnly junto
1646: 		*-- com Width/Header1.Caption, e sem CurrentControl a coluna volta a

*-- Linhas 1789 a 1798:
1789: 		THIS.grd_4c_Parcelas.ColumnCount = 7
1790: 
1791: 		WITH THIS.grd_4c_Parcelas
1792: 			.Top          = 504
1793: 			.Left         = 6
1794: 			.Width        = 946
1795: 			.Height       = 92
1796: 			.FontName     = "Tahoma"
1797: 			.FontSize     = 8
1798: 			.ForeColor    = RGB(90, 90, 90)

*-- Linhas 1901 a 1921:
1901: 			*-- dump (PROPRIEDADES DE: SIGOPORC.grdParcela + o Header1 de cada
1902: 			*-- Column no layout do legado).
1903: 			.Column1.Width           = 70
1904: 			.Column1.Header1.Caption = "%"
1905: 			.Column2.Width           = 70
1906: 			.Column2.Header1.Caption = "Data"
1907: 			.Column3.Width           = 122
1908: 			.Column3.Header1.Caption = "Previsto"
1909: 			.Column4.Width           = 80
1910: 			.Column4.Header1.Caption = "Fornecedor"
1911: 			.Column5.Width           = 122
1912: 			.Column5.Header1.Caption = "Realizado"
1913: 			.Column6.Width           = 290
1914: 			.Column6.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1915: 			.Column7.Width           = 122
1916: 			.Column7.Header1.Caption = "Cr" + CHR(233) + "dito"
1917: 		ENDWITH
1918: 	ENDPROC
1919: 
1920: 	*==========================================================================
1921: 	* ConfigurarBotoesParcelas - btnIncluirp/btnExcluirp do legado (fwbtnp,

*-- Linhas 1932 a 1974:
1932: 	* When ligado por BINDEVENT nao bloquearia nada.
1933: 	*==========================================================================
1934: 	PROTECTED PROCEDURE ConfigurarBotoesParcelas()
1935: 		THIS.AddObject("cmd_4c_IncluirParcela", "CommandButton")
1936: 		WITH THIS.cmd_4c_IncluirParcela
1937: 			.Top             = 516
1938: 			.Left            = 954
1939: 			.Height          = 40
1940: 			.Width           = 40
1941: 			.Caption         = ""
1942: 			.ToolTipText     = "Inserir linha"
1943: 			.ForeColor       = RGB(90, 90, 90)
1944: 			.BackColor       = RGB(255, 255, 255)
1945: 			.Themes          = .T.
1946: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1947: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1948: 			.TabIndex        = 26
1949: 			.Visible         = .T.
1950: 		ENDWITH
1951: 		BINDEVENT(THIS.cmd_4c_IncluirParcela, "Click", THIS, "BtnIncluirParcelaClick")
1952: 
1953: 		THIS.AddObject("cmd_4c_ExcluirParcela", "CommandButton")
1954: 		WITH THIS.cmd_4c_ExcluirParcela
1955: 			.Top             = 556
1956: 			.Left            = 954
1957: 			.Height          = 40
1958: 			.Width           = 40
1959: 			.Caption         = ""
1960: 			.ToolTipText     = "Exclui linha"
1961: 			.ForeColor       = RGB(90, 90, 90)
1962: 			.BackColor       = RGB(255, 255, 255)
1963: 			.Themes          = .T.
1964: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1965: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1966: 			.TabIndex        = 28
1967: 			.Visible         = .T.
1968: 		ENDWITH
1969: 		BINDEVENT(THIS.cmd_4c_ExcluirParcela, "Click", THIS, "BtnExcluirParcelaClick")
1970: 	ENDPROC
1971: 
1972: 	*==========================================================================
1973: 	* BtnIncluirParcelaClick - legado SIGOPORC.btnIncluirp.Click. Insere uma
1974: 	* parcela/previsao em branco para o ITEM CORRENTE da grade de itens.

*-- Linhas 2072 a 2080:
2072: 	* ConfigurarCamposPercentuais - Shape4 (moldura decorativa) + os 6
2073: 	* campos de percentual do cabecalho (say5/getPmargem .. Say6/
2074: 	* getPservico do legado). TRANSCRITOS do dump (bloco "PROPRIEDADES
2075: 	* DE: SIGOPORC.<nome>"), pareados por proximidade de Top (label.Top =
2076: 	* textbox.Top + 3, conferido um a um):
2077: 	*
2078: 	*   Say5 "Margem :...%"            (96)  <-> getPmargem      (93)  - SEM ControlSource; When sempre .F. (resultado calculado por TotalizarItn, nunca digitado)
2079: 	*   say4 "Contingente :...%"       (116) <-> getPtax2        (113) - ControlSource = TprMvCab.ptax2s (Perc1s)
2080: 	*   say1 "Ta\<xa Adm. :...%"       (136) <-> getPtaxa        (133) - ControlSource = TprMvCab.descs  (Perc2s)

*-- Linhas 2108 a 2146:
2108: 
2109: 		THIS.AddObject("shp_4c_Painel", "Shape")
2110: 		WITH THIS.shp_4c_Painel
2111: 			.Top          = 106
2112: 			.Left         = 577
2113: 			.Height       = 93
2114: 			.Width        = 163
2115: 			.BackStyle    = 0
2116: 			.BorderWidth  = 2
2117: 			.SpecialEffect = 0
2118: 			.BorderColor  = RGB(90, 90, 90)
2119: 			.Visible      = .T.
2120: 		ENDWITH
2121: 
2122: 		*-- Margem (resultado calculado - sempre desabilitado, destaque amarelo)
2123: 		THIS.AddObject("lbl_4c_Margem", "Label")
2124: 		WITH THIS.lbl_4c_Margem
2125: 			.FontName  = "Tahoma"
2126: 			.FontSize  = 8
2127: 			.Alignment = 1
2128: 			.AutoSize  = .F.
2129: 			.Caption   = "Margem :                     %"
2130: 			.Top       = 96
2131: 			.Left      = 261
2132: 			.Width     = 192
2133: 			.Height    = 15
2134: 			.ForeColor = RGB(90, 90, 90)
2135: 			.Visible   = .T.
2136: 		ENDWITH
2137: 
2138: 		THIS.AddObject("txt_4c_Margem", "TextBox")
2139: 		WITH THIS.txt_4c_Margem
2140: 			.Top           = 93
2141: 			.Left          = 380
2142: 			.Width         = 59
2143: 			.Height        = 21
2144: 			.Alignment     = 3
2145: 			.FontBold      = .T.
2146: 			.Format        = "K"

*-- Linhas 2157 a 2183:
2157: 		ENDWITH
2158: 
2159: 		*-- Contingente (Perc1s - TprMvCab.Ptax2s)
2160: 		THIS.AddObject("lbl_4c_Contingente", "Label")
2161: 		WITH THIS.lbl_4c_Contingente
2162: 			.FontName  = "Tahoma"
2163: 			.FontSize  = 8
2164: 			.Alignment = 1
2165: 			.AutoSize  = .F.
2166: 			.Caption   = "Contingente :                     %"
2167: 			.Top       = 116
2168: 			.Left      = 261
2169: 			.Width     = 192
2170: 			.Height    = 15
2171: 			.ForeColor = RGB(90, 90, 90)
2172: 			.Visible   = .T.
2173: 		ENDWITH
2174: 
2175: 		THIS.AddObject("txt_4c_Contingente", "TextBox")
2176: 		WITH THIS.txt_4c_Contingente
2177: 			.Top           = 113
2178: 			.Left          = 380
2179: 			.Width         = 59
2180: 			.Height        = 21
2181: 			.Alignment     = 3
2182: 			.Format        = "K"
2183: 			.InputMask     = "999.99"

*-- Linhas 2192 a 2218:
2192: 		BINDEVENT(THIS.txt_4c_Contingente, "KeyPress", THIS, "TxtContingenteKeyPress")
2193: 
2194: 		*-- Taxa Adm. (Perc2s - TprMvCab.Descs)
2195: 		THIS.AddObject("lbl_4c_TaxaAdm", "Label")
2196: 		WITH THIS.lbl_4c_TaxaAdm
2197: 			.FontName  = "Tahoma"
2198: 			.FontSize  = 8
2199: 			.Alignment = 1
2200: 			.AutoSize  = .F.
2201: 			.Caption   = "Ta\<xa Adm. :                     %"
2202: 			.Top       = 136
2203: 			.Left      = 261
2204: 			.Width     = 192
2205: 			.Height    = 15
2206: 			.ForeColor = RGB(90, 90, 90)
2207: 			.Visible   = .T.
2208: 		ENDWITH
2209: 
2210: 		THIS.AddObject("txt_4c_TaxaAdm", "TextBox")
2211: 		WITH THIS.txt_4c_TaxaAdm
2212: 			.Top           = 133
2213: 			.Left          = 380
2214: 			.Width         = 59
2215: 			.Height        = 21
2216: 			.Alignment     = 3
2217: 			.Format        = "K"
2218: 			.InputMask     = "999.99"

*-- Linhas 2227 a 2253:
2227: 		BINDEVENT(THIS.txt_4c_TaxaAdm, "KeyPress", THIS, "TxtTaxaAdmKeyPress")
2228: 
2229: 		*-- BV (Perc3s - TprMvCab.Ptax1s)
2230: 		THIS.AddObject("lbl_4c_BV", "Label")
2231: 		WITH THIS.lbl_4c_BV
2232: 			.FontName  = "Tahoma"
2233: 			.FontSize  = 8
2234: 			.Alignment = 1
2235: 			.AutoSize  = .F.
2236: 			.Caption   = "BV :                     %"
2237: 			.Top       = 156
2238: 			.Left      = 261
2239: 			.Width     = 192
2240: 			.Height    = 15
2241: 			.ForeColor = RGB(90, 90, 90)
2242: 			.Visible   = .T.
2243: 		ENDWITH
2244: 
2245: 		THIS.AddObject("txt_4c_BV", "TextBox")
2246: 		WITH THIS.txt_4c_BV
2247: 			.Top           = 153
2248: 			.Left          = 380
2249: 			.Width         = 59
2250: 			.Height        = 21
2251: 			.Alignment     = 3
2252: 			.Format        = "K"
2253: 			.InputMask     = "999.99"

*-- Linhas 2262 a 2288:
2262: 		BINDEVENT(THIS.txt_4c_BV, "KeyPress", THIS, "TxtBVKeyPress")
2263: 
2264: 		*-- Imposto cheio (Perc4s quando item NAO e servico - TprMvCab.Acres)
2265: 		THIS.AddObject("lbl_4c_Imposto", "Label")
2266: 		WITH THIS.lbl_4c_Imposto
2267: 			.FontName  = "Tahoma"
2268: 			.FontSize  = 8
2269: 			.Alignment = 1
2270: 			.AutoSize  = .F.
2271: 			.Caption   = "Im\<posto :                     %"
2272: 			.Top       = 176
2273: 			.Left      = 261
2274: 			.Width     = 192
2275: 			.Height    = 15
2276: 			.ForeColor = RGB(90, 90, 90)
2277: 			.Visible   = .T.
2278: 		ENDWITH
2279: 
2280: 		THIS.AddObject("txt_4c_Imposto", "TextBox")
2281: 		WITH THIS.txt_4c_Imposto
2282: 			.Top           = 173
2283: 			.Left          = 380
2284: 			.Width         = 59
2285: 			.Height        = 21
2286: 			.Alignment     = 3
2287: 			.Format        = "K"
2288: 			.InputMask     = "999.99"

*-- Linhas 2297 a 2323:
2297: 		BINDEVENT(THIS.txt_4c_Imposto, "KeyPress", THIS, "TxtImpostoKeyPress")
2298: 
2299: 		*-- Imposto sem ISS (Perc4s quando item E servico - TprMvCab.Ptax3s)
2300: 		THIS.AddObject("lbl_4c_ImpostoServico", "Label")
2301: 		WITH THIS.lbl_4c_ImpostoServico
2302: 			.FontName  = "Tahoma"
2303: 			.FontSize  = 8
2304: 			.Alignment = 1
2305: 			.AutoSize  = .F.
2306: 			.Caption   = "Imposto sem ISS :                     %"
2307: 			.Top       = 196
2308: 			.Left      = 260
2309: 			.Width     = 192
2310: 			.Height    = 15
2311: 			.ForeColor = RGB(90, 90, 90)
2312: 			.Visible   = .T.
2313: 		ENDWITH
2314: 
2315: 		THIS.AddObject("txt_4c_ImpostoServico", "TextBox")
2316: 		WITH THIS.txt_4c_ImpostoServico
2317: 			.Top           = 193
2318: 			.Left          = 380
2319: 			.Width         = 59
2320: 			.Height        = 21
2321: 			.Alignment     = 3
2322: 			.Format        = "K"
2323: 			.InputMask     = "999.9999"

*-- Linhas 2754 a 2778:
2754: 		LOCAL loc_lPodeEditar
2755: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
2756: 
2757: 		THIS.AddObject("lbl_4c_NovoGrupo", "Label")
2758: 		WITH THIS.lbl_4c_NovoGrupo
2759: 			.FontName  = "Tahoma"
2760: 			.FontSize  = 8
2761: 			.Caption   = "\<Grupo"
2762: 			.Top       = 129
2763: 			.Left      = 499
2764: 			.Width     = 31
2765: 			.Height    = 15
2766: 			.ForeColor = RGB(90, 90, 90)
2767: 			.Visible   = .T.
2768: 		ENDWITH
2769: 
2770: 		THIS.AddObject("txt_4c_NovoGrupo", "TextBox")
2771: 		WITH THIS.txt_4c_NovoGrupo
2772: 			.Top           = 144
2773: 			.Left          = 495
2774: 			.Width         = 37
2775: 			.Height        = 23
2776: 			.FontBold      = .T.
2777: 			.MaxLength     = 3
2778: 			.SpecialEffect = 1

*-- Linhas 2886 a 2895:
2886: 	PROTECTED PROCEDURE ConfigurarCampoBusca()
2887: 		THIS.AddObject("txt_4c_ProcuraDpros", "TextBox")
2888: 		WITH THIS.txt_4c_ProcuraDpros
2889: 			.Top           = 481
2890: 			.Left          = 16
2891: 			.Width         = 290
2892: 			.Height        = 21
2893: 			.FontSize      = 8
2894: 			.Alignment     = 3
2895: 			.Format        = "K"

*-- Linhas 2906 a 2915:
2906: 
2907: 		THIS.AddObject("edt_4c_ProcuraDpro2s", "EditBox")
2908: 		WITH THIS.edt_4c_ProcuraDpro2s
2909: 			.Top           = 481
2910: 			.Left          = 307
2911: 			.Width         = 290
2912: 			.Height        = 21
2913: 			.FontSize      = 8
2914: 			.SpecialEffect = 1
2915: 			.ForeColor     = RGB(0, 0, 0)

*-- Linhas 2921 a 2942:
2921: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "KeyPress", THIS, "ProcuraDpro2sKeyPress")
2922: 		BINDEVENT(THIS.edt_4c_ProcuraDpro2s, "LostFocus", THIS, "ProcuraDpro2sLostFocus")
2923: 
2924: 		THIS.AddObject("cmd_4c_Procurar", "CommandButton")
2925: 		WITH THIS.cmd_4c_Procurar
2926: 			.Top             = 481
2927: 			.Left            = 600
2928: 			.Height          = 21
2929: 			.Width           = 40
2930: 			.Caption         = ""
2931: 			.ToolTipText     = "Procurar Item"
2932: 			.Picture         = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2933: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_lupa_16.jpg"
2934: 			.Themes          = .T.
2935: 			.Visible         = .T.
2936: 		ENDWITH
2937: 		BINDEVENT(THIS.cmd_4c_Procurar, "Click", THIS, "BtnProcurarClick")
2938: 	ENDPROC
2939: 
2940: 	*==========================================================================
2941: 	* ProcuraDprosKeyPress / ProcuraDpro2sKeyPress - legado SIGOPORC.getDpros/
2942: 	* getDpro2s.Valid (disparado so com this_lProcura = .T., porque fora

*-- Linhas 2994 a 3008:
2994: 	*==========================================================================
2995: 	PROCEDURE ProcuraDprosLostFocus()
2996: 		IF !EMPTY(THIS.txt_4c_ProcuraDpros.Value)
2997: 			THIS.cmd_4c_Procurar.SetFocus()
2998: 		ENDIF
2999: 	ENDPROC
3000: 
3001: 	PROCEDURE ProcuraDpro2sLostFocus()
3002: 		IF !EMPTY(THIS.edt_4c_ProcuraDpro2s.Value)
3003: 			THIS.cmd_4c_Procurar.SetFocus()
3004: 		ENDIF
3005: 	ENDPROC
3006: 
3007: 	*==========================================================================
3008: 	* BtnProcurarClick - legado SIGOPORC.btnProcura.Click. Botao de DUAS

*-- Linhas 3071 a 3080:
3071: 	PROTECTED PROCEDURE ConfigurarImagemProduto()
3072: 		THIS.AddObject("img_4c_Produto", "Image")
3073: 		WITH THIS.img_4c_Produto
3074: 			.Top         = 108
3075: 			.Left        = 579
3076: 			.Width       = 159
3077: 			.Height      = 89
3078: 			.Stretch     = 1
3079: 			.ToolTipText = "Imagem do Produto [Duplo Click Para Zoom]"
3080: 			.Picture     = ""

*-- Linhas 3182 a 3191:
3182: 	PROTECTED PROCEDURE ConfigurarDescritivoRodape()
3183: 		THIS.AddObject("edt_4c_DescritivoRodape", "EditBox")
3184: 		WITH THIS.edt_4c_DescritivoRodape
3185: 			.Top           = 481
3186: 			.Left          = 5
3187: 			.Width         = 989
3188: 			.Height        = 115
3189: 			.FontSize      = 8
3190: 			.SpecialEffect = 1
3191: 			.ForeColor     = RGB(0, 0, 0)

*-- Linhas 3214 a 3224:
3214: 	* ficavam VISIVEIS em modo Criacao (onde o legado os esconde), e as
3215: 	* duas legendas que o P&G troca ("Lucro"/"Imposto Cheio") nunca eram
3216: 	* aplicadas. Mapa label->objeto do legado, conferido no dump:
3217: 	*   say5 -> lbl_4c_Margem          say4 -> lbl_4c_Contingente
3218: 	*   say1 -> lbl_4c_TaxaAdm         say3 -> lbl_4c_BV
3219: 	*   say2 -> lbl_4c_Imposto         say6 -> lbl_4c_ImpostoServico
3220: 	*
3221: 	* DESVIO DOCUMENTADO (geometria do ramo P&G): o legado faz
3222: 	* "grdItem.Height = 444" junto com "getDpros/getDpro2s/btnProcura.Top
3223: 	* = 570". Os dois numeros sao INCOMPATIVEIS entre si - com grdItem.Top
3224: 	* = 218, a altura 444 leva a grade ate 662, ou seja a grade cobriria a

*-- Linhas 3253 a 3325:
3253: 		loc_lMostraParcelas = !loc_lModoCriacao AND !loc_lPG
3254: 
3255: 		*-- Pares label/campo dos percentuais
3256: 		THIS.lbl_4c_Margem.Visible         = loc_lPercSoPG
3257: 		THIS.txt_4c_Margem.Visible         = loc_lPercSoPG
3258: 		THIS.lbl_4c_Contingente.Visible    = loc_lPercSoPG
3259: 		THIS.txt_4c_Contingente.Visible    = loc_lPercSoPG
3260: 		THIS.lbl_4c_BV.Visible             = loc_lPercSoPG
3261: 		THIS.txt_4c_BV.Visible             = loc_lPercSoPG
3262: 		THIS.lbl_4c_ImpostoServico.Visible = loc_lPercSoPG
3263: 		THIS.txt_4c_ImpostoServico.Visible = loc_lPercSoPG
3264: 
3265: 		THIS.lbl_4c_TaxaAdm.Visible        = loc_lMostraPerc
3266: 		THIS.txt_4c_TaxaAdm.Visible        = loc_lMostraPerc
3267: 		THIS.lbl_4c_Imposto.Visible        = loc_lMostraPerc
3268: 		THIS.txt_4c_Imposto.Visible        = loc_lMostraPerc
3269: 
3270: 		*-- Legendas que o ramo P&G troca (say1/say2 do legado)
3271: 		IF loc_lPG
3272: 			THIS.lbl_4c_TaxaAdm.Caption = "Lucro :                %"
3273: 			THIS.lbl_4c_Imposto.Caption = "Imposto Cheio :                %"
3274: 		ELSE
3275: 			THIS.lbl_4c_TaxaAdm.Caption = "Ta\<xa Adm. :                     %"
3276: 			THIS.lbl_4c_Imposto.Caption = "Im\<posto :                     %"
3277: 		ENDIF
3278: 
3279: 		*-- Grade de parcelas e seus botoes
3280: 		THIS.grd_4c_Parcelas.Visible       = loc_lMostraParcelas
3281: 		THIS.grd_4c_Parcelas.Enabled       = loc_lMostraParcelas
3282: 		THIS.cmd_4c_IncluirParcela.Visible = loc_lMostraParcelas
3283: 		THIS.cmd_4c_ExcluirParcela.Visible = loc_lMostraParcelas
3284: 
3285: 		*-- Botoes do rodape que o modo Criacao esconde
3286: 		THIS.cmd_4c_TotItens.Visible = !loc_lModoCriacao
3287: 		THIS.cmd_4c_IteSub.Visible   = !loc_lModoCriacao
3288: 
3289: 		IF loc_lModoCriacao
3290: 			*-- Criacao: o descritivo do rodape entra ligado ao item corrente
3291: 			*-- (legado: getDescritivo.ControlSource = [crSigMvOrc.Dpro2s]) e
3292: 			*-- a linha de busca sai inteira.
3293: 			THIS.edt_4c_DescritivoRodape.Visible = .T.
3294: 			IF USED(loc_cItens)
3295: 				THIS.edt_4c_DescritivoRodape.ControlSource = loc_cItens + ".dpro2s"
3296: 			ENDIF
3297: 
3298: 			THIS.txt_4c_ProcuraDpros.Visible  = .F.
3299: 			THIS.edt_4c_ProcuraDpro2s.Visible = .F.
3300: 			THIS.cmd_4c_Procurar.Visible      = .F.
3301: 		ELSE
3302: 			THIS.edt_4c_DescritivoRodape.Visible = .F.
3303: 
3304: 			THIS.txt_4c_ProcuraDpros.Visible  = .T.
3305: 			THIS.edt_4c_ProcuraDpro2s.Visible = .T.
3306: 			THIS.cmd_4c_Procurar.Visible      = .T.
3307: 
3308: 			*-- Geometria do ramo P&G (ver DESVIO DOCUMENTADO no cabecalho):
3309: 			*-- sem a grade de parcelas, a grade de itens cresce ate a linha
3310: 			*-- de busca, que desce para o rodape.
3311: 			IF loc_lPG
3312: 				THIS.grd_4c_Itens.Height      = 350
3313: 				THIS.txt_4c_ProcuraDpros.Top  = 570
3314: 				THIS.edt_4c_ProcuraDpro2s.Top = 570
3315: 				THIS.cmd_4c_Procurar.Top      = 570
3316: 			ELSE
3317: 				THIS.grd_4c_Itens.Height      = 258
3318: 				THIS.txt_4c_ProcuraDpros.Top  = 481
3319: 				THIS.edt_4c_ProcuraDpro2s.Top = 481
3320: 				THIS.cmd_4c_Procurar.Top      = 481
3321: 			ENDIF
3322: 		ENDIF
3323: 
3324: 		*-- Quem fica EDITAVEL (os "When" do legado) e assunto de
3325: 		*-- HabilitarCampos/AjustarBotoesPorModo - chamados aqui para o

*-- Linhas 3487 a 3536:
3487: 	ENDPROC
3488: 
3489: 	*==========================================================================
3490: 	* AtualizarEstadoCadastroProduto - Habilita/desabilita cmd_4c_CadPro
3491: 	* (btnCadPro) e o par txt_4c_NovoGrupo/lbl_4c_NovoGrupo conforme a linha
3492: 	* corrente da grade de itens e SigCdOpe.CadProds - transcrito do final
3493: 	* do AfterRowColChange legado (fica em metodo proprio, chamado tambem
3494: 	* de BtnCadastroProdutoClick depois de confirmar um produto novo).
3495: 	*==========================================================================
3496: 	PROCEDURE AtualizarEstadoCadastroProduto()
3497: 		LOCAL loc_cItens, loc_lVisivel, loc_cCpros, loc_nCitens, loc_nCitem2, loc_cBlocos, loc_lLinhaNormal
3498: 
3499: 		IF !PEMSTATUS(THIS, "cmd_4c_CadPro", 5)
3500: 			RETURN
3501: 		ENDIF
3502: 
3503: 		loc_cItens = THIS.this_oBusinessObject.this_cCursorItens
3504: 
3505: 		loc_lVisivel = INLIST(THIS.this_oBusinessObject.this_nCadProds, 1, 3, 4, 5) AND ;
3506: 			fChecaAcesso("SigCdPro", "INSERIR") AND ;
3507: 			INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3508: 
3509: 		IF !USED(loc_cItens) OR EOF(loc_cItens)
3510: 			THIS.cmd_4c_CadPro.Enabled = .F.
3511: 			RETURN
3512: 		ENDIF
3513: 
3514: 		loc_cCpros  = TratarNulo(EVALUATE(loc_cItens + ".cpros"), "")
3515: 		loc_nCitens = EVALUATE(loc_cItens + ".citens")
3516: 		loc_nCitem2 = EVALUATE(loc_cItens + ".citem2")
3517: 		loc_cBlocos = ALLTRIM(TratarNulo(EVALUATE(loc_cItens + ".cblocos"), ""))
3518: 
3519: 		loc_lLinhaNormal = (loc_nCitens <> loc_nCitem2) AND ;
3520: 			!INLIST(loc_cBlocos, "SUBTOTAL", "SUBTOTAIS", "TAXA", "TOTAL", "IMPOSTO", "BRANCO", "TOTALGERAL")
3521: 
3522: 		THIS.cmd_4c_CadPro.Enabled = loc_lVisivel AND ;
3523: 			( ;
3524: 				(EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 1 AND loc_lLinhaNormal) OR ;
3525: 				(!EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.this_nCadProds = 3 AND loc_lLinhaNormal) OR ;
3526: 				INLIST(THIS.this_oBusinessObject.this_nCadProds, 4, 5) ;
3527: 			)
3528: 
3529: 		IF THIS.this_oBusinessObject.this_nCadProds = 4
3530: 			THIS.txt_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3531: 			THIS.lbl_4c_NovoGrupo.Enabled = EMPTY(loc_cCpros)
3532: 			THIS.txt_4c_NovoGrupo.Value   = ""
3533: 		ENDIF
3534: 	ENDPROC
3535: 
3536: 	*==========================================================================

*-- Linhas 3608 a 3660:
3608: 		LOCAL loc_lPodeEditar
3609: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3610: 
3611: 		THIS.AddObject("cmd_4c_IncluirLinha", "CommandButton")
3612: 		WITH THIS.cmd_4c_IncluirLinha
3613: 			.Top            = 3
3614: 			.Left           = 700
3615: 			.Height         = 75
3616: 			.Width          = 75
3617: 			.FontBold       = .T.
3618: 			.FontItalic     = .T.
3619: 			.FontName       = "Comic Sans MS"
3620: 			.FontSize       = 8
3621: 			.WordWrap       = .F.
3622: 			.Caption        = "Inserir Linha"
3623: 			.ToolTipText    = "Inserir linha"
3624: 			.PicturePosition = 13
3625: 			.ForeColor      = RGB(90, 90, 90)
3626: 			.BackColor      = RGB(255, 255, 255)
3627: 			.Themes         = .T.
3628: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3629: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3630: 			.Enabled        = loc_lPodeEditar
3631: 			.Visible        = .T.
3632: 		ENDWITH
3633: 		BINDEVENT(THIS.cmd_4c_IncluirLinha, "Click", THIS, "BtnIncluirLinhaClick")
3634: 
3635: 		THIS.AddObject("cmd_4c_ExcluirLinha", "CommandButton")
3636: 		WITH THIS.cmd_4c_ExcluirLinha
3637: 			.Top            = 3
3638: 			.Left           = 775
3639: 			.Height         = 75
3640: 			.Width          = 75
3641: 			.FontBold       = .T.
3642: 			.FontItalic     = .T.
3643: 			.FontName       = "Comic Sans MS"
3644: 			.FontSize       = 8
3645: 			.Caption        = "Excluir"
3646: 			.ToolTipText    = "Exclui linha"
3647: 			.ForeColor      = RGB(90, 90, 90)
3648: 			.BackColor      = RGB(255, 255, 255)
3649: 			.Themes         = .T.
3650: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3651: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
3652: 			.Enabled        = loc_lPodeEditar
3653: 			.Visible        = .T.
3654: 		ENDWITH
3655: 		BINDEVENT(THIS.cmd_4c_ExcluirLinha, "Click", THIS, "BtnExcluirLinhaClick")
3656: 	ENDPROC
3657: 
3658: 	*==========================================================================
3659: 	* BtnIncluirLinhaClick - legado SIGOPORC.btnIncluir.Click. Insere uma
3660: 	* linha em branco IMEDIATAMENTE DEPOIS do item corrente, renumerando

*-- Linhas 3862 a 4019:
3862: 	* btnTotItens NAO tem PROCEDURE When no dump (fica sempre habilitado,
3863: 	* mesmo em CONSULTAR - ver totais nao exige direito de edicao); os
3864: 	* demais repetem o guard INSERIR/ALTERAR ja usado pelos outros botoes de
3865: 	* acao desta tela. cmd_4c_CadPro nasce Enabled=.F. - o estado real
3866: 	* depende da linha corrente (AtualizarEstadoCadastroProduto, chamado
3867: 	* pelo AfterRowColChange e pelo CarregarDados).
3868: 	*==========================================================================
3869: 	PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
3870: 		LOCAL loc_lPodeEditar
3871: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
3872: 
3873: 		THIS.AddObject("cmd_4c_TotItens", "CommandButton")
3874: 		WITH THIS.cmd_4c_TotItens
3875: 			.Top             = 3
3876: 			.Left            = 400
3877: 			.Height          = 75
3878: 			.Width           = 75
3879: 			.FontBold        = .T.
3880: 			.FontItalic      = .T.
3881: 			.FontName        = "Comic Sans MS"
3882: 			.FontSize        = 8
3883: 			.WordWrap        = .T.
3884: 			.Caption         = "Total"
3885: 			.ToolTipText     = "Total"
3886: 			.PicturePosition = 13
3887: 			.ForeColor       = RGB(90, 90, 90)
3888: 			.BackColor       = RGB(255, 255, 255)
3889: 			.Themes          = .T.
3890: 			.Picture         = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3891: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_calculadora_60.jpg"
3892: 			.Enabled         = .T.
3893: 			.Visible         = .T.
3894: 		ENDWITH
3895: 		BINDEVENT(THIS.cmd_4c_TotItens, "Click", THIS, "BtnTotalItensClick")
3896: 
3897: 		THIS.AddObject("cmd_4c_IteSub", "CommandButton")
3898: 		WITH THIS.cmd_4c_IteSub
3899: 			.Top             = 3
3900: 			.Left            = 475
3901: 			.Height          = 75
3902: 			.Width           = 75
3903: 			.FontBold        = .T.
3904: 			.FontItalic      = .T.
3905: 			.FontName        = "Comic Sans MS"
3906: 			.FontSize        = 8
3907: 			.WordWrap        = .T.
3908: 			.Caption         = "Itens Subn" + CHR(237) + "vel"
3909: 			.ToolTipText     = ""
3910: 			.PicturePosition = 13
3911: 			.ForeColor       = RGB(90, 90, 90)
3912: 			.BackColor       = RGB(255, 255, 255)
3913: 			.Themes          = .T.
3914: 			.Picture         = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3915: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_limpa_grade_60.jpg"
3916: 			.Enabled         = loc_lPodeEditar
3917: 			.Visible         = .T.
3918: 		ENDWITH
3919: 		BINDEVENT(THIS.cmd_4c_IteSub, "Click", THIS, "BtnItensSubnivelClick")
3920: 
3921: 		THIS.AddObject("cmd_4c_InsBlo", "CommandButton")
3922: 		WITH THIS.cmd_4c_InsBlo
3923: 			.Top             = 3
3924: 			.Left            = 550
3925: 			.Height          = 75
3926: 			.Width           = 75
3927: 			.FontBold        = .T.
3928: 			.FontItalic      = .T.
3929: 			.FontName        = "Comic Sans MS"
3930: 			.FontSize        = 8
3931: 			.WordWrap        = .F.
3932: 			.Caption         = "Inserir Bloco"
3933: 			.ToolTipText     = "Inserir linha"
3934: 			.PicturePosition = 13
3935: 			.ForeColor       = RGB(90, 90, 90)
3936: 			.BackColor       = RGB(255, 255, 255)
3937: 			.Themes          = .T.
3938: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3939: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3940: 			.Enabled         = loc_lPodeEditar
3941: 			.Visible         = .T.
3942: 		ENDWITH
3943: 		BINDEVENT(THIS.cmd_4c_InsBlo, "Click", THIS, "BtnInserirBlocoClick")
3944: 
3945: 		THIS.AddObject("cmd_4c_InsSub", "CommandButton")
3946: 		WITH THIS.cmd_4c_InsSub
3947: 			.Top             = 3
3948: 			.Left            = 625
3949: 			.Height          = 75
3950: 			.Width           = 75
3951: 			.FontBold        = .T.
3952: 			.FontItalic      = .T.
3953: 			.FontName        = "Comic Sans MS"
3954: 			.FontSize        = 8
3955: 			.WordWrap        = .T.
3956: 			.Caption         = "Inserir Sub-bloco"
3957: 			.ToolTipText     = "Inserir linha"
3958: 			.PicturePosition = 13
3959: 			.ForeColor       = RGB(90, 90, 90)
3960: 			.BackColor       = RGB(255, 255, 255)
3961: 			.Themes          = .T.
3962: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3963: 			.DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
3964: 			.Enabled         = loc_lPodeEditar
3965: 			.Visible         = .T.
3966: 		ENDWITH
3967: 		BINDEVENT(THIS.cmd_4c_InsSub, "Click", THIS, "BtnInserirSubBlocoClick")
3968: 
3969: 		THIS.AddObject("cmd_4c_CadPro", "CommandButton")
3970: 		WITH THIS.cmd_4c_CadPro
3971: 			.Top             = 3
3972: 			.Left            = 850
3973: 			.Height          = 75
3974: 			.Width           = 75
3975: 			.FontBold        = .T.
3976: 			.FontItalic      = .T.
3977: 			.FontName        = "Comic Sans MS"
3978: 			.FontSize        = 8
3979: 			.WordWrap        = .T.
3980: 			.Caption         = "Cadastro de Produtos"
3981: 			.ToolTipText     = "Cadastro de Produtos"
3982: 			.PicturePosition = 13
3983: 			.ForeColor       = RGB(90, 90, 90)
3984: 			.BackColor       = RGB(255, 255, 255)
3985: 			.Themes          = .T.
3986: 			.Picture         = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3987: 			.DisabledPicture = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
3988: 			.Enabled         = .F.
3989: 			.Visible         = .T.
3990: 		ENDWITH
3991: 		BINDEVENT(THIS.cmd_4c_CadPro, "Click", THIS, "BtnCadastroProdutoClick")
3992: 
3993: 		THIS.AddObject("obj_4c_OK", "CommandGroup")
3994: 		WITH THIS.obj_4c_OK
3995: 			.ButtonCount = 1
3996: 			.Top         = -2
3997: 			.Left        = 920
3998: 			.Height      = 85
3999: 			.Width       = 85
4000: 			.BackStyle   = 0
4001: 			.BorderStyle = 0
4002: 			.Themes      = .T.
4003: 			WITH .Buttons(1)
4004: 				.Top             = 5
4005: 				.Left            = 5
4006: 				.Height          = 75
4007: 				.Width           = 75
4008: 				.FontBold        = .T.
4009: 				.FontItalic      = .T.
4010: 				.FontName        = "Comic Sans MS"
4011: 				.FontSize        = 8
4012: 				.WordWrap        = .T.
4013: 				.Cancel          = .T.
4014: 				.Caption         = "Retornar"
4015: 				.ToolTipText     = "[Esc] Voltar Para a Tela Principal da Opera" + CHR(231) + CHR(227) + "o"
4016: 				.PicturePosition = 13
4017: 				.ForeColor       = RGB(90, 90, 90)
4018: 				.BackColor       = RGB(255, 255, 255)
4019: 				.Themes          = .T.

*-- Linhas 4999 a 5016:
4999: 		loc_lPodeEditar = INLIST(THIS.this_cOpEscolha, "INSERIR", "ALTERAR")
5000: 
5001: 		*-- Botoes de linha da grade de itens
5002: 		THIS.cmd_4c_IncluirLinha.Enabled = loc_lPodeEditar
5003: 		THIS.cmd_4c_ExcluirLinha.Enabled = loc_lPodeEditar
5004: 
5005: 		*-- Botoes de estrutura (bloco / sub-bloco) e navegacao de subnivel
5006: 		THIS.cmd_4c_InsBlo.Enabled = loc_lPodeEditar
5007: 		THIS.cmd_4c_InsSub.Enabled = loc_lPodeEditar
5008: 		THIS.cmd_4c_IteSub.Enabled = loc_lPodeEditar
5009: 
5010: 		*-- btnTotItens e o OK nao tem When no legado
5011: 		THIS.cmd_4c_TotItens.Enabled = .T.
5012: 		THIS.obj_4c_OK.Enabled       = .T.
5013: 
5014: 		*-- btnCadPro depende do modo E da linha corrente: quem resolve as
5015: 		*-- duas coisas (incluindo CadProds/fChecaAcesso) e o metodo de
5016: 		*-- refino, que ja trata cursor ausente/EOF.


### BO (C:\4c\projeto\app\classes\sigoporcBO.prg):
*====================================================================
* sigoporcBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPORC" (grade de Itens de
* um Orcamento). O legado abre este form como filho do form de
* cabecalho do movimento (Lparameters poForm, pnDatSes - Set
* Datasession To pnDatSes, isto e, o filho passa a compartilhar a MESMA
* data session do pai, com os cursores crSigMvOrc/crSigMvOrp/TprMvCab/
* crSigCdOpe/LocalEmp ja abertos por ele).
*
* Tabelas envolvidas: SigMvOrc (itens do orcamento), SigMvOrp
* (parcelas/previsoes de pagamento do item), SigMvCab (cabecalho do
* movimento - espelhado no cursor temporario TprMvCab do pai), SigCdOpe
* (configuracao da operacao), SigCdEmp (configuracao da empresa).
*
* Referencias legado -> BO:
*   TprMvCab.Emps/Dopes/Numes/MascNum -> this_cEmps/this_cDopes/
*                                        this_nNumes/this_cMascNum
*   crSigCdOpe.DigItens/CadProds/Opers/Origems/Destinos/OpePads ->
*                                        this_nDigItens/this_nCadProds/
*                                        this_nOpers/this_nOrigems/
*                                        this_nDestinos/this_cOpePads
*   LocalEmp.DivNotas (CursorQuery de SigCdEmp) -> this_nDivNotas
*   TprMvCab.ContaOs/ContaDs -> this_cContaOs/this_cContaDs
*   TprMvCab.Acres/PTax1s/PTax2s/PTax3s/Descs -> this_nAcres/this_nPTax1s/
*                                          this_nPTax2s/this_nPTax3s/this_nDescs
*   SigOpCdd.ConfigGers -> this_cConfigGers
*   Thisform.Caption -> this_cCaption
*   crSigMvOrc (grade de itens) -> this_cCursorItens ("cursor_4c_Itens")
*   crSigMvOrp (grade de parcelas) -> this_cCursorParcelas
*                                     ("cursor_4c_Parcelas")
*
* Thisform.ParentForm, Thisform.poObjExt1 (referencia ao form externo de
* pesquisa de produtos SigOpCgp) e o controle de DataSession permanecem
* no FORM (sao referencias/estado de UI, fora da responsabilidade do
* Business Object).
*
* Herda de: BusinessBase
*
* Fase 1/8 - propriedades e Init(). A leitura de SigCdOpe/SigCdEmp
* (DigItens/CadProds/Opers/Origems/Destinos/OpePads/DivNotas) e as
* colunas de TprMvCab (ContaOs/ContaDs/Acres/PTax1s/PTax2s/PTax3s) serao
* carregadas por metodo proprio em fase posterior - os valores abaixo
* ficam com o default ate la.
*
* Fase 2/8 - CarregarDoCursor()/Inserir()/Atualizar()/ObterChavePrimaria()
* para o ITEM de SigMvOrc (chave cidchaves), com RegistrarAuditoria()
* (herdado de BusinessBase) chamado em Inserir/Atualizar. cidchaves e
* pkchaves sao as duas chaves Fortyus (fUniqueIds(), regra #22) geradas
* no Inserir quando ainda vazias. Buscar() nao e sobrescrito aqui: a
* listagem de itens (SELECT com joins de produto/unidade) fica na fase do
* BO que monta o cursor da grade (CarregarItens), porque a consulta tem
* joins e nao cabe no Buscar() generico herdado de BusinessBase.
*
* Fase 7/8 - CarregarConfiguracao() (SigCdOpe/SigCdEmp/SigOpCdd/SigMvCab,
* equivalentes aos cursores que o FORM PAI legado ja tinha abertos -
* regra #35/cabecalho acima), CarregarItens()/CarregarParcelas() (leitura
* de SigMvOrc/SigMvOrp para as duas grades - o legado faz isso via
* AddCursor no Init; aqui e feito por SQLEXEC em cursor temporario +
* ZAP/APPEND no cursor ja ligado ao Grid, regra "SQLEXEC sobre alias de
* grid zera o ColumnCount").
*
* Modo Criacao do legado (SigCdOpe.DigItens IN (6,7), com sub-blocos
* lidos de SigOpCdI.JOB_MV_BLO em btnInsBlo/btnInsSub) NAO E PORTADO: a
* tabela SigOpCdI NAO EXISTE no schema canonico (conferido em
* docs\schema.sql, regra #14 - zero ocorrencias, nao e falso-negativo de
* encoding). This_nDigItens continua sendo lido e comparado (para nao
* quebrar os outros ramos que dependem dele, como DigItens=5->CONSULTAR),
* mas o ramo exclusivo de DigItens IN (6,7) que insere sub-itens de
* JOB_MV_BLO fica de fora em btnInsBlo/btnInsSub, com o motivo documentado
* la (nao e omissao silenciosa - rule "SEMPRE FUNCIONALIDADE COMPLETA",
* mas a fonte de dados do legado para essa sub-feature nao existe mais).
*====================================================================

DEFINE CLASS sigoporcBO AS BusinessBase

	*-- Parametros recebidos do form pai na abertura do dialogo (legado:
	*-- Lparameters poForm, pnDatSes). O form migrado repassa so os
	*-- valores escalares que identificam o cabecalho do movimento
	*-- (TprMvCab/SigMvCab); poForm (referencia de UI) e a troca de
	*-- DataSession ficam no Form.
	this_cEmps = ""                 && Empresa do movimento (TprMvCab.Emps / SigMvCab.emps)
	this_cDopes = ""                && Documento de Operacao (TprMvCab.Dopes / SigMvCab.dopes)
	this_nNumes = 0                 && Numero do movimento (TprMvCab.Numes / SigMvCab.numes)
	this_cMascNum = ""              && Mascara/numero formatado do documento (TprMvCab.MascNum) - usado no Caption "Itens"

	*-- Configuracao da operacao (SigCdOpe), referente ao Dopes acima.
	*-- Controla ramos de negocio usados pelos botoes/grades desta tela.
	*-- Populados em fase posterior (leitura via SQLEXEC); default abaixo.
	this_nDigItens = 0              && SigCdOpe.DigItens - 5 forca modo CONSULTAR independente do pai (Op_Escolha)
	this_nCadProds = 0              && SigCdOpe.CadProds - habilita o botao "Cadastro de Produtos" (btnCadPro)
	this_nOpers = 0                 && SigCdOpe.Opers - 1=Entrada/2=Saida, usado para resolver o fornecedor padrao
	this_nOrigems = 0               && SigCdOpe.Origems - .T. quando a conta de origem (TprMvCab.ContaOs) e obrigatoria
	this_nDestinos = 0              && SigCdOpe.Destinos - .T. quando a conta de destino (TprMvCab.ContaDs) e obrigatoria
	this_cOpePads = ""              && SigCdOpe.OpePads - padrao de operacao usado no cadastro de produtos
	this_nImagems = 0               && SigCdOpe.Imagems - habilita a pre-visualizacao da foto do produto no AfterRowColChange (grdItem.imgProds)
	this_nConfes = 0                && SigCdOpe.Confes - quando = 1, suprime a pre-visualizacao mesmo com Imagems = 1
	this_nPrecoAuts = 0             && SigCdOpe.PrecoAuts - autoriza a precificacao automatica em btnCadPro.Click
	this_nPrecoPs = 0               && SigCdOpe.PrecoPs - origem do preco automatico (1/10=venda ou ideal, 2=custo, 5=valors, 7=ultima compra, 8/9=custo medio, 11=custo total)
	this_nPrecops = 0               && SigCdOpe.Precops - moeda/fator de venda(1) ou custo(2) a copiar do cadastro de produto
	this_cCMoes = ""                && SigCdOpe.CMoes - moeda padrao da operacao (fallback quando nao ha precificacao automatica)

	*-- Configuracao da empresa (SigCdEmp), lida via Cemps = this_cEmps
	*-- (legado: CursorQuery([SigCdEmp],[LocalEmp],[Cemps],TprMvCab.Emps,[DivNotas])).
	*-- Populada em fase posterior; default abaixo.
	this_nDivNotas = 0              && SigCdEmp.DivNotas - 1=Preco&Gerencial(P&G) / 2=SRCOM - decide a formula de rateio dos percentuais do item

	*-- Contas de origem/destino do cabecalho (TprMvCab/SigMvCab), usadas
	*-- em btnCadPro.Click para resolver o fornecedor do produto novo.
	*-- Populadas em fase posterior; default abaixo.
	this_cContaOs = ""              && Conta de Origem (TprMvCab.ContaOs)
	this_cContaDs = ""              && Conta de Destino (TprMvCab.ContaDs)

	*-- Percentuais/indices do cabecalho (TprMvCab/SigMvCab), usados como
	*-- semente dos campos de percentual do item recem-incluido.
	*-- Populados em fase posterior; default abaixo.
	this_nAcres = 0                 && TprMvCab.Acres - imposto cheio (usado quando o item NAO e servico)
	this_nPTax1s = 0                && TprMvCab.PTax1s - percentual default de BV (Perc3s)
	this_nPTax2s = 0                && TprMvCab.PTax2s - percentual default de despesa operacional/contingente (Perc1s)
	this_nPTax3s = 0                && TprMvCab.PTax3s - percentual default de imposto de servico (Perc4s quando Servicos)
	this_nDescs = 0                 && TprMvCab.Descs - percentual default de lucro/"Taxa Adm." (Perc2s)

	*-- Mascara de configuracoes gerais da operacao (SigOpCdd.ConfigGers),
	*-- lida via Dopes = this_cDopes. Posicao 192 (1 char) = flag de
	*-- Decupagem (Int(Val(Substr(ConfigGers,192,1))) = 1), usada em
	*-- TotalizarItn(). Populada em fase posterior; default "" faz a
	*-- checagem de Decupagem avaliar sempre .F. (SUBSTR/VAL de string
	*-- vazia devolve 0), que e o comportamento seguro ate a config
	*-- chegar.
	this_cConfigGers = ""
	this_nChkIfors = 0              && SigOpCdd.ChkIfors - 1/2 habilita a resolucao de preco por SigPrFnc (tabela de fornecedor) antes do padrao de SigCdMoe

	*-- Titulo montado para a tela (legado: Thisform.Caption)
	this_cCaption = ""              && "<Emps> <Dopes> <MascNum> - Itens"

	*-- Nomes dos cursores que este BO popula/consome (constantes, para o
	*-- Form referenciar sem repetir literais - equivalentes aos aliases
	*-- globais do legado crSigMvOrc/crSigMvOrp)
	this_cCursorItens = "cursor_4c_Itens"        && Grade de itens do orcamento (SigMvOrc)
	this_cCursorParcelas = "cursor_4c_Parcelas"  && Grade de parcelas/previsoes do item selecionado (SigMvOrp)

	*-- Propriedades da entidade (mapeamento 1-para-1 para a tabela SigMvOrc -
	*-- um ITEM da grade de orcamento, chave cidchaves). this_cEmps/
	*-- this_cDopes/this_nNumes acima (recebidos no Init) JA cobrem as
	*-- colunas emps/dopes/numes - nao duplicar.
	this_cCblocos    = ""   && cblocos char(30) - marcador de linha (SUBTOTAL/BRANCO/SUBTOTAIS/TAXA/TOTAL/IMPOSTO/TOTALGERAL ou vazio = item normal)
	this_nCitem2     = 0    && citem2 numeric(10,0) - item do bloco (subtotal pai)
	this_nCitens     = 0    && citens numeric(10,0) - numero do item (PK logica dentro do orcamento)
	this_cCpros      = ""   && cpros char(14) - codigo do produto
	this_cCunips     = ""   && cunips char(3) - unidade de compra/pedido
	this_cCunis      = ""   && cunis char(3) - unidade de venda
	this_cDpro2s     = ""   && dpro2s text NULL - descricao complementar do produto
	this_cDpros      = ""   && dpros char(65) - descricao do produto/bloco
	this_cEmpdopnums = ""   && empdopnums char(29) - Emps(3)+Dopes(20)+Str(Numes,6), chave posicional que liga o item ao cabecalho
	this_nFators     = 0    && fators numeric(8,4) - fator de conversao de unidade
	this_nPesos      = 0    && pesos numeric(8,4) - peso unitario
	this_cPkchaves   = ""   && pkchaves char(20) - chave unica Fortyus (fUniqueIds(), independente de cidchaves)
	this_nQtds       = 0    && qtds numeric(8,4) - quantidade
	this_nTotas      = 0    && totas numeric(13,2) - total do item
	this_nUnits      = 0    && units numeric(13,2) - valor unitario
	this_cCidchaves  = ""   && cidchaves char(20) - PK (fUniqueIds())
	this_cMoedas     = ""   && moedas char(3) - moeda do total de custo
	this_cMoefats    = ""   && moefats char(3) - moeda de faturamento
	this_cMoevs      = ""   && moevs char(3) - moeda de venda
	this_cNotas      = ""   && notas char(9) - numero/mascara da nota associada
	this_cObs        = ""   && obs text NULL - observacao do item
	this_cOpers      = ""   && opers char(1) - tipo de operacao do item (distinto de this_nOpers, que e config de SigCdOpe)
	this_nTota1s     = 0    && tota1s numeric(13,2) - despesa operacional (Perc1s)
	this_nTota2s     = 0    && tota2s numeric(13,2) - lucro (Perc2s)
	this_nTota3s     = 0    && tota3s numeric(13,2) - BV (Perc3s)
	this_nTota4s     = 0    && tota4s numeric(13,2) - imposto/servico (Perc4s)
	this_nTota5s     = 0    && tota5s numeric(13,2) - incentivo 1 (Perc5s)
	this_nTota6s     = 0    && tota6s numeric(13,2) - incentivo 2 (Perc6s)
	this_nTota7s     = 0    && tota7s numeric(13,2) - custo interno SRCOM
	this_nTota8s     = 0    && tota8s numeric(13,2) - valor fornecedor
	this_nTota9s     = 0    && tota9s numeric(13,2) - saldo real custo interno SRCOM
	this_nTota10s    = 0    && tota10s numeric(13,2) - saldo real fornecedor
	this_nTpesos     = 0    && tpesos numeric(8,4) - peso total
	this_nUnivals    = 0    && univals numeric(13,2) - valor unitario de venda
	this_nUtilizas   = 0    && utilizas numeric(2,0) - controle de utilizacao (fluxo de preco autorizado)
	this_lServicos   = .F.  && servicos bit - item e servico (troca a regra de calculo do imposto)
	this_nCitagrs    = 0    && citagrs numeric(10,0) - item do agrupador (decupagem)
	this_nCitem3     = 0    && citem3 numeric(10,0) - item do sub-bloco (subtotal de 2o nivel)
	this_cCodacabs   = ""   && codacabs char(3) - codigo de acabamento (SigCdAca)
	this_lDebitos    = .F.  && debitos bit - item gerado a debito (bloqueia imposto cheio)
	this_lTaxas      = .F.  && taxas bit - item e taxa (fee)

	*====================================================================
	* Init - Inicializa Business Object
	* Parametros equivalentes ao Lparameters poForm, pnDatSes do Init do
	* form legado - o form migrado repassa so os valores escalares que
	* identificam o cabecalho do movimento (poForm/pnDatSes, que sao
	* referencia de UI e troca de DataSession, ficam no Form).
	*====================================================================
	PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_cMascNum)
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela = "SigMvOrc"
		THIS.this_cCampoChave = "cidchaves"

		IF VARTYPE(par_cEmps) = "C"
			THIS.this_cEmps = par_cEmps
		ENDIF

		IF VARTYPE(par_cDopes) = "C"
			THIS.this_cDopes = par_cDopes
		ENDIF

		IF VARTYPE(par_nNumes) = "N"
			THIS.this_nNumes = par_nNumes
		ENDIF

		IF VARTYPE(par_cMascNum) = "C"
			THIS.this_cMascNum = par_cMascNum
		ENDIF

		*-- Legado: Thisform.Caption = Alltrim(Emps)+' '+Alltrim(Dopes)+' '+Alltrim(MascNum)+' - Itens'
		THIS.this_cCaption = ALLTRIM(THIS.this_cEmps) + " " + ALLTRIM(THIS.this_cDopes) + ;
			" " + ALLTRIM(THIS.this_cMascNum) + " - Itens"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna a chave primaria (cidchaves) do item
	* corrente, para uso em RegistrarAuditoria()
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia TODAS as colunas de um item de SigMvOrc
	* (cursor_4c_Itens/crSigMvOrc) para as propriedades do BO. SEMPRE usar
	* SELECT (par_cAliasCursor) antes de acessar os campos (regra #8).
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCblocos = TratarNulo(cblocos, "C")
				THIS.this_nCitem2 = TratarNulo(citem2, "N")
				THIS.this_nCitens = TratarNulo(citens, "N")
				THIS.this_cCpros = TratarNulo(cpros, "C")
				THIS.this_cCunips = TratarNulo(cunips, "C")
				THIS.this_cCunis = TratarNulo(cunis, "C")
				THIS.this_cDopes = TratarNulo(dopes, "C")
				THIS.this_cDpro2s = TratarNulo(dpro2s, "C")
				THIS.this_cDpros = TratarNulo(dpros, "C")
				THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
				THIS.this_cEmps = TratarNulo(emps, "C")
				THIS.this_nFators = TratarNulo(fators, "N")
				THIS.this_nNumes = TratarNulo(numes, "N")
				THIS.this_nPesos = TratarNulo(pesos, "N")
				THIS.this_cPkchaves = TratarNulo(pkchaves, "C")
				THIS.this_nQtds = TratarNulo(qtds, "N")
				THIS.this_nTotas = TratarNulo(totas, "N")
				THIS.this_nUnits = TratarNulo(units, "N")
				THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
				THIS.this_cMoedas = TratarNulo(moedas, "C")
				THIS.this_cMoefats = TratarNulo(moefats, "C")
				THIS.this_cMoevs = TratarNulo(moevs, "C")
				THIS.this_cNotas = TratarNulo(notas, "C")
				THIS.this_cObs = TratarNulo(obs, "C")
				THIS.this_cOpers = TratarNulo(opers, "C")
				THIS.this_nTota1s = TratarNulo(tota1s, "N")
				THIS.this_nTota2s = TratarNulo(tota2s, "N")
				THIS.this_nTota3s = TratarNulo(tota3s, "N")
				THIS.this_nTota4s = TratarNulo(tota4s, "N")
				THIS.this_nTota5s = TratarNulo(tota5s, "N")
				THIS.this_nTota6s = TratarNulo(tota6s, "N")
				THIS.this_nTota7s = TratarNulo(tota7s, "N")
				THIS.this_nTota8s = TratarNulo(tota8s, "N")
				THIS.this_nTota9s = TratarNulo(tota9s, "N")
				THIS.this_nTota10s = TratarNulo(tota10s, "N")
				THIS.this_nTpesos = TratarNulo(tpesos, "N")
				THIS.this_nUnivals = TratarNulo(univals, "N")
				THIS.this_nUtilizas = TratarNulo(utilizas, "N")
				IF VARTYPE(servicos) = "L"
					THIS.this_lServicos = servicos
				ELSE
					THIS.this_lServicos = (NVL(servicos, 0) = 1)
				ENDIF
				THIS.this_nCitagrs = TratarNulo(citagrs, "N")
				THIS.this_nCitem3 = TratarNulo(citem3, "N")
				THIS.this_cCodacabs = TratarNulo(codacabs, "C")
				IF VARTYPE(debitos) = "L"
					THIS.this_lDebitos = debitos
				ELSE
					THIS.this_lDebitos = (NVL(debitos, 0) = 1)
				ENDIF
				IF VARTYPE(taxas) = "L"
					THIS.this_lTaxas = taxas
				ELSE
					THIS.this_lTaxas = (NVL(taxas, 0) = 1)
				ENDIF

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - Insere novo item (linha) em SigMvOrc
	* PK (cidchaves) e pkchaves gerados via fUniqueIds() se ainda vazios
	* (regra #22 - PK Fortyus NUNCA pode ser string vazia)
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			IF EMPTY(ALLTRIM(NVL(THIS.this_cPkchaves, "")))
				THIS.this_cPkchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			*-- Campo computado: Emps + Dopes + Numes (chave posicional que liga
			*-- o item ao cabecalho - regra #42, NUNCA ALLTRIM nas partes)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "INSERT INTO SigMvOrc ("
			loc_cSQL = loc_cSQL + "cblocos, citem2, citens, cpros, cunips, cunis, dopes, dpro2s,"
			loc_cSQL = loc_cSQL + "dpros, empdopnums, emps, fators, numes, pesos, pkchaves, qtds,"
			loc_cSQL = loc_cSQL + "totas, units, cidchaves, moedas, moefats, moevs, notas, obs,"
			loc_cSQL = loc_cSQL + "opers, tota10s, tota1s, tota2s, tota3s, tota4s, tota5s, tota6s,"
			loc_cSQL = loc_cSQL + "tota7s, tota8s, tota9s, tpesos, univals, utilizas, servicos, citagrs,"
			loc_cSQL = loc_cSQL + "citem3, codacabs, debitos, taxas"
			loc_cSQL = loc_cSQL + ") VALUES ("
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + IIF(THIS.this_lTaxas, "1", "0") + ")"

			IF USED("cursor_4c_Insert")
				USE IN cursor_4c_Insert
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

			IF loc_nResult < 0
				MsgErro("Erro ao inserir item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("INSERT")
				IF USED("cursor_4c_Insert")
					USE IN cursor_4c_Insert
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza item existente em SigMvOrc (por cidchaves)
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- Campo computado: Emps + Dopes + Numes (chave posicional - regra #42)
			THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)

			*-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
			*-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
			*-- com limite de 8192 caracteres ("Line is too long" em runtime).
			loc_cSQL = "UPDATE SigMvOrc SET"
			loc_cSQL = loc_cSQL + " cblocos = " + EscaparSQL(LEFT(THIS.this_cCblocos, 30)) + ","
			loc_cSQL = loc_cSQL + " citem2 = " + FormatarNumeroSQL(THIS.this_nCitem2, 0) + ","
			loc_cSQL = loc_cSQL + " citens = " + FormatarNumeroSQL(THIS.this_nCitens, 0) + ","
			loc_cSQL = loc_cSQL + " cpros = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ","
			loc_cSQL = loc_cSQL + " cunips = " + EscaparSQL(LEFT(THIS.this_cCunips, 3)) + ","
			loc_cSQL = loc_cSQL + " cunis = " + EscaparSQL(LEFT(THIS.this_cCunis, 3)) + ","
			loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
			loc_cSQL = loc_cSQL + " dpro2s = " + EscaparSQL(THIS.this_cDpro2s) + ","
			loc_cSQL = loc_cSQL + " dpros = " + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ","
			loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
			loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
			loc_cSQL = loc_cSQL + " fators = " + FormatarNumeroSQL(THIS.this_nFators, 4) + ","
			loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
			loc_cSQL = loc_cSQL + " pesos = " + FormatarNumeroSQL(THIS.this_nPesos, 4) + ","
			loc_cSQL = loc_cSQL + " pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkchaves, 20)) + ","
			loc_cSQL = loc_cSQL + " qtds = " + FormatarNumeroSQL(THIS.this_nQtds, 4) + ","
			loc_cSQL = loc_cSQL + " totas = " + FormatarNumeroSQL(THIS.this_nTotas, 2) + ","
			loc_cSQL = loc_cSQL + " units = " + FormatarNumeroSQL(THIS.this_nUnits, 2) + ","
			loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
			loc_cSQL = loc_cSQL + " moefats = " + EscaparSQL(LEFT(THIS.this_cMoefats, 3)) + ","
			loc_cSQL = loc_cSQL + " moevs = " + EscaparSQL(LEFT(THIS.this_cMoevs, 3)) + ","
			loc_cSQL = loc_cSQL + " notas = " + EscaparSQL(LEFT(THIS.this_cNotas, 9)) + ","
			loc_cSQL = loc_cSQL + " obs = " + EscaparSQL(THIS.this_cObs) + ","
			loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
			loc_cSQL = loc_cSQL + " tota10s = " + FormatarNumeroSQL(THIS.this_nTota10s, 2) + ","
			loc_cSQL = loc_cSQL + " tota1s = " + FormatarNumeroSQL(THIS.this_nTota1s, 2) + ","
			loc_cSQL = loc_cSQL + " tota2s = " + FormatarNumeroSQL(THIS.this_nTota2s, 2) + ","
			loc_cSQL = loc_cSQL + " tota3s = " + FormatarNumeroSQL(THIS.this_nTota3s, 2) + ","
			loc_cSQL = loc_cSQL + " tota4s = " + FormatarNumeroSQL(THIS.this_nTota4s, 2) + ","
			loc_cSQL = loc_cSQL + " tota5s = " + FormatarNumeroSQL(THIS.this_nTota5s, 2) + ","
			loc_cSQL = loc_cSQL + " tota6s = " + FormatarNumeroSQL(THIS.this_nTota6s, 2) + ","
			loc_cSQL = loc_cSQL + " tota7s = " + FormatarNumeroSQL(THIS.this_nTota7s, 2) + ","
			loc_cSQL = loc_cSQL + " tota8s = " + FormatarNumeroSQL(THIS.this_nTota8s, 2) + ","
			loc_cSQL = loc_cSQL + " tota9s = " + FormatarNumeroSQL(THIS.this_nTota9s, 2) + ","
			loc_cSQL = loc_cSQL + " tpesos = " + FormatarNumeroSQL(THIS.this_nTpesos, 4) + ","
			loc_cSQL = loc_cSQL + " univals = " + FormatarNumeroSQL(THIS.this_nUnivals, 2) + ","
			loc_cSQL = loc_cSQL + " utilizas = " + FormatarNumeroSQL(THIS.this_nUtilizas, 0) + ","
			loc_cSQL = loc_cSQL + " servicos = " + IIF(THIS.this_lServicos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " citagrs = " + FormatarNumeroSQL(THIS.this_nCitagrs, 0) + ","
			loc_cSQL = loc_cSQL + " citem3 = " + FormatarNumeroSQL(THIS.this_nCitem3, 0) + ","
			loc_cSQL = loc_cSQL + " codacabs = " + EscaparSQL(LEFT(THIS.this_cCodacabs, 3)) + ","
			loc_cSQL = loc_cSQL + " debitos = " + IIF(THIS.this_lDebitos, "1", "0") + ","
			loc_cSQL = loc_cSQL + " taxas = " + IIF(THIS.this_lTaxas, "1", "0")
			loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

			IF USED("cursor_4c_Update")
				USE IN cursor_4c_Update
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

			IF loc_nResult < 0
				MsgErro("Erro ao atualizar item do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				THIS.RegistrarAuditoria("UPDATE")
				IF USED("cursor_4c_Update")
					USE IN cursor_4c_Update
				ENDIF
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarConfiguracao - Le SigCdOpe (por Dopes), SigCdEmp (por Cemps -
	* regra SigCdEmp usa Cemps, NUNCA Cemps), SigOpCdd (por Dopes) e os
	* percentuais/contas do cabecalho em SigMvCab (por Emps+Dopes+Numes).
	* Equivalente ao bloco de cursores que o FORM PAI legado ja mantinha
	* abertos (crSigCdOpe/LocalEmp/crSigOpCdd/TprMvCab) - aqui cada valor e
	* lido direto do SQL Server, uma unica vez, na abertura do dialogo.
	*
	* Chamada em Formsigoporc.InicializarForm, logo apos CREATEOBJECT do
	* BO e ANTES de qualquer Configurar*() que dependa de this_cOpEscolha
	* (o Form recalcula this_cOpEscolha com this_nDigItens depois desta
	* chamada - regra do legado: DigItens=5 forca CONSULTAR).
	*====================================================================
	PROCEDURE CarregarConfiguracao()
		LOCAL loc_cSQL, loc_lSucesso
		loc_lSucesso = .T.

		TRY
			*-- SigCdOpe (configuracao da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF
			loc_cSQL = "SELECT DigItens, CadProds, Opers, Origems, Destinos, OpePads,"
			loc_cSQL = loc_cSQL + " Imagems, Confes, PrecoAuts, PrecoPs, Precops, CMoes"
			loc_cSQL = loc_cSQL + " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") > 0 AND USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
				SELECT cursor_4c_CfgOpe
				THIS.this_nDigItens  = TratarNulo(DigItens, "N")
				THIS.this_nCadProds  = TratarNulo(CadProds, "N")
				THIS.this_nOpers     = TratarNulo(Opers, "N")
				THIS.this_nOrigems   = TratarNulo(Origems, "N")
				THIS.this_nDestinos  = TratarNulo(Destinos, "N")
				THIS.this_cOpePads   = TratarNulo(OpePads, "C")
				THIS.this_nImagems   = TratarNulo(Imagems, "N")
				THIS.this_nConfes    = TratarNulo(Confes, "N")
				THIS.this_nPrecoAuts = TratarNulo(PrecoAuts, "N")
				THIS.this_nPrecoPs   = TratarNulo(PrecoPs, "N")
				THIS.this_nPrecops   = TratarNulo(Precops, "N")
				THIS.this_cCMoes     = TratarNulo(CMoes, "C")
			ENDIF
			IF USED("cursor_4c_CfgOpe")
				USE IN cursor_4c_CfgOpe
			ENDIF

			*-- SigCdEmp (configuracao da empresa, chave Cemps)
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF
			loc_cSQL = "SELECT DivNotas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmps)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgEmp") > 0 AND USED("cursor_4c_CfgEmp") AND RECCOUNT("cursor_4c_CfgEmp") > 0
				THIS.this_nDivNotas = TratarNulo(cursor_4c_CfgEmp.DivNotas, "N")
			ENDIF
			IF USED("cursor_4c_CfgEmp")
				USE IN cursor_4c_CfgEmp
			ENDIF

			*-- SigOpCdd (configuracao-detalhe da operacao, chave Dopes)
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF
			loc_cSQL = "SELECT ConfigGers, ChkIfors FROM SigOpCdd WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpd") > 0 AND USED("cursor_4c_CfgOpd") AND RECCOUNT("cursor_4c_CfgOpd") > 0
				THIS.this_cConfigGers = TratarNulo(cursor_4c_CfgOpd.ConfigGers, "C")
				THIS.this_nChkIfors   = TratarNulo(cursor_4c_CfgOpd.ChkIfors, "N")
			ENDIF
			IF USED("cursor_4c_CfgOpd")
				USE IN cursor_4c_CfgOpd
			ENDIF

			*-- SigMvCab (cabecalho do movimento, chave Emps+Dopes+Numes) -
			*-- percentuais default (semente do item novo) e contas de
			*-- origem/destino (usadas por btnCadPro.Click)
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
			loc_cSQL = "SELECT Acres, PTax1s, PTax2s, PTax3s, Descs, ContaOs, ContaDs"
			loc_cSQL = loc_cSQL + " FROM SigMvCab WHERE Emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND Dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgCab") > 0 AND USED("cursor_4c_CfgCab") AND RECCOUNT("cursor_4c_CfgCab") > 0
				SELECT cursor_4c_CfgCab
				THIS.this_nAcres   = TratarNulo(Acres, "N")
				THIS.this_nPTax1s  = TratarNulo(PTax1s, "N")
				THIS.this_nPTax2s  = TratarNulo(PTax2s, "N")
				THIS.this_nPTax3s  = TratarNulo(PTax3s, "N")
				THIS.this_nDescs   = TratarNulo(Descs, "N")
				THIS.this_cContaOs = TratarNulo(ContaOs, "C")
				THIS.this_cContaDs = TratarNulo(ContaDs, "C")
			ENDIF
			IF USED("cursor_4c_CfgCab")
				USE IN cursor_4c_CfgCab
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarConfiguracao")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Popula cursor_4c_Itens (grade de itens) a partir de
	* SigMvOrc, filtrado por Emps/Dopes/Numes e ordenado por Citens -
	* equivalente ao AddCursor('SigMvOrc','citens','CrSigMvOrc',...) do
	* Init legado. SQLEXEC vai para um cursor TEMPORARIO; cursor_4c_Itens
	* (ja ligado ao Grid, com colunas de lookup instaladas via AddObject)
	* e recarregado com ZAP + APPEND FROM DBF() - NUNCA SQLEXEC direto nele
	* (regra: SQLEXEC sobre alias de grid zera o ColumnCount).
	*====================================================================
	PROCEDURE CarregarItens()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF

			loc_cSQL = "SELECT o.cblocos, o.citem2, o.citens, o.cpros, o.cunips, o.cunis, o.dopes,"
			loc_cSQL = loc_cSQL + " o.dpro2s, o.dpros, o.empdopnums, o.emps, o.fators, o.numes, o.pesos,"
			loc_cSQL = loc_cSQL + " o.pkchaves, o.qtds, o.totas, o.units, o.cidchaves, o.moedas, o.moefats,"
			loc_cSQL = loc_cSQL + " o.moevs, o.notas, o.obs, o.opers, o.tota10s, o.tota1s, o.tota2s, o.tota3s,"
			loc_cSQL = loc_cSQL + " o.tota4s, o.tota5s, o.tota6s, o.tota7s, o.tota8s, o.tota9s, o.tpesos,"
			loc_cSQL = loc_cSQL + " o.univals, o.utilizas, o.servicos, o.citagrs, o.citem3, o.codacabs,"
			loc_cSQL = loc_cSQL + " o.debitos, o.taxas,"
			*-- Descricoes de lookup exibidas nas Columns 4/6/30 da grade de itens
			*-- (legado: crSigMvOrc.DcUnis/DcUnips/DAcabs - colunas PROJETADAS pela
			*-- query do form PAI, nao colunas de SigMvOrc). Sem estes tres joins a
			*-- grade abriria com Unidade/Unidade(pedido)/Acabamento em BRANCO,
			*-- mesmo com cunis/cunips/codacabs gravados.
			loc_cSQL = loc_cSQL + " NVL(uv.dunis, '')  AS dcunis,"
			loc_cSQL = loc_cSQL + " NVL(up.dunis, '')  AS dcunips,"
			loc_cSQL = loc_cSQL + " NVL(ac.descrs, '') AS dacabs"
			loc_cSQL = loc_cSQL + " FROM SigMvOrc o"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni uv ON RTRIM(uv.cunis) = RTRIM(o.cunis)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdUni up ON RTRIM(up.cunis) = RTRIM(o.cunips)"
			loc_cSQL = loc_cSQL + " LEFT JOIN SigCdAca ac ON RTRIM(ac.cods)  = RTRIM(o.codacabs)"
			loc_cSQL = loc_cSQL + " WHERE o.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND o.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND o.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY o.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar itens do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorItens)
					SELECT (THIS.this_cCursorItens)
					ZAP
					IF USED("cursor_4c_ItensTmp") AND RECCOUNT("cursor_4c_ItensTmp") > 0
						APPEND FROM DBF("cursor_4c_ItensTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ItensTmp")
				USE IN cursor_4c_ItensTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarItens")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarParcelas - Popula cursor_4c_Parcelas (grade de parcelas) a
	* partir de SigMvOrp, filtrado por Emps/Dopes/Numes e ordenado por
	* Citens - equivalente ao AddCursor('SigMvOrp','citens','CrSigMvOrp',
	* ...) do Init legado. dfors (descricao do fornecedor, Column6 de
	* grd_4c_Parcelas, SEMPRE ReadOnly) e projetado via LEFT JOIN em
	* SigCdCli.Iclis/Rclis - mesma tabela de conta usada pelo lookup
	* fAcessoContas do legado (ver cabecalho de ConfigurarGradeParcelas).
	* Mesmo padrao grid-safe de CarregarItens (cursor temporario + ZAP +
	* APPEND FROM DBF no cursor ja ligado ao Grid).
	*====================================================================
	PROCEDURE CarregarParcelas()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF

			loc_cSQL = "SELECT p.cidchaves, p.citens, p.datas, p.dopes, p.empdopnums,"
			loc_cSQL = loc_cSQL + " p.emps, p.numes, p.percs, p.valos, p.vlbaixas,"
			loc_cSQL = loc_cSQL + " p.borderos, p.ifors, p.valcreds,"
			loc_cSQL = loc_cSQL + " NVL(f.rclis, '') AS dfors"
			loc_cSQL = loc_cSQL + " FROM SigMvOrp p LEFT JOIN SigCdCli f ON f.iclis = p.ifors"
			loc_cSQL = loc_cSQL + " WHERE p.emps = " + EscaparSQL(THIS.this_cEmps)
			loc_cSQL = loc_cSQL + " AND p.dopes = " + EscaparSQL(THIS.this_cDopes)
			loc_cSQL = loc_cSQL + " AND p.numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0)
			loc_cSQL = loc_cSQL + " ORDER BY p.citens"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParcelasTmp")

			IF loc_nResultado < 0
				MsgErro("Erro ao carregar parcelas do or" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				IF USED(THIS.this_cCursorParcelas)
					SELECT (THIS.this_cCursorParcelas)
					ZAP
					IF USED("cursor_4c_ParcelasTmp") AND RECCOUNT("cursor_4c_ParcelasTmp") > 0
						APPEND FROM DBF("cursor_4c_ParcelasTmp")
					ENDIF
				ENDIF
				loc_lSucesso = .T.
			ENDIF

			IF USED("cursor_4c_ParcelasTmp")
				USE IN cursor_4c_ParcelasTmp
			ENDIF
		CATCH TO loException
			MsgErro(loException.Message, "Erro em sigoporcBO.CarregarParcelas")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

