# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 928: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormProduto.prg) - TRECHOS RELEVANTES PARA PASS GRID (12506 linhas total):

*-- Linhas 331 a 354:
331:             IF USED("cursor_4c_Lista")
332:                 USE IN cursor_4c_Lista
333:             ENDIF
334:             CREATE CURSOR cursor_4c_Lista (;
335:                 CPros    C(14),  ;
336:                 DPros    C(40),  ;
337:                 DPro2s   C(30),  ;
338:                 CGrus    C(10),  ;
339:                 DGrus    C(30),  ;
340:                 SGrus    C(10),  ;
341:                 Reffs    C(30),  ;
342:                 UsuaAlts C(15),  ;
343:                 Instalas N(1,0)  ;
344:             )
345: 
346:             *-- Container de filtros (cntFiltros no legado) - Top = 82+29 = 111
347:             par_oPage.AddObject("cnt_4c_Filtros", "Container")
348:             WITH par_oPage.cnt_4c_Filtros
349:                 .Top         = 111
350:                 .Left        = 2
351:                 .Width       = 395
352:                 .Height      = 68
353:                 .BackStyle   = 0
354:                 .BorderStyle = 1

*-- Linhas 895 a 951:
895: 
896:             *-- Grid principal (Grade no legado)
897:             *-- Top = 182 (82+29 cntFiltros + 68 altura + 3 gap + compensacao)
898:             *-- RecordSource e colunas definidos FORA de WITH (critico VFP9)
899:             par_oPage.AddObject("grd_4c_Lista", "Grid")
900:             par_oPage.grd_4c_Lista.Top               = 182
901:             par_oPage.grd_4c_Lista.Left              = 2
902:             par_oPage.grd_4c_Lista.Width             = 930
903:             par_oPage.grd_4c_Lista.Height            = 390
904:             par_oPage.grd_4c_Lista.ColumnCount       = 7
905:             par_oPage.grd_4c_Lista.FontName          = "Verdana"
906:             par_oPage.grd_4c_Lista.FontSize          = 8
907:             par_oPage.grd_4c_Lista.ForeColor         = RGB(90,90,90)
908:             par_oPage.grd_4c_Lista.BackColor         = RGB(255,255,255)
909:             par_oPage.grd_4c_Lista.GridLineColor     = RGB(238,238,238)
910:             par_oPage.grd_4c_Lista.GridLines         = 3
911:             par_oPage.grd_4c_Lista.HighlightBackColor = RGB(255,255,255)
912:             par_oPage.grd_4c_Lista.HighlightForeColor = RGB(15,41,104)
913:             par_oPage.grd_4c_Lista.HighlightStyle   = 2
914:             par_oPage.grd_4c_Lista.DeleteMark        = .F.
915:             par_oPage.grd_4c_Lista.RecordMark        = .F.
916:             par_oPage.grd_4c_Lista.RowHeight         = 16
917:             par_oPage.grd_4c_Lista.ScrollBars        = 2
918:             par_oPage.grd_4c_Lista.Themes            = .F.
919:             par_oPage.grd_4c_Lista.Visible           = .T.
920: 
921:             *-- CheckBox na Column7 ANTES de RecordSource
922:             par_oPage.grd_4c_Lista.Column7.AddObject("Check1", "CheckBox")
923:             par_oPage.grd_4c_Lista.Column7.CurrentControl = "Check1"
924:             par_oPage.grd_4c_Lista.Column7.Check1.Themes  = .F.
925:             par_oPage.grd_4c_Lista.Column7.Check1.Value   = 0
926: 
927:             *-- RecordSource FORA de WITH (critico: evita "Unknown member COLUMN1")
928:             par_oPage.grd_4c_Lista.RecordSource = "cursor_4c_Lista"
929: 
930:             *-- Configurar colunas APOS RecordSource (evita reset de headers/ControlSource)
931:             THIS.FormatarGridLista(par_oPage.grd_4c_Lista)
932: 
933:         CATCH TO loc_oErro
934:             MsgErro(loc_oErro.Message, "Erro ao configurar Page1")
935:         ENDTRY
936:     ENDPROC
937: 
938:     *--------------------------------------------------------------------------
939:     PROTECTED PROCEDURE ConfigurarPage2(par_oPage)
940:         LOCAL loc_oContainer
941:         TRY
942:             *-- Botoes de acao (Grupo_Salva no legado) - Top = 9+29 = 38
943:             par_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
944:             WITH par_oPage.cnt_4c_BotoesAcao
945:                 .Top         = 38
946:                 .Left        = 842
947:                 .Width       = 160
948:                 .Height      = 85
949:                 .BackStyle = 1
950:                 .BackColor = RGB(53, 53, 53)
951:                 .BorderStyle = 0

*-- Linhas 1044 a 1116:
1044:         TRY
1045:             loc_oGrid = par_oGrid
1046: 
1047:             *-- Column1: Produto (CPros)
1048:             loc_oGrid.Column1.Header1.Caption  = "Produto"
1049:             loc_oGrid.Column1.ControlSource    = "cursor_4c_Lista.CPros"
1050:             loc_oGrid.Column1.Width            = 80
1051:             loc_oGrid.Column1.ReadOnly         = .T.
1052:             loc_oGrid.Column1.Header1.FontBold = .T.
1053: 
1054:             *-- Column2: Descricao (DPros)
1055:             loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
1056:             loc_oGrid.Column2.ControlSource    = "cursor_4c_Lista.DPros"
1057:             loc_oGrid.Column2.Width            = 250
1058:             loc_oGrid.Column2.ReadOnly         = .T.
1059:             loc_oGrid.Column2.Header1.FontBold = .T.
1060: 
1061:             *-- Column3: Grupo (DGrus - descricao do grupo via JOIN)
1062:             loc_oGrid.Column3.Header1.Caption  = "Grupo"
1063:             loc_oGrid.Column3.ControlSource    = "cursor_4c_Lista.DGrus"
1064:             loc_oGrid.Column3.Width            = 100
1065:             loc_oGrid.Column3.ReadOnly         = .T.
1066:             loc_oGrid.Column3.Header1.FontBold = .T.
1067: 
1068:             *-- Column4: Subgrupo (SGrus)
1069:             loc_oGrid.Column4.Header1.Caption  = "Subgrp."
1070:             loc_oGrid.Column4.ControlSource    = "cursor_4c_Lista.SGrus"
1071:             loc_oGrid.Column4.Width            = 70
1072:             loc_oGrid.Column4.ReadOnly         = .T.
1073:             loc_oGrid.Column4.Header1.FontBold = .T.
1074: 
1075:             *-- Column5: Ref. Fornecedor (Reffs)
1076:             loc_oGrid.Column5.Header1.Caption  = "Ref. Fornecedor"
1077:             loc_oGrid.Column5.ControlSource    = "cursor_4c_Lista.Reffs"
1078:             loc_oGrid.Column5.Width            = 180
1079:             loc_oGrid.Column5.ReadOnly         = .T.
1080:             loc_oGrid.Column5.Header1.FontBold = .T.
1081: 
1082:             *-- Column6: Usuario (UsuaAlts)
1083:             loc_oGrid.Column6.Header1.Caption  = "Usu" + CHR(225) + "rio"
1084:             loc_oGrid.Column6.ControlSource    = "cursor_4c_Lista.UsuaAlts"
1085:             loc_oGrid.Column6.Width            = 100
1086:             loc_oGrid.Column6.ReadOnly         = .T.
1087:             loc_oGrid.Column6.Header1.FontBold = .T.
1088: 
1089:             *-- Column7: Instalacao - CheckBox (Instalas)
1090:             *-- ControlSource definido na Column (NAO no Check1) - evita Error 1767
1091:             loc_oGrid.Column7.Header1.Caption  = "I"
1092:             loc_oGrid.Column7.ControlSource    = "cursor_4c_Lista.Instalas"
1093:             loc_oGrid.Column7.Width            = 30
1094:             loc_oGrid.Column7.ReadOnly         = .T.
1095:             loc_oGrid.Column7.Header1.FontBold = .T.
1096:             loc_oGrid.Column7.Alignment        = 2
1097: 
1098:         CATCH TO loc_oErro
1099:             MsgErro(loc_oErro.Message, "Erro ao formatar grid lista")
1100:         ENDTRY
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     * AlternarPagina - Troca entre Page1 (Lista) e Page2 (Dados)
1105:     *--------------------------------------------------------------------------
1106:     PROCEDURE AlternarPagina(par_nPagina)
1107:         LOCAL loc_oErro
1108:         TRY
1109:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1110:             this_cModoAtual = IIF(par_nPagina = 1, "LISTA", "DADOS")
1111:         CATCH TO loc_oErro
1112:             MsgErro(loc_oErro.Message, "Erro ao alternar p" + CHR(225) + "gina")
1113:         ENDTRY
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------

*-- Linhas 1222 a 1245:
1222:                 *-- Posicionar no inicio e atualizar contador
1223:                 SELECT cursor_4c_Lista
1224:                 GO TOP
1225:                 loc_oPage1.grd_4c_Lista.Refresh()
1226:                 loc_nCount = RECCOUNT("cursor_4c_Lista")
1227:                 loc_oPage1.lbl_4c_Produtos.Caption = ;
1228:                     "Produtos Selecionados : " + LTRIM(STR(loc_nCount))
1229:             ENDIF
1230: 
1231:         CATCH TO loc_oErro
1232:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de produtos")
1233:         ENDTRY
1234:     ENDPROC
1235: 
1236:     *--------------------------------------------------------------------------
1237:     * ConfigurarEventos - BINDEVENT para botoes e filtros
1238:     * IMPORTANTE: todos os handlers devem ser PUBLIC
1239:     *--------------------------------------------------------------------------
1240:     PROTECTED PROCEDURE ConfigurarEventos()
1241:         LOCAL loc_oPage1, loc_oPage2, loc_oErro
1242:         TRY
1243:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
1244:             loc_oPage2 = THIS.pgf_4c_Paginas.Page2
1245: 

*-- Linhas 1256 a 1279:
1256:             BINDEVENT(loc_oPage2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1257: 
1258:             *-- Grid DblClick -> Alterar
1259:             BINDEVENT(loc_oPage1.grd_4c_Lista, "DblClick", THIS, "GridDblClick")
1260: 
1261:             *-- Filtro de grupo: KeyPress (NUNCA LostFocus - causa recursao infinita)
1262:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo, ;
1263:                       "KeyPress", THIS, "FiltroGrupoKeyPress")
1264: 
1265:             *-- Filtro data final: KeyPress (ENTER/TAB recarrega lista)
1266:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.txt_4c_DtAlterFim, ;
1267:                       "KeyPress", THIS, "FiltroDataFimKeyPress")
1268: 
1269:             *-- OptionGroup situacao: InteractiveChange recarrega lista
1270:             BINDEVENT(loc_oPage1.cnt_4c_Filtros.opt_4c_Situacao, ;
1271:                       "InteractiveChange", THIS, "FiltroSituacaoChange")
1272: 
1273:             *-- OptionGroup de navegacao interna das paginas de dados
1274:             BINDEVENT(loc_oPage2.obj_4c_Optiongroup1, ;
1275:                       "InteractiveChange", THIS, "NavegacaoDadosChange")
1276: 
1277:             *-- Lookups da pagina de dados (pgf_4c_DadosInterno.Page1)
1278:             LOCAL loc_oPgDados
1279:             loc_oPgDados = loc_oPage2.pgf_4c_DadosInterno.Page1

*-- Linhas 1338 a 1388:
1338:             LOCAL loc_oPgComp
1339:             loc_oPgComp = loc_oPage2.pgf_4c_DadosInterno.Page2
1340: 
1341:             BINDEVENT(loc_oPgComp.grd_4c_Compo,             "AfterRowColChange", THIS, "CompoAfterRowColChange")
1342:             BINDEVENT(loc_oPgComp.grd_4c_SubCp,             "AfterRowColChange", THIS, "SubCpAfterRowColChange")
1343:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaCusto,    "InteractiveChange", THIS, "LiberaCustoChange")
1344:             BINDEVENT(loc_oPgComp.chk_4c_ChkLiberaVenda,    "InteractiveChange", THIS, "LiberaVendaChange")
1345:             BINDEVENT(loc_oPgComp.txt_4c_Moec,              "KeyPress", THIS, "MoecKeyPress")
1346:             BINDEVENT(loc_oPgComp.txt_4c_Moepc,             "KeyPress", THIS, "MoepcKeyPress")
1347:             BINDEVENT(loc_oPgComp.txt_4c_Moecusf,           "KeyPress", THIS, "MoecusfKeyPress")
1348:             BINDEVENT(loc_oPgComp.txt_4c_Moeda,             "KeyPress", THIS, "MoedaKeyPress")
1349:             BINDEVENT(loc_oPgComp.txt_4c_Moepv,             "KeyPress", THIS, "MoepvKeyPress")
1350:             BINDEVENT(loc_oPgComp.txt_4c_Moev,              "KeyPress", THIS, "MoevKeyPress")
1351:             BINDEVENT(loc_oPgComp.txt_4c_Ftio,              "KeyPress", THIS, "FtioKeyPress")
1352:             BINDEVENT(loc_oPgComp.txt_4c_Margem,            "KeyPress", THIS, "MargemKeyPress")
1353:             BINDEVENT(loc_oPgComp.txt_4c_Cmkpc,             "KeyPress", THIS, "CmkpcKeyPress")
1354:             BINDEVENT(loc_oPgComp.cmd_4c_CmdCalcVals,       "Click",    THIS, "CalcValsClick")
1355:             BINDEVENT(loc_oPgComp.cmd_4c_CmdPesoM,          "Click",    THIS, "PesoMClick")
1356:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(1), "Click",    THIS, "CompoIncluirClick")
1357:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(2), "Click",    THIS, "CompoExcluirClick")
1358:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(3), "Click",    THIS, "CompoAtualizaClick")
1359:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(4), "Click",    THIS, "CompoCopiarClick")
1360:             BINDEVENT(loc_oPgComp.cmdg_4c_Compo.Buttons(5), "Click",    THIS, "CompoGrupoClick")
1361:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(1), "Click",    THIS, "SubCpIncluirClick")
1362:             BINDEVENT(loc_oPgComp.cmdg_4c_SubCp.Buttons(2), "Click",    THIS, "SubCpExcluirClick")
1363: 
1364:             *-- === Custo (Page6 do inner pageframe) ===
1365:             LOCAL loc_oPgCusto
1366:             loc_oPgCusto = loc_oPage2.pgf_4c_DadosInterno.Page6
1367: 
1368:             BINDEVENT(loc_oPgCusto.grd_4c_GrdCustoCompo,           "AfterRowColChange", THIS, "GrdCustoCompoAfterRowColChange")
1369:             BINDEVENT(loc_oPgCusto.cbo_4c_CmbTipos,                 "InteractiveChange", THIS, "CboTiposCustoInteractiveChange")
1370:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(1),  "Click", THIS, "CustoCompoIncluirClick")
1371:             BINDEVENT(loc_oPgCusto.cmdg_4c_CustoCompo.Buttons(2),  "Click", THIS, "CustoCompoExcluirClick")
1372: 
1373:             *-- === DadosFiscais (Page3 do inner pageframe) ===
1374:             LOCAL loc_oPgFisc
1375:             loc_oPgFisc = loc_oPage2.pgf_4c_DadosInterno.Page3
1376: 
1377:             BINDEVENT(loc_oPgFisc.txt_4c__gruccus,   "KeyPress", THIS, "GruccusFiscKeyPress")
1378:             BINDEVENT(loc_oPgFisc.txt_4c__dgruccus,  "KeyPress", THIS, "DgruccusFiscKeyPress")
1379:             BINDEVENT(loc_oPgFisc.txt_4c__contaccus, "KeyPress", THIS, "ContaccusFiscKeyPress")
1380:             BINDEVENT(loc_oPgFisc.txt_4c__dcontaccus,"KeyPress", THIS, "DcontaccusFiscKeyPress")
1381:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "KeyPress", THIS, "ClfiscalKeyPress")
1382:             BINDEVENT(loc_oPgFisc.txt_4c_Clfiscal,   "DblClick", THIS, "ClfiscalDblClick")
1383:             BINDEVENT(loc_oPgFisc.txt_4c_Dclfiscal,  "KeyPress", THIS, "DclfiscalKeyPress")
1384:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "KeyPress", THIS, "OrigmercKeyPress")
1385:             BINDEVENT(loc_oPgFisc.txt_4c_Origmerc,   "DblClick", THIS, "OrigmercDblClick")
1386:             BINDEVENT(loc_oPgFisc.txt_4c_Dorigmerc,  "KeyPress", THIS, "DorigmercKeyPress")
1387:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "KeyPress", THIS, "SittricmKeyPress")
1388:             BINDEVENT(loc_oPgFisc.txt_4c_Sittricm,   "DblClick", THIS, "SittricmDblClick")

*-- Linhas 4739 a 4763:
4739:                 "cursor_4c_BuscaGrpFlt", "CGrus", ;
4740:                 ALLTRIM(loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value), ;
4741:                 "Grupo de Produto")
4742:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4743:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4744:             loc_oBusca.Show()
4745:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrpFlt")
4746:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaGrpFlt.CGrus)
4747:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaGrpFlt.DGrus)
4748:                 loc_oPage1.cnt_4c_Filtros.txt_4c_CodGrupo.Value = loc_cCodigo
4749:                 loc_oPage1.cnt_4c_Filtros.txt_4c_DesGrupo.Value = loc_cDescricao
4750:             ENDIF
4751:             IF USED("cursor_4c_BuscaGrpFlt")
4752:                 USE IN cursor_4c_BuscaGrpFlt
4753:             ENDIF
4754:             loc_oBusca.Release()
4755:         CATCH TO loc_oErro
4756:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo (filtro)")
4757:         ENDTRY
4758:     ENDPROC
4759: 
4760:     *==========================================================================
4761:     * FASE 6: Lookup Handlers e Metodos AbrirLookup
4762:     * Todos os handlers sao PUBLIC (obrigatorio para BINDEVENT)
4763:     * Todos os AbrirLookup sao PROTECTED

*-- Linhas 4792 a 4816:
4792:                 "cursor_4c_BuscaCProEq", "CPros", ;
4793:                 ALLTRIM(loc_oPgDados.txt_4c_CProEq.Value), ;
4794:                 "Produto Equivalente")
4795:             loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
4796:             loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
4797:             loc_oBusca.Show()
4798:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCProEq")
4799:                 loc_oPgDados.txt_4c_CProEq.Value = ALLTRIM(cursor_4c_BuscaCProEq.CPros)
4800:             ENDIF
4801:             IF USED("cursor_4c_BuscaCProEq")
4802:                 USE IN cursor_4c_BuscaCProEq
4803:             ENDIF
4804:             loc_oBusca.Release()
4805:         CATCH TO loc_oErro
4806:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup produto equivalente")
4807:         ENDTRY
4808:     ENDPROC
4809: 
4810:     *-- Grupo Produto (SigCdGrp: CGrus / DGrus)
4811:     PROCEDURE CgruKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4812:         TRY
4813:             IF par_nKeyCode = 115
4814:                 THIS.AbrirLookupCgru()
4815:             ELSE
4816:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9

*-- Linhas 4840 a 4864:
4840:                 "cursor_4c_BuscaCgru", "CGrus", ;
4841:                 ALLTRIM(loc_oPgDados.txt_4c_Cgru.Value), ;
4842:                 "Grupo de Produto")
4843:             loc_oBusca.mAddColuna("CGrus", "", "C" + CHR(243) + "digo")
4844:             loc_oBusca.mAddColuna("DGrus", "", "Descri" + CHR(231) + CHR(227) + "o")
4845:             loc_oBusca.Show()
4846:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCgru")
4847:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCgru.CGrus)
4848:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCgru.DGrus)
4849:                 loc_oPgDados.txt_4c_Cgru.Value = loc_cCodigo
4850:                 loc_oPgDados.txt_4c_Dgru.Value = loc_cDescricao
4851:             ENDIF
4852:             IF USED("cursor_4c_BuscaCgru")
4853:                 USE IN cursor_4c_BuscaCgru
4854:             ENDIF
4855:             loc_oBusca.Release()
4856:         CATCH TO loc_oErro
4857:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de produto")
4858:         ENDTRY
4859:     ENDPROC
4860: 
4861:     PROTECTED PROCEDURE ValidarCgruDados()
4862:         LOCAL loc_oPgDados, loc_cCodGru, loc_nRet, loc_oErro
4863:         TRY
4864:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 4949 a 4973:
4949:                 "cursor_4c_BuscaCSGru2", "Codigos", ;
4950:                 ALLTRIM(loc_oPgDados.txt_4c_CSGru.Value), ;
4951:                 "Subgrupo")
4952:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
4953:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
4954:             loc_oBusca.Show()
4955:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCSGru2")
4956:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCSGru2.Codigos)
4957:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCSGru2.Descricaos)
4958:                 loc_oPgDados.txt_4c_CSGru.Value = loc_cCodigo
4959:                 loc_oPgDados.txt_4c_DsGru.Value = loc_cDescricao
4960:             ENDIF
4961:             IF USED("cursor_4c_BuscaCSGru")
4962:                 USE IN cursor_4c_BuscaCSGru
4963:             ENDIF
4964:             IF USED("cursor_4c_BuscaCSGru2")
4965:                 USE IN cursor_4c_BuscaCSGru2
4966:             ENDIF
4967:             loc_oBusca.Release()
4968:         CATCH TO loc_oErro
4969:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup subgrupo")
4970:         ENDTRY
4971:     ENDPROC
4972: 
4973:     PROTECTED PROCEDURE ValidarCSGruDados()

*-- Linhas 5034 a 5058:
5034:                 "cursor_4c_BuscaLin", "Linhas", ;
5035:                 ALLTRIM(loc_oPgDados.txt_4c_Lin.Value), ;
5036:                 "Linha")
5037:             loc_oBusca.mAddColuna("Linhas", "", "C" + CHR(243) + "digo")
5038:             loc_oBusca.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
5039:             loc_oBusca.Show()
5040:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLin")
5041:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaLin.Linhas)
5042:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaLin.Descs)
5043:                 loc_oPgDados.txt_4c_Lin.Value  = loc_cCodigo
5044:                 loc_oPgDados.txt_4c_DLin.Value = loc_cDescricao
5045:             ENDIF
5046:             IF USED("cursor_4c_BuscaLin")
5047:                 USE IN cursor_4c_BuscaLin
5048:             ENDIF
5049:             loc_oBusca.Release()
5050:         CATCH TO loc_oErro
5051:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup linha")
5052:         ENDTRY
5053:     ENDPROC
5054: 
5055:     PROTECTED PROCEDURE ValidarLinDados()
5056:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5057:         TRY
5058:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5116 a 5140:
5116:                 "cursor_4c_BuscaCol", "Colecoes", ;
5117:                 ALLTRIM(loc_oPgDados.txt_4c_Col.Value), ;
5118:                 "Grupo de Venda")
5119:             loc_oBusca.mAddColuna("Colecoes", "", "C" + CHR(243) + "digo")
5120:             loc_oBusca.mAddColuna("Descs",    "", "Descri" + CHR(231) + CHR(227) + "o")
5121:             loc_oBusca.Show()
5122:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCol")
5123:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
5124:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCol.Descs)
5125:                 loc_oPgDados.txt_4c_Col.Value  = loc_cCodigo
5126:                 loc_oPgDados.txt_4c_DCol.Value = loc_cDescricao
5127:             ENDIF
5128:             IF USED("cursor_4c_BuscaCol")
5129:                 USE IN cursor_4c_BuscaCol
5130:             ENDIF
5131:             loc_oBusca.Release()
5132:         CATCH TO loc_oErro
5133:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup grupo de venda")
5134:         ENDTRY
5135:     ENDPROC
5136: 
5137:     PROTECTED PROCEDURE ValidarColDados()
5138:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5139:         TRY
5140:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5198 a 5222:
5198:                 "cursor_4c_BuscaIfor", "IClis", ;
5199:                 ALLTRIM(loc_oPgDados.txt_4c_Ifor.Value), ;
5200:                 "Fornecedor")
5201:             loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
5202:             loc_oBusca.mAddColuna("RClis", "", "Nome")
5203:             loc_oBusca.Show()
5204:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIfor")
5205:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaIfor.IClis)
5206:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaIfor.RClis)
5207:                 loc_oPgDados.txt_4c_Ifor.Value = loc_cCodigo
5208:                 loc_oPgDados.txt_4c_Dfor.Value = loc_cDescricao
5209:             ENDIF
5210:             IF USED("cursor_4c_BuscaIfor")
5211:                 USE IN cursor_4c_BuscaIfor
5212:             ENDIF
5213:             loc_oBusca.Release()
5214:         CATCH TO loc_oErro
5215:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup fornecedor")
5216:         ENDTRY
5217:     ENDPROC
5218: 
5219:     PROTECTED PROCEDURE ValidarIforDados()
5220:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5221:         TRY
5222:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5276 a 5300:
5276:                 "cursor_4c_BuscaCor", "Cods", ;
5277:                 ALLTRIM(loc_oPgDados.txt_4c_CorPro.Value), ;
5278:                 "Cor")
5279:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5280:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5281:             loc_oBusca.Show()
5282:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor")
5283:                 loc_oPgDados.txt_4c_CorPro.Value = ALLTRIM(cursor_4c_BuscaCor.Cods)
5284:             ENDIF
5285:             IF USED("cursor_4c_BuscaCor")
5286:                 USE IN cursor_4c_BuscaCor
5287:             ENDIF
5288:             loc_oBusca.Release()
5289:         CATCH TO loc_oErro
5290:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup cor")
5291:         ENDTRY
5292:     ENDPROC
5293: 
5294:     *-- Tamanho (SigCdTam: Cods / Descs)
5295:     PROCEDURE TamKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5296:         TRY
5297:             IF par_nKeyCode = 115
5298:                 THIS.AbrirLookupTam()
5299:             ENDIF
5300:         CATCH TO loc_oErro

