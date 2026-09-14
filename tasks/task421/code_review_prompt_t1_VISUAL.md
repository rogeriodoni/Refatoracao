# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 294: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 346: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormFop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1523 linhas total):

*-- Linhas 97 a 119:
97:                         USE IN crFopProdDesc
98:                     ENDIF
99: 
100:                     THIS.Caption = "Fornecedores do Produto : " + THIS.this_cCpros + "-" + THIS.this_cDpros
101:                 ENDIF
102: 
103:                 *-- Estrutura visual base (Fase 3) via orquestrador
104:                 THIS.ConfigurarPageFrame()
105: 
106:                 *-- Sincronizar caption nos labels
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
108:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
109: 
110:                 *-- Vincular eventos dos botoes
111:                 BINDEVENT(THIS.cmd_4c_Inserir,  "Click",     THIS, "CmdInserirClick")
112:                 BINDEVENT(THIS.cmd_4c_Excluir,  "Click",     THIS, "CmdExcluirClick")
113:                 BINDEVENT(THIS.cmd_4c_Repetir,  "Click",     THIS, "CmdRepetirClick")
114:                 BINDEVENT(THIS.cmd_4c_Encerrar, "Click",     THIS, "CmdEncerrarClick")
115:                 BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress",  THIS, "TxtQtdeKeyPress")
116:                 BINDEVENT(THIS.txt_4c_Qtde,     "KeyPress", THIS, "TxtQtdeLostFocus")
117: 
118:                 *-- Vincular eventos de lookup nas colunas editaveis do grid
119:                 IF THIS.this_lModoEdicao

*-- Linhas 177 a 226:
177:         TRY
178:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
179:             WITH THIS.cnt_4c_Cabecalho
180:                 .Top         = 0
181:                 .Left        = 0
182:                 .Width       = THIS.Width
183:                 .Height      = 80
184:                 .BackStyle   = 1
185:                 .BackColor   = RGB(100, 100, 100)
186:                 .BorderWidth = 0
187:                 .Visible     = .T.
188:             ENDWITH
189: 
190:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
191:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
192:                 .FontBold      = .T.
193:                 .FontName      = "Tahoma"
194:                 .FontSize      = 18
195:                 .FontUnderline = .F.
196:                 .WordWrap      = .T.
197:                 .Alignment     = 0
198:                 .BackStyle     = 0
199:                 .AutoSize      = .F.
200:                 .Caption       = THIS.Caption
201:                 .Height        = 40
202:                 .Left          = 10
203:                 .Top           = 25
204:                 .Width         = 660
205:                 .ForeColor     = RGB(0, 0, 0)
206:                 .Visible       = .T.
207:             ENDWITH
208: 
209:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
210:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
211:                 .FontBold      = .T.
212:                 .FontName      = "Tahoma"
213:                 .FontSize      = 18
214:                 .WordWrap      = .T.
215:                 .Alignment     = 0
216:                 .BackStyle     = 0
217:                 .AutoSize      = .F.
218:                 .Caption       = THIS.Caption
219:                 .Height        = 46
220:                 .Left          = 10
221:                 .Top           = 24
222:                 .Width         = 660
223:                 .ForeColor     = RGB(255, 255, 255)
224:                 .ToolTipText   = "T" + CHR(237) + "tulo"
225:                 .Visible       = .T.
226:             ENDWITH

*-- Linhas 232 a 261:
232:     ENDPROC
233: 
234:     *==========================================================================
235:     * ConfigurarBotoes - Cria cmd_4c_Repetir, Inserir, Excluir, Encerrar
236:     * Original (1075px): Repetir=770, Inserir=846, Excluir=922, Sair=998
237:     * Escalado (1000px): Repetir=680, Inserir=760, Excluir=840, Encerrar=920
238:     * Todos ficam dentro do cnt_4c_Cabecalho (Top=3, sobrepostos)
239:     *==========================================================================
240:     PROTECTED PROCEDURE ConfigurarBotoes()
241:         LOCAL loc_lVis, loc_oErro
242:         loc_lVis = THIS.this_lModoEdicao
243: 
244:         TRY
245:             *-- cmd_4c_Repetir (original cmdRepetir, Left=770->680)
246:             THIS.AddObject("cmd_4c_Repetir", "CommandButton")
247:             WITH THIS.cmd_4c_Repetir
248:                 .Top             = 3
249:                 .Left            = 680
250:                 .Width           = 75
251:                 .Height          = 75
252:                 .Caption         = "Repetir"
253:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
254:                 .ToolTipText     = "Repetir Fornecedor"
255:                 .FontName        = "Comic Sans MS"
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .FontSize        = 8
259:                 .ForeColor       = RGB(90, 90, 90)
260:                 .BackColor       = RGB(255, 255, 255)
261:                 .Themes          = .T.

