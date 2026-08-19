# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [ALINHAMENTO] Botao 'cmd_4c_CompObrigInserir' tem Top=100 mas grupo usa Top=87 (diferenca de 13px)
- [ALINHAMENTO] Botao 'cmd_4c_CompObrigExcluir' tem Top=140 mas grupo usa Top=127 (diferenca de 13px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormLin.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3092 linhas total):

*-- Linhas 54 a 63:
54:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.ConfigurarPaginaLista()
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59:                 THIS.ConfigurarPaginaDados()
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarLista()
63:                 ENDIF

*-- Linhas 86 a 101:
86:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87:             WITH THIS.pgf_4c_Paginas
88:                 .PageCount      = 2
89:                 .Top            = -29
90:                 .Left           = 0
91:                 .Width          = THIS.Width
92:                 .Height         = THIS.Height + 29
93:                 .Tabs           = .F.
94:                 .Visible        = .T.
95:                 .Page1.Caption  = "Lista"
96:                 .Page2.Caption  = "Dados"
97:                 .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:                 .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             ENDWITH
100:         CATCH TO loException
101:             MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarPageFrame")

*-- Linhas 116 a 152:
116:             *-- Cabecalho cinza superior
117:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:             WITH loc_oPagina.cnt_4c_Cabecalho
119:                 .Top         = 31
120:                 .Left        = 0
121:                 .Width       = THIS.Width
122:                 .Height      = 80
123:                 .BackColor   = RGB(100, 100, 100)
124:                 .BorderWidth = 0
125:                 .Visible     = .T.
126: 
127:                 .AddObject("lbl_4c_Sombra", "Label")
128:                 WITH .lbl_4c_Sombra
129:                     .Caption    = "Cadastro de Linhas"
130:                     .Top        = 15
131:                     .Left       = 12
132:                     .Width      = THIS.Width
133:                     .Height     = 40
134:                     .FontName   = "Tahoma"
135:                     .FontSize   = 16
136:                     .FontBold   = .T.
137:                     .ForeColor  = RGB(0, 0, 0)
138:                     .BackStyle  = 0
139:                     .AutoSize   = .F.
140:                     .Visible    = .T.
141:                 ENDWITH
142: 
143:                 .AddObject("lbl_4c_Titulo", "Label")
144:                 WITH .lbl_4c_Titulo
145:                     .Caption    = "Cadastro de Linhas"
146:                     .Top        = 18
147:                     .Left       = 10
148:                     .Width      = THIS.Width
149:                     .Height     = 46
150:                     .FontName   = "Tahoma"
151:                     .FontSize   = 16
152:                     .FontBold   = .T.

*-- Linhas 160 a 181:
160:             *-- Container botoes CRUD (canonico: Left=542, lado direito)
161:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:             WITH loc_oPagina.cnt_4c_Botoes
163:                 .Top         = 29
164:                 .Left        = 542
165:                 .Width       = 390
166:                 .Height      = 85
167:                 .BackStyle   = 1
168:                 .BackColor   = RGB(53, 53, 53)
169:                 .BorderWidth = 0
170:                 .Visible     = .T.
171: 
172:                 .AddObject("cmd_4c_Incluir", "CommandButton")
173:                 WITH .cmd_4c_Incluir
174:                     .Caption         = "Incluir"
175:                     .Top             = 5
176:                     .Left            =  542
177:                     .Width           = 75
178:                     .Height          = 75
179:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:                     .PicturePosition = 13
181:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 191 a 203:
191:                     .Visible         = .T.
192:                 ENDWITH
193: 
194:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
195:                 WITH .cmd_4c_Visualizar
196:                     .Caption         = "Visualizar"
197:                     .Top             = 5
198:                     .Left            =  542
199:                     .Width           = 75
200:                     .Height          = 75
201:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:                     .PicturePosition = 13
203:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 214 a 226:
214:                     .Visible         = .T.
215:                 ENDWITH
216: 
217:                 .AddObject("cmd_4c_Alterar", "CommandButton")
218:                 WITH .cmd_4c_Alterar
219:                     .Caption         = "Alterar"
220:                     .Top             = 5
221:                     .Left            =  542
222:                     .Width           = 75
223:                     .Height          = 75
224:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:                     .PicturePosition = 13
226:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 237 a 249:
237:                     .Visible         = .T.
238:                 ENDWITH
239: 
240:                 .AddObject("cmd_4c_Excluir", "CommandButton")
241:                 WITH .cmd_4c_Excluir
242:                     .Caption         = "Excluir"
243:                     .Top             = 5
244:                     .Left            =  542
245:                     .Width           = 75
246:                     .Height          = 75
247:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:                     .PicturePosition = 13
249:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 260 a 272:
260:                     .Visible         = .T.
261:                 ENDWITH
262: 
263:                 .AddObject("cmd_4c_Buscar", "CommandButton")
264:                 WITH .cmd_4c_Buscar
265:                     .Caption         = "Buscar"
266:                     .Top             = 5
267:                     .Left            =  542
268:                     .Width           = 75
269:                     .Height          = 75
270:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:                     .PicturePosition = 13
272:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 287 a 307:
287:             *-- Container Encerrar (padrao canonico - Left=917, Width=90)
288:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
289:             WITH loc_oPagina.cnt_4c_Saida
290:                 .Top         = 29
291:                 .Left        = 917
292:                 .Width       = 90
293:                 .Height      = 85
294:                 .BackStyle   = 0
295:                 .BorderWidth = 0
296:                 .Visible     = .T.
297: 
298:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
299:                 WITH .cmd_4c_Encerrar
300:                     .Caption         = "Encerrar"
301:                     .Top             = 5
302:                     .Left            = 917
303:                     .Width           = 75
304:                     .Height          = 75
305:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:                     .PicturePosition = 13
307:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 322 a 354:
322:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
323:             loc_oPagina.grd_4c_Lista.ColumnCount = 2
324:             WITH loc_oPagina.grd_4c_Lista
325:                 .Top                = 117
326:                 .Left               = 26
327:                 .Width              = 890
328:                 .Height             = 498
329:                 .DeleteMark         = .F.
330:                 .RecordMark         = .F.
331:                 .RowHeight          = 16
332:                 .ScrollBars         = 2
333:                 .GridLineColor      = RGB(238, 238, 238)
334:                 .HighlightBackColor = RGB(255, 255, 255)
335:                 .HighlightForeColor = RGB(15, 41, 104)
336:                 .HighlightStyle     = 2
337:                 .Visible            = .T.
338:                 .Column1.Width               = 120
339:                 .Column1.Header1.Caption     = ""
340:                 .Column2.Width               = 770
341:                 .Column2.Header1.Caption     = "Descri" + CHR(231) + CHR(227) + "o"
342:             ENDWITH
343: 
344:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
345:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
346:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
347:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
348:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
349:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
350: 
351:             THIS.TornarControlesVisiveis(loc_oPagina)
352:         CATCH TO loException
353:             MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarPaginaLista")
354:         ENDTRY

*-- Linhas 368 a 388:
368:             *-- Container botoes Confirmar/Cancelar (Top=4+29=33)
369:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
370:             WITH loc_oPagina.cnt_4c_BotoesAcao
371:                 .Top         = 33
372:                 .Left        = 842
373:                 .Width       = 160
374:                 .Height      = 85
375:                 .BackStyle   = 0
376:                 .BorderWidth = 0
377:                 .Visible     = .T.
378: 
379:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
380:                 WITH .cmd_4c_Confirmar
381:                     .Caption         = "Confirmar"
382:                     .Top             = 5
383:                     .Left            = 5
384:                     .Width           = 75
385:                     .Height          = 75
386:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
387:                     .PicturePosition = 13
388:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 398 a 410:
398:                     .Visible         = .T.
399:                 ENDWITH
400: 
401:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
402:                 WITH .cmd_4c_Cancelar
403:                     .Caption         = "Encerrar"
404:                     .Top             = 5
405:                     .Left            = 80
406:                     .Width           = 75
407:                     .Height          = 75
408:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
409:                     .PicturePosition = 13
410:                     .BackColor       = RGB(255, 255, 255)

*-- Linhas 422 a 447:
422:                 ENDWITH
423:             ENDWITH
424: 
425:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
426:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
427: 
428:             *-- PageFrame interno com 3 abas: Geral | Fases | Composicao
429:             *-- Top = 121 (original) + 29 (compensacao outer PF) = 150
430:             *-- Left = -4, Width = 1007 (original - cobre largura total com overlap minimo)
431:             loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
432:             WITH loc_oPagina.pgf_4c_Abas
433:                 .PageCount      = 3
434:                 .Top            = 150
435:                 .Left           = -4
436:                 .Width          = 1007
437:                 .Height         = 483
438:                 .Tabs           = .T.
439:                 .Visible        = .T.
440:                 .Page1.Caption  = "Geral"
441:                 .Page2.Caption  = "Fases"
442:                 .Page3.Caption  = "Composi" + CHR(231) + CHR(227) + "o"
443:             ENDWITH
444: 
445:             THIS.ConfigurarAbaGeral()
446:             THIS.ConfigurarAbaFases()
447:             THIS.ConfigurarAbaComposicao()

