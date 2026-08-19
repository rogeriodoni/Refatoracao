# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [BINDEVENT-PARAMS] Handler 'ValidarMoeEq' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoeEq(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarFpag' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarFpag(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarValAdics' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarValAdics(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'COTACAO' (parent: SIGCDMOE.Pagina.Lista): Top original=5 vs migrado 'chk_4c_Cotacao' Top=144 (diff=139px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMoe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1677 linhas total):

*-- Linhas 26 a 146:
26:     *==========================================================================
27:     * Init - Inicializa o formulario
28:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
29:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
30:     *==========================================================================
31:     PROCEDURE Init()
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *==========================================================================
36:     * InicializarForm - Configura estrutura completa
37:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
38:     *==========================================================================
39:     PROTECTED PROCEDURE InicializarForm()
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.this_oBusinessObject = CREATEOBJECT("MoeBO")
45: 
46:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
47:                 MostrarErro("Erro ao criar MoeBO" + CHR(13) + ;
48:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
49:                     "FormMoe.InicializarForm")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55: 
56:                 THIS.pgf_4c_Paginas.Visible   = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 
60:                 THIS.CarregarLista()
61:                 loc_lSucesso = .T.
62:             ENDIF
63: 
64:         CATCH TO loException
65:             MostrarErro("Erro ao inicializar FormMoe:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormMoe.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *==========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 esconde abas; todos os controles compensam +29 no Top
77:     *==========================================================================
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
103:     *==========================================================================
104:     * ConfigurarPaginaLista - Configura Page1: cabecalho, botoes CRUD e grid
105:     *==========================================================================
106:     PROTECTED PROCEDURE ConfigurarPaginaLista()
107:         LOCAL loc_oPagina
108:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
109: 
110:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         *-- Container Cabecalho (cntSombra no legado)
114:         *-- Original: cntSombra.Top=1. Com compensacao PageFrame +29: Top=30
115:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPagina.cnt_4c_Cabecalho
117:             .Top         = 30
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackColor   = RGB(100, 100, 100)
122:             .BorderWidth = 0
123:             .Visible     = .T.
124:         ENDWITH
125: 
126:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
127:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
128:             .Caption   = "Cadastro de Moedas"
129:             .Top       = 15
130:             .Left      = 10
131:             .Width     = THIS.Width - 20
132:             .Height    = 46
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:             .AutoSize  = .F.
139:             .Visible   = .T.
140:         ENDWITH
141: 
142:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Caption   = "Cadastro de Moedas"
145:             .Top       = 18
146:             .Left      = 10

*-- Linhas 387 a 448:
387:             .Column3.Alignment       = 1
388:         ENDWITH
389: 
390:         *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
397:         BINDEVENT(loc_oPagina.cmd_4c_Cambio,                   "Click", THIS, "BtnCambioClick")
398: 
399:         THIS.TornarControlesVisiveis(loc_oPagina)
400:     ENDPROC
401: 
402:     *==========================================================================
403:     * ConfigurarPaginaDados - Configura Page2: botoes Salvar/Cancelar + TODOS os campos
404:     * Campos: Codigo, Descricao, Cotacao, FMult, Spinner, MoeEq, Qtde, Tabref,
405:     *   FPG (lookup SigOpFp), Toleras, OptTipo(Consultas), DisfPres, ValAdics,
406:     *   Grupo, SubGrupo + shapes separadores
407:     *==========================================================================
408:     PROTECTED PROCEDURE ConfigurarPaginaDados()
409:         LOCAL loc_oPagina
410:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
411: 
412:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
413:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
414: 
415:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
416:         *-- Original: Grupo_Salva.Top=16, Left=619. Compensacao +29: Top=45
417:         *-- Left canonico do framework: 842 (form Width=1000)
418:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
419:         WITH loc_oPagina.cnt_4c_Salva
420:             .Top         = 45
421:             .Left        = 842
422:             .Width       = 160
423:             .Height      = 85
424:             .BackStyle = 1
425:             .BackColor = RGB(255, 255, 255)
426:             .Visible     = .T.
427:         ENDWITH
428: 
429:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
430:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
431:             .Caption         = "Confirmar"
432:             .Top             = 5
433:             .Left            = 5
434:             .Width           = 75
435:             .Height          = 75
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
437:             .PicturePosition = 13
438:             .FontName        = "Comic Sans MS"
439:             .FontSize        = 8
440:             .FontBold        = .T.
441:             .FontItalic      = .T.
442:             .ForeColor       = RGB(90, 90, 90)
443:             .BackColor       = RGB(255, 255, 255)
444:             .Themes          = .F.
445:             .SpecialEffect   = 0
446:             .MousePointer    = 15
447:             .WordWrap        = .T.
448:             .AutoSize        = .F.

*-- Linhas 790 a 854:
790:             .Visible    = .T.
791:         ENDWITH
792: 
793:         *-- GRUPO 9: Listar na consulta (OptionGroup - Consultas)
794:         *-- Say15 "Listar na consulta :" - Original Top=293, +29=322, Left=247, Width=93
795:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
796:         WITH loc_oPagina.lbl_4c_Label15
797:             .Caption    = "Listar na consulta :"
798:             .Top        = 322
799:             .Left       = 247
800:             .Width      = 93
801:             .Height     = 15
802:             .FontName   = "Tahoma"
803:             .FontSize   = 8
804:             .FontBold   = .F.
805:             .FontItalic = .F.
806:             .BackStyle  = 0
807:             .ForeColor  = RGB(90, 90, 90)
808:             .AutoSize   = .T.
809:             .Visible    = .T.
810:         ENDWITH
811: 
812:         *-- opt_tipo Consultas numeric(1) - Original Top=288, +29=317, Left=343
813:         *-- ButtonCount=2: Buttons(1)="Sim"(Value=1), Buttons(2)="Não"; OptionGroup.Value=1 default
814:         loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
815:         WITH loc_oPagina.obj_4c_OptTipo
816:             .ButtonCount = 2
817:             .Top         = 317
818:             .Left        = 343
819:             .Width       = 109
820:             .Height      = 25
821:             .AutoSize    = .T.
822:             .BackStyle   = 0
823:             .BorderStyle = 0
824:             .Value       = 1
825:             .Visible     = .T.
826:         ENDWITH
827:         WITH loc_oPagina.obj_4c_OptTipo.Buttons(1)
828:             .Caption   = "Sim"
829:             .Left      = 5
830:             .Top       = 5
831:             .Width     = 34
832:             .Height    = 15
833:             .AutoSize  = .T.
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .BackStyle = 0
837:             .ForeColor = RGB(90, 90, 90)
838:         ENDWITH
839:         WITH loc_oPagina.obj_4c_OptTipo.Buttons(2)
840:             .Caption   = "N" + CHR(227) + "o"
841:             .Left      = 62
842:             .Top       = 5
843:             .Width     = 37
844:             .Height    = 15
845:             .AutoSize  = .T.
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8
848:             .BackStyle = 0
849:             .ForeColor = RGB(90, 90, 90)
850:         ENDWITH
851: 
852:         *-- SECAO: Preco na Etiqueta do Produto
853:         *-- Shape2 separador - Original Top=352, +29=381, Left=150, Width=367, Height=2
854:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")

*-- Linhas 1051 a 1677:
1051:             .Visible    = .T.
1052:         ENDWITH
1053: 
1054:         *-- BINDEVENTs para Page2 - metodos PUBLIC (sem PROTECTED) para funcionar com BINDEVENT
1055:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
1056:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
1057:         BINDEVENT(loc_oPagina.txt_4c_MoeEq,                  "KeyPress", THIS, "ValidarMoeEq")
1058:         BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress", THIS, "ValidarFpag")
1059:         BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress",  THIS, "FpgKeyPress")
1060:         BINDEVENT(loc_oPagina.txt_4c_ValAdics,               "KeyPress", THIS, "ValidarValAdics")
1061: 
1062:         THIS.TornarControlesVisiveis(loc_oPagina)
1063:     ENDPROC
1064: 
1065:     *==========================================================================
1066:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1067:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)
1068:     *==========================================================================
1069:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1070:         LOCAL loc_nI, loc_oObjeto, loc_nP
1071: 
1072:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1073:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1074: 
1075:             IF VARTYPE(loc_oObjeto) = "O"
1076:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1077:                     loc_oObjeto.Visible = .T.
1078:                 ENDIF
1079: 
1080:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1081:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1082:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1083:                     ENDFOR
1084:                 ENDIF
1085: 
1086:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1087:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1088:                 ENDIF
1089:             ENDIF
1090:         ENDFOR
1091:     ENDPROC
1092: 
1093:     *==========================================================================
1094:     * FormatarGridLista - Formata visual do grid da lista
1095:     * Fonte Verdana (padrao do framework Grade), tamanho 8
1096:     *==========================================================================
1097:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1098:         WITH par_oGrid
1099:             .FontName = "Verdana"
1100:             .FontSize = 8
1101:         ENDWITH
1102:     ENDPROC
1103: 
1104:     *==========================================================================
1105:     * Destroy - Libera recursos ao fechar o formulario
1106:     *==========================================================================
1107:     PROCEDURE Destroy()
1108:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1109:             THIS.this_oBusinessObject = .NULL.
1110:         ENDIF
1111: 
1112:         IF USED("cursor_4c_Dados")
1113:             USE IN cursor_4c_Dados
1114:         ENDIF
1115: 
1116:         IF USED("cursor_4c_Carrega")
1117:             USE IN cursor_4c_Carrega
1118:         ENDIF
1119: 
1120:         IF USED("cursor_4c_BuscaMoe")
1121:             USE IN cursor_4c_BuscaMoe
1122:         ENDIF
1123: 
1124:         IF USED("cursor_4c_BuscaFpag")
1125:             USE IN cursor_4c_BuscaFpag
1126:         ENDIF
1127: 
1128:         DODEFAULT()
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1133:     * par_nPagina: 1=Lista, 2=Dados
1134:     *==========================================================================
1135:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1136:         LOCAL loc_lResultado
1137:         loc_lResultado = .F.
1138: 
1139:         IF VARTYPE(par_nPagina) = "N" AND BETWEEN(par_nPagina, 1, 2)
1140:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1141:             IF par_nPagina = 1
1142:                 THIS.this_cModoAtual = "LISTA"
1143:                 THIS.CarregarLista()
1144:             ENDIF
1145:             loc_lResultado = .T.
1146:         ENDIF
1147: 
1148:         RETURN loc_lResultado
1149:     ENDPROC
1150: 
1151:     *==========================================================================
1152:     * CarregarLista - Carrega dados no Grid da Page1
1153:     * Chama MoeBO.Buscar() e vincula cursor ao grid
1154:     * Columns: cmoes (Moeda/120), dmoes (Descricao/330), nordrels (Ordem/129)
1155:     *==========================================================================
1156:     PROCEDURE CarregarLista()
1157:         LOCAL loc_lResultado, loc_oGrid
1158:         loc_lResultado = .F.
1159: 
1160:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1161:             loc_lResultado = .T.
1162:         ELSE
1163:             TRY
1164:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1165: 
1166:                 IF THIS.this_oBusinessObject.Buscar("")
1167:                     loc_oGrid.ColumnCount = 3
1168:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
1169:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cmoes"
1170:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dmoes"
1171:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nordrels"
1172: 
1173:                     *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
1174:                     loc_oGrid.Column1.Header1.Caption = "Moeda"
1175:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1176:                     loc_oGrid.Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"
1177: 
1178:                     loc_oGrid.Column1.Width = 120
1179:                     loc_oGrid.Column2.Width = 330
1180:                     loc_oGrid.Column3.Width = 129
1181: 
1182:                     THIS.FormatarGridLista(loc_oGrid)
1183:                     loc_oGrid.Refresh()
1184:                     loc_lResultado = .T.
1185:                 ENDIF
1186:             CATCH TO loc_oErro
1187:                 MsgErro("Erro ao carregar lista: " + loc_oErro.Message, "Erro")
1188:             ENDTRY
1189:         ENDIF
1190: 
1191:         RETURN loc_lResultado
1192:     ENDPROC
1193: 
1194:     *==========================================================================
1195:     * BtnIncluirClick - Prepara BO para novo registro e navega para Page2
1196:     *==========================================================================
1197:     PROCEDURE BtnIncluirClick()
1198:         THIS.this_oBusinessObject.NovoRegistro()
1199:         THIS.this_cModoAtual = "INCLUIR"
1200:         THIS.LimparCampos()
1201:         THIS.HabilitarCampos(.T.)
1202:         THIS.AjustarBotoesPorModo()
1203:         THIS.pgf_4c_Paginas.ActivePage = 2
1204:         THIS.pgf_4c_Paginas.Page2.txt_4c_Moeda.SetFocus
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * BtnVisualizarClick - Carrega registro selecionado e navega para Page2 leitura
1209:     *==========================================================================
1210:     PROCEDURE BtnVisualizarClick()
1211:         LOCAL loc_cCodigo
1212:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1213:             MsgAviso("Selecione uma moeda para visualizar!", ;
1214:                 "Aten" + CHR(231) + CHR(227) + "o")
1215:             RETURN
1216:         ENDIF
1217:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
1218:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1219:             THIS.this_cModoAtual = "VISUALIZAR"
1220:             THIS.BOParaForm()
1221:             THIS.HabilitarCampos(.F.)
1222:             THIS.AjustarBotoesPorModo()
1223:             THIS.pgf_4c_Paginas.ActivePage = 2
1224:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
1225:         ENDIF
1226:     ENDPROC
1227: 
1228:     *==========================================================================
1229:     * BtnAlterarClick - Carrega registro selecionado e navega para Page2 edicao
1230:     *==========================================================================
1231:     PROCEDURE BtnAlterarClick()
1232:         LOCAL loc_cCodigo
1233:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1234:             MsgAviso("Selecione uma moeda para alterar!", ;
1235:                 "Aten" + CHR(231) + CHR(227) + "o")
1236:             RETURN
1237:         ENDIF
1238:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
1239:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1240:             THIS.this_oBusinessObject.EditarRegistro()
1241:             THIS.this_cModoAtual = "ALTERAR"
1242:             THIS.BOParaForm()
1243:             THIS.HabilitarCampos(.T.)
1244:             THIS.AjustarBotoesPorModo()
1245:             THIS.pgf_4c_Paginas.ActivePage = 2
1246:             THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus
1247:         ENDIF
1248:     ENDPROC
1249: 
1250:     *==========================================================================
1251:     * BtnExcluirClick - Confirma e exclui o registro selecionado
1252:     *==========================================================================
1253:     PROCEDURE BtnExcluirClick()
1254:         LOCAL loc_cCodigo, loc_cDesc
1255:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1256:             MsgAviso("Selecione uma moeda para excluir!", ;
1257:                 "Aten" + CHR(231) + CHR(227) + "o")
1258:             RETURN
1259:         ENDIF
1260:         loc_cCodigo = ALLTRIM(cursor_4c_Dados.cmoes)
1261:         loc_cDesc   = ALLTRIM(cursor_4c_Dados.dmoes)
1262:         IF MsgConfirma("Confirma exclus" + CHR(227) + "o da moeda:" + CHR(13) + ;
1263:                 loc_cCodigo + " - " + loc_cDesc, "Excluir Moeda")
1264:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1265:                 IF THIS.this_oBusinessObject.Excluir()
1266:                     MsgInfo("Moeda exclu" + CHR(237) + "da com sucesso!", "Sucesso")
1267:                     THIS.CarregarLista()
1268:                 ENDIF
1269:             ENDIF
1270:         ENDIF
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * BtnBuscarClick - Recarrega a lista de moedas
1275:     *==========================================================================
1276:     PROCEDURE BtnBuscarClick()
1277:         THIS.CarregarLista()
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * BtnEncerrarClick - Fecha o formulario
1282:     *==========================================================================
1283:     PROCEDURE BtnEncerrarClick()
1284:         THIS.Release()
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * BtnCambioClick - Abre gestao de cotacoes (COTACAO no legado)
1289:     * Original: Do Form SIGPRCOT With ThisForm,ThisForm.DataSessionId
1290:     * Verifica se moeda permite cotacao antes de prosseguir
1291:     *==========================================================================
1292:     PROCEDURE BtnCambioClick()
1293:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1294:             MsgAviso("Selecione uma moeda para acessar o c" + CHR(226) + "mbio!", ;
1295:                 "Aten" + CHR(231) + CHR(227) + "o")
1296:             RETURN
1297:         ENDIF
1298:         IF !(NVL(cursor_4c_Dados.cotas, 0) = 1)
1299:             MsgAviso("Moeda " + ALLTRIM(cursor_4c_Dados.cmoes) + ;
1300:                 " n" + CHR(227) + "o permite altera" + CHR(231) + CHR(227) + ;
1301:                 "o de cota" + CHR(231) + CHR(227) + "o!", ;
1302:                 "C" + CHR(226) + "mbio")
1303:             RETURN
1304:         ENDIF
1305:         MsgInfo("Form de C" + CHR(226) + "mbio (SIGPRCOT) pendente de migra" + ;
1306:             CHR(231) + CHR(227) + "o.", "C" + CHR(226) + "mbio")
1307:     ENDPROC
1308: 
1309:     *==========================================================================
1310:     * BtnSalvarClick - Salva o registro atual (Confirmar no legado)
1311:     * Validacoes da Salva.Click original:
1312:     *   INSERT: cmoes nao vazio, nao duplicado, nordrels entre 0-5
1313:     *   INSERT/ALTER: disfpres padrao 'S' se vazio (tratado no FormParaBO)
1314:     *==========================================================================
1315:     PROCEDURE BtnSalvarClick()
1316:         LOCAL loc_oPg2, loc_cCodigo, loc_nOrdem, loc_lSucesso
1317:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1318: 
1319:         *-- Validacoes ANTES do TRY (RETURN fora de TRY e correto)
1320:         IF THIS.this_cModoAtual = "INCLUIR"
1321:             loc_cCodigo = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
1322:             IF EMPTY(loc_cCodigo)
1323:                 MsgAviso("Moeda inv" + CHR(225) + "lida !!!", ;
1324:                     "Aten" + CHR(231) + CHR(227) + "o")
1325:                 loc_oPg2.txt_4c_Moeda.SetFocus
1326:                 RETURN
1327:             ENDIF
1328: 
1329:             *-- Verificar duplicidade
1330:             loc_lSucesso = .F.
1331:             TRY
1332:                 LOCAL loc_nDup
1333:                 loc_nDup = SQLEXEC(gnConnHandle, ;
1334:                     "SELECT cmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cCodigo), ;
1335:                     "cursor_4c_DupCheck")
1336:                 IF loc_nDup > 0 AND USED("cursor_4c_DupCheck") AND RECCOUNT("cursor_4c_DupCheck") > 0
1337:                     IF USED("cursor_4c_DupCheck")
1338:                         USE IN cursor_4c_DupCheck
1339:                     ENDIF
1340:                     MsgAviso("Moeda j" + CHR(225) + " cadastrada !!!", ;
1341:                         "Aten" + CHR(231) + CHR(227) + "o")
1342:                     loc_oPg2.txt_4c_Moeda.SetFocus
1343:                     RETURN
1344:                 ENDIF
1345:                 IF USED("cursor_4c_DupCheck")
1346:                     USE IN cursor_4c_DupCheck
1347:                 ENDIF
1348:             CATCH TO loc_oErro
1349:                 MsgErro("Erro ao verificar duplicidade: " + loc_oErro.Message, "Erro")
1350:                 IF USED("cursor_4c_DupCheck")
1351:                     USE IN cursor_4c_DupCheck
1352:                 ENDIF
1353:                 RETURN
1354:             ENDTRY
1355: 
1356:             *-- Verificar nordrels entre 0-5
1357:             loc_nOrdem = loc_oPg2.obj_4c_SpnNordrels.Value
1358:             IF !BETWEEN(loc_nOrdem, 0, 5)
1359:                 MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
1360:                     "rios Inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
1361:                 loc_oPg2.obj_4c_SpnNordrels.SetFocus
1362:                 RETURN
1363:             ENDIF
1364:         ENDIF
1365: 
1366:         THIS.FormParaBO()
1367: 
1368:         TRY
1369:             IF THIS.this_oBusinessObject.Salvar()
1370:                 MsgInfo("Moeda salva com sucesso!", "Sucesso")
1371:                 THIS.this_cModoAtual = "LISTA"
1372:                 THIS.AlternarPagina(1)
1373:             ENDIF
1374:         CATCH TO loc_oErro
1375:             MsgErro("Erro ao salvar: " + loc_oErro.Message, "Erro")
1376:         ENDTRY
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * BtnCancelarClick - Cancela edicao e volta para lista
1381:     * Original: Cancelar.Click chama DoDefault() e mAtivaPagina1 se plCancelar
1382:     *==========================================================================
1383:     PROCEDURE BtnCancelarClick()
1384:         THIS.this_cModoAtual = "LISTA"
1385:         THIS.AlternarPagina(1)
1386:     ENDPROC
1387: 
1388:     *==========================================================================
1389:     * ValidarMoeEq - Lookup de Moeda Equivalente (LostFocus do txt_4c_MoeEq)
1390:     * Original: Get_moeEq.Valid com fwBuscaExt em SigCdMoe
1391:     * Abre FormBuscaAuxiliar se codigo nao encontrado exato
1392:     *==========================================================================
1393:     PROCEDURE ValidarMoeEq(par_nKeyCode, par_nShiftAltCtrl)
1394:         LOCAL loc_oPg2, loc_cMoeEq, loc_oBusca, loc_nResult
1395:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1396:         loc_cMoeEq = ALLTRIM(loc_oPg2.txt_4c_MoeEq.Value)
1397: 
1398:         IF EMPTY(loc_cMoeEq)
1399:             RETURN
1400:         ENDIF
1401: 
1402:         TRY
1403:             loc_nResult = SQLEXEC(gnConnHandle, ;
1404:                 "SELECT cmoes, dmoes FROM SigCdMoe WHERE cmoes = " + EscaparSQL(loc_cMoeEq), ;
1405:                 "cursor_4c_BuscaMoe")
1406: 
1407:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaMoe") AND RECCOUNT("cursor_4c_BuscaMoe") > 0
1408:                 *-- Encontrou exato, manter valor
1409:                 IF USED("cursor_4c_BuscaMoe")
1410:                     USE IN cursor_4c_BuscaMoe
1411:                 ENDIF
1412:             ELSE
1413:                 *-- Nao encontrou exato, abrir busca
1414:                 IF USED("cursor_4c_BuscaMoe")
1415:                     USE IN cursor_4c_BuscaMoe
1416:                 ENDIF
1417: 
1418:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1419:                     "SigCdMoe", "cursor_4c_BuscaMoe", "cmoes", loc_cMoeEq, "Moedas")
1420: 
1421:                 IF VARTYPE(loc_oBusca) = "O"
1422:                     IF !loc_oBusca.this_lAchouRegistro
1423:                         loc_oBusca.mAddColuna("cmoes", "", "C" + CHR(243) + "digo")
1424:                         loc_oBusca.mAddColuna("dmoes", "", "Descri" + CHR(231) + CHR(227) + "o")
1425:                         loc_oBusca.Show()
1426:                     ENDIF
1427:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1428:                         loc_oPg2.txt_4c_MoeEq.Value = ALLTRIM(cursor_4c_BuscaMoe.cmoes)
1429:                     ELSE
1430:                         loc_oPg2.txt_4c_MoeEq.Value = ""
1431:                         loc_oPg2.txt_4c_Qtde.Value  = 0
1432:                     ENDIF
1433:                     loc_oBusca.Release()
1434:                 ENDIF
1435: 
1436:                 IF USED("cursor_4c_BuscaMoe")
1437:                     USE IN cursor_4c_BuscaMoe
1438:                 ENDIF
1439:             ENDIF
1440: 
1441:         CATCH TO loc_oErro
1442:             MsgErro("Erro ao validar moeda equivalente: " + loc_oErro.Message, "Erro")
1443:             IF USED("cursor_4c_BuscaMoe")
1444:                 USE IN cursor_4c_BuscaMoe
1445:             ENDIF
1446:         ENDTRY
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * FpgKeyPress - Handler de KeyPress para txt_4c_FPG (F4 abre lookup SigOpFp)
1451:     * BINDEVENT exige metodo PUBLIC com parametros de KeyPress
1452:     *==========================================================================
1453:     PROCEDURE FpgKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1454:         IF par_nKeyCode = 28
1455:             THIS.AbrirLookupFpag()
1456:         ENDIF
1457:     ENDPROC
1458: 
1459:     *==========================================================================
1460:     * ValidarFpag - LostFocus de txt_4c_FPG: valida condicao de pagamento em SigOpFp
1461:     * Original: GET_FPG.Valid com fwBuscaExt em SigOpFp (Fpags/Descrs)
1462:     *==========================================================================
1463:     PROCEDURE ValidarFpag(par_nKeyCode, par_nShiftAltCtrl)
1464:         LOCAL loc_oPg2, loc_cFpag, loc_nResult
1465:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1466:         loc_cFpag = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)
1467: 
1468:         IF EMPTY(loc_cFpag)
1469:             RETURN
1470:         ENDIF
1471: 
1472:         TRY
1473:             IF USED("cursor_4c_BuscaFpag")
1474:                 USE IN cursor_4c_BuscaFpag
1475:             ENDIF
1476: 
1477:             loc_nResult = SQLEXEC(gnConnHandle, ;
1478:                 "SELECT Fpags, Descrs FROM SigOpFp WHERE Fpags = " + EscaparSQL(loc_cFpag), ;
1479:                 "cursor_4c_BuscaFpag")
1480: 
1481:             IF loc_nResult > 0 AND USED("cursor_4c_BuscaFpag") AND RECCOUNT("cursor_4c_BuscaFpag") > 0
1482:                 *-- Encontrou exato, manter valor
1483:                 IF USED("cursor_4c_BuscaFpag")
1484:                     USE IN cursor_4c_BuscaFpag
1485:                 ENDIF
1486:             ELSE
1487:                 *-- Nao encontrou, abrir busca
1488:                 IF USED("cursor_4c_BuscaFpag")
1489:                     USE IN cursor_4c_BuscaFpag
1490:                 ENDIF
1491:                 THIS.AbrirLookupFpag()
1492:             ENDIF
1493: 
1494:         CATCH TO loc_oErro
1495:             MsgErro("Erro ao validar cond. pagamento: " + loc_oErro.Message, "Erro")
1496:             IF USED("cursor_4c_BuscaFpag")
1497:                 USE IN cursor_4c_BuscaFpag
1498:             ENDIF
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * AbrirLookupFpag - Abre FormBuscaAuxiliar para SigOpFp (Cond. Pagamento)
1504:     * Original: GET_FPG.Valid fwBuscaExt SigOpFp / Fpags / Descrs
1505:     *==========================================================================
1506:     PROCEDURE AbrirLookupFpag()
1507:         LOCAL loc_oPg2, loc_cFpag, loc_oBusca
1508:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1509:         loc_cFpag = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)
1510: 
1511:         IF USED("cursor_4c_BuscaFpag")
1512:             USE IN cursor_4c_BuscaFpag
1513:         ENDIF
1514: 
1515:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1516:             "SigOpFp", "cursor_4c_BuscaFpag", "Fpags", loc_cFpag, ;
1517:             "Condi" + CHR(231) + CHR(245) + "es de Pagamento")
1518: 
1519:         IF VARTYPE(loc_oBusca) = "O"
1520:             IF !loc_oBusca.this_lAchouRegistro
1521:                 loc_oBusca.mAddColuna("Fpags", "", "C" + CHR(243) + "digo")
1522:                 loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1523:                 loc_oBusca.Show()
1524:             ENDIF
1525: 
1526:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaFpag")
1527:                 loc_oPg2.txt_4c_FPG.Value = ALLTRIM(cursor_4c_BuscaFpag.Fpags)
1528:             ELSE
1529:                 IF !loc_oBusca.this_lAchouRegistro
1530:                     loc_oPg2.txt_4c_FPG.Value = ""
1531:                 ENDIF
1532:             ENDIF
1533: 
1534:             loc_oBusca.Release()
1535:         ENDIF
1536: 
1537:         IF USED("cursor_4c_BuscaFpag")
1538:             USE IN cursor_4c_BuscaFpag
1539:         ENDIF
1540:     ENDPROC
1541: 
1542:     *==========================================================================
1543:     * ValidarValAdics - LostFocus de txt_4c_ValAdics: valor deve ser >= 0
1544:     * Original: GetValAdics.Valid: If This.Value < 0 -> MessageBox + Return 0
1545:     *==========================================================================
1546:     PROCEDURE ValidarValAdics(par_nKeyCode, par_nShiftAltCtrl)
1547:         LOCAL loc_oPg2
1548:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1549: 
1550:         IF loc_oPg2.txt_4c_ValAdics.Value < 0
1551:             MsgAviso("Valor Inv" + CHR(225) + "lido !!!", "Aten" + CHR(231) + CHR(227) + "o")
1552:             loc_oPg2.txt_4c_ValAdics.Value = 0
1553:             loc_oPg2.txt_4c_ValAdics.SetFocus
1554:         ENDIF
1555:     ENDPROC
1556: 
1557:     *==========================================================================
1558:     * FormParaBO - Transfere valores do Form para o BO antes de Salvar
1559:     * Todos os campos: Moeda, Descricao, Cotacao, FMult, Nordrels, MoeEq, Qtde,
1560:     *   Tabref, FPG, Toleras, OptTipo(Consultas), DisfPres, ValAdics, Grupo, Subg
1561:     *==========================================================================
1562:     PROTECTED PROCEDURE FormParaBO()
1563:         LOCAL loc_oPg2, loc_cDisfpres
1564:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1565: 
1566:         WITH THIS.this_oBusinessObject
1567:             .this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Moeda.Value)
1568:             .this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1569:             .this_lCotas     = (loc_oPg2.chk_4c_Cotacao.Value = 1)
1570:             .this_cFmults    = ALLTRIM(loc_oPg2.txt_4c_Fmult.Value)
1571:             .this_nNordrels  = loc_oPg2.obj_4c_SpnNordrels.Value
1572:             .this_cMoeqs     = ALLTRIM(loc_oPg2.txt_4c_MoeEq.Value)
1573:             .this_nQtdeqs    = loc_oPg2.txt_4c_Qtde.Value
1574:             .this_lTabrefs   = (loc_oPg2.chk_4c_Tabref.Value = 1)
1575:             .this_cFpags     = ALLTRIM(loc_oPg2.txt_4c_FPG.Value)
1576:             .this_nToleras   = loc_oPg2.txt_4c_Toleras.Value
1577:             .this_nConsultas = loc_oPg2.obj_4c_OptTipo.Value
1578:             .this_cDisfpres  = ALLTRIM(loc_oPg2.txt_4c_DisfPres.Value)
1579:             .this_nValadics  = loc_oPg2.txt_4c_ValAdics.Value
1580:             .this_cGrumoes   = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
1581:             .this_cSubmoes   = ALLTRIM(loc_oPg2.txt_4c_Subg.Value)
1582:         ENDWITH
1583:     ENDPROC
1584: 
1585:     *==========================================================================
1586:     * BOParaForm - Transfere valores do BO para o Form apos CarregarPorCodigo
1587:     * Todos os campos mapeados ao BO
1588:     *==========================================================================
1589:     PROTECTED PROCEDURE BOParaForm()
1590:         LOCAL loc_oPg2
1591:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1592: 
1593:         WITH THIS.this_oBusinessObject
1594:             loc_oPg2.txt_4c_Moeda.Value          = ALLTRIM(.this_cCodigo)
1595:             loc_oPg2.txt_4c_Descricao.Value       = ALLTRIM(.this_cDescricao)
1596:             loc_oPg2.chk_4c_Cotacao.Value         = .this_lCotas
1597:             loc_oPg2.txt_4c_Fmult.Value           = ALLTRIM(.this_cFmults)
1598:             loc_oPg2.obj_4c_SpnNordrels.Value     = .this_nNordrels
1599:             loc_oPg2.txt_4c_MoeEq.Value           = ALLTRIM(.this_cMoeqs)
1600:             loc_oPg2.txt_4c_Qtde.Value            = .this_nQtdeqs
1601:             loc_oPg2.chk_4c_Tabref.Value          = .this_lTabrefs
1602:             loc_oPg2.txt_4c_FPG.Value             = ALLTRIM(.this_cFpags)
1603:             loc_oPg2.txt_4c_Toleras.Value         = .this_nToleras
1604:             loc_oPg2.obj_4c_OptTipo.Value         = IIF(.this_nConsultas >= 1 AND .this_nConsultas <= 2, .this_nConsultas, 1)
1605:             loc_oPg2.txt_4c_DisfPres.Value        = ALLTRIM(.this_cDisfpres)
1606:             loc_oPg2.txt_4c_ValAdics.Value        = .this_nValadics
1607:             loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrumoes)
1608:             loc_oPg2.txt_4c_Subg.Value            = ALLTRIM(.this_cSubmoes)
1609:         ENDWITH
1610:     ENDPROC
1611: 
1612:     *==========================================================================
1613:     * LimparCampos - Limpa valores de todos os campos do form (todos mapeados)
1614:     *==========================================================================
1615:     PROTECTED PROCEDURE LimparCampos()
1616:         LOCAL loc_oPg2
1617:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1618: 
1619:         loc_oPg2.txt_4c_Moeda.Value          = ""
1620:         loc_oPg2.txt_4c_Descricao.Value       = ""
1621:         loc_oPg2.chk_4c_Cotacao.Value         = 0
1622:         loc_oPg2.txt_4c_Fmult.Value           = ""
1623:         loc_oPg2.obj_4c_SpnNordrels.Value     = 0
1624:         loc_oPg2.txt_4c_MoeEq.Value           = ""
1625:         loc_oPg2.txt_4c_Qtde.Value            = 0
1626:         loc_oPg2.chk_4c_Tabref.Value          = 0
1627:         loc_oPg2.txt_4c_FPG.Value             = ""
1628:         loc_oPg2.txt_4c_Toleras.Value         = 0
1629:         loc_oPg2.obj_4c_OptTipo.Value         = 1
1630:         loc_oPg2.txt_4c_DisfPres.Value        = ""
1631:         loc_oPg2.txt_4c_ValAdics.Value        = 0
1632:         loc_oPg2.txt_4c_Grupo.Value           = ""
1633:         loc_oPg2.txt_4c_Subg.Value            = ""
1634:     ENDPROC
1635: 
1636:     *==========================================================================
1637:     * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
1638:     * par_lHabilitar: .T. = edicao (INCLUIR/ALTERAR), .F. = leitura (VISUALIZAR)
1639:     * Regra: txt_4c_Moeda (PK) so habilitado no modo INCLUIR
1640:     *==========================================================================
1641:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1642:         LOCAL loc_oPg2, loc_lCodigo
1643:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1644:         loc_lCodigo = (THIS.this_cModoAtual = "INCLUIR")
1645: 
1646:         loc_oPg2.txt_4c_Moeda.Enabled          = loc_lCodigo
1647:         loc_oPg2.txt_4c_Descricao.Enabled       = par_lHabilitar
1648:         loc_oPg2.chk_4c_Cotacao.Enabled         = par_lHabilitar
1649:         loc_oPg2.txt_4c_Fmult.Enabled           = par_lHabilitar
1650:         loc_oPg2.obj_4c_SpnNordrels.Enabled     = par_lHabilitar
1651:         loc_oPg2.txt_4c_MoeEq.Enabled           = par_lHabilitar
1652:         loc_oPg2.txt_4c_Qtde.Enabled            = par_lHabilitar
1653:         loc_oPg2.chk_4c_Tabref.Enabled          = par_lHabilitar
1654:         loc_oPg2.txt_4c_FPG.Enabled             = par_lHabilitar
1655:         loc_oPg2.txt_4c_Toleras.Enabled         = par_lHabilitar
1656:         loc_oPg2.obj_4c_OptTipo.Enabled         = par_lHabilitar
1657:         loc_oPg2.txt_4c_DisfPres.Enabled        = par_lHabilitar
1658:         loc_oPg2.txt_4c_ValAdics.Enabled        = par_lHabilitar
1659:         loc_oPg2.txt_4c_Grupo.Enabled           = par_lHabilitar
1660:         loc_oPg2.txt_4c_Subg.Enabled            = par_lHabilitar
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * AjustarBotoesPorModo - Ajusta estado dos botoes da Page2 pelo modo atual
1665:     * INCLUIR/ALTERAR: Confirmar habilitado, Cancelar habilitado
1666:     * VISUALIZAR: Confirmar desabilitado, Cancelar habilitado (padrao canonico)
1667:     *==========================================================================
1668:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1669:         LOCAL loc_oPg2, loc_lPodeConfirmar
1670:         loc_oPg2           = THIS.pgf_4c_Paginas.Page2
1671:         loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1672: 
1673:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
1674:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1675:     ENDPROC
1676: 
1677: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MoeBO.prg):
*==============================================================================
* MoeBO.prg - Business Object para Cadastro de Moedas
* Tabela: SigCdMoe
* Chave primaria: cmoes char(3)
*==============================================================================