*-- Linhas 271 a 300:
271:             *-- ShpRepetir: shape decorativo ao redor do botao Repetir
272:             THIS.AddObject("shp_4c_ShpRepetir", "Shape")
273:             WITH THIS.shp_4c_ShpRepetir
274:                 .Top         = 1
275:                 .Left        = 677
276:                 .Width       = 81
277:                 .Height      = 80
278:                 .BackStyle   = 0
279:                 .BorderStyle = 0
280:                 .BorderColor = RGB(136, 189, 188)
281:                 .Visible     = loc_lVis
282:             ENDWITH
283: 
284:             *-- cmd_4c_Inserir (original cmdInserir, Left=846->760)
285:             THIS.AddObject("cmd_4c_Inserir", "CommandButton")
286:             WITH THIS.cmd_4c_Inserir
287:                 .Top             = 3
288:                 .Left            = 760
289:                 .Width           = 75
290:                 .Height          = 75
291:                 .Caption         = "Inserir"
292:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
293:                 .ToolTipText     = "Inserir Fornecedor"
294:                 .FontName        = "Comic Sans MS"
295:                 .FontBold        = .T.
296:                 .FontItalic      = .T.
297:                 .FontSize        = 8
298:                 .ForeColor       = RGB(90, 90, 90)
299:                 .BackColor       = RGB(255, 255, 255)
300:                 .Themes          = .T.

*-- Linhas 307 a 326:
307:                 .Enabled         = loc_lVis
308:             ENDWITH
309: 
310:             *-- cmd_4c_Excluir (original cmdExcluir, Left=922->840)
311:             THIS.AddObject("cmd_4c_Excluir", "CommandButton")
312:             WITH THIS.cmd_4c_Excluir
313:                 .Top             = 3
314:                 .Left            = 840
315:                 .Width           = 75
316:                 .Height          = 75
317:                 .Caption         = "Excluir"
318:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
319:                 .ToolTipText     = "Excluir Fornecedor"
320:                 .FontName        = "Comic Sans MS"
321:                 .FontBold        = .T.
322:                 .FontItalic      = .T.
323:                 .FontSize        = 8
324:                 .ForeColor       = RGB(90, 90, 90)
325:                 .BackColor       = RGB(255, 255, 255)
326:                 .Themes          = .T.

*-- Linhas 333 a 352:
333:                 .Enabled         = loc_lVis
334:             ENDWITH
335: 
336:             *-- cmd_4c_Encerrar (original cmdSair, Left=998->920)
337:             THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
338:             WITH THIS.cmd_4c_Encerrar
339:                 .Top             = 3
340:                 .Left            = 920
341:                 .Width           = 75
342:                 .Height          = 75
343:                 .Caption         = "Encerrar"
344:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
345:                 .Cancel          = .T.
346:                 .FontName        = "Comic Sans MS"
347:                 .FontBold        = .T.
348:                 .FontItalic      = .T.
349:                 .FontSize        = 8
350:                 .ForeColor       = RGB(90, 90, 90)
351:                 .BackColor       = RGB(255, 255, 255)
352:                 .Themes          = .T.

*-- Linhas 362 a 371:
362:             *-- Shape1: separador decorativo (original Shape1 Top=5, Left=816, W=7, H=22)
363:             THIS.AddObject("shp_4c_Shape1", "Shape")
364:             WITH THIS.shp_4c_Shape1
365:                 .Top         = 5
366:                 .Left        = 757
367:                 .Width       = 7
368:                 .Height      = 22
369:                 .BackStyle   = 0
370:                 .BorderStyle = 0
371:                 .BorderColor = RGB(136, 189, 188)

*-- Linhas 381 a 403:
381: 
382:     *==========================================================================
383:     * TornarControlesVisiveis - Recursivamente torna controles visiveis
384:     * EXCECAO: shp_4c_ShpRepetir e cmd_4c_Repetir controlados por this_lModoEdicao
385:     *==========================================================================
386:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
387:         LOCAL loc_i, loc_oControl
388: 
389:         FOR loc_i = 1 TO par_oContainer.ControlCount
390:             loc_oControl = par_oContainer.Controls(loc_i)
391:             IF VARTYPE(loc_oControl) = "O"
392:                 *-- Controles cuja visibilidade depende do modo (nao alterar aqui)
393:                 IF INLIST(UPPER(loc_oControl.Name), ;
394:                           "CMD_4C_REPETIR", ;
395:                           "SHP_4C_SHPREPETIR", ;
396:                           "CMD_4C_INSERIR", ;
397:                           "CMD_4C_EXCLUIR", ;
398:                           "LBL_4C_LBLQTDE", ;
399:                           "TXT_4C_QTDE", ;
400:                           "SHP_4C_SHPQTDE", ;
401:                           "CNT_4C_CABECALHO")
402:                     LOOP
403:                 ENDIF

*-- Linhas 457 a 466:
457:             THIS.AddObject("grd_4c_Dados", "Grid")
458:             loc_oGrid = THIS.grd_4c_Dados
459:             WITH loc_oGrid
460:                 .Top                = 129
461:                 .Left               = 8
462:                 .Width              = 960
463:                 .Height             = 462
464:                 .ColumnCount        = 10
465:                 .FontName           = "Tahoma"
466:                 .FontSize           = 8