*-- Linhas 469 a 478:
469:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
470:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Linhas"
471:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descs"
472:                         loc_oGrid.Column1.Header1.Caption = ""
473:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
474:                         THIS.FormatarGridLista(loc_oGrid)
475:                     ENDIF
476:                     loc_lResultado = .T.
477:                 ENDIF
478:             ENDIF

*-- Linhas 920 a 929:
920:                 IF PEMSTATUS(loc_oPg1, "opt_4c_Preco", 5)
921:                     loc_oPg1.opt_4c_Preco.Enabled = par_lHabilitar
922:                 ENDIF
923:                 IF PEMSTATUS(loc_oPg1, "cmd_4c_CmdgFigura", 5)
924:                     loc_oPg1.cmd_4c_CmdgFigura.Enabled = par_lHabilitar
925:                 ENDIF
926:             ENDIF
927:         CATCH TO loException
928:             MsgErro("Erro: " + loException.Message, "FormLin.HabilitarCampos")
929:         ENDTRY

*-- Linhas 939 a 960:
939:             loc_lModoLista = (THIS.this_cModoAtual = "LISTA")
940: 
941:             IF VARTYPE(loc_oCnt) = "O"
942:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
943:                     loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
944:                 ENDIF
945:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
946:                     loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
947:                 ENDIF
948:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
949:                     loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
950:                 ENDIF
951:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
952:                     loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
953:                 ENDIF
954:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
955:                     loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista
956:                 ENDIF
957:             ENDIF
958:         CATCH TO loException
959:             MsgErro("Erro: " + loException.Message, "FormLin.AjustarBotoesPorModo")
960:         ENDTRY

