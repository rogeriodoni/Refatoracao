# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 286: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 308: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 331: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReEqT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1347 linhas total):

*-- Linhas 118 a 126:
118:         loc_lSucesso   = .F.
119:         loc_lContinuar = .T.
120:         TRY
121:             THIS.Caption = "Estoque Retroativo"
122: 
123:             IF TYPE("gc_4c_CaminhoIcones") = "U"
124:                 gc_4c_CaminhoIcones = ""
125:             ENDIF
126:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 164 a 173:
164:                 ENDIF
165: 
166:                 *-- Atualizar captions do cabecalho apos criacao
167:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = "Estoque Retroativo"
168:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = "Estoque Retroativo"
169: 
170:                 *-- Vincula eventos dos botoes, opcao e paginas
171:                 THIS.ConfigurarEventos()
172: 
173:                 THIS.Visible   = .T.

*-- Linhas 191 a 270:
191:     PROTECTED PROCEDURE ConfigurarCabecalho()
192:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
193:         WITH THIS.cnt_4c_Cabecalho
194:             .Top         = 0
195:             .Left        = 0
196:             .Width       = THIS.Width
197:             .Height      = 80
198:             .BackStyle   = 1
199:             .BackColor   = RGB(100, 100, 100)
200:             .BorderWidth = 0
201:             .Visible     = .T.
202: 
203:             *-- Sombra deslocada 2px para efeito de profundidade no titulo
204:             .AddObject("lbl_4c_Sombra", "Label")
205:             WITH .lbl_4c_Sombra
206:                 .Top       = 22
207:                 .Left      = 22
208:                 .Width     = THIS.Width
209:                 .Height    = 30
210:                 .Caption   = "Estoque Retroativo"
211:                 .FontName  = "Tahoma"
212:                 .FontSize  = 14
213:                 .FontBold  = .T.
214:                 .ForeColor = RGB(0, 0, 0)
215:                 .BackStyle = 0
216:                 .Visible   = .T.
217:             ENDWITH
218: 
219:             *-- Titulo em branco sobre a sombra
220:             .AddObject("lbl_4c_Titulo", "Label")
221:             WITH .lbl_4c_Titulo
222:                 .Top       = 20
223:                 .Left      = 20
224:                 .Width     = THIS.Width
225:                 .Height    = 30
226:                 .Caption   = "Estoque Retroativo"
227:                 .FontName  = "Tahoma"
228:                 .FontSize  = 14
229:                 .FontBold  = .T.
230:                 .ForeColor = RGB(255, 255, 255)
231:                 .BackStyle = 0
232:                 .Visible   = .T.
233:             ENDWITH
234:         ENDWITH
235:     ENDPROC
236: 
237:     *--------------------------------------------------------------------------
238:     * ConfigurarBotoes - CommandGroup com 4 botoes de relatorio
239:     *   Original: BTNREPORT.Left=525, Top=-1 -> canonico Left=529, Top=0
240:     *   Geometria do framework frmrelatorio: Width=273, Height=80, ButtonCount=4
241:     *   Botoes: Visualizar(5) / Imprimir(71) / Excel(137) / Encerrar(203)
242:     *   BINDEVENTs Click vinculados em ConfigurarEventos()
243:     *--------------------------------------------------------------------------
244:     PROTECTED PROCEDURE ConfigurarBotoes()
245:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
246:         WITH THIS.cmg_4c_Botoes
247:             .Top           = 0
248:             .Left          = 529
249:             .Width         = 273
250:             .Height        = 80
251:             .ButtonCount   = 4
252:             .BackStyle     = 0
253:             .BorderStyle   = 0
254:             .BorderColor   = RGB(136, 189, 188)
255:             .SpecialEffect = 1
256:             .Themes        = .F.
257:             .Visible       = .T.
258: 
259:             *-- Botao 1: Visualizar (preview em tela)
260:             WITH .Buttons(1)
261:                 .Top             = 5
262:                 .Left            = 5
263:                 .Width           = 65
264:                 .Height          = 70
265:                 .Caption         = "Visualizar"
266:                 .FontBold        = .T.
267:                 .FontItalic      = .T.
268:                 .BackColor       = RGB(255, 255, 255)
269:                 .ForeColor       = RGB(90, 90, 90)
270:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 278 a 292:
278: 
279:             *-- Botao 2: Imprimir (impressora padrao)
280:             WITH .Buttons(2)
281:                 .Top             = 5
282:                 .Left            = 71
283:                 .Width           = 65
284:                 .Height          = 70
285:                 .Caption         = "Imprimir"
286:                 .FontName        = "Comic Sans MS"
287:                 .FontBold        = .T.
288:                 .FontItalic      = .T.
289:                 .FontSize        = 8
290:                 .BackColor       = RGB(255, 255, 255)
291:                 .ForeColor       = RGB(90, 90, 90)
292:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 300 a 314:
300: 
301:             *-- Botao 3: Excel (exportar dados)
302:             WITH .Buttons(3)
303:                 .Top             = 5
304:                 .Left            = 137
305:                 .Width           = 65
306:                 .Height          = 70
307:                 .Caption         = "Excel"
308:                 .FontName        = "Comic Sans MS"
309:                 .FontBold        = .T.
310:                 .FontItalic      = .T.
311:                 .FontSize        = 8
312:                 .BackColor       = RGB(255, 255, 255)
313:                 .ForeColor       = RGB(90, 90, 90)
314:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 322 a 337:
322: 
323:             *-- Botao 4: Encerrar (fechar form - ESC)
324:             WITH .Buttons(4)
325:                 .Top             = 5
326:                 .Left            = 203
327:                 .Width           = 65
328:                 .Height          = 70
329:                 .Caption         = "Encerrar"
330:                 .Cancel          = .T.
331:                 .FontName        = "Comic Sans MS"
332:                 .FontBold        = .T.
333:                 .FontItalic      = .T.
334:                 .FontSize        = 8
335:                 .BackColor       = RGB(255, 255, 255)
336:                 .ForeColor       = RGB(90, 90, 90)
337:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 347 a 355:
347: 
348:     *--------------------------------------------------------------------------
349:     * ConfigurarOpcao - OptionGroup de selecao de tipo de visualizacao
350:     *   Original: Opt_Key.Top=94, Left=168, Width=69, Height=42, Value=2
351:     *   Value=1 = Analitico (por produto - cursor_4c_TempoCp / SigReEq1.frx)
352:     *   Value=2 = Sintetico (por grupo  - cursor_4c_TempoGr / SigReEq2.frx) [padrao]
353:     *   BINDEVENT InteractiveChange vinculado em ConfigurarEventos()
354:     *--------------------------------------------------------------------------
355:     PROTECTED PROCEDURE ConfigurarOpcao()

