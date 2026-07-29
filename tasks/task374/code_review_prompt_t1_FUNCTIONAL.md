# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescGrupo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescGrupo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarClasse' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarClasse(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescClasse' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescClasse(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupGrupo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupGrupoDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupClasse()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.AbrirLookupClasseDesc()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CalcularAltSubtot()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CalcularProximaOrdem()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarCampos()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2456 linhas total):

*-- Linhas 35 a 174:
35:     * INICIALIZACAO
36:     *==========================================================================
37: 
38:     PROCEDURE Init(par_cBalancos, par_nMapas)
39:         LOCAL loc_lSucesso
40:         loc_lSucesso = .F.
41: 
42:         TRY
43:             IF PCOUNT() >= 1 AND VARTYPE(par_cBalancos) = "C"
44:                 THIS.this_cBalancos = ALLTRIM(par_cBalancos)
45:                 THIS.Caption = "Itens : " + ALLTRIM(par_cBalancos)
46:             ENDIF
47:             IF PCOUNT() >= 2 AND VARTYPE(par_nMapas) = "N"
48:                 THIS.this_nMapas = par_nMapas
49:             ENDIF
50: 
51:             loc_lSucesso = DODEFAULT()
52:         CATCH TO loException
53:             MostrarErro("Erro ao inicializar FormCmr:" + CHR(13) + ;
54:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
55:                         loException.Message, "Erro")
56:             loc_lSucesso = .F.
57:         ENDTRY
58: 
59:         RETURN loc_lSucesso
60:     ENDPROC
61: 
62:     PROTECTED PROCEDURE InicializarForm()
63:         LOCAL loc_lSucesso
64:         loc_lSucesso = .F.
65: 
66:         TRY
67:             THIS.this_oBusinessObject = CREATEOBJECT("CmrBO")
68: 
69:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
70:                 MostrarErro("Erro ao criar Business Object CmrBO", "Erro Cr" + CHR(237) + "tico")
71:             ELSE
72:                 THIS.this_oBusinessObject.this_cBalancos = THIS.this_cBalancos
73: 
74:                 THIS.ConfigurarPageFrame()
75:                 THIS.ConfigurarPaginaLista()
76:                 THIS.ConfigurarPaginaDados()
77: 
78:                 IF TYPE("THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo") = "O"
79:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 ENDIF
82: 
83:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
84:                     THIS.CarregarLista()
85:                 ENDIF
86: 
87:                 THIS.pgf_4c_Paginas.Visible    = .T.
88:                 THIS.pgf_4c_Paginas.ActivePage = 1
89:                 THIS.this_cModoAtual           = "LISTA"
90:                 loc_lSucesso = .T.
91:             ENDIF
92: 
93:         CATCH TO loException
94:             MostrarErro("Erro ao inicializar FormCmr:" + CHR(13) + ;
95:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
96:                         loException.Message, "Erro")
97:             loc_lSucesso = .F.
98:         ENDTRY
99: 
100:         RETURN loc_lSucesso
101:     ENDPROC
102: 
103:     *==========================================================================
104:     * CONFIGURACAO PAGEFRAME
105:     *==========================================================================
106: 
107:     PROTECTED PROCEDURE ConfigurarPageFrame()
108:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
109: 
110:         WITH THIS.pgf_4c_Paginas
111:             .Top       = -29
112:             .Left      = 0
113:             .Width     = 1003
114:             .Height    = 629
115:             .PageCount = 2
116:             .Tabs      = .F.
117:             .Visible   = .T.
118: 
119:             .Page1.Caption   = "Lista"
120:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:             .Page1.BackColor = RGB(255, 255, 255)
122: 
123:             .Page2.Caption   = "Dados"
124:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:             .Page2.BackColor = RGB(255, 255, 255)
126:         ENDWITH
127:     ENDPROC
128: 
129:     *==========================================================================
130:     * CONFIGURACAO PAGE1 - LISTA
131:     * Compensacao +29: Grupo_op.Top=-1 -> 28; cntSombra.Top=2 -> 31
132:     *==========================================================================
133: 
134:     PROTECTED PROCEDURE ConfigurarPaginaLista()
135:         LOCAL loc_oPagina
136:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
137: 
138:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
139:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
140: 
141:         *----------------------------------------------------------------------
142:         * Container Cabecalho (cntSombra no legado, Top=2+29=31)
143:         *----------------------------------------------------------------------
144:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
145:         WITH loc_oPagina.cnt_4c_Cabecalho
146:             .Top         = 31
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153:         ENDWITH
154: 
155:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
156:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
157:             .Top       = 15
158:             .Left      = 10
159:             .Width     = THIS.Width - 10
160:             .Height    = 40
161:             .AutoSize  = .F.
162:             .FontName  = "Tahoma"
163:             .FontSize  = 16
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .Caption   = THIS.Caption
168:             .Visible   = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
172:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
173:             .Top       = 18
174:             .Left      = 10

*-- Linhas 412 a 472:
412:         ENDWITH
413: 
414:         *----------------------------------------------------------------------
415:         * BINDEVENTs - botoes Page1 (metodos PUBLIC para BINDEVENT)
416:         *----------------------------------------------------------------------
417:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
418:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
419:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
420:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
421:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
422:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
423: 
424:         THIS.TornarControlesVisiveis(loc_oPagina)
425:     ENDPROC
426: 
427:     *==========================================================================
428:     * CONFIGURACAO PAGE2 - DADOS
429:     * Todos os controles com compensacao +29 de PageFrame.Top=-29
430:     *==========================================================================
431: 
432:     PROTECTED PROCEDURE ConfigurarPaginaDados()
433:         LOCAL loc_oPagina
434:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
435: 
436:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
437:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
438: 
439:         *----------------------------------------------------------------------
440:         * Container BotoesAcao (Grupo_Salva: Top=4+29=33, Left=842)
441:         *----------------------------------------------------------------------
442:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
443:         WITH loc_oPagina.cnt_4c_BotoesAcao
444:             .Top         = 33
445:             .Left        = 842
446:             .Width       = 160
447:             .Height      = 85
448:             .BackStyle = 1
449:             .BackColor = RGB(255, 255, 255)
450:             .Visible     = .T.
451:         ENDWITH
452: 
453:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
454:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
455:             .Caption         = "Confirmar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
457:             .PicturePosition = 13
458:             .Top             = 5
459:             .Left            = 5
460:             .Width           = 75
461:             .Height          = 75
462:             .FontName        = "Comic Sans MS"
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .FontSize        = 8
466:             .ForeColor       = RGB(90, 90, 90)
467:             .BackColor       = RGB(255, 255, 255)
468:             .Themes          = .F.
469:             .SpecialEffect   = 0
470:             .MousePointer    = 15
471:             .WordWrap        = .T.
472:             .Visible         = .T.

*-- Linhas 537 a 580:
537:         * Button 3: "Classe" (Left=59, Value=3=Classe)
538:         * Nota: Buttons visualmente em ordem Grupo/Classe/SubTotal (Left: 5/59/120)
539:         *----------------------------------------------------------------------
540:         loc_oPagina.AddObject("obj_4c_OptTpregs", "OptionGroup")
541:         WITH loc_oPagina.obj_4c_OptTpregs
542:             .ButtonCount = 3
543:             .BackStyle   = 0
544:             .BorderStyle = 0
545:             .Value       = 1
546:             .Top         = 204
547:             .Left        = 304
548:             .Width       = 185
549:             .Height      = 26
550:             .Visible     = .T.
551:         ENDWITH
552:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(1)
553:             .Caption   = "\<Grupo"
554:             .BackStyle = 0
555:             .Left      = 5
556:             .Top       = 5
557:             .Width     = 47
558:             .AutoSize  = .T.
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(90, 90, 90)
562:         ENDWITH
563:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(2)
564:             .Caption   = "\<SubTotal"
565:             .BackStyle = 0
566:             .Left      = 120
567:             .Top       = 6
568:             .AutoSize  = .T.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)
572:         ENDWITH
573:         WITH loc_oPagina.obj_4c_OptTpregs.Buttons(3)
574:             .Caption   = "Classe"
575:             .BackStyle = 0
576:             .Left      = 59
577:             .Top       = 5
578:             .Width     = 49
579:             .AutoSize  = .T.
580:             .FontName  = "Tahoma"

*-- Linhas 781 a 824:
781:         ENDWITH
782: 
783:         *-- opt_analiticos (Top=308+29=337)
784:         loc_oPagina.AddObject("obj_4c_Opt_analiticos", "OptionGroup")
785:         WITH loc_oPagina.obj_4c_Opt_analiticos
786:             .ButtonCount = 2
787:             .BackStyle   = 0
788:             .BorderStyle = 0
789:             .Value       = 1
790:             .Top         = 337
791:             .Left        = 304
792:             .Width       = 97
793:             .Height      = 25
794:             .Visible     = .T.
795:         ENDWITH
796:         WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(1)
797:             .Caption   = "Sim"
798:             .BackStyle = 0
799:             .Left      = 5
800:             .Top       = 5
801:             .Width     = 34
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .ForeColor = RGB(90, 90, 90)
806:         ENDWITH
807:         WITH loc_oPagina.obj_4c_Opt_analiticos.Buttons(2)
808:             .Caption   = "N" + CHR(227) + "o"
809:             .BackStyle = 0
810:             .Left      = 51
811:             .Top       = 5
812:             .AutoSize  = .T.
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .ForeColor = RGB(90, 90, 90)
816:         ENDWITH
817: 
818:         *-- Say5: Contra Partida (Top=335+29=364)
819:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
820:         WITH loc_oPagina.lbl_4c_Label5
821:             .Caption   = "Contra Partida :"
822:             .Top       = 364
823:             .Left      = 221
824:             .Width     = 79

