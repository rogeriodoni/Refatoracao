# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_ESTOQUES, CNT_4C_LINHAS, CNT_4C_REQUISICOES. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2980 linhas total):

*-- Linhas 50 a 224:
50:     *==========================================================================
51:     * Init - compartilha datasession do pai e repassa parametros
52:     *==========================================================================
53:     PROCEDURE Init(par_oParentForm, par_dData, par_lReserva, par_nEmphpdr, par_lAutomatico, par_nNumerodaop)
54:         IF VARTYPE(par_oParentForm) = "O"
55:             THIS.DataSessionId = par_oParentForm.DataSessionId
56:         ENDIF
57:         THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
58:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutomatico) = "L", par_lAutomatico, .F.)
59:         THIS.this_nEmphpdr    = IIF(VARTYPE(par_nEmphpdr)    = "N", par_nEmphpdr,    0)
60:         THIS.this_nNumerodaop = IIF(VARTYPE(par_nNumerodaop) = "N", par_nNumerodaop, 0)
61:         THIS.this_oParentForm = IIF(VARTYPE(par_oParentForm) = "O", par_oParentForm, .NULL.)
62:         IF THIS.this_lReserva
63:             THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
64:         ELSE
65:             THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
66:         ENDIF
67:         RETURN DODEFAULT()
68:     ENDPROC
69: 
70:     *==========================================================================
71:     * Destroy
72:     *==========================================================================
73:     PROCEDURE Destroy()
74:         DODEFAULT()
75:     ENDPROC
76: 
77:     *==========================================================================
78:     * InicializarForm - criado pelo FormBase.Init via DODEFAULT
79:     *==========================================================================
80:     PROTECTED PROCEDURE InicializarForm()
81:         LOCAL loc_lSucesso, loc_oErro
82:         loc_lSucesso = .F.
83:         TRY
84:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
85:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
86:                 MsgErro("Falha ao criar SigPrGlpBO.", "Erro")
87:             ELSE
88:                 WITH THIS.this_oBusinessObject
89:                     .this_lReserva    = THIS.this_lReserva
90:                     .this_lAutomatico = THIS.this_lAutomatico
91:                     .this_nNumerodaop = THIS.this_nNumerodaop
92:                     .this_cEmphpdr    = TRANSFORM(THIS.this_nEmphpdr)
93:                     .this_oParentForm = THIS.this_oParentForm
94:                 ENDWITH
95:                 THIS.ConfigurarPageFrame()
96:                 THIS.ConfigurarCabecalho()
97:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
98:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
99:                 THIS.ConfigurarBotoesPrincipais()
100:                 THIS.ConfigurarGradeItens()
101:                 THIS.ConfigurarContainerInfo()
102:                 THIS.ConfigurarContainerDisponivel()
103:                 THIS.ConfigurarContainerEstoques()
104:                 THIS.ConfigurarContainerLinhas()
105:                 THIS.ConfigurarContainerRequisicoes()
106:                 THIS.ConfigurarTotais()
107:                 THIS.ConfigurarObsItens()
108:                 THIS.ConfigurarPaginaDados()
109:                 THIS.TornarControlesVisiveis()
110:                 THIS.InicializarDados()
111:                 THIS.ConfigurarEventos()
112:                 THIS.AjustarBotaoPedras()
113:                 loc_lSucesso = .T.
114:             ENDIF
115:         CATCH TO loc_oErro
116:             MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
117:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
118:         ENDTRY
119:         RETURN loc_lSucesso
120:     ENDPROC
121: 
122:     *==========================================================================
123:     * ConfigurarPageFrame - ancora de layout do form OPERACIONAL
124:     *
125:     * OPERACIONAL nao possui PageFrame (layout flat: containers direto no Form).
126:     * Este metodo faz o papel equivalente ao ConfigurarPageFrame dos forms CRUD:
127:     * define a imagem de fundo do Form antes de instanciar os containers filhos.
128:     *==========================================================================
129:     PROTECTED PROCEDURE ConfigurarPageFrame()
130:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarCabecalho - equivale ao cntSombra legado
135:     *==========================================================================
136:     PROTECTED PROCEDURE ConfigurarCabecalho()
137:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
138:         WITH THIS.cnt_4c_Cabecalho
139:             .Top        = 0
140:             .Left       = 0
141:             .Width      = 1004
142:             .Height     = 80
143:             .BackStyle  = 1
144:             .BackColor  = RGB(100,100,100)
145:             .BorderWidth = 0
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .AutoSize  = .F.
149:                 .FontBold  = .T.
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 18
152:                 .WordWrap  = .T.
153:                 .Alignment = 0
154:                 .BackStyle = 0
155:                 .Caption   = THISFORM.Caption
156:                 .Height    = 40
157:                 .Left      = 10
158:                 .Top       = 18
159:                 .Width     = THIS.Width
160:                 .ForeColor = RGB(0,0,0)
161:             ENDWITH
162:             .AddObject("lbl_4c_Titulo", "Label")
163:             WITH .lbl_4c_Titulo
164:                 .AutoSize  = .F.
165:                 .FontBold  = .T.
166:                 .FontName  = "Tahoma"
167:                 .FontSize  = 18
168:                 .WordWrap  = .T.
169:                 .Alignment = 0
170:                 .BackStyle = 0
171:                 .Caption   = THISFORM.Caption
172:                 .Height    = 46
173:                 .Left      = 10
174:                 .Top       = 17
175:                 .Width     = THIS.Width
176:                 .ForeColor = RGB(255,255,255)
177:             ENDWITH
178:         ENDWITH
179:     ENDPROC
180: 
181:     *==========================================================================
182:     * ConfigurarBotoesPrincipais - 7 botoes da barra superior
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
185:         LOCAL loc_lcIcones
186:         loc_lcIcones = gc_4c_CaminhoIcones
187: 
188:         THIS.AddObject("cmd_4c_Requisicoes", "CommandButton")
189:         WITH THIS.cmd_4c_Requisicoes
190:             .Top             = 3
191:             .Left            = 472
192:             .Height          = 75
193:             .Width           = 75
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .FontName        = "Tahoma"
197:             .FontSize        = 8
198:             .WordWrap        = .T.
199:             .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
200:             .Picture         = loc_lcIcones + "geral_datas_60.jpg"
201:             .DisabledPicture = loc_lcIcones + "geral_datas_60.jpg"
202:             .Themes          = .T.
203:             .ForeColor       = RGB(90,90,90)
204:             .BackColor       = RGB(255,255,255)
205:             .Enabled         = .F.
206:         ENDWITH
207: 
208:         THIS.AddObject("cmd_4c_Estoques", "CommandButton")
209:         WITH THIS.cmd_4c_Estoques
210:             .Top             = 3
211:             .Left            = 547
212:             .Height          = 75
213:             .Width           = 75
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontName        = "Tahoma"
217:             .FontSize        = 8
218:             .WordWrap        = .T.
219:             .Caption         = "\<Estoques"
220:             .Picture         = loc_lcIcones + "geral_marcar_60.jpg"
221:             .DisabledPicture = loc_lcIcones + "geral_marcar_60.jpg"
222:             .Themes          = .T.
223:             .ForeColor       = RGB(90,90,90)
224:             .BackColor       = RGB(255,255,255)

*-- Linhas 325 a 368:
325:     *==========================================================================
326:     * ConfigurarGradeItens - grid principal TmpFinal (9 colunas)
327:     *==========================================================================
328:     PROTECTED PROCEDURE ConfigurarGradeItens()
329:         THIS.AddObject("grd_4c_Itens", "Grid")
330:         WITH THIS.grd_4c_Itens
331:             .Top               = 125
332:             .Left              = 11
333:             .Height            = 224
334:             .Width             = 708
335:             .ColumnCount       = 9
336:             .FontSize          = 8
337:             .AllowHeaderSizing = .F.
338:             .AllowRowSizing    = .F.
339:             .DeleteMark        = .F.
340:             .RecordMark        = .F.
341:             .Panel             = 1
342:             .RowHeight         = 17
343:             .ScrollBars        = 2
344:             .GridLineColor     = RGB(238,238,238)
345:             WITH .Column1
346:                 .Width              = 115
347:                 .Movable            = .F.
348:                 .Resizable          = .F.
349:                 .ReadOnly           = .T.
350:                 .Header1.Caption    = "Produto"
351:                 .Header1.FontName   = "Verdana"
352:                 .Header1.FontSize   = 8
353:                 .Header1.Alignment  = 2
354:                 .Header1.ForeColor  = RGB(36,84,155)
355:                 .Text1.FontSize     = 8
356:                 .Text1.BorderStyle  = 0
357:                 .Text1.Margin       = 0
358:                 .Text1.ForeColor    = RGB(0,0,0)
359:                 .Text1.BackColor    = RGB(255,255,255)
360:             ENDWITH
361:             WITH .Column2
362:                 .ColumnOrder        = 2
363:                 .Width              = 38
364:                 .Movable            = .F.
365:                 .Resizable          = .F.
366:                 .ReadOnly           = .T.
367:                 .Header1.Caption    = "Cor"
368:                 .Header1.FontName   = "Verdana"