*-- Linhas 361 a 400:
361:             .BorderStyle   = 1
362:             .Value         = 2
363:             .Height        = 42
364:             .Left          = 168
365:             .SpecialEffect = 1
366:             .Top           = 94
367:             .Width         = 69
368:             .Themes        = .F.
369:             .Visible       = .T.
370: 
371:             *-- Botao 1: Analitico (por produto - Page2)
372:             WITH .Buttons(1)
373:                 .BackStyle = 0
374:                 .Caption   = "\<Anal" + CHR(237) + "tico"
375:                 .Value     = 0
376:                 .Height    = 15
377:                 .Left      = 5
378:                 .Top       = 5
379:                 .Width     = 58
380:                 .AutoSize  = .T.
381:                 .ForeColor = RGB(90, 90, 90)
382:                 .Themes    = .F.
383:                 .Visible   = .T.
384:             ENDWITH
385: 
386:             *-- Botao 2: Sintetico (por grupo - Page1) - padrao selecionado
387:             WITH .Buttons(2)
388:                 .FontName  = "Tahoma"
389:                 .FontSize  = 8
390:                 .BackStyle = 0
391:                 .Caption   = "\<Sint" + CHR(233) + "tico"
392:                 .Value     = 1
393:                 .Height    = 15
394:                 .Left      = 5
395:                 .Top       = 22
396:                 .Width     = 59
397:                 .AutoSize  = .T.
398:                 .ForeColor = RGB(90, 90, 90)
399:                 .Themes    = .F.
400:                 .Visible   = .T.

