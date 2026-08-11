# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'ValidarCdGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDsGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDsGrupo(par_nKeyCode, par_nShiftAltCtrl)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpg.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1210 linhas total):

*-- Linhas 26 a 154:
26: 
27:     *==========================================================================
28:     * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
29:     * FormBase.Init() chama InicializarForm() - NAO duplicar a chamada!
30:     * DataSession=2 -> FormBase.Init() tambem aplica SET DATE TO BRITISH +
31:     *                  SET CENTURY ON para corrigir exibicao de datas.
32:     *==========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Configura estrutura completa
39:     * Chamado automaticamente por FormBase.Init() via DODEFAULT()
40:     *==========================================================================
41:     PROTECTED PROCEDURE InicializarForm()
42:         LOCAL loc_lSucesso
43:         loc_lSucesso = .F.
44: 
45:         TRY
46:             THIS.this_oBusinessObject = CREATEOBJECT("FpgBO")
47: 
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MostrarErro("Erro ao criar FpgBO" + CHR(13) + ;
50:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
51:                     "FormFpg.InicializarForm")
52:             ELSE
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 THIS.pgf_4c_Paginas.Visible = .T.
59:                 THIS.pgf_4c_Paginas.ActivePage = 1
60:                 THIS.this_cModoAtual = "LISTA"
61: 
62:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
63:                     THIS.CarregarLista()
64:                 ENDIF
65: 
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar FormFpg:" + CHR(13) + ;
71:                 loException.Message + CHR(13) + ;
72:                 "Linha: " + TRANSFORM(loException.LineNo), ;
73:                 "FormFpg.InicializarForm")
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *==========================================================================
80:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
81:     * Pagina.Top = -28 nesta form (conforme SCX original: linha 118)
82:     * Compensacao: +28 em todos os controles dentro das Pages
83:     *==========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -28
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 28
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *==========================================================================
110:     * ConfigurarPaginaLista - Configura Page1: cabecalho + botoes CRUD + grid
111:     * Legado: cntSombra, Grupo_op (5 botoes), Grupo_Saida, Grade
112:     * Compensacao +28 (Pagina.Top=-28)
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina
116:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado)
122:         *-- Framework: Top=2; com compensacao +28 = 30
123:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH loc_oPagina.cnt_4c_Cabecalho
125:             .Top         = 30
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = 769
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10

*-- Linhas 357 a 416:
357:             .Visible            = .T.
358:         ENDWITH
359: 
360:         *-- BINDEVENTs: handlers devem ser PUBLIC (nao PROTECTED) para BINDEVENT funcionar
361:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
362:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
363:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
364:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
365:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
366:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
367: 
368:         THIS.TornarControlesVisiveis(loc_oPagina)
369:     ENDPROC
370: 
371:     *==========================================================================
372:     * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar + campos
373:     * Campos (TextBox, OptionGroup) adicionados nas Fases seguintes
374:     * Compensacao +28 (Pagina.Top=-28)
375:     *==========================================================================
376:     PROTECTED PROCEDURE ConfigurarPaginaDados()
377:         LOCAL loc_oPagina
378:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
379: 
380:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
381:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
382: 
383:         *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
384:         *-- Legado: Grupo_Salva.Salva.Top=5, Left=5, Cancelar.Left=80; canonico Left=842, Top=32
385:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
386:         WITH loc_oPagina.cnt_4c_Salva
387:             .Top         = 32
388:             .Left        = 842
389:             .Width       = 160
390:             .Height      = 85
391:             .BackStyle   = 0
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Comic Sans MS"
408:             .FontSize        = 8
409:             .FontBold        = .T.
410:             .FontItalic      = .T.
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.

