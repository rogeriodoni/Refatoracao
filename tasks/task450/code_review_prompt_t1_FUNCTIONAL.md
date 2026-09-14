# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [BINDEVENT-PARAMS] Handler 'ValidarMovs' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMovs(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIct.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1724 linhas total):

*-- Linhas 30 a 139:
30:     this_cModoAtual      = "LISTA"
31: 
32:     *====================================================================
33:     * Init - APENAS DODEFAULT (FormBase chama InicializarForm)
34:     *====================================================================
35:     PROCEDURE Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *====================================================================
40:     * InicializarForm - Inicializa BO e monta estrutura visual
41:     *====================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lResultado
44:         loc_lResultado = .F.
45: 
46:         TRY
47:             THIS.Caption = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
48: 
49:             THIS.this_oBusinessObject = CREATEOBJECT("IctBO")
50: 
51:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
52:                 MostrarErro("Erro ao criar IctBO", "FormIct.InicializarForm")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lResultado = .T.
66:             ENDIF
67:         CATCH TO loException
68:             MostrarErro("Erro ao inicializar FormIct:" + CHR(13) + loException.Message, "Erro")
69:         ENDTRY
70: 
71:         RETURN loc_lResultado
72:     ENDPROC
73: 
74:     *====================================================================
75:     * ConfigurarPageFrame - PageFrame principal com 2 paginas
76:     *====================================================================
77:     PROTECTED PROCEDURE ConfigurarPageFrame()
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         WITH THIS.pgf_4c_Paginas
80:             .Top       = -29
81:             .Left      = 0
82:             .Width     = THIS.Width
83:             .Height    = THIS.Height + 29
84:             .PageCount = 2
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             .Page1.Caption = "Lista"
89:             .Page1.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
90: 
91:             .Page2.Caption = "Dados"
92:             .Page2.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
93:         ENDWITH
94:     ENDPROC
95: 
96:     *====================================================================
97:     * ConfigurarPaginaLista - Page1: cabecalho, grid, botoes CRUD
98:     *====================================================================
99:     PROTECTED PROCEDURE ConfigurarPaginaLista()
100:         LOCAL loc_oPagina
101:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
102: 
103:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
104:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105: 
106:         *-- Cabecalho cinza (cntSombra legado) Top=1+29=30
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 30
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BackStyle   = 1
115:             .BorderWidth = 0
116:             .Visible     = .T.
117: 
118:             .AddObject("lbl_4c_Sombra", "Label")
119:             WITH .lbl_4c_Sombra
120:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
121:                 .Top       = 15
122:                 .Left      = 10
123:                 .Width     = THIS.Width
124:                 .Height    = 40
125:                 .AutoSize  = .F.
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .Caption   = "Tipo de Tributa" + CHR(231) + CHR(227) + "o do ICMS"
137:                 .Top       = 18
138:                 .Left      = 10
139:                 .Width     = THIS.Width