*-- Linhas 5320 a 5344:
5320:                 "cursor_4c_BuscaTam", "Cods", ;
5321:                 ALLTRIM(loc_oPgDados.txt_4c_Tam.Value), ;
5322:                 "Tamanho")
5323:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5324:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5325:             loc_oBusca.Show()
5326:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam")
5327:                 loc_oPgDados.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTam.Cods)
5328:             ENDIF
5329:             IF USED("cursor_4c_BuscaTam")
5330:                 USE IN cursor_4c_BuscaTam
5331:             ENDIF
5332:             loc_oBusca.Release()
5333:         CATCH TO loc_oErro
5334:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tamanho")
5335:         ENDTRY
5336:     ENDPROC
5337: 
5338:     *-- Finalidade (SigCdFip: Cods / Descs)
5339:     PROCEDURE CodFinPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5340:         TRY
5341:             IF par_nKeyCode = 115
5342:                 THIS.AbrirLookupCodFinP()
5343:             ELSE
5344:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9

*-- Linhas 5368 a 5392:
5368:                 "cursor_4c_BuscaFinP", "Cods", ;
5369:                 ALLTRIM(loc_oPgDados.txt_4c_CodFinP.Value), ;
5370:                 "Finalidade")
5371:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
5372:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5373:             loc_oBusca.Show()
5374:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFinP")
5375:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaFinP.Cods)
5376:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaFinP.Descs)
5377:                 loc_oPgDados.txt_4c_CodFinP.Value = loc_cCodigo
5378:                 loc_oPgDados.txt_4c_DesFinP.Value = loc_cDescricao
5379:             ENDIF
5380:             IF USED("cursor_4c_BuscaFinP")
5381:                 USE IN cursor_4c_BuscaFinP
5382:             ENDIF
5383:             loc_oBusca.Release()
5384:         CATCH TO loc_oErro
5385:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup finalidade")
5386:         ENDTRY
5387:     ENDPROC
5388: 
5389:     PROTECTED PROCEDURE ValidarCodFinPDados()
5390:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5391:         TRY
5392:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5450 a 5474:
5450:                 "cursor_4c_BuscaAcb", "Cods", ;
5451:                 ALLTRIM(loc_oPgDados.txt_4c_CodAcb.Value), ;
5452:                 "Acabamento")
5453:             loc_oBusca.mAddColuna("Cods",   "", "C" + CHR(243) + "digo")
5454:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
5455:             loc_oBusca.Show()
5456:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
5457:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcb.Cods)
5458:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcb.Descrs)
5459:                 loc_oPgDados.txt_4c_CodAcb.Value = loc_cCodigo
5460:                 loc_oPgDados.txt_4c_DesAcb.Value = loc_cDescricao
5461:             ENDIF
5462:             IF USED("cursor_4c_BuscaAcb")
5463:                 USE IN cursor_4c_BuscaAcb
5464:             ENDIF
5465:             loc_oBusca.Release()
5466:         CATCH TO loc_oErro
5467:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup acabamento")
5468:         ENDTRY
5469:     ENDPROC
5470: 
5471:     PROTECTED PROCEDURE ValidarCodAcbDados()
5472:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5473:         TRY
5474:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5541 a 5565:
5541:                 "cursor_4c_BuscaClass", "Cods", ;
5542:                 ALLTRIM(loc_oPgDados.txt_4c_Class.Value), ;
5543:                 "Classifica" + CHR(231) + CHR(227) + "o")
5544:             loc_oBusca.mAddColuna("Cods", "", "C" + CHR(243) + "digo")
5545:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
5546:             loc_oBusca.Show()
5547:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClass")
5548:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaClass.Cods)
5549:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaClass.Descs)
5550:                 loc_oPgDados.txt_4c_Class.Value  = loc_cCodigo
5551:                 loc_oPgDados.txt_4c_DClass.Value = loc_cDescricao
5552:             ENDIF
5553:             IF USED("cursor_4c_BuscaClass")
5554:                 USE IN cursor_4c_BuscaClass
5555:             ENDIF
5556:             loc_oBusca.Release()
5557:         CATCH TO loc_oErro
5558:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o")
5559:         ENDTRY
5560:     ENDPROC
5561: 
5562:     PROTECTED PROCEDURE ValidarClassDados()
5563:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5564:         TRY
5565:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5619 a 5643:
5619:                 "cursor_4c_BuscaLocal", "Codigos", ;
5620:                 ALLTRIM(loc_oPgDados.txt_4c_Local.Value), ;
5621:                 "Localiza" + CHR(231) + CHR(227) + "o")
5622:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
5623:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
5624:             loc_oBusca.Show()
5625:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLocal")
5626:                 loc_oPgDados.txt_4c_Local.Value = ALLTRIM(cursor_4c_BuscaLocal.Codigos)
5627:             ENDIF
5628:             IF USED("cursor_4c_BuscaLocal")
5629:                 USE IN cursor_4c_BuscaLocal
5630:             ENDIF
5631:             loc_oBusca.Release()
5632:         CATCH TO loc_oErro
5633:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup local")
5634:         ENDTRY
5635:     ENDPROC
5636: 
5637:     *-- Unidade 1 (SigCdUni: CUnis / DUnis)
5638:     PROCEDURE CuniKeyPress(par_nKeyCode, par_nShiftAltCtrl)
5639:         TRY
5640:             IF par_nKeyCode = 115
5641:                 THIS.AbrirLookupCuni()
5642:             ELSE
5643:                 IF par_nKeyCode = 13 OR par_nKeyCode = 9

*-- Linhas 5667 a 5691:
5667:                 "cursor_4c_BuscaCuni", "CUnis", ;
5668:                 ALLTRIM(loc_oPgDados.txt_4c_Cuni.Value), ;
5669:                 "Unidade (1)")
5670:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5671:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5672:             loc_oBusca.Show()
5673:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCuni")
5674:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCuni.CUnis)
5675:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCuni.DUnis)
5676:                 loc_oPgDados.txt_4c_Cuni.Value = loc_cCodigo
5677:                 loc_oPgDados.txt_4c_Duni.Value = loc_cDescricao
5678:             ENDIF
5679:             IF USED("cursor_4c_BuscaCuni")
5680:                 USE IN cursor_4c_BuscaCuni
5681:             ENDIF
5682:             loc_oBusca.Release()
5683:         CATCH TO loc_oErro
5684:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 1")
5685:         ENDTRY
5686:     ENDPROC
5687: 
5688:     PROTECTED PROCEDURE ValidarCuniDados()
5689:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5690:         TRY
5691:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5749 a 5773:
5749:                 "cursor_4c_BuscaCunip", "CUnis", ;
5750:                 ALLTRIM(loc_oPgDados.txt_4c_Cunip.Value), ;
5751:                 "Unidade (2)")
5752:             loc_oBusca.mAddColuna("CUnis", "", "C" + CHR(243) + "digo")
5753:             loc_oBusca.mAddColuna("DUnis", "", "Descri" + CHR(231) + CHR(227) + "o")
5754:             loc_oBusca.Show()
5755:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCunip")
5756:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCunip.CUnis)
5757:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCunip.DUnis)
5758:                 loc_oPgDados.txt_4c_Cunip.Value = loc_cCodigo
5759:                 loc_oPgDados.txt_4c_Dunip.Value = loc_cDescricao
5760:             ENDIF
5761:             IF USED("cursor_4c_BuscaCunip")
5762:                 USE IN cursor_4c_BuscaCunip
5763:             ENDIF
5764:             loc_oBusca.Release()
5765:         CATCH TO loc_oErro
5766:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup unidade 2")
5767:         ENDTRY
5768:     ENDPROC
5769: 
5770:     PROTECTED PROCEDURE ValidarCunipDados()
5771:         LOCAL loc_oPgDados, loc_cCod, loc_nRet, loc_oErro
5772:         TRY
5773:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 5806 a 5877:
5806:         LOCAL loc_oErro
5807:         TRY
5808:             *-- === Cursores placeholder ANTES dos grids ===
5809:             SET NULL ON
5810:             IF USED("cursor_4c_Compo")
5811:                 USE IN cursor_4c_Compo
5812:             ENDIF
5813:             CREATE CURSOR cursor_4c_Compo (;
5814:                 Mats     C(14)    NULL, ;
5815:                 DPros    C(40)    NULL, ;
5816:                 Unisp    C(5)     NULL, ;
5817:                 Vals     N(15,6)  NULL, ;
5818:                 Qtds     N(15,6)  NULL, ;
5819:                 Totals   N(15,6)  NULL, ;
5820:                 Moedas   C(10)    NULL, ;
5821:                 Obss     C(50)    NULL, ;
5822:                 Es       C(10)    NULL, ;
5823:                 Conss    N(15,6)  NULL, ;
5824:                 Qtdss    N(15,6)  NULL, ;
5825:                 Unis     C(5)     NULL, ;
5826:                 Ords     N(5,0)   NULL, ;
5827:                 Bloqueio C(14)    NULL  ;
5828:             )
5829:             IF USED("cursor_4c_SubCp")
5830:                 USE IN cursor_4c_SubCp
5831:             ENDIF
5832:             CREATE CURSOR cursor_4c_SubCp (;
5833:                 Mats     C(14)    NULL, ;
5834:                 DPros    C(40)    NULL, ;
5835:                 Unisp    C(5)     NULL, ;
5836:                 Vals     N(15,6)  NULL, ;
5837:                 Qtds     N(15,6)  NULL, ;
5838:                 Totals   N(15,6)  NULL, ;
5839:                 Moedas   C(10)    NULL, ;
5840:                 Obss     C(50)    NULL, ;
5841:                 Es       C(10)    NULL, ;
5842:                 Conss    N(15,6)  NULL, ;
5843:                 Qtdss    N(15,6)  NULL, ;
5844:                 Unis     C(5)     NULL, ;
5845:                 Ords     N(5,0)   NULL, ;
5846:                 Bloqueio C(14)    NULL, ;
5847:                 Tams     C(10)    NULL  ;
5848:             )
5849:             IF USED("cursor_4c_GrupoCompo")
5850:                 USE IN cursor_4c_GrupoCompo
5851:             ENDIF
5852:             CREATE CURSOR cursor_4c_GrupoCompo (;
5853:                 CGrus  C(10)   NULL, ;
5854:                 Totals N(15,6) NULL, ;
5855:                 Moedas C(10)   NULL  ;
5856:             )
5857:             SET NULL OFF
5858: 
5859:             *-- === Obs. da OF (getObsOFs) - top=297+29=326 ===
5860:             par_oPage.AddObject("lbl_4c_LblObsOF", "Label")
5861:             WITH par_oPage.lbl_4c_LblObsOF
5862:                 .Top       = 329
5863:                 .Left      = 36
5864:                 .Width     = 64
5865:                 .Height    = 15
5866:                 .FontName  = "Tahoma"
5867:                 .FontSize  = 8
5868:                 .BackStyle = 0
5869:                 .Caption   = "<Obs. da OF :"
5870:                 .Visible   = .T.
5871:             ENDWITH
5872: 
5873:             par_oPage.AddObject("txt_4c_ObsOFs", "TextBox")
5874:             WITH par_oPage.txt_4c_ObsOFs
5875:                 .Top      = 326
5876:                 .Left     = 99
5877:                 .Width    = 850

*-- Linhas 5936 a 6079:
5936:             ENDWITH
5937: 
5938:             *-- === GradeGRUPO (grupos composicao) - top=34+29=63 ===
5939:             par_oPage.AddObject("grd_4c_Grupo", "Grid")
5940:             par_oPage.grd_4c_Grupo.Top         = 63
5941:             par_oPage.grd_4c_Grupo.Left        = 582
5942:             par_oPage.grd_4c_Grupo.Width       = 229
5943:             par_oPage.grd_4c_Grupo.Height      = 107
5944:             par_oPage.grd_4c_Grupo.ColumnCount = 3
5945:             par_oPage.grd_4c_Grupo.FontName    = "Tahoma"
5946:             par_oPage.grd_4c_Grupo.FontSize    = 8
5947:             par_oPage.grd_4c_Grupo.GridLines   = 3
5948:             par_oPage.grd_4c_Grupo.DeleteMark  = .F.
5949:             par_oPage.grd_4c_Grupo.RecordMark  = .F.
5950:             par_oPage.grd_4c_Grupo.ReadOnly    = .T.
5951:             par_oPage.grd_4c_Grupo.ScrollBars  = 2
5952:             par_oPage.grd_4c_Grupo.Themes      = .F.
5953:             par_oPage.grd_4c_Grupo.Visible     = .T.
5954: 
5955:             par_oPage.grd_4c_Grupo.RecordSource = "cursor_4c_GrupoCompo"
5956: 
5957:             par_oPage.grd_4c_Grupo.Column1.Header1.Caption  = "Grupo"
5958:             par_oPage.grd_4c_Grupo.Column1.ControlSource    = "cursor_4c_GrupoCompo.CGrus"
5959:             par_oPage.grd_4c_Grupo.Column1.Width            = 60
5960:             par_oPage.grd_4c_Grupo.Column1.Header1.FontBold = .T.
5961: 
5962:             par_oPage.grd_4c_Grupo.Column2.Header1.Caption  = "Total"
5963:             par_oPage.grd_4c_Grupo.Column2.ControlSource    = "cursor_4c_GrupoCompo.Totals"
5964:             par_oPage.grd_4c_Grupo.Column2.Width            = 90
5965:             par_oPage.grd_4c_Grupo.Column2.Header1.FontBold = .T.
5966: 
5967:             par_oPage.grd_4c_Grupo.Column3.Header1.Caption  = "Moeda"
5968:             par_oPage.grd_4c_Grupo.Column3.ControlSource    = "cursor_4c_GrupoCompo.Moedas"
5969:             par_oPage.grd_4c_Grupo.Column3.Width            = 65
5970:             par_oPage.grd_4c_Grupo.Column3.Header1.FontBold = .T.
5971: 
5972:             *-- === grdCompo (composicao principal) - top=148+29=177 ===
5973:             par_oPage.AddObject("grd_4c_Compo", "Grid")
5974:             par_oPage.grd_4c_Compo.Top         = 177
5975:             par_oPage.grd_4c_Compo.Left        = 6
5976:             par_oPage.grd_4c_Compo.Width       = 943
5977:             par_oPage.grd_4c_Compo.Height      = 147
5978:             par_oPage.grd_4c_Compo.ColumnCount = 14
5979:             par_oPage.grd_4c_Compo.FontName    = "Tahoma"
5980:             par_oPage.grd_4c_Compo.FontSize    = 8
5981:             par_oPage.grd_4c_Compo.GridLines   = 3
5982:             par_oPage.grd_4c_Compo.DeleteMark  = .F.
5983:             par_oPage.grd_4c_Compo.RecordMark  = .F.
5984:             par_oPage.grd_4c_Compo.RowHeight   = 16
5985:             par_oPage.grd_4c_Compo.ScrollBars  = 3
5986:             par_oPage.grd_4c_Compo.Themes      = .F.
5987:             par_oPage.grd_4c_Compo.Visible     = .T.
5988: 
5989:             par_oPage.grd_4c_Compo.RecordSource = "cursor_4c_Compo"
5990: 
5991:             par_oPage.grd_4c_Compo.Column1.Header1.Caption  = "Material"
5992:             par_oPage.grd_4c_Compo.Column1.ControlSource    = "cursor_4c_Compo.Mats"
5993:             par_oPage.grd_4c_Compo.Column1.Width            = 80
5994:             par_oPage.grd_4c_Compo.Column1.Header1.FontBold = .T.
5995: 
5996:             par_oPage.grd_4c_Compo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
5997:             par_oPage.grd_4c_Compo.Column2.ControlSource    = "cursor_4c_Compo.DPros"
5998:             par_oPage.grd_4c_Compo.Column2.Width            = 155
5999:             par_oPage.grd_4c_Compo.Column2.Header1.FontBold = .T.
6000: 
6001:             par_oPage.grd_4c_Compo.Column3.Header1.Caption  = "Un"
6002:             par_oPage.grd_4c_Compo.Column3.ControlSource    = "cursor_4c_Compo.Unisp"
6003:             par_oPage.grd_4c_Compo.Column3.Width            = 35
6004:             par_oPage.grd_4c_Compo.Column3.Header1.FontBold = .T.
6005: 
6006:             par_oPage.grd_4c_Compo.Column4.Header1.Caption  = "Valor"
6007:             par_oPage.grd_4c_Compo.Column4.ControlSource    = "cursor_4c_Compo.Vals"
6008:             par_oPage.grd_4c_Compo.Column4.Width            = 75
6009:             par_oPage.grd_4c_Compo.Column4.Header1.FontBold = .T.
6010: 
6011:             par_oPage.grd_4c_Compo.Column5.Header1.Caption  = "Qtde."
6012:             par_oPage.grd_4c_Compo.Column5.ControlSource    = "cursor_4c_Compo.Qtds"
6013:             par_oPage.grd_4c_Compo.Column5.Width            = 65
6014:             par_oPage.grd_4c_Compo.Column5.Header1.FontBold = .T.
6015: 
6016:             par_oPage.grd_4c_Compo.Column6.Header1.Caption  = "Total"
6017:             par_oPage.grd_4c_Compo.Column6.ControlSource    = "cursor_4c_Compo.Totals"
6018:             par_oPage.grd_4c_Compo.Column6.Width            = 75
6019:             par_oPage.grd_4c_Compo.Column6.Header1.FontBold = .T.
6020: 
6021:             par_oPage.grd_4c_Compo.Column7.Header1.Caption  = "Moe"
6022:             par_oPage.grd_4c_Compo.Column7.ControlSource    = "cursor_4c_Compo.Moedas"
6023:             par_oPage.grd_4c_Compo.Column7.Width            = 35
6024:             par_oPage.grd_4c_Compo.Column7.Header1.FontBold = .T.
6025: 
6026:             par_oPage.grd_4c_Compo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6027:             par_oPage.grd_4c_Compo.Column8.ControlSource    = "cursor_4c_Compo.Obss"
6028:             par_oPage.grd_4c_Compo.Column8.Width            = 100
6029:             par_oPage.grd_4c_Compo.Column8.Header1.FontBold = .T.
6030: 
6031:             par_oPage.grd_4c_Compo.Column9.Header1.Caption  = "E"
6032:             par_oPage.grd_4c_Compo.Column9.ControlSource    = "cursor_4c_Compo.Es"
6033:             par_oPage.grd_4c_Compo.Column9.Width            = 25
6034:             par_oPage.grd_4c_Compo.Column9.Header1.FontBold = .T.
6035: 
6036:             par_oPage.grd_4c_Compo.Column10.Header1.Caption  = "Consumo"
6037:             par_oPage.grd_4c_Compo.Column10.ControlSource    = "cursor_4c_Compo.Conss"
6038:             par_oPage.grd_4c_Compo.Column10.Width            = 65
6039:             par_oPage.grd_4c_Compo.Column10.Header1.FontBold = .T.
6040: 
6041:             par_oPage.grd_4c_Compo.Column11.Header1.Caption  = "Qtde."
6042:             par_oPage.grd_4c_Compo.Column11.ControlSource    = "cursor_4c_Compo.Qtdss"
6043:             par_oPage.grd_4c_Compo.Column11.Width            = 65
6044:             par_oPage.grd_4c_Compo.Column11.Header1.FontBold = .T.
6045: 
6046:             par_oPage.grd_4c_Compo.Column12.Header1.Caption  = "Un"
6047:             par_oPage.grd_4c_Compo.Column12.ControlSource    = "cursor_4c_Compo.Unis"
6048:             par_oPage.grd_4c_Compo.Column12.Width            = 35
6049:             par_oPage.grd_4c_Compo.Column12.Header1.FontBold = .T.
6050: 
6051:             par_oPage.grd_4c_Compo.Column13.Header1.Caption  = "Ord"
6052:             par_oPage.grd_4c_Compo.Column13.ControlSource    = "cursor_4c_Compo.Ords"
6053:             par_oPage.grd_4c_Compo.Column13.Width            = 35
6054:             par_oPage.grd_4c_Compo.Column13.Header1.FontBold = .T.
6055: 
6056:             par_oPage.grd_4c_Compo.Column14.Header1.Caption  = "Bloqueio"
6057:             par_oPage.grd_4c_Compo.Column14.ControlSource    = "cursor_4c_Compo.Bloqueio"
6058:             par_oPage.grd_4c_Compo.Column14.Width            = 90
6059:             par_oPage.grd_4c_Compo.Column14.Header1.FontBold = .T.
6060: 
6061:             *-- === cmdgCompo (CommandGroup 5 botoes) - top=145+29=174 ===
6062:             par_oPage.AddObject("cmdg_4c_Compo", "CommandGroup")
6063:             WITH par_oPage.cmdg_4c_Compo
6064:                 .Top         = 174
6065:                 .Left        = 947
6066:                 .Width       = 50
6067:                 .Height      = 210
6068:                 .ButtonCount = 5
6069:                 .Themes      = .F.
6070:                 .Visible     = .T.
6071:             ENDWITH
6072: 
6073:             WITH par_oPage.cmdg_4c_Compo.Buttons(1)
6074:                 .Caption  = "+"
6075:                 .Top      = 0
6076:                 .Left     = 0
6077:                 .Width    = 50
6078:                 .Height   = 40
6079:                 .FontName = "Tahoma"

