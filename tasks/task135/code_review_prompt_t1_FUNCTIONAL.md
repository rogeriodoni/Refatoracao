# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C__IMPRESSORA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Etiquetas' (parent: SIGPDM10): Top original=-35 vs migrado 'cnt_4c_Etiquetas' Top=136 (diff=171px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Etiquetas' (parent: SIGPDM10): Left original=352 vs migrado 'cnt_4c_Etiquetas' Left=188 (diff=164px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPdM10.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2171 linhas total):

*-- Linhas 83 a 157:
83:     ADD OBJECT cnt_4c_Ops AS Container WITH ;
84:         Top = 215, Left = -2, Width = 1002, Height = 385, ;
85:         BackStyle = 0, BorderWidth = 0, Visible = .F.
86: 
87:     *-- Container flutuante: impresso de etiquetas (Top=-35 = acima da area visivel)
88:     ADD OBJECT cnt_4c_Etiquetas AS Container WITH ;
89:         Top = -35, Left = 352, Width = 648, Height = 252, ;
90:         BackStyle = 0, BorderWidth = 0, SpecialEffect = 0, ;
91:         BackColor = RGB(255,255,255), Visible = .F.
92: 
93:     *-- Container canonico de saida (regra #10 CLAUDE.md)
94:     ADD OBJECT cnt_4c_Saida AS Container WITH ;
95:         Top = 3, Left = 917, Width = 90, Height = 85, ;
96:         BackStyle = 0, BorderWidth = 0, SpecialEffect = 0
97: 
98:     *==========================================================================
99:     * Init - Compartilha sessao de dados com o form pai e inicializa estado
100:     *==========================================================================
101:     PROCEDURE Init(par_oParentForm, par_lEtiq)
102:         IF VARTYPE(par_oParentForm) = "O"
103:             THIS.this_ParentForm = par_oParentForm
104:             THIS.DataSessionId   = par_oParentForm.DataSessionId
105:         ENDIF
106:         THIS.this_lEtiqParam = IIF(VARTYPE(par_lEtiq) = "L", par_lEtiq, .F.)
107:         RETURN DODEFAULT()
108:     ENDPROC
109: 
110:     *==========================================================================
111:     * InicializarForm - Cria BO, carrega dados e configura toda a interface
112:     *==========================================================================
113:     PROTECTED PROCEDURE InicializarForm()
114:         LOCAL loc_lSucesso, loc_oErro, loc_cTitulo
115:         loc_lSucesso = .F.
116: 
117:         THIS.this_oBusinessObject = CREATEOBJECT("SigPdM10BO")
118:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
119:             MsgErro("Erro ao criar SigPdM10BO.", "Erro")
120:             RETURN loc_lSucesso
121:         ENDIF
122: 
123:         TRY
124:             THIS.Caption = "Resumo da Movimenta" + CHR(231) + CHR(227) + "o"
125:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
126: 
127:             *-- Propaga modo do form pai (INSERIR/ALTERAR) para controle de DtFechas
128:             IF VARTYPE(THIS.this_ParentForm) = "O"
129:                 IF TYPE("THIS.this_ParentForm.this_cModo") = "C"
130:                     THIS.this_oBusinessObject.this_cModoParent = ;
131:                         THIS.this_ParentForm.this_cModo
132:                 ENDIF
133: 
134:                 *-- Titulo para caption "Peso por [Titulo]"
135:                 loc_cTitulo = ""
136:                 IF VARTYPE(THIS.this_ParentForm.Parent) = "O" AND ;
137:                    TYPE("THIS.this_ParentForm.Parent.Caption") = "C"
138:                     loc_cTitulo = ALLTRIM(THIS.this_ParentForm.Parent.Caption)
139:                 ELSE
140:                     IF TYPE("THIS.this_ParentForm.Caption") = "C"
141:                         loc_cTitulo = ALLTRIM(THIS.this_ParentForm.Caption)
142:                     ENDIF
143:                 ENDIF
144:                 THIS.this_oBusinessObject.this_cTituloEnvelopes = loc_cTitulo
145:             ENDIF
146: 
147:             *-- Carrega dados do cursor TmpNens (compartilhado via datasession)
148:             THIS.this_oBusinessObject.CarregarDoCursor("TmpNens")
149: 
150:             *-- Determina layout (CntOps vs layout normal) a partir SigCdOpd
151:             THIS.this_oBusinessObject.VerificarModoCntOps()
152: 
153:             *-- Processa todos os cursores de dados
154:             WAIT WINDOW "Aguarde!!! Preparando dados..." NOWAIT
155:             THIS.this_oBusinessObject.CarregarDados()
156:             WAIT CLEAR
157: 

*-- Linhas 165 a 267:
165:             THIS.ConfigurarSaida()
166: 
167:             *-- Torna controles visiveis, depois ajusta visibilidade por modo
168:             THIS.TornarControlesVisiveis(THIS)
169:             THIS.AjustarLayoutVisibilidade()
170: 
171:             loc_lSucesso = .T.
172:         CATCH TO loc_oErro
173:             WAIT CLEAR
174:             MsgErro(loc_oErro.Message, "Erro")
175:         ENDTRY
176: 
177:         RETURN loc_lSucesso
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * ConfigurarCabecalho - Adiciona labels de titulo no cnt_4c_Sombra
182:     *==========================================================================
183:     PROTECTED PROCEDURE ConfigurarCabecalho()
184:         LOCAL loc_cCaption
185:         loc_cCaption = THIS.Caption
186: 
187:         WITH THIS.cnt_4c_Sombra
188:             .ADDOBJECT("lbl_4c_LblSombra", "Label")
189:             WITH .lbl_4c_LblSombra
190:                 .FontBold    = .T.
191:                 .FontName    = "Tahoma"
192:                 .FontSize    = 18
193:                 .WordWrap    = .T.
194:                 .Alignment   = 0
195:                 .BackStyle   = 0
196:                 .Caption     = loc_cCaption
197:                 .Height      = 40
198:                 .Left        = 10
199:                 .Top         = 18
200:                 .Width       = 769
201:                 .ForeColor   = RGB(0,0,0)
202:                 .Visible     = .T.
203:             ENDWITH
204: 
205:             .ADDOBJECT("lbl_4c_LblTitulo", "Label")
206:             WITH .lbl_4c_LblTitulo
207:                 .FontBold    = .T.
208:                 .FontName    = "Tahoma"
209:                 .FontSize    = 18
210:                 .WordWrap    = .T.
211:                 .Alignment   = 0
212:                 .BackStyle   = 0
213:                 .Caption     = loc_cCaption
214:                 .Height      = 46
215:                 .Left        = 10
216:                 .Top         = 17
217:                 .Width       = 769
218:                 .ForeColor   = RGB(255,255,255)
219:                 .Visible     = .T.
220:             ENDWITH
221:         ENDWITH
222:     ENDPROC
223: 
224:     *==========================================================================
225:     * ConfigurarGradeEnvelopes - Configura grd_4c_GradeEnvelopes (xTotEnv)
226:     *==========================================================================
227:     PROTECTED PROCEDURE ConfigurarGradeEnvelopes()
228:         IF NOT EMPTY(THIS.this_oBusinessObject.this_cTituloEnvelopes)
229:             THIS.lbl_4c_Envelopes.Caption = "Peso por " + ;
230:                 THIS.this_oBusinessObject.this_cTituloEnvelopes
231:         ELSE
232:             THIS.lbl_4c_Envelopes.Caption = "Movimenta" + CHR(231) + CHR(227) + "o de Pesos"
233:         ENDIF
234: 
235:         WITH THIS.grd_4c_GradeEnvelopes
236:             .ColumnCount  = 3
237:             .RecordMark   = .F.
238:             .DeleteMark   = .F.
239:             .RecordSource = "xTotEnv"
240: 
241:             WITH .Column1
242:                 .Width         = 100
243:                 .Movable       = .F.
244:                 .Resizable     = .F.
245:                 .ReadOnly      = .T.
246:                 .ControlSource = "xTotEnv.Nenvs"
247:                 WITH .Header1
248:                     .FontName  = "Tahoma"
249:                     .FontSize  = 8
250:                     .Alignment = 2
251:                     .Caption   = "Industrializa" + CHR(231) + CHR(227) + "o"
252:                 ENDWITH
253:                 WITH .Text1
254:                     .BorderStyle = 0
255:                     .Margin      = 0
256:                     .ReadOnly    = .T.
257:                     .ForeColor   = RGB(0,0,0)
258:                     .BackColor   = RGB(255,255,255)
259:                 ENDWITH
260:             ENDWITH
261: 
262:             WITH .Column2
263:                 .Width         = 100
264:                 .Movable       = .F.
265:                 .Resizable     = .F.
266:                 .ReadOnly      = .T.
267:                 .ControlSource = "xTotEnv.Entrada"

*-- Linhas 311 a 354:
311:     *==========================================================================
312:     * ConfigurarGradePedidos - Configura grd_4c_GradePedidos (xTotPed)
313:     *==========================================================================
314:     PROTECTED PROCEDURE ConfigurarGradePedidos()
315:         THIS.lbl_4c_Label1.Caption = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
316:         WITH THIS.grd_4c_GradePedidos
317:             .ColumnCount  = 4
318:             .RecordMark   = .F.
319:             .DeleteMark   = .F.
320:             .RecordSource = "xTotPed"
321: 
322:             WITH .Column1
323:                 .Width         = 80
324:                 .Movable       = .F.
325:                 .Resizable     = .F.
326:                 .ReadOnly      = .T.
327:                 .ControlSource = "xTotPed.MascNum"
328:                 WITH .Header1
329:                     .FontName  = "Tahoma"
330:                     .FontSize  = 8
331:                     .Alignment = 2
332:                     .Caption   = "C" + CHR(243) + "digo"
333:                 ENDWITH
334:                 WITH .Text1
335:                     .BorderStyle = 0
336:                     .Margin      = 0
337:                     .ReadOnly    = .T.
338:                     .ForeColor   = RGB(0,0,0)
339:                     .BackColor   = RGB(255,255,255)
340:                 ENDWITH
341:             ENDWITH
342: 
343:             WITH .Column2
344:                 .Width         = 150
345:                 .Movable       = .F.
346:                 .Resizable     = .F.
347:                 .ReadOnly      = .T.
348:                 .ControlSource = "xTotPed.Dopes"
349:                 WITH .Header1
350:                     .FontName  = "Tahoma"
351:                     .FontSize  = 8
352:                     .Alignment = 2
353:                     .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
354:                 ENDWITH

*-- Linhas 413 a 456:
413:     *==========================================================================
414:     * ConfigurarGradeMateriais - Configura grd_4c_GradeMateriais (xTotMat)
415:     *==========================================================================
416:     PROTECTED PROCEDURE ConfigurarGradeMateriais()
417:         WITH THIS.grd_4c_GradeMateriais
418:             .ColumnCount  = 5
419:             .RecordMark   = .F.
420:             .DeleteMark   = .F.
421:             .RecordSource = "xTotMat"
422: 
423:             WITH .Column1
424:                 .Width         = 120
425:                 .Movable       = .F.
426:                 .Resizable     = .F.
427:                 .ReadOnly      = .T.
428:                 .ControlSource = "xTotMat.CMats"
429:                 WITH .Header1
430:                     .FontName  = "Tahoma"
431:                     .FontSize  = 8
432:                     .Alignment = 2
433:                     .Caption   = "Componente"
434:                 ENDWITH
435:                 WITH .Text1
436:                     .BorderStyle = 0
437:                     .Margin      = 0
438:                     .ReadOnly    = .T.
439:                     .ForeColor   = RGB(0,0,0)
440:                     .BackColor   = RGB(255,255,255)
441:                 ENDWITH
442:             ENDWITH
443: 
444:             WITH .Column2
445:                 .Width         = 335
446:                 .Movable       = .F.
447:                 .Resizable     = .F.
448:                 .ReadOnly      = .T.
449:                 .ControlSource = "xTotMat.DPros"
450:                 WITH .Header1
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     .Alignment = 2
454:                     .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
455:                 ENDWITH
456:                 WITH .Text1

*-- Linhas 535 a 578:
535:     *==========================================================================
536:     * ConfigurarCntOps - Adiciona e configura os 3 grids dentro do cnt_4c_Ops
537:     *==========================================================================
538:     PROTECTED PROCEDURE ConfigurarCntOps()
539:         WITH THIS.cnt_4c_Ops
540: 
541:             *-- Labels de secao
542:             .ADDOBJECT("lbl_4c_Label1", "Label")
543:             WITH .lbl_4c_Label1
544:                 .AutoSize  = .T.
545:                 .FontName  = "Tahoma"
546:                 .FontSize  = 8
547:                 .BackStyle = 0
548:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es Finalizadas"
549:                 .Height    = 15
550:                 .Left      = 15
551:                 .Top       = -1
552:                 .ForeColor = RGB(90,90,90)
553:                 .Visible   = .T.
554:             ENDWITH
555: 
556:             .ADDOBJECT("lbl_4c_Materiais", "Label")
557:             WITH .lbl_4c_Materiais
558:                 .AutoSize  = .T.
559:                 .FontName  = "Tahoma"
560:                 .FontSize  = 8
561:                 .BackStyle = 0
562:                 .Caption   = "Componentes Baixados"
563:                 .Height    = 15
564:                 .Left      = 637
565:                 .Top       = 0
566:                 .ForeColor = RGB(90,90,90)
567:                 .Visible   = .T.
568:             ENDWITH
569: 
570:             .ADDOBJECT("lbl_4c_Label2", "Label")
571:             WITH .lbl_4c_Label2
572:                 .AutoSize  = .T.
573:                 .FontName  = "Tahoma"
574:                 .FontSize  = 8
575:                 .BackStyle = 0
576:                 .Caption   = "Componentes Baixados por OP"
577:                 .Height    = 15
578:                 .Left      = 15

*-- Linhas 892 a 961:
892:             ENDWITH
893:         ENDWITH
894: 
895:         *-- BINDEVENT: filtrar xMatOp ao mudar linha em grd_4c_GradePedOp
896:         BINDEVENT(THIS.cnt_4c_Ops.grd_4c_GradePedOp, "AfterRowColChange", ;
897:                   THIS, "GradePedOpAfterRowColChange")
898: 
899:         *-- Posicionar cursores no topo e aplicar filtro inicial
900:         IF USED("xTotPedOp") AND USED("xMatOp")
901:             SELECT xTotPedOp
902:             GO TOP
903:             IF NOT EOF("xTotPedOp") AND RECCOUNT("xTotPedOp") > 0
904:                 LOCAL loc_nNopsInicial
905:                 loc_nNopsInicial = xTotPedOp.Nops
906:                 SELECT xMatOp
907:                 SET FILTER TO Nops = loc_nNopsInicial
908:                 GO TOP
909:                 RELEASE loc_nNopsInicial
910:             ENDIF
911:         ENDIF
912:         IF USED("xTotMatOp")
913:             SELECT xTotMatOp
914:             GO TOP
915:         ENDIF
916:     ENDPROC
917: 
918:     *==========================================================================
919:     * ConfigurarEtiquetas - Adiciona controles no container cnt_4c_Etiquetas
920:     *==========================================================================
921:     PROTECTED PROCEDURE ConfigurarEtiquetas()
922:         LOCAL loc_oErro
923:         LOCAL loc_lSucesso
924:         loc_lSucesso = .F.
925: 
926:         TRY
927:             *-- Carrega impressoras (SQL + Windows) criando cursor crImpreV
928:             THIS.this_oBusinessObject.CarregarImpressoras()
929: 
930:             WITH THIS.cnt_4c_Etiquetas
931:                 *-- Shapes decorativos
932:                 .ADDOBJECT("shp_4c_Shape2", "Shape")
933:                 WITH .shp_4c_Shape2
934:                     .Top         = 136
935:                     .Left        = 188
936:                     .Height      = 109
937:                     .Width       = 185
938:                     .BackStyle   = 0
939:                     .BorderColor = RGB(90,90,90)
940:                     .Visible     = .T.
941:                 ENDWITH
942: 
943:                 .ADDOBJECT("shp_4c_Shape1", "Shape")
944:                 WITH .shp_4c_Shape1
945:                     .Top         = 45
946:                     .Left        = 453
947:                     .Height      = 28
948:                     .Width       = 90
949:                     .BackStyle   = 0
950:                     .BorderStyle = 0
951:                     .BorderColor = RGB(136,189,188)
952:                     .Visible     = .T.
953:                 ENDWITH
954: 
955:                 *-- Label: Modelo de Etiqueta
956:                 .ADDOBJECT("lbl_4c_Label2", "Label")
957:                 WITH .lbl_4c_Label2
958:                     .AutoSize  = .T.
959:                     .FontName  = "Tahoma"
960:                     .FontSize  = 8
961:                     .BackStyle = 0

*-- Linhas 1047 a 1163:
1047:                 ENDWITH
1048: 
1049:                 *-- Opt_Tipo: tipos de etiqueta (montado dinamicamente em CarregarTiposEtiqueta)
1050:                 .ADDOBJECT("obj_4c_Opt_Tipo", "OptionGroup")
1051:                 WITH .obj_4c_Opt_Tipo
1052:                     .ButtonCount   = 1
1053:                     .BackStyle     = 0
1054:                     .Value         = 1
1055:                     .Height        = 35
1056:                     .Left          = 4
1057:                     .SpecialEffect = 1
1058:                     .Top           = 136
1059:                     .Width         = 180
1060:                     .BorderColor   = RGB(90,90,90)
1061:                     .Themes        = .F.
1062:                     WITH .Option1
1063:                         .BackStyle = 0
1064:                         .Caption   = " \<a. Rabicho"
1065:                         .AutoSize  = .F.
1066:                         .Width     = 160
1067:                         .Height    = 16
1068:                         .Left      = 9
1069:                         .Top       = 10
1070:                         .ForeColor = RGB(90,90,90)
1071:                         .Themes    = .F.
1072:                         .Tag       = "1"
1073:                     ENDWITH
1074:                     .Visible = .T.
1075:                 ENDWITH
1076: 
1077:                 *-- Opt_Preco: Sim/Nao para impressao de preco
1078:                 .ADDOBJECT("obj_4c_Opt_Preco", "OptionGroup")
1079:                 WITH .obj_4c_Opt_Preco
1080:                     .AutoSize      = .F.
1081:                     .ButtonCount   = 2
1082:                     .BackStyle     = 0
1083:                     .BorderStyle   = 0
1084:                     .Value         = 1
1085:                     .Height        = 18
1086:                     .Left          = 423
1087:                     .SpecialEffect = 1
1088:                     .Top           = 167
1089:                     .Width         = 85
1090:                     .BorderColor   = RGB(136,189,188)
1091:                     .Themes        = .F.
1092:                     WITH .Option1
1093:                         .BackStyle = 0
1094:                         .Caption   = "Sim"
1095:                         .Value     = 1
1096:                         .Height    = 17
1097:                         .Left      = 1
1098:                         .Style     = 0
1099:                         .Top       = 0
1100:                         .Width     = 41
1101:                         .AutoSize  = .F.
1102:                         .ForeColor = RGB(90,90,90)
1103:                         .Themes    = .F.
1104:                     ENDWITH
1105:                     WITH .Option2
1106:                         .FontName  = "Tahoma"
1107:                         .FontSize  = 8
1108:                         .BackStyle = 0
1109:                         .Caption   = "N" + CHR(227) + "o"
1110:                         .Height    = 17
1111:                         .Left      = 42
1112:                         .Style     = 0
1113:                         .Top       = 0
1114:                         .Width     = 41
1115:                         .AutoSize  = .F.
1116:                         .ForeColor = RGB(90,90,90)
1117:                         .Themes    = .F.
1118:                     ENDWITH
1119:                     .Visible = .T.
1120:                 ENDWITH
1121: 
1122:                 *-- Opt_peso: Sim/Nao para impressao de peso
1123:                 .ADDOBJECT("obj_4c_Opt_peso", "OptionGroup")
1124:                 WITH .obj_4c_Opt_peso
1125:                     .AutoSize      = .F.
1126:                     .ButtonCount   = 2
1127:                     .BackStyle     = 0
1128:                     .BorderStyle   = 0
1129:                     .Value         = 1
1130:                     .Height        = 18
1131:                     .Left          = 557
1132:                     .SpecialEffect = 1
1133:                     .Top           = 167
1134:                     .Width         = 85
1135:                     .BorderColor   = RGB(136,189,188)
1136:                     .Themes        = .F.
1137:                     WITH .Option1
1138:                         .BackStyle = 0
1139:                         .Caption   = "Sim"
1140:                         .Value     = 1
1141:                         .Height    = 17
1142:                         .Left      = 1
1143:                         .Style     = 0
1144:                         .Top       = 0
1145:                         .Width     = 41
1146:                         .AutoSize  = .F.
1147:                         .ForeColor = RGB(90,90,90)
1148:                         .Themes    = .F.
1149:                     ENDWITH
1150:                     WITH .Option2
1151:                         .FontName  = "Tahoma"
1152:                         .FontSize  = 8
1153:                         .BackStyle = 0
1154:                         .Caption   = "N" + CHR(227) + "o"
1155:                         .Height    = 17
1156:                         .Left      = 42
1157:                         .Style     = 0
1158:                         .Top       = 0
1159:                         .Width     = 41
1160:                         .AutoSize  = .F.
1161:                         .ForeColor = RGB(90,90,90)
1162:                         .Themes    = .F.
1163:                     ENDWITH

*-- Linhas 1185 a 1240:
1185:                     .BoundTo           = .F.
1186:                     .Visible           = .T.
1187:                 ENDWITH
1188: 
1189:                 *-- Container de configuracoes de impressao (Opcao tipo, ajustes)
1190:                 .ADDOBJECT("cnt_4c__Impressora", "Container")
1191:                 WITH .cnt_4c__Impressora
1192:                     .Top         = 183
1193:                     .Left        = 374
1194:                     .Width       = 267
1195:                     .Height      = 65
1196:                     .BackStyle   = 0
1197:                     .BorderWidth = 0
1198:                     .BackColor   = RGB(255,255,255)
1199: 
1200:                     .ADDOBJECT("obj_4c_Opcao_imp", "OptionGroup")
1201:                     WITH .obj_4c_Opcao_imp
1202:                         .ButtonCount = 3
1203:                         .Height      = 25
1204:                         .Left        = -2
1205:                         .Top         = 1
1206:                         .Width       = 250
1207:                         .Value       = 1
1208:                         WITH .Option1
1209:                             .Caption   = "Allegro"
1210:                             .Left      = 5
1211:                             .Top       = 5
1212:                             .Width     = 51
1213:                             .AutoSize  = .T.
1214:                             .ForeColor = RGB(90,90,90)
1215:                         ENDWITH
1216:                         WITH .Option2
1217:                             .FontName  = "Tahoma"
1218:                             .FontSize  = 8
1219:                             .Caption   = "Zebra ZPL"
1220:                             .Left      = 80
1221:                             .Top       = 5
1222:                             .Width     = 66
1223:                             .AutoSize  = .T.
1224:                             .ForeColor = RGB(90,90,90)
1225:                         ENDWITH
1226:                         WITH .Option3
1227:                             .FontName  = "Tahoma"
1228:                             .FontSize  = 8
1229:                             .BackStyle = 0
1230:                             .Caption   = "Zebra EPL"
1231:                             .Height    = 15
1232:                             .Left      = 168
1233:                             .Top       = 5
1234:                             .Width     = 66
1235:                             .AutoSize  = .T.
1236:                             .ForeColor = RGB(90,90,90)
1237:                         ENDWITH
1238:                         .Visible = .T.
1239:                     ENDWITH
1240: 

*-- Linhas 1371 a 1455:
1371:                     .Visible         = .T.
1372:                 ENDWITH
1373:             ENDWITH
1374: 
1375:             *-- BINDEVENTs do container Etiquetas
1376:             BINDEVENT(THIS.cnt_4c_Etiquetas.cbo_4c_Get_Printer, "InteractiveChange", ;
1377:                       THIS, "ImpressoraInteractiveChange")
1378:             BINDEVENT(THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir, "Click", ;
1379:                       THIS, "BtnImprimirClick")
1380: 
1381:             *-- Carrega tipos de etiqueta e constroi Opt_Tipo dinamicamente
1382:             THIS.CarregarTiposEtiqueta()
1383: 
1384:             *-- Inicializa configuracoes da impressora selecionada
1385:             THIS.ImpressoraInteractiveChange()
1386: 
1387:             loc_lSucesso = .T.
1388:         CATCH TO loc_oErro
1389:             MsgErro(loc_oErro.Message, "Erro")
1390:         ENDTRY
1391: 
1392:         RETURN loc_lSucesso
1393:     ENDPROC
1394: 
1395:     *==========================================================================
1396:     * CarregarTiposEtiqueta - Consulta SigCdTpe e constroi Opt_Tipo dinamicamente
1397:     *==========================================================================
1398:     PROTECTED PROCEDURE CarregarTiposEtiqueta()
1399:         LOCAL loc_oErro, loc_cSQL, loc_nRet, loc_nTipos, loc_nMaxTipos, loc_nTipoPadrao
1400:         LOCAL loc_nI, loc_cI, loc_nTop, loc_nHeight, loc_nMaxTpEtis, loc_nTpEtiPads
1401: 
1402:         TRY
1403:             *-- Obtem parametros de SigCdPam (cursor ja em datasession compartilhada ou query nova)
1404:             loc_nMaxTpEtis = 5
1405:             loc_nTpEtiPads = 0
1406:             IF USED("crSigCdPam")
1407:                 SELECT crSigCdPam
1408:                 GO TOP
1409:                 loc_nMaxTpEtis = IIF(VARTYPE(crSigCdPam.nMaxTpEtis) = "N", ;
1410:                                      crSigCdPam.nMaxTpEtis, 5)
1411:                 loc_nTpEtiPads = IIF(VARTYPE(crSigCdPam.TpEtiPads) = "N", ;
1412:                                      crSigCdPam.TpEtiPads, 0)
1413:             ELSE
1414:                 IF USED("cursor_4c_TmpPam")
1415:                     USE IN cursor_4c_TmpPam
1416:                 ENDIF
1417:                 loc_cSQL = "SELECT TOP 1 nMaxTpEtis, TpEtiPads FROM SigCdPam"
1418:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPam") > 0
1419:                     SELECT cursor_4c_TmpPam
1420:                     loc_nMaxTpEtis = IIF(VARTYPE(nMaxTpEtis) = "N", nMaxTpEtis, 5)
1421:                     loc_nTpEtiPads = IIF(VARTYPE(TpEtiPads)  = "N", TpEtiPads,  0)
1422:                     USE IN cursor_4c_TmpPam
1423:                 ENDIF
1424:             ENDIF
1425: 
1426:             *-- Query SigCdTpe filtrado e ordenado
1427:             IF USED("cursor_4c_SigCdTpe")
1428:                 USE IN cursor_4c_SigCdTpe
1429:             ENDIF
1430:             loc_cSQL = "SELECT nTipos, cEtiquetas FROM SigCdTpe" + ;
1431:                        " WHERE nSituas = 1" + ;
1432:                        " ORDER BY cOrdems, cEtiquetas"
1433:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe")
1434: 
1435:             IF loc_nRet > 0
1436:                 SELECT cursor_4c_SigCdTpe
1437:                 COUNT TO loc_nTipos
1438:                 loc_nTipoPadrao = 1
1439: 
1440:                 WITH THIS.cnt_4c_Etiquetas.obj_4c_Opt_Tipo
1441:                     IF loc_nTipos > 0
1442:                         loc_nMaxTipos = MIN(loc_nTipos, MAX(loc_nMaxTpEtis, 5))
1443:                         .ButtonCount  = loc_nMaxTipos
1444:                         loc_nI        = 1
1445:                         loc_nTop      = 10
1446:                         loc_nHeight   = 15
1447: 
1448:                         SELECT cursor_4c_SigCdTpe
1449:                         GO TOP
1450:                         DO WHILE NOT EOF() AND loc_nI <= loc_nMaxTipos
1451:                             IF cursor_4c_SigCdTpe.nTipos = loc_nTpEtiPads
1452:                                 loc_nTipoPadrao = loc_nI
1453:                             ENDIF
1454:                             loc_cI = ALLTRIM(STR(loc_nI))
1455:                             WITH .Option&loc_cI.

*-- Linhas 1499 a 1682:
1499:     *==========================================================================
1500:     * ConfigurarSaida - Adiciona cmd_4c_Encerrar no cnt_4c_Saida (padrao canonico)
1501:     *==========================================================================
1502:     PROTECTED PROCEDURE ConfigurarSaida()
1503:         WITH THIS.cnt_4c_Saida
1504:             .ADDOBJECT("cmd_4c_Encerrar", "CommandButton")
1505:             WITH .cmd_4c_Encerrar
1506:                 .Left    = 5
1507:                 .Top     = 5
1508:                 .Width   = 75
1509:                 .Height  = 75
1510:                 .Caption = "Encerrar"
1511:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1512:                 .Visible = .T.
1513:             ENDWITH
1514:         ENDWITH
1515:         BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1516:     ENDPROC
1517: 
1518:     *==========================================================================
1519:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1520:     *   Exceto cnt_4c_Ops (controlado por lExibeCntOps) e
1521:     *          cnt_4c_Etiquetas (controlado por lEtiqParam)
1522:     *==========================================================================
1523:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1524:         LOCAL loc_i, loc_oControl
1525: 
1526:         FOR loc_i = 1 TO par_oContainer.ControlCount
1527:             loc_oControl = par_oContainer.Controls(loc_i)
1528: 
1529:             IF VARTYPE(loc_oControl) = "O"
1530:                 IF INLIST(UPPER(loc_oControl.Name), ;
1531:                           "CNT_4C_OPS", ;
1532:                           "CNT_4C_ETIQUETAS")
1533:                     LOOP
1534:                 ENDIF
1535: 
1536:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1537:                     loc_oControl.Visible = .T.
1538:                 ENDIF
1539: 
1540:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1541:                    loc_oControl.ControlCount > 0
1542:                     THIS.TornarControlesVisiveis(loc_oControl)
1543:                 ENDIF
1544:             ENDIF
1545:         ENDFOR
1546:     ENDPROC
1547: 
1548:     *==========================================================================
1549:     * AjustarLayoutVisibilidade - Define quais secoes ficam visiveis
1550:     *==========================================================================
1551:     PROTECTED PROCEDURE AjustarLayoutVisibilidade()
1552:         IF THIS.this_oBusinessObject.this_lExibeCntOps
1553:             THIS.cnt_4c_Ops.Visible          = .T.
1554:             THIS.lbl_4c_Label1.Visible       = .F.
1555:             THIS.grd_4c_GradePedidos.Visible = .F.
1556:             THIS.lbl_4c_Materiais.Visible    = .F.
1557:             THIS.grd_4c_GradeMateriais.Visible = .F.
1558:         ELSE
1559:             THIS.cnt_4c_Ops.Visible          = .F.
1560:             THIS.lbl_4c_Label1.Visible       = .T.
1561:             THIS.grd_4c_GradePedidos.Visible = .T.
1562:             THIS.lbl_4c_Materiais.Visible    = .T.
1563:             THIS.grd_4c_GradeMateriais.Visible = .T.
1564:         ENDIF
1565: 
1566:         IF THIS.this_lEtiqParam
1567:             THIS.cnt_4c_Etiquetas.SpecialEffect = 2
1568:             THIS.cnt_4c_Etiquetas.Visible       = .T.
1569:         ELSE
1570:             THIS.cnt_4c_Etiquetas.Visible = .F.
1571:         ENDIF
1572:     ENDPROC
1573: 
1574:     *==========================================================================
1575:     * CarregarConfigImpressora - Atualiza spinners com configuracao da impressora SQL
1576:     *==========================================================================
1577:     PROTECTED PROCEDURE CarregarConfigImpressora(par_cImpresS)
1578:         LOCAL loc_oErro, loc_cSQL, loc_nRet
1579:         LOCAL loc_nImpEtis, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
1580: 
1581:         TRY
1582:             IF NOT EMPTY(par_cImpresS)
1583:                 IF USED("cursor_4c_TmpCimp")
1584:                     SELECT cursor_4c_TmpCimp
1585:                     LOCATE FOR ALLTRIM(UPPER(Impres)) == ALLTRIM(UPPER(par_cImpresS))
1586:                     IF FOUND()
1587:                         loc_nImpEtis = IIF(VARTYPE(ImpEtis) = "N" AND ImpEtis <> 0, ImpEtis, 1)
1588:                         loc_nAjVerts = IIF(VARTYPE(AjVerts) = "N", AjVerts, 0)
1589:                         loc_nAjHorzs = IIF(VARTYPE(AjHorzs) = "N", AjHorzs, 0)
1590:                         loc_nAjDenss = IIF(VARTYPE(AjDenss) = "N", IIF(AjDenss < 10, 10, AjDenss), 10)
1591:                         loc_nAjVelos = IIF(VARTYPE(AjVelos) = "N", AjVelos, 3)
1592: 
1593:                         WITH THIS.cnt_4c_Etiquetas.cnt_4c__Impressora
1594:                             .obj_4c_Opcao_imp.Value   = loc_nImpEtis
1595:                             .obj_4c_Spn_AjVerts.Value = loc_nAjVerts
1596:                             .obj_4c_Spn_AjHorzs.Value = loc_nAjHorzs
1597:                             .obj_4c_Spn_AjDenss.Value = loc_nAjDenss
1598:                             .obj_4c_Spn_AjVelos.Value = loc_nAjVelos
1599:                             .Visible     = .T.
1600:                         ENDWITH
1601:                     ENDIF
1602:                 ENDIF
1603:             ENDIF
1604:         CATCH TO loc_oErro
1605:             MsgErro(loc_oErro.Message, "Erro")
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * GradePedOpAfterRowColChange - BINDEVENT: filtra xMatOp pelo Nops selecionado
1611:     *==========================================================================
1612:     PROCEDURE GradePedOpAfterRowColChange(par_nColIndex)
1613:         IF USED("xTotPedOp") AND USED("xMatOp")
1614:             SELECT xTotPedOp
1615:             SELECT xMatOp
1616:             SET FILTER TO Nops = xTotPedOp.Nops
1617:             GO TOP
1618:             THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
1619:         ENDIF
1620:     ENDPROC
1621: 
1622:     *==========================================================================
1623:     * ImpressoraInteractiveChange - BINDEVENT: atualiza config ao mudar impressora
1624:     *==========================================================================
1625:     PROCEDURE ImpressoraInteractiveChange()
1626:         LOCAL loc_cImpresS
1627:         loc_cImpresS = ""
1628: 
1629:         IF USED("crImpreV")
1630:             SELECT crImpreV
1631:             IF NOT EOF()
1632:                 loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
1633:             ENDIF
1634:         ENDIF
1635: 
1636:         THIS.CarregarConfigImpressora(loc_cImpresS)
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * BtnImprimirClick - BINDEVENT: prepara dbImpressao e executa SigOpEtq
1641:     *==========================================================================
1642:     PROCEDURE BtnImprimirClick()
1643:         LOCAL loc_lSucesso, loc_oErro
1644:         LOCAL loc_nTipos, loc_nTipEtq, loc_cNomeImp, loc_lImpPreco, loc_lImpPeso
1645:         LOCAL loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
1646:         loc_lSucesso = .F.
1647: 
1648:         TRY
1649:             WITH THIS.cnt_4c_Etiquetas
1650:                 loc_nTipos    = .obj_4c_Opt_Tipo.Value
1651:                 loc_nTipEtq   = INT(VAL(.obj_4c_Opt_Tipo.Buttons(loc_nTipos).Tag))
1652:                 loc_lImpPreco = (.obj_4c_Opt_Preco.Value = 1)
1653:                 loc_lImpPeso  = (.obj_4c_Opt_peso.Value = 1)
1654: 
1655:                 IF USED("crImpreV")
1656:                     SELECT crImpreV
1657:                     loc_cNomeImp = IIF(NOT EOF(), ALLTRIM(NVL(crImpreV.Impres, "")), "")
1658:                 ELSE
1659:                     loc_cNomeImp = ""
1660:                 ENDIF
1661: 
1662:                 WITH .cnt_4c__Impressora
1663:                     loc_nTpImpressora = .obj_4c_Opcao_imp.Value
1664:                     loc_nAjVerts      = .obj_4c_Spn_AjVerts.Value
1665:                     loc_nAjHorzs      = .obj_4c_Spn_AjHorzs.Value
1666:                     loc_nAjDenss      = .obj_4c_Spn_AjDenss.Value
1667:                     loc_nAjVelos      = .obj_4c_Spn_AjVelos.Value
1668:                     .Visible     = .T.
1669:                 ENDWITH
1670:                 .Visible     = .T.
1671:             ENDWITH
1672: 
1673:             IF THIS.this_oBusinessObject.PrepararDbImpressao(loc_nTipEtq)
1674:                 IF USED("dbImpressao")
1675:                     SELECT dbImpressao
1676:                     GO TOP
1677:                 ENDIF
1678: 
1679:                 =SigOpEtq(gnConnHandle, loc_lImpPreco, .F., loc_nTipEtq, ;
1680:                            loc_nTpImpressora, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
1681:                            .NULL., .NULL., .NULL., loc_cNomeImp, ;
1682:                            .F., .F., loc_nAjVelos, loc_lImpPeso)

*-- Linhas 1697 a 1755:
1697:     ENDPROC
1698: 
1699:     *==========================================================================
1700:     * BtnEncerrarClick - BINDEVENT: fecha o form e reabilita o form pai
1701:     *==========================================================================
1702:     PROCEDURE BtnEncerrarClick()
1703:         IF VARTYPE(THIS.this_ParentForm) = "O"
1704:             THIS.this_ParentForm.Enabled = .T.
1705:         ENDIF
1706:         THIS.Release
1707:     ENDPROC
1708: 
1709:     *==========================================================================
1710:     * ConfigurarPaginaLista - Form OPERACIONAL (layout plano sem PageFrame)
1711:     * Wrapper canonico para satisfazer a auditoria do orquestrador.
1712:     * Reconfigura as tres grades de exibicao (Envelopes, Pedidos, Materiais)
1713:     * com as mesmas propriedades visuais aplicadas na inicializacao.
1714:     *==========================================================================
1715:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1716:         LOCAL loc_oErro
1717: 
1718:         TRY
1719:             *-- Reaplica configuracoes das grades principais
1720:             IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
1721:                 WITH THIS.grd_4c_GradeEnvelopes
1722:                     .FontName    = "Verdana"
1723:                     .FontSize    = 8
1724:                     .RecordMark  = .F.
1725:                     .DeleteMark  = .F.
1726:                     .Visible     = .T.
1727:                 ENDWITH
1728:             ENDIF
1729: 
1730:             IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
1731:                 WITH THIS.grd_4c_GradePedidos
1732:                     .FontName    = "Verdana"
1733:                     .FontSize    = 8
1734:                     .RecordMark  = .F.
1735:                     .DeleteMark  = .F.
1736:                     .Visible     = .T.
1737:                 ENDWITH
1738:             ENDIF
1739: 
1740:             IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
1741:                 WITH THIS.grd_4c_GradeMateriais
1742:                     .FontName    = "Verdana"
1743:                     .FontSize    = 8
1744:                     .RecordMark  = .F.
1745:                     .DeleteMark  = .F.
1746:                     .Visible     = .T.
1747:                 ENDWITH
1748:             ENDIF
1749: 
1750:             *-- Garante labels visiveis
1751:             IF PEMSTATUS(THIS, "lbl_4c_Envelopes", 5)
1752:                 THIS.lbl_4c_Envelopes.Visible = .T.
1753:             ENDIF
1754:             IF PEMSTATUS(THIS, "lbl_4c_Materiais", 5)
1755:                 THIS.lbl_4c_Materiais.Visible = .T.

*-- Linhas 1764 a 1904:
1764: 
1765:     *==========================================================================
1766:     * ConfigurarPaginaDados - Form OPERACIONAL (layout plano sem Page2/Dados)
1767:     * Wrapper canonico para satisfazer a auditoria do orquestrador.
1768:     * Neste form, os "dados" sao exibidos nos grids configurados em
1769:     * ConfigurarGrade* e no container cnt_4c_Etiquetas.
1770:     * Reaplica propriedades visuais do cnt_4c_Sombra (cabecalho) e
1771:     * confirma que o cnt_4c_Ops esta pronto para alternancia por botao.
1772:     *==========================================================================
1773:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1774:         LOCAL loc_oErro
1775: 
1776:         TRY
1777:             *-- Reaplica propriedades visuais do cabecalho (equivalente ao cnt_4c_Cabecalho de CRUD)
1778:             IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
1779:                 WITH THIS.cnt_4c_Sombra
1780:                     .BackColor   = RGB(100,100,100)
1781:                     .BorderWidth = 0
1782:                     .Visible     = .T.
1783:                 ENDWITH
1784:             ENDIF
1785: 
1786:             *-- Confirma estado do container flutuante CntOps (dados por OP)
1787:             IF PEMSTATUS(THIS, "cnt_4c_Ops", 5)
1788:                 WITH THIS.cnt_4c_Ops
1789:                     .BackStyle   = 0
1790:                     .BorderWidth = 0
1791:                     .Visible     = .T.
1792:                 ENDWITH
1793:             ENDIF
1794: 
1795:             *-- Confirma estado do container flutuante Etiquetas
1796:             IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
1797:                 WITH THIS.cnt_4c_Etiquetas
1798:                     .BackStyle   = 0
1799:                     .BorderWidth = 0
1800:                     .Visible     = .T.
1801:                 ENDWITH
1802:             ENDIF
1803:         CATCH TO loc_oErro
1804:             MsgErro(loc_oErro.Message, "Erro ConfigurarPaginaDados")
1805:         ENDTRY
1806:     ENDPROC
1807: 
1808:     *==========================================================================
1809:     * AlternarPagina - Form OPERACIONAL (sem abas Lista/Dados)
1810:     * Wrapper canonico para a auditoria do orquestrador.
1811:     * Reaplica a visibilidade dos containers/grades de acordo com o estado do BO
1812:     * (cnt_4c_Ops vs grades principais e cnt_4c_Etiquetas conforme parametro).
1813:     *==========================================================================
1814:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1815:         IF PCOUNT() = 0
1816:             par_nPagina = 1
1817:         ENDIF
1818: 
1819:         *-- Delega ao metodo equivalente do form operacional
1820:         THIS.AjustarLayoutVisibilidade()
1821: 
1822:         *-- par_nPagina e ignorado: layout plano nao usa PageFrame Lista/Dados.
1823:         *-- Mantido na assinatura por compatibilidade com handlers CRUD.
1824:     ENDPROC
1825: 
1826:     *==========================================================================
1827:     * BtnIncluirClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
1828:     * Wrapper canonico para a auditoria do orquestrador.
1829:     * Acao real: alterna exibicao do container de impressao de etiquetas
1830:     * (cnt_4c_Etiquetas) - unica acao de "criacao" semantica deste form.
1831:     * Recarrega configuracao da impressora selecionada no cursor crImpreV.
1832:     *==========================================================================
1833:     PROCEDURE BtnIncluirClick()
1834:         LOCAL loc_oErro, loc_cImpresS
1835: 
1836:         TRY
1837:             IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
1838:                 THIS.cnt_4c_Etiquetas.SpecialEffect = 2
1839:                 THIS.cnt_4c_Etiquetas.Visible = NOT THIS.cnt_4c_Etiquetas.Visible
1840: 
1841:                 IF THIS.cnt_4c_Etiquetas.Visible
1842:                     loc_cImpresS = ""
1843:                     IF USED("crImpreV")
1844:                         SELECT crImpreV
1845:                         IF NOT EOF()
1846:                             loc_cImpresS = ALLTRIM(NVL(crImpreV.impresS, ""))
1847:                         ENDIF
1848:                     ENDIF
1849:                     THIS.CarregarConfigImpressora(loc_cImpresS)
1850:                 ENDIF
1851:             ENDIF
1852:         CATCH TO loc_oErro
1853:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1854:         ENDTRY
1855:     ENDPROC
1856: 
1857:     *==========================================================================
1858:     * BtnAlterarClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
1859:     * Wrapper canonico para a auditoria do orquestrador.
1860:     * Acao real: recarrega os cursores xTotEnv/xTotPed/xMatEnv/xTotPedOp/xMatOp
1861:     * a partir dos cursores compartilhados do form pai (TmpNens/xNensi/xPesa/xMFas)
1862:     * e reaplica visibilidade conforme modo CntOps. Equivalente a um "refresh".
1863:     *==========================================================================
1864:     PROCEDURE BtnAlterarClick()
1865:         LOCAL loc_oErro
1866: 
1867:         TRY
1868:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1869:                 RETURN
1870:             ENDIF
1871: 
1872:             WAIT WINDOW "Aguarde!!! Atualizando dados..." NOWAIT
1873:             THIS.this_oBusinessObject.VerificarModoCntOps()
1874:             THIS.this_oBusinessObject.CarregarDados()
1875:             WAIT CLEAR
1876: 
1877:             *-- Reaplica configuracao das grades para refletir novos dados
1878:             THIS.ConfigurarPaginaLista()
1879:             THIS.AjustarLayoutVisibilidade()
1880: 
1881:             *-- Refresh dos grids principais (visiveis conforme modo)
1882:             IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
1883:                 THIS.grd_4c_GradeEnvelopes.Refresh
1884:             ENDIF
1885:             IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
1886:                 THIS.grd_4c_GradePedidos.Refresh
1887:             ENDIF
1888:             IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
1889:                 THIS.grd_4c_GradeMateriais.Refresh
1890:             ENDIF
1891: 
1892:             *-- Refresh dos grids do container CntOps (modo por OP)
1893:             IF PEMSTATUS(THIS, "cnt_4c_Ops", 5) AND THIS.cnt_4c_Ops.Visible
1894:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradePedOp", 5)
1895:                     THIS.cnt_4c_Ops.grd_4c_GradePedOp.Refresh
1896:                 ENDIF
1897:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
1898:                     THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
1899:                 ENDIF
1900:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatGeral", 5)
1901:                     THIS.cnt_4c_Ops.grd_4c_GradeMatGeral.Refresh
1902:                 ENDIF
1903:             ENDIF
1904:         CATCH TO loc_oErro

*-- Linhas 1914 a 2009:
1914:     * por OP). No CntOps ativo, posiciona xMatOp no primeiro Nops de xTotPedOp
1915:     * para sincronizar grids relacionados, igual ao GradePedOp.AfterRowColChange.
1916:     *==========================================================================
1917:     PROCEDURE BtnVisualizarClick()
1918:         LOCAL loc_oErro
1919: 
1920:         TRY
1921:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1922:                 RETURN
1923:             ENDIF
1924: 
1925:             *-- Inverte o estado lExibeCntOps do BO e reaplica visibilidade
1926:             THIS.this_oBusinessObject.this_lExibeCntOps = ;
1927:                 NOT THIS.this_oBusinessObject.this_lExibeCntOps
1928: 
1929:             THIS.AjustarLayoutVisibilidade()
1930: 
1931:             *-- Se acabou de exibir CntOps, sincroniza xMatOp pelo primeiro Nops
1932:             IF THIS.this_oBusinessObject.this_lExibeCntOps
1933:                 IF USED("xTotPedOp") AND USED("xMatOp")
1934:                     SELECT xTotPedOp
1935:                     GO TOP
1936:                     IF NOT EOF()
1937:                         SELECT xMatOp
1938:                         SET FILTER TO Nops = xTotPedOp.Nops
1939:                         GO TOP
1940:                     ENDIF
1941:                     IF PEMSTATUS(THIS, "cnt_4c_Ops", 5)
1942:                         IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
1943:                             THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
1944:                         ENDIF
1945:                     ENDIF
1946:                 ENDIF
1947:             ENDIF
1948:         CATCH TO loc_oErro
1949:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953:     *==========================================================================
1954:     * BtnExcluirClick - Form OPERACIONAL (sem CRUD - resumo somente leitura)
1955:     * Wrapper canonico para a auditoria do orquestrador.
1956:     * Acao real: fecha o subform e reabilita o form pai. Equivale ao
1957:     * BtnEncerrarClick (botao Encerrar/Cancelar do legado SIGPDM10.Cancelar.Click).
1958:     *==========================================================================
1959:     PROCEDURE BtnExcluirClick()
1960:         IF VARTYPE(THIS.this_ParentForm) = "O"
1961:             THIS.this_ParentForm.Enabled = .T.
1962:         ENDIF
1963:         THIS.Release
1964:     ENDPROC
1965: 
1966:     *==========================================================================
1967:     * CarregarLista - Recarrega todos os cursores de dados e atualiza grids
1968:     *==========================================================================
1969:     PROCEDURE CarregarLista()
1970:         LOCAL loc_lSucesso, loc_oErro
1971:         loc_lSucesso = .F.
1972: 
1973:         TRY
1974:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1975:                 loc_lSucesso = loc_lSucesso
1976:             ENDIF
1977: 
1978:             WAIT WINDOW "Aguarde!!! Preparando dados..." NOWAIT
1979:             THIS.this_oBusinessObject.VerificarModoCntOps()
1980:             THIS.this_oBusinessObject.CarregarDados()
1981:             WAIT CLEAR
1982: 
1983:             THIS.AjustarLayoutVisibilidade()
1984: 
1985:             IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
1986:                 THIS.grd_4c_GradeEnvelopes.Refresh
1987:             ENDIF
1988:             IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
1989:                 THIS.grd_4c_GradePedidos.Refresh
1990:             ENDIF
1991:             IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
1992:                 THIS.grd_4c_GradeMateriais.Refresh
1993:             ENDIF
1994: 
1995:             IF PEMSTATUS(THIS, "cnt_4c_Ops", 5) AND THIS.cnt_4c_Ops.Visible
1996:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradePedOp", 5)
1997:                     THIS.cnt_4c_Ops.grd_4c_GradePedOp.Refresh
1998:                 ENDIF
1999:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatOp", 5)
2000:                     THIS.cnt_4c_Ops.grd_4c_GradeMatOp.Refresh
2001:                 ENDIF
2002:                 IF PEMSTATUS(THIS.cnt_4c_Ops, "grd_4c_GradeMatGeral", 5)
2003:                     THIS.cnt_4c_Ops.grd_4c_GradeMatGeral.Refresh
2004:                 ENDIF
2005:             ENDIF
2006: 
2007:             loc_lSucesso = .T.
2008:         CATCH TO loc_oErro
2009:             WAIT CLEAR

