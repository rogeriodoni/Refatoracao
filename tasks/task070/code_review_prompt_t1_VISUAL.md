# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 264: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 287: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 319: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 342: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReCsp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1954 linhas total):

*-- Linhas 23 a 31:
23: *   - Init() / InicializarForm() / Destroy()
24: *   - ConfigurarCabecalho() - header escuro com titulo
25: *   - ConfigurarBotoesRelatorio() - cmg_4c_Botoes (Visualizar/Imprimir/Excel/Encerrar)
26: *   - ConfigurarBotoesAcao() - cmd_4c_Processar + cmd_4c_Movimento
27: *   - LimparCampos() - inicializa valores do BO nos campos de filtro
28: *   - FormParaRelatorio() - transfere campos do form para o BO
29: *   - ProcessarClick() - executa query e popula grid
30: *   - MovimentoClick() - abre SigMvExp com registro selecionado
31: *   - BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnSairClick

*-- Linhas 68 a 76:
68:         loc_lSucesso   = .F.
69:         loc_lContinuar = .T.
70:         TRY
71:             THIS.Caption = "Pesquisa opera" + CHR(231) + CHR(245) + "es"
72: 
73:             IF TYPE("gc_4c_CaminhoIcones") = "U"
74:                 gc_4c_CaminhoIcones = ""
75:             ENDIF
76:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 113 a 132:
113:                 *-- Campos de filtro - Fase 5: Empresa, Periodo, Mov/Nr/Doc
114:                 THIS.ConfigurarPaginaDados()
115: 
116:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
117:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
118: 
119:                 *-- Vincular clicks dos botoes de relatorio (cmg_4c_Botoes)
120:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
121:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
122:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
123:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
124: 
125:                 *-- Vincular clicks dos botoes de acao
126:                 BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "ProcessarClick")
127:                 BINDEVENT(THIS.cmd_4c_Movimento, "Click", THIS, "MovimentoClick")
128: 
129:                 *-- Valores iniciais dos campos de filtro
130:                 THIS.LimparCampos()
131: 
132:                 THIS.Visible = .T.

*-- Linhas 149 a 226:
149:     PROTECTED PROCEDURE ConfigurarCabecalho()
150:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH THIS.cnt_4c_Cabecalho
152:             .Top         = 0
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 80
156:             .BackStyle   = 1
157:             .BackColor   = RGB(100, 100, 100)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160: 
161:             *-- Sombra (deslocada 2px para efeito 3D do texto branco)
162:             .AddObject("lbl_4c_Sombra", "Label")
163:             WITH .lbl_4c_Sombra
164:                 .Top       = 22
165:                 .Left      = 22
166:                 .Width     = THIS.Width
167:                 .Height    = 30
168:                 .Caption   = "Pesquisa opera" + CHR(231) + CHR(245) + "es"
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 14
171:                 .FontBold  = .T.
172:                 .ForeColor = RGB(0, 0, 0)
173:                 .BackStyle = 0
174:                 .Visible   = .T.
175:             ENDWITH
176: 
177:             *-- Titulo em branco (sobre a sombra)
178:             .AddObject("lbl_4c_Titulo", "Label")
179:             WITH .lbl_4c_Titulo
180:                 .Top       = 20
181:                 .Left      = 20
182:                 .Width     = THIS.Width
183:                 .Height    = 30
184:                 .Caption   = "Pesquisa opera" + CHR(231) + CHR(245) + "es"
185:                 .FontName  = "Tahoma"
186:                 .FontSize  = 14
187:                 .FontBold  = .T.
188:                 .ForeColor = RGB(255, 255, 255)
189:                 .BackStyle = 0
190:                 .Visible   = .T.
191:             ENDWITH
192:         ENDWITH
193:     ENDPROC
194: 
195:     *--------------------------------------------------------------------------
196:     * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes (btnReport legado)
197:     *   Original: btnReport.Left=528, Top=-1, Width=273, Height=80
198:     *   Botoes: Visualiza(5), Imprime(71), DocExcel(137), Sair(203) - W=65 cada
199:     *--------------------------------------------------------------------------
200:     PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
201:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
202:         WITH THIS.cmg_4c_Botoes
203:             .Top           = 0
204:             .Left          = 529
205:             .Width         = 273
206:             .Height        = 80
207:             .ButtonCount   = 4
208:             .BackStyle     = 0
209:             .BorderStyle   = 0
210:             .BorderColor   = RGB(136, 189, 188)
211:             .SpecialEffect = 1
212:             .Themes        = .F.
213:             .Visible       = .T.
214: 
215:             *-- Visualizar
216:             WITH .Buttons(1)
217:                 .Top             = 5
218:                 .Left            = 5
219:                 .Width           = 65
220:                 .Height          = 70
221:                 .Caption         = "Visualizar"
222:                 .FontBold        = .T.
223:                 .FontItalic      = .T.
224:                 .BackColor       = RGB(255, 255, 255)
225:                 .ForeColor       = RGB(90, 90, 90)
226:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 234 a 248:
234: 
235:             *-- Imprimir
236:             WITH .Buttons(2)
237:                 .Top             = 5
238:                 .Left            = 71
239:                 .Width           = 65
240:                 .Height          = 70
241:                 .Caption         = "Imprimir"
242:                 .FontName        = "Comic Sans MS"
243:                 .FontBold        = .T.
244:                 .FontItalic      = .T.
245:                 .FontSize        = 8
246:                 .BackColor       = RGB(255, 255, 255)
247:                 .ForeColor       = RGB(90, 90, 90)
248:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"