*-- Linhas 997 a 1409:
997:             loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
998: 
999:             *-- Linha (PK - top=29, label top=34)
1000:             loc_oAba.AddObject("lbl_4c_LabelLinha", "Label")
1001:             WITH loc_oAba.lbl_4c_LabelLinha
1002:                 .Caption   = "Linha :"
1003:                 .Top       = 34
1004:                 .Left      = 208
1005:                 .Width     = 34
1006:                 .Height    = 15
1007:                 .FontName  = "Tahoma"
1008:                 .FontSize  = 8
1009:                 .BackStyle = 0
1010:                 .ForeColor = RGB(90, 90, 90)
1011:                 .Visible   = .T.
1012:             ENDWITH
1013: 
1014:             loc_oAba.AddObject("txt_4c_Linhas", "TextBox")
1015:             WITH loc_oAba.txt_4c_Linhas
1016:                 .Value     = ""
1017:                 .Top       = 29
1018:                 .Left      = 247
1019:                 .Width     = 79
1020:                 .Height    = 25
1021:                 .MaxLength = 10
1022:                 .FontName  = "Tahoma"
1023:                 .FontSize  = 8
1024:                 .Visible   = .T.
1025:             ENDWITH
1026: 
1027:             *-- Descricao (top=57, label top=62)
1028:             loc_oAba.AddObject("lbl_4c_LabelDescricao", "Label")
1029:             WITH loc_oAba.lbl_4c_LabelDescricao
1030:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1031:                 .Top       = 62
1032:                 .Left      = 187
1033:                 .Width     = 55
1034:                 .Height    = 15
1035:                 .FontName  = "Tahoma"
1036:                 .FontSize  = 8
1037:                 .BackStyle = 0
1038:                 .ForeColor = RGB(90, 90, 90)
1039:                 .Visible   = .T.
1040:             ENDWITH
1041: 
1042:             loc_oAba.AddObject("txt_4c_Descs", "TextBox")
1043:             WITH loc_oAba.txt_4c_Descs
1044:                 .Value     = ""
1045:                 .Top       = 57
1046:                 .Left      = 247
1047:                 .Width     = 289
1048:                 .Height    = 25
1049:                 .MaxLength = 50
1050:                 .FontName  = "Tahoma"
1051:                 .FontSize  = 8
1052:                 .Visible   = .T.
1053:             ENDWITH
1054: 
1055:             *-- Pedido de Estoque Minimo (top=84, label top=88) - lookup SigCdOpe
1056:             loc_oAba.AddObject("lbl_4c_LabelPedido", "Label")
1057:             WITH loc_oAba.lbl_4c_LabelPedido
1058:                 .Caption   = "Pedido de Estoque M" + CHR(237) + "nimo :"
1059:                 .Top       = 88
1060:                 .Left      = 109
1061:                 .Width     = 133
1062:                 .Height    = 15
1063:                 .FontName  = "Tahoma"
1064:                 .FontSize  = 8
1065:                 .BackStyle = 0
1066:                 .ForeColor = RGB(90, 90, 90)
1067:                 .Visible   = .T.
1068:             ENDWITH
1069: 
1070:             loc_oAba.AddObject("txt_4c_Pedidos", "TextBox")
1071:             WITH loc_oAba.txt_4c_Pedidos
1072:                 .Value     = ""
1073:                 .Top       = 84
1074:                 .Left      = 247
1075:                 .Width     = 151
1076:                 .Height    = 23
1077:                 .MaxLength = 5
1078:                 .FontName  = "Tahoma"
1079:                 .FontSize  = 8
1080:                 .Visible   = .T.
1081:             ENDWITH
1082: 
1083:             *-- Tipo de Custo [1]=Unitario [2]=Por Peso (top=110, label top=114)
1084:             loc_oAba.AddObject("lbl_4c_LabelTpCusto", "Label")
1085:             WITH loc_oAba.lbl_4c_LabelTpCusto
1086:                 .Caption   = "Tipo de Custo :"
1087:                 .Top       = 114
1088:                 .Left      = 167
1089:                 .Width     = 75
1090:                 .Height    = 15
1091:                 .FontName  = "Tahoma"
1092:                 .FontSize  = 8
1093:                 .BackStyle = 0
1094:                 .ForeColor = RGB(90, 90, 90)
1095:                 .Visible   = .T.
1096:             ENDWITH
1097: 
1098:             loc_oAba.AddObject("txt_4c_TpCustos", "TextBox")
1099:             WITH loc_oAba.txt_4c_TpCustos
1100:                 .Value     = ""
1101:                 .Top       = 110
1102:                 .Left      = 247
1103:                 .Width     = 20
1104:                 .Height    = 23
1105:                 .MaxLength = 1
1106:                 .FontName  = "Tahoma"
1107:                 .FontSize  = 8
1108:                 .Visible   = .T.
1109:             ENDWITH
1110: 
1111:             loc_oAba.AddObject("lbl_4c_HintTpCusto", "Label")
1112:             WITH loc_oAba.lbl_4c_HintTpCusto
1113:                 .Caption   = "[1] Unit" + CHR(225) + "rio  [2] Por Peso"
1114:                 .Top       = 114
1115:                 .Left      = 274
1116:                 .Width     = 118
1117:                 .Height    = 15
1118:                 .FontName  = "Tahoma"
1119:                 .FontSize  = 8
1120:                 .BackStyle = 0
1121:                 .ForeColor = RGB(90, 90, 90)
1122:                 .Visible   = .T.
1123:             ENDWITH
1124: 
1125:             *-- Tipo de Venda [1]=Unitario [2]=Por Peso (top=136, label top=140)
1126:             loc_oAba.AddObject("lbl_4c_LabelTpVenda", "Label")
1127:             WITH loc_oAba.lbl_4c_LabelTpVenda
1128:                 .Caption   = "Tipo de Venda :"
1129:                 .Top       = 140
1130:                 .Left      = 165
1131:                 .Width     = 75
1132:                 .Height    = 15
1133:                 .FontName  = "Tahoma"
1134:                 .FontSize  = 8
1135:                 .BackStyle = 0
1136:                 .ForeColor = RGB(90, 90, 90)
1137:                 .Visible   = .T.
1138:             ENDWITH
1139: 
1140:             loc_oAba.AddObject("txt_4c_TpVendas", "TextBox")
1141:             WITH loc_oAba.txt_4c_TpVendas
1142:                 .Value     = ""
1143:                 .Top       = 136
1144:                 .Left      = 247
1145:                 .Width     = 20
1146:                 .Height    = 23
1147:                 .MaxLength = 1
1148:                 .FontName  = "Tahoma"
1149:                 .FontSize  = 8
1150:                 .Visible   = .T.
1151:             ENDWITH
1152: 
1153:             loc_oAba.AddObject("lbl_4c_HintTpVenda", "Label")
1154:             WITH loc_oAba.lbl_4c_HintTpVenda
1155:                 .Caption   = "[1] Unit" + CHR(225) + "rio  [2] Por Peso"
1156:                 .Top       = 140
1157:                 .Left      = 274
1158:                 .Width     = 118
1159:                 .Height    = 15
1160:                 .FontName  = "Tahoma"
1161:                 .FontSize  = 8
1162:                 .BackStyle = 0
1163:                 .ForeColor = RGB(90, 90, 90)
1164:                 .Visible   = .T.
1165:             ENDWITH
1166: 
1167:             *-- Analisa Pesagem [1]=Sim [2]=Nao (top=162, label top=166)
1168:             loc_oAba.AddObject("lbl_4c_LabelAnaPes", "Label")
1169:             WITH loc_oAba.lbl_4c_LabelAnaPes
1170:                 .Caption   = "Analisa Pesagem :"
1171:                 .Top       = 166
1172:                 .Left      = 153
1173:                 .Width     = 87
1174:                 .Height    = 15
1175:                 .FontName  = "Tahoma"
1176:                 .FontSize  = 8
1177:                 .BackStyle = 0
1178:                 .ForeColor = RGB(90, 90, 90)
1179:                 .Visible   = .T.
1180:             ENDWITH
1181: 
1182:             loc_oAba.AddObject("txt_4c_AnaPes", "TextBox")
1183:             WITH loc_oAba.txt_4c_AnaPes
1184:                 .Value     = ""
1185:                 .Top       = 162
1186:                 .Left      = 247
1187:                 .Width     = 20
1188:                 .Height    = 23
1189:                 .MaxLength = 1
1190:                 .FontName  = "Tahoma"
1191:                 .FontSize  = 8
1192:                 .Visible   = .T.
1193:             ENDWITH
1194: 
1195:             loc_oAba.AddObject("lbl_4c_HintAnaPes", "Label")
1196:             WITH loc_oAba.lbl_4c_HintAnaPes
1197:                 .Caption   = "[1] Sim  [2] N" + CHR(227) + "o"
1198:                 .Top       = 166
1199:                 .Left      = 274
1200:                 .Width     = 74
1201:                 .Height    = 15
1202:                 .FontName  = "Tahoma"
1203:                 .FontSize  = 8
1204:                 .BackStyle = 0
1205:                 .ForeColor = RGB(90, 90, 90)
1206:                 .Visible   = .T.
1207:             ENDWITH
1208: 
1209:             *-- Tipo de Peso [1]=Normal [2]=Imagem Total (original top=188, label top=192)
1210:             loc_oAba.AddObject("lbl_4c_LabelTpPeso", "Label")
1211:             WITH loc_oAba.lbl_4c_LabelTpPeso
1212:                 .Caption   = "Tipo de Peso :"
1213:                 .Top       = 192
1214:                 .Left      = 172
1215:                 .Width     = 70
1216:                 .Height    = 15
1217:                 .FontName  = "Tahoma"
1218:                 .FontSize  = 8
1219:                 .BackStyle = 0
1220:                 .ForeColor = RGB(90, 90, 90)
1221:                 .Visible   = .T.
1222:             ENDWITH
1223: 
1224:             loc_oAba.AddObject("txt_4c_TpPesos", "TextBox")
1225:             WITH loc_oAba.txt_4c_TpPesos
1226:                 .Value     = ""
1227:                 .Top       = 188
1228:                 .Left      = 247
1229:                 .Width     = 20
1230:                 .Height    = 23
1231:                 .MaxLength = 1
1232:                 .FontName  = "Tahoma"
1233:                 .FontSize  = 8
1234:                 .Visible   = .T.
1235:             ENDWITH
1236: 
1237:             loc_oAba.AddObject("lbl_4c_HintTpPeso", "Label")
1238:             WITH loc_oAba.lbl_4c_HintTpPeso
1239:                 .Caption   = "[1] Normal  [2] Imagem Total"
1240:                 .Top       = 192
1241:                 .Left      = 274
1242:                 .Width     = 137
1243:                 .Height    = 15
1244:                 .FontName  = "Tahoma"
1245:                 .FontSize  = 8
1246:                 .BackStyle = 0
1247:                 .ForeColor = RGB(90, 90, 90)
1248:                 .Visible   = .T.
1249:             ENDWITH
1250: 
1251:             *-- Qtd Pecas por OF (original top=214, label top=218)
1252:             loc_oAba.AddObject("lbl_4c_LabelQtPcs", "Label")
1253:             WITH loc_oAba.lbl_4c_LabelQtPcs
1254:                 .Caption   = "Qtd Pe" + CHR(231) + "as por OF :"
1255:                 .Top       = 218
1256:                 .Left      = 148
1257:                 .Width     = 94
1258:                 .Height    = 15
1259:                 .FontName  = "Tahoma"
1260:                 .FontSize  = 8
1261:                 .BackStyle = 0
1262:                 .ForeColor = RGB(90, 90, 90)
1263:                 .Visible   = .T.
1264:             ENDWITH
1265: 
1266:             loc_oAba.AddObject("txt_4c_QtPcs", "TextBox")
1267:             WITH loc_oAba.txt_4c_QtPcs
1268:                 .Value     = 0
1269:                 .Top       = 214
1270:                 .Left      = 247
1271:                 .Width     = 58
1272:                 .Height    = 23
1273:                 .FontName  = "Tahoma"
1274:                 .FontSize  = 8
1275:                 .Visible   = .T.
1276:             ENDWITH
1277: 
1278:             *-- Bonus OptionGroup (original top=239, label top=242)
1279:             loc_oAba.AddObject("lbl_4c_LabelBonus", "Label")
1280:             WITH loc_oAba.lbl_4c_LabelBonus
1281:                 .Caption   = "B" + CHR(244) + "nus :"
1282:                 .Top       = 242
1283:                 .Left      = 204
1284:                 .Width     = 38
1285:                 .Height    = 15
1286:                 .FontName  = "Tahoma"
1287:                 .FontSize  = 8
1288:                 .BackStyle = 0
1289:                 .ForeColor = RGB(90, 90, 90)
1290:                 .Visible   = .T.
1291:             ENDWITH
1292: 
1293:             loc_oAba.AddObject("opt_4c_Bonus", "OptionGroup")
1294:             WITH loc_oAba.opt_4c_Bonus
1295:                 .ButtonCount = 2
1296:                 .Top         = 239
1297:                 .Left        = 243
1298:                 .Width       = 90
1299:                 .Height      = 20
1300:                 .BackStyle   = 0
1301:                 .BorderStyle = 0
1302:                 .Value       = 2
1303:                 .Visible     = .T.
1304:             ENDWITH
1305:             WITH loc_oAba.opt_4c_Bonus.Buttons(1)
1306:                 .Caption  = "Sim"
1307:                 .BackStyle = 0
1308:                 .Left     = 5
1309:                 .Top      = 3
1310:                 .Width    = 35
1311:                 .AutoSize = .F.
1312:                 .FontName = "Tahoma"
1313:                 .FontSize = 8
1314:                 .ForeColor = RGB(90, 90, 90)
1315:             ENDWITH
1316:             WITH loc_oAba.opt_4c_Bonus.Buttons(2)
1317:                 .Caption  = "N" + CHR(227) + "o"
1318:                 .BackStyle = 0
1319:                 .Left     = 42
1320:                 .Top      = 3
1321:                 .Width    = 38
1322:                 .AutoSize = .F.
1323:                 .FontName = "Tahoma"
1324:                 .FontSize = 8
1325:                 .ForeColor = RGB(90, 90, 90)
1326:             ENDWITH
1327: 
1328:             *-- Preco Fixo SubNivel por Operacao OptionGroup (original top=261, label top=264)
1329:             loc_oAba.AddObject("lbl_4c_LabelPreco", "Label")
1330:             WITH loc_oAba.lbl_4c_LabelPreco
1331:                 .Caption   = "Pre" + CHR(231) + "o Fixo SubN" + CHR(237) + "vel / Opera" + CHR(231) + CHR(227) + "o :"
1332:                 .Top       = 264
1333:                 .Left      = 55
1334:                 .Width     = 187
1335:                 .Height    = 15
1336:                 .FontName  = "Tahoma"
1337:                 .FontSize  = 8
1338:                 .BackStyle = 0
1339:                 .ForeColor = RGB(90, 90, 90)
1340:                 .Visible   = .T.
1341:             ENDWITH
1342: 
1343:             loc_oAba.AddObject("opt_4c_Preco", "OptionGroup")
1344:             WITH loc_oAba.opt_4c_Preco
1345:                 .ButtonCount = 2
1346:                 .Top         = 261
1347:                 .Left        = 243
1348:                 .Width       = 90
1349:                 .Height      = 20
1350:                 .BackStyle   = 0
1351:                 .BorderStyle = 0
1352:                 .Value       = 2
1353:                 .Visible     = .T.
1354:             ENDWITH
1355:             WITH loc_oAba.opt_4c_Preco.Buttons(1)
1356:                 .Caption  = "Sim"
1357:                 .BackStyle = 0
1358:                 .Left     = 5
1359:                 .Top      = 3
1360:                 .Width    = 35
1361:                 .AutoSize = .F.
1362:                 .FontName = "Tahoma"
1363:                 .FontSize = 8
1364:                 .ForeColor = RGB(90, 90, 90)
1365:             ENDWITH
1366:             WITH loc_oAba.opt_4c_Preco.Buttons(2)
1367:                 .Caption  = "N" + CHR(227) + "o"
1368:                 .BackStyle = 0
1369:                 .Left     = 42
1370:                 .Top      = 3
1371:                 .Width    = 38
1372:                 .AutoSize = .F.
1373:                 .FontName = "Tahoma"
1374:                 .FontSize = 8
1375:                 .ForeColor = RGB(90, 90, 90)
1376:             ENDWITH
1377: 
1378:             *-- Area de imagem da linha tecnica (Shape + Image + Botao selecionar)
1379:             loc_oAba.AddObject("shp_4c_Figura", "Shape")
1380:             WITH loc_oAba.shp_4c_Figura
1381:                 .Top           = 26
1382:                 .Left          = 598
1383:                 .Width         = 320
1384:                 .Height        = 193
1385:                 .FillStyle     = 1
1386:                 .SpecialEffect = 1
1387:                 .Visible       = .T.
1388:             ENDWITH
1389: 
1390:             loc_oAba.AddObject("img_4c_FigTec", "Image")
1391:             WITH loc_oAba.img_4c_FigTec
1392:                 .Top     = 27
1393:                 .Left    = 599
1394:                 .Width   = 318
1395:                 .Height  = 191
1396:                 .Stretch = 2
1397:                 .Visible = .T.
1398:             ENDWITH
1399: 
1400:             loc_oAba.AddObject("cmd_4c_CmdgFigura", "CommandButton")
1401:             WITH loc_oAba.cmd_4c_CmdgFigura
1402:                 .Caption         = ""
1403:                 .Top             = 180
1404:                 .Left            = 923
1405:                 .Width           = 40
1406:                 .Height          = 40
1407:                 .PicturePosition = 4
1408:                 .BackColor       = RGB(240, 240, 240)
1409:                 .Themes          = .T.

