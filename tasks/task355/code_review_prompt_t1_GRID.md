# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 899: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCat.prg) - TRECHOS RELEVANTES PARA PASS GRID (1218 linhas total):

*-- Linhas 331 a 369:
331: 
332:         *-- Grid de listagem (Grade no legado)
333:         *-- Colunas: Cods(52), descs(115), gdegrps(50), prazos(50)
334:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPagina.grd_4c_Lista
336: 
337:         loc_oGrid.Top               = 117
338:         loc_oGrid.Left              = 26
339:         loc_oGrid.Width             = 890
340:         loc_oGrid.Height            = 470
341:         loc_oGrid.FontName          = "Verdana"
342:         loc_oGrid.FontSize          = 8
343:         loc_oGrid.ForeColor         = RGB(90, 90, 90)
344:         loc_oGrid.BackColor         = RGB(255, 255, 255)
345:         loc_oGrid.GridLineColor     = RGB(238, 238, 238)
346:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
347:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
348:         loc_oGrid.HighlightStyle    = 2
349:         loc_oGrid.DeleteMark        = .F.
350:         loc_oGrid.RecordMark        = .F.
351:         loc_oGrid.RowHeight         = 16
352:         loc_oGrid.ScrollBars        = 2
353:         loc_oGrid.GridLines         = 3
354:         loc_oGrid.ColumnCount       = 4
355:         loc_oGrid.Visible           = .T.
356: 
357:         *-- BINDEVENTs para botoes CRUD e duplo clique no grid
358:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
359:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
360:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
361:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
362:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
364:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
365: 
366:         THIS.TornarControlesVisiveis(loc_oPagina)
367:     ENDPROC
368: 
369:     *====================================================================

*-- Linhas 689 a 728:
689:                 loc_lSucesso = .T.
690:             ELSE
691:                 IF THIS.this_oBusinessObject.Buscar("")
692:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
693: 
694:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36)
695:                     loc_oGrid.ColumnCount = 3
696:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
697:                     loc_oGrid.ColumnCount  = 4
698: 
699:                     WITH loc_oGrid
700:                         .Column1.ControlSource = "cursor_4c_Dados.cods"
701:                         .Column2.ControlSource = "cursor_4c_Dados.descs"
702:                         .Column3.ControlSource = "cursor_4c_Dados.gdegrps"
703:                         .Column4.ControlSource = "cursor_4c_Dados.prazos"
704: 
705:                         .Column1.Width = 70
706:                         .Column2.Width = 200
707:                         .Column3.Width = 80
708:                         .Column4.Width = 60
709: 
710:                         .Column1.Header1.Caption = "C" + CHR(243) + "digos"
711:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
712:                         .Column3.Header1.Caption = "Gde. Grp"
713:                         .Column4.Header1.Caption = "Prazo"
714: 
715:                         .Column1.ReadOnly = .T.
716:                         .Column2.ReadOnly = .T.
717:                         .Column3.ReadOnly = .T.
718:                         .Column4.ReadOnly = .T.
719:                     ENDWITH
720: 
721:                     THIS.FormatarGridLista(loc_oGrid)
722:                     loc_lSucesso = .T.
723:                 ENDIF
724:             ENDIF
725:         CATCH TO loc_oErro
726:             MsgErro("Erro ao carregar lista:" + CHR(13) + loc_oErro.Message, "Erro")
727:         ENDTRY
728: 

*-- Linhas 875 a 918:
875: 
876:             IF VARTYPE(loc_oBusca) = "O"
877:                 IF !loc_oBusca.this_lAchouRegistro
878:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
879:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
880:                     loc_oBusca.Show()
881:                 ENDIF
882: 
883:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
884:                     SELECT cursor_4c_BuscaCat
885:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaCat.cods)
886:                 ENDIF
887: 
888:                 loc_oBusca.Release()
889:             ENDIF
890: 
891:             IF USED("cursor_4c_BuscaCat")
892:                 USE IN cursor_4c_BuscaCat
893:             ENDIF
894: 
895:             IF !EMPTY(loc_cFiltro)
896:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
897:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
898:                     loc_oGrid.ColumnCount = 3
899:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
900:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
901:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
902:                     loc_oGrid.Column3.Header1.Caption = "Gde. Grp"
903:                     loc_oGrid.Column4.Header1.Caption = "Prazo"
904:                     loc_oGrid.Refresh()
905:                 ENDIF
906:             ENDIF
907: 
908:         CATCH TO loc_oErro
909:             MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "Erro")
910:             IF USED("cursor_4c_BuscaCat")
911:                 USE IN cursor_4c_BuscaCat
912:             ENDIF
913:         ENDTRY
914:     ENDPROC
915: 
916:     *====================================================================
917:     * BtnEncerrarClick - Fechar o formulario
918:     *====================================================================

*-- Linhas 1180 a 1199:
1180: 
1181:             IF VARTYPE(loc_oBusca) = "O"
1182:                 IF !loc_oBusca.this_lAchouRegistro
1183:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1184:                     loc_oBusca.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1185:                     loc_oBusca.Show()
1186:                 ENDIF
1187: 
1188:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGdeGrp")
1189:                     SELECT cursor_4c_BuscaGdeGrp
1190:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGdeGrp.codigos)
1191:                     loc_oPg2.txt_4c_GdeGrp.Value = loc_cCodigo
1192:                 ENDIF
1193: 
1194:                 loc_oBusca.Release()
1195:             ENDIF
1196: 
1197:             IF USED("cursor_4c_BuscaGdeGrp")
1198:                 USE IN cursor_4c_BuscaGdeGrp
1199:             ENDIF

