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
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' numa tela cujo dump legado NAO declara essa fonte - trocar por 'Tahoma' SO nas linhas apontadas, nunca "todas as ocorrencias" (Erro178: o legado do SIGCDPRO declara Comic Sans MS nos 8 botoes de navegacao, e a troca em massa virou regressao de PILAR 1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprpdf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1699 linhas total):

*-- Linhas 59 a 74:
59: *                                            dentro dele sao da Fase 5/6)
60: *               ConfigurarBarraAcao        - obj_4c_OptArquivo (PDF/Excel),
61: *                                            chk_4c_Chk_EMAIL,
62: *                                            cmd_4c_Cmd_GerarPDF e
63: *                                            cmd_4c_Cmd_SAIR (a fileira de
64: *                                            Top = 3, que e' a barra de acao
65: *                                            deste dialogo)
66: *               ConfigurarAreaArquivoSaida - lbl_4c_Lbl_SalvarEm,
67: *                                            txt_4c_TxtNomeArqSaida (ReadOnly),
68: *                                            cmd_4c_CmdGetFile e
69: *                                            cmd_4c_BtnPastasA
70: *               AplicarTipoArquivoPadrao / AplicarNomeArquivoPadrao /
71: *               AlternarPainelEmail        - os defaults e o colapso do Init
72: *                                            legado (resolve a pendencia que a
73: *                                            Fase 3 deixou anotada sobre
74: *                                            "ThisForm.Height = This.Height -

*-- Linhas 82 a 104:
82: *                                            portados COMPLETOS aqui.
83: *   Fase 5:   Formsigprpdf.prg - PRIMEIRA METADE dos campos de dentro de
84: *             cnt_4c_CtnSaida_Email (De / Para / CC), em ConfigurarCamposEmail:
85: *               lbl_4c_Label1 / txt_4c_TxtEmail_EnviarDE       (De - ReadOnly)
86: *               lbl_4c_Lbl_EmailPara / obj_4c_TxtEmail_EnviarPara (Para)
87: *               lbl_4c_LblEmail_CC / obj_4c_TxtEmail_CC           (CC)
88: *             txtEmail_EnviarPara/txtEmail_CC sao EDITBOX no legado (confirmado
89: *             no layout.json), nao TextBox, apesar do nome "txt". Valor inicial
90: *             de Para replicado do Init legado ("txtEmail_EnviarPara.Value =
91: *             thisform.oParentForm.Contaemail", via PEMSTATUS porque Contaemail
92: *             e' property do form chamador). O valor de De passou a ser escrito
93: *             em CarregarContaEmailEmpresa() (agora que o campo existe),
94: *             exatamente onde o legado faz essa atribuicao - DEPOIS da consulta
95: *             a SigCdEmp, nao no Init.
96: *   Fase 6:   Formsigprpdf.prg - SEGUNDA METADE dos campos de dentro de
97: *             cnt_4c_CtnSaida_Email, no MESMO ConfigurarCamposEmail:
98: *               lbl_4c_LblEmail_Assunto / txt_4c_TxtEmail_Assunto (Assunto)
99: *               lbl_4c_LblEmail_Corpo   / obj_4c_EdtEmail_Corpo   (Texto)
100: *             Com isso o painel de e-mail esta COMPLETO (os 5 campos + os 5
101: *             labels do SCX) e o valor inicial do Assunto passou a ser escrito
102: *             aqui, replicando o Init legado ("txtEmail_Assunto.Value =
103: *             Iif(Type([pcAssunto]) = [C], pcAssunto, [])") a partir de
104: *             this_cAssunto, que o Init do form ja normaliza.

*-- Linhas 126 a 148:
126: *             Nenhum dos 5 campos referencia tabela alguma: Assunto/Texto/CC
127: *             sao texto livre, De vem da consulta a SigCdEmp (ReadOnly) e Para
128: *             vem do form chamador. O unico "seletor" da tela e' o GetFile() do
129: *             cmd_4c_CmdGetFile, que e' dialogo de ARQUIVO do proprio VFP9 (ja
130: *             portado na Fase 4), nao busca em tabela. Criar AbrirLookupXxx
131: *             aqui significaria inventar tabela de lookup que o legado nunca
132: *             consultou - proibido pelo PILAR 1 e pela regra "NUNCA inventar
133: *             tabelas de lookup".
134: *
135: *   Fase 7/8: Formsigprpdf.prg - CmdGerarPDFClick, o Click do cmd_4c_Cmd_GerarPDF
136: *             (botao criado na Fase 4; BINDEVENT ligado agora em
137: *             ConfigurarBarraAcao). Usa o que as fases anteriores ja deixaram
138: *             pronto: THIS.ValidarDadosEnvio() (sincroniza a tela com o BO,
139: *             valida e da o foco ao campo recusado) e, no BO,
140: *             this_lContaEmailCarregada + ObterMensagemContaEmailIndisponivel()
141: *             para o aviso que NAO bloqueia o fechamento e
142: *             MontarDadosEnvioEmail() para o objeto de envio que vai para
143: *             par_oFormPai.oEMAIL. A unica saida da tela (cmd_4c_Cmd_SAIR,
144: *             Cancel = .T.) ja estava ligada desde a Fase 4, entao o dialogo
145: *             nunca ficou sem como fechar. Com isto, todos os Click do SCX
146: *             legado (Init/Click de Cmd_GerarPDF, Cmd_SAIR, Chk_EMAIL,
147: *             optArquivo, cmdGetFile, btnPastasA) estao portados - o dump
148: *             (tasks\task664\sigprpdf_form_codigo_fonte.txt) nao tem mais

*-- Linhas 242 a 255:
242: *   ausente - e' esta divergencia, nao esquecimento.
243: *
244: *   .Themes = .T. + .DisabledPicture nos CommandButton com .Picture
245: *   (cmd_4c_Cmd_SAIR, cmd_4c_Cmd_GerarPDF, cmd_4c_BtnPastasA), onde o SCX
246: *   declara Themes = .F. - padrao canonico do sistema novo para botao
247: *   standalone com icone (sem isso o icone nao renderiza se o botao for
248: *   desabilitado). O CorretorAutomatico (pattern #99) aplica essa troca de
249: *   qualquer forma em cada bloco "WITH THIS.cmd_4c_*" que tenha .Picture, entao
250: *   o codigo ja e' emitido no formato final. cmd_4c_CmdGetFile NAO tem .Picture
251: *   e por isso mantem o Themes = .F. do legado.
252: *
253: *   fundo_cad_1003.jpg - o CorretorAutomatico (pattern #168) emite AVISO de que
254: *   este form nao usa essa textura. NAO se aplica aqui: fundo_cad_1003.jpg e' o
255: *   fundo das Pages de form CRUD, e este e' um dialogo OPERACIONAL FLAT cujo

*-- Linhas 321 a 341:
321:     * proprio do legado), confere a conexao global (equivalente a
322:     * "If .poDataMgr.pnIdconn > 0 / Else MessageBox(...)"), resolve
323:     * this_cDiretorio (equivalente a "ThisForm.Diretorio =
324:     * goSistema.DirFiscais"), monta a tela e aplica os defaults.
325:     *
326:     * A ORDEM de criacao importa: cnt_4c_Sombra (faixa cinza, Top = 0..80,
327:     * Width = 1100) vem PRIMEIRO; a barra de acao (Top = 3..78) e' criada
328:     * DEPOIS para desenhar POR CIMA dela. E ConfigurarPainelEmail vem antes da
329:     * barra porque AlternarPainelEmail le a .Height daquele container para
330:     * encolher o form, que e' a primeira coisa que o Init legado faz.
331:     *--------------------------------------------------------------------------
332:     PROTECTED PROCEDURE InicializarForm()
333:         LOCAL loc_lSucesso, loc_oErro, loc_cDiretorio
334:         loc_lSucesso = .F.
335: 
336:         TRY
337:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpdfBO")
338: 
339:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
340:                 MsgErro("Erro ao criar sigprpdfBO." + CHR(13) + ;
341:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;

*-- Linhas 416 a 439:
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarCabecalho()
418:         LOCAL loc_oErro
419: 
420:         TRY
421:             THIS.AddObject("cnt_4c_Sombra", "Container")
422:             WITH THIS.cnt_4c_Sombra
423:                 .Top         = 0
424:                 .Left        = 0
425:                 .Width       = 1100
426:                 .Height      = 80
427:                 .BackColor   = RGB(100, 100, 100)
428:                 .BackStyle   = 1
429:                 .BorderWidth = 0
430: 
431:                 .AddObject("lbl_4c_Sombra", "Label")
432:                 WITH .lbl_4c_Sombra
433:                     .Top       = 18
434:                     .Left      = 10
435:                     *-- Canonico do sistema novo: os labels da faixa acompanham
436:                     *-- a largura do FORM (o SCX declara 769). O
437:                     *-- CorretorAutomatico (HEADER-WIDTH-TOTAL) aplica esta
438:                     *-- troca de qualquer forma, entao ja fica no formato final -
439:                     *-- NAO reverter para 769. Inerte visualmente: o label e'

*-- Linhas 449 a 463:
449:                     .WordWrap  = .T.
450:                     .Alignment = 0
451:                     .ForeColor = RGB(0, 0, 0)
452:                     .Caption   = THIS.Caption
453:                 ENDWITH
454: 
455:                 .AddObject("lbl_4c_Titulo", "Label")
456:                 WITH .lbl_4c_Titulo
457:                     .Top       = 17
458:                     .Left      = 10
459:                     *-- Canonico do sistema novo: os labels da faixa acompanham
460:                     *-- a largura do FORM (o SCX declara 769). O
461:                     *-- CorretorAutomatico (HEADER-WIDTH-TOTAL) aplica esta
462:                     *-- troca de qualquer forma, entao ja fica no formato final -
463:                     *-- NAO reverter para 769. Inerte visualmente: o label e'

*-- Linhas 473 a 481:
473:                     .WordWrap  = .T.
474:                     .Alignment = 0
475:                     .ForeColor = RGB(255, 255, 255)
476:                     .Caption   = THIS.Caption
477:                 ENDWITH
478: 
479:                 .Visible = .T.
480:             ENDWITH
481:         CATCH TO loc_oErro

*-- Linhas 508 a 517:
508:         TRY
509:             THIS.AddObject("cnt_4c_CtnSaida_Email", "Container")
510:             WITH THIS.cnt_4c_CtnSaida_Email
511:                 .Top         = 148
512:                 .Left        = 155
513:                 .Width       = 480
514:                 .Height      = 185
515:                 .BackStyle   = 0
516:                 .BorderWidth = 0
517:                 .TabIndex    = 7

*-- Linhas 583 a 612:
583:             loc_oPainel = THIS.cnt_4c_CtnSaida_Email
584: 
585:             *-- Label1 ("De:")
586:             loc_oPainel.AddObject("lbl_4c_Label1", "Label")
587:             WITH loc_oPainel.lbl_4c_Label1
588:                 .Top       = 8
589:                 .Left      = 47
590:                 .Width     = 19
591:                 .Height    = 15
592:                 .AutoSize  = .F.
593:                 .BackStyle = 0
594:                 .Alignment = 0
595:                 .FontName  = "Tahoma"
596:                 .FontSize  = 8
597:                 .Caption   = "De:"
598:                 .ForeColor = RGB(90, 90, 90)
599:                 .TabIndex  = 1
600:             ENDWITH
601: 
602:             *-- txtEmail_EnviarDE (De) - ReadOnly: preenchido so pela
603:             *-- consulta a SigCdEmp (CarregarContaEmailEmpresa)
604:             loc_oPainel.AddObject("txt_4c_TxtEmail_EnviarDE", "TextBox")
605:             WITH loc_oPainel.txt_4c_TxtEmail_EnviarDE
606:                 .Top               = 5
607:                 .Left              = 68
608:                 .Width             = 404
609:                 .Height            = 23
610:                 .FontName          = "Tahoma"
611:                 .FontSize          = 8
612:                 .ReadOnly          = .T.

*-- Linhas 619 a 704:
619:             ENDWITH
620: 
621:             *-- lbl_EmailPara ("Para:")
622:             loc_oPainel.AddObject("lbl_4c_Lbl_EmailPara", "Label")
623:             WITH loc_oPainel.lbl_4c_Lbl_EmailPara
624:                 .Top       = 38
625:                 .Left      = 38
626:                 .Width     = 28
627:                 .Height    = 15
628:                 .AutoSize  = .F.
629:                 .BackStyle = 0
630:                 .Alignment = 0
631:                 .FontName  = "Tahoma"
632:                 .FontSize  = 8
633:                 .Caption   = "Para:"
634:                 .ForeColor = RGB(90, 90, 90)
635:                 .TabIndex  = 3
636:             ENDWITH
637: 
638:             *-- txtEmail_EnviarPara (Para) - EDITBOX (ScrollBars = 0)
639:             loc_oPainel.AddObject("obj_4c_TxtEmail_EnviarPara", "EditBox")
640:             WITH loc_oPainel.obj_4c_TxtEmail_EnviarPara
641:                 .Top           = 35
642:                 .Left          = 68
643:                 .Width         = 404
644:                 .Height        = 23
645:                 .FontName      = "Tahoma"
646:                 .FontSize      = 8
647:                 .ScrollBars    = 0
648:                 .SpecialEffect = 1
649:                 .BorderColor   = RGB(100, 100, 100)
650:                 .TabIndex      = 4
651:                 .Value         = ""
652:             ENDWITH
653: 
654:             *-- lblEmail_CC ("CC:")
655:             loc_oPainel.AddObject("lbl_4c_LblEmail_CC", "Label")
656:             WITH loc_oPainel.lbl_4c_LblEmail_CC
657:                 .Top       = 68
658:                 .Left      = 46
659:                 .Width     = 20
660:                 .Height    = 15
661:                 .AutoSize  = .F.
662:                 .BackStyle = 0
663:                 .Alignment = 0
664:                 .FontName  = "Tahoma"
665:                 .FontSize  = 8
666:                 .Caption   = "CC:"
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .TabIndex  = 5
669:             ENDWITH
670: 
671:             *-- txtEmail_CC (CC) - EDITBOX (ScrollBars = 0)
672:             loc_oPainel.AddObject("obj_4c_TxtEmail_CC", "EditBox")
673:             WITH loc_oPainel.obj_4c_TxtEmail_CC
674:                 .Top           = 65
675:                 .Left          = 68
676:                 .Width         = 404
677:                 .Height        = 23
678:                 .FontName      = "Tahoma"
679:                 .FontSize      = 8
680:                 .ScrollBars    = 0
681:                 .SpecialEffect = 1
682:                 .BorderColor   = RGB(100, 100, 100)
683:                 .TabIndex      = 6
684:                 .Value         = ""
685:             ENDWITH
686: 
687:             *-- lblEmail_Assunto ("Assunto:")
688:             loc_oPainel.AddObject("lbl_4c_LblEmail_Assunto", "Label")
689:             WITH loc_oPainel.lbl_4c_LblEmail_Assunto
690:                 .Top       = 99
691:                 .Left      = 21
692:                 .Width     = 45
693:                 .Height    = 15
694:                 .AutoSize  = .F.
695:                 .BackStyle = 0
696:                 .Alignment = 0
697:                 .FontName  = "Tahoma"
698:                 .FontSize  = 8
699:                 .Caption   = "Assunto:"
700:                 .ForeColor = RGB(90, 90, 90)
701:                 .TabIndex  = 7
702:             ENDWITH
703: 
704:             *-- txtEmail_Assunto (Assunto) - TEXTBOX de verdade no legado

*-- Linhas 711 a 757:
711:             *-- cortaria assunto longo que o legado aceita.
712:             loc_oPainel.AddObject("txt_4c_TxtEmail_Assunto", "TextBox")
713:             WITH loc_oPainel.txt_4c_TxtEmail_Assunto
714:                 .Top           = 95
715:                 .Left          = 68
716:                 .Width         = 404
717:                 .Height        = 23
718:                 .FontName      = "Tahoma"
719:                 .FontSize      = 8
720:                 .SpecialEffect = 1
721:                 .BorderColor   = RGB(100, 100, 100)
722:                 .TabIndex      = 8
723:                 .Value         = ""
724:             ENDWITH
725: 
726:             *-- lblEmail_Corpo ("Texto:")
727:             loc_oPainel.AddObject("lbl_4c_LblEmail_Corpo", "Label")
728:             WITH loc_oPainel.lbl_4c_LblEmail_Corpo
729:                 .Top       = 127
730:                 .Left      = 32
731:                 .Width     = 34
732:                 .Height    = 15
733:                 .AutoSize  = .F.
734:                 .BackStyle = 0
735:                 .Alignment = 0
736:                 .FontName  = "Tahoma"
737:                 .FontSize  = 8
738:                 .Caption   = "Texto:"
739:                 .ForeColor = RGB(90, 90, 90)
740:                 .TabIndex  = 9
741:             ENDWITH
742: 
743:             *-- EdtEmail_Corpo (Texto) - EDITBOX de varias linhas (H = 53).
744:             *-- E' o UNICO EditBox do painel em que o SCX NAO declara
745:             *-- ScrollBars = 0, entao fica com o default do VFP9 (2 =
746:             *-- vertical) - nao se escreve a propriedade aqui justamente para
747:             *-- reproduzir a ausencia dela no dump: o corpo do e-mail e' o
748:             *-- campo que de fato precisa rolar.
749:             loc_oPainel.AddObject("obj_4c_EdtEmail_Corpo", "EditBox")
750:             WITH loc_oPainel.obj_4c_EdtEmail_Corpo
751:                 .Top           = 125
752:                 .Left          = 68
753:                 .Width         = 404
754:                 .Height        = 53
755:                 .FontName      = "Tahoma"
756:                 .FontSize      = 8
757:                 .SpecialEffect = 1

*-- Linhas 791 a 891:
791:     * Cmd_SAIR. Estruturalmente e' o que o cnt_4c_Botoes e' num form CRUD, mas
792:     * aqui os controles ficam DIRETO no form, como no SCX legado (sem container
793:     * agrupador - ver layout.json).
794:     *
795:     * Criada DEPOIS de ConfigurarCabecalho de proposito: a faixa cinza
796:     * (cnt_4c_Sombra) ocupa Top = 0..80 com Width = 1100, logo estes controles
797:     * (Top = 3..78, Left = 420..800) ficam DENTRO da area dela e so aparecem se
798:     * forem criados depois - AddObject empilha o ultimo objeto por cima.
799:     *
800:     * Propriedades vindas da CLASSE fwoption (framework.vcx, lida como DBF) e
801:     * nao declaradas no SCX: no grupo, BackStyle = 0 e BorderStyle = 0; nos dois
802:     * OptionButton, BackStyle = 0, FontSize = 8 e DisabledForeColor =
803:     * 128,128,128. O SCX declara AutoSize = .T. no grupo, mas AutoSize e' no-op
804:     * em controle criado por AddObject - os Width = 161 / Height = 85 do SCX JA
805:     * SAO o auto-size que o Form Designer calculou (5 + 75 + 5 = 85), entao
806:     * fixa-los com AutoSize = .F. e' reproducao fiel, nao desvio. OptionGroup
807:     * NAO tem ForeColor: a cor mora em cada Buttons(N).
808:     *--------------------------------------------------------------------------
809:     PROTECTED PROCEDURE ConfigurarBarraAcao()
810:         LOCAL loc_oErro
811: 
812:         TRY
813:             *-- optArquivo: tipo do arquivo de saida (1 = PDF, 2 = XLS).
814:             *-- OptionGroup.Value e' INDICE 1-based, nunca booleano.
815:             THIS.AddObject("obj_4c_OptArquivo", "OptionGroup")
816:             WITH THIS.obj_4c_OptArquivo
817:                 .Top         = -2
818:                 .Left        = 420
819:                 .Width       = 161
820:                 .Height      = 85
821:                 .ButtonCount = 2
822:                 .AutoSize    = .F.
823:                 .BackStyle   = 0
824:                 .BorderStyle = 0
825:                 .Themes      = .T.
826:                 .TabIndex    = 1
827:                 .Value       = 1
828: 
829:                 WITH .Buttons(1)
830:                     .Top               = 5
831:                     .Left              = 5
832:                     .Width             = 75
833:                     .Height            = 75
834:                     .Style             = 1
835:                     .FontBold          = .T.
836:                     .FontItalic        = .T.
837:                     .FontName          = "Comic Sans MS"
838:                     .FontSize          = 8
839:                     .Caption           = "PDF"
840:                     .Picture           = gc_4c_CaminhoIcones + "pdf_60.png"
841:                     .DisabledPicture   = gc_4c_CaminhoIcones + "pdf_60.png"
842:                     .BackStyle         = 0
843:                     .BackColor         = RGB(255, 255, 255)
844:                     .ForeColor         = RGB(90, 90, 90)
845:                     .DisabledForeColor = RGB(128, 128, 128)
846:                     .Themes            = .F.
847:                 ENDWITH
848: 
849:                 WITH .Buttons(2)
850:                     .Top               = 5
851:                     .Left              = 81
852:                     .Width             = 75
853:                     .Height            = 75
854:                     .Style             = 1
855:                     .FontBold          = .T.
856:                     .FontItalic        = .T.
857:                     .FontName          = "Comic Sans MS"
858:                     .FontSize          = 8
859:                     .Caption           = "Excel"
860:                     .Picture           = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
861:                     .DisabledPicture   = gc_4c_CaminhoIcones + "geral_excel_60.jpg"
862:                     .BackStyle         = 0
863:                     .BackColor         = RGB(255, 255, 255)
864:                     .ForeColor         = RGB(90, 90, 90)
865:                     .DisabledForeColor = RGB(128, 128, 128)
866:                     .Themes            = .F.
867:                 ENDWITH
868:             ENDWITH
869:             BINDEVENT(THIS.obj_4c_OptArquivo, "Click", THIS, "OptArquivoClick")
870: 
871:             *-- Chk_EMAIL: liga/desliga o bloco de e-mail. CheckBox GRAFICO
872:             *-- (Style = 1) - .Value e' NUMERICO (0/1), nunca .T./.F.
873:             THIS.AddObject("chk_4c_Chk_EMAIL", "CheckBox")
874:             WITH THIS.chk_4c_Chk_EMAIL
875:                 .Top        = 3
876:                 .Left       = 575
877:                 .Width      = 75
878:                 .Height     = 75
879:                 .Style      = 1
880:                 .AutoSize   = .F.
881:                 .FontBold   = .T.
882:                 .FontItalic = .T.
883:                 .FontName   = "Comic Sans MS"
884:                 .FontSize   = 8
885:                 .Alignment  = 0
886:                 .Caption    = "Email"
887:                 .Picture    = gc_4c_CaminhoIcones + "geral_enderecos_60.jpg"
888:                 .ForeColor  = RGB(90, 90, 90)
889:                 .BackColor  = RGB(255, 255, 255)
890:                 .Themes     = .F.
891:                 .TabIndex   = 2

*-- Linhas 899 a 954:
899:             *-- ver o roteiro das fases no cabecalho do arquivo.
900:             *-- O .Tag guarda o Caption de origem, igual ao
901:             *-- "Cmd_GerarPDF.Init: This.Tag = This.Caption" do legado.
902:             THIS.AddObject("cmd_4c_Cmd_GerarPDF", "CommandButton")
903:             WITH THIS.cmd_4c_Cmd_GerarPDF
904:                 .Top             = 3
905:                 .Left            = 650
906:                 .Width           = 75
907:                 .Height          = 75
908:                 .FontBold        = .T.
909:                 .FontItalic      = .T.
910:                 .FontName        = "Comic Sans MS"
911:                 .FontSize        = 8
912:                 .WordWrap        = .F.
913:                 .Alignment       = 6
914:                 .PicturePosition = 13
915:                 .Caption         = "   Gravar"
916:                 .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
917:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
918:                 .ForeColor       = RGB(90, 90, 90)
919:                 .BackColor       = RGB(255, 255, 255)
920:                 .Themes          = .T.
921:                 .TabIndex        = 3
922:                 .Tag             = .Caption
923:             ENDWITH
924:             BINDEVENT(THIS.cmd_4c_Cmd_GerarPDF, "Click", THIS, "CmdGerarPDFClick")
925: 
926:             *-- Cmd_SAIR: Cancel = .T. faz o ESC aciona-lo. Como este form tem
927:             *-- TitleBar = 0 e ControlBox = .F., ele e' a UNICA saida da tela -
928:             *-- por isso o Click dele e' portado JA nesta fase.
929:             THIS.AddObject("cmd_4c_Cmd_SAIR", "CommandButton")
930:             WITH THIS.cmd_4c_Cmd_SAIR
931:                 .Top             = 3
932:                 .Left            = 725
933:                 .Width           = 75
934:                 .Height          = 75
935:                 .FontBold        = .T.
936:                 .FontItalic      = .T.
937:                 .FontName        = "Comic Sans MS"
938:                 .FontSize        = 8
939:                 .Cancel          = .T.
940:                 .Caption         = "Encerrar"
941:                 .ToolTipText     = "[ESC] - Sair"
942:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
943:                 .DisabledPicture = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"
944:                 .ForeColor       = RGB(90, 90, 90)
945:                 .BackColor       = RGB(255, 255, 255)
946:                 .Themes          = .T.
947:                 .TabIndex        = 8
948:             ENDWITH
949:             BINDEVENT(THIS.cmd_4c_Cmd_SAIR, "Click", THIS, "CmdSairClick")
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message + CHR(13) + ;
952:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
953:                 "Procedure: " + loc_oErro.Procedure, ;
954:                 "Erro Formsigprpdf.ConfigurarBarraAcao")

*-- Linhas 962 a 1010:
962:     *
963:     * txt_4c_TxtNomeArqSaida e' ReadOnly = .T. no SCX: o caminho NAO e'
964:     * digitado, ele e' escrito pelo optArquivo (default) ou pelo GetFile() do
965:     * cmd_4c_CmdGetFile. Por isso o legado declara DisabledBackColor =
966:     * 255,255,255 (branco) - para o campo travado nao parecer desabilitado. O
967:     * SCX nao declara Format nem InputMask neste campo (nao ha o que
968:     * transcrever), e MaxLength tambem nao: e' caminho de arquivo, nao coluna
969:     * de tabela - inventar um limite aqui cortaria caminho longo.
970:     *
971:     * lbl_4c_Lbl_SalvarEm: o SCX declara AutoSize = .T. com Width = 53 /
972:     * Height = 15. AutoSize e' no-op em Label criado por AddObject, entao
973:     * transcreve-se AutoSize = .F. + os Width/Height do dump, que JA SAO o
974:     * auto-size calculado pelo Form Designer. Alignment = 0 e
975:     * ForeColor = 90,90,90 saem do legado (classe "say": texto a esquerda,
976:     * cinza - branco ficaria invisivel sobre o new_background.jpg claro).
977:     *
978:     * cmd_4c_BtnPastasA (classe fwbtnp do framework.vcx, lida como DBF):
979:     * MousePointer = 15, WordWrap = .T. e BackColor = 255,255,255 vem da
980:     * classe; Caption = "" e 40x32 sao os overrides do SCX.
981:     *--------------------------------------------------------------------------
982:     PROTECTED PROCEDURE ConfigurarAreaArquivoSaida()
983:         LOCAL loc_oErro
984: 
985:         TRY
986:             THIS.AddObject("lbl_4c_Lbl_SalvarEm", "Label")
987:             WITH THIS.lbl_4c_Lbl_SalvarEm
988:                 .Top       = 109
989:                 .Left      = 150
990:                 .Width     = 53
991:                 .Height    = 15
992:                 .AutoSize  = .F.
993:                 .BackStyle = 0
994:                 .Alignment = 0
995:                 .FontName  = "Tahoma"
996:                 .FontSize  = 8
997:                 .Caption   = "Salvar em:"
998:                 .ForeColor = RGB(90, 90, 90)
999:                 .TabIndex  = 4
1000:             ENDWITH
1001: 
1002:             THIS.AddObject("txt_4c_TxtNomeArqSaida", "TextBox")
1003:             WITH THIS.txt_4c_TxtNomeArqSaida
1004:                 .Top               = 105
1005:                 .Left              = 205
1006:                 .Width             = 383
1007:                 .Height            = 23
1008:                 .FontName          = "Tahoma"
1009:                 .FontSize          = 8
1010:                 .ReadOnly          = .T.

*-- Linhas 1018 a 1066:
1018:             *-- cmdGetFile: ". . ." - abre o GetFile(). Sem .Picture no legado,
1019:             *-- por isso mantem Themes = .F. (o padrao canonico de
1020:             *-- Themes = .T. vale para botao standalone COM icone).
1021:             THIS.AddObject("cmd_4c_CmdGetFile", "CommandButton")
1022:             WITH THIS.cmd_4c_CmdGetFile
1023:                 .Top        = 104
1024:                 .Left       = 589
1025:                 .Width      = 30
1026:                 .Height     = 25
1027:                 .FontBold   = .T.
1028:                 .FontItalic = .T.
1029:                 .FontName   = "Tahoma"
1030:                 .FontSize   = 8
1031:                 .Caption    = ". . ."
1032:                 .ForeColor  = RGB(90, 90, 90)
1033:                 .BackColor  = RGB(255, 255, 255)
1034:                 .Themes     = .F.
1035:                 .TabIndex   = 6
1036:             ENDWITH
1037:             BINDEVENT(THIS.cmd_4c_CmdGetFile, "Click", THIS, "CmdGetFileClick")
1038: 
1039:             THIS.AddObject("cmd_4c_BtnPastasA", "CommandButton")
1040:             WITH THIS.cmd_4c_BtnPastasA
1041:                 .Top             = 100
1042:                 .Left            = 619
1043:                 .Width           = 40
1044:                 .Height          = 32
1045:                 .FontBold        = .T.
1046:                 .FontItalic      = .T.
1047:                 .FontName        = "Tahoma"
1048:                 .FontSize        = 8
1049:                 .WordWrap        = .T.
1050:                 .Caption         = ""
1051:                 .PicturePosition = 13
1052:                 .MousePointer    = 15
1053:                 .ToolTipText     = "Abrir o Diret" + CHR(243) + "rio / Pasta de Arquivos"
1054:                 .Picture         = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1055:                 .DisabledPicture = gc_4c_CaminhoIcones + "geral_pasta_26.jpg"
1056:                 .ForeColor       = RGB(90, 90, 90)
1057:                 .BackColor       = RGB(255, 255, 255)
1058:                 .Themes          = .T.
1059:                 .TabIndex        = 82
1060:             ENDWITH
1061:             BINDEVENT(THIS.cmd_4c_BtnPastasA, "Click", THIS, "BtnPastasAClick")
1062:         CATCH TO loc_oErro
1063:             MsgErro(loc_oErro.Message + CHR(13) + ;
1064:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1065:                 "Procedure: " + loc_oErro.Procedure, ;
1066:                 "Erro Formsigprpdf.ConfigurarAreaArquivoSaida")

*-- Linhas 1127 a 1139:
1127:     * do Chk_EMAIL legado:
1128:     *   ThisForm.LockScreen = .T.
1129:     *   If This.Value = 1
1130:     *       ThisForm.Cmd_GerarPDF.Caption = "Enviar Email"
1131:     *       ThisForm.Height = ThisForm.Height + ThisForm.CtnSaida_Email.Height
1132:     *       ThisForm.CtnSaida_Email.Visible = .T.
1133:     *   Else
1134:     *       ThisForm.Cmd_GerarPDF.Caption = [\<Gravar]
1135:     *       ThisForm.Height = ThisForm.Height - ThisForm.CtnSaida_Email.Height
1136:     *       ThisForm.CtnSaida_Email.Visible = .F.
1137:     *   EndIf
1138:     *   ThisForm.Refresh() / ThisForm.LockScreen = .F.
1139:     * e tambem ao colapso inicial do Init ("Thisform.Height = This.Height -

*-- Linhas 1265 a 1273:
1265:     *--------------------------------------------------------------------------
1266:     * SincronizarCamposParaBO - Espelha TELA -> BO todos os controles de entrada
1267:     * do dialogo. PUBLIC: chamado por ValidarDadosEnvio() e pela fase de eventos
1268:     * (o Click do cmd_4c_Cmd_GerarPDF, que precisa dos valores no BO para
1269:     * MontarDadosEnvioEmail()).
1270:     *
1271:     * Por que o CONTROLE e' a fonte unica do valor: o Cmd_GerarPDF.Click legado
1272:     * nao consulta estado guardado em lugar nenhum, ele le o .Value na hora -
1273:     *   ThisForm.oParentForm.pcArqEmail = Alltrim(Nvl(This.Parent.TxtNomeArqSaida.Value, ""))

*-- Linhas 1282 a 1290:
1282:     * que estava la na abertura. O ALLTRIM/TratarNulo reproduz o Alltrim(Nvl())
1283:     * de cada linha acima.
1284:     *
1285:     * Chk_EMAIL.Value e' NUMERICO (CheckBox criado por AddObject): compara-se
1286:     * com 1 para virar o Logico this_lEnviarEmail - atribuir o numero direto a
1287:     * uma property declarada .F. faria o proximo AND no BO estourar.
1288:     * obj_4c_OptArquivo.Value e' o INDICE 1-based do OptionGroup (1 = PDF,
1289:     * 2 = XLS), nunca booleano.
1290:     *--------------------------------------------------------------------------

*-- Linhas 1323 a 1331:
1323:     * mensagem e dado o foco), para a fase de eventos escrever
1324:     * "IF !THIS.ValidarDadosEnvio() / RETURN / ENDIF" no Click do botao.
1325:     *
1326:     * PUBLIC porque e' chamado de fora (pelo handler do cmd_4c_Cmd_GerarPDF).
1327:     *
1328:     * FONTE UNICA DA REGRA: o texto e a ORDEM das tres checagens moram em
1329:     * sigprpdfBO.ValidarDadosConfirmacao(), que e' quem para na PRIMEIRA falha e
1330:     * devolve this_cMensagemErro + this_cCampoInvalido. Aqui fica so o que o BO
1331:     * nao pode fazer: ler a tela ANTES de validar (SincronizarCamposParaBO) e

*-- Linhas 1399 a 1407:
1399: 
1400:         DO CASE
1401:             CASE loc_cCampo == "ARQUIVO"
1402:                 THIS.cmd_4c_CmdGetFile.SetFocus()
1403:             CASE loc_cCampo == "EMAIL_DE"
1404:                 IF loc_oPainel.Visible
1405:                     loc_oPainel.txt_4c_TxtEmail_EnviarDE.SetFocus()
1406:                 ENDIF
1407:             CASE loc_cCampo == "EMAIL_PARA"

*-- Linhas 1489 a 1497:
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * ChkEmailClick - PROCEDURE Click do Chk_EMAIL legado. PUBLIC (alvo de
1492:     * BINDEVENT). CheckBox.Value e' NUMERICO: compara-se com 1, nunca com .T.
1493:     *
1494:     * O Caption do Cmd_GerarPDF e' trocado AQUI porque no legado ele so muda
1495:     * dentro deste Click (o colapso do Init nao o toca - ver nota em
1496:     * AlternarPainelEmail). O literal "\<Gravar" do ramo Else e' transcrito como
1497:     * esta no legado, inclusive sem os espacos de alinhamento do Caption de

*-- Linhas 1503 a 1511:
1503: 
1504:         loc_lMarcado = (THIS.chk_4c_Chk_EMAIL.Value = 1)
1505: 
1506:         THIS.cmd_4c_Cmd_GerarPDF.Caption = IIF(loc_lMarcado, "Enviar Email", "\<Gravar")
1507: 
1508:         THIS.AlternarPainelEmail(loc_lMarcado)
1509:     ENDPROC
1510: 
1511:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\sigprpdfBO.prg):
*==============================================================================
* SIGPRPDFBO.PRG
* Business Object do formulario Formsigprpdf (Geracao de PDF e E-mail)
* Herda de: BusinessBase
*
* SIGPRPDF e um DIALOGO FILHO (WindowType = 1, modal), instanciado por outro
* form (par_oFormPai, equivalente a poformParent/ThisForm.oParentForm do
* legado) para o usuario escolher o nome/tipo do arquivo de saida (PDF ou
* XLS) e, opcionalmente, os dados do e-mail de envio. O proprio SIGPRPDF
* NAO gera o PDF/XLS nem envia o e-mail - o Cmd_GerarPDF.Click legado (linhas
* 749-823 do fonte original) apenas:
*   1) grava o caminho escolhido em ThisForm.oParentForm.pcArqEmail;
*   2) quando Chk_EMAIL.Value = 1, monta um objeto CUSTOM
*      (ThisForm.oParentForm.oEMAIL) com os dados de SMTP/mensagem via
*      AddProperty, e devolve esse objeto ao form PAI;
*   3) fecha o dialogo (ThisForm.Release()).
* Quem efetivamente gera o arquivo e dispara o envio e o form chamador
* (fora do escopo desta migracao - nao faz parte do acervo de SIGPRPDF).
*
* POR QUE this_cTabela/this_cCampoChave FICAM VAZIOS
* ---------------------------------------------------
* Nao ha CRUD nem PK proprios: a UNICA leitura ao SQL Server no Init legado
* e "Select PadEmails, PadServs, PadSenhas, pastas, PadPortas From SigCdEmp
* Where CEmps = <empresa>" (dados da conta de e-mail da empresa, colunas
* reais conferidas em docs/schema.sql - tabela sigcdemp: pademails,
* padservs, padsenhas, pastas, padportas). Nao ha Insert/Update/Delete em
* tabela nenhuma - por isso este BO (como o sigpremaBO irmao) nao sobrescreve
* Inserir()/Atualizar()/ExecutarExclusao(): o comportamento padrao herdado de
* BusinessBase (recusar a operacao) ja e o correto para esta tela.
*
* REGISTRY1 / PDFCREATOR (optArquivo.Option1.Enabled) - DECISAO DEFERIDA
* ------------------------------------------------------------------------
* O legado habilita a opcao "PDF" conforme
* "ThisForm.Registry1.IsKey('PDFCreator.clsPDFCreator') Or
* ThisForm.Registry1.IsKey('PDFCreatorBeta.JobQueue')" (deteccao de instalacao
* do PDFCreator via COM/Registro do Windows). O form irmao Formsigprema ja
* documentou a mesma checagem como NAO PORTADA (ver cabecalho de
* Formsigprema.prg) porque a geracao do PDF via PDFCreator esta fora do
* escopo do acervo migrado. A property this_lPdfCreatorDisponivel fica
* declarada aqui para a fase de Form decidir como resolve-la (registro real,
* sempre .T., ou configuravel) - Fase 1 so declara, nao decide.
*==============================================================================