*-- Linhas 6181 a 6295:
6181:             ENDWITH
6182: 
6183:             *-- === grdsubcp (grid substitutos) - top=348+29=377 ===
6184:             par_oPage.AddObject("grd_4c_SubCp", "Grid")
6185:             par_oPage.grd_4c_SubCp.Top         = 377
6186:             par_oPage.grd_4c_SubCp.Left        = 6
6187:             par_oPage.grd_4c_SubCp.Width       = 943
6188:             par_oPage.grd_4c_SubCp.Height      = 83
6189:             par_oPage.grd_4c_SubCp.ColumnCount = 15
6190:             par_oPage.grd_4c_SubCp.FontName    = "Tahoma"
6191:             par_oPage.grd_4c_SubCp.FontSize    = 8
6192:             par_oPage.grd_4c_SubCp.GridLines   = 3
6193:             par_oPage.grd_4c_SubCp.DeleteMark  = .F.
6194:             par_oPage.grd_4c_SubCp.RecordMark  = .F.
6195:             par_oPage.grd_4c_SubCp.RowHeight   = 16
6196:             par_oPage.grd_4c_SubCp.ScrollBars  = 3
6197:             par_oPage.grd_4c_SubCp.Themes      = .F.
6198:             par_oPage.grd_4c_SubCp.Visible     = .T.
6199: 
6200:             par_oPage.grd_4c_SubCp.RecordSource = "cursor_4c_SubCp"
6201: 
6202:             par_oPage.grd_4c_SubCp.Column1.Header1.Caption  = "Material"
6203:             par_oPage.grd_4c_SubCp.Column1.ControlSource    = "cursor_4c_SubCp.Mats"
6204:             par_oPage.grd_4c_SubCp.Column1.Width            = 80
6205:             par_oPage.grd_4c_SubCp.Column1.Header1.FontBold = .T.
6206: 
6207:             par_oPage.grd_4c_SubCp.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
6208:             par_oPage.grd_4c_SubCp.Column2.ControlSource    = "cursor_4c_SubCp.DPros"
6209:             par_oPage.grd_4c_SubCp.Column2.Width            = 140
6210:             par_oPage.grd_4c_SubCp.Column2.Header1.FontBold = .T.
6211: 
6212:             par_oPage.grd_4c_SubCp.Column3.Header1.Caption  = "Un"
6213:             par_oPage.grd_4c_SubCp.Column3.ControlSource    = "cursor_4c_SubCp.Unisp"
6214:             par_oPage.grd_4c_SubCp.Column3.Width            = 30
6215:             par_oPage.grd_4c_SubCp.Column3.Header1.FontBold = .T.
6216: 
6217:             par_oPage.grd_4c_SubCp.Column4.Header1.Caption  = "Valor"
6218:             par_oPage.grd_4c_SubCp.Column4.ControlSource    = "cursor_4c_SubCp.Vals"
6219:             par_oPage.grd_4c_SubCp.Column4.Width            = 65
6220:             par_oPage.grd_4c_SubCp.Column4.Header1.FontBold = .T.
6221: 
6222:             par_oPage.grd_4c_SubCp.Column5.Header1.Caption  = "Qtde."
6223:             par_oPage.grd_4c_SubCp.Column5.ControlSource    = "cursor_4c_SubCp.Qtds"
6224:             par_oPage.grd_4c_SubCp.Column5.Width            = 60
6225:             par_oPage.grd_4c_SubCp.Column5.Header1.FontBold = .T.
6226: 
6227:             par_oPage.grd_4c_SubCp.Column6.Header1.Caption  = "Total"
6228:             par_oPage.grd_4c_SubCp.Column6.ControlSource    = "cursor_4c_SubCp.Totals"
6229:             par_oPage.grd_4c_SubCp.Column6.Width            = 65
6230:             par_oPage.grd_4c_SubCp.Column6.Header1.FontBold = .T.
6231: 
6232:             par_oPage.grd_4c_SubCp.Column7.Header1.Caption  = "Moe"
6233:             par_oPage.grd_4c_SubCp.Column7.ControlSource    = "cursor_4c_SubCp.Moedas"
6234:             par_oPage.grd_4c_SubCp.Column7.Width            = 30
6235:             par_oPage.grd_4c_SubCp.Column7.Header1.FontBold = .T.
6236: 
6237:             par_oPage.grd_4c_SubCp.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
6238:             par_oPage.grd_4c_SubCp.Column8.ControlSource    = "cursor_4c_SubCp.Obss"
6239:             par_oPage.grd_4c_SubCp.Column8.Width            = 90
6240:             par_oPage.grd_4c_SubCp.Column8.Header1.FontBold = .T.
6241: 
6242:             par_oPage.grd_4c_SubCp.Column9.Header1.Caption  = "E"
6243:             par_oPage.grd_4c_SubCp.Column9.ControlSource    = "cursor_4c_SubCp.Es"
6244:             par_oPage.grd_4c_SubCp.Column9.Width            = 20
6245:             par_oPage.grd_4c_SubCp.Column9.Header1.FontBold = .T.
6246: 
6247:             par_oPage.grd_4c_SubCp.Column10.Header1.Caption  = "Consumo"
6248:             par_oPage.grd_4c_SubCp.Column10.ControlSource    = "cursor_4c_SubCp.Conss"
6249:             par_oPage.grd_4c_SubCp.Column10.Width            = 60
6250:             par_oPage.grd_4c_SubCp.Column10.Header1.FontBold = .T.
6251: 
6252:             par_oPage.grd_4c_SubCp.Column11.Header1.Caption  = "Qtde."
6253:             par_oPage.grd_4c_SubCp.Column11.ControlSource    = "cursor_4c_SubCp.Qtdss"
6254:             par_oPage.grd_4c_SubCp.Column11.Width            = 60
6255:             par_oPage.grd_4c_SubCp.Column11.Header1.FontBold = .T.
6256: 
6257:             par_oPage.grd_4c_SubCp.Column12.Header1.Caption  = "Un"
6258:             par_oPage.grd_4c_SubCp.Column12.ControlSource    = "cursor_4c_SubCp.Unis"
6259:             par_oPage.grd_4c_SubCp.Column12.Width            = 30
6260:             par_oPage.grd_4c_SubCp.Column12.Header1.FontBold = .T.
6261: 
6262:             par_oPage.grd_4c_SubCp.Column13.Header1.Caption  = "Ord"
6263:             par_oPage.grd_4c_SubCp.Column13.ControlSource    = "cursor_4c_SubCp.Ords"
6264:             par_oPage.grd_4c_SubCp.Column13.Width            = 30
6265:             par_oPage.grd_4c_SubCp.Column13.Header1.FontBold = .T.
6266: 
6267:             par_oPage.grd_4c_SubCp.Column14.Header1.Caption  = "Bloqueio"
6268:             par_oPage.grd_4c_SubCp.Column14.ControlSource    = "cursor_4c_SubCp.Bloqueio"
6269:             par_oPage.grd_4c_SubCp.Column14.Width            = 75
6270:             par_oPage.grd_4c_SubCp.Column14.Header1.FontBold = .T.
6271: 
6272:             par_oPage.grd_4c_SubCp.Column15.Header1.Caption  = "Tam"
6273:             par_oPage.grd_4c_SubCp.Column15.ControlSource    = "cursor_4c_SubCp.Tams"
6274:             par_oPage.grd_4c_SubCp.Column15.Width            = 55
6275:             par_oPage.grd_4c_SubCp.Column15.Header1.FontBold = .T.
6276: 
6277:             *-- === cmdgSubCp (CommandGroup 2 botoes) - top=345+29=374 ===
6278:             par_oPage.AddObject("cmdg_4c_SubCp", "CommandGroup")
6279:             WITH par_oPage.cmdg_4c_SubCp
6280:                 .Top         = 374
6281:                 .Left        = 947
6282:                 .Width       = 50
6283:                 .Height      = 90
6284:                 .ButtonCount = 2
6285:                 .Themes      = .F.
6286:                 .Visible     = .T.
6287:             ENDWITH
6288: 
6289:             WITH par_oPage.cmdg_4c_SubCp.Buttons(1)
6290:                 .Caption  = "+"
6291:                 .Top      = 0
6292:                 .Left     = 0
6293:                 .Width    = 50
6294:                 .Height   = 40
6295:                 .FontName = "Tahoma"

*-- Linhas 7194 a 7245:
7194:         LOCAL loc_oErro
7195:         TRY
7196:             *-- === Cursores placeholder ANTES dos grids ===
7197:             SET NULL ON
7198:             IF USED("cursor_4c_CustoCompo")
7199:                 USE IN cursor_4c_CustoCompo
7200:             ENDIF
7201:             CREATE CURSOR cursor_4c_CustoCompo (;
7202:                 Mats     C(14)    NULL, ;
7203:                 DPros    C(40)    NULL, ;
7204:                 Unisp    C(5)     NULL, ;
7205:                 Vals     N(15,6)  NULL, ;
7206:                 Qtds     N(15,6)  NULL, ;
7207:                 Totals   N(15,6)  NULL, ;
7208:                 Moedas   C(10)    NULL, ;
7209:                 Obss     C(50)    NULL, ;
7210:                 Es       C(10)    NULL, ;
7211:                 Conss    N(15,6)  NULL, ;
7212:                 Qtdss    N(15,6)  NULL, ;
7213:                 Unis     C(5)     NULL, ;
7214:                 CGrus    C(10)    NULL, ;
7215:                 Bloqueio C(14)    NULL  ;
7216:             )
7217:             IF USED("cursor_4c_GrupoCompo2")
7218:                 USE IN cursor_4c_GrupoCompo2
7219:             ENDIF
7220:             CREATE CURSOR cursor_4c_GrupoCompo2 (;
7221:                 CGrus  C(10)   NULL, ;
7222:                 Totals N(15,6) NULL, ;
7223:                 Moedas C(10)   NULL  ;
7224:             )
7225:             SET NULL OFF
7226: 
7227:             *-- === Say1: label "Tipo:" - top=159+29=188, left=112 ===
7228:             par_oPage.AddObject("lbl_4c_LblTipo", "Label")
7229:             WITH par_oPage.lbl_4c_LblTipo
7230:                 .Top       = 188
7231:                 .Left      = 112
7232:                 .Width     = 29
7233:                 .Height    = 15
7234:                 .FontName  = "Tahoma"
7235:                 .FontSize  = 8
7236:                 .BackStyle = 0
7237:                 .Caption   = "Tipo:"
7238:                 .Visible   = .T.
7239:             ENDWITH
7240: 
7241:             *-- === cmbTipos - top=154+29=183, left=143, w=187, h=23 ===
7242:             par_oPage.AddObject("cbo_4c_CmbTipos", "ComboBox")
7243:             WITH par_oPage.cbo_4c_CmbTipos
7244:                 .Top            = 183
7245:                 .Left           = 143

*-- Linhas 7255 a 7357:
7255:             ENDWITH
7256: 
7257:             *-- === grdCompo (custo principal) - top=178+29=207, left=34, w=813, h=230, 12 cols ===
7258:             par_oPage.AddObject("grd_4c_GrdCustoCompo", "Grid")
7259:             par_oPage.grd_4c_GrdCustoCompo.Top         = 207
7260:             par_oPage.grd_4c_GrdCustoCompo.Left        = 34
7261:             par_oPage.grd_4c_GrdCustoCompo.Width       = 813
7262:             par_oPage.grd_4c_GrdCustoCompo.Height      = 230
7263:             par_oPage.grd_4c_GrdCustoCompo.ColumnCount = 12
7264:             par_oPage.grd_4c_GrdCustoCompo.FontName    = "Tahoma"
7265:             par_oPage.grd_4c_GrdCustoCompo.FontSize    = 8
7266:             par_oPage.grd_4c_GrdCustoCompo.GridLines   = 3
7267:             par_oPage.grd_4c_GrdCustoCompo.DeleteMark  = .F.
7268:             par_oPage.grd_4c_GrdCustoCompo.RecordMark  = .F.
7269:             par_oPage.grd_4c_GrdCustoCompo.RowHeight   = 16
7270:             par_oPage.grd_4c_GrdCustoCompo.ScrollBars  = 3
7271:             par_oPage.grd_4c_GrdCustoCompo.Themes      = .F.
7272:             par_oPage.grd_4c_GrdCustoCompo.Visible     = .T.
7273: 
7274:             par_oPage.grd_4c_GrdCustoCompo.RecordSource = "cursor_4c_CustoCompo"
7275: 
7276:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.Caption  = "Item"
7277:             par_oPage.grd_4c_GrdCustoCompo.Column1.ControlSource    = "cursor_4c_CustoCompo.Mats"
7278:             par_oPage.grd_4c_GrdCustoCompo.Column1.Width            = 80
7279:             par_oPage.grd_4c_GrdCustoCompo.Column1.Header1.FontBold = .T.
7280: 
7281:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
7282:             par_oPage.grd_4c_GrdCustoCompo.Column2.ControlSource    = "cursor_4c_CustoCompo.DPros"
7283:             par_oPage.grd_4c_GrdCustoCompo.Column2.Width            = 160
7284:             par_oPage.grd_4c_GrdCustoCompo.Column2.Header1.FontBold = .T.
7285: 
7286:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.Caption  = "Un"
7287:             par_oPage.grd_4c_GrdCustoCompo.Column3.ControlSource    = "cursor_4c_CustoCompo.Unisp"
7288:             par_oPage.grd_4c_GrdCustoCompo.Column3.Width            = 35
7289:             par_oPage.grd_4c_GrdCustoCompo.Column3.ReadOnly         = .T.
7290:             par_oPage.grd_4c_GrdCustoCompo.Column3.Header1.FontBold = .T.
7291: 
7292:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.Caption  = "Valor"
7293:             par_oPage.grd_4c_GrdCustoCompo.Column4.ControlSource    = "cursor_4c_CustoCompo.Vals"
7294:             par_oPage.grd_4c_GrdCustoCompo.Column4.Width            = 80
7295:             par_oPage.grd_4c_GrdCustoCompo.Column4.Header1.FontBold = .T.
7296: 
7297:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.Caption  = "Qtde."
7298:             par_oPage.grd_4c_GrdCustoCompo.Column5.ControlSource    = "cursor_4c_CustoCompo.Qtds"
7299:             par_oPage.grd_4c_GrdCustoCompo.Column5.Width            = 65
7300:             par_oPage.grd_4c_GrdCustoCompo.Column5.Header1.FontBold = .T.
7301: 
7302:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.Caption  = "Total"
7303:             par_oPage.grd_4c_GrdCustoCompo.Column6.ControlSource    = "cursor_4c_CustoCompo.Totals"
7304:             par_oPage.grd_4c_GrdCustoCompo.Column6.Width            = 80
7305:             par_oPage.grd_4c_GrdCustoCompo.Column6.ReadOnly         = .T.
7306:             par_oPage.grd_4c_GrdCustoCompo.Column6.Header1.FontBold = .T.
7307: 
7308:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.Caption  = "Moe"
7309:             par_oPage.grd_4c_GrdCustoCompo.Column7.ControlSource    = "cursor_4c_CustoCompo.Moedas"
7310:             par_oPage.grd_4c_GrdCustoCompo.Column7.Width            = 40
7311:             par_oPage.grd_4c_GrdCustoCompo.Column7.Header1.FontBold = .T.
7312: 
7313:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
7314:             par_oPage.grd_4c_GrdCustoCompo.Column8.ControlSource    = "cursor_4c_CustoCompo.Obss"
7315:             par_oPage.grd_4c_GrdCustoCompo.Column8.Width            = 100
7316:             par_oPage.grd_4c_GrdCustoCompo.Column8.Header1.FontBold = .T.
7317: 
7318:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.Caption  = "E"
7319:             par_oPage.grd_4c_GrdCustoCompo.Column9.ControlSource    = "cursor_4c_CustoCompo.Es"
7320:             par_oPage.grd_4c_GrdCustoCompo.Column9.Width            = 30
7321:             par_oPage.grd_4c_GrdCustoCompo.Column9.Header1.FontBold = .T.
7322: 
7323:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.Caption  = "Consumo"
7324:             par_oPage.grd_4c_GrdCustoCompo.Column10.ControlSource    = "cursor_4c_CustoCompo.Conss"
7325:             par_oPage.grd_4c_GrdCustoCompo.Column10.Width            = 65
7326:             par_oPage.grd_4c_GrdCustoCompo.Column10.Header1.FontBold = .T.
7327: 
7328:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.Caption  = "Qtde."
7329:             par_oPage.grd_4c_GrdCustoCompo.Column11.ControlSource    = "cursor_4c_CustoCompo.Qtdss"
7330:             par_oPage.grd_4c_GrdCustoCompo.Column11.Width            = 65
7331:             par_oPage.grd_4c_GrdCustoCompo.Column11.Header1.FontBold = .T.
7332: 
7333:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.Caption  = "Un"
7334:             par_oPage.grd_4c_GrdCustoCompo.Column12.ControlSource    = "cursor_4c_CustoCompo.Unis"
7335:             par_oPage.grd_4c_GrdCustoCompo.Column12.Width            = 35
7336:             par_oPage.grd_4c_GrdCustoCompo.Column12.ReadOnly         = .T.
7337:             par_oPage.grd_4c_GrdCustoCompo.Column12.Header1.FontBold = .T.
7338: 
7339:             *-- === cmdgCompo (2 botoes +/-) - top=240+29=269, left=851, w=50, h=90 ===
7340:             par_oPage.AddObject("cmdg_4c_CustoCompo", "CommandGroup")
7341:             WITH par_oPage.cmdg_4c_CustoCompo
7342:                 .Top         = 269
7343:                 .Left        = 851
7344:                 .Width       = 50
7345:                 .Height      = 90
7346:                 .ButtonCount = 2
7347:                 .Themes      = .F.
7348:                 .Visible     = .T.
7349:             ENDWITH
7350: 
7351:             WITH par_oPage.cmdg_4c_CustoCompo.Buttons(1)
7352:                 .Caption  = "+"
7353:                 .Top      = 0
7354:                 .Left     = 0
7355:                 .Width    = 50
7356:                 .Height   = 40
7357:                 .FontName = "Tahoma"

*-- Linhas 7455 a 7509:
7455:             ENDWITH
7456: 
7457:             *-- === GradeGRUPO2 - top=468+29=497, left=35, w=195, h=141, 3 cols ===
7458:             par_oPage.AddObject("grd_4c_GrupoCompo2", "Grid")
7459:             par_oPage.grd_4c_GrupoCompo2.Top         = 497
7460:             par_oPage.grd_4c_GrupoCompo2.Left        = 35
7461:             par_oPage.grd_4c_GrupoCompo2.Width       = 195
7462:             par_oPage.grd_4c_GrupoCompo2.Height      = 141
7463:             par_oPage.grd_4c_GrupoCompo2.ColumnCount = 3
7464:             par_oPage.grd_4c_GrupoCompo2.FontName    = "Tahoma"
7465:             par_oPage.grd_4c_GrupoCompo2.FontSize    = 8
7466:             par_oPage.grd_4c_GrupoCompo2.GridLines   = 3
7467:             par_oPage.grd_4c_GrupoCompo2.DeleteMark  = .F.
7468:             par_oPage.grd_4c_GrupoCompo2.RecordMark  = .F.
7469:             par_oPage.grd_4c_GrupoCompo2.ReadOnly    = .T.
7470:             par_oPage.grd_4c_GrupoCompo2.ScrollBars  = 2
7471:             par_oPage.grd_4c_GrupoCompo2.Themes      = .F.
7472:             par_oPage.grd_4c_GrupoCompo2.Visible     = .T.
7473: 
7474:             par_oPage.grd_4c_GrupoCompo2.RecordSource = "cursor_4c_GrupoCompo2"
7475: 
7476:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.Caption  = "Grp"
7477:             par_oPage.grd_4c_GrupoCompo2.Column1.ControlSource    = "cursor_4c_GrupoCompo2.CGrus"
7478:             par_oPage.grd_4c_GrupoCompo2.Column1.Width            = 60
7479:             par_oPage.grd_4c_GrupoCompo2.Column1.Header1.FontBold = .T.
7480: 
7481:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.Caption  = "Total"
7482:             par_oPage.grd_4c_GrupoCompo2.Column2.ControlSource    = "cursor_4c_GrupoCompo2.Totals"
7483:             par_oPage.grd_4c_GrupoCompo2.Column2.Width            = 90
7484:             par_oPage.grd_4c_GrupoCompo2.Column2.Header1.FontBold = .T.
7485: 
7486:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.Caption  = "Moe"
7487:             par_oPage.grd_4c_GrupoCompo2.Column3.ControlSource    = "cursor_4c_GrupoCompo2.Moedas"
7488:             par_oPage.grd_4c_GrupoCompo2.Column3.Width            = 40
7489:             par_oPage.grd_4c_GrupoCompo2.Column3.Header1.FontBold = .T.
7490: 
7491:         CATCH TO loc_oErro
7492:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina Custo")
7493:         ENDTRY
7494:     ENDPROC
7495: 
7496:     *==========================================================================
7497:     * CarregarComposicao - Carrega SigPrCpo e SigPrScp para o produto atual
7498:     *==========================================================================
7499:     PROCEDURE CarregarComposicao()
7500:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgComp, loc_oErro
7501:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7502:             RETURN
7503:         ENDIF
7504:         TRY
7505:             loc_cCPros = ALLTRIM(this_cCodigo)
7506:             IF EMPTY(loc_cCPros)
7507:                 RETURN
7508:             ENDIF
7509: 

*-- Linhas 7560 a 7585:
7560: 
7561:             *-- Refresh grids
7562:             loc_oPgComp = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7563:             loc_oPgComp.grd_4c_Compo.Refresh()
7564:             loc_oPgComp.grd_4c_SubCp.Refresh()
7565:             loc_oPgComp.grd_4c_Grupo.Refresh()
7566: 
7567:         CATCH TO loc_oErro
7568:             MsgErro(loc_oErro.Message, "Erro ao carregar composi" + CHR(231) + CHR(227) + "o")
7569:         ENDTRY
7570:     ENDPROC
7571: 
7572:     *==========================================================================
7573:     * Handlers de composicao (PUBLIC - obrigatorio para BINDEVENT)
7574:     *==========================================================================
7575:     PROCEDURE CompoAfterRowColChange(par_nColIndex)
7576:         LOCAL loc_oPg, loc_oErro
7577:         TRY
7578:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page2
7579:             IF USED("cursor_4c_Compo") AND !EOF("cursor_4c_Compo")
7580:                 SELECT cursor_4c_Compo
7581:                 loc_oPg.txt_4c_Desc.Value    = ALLTRIM(DPros)
7582:                 loc_oPg.txt_4c_MatP.Value    = ALLTRIM(Mats)
7583:                 loc_oPg.txt_4c_ObsOFs.Value  = ALLTRIM(Obss)
7584:             ENDIF
7585:         CATCH TO loc_oErro

*-- Linhas 7922 a 7946:
7922:                 "cursor_4c_BuscaMoeComp", "CMoes", ;
7923:                 ALLTRIM(par_oTextBox.Value), ;
7924:                 "Moeda")
7925:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
7926:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
7927:             loc_oBusca.Show()
7928:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeComp")
7929:                 loc_cCodigo = ALLTRIM(cursor_4c_BuscaMoeComp.CMoes)
7930:                 par_oTextBox.Value = loc_cCodigo
7931:             ENDIF
7932:             IF USED("cursor_4c_BuscaMoeComp")
7933:                 USE IN cursor_4c_BuscaMoeComp
7934:             ENDIF
7935:             loc_oBusca.Release()
7936:         CATCH TO loc_oErro
7937:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
7938:         ENDTRY
7939:     ENDPROC
7940: 
7941:     PROTECTED PROCEDURE ValidarFtio()
7942:         LOCAL loc_oPg, loc_cCod, loc_nRet, loc_oErro
7943:         TRY
7944:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
7945:                 RETURN
7946:             ENDIF

*-- Linhas 8068 a 8092:
8068:             ENDIF
8069: 
8070:             *-- Refresh grids
8071:             loc_oPgCusto.grd_4c_GrdCustoCompo.Refresh()
8072:             loc_oPgCusto.grd_4c_GrupoCompo2.Refresh()
8073: 
8074:         CATCH TO loc_oErro
8075:             MsgErro(loc_oErro.Message, "Erro ao carregar custo")
8076:         ENDTRY
8077:     ENDPROC
8078: 
8079:     *==========================================================================
8080:     * Handlers da pagina Custo (PUBLIC - obrigatorio para BINDEVENT)
8081:     *==========================================================================
8082:     PROCEDURE GrdCustoCompoAfterRowColChange(par_nColIndex)
8083:         LOCAL loc_oPg, loc_cSQL, loc_nRet, loc_cGrus, loc_cDGrus, loc_oErro
8084:         TRY
8085:             loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page6
8086:             IF USED("cursor_4c_CustoCompo") AND !EOF("cursor_4c_CustoCompo")
8087:                 SELECT cursor_4c_CustoCompo
8088:                 loc_oPg.txt_4c_DescCus.Value  = ALLTRIM(DPros)
8089:                 loc_cGrus = ALLTRIM(CGrus)
8090:                 *-- Buscar descricao do grupo
8091:                 IF !EMPTY(loc_cGrus) AND gnConnHandle > 0
8092:                     IF USED("cursor_4c_GruCusto")

*-- Linhas 8196 a 8241:
8196:         LOCAL loc_oGrd, loc_oErro
8197:         TRY
8198:             *-- === Cursores placeholder ANTES dos grids ===
8199:             SET NULL ON
8200:             IF USED("cursor_4c_ConsP")
8201:                 USE IN cursor_4c_ConsP
8202:             ENDIF
8203:             CREATE CURSOR cursor_4c_ConsP (;
8204:                 Mats   C(14)   NULL, ;
8205:                 Qtds   N(15,6) NULL, ;
8206:                 Unisp  C(5)    NULL, ;
8207:                 Grupos C(10)   NULL, ;
8208:                 Descrs C(50)   NULL, ;
8209:                 Ordems N(5,0)  NULL, ;
8210:                 Conss  N(15,6) NULL, ;
8211:                 Ccats  C(10)   NULL, ;
8212:                 DCats  C(50)   NULL  ;
8213:             )
8214:             IF USED("cursor_4c_DTemp")
8215:                 USE IN cursor_4c_DTemp
8216:             ENDIF
8217:             CREATE CURSOR cursor_4c_DTemp (;
8218:                 Grupos C(10)   NULL, ;
8219:                 TempoP N(10,2) NULL  ;
8220:             )
8221:             SET NULL OFF
8222: 
8223:             *-- === Say7: label "Qtde Componentes :" - top=523+29=552, left=25 ===
8224:             par_oPage.AddObject("lbl_4c_Label7", "Label")
8225:             WITH par_oPage.lbl_4c_Label7
8226:                 .Top       = 552
8227:                 .Left      = 25
8228:                 .Width     = 105
8229:                 .Height    = 15
8230:                 .FontName  = "Tahoma"
8231:                 .FontSize  = 8
8232:                 .BackStyle = 0
8233:                 .Caption   = "Qtde Componentes :"
8234:                 .Visible   = .T.
8235:             ENDWITH
8236: 
8237:             *-- === Getqtcpnt: TextBox contagem - top=519+29=548, left=131 ===
8238:             par_oPage.AddObject("txt_4c_Qtcpnt", "TextBox")
8239:             WITH par_oPage.txt_4c_Qtcpnt
8240:                 .Top      = 548
8241:                 .Left     = 131

