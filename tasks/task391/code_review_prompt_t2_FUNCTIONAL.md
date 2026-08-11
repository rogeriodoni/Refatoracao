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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCVI.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1953 linhas total):

*-- Linhas 21 a 158:
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
142:         loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
143:         loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
144: 
145:         *-- Container Botoes CRUD (Grupo_op no legado: Left=313, Top=-1)
146:         *-- Posicao canonica no novo sistema: Left=542
147:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
148:         WITH loc_oPagina.cnt_4c_Botoes
149:             .Top         = 0 + 29
150:             .Left        = 542
151:             .Width       = 390
152:             .Height      = 85
153:             .BackStyle = 0
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Botao Incluir (inserir.Left=36 no legado -> canonico Left=5)

*-- Linhas 677 a 747:
677:             .Visible            = .T.
678:         ENDWITH
679: 
680:         *-- BINDEVENTs dos botoes CRUD
681:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,   "Click", THIS, "BtnIncluirClick")
682:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,"Click", THIS, "BtnVisualizarClick")
683:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,   "Click", THIS, "BtnAlterarClick")
684:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,   "Click", THIS, "BtnExcluirClick")
685:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,    "Click", THIS, "BtnBuscarClick")
686:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,   "Click", THIS, "BtnEncerrarClick")
687:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
688:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaOk,    "Click", THIS, "BtnCopiaOkClick")
689:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CopiaCancel,"Click", THIS, "BtnCopiaCancelarClick")
690: 
691:         *-- BINDEVENTs dos campos de filtro
692:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess, "KeyPress", THIS, "FiltroLostFocus")
693:         BINDEVENT(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos, "KeyPress", THIS, "FiltroLostFocus")
694: 
695:         *-- BINDEVENT do grid
696:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
697: 
698:         THIS.TornarControlesVisiveis(loc_oPagina)
699: 
700:         *-- Restaurar container de copia como oculto apos TornarControlesVisiveis
701:         loc_oPagina.cnt_4c_Copia.Visible = .F.
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * ConfigurarPaginaDados - Configura Page2 (Dados)
706:     *--------------------------------------------------------------------------
707:     PROTECTED PROCEDURE ConfigurarPaginaDados()
708:         LOCAL loc_oPagina
709:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
710: 
711:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
712:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
713: 
714:         *-- Container Botoes Acao (Grupo_Salva no legado)
715:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
716:         WITH loc_oPagina.cnt_4c_BotoesAcao
717:             .Top         = 4 + 29
718:             .Left        = 842
719:             .Width       = 160
720:             .Height      = 85
721:             .BackStyle   = 0
722:             .BorderWidth = 0
723:             .Visible     = .T.
724:         ENDWITH
725: 
726:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
727:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
728:             .Caption         = "Confirmar"
729:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
730:             .PicturePosition = 13
731:             .Top             = 5
732:             .Left            = 5
733:             .Width           = 75
734:             .Height          = 75
735:             .BackColor       = RGB(255, 255, 255)
736:             .ForeColor       = RGB(90, 90, 90)
737:             .FontName        = "Tahoma"
738:             .FontSize        = 8
739:             .FontBold        = .T.
740:             .FontItalic      = .T.
741:             .Themes          = .F.
742:             .SpecialEffect   = 0
743:             .MousePointer    = 15
744:             .WordWrap        = .T.
745:             .AutoSize        = .F.
746:             .Visible         = .T.
747:         ENDWITH

*-- Linhas 769 a 813:
769:             .Visible         = .T.
770:         ENDWITH
771: 
772:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
773:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
774: 
775:         *-- CAMPOS PARTE 1/2 (Fase 5): Usuario, Periodo, Tipo, Setor (labels + textboxes)
776:         *-- Compensacao PageFrame: Top = Top_original + 29
777: 
778:         *-- Label: Usuario (Label1 no legado: Left=197, Top=157, ForeColor=36,84,155, Verdana 8)
779:         loc_oPagina.AddObject("lbl_4c_Usuars", "Label")
780:         WITH loc_oPagina.lbl_4c_Usuars
781:             .AutoSize  = .T.
782:             .Caption   = "Usu" + CHR(225) + "rio :"
783:             .Left      = 197
784:             .Top       = 157 + 29
785:             .Width     = 54
786:             .Height    = 15
787:             .FontName  = "Verdana"
788:             .FontSize  = 8
789:             .ForeColor = RGB(36, 84, 155)
790:             .BackStyle = 0
791:             .Visible   = .T.
792:         ENDWITH
793: 
794:         *-- TextBox: getUsuars (Left=251, Top=154, Width=80; lookup SigCdUsu)
795:         loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
796:         WITH loc_oPagina.txt_4c_Usuars
797:             .Left      = 251
798:             .Top       = 154 + 29
799:             .Width     = 80
800:             .Height    = 21
801:             .MaxLength = 10
802:             .Value     = ""
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         *-- Label: Periodo (Label9 no legado: Left=197, Top=182, Verdana 8, ForeColor=36,84,155)
809:         loc_oPagina.AddObject("lbl_4c_LblPeriodo", "Label")
810:         WITH loc_oPagina.lbl_4c_LblPeriodo
811:             .AutoSize  = .T.
812:             .Caption   = "Per" + CHR(237) + "odo :"
813:             .Left      = 197