*-- Linhas 832 a 875:
832:         ENDWITH
833: 
834:         *-- Opt_CPartida (Top=330+29=359, default Value=2=Nao)
835:         loc_oPagina.AddObject("obj_4c_Opt_CPartida", "OptionGroup")
836:         WITH loc_oPagina.obj_4c_Opt_CPartida
837:             .ButtonCount = 2
838:             .BackStyle   = 0
839:             .BorderStyle = 0
840:             .Value       = 2
841:             .Top         = 359
842:             .Left        = 304
843:             .Width       = 97
844:             .Height      = 25
845:             .Visible     = .T.
846:         ENDWITH
847:         WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(1)
848:             .Caption   = "Sim"
849:             .BackStyle = 0
850:             .Left      = 5
851:             .Top       = 5
852:             .Width     = 34
853:             .AutoSize  = .T.
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .ForeColor = RGB(90, 90, 90)
857:         ENDWITH
858:         WITH loc_oPagina.obj_4c_Opt_CPartida.Buttons(2)
859:             .Caption   = "N" + CHR(227) + "o"
860:             .BackStyle = 0
861:             .Left      = 51
862:             .Top       = 5
863:             .AutoSize  = .T.
864:             .FontName  = "Tahoma"
865:             .FontSize  = 8
866:             .ForeColor = RGB(90, 90, 90)
867:         ENDWITH
868: 
869:         *-- Say7: SubTotal 100% (Top=358+29=387)
870:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
871:         WITH loc_oPagina.lbl_4c_Label7
872:             .Caption   = "SubTotal 100% :"
873:             .Top       = 387
874:             .Left      = 217
875:             .Width     = 83

*-- Linhas 883 a 926:
883:         ENDWITH
884: 
885:         *-- opt_subtot100 (Top=354+29=383, default Value=2=Nao)
886:         loc_oPagina.AddObject("obj_4c_Opt_subtot100", "OptionGroup")
887:         WITH loc_oPagina.obj_4c_Opt_subtot100
888:             .ButtonCount = 2
889:             .BackStyle   = 0
890:             .BorderStyle = 0
891:             .Value       = 2
892:             .Top         = 383
893:             .Left        = 304
894:             .Width       = 97
895:             .Height      = 25
896:             .Visible     = .T.
897:         ENDWITH
898:         WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(1)
899:             .Caption   = "Sim"
900:             .BackStyle = 0
901:             .Left      = 5
902:             .Top       = 5
903:             .Width     = 34
904:             .AutoSize  = .T.
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .ForeColor = RGB(90, 90, 90)
908:         ENDWITH
909:         WITH loc_oPagina.obj_4c_Opt_subtot100.Buttons(2)
910:             .Caption   = "N" + CHR(227) + "o"
911:             .BackStyle = 0
912:             .Left      = 51
913:             .Top       = 5
914:             .AutoSize  = .T.
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(90, 90, 90)
918:         ENDWITH
919: 
920:         *-- Say2: Fator (Top=383+29=412)
921:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
922:         WITH loc_oPagina.lbl_4c_Label2
923:             .Caption   = "Fator :"
924:             .Top       = 412
925:             .Left      = 265
926:             .Height    = 17

*-- Linhas 1024 a 1067:
1024: 
1025:         *-- optTpDatas (Top=431+29=460)
1026:         *-- Button 1: Emissao(1), Button 2: Lancamento(2), Button 3: Vencimento(3=default), Button 4: Baixa(4)
1027:         loc_oPagina.AddObject("obj_4c_OptTpDatas", "OptionGroup")
1028:         WITH loc_oPagina.obj_4c_OptTpDatas
1029:             .ButtonCount = 4
1030:             .BackStyle   = 0
1031:             .BorderStyle = 0
1032:             .Value       = 3
1033:             .Top         = 460
1034:             .Left        = 298
1035:             .Width       = 320
1036:             .Height      = 25
1037:             .AutoSize    = .T.
1038:             .Visible     = .T.
1039:         ENDWITH
1040:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(1)
1041:             .Caption   = "Emiss" + CHR(227) + "o"
1042:             .BackStyle = 0
1043:             .Left      = 5
1044:             .Top       = 5
1045:             .Width     = 56
1046:             .AutoSize  = .T.
1047:             .FontName  = "Tahoma"
1048:             .FontSize  = 8
1049:             .ForeColor = RGB(90, 90, 90)
1050:         ENDWITH
1051:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(2)
1052:             .Caption   = "Lan" + CHR(231) + "amento"
1053:             .BackStyle = 0
1054:             .Left      = 78
1055:             .Top       = 5
1056:             .Width     = 76
1057:             .AutoSize  = .T.
1058:             .FontName  = "Tahoma"
1059:             .FontSize  = 8
1060:             .ForeColor = RGB(90, 90, 90)
1061:         ENDWITH
1062:         WITH loc_oPagina.obj_4c_OptTpDatas.Buttons(3)
1063:             .Caption   = "Vencimento"
1064:             .BackStyle = 0
1065:             .Left      = 173
1066:             .Top       = 5
1067:             .Width     = 73

*-- Linhas 1083 a 1155:
1083:         ENDWITH
1084: 
1085:         *----------------------------------------------------------------------
1086:         * BINDEVENTs Page2
1087:         *----------------------------------------------------------------------
1088:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1089:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1090:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,       "Click", THIS, "BtnEncerrarClick")
1091:         BINDEVENT(loc_oPagina.obj_4c_OptTpregs,     "InteractiveChange", THIS, "OptTpregsChanged")
1092:         BINDEVENT(loc_oPagina.txt_4c__cd_grupos,    "KeyPress",        THIS, "ValidarGrupo")
1093:         BINDEVENT(loc_oPagina.txt_4c__ds_grupos,    "KeyPress",        THIS, "ValidarDescGrupo")
1094:         BINDEVENT(loc_oPagina.txt_4c_Classe,        "KeyPress",        THIS, "ValidarClasse")
1095:         BINDEVENT(loc_oPagina.txt_4c_Dclasse,       "KeyPress",        THIS, "ValidarDescClasse")
1096:         BINDEVENT(loc_oPagina.txt_4c_Titulo,        "LostFocus",        THIS, "ValidarTitulo")
1097: 
1098:         *-- F4/DblClick para campos de lookup (equivalente ao evento Valid+F4 do fwget legado)
1099:         BINDEVENT(loc_oPagina.txt_4c__cd_grupos, "KeyPress", THIS, "CdGruposKeyPress")
1100:         BINDEVENT(loc_oPagina.txt_4c__cd_grupos, "DblClick", THIS, "AbrirLookupGrupo")
1101:         BINDEVENT(loc_oPagina.txt_4c__ds_grupos, "KeyPress", THIS, "DsGruposKeyPress")
1102:         BINDEVENT(loc_oPagina.txt_4c__ds_grupos, "DblClick", THIS, "AbrirLookupGrupoDesc")
1103:         BINDEVENT(loc_oPagina.txt_4c_Classe,     "KeyPress", THIS, "ClasseKeyPress")
1104:         BINDEVENT(loc_oPagina.txt_4c_Classe,     "DblClick", THIS, "AbrirLookupClasse")
1105:         BINDEVENT(loc_oPagina.txt_4c_Dclasse,    "KeyPress", THIS, "DclasseKeyPress")
1106:         BINDEVENT(loc_oPagina.txt_4c_Dclasse,    "DblClick", THIS, "AbrirLookupClasseDesc")
1107: 
1108:         THIS.TornarControlesVisiveis(loc_oPagina)
1109:     ENDPROC
1110: 
1111:     *==========================================================================
1112:     * CARREGAR LISTA - preenche o grid com dados do cursor
1113:     *==========================================================================
1114: 
1115:     PROCEDURE CarregarLista()
1116:         LOCAL loc_lResultado, loc_oGrid
1117:         loc_lResultado = .F.
1118: 
1119:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1120:             RETURN .T.
1121:         ENDIF
1122: 
1123:         TRY
1124:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1125:                 IF THIS.this_oBusinessObject.Buscar("")
1126:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1127: 
1128:                     *-- RecordSource FORA do WITH (garante criacao das colunas)
1129:                     loc_oGrid.ColumnCount = 9
1130:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1131: 
1132:                     *-- Re-definir ControlSource e Headers APOS RecordSource
1133:                     WITH loc_oGrid
1134:                         *-- Column1: Classe (mostra Classes se Grupos vazio, senao branco)
1135:                         .Column1.ControlSource  = "iif(EMPTY(cursor_4c_Dados.Grupos),cursor_4c_Dados.Classes,'')"
1136:                         .Column1.Header1.Caption = "Classe"
1137:                         .Column1.Width  = 80
1138:                         .Column1.Alignment = 0
1139: 
1140:                         *-- Column2: Nivel
1141:                         .Column2.ControlSource  = "cursor_4c_Dados.Nivels"
1142:                         .Column2.Header1.Caption = "N" + CHR(237) + "vel"
1143:                         .Column2.Width  = 33
1144:                         .Column2.Alignment = 1
1145: 
1146:                         *-- Column3: Operacao (+/-) com indicador visual
1147:                         .Column3.ControlSource  = "iif(cursor_4c_Dados.Operacaos='-','[-]','[+]')"
1148:                         .Column3.Header1.Caption = "Oper"
1149:                         .Column3.Width  = 40
1150:                         .Column3.Alignment = 1
1151: 
1152:                         *-- Column4: Grupo
1153:                         .Column4.ControlSource  = "cursor_4c_Dados.Grupos"
1154:                         .Column4.Header1.Caption = "Grupo"
1155:                         .Column4.Width  = 80