*-- Linhas 8278 a 8406:
8278:             ENDWITH
8279: 
8280:             *-- === GrdCons - top=155+29=184, left=6, w=987, h=362, 9 colunas ===
8281:             par_oPage.AddObject("grd_4c_GrdCons", "Grid")
8282:             loc_oGrd = par_oPage.grd_4c_GrdCons
8283:             loc_oGrd.Top         = 184
8284:             loc_oGrd.Left        = 6
8285:             loc_oGrd.Width       = 987
8286:             loc_oGrd.Height      = 362
8287:             loc_oGrd.ColumnCount = 9
8288:             loc_oGrd.FontName    = "Tahoma"
8289:             loc_oGrd.FontSize    = 8
8290:             loc_oGrd.GridLines   = 3
8291:             loc_oGrd.DeleteMark  = .F.
8292:             loc_oGrd.RecordMark  = .F.
8293:             loc_oGrd.RowHeight   = 16
8294:             loc_oGrd.ScrollBars  = 3
8295:             loc_oGrd.Themes      = .F.
8296:             loc_oGrd.Visible     = .T.
8297: 
8298:             loc_oGrd.RecordSource = "cursor_4c_ConsP"
8299: 
8300:             loc_oGrd.Column1.Header1.Caption  = "Componente"
8301:             loc_oGrd.Column1.ControlSource    = "cursor_4c_ConsP.Mats"
8302:             loc_oGrd.Column1.Width            = 100
8303:             loc_oGrd.Column1.ReadOnly         = .T.
8304:             loc_oGrd.Column1.Header1.FontBold = .T.
8305: 
8306:             loc_oGrd.Column2.Header1.Caption  = "Qtde."
8307:             loc_oGrd.Column2.ControlSource    = "cursor_4c_ConsP.Qtds"
8308:             loc_oGrd.Column2.Width            = 65
8309:             loc_oGrd.Column2.ReadOnly         = .T.
8310:             loc_oGrd.Column2.Header1.FontBold = .T.
8311: 
8312:             loc_oGrd.Column3.Header1.Caption  = "Uni"
8313:             loc_oGrd.Column3.ControlSource    = "cursor_4c_ConsP.Unisp"
8314:             loc_oGrd.Column3.Width            = 45
8315:             loc_oGrd.Column3.ReadOnly         = .T.
8316:             loc_oGrd.Column3.Header1.FontBold = .T.
8317: 
8318:             loc_oGrd.Column4.Header1.Caption  = "Fase"
8319:             loc_oGrd.Column4.ControlSource    = "cursor_4c_ConsP.Grupos"
8320:             loc_oGrd.Column4.Width            = 65
8321:             loc_oGrd.Column4.Header1.FontBold = .T.
8322: 
8323:             loc_oGrd.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8324:             loc_oGrd.Column5.ControlSource    = "cursor_4c_ConsP.Descrs"
8325:             loc_oGrd.Column5.Width            = 200
8326:             loc_oGrd.Column5.Header1.FontBold = .T.
8327: 
8328:             loc_oGrd.Column6.Header1.Caption  = "Ord."
8329:             loc_oGrd.Column6.ControlSource    = "cursor_4c_ConsP.Ordems"
8330:             loc_oGrd.Column6.Width            = 40
8331:             loc_oGrd.Column6.ReadOnly         = .T.
8332:             loc_oGrd.Column6.Header1.FontBold = .T.
8333: 
8334:             loc_oGrd.Column7.Header1.Caption  = "Consumo"
8335:             loc_oGrd.Column7.ControlSource    = "cursor_4c_ConsP.Conss"
8336:             loc_oGrd.Column7.Width            = 80
8337:             loc_oGrd.Column7.Header1.FontBold = .T.
8338: 
8339:             loc_oGrd.Column8.Header1.Caption  = "Cat."
8340:             loc_oGrd.Column8.ControlSource    = "cursor_4c_ConsP.Ccats"
8341:             loc_oGrd.Column8.Width            = 60
8342:             loc_oGrd.Column8.Header1.FontBold = .T.
8343: 
8344:             loc_oGrd.Column9.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
8345:             loc_oGrd.Column9.ControlSource    = "cursor_4c_ConsP.DCats"
8346:             loc_oGrd.Column9.Width            = 150
8347:             loc_oGrd.Column9.ReadOnly         = .T.
8348:             loc_oGrd.Column9.Header1.FontBold = .T.
8349: 
8350:             *-- BINDEVENT para colunas editaveis (F4=115 dispara lookup)
8351:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "GrdConsCol4KeyPress")
8352:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress", THIS, "GrdConsCol5KeyPress")
8353:             BINDEVENT(loc_oGrd.Column8.Text1, "KeyPress", THIS, "GrdConsCol8KeyPress")
8354: 
8355:             *-- === grDTEMP - top=519+29=548, left=821, w=172, h=107, 2 colunas ===
8356:             par_oPage.AddObject("grd_4c_GrDTEMP", "Grid")
8357:             WITH par_oPage.grd_4c_GrDTEMP
8358:                 .Top         = 548
8359:                 .Left        = 821
8360:                 .Width       = 172
8361:                 .Height      = 107
8362:                 .ColumnCount = 2
8363:                 .FontName    = "Tahoma"
8364:                 .FontSize    = 8
8365:                 .GridLines   = 3
8366:                 .DeleteMark  = .F.
8367:                 .RecordMark  = .F.
8368:                 .RowHeight   = 16
8369:                 .ScrollBars  = 3
8370:                 .Themes      = .F.
8371:                 .Visible     = .T.
8372:             ENDWITH
8373: 
8374:             par_oPage.grd_4c_GrDTEMP.RecordSource = "cursor_4c_DTemp"
8375: 
8376:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.Caption  = "Agrupamento"
8377:             par_oPage.grd_4c_GrDTEMP.Column1.ControlSource    = "cursor_4c_DTemp.Grupos"
8378:             par_oPage.grd_4c_GrDTEMP.Column1.Width            = 90
8379:             par_oPage.grd_4c_GrDTEMP.Column1.ReadOnly         = .T.
8380:             par_oPage.grd_4c_GrDTEMP.Column1.Header1.FontBold = .T.
8381: 
8382:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.Caption  = "Tempo %"
8383:             par_oPage.grd_4c_GrDTEMP.Column2.ControlSource    = "cursor_4c_DTemp.TempoP"
8384:             par_oPage.grd_4c_GrDTEMP.Column2.Width            = 70
8385:             par_oPage.grd_4c_GrDTEMP.Column2.ReadOnly         = .T.
8386:             par_oPage.grd_4c_GrDTEMP.Column2.Header1.FontBold = .T.
8387: 
8388:         CATCH TO loc_oErro
8389:             MsgErro(loc_oErro.Message, "Erro ao configurar p" + CHR(225) + "gina ConsP")
8390:         ENDTRY
8391:     ENDPROC
8392: 
8393:     *==========================================================================
8394:     * CarregarConsP - Carrega SigPrCpo com fase (SigCdPrf) e cat (SigCdCat)
8395:     *==========================================================================
8396:     PROCEDURE CarregarConsP()
8397:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgConsP, loc_oErro, loc_lContinuar
8398:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8399:             RETURN
8400:         ENDIF
8401:         loc_lContinuar = .T.
8402:         TRY
8403:             loc_cCPros = ALLTRIM(this_cCodigo)
8404:             IF EMPTY(loc_cCPros)
8405:                 loc_lContinuar = .F.
8406:             ENDIF

*-- Linhas 8436 a 8677:
8436: 
8437:                     loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8438:                     loc_oPgConsP.txt_4c_Qtcpnt.Value = LTRIM(STR(RECCOUNT("cursor_4c_ConsP")))
8439:                     loc_oPgConsP.grd_4c_GrdCons.Refresh()
8440:                 ENDIF
8441: 
8442:                 *-- Carregar DTemp (consumo agrupado por fase/grupo)
8443:                 IF USED("cursor_4c_DTempLoad")
8444:                     USE IN cursor_4c_DTempLoad
8445:                 ENDIF
8446:                 loc_cSQL = "SELECT ISNULL(c.grupos,'') AS Grupos, " + ;
8447:                            "       ISNULL(SUM(c.qtscons),0) AS TempoP " + ;
8448:                            "FROM SigPrCpo c " + ;
8449:                            "WHERE c.CPros = " + EscaparSQL(PADR(loc_cCPros, 14)) + ;
8450:                            "  AND c.grupos IS NOT NULL AND LTRIM(RTRIM(c.grupos)) <> '' " + ;
8451:                            "GROUP BY c.grupos ORDER BY c.grupos"
8452:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DTempLoad")
8453:                 IF loc_nRet > 0
8454:                     SELECT cursor_4c_DTemp
8455:                     ZAP
8456:                     APPEND FROM DBF("cursor_4c_DTempLoad")
8457:                     IF USED("cursor_4c_DTempLoad")
8458:                         USE IN cursor_4c_DTempLoad
8459:                     ENDIF
8460:                     SELECT cursor_4c_DTemp
8461:                     GO TOP
8462:                     IF VARTYPE(loc_oPgConsP) = "O"
8463:                         loc_oPgConsP.grd_4c_GrDTEMP.Refresh()
8464:                     ENDIF
8465:                 ENDIF
8466:             ENDIF
8467: 
8468:         CATCH TO loc_oErro
8469:             MsgErro(loc_oErro.Message, "Erro ao carregar ConsP")
8470:         ENDTRY
8471:     ENDPROC
8472: 
8473:     *==========================================================================
8474:     * GrdConsCol4KeyPress - F4 em Column4 (Fase) abre lookup SigCdPrf
8475:     *==========================================================================
8476:     PROCEDURE GrdConsCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8477:         LOCAL loc_oErro
8478:         TRY
8479:             IF par_nKeyCode = 115
8480:                 THIS.AbrirLookupFaseConsP()
8481:             ENDIF
8482:         CATCH TO loc_oErro
8483:             *-- Tolerado
8484:         ENDTRY
8485:     ENDPROC
8486: 
8487:     PROTECTED PROCEDURE AbrirLookupFaseConsP()
8488:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8489:         TRY
8490:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8491:                 RETURN
8492:             ENDIF
8493:             IF !this_lEmEdicao
8494:                 RETURN
8495:             ENDIF
8496:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8497:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8498:             loc_cGrupos  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
8499:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8500:                 "cursor_4c_BuscaFase", "Grupos", loc_cGrupos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
8501:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8502:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8503:             loc_oBusca.Show()
8504:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFase")
8505:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFase.Grupos)
8506:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFase.Descrs)
8507:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8508:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8509:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8510:                 ENDIF
8511:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8512:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8513:                 loc_oGrd.Refresh()
8514:             ENDIF
8515:             IF USED("cursor_4c_BuscaFase")
8516:                 USE IN cursor_4c_BuscaFase
8517:             ENDIF
8518:             loc_oBusca.Release()
8519:         CATCH TO loc_oErro
8520:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
8521:         ENDTRY
8522:     ENDPROC
8523: 
8524:     *==========================================================================
8525:     * GrdConsCol5KeyPress - F4 em Column5 (Descricao fase) abre lookup SigCdPrf
8526:     *==========================================================================
8527:     PROCEDURE GrdConsCol5KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8528:         LOCAL loc_oErro
8529:         TRY
8530:             IF par_nKeyCode = 115
8531:                 THIS.AbrirLookupFaseDescConsP()
8532:             ENDIF
8533:         CATCH TO loc_oErro
8534:             *-- Tolerado
8535:         ENDTRY
8536:     ENDPROC
8537: 
8538:     PROTECTED PROCEDURE AbrirLookupFaseDescConsP()
8539:         LOCAL loc_oBusca, loc_cGrupos, loc_cDescrs, loc_oPgConsP, loc_oGrd, loc_oErro
8540:         TRY
8541:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8542:                 RETURN
8543:             ENDIF
8544:             IF !this_lEmEdicao
8545:                 RETURN
8546:             ENDIF
8547:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8548:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8549:             loc_cDescrs  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
8550:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPrf", ;
8551:                 "cursor_4c_BuscaFaseDesc", "Descrs", loc_cDescrs, "Descri" + CHR(231) + CHR(227) + "o de Fase")
8552:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
8553:             loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
8554:             loc_oBusca.Show()
8555:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFaseDesc")
8556:                 loc_cGrupos = ALLTRIM(cursor_4c_BuscaFaseDesc.Grupos)
8557:                 loc_cDescrs = ALLTRIM(cursor_4c_BuscaFaseDesc.Descrs)
8558:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8559:                     REPLACE cursor_4c_ConsP.Grupos WITH loc_cGrupos
8560:                     REPLACE cursor_4c_ConsP.Descrs WITH loc_cDescrs
8561:                 ENDIF
8562:                 loc_oGrd.Column4.Text1.Value = loc_cGrupos
8563:                 loc_oGrd.Column5.Text1.Value = loc_cDescrs
8564:                 loc_oGrd.Refresh()
8565:             ENDIF
8566:             IF USED("cursor_4c_BuscaFaseDesc")
8567:                 USE IN cursor_4c_BuscaFaseDesc
8568:             ENDIF
8569:             loc_oBusca.Release()
8570:         CATCH TO loc_oErro
8571:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de descri" + CHR(231) + CHR(227) + "o de fase")
8572:         ENDTRY
8573:     ENDPROC
8574: 
8575:     *==========================================================================
8576:     * GrdConsCol8KeyPress - F4 em Column8 (Cat.) abre lookup SigCdCat
8577:     *==========================================================================
8578:     PROCEDURE GrdConsCol8KeyPress(par_nKeyCode, par_nShiftAltCtrl)
8579:         LOCAL loc_oErro
8580:         TRY
8581:             IF par_nKeyCode = 115
8582:                 THIS.AbrirLookupCatConsP()
8583:             ENDIF
8584:         CATCH TO loc_oErro
8585:             *-- Tolerado
8586:         ENDTRY
8587:     ENDPROC
8588: 
8589:     PROTECTED PROCEDURE AbrirLookupCatConsP()
8590:         LOCAL loc_oBusca, loc_cCods, loc_cDescs, loc_oPgConsP, loc_oGrd, loc_oErro
8591:         TRY
8592:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
8593:                 RETURN
8594:             ENDIF
8595:             IF !this_lEmEdicao
8596:                 RETURN
8597:             ENDIF
8598:             loc_oPgConsP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page5
8599:             loc_oGrd     = loc_oPgConsP.grd_4c_GrdCons
8600:             loc_cCods    = ALLTRIM(loc_oGrd.Column8.Text1.Value)
8601:             loc_oBusca   = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCat", ;
8602:                 "cursor_4c_BuscaCat", "Cods", loc_cCods, "Categoria")
8603:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
8604:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
8605:             loc_oBusca.Show()
8606:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCat")
8607:                 loc_cCods  = ALLTRIM(cursor_4c_BuscaCat.Cods)
8608:                 loc_cDescs = ALLTRIM(cursor_4c_BuscaCat.Descs)
8609:                 IF USED("cursor_4c_ConsP") AND !EOF("cursor_4c_ConsP")
8610:                     REPLACE cursor_4c_ConsP.Ccats WITH loc_cCods
8611:                     REPLACE cursor_4c_ConsP.DCats WITH loc_cDescs
8612:                 ENDIF
8613:                 loc_oGrd.Column8.Text1.Value = loc_cCods
8614:                 loc_oGrd.Column9.Text1.Value = loc_cDescs
8615:                 loc_oGrd.Refresh()
8616:             ENDIF
8617:             IF USED("cursor_4c_BuscaCat")
8618:                 USE IN cursor_4c_BuscaCat
8619:             ENDIF
8620:             loc_oBusca.Release()
8621:         CATCH TO loc_oErro
8622:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de categoria")
8623:         ENDTRY
8624:     ENDPROC
8625: 
8626:     *==========================================================================
8627:     * ConfigurarPgPgDadosFaseP - PgDadosFaseP (Page4 do pgf_4c_DadosInterno)
8628:     * GradFase (5 col), grdMatrizes (4 col), controles de produto
8629:     * Posicoes: original_top + 29
8630:     *==========================================================================
8631:     PROTECTED PROCEDURE ConfigurarPgPgDadosFaseP(par_oPage)
8632:         LOCAL loc_oGrd, loc_oGrd2, loc_oErro
8633:         TRY
8634:             *-- === Cursores placeholder ANTES dos grids ===
8635:             SET NULL ON
8636:             IF USED("cursor_4c_PrfFase")
8637:                 USE IN cursor_4c_PrfFase
8638:             ENDIF
8639:             CREATE CURSOR cursor_4c_PrfFase (;
8640:                 CIdChaves C(20)  NULL, ;
8641:                 Ordems    N(2,0) NULL, ;
8642:                 Grupos    C(10)  NULL, ;
8643:                 Descrs    C(50)  NULL, ;
8644:                 UniPrdts  C(10)  NULL, ;
8645:                 MatPrdts  C(15)  NULL  ;
8646:             )
8647:             IF USED("cursor_4c_Mtz")
8648:                 USE IN cursor_4c_Mtz
8649:             ENDIF
8650:             CREATE CURSOR cursor_4c_Mtz (;
8651:                 CIdChaves C(20)  NULL, ;
8652:                 CMats     C(14)  NULL, ;
8653:                 DPros     C(65)  NULL, ;
8654:                 Locals    C(10)  NULL, ;
8655:                 Qtds      N(3,0) NULL  ;
8656:             )
8657:             SET NULL OFF
8658: 
8659:             *-- === Shape fundo imagem fase (shpFig, top=152+29=181, left=231, w=244, h=148) ===
8660:             par_oPage.AddObject("shp_4c_ShpFig", "Shape")
8661:             WITH par_oPage.shp_4c_ShpFig
8662:                 .Top    = 181
8663:                 .Left   = 231
8664:                 .Width  = 244
8665:                 .Height = 148
8666:                 .BackColor   = RGB(255,255,255)
8667:                 .BorderStyle = 1
8668:                 .Visible     = .T.
8669:             ENDWITH
8670: 
8671:             *-- === Imagem fase (ImgFigJpg, top=153+29=182, left=232, w=241, h=146) ===
8672:             par_oPage.AddObject("img_4c_ImgFigJpg", "Image")
8673:             WITH par_oPage.img_4c_ImgFigJpg
8674:                 .Top     = 182
8675:                 .Left    = 232
8676:                 .Width   = 241
8677:                 .Height  = 146