DEFINE CLASS MoeBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo      = ""    && char(3)       cmoes  - Codigo da moeda (PK)

    *-- Dados cadastrais
    this_cDescricao   = ""    && char(15)      dmoes  - Descricao da moeda
    this_lCotas       = .F.   && bit           cotas  - Permite cotacao
    this_dDataTrans   = {}    && datetime NULL  datatrans - Data transacao

    *-- Fator multiplicador / ordem relatorios
    this_cFmults      = ""    && char(1)       fmults     - Fator multiplicador (N=Nao / S=Sim)
    this_nNordrels    = 0     && numeric(1,0)  nordrels   - N da coluna nos relatorios (0-5)

    *-- Codificacao etiqueta produto
    this_cDisfpres    = ""    && char(1)       disfpres   - Codifica na etiqueta (N/S/A/P)
    this_nValadics    = 0     && numeric(3,0)  valadics   - Valor adicional

    *-- Moeda equivalente
    this_cMoeqs       = ""    && char(3)       moeqs      - Codigo da moeda equivalente (FK SigCdMoe.cmoes)
    this_nQtdeqs      = 0     && numeric(12,6) qtdeqs     - Quantidade moeda equivalente
    this_nToleras     = 0     && numeric(4,2)  toleras    - Tolerancia conversao

    *-- Classificacao
    this_cGrumoes     = ""    && char(10)      grumoes    - Grupo
    this_cSubmoes     = ""    && char(10)      submoes    - Sub-grupo

    *-- Configuracao gerencial
    this_lTabrefs     = .F.   && bit           tabrefs    - Imprime tabela referencia
    this_cFpags       = ""    && char(12)      fpags      - Cond. pagamento automatica (FK SigOpFp.fpags)
    this_nConsultas   = 1     && numeric(1,0)  consultas  - Listar na consulta (1=Sim / 2=Nao)
    this_nObgfator    = 0     && numeric(1,0)  obgfator   - Obrigatorio fator

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, nordrels, cotas" + ;
                " FROM SigCdMoe"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cmoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator" + ;
                " FROM SigCdMoe" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCodigo), "N" + CHR(227) + "o Encontrado")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cmoes,    "C")
            THIS.this_cDescricao = TratarNulo(dmoes,    "C")
            IF VARTYPE(cotas) = "L"
                THIS.this_lCotas = cotas
            ELSE
                THIS.this_lCotas = (NVL(cotas, 0) = 1)
            ENDIF
            THIS.this_cFmults    = TratarNulo(fmults,   "C")
            THIS.this_nNordrels  = TratarNulo(nordrels, "N")
            THIS.this_cDisfpres  = TratarNulo(disfpres, "C")
            THIS.this_nValadics  = TratarNulo(valadics, "N")
            THIS.this_cMoeqs     = TratarNulo(moeqs,    "C")
            THIS.this_nQtdeqs    = TratarNulo(qtdeqs,   "N")
            THIS.this_nToleras   = TratarNulo(toleras,  "N")
            THIS.this_cGrumoes   = TratarNulo(grumoes,  "C")
            THIS.this_cSubmoes   = TratarNulo(submoes,  "C")
            IF VARTYPE(tabrefs) = "L"
                THIS.this_lTabrefs = tabrefs
            ELSE
                THIS.this_lTabrefs = (NVL(tabrefs, 0) = 1)
            ENDIF
            THIS.this_cFpags     = TratarNulo(fpags,    "C")
            THIS.this_nConsultas = TratarNulo(consultas,"N")
            THIS.this_nObgfator  = TratarNulo(obgfator, "N")
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDataTrans = {}
            ELSE
                THIS.this_dDataTrans = datatrans
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o pode ser vazio!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da moeda n" + CHR(227) + "o pode ser vazia!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !BETWEEN(THIS.this_nNordrels, 0, 5)
            MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
                "rios inv" + CHR(225) + "lida (0 a 5)!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                IF USED("cursor_4c_ValidaMoe")
                    USE IN cursor_4c_ValidaMoe
                ENDIF
                loc_cSQL = "SELECT cmoes FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMoe")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValidaMoe") > 0
                    MsgAviso("Moeda j" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            ENDTRY
            IF USED("cursor_4c_ValidaMoe")
                USE IN cursor_4c_ValidaMoe
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigCdMoe" + ;
                " (cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                IIF(THIS.this_lCotas, "1", "0") + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(THIS.this_cFmults) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNordrels) + ", " + ;
                EscaparSQL(loc_cDisfpres) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValadics) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdeqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nToleras) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + ", " + ;
                IIF(THIS.this_lTabrefs, "1", "0") + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsultas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObgfator) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdMoe SET" + ;
                " dmoes = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                " cotas = " + IIF(THIS.this_lCotas, "1", "0") + "," + ;
                " datatrans = GETDATE()," + ;
                " fmults = " + EscaparSQL(THIS.this_cFmults) + "," + ;
                " nordrels = " + FormatarNumeroSQL(THIS.this_nNordrels) + "," + ;
                " disfpres = " + EscaparSQL(loc_cDisfpres) + "," + ;
                " valadics = " + FormatarNumeroSQL(THIS.this_nValadics) + "," + ;
                " moeqs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + "," + ;
                " qtdeqs = " + FormatarNumeroSQL(THIS.this_nQtdeqs) + "," + ;
                " toleras = " + FormatarNumeroSQL(THIS.this_nToleras) + "," + ;
                " grumoes = " + EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + "," + ;
                " submoes = " + EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + "," + ;
                " tabrefs = " + IIF(THIS.this_lTabrefs, "1", "0") + "," + ;
                " fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + "," + ;
                " consultas = " + FormatarNumeroSQL(THIS.this_nConsultas) + "," + ;
                " obgfator = " + FormatarNumeroSQL(THIS.this_nObgfator) + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lPodeExcluir
        loc_lSucesso   = .F.
        loc_lPodeExcluir = .F.

        *-- Verificar se há cotações cadastradas
        TRY
            IF USED("cursor_4c_VerifCot")
                USE IN cursor_4c_VerifCot
            ENDIF
            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifCot")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_VerifCot") > 0
                MsgErro("Imposs" + CHR(237) + "vel excluir moeda com cota" + CHR(231) + ;
                    CHR(227) + "o cadastrada!", "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida")
            ELSE
                loc_lPodeExcluir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar cota" + CHR(231) + CHR(245) + "es: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerifCot")
            USE IN cursor_4c_VerifCot
        ENDIF

        IF loc_lPodeExcluir
            TRY
                loc_cSQL = "DELETE FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

