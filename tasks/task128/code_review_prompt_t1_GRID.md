# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 1247: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreipe.prg) - TRECHOS RELEVANTES PARA PASS GRID (2431 linhas total):

*-- Linhas 406 a 454:
406:         IF USED("cursor_4c_Operacoes")
407:             USE IN cursor_4c_Operacoes
408:         ENDIF
409:         CREATE CURSOR cursor_4c_Operacoes (;
410:             Marcas    I,;
411:             Emps      C(2),;
412:             Dopes     C(6),;
413:             Numes     N(8,0),;
414:             DescOrigs C(60),;
415:             DescDests C(60),;
416:             ContaEs   C(15),;
417:             LocalEnts N(8,0))
418: 
419:         THIS.ConfigurarGridOperacoes(loc_oPagina)
420:         THIS.ConfigurarBotoesSelecao(loc_oPagina)
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * ConfigurarGridOperacoes - Grid com 6 colunas para selecao de operacoes
425:     *   CheckBox em Column1: AddObject -> Caption/Value -> CurrentControl -> ControlSource
426:     *--------------------------------------------------------------------------
427:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPage)
428:         LOCAL loc_oGrid
429: 
430:         par_oPage.AddObject("grd_4c_GrdOper", "Grid")
431:         loc_oGrid = par_oPage.grd_4c_GrdOper
432: 
433:         WITH loc_oGrid
434:             .Top                = 125
435:             .Left               = 17
436:             .Width              = 727
437:             .Height             = 148
438:             .ColumnCount        = 6
439:             .RecordSource       = "cursor_4c_Operacoes"
440:             .RecordMark         = .F.
441:             .DeleteMark         = .F.
442:             .ReadOnly           = .F.
443:             .FontName           = "Verdana"
444:             .FontSize           = 8
445:             .ForeColor          = RGB(90, 90, 90)
446:             .BackColor          = RGB(255, 255, 255)
447:             .GridLineColor      = RGB(238, 238, 238)
448:             .HighlightBackColor = RGB(255, 255, 255)
449:             .HighlightForeColor = RGB(15, 41, 104)
450:             .HighlightStyle     = 2
451:             .ScrollBars         = 2
452:             .RowHeight          = 16
453: 
454:             *-- Column1: Marcas (CheckBox) - ordem critica obrigatoria

*-- Linhas 463 a 516:
463:                 .Check1.Height  = 14
464:                 .CurrentControl  = "Check1"
465:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
466:                 .Header1.Caption = ""
467:             ENDWITH
468: 
469:             *-- Column2: Emps
470:             WITH .Column2
471:                 .Width           = 40
472:                 .ControlSource   = "cursor_4c_Operacoes.Emps"
473:                 .Header1.Caption = "Emp"
474:             ENDWITH
475: 
476:             *-- Column3: Dopes (Operacao)
477:             WITH .Column3
478:                 .Width           = 80
479:                 .ControlSource   = "cursor_4c_Operacoes.Dopes"
480:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
481:             ENDWITH
482: 
483:             *-- Column4: Numes (Codigo)
484:             WITH .Column4
485:                 .Width           = 70
486:                 .ControlSource   = "cursor_4c_Operacoes.Numes"
487:                 .Header1.Caption = CHR(67) + CHR(243) + "digo"
488:             ENDWITH
489: 
490:             *-- Column5: DescOrigs (Conta Origem)
491:             WITH .Column5
492:                 .Width           = 255
493:                 .ControlSource   = "cursor_4c_Operacoes.DescOrigs"
494:                 .Header1.Caption = "Origem"
495:             ENDWITH
496: 
497:             *-- Column6: DescDests (Conta Destino) - 30+40+80+70+255+252=727
498:             WITH .Column6
499:                 .Width           = 252
500:                 .ControlSource   = "cursor_4c_Operacoes.DescDests"
501:                 .Header1.Caption = "Destino"
502:             ENDWITH
503: 
504:             .Visible = .T.
505:         ENDWITH
506:     ENDPROC
507: 
508:     *--------------------------------------------------------------------------
509:     * ConfigurarBotoesSelecao - Botoes SelTudo e Apaga ao lado direito do grid
510:     *--------------------------------------------------------------------------
511:     PROTECTED PROCEDURE ConfigurarBotoesSelecao(par_oPage)
512:         *-- SelTudo: selecionar todos (original top=220, left=756, w=45, h=45 -> Page1: top=138)
513:         par_oPage.AddObject("cmd_4c_SelTudo", "CommandButton")
514:         WITH par_oPage.cmd_4c_SelTudo
515:             .Top           = 138
516:             .Left          = 756