*-- Linhas 1203 a 1368:
1203:     * ALTERNAR PAGINA
1204:     *==========================================================================
1205: 
1206:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1207:         LOCAL loc_lResultado
1208:         loc_lResultado = .F.
1209: 
1210:         TRY
1211:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1212:                 loc_lResultado = .F.
1213:             ELSE
1214:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1215: 
1216:                 IF par_nPagina = 1
1217:                     THIS.this_cModoAtual = "LISTA"
1218:                     THIS.CarregarLista()
1219:                 ENDIF
1220: 
1221:                 loc_lResultado = .T.
1222:             ENDIF
1223:         CATCH TO loException
1224:             MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loException.Message, "Erro")
1225:             loc_lResultado = .F.
1226:         ENDTRY
1227: 
1228:         RETURN loc_lResultado
1229:     ENDPROC
1230: 
1231:     *==========================================================================
1232:     * HABILITAR/DESABILITAR CAMPOS
1233:     *==========================================================================
1234: 
1235:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1236:         LOCAL loc_oPg2
1237:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1238: 
1239:         loc_oPg2.obj_4c_OptTpregs.Enabled                   = par_lHabilitar
1240:         loc_oPg2.txt_4c_Descgrps.Enabled                    = par_lHabilitar
1241:         loc_oPg2.txt_4c_Ordems.Enabled                      = par_lHabilitar
1242:         loc_oPg2.txt_4c__cd_grupos.Enabled                  = par_lHabilitar
1243:         loc_oPg2.txt_4c__ds_grupos.Enabled                  = par_lHabilitar AND .F.
1244:         loc_oPg2.txt_4c_Classe.Enabled                      = par_lHabilitar
1245:         loc_oPg2.txt_4c_Dclasse.Enabled                     = par_lHabilitar AND .F.
1246:         loc_oPg2.cbo_4c_Cmb_operacaos.Enabled               = par_lHabilitar
1247:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(1).Enabled   = par_lHabilitar
1248:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(2).Enabled   = par_lHabilitar
1249:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(1).Enabled     = par_lHabilitar
1250:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(2).Enabled     = par_lHabilitar
1251:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(1).Enabled    = par_lHabilitar
1252:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(2).Enabled    = par_lHabilitar
1253:         loc_oPg2.txt_4c_Fator.Enabled                       = par_lHabilitar
1254:         loc_oPg2.txt_4c_Titulo.Enabled                      = par_lHabilitar
1255:         loc_oPg2.obj_4c_OptTpDatas.Buttons(1).Enabled       = par_lHabilitar
1256:         loc_oPg2.obj_4c_OptTpDatas.Buttons(2).Enabled       = par_lHabilitar
1257:         loc_oPg2.obj_4c_OptTpDatas.Buttons(3).Enabled       = par_lHabilitar
1258:         loc_oPg2.obj_4c_OptTpDatas.Buttons(4).Enabled       = par_lHabilitar
1259: 
1260:         *-- Confirmar/Cancelar: visiveis somente em modo edicao
1261:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1262:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1263: 
1264:         *-- Refinar habilitacao por tipo (Tpregs) quando habilitando
1265:         IF par_lHabilitar
1266:             THIS.OptTpregsChanged()
1267:         ENDIF
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * LIMPAR CAMPOS
1272:     *==========================================================================
1273: 
1274:     PROTECTED PROCEDURE LimparCampos()
1275:         LOCAL loc_oPg2
1276:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1277: 
1278:         loc_oPg2.obj_4c_OptTpregs.Value             = 1
1279:         loc_oPg2.txt_4c_Descgrps.Value              = ""
1280:         loc_oPg2.txt_4c_Ordems.Value                = 0
1281:         loc_oPg2.txt_4c__cd_grupos.Value            = ""
1282:         loc_oPg2.txt_4c__ds_grupos.Value            = ""
1283:         loc_oPg2.txt_4c_Classe.Value                = ""
1284:         loc_oPg2.txt_4c_Dclasse.Value               = ""
1285:         loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex     = 1
1286:         loc_oPg2.obj_4c_Opt_analiticos.Value        = 1
1287:         loc_oPg2.obj_4c_Opt_CPartida.Value          = 2
1288:         loc_oPg2.obj_4c_Opt_subtot100.Value         = 2
1289:         loc_oPg2.txt_4c_Fator.Value                 = 100
1290:         loc_oPg2.obj_4c_OptTpDatas.Value            = 3
1291:         IF THIS.this_nMapas = 2
1292:             loc_oPg2.txt_4c_Titulo.Value            = ""
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *==========================================================================
1297:     * FORM PARA BO (transfere campos do formulario para o Business Object)
1298:     *==========================================================================
1299: 
1300:     PROTECTED PROCEDURE FormParaBO()
1301:         LOCAL loc_oPg2, loc_nListIdx
1302:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1303: 
1304:         THIS.this_oBusinessObject.this_nTpregs    = loc_oPg2.obj_4c_OptTpregs.Value
1305:         THIS.this_oBusinessObject.this_cDescGrps  = ALLTRIM(loc_oPg2.txt_4c_Descgrps.Value)
1306:         THIS.this_oBusinessObject.this_nOrdems    = loc_oPg2.txt_4c_Ordems.Value
1307:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
1308:         THIS.this_oBusinessObject.this_cClasses   = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)
1309:         THIS.this_oBusinessObject.this_nAnaliticos = loc_oPg2.obj_4c_Opt_analiticos.Value
1310:         THIS.this_oBusinessObject.this_nCpartidas  = loc_oPg2.obj_4c_Opt_CPartida.Value
1311:         THIS.this_oBusinessObject.this_nSubtot100s = loc_oPg2.obj_4c_Opt_subtot100.Value
1312:         THIS.this_oBusinessObject.this_nFators    = loc_oPg2.txt_4c_Fator.Value
1313:         THIS.this_oBusinessObject.this_nTpDatas   = loc_oPg2.obj_4c_OptTpDatas.Value
1314:         THIS.this_oBusinessObject.this_cBalancos  = THIS.this_cBalancos
1315: 
1316:         IF THIS.this_nMapas = 2
1317:             THIS.this_oBusinessObject.this_cTitulos = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
1318:         ENDIF
1319: 
1320:         loc_nListIdx = loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex
1321:         THIS.this_oBusinessObject.this_cOperacaos = IIF(loc_nListIdx = 1, "+", "-")
1322:     ENDPROC
1323: 
1324:     *==========================================================================
1325:     * BO PARA FORM (carrega propriedades do BO nos campos do formulario)
1326:     *==========================================================================
1327: 
1328:     PROTECTED PROCEDURE BOParaForm()
1329:         LOCAL loc_oPg2, loc_oBO, loc_cSQL, loc_nResult
1330:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1331:         loc_oBO  = THIS.this_oBusinessObject
1332: 
1333:         loc_oPg2.obj_4c_OptTpregs.Value             = loc_oBO.this_nTpregs
1334:         loc_oPg2.txt_4c_Descgrps.Value              = ALLTRIM(loc_oBO.this_cDescGrps)
1335:         loc_oPg2.txt_4c_Ordems.Value                = loc_oBO.this_nOrdems
1336:         loc_oPg2.txt_4c__cd_grupos.Value            = ALLTRIM(loc_oBO.this_cGrupos)
1337:         loc_oPg2.txt_4c_Classe.Value                = ALLTRIM(loc_oBO.this_cClasses)
1338:         loc_oPg2.obj_4c_Opt_analiticos.Value        = IIF(loc_oBO.this_nAnaliticos > 0, loc_oBO.this_nAnaliticos, 1)
1339:         loc_oPg2.obj_4c_Opt_CPartida.Value          = IIF(loc_oBO.this_nCpartidas  > 0, loc_oBO.this_nCpartidas,  2)
1340:         loc_oPg2.obj_4c_Opt_subtot100.Value         = IIF(loc_oBO.this_nSubtot100s > 0, loc_oBO.this_nSubtot100s, 2)
1341:         loc_oPg2.txt_4c_Fator.Value                 = IIF(loc_oBO.this_nFators > 0, loc_oBO.this_nFators, 100)
1342:         loc_oPg2.obj_4c_OptTpDatas.Value            = IIF(loc_oBO.this_nTpDatas   > 0, loc_oBO.this_nTpDatas,   3)
1343:         loc_oPg2.cbo_4c_Cmb_operacaos.ListIndex    = IIF(loc_oBO.this_cOperacaos = "+", 1, 2)
1344: 
1345:         IF THIS.this_nMapas = 2
1346:             loc_oPg2.txt_4c_Titulo.Value = ALLTRIM(loc_oBO.this_cTitulos)
1347:         ENDIF
1348: 
1349:         *-- Popular descricao do Grupo (get_ds_grupos) via SQL
1350:         IF NOT EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
1351:             TRY
1352:                 loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr WHERE Codigos = " + ;
1353:                            EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos))
1354:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrDesc")
1355:                 IF loc_nResult >= 0 AND USED("cursor_4c_GcrDesc") AND RECCOUNT("cursor_4c_GcrDesc") > 0
1356:                     loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrDesc.Descrs)
1357:                 ENDIF
1358:                 IF USED("cursor_4c_GcrDesc")
1359:                     USE IN cursor_4c_GcrDesc
1360:                 ENDIF
1361:             CATCH TO loException
1362:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
1363:                         loException.Message, "Erro")
1364:             ENDTRY
1365:         ELSE
1366:             loc_oPg2.txt_4c__ds_grupos.Value = ""
1367:         ENDIF
1368: 

