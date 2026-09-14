# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [BINDEVENT-PARAMS] Handler 'ValidarTamanhoFolha' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTamanhoFolha(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarNomeImpressora' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarNomeImpressora(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCHM.Pagina.Dados): Top original=137 vs migrado 'lbl_4c_Label11' Top=345 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget1' (parent: SIGCDCHM.Pagina.Dados): Top original=133 vs migrado 'txt_4c_Fwget17' Top=366 (diff=233px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCHM.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1599 linhas total):

*-- Linhas 27 a 152:
27:     this_cMensagemErro   = ""
28: 
29:     *--------------------------------------------------------------------------
30:     PROCEDURE Init()
31:     *--------------------------------------------------------------------------
32:         RETURN DODEFAULT()
33:     ENDPROC
34: 
35:     *--------------------------------------------------------------------------
36:     PROTECTED PROCEDURE InicializarForm()
37:     *--------------------------------------------------------------------------
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("CHMBO")
43: 
44:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
45:                 MostrarErro("Erro ao criar Business Object CHMBO", ;
46:                             "Erro Cr" + CHR(237) + "tico")
47:                 loc_lSucesso = .F.
48:             ELSE
49:                 THIS.Caption = "Cadastro de Configura" + CHR(231) + CHR(227) + ;
50:                                "o do Cheque - Matricial"
51: 
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.ConfigurarPaginaLista()
54:                 THIS.ConfigurarPaginaDados()
55: 
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
57:                     THIS.Caption
58: 
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 THIS.pgf_4c_Paginas.Visible    = .T.
64:                 THIS.pgf_4c_Paginas.ActivePage = 1
65:                 THIS.this_cModoAtual = "LISTA"
66:                 loc_lSucesso = .T.
67:             ENDIF
68: 
69:         CATCH TO loException
70:             MostrarErro("Erro ao inicializar FormCHM:" + CHR(13) + ;
71:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
72:                         loException.Message, "Erro")
73:             loc_lSucesso = .F.
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Configura o PageFrame principal
81:     * Legado: Pagina.Top=-29 (oculta abas), Width=1003, Height=629
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 629
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e Botoes CRUD
107:     * Compensacao PageFrame.Top=-29: Top_original + 29
108:     * Grade legado: top=119+29=148, left=32, width=940, height=470
109:     * cnt_4c_Botoes canonico: Left=542, Top=29
110:     * cnt_4c_Saida canonico: Left=917 (Rule #10)
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina, loc_oGrid
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container de cabecalho (cntSombra: Top=2+29=31)
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 0
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 16
134:             .Left      = 11
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .AutoSize  = .F.
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .BackStyle = 0
142:             .ForeColor = RGB(0, 0, 0)
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46

*-- Linhas 351 a 411:
351:         loc_oGrid.ReadOnly           = .T.
352:         loc_oGrid.Visible            = .T.
353: 
354:         *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - BINDEVENT exige PUBLIC)
355:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
358:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
361: 
362:         THIS.TornarControlesVisiveis(loc_oPagina)
363:     ENDPROC
364: 
365:     *--------------------------------------------------------------------------
366:     * ConfigurarPaginaDados - Configura Page2 (Dados)
367:     * Compensacao PageFrame.Top=-29: Top_original + 29
368:     * Legado: Grupo_Salva.Left=627, Top=6+29=35, Width=172, Height=85
369:     * Fase 5/8: Botoes Confirmar/Cancelar + 1a metade dos campos
370:     *--------------------------------------------------------------------------
371:     PROTECTED PROCEDURE ConfigurarPaginaDados()
372:         LOCAL loc_oPagina
373:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
374: 
375:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
376: 
377:         *-- Container botoes Salvar/Cancelar (Grupo_Salva.Left=627, Top=6+29=35)
378:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
379:         WITH loc_oPagina.cnt_4c_BotoesDados
380:             .Top         = 35
381:             .Left        = 627
382:             .Width       = 172
383:             .Height      = 85
384:             .BackStyle   = 0
385:             .BorderWidth = 0
386:             .Visible     = .T.
387:         ENDWITH
388: 
389:         *-- Botao Confirmar (Salva.Left=11, Top=5)
390:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 11
397:             .Width           = 75
398:             .Height          = 75
399:             .FontName        = "Comic Sans MS"
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .FontSize        = 8
403:             .ForeColor       = RGB(90, 90, 90)
404:             .BackColor       = RGB(255, 255, 255)
405:             .Themes          = .F.
406:             .SpecialEffect   = 0
407:             .MousePointer    = 15
408:             .WordWrap        = .T.
409:             .AutoSize        = .F.
410:             .Visible         = .T.
411:         ENDWITH

*-- Linhas 434 a 478:
434:             .Visible         = .T.
435:         ENDWITH
436: 
437:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
438:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
439: 
440:         *----------------------------------------------------------------------
441:         *  BANCO (Get_Banco: top=66+29=95, left=251, width=45)
442:         *----------------------------------------------------------------------
443:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
444:         WITH loc_oPagina.lbl_4c_Label2
445:             .Caption   = "Banco :"
446:             .Top       = 99
447:             .Left      = 204
448:             .Width     = 42
449:             .Height    = 15
450:             .AutoSize  = .T.
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .FontBold  = .T.
454:             .BackStyle = 0
455:             .ForeColor = RGB(90, 90, 90)
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         loc_oPagina.AddObject("txt_4c_Banco", "TextBox")
460:         WITH loc_oPagina.txt_4c_Banco
461:             .Value        = ""
462:             .Top          = 95
463:             .Left         = 251
464:             .Width        = 45
465:             .Height       = 23
466:             .FontName     = "Tahoma"
467:             .FontSize     = 8
468:             .MaxLength    = 10
469:             .BackColor    = RGB(255, 255, 255)
470:             .ForeColor    = RGB(90, 90, 90)
471:             .Visible      = .T.
472:         ENDWITH
473: 
474:         *----------------------------------------------------------------------
475:         *  CABECALHOS DAS COLUNAS (Label3 Linha / Label4 Coluna)
476:         *  top=116+29=145 / top=115+29=144
477:         *----------------------------------------------------------------------
478:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")

