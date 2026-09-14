# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 451: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 471: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPcp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1144 linhas total):

*-- Linhas 5 a 19:
5: * Fase 8/8 - COMPLETO: Todos os metodos implementados
6: *
7: * OBJETOS MIGRADOS (100%):
8: *   cnt_4c_Sombra + lbl_4c_Sombra + lbl_4c_Titulo  (cntSombra do legado)
9: *   grd_4c_Dados  (Grade 6 colunas - grade principal de selecao)
10: *   grd_4c_Itens  (GradeItem 4 colunas - itens da OP selecionada)
11: *   cmd_4c_Confirmar (Salva), cmd_4c_Cancelar (Sair)
12: *   txt_4c_Info (Text1 - identificacao da OP), lbl_4c_Cliente, txt_4c_Cliente
13: *   lbl_4c_Ordenacao, cbo_4c_Ordenacao (Cmb_Concilia - ordenacao da grade)
14: *   lbl_4c_TabDica (Label1 - dica TAB)
15: *   shp_4c_Shape4 + img_4c_FigJpg (foto do produto - Visible=.F. por padrao)
16: *
17: * NOTA: Nenhum campo de lookup (F4/F5) - original tem todos os campos
18: * somente-leitura ou preenchidos programaticamente via AfterRowColChange.
19: * Os uticos campos editaveis sao Column1 (Priors) da grade principal.

*-- Linhas 127 a 136:
127:                         THIS.TornarControlesVisiveis()
128: 
129:                         *-- Propagar titulo para labels do cabecalho
130:                         THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
131:                         THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
132: 
133:                         *-- Carregar dados nos grids e vincular eventos
134:                         THIS.CarregarGrades()
135:                         THIS.VincularEventos()
136: 

*-- Linhas 162 a 207:
162:         THIS.AddObject("cnt_4c_Sombra", "Container")
163:         WITH THIS.cnt_4c_Sombra
164:             .Visible     = .T.
165:             .Top         = 0
166:             .Left        = 0
167:             .Width       = THIS.Width
168:             .Height      = 80
169:             .BorderWidth = 0
170:             .BackColor   = RGB(100,100,100)
171:         ENDWITH
172:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
173:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
174:             .FontBold      = .T.
175:             .FontName      = "Tahoma"
176:             .FontSize      = 18
177:             .FontUnderline = .F.
178:             .WordWrap      = .T.
179:             .Alignment     = 0
180:             .AutoSize      = .F.
181:             .BackStyle     = 0
182:             .Caption       = THIS.Caption
183:             .Height        = 40
184:             .Left          = 10
185:             .Top           = 18
186:             .Width         = THIS.Width
187:             .ForeColor     = RGB(0,0,0)
188:             .Visible       = .T.
189:         ENDWITH
190:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
191:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
192:             .FontBold   = .T.
193:             .FontName   = "Tahoma"
194:             .FontSize   = 18
195:             .WordWrap   = .T.
196:             .Alignment  = 0
197:             .AutoSize   = .F.
198:             .BackStyle  = 0
199:             .Caption    = THIS.Caption
200:             .Height     = 46
201:             .Left       = 10
202:             .Top        = 17
203:             .Width      = THIS.Width
204:             .ForeColor  = RGB(255,255,255)
205:             .Visible    = .T.
206:         ENDWITH
207:     ENDPROC

*-- Linhas 257 a 266:
257:         *-- Grade principal (Grade do legado) - lado esquerdo, 6 colunas
258:         THIS.AddObject("grd_4c_Dados", "Grid")
259:         WITH THIS.grd_4c_Dados
260:             .Top           = 110
261:             .Left          = 0
262:             .Width         = 469
263:             .Height        = 398
264:             .ColumnCount   = 6
265:             .FontName      = "Tahoma"
266:             .FontSize      = 8

*-- Linhas 277 a 285:
277:                 .Movable           = .F.
278:                 .Resizable         = .F.
279:                 .ReadOnly          = .F.
280:                 .Header1.Caption   = "Prioridade"
281:                 .Header1.Alignment = 2
282:                 .Header1.ForeColor = RGB(0,0,0)
283:                 .Text1.InputMask   = "999999"
284:                 .Text1.BorderStyle = 0
285:                 .Text1.Margin      = 0

