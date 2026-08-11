# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1948 linhas total):

*-- Linhas 21 a 142:
21:     *--------------------------------------------------------------------------
22:     * Init - Inicializa o formulario
23:     *--------------------------------------------------------------------------
24:     PROCEDURE Init()
25:         RETURN DODEFAULT()
26:     ENDPROC
27: 
28:     *--------------------------------------------------------------------------
29:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
30:     *--------------------------------------------------------------------------
31:     PROTECTED PROCEDURE InicializarForm()
32:         LOCAL loc_lSucesso, loc_oErro
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.Caption = "Cadastro de Comiss" + CHR(245) + ;
37:                 "es de Vendedores Individuais"
38: 
39:             THIS.this_oBusinessObject = CREATEOBJECT("CVIBO")
40: 
41:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
42:                 MostrarErro("Erro ao criar CVIBO", "InicializarForm")
43:             ELSE
44:                 THIS.ConfigurarPageFrame()
45:                 THIS.ConfigurarPaginaLista()
46:                 THIS.ConfigurarPaginaDados()
47: 
48:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
49:                     THIS.CarregarLista()
50:                 ENDIF
51: 
52:                 THIS.pgf_4c_Paginas.Visible = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55:                 loc_lSucesso = .T.
56:             ENDIF
57:         CATCH TO loc_oErro
58:             MostrarErro("Erro ao inicializar FormCVI:" + CHR(13) + ;
59:                 loc_oErro.Message, "Erro")
60:             loc_lSucesso = .F.
61:         ENDTRY
62: 
63:         RETURN loc_lSucesso
64:     ENDPROC
65: 
66:     *--------------------------------------------------------------------------
67:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
68:     *--------------------------------------------------------------------------
69:     PROTECTED PROCEDURE ConfigurarPageFrame()
70:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
71: 
72:         WITH THIS.pgf_4c_Paginas
73:             .PageCount = 2
74:             .Top       = -29
75:             .Left      = 0
76:             .Width     = THIS.Width
77:             .Height    = THIS.Height + 29
78:             .Tabs      = .F.
79:             .Visible   = .T.
80:         ENDWITH
81: 
82:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(100, 100, 100)
83:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
84:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(100, 100, 100)
85:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarPaginaLista - Configura Page1 (Lista com Grid e botoes CRUD)
90:     *--------------------------------------------------------------------------
91:     PROTECTED PROCEDURE ConfigurarPaginaLista()
92:         LOCAL loc_oPagina
93:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
94: 
95:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
96:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97: 
98:         *-- Container Cabecalho (cntSombra no legado)
99:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
100:         WITH loc_oPagina.cnt_4c_Cabecalho
101:             .Top         = 2 + 29
102:             .Left        = 0
103:             .Width       = THIS.Width
104:             .Height      = 80
105:             .BackColor   = RGB(100, 100, 100)
106:             .BorderWidth = 0
107:             .Visible     = .T.
108:         ENDWITH
109: 
110:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
111:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
112:             .AutoSize  = .F.
113:             .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
114:             .Top       = 15
115:             .Left      = 10
116:             .Width     = THIS.Width - 30
117:             .Height    = 40
118:             .FontName  = "Tahoma"
119:             .FontSize  = 16
120:             .FontBold  = .T.
121:             .ForeColor = RGB(0, 0, 0)
122:             .BackStyle = 0
123:             .Visible   = .T.
124:         ENDWITH
125: 
126:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
127:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
128:             .AutoSize  = .F.
129:             .Caption   = "Cadastro de Comiss" + CHR(245) + "es de Vendedores Individuais"
130:             .Top       = 18
131:             .Left      = 10
132:             .Width     = THIS.Width - 30
133:             .Height    = 46
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(255, 255, 255)
138:             .BackStyle = 0
139:             .Visible   = .T.
140:         ENDWITH
141: 
142:         *-- Container Botoes CRUD (Grupo_op no legado: Left=313, Top=-1)

*-- Linhas 674 a 744:
674:             .Visible            = .T.
675:         ENDWITH
676: 
677:         *-- BINDEVENTs dos botoes CRUD
678:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
679:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,"Click", THIS, "BtnVisualizarClick")
680:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
681:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
682:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
683:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
684:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
685:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk,    "Click", THIS, "BtnCopiaOkClick")
686:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel,"Click", THIS, "BtnCopiaCancelarClick")
687: 
688:         *-- BINDEVENTs dos campos de filtro
689:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess, "KeyPress", THIS, "FiltroLostFocus")
690:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos, "KeyPress", THIS, "FiltroLostFocus")
691: 
692:         *-- BINDEVENT do grid
693:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
694: 
695:         THIS.TornarControlesVisiveis(loc_oPagina)
696: 
697:         *-- Restaurar container de copia como oculto apos TornarControlesVisiveis
698:         loc_oPagina.cnt_4c_Copia.Visible = .F.
699:     ENDPROC
700: 
701:     *--------------------------------------------------------------------------
702:     * ConfigurarPaginaDados - Configura Page2 (Dados)
703:     *--------------------------------------------------------------------------
704:     PROTECTED PROCEDURE ConfigurarPaginaDados()
705:         LOCAL loc_oPagina
706:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
707: 
708:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
709:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
710: 
711:         *-- Container Botoes Acao (Grupo_Salva no legado)
712:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
713:         WITH loc_oPagina.cnt_4c_BotoesAcao
714:             .Top         = 4 + 29
715:             .Left        = 842
716:             .Width       = 160
717:             .Height      = 85
718:             .BackStyle   = 0
719:             .BorderWidth = 0
720:             .Visible     = .T.
721:         ENDWITH
722: 
723:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
724:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
725:             .Caption         = "Confirmar"
726:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
727:             .PicturePosition = 13
728:             .Top             = 5
729:             .Left            = 5
730:             .Width           = 75
731:             .Height          = 75
732:             .BackColor       = RGB(255, 255, 255)
733:             .ForeColor       = RGB(90, 90, 90)
734:             .FontName        = "Comic Sans MS"
735:             .FontSize        = 8
736:             .FontBold        = .T.
737:             .FontItalic      = .T.
738:             .Themes          = .F.
739:             .SpecialEffect   = 0
740:             .MousePointer    = 15
741:             .WordWrap        = .T.
742:             .AutoSize        = .F.
743:             .Visible         = .T.
744:         ENDWITH

*-- Linhas 766 a 810:
766:             .Visible         = .T.
767:         ENDWITH
768: 
769:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
770:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
771: 
772:         *-- CAMPOS PARTE 1/2 (Fase 5): Usuario, Periodo, Tipo, Setor (labels + textboxes)
773:         *-- Compensacao PageFrame: Top = Top_original + 29
774: 
775:         *-- Label: Usuario (Label1 no legado: Left=197, Top=157, ForeColor=36,84,155, Verdana 8)
776:         loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
777:         WITH loc_oPagina.lbl_4c_Usuars
778:             .AutoSize  = .T.
779:             .Caption   = "Usu" + CHR(225) + "rio :"
780:             .Left      = 197
781:             .Top       = 157 + 29
782:             .Width     = 54
783:             .Height    = 15
784:             .FontName  = "Verdana"
785:             .FontSize  = 8
786:             .ForeColor = RGB(36, 84, 155)
787:             .BackStyle = 0
788:             .Visible   = .T.
789:         ENDWITH
790: 
791:         *-- TextBox: getUsuars (Left=251, Top=154, Width=80; lookup SigCdUsu)
792:         loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
793:         WITH loc_oPagina.txt_4c_Usuars
794:             .Left      = 251
795:             .Top       = 154 + 29
796:             .Width     = 80
797:             .Height    = 21
798:             .MaxLength = 10
799:             .Value     = ""
800:             .FontName  = "Tahoma"
801:             .FontSize  = 8
802:             .Visible   = .T.
803:         ENDWITH
804: 
805:         *-- Label: Periodo (Label9 no legado: Left=197, Top=182, Verdana 8, ForeColor=36,84,155)
806:         loc_oPagina.AddObject("lbl_4c_LblPeriodo", "Label")
807:         WITH loc_oPagina.lbl_4c_LblPeriodo
808:             .AutoSize  = .T.
809:             .Caption   = "Per" + CHR(237) + "odo :"
810:             .Left      = 197