*-- Linhas 489 a 497:
489:                 .ReadOnly      = !THIS.this_lModoEdicao
490:             ENDWITH
491:             WITH loc_oGrid.Column1.Header1
492:                 .Caption   = "C" + CHR(243) + "digo"
493:                 .Alignment = 2
494:                 .FontName  = "Tahoma"
495:                 .FontSize  = 8
496:                 .ForeColor = RGB(90, 90, 90)
497:             ENDWITH

*-- Linhas 508 a 516:
508:                 .ReadOnly      = !THIS.this_lModoEdicao
509:             ENDWITH
510:             WITH loc_oGrid.Column2.Header1
511:                 .Caption   = "Raz" + CHR(227) + "o Social"
512:                 .Alignment = 2
513:                 .FontName  = "Tahoma"
514:                 .FontSize  = 8
515:                 .ForeColor = RGB(90, 90, 90)
516:             ENDWITH

*-- Linhas 527 a 535:
527:                 .ReadOnly      = !THIS.this_lModoEdicao
528:             ENDWITH
529:             WITH loc_oGrid.Column3.Header1
530:                 .Caption   = "Ref. Fornecedor"
531:                 .Alignment = 2
532:                 .FontName  = "Tahoma"
533:                 .FontSize  = 8
534:                 .ForeColor = RGB(90, 90, 90)
535:             ENDWITH

*-- Linhas 552 a 560:
552:                 .Margin      = 0
553:             ENDWITH
554:             WITH loc_oGrid.Column4.Header1
555:                 .Caption   = "Moe"
556:                 .Alignment = 2
557:                 .FontName  = "Tahoma"
558:                 .FontSize  = 8
559:                 .ForeColor = RGB(90, 90, 90)
560:             ENDWITH

*-- Linhas 580 a 588:
580:                 .Margin      = 0
581:             ENDWITH
582:             WITH loc_oGrid.Column5.Header1
583:                 .Caption   = "Pre" + CHR(231) + "o de Custo"
584:                 .Alignment = 2
585:                 .FontName  = "Tahoma"
586:                 .FontSize  = 8
587:                 .ForeColor = RGB(90, 90, 90)
588:             ENDWITH

*-- Linhas 606 a 647:
606:                 .NullDisplay = "  /  /    "
607:             ENDWITH
608:             WITH loc_oGrid.Column6.Header1
609:                 .Caption   = "Validade"
610:                 .Alignment = 2
611:                 .FontName  = "Tahoma"
612:                 .FontSize  = 8
613:                 .ForeColor = RGB(90, 90, 90)
614:             ENDWITH
615: 
616:             *-- Column7: Situas (S - CheckBox) ColumnOrder=10
617:             WITH loc_oGrid.Column7
618:                 .Width         = 16
619:                 .ColumnOrder   = 10
620:                 .FontName      = "Tahoma"
621:                 .FontSize      = 8
622:                 .Sparse        = .F.
623:                 .ControlSource = "crSigPrFnc.Situas"
624:                 .ReadOnly      = !THIS.this_lModoEdicao
625:             ENDWITH
626:             loc_oGrid.Column7.AddObject("Check1", "CheckBox")
627:             WITH loc_oGrid.Column7
628:                 .CurrentControl = "Check1"
629:             ENDWITH
630:             WITH loc_oGrid.Column7.Check1
631:                 .Caption   = ""
632:                 .Alignment = 0
633:                 .ReadOnly  = .F.
634:                 .Visible   = .T.
635:                 .Top       = 9
636:                 .Left      = 2
637:                 .Height    = 17
638:                 .Width     = 22
639:                 .Value     = 0
640:             ENDWITH
641:             WITH loc_oGrid.Column7.Header1
642:                 .Caption   = "S"
643:                 .Alignment = 2
644:                 .FontName  = "Tahoma"
645:                 .FontSize  = 8
646:                 .ForeColor = RGB(90, 90, 90)
647:             ENDWITH

*-- Linhas 664 a 672:
664:                 .Margin      = 0
665:             ENDWITH
666:             WITH loc_oGrid.Column8.Header1
667:                 .Caption   = "Grupo Venda"
668:                 .Alignment = 2
669:                 .FontName  = "Tahoma"
670:                 .FontSize  = 8
671:                 .ForeColor = RGB(90, 90, 90)
672:             ENDWITH

*-- Linhas 689 a 697:
689:                 .Margin      = 0
690:             ENDWITH
691:             WITH loc_oGrid.Column9.Header1
692:                 .Caption   = "Cor"
693:                 .Alignment = 2
694:                 .FontName  = "Tahoma"
695:                 .FontSize  = 8
696:                 .ForeColor = RGB(90, 90, 90)
697:             ENDWITH

*-- Linhas 714 a 722:
714:                 .Margin      = 0
715:             ENDWITH
716:             WITH loc_oGrid.Column10.Header1
717:                 .Caption   = "Tam"
718:                 .Alignment = 2
719:                 .FontName  = "Tahoma"
720:                 .FontSize  = 8
721:                 .ForeColor = RGB(90, 90, 90)
722:             ENDWITH

