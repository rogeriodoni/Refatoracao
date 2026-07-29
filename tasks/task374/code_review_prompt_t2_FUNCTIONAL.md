# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCmr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2468 linhas total):

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
462:             .FontName        = "Tahoma"
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

*-- Linhas 1390 a 1687:
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
1442:     PROCEDURE ValidarGrupo
1443:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1444:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1445:             RETURN
1446:         ENDIF
1447:         LOCAL loc_oPg2, loc_cGrupo, loc_cSQL, loc_nResult, loc_oBusca
1448:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1449:         loc_cGrupo = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
1450: 
1451:         IF EMPTY(loc_cGrupo)
1452:             loc_oPg2.txt_4c__ds_grupos.Value = ""
1453:             RETURN
1454:         ENDIF
1455: 
1456:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1457:             RETURN
1458:         ENDIF
1459: 
1460:         TRY
1461:             loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1462:                        EscaparSQL(loc_cGrupo)
1463:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
1464:             IF loc_nResult >= 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
1465:                 loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_GcrVal.Descrs)
1466:             ELSE
1467:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1468:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1469:                     "Grupos de Conta Corrente")
1470: 
1471:                 IF VARTYPE(loc_oBusca) = "O"
1472:                     IF NOT loc_oBusca.this_lAchouRegistro
1473:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1474:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1475:                         loc_oBusca.Show()
1476:                     ENDIF
1477: 
1478:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
1479:                         loc_oPg2.txt_4c__cd_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Codigos)
1480:                         loc_oPg2.txt_4c__ds_grupos.Value  = ALLTRIM(cursor_4c_BuscaGrupo.Descrs)
1481:                     ELSE
1482:                         loc_oPg2.txt_4c__cd_grupos.Value = ""
1483:                         loc_oPg2.txt_4c__ds_grupos.Value = ""
1484:                     ENDIF
1485: 
1486:                     loc_oBusca.Release()
1487:                 ENDIF
1488: 
1489:                 IF USED("cursor_4c_BuscaGrupo")
1490:                     USE IN cursor_4c_BuscaGrupo
1491:                 ENDIF
1492:             ENDIF
1493: 
1494:             IF USED("cursor_4c_GcrVal")
1495:                 USE IN cursor_4c_GcrVal
1496:             ENDIF
1497: 
1498:             *-- No modo INSERIR, popular Titulo com codigo do grupo
1499:             IF THIS.this_cModoAtual = "INCLUIR"
1500:                 loc_oPg2.txt_4c_Titulo.Value = ALLTRIM(loc_oPg2.txt_4c__cd_grupos.Value)
1501:             ENDIF
1502: 
1503:         CATCH TO loException
1504:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1505:             IF USED("cursor_4c_GcrVal")
1506:                 USE IN cursor_4c_GcrVal
1507:             ENDIF
1508:         ENDTRY
1509:     ENDPROC
1510: 
1511:     *==========================================================================
1512:     * VALIDACAO: DESCRICAO DO GRUPO (LostFocus de txt_4c__ds_grupos)
1513:     *==========================================================================
1514: 
1515:     PROCEDURE ValidarDescGrupo
1516:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1517:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1518:             RETURN
1519:         ENDIF
1520:         LOCAL loc_oPg2, loc_cDesc, loc_oBusca
1521:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1522:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c__ds_grupos.Value)
1523: 
1524:         IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1525:             RETURN
1526:         ENDIF
1527: 
1528:         TRY
1529:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1530:                 "SigCdGcr", "cursor_4c_BuscaGrupoDsc", "Descrs", loc_cDesc, ;
1531:                 "Grupos de Conta Corrente")
1532: 
1533:             IF VARTYPE(loc_oBusca) = "O"
1534:                 IF NOT loc_oBusca.this_lAchouRegistro
1535:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1536:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1537:                     loc_oBusca.Show()
1538:                 ENDIF
1539: 
1540:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupoDsc")
1541:                     loc_oPg2.txt_4c__cd_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Codigos)
1542:                     loc_oPg2.txt_4c__ds_grupos.Value = ALLTRIM(cursor_4c_BuscaGrupoDsc.Descrs)
1543:                 ELSE
1544:                     loc_oPg2.txt_4c__ds_grupos.Value = ""
1545:                 ENDIF
1546: 
1547:                 loc_oBusca.Release()
1548:             ENDIF
1549: 
1550:             IF USED("cursor_4c_BuscaGrupoDsc")
1551:                 USE IN cursor_4c_BuscaGrupoDsc
1552:             ENDIF
1553: 
1554:         CATCH TO loException
1555:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + ;
1556:                     loException.Message, "Erro")
1557:         ENDTRY
1558:     ENDPROC
1559: 
1560:     *==========================================================================
1561:     * VALIDACAO: CLASSE (LostFocus de txt_4c_Classe)
1562:     * Busca em SigCdCss por Classes, popula descricao
1563:     *==========================================================================
1564: 
1565:     PROCEDURE ValidarClasse
1566:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1567:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1568:             RETURN
1569:         ENDIF
1570:         LOCAL loc_oPg2, loc_cClasse, loc_cSQL, loc_nResult, loc_oBusca
1571:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1572:         loc_cClasse = ALLTRIM(loc_oPg2.txt_4c_Classe.Value)
1573: 
1574:         IF EMPTY(loc_cClasse)
1575:             loc_oPg2.txt_4c_Dclasse.Value = ""
1576:             RETURN
1577:         ENDIF
1578: 
1579:         IF NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1580:             RETURN
1581:         ENDIF
1582: 
1583:         TRY
1584:             loc_cSQL = "SELECT TOP 1 Classes, Descrs FROM SigCdCss WHERE Classes = " + ;
1585:                        EscaparSQL(loc_cClasse)
1586:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CssVal")
1587:             IF loc_nResult >= 0 AND USED("cursor_4c_CssVal") AND RECCOUNT("cursor_4c_CssVal") > 0
1588:                 loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_CssVal.Descrs)
1589:             ELSE
1590:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1591:                     "SigCdCss", "cursor_4c_BuscaClasse", "Classes", loc_cClasse, ;
1592:                     "Classes Cont" + CHR(225) + "beis")
1593: 
1594:                 IF VARTYPE(loc_oBusca) = "O"
1595:                     IF NOT loc_oBusca.this_lAchouRegistro
1596:                         loc_oBusca.mAddColuna("Classes", "", "Classe")
1597:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1598:                         loc_oBusca.Show()
1599:                     ENDIF
1600: 
1601:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasse")
1602:                         loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasse.Classes)
1603:                         loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasse.Descrs)
1604:                     ELSE
1605:                         loc_oPg2.txt_4c_Classe.Value  = ""
1606:                         loc_oPg2.txt_4c_Dclasse.Value = ""
1607:                     ENDIF
1608: 
1609:                     loc_oBusca.Release()
1610:                 ENDIF
1611: 
1612:                 IF USED("cursor_4c_BuscaClasse")
1613:                     USE IN cursor_4c_BuscaClasse
1614:                 ENDIF
1615:             ENDIF
1616: 
1617:             IF USED("cursor_4c_CssVal")
1618:                 USE IN cursor_4c_CssVal
1619:             ENDIF
1620: 
1621:         CATCH TO loException
1622:             MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
1623:             IF USED("cursor_4c_CssVal")
1624:                 USE IN cursor_4c_CssVal
1625:             ENDIF
1626:         ENDTRY
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * VALIDACAO: DESCRICAO DA CLASSE (LostFocus de txt_4c_Dclasse)
1631:     *==========================================================================
1632: 
1633:     PROCEDURE ValidarDescClasse
1634:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
1635:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1636:             RETURN
1637:         ENDIF
1638:         LOCAL loc_oPg2, loc_cDesc, loc_oBusca
1639:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1640:         loc_cDesc  = ALLTRIM(loc_oPg2.txt_4c_Dclasse.Value)
1641: 
1642:         IF EMPTY(loc_cDesc) OR NOT INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1643:             RETURN
1644:         ENDIF
1645: 
1646:         TRY
1647:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1648:                 "SigCdCss", "cursor_4c_BuscaClasseDsc", "Descrs", loc_cDesc, ;
1649:                 "Classes Cont" + CHR(225) + "beis")
1650: 
1651:             IF VARTYPE(loc_oBusca) = "O"
1652:                 IF NOT loc_oBusca.this_lAchouRegistro
1653:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1654:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1655:                     loc_oBusca.Show()
1656:                 ENDIF
1657: 
1658:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClasseDsc")
1659:                     loc_oPg2.txt_4c_Classe.Value  = ALLTRIM(cursor_4c_BuscaClasseDsc.Classes)
1660:                     loc_oPg2.txt_4c_Dclasse.Value = ALLTRIM(cursor_4c_BuscaClasseDsc.Descrs)
1661:                 ELSE
1662:                     loc_oPg2.txt_4c_Dclasse.Value = ""
1663:                 ENDIF
1664: 
1665:                 loc_oBusca.Release()
1666:             ENDIF
1667: 
1668:             IF USED("cursor_4c_BuscaClasseDsc")
1669:                 USE IN cursor_4c_BuscaClasseDsc
1670:             ENDIF
1671: 
1672:         CATCH TO loException
1673:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da classe: " + ;
1674:                     loException.Message, "Erro")
1675:         ENDTRY
1676:     ENDPROC
1677: 
1678:     *==========================================================================
1679:     * KEYPRESS HANDLERS para lookup fields (F4 = 115 abre picker)
1680:     *==========================================================================
1681: 
1682:     FUNCTION CdGruposKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1683:         IF par_nKeyCode = 115
1684:             THIS.AbrirLookupGrupo()
1685:         ENDIF
1686:     ENDFUNC
1687: 

