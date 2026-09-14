# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [BINDEVENT-PARAMS] Handler 'ValidarVincs' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarVincs(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'CodRelGerLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE CodRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'DesRelGerLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE DesRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formfnl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1603 linhas total):

*-- Linhas 9 a 154:
9:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
10:     Height      = 600
11:     Width       = 1000
12:     Caption     = "Tabela de Finalizacoes"   && acento setado em InicializarForm via CHR()
13:     AutoCenter  = .T.
14:     ShowWindow  = 1
15:     WindowType  = 1
16:     ControlBox  = .F.
17:     TitleBar    = 0
18:     Themes      = .F.
19:     BorderStyle = 2
20: 
21:     *-- Propriedades de estado
22:     this_oBusinessObject = .NULL.
23:     this_cModoAtual      = "LISTA"
24: 
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
43:             THIS.Caption = "Tabela de Finaliza" + CHR(231) + CHR(245) + "es"
44: 
45:             THIS.this_oBusinessObject = CREATEOBJECT("fnlBO")
46: 
47:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
48:                 MostrarErro("Erro ao criar fnlBO" + CHR(13) + ;
49:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
50:                     "Formfnl.InicializarForm")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53: 
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Visible    = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 
60:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
61:                     THIS.CarregarLista()
62:                 ENDIF
63: 
64:                 loc_lSucesso = .T.
65:             ENDIF
66: 
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar Formfnl:" + CHR(13) + ;
69:                 loException.Message + CHR(13) + ;
70:                 "Linha: " + TRANSFORM(loException.LineNo), ;
71:                 "Formfnl.InicializarForm")
72:         ENDTRY
73: 
74:         RETURN loc_lSucesso
75:     ENDPROC
76: 
77:     *===========================================================================
78:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
79:     * Top=-29 esconde as abas; controles internos compensam +29 no Top
80:     *===========================================================================
81:     PROTECTED PROCEDURE ConfigurarPageFrame()
82:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 (Lista): cabecalho, botoes e grid
108:     * Posicoes do original (compensacao +29 aplicada):
109:     *   cntSombra.Top=1 -> cnt_4c_Cabecalho.Top=30
110:     *   Grupo_op.Top=-1 -> cnt_4c_Botoes.Top=28  (Left=542 canonico)
111:     *   Grupo_Saida.Top=-1 -> cnt_4c_Saida.Top=28 (Left=917 canonico)
112:     *   Grade original Top=88 -> grd_4c_Lista.Top=117
113:     *===========================================================================
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         LOCAL loc_oPagina
116:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 30
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131: 
132:             .AddObject("lbl_4c_Sombra", "Label")
133:             WITH .lbl_4c_Sombra
134:                 .Caption   = ""
135:                 .Top       = 15
136:                 .Left      = 10
137:                 .Width     = THIS.Width
138:                 .Height    = 40
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 16
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(0, 0, 0)
143:                 .BackStyle = 0
144:                 .AutoSize  = .F.
145:                 .Visible   = .T.
146:             ENDWITH
147: 
148:             .AddObject("lbl_4c_Titulo", "Label")
149:             WITH .lbl_4c_Titulo
150:                 .Caption   = ""
151:                 .Top       = 18
152:                 .Left      = 10
153:                 .Width     = THIS.Width
154:                 .Height    = 46

