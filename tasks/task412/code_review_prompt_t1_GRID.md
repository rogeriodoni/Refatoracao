# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 491: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFAPF.prg) - TRECHOS RELEVANTES PARA PASS GRID (804 linhas total):

*-- Linhas 429 a 508:
429:         LOCAL loc_oErro
430: 
431:         TRY
432:             SET NULL ON
433:             CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
434:             SET NULL OFF
435: 
436:             THIS.AddObject("grd_4c_Lista", "Grid")
437:             WITH THIS.grd_4c_Lista
438:                 .Top                = 95
439:                 .Left               = 5
440:                 .Width              = THIS.Width - 10
441:                 .Height             = THIS.Height - 100
442:                 .FontName           = "Verdana"
443:                 .FontSize           = 8
444:                 .ForeColor          = RGB(90, 90, 90)
445:                 .BackColor          = RGB(255, 255, 255)
446:                 .GridLineColor      = RGB(238, 238, 238)
447:                 .HighlightBackColor = RGB(255, 255, 255)
448:                 .HighlightForeColor = RGB(15, 41, 104)
449:                 .HighlightStyle     = 2
450:                 .DeleteMark         = .F.
451:                 .RecordMark         = .F.
452:                 .ScrollBars         = 2
453:                 .RowHeight          = 16
454:                 .ColumnCount        = 2
455:                 .RecordSource       = "cursor_4c_Dados"
456:                 .Column1.ControlSource    = "cursor_4c_Dados.Codigo"
457:                 .Column1.Width            = 150
458:                 .Column1.Header1.Caption  = "C" + CHR(243) + "digo"
459:                 .Column2.ControlSource    = "cursor_4c_Dados.Descricao"
460:                 .Column2.Width            = THIS.Width - 10 - 150 - 5
461:                 .Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
462:             ENDWITH
463: 
464:         CATCH TO loc_oErro
465:             MsgErro(loc_oErro.Message + CHR(13) + ;
466:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
467:                 "Procedure: " + loc_oErro.Procedure, ;
468:                 "Erro ConfigurarGrade")
469:         ENDTRY
470:     ENDPROC
471: 
472:     *==========================================================================
473:     * CarregarLista - Carrega/recarrega dados no grid principal
474:     * Form operacional sem tabela propria - cursor permanece vazio por padrao
475:     *==========================================================================
476:     PROCEDURE CarregarLista()
477:         LOCAL loc_oErro
478: 
479:         TRY
480:             IF USED("cursor_4c_Dados")
481:                 SELECT cursor_4c_Dados
482:                 ZAP
483:             ELSE
484:                 SET NULL ON
485:                 CREATE CURSOR cursor_4c_Dados (Codigo C(20) NULL, Descricao C(60) NULL)
486:                 SET NULL OFF
487:             ENDIF
488: 
489:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
490:                 THIS.grd_4c_Lista.ColumnCount       = 2
491:                 THIS.grd_4c_Lista.RecordSource      = "cursor_4c_Dados"
492:                 THIS.grd_4c_Lista.Column1.Header1.Caption = "C" + CHR(243) + "digo"
493:                 THIS.grd_4c_Lista.Column2.Header1.Caption = ;
494:                     "Descri" + CHR(231) + CHR(227) + "o"
495:             ENDIF
496: 
497:             THIS.AlternarPagina(1)
498: 
499:         CATCH TO loc_oErro
500:             MsgErro(loc_oErro.Message + CHR(13) + ;
501:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
502:                 "Procedure: " + loc_oErro.Procedure, ;
503:                 "Erro CarregarLista")
504:         ENDTRY
505:     ENDPROC
506: 
507:     *==========================================================================
508:     * AlternarPagina - Alterna entre modo Lista (1) e modo Dados (2)

*-- Linhas 519 a 551:
519: 
520:         IF par_nPagina = 1
521:             *-- Modo Lista: exibe grid, oculta painel de dados
522:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
523:                 THIS.grd_4c_Lista.Visible = .T.
524:             ENDIF
525:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
526:                 THIS.cnt_4c_PainelDados.Visible = .F.
527:             ENDIF
528:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
529:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
530:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
531:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
532:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
533:         ELSE
534:             *-- Modo Dados: oculta grid, exibe painel de dados
535:             IF VARTYPE(THIS.grd_4c_Lista) = "O"
536:                 THIS.grd_4c_Lista.Visible = .F.
537:             ENDIF
538:             IF VARTYPE(THIS.cnt_4c_PainelDados) = "O"
539:                 THIS.cnt_4c_PainelDados.Visible = .T.
540:             ENDIF
541:             THIS.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .F.
542:             THIS.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .F.
543:             THIS.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .F.
544:             THIS.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .F.
545:             THIS.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .F.
546:         ENDIF
547:     ENDPROC
548: 
549:     *==========================================================================
550:     * BtnIncluirClick - Inicia inclusao de novo registro
551:     *==========================================================================