*-- Linhas 1390 a 1789:
1390:     ENDPROC
1391: 
1392:     *==========================================================================
1393:     * HANDLER: TIPO DE REGISTRO MUDOU (optTpregs InteractiveChange)
1394:     * Habilita/desabilita campos conforme o tipo selecionado
1395:     *==========================================================================
1396: 
1397:     PROCEDURE OptTpregsChanged()
1398:         LOCAL loc_oPg2, loc_nTpregs, loc_lEditar
1399:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1400:         loc_nTpregs = loc_oPg2.obj_4c_OptTpregs.Value
1401:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1402: 
1403:         *-- Campos por tipo:
1404:         *-- Tpregs=1 (Grupo): cd_grupos/ds_grupos habilitados
1405:         *-- Tpregs=2 (SubTotal): Descgrps habilitado
1406:         *-- Tpregs=3 (Classe): Classe/Dclasse habilitados
1407:         loc_oPg2.txt_4c_Descgrps.Enabled    = (loc_nTpregs = 2) AND loc_lEditar
1408:         loc_oPg2.lbl_4c_Label1.Enabled      = (loc_nTpregs = 2)
1409:         loc_oPg2.txt_4c__cd_grupos.Enabled  = (loc_nTpregs = 1) AND loc_lEditar
1410:         loc_oPg2.lbl_4c_Lbl_grupos.Enabled  = (loc_nTpregs = 1)
1411:         loc_oPg2.txt_4c_Classe.Enabled      = (loc_nTpregs = 3) AND loc_lEditar
1412:         loc_oPg2.lbl_4c_Label4.Enabled      = (loc_nTpregs = 3)
1413: 
1414:         *-- cmb_operacaos: somente Tpregs=1 ou 3
1415:         loc_oPg2.cbo_4c_Cmb_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3) AND loc_lEditar
1416:         loc_oPg2.lbl_4c_Lbl_operacaos.Enabled = INLIST(loc_nTpregs, 1, 3)
1417: 
1418:         *-- opt_analiticos: somente Tpregs=1
1419:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(1).Enabled = (loc_nTpregs = 1) AND loc_lEditar
1420:         loc_oPg2.obj_4c_Opt_analiticos.Buttons(2).Enabled = (loc_nTpregs = 1) AND loc_lEditar
1421:         loc_oPg2.lbl_4c_Lbl_analitico.Enabled             = (loc_nTpregs = 1)
1422: 
1423:         *-- Opt_CPartida: somente Tpregs=1 e Analiticos=1
1424:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(1).Enabled = ;
1425:             (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
1426:         loc_oPg2.obj_4c_Opt_CPartida.Buttons(2).Enabled = ;
1427:             (loc_nTpregs = 1) AND (loc_oPg2.obj_4c_Opt_analiticos.Value = 1) AND loc_lEditar
1428:         loc_oPg2.lbl_4c_Label5.Enabled = (loc_nTpregs = 1)
1429: 
1430:         *-- opt_subtot100: somente Tpregs=2 e llaltsubtot
1431:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(1).Enabled = ;
1432:             (loc_nTpregs = 2) AND loc_lEditar AND THIS.this_lAltSubtot
1433:         loc_oPg2.obj_4c_Opt_subtot100.Buttons(2).Enabled = (loc_nTpregs = 2) AND loc_lEditar
1434:         loc_oPg2.lbl_4c_Label7.Enabled = (loc_nTpregs = 2)
1435:     ENDPROC
1436: 
1437:     *==========================================================================
1438:     * VALIDACAO: GRUPO (LostFocus de txt_4c__cd_grupos)
1439:     * Busca em SigCdGcr, popula descricao ou abre picker
1440:     *==========================================================================
1441: 
1442:     PROCEDURE ValidarGrupo(par_nKeyCode, par_nShiftAltCtrl)
1443:         LOCAL loc_oPg2, loc_cGrupo, loc_cSQL, loc_nResult, loc_oBusca
1444:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1445:         loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
1446: 
1447:         IF EMPTY(loc_cGrupo)
1448:             loc_oPg2.txt_4c__ds_grupos.Value = ""
1449:             RETURN
1450:         ENDIF
1451: 
1452:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1453:             RETURN
1454:         ENDIF
1455: 
1456:         TRY
1457:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1458:                        EscaparSQL(loc_cGrupo)
1459:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1460:             IF loc_nResult >= 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1461:                 loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrVal.Descrs)
1462:             ELSE
1463:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1464:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1465:                     "Grupos de Conta Corrente")
1466: 
1467:                 IF VARTYPE(loc_oBusca) = "O"
1468:                     IF NOT loc_oBusca.this_lAchouRegistro
1469:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1470:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1471:                         loc_oBusca.Show()
1472:                     ENDIF
1473: 
1474:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1475:                         loc_oPg2.txt_4c__cd_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1476:                         loc_oPg2.txt_4c__ds_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1477:                     ELSE
1478:                         loc_oPg2.txt_4c__cd_grupos.Value = ""
1479:                         loc_oPg2.txt_4c__ds_grupos.Value = ""
1480:                     ENDIF
1481: 
1482:                     loc_oBusca.Release()
1483:                 ENDIF
1484: 
1485:                 IF USED("cursor_4c_BuscaGrupo")
1486:                     USE IN cursor_4c_BuscaGrupo
1487:                 ENDIF
1488:             ENDIF
1489: 
1490:             IF USED("cursor_4c_GcrVal")
1491:                 USE IN cursor_4c_GcrVal
1492:             ENDIF
1493: 
1494:             *-- No modo INSERIR, popular Titulo com codigo do grupo
1495:             IF THIS.this_cModoAtual = "INCLUIR"
1496:                 loc_oPg2.txt_4c_Titulo.Value = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
1497:             ENDIF
1498: 
1499:         CATCH TO loException
1500:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1501:             IF USED("cursor_4c_GcrVal")
1502:                 USE IN cursor_4c_GcrVal
1503:             ENDIF
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *==========================================================================
1508:     * VALIDACAO: DESCRICAO DO GRUPO (LostFocus de txt_4c__ds_grupos)
1509:     *==========================================================================
1510: 
1511:     PROCEDURE ValidarDescGrupo(par_nKeyCode, par_nShiftAltCtrl)
1512:         LOCAL loc_oPg2, loc_cDesc, loc_oBusca
1513:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1514:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c__ds_grupos.Value)
1515: 
1516:         IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1517:             RETURN
1518:         ENDIF
1519: 
1520:         TRY
1521:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1522:                 "SigCdGcr", "cursor_4c_BuscaGrupoDsc", "Descrs", loc_cDesc, ;
1523:                 "Grupos de Conta Corrente")
1524: 
1525:             IF VARTYPE(loc_oBusca) = "O"
1526:                 IF NOT loc_oBusca.this_lAchouRegistro
1527:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1528:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1529:                     loc_oBusca.Show()
1530:                 ENDIF
1531: 
1532:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDsc")
1533:                     loc_oPg2.txt_4c__cd_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Codigos)
1534:                     loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Descrs)
1535:                 ELSE
1536:                     loc_oPg2.txt_4c__ds_grupos.Value = ""
1537:                 ENDIF
1538: 
1539:                 loc_oBusca.Release()
1540:             ENDIF
1541: 
1542:             IF USED("cursor_4c_BuscaGrupoDsc")
1543:                 USE IN cursor_4c_BuscaGrupoDsc
1544:             ENDIF
1545: 
1546:         CATCH TO loException
1547:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
1548:                     loException.Message, "Erro")
1549:         ENDTRY
1550:     ENDPROC
1551: 
1552:     *==========================================================================
1553:     * VALIDACAO: CLASSE (LostFocus de txt_4c_Classe)
1554:     * Busca em SigCdCss por Classes, popula descricao
1555:     *==========================================================================
1556: 
1557:     PROCEDURE ValidarClasse(par_nKeyCode, par_nShiftAltCtrl)
1558:         LOCAL loc_oPg2, loc_cClasse, loc_cSQL, loc_nResult, loc_oBusca
1559:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1560:         loc_cClasse = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)
1561: 
1562:         IF EMPTY(loc_cClasse)
1563:             loc_oPg2.txt_4c_Dclasse.Value = ""
1564:             RETURN
1565:         ENDIF
1566: 
1567:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1568:             RETURN
1569:         ENDIF
1570: 
1571:         TRY
1572:             loc_cSQL = "SELECT TOP 1 Classes, Descrs FROM SigCdCss WHERE Classes = " + ;
1573:                        EscaparSQL(loc_cClasse)
1574:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVal")
1575:             IF loc_nResult >= 0 AND USED("cursor_4c_CssVal") AND RECCOUNT("cursor_4c_CssVal") > 0
1576:                 loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssVal.Descrs)
1577:             ELSE
1578:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1579:                     "SigCdCss", "cursor_4c_BuscaClasse", "Classes", loc_cClasse, ;
1580:                     "Classes Cont" + CHR(225) + "beis")
1581: 
1582:                 IF VARTYPE(loc_oBusca) = "O"
1583:                     IF NOT loc_oBusca.this_lAchouRegistro
1584:                         loc_oBusca.mAddColuna("Classes", "", "Classe")
1585:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1586:                         loc_oBusca.Show()
1587:                     ENDIF
1588: 
1589:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
1590:                         loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasse.Classes)
1591:                         loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasse.Descrs)
1592:                     ELSE
1593:                         loc_oPg2.txt_4c_Classe.Value  = ""
1594:                         loc_oPg2.txt_4c_Dclasse.Value = ""
1595:                     ENDIF
1596: 
1597:                     loc_oBusca.Release()
1598:                 ENDIF
1599: 
1600:                 IF USED("cursor_4c_BuscaClasse")
1601:                     USE IN cursor_4c_BuscaClasse
1602:                 ENDIF
1603:             ENDIF
1604: 
1605:             IF USED("cursor_4c_CssVal")
1606:                 USE IN cursor_4c_CssVal
1607:             ENDIF
1608: 
1609:         CATCH TO loException
1610:             MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
1611:             IF USED("cursor_4c_CssVal")
1612:                 USE IN cursor_4c_CssVal
1613:             ENDIF
1614:         ENDTRY
1615:     ENDPROC
1616: 
1617:     *==========================================================================
1618:     * VALIDACAO: DESCRICAO DA CLASSE (LostFocus de txt_4c_Dclasse)
1619:     *==========================================================================
1620: 
1621:     PROCEDURE ValidarDescClasse(par_nKeyCode, par_nShiftAltCtrl)
1622:         LOCAL loc_oPg2, loc_cDesc, loc_oBusca
1623:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1624:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Dclasse.Value)
1625: 
1626:         IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1627:             RETURN
1628:         ENDIF
1629: 
1630:         TRY
1631:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1632:                 "SigCdCss", "cursor_4c_BuscaClasseDsc", "Descrs", loc_cDesc, ;
1633:                 "Classes Cont" + CHR(225) + "beis")
1634: 
1635:             IF VARTYPE(loc_oBusca) = "O"
1636:                 IF NOT loc_oBusca.this_lAchouRegistro
1637:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1638:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1639:                     loc_oBusca.Show()
1640:                 ENDIF
1641: 
1642:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasseDsc")
1643:                     loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasseDsc.Classes)
1644:                     loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasseDsc.Descrs)
1645:                 ELSE
1646:                     loc_oPg2.txt_4c_Dclasse.Value = ""
1647:                 ENDIF
1648: 
1649:                 loc_oBusca.Release()
1650:             ENDIF
1651: 
1652:             IF USED("cursor_4c_BuscaClasseDsc")
1653:                 USE IN cursor_4c_BuscaClasseDsc
1654:             ENDIF
1655: 
1656:         CATCH TO loException
1657:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da classe: " + ;
1658:                     loException.Message, "Erro")
1659:         ENDTRY
1660:     ENDPROC
1661: 
1662:     *==========================================================================
1663:     * KEYPRESS HANDLERS para lookup fields (F4 = 115 abre picker)
1664:     *==========================================================================
1665: 
1666:     FUNCTION CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1667:         IF par_nKeyCode = 115
1668:             THIS.AbrirLookupGrupo()
1669:         ENDIF
1670:     ENDFUNC
1671: 
1672:     FUNCTION DsGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1673:         IF par_nKeyCode = 115
1674:             THIS.AbrirLookupGrupoDesc()
1675:         ENDIF
1676:     ENDFUNC
1677: 
1678:     FUNCTION ClasseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1679:         IF par_nKeyCode = 115
1680:             THIS.AbrirLookupClasse()
1681:         ENDIF
1682:     ENDFUNC
1683: 
1684:     FUNCTION DclasseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1685:         IF par_nKeyCode = 115
1686:             THIS.AbrirLookupClasseDesc()
1687:         ENDIF
1688:     ENDFUNC
1689: 
1690:     *==========================================================================
1691:     * LOOKUP DE GRUPO (SigCdGcr) por codigo e por descricao
1692:     *==========================================================================
1693: 
1694:     FUNCTION AbrirLookupGrupo()
1695:         LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDescrs
1696:         LOCAL loc_lResultado
1697:         loc_lResultado = .T.
1698:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1699: 
1700:         TRY
1701:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1702:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", "", ;
1703:                 "Grupos de Conta Corrente")
1704: 
1705:             IF VARTYPE(loc_oBusca) = "O"
1706:                 IF NOT loc_oBusca.this_lAchouRegistro
1707:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1708:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1709:                     loc_oBusca.Show()
1710:                 ENDIF
1711: 
1712:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1713:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1714:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1715:                     loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
1716:                     loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs
1717: 
1718:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
1719:                         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
1720:                             loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
1721:                         ENDIF
1722:                     ENDIF
1723:                 ENDIF
1724: 
1725:                 loc_oBusca.Release()
1726:             ENDIF
1727: 
1728:             IF USED("cursor_4c_BuscaGcr")
1729:                 USE IN cursor_4c_BuscaGcr
1730:             ENDIF
1731:         CATCH TO loc_oErro
1732:             IF USED("cursor_4c_BuscaGcr")
1733:                 USE IN cursor_4c_BuscaGcr
1734:             ENDIF
1735:             MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
1736:             loc_lResultado = .F.
1737:         ENDTRY
1738: 
1739:         RETURN loc_lResultado
1740:     ENDFUNC
1741: 
1742:     FUNCTION AbrirLookupGrupoDesc()
1743:         LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDescrs
1744:         LOCAL loc_lResultado
1745:         loc_lResultado = .T.
1746:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1747: 
1748:         TRY
1749:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1750:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Descrs", "", ;
1751:                 "Grupos de Conta Corrente")
1752: 
1753:             IF VARTYPE(loc_oBusca) = "O"
1754:                 IF NOT loc_oBusca.this_lAchouRegistro
1755:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1756:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1757:                     loc_oBusca.Show()
1758:                 ENDIF
1759: 
1760:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1761:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1762:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1763:                     loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
1764:                     loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs
1765: 
1766:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
1767:                         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
1768:                             loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
1769:                         ENDIF
1770:                     ENDIF
1771:                 ENDIF
1772: 
1773:                 loc_oBusca.Release()
1774:             ENDIF
1775: 
1776:             IF USED("cursor_4c_BuscaGcr")
1777:                 USE IN cursor_4c_BuscaGcr
1778:             ENDIF
1779:         CATCH TO loc_oErro
1780:             IF USED("cursor_4c_BuscaGcr")
1781:                 USE IN cursor_4c_BuscaGcr
1782:             ENDIF
1783:             MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
1784:             loc_lResultado = .F.
1785:         ENDTRY
1786: 
1787:         RETURN loc_lResultado
1788:     ENDFUNC
1789: 