*-- Linhas 349 a 415:
349:             .Visible            = .T.
350:         ENDWITH
351: 
352:         *-- BINDEVENTs dos botoes CRUD
353:         WITH loc_oPagina.cnt_4c_Botoes
354:             BINDEVENT(.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
355:             BINDEVENT(.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
356:             BINDEVENT(.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
357:             BINDEVENT(.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
358:             BINDEVENT(.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
359:             .Visible     = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *===========================================================================
367:     * ConfigurarPaginaDados - Configura Page2 (Dados)
368:     * Fase 5: botoes Confirmar/Cancelar + primeiros 50% dos campos
369:     * Fase 6: segundo 50% (Opc_fixo, Vincs, RelGerencial)
370:     *
371:     * Posicoes do original (compensacao +29 aplicada):
372:     *   Grupo_Salva.Top=4+29=33, Left=842
373:     *   Campos: Top_original + 29
374:     *===========================================================================
375:     PROTECTED PROCEDURE ConfigurarPaginaDados()
376:         LOCAL loc_oPagina
377:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
378: 
379:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
380:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
381: 
382:         *-- Container Salvar/Cancelar (Grupo_Salva no legado: Top=4+29=33, Left=842)
383:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
384:         WITH loc_oPagina.cnt_4c_BotoesAcao
385:             .Top         = 33
386:             .Left        = 842
387:             .Width       = 160
388:             .Height      = 85
389:             .BackStyle   = 0
390:             .Visible     = .T.
391: 
392:             .AddObject("cmd_4c_Confirmar", "CommandButton")
393:             WITH .cmd_4c_Confirmar
394:                 .Caption         = "Confirmar"
395:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
396:                 .PicturePosition = 13
397:                 .Top             = 5
398:                 .Left            = 5
399:                 .Width           = 75
400:                 .Height          = 75
401:                 .FontName        = "Comic Sans MS"
402:                 .FontBold        = .T.
403:                 .FontItalic      = .T.
404:                 .FontSize        = 8
405:                 .ForeColor       = RGB(90, 90, 90)
406:                 .BackColor       = RGB(255, 255, 255)
407:                 .SpecialEffect   = 0
408:                 .MousePointer    = 15
409:                 .WordWrap        = .T.
410:                 .AutoSize        = .F.
411:                 .Visible         = .T.
412:             ENDWITH
413: 
414:             .AddObject("cmd_4c_Cancelar", "CommandButton")
415:             WITH .cmd_4c_Cancelar

*-- Linhas 435 a 479:
435:             ENDWITH
436:         ENDWITH
437: 
438:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
439:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
440: 
441:         *-- === FASE 5: PRIMEIROS 50% DOS CAMPOS ===
442: 
443:         *-- Label Impressora (Say6 original: top=129, left=181 -> +29: top=158)
444:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
445:         WITH loc_oPagina.lbl_4c_Label6
446:             .Caption   = "Impressora :"
447:             .Top       = 158
448:             .Left      = 181
449:             .Width     = 68
450:             .Height    = 17
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .ForeColor = RGB(90, 90, 90)
454:             .BackStyle = 0
455:             .AutoSize  = .F.
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- ComboBox Impressora (Cmb_Imp original: top=125, left=249 -> +29: top=154)
460:         loc_oPagina.AddObject("cbo_4c_Cmb_Imp", "ComboBox")
461:         WITH loc_oPagina.cbo_4c_Cmb_Imp
462:             .Top           = 154
463:             .Left          = 249
464:             .Width         = 105
465:             .Height        = 24
466:             .FontName      = "Tahoma"
467:             .FontSize      = 8
468:             .SpecialEffect = 1
469:             .Style         = 2
470:             .Visible       = .T.
471:         ENDWITH
472: 
473:         *-- Label Codigo finalizador (Say32 original: top=154, left=202 -> +29: top=183)
474:         loc_oPagina.AddObject("lbl_4c_Label32", "Label")
475:         WITH loc_oPagina.lbl_4c_Label32
476:             .Caption   = "C" + CHR(243) + "digo :"
477:             .Top       = 183
478:             .Left      = 202
479:             .Width     = 44

*-- Linhas 586 a 631:
586:             .Visible   = .T.
587:         ENDWITH
588: 
589:         *-- OptionGroup Fixo (Opc_fixo original: top=225, left=249 -> +29: top=254)
590:         *-- Value=2 default = "Nao". ControlSource era crSigFiNal.nfixos (1=Sim, 2=Nao)
591:         loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
592:         WITH loc_oPagina.opt_4c_Opc_fixo
593:             .ButtonCount = 2
594:             .Value       = 2
595:             .Top         = 254
596:             .Left        = 249
597:             .BackStyle   = 0
598:             .BorderStyle = 0
599:             .AutoSize    = .T.
600:             .Visible     = .T.
601:         ENDWITH
602:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
603:             .Caption   = "Sim"
604:             .Left      = 5
605:             .Top       = 5
606:             .AutoSize  = .T.
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .BackStyle = 0
610:             .ForeColor = RGB(90, 90, 90)
611:             .Themes    = .F.
612:         ENDWITH
613:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
614:             .Caption   = "N" + CHR(227) + "o"
615:             .Left      = 47
616:             .Top       = 5
617:             .AutoSize  = .T.
618:             .FontName  = "Tahoma"
619:             .FontSize  = 8
620:             .BackStyle = 0
621:             .ForeColor = RGB(90, 90, 90)
622:             .Themes    = .F.
623:         ENDWITH
624: 
625:         *-- Label Vinculado (Say4 original: top=255, left=162 -> +29: top=284)
626:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
627:         WITH loc_oPagina.lbl_4c_Label4
628:             .Caption   = "Vinculado (S/N) :"
629:             .Top       = 284
630:             .Left      = 162
631:             .Width     = 85

*-- Linhas 700 a 760:
700:             .Visible       = .T.
701:         ENDWITH
702: 
703:         *-- BINDEVENTs para validacao de Vincs (S/N)
704:         BINDEVENT(loc_oPagina.txt_4c_Vincs, "KeyPress", THIS, "ValidarVincs")
705: 
706:         *-- BINDEVENTs para lookup de Rel. Gerencial (LostFocus + F4)
707:         BINDEVENT(loc_oPagina.txt_4c_CodRelGer, "KeyPress", THIS, "CodRelGerLostFocus")
708:         BINDEVENT(loc_oPagina.txt_4c_CodRelGer, "KeyPress",  THIS, "CodRelGerKeyPress")
709:         BINDEVENT(loc_oPagina.txt_4c_DesRelGer, "KeyPress", THIS, "DesRelGerLostFocus")
710:         BINDEVENT(loc_oPagina.txt_4c_DesRelGer, "KeyPress",  THIS, "DesRelGerKeyPress")
711: 
712:         THIS.TornarControlesVisiveis(loc_oPagina)
713:     ENDPROC
714: 
715:     *===========================================================================
716:     * CarregarLista - Carrega dados no Grid da Page1 via BO
717:     * Cursor: crSigFiNal (SigFiNal LEFT JOIN SigFiRlg)
718:     * Colunas: imps, ordems, descrs, descs
719:     *===========================================================================
720:     PROCEDURE CarregarLista()
721:         LOCAL loc_lResultado, loc_oGrid
722:         loc_lResultado = .F.
723: 
724:         TRY
725:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
726:                 loc_lResultado = .T.
727:             ELSE
728:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
729:                 IF THIS.this_oBusinessObject.Buscar("")
730:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
731: 
732:                     loc_oGrid.RecordSource = "crSigFiNal"
733:                     loc_oGrid.ColumnCount  = 4
734: 
735:                     WITH loc_oGrid
736:                         .Column1.ControlSource   = "crSigFiNal.imps"
737:                         .Column1.Width           = 160
738:                         .Column1.Header1.Caption = "Impressora"
739: 
740:                         .Column2.ControlSource   = "crSigFiNal.ordems"
741:                         .Column2.Width           = 80
742:                         .Column2.Header1.Caption = "Ordem"
743: 
744:                         .Column3.ControlSource   = "crSigFiNal.descrs"
745:                         .Column3.Width           = 350
746:                         .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
747: 
748:                         .Column4.ControlSource   = "crSigFiNal.descs"
749:                         .Column4.Width           = 250
750:                         .Column4.Header1.Caption = "Rel. Gerencial"
751:                     ENDWITH
752: 
753:                     THIS.FormatarGridLista(loc_oGrid)
754:                     loc_lResultado = .T.
755:                 ENDIF
756:                 ENDIF
757:             ENDIF
758: 
759:         CATCH TO loException
760:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;

*-- Linhas 766 a 1603:
766:     ENDPROC
767: 
768:     *===========================================================================
769:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
770:     * Percorre Pages de PageFrames e Controls de Containers
771:     *===========================================================================
772:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
773:         LOCAL loc_nI, loc_oObjeto, loc_nP
774: 
775:         FOR loc_nI = 1 TO par_oContainer.ControlCount
776:             loc_oObjeto = par_oContainer.Controls(loc_nI)
777: 
778:             IF VARTYPE(loc_oObjeto) = "O"
779:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
780:                     loc_oObjeto.Visible = .T.
781:                 ENDIF
782: 
783:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
784:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
785:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
786:                     ENDFOR
787:                 ENDIF
788: 
789:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
790:                     THIS.TornarControlesVisiveis(loc_oObjeto)
791:                 ENDIF
792:             ENDIF
793:         ENDFOR
794:     ENDPROC
795: 
796:     *===========================================================================
797:     * FormatarGridLista - Aplica formatacao visual ao grid da lista
798:     *===========================================================================
799:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
800:         WITH par_oGrid
801:             .FontName = "Tahoma"
802:             .FontSize = 8
803:         ENDWITH
804:     ENDPROC
805: 
806:     *===========================================================================
807:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
808:     * Ao voltar para lista (par_nPagina=1) recarrega os dados
809:     *===========================================================================
810:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
811:         LOCAL loc_lResultado
812:         loc_lResultado = .F.
813: 
814:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
815:             RETURN .F.
816:         ENDIF
817: 
818:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
819: 
820:         IF par_nPagina = 1
821:             THIS.CarregarLista()
822:         ENDIF
823: 
824:         loc_lResultado = .T.
825:         RETURN loc_lResultado
826:     ENDPROC
827: 
828:     *===========================================================================
829:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
830:     *===========================================================================
831:     PROCEDURE BtnIncluirClick()
832:         THIS.this_oBusinessObject.NovoRegistro()
833:         THIS.LimparCampos()
834:         THIS.this_cModoAtual = "INCLUIR"
835:         THIS.HabilitarCampos(.T.)
836:         THIS.AjustarBotoesPorModo()
837:         THIS.AlternarPagina(2)
838:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp) = "O"
839:             THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp.SetFocus
840:         ENDIF
841:     ENDPROC
842: 
843:     *===========================================================================
844:     * BtnVisualizarClick - Abre Page2 em modo somente leitura para o registro selecionado
845:     *===========================================================================
846:     PROCEDURE BtnVisualizarClick()
847:         LOCAL loc_cImps, loc_nOrdems
848:         loc_cImps   = ""
849:         loc_nOrdems = 0
850: 
851:         IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
852:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
853:             RETURN
854:         ENDIF
855: 
856:         SELECT crSigFiNal
857:         loc_cImps   = ALLTRIM(crSigFiNal.imps)
858:         loc_nOrdems = crSigFiNal.ordems
859: 
860:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
861:             RETURN
862:         ENDIF
863: 
864:         THIS.BOParaForm()
865:         THIS.this_cModoAtual = "VISUALIZAR"
866:         THIS.HabilitarCampos(.F.)
867:         THIS.AjustarBotoesPorModo()
868:         THIS.AlternarPagina(2)
869:     ENDPROC
870: 
871:     *===========================================================================
872:     * BtnAlterarClick - Abre Page2 para edicao do registro selecionado
873:     *===========================================================================
874:     PROCEDURE BtnAlterarClick()
875:         LOCAL loc_cImps, loc_nOrdems
876:         loc_cImps   = ""
877:         loc_nOrdems = 0
878: 
879:         IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
880:             MsgAviso("Nenhum registro selecionado.", "Alterar")
881:             RETURN
882:         ENDIF
883: 
884:         SELECT crSigFiNal
885:         loc_cImps   = ALLTRIM(crSigFiNal.imps)
886:         loc_nOrdems = crSigFiNal.ordems
887: 
888:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
889:             RETURN
890:         ENDIF
891: 
892:         THIS.this_oBusinessObject.EditarRegistro()
893:         THIS.BOParaForm()
894:         THIS.this_cModoAtual = "ALTERAR"
895:         THIS.HabilitarCampos(.T.)
896:         THIS.AjustarBotoesPorModo()
897:         THIS.AlternarPagina(2)
898:         IF VARTYPE(THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem) = "O"
899:             THIS.pgf_4c_Paginas.Page2.txt_4c_Ordem.SetFocus
900:         ENDIF
901:     ENDPROC
902: 
903:     *===========================================================================
904:     * BtnExcluirClick - Confirma e exclui o registro selecionado na lista
905:     *===========================================================================
906:     PROCEDURE BtnExcluirClick()
907:         LOCAL loc_cImps, loc_nOrdems, loc_cDescrs
908:         loc_cImps   = ""
909:         loc_nOrdems = 0
910:         loc_cDescrs = ""
911: 
912:         IF !USED("crSigFiNal") OR EOF("crSigFiNal") OR RECCOUNT("crSigFiNal") = 0
913:             MsgAviso("Nenhum registro selecionado.", "Excluir")
914:             RETURN
915:         ENDIF
916: 
917:         SELECT crSigFiNal
918:         loc_cImps   = ALLTRIM(crSigFiNal.imps)
919:         loc_nOrdems = crSigFiNal.ordems
920:         loc_cDescrs = ALLTRIM(crSigFiNal.descrs)
921: 
922:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o de:" + CHR(13) + loc_cDescrs, "Excluir")
923:             RETURN
924:         ENDIF
925: 
926:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cImps, loc_nOrdems)
927:             RETURN
928:         ENDIF
929: 
930:         IF THIS.this_oBusinessObject.Excluir()
931:             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
932:             THIS.CarregarLista()
933:         ENDIF
934:     ENDPROC
935: 
936:     *===========================================================================
937:     * BtnBuscarClick - Recarrega lista com todos os registros (limpa filtro)
938:     *===========================================================================
939:     PROCEDURE BtnBuscarClick()
940:         THIS.CarregarLista()
941:     ENDPROC
942: 
943:     *===========================================================================
944:     * BtnEncerrarClick - Fecha o formulario
945:     *===========================================================================
946:     PROCEDURE BtnEncerrarClick()
947:         THIS.Release()
948:     ENDPROC
949: 
950:     *===========================================================================
951:     * BtnSalvarClick - Salva o registro (INSERT ou UPDATE)
952:     * Validacoes: Impressora obrigatoria, Ordem obrigatoria,
953:     *             Ordem nao duplicada (INSERT), Codigo nao duplicado (INSERT)
954:     * Gera: ncodfinzs se 0 (INSERT)
955:     *===========================================================================
956:     PROCEDURE BtnSalvarClick()
957:         LOCAL loc_lSucesso, loc_oPg2, loc_cImps, loc_nOrdems, loc_nFinalz
958:         loc_lSucesso = .F.
959:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
960:         loc_cImps   = ""
961:         loc_nOrdems = 0
962:         loc_nFinalz = 0
963: 
964:         *-- Validacoes FORA do TRY para permitir RETURN direto
965:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
966:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
967:         ENDIF
968: 
969:         IF EMPTY(loc_cImps)
970:             MsgAviso("Selecione a Impressora.", "Confirmar")
971:             IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
972:                 loc_oPg2.cbo_4c_Cmb_Imp.SetFocus
973:             ENDIF
974:             RETURN
975:         ENDIF
976: 
977:         IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
978:             loc_nOrdems = loc_oPg2.txt_4c_Ordem.Value
979:         ENDIF
980: 
981:         IF loc_nOrdems <= 0
982:             MsgAviso("Informe a Ordem Finalizadora.", "Confirmar")
983:             IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
984:                 loc_oPg2.txt_4c_Ordem.SetFocus
985:             ENDIF
986:             RETURN
987:         ENDIF
988: 
989:         IF THIS.this_cModoAtual = "INCLUIR"
990:             *-- Valida Imps+Ordems nao duplicados
991:             IF THIS.this_oBusinessObject.ValidarOrdemDuplicada(loc_cImps, loc_nOrdems)
992:                 MsgAviso("Ordem j" + CHR(225) + " cadastrada!", "Confirmar")
993:                 IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
994:                     loc_oPg2.txt_4c_Ordem.SetFocus
995:                 ENDIF
996:                 RETURN
997:             ENDIF
998: 
999:             *-- Gera ncodfinzs se o usuario nao informou
1000:             IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1001:                 loc_nFinalz = loc_oPg2.txt_4c_Finalz.Value
1002:             ENDIF
1003:             IF loc_nFinalz <= 0
1004:                 loc_nFinalz = THIS.this_oBusinessObject.GerarProximoNcodFinzs(loc_cImps)
1005:                 IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1006:                     loc_oPg2.txt_4c_Finalz.Value = loc_nFinalz
1007:                 ENDIF
1008:             ENDIF
1009: 
1010:             *-- Valida Imps+ncodfinzs nao duplicados
1011:             IF THIS.this_oBusinessObject.ValidarCodigoDuplicado(loc_cImps, loc_nFinalz)
1012:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Confirmar")
1013:                 IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1014:                     loc_oPg2.txt_4c_Finalz.SetFocus
1015:                 ENDIF
1016:                 RETURN
1017:             ENDIF
1018:         ENDIF
1019: 
1020:         TRY
1021:             THIS.FormParaBO()
1022: 
1023:             loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1024: 
1025:             IF loc_lSucesso
1026:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1027:                 THIS.this_cModoAtual = "LISTA"
1028:                 THIS.AlternarPagina(1)
1029:             ENDIF
1030: 
1031:         CATCH TO loException
1032:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message + CHR(13) + ;
1033:                 "Linha: " + TRANSFORM(loException.LineNo), "Formfnl.BtnSalvarClick")
1034:         ENDTRY
1035:     ENDPROC
1036: 
1037:     *===========================================================================
1038:     * BtnCancelarClick - Cancela operacao e retorna para a lista
1039:     *===========================================================================
1040:     PROCEDURE BtnCancelarClick()
1041:         THIS.this_cModoAtual = "LISTA"
1042:         THIS.AlternarPagina(1)
1043:         THIS.CarregarLista()
1044:     ENDPROC
1045: 
1046:     *===========================================================================
1047:     * CarregarComboImpressora - Popula cbo_4c_Cmb_Imp com lista fixa de impressoras
1048:     * Lista identica ao AddItem() do SIGCDFNL.Init no legado
1049:     *===========================================================================
1050:     PROTECTED PROCEDURE CarregarComboImpressora()
1051:         LOCAL loc_oCbo
1052:         loc_oCbo = THIS.pgf_4c_Paginas.Page2.cbo_4c_Cmb_Imp
1053: 
1054:         IF VARTYPE(loc_oCbo) != "O"
1055:             RETURN
1056:         ENDIF
1057: 
1058:         loc_oCbo.Clear()
1059:         loc_oCbo.AddItem("DATAREGIS   ")
1060:         loc_oCbo.AddItem("SWEDA       ")
1061:         loc_oCbo.AddItem("BEMATECH    ")
1062:         loc_oCbo.AddItem("BEMA8501    ")
1063:         loc_oCbo.AddItem("NDATAREGIS  ")
1064:         loc_oCbo.AddItem("EPSON       ")
1065:         loc_oCbo.AddItem("DARUMA      ")
1066:         loc_oCbo.AddItem("S/IMPRESSORA")
1067:         loc_oCbo.AddItem("NSWEDA      ")
1068:         loc_oCbo.AddItem("Em Branco   ")
1069:     ENDPROC
1070: 
1071:     *===========================================================================
1072:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
1073:     * Usa TYPE() + PEMSTATUS() como guards para seguranca multi-fase
1074:     *===========================================================================
1075:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1076:         LOCAL loc_oPg2
1077:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1078: 
1079:         *-- Campos Fase 5
1080:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1081:             loc_oPg2.cbo_4c_Cmb_Imp.Enabled = par_lHabilitar
1082:         ENDIF
1083:         IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1084:             loc_oPg2.txt_4c_Finalz.Enabled  = par_lHabilitar
1085:         ENDIF
1086:         IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
1087:             loc_oPg2.txt_4c_Ordem.Enabled   = par_lHabilitar
1088:         ENDIF
1089:         IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1090:             loc_oPg2.txt_4c_Descr.Enabled   = par_lHabilitar
1091:         ENDIF
1092: 
1093:         *-- Campos Fase 6 (adicionados por ConfigurarPaginaDados Parte 2)
1094:         IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
1095:             loc_oPg2.opt_4c_Opc_fixo.Enabled = par_lHabilitar
1096:         ENDIF
1097:         IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
1098:             loc_oPg2.txt_4c_Vincs.Enabled    = par_lHabilitar
1099:         ENDIF
1100:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
1101:             loc_oPg2.txt_4c_CodRelGer.Enabled = par_lHabilitar AND ;
1102:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1103:         ENDIF
1104:         IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
1105:             loc_oPg2.txt_4c_DesRelGer.Enabled = par_lHabilitar AND ;
1106:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     *===========================================================================
1111:     * LimparCampos - Limpa todos os campos da Page2 para inclusao
1112:     *===========================================================================
1113:     PROTECTED PROCEDURE LimparCampos()
1114:         LOCAL loc_oPg2
1115:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1116: 
1117:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1118:             loc_oPg2.cbo_4c_Cmb_Imp.Value = ""
1119:         ENDIF
1120:         IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1121:             loc_oPg2.txt_4c_Finalz.Value = 0
1122:         ENDIF
1123:         IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
1124:             loc_oPg2.txt_4c_Ordem.Value = 0
1125:         ENDIF
1126:         IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1127:             loc_oPg2.txt_4c_Descr.Value = ""
1128:         ENDIF
1129: 
1130:         *-- Campos Fase 6
1131:         IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
1132:             loc_oPg2.opt_4c_Opc_fixo.Value = 2
1133:         ENDIF
1134:         IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
1135:             loc_oPg2.txt_4c_Vincs.Value = "N"
1136:         ENDIF
1137:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
1138:             loc_oPg2.txt_4c_CodRelGer.Value = 0
1139:         ENDIF
1140:         IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
1141:             loc_oPg2.txt_4c_DesRelGer.Value = ""
1142:         ENDIF
1143:     ENDPROC
1144: 
1145:     *===========================================================================
1146:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
1147:     * Padrao canonico: Confirmar disabled em VISUALIZAR, Cancelar sempre ativo
1148:     *===========================================================================
1149:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1150:         LOCAL loc_oPg2, loc_lPodeEditar
1151:         loc_oPg2        = THIS.pgf_4c_Paginas.Page2
1152:         loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1153: 
1154:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
1155:             WITH loc_oPg2.cnt_4c_BotoesAcao
1156:                 IF VARTYPE(.cmd_4c_Confirmar) = "O"
1157:                     .cmd_4c_Confirmar.Enabled = loc_lPodeEditar
1158:                 ENDIF
1159:                 IF VARTYPE(.cmd_4c_Cancelar) = "O"
1160:                     .cmd_4c_Cancelar.Enabled = .T.
1161:                 ENDIF
1162:                 .Visible     = .T.
1163:             ENDWITH
1164:         ENDIF
1165:     ENDPROC
1166: 
1167:     *===========================================================================
1168:     * FormParaBO - Transfere valores dos campos do Form para o BO
1169:     * Chamado antes de Salvar()
1170:     *===========================================================================
1171:     PROTECTED PROCEDURE FormParaBO()
1172:         LOCAL loc_oPg2
1173:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1174: 
1175:         *-- Campos Fase 5
1176:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1177:             THIS.this_oBusinessObject.this_cImps     = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
1178:         ENDIF
1179:         IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1180:             THIS.this_oBusinessObject.this_nCodFinzs = loc_oPg2.txt_4c_Finalz.Value
1181:         ENDIF
1182:         IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
1183:             THIS.this_oBusinessObject.this_nOrdems   = loc_oPg2.txt_4c_Ordem.Value
1184:         ENDIF
1185:         IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1186:             THIS.this_oBusinessObject.this_cDescrs   = ALLTRIM(loc_oPg2.txt_4c_Descr.Value)
1187:         ENDIF
1188: 
1189:         *-- Campos Fase 6
1190:         IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
1191:             THIS.this_oBusinessObject.this_nFixos   = loc_oPg2.opt_4c_Opc_fixo.Value
1192:         ENDIF
1193:         IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
1194:             THIS.this_oBusinessObject.this_cVincs   = ALLTRIM(loc_oPg2.txt_4c_Vincs.Value)
1195:         ENDIF
1196:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
1197:             THIS.this_oBusinessObject.this_nRelGers = loc_oPg2.txt_4c_CodRelGer.Value
1198:         ENDIF
1199:     ENDPROC
1200: 
1201:     *===========================================================================
1202:     * BOParaForm - Transfere valores do BO para os campos do Form
1203:     * Chamado apos CarregarPorCodigo() em Visualizar/Alterar
1204:     *===========================================================================
1205:     PROTECTED PROCEDURE BOParaForm()
1206:         LOCAL loc_oPg2
1207:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1208: 
1209:         *-- Campos Fase 5
1210:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1211:             loc_oPg2.cbo_4c_Cmb_Imp.Value = ALLTRIM(THIS.this_oBusinessObject.this_cImps)
1212:         ENDIF
1213:         IF VARTYPE(loc_oPg2.txt_4c_Finalz) = "O"
1214:             loc_oPg2.txt_4c_Finalz.Value  = THIS.this_oBusinessObject.this_nCodFinzs
1215:         ENDIF
1216:         IF VARTYPE(loc_oPg2.txt_4c_Ordem) = "O"
1217:             loc_oPg2.txt_4c_Ordem.Value   = THIS.this_oBusinessObject.this_nOrdems
1218:         ENDIF
1219:         IF VARTYPE(loc_oPg2.txt_4c_Descr) = "O"
1220:             loc_oPg2.txt_4c_Descr.Value   = THIS.this_oBusinessObject.this_cDescrs
1221:         ENDIF
1222: 
1223:         *-- Campos Fase 6
1224:         IF PEMSTATUS(loc_oPg2, "opt_4c_Opc_fixo", 5)
1225:             loc_oPg2.opt_4c_Opc_fixo.Value  = THIS.this_oBusinessObject.this_nFixos
1226:         ENDIF
1227:         IF PEMSTATUS(loc_oPg2, "txt_4c_Vincs", 5)
1228:             loc_oPg2.txt_4c_Vincs.Value      = THIS.this_oBusinessObject.this_cVincs
1229:         ENDIF
1230:         IF PEMSTATUS(loc_oPg2, "txt_4c_CodRelGer", 5)
1231:             loc_oPg2.txt_4c_CodRelGer.Value  = THIS.this_oBusinessObject.this_nRelGers
1232:         ENDIF
1233:         IF PEMSTATUS(loc_oPg2, "txt_4c_DesRelGer", 5)
1234:             loc_oPg2.txt_4c_DesRelGer.Value  = THIS.this_oBusinessObject.this_cDescs
1235:         ENDIF
1236: 
1237:         THIS.AtualizarEstadoDesRelGer()
1238:     ENDPROC
1239: 
1240:     *===========================================================================
1241:     * ValidarVincs - Handler LostFocus para txt_4c_Vincs
1242:     * Valida que o valor eh apenas 'S' ou 'N' (Get_Vincs.Valid no original)
1243:     *===========================================================================
1244:     PROCEDURE ValidarVincs(par_nKeyCode, par_nShiftAltCtrl)
1245:         LOCAL loc_oPg2, loc_cValor
1246:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1247:         loc_cValor = ""
1248: 
1249:         IF VARTYPE(loc_oPg2.txt_4c_Vincs) = "O"
1250:             loc_cValor = UPPER(ALLTRIM(loc_oPg2.txt_4c_Vincs.Value))
1251:             IF !EMPTY(loc_cValor) AND !INLIST(loc_cValor, "S", "N")
1252:                 MsgAviso("Vinculado deve ser S ou N.", "Vinculado")
1253:                 loc_oPg2.txt_4c_Vincs.Value = "N"
1254:                 loc_oPg2.txt_4c_Vincs.SetFocus
1255:             ELSE
1256:                 IF !EMPTY(loc_cValor)
1257:                 loc_oPg2.txt_4c_Vincs.Value = loc_cValor
1258:                 ENDIF
1259:             ENDIF
1260:         ENDIF
1261:     ENDPROC
1262: 
1263:     *===========================================================================
1264:     * CodRelGerKeyPress - Handler KeyPress para txt_4c_CodRelGer
1265:     * Abre lookup via F4 (keycode 28 no VFP9)
1266:     *===========================================================================
1267:     PROCEDURE CodRelGerKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1268:         IF par_nKeyCode = 28
1269:             THIS.AbrirLookupRelGerPorCodigo()
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     *===========================================================================
1274:     * DesRelGerKeyPress - Handler KeyPress para txt_4c_DesRelGer
1275:     * Abre lookup via F4 (keycode 28 no VFP9)
1276:     *===========================================================================
1277:     PROCEDURE DesRelGerKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1278:         IF par_nKeyCode = 28
1279:             THIS.AbrirLookupRelGerPorDescricao()
1280:         ENDIF
1281:     ENDPROC
1282: 
1283:     *===========================================================================
1284:     * CodRelGerLostFocus - Handler LostFocus para txt_4c_CodRelGer
1285:     * Busca SigFiRlg por Ordems; se nao encontrado, abre picker.
1286:     * Equivale ao GetCodRelGer.Valid do original.
1287:     *===========================================================================
1288:     PROCEDURE CodRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1289:         LOCAL loc_oPg2, loc_nCod, loc_cImps, loc_cSQL, loc_nResult
1290:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1291:         loc_nCod  = 0
1292:         loc_cImps = ""
1293: 
1294:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1295:             RETURN
1296:         ENDIF
1297: 
1298:         IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1299:             loc_nCod = loc_oPg2.txt_4c_CodRelGer.Value
1300:         ENDIF
1301: 
1302:         IF loc_nCod = 0
1303:             IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1304:                 loc_oPg2.txt_4c_DesRelGer.Value = ""
1305:             ENDIF
1306:             THIS.AtualizarEstadoDesRelGer()
1307:             RETURN
1308:         ENDIF
1309: 
1310:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1311:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
1312:         ENDIF
1313: 
1314:         IF EMPTY(loc_cImps)
1315:             RETURN
1316:         ENDIF
1317: 
1318:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1319:             EscaparSQL(loc_cImps)
1320:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")
1321: 
1322:         IF loc_nResult > 0 AND USED("csTmpRelgBusca")
1323:             SELECT csTmpRelgBusca
1324:             LOCATE FOR Ordems = loc_nCod
1325: 
1326:             IF !EOF("csTmpRelgBusca")
1327:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1328:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
1329:                 ENDIF
1330:             ELSE
1331:                 IF USED("csTmpRelgBusca")
1332:                     USE IN csTmpRelgBusca
1333:                 ENDIF
1334:                 THIS.AbrirLookupRelGerPorCodigo()
1335:                 THIS.AtualizarEstadoDesRelGer()
1336:                 RETURN
1337:             ENDIF
1338:         ENDIF
1339: 
1340:         IF USED("csTmpRelgBusca")
1341:             USE IN csTmpRelgBusca
1342:         ENDIF
1343:         THIS.AtualizarEstadoDesRelGer()
1344:     ENDPROC
1345: 
1346:     *===========================================================================
1347:     * DesRelGerLostFocus - Handler LostFocus para txt_4c_DesRelGer
1348:     * Busca SigFiRlg por Descrs; se nao encontrado, abre picker.
1349:     * Equivale ao GetDesRelGer.Valid do original.
1350:     * Ativo apenas quando CodRelGer estiver vazio (When do original).
1351:     *===========================================================================
1352:     PROCEDURE DesRelGerLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1353:         LOCAL loc_oPg2, loc_cDes, loc_cImps, loc_cSQL, loc_nResult
1354:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1355:         loc_cDes  = ""
1356:         loc_cImps = ""
1357: 
1358:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1359:             RETURN
1360:         ENDIF
1361: 
1362:         *-- So valida se CodRelGer estiver vazio (When original: Empty(GetCodRelGer.Value))
1363:         IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1364:             IF loc_oPg2.txt_4c_CodRelGer.Value <> 0
1365:                 RETURN
1366:             ENDIF
1367:         ENDIF
1368: 
1369:         IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1370:             loc_cDes = ALLTRIM(loc_oPg2.txt_4c_DesRelGer.Value)
1371:         ENDIF
1372: 
1373:         IF EMPTY(loc_cDes)
1374:             IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1375:                 loc_oPg2.txt_4c_CodRelGer.Value = 0
1376:             ENDIF
1377:             RETURN
1378:         ENDIF
1379: 
1380:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1381:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
1382:         ENDIF
1383: 
1384:         IF EMPTY(loc_cImps)
1385:             RETURN
1386:         ENDIF
1387: 
1388:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1389:             EscaparSQL(loc_cImps)
1390:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgBusca")
1391: 
1392:         IF loc_nResult > 0 AND USED("csTmpRelgBusca")
1393:             SELECT csTmpRelgBusca
1394:             LOCATE FOR UPPER(ALLTRIM(Descrs)) = UPPER(loc_cDes)
1395: 
1396:             IF !EOF("csTmpRelgBusca")
1397:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1398:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgBusca.Ordems
1399:                 ENDIF
1400:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1401:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgBusca.Descrs)
1402:                 ENDIF
1403:             ELSE
1404:                 IF USED("csTmpRelgBusca")
1405:                     USE IN csTmpRelgBusca
1406:                 ENDIF
1407:                 THIS.AbrirLookupRelGerPorDescricao()
1408:                 THIS.AtualizarEstadoDesRelGer()
1409:                 RETURN
1410:             ENDIF
1411:         ENDIF
1412: 
1413:         IF USED("csTmpRelgBusca")
1414:             USE IN csTmpRelgBusca
1415:         ENDIF
1416:         THIS.AtualizarEstadoDesRelGer()
1417:     ENDPROC
1418: 
1419:     *===========================================================================
1420:     * AbrirLookupRelGerPorCodigo - Picker de Rel. Gerencial a partir do campo codigo
1421:     * Tabela: SigFiRlg. Filtrado por Imps do combo.
1422:     * Equivale ao fwBuscaInt com Ordems+Descrs do GetCodRelGer.Valid original.
1423:     *===========================================================================
1424:     PROCEDURE AbrirLookupRelGerPorCodigo()
1425:         LOCAL loc_oPg2, loc_cImps, loc_oBusca, loc_cSQL, loc_nResult
1426:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1427:         loc_cImps = ""
1428: 
1429:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1430:             RETURN
1431:         ENDIF
1432: 
1433:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1434:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
1435:         ENDIF
1436: 
1437:         IF EMPTY(loc_cImps)
1438:             MsgAviso("Selecione a Impressora antes de buscar o Relat" + CHR(243) + ;
1439:                 "rio Gerencial.", "Lookup")
1440:             RETURN
1441:         ENDIF
1442: 
1443:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1444:             EscaparSQL(loc_cImps)
1445:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")
1446: 
1447:         IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
1448:             IF USED("csTmpRelgLkp")
1449:                 USE IN csTmpRelgLkp
1450:             ENDIF
1451:             MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
1452:                 "Lookup")
1453:             RETURN
1454:         ENDIF
1455: 
1456:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1457: 
1458:         IF VARTYPE(loc_oBusca) = "O"
1459:             loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
1460:             loc_oBusca.this_cTitulo        = "Rel. Gerencial"
1461:             loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
1462:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1463:             loc_oBusca.Show()
1464: 
1465:             IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
1466:                 SELECT csTmpRelgLkp
1467:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1468:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
1469:                 ENDIF
1470:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1471:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
1472:                 ENDIF
1473:             ELSE
1474:                 IF !loc_oBusca.this_lSelecionou
1475:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1476:                     loc_oPg2.txt_4c_CodRelGer.Value = 0
1477:                 ENDIF
1478:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1479:                     loc_oPg2.txt_4c_DesRelGer.Value = ""
1480:                 ENDIF
1481:                 ENDIF
1482:             ENDIF
1483: 
1484:             loc_oBusca.Release()
1485:         ENDIF
1486: 
1487:         IF USED("csTmpRelgLkp")
1488:             USE IN csTmpRelgLkp
1489:         ENDIF
1490:     ENDPROC
1491: 
1492:     *===========================================================================
1493:     * AbrirLookupRelGerPorDescricao - Picker de Rel. Gerencial a partir da descricao
1494:     * Mesma tabela SigFiRlg, colunas reordenadas: Descrs primeiro.
1495:     * Equivale ao fwBuscaInt com Descrs+Ordems do GetDesRelGer.Valid original.
1496:     *===========================================================================
1497:     PROCEDURE AbrirLookupRelGerPorDescricao()
1498:         LOCAL loc_oPg2, loc_cImps, loc_oBusca, loc_cSQL, loc_nResult
1499:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1500:         loc_cImps = ""
1501: 
1502:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1503:             RETURN
1504:         ENDIF
1505: 
1506:         IF VARTYPE(loc_oPg2.cbo_4c_Cmb_Imp) = "O"
1507:             loc_cImps = ALLTRIM(loc_oPg2.cbo_4c_Cmb_Imp.Value)
1508:         ENDIF
1509: 
1510:         IF EMPTY(loc_cImps)
1511:             MsgAviso("Selecione a Impressora antes de buscar o Relat" + CHR(243) + ;
1512:                 "rio Gerencial.", "Lookup")
1513:             RETURN
1514:         ENDIF
1515: 
1516:         loc_cSQL    = "SELECT Ordems, Descrs FROM SigFiRlg WHERE Imps = " + ;
1517:             EscaparSQL(loc_cImps)
1518:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "csTmpRelgLkp")
1519: 
1520:         IF loc_nResult <= 0 OR !USED("csTmpRelgLkp") OR RECCOUNT("csTmpRelgLkp") = 0
1521:             IF USED("csTmpRelgLkp")
1522:                 USE IN csTmpRelgLkp
1523:             ENDIF
1524:             MsgAviso("Nenhum Relat" + CHR(243) + "rio Gerencial para a impressora selecionada.", ;
1525:                 "Lookup")
1526:             RETURN
1527:         ENDIF
1528: 
1529:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1530: 
1531:         IF VARTYPE(loc_oBusca) = "O"
1532:             loc_oBusca.this_cCursorDestino = "csTmpRelgLkp"
1533:             loc_oBusca.this_cTitulo        = "Rel. Gerencial"
1534:             loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1535:             loc_oBusca.mAddColuna("Ordems", "", "C" + CHR(243) + "digo")
1536:             loc_oBusca.Show()
1537: 
1538:             IF loc_oBusca.this_lSelecionou AND USED("csTmpRelgLkp")
1539:                 SELECT csTmpRelgLkp
1540:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1541:                     loc_oPg2.txt_4c_CodRelGer.Value = csTmpRelgLkp.Ordems
1542:                 ENDIF
1543:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1544:                     loc_oPg2.txt_4c_DesRelGer.Value = ALLTRIM(csTmpRelgLkp.Descrs)
1545:                 ENDIF
1546:             ELSE
1547:                 IF !loc_oBusca.this_lSelecionou
1548:                 IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1549:                     loc_oPg2.txt_4c_CodRelGer.Value = 0
1550:                 ENDIF
1551:                 IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1552:                     loc_oPg2.txt_4c_DesRelGer.Value = ""
1553:                 ENDIF
1554:                 ENDIF
1555:             ENDIF
1556: 
1557:             loc_oBusca.Release()
1558:         ENDIF
1559: 
1560:         IF USED("csTmpRelgLkp")
1561:             USE IN csTmpRelgLkp
1562:         ENDIF
1563:     ENDPROC
1564: 
1565:     *===========================================================================
1566:     * AtualizarEstadoDesRelGer - Habilita/desabilita txt_4c_DesRelGer conforme
1567:     * o valor de txt_4c_CodRelGer (When do original: Empty(GetCodRelGer.Value))
1568:     *===========================================================================
1569:     PROTECTED PROCEDURE AtualizarEstadoDesRelGer()
1570:         LOCAL loc_oPg2, loc_lCodVazio
1571:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1572:         loc_lCodVazio = .T.
1573: 
1574:         IF VARTYPE(loc_oPg2.txt_4c_CodRelGer) = "O"
1575:             loc_lCodVazio = (loc_oPg2.txt_4c_CodRelGer.Value = 0)
1576:         ENDIF
1577: 
1578:         IF VARTYPE(loc_oPg2.txt_4c_DesRelGer) = "O"
1579:             loc_oPg2.txt_4c_DesRelGer.Enabled = loc_lCodVazio AND ;
1580:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1581:         ENDIF
1582:     ENDPROC
1583: 
1584:     *===========================================================================
1585:     * Destroy - Libera recursos do formulario
1586:     *===========================================================================
1587:     PROCEDURE Destroy()
1588:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1589:             THIS.this_oBusinessObject = .NULL.
1590:         ENDIF
1591:         IF USED("crSigFiNal")
1592:             USE IN crSigFiNal
1593:         ENDIF
1594:         IF USED("csTmpRelgBusca")
1595:             USE IN csTmpRelgBusca
1596:         ENDIF
1597:         IF USED("csTmpRelgLkp")
1598:             USE IN csTmpRelgLkp
1599:         ENDIF
1600:         DODEFAULT()
1601:     ENDPROC
1602: 
1603: ENDDEFINE