*-- Linhas 256 a 270:
256: 
257:             *-- Excel
258:             WITH .Buttons(3)
259:                 .Top             = 5
260:                 .Left            = 137
261:                 .Width           = 65
262:                 .Height          = 70
263:                 .Caption         = "Excel"
264:                 .FontName        = "Comic Sans MS"
265:                 .FontBold        = .T.
266:                 .FontItalic      = .T.
267:                 .FontSize        = 8
268:                 .BackColor       = RGB(255, 255, 255)
269:                 .ForeColor       = RGB(90, 90, 90)
270:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_excel_26.jpg"

*-- Linhas 278 a 293:
278: 
279:             *-- Encerrar (ESC fecha o formulario)
280:             WITH .Buttons(4)
281:                 .Top             = 5
282:                 .Left            = 203
283:                 .Width           = 65
284:                 .Height          = 70
285:                 .Caption         = "Encerrar"
286:                 .Cancel          = .T.
287:                 .FontName        = "Comic Sans MS"
288:                 .FontBold        = .T.
289:                 .FontItalic      = .T.
290:                 .FontSize        = 8
291:                 .BackColor       = RGB(255, 255, 255)
292:                 .ForeColor       = RGB(90, 90, 90)
293:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_sair_60.jpg"

*-- Linhas 309 a 325:
309:     *--------------------------------------------------------------------------
310:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
311:         *-- Processar: executa query com os filtros preenchidos
312:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
313:         WITH THIS.cmd_4c_Processar
314:             .Top             = 122
315:             .Left            = 543
316:             .Width           = 75
317:             .Height          = 75
318:             .Caption         = "Processar"
319:             .FontName        = "Comic Sans MS"
320:             .FontBold        = .T.
321:             .FontItalic      = .T.
322:             .FontSize        = 8
323:             .ForeColor       = RGB(90, 90, 90)
324:             .BackColor       = RGB(255, 255, 255)
325:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"

*-- Linhas 332 a 348:
332:         ENDWITH
333: 
334:         *-- Movimento: abre detalhe do registro selecionado no grid (SigMvExp)
335:         THIS.AddObject("cmd_4c_Movimento", "CommandButton")
336:         WITH THIS.cmd_4c_Movimento
337:             .Top             = 122
338:             .Left            = 619
339:             .Width           = 75
340:             .Height          = 75
341:             .Caption         = "Movimento"
342:             .FontName        = "Comic Sans MS"
343:             .FontBold        = .T.
344:             .FontItalic      = .T.
345:             .FontSize        = 8
346:             .ForeColor       = RGB(90, 90, 90)
347:             .BackColor       = RGB(255, 255, 255)
348:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"