*-- Linhas 508 a 551:
508:     *==========================================================================
509:     * ConfigurarContainerInfo - Container3: painel informativo sempre visivel
510:     *==========================================================================
511:     PROTECTED PROCEDURE ConfigurarContainerInfo()
512:         THIS.AddObject("cnt_4c_Info", "Container")
513:         WITH THIS.cnt_4c_Info
514:             .Top         = 373
515:             .Left        = 12
516:             .Width       = 708
517:             .Height      = 205
518:             .SpecialEffect = 0
519:             .BackStyle   = 1
520:             .BackColor   = RGB(255,255,255)
521:             .BorderWidth = 0
522: 
523:             .AddObject("lbl_4c_TituloInfo", "Label")
524:             WITH .lbl_4c_TituloInfo
525:                 .AutoSize  = .T.
526:                 .FontBold  = .T.
527:                 .FontName  = "Tahoma"
528:                 .FontSize  = 9
529:                 .BackStyle = 0
530:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
531:                 .Height    = 16
532:                 .Left      = 6
533:                 .Top       = 5
534:                 .Width     = 118
535:                 .ForeColor = RGB(90,90,90)
536:             ENDWITH
537: 
538:             .AddObject("grd_4c_DispInfo", "Grid")
539:             WITH .grd_4c_DispInfo
540:                 .Top               = 24
541:                 .Left              = 6
542:                 .Height            = 148
543:                 .Width             = 444
544:                 .ColumnCount       = 6
545:                 .FontSize          = 8
546:                 .AllowHeaderSizing = .F.
547:                 .AllowRowSizing    = .F.
548:                 .DeleteMark        = .F.
549:                 .RecordMark        = .F.
550:                 .Panel             = 1
551:                 .RowHeight         = 16

*-- Linhas 750 a 793:
750:     *==========================================================================
751:     * ConfigurarContainerDisponivel - Container2: disponivel por produto
752:     *==========================================================================
753:     PROTECTED PROCEDURE ConfigurarContainerDisponivel()
754:         LOCAL loc_lcIcones
755:         loc_lcIcones = gc_4c_CaminhoIcones
756:         THIS.AddObject("cnt_4c_Disponivel", "Container")
757:         WITH THIS.cnt_4c_Disponivel
758:             .Top         = 125
759:             .Left        = 12
760:             .Width       = 708
761:             .Height      = 465
762:             .SpecialEffect = 0
763:             .Visible     = .F.
764:             .BackStyle   = 1
765:             .BackColor   = RGB(255,255,255)
766:             .BorderWidth = 0
767: 
768:             .AddObject("lbl_4c_TituloDisp", "Label")
769:             WITH .lbl_4c_TituloDisp
770:                 .AutoSize  = .T.
771:                 .FontBold  = .T.
772:                 .FontName  = "Tahoma"
773:                 .FontSize  = 10
774:                 .BackStyle = 0
775:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
776:                 .Height    = 18
777:                 .Left      = 610
778:                 .Top       = 10
779:                 .Width     = 123
780:                 .ForeColor = RGB(90,90,90)
781:             ENDWITH
782: 
783:             .AddObject("cmd_4c_SairDisp", "CommandButton")
784:             WITH .cmd_4c_SairDisp
785:                 .Top             = 3
786:                 .Left            = 620
787:                 .Height          = 75
788:                 .Width           = 75
789:                 .FontName        = "Tahoma"
790:                 .FontSize        = 8
791:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
792:                 .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
793:                 .Cancel          = .T.

*-- Linhas 960 a 1003:
960:     *==========================================================================
961:     * ConfigurarContainerEstoques - Container5: disponivel por conta/grupo
962:     *==========================================================================
963:     PROTECTED PROCEDURE ConfigurarContainerEstoques()
964:         LOCAL loc_lcIcones
965:         loc_lcIcones = gc_4c_CaminhoIcones
966:         THIS.AddObject("cnt_4c_Estoques", "Container")
967:         WITH THIS.cnt_4c_Estoques
968:             .Top         = 125
969:             .Left        = 12
970:             .Width       = 708
971:             .Height      = 465
972:             .SpecialEffect = 0
973:             .Visible     = .F.
974:             .BackStyle   = 1
975:             .BackColor   = RGB(255,255,255)
976:             .BorderWidth = 0
977: 
978:             .AddObject("lbl_4c_TituloEstq", "Label")
979:             WITH .lbl_4c_TituloEstq
980:                 .AutoSize  = .T.
981:                 .FontBold  = .T.
982:                 .FontName  = "Tahoma"
983:                 .FontSize  = 10
984:                 .BackStyle = 0
985:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
986:                 .Height    = 18
987:                 .Left      = 284
988:                 .Top       = 10
989:                 .Width     = 123
990:                 .ForeColor = RGB(90,90,90)
991:             ENDWITH
992: 
993:             .AddObject("cmd_4c_OkEstq", "CommandButton")
994:             WITH .cmd_4c_OkEstq
995:                 .Top             = 3
996:                 .Left            = 620
997:                 .Height          = 75
998:                 .Width           = 75
999:                 .FontBold        = .T.
1000:                 .FontItalic      = .T.
1001:                 .FontName        = "Tahoma"
1002:                 .FontSize        = 8
1003:                 .WordWrap        = .T.

*-- Linhas 1225 a 1268:
1225:     *==========================================================================
1226:     * ConfigurarContainerLinhas - Container1: pecas por linha
1227:     *==========================================================================
1228:     PROTECTED PROCEDURE ConfigurarContainerLinhas()
1229:         LOCAL loc_lcIcones
1230:         loc_lcIcones = gc_4c_CaminhoIcones
1231:         THIS.AddObject("cnt_4c_Linhas", "Container")
1232:         WITH THIS.cnt_4c_Linhas
1233:             .Top         = 125
1234:             .Left        = 12
1235:             .Width       = 708
1236:             .Height      = 465
1237:             .SpecialEffect = 0
1238:             .Visible     = .F.
1239:             .BackStyle   = 1
1240:             .BackColor   = RGB(255,255,255)
1241:             .BorderWidth = 0
1242: 
1243:             .AddObject("lbl_4c_TituloLin", "Label")
1244:             WITH .lbl_4c_TituloLin
1245:                 .AutoSize  = .T.
1246:                 .FontBold  = .T.
1247:                 .FontName  = "Tahoma"
1248:                 .FontSize  = 10
1249:                 .BackStyle = 0
1250:                 .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
1251:                 .Height    = 18
1252:                 .Left      = 259
1253:                 .Top       = 10
1254:                 .Width     = 170
1255:                 .ForeColor = RGB(90,90,90)
1256:             ENDWITH
1257: 
1258:             .AddObject("cmd_4c_OkLinhas", "CommandButton")
1259:             WITH .cmd_4c_OkLinhas
1260:                 .Top             = 3
1261:                 .Left            = 620
1262:                 .Height          = 75
1263:                 .Width           = 75
1264:                 .FontBold        = .T.
1265:                 .FontItalic      = .T.
1266:                 .FontName        = "Tahoma"
1267:                 .FontSize        = 8
1268:                 .WordWrap        = .T.

*-- Linhas 1372 a 1415:
1372:     *==========================================================================
1373:     * ConfigurarContainerRequisicoes - Container4: componentes adicionais
1374:     *==========================================================================
1375:     PROTECTED PROCEDURE ConfigurarContainerRequisicoes()
1376:         LOCAL loc_lcIcones
1377:         loc_lcIcones = gc_4c_CaminhoIcones
1378:         THIS.AddObject("cnt_4c_Requisicoes", "Container")
1379:         WITH THIS.cnt_4c_Requisicoes
1380:             .Top         = 125
1381:             .Left        = 12
1382:             .Width       = 708
1383:             .Height      = 465
1384:             .SpecialEffect = 0
1385:             .Visible     = .F.
1386:             .BackStyle   = 1
1387:             .BackColor   = RGB(255,255,255)
1388:             .BorderWidth = 0
1389: 
1390:             .AddObject("lbl_4c_TituloReq", "Label")
1391:             WITH .lbl_4c_TituloReq
1392:                 .AutoSize  = .T.
1393:                 .FontBold  = .T.
1394:                 .FontName  = "Tahoma"
1395:                 .FontSize  = 10
1396:                 .BackStyle = 0
1397:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1398:                 .Height    = 18
1399:                 .Left      = 229
1400:                 .Top       = 8
1401:                 .Width     = 249
1402:                 .ForeColor = RGB(90,90,90)
1403:             ENDWITH
1404: 
1405:             .AddObject("cmd_4c_SairReq", "CommandButton")
1406:             WITH .cmd_4c_SairReq
1407:                 .Top             = 3
1408:                 .Left            = 620
1409:                 .Height          = 75
1410:                 .Width           = 75
1411:                 .FontBold        = .T.
1412:                 .FontItalic      = .T.
1413:                 .FontName        = "Tahoma"
1414:                 .FontSize        = 8
1415:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"