*-- Linhas 1798 a 1883:
1798:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1799: 
1800:         TRY
1801:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1802:                 "SigCdCss", "cursor_4c_BuscaCss", "Classes", "", ;
1803:                 "Classes Cont" + CHR(225) + "beis")
1804: 
1805:             IF VARTYPE(loc_oBusca) = "O"
1806:                 IF NOT loc_oBusca.this_lAchouRegistro
1807:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1808:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1809:                     loc_oBusca.Show()
1810:                 ENDIF
1811: 
1812:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
1813:                     loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
1814:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
1815:                     loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
1816:                     loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
1817:                 ENDIF
1818: 
1819:                 loc_oBusca.Release()
1820:             ENDIF
1821: 
1822:             IF USED("cursor_4c_BuscaCss")
1823:                 USE IN cursor_4c_BuscaCss
1824:             ENDIF
1825:         CATCH TO loc_oErro
1826:             IF USED("cursor_4c_BuscaCss")
1827:                 USE IN cursor_4c_BuscaCss
1828:             ENDIF
1829:             MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
1830:             loc_lResultado = .F.
1831:         ENDTRY
1832: 
1833:         RETURN loc_lResultado
1834:     ENDFUNC
1835: 
1836:     FUNCTION AbrirLookupClasseDesc()
1837:         LOCAL loc_oPg2, loc_oBusca, loc_cClasse, loc_cDescrs
1838:         LOCAL loc_lResultado
1839:         loc_lResultado = .T.
1840:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1841: 
1842:         TRY
1843:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1844:                 "SigCdCss", "cursor_4c_BuscaCss", "Descrs", "", ;
1845:                 "Classes Cont" + CHR(225) + "beis")
1846: 
1847:             IF VARTYPE(loc_oBusca) = "O"
1848:                 IF NOT loc_oBusca.this_lAchouRegistro
1849:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1850:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1851:                     loc_oBusca.Show()
1852:                 ENDIF
1853: 
1854:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
1855:                     loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
1856:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
1857:                     loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
1858:                     loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
1859:                 ENDIF
1860: 
1861:                 loc_oBusca.Release()
1862:             ENDIF
1863: 
1864:             IF USED("cursor_4c_BuscaCss")
1865:                 USE IN cursor_4c_BuscaCss
1866:             ENDIF
1867:         CATCH TO loc_oErro
1868:             IF USED("cursor_4c_BuscaCss")
1869:                 USE IN cursor_4c_BuscaCss
1870:             ENDIF
1871:             MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
1872:             loc_lResultado = .F.
1873:         ENDTRY
1874: 
1875:         RETURN loc_lResultado
1876:     ENDFUNC
1877: 
1878:     *==========================================================================
1879:     * VALIDAR TITULO (LostFocus ? unicidade em SigCdMri para o mesmo Balanco)
1880:     * Ativo apenas quando Mapas=2 e no modo INCLUIR ou ALTERAR
1881:     *==========================================================================
1882: 
1883:     FUNCTION ValidarTitulo()

