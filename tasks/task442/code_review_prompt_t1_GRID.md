# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 333: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormGr1.prg) - TRECHOS RELEVANTES PARA PASS GRID (1023 linhas total):

*-- Linhas 241 a 262:
241:         IF USED("cursor_4c_Acessos")
242:             USE IN cursor_4c_Acessos
243:         ENDIF
244:         SET NULL ON
245:         CREATE CURSOR cursor_4c_Acessos ;
246:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
247:         SET NULL OFF
248: 
249:         *-- Shape borda da area de dados (Shape1 do legado)
250:         THIS.AddObject("shp_4c_Area", "Shape")
251:         WITH THIS.shp_4c_Area
252:             .Top           = 83
253:             .Left          = 3
254:             .Width         = 960
255:             .Height        = 507
256:             .BackStyle     = 0
257:             .SpecialEffect = 0
258:         ENDWITH
259: 
260:         *-- Label "Usu CHR(225) rio :" (Label1 do legado)
261:         THIS.AddObject("lbl_4c_Label1", "Label")
262:         WITH THIS.lbl_4c_Label1

*-- Linhas 302 a 355:
302:         ENDWITH
303: 
304:         *-- Grid de acessos (Grid1 do legado)
305:         THIS.AddObject("grd_4c_Dados", "Grid")
306:         loc_oGrid = THIS.grd_4c_Dados
307:         WITH loc_oGrid
308:             .Top                = 118
309:             .Left               = 9
310:             .Width              = 950
311:             .Height             = 472
312:             .ColumnCount        = 1
313:             .DeleteMark         = .F.
314:             .RecordMark         = .F.
315:             .ReadOnly           = .T.
316:             .ScrollBars         = 2
317:             .GridLineColor      = RGB(238, 238, 238)
318:             .FontName           = "Verdana"
319:             .FontSize           = 8
320:             .HighlightStyle     = 2
321:             .HighlightBackColor = RGB(255, 255, 255)
322:             .HighlightForeColor = RGB(15, 41, 104)
323:             .RowHeight          = 16
324: 
325:             WITH .Column1
326:                 .Width         = 924
327:                 .Movable       = .F.
328:                 .Resizable     = .F.
329:                 .ReadOnly      = .T.
330:                 .ControlSource = "cursor_4c_Acessos.Descricaos"
331:             ENDWITH
332: 
333:             .RecordSource = "cursor_4c_Acessos"
334:         ENDWITH
335: 
336:         *-- Header1: fora do WITH aninhado para evitar silently-ignored props
337:         loc_oGrid.Column1.Header1.Caption   = "Acessos"
338:         loc_oGrid.Column1.Header1.FontName  = "Tahoma"
339:         loc_oGrid.Column1.Header1.Alignment = 2
340:         loc_oGrid.Column1.Header1.ForeColor = RGB(90, 90, 90)
341: 
342:         *-- Text1 (celula de dados): Courier New conforme legado
343:         loc_oGrid.Column1.Text1.FontName    = "Courier New"
344:         loc_oGrid.Column1.Text1.FontSize    = 8
345:         loc_oGrid.Column1.Text1.BorderStyle = 0
346:         loc_oGrid.Column1.Text1.ReadOnly    = .T.
347:         loc_oGrid.Column1.Text1.ForeColor   = RGB(0, 0, 0)
348:         loc_oGrid.Column1.Text1.BackColor   = RGB(255, 255, 255)
349: 
350:         *-- BINDEVENTs: campos de usuario (grupo eh vinculado em ConfigurarPaginaDados)
351:         BINDEVENT(THIS.txt_4c_Codigo, "GotFocus", THIS, "TxtCodigoGotFocus")
352:         BINDEVENT(THIS.txt_4c_Codigo, "KeyPress", THIS, "TxtCodigoKeyPress")
353:         BINDEVENT(THIS.txt_4c_Descri, "KeyPress", THIS, "TxtDescriKeyPress")
354: 
355:         *-- BINDEVENTs: botoes do cabecalho (criados em ConfigurarCabecalho)