*-- Linhas 1074 a 1131:
1074:             .Visible   = .T.
1075:         ENDWITH
1076: 
1077:         *-- BINDEVENTs dos campos com lookup (F4 e DblClick)
1078:         BINDEVENT(loc_oPagina.txt_4c_Usuars,  "KeyPress", THIS, "UsuarsLookupKeyPress")
1079:         BINDEVENT(loc_oPagina.txt_4c_Usuars,  "DblClick", THIS, "UsuarsLookupDblClick")
1080:         BINDEVENT(loc_oPagina.txt_4c_Setors,  "KeyPress", THIS, "SetorsLookupKeyPress")
1081:         BINDEVENT(loc_oPagina.txt_4c_Setors,  "DblClick", THIS, "SetorsLookupDblClick")
1082:         BINDEVENT(loc_oPagina.txt_4c_Supervs, "KeyPress", THIS, "SupervsLookupKeyPress")
1083:         BINDEVENT(loc_oPagina.txt_4c_Supervs, "DblClick", THIS, "SupervsLookupDblClick")
1084: 
1085:         THIS.TornarControlesVisiveis(loc_oPagina)
1086:     ENDPROC
1087: 
1088:     *--------------------------------------------------------------------------
1089:     * CarregarLista - Carrega dados no Grid da Page1 com filtro de periodo
1090:     *--------------------------------------------------------------------------
1091:     PROCEDURE CarregarLista()
1092:         LOCAL loc_lResultado, loc_oErro, loc_cMess, loc_cAnos
1093:         LOCAL loc_cFiltro, loc_oGrid, loc_oPagina
1094:         loc_lResultado = .F.
1095: 
1096:         TRY
1097:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1098:                 loc_lResultado = .T.
1099:             ELSE
1100:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1101:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
1102: 
1103:                 *-- Ler filtro de periodo do container cnt_4c_Filtro
1104:                 IF VARTYPE(loc_oPagina.cnt_4c_Filtro) = "O"
1105:                     loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
1106:                     loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")
1107:                 ELSE
1108:                     loc_cMess = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 5, 2)), 2, "0")
1109:                     loc_cAnos = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 1, 4)), 4, "0")
1110:                 ENDIF
1111: 
1112:                 *-- Construir filtro WHERE
1113:                 IF loc_cMess = "00" OR EMPTY(loc_cMess)
1114:                     loc_cFiltro = "Anos = '" + loc_cAnos + "'"
1115:                 ELSE
1116:                     IF loc_cAnos = "0000" OR EMPTY(loc_cAnos)
1117:                         loc_cFiltro = "Mess = '" + loc_cMess + "'"
1118:                     ELSE
1119:                         loc_cFiltro = "Mess = '" + loc_cMess + "' AND Anos = '" + loc_cAnos + "'"
1120:                     ENDIF
1121:                 ENDIF
1122: 
1123:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1124:                     *-- Vincular grid ao cursor (RecordSource e ControlSource FORA do WITH)
1125:                     loc_oGrid.RecordSource = "crSigCcCmV"
1126:                     loc_oGrid.ColumnCount  = 8
1127: 
1128:                     loc_oGrid.Column1.ControlSource = "crSigCcCmV.Usuars"
1129:                     loc_oGrid.Column2.ControlSource = "crSigCcCmV.Mess"
1130:                     loc_oGrid.Column3.ControlSource = "crSigCcCmV.Anos"
1131:                     loc_oGrid.Column4.ControlSource = "crSigCcCmV.Indivs"