*-- Linhas 439 a 483:
439:             .Visible         = .T.
440:         ENDWITH
441: 
442:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- Label titulo do cadastro (lbl_cadastro no legado)
446:         *-- Legado: Top=163, compensacao +28 = 191; Left=255; FontBold=.T.; BackStyle=0
447:         loc_oPagina.AddObject("lbl_4c_Lbl_cadastro", "Label")
448:         WITH loc_oPagina.lbl_4c_Lbl_cadastro
449:             .Caption    = "Cadastro de Contas a Pagar"
450:             .Top        = 191
451:             .Left       = 255
452:             .FontName   = "Tahoma"
453:             .FontSize   = 8
454:             .FontBold   = .T.
455:             .FontItalic = .F.
456:             .BackStyle  = 0
457:             .ForeColor  = RGB(90, 90, 90)
458:             .AutoSize   = .T.
459:             .Visible    = .T.
460:         ENDWITH
461: 
462:         *-- Label "Grupo :" (lbl_grupo no legado)
463:         *-- Legado: Top=186+28=214, Left=207, Width=38
464:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
465:         WITH loc_oPagina.lbl_4c_Lbl_grupo
466:             .Caption   = "Grupo :"
467:             .Top       = 214
468:             .Left      = 207
469:             .Width     = 38
470:             .Height    = 17
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .FontBold  = .F.
474:             .Alignment = 0
475:             .ForeColor = RGB(90, 90, 90)
476:             .AutoSize  = .T.
477:             .Visible   = .T.
478:         ENDWITH
479: 
480:         *-- TextBox codigo do grupo (get_cd_grupo no legado)
481:         *-- Legado: Top=181+28=209, Left=254, Width=79, Height=23, MaxLength=10
482:         *-- When: pcEscolha $ 'INSERIR/PROCURAR' -> habilitado so em INCLUIR (grupos=PK)
483:         *-- Valid (fAcessoContab 'C'): valida codigo em SigCdGcr, preenche descricao

*-- Linhas 530 a 632:
530:             .Visible   = .T.
531:         ENDWITH
532: 
533:         *-- OptionGroup "Real/Previsto" (op_con no legado)
534:         *-- Legado: Top=206+28=234, Left=254, Width=113, Height=25, Value=1 (Real)
535:         *-- relprevs: 1=Real, 2=Previsto; When: INSERIR/ALTERAR
536:         loc_oPagina.AddObject("opt_4c_Op_con", "OptionGroup")
537:         WITH loc_oPagina.opt_4c_Op_con
538:             .ButtonCount   = 2
539:             .Value         = 1
540:             .Top           = 234
541:             .Left          = 254
542:             .Width         = 118
543:             .Height        = 25
544:             .BackStyle     = 0
545:             .BorderStyle   = 0
546:             .SpecialEffect = 0
547:             .Visible       = .T.
548:         ENDWITH
549: 
550:         WITH loc_oPagina.opt_4c_Op_con.Buttons(1)
551:             .Caption   = "Real"
552:             .Left      = 5
553:             .Top       = 5
554:             .Width     = 40
555:             .AutoSize  = .T.
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(90, 90, 90)
559:             .BackStyle = 0
560:         ENDWITH
561: 
562:         WITH loc_oPagina.opt_4c_Op_con.Buttons(2)
563:             .Caption   = "Previsto"
564:             .Left      = 51
565:             .Top       = 5
566:             .Width     = 57
567:             .AutoSize  = .T.
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .ForeColor = RGB(90, 90, 90)
571:             .BackStyle = 0
572:         ENDWITH
573: 
574:         *-- BINDEVENTs para lookup SigCdGcr (substitui fAcessoContab do legado)
575:         *-- F4(115)/Enter(13)/DblClick em cd_grupo: abre FormBuscaAuxiliar
576:         *-- LostFocus em cd_grupo: valida codigo, preenche descricao
577:         *-- LostFocus em ds_grupo: valida descricao, preenche codigo
578:         BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "KeyPress",  THIS, "CdGrupoKeyPress")
579:         BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "DblClick",  THIS, "CdGrupoDblClick")
580:         BINDEVENT(loc_oPagina.txt_4c__cd_grupo, "KeyPress", THIS, "ValidarCdGrupo")
581:         BINDEVENT(loc_oPagina.txt_4c__ds_grupo, "KeyPress", THIS, "ValidarDsGrupo")
582: 
583:         THIS.TornarControlesVisiveis(loc_oPagina)
584:     ENDPROC
585: 
586:     *==========================================================================
587:     * CarregarLista - Carrega dados no Grid da Page1
588:     * Chama FpgBO.Buscar() e vincula cursor_4c_Dados ao grd_4c_Lista
589:     * REGRA (Problema 36): RecordSource e ColumnCount FORA do WITH
590:     * REGRA (Problema 32): redefinir Headers APOS RecordSource
591:     *==========================================================================
592:     PROCEDURE CarregarLista()
593:         LOCAL loc_lResultado, loc_oGrid
594:         loc_lResultado = .F.
595: 
596:         TRY
597:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
598:                 loc_lResultado = .T.
599:             ELSE
600:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
601: 
602:                 IF !THIS.this_oBusinessObject.Buscar("")
603:                     loc_lResultado = .F.
604:                 ELSE
605:                     *-- Problema 36: RecordSource e ColumnCount fora do WITH
606:                     loc_oGrid.ColumnCount = 3
607:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
608:                     loc_oGrid.ColumnCount  = 3
609: 
610:                     *-- Problema 32: ControlSource e Headers APOS RecordSource (auto-bind reseta)
611:                     WITH loc_oGrid
612:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
613:                         .Column1.Width           = 80
614:                         .Column1.Alignment       = 0
615:                         .Column1.Header1.Caption = "Grupo"
616: 
617:                         .Column2.ControlSource   = "cursor_4c_Dados.descrs"
618:                         .Column2.Width           = 560
619:                         .Column2.Alignment       = 0
620:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
621: 
622:                         .Column3.ControlSource   = "cursor_4c_Dados.relprevs"
623:                         .Column3.Width           = 80
624:                         .Column3.Alignment       = 2
625:                         .Column3.Header1.Caption = "Tipo"
626:                     ENDWITH
627: 
628:                     THIS.FormatarGridLista(loc_oGrid)
629:                     THIS.AjustarBotoesPorModo()
630:                     loc_lResultado = .T.
631:                 ENDIF
632:             ENDIF