*-- Linhas 1417 a 1425:
1417:             BINDEVENT(loc_oAba.txt_4c_TpVendas,     "KeyPress", THIS, "ValidarTpVenda")
1418:             BINDEVENT(loc_oAba.txt_4c_AnaPes,       "KeyPress", THIS, "ValidarAnaPes")
1419:             BINDEVENT(loc_oAba.txt_4c_TpPesos,      "KeyPress", THIS, "ValidarTpPeso")
1420:             BINDEVENT(loc_oAba.cmd_4c_CmdgFigura,   "Click",     THIS, "CmdgFiguraClick")
1421: 
1422:         CATCH TO loException
1423:             MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarAbaGeral")
1424:         ENDTRY
1425:     ENDPROC

*-- Linhas 1583 a 1625:
1583:         TRY
1584:             loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
1585: 
1586:             loc_oAba.AddObject("cmd_4c_FaseInserir", "CommandButton")
1587:             WITH loc_oAba.cmd_4c_FaseInserir
1588:                 .Caption         = ""
1589:                 .Top             = 87
1590:                 .Left            = 942
1591:                 .Width           = 40
1592:                 .Height          = 40
1593:                 .PicturePosition = 4
1594:                 .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
1595:                 .ToolTipText     = "Inserir Fase"
1596:                 .Themes          = .T.
1597:                 .SpecialEffect   = 0
1598:                 .Visible         = .T.
1599:             ENDWITH
1600: 
1601:             loc_oAba.AddObject("cmd_4c_FaseExcluir", "CommandButton")
1602:             WITH loc_oAba.cmd_4c_FaseExcluir
1603:                 .Caption         = ""
1604:                 .Top             = 127
1605:                 .Left            = 942
1606:                 .Width           = 40
1607:                 .Height          = 40
1608:                 .PicturePosition = 4
1609:                 .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
1610:                 .ToolTipText     = "Excluir Fase"
1611:                 .Themes          = .T.
1612:                 .SpecialEffect   = 0
1613:                 .Visible         = .T.
1614:             ENDWITH
1615: 
1616:             loc_oAba.AddObject("cmd_4c_FaseAlternativa", "CommandButton")
1617:             WITH loc_oAba.cmd_4c_FaseAlternativa
1618:                 .Caption         = ""
1619:                 .Top             = 180
1620:                 .Left            = 942
1621:                 .Width           = 40
1622:                 .Height          = 40
1623:                 .PicturePosition = 4
1624:                 .Picture         = gc_4c_CaminhoIcones + "geral_copia_26.jpg"
1625:                 .ToolTipText     = "Fase Alternativa"

*-- Linhas 1632 a 1743:
1632:             loc_oAba.AddObject("grd_4c_Fases", "Grid")
1633:             loc_oAba.grd_4c_Fases.ColumnCount = 10
1634:             WITH loc_oAba.grd_4c_Fases
1635:                 .Top          = 7
1636:                 .Left         = 9
1637:                 .Width        = 926
1638:                 .Height       = 323
1639:                 .RecordSource = ""
1640:                 .GridLines    = 1
1641:                 .FontName     = "Verdana"
1642:                 .FontSize     = 8
1643:                 .Visible      = .T.
1644:                 .RecordMark   = .F.
1645:                 .DeleteMark   = .F.
1646:             ENDWITH
1647:             WITH loc_oAba.grd_4c_Fases.Column1
1648:                 .Width = 45
1649:                 .Header1.Caption = "Ordem"
1650:             ENDWITH
1651:             WITH loc_oAba.grd_4c_Fases.Column2
1652:                 .Width = 65
1653:                 .Header1.Caption = "Fase"
1654:             ENDWITH
1655:             WITH loc_oAba.grd_4c_Fases.Column3
1656:                 .Width = 175
1657:                 .ReadOnly = .T.
1658:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1659:             ENDWITH
1660:             WITH loc_oAba.grd_4c_Fases.Column4
1661:                 .Width          = 55
1662:                 .Sparse         = .F.
1663:                 .AddObject("Check1", "CheckBox")
1664:                 .Check1.Caption = ""
1665:                 .Check1.Alignment = 0
1666:                 .Check1.ReadOnly  = .F.
1667:                 .Check1.Visible   = .T.
1668:                 .Check1.Top       = 9
1669:                 .Check1.Left      = 2
1670:                 .Check1.Height    = 17
1671:                 .Check1.Width     = 22
1672:                 .CurrentControl = "Check1"
1673:                 .Header1.Caption = ""
1674:                 .AddObject("Check1", "CheckBox")
1675:                 WITH .Check1
1676:                     .Caption   = ""
1677:                     .Alignment = 0
1678:                     .ReadOnly  = .F.
1679:                     .Visible   = .T.
1680:                     .Top       = 9
1681:                     .Left      = 2
1682:                     .Height    = 17
1683:                     .Width     = 22
1684:                 ENDWITH
1685:             ENDWITH
1686:             WITH loc_oAba.grd_4c_Fases.Column5
1687:                 .Width = 90
1688:                 .Header1.Caption = "Conta"
1689:             ENDWITH
1690:             WITH loc_oAba.grd_4c_Fases.Column6
1691:                 .Width = 55
1692:                 .Header1.Caption = "Grp.Prod"
1693:             ENDWITH
1694:             WITH loc_oAba.grd_4c_Fases.Column7
1695:                 .Width = 40
1696:                 .Header1.Caption = "Dias"
1697:             ENDWITH
1698:             WITH loc_oAba.grd_4c_Fases.Column8
1699:                 .Width = 90
1700:                 .Header1.Caption = "Uni. Produtiva"
1701:             ENDWITH
1702:             WITH loc_oAba.grd_4c_Fases.Column9
1703:                 .Width = 100
1704:                 .Header1.Caption = "Usu" + CHR(225) + "rio"
1705:             ENDWITH
1706:             WITH loc_oAba.grd_4c_Fases.Column10
1707:                 .Width = 55
1708:                 .Header1.Caption = "G.Grupo"
1709:             ENDWITH
1710: 
1711:             *-- Label Observacao acima do EditBox (Say1 do legado, top=333)
1712:             loc_oAba.AddObject("lbl_4c_ObsFase", "Label")
1713:             WITH loc_oAba.lbl_4c_ObsFase
1714:                 .Caption  = "Observa" + CHR(231) + CHR(227) + "o"
1715:                 .Top      = 333
1716:                 .Left     = 10
1717:                 .AutoSize = .F.
1718:                 .Width    = 100
1719:                 .FontName = "Tahoma"
1720:                 .FontSize = 8
1721:                 .Visible  = .T.
1722:             ENDWITH
1723: 
1724:             *-- EditBox para Obs da fase selecionada
1725:             loc_oAba.AddObject("edt_4c_ObsFase", "EditBox")
1726:             WITH loc_oAba.edt_4c_ObsFase
1727:                 .Top      = 347
1728:                 .Left     = 9
1729:                 .Width    = 926
1730:                 .Height   = 102
1731:                 .FontName = "Tahoma"
1732:                 .FontSize = 8
1733:                 .Visible  = .T.
1734:             ENDWITH
1735: 
1736:             BINDEVENT(loc_oAba.cmd_4c_FaseInserir,           "Click",             THIS, "FaseBtnInserirClick")
1737:             BINDEVENT(loc_oAba.cmd_4c_FaseExcluir,           "Click",             THIS, "FaseBtnExcluirClick")
1738:             BINDEVENT(loc_oAba.cmd_4c_FaseAlternativa,       "Click",             THIS, "FaseBtnAlternativaClick")
1739:             BINDEVENT(loc_oAba.grd_4c_Fases,                 "KeyPress",          THIS, "GradFaseKeyPress")
1740:             BINDEVENT(loc_oAba.grd_4c_Fases,                 "AfterRowColChange", THIS, "GradFaseAfterRowColChange")
1741:             BINDEVENT(loc_oAba.edt_4c_ObsFase,               "KeyPress",         THIS, "FaseObsLostFocus")
1742:             BINDEVENT(loc_oAba.grd_4c_Fases.Column1.Text1,   "KeyPress",         THIS, "FaseOrdemLostFocus")
1743:             BINDEVENT(loc_oAba.grd_4c_Fases.Column4.Check1,  "Click",             THIS, "FaseAgregarClick")