*-- Linhas 1077 a 1134:
1077:             .Visible   = .T.
1078:         ENDWITH
1079: 
1080:         *-- BINDEVENTs dos campos com lookup (F4 e DblClick)
1081:         BINDEVENT(loc_oPagina.txt_4c_Usuars,  "KeyPress", THIS, "UsuarsLookupKeyPress")
1082:         BINDEVENT(loc_oPagina.txt_4c_Usuars,  "DblClick", THIS, "UsuarsLookupDblClick")
1083:         BINDEVENT(loc_oPagina.txt_4c_Setors,  "KeyPress", THIS, "SetorsLookupKeyPress")
1084:         BINDEVENT(loc_oPagina.txt_4c_Setors,  "DblClick", THIS, "SetorsLookupDblClick")
1085:         BINDEVENT(loc_oPagina.txt_4c_Supervs, "KeyPress", THIS, "SupervsLookupKeyPress")
1086:         BINDEVENT(loc_oPagina.txt_4c_Supervs, "DblClick", THIS, "SupervsLookupDblClick")
1087: 
1088:         THIS.TornarControlesVisiveis(loc_oPagina)
1089:     ENDPROC
1090: 
1091:     *--------------------------------------------------------------------------
1092:     * CarregarLista - Carrega dados no Grid da Page1 com filtro de periodo
1093:     *--------------------------------------------------------------------------
1094:     PROCEDURE CarregarLista()
1095:         LOCAL loc_lResultado, loc_oErro, loc_cMess, loc_cAnos
1096:         LOCAL loc_cFiltro, loc_oGrid, loc_oPagina
1097:         loc_lResultado = .F.
1098: 
1099:         TRY
1100:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1101:                 loc_lResultado = .T.
1102:             ELSE
1103:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1104:                 loc_oGrid   = loc_oPagina.grd_4c_Lista
1105: 
1106:                 *-- Ler filtro de periodo do container cnt_4c_Filtro
1107:                 IF VARTYPE(loc_oPagina.cnt_4c_Filtro) = "O"
1108:                     loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
1109:                     loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")
1110:                 ELSE
1111:                     loc_cMess = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 5, 2)), 2, "0")
1112:                     loc_cAnos = PADL(ALLTRIM(SUBSTR(DTOS(DATE()), 1, 4)), 4, "0")
1113:                 ENDIF
1114: 
1115:                 *-- Construir filtro WHERE
1116:                 IF loc_cMess = "00" OR EMPTY(loc_cMess)
1117:                     loc_cFiltro = "Anos = '" + loc_cAnos + "'"
1118:                 ELSE
1119:                     IF loc_cAnos = "0000" OR EMPTY(loc_cAnos)
1120:                         loc_cFiltro = "Mess = '" + loc_cMess + "'"
1121:                     ELSE
1122:                         loc_cFiltro = "Mess = '" + loc_cMess + "' AND Anos = '" + loc_cAnos + "'"
1123:                     ENDIF
1124:                 ENDIF
1125: 
1126:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1127:                     *-- Vincular grid ao cursor (RecordSource e ControlSource FORA do WITH)
1128:                     loc_oGrid.RecordSource = "crSigCcCmV"
1129:                     loc_oGrid.ColumnCount  = 8
1130: 
1131:                     loc_oGrid.Column1.ControlSource = "crSigCcCmV.Usuars"
1132:                     loc_oGrid.Column2.ControlSource = "crSigCcCmV.Mess"
1133:                     loc_oGrid.Column3.ControlSource = "crSigCcCmV.Anos"
1134:                     loc_oGrid.Column4.ControlSource = "crSigCcCmV.Indivs"

