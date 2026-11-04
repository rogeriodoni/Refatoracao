# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'MARCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: I, CPROS, CUSTOS, MATS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
  DeleteMark = .F.
  DeleteMark = .F.
Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas ;
  From crGrade ;
	.DeleteMark 	   = .f.
	.Column1.ControlSource   = [crGrade.Marcas]
	.Column2.ControlSource   = [crGrade.Mats]
	.Column3.ControlSource   = [crGrade.DPros]
	.Column4.ControlSource   = [crGrade.Qtds]
	.Column5.ControlSource   = [crGrade.UniCompos]
	.Column6.ControlSource   = [crGrade.PCompos]
	.Column7.ControlSource   = [crGrade.Moeds]
	.Column8.ControlSource   = [crGrade.Totas]
	.DeleteMark 	   = .f.
	.Column1.ControlSource  = [crRodape.Descrs]
	.Column2.ControlSource  = [crRodape.Usuars]
	.Column3.ControlSource  = [crRodape.Totas]
lcQuery = [Select a.CPros, a.Mats, b.DPros, a.Qtds, a.UniCompos, b.PVens as PCompos, b.Moevs as Moeds, ] + ;
		    [From SigPrCpo a, SigCdPro b ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalCompo]) < 1)
Select LocalCompo
	Insert Into crGrade (Marcas, Mats, DPros, Qtds, UniCompos, PCompos, Moeds, Totas, Reffs, FigJpgs, Tipos) ;
Select crGrade
lcQuery = [Select Tipos ] + ;
		    [From SigCdTpc ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, [LocalTpCom]) < 1)
Select LocalTpCom
Insert Into crRodape (Totas) Values (0)
	Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas ;
	  From crGrade ;
	Select LocalPro
Select crGrade
Select crGrade
Select crGrade
		Delete In crGrade
Select crGrade
Select crGrade
	Delete In crGrade
Select crGrade

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCpo.prg) - TRECHOS RELEVANTES PARA PASS SQL (1778 linhas total):