*-- Linhas 415 a 448:
415:         LOCAL loc_oErro
416: 
417:         TRY
418:             *-- Limpa RecordSource para evitar uncommitted changes
419:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
420:                 THIS.grd_4c_Dados.RecordSource = ""
421:             ENDIF
422: 
423:             THIS.this_oBusinessObject.BuscarAcessosPorUsuario(THIS.this_cUsuarios)
424: 
425:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
426:                 THIS.grd_4c_Dados.ColumnCount  = 1
427:                 THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
428:                 THIS.grd_4c_Dados.Column1.ControlSource        = "cursor_4c_Acessos.Descricaos"
429:                 THIS.grd_4c_Dados.Column1.Header1.Caption      = "Acessos"
430:                 THIS.grd_4c_Dados.Column1.Header1.FontName     = "Tahoma"
431:                 THIS.grd_4c_Dados.Column1.Header1.Alignment    = 2
432:                 THIS.grd_4c_Dados.Column1.Header1.ForeColor    = RGB(90, 90, 90)
433:                 THIS.grd_4c_Dados.Refresh()
434:             ENDIF
435: 
436:         CATCH TO loc_oErro
437:             MsgErro(loc_oErro.Message + CHR(13) + ;
438:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
439:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarAcessos")
440:         ENDTRY
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     * AbrirBuscaUsuarioPorCodigo - Picker FormBuscaAuxiliar buscando por Usuarios
445:     *--------------------------------------------------------------------------
446:     PROTECTED PROCEDURE AbrirBuscaUsuarioPorCodigo()
447:         LOCAL loc_oLookup, loc_cValor, loc_oErro
448: 

*-- Linhas 454 a 473:
454:                 "Usu" + CHR(225) + "rios", .T., .T., "NOT cAtivos = 'N'")
455: 
456:             IF VARTYPE(loc_oLookup) = "O"
457:                 loc_oLookup.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
458:                 loc_oLookup.mAddColuna("NComps", "", "Nome")
459:                 loc_oLookup.Show()
460: 
461:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
462:                    loc_oLookup.this_lSelecionou
463:                     SELECT cursor_4c_BuscaUsu
464:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
465:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
466:                     THIS.txt_4c_Descri.ReadOnly = .T.
467:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
468:                     THIS.this_cNComps            = ALLTRIM(NComps)
469:                     USE IN cursor_4c_BuscaUsu
470:                     THIS.CarregarAcessos()
471:                 ELSE
472:                     IF USED("cursor_4c_BuscaUsu")
473:                         USE IN cursor_4c_BuscaUsu

*-- Linhas 496 a 515:
496:                 "Usu" + CHR(225) + "rios", .T., .T., "NOT cAtivos = 'N'")
497: 
498:             IF VARTYPE(loc_oLookup) = "O"
499:                 loc_oLookup.mAddColuna("Usuarios", "XXXXXXXXXX", "C" + CHR(243) + "digo")
500:                 loc_oLookup.mAddColuna("NComps", "", "Nome")
501:                 loc_oLookup.Show()
502: 
503:                 IF USED("cursor_4c_BuscaUsu") AND !EOF("cursor_4c_BuscaUsu") AND ;
504:                    loc_oLookup.this_lSelecionou
505:                     SELECT cursor_4c_BuscaUsu
506:                     THIS.txt_4c_Codigo.Value    = ALLTRIM(Usuarios)
507:                     THIS.txt_4c_Descri.Value    = ALLTRIM(NComps)
508:                     THIS.txt_4c_Descri.ReadOnly = .T.
509:                     THIS.this_cUsuarios          = ALLTRIM(Usuarios)
510:                     THIS.this_cNComps            = ALLTRIM(NComps)
511:                     USE IN cursor_4c_BuscaUsu
512:                     THIS.CarregarAcessos()
513:                 ELSE
514:                     IF USED("cursor_4c_BuscaUsu")
515:                         USE IN cursor_4c_BuscaUsu