*-- Linhas 1757 a 1784:
1757:             loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
1758: 
1759:             *-- Botoes para grd_4c_Composicao
1760:             loc_oAba.AddObject("cmd_4c_CompoInserir", "CommandButton")
1761:             WITH loc_oAba.cmd_4c_CompoInserir
1762:                 .Caption         = ""
1763:                 .Top             = 87
1764:                 .Left            = 949
1765:                 .Width           = 40
1766:                 .Height          = 40
1767:                 .PicturePosition = 4
1768:                 .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
1769:                 .ToolTipText     = "Inserir Composi" + CHR(231) + CHR(227) + "o"
1770:                 .Themes          = .T.
1771:                 .SpecialEffect   = 0
1772:                 .Visible         = .T.
1773:             ENDWITH
1774: 
1775:             loc_oAba.AddObject("cmd_4c_CompoExcluir", "CommandButton")
1776:             WITH loc_oAba.cmd_4c_CompoExcluir
1777:                 .Caption         = ""
1778:                 .Top             = 127
1779:                 .Left            = 949
1780:                 .Width           = 40
1781:                 .Height          = 40
1782:                 .PicturePosition = 4
1783:                 .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
1784:                 .ToolTipText     = "Excluir Composi" + CHR(231) + CHR(227) + "o"

*-- Linhas 1791 a 1971:
1791:             loc_oAba.AddObject("grd_4c_Composicao", "Grid")
1792:             loc_oAba.grd_4c_Composicao.ColumnCount = 9
1793:             WITH loc_oAba.grd_4c_Composicao
1794:                 .Top          = 9
1795:                 .Left         = 8
1796:                 .Width        = 938
1797:                 .Height       = 243
1798:                 .RecordSource = ""
1799:                 .GridLines    = 1
1800:                 .FontName     = "Verdana"
1801:                 .FontSize     = 8
1802:                 .Visible      = .T.
1803:                 .RecordMark   = .F.
1804:                 .DeleteMark   = .F.
1805:             ENDWITH
1806:             WITH loc_oAba.grd_4c_Composicao.Column1
1807:                 .Width = 100
1808:                 .Header1.Caption = "Consumo"
1809:             ENDWITH
1810:             WITH loc_oAba.grd_4c_Composicao.Column2
1811:                 .Width = 195
1812:                 .ReadOnly = .T.
1813:                 .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1814:             ENDWITH
1815:             WITH loc_oAba.grd_4c_Composicao.Column3
1816:                 .Width = 55
1817:                 .Header1.Caption = "Uni"
1818:             ENDWITH
1819:             WITH loc_oAba.grd_4c_Composicao.Column4
1820:                 .Width = 80
1821:                 .Header1.Caption = "Valor"
1822:             ENDWITH
1823:             WITH loc_oAba.grd_4c_Composicao.Column5
1824:                 .Width = 80
1825:                 .Header1.Caption = "Qtde"
1826:             ENDWITH
1827:             WITH loc_oAba.grd_4c_Composicao.Column6
1828:                 .Width = 80
1829:                 .Header1.Caption = "Total"
1830:             ENDWITH
1831:             WITH loc_oAba.grd_4c_Composicao.Column7
1832:                 .Width = 55
1833:                 .Header1.Caption = "Moe"
1834:             ENDWITH
1835:             WITH loc_oAba.grd_4c_Composicao.Column8
1836:                 .Width = 100
1837:                 .Header1.Caption = "Observa" + CHR(231) + CHR(227) + "o"
1838:             ENDWITH
1839:             WITH loc_oAba.grd_4c_Composicao.Column9
1840:                 .Width = 55
1841:                 .Header1.Caption = "Etiq"
1842:             ENDWITH
1843: 
1844:             *-- Campo desc do produto selecionado na composicao (Get_Desc do legado)
1845:             loc_oAba.AddObject("lbl_4c_LabelCompoDesc", "Label")
1846:             WITH loc_oAba.lbl_4c_LabelCompoDesc
1847:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
1848:                 .Top       = 260
1849:                 .Left      = 8
1850:                 .Width     = 122
1851:                 .Height    = 15
1852:                 .FontName  = "Tahoma"
1853:                 .FontSize  = 8
1854:                 .BackStyle = 0
1855:                 .ForeColor = RGB(90, 90, 90)
1856:                 .Visible   = .T.
1857:             ENDWITH
1858: 
1859:             loc_oAba.AddObject("txt_4c_CompoDesc", "TextBox")
1860:             WITH loc_oAba.txt_4c_CompoDesc
1861:                 .Value    = ""
1862:                 .Top      = 256
1863:                 .Left     = 135
1864:                 .Width    = 290
1865:                 .Height   = 23
1866:                 .ReadOnly = .T.
1867:                 .FontName = "Tahoma"
1868:                 .FontSize = 8
1869:                 .Visible  = .T.
1870:             ENDWITH
1871: 
1872:             *-- Titulo da secao Composicao Obrigatoria
1873:             loc_oAba.AddObject("lbl_4c_CompoObrig", "Label")
1874:             WITH loc_oAba.lbl_4c_CompoObrig
1875:                 .Caption   = "Composi" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria"
1876:                 .Top       = 288
1877:                 .Left      = 11
1878:                 .Width     = 200
1879:                 .Height    = 15
1880:                 .FontName  = "Tahoma"
1881:                 .FontSize  = 8
1882:                 .FontBold  = .T.
1883:                 .BackStyle = 0
1884:                 .Visible   = .T.
1885:             ENDWITH
1886: 
1887:             *-- Botoes para grd_4c_CompObrig
1888:             loc_oAba.AddObject("cmd_4c_CompObrigInserir", "CommandButton")
1889:             WITH loc_oAba.cmd_4c_CompObrigInserir
1890:                 .Caption         = ""
1891:                 .Top             = 100
1892:                 .Left            = 942
1893:                 .Width           = 40
1894:                 .Height          = 40
1895:                 .PicturePosition = 4
1896:                 .Picture         = gc_4c_CaminhoIcones + "geral_inserir_26.jpg"
1897:                 .ToolTipText     = "Inserir Comp. Obrigat" + CHR(243) + "ria"
1898:                 .Themes          = .T.
1899:                 .SpecialEffect   = 0
1900:                 .Visible         = .T.
1901:             ENDWITH
1902: 
1903:             loc_oAba.AddObject("cmd_4c_CompObrigExcluir", "CommandButton")
1904:             WITH loc_oAba.cmd_4c_CompObrigExcluir
1905:                 .Caption         = ""
1906:                 .Top             = 140
1907:                 .Left            = 942
1908:                 .Width           = 40
1909:                 .Height          = 40
1910:                 .PicturePosition = 4
1911:                 .Picture         = gc_4c_CaminhoIcones + "geral_excluir_26.jpg"
1912:                 .ToolTipText     = "Excluir Comp. Obrigat" + CHR(243) + "ria"
1913:                 .Themes          = .T.
1914:                 .SpecialEffect   = 0
1915:                 .Visible         = .T.
1916:             ENDWITH
1917: 
1918:             *-- Grid de Composicao Obrigatoria: ColumnCount ANTES do WITH (Problema 36)
1919:             loc_oAba.AddObject("grd_4c_CompObrig", "Grid")
1920:             loc_oAba.grd_4c_CompObrig.ColumnCount = 4
1921:             WITH loc_oAba.grd_4c_CompObrig
1922:                 .Top          = 304
1923:                 .Left         = 11
1924:                 .Width        = 336
1925:                 .Height       = 147
1926:                 .RecordSource = ""
1927:                 .GridLines    = 1
1928:                 .FontName     = "Verdana"
1929:                 .FontSize     = 8
1930:                 .Visible      = .T.
1931:                 .RecordMark   = .F.
1932:                 .DeleteMark   = .F.
1933:             ENDWITH
1934:             WITH loc_oAba.grd_4c_CompObrig.Column1
1935:                 .Width = 80
1936:                 .Header1.Caption = "Componente A"
1937:             ENDWITH
1938:             WITH loc_oAba.grd_4c_CompObrig.Column2
1939:                 .Width = 55
1940:                 .Header1.Caption = "G.Grupo"
1941:             ENDWITH
1942:             WITH loc_oAba.grd_4c_CompObrig.Column3
1943:                 .Width = 55
1944:                 .Header1.Caption = "Grupo"
1945:             ENDWITH
1946:             WITH loc_oAba.grd_4c_CompObrig.Column4
1947:                 .Width = 80
1948:                 .Header1.Caption = "Componente B"
1949:             ENDWITH
1950: 
1951:             BINDEVENT(loc_oAba.cmd_4c_CompoInserir,     "Click",             THIS, "CompoBtnInserirClick")
1952:             BINDEVENT(loc_oAba.cmd_4c_CompoExcluir,     "Click",             THIS, "CompoBtnExcluirClick")
1953:             BINDEVENT(loc_oAba.grd_4c_Composicao,       "KeyPress",          THIS, "GrdCompoKeyPress")
1954:             BINDEVENT(loc_oAba.grd_4c_Composicao,       "AfterRowColChange", THIS, "GrdCompoAfterRowColChange")
1955:             BINDEVENT(loc_oAba.cmd_4c_CompObrigInserir, "Click",             THIS, "CompObrigBtnInserirClick")
1956:             BINDEVENT(loc_oAba.cmd_4c_CompObrigExcluir, "Click",             THIS, "CompObrigBtnExcluirClick")
1957:             BINDEVENT(loc_oAba.grd_4c_CompObrig,        "KeyPress",          THIS, "GrdProKeyPress")
1958: 
1959:         CATCH TO loException
1960:             MsgErro("Erro: " + loException.Message, "FormLin.ConfigurarAbaComposicao")
1961:         ENDTRY
1962:     ENDPROC
1963: 
1964:     *==========================================================================
1965:     * FaseBtnInserirClick - Insere nova linha vazia na grade de Fases
1966:     *==========================================================================
1967:     PROCEDURE FaseBtnInserirClick()
1968:         LOCAL loc_oGrd, loc_nNovaOrdem, loc_cLinhas
1969:         TRY
1970:             IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1971:                 RETURN