*-- Linhas 292 a 300:
292:                 .Movable           = .F.
293:                 .Resizable         = .F.
294:                 .ReadOnly          = .T.
295:                 .Header1.Caption   = "Emp"
296:                 .Header1.Alignment = 2
297:                 .Header1.ForeColor = RGB(0,0,0)
298:                 .Text1.BorderStyle = 0
299:                 .Text1.Margin      = 0
300:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 306 a 314:
306:                 .Movable           = .F.
307:                 .Resizable         = .F.
308:                 .ReadOnly          = .T.
309:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
310:                 .Header1.Alignment = 2
311:                 .Header1.ForeColor = RGB(0,0,0)
312:                 .Text1.BorderStyle = 0
313:                 .Text1.Margin      = 0
314:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 320 a 328:
320:                 .Movable           = .F.
321:                 .Resizable         = .F.
322:                 .ReadOnly          = .T.
323:                 .Header1.Caption   = "Codigo"
324:                 .Header1.Alignment = 2
325:                 .Header1.ForeColor = RGB(0,0,0)
326:                 .Text1.BorderStyle = 0
327:                 .Text1.Margin      = 0
328:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 334 a 342:
334:                 .Movable           = .F.
335:                 .Resizable         = .F.
336:                 .ReadOnly          = .T.
337:                 .Header1.Caption   = "Cliente"
338:                 .Header1.Alignment = 2
339:                 .Header1.ForeColor = RGB(0,0,0)
340:                 .Text1.BorderStyle = 0
341:                 .Text1.Margin      = 0
342:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 348 a 370:
348:                 .Movable           = .F.
349:                 .Resizable         = .F.
350:                 .ReadOnly          = .T.
351:                 .Header1.Caption   = "Prazo.Entrega"
352:                 .Header1.Alignment = 2
353:                 .Header1.ForeColor = RGB(0,0,0)
354:                 .Text1.BorderStyle = 0
355:                 .Text1.Margin      = 0
356:                 .Text1.ForeColor   = RGB(0,0,0)
357:                 .Text1.BackColor   = RGB(255,255,255)
358:             ENDWITH
359:         ENDWITH
360: 
361:         *-- Grade de itens (GradeItem do legado) - lado direito, 4 colunas
362:         THIS.AddObject("grd_4c_Itens", "Grid")
363:         WITH THIS.grd_4c_Itens
364:             .Top           = 131
365:             .Left          = 470
366:             .Width         = 329
367:             .Height        = 325
368:             .ColumnCount   = 4
369:             .FontName      = "Tahoma"
370:             .FontSize      = 8

*-- Linhas 381 a 389:
381:                 .Movable           = .F.
382:                 .Resizable         = .F.
383:                 .ReadOnly          = .T.
384:                 .Header1.Caption   = "Envelope"
385:                 .Header1.Alignment = 2
386:                 .Header1.ForeColor = RGB(0,0,0)
387:                 .Text1.BorderStyle = 0
388:                 .Text1.Margin      = 0
389:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 395 a 403:
395:                 .Movable           = .F.
396:                 .Resizable         = .F.
397:                 .ReadOnly          = .T.
398:                 .Header1.Caption   = "O.P."
399:                 .Header1.Alignment = 2
400:                 .Header1.ForeColor = RGB(0,0,0)
401:                 .Text1.BorderStyle = 0
402:                 .Text1.Margin      = 0
403:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 409 a 417:
409:                 .Movable           = .F.
410:                 .Resizable         = .F.
411:                 .ReadOnly          = .T.
412:                 .Header1.Caption   = "Produto"
413:                 .Header1.Alignment = 2
414:                 .Header1.ForeColor = RGB(0,0,0)
415:                 .Text1.BorderStyle = 0
416:                 .Text1.Margin      = 0
417:                 .Text1.ForeColor   = RGB(0,0,0)

*-- Linhas 423 a 431:
423:                 .Movable            = .F.
424:                 .Resizable          = .F.
425:                 .ReadOnly           = .T.
426:                 .Header1.Caption    = "Qtde"
427:                 .Header1.Alignment  = 2
428:                 .Header1.ForeColor  = RGB(0,0,0)
429:                 .Text1.InputMask    = "9999.99"
430:                 .Text1.BorderStyle  = 0
431:                 .Text1.Margin       = 0

