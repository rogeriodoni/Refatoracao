# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLGR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1505 linhas total):

*-- Linhas 28 a 139:
28:     this_cModoAtual = "LISTA"
29: 
30:     *==========================================================================
31:     * Init - Apenas DODEFAULT (FormBase.Init chama InicializarForm)
32:     *==========================================================================
33:     PROCEDURE Init()
34:         RETURN DODEFAULT()
35:     ENDPROC
36: 
37:     *==========================================================================
38:     * InicializarForm - Cria BO, PageFrame e componentes da interface
39:     *==========================================================================
40:     PROTECTED PROCEDURE InicializarForm()
41:         LOCAL loc_lResultado
42:         loc_lResultado = .F.
43: 
44:         TRY
45:             THIS.this_oBusinessObject = CREATEOBJECT("LGRBO")
46: 
47:             THIS.ConfigurarPageFrame()
48:             THIS.ConfigurarPaginaLista()
49:             THIS.ConfigurarPaginaDados()
50: 
51:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53: 
54:             IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
55:                 IF !THIS.CarregarLista()
56:                     * Falha ao carregar nao impede a abertura do form
57:                 ENDIF
58:             ENDIF
59: 
60:             THIS.pgf_4c_Paginas.Visible = .T.
61:             THIS.pgf_4c_Paginas.ActivePage = 1
62:             THIS.this_cModoAtual = "LISTA"
63:             loc_lResultado = .T.
64: 
65:         CATCH TO loc_oErro
66:             MsgErro("Erro ao inicializar FormLGR:" + CHR(13) + loc_oErro.Message, "Erro")
67:             loc_lResultado = .F.
68:         ENDTRY
69: 
70:         RETURN loc_lResultado
71:     ENDPROC
72: 
73:     *==========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame principal (Top=-29 para ocultar abas)
75:     *==========================================================================
76:     PROTECTED PROCEDURE ConfigurarPageFrame()
77:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
78:         WITH THIS.pgf_4c_Paginas
79:             .Top       = -29
80:             .Left      = 0
81:             .Width     = THIS.Width
82:             .Height    = THIS.Height + 29
83:             .PageCount = 2
84:             .Tabs      = .F.
85:             .Visible   = .T.
86:             .Page1.Caption   = "Lista"
87:             .Page1.BackColor = RGB(225, 225, 225)
88:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:             .Page2.Caption   = "Dados"
90:             .Page2.BackColor = RGB(225, 225, 225)
91:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:         ENDWITH
93:     ENDPROC
94: 
95:     *==========================================================================
96:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
97:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
98:     *==========================================================================
99:     PROTECTED PROCEDURE ConfigurarPaginaLista()
100:         LOCAL loc_oPagina
101:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
102: 
103:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
104:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105: 
106:         *-- Cabecalho cinza escuro com titulo (Top original=2, +29comp=31)
107:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
108:         WITH loc_oPagina.cnt_4c_Cabecalho
109:             .Top         = 31
110:             .Left        = 0
111:             .Width       = THIS.Width
112:             .Height      = 80
113:             .BackColor   = RGB(100, 100, 100)
114:             .BorderWidth = 0
115:             .Visible     = .T.
116:             .AddObject("lbl_4c_Sombra", "Label")
117:             WITH .lbl_4c_Sombra
118:                 .Caption   = THIS.Caption
119:                 .Top       = 15
120:                 .Left      = 10
121:                 .Width     = THIS.Width
122:                 .Height    = 40
123:                 .FontName  = "Tahoma"
124:                 .FontSize  = 16
125:                 .FontBold  = .T.
126:                 .ForeColor = RGB(0, 0, 0)
127:                 .BackStyle = 0
128:                 .AutoSize  = .F.
129:                 .Visible   = .T.
130:             ENDWITH
131:             .AddObject("lbl_4c_Titulo", "Label")
132:             WITH .lbl_4c_Titulo
133:                 .Caption   = THIS.Caption
134:                 .Top       = 18
135:                 .Left      = 10
136:                 .Width     = THIS.Width
137:                 .Height    = 46
138:                 .FontName  = "Tahoma"
139:                 .FontSize  = 16