*-- Linhas 1714 a 1805:
1714:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1715: 
1716:         TRY
1717:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1718:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", "", ;
1719:                 "Grupos de Conta Corrente")
1720: 
1721:             IF VARTYPE(loc_oBusca) = "O"
1722:                 IF NOT loc_oBusca.this_lAchouRegistro
1723:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1724:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1725:                     loc_oBusca.Show()
1726:                 ENDIF
1727: 
1728:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1729:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1730:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1731:                     loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
1732:                     loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs
1733: 
1734:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
1735:                         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
1736:                             loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
1737:                         ENDIF
1738:                     ENDIF
1739:                 ENDIF
1740: 
1741:                 loc_oBusca.Release()
1742:             ENDIF
1743: 
1744:             IF USED("cursor_4c_BuscaGcr")
1745:                 USE IN cursor_4c_BuscaGcr
1746:             ENDIF
1747:         CATCH TO loc_oErro
1748:             IF USED("cursor_4c_BuscaGcr")
1749:                 USE IN cursor_4c_BuscaGcr
1750:             ENDIF
1751:             MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
1752:             loc_lResultado = .F.
1753:         ENDTRY
1754: 
1755:         RETURN loc_lResultado
1756:     ENDFUNC
1757: 
1758:     FUNCTION AbrirLookupGrupoDesc()
1759:         LOCAL loc_oPg2, loc_oBusca, loc_cCodigo, loc_cDescrs
1760:         LOCAL loc_lResultado
1761:         loc_lResultado = .T.
1762:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1763: 
1764:         TRY
1765:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1766:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Descrs", "", ;
1767:                 "Grupos de Conta Corrente")
1768: 
1769:             IF VARTYPE(loc_oBusca) = "O"
1770:                 IF NOT loc_oBusca.this_lAchouRegistro
1771:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1772:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1773:                     loc_oBusca.Show()
1774:                 ENDIF
1775: 
1776:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1777:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
1778:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
1779:                     loc_oPg2.txt_4c__cd_grupos.Value = loc_cCodigo
1780:                     loc_oPg2.txt_4c__ds_grupos.Value = loc_cDescrs
1781: 
1782:                     IF THIS.this_cModoAtual = "INCLUIR" AND THIS.this_nMapas = 2
1783:                         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
1784:                             loc_oPg2.txt_4c_Titulo.Value = loc_cDescrs
1785:                         ENDIF
1786:                     ENDIF
1787:                 ENDIF
1788: 
1789:                 loc_oBusca.Release()
1790:             ENDIF
1791: 
1792:             IF USED("cursor_4c_BuscaGcr")
1793:                 USE IN cursor_4c_BuscaGcr
1794:             ENDIF
1795:         CATCH TO loc_oErro
1796:             IF USED("cursor_4c_BuscaGcr")
1797:                 USE IN cursor_4c_BuscaGcr
1798:             ENDIF
1799:             MsgErro("Erro ao abrir lookup de grupo: " + loc_oErro.Message, "Erro")
1800:             loc_lResultado = .F.
1801:         ENDTRY
1802: 
1803:         RETURN loc_lResultado
1804:     ENDFUNC
1805: 

