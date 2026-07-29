# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 364: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 837: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCNF.prg) - TRECHOS RELEVANTES PARA PASS GRID (2765 linhas total):

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

*-- Linhas 350 a 409:
350: 
351:         THIS.ConfigurarFiltros(loc_oPagina)
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
364:             .RecordSource = "cursor_4c_Dados"
365:             .Visible      = .T.
366:         ENDWITH
367: 
368:         WITH loc_oGrid.Column1
369:             .ControlSource = "cursor_4c_Dados.nfis"
370:             .Width         = 70
371:             .Alignment     = 2
372:         ENDWITH
373:         loc_oGrid.Column1.Header1.Caption = "NF N" + CHR(176)
374: 
375:         WITH loc_oGrid.Column2
376:             .ControlSource = "cursor_4c_Dados.emis"
377:             .Width         = 95
378:             .Alignment     = 2
379:         ENDWITH
380:         loc_oGrid.Column2.Header1.Caption = "Emiss" + CHR(227) + "o"
381: 
382:         WITH loc_oGrid.Column3
383:             .ControlSource = "cursor_4c_Dados.totnotas"
384:             .Width         = 120
385:             .Alignment     = 2
386:         ENDWITH
387:         loc_oGrid.Column3.Header1.Caption = "Total NF"
388: 
389:         WITH loc_oGrid.Column4
390:             .ControlSource = "cursor_4c_Dados.rclis"
391:             .Width         = 715
392:             .Alignment     = 2
393:         ENDWITH
394:         loc_oGrid.Column4.Header1.Caption = "Cliente / Fornecedor"
395: 
396:         *-- NFs com carta de correcao em vermelho (legado: DynamicForeColor em Grade)
397:         loc_oGrid.SetAll("DynamicForeColor", ;
398:             "IIF(cursor_4c_Dados.correcs > 0, RGB(255,0,0), RGB(0,0,0))", "Column")
399: 
400:         THIS.FormatarGridLista(loc_oGrid)
401: 
402:         THIS.TornarControlesVisiveis(loc_oPagina)
403:     ENDPROC
404: 
405:     *==========================================================================
406:     * ConfigurarPaginaDados - Page2: campos NF + aba Impostos/Servicos
407:     * Legado: Dados com Get_dope/Get_nume/Get_nota/etc + Pagina(Impostos+Servicos)
408:     * Compensacao PageFrame: +29 em Top
409:     *==========================================================================

*-- Linhas 784 a 802:
784:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_ImpCarta,     "Click", THIS, "BtnImpCartaClick")
785: 
786:         *-- Grade: selecao de linha atualiza estado dos botoes
787:         BINDEVENT(loc_oPg1.grd_4c_Lista, "AfterRowColChange", THIS, "GrdListaAfterRowColChange")
788: 
789:         *-- Filtros (Page1)
790:         LOCAL loc_oCnt
791:         loc_oCnt = loc_oPg1.cnt_4c_Filtros
792:         BINDEVENT(loc_oCnt.txt_4c_Emp,    "KeyPress",         THIS, "ValidarEmpresa")
793:         BINDEVENT(loc_oCnt.txt_4c_Serie,  "KeyPress",         THIS, "ValidarSerie")
794:         BINDEVENT(loc_oCnt.txt_4c_DtIni,  "KeyPress",         THIS, "ValidarDtIni")
795:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "KeyPress",         THIS, "ValidarDtFim")
796:         BINDEVENT(loc_oCnt.txt_4c_DtFim,  "When",              THIS, "DtFimWhenCheck")
797:         BINDEVENT(loc_oCnt.opt_4c_Filtro, "InteractiveChange", THIS, "FiltroChanged")
798: 
799:         *-- Salvar/Cancelar (Page2)
800:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
801:         BINDEVENT(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
802: 

*-- Linhas 823 a 853:
823:                 *-- Repassar filtros para o BO antes de chamar Buscar
824:                 THIS.this_oBusinessObject.this_cEmps           = THIS.this_cEmps
825:                 THIS.this_oBusinessObject.this_cSeriesFiltro   = THIS.this_cSeriesFiltro
826:                 THIS.this_oBusinessObject.this_tEmisDeFiltro   = THIS.this_dEmisDeFiltro
827:                 THIS.this_oBusinessObject.this_tEmisAteFiltro  = THIS.this_dEmisAteFiltro
828:                 THIS.this_oBusinessObject.this_cOpeFiltro      = THIS.this_cOpeFiltro
829:                 THIS.this_oBusinessObject.this_lCancelasFiltro = THIS.this_lCancelasFiltro
830:                 THIS.this_oBusinessObject.this_cNfisDeFiltro   = ""
831:                 THIS.this_oBusinessObject.this_cNfisAteFiltro  = ""
832: 
833:                 *-- Buscar requer empresa e serie preenchidos para consultar
834:                 IF !EMPTY(ALLTRIM(THIS.this_cEmps)) AND !EMPTY(ALLTRIM(THIS.this_cSeriesFiltro))
835:                     IF THIS.this_oBusinessObject.Buscar("")
836:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.ColumnCount = 3
837:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
838:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
839:                         loc_lResultado = .T.
840:                     ELSE
841:                         loc_lResultado = .F.
842:                     ENDIF
843:                 ELSE
844:                     *-- Sem filtros suficientes: lista permanece vazia (nao e erro)
845:                     loc_lResultado = .T.
846:                 ENDIF
847:             ENDIF
848: 
849:         CATCH TO loc_oErro
850:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de NFs")
851:             loc_lResultado = .F.
852:         ENDTRY
853: 

*-- Linhas 1595 a 1615:
1595:                         loc_oBusca.this_cTitulo        = "S" + CHR(233) + "ries"
1596:                         loc_oBusca.this_cCampoChave    = "Cods"
1597:                         loc_oBusca.this_cValorInicial  = loc_cSerie
1598:                         loc_oBusca.mAddColuna("Cods",  "XXXXX",              ;
1599:                             "S" + CHR(233) + "rie")
1600:                         loc_oBusca.mAddColuna("Descs", "XXXXXXXXXXXXXXXXXXXX", ;
1601:                             "Descri" + CHR(231) + CHR(227) + "o")
1602:                         loc_oBusca.Show()
1603: 
1604:                         IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaSer")
1605:                             SELECT cursor_4c_BuscaSer
1606:                             THIS.this_cSeriesFiltro     = ALLTRIM(cursor_4c_BuscaSer.Cods)
1607:                             loc_oCnt.txt_4c_Serie.Value = THIS.this_cSeriesFiltro
1608:                             loc_lEncontrou              = .T.
1609:                         ELSE
1610:                             loc_oCnt.txt_4c_Serie.Value = ""
1611:                             THIS.this_cSeriesFiltro     = ""
1612:                         ENDIF
1613:                         loc_oBusca.Release()
1614:                     ENDIF
1615:                 ENDIF