*-- Linhas 1188 a 1796:
1188:     *--------------------------------------------------------------------------
1189:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1190:     *--------------------------------------------------------------------------
1191:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1192:         LOCAL loc_lResultado
1193:         loc_lResultado = .F.
1194: 
1195:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1196:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1197:             IF par_nPagina = 1
1198:                 THIS.CarregarLista()
1199:             ENDIF
1200:             loc_lResultado = .T.
1201:         ENDIF
1202: 
1203:         RETURN loc_lResultado
1204:     ENDPROC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * BtnIncluirClick - Incluir novo registro
1208:     *--------------------------------------------------------------------------
1209:     PROCEDURE BtnIncluirClick()
1210:         THIS.this_oBusinessObject.NovoRegistro()
1211:         THIS.LimparCampos()
1212:         THIS.this_cModoAtual = "INCLUIR"
1213:         THIS.HabilitarCampos(.T.)
1214:         THIS.AjustarBotoesPorModo()
1215:         THIS.AlternarPagina(2)
1216:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1217:     ENDPROC
1218: 
1219:     *--------------------------------------------------------------------------
1220:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
1221:     *--------------------------------------------------------------------------
1222:     PROCEDURE BtnVisualizarClick()
1223:         LOCAL loc_cChave
1224:         loc_cChave = ""
1225: 
1226:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1227:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1228:             RETURN
1229:         ENDIF
1230: 
1231:         SELECT crSigCcCmV
1232:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1233: 
1234:         IF EMPTY(loc_cChave)
1235:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
1236:             RETURN
1237:         ENDIF
1238: 
1239:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1240:             THIS.this_cModoAtual = "VISUALIZAR"
1241:             THIS.BOParaForm()
1242:             THIS.HabilitarCampos(.F.)
1243:             THIS.AjustarBotoesPorModo()
1244:             THIS.AlternarPagina(2)
1245:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
1246:         ENDIF
1247:     ENDPROC
1248: 
1249:     *--------------------------------------------------------------------------
1250:     * BtnAlterarClick - Alterar registro selecionado
1251:     *--------------------------------------------------------------------------
1252:     PROCEDURE BtnAlterarClick()
1253:         LOCAL loc_cChave
1254:         loc_cChave = ""
1255: 
1256:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1257:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1258:             RETURN
1259:         ENDIF
1260: 
1261:         SELECT crSigCcCmV
1262:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1263: 
1264:         IF EMPTY(loc_cChave)
1265:             MsgAviso("Nenhum registro selecionado.", "Alterar")
1266:             RETURN
1267:         ENDIF
1268: 
1269:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1270:             THIS.this_oBusinessObject.EditarRegistro()
1271:             THIS.this_cModoAtual = "ALTERAR"
1272:             THIS.BOParaForm()
1273:             THIS.HabilitarCampos(.T.)
1274:             THIS.AjustarBotoesPorModo()
1275:             THIS.AlternarPagina(2)
1276:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
1277:         ENDIF
1278:     ENDPROC
1279: 
1280:     *--------------------------------------------------------------------------
1281:     * BtnExcluirClick - Excluir registro selecionado
1282:     *--------------------------------------------------------------------------
1283:     PROCEDURE BtnExcluirClick()
1284:         LOCAL loc_cChave, loc_lConfirmou
1285:         loc_cChave    = ""
1286:         loc_lConfirmou = .F.
1287: 
1288:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1289:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1290:             RETURN
1291:         ENDIF
1292: 
1293:         SELECT crSigCcCmV
1294:         loc_cChave = ALLTRIM(crSigCcCmV.cIdChaves)
1295: 
1296:         IF EMPTY(loc_cChave)
1297:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1298:             RETURN
1299:         ENDIF
1300: 
1301:         loc_lConfirmou = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1302:         IF !loc_lConfirmou
1303:             RETURN
1304:         ENDIF
1305: 
1306:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cChave)
1307:             IF THIS.this_oBusinessObject.Excluir()
1308:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1309:                 THIS.CarregarLista()
1310:             ENDIF
1311:         ENDIF
1312:     ENDPROC
1313: 
1314:     *--------------------------------------------------------------------------
1315:     * BtnBuscarClick - Recarregar lista com filtro atual
1316:     *--------------------------------------------------------------------------
1317:     PROCEDURE BtnBuscarClick()
1318:         THIS.FiltroLostFocus()
1319:     ENDPROC
1320: 
1321:     *--------------------------------------------------------------------------
1322:     * BtnEncerrarClick - Fecha o formulario
1323:     *--------------------------------------------------------------------------
1324:     PROCEDURE BtnEncerrarClick()
1325:         THIS.Release()
1326:     ENDPROC
1327: 
1328:     *--------------------------------------------------------------------------
1329:     * BtnSalvarClick - Salva o registro atual
1330:     *--------------------------------------------------------------------------
1331:     PROCEDURE BtnSalvarClick()
1332:         LOCAL loc_lResultado, loc_oErro
1333:         loc_lResultado = .F.
1334: 
1335:         IF THIS.this_cModoAtual = "VISUALIZAR"
1336:             THIS.BtnCancelarClick()
1337:             RETURN
1338:         ENDIF
1339: 
1340:         IF !THIS.this_oBusinessObject.ValidarDados()
1341:             RETURN
1342:         ENDIF
1343: 
1344:         TRY
1345:             IF THIS.FormParaBO()
1346:                 IF THIS.this_oBusinessObject.Salvar()
1347:                     MsgInfo("Registro salvo com sucesso!")
1348:                     THIS.this_cModoAtual = "LISTA"
1349:                     THIS.AlternarPagina(1)
1350:                     loc_lResultado = .T.
1351:                 ENDIF
1352:             ENDIF
1353:         CATCH TO loc_oErro
1354:             MsgErro("Erro ao salvar:" + CHR(13) + loc_oErro.Message, "Erro")
1355:             loc_lResultado = .F.
1356:         ENDTRY
1357: 
1358:         RETURN loc_lResultado
1359:     ENDPROC
1360: 
1361:     *--------------------------------------------------------------------------
1362:     * BtnCancelarClick - Cancela e volta para a lista
1363:     *--------------------------------------------------------------------------
1364:     PROCEDURE BtnCancelarClick()
1365:         THIS.this_cModoAtual = "LISTA"
1366:         THIS.AlternarPagina(1)
1367:         THIS.CarregarLista()
1368:     ENDPROC
1369: 
1370:     *--------------------------------------------------------------------------
1371:     * BtnCopiaClick - Mostra/oculta painel de copia de periodo
1372:     *--------------------------------------------------------------------------
1373:     PROCEDURE BtnCopiaClick()
1374:         LOCAL loc_oPagina, loc_oCopia
1375:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1376:         loc_oCopia  = loc_oPagina.cnt_4c_Copia
1377: 
1378:         *-- Desabilitar controles da lista ao abrir painel de copia
1379:         loc_oPagina.grd_4c_Lista.Enabled         = .F.
1380:         loc_oPagina.cnt_4c_Saida.Enabled         = .F.
1381:         loc_oPagina.cnt_4c_Botoes.Enabled        = .F.
1382:         loc_oPagina.cmd_4c_Copia.Enabled         = .F.
1383:         THIS.pgf_4c_Paginas.Page2.Enabled        = .F.
1384: 
1385:         *-- Prefill com o periodo do filtro atual
1386:         WITH loc_oCopia
1387:             .txt_4c_OMess.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value
1388:             .txt_4c_OAnos.Value = loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value
1389:             .txt_4c_DMess.Value = ""
1390:             .txt_4c_DAnos.Value = ""
1391:             .Visible = .T.
1392:         ENDWITH
1393: 
1394:         loc_oCopia.txt_4c_OMess.SetFocus
1395:     ENDPROC
1396: 
1397:     *--------------------------------------------------------------------------
1398:     * BtnCopiaCancelarClick - Cancela copia de periodo e restaura controles
1399:     *--------------------------------------------------------------------------
1400:     PROCEDURE BtnCopiaCancelarClick()
1401:         LOCAL loc_oPagina
1402:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1403: 
1404:         loc_oPagina.cnt_4c_Copia.Visible         = .F.
1405:         loc_oPagina.grd_4c_Lista.Enabled         = .T.
1406:         loc_oPagina.cnt_4c_Saida.Enabled         = .T.
1407:         loc_oPagina.cnt_4c_Botoes.Enabled        = .T.
1408:         loc_oPagina.cmd_4c_Copia.Enabled         = .T.
1409:         THIS.pgf_4c_Paginas.Page2.Enabled        = .T.
1410: 
1411:         THIS.Refresh()
1412:         loc_oPagina.grd_4c_Lista.SetFocus
1413:     ENDPROC
1414: 
1415:     *--------------------------------------------------------------------------
1416:     * BtnCopiaOkClick - Executa copia de periodo via BO.CopiarPeriodo()
1417:     *--------------------------------------------------------------------------
1418:     PROCEDURE BtnCopiaOkClick()
1419:         LOCAL loc_oPagina, loc_oCopia
1420:         LOCAL loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos
1421:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1422:         loc_oCopia  = loc_oPagina.cnt_4c_Copia
1423: 
1424:         loc_cOMess = PADL(ALLTRIM(loc_oCopia.txt_4c_OMess.Value), 2, "0")
1425:         loc_cOAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_OAnos.Value), 4, "0")
1426:         loc_cDMess = PADL(ALLTRIM(loc_oCopia.txt_4c_DMess.Value), 2, "0")
1427:         loc_cDAnos = PADL(ALLTRIM(loc_oCopia.txt_4c_DAnos.Value), 4, "0")
1428: 
1429:         IF EMPTY(loc_cOMess) OR loc_cOMess = "00"
1430:             MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1431:                 "s de Refer" + CHR(234) + "ncia da Origem!", "C" + CHR(243) + "pia")
1432:             loc_oCopia.txt_4c_OMess.SetFocus
1433:             RETURN
1434:         ENDIF
1435: 
1436:         IF !BETWEEN(VAL(loc_cOMess), 1, 12)
1437:             MsgAviso("M" + CHR(234) + "s de Origem inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
1438:             loc_oCopia.txt_4c_OMess.SetFocus
1439:             RETURN
1440:         ENDIF
1441: 
1442:         IF EMPTY(loc_cOAnos) OR loc_cOAnos = "0000"
1443:             MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1444:                 "ncia da Origem!", "C" + CHR(243) + "pia")
1445:             loc_oCopia.txt_4c_OAnos.SetFocus
1446:             RETURN
1447:         ENDIF
1448: 
1449:         IF EMPTY(loc_cDMess) OR loc_cDMess = "00"
1450:             MsgAviso("Obrigat" + CHR(243) + "rio informar o M" + CHR(234) + ;
1451:                 "s de Refer" + CHR(234) + "ncia do Destino!", "C" + CHR(243) + "pia")
1452:             loc_oCopia.txt_4c_DMess.SetFocus
1453:             RETURN
1454:         ENDIF
1455: 
1456:         IF !BETWEEN(VAL(loc_cDMess), 1, 12)
1457:             MsgAviso("M" + CHR(234) + "s de Destino inv" + CHR(225) + "lido (01-12).", "C" + CHR(243) + "pia")
1458:             loc_oCopia.txt_4c_DMess.SetFocus
1459:             RETURN
1460:         ENDIF
1461: 
1462:         IF EMPTY(loc_cDAnos) OR loc_cDAnos = "0000"
1463:             MsgAviso("Obrigat" + CHR(243) + "rio informar o Ano de Refer" + CHR(234) + ;
1464:                 "ncia do Destino!", "C" + CHR(243) + "pia")
1465:             loc_oCopia.txt_4c_DAnos.SetFocus
1466:             RETURN
1467:         ENDIF
1468: 
1469:         IF loc_cOMess = loc_cDMess AND loc_cOAnos = loc_cDAnos
1470:             MsgAviso("Per" + CHR(237) + "odo de origem e destino s" + CHR(227) + "o iguais.", "C" + CHR(243) + "pia")
1471:             RETURN
1472:         ENDIF
1473: 
1474:         IF !MsgConfirma("Confirma a c" + CHR(243) + "pia do per" + CHR(237) + "odo " + ;
1475:                 loc_cOMess + "/" + loc_cOAnos + " para " + loc_cDMess + "/" + loc_cDAnos + "?", ;
1476:                 "C" + CHR(243) + "pia de Per" + CHR(237) + "odo")
1477:             RETURN
1478:         ENDIF
1479: 
1480:         IF THIS.this_oBusinessObject.CopiarPeriodo(loc_cOMess, loc_cOAnos, loc_cDMess, loc_cDAnos)
1481:             MsgInfo("C" + CHR(243) + "pia realizada com sucesso!")
1482:             THIS.BtnCopiaCancelarClick()
1483:             THIS.CarregarLista()
1484:         ENDIF
1485:     ENDPROC
1486: 
1487:     *--------------------------------------------------------------------------
1488:     * FiltroLostFocus - Chamado quando campo de filtro perde foco; recarrega lista
1489:     *--------------------------------------------------------------------------
1490:     PROCEDURE FiltroLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1491:         LOCAL loc_oPagina, loc_cMess, loc_cAnos
1492:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1493: 
1494:         *-- Padl nos campos de filtro
1495:         loc_cMess = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value), 2, "0")
1496:         loc_cAnos = PADL(ALLTRIM(loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value), 4, "0")
1497: 
1498:         loc_oPagina.cnt_4c_Filtro.txt_4c_Mess.Value = loc_cMess
1499:         loc_oPagina.cnt_4c_Filtro.txt_4c_Anos.Value = loc_cAnos
1500: 
1501:         THIS.CarregarLista()
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * GradeAfterRowColChange - Handler do grid apos mudanca de linha/coluna
1506:     *--------------------------------------------------------------------------
1507:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1508:         IF !USED("crSigCcCmV") OR EOF("crSigCcCmV")
1509:             RETURN
1510:         ENDIF
1511:     ENDPROC
1512: 
1513:     *--------------------------------------------------------------------------
1514:     * FormParaBO - Transfere dados do Form para o BO
1515:     *--------------------------------------------------------------------------
1516:     PROTECTED PROCEDURE FormParaBO()
1517:         LOCAL loc_lResultado, loc_oErro, loc_oPg2
1518:         loc_lResultado = .F.
1519: 
1520:         TRY
1521:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1522: 
1523:             THIS.this_oBusinessObject.this_cUsuars  = ALLTRIM(loc_oPg2.txt_4c_Usuars.Value)
1524:             THIS.this_oBusinessObject.this_cMess    = PADL(ALLTRIM(loc_oPg2.txt_4c_Mess.Value), 2, "0")
1525:             THIS.this_oBusinessObject.this_cAnos    = PADL(ALLTRIM(loc_oPg2.txt_4c_Anos.Value), 4, "0")
1526:             THIS.this_oBusinessObject.this_cIndivs  = UPPER(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))
1527:             THIS.this_oBusinessObject.this_cSetors  = ALLTRIM(loc_oPg2.txt_4c_Setors.Value)
1528:             THIS.this_oBusinessObject.this_cSupervs = ALLTRIM(loc_oPg2.txt_4c_Supervs.Value)
1529:             THIS.this_oBusinessObject.this_nAdics   = loc_oPg2.txt_4c_Adics.Value
1530:             THIS.this_oBusinessObject.this_nMinimos = loc_oPg2.txt_4c_Minimos.Value
1531:             THIS.this_oBusinessObject.this_nMinExps = loc_oPg2.txt_4c_MinExps.Value
1532: 
1533:             loc_lResultado = .T.
1534:         CATCH TO loc_oErro
1535:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1536:             loc_lResultado = .F.
1537:         ENDTRY
1538: 
1539:         RETURN loc_lResultado
1540:     ENDPROC
1541: 
1542:     *--------------------------------------------------------------------------
1543:     * BOParaForm - Transfere dados do BO para o Form
1544:     *--------------------------------------------------------------------------
1545:     PROTECTED PROCEDURE BOParaForm()
1546:         LOCAL loc_lResultado, loc_oErro, loc_oPg2
1547:         loc_lResultado = .F.
1548: 
1549:         TRY
1550:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1551: 
1552:             loc_oPg2.txt_4c_Usuars.Value  = THIS.this_oBusinessObject.this_cUsuars
1553:             loc_oPg2.txt_4c_Mess.Value    = THIS.this_oBusinessObject.this_cMess
1554:             loc_oPg2.txt_4c_Anos.Value    = THIS.this_oBusinessObject.this_cAnos
1555:             loc_oPg2.txt_4c_Indivs.Value  = THIS.this_oBusinessObject.this_cIndivs
1556:             loc_oPg2.txt_4c_Setors.Value  = THIS.this_oBusinessObject.this_cSetors
1557:             loc_oPg2.txt_4c_Supervs.Value = THIS.this_oBusinessObject.this_cSupervs
1558:             loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(THIS.this_oBusinessObject.this_nAdics)
1559:             loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinimos)
1560:             loc_oPg2.txt_4c_MinExps.Value = TRANSFORM(THIS.this_oBusinessObject.this_nMinExps)
1561: 
1562:             loc_lResultado = .T.
1563:         CATCH TO loc_oErro
1564:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")
1565:             loc_lResultado = .F.
1566:         ENDTRY
1567: 
1568:         RETURN loc_lResultado
1569:     ENDPROC
1570: 
1571:     *--------------------------------------------------------------------------
1572:     * LimparCampos - Limpa valores dos campos da Page2
1573:     *--------------------------------------------------------------------------
1574:     PROTECTED PROCEDURE LimparCampos()
1575:         LOCAL loc_oErro, loc_oPg2
1576:         TRY
1577:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1578:             loc_oPg2.txt_4c_Usuars.Value  = ""
1579:             loc_oPg2.txt_4c_Mess.Value    = ""
1580:             loc_oPg2.txt_4c_Anos.Value    = ""
1581:             loc_oPg2.txt_4c_Indivs.Value  = ""
1582:             loc_oPg2.txt_4c_Setors.Value  = ""
1583:             loc_oPg2.txt_4c_Supervs.Value = ""
1584:             loc_oPg2.txt_4c_Adics.Value   = ""
1585:             loc_oPg2.txt_4c_Minimos.Value = ""
1586:             loc_oPg2.txt_4c_MinExps.Value = ""
1587:         CATCH TO loc_oErro
1588:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1589:         ENDTRY
1590:     ENDPROC
1591: 
1592:     *--------------------------------------------------------------------------
1593:     * HabilitarCampos - Habilita/desabilita campos da Page2
1594:     *--------------------------------------------------------------------------
1595:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1596:         LOCAL loc_oErro, loc_oPg2, loc_lHab
1597:         loc_lHab = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar)
1598:         TRY
1599:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1600:             loc_oPg2.txt_4c_Usuars.ReadOnly  = !loc_lHab
1601:             loc_oPg2.txt_4c_Mess.ReadOnly    = !loc_lHab
1602:             loc_oPg2.txt_4c_Anos.ReadOnly    = !loc_lHab
1603:             loc_oPg2.txt_4c_Indivs.ReadOnly  = !loc_lHab
1604:             loc_oPg2.txt_4c_Setors.ReadOnly  = !loc_lHab
1605:             loc_oPg2.txt_4c_Supervs.ReadOnly = !loc_lHab
1606:             loc_oPg2.txt_4c_Adics.ReadOnly   = !loc_lHab
1607:             loc_oPg2.txt_4c_Minimos.ReadOnly = !loc_lHab
1608:             loc_oPg2.txt_4c_MinExps.ReadOnly = !loc_lHab
1609: 
1610:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
1611:         CATCH TO loc_oErro
1612:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1613:         ENDTRY
1614:     ENDPROC
1615: 
1616:     *--------------------------------------------------------------------------
1617:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1618:     *--------------------------------------------------------------------------
1619:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1620:         LOCAL loc_oErro, loc_oPg1, loc_oPg2, loc_lEditando
1621:         TRY
1622:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1623:             loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1624:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1625: 
1626:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
1627:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1628:         CATCH TO loc_oErro
1629:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
1630:         ENDTRY
1631:     ENDPROC
1632: 
1633:     *--------------------------------------------------------------------------
1634:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1635:     *--------------------------------------------------------------------------
1636:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1637:         LOCAL loc_nI, loc_oObjeto, loc_nP
1638: 
1639:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1640:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1641: 
1642:             IF VARTYPE(loc_oObjeto) = "O"
1643:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1644:                     IF !INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
1645:                         loc_oObjeto.Visible = .T.
1646:                     ENDIF
1647:                 ENDIF
1648: 
1649:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1650:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1651:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1652:                     ENDFOR
1653:                 ENDIF
1654: 
1655:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1656:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1657:                 ENDIF
1658:             ENDIF
1659:         ENDFOR
1660:     ENDPROC
1661: 
1662:     *--------------------------------------------------------------------------
1663:     * FormatarGridLista - Formata visual do grid da lista
1664:     *--------------------------------------------------------------------------
1665:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1666:         WITH par_oGrid
1667:             .FontName = "Tahoma"
1668:             .FontSize = 8
1669:         ENDWITH
1670:     ENDPROC
1671: 
1672:     *--------------------------------------------------------------------------
1673:     * Destroy - Libera recursos
1674:     *--------------------------------------------------------------------------
1675:     PROCEDURE Destroy()
1676:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1677:             THIS.this_oBusinessObject = .NULL.
1678:         ENDIF
1679:         IF USED("crSigCcCmV")
1680:             USE IN crSigCcCmV
1681:         ENDIF
1682:         IF USED("cursor_4c_BuscaSup")
1683:             USE IN cursor_4c_BuscaSup
1684:         ENDIF
1685:         DODEFAULT()
1686:     ENDPROC
1687: 
1688:     *--------------------------------------------------------------------------
1689:     * UsuarsLookupKeyPress - Handler KeyPress para txt_4c_Usuars (F4 = abre lookup)
1690:     *--------------------------------------------------------------------------
1691:     PROCEDURE UsuarsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1692:         IF par_nKeyCode = 28  && F4 no VFP9
1693:             THIS.AbrirLookupUsuars()
1694:         ENDIF
1695:     ENDPROC
1696: 
1697:     *--------------------------------------------------------------------------
1698:     * UsuarsLookupDblClick - Handler DblClick para txt_4c_Usuars
1699:     *--------------------------------------------------------------------------
1700:     PROCEDURE UsuarsLookupDblClick()
1701:         THIS.AbrirLookupUsuars()
1702:     ENDPROC
1703: 
1704:     *--------------------------------------------------------------------------
1705:     * AbrirLookupUsuars - Lookup em SigCdUsu (Usuarios / Nome Completo)
1706:     *--------------------------------------------------------------------------
1707:     PROCEDURE AbrirLookupUsuars()
1708:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
1709:         loc_oBusca   = .NULL.
1710:         loc_lReadOnly = .F.
1711: 
1712:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1713:         IF VARTYPE(loc_oPg2.txt_4c_Usuars) = "O"
1714:             loc_lReadOnly = loc_oPg2.txt_4c_Usuars.ReadOnly
1715:         ENDIF
1716:         IF loc_lReadOnly
1717:             RETURN
1718:         ENDIF
1719: 
1720:         TRY
1721:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1722:                 "SigCdUsu", "cursor_4c_BuscaUsu", "Usuarios", ;
1723:                 loc_oPg2.txt_4c_Usuars.Value, ;
1724:                 "Usu" + CHR(225) + "rios")
1725:             IF VARTYPE(loc_oBusca) = "O"
1726:                 loc_oBusca.mAddColuna("Usuarios", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
1727:                 loc_oBusca.mAddColuna("NComps",   "X(40)",     "Nome Completo")
1728:                 loc_oBusca.Show()
1729:                 IF loc_oBusca.this_lSelecionou
1730:                     loc_oPg2.txt_4c_Usuars.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1731:                     THIS.PreencherUltimoPeriodoUsuario(ALLTRIM(loc_oBusca.this_cValorSelecionado))
1732:                 ENDIF
1733:                 IF USED("cursor_4c_BuscaUsu")
1734:                     USE IN cursor_4c_BuscaUsu
1735:                 ENDIF
1736:                 loc_oBusca.Release()
1737:                 loc_oBusca = .NULL.
1738:             ENDIF
1739:         CATCH TO loc_oErro
1740:             MsgErro("Erro ao abrir lookup de Usu" + CHR(225) + "rio:" + ;
1741:                 CHR(13) + loc_oErro.Message, "Erro")
1742:             IF USED("cursor_4c_BuscaUsu")
1743:                 USE IN cursor_4c_BuscaUsu
1744:             ENDIF
1745:             IF VARTYPE(loc_oBusca) = "O"
1746:                 loc_oBusca.Release()
1747:                 loc_oBusca = .NULL.
1748:             ENDIF
1749:         ENDTRY
1750:     ENDPROC
1751: 
1752:     *--------------------------------------------------------------------------
1753:     * PreencherUltimoPeriodoUsuario - Preenche campos com ultimo periodo do usuario
1754:     * Chamado apos selecao no lookup de usuario, quando outros campos estao vazios
1755:     *--------------------------------------------------------------------------
1756:     PROTECTED PROCEDURE PreencherUltimoPeriodoUsuario(par_cUsuario)
1757:         LOCAL loc_lProceder, loc_oErro, loc_oPg2
1758:         LOCAL loc_cSQL, loc_nRet, loc_dBase, loc_dProx
1759:         LOCAL loc_cMess, loc_cAnos
1760: 
1761:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1762: 
1763:         *-- So preenche se os demais campos estiverem vazios
1764:         loc_lProceder = EMPTY(ALLTRIM(loc_oPg2.txt_4c_Mess.Value)) AND ;
1765:                         EMPTY(ALLTRIM(loc_oPg2.txt_4c_Anos.Value)) AND ;
1766:                         EMPTY(ALLTRIM(loc_oPg2.txt_4c_Indivs.Value))
1767: 
1768:         IF !loc_lProceder
1769:             RETURN
1770:         ENDIF
1771: 
1772:         TRY
1773:             loc_cSQL = "SELECT TOP 1 Mess, Anos, Indivs, Setors, Supervs, Adics, Minimos " + ;
1774:                        "FROM SigCcCmV " + ;
1775:                        "WHERE Usuars = " + EscaparSQL(par_cUsuario) + " " + ;
1776:                        "ORDER BY Anos DESC, Mess DESC"
1777: 
1778:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltPer")
1779: 
1780:             IF loc_nRet > 0 AND USED("cursor_4c_UltPer") AND !EOF("cursor_4c_UltPer")
1781:                 *-- Calcular proximo periodo via GOMONTH
1782:                 loc_cMess = PADL(ALLTRIM(cursor_4c_UltPer.Mess), 2, "0")
1783:                 loc_cAnos = PADL(ALLTRIM(cursor_4c_UltPer.Anos), 4, "0")
1784:                 loc_dBase = DATE(VAL(loc_cAnos), VAL(loc_cMess), 1)
1785:                 loc_dProx = GOMONTH(loc_dBase, 1)
1786: 
1787:                 loc_oPg2.txt_4c_Mess.Value    = PADL(LTRIM(STR(MONTH(loc_dProx))), 2, "0")
1788:                 loc_oPg2.txt_4c_Anos.Value    = LTRIM(STR(YEAR(loc_dProx)))
1789:                 loc_oPg2.txt_4c_Indivs.Value  = ALLTRIM(cursor_4c_UltPer.Indivs)
1790:                 loc_oPg2.txt_4c_Setors.Value  = ALLTRIM(cursor_4c_UltPer.Setors)
1791:                 loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(cursor_4c_UltPer.Supervs)
1792:                 loc_oPg2.txt_4c_Adics.Value   = TRANSFORM(cursor_4c_UltPer.Adics)
1793:                 loc_oPg2.txt_4c_Minimos.Value = TRANSFORM(cursor_4c_UltPer.Minimos)
1794: 
1795:                 IF USED("cursor_4c_UltPer")
1796:                     USE IN cursor_4c_UltPer

*-- Linhas 1808 a 1953:
1808:     *--------------------------------------------------------------------------
1809:     * SetorsLookupKeyPress - Handler KeyPress para txt_4c_Setors (F4 = abre lookup)
1810:     *--------------------------------------------------------------------------
1811:     PROCEDURE SetorsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1812:         IF par_nKeyCode = 28  && F4 no VFP9
1813:             THIS.AbrirLookupSetors()
1814:         ENDIF
1815:     ENDPROC
1816: 
1817:     *--------------------------------------------------------------------------
1818:     * SetorsLookupDblClick - Handler DblClick para txt_4c_Setors
1819:     *--------------------------------------------------------------------------
1820:     PROCEDURE SetorsLookupDblClick()
1821:         THIS.AbrirLookupSetors()
1822:     ENDPROC
1823: 
1824:     *--------------------------------------------------------------------------
1825:     * AbrirLookupSetors - Lookup em SigCdSet (Setores / Descricao)
1826:     *--------------------------------------------------------------------------
1827:     PROCEDURE AbrirLookupSetors()
1828:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro
1829:         loc_oBusca   = .NULL.
1830:         loc_lReadOnly = .F.
1831: 
1832:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1833:         IF VARTYPE(loc_oPg2.txt_4c_Setors) = "O"
1834:             loc_lReadOnly = loc_oPg2.txt_4c_Setors.ReadOnly
1835:         ENDIF
1836:         IF loc_lReadOnly
1837:             RETURN
1838:         ENDIF
1839: 
1840:         TRY
1841:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1842:                 "SigCdSet", "cursor_4c_BuscaSet", "Setores", ;
1843:                 loc_oPg2.txt_4c_Setors.Value, ;
1844:                 "Setores")
1845:             IF VARTYPE(loc_oBusca) = "O"
1846:                 loc_oBusca.mAddColuna("Setores", "XXXXXXXXXX", "Setor")
1847:                 loc_oBusca.mAddColuna("Descrs",  "X(40)",     "Descri" + CHR(231) + CHR(227) + "o")
1848:                 loc_oBusca.Show()
1849:                 IF loc_oBusca.this_lSelecionou
1850:                     loc_oPg2.txt_4c_Setors.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1851:                 ENDIF
1852:                 IF USED("cursor_4c_BuscaSet")
1853:                     USE IN cursor_4c_BuscaSet
1854:                 ENDIF
1855:                 loc_oBusca.Release()
1856:                 loc_oBusca = .NULL.
1857:             ENDIF
1858:         CATCH TO loc_oErro
1859:             MsgErro("Erro ao abrir lookup de Setor:" + CHR(13) + loc_oErro.Message, "Erro")
1860:             IF USED("cursor_4c_BuscaSet")
1861:                 USE IN cursor_4c_BuscaSet
1862:             ENDIF
1863:             IF VARTYPE(loc_oBusca) = "O"
1864:                 loc_oBusca.Release()
1865:                 loc_oBusca = .NULL.
1866:             ENDIF
1867:         ENDTRY
1868:     ENDPROC
1869: 
1870:     *--------------------------------------------------------------------------
1871:     * SupervsLookupKeyPress - Handler KeyPress para txt_4c_Supervs (F4 = abre lookup)
1872:     *--------------------------------------------------------------------------
1873:     PROCEDURE SupervsLookupKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1874:         IF par_nKeyCode = 28  && F4 no VFP9
1875:             THIS.AbrirLookupSupervs()
1876:         ENDIF
1877:     ENDPROC
1878: 
1879:     *--------------------------------------------------------------------------
1880:     * SupervsLookupDblClick - Handler DblClick para txt_4c_Supervs
1881:     *--------------------------------------------------------------------------
1882:     PROCEDURE SupervsLookupDblClick()
1883:         THIS.AbrirLookupSupervs()
1884:     ENDPROC
1885: 
1886:     *--------------------------------------------------------------------------
1887:     * AbrirLookupSupervs - Lookup dinamico de responsaveis em SigCcCmV/SigCdUsu
1888:     * Busca DISTINCT usuarios com Indivs='R' e Supervs/Setors em branco
1889:     *--------------------------------------------------------------------------
1890:     PROCEDURE AbrirLookupSupervs()
1891:         LOCAL loc_oPg2, loc_lReadOnly, loc_oBusca, loc_oErro, loc_nRet, loc_cSQL
1892:         loc_oBusca   = .NULL.
1893:         loc_lReadOnly = .F.
1894: 
1895:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1896:         IF VARTYPE(loc_oPg2.txt_4c_Supervs) = "O"
1897:             loc_lReadOnly = loc_oPg2.txt_4c_Supervs.ReadOnly
1898:         ENDIF
1899:         IF loc_lReadOnly
1900:             RETURN
1901:         ENDIF
1902: 
1903:         TRY
1904:             *-- Montar cursor dinamico de responsaveis (Indivs='R', sem Supervs/Setors proprios)
1905:             loc_cSQL = "SELECT DISTINCT a.Usuars, b.NComps " + ;
1906:                        "FROM SigCcCmV a " + ;
1907:                        "INNER JOIN SigCdUsu b ON a.Usuars = b.Usuarios " + ;
1908:                        "WHERE a.Indivs = 'R' " + ;
1909:                        "AND RTRIM(a.Supervs) = '' " + ;
1910:                        "AND RTRIM(a.Setors) = '' " + ;
1911:                        "ORDER BY a.Usuars"
1912: 
1913:             IF USED("cursor_4c_BuscaSup")
1914:                 USE IN cursor_4c_BuscaSup
1915:             ENDIF
1916: 
1917:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaSup")
1918: 
1919:             IF loc_nRet <= 0 OR !USED("cursor_4c_BuscaSup")
1920:                 MsgAviso("Nenhum respons" + CHR(225) + "vel encontrado.", "Respons" + CHR(225) + "vel")
1921:                 RETURN
1922:             ENDIF
1923: 
1924:             *-- FormBuscaAuxiliar MODO 2: sem params Init, cursor pre-existente
1925:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1926:             IF VARTYPE(loc_oBusca) = "O"
1927:                 loc_oBusca.this_cCursorDestino = "cursor_4c_BuscaSup"
1928:                 loc_oBusca.mAddColuna("Usuars", "XXXXXXXXXX", "Usu" + CHR(225) + "rio")
1929:                 loc_oBusca.mAddColuna("NComps", "X(40)",     "Nome Completo")
1930:                 loc_oBusca.Show()
1931:                 IF loc_oBusca.this_lSelecionou
1932:                     loc_oPg2.txt_4c_Supervs.Value = ALLTRIM(loc_oBusca.this_cValorSelecionado)
1933:                 ENDIF
1934:                 IF USED("cursor_4c_BuscaSup")
1935:                     USE IN cursor_4c_BuscaSup
1936:                 ENDIF
1937:                 loc_oBusca.Release()
1938:                 loc_oBusca = .NULL.
1939:             ENDIF
1940:         CATCH TO loc_oErro
1941:             MsgErro("Erro ao abrir lookup de Respons" + CHR(225) + "vel:" + ;
1942:                 CHR(13) + loc_oErro.Message, "Erro")
1943:             IF USED("cursor_4c_BuscaSup")
1944:                 USE IN cursor_4c_BuscaSup
1945:             ENDIF
1946:             IF VARTYPE(loc_oBusca) = "O"
1947:                 loc_oBusca.Release()
1948:                 loc_oBusca = .NULL.
1949:             ENDIF
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953: ENDDEFINE


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