*-- Linhas 381 a 406:
381:         loc_oPgf.PageCount = 2
382: 
383:         *-- Posicionamento: logo abaixo dos botoes de acao (Top 122 + 75 + 8 = 205)
384:         loc_oPgf.Top    = 205
385:         loc_oPgf.Left   = -1
386:         loc_oPgf.Width  = THIS.Width + 2
387:         loc_oPgf.Height = THIS.Height - 205
388:         loc_oPgf.Tabs   = .F.
389: 
390:         *-- Page1: Resultados (grade preenchida na proxima etapa)
391:         loc_oPgf.Page1.Caption   = "Resultados"
392:         loc_oPgf.Page1.FontName  = "Tahoma"
393:         loc_oPgf.Page1.FontSize  = 8
394:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
395:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
396:         IF !EMPTY(loc_cFundo)
397:             loc_oPgf.Page1.Picture = loc_cFundo
398:         ENDIF
399: 
400:         *-- Page2: Filtros (textboxes preenchidos nas etapas seguintes)
401:         loc_oPgf.Page2.Caption   = "Filtros"
402:         loc_oPgf.Page2.FontName  = "Tahoma"
403:         loc_oPgf.Page2.FontSize  = 8
404:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
405:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
406:         IF !EMPTY(loc_cFundo)

*-- Linhas 564 a 580:
564:                         loc_oGrid.Column6.ControlSource = loc_cCursor + ".Obses"
565: 
566:                         *-- Reconfigurar headers (VFP9 reseta ao alterar RecordSource)
567:                         loc_oGrid.Column1.Header1.Caption = ;
568:                             "Movimenta" + CHR(231) + CHR(227) + "o"
569:                         loc_oGrid.Column2.Header1.Caption = ;
570:                             "N" + CHR(250) + "mero"
571:                         loc_oGrid.Column3.Header1.Caption = "Docum."
572:                         loc_oGrid.Column4.Header1.Caption = "Data"
573:                         loc_oGrid.Column5.Header1.Caption = ;
574:                             "Usu" + CHR(225) + "rio"
575:                         loc_oGrid.Column6.Header1.Caption = ;
576:                             "Observa" + CHR(231) + CHR(227) + "o"
577: 
578:                         *-- Navegar para a pagina de resultados e focar grid
579:                         THIS.AlternarPagina(1)
580:                         loc_oGrid.SetFocus()

*-- Linhas 885 a 894:
885:         loc_oGrid = loc_oPagina.grd_4c_Dados
886: 
887:         WITH loc_oGrid
888:             .Top                = 55
889:             .Left               = 16
890:             .Width              = 760
891:             .Height             = 308
892:             .ColumnCount        = 6
893:             .FontName           = "Verdana"
894:             .FontSize           = 8

*-- Linhas 906 a 956:
906:             *-- Movimentacao (dopes) - operacao
907:             WITH .Column1
908:                 .Width              = 140
909:                 .Header1.Caption    = "Movimenta" + CHR(231) + CHR(227) + "o"
910:                 .FontName           = "Verdana"
911:                 .FontSize           = 8
912:             ENDWITH
913: 
914:             *-- Numero (numes)
915:             WITH .Column2
916:                 .Width              = 70
917:                 .Header1.Caption    = "N" + CHR(250) + "mero"
918:                 .FontName           = "Verdana"
919:                 .FontSize           = 8
920:                 .Alignment          = 1
921:             ENDWITH
922: 
923:             *-- Documento (notas)
924:             WITH .Column3
925:                 .Width              = 100
926:                 .Header1.Caption    = "Docum."
927:                 .FontName           = "Verdana"
928:                 .FontSize           = 8
929:             ENDWITH
930: 
931:             *-- Data (datas)
932:             WITH .Column4
933:                 .Width              = 90
934:                 .Header1.Caption    = "Data"
935:                 .FontName           = "Verdana"
936:                 .FontSize           = 8
937:                 .Alignment          = 3
938:             ENDWITH
939: 
940:             *-- Usuario (usulibs)
941:             WITH .Column5
942:                 .Width              = 100
943:                 .Header1.Caption    = "Usu" + CHR(225) + "rio"
944:                 .FontName           = "Verdana"
945:                 .FontSize           = 8
946:             ENDWITH
947: 
948:             *-- Observacao (Obses)
949:             WITH .Column6
950:                 .Width              = 260
951:                 .Header1.Caption    = "Observa" + CHR(231) + CHR(227) + "o"
952:                 .FontName           = "Verdana"
953:                 .FontSize           = 8
954:             ENDWITH
955: 
956:             .Visible = .T.