*-- Linhas 1185 a 1791:
1185:     *--------------------------------------------------------------------------
1186:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1187:     *--------------------------------------------------------------------------
1188:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1189:         LOCAL loc_lResultado
1190:         loc_lResultado = .F.
1191: 
1192:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1193:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1194:             IF par_nPagina = 1
1195:                 THIS.CarregarLista()
1196:             ENDIF
1197:             loc_lResultado = .T.
1198:         ENDIF
1199: 
1200:         RETURN loc_lResultado
1201:     ENDPROC
1202: 
1203:     *--------------------------------------------------------------------------
1204:     * BtnIncluirClick - Incluir novo registro
1205:     *--------------------------------------------------------------------------
1206:     PROCEDURE BtnIncluirClick()
1207:         THIS.this_oBusinessObject.NovoRegistro()
1208:         THIS.LimparCampos()
1209:         THIS.this_cModoAtual = "INCLUIR"
1210:         THIS.HabilitarCampos(.T.)
1211:         THIS.AjustarBotoesPorModo()
1212:         THIS.AlternarPagina(2)
1213:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1214:     ENDPROC
1215: 
1216:     *--------------------------------------------------------------------------
1217:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
1218:     *--------------------------------------------------------------------------
1219:     PROCEDURE BtnVisualizarClick()
1220:         LOCAL loc_cChave
1221:         loc_cChave = ""
1222: 
1223:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1224:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1225:             RETURN
1226:         ENDIF
1227: 
1228:         SELECT crSigCcCmV
1229:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1230: 
1231:         IF EMPTY(loc_cChave)
1232:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1233:             RETURN
1234:         ENDIF
1235: 
1236:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1237:             THIS.this_cModoAtual = "VISUALIZAR"
1238:             THIS.BOParaForm()
1239:             THIS.HabilitarCampos(.F.)
1240:             THIS.AjustarBotoesPorModo()
1241:             THIS.AlternarPagina(2)
1242:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
1243:         ENDIF
1244:     ENDPROC
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * BtnAlterarClick - Alterar registro selecionado
1248:     *--------------------------------------------------------------------------
1249:     PROCEDURE BtnAlterarClick()
1250:         LOCAL loc_cChave
1251:         loc_cChave = ""
1252: 
1253:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1254:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1255:             RETURN
1256:         ENDIF
1257: 
1258:         SELECT crSigCcCmV
1259:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1260: 
1261:         IF EMPTY(loc_cChave)
1262:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1263:             RETURN
1264:         ENDIF
1265: 
1266:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1267:             THIS.this_oBusinessObject.EditarRegistro()
1268:             THIS.this_cModoAtual = "ALTERAR"
1269:             THIS.BOParaForm()
1270:             THIS.HabilitarCampos(.T.)
1271:             THIS.AjustarBotoesPorModo()
1272:             THIS.AlternarPagina(2)
1273:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1274:         ENDIF
1275:     ENDPROC
1276: 
1277:     *--------------------------------------------------------------------------
1278:     * BtnExcluirClick - Excluir registro selecionado
1279:     *--------------------------------------------------------------------------
1280:     PROCEDURE BtnExcluirClick()
1281:         LOCAL loc_cChave, loc_lConfirmou
1282:         loc_cChave    = ""
1283:         loc_lConfirmou = .F.
1284: 
1285:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1286:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1287:             RETURN
1288:         ENDIF
1289: 
1290:         SELECT crSigCcCmV
1291:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1292: 
1293:         IF EMPTY(loc_cChave)
1294:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1295:             RETURN
1296:         ENDIF
1297: 
1298:         loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1299:         IF !loc_lConfirmou
1300:             RETURN
1301:         ENDIF
1302: 
1303:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1304:             IF THIS.this_oBusinessObject.Excluir()
1305:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1306:                 THIS.CarregarLista()
1307:             ENDIF
1308:         ENDIF
1309:     ENDPROC
1310: 
1311:     *--------------------------------------------------------------------------
1312:     * BtnBuscarClick - Recarregar lista com filtro atual
1313:     *--------------------------------------------------------------------------
1314:     PROCEDURE BtnBuscarClick()
1315:         THIS.FiltroLostFocus()
1316:     ENDPROC
1317: 
1318:     *--------------------------------------------------------------------------
1319:     * BtnEncerrarClick - Fecha o formulario
1320:     *--------------------------------------------------------------------------
1321:     PROCEDURE BtnEncerrarClick()
1322:         THIS.Release()
1323:     ENDPROC
1324: 
1325:     *--------------------------------------------------------------------------
1326:     * BtnSalvarClick - Salva o registro atual
1327:     *--------------------------------------------------------------------------
1328:     PROCEDURE BtnSalvarClick()
1329:         LOCAL loc_lResultado, loc_oErro
1330:         loc_lResultado = .F.
1331: 
1332:         IF THIS.this_cModoAtual = "VISUALIZAR"
1333:             THIS.BtnCancelarClick()
1334:             RETURN
1335:         ENDIF
1336: 
1337:         IF !THIS.this_oBusinessObject.ValidarDados()
1338:             RETURN
1339:         ENDIF
1340: 
1341:         TRY
1342:             IF THIS.FormParaBO()
1343:                 IF THIS.this_oBusinessObject.Salvar()
1344:                     MsgInfo("Registro salvo com sucesso!")
1345:                     THIS.this_cModoAtual = "LISTA"
1346:                     THIS.AlternarPagina(1)
1347:                     loc_lResultado = .T.
1348:                 ENDIF
1349:             ENDIF
1350:         CATCH TO loc_oErro
1351:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1352:             loc_lResultado = .F.
1353:         ENDTRY
1354: 
1355:         RETURN loc_lResultado
1356:     ENDPROC
1357: 
1358:     *--------------------------------------------------------------------------
1359:     * BtnCancelarClick - Cancela e volta para a lista
1360:     *--------------------------------------------------------------------------
1361:     PROCEDURE BtnCancelarClick()
1362:         THIS.this_cModoAtual = "LISTA"
1363:         THIS.AlternarPagina(1)
1364:         THIS.CarregarLista()
1365:     ENDPROC
1366: 
1367:     *--------------------------------------------------------------------------
1368:     * BtnCopiaClick - Mostra/oculta painel de copia de periodo
1369:     *--------------------------------------------------------------------------
1370:     PROCEDURE BtnCopiaClick()
1371:         LOCAL loc_oPagina, loc_oCopia
1372:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1373:         loc_oCopia  = loc_oPagina.cnt_4c_Copia
1374: 
1375:         *-- Desabilitar controles da lista ao abrir painel de copia
1376:         loc_oPagina.grd_4c_Lista.Enabled         = .F.
1377:         loc_oPagina.cnt_4c_Saida.Enabled         = .F.
1378:         loc_oPagina.cnt_4c_Botoes.Enabled        = .F.
1379:         loc_oPagina.cmd_4c_Copia.Enabled         = .F.
1380:         THIS.pgf_4c_Paginas.Page2.Enabled        = .F.
1381: 
1382:         *-- Prefill com o periodo do filtro atual
1383:         WITH loc_oCopia
1384:             .txt_4c_OMess.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value
1385:             .txt_4c_OAnos.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value
1386:             .txt_4c_DMess.Value = ""
1387:             .txt_4c_DAnos.Value = ""
1388:             .Visible = .T.
1389:         ENDWITH
1390: 
1391:         loc_oCopia.txt_4c_OMess.SetFocus
1392:     ENDPROC
1393: 
1394:     *--------------------------------------------------------------------------
1395:     * BtnCopiaCancelarClick - Cancela copia de periodo e restaura controles
1396:     *--------------------------------------------------------------------------
1397:     PROCEDURE BtnCopiaCancelarClick()
1398:         LOCAL loc_oPagina
1399:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1400: 
1401:         loc_oPagina.cnt_4c_Copia.Visible         = .F.
1402:         loc_oPagina.grd_4c_Lista.Enabled         = .T.
1403:         loc_oPagina.cnt_4c_Saida.Enabled         = .T.
1404:         loc_oPagina.cnt_4c_Botoes.Enabled        = .T.
1405:         loc_oPagina.cmd_4c_Copia.Enabled         = .T.
1406:         THIS.pgf_4c_Paginas.Page2.Enabled        = .T.
1407: 
1408:         THIS.Refresh()
1409:         loc_oPagina.grd_4c_Lista.SetFocus
1410:     ENDPROC
1411: 
1412:     *--------------------------------------------------------------------------
1413:     * BtnCopiaOkClick - Executa copia de periodo via BO.CopiarPeriodo()
1414:     *--------------------------------------------------------------------------
1415:     PROCEDURE BtnCopiaOkClick()
1416:         LOCAL loc_oPagina, loc_oCopia
1417:         LOCAL loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos
1418:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1419:         loc_oCopia  = loc_oPagina.cnt_4c_Copia
1420: 
1421:         loc_cOMess = PADL(ALLTRIM(loc_oCopia.txt_4c_OMess.Value), 2, "0")
1422:         loc_cOAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_OAnos.Value), 4, "0")
1423:         loc_cDMess = PADL(ALLTRIM(loc_oCopia.txt_4c_DMess.Value), 2, "0")
1424:         loc_cDAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_DAnos.Value), 4, "0")
1425: 
1426:         IF EMPTY(loc_cOMess) OR loc_cOMess = "00"
1427:             MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1428:                 "s de Refer" + CHR(234) + "ncia da Origem!", "C" + CHR(243) + "pia")
1429:             loc_oCopia.txt_4c_OMess.SetFocus
1430:             RETURN
1431:         ENDIF
1432: 
1433:         IF !BETWEEN(VAL(loc_cOMess), 1, 12)
1434:             MsgAviso("M" + CHR(234) + "s de Origem inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
1435:             loc_oCopia.txt_4c_OMess.SetFocus
1436:             RETURN
1437:         ENDIF
1438: 
1439:         IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000"
1440:             MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1441:                 "ncia da Origem!", "C" + CHR(243) + "pia")
1442:             loc_oCopia.txt_4c_OAnos.SetFocus
1443:             RETURN
1444:         ENDIF
1445: 
1446:         IF EMPTY(loc_cDMess) OR loc_cDMess = "00"
1447:             MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1448:                 "s de Refer" + CHR(234) + "ncia do Destino!", "C" + CHR(243) + "pia")
1449:             loc_oCopia.txt_4c_DMess.SetFocus
1450:             RETURN
1451:         ENDIF
1452: 
1453:         IF !BETWEEN(VAL(loc_cDMess), 1, 12)
1454:             MsgAviso("M" + CHR(234) + "s de Destino inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
1455:             loc_oCopia.txt_4c_DMess.SetFocus
1456:             RETURN
1457:         ENDIF
1458: 
1459:         IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000"
1460:             MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1461:                 "ncia do Destino!", "C" + CHR(243) + "pia")
1462:             loc_oCopia.txt_4c_DAnos.SetFocus
1463:             RETURN
1464:         ENDIF
1465: 
1466:         IF loc_cOMess = loc_cDMess AND loc_cOAnos = loc_cDAnos
1467:             MsgAviso("Per" + CHR(237) + "odo de origem e destino s" + CHR(227) + "o iguais.", "C" + CHR(243) + "pia")
1468:             RETURN
1469:         ENDIF
1470: 
1471:         IF !MsgConfirma("Confirma a c" + CHR(243) + "pia do per" + CHR(237) + "odo " + ;
1472:                 loc_cOMess + "/" + loc_cOAnos + " para " + loc_cDMess + "/" + loc_cDAnos + "?", ;
1473:                 "C" + CHR(243) + "pia de Per" + CHR(237) + "odo")
1474:             RETURN
1475:         ENDIF
1476: 
1477:         IF THIS.this_oBusinessObject.CopiarPeriodo(loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos)
1478:             MsgInfo("C" + CHR(243) + "pia realizada com sucesso!")
1479:             THIS.BtnCopiaCancelarClick()
1480:             THIS.CarregarLista()
1481:         ENDIF
1482:     ENDPROC
1483: 
1484:     *--------------------------------------------------------------------------
1485:     * FiltroLostFocus - Chamado quando campo de filtro perde foco; recarrega lista
1486:     *--------------------------------------------------------------------------
1487:     PROCEDURE FiltroLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1488:         LOCAL loc_oPagina, loc_cMess, loc_cAnos
1489:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1490: 
1491:         *-- Padl nos campos de filtro
1492:         loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
1493:         loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")
1494: 
1495:         loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value = loc_cMess
1496:         loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value = loc_cAnos
1497: 
1498:         THIS.CarregarLista()
1499:     ENDPROC
1500: 
1501:     *--------------------------------------------------------------------------
1502:     * GradeAfterRowColChange - Handler do grid apos mudanca de linha/coluna
1503:     *--------------------------------------------------------------------------
1504:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1505:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1506:             RETURN
1507:         ENDIF
1508:     ENDPROC
1509: 
1510:     *--------------------------------------------------------------------------
1511:     * FormParaBO - Transfere dados do Form para o BO
1512:     *--------------------------------------------------------------------------
1513:     PROTECTED PROCEDURE FormParaBO()
1514:         LOCAL loc_lResultado, loc_oErro, loc_oPg2
1515:         loc_lResultado = .F.
1516: 
1517:         TRY
1518:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1519: 
1520:             THIS.this_oBusinessObject.this_cUsuars  = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
1521:             THIS.this_oBusinessObject.this_cMess    = PADL(ALLTRIM(loc_oPg2.txt_4c_Mess.Value), 2, "0")
1522:             THIS.this_oBusinessObject.this_cAnos    = PADL(ALLTRIM(loc_oPg2.txt_4c_Anos.Value), 4, "0")
1523:             THIS.this_oBusinessObject.this_cIndivs  = UPPER(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))
1524:             THIS.this_oBusinessObject.this_cSetors  = ALLTRIM(loc_oPg2.txt_4c_Setors.Value)
1525:             THIS.this_oBusinessObject.this_cSupervs = ALLTRIM(loc_oPg2.txt_4c_Supervs.Value)
1526:             THIS.this_oBusinessObject.this_nAdics   = loc_oPg2.txt_4c_Adics.Value
1527:             THIS.this_oBusinessObject.this_nMinimos = loc_oPg2.txt_4c_Minimos.Value
1528:             THIS.this_oBusinessObject.this_nMinExps = loc_oPg2.txt_4c_MinExps.Value
1529: 
1530:             loc_lResultado = .T.
1531:         CATCH TO loc_oErro
1532:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1533:             loc_lResultado = .F.
1534:         ENDTRY
1535: 
1536:         RETURN loc_lResultado
1537:     ENDPROC
1538: 
1539:     *--------------------------------------------------------------------------
1540:     * BOParaForm - Transfere dados do BO para o Form
1541:     *--------------------------------------------------------------------------
1542:     PROTECTED PROCEDURE BOParaForm()
1543:         LOCAL loc_lResultado, loc_oErro, loc_oPg2
1544:         loc_lResultado = .F.
1545: 
1546:         TRY
1547:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1548: 
1549:             loc_oPg2.txt_4c_Usuars.Value  = THIS.this_oBusinessObject.this_cUsuars
1550:             loc_oPg2.txt_4c_Mess.Value    = THIS.this_oBusinessObject.this_cMess
1551:             loc_oPg2.txt_4c_Anos.Value    = THIS.this_oBusinessObject.this_cAnos
1552:             loc_oPg2.txt_4c_Indivs.Value  = THIS.this_oBusinessObject.this_cIndivs
1553:             loc_oPg2.txt_4c_Setors.Value  = THIS.this_oBusinessObject.this_cSetors
1554:             loc_oPg2.txt_4c_Supervs.Value = THIS.this_oBusinessObject.this_cSupervs
1555:             loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nAdics)
1556:             loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinimos)
1557:             loc_oPg2.txt_4c_MinExps.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinExps)
1558: 
1559:             loc_lResultado = .T.
1560:         CATCH TO loc_oErro
1561:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
1562:             loc_lResultado = .F.
1563:         ENDTRY
1564: 
1565:         RETURN loc_lResultado
1566:     ENDPROC
1567: 
1568:     *--------------------------------------------------------------------------
1569:     * LimparCampos - Limpa valores dos campos da Page2
1570:     *--------------------------------------------------------------------------
1571:     PROTECTED PROCEDURE LimparCampos()
1572:         LOCAL loc_oErro, loc_oPg2
1573:         TRY
1574:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1575:             loc_oPg2.txt_4c_Usuars.Value  = ""
1576:             loc_oPg2.txt_4c_Mess.Value    = ""
1577:             loc_oPg2.txt_4c_Anos.Value    = ""
1578:             loc_oPg2.txt_4c_Indivs.Value  = ""
1579:             loc_oPg2.txt_4c_Setors.Value  = ""
1580:             loc_oPg2.txt_4c_Supervs.Value = ""
1581:             loc_oPg2.txt_4c_Adics.Value   = ""
1582:             loc_oPg2.txt_4c_Minimos.Value = ""
1583:             loc_oPg2.txt_4c_MinExps.Value = ""
1584:         CATCH TO loc_oErro
1585:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1586:         ENDTRY
1587:     ENDPROC
1588: 
1589:     *--------------------------------------------------------------------------
1590:     * HabilitarCampos - Habilita/desabilita campos da Page2
1591:     *--------------------------------------------------------------------------
1592:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1593:         LOCAL loc_oErro, loc_oPg2, loc_lHab
1594:         loc_lHab = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1595:         TRY
1596:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1597:             loc_oPg2.txt_4c_Usuars.ReadOnly  = !loc_lHab
1598:             loc_oPg2.txt_4c_Mess.ReadOnly    = !loc_lHab
1599:             loc_oPg2.txt_4c_Anos.ReadOnly    = !loc_lHab
1600:             loc_oPg2.txt_4c_Indivs.ReadOnly  = !loc_lHab
1601:             loc_oPg2.txt_4c_Setors.ReadOnly  = !loc_lHab
1602:             loc_oPg2.txt_4c_Supervs.ReadOnly = !loc_lHab
1603:             loc_oPg2.txt_4c_Adics.ReadOnly   = !loc_lHab
1604:             loc_oPg2.txt_4c_Minimos.ReadOnly = !loc_lHab
1605:             loc_oPg2.txt_4c_MinExps.ReadOnly = !loc_lHab
1606: 
1607:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1608:         CATCH TO loc_oErro
1609:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1610:         ENDTRY
1611:     ENDPROC
1612: 
1613:     *--------------------------------------------------------------------------
1614:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1615:     *--------------------------------------------------------------------------
1616:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1617:         LOCAL loc_oErro, loc_oPg1, loc_oPg2, loc_lEditando
1618:         TRY
1619:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1620:             loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1621:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1622: 
1623:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1624:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1625:         CATCH TO loc_oErro
1626:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1627:         ENDTRY
1628:     ENDPROC
1629: 
1630:     *--------------------------------------------------------------------------
1631:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1632:     *--------------------------------------------------------------------------
1633:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1634:         LOCAL loc_nI, loc_oObjeto, loc_nP
1635: 
1636:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1637:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1638: 
1639:             IF VARTYPE(loc_oObjeto) = "O"
1640:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1641:                     loc_oObjeto.Visible = .T.
1642:                 ENDIF
1643: 
1644:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1645:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1646:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1647:                     ENDFOR
1648:                 ENDIF
1649: 
1650:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1651:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1652:                 ENDIF
1653:             ENDIF
1654:         ENDFOR
1655:     ENDPROC
1656: 
1657:     *--------------------------------------------------------------------------
1658:     * FormatarGridLista - Formata visual do grid da lista
1659:     *--------------------------------------------------------------------------
1660:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1661:         WITH par_oGrid
1662:             .FontName = "Tahoma"
1663:             .FontSize = 8
1664:         ENDWITH
1665:     ENDPROC
1666: 
1667:     *--------------------------------------------------------------------------
1668:     * Destroy - Libera recursos
1669:     *--------------------------------------------------------------------------
1670:     PROCEDURE Destroy()
1671:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1672:             THIS.this_oBusinessObject = .NULL.
1673:         ENDIF
1674:         IF USED("crSigCcCmV")
1675:             USE IN crSigCcCmV
1676:         ENDIF
1677:         IF USED("cursor_4c_BuscaSup")
1678:             USE IN cursor_4c_BuscaSup
1679:         ENDIF
1680:         DODEFAULT()
1681:     ENDPROC
1682: 
1683:     *--------------------------------------------------------------------------
1684:     * UsuarsLookupKeyPress - Handler KeyPress para txt_4c_Usuars (F4 = abre lookup)
1685:     *--------------------------------------------------------------------------
1686:     PROCEDURE UsuarsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1687:         IF par_nKeyCode = 28  && F4 no VFP9
1688:             THIS.AbrirLookupUsuars()
1689:         ENDIF
1690:     ENDPROC
1691: 
1692:     *--------------------------------------------------------------------------
1693:     * UsuarsLookupDblClick - Handler DblClick para txt_4c_Usuars
1694:     *--------------------------------------------------------------------------
1695:     PROCEDURE UsuarsLookupDblClick()
1696:         THIS.AbrirLookupUsuars()
1697:     ENDPROC
1698: 
1699:     *--------------------------------------------------------------------------
1700:     * AbrirLookupUsuars - Lookup em SigCdUsu (Usuarios / Nome Completo)
1701:     *--------------------------------------------------------------------------
1702:     PROCEDURE AbrirLookupUsuars()
1703:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
1704:         loc_oBusca   = .NULL.
1705:         loc_lReadOnly = .F.
1706: 
1707:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1708:         IF VARTYPE(loc_oPg2.txt_4c_Usuars) = "O"
1709:             loc_lReadOnly = loc_oPg2.txt_4c_Usuars.ReadOnly
1710:         ENDIF
1711:         IF loc_lReadOnly
1712:             RETURN
1713:         ENDIF
1714: 
1715:         TRY
1716:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1717:                 "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", ;
1718:                 loc_oPg2.txt_4c_Usuars.Value, ;
1719:                 "Usu" + CHR(225) + "rios")
1720:             IF VARTYPE(loc_oBusca) = "O"
1721:                 loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
1722:                 loc_oBusca.mAddColuna("NComps",   "X(40)",     "Nome Completo")
1723:                 loc_oBusca.Show()
1724:                 IF loc_oBusca.this_lSelecionou
1725:                     loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1726:                     THIS.PreencherUltimoPeriodoUsuario(ALLTRIM(loc_oBusca.this_cValorSelecionado))
1727:                 ENDIF
1728:                 IF USED("cursor_4c_BuscaUsu")
1729:                     USE IN cursor_4c_BuscaUsu
1730:                 ENDIF
1731:                 loc_oBusca.Release()
1732:                 loc_oBusca = .NULL.
1733:             ENDIF
1734:         CATCH TO loc_oErro
1735:             MsgErro("Erro ao abrir lookup de Usu" + CHR(225) + "rio:" + ;
1736:                 CHR(13) + loc_oErro.Message, "Erro")
1737:             IF USED("cursor_4c_BuscaUsu")
1738:                 USE IN cursor_4c_BuscaUsu
1739:             ENDIF
1740:             IF VARTYPE(loc_oBusca) = "O"
1741:                 loc_oBusca.Release()
1742:                 loc_oBusca = .NULL.
1743:             ENDIF
1744:         ENDTRY
1745:     ENDPROC
1746: 
1747:     *--------------------------------------------------------------------------
1748:     * PreencherUltimoPeriodoUsuario - Preenche campos com ultimo periodo do usuario
1749:     * Chamado apos selecao no lookup de usuario, quando outros campos estao vazios
1750:     *--------------------------------------------------------------------------
1751:     PROTECTED PROCEDURE PreencherUltimoPeriodoUsuario(par_cUsuario)
1752:         LOCAL loc_lProceder, loc_oErro, loc_oPg2
1753:         LOCAL loc_cSQL, loc_nRet, loc_dBase, loc_dProx
1754:         LOCAL loc_cMess, loc_cAnos
1755: 
1756:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1757: 
1758:         *-- So preenche se os demais campos estiverem vazios
1759:         loc_lProceder = EMPTY(ALLTRIM(loc_oPg2.txt_4c_Mess.Value)) AND ;
1760:                         EMPTY(ALLTRIM(loc_oPg2.txt_4c_Anos.Value)) AND ;
1761:                         EMPTY(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))
1762: 
1763:         IF !loc_lProceder
1764:             RETURN
1765:         ENDIF
1766: 
1767:         TRY
1768:             loc_cSQL = "SELECT TOP 1 Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos " + ;
1769:                        "FROM SigCcCmV " + ;
1770:                        "WHERE Usuars = " + EscaparSQL(par_cUsuario) + " " + ;
1771:                        "ORDER BY Anos DESC, Mess DESC"
1772: 
1773:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
1774: 
1775:             IF loc_nRet > 0 AND USED("cursor_4c_UltPer") AND !EOF("cursor_4c_UltPer")
1776:                 *-- Calcular proximo periodo via GOMONTH
1777:                 loc_cMess = PADL(ALLTRIM(cursor_4c_UltPer.Mess), 2, "0")
1778:                 loc_cAnos = PADL(ALLTRIM(cursor_4c_UltPer.Anos), 4, "0")
1779:                 loc_dBase = DATE(VAL(loc_cAnos), VAL(loc_cMess), 1)
1780:                 loc_dProx = GOMONTH(loc_dBase, 1)
1781: 
1782:                 loc_oPg2.txt_4c_Mess.Value    = PADL(LTRIM(STR(MONTH(loc_dProx))), 2, "0")
1783:                 loc_oPg2.txt_4c_Anos.Value    = LTRIM(STR(YEAR(loc_dProx)))
1784:                 loc_oPg2.txt_4c_Indivs.Value  = ALLTRIM(cursor_4c_UltPer.Indivs)
1785:                 loc_oPg2.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.Setors)
1786:                 loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(cursor_4c_UltPer.Supervs)
1787:                 loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(cursor_4c_UltPer.Adics)
1788:                 loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(cursor_4c_UltPer.Minimos)
1789: 
1790:                 IF USED("cursor_4c_UltPer")
1791:                     USE IN cursor_4c_UltPer