*-- Linhas 1814 a 1899:
1814:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1815: 
1816:         TRY
1817:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1818:                 "SigCdCss", "cursor_4c_BuscaCss", "Classes", "", ;
1819:                 "Classes Cont" + CHR(225) + "beis")
1820: 
1821:             IF VARTYPE(loc_oBusca) = "O"
1822:                 IF NOT loc_oBusca.this_lAchouRegistro
1823:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1824:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1825:                     loc_oBusca.Show()
1826:                 ENDIF
1827: 
1828:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
1829:                     loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
1830:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
1831:                     loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
1832:                     loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
1833:                 ENDIF
1834: 
1835:                 loc_oBusca.Release()
1836:             ENDIF
1837: 
1838:             IF USED("cursor_4c_BuscaCss")
1839:                 USE IN cursor_4c_BuscaCss
1840:             ENDIF
1841:         CATCH TO loc_oErro
1842:             IF USED("cursor_4c_BuscaCss")
1843:                 USE IN cursor_4c_BuscaCss
1844:             ENDIF
1845:             MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
1846:             loc_lResultado = .F.
1847:         ENDTRY
1848: 
1849:         RETURN loc_lResultado
1850:     ENDFUNC
1851: 
1852:     FUNCTION AbrirLookupClasseDesc()
1853:         LOCAL loc_oPg2, loc_oBusca, loc_cClasse, loc_cDescrs
1854:         LOCAL loc_lResultado
1855:         loc_lResultado = .T.
1856:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1857: 
1858:         TRY
1859:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1860:                 "SigCdCss", "cursor_4c_BuscaCss", "Descrs", "", ;
1861:                 "Classes Cont" + CHR(225) + "beis")
1862: 
1863:             IF VARTYPE(loc_oBusca) = "O"
1864:                 IF NOT loc_oBusca.this_lAchouRegistro
1865:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1866:                     loc_oBusca.mAddColuna("Classes", "", "Classe")
1867:                     loc_oBusca.Show()
1868:                 ENDIF
1869: 
1870:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCss")
1871:                     loc_cClasse = ALLTRIM(cursor_4c_BuscaCss.Classes)
1872:                     loc_cDescrs = ALLTRIM(cursor_4c_BuscaCss.Descrs)
1873:                     loc_oPg2.txt_4c_Classe.Value  = loc_cClasse
1874:                     loc_oPg2.txt_4c_Dclasse.Value = loc_cDescrs
1875:                 ENDIF
1876: 
1877:                 loc_oBusca.Release()
1878:             ENDIF
1879: 
1880:             IF USED("cursor_4c_BuscaCss")
1881:                 USE IN cursor_4c_BuscaCss
1882:             ENDIF
1883:         CATCH TO loc_oErro
1884:             IF USED("cursor_4c_BuscaCss")
1885:                 USE IN cursor_4c_BuscaCss
1886:             ENDIF
1887:             MsgErro("Erro ao abrir lookup de classe: " + loc_oErro.Message, "Erro")
1888:             loc_lResultado = .F.
1889:         ENDTRY
1890: 
1891:         RETURN loc_lResultado
1892:     ENDFUNC
1893: 
1894:     *==========================================================================
1895:     * VALIDAR TITULO (LostFocus ? unicidade em SigCdMri para o mesmo Balanco)
1896:     * Ativo apenas quando Mapas=2 e no modo INCLUIR ou ALTERAR
1897:     *==========================================================================
1898: 
1899:     FUNCTION ValidarTitulo()