*-- Linhas 420 a 444:
420:         loc_oPgf.PageCount = 2
421: 
422:         *-- Posicao EXATA do original
423:         loc_oPgf.Top    = 151
424:         loc_oPgf.Left   = 58
425:         loc_oPgf.Width  = 684
426:         loc_oPgf.Height = 316
427: 
428:         *-- ErasePage limpa fundo das paginas antes de redesenho
429:         loc_oPgf.ErasePage = .T.
430: 
431:         *-- Page1: Resultado (visao sintetica por grupo)
432:         loc_oPgf.Page1.Caption   = "Resultado"
433:         loc_oPgf.Page1.FontName  = "Tahoma"
434:         loc_oPgf.Page1.FontSize  = 8
435:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
436:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
437: 
438:         *-- Page2: Produtos (visao analitica por produto)
439:         loc_oPgf.Page2.Caption   = "Produtos"
440:         loc_oPgf.Page2.FontName  = "Tahoma"
441:         loc_oPgf.Page2.FontSize  = 8
442:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
443:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
444: 

*-- Linhas 459 a 468:
459:             loc_oGrid = loc_oPagina.grd_4c_Dados
460: 
461:             WITH loc_oGrid
462:                 .Top               = 10
463:                 .Left              = 10
464:                 .Width             = 660
465:                 .Height            = 276
466:                 .ColumnCount       = 9
467:                 .FontName          = "Tahoma"
468:                 .FontSize          = 8

*-- Linhas 484 a 492:
484:                     .FontName  = "Tahoma"
485:                     .FontSize  = 8
486:                     WITH .Header1
487:                         .Caption   = "Grupo"
488:                         .FontName  = "Tahoma"
489:                         .FontSize  = 8
490:                         .Alignment = 2
491:                         .ForeColor = RGB(90, 90, 90)
492:                     ENDWITH

*-- Linhas 509 a 517:
509:                     .FontName  = "Tahoma"
510:                     .FontSize  = 8
511:                     WITH .Header1
512:                         .Caption   = "Conta"
513:                         .FontName  = "Tahoma"
514:                         .FontSize  = 8
515:                         .Alignment = 2
516:                         .ForeColor = RGB(90, 90, 90)
517:                     ENDWITH

*-- Linhas 535 a 543:
535:                     .FontSize  = 8
536:                     .Format    = "9999,999.9"
537:                     WITH .Header1
538:                         .Caption   = "Linha"
539:                         .FontName  = "Tahoma"
540:                         .FontSize  = 8
541:                         .Alignment = 2
542:                         .ForeColor = RGB(90, 90, 90)
543:                     ENDWITH

*-- Linhas 561 a 569:
561:                     .FontSize  = 8
562:                     .Format    = "999,999.99"
563:                     WITH .Header1
564:                         .Caption   = "Peso"
565:                         .FontName  = "Tahoma"
566:                         .FontSize  = 8
567:                         .Alignment = 2
568:                         .ForeColor = RGB(90, 90, 90)
569:                     ENDWITH

*-- Linhas 587 a 595:
587:                     .FontSize  = 8
588:                     .Format    = "999,999.999"
589:                     WITH .Header1
590:                         .Caption   = "Quantidade"
591:                         .FontName  = "Tahoma"
592:                         .FontSize  = 8
593:                         .Alignment = 2
594:                         .ForeColor = RGB(90, 90, 90)
595:                     ENDWITH

*-- Linhas 613 a 621:
613:                     .FontSize  = 8
614:                     .Format    = "9999,999.99"
615:                     WITH .Header1
616:                         .Caption   = "$Venda"
617:                         .FontName  = "Tahoma"
618:                         .FontSize  = 8
619:                         .Alignment = 2
620:                         .ForeColor = RGB(90, 90, 90)
621:                     ENDWITH