*-- Linhas 440 a 501:
440:     *==========================================================================
441:     PROTECTED PROCEDURE ConfigurarBotoes
442:         *-- Botao Confirmar (Salva do legado)
443:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
444:         WITH THIS.cmd_4c_Confirmar
445:             .Top        = 3
446:             .Left       = 650
447:             .Height     = 75
448:             .Width      = 75
449:             .FontBold   = .T.
450:             .FontItalic = .T.
451:             .FontName   = "Comic Sans MS"
452:             .FontSize   = 8
453:             .WordWrap   = .F.
454:             .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
455:             .Caption    = "Confirmar"
456:             .ForeColor  = RGB(90,90,90)
457:             .BackColor  = RGB(255,255,255)
458:             .Themes           = .T.
459:             .Visible    = .T.
460:         ENDWITH
461: 
462:         *-- Botao Cancelar/Sair (Sair do legado)
463:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
464:         WITH THIS.cmd_4c_Cancelar
465:             .Top        = 3
466:             .Left       = 725
467:             .Height     = 75
468:             .Width      = 75
469:             .FontBold   = .T.
470:             .FontItalic = .T.
471:             .FontName   = "Comic Sans MS"
472:             .FontSize   = 8
473:             .WordWrap   = .F.
474:             .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
475:             .Cancel     = .T.
476:             .Caption    = "Encerrar"
477:             .ForeColor  = RGB(90,90,90)
478:             .BackColor  = RGB(255,255,255)
479:             .Themes           = .T.
480:             .Visible    = .T.
481:         ENDWITH
482:     ENDPROC
483: 
484:     *==========================================================================
485:     * ConfigurarPaginaDados - Controles de exibicao auxiliares (equivalente a
486:     * "Page2 Dados" nos forms CRUD). Para este form OPERACIONAL sem PageFrame,
487:     * agrupa os controles de exibicao de contexto da operacao selecionada:
488:     * txt_4c_Info (identificacao da OP), lbl_4c_Cliente e txt_4c_Cliente.
489:     *==========================================================================
490:     PROTECTED PROCEDURE ConfigurarPaginaDados
491:         *-- Caixa de identificacao da operacao selecionada (Text1 do legado)
492:         *-- Exibe: "EMP OPERACAO NUMES" ao navegar na grade principal
493:         THIS.AddObject("txt_4c_Info", "TextBox")
494:         WITH THIS.txt_4c_Info
495:             .Top         = 110
496:             .Left        = 470
497:             .Width       = 329
498:             .Height      = 21
499:             .FontBold    = .T.
500:             .FontName    = "Tahoma"
501:             .FontSize    = 8

*-- Linhas 509 a 540:
509:         ENDWITH
510: 
511:         *-- Label "Cliente" (Say3 do legado)
512:         THIS.AddObject("lbl_4c_Cliente", "Label")
513:         WITH THIS.lbl_4c_Cliente
514:             .AutoSize   = .T.
515:             .FontBold   = .F.
516:             .FontItalic = .F.
517:             .FontName   = "Tahoma"
518:             .FontSize   = 8
519:             .BackStyle  = 0
520:             .Caption    = "Cliente"
521:             .Left       = 23
522:             .Top        = 515
523:             .ForeColor  = RGB(90,90,90)
524:             .Visible    = .T.
525:         ENDWITH
526: 
527:         *-- Caixa do cliente (Get_Cliente do legado - somente leitura, preenchida via Grade)
528:         THIS.AddObject("txt_4c_Cliente", "TextBox")
529:         WITH THIS.txt_4c_Cliente
530:             .FontBold    = .T.
531:             .FontName    = "Tahoma"
532:             .FontSize    = 8
533:             .Height      = 23
534:             .Left        = 60
535:             .Top         = 512
536:             .Width       = 411
537:             .ForeColor   = RGB(0,0,0)
538:             .BackColor   = RGB(255,255,221)
539:             .ReadOnly    = .T.
540:             .BorderStyle = 0