*-- Linhas 900 a 921:
900:             .BackStyle = 0
901:             .ForeColor = RGB(90, 90, 90)
902:             .Visible   = .T.
903:         ENDWITH
904: 
905:         loc_oPagina.AddObject("txt_4c_Fwget17", "TextBox")
906:         WITH loc_oPagina.txt_4c_Fwget17
907:             .Value     = ""
908:             .Top       = 366
909:             .Left      = 250
910:             .Width     = 160
911:             .Height    = 23
912:             .MaxLength = 20
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8
915:             .BackColor = RGB(255, 255, 255)
916:             .ForeColor = RGB(90, 90, 90)
917:             .Visible   = .T.
918:         ENDWITH
919: 
920:         *----------------------------------------------------------------------
921:         *  TAMANHO FOLHA (Label13: top=364+29=393; fwget18: top=362+29=391)

*-- Linhas 952 a 1034:
952:             .Visible   = .T.
953:         ENDWITH
954: 
955:         BINDEVENT(loc_oPagina.txt_4c_Fwget18, "KeyPress", THIS, "ValidarTamanhoFolha")
956: 
957:         *----------------------------------------------------------------------
958:         *  NOME IMPRESSORA (Label14: top=392+29=421; fwget19: top=387+29=416)
959:         *  Legado: fwget19.Valid -> GetPrinter() quando vazio (ValidarNomeImpressora)
960:         *----------------------------------------------------------------------
961:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
962:         WITH loc_oPagina.lbl_4c_Label14
963:             .Caption   = "Nome Impressora :"
964:             .Top       = 421
965:             .Left      = 153
966:             .Width     = 93
967:             .Height    = 15
968:             .AutoSize  = .T.
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8
971:             .FontBold  = .F.
972:             .BackStyle = 0
973:             .ForeColor = RGB(90, 90, 90)
974:             .Visible   = .T.
975:         ENDWITH
976: 
977:         loc_oPagina.AddObject("txt_4c_Fwget19", "TextBox")
978:         WITH loc_oPagina.txt_4c_Fwget19
979:             .Value     = ""
980:             .Top       = 416
981:             .Left      = 250
982:             .Width     = 319
983:             .Height    = 23
984:             .MaxLength = 40
985:             .FontName  = "Tahoma"
986:             .FontSize  = 8
987:             .BackColor = RGB(255, 255, 255)
988:             .ForeColor = RGB(90, 90, 90)
989:             .Visible   = .T.
990:         ENDWITH
991: 
992:         BINDEVENT(loc_oPagina.txt_4c_Fwget19, "KeyPress", THIS, "ValidarNomeImpressora")
993: 
994:         THIS.TornarControlesVisiveis(loc_oPagina)
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * CarregarLista - Carrega dados no Grid da Page1 via BO.Buscar()
999:     * Cursor cursor_4c_Dados: banco, local, ctamanho, cnomimpre
1000:     * REGRA Problema 48: RecordSource e ColumnCount FORA do WITH
1001:     * REGRA Problema 32: Redefinir Headers APOS RecordSource
1002:     *--------------------------------------------------------------------------
1003:     PROTECTED FUNCTION CarregarLista()
1004:         LOCAL loc_lResultado, loc_oGrid
1005:         loc_lResultado = .F.
1006: 
1007:         TRY
1008:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1009:                 loc_lResultado = .T.
1010:             ELSE
1011:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1012: 
1013:                 IF THIS.this_oBusinessObject.Buscar("")
1014:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
1015:                     loc_oGrid.ColumnCount = 3
1016:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1017:                     loc_oGrid.ColumnCount  = 4
1018: 
1019:                     WITH loc_oGrid
1020:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1021:                         .Column1.Width           = 80
1022:                         .Column1.Header1.Caption = "Banco"
1023:                         .Column1.ReadOnly        = .T.
1024: 
1025:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1026:                         .Column2.Width           = 160
1027:                         .Column2.Header1.Caption = "Local"
1028:                         .Column2.ReadOnly        = .T.
1029: 
1030:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1031:                         .Column3.Width           = 200
1032:                         .Column3.Header1.Caption = "Tamanho Folha"
1033:                         .Column3.ReadOnly        = .T.
1034: 