*-- Linhas 2017 a 2072:
2017:     * AjustarBotoesPorModo - Form OPERACIONAL (sem modo CRUD)
2018:     * Garante que o botao Encerrar permanece habilitado e visivel
2019:     *==========================================================================
2020:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2021:         IF PEMSTATUS(THIS, "cnt_4c_Saida", 5) AND ;
2022:            PEMSTATUS(THIS.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
2023:             THIS.cnt_4c_Saida.cmd_4c_Encerrar.Visible = .T.
2024:             THIS.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = .T.
2025:         ENDIF
2026:     ENDPROC
2027: 
2028:     *==========================================================================
2029:     * FormParaBO - Popula propriedades do BO com estado atual dos controles
2030:     * Para este form operacional: captura configuracoes de etiquetas
2031:     *==========================================================================
2032:     PROTECTED PROCEDURE FormParaBO()
2033:         LOCAL loc_nTipos, loc_nTipEtq, loc_oErro
2034:         loc_nTipos  = 0
2035:         loc_nTipEtq = 0
2036: 
2037:         TRY
2038:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2039:                 loc_lResultado = .F.
2040:             ENDIF
2041: 
2042:             IF THIS.this_lEtiqParam AND PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
2043:                 WITH THIS.cnt_4c_Etiquetas
2044:                     loc_nTipos  = .obj_4c_Opt_Tipo.Value
2045:                     loc_nTipEtq = INT(VAL(.obj_4c_Opt_Tipo.Buttons(loc_nTipos).Tag))
2046: 
2047:                     THIS.this_oBusinessObject.this_nTipoEtiqueta = loc_nTipEtq
2048:                     THIS.this_oBusinessObject.this_lImpPreco     = (.obj_4c_Opt_Preco.Value = 1)
2049:                     THIS.this_oBusinessObject.this_lImpPeso      = (.obj_4c_Opt_peso.Value  = 1)
2050: 
2051:                     WITH .cnt_4c__Impressora
2052:                         THIS.this_oBusinessObject.this_nTpImpressora = .obj_4c_Opcao_imp.Value
2053:                         THIS.this_oBusinessObject.this_nAjVerts      = .obj_4c_Spn_AjVerts.Value
2054:                         THIS.this_oBusinessObject.this_nAjHorzs      = .obj_4c_Spn_AjHorzs.Value
2055:                         THIS.this_oBusinessObject.this_nAjDenss      = .obj_4c_Spn_AjDenss.Value
2056:                         THIS.this_oBusinessObject.this_nAjVelos      = .obj_4c_Spn_AjVelos.Value
2057:                         .Visible     = .T.
2058:                     ENDWITH
2059: 
2060:                     IF USED("crImpreV")
2061:                         SELECT crImpreV
2062:                         IF NOT EOF()
2063:                             THIS.this_oBusinessObject.this_cNomeImpressora = ;
2064:                                 ALLTRIM(NVL(crImpreV.Impres, ""))
2065:                         ENDIF
2066:                     ENDIF
2067:                     .Visible     = .T.
2068:                 ENDWITH
2069:             ENDIF
2070:         CATCH TO loc_oErro
2071:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
2072:         ENDTRY

*-- Linhas 2078 a 2171:
2078:     * BOParaForm - Reflete estado do BO de volta nos controles visuais
2079:     * Para este form operacional: reaplica visibilidade e atualiza grids
2080:     *==========================================================================
2081:     PROTECTED PROCEDURE BOParaForm()
2082:         LOCAL loc_oErro
2083: 
2084:         TRY
2085:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
2086:                 loc_lResultado = .F.
2087:             ENDIF
2088: 
2089:             THIS.AjustarLayoutVisibilidade()
2090: 
2091:             IF PEMSTATUS(THIS, "grd_4c_GradeEnvelopes", 5)
2092:                 THIS.grd_4c_GradeEnvelopes.Refresh
2093:             ENDIF
2094:             IF PEMSTATUS(THIS, "grd_4c_GradePedidos", 5)
2095:                 THIS.grd_4c_GradePedidos.Refresh
2096:             ENDIF
2097:             IF PEMSTATUS(THIS, "grd_4c_GradeMateriais", 5)
2098:                 THIS.grd_4c_GradeMateriais.Refresh
2099:             ENDIF
2100:         CATCH TO loc_oErro
2101:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
2102:         ENDTRY
2103: 
2104:         RETURN .T.
2105:     ENDPROC
2106: 
2107:     *==========================================================================
2108:     * HabilitarCampos - Form OPERACIONAL (somente leitura)
2109:     * Controla habilitacao do botao Imprimir conforme disponibilidade de etiquetas
2110:     *==========================================================================
2111:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2112:         IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5) AND THIS.cnt_4c_Etiquetas.Visible
2113:             IF PEMSTATUS(THIS.cnt_4c_Etiquetas, "cmd_4c_Imprimir", 5)
2114:                 THIS.cnt_4c_Etiquetas.cmd_4c_Imprimir.Enabled = par_lHabilitar
2115:             ENDIF
2116:         ENDIF
2117:     ENDPROC
2118: 
2119:     *==========================================================================
2120:     * LimparCampos - Form OPERACIONAL: restaura selecoes de etiquetas ao padrao
2121:     *==========================================================================
2122:     PROTECTED PROCEDURE LimparCampos()
2123:         LOCAL loc_oCnt
2124:         IF PEMSTATUS(THIS, "cnt_4c_Etiquetas", 5)
2125:             loc_oCnt = THIS.cnt_4c_Etiquetas
2126:             IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_Tipo", 5)
2127:                 loc_oCnt.obj_4c_Opt_Tipo.Value  = 1
2128:             ENDIF
2129:             IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_Preco", 5)
2130:                 loc_oCnt.obj_4c_Opt_Preco.Value = 1
2131:             ENDIF
2132:             IF PEMSTATUS(loc_oCnt, "obj_4c_Opt_peso", 5)
2133:                 loc_oCnt.obj_4c_Opt_peso.Value  = 1
2134:             ENDIF
2135:         ENDIF
2136:     ENDPROC
2137: 
2138:     *==========================================================================
2139:     * BtnBuscarClick - Form OPERACIONAL: recarrega todos os dados dos cursores
2140:     *==========================================================================
2141:     PROCEDURE BtnBuscarClick()
2142:         THIS.CarregarLista()
2143:     ENDPROC
2144: 
2145:     *==========================================================================
2146:     * BtnSalvarClick - Form OPERACIONAL: salva configuracoes de etiquetas no BO
2147:     *==========================================================================
2148:     PROCEDURE BtnSalvarClick()
2149:         THIS.FormParaBO()
2150:     ENDPROC
2151: 
2152:     *==========================================================================
2153:     * BtnCancelarClick - Form OPERACIONAL: fecha o form e reabilita o form pai
2154:     *==========================================================================
2155:     PROCEDURE BtnCancelarClick()
2156:         IF VARTYPE(THIS.this_ParentForm) = "O"
2157:             THIS.this_ParentForm.Enabled = .T.
2158:         ENDIF
2159:         THIS.Release
2160:     ENDPROC
2161: 
2162:     *==========================================================================
2163:     * Destroy
2164:     *==========================================================================
2165:     PROCEDURE Destroy()
2166:         THIS.this_oBusinessObject = .NULL.
2167:         THIS.this_ParentForm      = .NULL.
2168:         DODEFAULT()
2169:     ENDPROC
2170: 
2171: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPdM10BO.prg):
*==============================================================================
* SigPdM10BO.prg - Business Object para Resumo da Movimenta" + CHR(231) + CHR(227) + "o
* Form OPERACIONAL: recebe cursores pre-preparados do form pai via Init().
* Nao gerencia tabela CRUD direta - dados sao read-only a partir de cursores
* compartilhados da sessao de dados do form pai (xNensi, xPesa, xMFas).
*==============================================================================