*-- Linhas 653 a 673:
653:             ENDIF
654: 
655:             IF THIS.this_oBusinessObject.RemoverAcessoLocal()
656:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
657:                     THIS.grd_4c_Dados.Refresh()
658:                     THIS.grd_4c_Dados.SetFocus()
659:                 ENDIF
660:             ENDIF
661: 
662:         CATCH TO loc_oErro
663:             MsgErro(loc_oErro.Message + CHR(13) + ;
664:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
665:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmgRemoveClick")
666:         ENDTRY
667:     ENDPROC
668: 
669:     *--------------------------------------------------------------------------
670:     * CmgSalvarClick - Valida e grava o novo grupo com os acessos exibidos
671:     *--------------------------------------------------------------------------
672:     PROCEDURE CmgSalvarClick()
673:         LOCAL loc_cUsuarios, loc_cGrupo, loc_oErro

*-- Linhas 833 a 852:
833:             THIS.this_cUsuarios = loc_cUsuarios
834:             THIS.CarregarAcessos()
835: 
836:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
837:                 THIS.grd_4c_Dados.SetFocus()
838:             ENDIF
839: 
840:         CATCH TO loc_oErro
841:             MsgErro(loc_oErro.Message + CHR(13) + ;
842:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
843:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnVisualizarClick")
844:         ENDTRY
845:     ENDPROC
846: 
847:     *--------------------------------------------------------------------------
848:     * BtnExcluirClick - Remove acesso selecionado do cursor local (pre-save)
849:     * Nao afeta SigCdGrA ate o Salvar. Exige registro corrente no grid.
850:     * Equivale ao Commandgroup2.Click do legado (Delete + Count + SetFocus).
851:     *--------------------------------------------------------------------------
852:     PROCEDURE BtnExcluirClick()

*-- Linhas 868 a 888:
868:             ENDIF
869: 
870:             IF THIS.this_oBusinessObject.RemoverAcessoLocal()
871:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
872:                     THIS.grd_4c_Dados.Refresh()
873:                     THIS.grd_4c_Dados.SetFocus()
874:                 ENDIF
875:             ENDIF
876: 
877:         CATCH TO loc_oErro
878:             MsgErro(loc_oErro.Message + CHR(13) + ;
879:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
880:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
881:         ENDTRY
882:     ENDPROC
883: 
884:     *--------------------------------------------------------------------------
885:     * FormParaBO - Copia valores do form para o Business Object
886:     *--------------------------------------------------------------------------
887:     PROCEDURE FormParaBO()
888:         IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 921 a 957:
921:         THIS.this_cNComps            = ""
922:         THIS.this_cGrupos            = ""
923: 
924:         *-- Limpa grid: desvincula RecordSource, recria cursor vazio
925:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
926:             THIS.grd_4c_Dados.RecordSource = ""
927:         ENDIF
928: 
929:         IF USED("cursor_4c_Acessos")
930:             USE IN cursor_4c_Acessos
931:         ENDIF
932: 
933:         SET NULL ON
934:         CREATE CURSOR cursor_4c_Acessos ;
935:             (Programas C(15) NULL, Parametros C(10) NULL, Descricaos C(150) NULL)
936:         SET NULL OFF
937: 
938:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
939:             THIS.grd_4c_Dados.ColumnCount  = 1
940:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Acessos"
941:             THIS.grd_4c_Dados.Column1.ControlSource = "cursor_4c_Acessos.Descricaos"
942:             THIS.grd_4c_Dados.Refresh()
943:         ENDIF
944: 
945:         THIS.txt_4c_Codigo.SetFocus()
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * CarregarLista - Recarrega dados do usuario corrente (alias de CarregarAcessos)
950:     *--------------------------------------------------------------------------
951:     PROCEDURE CarregarLista()
952:         IF !EMPTY(THIS.this_cUsuarios)
953:             THIS.CarregarAcessos()
954:         ENDIF
955:     ENDPROC
956: 
957:     *--------------------------------------------------------------------------