*-- Linhas 548 a 623:
548:     *==========================================================================
549:     PROTECTED PROCEDURE ConfigurarControlesAuxiliares
550:         *-- Label "Ordenacao" (lbl_lancamentos do legado)
551:         THIS.AddObject("lbl_4c_Ordenacao", "Label")
552:         WITH THIS.lbl_4c_Ordenacao
553:             .AutoSize   = .T.
554:             .FontBold   = .F.
555:             .FontItalic = .F.
556:             .FontName   = "Tahoma"
557:             .FontSize   = 8
558:             .BackStyle  = 0
559:             .Caption    = "Ordena" + CHR(231) + CHR(227) + "o :"
560:             .Left       = 16
561:             .Top        = 545
562:             .ForeColor  = RGB(90,90,90)
563:             .Visible    = .T.
564:         ENDWITH
565: 
566:         *-- ComboBox de ordenacao (Cmb_Concilia do legado)
567:         THIS.AddObject("cbo_4c_Ordenacao", "ComboBox")
568:         WITH THIS.cbo_4c_Ordenacao
569:             .FontName      = "Tahoma"
570:             .FontSize      = 8
571:             .RowSourceType = 0
572:             .Style         = 2
573:             .Height        = 24
574:             .Left          = 80
575:             .Top           = 540
576:             .Width         = 140
577:             .Visible       = .T.
578:         ENDWITH
579: 
580:         *-- Label de dica TAB (Label1 do legado)
581:         THIS.AddObject("lbl_4c_TabDica", "Label")
582:         WITH THIS.lbl_4c_TabDica
583:             .AutoSize   = .T.
584:             .FontBold   = .F.
585:             .FontItalic = .F.
586:             .FontName   = "Tahoma"
587:             .FontSize   = 8
588:             .BackStyle  = 0
589:             .Caption    = "[ < TAB > para mudar de Grade ] "
590:             .Left       = 306
591:             .Top        = 545
592:             .ForeColor  = RGB(90,90,90)
593:             .Visible    = .T.
594:         ENDWITH
595:     ENDPROC
596: 
597:     *==========================================================================
598:     * ConfigurarImagemProduto - Cria shape e imagem do produto (ocultos por padrao)
599:     *==========================================================================
600:     PROTECTED PROCEDURE ConfigurarImagemProduto
601:         *-- Shape de fundo (Shape4 do legado)
602:         THIS.AddObject("shp_4c_Shape4", "Shape")
603:         WITH THIS.shp_4c_Shape4
604:             .Top         = 461
605:             .Left        = 480
606:             .Width       = 148
607:             .Height      = 109
608:             .BackStyle   = 0
609:             .BorderColor = RGB(90,90,90)
610:             .Visible     = .F.
611:         ENDWITH
612: 
613:         *-- Imagem do produto (FigJpg do legado)
614:         THIS.AddObject("img_4c_FigJpg", "Image")
615:         WITH THIS.img_4c_FigJpg
616:             .Stretch = 1
617:             .Top     = 463
618:             .Left    = 483
619:             .Width   = 143
620:             .Height  = 105
621:             .Visible = .F.
622:         ENDWITH
623:     ENDPROC

*-- Linhas 695 a 704:
695:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "GrdDadosCol1LostFocus")
696:         BINDEVENT(THIS.grd_4c_Itens.Column1.Text1, "KeyPress", THIS, "GrdItensCol1LostFocus")
697:         BINDEVENT(THIS.cbo_4c_Ordenacao, "InteractiveChange", THIS, "CboOrdenacaoInteractiveChange")
698:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
699:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
700:     ENDPROC
701: 
702:     *==========================================================================
703:     * AlternarPagina - Alterna foco entre a grade principal (1) e a grade de
704:     * itens (2). Em OPERACIONAL sem PageFrame, este metodo cumpre o papel do

*-- Linhas 1049 a 1058:
1049:     PROCEDURE HabilitarCampos()
1050:         LOCAL loc_lTemDados
1051:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1052:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1053:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1054:         ENDIF
1055:         IF PEMSTATUS(THIS, "cbo_4c_Ordenacao", 5)
1056:             THIS.cbo_4c_Ordenacao.Enabled = loc_lTemDados
1057:         ENDIF
1058:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)

*-- Linhas 1080 a 1089:
1080:     PROCEDURE AjustarBotoesPorModo()
1081:         LOCAL loc_lTemDados
1082:         loc_lTemDados = USED("cursor_4c_Selecao") AND RECCOUNT("cursor_4c_Selecao") > 0
1083:         IF PEMSTATUS(THIS, "cmd_4c_Confirmar", 5)
1084:             THIS.cmd_4c_Confirmar.Enabled = loc_lTemDados
1085:         ENDIF
1086:     ENDPROC
1087: 
1088:     *==========================================================================
1089:     * BtnBuscarClick - Volta ao topo da grade principal e reposiciona painel