*-- Linhas 1911 a 1954:
1911:                     IF USED("cursor_4c_DupTit")
1912:                         USE IN cursor_4c_DupTit
1913:                     ENDIF
1914:                     MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
1915:                     loc_oPg2.txt_4c_Titulo.SetFocus()
1916:                     loc_lResultado = .F.
1917:                 ENDIF
1918:             ENDIF
1919:             IF USED("cursor_4c_DupTit")
1920:                 USE IN cursor_4c_DupTit
1921:             ENDIF
1922:         CATCH TO loc_oErro
1923:             IF USED("cursor_4c_DupTit")
1924:                 USE IN cursor_4c_DupTit
1925:             ENDIF
1926:             MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loc_oErro.Message, "Erro")
1927:             loc_lResultado = .F.
1928:         ENDTRY
1929: 
1930:         RETURN loc_lResultado
1931:     ENDFUNC
1932: 
1933:     *==========================================================================
1934:     * CALCULAR PROXIMA ORDEM (retorna proximo Ordems disponivel)
1935:     *==========================================================================
1936: 
1937:     PROTECTED FUNCTION CalcularProximaOrdem()
1938:         LOCAL loc_cSQL, loc_nResult, loc_nOrdem
1939:         loc_nOrdem = 1
1940: 
1941:         TRY
1942:             loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
1943:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
1944:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
1945:             IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
1946:                 IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
1947:                     loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
1948:                 ENDIF
1949:             ENDIF
1950:             IF USED("cursor_4c_ProxOrdem")
1951:                 USE IN cursor_4c_ProxOrdem
1952:             ENDIF
1953:         CATCH TO loException
1954:             MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")