*-- Linhas 739 a 773:
739:         TRY
740:             THIS.AddObject("shp_4c_ShpQtde", "Shape")
741:             WITH THIS.shp_4c_ShpQtde
742:                 .Top         = 90
743:                 .Left        = 588
744:                 .Width       = 123
745:                 .Height      = 30
746:                 .BackStyle   = 0
747:                 .BorderStyle = 0
748:                 .Visible     = .F.
749:             ENDWITH
750: 
751:             THIS.AddObject("lbl_4c_LblQtde", "Label")
752:             WITH THIS.lbl_4c_LblQtde
753:                 .Top       = 97
754:                 .Left      = 595
755:                 .Width     = 73
756:                 .Height    = 16
757:                 .Caption   = "Quantidade :"
758:                 .FontName  = "Tahoma"
759:                 .FontSize  = 8
760:                 .BackStyle = 0
761:                 .ForeColor = RGB(90, 90, 90)
762:                 .Visible   = .F.
763:             ENDWITH
764: 
765:             THIS.AddObject("txt_4c_Qtde", "TextBox")
766:             WITH THIS.txt_4c_Qtde
767:                 .Top           = 94
768:                 .Left          = 669
769:                 .Width         = 36
770:                 .Height        = 23
771:                 .Value         = 0
772:                 .FontName      = "Tahoma"
773:                 .FontSize      = 8

*-- Linhas 837 a 845:
837:                          "Aten" + CHR(231) + CHR(227) + "o")
838:                 RETURN
839:             ENDIF
840:             THIS.lbl_4c_LblQtde.Visible = .T.
841:             THIS.txt_4c_Qtde.Visible    = .T.
842:             THIS.shp_4c_ShpQtde.Visible = .T.
843:             THIS.txt_4c_Qtde.Value      = 0
844:             THIS.txt_4c_Qtde.SetFocus()
845:         CATCH TO loc_oErro

*-- Linhas 897 a 905:
897:                 THIS.grd_4c_Dados.Refresh()
898:             ENDIF
899: 
900:             THIS.lbl_4c_LblQtde.Visible = .F.
901:             THIS.shp_4c_ShpQtde.Visible  = .F.
902:             THIS.txt_4c_Qtde.Visible     = .F.
903: 
904:             IF USED("crSigPrFnc")
905:                 SELECT crSigPrFnc

*-- Linhas 919 a 927:
919:         LOCAL loc_oErro
920: 
921:         TRY
922:             THIS.lbl_4c_LblQtde.Visible = .F.
923:             THIS.shp_4c_ShpQtde.Visible  = .F.
924:             THIS.txt_4c_Qtde.Visible     = .F.
925:             IF USED("crSigPrFnc")
926:                 SELECT crSigPrFnc
927:                 THIS.grd_4c_Dados.Column1.SetFocus()

*-- Linhas 1431 a 1447:
1431:         LOCAL loc_oErro
1432: 
1433:         TRY
1434:             THIS.cmd_4c_Inserir.Visible      = THIS.this_lModoEdicao
1435:             THIS.cmd_4c_Inserir.Enabled      = THIS.this_lModoEdicao
1436:             THIS.cmd_4c_Excluir.Visible      = THIS.this_lModoEdicao
1437:             THIS.cmd_4c_Excluir.Enabled      = THIS.this_lModoEdicao
1438:             THIS.cmd_4c_Repetir.Visible      = THIS.this_lModoEdicao
1439:             THIS.cmd_4c_Repetir.Enabled      = THIS.this_lModoEdicao
1440:             THIS.shp_4c_ShpRepetir.Visible   = THIS.this_lModoEdicao
1441:             THIS.cmd_4c_Encerrar.Visible     = .T.
1442:             THIS.cmd_4c_Encerrar.Enabled     = .T.
1443:         CATCH TO loc_oErro
1444:             MsgErro(loc_oErro.Message + CHR(13) + ;
1445:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1446:                     "Procedure: " + loc_oErro.Procedure, "Erro em AjustarBotoesPorModo")
1447:         ENDTRY