### BO (C:\4c\projeto\app\classes\SigPrPcpBO.prg):
*==============================================================================
* SigPrPcpBO.prg - Business Object: Priorizacao de Operacoes para PCP
* Tabela principal: SigMvCab (UPDATE Priors)
* Formulario: FormSigPrPcp.prg
*==============================================================================
DEFINE CLASS SigPrPcpBO AS BusinessBase

    *-- Tabela e chave (alvo do UPDATE de prioridades)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "EmpDopNums"

    *-- Parametros de configuracao (lidos de SigCdPam)
    this_cOperacao    = ""   && DoppPads - tipo de operacao para planejamento
    this_cServico     = ""   && DoppServs - tipo de servico para planejamento

    *-- Registro corrente do cursor zTmpSelecao / zTmppPcp
    this_nPriors      = 0    && Priors n(6)   - prioridade atual (editavel)
    this_nNenvs       = 0    && nenvs n(10)   - numero envelope
    this_nNops        = 0    && Nops n(10)    - numero OP (SigPdMvf.NOps)
    this_cEmps        = ""   && Emps c(3)     - codigo empresa
    this_cDopes       = ""   && Dopes c(20)   - codigo operacao
    this_nNumes       = 0    && Numes n(6)    - numero da ordem de producao
    this_cContas      = ""   && Contas c(10)  - codigo conta/cliente (SigCdCli.Iclis)
    this_cRclis       = ""   && Rclis c(40)   - razao social do cliente
    this_tPrazoEnts   = {}   && PrazoEnts T   - prazo de entrega (DateTime)
    this_cCpros       = ""   && Cpros c(14)   - codigo do produto (SigCdPro)
    this_nQtds        = 0    && Qtds n(9,3)   - quantidade da OP
    this_nAPriors     = 0    && aPriors n(6)  - prioridade original antes de editar

    *-- Chave concatenada usada em INDEX e RELATION
    this_cEmpDopNum   = ""   && Emps + Dopes + Str(Numes,6)

    *-- Contexto de processamento (SigCdOpd)
    this_cNivels      = ""   && Nivels - nivel da operacao (SigCdOpd)
    this_nChkDests    = 0    && ChkDests n(1,0) - flag destino (SigCdOpd): 3=ignorar

    *-- Dados do item de grade (SigOpPic + SigMvCab + SigCdOpe)
    this_cContaOs     = ""   && ContaOs c(10) - conta origem (SigMvCab)
    this_cContaDs     = ""   && ContaDs c(10) - conta destino (SigMvCab)
    this_nGlobalizas  = 0    && Globalizas n(1,0) - flag globalizacao (SigCdOpe)
    this_nServicos    = 0    && Servicos n(1,0)   - flag servico (SigCdOpe)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave; chama BusinessBase.Init via DODEFAULT
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave concatenada do registro corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfiguracaoPam - Le DoppPads e DoppServs de SigCdPam
    * Popula: this_cOperacao, this_cServico
    *--------------------------------------------------------------------------
    FUNCTION ObterConfiguracaoPam()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select DoppPads, DoppServs From SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND RECCOUNT("cursor_4c_Pam") > 0
                    SELECT cursor_4c_Pam
                    THIS.this_cOperacao = ALLTRIM(NVL(DoppPads, ""))
                    THIS.this_cServico  = ALLTRIM(NVL(DoppServs, ""))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Pam")
            USE IN cursor_4c_Pam
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades this_* a partir de cursor
    * par_cAliasCursor: alias do cursor (zTmppPcp ou zTmpSelecao)
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nPriors    = NVL(Priors, 0)
            THIS.this_nNenvs     = NVL(Nenvs, 0)
            THIS.this_nNops      = NVL(Nops, 0)
            THIS.this_cEmps      = ALLTRIM(NVL(Emps, ""))
            THIS.this_cDopes     = ALLTRIM(NVL(Dopes, ""))
            THIS.this_nNumes     = NVL(Numes, 0)
            THIS.this_cContas    = ALLTRIM(NVL(Contas, ""))
            THIS.this_cRclis     = ALLTRIM(NVL(Rclis, ""))
            THIS.this_tPrazoEnts = NVL(PrazoEnts, {})
            THIS.this_cCpros     = ALLTRIM(NVL(Cpros, ""))
            THIS.this_nQtds      = NVL(Qtds, 0)
            THIS.this_nAPriors   = NVL(aPriors, 0)
            THIS.this_cEmpDopNum = THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - Processa OPs em aberto e popula cursor destino (zTmppPcp)
    * Requer: ObterConfiguracaoPam() chamado antes
    * par_cCursorDestino: cursor criado pelo Form (estrutura zTmppPcp)
    *--------------------------------------------------------------------------
    FUNCTION Processar(par_cCursorDestino)
        LOCAL loc_lSucesso, loc_lAbortar, loc_cSQL, loc_oErro, loc_oProg
        LOCAL loc_cEmpresa, loc_lEnvelope, loc_nEnv, loc_cCliente, loc_cRclis
        LOCAL loc_cOpCompara, loc_nPop
        LOCAL loc_nMfasNops, loc_nMfasNenvs, loc_nMfasNumps
        LOCAL loc_nPriors, loc_cEmps, loc_cDopes, loc_nNumes
        LOCAL loc_tPrazoEnts, loc_cCpros, loc_nQtds

        loc_lSucesso  = .F.
        loc_lAbortar  = .F.
        loc_cEmpresa  = go_4c_Sistema.cCodEmpresa

        TRY
            IF USED(par_cCursorDestino)
                SELECT (par_cCursorDestino)
                ZAP
            ENDIF

            *-- Buscar OPs em aberto de Operacao (DoppPads) em SigCdNec
            loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                       "Where EmpDNps Between " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + STR(0,10)) + ;
                       " And " + ;
                       EscaparSQL(loc_cEmpresa + THIS.this_cOperacao + "9999999999") + ;
                       " And ChkSubn = 0 Order By Numps, Dopps, cIdChaves"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend1") < 1
                loc_lAbortar = .T.
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (OpPendente1)")
            ENDIF

            IF !loc_lAbortar
                *-- Buscar OPs em aberto de Servico (DoppServs) em SigCdNec
                loc_cSQL = "Select Numps, Dopps, cIdChaves From SigCdNec " + ;
                           "Where EmpDNps Between " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + STR(0,10)) + ;
                           " And " + ;
                           EscaparSQL(loc_cEmpresa + THIS.this_cServico + "9999999999") + ;
                           " And ChkSubn = 0 And 0=1 Order By Numps, Dopps, cIdChaves"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpPend2") < 1
                    loc_lAbortar = .T.
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (OpPendente2)")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                *-- Unir cursores de Operacao e Servico
                SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend1 ;
                    UNION ALL ;
                    SELECT 0 AS Priors, Numps, Dopps FROM cursor_4c_OpPend2 ;
                    INTO CURSOR cursor_4c_OpPendente READWRITE

                IF USED("cursor_4c_OpPend1")
                    USE IN cursor_4c_OpPend1
                ENDIF
                IF USED("cursor_4c_OpPend2")
                    USE IN cursor_4c_OpPend2
                ENDIF

                SELECT cursor_4c_OpPendente
                loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Ops ...", RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Buscar movimentos de producao (SigPdMvf)
                    loc_cSQL = "Select * From SigPdMvf Where Nops = " + ;
                               FormatarNumeroSQL(cursor_4c_OpPendente.Numps, 0) + ;
                               " Order by Nops, CidChaves desc"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMfas")

                    IF !USED("cursor_4c_TmpMfas") OR RECCOUNT("cursor_4c_TmpMfas") = 0
                        IF USED("cursor_4c_TmpMfas")
                            USE IN cursor_4c_TmpMfas
                        ENDIF
                        LOOP
                    ENDIF

                    SELECT cursor_4c_TmpMfas
                    GO TOP
                    IF EMPTY(NVL(cursor_4c_TmpMfas.GrupoDs, ""))
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    *-- Salvar valores de TmpMfas antes de trocar work area
                    loc_nMfasNops  = NVL(cursor_4c_TmpMfas.Nops, 0)
                    loc_nMfasNenvs = NVL(cursor_4c_TmpMfas.Nenvs, 0)
                    loc_nMfasNumps = NVL(cursor_4c_TmpMfas.Numps, 0)
                    loc_nPop       = loc_nMfasNops

                    loc_cOpCompara = IIF(ALLTRIM(NVL(cursor_4c_OpPendente.Dopps, "")) = ;
                                        ALLTRIM(THIS.this_cOperacao), ;
                                        THIS.this_cOperacao, THIS.this_cServico)

                    *-- Buscar dados da operacao em SigCdOpd
                    loc_cSQL = "Select * From SigCdOpd Where Dopps = " + ;
                               EscaparSQL(ALLTRIM(cursor_4c_TmpMfas.Dopps))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdOpd")

                    IF !USED("cursor_4c_SigCdOpd") OR RECCOUNT("cursor_4c_SigCdOpd") = 0
                        IF USED("cursor_4c_SigCdOpd")
                            USE IN cursor_4c_SigCdOpd
                        ENDIF
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    SELECT cursor_4c_SigCdOpd
                    IF NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 3
                        USE IN cursor_4c_SigCdOpd
                        USE IN cursor_4c_TmpMfas
                        LOOP
                    ENDIF

                    loc_lEnvelope = (ALLTRIM(NVL(cursor_4c_SigCdOpd.Nivels, "")) <> ;
                                    ALLTRIM(loc_cOpCompara) OR ;
                                    NVL(cursor_4c_SigCdOpd.ChkDests, 0) = 1)
                    USE IN cursor_4c_SigCdOpd

                    *-- Query principal: SigOpPic + SigMvCab + SigCdOpe agrupados
                    loc_cSQL = "Select a.Nops, Sum(a.Qtds) as Qtds, b.ContaOs, b.ContaDs, " + ;
                               "b.prazoents, b.empdopNums, b.priors, b.Emps, b.Dopes, b.Numes, " + ;
                               "c.Globalizas, c.Servicos, a.cpros " + ;
                               "From SigOpPic a, SigMvCab b, SigCdOpe c " + ;
                               "Where a.Nops = " + FormatarNumeroSQL(loc_nPop, 0) + ;
                               " And a.EmpDopNums = b.EmpDopNums " + ;
                               "And b.Dopes = c.Dopes " + ;
                               "Group by a.Nops, b.ContaOs, b.ContaDs, b.prazoents, " + ;
                               "b.empdopnums, b.priors, b.emps, b.dopes, " + ;
                               "b.numes, c.globalizas, c.Servicos, a.cpros"

                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpi") < 1
                        USE IN cursor_4c_TmpMfas
                        loc_lAbortar = .T.
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (crTmpOpi)")
                        EXIT
                    ENDIF

                    *-- Processar cada item da OP
                    SELECT cursor_4c_TmpOpi
                    SCAN
                        IF NVL(cursor_4c_TmpOpi.Qtds, 0) <> 0
                            *-- Calcular numero do envelope
                            IF loc_lEnvelope
                                loc_nEnv = loc_nMfasNenvs
                                IF loc_nMfasNenvs = loc_nMfasNops
                                    loc_nEnv = loc_nMfasNumps
                                ENDIF
                            ELSE
                                loc_nEnv = 0
                            ENDIF
                            loc_nEnv = IIF(loc_nEnv = 0, loc_nMfasNops, loc_nEnv)

                            *-- Globalizas=1 ou Servicos=1: usa ContaOs; senao ContaDs
                            IF NVL(cursor_4c_TmpOpi.Globalizas, 0) = 1 OR ;
                               NVL(cursor_4c_TmpOpi.Servicos, 0) = 1
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaOs, ""))
                            ELSE
                                loc_cCliente = ALLTRIM(NVL(cursor_4c_TmpOpi.ContaDs, ""))
                            ENDIF

                            *-- Buscar razao social do cliente em SigCdCli
                            loc_cSQL = "Select rclis From SigCdCli Where Iclis = " + ;
                                       EscaparSQL(loc_cCliente)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCli")
                            loc_cRclis = ""
                            IF USED("cursor_4c_TmpCli") AND RECCOUNT("cursor_4c_TmpCli") > 0
                                SELECT cursor_4c_TmpCli
                                loc_cRclis = ALLTRIM(NVL(rclis, ""))
                            ENDIF
                            IF USED("cursor_4c_TmpCli")
                                USE IN cursor_4c_TmpCli
                            ENDIF

                            *-- Capturar valores de TmpOpi para o REPLACE
                            SELECT cursor_4c_TmpOpi
                            loc_nPriors    = NVL(cursor_4c_TmpOpi.Priors, 0)
                            loc_cEmps      = ALLTRIM(NVL(cursor_4c_TmpOpi.Emps, ""))
                            loc_cDopes     = ALLTRIM(NVL(cursor_4c_TmpOpi.Dopes, ""))
                            loc_nNumes     = NVL(cursor_4c_TmpOpi.Numes, 0)
                            loc_tPrazoEnts = NVL(cursor_4c_TmpOpi.PrazoEnts, {})
                            loc_cCpros     = ALLTRIM(NVL(cursor_4c_TmpOpi.Cpros, ""))
                            loc_nQtds      = NVL(cursor_4c_TmpOpi.Qtds, 0)

                            *-- Inserir no cursor destino
                            SELECT (par_cCursorDestino)
                            APPEND BLANK
                            REPLACE Priors    WITH loc_nPriors, ;
                                    Nenvs     WITH loc_nEnv, ;
                                    Nops      WITH loc_nMfasNops, ;
                                    Emps      WITH loc_cEmps, ;
                                    Dopes     WITH loc_cDopes, ;
                                    Numes     WITH loc_nNumes, ;
                                    Contas    WITH loc_cCliente, ;
                                    Rclis     WITH LEFT(loc_cRclis, 40), ;
                                    PrazoEnts WITH loc_tPrazoEnts, ;
                                    Cpros     WITH loc_cCpros, ;
                                    Qtds      WITH loc_nQtds, ;
                                    aPriors   WITH loc_nPriors
                        ENDIF
                    ENDSCAN

                    IF USED("cursor_4c_TmpOpi")
                        USE IN cursor_4c_TmpOpi
                    ENDIF
                    IF USED("cursor_4c_TmpMfas")
                        USE IN cursor_4c_TmpMfas
                    ENDIF
                ENDSCAN

                IF VARTYPE(loc_oProg) = "O"
                    loc_oProg.Complete()
                    loc_oProg = .NULL.
                ENDIF

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        *-- Limpeza de cursores temporarios
        IF USED("cursor_4c_OpPend1")
            USE IN cursor_4c_OpPend1
        ENDIF
        IF USED("cursor_4c_OpPend2")
            USE IN cursor_4c_OpPend2
        ENDIF
        IF USED("cursor_4c_OpPendente")
            USE IN cursor_4c_OpPendente
        ENDIF
        IF USED("cursor_4c_TmpMfas")
            USE IN cursor_4c_TmpMfas
        ENDIF
        IF USED("cursor_4c_SigCdOpd")
            USE IN cursor_4c_SigCdOpd
        ENDIF
        IF USED("cursor_4c_TmpOpi")
            USE IN cursor_4c_TmpOpi
        ENDIF
        IF USED("cursor_4c_TmpCli")
            USE IN cursor_4c_TmpCli
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza prioridade de uma OP individual em SigMvCab
    * Usa: this_nPriors, this_cEmps, this_cDopes, this_nNumes
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Update SigMvCab Set Priors = " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ;
                       " Where EmpDopNums = " + ;
                       EscaparSQL(THIS.ObterChavePrimaria())
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarPrioridades - Grava todas as prioridades alteradas em lote
    * par_cCursorSelecao: cursor com os registros (ex: "zTmpSelecao")
    * Ignora registros onde Priors=0 E aPriors=0 (sem alteracao)
    *--------------------------------------------------------------------------
    FUNCTION GravarPrioridades(par_cCursorSelecao)
        LOCAL loc_lSucesso, loc_lTransacao, loc_cSQL, loc_oErro
        LOCAL loc_cEdn, loc_nPriors

        loc_lSucesso   = .T.
        loc_lTransacao = .F.

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacao = .T.

            SELECT (par_cCursorSelecao)
            GO TOP
            SCAN
                IF NVL(Priors, 0) = 0 AND NVL(aPriors, 0) = 0
                    LOOP
                ENDIF

                loc_nPriors = NVL(Priors, 0)
                loc_cEdn    = ALLTRIM(NVL(Emps, "")) + ;
                              ALLTRIM(NVL(Dopes, "")) + ;
                              STR(NVL(Numes, 0), 6)

                loc_cSQL = "Update SigMvCab Set Priors = " + ;
                           FormatarNumeroSQL(loc_nPriors, 0) + ;
                           " Where EmpDopNums = " + EscaparSQL(loc_cEdn)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN

            IF loc_lSucesso
                SQLEXEC(gnConnHandle, "COMMIT")
                THIS.RegistrarAuditoria("GRAVARPRIORIDADES")
            ELSE
                SQLEXEC(gnConnHandle, "ROLLBACK")
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel completar " + ;
                        "o processamento (commit). Tente novamente!!", ;
                        "Falha na Grava" + CHR(231) + CHR(227) + "o")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterImagemProduto - Busca e grava imagem Base64 de SigCdPro em arquivo
    * par_cCpros: codigo do produto
    * par_cArquivoDestino: caminho completo do arquivo temporario
    * Retorna: .T. se imagem obtida e gravada com sucesso
    *--------------------------------------------------------------------------
    FUNCTION ObterImagemProduto(par_cCpros, par_cArquivoDestino)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro, loc_cFoto
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "Select FigJpgs From SigCdPro Where Cpros = " + ;
                       EscaparSQL(par_cCpros)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPro") > 0
                IF USED("cursor_4c_TmpPro") AND RECCOUNT("cursor_4c_TmpPro") > 0
                    SELECT cursor_4c_TmpPro
                    IF !EMPTY(NVL(cursor_4c_TmpPro.FigJpgs, ""))
                        loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                                    cursor_4c_TmpPro.FigJpgs, ;
                                    "data:image/png;base64,", ""), ;
                                    "data:image/jpeg;base64,", ""), ;
                                    "data:image/jpg;base64,", ""), 14)
                        IF STRTOFILE(loc_cFoto, par_cArquivoDestino) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_TmpPro")
            USE IN cursor_4c_TmpPro
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