*-- Linhas 1527 a 1726:
1527:     *==========================================================================
1528:     * ConfigurarTotais - 3 textboxes de totais (Tot_Qtd, Tot_Est, Tot_Prz)
1529:     *==========================================================================
1530:     PROTECTED PROCEDURE ConfigurarTotais()
1531:         THIS.AddObject("txt_4c_TotQtd", "TextBox")
1532:         WITH THIS.txt_4c_TotQtd
1533:             .Height        = 23
1534:             .InputMask     = "999,999.99"
1535:             .Left          = 417
1536:             .SpecialEffect = 1
1537:             .Top           = 349
1538:             .Width         = 80
1539:             .ReadOnly      = .T.
1540:             .Value         = 0
1541:         ENDWITH
1542: 
1543:         THIS.AddObject("txt_4c_TotEst", "TextBox")
1544:         WITH THIS.txt_4c_TotEst
1545:             .Height        = 23
1546:             .InputMask     = "999,999.99"
1547:             .Left          = 498
1548:             .SpecialEffect = 1
1549:             .Top           = 349
1550:             .Width         = 81
1551:             .ReadOnly      = .T.
1552:             .Value         = 0
1553:         ENDWITH
1554: 
1555:         THIS.AddObject("txt_4c_TotPrz", "TextBox")
1556:         WITH THIS.txt_4c_TotPrz
1557:             .Height        = 23
1558:             .InputMask     = "999,999.99"
1559:             .Left          = 580
1560:             .SpecialEffect = 1
1561:             .Top           = 349
1562:             .Width         = 82
1563:             .ReadOnly      = .T.
1564:             .Value         = 0
1565:         ENDWITH
1566:     ENDPROC
1567: 
1568:     *==========================================================================
1569:     * ConfigurarObsItens - imagem do produto + area de observacoes
1570:     *==========================================================================
1571:     PROTECTED PROCEDURE ConfigurarObsItens()
1572:         THIS.AddObject("img_4c_Figura", "Image")
1573:         WITH THIS.img_4c_Figura
1574:             .Stretch = 1
1575:             .Height  = 204
1576:             .Left    = 726
1577:             .Top     = 125
1578:             .Visible = .F.
1579:             .Width   = 266
1580:         ENDWITH
1581: 
1582:         THIS.AddObject("lbl_4c_ObsItens", "Label")
1583:         WITH THIS.lbl_4c_ObsItens
1584:             .AutoSize  = .T.
1585:             .FontBold  = .T.
1586:             .FontName  = "Verdana"
1587:             .FontSize  = 8
1588:             .BackStyle = 0
1589:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
1590:             .Height    = 15
1591:             .Left      = 726
1592:             .Top       = 369
1593:             .Width     = 134
1594:             .ForeColor = RGB(255,255,255)
1595:         ENDWITH
1596: 
1597:         THIS.AddObject("edt_4c_Obs", "EditBox")
1598:         WITH THIS.edt_4c_Obs
1599:             .Height = 205
1600:             .Left   = 732
1601:             .Top    = 361
1602:             .Width  = 266
1603:         ENDWITH
1604:     ENDPROC
1605: 
1606:     *==========================================================================
1607:     * ConfigurarPaginaDados - Fase 5/8: elementos decorativos complementares
1608:     *
1609:     * Para form OPERACIONAL flat (sem PageFrame/Page2 de CRUD), este metodo
1610:     * adiciona elementos visuais secundarios sobrepostos ao layout principal.
1611:     * Fase 5 (primeira metade): Shape2 - decoracao superior esquerda do header.
1612:     *   Corresponde ao Shape2 do legado: top=9, left=9, 279x51
1613:     *   Posicionado sobre o cnt_4c_Cabecalho para criar destaque visual na
1614:     *   area de titulo/empresa, conforme o original SIGPRGLP.SCX.
1615:     *==========================================================================
1616:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1617:         LOCAL loc_oErro
1618:         TRY
1619:             THIS.AddObject("shp_4c_Shape2", "Shape")
1620:             WITH THIS.shp_4c_Shape2
1621:                 .Top           = 9
1622:                 .Left          = 9
1623:                 .Height        = 51
1624:                 .Width         = 279
1625:                 .SpecialEffect = 0
1626:                 .BorderStyle   = 1
1627:                 .BorderWidth   = 1
1628:                 .BorderColor   = RGB(160,160,160)
1629:                 .FillStyle     = 0
1630:                 .FillColor     = RGB(80,80,80)
1631:                 .BackStyle     = 0
1632:                 .Curvature     = 5
1633:             ENDWITH
1634: 
1635:             THIS.AddObject("shp_4c_Shape3", "Shape")
1636:             WITH THIS.shp_4c_Shape3
1637:                 .Top           = 10
1638:                 .Left          = 820
1639:                 .Height        = 38
1640:                 .Width         = 116
1641:                 .SpecialEffect = 0
1642:                 .BorderStyle   = 1
1643:                 .BorderWidth   = 1
1644:                 .BorderColor   = RGB(160,160,160)
1645:                 .FillStyle     = 0
1646:                 .FillColor     = RGB(80,80,80)
1647:                 .BackStyle     = 0
1648:                 .Curvature     = 3
1649:             ENDWITH
1650:         CATCH TO loc_oErro
1651:             MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message + ;
1652:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1653:         ENDTRY
1654:     ENDPROC
1655: 
1656:     *==========================================================================
1657:     * TornarControlesVisiveis - containers ocultos mantem filhos visiveis
1658:     *==========================================================================
1659:     PROTECTED PROCEDURE TornarControlesVisiveis()
1660:         LOCAL loc_i, loc_oCtrl, loc_cNome
1661:         FOR loc_i = 1 TO THIS.ControlCount
1662:             loc_oCtrl = THIS.Controls(loc_i)
1663:             loc_cNome = UPPER(loc_oCtrl.Name)
1664:             IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_DISPONIVEL", "CNT_4C_ESTOQUES", "CNT_4C_LINHAS", "CNT_4C_REQUISICOES")
1665:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1666:                 LOOP
1667:             ENDIF
1668:             loc_oCtrl.Visible = .T.
1669:         NEXT
1670:     ENDPROC
1671: 
1672:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1673:         LOCAL loc_i, loc_oCtrl
1674:         FOR loc_i = 1 TO par_oContainer.ControlCount
1675:             loc_oCtrl = par_oContainer.Controls(loc_i)
1676:             loc_oCtrl.Visible = .T.
1677:             IF loc_oCtrl.BaseClass = "Container"
1678:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1679:             ENDIF
1680:         NEXT
1681:     ENDPROC
1682: 
1683:     *==========================================================================
1684:     * InicializarDados - ControlSources, queries iniciais, totais
1685:     *==========================================================================
1686:     PROTECTED PROCEDURE InicializarDados()
1687:         LOCAL loc_lSucesso, loc_oErro, loc_nSal, loc_nEst, loc_nPrz, loc_lcQuery
1688:         loc_lSucesso = .F.
1689:         TRY
1690:             *-- ControlSources GradeItens (mapeamento exato do legado)
1691:             THIS.grd_4c_Itens.RecordSource = "TmpFinal"
1692:             WITH THIS.grd_4c_Itens
1693:                 .Column1.ControlSource   = "TmpFinal.Cpros"
1694:                 .Column2.ControlSource   = "TmpFinal.CodCors"
1695:                 .Column3.ControlSource   = "TmpFinal.Dopes"
1696:                 .Column4.ControlSource   = "TmpFinal.Numes"
1697:                 .Column5.ControlSource   = "TmpFinal.Saldo"
1698:                 .Column6.ControlSource   = "TmpFinal.Produzir"
1699:                 .Column7.ControlSource   = "TmpFinal.Estoque"
1700:                 .Column8.ControlSource   = "IIF(EMPTY(TmpFinal.Obsps),' ','*')"
1701:                 .Column9.ControlSource   = "TmpFinal.CodTams"
1702:             ENDWITH
1703: 
1704:             *-- Se TransfRes vazio, grid somente leitura
1705:             IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1706:                 IF EMPTY(ALLTRIM(crSigCdPam.TransfRes))
1707:                     THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
1708:                 ENDIF
1709:             ENDIF
1710: 
1711:             *-- TmpSaldG para Container3
1712:             IF USED("TmpSaldG")
1713:                 SELECT TmpSaldG
1714:                 SET ORDER TO Cpros
1715:                 IF USED("TmpFinal") .AND. NOT EOF("TmpFinal")
1716:                     SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1717:                 ENDIF
1718:                 GO TOP
1719:             ENDIF
1720: 
1721:             THIS.cnt_4c_Info.grd_4c_DispInfo.RecordSource = "TmpSaldG"
1722:             WITH THIS.cnt_4c_Info.grd_4c_DispInfo
1723:                 .Column1.ControlSource   = "TmpSaldG.Grupos"
1724:                 .Column2.ControlSource   = "TmpSaldG.Estos"
1725:                 .Column3.ControlSource   = "TmpSaldG.Saldo"
1726:                 .Column4.ControlSource   = "TmpSaldG.Saldo - TmpSaldG.Disps"