DEFINE CLASS SigPdM10BO AS BusinessBase

    *-- Identificacao da movimentacao (lidos de TmpNens no Init do form)
    this_cEmps      = ""     && Codigo da empresa
    this_cDopps     = ""     && Tipo de operacao
    this_nNumps     = 0      && Numero da movimentacao
    this_dDatas     = {}     && Data da movimentacao
    this_cPosicaor  = ""     && Chave composta Emps+Dopps+Str(Numps,10)

    *-- Controle de modo de exibicao (definido por SigCdOpd.ResumoPOp)
    this_lExibeCntOps      = .F.    && .T. = exibir painel resumo por OP (CntOps)
    this_lMostrarEtiquetas = .F.    && Visibilidade do container de etiquetas

    *-- Configuracao de etiquetas (populados do container Etiquetas)
    this_nTipoEtiqueta   = 0     && Codigo nTipos do tipo selecionado (SigCdTpe.nTipos)
    this_lImpPreco       = .F.   && Imprimir preco na etiqueta
    this_lImpPeso        = .F.   && Imprimir peso na etiqueta
    this_cNomeImpressora = ""    && Nome da impressora Windows selecionada
    this_nTpImpressora   = 0     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts        = 0     && Ajuste vertical de impressao
    this_nAjHorzs        = 0     && Ajuste horizontal de impressao
    this_nAjDenss        = 10   && Densidade de impressao (10-20)
    this_nAjVelos        = 3     && Velocidade de impressao (1-3)

    *-- Titulo dinamico do label de pesos (depende do form pai)
    this_cTituloEnvelopes = ""   && Caption dinamico: "Peso por [Titulo do pai]"

    *-- Modo herdado do form pai (INSERIR/ALTERAR) para DtFechas
    this_cModoParent = ""

    *-- Flags de SigCdOpd para controle de impressao de etiquetas
    this_nChkUnis = 0    && Verifica se usa unidades para etiquetas
    this_nEtiqs   = 0    && Flag de etiquetas habilitadas

    *--------------------------------------------------------------------------
    * Init - Configuracao basica do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le cursor TmpNens e popula propriedades do BO
    * par_cAliasCursor: nome do alias "TmpNens" (cursor do form pai)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            GO TOP
            THIS.this_cEmps     = ALLTRIM(NVL(Emps,  ""))
            THIS.this_cDopps    = ALLTRIM(NVL(Dopps, ""))
            THIS.this_nNumps    = NVL(Numps, 0)
            THIS.this_dDatas    = NVL(DataS, {})
            THIS.this_cPosicaor = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 10)
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta Emps+Dopps+Str(Numps,10)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPosicaor
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form operacional sem persistencia direta
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarModoCntOps - Consulta SigCdOpd.ResumoPOp para determinar layout
    * Popula: this_lExibeCntOps, this_nChkUnis, this_nEtiqs
    *--------------------------------------------------------------------------
    PROCEDURE VerificarModoCntOps()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_TmpOpd")
                TABLEREVERT(.T., "cursor_4c_TmpOpd")
                USE IN cursor_4c_TmpOpd
            ENDIF

            loc_cSQL = "SELECT ResumoPOp, ChkUnis, Etiqs FROM SigCdOpd WHERE Dopes = " + EscaparSQL(THIS.this_cDopps)
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpd")

            IF loc_nRet > 0
                SELECT cursor_4c_TmpOpd
                IF NOT EOF()
                    IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                        THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                    ELSE
                        IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                            THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                        ELSE
                            IF VARTYPE(cursor_4c_TmpOpd.ResumoPOp) = "L"
                                THIS.this_lExibeCntOps = cursor_4c_TmpOpd.ResumoPOp
                            ELSE
                                THIS.this_lExibeCntOps = (NVL(cursor_4c_TmpOpd.ResumoPOp, 0) = 1)
                            ENDIF
                        ENDIF
                    ENDIF
                    THIS.this_nChkUnis     = NVL(cursor_4c_TmpOpd.ChkUnis, 0)
                    THIS.this_nEtiqs       = NVL(cursor_4c_TmpOpd.Etiqs,   0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao verificar modo de exibi" + CHR(231) + CHR(227) + "o.", "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursores - Cria cursores de trabalho para os grids
    * Cursores criados: xTotEnv, xTotMat, xTotPed, xTotMatOp, xMatOp, xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            SET NULL ON

            IF USED("xTotEnv")
                USE IN xTotEnv
            ENDIF
            CREATE CURSOR xTotEnv (Nenvs N(10) NULL, Entrada N(12,3) NULL, Saida N(12,3) NULL)
            INDEX ON Nenvs TAG Nenvs

            IF USED("xTotMat")
                USE IN xTotMat
            ENDIF
            CREATE CURSOR xTotMat (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xTotPed")
                USE IN xTotPed
            ENDIF
            CREATE CURSOR xTotPed (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Repres C(50) NULL, Flag N(1) NULL, DtFechas D NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            IF USED("xTotMatOp")
                USE IN xTotMatOp
            ENDIF
            CREATE CURSOR xTotMatOp (CMats C(14) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL)
            INDEX ON CMats TAG CMats

            IF USED("xMatOp")
                USE IN xMatOp
            ENDIF
            CREATE CURSOR xMatOp (CMats C(14) NULL, DPros C(40) NULL, CUnis C(3) NULL, Qtds N(10,3) NULL, Pesos N(10,3) NULL, Nops N(10) NULL)
            INDEX ON STR(Nops, 10) + CMats TAG NopMats

            IF USED("xTotPedOp")
                USE IN xTotPedOp
            ENDIF
            CREATE CURSOR xTotPedOp (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, MascNum C(6) NULL, NConta C(50) NULL, Flag N(1) NULL, DtFechas D NULL, Nops N(10) NULL)
            INDEX ON Emps + Dopes + STR(Numes, 6) + STR(Nops, 10) TAG EdnNops

            SET NULL OFF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET NULL OFF
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEnvelopes - Processa xPesa e popula xTotEnv.Saida
    * Agrupa pesos por envelope e insere totais em xTotEnv
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEnvelopes()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF
            SELECT Nenvs, SUM(Peso) AS tPeso ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR cursor_4c_TmpEnv READWRITE
            SET NULL OFF

            SELECT cursor_4c_TmpEnv
            SCAN
                LOCAL loc_nNenvE, loc_nPesoE
                loc_nNenvE = cursor_4c_TmpEnv.Nenvs
                loc_nPesoE = cursor_4c_TmpEnv.tPeso

                SELECT xTotEnv
                IF NOT SEEK(loc_nNenvE)
                    INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (loc_nNenvE, 0, 0)
                ENDIF
                REPLACE Saida WITH loc_nPesoE IN xTotEnv

                RELEASE loc_nNenvE, loc_nPesoE
                SELECT cursor_4c_TmpEnv
            ENDSCAN

            IF USED("cursor_4c_TmpEnv")
                USE IN cursor_4c_TmpEnv
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRateio - Ajusta quantidades/pesos de xNensi conforme logica de rateio
    * Distribui proporcional o peso da pesagem entre os itens de rateio=2
    * Rateio=3: descontado da pesagem total
    * Rateio=2: recebe proporcao + saldo de arredondamento no primeiro registro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarRateio()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF NOT USED("xPesa") OR NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SET NULL ON
            IF USED("xRateio")
                USE IN xRateio
            ENDIF
            SELECT Nenvs, SUM(Peso) AS Pesos ;
                FROM xPesa ;
                GROUP BY Nenvs ;
                ORDER BY Nenvs ;
                INTO CURSOR xRateio READWRITE
            SET NULL OFF

            SELECT xRateio
            SCAN
                LOCAL loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                loc_nNenv    = xRateio.Nenvs
                loc_nPesagem = xRateio.Pesos
                loc_nPesoAnt = 0
                loc_nRecno   = 0

                SELECT xNensi
                SCAN FOR (Rateio = 3) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    loc_nPesagem = loc_nPesagem - Pesos
                ENDSCAN

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    IF loc_nRecno = 0
                        loc_nRecno = RECNO()
                    ENDIF
                    loc_nPesoAnt = loc_nPesoAnt + PsFaseAnt
                ENDSCAN

                loc_nDifPeso = loc_nPesagem - loc_nPesoAnt

                SELECT xNensi
                SCAN FOR (Rateio = 2) AND (Nenvs = loc_nNenv) AND NOT FlagIncs
                    LOCAL loc_nDiv, loc_nNovoPeso
                    loc_nDiv      = IIF(loc_nPesoAnt = 0, 1, loc_nPesoAnt)
                    loc_nNovoPeso = ROUND(PsFaseAnt + (PsFaseAnt / loc_nDiv * loc_nDifPeso), 2)
                    REPLACE Pesos WITH loc_nNovoPeso, Qtds WITH loc_nNovoPeso
                    loc_nPesagem  = loc_nPesagem - loc_nNovoPeso
                    RELEASE loc_nDiv, loc_nNovoPeso
                ENDSCAN

                IF (loc_nRecno <> 0) AND (loc_nPesagem <> 0)
                    SELECT xNensi
                    GO loc_nRecno
                    REPLACE Pesos WITH xNensi.Pesos + loc_nPesagem, ;
                            Qtds  WITH xNensi.Qtds  + loc_nPesagem
                ENDIF

                RELEASE loc_nNenv, loc_nPesagem, loc_nPesoAnt, loc_nRecno, loc_nDifPeso
                SELECT xRateio
            ENDSCAN

            IF USED("xRateio")
                USE IN xRateio
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMateriais - Processa xNensi e popula xTotMat + atualiza xTotEnv.Entrada
    * Para cada item com Rateio in (2,3,5): acumula Qtds/Pesos em xTotMat
    * e acumula PsFaseAnt em xTotEnv.Entrada
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMateriais()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)

                    SELECT xTotMat
                    IF NOT SEEK(loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xTotMat (CMats, DPros, CUnis, Qtds, Pesos) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0)
                    ENDIF

                    REPLACE Qtds  WITH xTotMat.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xTotMat.Pesos + xNensi.Pesos IN xTotMat

                    SELECT xTotEnv
                    IF NOT SEEK(xNensi.Nenvs)
                        INSERT INTO xTotEnv (Nenvs, Entrada, Saida) VALUES (xNensi.Nenvs, 0, 0)
                    ENDIF
                    REPLACE Entrada WITH xTotEnv.Entrada + xNensi.PsFaseAnt IN xTotEnv

                    SELECT xNensi
                ENDIF
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPedidosBaixados - Processa xMFas e popula xTotPed + xTotPedOp
    * Para cada OP (xMFas.Nops): busca pedidos via SigOpPic, monta NConta via
    * SigMvCab + SigCdCli e insere em xTotPed e xTotPedOp
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPedidosBaixados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cEmp, loc_cEdn, loc_cNConta, loc_cConta, loc_cVends, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xMFas")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xMFas
            SCAN
                loc_nNops = xMFas.Nops

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cEmp = IIF(EMPTY(cursor_4c_LocalOpi.EmpDs), ;
                                       ALLTRIM(cursor_4c_LocalOpi.Emps), ;
                                       ALLTRIM(cursor_4c_LocalOpi.EmpDs))
                        loc_cEdn = loc_cEmp + ALLTRIM(cursor_4c_LocalOpi.Dopes) + STR(cursor_4c_LocalOpi.Numes, 6)

                        SELECT xTotPed
                        IF NOT SEEK(loc_cEdn)
                            IF USED("cursor_4c_LocalEest")
                                TABLEREVERT(.T., "cursor_4c_LocalEest")
                                USE IN cursor_4c_LocalEest
                            ENDIF
                            loc_cSQL = "SELECT ContaOs, ContaDs, Vends FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)
                            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                            IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalEest")
                                SELECT cursor_4c_LocalEest
                                loc_cConta = IIF(EMPTY(cursor_4c_LocalEest.ContaDs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaOs), ;
                                                 ALLTRIM(cursor_4c_LocalEest.ContaDs))
                                loc_cVends = ALLTRIM(NVL(cursor_4c_LocalEest.Vends, ""))
                            ELSE
                                loc_cConta = ""
                                loc_cVends = ""
                            ENDIF

                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            IF NOT EMPTY(loc_cConta)
                                loc_cSQL = "SELECT RClis FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
                                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                                IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalCli")
                                    SELECT cursor_4c_LocalCli
                                    loc_cNConta = loc_cConta + " / " + ALLTRIM(NVL(RClis, ""))
                                ELSE
                                    loc_cNConta = loc_cConta
                                ENDIF
                            ELSE
                                loc_cNConta = ""
                            ENDIF

                            SELECT cursor_4c_LocalOpi
                            INSERT INTO xTotPed (Emps, Dopes, Numes, MascNum, NConta, Repres, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_cVends, 0)

                            INSERT INTO xTotPedOp (Emps, Dopes, Numes, MascNum, NConta, Nops, Flag) ;
                                VALUES (loc_cEmp, ALLTRIM(cursor_4c_LocalOpi.Dopes), ;
                                        cursor_4c_LocalOpi.Numes, ;
                                        ALLTRIM(STR(cursor_4c_LocalOpi.Numes, 6)), ;
                                        loc_cNConta, loc_nNops, 0)
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                SELECT xMFas
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarResumoPorOP - Processa xNensi e popula xMatOp; copia xTotMat em xTotMatOp
    * Para cada item com Rateio in (2,3,5): acumula em xMatOp indexado por Nops+CMats
    *--------------------------------------------------------------------------
    PROCEDURE CarregarResumoPorOP()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cCMats, loc_cDPros, loc_cCUnis, loc_nNops
        loc_lSucesso = .F.

        IF NOT USED("xNensi")
            RETURN loc_lSucesso
        ENDIF

        TRY
            SELECT xNensi
            SET ORDER TO
            SCAN
                IF INLIST(xNensi.Rateio, 2, 3, 5)
                    loc_cCMats = ALLTRIM(xNensi.CMats)
                    loc_nNops  = xNensi.Nops

                    SELECT xMatOp
                    IF NOT SEEK(STR(loc_nNops, 10) + loc_cCMats)
                        IF USED("cursor_4c_LocalPro")
                            TABLEREVERT(.T., "cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                        loc_cSQL = "SELECT CUnis, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCMats)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalPro")
                            SELECT cursor_4c_LocalPro
                            loc_cDPros = ALLTRIM(NVL(DPros, ""))
                            loc_cCUnis = ALLTRIM(NVL(CUnis, ""))
                        ELSE
                            loc_cDPros = ""
                            loc_cCUnis = ""
                        ENDIF

                        INSERT INTO xMatOp (CMats, DPros, CUnis, Qtds, Pesos, Nops) ;
                            VALUES (loc_cCMats, loc_cDPros, loc_cCUnis, 0, 0, loc_nNops)
                    ENDIF

                    REPLACE Qtds  WITH xMatOp.Qtds  + xNensi.Qtds, ;
                            Pesos WITH xMatOp.Pesos + xNensi.Pesos IN xMatOp

                    SELECT xNensi
                ENDIF
            ENDSCAN

            SELECT xTotMat
            SCAN
                INSERT INTO xTotMatOp (CMats, CUnis, Qtds, Pesos) ;
                    VALUES (xTotMat.CMats, xTotMat.CUnis, xTotMat.Qtds, xTotMat.Pesos)
            ENDSCAN

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarPedidosFechados - Verifica SigCdNec (ChkSubn) por pedido em xTotPed
    * Remove pedidos em aberto (Flag=0) e preenche DtFechas nos fechados
    *--------------------------------------------------------------------------
    PROCEDURE MarcarPedidosFechados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChave, loc_lAberto, loc_cChaveP
        loc_lSucesso = .F.

        TRY
            SELECT xTotPed
            SCAN
                loc_cChave  = ALLTRIM(Emps) + ALLTRIM(Dopes) + STR(Numes, 6)
                loc_lAberto = .F.

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Emps, Dopps, Nops FROM SigOpPic WHERE EmpDopNums = " + EscaparSQL(loc_cChave)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalOpi
                    SCAN
                        loc_cChaveP = ALLTRIM(cursor_4c_LocalOpi.Emps) + ;
                                      ALLTRIM(cursor_4c_LocalOpi.Dopps) + ;
                                      STR(cursor_4c_LocalOpi.Nops, 10)

                        IF USED("cursor_4c_LocalNens")
                            TABLEREVERT(.T., "cursor_4c_LocalNens")
                            USE IN cursor_4c_LocalNens
                        ENDIF
                        loc_cSQL = "SELECT ChkSubn FROM SigCdNec WHERE EmpDNPs = " + EscaparSQL(loc_cChaveP)
                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalNens")

                        IF loc_nRet > 0 AND NOT EOF("cursor_4c_LocalNens")
                            SELECT cursor_4c_LocalNens
                            IF NOT NVL(ChkSubn, .F.)
                                loc_lAberto = .T.
                                EXIT
                            ENDIF
                        ELSE
                            loc_lAberto = .T.
                            EXIT
                        ENDIF

                        SELECT cursor_4c_LocalOpi
                    ENDSCAN
                ENDIF

                IF NOT loc_lAberto
                    REPLACE Flag WITH 1 IN xTotPed
                ENDIF

                SELECT xTotPed
            ENDSCAN

            SELECT xTotPed
            DELETE FOR Flag = 0
            PACK

            IF INLIST(THIS.this_cModoParent, "INSERIR", "ALTERAR")
                IF USED("TmpNens")
                    SELECT TmpNens
                    LOCAL loc_dDataS
                    loc_dDataS = NVL(DataS, DATE())
                    SELECT xTotPed
                    SCAN
                        REPLACE DtFechas WITH loc_dDataS
                    ENDSCAN
                    RELEASE loc_dDataS
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Orquestra o processo completo de carregamento de dados
    * Sequencia: PrepararCursores > Envelopes > Rateio > Materiais >
    *            PedidosBaixados > ResumoPorOP > MarcarFechados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararCursores()
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarEnvelopes()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.ProcessarRateio()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarMateriais()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarPedidosBaixados()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.CarregarResumoPorOP()
            ENDIF
            IF loc_lSucesso
                loc_lSucesso = THIS.MarcarPedidosFechados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Cria crImpreV combinando impressoras SQL + Windows
    * Consulta: SigSyImp/SigCdAcG para impressoras autorizadas ao usuario
    *           APRINTERS() para impressoras instaladas no Windows
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_nPrinters, loc_aPrinters, loc_nI
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b" + ;
                       " WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.cimps = b.impres" + ;
                       " UNION ALL " + ;
                       "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c" + ;
                       " WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

            IF USED("cursor_4c_TmpCimp")
                TABLEREVERT(.T., "cursor_4c_TmpCimp")
                USE IN cursor_4c_TmpCimp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")

            IF loc_nRet <= 0
                MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_SigCdmp")
                TABLEREVERT(.T., "cursor_4c_SigCdmp")
                USE IN cursor_4c_SigCdmp
            ENDIF

            IF RECCOUNT("cursor_4c_TmpCimp") > 0
                SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_TmpCimp ;
                    INTO CURSOR cursor_4c_SigCdmp READWRITE
                SELECT cursor_4c_SigCdmp
                INDEX ON Impres TAG skImpres
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_SigCdmp (Impres C(50) NULL, nTpImpres N(2) NULL)
                INDEX ON Impres TAG skImpres
                SET NULL OFF
            ENDIF

            DIMENSION loc_aPrinters(1)
            loc_nPrinters = APRINTERS(loc_aPrinters)

            IF loc_nPrinters = 0
                MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_ImpWin (Impres C(50) NULL)
            SET NULL OFF
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_ImpWin (Impres) VALUES (UPPER(loc_aPrinters(loc_nI, 1)))
            ENDFOR

            IF USED("cursor_4c_ImpMatch")
                TABLEREVERT(.T., "cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.Impres) AS IDupla, ;
                   b.Impres, a.Impres AS impresS ;
                FROM cursor_4c_SigCdmp a, cursor_4c_ImpWin b ;
                WHERE ALLTRIM(UPPER(a.Impres)) LIKE "%" + ALLTRIM(UPPER(b.Impres)) + "%" ;
                GROUP BY b.Impres, a.Impres ;
                INTO CURSOR cursor_4c_ImpMatch READWRITE

            IF RECCOUNT("cursor_4c_ImpMatch") > 1
                SELECT cursor_4c_ImpMatch
                APPEND BLANK
            ENDIF

            IF USED("crImpreV")
                USE IN crImpreV
            ENDIF
            SELECT * FROM cursor_4c_ImpMatch ORDER BY 1 INTO CURSOR crImpreV READWRITE

            SELECT crImpreV
            GO TOP

            IF USED("cursor_4c_ImpMatch")
                USE IN cursor_4c_ImpMatch
            ENDIF
            IF USED("cursor_4c_ImpWin")
                USE IN cursor_4c_ImpWin
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressao - Monta cursor dbImpressao para uso por SigOpEtq
    * par_nTipoEtq: codigo do tipo de etiqueta selecionado (SigCdTpe.nTipos)
    * Cursor dbImpressao fica disponivel para o form chamar =SigOpEtq(...)
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDbImpressao(par_nTipoEtq)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        LOCAL loc_cChaveNs
        loc_lSucesso = .F.

        TRY
            loc_cChaveNs = THIS.this_cEmps + THIS.this_cDopps + STR(THIS.this_nNumps, 6)

            IF USED("dbImpressao")
                USE IN dbImpressao
            ENDIF
            SET NULL ON
            CREATE CURSOR dbImpressao (Cpros C(14) NULL, Dpros C(40) NULL, Qtds N(1) NULL, ;
                                       QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL, ;
                                       Nops N(10) NULL, Notas C(6) NULL, Aros C(50) NULL, ;
                                       Pesos N(12,3) NULL, Contas C(10) NULL, ;
                                       EmpDopNums C(29) NULL, Reffs C(20) NULL, ;
                                       empos C(3) NULL, cpros1 C(14) NULL, codtams C(4) NULL)
            SET NULL OFF

            IF par_nTipoEtq = 74
                THIS.PrepararDbImpressaoOP(loc_cChaveNs)
            ELSE
                THIS.PrepararDbImpressaoPadrao(par_nTipoEtq, loc_cChaveNs)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoOP - Preenche dbImpressao para etiqueta de OP (tipo 74)
    * Consulta SigOpEtq + SigEtPos e lookup em SigCdPro, SigCdOpe, SigCdPsg, SigOpPic
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoOP(par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
        LOCAL loc_lColecoes, loc_cClassis, loc_cAro, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF

            loc_cSQL = "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " UNION ALL " + ;
                       "SELECT Cpros,Nops,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs," + ;
                       "CodTams,Pesos,CodCors,Peso2s FROM SigEtPos" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Nops"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros  = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_cDopeOs = ALLTRIM(cursor_4c_LocalEti.DopeOs)
                loc_nNops   = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT Cpros,CGrus,SGrus,DPros,Colecoes FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopeOs)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cCGrus    = ALLTRIM(NVL(CGrus, ""))
                    loc_cSGrus    = ALLTRIM(NVL(SGrus, ""))
                    loc_cDPros    = ALLTRIM(NVL(DPros, ""))
                    loc_lColecoes = NOT EMPTY(NVL(Colecoes, ""))
                ELSE
                    loc_cCGrus    = ""
                    loc_cSGrus    = ""
                    loc_cDPros    = ""
                    loc_lColecoes = .F.
                ENDIF

                IF USED("cursor_4c_LocalSGru")
                    TABLEREVERT(.T., "cursor_4c_LocalSGru")
                    USE IN cursor_4c_LocalSGru
                ENDIF
                loc_cSQL = "SELECT Descricaos FROM SigCdPsg WHERE CGruCods = " + EscaparSQL(loc_cCGrus + loc_cSGrus)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalSGru")

                IF USED("cursor_4c_LocalOpi")
                    TABLEREVERT(.T., "cursor_4c_LocalOpi")
                    USE IN cursor_4c_LocalOpi
                ENDIF
                loc_cSQL = "SELECT Notas,CodTams,CodCors,Numes,dopes FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                loc_cAro = ""

                IF NOT EOF("cursor_4c_LocalOpi")
                    SELECT cursor_4c_LocalOpi
                    LOCAL loc_lNaoN, loc_nNumeOs, loc_cDopesOi
                    loc_lNaoN   = NOT EMPTY(NVL(notas, ""))
                    loc_nNumeOs = NVL(Numes, 0)
                    loc_cDopesOi = ALLTRIM(NVL(dopes, ""))

                    loc_cClassis = PADC(IIF(loc_lColecoes AND loc_cSGrus <> PADR("N", 6), ;
                                            "Fundi" + CHR(231) + CHR(227) + "o", ;
                                            IIF(loc_lNaoN, "Os", "Alian" + CHR(231) + "a")), 10)

                    IF loc_cClassis = PADC("Os", 10)
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                        SELECT DISTINCT CodTams FROM cursor_4c_LocalOpi ;
                            INTO CURSOR cursor_4c_CsSelecao READWRITE ;
                            ORDER BY CodTams
                        SELECT cursor_4c_CsSelecao
                        SCAN
                            loc_cAro = loc_cAro + ALLTRIM(NVL(CodTams, "")) + "/"
                        ENDSCAN
                        IF USED("cursor_4c_CsSelecao")
                            USE IN cursor_4c_CsSelecao
                        ENDIF
                    ENDIF

                    IF NOT EOF("cursor_4c_LocalOpe")
                        SELECT cursor_4c_LocalOpe
                        loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                    ELSE
                        loc_cAbrevs = ""
                    ENDIF

                    SELECT cursor_4c_LocalEti
                    INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs, Nops, Notas, Aros, Pesos) ;
                        VALUES (loc_cCPros, loc_cDPros, 1, ;
                                NVL(cursor_4c_LocalEti.Qtds, 0), ;
                                loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                                ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")), ;
                                loc_nNops, ;
                                PADR(IIF(loc_lNaoN, ALLTRIM(NVL(cursor_4c_LocalOpi.notas, "")), ""), 6), ;
                                PADR(loc_cAro, 50), ;
                                NVL(cursor_4c_LocalEti.Pesos, 0))

                    RELEASE loc_lNaoN, loc_nNumeOs, loc_cDopesOi, loc_cClassis
                ENDIF

                RELEASE loc_cCPros, loc_cDopeOs, loc_cDPros, loc_cCGrus, loc_cSGrus
                RELEASE loc_lColecoes, loc_cAro, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDbImpressaoPadrao - Preenche dbImpressao para tipos de etiqueta nao-OP
    * Consulta SigOpEtq; para tipos 14,39,109,113 inclui dados de SigMvCab/SigCdCli
    * Se ChkUnis=1 e Etiqs=1, inclui etiquetas extras de SigEtPos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDbImpressaoPadrao(par_nTipoEtq, par_cChaveNs)
        LOCAL loc_cSQL, loc_nRet
        LOCAL loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs

        TRY
            IF USED("cursor_4c_LocalEti")
                TABLEREVERT(.T., "cursor_4c_LocalEti")
                USE IN cursor_4c_LocalEti
            ENDIF
            loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs AS Obs,Emps,Numes,Dopes,Empos,DopeOs,NumeOs,Nops" + ;
                       " FROM SigOpEtq" + ;
                       " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs) + ;
                       " ORDER BY Cbars"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEti")

            IF loc_nRet <= 0
                RETURN
            ENDIF

            SELECT cursor_4c_LocalEti
            SCAN
                loc_cCPros = ALLTRIM(cursor_4c_LocalEti.CPros)
                loc_nCBars = cursor_4c_LocalEti.Cbars
                loc_nNops  = cursor_4c_LocalEti.Nops

                IF USED("cursor_4c_LocalPro")
                    TABLEREVERT(.T., "cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
                loc_cSQL = "SELECT CGrus, SGrus, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_cCPros)
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF NOT EOF("cursor_4c_LocalPro")
                    SELECT cursor_4c_LocalPro
                    loc_cDPros = ALLTRIM(NVL(DPros, ""))
                ELSE
                    loc_cDPros = ""
                ENDIF

                IF USED("cursor_4c_LocalOpe")
                    TABLEREVERT(.T., "cursor_4c_LocalOpe")
                    USE IN cursor_4c_LocalOpe
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.Dopes))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpe")

                IF USED("cursor_4c_LocalOpeO")
                    TABLEREVERT(.T., "cursor_4c_LocalOpeO")
                    USE IN cursor_4c_LocalOpeO
                ENDIF
                loc_cSQL = "SELECT Abrevs, globalizas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(cursor_4c_LocalEti.DopeOs))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpeO")

                IF NOT EOF("cursor_4c_LocalOpe")
                    SELECT cursor_4c_LocalOpe
                    loc_cAbrevs = ALLTRIM(NVL(Abrevs, ""))
                ELSE
                    loc_cAbrevs = ""
                ENDIF

                SELECT cursor_4c_LocalEti
                INSERT INTO dbImpressao (CPros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                    VALUES (STR(loc_nCBars, 14), loc_cDPros, 1, ;
                            NVL(cursor_4c_LocalEti.Qtds, 0), ;
                            loc_cAbrevs + " : " + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), ;
                            ALLTRIM(NVL(cursor_4c_LocalEti.Obs, "")))

                IF INLIST(par_nTipoEtq, 14, 39, 109, 113)
                    IF USED("cursor_4c_LocalOpi")
                        TABLEREVERT(.T., "cursor_4c_LocalOpi")
                        USE IN cursor_4c_LocalOpi
                    ENDIF
                    loc_cSQL = "SELECT Emps, Dopes, Numes, EmpDs FROM SigOpPic WHERE Nops = " + FormatarNumeroSQL(loc_nNops)
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalOpi")

                    IF NOT EOF("cursor_4c_LocalOpi")
                        SELECT cursor_4c_LocalOpi

                        LOCAL loc_cEdnL
                        loc_cEdnL = ALLTRIM(cursor_4c_LocalEti.Empos) + ;
                                    ALLTRIM(cursor_4c_LocalEti.DopeOs) + ;
                                    STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)

                        IF USED("cursor_4c_LocalEest")
                            TABLEREVERT(.T., "cursor_4c_LocalEest")
                            USE IN cursor_4c_LocalEest
                        ENDIF
                        loc_cSQL = "SELECT ContaOs, ContaDs FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdnL)
                        SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEest")

                        LOCAL loc_lGlobaliza, loc_cContaL
                        IF NOT EOF("cursor_4c_LocalOpeO")
                            SELECT cursor_4c_LocalOpeO
                            IF VARTYPE(globalizas) = "L"
                                loc_lGlobaliza = globalizas
                            ELSE
                                IF VARTYPE(globalizas) = "L"
                                    loc_lGlobaliza = globalizas
                                ELSE
                                    IF VARTYPE(globalizas) = "L"
                                        loc_lGlobaliza = globalizas
                                    ELSE
                                        loc_lGlobaliza = (NVL(globalizas, 0) = 1)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            loc_lGlobaliza = .F.
                        ENDIF

                        IF NOT EOF("cursor_4c_LocalEest")
                            SELECT cursor_4c_LocalEest
                            loc_cContaL = IIF(loc_lGlobaliza, ;
                                              ALLTRIM(NVL(ContaOs, "")), ;
                                              ALLTRIM(NVL(ContaDs, "")))
                        ELSE
                            loc_cContaL = ""
                        ENDIF

                        IF INLIST(par_nTipoEtq, 109, 113)
                            IF USED("cursor_4c_LocalCli")
                                TABLEREVERT(.T., "cursor_4c_LocalCli")
                                USE IN cursor_4c_LocalCli
                            ENDIF
                            loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cContaL)
                            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalCli")
                            IF NOT EOF("cursor_4c_LocalCli")
                                SELECT cursor_4c_LocalCli
                                loc_cContaL = ALLTRIM(NVL(Rclis, ""))
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_LocalEti
                        IF par_nTipoEtq <> 14
                            REPLACE Pedido WITH loc_cContaL + ;
                                IIF(INLIST(par_nTipoEtq, 39), "/" + ALLTRIM(STR(NVL(cursor_4c_LocalEti.NumeOs, 0), 6)), "") ;
                                IN dbImpressao
                        ELSE
                            REPLACE Contas WITH loc_cContaL IN dbImpressao
                        ENDIF

                        RELEASE loc_cEdnL, loc_lGlobaliza, loc_cContaL
                    ENDIF
                ENDIF

                RELEASE loc_cCPros, loc_cDPros, loc_nCBars, loc_nNops, loc_cAbrevs
                SELECT cursor_4c_LocalEti
            ENDSCAN

            IF THIS.this_nChkUnis = 1 AND THIS.this_nEtiqs = 1
                IF USED("cursor_4c_LocalEtiPos")
                    TABLEREVERT(.T., "cursor_4c_LocalEtiPos")
                    USE IN cursor_4c_LocalEtiPos
                ENDIF
                loc_cSQL = "SELECT Cpros,Cbars,Qtds,ObsEtiqs,Emps,Numes,Dopes FROM SigEtPos" + ;
                           " WHERE EmpDopNums = " + EscaparSQL(par_cChaveNs)
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalEtiPos")

                IF loc_nRet > 0
                    SELECT cursor_4c_LocalEtiPos
                    SCAN
                        INSERT INTO dbImpressao (CPros, Qtds) ;
                            VALUES (cursor_4c_LocalEtiPos.CPros, cursor_4c_LocalEtiPos.Qtds)
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