*-- Linhas 383 a 440:
383:             ENDWITH
384:         ENDWITH
385: 
386:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
391:         BINDEVENT(loc_oPagina.cmd_4c_Copiar,                    "Click", THIS, "BtnCopiarClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
393: 
394:         THIS.TornarControlesVisiveis(loc_oPagina)
395:     ENDPROC
396: 
397:     *====================================================================
398:     * ConfigurarPaginaDados - Page2: botoes Salvar/Cancelar e container dados
399:     *====================================================================
400:     PROTECTED PROCEDURE ConfigurarPaginaDados()
401:         LOCAL loc_oPagina, loc_oCnt
402:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
403: 
404:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
405:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
406: 
407:         *-- Container Salvar/Cancelar (grupo_salva legado) Top=-4+29=25
408:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
409:         WITH loc_oPagina.cnt_4c_Salva
410:             .Top         = 25
411:             .Left        = 837
412:             .Width       = 161
413:             .Height      = 85
414:             .BackStyle   = 0
415:             .BorderWidth = 0
416:             .Visible     = .T.
417: 
418:             .AddObject("cmd_4c_Confirmar", "CommandButton")
419:             WITH .cmd_4c_Confirmar
420:                 .Caption         = "Confirmar"
421:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
422:                 .PicturePosition = 13
423:                 .Top             = 5
424:                 .Left            = 5
425:                 .Width           = 75
426:                 .Height          = 75
427:                 .FontName        = "Comic Sans MS"
428:                 .FontBold        = .T.
429:                 .FontItalic      = .T.
430:                 .FontSize        = 8
431:                 .ForeColor       = RGB(90, 90, 90)
432:                 .BackColor       = RGB(255, 255, 255)
433:                 .SpecialEffect   = 0
434:                 .MousePointer    = 15
435:                 .WordWrap        = .T.
436:                 .Visible         = .T.
437:             ENDWITH
438: 
439:             .AddObject("cmd_4c_Cancelar", "CommandButton")
440:             WITH .cmd_4c_Cancelar

*-- Linhas 790 a 857:
790:             .Visible  = .T.
791:         ENDWITH
792: 
793:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
794:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
795: 
796:         *-- Lookups: F4 e DblClick para campos com busca auxiliar
797:         BINDEVENT(loc_oCnt.txt_4c_CFOP,     "KeyPress", THIS, "CFOPKeyPress")
798:         BINDEVENT(loc_oCnt.txt_4c_CFOP,     "DblClick",  THIS, "CFOPDblClick")
799:         BINDEVENT(loc_oCnt.txt_4c_DCFOP,    "KeyPress", THIS, "DCFOPKeyPress")
800:         BINDEVENT(loc_oCnt.txt_4c_DCFOP,    "DblClick",  THIS, "DCFOPDblClick")
801:         BINDEVENT(loc_oCnt.txt_4c_Origem,   "KeyPress", THIS, "OrigemKeyPress")
802:         BINDEVENT(loc_oCnt.txt_4c_Origem,   "DblClick",  THIS, "OrigemDblClick")
803:         BINDEVENT(loc_oCnt.txt_4c_DOrigem,  "KeyPress", THIS, "DOrigemKeyPress")
804:         BINDEVENT(loc_oCnt.txt_4c_DOrigem,  "DblClick",  THIS, "DOrigemDblClick")
805:         BINDEVENT(loc_oCnt.txt_4c_Destino,  "KeyPress", THIS, "DestinoKeyPress")
806:         BINDEVENT(loc_oCnt.txt_4c_Destino,  "DblClick",  THIS, "DestinoDblClick")
807:         BINDEVENT(loc_oCnt.txt_4c_DDestino, "KeyPress", THIS, "DDestinoKeyPress")
808:         BINDEVENT(loc_oCnt.txt_4c_DDestino, "DblClick",  THIS, "DDestinoDblClick")
809:         BINDEVENT(loc_oCnt.txt_4c_Movs,     "KeyPress", THIS, "ValidarMovs")
810: 
811:         THIS.TornarControlesVisiveis(loc_oPagina)
812:     ENDPROC
813: 
814:     *====================================================================
815:     * CarregarLista - Busca registros e vincula ao Grid
816:     *====================================================================
817:     PROCEDURE CarregarLista()
818:         LOCAL loc_lResultado, loc_oGrid
819:         loc_lResultado = .F.
820: 
821:         TRY
822:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
823:                 loc_lResultado = .T.
824:             ELSE
825:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
826:                 IF THIS.this_oBusinessObject.Buscar("")
827:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
828: 
829:                     loc_oGrid.ColumnCount = 13
830:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
831: 
832:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.Tipos"
833:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.Descs"
834:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.Movs"
835:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.CFOPs"
836:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.CFOPd"
837:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.Origems"
838:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.Origemd"
839:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.Destinos"
840:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.Destinod"
841:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.Aliquotas"
842:                     loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.Bases"
843:                     loc_oGrid.Column12.ControlSource = "cursor_4c_Dados.Reduzidas"
844:                     loc_oGrid.Column13.ControlSource = "cursor_4c_Dados.aliqicmsts"
845: 
846:                     *-- Reconfirmar headers e widths apos RecordSource (auto-bind reseta)
847:                     loc_oGrid.Column1.Width            = 50
848:                     loc_oGrid.Column1.Header1.Caption  = "Tipo"
849:                     loc_oGrid.Column2.Width            = 90
850:                     loc_oGrid.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
851:                     loc_oGrid.Column3.Width            = 35
852:                     loc_oGrid.Column3.Header1.Caption  = "Mov"
853:                     loc_oGrid.Column4.Width            = 60
854:                     loc_oGrid.Column4.Header1.Caption  = "CFOP"
855:                     loc_oGrid.Column5.Width            = 160
856:                     loc_oGrid.Column5.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o CFOP"
857:                     loc_oGrid.Column6.Width            = 35

*-- Linhas 891 a 1724:
891:     *====================================================================
892:     * AlternarPagina - Alterna entre Page1 (1) e Page2 (2)
893:     *====================================================================
894:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
895:         LOCAL loc_lResultado
896:         loc_lResultado = .F.
897: 
898:         TRY
899:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
900:                 loc_lResultado = .F.
901:             ELSE
902:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
903:                 IF par_nPagina = 1
904:                     THIS.this_cModoAtual = "LISTA"
905:                     THIS.CarregarLista()
906:                 ENDIF
907:                 loc_lResultado = .T.
908:             ENDIF
909:         CATCH TO loException
910:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
911:                 loException.Message, "FormIct.AlternarPagina")
912:         ENDTRY
913: 
914:         RETURN loc_lResultado
915:     ENDPROC
916: 
917:     *====================================================================
918:     * BtnIncluirClick
919:     *====================================================================
920:     PROCEDURE BtnIncluirClick()
921:         TRY
922:             THIS.this_oBusinessObject.NovoRegistro()
923:             THIS.LimparCampos()
924:             THIS.this_cModoAtual = "INCLUIR"
925:             THIS.HabilitarCampos(.T.)
926:             THIS.AjustarBotoesPorModo()
927:             THIS.AlternarPagina(2)
928:         CATCH TO loException
929:             MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, ;
930:                 "FormIct.BtnIncluirClick")
931:         ENDTRY
932:     ENDPROC
933: 
934:     *====================================================================
935:     * BtnVisualizarClick
936:     *====================================================================
937:     PROCEDURE BtnVisualizarClick()
938:         LOCAL loc_cCidChaves
939:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
940:             MsgAviso("Selecione um registro para visualizar!")
941:             RETURN
942:         ENDIF
943:         TRY
944:             SELECT cursor_4c_Dados
945:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
946:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
947:                 THIS.this_cModoAtual = "VISUALIZAR"
948:                 THIS.BOParaForm()
949:                 THIS.HabilitarCampos(.F.)
950:                 THIS.AjustarBotoesPorModo()
951:                 THIS.AlternarPagina(2)
952:             ENDIF
953:         CATCH TO loException
954:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, ;
955:                 "FormIct.BtnVisualizarClick")
956:         ENDTRY
957:     ENDPROC
958: 
959:     *====================================================================
960:     * BtnAlterarClick
961:     *====================================================================
962:     PROCEDURE BtnAlterarClick()
963:         LOCAL loc_cCidChaves
964:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
965:             MsgAviso("Selecione um registro para alterar!")
966:             RETURN
967:         ENDIF
968:         TRY
969:             SELECT cursor_4c_Dados
970:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
971:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
972:                 THIS.this_oBusinessObject.EditarRegistro()
973:                 THIS.this_cModoAtual = "ALTERAR"
974:                 THIS.BOParaForm()
975:                 THIS.HabilitarCampos(.T.)
976:                 THIS.AjustarBotoesPorModo()
977:                 THIS.AlternarPagina(2)
978:             ENDIF
979:         CATCH TO loException
980:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, ;
981:                 "FormIct.BtnAlterarClick")
982:         ENDTRY
983:     ENDPROC
984: 
985:     *====================================================================
986:     * BtnExcluirClick
987:     *====================================================================
988:     PROCEDURE BtnExcluirClick()
989:         LOCAL loc_cCidChaves, loc_lConfirmado
990:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
991:             MsgAviso("Selecione um registro para excluir!")
992:             RETURN
993:         ENDIF
994:         TRY
995:             SELECT cursor_4c_Dados
996:             loc_cCidChaves  = ALLTRIM(cursor_4c_Dados.cidchaves)
997:             loc_lConfirmado = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", ;
998:                 "Excluir Tributa" + CHR(231) + CHR(227) + "o ICMS")
999:             IF loc_lConfirmado
1000:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1001:                     IF THIS.this_oBusinessObject.Excluir()
1002:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1003:                         THIS.CarregarLista()
1004:                     ENDIF
1005:                 ENDIF
1006:             ENDIF
1007:         CATCH TO loException
1008:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
1009:                 "FormIct.BtnExcluirClick")
1010:         ENDTRY
1011:     ENDPROC
1012: 
1013:     *====================================================================
1014:     * BtnBuscarClick
1015:     *====================================================================
1016:     PROCEDURE BtnBuscarClick()
1017:         TRY
1018:             THIS.LimparCampos()
1019:             THIS.this_cModoAtual = "BUSCAR"
1020:             THIS.HabilitarCampos(.T.)
1021:             THIS.AjustarBotoesPorModo()
1022:             THIS.AlternarPagina(2)
1023:         CATCH TO loException
1024:             MostrarErro("Erro ao abrir busca:" + CHR(13) + loException.Message, ;
1025:                 "FormIct.BtnBuscarClick")
1026:         ENDTRY
1027:     ENDPROC
1028: 
1029:     *====================================================================
1030:     * BtnCopiarClick - Copia registro selecionado como novo (Command1 legado)
1031:     *====================================================================
1032:     PROCEDURE BtnCopiarClick()
1033:         LOCAL loc_cCidChaves
1034:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1035:             MsgAviso("Selecione um registro para copiar!")
1036:             RETURN
1037:         ENDIF
1038:         TRY
1039:             SELECT cursor_4c_Dados
1040:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1041:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1042:                 THIS.this_oBusinessObject.NovoRegistro()
1043:                 THIS.this_cModoAtual = "INCLUIR"
1044:                 THIS.BOParaForm()
1045:                 THIS.HabilitarCampos(.T.)
1046:                 THIS.AjustarBotoesPorModo()
1047:                 THIS.AlternarPagina(2)
1048:             ENDIF
1049:         CATCH TO loException
1050:             MostrarErro("Erro ao copiar:" + CHR(13) + loException.Message, ;
1051:                 "FormIct.BtnCopiarClick")
1052:         ENDTRY
1053:     ENDPROC
1054: 
1055:     *====================================================================
1056:     * BtnEncerrarClick
1057:     *====================================================================
1058:     PROCEDURE BtnEncerrarClick()
1059:         THIS.Release()
1060:     ENDPROC
1061: 
1062:     *====================================================================
1063:     * BtnSalvarClick
1064:     *====================================================================
1065:     PROCEDURE BtnSalvarClick()
1066:         TRY
1067:             IF THIS.this_cModoAtual = "BUSCAR"
1068:                 THIS.FormParaBO()
1069:                 THIS.ExecutarBusca()
1070:             ELSE
1071:                 IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1072:                 IF THIS.FormParaBO()
1073:                     IF THIS.this_oBusinessObject.Salvar()
1074:                         MsgInfo("Registro salvo com sucesso!")
1075:                         THIS.AlternarPagina(1)
1076:                     ENDIF
1077:                 ENDIF
1078:             ELSE
1079:                 THIS.AlternarPagina(1)
1080:                 ENDIF
1081:             ENDIF
1082:         CATCH TO loException
1083:             MostrarErro("Erro ao confirmar:" + CHR(13) + loException.Message, ;
1084:                 "FormIct.BtnSalvarClick")
1085:         ENDTRY
1086:     ENDPROC
1087: 
1088:     *====================================================================
1089:     * BtnCancelarClick - Volta para Page1
1090:     *====================================================================
1091:     PROCEDURE BtnCancelarClick()
1092:         LOCAL loc_lResultado
1093:         loc_lResultado = .F.
1094:         TRY
1095:             THIS.AlternarPagina(1)
1096:             loc_lResultado = .T.
1097:         CATCH TO loException
1098:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, ;
1099:                 "FormIct.BtnCancelarClick")
1100:         ENDTRY
1101:         RETURN loc_lResultado
1102:     ENDPROC
1103: 
1104:     *====================================================================
1105:     * FormParaBO - Transfere Form -> BO
1106:     *====================================================================
1107:     PROCEDURE FormParaBO()
1108:         LOCAL loc_lResultado, loc_oCnt
1109:         loc_lResultado = .F.
1110:         TRY
1111:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1112:             WITH THIS.this_oBusinessObject
1113:                 .this_cTipos      = UPPER(ALLTRIM(loc_oCnt.txt_4c_Tipo.Value))
1114:                 .this_cDescs      = ALLTRIM(loc_oCnt.txt_4c_Desc.Value)
1115:                 .this_cCfops      = ALLTRIM(loc_oCnt.txt_4c_CFOP.Value)
1116:                 .this_cCfopd      = ALLTRIM(loc_oCnt.txt_4c_DCFOP.Value)
1117:                 .this_cOrigems    = UPPER(ALLTRIM(loc_oCnt.txt_4c_Origem.Value))
1118:                 .this_cOrigemd    = ALLTRIM(loc_oCnt.txt_4c_DOrigem.Value)
1119:                 .this_cDestinos   = UPPER(ALLTRIM(loc_oCnt.txt_4c_Destino.Value))
1120:                 .this_cDestinoD   = ALLTRIM(loc_oCnt.txt_4c_DDestino.Value)
1121:                 .this_cMovs       = UPPER(ALLTRIM(loc_oCnt.txt_4c_Movs.Value))
1122:                 .this_nAliquotas  = loc_oCnt.txt_4c_Aliquota.Value
1123:                 .this_nBases      = loc_oCnt.txt_4c_Base.Value
1124:                 .this_nReduzidas  = loc_oCnt.txt_4c_Reduz.Value
1125:                 .this_nAliqicmsts = loc_oCnt.txt_4c_Subst.Value
1126:             ENDWITH
1127:             loc_lResultado = .T.
1128:         CATCH TO loException
1129:             MostrarErro("Erro ao transferir dados:" + CHR(13) + loException.Message, ;
1130:                 "FormIct.FormParaBO")
1131:         ENDTRY
1132:         RETURN loc_lResultado
1133:     ENDPROC
1134: 
1135:     *====================================================================
1136:     * BOParaForm - Transfere BO -> Form
1137:     *====================================================================
1138:     PROCEDURE BOParaForm()
1139:         LOCAL loc_lResultado, loc_oCnt
1140:         loc_lResultado = .F.
1141:         TRY
1142:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1143:             WITH THIS.this_oBusinessObject
1144:                 loc_oCnt.txt_4c_Tipo.Value     = ALLTRIM(.this_cTipos)
1145:                 loc_oCnt.txt_4c_Desc.Value     = ALLTRIM(.this_cDescs)
1146:                 loc_oCnt.txt_4c_CFOP.Value     = ALLTRIM(.this_cCfops)
1147:                 loc_oCnt.txt_4c_DCFOP.Value    = ALLTRIM(.this_cCfopd)
1148:                 loc_oCnt.txt_4c_Origem.Value   = ALLTRIM(.this_cOrigems)
1149:                 loc_oCnt.txt_4c_DOrigem.Value  = ALLTRIM(.this_cOrigemd)
1150:                 loc_oCnt.txt_4c_Destino.Value  = ALLTRIM(.this_cDestinos)
1151:                 loc_oCnt.txt_4c_DDestino.Value = ALLTRIM(.this_cDestinoD)
1152:                 loc_oCnt.txt_4c_Movs.Value     = ALLTRIM(.this_cMovs)
1153:                 loc_oCnt.txt_4c_Aliquota.Value = .this_nAliquotas
1154:                 loc_oCnt.txt_4c_Base.Value     = .this_nBases
1155:                 loc_oCnt.txt_4c_Reduz.Value    = .this_nReduzidas
1156:                 loc_oCnt.txt_4c_Subst.Value    = .this_nAliqicmsts
1157:             ENDWITH
1158:             loc_lResultado = .T.
1159:         CATCH TO loException
1160:             MostrarErro("Erro ao popular campos:" + CHR(13) + loException.Message, ;
1161:                 "FormIct.BOParaForm")
1162:         ENDTRY
1163:         RETURN loc_lResultado
1164:     ENDPROC
1165: 
1166:     *====================================================================
1167:     * ExecutarBusca - Executa busca com filtro construido dos campos BO
1168:     *====================================================================
1169:     PROTECTED PROCEDURE ExecutarBusca()
1170:         LOCAL loc_cFiltro, loc_cTipos, loc_cDescs, loc_cCfops, loc_cOrigems, loc_cDestinos
1171:         loc_cFiltro   = ""
1172:         loc_cTipos    = ALLTRIM(THIS.this_oBusinessObject.this_cTipos)
1173:         loc_cDescs    = ALLTRIM(THIS.this_oBusinessObject.this_cDescs)
1174:         loc_cCfops    = ALLTRIM(THIS.this_oBusinessObject.this_cCfops)
1175:         loc_cOrigems  = ALLTRIM(THIS.this_oBusinessObject.this_cOrigems)
1176:         loc_cDestinos = ALLTRIM(THIS.this_oBusinessObject.this_cDestinos)
1177: 
1178:         TRY
1179:             IF !EMPTY(loc_cTipos)
1180:                 loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
1181:                     "a.Tipos = " + EscaparSQL(loc_cTipos)
1182:             ENDIF
1183:             IF !EMPTY(loc_cDescs)
1184:                 loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
1185:                     "a.Descs LIKE " + EscaparSQL("%" + loc_cDescs + "%")
1186:             ENDIF
1187:             IF !EMPTY(loc_cCfops)
1188:                 loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
1189:                     "a.CFOPs = " + EscaparSQL(loc_cCfops)
1190:             ENDIF
1191:             IF !EMPTY(loc_cOrigems)
1192:                 loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
1193:                     "a.Origems = " + EscaparSQL(loc_cOrigems)
1194:             ENDIF
1195:             IF !EMPTY(loc_cDestinos)
1196:                 loc_cFiltro = loc_cFiltro + IIF(EMPTY(loc_cFiltro),"","AND ") + ;
1197:                     "a.Destinos = " + EscaparSQL(loc_cDestinos)
1198:             ENDIF
1199:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1200:                 THIS.AlternarPagina(1)
1201:             ENDIF
1202:         CATCH TO loException
1203:             MostrarErro("Erro ao executar busca:" + CHR(13) + loException.Message, ;
1204:                 "FormIct.ExecutarBusca")
1205:         ENDTRY
1206:     ENDPROC
1207: 
1208:     *====================================================================
1209:     * HabilitarCampos - Controle ReadOnly por campo conforme modo
1210:     * INCLUIR:     PK + desc + numericos editaveis
1211:     * ALTERAR:     apenas numericos editaveis (PK e desc bloqueados)
1212:     * BUSCAR:      PK + desc + numericos editaveis, exceto Movs (only INSERIR legado)
1213:     * VISUALIZAR:  todos ReadOnly
1214:     *====================================================================
1215:     PROCEDURE HabilitarCampos(par_lHabilitar)
1216:         LOCAL loc_oPg2, loc_oCnt, loc_lIncluir, loc_lAlterar, loc_lBuscar
1217:         TRY
1218:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1219:             loc_oCnt    = loc_oPg2.cnt_4c_Container1
1220:             loc_lIncluir = par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR"
1221:             loc_lAlterar = par_lHabilitar AND THIS.this_cModoAtual = "ALTERAR"
1222:             loc_lBuscar  = par_lHabilitar AND THIS.this_cModoAtual = "BUSCAR"
1223: 
1224:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
1225: 
1226:             *-- Campos PK: editaveis em INCLUIR e BUSCAR (exceto Movs que e so INCLUIR)
1227:             loc_oCnt.txt_4c_Tipo.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
1228:             loc_oCnt.txt_4c_CFOP.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
1229:             loc_oCnt.txt_4c_Origem.ReadOnly  = !(loc_lIncluir OR loc_lBuscar)
1230:             loc_oCnt.txt_4c_Destino.ReadOnly = !(loc_lIncluir OR loc_lBuscar)
1231:             loc_oCnt.txt_4c_Movs.ReadOnly    = !loc_lIncluir
1232: 
1233:             *-- Desc: legado When = INSERIR|PROCURAR (lock em ALTERAR)
1234:             loc_oCnt.txt_4c_Desc.ReadOnly    = !(loc_lIncluir OR loc_lBuscar)
1235: 
1236:             *-- Numericos: sem When no legado - editaveis em qualquer modo de edicao
1237:             loc_oCnt.txt_4c_Aliquota.ReadOnly = !par_lHabilitar
1238:             loc_oCnt.txt_4c_Base.ReadOnly     = !par_lHabilitar
1239:             loc_oCnt.txt_4c_Reduz.ReadOnly    = !par_lHabilitar
1240:             loc_oCnt.txt_4c_Subst.ReadOnly    = !par_lHabilitar
1241: 
1242:             *-- Campos desc de lookup: editaveis em INCLUIR (When legado = INSERIR AND Empty(codigo))
1243:             loc_oCnt.txt_4c_DCFOP.ReadOnly    = !loc_lIncluir
1244:             loc_oCnt.txt_4c_DOrigem.ReadOnly  = !loc_lIncluir
1245:             loc_oCnt.txt_4c_DDestino.ReadOnly = !loc_lIncluir
1246:         CATCH TO loException
1247:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, ;
1248:                 "FormIct.HabilitarCampos")
1249:         ENDTRY
1250:     ENDPROC
1251: 
1252:     *====================================================================
1253:     * LimparCampos - Zera propriedades do BO e campos visuais de Page2
1254:     *====================================================================
1255:     PROCEDURE LimparCampos()
1256:         LOCAL loc_oCnt
1257:         TRY
1258:             WITH THIS.this_oBusinessObject
1259:                 .this_cCidChaves  = ""
1260:                 .this_cTipos      = ""
1261:                 .this_cDescs      = ""
1262:                 .this_cCfops      = ""
1263:                 .this_cOrigems    = ""
1264:                 .this_cDestinos   = ""
1265:                 .this_cMovs       = ""
1266:                 .this_nAliquotas  = 0
1267:                 .this_nBases      = 0
1268:                 .this_nReduzidas  = 0
1269:                 .this_nAliqicmsts = 0
1270:                 .this_cOrigemd    = ""
1271:                 .this_cDestinoD   = ""
1272:                 .this_cCfopd      = ""
1273:             ENDWITH
1274:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1275:             loc_oCnt.txt_4c_Tipo.Value     = ""
1276:             loc_oCnt.txt_4c_Desc.Value     = ""
1277:             loc_oCnt.txt_4c_CFOP.Value     = ""
1278:             loc_oCnt.txt_4c_DCFOP.Value    = ""
1279:             loc_oCnt.txt_4c_Origem.Value   = ""
1280:             loc_oCnt.txt_4c_DOrigem.Value  = ""
1281:             loc_oCnt.txt_4c_Destino.Value  = ""
1282:             loc_oCnt.txt_4c_DDestino.Value = ""
1283:             loc_oCnt.txt_4c_Movs.Value     = ""
1284:             loc_oCnt.txt_4c_Aliquota.Value = 0
1285:             loc_oCnt.txt_4c_Base.Value     = 0
1286:             loc_oCnt.txt_4c_Reduz.Value    = 0
1287:             loc_oCnt.txt_4c_Subst.Value    = 0
1288:         CATCH TO loException
1289:             MostrarErro("Erro ao limpar campos:" + CHR(13) + loException.Message, ;
1290:                 "FormIct.LimparCampos")
1291:         ENDTRY
1292:     ENDPROC
1293: 
1294:     *====================================================================
1295:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1296:     *====================================================================
1297:     PROCEDURE AjustarBotoesPorModo()
1298:         LOCAL loc_oPg2, loc_lEditar
1299:         TRY
1300:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1301:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1302: 
1303:             WITH loc_oPg2.cnt_4c_Salva
1304:                 .cmd_4c_Confirmar.Enabled = loc_lEditar
1305:                 .cmd_4c_Cancelar.Enabled  = .T.
1306:                 .Visible     = .T.
1307:             ENDWITH
1308:         CATCH TO loException
1309:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + ;
1310:                 loException.Message, "FormIct.AjustarBotoesPorModo")
1311:         ENDTRY
1312:     ENDPROC
1313: 
1314:     *====================================================================
1315:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1316:     *====================================================================
1317:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1318:         LOCAL loc_nI, loc_oObjeto, loc_nP
1319: 
1320:         IF VARTYPE(par_oContainer) != "O"
1321:             RETURN
1322:         ENDIF
1323: 
1324:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1325:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1326:             IF VARTYPE(loc_oObjeto) = "O"
1327:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1328:                     loc_oObjeto.Visible = .T.
1329:                 ENDIF
1330:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1331:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1332:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1333:                     ENDFOR
1334:                 ENDIF
1335:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1336:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1337:                 ENDIF
1338:             ENDIF
1339:         ENDFOR
1340:     ENDPROC
1341: 
1342:     *====================================================================
1343:     * FormatarGridLista - Aplica formatacao visual ao Grid
1344:     *====================================================================
1345:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1346:         IF VARTYPE(par_oGrid) != "O"
1347:             RETURN
1348:         ENDIF
1349:         WITH par_oGrid
1350:             .FontName = "Tahoma"
1351:             .FontSize = 8
1352:         ENDWITH
1353:     ENDPROC
1354: 
1355:     *====================================================================
1356:     * Destroy - Libera recursos
1357:     *====================================================================
1358:     PROCEDURE Destroy()
1359:         LOCAL loc_oErro
1360:         TRY
1361:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1362:                 THIS.this_oBusinessObject = .NULL.
1363:             ENDIF
1364:             IF USED("cursor_4c_Dados")
1365:                 USE IN cursor_4c_Dados
1366:             ENDIF
1367:         CATCH TO loc_oErro
1368:             MostrarErro(loc_oErro.Message, "FormIct.Destroy")
1369:         ENDTRY
1370:         DODEFAULT()
1371:     ENDPROC
1372: 
1373:     *====================================================================
1374:     * CFOPKeyPress / CFOPDblClick - F4 ou duplo-clique em CFOP (codigo)
1375:     *====================================================================
1376:     PROCEDURE CFOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1377:         IF par_nKeyCode = 28
1378:             THIS.AbrirLookupCFOP()
1379:         ENDIF
1380:     ENDPROC
1381: 
1382:     PROCEDURE CFOPDblClick()
1383:         THIS.AbrirLookupCFOP()
1384:     ENDPROC
1385: 
1386:     *====================================================================
1387:     * AbrirLookupCFOP - Busca por codigo em SigCdCfo
1388:     * Preenche txt_4c_CFOP (Codigos) e txt_4c_DCFOP (Descricaos)
1389:     *====================================================================
1390:     PROCEDURE AbrirLookupCFOP()
1391:         LOCAL loc_oCnt, loc_oBusca, loc_cCodigo, loc_cDescricao
1392:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1393:         IF VARTYPE(loc_oCnt) != "O"
1394:             RETURN
1395:         ENDIF
1396:         IF loc_oCnt.txt_4c_CFOP.ReadOnly
1397:             RETURN
1398:         ENDIF
1399: 
1400:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1401:             "SigCdCfo", "cursor_4c_BuscaCFOP", "Codigos", ;
1402:             ALLTRIM(loc_oCnt.txt_4c_CFOP.Value), ;
1403:             "Buscar C.F.O.P.")
1404: 
1405:         IF VARTYPE(loc_oBusca) = "O"
1406:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1407:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1408:             loc_oBusca.Show()
1409: 
1410:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFOP")
1411:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCFOP.Codigos)
1412:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCFOP.Descricaos)
1413:                 loc_oCnt.txt_4c_CFOP.Value  = loc_cCodigo
1414:                 loc_oCnt.txt_4c_DCFOP.Value = loc_cDescricao
1415:             ENDIF
1416: 
1417:             loc_oBusca.Release()
1418:         ENDIF
1419: 
1420:         IF USED("cursor_4c_BuscaCFOP")
1421:             USE IN cursor_4c_BuscaCFOP
1422:         ENDIF
1423:     ENDPROC
1424: 
1425:     *====================================================================
1426:     * DCFOPKeyPress / DCFOPDblClick - F4 ou duplo-clique em DCFOP (descricao)
1427:     * Ativo apenas em INCLUIR quando CFOP estiver vazio (When legado)
1428:     *====================================================================
1429:     PROCEDURE DCFOPKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1430:         IF par_nKeyCode = 28
1431:             THIS.AbrirLookupDCFOP()
1432:         ENDIF
1433:     ENDPROC
1434: 
1435:     PROCEDURE DCFOPDblClick()
1436:         THIS.AbrirLookupDCFOP()
1437:     ENDPROC
1438: 
1439:     *====================================================================
1440:     * AbrirLookupDCFOP - Busca por descricao em SigCdCfo
1441:     * Ativo apenas em INCLUIR e com CFOP vazio (When legado)
1442:     * Preenche txt_4c_CFOP (Codigos) e txt_4c_DCFOP (Descricaos)
1443:     *====================================================================
1444:     PROCEDURE AbrirLookupDCFOP()
1445:         LOCAL loc_oCnt, loc_oBusca, loc_cCodigo, loc_cDescricao
1446:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1447:         IF VARTYPE(loc_oCnt) != "O"
1448:             RETURN
1449:         ENDIF
1450:         IF loc_oCnt.txt_4c_DCFOP.ReadOnly
1451:             RETURN
1452:         ENDIF
1453:         *-- Guardia: When legado = INSERIR AND Empty(GetCFOP)
1454:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_CFOP.Value))
1455:             RETURN
1456:         ENDIF
1457: 
1458:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1459:             "SigCdCfo", "cursor_4c_BuscaCFOP", "Descricaos", ;
1460:             ALLTRIM(loc_oCnt.txt_4c_DCFOP.Value), ;
1461:             "Buscar C.F.O.P. por Descri" + CHR(231) + CHR(227) + "o")
1462: 
1463:         IF VARTYPE(loc_oBusca) = "O"
1464:             loc_oBusca.mAddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1465:             loc_oBusca.mAddColuna("Codigos",    "", "C" + CHR(243) + "digo")
1466:             loc_oBusca.Show()
1467: 
1468:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCFOP")
1469:                 loc_cCodigo    = ALLTRIM(cursor_4c_BuscaCFOP.Codigos)
1470:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaCFOP.Descricaos)
1471:                 loc_oCnt.txt_4c_CFOP.Value  = loc_cCodigo
1472:                 loc_oCnt.txt_4c_DCFOP.Value = loc_cDescricao
1473:             ENDIF
1474: 
1475:             loc_oBusca.Release()
1476:         ENDIF
1477: 
1478:         IF USED("cursor_4c_BuscaCFOP")
1479:             USE IN cursor_4c_BuscaCFOP
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *====================================================================
1484:     * OrigemKeyPress / OrigemDblClick - F4 ou duplo-clique em Origem (codigo UF)
1485:     *====================================================================
1486:     PROCEDURE OrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1487:         IF par_nKeyCode = 28
1488:             THIS.AbrirLookupOrigem()
1489:         ENDIF
1490:     ENDPROC
1491: 
1492:     PROCEDURE OrigemDblClick()
1493:         THIS.AbrirLookupOrigem()
1494:     ENDPROC
1495: 
1496:     *====================================================================
1497:     * AbrirLookupOrigem - Busca por codigo de UF em SigCdUfs
1498:     * Preenche txt_4c_Origem (Estados) e txt_4c_DOrigem (Descrs)
1499:     *====================================================================
1500:     PROCEDURE AbrirLookupOrigem()
1501:         LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
1502:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1503:         IF VARTYPE(loc_oCnt) != "O"
1504:             RETURN
1505:         ENDIF
1506:         IF loc_oCnt.txt_4c_Origem.ReadOnly
1507:             RETURN
1508:         ENDIF
1509: 
1510:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1511:             "SigCdUfs", "cursor_4c_BuscaUF", "Estados", ;
1512:             ALLTRIM(loc_oCnt.txt_4c_Origem.Value), ;
1513:             "Estado Origem")
1514: 
1515:         IF VARTYPE(loc_oBusca) = "O"
1516:             loc_oBusca.mAddColuna("Estados", "", "UF")
1517:             loc_oBusca.mAddColuna("Descrs",  "", "Estado")
1518:             loc_oBusca.Show()
1519: 
1520:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
1521:                 loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
1522:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
1523:                 loc_oCnt.txt_4c_Origem.Value  = loc_cEstado
1524:                 loc_oCnt.txt_4c_DOrigem.Value = loc_cDescricao
1525:             ENDIF
1526: 
1527:             loc_oBusca.Release()
1528:         ENDIF
1529: 
1530:         IF USED("cursor_4c_BuscaUF")
1531:             USE IN cursor_4c_BuscaUF
1532:         ENDIF
1533:     ENDPROC
1534: 
1535:     *====================================================================
1536:     * DOrigemKeyPress / DOrigemDblClick - F4 ou duplo-clique em DOrigem (nome do estado)
1537:     * Ativo apenas em INCLUIR quando Origem estiver vazio (When legado)
1538:     *====================================================================
1539:     PROCEDURE DOrigemKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1540:         IF par_nKeyCode = 28
1541:             THIS.AbrirLookupDOrigem()
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     PROCEDURE DOrigemDblClick()
1546:         THIS.AbrirLookupDOrigem()
1547:     ENDPROC
1548: 
1549:     *====================================================================
1550:     * AbrirLookupDOrigem - Busca por nome de estado em SigCdUfs
1551:     * Ativo apenas em INCLUIR e com Origem vazio (When legado)
1552:     * Preenche txt_4c_Origem (Estados) e txt_4c_DOrigem (Descrs)
1553:     *====================================================================
1554:     PROCEDURE AbrirLookupDOrigem()
1555:         LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
1556:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1557:         IF VARTYPE(loc_oCnt) != "O"
1558:             RETURN
1559:         ENDIF
1560:         IF loc_oCnt.txt_4c_DOrigem.ReadOnly
1561:             RETURN
1562:         ENDIF
1563:         *-- Guardia: When legado = INSERIR AND Empty(GetOrigem)
1564:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Origem.Value))
1565:             RETURN
1566:         ENDIF
1567: 
1568:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1569:             "SigCdUfs", "cursor_4c_BuscaUF", "Descrs", ;
1570:             ALLTRIM(loc_oCnt.txt_4c_DOrigem.Value), ;
1571:             "Estado Origem por Nome")
1572: 
1573:         IF VARTYPE(loc_oBusca) = "O"
1574:             loc_oBusca.mAddColuna("Descrs",  "", "Estado")
1575:             loc_oBusca.mAddColuna("Estados", "", "UF")
1576:             loc_oBusca.Show()
1577: 
1578:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
1579:                 loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
1580:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
1581:                 loc_oCnt.txt_4c_Origem.Value  = loc_cEstado
1582:                 loc_oCnt.txt_4c_DOrigem.Value = loc_cDescricao
1583:             ENDIF
1584: 
1585:             loc_oBusca.Release()
1586:         ENDIF
1587: 
1588:         IF USED("cursor_4c_BuscaUF")
1589:             USE IN cursor_4c_BuscaUF
1590:         ENDIF
1591:     ENDPROC
1592: 
1593:     *====================================================================
1594:     * DestinoKeyPress / DestinoDblClick - F4 ou duplo-clique em Destino (codigo UF)
1595:     *====================================================================
1596:     PROCEDURE DestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1597:         IF par_nKeyCode = 28
1598:             THIS.AbrirLookupDestino()
1599:         ENDIF
1600:     ENDPROC
1601: 
1602:     PROCEDURE DestinoDblClick()
1603:         THIS.AbrirLookupDestino()
1604:     ENDPROC
1605: 
1606:     *====================================================================
1607:     * AbrirLookupDestino - Busca por codigo de UF em SigCdUfs
1608:     * Preenche txt_4c_Destino (Estados) e txt_4c_DDestino (Descrs)
1609:     *====================================================================
1610:     PROCEDURE AbrirLookupDestino()
1611:         LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
1612:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1613:         IF VARTYPE(loc_oCnt) != "O"
1614:             RETURN
1615:         ENDIF
1616:         IF loc_oCnt.txt_4c_Destino.ReadOnly
1617:             RETURN
1618:         ENDIF
1619: 
1620:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1621:             "SigCdUfs", "cursor_4c_BuscaUF", "Estados", ;
1622:             ALLTRIM(loc_oCnt.txt_4c_Destino.Value), ;
1623:             "Estado Destino")
1624: 
1625:         IF VARTYPE(loc_oBusca) = "O"
1626:             loc_oBusca.mAddColuna("Estados", "", "UF")
1627:             loc_oBusca.mAddColuna("Descrs",  "", "Estado")
1628:             loc_oBusca.Show()
1629: 
1630:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
1631:                 loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
1632:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
1633:                 loc_oCnt.txt_4c_Destino.Value  = loc_cEstado
1634:                 loc_oCnt.txt_4c_DDestino.Value = loc_cDescricao
1635:             ENDIF
1636: 
1637:             loc_oBusca.Release()
1638:         ENDIF
1639: 
1640:         IF USED("cursor_4c_BuscaUF")
1641:             USE IN cursor_4c_BuscaUF
1642:         ENDIF
1643:     ENDPROC
1644: 
1645:     *====================================================================
1646:     * DDestinoKeyPress / DDestinoDblClick - F4 ou duplo-clique em DDestino (nome estado)
1647:     * Ativo apenas em INCLUIR quando Destino estiver vazio (When legado)
1648:     *====================================================================
1649:     PROCEDURE DDestinoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1650:         IF par_nKeyCode = 28
1651:             THIS.AbrirLookupDDestino()
1652:         ENDIF
1653:     ENDPROC
1654: 
1655:     PROCEDURE DDestinoDblClick()
1656:         THIS.AbrirLookupDDestino()
1657:     ENDPROC
1658: 
1659:     *====================================================================
1660:     * AbrirLookupDDestino - Busca por nome de estado em SigCdUfs
1661:     * Ativo apenas em INCLUIR e com Destino vazio (When legado)
1662:     * Preenche txt_4c_Destino (Estados) e txt_4c_DDestino (Descrs)
1663:     *====================================================================
1664:     PROCEDURE AbrirLookupDDestino()
1665:         LOCAL loc_oCnt, loc_oBusca, loc_cEstado, loc_cDescricao
1666:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1667:         IF VARTYPE(loc_oCnt) != "O"
1668:             RETURN
1669:         ENDIF
1670:         IF loc_oCnt.txt_4c_DDestino.ReadOnly
1671:             RETURN
1672:         ENDIF
1673:         *-- Guardia: When legado = INSERIR AND Empty(GetDestino)
1674:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Destino.Value))
1675:             RETURN
1676:         ENDIF
1677: 
1678:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1679:             "SigCdUfs", "cursor_4c_BuscaUF", "Descrs", ;
1680:             ALLTRIM(loc_oCnt.txt_4c_DDestino.Value), ;
1681:             "Estado Destino por Nome")
1682: 
1683:         IF VARTYPE(loc_oBusca) = "O"
1684:             loc_oBusca.mAddColuna("Descrs",  "", "Estado")
1685:             loc_oBusca.mAddColuna("Estados", "", "UF")
1686:             loc_oBusca.Show()
1687: 
1688:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUF")
1689:                 loc_cEstado    = ALLTRIM(cursor_4c_BuscaUF.Estados)
1690:                 loc_cDescricao = ALLTRIM(cursor_4c_BuscaUF.Descrs)
1691:                 loc_oCnt.txt_4c_Destino.Value  = loc_cEstado
1692:                 loc_oCnt.txt_4c_DDestino.Value = loc_cDescricao
1693:             ENDIF
1694: 
1695:             loc_oBusca.Release()
1696:         ENDIF
1697: 
1698:         IF USED("cursor_4c_BuscaUF")
1699:             USE IN cursor_4c_BuscaUF
1700:         ENDIF
1701:     ENDPROC
1702: 
1703:     *====================================================================
1704:     * ValidarMovs - Valida campo Tipo de Movimento (E=Entrada / S=Saida)
1705:     * Equivale ao GetMovs.Valid do legado
1706:     *====================================================================
1707:     PROCEDURE ValidarMovs()
1708:         LOCAL loc_oCnt, loc_cMovs
1709:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1710:         IF VARTYPE(loc_oCnt) != "O"
1711:             RETURN
1712:         ENDIF
1713:         IF loc_oCnt.txt_4c_Movs.ReadOnly
1714:             RETURN
1715:         ENDIF
1716:         loc_cMovs = UPPER(ALLTRIM(loc_oCnt.txt_4c_Movs.Value))
1717:         IF !EMPTY(loc_cMovs) AND !INLIST(loc_cMovs, "E", "S")
1718:             MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido." + CHR(13) + ;
1719:                 "Use E=Entrada ou S=Sa" + CHR(237) + "da.")
1720:             loc_oCnt.txt_4c_Movs.Value = ""
1721:         ENDIF
1722:     ENDPROC
1723: 
1724: ENDDEFINE