*-- Linhas 1786 a 1888:
1786:     *==========================================================================
1787:     * AjustarBotaoPedras - habilitar apenas se parametros completos
1788:     *==========================================================================
1789:     PROTECTED PROCEDURE AjustarBotaoPedras()
1790:         THIS.cmd_4c_Requisicoes.Enabled = .F.
1791:         IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1792:             IF NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) .AND. ;
1793:                NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) .AND. ;
1794:                NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) .AND. ;
1795:                NOT EMPTY(ALLTRIM(crSigCdPam.DopComps)) .AND. ;
1796:                NOT THIS.this_lReserva
1797:                 THIS.cmd_4c_Requisicoes.Enabled = .T.
1798:             ENDIF
1799:         ENDIF
1800:     ENDPROC
1801: 
1802:     *==========================================================================
1803:     * ConfigurarEventos - BINDEVENT para todos os eventos
1804:     *==========================================================================
1805:     PROTECTED PROCEDURE ConfigurarEventos()
1806:         BINDEVENT(THIS.grd_4c_Itens,                                     "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1807:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "When",              THIS, "GradeItensColumn6When")
1808:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "Valid",             THIS, "GradeItensColumn6Valid")
1809:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "KeyPress",         THIS, "GradeItensColumn6LostFocus")
1810:         BINDEVENT(THIS.grd_4c_Itens.Column1.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1811:         BINDEVENT(THIS.grd_4c_Itens.Column2.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1812:         BINDEVENT(THIS.grd_4c_Itens.Column3.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1813:         BINDEVENT(THIS.grd_4c_Itens.Column4.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1814:         BINDEVENT(THIS.grd_4c_Itens.Column5.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1815:         BINDEVENT(THIS.grd_4c_Itens.Column7.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1816:         BINDEVENT(THIS.grd_4c_Itens.Column8.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1817:         BINDEVENT(THIS.grd_4c_Itens.Column9.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1818:         BINDEVENT(THIS.cnt_4c_Info.grd_4c_DispInfo,                      "AfterRowColChange", THIS, "GradeDispInfoAfterRowColChange")
1819:         BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq,                  "AfterRowColChange", THIS, "GradeDispEstqAfterRowColChange")
1820:         BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1,    "Valid",             THIS, "GradeDispEstqColumn5Valid")
1821:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1,  "Valid",             THIS, "GradeDispProdColumn5Valid")
1822:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column1.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1823:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column2.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1824:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column3.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1825:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column4.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1826:         BINDEVENT(THIS.cmd_4c_Disponiveis,                                "Click",             THIS, "CmdDisponiveisClick")
1827:         BINDEVENT(THIS.cmd_4c_LinhasTot,                                  "Click",             THIS, "CmdLinhasTotClick")
1828:         BINDEVENT(THIS.cmd_4c_Requisicoes,                                "Click",             THIS, "CmdRequisoesClick")
1829:         BINDEVENT(THIS.cmd_4c_Estoques,                                   "Click",             THIS, "CmdEstoquesClick")
1830:         BINDEVENT(THIS.cmd_4c_Relatorio,                                  "Click",             THIS, "CmdRelatorioClick")
1831:         BINDEVENT(THIS.cmd_4c_Processar,                                  "Click",             THIS, "CmdProcessarClick")
1832:         BINDEVENT(THIS.cmd_4c_Cancelar,                                   "Click",             THIS, "CmdCancelarClick")
1833:         BINDEVENT(THIS.cnt_4c_Estoques.cmd_4c_OkEstq,                    "Click",             THIS, "CancelarC5Click")
1834:         BINDEVENT(THIS.cnt_4c_Disponivel.cmd_4c_SairDisp,                "Click",             THIS, "CancelarC2Click")
1835:         BINDEVENT(THIS.cnt_4c_Requisicoes.cmd_4c_SairReq,                "Click",             THIS, "CancelarC4Click")
1836:         BINDEVENT(THIS.cnt_4c_Linhas.cmd_4c_OkLinhas,                    "Click",             THIS, "CancelarC1Click")
1837:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1, "Valid",             THIS, "GradePedra1Valid")
1838:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "When",              THIS, "GradePedra5When")
1839:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "Valid",             THIS, "GradePedra5Valid")
1840:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "KeyPress",         THIS, "GradePedra5LostFocus")
1841:         BINDEVENT(THIS.img_4c_Figura,                                     "DblClick",          THIS, "ImgFiguraDblClick")
1842:     ENDPROC
1843: 
1844:     *==========================================================================
1845:     * HANDLERS DE EVENTOS
1846:     *==========================================================================
1847: 
1848:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1849:         LOCAL loc_lcArquivo, loc_lcFoto, loc_oErro
1850:         TRY
1851:             THIS.edt_4c_Obs.Refresh
1852:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
1853: 
1854:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1855: 
1856:             IF USED("TmpSaldG")
1857:                 SELECT TmpSaldG
1858:                 SET ORDER TO Cpros
1859:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1860:                 GO TOP
1861:             ENDIF
1862: 
1863:             WITH THIS.cnt_4c_Info
1864:                 .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
1865:                 .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
1866:                 .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
1867:                 .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
1868:                     IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
1869:                     IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
1870: 
1871:                 IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
1872:                     .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
1873:                     .txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
1874:                 ENDIF
1875:                 .grd_4c_DispInfo.Refresh
1876:                 .Visible     = .T.
1877:             ENDWITH
1878: 
1879:             *-- Imagem do produto
1880:             loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
1881:             CLEAR RESOURCES
1882:             THIS.img_4c_Figura.Picture = ""
1883:             THIS.img_4c_Figura.Visible = .F.
1884:             IF SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigProFig") > 0
1885:                 IF NOT EOF("crSigProFig")
1886:                     IF NOT EMPTY(crSigProFig.FigJpgs) .AND. NOT ISNULL(crSigProFig.FigJpgs)
1887:                         loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigProFig.FigJpgs, ;
1888:                             "data:image/png;base64,", ""), ;

