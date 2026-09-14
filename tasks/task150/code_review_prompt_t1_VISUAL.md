# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdMp9.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2179 linhas total):

*-- Linhas 221 a 282:
221:     * ConfigurarCabecalho - Container de titulo com efeito sombra
222:     *==========================================================================
223:     PROTECTED PROCEDURE ConfigurarCabecalho()
224:         LOCAL loc_cTitulo
225:         loc_cTitulo = "Pesagem de Pe" + CHR(231) + "as"
226:         THIS.AddObject("cnt_4c_Sombra", "Container")
227:         WITH THIS.cnt_4c_Sombra
228:             .Top         = 0
229:             .Left        = 0
230:             .Width       = 1100
231:             .Height      = 80
232:             .BorderWidth = 0
233:             .BackColor   = RGB(100, 100, 100)
234:             .AddObject("lbl_4c_Sombra", "Label")
235:             WITH .lbl_4c_Sombra
236:                 .FontBold   = .T.
237:                 .FontName   = "Tahoma"
238:                 .FontSize   = 18
239:                 .WordWrap   = .T.
240:                 .Alignment  = 0
241:                 .BackStyle  = 0
242:                 .Caption    = loc_cTitulo
243:                 .Height     = 40
244:                 .Left       = 10
245:                 .Top        = 18
246:                 .Width      = THIS.Width
247:                 .ForeColor  = RGB(0, 0, 0)
248:                 .Visible    = .T.
249:             ENDWITH
250:             .AddObject("lbl_4c_Titulo", "Label")
251:             WITH .lbl_4c_Titulo
252:                 .FontBold   = .T.
253:                 .FontName   = "Tahoma"
254:                 .FontSize   = 18
255:                 .WordWrap   = .T.
256:                 .Alignment  = 0
257:                 .BackStyle  = 0
258:                 .Caption    = loc_cTitulo
259:                 .Height     = 46
260:                 .Left       = 10
261:                 .Top        = 17
262:                 .Width      = THIS.Width
263:                 .ForeColor  = RGB(255, 255, 255)
264:                 .Visible    = .T.
265:             ENDWITH
266:             .Visible = .T.
267:         ENDWITH
268:     ENDPROC
269: 
270:     *==========================================================================
271:     * ConfigurarPaginaLista - Configura a "pagina" principal do form OPERACIONAL
272:     * Em forms OPERACIONAIS nao ha PageFrame Page1/Page2 como nos CRUD.
273:     * Esta procedure agrupa Grid (lista de pecas) e Rodape (botoes de acao):
274:     *   - cmd_4c_Resumo    - Abre janela de resumo (SigPdM10)
275:     *   - cmd_4c_CustoP    - Visualiza custos do produto (apenas com permissao)
276:     *   - cmd_4c_Processar - Confirma pesagem e segue para SigPdM11
277:     *   - cmd_4c_Cancelar  - Cancela e fecha o form
278:     * O legado nao usa botoes CRUD (Incluir/Alterar/Excluir/Buscar) porque
279:     * a pesagem ja recebe a lista de pecas pronta do form pai.
280:     *==========================================================================
281:     PROTECTED PROCEDURE ConfigurarPaginaLista()
282:         THIS.ConfigurarGrid()

*-- Linhas 344 a 357:
344:             .DeleteMark        = .F.
345:             .RecordMark        = .F.
346:             .Height            = 463
347:             .Left              = 10
348:             .Panel             = 1
349:             .RowHeight         = 17
350:             .ScrollBars        = 2
351:             .TabIndex          = 1
352:             .Top               = 111
353:             .Width             = 980
354:             .GridLineColor     = RGB(238, 238, 238)
355:             .ReadOnly          = loc_lTrfPesas
356: 
357:             *-- Column1: Produto (Cpros) - ReadOnly

*-- Linhas 363 a 371:
363:                 .Resizable         = .F.
364:                 .ReadOnly          = .T.
365:                 .FontSize          = 8
366:                 .Header1.Caption   = "Produto"
367:                 .Header1.FontName  = "Tahoma"
368:                 .Header1.FontSize  = 8
369:                 .Header1.Alignment = 2
370:                 .Text1.FontSize    = 8
371:                 .Text1.BorderStyle = 0

*-- Linhas 385 a 393:
385:                 .Resizable         = .F.
386:                 .ReadOnly          = !loc_lLibObss
387:                 .FontSize          = 8
388:                 .Header1.Caption   = "Observa" + CHR(231) + CHR(227) + "o"
389:                 .Header1.FontName  = "Tahoma"
390:                 .Header1.FontSize  = 8
391:                 .Header1.Alignment = 2
392:                 .Text1.FontSize    = 8
393:                 .Text1.BorderStyle = 0

*-- Linhas 406 a 414:
406:                 .Resizable         = .F.
407:                 .ReadOnly          = .T.
408:                 .FontSize          = 8
409:                 .Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
410:                 .Header1.FontName  = "Tahoma"
411:                 .Header1.FontSize  = 8
412:                 .Header1.Alignment = 2
413:                 .Text1.FontSize    = 8
414:                 .Text1.BorderStyle = 0

*-- Linhas 428 a 436:
428:                 .Resizable         = .F.
429:                 .ReadOnly          = .F.
430:                 .FontSize          = 8
431:                 .Header1.Caption   = "Tam"
432:                 .Header1.FontName  = "Tahoma"
433:                 .Header1.FontSize  = 8
434:                 .Header1.Alignment = 2
435:                 .Text1.FontSize    = 8
436:                 .Text1.BorderStyle = 0

*-- Linhas 454 a 462:
454:                 .FontBold          = .T.
455:                 .FontSize          = 8
456:                 .Format            = "K"
457:                 .Header1.Caption   = "Quantidade"
458:                 .Header1.FontName  = "Tahoma"
459:                 .Header1.FontSize  = 8
460:                 .Header1.Alignment = 2
461:                 .Text1.FontBold    = .T.
462:                 .Text1.FontSize    = 8

*-- Linhas 479 a 487:
479:                 .ReadOnly          = .F.
480:                 .FontBold          = .T.
481:                 .FontSize          = 8
482:                 .Header1.Caption   = "Peso"
483:                 .Header1.FontName  = "Tahoma"
484:                 .Header1.FontSize  = 8
485:                 .Header1.Alignment = 2
486:                 .Text1.FontBold    = .T.
487:                 .Text1.FontSize    = 8

*-- Linhas 504 a 512:
504:                 .Resizable         = .F.
505:                 .ReadOnly          = .F.
506:                 .FontSize          = 8
507:                 .Header1.Caption   = "Cor"
508:                 .Header1.FontName  = "Tahoma"
509:                 .Header1.FontSize  = 8
510:                 .Header1.Alignment = 2
511:                 .Text1.FontSize    = 8
512:                 .Text1.BorderStyle = 0

*-- Linhas 528 a 536:
528:                 .Resizable         = .F.
529:                 .ReadOnly          = .T.
530:                 .FontSize          = 8
531:                 .Header1.Caption   = "Barras"
532:                 .Header1.FontName  = "Tahoma"
533:                 .Header1.FontSize  = 8
534:                 .Header1.Alignment = 2
535:                 .Text1.FontSize    = 8
536:                 .Text1.BorderStyle = 0