*-- Linhas 423 a 486:
423:             .Visible           = .T.
424:         ENDWITH
425: 
426:         *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
427:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
428:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
429:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
430:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
431:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
432:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
433: 
434:         *-- BINDEVENTs dos campos de filtro
435:         BINDEVENT(loc_oPagina.txt_4c_SerieFab, "KeyPress", THIS, "ValidarSerieFab")
436:         BINDEVENT(loc_oPagina.txt_4c_Dtini,    "KeyPress", THIS, "ValidarDtini")
437:         BINDEVENT(loc_oPagina.txt_4c_Dtfim,    "KeyPress", THIS, "ValidarDtfim")
438: 
439:         THIS.TornarControlesVisiveis(loc_oPagina)
440:     ENDPROC
441: 
442:     *==========================================================================
443:     * ConfigurarPaginaDados - Page2: campos de edicao e botoes salvar/cancelar
444:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
445:     *==========================================================================
446:     PROTECTED PROCEDURE ConfigurarPaginaDados()
447:         LOCAL loc_oPagina
448:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
449: 
450:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
451:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
452: 
453:         *-- Container botoes Confirmar/Cancelar (grupo_salva canonico)
454:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
455:         WITH loc_oPagina.cnt_4c_Salva
456:             .Top         = 33
457:             .Left        = 842
458:             .Width       = 160
459:             .Height      = 85
460:             .BackStyle   = 0
461:             .BorderWidth = 0
462:             .Visible     = .T.
463:         ENDWITH
464: 
465:         WITH loc_oPagina.cnt_4c_Salva
466:             .AddObject("cmd_4c_Confirmar", "CommandButton")
467:             WITH .cmd_4c_Confirmar
468:                 .Caption         = "Confirmar"
469:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
470:                 .PicturePosition = 13
471:                 .Top             = 5
472:                 .Left            = 5
473:                 .Width           = 75
474:                 .Height          = 75
475:                 .BackColor       = RGB(255, 255, 255)
476:                 .ForeColor       = RGB(90, 90, 90)
477:                 .FontName        = "Tahoma"
478:                 .FontSize        = 8
479:                 .FontBold        = .T.
480:                 .FontItalic      = .T.
481:                 .SpecialEffect   = 0
482:                 .MousePointer    = 15
483:                 .WordWrap        = .T.
484:                 .Visible         = .T.
485:             ENDWITH
486:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 796 a 852:
796:             .Visible   = .T.
797:         ENDWITH
798: 
799:         *-- BINDEVENTs botoes Page2 (PUBLIC methods)
800:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
801:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
802: 
803:         *-- BINDEVENTs formatadores e lookups de campos Page2
804:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ValidarModelo")
805:         BINDEVENT(loc_oPagina.txt_4c_Coo,    "LostFocus", THIS, "FormatarCoo")
806:         BINDEVENT(loc_oPagina.txt_4c_Cnf,    "LostFocus", THIS, "FormatarCnf")
807:         BINDEVENT(loc_oPagina.txt_4c_Rg,     "LostFocus", THIS, "FormatarRg")
808:         BINDEVENT(loc_oPagina.txt_4c_Dcd,    "LostFocus", THIS, "FormatarDcd")
809:         BINDEVENT(loc_oPagina.txt_4c_Rz,     "LostFocus", THIS, "FormatarRz")
810:         BINDEVENT(loc_oPagina.txt_4c_Tipo,   "KeyPress", THIS, "ValidarTipo")
811: 
812:         THIS.TornarControlesVisiveis(loc_oPagina)
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * CarregarLista - Busca registros via BO e configura o grid
817:     * Le filtros de Page1, chama Buscar(), monta colunas do grid
818:     *==========================================================================
819:     PROTECTED FUNCTION CarregarLista()
820:         LOCAL loc_lResultado, loc_oPg1, loc_oGrid
821:         LOCAL loc_cSerifab, loc_dDtini, loc_dDtfim
822:         loc_lResultado = .F.
823: 
824:         TRY
825:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
826:                 loc_lResultado = .T.
827:             ELSE
828:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
829:                 loc_oGrid = loc_oPg1.grd_4c_Lista
830: 
831:                 *-- Ler filtros atuais
832:                 loc_cSerifab = ""
833:                 loc_dDtini   = {}
834:                 loc_dDtfim   = {}
835: 
836:                 IF PEMSTATUS(loc_oPg1, "txt_4c_SerieFab", 5)
837:                     loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
838:                 ENDIF
839:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Dtini", 5)
840:                     IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) = "D"
841:                         loc_dDtini = loc_oPg1.txt_4c_Dtini.Value
842:                     ENDIF
843:                 ENDIF
844:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Dtfim", 5)
845:                     IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) = "D"
846:                         loc_dDtfim = loc_oPg1.txt_4c_Dtfim.Value
847:                     ENDIF
848:                 ENDIF
849: 
850:                 IF THIS.this_oBusinessObject.Buscar(loc_cSerifab, loc_dDtini, loc_dDtfim)
851:                     *-- RecordSource e ColumnCount FORA do WITH para garantir criacao das colunas
852:                     loc_oGrid.ColumnCount = 3

