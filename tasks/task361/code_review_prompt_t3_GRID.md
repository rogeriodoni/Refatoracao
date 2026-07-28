# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (2)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 756: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...
- [GRID-RECORDSOURCE-AUTOBIND] Linha 945: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCeg.prg) - TRECHOS RELEVANTES PARA PASS GRID (1572 linhas total):

*-- Linhas 340 a 360:
340:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de lista - Top=117 (88+29), Left=26, Width=890, Height=498
343:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
344:         loc_oGrid = loc_oPg1.grd_4c_Lista
345:         loc_oGrid.ColumnCount = 5
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 890
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)
354:             .BackColor          = RGB(255, 255, 255)
355:             .GridLineColor      = RGB(238, 238, 238)
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.

*-- Linhas 368 a 390:
368:         loc_oGrid.Column3.Width           = 120
369:         loc_oGrid.Column4.Width           = 60
370:         loc_oGrid.Column5.Width           = 490
371:         loc_oGrid.Column1.Header1.Caption = "Prioridade"
372:         loc_oGrid.Column2.Header1.Caption = "Grupo"
373:         loc_oGrid.Column3.Header1.Caption = "Conta"
374:         loc_oGrid.Column4.Header1.Caption = "Empresa"
375:         loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
376:         loc_oGrid.Column1.Alignment       = 2
377:         loc_oGrid.Column4.Alignment       = 2
378: 
379:         THIS.TornarControlesVisiveis(loc_oPg1)
380:     ENDPROC
381: 
382:     *--------------------------------------------------------------------------
383:     * ConfigurarPaginaDados - Configura Page2: cabecalho + botoes acao
384:     * Campos de dados (txt_4c_*) adicionados na Fase 5
385:     *--------------------------------------------------------------------------
386:     PROTECTED PROCEDURE ConfigurarPaginaDados()
387:         LOCAL loc_oPg2, loc_oCab, loc_oBotoesAcao
388: 
389:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
390: 

*-- Linhas 742 a 777:
742:                 IF VARTYPE(THIS.this_oBusinessObject) != "O"
743:                 MsgErro("Business Object n" + CHR(227) + "o inicializado", "FormCeg.CarregarLista")
744:             ELSE
745:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
746:                 *-- Desconectar RecordSource antes do SQLEXEC para preservar colunas do grid
747:                 loc_oGrid.RecordSource = ""
748:                 IF THIS.this_oBusinessObject.Buscar("")
749:                     loc_oGrid.ColumnCount = 5
750:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
751:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
752:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
753:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
754:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
755:                     loc_oGrid.ColumnCount = 3
756:                     loc_oGrid.RecordSource         = "cursor_4c_Dados"
757:                     *-- Redefinir cabecalhos apos RecordSource (VFP reseta headers)
758:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
759:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
760:                     loc_oGrid.Column3.Header1.Caption = "Conta"
761:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
762:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
763:                     THIS.FormatarGridLista(loc_oGrid)
764:                     loc_lResultado = .T.
765:                 ENDIF
766:                 ENDIF
767:             ENDIF
768:         CATCH TO loc_oErro
769:             MsgErro(loc_oErro.Message, "FormCeg.CarregarLista")
770:         ENDTRY
771: 
772:         RETURN loc_lResultado
773:     ENDPROC
774: 
775:     *--------------------------------------------------------------------------
776:     * AlternarPagina - Navega entre Page1 (lista) e Page2 (dados)
777:     *--------------------------------------------------------------------------