*-- Linhas 992 a 1016:
992:     PROTECTED PROCEDURE ConfigurarPaginaDados()
993: 
994:         *-- ROW 1: Empresa (Say6 / Get_Empresa / Get_Dempresa)
995:         THIS.AddObject("lbl_4c_Empresa", "Label")
996:         WITH THIS.lbl_4c_Empresa
997:             .Top       = 96
998:             .Left      = 61
999:             .AutoSize  = .T.
1000:             .FontName  = "Tahoma"
1001:             .FontSize  = 8
1002:             .Caption   = "Empresa :"
1003:             .ForeColor = RGB(90, 90, 90)
1004:             .BackStyle = 0
1005:             .Visible   = .T.
1006:         ENDWITH
1007: 
1008:         THIS.AddObject("txt_4c_Empresa", "TextBox")
1009:         WITH THIS.txt_4c_Empresa
1010:             .Top           = 93
1011:             .Left          = 114
1012:             .Width         = 33
1013:             .Height        = 21
1014:             .FontName      = "Tahoma"
1015:             .FontSize      = 8
1016:             .SpecialEffect = 1

*-- Linhas 1023 a 1089:
1023: 
1024:         THIS.AddObject("txt_4c_DEmpresa", "TextBox")
1025:         WITH THIS.txt_4c_DEmpresa
1026:             .Top           = 93
1027:             .Left          = 148
1028:             .Width         = 359
1029:             .Height        = 21
1030:             .FontName      = "Tahoma"
1031:             .FontSize      = 8
1032:             .SpecialEffect = 1
1033:             .ForeColor     = RGB(0, 0, 0)
1034:             .BackColor     = RGB(255, 255, 255)
1035:             .Value         = ""
1036:             .Visible       = .T.
1037:         ENDWITH
1038: 
1039:         *-- ROW 2: Periodo (lbl_periodo / get_dt_inicial / "a" / get_dt_final)
1040:         THIS.AddObject("lbl_4c_Periodo", "Label")
1041:         WITH THIS.lbl_4c_Periodo
1042:             .Top       = 121
1043:             .Left      = 63
1044:             .Width     = 48
1045:             .AutoSize  = .T.
1046:             .FontName  = "Tahoma"
1047:             .FontSize  = 8
1048:             .Caption   = "Per" + CHR(237) + "odo : "
1049:             .ForeColor = RGB(90, 90, 90)
1050:             .BackStyle = 0
1051:             .Visible   = .T.
1052:         ENDWITH
1053: 
1054:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
1055:         WITH THIS.txt_4c_DtInicial
1056:             .Top           = 118
1057:             .Left          = 114
1058:             .Width         = 80
1059:             .Height        = 21
1060:             .FontName      = "Tahoma"
1061:             .FontSize      = 8
1062:             .SpecialEffect = 1
1063:             .ForeColor     = RGB(0, 0, 0)
1064:             .BackColor     = RGB(255, 255, 255)
1065:             .Value         = {}
1066:             .Format        = "K"
1067:             .Visible       = .T.
1068:         ENDWITH
1069: 
1070:         THIS.AddObject("lbl_4c_PeriodoA", "Label")
1071:         WITH THIS.lbl_4c_PeriodoA
1072:             .Top       = 121
1073:             .Left      = 199
1074:             .Width     = 8
1075:             .AutoSize  = .T.
1076:             .Caption   = CHR(224)
1077:             .BackStyle = 0
1078:             .Visible   = .T.
1079:         ENDWITH
1080: 
1081:         THIS.AddObject("txt_4c_DtFinal", "TextBox")
1082:         WITH THIS.txt_4c_DtFinal
1083:             .Top           = 118
1084:             .Left          = 209
1085:             .Width         = 80
1086:             .Height        = 21
1087:             .FontName      = "Tahoma"
1088:             .FontSize      = 8
1089:             .SpecialEffect = 1

