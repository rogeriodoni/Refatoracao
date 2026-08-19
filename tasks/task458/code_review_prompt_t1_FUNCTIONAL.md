# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'ValidarSerieFab' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSerieFab(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDtini' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDtini(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDtfim' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDtfim(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarModelo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarModelo(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarTipo' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipo(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLGR.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1502 linhas total):

*-- Linhas 28 a 136:
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
51:             IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
52:                 IF !THIS.CarregarLista()
53:                     * Falha ao carregar nao impede a abertura do form
54:                 ENDIF
55:             ENDIF
56: 
57:             THIS.pgf_4c_Paginas.Visible = .T.
58:             THIS.pgf_4c_Paginas.ActivePage = 1
59:             THIS.this_cModoAtual = "LISTA"
60:             loc_lResultado = .T.
61: 
62:         CATCH TO loc_oErro
63:             MsgErro("Erro ao inicializar FormLGR:" + CHR(13) + loc_oErro.Message, "Erro")
64:             loc_lResultado = .F.
65:         ENDTRY
66: 
67:         RETURN loc_lResultado
68:     ENDPROC
69: 
70:     *==========================================================================
71:     * ConfigurarPageFrame - Cria PageFrame principal (Top=-29 para ocultar abas)
72:     *==========================================================================
73:     PROTECTED PROCEDURE ConfigurarPageFrame()
74:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
75:         WITH THIS.pgf_4c_Paginas
76:             .Top       = -29
77:             .Left      = 0
78:             .Width     = THIS.Width
79:             .Height    = THIS.Height + 29
80:             .PageCount = 2
81:             .Tabs      = .F.
82:             .Visible   = .T.
83:             .Page1.Caption   = "Lista"
84:             .Page1.BackColor = RGB(225, 225, 225)
85:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86:             .Page2.Caption   = "Dados"
87:             .Page2.BackColor = RGB(225, 225, 225)
88:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:         ENDWITH
90:     ENDPROC
91: 
92:     *==========================================================================
93:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
94:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
95:     *==========================================================================
96:     PROTECTED PROCEDURE ConfigurarPaginaLista()
97:         LOCAL loc_oPagina
98:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
99: 
100:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
101:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102: 
103:         *-- Cabecalho cinza escuro com titulo (Top original=2, +29comp=31)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:             .AddObject("lbl_4c_Sombra", "Label")
114:             WITH .lbl_4c_Sombra
115:                 .Caption   = THIS.Caption
116:                 .Top       = 15
117:                 .Left      = 10
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .FontName  = "Tahoma"
121:                 .FontSize  = 16
122:                 .FontBold  = .T.
123:                 .ForeColor = RGB(0, 0, 0)
124:                 .BackStyle = 0
125:                 .AutoSize  = .F.
126:                 .Visible   = .T.
127:             ENDWITH
128:             .AddObject("lbl_4c_Titulo", "Label")
129:             WITH .lbl_4c_Titulo
130:                 .Caption   = THIS.Caption
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 46
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16