*-- Linhas 1903 a 2631:
1903:         ENDTRY
1904:     ENDPROC
1905: 
1906:     PROCEDURE GradeItensRedirFoco()
1907:         THIS.grd_4c_Itens.Column6.Text1.SetFocus
1908:     ENDPROC
1909: 
1910:     PROCEDURE GradeDispProdRedirFoco()
1911:         THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.SetFocus
1912:     ENDPROC
1913: 
1914:     PROCEDURE GradeItensColumn6When()
1915:         LOCAL loc_oErro
1916:         THIS.this_oBusinessObject.this_nOldValue = THIS.grd_4c_Itens.Column6.Text1.Value
1917:         IF THIS.this_lReserva .AND. (TmpFinal.Estoque = 0)
1918:             TRY
1919:                 IF SQLEXEC(gnConnHandle, "SELECT CGrus FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crTmpPro") > 0
1920:                     IF NOT EOF("crTmpPro")
1921:                         IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
1922:                             IF NOT EOF("crTmpGru")
1923:                                 IF INLIST(crTmpGru.TipoEstos, 3, 4)
1924:                                     THIS.cmd_4c_Disponiveis.Enabled = .T.
1925:                                 ENDIF
1926:                             ENDIF
1927:                             USE IN crTmpGru
1928:                         ENDIF
1929:                     ENDIF
1930:                     USE IN crTmpPro
1931:                 ENDIF
1932:             CATCH TO loc_oErro
1933:                 MsgErro(loc_oErro.Message, "Erro")
1934:             ENDTRY
1935:         ENDIF
1936:         RETURN .T.
1937:     ENDPROC
1938: 
1939:     PROCEDURE GradeItensColumn6Valid()
1940:         LOCAL loc_lResultado, loc_nNovoValor, loc_xBaixa, loc_oErro
1941:         loc_lResultado = .T.
1942:         loc_nNovoValor = THIS.grd_4c_Itens.Column6.Text1.Value
1943:         TRY
1944:             IF NOT SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1945:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1946:             ENDIF
1947:             IF loc_nNovoValor <> THIS.this_oBusinessObject.this_nOldValue .AND. TmpSaldU.KeySelm
1948:                 IF NOT MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + CHR(13) + ;
1949:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?")
1950:                     THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1951:                     loc_lResultado = .F.
1952:                 ENDIF
1953:             ENDIF
1954:             IF loc_lResultado
1955:                 DO CASE
1956:                     CASE loc_nNovoValor = THIS.this_oBusinessObject.this_nOldValue
1957:                         *-- nenhuma mudanca
1958:                     CASE loc_nNovoValor < 0
1959:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1960:                         THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1961:                         loc_lResultado = .F.
1962:                     CASE loc_nNovoValor > TmpFinal.Saldo
1963:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
1964:                         THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
1965:                         loc_lResultado = .F.
1966:                     CASE NOT SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") .AND. ;
1967:                          (TmpFinal.Produzir <> TmpFinal.Saldo)
1968:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
1969:                         THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo
1970:                         loc_lResultado = .F.
1971:                     OTHERWISE
1972:                         IF (TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNovoValor)
1973:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
1974:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNovoValor IN TmpFinal
1975:                             REPLACE KeySelm WITH .F. IN TmpSaldU
1976:                             SELECT TmpSaldo
1977:                             loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
1978:                             SELECT TmpSaldG
1979:                             SET ORDER TO Cpros
1980:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1981:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros .AND. ;
1982:                                 CodCors = TmpSaldo.CodCors .AND. CodTams = TmpSaldo.CodTams
1983:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1984:                             SCAN WHILE Cpros = TmpSaldo.Cpros .AND. CodCors = TmpSaldo.CodCors .AND. ;
1985:                                 CodTams = TmpSaldo.CodTams .AND. loc_xBaixa > 0
1986:                                 IF TmpSaldG.Disps >= loc_xBaixa
1987:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
1988:                                     loc_xBaixa = 0
1989:                                 ELSE
1990:                                     loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
1991:                                     REPLACE TmpSaldG.Disps WITH 0
1992:                                 ENDIF
1993:                             ENDSCAN
1994:                         ELSE
1995:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
1996:                             THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1997:                             loc_lResultado = .F.
1998:                         ENDIF
1999:                 ENDCASE
2000:             ENDIF
2001:         CATCH TO loc_oErro
2002:             MsgErro(loc_oErro.Message, "Erro")
2003:             loc_lResultado = .F.
2004:         ENDTRY
2005:         RETURN loc_lResultado
2006:     ENDPROC
2007: 
2008:     PROCEDURE GradeItensColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2009:         IF NOT INLIST(par_nKeyCode, 13, 9)
2010:             RETURN
2011:         ENDIF
2012:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2013:         TRY
2014:             SELECT TmpFinal
2015:             loc_nRecno = RECNO()
2016:             SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2017:             GO loc_nRecno
2018:             THIS.txt_4c_TotQtd.Value = loc_nSal
2019:             THIS.txt_4c_TotEst.Value = loc_nEst
2020:             THIS.txt_4c_TotPrz.Value = loc_nPrz
2021:             THIS.txt_4c_TotQtd.Refresh
2022:             THIS.txt_4c_TotEst.Refresh
2023:             THIS.txt_4c_TotPrz.Refresh
2024:             THIS.Refresh
2025:         CATCH TO loc_oErro
2026:             MsgErro(loc_oErro.Message, "Erro")
2027:         ENDTRY
2028:     ENDPROC
2029: 
2030:     PROCEDURE GradeDispInfoAfterRowColChange(par_nColIndex)
2031:         LOCAL loc_oErro
2032:         TRY
2033:             IF THIS.this_oBusinessObject.AtualizarInfoContainer3(par_nColIndex)
2034:                 THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
2035:                 THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
2036:             ENDIF
2037:         CATCH TO loc_oErro
2038:             MsgErro(loc_oErro.Message, "Erro")
2039:         ENDTRY
2040:     ENDPROC
2041: 
2042:     PROCEDURE GradeDispEstqAfterRowColChange(par_nColIndex)
2043:         LOCAL loc_oErro
2044:         TRY
2045:             IF THIS.this_oBusinessObject.AtualizarInfoDisponivelConta(par_nColIndex)
2046:                 THIS.cnt_4c_Estoques.txt_4c_DGrupoEstq.Value = THIS.this_oBusinessObject.this_cDscGrupo
2047:                 THIS.cnt_4c_Estoques.txt_4c_DContaEstq.Value = THIS.this_oBusinessObject.this_cDscConta
2048:             ENDIF
2049:         CATCH TO loc_oErro
2050:             MsgErro(loc_oErro.Message, "Erro")
2051:         ENDTRY
2052:     ENDPROC
2053: 
2054:     PROCEDURE GradeDispEstqColumn5Valid()
2055:         LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
2056:         loc_lResultado = .T.
2057:         loc_nNovoValor = THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value
2058:         TRY
2059:             IF loc_nNovoValor > TmpDisp.Disps
2060:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "")
2061:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2062:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2063:                 loc_lResultado = .F.
2064:             ELSE
2065:                 IF loc_nNovoValor < 0
2066:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
2067:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2068:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2069:                 loc_lResultado = .F.
2070:             ELSE
2071:                 loc_nRegDisp = RECNO("TmpDisp")
2072:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2073:                 GO loc_nRegDisp IN TmpDisp
2074:                 IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
2075:                     MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
2076:                     THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2077:                     THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2078:                     loc_lResultado = .F.
2079:                 ELSE
2080:                     THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value = loc_nQtdUti
2081:                     THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Refresh
2082:                 ENDIF
2083:                 ENDIF
2084:             ENDIF
2085:         CATCH TO loc_oErro
2086:             MsgErro(loc_oErro.Message, "Erro")
2087:             loc_lResultado = .F.
2088:         ENDTRY
2089:         RETURN loc_lResultado
2090:     ENDPROC
2091: 
2092:     PROCEDURE GradeDispProdColumn5Valid()
2093:         LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
2094:         loc_lResultado = .T.
2095:         loc_nNovoValor = THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value
2096:         TRY
2097:             IF loc_nNovoValor > TmpDisp.Disps
2098:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
2099:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
2100:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
2101:                 loc_lResultado = .F.
2102:             ELSE
2103:                 loc_nRegDisp = RECNO("TmpDisp")
2104:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2105:                 GO loc_nRegDisp IN TmpDisp
2106:                 IF loc_nQtdUti > TmpFinal.Saldo
2107:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
2108:                     THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
2109:                     THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
2110:                     loc_lResultado = .F.
2111:                 ELSE
2112:                     THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Value = loc_nQtdUti
2113:                     THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Refresh
2114:                 ENDIF
2115:             ENDIF
2116:         CATCH TO loc_oErro
2117:             MsgErro(loc_oErro.Message, "Erro")
2118:             loc_lResultado = .F.
2119:         ENDTRY
2120:         RETURN loc_lResultado
2121:     ENDPROC
2122: 
2123:     *-- Disponivel.Click: abre Container2 com estoque por produto/cor/tam
2124:     PROCEDURE CmdDisponiveisClick()
2125:         LOCAL loc_oErro
2126:         TRY
2127:             THIS.this_oBusinessObject.BuscarDisponivel(TmpFinal.Cpros, TmpFinal.CodCors)
2128:             IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
2129:                 MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
2130:                 THIS.CancelarC2Click()
2131:             ELSE
2132:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.ColumnCount = 5
2133:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.RecordSource = "TmpDisp"
2134:                 WITH THIS.cnt_4c_Disponivel.grd_4c_DispProd
2135:                     .Column1.Width           = 80
2136:                     .Column2.Width           = 38
2137:                     .Column3.Width           = 24
2138:                     .Column4.Width           = 75
2139:                     .Column5.Width           = 75
2140:                     .Column1.Header1.Caption = "Produto"
2141:                     .Column2.Header1.Caption = "Cor"
2142:                     .Column3.Header1.Caption = "Tam"
2143:                     .Column4.Header1.Caption = "Disponivel"
2144:                     .Column5.Header1.Caption = "Utilizar"
2145:                     .Column1.ControlSource   = "TmpDisp.Cpros"
2146:                     .Column2.ControlSource   = "TmpDisp.CodCors"
2147:                     .Column3.ControlSource   = "TmpDisp.CodTams"
2148:                     .Column4.ControlSource   = "TmpDisp.Disps"
2149:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2150:                 ENDWITH
2151:                 THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
2152:                 THIS.grd_4c_Itens.Enabled        = .F.
2153:                 THIS.cmd_4c_Processar.Enabled    = .F.
2154:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2155:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2156:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2157:                 THIS.cnt_4c_Info.Enabled         = .F.
2158:                 THIS.cnt_4c_Disponivel.Visible   = .T.
2159:                 THIS.cnt_4c_Disponivel.ZOrder(0)
2160:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2161:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus
2162:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2163:             ENDIF
2164:         CATCH TO loc_oErro
2165:             MsgErro(loc_oErro.Message, "Erro")
2166:         ENDTRY
2167:     ENDPROC
2168: 
2169:     *-- TotLinha.Click: abre Container1 com total por linha de producao
2170:     PROCEDURE CmdLinhasTotClick()
2171:         LOCAL loc_oErro
2172:         TRY
2173:             THIS.this_oBusinessObject.BuscarPorLinhas()
2174:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.ColumnCount = 4
2175:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.RecordSource = "TmpLinha"
2176:             WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg
2177:                 .Column1.ControlSource = "TmpLinha.Linhas"
2178:                 .Column2.ControlSource = "TmpLinha.Saldo"
2179:                 .Column3.ControlSource = "TmpLinha.Estoque"
2180:                 .Column4.ControlSource = "TmpLinha.Produzir"
2181:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
2182:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
2183:             ENDWITH
2184:             THIS.cmd_4c_Processar.Enabled   = .F.
2185:             THIS.cmd_4c_Cancelar.Enabled    = .F.
2186:             THIS.cmd_4c_LinhasTot.Enabled   = .F.
2187:             THIS.cmd_4c_Requisicoes.Enabled = .F.
2188:             THIS.cmd_4c_Disponiveis.Enabled = .F.
2189:             THIS.grd_4c_Itens.Enabled       = .F.
2190:             THIS.cnt_4c_Info.Enabled        = .F.
2191:             THIS.cnt_4c_Linhas.Visible      = .T.
2192:             THIS.cnt_4c_Linhas.ZOrder(0)
2193:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh
2194:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Column1.SetFocus
2195:         CATCH TO loc_oErro
2196:             MsgErro(loc_oErro.Message, "Erro")
2197:         ENDTRY
2198:     ENDPROC
2199: 
2200:     *-- Pedras.Click: abre Container4 com requisicoes de componentes
2201:     PROCEDURE CmdRequisoesClick()
2202:         LOCAL loc_oErro
2203:         TRY
2204:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.ColumnCount = 5
2205:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.RecordSource = "SelPedra"
2206:             WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq
2207:                 .Column1.ControlSource = "SelPedra.Cpros"
2208:                 .Column2.ControlSource = "SelPedra.Dpros"
2209:                 .Column3.ControlSource = "SelPedra.Cunis"
2210:                 .Column4.ControlSource = "SelPedra.Qtds"
2211:                 .Column5.ControlSource = "SelPedra.Cpro2s"
2212:             ENDWITH
2213:             THIS.cmd_4c_Processar.Enabled    = .F.
2214:             THIS.cmd_4c_Cancelar.Enabled     = .F.
2215:             THIS.cmd_4c_LinhasTot.Enabled    = .F.
2216:             THIS.cmd_4c_Requisicoes.Enabled  = .F.
2217:             THIS.cmd_4c_Disponiveis.Enabled  = .F.
2218:             THIS.grd_4c_Itens.Enabled        = .F.
2219:             THIS.cnt_4c_Info.Enabled         = .F.
2220:             THIS.cnt_4c_Requisicoes.Visible  = .T.
2221:             THIS.cnt_4c_Requisicoes.ZOrder(0)
2222:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2223:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.SetFocus
2224:         CATCH TO loc_oErro
2225:             MsgErro(loc_oErro.Message, "Erro")
2226:         ENDTRY
2227:     ENDPROC
2228: 
2229:     *-- SelEstoque.Click: abre Container5 com disponivel por conta/grupo
2230:     PROCEDURE CmdEstoquesClick()
2231:         LOCAL loc_oErro
2232:         TRY
2233:             THIS.this_oBusinessObject.BuscarEstoqueDetalhado(TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams)
2234:             IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
2235:                 MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
2236:                 THIS.CancelarC5Click()
2237:             ELSE
2238:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.ColumnCount = 5
2239:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.RecordSource = "TmpDisp"
2240:                 WITH THIS.cnt_4c_Estoques.grd_4c_DispEstq
2241:                     .Column1.Width           = 80
2242:                     .Column2.Width           = 80
2243:                     .Column3.Width           = 24
2244:                     .Column4.Width           = 75
2245:                     .Column5.Width           = 75
2246:                     .Column1.Header1.Caption = "Grupo"
2247:                     .Column2.Header1.Caption = "Conta"
2248:                     .Column3.Header1.Caption = "Prioridade"
2249:                     .Column4.Header1.Caption = "Disponivel"
2250:                     .Column5.Header1.Caption = "Utilizar"
2251:                     .Column1.ControlSource   = "TmpDisp.Grupos"
2252:                     .Column2.ControlSource   = "TmpDisp.Estos"
2253:                     .Column3.ControlSource   = "TmpDisp.Priors"
2254:                     .Column4.ControlSource   = "TmpDisp.Disps"
2255:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2256:                 ENDWITH
2257:                 THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
2258:                     "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
2259:                 THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
2260:                 THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
2261:                 THIS.cmd_4c_Processar.Enabled    = .F.
2262:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2263:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2264:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2265:                 THIS.cmd_4c_Estoques.Enabled     = .F.
2266:                 THIS.cmd_4c_Requisicoes.Enabled  = .F.
2267:                 THIS.cnt_4c_Info.Enabled         = .F.
2268:                 THIS.cnt_4c_Estoques.Visible     = .T.
2269:                 THIS.cnt_4c_Estoques.ZOrder(0)
2270:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
2271:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.SetFocus
2272:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
2273:             ENDIF
2274:         CATCH TO loc_oErro
2275:             MsgErro(loc_oErro.Message, "Erro")
2276:         ENDTRY
2277:     ENDPROC
2278: 
2279:     *-- btnRelatorio.Click: gerar relatorio SigReGlp
2280:     PROCEDURE CmdRelatorioClick()
2281:         LOCAL loc_oErro
2282:         TRY
2283:             THIS.this_oBusinessObject.GerarRelatorio()
2284:         CATCH TO loc_oErro
2285:             MsgErro(loc_oErro.Message, "Erro")
2286:         ENDTRY
2287:     ENDPROC
2288: 
2289:     *-- Processar.Click: executa globalizacao/reserva
2290:     PROCEDURE CmdProcessarClick()
2291:         LOCAL loc_dPrev, loc_dGera, loc_oPP, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2292:         loc_dPrev = {}
2293:         loc_dGera = {}
2294:         *-- Extrair datas do avo via PEMSTATUS para evitar CATCH silencioso
2295:         IF VARTYPE(THIS.this_oParentForm) = "O"
2296:             IF PEMSTATUS(THIS.this_oParentForm, "ParentForm", 5)
2297:                 loc_oPP = THIS.this_oParentForm.ParentForm
2298:                 IF VARTYPE(loc_oPP) = "O"
2299:                     IF PEMSTATUS(loc_oPP, "Cnt_Previsao", 5)
2300:                         IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetPrevisao", 5)
2301:                             loc_dPrev = loc_oPP.Cnt_Previsao.GetPrevisao.Value
2302:                         ENDIF
2303:                         IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetGeracao", 5)
2304:                             loc_dGera = loc_oPP.Cnt_Previsao.GetGeracao.Value
2305:                         ENDIF
2306:                     ENDIF
2307:                 ENDIF
2308:             ENDIF
2309:         ENDIF
2310:         TRY
2311:             IF THIS.this_oBusinessObject.Processar(loc_dPrev, loc_dGera)
2312:                 THIS.grd_4c_Itens.Refresh
2313:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2314:                 IF USED("TmpFinal")
2315:                     SELECT TmpFinal
2316:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2317:                     THIS.txt_4c_TotQtd.Value = loc_nSal
2318:                     THIS.txt_4c_TotEst.Value = loc_nEst
2319:                     THIS.txt_4c_TotPrz.Value = loc_nPrz
2320:                 ENDIF
2321:             ENDIF
2322:         CATCH TO loc_oErro
2323:             MsgErro(loc_oErro.Message, "Erro")
2324:         ENDTRY
2325:     ENDPROC
2326: 
2327:     *-- Cancelar.Click: fechar form sem processar
2328:     PROCEDURE CmdCancelarClick()
2329:         LOCAL loc_oErro
2330:         TRY
2331:             IF VARTYPE(THIS.this_oParentForm) = "O"
2332:                 THIS.this_oParentForm.Enabled = .T.
2333:             ENDIF
2334:         CATCH TO loc_oErro
2335:             MsgErro(loc_oErro.Message, "Erro")
2336:         ENDTRY
2337:         THIS.Release
2338:     ENDPROC
2339: 
2340:     *-- Container5 OK: confirmar selecao de estoque por conta/grupo
2341:     PROCEDURE CancelarC5Click()
2342:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2343:         TRY
2344:             THIS.this_oBusinessObject.ConfirmarDisponivelSimples()
2345:             IF USED("TmpFinal")
2346:                 SELECT TmpFinal
2347:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2348:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2349:                 THIS.txt_4c_TotEst.Value = loc_nEst
2350:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2351:             ENDIF
2352:         CATCH TO loc_oErro
2353:             MsgErro(loc_oErro.Message, "Erro")
2354:         ENDTRY
2355:         THIS.cmd_4c_Processar.Enabled    = .T.
2356:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2357:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2358:         THIS.cmd_4c_Estoques.Enabled     = .T.
2359:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2360:         THIS.cnt_4c_Info.Enabled         = .T.
2361:         THIS.cnt_4c_Estoques.Visible     = .F.
2362:         THIS.grd_4c_Itens.Enabled        = .T.
2363:         THIS.grd_4c_Itens.ZOrder(0)
2364:         THIS.grd_4c_Itens.Refresh
2365:         THIS.grd_4c_Itens.Column6.SetFocus
2366:     ENDPROC
2367: 
2368:     *-- Container2 Sair: confirmar selecao de disponivel por produto
2369:     PROCEDURE CancelarC2Click()
2370:         LOCAL loc_oErro
2371:         TRY
2372:             THIS.this_oBusinessObject.ConfirmarDisponivel()
2373:         CATCH TO loc_oErro
2374:             MsgErro(loc_oErro.Message, "Erro")
2375:         ENDTRY
2376:         THIS.cmd_4c_Processar.Enabled    = .T.
2377:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2378:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2379:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2380:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2381:         THIS.cnt_4c_Info.Enabled         = .T.
2382:         THIS.cnt_4c_Disponivel.Visible   = .F.
2383:         THIS.grd_4c_Itens.Enabled        = .T.
2384:         THIS.grd_4c_Itens.ZOrder(0)
2385:         THIS.grd_4c_Itens.Refresh
2386:         THIS.grd_4c_Itens.Column6.SetFocus
2387:     ENDPROC
2388: 
2389:     *-- Container4 Sair: fechar painel de requisicoes
2390:     PROCEDURE CancelarC4Click()
2391:         THIS.cmd_4c_Processar.Enabled    = .T.
2392:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2393:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2394:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2395:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2396:         THIS.cnt_4c_Info.Enabled         = .T.
2397:         THIS.cnt_4c_Requisicoes.Visible  = .F.
2398:         THIS.grd_4c_Itens.Enabled        = .T.
2399:         THIS.grd_4c_Itens.ZOrder(0)
2400:         THIS.grd_4c_Itens.Refresh
2401:         THIS.grd_4c_Itens.Column6.SetFocus
2402:     ENDPROC
2403: 
2404:     *-- Container1 OK: fechar painel de linhas
2405:     PROCEDURE CancelarC1Click()
2406:         THIS.cmd_4c_Processar.Enabled    = .T.
2407:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2408:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2409:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2410:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2411:         THIS.cnt_4c_Linhas.Visible       = .F.
2412:         THIS.cnt_4c_Info.Enabled         = .T.
2413:         THIS.grd_4c_Itens.Enabled        = .T.
2414:         THIS.grd_4c_Itens.ZOrder(0)
2415:         THIS.grd_4c_Itens.Refresh
2416:         THIS.grd_4c_Itens.Column6.SetFocus
2417:     ENDPROC
2418: 
2419:     *-- GradePedra Column1.Text1 Valid: lookup produto
2420:     PROCEDURE GradePedra1Valid()
2421:         LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
2422:         loc_lResultado = .T.
2423:         TRY
2424:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value))
2425:             IF NOT EMPTY(loc_lcValor)
2426:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup") > 0
2427:                     IF NOT EOF("crProLookup")
2428:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = crProLookup.Cpros
2429:                         REPLACE SelPedra.Dpros WITH crProLookup.DPros, ;
2430:                                 SelPedra.Cunis WITH crProLookup.Cunis IN SelPedra
2431:                         USE IN crProLookup
2432:                     ELSE
2433:                         USE IN crProLookup
2434:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro") > 0
2435:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2436:                             IF VARTYPE(loc_oForm) = "O"
2437:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro"
2438:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2439:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2440:                                 loc_oForm.Show()
2441:                                 IF loc_oForm.this_lSelecionou
2442:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = cursor_4c_BuscaPro.Cpros
2443:                                     REPLACE SelPedra.Dpros WITH cursor_4c_BuscaPro.DPros, ;
2444:                                             SelPedra.Cunis WITH cursor_4c_BuscaPro.Cunis IN SelPedra
2445:                                 ENDIF
2446:                             ENDIF
2447:                         ENDIF
2448:                         IF USED("cursor_4c_BuscaPro")
2449:                             USE IN cursor_4c_BuscaPro
2450:                         ENDIF
2451:                     ENDIF
2452:                 ENDIF
2453:                 THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2454:             ENDIF
2455:         CATCH TO loc_oErro
2456:             MsgErro(loc_oErro.Message, "Erro")
2457:             loc_lResultado = .F.
2458:         ENDTRY
2459:         RETURN loc_lResultado
2460:     ENDPROC
2461: 
2462:     *-- GradePedra Column5.Text1 When: salva valor anterior
2463:     PROCEDURE GradePedra5When()
2464:         THIS.this_oBusinessObject.this_nAntValue = THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value
2465:         RETURN NOT EMPTY(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value)
2466:     ENDPROC
2467: 
2468:     *-- GradePedra Column5.Text1 Valid: lookup produto substituto
2469:     PROCEDURE GradePedra5Valid()
2470:         LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
2471:         loc_lResultado = .T.
2472:         TRY
2473:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value))
2474:             IF NOT EMPTY(loc_lcValor)
2475:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup2") > 0
2476:                     IF NOT EOF("crProLookup2")
2477:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = crProLookup2.Cpros
2478:                         USE IN crProLookup2
2479:                     ELSE
2480:                         USE IN crProLookup2
2481:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro2") > 0
2482:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2483:                             IF VARTYPE(loc_oForm) = "O"
2484:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro2"
2485:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2486:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2487:                                 loc_oForm.Show()
2488:                                 IF loc_oForm.this_lSelecionou
2489:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = cursor_4c_BuscaPro2.Cpros
2490:                                 ENDIF
2491:                             ENDIF
2492:                         ENDIF
2493:                         IF USED("cursor_4c_BuscaPro2")
2494:                             USE IN cursor_4c_BuscaPro2
2495:                         ENDIF
2496:                     ENDIF
2497:                 ENDIF
2498:                 THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2499:             ENDIF
2500:         CATCH TO loc_oErro
2501:             MsgErro(loc_oErro.Message, "Erro")
2502:             loc_lResultado = .F.
2503:         ENDTRY
2504:         RETURN loc_lResultado
2505:     ENDPROC
2506: 
2507:     *-- GradePedra Column5.Text1 KeyPress: avancar para proximo registro ao confirmar
2508:     PROCEDURE GradePedra5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2509:         IF NOT INLIST(par_nKeyCode, 13, 9)
2510:             RETURN
2511:         ENDIF
2512:         LOCAL loc_xPos, loc_oErro
2513:         TRY
2514:             SELECT SelPedra
2515:             loc_xPos = RECNO()
2516:             LOCATE FOR EMPTY(Cpros)
2517:             IF EOF()
2518:                 APPEND BLANK
2519:             ENDIF
2520:             LOCATE FOR RECNO() = loc_xPos
2521:             KEYBOARD "{DNARROW}"
2522:         CATCH TO loc_oErro
2523:             MsgErro(loc_oErro.Message, "Erro")
2524:         ENDTRY
2525:     ENDPROC
2526: 
2527:     *-- img_4c_Figura DblClick: zoom da imagem
2528:     PROCEDURE ImgFiguraDblClick()
2529:         IF NOT EMPTY(THIS.img_4c_Figura.Picture)
2530:             MsgInfo(THIS.img_4c_Figura.Picture, "Zoom")
2531:         ENDIF
2532:     ENDPROC
2533: 
2534:     *==========================================================================
2535:     * ConfigurarPaginaLista - equivalente OPERACIONAL da Page1 Lista dos CRUD
2536:     *
2537:     * Este form eh OPERACIONAL flat (sem PageFrame): a "pagina lista" corresponde
2538:     * a visao principal com barra de botoes superior + grade de itens central.
2539:     * Este metodo compoe as tres pecas equivalentes ao Page1 de um CRUD:
2540:     *   1) Barra de botoes principais (equivalente ao cnt_4c_Botoes CRUD)
2541:     *   2) Grade principal (equivalente ao grd_4c_Lista CRUD)
2542:     *   3) Container de totais + observacoes (rodape informativo)
2543:     * Retorna o container de botoes principais como "ancora" da lista, para que
2544:     * chamadores possam referenciar a barra CRUD-like sem precisar mudar layout.
2545:     *==========================================================================
2546:     PROTECTED PROCEDURE ConfigurarPaginaLista()
2547:         LOCAL loc_lSucesso, loc_oErro
2548:         loc_lSucesso = .F.
2549:         TRY
2550:             *-- Barra de botoes principais (equivalente a cnt_4c_Botoes do CRUD)
2551:             IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2552:                 THIS.ConfigurarBotoesPrincipais()
2553:             ENDIF
2554:             *-- Grade principal (equivalente ao grid da Page1 do CRUD)
2555:             IF NOT PEMSTATUS(THIS, "grd_4c_Itens", 5)
2556:                 THIS.ConfigurarGradeItens()
2557:             ENDIF
2558:             *-- Rodape com totais e observacoes
2559:             IF NOT PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2560:                 THIS.ConfigurarTotais()
2561:             ENDIF
2562:             IF NOT PEMSTATUS(THIS, "edt_4c_Obs", 5)
2563:                 THIS.ConfigurarObsItens()
2564:             ENDIF
2565:             loc_lSucesso = .T.
2566:         CATCH TO loc_oErro
2567:             MsgErro("Erro ao configurar pagina lista: " + loc_oErro.Message + ;
2568:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2569:         ENDTRY
2570:         RETURN loc_lSucesso
2571:     ENDPROC
2572: 
2573:     *==========================================================================
2574:     * AlternarPagina - navegacao entre "paginas" logicas do form OPERACIONAL
2575:     *
2576:     * Este form nao tem PageFrame fisico. As "paginas" sao containers flutuantes
2577:     * (Visible=.F. por default) que sobrepoem a visao principal:
2578:     *   par_nPagina = 1 -> Lista principal (esconde todos os containers)
2579:     *   par_nPagina = 2 -> Container Disponivel (estoque por produto/cor/tam)
2580:     *   par_nPagina = 3 -> Container Estoques (disponivel detalhado por conta)
2581:     *   par_nPagina = 4 -> Container Linhas (total por linha de producao)
2582:     *   par_nPagina = 5 -> Container Requisicoes (componentes adicionais)
2583:     *   par_nPagina = 6 -> Container Info (rodape com totais)
2584:     * Retorna .T. em sucesso, .F. em caso de parametro invalido ou erro.
2585:     *==========================================================================
2586:     PROCEDURE AlternarPagina(par_nPagina)
2587:         LOCAL loc_lResultado, loc_oErro
2588:         loc_lResultado = .F.
2589:         TRY
2590:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 6
2591:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Aviso")
2592:                 loc_lResultado = .F.
2593:             ENDIF
2594:             *-- Sempre esconder todos os containers flutuantes primeiro
2595:             IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
2596:                 THIS.cnt_4c_Disponivel.Visible  = .F.
2597:             ENDIF
2598:             IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
2599:                 THIS.cnt_4c_Estoques.Visible    = .F.
2600:             ENDIF
2601:             IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
2602:                 THIS.cnt_4c_Linhas.Visible      = .F.
2603:             ENDIF
2604:             IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
2605:                 THIS.cnt_4c_Requisicoes.Visible = .F.
2606:             ENDIF
2607:             DO CASE
2608:                 CASE par_nPagina = 1
2609:                     *-- Retorno a visao principal: reabilitar botoes e grade
2610:                     IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2611:                         THIS.cmd_4c_Processar.Enabled   = .T.
2612:                     ENDIF
2613:                     IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2614:                         THIS.cmd_4c_Cancelar.Enabled    = .T.
2615:                     ENDIF
2616:                     IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2617:                         THIS.cmd_4c_LinhasTot.Enabled   = .T.
2618:                     ENDIF
2619:                     IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2620:                         THIS.cmd_4c_Requisicoes.Enabled = .T.
2621:                     ENDIF
2622:                     IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2623:                         THIS.cmd_4c_Disponiveis.Enabled = .T.
2624:                     ENDIF
2625:                     IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2626:                         THIS.cmd_4c_Estoques.Enabled    = .T.
2627:                     ENDIF
2628:                     IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2629:                         THIS.cnt_4c_Info.Enabled        = .T.
2630:                     ENDIF
2631:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)