*-- Linhas 9010 a 9085:
9010:                 .Visible = .T.
9011:             ENDWITH
9012: 
9013:             *-- === grd_4c_GradFase (GradFase, top=152+29=181, left=527, w=420, h=312, 5 colunas) ===
9014:             par_oPage.AddObject("grd_4c_GradFase", "Grid")
9015:             loc_oGrd = par_oPage.grd_4c_GradFase
9016:             loc_oGrd.Top         = 181
9017:             loc_oGrd.Left        = 527
9018:             loc_oGrd.Width       = 420
9019:             loc_oGrd.Height      = 312
9020:             loc_oGrd.ColumnCount = 5
9021:             loc_oGrd.FontName    = "Tahoma"
9022:             loc_oGrd.FontSize    = 8
9023:             loc_oGrd.GridLines   = 3
9024:             loc_oGrd.DeleteMark  = .F.
9025:             loc_oGrd.RecordMark  = .F.
9026:             loc_oGrd.RowHeight   = 16
9027:             loc_oGrd.ScrollBars  = 3
9028:             loc_oGrd.Themes      = .F.
9029:             loc_oGrd.Visible     = .T.
9030: 
9031:             loc_oGrd.RecordSource = "cursor_4c_PrfFase"
9032: 
9033:             loc_oGrd.Column1.Header1.Caption  = "Ordem"
9034:             loc_oGrd.Column1.ControlSource    = "cursor_4c_PrfFase.Ordems"
9035:             loc_oGrd.Column1.Width            = 40
9036:             loc_oGrd.Column1.Header1.FontBold = .T.
9037: 
9038:             loc_oGrd.Column2.Header1.Caption  = "Fase"
9039:             loc_oGrd.Column2.ControlSource    = "cursor_4c_PrfFase.Grupos"
9040:             loc_oGrd.Column2.Width            = 70
9041:             loc_oGrd.Column2.Header1.FontBold = .T.
9042: 
9043:             loc_oGrd.Column3.Header1.Caption  = "Utiliza" + CHR(231) + CHR(227) + "o"
9044:             loc_oGrd.Column3.ControlSource    = "cursor_4c_PrfFase.Descrs"
9045:             loc_oGrd.Column3.Width            = 160
9046:             loc_oGrd.Column3.ReadOnly         = .T.
9047:             loc_oGrd.Column3.Header1.FontBold = .T.
9048: 
9049:             loc_oGrd.Column4.Header1.Caption  = "Uni. Produtiva"
9050:             loc_oGrd.Column4.ControlSource    = "cursor_4c_PrfFase.UniPrdts"
9051:             loc_oGrd.Column4.Width            = 75
9052:             loc_oGrd.Column4.Header1.FontBold = .T.
9053: 
9054:             loc_oGrd.Column5.Header1.Caption  = "Material"
9055:             loc_oGrd.Column5.ControlSource    = "cursor_4c_PrfFase.MatPrdts"
9056:             loc_oGrd.Column5.Width            = 75
9057:             loc_oGrd.Column5.Header1.FontBold = .T.
9058: 
9059:             *-- BINDEVENTs para GradFase
9060:             BINDEVENT(loc_oGrd,             "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
9061:             BINDEVENT(loc_oGrd.Column1.Text1, "GotFocus",         THIS, "GradFaseCol1GotFocus")
9062:             BINDEVENT(loc_oGrd.Column1.Text1, "LostFocus",        THIS, "GradFaseCol1LostFocus")
9063:             BINDEVENT(loc_oGrd.Column2.Text1, "KeyPress",         THIS, "GradFaseCol2KeyPress")
9064:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress",         THIS, "GradFaseCol4KeyPress")
9065:             BINDEVENT(loc_oGrd.Column5.Text1, "KeyPress",         THIS, "GradFaseCol5KeyPress")
9066: 
9067:             *-- === Botao Incluir fase (inserir, top=152+29=181, left=950, w=40, h=40) ===
9068:             par_oPage.AddObject("cmd_4c_Incluir", "CommandButton")
9069:             WITH par_oPage.cmd_4c_Incluir
9070:                 .Top     = 181
9071:                 .Left   = 950
9072:                 .Width   = 40
9073:                 .Height = 40
9074:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9075:                 .Caption = ""
9076:                 .FontName = "Tahoma"
9077:                 .FontSize = 8
9078:                 .Themes  = .F.
9079:                 .Visible = .T.
9080:             ENDWITH
9081: 
9082:             *-- === Botao Excluir fase (excluir, top=192+29=221, left=950, w=40, h=40) ===
9083:             par_oPage.AddObject("cmd_4c_Excluir", "CommandButton")
9084:             WITH par_oPage.cmd_4c_Excluir
9085:                 .Top     = 221

*-- Linhas 9159 a 9227:
9159:                 .Visible = .T.
9160:             ENDWITH
9161: 
9162:             *-- === grd_4c_Matrizes (grdMatrizes, top=380+29=409, left=7, w=246, h=240, 4 colunas) ===
9163:             par_oPage.AddObject("grd_4c_Matrizes", "Grid")
9164:             loc_oGrd2 = par_oPage.grd_4c_Matrizes
9165:             loc_oGrd2.Top         = 409
9166:             loc_oGrd2.Left        = 7
9167:             loc_oGrd2.Width       = 246
9168:             loc_oGrd2.Height      = 240
9169:             loc_oGrd2.ColumnCount = 4
9170:             loc_oGrd2.FontName    = "Tahoma"
9171:             loc_oGrd2.FontSize    = 8
9172:             loc_oGrd2.GridLines   = 3
9173:             loc_oGrd2.DeleteMark  = .F.
9174:             loc_oGrd2.RecordMark  = .F.
9175:             loc_oGrd2.RowHeight   = 16
9176:             loc_oGrd2.ScrollBars  = 3
9177:             loc_oGrd2.Themes      = .F.
9178:             loc_oGrd2.Visible     = .T.
9179: 
9180:             loc_oGrd2.RecordSource = "cursor_4c_Mtz"
9181: 
9182:             loc_oGrd2.Column1.Header1.Caption  = "Matriz"
9183:             loc_oGrd2.Column1.ControlSource    = "cursor_4c_Mtz.CMats"
9184:             loc_oGrd2.Column1.Width            = 60
9185:             loc_oGrd2.Column1.Header1.FontBold = .T.
9186: 
9187:             loc_oGrd2.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
9188:             loc_oGrd2.Column2.ControlSource    = "cursor_4c_Mtz.DPros"
9189:             loc_oGrd2.Column2.Width            = 100
9190:             loc_oGrd2.Column2.ReadOnly         = .T.
9191:             loc_oGrd2.Column2.Header1.FontBold = .T.
9192: 
9193:             loc_oGrd2.Column3.Header1.Caption  = "Local"
9194:             loc_oGrd2.Column3.ControlSource    = "cursor_4c_Mtz.Locals"
9195:             loc_oGrd2.Column3.Width            = 50
9196:             loc_oGrd2.Column3.ReadOnly         = .T.
9197:             loc_oGrd2.Column3.Header1.FontBold = .T.
9198: 
9199:             loc_oGrd2.Column4.Header1.Caption  = "Qtde"
9200:             loc_oGrd2.Column4.ControlSource    = "cursor_4c_Mtz.Qtds"
9201:             loc_oGrd2.Column4.Width            = 36
9202:             loc_oGrd2.Column4.Header1.FontBold = .T.
9203: 
9204:             *-- BINDEVENTs para Matrizes
9205:             BINDEVENT(loc_oGrd2,              "AfterRowColChange", THIS, "MatrizesAfterRowColChange")
9206:             BINDEVENT(loc_oGrd2.Column1.Text1, "GotFocus",         THIS, "MatrizesCol1GotFocus")
9207:             BINDEVENT(loc_oGrd2.Column1.Text1, "KeyPress",         THIS, "MatrizesCol1KeyPress")
9208: 
9209:             *-- === Botao Inserir Matriz (btnInsereMtx, top=380+29=409, left=258, w=40, h=40) ===
9210:             par_oPage.AddObject("cmd_4c_BtnInsereMtx", "CommandButton")
9211:             WITH par_oPage.cmd_4c_BtnInsereMtx
9212:                 .Top     = 409
9213:                 .Left   = 258
9214:                 .Width   = 40
9215:                 .Height = 40
9216:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
9217:                 .Caption = ""
9218:                 .FontName = "Tahoma"
9219:                 .FontSize = 8
9220:                 .Themes  = .F.
9221:                 .Visible = .T.
9222:             ENDWITH
9223: 
9224:             *-- === Botao Excluir Matriz (btnExcluiMtz, top=420+29=449, left=258, w=40, h=40) ===
9225:             par_oPage.AddObject("cmd_4c_BtnExcluiMtz", "CommandButton")
9226:             WITH par_oPage.cmd_4c_BtnExcluiMtz
9227:                 .Top     = 449

*-- Linhas 9378 a 9401:
9378:                     SELECT cursor_4c_PrfFase
9379:                     GO TOP
9380:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9381:                     loc_oPgFaseP.grd_4c_GradFase.Refresh()
9382:                     *-- Carregar imagem da primeira linha
9383:                     THIS.GradFaseAfterRowColChange(0)
9384:                 ELSE
9385:                     IF USED("cursor_4c_PrfFaseTemp")
9386:                         USE IN cursor_4c_PrfFaseTemp
9387:                     ENDIF
9388:                 ENDIF
9389:             ENDIF
9390:         CATCH TO loc_oErro
9391:             MsgErro(loc_oErro.Message, "Erro ao carregar Fase P")
9392:         ENDTRY
9393:     ENDPROC
9394: 
9395:     *==========================================================================
9396:     * CarregarMatrizes - SQLEXEC sigprmtz -> cursor_4c_Mtz
9397:     *==========================================================================
9398:     PROCEDURE CarregarMatrizes()
9399:         LOCAL loc_cSQL, loc_nRet, loc_cCPros, loc_oPgFaseP, loc_oErro, loc_lContinuar
9400:         IF gb_4c_ValidandoUI OR gnConnHandle <= 0
9401:             RETURN

*-- Linhas 9430 a 9453:
9430:                     SELECT cursor_4c_Mtz
9431:                     GO TOP
9432:                     loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9433:                     loc_oPgFaseP.grd_4c_Matrizes.Refresh()
9434:                     *-- Carregar imagem da primeira matriz
9435:                     THIS.MatrizesAfterRowColChange(0)
9436:                 ELSE
9437:                     IF USED("cursor_4c_MtzTemp")
9438:                         USE IN cursor_4c_MtzTemp
9439:                     ENDIF
9440:                 ENDIF
9441:             ENDIF
9442:         CATCH TO loc_oErro
9443:             MsgErro(loc_oErro.Message, "Erro ao carregar Matrizes")
9444:         ENDTRY
9445:     ENDPROC
9446: 
9447:     *==========================================================================
9448:     * GradFaseAfterRowColChange - Carrega imagem FigProcs da linha atual
9449:     *==========================================================================
9450:     PROCEDURE GradFaseAfterRowColChange(par_nColIndex)
9451:         LOCAL loc_oPgFaseP, loc_cCIdChaves, loc_cArquivo, loc_nRet, loc_oErro
9452:         TRY
9453:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 9861 a 9885:
9861:         TRY
9862:             IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
9863:                 loc_oPgFaseP = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
9864:                 loc_oGrd2 = loc_oPgFaseP.grd_4c_Matrizes
9865:                 loc_oGrd2.Column1.Text1.Tag = PADR(loc_oGrd2.Column1.Text1.Value, 14)
9866:             ENDIF
9867:         CATCH TO loc_oErro
9868:             *-- Tolerado
9869:         ENDTRY
9870:     ENDPROC
9871: 
9872:     *==========================================================================
9873:     * MatrizesCol1KeyPress - F4 abre lookup de Produto-Matriz (SigCdPro)
9874:     *==========================================================================
9875:     PROCEDURE MatrizesCol1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
9876:         LOCAL loc_oErro
9877:         TRY
9878:             IF par_nKeyCode = 115
9879:                 THIS.AbrirLookupMatrizesCol1()
9880:             ENDIF
9881:         CATCH TO loc_oErro
9882:             *-- Tolerado
9883:         ENDTRY
9884:     ENDPROC
9885: 

*-- Linhas 10012 a 10221:
10012:     ENDPROC
10013: 
10014:     *==========================================================================
10015:     * AbrirLookupGradFaseFase - Lookup SigCdGcr para Column2 (Grupos/Fase)
10016:     *==========================================================================
10017:     PROTECTED PROCEDURE AbrirLookupGradFaseFase()
10018:         LOCAL loc_oBusca, loc_cCodigos, loc_cDescrs, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10019:         TRY
10020:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10021:                 RETURN
10022:             ENDIF
10023:             IF !this_lEmEdicao
10024:                 RETURN
10025:             ENDIF
10026:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10027:                 RETURN
10028:             ENDIF
10029:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10030:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10031:             loc_cCodigos   = ALLTRIM(loc_oGrd.Column2.Text1.Value)
10032:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10033:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
10034:                 "cursor_4c_BuscaGcr", "Codigos", loc_cCodigos, "Fase de Produ" + CHR(231) + CHR(227) + "o")
10035:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
10036:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
10037:             loc_oBusca.Show()
10038:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
10039:                 loc_cCodigos = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
10040:                 loc_cDescrs  = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
10041:                 *-- Atualizar cursor e DB
10042:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10043:                     REPLACE cursor_4c_PrfFase.Grupos WITH PADR(loc_cCodigos, 10)
10044:                     REPLACE cursor_4c_PrfFase.Descrs WITH PADR(loc_cDescrs,  50)
10045:                 ENDIF
10046:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10047:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10048:                         "UPDATE SigCdPrf SET Grupos = " + EscaparSQL(PADR(loc_cCodigos, 10)) + ;
10049:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10050:                 ENDIF
10051:                 loc_oGrd.Column2.Text1.Value = loc_cCodigos
10052:                 loc_oGrd.Column3.Text1.Value = loc_cDescrs
10053:                 loc_oGrd.Refresh()
10054:             ENDIF
10055:             IF USED("cursor_4c_BuscaGcr")
10056:                 USE IN cursor_4c_BuscaGcr
10057:             ENDIF
10058:             loc_oBusca.Release()
10059:         CATCH TO loc_oErro
10060:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de fase")
10061:         ENDTRY
10062:     ENDPROC
10063: 
10064:     *==========================================================================
10065:     * AbrirLookupGradFaseUpd - Lookup SigCdUpd para Column4 (UniPrdts)
10066:     *==========================================================================
10067:     PROTECTED PROCEDURE AbrirLookupGradFaseUpd()
10068:         LOCAL loc_oBusca, loc_cUniPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10069:         TRY
10070:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10071:                 RETURN
10072:             ENDIF
10073:             IF !this_lEmEdicao
10074:                 RETURN
10075:             ENDIF
10076:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10077:                 RETURN
10078:             ENDIF
10079:             LOCAL loc_cGruposUpd
10080:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10081:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10082:             loc_cUniPrdts  = ALLTRIM(loc_oGrd.Column4.Text1.Value)
10083:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10084:             loc_cGruposUpd = ALLTRIM(cursor_4c_PrfFase.Grupos)
10085:             *-- Filtrar por Codigos = Grupos atual (conforme legado)
10086:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdUpd", ;
10087:                 "cursor_4c_BuscaUpd", "UniPrdts", loc_cUniPrdts, "Unidade Produtiva", ;
10088:                 .F., .F., "Codigos = " + EscaparSQL(PADR(loc_cGruposUpd, 10)))
10089:             loc_oBusca.mAddColuna("UniPrdts", "", "Uni. Produtiva")
10090:             loc_oBusca.Show()
10091:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUpd")
10092:                 loc_cUniPrdts = ALLTRIM(cursor_4c_BuscaUpd.UniPrdts)
10093:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10094:                     REPLACE cursor_4c_PrfFase.UniPrdts WITH PADR(loc_cUniPrdts, 10)
10095:                 ENDIF
10096:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10097:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10098:                         "UPDATE SigCdPrf SET UniPrdts = " + EscaparSQL(PADR(loc_cUniPrdts, 10)) + ;
10099:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10100:                 ENDIF
10101:                 loc_oGrd.Column4.Text1.Value = loc_cUniPrdts
10102:                 loc_oGrd.Refresh()
10103:             ENDIF
10104:             IF USED("cursor_4c_BuscaUpd")
10105:                 USE IN cursor_4c_BuscaUpd
10106:             ENDIF
10107:             loc_oBusca.Release()
10108:         CATCH TO loc_oErro
10109:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de unidade produtiva")
10110:         ENDTRY
10111:     ENDPROC
10112: 
10113:     *==========================================================================
10114:     * AbrirLookupGradFaseOpt - Lookup SigOpOpt para Column5 (MatPrdts)
10115:     *==========================================================================
10116:     PROTECTED PROCEDURE AbrirLookupGradFaseOpt()
10117:         LOCAL loc_oBusca, loc_cMatPrdts, loc_cCIdChaves, loc_nRet, loc_oPgFaseP, loc_oGrd, loc_oErro
10118:         TRY
10119:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10120:                 RETURN
10121:             ENDIF
10122:             IF !this_lEmEdicao
10123:                 RETURN
10124:             ENDIF
10125:             IF !USED("cursor_4c_PrfFase") OR EOF("cursor_4c_PrfFase")
10126:                 RETURN
10127:             ENDIF
10128:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10129:             loc_oGrd       = loc_oPgFaseP.grd_4c_GradFase
10130:             loc_cMatPrdts  = ALLTRIM(loc_oGrd.Column5.Text1.Value)
10131:             loc_cCIdChaves = ALLTRIM(cursor_4c_PrfFase.CIdChaves)
10132:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigOpOpt", ;
10133:                 "cursor_4c_BuscaOpt", "Cods", loc_cMatPrdts, "Tipo de Material")
10134:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10135:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10136:             loc_oBusca.Show()
10137:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpt")
10138:                 loc_cMatPrdts = ALLTRIM(cursor_4c_BuscaOpt.Cods)
10139:                 IF USED("cursor_4c_PrfFase") AND !EOF("cursor_4c_PrfFase")
10140:                     REPLACE cursor_4c_PrfFase.MatPrdts WITH PADR(loc_cMatPrdts, 15)
10141:                 ENDIF
10142:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10143:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10144:                         "UPDATE SigCdPrf SET MatPrdts = " + EscaparSQL(PADR(loc_cMatPrdts, 15)) + ;
10145:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10146:                 ENDIF
10147:                 loc_oGrd.Column5.Text1.Value = loc_cMatPrdts
10148:                 loc_oGrd.Refresh()
10149:             ENDIF
10150:             IF USED("cursor_4c_BuscaOpt")
10151:                 USE IN cursor_4c_BuscaOpt
10152:             ENDIF
10153:             loc_oBusca.Release()
10154:         CATCH TO loc_oErro
10155:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de material")
10156:         ENDTRY
10157:     ENDPROC
10158: 
10159:     *==========================================================================
10160:     * AbrirLookupMatrizesCol1 - Lookup SigCdPro para Column1 de grdMatrizes
10161:     *==========================================================================
10162:     PROTECTED PROCEDURE AbrirLookupMatrizesCol1()
10163:         LOCAL loc_oBusca, loc_cCMats, loc_cDPros, loc_cLocals, loc_cCIdChaves, loc_nRet
10164:         LOCAL loc_oPgFaseP, loc_oGrd2, loc_oErro
10165:         TRY
10166:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10167:                 RETURN
10168:             ENDIF
10169:             IF !this_lEmEdicao
10170:                 RETURN
10171:             ENDIF
10172:             IF !USED("cursor_4c_Mtz") OR EOF("cursor_4c_Mtz")
10173:                 RETURN
10174:             ENDIF
10175:             loc_oPgFaseP   = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page4
10176:             loc_oGrd2      = loc_oPgFaseP.grd_4c_Matrizes
10177:             loc_cCMats     = ALLTRIM(loc_oGrd2.Column1.Text1.Value)
10178:             loc_cCIdChaves = ALLTRIM(cursor_4c_Mtz.CIdChaves)
10179:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
10180:                 "cursor_4c_BuscaMtz", "CPros", loc_cCMats, "Produto Matriz")
10181:             loc_oBusca.mAddColuna("CPros",  "", "Matriz")
10182:             loc_oBusca.mAddColuna("DPros",  "", "Descri" + CHR(231) + CHR(227) + "o")
10183:             loc_oBusca.mAddColuna("Locals", "", "Local")
10184:             loc_oBusca.Show()
10185:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMtz")
10186:                 loc_cCMats  = ALLTRIM(cursor_4c_BuscaMtz.CPros)
10187:                 loc_cDPros  = ALLTRIM(cursor_4c_BuscaMtz.DPros)
10188:                 loc_cLocals = ALLTRIM(cursor_4c_BuscaMtz.Locals)
10189:                 IF USED("cursor_4c_Mtz") AND !EOF("cursor_4c_Mtz")
10190:                     REPLACE cursor_4c_Mtz.CMats  WITH PADR(loc_cCMats,  14)
10191:                     REPLACE cursor_4c_Mtz.DPros  WITH PADR(loc_cDPros,  65)
10192:                     REPLACE cursor_4c_Mtz.Locals WITH PADR(loc_cLocals, 10)
10193:                 ENDIF
10194:                 IF !EMPTY(loc_cCIdChaves) AND gnConnHandle > 0
10195:                     loc_nRet = SQLEXEC(gnConnHandle, ;
10196:                         "UPDATE SigPrMtz SET CMats = " + EscaparSQL(PADR(loc_cCMats, 14)) + ;
10197:                         " WHERE CIdChaves = " + EscaparSQL(loc_cCIdChaves))
10198:                 ENDIF
10199:                 loc_oGrd2.Column1.Text1.Value = loc_cCMats
10200:                 loc_oGrd2.Column2.Text1.Value = loc_cDPros
10201:                 loc_oGrd2.Column3.Text1.Value = loc_cLocals
10202:                 loc_oGrd2.Refresh()
10203:                 THIS.MatrizesAfterRowColChange(0)
10204:             ENDIF
10205:             IF USED("cursor_4c_BuscaMtz")
10206:                 USE IN cursor_4c_BuscaMtz
10207:             ENDIF
10208:             loc_oBusca.Release()
10209:         CATCH TO loc_oErro
10210:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de matriz")
10211:         ENDTRY
10212:     ENDPROC
10213: 
10214:     *==========================================================================
10215:     * AbrirLookupCodAcbFaseP - Lookup SigCdAca para txt_4c_codacb
10216:     *==========================================================================
10217:     PROTECTED PROCEDURE AbrirLookupCodAcbFaseP()
10218:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPgFaseP, loc_oErro
10219:         TRY
10220:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0
10221:                 RETURN

*-- Linhas 10227 a 10251:
10227:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_codacb.Value)
10228:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdAca", ;
10229:                 "cursor_4c_BuscaAcaFP", "Cods", loc_cCodigo, "Acabamento")
10230:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10231:             loc_oBusca.mAddColuna("Descrs","", "Descri" + CHR(231) + CHR(227) + "o")
10232:             loc_oBusca.Show()
10233:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcaFP")
10234:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaAcaFP.Cods)
10235:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaAcaFP.Descrs)
10236:                 loc_oPgFaseP.txt_4c_codacb.Value = loc_cCodigo
10237:                 loc_oPgFaseP.txt_4c_Dacb.Value   = loc_cDescricao
10238:             ENDIF
10239:             IF USED("cursor_4c_BuscaAcaFP")
10240:                 USE IN cursor_4c_BuscaAcaFP
10241:             ENDIF
10242:             loc_oBusca.Release()
10243:         CATCH TO loc_oErro
10244:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de acabamento")
10245:         ENDTRY
10246:     ENDPROC
10247: 
10248:     *==========================================================================
10249:     * AbrirLookupTamFaseP - Lookup SigCdTam para txt_4c_Tam
10250:     *==========================================================================
10251:     PROTECTED PROCEDURE AbrirLookupTamFaseP()

*-- Linhas 10261 a 10285:
10261:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Tam.Value)
10262:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdTam", ;
10263:                 "cursor_4c_BuscaTamFP", "Cods", loc_cCodigo, "Tamanho")
10264:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10265:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10266:             loc_oBusca.Show()
10267:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTamFP")
10268:                 loc_oPgFaseP.txt_4c_Tam.Value = ALLTRIM(cursor_4c_BuscaTamFP.Cods)
10269:             ENDIF
10270:             IF USED("cursor_4c_BuscaTamFP")
10271:                 USE IN cursor_4c_BuscaTamFP
10272:             ENDIF
10273:             loc_oBusca.Release()
10274:         CATCH TO loc_oErro
10275:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de tamanho")
10276:         ENDTRY
10277:     ENDPROC
10278: 
10279:     *==========================================================================
10280:     * AbrirLookupCorFaseP - Lookup SigCdCor para txt_4c_Cor
10281:     *==========================================================================
10282:     PROTECTED PROCEDURE AbrirLookupCorFaseP()
10283:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10284:         TRY
10285:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 10292 a 10316:
10292:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Cor.Value)
10293:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCor", ;
10294:                 "cursor_4c_BuscaCorFP", "Cods", loc_cCodigo, "Cor")
10295:             loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
10296:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
10297:             loc_oBusca.Show()
10298:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCorFP")
10299:                 loc_oPgFaseP.txt_4c_Cor.Value = ALLTRIM(cursor_4c_BuscaCorFP.Cods)
10300:             ENDIF
10301:             IF USED("cursor_4c_BuscaCorFP")
10302:                 USE IN cursor_4c_BuscaCorFP
10303:             ENDIF
10304:             loc_oBusca.Release()
10305:         CATCH TO loc_oErro
10306:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de cor")
10307:         ENDTRY
10308:     ENDPROC
10309: 
10310:     *==========================================================================
10311:     * AbrirLookupConquilhaFaseP - Lookup SigCdCnq para txt_4c_Conquilha
10312:     *==========================================================================
10313:     PROTECTED PROCEDURE AbrirLookupConquilhaFaseP()
10314:         LOCAL loc_oBusca, loc_cCodigo, loc_oPgFaseP, loc_oErro
10315:         TRY
10316:             IF gb_4c_ValidandoUI OR gnConnHandle <= 0

*-- Linhas 10323 a 10377:
10323:             loc_cCodigo  = ALLTRIM(loc_oPgFaseP.txt_4c_Conquilha.Value)
10324:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCnq", ;
10325:                 "cursor_4c_BuscaCnqFP", "conquilhas", loc_cCodigo, "Conquilhas")
10326:             loc_oBusca.mAddColuna("conquilhas", "", "Conquilhas")
10327:             loc_oBusca.Show()
10328:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCnqFP")
10329:                 loc_oPgFaseP.txt_4c_Conquilha.Value = ALLTRIM(cursor_4c_BuscaCnqFP.conquilhas)
10330:             ENDIF
10331:             IF USED("cursor_4c_BuscaCnqFP")
10332:                 USE IN cursor_4c_BuscaCnqFP
10333:             ENDIF
10334:             loc_oBusca.Release()
10335:         CATCH TO loc_oErro
10336:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup de conquilha")
10337:         ENDTRY
10338:     ENDPROC
10339: 
10340:     *==========================================================================
10341:     * ConfigurarPgpgDadosFiscais - Page3 (pgDadosFiscais) do pgf_4c_DadosInterno
10342:     * Posicoes: original_top + 29 (inner PageFrame em Page2 outer -> +29)
10343:     *==========================================================================
10344:     PROTECTED PROCEDURE ConfigurarPgpgDadosFiscais(par_oPage)
10345:         LOCAL loc_oErro
10346:         TRY
10347:             *-- === Cursor placeholder ANTES do grid grdCmv ===
10348:             SET NULL ON
10349:             IF USED("cursor_4c_Cmv")
10350:                 USE IN cursor_4c_Cmv
10351:             ENDIF
10352:             CREATE CURSOR cursor_4c_Cmv (;
10353:                 Periodo C(7)    NULL, ;
10354:                 ValGR   N(15,6) NULL, ;
10355:                 Moe     C(3)    NULL  ;
10356:             )
10357:             SET NULL OFF
10358: 
10359:             *-- === Say16: "Grupo C.C. :" - top=165+29=194, left=138, w=63, h=15 ===
10360:             par_oPage.AddObject("lbl_4c_Label16", "Label")
10361:             WITH par_oPage.lbl_4c_Label16
10362:                 .Top       = 194
10363:                 .Left      = 138
10364:                 .Width     = 63
10365:                 .Height    = 15
10366:                 .FontName  = "Tahoma"
10367:                 .FontSize  = 8
10368:                 .BackStyle = 0
10369:                 .Caption   = "Grupo C.C. :"
10370:                 .ForeColor = RGB(90,90,90)
10371:                 .Visible   = .T.
10372:             ENDWITH
10373: 
10374:             *-- === Say17: "Conta C.C. :" - top=189+29=218, left=138, w=63, h=15 ===
10375:             par_oPage.AddObject("lbl_4c_Label17", "Label")
10376:             WITH par_oPage.lbl_4c_Label17
10377:                 .Top       = 218

*-- Linhas 10397 a 10420:
10397:                 .FontSize       = 8
10398:                 .SpecialEffect  = 1
10399:                 .Themes         = .F.
10400:                 .ControlSource  = "crSigCdPro.gruccus"
10401:                 .Visible        = .T.
10402:             ENDWITH
10403: 
10404:             *-- === get_dgruccus: top=161+29=190, left=288, w=318, h=23 ===
10405:             par_oPage.AddObject("txt_4c__dgruccus", "TextBox")
10406:             WITH par_oPage.txt_4c__dgruccus
10407:                 .Top            = 190
10408:                 .Left           = 288
10409:                 .Width          = 318
10410:                 .Height         = 23
10411:                 .FontName       = "Tahoma"
10412:                 .FontSize       = 8
10413:                 .SpecialEffect  = 1
10414:                 .Themes         = .F.
10415:                 .Visible        = .T.
10416:             ENDWITH
10417: 
10418:             *-- === get_contaccus: top=186+29=215, left=206, w=80, h=23 ===
10419:             par_oPage.AddObject("txt_4c__contaccus", "TextBox")
10420:             WITH par_oPage.txt_4c__contaccus

*-- Linhas 10426 a 10449:
10426:                 .FontSize       = 8
10427:                 .SpecialEffect  = 1
10428:                 .Themes         = .F.
10429:                 .ControlSource  = "crSigCdPro.contaccus"
10430:                 .Visible        = .T.
10431:             ENDWITH
10432: 
10433:             *-- === get_dcontaccus: top=186+29=215, left=288, w=318, h=23 ===
10434:             par_oPage.AddObject("txt_4c__dcontaccus", "TextBox")
10435:             WITH par_oPage.txt_4c__dcontaccus
10436:                 .Top            = 215
10437:                 .Left           = 288
10438:                 .Width          = 318
10439:                 .Height         = 23
10440:                 .FontName       = "Tahoma"
10441:                 .FontSize       = 8
10442:                 .SpecialEffect  = 1
10443:                 .Themes         = .F.
10444:                 .Visible        = .T.
10445:             ENDWITH
10446: 
10447:             *-- === Say1: "Classificacao Fiscal :" - top=216+29=245, left=102, w=99 ===
10448:             par_oPage.AddObject("lbl_4c_Label1", "Label")
10449:             WITH par_oPage.lbl_4c_Label1