*-- Linhas 643 a 1071:
643:     *==========================================================================
644:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
645:     *==========================================================================
646:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
647:         LOCAL loc_lResultado
648:         loc_lResultado = .F.
649: 
650:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
651:             RETURN .F.
652:         ENDIF
653: 
654:         TRY
655:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
656: 
657:             IF par_nPagina = 1
658:                 THIS.this_cModoAtual = "LISTA"
659:                 THIS.CarregarLista()
660:             ENDIF
661: 
662:             loc_lResultado = .T.
663: 
664:         CATCH TO loException
665:             MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, ;
666:                 "FormFpg.AlternarPagina")
667:         ENDTRY
668: 
669:         RETURN loc_lResultado
670:     ENDPROC
671: 
672:     *==========================================================================
673:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
674:     * Legado: pcEscolha='INSERIR' -> SetFocus em get_cd_grupo
675:     *==========================================================================
676:     PROCEDURE BtnIncluirClick()
677:         TRY
678:             THIS.this_oBusinessObject.NovoRegistro()
679:             THIS.LimparCampos()
680:             THIS.this_cModoAtual = "INCLUIR"
681:             THIS.HabilitarCampos(.T.)
682:             THIS.AlternarPagina(2)
683:             THIS.AjustarBotoesPorModo()
684:         CATCH TO loException
685:             MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
686:                 "FormFpg.BtnIncluirClick")
687:         ENDTRY
688:     ENDPROC
689: 
690:     *==========================================================================
691:     * BtnVisualizarClick - Carrega registro selecionado e navega para Page2 (somente leitura)
692:     * Legado: pcEscolha='CONSULTAR' -> SetFocus em Grupo_Salva.Salva
693:     *==========================================================================
694:     PROCEDURE BtnVisualizarClick()
695:         LOCAL loc_cGrupos
696:         loc_cGrupos = ""
697: 
698:         TRY
699:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
700:                 MsgAviso("Selecione um registro na lista!")
701:             ELSE
702:                 SELECT cursor_4c_Dados
703:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
704: 
705:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
706:                     THIS.this_cModoAtual = "VISUALIZAR"
707:                     THIS.BOParaForm()
708:                     THIS.HabilitarCampos(.F.)
709:                     THIS.AlternarPagina(2)
710:                     THIS.AjustarBotoesPorModo()
711:                 ENDIF
712:             ENDIF
713:         CATCH TO loException
714:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
715:                 "FormFpg.BtnVisualizarClick")
716:         ENDTRY
717:     ENDPROC
718: 
719:     *==========================================================================
720:     * BtnAlterarClick - Carrega registro selecionado e navega para Page2 (editavel)
721:     *==========================================================================
722:     PROCEDURE BtnAlterarClick()
723:         LOCAL loc_cGrupos
724:         loc_cGrupos = ""
725: 
726:         TRY
727:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
728:                 MsgAviso("Selecione um registro na lista!")
729:             ELSE
730:                 SELECT cursor_4c_Dados
731:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
732: 
733:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
734:                     THIS.this_oBusinessObject.EditarRegistro()
735:                     THIS.this_cModoAtual = "ALTERAR"
736:                     THIS.BOParaForm()
737:                     THIS.HabilitarCampos(.T.)
738:                     THIS.AlternarPagina(2)
739:                     THIS.AjustarBotoesPorModo()
740:                 ENDIF
741:             ENDIF
742:         CATCH TO loException
743:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
744:                 "FormFpg.BtnAlterarClick")
745:         ENDTRY
746:     ENDPROC
747: 
748:     *==========================================================================
749:     * BtnExcluirClick - Confirma e exclui registro selecionado
750:     *==========================================================================
751:     PROCEDURE BtnExcluirClick()
752:         LOCAL loc_cGrupos
753:         loc_cGrupos = ""
754: 
755:         TRY
756:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
757:                 MsgAviso("Selecione um registro na lista!")
758:             ELSE
759:                 SELECT cursor_4c_Dados
760:                 loc_cGrupos = ALLTRIM(cursor_4c_Dados.grupos)
761: 
762:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do grupo '" + ;
763:                     loc_cGrupos + "'?", "Confirmar Exclus" + CHR(227) + "o")
764: 
765:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cGrupos)
766:                         IF THIS.this_oBusinessObject.Excluir()
767:                             MsgInfo("Grupo exclu" + CHR(237) + "do com sucesso!")
768:                             THIS.CarregarLista()
769:                         ENDIF
770:                     ENDIF
771:                 ENDIF
772:             ENDIF
773:         CATCH TO loException
774:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
775:                 "FormFpg.BtnExcluirClick")
776:         ENDTRY
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar lista (procurar no legado)
781:     * Legado: pcEscolha='PROCURAR' -> SetFocus em get_cd_grupo (modo busca)
782:     *==========================================================================
783:     PROCEDURE BtnBuscarClick()
784:         LOCAL loc_oBusca, loc_cGrupos, loc_lSelecionou
785:         loc_cGrupos   = ""
786:         loc_lSelecionou = .F.
787: 
788:         TRY
789:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
790:                 "SigCdPag", "cursor_4c_BuscaFpg", "grupos", "", ;
791:                 "Buscar Grupo de Pagamento")
792: 
793:             IF VARTYPE(loc_oBusca) = "O"
794:                 loc_oBusca.mAddColuna("grupos", "", "Grupo")
795:                 loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
796:                 loc_oBusca.Show()
797: 
798:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpg")
799:                     SELECT cursor_4c_BuscaFpg
800:                     loc_cGrupos   = ALLTRIM(cursor_4c_BuscaFpg.grupos)
801:                     loc_lSelecionou = .T.
802:                 ENDIF
803: 
804:                 loc_oBusca.Release()
805:             ENDIF
806: 
807:             IF USED("cursor_4c_BuscaFpg")
808:                 USE IN cursor_4c_BuscaFpg
809:             ENDIF
810: 
811:             IF loc_lSelecionou
812:                 THIS.this_oBusinessObject.Buscar("grupos = " + EscaparSQL(loc_cGrupos))
813:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
814:             ENDIF
815: 
816:         CATCH TO loException
817:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, ;
818:                 "FormFpg.BtnBuscarClick")
819:             IF USED("cursor_4c_BuscaFpg")
820:                 USE IN cursor_4c_BuscaFpg
821:             ENDIF
822:         ENDTRY
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * BtnEncerrarClick - Fecha o formulario
827:     *==========================================================================
828:     PROCEDURE BtnEncerrarClick()
829:         TRY
830:             THIS.Release()
831:         CATCH TO loException
832:             *-- Ignorar erros ao encerrar
833:         ENDTRY
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * BtnSalvarClick - Transfere dados do Form para BO e salva
838:     * Legado: valida campo Grupos vazio em INSERIR, depois DoDefault -> mAtivapagina1
839:     *==========================================================================
840:     PROCEDURE BtnSalvarClick()
841:         LOCAL loc_oPagina, loc_cGrupos
842:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
843:         loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)
844: 
845:         *-- Validacao pre-TRY (legado: "Grupo nao pode ficar em branco!")
846:         IF THIS.this_cModoAtual = "INCLUIR" AND EMPTY(loc_cGrupos)
847:             MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
848:             IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
849:                 loc_oPagina.txt_4c__cd_grupo.SetFocus()
850:             ENDIF
851:             RETURN
852:         ENDIF
853: 
854:         TRY
855:             THIS.FormParaBO()
856: 
857:             IF THIS.this_oBusinessObject.Salvar()
858:                 MsgInfo("Registro salvo com sucesso!")
859:                 THIS.AlternarPagina(1)
860:             ENDIF
861:         CATCH TO loException
862:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
863:                 "FormFpg.BtnSalvarClick")
864:         ENDTRY
865:     ENDPROC
866: 
867:     *==========================================================================
868:     * BtnCancelarClick - Cancela edicao e retorna para lista
869:     * Legado: Grupo_Salva.Cancelar.Click -> dodefault() -> mAtivapagina1
870:     *==========================================================================
871:     PROCEDURE BtnCancelarClick()
872:         TRY
873:             THIS.AlternarPagina(1)
874:         CATCH TO loException
875:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
876:                 "FormFpg.BtnCancelarClick")
877:         ENDTRY
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
882:     * Implementacao base: controla botoes de Page1. Estendido em fases seguintes.
883:     *==========================================================================
884:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
885:         LOCAL loc_oPagina
886:         TRY
887:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
888: 
889:             *-- Confirmar desabilitado em VISUALIZAR
890:             IF VARTYPE(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
891:                 loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
892:             ENDIF
893: 
894:             *-- grupos = PK: editavel somente em INCLUIR (legado: When='INSERIR/PROCURAR')
895:             IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
896:                 loc_oPagina.txt_4c__cd_grupo.ReadOnly = !(par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
897:             ENDIF
898: 
899:             *-- descricao: editavel em INCLUIR/ALTERAR (legado: When='INSERIR/ALTERAR')
900:             IF VARTYPE(loc_oPagina.txt_4c__ds_grupo) = "O"
901:                 loc_oPagina.txt_4c__ds_grupo.ReadOnly = !par_lHabilitar
902:             ENDIF
903: 
904:             *-- tipo Real/Previsto: habilitado em INCLUIR/ALTERAR (legado: When='INSERIR/ALTERAR')
905:             IF VARTYPE(loc_oPagina.opt_4c_Op_con) = "O"
906:                 loc_oPagina.opt_4c_Op_con.Enabled = par_lHabilitar
907:             ENDIF
908: 
909:         CATCH TO loException
910:             *-- Ignorar erros de controles ainda nao disponiveis
911:         ENDTRY
912:     ENDPROC
913: 
914:     *==========================================================================
915:     * LimparCampos - Limpa campos da Page2 e reseta propriedades do BO
916:     * Implementacao base limpa o BO. Estendida em fases seguintes com controles.
917:     *==========================================================================
918:     PROTECTED PROCEDURE LimparCampos()
919:         LOCAL loc_oPagina
920:         TRY
921:             THIS.this_oBusinessObject.this_cGrupos   = ""
922:             THIS.this_oBusinessObject.this_cDescrs   = ""
923:             THIS.this_oBusinessObject.this_nRelprevs = 0
924: 
925:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
926:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
927:                 IF VARTYPE(loc_oPagina.txt_4c__cd_grupo) = "O"
928:                     loc_oPagina.txt_4c__cd_grupo.Value = ""
929:                 ENDIF
930:                 IF VARTYPE(loc_oPagina.txt_4c__ds_grupo) = "O"
931:                     loc_oPagina.txt_4c__ds_grupo.Value = ""
932:                 ENDIF
933:                 IF VARTYPE(loc_oPagina.opt_4c_Op_con) = "O"
934:                     loc_oPagina.opt_4c_Op_con.Value = 1
935:                 ENDIF
936:             ENDIF
937:         CATCH TO loException
938:             *-- Ignorar erros durante limpeza
939:         ENDTRY
940:     ENDPROC
941: 
942:     *==========================================================================
943:     * FormParaBO - Transfere dados dos controles da Page2 para o BO
944:     * Implementacao base. Estendida em fases seguintes quando controles forem adicionados.
945:     *==========================================================================
946:     PROTECTED PROCEDURE FormParaBO()
947:         LOCAL loc_oPagina
948:         TRY
949:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
950:                 MostrarErro("Business Object n" + CHR(227) + "o inicializado", ;
951:                     "FormFpg.FormParaBO")
952:             ELSE
953:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
954:                 THIS.this_oBusinessObject.this_cGrupos   = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)
955:                 THIS.this_oBusinessObject.this_cDescrs   = ALLTRIM(loc_oPagina.txt_4c__ds_grupo.Value)
956:                 THIS.this_oBusinessObject.this_nRelprevs = loc_oPagina.opt_4c_Op_con.Value
957:             ENDIF
958:         CATCH TO loException
959:             MostrarErro("Erro em FormParaBO:" + CHR(13) + loException.Message, ;
960:                 "FormFpg.FormParaBO")
961:         ENDTRY
962:     ENDPROC
963: 
964:     *==========================================================================
965:     * BOParaForm - Transfere dados do BO para os controles da Page2
966:     * Implementacao base. Estendida em fases seguintes quando controles forem adicionados.
967:     *==========================================================================
968:     PROTECTED PROCEDURE BOParaForm()
969:         LOCAL loc_oPagina, loc_nRelprevs
970:         TRY
971:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
972:                 MostrarErro("Business Object n" + CHR(227) + "o inicializado", ;
973:                     "FormFpg.BOParaForm")
974:             ELSE
975:                 loc_oPagina   = THIS.pgf_4c_Paginas.Page2
976:                 loc_nRelprevs = THIS.this_oBusinessObject.this_nRelprevs
977: 
978:                 loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
979:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
980:                 loc_oPagina.opt_4c_Op_con.Value    = IIF(loc_nRelprevs >= 1 AND loc_nRelprevs <= 2, loc_nRelprevs, 1)
981:             ENDIF
982:         CATCH TO loException
983:             MostrarErro("Erro em BOParaForm:" + CHR(13) + loException.Message, ;
984:                 "FormFpg.BOParaForm")
985:         ENDTRY
986:     ENDPROC
987: 
988:     *==========================================================================
989:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
990:     * REGRA: chamar SEMPRE com parametro (nao sem parametro)
991:     *==========================================================================
992:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
993:         LOCAL loc_nI, loc_oObjeto, loc_nP
994: 
995:         FOR loc_nI = 1 TO par_oContainer.ControlCount
996:             loc_oObjeto = par_oContainer.Controls(loc_nI)
997: 
998:             IF VARTYPE(loc_oObjeto) = "O"
999:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1000:                     loc_oObjeto.Visible = .T.
1001:                 ENDIF
1002: 
1003:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1004:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1005:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1006:                     ENDFOR
1007:                 ENDIF
1008: 
1009:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1010:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1011:                 ENDIF
1012:             ENDIF
1013:         ENDFOR
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     * FormatarGridLista - Aplica formatacao visual padrao ao grid
1018:     *==========================================================================
1019:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1020:         WITH par_oGrid
1021:             .FontName = "Tahoma"
1022:             .FontSize = 8
1023:         ENDWITH
1024:     ENDPROC
1025: 
1026:     *==========================================================================
1027:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme selecao
1028:     * e ajusta foco em Page2 conforme this_cModoAtual
1029:     * Legado: Click handler usava pcEscolha para SetFocus em INSERIR vs CONSULTAR
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1032:         LOCAL loc_oPg1, loc_oPg2, loc_lTemRegistro
1033: 
1034:         TRY
1035:             loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1036:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1037:             loc_lTemRegistro = USED("cursor_4c_Dados") AND ;
1038:                 !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1039: 
1040:             *-- Botoes que requerem selecao: Visualizar, Alterar, Excluir
1041:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar) = "O"
1042:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1043:             ENDIF
1044:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar) = "O"
1045:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1046:             ENDIF
1047:             IF VARTYPE(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir) = "O"
1048:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1049:             ENDIF
1050: 
1051:             *-- Confirmar desabilitado em VISUALIZAR
1052:             IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar) = "O"
1053:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1054:             ENDIF
1055: 
1056:             *-- Foco em Page2 conforme modo (legado: INSERIR/PROCURAR -> cd_grupo; CONSULTAR -> Salva)
1057:             IF THIS.pgf_4c_Paginas.ActivePage = 2
1058:                 DO CASE
1059:                     CASE THIS.this_cModoAtual = "INCLUIR"
1060:                         IF VARTYPE(loc_oPg2.txt_4c__cd_grupo) = "O"
1061:                             loc_oPg2.txt_4c__cd_grupo.SetFocus()
1062:                         ENDIF
1063:                     CASE THIS.this_cModoAtual = "ALTERAR"
1064:                         IF VARTYPE(loc_oPg2.txt_4c__ds_grupo) = "O"
1065:                             loc_oPg2.txt_4c__ds_grupo.SetFocus()
1066:                         ENDIF
1067:                     CASE THIS.this_cModoAtual = "VISUALIZAR"
1068:                         IF VARTYPE(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar) = "O"
1069:                             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.SetFocus()
1070:                         ENDIF
1071:                 ENDCASE