*-- Linhas 549 a 557:
549:                 .Resizable         = .F.
550:                 .ReadOnly          = .T.
551:                 .FontSize          = 8
552:                 .Header1.Caption   = "Custo"
553:                 .Header1.FontName  = "Tahoma"
554:                 .Header1.FontSize  = 8
555:                 .Header1.Alignment = 2
556:                 .Text1.FontSize    = 8
557:                 .Text1.BorderStyle = 0

*-- Linhas 588 a 601:
588:         loc_lAcesso   = fChecaAcesso(THIS.this_cProgAcesso, "CUSTOP")
589: 
590:         *-- Label "Peso medio :"
591:         THIS.AddObject("lbl_4c_PesoMedio", "Label")
592:         WITH THIS.lbl_4c_PesoMedio
593:             .FontSize  = 8
594:             .Caption   = "Peso m" + CHR(233) + "dio :"
595:             .Left      = 49
596:             .Top       = 88
597:             .BackStyle = 0
598:             .ForeColor = RGB(90, 90, 90)
599:             .Visible   = .T.
600:         ENDWITH
601: 

*-- Linhas 607 a 711:
607:             .Value         = 0
608:             .Height        = 23
609:             .InputMask     = "999.999"
610:             .Left          = 114
611:             .TabIndex      = 6
612:             .Top           = 84
613:             .Width         = 72
614:             .ForeColor     = RGB(0, 0, 0)
615:             .Visible       = .T.
616:         ENDWITH
617:         BINDEVENT(THIS.txt_4c_PesoMedio, "LostFocus", THIS, "TxtPesoMedioValid")
618: 
619:         *-- Indicador de peca especial (caixa vermelha decorativa - Botao1 do legado)
620:         THIS.AddObject("txt_4c_Especial", "TextBox")
621:         WITH THIS.txt_4c_Especial
622:             .Height        = 20
623:             .Left          = 12
624:             .SpecialEffect = 1
625:             .ToolTipText   = "Pe" + CHR(231) + "a Especial"
626:             .Top           = 86
627:             .Width         = 27
628:             .BackColor     = RGB(255, 0, 0)
629:             .ReadOnly      = .T.
630:             .Visible       = .T.
631:         ENDWITH
632:         BINDEVENT(THIS.txt_4c_Especial, "When", THIS, "TxtEspecialWhen")
633: 
634:         *-- Botao Resumo
635:         THIS.AddObject("cmd_4c_Resumo", "CommandButton")
636:         WITH THIS.cmd_4c_Resumo
637:             .Top       = 3
638:             .Left      = 700
639:             .Height    = 75
640:             .Width     = 75
641:             .Caption   = "\<Resumo"
642:             .Themes    = .F.
643:             .ForeColor = RGB(90, 90, 90)
644:             .BackColor = RGB(255, 255, 255)
645:             IF FILE(loc_cIconPath + "geral_documento_60.jpg")
646:                 .Picture = loc_cIconPath + "geral_documento_60.jpg"
647:             ENDIF
648:             .Visible   = .T.
649:         ENDWITH
650:         BINDEVENT(THIS.cmd_4c_Resumo, "Click", THIS, "BtnResumoClick")
651: 
652:         *-- Botao CustoP (visivel apenas com permissao CUSTOP)
653:         THIS.AddObject("cmd_4c_CustoP", "CommandButton")
654:         WITH THIS.cmd_4c_CustoP
655:             .Top         = 3
656:             .Left        = 775
657:             .Height      = 75
658:             .Width       = 75
659:             .Caption     = "Cus\<tos"
660:             .ToolTipText = "Custo Produ" + CHR(231) + CHR(227) + "o"
661:             .Themes      = .F.
662:             .ForeColor   = RGB(90, 90, 90)
663:             .BackColor   = RGB(255, 255, 255)
664:             IF FILE(loc_cIconPath + "geral_calculadora_60.jpg")
665:                 .Picture = loc_cIconPath + "geral_calculadora_60.jpg"
666:             ENDIF
667:             .Visible     = loc_lAcesso
668:         ENDWITH
669:         BINDEVENT(THIS.cmd_4c_CustoP, "Click", THIS, "BtnCustoPClick")
670: 
671:         *-- Botao Processar (Confirmar)
672:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
673:         WITH THIS.cmd_4c_Processar
674:             .Top       = 3
675:             .Left      = 850
676:             .Height    = 75
677:             .Width     = 75
678:             .Caption   = "\<Confirmar"
679:             .Themes    = .F.
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackColor = RGB(255, 255, 255)
682:             IF FILE(loc_cIconPath + "cadastro_salvar_60.jpg")
683:                 .Picture = loc_cIconPath + "cadastro_salvar_60.jpg"
684:             ENDIF
685:             .Visible   = .T.
686:         ENDWITH
687:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
688: 
689:         *-- Botao Cancelar
690:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
691:         WITH THIS.cmd_4c_Cancelar
692:             .Top       = 3
693:             .Left      = 925
694:             .Height    = 75
695:             .Width     = 75
696:             .Cancel    = .T.
697:             .Caption   = "Encerrar"
698:             .Themes    = .F.
699:             .ForeColor = RGB(90, 90, 90)
700:             .BackColor = RGB(255, 255, 255)
701:             IF FILE(loc_cIconPath + "cadastro_cancelar_60.jpg")
702:                 .Picture = loc_cIconPath + "cadastro_cancelar_60.jpg"
703:             ENDIF
704:             .Visible   = .T.
705:         ENDWITH
706:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * ConfigurarPaginaDados - Elementos visuais decorativos do form OPERACIONAL
711:     * Forms OPERACIONAIS nao tem Page2/PaginaDados como nos CRUD.

*-- Linhas 720 a 742:
720:             *-- Shape2: moldura decorativa lado esquerdo (area de titulo)
721:             THIS.AddObject("shp_4c_Shape2", "Shape")
722:             WITH THIS.shp_4c_Shape2
723:                 .Top         = 11
724:                 .Left        = 10
725:                 .Height      = 110
726:                 .Width       = 172
727:                 .BackStyle   = 0
728:                 .BorderStyle = 0
729:                 .BorderColor = RGB(136, 189, 188)
730:                 .Visible     = .T.
731:             ENDWITH
732: 
733:             *-- Shape1: moldura decorativa lado direito (area dos botoes de acao)
734:             THIS.AddObject("shp_4c_Shape1", "Shape")
735:             WITH THIS.shp_4c_Shape1
736:                 .Top         = 11
737:                 .Left        = 817
738:                 .Height      = 110
739:                 .Width       = 172
740:                 .BackStyle   = 0
741:                 .BorderStyle = 0
742:                 .BorderColor = RGB(0, 0, 0)

*-- Linhas 764 a 773:
764:             SET CLASSLIB TO (loc_cVcx) ADDITIVE
765:             THIS.AddObject("bal_4c_Balanca", "balan" + CHR(231) + "a")
766:             WITH THIS.bal_4c_Balanca
767:                 .Top          = 84
768:                 .Left         = 924
769:                 .Height       = 36
770:                 .Width        = 24
771:                 .Porta        = NVL(crSigCdPam.BalPortas, 0)
772:                 .Velocidade   = NVL(crSigCdPam.BalVelocs, 0)
773:                 .TipoParidade = NVL(crSigCdPam.BalTppars, 0)