### BO (C:\4c\projeto\app\classes\IctBO.prg):
*====================================================================
* IctBO.prg
*
* Business Object para Cadastro de Tipo de Tributa??o do ICMS
* Tabela: SigPrTri
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS IctBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrTri)
    this_cCidChaves   = ""    && cidchaves char(20) - PK composta (gerada)
    this_cTipos       = ""    && tipos     char(4)
    this_cDescs       = ""    && descs     char(20)
    this_cCfops       = ""    && cfops     char(10)
    this_cOrigems     = ""    && origems   char(2)
    this_cDestinos    = ""    && destinos  char(2)
    this_cMovs        = ""    && movs      char(1)
    this_nAliquotas   = 0     && aliquotas numeric(5,2)
    this_nBases       = 0     && bases     numeric(5,2)
    this_nReduzidas   = 0     && reduzidas numeric(5,2)
    this_nAliqicmsts  = 0     && aliqicmsts numeric(5,2) - Aliq. Substitui??o

    *-- Propriedades auxiliares de exibi??o (vem de JOINs, n?o s?o colunas de SigPrTri)
    this_cOrigemd     = ""    && SigCdUfs.Descrs para Origems (display)
    this_cDestinoD    = ""    && SigCdUfs.Descrs para Destinos (display)
    this_cCfopd       = ""    && SigCdCfo.Descricaos para Cfops (display)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTri"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "IctBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * cidchaves = tipos(4) + cfops(10) + movs(1) + origems(2) + "/" + destinos(2) = 20 chars
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * GerarCidChaves - Computa a PK composta a partir dos campos-chave
    *====================================================================
    PROTECTED FUNCTION GerarCidChaves()
        RETURN PADR(ALLTRIM(THIS.this_cTipos),  4) + ;
               PADR(ALLTRIM(THIS.this_cCfops), 10) + ;
               LEFT(ALLTRIM(THIS.this_cMovs) + " ", 1) + ;
               PADR(ALLTRIM(THIS.this_cOrigems), 2) + ;
               "/" + ;
               PADR(ALLTRIM(THIS.this_cDestinos), 2)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,   "C")
                THIS.this_cTipos      = TratarNulo(Tipos,       "C")
                THIS.this_cDescs      = TratarNulo(Descs,       "C")
                THIS.this_cCfops      = TratarNulo(CFOPs,       "C")
                THIS.this_cOrigems    = TratarNulo(Origems,     "C")
                THIS.this_cDestinos   = TratarNulo(Destinos,    "C")
                THIS.this_cMovs       = TratarNulo(Movs,        "C")
                THIS.this_nAliquotas  = TratarNulo(Aliquotas,   "N")
                THIS.this_nBases      = TratarNulo(Bases,       "N")
                THIS.this_nReduzidas  = TratarNulo(Reduzidas,   "N")
                THIS.this_nAliqicmsts = TratarNulo(aliqicmsts,  "N")
                IF FCOUNT() > 11
                    THIS.this_cOrigemd  = TratarNulo(Origemd,   "C")
                    THIS.this_cDestinoD = TratarNulo(Destinod,  "C")
                    THIS.this_cCfopd    = TratarNulo(CFOPd,     "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, ;
                "IctBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cTipos))
            MsgAviso("Tipo obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCfops))
            MsgAviso("C.F.O.P. obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cMovs))
            MsgAviso("Tipo de Movimento obrigat" + CHR(243) + "rio!")
            loc_lValido = .F.
        ELSE
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cMovs)), "E", "S")
            MsgAviso("Tipo de Movimento inv" + CHR(225) + "lido. Use E=Entrada ou S=Sa" + CHR(237) + "da.")
            loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Buscar - Busca registros na tabela SigPrTri com JOINs de display
    * par_cFiltro: condicao SQL sem WHERE (vazio = todos)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cidchaves C(20), Tipos C(4), ;
                        Descs C(20), CFOPs C(10), Origems C(2), Destinos C(2), ;
                        Movs C(1), Aliquotas N(5,2), Bases N(5,2), Reduzidas N(5,2), ;
                        aliqicmsts N(5,2), Origemd C(50), Destinod C(50), CFOPd C(60))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                    " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                    " a.Reduzidas, a.aliqicmsts," + ;
                    " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                    " FROM SigPrTri a" + ;
                    " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                    " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                    " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY a.Tipos, a.CFOPs, a.Movs, a.Origems, a.Destinos"

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
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "IctBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.Tipos, a.Descs, a.CFOPs," + ;
                " a.Origems, a.Destinos, a.Movs, a.Aliquotas, a.Bases," + ;
                " a.Reduzidas, a.aliqicmsts," + ;
                " b.Descrs AS Origemd, c.Descrs AS Destinod, d.Descricaos AS CFOPd" + ;
                " FROM SigPrTri a" + ;
                " LEFT JOIN SigCdUfs b ON a.Origems = b.Estados" + ;
                " LEFT JOIN SigCdUfs c ON a.Destinos = c.Estados" + ;
                " LEFT JOIN SigCdCfo d ON a.CFOPs = d.Codigos" + ;
                " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "IctBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarCidChaves()

            loc_cSQL = "INSERT INTO SigPrTri" + ;
                " (cidchaves, Tipos, Descs, CFOPs, Origems, Destinos," + ;
                " Movs, Aliquotas, Bases, Reduzidas, aliqicmsts)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cTipos)     + ", " + ;
                EscaparSQL(THIS.this_cDescs)     + ", " + ;
                EscaparSQL(THIS.this_cCfops)     + ", " + ;
                EscaparSQL(THIS.this_cOrigems)   + ", " + ;
                EscaparSQL(THIS.this_cDestinos)  + ", " + ;
                EscaparSQL(THIS.this_cMovs)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "IctBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrTri (PROTECTED)
    * Apenas campos editaveis em modo ALTERAR (nao atualiza chave composta)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrTri SET" + ;
                " Descs = "      + EscaparSQL(THIS.this_cDescs)             + ", " + ;
                " Aliquotas = "  + FormatarNumeroSQL(THIS.this_nAliquotas,  2) + ", " + ;
                " Bases = "      + FormatarNumeroSQL(THIS.this_nBases,      2) + ", " + ;
                " Reduzidas = "  + FormatarNumeroSQL(THIS.this_nReduzidas,  2) + ", " + ;
                " aliqicmsts = " + FormatarNumeroSQL(THIS.this_nAliqicmsts, 2) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "IctBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro de SigPrTri (PROTECTED)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTri WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir Tributa" + CHR(231) + CHR(227) + "o ICMS:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "IctBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