*-- Linhas 911 a 1505:
911:     *==========================================================================
912:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
913:     *==========================================================================
914:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
915:         IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
916:             RETURN .F.
917:         ENDIF
918: 
919:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
920: 
921:         IF par_nPagina = 1
922:             THIS.this_cModoAtual = "LISTA"
923:         ENDIF
924: 
925:         RETURN .T.
926:     ENDPROC
927: 
928:     *==========================================================================
929:     * BtnIncluirClick - Prepara form para inclusao de novo registro
930:     *==========================================================================
931:     PROCEDURE BtnIncluirClick()
932:         THIS.this_oBusinessObject.NovoRegistro()
933:         THIS.LimparCampos()
934:         THIS.this_cModoAtual = "INCLUIR"
935:         THIS.HabilitarCampos(.T.)
936:         THIS.AjustarBotoesPorModo()
937:         THIS.AlternarPagina(2)
938:         THIS.pgf_4c_Paginas.Page2.txt_4c_Modelo.SetFocus
939:     ENDPROC
940: 
941:     *==========================================================================
942:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
943:     *==========================================================================
944:     PROCEDURE BtnVisualizarClick()
945:         LOCAL loc_cIdChaves
946:         loc_cIdChaves = ""
947: 
948:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
949:             MsgAviso("Nenhum registro selecionado.", "Aviso")
950:             RETURN
951:         ENDIF
952: 
953:         SELECT cursor_4c_Dados
954:         loc_cIdChaves = ALLTRIM(cidchaves)
955: 
956:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
957:             THIS.this_cModoAtual = "VISUALIZAR"
958:             THIS.BOParaForm()
959:             THIS.HabilitarCampos(.F.)
960:             THIS.AjustarBotoesPorModo()
961:             THIS.AlternarPagina(2)
962:         ENDIF
963:     ENDPROC
964: 
965:     *==========================================================================
966:     * BtnAlterarClick - Carrega registro selecionado para edicao
967:     * Regra do legado: so permite alterar registros com cincmans='M' (manual)
968:     *==========================================================================
969:     PROCEDURE BtnAlterarClick()
970:         LOCAL loc_cIdChaves, loc_cIncMans
971:         loc_cIdChaves = ""
972:         loc_cIncMans  = ""
973: 
974:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
975:             MsgAviso("Nenhum registro selecionado.", "Aviso")
976:             RETURN
977:         ENDIF
978: 
979:         SELECT cursor_4c_Dados
980:         loc_cIdChaves = ALLTRIM(cidchaves)
981:         loc_cIncMans  = ALLTRIM(cincmans)
982: 
983:         IF loc_cIncMans <> "M"
984:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
985:                      "do manualmente, n" + CHR(227) + "o pode ser Alterado.", "Aviso")
986:             RETURN
987:         ENDIF
988: 
989:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
990:             THIS.this_oBusinessObject.EditarRegistro()
991:             THIS.this_cModoAtual = "ALTERAR"
992:             THIS.BOParaForm()
993:             THIS.HabilitarCampos(.T.)
994:             THIS.AjustarBotoesPorModo()
995:             THIS.AlternarPagina(2)
996:         ENDIF
997:     ENDPROC
998: 
999:     *==========================================================================
1000:     * BtnExcluirClick - Exclui registro selecionado (somente inclusao manual)
1001:     *==========================================================================
1002:     PROCEDURE BtnExcluirClick()
1003:         LOCAL loc_cIdChaves, loc_cIncMans
1004:         loc_cIdChaves = ""
1005:         loc_cIncMans  = ""
1006: 
1007:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1008:             MsgAviso("Nenhum registro selecionado.", "Aviso")
1009:             RETURN
1010:         ENDIF
1011: 
1012:         SELECT cursor_4c_Dados
1013:         loc_cIdChaves = ALLTRIM(cidchaves)
1014:         loc_cIncMans  = ALLTRIM(cincmans)
1015: 
1016:         IF loc_cIncMans <> "M"
1017:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
1018:                      "do manualmente, n" + CHR(227) + "o pode ser Exclu" + CHR(237) + "do.", "Aviso")
1019:             RETURN
1020:         ENDIF
1021: 
1022:         IF MsgConfirma("Deseja excluir este registro?", "Confirma" + CHR(231) + CHR(227) + "o")
1023:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1024:                 IF THIS.this_oBusinessObject.Excluir()
1025:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1026:                     THIS.CarregarLista()
1027:                 ENDIF
1028:             ENDIF
1029:         ENDIF
1030:     ENDPROC
1031: 
1032:     *==========================================================================
1033:     * BtnBuscarClick - Executa busca com os filtros preenchidos em Page1
1034:     * Valida que serie foi informada (conforme legado)
1035:     *==========================================================================
1036:     PROCEDURE BtnBuscarClick()
1037:         LOCAL loc_oPg1, loc_cSerifab
1038:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1039:         loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1040: 
1041:         IF EMPTY(loc_cSerifab)
1042:             MsgAviso("Informe a S" + CHR(233) + "rie de Fabrica" + CHR(231) + ;
1043:                      CHR(227) + "o e as datas para pesquisar.", "Aviso")
1044:             loc_oPg1.txt_4c_SerieFab.SetFocus
1045:             RETURN
1046:         ENDIF
1047: 
1048:         IF EMPTY(loc_oPg1.txt_4c_Dtini.Value) OR EMPTY(loc_oPg1.txt_4c_Dtfim.Value)
1049:             MsgAviso("Informe o per" + CHR(237) + "odo de datas para pesquisar.", "Aviso")
1050:             RETURN
1051:         ENDIF
1052: 
1053:         THIS.CarregarLista()
1054:     ENDPROC
1055: 
1056:     *==========================================================================
1057:     * BtnEncerrarClick - Fecha o formulario
1058:     *==========================================================================
1059:     PROCEDURE BtnEncerrarClick()
1060:         THIS.Release()
1061:     ENDPROC
1062: 
1063:     *==========================================================================
1064:     * BtnSalvarClick - Valida e salva registro (INSERT ou UPDATE via BO)
1065:     *==========================================================================
1066:     PROCEDURE BtnSalvarClick()
1067:         LOCAL loc_oPg2
1068:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1069: 
1070:         *-- Validacoes de UI antes do TRY (nao usar RETURN dentro de TRY)
1071:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
1072:             MsgAviso("Modelo n" + CHR(227) + "o pode estar em branco.", "Aviso")
1073:             loc_oPg2.txt_4c_Modelo.SetFocus
1074:             RETURN
1075:         ENDIF
1076: 
1077:         THIS.FormParaBO()
1078: 
1079:         IF THIS.this_oBusinessObject.Salvar()
1080:             MsgInfo("Registro salvo com sucesso!", "")
1081:             THIS.AlternarPagina(1)
1082:             THIS.CarregarLista()
1083:         ENDIF
1084:     ENDPROC
1085: 
1086:     *==========================================================================
1087:     * BtnCancelarClick - Cancela edicao e volta para a lista
1088:     *==========================================================================
1089:     PROCEDURE BtnCancelarClick()
1090:         THIS.AlternarPagina(1)
1091:         THIS.this_cModoAtual = "LISTA"
1092:         THIS.CarregarLista()
1093:     ENDPROC
1094: 
1095:     *==========================================================================
1096:     * FormParaBO - Transfere valores dos campos do form para o BO
1097:     *==========================================================================
1098:     PROTECTED PROCEDURE FormParaBO()
1099:         LOCAL loc_oPg1, loc_oPg2, loc_cHoras
1100:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1101:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1102: 
1103:         WITH THIS.this_oBusinessObject
1104:             .this_cModelos = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1105:             .this_cCoos    = ALLTRIM(loc_oPg2.txt_4c_Coo.Value)
1106:             .this_cGnfs    = ALLTRIM(loc_oPg2.txt_4c_Cnf.Value)
1107:             .this_cGrgs    = ALLTRIM(loc_oPg2.txt_4c_Rg.Value)
1108:             .this_cCdcs    = ALLTRIM(loc_oPg2.txt_4c_Dcd.Value)
1109:             .this_cCrzs    = ALLTRIM(loc_oPg2.txt_4c_Rz.Value)
1110:             .this_cDoctos  = ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)
1111: 
1112:             *-- Data: TextBox.Value eh Date -> converter para string YYYYMMDD
1113:             IF VARTYPE(loc_oPg2.txt_4c_Dtmov.Value) = "D" AND !EMPTY(loc_oPg2.txt_4c_Dtmov.Value)
1114:                 .this_cDatas = DTOS(loc_oPg2.txt_4c_Dtmov.Value)
1115:             ELSE
1116:                 .this_cDatas = ""
1117:             ENDIF
1118: 
1119:             *-- Hora: string HH:MM:SS -> HHMMSS (strip colons)
1120:             loc_cHoras   = STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Hrmov.Value), ":", "")
1121:             .this_cHoras = loc_cHoras
1122: 
1123:             *-- Inclusao manual flag
1124:             IF THIS.this_cModoAtual = "INCLUIR"
1125:                 .this_cIncMans = "M"
1126:                 *-- Serie vem do filtro de Page1
1127:                 .this_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1128:             ENDIF
1129:         ENDWITH
1130:     ENDPROC
1131: 
1132:     *==========================================================================
1133:     * BOParaForm - Transfere valores do BO para os campos do form
1134:     *==========================================================================
1135:     PROTECTED PROCEDURE BOParaForm()
1136:         LOCAL loc_oPg2, loc_cDatas, loc_cHoras
1137:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1138: 
1139:         WITH THIS.this_oBusinessObject
1140:             loc_oPg2.txt_4c_Codigo.Value = .this_cIdChaves
1141:             loc_oPg2.txt_4c_Modelo.Value = .this_cModelos
1142:             loc_oPg2.txt_4c_Coo.Value    = .this_cCoos
1143:             loc_oPg2.txt_4c_Cnf.Value    = .this_cGnfs
1144:             loc_oPg2.txt_4c_Rg.Value     = .this_cGrgs
1145:             loc_oPg2.txt_4c_Dcd.Value    = .this_cCdcs
1146:             loc_oPg2.txt_4c_Rz.Value     = .this_cCrzs
1147:             loc_oPg2.txt_4c_Tipo.Value   = .this_cDoctos
1148: 
1149:             *-- Data: string YYYYMMDD -> Date (via STOD)
1150:             loc_cDatas = ALLTRIM(.this_cDatas)
1151:             IF LEN(loc_cDatas) = 8
1152:                 loc_oPg2.txt_4c_Dtmov.Value = STOD(loc_cDatas)
1153:             ELSE
1154:                 loc_oPg2.txt_4c_Dtmov.Value = {}
1155:             ENDIF
1156: 
1157:             *-- Hora: string HHMMSS -> HH:MM:SS
1158:             loc_cHoras = ALLTRIM(.this_cHoras)
1159:             IF LEN(loc_cHoras) = 6
1160:                 loc_oPg2.txt_4c_Hrmov.Value = LEFT(loc_cHoras, 2) + ":" + ;
1161:                                                SUBSTR(loc_cHoras, 3, 2) + ":" + ;
1162:                                                RIGHT(loc_cHoras, 2)
1163:             ELSE
1164:                 loc_oPg2.txt_4c_Hrmov.Value = ""
1165:             ENDIF
1166:         ENDWITH
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * HabilitarCampos - Habilita ou desabilita campos da Page2 para edicao
1171:     *==========================================================================
1172:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1173:         LOCAL loc_oPg2
1174:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1175: 
1176:         *-- txt_4c_Codigo (NFAB) sempre ReadOnly
1177:         loc_oPg2.txt_4c_Modelo.ReadOnly = !par_lHabilitar
1178:         loc_oPg2.txt_4c_Coo.ReadOnly    = !par_lHabilitar
1179:         loc_oPg2.txt_4c_Cnf.ReadOnly    = !par_lHabilitar
1180:         loc_oPg2.txt_4c_Rg.ReadOnly     = !par_lHabilitar
1181:         loc_oPg2.txt_4c_Dcd.ReadOnly    = !par_lHabilitar
1182:         loc_oPg2.txt_4c_Rz.ReadOnly     = !par_lHabilitar
1183:         loc_oPg2.txt_4c_Tipo.ReadOnly   = !par_lHabilitar
1184:         loc_oPg2.txt_4c_Dtmov.ReadOnly  = !par_lHabilitar
1185:         loc_oPg2.txt_4c_Hrmov.ReadOnly  = !par_lHabilitar
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * LimparCampos - Limpa todos os campos da Page2
1190:     *==========================================================================
1191:     PROTECTED PROCEDURE LimparCampos()
1192:         LOCAL loc_oPg2
1193:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1194: 
1195:         loc_oPg2.txt_4c_Codigo.Value = ""
1196:         loc_oPg2.txt_4c_Modelo.Value = ""
1197:         loc_oPg2.txt_4c_Coo.Value    = "000000"
1198:         loc_oPg2.txt_4c_Cnf.Value    = ""
1199:         loc_oPg2.txt_4c_Rg.Value     = ""
1200:         loc_oPg2.txt_4c_Dcd.Value    = ""
1201:         loc_oPg2.txt_4c_Rz.Value     = ""
1202:         loc_oPg2.txt_4c_Tipo.Value   = ""
1203:         loc_oPg2.txt_4c_Dtmov.Value  = DATE()
1204:         loc_oPg2.txt_4c_Hrmov.Value  = ""
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
1209:     *==========================================================================
1210:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1211:         LOCAL loc_oPg2, loc_lEditar
1212:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1213:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1214: 
1215:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditar
1216:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     * ValidarSerieFab - LostFocus do campo serie em Page1
1221:     * Valida serie contra SigFiMpf e abre picker se nao encontrar exato
1222:     *==========================================================================
1223:     PROCEDURE ValidarSerieFab(par_nKeyCode, par_nShiftAltCtrl)
1224:         LOCAL loc_oPg1, loc_cSerifab, loc_oBusca
1225:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1226:         loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1227: 
1228:         IF EMPTY(loc_cSerifab)
1229:             RETURN
1230:         ENDIF
1231: 
1232:         *-- Buscar serie exata em SigFiMpf
1233:         IF THIS.this_oBusinessObject.BuscarImpressoras("a.cimpfabs = " + EscaparSQL(loc_cSerifab))
1234:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 1
1235:                 SELECT cursor_4c_Impressoras
1236:                 loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(cimpfabs)
1237:                 USE IN cursor_4c_Impressoras
1238:                 RETURN
1239:             ENDIF
1240:             IF USED("cursor_4c_Impressoras")
1241:                 USE IN cursor_4c_Impressoras
1242:             ENDIF
1243:         ENDIF
1244: 
1245:         *-- Nao encontrou exato: buscar por LIKE e exibir picker
1246:         IF !THIS.this_oBusinessObject.BuscarImpressoras( ;
1247:                 "a.cimpfabs LIKE " + EscaparSQL(loc_cSerifab + "%"))
1248:             THIS.this_oBusinessObject.BuscarImpressoras("")
1249:         ELSE
1250:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 0
1251:                 USE IN cursor_4c_Impressoras
1252:                 THIS.this_oBusinessObject.BuscarImpressoras("")
1253:             ENDIF
1254:         ENDIF
1255: 
1256:         IF USED("cursor_4c_Impressoras")
1257:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1258:             IF VARTYPE(loc_oBusca) = "O"
1259:                 loc_oBusca.DefinirCursor("cursor_4c_Impressoras", "cimpfabs", "cmarcas", ;
1260:                     "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o")
1261:                 loc_oBusca.Mostrar()
1262:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1263:                     loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1264:                 ENDIF
1265:                 loc_oBusca.Release()
1266:             ENDIF
1267:             IF USED("cursor_4c_Impressoras")
1268:                 USE IN cursor_4c_Impressoras
1269:             ENDIF
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * ValidarDtini - LostFocus da data inicio (valida tipo Date)
1275:     *==========================================================================
1276:     PROCEDURE ValidarDtini(par_nKeyCode, par_nShiftAltCtrl)
1277:         LOCAL loc_oPg1
1278:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1279:         IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) <> "D"
1280:             loc_oPg1.txt_4c_Dtini.Value = DATE()
1281:         ENDIF
1282:     ENDPROC
1283: 
1284:     *==========================================================================
1285:     * ValidarDtfim - LostFocus da data fim (valida tipo Date)
1286:     *==========================================================================
1287:     PROCEDURE ValidarDtfim(par_nKeyCode, par_nShiftAltCtrl)
1288:         LOCAL loc_oPg1
1289:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1290:         IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) <> "D"
1291:             loc_oPg1.txt_4c_Dtfim.Value = DATE()
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *==========================================================================
1296:     * ValidarModelo - LostFocus do campo modelo em Page2
1297:     * Busca em SigFiMpm e abre picker se nao encontrar exato
1298:     *==========================================================================
1299:     PROCEDURE ValidarModelo(par_nKeyCode, par_nShiftAltCtrl)
1300:         LOCAL loc_oPg2, loc_cModelo, loc_oBusca
1301:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1302:         loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1303: 
1304:         IF EMPTY(loc_cModelo) OR !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1305:             RETURN
1306:         ENDIF
1307: 
1308:         *-- Buscar modelo exato em SigFiMpm
1309:         IF THIS.this_oBusinessObject.BuscarModelos("cModelos = " + EscaparSQL(loc_cModelo))
1310:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 1
1311:                 SELECT cursor_4c_Modelos
1312:                 loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cModelos)
1313:                 USE IN cursor_4c_Modelos
1314:                 RETURN
1315:             ENDIF
1316:             IF USED("cursor_4c_Modelos")
1317:                 USE IN cursor_4c_Modelos
1318:             ENDIF
1319:         ENDIF
1320: 
1321:         *-- Nao encontrou: buscar por LIKE e exibir picker
1322:         IF !THIS.this_oBusinessObject.BuscarModelos( ;
1323:                 "cModelos LIKE " + EscaparSQL(loc_cModelo + "%"))
1324:             THIS.this_oBusinessObject.BuscarModelos("")
1325:         ELSE
1326:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 0
1327:                 USE IN cursor_4c_Modelos
1328:                 THIS.this_oBusinessObject.BuscarModelos("")
1329:             ENDIF
1330:         ENDIF
1331: 
1332:         IF USED("cursor_4c_Modelos")
1333:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1334:             IF VARTYPE(loc_oBusca) = "O"
1335:                 loc_oBusca.DefinirCursor("cursor_4c_Modelos", "cModelos", "cMarcas", "Modelos")
1336:                 loc_oBusca.Mostrar()
1337:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1338:                     loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1339:                 ENDIF
1340:                 loc_oBusca.Release()
1341:             ENDIF
1342:             IF USED("cursor_4c_Modelos")
1343:                 USE IN cursor_4c_Modelos
1344:             ENDIF
1345:         ENDIF
1346:     ENDPROC
1347: 
1348:     *==========================================================================
1349:     * ValidarTipo - LostFocus do campo tipo de documento em Page2
1350:     *==========================================================================
1351:     PROCEDURE ValidarTipo(par_nKeyCode, par_nShiftAltCtrl)
1352:         LOCAL loc_oPg2
1353:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1354:         IF LEN(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)) > 2
1355:             loc_oPg2.txt_4c_Tipo.Value = LEFT(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value), 2)
1356:         ENDIF
1357:     ENDPROC
1358: 
1359:     *==========================================================================
1360:     * FormatarCoo - LostFocus do COO: formata como string numerica 6 digitos
1361:     * Replica comportamento do legado: Transform(VAL(Value), '@L 999999')
1362:     *==========================================================================
1363:     PROCEDURE FormatarCoo()
1364:         LOCAL loc_oPg2
1365:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1366:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1367:             RETURN
1368:         ENDIF
1369:         WITH loc_oPg2.txt_4c_Coo
1370:             IF !EMPTY(ALLTRIM(.Value))
1371:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1372:                 .Refresh()
1373:             ENDIF
1374:         ENDWITH
1375:     ENDPROC
1376: 
1377:     *==========================================================================
1378:     * FormatarCnf - LostFocus do Cupom nao Fiscal: mesma formatacao
1379:     *==========================================================================
1380:     PROCEDURE FormatarCnf()
1381:         LOCAL loc_oPg2
1382:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1383:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1384:             RETURN
1385:         ENDIF
1386:         WITH loc_oPg2.txt_4c_Cnf
1387:             IF !EMPTY(ALLTRIM(.Value))
1388:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1389:                 .Refresh()
1390:             ENDIF
1391:         ENDWITH
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * FormatarRg - LostFocus do Relatorio Gerencial: mesma formatacao
1396:     *==========================================================================
1397:     PROCEDURE FormatarRg()
1398:         LOCAL loc_oPg2
1399:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1400:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1401:             RETURN
1402:         ENDIF
1403:         WITH loc_oPg2.txt_4c_Rg
1404:             IF !EMPTY(ALLTRIM(.Value))
1405:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1406:                 .Refresh()
1407:             ENDIF
1408:         ENDWITH
1409:     ENDPROC
1410: 
1411:     *==========================================================================
1412:     * FormatarDcd - LostFocus do DCD: formata como string numerica 4 digitos
1413:     *==========================================================================
1414:     PROCEDURE FormatarDcd()
1415:         LOCAL loc_oPg2
1416:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1417:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1418:             RETURN
1419:         ENDIF
1420:         WITH loc_oPg2.txt_4c_Dcd
1421:             IF !EMPTY(ALLTRIM(.Value))
1422:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 9999")
1423:                 .Refresh()
1424:             ENDIF
1425:         ENDWITH
1426:     ENDPROC
1427: 
1428:     *==========================================================================
1429:     * FormatarRz - LostFocus da Reducao Z: formata como string numerica 6 digitos
1430:     *==========================================================================
1431:     PROCEDURE FormatarRz()
1432:         LOCAL loc_oPg2
1433:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1434:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1435:             RETURN
1436:         ENDIF
1437:         WITH loc_oPg2.txt_4c_Rz
1438:             IF !EMPTY(ALLTRIM(.Value))
1439:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1440:                 .Refresh()
1441:             ENDIF
1442:         ENDWITH
1443:     ENDPROC
1444: 
1445:     *==========================================================================
1446:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1447:     *==========================================================================
1448:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1449:         LOCAL loc_i, loc_oControl, loc_nP
1450: 
1451:         IF VARTYPE(par_oContainer) <> "O"
1452:             RETURN
1453:         ENDIF
1454: 
1455:         FOR loc_i = 1 TO par_oContainer.ControlCount
1456:             loc_oControl = par_oContainer.Controls(loc_i)
1457: 
1458:             IF VARTYPE(loc_oControl) = "O"
1459:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1460:                     loc_oControl.Visible = .T.
1461:                 ENDIF
1462: 
1463:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1464:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1465:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1466:                     ENDFOR
1467:                 ENDIF
1468: 
1469:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1470:                     THIS.TornarControlesVisiveis(loc_oControl)
1471:                 ENDIF
1472:             ENDIF
1473:         ENDFOR
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * FormatarGridLista - Formata fonte do grid apos carregar dados
1478:     *==========================================================================
1479:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1480:         IF VARTYPE(par_oGrid) <> "O"
1481:             RETURN
1482:         ENDIF
1483: 
1484:         WITH par_oGrid
1485:             .FontName = "Tahoma"
1486:             .FontSize = 8
1487:         ENDWITH
1488:     ENDPROC
1489: 
1490:     *==========================================================================
1491:     * Destroy - Libera recursos do form
1492:     *==========================================================================
1493:     PROCEDURE Destroy()
1494:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1495:             THIS.this_oBusinessObject = .NULL.
1496:         ENDIF
1497: 
1498:         IF USED("cursor_4c_Dados")
1499:             USE IN cursor_4c_Dados
1500:         ENDIF
1501: 
1502:         DODEFAULT()
1503:     ENDPROC
1504: 
1505: ENDDEFINE