*-- Linhas 1209 a 1218:
1209:                 SKIP
1210:                 KEYBOARD "{DOWNARROW}"
1211:                 IF EOF("xPesa")
1212:                     IF VARTYPE(THIS.cmd_4c_Resumo) = "O"
1213:                         THIS.cmd_4c_Resumo.SetFocus()
1214:                     ENDIF
1215:                 ELSE
1216:                     IF USED("crSigCdPam") AND NVL(crSigCdPam.LibObss, 0) = 1
1217:                         THIS.grd_4c_Itens.Column2.SetFocus()
1218:                     ELSE

*-- Linhas 1996 a 2012:
1996:                 GO TOP
1997:                 THIS.grd_4c_Itens.RecordSource = "xPesa"
1998:                 WITH THIS.grd_4c_Itens
1999:                     .Column1.Header1.Caption = "Produto"
2000:                     .Column2.Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
2001:                     .Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2002:                     .Column4.Header1.Caption = "Tam"
2003:                     .Column5.Header1.Caption = "Quantidade"
2004:                     .Column6.Header1.Caption = "Peso"
2005:                     .Column7.Header1.Caption = "Cor"
2006:                     .Column8.Header1.Caption = "Barras"
2007:                     .Column9.Header1.Caption = "Custo"
2008:                     .Refresh()
2009:                 ENDWITH
2010:             ENDIF
2011:         CATCH TO loc_oErro
2012:             MsgErro(loc_oErro.Message, "Erro ao carregar lista de pe" + CHR(231) + "as")

*-- Linhas 2027 a 2040:
2027:             loc_cModo   = ALLTRIM(NVL(THIS.this_oPaiForm.pcEscolha, ""))
2028:             loc_lEdicao = INLIST(loc_cModo, "INSERIR", "ALTERAR")
2029:         ENDIF
2030:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
2031:             THIS.cmd_4c_Processar.Enabled = loc_lEdicao
2032:         ENDIF
2033:         IF VARTYPE(THIS.cmd_4c_CustoP) = "O"
2034:             THIS.cmd_4c_CustoP.Visible  = loc_lAcesso
2035:             THIS.cmd_4c_CustoP.Enabled  = loc_lAcesso AND loc_lEdicao
2036:         ENDIF
2037:         IF VARTYPE(THIS.txt_4c_PesoMedio) = "O"
2038:             THIS.txt_4c_PesoMedio.ReadOnly = !loc_lEdicao
2039:         ENDIF
2040:         IF VARTYPE(THIS.grd_4c_Itens) = "O"