*-- Linhas 638 a 646:
638:                     .FontName  = "Tahoma"
639:                     .FontSize  = 8
640:                     WITH .Header1
641:                         .Caption   = "Moe"
642:                         .FontName  = "Tahoma"
643:                         .FontSize  = 8
644:                         .Alignment = 2
645:                         .ForeColor = RGB(90, 90, 90)
646:                     ENDWITH

*-- Linhas 663 a 671:
663:                     .FontSize  = 8
664:                     .Format    = "9999,999.99"
665:                     WITH .Header1
666:                         .Caption   = "$Custo"
667:                         .FontName  = "Tahoma"
668:                         .FontSize  = 8
669:                         .Alignment = 2
670:                         .ForeColor = RGB(90, 90, 90)
671:                     ENDWITH

*-- Linhas 689 a 697:
689:                     .FontSize  = 8
690:                     .Format    = "9999,999.99"
691:                     WITH .Header1
692:                         .Caption   = "Moe"
693:                         .FontName  = "Tahoma"
694:                         .FontSize  = 8
695:                         .Alignment = 2
696:                         .ForeColor = RGB(90, 90, 90)
697:                     ENDWITH

*-- Linhas 727 a 736:
727:             loc_oGrid = loc_oPagina.grd_4c_Dados
728: 
729:             WITH loc_oGrid
730:                 .Top               = 10
731:                 .Left              = 10
732:                 .Width             = 660
733:                 .Height            = 276
734:                 .ColumnCount       = 8
735:                 .FontName          = "Tahoma"
736:                 .FontSize          = 8

*-- Linhas 754 a 762:
754:                     .FontSize  = 8
755:                     .ForeColor = RGB(0, 0, 0)
756:                     WITH .Header1
757:                         .Caption   = "Referencia"
758:                         .FontName  = "Tahoma"
759:                         .FontSize  = 8
760:                         .Alignment = 2
761:                         .ForeColor = RGB(90, 90, 90)
762:                     ENDWITH

*-- Linhas 780 a 788:
780:                     .FontSize  = 8
781:                     .ForeColor = RGB(0, 0, 0)
782:                     WITH .Header1
783:                         .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
784:                         .FontName  = "Tahoma"
785:                         .FontSize  = 8
786:                         .Alignment = 2
787:                         .ForeColor = RGB(90, 90, 90)
788:                     ENDWITH

*-- Linhas 808 a 816:
808:                     .Format      = "999,999.9"
809:                     .ColumnOrder = 3
810:                     WITH .Header1
811:                         .Caption   = "Peso"
812:                         .FontName  = "Tahoma"
813:                         .FontSize  = 8
814:                         .Alignment = 2
815:                         .ForeColor = RGB(90, 90, 90)
816:                     ENDWITH

*-- Linhas 835 a 843:
835:                     .ForeColor = RGB(0, 0, 0)
836:                     .Format    = "999,999.999"
837:                     WITH .Header1
838:                         .Caption   = "Quantidade"
839:                         .FontName  = "Tahoma"
840:                         .FontSize  = 8
841:                         .Alignment = 2
842:                         .ForeColor = RGB(90, 90, 90)
843:                     ENDWITH

*-- Linhas 862 a 870:
862:                     .ForeColor = RGB(0, 0, 0)
863:                     .Format    = "9999,999.99"
864:                     WITH .Header1
865:                         .Caption   = "$Venda"
866:                         .FontName  = "Tahoma"
867:                         .FontSize  = 8
868:                         .Alignment = 2
869:                         .ForeColor = RGB(90, 90, 90)
870:                     ENDWITH

*-- Linhas 888 a 896:
888:                     .FontSize  = 8
889:                     .ForeColor = RGB(0, 0, 0)
890:                     WITH .Header1
891:                         .Caption   = "Moe"
892:                         .FontName  = "Tahoma"
893:                         .FontSize  = 8
894:                         .Alignment = 2
895:                         .ForeColor = RGB(90, 90, 90)
896:                     ENDWITH