### BO (C:\4c\projeto\app\classes\fnlBO.prg):
*==============================================================================
* fnlBO.prg - Business Object para Tabela de Finalizacoes (SigFiNal)
* Herda de: BusinessBase
* Tabela: SigFiNal (PK composta: imps + ordems)
*==============================================================================

DEFINE CLASS fnlBO AS BusinessBase

    *-- Propriedades da tabela SigFiNal
    this_cImps       = ""   && char(20) - Impressora (PK parte 1)
    this_nOrdems     = 0    && numeric(2,0) - Ordem finalizadora
    this_cDescrs     = ""   && char(40) - Descricao
    this_nCodFinzs   = 0    && numeric(2,0) - Codigo finalizador
    this_nFixos      = 2    && numeric(1,0) - Fixo (1=Sim, 2=Nao)
    this_cVincs      = "N"  && char(1) - Vinculado (S/N)
    this_nRelGers    = 0    && numeric(1,0) - FK SigFiRlg.ordems
    this_cDescs      = ""   && alias SigFiRlg.descrs (nao coluna real - lookup display)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiNal"
        THIS.this_cCampoChave = "imps"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cImps) + STR(THIS.this_nOrdems, 2, 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cImps       = TratarNulo(imps,       "C")
            THIS.this_nOrdems     = TratarNulo(ordems,     "N")
            THIS.this_cDescrs     = TratarNulo(descrs,     "C")
            THIS.this_nCodFinzs   = TratarNulo(ncodfinzs,  "N")
            THIS.this_nFixos      = TratarNulo(nfixos,     "N")
            THIS.this_cVincs      = TratarNulo(vincs,      "C")
            THIS.this_nRelGers    = TratarNulo(nrelgers,   "N")
            *-- descs vem do JOIN; se coluna existir no cursor, carregar
            IF TYPE("descs") != "U"
                THIS.this_cDescs  = TratarNulo(descs,      "C")
            ELSE
                THIS.this_cDescs  = ""
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNal")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar finalizacoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs," + ;
                       " a.nfixos, a.ncodfinzs, a.vincs, a.nrelgers," + ;
                       " b.descrs AS descs" + ;
                       " FROM SigFiNal a" + ;
                       " LEFT JOIN SigFiRlg b ON b.ordems = a.nrelgers AND b.imps = a.imps" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFnl")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CarregaFnl") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFnl")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_CarregaFnl")
            USE IN cursor_4c_CarregaFnl
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarRelGerencial - Busca registros de SigFiRlg para lookup de Rel. Gerencial
    *--------------------------------------------------------------------------
    PROCEDURE BuscarRelGerencial(par_cImps, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(par_cCursorDestino)
            par_cCursorDestino = "cursor_4c_RelGer"
        ENDIF

        TRY
            loc_cSQL = "SELECT ordems, descrs FROM SigFiRlg" + ;
                       " WHERE imps = " + EscaparSQL(par_cImps) + ;
                       " ORDER BY ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Rel. Gerencial:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNal" + ;
                       " (imps, ordems, descrs, nfixos, ncodfinzs, vincs, nrelgers)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cImps) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       EscaparSQL(THIS.this_cVincs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNal SET" + ;
                       " imps = "      + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = "    + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " descrs = "    + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = "    + FormatarNumeroSQL(THIS.this_nFixos) + ", " + ;
                       " ncodfinzs = " + FormatarNumeroSQL(THIS.this_nCodFinzs) + ", " + ;
                       " vincs = "     + EscaparSQL(THIS.this_cVincs) + ", " + ;
                       " nrelgers = "  + FormatarNumeroSQL(THIS.this_nRelGers) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir finalizacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarOrdemDuplicada - Verifica se Imps+Ordems ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarOrdemDuplicada(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldOrd")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldOrd") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldOrd")
            USE IN cursor_4c_VldOrd
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigoDuplicado - Verifica se Imps+ncodfinzs ja existe (INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigoDuplicado(par_cImps, par_nCodFinzs)
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigFiNal WHERE imps = " + ;
                       EscaparSQL(par_cImps) + ;
                       " AND ncodfinzs = " + FormatarNumeroSQL(par_nCodFinzs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VldCod")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_VldCod") > 0
                loc_lDuplicado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_VldCod")
            USE IN cursor_4c_VldCod
        ENDIF

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarProximoNcodFinzs - Proximo codigo finalizador disponivel por impressora
    * Substitui fGerUniqueKey('SigFiNal') do legado
    *--------------------------------------------------------------------------
    PROCEDURE GerarProximoNcodFinzs(par_cImps)
        LOCAL loc_nResultado, loc_nProximo
        loc_nProximo = 1

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT ISNULL(MAX(ncodfinzs), 0) + 1 AS Proximo FROM SigFiNal" + ;
                " WHERE imps = " + EscaparSQL(par_cImps), ;
                "cursor_4c_ProxCod")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
                SELECT cursor_4c_ProxCod
                loc_nProximo = cursor_4c_ProxCod.Proximo
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao gerar pr" + CHR(243) + "ximo c" + CHR(243) + "digo:" + ;
                CHR(13) + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ProxCod")
            USE IN cursor_4c_ProxCod
        ENDIF

        RETURN loc_nProximo
    ENDPROC

ENDDEFINE

