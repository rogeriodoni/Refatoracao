# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BINDEVENT-PARAMS] Handler 'CodMoedaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CodMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DescMoedaLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DescMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCst.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1125 linhas total):

*-- Linhas 25 a 146:
25:     *===========================================================================
26:     * Init - Inicializa o formulario
27:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
29:     *===========================================================================
30:     PROCEDURE Init()
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *===========================================================================
35:     * InicializarForm - Configura estrutura completa
36:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
37:     *===========================================================================
38:     PROTECTED PROCEDURE InicializarForm()
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             THIS.this_oBusinessObject = CREATEOBJECT("CstBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar CstBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormCst.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
58:                     THIS.CarregarLista()
59:                 ENDIF
60: 
61:                 loc_lSucesso = .T.
62:             ENDIF
63: 
64:         CATCH TO loException
65:             MostrarErro("Erro ao inicializar FormCst:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormCst.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *===========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 para esconder abas; controles compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *===========================================================================
104:     * ConfigurarPaginaLista - Configura Page1: Cabecalho, Botoes CRUD e Grid
105:     *===========================================================================
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina, loc_oErro
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         TRY
114:             *-- Container Cabecalho (cntSombra do legado)
115:             *-- Top=31: compensa PageFrame.Top=-29
116:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:             WITH loc_oPagina.cnt_4c_Cabecalho
118:                 .Top         = 31
119:                 .Left        = -1
120:                 .Width       = THIS.Width + 8
121:                 .Height      = 80
122:                 .BackColor   = RGB(100, 100, 100)
123:                 .BorderWidth = 0
124:                 .Visible     = .T.
125: 
126:                 .AddObject("lbl_4c_Sombra", "Label")
127:                 WITH .lbl_4c_Sombra
128:                     .Top       = 15
129:                     .Left      = 10
130:                     .Width     = THIS.Width
131:                     .Height    = 40
132:                     .Caption   = THIS.Caption
133:                     .FontName  = "Tahoma"
134:                     .FontSize  = 16
135:                     .FontBold  = .T.
136:                     .ForeColor = RGB(0, 0, 0)
137:                     .BackStyle = 0
138:                     .AutoSize  = .F.
139:                     .Visible   = .T.
140:                 ENDWITH
141: 
142:                 .AddObject("lbl_4c_Titulo", "Label")
143:                 WITH .lbl_4c_Titulo
144:                     .Top       = 18
145:                     .Left      = 10
146:                     .Width     = THIS.Width

*-- Linhas 339 a 406:
339:                 .Visible            = .T.
340:             ENDWITH
341: 
342:             *-- BINDEVENT para botoes CRUD (metodos PUBLIC obrigatorios)
343:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
344:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
345:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
346:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
347:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
348:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
349: 
350:             THIS.TornarControlesVisiveis(loc_oPagina)
351: 
352:         CATCH TO loc_oErro
353:             MostrarErro("Erro ao configurar Page1:" + CHR(13) + ;
354:                 loc_oErro.Message + CHR(13) + ;
355:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
356:                 "FormCst.ConfigurarPaginaLista")
357:         ENDTRY
358:     ENDPROC
359: 
360:     *===========================================================================
361:     * ConfigurarPaginaDados - Configura Page2: Botoes de Acao + campos Parte 1
362:     * FASE 5/8: cnt_4c_BotoesAcao (Salvar+Cancelar), Label1+txt_4c_Codigo,
363:     *           Label2+txt_4c_Descricao, Label3+txt_4c_Constante
364:     * Top += 29 em todos os controles (compensacao PageFrame.Top=-29)
365:     *===========================================================================
366:     PROTECTED PROCEDURE ConfigurarPaginaDados()
367:         LOCAL loc_oPagina, loc_oErro
368:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
369: 
370:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
371:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
372: 
373:         TRY
374:             *-- Container Botoes de Acao (Grupo_Salva do legado)
375:             *-- Original: Left=820, Top=8 -> Migrado: Top=37 (8+29)
376:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
377:             WITH loc_oPagina.cnt_4c_BotoesAcao
378:                 .Top         = 37
379:                 .Left        = 820
380:                 .Width       = 160
381:                 .Height      = 85
382:                 .BackStyle   = 0
383:                 .BorderWidth = 0
384:                 .Visible     = .T.
385: 
386:                 .AddObject("cmd_4c_Salvar", "CommandButton")
387:                 WITH .cmd_4c_Salvar
388:                     .Caption         = "Salvar"
389:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
390:                     .PicturePosition = 13
391:                     .Top             = 5
392:                     .Left            = 5
393:                     .Width           = 75
394:                     .Height          = 75
395:                     .BackColor       = RGB(255, 255, 255)
396:                     .ForeColor       = RGB(90, 90, 90)
397:                     .FontName        = "Comic Sans MS"
398:                     .FontBold        = .T.
399:                     .FontItalic      = .T.
400:                     .FontSize        = 8
401:                     .SpecialEffect   = 0
402:                     .MousePointer    = 15
403:                     .WordWrap        = .T.
404:                     .AutoSize        = .F.
405:                 ENDWITH
406: 

*-- Linhas 427 a 471:
427:                 ENDWITH
428:             ENDWITH
429: 
430:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
431:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
432: 
433:             *-- Label1 + txt_4c_Codigo (Get_Codigo do legado)
434:             *-- Original: Label1.Top=126, Get_Codigo.Top=122 -> Migrado: +29
435:             loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
436:             WITH loc_oPagina.lbl_4c_Codigo
437:                 .Caption   = "C" + CHR(243) + "digo : "
438:                 .Top       = 155
439:                 .Left      = 281
440:                 .Width     = 45
441:                 .Height    = 15
442:                 .FontName  = "Tahoma"
443:                 .FontSize  = 8
444:                 .FontBold  = .F.
445:                 .BackStyle = 0
446:                 .ForeColor = RGB(90, 90, 90)
447:                 .AutoSize  = .F.
448:                 .Visible   = .T.
449:             ENDWITH
450: 
451:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
452:             WITH loc_oPagina.txt_4c_Codigo
453:                 .Value         = ""
454:                 .Top           = 151
455:                 .Left          = 330
456:                 .Width         = 34
457:                 .Height        = 23
458:                 .InputMask     = "!!!"
459:                 .MaxLength     = 3
460:                 .SpecialEffect = 1
461:                 .FontName      = "Tahoma"
462:                 .FontSize      = 8
463:                 .TabIndex      = 2
464:                 .Visible       = .T.
465:             ENDWITH
466: 
467:             *-- Label2 + txt_4c_Descricao (Get_Descricao do legado)
468:             *-- Original: Label2.Top=152, Get_Descricao.Top=148 -> Migrado: +29
469:             loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
470:             WITH loc_oPagina.lbl_4c_Descricao
471:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "

*-- Linhas 579 a 639:
579:                 .Visible       = .T.
580:             ENDWITH
581: 
582:             BINDEVENT(loc_oPagina.txt_4c_CodMoeda,  "KeyPress", THIS, "CodMoedaLostFocus")
583:             BINDEVENT(loc_oPagina.txt_4c_DescMoeda, "KeyPress", THIS, "DescMoedaLostFocus")
584: 
585:             THIS.TornarControlesVisiveis(loc_oPagina)
586: 
587:         CATCH TO loc_oErro
588:             MostrarErro("Erro ao configurar Page2:" + CHR(13) + ;
589:                 loc_oErro.Message + CHR(13) + ;
590:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
591:                 "FormCst.ConfigurarPaginaDados")
592:         ENDTRY
593:     ENDPROC
594: 
595:     *===========================================================================
596:     * CarregarLista - Carrega dados no Grid da Page1
597:     * REGRA: RecordSource setado APOS Buscar(); Headers redefinidos apos RecordSource
598:     *===========================================================================
599:     PROCEDURE CarregarLista()
600:         LOCAL loc_lResultado, loc_oErro, loc_oGrid
601:         loc_lResultado = .F.
602: 
603:         TRY
604:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
605:                 loc_lResultado = .T.
606:             ELSE
607:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
608: 
609:                 IF THIS.this_oBusinessObject.Buscar("")
610:                     *-- RecordSource FORA do WITH (regra critica #36/#48)
611:                     loc_oGrid.RecordSource = "crSigCdCnt"
612: 
613:                     *-- ControlSource e Headers APOS RecordSource (regra #32)
614:                     WITH loc_oGrid
615:                         .Column1.ControlSource   = "crSigCdCnt.codigos"
616:                         .Column1.Width           = 60
617:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
618:                         .Column1.Alignment       = 0
619: 
620:                         .Column2.ControlSource   = "crSigCdCnt.descricaos"
621:                         .Column2.Width           = 267
622:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
623:                         .Column2.Alignment       = 0
624: 
625:                         .Column3.ControlSource   = "crSigCdCnt.consts"
626:                         .Column3.Width           = 177
627:                         .Column3.Header1.Caption = "Valor"
628:                         .Column3.Alignment       = 1
629: 
630:                         .Column4.ControlSource   = "crSigCdCnt.moedas"
631:                         .Column4.Width           = 42
632:                         .Column4.Header1.Caption = "Moeda"
633:                         .Column4.Alignment       = 0
634:                     ENDWITH
635: 
636:                     THIS.FormatarGridLista(loc_oGrid)
637:                     loc_oGrid.Refresh()
638:                     loc_lResultado = .T.
639:                 ENDIF

*-- Linhas 652 a 1125:
652:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
653:     * Se voltar para Page1, recarrega a lista automaticamente
654:     *===========================================================================
655:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
656:         LOCAL loc_lResultado
657:         loc_lResultado = .F.
658: 
659:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
660:             RETURN loc_lResultado
661:         ENDIF
662: 
663:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
664: 
665:         IF par_nPagina = 1
666:             THIS.this_cModoAtual = "LISTA"
667:             THIS.CarregarLista()
668:         ENDIF
669: 
670:         loc_lResultado = .T.
671: 
672:         RETURN loc_lResultado
673:     ENDPROC
674: 
675:     *===========================================================================
676:     * Destroy - Libera recursos ao fechar o formulario
677:     *===========================================================================
678:     PROCEDURE Destroy()
679:         LOCAL loc_oErro
680: 
681:         TRY
682:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
683:                 THIS.this_oBusinessObject = .NULL.
684:             ENDIF
685: 
686:             IF USED("crSigCdCnt")
687:                 USE IN crSigCdCnt
688:             ENDIF
689:         CATCH TO loc_oErro
690:             MostrarErro("Erro ao destruir FormCst:" + CHR(13) + ;
691:                 loc_oErro.Message, ;
692:                 "FormCst.Destroy")
693:         ENDTRY
694: 
695:         DODEFAULT()
696:     ENDPROC
697: 
698:     *===========================================================================
699:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
700:     * REGRA: Deve iterar Pages E Controls para PageFrames
701:     * SEMPRE chamar COM parametro: THIS.TornarControlesVisiveis(loc_oPagina)
702:     *===========================================================================
703:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
704:         LOCAL loc_nI, loc_oObjeto, loc_nP
705: 
706:         FOR loc_nI = 1 TO par_oContainer.ControlCount
707:             loc_oObjeto = par_oContainer.Controls(loc_nI)
708: 
709:             IF VARTYPE(loc_oObjeto) = "O"
710:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
711:                     loc_oObjeto.Visible = .T.
712:                 ENDIF
713: 
714:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
715:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
716:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
717:                     ENDFOR
718:                 ENDIF
719: 
720:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
721:                     THIS.TornarControlesVisiveis(loc_oObjeto)
722:                 ENDIF
723:             ENDIF
724:         ENDFOR
725:     ENDPROC
726: 
727:     *===========================================================================
728:     * FormatarGridLista - Formata visual do grid da lista
729:     * SEMPRE chamar APOS carregar dados: THIS.FormatarGridLista(loc_oGrid)
730:     *===========================================================================
731:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
732:         WITH par_oGrid
733:             .FontName = "Tahoma"
734:             .FontSize = 8
735:         ENDWITH
736:     ENDPROC
737: 
738:     *===========================================================================
739:     * FormParaBO - Transfere valores dos campos do Form para o BO
740:     *===========================================================================
741:     PROTECTED PROCEDURE FormParaBO()
742:         LOCAL loc_oPagina
743:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
744: 
745:         THIS.this_oBusinessObject.this_cCodigo    = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
746:         THIS.this_oBusinessObject.this_cDescricao = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
747:         THIS.this_oBusinessObject.this_nConstante = loc_oPagina.txt_4c_Constante.Value
748:         THIS.this_oBusinessObject.this_cMoeda     = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)
749:         THIS.this_oBusinessObject.this_cDescMoeda = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)
750:     ENDPROC
751: 
752:     *===========================================================================
753:     * BOParaForm - Transfere valores do BO para os campos do Form
754:     *===========================================================================
755:     PROTECTED PROCEDURE BOParaForm()
756:         LOCAL loc_oPagina
757:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
758: 
759:         loc_oPagina.txt_4c_Codigo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
760:         loc_oPagina.txt_4c_Descricao.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
761:         loc_oPagina.txt_4c_Constante.Value = THIS.this_oBusinessObject.this_nConstante
762:         loc_oPagina.txt_4c_CodMoeda.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cMoeda)
763:         loc_oPagina.txt_4c_DescMoeda.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescMoeda)
764:     ENDPROC
765: 
766:     *===========================================================================
767:     * LimparCampos - Limpa todos os campos da Page2
768:     *===========================================================================
769:     PROTECTED PROCEDURE LimparCampos()
770:         LOCAL loc_oPagina
771:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
772: 
773:         loc_oPagina.txt_4c_Codigo.Value    = ""
774:         loc_oPagina.txt_4c_Descricao.Value = ""
775:         loc_oPagina.txt_4c_Constante.Value = 0
776:         loc_oPagina.txt_4c_CodMoeda.Value  = ""
777:         loc_oPagina.txt_4c_DescMoeda.Value = ""
778:     ENDPROC
779: 
780:     *===========================================================================
781:     * HabilitarCampos - Habilita/desabilita campos conforme modo atual
782:     * Codigo: habilitado SOMENTE no INCLUIR (PK nao editavel em UPDATE)
783:     * DescMoeda: habilitada apenas quando CodMoeda esta vazio (busca por descricao)
784:     *===========================================================================
785:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
786:         LOCAL loc_oPagina, loc_lCodEnabled
787:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
788: 
789:         loc_lCodEnabled = par_lHabilitar AND (THIS.this_cModoAtual = "INCLUIR")
790: 
791:         loc_oPagina.txt_4c_Codigo.Enabled    = loc_lCodEnabled
792:         loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
793:         loc_oPagina.txt_4c_Constante.Enabled = par_lHabilitar
794:         loc_oPagina.txt_4c_CodMoeda.Enabled  = par_lHabilitar
795:         loc_oPagina.txt_4c_DescMoeda.Enabled = par_lHabilitar AND ;
796:             EMPTY(ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value))
797:     ENDPROC
798: 
799:     *===========================================================================
800:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
801:     *===========================================================================
802:     PROTECTED PROCEDURE AjustarBotoesPorModo()
803:         LOCAL loc_oCnt
804:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
805: 
806:         DO CASE
807:         CASE THIS.this_cModoAtual = "VISUALIZAR"
808:             loc_oCnt.cmd_4c_Salvar.Enabled   = .F.
809:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
810:         OTHERWISE
811:             loc_oCnt.cmd_4c_Salvar.Enabled   = .T.
812:             loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
813:         ENDCASE
814:     ENDPROC
815: 
816:     *===========================================================================
817:     * BtnIncluirClick - Prepara formulario para inclusao de nova constante
818:     *===========================================================================
819:     PROCEDURE BtnIncluirClick()
820:         THIS.this_oBusinessObject.NovoRegistro()
821:         THIS.LimparCampos()
822:         THIS.this_cModoAtual = "INCLUIR"
823:         THIS.HabilitarCampos(.T.)
824:         THIS.AjustarBotoesPorModo()
825:         THIS.AlternarPagina(2)
826:         THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
827:     ENDPROC
828: 
829:     *===========================================================================
830:     * BtnVisualizarClick - Abre registro selecionado em modo somente-leitura
831:     *===========================================================================
832:     PROCEDURE BtnVisualizarClick()
833:         LOCAL loc_cCodigo
834: 
835:         IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
836:             MsgAviso("Nenhum registro selecionado!")
837:             RETURN
838:         ENDIF
839: 
840:         SELECT crSigCdCnt
841:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
842: 
843:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
844:             THIS.this_cModoAtual = "VISUALIZAR"
845:             THIS.BOParaForm()
846:             THIS.HabilitarCampos(.F.)
847:             THIS.AjustarBotoesPorModo()
848:             THIS.AlternarPagina(2)
849:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
850:         ENDIF
851:     ENDPROC
852: 
853:     *===========================================================================
854:     * BtnAlterarClick - Abre registro selecionado para edicao
855:     *===========================================================================
856:     PROCEDURE BtnAlterarClick()
857:         LOCAL loc_cCodigo
858: 
859:         IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
860:             MsgAviso("Nenhum registro selecionado!")
861:             RETURN
862:         ENDIF
863: 
864:         SELECT crSigCdCnt
865:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
866: 
867:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
868:             THIS.this_oBusinessObject.EditarRegistro()
869:             THIS.this_cModoAtual = "ALTERAR"
870:             THIS.BOParaForm()
871:             THIS.HabilitarCampos(.T.)
872:             THIS.AjustarBotoesPorModo()
873:             THIS.AlternarPagina(2)
874:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
875:         ENDIF
876:     ENDPROC
877: 
878:     *===========================================================================
879:     * BtnExcluirClick - Exclui o registro selecionado apos confirmacao
880:     *===========================================================================
881:     PROCEDURE BtnExcluirClick()
882:         LOCAL loc_cCodigo, loc_lConfirma, loc_lExcluido
883: 
884:         IF !USED("crSigCdCnt") OR EOF("crSigCdCnt")
885:             MsgAviso("Nenhum registro selecionado!")
886:             RETURN
887:         ENDIF
888: 
889:         SELECT crSigCdCnt
890:         loc_cCodigo = ALLTRIM(crSigCdCnt.codigos)
891: 
892:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
893:             RETURN
894:         ENDIF
895: 
896:         loc_lConfirma = MsgConfirma("Deseja excluir a constante [" + loc_cCodigo + ;
897:             "] - " + ALLTRIM(THIS.this_oBusinessObject.this_cDescricao) + "?", ;
898:             "Confirmar Exclus" + CHR(227) + "o")
899: 
900:         IF loc_lConfirma
901:             loc_lExcluido = THIS.this_oBusinessObject.Excluir()
902:             IF loc_lExcluido
903:                 THIS.CarregarLista()
904:             ENDIF
905:         ENDIF
906:     ENDPROC
907: 
908:     *===========================================================================
909:     * BtnBuscarClick - Filtra lista de constantes por codigo ou descricao
910:     *===========================================================================
911:     PROCEDURE BtnBuscarClick()
912:         LOCAL loc_cBusca, loc_cFiltro, loc_oGrid, loc_lResultado
913: 
914:         loc_cBusca = ALLTRIM(INPUTBOX("Pesquisar por c" + CHR(243) + ;
915:             "digo ou descri" + CHR(231) + CHR(227) + "o:", ;
916:             "Buscar Constantes", ""))
917: 
918:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
919: 
920:         IF EMPTY(loc_cBusca)
921:             loc_lResultado = THIS.this_oBusinessObject.Buscar("")
922:         ELSE
923:             loc_cFiltro = "a.codigos LIKE " + EscaparSQL("%" + loc_cBusca + "%")
924:             loc_lResultado = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
925:         ENDIF
926: 
927:         IF loc_lResultado
928:             loc_oGrid.RecordSource = "crSigCdCnt"
929:             WITH loc_oGrid
930:                 .Column1.ControlSource   = "crSigCdCnt.codigos"
931:                 .Column1.Width           = 60
932:                 .Column1.Header1.Caption = "C" + CHR(243) + "digo"
933:                 .Column2.ControlSource   = "crSigCdCnt.descricaos"
934:                 .Column2.Width           = 267
935:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
936:                 .Column3.ControlSource   = "crSigCdCnt.consts"
937:                 .Column3.Width           = 177
938:                 .Column3.Header1.Caption = "Valor"
939:                 .Column4.ControlSource   = "crSigCdCnt.moedas"
940:                 .Column4.Width           = 42
941:                 .Column4.Header1.Caption = "Moeda"
942:             ENDWITH
943:             THIS.FormatarGridLista(loc_oGrid)
944:             loc_oGrid.Refresh()
945:         ENDIF
946:     ENDPROC
947: 
948:     *===========================================================================
949:     * BtnEncerrarClick - Fecha o formulario
950:     *===========================================================================
951:     PROCEDURE BtnEncerrarClick()
952:         THIS.Release()
953:     ENDPROC
954: 
955:     *===========================================================================
956:     * BtnSalvarClick - Salva os dados (Inserir ou Atualizar)
957:     * Validacoes obrigatorias FORA do TRY (regra critica #16)
958:     *===========================================================================
959:     PROCEDURE BtnSalvarClick()
960:         LOCAL loc_lSalvo
961: 
962:         IF THIS.this_cModoAtual = "INCLUIR" AND ;
963:                 EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.Value))
964:             MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio!")
965:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus
966:             RETURN
967:         ENDIF
968: 
969:         IF EMPTY(ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.Value))
970:             MsgAviso("Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!")
971:             THIS.pgf_4c_Paginas.Page2.txt_4c_CodMoeda.SetFocus
972:             RETURN
973:         ENDIF
974: 
975:         THIS.FormParaBO()
976: 
977:         loc_lSalvo = THIS.this_oBusinessObject.Salvar()
978: 
979:         IF loc_lSalvo
980:             MsgInfo("Registro salvo com sucesso!")
981:             THIS.AlternarPagina(1)
982:         ENDIF
983:     ENDPROC
984: 
985:     *===========================================================================
986:     * BtnCancelarClick - Cancela edicao e retorna para a lista
987:     *===========================================================================
988:     PROCEDURE BtnCancelarClick()
989:         THIS.AlternarPagina(1)
990:     ENDPROC
991: 
992:     *===========================================================================
993:     * CodMoedaLostFocus - Handler LostFocus de txt_4c_CodMoeda
994:     * Busca descricao da moeda pelo codigo digitado
995:     *===========================================================================
996:     PROCEDURE CodMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
997:         LOCAL loc_oPagina, loc_cCodigo
998:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
999:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_CodMoeda.Value)
1000: 
1001:         IF EMPTY(loc_cCodigo)
1002:             loc_oPagina.txt_4c_DescMoeda.Value   = ""
1003:             loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
1004:             RETURN
1005:         ENDIF
1006: 
1007:         THIS.AbrirLookupMoedaCodigo(loc_cCodigo)
1008:     ENDPROC
1009: 
1010:     *===========================================================================
1011:     * DescMoedaLostFocus - Handler LostFocus de txt_4c_DescMoeda
1012:     * Busca moeda pela descricao digitada
1013:     *===========================================================================
1014:     PROCEDURE DescMoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1015:         LOCAL loc_oPagina, loc_cDescricao
1016:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1017:         loc_cDescricao = ALLTRIM(loc_oPagina.txt_4c_DescMoeda.Value)
1018: 
1019:         IF EMPTY(loc_cDescricao)
1020:             RETURN
1021:         ENDIF
1022: 
1023:         THIS.AbrirLookupMoedaDescricao(loc_cDescricao)
1024:     ENDPROC
1025: 
1026:     *===========================================================================
1027:     * AbrirLookupMoedaCodigo - Picker de Moeda por codigo (cmoes)
1028:     * Tabela: SigCdMoe | Pesquisa: cmoes | Preenche: CodMoeda + DescMoeda
1029:     *===========================================================================
1030:     PROCEDURE AbrirLookupMoedaCodigo(par_cValor)
1031:         LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
1032:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1033:         loc_lResultado = .F.
1034: 
1035:         TRY
1036:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1037:                 "SigCdMoe", ;
1038:                 "cursor_4c_BuscaMoe", ;
1039:                 "cmoes", ;
1040:                 par_cValor, ;
1041:                 "Buscar Moeda")
1042: 
1043:             IF VARTYPE(loc_oBusca) = "O"
1044:                 IF !loc_oBusca.this_lAchouRegistro
1045:                     loc_oBusca.mAddColuna("cmoes", "", "Moeda")
1046:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1047:                     loc_oBusca.Show()
1048:                 ENDIF
1049: 
1050:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1051:                     SELECT cursor_4c_BuscaMoe
1052:                     loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1053:                     loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoe.dmoes)
1054:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
1055:                     loc_lResultado = .T.
1056:                 ELSE
1057:                     loc_oPagina.txt_4c_CodMoeda.Value    = ""
1058:                     loc_oPagina.txt_4c_DescMoeda.Value   = ""
1059:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .T.
1060:                 ENDIF
1061: 
1062:                 loc_oBusca.Release()
1063:             ENDIF
1064:         CATCH TO loc_oErro
1065:             MostrarErro("Erro ao buscar moeda:" + CHR(13) + ;
1066:                 loc_oErro.Message, "FormCst.AbrirLookupMoedaCodigo")
1067:         ENDTRY
1068: 
1069:         IF USED("cursor_4c_BuscaMoe")
1070:             USE IN cursor_4c_BuscaMoe
1071:         ENDIF
1072: 
1073:         RETURN loc_lResultado
1074:     ENDPROC
1075: 
1076:     *===========================================================================
1077:     * AbrirLookupMoedaDescricao - Picker de Moeda por descricao (dmoes)
1078:     * Tabela: SigCdMoe | Pesquisa: dmoes | Preenche: CodMoeda + DescMoeda
1079:     *===========================================================================
1080:     PROCEDURE AbrirLookupMoedaDescricao(par_cValor)
1081:         LOCAL loc_oBusca, loc_oPagina, loc_lResultado, loc_oErro
1082:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
1083:         loc_lResultado = .F.
1084: 
1085:         TRY
1086:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1087:                 "SigCdMoe", ;
1088:                 "cursor_4c_BuscaMoeDesc", ;
1089:                 "dmoes", ;
1090:                 par_cValor, ;
1091:                 "Buscar Moeda por Descri" + CHR(231) + CHR(227) + "o")
1092: 
1093:             IF VARTYPE(loc_oBusca) = "O"
1094:                 IF !loc_oBusca.this_lAchouRegistro
1095:                     loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1096:                     loc_oBusca.mAddColuna("cmoes", "", "Moeda")
1097:                     loc_oBusca.Show()
1098:                 ENDIF
1099: 
1100:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeDesc")
1101:                     SELECT cursor_4c_BuscaMoeDesc
1102:                     loc_oPagina.txt_4c_CodMoeda.Value    = ALLTRIM(cursor_4c_BuscaMoeDesc.cmoes)
1103:                     loc_oPagina.txt_4c_DescMoeda.Value   = ALLTRIM(cursor_4c_BuscaMoeDesc.dmoes)
1104:                     loc_oPagina.txt_4c_DescMoeda.Enabled = .F.
1105:                     loc_lResultado = .T.
1106:                 ELSE
1107:                     loc_oPagina.txt_4c_CodMoeda.Value  = ""
1108:                     loc_oPagina.txt_4c_DescMoeda.Value = ""
1109:                 ENDIF
1110: 
1111:                 loc_oBusca.Release()
1112:             ENDIF
1113:         CATCH TO loc_oErro
1114:             MostrarErro("Erro ao buscar moeda por descri" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
1115:                 loc_oErro.Message, "FormCst.AbrirLookupMoedaDescricao")
1116:         ENDTRY
1117: 
1118:         IF USED("cursor_4c_BuscaMoeDesc")
1119:             USE IN cursor_4c_BuscaMoeDesc
1120:         ENDIF
1121: 
1122:         RETURN loc_lResultado
1123:     ENDPROC
1124: 
1125: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CstBO.prg):
*==============================================================================
* CstBO.prg - Business Object para Constantes
* Tabela: SigCdCnt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CstBO AS BusinessBase

    *-- Propriedades da tabela SigCdCnt
    this_cCodigo    = ""    && Codigos     C(3)  - PK
    this_cDescricao = ""    && Descricaos  C(40)
    this_nConstante = 0     && Consts      N(13,6) - Valor da Constante
    this_cMoeda     = ""    && Moedas      C(3)  - FK SigCdMoe.Cmoes

    *-- Propriedade auxiliar de exibicao (nao persistida em SigCdCnt)
    this_cDescMoeda = ""    && SigCdMoe.Dmoes C(15) - Descricao da Moeda

    *--------------------------------------------------------------------------
    * Init - Inicializa BO configurando tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCnt"
            THIS.this_cCampoChave = "Codigos"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CstBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                THIS.this_cDescricao = TratarNulo(descricaos, "C")
                THIS.this_nConstante = TratarNulo(consts,     "N")
                THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CstBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo da Constante j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cMoeda)
            MsgAviso("Moeda n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se codigos ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigCdCnt" + ;
                " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")

            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (NVL(cursor_4c_ChkCod.nTotal, 0) > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CstBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCnt (codigos, descricaos, consts, moedas)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    <<EscaparSQL(THIS.this_cMoeda)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CstBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCnt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCnt
                SET descricaos = <<EscaparSQL(THIS.this_cDescricao)>>,
                    consts     = <<FormatarNumeroSQL(THIS.this_nConstante, 6)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoeda)>>
                WHERE codigos = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CstBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCnt
    * Valida uso em SigOpTdt (6 campos de constante) antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar se constante esta sendo usada em operacoes (SigOpTdt)
            loc_cSQL = "SELECT COUNT(*) AS nTotal FROM SigOpTdt" + ;
                " WHERE (const1t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const1t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const2t2s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t1s = " + EscaparSQL(THIS.this_cCodigo) + ;
                " OR const3t2s = " + EscaparSQL(THIS.this_cCodigo) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCnt")

            IF loc_nResultado < 0
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ChkCnt")
                    SELECT cursor_4c_ChkCnt
                    loc_nUso = NVL(cursor_4c_ChkCnt.nTotal, 0)
                    USE IN cursor_4c_ChkCnt
                ENDIF

                IF loc_nUso > 0
                    MsgAviso("Constante sendo utilizada em Opera" + CHR(231) + CHR(245) + "es!")
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCnt WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CstBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor crSigCdCnt com codigos, descricaos, consts, moedas
    * (cursor nomeado igual ao legado para compatibilidade com grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("crSigCdCnt")
                    SET NULL ON
                    CREATE CURSOR crSigCdCnt (codigos C(3), descricaos C(40), consts N(13,6), moedas C(3))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas" + ;
                    " FROM SigCdCnt a"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

                IF USED("crSigCdCnt")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT crSigCdCnt
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdCnt")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar constantes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CstBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria (codigos)
    * Tambem carrega descricao da moeda via JOIN com SigCdMoe
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos, a.consts, a.moedas," + ;
                " b.dmoes AS descmoes" + ;
                " FROM SigCdCnt a" + ;
                " LEFT JOIN SigCdMoe b ON b.cmoes = a.moedas" + ;
                " WHERE a.codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    SELECT cursor_4c_Carrega
                    THIS.this_cCodigo    = TratarNulo(codigos,    "C")
                    THIS.this_cDescricao = TratarNulo(descricaos, "C")
                    THIS.this_nConstante = TratarNulo(consts,     "N")
                    THIS.this_cMoeda     = TratarNulo(moedas,     "C")
                    THIS.this_cDescMoeda = TratarNulo(descmoes,   "C")
                    THIS.this_lNovoRegistro = .F.
                    loc_lSucesso = .T.
                ELSE
                    MsgAviso("Constante n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar constante:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CstBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDescMoeda - Carrega descricao da moeda pelo codigo
    * Usado apos lookup de moeda para atualizar campo de exibicao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDescMoeda(par_cCodigoMoeda)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cCodigoMoeda)
                THIS.this_cDescMoeda = ""
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.dmoes FROM SigCdMoe a" + ;
                    " WHERE a.cmoes = " + EscaparSQL(par_cCodigoMoeda)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Moe")

                IF loc_nResultado >= 0
                    IF RECCOUNT("cursor_4c_Moe") > 0
                        SELECT cursor_4c_Moe
                        THIS.this_cDescMoeda = TratarNulo(dmoes, "C")
                    ELSE
                        THIS.this_cDescMoeda = ""
                    ENDIF

                    IF USED("cursor_4c_Moe")
                        USE IN cursor_4c_Moe
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o da moeda:" + CHR(13) + loException.Message, "CstBO.CarregarDescMoeda")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