*-- Linhas 1096 a 1121:
1096: 
1097:         *-- ROW 3: Movimentacao / Numero / Documento (lbl_dopes / get_nm_operacao /
1098:         *--        Say1 / get_codigo / Say2 / get_documento)
1099:         THIS.AddObject("lbl_4c_Dopes", "Label")
1100:         WITH THIS.lbl_4c_Dopes
1101:             .Top       = 146
1102:             .Left      = 33
1103:             .Width     = 78
1104:             .AutoSize  = .T.
1105:             .FontName  = "Tahoma"
1106:             .FontSize  = 8
1107:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1108:             .ForeColor = RGB(90, 90, 90)
1109:             .BackStyle = 0
1110:             .Visible   = .T.
1111:         ENDWITH
1112: 
1113:         THIS.AddObject("txt_4c_NmOperacao", "TextBox")
1114:         WITH THIS.txt_4c_NmOperacao
1115:             .Top           = 143
1116:             .Left          = 114
1117:             .Width         = 150
1118:             .Height        = 21
1119:             .FontName      = "Tahoma"
1120:             .FontSize      = 9
1121:             .SpecialEffect = 1

*-- Linhas 1127 a 1150:
1127:             .Visible       = .T.
1128:         ENDWITH
1129: 
1130:         THIS.AddObject("lbl_4c_Say1", "Label")
1131:         WITH THIS.lbl_4c_Say1
1132:             .Top       = 146
1133:             .Left      = 277
1134:             .Width     = 46
1135:             .AutoSize  = .T.
1136:             .FontSize  = 8
1137:             .Caption   = "N" + CHR(250) + "mero :"
1138:             .BackStyle = 0
1139:             .Visible   = .T.
1140:         ENDWITH
1141: 
1142:         THIS.AddObject("txt_4c_Codigo", "TextBox")
1143:         WITH THIS.txt_4c_Codigo
1144:             .Top           = 143
1145:             .Left          = 326
1146:             .Width         = 45
1147:             .Height        = 21
1148:             .FontName      = "Tahoma"
1149:             .FontSize      = 9
1150:             .SpecialEffect = 1

*-- Linhas 1157 a 1180:
1157:             .Visible       = .T.
1158:         ENDWITH
1159: 
1160:         THIS.AddObject("lbl_4c_Say2", "Label")
1161:         WITH THIS.lbl_4c_Say2
1162:             .Top       = 146
1163:             .Left      = 392
1164:             .Width     = 60
1165:             .AutoSize  = .T.
1166:             .FontSize  = 8
1167:             .Caption   = "Documento:"
1168:             .BackStyle = 0
1169:             .Visible   = .T.
1170:         ENDWITH
1171: 
1172:         THIS.AddObject("txt_4c_Documento", "TextBox")
1173:         WITH THIS.txt_4c_Documento
1174:             .Top           = 143
1175:             .Left          = 455
1176:             .Width         = 52
1177:             .Height        = 21
1178:             .FontName      = "Tahoma"
1179:             .FontSize      = 9
1180:             .SpecialEffect = 1

*-- Linhas 1187 a 1263:
1187:         ENDWITH
1188: 
1189:         *-- ROW 4: Tipo conta - Say4 / OptConta (Origem / Destino)
1190:         THIS.AddObject("lbl_4c_Say4", "Label")
1191:         WITH THIS.lbl_4c_Say4
1192:             .Top       = 167
1193:             .Left      = 68
1194:             .Width     = 43
1195:             .AutoSize  = .T.
1196:             .FontName  = "Tahoma"
1197:             .FontSize  = 8
1198:             .Caption   = "Contas :"
1199:             .ForeColor = RGB(90, 90, 90)
1200:             .BackStyle = 0
1201:             .Visible   = .T.
1202:         ENDWITH
1203: 
1204:         THIS.AddObject("opt_4c_Conta", "OptionGroup")
1205:         WITH THIS.opt_4c_Conta
1206:             .Top         = 164
1207:             .Left        = 114
1208:             .Width       = 131
1209:             .Height      = 21
1210:             .ButtonCount = 2
1211:             .BackStyle   = 0
1212:             .BorderStyle = 0
1213:             .Value       = 1
1214:             .Visible     = .T.
1215:             WITH .Buttons(1)
1216:                 .Caption   = "Origem"
1217:                 .Value     = 1
1218:                 .Height    = 15
1219:                 .Left      = 5
1220:                 .Top       = 4
1221:                 .Width     = 52
1222:                 .AutoSize  = .T.
1223:                 .BackStyle = 0
1224:                 .ForeColor = RGB(90, 90, 90)
1225:             ENDWITH
1226:             WITH .Buttons(2)
1227:                 .Caption   = "Destino"
1228:                 .Height    = 15
1229:                 .Left      = 68
1230:                 .Top       = 4
1231:                 .Width     = 54
1232:                 .AutoSize  = .T.
1233:                 .FontName  = "Tahoma"
1234:                 .FontSize  = 8
1235:                 .BackStyle = 0
1236:                 .ForeColor = RGB(90, 90, 90)
1237:             ENDWITH
1238:         ENDWITH
1239: 
1240:         *-- ROW 5: Grupo contabil (Say3 / getGrupo / getDGrupo)
1241:         THIS.AddObject("lbl_4c_Say3", "Label")
1242:         WITH THIS.lbl_4c_Say3
1243:             .Top       = 189
1244:             .Left      = 73
1245:             .Width     = 38
1246:             .AutoSize  = .T.
1247:             .FontName  = "Tahoma"
1248:             .FontSize  = 8
1249:             .Caption   = "Grupo :"
1250:             .ForeColor = RGB(90, 90, 90)
1251:             .BackStyle = 0
1252:             .Visible   = .T.
1253:         ENDWITH
1254: 
1255:         THIS.AddObject("txt_4c_Grupo", "TextBox")
1256:         WITH THIS.txt_4c_Grupo
1257:             .Top           = 186
1258:             .Left          = 114
1259:             .Width         = 80
1260:             .Height        = 22
1261:             .FontName      = "Tahoma"
1262:             .FontSize      = 8
1263:             .SpecialEffect = 1