*-- Linhas 2916 a 2933:
2916:                     loc_oGrd.Column8.ControlSource    = "cursor_4c_Fases.UniPrdts"
2917:                     loc_oGrd.Column9.ControlSource    = "cursor_4c_Fases.Usuars"
2918:                     loc_oGrd.Column10.ControlSource   = "cursor_4c_Fases.Mercs"
2919:                     loc_oGrd.Column1.Header1.Caption  = "Ordem"
2920:                     loc_oGrd.Column2.Header1.Caption  = "Fase"
2921:                     loc_oGrd.Column3.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2922:                     loc_oGrd.Column4.Header1.Caption  = ""
2923:                     loc_oGrd.Column5.Header1.Caption  = "Conta"
2924:                     loc_oGrd.Column6.Header1.Caption  = "Grp.Prod"
2925:                     loc_oGrd.Column7.Header1.Caption  = "Dias"
2926:                     loc_oGrd.Column8.Header1.Caption  = "Uni. Produtiva"
2927:                     loc_oGrd.Column9.Header1.Caption  = "Usu" + CHR(225) + "rio"
2928:                     loc_oGrd.Column10.Header1.Caption = "G.Grupo"
2929:                     loc_oGrd.Refresh()
2930:                 ENDIF
2931:             ENDIF
2932: 
2933:             *-- Grade de Composicao

*-- Linhas 2945 a 2961:
2945:                     loc_oGrd.Column7.ControlSource    = "cursor_4c_Composicao.Moeds"
2946:                     loc_oGrd.Column8.ControlSource    = "cursor_4c_Composicao.ObsCompos"
2947:                     loc_oGrd.Column9.ControlSource    = "cursor_4c_Composicao.Etiqs"
2948:                     loc_oGrd.Column1.Header1.Caption  = "Consumo"
2949:                     loc_oGrd.Column2.Header1.Caption  = "Descri" + CHR(231) + CHR(227) + "o"
2950:                     loc_oGrd.Column3.Header1.Caption  = "Uni"
2951:                     loc_oGrd.Column4.Header1.Caption  = "Valor"
2952:                     loc_oGrd.Column5.Header1.Caption  = "Qtde"
2953:                     loc_oGrd.Column6.Header1.Caption  = "Total"
2954:                     loc_oGrd.Column7.Header1.Caption  = "Moe"
2955:                     loc_oGrd.Column8.Header1.Caption  = "Observa" + CHR(231) + CHR(227) + "o"
2956:                     loc_oGrd.Column9.Header1.Caption  = "Etiq"
2957:                     loc_oGrd.Refresh()
2958:                 ENDIF
2959:             ENDIF
2960: 
2961:             *-- Grade de Composicao Obrigatoria

*-- Linhas 2968 a 2979:
2968:                     loc_oGrd.Column2.ControlSource   = "cursor_4c_CompObrig.Cgrus"
2969:                     loc_oGrd.Column3.ControlSource   = "cursor_4c_CompObrig.Mercs"
2970:                     loc_oGrd.Column4.ControlSource   = "cursor_4c_CompObrig.Mat2s"
2971:                     loc_oGrd.Column1.Header1.Caption = "Componente A"
2972:                     loc_oGrd.Column2.Header1.Caption = "G.Grupo"
2973:                     loc_oGrd.Column3.Header1.Caption = "Grupo"
2974:                     loc_oGrd.Column4.Header1.Caption = "Componente B"
2975:                     loc_oGrd.Refresh()
2976:                 ENDIF
2977:             ENDIF
2978: 
2979:             loc_lResultado = .T.


### BO (C:\4c\projeto\app\classes\LinBO.prg):
*==============================================================================
* LinBO.prg - Business Object para Cadastro de Linhas de Producao
* Tabela principal: SigCdLin  (PK: linhas char 10)
* Tabelas auxiliares: SigCdLnf (Fases), SigCdLni (Composicao), SigPrPrc (Comp. Obrigatoria)
*==============================================================================