*-- Linhas 563 a 594:
563:             SELECT cursor_4c_Operacoes
564:             REPLACE ALL Marcas WITH 1
565:             GO TOP
566:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
567:         ENDIF
568:     ENDPROC
569: 
570:     *--------------------------------------------------------------------------
571:     * CmdApagaClick - Desmarca todos os registros do grid (Marcas=0)
572:     *   Replica: Select TmpOper + Replace All TmpOper.marcas with 0
573:     *--------------------------------------------------------------------------
574:     PROCEDURE CmdApagaClick()
575:         IF USED("cursor_4c_Operacoes")
576:             SELECT cursor_4c_Operacoes
577:             REPLACE ALL Marcas WITH 0
578:             GO TOP
579:             THIS.pgf_4c_Paginas.Page1.grd_4c_GrdOper.Refresh()
580:         ENDIF
581:     ENDPROC
582: 
583:     *--------------------------------------------------------------------------
584:     * AlternarPagina - Alterna para pagina indicada no PageFrame
585:     *   Formulario de etiquetas usa PageCount=1 (todos os controles em Page1)
586:     *--------------------------------------------------------------------------
587:     PROCEDURE AlternarPagina(par_nPagina)
588:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
589:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
590:         ENDIF
591:     ENDPROC
592: 
593:     *--------------------------------------------------------------------------
594:     * ConfigurarPaginaDados - Adiciona campos de filtro (primeira metade) em Page1

*-- Linhas 968 a 987:
968:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
969:             ELSE
970:                 IF !loc_oForm.this_lAchouRegistro
971:                 loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
972:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
973:                 loc_oForm.Show()
974:                 IF loc_oForm.this_lSelecionou
975:                     loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.Codigos)
976:                     loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
977:                 ELSE
978:                     loc_oPg1.txt_4c_Codigo.Value = ""
979:                     loc_oPg1.txt_4c_Desc.Value   = ""
980:                 ENDIF
981:                 ENDIF
982:             ENDIF
983: 
984:             IF USED("cursor_4c_BuscaCodigo")
985:                 USE IN cursor_4c_BuscaCodigo
986:             ENDIF
987:             loc_oForm.Release()

*-- Linhas 1026 a 1045:
1026:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1027:             ELSE
1028:                 IF !loc_oForm.this_lAchouRegistro
1029:                 loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1030:                 loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1031:                 loc_oForm.Show()
1032:                 IF loc_oForm.this_lSelecionou
1033:                     loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDesc.Codigos)
1034:                     loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1035:                 ELSE
1036:                     loc_oPg1.txt_4c_Codigo.Value = ""
1037:                     loc_oPg1.txt_4c_Desc.Value   = ""
1038:                 ENDIF
1039:                 ENDIF
1040:             ENDIF
1041: 
1042:             IF USED("cursor_4c_BuscaDesc")
1043:                 USE IN cursor_4c_BuscaDesc
1044:             ENDIF
1045:             loc_oForm.Release()

*-- Linhas 1070 a 1089:
1070:                 RETURN
1071:             ENDIF
1072: 
1073:             loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1074:             loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1075:             loc_oForm.Show()
1076: 
1077:             IF loc_oForm.this_lSelecionou
1078:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaCodigo.Codigos)
1079:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaCodigo.Descs)
1080:                 loc_oPg1.txt_4c_Codigo.Refresh()
1081:                 loc_oPg1.txt_4c_Desc.Refresh()
1082:                 THIS.AtualizarEstadoControles()
1083:             ENDIF
1084: 
1085:             IF USED("cursor_4c_BuscaCodigo")
1086:                 USE IN cursor_4c_BuscaCodigo
1087:             ENDIF
1088:             loc_oForm.Release()
1089: 