*-- Linhas 2016 a 2456:
2016:         *-- Titulo obrigatorio e unico se Mapas=2
2017:         IF THIS.this_nMapas = 2
2018:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
2019:                 MsgAviso("T" + CHR(237) + "tulo N" + CHR(227) + "o Preenchido!", "Valida" + CHR(231) + CHR(227) + "o")
2020:                 loc_oPg2.txt_4c_Titulo.SetFocus()
2021:                 RETURN .F.
2022:             ENDIF
2023: 
2024:             loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
2025:             TRY
2026:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2027:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2028:                            " AND Titulos = " + EscaparSQL(loc_cTituloVal) + ;
2029:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2030:                 loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
2031:                 IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
2032:                     IF cursor_4c_DupTit.QTD > 0
2033:                         IF USED("cursor_4c_DupTit")
2034:                             USE IN cursor_4c_DupTit
2035:                         ENDIF
2036:                         MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
2037:                         loc_oPg2.txt_4c_Titulo.SetFocus()
2038:                         loc_lResultado = .F.
2039:                     ENDIF
2040:                 ENDIF
2041:                 IF USED("cursor_4c_DupTit")
2042:                     USE IN cursor_4c_DupTit
2043:                 ENDIF
2044:             CATCH TO loException
2045:                 IF USED("cursor_4c_DupTit")
2046:                     USE IN cursor_4c_DupTit
2047:                 ENDIF
2048:                 MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loException.Message, "Erro")
2049:                 loc_lResultado = .F.
2050:             ENDTRY
2051: 
2052:             IF !loc_lResultado
2053:                 RETURN .F.
2054:             ENDIF
2055:         ENDIF
2056: 
2057:         *-- Validar Grupo (Tpregs=1)
2058:         IF loc_nTpregs = 1
2059:             IF EMPTY(loc_cGrupos)
2060:                 MsgAviso("Grupo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2061:                 loc_oPg2.txt_4c__cd_grupos.SetFocus()
2062:                 RETURN .F.
2063:             ENDIF
2064: 
2065:             TRY
2066:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
2067:                            EscaparSQL(loc_cGrupos)
2068:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
2069:                 IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
2070:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
2071:                     loc_oBO.this_cClasses  = loc_cGrupos
2072:                     IF USED("cursor_4c_VGcr")
2073:                         USE IN cursor_4c_VGcr
2074:                     ENDIF
2075:                 ELSE
2076:                     IF USED("cursor_4c_VGcr")
2077:                         USE IN cursor_4c_VGcr
2078:                     ENDIF
2079:                     MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2080:                     loc_oPg2.txt_4c__cd_grupos.SetFocus()
2081:                     loc_lResultado = .F.
2082:                 ENDIF
2083:             CATCH TO loException
2084:                 IF USED("cursor_4c_VGcr")
2085:                     USE IN cursor_4c_VGcr
2086:                 ENDIF
2087:                 MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
2088:                 loc_lResultado = .F.
2089:             ENDTRY
2090: 
2091:             IF !loc_lResultado
2092:                 RETURN .F.
2093:             ENDIF
2094:         ENDIF
2095: 
2096:         *-- Validar Classe (Tpregs=3)
2097:         IF loc_nTpregs = 3
2098:             IF EMPTY(loc_cClasses)
2099:                 MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2100:                 loc_oPg2.txt_4c_Classe.SetFocus()
2101:                 RETURN .F.
2102:             ENDIF
2103: 
2104:             TRY
2105:                 loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
2106:                            EscaparSQL(loc_cClasses)
2107:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
2108:                 IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
2109:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
2110:                     loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
2111:                     IF USED("cursor_4c_VCss")
2112:                         USE IN cursor_4c_VCss
2113:                     ENDIF
2114:                 ELSE
2115:                     IF USED("cursor_4c_VCss")
2116:                         USE IN cursor_4c_VCss
2117:                     ENDIF
2118:                     MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2119:                     loc_oPg2.txt_4c_Classe.SetFocus()
2120:                     loc_lResultado = .F.
2121:                 ENDIF
2122:             CATCH TO loException
2123:                 IF USED("cursor_4c_VCss")
2124:                     USE IN cursor_4c_VCss
2125:                 ENDIF
2126:                 MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
2127:                 loc_lResultado = .F.
2128:             ENDTRY
2129: 
2130:             IF !loc_lResultado
2131:                 RETURN .F.
2132:             ENDIF
2133: 
2134:             TRY
2135:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2136:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2137:                            " AND Classes = " + EscaparSQL(loc_cClasses) + ;
2138:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2139:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
2140:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
2141:                     IF cursor_4c_DupCls.QTD > 0
2142:                         IF USED("cursor_4c_DupCls")
2143:                             USE IN cursor_4c_DupCls
2144:                         ENDIF
2145:                         MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
2146:                         loc_oPg2.txt_4c_Classe.SetFocus()
2147:                         loc_lResultado = .F.
2148:                     ENDIF
2149:                 ENDIF
2150:                 IF USED("cursor_4c_DupCls")
2151:                     USE IN cursor_4c_DupCls
2152:                 ENDIF
2153:             CATCH TO loException
2154:                 MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")
2155:                 loc_lResultado = .F.
2156:             ENDTRY
2157: 
2158:             IF !loc_lResultado
2159:                 RETURN .F.
2160:             ENDIF
2161:         ENDIF
2162: 
2163:         *-- Validar SubTotal (Tpregs=2)
2164:         IF loc_nTpregs = 2
2165:             IF EMPTY(loc_cDescGrps)
2166:                 MsgAviso("SubTotal Inv" + CHR(225) + "lido.", "Valida" + CHR(231) + CHR(227) + "o")
2167:                 loc_oPg2.txt_4c_Descgrps.SetFocus()
2168:                 RETURN .F.
2169:             ENDIF
2170: 
2171:             IF loc_nFator <> 100
2172:                 MsgAviso("Fator Inv" + CHR(225) + "lido", "Valida" + CHR(231) + CHR(227) + "o")
2173:                 loc_oPg2.txt_4c_Fator.Value = 100
2174:                 loc_oPg2.txt_4c_Fator.SetFocus()
2175:                 RETURN .F.
2176:             ENDIF
2177: 
2178:             loc_oBO.this_cClasses = "6"
2179: 
2180:             TRY
2181:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2182:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2183:                            " AND DescGrps = " + EscaparSQL(loc_cDescGrps) + ;
2184:                            " AND CidChaves <> " + EscaparSQL(loc_oBO.this_cCidChaves)
2185:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
2186:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
2187:                     IF cursor_4c_DupSub.QTD > 0
2188:                         IF USED("cursor_4c_DupSub")
2189:                             USE IN cursor_4c_DupSub
2190:                         ENDIF
2191:                         MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
2192:                         loc_oPg2.txt_4c_Descgrps.SetFocus()
2193:                         loc_lResultado = .F.
2194:                     ENDIF
2195:                 ENDIF
2196:                 IF USED("cursor_4c_DupSub")
2197:                     USE IN cursor_4c_DupSub
2198:                 ENDIF
2199:             CATCH TO loException
2200:                 MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")
2201:                 loc_lResultado = .F.
2202:             ENDTRY
2203: 
2204:             IF !loc_lResultado
2205:                 RETURN .F.
2206:             ENDIF
2207:         ENDIF
2208: 
2209:         *-- Validar Operacao selecionada
2210:         IF loc_nListIdx <= 0
2211:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2212:             loc_oPg2.cbo_4c_Cmb_operacaos.SetFocus()
2213:             RETURN .F.
2214:         ENDIF
2215: 
2216:         *-- Validar Analiticos
2217:         IF NOT INLIST(loc_nAnaliticos, 1, 2)
2218:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2219:             loc_oPg2.obj_4c_Opt_analiticos.SetFocus()
2220:             RETURN .F.
2221:         ENDIF
2222: 
2223:         *-- Validar Fator (1-100, exceto SubTotal que exige 100 e ja foi validado)
2224:         IF loc_nTpregs <> 2
2225:             IF loc_nFator <= 0 OR loc_nFator > 100
2226:                 MsgAviso("Fator Inv" + CHR(225) + "lido!!", "Valida" + CHR(231) + CHR(227) + "o")
2227:                 loc_oPg2.txt_4c_Fator.Value = 100
2228:                 loc_oPg2.txt_4c_Fator.SetFocus()
2229:                 RETURN .F.
2230:             ENDIF
2231:         ENDIF
2232: 
2233:         *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
2234:         IF loc_nTpregs = 1
2235:             TRY
2236:                 loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
2237:                            EscaparSQL(loc_oBO.this_cClasses)
2238:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
2239:                 IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
2240:                     loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
2241:                 ELSE
2242:                     loc_oBO.this_nNivels = 0
2243:                 ENDIF
2244:                 IF USED("cursor_4c_NivGrp")
2245:                     USE IN cursor_4c_NivGrp
2246:                 ENDIF
2247:             CATCH TO loException
2248:                 MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
2249:             ENDTRY
2250:         ENDIF
2251: 
2252:         RETURN .T.
2253:     ENDFUNC
2254: 
2255:     *==========================================================================
2256:     * EVENTOS DOS BOTOES - todos PUBLIC para BINDEVENT
2257:     *==========================================================================
2258: 
2259:     PROCEDURE BtnIncluirClick()
2260:         LOCAL loc_oPg2, loc_nProxOrdem
2261:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2262: 
2263:         *-- Calcular AltSubtot para novo registro (sem DescGrps atual)
2264:         THIS.this_lAltSubtot = THIS.CalcularAltSubtot("")
2265: 
2266:         THIS.this_oBusinessObject.NovoRegistro()
2267:         THIS.LimparCampos()
2268: 
2269:         *-- Calcular e setar proxima ordem
2270:         loc_nProxOrdem = THIS.CalcularProximaOrdem()
2271:         loc_oPg2.txt_4c_Ordems.Value = loc_nProxOrdem
2272: 
2273:         THIS.this_cModoAtual = "INCLUIR"
2274:         THIS.HabilitarCampos(.T.)
2275:         THIS.AlternarPagina(2)
2276:         loc_oPg2.obj_4c_OptTpregs.SetFocus()
2277:     ENDPROC
2278: 
2279:     PROCEDURE BtnVisualizarClick()
2280:         LOCAL loc_cCidChaves
2281:         loc_cCidChaves = ""
2282: 
2283:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2284:             SELECT cursor_4c_Dados
2285:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2286:         ENDIF
2287: 
2288:         IF EMPTY(loc_cCidChaves)
2289:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
2290:             RETURN
2291:         ENDIF
2292: 
2293:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2294:             THIS.this_cCidChavesAtual = loc_cCidChaves
2295:             THIS.this_cModoAtual      = "VISUALIZAR"
2296:             THIS.BOParaForm()
2297:             THIS.HabilitarCampos(.F.)
2298:             THIS.AlternarPagina(2)
2299:         ENDIF
2300:     ENDPROC
2301: 
2302:     PROCEDURE BtnAlterarClick()
2303:         LOCAL loc_cCidChaves, loc_cDescGrpsAtual
2304:         loc_cCidChaves = ""
2305: 
2306:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2307:             SELECT cursor_4c_Dados
2308:             loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
2309:             loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
2310:         ENDIF
2311: 
2312:         IF EMPTY(loc_cCidChaves)
2313:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
2314:             RETURN
2315:         ENDIF
2316: 
2317:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2318:             THIS.this_cCidChavesAtual = loc_cCidChaves
2319:             THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
2320:             THIS.this_oBusinessObject.EditarRegistro()
2321:             THIS.this_cModoAtual = "ALTERAR"
2322:             THIS.BOParaForm()
2323:             THIS.HabilitarCampos(.T.)
2324:             THIS.AlternarPagina(2)
2325:         ENDIF
2326:     ENDPROC
2327: 
2328:     PROCEDURE BtnExcluirClick()
2329:         LOCAL loc_cCidChaves, loc_lConfirma
2330:         loc_cCidChaves = ""
2331: 
2332:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2333:             SELECT cursor_4c_Dados
2334:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2335:         ENDIF
2336: 
2337:         IF EMPTY(loc_cCidChaves)
2338:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2339:             RETURN
2340:         ENDIF
2341: 
2342:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
2343:                                     "Confirmar Exclus" + CHR(227) + "o")
2344: 
2345:         IF loc_lConfirma
2346:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2347:                 IF THIS.this_oBusinessObject.Excluir()
2348:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
2349:                     THIS.CarregarLista()
2350:                 ENDIF
2351:             ENDIF
2352:         ENDIF
2353:     ENDPROC
2354: 
2355:     PROCEDURE BtnBuscarClick()
2356:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2357:             GO TOP IN cursor_4c_Dados
2358:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2359:         ENDIF
2360:     ENDPROC
2361: 
2362:     PROCEDURE BtnEncerrarClick()
2363:         THIS.Release()
2364:     ENDPROC
2365: 
2366:     PROCEDURE BtnSalvarClick()
2367:         LOCAL loc_lSucesso
2368:         loc_lSucesso = .F.
2369: 
2370:         *-- Transferir campos do form para o BO
2371:         THIS.FormParaBO()
2372: 
2373:         *-- Validar e auto-popular campos derivados
2374:         IF NOT THIS.ValidarCampos()
2375:             RETURN
2376:         ENDIF
2377: 
2378:         TRY
2379:             IF THIS.this_oBusinessObject.Salvar()
2380:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
2381:                 THIS.AlternarPagina(1)
2382:                 loc_lSucesso = .T.
2383:             ENDIF
2384:         CATCH TO loException
2385:             MsgErro("Erro ao salvar: " + loException.Message, "Erro")
2386:         ENDTRY
2387:     ENDPROC
2388: 
2389:     PROCEDURE BtnCancelarClick()
2390:         THIS.AlternarPagina(1)
2391:     ENDPROC
2392: 
2393:     *==========================================================================
2394:     * DESTROY
2395:     *==========================================================================
2396: 
2397:     PROCEDURE Destroy()
2398:         LOCAL loc_lSucesso
2399:         loc_lSucesso = .F.
2400: 
2401:         TRY
2402:             IF USED("cursor_4c_Dados")
2403:                 USE IN cursor_4c_Dados
2404:             ENDIF
2405:             IF USED("cursor_4c_Carrega")
2406:                 USE IN cursor_4c_Carrega
2407:             ENDIF
2408:             IF USED("cursor_4c_Busca")
2409:                 USE IN cursor_4c_Busca
2410:             ENDIF
2411: 
2412:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2413:                 THIS.this_oBusinessObject = .NULL.
2414:             ENDIF
2415: 
2416:             loc_lSucesso = .T.
2417:         CATCH TO loException
2418:             MsgErro("Erro ao destruir FormCmr: " + loException.Message, "Erro")
2419:         ENDTRY
2420: 
2421:         DODEFAULT()
2422:         RETURN loc_lSucesso
2423:     ENDPROC
2424: 
2425:     *==========================================================================
2426:     * AUXILIARES
2427:     *==========================================================================
2428: 
2429:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2430:         LOCAL loc_nI, loc_oObjeto, loc_nP
2431:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2432:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2433:             IF VARTYPE(loc_oObjeto) = "O"
2434:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2435:                     loc_oObjeto.Visible = .T.
2436:                 ENDIF
2437:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2438:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2439:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2440:                     ENDFOR
2441:                 ENDIF
2442:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2443:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2444:                 ENDIF
2445:             ENDIF
2446:         ENDFOR
2447:     ENDPROC
2448: 
2449:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2450:         WITH par_oGrid
2451:             .FontName = "Tahoma"
2452:             .FontSize = 8
2453:         ENDWITH
2454:     ENDPROC
2455: 
2456: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CmrBO.prg):
*==============================================================================
* CmrBO.prg - Business Object para Itens de Mapa de Resultados (SigCdMri)
* Data: 2026-07-29
* Tabela: SIGCDMRI | PK: CidChaves (char 20)
* FK: Balancos -> SIGCDMRR.Balancos
*==============================================================================