*-- Linhas 420 a 483:
420:             .Visible           = .T.
421:         ENDWITH
422: 
423:         *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
424:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
425:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
427:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
428:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
429:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
430: 
431:         *-- BINDEVENTs dos campos de filtro
432:         BINDEVENT(loc_oPagina.txt_4c_SerieFab, "KeyPress", THIS, "ValidarSerieFab")
433:         BINDEVENT(loc_oPagina.txt_4c_Dtini,    "KeyPress", THIS, "ValidarDtini")
434:         BINDEVENT(loc_oPagina.txt_4c_Dtfim,    "KeyPress", THIS, "ValidarDtfim")
435: 
436:         THIS.TornarControlesVisiveis(loc_oPagina)
437:     ENDPROC
438: 
439:     *==========================================================================
440:     * ConfigurarPaginaDados - Page2: campos de edicao e botoes salvar/cancelar
441:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
442:     *==========================================================================
443:     PROTECTED PROCEDURE ConfigurarPaginaDados()
444:         LOCAL loc_oPagina
445:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
446: 
447:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
448:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
449: 
450:         *-- Container botoes Confirmar/Cancelar (grupo_salva canonico)
451:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
452:         WITH loc_oPagina.cnt_4c_Salva
453:             .Top         = 33
454:             .Left        = 842
455:             .Width       = 160
456:             .Height      = 85
457:             .BackStyle   = 0
458:             .BorderWidth = 0
459:             .Visible     = .T.
460:         ENDWITH
461: 
462:         WITH loc_oPagina.cnt_4c_Salva
463:             .AddObject("cmd_4c_Confirmar", "CommandButton")
464:             WITH .cmd_4c_Confirmar
465:                 .Caption         = "Confirmar"
466:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
467:                 .PicturePosition = 13
468:                 .Top             = 5
469:                 .Left            = 5
470:                 .Width           = 75
471:                 .Height          = 75
472:                 .BackColor       = RGB(255, 255, 255)
473:                 .ForeColor       = RGB(90, 90, 90)
474:                 .FontName        = "Comic Sans MS"
475:                 .FontSize        = 8
476:                 .FontBold        = .T.
477:                 .FontItalic      = .T.
478:                 .SpecialEffect   = 0
479:                 .MousePointer    = 15
480:                 .WordWrap        = .T.
481:                 .Visible         = .T.
482:             ENDWITH
483:             .AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 793 a 849:
793:             .Visible   = .T.
794:         ENDWITH
795: 
796:         *-- BINDEVENTs botoes Page2 (PUBLIC methods)
797:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
798:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
799: 
800:         *-- BINDEVENTs formatadores e lookups de campos Page2
801:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ValidarModelo")
802:         BINDEVENT(loc_oPagina.txt_4c_Coo,    "LostFocus", THIS, "FormatarCoo")
803:         BINDEVENT(loc_oPagina.txt_4c_Cnf,    "LostFocus", THIS, "FormatarCnf")
804:         BINDEVENT(loc_oPagina.txt_4c_Rg,     "LostFocus", THIS, "FormatarRg")
805:         BINDEVENT(loc_oPagina.txt_4c_Dcd,    "LostFocus", THIS, "FormatarDcd")
806:         BINDEVENT(loc_oPagina.txt_4c_Rz,     "LostFocus", THIS, "FormatarRz")
807:         BINDEVENT(loc_oPagina.txt_4c_Tipo,   "KeyPress", THIS, "ValidarTipo")
808: 
809:         THIS.TornarControlesVisiveis(loc_oPagina)
810:     ENDPROC
811: 
812:     *==========================================================================
813:     * CarregarLista - Busca registros via BO e configura o grid
814:     * Le filtros de Page1, chama Buscar(), monta colunas do grid
815:     *==========================================================================
816:     PROTECTED FUNCTION CarregarLista()
817:         LOCAL loc_lResultado, loc_oPg1, loc_oGrid
818:         LOCAL loc_cSerifab, loc_dDtini, loc_dDtfim
819:         loc_lResultado = .F.
820: 
821:         TRY
822:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
823:                 loc_lResultado = .T.
824:             ELSE
825:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
826:                 loc_oGrid = loc_oPg1.grd_4c_Lista
827: 
828:                 *-- Ler filtros atuais
829:                 loc_cSerifab = ""
830:                 loc_dDtini   = {}
831:                 loc_dDtfim   = {}
832: 
833:                 IF PEMSTATUS(loc_oPg1, "txt_4c_SerieFab", 5)
834:                     loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
835:                 ENDIF
836:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Dtini", 5)
837:                     IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) = "D"
838:                         loc_dDtini = loc_oPg1.txt_4c_Dtini.Value
839:                     ENDIF
840:                 ENDIF
841:                 IF PEMSTATUS(loc_oPg1, "txt_4c_Dtfim", 5)
842:                     IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) = "D"
843:                         loc_dDtfim = loc_oPg1.txt_4c_Dtfim.Value
844:                     ENDIF
845:                 ENDIF
846: 
847:                 IF THIS.this_oBusinessObject.Buscar(loc_cSerifab, loc_dDtini, loc_dDtfim)
848:                     *-- RecordSource e ColumnCount FORA do WITH para garantir criacao das colunas
849:                     loc_oGrid.ColumnCount = 3