*-- Linhas 1109 a 1128:
1109:                 RETURN
1110:             ENDIF
1111: 
1112:             loc_oForm.mAddColuna("Descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
1113:             loc_oForm.mAddColuna("Codigos", "", CHR(67) + CHR(243) + "digo")
1114:             loc_oForm.Show()
1115: 
1116:             IF loc_oForm.this_lSelecionou
1117:                 loc_oPg1.txt_4c_Codigo.Value = ALLTRIM(cursor_4c_BuscaDesc.Codigos)
1118:                 loc_oPg1.txt_4c_Desc.Value   = ALLTRIM(cursor_4c_BuscaDesc.Descs)
1119:                 loc_oPg1.txt_4c_Codigo.Refresh()
1120:                 loc_oPg1.txt_4c_Desc.Refresh()
1121:                 THIS.AtualizarEstadoControles()
1122:             ENDIF
1123: 
1124:             IF USED("cursor_4c_BuscaDesc")
1125:                 USE IN cursor_4c_BuscaDesc
1126:             ENDIF
1127:             loc_oForm.Release()
1128: 

*-- Linhas 1188 a 1212:
1188:         loc_dDataIni = loc_oPg1.txt_4c__dt_inicial.Value
1189:         loc_dDataFin = loc_oPg1.txt_4c__dt_final.Value
1190:         loc_nConta   = loc_oPg1.obj_4c_Opt_conta.Value
1191:         loc_oGrid    = loc_oPg1.grd_4c_GrdOper
1192: 
1193:         IF EMPTY(loc_dDataFin)
1194:             RETURN
1195:         ENDIF
1196: 
1197:         loc_oGrid.RecordSource = ""
1198: 
1199:         TRY
1200:             IF loc_nConta = 1
1201:                 loc_cSQL = "SELECT 0 AS Marcas, a.Emps, a.Dopes, a.Numes, " + ;
1202:                            "b.RClis AS DescOrigs, c.RClis AS DescDests, " + ;
1203:                            "a.ContaEs, a.LocalEnts, " + ;
1204:                            "b.IClis, b.RClis, b.Endes, b.Nums, b.Compls, " + ;
1205:                            "b.Bairs, b.Cidas, b.Ceps, b.Estas, b.Tel1s, " + ;
1206:                            "b.Tel2s, b.Faxs, b.Nascs, b.cIdChaves, " + ;
1207:                            "b.Codigos, b.Paises, b.Contato " + ;
1208:                            "FROM SigMvCab a " + ;
1209:                            "INNER JOIN SigCdCli b ON a.ContaOs = b.Iclis " + ;
1210:                            "INNER JOIN SigCdCli c ON a.ContaDs = c.Iclis " + ;
1211:                            "WHERE RTRIM(a.Dopes) = " + EscaparSQL(loc_cDopes) + ;
1212:                            " AND a.Datas BETWEEN " + FormatarDataSQL(loc_dDataIni) + ;

*-- Linhas 1233 a 1263:
1233: 
1234:             IF loc_nResult > 0
1235:                 IF USED("cursor_4c_Operacoes")
1236:                     USE IN cursor_4c_Operacoes
1237:                 ENDIF
1238:                 SELECT * FROM cursor_4c_TmpQuery INTO CURSOR cursor_4c_Operacoes READWRITE
1239:                 IF USED("cursor_4c_TmpQuery")
1240:                     USE IN cursor_4c_TmpQuery
1241:                 ENDIF
1242: 
1243:                 SELECT cursor_4c_Operacoes
1244:                 IF !EOF()
1245:                     GO TOP
1246:                     loc_oGrid.ColumnCount = 3
1247:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1248:                 ELSE
1249:                     MsgAviso("Nenhum movimento encontrado nesse per" + ;
1250:                         CHR(237) + "odo.", "Aviso")
1251:                 ENDIF
1252:             ELSE
1253:                 IF USED("cursor_4c_TmpQuery")
1254:                     USE IN cursor_4c_TmpQuery
1255:                 ENDIF
1256:                 MsgErro("Erro ao consultar movimentos de " + loc_cDopes + ".", "Erro")
1257:             ENDIF
1258: 
1259:         CATCH TO loc_oErro
1260:             MsgErro(loc_oErro.Message + CHR(13) + ;
1261:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
1262:         ENDTRY
1263: 

*-- Linhas 1991 a 2009:
1991:             IF USED("CsCabecalho")
1992:                 USE IN CsCabecalho
1993:             ENDIF
1994:             CREATE CURSOR CsCabecalho (llImpPais L, llImpCodigos L)
1995:             APPEND BLANK
1996:             REPLACE llImpPais WITH ;
1997:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptPais", 5) AND loc_oPg1.obj_4c_OptPais.Value = 1, .T., .F.) ;
1998:                 IN CsCabecalho
1999:             REPLACE llImpCodigos WITH ;
2000:                 IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptCodigo", 5) AND loc_oPg1.obj_4c_OptCodigo.Value = 1, .T., .T.) ;
2001:                 IN CsCabecalho
2002: 
2003:             loc_nContatos = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptContatos", 5), loc_oPg1.obj_4c_OptContatos.Value, 2)
2004:             loc_nProper   = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OptProper", 5),   loc_oPg1.obj_4c_OptProper.Value,   2)
2005:             loc_nOrdem    = IIF(PEMSTATUS(loc_oPg1, "obj_4c_Option", 5),      loc_oPg1.obj_4c_Option.Value,      2)
2006:             loc_nOrdemDir = IIF(PEMSTATUS(loc_oPg1, "obj_4c_OpOrdem", 5),     loc_oPg1.obj_4c_OpOrdem.Value,     2)
2007:             loc_lModoOp   = PEMSTATUS(loc_oPg1, "txt_4c__nm_operacao", 5) AND ;
2008:                             !EMPTY(ALLTRIM(loc_oPg1.txt_4c__nm_operacao.Value))
2009: 