*-- Linhas 915 a 923:
915:                     .ForeColor = RGB(0, 0, 0)
916:                     .Format    = "9999,999.99"
917:                     WITH .Header1
918:                         .Caption   = "$Custo"
919:                         .FontName  = "Tahoma"
920:                         .FontSize  = 8
921:                         .Alignment = 2
922:                         .ForeColor = RGB(90, 90, 90)
923:                     ENDWITH

*-- Linhas 940 a 948:
940:                     .FontSize  = 8
941:                     .ForeColor = RGB(0, 0, 0)
942:                     WITH .Header1
943:                         .Caption   = "Moe"
944:                         .FontName  = "Tahoma"
945:                         .FontSize  = 8
946:                         .Alignment = 2
947:                         .ForeColor = RGB(90, 90, 90)
948:                     ENDWITH


### BO (C:\4c\projeto\app\classes\SigReEqTBO.prg):
*==============================================================================
* SIGREEQTBO.PRG
* Business Object para Estoque Retroativo (SigReEqT)
* Herda de RelatorioBase
*
* IMPORTANTE: Este relatorio e um formulario filho que recebe cursores
* pre-carregados do form pai via DataSession. Nao executa SQL proprio.
* Cursors de entrada: csTempoGr (sintetico/grupos) e csTempoCp (analitico/produtos)
*==============================================================================