*-- Linhas 931 a 965:
931:             loc_cFiltro = INPUTBOX("Filtrar por Grupo (vazio = todos):", ;
932:                                    "Buscar Prioridades", "")
933:             IF TYPE("loc_cFiltro") = "C"
934:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
935:                 *-- Desconectar RecordSource antes do SQLEXEC
936:                 loc_oGrid.RecordSource = ""
937:                 IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
938:                     loc_oGrid.ColumnCount = 5
939:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.priors"
940:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
941:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
942:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
943:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
944:                     loc_oGrid.ColumnCount = 3
945:                     loc_oGrid.RecordSource         = "cursor_4c_Dados"
946:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
947:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
948:                     loc_oGrid.Column3.Header1.Caption = "Conta"
949:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
950:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
951:                     loc_lResultado = .T.
952:                 ENDIF
953:             ENDIF
954:         CATCH TO loc_oErro
955:             MsgErro(loc_oErro.Message, "FormCeg.BtnBuscarClick")
956:         ENDTRY
957: 
958:         RETURN loc_lResultado
959:     ENDPROC
960: 
961:     *--------------------------------------------------------------------------
962:     * BtnEncerrarClick - Fecha o formulario
963:     *--------------------------------------------------------------------------
964:     PROCEDURE BtnEncerrarClick()
965:         TRY

*-- Linhas 1299 a 1318:
1299:                     ENDIF
1300:                 ELSE
1301:                     IF !loc_oBusca.this_lAchouRegistro
1302:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1303:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1304:                     loc_oBusca.Show()
1305:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1306:                         loc_oPg2.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1307:                     ENDIF
1308:                     ENDIF
1309:                 ENDIF
1310:                 loc_oBusca.Release()
1311:             ENDIF
1312:         CATCH TO loc_oErro
1313:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaGrupo")
1314:         ENDTRY
1315: 
1316:         IF USED("cursor_4c_BuscaGrupo")
1317:             USE IN cursor_4c_BuscaGrupo
1318:         ENDIF

*-- Linhas 1368 a 1387:
1368:                     ENDIF
1369:                 ELSE
1370:                     IF !loc_oBusca.this_lAchouRegistro
1371:                     loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1372:                     loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1373:                     loc_oBusca.Show()
1374:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1375:                         loc_oPg2.txt_4c_Conta.Value = ALLTRIM(cursor_4c_BuscaConta.Iclis)
1376:                     ENDIF
1377:                     ENDIF
1378:                 ENDIF
1379:                 loc_oBusca.Release()
1380:             ENDIF
1381:         CATCH TO loc_oErro
1382:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaConta")
1383:         ENDTRY
1384: 
1385:         IF USED("cursor_4c_BuscaConta")
1386:             USE IN cursor_4c_BuscaConta
1387:         ENDIF

*-- Linhas 1434 a 1453:
1434:                     ENDIF
1435:                 ELSE
1436:                     IF !loc_oBusca.this_lAchouRegistro
1437:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1438:                     loc_oBusca.mAddColuna("Razas", "", "Nome")
1439:                     loc_oBusca.Show()
1440:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1441:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1442:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1443:                     ENDIF
1444:                     ENDIF
1445:                 ENDIF
1446:                 loc_oBusca.Release()
1447:             ENDIF
1448:         CATCH TO loc_oErro
1449:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaEmps")
1450:         ENDTRY
1451: 
1452:         IF USED("cursor_4c_BuscaEmp")
1453:             USE IN cursor_4c_BuscaEmp

*-- Linhas 1501 a 1520:
1501:                     ENDIF
1502:                 ELSE
1503:                     IF !loc_oBusca.this_lAchouRegistro
1504:                     loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
1505:                     loc_oBusca.mAddColuna("Razas", "", "Nome")
1506:                     loc_oBusca.Show()
1507:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaDEmp")
1508:                         loc_oPg2.txt_4c_Emps.Value  = ALLTRIM(cursor_4c_BuscaDEmp.Cemps)
1509:                         loc_oPg2.txt_4c_DEmps.Value = ALLTRIM(cursor_4c_BuscaDEmp.Razas)
1510:                     ENDIF
1511:                     ENDIF
1512:                 ENDIF
1513:                 loc_oBusca.Release()
1514:             ENDIF
1515:         CATCH TO loc_oErro
1516:             MsgErro(loc_oErro.Message, "FormCeg.AbrirBuscaDEmps")
1517:         ENDTRY
1518: 
1519:         IF USED("cursor_4c_BuscaDEmp")
1520:             USE IN cursor_4c_BuscaDEmp