*-- Linhas 2661 a 2980:
2661:     * Executa o processamento da Previa da Globalizacao, gerando OPs, movimentos
2662:     * de estoque, requisicoes de componentes e historicos derivados da grade.
2663:     *--------------------------------------------------------------------------
2664:     PROCEDURE BtnIncluirClick()
2665:         LOCAL loc_oErro
2666:         TRY
2667:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND !THIS.cmd_4c_Processar.Enabled
2668:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2669:                 loc_lResultado = .F.
2670:             ENDIF
2671:             THIS.CmdProcessarClick()
2672:         CATCH TO loc_oErro
2673:             MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message + ;
2674:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2675:         ENDTRY
2676:     ENDPROC
2677: 
2678:     *--------------------------------------------------------------------------
2679:     * BtnAlterarClick - Retorna a visao principal e devolve o foco a grade de itens
2680:     * Fecha containers flutuantes (Disponivel/Estoques/Linhas/Requisicoes) e
2681:     * reabilita a edicao da coluna Produzir para ajuste manual das quantidades.
2682:     *--------------------------------------------------------------------------
2683:     PROCEDURE BtnAlterarClick()
2684:         LOCAL loc_oErro
2685:         TRY
2686:             THIS.AlternarPagina(1)
2687:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2688:                 SELECT cursor_4c_ItensFinal
2689:                 GO TOP
2690:             ENDIF
2691:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2692:                 THIS.grd_4c_Itens.Refresh
2693:                 IF THIS.grd_4c_Itens.ColumnCount >= 6
2694:                     THIS.grd_4c_Itens.Column6.Text1.SetFocus
2695:                 ENDIF
2696:             ENDIF
2697:         CATCH TO loc_oErro
2698:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
2699:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2700:         ENDTRY
2701:     ENDPROC
2702: 
2703:     *--------------------------------------------------------------------------
2704:     * BtnVisualizarClick - Reexibe o painel de informacoes do item corrente
2705:     * Traz o container cnt_4c_Info para o topo e atualiza os totais / totais por
2706:     * linha da linha atualmente selecionada na grade principal.
2707:     *--------------------------------------------------------------------------
2708:     PROCEDURE BtnVisualizarClick()
2709:         LOCAL loc_oErro
2710:         TRY
2711:             THIS.AlternarPagina(6)
2712:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2713:                 SELECT cursor_4c_ItensFinal
2714:                 THIS.GradeItensAfterRowColChange(1)
2715:             ENDIF
2716:         CATCH TO loc_oErro
2717:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
2718:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2719:         ENDTRY
2720:     ENDPROC
2721: 
2722:     *--------------------------------------------------------------------------
2723:     * BtnExcluirClick - Cancela o processamento e encerra o formulario
2724:     * Faz rollback da transacao aberta pelo Init e libera o form pai.
2725:     * Equivalente a acao do botao Cancelar (Sair) da barra superior.
2726:     *--------------------------------------------------------------------------
2727:     PROCEDURE BtnExcluirClick()
2728:         LOCAL loc_oErro
2729:         TRY
2730:             IF !MsgConfirma("Deseja realmente cancelar o processamento e sair?", "Confirma" + CHR(231) + CHR(227) + "o")
2731:                 loc_lResultado = .F.
2732:             ENDIF
2733:             THIS.CmdCancelarClick()
2734:         CATCH TO loc_oErro
2735:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message + ;
2736:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2737:         ENDTRY
2738:     ENDPROC
2739: 
2740: 
2741:     *==========================================================================
2742:     * BtnBuscarClick - Retorna a visao principal (fecha paineis flutuantes)
2743:     *==========================================================================
2744:     PROCEDURE BtnBuscarClick()
2745:         LOCAL loc_oErro
2746:         TRY
2747:             THIS.AlternarPagina(1)
2748:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2749:                 THIS.grd_4c_Itens.Refresh
2750:             ENDIF
2751:         CATCH TO loc_oErro
2752:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message + ;
2753:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2754:         ENDTRY
2755:     ENDPROC
2756: 
2757:     *==========================================================================
2758:     * BtnEncerrarClick - Encerra o formulario
2759:     *==========================================================================
2760:     PROCEDURE BtnEncerrarClick()
2761:         THIS.CmdCancelarClick()
2762:     ENDPROC
2763: 
2764:     *==========================================================================
2765:     * BtnSalvarClick - Executa o processamento (equivalente ao Processar)
2766:     *==========================================================================
2767:     PROCEDURE BtnSalvarClick()
2768:         LOCAL loc_oErro
2769:         TRY
2770:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND NOT THIS.cmd_4c_Processar.Enabled
2771:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2772:                 loc_lResultado = .F.
2773:             ENDIF
2774:             THIS.CmdProcessarClick()
2775:         CATCH TO loc_oErro
2776:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + ;
2777:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2778:         ENDTRY
2779:     ENDPROC
2780: 
2781:     *==========================================================================
2782:     * BtnCancelarClick - Cancela e encerra o formulario
2783:     *==========================================================================
2784:     PROCEDURE BtnCancelarClick()
2785:         THIS.CmdCancelarClick()
2786:     ENDPROC
2787: 
2788:     *==========================================================================
2789:     * FormParaBO - Transferencia dos campos do form para o BO
2790:     * Para form OPERACIONAL, os dados fluem diretamente dos cursors compartilhados
2791:     * (TmpFinal, TmpSaldo, TmpSaldG, SelPedra). Este metodo atualiza apenas
2792:     * as propriedades de controle do BO.
2793:     *==========================================================================
2794:     PROTECTED PROCEDURE FormParaBO()
2795:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2796:             RETURN .F.
2797:         ENDIF
2798:         WITH THIS.this_oBusinessObject
2799:             .this_lReserva    = THIS.this_lReserva
2800:             .this_lAutomatico = THIS.this_lAutomatico
2801:             .this_nNumerodaop = THIS.this_nNumerodaop
2802:         ENDWITH
2803:         RETURN .T.
2804:     ENDPROC
2805: 
2806:     *==========================================================================
2807:     * BOParaForm - Transferencia do BO para os campos do form
2808:     * Para form OPERACIONAL, os grids sao alimentados diretamente via
2809:     * RecordSource nos cursors compartilhados. Este metodo atualiza os
2810:     * totalizadores e labels exibidos na barra de informacoes.
2811:     *==========================================================================
2812:     PROTECTED PROCEDURE BOParaForm()
2813:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2814:         TRY
2815:             loc_nSal = 0
2816:             loc_nEst = 0
2817:             loc_nPrz = 0
2818:             IF USED("TmpFinal")
2819:                 SELECT TmpFinal
2820:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2821:                 GO TOP
2822:             ENDIF
2823:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2824:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2825:                 THIS.txt_4c_TotEst.Value = loc_nEst
2826:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2827:             ENDIF
2828:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2829:                 THIS.grd_4c_Itens.Refresh
2830:             ENDIF
2831:             IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2832:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2833:             ENDIF
2834:         CATCH TO loc_oErro
2835:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message + ;
2836:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2837:         ENDTRY
2838:     ENDPROC
2839: 
2840:     *==========================================================================
2841:     * HabilitarCampos - Habilita/desabilita controles conforme o modo
2842:     * Para form OPERACIONAL, o controle de habilitacao e feito por operacao
2843:     * especifica (CmdDisponiveis, CmdEstoques, etc.). Este metodo gerencia o
2844:     * estado da barra principal de botoes conforme this_cModoAtual.
2845:     *==========================================================================
2846:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2847:         LOCAL loc_lHab
2848:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2849:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2850:             THIS.grd_4c_Itens.Enabled      = loc_lHab
2851:         ENDIF
2852:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2853:             THIS.cmd_4c_Processar.Enabled  = loc_lHab
2854:         ENDIF
2855:         IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2856:             THIS.cmd_4c_LinhasTot.Enabled  = loc_lHab
2857:         ENDIF
2858:         IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2859:             THIS.cmd_4c_Disponiveis.Enabled = loc_lHab
2860:         ENDIF
2861:         IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2862:             THIS.cmd_4c_Estoques.Enabled   = loc_lHab
2863:         ENDIF
2864:         IF loc_lHab
2865:             THIS.AjustarBotaoPedras()
2866:         ELSE
2867:             IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2868:                 THIS.cmd_4c_Requisicoes.Enabled = .F.
2869:             ENDIF
2870:         ENDIF
2871:     ENDPROC
2872: 
2873:     *==========================================================================
2874:     * LimparCampos - Limpa campos editaveis do form
2875:     * Para form OPERACIONAL, os cursors compartilhados sao zerados via ZAP
2876:     * no BO. O form apenas reseta os totalizadores e labels locais.
2877:     *==========================================================================
2878:     PROTECTED PROCEDURE LimparCampos()
2879:         IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2880:             THIS.txt_4c_TotQtd.Value = 0
2881:             THIS.txt_4c_TotEst.Value = 0
2882:             THIS.txt_4c_TotPrz.Value = 0
2883:         ENDIF
2884:         IF PEMSTATUS(THIS, "lbl_4c_ObsItens", 5)
2885:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2886:         ENDIF
2887:         IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
2888:             THIS.edt_4c_Obs.ControlSource = ""
2889:         ENDIF
2890:         IF PEMSTATUS(THIS, "img_4c_Figura", 5)
2891:             THIS.img_4c_Figura.Picture = ""
2892:             THIS.img_4c_Figura.Visible = .F.
2893:         ENDIF
2894:         IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2895:             THIS.cnt_4c_Info.txt_4c_TotQtdInfo.Value = 0
2896:             THIS.cnt_4c_Info.txt_4c_TotEstInfo.Value = 0
2897:             THIS.cnt_4c_Info.txt_4c_TotPrzInfo.Value = 0
2898:             THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = ""
2899:             THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = ""
2900:         ENDIF
2901:     ENDPROC
2902: 
2903:     *==========================================================================
2904:     * CarregarLista - Recarrega a grade principal a partir dos cursors
2905:     * Para form OPERACIONAL, nao executa SQL proprio: releia os cursors
2906:     * compartilhados (TmpFinal, TmpSaldG) passados pelo form pai.
2907:     *==========================================================================
2908:     PROCEDURE CarregarLista()
2909:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2910:         loc_nSal = 0
2911:         loc_nEst = 0
2912:         loc_nPrz = 0
2913:         TRY
2914:             IF USED("TmpFinal")
2915:                 SELECT TmpFinal
2916:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2917:                 GO TOP
2918:             ENDIF
2919:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2920:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2921:                 THIS.txt_4c_TotEst.Value = loc_nEst
2922:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2923:             ENDIF
2924:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2925:                 THIS.grd_4c_Itens.Refresh
2926:             ENDIF
2927:             IF USED("TmpSaldG") AND PEMSTATUS(THIS, "cnt_4c_Info", 5)
2928:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2929:             ENDIF
2930:         CATCH TO loc_oErro
2931:             MsgErro("Erro ao recarregar lista: " + loc_oErro.Message + ;
2932:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2933:         ENDTRY
2934:         RETURN .T.
2935:     ENDPROC
2936: 
2937:     *==========================================================================
2938:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme modo atual
2939:     * Para form OPERACIONAL, o "modo" e determinado pelo estado dos containers
2940:     * flutuantes (algum visivel = modo sub-painel; nenhum = modo principal).
2941:     *==========================================================================
2942:     PROCEDURE AjustarBotoesPorModo()
2943:         LOCAL loc_lModoPrincipal
2944:         loc_lModoPrincipal = .T.
2945:         IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
2946:             IF THIS.cnt_4c_Disponivel.Visible
2947:                 loc_lModoPrincipal = .F.
2948:             ENDIF
2949:         ENDIF
2950:         IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
2951:             IF THIS.cnt_4c_Estoques.Visible
2952:                 loc_lModoPrincipal = .F.
2953:             ENDIF
2954:         ENDIF
2955:         IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
2956:             IF THIS.cnt_4c_Linhas.Visible
2957:                 loc_lModoPrincipal = .F.
2958:             ENDIF
2959:         ENDIF
2960:         IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
2961:             IF THIS.cnt_4c_Requisicoes.Visible
2962:                 loc_lModoPrincipal = .F.
2963:             ENDIF
2964:         ENDIF
2965:         THIS.HabilitarCampos(loc_lModoPrincipal)
2966:         IF loc_lModoPrincipal
2967:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2968:                 THIS.cmd_4c_Cancelar.Enabled = .T.
2969:             ENDIF
2970:             IF PEMSTATUS(THIS, "cmd_4c_Relatorio", 5)
2971:                 THIS.cmd_4c_Relatorio.Enabled = .T.
2972:             ENDIF
2973:         ELSE
2974:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2975:                 THIS.cmd_4c_Cancelar.Enabled = .F.
2976:             ENDIF
2977:         ENDIF
2978:     ENDPROC
2979: 
2980: ENDDEFINE