*-- Linhas 10472 a 10495:
10472:                 .InputMask      = "9999.99.9999"
10473:                 .MaxLength      = 12
10474:                 .Themes         = .F.
10475:                 .ControlSource  = "crSigCdPro.clfiscals"
10476:                 .Visible        = .T.
10477:             ENDWITH
10478: 
10479:             *-- === getDclfiscal: top=211+29=240, left=303, w=303, h=23 ===
10480:             par_oPage.AddObject("txt_4c_Dclfiscal", "TextBox")
10481:             WITH par_oPage.txt_4c_Dclfiscal
10482:                 .Top            = 240
10483:                 .Left           = 303
10484:                 .Width          = 303
10485:                 .Height         = 23
10486:                 .FontName       = "Tahoma"
10487:                 .FontSize       = 8
10488:                 .SpecialEffect  = 1
10489:                 .Format         = "!"
10490:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
10491:                 .MaxLength      = 40
10492:                 .Themes         = .F.
10493:                 .Visible        = .T.
10494:             ENDWITH
10495: 

*-- Linhas 10519 a 10542:
10519:                 .SpecialEffect  = 1
10520:                 .MaxLength      = 1
10521:                 .Themes         = .F.
10522:                 .ControlSource  = "crSigCdPro.origmercs"
10523:                 .Visible        = .T.
10524:             ENDWITH
10525: 
10526:             *-- === getDorigmerc: top=236+29=265, left=226, w=380, h=23 ===
10527:             par_oPage.AddObject("txt_4c_Dorigmerc", "TextBox")
10528:             WITH par_oPage.txt_4c_Dorigmerc
10529:                 .Top            = 265
10530:                 .Left           = 226
10531:                 .Width          = 380
10532:                 .Height         = 23
10533:                 .FontName       = "Tahoma"
10534:                 .FontSize       = 8
10535:                 .SpecialEffect  = 1
10536:                 .Format         = "!"
10537:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
10538:                 .MaxLength      = 40
10539:                 .Themes         = .F.
10540:                 .Visible        = .T.
10541:             ENDWITH
10542: 

*-- Linhas 10566 a 10589:
10566:                 .SpecialEffect  = 1
10567:                 .MaxLength      = 3
10568:                 .Themes         = .F.
10569:                 .ControlSource  = "crSigCdPro.sittricms"
10570:                 .Visible        = .T.
10571:             ENDWITH
10572: 
10573:             *-- === getDsittricm: top=261+29=290, left=240, w=366, h=23 ===
10574:             par_oPage.AddObject("txt_4c_Dsittricm", "TextBox")
10575:             WITH par_oPage.txt_4c_Dsittricm
10576:                 .Top            = 290
10577:                 .Left           = 240
10578:                 .Width          = 366
10579:                 .Height         = 23
10580:                 .FontName       = "Tahoma"
10581:                 .FontSize       = 8
10582:                 .SpecialEffect  = 1
10583:                 .Format         = "!"
10584:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
10585:                 .MaxLength      = 40
10586:                 .Themes         = .F.
10587:                 .Visible        = .T.
10588:             ENDWITH
10589: 

*-- Linhas 10614 a 10637:
10614:                 .InputMask      = "9999"
10615:                 .MaxLength      = 4
10616:                 .Themes         = .F.
10617:                 .ControlSource  = "crSigCdPro.CodServs"
10618:                 .Visible        = .T.
10619:             ENDWITH
10620: 
10621:             *-- === Say8: "Aliquota ICMS :" - top=291+29=320, left=250, w=76, h=15 ===
10622:             par_oPage.AddObject("lbl_4c_Label8", "Label")
10623:             WITH par_oPage.lbl_4c_Label8
10624:                 .Top       = 320
10625:                 .Left      = 250
10626:                 .Width     = 76
10627:                 .Height    = 15
10628:                 .FontName  = "Tahoma"
10629:                 .FontSize  = 8
10630:                 .BackStyle = 0
10631:                 .Caption   = "Al" + CHR(237) + "quota ICMS :"
10632:                 .ForeColor = RGB(90,90,90)
10633:                 .Visible   = .T.
10634:             ENDWITH
10635: 
10636:             *-- === getIcms: top=286+29=315, left=342, w=45, h=23 ===
10637:             par_oPage.AddObject("txt_4c_Icms", "TextBox")

*-- Linhas 10646 a 10669:
10646:                 .InputMask      = "99.99"
10647:                 .MaxLength      = 5
10648:                 .Themes         = .F.
10649:                 .ControlSource  = "crSigCdPro.icms"
10650:                 .Visible        = .T.
10651:             ENDWITH
10652: 
10653:             *-- === Say4: "Tipo de Tributacao :" - top=291+29=320, left=395, w=98 ===
10654:             par_oPage.AddObject("lbl_4c_Label4", "Label")
10655:             WITH par_oPage.lbl_4c_Label4
10656:                 .Top       = 320
10657:                 .Left      = 395
10658:                 .Width     = 98
10659:                 .FontName  = "Tahoma"
10660:                 .FontSize  = 8
10661:                 .BackStyle = 0
10662:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o :"
10663:                 .ForeColor = RGB(90,90,90)
10664:                 .Visible   = .T.
10665:             ENDWITH
10666: 
10667:             *-- === Get_TpTrib: top=286+29=315, left=513, w=38, h=23 ===
10668:             par_oPage.AddObject("txt_4c_TpTrib", "TextBox")
10669:             WITH par_oPage.txt_4c_TpTrib

*-- Linhas 10676 a 10699:
10676:                 .SpecialEffect  = 1
10677:                 .MaxLength      = 4
10678:                 .Themes         = .F.
10679:                 .ControlSource  = "crSigCdPro.tptribs"
10680:                 .Visible        = .T.
10681:             ENDWITH
10682: 
10683:             *-- === Say41: "IAT :" - top=290+29=319, left=558, w=26, h=15 ===
10684:             par_oPage.AddObject("lbl_4c_Label41", "Label")
10685:             WITH par_oPage.lbl_4c_Label41
10686:                 .Top       = 319
10687:                 .Left      = 558
10688:                 .Width     = 26
10689:                 .Height    = 15
10690:                 .FontName  = "Tahoma"
10691:                 .FontSize  = 8
10692:                 .BackStyle = 0
10693:                 .Caption   = "IAT :"
10694:                 .ForeColor = RGB(90,90,90)
10695:                 .Visible   = .T.
10696:             ENDWITH
10697: 
10698:             *-- === getiat: top=286+29=315, left=589, w=17, h=23 ===
10699:             par_oPage.AddObject("txt_4c_Iat", "TextBox")

*-- Linhas 10707 a 10730:
10707:                 .SpecialEffect  = 1
10708:                 .MaxLength      = 1
10709:                 .Themes         = .F.
10710:                 .ControlSource  = "crSigCdPro.iats"
10711:                 .Visible        = .T.
10712:             ENDWITH
10713: 
10714:             *-- === Say42: "[A]rredondamento [T]runcamento" - top=290+29=319, left=609, w=165, h=15 ===
10715:             par_oPage.AddObject("lbl_4c_Label42", "Label")
10716:             WITH par_oPage.lbl_4c_Label42
10717:                 .Top       = 319
10718:                 .Left      = 609
10719:                 .Width     = 165
10720:                 .Height    = 15
10721:                 .FontName  = "Tahoma"
10722:                 .FontSize  = 8
10723:                 .BackStyle = 0
10724:                 .Caption   = "[A]rredondamento [T]runcamento"
10725:                 .ForeColor = RGB(90,90,90)
10726:                 .Visible   = .T.
10727:             ENDWITH
10728: 
10729:             *-- === Say5: "Situacao Tributaria IPI :" - top=316+29=345, left=85, w=116, h=15 ===
10730:             par_oPage.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 10784 a 10807:
10784:                 .InputMask      = "99.99"
10785:                 .MaxLength      = 5
10786:                 .Themes         = .F.
10787:                 .ControlSource  = "crSigCdPro.AliqIpis"
10788:                 .Visible        = .T.
10789:             ENDWITH
10790: 
10791:             *-- === Say13: "Excecao da TIPI :" - top=316+29=345, left=495, w=87, h=15 ===
10792:             par_oPage.AddObject("lbl_4c_Label13", "Label")
10793:             WITH par_oPage.lbl_4c_Label13
10794:                 .Top       = 345
10795:                 .Left      = 495
10796:                 .Width     = 87
10797:                 .Height    = 15
10798:                 .FontName  = "Tahoma"
10799:                 .FontSize  = 8
10800:                 .BackStyle = 0
10801:                 .Caption   = "Exce" + CHR(231) + CHR(227) + "o da TIPI :"
10802:                 .ForeColor = RGB(90,90,90)
10803:                 .Visible   = .T.
10804:             ENDWITH
10805: 
10806:             *-- === getextipi: top=311+29=340, left=601, w=35, h=25 ===
10807:             par_oPage.AddObject("txt_4c_Extipi", "TextBox")

*-- Linhas 10816 a 10839:
10816:                 .MaxLength      = 3
10817:                 .Format         = "K"
10818:                 .Themes         = .F.
10819:                 .ControlSource  = "crSigCdPro.extipi"
10820:                 .Visible        = .T.
10821:             ENDWITH
10822: 
10823:             *-- === Say18: "Descricao Fiscal :" - top=341+29=370, left=117, w=84, h=15 ===
10824:             par_oPage.AddObject("lbl_4c_Label18", "Label")
10825:             WITH par_oPage.lbl_4c_Label18
10826:                 .Top       = 370
10827:                 .Left      = 117
10828:                 .Width     = 84
10829:                 .Height    = 15
10830:                 .FontName  = "Tahoma"
10831:                 .FontSize  = 8
10832:                 .BackStyle = 0
10833:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o Fiscal :"
10834:                 .ForeColor = RGB(90,90,90)
10835:                 .Visible   = .T.
10836:             ENDWITH
10837: 
10838:             *-- === btnDescFis: top=359+29=388, left=162, w=32, h=32 ===
10839:             par_oPage.AddObject("cmd_4c_BtnDescFis", "CommandButton")

*-- Linhas 10858 a 10948:
10858:                 .FontSize       = 8
10859:                 .SpecialEffect  = 1
10860:                 .Themes         = .F.
10861:                 .ControlSource  = "crSigCdPro.descfis"
10862:                 .Visible        = .T.
10863:             ENDWITH
10864: 
10865:             *-- === Say9: "Valor do Grama Produzido" - top=320+29=349, left=756, w=125, h=15 ===
10866:             par_oPage.AddObject("lbl_4c_Label9", "Label")
10867:             WITH par_oPage.lbl_4c_Label9
10868:                 .Top       = 349
10869:                 .Left      = 756
10870:                 .Width     = 125
10871:                 .Height    = 15
10872:                 .FontName  = "Tahoma"
10873:                 .FontSize  = 8
10874:                 .BackStyle = 0
10875:                 .Caption   = "Valor do Grama Produzido"
10876:                 .ForeColor = RGB(90,90,90)
10877:                 .Visible   = .T.
10878:             ENDWITH
10879: 
10880:             *-- === grdCmv: top=338+29=367, left=754, w=223, h=141, 3 colunas, ReadOnly ===
10881:             par_oPage.AddObject("grd_4c_Dados", "Grid")
10882:             par_oPage.grd_4c_Dados.Top         = 367
10883:             par_oPage.grd_4c_Dados.Left        = 754
10884:             par_oPage.grd_4c_Dados.Width       = 223
10885:             par_oPage.grd_4c_Dados.Height      = 141
10886:             par_oPage.grd_4c_Dados.ColumnCount = 3
10887:             par_oPage.grd_4c_Dados.FontName    = "Tahoma"
10888:             par_oPage.grd_4c_Dados.FontSize    = 8
10889:             par_oPage.grd_4c_Dados.ReadOnly    = .T.
10890:             par_oPage.grd_4c_Dados.DeleteMark  = .F.
10891:             par_oPage.grd_4c_Dados.RecordMark  = .F.
10892:             par_oPage.grd_4c_Dados.RowHeight   = 17
10893:             par_oPage.grd_4c_Dados.GridLines   = 3
10894:             par_oPage.grd_4c_Dados.ScrollBars  = 3
10895:             par_oPage.grd_4c_Dados.Themes      = .F.
10896:             par_oPage.grd_4c_Dados.Visible     = .T.
10897: 
10898:             par_oPage.grd_4c_Dados.RecordSource = "cursor_4c_Cmv"
10899: 
10900:             par_oPage.grd_4c_Dados.Column1.Header1.Caption  = "Per" + CHR(237) + "odo"
10901:             par_oPage.grd_4c_Dados.Column1.ControlSource    = "cursor_4c_Cmv.Periodo"
10902:             par_oPage.grd_4c_Dados.Column1.Width            = 59
10903:             par_oPage.grd_4c_Dados.Column1.ReadOnly         = .T.
10904:             par_oPage.grd_4c_Dados.Column1.Movable          = .F.
10905:             par_oPage.grd_4c_Dados.Column1.Resizable        = .F.
10906:             par_oPage.grd_4c_Dados.Column1.FontName         = "Tahoma"
10907:             par_oPage.grd_4c_Dados.Column1.FontSize         = 8
10908:             par_oPage.grd_4c_Dados.Column1.Header1.FontBold = .T.
10909:             par_oPage.grd_4c_Dados.Column1.Header1.Alignment = 2
10910: 
10911:             par_oPage.grd_4c_Dados.Column2.Header1.Caption  = "Valor Custo GR"
10912:             par_oPage.grd_4c_Dados.Column2.ControlSource    = "cursor_4c_Cmv.ValGR"
10913:             par_oPage.grd_4c_Dados.Column2.Width            = 100
10914:             par_oPage.grd_4c_Dados.Column2.ReadOnly         = .T.
10915:             par_oPage.grd_4c_Dados.Column2.Movable          = .F.
10916:             par_oPage.grd_4c_Dados.Column2.Resizable        = .F.
10917:             par_oPage.grd_4c_Dados.Column2.FontName         = "Tahoma"
10918:             par_oPage.grd_4c_Dados.Column2.FontSize         = 8
10919:             par_oPage.grd_4c_Dados.Column2.Header1.FontBold = .T.
10920:             par_oPage.grd_4c_Dados.Column2.Header1.Alignment = 2
10921: 
10922:             par_oPage.grd_4c_Dados.Column3.Header1.Caption  = "Moe"
10923:             par_oPage.grd_4c_Dados.Column3.ControlSource    = "cursor_4c_Cmv.Moe"
10924:             par_oPage.grd_4c_Dados.Column3.Width            = 31
10925:             par_oPage.grd_4c_Dados.Column3.ReadOnly         = .T.
10926:             par_oPage.grd_4c_Dados.Column3.FontName         = "Tahoma"
10927:             par_oPage.grd_4c_Dados.Column3.Header1.FontBold = .T.
10928:             par_oPage.grd_4c_Dados.Column3.Header1.Alignment = 2
10929: 
10930:             *-- === Say12: "Descricao ECF :" - top=433+29=462, left=124, w=77, h=15 ===
10931:             par_oPage.AddObject("lbl_4c_Label12", "Label")
10932:             WITH par_oPage.lbl_4c_Label12
10933:                 .Top       = 462
10934:                 .Left      = 124
10935:                 .Width     = 77
10936:                 .Height    = 15
10937:                 .FontName  = "Tahoma"
10938:                 .FontSize  = 8
10939:                 .BackStyle = 0
10940:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o ECF :"
10941:                 .ForeColor = RGB(90,90,90)
10942:                 .Visible   = .T.
10943:             ENDWITH
10944: 
10945:             *-- === getDescEcfs: top=429+29=458, left=206, w=213, h=23 ===
10946:             par_oPage.AddObject("txt_4c_DescEcfs", "TextBox")
10947:             WITH par_oPage.txt_4c_DescEcfs
10948:                 .Top            = 458

*-- Linhas 10954 a 10977:
10954:                 .SpecialEffect  = 1
10955:                 .MaxLength      = 29
10956:                 .Themes         = .F.
10957:                 .ControlSource  = "crSigCdPro.descecfs"
10958:                 .Visible        = .T.
10959:             ENDWITH
10960: 
10961:             *-- === Say11: "Metal :" - top=433+29=462, left=494, w=35 ===
10962:             par_oPage.AddObject("lbl_4c_Label11", "Label")
10963:             WITH par_oPage.lbl_4c_Label11
10964:                 .Top       = 462
10965:                 .Left      = 494
10966:                 .Width     = 35
10967:                 .FontName  = "Tahoma"
10968:                 .FontSize  = 8
10969:                 .BackStyle = 0
10970:                 .Caption   = "Metal :"
10971:                 .ForeColor = RGB(90,90,90)
10972:                 .Visible   = .T.
10973:             ENDWITH
10974: 
10975:             *-- === Get_metal: top=429+29=458, left=537, w=24, h=23 ===
10976:             par_oPage.AddObject("txt_4c_Metal", "TextBox")
10977:             WITH par_oPage.txt_4c_Metal

*-- Linhas 10983 a 11006:
10983:                 .FontSize       = 8
10984:                 .SpecialEffect  = 1
10985:                 .Themes         = .F.
10986:                 .ControlSource  = "crSigCdPro.metals"
10987:                 .Visible        = .T.
10988:             ENDWITH
10989: 
10990:             *-- === Get_DesMetal: top=429+29=458, left=564, w=150, h=23 ===
10991:             par_oPage.AddObject("txt_4c_DesMetal", "TextBox")
10992:             WITH par_oPage.txt_4c_DesMetal
10993:                 .Top            = 458
10994:                 .Left           = 564
10995:                 .Width          = 150
10996:                 .Height         = 23
10997:                 .FontName       = "Tahoma"
10998:                 .FontSize       = 8
10999:                 .SpecialEffect  = 1
11000:                 .Format         = "!"
11001:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXXXXX"
11002:                 .MaxLength      = 20
11003:                 .Themes         = .F.
11004:                 .ReadOnly       = .T.
11005:                 .Visible        = .T.
11006:             ENDWITH

*-- Linhas 11033 a 11072:
11033:                 .InputMask      = "999,999,999.99"
11034:                 .MaxLength      = 14
11035:                 .Themes         = .F.
11036:                 .ControlSource  = "crSigCdPro.valors"
11037:                 .Visible        = .T.
11038:             ENDWITH
11039: 
11040:             *-- === GetMvalor: top=454+29=483, left=317, w=31, h=23 ===
11041:             par_oPage.AddObject("txt_4c_Mvalor", "TextBox")
11042:             WITH par_oPage.txt_4c_Mvalor
11043:                 .Top            = 483
11044:                 .Left           = 317
11045:                 .Width          = 31
11046:                 .Height         = 23
11047:                 .FontName       = "Tahoma"
11048:                 .FontSize       = 8
11049:                 .SpecialEffect  = 1
11050:                 .MaxLength      = 3
11051:                 .Themes         = .F.
11052:                 .ControlSource  = "crSigCdPro.moedas"
11053:                 .Visible        = .T.
11054:             ENDWITH
11055: 
11056:             *-- === Say15: "Teor :" - top=458+29=487, left=498, w=31 ===
11057:             par_oPage.AddObject("lbl_4c_Label15", "Label")
11058:             WITH par_oPage.lbl_4c_Label15
11059:                 .Top       = 487
11060:                 .Left      = 498
11061:                 .Width     = 31
11062:                 .FontName  = "Tahoma"
11063:                 .FontSize  = 8
11064:                 .BackStyle = 0
11065:                 .Caption   = "Teor :"
11066:                 .ForeColor = RGB(90,90,90)
11067:                 .Visible   = .T.
11068:             ENDWITH
11069: 
11070:             *-- === Get_teor: top=454+29=483, left=537, w=24, h=23 ===
11071:             par_oPage.AddObject("txt_4c_Teor", "TextBox")
11072:             WITH par_oPage.txt_4c_Teor

*-- Linhas 11078 a 11101:
11078:                 .FontSize       = 8
11079:                 .SpecialEffect  = 1
11080:                 .Themes         = .F.
11081:                 .ControlSource  = "crSigCdPro.teors"
11082:                 .Visible        = .T.
11083:             ENDWITH
11084: 
11085:             *-- === Get_DesTeor: top=454+29=483, left=564, w=150, h=23 ===
11086:             par_oPage.AddObject("txt_4c_DesTeor", "TextBox")
11087:             WITH par_oPage.txt_4c_DesTeor
11088:                 .Top            = 483
11089:                 .Left           = 564
11090:                 .Width          = 150
11091:                 .Height         = 23
11092:                 .FontName       = "Tahoma"
11093:                 .FontSize       = 8
11094:                 .SpecialEffect  = 1
11095:                 .Format         = "!"
11096:                 .InputMask      = "XXXXXXXXXXXXXXXXXXXX"
11097:                 .MaxLength      = 20
11098:                 .Themes         = .F.
11099:                 .ReadOnly       = .T.
11100:                 .Visible        = .T.
11101:             ENDWITH

*-- Linhas 11266 a 11290:
11266:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11267:                 "cursor_4c_BuscaClf", "Codigos", loc_cCodigo, ;
11268:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11269:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11270:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11271:             loc_oBusca.Show()
11272:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11273:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11274:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11275:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11276:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11277:             ELSE
11278:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11279:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11280:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11281:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11282:             ENDIF
11283:             IF USED("cursor_4c_BuscaClf")
11284:                 USE IN cursor_4c_BuscaClf
11285:             ENDIF
11286:             loc_oBusca.Release()
11287:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11288:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11289:         CATCH TO loc_oErro
11290:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup classifica" + CHR(231) + CHR(227) + "o fiscal")

*-- Linhas 11312 a 11336:
11312:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdClf", ;
11313:                 "cursor_4c_BuscaClf", "Descricaos", loc_cDescricao, ;
11314:                 "Classifica" + CHR(231) + CHR(227) + "o Fiscal")
11315:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11316:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11317:             loc_oBusca.Show()
11318:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
11319:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ALLTRIM(cursor_4c_BuscaClf.Codigos)
11320:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ALLTRIM(cursor_4c_BuscaClf.Descricaos)
11321:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .T.
11322:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .T.
11323:             ELSE
11324:                 loc_oPgFisc.txt_4c_Clfiscal.Value  = ""
11325:                 loc_oPgFisc.txt_4c_Dclfiscal.Value = ""
11326:                 loc_oPgFisc.lbl_4c__AliqIPI.Enabled = .F.
11327:                 loc_oPgFisc.txt_4c_AliqIPI.Enabled  = .F.
11328:             ENDIF
11329:             IF USED("cursor_4c_BuscaClf")
11330:                 USE IN cursor_4c_BuscaClf
11331:             ENDIF
11332:             loc_oBusca.Release()
11333:             loc_oPgFisc.txt_4c_Clfiscal.Refresh
11334:             loc_oPgFisc.txt_4c_Dclfiscal.Refresh
11335:         CATCH TO loc_oErro
11336:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o fiscal")

*-- Linhas 11366 a 11390:
11366:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11367:                 "cursor_4c_BuscaOrg", "Codigos", loc_cCodigo, ;
11368:                 "Origem da Mercadoria")
11369:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11370:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11371:             loc_oBusca.Show()
11372:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11373:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11374:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11375:             ELSE
11376:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11377:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11378:             ENDIF
11379:             IF USED("cursor_4c_BuscaOrg")
11380:                 USE IN cursor_4c_BuscaOrg
11381:             ENDIF
11382:             loc_oBusca.Release()
11383:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11384:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11385:         CATCH TO loc_oErro
11386:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup origem mercadoria")
11387:         ENDTRY
11388:     ENDPROC
11389: 
11390:     PROCEDURE DorigmercKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 11408 a 11432:
11408:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdOrg", ;
11409:                 "cursor_4c_BuscaOrg", "Descricaos", loc_cDescricao, ;
11410:                 "Origem da Mercadoria")
11411:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11412:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11413:             loc_oBusca.Show()
11414:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOrg")
11415:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ALLTRIM(cursor_4c_BuscaOrg.Codigos)
11416:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ALLTRIM(cursor_4c_BuscaOrg.Descricaos)
11417:             ELSE
11418:                 loc_oPgFisc.txt_4c_Origmerc.Value  = ""
11419:                 loc_oPgFisc.txt_4c_Dorigmerc.Value = ""
11420:             ENDIF
11421:             IF USED("cursor_4c_BuscaOrg")
11422:                 USE IN cursor_4c_BuscaOrg
11423:             ENDIF
11424:             loc_oBusca.Release()
11425:             loc_oPgFisc.txt_4c_Origmerc.Refresh
11426:             loc_oPgFisc.txt_4c_Dorigmerc.Refresh
11427:         CATCH TO loc_oErro
11428:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o origem")
11429:         ENDTRY
11430:     ENDPROC
11431: 
11432:     PROCEDURE SittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 11458 a 11482:
11458:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11459:                 "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11460:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11461:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11462:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11463:             loc_oBusca.Show()
11464:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11465:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11466:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11467:             ELSE
11468:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11469:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11470:             ENDIF
11471:             IF USED("cursor_4c_BuscaIcm")
11472:                 USE IN cursor_4c_BuscaIcm
11473:             ENDIF
11474:             loc_oBusca.Release()
11475:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11476:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11477:         CATCH TO loc_oErro
11478:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup situa" + CHR(231) + CHR(227) + "o ICMS")
11479:         ENDTRY
11480:     ENDPROC
11481: 
11482:     PROCEDURE DsittricmKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 11500 a 11524:
11500:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11501:                 "cursor_4c_BuscaIcm", "Descricaos", loc_cDescricao, ;
11502:                 "Situa" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria ICMS")
11503:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11504:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11505:             loc_oBusca.Show()
11506:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11507:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11508:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11509:             ELSE
11510:                 loc_oPgFisc.txt_4c_Sittricm.Value  = ""
11511:                 loc_oPgFisc.txt_4c_Dsittricm.Value = ""
11512:             ENDIF
11513:             IF USED("cursor_4c_BuscaIcm")
11514:                 USE IN cursor_4c_BuscaIcm
11515:             ENDIF
11516:             loc_oBusca.Release()
11517:             loc_oPgFisc.txt_4c_Sittricm.Refresh
11518:             loc_oPgFisc.txt_4c_Dsittricm.Refresh
11519:         CATCH TO loc_oErro
11520:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup descri" + CHR(231) + CHR(227) + "o ICMS")
11521:         ENDTRY
11522:     ENDPROC
11523: 
11524:     PROCEDURE CodServsFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)