### BO (C:\4c\projeto\app\classes\LGRBO.prg):
*==============================================================================
* LGRBO.prg - Business Object para Livro de Gerenciamento Fiscal (SigFiGfd)
* Herda de: BusinessBase
* Tabela: SigFiGfd
* PK: cidchaves (gerado via SYS(2015)+SYS(2015))
*==============================================================================

DEFINE CLASS LGRBO AS BusinessBase

    *-- Propriedades da classe
    this_cTabela      = "SigFiGfd"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades mapeadas da tabela SigFiGfd
    *--------------------------------------------------------------------------
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cSerifab   = ""    && cserifab  char(20) - Serie de Fabricacao (FK SigFiMpf)
    this_cModelos   = ""    && cmodelos  char(20) - Modelo (FK SigFiMpm)
    this_cCoos      = ""    && ccoos     char(6)  - COO
    this_cGnfs      = ""    && cgnfs     char(6)  - Cupom nao Fiscal
    this_cGrgs      = ""    && cgrgs     char(6)  - Relatorios Gerenciais
    this_cCdcs      = ""    && ccdcs     char(4)  - Demonstrativo Credito e Debito
    this_cCrzs      = ""    && ccrzs     char(6)  - Reducao Z
    this_cDoctos    = ""    && cdoctos   char(2)  - Tipo de Documento
    this_cDatas     = ""    && cdatas    char(8)  - Data YYYYMMDD (sem barras)
    this_cHoras     = ""    && choras    char(6)  - Hora HHMMSS
    this_cIncMans   = ""    && cincmans  char(1)  - Flag inclusao manual ('M')
    this_cTipos     = ""    && ctipos    char(3)  - Tipo (ex: 'E16')
    this_cMfs       = ""    && cmfs      char(1)  - Memoria Fiscal
    this_cUsuarios  = ""    && cusuarios char(2)  - Usuario
    this_cCancel    = ""    && ccancel   char(1)  - Flag cancelamento
    this_cDescons   = ""    && cdescons  char(13) - Desconto
    this_cDescrs    = ""    && cdescrs   char(100) - Descricao
    this_cFpagtos   = ""    && cfpagtos  char(14) - Forma de Pagamento
    this_cItems     = ""    && citems    char(4)  - Item
    this_cPros      = ""    && cpros     char(14) - Pro
    this_cQtds      = ""    && cqtds     char(7)  - Quantidade
    this_cTribs     = ""    && ctribs    char(7)  - Tributos
    this_cUnids     = ""    && cunids    char(3)  - Unidade
    this_cValors    = ""    && cvalors   char(14) - Valor
    this_cLocals    = ""    && locals    char(10) - Local
    this_cDocorigs  = ""    && cdocorigs char(10) - Documento de origem
    this_cConcatda  = ""    && concatda  text     - Concatenado
    this_lCopias    = .F.   && copias    bit      - Copias
    this_nNtrans    = 0     && ntrans    numeric(6,0) - Numero transacao
    this_dDatatrans = {}    && datatrans datetime - Data transacao auditoria

    *-- Propriedade auxiliar da juncao (SigFiMpm.cmarcas - apenas para exibicao no grid)
    this_cMarcas    = ""    && cmarcas (vem de SigFiMpm via JOIN)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiGfd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN SigFiMpm para exibir marca
    * par_cFiltro: filtro WHERE adicional (sem a palavra WHERE)
    * par_cSerifab: serie de fabricacao para filtrar
    * par_dDtini: data inicio do periodo
    * par_dDtfim: data fim do periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cSerifab, par_dDtini, par_dDtfim)
        LOCAL loc_cSQL, loc_cSerifab, loc_cDtini, loc_cDtfim, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSerifab = IIF(VARTYPE(par_cSerifab) = "C", ALLTRIM(par_cSerifab), "")
            loc_cDtini   = IIF(VARTYPE(par_dDtini) = "D" AND !EMPTY(par_dDtini), ;
                               STRTRAN(DTOC(par_dDtini), "/", ""), "")
            loc_cDtfim   = IIF(VARTYPE(par_dDtfim) = "D" AND !EMPTY(par_dDtfim), ;
                               STRTRAN(DTOC(par_dDtfim), "/", ""), "")

            loc_cSQL = "SELECT b.cmarcas, a.cidchaves, a.cserifab, a.cmodelos," + ;
                       " a.ccoos, a.cgnfs, a.cgrgs, a.ccdcs, a.ccrzs, a.cdoctos," + ;
                       " a.cdatas, a.choras, a.cincmans, a.ctipos, a.cmfs," + ;
                       " a.cusuarios, a.ccancel, a.cdescons, a.cdescrs," + ;
                       " a.cfpagtos, a.citems, a.cpros, a.cqtds, a.ctribs," + ;
                       " a.cunids, a.cvalors, a.locals, a.ntrans, a.cdocorigs" + ;
                       " FROM SigFiGfd a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos"

            IF !EMPTY(loc_cSerifab) OR !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                loc_cSQL = loc_cSQL + " WHERE"
                IF !EMPTY(loc_cSerifab)
                    loc_cSQL = loc_cSQL + " a.cserifab = " + EscaparSQL(loc_cSerifab)
                    IF !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                        loc_cSQL = loc_cSQL + " AND"
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cDtini) AND !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas BETWEEN " + EscaparSQL(loc_cDtini) + ;
                               " AND " + EscaparSQL(loc_cDtfim)
                ELSE
                    IF !EMPTY(loc_cDtini)
                    loc_cSQL = loc_cSQL + " a.cdatas >= " + EscaparSQL(loc_cDtini)
                ELSE
                    IF !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas <= " + EscaparSQL(loc_cDtfim)
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.cdatas, a.ccoos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Buscar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cIdChaves) <> "C" OR EMPTY(par_cIdChaves)
                MsgErro("Chave inv" + CHR(225) + "lida para carregamento.", "Erro")
            ELSE
                loc_cSQL = "SELECT b.cmarcas, a.*" + ;
                           " FROM SigFiGfd a" + ;
                           " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos" + ;
                           " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Carrega")
                    TABLEREVERT(.T., "cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.CarregarPorCodigo: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cSerifab   = TratarNulo(cserifab,  "C")
            THIS.this_cModelos   = TratarNulo(cmodelos,  "C")
            THIS.this_cCoos      = TratarNulo(ccoos,     "C")
            THIS.this_cGnfs      = TratarNulo(cgnfs,     "C")
            THIS.this_cGrgs      = TratarNulo(cgrgs,     "C")
            THIS.this_cCdcs      = TratarNulo(ccdcs,     "C")
            THIS.this_cCrzs      = TratarNulo(ccrzs,     "C")
            THIS.this_cDoctos    = TratarNulo(cdoctos,   "C")
            THIS.this_cDatas     = TratarNulo(cdatas,    "C")
            THIS.this_cHoras     = TratarNulo(choras,    "C")
            THIS.this_cIncMans   = TratarNulo(cincmans,  "C")
            THIS.this_cTipos     = TratarNulo(ctipos,    "C")
            THIS.this_cMfs       = TratarNulo(cmfs,      "C")
            THIS.this_cUsuarios  = TratarNulo(cusuarios, "C")
            THIS.this_cCancel    = TratarNulo(ccancel,   "C")
            THIS.this_cDescons   = TratarNulo(cdescons,  "C")
            THIS.this_cDescrs    = TratarNulo(cdescrs,   "C")
            THIS.this_cFpagtos   = TratarNulo(cfpagtos,  "C")
            THIS.this_cItems     = TratarNulo(citems,    "C")
            THIS.this_cPros      = TratarNulo(cpros,     "C")
            THIS.this_cQtds      = TratarNulo(cqtds,     "C")
            THIS.this_cTribs     = TratarNulo(ctribs,    "C")
            THIS.this_cUnids     = TratarNulo(cunids,    "C")
            THIS.this_cValors    = TratarNulo(cvalors,   "C")
            THIS.this_cLocals    = TratarNulo(locals,    "C")
            THIS.this_nNtrans    = TratarNulo(ntrans,    "N")
            THIS.this_cDocorigs  = TratarNulo(cdocorigs, "C")
            THIS.this_lCopias    = (TratarNulo(copias,   "N") <> 0)
            IF TYPE("cmarcas") = "C"
                THIS.this_cMarcas = TratarNulo(cmarcas, "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = SYS(2015) + SYS(2015)
            THIS.this_cIdChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigFiGfd" + ;
                       " (cidchaves, cserifab, cmodelos, ccoos, cgnfs, cgrgs," + ;
                       "  ccdcs, ccrzs, cdoctos, cdatas, choras, cincmans," + ;
                       "  ctipos, cmfs, cusuarios, ccancel, cdescons, cdescrs," + ;
                       "  cfpagtos, citems, cpros, cqtds, ctribs, cunids," + ;
                       "  cvalors, locals, ntrans, cdocorigs, copias)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       EscaparSQL(THIS.this_cSerifab)   + ", " + ;
                       EscaparSQL(THIS.this_cModelos)   + ", " + ;
                       EscaparSQL(THIS.this_cCoos)      + ", " + ;
                       EscaparSQL(THIS.this_cGnfs)      + ", " + ;
                       EscaparSQL(THIS.this_cGrgs)      + ", " + ;
                       EscaparSQL(THIS.this_cCdcs)      + ", " + ;
                       EscaparSQL(THIS.this_cCrzs)      + ", " + ;
                       EscaparSQL(THIS.this_cDoctos)    + ", " + ;
                       EscaparSQL(THIS.this_cDatas)     + ", " + ;
                       EscaparSQL(THIS.this_cHoras)     + ", " + ;
                       EscaparSQL(THIS.this_cIncMans)   + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMfs)       + ", " + ;
                       EscaparSQL(THIS.this_cUsuarios)  + ", " + ;
                       EscaparSQL(THIS.this_cCancel)    + ", " + ;
                       EscaparSQL(THIS.this_cDescons)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cFpagtos)   + ", " + ;
                       EscaparSQL(THIS.this_cItems)     + ", " + ;
                       EscaparSQL(THIS.this_cPros)      + ", " + ;
                       EscaparSQL(THIS.this_cQtds)      + ", " + ;
                       EscaparSQL(THIS.this_cTribs)     + ", " + ;
                       EscaparSQL(THIS.this_cUnids)     + ", " + ;
                       EscaparSQL(THIS.this_cValors)    + ", " + ;
                       EscaparSQL(THIS.this_cLocals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       EscaparSQL(THIS.this_cDocorigs)  + ", " + ;
                       IIF(THIS.this_lCopias, "1", "0") + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Inserir: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiGfd SET" + ;
                       "  cserifab  = " + EscaparSQL(THIS.this_cSerifab)  + "," + ;
                       "  cmodelos  = " + EscaparSQL(THIS.this_cModelos)  + "," + ;
                       "  ccoos     = " + EscaparSQL(THIS.this_cCoos)     + "," + ;
                       "  cgnfs     = " + EscaparSQL(THIS.this_cGnfs)     + "," + ;
                       "  cgrgs     = " + EscaparSQL(THIS.this_cGrgs)     + "," + ;
                       "  ccdcs     = " + EscaparSQL(THIS.this_cCdcs)     + "," + ;
                       "  ccrzs     = " + EscaparSQL(THIS.this_cCrzs)     + "," + ;
                       "  cdoctos   = " + EscaparSQL(THIS.this_cDoctos)   + "," + ;
                       "  cdatas    = " + EscaparSQL(THIS.this_cDatas)    + "," + ;
                       "  choras    = " + EscaparSQL(THIS.this_cHoras)    + "," + ;
                       "  cincmans  = " + EscaparSQL(THIS.this_cIncMans)  + "," + ;
                       "  ctipos    = " + EscaparSQL(THIS.this_cTipos)    + "," + ;
                       "  cmfs      = " + EscaparSQL(THIS.this_cMfs)      + "," + ;
                       "  cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + "," + ;
                       "  ccancel   = " + EscaparSQL(THIS.this_cCancel)   + "," + ;
                       "  cdescons  = " + EscaparSQL(THIS.this_cDescons)  + "," + ;
                       "  cdescrs   = " + EscaparSQL(THIS.this_cDescrs)   + "," + ;
                       "  cfpagtos  = " + EscaparSQL(THIS.this_cFpagtos)  + "," + ;
                       "  citems    = " + EscaparSQL(THIS.this_cItems)    + "," + ;
                       "  cpros     = " + EscaparSQL(THIS.this_cPros)     + "," + ;
                       "  cqtds     = " + EscaparSQL(THIS.this_cQtds)     + "," + ;
                       "  ctribs    = " + EscaparSQL(THIS.this_cTribs)    + "," + ;
                       "  cunids    = " + EscaparSQL(THIS.this_cUnids)    + "," + ;
                       "  cvalors   = " + EscaparSQL(THIS.this_cValors)   + "," + ;
                       "  locals    = " + EscaparSQL(THIS.this_cLocals)   + "," + ;
                       "  ntrans    = " + FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       "  cdocorigs = " + EscaparSQL(THIS.this_cDocorigs) + "," + ;
                       "  copias    = " + IIF(THIS.this_lCopias, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Atualizar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiGfd WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ExecutarExclusao: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - Validacoes de negocio antes do INSERT/UPDATE
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarAntesDeSalvar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cSerifab)
            MsgErro("S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_cCoos = "000000"
            MsgErro("COO n" + CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGnfs)
            MsgErro("Cupom n" + CHR(227) + "o Fiscal n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGrgs)
            MsgErro("Relat" + CHR(243) + "rios Gerenciais n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCdcs)
            MsgErro("Demonstrativo D" + CHR(233) + "bito e Cr" + CHR(233) + "dito n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCrzs)
            MsgErro("Redu" + CHR(231) + CHR(227) + "o Z n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDoctos)
            MsgErro("Tipo de Documento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDatas)
            MsgErro("Data do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cHoras)
            MsgErro("Hora do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCOODuplicado - Verifica se COO ja existe para a serie (INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCOODuplicado(par_cSerifab, par_cCoos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT ccoos FROM SigFiGfd" + ;
                       " WHERE cserifab = " + EscaparSQL(ALLTRIM(par_cSerifab)) + ;
                       " AND ccoos = " + EscaparSQL(ALLTRIM(par_cCoos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_VerCoo")
                TABLEREVERT(.T., "cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerCoo")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VerCoo") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.VerificarCOODuplicado: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloDaSerie - Busca o modelo associado a uma serie de fabricacao
    * (faz query em SigFiMpf pois cserifab e criptografado)
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloDaSerie(par_cSerifab)
        LOCAL loc_cSQL, loc_nResult, loc_cModelo
        loc_cModelo = ""

        TRY
            loc_cSQL = "SELECT cModelos FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifab))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpFab")
                TABLEREVERT(.T., "cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFab")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpFab") > 0
                SELECT cursor_4c_TmpFab
                loc_cModelo = ALLTRIM(cModelos)
            ENDIF

            IF USED("cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterModeloDaSerie: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cModelo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMFAdis - Busca o cMFAdis do modelo (tabela SigFiMpm)
    *--------------------------------------------------------------------------
    FUNCTION ObterMFAdis(par_cModelos)
        LOCAL loc_cSQL, loc_nResult, loc_cMFAdis
        loc_cMFAdis = ""

        TRY
            loc_cSQL = "SELECT cMFAdis FROM SigFiMpm WHERE cModelos = " + ;
                       EscaparSQL(ALLTRIM(par_cModelos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpm")
                TABLEREVERT(.T., "cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpm")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpm") > 0
                SELECT cursor_4c_TmpMpm
                loc_cMFAdis = ALLTRIM(cMFAdis)
            ENDIF

            IF USED("cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterMFAdis: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMFAdis
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNumUsuars - Busca o cNumUsuars de uma serie (tabela SigFiMpf)
    *--------------------------------------------------------------------------
    FUNCTION ObterNumUsuars(par_cSerifabDecriptografada)
        LOCAL loc_cSQL, loc_nResult, loc_cNumUsuars
        loc_cNumUsuars = ""

        TRY
            loc_cSQL = "SELECT cNumUsuars FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifabDecriptografada))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpf")
                TABLEREVERT(.T., "cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpf") > 0
                SELECT cursor_4c_TmpMpf
                loc_cNumUsuars = ALLTRIM(cNumUsuars)
            ENDIF

            IF USED("cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterNumUsuars: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cNumUsuars
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarImpressoras - Busca lista de impressoras (SigFiMpf JOIN SigFiMpm)
    * Retorna cursor cursor_4c_Impressoras com campos: cimpfabs, cmarcas, cmodelos
    *--------------------------------------------------------------------------
    FUNCTION BuscarImpressoras(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.cmarcas, a.cmodelos, a.cimpfabs" + ;
                       " FROM SigFiMpf a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cmodelos"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Impressoras")
                TABLEREVERT(.T., "cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Impressoras")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar impressoras: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarImpressoras: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarModelos - Busca lista de modelos (SigFiMpm)
    * Retorna cursor cursor_4c_Modelos com campos: cModelos, cMarcas
    *--------------------------------------------------------------------------
    FUNCTION BuscarModelos(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cModelos, cMarcas FROM SigFiMpm"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Modelos")
                TABLEREVERT(.T., "cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Modelos")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarModelos: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