*-- Linhas 27 a 60:
27: * grdItens) + grade de totais (grd_4c_Rodape, equivalente a grdRodape) +
28: * CommandGroup de saida (cmg_4c_Botoes, equivalente a cntBotoes) + o metodo
29: * CarregarDados() (equivalente a SelecionaDados/AtuaTotas), que popula os
30: * cursores da BO ANTES das grades serem montadas - Column.ControlSource
31: * exige o cursor ja existente (regra #41). ComboBox de tipos e Image
32: * (Fases 5-6) e os eventos reais (Check1 da grade, Valid do combo, Click
33: * dos botoes, DblClick da imagem - Fase 7) entram nos blocos seguintes.
34: *
35: * Fase 5/8: label + combobox de filtro por tipo de composicao
36: * (lbl_4c_Label1/cbo_4c_CmbTipos, equivalentes a Say1/cmbTipos do legado),
37: * ligado ao cursor_4c_Tipos ja populado pela BO em CarregarTipos().
38: *
39: * Fase 6/8 (este bloco): ultimos controles e a VALIDACAO DE CAMPO do
40: * legado, ligada por BINDEVENT -
41: *   - Image de zoom do componente (img_4c_ImgFigJpg, equivalente a
42: *     ImgFigJpg do legado) - nasce oculta, igual ao legado (regra de
43: *     container flutuante: excluida de TornarControlesVisiveis);
44: *   - ValidarFiltroTipo(): o PROCEDURE Valid do cmbTipos legado
45: *     (Select crGrade / Set Filter To Tipos = cmbTipos.Value In crGrade /
46: *     Go Top In crGrade / ThisForm.grdItens.Refresh), delegando a
47: *     THIS.this_oBusinessObject.AplicarFiltroTipo();
48: *   - AtualizarRodape(par_nRegistroGrade): funil UNICO de repintura da
49: *     grade + grade de totais + Buttons(1).Enabled (regra #21 - popular
50: *     cursor NAO repinta a grade; o repaint tem de rodar em TODO caminho
51: *     que mexe no cursor), chamado pela validacao do combo com 0 (GO TOP,
52: *     como o legado) e reusado na Fase 7 pelo toggle do checkbox, que
53: *     passa o RECNO para a grade nao saltar;
54: *   - ValidarFocoRodape(): o GotFocus de grdRodape.Column1.Text1 legado
55: *     (ThisForm.grdItens.Column1.SetFocus) - a grade de totais eh
56: *     somente-leitura e devolve o foco a grade de itens;
57: *   - ValidarTagRodapeGotFocus()/ValidarTagRodapeLostFocus(): o par
58: *     GotFocus (This.Tag = This.Value) / LostFocus (This.Value =
59: *     This.Tag) de grdRodape.Column2.Text1 legado, que restaura o valor
60: *     original da celula caso algo a tenha alterado.

*-- Linhas 190 a 208:
190: 
191:                     *-- CarregarDados() PRIMEIRO: popula cursor_4c_Grade/
192:                     *-- cursor_4c_Rodape via BO antes de qualquer Grid ser
193:                     *-- montado (regra #41 - Column.ControlSource exige o
194:                     *-- cursor ja existente).
195:                     THIS.CarregarDados()
196:                     THIS.ConfigurarGridItens()
197:                     THIS.ConfigurarGridRodape()
198:                     THIS.ConfigurarFiltroTipo()
199:                     THIS.ConfigurarBotoes()
200:                     THIS.ConfigurarImagem()
201: 
202:                     THIS.TornarControlesVisiveis(THIS)
203: 
204:                     *-- Trecho FINAL do selecionadados legado (Go Top +
205:                     *-- grdItens.Refresh + Column1.SetFocus + Go Top In
206:                     *-- crRodape + grdRodape.Refresh): popular o cursor NAO
207:                     *-- repinta a grade (regra #21), e o repaint tem de rodar
208:                     *-- DEPOIS de TornarControlesVisiveis - Refresh em

*-- Linhas 282 a 301:
282:     *--------------------------------------------------------------------------
283:     * CarregarDados - popula cursor_4c_Grade via
284:     * THIS.this_oBusinessObject.CarregarComposicao() (equivalente ao
285:     * Zap crGrade/crRodape + Insert Into crGrade do SelecionaDados legado),
286:     * cria a linha unica de cursor_4c_Rodape (Insert Into crRodape (Totas)
287:     * Values (0) legado) e calcula os totais iniciais apenas quando ha
288:     * componentes (If (Reccount([crGrade]) > 0).../AtuaTotas legado) - "Where
289:     * Marcas" eh criterio de negocio dentro de AtualizarTotais (regra #17).
290:     *
291:     * Roda ANTES de ConfigurarGridItens/ConfigurarGridRodape: os dois
292:     * cursores DEVEM existir quando as grades forem montadas (regra #41). Se
293:     * CarregarComposicao() falhar (SQL), cursor_4c_Grade pode nao ter sido
294:     * criado pela BO - o fallback abaixo garante a estrutura vazia com as
295:     * MESMAS colunas de SigOpCpoBO.CarregarComposicao(), para a grade montar
296:     * sem erro mesmo com a composicao vazia.
297:     *--------------------------------------------------------------------------
298:     PROTECTED PROCEDURE CarregarDados()
299:         LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape
300:         loc_lSucesso      = .F.
301:         loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade

*-- Linhas 310 a 400:
310: 
311:         IF !USED(loc_cCursorGrade)
312:             SET NULL ON
313:             CREATE CURSOR (loc_cCursorGrade) ;
314:                 (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
315:                  Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
316:                  Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
317:                  FigJpgs M, Tipos C(20))
318:             SET NULL OFF
319:         ENDIF
320: 
321:         IF USED(loc_cCursorRodape)
322:             USE IN (loc_cCursorRodape)
323:         ENDIF
324: 
325:         SET NULL ON
326:         CREATE CURSOR (loc_cCursorRodape) (Descrs C(100), Usuars C(10), Totas N(12,2))
327:         SET NULL OFF
328: 
329:         *-- "Insert Into crRodape (Totas) Values (0)" do selecionadados legado.
330:         *-- O REPLACE vai com "IN (<alias>)" EXPLICITO: AtualizarTotais() do
331:         *-- BO faz "SELECT ... INTO CURSOR <tmp>" seguido de "USE IN <tmp>", e
332:         *-- fechar o cursor CORRENTE deixa a work area VAZIA - um REPLACE sem
333:         *-- alias logo depois estoura "No table is open in the current work
334:         *-- area." e derruba o InicializarForm (o form nao abre).
335:         SELECT (loc_cCursorRodape)
336:         APPEND BLANK
337:         REPLACE Totas WITH 0 IN (loc_cCursorRodape)
338: 
339:         IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdeComponentes > 0
340:             THIS.this_oBusinessObject.AtualizarTotais()
341:             REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
342:                 IN (loc_cCursorRodape)
343:         ENDIF
344: 
345:         IF USED(loc_cCursorGrade)
346:             SELECT (loc_cCursorGrade)
347:             GO TOP
348:         ENDIF
349: 
350:         SELECT (loc_cCursorRodape)
351:         GO TOP
352: 
353:         RETURN loc_lSucesso
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarGridItens - grade de componentes da composicao (grdItens do
358:     * legado), ligada a cursor_4c_Grade (ja populado por CarregarDados()).
359:     * Geometria e colunas TRANSCRITAS do dump (SIGOPCPO.grdItens +
360:     * PROCEDURE montagrades): 8 colunas, Column.InputMask/ControlSource
361:     * sao propriedades que a Column repassa ao CurrentControl - igual ao
362:     * legado. Ordem de configuracao segue o padrao canonico (ColumnCount ->
363:     * RecordSource -> ControlSource -> Header1.Caption -> Width por ultimo -
364:     * Problema 48/regra #41): mexer em Width ANTES de RecordSource/
365:     * ControlSource estabilizarem reseta tudo para o default 90.
366:     *
367:     * Column1 recebe CheckBox via AddObject + CurrentControl + Sparse = .F.
368:     * (regra #18 - AddObject sozinho NAO faz o controle aparecer). O For
369:     * Movable/Resizable/ReadOnly do legado (.Column&lcCol..ReadOnly =
370:     * (I > 1)) foi transcrito coluna a coluna: Column1 fica EDITAVEL (o
371:     * checkbox), Column2-8 continuam ReadOnly - e o ReadOnly de Column vem
372:     * DEPOIS do ReadOnly do Grid (regra #18).
373:     *--------------------------------------------------------------------------
374:     PROTECTED PROCEDURE ConfigurarGridItens()
375:         THIS.AddObject("grd_4c_Itens", "Grid")
376:         WITH THIS.grd_4c_Itens
377:             .Top               = 198
378:             .Left              = 10
379:             .Width             = 980
380:             .Height            = 371
381:             .FontName          = "Tahoma"
382:             .FontSize          = 8
383:             .AllowHeaderSizing = .F.
384:             .AllowRowSizing    = .F.
385:             .DeleteMark        = .F.
386:             .RecordMark        = .F.
387:             .HeaderHeight      = 16
388:             .RowHeight         = 18
389:             .ScrollBars        = 2
390:             .GridLineColor     = RGB(238, 238, 238)
391:             .ToolTipText       = "Grade de Produtos"
392:             .ReadOnly          = .T.
393:         ENDWITH
394: 
395:         *-- Vinculo ao cursor + colunas: extraido para VincularGradeItens()
396:         *-- porque CarregarLista() tem de poder REFAZE-LO (Problema 48 -
397:         *-- re-atribuir RecordSource reseta Column.Width/Header1.Caption e
398:         *-- destroi o CurrentControl do CheckBox). Chamado DEPOIS do
399:         *-- .ReadOnly = .T. do Grid, porque o ReadOnly do grid propaga para
400:         *-- as colunas e sobrescreveria o Column1.ReadOnly = .F. (regra #18).

*-- Linhas 419 a 437:
419:     * VincularGradeItens - liga grd_4c_Itens a cursor_4c_Grade e configura as
420:     * 8 colunas. Extraido de ConfigurarGridItens() para ser REUSADO por
421:     * CarregarLista(): a ordem canonica eh ColumnCount -> RecordSource ->
422:     * ControlSource -> Header1.Caption -> Width por ULTIMO (Problema 48 /
423:     * regra #41), porque re-atribuir RecordSource reseta Width e Caption para
424:     * o default 90/"Header1" e DESTROI o CurrentControl do CheckBox da
425:     * Column1 (regra #18) - quem re-vincula tem de repetir o bloco INTEIRO.
426:     *
427:     * ColumnCount so eh tocado quando esta diferente de 8: atribuir
428:     * ColumnCount RECRIA os objetos Column, matando o CheckBox e os
429:     * BINDEVENT dele. Por isso os 4 handlers do CheckBox sao ligados APENAS
430:     * no passe em que o controle de fato nasce (AddObject) - religar sem o
431:     * AddObject somaria uma 2a chamada do mesmo handler por evento, e o
432:     * toggle da marcacao se anularia.
433:     *--------------------------------------------------------------------------
434:     PROTECTED PROCEDURE VincularGradeItens()
435:         LOCAL loc_cCursor, loc_lCriouCheck
436:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorGrade
437:         loc_lCriouCheck = .F.

*-- Linhas 443 a 468:
443: 
444:             .RecordSource = loc_cCursor
445: 
446:             .Column1.ControlSource = loc_cCursor + ".Marcas"
447:             .Column2.ControlSource = loc_cCursor + ".Mats"
448:             .Column3.ControlSource = loc_cCursor + ".Dpros"
449:             .Column4.ControlSource = loc_cCursor + ".Qtds"
450:             .Column5.ControlSource = loc_cCursor + ".UniCompos"
451:             .Column6.ControlSource = loc_cCursor + ".PCompos"
452:             .Column7.ControlSource = loc_cCursor + ".Moeds"
453:             .Column8.ControlSource = loc_cCursor + ".Totas"
454: 
455:             .Column1.Header1.Caption = ""
456:             .Column2.Header1.Caption = "Item"
457:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
458:             .Column4.Header1.Caption = "Qtde."
459:             .Column5.Header1.Caption = "Uni"
460:             .Column6.Header1.Caption = "Valor Unit" + CHR(225) + "rio"
461:             .Column7.Header1.Caption = "Moe"
462:             .Column8.Header1.Caption = "Valor Total"
463: 
464:             .Column4.InputMask = "99999.999"
465:             .Column6.InputMask = "99999999.999"
466:             .Column8.InputMask = "99999999.99"
467: 
468:             .Column1.Width = 15

*-- Linhas 569 a 614:
569:     * cursor_4c_Rodape (1 linha, ja populada por CarregarDados()). Geometria
570:     * e colunas TRANSCRITAS do dump (SIGOPCPO.grdRodape + PROCEDURE
571:     * montagrades): 3 colunas, todas ReadOnly - mesmo ordem canonica
572:     * (ControlSource -> Header1.Caption -> Width por ultimo).
573:     *--------------------------------------------------------------------------
574:     PROTECTED PROCEDURE ConfigurarGridRodape()
575:         LOCAL loc_cCursor
576:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorRodape
577: 
578:         THIS.AddObject("grd_4c_Rodape", "Grid")
579:         WITH THIS.grd_4c_Rodape
580:             .Top               = 566
581:             .Left              = 542
582:             .Width             = 447
583:             .Height            = 23
584:             .FontName          = "Arial"
585:             .AllowHeaderSizing = .F.
586:             .AllowRowSizing    = .F.
587:             .DeleteMark        = .F.
588:             .RecordMark        = .F.
589:             .HeaderHeight      = 4
590:             .ScrollBars        = 2
591:             .BackColor         = RGB(224, 253, 254)
592:             .ToolTipText       = "Totais"
593:             .ColumnCount       = 3
594:             .ReadOnly          = .T.
595:             .RecordSource      = loc_cCursor
596: 
597:             .Column1.ControlSource = loc_cCursor + ".Descrs"
598:             .Column2.ControlSource = loc_cCursor + ".Usuars"
599:             .Column3.ControlSource = loc_cCursor + ".Totas"
600: 
601:             .Column1.Header1.Caption = ""
602:             .Column2.Header1.Caption = ""
603:             .Column3.Header1.Caption = ""
604: 
605:             .Column3.InputMask = "999999999.99"
606: 
607:             .Column1.Width = 152
608:             .Column2.Width = 152
609:             .Column3.Width = 120
610: 
611:             .Column1.FontName  = "Arial"
612:             .Column1.BackColor = RGB(245, 251, 136)
613:             .Column2.FontName  = "Arial"
614:             .Column2.FontBold  = .T.

*-- Linhas 658 a 676:
658:     * (classe say, regra #23), mas aqui o legado JA declara Width=32 - entao
659:     * NAO eh o caso da regra (nada a corrigir).
660:     *
661:     * cmbTipos eh fwcombo Style=2 (dropdown list) SEM ControlSource: o
662:     * legado o popula via Clear/AddItem a partir de LocalTpCom (SigCdTpc),
663:     * ja feito pela BO em CarregarTipos() -> cursor_4c_Tipos. Aqui o combo
664:     * liga via RowSourceType=2 (Alias) nesse MESMO cursor (ja existe quando
665:     * este metodo roda - chamado DEPOIS de CarregarDados() em
666:     * InicializarForm), o que reproduz a lista sem reimplementar o
667:     * Clear/AddItem. .Value recebe this_cTipoSelecionado (equivalente a
668:     * ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos) do
669:     * SelecionaDados legado), DEPOIS do RowSource estar definido. O Valid
670:     * do legado (Set Filter To Tipos = cmbTipos.Value In crGrade + Refresh)
671:     * eh ligado no fim deste metodo e implementado em ValidarFiltroTipo(),
672:     * delegando a THIS.this_oBusinessObject.AplicarFiltroTipo().
673:     *--------------------------------------------------------------------------
674:     PROTECTED PROCEDURE ConfigurarFiltroTipo()
675:         LOCAL loc_cCursorTipos
676:         loc_cCursorTipos = THIS.this_oBusinessObject.this_cCursorTipos

*-- Linhas 865 a 883:
865:     *--------------------------------------------------------------------------
866:     * ValidarFiltroTipoExec - corpo da validacao do campo Tipo. Transcricao
867:     * do PROCEDURE Valid de SIGOPCPO.cmbTipos:
868:     *     Select crGrade
869:     *     Set Filter To Tipos = ThisForm.cmbTipos.Value In crGrade
870:     *     Go Top In crGrade
871:     *     ThisForm.grdItens.Refresh
872:     * O Set Filter/Go Top moram em
873:     * THIS.this_oBusinessObject.AplicarFiltroTipo() (fonte unica do filtro,
874:     * Fase 2) e a repintura em THIS.AtualizarRodape() (funil unico, regra
875:     * #21) - aqui fica apenas a leitura do campo e a guarda de
876:     * valor-nao-mudou.
877:     *
878:     * A comparacao da guarda usa ALLTRIM nos DOIS lados: o .Value vem de uma
879:     * coluna char(20) (padded) e this_cTipoFiltroAtual pode ter sido gravado
880:     * sem o padding, e com SET EXACT ON (config.prg) "X" == "X   " eh .F. -
881:     * sem o ALLTRIM a guarda nunca casaria e o filtro seria reaplicado duas
882:     * vezes por escolha. ALLTRIM aqui eh seguro porque a guarda so decide
883:     * REAPLICAR ou nao; quem compara contra o cursor eh a BO, com o valor

*-- Linhas 948 a 966:
948:     *     que eh o que o caminho do CHECKBOX precisa (Fase 7): a linha
949:     *     corrente eh o que o AfterRowColChange usa para escolher a imagem,
950:     *     e um GO TOP faria a grade saltar a cada marcacao.
951:     * Repor o ponteiro eh OBRIGATORIO nos dois casos: o SELECT ... SUM() de
952:     * AtualizarTotais() percorre o cursor e pode deixa-lo em EOF.
953:     *
954:     * O metodo eh o FUNIL de sincronismo desta tela, nos tres passos:
955:     *   1. THIS.FormParaBO()  - o que esta nos controles e na linha corrente
956:     *                           da grade vai para as properties do BO;
957:     *   2. BO.AtualizarTotais() - o BO recalcula o que eh dele (totais e
958:     *                           this_lPermiteConfirmar);
959:     *   3. THIS.BOParaForm()  - o estado do BO volta para os controles
960:     *                           (total do rodape, botao Confirmar, imagem do
961:     *                           componente, combo de tipo).
962:     * Nenhum handler escreve direto nesses controles: fonte unica.
963:     *
964:     * Reentrancia: os passos 1 e 3 mexem no ponteiro do cursor e repintam a
965:     * grade, o que redispara o AfterRowColChange dela - que chama este
966:     * mesmo metodo. this_lEmAtualizacao garante UM passe por acao do

*-- Linhas 987 a 1005:
987:                 *-- Ponteiro ANTES de FormParaBO(): eh a linha corrente que
988:                 *-- CarregarDoCursor() le para alimentar o BO.
989:                 IF USED(loc_cCursorGrade)
990:                     SELECT (loc_cCursorGrade)
991:                     IF loc_nRegGrade > 0 AND loc_nRegGrade <= RECCOUNT()
992:                         GO loc_nRegGrade
993:                     ELSE
994:                         GO TOP
995:                     ENDIF
996:                 ENDIF
997: 
998:                 THIS.FormParaBO()
999:                 THIS.this_oBusinessObject.AtualizarTotais()
1000: 
1001:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1002:                     THIS.grd_4c_Itens.Refresh()
1003:                 ENDIF
1004: 
1005:                 THIS.BOParaForm()

*-- Linhas 1137 a 1155:
1137:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
1138: 
1139:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1140:                     SELECT (loc_cCursor)
1141:                     REPLACE Marcas WITH !Marcas
1142:                     loc_nRecno = RECNO()
1143: 
1144:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1145:                         THIS.grd_4c_Itens.Column1.Refresh()
1146:                     ENDIF
1147: 
1148:                     THIS.AtualizarRodape(loc_nRecno)
1149:                 ENDIF
1150:             ENDIF
1151: 
1152:         CATCH TO loc_oErro
1153:             MsgErro(loc_oErro.Message + CHR(13) + ;
1154:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1155:                     "Procedure: " + loc_oErro.Procedure, ;

*-- Linhas 1245 a 1269:
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * BtnConfirmarClick - Click de Buttons(1) do cntBotoes legado (OK):
1248:     *     Select crGrade
1249:     *     Set Filter To
1250:     *     Go Top In crGrade
1251:     *     Select crGrade
1252:     *     Scan
1253:     *         If Not Marcas
1254:     *             Delete In crGrade
1255:     *         EndIf
1256:     *     EndScan
1257:     *     ThisForm.Release
1258:     * O descarte das linhas nao marcadas mora em
1259:     * THIS.this_oBusinessObject.ConfirmarSelecao() (fonte unica, Fase 2). O
1260:     * Release so acontece com sucesso - sem RETURN dentro do TRY (regra #1),
1261:     * flag loc_lSucesso decide a saida DEPOIS do ENDTRY. PUBLIC (alvo de
1262:     * BINDEVENT, regra #3).
1263:     *--------------------------------------------------------------------------
1264:     PROCEDURE BtnConfirmarClick()
1265:         LOCAL loc_lSucesso, loc_oErro
1266:         loc_lSucesso = .F.
1267: 
1268:         TRY
1269:             IF VARTYPE(THIS.this_oBusinessObject) != "O"

*-- Linhas 1292 a 1315:
1292: 
1293:     *--------------------------------------------------------------------------
1294:     * BtnCancelarClick - Click de Buttons(2) do cntBotoes legado (Cancelar):
1295:     *     Select crGrade
1296:     *     Set Filter To
1297:     *     Go Top In crGrade
1298:     *     Select crGrade
1299:     *     Scan
1300:     *         Delete In crGrade
1301:     *     EndScan
1302:     *     ThisForm.Release
1303:     * O descarte INCONDICIONAL de todas as linhas mora em
1304:     * THIS.this_oBusinessObject.CancelarSelecao() (fonte unica, Fase 2). O
1305:     * Release acontece sempre - cancelar nunca falha de um jeito que impeca
1306:     * sair do dialogo. PUBLIC (alvo de BINDEVENT, regra #3).
1307:     *--------------------------------------------------------------------------
1308:     PROCEDURE BtnCancelarClick()
1309:         LOCAL loc_oErro
1310: 
1311:         TRY
1312:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1313:                 THIS.this_oBusinessObject.CancelarSelecao()
1314:             ENDIF
1315: 

*-- Linhas 1325 a 1343:
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * ImgFigJpgClick - Click de SIGOPCPO.ImgFigJpg legado:
1328:     *     Select crGrade
1329:     *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs)
1330:     *         lcFoto = Strconv(Strtran(...), 14)
1331:     *         =StrToFile(lcFoto, lcArq)
1332:     *     EndIf
1333:     *     If File(lcArq)
1334:     *         Do Form SigOpZom With lcArq, [Produto : ]+Mats+[ - ]+DPros, ;
1335:     *                  [Ref. Fornecedor : ]+Reffs
1336:     *     EndIf
1337:     * A decodificacao mora em THIS.this_oBusinessObject.DecodificarImagem()
1338:     * (fonte unica, Fase 2); a abertura do zoom em
1339:     * THIS.AbrirFormZoomImagem() - SigOpZom esta FORA do escopo desta task
1340:     * (ProximasMigracoes\SigOpZom.SCX ainda nao migrado), mesmo padrao do
1341:     * FormSigMvSbn.ImgFigJpgDblClick: CREATEOBJECT guardado, ausencia
1342:     * AVISADA via MsgAviso em vez de estourar "Class definition ... is not
1343:     * found". Quando SigOpZom for migrado, esta chamada passa a funcionar

*-- Linhas 1441 a 1459:
1441:     *
1442:     * NAO re-consulta o banco: a carga eh de CarregarDados() (-> BO.
1443:     * CarregarComposicao()), que roda ANTES das grades existirem porque
1444:     * Column.ControlSource exige o cursor ja criado (regra #41). Este metodo
1445:     * eh o passo seguinte - re-vincular e repintar - e por isso pode ser
1446:     * chamado quantas vezes for preciso sem custo de SQL.
1447:     *
1448:     * O re-vinculo (VincularGradeItens) eh condicional: so refaz quando a
1449:     * grade NAO esta mais apontando para o cursor certo (RecordSource vazio
1450:     * ou trocado), porque re-atribuir RecordSource reseta Width/Caption das
1451:     * colunas e destroi o CurrentControl do CheckBox (Problema 48/regra #18).
1452:     *
1453:     * PUBLIC: TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
1454:     * classe, e PEMSTATUS nao distingue escopo - metodo PROTECTED entraria no
1455:     * branch do teste e estouraria "Property CARREGARLISTA is not found"
1456:     * (regra #3).
1457:     *--------------------------------------------------------------------------
1458:     FUNCTION CarregarLista()
1459:         LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, loc_oErro

*-- Linhas 1482 a 1500:
1482:                     *-- "Go Top In crRodape" do legado: a linha unica de
1483:                     *-- totais sempre repousa no topo.
1484:                     IF USED(loc_cCursorRodape)
1485:                         SELECT (loc_cCursorRodape)
1486:                         GO TOP
1487:                     ENDIF
1488: 
1489:                     *-- Totais + rodape + botao Confirmar + imagem pelo funil
1490:                     *-- (fonte unica). 0 = GO TOP em cursor_4c_Grade, que eh
1491:                     *-- o que o legado faz neste ponto.
1492:                     THIS.AtualizarRodape(0)
1493: 
1494:                     *-- "ThisForm.grdItens.Column1.SetFocus" do legado: o
1495:                     *-- dialogo abre com o foco na coluna de marcacao, para o
1496:                     *-- usuario poder marcar com Espaco/Enter sem usar o mouse
1497:                     *-- (os handlers de teclado do CheckBox dependem disso).
1498:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1499:                         IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled ;
1500:                            AND RECCOUNT(loc_cCursorGrade) > 0

*-- Linhas 1580 a 1607:
1580: 
1581:                 *-- 3. Celulas da grade de totais.
1582:                 IF USED(loc_cCursorRodape)
1583:                     SELECT (loc_cCursorRodape)
1584:                     IF !EOF()
1585:                         THIS.this_oBusinessObject.this_cDescrsRodape = TratarNulo(Descrs, "")
1586:                         THIS.this_oBusinessObject.this_cUsuarsRodape = TratarNulo(Usuars, "")
1587:                         THIS.this_oBusinessObject.this_nTotasRodape  = TratarNulo(Totas, 0)
1588:                     ENDIF
1589:                 ENDIF
1590: 
1591:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1592:                     SELECT (loc_cAliasAnterior)
1593:                 ENDIF
1594: 
1595:                 loc_lSucesso = .T.
1596:             ENDIF
1597: 
1598:         CATCH TO loc_oErro
1599:             MsgErro(loc_oErro.Message + CHR(13) + ;
1600:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1601:                     "Procedure: " + loc_oErro.Procedure, ;
1602:                     "Erro ao Transferir Dados da Tela")
1603:         ENDTRY
1604: 
1605:         RETURN loc_lSucesso
1606:     ENDFUNC
1607: 

*-- Linhas 1656 a 1674:
1656:                 *-- sem alias ali estoura "No table is open in the current
1657:                 *-- work area.".
1658:                 IF USED(loc_cCursorRodape)
1659:                     SELECT (loc_cCursorRodape)
1660:                     GO TOP
1661:                     IF !EOF()
1662:                         REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
1663:                             IN (loc_cCursorRodape)
1664:                     ENDIF
1665:                 ENDIF
1666: 
1667:                 IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
1668:                     THIS.grd_4c_Rodape.Column3.Refresh()
1669:                     THIS.grd_4c_Rodape.Refresh()
1670:                 ENDIF
1671: 
1672:                 *-- Botao OK: habilitado so com quantidade marcada > 0.
1673:                 IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1674:                     THIS.cmg_4c_Botoes.Buttons(1).Enabled = ;

*-- Linhas 1716 a 1734:
1716:                 ENDIF
1717: 
1718:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1719:                     SELECT (loc_cAliasAnterior)
1720:                 ENDIF
1721: 
1722:                 loc_lSucesso = .T.
1723:             ENDIF
1724: 
1725:         CATCH TO loc_oErro
1726:             MsgErro(loc_oErro.Message + CHR(13) + ;
1727:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1728:                     "Procedure: " + loc_oErro.Procedure, ;
1729:                     "Erro ao Exibir Dados na Tela")
1730:         ENDTRY
1731: 
1732:         RETURN loc_lSucesso
1733:     ENDFUNC
1734: 


### BO (C:\4c\projeto\app\classes\SigOpCpoBO.prg):
*==============================================================================
* SigOpCpoBO.prg - Business Object para Composicao de Produtos (SIGOPCPO)
*
* Form OPERACIONAL de SELECAO: eh um dialogo modal (WindowType = 1,
* TitleBar = 0, ControlBox = .F., Movable = .F.) aberto por um form PAI
* (o Init legado recebe LParameters pFrm, pKey e faz .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Ele lista a composicao (componentes) do produto
* informado em pKey, deixa o usuario MARCAR quais componentes deseja e, no
* botao OK, mantem na grade apenas as linhas marcadas; no Cancelar, descarta
* todas. Quem persiste eh o form PAI - esta tela NAO grava em tabela alguma.
*
* Tabela principal: SigPrCpo (chave primaria: cidchaves char(20) -
* constraint sigprcpo_cidchaves, ver docs/schema.sql)
* Tabelas auxiliares: SigCdPro (descricao / preco / moeda / referencia /
* imagem do componente e do produto-pai) e SigCdTpc (tipos de composicao com
* Custos = 2, que alimentam o cmbTipos).
*
* Legado (SigOpCpo.SCX):
*   Load           -> fConfigGeral() + Create Cursor crRodape
*                     (Descrs c(100), Usuars c(10), Totas n(12,2))
*   Init           -> guarda pFrm/pKey, lpKey = Padr(pKey, 14),
*                     CursorQuery([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros])
*                     para validar o produto e montar o Caption
*                     (Caption + " - " + lpKey + " - " + LocalPro.DPros),
*                     depois MontaGrades + SelecionaDados
*   SelecionaDados -> Zap crGrade/crRodape; SELECT da composicao (SigPrCpo a
*                     + SigCdPro b) para LocalCompo; Insert Into crGrade;
*                     SELECT Tipos From SigCdTpc Where Custos = 2 para
*                     popular o cmbTipos; Set Filter To Tipos = cmbTipos.Value
*   AtuaTotas      -> Select Sum(Qtds), Sum(Totas) From crGrade Where Marcas
*                     -> grdRodape.Column3 + habilita/desabilita o btnConfirmar
*
* Mapeamento SELECT legado -> coluna real -> propriedade (tipos conferidos
* em docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
*   a.CPros              -> SigPrCpo.cpros     char(14)      -> this_cCpros
*   a.Mats               -> SigPrCpo.mats      char(14)      -> this_cMats
*   b.DPros              -> SigCdPro.dpros     char(65)      -> this_cDpros
*   a.Qtds               -> SigPrCpo.qtds      numeric(8,3)  -> this_nQtds
*   a.UniCompos          -> SigPrCpo.unicompos char(3)       -> this_cUnicompos
*   b.PVens as PCompos   -> SigCdPro.pvens     numeric(11,5) -> this_nPcompos
*   b.Moevs as Moeds     -> SigCdPro.moevs     char(3)       -> this_cMoeds
*   (a.Qtds * b.PVens)   -> calculado          numeric(11,3) -> this_nTotas
*   a.Etiqs              -> SigPrCpo.etiqs     char(1)       -> this_cEtiqs
*   b.Reffs              -> SigCdPro.reffs     char(40)      -> this_cReffs
*   b.FigJpgs            -> SigCdPro.figjpgs   text NULL     -> this_cFigjpgs
*   a.Tipos              -> SigPrCpo.tipos     char(20)      -> this_cTipos
*   (sem controle)       -> SigPrCpo.cidchaves char(20) PK   -> this_cCidchaves
*
* ATENCAO - as duas colunas "gemeas" que a tela NAO le:
* SigPrCpo tem pcompos numeric(11,3) e moeds char(3) PROPRIAS, mas o SELECT
* legado NAO as usa: ele toma b.PVens as PCompos e b.Moevs as Moeds, isto eh,
* o preco de venda e a moeda de venda do COMPONENTE em SigCdPro. Trocar a
* origem mudaria o valor exibido e o total - por isso as propriedades
* this_nPcompos / this_cMoeds documentam de onde vem (regra #17: a formula e
* a origem do legado se transcrevem, nao se reescrevem).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCpoBO AS BusinessBase

    *==========================================================================
    * Chave do dialogo - produto cuja composicao esta sendo exibida
    *==========================================================================
    *-- Cpros: char(14) - codigo do produto-PAI. Equivale ao .lpKey do legado
    *-- (.lpKey = Padr(Iif(Type([pKey])=[C], pKey, []), 14)) e eh o filtro da
    *-- consulta da composicao (Where a.CPros = '<lpKey>'). O PADR ate 14 eh
    *-- obrigatorio: a coluna eh char(14) e a comparacao com o valor gravado
    *-- depende do padding (regra #42).
    this_cCpros        = ""   && char(14) NOT NULL - produto-pai (lpKey)

    *-- Descricao do produto-pai, lida de SigCdPro.dpros pelo CursorQuery
    *-- ([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros]) do Init legado. Entra no
    *-- Caption do form e nos dois labels da faixa do cabecalho
    *-- (lblSombra/lblTitulo recebem ThisForm.Caption).
    this_cDprosProduto = ""   && char(65) NOT NULL - descricao do produto-pai

    *-- Cidchaves: char(20) - PRIMARY KEY de SigPrCpo (constraint
    *-- sigprcpo_cidchaves). A tela nao grava, mas a chave eh declarada para o
    *-- ObterChavePrimaria() da auditoria e para que a leitura de uma linha
    *-- possa identificar o registro de origem sem ambiguidade.
    this_cCidchaves    = ""   && char(20) NOT NULL - chave primaria SigPrCpo

    *==========================================================================
    * Linha corrente da composicao (colunas da grade grdItens)
    *==========================================================================
    *-- Marcas: coluna LOGICA que existe SO no cursor da grade (nao ha coluna
    *-- equivalente em SigPrCpo). O legado a inicializa com
    *-- (LocalCompo.Etiqs = [S]), isto eh, o componente nasce marcado quando
    *-- Etiqs = "S", e a alterna com Replace Marcas With Not Marcas nos
    *-- handlers do CheckBox da Column1. Propriedade LOGICA porque a origem eh
    *-- uma comparacao, nao uma coluna numeric(1,0) nem bit.
    this_lMarcas       = .F.  && logico (so cursor) - componente selecionado

    *-- Mats: char(14) - codigo do componente (coluna "Item" da grade). No
    *-- SELECT ele tambem eh o lado do join com SigCdPro (a.Mats = b.CPros).
    this_cMats         = ""   && char(14) NOT NULL - codigo do componente

    *-- Dpros: char(65) - descricao do componente, vinda de SigCdPro.dpros
    *-- (coluna "Descricao", a mais larga da grade - Column3.Width = 394).
    this_cDpros        = ""   && char(65) NOT NULL - descricao do componente

    *-- Qtds: numeric(8,3) - quantidade do componente na composicao. Exibida
    *-- com InputMask [99999.999] na Column4 e somada no total de quantidade
    *-- que habilita o botao OK.
    this_nQtds         = 0    && numeric(8,3) NOT NULL - quantidade

    *-- UniCompos: char(3) - unidade da composicao (coluna "Uni",
    *-- Column5.Width = 31).
    this_cUnicompos    = ""   && char(3) NOT NULL - unidade do componente

    *-- Pcompos: o SELECT legado toma b.PVens as PCompos, ou seja o PRECO DE
    *-- VENDA do componente em SigCdPro - numeric(11,5) -, e NAO a coluna
    *-- SigPrCpo.pcompos (numeric(11,3)), que existe mas nao eh lida. Exibido
    *-- com InputMask [99999999.999] na Column6 ("Valor Unitario").
    this_nPcompos      = 0    && numeric(11,5) NOT NULL - b.PVens as PCompos

    *-- Moeds: o SELECT legado toma b.Moevs as Moeds, isto eh a MOEDA DE
    *-- VENDA do componente em SigCdPro - char(3) -, e NAO a coluna
    *-- SigPrCpo.moeds, que existe mas nao eh lida. Coluna "Moe" da grade
    *-- (Column7.Width = 31).
    this_cMoeds        = ""   && char(3) NOT NULL - b.Moevs as Moeds

    *-- Totas: valor total da linha. Formula do legado, transcrita sem
    *-- reescrita (regra #17): (a.Qtds * b.PVens) - quantidade da composicao
    *-- multiplicada pelo preco de venda do componente. SigPrCpo tem uma
    *-- coluna totas numeric(11,3), mas o SELECT NAO a le: o valor eh sempre
    *-- recalculado. Exibido com InputMask [99999999.99] na Column8, que eh a
    *-- unica coluna em negrito e com BackColor 245,251,136.
    this_nTotas        = 0    && calculado numeric(11,3) - Qtds * PVens

    *-- Etiqs: char(1) - flag de etiqueta do componente. O unico uso na tela
    *-- eh definir o estado inicial de Marcas (Marcas = (Etiqs = "S")); nao
    *-- tem coluna na grade.
    this_cEtiqs        = ""   && char(1) NOT NULL - "S" marca o componente

    *-- Reffs: char(40) - referencia do fornecedor do componente. Nao tem
    *-- coluna na grade: eh usada no titulo da tela de zoom da imagem
    *-- (Do Form SigOpZom With ... , [Ref. Fornecedor : ] + crGrade.Reffs).
    this_cReffs        = ""   && char(40) NOT NULL - ref. do fornecedor

    *-- Figjpgs: coluna text NULL de SigCdPro com a imagem do componente em
    *-- base64. O legado remove os prefixos data:image/...;base64, e decodifica
    *-- com Strconv(..., 14) UMA unica vez, gravando o resultado em arquivo
    *-- temporario antes de atribuir ao .Picture do Image. Propriedade de
    *-- CARACTERE porque guarda o base64 cru; por ser NULL no banco, toda
    *-- leitura passa por Nvl(..., []) como no Insert Into legado.
    this_cFigjpgs      = ""   && text NULL - imagem do componente em base64

    *-- Tipos: char(20) - tipo de composicao da linha. Eh a coluna pela qual o
    *-- cmbTipos FILTRA a grade (Set Filter To Tipos = cmbTipos.Value In
    *-- crGrade), executado tanto no fim do SelecionaDados quanto no Valid do
    *-- combo.
    this_cTipos        = ""   && char(20) NOT NULL - tipo de composicao

    *==========================================================================
    * Linha do rodape (grade grdRodape) - cursor criado no Load legado com
    * Create Cursor crRodape (Descrs c(100), Usuars c(10), Totas n(12,2)).
    * O legado insere UMA linha (Insert Into crRodape (Totas) Values (0)) e so
    * atualiza Totas; Descrs e Usuars ficam em branco, mas existem porque as
    * tres colunas estao ligadas as tres Columns do grdRodape
    * (Column1 -> Descrs, Column2 -> Usuars, Column3 -> Totas).
    *==========================================================================
    this_cDescrsRodape = ""   && c(100) cursor local - Column1 do grdRodape
    this_cUsuarsRodape = ""   && c(10)  cursor local - Column2 do grdRodape
    this_nTotasRodape  = 0    && n(12,2) cursor local - Column3 (total geral)

    *==========================================================================
    * Totais do AtuaTotas
    *
    * O legado agrupa SO as linhas marcadas:
    *   Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas
    *     From crGrade Where Marcas Group By 1 Into Cursor LocalTot
    * O "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total, e nao se troca por soma de tudo.
    * O botao OK fica habilitado apenas quando LocalTot.Qtds > 0.
    *==========================================================================
    this_nTotalQtds    = 0    && soma de Qtds das linhas com Marcas = .T.
    this_nTotalTotas   = 0    && soma de Totas das linhas com Marcas = .T.

    *-- Espelha o Enabled do btnConfirmar: (LocalTot.Qtds > 0) no legado.
    *-- Fonte UNICA do estado do botao - o form apenas reflete esta
    *-- propriedade, para nao existirem dois criterios divergentes.
    this_lPermiteConfirmar = .F.

    *==========================================================================
    * Filtro de tipo (cmbTipos) - ComboBox Style = 2 (dropdown list),
    * FontName "Courier New", SEM ControlSource: ele apenas filtra a grade.
    *==========================================================================
    *-- Valor corrente do combo, usado no Set Filter To Tipos = <valor>.
    this_cTipoSelecionado = ""

    *-- Equivale ao llBrc do SelecionaDados legado: fica .T. quando ALGUMA
    *-- linha da composicao tem Tipos vazio (If Not llBrc And
    *-- Empty(LocalCompo.Tipos)). Nesse caso o legado acrescenta um item
    *-- Space(20) no TOPO do combo e o seleciona por padrao; sem nenhuma linha
    *-- sem tipo, o default passa a ser o PRIMEIRO tipo retornado por SigCdTpc
    *-- (ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)).
    this_lTemTipoEmBranco = .F.

    *-- Item em branco do combo: Space(20), do tamanho exato de
    *-- SigPrCpo.tipos char(20), para o Set Filter To comparar certo.
    this_cTipoEmBranco    = ""

    *-- Filtro fixo da consulta de tipos: Where Custos = 2 em SigCdTpc
    *-- (coluna numeric(1,0)). Valor TRANSCRITO do legado - mudar aqui muda
    *-- quais tipos o usuario pode escolher.
    this_nCustosFiltro    = 2

    *-- Quantidade de tipos carregados de SigCdTpc (sem contar o item em
    *-- branco), para o form saber se o combo tem conteudo.
    this_nQtdeTipos       = 0

    *==========================================================================
    * Tabelas envolvidas (nomes EXATOS do banco - PILAR 2)
    *==========================================================================
    this_cTabelaComposicao = "SigPrCpo"   && composicao do produto (principal)
    this_cTabelaProduto    = "SigCdPro"   && produto: descricao/preco/imagem
    this_cTabelaTipoComp   = "SigCdTpc"   && tipos de composicao do cmbTipos

    *==========================================================================
    * Aliases dos cursores (PILAR 3 - nomes novos, prefixo cursor_4c_)
    *
    * Correspondencia com o legado:
    *   crGrade    -> this_cCursorGrade     (grade grdItens; no legado o cursor
    *                                        pertence ao form PAI e aqui eh
    *                                        apenas Zap'ado - na arquitetura
    *                                        nova ele eh criado e populado por
    *                                        este BO, e o form pai o le depois
    *                                        que o dialogo fecha)
    *   crRodape   -> this_cCursorRodape    (grade grdRodape, 1 linha)
    *   LocalCompo -> this_cCursorTempComp  (cursor TEMPORARIO do SQLEXEC da
    *                                        composicao; o SQLEXEC nunca vai
    *                                        para o alias ligado ao Grid, que
    *                                        perderia o ColumnCount)
    *   LocalTpCom -> this_cCursorTipos     (tipos de SigCdTpc)
    *   LocalPro   -> this_cCursorProduto   (cabecalho: descricao do produto)
    *   LocalTot   -> this_cCursorTotais    (totais do AtuaTotas)
    *==========================================================================
    this_cCursorGrade     = "cursor_4c_Grade"
    this_cCursorRodape    = "cursor_4c_Rodape"
    this_cCursorTempComp  = "cursor_4c_TempComp"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorTempTipos = "cursor_4c_TempTipos"
    this_cCursorProduto   = "cursor_4c_Produto"
    this_cCursorTotais    = "cursor_4c_Totais"

    *==========================================================================
    * Decodificacao da imagem (SigCdPro.figjpgs)
    *
    * O legado retira TRES prefixos data-URI antes do Strconv(..., 14):
    *   Strtran(Strtran(Strtran(FigJpgs,[data:image/png;base64,],[]),
    *                                  [data:image/jpeg;base64,],[]),
    *                                  [data:image/jpg;base64,],[])
    * Os prefixos ficam em propriedades para que exista UM unico lugar com a
    * lista, e o Strconv seja aplicado UMA SO VEZ sobre o resultado - decodar
    * duas vezes devolve lixo e a imagem nao abre.
    *==========================================================================
    this_cPrefixoPng  = "data:image/png;base64,"
    this_cPrefixoJpeg = "data:image/jpeg;base64,"
    this_cPrefixoJpg  = "data:image/jpg;base64,"

    *-- Caminho do arquivo .jpg temporario gerado por StrToFile para alimentar
    *-- o .Picture do Image (no legado: Sys(2023) + "\" + Sys(2015) + ".jpg").
    this_cArquivoImagem = ""

    *==========================================================================
    * Estado do dialogo
    *==========================================================================
    *-- .T. quando o usuario fechou pelo OK (btnConfirmar) e portanto as linhas
    *-- MARCADAS devem ser devolvidas ao form pai; .F. no Cancelar (btnSair),
    *-- que descarta todas as linhas.
    this_lConfirmado      = .F.

    *-- Quantidade de componentes carregados na grade (Reccount do cursor da
    *-- grade), usada pelo legado em If (Reccount([crGrade]) > 0) antes de
    *-- calcular os totais iniciais.
    this_nQtdeComponentes = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal (SigPrCpo) e a chave primaria REAL (cidchaves
    * - constraint sigprcpo_cidchaves, docs/schema.sql), fixa os valores
    * constantes transcritos do legado e zera o estado de edicao herdado de
    * BusinessBase.
    *
    * NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): esta tela eh
    * um dialogo de SELECAO e todo Insert Into / Replace / Delete do legado
    * tem por destino CURSOR LOCAL (crGrade e crRodape) - o acesso remoto eh
    * 100% Select. O comportamento padrao herdado de BusinessBase (recusar a
    * gravacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
    * inventar um INSERT aqui violaria a regra #22 (a lista de colunas vem do
    * schema, nunca de adivinhacao).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigPrCpo")

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cidchaves"

            *-- Nomes das tabelas auxiliares (PILAR 2 - nomes exatos).
            THIS.this_cTabelaComposicao = "SigPrCpo"
            THIS.this_cTabelaProduto    = "SigCdPro"
            THIS.this_cTabelaTipoComp   = "SigCdTpc"

            *-- Item em branco do cmbTipos: Space(20) = largura de
            *-- SigPrCpo.tipos char(20), igual ao AddItem(Space(20)) legado.
            THIS.this_cTipoEmBranco = SPACE(20)

            *-- Filtro fixo da consulta de tipos (SigCdTpc.custos = 2).
            THIS.this_nCustosFiltro = 2

            *-- Prefixos data-URI removidos antes do Strconv(..., 14).
            THIS.this_cPrefixoPng  = "data:image/png;base64,"
            THIS.this_cPrefixoJpeg = "data:image/jpeg;base64,"
            THIS.this_cPrefixoJpg  = "data:image/jpg;base64,"

            *-- Estado inicial do dialogo: nada carregado, nada marcado, OK
            *-- desabilitado (btnConfirmar.Enabled = .f. no SelecionaDados).
            THIS.this_cCpros            = ""
            THIS.this_cDprosProduto     = ""
            THIS.this_cCidchaves        = ""
            THIS.this_lMarcas           = .F.
            THIS.this_cMats             = ""
            THIS.this_cDpros            = ""
            THIS.this_nQtds             = 0
            THIS.this_cUnicompos        = ""
            THIS.this_nPcompos          = 0
            THIS.this_cMoeds            = ""
            THIS.this_nTotas            = 0
            THIS.this_cEtiqs            = ""
            THIS.this_cReffs            = ""
            THIS.this_cFigjpgs          = ""
            THIS.this_cTipos            = ""
            THIS.this_cDescrsRodape     = ""
            THIS.this_cUsuarsRodape     = ""
            THIS.this_nTotasRodape      = 0
            THIS.this_nTotalQtds        = 0
            THIS.this_nTotalTotas       = 0
            THIS.this_lPermiteConfirmar = .F.
            THIS.this_cTipoSelecionado  = ""
            THIS.this_lTemTipoEmBranco  = .F.
            THIS.this_nQtdeTipos        = 0
            THIS.this_cArquivoImagem    = ""
            THIS.this_lConfirmado       = .F.
            THIS.this_nQtdeComponentes  = 0

            *-- Estado de edicao herdado de BusinessBase: dialogo de selecao
            *-- nunca entra em edicao de registro.
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_cMensagemErro   = ""
            THIS.this_lErroExibido    = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SigOpCpoBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Devolve a chave primaria da linha corrente
    * (SigPrCpo.cidchaves char(20)), usada pela auditoria de BusinessBase.
    *
    * PADR ate 20 porque a coluna eh char(20) e o valor guardado na property
    * pode vir com ALLTRIM na leitura do cursor (regra #42).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN PADR(ALLTRIM(THIS.this_cCidchaves), 20)
    ENDFUNC

    *==========================================================================
    * Fase 2 - Metodos de carga (equivalentes ao CRUD desta tela)
    *
    * Este dialogo eh SOMENTE-LEITURA no banco: o Init legado (Load +
    * SelecionaDados) faz so Select; o que o usuario marca so eh persistido
    * quando o form PAI grava a composicao, fora deste BO. Por isso Inserir(),
    * Atualizar() e ExecutarExclusao() NAO sao sobrescritos aqui - o
    * comportamento herdado de BusinessBase (recusar a operacao) ja eh o
    * adequado para este dialogo, e RegistrarAuditoria() so eh chamado por
    * esses dois metodos (regra: Audit System). Os metodos abaixo substituem,
    * um a um, a logica do Load/Init/SelecionaDados/AtuaTotas do legado:
    *
    *   Load + Create Cursor crRodape   -> THIS.Init() (Fase 1)
    *   CursorQuery(SigCdPro,...)       -> THIS.CarregarProduto()
    *   SelecionaDados (Insert crGrade) -> THIS.CarregarComposicao()
    *   SelecionaDados (combo Tipos)    -> THIS.CarregarTipos() (PROTECTED,
    *                                      chamado por CarregarComposicao)
    *   Set Filter To Tipos = ...       -> THIS.AplicarFiltroTipo()
    *   AtuaTotas                       -> THIS.AtualizarTotais()
    *   btnConfirmar.Click              -> THIS.ConfirmarSelecao()
    *   btnSair.Click                   -> THIS.CancelarSelecao()
    *   ImgFigJpg.Click (Strconv+jpg)   -> THIS.DecodificarImagem()
    *   leitura da linha da grade       -> THIS.CarregarDoCursor()
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de cursor_4c_Grade (ou outro
    * alias informado) para as properties this_* da linha. Usado pelo form
    * sempre que a linha corrente da grade mudar (AfterRowColChange) ou antes
    * de abrir o zoom da imagem (ImgFigJpgClick).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_lMarcas    = TratarNulo(Marcas, .F.)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
            THIS.this_cMats      = TratarNulo(Mats, "")
            THIS.this_cDpros     = TratarNulo(Dpros, "")
            THIS.this_nQtds      = TratarNulo(Qtds, 0)
            THIS.this_cUnicompos = TratarNulo(UniCompos, "")
            THIS.this_nPcompos   = TratarNulo(PCompos, 0)
            THIS.this_cMoeds     = TratarNulo(Moeds, "")
            THIS.this_nTotas     = TratarNulo(Totas, 0)
            THIS.this_cEtiqs     = TratarNulo(Etiqs, "")
            THIS.this_cReffs     = TratarNulo(Reffs, "")
            THIS.this_cFigjpgs   = TratarNulo(FigJpgs, "")
            THIS.this_cTipos     = TratarNulo(Tipos, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarProduto - Valida o produto-pai (par_cCpros, equivalente ao
    * .lpKey legado) e le a descricao em SigCdPro.dpros para compor o Caption
    * do form ("... - <Cpros> - <Dpros>"), igual ao CursorQuery([SigCdPro],
    * [LocalPro],[Cpros],lpKey,[DPros]) do Init legado.
    *
    * Retorna .F. quando o produto nao existe (equivalente ao
    * "MessageBox('O Produto Informado Nao Existe!!!',...) / .Release" do
    * legado) - o form eh quem decide fechar, exibindo this_cMensagemErro.
    *==========================================================================
    FUNCTION CarregarProduto(par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_cCpros = PADR(ALLTRIM(TratarNulo(par_cCpros, "")), 14)

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                       "WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorProduto) ;
                    AND RECCOUNT(THIS.this_cCursorProduto) > 0

                SELECT (THIS.this_cCursorProduto)
                GO TOP
                THIS.this_cDprosProduto = TratarNulo(Dpros, "")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "O Produto Informado N" + CHR(227) + ;
                    "o Existe!!!"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Validar Produto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarComposicao - Recria cursor_4c_Grade (equivalente a crGrade) com
    * a composicao do produto em THIS.this_cCpros, no mesmo SELECT do legado
    * (SigPrCpo a INNER JOIN SigCdPro b, Order By a.Mats), e so depois monta o
    * filtro de tipos (THIS.CarregarTipos + THIS.AplicarFiltroTipo), igual ao
    * SelecionaDados legado (Zap crGrade/crRodape -> Select -> Insert Into
    * crGrade -> Select Tipos -> Set Filter To).
    *
    * O SQLEXEC NUNCA vai direto para cursor_4c_Grade (regra do SQLEXEC zerar
    * ColumnCount do Grid): a consulta roda em cursor_4c_TempComp e cada linha
    * eh copiada por APPEND BLANK + REPLACE para o cursor local que o Grid usa.
    *==========================================================================
    FUNCTION CarregarComposicao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, ;
              loc_lTemBranco, loc_cCidchaves, loc_cMats, loc_cDpros, ;
              loc_nQtds, loc_cUnicompos, loc_nPcompos, loc_cMoeds, ;
              loc_nTotas, loc_cEtiqs, loc_cReffs, loc_cFigjpgs, loc_cTipos

        loc_lResultado = .F.
        loc_lTemBranco = .F.

        TRY
            IF USED(THIS.this_cCursorTempComp)
                USE IN (THIS.this_cCursorTempComp)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.mats, b.dpros, a.qtds, " + ;
                       "a.unicompos, b.pvens AS pcompos, b.moevs AS moeds, " + ;
                       "(a.qtds * b.pvens) AS totas, a.etiqs, b.reffs, " + ;
                       "b.figjpgs, a.tipos " + ;
                       "FROM SigPrCpo a INNER JOIN SigCdPro b " + ;
                       "ON a.mats = b.cpros " + ;
                       "WHERE a.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ;
                       " ORDER BY a.mats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempComp))

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao consultar a composi" + ;
                    CHR(231) + CHR(227) + "o do produto." + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorGrade)
                    USE IN (THIS.this_cCursorGrade)
                ENDIF

                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorGrade) ;
                    (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                     Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                     Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                     FigJpgs M, Tipos C(20))
                SET NULL OFF

                IF USED(THIS.this_cCursorTempComp)
                    SELECT (THIS.this_cCursorTempComp)
                    SCAN
                        loc_cCidchaves = TratarNulo(cidchaves, "")
                        loc_cMats      = TratarNulo(mats, "")
                        loc_cDpros     = TratarNulo(dpros, "")
                        loc_nQtds      = TratarNulo(qtds, 0)
                        loc_cUnicompos = TratarNulo(unicompos, "")
                        loc_nPcompos   = TratarNulo(pcompos, 0)
                        loc_cMoeds     = TratarNulo(moeds, "")
                        loc_nTotas     = TratarNulo(totas, 0)
                        loc_cEtiqs     = TratarNulo(etiqs, "")
                        loc_cReffs     = TratarNulo(reffs, "")
                        loc_cFigjpgs   = TratarNulo(figjpgs, "")
                        loc_cTipos     = TratarNulo(tipos, "")

                        IF EMPTY(loc_cTipos)
                            loc_lTemBranco = .T.
                        ENDIF

                        SELECT (THIS.this_cCursorGrade)
                        APPEND BLANK
                        REPLACE Marcas    WITH (loc_cEtiqs == "S"), ;
                                Cidchaves WITH loc_cCidchaves, ;
                                Mats      WITH loc_cMats, ;
                                Dpros     WITH loc_cDpros, ;
                                Qtds      WITH loc_nQtds, ;
                                UniCompos WITH loc_cUnicompos, ;
                                PCompos   WITH loc_nPcompos, ;
                                Moeds     WITH loc_cMoeds, ;
                                Totas     WITH loc_nTotas, ;
                                Etiqs     WITH loc_cEtiqs, ;
                                Reffs     WITH loc_cReffs, ;
                                FigJpgs   WITH loc_cFigjpgs, ;
                                Tipos     WITH loc_cTipos

                        SELECT (THIS.this_cCursorTempComp)
                    ENDSCAN

                    USE IN (THIS.this_cCursorTempComp)
                ENDIF

                THIS.this_lTemTipoEmBranco = loc_lTemBranco
                THIS.this_nQtdeComponentes = RECCOUNT(THIS.this_cCursorGrade)

                SELECT (THIS.this_cCursorGrade)
                GO TOP

                THIS.CarregarTipos()
                THIS.AplicarFiltroTipo(THIS.this_cTipoSelecionado)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarTipos (PROTECTED) - Monta cursor_4c_Tipos a partir de SigCdTpc
    * Where Custos = 2 (this_nCustosFiltro), igual ao "Select Tipos From
    * SigCdTpc Where Custos = 2" do SelecionaDados legado. Quando
    * this_lTemTipoEmBranco (setado por CarregarComposicao) acrescenta o item
    * em branco Space(20) no TOPO, igual ao AddItem(Space(20)) legado, e
    * define this_cTipoSelecionado com o default (o item em branco, se
    * existir; senao o primeiro tipo retornado).
    *
    * PROTECTED porque so faz sentido chamado por CarregarComposicao - o form
    * nunca precisa chama-lo isoladamente, so ler cursor_4c_Tipos.
    *==========================================================================
    PROTECTED PROCEDURE CarregarTipos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, loc_cTipo
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorTempTipos)
                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            loc_cSQL = "SELECT tipos FROM SigCdTpc " + ;
                       "WHERE custos = " + ;
                       FormatarNumeroSQL(THIS.this_nCustosFiltro, 0) + ;
                       " ORDER BY tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempTipos))

            IF USED(THIS.this_cCursorTipos)
                USE IN (THIS.this_cCursorTipos)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorTipos) (Tipos C(20))

            IF THIS.this_lTemTipoEmBranco
                APPEND BLANK
                REPLACE Tipos WITH THIS.this_cTipoEmBranco
            ENDIF

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorTempTipos)
                SELECT (THIS.this_cCursorTempTipos)
                SCAN
                    loc_cTipo = TratarNulo(tipos, "")
                    SELECT (THIS.this_cCursorTipos)
                    APPEND BLANK
                    REPLACE Tipos WITH loc_cTipo
                    SELECT (THIS.this_cCursorTempTipos)
                ENDSCAN

                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            THIS.this_nQtdeTipos = RECCOUNT(THIS.this_cCursorTipos)

            SELECT (THIS.this_cCursorTipos)
            GO TOP

            THIS.this_cTipoSelecionado = IIF(RECCOUNT(THIS.this_cCursorTipos) > 0, ;
                TratarNulo(Tipos, THIS.this_cTipoEmBranco), ;
                THIS.this_cTipoEmBranco)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Tipos de Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarFiltroTipo - Filtra cursor_4c_Grade pelo tipo escolhido no
    * cmbTipos, igual ao "Select crGrade / Set Filter To Tipos =
    * ThisForm.cmbTipos.Value In crGrade / Go Top In crGrade" do Valid legado.
    * Comparacao com == (SET EXACT ON global) contra o valor JA padronizado
    * para 20 posicoes (this_cTipoSelecionado nunca leva ALLTRIM - regra da
    * comparacao com buffer padded).
    *
    * O VALOR ENTRA NA EXPRESSAO COMO LITERAL - NUNCA como THIS.<property>.
    * SET FILTER guarda a expressao como TEXTO e a REAVALIA a cada acesso a
    * registro, resolvendo o THIS contra o objeto que estiver ativo NAQUELE
    * momento - e nao contra este BO. Medido no VFP9 (automation\
    * MedirSetFilterThis.prg, 2026-10-30) com "SET FILTER TO Tipos ==
    * THIS.this_cTipoSelecionado", que o VFP armazena como
    * [TIPOS==This.THIS_CTIPOSELECIONADO]:
    *
    *   GO TOP de DENTRO deste BO        -> OK (3 linhas visiveis)
    *   GO TOP de dentro de OUTRO objeto -> ERRO "Property
    *                                       THIS_CTIPOSELECIONADO is not found"
    *   GO TOP fora de objeto algum      -> o VFP DESCARTA O FILTRO em
    *                                       silencio: FILTER() volta VAZIO
    *   valor como LITERAL               -> OK nos TRES contextos
    *
    * A ultima linha do meio eh a perigosa: o Grid repinta FORA de qualquer
    * metodo, entao a grade passaria a exibir TODOS os tipos sem erro na
    * tela - divergencia muda do legado (PILAR 1), que filtra de verdade.
    * O delimitador do literal eh escolhido entre ", ' e [] para o valor
    * nunca quebrar a expressao.
    *==========================================================================
    FUNCTION AplicarFiltroTipo(par_cTipo)
        LOCAL loc_lResultado, loc_cValor, loc_cExpr
        loc_lResultado = .F.

        THIS.this_cTipoSelecionado = TratarNulo(par_cTipo, THIS.this_cTipoEmBranco)

        IF USED(THIS.this_cCursorGrade)
            loc_cValor = THIS.this_cTipoSelecionado

            DO CASE
            CASE !(CHR(34) $ loc_cValor)
                loc_cExpr = "Tipos == " + CHR(34) + loc_cValor + CHR(34)
            CASE !("'" $ loc_cValor)
                loc_cExpr = "Tipos == '" + loc_cValor + "'"
            OTHERWISE
                loc_cExpr = "Tipos == [" + STRTRAN(loc_cValor, "]", " ") + "]"
            ENDCASE

            SELECT (THIS.this_cCursorGrade)
            SET FILTER TO &loc_cExpr
            GO TOP
            loc_lResultado = .T.
        ENDIF

        THIS.AtualizarTotais()

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarTotais - Soma Qtds/Totas das linhas MARCADAS de cursor_4c_Grade
    * e habilita/desabilita a confirmacao, igual ao AtuaTotas legado:
    *   Select Sum(Qtds) as Qtds, Sum(Totas) as Totas From crGrade
    *     Where Marcas Group By 1 Into Cursor LocalTot
    *   btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total - nao se troca por soma de tudo.
    *
    * O TOTAL EH DA COMPOSICAO INTEIRA, NAO DO TIPO FILTRADO - e isso eh
    * FIEL ao legado, nao um descuido. Medido no VFP9 (automation\
    * MedirSelectComSetFilter.prg, 2026-10-30) com SET FILTER ativo em um
    * tipo que cobre 90 de 100: o acesso NAVEGACIONAL (COUNT, SCAN) respeita
    * o filtro e da 90, mas o SELECT SQL local o IGNORA e da 100 - inclusive
    * na forma exata do AtuaTotas legado (Select .. Where Marcas Group By 1).
    * Como o legado usa esse mesmo SELECT, ele tambem totaliza a composicao
    * inteira. NUNCA trocar este SELECT por SCAN/COUNT "para respeitar o
    * filtro": isso mudaria o numero que o usuario ve, em silencio.
    *==========================================================================
    FUNCTION AtualizarTotais()
        LOCAL loc_lResultado, loc_nSomaQtds, loc_nSomaTotas, loc_oErro
        loc_lResultado = .F.
        loc_nSomaQtds  = 0
        loc_nSomaTotas = 0

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT SUM(Qtds) AS SomaQtds, SUM(Totas) AS SomaTotas ;
                    FROM (THIS.this_cCursorGrade) WHERE Marcas = .T. ;
                    INTO CURSOR cursor_4c_SomaMarcadas

                IF USED("cursor_4c_SomaMarcadas")
                    loc_nSomaQtds  = TratarNulo(cursor_4c_SomaMarcadas.SomaQtds, 0)
                    loc_nSomaTotas = TratarNulo(cursor_4c_SomaMarcadas.SomaTotas, 0)
                    USE IN cursor_4c_SomaMarcadas
                ENDIF
            ENDIF

            THIS.this_nTotalQtds        = loc_nSomaQtds
            THIS.this_nTotalTotas       = loc_nSomaTotas
            THIS.this_lPermiteConfirmar = (loc_nSomaQtds > 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ConfirmarSelecao - Equivalente ao btnConfirmar.Click legado: descarta as
    * linhas NAO marcadas de cursor_4c_Grade (Select crGrade / Set Filter To /
    * Scan / If Not Marcas / Delete / EndScan) e marca o dialogo como
    * confirmado, para o form PAI ler apenas os componentes escolhidos.
    *==========================================================================
    FUNCTION ConfirmarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                SCAN
                    IF !Marcas
                        DELETE
                    ENDIF
                ENDSCAN
                GO TOP
            ENDIF

            THIS.this_lConfirmado = .T.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CancelarSelecao - Equivalente ao btnSair.Click legado: descarta TODAS as
    * linhas de cursor_4c_Grade (Select crGrade / Set Filter To / Scan /
    * Delete / EndScan), incondicional - nao so as desmarcadas - e marca o
    * dialogo como NAO confirmado.
    *==========================================================================
    FUNCTION CancelarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                ZAP
            ENDIF

            THIS.this_lConfirmado = .F.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * DecodificarImagem - Remove os tres prefixos data-URI e decodifica o
    * base64 de SigCdPro.figjpgs, gravando o resultado num .jpg temporario,
    * igual ao ImgFigJpg.Click legado:
    *   lcArq = Sys(2023) + [\] + Sys(2015) + [.jpg]
    *   Strconv(Strtran(Strtran(Strtran(FigJpgs,png,[]),jpeg,[]),jpg,[]), 14)
    *   StrToFile(lcFoto, lcArq)
    * O Strconv roda UMA SO VEZ sobre o resultado dos tres Strtran - decodar
    * duas vezes devolve lixo. this_cArquivoImagem fica "" quando nao ha
    * imagem, igual ao Image.Visible = .F. do legado quando Empty(FigJpgs).
    *==========================================================================
    FUNCTION DecodificarImagem(par_cFigjpgsBase64)
        LOCAL loc_lResultado, loc_cBase64, loc_cBinario, loc_cArquivo, loc_oErro
        loc_lResultado = .F.
        THIS.this_cArquivoImagem = ""

        TRY
            loc_cBase64 = TratarNulo(par_cFigjpgsBase64, "")

            IF !EMPTY(loc_cBase64)
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoPng,  "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpeg, "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpg,  "")

                loc_cBinario = STRCONV(loc_cBase64, 14)
                loc_cArquivo = ADDBS(SYS(2023)) + SYS(2015) + ".jpg"

                IF STRTOFILE(loc_cBinario, loc_cArquivo) > 0
                    THIS.this_cArquivoImagem = loc_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Decodificar Imagem")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