*-- Linhas 908 a 1502:
908:     *==========================================================================
909:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
910:     *==========================================================================
911:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
912:         IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
913:             RETURN .F.
914:         ENDIF
915: 
916:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
917: 
918:         IF par_nPagina = 1
919:             THIS.this_cModoAtual = "LISTA"
920:         ENDIF
921: 
922:         RETURN .T.
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * BtnIncluirClick - Prepara form para inclusao de novo registro
927:     *==========================================================================
928:     PROCEDURE BtnIncluirClick()
929:         THIS.this_oBusinessObject.NovoRegistro()
930:         THIS.LimparCampos()
931:         THIS.this_cModoAtual = "INCLUIR"
932:         THIS.HabilitarCampos(.T.)
933:         THIS.AjustarBotoesPorModo()
934:         THIS.AlternarPagina(2)
935:         THIS.pgf_4c_Paginas.Page2.txt_4c_Modelo.SetFocus
936:     ENDPROC
937: 
938:     *==========================================================================
939:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
940:     *==========================================================================
941:     PROCEDURE BtnVisualizarClick()
942:         LOCAL loc_cIdChaves
943:         loc_cIdChaves = ""
944: 
945:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
946:             MsgAviso("Nenhum registro selecionado.", "Aviso")
947:             RETURN
948:         ENDIF
949: 
950:         SELECT cursor_4c_Dados
951:         loc_cIdChaves = ALLTRIM(cidchaves)
952: 
953:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
954:             THIS.this_cModoAtual = "VISUALIZAR"
955:             THIS.BOParaForm()
956:             THIS.HabilitarCampos(.F.)
957:             THIS.AjustarBotoesPorModo()
958:             THIS.AlternarPagina(2)
959:         ENDIF
960:     ENDPROC
961: 
962:     *==========================================================================
963:     * BtnAlterarClick - Carrega registro selecionado para edicao
964:     * Regra do legado: so permite alterar registros com cincmans='M' (manual)
965:     *==========================================================================
966:     PROCEDURE BtnAlterarClick()
967:         LOCAL loc_cIdChaves, loc_cIncMans
968:         loc_cIdChaves = ""
969:         loc_cIncMans  = ""
970: 
971:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
972:             MsgAviso("Nenhum registro selecionado.", "Aviso")
973:             RETURN
974:         ENDIF
975: 
976:         SELECT cursor_4c_Dados
977:         loc_cIdChaves = ALLTRIM(cidchaves)
978:         loc_cIncMans  = ALLTRIM(cincmans)
979: 
980:         IF loc_cIncMans <> "M"
981:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
982:                      "do manualmente, n" + CHR(227) + "o pode ser Alterado.", "Aviso")
983:             RETURN
984:         ENDIF
985: 
986:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
987:             THIS.this_oBusinessObject.EditarRegistro()
988:             THIS.this_cModoAtual = "ALTERAR"
989:             THIS.BOParaForm()
990:             THIS.HabilitarCampos(.T.)
991:             THIS.AjustarBotoesPorModo()
992:             THIS.AlternarPagina(2)
993:         ENDIF
994:     ENDPROC
995: 
996:     *==========================================================================
997:     * BtnExcluirClick - Exclui registro selecionado (somente inclusao manual)
998:     *==========================================================================
999:     PROCEDURE BtnExcluirClick()
1000:         LOCAL loc_cIdChaves, loc_cIncMans
1001:         loc_cIdChaves = ""
1002:         loc_cIncMans  = ""
1003: 
1004:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1005:             MsgAviso("Nenhum registro selecionado.", "Aviso")
1006:             RETURN
1007:         ENDIF
1008: 
1009:         SELECT cursor_4c_Dados
1010:         loc_cIdChaves = ALLTRIM(cidchaves)
1011:         loc_cIncMans  = ALLTRIM(cincmans)
1012: 
1013:         IF loc_cIncMans <> "M"
1014:             MsgAviso("Registro n" + CHR(227) + "o inclu" + CHR(237) + ;
1015:                      "do manualmente, n" + CHR(227) + "o pode ser Exclu" + CHR(237) + "do.", "Aviso")
1016:             RETURN
1017:         ENDIF
1018: 
1019:         IF MsgConfirma("Deseja excluir este registro?", "Confirma" + CHR(231) + CHR(227) + "o")
1020:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cIdChaves)
1021:                 IF THIS.this_oBusinessObject.Excluir()
1022:                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "")
1023:                     THIS.CarregarLista()
1024:                 ENDIF
1025:             ENDIF
1026:         ENDIF
1027:     ENDPROC
1028: 
1029:     *==========================================================================
1030:     * BtnBuscarClick - Executa busca com os filtros preenchidos em Page1
1031:     * Valida que serie foi informada (conforme legado)
1032:     *==========================================================================
1033:     PROCEDURE BtnBuscarClick()
1034:         LOCAL loc_oPg1, loc_cSerifab
1035:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1036:         loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1037: 
1038:         IF EMPTY(loc_cSerifab)
1039:             MsgAviso("Informe a S" + CHR(233) + "rie de Fabrica" + CHR(231) + ;
1040:                      CHR(227) + "o e as datas para pesquisar.", "Aviso")
1041:             loc_oPg1.txt_4c_SerieFab.SetFocus
1042:             RETURN
1043:         ENDIF
1044: 
1045:         IF EMPTY(loc_oPg1.txt_4c_Dtini.Value) OR EMPTY(loc_oPg1.txt_4c_Dtfim.Value)
1046:             MsgAviso("Informe o per" + CHR(237) + "odo de datas para pesquisar.", "Aviso")
1047:             RETURN
1048:         ENDIF
1049: 
1050:         THIS.CarregarLista()
1051:     ENDPROC
1052: 
1053:     *==========================================================================
1054:     * BtnEncerrarClick - Fecha o formulario
1055:     *==========================================================================
1056:     PROCEDURE BtnEncerrarClick()
1057:         THIS.Release()
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * BtnSalvarClick - Valida e salva registro (INSERT ou UPDATE via BO)
1062:     *==========================================================================
1063:     PROCEDURE BtnSalvarClick()
1064:         LOCAL loc_oPg2
1065:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1066: 
1067:         *-- Validacoes de UI antes do TRY (nao usar RETURN dentro de TRY)
1068:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Modelo.Value))
1069:             MsgAviso("Modelo n" + CHR(227) + "o pode estar em branco.", "Aviso")
1070:             loc_oPg2.txt_4c_Modelo.SetFocus
1071:             RETURN
1072:         ENDIF
1073: 
1074:         THIS.FormParaBO()
1075: 
1076:         IF THIS.this_oBusinessObject.Salvar()
1077:             MsgInfo("Registro salvo com sucesso!", "")
1078:             THIS.AlternarPagina(1)
1079:             THIS.CarregarLista()
1080:         ENDIF
1081:     ENDPROC
1082: 
1083:     *==========================================================================
1084:     * BtnCancelarClick - Cancela edicao e volta para a lista
1085:     *==========================================================================
1086:     PROCEDURE BtnCancelarClick()
1087:         THIS.AlternarPagina(1)
1088:         THIS.this_cModoAtual = "LISTA"
1089:         THIS.CarregarLista()
1090:     ENDPROC
1091: 
1092:     *==========================================================================
1093:     * FormParaBO - Transfere valores dos campos do form para o BO
1094:     *==========================================================================
1095:     PROTECTED PROCEDURE FormParaBO()
1096:         LOCAL loc_oPg1, loc_oPg2, loc_cHoras
1097:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1098:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1099: 
1100:         WITH THIS.this_oBusinessObject
1101:             .this_cModelos = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1102:             .this_cCoos    = ALLTRIM(loc_oPg2.txt_4c_Coo.Value)
1103:             .this_cGnfs    = ALLTRIM(loc_oPg2.txt_4c_Cnf.Value)
1104:             .this_cGrgs    = ALLTRIM(loc_oPg2.txt_4c_Rg.Value)
1105:             .this_cCdcs    = ALLTRIM(loc_oPg2.txt_4c_Dcd.Value)
1106:             .this_cCrzs    = ALLTRIM(loc_oPg2.txt_4c_Rz.Value)
1107:             .this_cDoctos  = ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)
1108: 
1109:             *-- Data: TextBox.Value eh Date -> converter para string YYYYMMDD
1110:             IF VARTYPE(loc_oPg2.txt_4c_Dtmov.Value) = "D" AND !EMPTY(loc_oPg2.txt_4c_Dtmov.Value)
1111:                 .this_cDatas = DTOS(loc_oPg2.txt_4c_Dtmov.Value)
1112:             ELSE
1113:                 .this_cDatas = ""
1114:             ENDIF
1115: 
1116:             *-- Hora: string HH:MM:SS -> HHMMSS (strip colons)
1117:             loc_cHoras   = STRTRAN(ALLTRIM(loc_oPg2.txt_4c_Hrmov.Value), ":", "")
1118:             .this_cHoras = loc_cHoras
1119: 
1120:             *-- Inclusao manual flag
1121:             IF THIS.this_cModoAtual = "INCLUIR"
1122:                 .this_cIncMans = "M"
1123:                 *-- Serie vem do filtro de Page1
1124:                 .this_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1125:             ENDIF
1126:         ENDWITH
1127:     ENDPROC
1128: 
1129:     *==========================================================================
1130:     * BOParaForm - Transfere valores do BO para os campos do form
1131:     *==========================================================================
1132:     PROTECTED PROCEDURE BOParaForm()
1133:         LOCAL loc_oPg2, loc_cDatas, loc_cHoras
1134:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1135: 
1136:         WITH THIS.this_oBusinessObject
1137:             loc_oPg2.txt_4c_Codigo.Value = .this_cIdChaves
1138:             loc_oPg2.txt_4c_Modelo.Value = .this_cModelos
1139:             loc_oPg2.txt_4c_Coo.Value    = .this_cCoos
1140:             loc_oPg2.txt_4c_Cnf.Value    = .this_cGnfs
1141:             loc_oPg2.txt_4c_Rg.Value     = .this_cGrgs
1142:             loc_oPg2.txt_4c_Dcd.Value    = .this_cCdcs
1143:             loc_oPg2.txt_4c_Rz.Value     = .this_cCrzs
1144:             loc_oPg2.txt_4c_Tipo.Value   = .this_cDoctos
1145: 
1146:             *-- Data: string YYYYMMDD -> Date (via STOD)
1147:             loc_cDatas = ALLTRIM(.this_cDatas)
1148:             IF LEN(loc_cDatas) = 8
1149:                 loc_oPg2.txt_4c_Dtmov.Value = STOD(loc_cDatas)
1150:             ELSE
1151:                 loc_oPg2.txt_4c_Dtmov.Value = {}
1152:             ENDIF
1153: 
1154:             *-- Hora: string HHMMSS -> HH:MM:SS
1155:             loc_cHoras = ALLTRIM(.this_cHoras)
1156:             IF LEN(loc_cHoras) = 6
1157:                 loc_oPg2.txt_4c_Hrmov.Value = LEFT(loc_cHoras, 2) + ":" + ;
1158:                                                SUBSTR(loc_cHoras, 3, 2) + ":" + ;
1159:                                                RIGHT(loc_cHoras, 2)
1160:             ELSE
1161:                 loc_oPg2.txt_4c_Hrmov.Value = ""
1162:             ENDIF
1163:         ENDWITH
1164:     ENDPROC
1165: 
1166:     *==========================================================================
1167:     * HabilitarCampos - Habilita ou desabilita campos da Page2 para edicao
1168:     *==========================================================================
1169:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1170:         LOCAL loc_oPg2
1171:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1172: 
1173:         *-- txt_4c_Codigo (NFAB) sempre ReadOnly
1174:         loc_oPg2.txt_4c_Modelo.ReadOnly = !par_lHabilitar
1175:         loc_oPg2.txt_4c_Coo.ReadOnly    = !par_lHabilitar
1176:         loc_oPg2.txt_4c_Cnf.ReadOnly    = !par_lHabilitar
1177:         loc_oPg2.txt_4c_Rg.ReadOnly     = !par_lHabilitar
1178:         loc_oPg2.txt_4c_Dcd.ReadOnly    = !par_lHabilitar
1179:         loc_oPg2.txt_4c_Rz.ReadOnly     = !par_lHabilitar
1180:         loc_oPg2.txt_4c_Tipo.ReadOnly   = !par_lHabilitar
1181:         loc_oPg2.txt_4c_Dtmov.ReadOnly  = !par_lHabilitar
1182:         loc_oPg2.txt_4c_Hrmov.ReadOnly  = !par_lHabilitar
1183:     ENDPROC
1184: 
1185:     *==========================================================================
1186:     * LimparCampos - Limpa todos os campos da Page2
1187:     *==========================================================================
1188:     PROTECTED PROCEDURE LimparCampos()
1189:         LOCAL loc_oPg2
1190:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1191: 
1192:         loc_oPg2.txt_4c_Codigo.Value = ""
1193:         loc_oPg2.txt_4c_Modelo.Value = ""
1194:         loc_oPg2.txt_4c_Coo.Value    = "000000"
1195:         loc_oPg2.txt_4c_Cnf.Value    = ""
1196:         loc_oPg2.txt_4c_Rg.Value     = ""
1197:         loc_oPg2.txt_4c_Dcd.Value    = ""
1198:         loc_oPg2.txt_4c_Rz.Value     = ""
1199:         loc_oPg2.txt_4c_Tipo.Value   = ""
1200:         loc_oPg2.txt_4c_Dtmov.Value  = DATE()
1201:         loc_oPg2.txt_4c_Hrmov.Value  = ""
1202:     ENDPROC
1203: 
1204:     *==========================================================================
1205:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo
1206:     *==========================================================================
1207:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1208:         LOCAL loc_oPg2, loc_lEditar
1209:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1210:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1211: 
1212:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditar
1213:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1214:     ENDPROC
1215: 
1216:     *==========================================================================
1217:     * ValidarSerieFab - LostFocus do campo serie em Page1
1218:     * Valida serie contra SigFiMpf e abre picker se nao encontrar exato
1219:     *==========================================================================
1220:     PROCEDURE ValidarSerieFab(par_nKeyCode, par_nShiftAltCtrl)
1221:         LOCAL loc_oPg1, loc_cSerifab, loc_oBusca
1222:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1223:         loc_cSerifab = ALLTRIM(loc_oPg1.txt_4c_SerieFab.Value)
1224: 
1225:         IF EMPTY(loc_cSerifab)
1226:             RETURN
1227:         ENDIF
1228: 
1229:         *-- Buscar serie exata em SigFiMpf
1230:         IF THIS.this_oBusinessObject.BuscarImpressoras("a.cimpfabs = " + EscaparSQL(loc_cSerifab))
1231:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 1
1232:                 SELECT cursor_4c_Impressoras
1233:                 loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(cimpfabs)
1234:                 USE IN cursor_4c_Impressoras
1235:                 RETURN
1236:             ENDIF
1237:             IF USED("cursor_4c_Impressoras")
1238:                 USE IN cursor_4c_Impressoras
1239:             ENDIF
1240:         ENDIF
1241: 
1242:         *-- Nao encontrou exato: buscar por LIKE e exibir picker
1243:         IF !THIS.this_oBusinessObject.BuscarImpressoras( ;
1244:                 "a.cimpfabs LIKE " + EscaparSQL(loc_cSerifab + "%"))
1245:             THIS.this_oBusinessObject.BuscarImpressoras("")
1246:         ELSE
1247:             IF USED("cursor_4c_Impressoras") AND RECCOUNT("cursor_4c_Impressoras") = 0
1248:                 USE IN cursor_4c_Impressoras
1249:                 THIS.this_oBusinessObject.BuscarImpressoras("")
1250:             ENDIF
1251:         ENDIF
1252: 
1253:         IF USED("cursor_4c_Impressoras")
1254:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1255:             IF VARTYPE(loc_oBusca) = "O"
1256:                 loc_oBusca.DefinirCursor("cursor_4c_Impressoras", "cimpfabs", "cmarcas", ;
1257:                     "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o")
1258:                 loc_oBusca.Mostrar()
1259:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1260:                     loc_oPg1.txt_4c_SerieFab.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1261:                 ENDIF
1262:                 loc_oBusca.Release()
1263:             ENDIF
1264:             IF USED("cursor_4c_Impressoras")
1265:                 USE IN cursor_4c_Impressoras
1266:             ENDIF
1267:         ENDIF
1268:     ENDPROC
1269: 
1270:     *==========================================================================
1271:     * ValidarDtini - LostFocus da data inicio (valida tipo Date)
1272:     *==========================================================================
1273:     PROCEDURE ValidarDtini(par_nKeyCode, par_nShiftAltCtrl)
1274:         LOCAL loc_oPg1
1275:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1276:         IF VARTYPE(loc_oPg1.txt_4c_Dtini.Value) <> "D"
1277:             loc_oPg1.txt_4c_Dtini.Value = DATE()
1278:         ENDIF
1279:     ENDPROC
1280: 
1281:     *==========================================================================
1282:     * ValidarDtfim - LostFocus da data fim (valida tipo Date)
1283:     *==========================================================================
1284:     PROCEDURE ValidarDtfim(par_nKeyCode, par_nShiftAltCtrl)
1285:         LOCAL loc_oPg1
1286:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1287:         IF VARTYPE(loc_oPg1.txt_4c_Dtfim.Value) <> "D"
1288:             loc_oPg1.txt_4c_Dtfim.Value = DATE()
1289:         ENDIF
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * ValidarModelo - LostFocus do campo modelo em Page2
1294:     * Busca em SigFiMpm e abre picker se nao encontrar exato
1295:     *==========================================================================
1296:     PROCEDURE ValidarModelo(par_nKeyCode, par_nShiftAltCtrl)
1297:         LOCAL loc_oPg2, loc_cModelo, loc_oBusca
1298:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1299:         loc_cModelo = ALLTRIM(loc_oPg2.txt_4c_Modelo.Value)
1300: 
1301:         IF EMPTY(loc_cModelo) OR !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1302:             RETURN
1303:         ENDIF
1304: 
1305:         *-- Buscar modelo exato em SigFiMpm
1306:         IF THIS.this_oBusinessObject.BuscarModelos("cModelos = " + EscaparSQL(loc_cModelo))
1307:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 1
1308:                 SELECT cursor_4c_Modelos
1309:                 loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(cModelos)
1310:                 USE IN cursor_4c_Modelos
1311:                 RETURN
1312:             ENDIF
1313:             IF USED("cursor_4c_Modelos")
1314:                 USE IN cursor_4c_Modelos
1315:             ENDIF
1316:         ENDIF
1317: 
1318:         *-- Nao encontrou: buscar por LIKE e exibir picker
1319:         IF !THIS.this_oBusinessObject.BuscarModelos( ;
1320:                 "cModelos LIKE " + EscaparSQL(loc_cModelo + "%"))
1321:             THIS.this_oBusinessObject.BuscarModelos("")
1322:         ELSE
1323:             IF USED("cursor_4c_Modelos") AND RECCOUNT("cursor_4c_Modelos") = 0
1324:                 USE IN cursor_4c_Modelos
1325:                 THIS.this_oBusinessObject.BuscarModelos("")
1326:             ENDIF
1327:         ENDIF
1328: 
1329:         IF USED("cursor_4c_Modelos")
1330:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1331:             IF VARTYPE(loc_oBusca) = "O"
1332:                 loc_oBusca.DefinirCursor("cursor_4c_Modelos", "cModelos", "cMarcas", "Modelos")
1333:                 loc_oBusca.Mostrar()
1334:                 IF !EMPTY(ALLTRIM(loc_oBusca.cCodigoSelecionado))
1335:                     loc_oPg2.txt_4c_Modelo.Value = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1336:                 ENDIF
1337:                 loc_oBusca.Release()
1338:             ENDIF
1339:             IF USED("cursor_4c_Modelos")
1340:                 USE IN cursor_4c_Modelos
1341:             ENDIF
1342:         ENDIF
1343:     ENDPROC
1344: 
1345:     *==========================================================================
1346:     * ValidarTipo - LostFocus do campo tipo de documento em Page2
1347:     *==========================================================================
1348:     PROCEDURE ValidarTipo(par_nKeyCode, par_nShiftAltCtrl)
1349:         LOCAL loc_oPg2
1350:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1351:         IF LEN(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value)) > 2
1352:             loc_oPg2.txt_4c_Tipo.Value = LEFT(ALLTRIM(loc_oPg2.txt_4c_Tipo.Value), 2)
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *==========================================================================
1357:     * FormatarCoo - LostFocus do COO: formata como string numerica 6 digitos
1358:     * Replica comportamento do legado: Transform(VAL(Value), '@L 999999')
1359:     *==========================================================================
1360:     PROCEDURE FormatarCoo()
1361:         LOCAL loc_oPg2
1362:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1363:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1364:             RETURN
1365:         ENDIF
1366:         WITH loc_oPg2.txt_4c_Coo
1367:             IF !EMPTY(ALLTRIM(.Value))
1368:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1369:                 .Refresh()
1370:             ENDIF
1371:         ENDWITH
1372:     ENDPROC
1373: 
1374:     *==========================================================================
1375:     * FormatarCnf - LostFocus do Cupom nao Fiscal: mesma formatacao
1376:     *==========================================================================
1377:     PROCEDURE FormatarCnf()
1378:         LOCAL loc_oPg2
1379:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1380:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1381:             RETURN
1382:         ENDIF
1383:         WITH loc_oPg2.txt_4c_Cnf
1384:             IF !EMPTY(ALLTRIM(.Value))
1385:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1386:                 .Refresh()
1387:             ENDIF
1388:         ENDWITH
1389:     ENDPROC
1390: 
1391:     *==========================================================================
1392:     * FormatarRg - LostFocus do Relatorio Gerencial: mesma formatacao
1393:     *==========================================================================
1394:     PROCEDURE FormatarRg()
1395:         LOCAL loc_oPg2
1396:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1397:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1398:             RETURN
1399:         ENDIF
1400:         WITH loc_oPg2.txt_4c_Rg
1401:             IF !EMPTY(ALLTRIM(.Value))
1402:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1403:                 .Refresh()
1404:             ENDIF
1405:         ENDWITH
1406:     ENDPROC
1407: 
1408:     *==========================================================================
1409:     * FormatarDcd - LostFocus do DCD: formata como string numerica 4 digitos
1410:     *==========================================================================
1411:     PROCEDURE FormatarDcd()
1412:         LOCAL loc_oPg2
1413:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1414:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1415:             RETURN
1416:         ENDIF
1417:         WITH loc_oPg2.txt_4c_Dcd
1418:             IF !EMPTY(ALLTRIM(.Value))
1419:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 9999")
1420:                 .Refresh()
1421:             ENDIF
1422:         ENDWITH
1423:     ENDPROC
1424: 
1425:     *==========================================================================
1426:     * FormatarRz - LostFocus da Reducao Z: formata como string numerica 6 digitos
1427:     *==========================================================================
1428:     PROCEDURE FormatarRz()
1429:         LOCAL loc_oPg2
1430:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1431:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1432:             RETURN
1433:         ENDIF
1434:         WITH loc_oPg2.txt_4c_Rz
1435:             IF !EMPTY(ALLTRIM(.Value))
1436:                 .Value = TRANSFORM(VAL(ALLTRIM(.Value)), "@L 999999")
1437:                 .Refresh()
1438:             ENDIF
1439:         ENDWITH
1440:     ENDPROC
1441: 
1442:     *==========================================================================
1443:     * TornarControlesVisiveis - Torna todos os controles do container visiveis
1444:     *==========================================================================
1445:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1446:         LOCAL loc_i, loc_oControl, loc_nP
1447: 
1448:         IF VARTYPE(par_oContainer) <> "O"
1449:             RETURN
1450:         ENDIF
1451: 
1452:         FOR loc_i = 1 TO par_oContainer.ControlCount
1453:             loc_oControl = par_oContainer.Controls(loc_i)
1454: 
1455:             IF VARTYPE(loc_oControl) = "O"
1456:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1457:                     loc_oControl.Visible = .T.
1458:                 ENDIF
1459: 
1460:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1461:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1462:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1463:                     ENDFOR
1464:                 ENDIF
1465: 
1466:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1467:                     THIS.TornarControlesVisiveis(loc_oControl)
1468:                 ENDIF
1469:             ENDIF
1470:         ENDFOR
1471:     ENDPROC
1472: 
1473:     *==========================================================================
1474:     * FormatarGridLista - Formata fonte do grid apos carregar dados
1475:     *==========================================================================
1476:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1477:         IF VARTYPE(par_oGrid) <> "O"
1478:             RETURN
1479:         ENDIF
1480: 
1481:         WITH par_oGrid
1482:             .FontName = "Tahoma"
1483:             .FontSize = 8
1484:         ENDWITH
1485:     ENDPROC
1486: 
1487:     *==========================================================================
1488:     * Destroy - Libera recursos do form
1489:     *==========================================================================
1490:     PROCEDURE Destroy()
1491:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1492:             THIS.this_oBusinessObject = .NULL.
1493:         ENDIF
1494: 
1495:         IF USED("cursor_4c_Dados")
1496:             USE IN cursor_4c_Dados
1497:         ENDIF
1498: 
1499:         DODEFAULT()
1500:     ENDPROC
1501: 
1502: ENDDEFINE


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