*-- Linhas 1077 a 1599:
1077:     *--------------------------------------------------------------------------
1078:     * FormatarGridLista - Formata visual do grid da lista
1079:     *--------------------------------------------------------------------------
1080:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1081:         WITH par_oGrid
1082:             .FontName = "Tahoma"
1083:             .FontSize = 8
1084:         ENDWITH
1085:     ENDPROC
1086: 
1087:     *--------------------------------------------------------------------------
1088:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1091:         LOCAL loc_nI, loc_oObjeto, loc_nP
1092: 
1093:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1094:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1095: 
1096:             IF VARTYPE(loc_oObjeto) = "O"
1097:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1098:                     loc_oObjeto.Visible = .T.
1099:                 ENDIF
1100: 
1101:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1102:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1103:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1104:                     ENDFOR
1105:                 ENDIF
1106: 
1107:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1108:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1109:                 ENDIF
1110:             ENDIF
1111:         ENDFOR
1112:     ENDPROC
1113: 
1114:     *==========================================================================
1115:     *  HANDLERS DE BOTOES - PUBLIC (BINDEVENT exige PUBLIC, sem PROTECTED)
1116:     *==========================================================================
1117: 
1118:     *--------------------------------------------------------------------------
1119:     * BtnIncluirClick - Abre Page2 para novo registro
1120:     * Legado: DoDefault('INSERIR') -> navega para dados + foco em Get_Banco
1121:     *--------------------------------------------------------------------------
1122:     PROCEDURE BtnIncluirClick()
1123:         THIS.this_oBusinessObject.NovoRegistro()
1124:         THIS.LimparCampos()
1125:         THIS.this_cModoAtual = "INCLUIR"
1126:         THIS.HabilitarCampos(.T.)
1127:         THIS.AjustarBotoesPorModo()
1128:         THIS.AlternarPagina(2)
1129: 
1130:         TRY
1131:             THIS.pgf_4c_Paginas.Page2.txt_4c_Banco.SetFocus
1132:         CATCH TO loException
1133:             MsgErro("Erro ao focar campo Banco: " + loException.Message, "Erro")
1134:         ENDTRY
1135:     ENDPROC
1136: 
1137:     *--------------------------------------------------------------------------
1138:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
1139:     * Legado: DoDefault('CONSULTAR') -> navega + foco em Salva
1140:     *--------------------------------------------------------------------------
1141:     PROCEDURE BtnVisualizarClick()
1142:         LOCAL loc_cBanco
1143: 
1144:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1145:             MsgAviso("Selecione um registro na lista.", "Aten" + CHR(231) + CHR(227) + "o")
1146:             RETURN
1147:         ENDIF
1148: 
1149:         SELECT cursor_4c_Dados
1150:         loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)
1151: 
1152:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
1153:             THIS.this_cModoAtual = "VISUALIZAR"
1154:             THIS.BOParaForm()
1155:             THIS.HabilitarCampos(.F.)
1156:             THIS.AjustarBotoesPorModo()
1157:             THIS.AlternarPagina(2)
1158: 
1159:             TRY
1160:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Cancelar.SetFocus
1161:             CATCH TO loException
1162:                 MsgErro("Erro ao focar Cancelar: " + loException.Message, "Erro")
1163:             ENDTRY
1164:         ELSE
1165:             MsgAviso("Erro ao carregar o registro selecionado.", "Erro")
1166:         ENDIF
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * BtnAlterarClick - Carrega registro selecionado para edicao
1171:     * Legado: DoDefault('ALTERAR') -> navega + foco em Get_Banco (quando habilitado)
1172:     *--------------------------------------------------------------------------
1173:     PROCEDURE BtnAlterarClick()
1174:         LOCAL loc_cBanco
1175: 
1176:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1177:             MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1178:             RETURN
1179:         ENDIF
1180: 
1181:         SELECT cursor_4c_Dados
1182:         loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)
1183: 
1184:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
1185:             THIS.this_oBusinessObject.EditarRegistro()
1186:             THIS.this_cModoAtual = "ALTERAR"
1187:             THIS.BOParaForm()
1188:             THIS.HabilitarCampos(.T.)
1189:             THIS.AjustarBotoesPorModo()
1190:             THIS.AlternarPagina(2)
1191: 
1192:             TRY
1193:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Fwget17.SetFocus
1194:             CATCH TO loException
1195:                 MsgErro("Erro ao focar campo Local: " + loException.Message, "Erro")
1196:             ENDTRY
1197:         ELSE
1198:             MsgAviso("Erro ao carregar o registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1199:         ENDIF
1200:     ENDPROC
1201: 
1202:     *--------------------------------------------------------------------------
1203:     * BtnExcluirClick - Confirma e exclui o registro selecionado
1204:     *--------------------------------------------------------------------------
1205:     PROCEDURE BtnExcluirClick()
1206:         LOCAL loc_cBanco
1207: 
1208:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1209:             MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
1210:             RETURN
1211:         ENDIF
1212: 
1213:         SELECT cursor_4c_Dados
1214:         loc_cBanco = ALLTRIM(cursor_4c_Dados.banco)
1215: 
1216:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do banco [" + loc_cBanco + "]?", ;
1217:                         "Confirmar Exclus" + CHR(227) + "o")
1218:             RETURN
1219:         ENDIF
1220: 
1221:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cBanco)
1222:             IF THIS.this_oBusinessObject.Excluir()
1223:                 MsgInfo("Banco exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1224:                 THIS.CarregarLista()
1225:             ENDIF
1226:         ELSE
1227:             MsgAviso("Erro ao carregar o registro para exclus" + CHR(227) + "o.", "Erro")
1228:         ENDIF
1229:     ENDPROC
1230: 
1231:     *--------------------------------------------------------------------------
1232:     * BtnBuscarClick - Abre FormBuscaAuxiliar para filtrar a lista
1233:     *--------------------------------------------------------------------------
1234:     PROCEDURE BtnBuscarClick()
1235:         LOCAL loc_oBusca, loc_cBanco, loc_oGrid
1236: 
1237:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1238:             "SigCqMat", "cursor_4c_Busca", "banco", "", ;
1239:             "Busca de Configura" + CHR(231) + CHR(227) + "o de Cheque")
1240: 
1241:         IF VARTYPE(loc_oBusca) = "O"
1242:             loc_oBusca.mAddColuna("banco",      "", "Banco")
1243:             loc_oBusca.mAddColuna("local",      "", "Local")
1244:             loc_oBusca.mAddColuna("ctamanho",   "", "Tamanho Folha")
1245:             loc_oBusca.mAddColuna("cnomimpre",  "", "Nome Impressora")
1246:             loc_oBusca.Show()
1247: 
1248:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_Busca")
1249:                 loc_cBanco = ALLTRIM(cursor_4c_Busca.banco)
1250: 
1251:                 IF THIS.this_oBusinessObject.Buscar(loc_cBanco)
1252:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1253:                     loc_oGrid.ColumnCount = 3
1254:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1255:                     WITH loc_oGrid
1256:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1257:                         .Column1.Header1.Caption = "Banco"
1258:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1259:                         .Column2.Header1.Caption = "Local"
1260:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1261:                         .Column3.Header1.Caption = "Tamanho Folha"
1262:                         .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
1263:                         .Column4.Header1.Caption = "Nome Impressora"
1264:                     ENDWITH
1265:                 ENDIF
1266:             ENDIF
1267: 
1268:             loc_oBusca.Release()
1269:         ENDIF
1270: 
1271:         IF USED("cursor_4c_Busca")
1272:             USE IN cursor_4c_Busca
1273:         ENDIF
1274:     ENDPROC
1275: 
1276:     *--------------------------------------------------------------------------
1277:     * BtnEncerrarClick - Fecha o formulario
1278:     *--------------------------------------------------------------------------
1279:     PROCEDURE BtnEncerrarClick()
1280:         THIS.Release()
1281:     ENDPROC
1282: 
1283:     *--------------------------------------------------------------------------
1284:     * BtnSalvarClick - Valida e salva o registro (Page2)
1285:     * Legado: validacoes de banco duplicado + local obrigatorio antes de salvar
1286:     *--------------------------------------------------------------------------
1287:     PROCEDURE BtnSalvarClick()
1288:         LOCAL loc_cBanco, loc_cLocal, loc_oPagina
1289: 
1290:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1291: 
1292:         *-- Validacoes FORA do TRY (Problema 16)
1293:         TRY
1294:             loc_cBanco = ALLTRIM(loc_oPagina.txt_4c_Banco.Value)
1295:             loc_cLocal = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
1296:         CATCH TO loException
1297:             MsgErro("Erro ao ler campos do formul" + CHR(225) + "rio: " + loException.Message, "Erro")
1298:             RETURN
1299:         ENDTRY
1300: 
1301:         IF EMPTY(loc_cBanco)
1302:             MsgAviso("Preencher o Banco.", "Aten" + CHR(231) + CHR(227) + "o")
1303: 
1304:             TRY
1305:                 loc_oPagina.txt_4c_Banco.SetFocus
1306:             CATCH
1307:             ENDTRY
1308: 
1309:             RETURN
1310:         ENDIF
1311: 
1312:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1313:             IF EMPTY(loc_cLocal)
1314:                 MsgAviso("Preencher o Local.", "Aten" + CHR(231) + CHR(227) + "o")
1315: 
1316:                 TRY
1317:                     loc_oPagina.txt_4c_Fwget17.SetFocus
1318:                 CATCH
1319:                 ENDTRY
1320: 
1321:                 RETURN
1322:             ENDIF
1323:         ENDIF
1324: 
1325:         THIS.FormParaBO()
1326: 
1327:         IF THIS.this_oBusinessObject.Salvar()
1328:             MsgInfo("Registro salvo com sucesso!", "Sucesso")
1329:             THIS.this_cModoAtual = "LISTA"
1330:             THIS.AlternarPagina(1)
1331:         ENDIF
1332:     ENDPROC
1333: 
1334:     *--------------------------------------------------------------------------
1335:     * BtnCancelarClick - Cancela e retorna para a lista (Page2 -> Page1)
1336:     *--------------------------------------------------------------------------
1337:     PROCEDURE BtnCancelarClick()
1338:         THIS.this_cModoAtual = "LISTA"
1339:         THIS.AlternarPagina(1)
1340:         THIS.CarregarLista()
1341:     ENDPROC
1342: 
1343:     *==========================================================================
1344:     *  DATA BINDING - Transferencia Form <-> BO
1345:     *==========================================================================
1346: 
1347:     *--------------------------------------------------------------------------
1348:     * FormParaBO - Transfere valores dos campos do form para o BO
1349:     * Mapeamento: fwget1=lvlr(L), fwget2=cvlr(C), fwget3=lvext1, fwget4=cvext1
1350:     *             fwget5=lvext2, fwget6=cvext2, fwget7=lfavo, fwget8=cfavo
1351:     *             fwget9=llocal, fwget10=clocal, fwget11=ldia, fwget12=cdia
1352:     *             fwget13=lmes, fwget14=cmes, fwget15=lano, fwget16=cano
1353:     *             fwget17=local, fwget18=ctamanho, fwget19=cnomimpre
1354:     *--------------------------------------------------------------------------
1355:     PROTECTED PROCEDURE FormParaBO()
1356:         LOCAL loc_oPagina, loc_oBO
1357:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1358:         loc_oBO     = THIS.this_oBusinessObject
1359: 
1360:         TRY
1361:             loc_oBO.this_cBanco    = ALLTRIM(loc_oPagina.txt_4c_Banco.Value)
1362:             loc_oBO.this_nLvlr     = TRANSFORM(loc_oPagina.txt_4c_Fwget1.Value)
1363:             loc_oBO.this_nCvlr     = TRANSFORM(loc_oPagina.txt_4c_Fwget2.Value)
1364:             loc_oBO.this_nLvext1   = TRANSFORM(loc_oPagina.txt_4c_Fwget3.Value)
1365:             loc_oBO.this_nCvext1   = TRANSFORM(loc_oPagina.txt_4c_Fwget4.Value)
1366:             loc_oBO.this_nLvext2   = TRANSFORM(loc_oPagina.txt_4c_Fwget5.Value)
1367:             loc_oBO.this_nCvext2   = TRANSFORM(loc_oPagina.txt_4c_Fwget6.Value)
1368:             loc_oBO.this_nLfavo    = TRANSFORM(loc_oPagina.txt_4c_Fwget7.Value)
1369:             loc_oBO.this_nCfavo    = TRANSFORM(loc_oPagina.txt_4c_Fwget8.Value)
1370:             loc_oBO.this_nLlocal   = TRANSFORM(loc_oPagina.txt_4c_Fwget9.Value)
1371:             loc_oBO.this_nClocal   = TRANSFORM(loc_oPagina.txt_4c_Fwget10.Value)
1372:             loc_oBO.this_nLdia     = TRANSFORM(loc_oPagina.txt_4c_Fwget11.Value)
1373:             loc_oBO.this_nCdia     = TRANSFORM(loc_oPagina.txt_4c_Fwget12.Value)
1374:             loc_oBO.this_nLmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget13.Value)
1375:             loc_oBO.this_nCmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget14.Value)
1376:             loc_oBO.this_nLano     = TRANSFORM(loc_oPagina.txt_4c_Fwget15.Value)
1377:             loc_oBO.this_nCano     = TRANSFORM(loc_oPagina.txt_4c_Fwget16.Value)
1378:             loc_oBO.this_cLocal    = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
1379:             loc_oBO.this_cTamanho  = ALLTRIM(loc_oPagina.txt_4c_Fwget18.Value)
1380:             loc_oBO.this_cNomImpre = ALLTRIM(loc_oPagina.txt_4c_Fwget19.Value)
1381:         CATCH TO loException
1382:             MsgErro("Erro em FormParaBO:" + CHR(13) + ;
1383:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1384:                     loException.Message, "Erro")
1385:         ENDTRY
1386:     ENDPROC
1387: 
1388:     *--------------------------------------------------------------------------
1389:     * BOParaForm - Transfere valores do BO para os campos do form
1390:     *--------------------------------------------------------------------------
1391:     PROTECTED PROCEDURE BOParaForm()
1392:         LOCAL loc_oPagina, loc_oBO
1393:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1394:         loc_oBO     = THIS.this_oBusinessObject
1395: 
1396:         TRY
1397:             loc_oPagina.txt_4c_Banco.Value    = loc_oBO.this_cBanco
1398:             loc_oPagina.txt_4c_Fwget1.Value   = loc_oBO.this_nLvlr
1399:             loc_oPagina.txt_4c_Fwget2.Value   = loc_oBO.this_nCvlr
1400:             loc_oPagina.txt_4c_Fwget3.Value   = loc_oBO.this_nLvext1
1401:             loc_oPagina.txt_4c_Fwget4.Value   = loc_oBO.this_nCvext1
1402:             loc_oPagina.txt_4c_Fwget5.Value   = loc_oBO.this_nLvext2
1403:             loc_oPagina.txt_4c_Fwget6.Value   = loc_oBO.this_nCvext2
1404:             loc_oPagina.txt_4c_Fwget7.Value   = loc_oBO.this_nLfavo
1405:             loc_oPagina.txt_4c_Fwget8.Value   = loc_oBO.this_nCfavo
1406:             loc_oPagina.txt_4c_Fwget9.Value   = loc_oBO.this_nLlocal
1407:             loc_oPagina.txt_4c_Fwget10.Value  = loc_oBO.this_nClocal
1408:             loc_oPagina.txt_4c_Fwget11.Value  = loc_oBO.this_nLdia
1409:             loc_oPagina.txt_4c_Fwget12.Value  = loc_oBO.this_nCdia
1410:             loc_oPagina.txt_4c_Fwget13.Value  = loc_oBO.this_nLmes
1411:             loc_oPagina.txt_4c_Fwget14.Value  = loc_oBO.this_nCmes
1412:             loc_oPagina.txt_4c_Fwget15.Value  = loc_oBO.this_nLano
1413:             loc_oPagina.txt_4c_Fwget16.Value  = loc_oBO.this_nCano
1414:             loc_oPagina.txt_4c_Fwget17.Value  = loc_oBO.this_cLocal
1415:             loc_oPagina.txt_4c_Fwget18.Value  = loc_oBO.this_cTamanho
1416:             loc_oPagina.txt_4c_Fwget19.Value  = loc_oBO.this_cNomImpre
1417:         CATCH TO loException
1418:             MsgErro("Erro em BOParaForm:" + CHR(13) + ;
1419:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1420:                     loException.Message, "Erro")
1421:         ENDTRY
1422:     ENDPROC
1423: 
1424:     *--------------------------------------------------------------------------
1425:     * LimparCampos - Limpa todos os campos da Page2
1426:     *--------------------------------------------------------------------------
1427:     PROTECTED PROCEDURE LimparCampos()
1428:         LOCAL loc_oPagina
1429:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1430: 
1431:         TRY
1432:             loc_oPagina.txt_4c_Banco.Value    = ""
1433:             loc_oPagina.txt_4c_Fwget1.Value   = 0
1434:             loc_oPagina.txt_4c_Fwget2.Value   = 0
1435:             loc_oPagina.txt_4c_Fwget3.Value   = 0
1436:             loc_oPagina.txt_4c_Fwget4.Value   = 0
1437:             loc_oPagina.txt_4c_Fwget5.Value   = 0
1438:             loc_oPagina.txt_4c_Fwget6.Value   = 0
1439:             loc_oPagina.txt_4c_Fwget7.Value   = 0
1440:             loc_oPagina.txt_4c_Fwget8.Value   = 0
1441:             loc_oPagina.txt_4c_Fwget9.Value   = 0
1442:             loc_oPagina.txt_4c_Fwget10.Value  = 0
1443:             loc_oPagina.txt_4c_Fwget11.Value  = 0
1444:             loc_oPagina.txt_4c_Fwget12.Value  = 0
1445:             loc_oPagina.txt_4c_Fwget13.Value  = 0
1446:             loc_oPagina.txt_4c_Fwget14.Value  = 0
1447:             loc_oPagina.txt_4c_Fwget15.Value  = 0
1448:             loc_oPagina.txt_4c_Fwget16.Value  = 0
1449:             loc_oPagina.txt_4c_Fwget17.Value  = ""
1450:             loc_oPagina.txt_4c_Fwget18.Value  = ""
1451:             loc_oPagina.txt_4c_Fwget19.Value  = ""
1452:         CATCH TO loException
1453:             MsgErro("Erro em LimparCampos: " + loException.Message, "Erro")
1454:         ENDTRY
1455:     ENDPROC
1456: 
1457:     *--------------------------------------------------------------------------
1458:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1459:     * Legado: Get_Banco.When retorna .F. nos modos ALTERAR/EXCLUIR/CONSULTAR
1460:     *--------------------------------------------------------------------------
1461:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1462:         LOCAL loc_oPagina
1463:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1464: 
1465:         TRY
1466:             *-- Banco editavel SOMENTE no modo INCLUIR (regra do legado: Get_Banco.When)
1467:             loc_oPagina.txt_4c_Banco.ReadOnly  = !INLIST(THIS.this_cModoAtual, "INCLUIR")
1468:             loc_oPagina.txt_4c_Banco.Enabled   =  INLIST(THIS.this_cModoAtual, "INCLUIR")
1469: 
1470:             *-- Demais campos seguem par_lHabilitar
1471:             loc_oPagina.txt_4c_Fwget1.ReadOnly   = !par_lHabilitar
1472:             loc_oPagina.txt_4c_Fwget2.ReadOnly   = !par_lHabilitar
1473:             loc_oPagina.txt_4c_Fwget3.ReadOnly   = !par_lHabilitar
1474:             loc_oPagina.txt_4c_Fwget4.ReadOnly   = !par_lHabilitar
1475:             loc_oPagina.txt_4c_Fwget5.ReadOnly   = !par_lHabilitar
1476:             loc_oPagina.txt_4c_Fwget6.ReadOnly   = !par_lHabilitar
1477:             loc_oPagina.txt_4c_Fwget7.ReadOnly   = !par_lHabilitar
1478:             loc_oPagina.txt_4c_Fwget8.ReadOnly   = !par_lHabilitar
1479:             loc_oPagina.txt_4c_Fwget9.ReadOnly   = !par_lHabilitar
1480:             loc_oPagina.txt_4c_Fwget10.ReadOnly  = !par_lHabilitar
1481:             loc_oPagina.txt_4c_Fwget11.ReadOnly  = !par_lHabilitar
1482:             loc_oPagina.txt_4c_Fwget12.ReadOnly  = !par_lHabilitar
1483:             loc_oPagina.txt_4c_Fwget13.ReadOnly  = !par_lHabilitar
1484:             loc_oPagina.txt_4c_Fwget14.ReadOnly  = !par_lHabilitar
1485:             loc_oPagina.txt_4c_Fwget15.ReadOnly  = !par_lHabilitar
1486:             loc_oPagina.txt_4c_Fwget16.ReadOnly  = !par_lHabilitar
1487:             loc_oPagina.txt_4c_Fwget17.ReadOnly  = !par_lHabilitar
1488:             loc_oPagina.txt_4c_Fwget18.ReadOnly  = !par_lHabilitar
1489:             loc_oPagina.txt_4c_Fwget19.ReadOnly  = !par_lHabilitar
1490:         CATCH TO loException
1491:             MsgErro("Erro em HabilitarCampos: " + loException.Message, "Erro")
1492:         ENDTRY
1493:     ENDPROC
1494: 
1495:     *--------------------------------------------------------------------------
1496:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes Confirmar/Cancelar
1497:     *--------------------------------------------------------------------------
1498:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1499:         LOCAL loc_oPg2Botoes
1500: 
1501:         TRY
1502:             loc_oPg2Botoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
1503: 
1504:             DO CASE
1505:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1506:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1507:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .T.
1508:                 ENDIF
1509:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1510:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1511:                 ENDIF
1512:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1513:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1514:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .F.
1515:                 ENDIF
1516:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1517:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1518:                 ENDIF
1519:             ENDCASE
1520:         CATCH TO loException
1521:             MsgErro("Erro em AjustarBotoesPorModo: " + loException.Message, "Erro")
1522:         ENDTRY
1523:     ENDPROC
1524: 
1525:     *--------------------------------------------------------------------------
1526:     * ValidarTamanhoFolha - Obtem tamanho da folha via dialogo se campo vazio
1527:     * Legado: fwget18.Valid - GetPaperSize() quando valor em branco
1528:     * Chamado via BINDEVENT LostFocus de txt_4c_Fwget18 (configurado na Fase 5)
1529:     *--------------------------------------------------------------------------
1530:     PROCEDURE ValidarTamanhoFolha()
1531:         LOCAL loc_cTamanho, loc_oPagina
1532:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1533: 
1534:         TRY
1535:             loc_cTamanho = ALLTRIM(loc_oPagina.txt_4c_Fwget18.Value)
1536: 
1537:             IF EMPTY(loc_cTamanho)
1538:                 loc_cTamanho = GETPAPERSIZE()
1539: 
1540:                 IF EMPTY(loc_cTamanho)
1541:                     loc_cTamanho = STR(256, 10) + "Personalizado"
1542:                 ENDIF
1543: 
1544:                 loc_oPagina.txt_4c_Fwget18.Value = ALLTRIM(SUBSTR(loc_cTamanho, 11))
1545:             ENDIF
1546:         CATCH TO loException
1547:             MsgErro("Erro em ValidarTamanhoFolha: " + loException.Message, "Erro")
1548:         ENDTRY
1549:     ENDPROC
1550: 
1551:     *--------------------------------------------------------------------------
1552:     * ValidarNomeImpressora - Obtem impressora padrao via dialogo se campo vazio
1553:     * Legado: fwget19.Valid - GetPrinter() quando valor em branco
1554:     * Chamado via BINDEVENT LostFocus de txt_4c_Fwget19 (configurado na Fase 5)
1555:     *--------------------------------------------------------------------------
1556:     PROCEDURE ValidarNomeImpressora()
1557:         LOCAL loc_cImpre, loc_oPagina
1558:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1559: 
1560:         TRY
1561:             loc_cImpre = ALLTRIM(loc_oPagina.txt_4c_Fwget19.Value)
1562: 
1563:             IF EMPTY(loc_cImpre)
1564:                 loc_cImpre = GETPRINTER()
1565: 
1566:                 IF !EMPTY(loc_cImpre)
1567:                     loc_oPagina.txt_4c_Fwget19.Value = loc_cImpre
1568:                 ENDIF
1569:             ENDIF
1570:         CATCH TO loException
1571:             MsgErro("Erro em ValidarNomeImpressora: " + loException.Message, "Erro")
1572:         ENDTRY
1573:     ENDPROC
1574: 
1575:     *--------------------------------------------------------------------------
1576:     * Destroy - Libera recursos ao fechar o formulario
1577:     *--------------------------------------------------------------------------
1578:     PROCEDURE Destroy()
1579:         TRY
1580:             IF USED("cursor_4c_Dados")
1581:                 USE IN cursor_4c_Dados
1582:             ENDIF
1583:             IF USED("cursor_4c_Carrega")
1584:                 USE IN cursor_4c_Carrega
1585:             ENDIF
1586:             IF USED("cursor_4c_Busca")
1587:                 USE IN cursor_4c_Busca
1588:             ENDIF
1589:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1590:                 THIS.this_oBusinessObject = .NULL.
1591:             ENDIF
1592:         CATCH TO loException
1593:             MsgErro("Erro ao destruir FormCHM: " + loException.Message, "Erro")
1594:         ENDTRY
1595: 
1596:         DODEFAULT()
1597:     ENDPROC
1598: 
1599: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CHMBO.prg):
*==============================================================================
* CHMBO.prg - Business Object: Configura??o do Cheque Matricial
* Tabela: SigCqMat
* PK: banco (C3)
* Gerado: 2026-07-28 - Fase 1/8
*==============================================================================
DEFINE CLASS CHMBO AS BusinessBase

    *-- Chave prim?ria
    this_cBanco     = ""   && banco C(3)

    *-- Posi??es de impress?o - Valor
    this_nLvlr      = 0    && lvlr  N - Linha  Valor
    this_nCvlr      = 0    && cvlr  N - Coluna Valor

    *-- Posi??es de impress?o - Valor Extenso 1
    this_nLvext1    = 0    && lvext1 N - Linha  Valor Extenso 1
    this_nCvext1    = 0    && cvext1 N - Coluna Valor Extenso 1

    *-- Posi??es de impress?o - Valor Extenso 2
    this_nLvext2    = 0    && lvext2 N - Linha  Valor Extenso 2
    this_nCvext2    = 0    && cvext2 N - Coluna Valor Extenso 2

    *-- Posi??es de impress?o - Favorecido
    this_nLfavo     = 0    && lfavo N - Linha  Favorecido
    this_nCfavo     = 0    && cfavo N - Coluna Favorecido

    *-- Posi??es de impress?o - Localidade
    this_nLlocal    = 0    && llocal N - Linha  Localidade
    this_nClocal    = 0    && clocal N - Coluna Localidade

    *-- Posi??es de impress?o - Dia
    this_nLdia      = 0    && ldia N - Linha  Dia
    this_nCdia      = 0    && cdia N - Coluna Dia

    *-- Posi??es de impress?o - M?s
    this_nLmes      = 0    && lmes N - Linha  M?s
    this_nCmes      = 0    && cmes N - Coluna M?s

    *-- Posi??es de impress?o - Ano
    this_nLano      = 0    && lano N - Linha  Ano
    this_nCano      = 0    && cano N - Coluna Ano

    *-- Campos de configura??o da impressora
    this_cLocal     = ""   && local      C(20) - Local de emiss?o
    this_cTamanho   = ""   && ctamanho   C(50) - Tamanho da folha
    this_cNomImpre  = ""   && cNomImpre  C(40) - Nome da impressora

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SigCqMat"
        THIS.this_cCampoChave  = "banco"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cBanco
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " WHERE banco LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY banco"
            ELSE
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " ORDER BY banco"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cBanco)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT banco, lvlr, cvlr, lvext1, cvext1," + ;
                       " lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                       " ldia, cdia, lmes, cmes, lano, cano," + ;
                       " [local], ctamanho, cnomimpre" + ;
                       " FROM SigCqMat" + ;
                       " WHERE banco = " + EscaparSQL(par_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBanco    = TratarNulo(banco,    "C")
            THIS.this_nLvlr     = TratarNulo(lvlr,     "N")
            THIS.this_nCvlr     = TratarNulo(cvlr,     "N")
            THIS.this_nLvext1   = TratarNulo(lvext1,   "N")
            THIS.this_nCvext1   = TratarNulo(cvext1,   "N")
            THIS.this_nLvext2   = TratarNulo(lvext2,   "N")
            THIS.this_nCvext2   = TratarNulo(cvext2,   "N")
            THIS.this_nLfavo    = TratarNulo(lfavo,    "N")
            THIS.this_nCfavo    = TratarNulo(cfavo,    "N")
            THIS.this_nLlocal   = TratarNulo(llocal,   "N")
            THIS.this_nClocal   = TratarNulo(clocal,   "N")
            THIS.this_nLdia     = TratarNulo(ldia,     "N")
            THIS.this_nCdia     = TratarNulo(cdia,     "N")
            THIS.this_nLmes     = TratarNulo(lmes,     "N")
            THIS.this_nCmes     = TratarNulo(cmes,     "N")
            THIS.this_nLano     = TratarNulo(lano,     "N")
            THIS.this_nCano     = TratarNulo(cano,     "N")
            THIS.this_cLocal    = TratarNulo(EVALUATE(par_cAliasCursor + ".local"), "C")
            THIS.this_cTamanho  = TratarNulo(ctamanho, "C")
            THIS.this_cNomImpre = TratarNulo(cnomimpre,"C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_cChkSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChkSQL = "SELECT COUNT(*) AS total FROM SigCqMat" + ;
                          " WHERE banco = " + EscaparSQL(THIS.this_cBanco)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkDup")

            IF cursor_4c_ChkDup.total > 0
                MsgAviso("Existe esse Banco J" + CHR(225) + " Cadastrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_ChkDup
            ELSE
                USE IN cursor_4c_ChkDup
                loc_cSQL = "INSERT INTO SigCqMat" + ;
                           " (banco, lvlr, cvlr, lvext1, cvext1," + ;
                           "  lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                           "  ldia, cdia, lmes, cmes, lano, cano," + ;
                           "  [local], ctamanho, cnomimpre)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cBanco) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLlocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nClocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLano) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCano) + ", " + ;
                           EscaparSQL(THIS.this_cLocal) + ", " + ;
                           EscaparSQL(THIS.this_cTamanho) + ", " + ;
                           EscaparSQL(THIS.this_cNomImpre) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Insert")
                    TABLEREVERT(.T., "cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

                IF loc_nResultado > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqMat SET" + ;
                       " lvlr = "    + FormatarNumeroSQL(THIS.this_nLvlr)   + "," + ;
                       " cvlr = "    + FormatarNumeroSQL(THIS.this_nCvlr)   + "," + ;
                       " lvext1 = "  + FormatarNumeroSQL(THIS.this_nLvext1) + "," + ;
                       " cvext1 = "  + FormatarNumeroSQL(THIS.this_nCvext1) + "," + ;
                       " lvext2 = "  + FormatarNumeroSQL(THIS.this_nLvext2) + "," + ;
                       " cvext2 = "  + FormatarNumeroSQL(THIS.this_nCvext2) + "," + ;
                       " lfavo = "   + FormatarNumeroSQL(THIS.this_nLfavo)  + "," + ;
                       " cfavo = "   + FormatarNumeroSQL(THIS.this_nCfavo)  + "," + ;
                       " llocal = "  + FormatarNumeroSQL(THIS.this_nLlocal) + "," + ;
                       " clocal = "  + FormatarNumeroSQL(THIS.this_nClocal) + "," + ;
                       " ldia = "    + FormatarNumeroSQL(THIS.this_nLdia)   + "," + ;
                       " cdia = "    + FormatarNumeroSQL(THIS.this_nCdia)   + "," + ;
                       " lmes = "    + FormatarNumeroSQL(THIS.this_nLmes)   + "," + ;
                       " cmes = "    + FormatarNumeroSQL(THIS.this_nCmes)   + "," + ;
                       " lano = "    + FormatarNumeroSQL(THIS.this_nLano)   + "," + ;
                       " cano = "    + FormatarNumeroSQL(THIS.this_nCano)   + "," + ;
                       " [local] = " + EscaparSQL(THIS.this_cLocal)         + "," + ;
                       " ctamanho = "+ EscaparSQL(THIS.this_cTamanho)       + "," + ;
                       " cnomimpre ="+ EscaparSQL(THIS.this_cNomImpre) + ;
                       " WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCqMat WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