DEFINE CLASS SigReEqTBO AS RelatorioBase

    *-- Opcao de visualizacao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *-- Valor padrao 2 = Sintetico (igual ao original: Opt_Key.Value = 2)
    this_nOpcao             = 2

    *-- Nomes dos cursors de dados (preenchidos pelo form pai via Set DataSession)
    this_cCursorGrupos      = "cursor_4c_TempoGr"
    this_cCursorProdutos    = "cursor_4c_TempoCp"

    *-- Nomes dos arquivos FRX (sem extensao e sem caminho)
    *-- SigReEq1 = Analitico (csTempoCp, com ordem Imprimir)
    *-- SigReEq2 = Sintetico (csTempoGr)
    this_cFrxAnalitico      = "SigReEq1"
    this_cFrxSintetico      = "SigReEq2"

    *-- Titulo exibido no cabecalho do form
    this_cTitulo            = "Estoque Retroativo"

    *-- Mensagem de erro da ultima operacao
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO de Estoque Retroativo
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cTabela      = ""
            THIS.this_cCampoChave  = ""
            THIS.this_cTitulo      = "Estoque Retroativo"
            THIS.this_nOpcao       = 2

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida cursors fornecidos pelo form pai via DataSession
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(THIS.this_cCursorGrupos)
                THIS.this_cMensagemErro = "Cursor de grupos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorGrupos
                loc_lSucesso = .F.
            ENDIF
            IF !USED(THIS.this_cCursorProdutos)
                THIS.this_cMensagemErro = "Cursor de produtos n" + CHR(227) + "o encontrado: " + THIS.this_cCursorProdutos
                loc_lSucesso = .F.
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DefinirOpcao - Define opcao de visualizacao/impressao
    * par_nOpcao: 1=Analitico (por produto), 2=Sintetico (por grupo)
    *--------------------------------------------------------------------------
    PROCEDURE DefinirOpcao(par_nOpcao)
        THIS.this_nOpcao = par_nOpcao
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime relatorio direto para impressora sem dialogo
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirComPrompt - Imprime relatorio com dialogo de selecao de impressora
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirComPrompt()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) TO PRINTER PROMPT NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cPathFrx
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nOpcao = 1
                SELECT (THIS.this_cCursorProdutos)
                SET ORDER TO Imprimir
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxAnalitico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ELSE
                SELECT (THIS.this_cCursorGrupos)
                GO TOP
                loc_cPathFrx = gc_4c_CaminhoReports + THIS.this_cFrxSintetico + ".frx"
                REPORT FORM (loc_cPathFrx) PREVIEW NOCONSOLE
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterExpressaoCor - Retorna expressao DynamicForeColor para grid de grupos
    * Quebra='1' exibe em azul; Tipos='6' exibe em vermelho; demais em preto
    *--------------------------------------------------------------------------
    FUNCTION ObterExpressaoCor()
        RETURN "IIF(Quebra='1',RGB(0,0,255),IIF(Tipos='6',RGB(255,0,0),RGB(0,0,0)))"
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConfigurarFiltroProdutos - Filtra cursor de produtos pelo grupo selecionado
    * Equivalente ao Page2.Activate do original (SET KEY TO Grupos+Contas+Linhas)
    *--------------------------------------------------------------------------
    PROCEDURE ConfigurarFiltroProdutos()
        LOCAL loc_lSucesso, loc_cGrupos, loc_cContas, loc_cLinhas
        loc_lSucesso = .F.
        TRY
            SELECT (THIS.this_cCursorGrupos)
            loc_cGrupos = Grupos
            loc_cContas = Contas
            loc_cLinhas = Linhas

            SELECT (THIS.this_cCursorProdutos)
            SET ORDER TO Visualizar
            SET KEY TO loc_cGrupos + loc_cContas + loc_cLinhas
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparFiltroProdutos - Remove filtro SET KEY TO do cursor de produtos
    * Equivalente ao Page2.Deactivate do original
    *--------------------------------------------------------------------------
    PROCEDURE LimparFiltroProdutos()
        LOCAL loc_oErro
        TRY
            SELECT (THIS.this_cCursorProdutos)
            SET KEY TO
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Configura cursor de dados para o relatorio
    * par_cAliasCursor: alias do cursor preenchido pelo form pai
    * par_cTipo: "ANALITICO" (produtos/csTempoCp) ou "SINTETICO" (grupos/csTempoGr)
    *
    * Equivalente ao Init original que recebia poForm e setava DataSession.
    * Permite ao form pai injetar dinamicamente os cursors a usar.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor, par_cTipo)
        LOCAL loc_lSucesso, loc_cTipo
        loc_lSucesso = .F.
        TRY
            IF EMPTY(par_cAliasCursor)
                THIS.this_cMensagemErro = "Alias do cursor n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o existe: " + par_cAliasCursor
                loc_lSucesso = .F.
            ENDIF

            loc_cTipo = UPPER(ALLTRIM(NVL(par_cTipo, "SINTETICO")))
            IF loc_cTipo == "ANALITICO"
                THIS.this_cCursorProdutos = par_cAliasCursor
                THIS.this_nOpcao = 1
            ELSE
                THIS.this_cCursorGrupos = par_cAliasCursor
                THIS.this_nOpcao = 2
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Inser" + CHR(231) + CHR(245) + "es em tabelas de movimento s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de inser" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o suportada por BO de relat" + CHR(243) + "rio
    *
    * Relat" + CHR(243) + "rios apenas LEEM dados de cursors preenchidos pelo form pai.
    * Atualiza" + CHR(231) + CHR(245) + "es de registros s" + CHR(227) + "o feitas em BOs CRUD espec" + CHR(237) + "ficos.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o de atualiza" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o dispon" + CHR(237) + "vel em relat" + CHR(243) + "rios"
        MsgAviso(THIS.this_cMensagemErro)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do cursor ativo para fins de auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        TRY
            IF USED(THIS.this_cCursorGrupos)
                SELECT (THIS.this_cCursorGrupos)
                IF !EOF() AND TYPE(THIS.this_cCursorGrupos + ".Grupos") == "C"
                    loc_cChave = ALLTRIM(EVALUATE(THIS.this_cCursorGrupos + ".Grupos"))
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emiss" + CHR(227) + "o de relat" + CHR(243) + "rio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTipoRelatorio, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .F.
            ENDIF

            loc_cTipoRelatorio = IIF(THIS.this_nOpcao = 1, "Analitico", "Sintetico")
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                "VALUES (" + ;
                EscaparSQL("SigReEqT") + ", " + ;
                EscaparSQL(LEFT(NVL(par_cOperacao, "RELATORIO"), 10)) + ", " + ;
                EscaparSQL(LEFT(THIS.ObterChavePrimaria() + "|" + loc_cTipoRelatorio, 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                "GETDATE())"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE

