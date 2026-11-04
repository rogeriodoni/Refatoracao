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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2301 linhas total):

*-- Linhas 28 a 36:
28: *                     Thisform.PcEscolha          = IIF(EMPTY(poForm.PcEscolha), ;
29: *                                                       "INSERIR", poForm.PcEscolha)
30: *                     Thisform.ParentForm.Enabled = .F.
31: *                     .Caption = 'Faixa de Valores da Operacao ' + ;
32: *                                AllTrim(Proper(crSigCdOpe.Dopes))
33: *
34: *    SIGOPCRD.cmdSair.Click : Thisform.ParentForm.Enabled = .T.
35: *                             ThisForm.Release
36: *

*-- Linhas 51 a 71:
51: *------------------------------------------------------------------------------
52: * ESCOPO JA ENTREGUE
53: *
54: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
55: * completo (contexto do pai + BO + InicializarForm), cabecalho cinza
56: * (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
57: *
58: * Fase 4/8 - corpo da tela: Shape1 decorativo, a grade de 4 colunas
59: * (GradeSubN -> grd_4c_Dados) com o bind do cursor, e os DOIS botoes do dump
60: * (cmdExcluir -> cmd_4c_Excluir, cmdSair -> cmd_4c_Encerrar) com os Click
61: * transcritos do legado.
62: *
63: * Fase 5/8 - auditoria de propriedades + ordem de tabulacao. Esta tela NAO
64: * tem campo solto algum: os unicos controles de ENTRADA do SCX sao os quatro
65: * Text1 das colunas da grade, que vieram com ela na Fase 4. Como nao ha
66: * "metade dos campos" a acrescentar (e inventar campo violaria o PILAR 1), a
67: * fase foi gasta no que de fato sobra num form FLAT - conferir, propriedade
68: * por propriedade, o que a criacao em massa da Fase 4 derrubou. As 150
69: * propriedades do dump foram cruzadas uma a uma com o .prg; faltavam tres:
70: *
71: *   TitleBar = 0 (form)   - estava SO no comentario, sem declaracao. Com o

*-- Linhas 492 a 514:
492:     *==========================================================================
493:     * AjustarCaption - titulo dinamico da tela e dos labels do cabecalho
494:     *
495:     * Legado: .Caption = 'Faixa de Valores da Operacao ' + ;
496:     *                    AllTrim(Proper(crSigCdOpe.Dopes))
497:     *         ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
498:     *         ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
499:     *
500:     * Sem operacao no contexto o Caption de projeto do SCX eh preservado, para
501:     * a tela nunca exibir "... da Operacao" com o nome em branco.
502:     *==========================================================================
503:     PROCEDURE AjustarCaption()
504:         LOCAL loc_cOperacao
505: 
506:         loc_cOperacao = ALLTRIM(NVL(THIS.this_cOperacao, ""))
507: 
508:         IF !EMPTY(loc_cOperacao)
509:             THIS.Caption = "Faixa de Valores da Opera" + CHR(231) + CHR(227) + "o " + ;
510:                            ALLTRIM(PROPER(loc_cOperacao))
511:         ENDIF
512: 
513:         THIS.this_cTituloForm = THIS.Caption
514: 

*-- Linhas 558 a 597:
558:     * Nao ha compensacao de +29: sem PageFrame, os Top do dump sao absolutos.
559:     * O cabecalho eh o PRIMEIRO AddObject da tela (regra #11), para que a
560:     * grade e os botoes criados nas fases seguintes desenhem POR CIMA dele.
561:     *==========================================================================
562:     PROTECTED PROCEDURE ConfigurarCabecalho()
563:         THIS.AddObject("cnt_4c_Sombra", "Container")
564:         WITH THIS.cnt_4c_Sombra
565:             .Top          = 0
566:             .Left         = 0
567:             .Width        = THIS.Width
568:             .Height       = 80
569:             .BorderWidth  = 0
570:             .BackStyle    = 1
571:             .BackColor    = RGB(100, 100, 100)
572:             .SpecialEffect = 0
573:             .Visible      = .T.
574:         ENDWITH
575: 
576:         *-- Label de sombra: preto, 1px acima do titulo (efeito de relevo)
577:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Sombra", "Label")
578:         WITH THIS.cnt_4c_Sombra.lbl_4c_Sombra
579:             *-- AutoSize = .F. explicito: AutoSize eh NO-OP em Label criado
580:             *-- por AddObject e, com WordWrap = .T., DESCARTA a Height e
581:             *-- corta o texto (regra #23).
582:             .AutoSize   = .F.
583:             .FontName   = "Tahoma"
584:             .FontSize   = 18
585:             .FontBold   = .T.
586:             .FontUnderline = .F.
587:             .WordWrap   = .T.
588:             .Alignment  = 0
589:             .BackStyle  = 0
590:             .Caption    = THIS.Caption
591:             .Top        = 18
592:             .Left       = 10
593:             .Width      = THIS.Width - 20
594:             .Height     = 40
595:             .ForeColor  = RGB(0, 0, 0)
596:             *-- Rotation = 0 esta no dump. Eh o DEFAULT, entao a atribuicao eh
597:             *-- inerte - medido no VFP9 (2026-10-30): Rotation lido de volta = 0

*-- Linhas 603 a 629:
603:             .Visible    = .T.
604:         ENDWITH
605: 
606:         *-- Label do titulo: branco sobre o cinza do container OPACO - este eh
607:         *-- o caso em que o branco esta CORRETO (regra #12)
608:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_Titulo", "Label")
609:         WITH THIS.cnt_4c_Sombra.lbl_4c_Titulo
610:             .AutoSize   = .F.
611:             .FontName   = "Tahoma"
612:             .FontSize   = 18
613:             .FontBold   = .T.
614:             .WordWrap   = .T.
615:             .Alignment  = 0
616:             .BackStyle  = 0
617:             .Caption    = THIS.Caption
618:             .Top        = 17
619:             .Left       = 10
620:             .Width      = THIS.Width - 20
621:             .Height     = 46
622:             .ForeColor  = RGB(255, 255, 255)
623:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
624:             *-- Rotation = 0 do dump - ver a nota em lbl_4c_Sombra acima
625:             .Rotation   = 0
626:             .Visible    = .T.
627:         ENDWITH
628: 
629:         RETURN .T.

*-- Linhas 711 a 732:
711:             THIS.grd_4c_Dados.TabIndex = 1
712:         ENDIF
713: 
714:         *-- Cabecalho: so tem Label dentro, nao para o Tab. Fica em 2 porque
715:         *-- eh o que o load do legado produz, nao por escolha.
716:         IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
717:             THIS.cnt_4c_Sombra.TabIndex = 2
718:         ENDIF
719: 
720:         *-- Botoes, na ordem dos registros do SCX (Left 450, depois 525)
721:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
722:             THIS.cmd_4c_Excluir.TabIndex = 3
723:         ENDIF
724: 
725:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
726:             THIS.cmd_4c_Encerrar.TabIndex = 4
727:         ENDIF
728: 
729:         RETURN .T.
730:     ENDPROC
731: 
732: 

*-- Linhas 750 a 759:
750:     PROTECTED PROCEDURE ConfigurarShapeDecorativo()
751:         THIS.AddObject("shp_4c_Shape1", "Shape")
752:         WITH THIS.shp_4c_Shape1
753:             .Top         = 7
754:             .Left        = 205
755:             .Height      = 110
756:             .Width       = 173
757:             .BackStyle   = 0
758:             .BorderStyle = 0
759:             .BorderColor = RGB(136, 189, 188)

*-- Linhas 798 a 807:
798:         THIS.AddObject("grd_4c_Dados", "Grid")
799:         WITH THIS.grd_4c_Dados
800:             .ColumnCount    = 4
801:             .Top            = 103
802:             .Left           = 118
803:             .Width          = 363
804:             .Height         = 227
805:             .FontName       = "Tahoma"
806:             .FontSize       = 8
807:             .RowHeight      = 16

*-- Linhas 876 a 884:
876:                 .FontName  = "Tahoma"
877:                 .FontSize  = 8
878:                 .Alignment = 2
879:                 .Caption   = "Faixa Inicial"
880:             ENDWITH
881:             WITH .Text1
882:                 .FontName    = "Tahoma"
883:                 .FontSize    = 8
884:                 .BorderStyle = 0

*-- Linhas 900 a 908:
900:                 .FontName  = "Tahoma"
901:                 .FontSize  = 8
902:                 .Alignment = 2
903:                 .Caption   = "Faixa Final"
904:             ENDWITH
905:             WITH .Text1
906:                 .FontName    = "Tahoma"
907:                 .FontSize    = 8
908:                 .BorderStyle = 0

*-- Linhas 923 a 931:
923:                 .FontName  = "Tahoma"
924:                 .FontSize  = 8
925:                 .Alignment = 2
926:                 .Caption   = "%"
927:             ENDWITH
928:             WITH .Text1
929:                 .FontName    = "Tahoma"
930:                 .FontSize    = 8
931:                 .BorderStyle = 0

*-- Linhas 947 a 955:
947:                 .FontName  = "Tahoma"
948:                 .FontSize  = 8
949:                 .Alignment = 2
950:                 .Caption   = "Multiplos"
951:             ENDWITH
952:             WITH .Text1
953:                 .FontName    = "Tahoma"
954:                 .FontSize    = 8
955:                 .BorderStyle = 0

*-- Linhas 977 a 988:
977:     * sao as canonicas de botao do projeto (Comic Sans MS 8 bold italic,
978:     * ForeColor 90,90,90 sobre BackColor branco, Themes, PicturePosition 13).
979:     *
980:     * Nomes canonicos do projeto (cmd_4c_Excluir / cmd_4c_Encerrar), nao os
981:     * cmd_4c_CmdExcluir / cmd_4c_CmdSair do mapeamento gerado: o mapeamento de
982:     * validacao de UI eh regerado a partir DESTE .prg, e os patterns do
983:     * CorretorAutomatico e a regra #10 falam de cmd_4c_Encerrar.
984:     *
985:     * .Themes = .T. + .DisabledPicture obrigatorios: botao standalone com
986:     * .Picture e Themes = .F. NAO desenha o icone quando fica .Enabled = .F.,
987:     * e o Excluir eh justamente o que o legado desabilita por falta de acesso.
988:     *

*-- Linhas 997 a 1011:
997:     * alem do clique - por isso ReabilitarFormPai tambem roda no Destroy.
998:     *==========================================================================
999:     PROTECTED PROCEDURE ConfigurarBotoes()
1000:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
1001:         WITH THIS.cmd_4c_Excluir
1002:             .Top             = 3
1003:             .Left            = 450
1004:             .Width           = 75
1005:             .Height          = 75
1006:             .Caption         = "Excluir"
1007:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1008:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
1009:             .PicturePosition = 13
1010:             .FontName        = "Comic Sans MS"
1011:             .FontSize        = 8

*-- Linhas 1022 a 1036:
1022:             .Visible         = .T.
1023:         ENDWITH
1024: 
1025:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
1026:         WITH THIS.cmd_4c_Encerrar
1027:             .Top             = 3
1028:             .Left            = 525
1029:             .Width           = 75
1030:             .Height          = 75
1031:             .Caption         = "Encerrar"
1032:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1033:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1034:             .PicturePosition = 13
1035:             .FontName        = "Comic Sans MS"
1036:             .FontSize        = 8

*-- Linhas 1051 a 1060:
1051:         *-- BINDEVENT so DEPOIS de os dois objetos existirem, e apontando para
1052:         *-- metodos que JA estao definidos nesta classe: delegate inexistente
1053:         *-- estoura no proprio BINDEVENT e derruba o Init.
1054:         BINDEVENT(THIS.cmd_4c_Excluir,  "Click", THIS, "CmdExcluirClick")
1055:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
1056: 
1057:         RETURN .T.
1058:     ENDPROC
1059: 
1060: 

*-- Linhas 1087 a 1102:
1087:             loc_lPodeExcluir = THIS.this_oBusinessObject.this_lPodeExcluir
1088:         ENDIF
1089: 
1090:         IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
1091:             THIS.cmd_4c_Excluir.Visible = loc_lPodeExcluir
1092:             THIS.cmd_4c_Excluir.Enabled = loc_lPodeExcluir
1093:         ENDIF
1094: 
1095:         IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1096:             THIS.cmd_4c_Encerrar.Visible = .T.
1097:             THIS.cmd_4c_Encerrar.Enabled = .T.
1098:         ENDIF
1099: 
1100:         RETURN .T.
1101:     ENDPROC
1102: 

*-- Linhas 1468 a 1480:
1468:             ENDIF
1469: 
1470:             IF loc_lVazio
1471:                 IF PEMSTATUS(THIS, "cmd_4c_Encerrar", 5)
1472:                     *-- SetFocus falha em controle que nao esta visivel e
1473:                     *-- habilitado (caminho de carga, form ainda nao mostrado).
1474:                     IF THIS.cmd_4c_Encerrar.Visible AND THIS.cmd_4c_Encerrar.Enabled
1475:                         THIS.cmd_4c_Encerrar.SetFocus()
1476:                     ENDIF
1477:                 ENDIF
1478:             ENDIF
1479:         CATCH TO loc_oErro
1480:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 2106 a 2115:
2106:                 *-- A permissao do Excluir tem fonte UNICA
2107:                 THIS.AjustarBotoesPorModo()
2108:             ELSE
2109:                 IF PEMSTATUS(THIS, "cmd_4c_Excluir", 5)
2110:                     THIS.cmd_4c_Excluir.Enabled = .F.
2111:                 ENDIF
2112:             ENDIF
2113:         CATCH TO loc_oErro
2114:             THIS.this_cMensagemErro = loc_oErro.Message
2115:             MsgErro("Erro ao ajustar a digita" + CHR(231) + CHR(227) + "o da grade:" + CHR(13) + ;