DEFINE CLASS CmrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento com campos da tabela SIGCDMRI)
    this_cCidChaves   = ""  && cidchaves   CHAR(20)     - Chave " + CHR(250) + "nica (PK)
    this_cBalancos    = ""  && balancos    CHAR(20)     - Balan" + CHR(231) + "o (FK -> SIGCDMRR)
    this_nAnaliticos  = 0   && analiticos  NUMERIC(1,0) - Anal" + CHR(237) + "tico (1=Sim, 2=N" + CHR(227) + "o)
    this_cClasses     = ""  && classes     CHAR(10)     - Classe contabil
    this_cDescGrps    = ""  && descgrps    CHAR(30)     - Descri" + CHR(231) + CHR(227) + "o do Subtotal
    this_nFators      = 0   && fators      NUMERIC(3,0) - Fator percentual (0-100)
    this_cGrupos      = ""  && grupos      CHAR(10)     - Grupo de conta corrente
    this_nNivels      = 0   && nivels      NUMERIC(1,0) - N" + CHR(237) + "vel hier" + CHR(225) + "rquico
    this_cOperacaos   = ""  && operacaos   CHAR(1)      - Opera" + CHR(231) + CHR(227) + "o ('+' Soma / '-' Subtrai)
    this_nTpregs      = 0   && tpregs      NUMERIC(1,0) - Tipo de registro (1=Grupo, 2=SubTotal, 3=Classe)
    this_cTitulos     = ""  && titulos     CHAR(10)     - T" + CHR(237) + "tulo do cabe" + CHR(231) + "alho de coluna
    this_nCpartidas   = 0   && cpartidas   NUMERIC(1,0) - Contra Partida (1=Sim, 2=N" + CHR(227) + "o)
    this_nOrdems      = 0   && ordems      NUMERIC(3,0) - Ordem de exibi" + CHR(231) + CHR(227) + "o
    this_nSubtot100s  = 0   && subtot100s  NUMERIC(1,0) - SubTotal 100% (1=Sim, 2=N" + CHR(227) + "o)
    this_nTpDatas     = 0   && tpdatas     NUMERIC(1,0) - Tipo de data (1=Emiss" + CHR(227) + "o, 2=Lan" + CHR(231) + "amento, 3=Vencimento, 4=Baixa)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMri"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor -> propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(CidChaves,  "C")
                THIS.this_cBalancos   = TratarNulo(Balancos,   "C")
                THIS.this_nTpregs     = TratarNulo(Tpregs,     "N")
                THIS.this_cGrupos     = TratarNulo(Grupos,     "C")
                THIS.this_cDescGrps   = TratarNulo(DescGrps,   "C")
                THIS.this_cClasses    = TratarNulo(Classes,    "C")
                THIS.this_nAnaliticos = TratarNulo(Analiticos, "N")
                THIS.this_cOperacaos  = TratarNulo(Operacaos,  "C")
                THIS.this_nCpartidas  = TratarNulo(Cpartidas,  "N")
                THIS.this_nSubtot100s = TratarNulo(Subtot100s, "N")
                THIS.this_nFators     = TratarNulo(Fators,     "N")
                THIS.this_cTitulos    = TratarNulo(Titulos,    "C")
                THIS.this_nOrdems     = TratarNulo(Ordems,     "N")
                THIS.this_nTpDatas    = TratarNulo(TpDatas,    "N")
                THIS.this_nNivels     = TratarNulo(Nivels,     "N")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista itens do mapa de resultados do Balanco corrente
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
                       " ORDER BY Ordems, Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") >= 0
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar itens do mapa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
            loc_cSQL = "SELECT CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                       " Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                       " Fators, Titulos, Ordems, TpDatas, Nivels" + ;
                       " FROM SigCdMri" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cNovaChave
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica via SQL Server (NEWID sem hifens, 20 chars)
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS NovaCidChave", ;
                "cursor_4c_NewID")
            IF loc_nResult >= 0 AND USED("cursor_4c_NewID") AND RECCOUNT("cursor_4c_NewID") > 0
                GO TOP IN cursor_4c_NewID
                loc_cNovaChave = ALLTRIM(cursor_4c_NewID.NovaCidChave)
            ELSE
                loc_cNovaChave = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF
            IF USED("cursor_4c_NewID")
                USE IN cursor_4c_NewID
            ENDIF
            THIS.this_cCidChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigCdMri" + ;
                " (CidChaves, Balancos, Tpregs, Grupos, DescGrps," + ;
                "  Classes, Analiticos, Operacaos, Cpartidas, Subtot100s," + ;
                "  Fators, Titulos, Ordems, TpDatas, Nivels)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cBalancos)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpregs) + ", " + ;
                EscaparSQL(THIS.this_cGrupos)     + ", " + ;
                EscaparSQL(THIS.this_cDescGrps)   + ", " + ;
                EscaparSQL(THIS.this_cClasses)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nAnaliticos)  + ", " + ;
                EscaparSQL(THIS.this_cOperacaos)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nCpartidas)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nSubtot100s)  + ", " + ;
                FormatarNumeroSQL(THIS.this_nFators)      + ", " + ;
                EscaparSQL(THIS.this_cTitulos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdems)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpDatas)     + ", " + ;
                FormatarNumeroSQL(THIS.this_nNivels)      + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdMri (PROTECTED - chamado por Salvar())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SigCdMri SET" + ;
                " Tpregs = "      + FormatarNumeroSQL(THIS.this_nTpregs)     + "," + ;
                " Grupos = "      + EscaparSQL(THIS.this_cGrupos)            + "," + ;
                " DescGrps = "    + EscaparSQL(THIS.this_cDescGrps)          + "," + ;
                " Classes = "     + EscaparSQL(THIS.this_cClasses)           + "," + ;
                " Analiticos = "  + FormatarNumeroSQL(THIS.this_nAnaliticos) + "," + ;
                " Operacaos = "   + EscaparSQL(THIS.this_cOperacaos)         + "," + ;
                " Cpartidas = "   + FormatarNumeroSQL(THIS.this_nCpartidas)  + "," + ;
                " Subtot100s = "  + FormatarNumeroSQL(THIS.this_nSubtot100s) + "," + ;
                " Fators = "      + FormatarNumeroSQL(THIS.this_nFators)     + "," + ;
                " Titulos = "     + EscaparSQL(THIS.this_cTitulos)           + "," + ;
                " Ordems = "      + FormatarNumeroSQL(THIS.this_nOrdems)     + "," + ;
                " TpDatas = "     + FormatarNumeroSQL(THIS.this_nTpDatas)    + "," + ;
                " Nivels = "      + FormatarNumeroSQL(THIS.this_nNivels)     + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMri (PROTECTED - chamado por Excluir())
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM SigCdMri" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir item:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