### BO (C:\4c\projeto\app\classes\FopBO.prg):
*==============================================================================
* FopBO.prg - Business Object para Fornecedores do Produto
* Tabela   : SigPrFnc
* Herda de : BusinessBase
* Migrado de: SIGCDFOP.SCX (task421)
*==============================================================================
DEFINE CLASS FopBO AS BusinessBase

    *---------------------------------------------------------------------------
    *-- Campos da tabela SigPrFnc (schema.sql)
    *---------------------------------------------------------------------------
    this_cCidChaves  = ""   && PK char(20)
    this_cCpros      = ""   && Produto char(14) - FK SigCdPro
    this_cIfors      = ""   && Fornecedor char(10) - FK SigCdCli
    this_cRClis      = ""   && Razao Social (JOIN SigCdCli - exibicao, nao persistido)
    this_cReffs      = ""   && Referencia do Fornecedor char(40)
    this_cMoevs      = ""   && Moeda char(3) - FK SigCdMoe
    this_nPvens      = 0    && Preco de Custo numeric(10,2)
    this_dDtvalid    = {}   && Validade datetime NULL
    this_nSituas     = 0    && Situacao numeric(1,0) - checkbox (Situas)
    this_cColecoes   = ""   && Grupo Venda char(10) - FK SigCdCol
    this_cCodcors    = ""   && Cor char(4) - FK SigCdCor
    this_cCodtams    = ""   && Tamanho char(4) - FK SigCdTam

    *---------------------------------------------------------------------------
    *-- Estado operacional do formulario
    *---------------------------------------------------------------------------
    this_cCprosAtivo = ""   && Codigo do produto em edicao
    this_lHouveIncl  = .F.  && Houve inclusoes nesta sessao
    this_lHouveExcl  = .F.  && Houve exclusoes nesta sessao
    this_cModoAtual  = ""   && Modo atual: INSERIR / ALTERAR / VISUALIZAR

    *===========================================================================
    PROCEDURE Init()
    *===========================================================================
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrFnc"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em FopBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
    *===========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *===========================================================================
    PROCEDURE BuscarPorProduto(par_cCpros)
    *===========================================================================
    * Carrega fornecedores do produto do SQL Server para cursor crSigPrFnc.
    * O cursor inclui coluna lNovo (.F. para registros ja existentes no DB).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cCPros, loc_cIfors, loc_cRClis
        LOCAL loc_cReffs, loc_cMoevs, loc_nPvens, loc_dDtvalid
        LOCAL loc_nSituas, loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF

            loc_cSQL = "SELECT a.CidChaves, a.cPros, a.iFors, " + ;
                       "ISNULL(b.rClis, '') AS rClis, " + ;
                       "a.Reffs, a.MoeVs, a.PVens, a.DtValid, " + ;
                       "a.Situas, a.Colecoes, a.CodCors, a.CodTams " + ;
                       "FROM SigPrFnc a " + ;
                       "LEFT JOIN SigCdCli b ON b.iClis = a.iFors " + ;
                       "WHERE a.cPros = " + EscaparSQL(par_cCpros)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrFncTemp")

            IF loc_nRet < 0
                MsgErro("Erro ao carregar fornecedores do produto.", "Erro em BuscarPorProduto")
            ELSE
                IF USED("crSigPrFnc")
                    TABLEREVERT(.T., "crSigPrFnc")
                    USE IN crSigPrFnc
                ENDIF

                SET NULL ON
                CREATE CURSOR crSigPrFnc ;
                    (CidChaves C(20) NULL, cPros C(14) NULL, iFors C(10) NULL, ;
                     rClis C(50) NULL, Reffs C(40) NULL, MoeVs C(3) NULL, ;
                     PVens N(10,2) NULL, DtValid T NULL, Situas N(1,0) NULL, ;
                     Colecoes C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     lNovo L)
                SET NULL OFF

                SELECT crSigPrFncTemp
                GO TOP
                SCAN
                    loc_cCidChaves = NVL(crSigPrFncTemp.CidChaves, "")
                    loc_cCPros     = NVL(crSigPrFncTemp.cPros, "")
                    loc_cIfors     = NVL(crSigPrFncTemp.iFors, "")
                    loc_cRClis     = NVL(crSigPrFncTemp.rClis, "")
                    loc_cReffs     = NVL(crSigPrFncTemp.Reffs, "")
                    loc_cMoevs     = NVL(crSigPrFncTemp.MoeVs, "")
                    loc_nPvens     = NVL(crSigPrFncTemp.PVens, 0)
                    loc_dDtvalid   = crSigPrFncTemp.DtValid
                    loc_nSituas    = NVL(crSigPrFncTemp.Situas, 0)
                    loc_cColecoes  = NVL(crSigPrFncTemp.Colecoes, "")
                    loc_cCodcors   = NVL(crSigPrFncTemp.CodCors, "")
                    loc_cCodtams   = NVL(crSigPrFncTemp.CodTams, "")

                    SELECT crSigPrFnc
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cCidChaves, ;
                            cPros     WITH loc_cCPros, ;
                            iFors     WITH loc_cIfors, ;
                            rClis     WITH loc_cRClis, ;
                            Reffs     WITH loc_cReffs, ;
                            MoeVs     WITH loc_cMoevs, ;
                            PVens     WITH loc_nPvens, ;
                            DtValid   WITH loc_dDtvalid, ;
                            Situas    WITH loc_nSituas, ;
                            Colecoes  WITH loc_cColecoes, ;
                            CodCors   WITH loc_cCodcors, ;
                            CodTams   WITH loc_cCodtams, ;
                            lNovo     WITH .F.

                    SELECT crSigPrFncTemp
                ENDSCAN

                USE IN crSigPrFncTemp

                SELECT crSigPrFnc
                GO TOP

                THIS.this_cCprosAtivo = par_cCpros
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em BuscarPorProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE InserirLinha(par_cCpros)
    *===========================================================================
    * Adiciona linha em branco ao cursor crSigPrFnc (ainda nao persiste no DB).
    * Replica cmdInserir.Click: localiza linha vazia existente, senao append.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cChave, loc_lAchou

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                MsgErro("Cursor crSigPrFnc n" + CHR(227) + "o inicializado.", "Erro em InserirLinha")
            ELSE
                SELECT crSigPrFnc
                SET EXACT ON
                LOCATE FOR ALLTRIM(cPros) == ALLTRIM(par_cCpros) AND EMPTY(iFors) AND !DELETED()
                loc_lAchou = !EOF()

                IF !loc_lAchou
                    loc_cChave = THIS.GerarCidChaves()
                    APPEND BLANK
                    REPLACE CidChaves WITH loc_cChave, ;
                            cPros     WITH par_cCpros, ;
                            iFors     WITH "", ;
                            rClis     WITH "", ;
                            Reffs     WITH "", ;
                            MoeVs     WITH "", ;
                            PVens     WITH 0, ;
                            Situas    WITH 0, ;
                            Colecoes  WITH "", ;
                            CodCors   WITH "", ;
                            CodTams   WITH "", ;
                            lNovo     WITH .T.
                    THIS.this_lHouveIncl = .T.
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em InserirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ExcluirLinha()
    *===========================================================================
    * Marca a linha corrente do cursor para exclusao (replica cmdExcluir.Click).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF !EOF() AND ALLTRIM(cPros) == ALLTRIM(THIS.this_cCprosAtivo) AND !DELETED()
                    DELETE
                    SKIP
                    SKIP - 1
                    THIS.this_lHouveExcl = .T.
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExcluirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE RepetirLinha(par_nVezes)
    *===========================================================================
    * Duplica a linha corrente do cursor N vezes (replica getQtde.Valid).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_i, loc_cChave
        LOCAL loc_cIfors, loc_cRClis, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams, loc_cCpros

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                SELECT crSigPrFnc
                IF EMPTY(iFors)
                    MsgAviso("Selecione um registro para ser repetido.", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cRClis    = ALLTRIM(rClis)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cMoevs    = ALLTRIM(MoeVs)
                    loc_nPvens    = NVL(PVens, 0)
                    loc_dDtvalid  = DtValid
                    loc_nSituas   = NVL(Situas, 0)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_cCodcors  = ALLTRIM(CodCors)
                    loc_cCodtams  = ALLTRIM(CodTams)
                    loc_cCpros    = ALLTRIM(cPros)

                    FOR loc_i = 1 TO par_nVezes
                        loc_cChave = THIS.GerarCidChaves()
                        SELECT crSigPrFnc
                        APPEND BLANK
                        REPLACE CidChaves WITH loc_cChave, ;
                                cPros     WITH loc_cCpros, ;
                                iFors     WITH loc_cIfors, ;
                                rClis     WITH loc_cRClis, ;
                                Reffs     WITH loc_cReffs, ;
                                MoeVs     WITH loc_cMoevs, ;
                                PVens     WITH loc_nPvens, ;
                                DtValid   WITH loc_dDtvalid, ;
                                Situas    WITH loc_nSituas, ;
                                Colecoes  WITH loc_cColecoes, ;
                                CodCors   WITH loc_cCodcors, ;
                                CodTams   WITH loc_cCodtams, ;
                                lNovo     WITH .T.
                    ENDFOR

                    THIS.this_lHouveIncl = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em RepetirLinha")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE ValidarCursor(par_cModo)
    *===========================================================================
    * Valida todas as linhas do cursor antes de salvar (replica cmdSair.Click).
    * Retorna .T. se valido, .F. se invalido (com MsgAviso ao usuario).
    *---------------------------------------------------------------------------
        LOCAL loc_lValido
        LOCAL loc_cIfors, loc_cReffs, loc_cColecoes, loc_nPvens
        LOCAL loc_nDupli

        loc_lValido = .T.

        TRY
            IF USED("crSigPrFnc") AND INLIST(UPPER(par_cModo), "INSERIR", "ALTERAR")
                SELECT crSigPrFnc
                GO TOP
                SCAN
                    IF DELETED()
                        LOOP
                    ENDIF

                    IF EMPTY(iFors)
                        MsgAviso("Fornecedor deve ser informado!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(Reffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    IF EMPTY(MoeVs)
                        MsgAviso("A Moeda deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    loc_cIfors    = ALLTRIM(iFors)
                    loc_cReffs    = ALLTRIM(Reffs)
                    loc_cColecoes = ALLTRIM(Colecoes)
                    loc_nPvens    = NVL(PVens, 0)

                    SELECT COUNT(*) AS nDupli ;
                        FROM crSigPrFnc a ;
                        WHERE ALLTRIM(a.iFors)    == m.loc_cIfors ;
                          AND ALLTRIM(a.Reffs)    == m.loc_cReffs ;
                          AND ALLTRIM(a.Colecoes) == m.loc_cColecoes ;
                          AND NVL(a.PVens, 0)      = m.loc_nPvens ;
                          AND !DELETED() ;
                        INTO CURSOR crAuxDupli READWRITE

                    SELECT crAuxDupli
                    loc_nDupli = NVL(crAuxDupli.nDupli, 0)
                    USE IN crAuxDupli

                    IF loc_nDupli > 1
                        MsgAviso("Fornecedor j" + CHR(225) + " informado para este produto!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lValido = .F.
                        EXIT
                    ENDIF

                    SELECT crSigPrFnc
                ENDSCAN

                SELECT crSigPrFnc
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ValidarCursor")
            loc_lValido = .F.
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *===========================================================================
    PROCEDURE SalvarAlteracoes(par_cCpros)
    *===========================================================================
    * Persiste as alteracoes do cursor crSigPrFnc no SQL Server.
    * Estrategia: DELETE todos existentes para o produto + INSERT os nao-deletados.
    * Isso replica o comportamento do fSqlConector.ReQuery do legado.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCidChaves, loc_cIfors, loc_cReffs, loc_cMoevs
        LOCAL loc_nPvens, loc_dDtvalid, loc_nSituas
        LOCAL loc_cColecoes, loc_cCodcors, loc_cCodtams

        loc_lSucesso = .F.

        TRY
            IF !USED("crSigPrFnc")
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "DELETE FROM SigPrFnc WHERE cPros = " + EscaparSQL(par_cCpros)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir registros anteriores de SigPrFnc.", ;
                            "Erro em SalvarAlteracoes")
                ELSE
                    SELECT crSigPrFnc
                    GO TOP
                    SCAN
                        IF DELETED()
                            LOOP
                        ENDIF

                        loc_cCidChaves = ALLTRIM(CidChaves)
                        loc_cIfors     = ALLTRIM(iFors)
                        loc_cReffs     = ALLTRIM(Reffs)
                        loc_cMoevs     = ALLTRIM(MoeVs)
                        loc_nPvens     = NVL(PVens, 0)
                        loc_dDtvalid   = DtValid
                        loc_nSituas    = NVL(Situas, 0)
                        loc_cColecoes  = ALLTRIM(Colecoes)
                        loc_cCodcors   = ALLTRIM(CodCors)
                        loc_cCodtams   = ALLTRIM(CodTams)

                        loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                   "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                   "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cCidChaves) + ", " + ;
                                   EscaparSQL(par_cCpros) + ", " + ;
                                   EscaparSQL(loc_cIfors) + ", " + ;
                                   EscaparSQL(loc_cReffs) + ", " + ;
                                   EscaparSQL(loc_cMoevs) + ", " + ;
                                   FormatarNumeroSQL(loc_nPvens, 2) + ", " + ;
                                   IIF(ISNULL(loc_dDtvalid) OR EMPTY(loc_dDtvalid), ;
                                       "NULL", FormatarDataSQL(loc_dDtvalid)) + ", " + ;
                                   FormatarNumeroSQL(loc_nSituas, 0) + ", " + ;
                                   EscaparSQL(loc_cColecoes) + ", " + ;
                                   EscaparSQL(loc_cCodcors) + ", " + ;
                                   EscaparSQL(loc_cCodtams) + ")"

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nRet < 0
                            MsgErro("Erro ao inserir fornecedor " + loc_cIfors + " em SigPrFnc.", ;
                                    "Erro em SalvarAlteracoes")
                            EXIT
                        ENDIF

                        SELECT crSigPrFnc
                    ENDSCAN

                    IF loc_nRet >= 0
                        SELECT crSigPrFnc
                        GO TOP
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em SalvarAlteracoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE CarregarDoCursor(par_cAlias)
    *===========================================================================
    * Mapeia campos do cursor para propriedades do BO.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAlias)
                SELECT (par_cAlias)
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                THIS.this_cCpros     = TratarNulo(cPros, "C")
                THIS.this_cIfors     = TratarNulo(iFors, "C")
                THIS.this_cRClis     = TratarNulo(rClis, "C")
                THIS.this_cReffs     = TratarNulo(Reffs, "C")
                THIS.this_cMoevs     = TratarNulo(MoeVs, "C")
                THIS.this_nPvens     = NVL(PVens, 0)
                THIS.this_dDtvalid   = NVL(DtValid, {})
                THIS.this_nSituas    = NVL(Situas, 0)
                THIS.this_cColecoes  = TratarNulo(Colecoes, "C")
                THIS.this_cCodcors   = TratarNulo(CodCors, "C")
                THIS.this_cCodtams   = TratarNulo(CodTams, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED FUNCTION GerarCidChaves()
    *===========================================================================
    * Gera chave unica de 20 chars para CidChaves (replica fUniqueIds do legado).
    * Usa NEWID() do SQL Server (GUID sem hifens, truncado em 20 chars).
    *---------------------------------------------------------------------------
        LOCAL loc_cChave

        loc_cChave = ""

        TRY
            IF SQLEXEC(gnConnHandle, ;
                       "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS nk", ;
                       "crChaveTemp") > 0
                SELECT crChaveTemp
                loc_cChave = ALLTRIM(TRANSFORM(crChaveTemp.nk))
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            * Fallback local se SQL Server nao disponivel
        ENDTRY

        IF EMPTY(loc_cChave)
            loc_cChave = LEFT(STRTRAN(STRTRAN(STRTRAN(TRANSFORM(DATETIME()), "/", ""), " ", ""), ":", "") + ;
                              SYS(3) + SYS(3), 20)
        ENDIF

        RETURN loc_cChave
    ENDPROC

    *===========================================================================
    PROCEDURE Inserir()
    *===========================================================================
    * Insere UM registro individual de SigPrFnc usando as propriedades this_*.
    * Chamado internamente por SalvarAlteracoes ou standalone via CarregarDoCursor.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_cChave

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCpros)
                MsgAviso("Produto n" + CHR(227) + "o informado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cChave = ALLTRIM(THIS.this_cCidChaves)
                            IF EMPTY(loc_cChave)
                                loc_cChave = THIS.GerarCidChaves()
                                THIS.this_cCidChaves = loc_cChave
                            ENDIF

                            loc_cSQL = "INSERT INTO SigPrFnc " + ;
                                       "(CidChaves, cPros, iFors, Reffs, MoeVs, " + ;
                                       "PVens, DtValid, Situas, Colecoes, CodCors, CodTams) " + ;
                                       "VALUES (" + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cIfors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cReffs)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cMoevs)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nPvens, 2) + ", " + ;
                                       IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       FormatarNumeroSQL(THIS.this_nSituas, 0) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodcors)) + ", " + ;
                                       EscaparSQL(ALLTRIM(THIS.this_cCodtams)) + ")"

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao inserir fornecedor do produto no SQL Server.", ;
                                        "Erro em Inserir")
                            ELSE
                                THIS.RegistrarAuditoria("INCLUSAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE Atualizar()
    *===========================================================================
    * Atualiza UM registro individual de SigPrFnc pela chave primaria CidChaves.
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada. N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
                        "vel atualizar.", "Erro em Atualizar")
            ELSE
                IF EMPTY(THIS.this_cIfors)
                    MsgAviso("Fornecedor deve ser informado!", ;
                             "Aten" + CHR(231) + CHR(227) + "o")
                ELSE
                    IF EMPTY(THIS.this_cReffs)
                        MsgAviso("A refer" + CHR(234) + "ncia do fornecedor deve ser informada!", ;
                                 "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        IF EMPTY(THIS.this_cMoevs)
                            MsgAviso("A Moeda deve ser informada!", ;
                                     "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            loc_cSQL = "UPDATE SigPrFnc SET " + ;
                                       "cPros = "    + EscaparSQL(ALLTRIM(THIS.this_cCpros))    + ", " + ;
                                       "iFors = "    + EscaparSQL(ALLTRIM(THIS.this_cIfors))    + ", " + ;
                                       "Reffs = "    + EscaparSQL(ALLTRIM(THIS.this_cReffs))    + ", " + ;
                                       "MoeVs = "    + EscaparSQL(ALLTRIM(THIS.this_cMoevs))    + ", " + ;
                                       "PVens = "    + FormatarNumeroSQL(THIS.this_nPvens, 2)   + ", " + ;
                                       "DtValid = "  + IIF(ISNULL(THIS.this_dDtvalid) OR EMPTY(THIS.this_dDtvalid), ;
                                                           "NULL", FormatarDataSQL(THIS.this_dDtvalid)) + ", " + ;
                                       "Situas = "   + FormatarNumeroSQL(THIS.this_nSituas, 0)  + ", " + ;
                                       "Colecoes = " + EscaparSQL(ALLTRIM(THIS.this_cColecoes)) + ", " + ;
                                       "CodCors = "  + EscaparSQL(ALLTRIM(THIS.this_cCodcors))  + ", " + ;
                                       "CodTams = "  + EscaparSQL(ALLTRIM(THIS.this_cCodtams))  + " " + ;
                                       "WHERE CidChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                            IF loc_nRet < 0
                                MsgErro("Erro ao atualizar fornecedor do produto no SQL Server.", ;
                                        "Erro em Atualizar")
                            ELSE
                                THIS.RegistrarAuditoria("ALTERACAO")
                                loc_lSucesso = .T.
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
    *===========================================================================
    * Executa DELETE de UM registro individual pela chave CidChaves.
    * Chamado por BusinessBase.Excluir() (PUBLIC).
    *---------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave prim" + CHR(225) + "ria (CidChaves) n" + CHR(227) + ;
                        "o informada.", "Erro em ExecutarExclusao")
            ELSE
                THIS.RegistrarAuditoria("EXCLUSAO")

                loc_cSQL = "DELETE FROM SigPrFnc WHERE CidChaves = " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRet < 0
                    MsgErro("Erro ao excluir fornecedor do produto no SQL Server.", ;
                            "Erro em ExecutarExclusao")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    PROCEDURE LiberarCursores()
    *===========================================================================
    * Libera todos os cursores do BO. Chamar no Destroy do Form.
    *---------------------------------------------------------------------------
        TRY
            IF USED("crSigPrFnc")
                TABLEREVERT(.T., "crSigPrFnc")
                USE IN crSigPrFnc
            ENDIF
            IF USED("crSigPrFncTemp")
                USE IN crSigPrFncTemp
            ENDIF
            IF USED("crAuxDupli")
                USE IN crAuxDupli
            ENDIF
            IF USED("crChaveTemp")
                USE IN crChaveTemp
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em LiberarCursores")
        ENDTRY
    ENDPROC

ENDDEFINE

