# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 379: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAut.prg) - TRECHOS RELEVANTES PARA PASS GRID (1448 linhas total):

*-- Linhas 16 a 34:
16: * (cntSombra + Grd + TxtObs + botoes soltos direto na form). Ver padrao em
17: * Formale.prg/FormFpN.prg (dialogos OPERACIONAL planos).
18: *
19: * Fase 4/8 - Grid (Grd -> grd_4c_Dados, vinculado ao cursor local
20: * cursor_4c_Pagamentos, mesma estrutura de SigOpAutBO.this_cCursorPagamentos),
21: * os 3 botoes standalone do legado (Grade/Imprimir/Sair -> cmd_4c_Grade/
22: * cmd_4c_Fwbtnm1/cmd_4c_Sair) e a carga de dados (CarregarDados/VincularGrade,
23: * equivalentes ao bloco de consulta do Init legado). O legado NAO tem botoes
24: * CRUD (Incluir/Alterar/Excluir/Buscar) - este dialogo so marca linhas de
25: * pagamento/parcela para autenticar e imprime o comprovante.
26: *
27: * Fase 5/8 - Campo de observacao (Say6/TxtObs -> lbl_4c_Label6/txt_4c_TxtObs).
28: *
29: * Fase 6/8 - Controle OLE restante do dump (OleComm -> obj_4c_OleComm, porta
30: * serial da impressora de cheque/fiscal usada dentro de autentica()). SEM
31: * LOOKUPS: o form NAO tem nenhum CreateObject('fwbuscaext'/'fwBuscaSel'),
32: * sigacess() nem Seek em tabela auxiliar no codigo fonte original (SigOpAut e
33: * um dialogo modal de marcacao/autenticacao, nao um cadastro) - varredura
34: * integral de SigOpAut_form_codigo_fonte.txt confirma isso, entao esta

*-- Linhas 270 a 309:
270: 
271:     *--------------------------------------------------------------------------
272:     * ConfigurarGrid - Grd legado (sem PageFrame, filho direto do form):
273:     * ColumnCount=3, Column1=Check1 (Marca), Column2/Column3=Text1 (Obs/Fpags),
274:     * os dois ultimos ReadOnly. Cria o cursor cursor_4c_Pagamentos com a MESMA
275:     * estrutura/ordem de campos de SigOpAutBO.this_cCursorPagamentos (regra
276:     * CLAUDE.md: CREATE CURSOR identico em todo lugar onde o mesmo alias
277:     * aparece) - equivale ao Load legado:
278:     *   Create Cursor csPgto (Marca L, Obs C(27), fpags C(12), Printed L,
279:     *                         Autenticas n(1))
280:     *
281:     * Aqui ficam SO as propriedades de desenho do Grd (as que nao dependem do
282:     * cursor). O vinculo (ColumnCount/RecordSource/ControlSource/Width/
283:     * CurrentControl) mora em VincularGrade(), porque tambem tem de rodar
284:     * DEPOIS de cada carga de dados.
285:     *--------------------------------------------------------------------------
286:     PROTECTED PROCEDURE ConfigurarGrid()
287:         LOCAL loc_oErro
288:         TRY
289:             IF !USED("cursor_4c_Pagamentos")
290:                 CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
291:             ENDIF
292: 
293:             THIS.AddObject("grd_4c_Dados", "Grid")
294:             WITH THIS.grd_4c_Dados
295:                 .Top               = 85
296:                 .Left              = 12
297:                 .Width             = 527
298:                 .Height            = 228
299:                 .TabIndex          = 1
300:                 .FontName          = "Tahoma"
301:                 .FontSize          = 8
302:                 .AllowHeaderSizing = .F.
303:                 .AllowRowSizing    = .F.
304:                 .DeleteMark        = .F.
305:                 .RecordMark        = .F.
306:                 .RowHeight         = 16
307:                 .ScrollBars        = 2
308:                 *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
309:                 *-- READ-ONLY em runtime (medido no VFP9: "Property SPLITBAR

*-- Linhas 329 a 395:
329:     ENDPROC
330: 
331:     *--------------------------------------------------------------------------
332:     * VincularGrade - (Re)vincula grd_4c_Dados ao cursor_4c_Pagamentos.
333:     * Legado (fim do Init):
334:     *   With ThisForm.Grd
335:     *       .RecordSource          = 'csPgto'
336:     *       .RecordSourceType      = 1
337:     *       .Column1.ControlSource = 'csPgto.marca'
338:     *       .Column2.ControlSource = 'csPgto.Obs'
339:     *       .Column3.ControlSource = 'csPgto.fPags'
340:     *       .Refresh
341:     *   EndWith
342:     *
343:     * PUBLIC e idempotente de proposito: SigOpAutBO.PopularCursorPagamentos()
344:     * faz USE IN + CREATE CURSOR no alias da grade, e derrubar o alias leva o
345:     * Grid a ColumnCount = 0 - retangulo branco sem cabecalho, sem erro e sem
346:     * log, morto pelo resto da vida do form. Por isso TODO caminho que popula
347:     * o cursor chama este metodo depois. O CheckBox da Column1 tambem eh
348:     * reinstalado aqui, porque reconstruir o ColumnCount cria objetos Column
349:     * novos (CurrentControl volta a "Text1").
350:     *
351:     * Ordem obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
352:     * Width/Header (RecordSource recalcula as larguras para o default 90) e,
353:     * na Column1, AddObject -> propriedades do CheckBox -> CurrentControl ->
354:     * ControlSource por ULTIMO (ControlSource antes do AddObject dispara o
355:     * erro 1767).
356:     *--------------------------------------------------------------------------
357:     PROCEDURE VincularGrade()
358:         LOCAL loc_oErro, loc_oGrd, loc_lOk
359:         loc_lOk = .F.
360: 
361:         TRY
362:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Pagamentos")
363:                 loc_oGrd = THIS.grd_4c_Dados
364: 
365:                 *-- ColumnCount so eh reatribuido quando difere do esperado:
366:                 *-- REDUZIR destroi os controles postos por AddObject nas
367:                 *-- Columns (medido no VFP9); subir de 0 - que eh o estado
368:                 *-- depois do alias ser derrubado - eh justamente o caso que
369:                 *-- este metodo existe para consertar. Vem ANTES do
370:                 *-- RecordSource para o VFP nao auto-expandir a grade para as
371:                 *-- 5 colunas do cursor.
372:                 IF loc_oGrd.ColumnCount != 3
373:                     loc_oGrd.ColumnCount = 3
374:                 ENDIF
375: 
376:                 loc_oGrd.RecordSourceType = 1
377:                 loc_oGrd.RecordSource     = ""
378:                 loc_oGrd.ColumnCount = 3
379:                 loc_oGrd.RecordSource     = "cursor_4c_Pagamentos"
380: 
381:                 *-- Column1 - Check1 do legado (csPgto.marca), coluna de marcacao
382:                 loc_oGrd.Column1.FontSize  = 8
383:                 loc_oGrd.Column1.Movable   = .F.
384:                 loc_oGrd.Column1.Resizable = .F.
385:                 loc_oGrd.Column1.Alignment = 0
386:                 loc_oGrd.Column1.Enabled   = .T.
387:                 loc_oGrd.Column1.ReadOnly  = .F.
388:                 *-- Sparse = .F.: sem isto o CheckBox so desenha na linha
389:                 *-- corrente e as outras exibem 0/1 como texto, sem clique.
390:                 loc_oGrd.Column1.Sparse    = .F.
391: 
392:                 IF !PEMSTATUS(loc_oGrd.Column1, "chk_4c_Marca", 5)
393:                     loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
394:                 ENDIF
395: 

*-- Linhas 437 a 485:
437:                 loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
438:                 loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
439: 
440:                 *-- Width/Header DEPOIS do RecordSource e dos ControlSource,
441:                 *-- senao o VFP devolve as larguras para o default 90
442:                 loc_oGrd.Column1.Width = 17
443:                 loc_oGrd.Column2.Width = 382
444:                 loc_oGrd.Column3.Width = 94
445: 
446:                 *-- Headers sem texto no legado (Caption = "", Alignment = 2)
447:                 loc_oGrd.Column1.Header1.FontSize  = 8
448:                 loc_oGrd.Column1.Header1.Alignment = 2
449:                 loc_oGrd.Column1.Header1.Caption   = ""
450:                 loc_oGrd.Column2.Header1.FontSize  = 8
451:                 loc_oGrd.Column2.Header1.Alignment = 2
452:                 loc_oGrd.Column2.Header1.Caption   = ""
453:                 loc_oGrd.Column3.Header1.FontSize  = 8
454:                 loc_oGrd.Column3.Header1.Alignment = 2
455:                 loc_oGrd.Column3.Header1.Caption   = ""
456: 
457:                 *-- Ordem visual do SCX: Marca, Fpags, Obs (Column2.ColumnOrder
458:                 *-- = 3 e Column3.ColumnOrder = 2 no dump). ColumnOrder por
459:                 *-- ultimo, porque reordenar reposiciona as colunas irmas.
460:                 loc_oGrd.Column3.ColumnOrder = 2
461:                 loc_oGrd.Column2.ColumnOrder = 3
462: 
463:                 *-- Popular cursor NAO repinta a grade (regra CLAUDE.md #21):
464:                 *-- o legado fecha com Select csPgto / Go Top / .Refresh
465:                 SELECT cursor_4c_Pagamentos
466:                 GO TOP
467:                 loc_oGrd.Refresh()
468: 
469:                 *-- Os 4 handlers do CheckBox sao (re)ligados AQUI, e nao no
470:                 *-- InicializarForm: reconstruir o ColumnCount destroi os
471:                 *-- objetos Column e leva o chk_4c_Marca junto, e com ele os
472:                 *-- BINDEVENT. Ligados uma unica vez na inicializacao, o
473:                 *-- CheckBox ficaria inerte depois da primeira recarga.
474:                 THIS.LigarEventosGrade()
475: 
476:                 loc_lOk = .T.
477:             ENDIF
478:         CATCH TO loc_oErro
479:             MsgErro(loc_oErro.Message + CHR(13) + ;
480:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
481:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.VincularGrade")
482:             loc_lOk = .F.
483:         ENDTRY
484: 
485:         RETURN loc_lOk

*-- Linhas 500 a 527:
500:     * unico clique dispararia o handler N vezes, alternando a marca N vezes.
501:     *
502:     * PEMSTATUS ANINHADO, nao com AND: VFP9 nao faz short-circuit, entao
503:     * "PEMSTATUS(THIS, 'grd_4c_Dados', 5) AND PEMSTATUS(THIS.grd_4c_Dados...)"
504:     * avaliaria o segundo lado mesmo sem a grade existir.
505:     *--------------------------------------------------------------------------
506:     PROTECTED PROCEDURE LigarEventosGrade()
507:         LOCAL loc_oChk, loc_oErro
508: 
509:         TRY
510:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
511:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Marca", 5)
512:                     loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Marca
513: 
514:                     UNBINDEVENT(loc_oChk)
515: 
516:                     BINDEVENT(loc_oChk, "KeyPress",  THIS, "ChkMarcaKeyPress")
517:                     BINDEVENT(loc_oChk, "MouseUp",   THIS, "ChkMarcaMouseUp")
518:                     BINDEVENT(loc_oChk, "MouseDown", THIS, "ChkMarcaMouseDown")
519:                     BINDEVENT(loc_oChk, "Click",     THIS, "ChkMarcaClick")
520:                 ENDIF
521:             ENDIF
522:         CATCH TO loc_oErro
523:             MsgErro(loc_oErro.Message + CHR(13) + ;
524:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
525:                 "Procedure: " + loc_oErro.Procedure, ;
526:                 "Erro em FormSigOpAut.LigarEventosGrade")
527:         ENDTRY

*-- Linhas 546 a 584:
546:     * Aqui o toggle nativo foi suprimido (NODEFAULT nos handlers), entao ele eh
547:     * refeito explicitamente ANTES da regra - o resultado final eh identico.
548:     *
549:     * Marca e Printed sao LOGICOS no cursor (legado: "Create Cursor csPgto
550:     * (Marca L, Obs C(27), fpags C(12), Printed L, Autenticas n(1))"), por isso
551:     * a alternancia eh "!valor" e NAO o IIF(col = 0, 1, 0) usado quando a
552:     * coluna de marcacao eh numerica.
553:     *--------------------------------------------------------------------------
554:     PROCEDURE ValidarMarcacaoLinha()
555:         LOCAL loc_oErro
556: 
557:         TRY
558:             IF USED("cursor_4c_Pagamentos")
559:                 SELECT cursor_4c_Pagamentos
560:                 IF !EOF("cursor_4c_Pagamentos") AND !BOF("cursor_4c_Pagamentos")
561:                     REPLACE cursor_4c_Pagamentos.Marca ;
562:                         WITH !cursor_4c_Pagamentos.Marca
563: 
564:                     IF !cursor_4c_Pagamentos.Printed
565:                         REPLACE cursor_4c_Pagamentos.Marca WITH .T.
566:                     ENDIF
567: 
568:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
569:                         THIS.grd_4c_Dados.Refresh()
570:                     ENDIF
571:                 ENDIF
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message + CHR(13) + ;
575:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
576:                 "Procedure: " + loc_oErro.Procedure, ;
577:                 "Erro em FormSigOpAut.ValidarMarcacaoLinha")
578:         ENDTRY
579:     ENDPROC
580: 
581:     *--------------------------------------------------------------------------
582:     * ChkMarcaKeyPress - Espaco/Enter marcam a linha, igual ao clique.
583:     * Assinatura COMPLETA obrigatoria: handler ligado a KeyPress sem os dois
584:     * parametros estoura a cada tecla (regra CLAUDE.md #3).

*-- Linhas 915 a 935:
915:                         *-- autenticacao
916:                         loc_oBO.ZerarSeNaoRequerAutenticacao(THIS.ObterModeloImpressoraFiscal())
917: 
918:                         *-- PopularCursorPagamentos faz USE IN + CREATE CURSOR
919:                         *-- no alias da grade: sem revincular, o Grid fica em
920:                         *-- ColumnCount = 0 e vira um retangulo branco
921:                         THIS.VincularGrade()
922: 
923:                         *-- Legado: If Reccount() = 0 / ThisForm.Release / Return .F.
924:                         loc_lOk = (RECCOUNT("cursor_4c_Pagamentos") > 0)
925:                     ELSE
926:                         IF !EMPTY(loc_oBO.this_cMensagemErro)
927:                             MsgErro(loc_oBO.this_cMensagemErro, ;
928:                                 "Autentica" + CHR(231) + CHR(227) + "o")
929:                         ENDIF
930:                         loc_lOk = .F.
931:                     ENDIF
932:                 ENDIF
933:             ENDIF
934:         CATCH TO loc_oErro
935:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 997 a 1015:
997:     * o dump do SCX nao declara Visible para ele (eh um controle funcional de
998:     * porta serial, nunca um elemento de tela) e forcar .Visible = .T. criaria
999:     * uma caixa OLE 100x100 em branco sobre a grade (Top=91/Left=480 cai
1000:     * dentro da area do grd_4c_Dados). Mesmo padrao de exclusao por nome usado
1001:     * para containers flutuantes (regra CLAUDE.md de TornarControlesVisiveis).
1002:     *--------------------------------------------------------------------------
1003:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1004:         LOCAL loc_nI, loc_oControl, loc_nP, loc_lExcluido
1005: 
1006:         IF VARTYPE(par_oContainer) != "O"
1007:             RETURN
1008:         ENDIF
1009: 
1010:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1011:             loc_oControl = par_oContainer.Controls(loc_nI)
1012:             IF VARTYPE(loc_oControl) = "O"
1013:                 loc_lExcluido = INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OLECOMM")
1014: 
1015:                 IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido

*-- Linhas 1054 a 1073:
1054:     *   Thisform.Grd.Column1.Setfocus
1055:     *--------------------------------------------------------------------------
1056:     PROCEDURE BtnGradeClick()
1057:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1058:             THIS.grd_4c_Dados.Column1.SetFocus()
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click):
1064:     *   Select csPgto / If Reccount() > 0 / Go top / Scan
1065:     *       if !(csPgto.Printed)
1066:     *           .Grd.Refresh / .Grd.Column1.SetFocus
1067:     *           MessageBox("Autenticacao Obrigatoria",16,"") / Return
1068:     *       endif
1069:     *   EndScan / EndIf
1070:     *   ldtime = DateTime() / Do While DateTime()-ldtime<=2 / =chrsaw(.5) / EndDo
1071:     *   ThisForm.Release
1072:     *
1073:     * ExisteLinhaNaoAutenticada() (BO) reproduz o Scan/Locate For !Printed.

*-- Linhas 1081 a 1101:
1081: 
1082:         IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
1083:                 AND THIS.this_oBusinessObject.ExisteLinhaNaoAutenticada()
1084:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1085:                 THIS.grd_4c_Dados.Refresh()
1086:                 THIS.grd_4c_Dados.Column1.SetFocus()
1087:             ENDIF
1088:             MsgAviso("Autentica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria", ;
1089:                 "Aten" + CHR(231) + CHR(227) + "o")
1090:             RETURN
1091:         ENDIF
1092: 
1093:         loc_tInicio = DATETIME()
1094:         DO WHILE DATETIME() - loc_tInicio <= 2
1095:             DOEVENTS
1096:         ENDDO
1097: 
1098:         THIS.Release()
1099:     ENDPROC
1100: 
1101:     *--------------------------------------------------------------------------

*-- Linhas 1149 a 1168:
1149: 
1150:                 SELECT cursor_4c_Pagamentos
1151:                 GO TOP
1152:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1153:                     THIS.grd_4c_Dados.Refresh()
1154:                 ENDIF
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message + CHR(13) + ;
1158:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1159:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BtnImprimirClick")
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * FormParaBO - Transferencia FORM -> BO.
1165:     *
1166:     * Este dialogo nao tem ficha de cadastro: a superficie editavel do legado
1167:     * eh UM campo (TxtObs) mais a coluna de marcacao da grade. Logo o par
1168:     * FormParaBO/BOParaForm aqui nao mapeia dezenas de campos - mapeia o que

