# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIBP.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1427 linhas total):

*-- Linhas 25 a 151:
25: 
26:     *===========================================================================
27:     * Init - REGRA CRITICA: apenas RETURN DODEFAULT()
28:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar!
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
43:             THIS.this_oBusinessObject = CREATEOBJECT("IBPBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar IBPBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormIBP.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51: 
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 THIS.pgf_4c_Paginas.Visible   = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual           = "LISTA"
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF
62: 
63:                 loc_lSucesso = .T.
64:             ENDIF
65: 
66:         CATCH TO loException
67:             MostrarErro("Erro ao inicializar FormIBP:" + CHR(13) + ;
68:                 loException.Message + CHR(13) + ;
69:                 "Linha: " + TRANSFORM(loException.LineNo), ;
70:                 "FormIBP.InicializarForm")
71:         ENDTRY
72: 
73:         RETURN loc_lSucesso
74:     ENDPROC
75: 
76:     *===========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
78:     * Top=-29 para esconder abas; controles compensam +29 no Top
79:     * Background: new_background.jpg (original: ..\framework\imagens\new_background.jpg)
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
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 com Grid e botoes
108:     * IBPT: cnt_4c_Botoes fica OCULTO/DESABILITADO (Grupo_op.Visible=.F. original)
109:     * cmd_4c_BtnCarregar eh o botao principal (btncarregar do legado)
110:     *===========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina, loc_oGrid
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container Cabecalho (cntSombra no legado)
119:         *-- Original: cntSombra.Top=1. Com compensacao +29: Top=31
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129: 
130:             .AddObject("lbl_4c_Sombra", "Label")
131:             WITH .lbl_4c_Sombra
132:                 .Caption   = THIS.Caption
133:                 .Top       = 15
134:                 .Left      = 10
135:                 .Width     = THIS.Width
136:                 .Height    = 40
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .AutoSize  = .F.
143:                 .Visible   = .T.
144:             ENDWITH
145: 
146:             .AddObject("lbl_4c_Titulo", "Label")
147:             WITH .lbl_4c_Titulo
148:                 .Caption   = THIS.Caption
149:                 .Top       = 18
150:                 .Left      = 10
151:                 .Width     = THIS.Width

*-- Linhas 388 a 447:
388:             .Column9.Alignment = 2
389:         ENDWITH
390: 
391:         *-- BINDEVENT para botoes (Problema 17: handlers devem ser PUBLIC)
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,          "Click", THIS, "BtnEncerrarClick")
393:         BINDEVENT(loc_oPagina.cmd_4c_BtnCarregar,                    "Click", THIS, "BtnCarregarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,          "Click", THIS, "BtnIncluirClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,          "Click", THIS, "BtnAlterarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,       "Click", THIS, "BtnVisualizarClick")
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,          "Click", THIS, "BtnExcluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,           "Click", THIS, "BtnBuscarClick")
399: 
400:         THIS.TornarControlesVisiveis(loc_oPagina)
401:     ENDPROC
402: 
403:     *===========================================================================
404:     * ConfigurarPaginaDados - Configura Page2 com containers de edicao
405:     * Campos de dados adicionados nas Fases 5-6
406:     *===========================================================================
407:     PROTECTED PROCEDURE ConfigurarPaginaDados()
408:         LOCAL loc_oPagina
409:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
410: 
411:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
412:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
413: 
414:         *-- Container Salva/Cancelar (Grupo_Salva no legado)
415:         *-- Original: Left=819, Top=9. Com compensacao +29: Top=38
416:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
417:         WITH loc_oPagina.cnt_4c_Salva
418:             .Top         = 38
419:             .Left        = 842
420:             .Width       = 160
421:             .Height      = 85
422:             .BackStyle   = 0
423:             .Visible     = .T.
424: 
425:             .AddObject("cmd_4c_Confirmar", "CommandButton")
426:             WITH .cmd_4c_Confirmar
427:                 .Caption         = "Confirmar"
428:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
429:                 .PicturePosition = 13
430:                 .Top             = 5
431:                 .Left            = 5
432:                 .Width           = 75
433:                 .Height          = 75
434:                 .BackColor       = RGB(255,255,255)
435:                 .ForeColor       = RGB(90,90,90)
436:                 .FontName        = "Tahoma"
437:                 .FontSize        = 8
438:                 .FontBold        = .T.
439:                 .FontItalic      = .T.
440:             ENDWITH
441: 
442:             .AddObject("cmd_4c_Cancelar", "CommandButton")
443:             WITH .cmd_4c_Cancelar
444:                 .Caption         = "Encerrar"
445:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
446:                 .PicturePosition = 13
447:                 .Top             = 5

*-- Linhas 901 a 954:
901:             .Visible   = .T.
902:         ENDWITH
903: 
904:         *-- BINDEVENT para botoes de Page2
905:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
906:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
907: 
908:         THIS.TornarControlesVisiveis(loc_oPagina)
909:     ENDPROC
910: 
911:     *===========================================================================
912:     * CarregarLista - Carrega cursor_4c_Dados e vincula ao grid
913:     *===========================================================================
914:     PROCEDURE CarregarLista()
915:         LOCAL loc_lResultado, loc_oGrid
916:         loc_lResultado = .F.
917: 
918:         TRY
919:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
920:                 loc_lResultado = .T.
921:             ELSE
922:                 IF THIS.this_oBusinessObject.Buscar("")
923:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
924: 
925:                     *-- Problema 36: RecordSource e ColumnCount FORA do WITH
926:                     loc_oGrid.ColumnCount = 3
927:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
928:                     loc_oGrid.ColumnCount  = 9
929: 
930:                     *-- Problema 48: ControlSource e Headers APOS RecordSource
931:                     WITH loc_oGrid
932:                         .Column1.ControlSource = "cursor_4c_Dados.ufs"
933:                         .Column2.ControlSource = "cursor_4c_Dados.codigo"
934:                         .Column3.ControlSource = "cursor_4c_Dados.datini"
935:                         .Column4.ControlSource = "cursor_4c_Dados.datfin"
936:                         .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
937:                         .Column6.ControlSource = "cursor_4c_Dados.impfederal"
938:                         .Column7.ControlSource = "cursor_4c_Dados.estadual"
939:                         .Column8.ControlSource = "cursor_4c_Dados.municipal"
940:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
941: 
942:                         *-- Problema 32: Reconfigurar Headers APOS RecordSource
943:                         .Column1.Header1.Caption = "Estado"
944:                         .Column2.Header1.Caption = "Codigo"
945:                         .Column3.Header1.Caption = "Data Ini"
946:                         .Column4.Header1.Caption = "Data Fim"
947:                         .Column5.Header1.Caption = "Aliq Nac Fed"
948:                         .Column6.Header1.Caption = "Aliq Imp Fed"
949:                         .Column7.Header1.Caption = "Aliq Estadual"
950:                         .Column8.Header1.Caption = "Aliq Municipal"
951:                         .Column9.Header1.Caption = "Versao"
952: 
953:                         .Column1.Width = 75
954:                         .Column2.Width = 100

*-- Linhas 987 a 1365:
987:     *===========================================================================
988:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
989:     *===========================================================================
990:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
991:         LOCAL loc_lResultado
992:         loc_lResultado = .F.
993: 
994:         TRY
995:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
996:                 MsgErro("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + ;
997:                     TRANSFORM(par_nPagina), "FormIBP.AlternarPagina")
998:             ELSE
999:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1000:                 IF par_nPagina = 1
1001:                     THIS.CarregarLista()
1002:                 ENDIF
1003:                 loc_lResultado = .T.
1004:             ENDIF
1005:         CATCH TO loException
1006:             MsgErro("Erro em FormIBP.AlternarPagina:" + CHR(13) + ;
1007:                 loException.Message, "Erro")
1008:         ENDTRY
1009: 
1010:         RETURN loc_lResultado
1011:     ENDPROC
1012: 
1013:     *===========================================================================
1014:     * BtnEncerrarClick - Fecha o formulario
1015:     *===========================================================================
1016:     PROCEDURE BtnEncerrarClick()
1017:         THIS.Release()
1018:     ENDPROC
1019: 
1020:     *===========================================================================
1021:     * BtnCarregarClick - Importa planilha CSV de IBPT via IBPBO.ImportarPlanilha
1022:     * Original: btncarregar.Click -> thisform.ImportaPlan()
1023:     *===========================================================================
1024:     PROCEDURE BtnCarregarClick()
1025:         LOCAL loc_lResultado
1026:         loc_lResultado = .F.
1027: 
1028:         TRY
1029:             loc_lResultado = THIS.this_oBusinessObject.ImportarPlanilha()
1030:             IF loc_lResultado
1031:                 MsgInfo("Planilha importada com sucesso.", "Aviso")
1032:                 THIS.CarregarLista()
1033:             ELSE
1034:                 MsgAviso("A Planilha n" + CHR(227) + "o foi importada.", "Aviso")
1035:             ENDIF
1036:         CATCH TO loException
1037:             MsgErro("Erro em FormIBP.BtnCarregarClick:" + CHR(13) + ;
1038:                 loException.Message, "Erro")
1039:         ENDTRY
1040:     ENDPROC
1041: 
1042:     *===========================================================================
1043:     * BtnSalvarClick - Salva registro (Page2)
1044:     *===========================================================================
1045:     PROCEDURE BtnSalvarClick()
1046:         LOCAL loc_lResultado
1047:         loc_lResultado = .F.
1048: 
1049:         TRY
1050:             THIS.FormParaBO()
1051:             IF THIS.this_oBusinessObject.Salvar()
1052:                 MsgInfo("Registro salvo com sucesso!", "Sucesso")
1053:                 THIS.AlternarPagina(1)
1054:             ENDIF
1055:         CATCH TO loException
1056:             MsgErro("Erro em FormIBP.BtnSalvarClick:" + CHR(13) + ;
1057:                 loException.Message, "Erro")
1058:         ENDTRY
1059:     ENDPROC
1060: 
1061:     *===========================================================================
1062:     * BtnCancelarClick - Cancela edicao e volta para lista (Page2 -> Page1)
1063:     *===========================================================================
1064:     PROCEDURE BtnCancelarClick()
1065:         THIS.AlternarPagina(1)
1066:         THIS.this_cModoAtual = "LISTA"
1067:     ENDPROC
1068: 
1069:     *===========================================================================
1070:     * FormParaBO - Transfere campos do Form (Page2) para o Business Object
1071:     * Campos: todos os 14 campos da tabela SigCdIbp
1072:     *===========================================================================
1073:     PROTECTED PROCEDURE FormParaBO()
1074:         LOCAL loc_oPg2
1075:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1076: 
1077:         THIS.this_oBusinessObject.this_cUfs        = ALLTRIM(loc_oPg2.txt_4c_Ufs.Value)
1078:         THIS.this_oBusinessObject.this_cCodigo     = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1079:         THIS.this_oBusinessObject.this_cEx         = ALLTRIM(loc_oPg2.txt_4c_Ex.Value)
1080:         THIS.this_oBusinessObject.this_nTipo       = loc_oPg2.txt_4c_Tipo.Value
1081:         THIS.this_oBusinessObject.this_cDescricao  = ALLTRIM(loc_oPg2.edt_4c_Descricao.Value)
1082:         THIS.this_oBusinessObject.this_dDatIni     = loc_oPg2.txt_4c_DatIni.Value
1083:         THIS.this_oBusinessObject.this_dDatFin     = loc_oPg2.txt_4c_DatFin.Value
1084:         THIS.this_oBusinessObject.this_nNacFederal = loc_oPg2.txt_4c_NacFederal.Value
1085:         THIS.this_oBusinessObject.this_nImpFederal = loc_oPg2.txt_4c_ImpFederal.Value
1086:         THIS.this_oBusinessObject.this_nEstadual   = loc_oPg2.txt_4c_Estadual.Value
1087:         THIS.this_oBusinessObject.this_nMunicipal  = loc_oPg2.txt_4c_Municipal.Value
1088:         THIS.this_oBusinessObject.this_cChave      = ALLTRIM(loc_oPg2.txt_4c_Chave.Value)
1089:         THIS.this_oBusinessObject.this_cVersao     = ALLTRIM(loc_oPg2.txt_4c_Versao.Value)
1090:         THIS.this_oBusinessObject.this_cFonte      = ALLTRIM(loc_oPg2.txt_4c_Fonte.Value)
1091:     ENDPROC
1092: 
1093:     *===========================================================================
1094:     * BOParaForm - Transfere propriedades do Business Object para os campos do Form
1095:     * Campos: todos os 14 campos da tabela SigCdIbp
1096:     *===========================================================================
1097:     PROTECTED PROCEDURE BOParaForm()
1098:         LOCAL loc_oPg2
1099:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1100: 
1101:         loc_oPg2.txt_4c_Ufs.Value        = ALLTRIM(THIS.this_oBusinessObject.this_cUfs)
1102:         loc_oPg2.txt_4c_Codigo.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1103:         loc_oPg2.txt_4c_Ex.Value         = ALLTRIM(THIS.this_oBusinessObject.this_cEx)
1104:         loc_oPg2.txt_4c_Tipo.Value       = THIS.this_oBusinessObject.this_nTipo
1105:         loc_oPg2.edt_4c_Descricao.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cDescricao)
1106:         loc_oPg2.txt_4c_DatIni.Value     = THIS.this_oBusinessObject.this_dDatIni
1107:         loc_oPg2.txt_4c_DatFin.Value     = THIS.this_oBusinessObject.this_dDatFin
1108:         loc_oPg2.txt_4c_NacFederal.Value = THIS.this_oBusinessObject.this_nNacFederal
1109:         loc_oPg2.txt_4c_ImpFederal.Value = THIS.this_oBusinessObject.this_nImpFederal
1110:         loc_oPg2.txt_4c_Estadual.Value   = THIS.this_oBusinessObject.this_nEstadual
1111:         loc_oPg2.txt_4c_Municipal.Value  = THIS.this_oBusinessObject.this_nMunicipal
1112:         loc_oPg2.txt_4c_Chave.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cChave)
1113:         loc_oPg2.txt_4c_Versao.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cVersao)
1114:         loc_oPg2.txt_4c_Fonte.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cFonte)
1115:     ENDPROC
1116: 
1117:     *===========================================================================
1118:     * LimparCampos - Limpa valores dos campos da Page2
1119:     *===========================================================================
1120:     PROTECTED PROCEDURE LimparCampos()
1121:         LOCAL loc_oPg2
1122:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1123: 
1124:         loc_oPg2.txt_4c_Ufs.Value        = ""
1125:         loc_oPg2.txt_4c_Codigo.Value     = ""
1126:         loc_oPg2.txt_4c_Ex.Value         = ""
1127:         loc_oPg2.txt_4c_Tipo.Value       = 0
1128:         loc_oPg2.edt_4c_Descricao.Value  = ""
1129:         loc_oPg2.txt_4c_DatIni.Value     = {}
1130:         loc_oPg2.txt_4c_DatFin.Value     = {}
1131:         loc_oPg2.txt_4c_NacFederal.Value = 0
1132:         loc_oPg2.txt_4c_ImpFederal.Value = 0
1133:         loc_oPg2.txt_4c_Estadual.Value   = 0
1134:         loc_oPg2.txt_4c_Municipal.Value  = 0
1135:         loc_oPg2.txt_4c_Chave.Value      = ""
1136:         loc_oPg2.txt_4c_Versao.Value     = ""
1137:         loc_oPg2.txt_4c_Fonte.Value      = ""
1138:     ENDPROC
1139: 
1140:     *===========================================================================
1141:     * HabilitarCampos - Habilita ou desabilita campos de edicao da Page2
1142:     * ufs e codigo somente editaveis em INCLUIR (componentes da chave natural)
1143:     *===========================================================================
1144:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1145:         LOCAL loc_oPg2, loc_lEnabled, loc_lIncluir
1146:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1147:         loc_lEnabled = (VARTYPE(par_lHabilitar) = "L" AND par_lHabilitar = .T.)
1148:         loc_lIncluir = (THIS.this_cModoAtual = "INCLUIR")
1149: 
1150:         loc_oPg2.txt_4c_Ufs.Enabled        = (loc_lEnabled AND loc_lIncluir)
1151:         loc_oPg2.txt_4c_Codigo.Enabled     = (loc_lEnabled AND loc_lIncluir)
1152:         loc_oPg2.txt_4c_Ex.Enabled         = loc_lEnabled
1153:         loc_oPg2.txt_4c_Tipo.Enabled       = loc_lEnabled
1154:         loc_oPg2.edt_4c_Descricao.Enabled  = loc_lEnabled
1155:         loc_oPg2.txt_4c_DatIni.Enabled     = loc_lEnabled
1156:         loc_oPg2.txt_4c_DatFin.Enabled     = loc_lEnabled
1157:         loc_oPg2.txt_4c_NacFederal.Enabled = loc_lEnabled
1158:         loc_oPg2.txt_4c_ImpFederal.Enabled = loc_lEnabled
1159:         loc_oPg2.txt_4c_Estadual.Enabled   = loc_lEnabled
1160:         loc_oPg2.txt_4c_Municipal.Enabled  = loc_lEnabled
1161:         loc_oPg2.txt_4c_Chave.Enabled      = (loc_lEnabled AND loc_lIncluir)
1162:         loc_oPg2.txt_4c_Versao.Enabled     = (loc_lEnabled AND loc_lIncluir)
1163:         loc_oPg2.txt_4c_Fonte.Enabled      = loc_lEnabled
1164:     ENDPROC
1165: 
1166:     *===========================================================================
1167:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1168:     * Filtra cnt_4c_Botoes (deve permanecer oculto neste form - Problema 26)
1169:     *===========================================================================
1170:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1171:         LOCAL loc_nI, loc_oObjeto, loc_cNome, loc_nP
1172: 
1173:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1174:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1175: 
1176:             IF VARTYPE(loc_oObjeto) = "O"
1177:                 loc_cNome = UPPER(loc_oObjeto.Name)
1178: 
1179:                 *-- cnt_4c_Botoes permanece oculto (CRUD escondido no SIGCDIBP)
1180:                 *-- cnt_4c_Cabecalho: preservar Visible original (pode ser .F. em Page2)
1181:                 IF INLIST(loc_cNome, "CNT_4C_BOTOES", "CNT_4C_CABECALHO")
1182:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1183:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1184:                     ENDIF
1185:                     LOOP
1186:                 ENDIF
1187: 
1188:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1189:                     loc_oObjeto.Visible = .T.
1190:                 ENDIF
1191: 
1192:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1193:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1194:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1195:                     ENDFOR
1196:                 ENDIF
1197: 
1198:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1199:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1200:                 ENDIF
1201:             ENDIF
1202:         ENDFOR
1203:     ENDPROC
1204: 
1205:     *===========================================================================
1206:     * FormatarGridLista - Formata visual do grid da lista
1207:     *===========================================================================
1208:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1209:         WITH par_oGrid
1210:             .FontName = "Tahoma"
1211:             .FontSize = 8
1212:         ENDWITH
1213:     ENDPROC
1214: 
1215:     *===========================================================================
1216:     * BtnIncluirClick - Abre Page2 em modo INCLUIR
1217:     * Problema 18: NovoRegistro() prepara BO para INSERT
1218:     * Problema 19: this_cModoAtual ANTES de HabilitarCampos
1219:     *===========================================================================
1220:     PROCEDURE BtnIncluirClick()
1221:         THIS.this_oBusinessObject.NovoRegistro()
1222:         THIS.LimparCampos()
1223:         THIS.this_cModoAtual = "INCLUIR"
1224:         THIS.HabilitarCampos(.T.)
1225:         THIS.AlternarPagina(2)
1226:     ENDPROC
1227: 
1228:     *===========================================================================
1229:     * BtnAlterarClick - Carrega registro selecionado e abre Page2 em modo ALTERAR
1230:     * Problema 18: EditarRegistro() prepara BO para UPDATE
1231:     *===========================================================================
1232:     PROCEDURE BtnAlterarClick()
1233:         LOCAL loc_cCidChaves, loc_lResultado
1234:         loc_lResultado = .F.
1235: 
1236:         TRY
1237:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1238:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1239:             ELSE
1240:                 SELECT cursor_4c_Dados
1241:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1242:                 IF EMPTY(loc_cCidChaves)
1243:                     MsgAviso("Nenhum registro selecionado.", "Alterar")
1244:                 ELSE
1245:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1246:                     THIS.this_oBusinessObject.EditarRegistro()
1247:                     THIS.BOParaForm()
1248:                     THIS.this_cModoAtual = "ALTERAR"
1249:                     THIS.HabilitarCampos(.T.)
1250:                     THIS.AlternarPagina(2)
1251:                     loc_lResultado = .T.
1252:                     ENDIF
1253:                 ENDIF
1254:             ENDIF
1255:         CATCH TO loException
1256:             MsgErro("Erro em FormIBP.BtnAlterarClick:" + CHR(13) + loException.Message, "Erro")
1257:         ENDTRY
1258:     ENDPROC
1259: 
1260:     *===========================================================================
1261:     * BtnVisualizarClick - Carrega registro selecionado e abre Page2 somente leitura
1262:     *===========================================================================
1263:     PROCEDURE BtnVisualizarClick()
1264:         LOCAL loc_cCidChaves, loc_lResultado
1265:         loc_lResultado = .F.
1266: 
1267:         TRY
1268:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1269:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1270:             ELSE
1271:                 SELECT cursor_4c_Dados
1272:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1273:                 IF EMPTY(loc_cCidChaves)
1274:                     MsgAviso("Nenhum registro selecionado.", "Visualizar")
1275:                 ELSE
1276:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1277:                     THIS.BOParaForm()
1278:                     THIS.this_cModoAtual = "VISUALIZAR"
1279:                     THIS.HabilitarCampos(.F.)
1280:                     THIS.AlternarPagina(2)
1281:                     loc_lResultado = .T.
1282:                     ENDIF
1283:                 ENDIF
1284:             ENDIF
1285:         CATCH TO loException
1286:             MsgErro("Erro em FormIBP.BtnVisualizarClick:" + CHR(13) + loException.Message, "Erro")
1287:         ENDTRY
1288:     ENDPROC
1289: 
1290:     *===========================================================================
1291:     * BtnExcluirClick - Confirma e exclui registro selecionado do grid
1292:     * Form chama Excluir() (PUBLIC); BO executa ExecutarExclusao() (PROTECTED)
1293:     *===========================================================================
1294:     PROCEDURE BtnExcluirClick()
1295:         LOCAL loc_cCidChaves
1296: 
1297:         TRY
1298:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1299:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1300:             ELSE
1301:                 SELECT cursor_4c_Dados
1302:                 loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1303:                 IF EMPTY(loc_cCidChaves)
1304:                     MsgAviso("Nenhum registro selecionado.", "Excluir")
1305:                 ELSE
1306:                     IF MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro de IBPT?", "Excluir")
1307:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1308:                         IF THIS.this_oBusinessObject.Excluir()
1309:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1310:                             THIS.CarregarLista()
1311:                         ENDIF
1312:                     ENDIF
1313:                     ENDIF
1314:                 ENDIF
1315:             ENDIF
1316:         CATCH TO loException
1317:             MsgErro("Erro em FormIBP.BtnExcluirClick:" + CHR(13) + loException.Message, "Erro")
1318:         ENDTRY
1319:     ENDPROC
1320: 
1321:     *===========================================================================
1322:     * BtnBuscarClick - Filtra registros da lista por UFS ou Codigo
1323:     * cnt_4c_Botoes fica oculto no SIGCDIBP; metodo implementado para completude
1324:     *===========================================================================
1325:     PROCEDURE BtnBuscarClick()
1326:         LOCAL loc_cFiltro, loc_lResultado
1327:         loc_cFiltro    = ""
1328:         loc_lResultado = .F.
1329: 
1330:         TRY
1331:             loc_cFiltro = ALLTRIM(INPUTBOX("Digite UFS ou C" + CHR(243) + "digo para filtrar:", ;
1332:                 "Buscar IBPT", ""))
1333: 
1334:             IF EMPTY(loc_cFiltro)
1335:                 THIS.CarregarLista()
1336:             ELSE
1337:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1338:                     LOCAL loc_oGrid
1339:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1340: 
1341:                     loc_oGrid.ColumnCount = 3
1342:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1343:                     loc_oGrid.ColumnCount  = 9
1344: 
1345:                     WITH loc_oGrid
1346:                         .Column1.ControlSource = "cursor_4c_Dados.ufs"
1347:                         .Column2.ControlSource = "cursor_4c_Dados.codigo"
1348:                         .Column3.ControlSource = "cursor_4c_Dados.datini"
1349:                         .Column4.ControlSource = "cursor_4c_Dados.datfin"
1350:                         .Column5.ControlSource = "cursor_4c_Dados.nacfederal"
1351:                         .Column6.ControlSource = "cursor_4c_Dados.impfederal"
1352:                         .Column7.ControlSource = "cursor_4c_Dados.estadual"
1353:                         .Column8.ControlSource = "cursor_4c_Dados.municipal"
1354:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
1355: 
1356:                         .Column1.Header1.Caption = "Estado"
1357:                         .Column2.Header1.Caption = "Codigo"
1358:                         .Column3.Header1.Caption = "Data Ini"
1359:                         .Column4.Header1.Caption = "Data Fim"
1360:                         .Column5.Header1.Caption = "Aliq Nac Fed"
1361:                         .Column6.Header1.Caption = "Aliq Imp Fed"
1362:                         .Column7.Header1.Caption = "Aliq Estadual"
1363:                         .Column8.Header1.Caption = "Aliq Municipal"
1364:                         .Column9.Header1.Caption = "Versao"
1365: 