*-- Linhas 1926 a 1969:
1926:                     IF USED("cursor_4c_DupTit")
1927:                         USE IN cursor_4c_DupTit
1928:                     ENDIF
1929:                     MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
1930:                     loc_oPg2.txt_4c_Titulo.SetFocus()
1931:                     loc_lResultado = .F.
1932:                 ENDIF
1933:             ENDIF
1934:             IF USED("cursor_4c_DupTit")
1935:                 USE IN cursor_4c_DupTit
1936:             ENDIF
1937:         CATCH TO loc_oErro
1938:             IF USED("cursor_4c_DupTit")
1939:                 USE IN cursor_4c_DupTit
1940:             ENDIF
1941:             MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loc_oErro.Message, "Erro")
1942:             loc_lResultado = .F.
1943:         ENDTRY
1944: 
1945:         RETURN loc_lResultado
1946:     ENDFUNC
1947: 
1948:     *==========================================================================
1949:     * CALCULAR PROXIMA ORDEM (retorna proximo Ordems disponivel)
1950:     *==========================================================================
1951: 
1952:     PROTECTED FUNCTION CalcularProximaOrdem()
1953:         LOCAL loc_cSQL, loc_nResult, loc_nOrdem
1954:         loc_nOrdem = 1
1955: 
1956:         TRY
1957:             loc_cSQL = "SELECT MAX(Ordems) + 1 AS ProxOrdem FROM SigCdMri" + ;
1958:                        " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos)
1959:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxOrdem")
1960:             IF loc_nResult >= 0 AND USED("cursor_4c_ProxOrdem") AND RECCOUNT("cursor_4c_ProxOrdem") > 0
1961:                 IF NOT ISNULL(cursor_4c_ProxOrdem.ProxOrdem)
1962:                     loc_nOrdem = cursor_4c_ProxOrdem.ProxOrdem
1963:                 ENDIF
1964:             ENDIF
1965:             IF USED("cursor_4c_ProxOrdem")
1966:                 USE IN cursor_4c_ProxOrdem
1967:             ENDIF
1968:         CATCH TO loException
1969:             MsgErro("Erro ao calcular ordem: " + loException.Message, "Erro")