DEFINE CLASS sigprpdfBO AS BusinessBase

    *-- Referencia ao form que instanciou este dialogo (equivalente a
    *-- ThisForm.oParentForm / par_oFormPai do legado) - usado para devolver
    *-- o caminho do arquivo escolhido (pcArqEmail) e os dados de envio
    *-- (oEMAIL) de volta ao chamador, e para ler o e-mail de destino inicial
    *-- (par_oFormPai.Contaemail)
    this_oFormPai = .NULL.

    *-- Diretorio padrao de saida (equivalente a ThisForm.Diretorio =
    *-- goSistema.DirFiscais), usado tanto para montar o nome default do
    *-- arquivo (FORTYUSPDF.PDF / FORTYUSEXCEL.XLS) quanto para abrir a
    *-- pasta via btnPastasA (CreateObject('Shell.Application').Open)
    this_cDiretorio = ""

    *-- Tipo de arquivo de saida (equivalente a optArquivo.Value - indice
    *-- 1-based do OptionGroup, NUNCA booleano): 1 = PDF, 2 = XLS
    this_nTipoArquivo = 1

    *-- .T. quando o PDFCreator (COM) esta disponivel na maquina
    *-- (equivalente a optArquivo.Option1.Enabled, resolvido via
    *-- Registry1.IsKey no legado - ver nota no cabecalho deste arquivo).
    *-- Resolucao definitiva fica para a fase do Form.
    this_lPdfCreatorDisponivel = .F.

    *-- Caminho completo do arquivo escolhido pelo usuario (equivalente a
    *-- txtNomeArqSaida.Value) - e o valor devolvido como
    *-- ThisForm.oParentForm.pcArqEmail ao confirmar (Cmd_GerarPDF.Click) e
    *-- tambem o anexo do e-mail (cAnexo) quando o envio esta habilitado
    this_cArquivoSaida = ""

    *-- .T. quando o usuario marcou a opcao de enviar e-mail (equivalente a
    *-- Chk_EMAIL.Value = 1) - controla a exibicao de CtnSaida_Email e se
    *-- Cmd_GerarPDF.Click monta o objeto de envio (oEMAIL) no form pai
    this_lEnviarEmail = .F.

    *-- Campos do bloco de e-mail (CtnSaida_Email), equivalentes a
    *-- cFrom/cTO/cCC/cAssunto/cCorpo do objeto oEMAIL montado no legado
    this_cEmailDe       = ""   && txtEmail_EnviarDE.Value (ReadOnly - preenchido com this_cEmpPadEmails)
    this_cEmailPara     = ""   && txtEmail_EnviarPara.Value (inicial: par_oFormPai.Contaemail)
    this_cEmailCC       = ""   && txtEmail_CC.Value
    this_cEmailAssunto  = ""   && txtEmail_Assunto.Value (inicial: par_cAssunto recebido no Init do form)
    this_cEmailCorpo    = ""   && EdtEmail_Corpo.Value

    *-- Dados da conta de e-mail da empresa (SigCdEmp.Cemps = empresa
    *-- corrente), equivalentes ao cursor TmpEmpMail do legado - colunas
    *-- reais conferidas em docs/schema.sql: pademails, padservs, padsenhas,
    *-- pastas, padportas
    this_cEmpPadEmails = ""   && pademails - conta remetente/usuario SMTP (cSendUserName/cFrom)
    this_cEmpPadServs  = ""   && padservs - servidor SMTP (cSmtpServer)
    this_cEmpPadSenhas = ""   && padsenhas - senha SMTP (cSendPassWord)
    this_cEmpPastas    = ""   && pastas - selecionada pelo legado (TmpEmpMail.pastas) mas nunca referenciada depois do Select; mantida so para rastrear a mesma consulta
    this_nEmpPadPortas = 0    && padportas - porta SMTP (nSmtpServerPort)

    *-- .T. apos ObterDadosContaEmail() carregar com sucesso os dados de
    *-- SigCdEmp (equivalente a "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0"
    *-- checado no Cmd_GerarPDF.Click legado antes de montar o objeto oEMAIL)
    this_lContaEmailCarregada = .F.

    *-- Identifica qual campo falhou na ultima chamada a
    *-- ValidarDadosConfirmacao() - "ARQUIVO" | "EMAIL_DE" | "EMAIL_PARA" |
    *-- "EMAIL_CONTA" | "" (sem falha). O Form usa isto so para decidir o
    *-- SetFocus, igual ao This.Parent.CmdGetFile.SetFocus() /
    *-- TxtEmail_EnviarDE.SetFocus() / txtEmail_EnviarPara.SetFocus() do
    *-- Cmd_GerarPDF.Click legado - a mensagem em si vai em this_cMensagemErro
    *-- (ja declarada em BusinessBase)
    this_cCampoInvalido = ""

    *==========================================================================
    * Init - Construtor
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = DODEFAULT()

            *-- SIGPRPDF nao tem tabela/PK propria (ver cabecalho do arquivo)
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            THIS.this_oFormPai = .NULL.
            THIS.this_cDiretorio = ""

            THIS.this_nTipoArquivo          = 1
            THIS.this_lPdfCreatorDisponivel = .F.
            THIS.this_cArquivoSaida         = ""
            THIS.this_lEnviarEmail          = .F.

            THIS.this_cEmailDe      = ""
            THIS.this_cEmailPara    = ""
            THIS.this_cEmailCC      = ""
            THIS.this_cEmailAssunto = ""
            THIS.this_cEmailCorpo   = ""

            THIS.this_cEmpPadEmails = ""
            THIS.this_cEmpPadServs  = ""
            THIS.this_cEmpPadSenhas = ""
            THIS.this_cEmpPastas    = ""
            THIS.this_nEmpPadPortas = 0

            THIS.this_lContaEmailCarregada = .F.
            THIS.this_cCampoInvalido       = ""
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em sigprpdfBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas do cursor da conta de e-mail da
    * empresa (SigCdEmp) para as properties deste BO. Eh o hook canonico do
    * BusinessBase e o UNICO ponto do BO que le colunas de cursor - chamado por
    * ObterDadosContaEmail() depois do SQLEXEC, e tambem utilizavel pelo Form
    * quando o cursor TmpEmpMail/equivalente ja estiver aberto.
    *
    * As conversoes sao as do Init / Cmd_GerarPDF.Click legado, coluna a coluna
    * (linhas 652 e 801-804 do fonte original) - LOWER + ALLTRIM em PadEmails e
    * PadServs, so ALLTRIM em PadSenhas, Nvl(...,0) em PadPortas:
    *   TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, [])))
    *   "cSmtpServer"     <- Lower(Alltrim(Nvl(TmpEmpMail.PadServs,  "")))
    *   "nSmtpServerPort" <-            Nvl(TmpEmpMail.PadPortas, 0)
    *   "cSendUserName"   <- Lower(Alltrim(Nvl(TmpEmpMail.PadEmails, "")))
    *   "cSendPassWord"   <-       Alltrim(Nvl(TmpEmpMail.PadSenhas, "")))
    * Tipos conferidos em docs/schema.sql (tabela sigcdemp): pademails char(50),
    * padservs char(50), padsenhas char(30), pastas char(50), padportas
    * numeric(3,0) - por isso padportas vai para a property NUMERICA
    * this_nEmpPadPortas e as demais para properties de caractere.
    *
    * Marca this_lContaEmailCarregada, que eh o equivalente migrado de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" checado no
    * Cmd_GerarPDF.Click legado antes de montar o objeto de envio.
    *
    * par_cAliasCursor: alias do cursor a ler. Retorna .T. se leu a linha.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_nAreaAnterior

        loc_lSucesso      = .F.
        loc_nAreaAnterior = SELECT()
        loc_cAlias        = IIF(VARTYPE(par_cAliasCursor) = "C", ALLTRIM(par_cAliasCursor), "")

        THIS.this_lContaEmailCarregada = .F.

        TRY
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de dados da conta de e-mail " + ;
                                          "indispon" + CHR(237) + "vel."
            ELSE
                *-- Alias dinamico: SELECT (var) + acesso DIRETO aos campos.
                *-- NUNCA campo, que eh sintaxe invalida em VFP9.
                SELECT (loc_cAlias)
                GO TOP

                IF EOF(loc_cAlias)
                    THIS.this_cMensagemErro = "Conta de e-mail n" + CHR(227) + "o " + ;
                                              "cadastrada para a empresa."
                ELSE
                    *-- Existencia de campo em CURSOR se testa com TYPE(),
                    *-- NUNCA com PEMSTATUS (que exige objeto no 1o argumento)
                    IF TYPE(loc_cAlias + ".PadEmails") != "U"
                        THIS.this_cEmpPadEmails = LOWER(ALLTRIM(TratarNulo(PadEmails, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadServs") != "U"
                        THIS.this_cEmpPadServs = LOWER(ALLTRIM(TratarNulo(PadServs, "")))
                    ENDIF

                    IF TYPE(loc_cAlias + ".PadSenhas") != "U"
                        THIS.this_cEmpPadSenhas = ALLTRIM(TratarNulo(PadSenhas, ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Pastas") != "U"
                        THIS.this_cEmpPastas = ALLTRIM(TratarNulo(Pastas, ""))
                    ENDIF

                    *-- padportas eh numeric(3,0) no schema: NVL numerico, sem
                    *-- ALLTRIM/STR (ALLTRIM sobre numerico dispara o erro 11)
                    IF TYPE(loc_cAlias + ".PadPortas") != "U"
                        THIS.this_nEmpPadPortas = NVL(PadPortas, 0)
                    ENDIF

                    *-- Init legado: TxtEmail_EnviarDE.Value recebe PadEmails
                    THIS.this_cEmailDe = THIS.this_cEmpPadEmails

                    THIS.this_lContaEmailCarregada = .T.
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.CarregarDoCursor")
        ENDTRY

        *-- Restaura a work area do chamador (o SELECT acima a trocou)
        IF loc_nAreaAnterior > 0
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDadosContaEmail - Carrega os dados da conta de e-mail parametrizada
    * para a empresa em SigCdEmp (equivalente a "Select PadEmails, PadServs,
    * PadSenhas, pastas, PadPortas From SigCdEmp Where CEmps = <empresa>"
    * no Init legado, que populava o cursor TmpEmpMail). par_cCodEmpresa deve
    * vir de go_4c_Sistema.cCodEmpresa (CLAUDE.md: NUNCA usar a legada _EMPR).
    *
    * Tambem repete o que o Init legado fazia com o resultado -
    * THIS.this_cEmailDe recebe PadEmails em minusculo/trim, equivalente a
    * "Thisform.CtnSaida_Email.TxtEmail_EnviarDE.Value = Lower(Alltrim(Nvl(
    * TmpEmpMail.PadEmails, [])))".
    *
    * Retorna .T. se a consulta foi executada com sucesso. Em caso de falha,
    * reproduz a mensagem do legado ("Favor Reinicializar o Processo!!!") em
    * this_cMensagemErro - o Form decide como exibir (MsgErro).
    *==========================================================================
    PROCEDURE ObterDadosContaEmail(par_cCodEmpresa)
        LOCAL loc_lSucesso, loc_cSQL

        loc_lSucesso = .F.
        THIS.this_lContaEmailCarregada = .F.
        THIS.this_cMensagemErro        = ""

        TRY
            IF USED("cursor_4c_TmpEmpMail")
                USE IN cursor_4c_TmpEmpMail
            ENDIF

            loc_cSQL = "SELECT PadEmails, PadServs, PadSenhas, Pastas, PadPortas " + ;
                       "FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(TratarNulo(par_cCodEmpresa, "")))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmpMail") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
            ELSE
                *-- A leitura das colunas fica num lugar so (CarregarDoCursor),
                *-- que eh o hook canonico do BusinessBase para esse mapeamento
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_TmpEmpMail")

                IF !loc_lSucesso AND EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ObterDadosContaEmail")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterNomeArquivoPadrao - Monta o nome/caminho default do arquivo de
    * saida, equivalente a:
    *   Init legado:        ThisForm.Diretorio + [FORTYUSPDF.] + Iif(... ,[PDF],[XLS])
    *   optArquivo.Click:   ThisForm.Diretorio + [FORTYUSPDF.PDF] / [FORTYUSEXCEL.XLS]
    * par_nTipoArquivo: 1 = PDF, 2 = XLS (THIS.this_nTipoArquivo - indice
    * 1-based do OptionGroup, NUNCA booleano - CLAUDE.md regra sobre
    * ControlSource numerico).
    *==========================================================================
    PROCEDURE ObterNomeArquivoPadrao(par_nTipoArquivo)
        LOCAL loc_cDir

        loc_cDir = ALLTRIM(TratarNulo(THIS.this_cDiretorio, ""))
        IF !EMPTY(loc_cDir) AND RIGHT(loc_cDir, 1) != "\"
            loc_cDir = loc_cDir + "\"
        ENDIF

        RETURN loc_cDir + IIF(par_nTipoArquivo = 1, "FORTYUSPDF.PDF", "FORTYUSEXCEL.XLS")
    ENDPROC

    *==========================================================================
    * ValidarDadosConfirmacao - Reproduz, na ordem, as DUAS checagens
    * BLOQUEANTES do Cmd_GerarPDF.Click legado - as unicas que fazem Return
    * antecipado (o dialogo NAO fecha):
    *   1) nome do arquivo de saida preenchido (senao, igual ao legado,
    *      MessageBox + This.Parent.CmdGetFile.SetFocus());
    *   2) quando this_lEnviarEmail = .T. (Chk_EMAIL.Value = 1):
    *      2a) campo 'DE:' preenchido (TxtEmail_EnviarDE.SetFocus());
    *      2b) campo 'PARA:' preenchido (txtEmail_EnviarPara.SetFocus()).
    *
    * A terceira checagem do legado (conta de e-mail da empresa ausente -
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0") NAO bloqueia: o
    * Else so exibe MessageBox('Problemas na selecao de dados do email...')
    * SEM Return, e o fluxo segue at? ThisForm.Release() (o dialogo fecha
    * mesmo assim, so sem montar o objeto de envio). Por isso essa checagem
    * fica fora deste metodo - o Form consulta THIS.this_lContaEmailCarregada
    * direto para decidir se exibe o aviso antes de chamar
    * MontarDadosEnvioEmail(), sem impedir o fechamento.
    *
    * Retorna .T. se passou nas duas checagens bloqueantes. Em caso de
    * falha, preenche this_cMensagemErro (texto IDENTICO ao MessageBox
    * legado) e this_cCampoInvalido (para o Form decidir o SetFocus) e para
    * na PRIMEIRA falha, igual ao Return antecipado do legado.
    *==========================================================================
    PROCEDURE ValidarDadosConfirmacao()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro  = ""
        THIS.this_cCampoInvalido = ""

        TRY
            IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cArquivoSaida, "")))
                THIS.this_cMensagemErro  = "Selecione um nome para o arquivo!"
                THIS.this_cCampoInvalido = "ARQUIVO"
            ELSE
                IF !THIS.this_lEnviarEmail
                    loc_lValido = .T.
                ELSE
                    IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
                        THIS.this_cMensagemErro  = "O campo 'DE:' n" + CHR(227) + "o foi preenchido."
                        THIS.this_cCampoInvalido = "EMAIL_DE"
                    ELSE
                        IF EMPTY(ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
                            THIS.this_cMensagemErro  = "O campo 'PARA:' n" + CHR(227) + "o foi preenchido."
                            THIS.this_cCampoInvalido = "EMAIL_PARA"
                        ELSE
                            loc_lValido = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro em sigprpdfBO.ValidarDadosConfirmacao")
        ENDTRY

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ObterMensagemContaEmailIndisponivel - Mensagem a exibir (sem bloquear o
    * fechamento do dialogo) quando this_lEnviarEmail = .T. mas
    * this_lContaEmailCarregada = .F. - equivalente ao Else sem Return de
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" no Cmd_GerarPDF.Click
    * legado. Ver nota em ValidarDadosConfirmacao sobre por que esta checagem
    * NAO entra na cadeia bloqueante.
    *==========================================================================
    PROCEDURE ObterMensagemContaEmailIndisponivel()
        RETURN "Problemas na sele" + CHR(231) + CHR(227) + "o de dados do email. Favor enviar novamente."
    ENDPROC

    *==========================================================================
    * MontarDadosEnvioEmail - Monta a estrutura de envio equivalente ao
    * objeto CUSTOM que o Cmd_GerarPDF.Click legado cria em
    * ThisForm.oParentForm.oEMAIL via AddProperty (cSmtpServer, nSmtpServerPort,
    * cSendUserName, cSendPassWord, cFrom, cTO, cCC, cAssunto, cCorpo, cAnexo).
    * Devolve um objeto CUSTOM com as mesmas properties, na mesma grafia, para
    * o Form atribuir direto a par_oFormPai.oEMAIL - este BO nao conhece o
    * form pai, so monta o objeto (THIS.this_oFormPai existe so para o Form
    * usar, nunca eh referenciado por este BO).
    *
    * Chamar APENAS depois de ValidarDadosConfirmacao() retornar .T. E
    * this_lContaEmailCarregada = .T. - este metodo nao revalida. Sem os
    * dados da conta (this_lContaEmailCarregada = .F.), devolve .NULL.,
    * equivalente ao legado NAO atribuir ThisForm.oParentForm.oEMAIL quando
    * "Used('TmpEmpMail') And RecCount('TmpEmpMail') > 0" falha.
    *==========================================================================
    PROCEDURE MontarDadosEnvioEmail()
        LOCAL loc_oEmail

        IF !THIS.this_lContaEmailCarregada
            RETURN .NULL.
        ENDIF

        loc_oEmail = CREATEOBJECT("Empty")

        ADDPROPERTY(loc_oEmail, "cSmtpServer",     THIS.this_cEmpPadServs)
        ADDPROPERTY(loc_oEmail, "nSmtpServerPort", THIS.this_nEmpPadPortas)
        ADDPROPERTY(loc_oEmail, "cSendUserName",   THIS.this_cEmpPadEmails)
        ADDPROPERTY(loc_oEmail, "cSendPassWord",   THIS.this_cEmpPadSenhas)
        ADDPROPERTY(loc_oEmail, "cFrom",           ALLTRIM(TratarNulo(THIS.this_cEmailDe, "")))
        ADDPROPERTY(loc_oEmail, "cTO",             ALLTRIM(TratarNulo(THIS.this_cEmailPara, "")))
        ADDPROPERTY(loc_oEmail, "cCC",             ALLTRIM(TratarNulo(THIS.this_cEmailCC, "")))
        ADDPROPERTY(loc_oEmail, "cAssunto",        ALLTRIM(TratarNulo(THIS.this_cEmailAssunto, "")))
        ADDPROPERTY(loc_oEmail, "cCorpo",           ALLTRIM(TratarNulo(THIS.this_cEmailCorpo, "")))
        ADDPROPERTY(loc_oEmail, "cAnexo",           THIS.this_cArquivoSaida)

        RETURN loc_oEmail
    ENDPROC

    *==========================================================================
    * Destroy - Libera o cursor de trabalho aberto por este BO
    *==========================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_TmpEmpMail")
            USE IN cursor_4c_TmpEmpMail
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