*-- Linhas 1388 a 1427:
1388:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
1389:     * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
1390:     *===========================================================================
1391:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1392:         LOCAL loc_oPg2, loc_lModoEdicao, loc_lModoVisualizacao
1393:         loc_oPg2               = THIS.pgf_4c_Paginas.Page2
1394:         loc_lModoEdicao        = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1395:         loc_lModoVisualizacao  = (THIS.this_cModoAtual = "VISUALIZAR")
1396: 
1397:         *-- Botao Confirmar: habilitado apenas em edicao
1398:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Enabled", 5)
1399:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
1400:         ENDIF
1401: 
1402:         *-- Botao Cancelar: habilitado em edicao e visualizacao
1403:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar, "Enabled", 5)
1404:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lModoEdicao OR loc_lModoVisualizacao)
1405:         ENDIF
1406: 
1407:         *-- Botao BtnCarregar: habilitado apenas na lista
1408:         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar) = "O"
1409:             THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar.Enabled = (THIS.this_cModoAtual = "LISTA")
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     *===========================================================================
1414:     * Destroy - Libera recursos
1415:     *===========================================================================
1416:     PROCEDURE Destroy()
1417:         TRY
1418:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1419:                 THIS.this_oBusinessObject = .NULL.
1420:             ENDIF
1421:         CATCH TO loException
1422:             MsgErro("Erro em FormIBP.Destroy:" + CHR(13) + loException.Message, "Erro")
1423:         ENDTRY
1424:         DODEFAULT()
1425:     ENDPROC
1426: 
1427: ENDDEFINE