*-- Linhas 11531 a 11555:
11531:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdIcm", ;
11532:                         "cursor_4c_BuscaIcm", "Codigos", loc_cCodigo, ;
11533:                         "C" + CHR(243) + "digo ICMS")
11534:                     loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
11535:                     loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
11536:                     loc_oBusca.Show()
11537:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaIcm")
11538:                         loc_oPgFisc.txt_4c_Sittricm.Value  = ALLTRIM(cursor_4c_BuscaIcm.Codigos)
11539:                         loc_oPgFisc.txt_4c_Dsittricm.Value = ALLTRIM(cursor_4c_BuscaIcm.Descricaos)
11540:                     ENDIF
11541:                     IF USED("cursor_4c_BuscaIcm")
11542:                         USE IN cursor_4c_BuscaIcm
11543:                     ENDIF
11544:                     loc_oBusca.Release()
11545:                     loc_oPgFisc.txt_4c_Sittricm.Refresh
11546:                     loc_oPgFisc.txt_4c_Dsittricm.Refresh
11547:                 ENDIF
11548:             ENDIF
11549:         CATCH TO loc_oErro
11550:             MsgErro(loc_oErro.Message, "Erro ao validar c" + CHR(243) + "digo servi" + CHR(231) + "os ICMS")
11551:         ENDTRY
11552:     ENDPROC
11553: 
11554:     PROCEDURE TpTribKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11555:         TRY

*-- Linhas 11580 a 11604:
11580:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigPrTri", ;
11581:                 "cursor_4c_BuscaTri", "Tipos", loc_cCodigo, ;
11582:                 "Tipo de Tributa" + CHR(231) + CHR(227) + "o")
11583:             loc_oBusca.mAddColuna("Tipos", "", "Tipo")
11584:             loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
11585:             loc_oBusca.Show()
11586:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTri")
11587:                 loc_oPgFisc.txt_4c_TpTrib.Value = ALLTRIM(cursor_4c_BuscaTri.Tipos)
11588:             ELSE
11589:                 loc_oPgFisc.txt_4c_TpTrib.Value = ""
11590:             ENDIF
11591:             IF USED("cursor_4c_BuscaTri")
11592:                 USE IN cursor_4c_BuscaTri
11593:             ENDIF
11594:             loc_oBusca.Release()
11595:             loc_oPgFisc.txt_4c_TpTrib.Refresh
11596:         CATCH TO loc_oErro
11597:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup tipo tributa" + CHR(231) + CHR(227) + "o")
11598:         ENDTRY
11599:     ENDPROC
11600: 
11601:     PROCEDURE IatFiscKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11602:         LOCAL loc_oPgFisc, loc_oErro
11603:         TRY
11604:             IF par_nKeyCode = 13 OR par_nKeyCode = 9

*-- Linhas 11674 a 11698:
11674:             loc_cCodigo = ALLTRIM(loc_oPgFisc.txt_4c_Mvalor.Value)
11675:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
11676:                 "cursor_4c_BuscaMoe", "CMoes", loc_cCodigo, "Moeda")
11677:             loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
11678:             loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
11679:             loc_oBusca.Show()
11680:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
11681:                 loc_oPgFisc.txt_4c_Mvalor.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
11682:             ELSE
11683:                 loc_oPgFisc.txt_4c_Mvalor.Value = ""
11684:             ENDIF
11685:             IF USED("cursor_4c_BuscaMoe")
11686:                 USE IN cursor_4c_BuscaMoe
11687:             ENDIF
11688:             loc_oBusca.Release()
11689:             loc_oPgFisc.txt_4c_Mvalor.Refresh
11690:         CATCH TO loc_oErro
11691:             MsgErro(loc_oErro.Message, "Erro ao abrir lookup moeda")
11692:         ENDTRY
11693:     ENDPROC
11694: 
11695:     PROCEDURE MetalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
11696:         TRY
11697:             IF par_nKeyCode = 115
11698:                 THIS.AbrirLookupMetal()

*-- Linhas 11814 a 11922:
11814:         LOCAL loc_oGrd, loc_oGrdArq, loc_oErro
11815:         TRY
11816:             *-- === Criar cursores placeholder ANTES dos grids ===
11817:             SET NULL ON
11818:             IF USED("crSigPrTar")
11819:                 USE IN crSigPrTar
11820:             ENDIF
11821:             CREATE CURSOR crSigPrTar (;
11822:                 CPros    C(14)  NULL, ;
11823:                 pkChaves C(30)  NULL, ;
11824:                 DtInis   T      NULL, ;
11825:                 DtFims   T      NULL, ;
11826:                 Usuars   C(20)  NULL, ;
11827:                 Tarefas  C(10)  NULL, ;
11828:                 ObsTars  M      NULL  ;
11829:             )
11830:             IF USED("crSigPrArq")
11831:                 USE IN crSigPrArq
11832:             ENDIF
11833:             CREATE CURSOR crSigPrArq (;
11834:                 CPros    C(14)  NULL, ;
11835:                 pkChaves C(30)  NULL, ;
11836:                 Arquivos C(254) NULL  ;
11837:             )
11838:             SET NULL OFF
11839: 
11840:             *-- === lbl_4c_ObsTar (Say31): top=144+29=173, left=583, w=126, h=15 ===
11841:             par_oPage.AddObject("lbl_4c_ObsTar", "Label")
11842:             WITH par_oPage.lbl_4c_ObsTar
11843:                 .Top       = 173
11844:                 .Left      = 583
11845:                 .Width     = 126
11846:                 .Height    = 15
11847:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Tarefa"
11848:                 .FontName  = "Tahoma"
11849:                 .FontSize  = 8
11850:                 .AutoSize  = .F.
11851:                 .BackStyle = 0
11852:                 .ForeColor = RGB(0, 0, 0)
11853:                 .Visible   = .T.
11854:             ENDWITH
11855: 
11856:             *-- === grd_4c_Designer (grdDesigner): top=160+29=189, left=10, w=495, h=238 ===
11857:             par_oPage.AddObject("grd_4c_Designer", "Grid")
11858:             loc_oGrd = par_oPage.grd_4c_Designer
11859:             loc_oGrd.Top         = 189
11860:             loc_oGrd.Left        = 10
11861:             loc_oGrd.Width       = 495
11862:             loc_oGrd.Height      = 238
11863:             loc_oGrd.ColumnCount = 4
11864:             loc_oGrd.FontName    = "Tahoma"
11865:             loc_oGrd.FontSize    = 8
11866:             loc_oGrd.GridLines   = 3
11867:             loc_oGrd.DeleteMark  = .F.
11868:             loc_oGrd.RecordMark  = .F.
11869:             loc_oGrd.RowHeight   = 16
11870:             loc_oGrd.ScrollBars  = 3
11871:             loc_oGrd.Themes      = .F.
11872:             loc_oGrd.Visible     = .T.
11873: 
11874:             loc_oGrd.RecordSource = "crSigPrTar"
11875: 
11876:             loc_oGrd.Column1.Header1.Caption  = "Data de In" + CHR(237) + "cio"
11877:             loc_oGrd.Column1.ControlSource    = "crSigPrTar.DtInis"
11878:             loc_oGrd.Column1.Width            = 110
11879:             loc_oGrd.Column1.ReadOnly         = .T.
11880:             loc_oGrd.Column1.Header1.FontBold = .T.
11881: 
11882:             loc_oGrd.Column2.Header1.Caption  = "Data de Conclus" + CHR(227) + "o"
11883:             loc_oGrd.Column2.ControlSource    = "crSigPrTar.DtFims"
11884:             loc_oGrd.Column2.Width            = 120
11885:             loc_oGrd.Column2.ReadOnly         = .T.
11886:             loc_oGrd.Column2.Header1.FontBold = .T.
11887: 
11888:             loc_oGrd.Column3.Header1.Caption  = "Usu" + CHR(225) + "rio"
11889:             loc_oGrd.Column3.ControlSource    = "crSigPrTar.Usuars"
11890:             loc_oGrd.Column3.Width            = 100
11891:             loc_oGrd.Column3.ReadOnly         = .T.
11892:             loc_oGrd.Column3.Header1.FontBold = .T.
11893: 
11894:             loc_oGrd.Column4.Header1.Caption  = "Tarefa"
11895:             loc_oGrd.Column4.ControlSource    = "crSigPrTar.Tarefas"
11896:             loc_oGrd.Column4.Width            = 165
11897:             loc_oGrd.Column4.ReadOnly         = .T.
11898:             loc_oGrd.Column4.Header1.FontBold = .T.
11899: 
11900:             *-- BINDEVENTs para grd_4c_Designer
11901:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "DesignerAfterRowColChange")
11902:             BINDEVENT(loc_oGrd.Column4.Text1, "KeyPress", THIS, "DesignerCol4KeyPress")
11903: 
11904:             *-- === cmd_4c_BtnIniTarefa (btnIniTarefa): top=161+29=190, left=509, w=42, h=42 ===
11905:             par_oPage.AddObject("cmd_4c_BtnIniTarefa", "CommandButton")
11906:             WITH par_oPage.cmd_4c_BtnIniTarefa
11907:                 .Top     = 190
11908:                 .Left    = 509
11909:                 .Width   = 42
11910:                 .Height  = 42
11911:                 .Caption = ""
11912:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
11913:                 .Themes  = .F.
11914:                 .Visible = .T.
11915:             ENDWITH
11916:             BINDEVENT(par_oPage.cmd_4c_BtnIniTarefa, "Click", THIS, "BtnIniTarefaClick")
11917: 
11918:             *-- === cmd_4c_BtnFimTarefa (btnFimTarefa): top=203+29=232, left=509, w=42, h=42 ===
11919:             par_oPage.AddObject("cmd_4c_BtnFimTarefa", "CommandButton")
11920:             WITH par_oPage.cmd_4c_BtnFimTarefa
11921:                 .Top     = 232
11922:                 .Left    = 509

*-- Linhas 11936 a 12007:
11936:                 .Left        = 584
11937:                 .Width       = 407
11938:                 .Height      = 238
11939:                 .ControlSource = "crSigPrTar.ObsTars"
11940:                 .FontName    = "Tahoma"
11941:                 .FontSize    = 8
11942:                 .ScrollBars  = 2
11943:                 .ReadOnly    = .T.
11944:                 .Themes      = .F.
11945:                 .Visible     = .T.
11946:             ENDWITH
11947: 
11948:             *-- === shp_4c_Shape1 (Shape1): top=415+29=444, left=584, w=407, h=202 ===
11949:             par_oPage.AddObject("shp_4c_Shape1", "Shape")
11950:             WITH par_oPage.shp_4c_Shape1
11951:                 .Top         = 444
11952:                 .Left        = 584
11953:                 .Width       = 407
11954:                 .Height      = 202
11955:                 .BackColor   = RGB(255, 255, 255)
11956:                 .BackStyle   = 1
11957:                 .BorderStyle = 1
11958:                 .Visible     = .T.
11959:             ENDWITH
11960: 
11961:             *-- === grd_4c_Arquivos (grdArquivos): top=415+29=444, left=10, w=495, h=202 ===
11962:             par_oPage.AddObject("grd_4c_Arquivos", "Grid")
11963:             loc_oGrdArq = par_oPage.grd_4c_Arquivos
11964:             loc_oGrdArq.Top         = 444
11965:             loc_oGrdArq.Left        = 10
11966:             loc_oGrdArq.Width       = 495
11967:             loc_oGrdArq.Height      = 202
11968:             loc_oGrdArq.ColumnCount = 1
11969:             loc_oGrdArq.FontName    = "Tahoma"
11970:             loc_oGrdArq.FontSize    = 8
11971:             loc_oGrdArq.GridLines   = 3
11972:             loc_oGrdArq.DeleteMark  = .F.
11973:             loc_oGrdArq.RecordMark  = .F.
11974:             loc_oGrdArq.RowHeight   = 16
11975:             loc_oGrdArq.ScrollBars  = 3
11976:             loc_oGrdArq.Themes      = .F.
11977:             loc_oGrdArq.Visible     = .T.
11978: 
11979:             loc_oGrdArq.RecordSource = "crSigPrArq"
11980: 
11981:             loc_oGrdArq.Column1.Header1.Caption  = "Arquivos Para Designer"
11982:             loc_oGrdArq.Column1.ControlSource    = "crSigPrArq.Arquivos"
11983:             loc_oGrdArq.Column1.Width            = 495
11984:             loc_oGrdArq.Column1.ReadOnly         = .T.
11985:             loc_oGrdArq.Column1.Header1.FontBold = .T.
11986: 
11987:             *-- BINDEVENTs para grd_4c_Arquivos
11988:             BINDEVENT(loc_oGrdArq, "AfterRowColChange", THIS, "ArquivosAfterRowColChange")
11989: 
11990:             *-- === cmd_4c_BtnInsArqs (btnInsArqs): top=416+29=445, left=509, w=42, h=42 ===
11991:             par_oPage.AddObject("cmd_4c_BtnInsArqs", "CommandButton")
11992:             WITH par_oPage.cmd_4c_BtnInsArqs
11993:                 .Top     = 445
11994:                 .Left    = 509
11995:                 .Width   = 42
11996:                 .Height  = 42
11997:                 .Caption = ""
11998:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
11999:                 .Themes  = .F.
12000:                 .Visible = .T.
12001:             ENDWITH
12002:             BINDEVENT(par_oPage.cmd_4c_BtnInsArqs, "Click", THIS, "BtnInsArqsClick")
12003: 
12004:             *-- === cmd_4c_BtnExcArqs (btnExcArqs): top=458+29=487, left=509, w=42, h=42 ===
12005:             par_oPage.AddObject("cmd_4c_BtnExcArqs", "CommandButton")
12006:             WITH par_oPage.cmd_4c_BtnExcArqs
12007:                 .Top     = 487

*-- Linhas 12082 a 12131:
12082:                     ENDIF
12083:                     SELECT crSigPrTar
12084:                     GO TOP
12085:                     loc_oPgDesigner.grd_4c_Designer.Refresh()
12086:                     THIS.DesignerAfterRowColChange(0)
12087:                 ELSE
12088:                     IF USED("cursor_4c_TarTemp")
12089:                         USE IN cursor_4c_TarTemp
12090:                     ENDIF
12091:                 ENDIF
12092: 
12093:                 *-- Carregar crSigPrArq de SigPrArq
12094:                 IF USED("cursor_4c_ArqTemp")
12095:                     USE IN cursor_4c_ArqTemp
12096:                 ENDIF
12097:                 loc_cSQL = "SELECT CPros, pkChaves, Arquivos FROM SigPrArq " + ;
12098:                            "WHERE CPros = " + EscaparSQL(PADR(loc_cCPros, 14))
12099:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqTemp")
12100:                 IF loc_nRet > 0
12101:                     SELECT crSigPrArq
12102:                     ZAP
12103:                     IF RECCOUNT("cursor_4c_ArqTemp") > 0
12104:                         APPEND FROM DBF("cursor_4c_ArqTemp")
12105:                     ENDIF
12106:                     IF USED("cursor_4c_ArqTemp")
12107:                         USE IN cursor_4c_ArqTemp
12108:                     ENDIF
12109:                     SELECT crSigPrArq
12110:                     GO TOP
12111:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12112:                     THIS.ArquivosAfterRowColChange(0)
12113:                 ELSE
12114:                     IF USED("cursor_4c_ArqTemp")
12115:                         USE IN cursor_4c_ArqTemp
12116:                     ENDIF
12117:                 ENDIF
12118: 
12119:                 *-- Carregar crTarefas de SigCdCad (se ainda nao carregado)
12120:                 IF !USED("crTarefas")
12121:                     THIS.CarregarTarefas()
12122:                 ENDIF
12123:             ENDIF
12124:         CATCH TO loc_oErro
12125:             MsgErro(loc_oErro.Message, "Erro ao carregar Designer")
12126:         ENDTRY
12127:     ENDPROC
12128: 
12129:     *==========================================================================
12130:     * CarregarTarefas - Carrega lista de tarefas de SigCdCad (lookup)
12131:     *==========================================================================

*-- Linhas 12164 a 12198:
12164:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12165:             *-- Atualizar editbox de observacoes da tarefa
12166:             loc_oPgDesigner.obj_4c_GetObsTarefas.Refresh()
12167:             *-- Controlar editabilidade da coluna Tarefa (Column4)
12168:             loc_lPodeEditar = .F.
12169:             IF INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12170:                 IF USED("crSigPrTar") AND !EOF("crSigPrTar") AND !BOF("crSigPrTar")
12171:                     SELECT crSigPrTar
12172:                     IF ALLTRIM(NVL(Usuars, "")) == ALLTRIM(gc_4c_UsuarioLogado) ;
12173:                        AND EMPTY(NVL(DtFims, {}))
12174:                         loc_lPodeEditar = .T.
12175:                     ENDIF
12176:                 ENDIF
12177:             ENDIF
12178:             loc_oPgDesigner.grd_4c_Designer.Column4.ReadOnly = !loc_lPodeEditar
12179:         CATCH TO loc_oErro
12180:             *-- Tolerado: controle da coluna nao critico
12181:         ENDTRY
12182:     ENDPROC
12183: 
12184:     *==========================================================================
12185:     * DesignerCol4KeyPress - F4 abre lookup de Tarefa (crTarefas/SigCdCad)
12186:     *==========================================================================
12187:     PROCEDURE DesignerCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
12188:         LOCAL loc_oErro
12189:         TRY
12190:             IF par_nKeyCode = 115
12191:                 THIS.AbrirLookupDesignerTarefa()
12192:             ENDIF
12193:         CATCH TO loc_oErro
12194:             *-- Tolerado
12195:         ENDTRY
12196:     ENDPROC
12197: 
12198:     *==========================================================================

*-- Linhas 12214 a 12251:
12214:                 RETURN
12215:             ENDIF
12216:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12217:             loc_oGrd   = loc_oPgDesigner.grd_4c_Designer
12218:             loc_cCodCads = ALLTRIM(loc_oGrd.Column4.Text1.Value)
12219:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
12220:                 "crTarefas", "cursor_4c_BuscaTar", "CodCads", loc_cCodCads, ;
12221:                 "Busca de Tarefas", .F.)
12222:             IF VARTYPE(loc_oBusca) = "O"
12223:                 IF loc_oBusca.this_lSelecionou
12224:                     IF USED("cursor_4c_BuscaTar") AND RECCOUNT("cursor_4c_BuscaTar") > 0
12225:                         SELECT cursor_4c_BuscaTar
12226:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12227:                         loc_oGrd.Refresh()
12228:                     ENDIF
12229:                 ELSE
12230:                     loc_oBusca.mAddColuna("CodCads",  "", "C" + CHR(243) + "digo")
12231:                     loc_oBusca.mAddColuna("DesCads",  "", "Descri" + CHR(231) + CHR(227) + "o")
12232:                     loc_oBusca.Show()
12233:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTar")
12234:                         SELECT cursor_4c_BuscaTar
12235:                         REPLACE crSigPrTar.Tarefas WITH ALLTRIM(CodCads)
12236:                         loc_oGrd.Refresh()
12237:                     ENDIF
12238:                 ENDIF
12239:                 loc_oBusca.Release()
12240:             ENDIF
12241:             IF USED("cursor_4c_BuscaTar")
12242:                 USE IN cursor_4c_BuscaTar
12243:             ENDIF
12244:         CATCH TO loc_oErro
12245:             MsgErro(loc_oErro.Message, "Erro ao buscar tarefa")
12246:         ENDTRY
12247:     ENDPROC
12248: 
12249:     *==========================================================================
12250:     * BtnIniTarefaClick - Inicia nova tarefa (INSERT Into crSigPrTar)
12251:     *==========================================================================

*-- Linhas 12291 a 12314:
12291:                             loc_dtAgora, ;
12292:                             PADR(ALLTRIM(gc_4c_UsuarioLogado), 20))
12293:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12294:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12295:             ENDIF
12296:         CATCH TO loc_oErro
12297:             MsgErro(loc_oErro.Message, "Erro ao iniciar tarefa")
12298:         ENDTRY
12299:     ENDPROC
12300: 
12301:     *==========================================================================
12302:     * BtnFimTarefaClick - Finaliza tarefa atual (Replace DtFims)
12303:     *==========================================================================
12304:     PROCEDURE BtnFimTarefaClick()
12305:         LOCAL loc_oPgDesigner, loc_dtAgora, loc_lContinuar, loc_oErro
12306:         loc_lContinuar = .T.
12307:         TRY
12308:             IF !INLIST(this_cModoAtual, "INCLUIR", "ALTERAR")
12309:                 loc_lContinuar = .F.
12310:             ENDIF
12311:             IF loc_lContinuar AND (!USED("crSigPrTar") OR EOF("crSigPrTar") OR BOF("crSigPrTar"))
12312:                 loc_lContinuar = .F.
12313:             ENDIF
12314:             IF loc_lContinuar

*-- Linhas 12333 a 12356:
12333:                 loc_dtAgora = DATETIME()
12334:                 REPLACE DtFims WITH loc_dtAgora IN crSigPrTar
12335:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12336:                 loc_oPgDesigner.grd_4c_Designer.Refresh()
12337:                 THIS.DesignerAfterRowColChange(0)
12338:             ENDIF
12339:         CATCH TO loc_oErro
12340:             MsgErro(loc_oErro.Message, "Erro ao finalizar tarefa")
12341:         ENDTRY
12342:     ENDPROC
12343: 
12344:     *==========================================================================
12345:     * ArquivosAfterRowColChange - Exibe preview de imagem para arquivo selecionado
12346:     *==========================================================================
12347:     PROCEDURE ArquivosAfterRowColChange(par_nColIndex)
12348:         LOCAL loc_oPgDesigner, loc_cArq, loc_cExt, loc_oErro
12349:         TRY
12350:             IF gb_4c_ValidandoUI
12351:                 RETURN
12352:             ENDIF
12353:             loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12354:             loc_oPgDesigner.img_4c_ImgArqJpg.Picture = ""
12355:             loc_oPgDesigner.img_4c_ImgArqJpg.Visible = .F.
12356:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")

*-- Linhas 12391 a 12414:
12391:                                 PADR(SYS(2015), 30), ;
12392:                                 UPPER(loc_cArq))
12393:                     loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12394:                     loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12395:                 ENDIF
12396:             ENDIF
12397:         CATCH TO loc_oErro
12398:             MsgErro(loc_oErro.Message, "Erro ao inserir arquivo")
12399:         ENDTRY
12400:     ENDPROC
12401: 
12402:     *==========================================================================
12403:     * BtnOpnArqsClick - Abre arquivo selecionado com Shell.Application
12404:     *==========================================================================
12405:     PROCEDURE BtnOpnArqsClick()
12406:         LOCAL loc_cArq, loc_oShell, loc_lContinuar, loc_oErro
12407:         loc_lContinuar = .T.
12408:         TRY
12409:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12410:                 loc_lContinuar = .F.
12411:             ENDIF
12412:             IF loc_lContinuar
12413:                 SELECT crSigPrArq
12414:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))

*-- Linhas 12454 a 12477:
12454:                     ENDIF
12455:                 ENDIF
12456:                 loc_oPgDesigner = THIS.pgf_4c_Paginas.Page2.pgf_4c_DadosInterno.Page7
12457:                 loc_oPgDesigner.grd_4c_Arquivos.Refresh()
12458:                 THIS.ArquivosAfterRowColChange(0)
12459:             ENDIF
12460:         CATCH TO loc_oErro
12461:             MsgErro(loc_oErro.Message, "Erro ao excluir arquivo")
12462:         ENDTRY
12463:     ENDPROC
12464: 
12465:     *==========================================================================
12466:     * ImgArqJpgClick - Zoom na imagem (abre SigOpZom se for imagem valida)
12467:     *==========================================================================
12468:     PROCEDURE ImgArqJpgClick()
12469:         LOCAL loc_cArq, loc_cExt, loc_lContinuar, loc_oErro
12470:         loc_lContinuar = .T.
12471:         TRY
12472:             IF !USED("crSigPrArq") OR EOF("crSigPrArq") OR BOF("crSigPrArq")
12473:                 loc_lContinuar = .F.
12474:             ENDIF
12475:             IF loc_lContinuar
12476:                 SELECT crSigPrArq
12477:                 loc_cArq = ALLTRIM(NVL(Arquivos, ""))