### BO (C:\4c\projeto\app\classes\SigPdMp9BO.prg):
*------------------------------------------------------------------------------
* SigPdMp9BO.prg - Business Object: Pesagem de Pe" + CHR(231) + "as
* Herda de BusinessBase
* Tabela principal: SigPrCpo (composi" + CHR(231) + CHR(227) + "o especial de pe" + CHR(231) + "as)
* Cursor de trabalho: xPesa (gerenciado pelo form pai SigPdM8/similar)
*------------------------------------------------------------------------------
DEFINE CLASS SigPdMp9BO AS BusinessBase

    *-- Dados da linha atual do cursor xPesa (grid GradeItens)
    this_cCpros      = ""    && Codigo do produto (Column1 - Produto)
    this_cObs        = ""    && Observacao (Column2 - Observa" + CHR(231) + CHR(227) + "o)
    this_cOper       = ""    && Opera" + CHR(231) + CHR(227) + "o/Movimenta" + CHR(231) + CHR(227) + "o (Column3)
    this_nQtds       = 0     && Quantidade (Column5 - Quantidade)
    this_nPeso       = 0     && Peso (Column6 - Peso)
    this_cTams       = ""    && Codigo do tamanho (Column4 - Tam)
    this_cCors       = ""    && Codigo da cor (Column7 - Cor)
    this_cCbars      = ""    && Codigo de barras (Column8 - Barras)
    this_nCustoFs    = 0     && Custo de produ" + CHR(231) + CHR(227) + "o (Column9 - Custo)
    this_lEspecial   = .F.   && Flag pe" + CHR(231) + "a especial (DynamicForeColor vermelho)
    this_nNops       = 0     && N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    this_nNenvs      = 0     && N" + CHR(250) + "mero do envelope/pe" + CHR(231) + "a
    this_nPesoFixs   = 0     && Peso fixo da pe" + CHR(231) + "a
    this_cUsuLibs    = ""    && Usu" + CHR(225) + "rio que liberou pesagem fora do limite
    this_cMatPs      = ""    && Material da pe" + CHR(231) + "a (para rateio)
    this_nPeso2s     = 0     && Peso secund" + CHR(225) + "rio da pe" + CHR(231) + "a

    *-- Estado do processo de pesagem
    this_lAlterou    = .F.   && Indica se peso foi alterado na linha atual
    this_lLiberaPeso = .F.   && Indica se usu" + CHR(225) + "rio tem permiss" + CHR(227) + "o para liberar pesagem
    this_nOldValue   = 0     && Valor anterior do peso antes da edi" + CHR(231) + CHR(227) + "o
    this_nPesoMedio  = 0     && Peso m" + CHR(233) + "dio calculado (campo get_pesom)

    *-- C" + CHR(243) + "digo de acesso ao programa para verifica" + CHR(231) + CHR(227) + "o de permiss" + CHR(227) + "o (fChecaAcesso)
    this_cProgAcesso = ""    && Ex: 'P00000001' constru" + CHR(237) + "do a partir de Ndopps

    *-- Data de refer" + CHR(234) + "ncia para cota" + CHR(231) + CHR(245) + "es de moeda (de TmpNens.Datas)
    this_dDataMovimento = {} && Data da movimenta" + CHR(231) + CHR(227) + "o atual

    *-- Propriedades de composi" + CHR(231) + CHR(227) + "o SigPrCpo (para INSERT/UPDATE via ExecutarInsercao/ExecutarAtualizacao)
    this_cIdChaves       = ""   && cidchaves char(20) PRIMARY KEY
    this_cMats           = ""   && mats char(14) - c" + CHR(243) + "digo do material
    this_cCgrus          = ""   && cgrus char(3) - c" + CHR(243) + "digo do grupo
    this_cCats           = ""   && cats char(6) - categoria
    this_cDcompos        = ""   && dcompos char(40) - descri" + CHR(231) + CHR(227) + "o da composi" + CHR(231) + CHR(227) + "o
    this_cDscGrp         = ""   && dscgrp char(20) - descri" + CHR(231) + CHR(227) + "o do grupo
    this_cEtiqs          = ""   && etiqs char(1) - etiqueta
    this_cGrupos         = ""   && grupos char(10) - grupos
    this_cMoeds          = ""   && moeds char(3) - moeda
    this_cObsCompos      = ""   && obscompos char(10) - observa" + CHR(231) + CHR(227) + "o
    this_nOrdems         = 0    && ordems numeric(2,0) - ordem
    this_nPcompos        = 0    && pcompos numeric(11,3) - pre" + CHR(231) + "o
    this_nQtdsCompo      = 0    && qtds numeric(8,3) - quantidade na composi" + CHR(231) + CHR(227) + "o
    this_nQtscons        = 0    && qtscons numeric(8,3) - qtd consumida
    this_cUniCompos      = ""   && unicompos char(3) - unidade
    this_cCompos         = ""   && compos char(10) - composi" + CHR(231) + CHR(227) + "o
    this_nOrdCompos      = 0    && ordcompos numeric(2,0) - ordem composi" + CHR(231) + CHR(227) + "o
    this_nQtdCvs         = 0    && qtdcvs numeric(11,3) - qtd convertida
    this_nVlrCvs         = 0    && vlrcvs numeric(11,2) - valor convertido
    this_dDtMovs         = {}   && dtmovs - data do movimento
    this_cCuniPs         = ""   && cunips char(3) - unidade peso
    this_nMarkCvs        = 0    && markcvs numeric(9,6) - markup convertido
    this_nPesos          = 0    && pesos numeric(8,3) - peso na composi" + CHR(231) + CHR(227) + "o
    this_nTotas          = 0    && totas numeric(11,3) - total
    this_nTpAlts         = 0    && tpalts numeric(1,0) - tipo de altera" + CHR(231) + CHR(227) + "o
    this_nVlrPvs         = 0    && vlrpvs numeric(11,2) - valor venda
    this_nOrdTs          = 0    && ordts numeric(2,0) - ordem t
    this_cTipos          = ""   && tipos char(20) - tipos
    this_cMatriz         = ""   && matriz char(14) - matriz
    this_cObsOfs         = ""   && obsofs char(120) - obs ofertas
    this_nPedraPrincipal = 0    && PedraPrincipal numeric(1,0)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        THIS.this_cTabela     = "SigPrCpo"
        THIS.this_cCampoChave = "cIdChaves"
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna cIdChaves do registro atual
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cIdChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor xPesa
    * par_cAliasCursor: alias do cursor (tipicamente "xPesa")
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            THIS.this_cObs      = ALLTRIM(NVL(Obs,      ""))
            THIS.this_cOper     = ALLTRIM(NVL(Oper,     ""))
            THIS.this_nQtds     = NVL(Qtds,     0)
            THIS.this_nPeso     = NVL(Peso,     0)
            THIS.this_cTams     = ALLTRIM(NVL(Tams,    ""))
            THIS.this_cCors     = ALLTRIM(NVL(Cors,    ""))
            THIS.this_cCbars    = ALLTRIM(NVL(Cbars,   ""))
            THIS.this_nCustoFs  = NVL(CustoFs,  0)
            THIS.this_lEspecial = IIF(VARTYPE(Especial) = "L", Especial, NVL(Especial, 0) = 1)
            THIS.this_nNops     = NVL(Nops,     0)
            THIS.this_nNenvs    = NVL(Nenvs,    0)
            THIS.this_nPesoFixs = NVL(PesoFixs, 0)
            THIS.this_cUsuLibs  = ALLTRIM(NVL(UsuLibs, ""))
            THIS.this_cMatPs    = ALLTRIM(NVL(MatPs,   ""))
            THIS.this_nPeso2s   = NVL(Peso2s,   0)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados m" + CHR(237) + "nimos antes de gravar SigPrCpo
    *==========================================================================
    PROTECTED FUNCTION ValidarDados()
        IF EMPTY(THIS.this_cCpros)
            MsgAviso("O c" + CHR(243) + "digo do produto deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cMats)
            MsgAviso("O c" + CHR(243) + "digo do material deve ser informado.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ExecutarInsercao - INSERT INTO SigPrCpo com os dados das propriedades do BO
    *==========================================================================
    PROTECTED FUNCTION ExecutarInsercao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cIdChaves)
                THIS.this_cIdChaves = ALLTRIM(fUniqueIds())
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                       "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, grupos, " + ;
                       "moeds, obscompos, ordems, pcompos, qtds, qtscons, unicompos, compos, " + ;
                       "ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, markcvs, pesos, totas, " + ;
                       "tpalts, vlrpvs, ordts, tipos, matriz, obsofs, datatrans, PedraPrincipal) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)        + ", " + ;
                       EscaparSQL(THIS.this_cCpros)           + ", " + ;
                       EscaparSQL(THIS.this_cMats)            + ", " + ;
                       EscaparSQL(THIS.this_cCgrus)           + ", " + ;
                       EscaparSQL(THIS.this_cCats)            + ", " + ;
                       EscaparSQL(THIS.this_cDcompos)         + ", " + ;
                       EscaparSQL(THIS.this_cDscGrp)          + ", " + ;
                       EscaparSQL(THIS.this_cEtiqs)           + ", " + ;
                       EscaparSQL(THIS.this_cGrupos)          + ", " + ;
                       EscaparSQL(THIS.this_cMoeds)           + ", " + ;
                       EscaparSQL(THIS.this_cObsCompos)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcompos)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdsCompo)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtscons)  + ", " + ;
                       EscaparSQL(THIS.this_cUniCompos)       + ", " + ;
                       EscaparSQL(THIS.this_cCompos)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdCompos)+ ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdCvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrCvs)   + ", " + ;
                       "GETDATE(), "                          + ;
                       EscaparSQL(THIS.this_cCuniPs)          + ", " + ;
                       FormatarNumeroSQL(THIS.this_nMarkCvs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesos)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTotas)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpAlts)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrPvs)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdTs)    + ", " + ;
                       EscaparSQL(THIS.this_cTipos)           + ", " + ;
                       EscaparSQL(THIS.this_cMatriz)          + ", " + ;
                       EscaparSQL(THIS.this_cObsOfs)          + ", " + ;
                       "GETDATE(), "                          + ;
                       FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ")"

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao inserir composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao inserir SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarAtualizacao - UPDATE SigPrCpo WHERE cpros = AND mats =
    *==========================================================================
    PROTECTED FUNCTION ExecutarAtualizacao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCpros) OR EMPTY(THIS.this_cMats)
                MsgErro("Produto ou material n" + CHR(227) + "o informado para UPDATE.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigPrCpo SET " + ;
                       "cgrus = "     + EscaparSQL(THIS.this_cCgrus)            + ", " + ;
                       "cats = "      + EscaparSQL(THIS.this_cCats)             + ", " + ;
                       "dcompos = "   + EscaparSQL(THIS.this_cDcompos)          + ", " + ;
                       "dscgrp = "    + EscaparSQL(THIS.this_cDscGrp)           + ", " + ;
                       "etiqs = "     + EscaparSQL(THIS.this_cEtiqs)            + ", " + ;
                       "grupos = "    + EscaparSQL(THIS.this_cGrupos)           + ", " + ;
                       "moeds = "     + EscaparSQL(THIS.this_cMoeds)            + ", " + ;
                       "obscompos = " + EscaparSQL(THIS.this_cObsCompos)        + ", " + ;
                       "ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems)    + ", " + ;
                       "pcompos = "   + FormatarNumeroSQL(THIS.this_nPcompos)   + ", " + ;
                       "qtds = "      + FormatarNumeroSQL(THIS.this_nQtdsCompo) + ", " + ;
                       "qtscons = "   + FormatarNumeroSQL(THIS.this_nQtscons)   + ", " + ;
                       "unicompos = " + EscaparSQL(THIS.this_cUniCompos)        + ", " + ;
                       "compos = "    + EscaparSQL(THIS.this_cCompos)           + ", " + ;
                       "ordcompos = " + FormatarNumeroSQL(THIS.this_nOrdCompos) + ", " + ;
                       "qtdcvs = "    + FormatarNumeroSQL(THIS.this_nQtdCvs)    + ", " + ;
                       "vlrcvs = "    + FormatarNumeroSQL(THIS.this_nVlrCvs)    + ", " + ;
                       "dtmovs = GETDATE(), " + ;
                       "cunips = "    + EscaparSQL(THIS.this_cCuniPs)           + ", " + ;
                       "markcvs = "   + FormatarNumeroSQL(THIS.this_nMarkCvs)   + ", " + ;
                       "pesos = "     + FormatarNumeroSQL(THIS.this_nPesos)     + ", " + ;
                       "totas = "     + FormatarNumeroSQL(THIS.this_nTotas)     + ", " + ;
                       "tpalts = "    + FormatarNumeroSQL(THIS.this_nTpAlts)    + ", " + ;
                       "vlrpvs = "    + FormatarNumeroSQL(THIS.this_nVlrPvs)    + ", " + ;
                       "ordts = "     + FormatarNumeroSQL(THIS.this_nOrdTs)     + ", " + ;
                       "tipos = "     + EscaparSQL(THIS.this_cTipos)            + ", " + ;
                       "matriz = "    + EscaparSQL(THIS.this_cMatriz)           + ", " + ;
                       "obsofs = "    + EscaparSQL(THIS.this_cObsOfs)           + ", " + ;
                       "PedraPrincipal = " + FormatarNumeroSQL(THIS.this_nPedraPrincipal) + ;
                       " WHERE cpros = " + EscaparSQL(THIS.this_cCpros) + ;
                       " AND mats = "    + EscaparSQL(THIS.this_cMats)

            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRet < 1
                MsgErro("Falha ao atualizar composi" + CHR(231) + CHR(227) + "o em SigPrCpo.", "Erro")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar SigPrCpo")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BuscarPermissaoLiberaPeso - Verifica se existe usu" + CHR(225) + "rio com senha de libera" + CHR(231) + CHR(227) + "o
    * Seta this_lLiberaPeso e retorna .T. se ao menos um usu" + CHR(225) + "rio tem LibPess='S'
    * Replica: lcSql = [Select Count(*) as Senha From SigCdUsu Where LibPess = 'S' And Senhas <> ' ']
    *==========================================================================
    FUNCTION BuscarPermissaoLiberaPeso()
        LOCAL loc_lPodeLiberar, loc_cSQL, loc_nRet, loc_oErro
        loc_lPodeLiberar = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS Senha FROM SigCdUsu " + ;
                       "WHERE LibPess = 'S' AND Senhas <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSenha")
            IF loc_nRet >= 1
                SELECT cursor_4c_TmpSenha
                GO TOP
                IF NVL(Senha, 0) > 0
                    loc_lPodeLiberar = .T.
                ENDIF
                IF USED("cursor_4c_TmpSenha")
                    USE IN cursor_4c_TmpSenha
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar permiss" + CHR(227) + "o de peso")
        ENDTRY
        THIS.this_lLiberaPeso = loc_lPodeLiberar
        RETURN loc_lPodeLiberar
    ENDFUNC

    *==========================================================================
    * VerificarDiferencaPeso - Valida se novo peso est" + CHR(225) + " dentro do limite tolerado
    * par_nPesoNovo: valor do peso digitado pelo usu" + CHR(225) + "rio
    * Retorna .T. se dentro do limite (ou sem configura" + CHR(231) + CHR(227) + "o de limite)
    *         .F. se fora do limite (form deve tratar autoriza" + CHR(231) + CHR(227) + "o)
    * Replica logica de Column6.Text1.Valid do legado
    *==========================================================================
    FUNCTION VerificarDiferencaPeso(par_nPesoNovo)
        LOCAL loc_lDentroLimite, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_nDifPesags, loc_cDifPes, loc_nPesoMs
        LOCAL loc_nPesagem, loc_nXDif, loc_nSinals
        loc_lDentroLimite = .T.
        TRY
            *-- Busca flag de controle de diferenca de peso da empresa
            loc_cSQL = "SELECT DifPes FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpDif")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_EmpDif
            GO TOP
            loc_cDifPes = ALLTRIM(NVL(DifPes, ""))
            IF USED("cursor_4c_EmpDif")
                USE IN cursor_4c_EmpDif
            ENDIF

            *-- Busca tolerancia da parametrizacao (crSigCdPam.DifPesags, .Sinals)
            IF !USED("crSigCdPam")
                loc_lSucesso = .T.
            ENDIF
            SELECT crSigCdPam
            GO TOP
            loc_nDifPesags = NVL(DifPesags, 0)
            loc_nSinals    = NVL(Sinals, 0)

            IF loc_nDifPesags = 0 OR loc_cDifPes <> "S"
                loc_lSucesso = .T.
            ENDIF

            *-- Busca peso nominal do produto
            loc_cSQL = "SELECT PesoMs FROM SigCdPro " + ;
                       "WHERE Cpros = " + EscaparSQL(THIS.this_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProPeso")
            IF loc_nRet < 1
                loc_lSucesso = .T.
            ENDIF
            SELECT cursor_4c_ProPeso
            GO TOP
            loc_nPesoMs = NVL(PesoMs, 0)
            IF USED("cursor_4c_ProPeso")
                USE IN cursor_4c_ProPeso
            ENDIF

            IF loc_nPesoMs = 0
                loc_lSucesso = .T.
            ENDIF

            *-- Calcula peso real por pe" + CHR(231) + "a e percentual de diferen" + CHR(231) + "a
            loc_nPesagem = 0
            IF THIS.this_nQtds <> 0
                loc_nPesagem = (par_nPesoNovo / THIS.this_nQtds) - THIS.this_nPesoFixs
            ENDIF

            IF loc_nPesagem <> loc_nPesoMs
                loc_nXDif = (((loc_nPesagem / loc_nPesoMs) - 1) * 100)
                IF (loc_nXDif < (loc_nDifPesags * -1) AND loc_nSinals <> 1) OR ;
                   (loc_nXDif > loc_nDifPesags AND loc_nSinals <> 2)
                    loc_lDentroLimite = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao verificar diferen" + CHR(231) + "a de peso")
            loc_lDentroLimite = .T.
        ENDTRY
        RETURN loc_lDentroLimite
    ENDFUNC

    *==========================================================================
    * AtualizarPesoMedio - Distribui peso m" + CHR(233) + "dio por todas as pe" + CHR(231) + "as do cursor xPesa
    * par_nPesoMedio: valor do campo get_pesom
    * Replica logica de get_pesom.Valid do legado
    *==========================================================================
    FUNCTION AtualizarPesoMedio(par_nPesoMedio)
        LOCAL loc_lSucesso, loc_nTotal, loc_nPesoPorUnid, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF !USED("xPesa") OR par_nPesoMedio = 0
                loc_lSucesso = .F.
            ENDIF
            SELECT xPesa
            SUM Qtds TO loc_nTotal
            IF loc_nTotal = 0
                loc_lSucesso = .F.
            ENDIF
            loc_nPesoPorUnid = par_nPesoMedio / loc_nTotal
            SELECT xPesa
            SCAN
                REPLACE Peso WITH NVL(Qtds, 0) * loc_nPesoPorUnid
            ENDSCAN
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao atualizar peso m" + CHR(233) + "dio")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * CalcularCustoProducao - Calcula custo de produ" + CHR(231) + CHR(227) + "o de uma pe" + CHR(231) + "a
    * par_nNops: n" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o
    * par_cCpros: c" + CHR(243) + "digo do produto
    * Retorna valor num" + CHR(233) + "rico do custo calculado
    * Replica logica de custoproducao do legado (usa CrSigCdNei local)
    *==========================================================================
    FUNCTION CalcularCustoProducao(par_nNops, par_cCpros)
        LOCAL loc_nCusto, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cMoeda, loc_nMoev, loc_nMoem
        LOCAL loc_nValor, loc_cMoedaItem, loc_lRetrab
        loc_nCusto = 0
        TRY
            *-- Busca dados do produto principal para cambio
            loc_cSQL = "SELECT MoeCusfs, CustoFs, pVens, Moevs FROM SigCdPro " + ;
                       "WHERE CPros = " + EscaparSQL(par_cCpros)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpPro")
            IF loc_nRet < 1
                loc_lSucesso = 0
            ENDIF
            SELECT cursor_4c_CpPro
            GO TOP
            loc_cMoeda = ALLTRIM(NVL(MoeCusfs, ""))
            IF USED("cursor_4c_CpPro")
                USE IN cursor_4c_CpPro
            ENDIF

            loc_nMoev = fBuscarCotacao(loc_cMoeda, THIS.this_dDataMovimento, gnConnHandle)

            *-- Soma custo de materiais do cursor local CrSigCdNei (por opera" + CHR(231) + CHR(227) + "o)
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                SCAN FOR Nops = par_nNops
                    IF EMPTY(NVL(Cmats, "")) OR IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                        LOOP
                    ENDIF
                    loc_cMoedaItem = ALLTRIM(NVL(MoeCusFs, ""))
                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT CrSigCdNei
                    loc_nCusto = loc_nCusto + ;
                                 (NVL(Qtds,0) * NVL(CustoFs,0) * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
            ENDIF

            *-- Busca servi" + CHR(231) + "os terceirizados no SQL Server
            loc_cSQL = "SELECT a.cMats, c.Retrabs, a.Qtds, a.Coefs, a.Fators, a.Moedas " + ;
                       "FROM SigCdNei a " + ;
                       "JOIN SigCdSvc b ON a.cMats = b.ccats AND b.Cpros <> ' ' " + ;
                       "JOIN SigCdNec c ON a.EmpDnps = c.EmpDnPs " + ;
                       "WHERE a.Nops = " + FormatarNumeroSQL(par_nNops) + ;
                       " AND a.Servicos = 1 AND a.cMats <> ' '"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpSvc")
            IF loc_nRet >= 1
                SELECT cursor_4c_CpSvc
                SCAN
                    loc_lRetrab    = IIF(VARTYPE(Retrabs)="L", Retrabs, NVL(Retrabs,0)=1)
                    loc_cMoedaItem = ALLTRIM(NVL(cursor_4c_CpSvc.Moedas, ""))
                    IF loc_lRetrab AND NVL(Coefs,0) <> 0
                        loc_nValor = ROUND(NVL(Coefs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ELSE
                        loc_nValor = ROUND(NVL(Fators,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                    ENDIF

                    IF loc_nValor = 0
                        LOCAL loc_cMatsSvc
                        loc_cMatsSvc = ALLTRIM(NVL(cursor_4c_CpSvc.cMats, ""))
                        loc_cSQL = "SELECT p.MoeCusfs, p.CustoFs, p.pVens, p.Moevs, g.pvCompos " + ;
                                   "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.Cgrus = g.Cgrus " + ;
                                   "WHERE p.CPros = " + EscaparSQL(loc_cMatsSvc)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpProSvc")
                        IF loc_nRet >= 1
                            SELECT cursor_4c_CpProSvc
                            GO TOP
                            IF NVL(pvCompos,0) = 2
                                loc_nValor     = ROUND(NVL(pVens,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(Moevs,""))
                            ELSE
                                loc_nValor     = ROUND(NVL(CustoFs,0) * NVL(cursor_4c_CpSvc.Qtds,0), 2)
                                loc_cMoedaItem = ALLTRIM(NVL(MoeCusfs,""))
                            ENDIF
                            IF USED("cursor_4c_CpProSvc")
                                USE IN cursor_4c_CpProSvc
                            ENDIF
                        ENDIF
                    ENDIF

                    loc_nMoem = fBuscarCotacao(loc_cMoedaItem, THIS.this_dDataMovimento, gnConnHandle)
                    SELECT cursor_4c_CpSvc
                    loc_nCusto = loc_nCusto + (loc_nValor * IIF(loc_nMoev=0, 1, loc_nMoem / loc_nMoev))
                ENDSCAN
                IF USED("cursor_4c_CpSvc")
                    USE IN cursor_4c_CpSvc
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao calcular custo de produ" + CHR(231) + CHR(227) + "o")
            loc_nCusto = 0
        ENDTRY
        RETURN loc_nCusto
    ENDFUNC

    *==========================================================================
    * DistribuirRateio - Distribui peso entre os materiais do envelope
    * par_nAmarra: RECNO() da linha atual de xPesa
    * Popula cursor local CrSigCdNei com os materiais e pesos distribuidos
    * Replica logica de ratpeso do legado
    *==========================================================================
    FUNCTION DistribuirRateio(par_nAmarra)
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_nNenv, loc_cMatP, loc_nPesagem, loc_nPesoAnt, loc_nRecnoRateio
        LOCAL loc_nDifPeso, loc_nTotGrava, loc_cSQL, loc_nRet, loc_lTemOuro
        LOCAL loc_cEmps, loc_cDopps, loc_nNumps, loc_cEmpDnPs
        LOCAL loc_nPsFaseAnt, loc_nDivisor
        loc_lSucesso = .F.
        TRY
            IF !USED("crSigCdOpd") OR !USED("xNensiE") OR !USED("TmpNens")
                MsgErro("Cursores de opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o est" + CHR(227) + "o abertos.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Posiciona crSigCdOpd pelo tipo de opera" + CHR(231) + CHR(227) + "o
            SELECT crSigCdOpd
            SET ORDER TO Dopps
            SELECT TmpNens
            GO TOP
            SEEK ALLTRIM(NVL(TmpNens.Dopps, "")) IN crSigCdOpd

            *-- Zera cursores de trabalho para reprocessamento
            IF USED("CrSigCdNei")
                SELECT CrSigCdNei
                ZAP
            ENDIF
            SELECT xNensiE
            ZAP

            *-- Copia xNensI para xNensiE e calcula totais
            IF USED("xNensI")
                SELECT xNensI
                SET ORDER TO
                SELECT xNensiE
                APPEND FROM DBF("xNensI")
                SUM Pesos TO loc_nTotGrava FOR Visivel AND !IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)
                SET ORDER TO Rateio
                DELETE ALL FOR EMPTY(NVL(Nops,"")) AND EMPTY(NVL(CMats,"")) AND ;
                              EMPTY(NVL(Cats,"")) AND NVL(Rateio,0) <> 1
                GO TOP
            ENDIF

            *-- Rateio especial para etiquetas tipo 1 ou 3
            IF INLIST(NVL(crSigCdOpd.Etiqs, 0), 1, 3)
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
                SELECT xPesa
                SELECT Nenvs, MatPs, Peso AS Pesos ;
                FROM xPesa WHERE RECNO() = par_nAmarra ;
                INTO CURSOR xRateio

                SELECT xRateio
                SCAN
                    loc_nNenv        = NVL(Nenvs, 0)
                    loc_cMatP        = ALLTRIM(NVL(MatPs, ""))
                    loc_nPesagem     = NVL(Pesos, 0)
                    loc_nPesoAnt     = 0
                    loc_nRecnoRateio = 0
                    loc_lTemOuro     = .F.

                    SELECT xNensiE
                    SET ORDER TO Nenvs
                    IF SEEK(loc_nNenv)
                        SCAN WHILE NVL(Nenvs,0) = loc_nNenv
                            IF ALLTRIM(NVL(CMats,"")) = loc_cMatP
                                loc_lTemOuro = .T.
                                EXIT
                            ENDIF
                        ENDSCAN
                    ENDIF

                    IF !loc_lTemOuro
                        SELECT TmpNens
                        GO TOP
                        INSERT INTO xNensiE (Nenvs, Nops, Numps, CMats, PsFaseAnt, Pesos, Qtds, Rateio) ;
                        VALUES (loc_nNenv, loc_nNenv, NVL(Numps,0), loc_cMatP, ;
                                loc_nPesagem, loc_nPesagem, loc_nPesagem, 2)
                    ENDIF

                    SELECT xNensiE
                    SCAN FOR NVL(Rateio,0) = 3 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        IF loc_nRecnoRateio = 0
                            loc_nRecnoRateio = RECNO()
                        ENDIF
                        loc_nPesoAnt = loc_nPesoAnt + NVL(PsFaseAnt, 0)
                    ENDSCAN

                    loc_nDifPeso = loc_nPesagem - loc_nPesoAnt
                    SCAN FOR NVL(Rateio,0) = 2 AND NVL(NEnvs,0) = loc_nNenv AND ;
                             !IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                        loc_nPsFaseAnt = NVL(PsFaseAnt, 0)
                        loc_nDivisor   = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                        REPLACE Pesos WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2), ;
                                Qtds  WITH ROUND(loc_nPsFaseAnt + (loc_nPsFaseAnt / loc_nDivisor * loc_nDifPeso), 2)
                        loc_nPesagem = loc_nPesagem - NVL(Pesos, 0)
                    ENDSCAN

                    IF loc_nRecnoRateio <> 0 AND loc_nPesagem <> 0
                        GO loc_nRecnoRateio
                        REPLACE Pesos WITH NVL(Pesos,0) + loc_nPesagem, ;
                                Qtds  WITH NVL(Qtds,0)  + loc_nPesagem
                    ENDIF

                    SELECT xRateio
                ENDSCAN
                IF USED("xRateio")
                    USE IN xRateio
                ENDIF
            ENDIF

            *-- Grava xNensiE no cursor local CrSigCdNei com dados do SQL Server
            SELECT TmpNens
            GO TOP
            loc_cEmps    = ALLTRIM(NVL(TmpNens.Emps,  ""))
            loc_cDopps   = ALLTRIM(NVL(TmpNens.Dopps, ""))
            loc_nNumps   = NVL(TmpNens.Numps, 0)
            loc_cEmpDnPs = loc_cEmps + loc_cDopps + STR(loc_nNumps, 10)

            SELECT xNensiE
            SET ORDER TO Gravar
            SCAN FOR NVL(Qtds,0) <> 0 OR NVL(Pesos,0) <> 0 OR ;
                     (USED("crSigCdOpd") AND NVL(crSigCdOpd.ReiNops, 0) = 1)

                *-- Busca custo e flags do produto/grupo para este material
                loc_cSQL = "SELECT g.CEstoqs, g.pvCompos, g.Varias, " + ;
                           "p.CGrus, p.CustoFs, p.MoeCusFs, p.pVens, p.Moevs " + ;
                           "FROM SigCdPro p LEFT JOIN SigCdGrp g ON p.CGrus = g.CGrus " + ;
                           "WHERE p.Cpros = " + EscaparSQL(ALLTRIM(NVL(xNensiE.CMats,"")))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PgRateio")

                IF USED("CrSigCdNei")
                    INSERT INTO CrSigCdNei ;
                    (Emps, Dopps, Numps, Nops, Nenvs, CMats, CDescs, CUnis, Tpops, Cats, Obss, ;
                     AQtds, Qtds, Pesos, FlagIncs, Fators, Moedas, Servicos, GrupoFins, ;
                     nLotes, PesoFixs, cIdChaves, EmpDNPs, Peso2s) ;
                    VALUES ;
                    (loc_cEmps, loc_cDopps, loc_nNumps, ;
                     NVL(xNensiE.NOps,0), NVL(xNensiE.Nenvs,0), ;
                     ALLTRIM(NVL(xNensiE.CMats,"")),   ALLTRIM(NVL(xNensiE.CDescs,"")), ;
                     ALLTRIM(NVL(xNensiE.CUnis,"")),   ALLTRIM(NVL(xNensiE.Tpops,"")), ;
                     ALLTRIM(NVL(xNensiE.Cats,"")),    ALLTRIM(NVL(xNensiE.Obss,"")), ;
                     NVL(xNensiE.AQtds,0), NVL(xNensiE.Qtds,0), NVL(xNensiE.Pesos,0), ;
                     IIF(VARTYPE(xNensiE.FlagIncs)="L", xNensiE.FlagIncs, NVL(xNensiE.FlagIncs,0)=1), ;
                     NVL(xNensiE.Fators,0), ALLTRIM(NVL(xNensiE.Moedas,"")), ;
                     IIF(VARTYPE(xNensiE.Servicos)="L", xNensiE.Servicos, NVL(xNensiE.Servicos,0)=1), ;
                     ALLTRIM(NVL(xNensiE.GrupoFins,"")), ;
                     NVL(xNensiE.nLotes,0), NVL(xNensiE.PesoFixs,0), ;
                     ALLTRIM(fUniqueIds()), loc_cEmpDnPs, NVL(xNensiE.Peso2s,0))

                    *-- Atualiza custo/moeda e flag PesoFixs baseado no grupo do produto
                    IF loc_nRet >= 1 AND USED("cursor_4c_PgRateio")
                        SELECT cursor_4c_PgRateio
                        GO TOP
                        SELECT CrSigCdNei
                        GO BOTTOM
                        IF NVL(cursor_4c_PgRateio.pvCompos, 0) = 2
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.pVens,    0), ;
                                    MoeCusfs WITH ALLTRIM(NVL(cursor_4c_PgRateio.Moevs,""))
                        ELSE
                            REPLACE CustoFs  WITH NVL(cursor_4c_PgRateio.CustoFs,  0), ;
                                    MoeCusFs WITH ALLTRIM(NVL(cursor_4c_PgRateio.MoeCusFs,""))
                        ENDIF
                        IF USED("crSigCdOpd") AND NVL(crSigCdOpd.PesoFixs,0) = 1 AND ;
                           NVL(cursor_4c_PgRateio.Varias,0) = 1
                            REPLACE PesoFixs WITH 1
                        ENDIF
                        IF USED("cursor_4c_PgRateio")
                            USE IN cursor_4c_PgRateio
                        ENDIF
                    ENDIF
                ENDIF
                SELECT xNensiE
            ENDSCAN
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao distribuir rateio de peso")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarComposicaoEspecial - Grava composi" + CHR(231) + CHR(227) + "o especial no SQL Server (SigPrCpo)
    * par_cAliasCursor: cursor local com dados (ex: "CsSigPrCpo")
    *   - Cursor deve ter campos do SigPrCpo (ideal: construido via SELECT * FROM SigPrCpo)
    *   - Campos m" + CHR(237) + "nimos: cpros, mats, qtds, pesos, dcompos, unicompos, cunips,
    *     cgrus, pcompos, moeds, dtmovs, tpalts, cidchaves, etiqs
    * Replica: Thisform.Podatamgr.update('CsSigPrCpo') do legado
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarComposicaoEspecial(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_cCpros, loc_cIdChaves, loc_nTpAlts
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                MsgErro("Cursor " + par_cAliasCursor + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)
            GO TOP
            IF EOF()
                loc_lSucesso = .T.
            ENDIF

            *-- Remove composi" + CHR(231) + CHR(227) + "o anterior do produto no SQL Server
            loc_cCpros = ALLTRIM(NVL(cpros, ""))
            IF !EMPTY(loc_cCpros)
                loc_cSQL = "DELETE FROM SigPrCpo WHERE cpros = " + EscaparSQL(loc_cCpros)
                SQLEXEC(gnConnHandle, loc_cSQL)
            ENDIF

            *-- Insere cada linha v" + CHR(225) + "lida (TpAlts > 0)
            SELECT (par_cAliasCursor)
            GO TOP
            DO WHILE !EOF()
                loc_nTpAlts = NVL(TpAlts, 0)
                IF loc_nTpAlts > 0
                    loc_cIdChaves = ALLTRIM(NVL(cIdChaves, ""))
                    IF EMPTY(loc_cIdChaves)
                        loc_cIdChaves = ALLTRIM(fUniqueIds())
                    ENDIF
                    loc_cSQL = "INSERT INTO SigPrCpo (" + ;
                               "cidchaves, cpros, mats, cgrus, cats, dcompos, dscgrp, etiqs, " + ;
                               "grupos, moeds, obscompos, ordems, pcompos, qtds, qtscons, " + ;
                               "unicompos, compos, ordcompos, qtdcvs, vlrcvs, dtmovs, cunips, " + ;
                               "markcvs, pesos, totas, tpalts, vlrpvs, ordts, tipos, matriz, " + ;
                               "obsofs, datatrans, PedraPrincipal) " + ;
                               "VALUES (" + ;
                               EscaparSQL(loc_cIdChaves)                          + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cpros,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(mats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cgrus,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(cats,      "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dcompos,   "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(dscgrp,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(etiqs,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(grupos,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(moeds,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obscompos, "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordems,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pcompos,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtds,        0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtscons,     0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(unicompos, "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(compos,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(ordcompos,   0))             + ", " + ;
                               FormatarNumeroSQL(NVL(qtdcvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrcvs,      0))             + ", " + ;
                               "GETDATE(), "                                               + ;
                               EscaparSQL(ALLTRIM(NVL(cunips,    "")))            + ", " + ;
                               FormatarNumeroSQL(NVL(markcvs,     0))             + ", " + ;
                               FormatarNumeroSQL(NVL(pesos,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(totas,       0))             + ", " + ;
                               FormatarNumeroSQL(NVL(tpalts,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(vlrpvs,      0))             + ", " + ;
                               FormatarNumeroSQL(NVL(ordts,       0))             + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(tipos,     "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(matriz,    "")))            + ", " + ;
                               EscaparSQL(ALLTRIM(NVL(obsofs,    "")))            + ", " + ;
                               "GETDATE(), "                                               + ;
                               FormatarNumeroSQL(NVL(PedraPrincipal, 0))          + ")"
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nRet < 1
                        MsgErro("Falha ao gravar composi" + CHR(231) + CHR(227) + "o especial. " + ;
                                "Produto: " + ALLTRIM(NVL(cpros,"")), "Erro")
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
                SELECT (par_cAliasCursor)
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar composi" + CHR(231) + CHR(227) + "o especial")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * GravarSigCdNei - Persiste cursor local CrSigCdNei no SQL Server (SigCdNei)
    * Equivalente ao poDataMgr.update('CrSigCdNei') do legado
    * Chamado pelo form em BtnProcessarClick ap" + CHR(243) + "s todas as pe" + CHR(231) + "as pesadas
    * Retorna .T. se sucesso, .F. se falha
    *==========================================================================
    FUNCTION GravarSigCdNei()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro
        LOCAL loc_lFlagIncs, loc_lServicos
        loc_lSucesso = .F.
        TRY
            IF !USED("CrSigCdNei") OR RECCOUNT("CrSigCdNei") = 0
                loc_lSucesso = .T.
            ENDIF
            SELECT CrSigCdNei
            GO TOP
            DO WHILE !EOF()
                loc_lFlagIncs = IIF(VARTYPE(FlagIncs)="L", FlagIncs, NVL(FlagIncs,0)=1)
                loc_lServicos = IIF(VARTYPE(Servicos)="L", Servicos, NVL(Servicos,0)=1)

                loc_cSQL = "INSERT INTO SigCdNei (" + ;
                           "emps, dopps, numps, nops, nenvs, cmats, cdescs, cunis, tpops, cats, " + ;
                           "obss, aqtds, qtds, pesos, flagincs, fators, moedas, servicos, " + ;
                           "grupofins, nlotes, pesofixs, cidchaves, empdnps, peso2s, " + ;
                           "custofs, moecusfs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(ALLTRIM(NVL(Emps,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Dopps,     ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Numps,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nops,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Nenvs,       0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CMats,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CDescs,    ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(CUnis,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Tpops,     ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Cats,      ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Obss,      ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(AQtds,       0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Qtds,        0))  + ", " + ;
                           FormatarNumeroSQL(NVL(Pesos,       0))  + ", " + ;
                           IIF(loc_lFlagIncs, "1", "0")            + ", " + ;
                           FormatarNumeroSQL(NVL(Fators,      0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(Moedas,    ""))) + ", " + ;
                           IIF(loc_lServicos, "1", "0")            + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(GrupoFins, ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(nLotes,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(PesoFixs,    0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(cIdChaves, ""))) + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(EmpDNPs,   ""))) + ", " + ;
                           FormatarNumeroSQL(NVL(Peso2s,      0))  + ", " + ;
                           FormatarNumeroSQL(NVL(CustoFs,     0))  + ", " + ;
                           EscaparSQL(ALLTRIM(NVL(MoeCusFs,  ""))) + ")"

                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao gravar SigCdNei (Nenvs=" + ;
                            TRANSFORM(NVL(Nenvs,0)) + ")", "Erro")
                    loc_lSucesso = .F.
                ENDIF
                SELECT CrSigCdNei
                SKIP
            ENDDO
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao gravar SigCdNei")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