### BO (C:\4c\projeto\app\classes\IBPBO.prg):
*------------------------------------------------------------------------------
* IBPBO.prg - Business Object para SigCdIbp (Cadastro IBPT)
* Herda de BusinessBase
* Tabela: SigCdIbp / PK: cidchaves
*------------------------------------------------------------------------------

DEFINE CLASS IBPBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves  = ""   && char(20) NOT NULL

    *-- Campos da tabela SigCdIbp
    this_cUfs        = ""   && char(2)
    this_cCodigo     = ""   && char(10)
    this_cEx         = ""   && char(3)
    this_nTipo       = 0    && numeric(3,0)
    this_cDescricao  = ""   && text (memo)
    this_dDatIni     = {}   && datetime
    this_dDatFin     = {}   && datetime
    this_nNacFederal = 0    && numeric(5,2)
    this_nImpFederal = 0    && numeric(5,2)
    this_nEstadual   = 0    && numeric(5,2)
    this_nMunicipal  = 0    && numeric(5,2)
    this_cChave      = ""   && char(10)
    this_cVersao     = ""   && char(10)
    this_cFonte      = ""   && char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdIbp"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional; cursor_4c_Dados para o grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                loc_cWhere = ""
            ENDIF

            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       loc_cWhere + ;
                       " ORDER BY ufs, codigo, versao"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cUfs        = TratarNulo(ufs,        "C")
                THIS.this_cCodigo     = TratarNulo(codigo,     "C")
                THIS.this_cEx         = TratarNulo(ex,         "C")
                THIS.this_nTipo       = TratarNulo(tipo,       "N")
                THIS.this_cDescricao  = TratarNulo(descricao,  "C")
                THIS.this_dDatIni     = TratarNulo(datini,     "D")
                THIS.this_dDatFin     = TratarNulo(datfin,     "D")
                THIS.this_nNacFederal = TratarNulo(nacfederal, "N")
                THIS.this_nImpFederal = TratarNulo(impfederal, "N")
                THIS.this_nEstadual   = TratarNulo(estadual,   "N")
                THIS.this_nMunicipal  = TratarNulo(municipal,  "N")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cVersao     = TratarNulo(versao,     "C")
                THIS.this_cFonte      = TratarNulo(fonte,      "C")
                loc_lSucesso = .T.
            CATCH TO loException
                MsgErro("Erro em IBPBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro via CRUD standard
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdIbp" + ;
                       " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       "  datini, datfin, nacfederal, impfederal," + ;
                       "  estadual, municipal, chave, versao, fonte)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cUfs) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cEx) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       EscaparSQL(THIS.this_cChave) + "," + ;
                       EscaparSQL(THIS.this_cVersao) + "," + ;
                       EscaparSQL(THIS.this_cFonte) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdIbp SET" + ;
                       " ufs        = " + EscaparSQL(THIS.this_cUfs) + "," + ;
                       " codigo     = " + EscaparSQL(THIS.this_cCodigo) + "," + ;
                       " ex         = " + EscaparSQL(THIS.this_cEx) + "," + ;
                       " tipo       = " + FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       " descricao  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " datini     = " + FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       " datfin     = " + FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       " nacfederal = " + FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       " impfederal = " + FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       " estadual   = " + FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       " municipal  = " + FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       " chave      = " + EscaparSQL(THIS.this_cChave) + "," + ;
                       " versao     = " + EscaparSQL(THIS.this_cVersao) + "," + ;
                       " fonte      = " + EscaparSQL(THIS.this_cFonte) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarPlanilha - Importa dados IBPT de arquivos CSV de uma pasta
    * Portado de SIGCDIBP.importaplan
    * CSV: c1=codigo, c2=ex(skip se !empty), c4=descricao, c5=nacfed, c6=impfed,
    *       c7=estadual, c8=municipal, c9=datini, c10=datfin, c11=chave,
    *       c12=versao, c13=fonte. UF extraida do nome do arquivo (pos 13-14).
    *--------------------------------------------------------------------------
    FUNCTION ImportarPlanilha()
        LOCAL loc_lSucesso, loc_lOk, loc_lcDir, loc_nQtdArq
        LOCAL loc_lcArq, loc_lcUf, loc_lcCodigo, loc_lcDesc
        LOCAL loc_lnAliq5, loc_lnAliq6, loc_lnAliq7, loc_lnAliq8
        LOCAL loc_ldDatIni, loc_ldDatFin
        LOCAL loc_lcChave, loc_lcVersao, loc_lcFonte
        LOCAL loc_lcCidChaves, loc_lcQuery, loc_nResult, loc_i
        loc_lSucesso = .F.
        loc_lOk      = .F.

        *-- Selecionar pasta (fora do TRY - RETURN .F. e valido aqui)
        loc_lcDir = GETDIR([], "Selecione a Pasta com os Arquivos CSV do IBPT", ;
                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2)
        IF EMPTY(loc_lcDir)
            RETURN .F.
        ENDIF

        DIMENSION loc_laArqs[1, 5]
        loc_nQtdArq = ADIR(loc_laArqs, loc_lcDir + "*.csv")
        IF loc_nQtdArq = 0
            MsgAviso("Nenhum arquivo CSV encontrado na pasta selecionada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        TRY
            CREATE CURSOR localIbpt (c1 c(10), c2 c(50), c3 c(50), c4 c(100), ;
                c5 c(50), c6 c(50), c7 c(50), c8 c(50), ;
                c9 c(50), c10 c(50), c11 c(50), c12 c(50), c13 c(50))

            FOR loc_i = 1 TO loc_nQtdArq
                loc_lcArq = loc_lcDir + loc_laArqs[loc_i, 1]
                IF EMPTY(loc_lcArq)
                    LOOP
                ENDIF

                *-- UF extraida do nome do arquivo (posicoes 13-14 do nome original)
                loc_lcUf = SUBSTR(ALLTRIM(loc_laArqs[loc_i, 1]), 13, 2)

                SELECT localIbpt
                ZAP
                APPEND FROM (loc_lcArq) DELIMITED WITH CHARACTER ";"
                GO TOP
                DELETE
                DELETE ALL FOR !EMPTY(c2)
                GO TOP

                SCAN
                    loc_lcCodigo = ALLTRIM(c1)
                    loc_lcDesc   = ALLTRIM(c4)
                    loc_lnAliq5  = VAL(ALLTRIM(c5))
                    loc_lnAliq6  = VAL(ALLTRIM(c6))
                    loc_lnAliq7  = VAL(ALLTRIM(c7))
                    loc_lnAliq8  = VAL(ALLTRIM(c8))
                    loc_ldDatIni = DTOT(CTOD(ALLTRIM(c9)))
                    loc_ldDatFin = DTOT(CTOD(ALLTRIM(c10)))
                    loc_lcChave  = ALLTRIM(c11)
                    loc_lcVersao = ALLTRIM(c12)
                    loc_lcFonte  = ALLTRIM(c13)

                    loc_lcQuery = "SELECT cidchaves FROM SigCdIbp" + ;
                                  " WHERE ufs    = " + EscaparSQL(loc_lcUf) + ;
                                  " AND   codigo = " + EscaparSQL(loc_lcCodigo) + ;
                                  " AND   chave  = " + EscaparSQL(loc_lcChave) + ;
                                  " AND   versao = " + EscaparSQL(loc_lcVersao)

                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_AuxIbp")
                        TABLEREVERT(.T., "cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_AuxIbp")
                    IF loc_nResult < 0
                        MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", "Erro")
                        loc_lOk = .F.
                        IF USED("cursor_4c_AuxIbp")
                            USE IN cursor_4c_AuxIbp
                        ENDIF
                        EXIT
                    ENDIF

                    IF RECCOUNT("cursor_4c_AuxIbp") = 0
                        *-- Novo registro
                        loc_lcCidChaves = LEFT(fUniqueIds(), 20)
                        loc_lcQuery = "INSERT INTO SigCdIbp" + ;
                                      " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                                      "  datini, datfin, nacfederal, impfederal," + ;
                                      "  estadual, municipal, chave, versao, fonte)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(loc_lcCidChaves) + "," + ;
                                      EscaparSQL(loc_lcUf) + "," + ;
                                      EscaparSQL(loc_lcCodigo) + "," + ;
                                      EscaparSQL("") + "," + ;
                                      "0," + ;
                                      EscaparSQL(loc_lcDesc) + "," + ;
                                      FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      EscaparSQL(loc_lcChave) + "," + ;
                                      EscaparSQL(loc_lcVersao) + "," + ;
                                      EscaparSQL(loc_lcFonte) + ;
                                      ")"
                    ELSE
                        *-- Registro existente - atualizar aliquotas e datas
                        SELECT cursor_4c_AuxIbp
                        loc_lcCidChaves = ALLTRIM(cursor_4c_AuxIbp.cidchaves)
                        loc_lcQuery = "UPDATE SigCdIbp SET" + ;
                                      " descricao  = " + EscaparSQL(loc_lcDesc) + "," + ;
                                      " datini     = " + FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      " datfin     = " + FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      " nacfederal = " + FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      " impfederal = " + FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      " estadual   = " + FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      " municipal  = " + FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      " fonte      = " + EscaparSQL(loc_lcFonte) + ;
                                      " WHERE cidchaves = " + EscaparSQL(loc_lcCidChaves)
                    ENDIF

                    IF USED("cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_nResult < 0
                        MsgErro("Erro ao importar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT localIbpt
                ENDSCAN

                IF !loc_lOk
                    EXIT
                ENDIF
            ENDFOR

            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF

            loc_lSucesso = loc_lOk
        CATCH TO loException
            MsgErro("Erro em IBPBO.ImportarPlanilha:" + CHR(13) + loException.Message, "Erro")
            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF
            IF USED("cursor_4c_AuxIbp")
                USE IN cursor_4c_AuxIbp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

