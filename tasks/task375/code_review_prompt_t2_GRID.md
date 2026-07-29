# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 396: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg) - TRECHOS RELEVANTES PARA PASS GRID (2770 linhas total):

*-- Linhas 66 a 85:
66:                 IF USED("cursor_4c_Dados")
67:                     USE IN cursor_4c_Dados
68:                 ENDIF
69:                 SET NULL ON
70:                 CREATE CURSOR cursor_4c_Dados ( ;
71:                     cidchaves   C(20), ;
72:                     empdopnums  C(29), ;
73:                     emps        C(3),  ;
74:                     dopes       C(20), ;
75:                     numes       N(6,0), ;
76:                     nfis        C(6),  ;
77:                     series      C(8),  ;
78:                     especienfs  C(6),  ;
79:                     emis        T,     ;
80:                     dtsaidas    T,     ;
81:                     datans      T,     ;
82:                     operas      C(1),  ;
83:                     correcs     I,     ;
84:                     cancelas    I,     ;
85:                     regs        I,     ;

*-- Linhas 100 a 118:
100:                     rclis       C(40), ;
101:                     descricaos  C(60) ;
102:                 )
103:                 SET NULL OFF
104: 
105:                 THIS.ConfigurarPageFrame()
106:                 THIS.ConfigurarPaginaLista()
107:                 THIS.ConfigurarPaginaDados()
108:                 THIS.ConfigurarBindings()
109: 
110:                 *-- Propagar caption para label do cabecalho
111:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
113: 
114:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
115:                     IF !THIS.CarregarLista()
116:                         *-- falha nao impede abertura
117:                     ENDIF
118:                 ENDIF

*-- Linhas 352 a 412:
352: 
353:         *-- Grade de notas fiscais (legado: Grade top=224 left=35 w=736 h=410)
354:         *-- Novo: top=166 (abaixo dos filtros), largura total, altura ate fundo da pagina
355:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:         loc_oGrid = loc_oPagina.grd_4c_Lista
357:         WITH loc_oGrid
358:             .Top          = 166
359:             .Left         = 0
360:             .Width        = THIS.Width
361:             .Height       = 461
362:             .ReadOnly     = .T.
363:             .ColumnCount  = 4
364:             .Visible      = .T.
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column1
368:             .ControlSource = "cursor_4c_Dados.nfis"
369:             .Width         = 70
370:             .Alignment     = 2
371:         ENDWITH
372:         loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
373: 
374:         WITH loc_oGrid.Column2
375:             .ControlSource = "cursor_4c_Dados.emis"
376:             .Width         = 95
377:             .Alignment     = 2
378:         ENDWITH
379:         loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
380: 
381:         WITH loc_oGrid.Column3
382:             .ControlSource = "cursor_4c_Dados.totnotas"
383:             .Width         = 120
384:             .Alignment     = 2
385:         ENDWITH
386:         loc_oGrid.Column3.Header1.Caption = "Total NF"
387: 
388:         WITH loc_oGrid.Column4
389:             .ControlSource = "cursor_4c_Dados.rclis"
390:             .Width         = 715
391:             .Alignment     = 2
392:         ENDWITH
393:         loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"
394: 
395:         loc_oGrid.ColumnCount = 3
396:         loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 
398:         *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)
399:         loc_oGrid.SetAll("DynamicForeColor", ;
400:             "IIF(cursor_4c_Dados.correcs > 0, RGB(255,0,0), RGB(0,0,0))", "Column")
401: 
402:         THIS.FormatarGridLista(loc_oGrid)
403: 
404:         THIS.TornarControlesVisiveis(loc_oPagina)
405:     ENDPROC
406: 
407:     *==========================================================================
408:     * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos
409:     * Legado: Dados com Get_dope/Get_nume/Get_nota/etc + Pagina(Impostos+Servicos)
410:     * Compensacao PageFrame: +29 em Top
411:     *==========================================================================
412:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 786 a 804:
786:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")
787: 
788:         *-- Grade: selecao de linha atualiza estado dos botoes
789:         BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")
790: 
791:         *-- Filtros (Page1)
792:         LOCAL loc_oCnt
793:         loc_oCnt = loc_oPg1.cnt_4c_Filtros
794:         BINDEVENT(loc_oCnt.txt_4c_Emp,    "KeyPress",         THIS, "ValidarEmpresa")
795:         BINDEVENT(loc_oCnt.txt_4c_Serie,  "KeyPress",         THIS, "ValidarSerie")
796:         BINDEVENT(loc_oCnt.txt_4c_DtIni,  "KeyPress",         THIS, "ValidarDtIni")
797:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
798:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
799:         BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")
800: 
801:         *-- Salvar/Cancelar (Page2)
802:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
803:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
804: 

*-- Linhas 835 a 858:
835:                 *-- Buscar requer empresa e serie preenchidos para consultar
836:                 IF !EMPTY(ALLTRIM(THIS.this_cEmps)) AND !EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
837:                     IF THIS.this_oBusinessObject.Buscar("")
838:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
839:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
840:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.nfis"
841:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.emis"
842:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.totnotas"
843:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
844:                         loc_lResultado = .T.
845:                     ELSE
846:                         loc_lResultado = .F.
847:                     ENDIF
848:                 ELSE
849:                     *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
850:                     loc_lResultado = .T.
851:                 ENDIF
852:             ENDIF
853: 
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
856:             loc_lResultado = .F.
857:         ENDTRY
858: 

*-- Linhas 1600 a 1620:
1600:                         loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
1601:                         loc_oBusca.this_cCampoChave    = "Cods"
1602:                         loc_oBusca.this_cValorInicial  = loc_cSerie
1603:                         loc_oBusca.mAddColuna("Cods",  "XXXXX",              ;
1604:                             "S" + CHR(233) + "rie")
1605:                         loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXX", ;
1606:                             "Descri" + CHR(231) + CHR(227) + "o")
1607:                         loc_oBusca.Show()
1608: 
1609:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
1610:                             SELECT cursor_4c_BuscaSer
1611:                             THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
1612:                             loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
1613:                             loc_lEncontrou              = .T.
1614:                         ELSE
1615:                             loc_oCnt.txt_4c_Serie.Value = ""
1616:                             THIS.this_cSeriesFiltro     = ""
1617:                         ENDIF
1618:                         loc_oBusca.Release()
1619:                     ENDIF
1620:                 ENDIF