DEFINE CLASS LinBO AS BusinessBase

    *-- Identificacao / Chave primaria
    this_cLinhas      = ""    && char(10)  Codigo da Linha de Producao (PK)

    *-- Descricao
    this_cDescs       = ""    && char(40)  Descricao da Linha

    *-- Codigo de coluna (campo oculto no form, usado internamente)
    this_cCodCols     = ""    && char(1)   Codigo de Coluna (codcols)

    *-- Pedido de estoque minimo - lookup em SigCdOpe (Dopes)
    this_cPedidos     = ""    && char(20)  Codigo da Operacao (FK SigCdOpe.Dopes)

    *-- Tipos de classificacao (char "1" ou "2")
    this_cTpCustos    = ""    && char(1)   Tipo de Custo  (1=Unitario / 2=Por Peso)
    this_cTpVendas    = ""    && char(1)   Tipo de Venda  (1=Unitario / 2=Por Peso)
    this_cTpPesos     = ""    && char(1)   Tipo de Peso   (1=Normal   / 2=Imagem Total)

    *-- Campos numericos de configuracao
    this_nTeors       = 0     && numeric(4,0)  Teor
    this_nBReservas   = 0     && numeric(5,2)  Base de Reservas (%)
    this_nQtPcs       = 0     && numeric(5,0)  Qtd Pecas por OF
    this_nChkPesags   = 0     && numeric(1,0)  Analisa Pesagem (1=Sim / 2=Nao)
    this_nIds         = 0     && numeric(10,0) ID interno (auto)
    this_nBonus       = 0     && numeric(1,0)  Bonus (OptionGroup fwoption1)
    this_nGerNEtiqs   = 0     && numeric(1,0)  Gerar N/Etiqs (oculto - optGerNEtiqs)
    this_nVlrFixos    = 0     && numeric(1,0)  Preco Fixo SubNivel Por Operacao (Opt_Preco)

    *-- Figura Tecnica (blob JPEG armazenado como text no banco)
    this_cFigJpgs     = ""    && text          Imagem da Figura Tecnica (figjpgs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdLin"
        THIS.this_cCampoChave = "linhas"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cLinhas
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cLinhas     = TratarNulo(linhas,     "C")
                THIS.this_cDescs      = TratarNulo(descs,      "C")
                THIS.this_cCodCols    = TratarNulo(codcols,    "C")
                THIS.this_cPedidos    = TratarNulo(pedidos,    "C")
                THIS.this_cTpCustos   = TratarNulo(tpcustos,   "C")
                THIS.this_cTpVendas   = TratarNulo(tpvendas,   "C")
                THIS.this_cTpPesos    = TratarNulo(tppesos,    "C")
                THIS.this_nTeors      = TratarNulo(teors,      "N")
                THIS.this_nBReservas  = TratarNulo(breservas,  "N")
                THIS.this_nQtPcs      = TratarNulo(qtpcs,      "N")
                THIS.this_nChkPesags  = TratarNulo(chkpesags,  "N")
                THIS.this_nIds        = TratarNulo(ids,        "N")
                THIS.this_nBonus      = TratarNulo(bonus,      "N")
                THIS.this_nGerNEtiqs  = TratarNulo(gernetiqs,  "N")
                THIS.this_nVlrFixos   = TratarNulo(vlrfixos,   "N")
                THIS.this_cFigJpgs    = TratarNulo(figjpgs,    "C")
                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar cursor: " + loException.Message, "LinBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista todas as linhas de producao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT linhas, descs, tpcustos, tpvendas" + ;
                       " FROM SigCdLin" + ;
                       " ORDER BY linhas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar linhas: " + CapturarErroSQL(), "LinBO.Buscar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo da linha
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cLinhas))
            RETURN .F.
        ENDIF

        TRY

            loc_cSQL = "SELECT linhas, descs, codcols, pedidos," + ;
                       " tpcustos, tpvendas, tppesos," + ;
                       " teors, breservas, qtpcs, chkpesags," + ;
                       " ids, bonus, gernetiqs, vlrfixos, figjpgs" + ;
                       " FROM SigCdLin" + ;
                       " WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar linha: " + CapturarErroSQL(), "LinBO.CarregarPorCodigo")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLin
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdLin" + ;
                       " (linhas, descs, codcols, pedidos," + ;
                       " tpcustos, tpvendas, tppesos," + ;
                       " teors, breservas, qtpcs, chkpesags," + ;
                       " ids, bonus, gernetiqs, vlrfixos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cLinhas)    + ", " + ;
                       EscaparSQL(THIS.this_cDescs)     + ", " + ;
                       EscaparSQL(THIS.this_cCodCols)   + ", " + ;
                       EscaparSQL(THIS.this_cPedidos)   + ", " + ;
                       EscaparSQL(THIS.this_cTpCustos)  + ", " + ;
                       EscaparSQL(THIS.this_cTpVendas)  + ", " + ;
                       EscaparSQL(THIS.this_cTpPesos)   + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTeors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBReservas)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtPcs)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkPesags)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nIds)        + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBonus)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nGerNEtiqs)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nVlrFixos)   + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir linha: " + CapturarErroSQL(), "LinBO.Inserir")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdLin
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdLin SET" + ;
                       " descs       = " + EscaparSQL(THIS.this_cDescs)     + ", " + ;
                       " codcols     = " + EscaparSQL(THIS.this_cCodCols)   + ", " + ;
                       " pedidos     = " + EscaparSQL(THIS.this_cPedidos)   + ", " + ;
                       " tpcustos    = " + EscaparSQL(THIS.this_cTpCustos)  + ", " + ;
                       " tpvendas    = " + EscaparSQL(THIS.this_cTpVendas)  + ", " + ;
                       " tppesos     = " + EscaparSQL(THIS.this_cTpPesos)   + ", " + ;
                       " teors       = " + FormatarNumeroSQL(THIS.this_nTeors)     + ", " + ;
                       " breservas   = " + FormatarNumeroSQL(THIS.this_nBReservas) + ", " + ;
                       " qtpcs       = " + FormatarNumeroSQL(THIS.this_nQtPcs)     + ", " + ;
                       " chkpesags   = " + FormatarNumeroSQL(THIS.this_nChkPesags) + ", " + ;
                       " bonus       = " + FormatarNumeroSQL(THIS.this_nBonus)     + ", " + ;
                       " gernetiqs   = " + FormatarNumeroSQL(THIS.this_nGerNEtiqs) + ", " + ;
                       " vlrfixos    = " + FormatarNumeroSQL(THIS.this_nVlrFixos)  + ;
                       " WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar linha: " + CapturarErroSQL(), "LinBO.Atualizar")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdLin + cascata em SigCdLnf/SigCdLni/SigPrPrc
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir fases da linha
            loc_cSQL = "DELETE FROM SigCdLnf WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir composicao de insumos
            loc_cSQL = "DELETE FROM SigCdLni WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir composicao obrigatoria
            loc_cSQL = "DELETE FROM SigPrPrc WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Excluir a linha principal
            loc_cSQL = "DELETE FROM SigCdLin WHERE linhas = " + EscaparSQL(THIS.this_cLinhas)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir linha: " + CapturarErroSQL(), "LinBO.ExecutarExclusao")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Override: salva registro principal + tabelas de detalhe
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF DODEFAULT()
                loc_lResultado = THIS.SalvarFases(THIS.this_cLinhas)
                IF loc_lResultado
                    loc_lResultado = THIS.SalvarComposicao(THIS.this_cLinhas)
                ENDIF
                IF loc_lResultado
                    loc_lResultado = THIS.SalvarComposicaoObrigatoria(THIS.this_cLinhas)
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.Salvar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFases - Popula cursor_4c_Fases (SigCdLnf + descricao SigCdGcr)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarFases(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Fases")
            USE IN cursor_4c_Fases
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_Fases ;
                    (Linhas C(10), Ordems N(2,0), Ordem2 N(3,0), Grupos C(10), ;
                     Descrs C(40), Agregas L, Contas C(10), Cgrus C(3), ;
                     Ndias N(2,0), UniPrdts C(10), Usuars C(10), Mercs C(3), Obs M)
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.ordems, a.ordem2, a.grupos," + ;
                           " ISNULL(b.descrs,'') AS descrs, a.agregas," + ;
                           " a.contas, a.cgrus, a.ndias, a.uniprdts, a.usuars," + ;
                           " a.mercs, a.obs" + ;
                           " FROM SigCdLnf a" + ;
                           " LEFT JOIN SigCdGcr b ON b.codigos = a.grupos" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas)) + ;
                           " ORDER BY a.ordems, a.ordem2"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FasesLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Fases ;
                        (Linhas C(10), Ordems N(2,0), Ordem2 N(3,0), Grupos C(10), ;
                         Descrs C(40), Agregas L, Contas C(10), Cgrus C(3), ;
                         Ndias N(2,0), UniPrdts C(10), Usuars C(10), Mercs C(3), Obs M)
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_FasesLoad") > 0
                        APPEND FROM DBF("cursor_4c_FasesLoad")
                    ENDIF
                    GO TOP IN cursor_4c_Fases

                    IF USED("cursor_4c_FasesLoad")
                        USE IN cursor_4c_FasesLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar fases: " + CapturarErroSQL(), "LinBO.BuscarFases")
                    IF USED("cursor_4c_FasesLoad")
                        USE IN cursor_4c_FasesLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarFases")
            IF USED("cursor_4c_FasesLoad")
                USE IN cursor_4c_FasesLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicao - Popula cursor_4c_Composicao (SigCdLni)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicao(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Composicao")
            USE IN cursor_4c_Composicao
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_Composicao ;
                    (Linhas C(10), Mats C(14), Dcompos C(30), UniCompos C(3), ;
                     Pcompos N(11,3), Qtds N(8,3), Totas N(11,3), ;
                     Moeds C(3), ObsCompos C(10), Etiqs C(1))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.mats, a.dcompos, a.unicompos," + ;
                           " a.pcompos, a.qtds, a.totas, a.moeds, a.obscompos, a.etiqs" + ;
                           " FROM SigCdLni a" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas)) + ;
                           " ORDER BY a.ordems, a.ordcompos"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompoLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Composicao ;
                        (Linhas C(10), Mats C(14), Dcompos C(30), UniCompos C(3), ;
                         Pcompos N(11,3), Qtds N(8,3), Totas N(11,3), ;
                         Moeds C(3), ObsCompos C(10), Etiqs C(1))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_CompoLoad") > 0
                        APPEND FROM DBF("cursor_4c_CompoLoad")
                    ENDIF
                    GO TOP IN cursor_4c_Composicao

                    IF USED("cursor_4c_CompoLoad")
                        USE IN cursor_4c_CompoLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.BuscarComposicao")
                    IF USED("cursor_4c_CompoLoad")
                        USE IN cursor_4c_CompoLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarComposicao")
            IF USED("cursor_4c_CompoLoad")
                USE IN cursor_4c_CompoLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCompObrig - Popula cursor_4c_CompObrig (SigPrPrc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCompObrig(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_CompObrig")
            USE IN cursor_4c_CompObrig
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cLinhas))
                SET NULL ON
                CREATE CURSOR cursor_4c_CompObrig ;
                    (Linhas C(10), Mat1s C(14), Cgrus C(3), Mercs C(3), Mat2s C(14))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT a.linhas, a.mat1s, a.cgrus, a.mercs, a.mat2s" + ;
                           " FROM SigPrPrc a" + ;
                           " WHERE a.linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CompLoad")

                IF loc_nResultado >= 0
                    SET NULL ON
                    CREATE CURSOR cursor_4c_CompObrig ;
                        (Linhas C(10), Mat1s C(14), Cgrus C(3), Mercs C(3), Mat2s C(14))
                    SET NULL OFF

                    IF RECCOUNT("cursor_4c_CompLoad") > 0
                        APPEND FROM DBF("cursor_4c_CompLoad")
                    ENDIF
                    GO TOP IN cursor_4c_CompObrig

                    IF USED("cursor_4c_CompLoad")
                        USE IN cursor_4c_CompLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.BuscarCompObrig")
                    IF USED("cursor_4c_CompLoad")
                        USE IN cursor_4c_CompLoad
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.BuscarCompObrig")
            IF USED("cursor_4c_CompLoad")
                USE IN cursor_4c_CompLoad
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarFases - Persiste cursor_4c_Fases em SigCdLnf (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarFases(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_Fases")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdLnf WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar fases: " + CapturarErroSQL(), "LinBO.SalvarFases")
            ELSE
                SELECT cursor_4c_Fases
                GO TOP
                DO WHILE !EOF("cursor_4c_Fases") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_cChave = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdLnf" + ;
                                   " (cidchaves, linhas, ordems, ordem2, grupos, cgrus, mercs," + ;
                                   "  contas, ndias, uniprdts, usuars, agregas, obs, matprdts, etiquetas)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                                   + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                         + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ordems)               + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ordem2)               + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Grupos))             + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Cgrus))              + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Mercs))              + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Contas))             + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Fases.Ndias)                + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.UniPrdts))           + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Fases.Usuars))             + ", " + ;
                                   IIF(NVL(cursor_4c_Fases.Agregas, .F.), "1", "0")       + ", " + ;
                                   EscaparSQL(ALLTRIM(NVL(cursor_4c_Fases.Obs, "")))       + ", " + ;
                                   EscaparSQL("")                                           + ", " + ;
                                   "0)"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar fase: " + CapturarErroSQL(), "LinBO.SalvarFases")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarFases")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarComposicao - Persiste cursor_4c_Composicao em SigCdLni (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarComposicao(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave, loc_nOrdem
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_Composicao")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdLni WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.SalvarComposicao")
            ELSE
                SELECT cursor_4c_Composicao
                GO TOP
                loc_nOrdem = 0
                DO WHILE !EOF("cursor_4c_Composicao") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_nOrdem  = loc_nOrdem + 1
                        loc_cChave  = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigCdLni" + ;
                                   " (cidchaves, linhas, mats, cpros, dcompos, unicompos," + ;
                                   "  pcompos, qtds, totas, moeds, obscompos, etiqs," + ;
                                   "  cats, cgrus, compos, dscgrp, grupos, ordems, ordcompos," + ;
                                   "  qtdcvs, qtscons, vlrcvs, cunips, pesos)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                                           + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                                 + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Mats))                  + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Mats))                  + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Dcompos))               + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.UniCompos))             + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Pcompos)                 + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Qtds)                    + ", " + ;
                                   FormatarNumeroSQL(cursor_4c_Composicao.Totas)                   + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Moeds))                 + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.ObsCompos))             + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Composicao.Etiqs))                 + ", " + ;
                                   "'', '', '', '', '', " + ;
                                   FormatarNumeroSQL(loc_nOrdem)                                    + ", " + ;
                                   FormatarNumeroSQL(loc_nOrdem)                                    + ", " + ;
                                   "0, 0, 0, '', 0)"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar item composi" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL(), "LinBO.SalvarComposicao")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarComposicao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarComposicaoObrigatoria - Persiste cursor_4c_CompObrig em SigPrPrc (DELETE + re-INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarComposicaoObrigatoria(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lErroLoop, loc_cChave
        loc_lSucesso  = .F.
        loc_lErroLoop = .F.

        IF !USED("cursor_4c_CompObrig")
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigPrPrc WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao limpar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.SalvarComposicaoObrigatoria")
            ELSE
                SELECT cursor_4c_CompObrig
                GO TOP
                DO WHILE !EOF("cursor_4c_CompObrig") AND !loc_lErroLoop
                    IF !DELETED()
                        loc_cChave = LEFT(fUniqueIds(), 20)
                        loc_cSQL = "INSERT INTO SigPrPrc" + ;
                                   " (cidchaves, linhas, mat1s, mat2s, cgrus, mercs)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(loc_cChave)                               + ", " + ;
                                   EscaparSQL(ALLTRIM(par_cLinhas))                     + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mat1s))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mat2s))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Cgrus))      + ", " + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_CompObrig.Mercs))      + ")"

                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar comp. obrigat" + CHR(243) + "ria: " + CapturarErroSQL(), "LinBO.SalvarComposicaoObrigatoria")
                            loc_lErroLoop = .T.
                        ENDIF
                    ENDIF
                    IF !loc_lErroLoop
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lErroLoop
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.SalvarComposicaoObrigatoria")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMateriasPrimas - Carrega cursor crMtPrima para lookups inline do grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMateriasPrimas()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cpros AS CPros, a.descs AS DPros, a.cgrus AS CGrus" + ;
                       " FROM SigCdPro a" + ;
                       " ORDER BY a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMtPrima")

            IF loc_nResultado >= 0
                IF USED("crMtPrima")
                    SELECT crMtPrima
                    INDEX ON CPros TAG CPros
                    INDEX ON DPros TAG DPros
                    GO TOP IN crMtPrima
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar materias primas: " + CapturarErroSQL(), "LinBO.CarregarMateriasPrimas")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarMateriasPrimas")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarGruposContaCorrente - Carrega cursor crSigCdGcr para lookup inline
    *--------------------------------------------------------------------------
    PROCEDURE CarregarGruposContaCorrente()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr ORDER BY Codigos"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGcr")

            IF loc_nResultado >= 0
                IF USED("crSigCdGcr")
                    SELECT crSigCdGcr
                    INDEX ON Codigos TAG Codigos
                    GO TOP IN crSigCdGcr
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar grupos: " + CapturarErroSQL(), "LinBO.CarregarGruposContaCorrente")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.CarregarGruposContaCorrente")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLinhaExistente - Verifica se codigo de linha ja existe (para INCLUIR)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLinhaExistente(par_cLinhas)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 linhas FROM SigCdLin" + ;
                       " WHERE linhas = " + EscaparSQL(ALLTRIM(par_cLinhas))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaLin")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValidaLin") > 0
                loc_lExiste = .T.
            ENDIF

            IF USED("cursor_4c_ValidaLin")
                USE IN cursor_4c_ValidaLin
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "LinBO.ValidarLinhaExistente")
            IF USED("cursor_4c_ValidaLin")
                USE IN cursor_4c_ValidaLin
            ENDIF
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresAuxiliares - Fecha cursores de sub-tabelas quando form fecha
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresAuxiliares()
        IF USED("cursor_4c_Fases")
            USE IN cursor_4c_Fases
        ENDIF
        IF USED("cursor_4c_Composicao")
            USE IN cursor_4c_Composicao
        ENDIF
        IF USED("cursor_4c_CompObrig")
            USE IN cursor_4c_CompObrig
        ENDIF
        IF USED("crMtPrima")
            USE IN crMtPrima
        ENDIF
        IF USED("crSigCdGcr")
            USE IN crSigCdGcr
        ENDIF
    ENDPROC

ENDDEFINE