*-- Linhas 1269 a 1308:
1269: 
1270:         THIS.AddObject("txt_4c_DGrupo", "TextBox")
1271:         WITH THIS.txt_4c_DGrupo
1272:             .Top           = 186
1273:             .Left          = 196
1274:             .Width         = 311
1275:             .Height        = 22
1276:             .FontName      = "Tahoma"
1277:             .FontSize      = 8
1278:             .SpecialEffect = 1
1279:             .ForeColor     = RGB(0, 0, 0)
1280:             .BackColor     = RGB(255, 255, 255)
1281:             .Value         = ""
1282:             .Visible       = .T.
1283:         ENDWITH
1284: 
1285:         *-- ROW 6: Conta contabil (lbl_estoque / getConta / getDConta)
1286:         THIS.AddObject("lbl_4c_Estoque", "Label")
1287:         WITH THIS.lbl_4c_Estoque
1288:             .Top       = 214
1289:             .Left      = 73
1290:             .Width     = 38
1291:             .AutoSize  = .T.
1292:             .FontName  = "Tahoma"
1293:             .FontSize  = 8
1294:             .Caption   = "Conta :"
1295:             .ForeColor = RGB(90, 90, 90)
1296:             .BackStyle = 0
1297:             .Visible   = .T.
1298:         ENDWITH
1299: 
1300:         THIS.AddObject("txt_4c_Conta", "TextBox")
1301:         WITH THIS.txt_4c_Conta
1302:             .Top           = 211
1303:             .Left          = 114
1304:             .Width         = 80
1305:             .Height        = 22
1306:             .FontName      = "Tahoma"
1307:             .FontSize      = 8
1308:             .SpecialEffect = 1

*-- Linhas 1314 a 1353:
1314: 
1315:         THIS.AddObject("txt_4c_DConta", "TextBox")
1316:         WITH THIS.txt_4c_DConta
1317:             .Top           = 211
1318:             .Left          = 196
1319:             .Width         = 311
1320:             .Height        = 22
1321:             .FontName      = "Tahoma"
1322:             .FontSize      = 8
1323:             .SpecialEffect = 1
1324:             .ForeColor     = RGB(0, 0, 0)
1325:             .BackColor     = RGB(255, 255, 255)
1326:             .Value         = ""
1327:             .Visible       = .T.
1328:         ENDWITH
1329: 
1330:         *-- ROW 7: Observacao (Say5 / get_Obses)
1331:         THIS.AddObject("lbl_4c_Say5", "Label")
1332:         WITH THIS.lbl_4c_Say5
1333:             .Top       = 235
1334:             .Left      = 44
1335:             .Width     = 67
1336:             .AutoSize  = .T.
1337:             .FontName  = "Tahoma"
1338:             .FontSize  = 8
1339:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
1340:             .ForeColor = RGB(90, 90, 90)
1341:             .BackStyle = 0
1342:             .Visible   = .T.
1343:         ENDWITH
1344: 
1345:         THIS.AddObject("txt_4c_Obses", "TextBox")
1346:         WITH THIS.txt_4c_Obses
1347:             .Top           = 235
1348:             .Left          = 114
1349:             .Width         = 393
1350:             .Height        = 21
1351:             .FontName      = "Tahoma"
1352:             .FontSize      = 8
1353:             .SpecialEffect = 1