*-- Linhas 2031 a 2468:
2031:         *-- Titulo obrigatorio e unico se Mapas=2
2032:         IF THIS.this_nMapas = 2
2033:             IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Titulo.Value))
2034:                 MsgAviso("T" + CHR(237) + "tulo N" + CHR(227) + "o Preenchido!", "Valida" + CHR(231) + CHR(227) + "o")
2035:                 loc_oPg2.txt_4c_Titulo.SetFocus()
2036:                 RETURN .F.
2037:             ENDIF
2038: 
2039:             loc_cTituloVal = ALLTRIM(loc_oPg2.txt_4c_Titulo.Value)
2040:             TRY
2041:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2042:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2043:                            " AND Titulos = " + EscaparSQL(loc_cTituloVal)
2044:                 loc_nResultTit = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupTit")
2045:                 IF loc_nResultTit >= 0 AND USED("cursor_4c_DupTit") AND RECCOUNT("cursor_4c_DupTit") > 0
2046:                     IF cursor_4c_DupTit.QTD > 0
2047:                         IF USED("cursor_4c_DupTit")
2048:                             USE IN cursor_4c_DupTit
2049:                         ENDIF
2050:                         MsgAviso("T" + CHR(237) + "tulo j" + CHR(225) + " utilizado!", "Valida" + CHR(231) + CHR(227) + "o")
2051:                         loc_oPg2.txt_4c_Titulo.SetFocus()
2052:                         loc_lResultado = .F.
2053:                     ENDIF
2054:                 ENDIF
2055:                 IF USED("cursor_4c_DupTit")
2056:                     USE IN cursor_4c_DupTit
2057:                 ENDIF
2058:             CATCH TO loException
2059:                 IF USED("cursor_4c_DupTit")
2060:                     USE IN cursor_4c_DupTit
2061:                 ENDIF
2062:                 MsgErro("Erro ao validar t" + CHR(237) + "tulo: " + loException.Message, "Erro")
2063:                 loc_lResultado = .F.
2064:             ENDTRY
2065: 
2066:             IF !loc_lResultado
2067:                 RETURN .F.
2068:             ENDIF
2069:         ENDIF
2070: 
2071:         *-- Validar Grupo (Tpregs=1)
2072:         IF loc_nTpregs = 1
2073:             IF EMPTY(loc_cGrupos)
2074:                 MsgAviso("Grupo inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2075:                 loc_oPg2.txt_4c__cd_grupos.SetFocus()
2076:                 RETURN .F.
2077:             ENDIF
2078: 
2079:             TRY
2080:                 loc_cSQL = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
2081:                            EscaparSQL(loc_cGrupos)
2082:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VGcr")
2083:                 IF loc_nResult >= 0 AND USED("cursor_4c_VGcr") AND RECCOUNT("cursor_4c_VGcr") > 0
2084:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VGcr.Descrs)
2085:                     loc_oBO.this_cClasses  = loc_cGrupos
2086:                     IF USED("cursor_4c_VGcr")
2087:                         USE IN cursor_4c_VGcr
2088:                     ENDIF
2089:                 ELSE
2090:                     IF USED("cursor_4c_VGcr")
2091:                         USE IN cursor_4c_VGcr
2092:                     ENDIF
2093:                     MsgAviso("Grupo Inv" + CHR(225) + "lido!", "Valida" + CHR(231) + CHR(227) + "o")
2094:                     loc_oPg2.txt_4c__cd_grupos.SetFocus()
2095:                     loc_lResultado = .F.
2096:                 ENDIF
2097:             CATCH TO loException
2098:                 IF USED("cursor_4c_VGcr")
2099:                     USE IN cursor_4c_VGcr
2100:                 ENDIF
2101:                 MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
2102:                 loc_lResultado = .F.
2103:             ENDTRY
2104: 
2105:             IF !loc_lResultado
2106:                 RETURN .F.
2107:             ENDIF
2108:         ENDIF
2109: 
2110:         *-- Validar Classe (Tpregs=3)
2111:         IF loc_nTpregs = 3
2112:             IF EMPTY(loc_cClasses)
2113:                 MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2114:                 loc_oPg2.txt_4c_Classe.SetFocus()
2115:                 RETURN .F.
2116:             ENDIF
2117: 
2118:             TRY
2119:                 loc_cSQL = "SELECT TOP 1 Classes, Descrs, Nivels FROM SigCdCss WHERE Classes = " + ;
2120:                            EscaparSQL(loc_cClasses)
2121:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VCss")
2122:                 IF loc_nResult >= 0 AND USED("cursor_4c_VCss") AND RECCOUNT("cursor_4c_VCss") > 0
2123:                     loc_oBO.this_cDescGrps = ALLTRIM(cursor_4c_VCss.Descrs)
2124:                     loc_oBO.this_nNivels   = cursor_4c_VCss.Nivels
2125:                     IF USED("cursor_4c_VCss")
2126:                         USE IN cursor_4c_VCss
2127:                     ENDIF
2128:                 ELSE
2129:                     IF USED("cursor_4c_VCss")
2130:                         USE IN cursor_4c_VCss
2131:                     ENDIF
2132:                     MsgAviso("Classe Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2133:                     loc_oPg2.txt_4c_Classe.SetFocus()
2134:                     loc_lResultado = .F.
2135:                 ENDIF
2136:             CATCH TO loException
2137:                 IF USED("cursor_4c_VCss")
2138:                     USE IN cursor_4c_VCss
2139:                 ENDIF
2140:                 MsgErro("Erro ao validar classe: " + loException.Message, "Erro")
2141:                 loc_lResultado = .F.
2142:             ENDTRY
2143: 
2144:             IF !loc_lResultado
2145:                 RETURN .F.
2146:             ENDIF
2147: 
2148:             TRY
2149:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2150:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2151:                            " AND Classes = " + EscaparSQL(loc_cClasses)
2152:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCls")
2153:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupCls") AND RECCOUNT("cursor_4c_DupCls") > 0
2154:                     IF cursor_4c_DupCls.QTD > 0
2155:                         IF USED("cursor_4c_DupCls")
2156:                             USE IN cursor_4c_DupCls
2157:                         ENDIF
2158:                         MsgAviso("Classe j" + CHR(225) + " cadastrada!!", "Valida" + CHR(231) + CHR(227) + "o")
2159:                         loc_oPg2.txt_4c_Classe.SetFocus()
2160:                         loc_lResultado = .F.
2161:                     ENDIF
2162:                 ENDIF
2163:                 IF USED("cursor_4c_DupCls")
2164:                     USE IN cursor_4c_DupCls
2165:                 ENDIF
2166:             CATCH TO loException
2167:                 MsgErro("Erro ao verificar duplicidade de classe: " + loException.Message, "Erro")
2168:                 loc_lResultado = .F.
2169:             ENDTRY
2170: 
2171:             IF !loc_lResultado
2172:                 RETURN .F.
2173:             ENDIF
2174:         ENDIF
2175: 
2176:         *-- Validar SubTotal (Tpregs=2)
2177:         IF loc_nTpregs = 2
2178:             IF EMPTY(loc_cDescGrps)
2179:                 MsgAviso("SubTotal Inv" + CHR(225) + "lido.", "Valida" + CHR(231) + CHR(227) + "o")
2180:                 loc_oPg2.txt_4c_Descgrps.SetFocus()
2181:                 RETURN .F.
2182:             ENDIF
2183: 
2184:             IF loc_nFator <> 100
2185:                 MsgAviso("Fator Inv" + CHR(225) + "lido", "Valida" + CHR(231) + CHR(227) + "o")
2186:                 loc_oPg2.txt_4c_Fator.Value = 100
2187:                 loc_oPg2.txt_4c_Fator.SetFocus()
2188:                 RETURN .F.
2189:             ENDIF
2190: 
2191:             loc_oBO.this_cClasses = "6"
2192: 
2193:             TRY
2194:                 loc_cSQL = "SELECT COUNT(*) AS QTD FROM SigCdMri" + ;
2195:                            " WHERE Balancos = " + EscaparSQL(THIS.this_cBalancos) + ;
2196:                            " AND DescGrps = " + EscaparSQL(loc_cDescGrps)
2197:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupSub")
2198:                 IF loc_nResult >= 0 AND USED("cursor_4c_DupSub") AND RECCOUNT("cursor_4c_DupSub") > 0
2199:                     IF cursor_4c_DupSub.QTD > 0
2200:                         IF USED("cursor_4c_DupSub")
2201:                             USE IN cursor_4c_DupSub
2202:                         ENDIF
2203:                         MsgAviso("SubTotal j" + CHR(225) + " Cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
2204:                         loc_oPg2.txt_4c_Descgrps.SetFocus()
2205:                         loc_lResultado = .F.
2206:                     ENDIF
2207:                 ENDIF
2208:                 IF USED("cursor_4c_DupSub")
2209:                     USE IN cursor_4c_DupSub
2210:                 ENDIF
2211:             CATCH TO loException
2212:                 MsgErro("Erro ao verificar SubTotal: " + loException.Message, "Erro")
2213:                 loc_lResultado = .F.
2214:             ENDTRY
2215: 
2216:             IF !loc_lResultado
2217:                 RETURN .F.
2218:             ENDIF
2219:         ENDIF
2220: 
2221:         *-- Validar Operacao selecionada
2222:         IF loc_nListIdx <= 0
2223:             MsgAviso("Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2224:             loc_oPg2.cbo_4c_Cmb_operacaos.SetFocus()
2225:             RETURN .F.
2226:         ENDIF
2227: 
2228:         *-- Validar Analiticos
2229:         IF NOT INLIST(loc_nAnaliticos, 1, 2)
2230:             MsgAviso("Op" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida!", "Valida" + CHR(231) + CHR(227) + "o")
2231:             loc_oPg2.obj_4c_Opt_analiticos.SetFocus()
2232:             RETURN .F.
2233:         ENDIF
2234: 
2235:         *-- Validar Fator (1-100, exceto SubTotal que exige 100 e ja foi validado)
2236:         IF loc_nTpregs <> 2
2237:             IF loc_nFator <= 0 OR loc_nFator > 100
2238:                 MsgAviso("Fator Inv" + CHR(225) + "lido!!", "Valida" + CHR(231) + CHR(227) + "o")
2239:                 loc_oPg2.txt_4c_Fator.Value = 100
2240:                 loc_oPg2.txt_4c_Fator.SetFocus()
2241:                 RETURN .F.
2242:             ENDIF
2243:         ENDIF
2244: 
2245:         *-- Auto-popular Nivels para Tpregs=1 via SigCdCss
2246:         IF loc_nTpregs = 1
2247:             TRY
2248:                 loc_cSQL = "SELECT TOP 1 Nivels FROM SigCdCss WHERE Classes = " + ;
2249:                            EscaparSQL(loc_oBO.this_cClasses)
2250:                 loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NivGrp")
2251:                 IF loc_nResult >= 0 AND USED("cursor_4c_NivGrp") AND RECCOUNT("cursor_4c_NivGrp") > 0
2252:                     loc_oBO.this_nNivels = cursor_4c_NivGrp.Nivels
2253:                 ELSE
2254:                     loc_oBO.this_nNivels = 0
2255:                 ENDIF
2256:                 IF USED("cursor_4c_NivGrp")
2257:                     USE IN cursor_4c_NivGrp
2258:                 ENDIF
2259:             CATCH TO loException
2260:                 MsgErro("Erro ao obter n" + CHR(237) + "vel: " + loException.Message, "Erro")
2261:             ENDTRY
2262:         ENDIF
2263: 
2264:         RETURN .T.
2265:     ENDFUNC
2266: 
2267:     *==========================================================================
2268:     * EVENTOS DOS BOTOES - todos PUBLIC para BINDEVENT
2269:     *==========================================================================
2270: 
2271:     PROCEDURE BtnIncluirClick()
2272:         LOCAL loc_oPg2, loc_nProxOrdem
2273:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2274: 
2275:         *-- Calcular AltSubtot para novo registro (sem DescGrps atual)
2276:         THIS.this_lAltSubtot = THIS.CalcularAltSubtot("")
2277: 
2278:         THIS.this_oBusinessObject.NovoRegistro()
2279:         THIS.LimparCampos()
2280: 
2281:         *-- Calcular e setar proxima ordem
2282:         loc_nProxOrdem = THIS.CalcularProximaOrdem()
2283:         loc_oPg2.txt_4c_Ordems.Value = loc_nProxOrdem
2284: 
2285:         THIS.this_cModoAtual = "INCLUIR"
2286:         THIS.HabilitarCampos(.T.)
2287:         THIS.AlternarPagina(2)
2288:         loc_oPg2.obj_4c_OptTpregs.SetFocus()
2289:     ENDPROC
2290: 
2291:     PROCEDURE BtnVisualizarClick()
2292:         LOCAL loc_cCidChaves
2293:         loc_cCidChaves = ""
2294: 
2295:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2296:             SELECT cursor_4c_Dados
2297:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2298:         ENDIF
2299: 
2300:         IF EMPTY(loc_cCidChaves)
2301:             MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
2302:             RETURN
2303:         ENDIF
2304: 
2305:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2306:             THIS.this_cCidChavesAtual = loc_cCidChaves
2307:             THIS.this_cModoAtual      = "VISUALIZAR"
2308:             THIS.BOParaForm()
2309:             THIS.HabilitarCampos(.F.)
2310:             THIS.AlternarPagina(2)
2311:         ENDIF
2312:     ENDPROC
2313: 
2314:     PROCEDURE BtnAlterarClick()
2315:         LOCAL loc_cCidChaves, loc_cDescGrpsAtual
2316:         loc_cCidChaves = ""
2317: 
2318:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2319:             SELECT cursor_4c_Dados
2320:             loc_cCidChaves     = ALLTRIM(cursor_4c_Dados.CidChaves)
2321:             loc_cDescGrpsAtual = ALLTRIM(cursor_4c_Dados.DescGrps)
2322:         ENDIF
2323: 
2324:         IF EMPTY(loc_cCidChaves)
2325:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
2326:             RETURN
2327:         ENDIF
2328: 
2329:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2330:             THIS.this_cCidChavesAtual = loc_cCidChaves
2331:             THIS.this_lAltSubtot      = THIS.CalcularAltSubtot(loc_cDescGrpsAtual)
2332:             THIS.this_oBusinessObject.EditarRegistro()
2333:             THIS.this_cModoAtual = "ALTERAR"
2334:             THIS.BOParaForm()
2335:             THIS.HabilitarCampos(.T.)
2336:             THIS.AlternarPagina(2)
2337:         ENDIF
2338:     ENDPROC
2339: 
2340:     PROCEDURE BtnExcluirClick()
2341:         LOCAL loc_cCidChaves, loc_lConfirma
2342:         loc_cCidChaves = ""
2343: 
2344:         IF USED("cursor_4c_Dados") AND NOT EOF("cursor_4c_Dados")
2345:             SELECT cursor_4c_Dados
2346:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.CidChaves)
2347:         ENDIF
2348: 
2349:         IF EMPTY(loc_cCidChaves)
2350:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2351:             RETURN
2352:         ENDIF
2353: 
2354:         loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro selecionado?", ;
2355:                                     "Confirmar Exclus" + CHR(227) + "o")
2356: 
2357:         IF loc_lConfirma
2358:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
2359:                 IF THIS.this_oBusinessObject.Excluir()
2360:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
2361:                     THIS.CarregarLista()
2362:                 ENDIF
2363:             ENDIF
2364:         ENDIF
2365:     ENDPROC
2366: 
2367:     PROCEDURE BtnBuscarClick()
2368:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2369:             GO TOP IN cursor_4c_Dados
2370:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2371:         ENDIF
2372:     ENDPROC
2373: 
2374:     PROCEDURE BtnEncerrarClick()
2375:         THIS.Release()
2376:     ENDPROC
2377: 
2378:     PROCEDURE BtnSalvarClick()
2379:         LOCAL loc_lSucesso
2380:         loc_lSucesso = .F.
2381: 
2382:         *-- Transferir campos do form para o BO
2383:         THIS.FormParaBO()
2384: 
2385:         *-- Validar e auto-popular campos derivados
2386:         IF NOT THIS.ValidarCampos()
2387:             RETURN
2388:         ENDIF
2389: 
2390:         TRY
2391:             IF THIS.this_oBusinessObject.Salvar()
2392:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
2393:                 THIS.AlternarPagina(1)
2394:                 loc_lSucesso = .T.
2395:             ENDIF
2396:         CATCH TO loException
2397:             MsgErro("Erro ao salvar: " + loException.Message, "Erro")
2398:         ENDTRY
2399:     ENDPROC
2400: 
2401:     PROCEDURE BtnCancelarClick()
2402:         THIS.AlternarPagina(1)
2403:     ENDPROC
2404: 
2405:     *==========================================================================
2406:     * DESTROY
2407:     *==========================================================================
2408: 
2409:     PROCEDURE Destroy()
2410:         LOCAL loc_lSucesso
2411:         loc_lSucesso = .F.
2412: 
2413:         TRY
2414:             IF USED("cursor_4c_Dados")
2415:                 USE IN cursor_4c_Dados
2416:             ENDIF
2417:             IF USED("cursor_4c_Carrega")
2418:                 USE IN cursor_4c_Carrega
2419:             ENDIF
2420:             IF USED("cursor_4c_Busca")
2421:                 USE IN cursor_4c_Busca
2422:             ENDIF
2423: 
2424:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2425:                 THIS.this_oBusinessObject = .NULL.
2426:             ENDIF
2427: 
2428:             loc_lSucesso = .T.
2429:         CATCH TO loException
2430:             MsgErro("Erro ao destruir FormCmr: " + loException.Message, "Erro")
2431:         ENDTRY
2432: 
2433:         DODEFAULT()
2434:         RETURN loc_lSucesso
2435:     ENDPROC
2436: 
2437:     *==========================================================================
2438:     * AUXILIARES
2439:     *==========================================================================
2440: 
2441:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2442:         LOCAL loc_nI, loc_oObjeto, loc_nP
2443:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2444:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2445:             IF VARTYPE(loc_oObjeto) = "O"
2446:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2447:                     loc_oObjeto.Visible = .T.
2448:                 ENDIF
2449:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2450:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2451:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2452:                     ENDFOR
2453:                 ENDIF
2454:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2455:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2456:                 ENDIF
2457:             ENDIF
2458:         ENDFOR
2459:     ENDPROC
2460: 
2461:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2462:         WITH par_oGrid
2463:             .FontName = "Tahoma"
2464:             .FontSize = 8
2465:         ENDWITH
2466:     ENDPROC
2467: 
2468: ENDDEFINE


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

