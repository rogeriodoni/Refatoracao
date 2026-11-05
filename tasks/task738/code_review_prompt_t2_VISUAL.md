# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [ALINHAMENTO] Botao 'cmd_4c_BtnGetArqO' tem Top=18 mas grupo usa Top=6 (diferenca de 12px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopgar.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1473 linhas total):

*-- Linhas 42 a 70:
42: * default - cntTXT.visible = .T. no Init legado), ConfigurarBotoes()
43: * (Shape1/Cancela/Processa), ConfigurarChkXml() (toggle TXT<->XML) e
44: * ConfigurarPainelXml() (painel oculto por default - cntXml.visible = .F.
45: * no Init legado), com os handlers de botao/checkbox e os BINDEVENTs em
46: * InicializarForm. Unica diferenca deste dialogo para o perfil-irmao: DOIS
47: * paineis alternados por chkXml, em vez de um unico painel fixo.
48: *
49: * chk_4c_ChkXml e cmd_4c_BtnDirs/txt_4c_Dirs/txt_4c_Arquivo (dentro de
50: * cnt_4c_Xml) NAO existiam na Fase 3 - cnt_4c_Xml nasce com Visible = .F.
51: * (AddObject default) e TornarControlesVisiveis() foi atualizado para NAO
52: * forcar .T. nele (continua recursando nos filhos, para eles nao ficarem
53: * Visible = .F. "para sempre" quando o chkXml alternar o painel depois -
54: * regra do CorretorAutomatico #109/CLAUDE.md).
55: *
56: * Fase 5/8: "metade dos campos da Page2" nao se aplica - nao ha Page2, e os
57: * 19 objetos do SCX (3 TextBox, 2 CheckBox, 5 Label, 2 Shape, 4 CommandButton
58: * e os 3 Container) ja estavam TODOS criados desde a Fase 4; acrescentar
59: * campo aqui seria inventar superficie que o legado nao tem. O gate da fase
60: * passa pelo ramo CAPTURA, por paridade (3 dos 3 TextBox do legado, piso 2).
61: * O trabalho real da fase foi (a) a ORDEM DE TABULACAO, que o migrador havia
62: * descartado - ver ConfigurarOrdemTabulacao() - e (b) a auditoria campo a
63: * campo contra o dump, que achou nove divergencias silenciosas:
64: *
65: *   cmd_4c_BtnDirs    .Picture apontava geral_pasta_16.jpg, que eh o icone do
66: *                     IRMAO btnGetArqO - o dump pede geral_pasta_26.jpg. Os
67: *                     DOIS arquivos existem em vbmp\, entao o errado desenhava
68: *                     um icone sem erro nenhum (regra #25). No mesmo bloco,
69: *                     Verdana 10 / SpecialEffect = 2 / ForeColor 36,84,155
70: *                     tambem vinham do irmao: btnDirs eh classe "fwbtnp"

*-- Linhas 78 a 90:
78: *   txt_4c_Arquivo    .Height = 22 contra os 23 do default da classe "fwget"
79: *                     (o dump nao sobrescreve Height), mais SpecialEffect e
80: *                     BorderColor que nem o dump nem a fwget declaram.
81: *   FontBold          marcado em chk_4c_ChkXml e lbl_4c_LabelArquivo, que o
82: *                     dump NAO declara (chkXml eh "checkbox" pura e o label eh
83: *                     classe "say" - as duas com default .F.). Vinha do par
84: *                     chkImagens/CntTXT.Say1, cujos dumps DECLARAM negrito.
85: *   AutoSize          explicitado .F. nos dois CheckBox: o dump declara .T.,
86: *                     que eh NO-OP em controle criado por AddObject (regra
87: *                     #23) e precisa de Width/Height fixos.
88: *
89: * Nenhuma delas quebra compilacao nem aparece em log - sao todas visuais ou
90: * de ordem de foco. Provado em VFP9 em 2026-11-05: COMPILE sem .ERR (com

*-- Linhas 97 a 105:
97: * form NAO tem nenhuma das duas a acrescentar:
98: *
99: *   CAMPOS   os 19 objetos da arvore do SCX (3 Container, 5 Label, 3 TextBox,
100: *            2 CheckBox, 2 Shape e 4 CommandButton - contados um a um na
101: *            SECAO 1 do dump, fora o Dataenvironment e a propria Form) ja
102: *            estavam TODOS criados desde a Fase 4, e a Fase 5 auditou as
103: *            propriedades de cada um contra o dump. Nao sobrou campo: criar
104: *            mais um seria inventar superficie que o legado nao tem.
105: *

*-- Linhas 146 a 156:
146: *                    nao o tomar por campo vivo nem por defeito da migracao.
147: *
148: * Dois desvios que FICAM como estao, por serem herdados do SCX (regra #28) e
149: * nao defeito da migracao: cmd_4c_Cancela termina em 804 com Form.Width = 799
150: * (Left 724 do dump + Width 80 do default da classe fwbtng), perdendo 5px na
151: * borda, e cmd_4c_Processa termina em 729, cobrindo os mesmos 5px da esquerda
152: * do Cancela. Os dois numeros sao consequencia aritmetica de valores que o
153: * legado declara; "consertar" exigiria inventar Left ou Width proprio.
154: *
155: * Fase 8/8 (consolidacao final): o template desta fase cobra nomes de form
156: * CRUD. Aqui, pela MESMA ausencia estrutural que as fases 4/5/6 ja mediram

*-- Linhas 182 a 192:
182: *   BtnCancelarClick()      RENOMEADO (era batizado pelo Caption). O objeto do
183: *                           legado chama-se "Cancela" e declara Cancel = .T.,
184: *                           isto eh, a tecla ESC o acionava - no migrado ele eh
185: *                           cmd_4c_Cancela, e o nome do handler agora segue o
186: *                           objeto, como nos outros oito sites do projeto que
187: *                           ligam cmd_4c_Cancela. O Caption continua
188: *                           "Encerrar", transcrito do dump.
189: *
190: * O que NAO entrou, e por que escrever seria pior do que faltar:
191: *
192: *   botao de BUSCA       nao existe no SCX: os quatro CommandButton do legado

*-- Linhas 201 a 209:
201: *   HabilitarCampos      nenhum campo eh habilitado/desabilitado em runtime
202: *                        pelo legado: getArqTXT e getDirs ja nascem
203: *                        ReadOnly = .T. (transcricao do "When -> Return .f.")
204: *                        e os dois CheckBox nunca travam. Nao ha modo a
205: *                        condicionar - o que alterna aqui eh VISIBILIDADE de
206: *                        painel, e isso eh AplicarPainelPorModo.
207: *   AjustarBotoesPorModo nenhum dos quatro botoes eh desabilitado em ponto
208: *                        algum do dump, e nao ha modo CRUD neste dialogo.
209: *

*-- Linhas 257 a 265:
257:     * this_cUltimoProgresso - ultimo texto de progresso recebido do BO
258:     * (equivalente ao Caption de lblResults no legado, atualizado dentro do
259:     * Scan de ProcessaTxt/GerarArquivoTxt). Guardado na classe porque o
260:     * label correspondente (lbl_4c_LblResults) so sera criado no painel TXT,
261:     * em fase posterior - assim o progresso reportado antes do label existir
262:     * nao se perde.
263:     *==========================================================================
264:     this_cUltimoProgresso = ""
265: 

*-- Linhas 290 a 298:
290:     * "L" e os guards de objeto adiante lerem lixo.
291:     *==========================================================================
292:     PROCEDURE Init(par_oFormPai)
293:         THIS.Caption = "Gera Arquivo"
294: 
295:         IF VARTYPE(par_oFormPai) = "O"
296:             THIS.this_oFormPai = par_oFormPai
297:         ENDIF
298: 

*-- Linhas 360 a 397:
360:             ELSE
361:                 *-- O BO repinta o progresso durante o Scan de GerarArquivoTxt
362:                 *-- chamando this_oFormUI.AtualizarProgresso() - equivale ao
363:                 *-- "ThisForm.cntTxt.lblResults.Caption = ..." repetido no
364:                 *-- legado dentro de ProcessaTxt.
365:                 THIS.this_oBusinessObject.this_oFormUI = THIS
366: 
367:                 THIS.ConfigurarPageFrame()
368: 
369:                 *-- Fase 8: estado inicial da tela (o Init legado limpa os
370:                 *-- tres campos de arquivo e assenta chkXml/paineis). Vem
371:                 *-- DEPOIS de ConfigurarPageFrame, que cria os controles, e
372:                 *-- ANTES de TornarControlesVisiveis, para que a decisao de
373:                 *-- qual painel fica visivel seja respeitada por ele.
374:                 THIS.CarregarLista()
375: 
376:                 *-- BINDEVENTs: botoes/checkbox criados em ConfigurarBotoes/
377:                 *-- ConfigurarPainelTxt/ConfigurarChkXml/ConfigurarPainelXml,
378:                 *-- acima.
379:                 BINDEVENT(THIS.cmd_4c_Processa,              "Click", THIS, "BtnProcessarClick")
380:                 BINDEVENT(THIS.cmd_4c_Cancela,               "Click", THIS, "BtnCancelarClick")
381:                 BINDEVENT(THIS.chk_4c_ChkXml,                "Click", THIS, "ChkXmlClick")
382:                 BINDEVENT(THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO, "Click", THIS, "BtnGetArqOClick")
383:                 BINDEVENT(THIS.cnt_4c_Xml.cmd_4c_BtnDirs,    "Click", THIS, "BtnDirsClick")
384: 
385:                 THIS.TornarControlesVisiveis(THIS)
386: 
387:                 loc_lSucesso = .T.
388:             ENDIF
389:         CATCH TO loc_oErro
390:             MsgErro(loc_oErro.Message + CHR(13) + ;
391:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
392:                 "Procedure: " + loc_oErro.Procedure, ;
393:                 "Erro em InicializarForm")
394:         ENDTRY
395: 
396:         RETURN loc_lSucesso
397:     ENDPROC

*-- Linhas 445 a 466:
445:     * DBF por automation\dump738_scx.prg) e aplicando o TabIndex gravado logo
446:     * apos cada AddObject; os valores abaixo sao o que se leu de volta.
447:     *
448:     *   FILHOS DA FORM    cnt_4c_Sombra 1 / cnt_4c_TXT 2 / cmd_4c_Cancela 3 /
449:     *                     cmd_4c_Processa 4 / chk_4c_ChkXml 5 / cnt_4c_Xml 6
450:     *   cnt_4c_TXT        lbl_4c_LblResults 1 / lbl_4c_Label1 2 /
451:     *                     txt_4c_ArqTXT 3 / cmd_4c_BtnGetArqO 4 /
452:     *                     chk_4c_ChkImagens 5
453:     *   cnt_4c_Xml        txt_4c_Arquivo 1 / cmd_4c_BtnDirs 2 /
454:     *                     txt_4c_Dirs 3 / lbl_4c_LabelArquivo 4
455:     *
456:     * TabIndex eh escopado por PAI, por isso as tres sequencias recomecam em 1.
457:     * Atribuicao em ordem ASCENDENTE dentro de cada pai: descendente TROCA os
458:     * controles de lugar (medido). Nos dois paineis a ordem relativa dos
459:     * FOCALIZAVEIS ja coincidia com a ordem de criacao, entao o passe eh hoje
460:     * um no-op de comportamento - fica como documentacao da ordem do legado e
461:     * como guarda para quando alguem reordenar os AddObject.
462:     *
463:     * shp_4c_Shape1 e shp_4c_Shape2 ficam de FORA: Shape nao tem TabIndex
464:     * (medido - PEMSTATUS devolve .F.) e atribuir estouraria "Property TABINDEX
465:     * is not found". Os dois labels de cnt_4c_Sombra tambem ficam de fora - o
466:     * SCX nao lhes da TabIndex e Label nao tem TabStop (nao recebe foco).

*-- Linhas 481 a 509:
481:         *-- a ordem efetiva eh a de criacao dos REGISTROS do .scx).
482:         THIS.cnt_4c_Sombra.TabIndex   = 1
483:         THIS.cnt_4c_TXT.TabIndex      = 2
484:         THIS.cmd_4c_Cancela.TabIndex  = 3
485:         THIS.cmd_4c_Processa.TabIndex = 4
486:         THIS.chk_4c_ChkXml.TabIndex   = 5
487:         THIS.cnt_4c_Xml.TabIndex      = 6
488: 
489:         *-- Painel TXT. SCX: Say1 = 1, getArqTXT = 2, btnGetArqO = 3,
490:         *-- chkImagens = 4, lblResults = 1 (DUPLICADO com Say1).
491:         THIS.cnt_4c_TXT.lbl_4c_LblResults.TabIndex = 1
492:         THIS.cnt_4c_TXT.lbl_4c_Label1.TabIndex     = 2
493:         THIS.cnt_4c_TXT.txt_4c_ArqTXT.TabIndex     = 3
494:         THIS.cnt_4c_TXT.cmd_4c_BtnGetArqO.TabIndex = 4
495:         THIS.cnt_4c_TXT.chk_4c_ChkImagens.TabIndex = 5
496: 
497:         *-- Painel XML. SCX: btnDirs = 15, Get_arquivo = 1, getDirs = 14,
498:         *-- Say1 = 13 - so o 1 de Get_arquivo cabe e sobrevive ao load.
499:         THIS.cnt_4c_Xml.txt_4c_Arquivo.TabIndex      = 1
500:         THIS.cnt_4c_Xml.cmd_4c_BtnDirs.TabIndex      = 2
501:         THIS.cnt_4c_Xml.txt_4c_Dirs.TabIndex         = 3
502:         THIS.cnt_4c_Xml.lbl_4c_LabelArquivo.TabIndex = 4
503:     ENDPROC
504: 
505:     *==========================================================================
506:     * ConfigurarCabecalho - faixa cinza superior com o titulo da tela
507:     * (cntSombra do legado) e os dois labels sobrepostos que produzem o
508:     * efeito de sombra: lblSombra em preto (Top = 25) sob lblTitulo em
509:     * branco (Top = 24). Width/Height/Font/ForeColor transcritos do dump

*-- Linhas 517 a 577:
517:     * Form Designer, logo fixa-los eh reproducao fiel.
518:     *
519:     * Caption = THIS.Caption transcreve o "ThisForm.cntSombra.lblSombra.
520:     * Caption = ThisForm.Caption" / "...lblTitulo.Caption = ThisForm.Caption"
521:     * do Init legado - o texto "Cadastro de Testes" do dump e' so o default
522:     * generico do Form Designer, sobrescrito em runtime pelo proprio legado.
523:     *==========================================================================
524:     PROTECTED PROCEDURE ConfigurarCabecalho()
525:         LOCAL loc_oCab
526: 
527:         THIS.AddObject("cnt_4c_Sombra", "Container")
528:         loc_oCab = THIS.cnt_4c_Sombra
529:         WITH loc_oCab
530:             .Top         = 0
531:             .Left        = 0
532:             .Width       = THIS.Width
533:             .Height      = 80
534:             .BackStyle   = 1
535:             .BackColor   = RGB(100, 100, 100)
536:             .BorderWidth = 0
537:             .Visible     = .T.
538:         ENDWITH
539: 
540:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
541:         WITH loc_oCab.lbl_4c_LblSombra
542:             .AutoSize  = .F.
543:             .Top       = 25
544:             .Left      = 10
545:             .Width     = 769
546:             .Height    = 40
547:             .FontName  = "Tahoma"
548:             .FontSize  = 18
549:             .FontBold  = .T.
550:             .WordWrap  = .T.
551:             .Alignment = 0
552:             .BackStyle = 0
553:             .ForeColor = RGB(0, 0, 0)
554:             .Caption   = THIS.Caption
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
559:         WITH loc_oCab.lbl_4c_LblTitulo
560:             .AutoSize  = .F.
561:             .Top       = 24
562:             .Left      = 10
563:             .Width     = 769
564:             .Height    = 46
565:             .FontName  = "Tahoma"
566:             .FontSize  = 18
567:             .FontBold  = .T.
568:             .WordWrap  = .T.
569:             .Alignment = 0
570:             .BackStyle = 0
571:             .ForeColor = RGB(255, 255, 255)
572:             .Caption   = THIS.Caption
573:             .Visible   = .T.
574:         ENDWITH
575:     ENDPROC
576: 
577:     *==========================================================================

*-- Linhas 588 a 700:
588:     * nao BINDEVENT).
589:     *
590:     * Say1 (classe "say" sem Width/Alignment no dump) e chkImagens (classe
591:     * "fwcheckbox") repetem a armadilha de AutoSize no-op da regra #23/#33 -
592:     * AutoSize = .F. + Width explicito. Shape2 eh a moldura do resultado
593:     * (lblResults, label de progresso atualizado por
594:     * sigopgarBO.AtualizarProgresso via THIS.AtualizarProgresso - ver
595:     * abaixo).
596:     *==========================================================================
597:     PROTECTED PROCEDURE ConfigurarPainelTxt()
598:         LOCAL loc_oTxt
599: 
600:         THIS.AddObject("cnt_4c_TXT", "Container")
601:         loc_oTxt = THIS.cnt_4c_TXT
602:         WITH loc_oTxt
603:             .Top       = 155
604:             .Left      = 102
605:             .Width     = 595
606:             .Height    = 127
607:             .BackStyle = 0
608:             .Visible   = .T.
609:         ENDWITH
610: 
611:         loc_oTxt.AddObject("lbl_4c_Label1", "Label")
612:         WITH loc_oTxt.lbl_4c_Label1
613:             .Top       = 6
614:             .Left      = 11
615:             .Width     = 170
616:             .Height    = 15
617:             .AutoSize  = .F.
618:             .Alignment = 0
619:             .BackStyle = 0
620:             .FontBold  = .T.
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8
623:             .ForeColor = RGB(90, 90, 90)
624:             .Caption   = "Arquivo a Ser Gerado"
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         loc_oTxt.AddObject("txt_4c_ArqTXT", "TextBox")
629:         WITH loc_oTxt.txt_4c_ArqTXT
630:             .Top           = 23
631:             .Left          = 11
632:             .Width         = 540
633:             .Height        = 22
634:             .FontName      = "Tahoma"
635:             .FontSize      = 8
636:             .SpecialEffect = 1
637:             .ForeColor     = RGB(0, 0, 0)
638:             .BorderColor   = RGB(100, 100, 100)
639:             .ReadOnly      = .T.
640:             .TabStop       = .F.
641:             .Value         = ""
642:             .ToolTipText   = "Arquivo XML a Ser Importado"
643:             .Visible       = .T.
644:         ENDWITH
645: 
646:         loc_oTxt.AddObject("cmd_4c_BtnGetArqO", "CommandButton")
647:         WITH loc_oTxt.cmd_4c_BtnGetArqO
648:             .Top           = 18
649:             .Left          = 552
650:             .Height        = 32
651:             .Width         = 40
652:             .FontBold      = .T.
653:             .FontName      = "Verdana"
654:             .FontSize      = 10
655:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_16.jpg"
656:             .Caption         = ""
657:             .ToolTipText     = "Seleciona o Arquivo Que Ser" + CHR(225) + " Processado"
658:             .PicturePosition = 13
659:             .SpecialEffect   = 2
660:             .ForeColor       = RGB(36, 84, 155)
661:             .BackColor       = RGB(255, 255, 255)
662:             .Themes          = .T.
663:             .Visible         = .T.
664:         ENDWITH
665: 
666:         loc_oTxt.AddObject("chk_4c_ChkImagens", "CheckBox")
667:         WITH loc_oTxt.chk_4c_ChkImagens
668:             *-- Dump declara AutoSize = .T. e NAO declara Width/Height. Em
669:             *-- CheckBox criado por AddObject o AutoSize eh NO-OP (regra #23,
670:             *-- medida tambem para CheckBox): ficaria nos 100x17 do default e
671:             *-- cortaria "Exportar Imagens". Por isso AutoSize = .F. explicito
672:             *-- + Width que caiba o texto; Height = 17 eh o da classe
673:             *-- fwcheckbox (docs/FRAMEWORK_class_codigo_fonte.txt).
674:             .AutoSize      = .F.
675:             .Top           = 53
676:             .Left          = 11
677:             .Width         = 150
678:             .Height        = 17
679:             .FontBold      = .T.
680:             .FontName      = "Tahoma"
681:             .FontSize      = 8
682:             .Alignment     = 0
683:             .BackStyle     = 0
684:             .ForeColor     = RGB(90, 90, 90)
685:             .Themes        = .F.
686:             .SpecialEffect = 1
687:             .Caption       = "Exportar Imagens"
688:             .Value         = 1
689:             .Visible       = .T.
690:         ENDWITH
691: 
692:         loc_oTxt.AddObject("shp_4c_Shape2", "Shape")
693:         WITH loc_oTxt.shp_4c_Shape2
694:             .Top         = 77
695:             .Left        = 11
696:             .Width       = 560
697:             .Height      = 36
698:             .BackStyle   = 0
699:             .BorderStyle = 6
700:             .BorderWidth = 1

*-- Linhas 712 a 771:
712:             .Visible     = .T.
713:         ENDWITH
714: 
715:         loc_oTxt.AddObject("lbl_4c_LblResults", "Label")
716:         WITH loc_oTxt.lbl_4c_LblResults
717:             .Top       = 88
718:             .Left      = 19
719:             .Width     = 543
720:             .Height    = 15
721:             .AutoSize  = .F.
722:             .Alignment = 0
723:             .BackStyle = 0
724:             .FontBold  = .T.
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .ForeColor = RGB(90, 90, 90)
728:             .Caption   = ""
729:             .Visible   = .T.
730:         ENDWITH
731:     ENDPROC
732: 
733:     *==========================================================================
734:     * ConfigurarBotoes - Shape1 (moldura decorativa) + os dois botoes de
735:     * acao do legado (Cancela -> cmd_4c_Cancela / Processa -> cmd_4c_
736:     * Processa), ambos classe fwbtng (framework.vcx). O dump so sobrescreve
737:     * Top/Left/Picture/Caption (e Cancel em Cancela) - Height/Width/Font*/
738:     * WordWrap/MousePointer/ForeColor/BackColor/Themes vem do DEFAULT da
739:     * classe fwbtng (docs/FRAMEWORK_class_codigo_fonte.txt), mesmo padrao
740:     * usado em ConfigurarBotoes() de Formsigopecm.prg (dialogo-irmao).
741:     *
742:     * "\<Processar" preserva o marcador de tecla de acesso (Alt+P) do VFP9 -
743:     * sintaxe nativa, nao removida na migracao.
744:     *==========================================================================
745:     PROTECTED PROCEDURE ConfigurarBotoes()
746:         THIS.AddObject("shp_4c_Shape1", "Shape")
747:         WITH THIS.shp_4c_Shape1
748:             .Top           = 7
749:             .Left          = 615
750:             .Width         = 173
751:             .Height        = 110
752:             .BackStyle     = 0
753:             .BorderStyle   = 0
754:             .SpecialEffect = 1
755:             .BorderColor   = RGB(136, 189, 188)
756:             .Visible       = .T.
757:         ENDWITH
758: 
759:         THIS.AddObject("cmd_4c_Cancela", "CommandButton")
760:         WITH THIS.cmd_4c_Cancela
761:             .Top          = 3
762:             .Left         = 724
763:             .Height       = 100
764:             .Width        = 80
765:             .Cancel       = .T.
766:             .Caption      = "Encerrar"
767:             .Picture      = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
768:             .FontBold     = .T.
769:             .FontItalic   = .T.
770:             .FontName     = "Comic Sans MS"
771:             .FontSize     = 8

*-- Linhas 777 a 791:
777:             .Visible      = .T.
778:         ENDWITH
779: 
780:         THIS.AddObject("cmd_4c_Processa", "CommandButton")
781:         WITH THIS.cmd_4c_Processa
782:             .Top          = 3
783:             .Left         = 649
784:             .Height       = 100
785:             .Width        = 80
786:             .Caption      = "\<Processar"
787:             .Picture      = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
788:             .FontBold     = .T.
789:             .FontItalic   = .T.
790:             .FontName     = "Comic Sans MS"
791:             .FontSize     = 8

*-- Linhas 799 a 835:
799:     ENDPROC
800: 
801:     *==========================================================================
802:     * ConfigurarChkXml - checkbox que alterna entre o painel TXT (default) e
803:     * o painel XML (chkXml -> chk_4c_ChkXml). Classe "checkbox" PURA no dump
804:     * (nao "fwcheckbox", diferente de chk_4c_ChkImagens) - sem default de
805:     * framework para herdar, entao a transcricao fica so no que o dump
806:     * declara (Top/Left/Width/Height/Caption), com Font/ForeColor no padrao
807:     * de label de dados do projeto (CLAUDE.md regra #12) por nao haver
808:     * override proprio.
809:     *==========================================================================
810:     PROTECTED PROCEDURE ConfigurarChkXml()
811:         THIS.AddObject("chk_4c_ChkXml", "CheckBox")
812:         WITH THIS.chk_4c_ChkXml
813:             *-- AutoSize = .F. pelo mesmo motivo de chk_4c_ChkImagens (no-op em
814:             *-- AddObject) - aqui o dump JA traz Width/Height explicitos.
815:             *-- FontBold NAO entra: o dump de chkXml nao o declara e a classe eh
816:             *-- "checkbox" PURA (default .F.) - diferente de chkImagens, que eh
817:             *-- "fwcheckbox" e cujo dump declara FontBold = .T. Marcar negrito
818:             *-- aqui engrossaria uma legenda que o legado desenha fina.
819:             .AutoSize  = .F.
820:             .Top       = 90
821:             .Left      = 108
822:             .Width     = 152
823:             .Height    = 15
824:             .FontBold  = .F.
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .Alignment = 0
828:             .BackStyle = 0
829:             .ForeColor = RGB(90, 90, 90)
830:             .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Arquivo em XML"
831:             .Value     = 0
832:             .Visible   = .T.
833:         ENDWITH
834:     ENDPROC
835: 

*-- Linhas 853 a 871:
853:         THIS.AddObject("cnt_4c_Xml", "Container")
854:         loc_oXml = THIS.cnt_4c_Xml
855:         WITH loc_oXml
856:             .Top       = 109
857:             .Left      = 102
858:             .Width     = 595
859:             .Height    = 47
860:             .BackStyle = 0
861:         ENDWITH
862: 
863:         loc_oXml.AddObject("lbl_4c_LabelArquivo", "Label")
864:         WITH loc_oXml.lbl_4c_LabelArquivo
865:             .Top        = 15
866:             .Left       = 30
867:             .Width      = 45
868:             .Height     = 15
869:             .AutoSize   = .F.
870:             .Alignment  = 0
871:             .BackStyle  = 0

*-- Linhas 879 a 887:
879:             .FontName   = "Tahoma"
880:             .FontSize   = 8
881:             .ForeColor  = RGB(90, 90, 90)
882:             .Caption    = "Arquivo :"
883:             .Visible    = .T.
884:         ENDWITH
885: 
886:         *-- CAMPO APOSENTADO E SOTERRADO no proprio legado (regra #28).
887:         *-- Get_arquivo e getDirs tem o MESMO Top (11) e o MESMO Left (78) no

*-- Linhas 908 a 917:
908:         *-- nenhum metodo de sigopgarBO o consome - exatamente como no legado.
909:         loc_oXml.AddObject("txt_4c_Arquivo", "TextBox")
910:         WITH loc_oXml.txt_4c_Arquivo
911:             .Top       = 11
912:             .Left      = 78
913:             .Width     = 150
914:             *-- Height = 23 (NAO 22): o dump de Get_arquivo nao declara Height,
915:             *-- entao vale o default da classe "fwget", que eh 23. SpecialEffect
916:             *-- e BorderColor NAO entram - nem o dump nem a fwget os declaram
917:             *-- (sao do IRMAO getArqTXT, textbox PURA, cujo dump declara os

*-- Linhas 929 a 938:
929: 
930:         loc_oXml.AddObject("txt_4c_Dirs", "TextBox")
931:         WITH loc_oXml.txt_4c_Dirs
932:             .Top           = 11
933:             .Left          = 78
934:             .Width         = 421
935:             .Height        = 23
936:             .FontName      = "Tahoma"
937:             .FontSize      = 8
938:             .SpecialEffect = 1

*-- Linhas 958 a 982:
958:         *-- Picture/Caption/ToolTipText/PicturePosition. Verdana 10 /
959:         *-- SpecialEffect = 2 / ForeColor 36,84,155 pertencem ao IRMAO
960:         *-- btnGetArqO, cujo dump os declara - copia-los para ca era invencao.
961:         loc_oXml.AddObject("cmd_4c_BtnDirs", "CommandButton")
962:         WITH loc_oXml.cmd_4c_BtnDirs
963:             .Top             = 6
964:             .Left            = 500
965:             .Height          = 32
966:             .Width           = 40
967:             .FontBold        = .T.
968:             .FontItalic      = .T.
969:             .FontName        = "Comic Sans MS"
970:             .FontSize        = 8
971:             .WordWrap        = .T.
972:             .MousePointer    = 15
973:             *-- geral_pasta_26.jpg (com 26, NAO 16): o 16 eh o icone do IRMAO
974:             *-- btnGetArqO. Os DOIS arquivos existem em vbmp\, entao o nome
975:             *-- errado desenharia um icone sem erro nenhum (regra #25).
976:             .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
977:             .Caption         = ""
978:             .ToolTipText     = "Carregar o Diret" + CHR(243) + "rio / Pasta de Grava" + ;
979:                                CHR(231) + CHR(227) + "o do Arquivo"
980:             .PicturePosition = 13
981:             .ForeColor       = RGB(90, 90, 90)
982:             .BackColor       = RGB(255, 255, 255)

*-- Linhas 1070 a 1087:
1070:     * .F. / Thisform.cntTXT.visible = .T.", que sao exatamente este estado com
1071:     * chkXml.Value = 0).
1072:     *
1073:     * Le o CHECKBOX, nao uma copia do modo: o controle eh a fonte unica do que
1074:     * o usuario escolheu (mesmo criterio do campo de filtro da regra #35b) -
1075:     * guardar o modo numa property e consultar ela aqui criaria a segunda copia
1076:     * que este metodo existe para evitar.
1077:     *
1078:     * PUBLIC (sem PROTECTED): o harness de teste chama metodos do form de FORA
1079:     * da classe, e PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo em metodo
1080:     * PROTECTED - o teste entraria no branch e a chamada real falharia em
1081:     * runtime com "Property APLICARPAINELPORMODO is not found" (regra #3).
1082:     * Chamar de fora eh seguro: o metodo so LE o checkbox e escreve .Visible,
1083:     * logo eh idempotente.
1084:     *==========================================================================
1085:     PROCEDURE AplicarPainelPorModo()
1086:         IF VARTYPE(THIS.chk_4c_ChkXml) != "O" OR ;
1087:            VARTYPE(THIS.cnt_4c_TXT) != "O" OR ;

*-- Linhas 1109 a 1117:
1109:     * confiar numa copia que ja pode ter ficado velha (CLAUDE.md #44, item 6).
1110:     *
1111:     * "TODOS os campos" (cobranca da Fase 8) esta satisfeito por construcao: o
1112:     * dump tem exatamente TRES TextBox e DOIS CheckBox, e os cinco aparecem
1113:     * aqui. Os dois TextBox de caminho (txt_4c_ArqTXT e txt_4c_Dirs) sao
1114:     * ReadOnly = .T. - o valor so chega pelo picker do botao de pasta vizinho -
1115:     * e txt_4c_Arquivo eh o campo soterrado documentado em
1116:     * ConfigurarPainelXml(), que por isso chega SEMPRE vazio ao BO. Os tres sao
1117:     * lidos de qualquer forma: decidir quais campos consumir eh do BO, nao

*-- Linhas 1155 a 1163:
1155:     * chkXml sem Value, isto eh 0) - e este hook, que roda DEPOIS deles, eh
1156:     * quem tem a ultima palavra.
1157:     *
1158:     * Conversao EXPLICITA logico -> numerico com IIF: CheckBox.Value eh
1159:     * NUMERICO e atribuir .T./.F. direto o converteria para logico, estourando
1160:     * "Operator/operand type mismatch" no primeiro LimparCampos (que grava 0).
1161:     *
1162:     * PROTECTED EXPLICITO pelo MESMO motivo de LimparCampos, acima (regra #51).
1163:     *==========================================================================

*-- Linhas 1333 a 1345:
1333:     *
1334:     * Fase 8: renomeado - o handler era batizado pelo CAPTION do botao e
1335:     * agora segue o OBJETO, como nos outros oito sites do projeto que ligam
1336:     * um cmd_4c_Cancela. O objeto do legado chama-se "Cancela" e declara
1337:     * Cancel = .T. (a tecla ESC o aciona), entao "cancelar" descreve o papel
1338:     * dele melhor do que o Caption, que o dump traz como "Encerrar" e que
1339:     * segue transcrito tal e qual em ConfigurarBotoes(). O canonico
1340:     * cmd_4c_Encerrar da CLAUDE.md #10 eh do bloco de saida dos forms CRUD -
1341:     * nao deste dialogo, cujo botao tem nome proprio no SCX.
1342:     *==========================================================================
1343:     PROCEDURE BtnCancelarClick()
1344:         THIS.Release()
1345:     ENDPROC

*-- Linhas 1384 a 1394:
1384:     *==========================================================================
1385:     * ChkXmlClick - equivale a SIGOPGAR.chkXml.Valid: limpa os tres campos
1386:     * de arquivo/diretorio dos dois paineis e alterna qual painel fica
1387:     * visivel, conforme o Value do checkbox (1 = XML, 0 = TXT). Ligado em
1388:     * "Click" (nao em "Valid" - BINDEVENT em TextBox/CheckBox "Valid" nao
1389:     * dispara de forma confiavel, regra CLAUDE.md #3/#46); no CheckBox,
1390:     * Click dispara DEPOIS do toggle de .Value, entao ler THIS.chk_4c_
1391:     * ChkXml.Value aqui ja reflete a escolha do usuario, igual ao This.
1392:     * Value do Valid legado.
1393:     *==========================================================================
1394:     PROCEDURE ChkXmlClick()

*-- Linhas 1404 a 1412:
1404:     *==========================================================================
1405:     * AtualizarProgresso - contrato com sigopgarBO.AtualizarProgresso, que
1406:     * chama este metodo a cada grupo/produto processado (equivale ao
1407:     * "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan de
1408:     * ProcessaTxt no legado). PUBLIC porque quem chama eh o BO, de fora da
1409:     * classe.
1410:     *
1411:     * O texto eh sempre guardado em this_cUltimoProgresso e so entao
1412:     * exibido, se o label de resultado do painel TXT ja existir - assim o

*-- Linhas 1419 a 1429:
1419:         loc_cTexto = IIF(VARTYPE(par_cTexto) = "C", par_cTexto, "")
1420:         THIS.this_cUltimoProgresso = loc_cTexto
1421: 
1422:         IF PEMSTATUS(THIS, "cnt_4c_TXT", 5) AND PEMSTATUS(THIS.cnt_4c_TXT, "lbl_4c_LblResults", 5)
1423:             THIS.cnt_4c_TXT.lbl_4c_LblResults.Caption = loc_cTexto
1424:             THIS.cnt_4c_TXT.lbl_4c_LblResults.Refresh()
1425:             DOEVENTS
1426:         ENDIF
1427:     ENDPROC
1428: 
1429:     *==========================================================================


### BO (C:\4c\projeto\app\classes\sigopgarBO.prg):
*==============================================================================
* sigopgarBO.prg
*
* Business Object para sigopgar (Gera Arquivo)
* Dialogo filho MODAL ("Gera Arquivo"), aberto por um formulario de consulta/
* selecao de produtos para exportar os produtos SELECIONADOS para um arquivo
* em disco, em um de dois formatos escolhidos pelo usuario (chkXml):
*
*   - chkXml.Value = 1 (XML): gera um XML via XMLAdapter com os produtos do
*     cursor de origem (Produto/Descricao/Grupo/Unidade/Modelo/Foto/DataAlt),
*     salvando no arquivo/diretorio escolhido em CntXml.getDirs.
*   - chkXml.Value = 0 (TXT, default): gera um arquivo TXT de largura fixa
*     (protocolo proprio "td01"/"td03") com um registro por Grupo distinto e
*     um registro por Produto, mais a exportacao de cada foto (FigJpgs) como
*     .jpg separado na mesma pasta do TXT (ProcessaTxt/ExportaProduto no
*     legado), usando o arquivo escolhido em CntTXT.getArqTXT.
*
* Nao possui tabela principal propria: a origem dos produtos e o cursor
* global CrImagens, populado pelo formulario pai ANTES de abrir este dialogo
* (equivalente ao parametro oObjForm do Init legado - aqui this_cCursorOrigem
* documenta o nome do cursor recebido). A gravacao real deste BO e em ARQUIVO
* (StrToFile), nao em tabela do SQL Server - os unicos SQLEXEC existentes sao
* leituras auxiliares (SigCdGrp/SigCdPro/SigPrCar+SigCrRap) para montar o
* conteudo exportado.
*
* Criado na Fase 1 (propriedades e Init). Completo a partir da Fase 2 com
* os metodos que GERAM O ARQUIVO (GerarArquivo/GerarArquivoXml/
* GerarArquivoTxt/ExportarXml) - os "metodos CRUD" deste BO, ja que nao
* ha Inserir()/Atualizar() de tabela neste dialogo (ver acima).
*==============================================================================

DEFINE CLASS sigopgarBO AS BusinessBase

    *-- Cursor de origem dos produtos selecionados (equivalente a CrImagens
    *-- no legado), recebido do formulario pai antes de abrir este dialogo
    this_cCursorOrigem      = ""    && char - nome do cursor com os produtos selecionados (colunas Cpros/Cgrus/Cunis/FigJpgs)

    *-- Modo de geracao escolhido pelo usuario (chkXml.Valid no legado)
    this_lGeraXml           = .F.   && logical - .T. = gera arquivo XML (CntXml visivel) / .F. = gera arquivo TXT (CntTXT visivel), default .F.

    *-- Painel XML (CntXml) - visivel quando this_lGeraXml = .T.
    this_cCodArquivo        = ""    && char(20) - CntXml.Get_arquivo.Value ("Arquivo :") - codigo informativo do arquivo XML (Format "K!" no legado)
    this_cArquivoXml        = ""    && char - CntXml.getDirs.Value - caminho completo do arquivo XML de destino (extensao .xml obrigatoria)

    *-- Painel TXT (CntTXT) - visivel quando this_lGeraXml = .F. (default)
    this_cArquivoTxt        = ""    && char - CntTXT.getArqTXT.Value - caminho completo do arquivo TXT de destino
    this_lExportarImagens   = .T.   && logical - CntTXT.chkImagens.Value - exporta as fotos (FigJpgs) dos produtos como .jpg junto ao TXT, default .T. (Value=1 no SCX)

    *-- Progresso exibido durante a geracao do TXT (CntTXT.lblResults.Caption
    *-- no legado - atualizado a cada grupo/produto processado)
    this_cMensagemProgresso = ""    && char/memo - texto de progresso ("Processando N Grupo(s) / Produtos Gerados : M")
    this_nQtdGrupos         = 0     && numeric - total de grupos distintos no cursor de origem (lnQtd no legado)
    this_nQtdProdutos       = 0     && numeric - total de produtos efetivamente gravados no TXT (lnCnt no legado)

    *-- Referencia opcional ao form para repintar o progresso durante
    *-- GerarArquivoTxt (equivalente ao "ThisForm.cntTxt.lblResults.Caption
    *-- = ..." repetido dentro do Scan de ProcessaTxt no legado). Fica
    *-- .NULL. quando o BO eh usado sem interface (ex.: teste automatizado).
    this_oFormUI            = .NULL.

    *--------------------------------------------------------------------------
    * Init - Inicializa Business Object. Sem tabela principal propria (a
    * gravacao efetiva eh em arquivo, nao em tabela do SQL Server - ver
    * cabecalho da classe).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""

        *-- Cursor global montado pelo formulario pai antes de abrir este
        *-- dialogo (equivalente a CrImagens, citado direto por nome no
        *-- Init/Processamento/ProcessaTxt do legado - nao e parametro do
        *-- Init legado). Mantido como property (em vez de literal fixo)
        *-- para permitir que o Form troque o nome, se precisar.
        THIS.this_cCursorOrigem = "crImagens"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel. Este dialogo nao tem tabela/cursor
    * de registro unico: a origem dos dados eh this_cCursorOrigem (cursor
    * externo populado pelo formulario pai), percorrido inteiro pelo metodo
    * de geracao do arquivo, nao carregado campo a campo numa property.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel. A persistencia deste dialogo eh em ARQUIVO
    * (StrToFile do XML/TXT gerado), nao em INSERT no SQL Server.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel, pelo mesmo motivo de Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Nao aplicavel: sem tabela nem chave primaria
    * propria neste dialogo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Nao aplicavel: sem gravacao em tabela do SQL
    * Server neste dialogo, nao ha operacao para auditar aqui.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN
    ENDPROC

    *==========================================================================
    * METODOS DE PROCESSAMENTO (equivalentes as operacoes de gravacao deste
    * dialogo - ver cabecalho da classe: a persistencia real e em ARQUIVO,
    * nunca em INSERT/UPDATE de tabela, entao os "metodos CRUD" deste BO sao
    * os que GERAM O ARQUIVO, nao Inserir()/Atualizar() de BusinessBase
    * (mesmo padrao adotado em sigopecmBO.prg para forms operacionais sem
    * tabela propria).
    *==========================================================================

    *--------------------------------------------------------------------------
    * AtualizarProgresso - Repinta o andamento do processamento (equivalente
    * ao "ThisForm.cntTxt.lblResults.Caption = ..." repetido dentro do Scan
    * de ProcessaTxt no legado). Delega para um metodo PUBLIC do form
    * (THIS.this_oFormUI.AtualizarProgresso(cTexto)), que o Form (Fase 3)
    * implementa para repintar o label dele e fazer Refresh(). Nao faz nada
    * quando this_oFormUI esta .NULL. (BO usado sem interface).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarProgresso(par_nQtdGrupos, par_nQtdProdutos)
        LOCAL loc_cTexto

        loc_cTexto = "Processando " + ALLTRIM(STR(par_nQtdGrupos, 10)) + " Grupo" + ;
            IIF(par_nQtdGrupos = 1, "", "s") + " / " + ;
            "Produtos Gerados : " + ALLTRIM(STR(par_nQtdProdutos, 10))

        THIS.this_cMensagemProgresso = loc_cTexto

        IF VARTYPE(THIS.this_oFormUI) = "O" AND PEMSTATUS(THIS.this_oFormUI, "AtualizarProgresso", 5)
            THIS.this_oFormUI.AtualizarProgresso(loc_cTexto)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivo - Ponto de entrada do processamento (equivalente a
    * SIGOPGAR.Processamento no legado). Fecha o cursor auxiliar de XML
    * (equivalente ao "If Used([csArqXMl]) / Use In csArqXMl" do topo do
    * legado) e despacha para GerarArquivoXml() ou GerarArquivoTxt()
    * conforme this_lGeraXml (chkXml.Value).
    *--------------------------------------------------------------------------
    PROCEDURE GerarArquivo()
        IF USED("cursor_4c_ArqXml")
            USE IN cursor_4c_ArqXml
        ENDIF

        IF THIS.this_lGeraXml
            RETURN THIS.GerarArquivoXml()
        ELSE
            RETURN THIS.GerarArquivoTxt()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoXml - Gera o arquivo XML com os produtos do cursor de
    * origem (equivalente ao ramo "Else" de Processamento + ExportaProduto
    * no legado - chkXml.Value = 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoXml   - caminho completo do .xml de destino
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *
    * Contrato de erro: falha de validacao (arquivo vazio/extensao errada/
    * sem produtos selecionados) preenche this_cMensagemErro e retorna .F.
    * SEM exibir MsgErro - quem exibe eh o Form (BtnProcessarClickExec,
    * com MsgAviso), igual ao legado, que devolve .F. e deixa a
    * MessageBox para o chamador. O SetFocus que o legado faz nesses
    * ramos (btnDirs no XML, btnGetArqO no TXT, Cancela no fim de
    * ProcessaTxt) NAO foi reproduzido de proposito: Processa.Click
    * executa "Thisform.Processamento() / Thisform.Release" SEM
    * condicionar ao retorno, entao o dialogo fecha logo depois e o
    * foco recem-posto nunca chega a ser visto. Reproduzi-lo seria
    * acrescentar linha inobservavel; o que importa para o PILAR 1 -
    * mensagem identica e dialogo fechando - esta reproduzido.
    * Falha de SQL exibe o proprio MsgErro aqui, igual ao resto da classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoXml()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cProduto, loc_cSQL, loc_nResultado

        loc_lResultado          = .F.
        THIS.this_cMensagemErro = ""
        loc_cArquivo            = ALLTRIM(NVL(THIS.this_cArquivoXml, ""))
        loc_cCursorOrigem       = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "Arquivo n" + CHR(227) + "o informado!!!"
            ELSE
                IF UPPER(JUSTEXT(loc_cArquivo)) != "XML"
                    THIS.this_cMensagemErro = "Arquivo com Extens" + CHR(227) + "o inv" + CHR(225) + "lida!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        IF USED("cursor_4c_ArqXml")
                            USE IN cursor_4c_ArqXml
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ArqXml (Produto C(14), Descricao C(254), Grupo C(3), Unidade C(3), Modelo C(3), Foto W, DataAlt T)
                        SET NULL OFF
                        INDEX ON Produto TAG Produto

                        loc_lResultado = .T.

                        SELECT (loc_cCursorOrigem)
                        GO TOP
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cProduto = EVALUATE(loc_cCursorOrigem + ".Cpros")

                            loc_cSQL = "SELECT a.DPro3s, a.CodFinP, b.DataAlts" + ;
                                " FROM SigCdPro a JOIN SigCdPrc b ON a.cpros = b.cpros" + ;
                                " WHERE a.cpros = " + EscaparSQL(loc_cProduto)

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ArqXmlProd")

                            IF loc_nResultado < 0
                                MsgErro("Falha na Gera" + CHR(231) + CHR(227) + "o do Arquivo. Reinicie o Processo...", "Select (crTProd)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            INSERT INTO cursor_4c_ArqXml (Produto, Descricao, Grupo, Unidade, Modelo, Foto, DataAlt) VALUES ( ;
                                PADR(loc_cProduto, 14), ;
                                "", ;
                                EVALUATE(loc_cCursorOrigem + ".Cgrus"), ;
                                EVALUATE(loc_cCursorOrigem + ".Cunis"), ;
                                "", ;
                                NVL(EVALUATE(loc_cCursorOrigem + ".FigJpgs"), ""), ;
                                CTOD(""))

                            IF USED("cursor_4c_ArqXmlProd") AND RECCOUNT("cursor_4c_ArqXmlProd") > 0
                                SELECT cursor_4c_ArqXml
                                REPLACE Descricao WITH ALLTRIM(LEFT(TratarNulo(cursor_4c_ArqXmlProd.DPro3s, ""), 254)), ;
                                        Modelo    WITH TratarNulo(cursor_4c_ArqXmlProd.CodFinP, ""), ;
                                        DataAlt   WITH cursor_4c_ArqXmlProd.DataAlts
                            ENDIF

                            IF USED("cursor_4c_ArqXmlProd")
                                USE IN cursor_4c_ArqXmlProd
                            ENDIF

                            SELECT (loc_cCursorOrigem)
                        ENDSCAN

                        IF loc_lResultado
                            SELECT cursor_4c_ArqXml
                            GO TOP

                            THIS.ExportarXml(loc_cArquivo)

                            IF FILE(loc_cArquivo)
                                MsgInfo("Arquivo Gerado com Sucesso", "Gera" + CHR(231) + CHR(227) + "o de Arquivo")
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo XML: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_ArqXmlProd")
                USE IN cursor_4c_ArqXmlProd
            ENDIF
            IF USED("cursor_4c_ArqXml")
                USE IN cursor_4c_ArqXml
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarXml - Grava em disco o arquivo XML com o conteudo do cursor
    * cursor_4c_ArqXml (equivalente a ExportaProduto() no legado - usa
    * XMLAdapter para serializar o cursor e grava a string resultante com
    * StrToFile).
    *
    * NOTA: XMLAdapter.ToXML() recebe o NOME da variavel de saida (como
    * string) e preenche essa variavel por substituicao - igual ao legado
    * (.ToXML([lcStr]) seguido de StrToFile(lcStr, ...)). Passar o VALOR de
    * loc_cStr no lugar do nome "loc_cStr" produziria XML vazio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExportarXml(par_cArquivo)
        LOCAL loc_oXml, loc_cStr
        loc_cStr = ""

        loc_oXml = CREATEOBJECT("XMLAdapter")

        WITH loc_oXml
            .RespectCursorCP = .T.
            .RespectNesting  = .T.
            .UTF8Encoded     = .T.
            .FormattedOutput = .T.
            .XMLName         = STRCONV("cpros", 12)

            .AddTableSchema("cursor_4c_ArqXml")
            .ToXML("loc_cStr")
        ENDWITH

        STRTOFILE(loc_cStr, par_cArquivo, 0)

        loc_oXml = .NULL.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarArquivoTxt - Gera o arquivo TXT de largura fixa (protocolo
    * "td01"/"td03") com um registro por Grupo distinto e um registro por
    * Produto do cursor de origem, mais a exportacao de cada foto (FigJpgs)
    * como .jpg separado na mesma pasta do TXT (equivalente a ProcessaTxt
    * no legado - chkXml.Value <> 1).
    *
    * Pre-requisitos (setados pelo Form antes de chamar):
    *   THIS.this_cArquivoTxt   - caminho completo do .txt a ser gerado
    *   THIS.this_cCursorOrigem - nome do cursor com os produtos
    *                             selecionados (default "crImagens", ver Init)
    *   THIS.this_oFormUI       - opcional, para repintar o progresso
    *
    * this_lExportarImagens NAO entra aqui: este metodo nao a le, porque o
    * legado tambem nao - CntTXT.chkImagens aparece so na arvore de objetos
    * e nas propriedades do SCX, nunca referenciado dentro de ProcessaTxt.
    * Acrescentar essa checagem seria inventar restricao que o legado nao
    * tem (PILAR 1 / CLAUDE.md regra #49) - a imagem e exportada sempre que
    * SigCdPro.FigJpgs estiver preenchido, independente da caixa marcada.
    *
    * Contrato de erro: igual a GerarArquivoXml() - falha de validacao
    * preenche this_cMensagemErro e retorna .F. sem MsgErro; falha de SQL
    * exibe o proprio MsgErro aqui.
    *
    * Retorno: .T. se o processamento rodou do inicio ao fim (mesmo que
    * nenhum produto tenha sido gerado - igual ao legado, que so muda a
    * mensagem final, nunca o retorno); .F. em falha de validacao ou de SQL.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE GerarArquivoTxt()
        LOCAL loc_lResultado, loc_oErro
        LOCAL loc_cArquivo, loc_cCursorOrigem, loc_cChr, loc_cSQL, loc_nResultado
        LOCAL loc_nQtdGrupos, loc_nQtdProdutos
        LOCAL loc_cGru, loc_cDes, loc_cUni, loc_cStr
        LOCAL loc_cRef, loc_cDat, loc_cSit, loc_cPes, loc_cIpi, loc_cIcm, loc_cClf, loc_cTri, loc_cVal, loc_cPre
        LOCAL loc_cGvd, loc_cGr1, loc_cDe1, loc_cUn1
        LOCAL loc_cImg, loc_cFoto

        loc_lResultado = .F.
        THIS.this_cMensagemErro      = ""
        THIS.this_nQtdGrupos         = 0
        THIS.this_nQtdProdutos       = 0
        THIS.this_cMensagemProgresso = ""

        loc_cArquivo      = ALLTRIM(NVL(THIS.this_cArquivoTxt, ""))
        loc_cCursorOrigem = ALLTRIM(NVL(THIS.this_cCursorOrigem, ""))

        TRY
            IF EMPTY(loc_cArquivo)
                THIS.this_cMensagemErro = "O Arquivo a Ser Gerado N" + CHR(227) + "o Foi Informado!!!"
            ELSE
                *-- Testa se o arquivo pode ser criado (igual ao legado)
                STRTOFILE("", loc_cArquivo, 0)

                IF !FILE(loc_cArquivo)
                    THIS.this_cMensagemErro = "O Arquivo N" + CHR(227) + "o Pode Ser Criado!!!"
                ELSE
                    IF EMPTY(loc_cCursorOrigem) OR !USED(loc_cCursorOrigem)
                        THIS.this_cMensagemErro = "Nenhum produto selecionado para exportar."
                    ELSE
                        loc_cChr = CHR(13) + CHR(10)

                        IF USED("cursor_4c_GruposSelec")
                            USE IN cursor_4c_GruposSelec
                        ENDIF
                        SELECT DISTINCT Cgrus FROM (loc_cCursorOrigem) ;
                            INTO CURSOR cursor_4c_GruposSelec ;
                            ORDER BY Cgrus

                        IF USED("cursor_4c_ControleGrupos")
                            USE IN cursor_4c_ControleGrupos
                        ENDIF
                        SET NULL ON
                        CREATE CURSOR cursor_4c_ControleGrupos (Grupo N(8))
                        SET NULL OFF
                        INDEX ON Grupo TAG Grupo

                        loc_nQtdGrupos   = RECCOUNT("cursor_4c_GruposSelec")
                        loc_nQtdProdutos = 0

                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                        loc_lResultado = .T.

                        SELECT cursor_4c_GruposSelec
                        SCAN
                            IF !loc_lResultado
                                EXIT
                            ENDIF

                            loc_cSQL = "SELECT Cgrus, Dgrus, Ids" + ;
                                " FROM SigCdGrp" + ;
                                " WHERE Cgrus = " + EscaparSQL(cursor_4c_GruposSelec.Cgrus) + ;
                                "   AND Ids > 0"

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosGrupo")

                            IF loc_nResultado < 1
                                MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalGrupo)")
                                loc_lResultado = .F.
                                EXIT
                            ENDIF

                            SELECT cursor_4c_DadosGrupo
                            GO TOP

                            IF !EOF("cursor_4c_DadosGrupo")
                                loc_cGru = PADL(cursor_4c_DadosGrupo.Ids, 8, "0")
                                loc_cDes = PADR(ALLTRIM(cursor_4c_DadosGrupo.Dgrus), 40)
                                loc_cUni = PADR("", 4)

                                *-- td01 - Tabela de Grupos
                                loc_cStr = "td01" + ;           && Tipo - "td01" - Constante - Caracter(4)
                                    loc_cGru + ;                && ID - Numerico(8)
                                    loc_cDes + ;                && Descricao - Caracter(40)
                                    loc_cUni + loc_cChr         && Unidade - Caracter(4)

                                STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                IF !SEEK(cursor_4c_DadosGrupo.Ids, "cursor_4c_ControleGrupos", "Grupo")
                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_DadosGrupo.Ids)
                                ENDIF

                                *-- Produtos distintos do grupo (crPros do legado)
                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                                SELECT DISTINCT Cpros FROM (loc_cCursorOrigem) ;
                                    WHERE Cgrus = cursor_4c_GruposSelec.Cgrus ;
                                    INTO CURSOR cursor_4c_ProdutosGrupo ;
                                    ORDER BY Cpros

                                SELECT cursor_4c_ProdutosGrupo
                                SCAN
                                    loc_cSQL = "SELECT Cpros, Dpros, Cunis, DtIncs, Situas, PesoMs, Icms," + ;
                                        " AliqIpis, ClFiscals, SitTrIcms, Pvens, FigJpgs" + ;
                                        " FROM SigCdPro" + ;
                                        " WHERE Cpros = " + EscaparSQL(cursor_4c_ProdutosGrupo.Cpros)

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosProduto")

                                    IF loc_nResultado < 1
                                        MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalProds)")
                                        loc_lResultado = .F.
                                        EXIT
                                    ENDIF

                                    SELECT cursor_4c_DadosProduto
                                    GO TOP

                                    IF !EOF("cursor_4c_DadosProduto")
                                        loc_cRef = PADR(CHRTRAN(cursor_4c_DadosProduto.Cpros, [ */\:?"'<>|], []), 25)
                                        loc_cDes = PADR(ALLTRIM(cursor_4c_DadosProduto.Dpros), 60)
                                        loc_cUni = PADR(ALLTRIM(cursor_4c_DadosProduto.Cunis), 3)
                                        loc_cDat = DTOC(TTOD(cursor_4c_DadosProduto.DtIncs))
                                        loc_cSit = IIF(cursor_4c_DadosProduto.Situas = 2, "i", "a")
                                        *-- PADL direto na COLUNA (nao em variavel) converte o
                                        *-- numero com as decimais DECLARADAS no SQL Server
                                        *-- (pesoms numeric(8,3), pvens numeric(11,5)); em
                                        *-- variavel usaria SET DECIMALS (regra CLAUDE.md #42
                                        *-- / sigopecmBO.GerarArquivoExportacao).
                                        loc_cPes = STRTRAN(PADL(cursor_4c_DadosProduto.PesoMs, 8, "0"), ".", ",")
                                        loc_cIpi = PADL(INT(cursor_4c_DadosProduto.AliqIpis), 2, "0")
                                        loc_cIcm = PADL(INT(cursor_4c_DadosProduto.Icms), 2, "0")
                                        loc_cClf = PADR(CHRTRAN(cursor_4c_DadosProduto.ClFiscals, [ .], []), 8)
                                        loc_cTri = PADR(cursor_4c_DadosProduto.SitTrIcms, 3)
                                        loc_cVal = STRTRAN(PADL(cursor_4c_DadosProduto.Pvens, 8, "0"), ".", ",")
                                        loc_cPre = PADR("00000000" + loc_cVal + "0000^", 400)

                                        loc_cGvd = ""

                                        *-- Colecoes/caracteristicas do produto (SigPrCar + SigCrRap)
                                        loc_cSQL = "SELECT b.Descrs, b.Ordens" + ;
                                            " FROM SigPrCar a, SigCrRap b" + ;
                                            " WHERE a.Cpros = " + EscaparSQL(cursor_4c_DadosProduto.Cpros) + ;
                                            "   AND a.Codigos = b.Codigos"

                                        IF USED("cursor_4c_Caracteristicas")
                                            USE IN cursor_4c_Caracteristicas
                                        ENDIF
                                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Caracteristicas")

                                        IF loc_nResultado < 1
                                            MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (LocalCaracs)")
                                            loc_lResultado = .F.
                                            EXIT
                                        ENDIF

                                        SELECT cursor_4c_Caracteristicas
                                        SCAN
                                            IF !EMPTY(cursor_4c_Caracteristicas.Ordens)
                                                IF !SEEK(cursor_4c_Caracteristicas.Ordens, "cursor_4c_ControleGrupos", "Grupo")
                                                    INSERT INTO cursor_4c_ControleGrupos (Grupo) VALUES (cursor_4c_Caracteristicas.Ordens)

                                                    loc_cGr1 = PADL(cursor_4c_Caracteristicas.Ordens, 8, "0")
                                                    loc_cDe1 = PADR(ALLTRIM(cursor_4c_Caracteristicas.Descrs), 40)
                                                    loc_cUn1 = PADR("", 4)

                                                    *-- td01 - Tabela de Grupos (colecao)
                                                    loc_cStr = "td01" + loc_cGr1 + loc_cDe1 + loc_cUn1 + loc_cChr

                                                    STRTOFILE(loc_cStr, loc_cArquivo, .T.)
                                                ENDIF
                                                loc_cGvd = loc_cGvd + ALLTRIM(STR(cursor_4c_Caracteristicas.Ordens, 8)) + "^"
                                            ENDIF
                                        ENDSCAN
                                        loc_cGvd = PADR(ALLTRIM(loc_cGvd), 60)

                                        *-- td03 - Tabela de Produtos
                                        loc_cStr = "td03" + ;               && Tipo - "td03" - Constante - Caracter(4)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            loc_cRef + ;                    && Referencia - Caracter(25)
                                            loc_cDes + ;                    && Descricao - Caracter(60)
                                            loc_cUni + ;                    && Unidade - Caracter(3)
                                            loc_cGru + ;                    && ID Grupo - Numerico(8)
                                            "00000000" + ;                  && ID Subgrupo - Numerico(8)
                                            loc_cDat + ;                    && Data do produto - Data(10)
                                            " " + ;                         && Alternativo - Caracter(1)
                                            "001" + ;                       && Multiplicador - Numerico(3)
                                            PADR(loc_cRef, 20) + ;          && Nome Foto Sem Extensao - Caracter(20)
                                            loc_cSit + ;                    && Status Produto a=ativo/i=inativo - Caracter(1)
                                            "00000000" + ;                  && Desconto Maximo em % - Numerico(8)
                                            "00" + ;                        && Tabela - Caracter(2)
                                            loc_cPes + ;                    && Peso - Numerico(8)
                                            " " + ;                         && Status Foto - Caracter(1)
                                            " " + ;                         && Lancamento - Caracter(1)
                                            loc_cIpi + ;                    && % do IPI - Numerico(2)
                                            "00000000" + ;                  && Valor IPI - Numerico(8)
                                            loc_cIcm + ;                    && % ICMS - Numerico(2)
                                            "00000000" + ;                  && Valor ICMS - Numerico(8)
                                            loc_cClf + ;                    && Classificacao Fiscal - Caracter(8)
                                            loc_cTri + ;                    && Situacao Tributaria - Caracter(3)
                                            SPACE(8) + ;                    && RESERVADO - Caracter(8)
                                            "00000000" + ;                  && Estoque - Numerico(8)
                                            loc_cPre + ;                    && Lista(8)+Preco(8)+QtdeMinima(4)+^ - Caracter(400)
                                            SPACE(20) + ;                   && Codigo de Barras - Caracter(20)
                                            SPACE(64) + ;                   && RESERVADO - Caracter(64)
                                            SPACE(400) + ;                  && Caracteristicas (separador CHR(13)) - Caracter(400)
                                            loc_cGvd + loc_cChr             && Material/Complemento - Caracter(60)

                                        STRTOFILE(loc_cStr, loc_cArquivo, .T.)

                                        loc_nQtdProdutos = loc_nQtdProdutos + 1
                                        THIS.AtualizarProgresso(loc_nQtdGrupos, loc_nQtdProdutos)

                                        *-- Exportando a imagem. O legado NAO consulta
                                        *-- chkImagens aqui - ver nota de
                                        *-- this_lExportarImagens no cabecalho do metodo.
                                        IF !EMPTY(cursor_4c_DadosProduto.FigJpgs) AND !ISNULL(cursor_4c_DadosProduto.FigJpgs)
                                            loc_cImg  = ALLTRIM(JUSTPATH(loc_cArquivo)) + "\" + ALLTRIM(loc_cRef) + ".Jpg"
                                            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(cursor_4c_DadosProduto.FigJpgs, ;
                                                "data:image/png;base64,", ""), ;
                                                "data:image/jpeg;base64,", ""), ;
                                                "data:image/jpg;base64,", ""), 14)
                                            STRTOFILE(loc_cFoto, loc_cImg)
                                        ENDIF
                                    ENDIF

                                    IF USED("cursor_4c_DadosProduto")
                                        USE IN cursor_4c_DadosProduto
                                    ENDIF
                                    IF USED("cursor_4c_Caracteristicas")
                                        USE IN cursor_4c_Caracteristicas
                                    ENDIF
                                ENDSCAN

                                IF USED("cursor_4c_ProdutosGrupo")
                                    USE IN cursor_4c_ProdutosGrupo
                                ENDIF
                            ENDIF

                            IF USED("cursor_4c_DadosGrupo")
                                USE IN cursor_4c_DadosGrupo
                            ENDIF
                        ENDSCAN

                        THIS.this_nQtdGrupos   = loc_nQtdGrupos
                        THIS.this_nQtdProdutos = loc_nQtdProdutos

                        IF loc_lResultado
                            IF loc_nQtdProdutos > 0
                                THIS.this_cMensagemProgresso = "Arquivo de Produtos Gerado Com Sucesso!!!"
                            ELSE
                                THIS.this_cMensagemProgresso = "Aten" + CHR(231) + CHR(227) + "o!!! Arquivo Gerado Sem Produtos!!!"
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao gerar arquivo TXT: " + loc_oErro.Message + ;
                CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo)
            loc_lResultado = .F.
        FINALLY
            IF USED("cursor_4c_GruposSelec")
                USE IN cursor_4c_GruposSelec
            ENDIF
            IF USED("cursor_4c_ProdutosGrupo")
                USE IN cursor_4c_ProdutosGrupo
            ENDIF
            IF USED("cursor_4c_ControleGrupos")
                USE IN cursor_4c_ControleGrupos
            ENDIF
            IF USED("cursor_4c_DadosGrupo")
                USE IN cursor_4c_DadosGrupo
            ENDIF
            IF USED("cursor_4c_DadosProduto")
                USE IN cursor_4c_DadosProduto
            ENDIF
            IF USED("cursor_4c_Caracteristicas")
                USE IN cursor_4c_Caracteristicas
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