*-- Linhas 1803 a 1948:
1803:     *--------------------------------------------------------------------------
1804:     * SetorsLookupKeyPress - Handler KeyPress para txt_4c_Setors (F4 = abre lookup)
1805:     *--------------------------------------------------------------------------
1806:     PROCEDURE SetorsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1807:         IF par_nKeyCode = 28  && F4 no VFP9
1808:             THIS.AbrirLookupSetors()
1809:         ENDIF
1810:     ENDPROC
1811: 
1812:     *--------------------------------------------------------------------------
1813:     * SetorsLookupDblClick - Handler DblClick para txt_4c_Setors
1814:     *--------------------------------------------------------------------------
1815:     PROCEDURE SetorsLookupDblClick()
1816:         THIS.AbrirLookupSetors()
1817:     ENDPROC
1818: 
1819:     *--------------------------------------------------------------------------
1820:     * AbrirLookupSetors - Lookup em SigCdSet (Setores / Descricao)
1821:     *--------------------------------------------------------------------------
1822:     PROCEDURE AbrirLookupSetors()
1823:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
1824:         loc_oBusca   = .NULL.
1825:         loc_lReadOnly = .F.
1826: 
1827:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1828:         IF VARTYPE(loc_oPg2.txt_4c_Setors) = "O"
1829:             loc_lReadOnly = loc_oPg2.txt_4c_Setors.ReadOnly
1830:         ENDIF
1831:         IF loc_lReadOnly
1832:             RETURN
1833:         ENDIF
1834: 
1835:         TRY
1836:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1837:                 "SigCdSet", "cursor_4c_BuscaSet", "Setores", ;
1838:                 loc_oPg2.txt_4c_Setors.Value, ;
1839:                 "Setores")
1840:             IF VARTYPE(loc_oBusca) = "O"
1841:                 loc_oBusca.mAddColuna("Setores", "XXXXXXXXXX", "Setor")
1842:                 loc_oBusca.mAddColuna("Descrs",  "X(40)",     "Descri" + CHR(231) + CHR(227) + "o")
1843:                 loc_oBusca.Show()
1844:                 IF loc_oBusca.this_lSelecionou
1845:                     loc_oPg2.txt_4c_Setors.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1846:                 ENDIF
1847:                 IF USED("cursor_4c_BuscaSet")
1848:                     USE IN cursor_4c_BuscaSet
1849:                 ENDIF
1850:                 loc_oBusca.Release()
1851:                 loc_oBusca = .NULL.
1852:             ENDIF
1853:         CATCH TO loc_oErro
1854:             MsgErro("Erro ao abrir lookup de Setor:" + CHR(13) + loc_oErro.Message, "Erro")
1855:             IF USED("cursor_4c_BuscaSet")
1856:                 USE IN cursor_4c_BuscaSet
1857:             ENDIF
1858:             IF VARTYPE(loc_oBusca) = "O"
1859:                 loc_oBusca.Release()
1860:                 loc_oBusca = .NULL.
1861:             ENDIF
1862:         ENDTRY
1863:     ENDPROC
1864: 
1865:     *--------------------------------------------------------------------------
1866:     * SupervsLookupKeyPress - Handler KeyPress para txt_4c_Supervs (F4 = abre lookup)
1867:     *--------------------------------------------------------------------------
1868:     PROCEDURE SupervsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1869:         IF par_nKeyCode = 28  && F4 no VFP9
1870:             THIS.AbrirLookupSupervs()
1871:         ENDIF
1872:     ENDPROC
1873: 
1874:     *--------------------------------------------------------------------------
1875:     * SupervsLookupDblClick - Handler DblClick para txt_4c_Supervs
1876:     *--------------------------------------------------------------------------
1877:     PROCEDURE SupervsLookupDblClick()
1878:         THIS.AbrirLookupSupervs()
1879:     ENDPROC
1880: 
1881:     *--------------------------------------------------------------------------
1882:     * AbrirLookupSupervs - Lookup dinamico de responsaveis em SigCcCmV/SigCdUsu
1883:     * Busca DISTINCT usuarios com Indivs='R' e Supervs/Setors em branco
1884:     *--------------------------------------------------------------------------
1885:     PROCEDURE AbrirLookupSupervs()
1886:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro, loc_nRet, loc_cSQL
1887:         loc_oBusca   = .NULL.
1888:         loc_lReadOnly = .F.
1889: 
1890:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1891:         IF VARTYPE(loc_oPg2.txt_4c_Supervs) = "O"
1892:             loc_lReadOnly = loc_oPg2.txt_4c_Supervs.ReadOnly
1893:         ENDIF
1894:         IF loc_lReadOnly
1895:             RETURN
1896:         ENDIF
1897: 
1898:         TRY
1899:             *-- Montar cursor dinamico de responsaveis (Indivs='R', sem Supervs/Setors proprios)
1900:             loc_cSQL = "SELECT DISTINCT a.Usuars, b.NComps " + ;
1901:                        "FROM SigCcCmV a " + ;
1902:                        "INNER JOIN SigCdUsu b ON a.Usuars = b.Usuarios " + ;
1903:                        "WHERE a.Indivs = 'R' " + ;
1904:                        "AND RTRIM(a.Supervs) = '' " + ;
1905:                        "AND RTRIM(a.Setors) = '' " + ;
1906:                        "ORDER BY a.Usuars"
1907: 
1908:             IF USED("cursor_4c_BuscaSup")
1909:                 USE IN cursor_4c_BuscaSup
1910:             ENDIF
1911: 
1912:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSup")
1913: 
1914:             IF loc_nRet <= 0 OR !USED("cursor_4c_BuscaSup")
1915:                 MsgAviso("Nenhum respons" + CHR(225) + "vel encontrado.", "Respons" + CHR(225) + "vel")
1916:                 RETURN
1917:             ENDIF
1918: 
1919:             *-- FormBuscaAuxiliar MODO 2: sem params Init, cursor pre-existente
1920:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1921:             IF VARTYPE(loc_oBusca) = "O"
1922:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSup"
1923:                 loc_oBusca.mAddColuna("Usuars", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
1924:                 loc_oBusca.mAddColuna("NComps", "X(40)",     "Nome Completo")
1925:                 loc_oBusca.Show()
1926:                 IF loc_oBusca.this_lSelecionou
1927:                     loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1928:                 ENDIF
1929:                 IF USED("cursor_4c_BuscaSup")
1930:                     USE IN cursor_4c_BuscaSup
1931:                 ENDIF
1932:                 loc_oBusca.Release()
1933:                 loc_oBusca = .NULL.
1934:             ENDIF
1935:         CATCH TO loc_oErro
1936:             MsgErro("Erro ao abrir lookup de Respons" + CHR(225) + "vel:" + ;
1937:                 CHR(13) + loc_oErro.Message, "Erro")
1938:             IF USED("cursor_4c_BuscaSup")
1939:                 USE IN cursor_4c_BuscaSup
1940:             ENDIF
1941:             IF VARTYPE(loc_oBusca) = "O"
1942:                 loc_oBusca.Release()
1943:                 loc_oBusca = .NULL.
1944:             ENDIF
1945:         ENDTRY
1946:     ENDPROC
1947: 
1948: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CVIBO.prg):
*====================================================================
* CVIBO.prg
*
* Business Object para Comissoes de Vendedores Individuais
* Tabela principal: SigCcCmV (cIdChaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CVIBO AS BusinessBase

	*-- Propriedades da entidade (SigCcCmV)
	this_cCidChaves  = ""    && cIdChaves char(20)    - PK (UUID via fUniqueIds)
	this_cUsuars     = ""    && Usuars char(10)        - usuario (FK SigCdUsu.Usuarios)
	this_cMess       = ""    && Mess char(2)           - mes de referencia (MM)
	this_cAnos       = ""    && Anos char(4)           - ano de referencia (YYYY)
	this_cIndivs     = ""    && Indivs char(1)         - tipo: I=Individual R=Responsavel S=Setor
	this_cSetors     = ""    && Setors char(10)        - setor (FK SigCdSet.Setores)
	this_cSupervs    = ""    && Supervs char(10)       - responsavel (FK SigCcCmV.Usuars onde Indivs=R)
	this_nAdics      = 0     && Adics numeric(5,2)     - percentual adicional
	this_nMinimos    = 0     && Minimos numeric(11,2)  - valor minimo
	this_nMinExps    = 0     && MinExps numeric(11,2)  - experiencia minima

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCcCmV"
		THIS.this_cCampoChave = "cIdChaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna PK para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT com filtro WHERE opcional
	* par_cFiltro: clausula WHERE sem a palavra WHERE (ex: "Mess='01' AND Anos='2026'")
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV"
			IF TYPE("par_cFiltro") = "C" AND !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF
			loc_cSQL = loc_cSQL + " ORDER BY Anos, Mess, Usuars"

			IF USED("crSigCcCmV")
				USE IN crSigCcCmV
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCcCmV")
			IF loc_nResult > 0
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega BO pelo cIdChaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cChave)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "SELECT cIdChaves, Usuars, Mess, Anos, Indivs," + ;
				" Setors, Supervs, Adics, Minimos, MinExps" + ;
				" FROM SigCcCmV WHERE cIdChaves = " + EscaparSQL(par_cChave)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Popula propriedades do BO a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAlias)
		LOCAL loc_lResultado
		loc_lResultado = .F.
		IF USED(par_cAlias)
			SELECT (par_cAlias)
			THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
			THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
			THIS.this_cMess      = TratarNulo(Mess,      "C")
			THIS.this_cAnos      = TratarNulo(Anos,      "C")
			THIS.this_cIndivs    = TratarNulo(Indivs,    "C")
			THIS.this_cSetors    = TratarNulo(Setors,    "C")
			THIS.this_cSupervs   = TratarNulo(Supervs,   "C")
			THIS.this_nAdics     = TratarNulo(Adics,     "N")
			THIS.this_nMinimos   = TratarNulo(Minimos,   "N")
			THIS.this_nMinExps   = TratarNulo(MinExps,   "N")
			loc_lResultado = .T.
		ENDIF
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		LOCAL loc_lValido, loc_cSQLComI, loc_nResComI
		LOCAL loc_cSQLSupv, loc_nResSupv
		loc_lValido = .T.

		IF EMPTY(ALLTRIM(THIS.this_cUsuars))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Usu" + CHR(225) + "rio!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cMess))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o M" + CHR(234) + "s de Refer" + ;
				CHR(234) + "ncia!!!", "Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !(INT(VAL(THIS.this_cMess)) > 0)
			MsgAviso("M" + CHR(234) + "s de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cAnos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Ano de Refer" + CHR(234) + "ncia!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !BETWEEN(INT(VAL(THIS.this_cAnos)), 1, 9999)
			MsgAviso("Ano de Refer" + CHR(234) + "ncia Inv" + CHR(225) + "lido!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIndivs))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Status de Tipo de Vendedor!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND !INLIST(ALLTRIM(THIS.this_cIndivs), "I", "R", "S")
			MsgAviso("Observe a Informa" + CHR(231) + CHR(227) + "o na Tela ao Lado do Tipo de Vendedor!!!" + CHR(13) + ;
				"Voc" + CHR(234) + " Est" + CHR(225) + " Tentando Usar Um Tipo de Vendedor Que N" + CHR(227) + "o Existe!!!", ;
				"Aten" + CHR(231) + CHR(227) + "o!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_nMinimos = 0
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o Valor M" + CHR(237) + "nimo!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "I" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser Individual e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "S" AND THIS.this_nAdics <> 0
			MsgAviso("O Vendedor N" + CHR(227) + "o Pode Ser de Setor e Receber Adicional!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND !EMPTY(ALLTRIM(THIS.this_cSupervs))
			MsgAviso("O Respons" + CHR(225) + "vel N" + CHR(227) + "o Pode Ter Um Respons" + CHR(225) + "vel Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND ALLTRIM(THIS.this_cIndivs) = "R" AND ;
			EMPTY(ALLTRIM(THIS.this_cSetors)) AND THIS.this_nAdics = 0
			MsgAviso("O Vendedor Respons" + CHR(225) + "vel Tem Que Ter Um Adicional Cadastrado!!!", ;
				"Valida" + CHR(231) + CHR(227) + "o")
			loc_lValido = .F.
		ENDIF

		*-- Verificar se usuario ja cadastrado no periodo em SigCcCmI (Vendedor por Cargo)
		IF loc_lValido
			loc_cSQLComI = "SELECT Usuars, Mess, Anos, cIdChaves FROM SigCcCmI" + ;
				" WHERE Usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars))

			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF

			loc_nResComI = SQLEXEC(gnConnHandle, loc_cSQLComI, "cursor_4c_ComI")
			IF loc_nResComI > 0
				SELECT cursor_4c_ComI
				SCAN
					IF ALLTRIM(cursor_4c_ComI.Mess) = ALLTRIM(THIS.this_cMess) AND ;
					   ALLTRIM(cursor_4c_ComI.Anos) = ALLTRIM(THIS.this_cAnos)
						MsgAviso("Usu" + CHR(225) + "rio J" + CHR(225) + " Cadastrado No Per" + ;
							CHR(237) + "odo Como Vendedor Por Cargo!!!", ;
							"Valida" + CHR(231) + CHR(227) + "o")
						loc_lValido = .F.
						EXIT
					ENDIF
				ENDSCAN
			ENDIF
			IF USED("cursor_4c_ComI")
				USE IN cursor_4c_ComI
			ENDIF
		ENDIF

		*-- Verificar se supervisor ja tem vinculo no mesmo periodo (se tem setor definido)
		IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cSetors))
			loc_cSQLSupv = "SELECT Usuars FROM SigCcCmV" + ;
				" WHERE Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ;
				" AND Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + ;
				" AND Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ;
				" AND cIdChaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF

			loc_nResSupv = SQLEXEC(gnConnHandle, loc_cSQLSupv, "cursor_4c_Supv")
			IF loc_nResSupv > 0 AND RECCOUNT("cursor_4c_Supv") > 0
				SELECT cursor_4c_Supv
				GO TOP
				IF !EOF("cursor_4c_Supv")
					MsgAviso("Usu" + CHR(225) + "rio Cadastrado Como Vendedor Respons" + CHR(225) + "vel!!!", ;
						"Valida" + CHR(231) + CHR(227) + "o")
					loc_lValido = .F.
				ENDIF
			ENDIF
			IF USED("cursor_4c_Supv")
				USE IN cursor_4c_Supv
			ENDIF
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
				THIS.this_cCidChaves = fUniqueIds()
			ENDIF

			loc_cSQL = "INSERT INTO SigCcCmV" + ;
				" (cIdChaves, Usuars, Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos, MinExps)" + ;
				" VALUES (" + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cMess)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cAnos)) + ", " + ;
				EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + ", " + ;
				EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + ", " + ;
				FormatarNumeroSQL(THIS.this_nAdics) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinimos) + ", " + ;
				FormatarNumeroSQL(THIS.this_nMinExps) + ")"

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "UPDATE SigCcCmV SET" + ;
				" Usuars = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cUsuars), 10)) + "," + ;
				" Mess = " + EscaparSQL(ALLTRIM(THIS.this_cMess)) + "," + ;
				" Anos = " + EscaparSQL(ALLTRIM(THIS.this_cAnos)) + "," + ;
				" Indivs = " + EscaparSQL(ALLTRIM(THIS.this_cIndivs)) + "," + ;
				" Setors = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSetors), 10)) + "," + ;
				" Supervs = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cSupervs), 10)) + "," + ;
				" Adics = " + FormatarNumeroSQL(THIS.this_nAdics) + "," + ;
				" Minimos = " + FormatarNumeroSQL(THIS.this_nMinimos) + "," + ;
				" MinExps = " + FormatarNumeroSQL(THIS.this_nMinExps) + ;
				" WHERE cIdChaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCcCmV (PROTECTED - chamado pelo BusinessBase)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		loc_lResultado = .F.
		TRY
			loc_cSQL = "DELETE FROM SigCcCmV WHERE cIdChaves = " + ;
				EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResult > 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lResultado = .T.
			ELSE
				MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY
		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* CopiarPeriodo - Copia comissoes de um periodo de origem para destino
	* par_cOMess/par_cOAnos: periodo de origem (MM/YYYY)
	* par_cDMess/par_cDAnos: periodo de destino (MM/YYYY)
	* Retorna .T. se ao menos um registro foi gerado com sucesso
	*====================================================================
	PROCEDURE CopiarPeriodo(par_cOMess, par_cOAnos, par_cDMess, par_cDAnos)
		LOCAL loc_lResultado, loc_cSQL, loc_nResult
		LOCAL loc_llIns, loc_llOks, loc_lcMsg, loc_llPular
		LOCAL loc_nConnFP2, loc_oProg
		LOCAL loc_cSQLFop, loc_nResFop
		LOCAL loc_cSQLBusca, loc_nResBusca
		LOCAL loc_cNovaChave, loc_cSQLIns, loc_nResIns
		LOCAL loc_cUsar, loc_cIndv, loc_cSet, loc_cSup
		LOCAL loc_nAdi, loc_nMin, loc_nMinEx

		loc_lResultado = .F.
		loc_llIns      = .F.
		loc_llOks      = .T.
		loc_lcMsg      = ""
		loc_llPular    = .F.
		loc_nConnFP2   = 0
		loc_oProg      = .NULL.

		TRY
			*-- Buscar todos os registros do periodo de origem
			loc_cSQL = "SELECT * FROM SigCcCmV" + ;
				" WHERE Mess = " + EscaparSQL(par_cOMess) + ;
				" AND Anos = " + EscaparSQL(par_cOAnos) + ;
				" ORDER BY Usuars"

			IF USED("crOrigem")
				USE IN crOrigem
			ENDIF

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crOrigem")
			IF loc_nResult < 1
				MsgErro("Erro ao buscar per" + CHR(237) + "odo de origem:" + CHR(13) + ;
					CapturarErroSQL(), "Erro SQL")
			ELSE
				SELECT crOrigem
				GO TOP
				IF EOF("crOrigem")
					MsgAviso("Nenhum Vendedor Est" + CHR(225) + " Cadastrado no Per" + CHR(237) + ;
						"odo de Origem Informado!!!", "Aten" + CHR(231) + CHR(227) + "o")
				ELSE
					*-- Tentar conexao secundaria para folha de pagamento
					loc_nConnFP2 = SQLCONNECT("SigCcCMV_FOPAGV")

					*-- Criar barra de progresso
					loc_oProg = CREATEOBJECT("fwprogressbar", ;
						"Processando Vendedores...", RECCOUNT("crOrigem") + 1)
					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Show()
					ENDIF

					SELECT crOrigem
					SCAN
						*-- Capturar valores do registro atual antes de mudar area de trabalho
						loc_cUsar  = ALLTRIM(crOrigem.Usuars)
						loc_cIndv  = ALLTRIM(crOrigem.Indivs)
						loc_cSet   = ALLTRIM(crOrigem.Setors)
						loc_cSup   = ALLTRIM(crOrigem.Supervs)
						loc_nAdi   = crOrigem.Adics
						loc_nMin   = crOrigem.Minimos
						loc_nMinEx = crOrigem.MinExps
						loc_llPular = .F.

						IF VARTYPE(loc_oProg) = "O"
							loc_oProg.Update(.T.)
							IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
								loc_oProg.SubTitulo.Caption = "Processando o Vendedor : " + loc_cUsar
							ENDIF
						ENDIF

						*-- Verificar atividade na folha de pagamento (se conexao disponivel)
						IF loc_nConnFP2 > 0
							loc_cSQLFop = "SELECT Funcs, Conds FROM FopCff" + ;
								" WHERE Funcs = " + EscaparSQL(loc_cUsar) + ;
								" ORDER BY Funcs"

							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF

							loc_nResFop = SQLEXEC(loc_nConnFP2, loc_cSQLFop, "crFopCff")
							IF loc_nResFop > 0
								SELECT crFopCff
								GO TOP
								IF EOF("crFopCff") OR INLIST(ALLTRIM(crFopCff.Conds), "D", "Q")
									loc_lcMsg = loc_lcMsg + loc_cUsar + ;
										IIF(!EOF("crFopCff"), "(" + ALLTRIM(crFopCff.Conds) + "); ", "; ")
									loc_llPular = .T.
								ENDIF
							ENDIF
							IF USED("crFopCff")
								USE IN crFopCff
							ENDIF
						ENDIF

						IF !loc_llPular
							*-- Verificar se ja existe no periodo de destino
							loc_cSQLBusca = "SELECT cIdChaves FROM SigCcCmV" + ;
								" WHERE Usuars = " + EscaparSQL(loc_cUsar) + ;
								" AND Indivs = " + EscaparSQL(loc_cIndv) + ;
								" AND Setors = " + EscaparSQL(loc_cSet) + ;
								" AND Mess = " + EscaparSQL(par_cDMess) + ;
								" AND Anos = " + EscaparSQL(par_cDAnos)

							IF USED("crBusca")
								USE IN crBusca
							ENDIF

							loc_nResBusca = SQLEXEC(gnConnHandle, loc_cSQLBusca, "crBusca")
							IF loc_nResBusca > 0
								SELECT crBusca
								GO TOP
								IF EOF("crBusca")
									*-- Inserir novo registro no periodo de destino
									loc_cNovaChave = fUniqueIds()
									loc_cSQLIns = "INSERT INTO SigCcCmV" + ;
										" (cIdChaves, Usuars, Mess, Anos, Indivs," + ;
										" Setors, Supervs, Adics, Minimos, MinExps)" + ;
										" VALUES (" + ;
										EscaparSQL(loc_cNovaChave) + ", " + ;
										EscaparSQL(loc_cUsar) + ", " + ;
										EscaparSQL(par_cDMess) + ", " + ;
										EscaparSQL(par_cDAnos) + ", " + ;
										EscaparSQL(loc_cIndv) + ", " + ;
										EscaparSQL(loc_cSet) + ", " + ;
										EscaparSQL(loc_cSup) + ", " + ;
										FormatarNumeroSQL(loc_nAdi) + ", " + ;
										FormatarNumeroSQL(loc_nMin) + ", " + ;
										FormatarNumeroSQL(loc_nMinEx) + ")"

									loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)
									IF loc_nResIns > 0
										loc_llIns = .T.
									ELSE
										MsgErro("Falha ao inserir vendedor " + loc_cUsar + ":" + ;
											CHR(13) + CapturarErroSQL(), "Erro SQL")
										loc_llOks = .F.
									ENDIF
								ENDIF
							ENDIF
							IF USED("crBusca")
								USE IN crBusca
							ENDIF
						ENDIF

						IF !loc_llOks
							EXIT
						ENDIF
					ENDSCAN

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Update(.T.)
						IF PEMSTATUS(loc_oProg, "SubTitulo", 5)
							loc_oProg.SubTitulo.Caption = "Atualizando Os Registros"
						ENDIF
					ENDIF

					IF loc_llIns
						IF loc_llOks
							IF !EMPTY(loc_lcMsg)
								MsgAviso("N" + CHR(227) + "o Gerados: " + loc_lcMsg, ;
									"C" + CHR(243) + "pia Parcialmente Conclu" + CHR(237) + "da")
							ELSE
								MsgInfo("Os Registros Foram Gerados Com Sucesso!!!", ;
									"C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
							ENDIF
							loc_lResultado = .T.
						ELSE
							MsgErro("Houve Uma Falha na Grava" + CHR(231) + CHR(227) + ;
								"o e Os Registros N" + CHR(195) + "O Foram Gerados!!!", "Erro!!!")
						ENDIF
					ELSE
						MsgAviso("Nenhum Registro Foi Gerado!!!", ;
							"C" + CHR(243) + "pia Conclu" + CHR(237) + "da Sem Sucesso")
					ENDIF

					IF VARTYPE(loc_oProg) = "O"
						loc_oProg.Complete()
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em CopiarPeriodo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		*-- Limpeza de cursores e conexao secundaria (FORA do TRY)
		IF USED("crOrigem")
			USE IN crOrigem
		ENDIF
		IF USED("crFopCff")
			USE IN crFopCff
		ENDIF
		IF USED("crBusca")
			USE IN crBusca
		ENDIF
		IF loc_nConnFP2 > 0
			SQLDISCONNECT(loc_nConnFP2)
		ENDIF

		RETURN loc_lResultado
	ENDPROC

ENDDEFINE