*-- Linhas 1079 a 1210:
1079:     *==========================================================================
1080:     * Destroy - Libera recursos ao fechar o formulario
1081:     *==========================================================================
1082:     PROCEDURE Destroy()
1083:         TRY
1084:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1085:                 THIS.this_oBusinessObject = .NULL.
1086:             ENDIF
1087: 
1088:             IF USED("cursor_4c_Dados")
1089:                 USE IN cursor_4c_Dados
1090:             ENDIF
1091:         CATCH TO loException
1092:             *-- Ignorar erros no Destroy para nao bloquear fechamento
1093:         ENDTRY
1094: 
1095:         DODEFAULT()
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * HANDLERS DE LOOKUP - Grupo Conta Corrente (SigCdGcr)
1100:     * Substitui fAcessoContab(Usuar,'C',valor,...) / fAcessoContab(Usuar,'D',...)
1101:     * Campos em SigCdGcr: Codigos (PK), Descrs (descricao)
1102:     *==========================================================================
1103: 
1104:     PROCEDURE CdGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1105:         IF par_nKeyCode = 13 OR par_nKeyCode = 115
1106:             THIS.AbrirLookupGrupoGcr()
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     PROCEDURE CdGrupoDblClick()
1111:         THIS.AbrirLookupGrupoGcr()
1112:     ENDPROC
1113: 
1114:     *--------------------------------------------------------------------------
1115:     * ValidarCdGrupo - LostFocus de txt_4c__cd_grupo
1116:     * Valida codigo em SigCdGcr e preenche descricao (equivale fAcessoContab 'C')
1117:     *--------------------------------------------------------------------------
1118:     PROCEDURE ValidarCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
1119:         LOCAL loc_oPagina, loc_cCodigo
1120:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1121:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)
1122: 
1123:         IF EMPTY(loc_cCodigo)
1124:             loc_oPagina.txt_4c__ds_grupo.Value = ""
1125:             RETURN
1126:         ENDIF
1127: 
1128:         THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cCodigo, "C", "cursor_4c_GcrVal")
1129: 
1130:         IF USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1131:             SELECT cursor_4c_GcrVal
1132:             loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrVal.descrs)
1133:         ENDIF
1134: 
1135:         IF USED("cursor_4c_GcrVal")
1136:             USE IN cursor_4c_GcrVal
1137:         ENDIF
1138:     ENDPROC
1139: 
1140:     *--------------------------------------------------------------------------
1141:     * ValidarDsGrupo - LostFocus de txt_4c__ds_grupo
1142:     * Valida descricao em SigCdGcr e preenche codigo (equivale fAcessoContab 'D')
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE ValidarDsGrupo(par_nKeyCode, par_nShiftAltCtrl)
1145:         LOCAL loc_oPagina, loc_cDescricao
1146:         loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1147:         loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c__ds_grupo.Value)
1148: 
1149:         IF EMPTY(loc_cDescricao)
1150:             loc_oPagina.txt_4c__cd_grupo.Value = ""
1151:             RETURN
1152:         ENDIF
1153: 
1154:         THIS.this_oBusinessObject.BuscarGrupoGcr(loc_cDescricao, "D", "cursor_4c_GcrDVal")
1155: 
1156:         IF USED("cursor_4c_GcrDVal") AND RECCOUNT("cursor_4c_GcrDVal") > 0
1157:             SELECT cursor_4c_GcrDVal
1158:             IF RECCOUNT("cursor_4c_GcrDVal") = 1
1159:                 loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.grupos)
1160:                 loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_GcrDVal.descrs)
1161:             ELSE
1162:                 THIS.AbrirLookupGrupoGcr()
1163:             ENDIF
1164:         ENDIF
1165: 
1166:         IF USED("cursor_4c_GcrDVal")
1167:             USE IN cursor_4c_GcrDVal
1168:         ENDIF
1169:     ENDPROC
1170: 
1171:     *--------------------------------------------------------------------------
1172:     * AbrirLookupGrupoGcr - Abre FormBuscaAuxiliar para SigCdGcr
1173:     * Preenche txt_4c__cd_grupo e txt_4c__ds_grupo com selecao do usuario
1174:     *--------------------------------------------------------------------------
1175:     PROTECTED PROCEDURE AbrirLookupGrupoGcr()
1176:         LOCAL loc_oBusca, loc_oPagina, loc_cCodigo
1177:         loc_oBusca  = .NULL.
1178:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1179:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__cd_grupo.Value)
1180: 
1181:         TRY
1182:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1183:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Grupos", ;
1184:                 loc_cCodigo, "Grupo de Conta Corrente")
1185: 
1186:             IF VARTYPE(loc_oBusca) = "O"
1187:                 loc_oBusca.mAddColuna("Grupos", "", "C" + CHR(243) + "digo")
1188:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1189:                 loc_oBusca.Show()
1190: 
1191:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1192:                     SELECT cursor_4c_BuscaGcr
1193:                     loc_oPagina.txt_4c__cd_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Grupos)
1194:                     loc_oPagina.txt_4c__ds_grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1195:                 ENDIF
1196: 
1197:                 loc_oBusca.Release()
1198:             ENDIF
1199: 
1200:         CATCH TO loException
1201:             MostrarErro("Erro ao abrir lookup Grupo GCR:" + CHR(13) + loException.Message, ;
1202:                 "FormFpg.AbrirLookupGrupoGcr")
1203:         ENDTRY
1204: 
1205:         IF USED("cursor_4c_BuscaGcr")
1206:             USE IN cursor_4c_BuscaGcr
1207:         ENDIF
1208:     ENDPROC
1209: 
1210: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FpgBO.prg):
*====================================================================
* FpgBO.prg
*
* Business Object para Cadastro Financeiro de Pagamentos
* Tabela: SigCdPag
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS FpgBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdPag)
    this_cGrupos   = ""    && grupos char(10) - PK
    this_cDescrs   = ""    && descrs char(30)
    this_nRelprevs = 0     && relprevs numeric(1,0) - 1=Real, 2=Previsto

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPag"
            THIS.this_cCampoChave = "grupos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FpgBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cGrupos   = TratarNulo(grupos,   "C")
                THIS.this_cDescrs   = TratarNulo(descrs,   "C")
                THIS.this_nRelprevs = TratarNulo(relprevs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FpgBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cGrupos)
            MsgAviso("Grupo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarGrupoExistente(THIS.this_cGrupos)
                MsgAviso("Grupo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarGrupoExistente - Verifica se grupos ja existe no banco
    *====================================================================
    PROCEDURE VerificarGrupoExistente(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkGrp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkGrp")
                SELECT cursor_4c_ChkGrp
                loc_lExiste = (cursor_4c_ChkGrp.qtd > 0)
                USE IN cursor_4c_ChkGrp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar grupo:" + CHR(13) + loException.Message, "FpgBO.VerificarGrupoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdPag (grupos, descrs, relprevs)
                VALUES (
                    <<EscaparSQL(THIS.this_cGrupos)>>,
                    <<EscaparSQL(THIS.this_cDescrs)>>,
                    <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FpgBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdPag
                SET descrs   = <<EscaparSQL(THIS.this_cDescrs)>>,
                    relprevs = <<FormatarNumeroSQL(THIS.this_nRelprevs, 0)>>
                WHERE grupos = <<EscaparSQL(THIS.this_cGrupos)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FpgBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdPag
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdPag WHERE grupos = " + EscaparSQL(THIS.this_cGrupos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FpgBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com grupos, descrs, relprevs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (grupos C(10), descrs C(30), relprevs N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupos"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FpgBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (grupos)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT grupos, descrs, relprevs FROM SigCdPag" + ;
                " WHERE grupos = " + EscaparSQL(par_cGrupos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de pagamento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de pagamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FpgBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * BuscarGrupoGcr - Busca grupo de conta corrente em SigCdGcr
    * Usado pelo Form para validar/lookup do campo grupos via fAcessoContab
    * Substitui fAcessoContab(Usuar,'C',codigo,...) e
    *          fAcessoContab(Usuar,'D',descricao,...)
    *====================================================================
    PROCEDURE BuscarGrupoGcr(par_cValor, par_cModo, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCursorDest
        loc_lSucesso = .F.
        loc_cCursorDest = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
            par_cCursorDestino, "cursor_4c_BuscaGcr")

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                loc_lSucesso = .T.
            ELSE
                DO CASE
                    CASE UPPER(ALLTRIM(par_cModo)) = "C"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE grupos = " + EscaparSQL(par_cValor)
                    CASE UPPER(ALLTRIM(par_cModo)) = "D"
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr" + ;
                            " WHERE UPPER(RTRIM(descrs)) LIKE UPPER(" + EscaparSQL(par_cValor + "%") + ")"
                    OTHERWISE
                        loc_cSQL = "SELECT grupos, descrs FROM SigCdGcr ORDER BY grupos"
                ENDCASE

                IF USED(loc_cCursorDest)
                    USE IN (loc_cCursorDest)
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursorDest)
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar grupo conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar grupo GCR:" + CHR(13) + loException.Message, "FpgBO.BuscarGrupoGcr")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