### BO (C:\4c\projeto\app\classes\ProdutoBO.prg):
*==============================================================================
* ProdutoBO.prg - Business Object para Cadastro de Produtos (SigCdPro)
* Gerado: Fase 8/8 - Completo, tabela SigCdPro
*==============================================================================

DEFINE CLASS ProdutoBO AS BusinessBase

    *-- Identificacao
    this_cCpros       = ""    && CPros  char(14) - PK: codigo do produto
    *-- Descricoes
    this_cDpros       = ""    && DPros  - descricao principal
    this_cDPro2s      = ""    && DPro2s - descricao secundaria
    this_cDPro3s      = ""    && DPro3s - descricao memo (editbox)
    *-- Grupo / Subgrupo
    this_cCgrus       = ""    && CGrus  - codigo do grupo
    this_cSGrus       = ""    && SGrus  - codigo do subgrupo
    *-- Fornecedor / Referencia / Colecao
    this_cIFors       = ""    && IFors  - codigo do fornecedor
    this_cReffs       = ""    && Reffs  - referencia do fornecedor
    this_cColecoes    = ""    && Colecoes - colecao
    *-- Codigos auxiliares
    this_cCbars       = ""    && Cbars    - codigo de barras
    this_cEAN13       = ""    && EAN13    - EAN-13 (se campo separado)
    this_cCProEqs     = ""    && CProEqs  - produto equivalente
    this_cIdeCPros    = ""    && IdeCPros - identificador
    this_cMercs       = ""    && Mercs    - mercadoria
    *-- Linha / Colecao
    this_cLins        = ""    && Lins     - codigo da linha
    this_cCols        = ""    && Cols     - codigo da colecao/grupo venda
    *-- Unidades
    this_cCUnis       = ""    && CUnis    - unidade 1
    this_cCUnips      = ""    && CUnips   - unidade 2
    *-- Dimensoes
    this_nAlturas     = 0     && Alturas
    this_nLarguras    = 0     && Larguras
    this_nDiametros   = 0     && Diametros
    this_nEspessuras  = 0     && Espessuras
    this_nCompriments = 0     && Compriments
    this_nPesoMs      = 0     && PesoMs      - peso base
    this_nPesoBs      = 0     && PesoBs      - peso bruto
    this_nPesoPmedios = 0     && PesoPmedios - peso medio
    *-- Classificacoes
    this_cTams        = ""    && Tams     - tamanho
    this_cCorPros     = ""    && CorPros  - cor
    this_cCodFinPs    = ""    && CodFinPs - finalidade
    this_cCodAcbs     = ""    && CodAcbs  - acabamento
    this_cLocals      = ""    && Locals   - local
    this_cClasss      = ""    && Classs   - classificacao
    *-- Precos e moedas
    this_nPvens       = 0     && Pvens    - preco de venda
    this_cMoevs       = ""    && Moevs    - moeda venda
    this_nFvendas     = 0     && Fvendas  - fator venda
    this_cMfvendas    = ""    && Mfvendas - moeda fator venda
    this_nCustofs     = 0     && Custofs  - custo
    this_cMoecs       = ""    && Moecs    - moeda custo
    this_nMargems     = 0     && Margems  - margem
    this_nPcuss       = 0     && Pcuss    - preco custo unitario
    this_cMoePcs      = ""    && MoePcs   - moeda preco custo
    this_nFcustos     = 0     && Fcustos  - fator custo
    this_nPFTioCs     = 0     && PFTioCs  - feitio custo
    this_nPFTios      = 0     && PFTios   - feitio venda
    *-- Quantidades e lotes
    this_nQmins       = 0     && Qmins    - quantidade minima
    this_nLtMinsVs    = 0     && LtMinsVs - lote minimo venda
    this_nConjuntos   = 0     && Conjuntos - conjunto
    this_nQtPeds      = 0     && QtPeds   - quantidade pedido
    *-- Flags booleanos (armazenados como INT 0/1)
    this_nGarVits     = 0     && GarVits     - garantia vitrine
    this_nConsigs     = 0     && Consigs     - consignado
    this_nFabrProprs  = 0     && FabrProprs  - fabricacao propria
    this_nEncoms      = 0     && Encoms      - encomenda
    this_nProdWebs    = 0     && ProdWebs    - produto web
    this_nOpcVars     = 0     && OpcVars     - opcao variacao
    this_nInstalas    = 0     && Instalas    - instalado/ativo (chkInstalas)
    *-- Status e situacao
    this_nSituas      = 0     && Situas  - situacao
    this_dDtSituas    = {}    && DtSituas - data situacao
    *-- Observacoes
    this_cObs1s       = ""    && Obs1s
    this_cObs2s       = ""    && Obs2s
    this_cObs3s       = ""    && Obs3s
    this_cDscCompras  = ""    && DscCompras - descricao compras (memo)
    this_cObsCompras  = ""    && ObsCompras - obs compras (memo)
    *-- Campos customizados
    this_cFwget3s     = ""    && Fwget3s
    this_cFwget4s     = ""    && Fwget4s
    this_cFwget5s     = ""    && Fwget5s
    this_cFwget6s     = ""    && Fwget6s
    this_cCodIdents   = ""    && CodIdents
    this_cTEnts       = ""    && TEnts  - tipo entrada
    this_nDiasGars    = 0     && DiasGars - dias de garantia
    *-- Campos FaseP (Fase P - dados de processo)
    this_nQtMinFabs   = 0     && QtMinFabs  - qtd minima fabricacao
    this_cCodGarras   = ""    && CodGarras  - codigo de garras
    this_cConquilhas  = ""    && Conquilhas - conquilha padrao
    this_nPesoBris    = 0     && PesoBris   - peso brilhante
    this_nPesoMetal   = 0     && PesoMetal  - peso metal
    this_nPesoPdrs    = 0     && PesoPdrs   - peso pedra
    this_nCravCers    = 0     && CravCers   - cravacao em cera (0/1)
    this_nVarias      = 0     && Varias     - peso variavel (0/1)
    *-- Estoque e auditoria (somente leitura)
    this_nEstoques    = 0     && Estoques
    this_nQtdEsts     = 0     && QtdEsts
    this_dDtIncs      = {}    && DtIncs  - data de inclusao
    this_dDataAlts    = {}    && DataAlts - data alteracao
    this_cHoraAlts    = ""    && HoraAlts - hora alteracao
    this_cUsuaIncs    = ""    && UsuaIncs - usuario inclusao
    this_cUsuaAlts    = ""    && UsuaAlts - usuario alteracao
    this_dDtucps      = {}    && Dtucps  - data ult. compra
    this_nVucps       = 0     && Vucps   - valor ult. compra
    this_cMucps       = ""    && Mucps   - moeda ult. compra
    this_nQtdUltComps = 0     && QtdUltComps - qtd ult. compra

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCpros       = TratarNulo(CPros,       "C")
                THIS.this_cDpros       = TratarNulo(DPros,       "C")
                THIS.this_cDPro2s      = TratarNulo(DPro2s,      "C")
                THIS.this_cDPro3s      = TratarNulo(DPro3s,      "C")
                THIS.this_cCgrus       = TratarNulo(CGrus,       "C")
                THIS.this_cSGrus       = TratarNulo(SGrus,       "C")
                THIS.this_cIFors       = TratarNulo(IFors,       "C")
                THIS.this_cReffs       = TratarNulo(Reffs,       "C")
                THIS.this_cColecoes    = TratarNulo(Colecoes,    "C")
                THIS.this_cCbars       = TratarNulo(Cbars,       "C")
                THIS.this_cCProEqs     = TratarNulo(CProEqs,     "C")
                THIS.this_cIdeCPros    = TratarNulo(IdeCPros,    "C")
                THIS.this_cMercs       = TratarNulo(Mercs,       "C")
                THIS.this_cLins        = TratarNulo(Lins,        "C")
                THIS.this_cCols        = TratarNulo(Cols,        "C")
                THIS.this_cCUnis       = TratarNulo(CUnis,       "C")
                THIS.this_cCUnips      = TratarNulo(CUnips,      "C")
                THIS.this_nAlturas     = TratarNulo(Alturas,     "N")
                THIS.this_nLarguras    = TratarNulo(Larguras,    "N")
                THIS.this_nDiametros   = TratarNulo(Diametros,   "N")
                THIS.this_nEspessuras  = TratarNulo(Espessuras,  "N")
                THIS.this_nCompriments = TratarNulo(Compriments, "N")
                THIS.this_nPesoMs      = TratarNulo(PesoMs,      "N")
                THIS.this_nPesoBs      = TratarNulo(PesoBs,      "N")
                THIS.this_nPesoPmedios = TratarNulo(PesoPmedios, "N")
                THIS.this_cTams        = TratarNulo(Tams,        "C")
                THIS.this_cCorPros     = TratarNulo(CorPros,     "C")
                THIS.this_cCodFinPs    = TratarNulo(CodFinPs,    "C")
                THIS.this_cCodAcbs     = TratarNulo(CodAcbs,     "C")
                THIS.this_cLocals      = TratarNulo(Locals,      "C")
                THIS.this_cClasss      = TratarNulo(Classs,      "C")
                THIS.this_nPvens       = TratarNulo(Pvens,       "N")
                THIS.this_cMoevs       = TratarNulo(Moevs,       "C")
                THIS.this_nFvendas     = TratarNulo(Fvendas,     "N")
                THIS.this_cMfvendas    = TratarNulo(Mfvendas,    "C")
                THIS.this_nCustofs     = TratarNulo(Custofs,     "N")
                THIS.this_cMoecs       = TratarNulo(Moecs,       "C")
                THIS.this_nMargems     = TratarNulo(Margems,     "N")
                THIS.this_nQmins       = TratarNulo(Qmins,       "N")
                THIS.this_nLtMinsVs    = TratarNulo(LtMinsVs,    "N")
                THIS.this_nConjuntos   = TratarNulo(Conjuntos,   "N")
                THIS.this_nQtPeds      = TratarNulo(QtPeds,      "N")
                THIS.this_nGarVits     = TratarNulo(GarVits,     "N")
                THIS.this_nConsigs     = TratarNulo(Consigs,     "N")
                THIS.this_nFabrProprs  = TratarNulo(FabrProprs,  "N")
                THIS.this_nEncoms      = TratarNulo(Encoms,      "N")
                THIS.this_nProdWebs    = TratarNulo(ProdWebs,    "N")
                THIS.this_nOpcVars     = TratarNulo(OpcVars,     "N")
                THIS.this_nInstalas    = TratarNulo(Instalas,    "N")
                THIS.this_nSituas      = TratarNulo(Situas,      "N")
                THIS.this_dDtSituas    = TratarNulo(DtSituas,    "D")
                THIS.this_cObs1s       = TratarNulo(Obs1s,       "C")
                THIS.this_cObs2s       = TratarNulo(Obs2s,       "C")
                THIS.this_cObs3s       = TratarNulo(Obs3s,       "C")
                THIS.this_cDscCompras  = TratarNulo(DscCompras,  "C")
                THIS.this_cObsCompras  = TratarNulo(ObsCompras,  "C")
                THIS.this_cFwget3s     = TratarNulo(Fwget3s,     "C")
                THIS.this_cFwget4s     = TratarNulo(Fwget4s,     "C")
                THIS.this_cFwget5s     = TratarNulo(Fwget5s,     "C")
                THIS.this_cFwget6s     = TratarNulo(Fwget6s,     "C")
                THIS.this_cCodIdents   = TratarNulo(CodIdents,   "C")
                THIS.this_cTEnts       = TratarNulo(TEnts,       "C")
                THIS.this_nDiasGars    = TratarNulo(DiasGars,    "N")
                THIS.this_nQtMinFabs   = TratarNulo(QtMinFabs,   "N")
                THIS.this_cCodGarras   = TratarNulo(CodGarras,   "C")
                THIS.this_cConquilhas  = TratarNulo(Conquilhas,  "C")
                THIS.this_nPesoBris    = TratarNulo(PesoBris,    "N")
                THIS.this_nPesoMetal   = TratarNulo(PesoMetal,   "N")
                THIS.this_nPesoPdrs    = TratarNulo(PesoPdrs,    "N")
                THIS.this_nCravCers    = TratarNulo(CravCers,    "N")
                THIS.this_nVarias      = TratarNulo(Varias,      "N")
                THIS.this_nEstoques    = TratarNulo(Estoques,    "N")
                THIS.this_nQtdEsts     = TratarNulo(QtdEsts,     "N")
                THIS.this_dDtIncs      = TratarNulo(DtIncs,      "D")
                THIS.this_dDataAlts    = TratarNulo(DataAlts,    "D")
                THIS.this_cHoraAlts    = TratarNulo(HoraAlts,    "C")
                THIS.this_cUsuaIncs    = TratarNulo(UsuaIncs,    "C")
                THIS.this_cUsuaAlts    = TratarNulo(UsuaAlts,    "C")
                THIS.this_dDtucps      = TratarNulo(Dtucps,      "D")
                THIS.this_nVucps       = TratarNulo(Vucps,       "N")
                THIS.this_cMucps       = TratarNulo(Mucps,       "C")
                THIS.this_nQtdUltComps = TratarNulo(QtdUltComps, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto do cursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Busca o produto no banco pelo CPros
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_nRet, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cCodigo) OR gnConnHandle <= 0
                loc_lSucesso = loc_lSucesso
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, ;
                "SELECT * FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(ALLTRIM(par_cCodigo), 14)), ;
                "cursor_4c_ProdutoBO")
            IF loc_nRet > 0 AND RECCOUNT("cursor_4c_ProdutoBO") > 0
                THIS.CarregarDoCursor("cursor_4c_ProdutoBO")
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_ProdutoBO")
                USE IN cursor_4c_ProdutoBO
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna cursor com lista de produtos (filtro SQL WHERE opcional)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nRet, loc_oErro
        TRY
            IF USED("cursor_4c_BuscarBO")
                USE IN cursor_4c_BuscarBO
            ENDIF
            loc_cSQL = "SELECT CPros, DPros, CGrus, SGrus, Reffs, " + ;
                       "UsuaAlts, CAST(ISNULL(Instalas,0) AS INT) AS Instalas " + ;
                       "FROM SigCdPro"
            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY CPros"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscarBO")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao buscar produtos")
        ENDTRY
        RETURN loc_nRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "INSERT INTO SigCdPro (" + ;
                "CPros, DPros, DPro2s, CGrus, SGrus, IFors, Reffs, Colecoes, " + ;
                "Cbars, CProEqs, IdeCPros, Mercs, Lins, Cols, CUnis, CUnips, " + ;
                "Alturas, Larguras, Diametros, Espessuras, Compriments, " + ;
                "PesoMs, PesoBs, PesoPmedios, Tams, CorPros, CodFinPs, " + ;
                "CodAcbs, Locals, Classs, " + ;
                "Pvens, Moevs, Fvendas, Mfvendas, Custofs, Moecs, Margems, " + ;
                "Qmins, LtMinsVs, Conjuntos, QtPeds, DiasGars, " + ;
                "GarVits, Consigs, FabrProprs, Encoms, ProdWebs, OpcVars, Instalas, " + ;
                "Situas, DtSituas, Obs1s, Obs2s, Obs3s, DscCompras, ObsCompras, " + ;
                "Fwget3s, Fwget4s, Fwget5s, Fwget6s, CodIdents, TEnts, " + ;
                "QtMinFabs, CodGarras, Conquilhas, PesoBris, PesoMetal, PesoPdrs, CravCers, Varias, " + ;
                "DtIncs, UsuaIncs, DataAlts, UsuaAlts" + ;
                ") VALUES (" + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14)) + "," + ;
                EscaparSQL(THIS.this_cDpros) + "," + ;
                EscaparSQL(THIS.this_cDPro2s) + "," + ;
                EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                EscaparSQL(THIS.this_cIFors) + "," + ;
                EscaparSQL(THIS.this_cReffs) + "," + ;
                EscaparSQL(THIS.this_cColecoes) + "," + ;
                EscaparSQL(THIS.this_cCbars) + "," + ;
                EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                EscaparSQL(THIS.this_cMercs) + "," + ;
                EscaparSQL(THIS.this_cLins) + "," + ;
                EscaparSQL(THIS.this_cCols) + "," + ;
                EscaparSQL(THIS.this_cCUnis) + "," + ;
                EscaparSQL(THIS.this_cCUnips) + "," + ;
                FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                EscaparSQL(THIS.this_cTams) + "," + ;
                EscaparSQL(THIS.this_cCorPros) + "," + ;
                EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cClasss) + "," + ;
                FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                EscaparSQL(THIS.this_cMoevs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                EscaparSQL(THIS.this_cMfvendas) + "," + ;
                FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                EscaparSQL(THIS.this_cMoecs) + "," + ;
                FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                EscaparSQL(THIS.this_cObs1s) + "," + ;
                EscaparSQL(THIS.this_cObs2s) + "," + ;
                EscaparSQL(THIS.this_cObs3s) + "," + ;
                EscaparSQL(THIS.this_cDscCompras) + "," + ;
                EscaparSQL(THIS.this_cObsCompras) + "," + ;
                EscaparSQL(THIS.this_cFwget3s) + "," + ;
                EscaparSQL(THIS.this_cFwget4s) + "," + ;
                EscaparSQL(THIS.this_cFwget5s) + "," + ;
                EscaparSQL(THIS.this_cFwget6s) + "," + ;
                EscaparSQL(THIS.this_cCodIdents) + "," + ;
                EscaparSQL(THIS.this_cTEnts) + "," + ;
                FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                EscaparSQL(THIS.this_cCodGarras) + "," + ;
                EscaparSQL(THIS.this_cConquilhas) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                "GETDATE()," + ;
                EscaparSQL(gc_4c_UsuarioLogado) + ;
                ")"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdPro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigCdPro SET " + ;
                "DPros       = " + EscaparSQL(THIS.this_cDpros) + "," + ;
                "DPro2s      = " + EscaparSQL(THIS.this_cDPro2s) + "," + ;
                "CGrus       = " + EscaparSQL(PADR(THIS.this_cCgrus, 10)) + "," + ;
                "SGrus       = " + EscaparSQL(PADR(THIS.this_cSGrus, 10)) + "," + ;
                "IFors       = " + EscaparSQL(THIS.this_cIFors) + "," + ;
                "Reffs       = " + EscaparSQL(THIS.this_cReffs) + "," + ;
                "Colecoes    = " + EscaparSQL(THIS.this_cColecoes) + "," + ;
                "Cbars       = " + EscaparSQL(THIS.this_cCbars) + "," + ;
                "CProEqs     = " + EscaparSQL(PADR(THIS.this_cCProEqs, 14)) + "," + ;
                "IdeCPros    = " + EscaparSQL(THIS.this_cIdeCPros) + "," + ;
                "Mercs       = " + EscaparSQL(THIS.this_cMercs) + "," + ;
                "Lins        = " + EscaparSQL(THIS.this_cLins) + "," + ;
                "Cols        = " + EscaparSQL(THIS.this_cCols) + "," + ;
                "CUnis       = " + EscaparSQL(THIS.this_cCUnis) + "," + ;
                "CUnips      = " + EscaparSQL(THIS.this_cCUnips) + "," + ;
                "Alturas     = " + FormatarNumeroSQL(THIS.this_nAlturas) + "," + ;
                "Larguras    = " + FormatarNumeroSQL(THIS.this_nLarguras) + "," + ;
                "Diametros   = " + FormatarNumeroSQL(THIS.this_nDiametros) + "," + ;
                "Espessuras  = " + FormatarNumeroSQL(THIS.this_nEspessuras) + "," + ;
                "Compriments = " + FormatarNumeroSQL(THIS.this_nCompriments) + "," + ;
                "PesoMs      = " + FormatarNumeroSQL(THIS.this_nPesoMs) + "," + ;
                "PesoBs      = " + FormatarNumeroSQL(THIS.this_nPesoBs) + "," + ;
                "PesoPmedios = " + FormatarNumeroSQL(THIS.this_nPesoPmedios) + "," + ;
                "Tams        = " + EscaparSQL(THIS.this_cTams) + "," + ;
                "CorPros     = " + EscaparSQL(THIS.this_cCorPros) + "," + ;
                "CodFinPs    = " + EscaparSQL(THIS.this_cCodFinPs) + "," + ;
                "CodAcbs     = " + EscaparSQL(THIS.this_cCodAcbs) + "," + ;
                "Locals      = " + EscaparSQL(THIS.this_cLocals) + "," + ;
                "Classs      = " + EscaparSQL(THIS.this_cClasss) + "," + ;
                "Pvens       = " + FormatarNumeroSQL(THIS.this_nPvens) + "," + ;
                "Moevs       = " + EscaparSQL(THIS.this_cMoevs) + "," + ;
                "Fvendas     = " + FormatarNumeroSQL(THIS.this_nFvendas) + "," + ;
                "Mfvendas    = " + EscaparSQL(THIS.this_cMfvendas) + "," + ;
                "Custofs     = " + FormatarNumeroSQL(THIS.this_nCustofs) + "," + ;
                "Moecs       = " + EscaparSQL(THIS.this_cMoecs) + "," + ;
                "Margems     = " + FormatarNumeroSQL(THIS.this_nMargems) + "," + ;
                "Qmins       = " + FormatarNumeroSQL(THIS.this_nQmins) + "," + ;
                "LtMinsVs    = " + FormatarNumeroSQL(THIS.this_nLtMinsVs) + "," + ;
                "Conjuntos   = " + FormatarNumeroSQL(THIS.this_nConjuntos) + "," + ;
                "QtPeds      = " + FormatarNumeroSQL(THIS.this_nQtPeds) + "," + ;
                "DiasGars    = " + FormatarNumeroSQL(THIS.this_nDiasGars) + "," + ;
                "GarVits     = " + FormatarNumeroSQL(THIS.this_nGarVits) + "," + ;
                "Consigs     = " + FormatarNumeroSQL(THIS.this_nConsigs) + "," + ;
                "FabrProprs  = " + FormatarNumeroSQL(THIS.this_nFabrProprs) + "," + ;
                "Encoms      = " + FormatarNumeroSQL(THIS.this_nEncoms) + "," + ;
                "ProdWebs    = " + FormatarNumeroSQL(THIS.this_nProdWebs) + "," + ;
                "OpcVars     = " + FormatarNumeroSQL(THIS.this_nOpcVars) + "," + ;
                "Instalas    = " + FormatarNumeroSQL(THIS.this_nInstalas) + "," + ;
                "Situas      = " + FormatarNumeroSQL(THIS.this_nSituas) + "," + ;
                "DtSituas    = " + FormatarDataSQL(THIS.this_dDtSituas) + "," + ;
                "Obs1s       = " + EscaparSQL(THIS.this_cObs1s) + "," + ;
                "Obs2s       = " + EscaparSQL(THIS.this_cObs2s) + "," + ;
                "Obs3s       = " + EscaparSQL(THIS.this_cObs3s) + "," + ;
                "DscCompras  = " + EscaparSQL(THIS.this_cDscCompras) + "," + ;
                "ObsCompras  = " + EscaparSQL(THIS.this_cObsCompras) + "," + ;
                "Fwget3s     = " + EscaparSQL(THIS.this_cFwget3s) + "," + ;
                "Fwget4s     = " + EscaparSQL(THIS.this_cFwget4s) + "," + ;
                "Fwget5s     = " + EscaparSQL(THIS.this_cFwget5s) + "," + ;
                "Fwget6s     = " + EscaparSQL(THIS.this_cFwget6s) + "," + ;
                "CodIdents   = " + EscaparSQL(THIS.this_cCodIdents) + "," + ;
                "TEnts       = " + EscaparSQL(THIS.this_cTEnts) + "," + ;
                "QtMinFabs   = " + FormatarNumeroSQL(THIS.this_nQtMinFabs) + "," + ;
                "CodGarras   = " + EscaparSQL(THIS.this_cCodGarras) + "," + ;
                "Conquilhas  = " + EscaparSQL(THIS.this_cConquilhas) + "," + ;
                "PesoBris    = " + FormatarNumeroSQL(THIS.this_nPesoBris) + "," + ;
                "PesoMetal   = " + FormatarNumeroSQL(THIS.this_nPesoMetal) + "," + ;
                "PesoPdrs    = " + FormatarNumeroSQL(THIS.this_nPesoPdrs) + "," + ;
                "CravCers    = " + FormatarNumeroSQL(THIS.this_nCravCers) + "," + ;
                "Varias      = " + FormatarNumeroSQL(THIS.this_nVarias) + "," + ;
                "DataAlts    = GETDATE()," + ;
                "UsuaAlts    = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE CPros = " + EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdPro (chamado por Excluir() do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdPro WHERE CPros = " + ;
                EscaparSQL(PADR(THIS.this_cCpros, 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir produto." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir produto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