*-- Linhas 1911 a 1920:
1911:                 ENDIF
1912:             ENDIF
1913:         ENDIF
1914:         IF VARTYPE(THIS.cmd_4c_Movimento) = "O"
1915:             THIS.cmd_4c_Movimento.Enabled = loc_lTemDados
1916:         ENDIF
1917:     ENDPROC
1918: 
1919:     *--------------------------------------------------------------------------
1920:     * BtnBuscarClick - Executa a pesquisa com os filtros atuais


### BO (C:\4c\projeto\app\classes\SigReCspBO.prg):
*==============================================================================
* SIGRECSPBO.PRG
* Business Object para Pesquisa de Operacoes (SIGRECSP)
* Herda de RelatorioBase
*
* Tabela principal: SigMvCab
* Chave: EmpDopNums
* Cursor resultado: cursor_4c_SigReCsp
*==============================================================================

DEFINE CLASS SigReCspBO AS RelatorioBase

    *-- Configuracao base
    this_cTabela        = "SigMvCab"
    this_cCampoChave    = "EmpDopNums"
    this_cCursorDados   = "cursor_4c_SigReCsp"

    *-- Filtros: Empresa
    this_cEmpresa       = ""
    this_cDEmpresa      = ""

    *-- Filtros: Periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtros: Movimentacao
    this_cNmOperacao    = ""
    this_cCodigo        = ""
    this_cDocumento     = ""

    *-- Filtros: Conta/Grupo contabil
    this_nOptConta      = 1
    this_cContas        = ""
    this_cDContas       = ""
    this_cGrupos        = ""
    this_cDGrupos       = ""

    *-- Filtros: Observacao
    this_cObses         = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO de pesquisa de operacoes
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF
            THIS.this_dDtInicial = DATE()
            THIS.this_dDtFinal   = DATE()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Carrega empresa padrao e sua descricao.
    * Chamado pelo form em InicializarForm().
    * Equivalente ao bloco Init() do legado SIGRECSP que carrega SigCdEmp.
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_cEmpresa)
                loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                    EscaparSQL(THIS.this_cEmpresa)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpRec")
                IF loc_nResult > 0
                    SELECT cursor_4c_EmpRec
                    IF !EOF()
                        THIS.this_cDEmpresa = ALLTRIM(cursor_4c_EmpRec.Razas)
                    ENDIF
                    USE IN cursor_4c_EmpRec
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa query principal em SigMvCab com os filtros
    * definidos nas propriedades this_*. Popula cursor_4c_SigReCsp.
    * Equivalente ao metodo 'processamento' do form legado SIGRECSP.
    * NOTA: filtro de acesso por operacao (fAcessoMovmto) nao replicado -
    * funcao legada de controle de acesso nao existe no novo sistema.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult
        LOCAL loc_cOpCta, loc_cOpGru, loc_dDtI, loc_dDtF, loc_cDtFSQL
        loc_lSucesso = .F.
        TRY
            *-- Normalizar datas: sem data = faixa maxima historica
            loc_dDtI = IIF(EMPTY(THIS.this_dDtInicial), {^1900-01-01}, THIS.this_dDtInicial)
            loc_dDtF = IIF(EMPTY(THIS.this_dDtFinal),   {^2099-12-31}, THIS.this_dDtFinal)

            *-- Data final com 23:59:59 para cobrir o dia inteiro (campo DATETIME)
            loc_cDtFSQL = "'" + ;
                PADL(YEAR(loc_dDtF),  4, "0") + "-" + ;
                PADL(MONTH(loc_dDtF), 2, "0") + "-" + ;
                PADL(DAY(loc_dDtF),   2, "0") + " 23:59:59'"

            *-- Colunas de Conta/Grupo dependem de OptConta:
            *-- 1=Origem -> ContaOs/GrupoOs | 2=Destino -> ContaDs/GrupoDs
            IF THIS.this_nOptConta = 1
                loc_cOpCta = "ContaOs"
                loc_cOpGru = "GrupoOs"
            ELSE
                loc_cOpCta = "ContaDs"
                loc_cOpGru = "GrupoDs"
            ENDIF

            *-- Construir clausula WHERE adicional
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cNmOperacao))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cNmOperacao))
            ENDIF

            *-- numes e NUMERIC(6,0) - nao usar aspas, apenas o valor numerico
            IF !EMPTY(ALLTRIM(THIS.this_cCodigo))
                loc_cWhere = loc_cWhere + ;
                    " AND a.numes = " + ALLTRIM(THIS.this_cCodigo)
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cDocumento))
                loc_cWhere = loc_cWhere + ;
                    " AND a.notas = " + EscaparSQL(ALLTRIM(THIS.this_cDocumento))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cGrupos))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpGru + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cGrupos))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cContas))
                loc_cWhere = loc_cWhere + ;
                    " AND a." + loc_cOpCta + " = " + ;
                    EscaparSQL(ALLTRIM(THIS.this_cContas))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cObses))
                loc_cWhere = loc_cWhere + ;
                    " AND a.Obses LIKE " + ;
                    EscaparSQL("%" + ALLTRIM(THIS.this_cObses) + "%")
            ENDIF

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Query principal: SigMvCab com campos do grid original
            loc_cSQL = "SELECT a.emps, a.dopes, a.numes, a.datas, a.notas," + ;
                " a.datars, a.empdopnums, a.operadors, a.usulibs," + ;
                " ISNULL(CONVERT(VARCHAR(250), a.Obses), '') AS Obses" + ;
                " FROM SigMvCab a" + ;
                " WHERE a.datas BETWEEN " + FormatarDataSQL(loc_dDtI) + ;
                " AND " + loc_cDtFSQL + ;
                loc_cWhere + ;
                " ORDER BY a.EmpDopNums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao buscar dados de opera" + ;
                    CHR(231) + CHR(245) + "es"
                loc_lSucesso = .F.
            ELSE
                SELECT (THIS.this_cCursorDados)
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Restaura filtros a partir de cursor de configuracao.
    * Util para "ultimo filtro usado" sem quebrar quando o schema evoluir.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_lValido
        loc_lSucesso = .F.
        TRY
            loc_lValido = !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            IF !loc_lValido
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel"
            ENDIF
            IF loc_lValido
                SELECT (par_cAliasCursor)
                loc_lValido = !EOF()
                IF !loc_lValido
                    THIS.this_cMensagemErro = "Cursor de filtros vazio"
                ENDIF
            ENDIF
            IF loc_lValido
                IF TYPE(par_cAliasCursor + ".c_empresa") = "C"
                    THIS.this_cEmpresa    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_empresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dempresa") = "C"
                    THIS.this_cDEmpresa   = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dempresa"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_inicial") = "D"
                    THIS.this_dDtInicial  = EVALUATE(par_cAliasCursor + ".d_inicial")
                ENDIF
                IF TYPE(par_cAliasCursor + ".d_final") = "D"
                    THIS.this_dDtFinal    = EVALUATE(par_cAliasCursor + ".d_final")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_operacao") = "C"
                    THIS.this_cNmOperacao = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_operacao"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_codigo") = "C"
                    THIS.this_cCodigo     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_codigo"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_documento") = "C"
                    THIS.this_cDocumento  = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_documento"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".n_optconta") = "N"
                    THIS.this_nOptConta   = EVALUATE(par_cAliasCursor + ".n_optconta")
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_contas") = "C"
                    THIS.this_cContas     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_contas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dcontas") = "C"
                    THIS.this_cDContas    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dcontas"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_grupos") = "C"
                    THIS.this_cGrupos     = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_grupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_dgrupos") = "C"
                    THIS.this_cDGrupos    = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_dgrupos"))
                ENDIF
                IF TYPE(par_cAliasCursor + ".c_obses") = "C"
                    THIS.this_cObses      = ALLTRIM(EVALUATE(par_cAliasCursor + ".c_obses"))
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: pesquisa nao persiste dados.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: use PrepararDados()."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Pesquisa nao tem chave primaria para persistencia.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro.
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha cursores abertos pelo BO.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED("cursor_4c_EmpRec")
            USE IN cursor_4c_EmpRec
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

