# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_ESTOQUES, CNT_4C_LINHAS, CNT_4C_REQUISICOES. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Info.grd_4c_DispInfo define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Info.grd_4c_DispInfo.RecordSource).
- [GRID-WITH] Bloco WITH 0 define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: 0.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Estoques.grd_4c_DispEstq define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Estoques.grd_4c_DispEstq.RecordSource).
- [GRID-HEADER] Header Caption 'Prior' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Prioridade, Disponível, Utilizar, Produto, Cor, Tam, Disponivel, Descrição, Uni, Qtde, Linha, Quantidade, Estoque, Produzir, Obs, Movimentação, Código, Atual, Utilizado, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Disponivel' (parent: SIGPRGLP): Left original=622 vs migrado 'cnt_4c_Disponivel' Left=284 (diff=338px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2978 linhas total):

*-- Linhas 50 a 222:
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
97:                 THIS.ConfigurarBotoesPrincipais()
98:                 THIS.ConfigurarGradeItens()
99:                 THIS.ConfigurarContainerInfo()
100:                 THIS.ConfigurarContainerDisponivel()
101:                 THIS.ConfigurarContainerEstoques()
102:                 THIS.ConfigurarContainerLinhas()
103:                 THIS.ConfigurarContainerRequisicoes()
104:                 THIS.ConfigurarTotais()
105:                 THIS.ConfigurarObsItens()
106:                 THIS.ConfigurarPaginaDados()
107:                 THIS.TornarControlesVisiveis()
108:                 THIS.InicializarDados()
109:                 THIS.ConfigurarEventos()
110:                 THIS.AjustarBotaoPedras()
111:                 loc_lSucesso = .T.
112:             ENDIF
113:         CATCH TO loc_oErro
114:             MsgErro("Erro ao inicializar: " + loc_oErro.Message + ;
115:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
116:         ENDTRY
117:         RETURN loc_lSucesso
118:     ENDPROC
119: 
120:     *==========================================================================
121:     * ConfigurarPageFrame - ancora de layout do form OPERACIONAL
122:     *
123:     * OPERACIONAL nao possui PageFrame (layout flat: containers direto no Form).
124:     * Este metodo faz o papel equivalente ao ConfigurarPageFrame dos forms CRUD:
125:     * define a imagem de fundo do Form antes de instanciar os containers filhos.
126:     *==========================================================================
127:     PROTECTED PROCEDURE ConfigurarPageFrame()
128:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarCabecalho - equivale ao cntSombra legado
133:     *==========================================================================
134:     PROTECTED PROCEDURE ConfigurarCabecalho()
135:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
136:         WITH THIS.cnt_4c_Cabecalho
137:             .Top        = 0
138:             .Left       = 0
139:             .Width      = 1004
140:             .Height     = 80
141:             .BackStyle  = 1
142:             .BackColor  = RGB(100,100,100)
143:             .BorderWidth = 0
144:             .AddObject("lbl_4c_Sombra", "Label")
145:             WITH .lbl_4c_Sombra
146:                 .AutoSize  = .F.
147:                 .FontBold  = .T.
148:                 .FontName  = "Tahoma"
149:                 .FontSize  = 18
150:                 .WordWrap  = .T.
151:                 .Alignment = 0
152:                 .BackStyle = 0
153:                 .Caption   = THISFORM.Caption
154:                 .Height    = 40
155:                 .Left      = 10
156:                 .Top       = 18
157:                 .Width     = THIS.Width
158:                 .ForeColor = RGB(0,0,0)
159:             ENDWITH
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .AutoSize  = .F.
163:                 .FontBold  = .T.
164:                 .FontName  = "Tahoma"
165:                 .FontSize  = 18
166:                 .WordWrap  = .T.
167:                 .Alignment = 0
168:                 .BackStyle = 0
169:                 .Caption   = THISFORM.Caption
170:                 .Height    = 46
171:                 .Left      = 10
172:                 .Top       = 17
173:                 .Width     = THIS.Width
174:                 .ForeColor = RGB(255,255,255)
175:             ENDWITH
176:         ENDWITH
177:     ENDPROC
178: 
179:     *==========================================================================
180:     * ConfigurarBotoesPrincipais - 7 botoes da barra superior
181:     *==========================================================================
182:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
183:         LOCAL loc_lcIcones
184:         loc_lcIcones = gc_4c_CaminhoIcones
185: 
186:         THIS.AddObject("cmd_4c_Requisicoes", "CommandButton")
187:         WITH THIS.cmd_4c_Requisicoes
188:             .Top             = 3
189:             .Left            = 472
190:             .Height          = 75
191:             .Width           = 75
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .WordWrap        = .T.
197:             .Caption         = "\<Requisi" + CHR(231) + CHR(245) + "es"
198:             .Picture         = loc_lcIcones + "geral_datas_60.jpg"
199:             .DisabledPicture = loc_lcIcones + "geral_datas_60.jpg"
200:             .Themes          = .T.
201:             .ForeColor       = RGB(90,90,90)
202:             .BackColor       = RGB(255,255,255)
203:             .Enabled         = .F.
204:         ENDWITH
205: 
206:         THIS.AddObject("cmd_4c_Estoques", "CommandButton")
207:         WITH THIS.cmd_4c_Estoques
208:             .Top             = 3
209:             .Left            = 547
210:             .Height          = 75
211:             .Width           = 75
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .FontName        = "Comic Sans MS"
215:             .FontSize        = 8
216:             .WordWrap        = .T.
217:             .Caption         = "\<Estoques"
218:             .Picture         = loc_lcIcones + "geral_marcar_60.jpg"
219:             .DisabledPicture = loc_lcIcones + "geral_marcar_60.jpg"
220:             .Themes          = .T.
221:             .ForeColor       = RGB(90,90,90)
222:             .BackColor       = RGB(255,255,255)

*-- Linhas 322 a 366:
322: 
323:     *==========================================================================
324:     * ConfigurarGradeItens - grid principal TmpFinal (9 colunas)
325:     *==========================================================================
326:     PROTECTED PROCEDURE ConfigurarGradeItens()
327:         THIS.AddObject("grd_4c_Itens", "Grid")
328:         WITH THIS.grd_4c_Itens
329:             .Top               = 125
330:             .Left              = 11
331:             .Height            = 224
332:             .Width             = 708
333:             .ColumnCount       = 9
334:             .FontSize          = 8
335:             .AllowHeaderSizing = .F.
336:             .AllowRowSizing    = .F.
337:             .DeleteMark        = .F.
338:             .RecordMark        = .F.
339:             .Panel             = 1
340:             .RowHeight         = 17
341:             .ScrollBars        = 2
342:             .GridLineColor     = RGB(238,238,238)
343:             WITH .Column1
344:                 .Width              = 115
345:                 .Movable            = .F.
346:                 .Resizable          = .F.
347:                 .ReadOnly           = .T.
348:                 .Header1.Caption    = "Produto"
349:                 .Header1.FontName   = "Verdana"
350:                 .Header1.FontSize   = 8
351:                 .Header1.Alignment  = 2
352:                 .Header1.ForeColor  = RGB(36,84,155)
353:                 .Text1.FontSize     = 8
354:                 .Text1.BorderStyle  = 0
355:                 .Text1.Margin       = 0
356:                 .Text1.ForeColor    = RGB(0,0,0)
357:                 .Text1.BackColor    = RGB(255,255,255)
358:             ENDWITH
359:             WITH .Column2
360:                 .ColumnOrder        = 2
361:                 .Width              = 38
362:                 .Movable            = .F.
363:                 .Resizable          = .F.
364:                 .ReadOnly           = .T.
365:                 .Header1.Caption    = "Cor"
366:                 .Header1.FontName   = "Verdana"

*-- Linhas 505 a 549:
505: 
506:     *==========================================================================
507:     * ConfigurarContainerInfo - Container3: painel informativo sempre visivel
508:     *==========================================================================
509:     PROTECTED PROCEDURE ConfigurarContainerInfo()
510:         THIS.AddObject("cnt_4c_Info", "Container")
511:         WITH THIS.cnt_4c_Info
512:             .Top         = 373
513:             .Left        = 12
514:             .Width       = 708
515:             .Height      = 205
516:             .SpecialEffect = 0
517:             .BackStyle   = 1
518:             .BackColor   = RGB(255,255,255)
519:             .BorderWidth = 0
520: 
521:             .AddObject("lbl_4c_TituloInfo", "Label")
522:             WITH .lbl_4c_TituloInfo
523:                 .AutoSize  = .T.
524:                 .FontBold  = .T.
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 9
527:                 .BackStyle = 0
528:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
529:                 .Height    = 16
530:                 .Left      = 6
531:                 .Top       = 5
532:                 .Width     = 118
533:                 .ForeColor = RGB(90,90,90)
534:             ENDWITH
535: 
536:             .AddObject("grd_4c_DispInfo", "Grid")
537:             WITH .grd_4c_DispInfo
538:                 .Top               = 24
539:                 .Left              = 6
540:                 .Height            = 148
541:                 .Width             = 444
542:                 .ColumnCount       = 6
543:                 .FontSize          = 8
544:                 .AllowHeaderSizing = .F.
545:                 .AllowRowSizing    = .F.
546:                 .DeleteMark        = .F.
547:                 .RecordMark        = .F.
548:                 .Panel             = 1
549:                 .RowHeight         = 16

*-- Linhas 748 a 791:
748:     *==========================================================================
749:     * ConfigurarContainerDisponivel - Container2: disponivel por produto
750:     *==========================================================================
751:     PROTECTED PROCEDURE ConfigurarContainerDisponivel()
752:         LOCAL loc_lcIcones
753:         loc_lcIcones = gc_4c_CaminhoIcones
754:         THIS.AddObject("cnt_4c_Disponivel", "Container")
755:         WITH THIS.cnt_4c_Disponivel
756:             .Top         = 125
757:             .Left        = 12
758:             .Width       = 708
759:             .Height      = 465
760:             .SpecialEffect = 0
761:             .Visible     = .F.
762:             .BackStyle   = 1
763:             .BackColor   = RGB(255,255,255)
764:             .BorderWidth = 0
765: 
766:             .AddObject("lbl_4c_TituloDisp", "Label")
767:             WITH .lbl_4c_TituloDisp
768:                 .AutoSize  = .T.
769:                 .FontBold  = .T.
770:                 .FontName  = "Tahoma"
771:                 .FontSize  = 10
772:                 .BackStyle = 0
773:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
774:                 .Height    = 18
775:                 .Left      = 284
776:                 .Top       = 10
777:                 .Width     = 123
778:                 .ForeColor = RGB(90,90,90)
779:             ENDWITH
780: 
781:             .AddObject("cmd_4c_SairDisp", "CommandButton")
782:             WITH .cmd_4c_SairDisp
783:                 .Top             = 10
784:                 .Left            = 620
785:                 .Height          = 75
786:                 .Width           = 75
787:                 .FontName        = "Comic Sans MS"
788:                 .FontSize        = 8
789:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"
790:                 .DisabledPicture = loc_lcIcones + "cadastro_sair_60.jpg"
791:                 .Cancel          = .T.

*-- Linhas 958 a 1001:
958:     *==========================================================================
959:     * ConfigurarContainerEstoques - Container5: disponivel por conta/grupo
960:     *==========================================================================
961:     PROTECTED PROCEDURE ConfigurarContainerEstoques()
962:         LOCAL loc_lcIcones
963:         loc_lcIcones = gc_4c_CaminhoIcones
964:         THIS.AddObject("cnt_4c_Estoques", "Container")
965:         WITH THIS.cnt_4c_Estoques
966:             .Top         = 125
967:             .Left        = 12
968:             .Width       = 708
969:             .Height      = 465
970:             .SpecialEffect = 0
971:             .Visible     = .F.
972:             .BackStyle   = 1
973:             .BackColor   = RGB(255,255,255)
974:             .BorderWidth = 0
975: 
976:             .AddObject("lbl_4c_TituloEstq", "Label")
977:             WITH .lbl_4c_TituloEstq
978:                 .AutoSize  = .T.
979:                 .FontBold  = .T.
980:                 .FontName  = "Tahoma"
981:                 .FontSize  = 10
982:                 .BackStyle = 0
983:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
984:                 .Height    = 18
985:                 .Left      = 284
986:                 .Top       = 10
987:                 .Width     = 123
988:                 .ForeColor = RGB(90,90,90)
989:             ENDWITH
990: 
991:             .AddObject("cmd_4c_OkEstq", "CommandButton")
992:             WITH .cmd_4c_OkEstq
993:                 .Top             = 10
994:                 .Left            = 620
995:                 .Height          = 75
996:                 .Width           = 75
997:                 .FontBold        = .T.
998:                 .FontItalic      = .T.
999:                 .FontName        = "Comic Sans MS"
1000:                 .FontSize        = 8
1001:                 .WordWrap        = .T.

*-- Linhas 1223 a 1266:
1223:     *==========================================================================
1224:     * ConfigurarContainerLinhas - Container1: pecas por linha
1225:     *==========================================================================
1226:     PROTECTED PROCEDURE ConfigurarContainerLinhas()
1227:         LOCAL loc_lcIcones
1228:         loc_lcIcones = gc_4c_CaminhoIcones
1229:         THIS.AddObject("cnt_4c_Linhas", "Container")
1230:         WITH THIS.cnt_4c_Linhas
1231:             .Top         = 125
1232:             .Left        = 12
1233:             .Width       = 708
1234:             .Height      = 465
1235:             .SpecialEffect = 0
1236:             .Visible     = .F.
1237:             .BackStyle   = 1
1238:             .BackColor   = RGB(255,255,255)
1239:             .BorderWidth = 0
1240: 
1241:             .AddObject("lbl_4c_TituloLin", "Label")
1242:             WITH .lbl_4c_TituloLin
1243:                 .AutoSize  = .T.
1244:                 .FontBold  = .T.
1245:                 .FontName  = "Tahoma"
1246:                 .FontSize  = 10
1247:                 .BackStyle = 0
1248:                 .Caption   = "Pe" + CHR(231) + "as a produzir por linha"
1249:                 .Height    = 18
1250:                 .Left      = 259
1251:                 .Top       = 10
1252:                 .Width     = 170
1253:                 .ForeColor = RGB(90,90,90)
1254:             ENDWITH
1255: 
1256:             .AddObject("cmd_4c_OkLinhas", "CommandButton")
1257:             WITH .cmd_4c_OkLinhas
1258:                 .Top             = 10
1259:                 .Left            = 620
1260:                 .Height          = 75
1261:                 .Width           = 75
1262:                 .FontBold        = .T.
1263:                 .FontItalic      = .T.
1264:                 .FontName        = "Comic Sans MS"
1265:                 .FontSize        = 8
1266:                 .WordWrap        = .T.

*-- Linhas 1370 a 1413:
1370:     *==========================================================================
1371:     * ConfigurarContainerRequisicoes - Container4: componentes adicionais
1372:     *==========================================================================
1373:     PROTECTED PROCEDURE ConfigurarContainerRequisicoes()
1374:         LOCAL loc_lcIcones
1375:         loc_lcIcones = gc_4c_CaminhoIcones
1376:         THIS.AddObject("cnt_4c_Requisicoes", "Container")
1377:         WITH THIS.cnt_4c_Requisicoes
1378:             .Top         = 125
1379:             .Left        = 12
1380:             .Width       = 708
1381:             .Height      = 465
1382:             .SpecialEffect = 0
1383:             .Visible     = .F.
1384:             .BackStyle   = 1
1385:             .BackColor   = RGB(255,255,255)
1386:             .BorderWidth = 0
1387: 
1388:             .AddObject("lbl_4c_TituloReq", "Label")
1389:             WITH .lbl_4c_TituloReq
1390:                 .AutoSize  = .T.
1391:                 .FontBold  = .T.
1392:                 .FontName  = "Tahoma"
1393:                 .FontSize  = 10
1394:                 .BackStyle = 0
1395:                 .Caption   = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1396:                 .Height    = 18
1397:                 .Left      = 229
1398:                 .Top       = 8
1399:                 .Width     = 249
1400:                 .ForeColor = RGB(90,90,90)
1401:             ENDWITH
1402: 
1403:             .AddObject("cmd_4c_SairReq", "CommandButton")
1404:             WITH .cmd_4c_SairReq
1405:                 .Top             = 10
1406:                 .Left            = 620
1407:                 .Height          = 75
1408:                 .Width           = 75
1409:                 .FontBold        = .T.
1410:                 .FontItalic      = .T.
1411:                 .FontName        = "Comic Sans MS"
1412:                 .FontSize        = 8
1413:                 .Picture         = loc_lcIcones + "cadastro_sair_60.jpg"

*-- Linhas 1525 a 1734:
1525:     *==========================================================================
1526:     * ConfigurarTotais - 3 textboxes de totais (Tot_Qtd, Tot_Est, Tot_Prz)
1527:     *==========================================================================
1528:     PROTECTED PROCEDURE ConfigurarTotais()
1529:         THIS.AddObject("txt_4c_TotQtd", "TextBox")
1530:         WITH THIS.txt_4c_TotQtd
1531:             .Height        = 23
1532:             .InputMask     = "999,999.99"
1533:             .Left          = 417
1534:             .SpecialEffect = 1
1535:             .Top           = 349
1536:             .Width         = 80
1537:             .ReadOnly      = .T.
1538:             .Value         = 0
1539:         ENDWITH
1540: 
1541:         THIS.AddObject("txt_4c_TotEst", "TextBox")
1542:         WITH THIS.txt_4c_TotEst
1543:             .Height        = 23
1544:             .InputMask     = "999,999.99"
1545:             .Left          = 498
1546:             .SpecialEffect = 1
1547:             .Top           = 349
1548:             .Width         = 81
1549:             .ReadOnly      = .T.
1550:             .Value         = 0
1551:         ENDWITH
1552: 
1553:         THIS.AddObject("txt_4c_TotPrz", "TextBox")
1554:         WITH THIS.txt_4c_TotPrz
1555:             .Height        = 23
1556:             .InputMask     = "999,999.99"
1557:             .Left          = 580
1558:             .SpecialEffect = 1
1559:             .Top           = 349
1560:             .Width         = 82
1561:             .ReadOnly      = .T.
1562:             .Value         = 0
1563:         ENDWITH
1564:     ENDPROC
1565: 
1566:     *==========================================================================
1567:     * ConfigurarObsItens - imagem do produto + area de observacoes
1568:     *==========================================================================
1569:     PROTECTED PROCEDURE ConfigurarObsItens()
1570:         THIS.AddObject("img_4c_Figura", "Image")
1571:         WITH THIS.img_4c_Figura
1572:             .Stretch = 1
1573:             .Height  = 204
1574:             .Left    = 726
1575:             .Top     = 125
1576:             .Visible = .F.
1577:             .Width   = 266
1578:         ENDWITH
1579: 
1580:         THIS.AddObject("lbl_4c_ObsItens", "Label")
1581:         WITH THIS.lbl_4c_ObsItens
1582:             .AutoSize  = .T.
1583:             .FontBold  = .T.
1584:             .FontName  = "Verdana"
1585:             .FontSize  = 8
1586:             .BackStyle = 0
1587:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Item"
1588:             .Height    = 15
1589:             .Left      = 726
1590:             .Top       = 369
1591:             .Width     = 134
1592:             .ForeColor = RGB(255,255,255)
1593:         ENDWITH
1594: 
1595:         THIS.AddObject("edt_4c_Obs", "EditBox")
1596:         WITH THIS.edt_4c_Obs
1597:             .Height = 205
1598:             .Left   = 732
1599:             .Top    = 361
1600:             .Width  = 266
1601:         ENDWITH
1602:     ENDPROC
1603: 
1604:     *==========================================================================
1605:     * ConfigurarPaginaDados - Fase 5/8: elementos decorativos complementares
1606:     *
1607:     * Para form OPERACIONAL flat (sem PageFrame/Page2 de CRUD), este metodo
1608:     * adiciona elementos visuais secundarios sobrepostos ao layout principal.
1609:     * Fase 5 (primeira metade): Shape2 - decoracao superior esquerda do header.
1610:     *   Corresponde ao Shape2 do legado: top=9, left=9, 279x51
1611:     *   Posicionado sobre o cnt_4c_Cabecalho para criar destaque visual na
1612:     *   area de titulo/empresa, conforme o original SIGPRGLP.SCX.
1613:     *==========================================================================
1614:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1615:         LOCAL loc_oErro
1616:         TRY
1617:             THIS.AddObject("shp_4c_Shape2", "Shape")
1618:             WITH THIS.shp_4c_Shape2
1619:                 .Top           = 9
1620:                 .Left          = 9
1621:                 .Height        = 51
1622:                 .Width         = 279
1623:                 .SpecialEffect = 0
1624:                 .BorderStyle   = 1
1625:                 .BorderWidth   = 1
1626:                 .BorderColor   = RGB(160,160,160)
1627:                 .FillStyle     = 0
1628:                 .FillColor     = RGB(80,80,80)
1629:                 .BackStyle     = 0
1630:                 .Curvature     = 5
1631:             ENDWITH
1632: 
1633:             THIS.AddObject("shp_4c_Shape3", "Shape")
1634:             WITH THIS.shp_4c_Shape3
1635:                 .Top           = 10
1636:                 .Left          = 820
1637:                 .Height        = 38
1638:                 .Width         = 116
1639:                 .SpecialEffect = 0
1640:                 .BorderStyle   = 1
1641:                 .BorderWidth   = 1
1642:                 .BorderColor   = RGB(160,160,160)
1643:                 .FillStyle     = 0
1644:                 .FillColor     = RGB(80,80,80)
1645:                 .BackStyle     = 0
1646:                 .Curvature     = 3
1647:             ENDWITH
1648:         CATCH TO loc_oErro
1649:             MsgErro("Erro em ConfigurarPaginaDados: " + loc_oErro.Message + ;
1650:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1651:         ENDTRY
1652:     ENDPROC
1653: 
1654:     *==========================================================================
1655:     * TornarControlesVisiveis - containers ocultos mantem filhos visiveis
1656:     *==========================================================================
1657:     PROTECTED PROCEDURE TornarControlesVisiveis()
1658:         LOCAL loc_i, loc_oCtrl, loc_cNome
1659:         FOR loc_i = 1 TO THIS.ControlCount
1660:             loc_oCtrl = THIS.Controls(loc_i)
1661:             loc_cNome = UPPER(loc_oCtrl.Name)
1662:             IF INLIST(loc_cNome, "CNT_4C_DISPONIVEL", "CNT_4C_ESTOQUES", "CNT_4C_LINHAS", "CNT_4C_REQUISICOES")
1663:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1664:                 LOOP
1665:             ENDIF
1666:             loc_oCtrl.Visible = .T.
1667:         NEXT
1668:     ENDPROC
1669: 
1670:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1671:         LOCAL loc_i, loc_oCtrl
1672:         FOR loc_i = 1 TO par_oContainer.ControlCount
1673:             loc_oCtrl = par_oContainer.Controls(loc_i)
1674:             loc_oCtrl.Visible = .T.
1675:             IF loc_oCtrl.BaseClass = "Container"
1676:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1677:             ENDIF
1678:         NEXT
1679:     ENDPROC
1680: 
1681:     *==========================================================================
1682:     * InicializarDados - ControlSources, queries iniciais, totais
1683:     *==========================================================================
1684:     PROTECTED PROCEDURE InicializarDados()
1685:         LOCAL loc_lSucesso, loc_oErro, loc_nSal, loc_nEst, loc_nPrz, loc_lcQuery
1686:         loc_lSucesso = .F.
1687:         TRY
1688:             *-- ControlSources GradeItens (mapeamento exato do legado)
1689:             WITH THIS.grd_4c_Itens
1690:                 .RecordSource            = "TmpFinal"
1691:                 .Column1.ControlSource   = "TmpFinal.Cpros"
1692:                 .Column2.ControlSource   = "TmpFinal.CodCors"
1693:                 .Column3.ControlSource   = "TmpFinal.Dopes"
1694:                 .Column4.ControlSource   = "TmpFinal.Numes"
1695:                 .Column5.ControlSource   = "TmpFinal.Saldo"
1696:                 .Column6.ControlSource   = "TmpFinal.Produzir"
1697:                 .Column7.ControlSource   = "TmpFinal.Estoque"
1698:                 .Column8.ControlSource   = "IIF(EMPTY(TmpFinal.Obsps),' ','*')"
1699:                 .Column9.ControlSource   = "TmpFinal.CodTams"
1700:             ENDWITH
1701: 
1702:             *-- Se TransfRes vazio, grid somente leitura
1703:             IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1704:                 IF EMPTY(ALLTRIM(crSigCdPam.TransfRes))
1705:                     THIS.grd_4c_Itens.SetAll("ReadOnly", .T.)
1706:                 ENDIF
1707:             ENDIF
1708: 
1709:             *-- TmpSaldG para Container3
1710:             IF USED("TmpSaldG")
1711:                 SELECT TmpSaldG
1712:                 SET ORDER TO Cpros
1713:                 IF USED("TmpFinal") .AND. NOT EOF("TmpFinal")
1714:                     SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1715:                 ENDIF
1716:                 GO TOP
1717:             ENDIF
1718: 
1719:             WITH THIS.cnt_4c_Info.grd_4c_DispInfo
1720:                 .RecordSource            = "TmpSaldG"
1721:                 .Column1.ControlSource   = "TmpSaldG.Grupos"
1722:                 .Column2.ControlSource   = "TmpSaldG.Estos"
1723:                 .Column3.ControlSource   = "TmpSaldG.Saldo"
1724:                 .Column4.ControlSource   = "TmpSaldG.Saldo - TmpSaldG.Disps"
1725:                 .Column5.ControlSource   = "TmpSaldG.Disps"
1726:                 .Column6.ControlSource   = "TmpSaldG.Emps"
1727:                 .SetAll("ReadOnly", .T.)
1728:             ENDWITH
1729: 
1730:             *-- Cursor de rastreamento de selecao manual
1731:             IF NOT USED("TmpSaldU")
1732:                 CREATE CURSOR TmpSaldU (Cpros C(14), KeySelm L)
1733:                 INDEX ON Cpros TAG Cpros
1734:             ENDIF

*-- Linhas 1784 a 1886:
1784:     *==========================================================================
1785:     * AjustarBotaoPedras - habilitar apenas se parametros completos
1786:     *==========================================================================
1787:     PROTECTED PROCEDURE AjustarBotaoPedras()
1788:         THIS.cmd_4c_Requisicoes.Enabled = .F.
1789:         IF USED("crSigCdPam") .AND. NOT EOF("crSigCdPam")
1790:             IF NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) .AND. ;
1791:                NOT EMPTY(ALLTRIM(crSigCdPam.DopReqcs)) .AND. ;
1792:                NOT EMPTY(ALLTRIM(crSigCdPam.DopPedcs)) .AND. ;
1793:                NOT EMPTY(ALLTRIM(crSigCdPam.DopComps)) .AND. ;
1794:                NOT THIS.this_lReserva
1795:                 THIS.cmd_4c_Requisicoes.Enabled = .T.
1796:             ENDIF
1797:         ENDIF
1798:     ENDPROC
1799: 
1800:     *==========================================================================
1801:     * ConfigurarEventos - BINDEVENT para todos os eventos
1802:     *==========================================================================
1803:     PROTECTED PROCEDURE ConfigurarEventos()
1804:         BINDEVENT(THIS.grd_4c_Itens,                                     "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
1805:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "When",              THIS, "GradeItensColumn6When")
1806:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "Valid",             THIS, "GradeItensColumn6Valid")
1807:         BINDEVENT(THIS.grd_4c_Itens.Column6.Text1,                       "KeyPress",         THIS, "GradeItensColumn6LostFocus")
1808:         BINDEVENT(THIS.grd_4c_Itens.Column1.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1809:         BINDEVENT(THIS.grd_4c_Itens.Column2.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1810:         BINDEVENT(THIS.grd_4c_Itens.Column3.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1811:         BINDEVENT(THIS.grd_4c_Itens.Column4.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1812:         BINDEVENT(THIS.grd_4c_Itens.Column5.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1813:         BINDEVENT(THIS.grd_4c_Itens.Column7.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1814:         BINDEVENT(THIS.grd_4c_Itens.Column8.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1815:         BINDEVENT(THIS.grd_4c_Itens.Column9.Text1,                       "GotFocus",          THIS, "GradeItensRedirFoco")
1816:         BINDEVENT(THIS.cnt_4c_Info.grd_4c_DispInfo,                      "AfterRowColChange", THIS, "GradeDispInfoAfterRowColChange")
1817:         BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq,                  "AfterRowColChange", THIS, "GradeDispEstqAfterRowColChange")
1818:         BINDEVENT(THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1,    "Valid",             THIS, "GradeDispEstqColumn5Valid")
1819:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1,  "Valid",             THIS, "GradeDispProdColumn5Valid")
1820:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column1.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1821:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column2.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1822:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column3.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1823:         BINDEVENT(THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column4.Text1, "GotFocus",          THIS, "GradeDispProdRedirFoco")
1824:         BINDEVENT(THIS.cmd_4c_Disponiveis,                                "Click",             THIS, "CmdDisponiveisClick")
1825:         BINDEVENT(THIS.cmd_4c_LinhasTot,                                  "Click",             THIS, "CmdLinhasTotClick")
1826:         BINDEVENT(THIS.cmd_4c_Requisicoes,                                "Click",             THIS, "CmdRequisoesClick")
1827:         BINDEVENT(THIS.cmd_4c_Estoques,                                   "Click",             THIS, "CmdEstoquesClick")
1828:         BINDEVENT(THIS.cmd_4c_Relatorio,                                  "Click",             THIS, "CmdRelatorioClick")
1829:         BINDEVENT(THIS.cmd_4c_Processar,                                  "Click",             THIS, "CmdProcessarClick")
1830:         BINDEVENT(THIS.cmd_4c_Cancelar,                                   "Click",             THIS, "CmdCancelarClick")
1831:         BINDEVENT(THIS.cnt_4c_Estoques.cmd_4c_OkEstq,                    "Click",             THIS, "CancelarC5Click")
1832:         BINDEVENT(THIS.cnt_4c_Disponivel.cmd_4c_SairDisp,                "Click",             THIS, "CancelarC2Click")
1833:         BINDEVENT(THIS.cnt_4c_Requisicoes.cmd_4c_SairReq,                "Click",             THIS, "CancelarC4Click")
1834:         BINDEVENT(THIS.cnt_4c_Linhas.cmd_4c_OkLinhas,                    "Click",             THIS, "CancelarC1Click")
1835:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1, "Valid",             THIS, "GradePedra1Valid")
1836:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "When",              THIS, "GradePedra5When")
1837:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "Valid",             THIS, "GradePedra5Valid")
1838:         BINDEVENT(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1, "KeyPress",         THIS, "GradePedra5LostFocus")
1839:         BINDEVENT(THIS.img_4c_Figura,                                     "DblClick",          THIS, "ImgFiguraDblClick")
1840:     ENDPROC
1841: 
1842:     *==========================================================================
1843:     * HANDLERS DE EVENTOS
1844:     *==========================================================================
1845: 
1846:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1847:         LOCAL loc_lcArquivo, loc_lcFoto, loc_oErro
1848:         TRY
1849:             THIS.edt_4c_Obs.Refresh
1850:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
1851: 
1852:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1853: 
1854:             IF USED("TmpSaldG")
1855:                 SELECT TmpSaldG
1856:                 SET ORDER TO Cpros
1857:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1858:                 GO TOP
1859:             ENDIF
1860: 
1861:             WITH THIS.cnt_4c_Info
1862:                 .txt_4c_TotQtdInfo.Value = TmpSaldo.Saldo
1863:                 .txt_4c_TotEstInfo.Value = TmpSaldo.Saldo - TmpSaldo.Disps
1864:                 .txt_4c_TotPrzInfo.Value = TmpSaldo.Disps
1865:                 .lbl_4c_TituloInfo.Caption = TmpFinal.Cpros + ;
1866:                     IIF(NOT EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
1867:                     IIF(NOT EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
1868: 
1869:                 IF THIS.this_oBusinessObject.AtualizarInfoItem(par_nColIndex)
1870:                     .txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
1871:                     .txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
1872:                 ENDIF
1873:                 .grd_4c_DispInfo.Refresh
1874:                 .Visible     = .T.
1875:             ENDWITH
1876: 
1877:             *-- Imagem do produto
1878:             loc_lcArquivo = SYS(2023) + "\TempGlb.jpg"
1879:             CLEAR RESOURCES
1880:             THIS.img_4c_Figura.Picture = ""
1881:             THIS.img_4c_Figura.Visible = .F.
1882:             IF SQLEXEC(gnConnHandle, "SELECT FigJpgs FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crSigProFig") > 0
1883:                 IF NOT EOF("crSigProFig")
1884:                     IF NOT EMPTY(crSigProFig.FigJpgs) .AND. NOT ISNULL(crSigProFig.FigJpgs)
1885:                         loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(crSigProFig.FigJpgs, ;
1886:                             "data:image/png;base64,", ""), ;

*-- Linhas 1900 a 2978:
1900:             MsgErro(loc_oErro.Message, "Erro")
1901:         ENDTRY
1902:     ENDPROC
1903: 
1904:     PROCEDURE GradeItensRedirFoco()
1905:         THIS.grd_4c_Itens.Column6.Text1.SetFocus
1906:     ENDPROC
1907: 
1908:     PROCEDURE GradeDispProdRedirFoco()
1909:         THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.SetFocus
1910:     ENDPROC
1911: 
1912:     PROCEDURE GradeItensColumn6When()
1913:         LOCAL loc_oErro
1914:         THIS.this_oBusinessObject.this_nOldValue = THIS.grd_4c_Itens.Column6.Text1.Value
1915:         IF THIS.this_lReserva .AND. (TmpFinal.Estoque = 0)
1916:             TRY
1917:                 IF SQLEXEC(gnConnHandle, "SELECT CGrus FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), "crTmpPro") > 0
1918:                     IF NOT EOF("crTmpPro")
1919:                         IF SQLEXEC(gnConnHandle, "SELECT TipoEstos FROM SigCdGrp WHERE CGrus = " + EscaparSQL(ALLTRIM(crTmpPro.CGrus)), "crTmpGru") > 0
1920:                             IF NOT EOF("crTmpGru")
1921:                                 IF INLIST(crTmpGru.TipoEstos, 3, 4)
1922:                                     THIS.cmd_4c_Disponiveis.Enabled = .T.
1923:                                 ENDIF
1924:                             ENDIF
1925:                             USE IN crTmpGru
1926:                         ENDIF
1927:                     ENDIF
1928:                     USE IN crTmpPro
1929:                 ENDIF
1930:             CATCH TO loc_oErro
1931:                 MsgErro(loc_oErro.Message, "Erro")
1932:             ENDTRY
1933:         ENDIF
1934:         RETURN .T.
1935:     ENDPROC
1936: 
1937:     PROCEDURE GradeItensColumn6Valid()
1938:         LOCAL loc_lResultado, loc_nNovoValor, loc_xBaixa, loc_oErro
1939:         loc_lResultado = .T.
1940:         loc_nNovoValor = THIS.grd_4c_Itens.Column6.Text1.Value
1941:         TRY
1942:             IF NOT SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1943:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1944:             ENDIF
1945:             IF loc_nNovoValor <> THIS.this_oBusinessObject.this_nOldValue .AND. TmpSaldU.KeySelm
1946:                 IF NOT MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + CHR(13) + ;
1947:                     "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?")
1948:                     THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1949:                     loc_lResultado = .F.
1950:                 ENDIF
1951:             ENDIF
1952:             IF loc_lResultado
1953:                 DO CASE
1954:                     CASE loc_nNovoValor = THIS.this_oBusinessObject.this_nOldValue
1955:                         *-- nenhuma mudanca
1956:                     CASE loc_nNovoValor < 0
1957:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
1958:                         THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1959:                         loc_lResultado = .F.
1960:                     CASE loc_nNovoValor > TmpFinal.Saldo
1961:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
1962:                         THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
1963:                         loc_lResultado = .F.
1964:                     CASE NOT SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") .AND. ;
1965:                          (TmpFinal.Produzir <> TmpFinal.Saldo)
1966:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
1967:                         THIS.grd_4c_Itens.Column6.Text1.Value = TmpFinal.Saldo
1968:                         loc_lResultado = .F.
1969:                     OTHERWISE
1970:                         IF (TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNovoValor)
1971:                             REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
1972:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNovoValor IN TmpFinal
1973:                             REPLACE KeySelm WITH .F. IN TmpSaldU
1974:                             SELECT TmpSaldo
1975:                             loc_xBaixa = TmpSaldo.Saldo - TmpSaldo.Disps
1976:                             SELECT TmpSaldG
1977:                             SET ORDER TO Cpros
1978:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1979:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros .AND. ;
1980:                                 CodCors = TmpSaldo.CodCors .AND. CodTams = TmpSaldo.CodTams
1981:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1982:                             SCAN WHILE Cpros = TmpSaldo.Cpros .AND. CodCors = TmpSaldo.CodCors .AND. ;
1983:                                 CodTams = TmpSaldo.CodTams .AND. loc_xBaixa > 0
1984:                                 IF TmpSaldG.Disps >= loc_xBaixa
1985:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - loc_xBaixa
1986:                                     loc_xBaixa = 0
1987:                                 ELSE
1988:                                     loc_xBaixa = loc_xBaixa - TmpSaldG.Disps
1989:                                     REPLACE TmpSaldG.Disps WITH 0
1990:                                 ENDIF
1991:                             ENDSCAN
1992:                         ELSE
1993:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
1994:                             THIS.grd_4c_Itens.Column6.Text1.Value = THIS.this_oBusinessObject.this_nOldValue
1995:                             loc_lResultado = .F.
1996:                         ENDIF
1997:                 ENDCASE
1998:             ENDIF
1999:         CATCH TO loc_oErro
2000:             MsgErro(loc_oErro.Message, "Erro")
2001:             loc_lResultado = .F.
2002:         ENDTRY
2003:         RETURN loc_lResultado
2004:     ENDPROC
2005: 
2006:     PROCEDURE GradeItensColumn6LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2007:         IF NOT INLIST(par_nKeyCode, 13, 9)
2008:             RETURN
2009:         ENDIF
2010:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2011:         TRY
2012:             SELECT TmpFinal
2013:             loc_nRecno = RECNO()
2014:             SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2015:             GO loc_nRecno
2016:             THIS.txt_4c_TotQtd.Value = loc_nSal
2017:             THIS.txt_4c_TotEst.Value = loc_nEst
2018:             THIS.txt_4c_TotPrz.Value = loc_nPrz
2019:             THIS.txt_4c_TotQtd.Refresh
2020:             THIS.txt_4c_TotEst.Refresh
2021:             THIS.txt_4c_TotPrz.Refresh
2022:             THIS.Refresh
2023:         CATCH TO loc_oErro
2024:             MsgErro(loc_oErro.Message, "Erro")
2025:         ENDTRY
2026:     ENDPROC
2027: 
2028:     PROCEDURE GradeDispInfoAfterRowColChange(par_nColIndex)
2029:         LOCAL loc_oErro
2030:         TRY
2031:             IF THIS.this_oBusinessObject.AtualizarInfoContainer3(par_nColIndex)
2032:                 THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = THIS.this_oBusinessObject.this_cDscGrupo
2033:                 THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = THIS.this_oBusinessObject.this_cDscConta
2034:             ENDIF
2035:         CATCH TO loc_oErro
2036:             MsgErro(loc_oErro.Message, "Erro")
2037:         ENDTRY
2038:     ENDPROC
2039: 
2040:     PROCEDURE GradeDispEstqAfterRowColChange(par_nColIndex)
2041:         LOCAL loc_oErro
2042:         TRY
2043:             IF THIS.this_oBusinessObject.AtualizarInfoDisponivelConta(par_nColIndex)
2044:                 THIS.cnt_4c_Estoques.txt_4c_DGrupoEstq.Value = THIS.this_oBusinessObject.this_cDscGrupo
2045:                 THIS.cnt_4c_Estoques.txt_4c_DContaEstq.Value = THIS.this_oBusinessObject.this_cDscConta
2046:             ENDIF
2047:         CATCH TO loc_oErro
2048:             MsgErro(loc_oErro.Message, "Erro")
2049:         ENDTRY
2050:     ENDPROC
2051: 
2052:     PROCEDURE GradeDispEstqColumn5Valid()
2053:         LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
2054:         loc_lResultado = .T.
2055:         loc_nNovoValor = THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value
2056:         TRY
2057:             IF loc_nNovoValor > TmpDisp.Disps
2058:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Dispon" + CHR(237) + "vel...", "")
2059:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2060:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2061:                 loc_lResultado = .F.
2062:             ELSE
2063:                 IF loc_nNovoValor < 0
2064:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
2065:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2066:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2067:                 loc_lResultado = .F.
2068:             ELSE
2069:                 loc_nRegDisp = RECNO("TmpDisp")
2070:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2071:                 GO loc_nRegDisp IN TmpDisp
2072:                 IF loc_nQtdUti > TmpFinal.Saldo - TmpFinal.Estoque
2073:                     MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
2074:                     THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Value = 0
2075:                     THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.Text1.Refresh
2076:                     loc_lResultado = .F.
2077:                 ELSE
2078:                     THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value = loc_nQtdUti
2079:                     THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Refresh
2080:                 ENDIF
2081:                 ENDIF
2082:             ENDIF
2083:         CATCH TO loc_oErro
2084:             MsgErro(loc_oErro.Message, "Erro")
2085:             loc_lResultado = .F.
2086:         ENDTRY
2087:         RETURN loc_lResultado
2088:     ENDPROC
2089: 
2090:     PROCEDURE GradeDispProdColumn5Valid()
2091:         LOCAL loc_lResultado, loc_nNovoValor, loc_nRegDisp, loc_nQtdUti, loc_oErro
2092:         loc_lResultado = .T.
2093:         loc_nNovoValor = THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value
2094:         TRY
2095:             IF loc_nNovoValor > TmpDisp.Disps
2096:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
2097:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
2098:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
2099:                 loc_lResultado = .F.
2100:             ELSE
2101:                 loc_nRegDisp = RECNO("TmpDisp")
2102:                 SUM TmpDisp.Utilizar TO loc_nQtdUti
2103:                 GO loc_nRegDisp IN TmpDisp
2104:                 IF loc_nQtdUti > TmpFinal.Saldo
2105:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
2106:                     THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Value = 0
2107:                     THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.Text1.Refresh
2108:                     loc_lResultado = .F.
2109:                 ELSE
2110:                     THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Value = loc_nQtdUti
2111:                     THIS.cnt_4c_Disponivel.txt_4c_SelecDisp.Refresh
2112:                 ENDIF
2113:             ENDIF
2114:         CATCH TO loc_oErro
2115:             MsgErro(loc_oErro.Message, "Erro")
2116:             loc_lResultado = .F.
2117:         ENDTRY
2118:         RETURN loc_lResultado
2119:     ENDPROC
2120: 
2121:     *-- Disponivel.Click: abre Container2 com estoque por produto/cor/tam
2122:     PROCEDURE CmdDisponiveisClick()
2123:         LOCAL loc_oErro
2124:         TRY
2125:             THIS.this_oBusinessObject.BuscarDisponivel(TmpFinal.Cpros, TmpFinal.CodCors)
2126:             IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
2127:                 MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
2128:                 THIS.CancelarC2Click()
2129:             ELSE
2130:                 WITH THIS.cnt_4c_Disponivel.grd_4c_DispProd
2131:                     .ColumnCount             = 5
2132:                     .RecordSource            = "TmpDisp"
2133:                     .Column1.Width           = 80
2134:                     .Column2.Width           = 38
2135:                     .Column3.Width           = 24
2136:                     .Column4.Width           = 75
2137:                     .Column5.Width           = 75
2138:                     .Column1.Header1.Caption = "Produto"
2139:                     .Column2.Header1.Caption = "Cor"
2140:                     .Column3.Header1.Caption = "Tam"
2141:                     .Column4.Header1.Caption = "Disponivel"
2142:                     .Column5.Header1.Caption = "Utilizar"
2143:                     .Column1.ControlSource   = "TmpDisp.Cpros"
2144:                     .Column2.ControlSource   = "TmpDisp.CodCors"
2145:                     .Column3.ControlSource   = "TmpDisp.CodTams"
2146:                     .Column4.ControlSource   = "TmpDisp.Disps"
2147:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2148:                 ENDWITH
2149:                 THIS.cnt_4c_Disponivel.txt_4c_PedidaDisp.Value = TmpFinal.Saldo
2150:                 THIS.grd_4c_Itens.Enabled        = .F.
2151:                 THIS.cmd_4c_Processar.Enabled    = .F.
2152:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2153:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2154:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2155:                 THIS.cnt_4c_Info.Enabled         = .F.
2156:                 THIS.cnt_4c_Disponivel.Visible   = .T.
2157:                 THIS.cnt_4c_Disponivel.ZOrder(0)
2158:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2159:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Column5.SetFocus
2160:                 THIS.cnt_4c_Disponivel.grd_4c_DispProd.Refresh
2161:             ENDIF
2162:         CATCH TO loc_oErro
2163:             MsgErro(loc_oErro.Message, "Erro")
2164:         ENDTRY
2165:     ENDPROC
2166: 
2167:     *-- TotLinha.Click: abre Container1 com total por linha de producao
2168:     PROCEDURE CmdLinhasTotClick()
2169:         LOCAL loc_oErro
2170:         TRY
2171:             THIS.this_oBusinessObject.BuscarPorLinhas()
2172:             WITH THIS.cnt_4c_Linhas.grd_4c_LinhasAgg
2173:                 .ColumnCount           = 4
2174:                 .RecordSource          = "TmpLinha"
2175:                 .Column1.ControlSource = "TmpLinha.Linhas"
2176:                 .Column2.ControlSource = "TmpLinha.Saldo"
2177:                 .Column3.ControlSource = "TmpLinha.Estoque"
2178:                 .Column4.ControlSource = "TmpLinha.Produzir"
2179:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas=[TOTAIS]",                              "Column")
2180:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas=[TOTAIS],RGB(0,0,255),RGB(0,0,0))", "Column")
2181:             ENDWITH
2182:             THIS.cmd_4c_Processar.Enabled   = .F.
2183:             THIS.cmd_4c_Cancelar.Enabled    = .F.
2184:             THIS.cmd_4c_LinhasTot.Enabled   = .F.
2185:             THIS.cmd_4c_Requisicoes.Enabled = .F.
2186:             THIS.cmd_4c_Disponiveis.Enabled = .F.
2187:             THIS.grd_4c_Itens.Enabled       = .F.
2188:             THIS.cnt_4c_Info.Enabled        = .F.
2189:             THIS.cnt_4c_Linhas.Visible      = .T.
2190:             THIS.cnt_4c_Linhas.ZOrder(0)
2191:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Refresh
2192:             THIS.cnt_4c_Linhas.grd_4c_LinhasAgg.Column1.SetFocus
2193:         CATCH TO loc_oErro
2194:             MsgErro(loc_oErro.Message, "Erro")
2195:         ENDTRY
2196:     ENDPROC
2197: 
2198:     *-- Pedras.Click: abre Container4 com requisicoes de componentes
2199:     PROCEDURE CmdRequisoesClick()
2200:         LOCAL loc_oErro
2201:         TRY
2202:             WITH THIS.cnt_4c_Requisicoes.grd_4c_PedraReq
2203:                 .ColumnCount           = 5
2204:                 .RecordSource          = "SelPedra"
2205:                 .Column1.ControlSource = "SelPedra.Cpros"
2206:                 .Column2.ControlSource = "SelPedra.Dpros"
2207:                 .Column3.ControlSource = "SelPedra.Cunis"
2208:                 .Column4.ControlSource = "SelPedra.Qtds"
2209:                 .Column5.ControlSource = "SelPedra.Cpro2s"
2210:             ENDWITH
2211:             THIS.cmd_4c_Processar.Enabled    = .F.
2212:             THIS.cmd_4c_Cancelar.Enabled     = .F.
2213:             THIS.cmd_4c_LinhasTot.Enabled    = .F.
2214:             THIS.cmd_4c_Requisicoes.Enabled  = .F.
2215:             THIS.cmd_4c_Disponiveis.Enabled  = .F.
2216:             THIS.grd_4c_Itens.Enabled        = .F.
2217:             THIS.cnt_4c_Info.Enabled         = .F.
2218:             THIS.cnt_4c_Requisicoes.Visible  = .T.
2219:             THIS.cnt_4c_Requisicoes.ZOrder(0)
2220:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2221:             THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.SetFocus
2222:         CATCH TO loc_oErro
2223:             MsgErro(loc_oErro.Message, "Erro")
2224:         ENDTRY
2225:     ENDPROC
2226: 
2227:     *-- SelEstoque.Click: abre Container5 com disponivel por conta/grupo
2228:     PROCEDURE CmdEstoquesClick()
2229:         LOCAL loc_oErro
2230:         TRY
2231:             THIS.this_oBusinessObject.BuscarEstoqueDetalhado(TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams)
2232:             IF NOT USED("TmpDisp") .OR. RECCOUNT("TmpDisp") = 0
2233:                 MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
2234:                 THIS.CancelarC5Click()
2235:             ELSE
2236:                 WITH THIS.cnt_4c_Estoques.grd_4c_DispEstq
2237:                     .ColumnCount             = 5
2238:                     .RecordSource            = "TmpDisp"
2239:                     .Column1.Width           = 80
2240:                     .Column2.Width           = 80
2241:                     .Column3.Width           = 24
2242:                     .Column4.Width           = 75
2243:                     .Column5.Width           = 75
2244:                     .Column1.Header1.Caption = "Grupo"
2245:                     .Column2.Header1.Caption = "Conta"
2246:                     .Column3.Header1.Caption = "Prior"
2247:                     .Column4.Header1.Caption = "Disponivel"
2248:                     .Column5.Header1.Caption = "Utilizar"
2249:                     .Column1.ControlSource   = "TmpDisp.Grupos"
2250:                     .Column2.ControlSource   = "TmpDisp.Estos"
2251:                     .Column3.ControlSource   = "TmpDisp.Priors"
2252:                     .Column4.ControlSource   = "TmpDisp.Disps"
2253:                     .Column5.ControlSource   = "TmpDisp.Utilizar"
2254:                 ENDWITH
2255:                 THIS.cnt_4c_Estoques.lbl_4c_TituloEstq.Caption = ;
2256:                     "Estoque Dispon" + CHR(237) + "vel (" + TmpFinal.Cpros + " " + TmpFinal.CodCors + "/" + TmpFinal.CodTams + ")"
2257:                 THIS.cnt_4c_Estoques.txt_4c_PedidaEstq.Value = TmpFinal.Saldo - TmpFinal.Estoque
2258:                 THIS.cnt_4c_Estoques.txt_4c_SelecEstq.Value  = 0
2259:                 THIS.cmd_4c_Processar.Enabled    = .F.
2260:                 THIS.cmd_4c_Cancelar.Enabled     = .F.
2261:                 THIS.cmd_4c_LinhasTot.Enabled    = .F.
2262:                 THIS.cmd_4c_Disponiveis.Enabled  = .F.
2263:                 THIS.cmd_4c_Estoques.Enabled     = .F.
2264:                 THIS.cmd_4c_Requisicoes.Enabled  = .F.
2265:                 THIS.cnt_4c_Info.Enabled         = .F.
2266:                 THIS.cnt_4c_Estoques.Visible     = .T.
2267:                 THIS.cnt_4c_Estoques.ZOrder(0)
2268:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
2269:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Column5.SetFocus
2270:                 THIS.cnt_4c_Estoques.grd_4c_DispEstq.Refresh
2271:             ENDIF
2272:         CATCH TO loc_oErro
2273:             MsgErro(loc_oErro.Message, "Erro")
2274:         ENDTRY
2275:     ENDPROC
2276: 
2277:     *-- btnRelatorio.Click: gerar relatorio SigReGlp
2278:     PROCEDURE CmdRelatorioClick()
2279:         LOCAL loc_oErro
2280:         TRY
2281:             THIS.this_oBusinessObject.GerarRelatorio()
2282:         CATCH TO loc_oErro
2283:             MsgErro(loc_oErro.Message, "Erro")
2284:         ENDTRY
2285:     ENDPROC
2286: 
2287:     *-- Processar.Click: executa globalizacao/reserva
2288:     PROCEDURE CmdProcessarClick()
2289:         LOCAL loc_dPrev, loc_dGera, loc_oPP, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2290:         loc_dPrev = {}
2291:         loc_dGera = {}
2292:         *-- Extrair datas do avo via PEMSTATUS para evitar CATCH silencioso
2293:         IF VARTYPE(THIS.this_oParentForm) = "O"
2294:             IF PEMSTATUS(THIS.this_oParentForm, "ParentForm", 5)
2295:                 loc_oPP = THIS.this_oParentForm.ParentForm
2296:                 IF VARTYPE(loc_oPP) = "O"
2297:                     IF PEMSTATUS(loc_oPP, "Cnt_Previsao", 5)
2298:                         IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetPrevisao", 5)
2299:                             loc_dPrev = loc_oPP.Cnt_Previsao.GetPrevisao.Value
2300:                         ENDIF
2301:                         IF PEMSTATUS(loc_oPP.Cnt_Previsao, "GetGeracao", 5)
2302:                             loc_dGera = loc_oPP.Cnt_Previsao.GetGeracao.Value
2303:                         ENDIF
2304:                     ENDIF
2305:                 ENDIF
2306:             ENDIF
2307:         ENDIF
2308:         TRY
2309:             IF THIS.this_oBusinessObject.Processar(loc_dPrev, loc_dGera)
2310:                 THIS.grd_4c_Itens.Refresh
2311:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2312:                 IF USED("TmpFinal")
2313:                     SELECT TmpFinal
2314:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2315:                     THIS.txt_4c_TotQtd.Value = loc_nSal
2316:                     THIS.txt_4c_TotEst.Value = loc_nEst
2317:                     THIS.txt_4c_TotPrz.Value = loc_nPrz
2318:                 ENDIF
2319:             ENDIF
2320:         CATCH TO loc_oErro
2321:             MsgErro(loc_oErro.Message, "Erro")
2322:         ENDTRY
2323:     ENDPROC
2324: 
2325:     *-- Cancelar.Click: fechar form sem processar
2326:     PROCEDURE CmdCancelarClick()
2327:         LOCAL loc_oErro
2328:         TRY
2329:             IF VARTYPE(THIS.this_oParentForm) = "O"
2330:                 THIS.this_oParentForm.Enabled = .T.
2331:             ENDIF
2332:         CATCH TO loc_oErro
2333:             MsgErro(loc_oErro.Message, "Erro")
2334:         ENDTRY
2335:         THIS.Release
2336:     ENDPROC
2337: 
2338:     *-- Container5 OK: confirmar selecao de estoque por conta/grupo
2339:     PROCEDURE CancelarC5Click()
2340:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2341:         TRY
2342:             THIS.this_oBusinessObject.ConfirmarDisponivelSimples()
2343:             IF USED("TmpFinal")
2344:                 SELECT TmpFinal
2345:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2346:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2347:                 THIS.txt_4c_TotEst.Value = loc_nEst
2348:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2349:             ENDIF
2350:         CATCH TO loc_oErro
2351:             MsgErro(loc_oErro.Message, "Erro")
2352:         ENDTRY
2353:         THIS.cmd_4c_Processar.Enabled    = .T.
2354:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2355:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2356:         THIS.cmd_4c_Estoques.Enabled     = .T.
2357:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2358:         THIS.cnt_4c_Info.Enabled         = .T.
2359:         THIS.cnt_4c_Estoques.Visible     = .F.
2360:         THIS.grd_4c_Itens.Enabled        = .T.
2361:         THIS.grd_4c_Itens.ZOrder(0)
2362:         THIS.grd_4c_Itens.Refresh
2363:         THIS.grd_4c_Itens.Column6.SetFocus
2364:     ENDPROC
2365: 
2366:     *-- Container2 Sair: confirmar selecao de disponivel por produto
2367:     PROCEDURE CancelarC2Click()
2368:         LOCAL loc_oErro
2369:         TRY
2370:             THIS.this_oBusinessObject.ConfirmarDisponivel()
2371:         CATCH TO loc_oErro
2372:             MsgErro(loc_oErro.Message, "Erro")
2373:         ENDTRY
2374:         THIS.cmd_4c_Processar.Enabled    = .T.
2375:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2376:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2377:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2378:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2379:         THIS.cnt_4c_Info.Enabled         = .T.
2380:         THIS.cnt_4c_Disponivel.Visible   = .F.
2381:         THIS.grd_4c_Itens.Enabled        = .T.
2382:         THIS.grd_4c_Itens.ZOrder(0)
2383:         THIS.grd_4c_Itens.Refresh
2384:         THIS.grd_4c_Itens.Column6.SetFocus
2385:     ENDPROC
2386: 
2387:     *-- Container4 Sair: fechar painel de requisicoes
2388:     PROCEDURE CancelarC4Click()
2389:         THIS.cmd_4c_Processar.Enabled    = .T.
2390:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2391:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2392:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2393:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2394:         THIS.cnt_4c_Info.Enabled         = .T.
2395:         THIS.cnt_4c_Requisicoes.Visible  = .F.
2396:         THIS.grd_4c_Itens.Enabled        = .T.
2397:         THIS.grd_4c_Itens.ZOrder(0)
2398:         THIS.grd_4c_Itens.Refresh
2399:         THIS.grd_4c_Itens.Column6.SetFocus
2400:     ENDPROC
2401: 
2402:     *-- Container1 OK: fechar painel de linhas
2403:     PROCEDURE CancelarC1Click()
2404:         THIS.cmd_4c_Processar.Enabled    = .T.
2405:         THIS.cmd_4c_Cancelar.Enabled     = .T.
2406:         THIS.cmd_4c_Requisicoes.Enabled  = .T.
2407:         THIS.cmd_4c_LinhasTot.Enabled    = .T.
2408:         THIS.cmd_4c_Disponiveis.Enabled  = .T.
2409:         THIS.cnt_4c_Linhas.Visible       = .F.
2410:         THIS.cnt_4c_Info.Enabled         = .T.
2411:         THIS.grd_4c_Itens.Enabled        = .T.
2412:         THIS.grd_4c_Itens.ZOrder(0)
2413:         THIS.grd_4c_Itens.Refresh
2414:         THIS.grd_4c_Itens.Column6.SetFocus
2415:     ENDPROC
2416: 
2417:     *-- GradePedra Column1.Text1 Valid: lookup produto
2418:     PROCEDURE GradePedra1Valid()
2419:         LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
2420:         loc_lResultado = .T.
2421:         TRY
2422:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value))
2423:             IF NOT EMPTY(loc_lcValor)
2424:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup") > 0
2425:                     IF NOT EOF("crProLookup")
2426:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = crProLookup.Cpros
2427:                         REPLACE SelPedra.Dpros WITH crProLookup.DPros, ;
2428:                                 SelPedra.Cunis WITH crProLookup.Cunis IN SelPedra
2429:                         USE IN crProLookup
2430:                     ELSE
2431:                         USE IN crProLookup
2432:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro") > 0
2433:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2434:                             IF VARTYPE(loc_oForm) = "O"
2435:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro"
2436:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2437:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2438:                                 loc_oForm.Show()
2439:                                 IF loc_oForm.this_lSelecionou
2440:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value = cursor_4c_BuscaPro.Cpros
2441:                                     REPLACE SelPedra.Dpros WITH cursor_4c_BuscaPro.DPros, ;
2442:                                             SelPedra.Cunis WITH cursor_4c_BuscaPro.Cunis IN SelPedra
2443:                                 ENDIF
2444:                             ENDIF
2445:                         ENDIF
2446:                         IF USED("cursor_4c_BuscaPro")
2447:                             USE IN cursor_4c_BuscaPro
2448:                         ENDIF
2449:                     ENDIF
2450:                 ENDIF
2451:                 THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2452:             ENDIF
2453:         CATCH TO loc_oErro
2454:             MsgErro(loc_oErro.Message, "Erro")
2455:             loc_lResultado = .F.
2456:         ENDTRY
2457:         RETURN loc_lResultado
2458:     ENDPROC
2459: 
2460:     *-- GradePedra Column5.Text1 When: salva valor anterior
2461:     PROCEDURE GradePedra5When()
2462:         THIS.this_oBusinessObject.this_nAntValue = THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value
2463:         RETURN NOT EMPTY(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column1.Text1.Value)
2464:     ENDPROC
2465: 
2466:     *-- GradePedra Column5.Text1 Valid: lookup produto substituto
2467:     PROCEDURE GradePedra5Valid()
2468:         LOCAL loc_lResultado, loc_lcValor, loc_oForm, loc_oErro
2469:         loc_lResultado = .T.
2470:         TRY
2471:             loc_lcValor = ALLTRIM(TRANSFORM(THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value))
2472:             IF NOT EMPTY(loc_lcValor)
2473:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + EscaparSQL(loc_lcValor), "crProLookup2") > 0
2474:                     IF NOT EOF("crProLookup2")
2475:                         THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = crProLookup2.Cpros
2476:                         USE IN crProLookup2
2477:                     ELSE
2478:                         USE IN crProLookup2
2479:                         IF SQLEXEC(gnConnHandle, "SELECT CPros, DPros FROM SigCdPro WHERE CPros LIKE " + EscaparSQL(loc_lcValor + "%"), "cursor_4c_BuscaPro2") > 0
2480:                             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar")
2481:                             IF VARTYPE(loc_oForm) = "O"
2482:                                 loc_oForm.this_cCursorDestino = "cursor_4c_BuscaPro2"
2483:                                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2484:                                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2485:                                 loc_oForm.Show()
2486:                                 IF loc_oForm.this_lSelecionou
2487:                                     THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Column5.Text1.Value = cursor_4c_BuscaPro2.Cpros
2488:                                 ENDIF
2489:                             ENDIF
2490:                         ENDIF
2491:                         IF USED("cursor_4c_BuscaPro2")
2492:                             USE IN cursor_4c_BuscaPro2
2493:                         ENDIF
2494:                     ENDIF
2495:                 ENDIF
2496:                 THIS.cnt_4c_Requisicoes.grd_4c_PedraReq.Refresh
2497:             ENDIF
2498:         CATCH TO loc_oErro
2499:             MsgErro(loc_oErro.Message, "Erro")
2500:             loc_lResultado = .F.
2501:         ENDTRY
2502:         RETURN loc_lResultado
2503:     ENDPROC
2504: 
2505:     *-- GradePedra Column5.Text1 KeyPress: avancar para proximo registro ao confirmar
2506:     PROCEDURE GradePedra5LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2507:         IF NOT INLIST(par_nKeyCode, 13, 9)
2508:             RETURN
2509:         ENDIF
2510:         LOCAL loc_xPos, loc_oErro
2511:         TRY
2512:             SELECT SelPedra
2513:             loc_xPos = RECNO()
2514:             LOCATE FOR EMPTY(Cpros)
2515:             IF EOF()
2516:                 APPEND BLANK
2517:             ENDIF
2518:             LOCATE FOR RECNO() = loc_xPos
2519:             KEYBOARD "{DNARROW}"
2520:         CATCH TO loc_oErro
2521:             MsgErro(loc_oErro.Message, "Erro")
2522:         ENDTRY
2523:     ENDPROC
2524: 
2525:     *-- img_4c_Figura DblClick: zoom da imagem
2526:     PROCEDURE ImgFiguraDblClick()
2527:         IF NOT EMPTY(THIS.img_4c_Figura.Picture)
2528:             MsgInfo(THIS.img_4c_Figura.Picture, "Zoom")
2529:         ENDIF
2530:     ENDPROC
2531: 
2532:     *==========================================================================
2533:     * ConfigurarPaginaLista - equivalente OPERACIONAL da Page1 Lista dos CRUD
2534:     *
2535:     * Este form eh OPERACIONAL flat (sem PageFrame): a "pagina lista" corresponde
2536:     * a visao principal com barra de botoes superior + grade de itens central.
2537:     * Este metodo compoe as tres pecas equivalentes ao Page1 de um CRUD:
2538:     *   1) Barra de botoes principais (equivalente ao cnt_4c_Botoes CRUD)
2539:     *   2) Grade principal (equivalente ao grd_4c_Lista CRUD)
2540:     *   3) Container de totais + observacoes (rodape informativo)
2541:     * Retorna o container de botoes principais como "ancora" da lista, para que
2542:     * chamadores possam referenciar a barra CRUD-like sem precisar mudar layout.
2543:     *==========================================================================
2544:     PROTECTED PROCEDURE ConfigurarPaginaLista()
2545:         LOCAL loc_lSucesso, loc_oErro
2546:         loc_lSucesso = .F.
2547:         TRY
2548:             *-- Barra de botoes principais (equivalente a cnt_4c_Botoes do CRUD)
2549:             IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2550:                 THIS.ConfigurarBotoesPrincipais()
2551:             ENDIF
2552:             *-- Grade principal (equivalente ao grid da Page1 do CRUD)
2553:             IF NOT PEMSTATUS(THIS, "grd_4c_Itens", 5)
2554:                 THIS.ConfigurarGradeItens()
2555:             ENDIF
2556:             *-- Rodape com totais e observacoes
2557:             IF NOT PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2558:                 THIS.ConfigurarTotais()
2559:             ENDIF
2560:             IF NOT PEMSTATUS(THIS, "edt_4c_Obs", 5)
2561:                 THIS.ConfigurarObsItens()
2562:             ENDIF
2563:             loc_lSucesso = .T.
2564:         CATCH TO loc_oErro
2565:             MsgErro("Erro ao configurar pagina lista: " + loc_oErro.Message + ;
2566:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2567:         ENDTRY
2568:         RETURN loc_lSucesso
2569:     ENDPROC
2570: 
2571:     *==========================================================================
2572:     * AlternarPagina - navegacao entre "paginas" logicas do form OPERACIONAL
2573:     *
2574:     * Este form nao tem PageFrame fisico. As "paginas" sao containers flutuantes
2575:     * (Visible=.F. por default) que sobrepoem a visao principal:
2576:     *   par_nPagina = 1 -> Lista principal (esconde todos os containers)
2577:     *   par_nPagina = 2 -> Container Disponivel (estoque por produto/cor/tam)
2578:     *   par_nPagina = 3 -> Container Estoques (disponivel detalhado por conta)
2579:     *   par_nPagina = 4 -> Container Linhas (total por linha de producao)
2580:     *   par_nPagina = 5 -> Container Requisicoes (componentes adicionais)
2581:     *   par_nPagina = 6 -> Container Info (rodape com totais)
2582:     * Retorna .T. em sucesso, .F. em caso de parametro invalido ou erro.
2583:     *==========================================================================
2584:     PROCEDURE AlternarPagina(par_nPagina)
2585:         LOCAL loc_lResultado, loc_oErro
2586:         loc_lResultado = .F.
2587:         TRY
2588:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 6
2589:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina), "Aviso")
2590:                 loc_lResultado = .F.
2591:             ENDIF
2592:             *-- Sempre esconder todos os containers flutuantes primeiro
2593:             IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
2594:                 THIS.cnt_4c_Disponivel.Visible  = .F.
2595:             ENDIF
2596:             IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
2597:                 THIS.cnt_4c_Estoques.Visible    = .F.
2598:             ENDIF
2599:             IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
2600:                 THIS.cnt_4c_Linhas.Visible      = .F.
2601:             ENDIF
2602:             IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
2603:                 THIS.cnt_4c_Requisicoes.Visible = .F.
2604:             ENDIF
2605:             DO CASE
2606:                 CASE par_nPagina = 1
2607:                     *-- Retorno a visao principal: reabilitar botoes e grade
2608:                     IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2609:                         THIS.cmd_4c_Processar.Enabled   = .T.
2610:                     ENDIF
2611:                     IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2612:                         THIS.cmd_4c_Cancelar.Enabled    = .T.
2613:                     ENDIF
2614:                     IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2615:                         THIS.cmd_4c_LinhasTot.Enabled   = .T.
2616:                     ENDIF
2617:                     IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2618:                         THIS.cmd_4c_Requisicoes.Enabled = .T.
2619:                     ENDIF
2620:                     IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2621:                         THIS.cmd_4c_Disponiveis.Enabled = .T.
2622:                     ENDIF
2623:                     IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2624:                         THIS.cmd_4c_Estoques.Enabled    = .T.
2625:                     ENDIF
2626:                     IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2627:                         THIS.cnt_4c_Info.Enabled        = .T.
2628:                     ENDIF
2629:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2630:                         THIS.grd_4c_Itens.Enabled       = .T.
2631:                         THIS.grd_4c_Itens.ZOrder(0)
2632:                         THIS.grd_4c_Itens.Refresh
2633:                     ENDIF
2634:                     THIS.AjustarBotaoPedras()
2635:                 CASE par_nPagina = 2
2636:                     THIS.CmdDisponiveisClick()
2637:                 CASE par_nPagina = 3
2638:                     THIS.CmdEstoquesClick()
2639:                 CASE par_nPagina = 4
2640:                     THIS.CmdLinhasTotClick()
2641:                 CASE par_nPagina = 5
2642:                     THIS.CmdRequisoesClick()
2643:                 CASE par_nPagina = 6
2644:                     IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2645:                         THIS.cnt_4c_Info.Visible = .T.
2646:                         THIS.cnt_4c_Info.ZOrder(0)
2647:                     ENDIF
2648:             ENDCASE
2649:             loc_lResultado = .T.
2650:         CATCH TO loc_oErro
2651:             MsgErro("Erro ao alternar p" + CHR(225) + "gina: " + loc_oErro.Message + ;
2652:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2653:         ENDTRY
2654:         RETURN loc_lResultado
2655:     ENDPROC
2656: 
2657:     *--------------------------------------------------------------------------
2658:     * BtnIncluirClick - Dispara a acao principal do formulario (Processar)
2659:     * Executa o processamento da Previa da Globalizacao, gerando OPs, movimentos
2660:     * de estoque, requisicoes de componentes e historicos derivados da grade.
2661:     *--------------------------------------------------------------------------
2662:     PROCEDURE BtnIncluirClick()
2663:         LOCAL loc_oErro
2664:         TRY
2665:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND !THIS.cmd_4c_Processar.Enabled
2666:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2667:                 loc_lResultado = .F.
2668:             ENDIF
2669:             THIS.CmdProcessarClick()
2670:         CATCH TO loc_oErro
2671:             MsgErro("Erro em BtnIncluirClick: " + loc_oErro.Message + ;
2672:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2673:         ENDTRY
2674:     ENDPROC
2675: 
2676:     *--------------------------------------------------------------------------
2677:     * BtnAlterarClick - Retorna a visao principal e devolve o foco a grade de itens
2678:     * Fecha containers flutuantes (Disponivel/Estoques/Linhas/Requisicoes) e
2679:     * reabilita a edicao da coluna Produzir para ajuste manual das quantidades.
2680:     *--------------------------------------------------------------------------
2681:     PROCEDURE BtnAlterarClick()
2682:         LOCAL loc_oErro
2683:         TRY
2684:             THIS.AlternarPagina(1)
2685:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2686:                 SELECT cursor_4c_ItensFinal
2687:                 GO TOP
2688:             ENDIF
2689:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2690:                 THIS.grd_4c_Itens.Refresh
2691:                 IF THIS.grd_4c_Itens.ColumnCount >= 6
2692:                     THIS.grd_4c_Itens.Column6.Text1.SetFocus
2693:                 ENDIF
2694:             ENDIF
2695:         CATCH TO loc_oErro
2696:             MsgErro("Erro em BtnAlterarClick: " + loc_oErro.Message + ;
2697:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2698:         ENDTRY
2699:     ENDPROC
2700: 
2701:     *--------------------------------------------------------------------------
2702:     * BtnVisualizarClick - Reexibe o painel de informacoes do item corrente
2703:     * Traz o container cnt_4c_Info para o topo e atualiza os totais / totais por
2704:     * linha da linha atualmente selecionada na grade principal.
2705:     *--------------------------------------------------------------------------
2706:     PROCEDURE BtnVisualizarClick()
2707:         LOCAL loc_oErro
2708:         TRY
2709:             THIS.AlternarPagina(6)
2710:             IF USED("cursor_4c_ItensFinal") AND RECCOUNT("cursor_4c_ItensFinal") > 0
2711:                 SELECT cursor_4c_ItensFinal
2712:                 THIS.GradeItensAfterRowColChange(1)
2713:             ENDIF
2714:         CATCH TO loc_oErro
2715:             MsgErro("Erro em BtnVisualizarClick: " + loc_oErro.Message + ;
2716:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2717:         ENDTRY
2718:     ENDPROC
2719: 
2720:     *--------------------------------------------------------------------------
2721:     * BtnExcluirClick - Cancela o processamento e encerra o formulario
2722:     * Faz rollback da transacao aberta pelo Init e libera o form pai.
2723:     * Equivalente a acao do botao Cancelar (Sair) da barra superior.
2724:     *--------------------------------------------------------------------------
2725:     PROCEDURE BtnExcluirClick()
2726:         LOCAL loc_oErro
2727:         TRY
2728:             IF !MsgConfirma("Deseja realmente cancelar o processamento e sair?", "Confirma" + CHR(231) + CHR(227) + "o")
2729:                 loc_lResultado = .F.
2730:             ENDIF
2731:             THIS.CmdCancelarClick()
2732:         CATCH TO loc_oErro
2733:             MsgErro("Erro em BtnExcluirClick: " + loc_oErro.Message + ;
2734:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2735:         ENDTRY
2736:     ENDPROC
2737: 
2738: 
2739:     *==========================================================================
2740:     * BtnBuscarClick - Retorna a visao principal (fecha paineis flutuantes)
2741:     *==========================================================================
2742:     PROCEDURE BtnBuscarClick()
2743:         LOCAL loc_oErro
2744:         TRY
2745:             THIS.AlternarPagina(1)
2746:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5) AND THIS.grd_4c_Itens.Visible
2747:                 THIS.grd_4c_Itens.Refresh
2748:             ENDIF
2749:         CATCH TO loc_oErro
2750:             MsgErro("Erro em BtnBuscarClick: " + loc_oErro.Message + ;
2751:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2752:         ENDTRY
2753:     ENDPROC
2754: 
2755:     *==========================================================================
2756:     * BtnEncerrarClick - Encerra o formulario
2757:     *==========================================================================
2758:     PROCEDURE BtnEncerrarClick()
2759:         THIS.CmdCancelarClick()
2760:     ENDPROC
2761: 
2762:     *==========================================================================
2763:     * BtnSalvarClick - Executa o processamento (equivalente ao Processar)
2764:     *==========================================================================
2765:     PROCEDURE BtnSalvarClick()
2766:         LOCAL loc_oErro
2767:         TRY
2768:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5) AND NOT THIS.cmd_4c_Processar.Enabled
2769:                 MsgAviso("Processamento indispon" + CHR(237) + "vel no momento.", "Aviso")
2770:                 loc_lResultado = .F.
2771:             ENDIF
2772:             THIS.CmdProcessarClick()
2773:         CATCH TO loc_oErro
2774:             MsgErro("Erro em BtnSalvarClick: " + loc_oErro.Message + ;
2775:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2776:         ENDTRY
2777:     ENDPROC
2778: 
2779:     *==========================================================================
2780:     * BtnCancelarClick - Cancela e encerra o formulario
2781:     *==========================================================================
2782:     PROCEDURE BtnCancelarClick()
2783:         THIS.CmdCancelarClick()
2784:     ENDPROC
2785: 
2786:     *==========================================================================
2787:     * FormParaBO - Transferencia dos campos do form para o BO
2788:     * Para form OPERACIONAL, os dados fluem diretamente dos cursors compartilhados
2789:     * (TmpFinal, TmpSaldo, TmpSaldG, SelPedra). Este metodo atualiza apenas
2790:     * as propriedades de controle do BO.
2791:     *==========================================================================
2792:     PROTECTED PROCEDURE FormParaBO()
2793:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
2794:             RETURN .F.
2795:         ENDIF
2796:         WITH THIS.this_oBusinessObject
2797:             .this_lReserva    = THIS.this_lReserva
2798:             .this_lAutomatico = THIS.this_lAutomatico
2799:             .this_nNumerodaop = THIS.this_nNumerodaop
2800:         ENDWITH
2801:         RETURN .T.
2802:     ENDPROC
2803: 
2804:     *==========================================================================
2805:     * BOParaForm - Transferencia do BO para os campos do form
2806:     * Para form OPERACIONAL, os grids sao alimentados diretamente via
2807:     * RecordSource nos cursors compartilhados. Este metodo atualiza os
2808:     * totalizadores e labels exibidos na barra de informacoes.
2809:     *==========================================================================
2810:     PROTECTED PROCEDURE BOParaForm()
2811:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2812:         TRY
2813:             loc_nSal = 0
2814:             loc_nEst = 0
2815:             loc_nPrz = 0
2816:             IF USED("TmpFinal")
2817:                 SELECT TmpFinal
2818:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2819:                 GO TOP
2820:             ENDIF
2821:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2822:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2823:                 THIS.txt_4c_TotEst.Value = loc_nEst
2824:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2825:             ENDIF
2826:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2827:                 THIS.grd_4c_Itens.Refresh
2828:             ENDIF
2829:             IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2830:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2831:             ENDIF
2832:         CATCH TO loc_oErro
2833:             MsgErro("Erro em BOParaForm: " + loc_oErro.Message + ;
2834:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2835:         ENDTRY
2836:     ENDPROC
2837: 
2838:     *==========================================================================
2839:     * HabilitarCampos - Habilita/desabilita controles conforme o modo
2840:     * Para form OPERACIONAL, o controle de habilitacao e feito por operacao
2841:     * especifica (CmdDisponiveis, CmdEstoques, etc.). Este metodo gerencia o
2842:     * estado da barra principal de botoes conforme this_cModoAtual.
2843:     *==========================================================================
2844:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2845:         LOCAL loc_lHab
2846:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2847:         IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2848:             THIS.grd_4c_Itens.Enabled      = loc_lHab
2849:         ENDIF
2850:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
2851:             THIS.cmd_4c_Processar.Enabled  = loc_lHab
2852:         ENDIF
2853:         IF PEMSTATUS(THIS, "cmd_4c_LinhasTot", 5)
2854:             THIS.cmd_4c_LinhasTot.Enabled  = loc_lHab
2855:         ENDIF
2856:         IF PEMSTATUS(THIS, "cmd_4c_Disponiveis", 5)
2857:             THIS.cmd_4c_Disponiveis.Enabled = loc_lHab
2858:         ENDIF
2859:         IF PEMSTATUS(THIS, "cmd_4c_Estoques", 5)
2860:             THIS.cmd_4c_Estoques.Enabled   = loc_lHab
2861:         ENDIF
2862:         IF loc_lHab
2863:             THIS.AjustarBotaoPedras()
2864:         ELSE
2865:             IF PEMSTATUS(THIS, "cmd_4c_Requisicoes", 5)
2866:                 THIS.cmd_4c_Requisicoes.Enabled = .F.
2867:             ENDIF
2868:         ENDIF
2869:     ENDPROC
2870: 
2871:     *==========================================================================
2872:     * LimparCampos - Limpa campos editaveis do form
2873:     * Para form OPERACIONAL, os cursors compartilhados sao zerados via ZAP
2874:     * no BO. O form apenas reseta os totalizadores e labels locais.
2875:     *==========================================================================
2876:     PROTECTED PROCEDURE LimparCampos()
2877:         IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2878:             THIS.txt_4c_TotQtd.Value = 0
2879:             THIS.txt_4c_TotEst.Value = 0
2880:             THIS.txt_4c_TotPrz.Value = 0
2881:         ENDIF
2882:         IF PEMSTATUS(THIS, "lbl_4c_ObsItens", 5)
2883:             THIS.lbl_4c_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2884:         ENDIF
2885:         IF PEMSTATUS(THIS, "edt_4c_Obs", 5)
2886:             THIS.edt_4c_Obs.ControlSource = ""
2887:         ENDIF
2888:         IF PEMSTATUS(THIS, "img_4c_Figura", 5)
2889:             THIS.img_4c_Figura.Picture = ""
2890:             THIS.img_4c_Figura.Visible = .F.
2891:         ENDIF
2892:         IF PEMSTATUS(THIS, "cnt_4c_Info", 5)
2893:             THIS.cnt_4c_Info.txt_4c_TotQtdInfo.Value = 0
2894:             THIS.cnt_4c_Info.txt_4c_TotEstInfo.Value = 0
2895:             THIS.cnt_4c_Info.txt_4c_TotPrzInfo.Value = 0
2896:             THIS.cnt_4c_Info.txt_4c_DGrupoInfo.Value = ""
2897:             THIS.cnt_4c_Info.txt_4c_DContaInfo.Value = ""
2898:         ENDIF
2899:     ENDPROC
2900: 
2901:     *==========================================================================
2902:     * CarregarLista - Recarrega a grade principal a partir dos cursors
2903:     * Para form OPERACIONAL, nao executa SQL proprio: releia os cursors
2904:     * compartilhados (TmpFinal, TmpSaldG) passados pelo form pai.
2905:     *==========================================================================
2906:     PROCEDURE CarregarLista()
2907:         LOCAL loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2908:         loc_nSal = 0
2909:         loc_nEst = 0
2910:         loc_nPrz = 0
2911:         TRY
2912:             IF USED("TmpFinal")
2913:                 SELECT TmpFinal
2914:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2915:                 GO TOP
2916:             ENDIF
2917:             IF PEMSTATUS(THIS, "txt_4c_TotQtd", 5)
2918:                 THIS.txt_4c_TotQtd.Value = loc_nSal
2919:                 THIS.txt_4c_TotEst.Value = loc_nEst
2920:                 THIS.txt_4c_TotPrz.Value = loc_nPrz
2921:             ENDIF
2922:             IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
2923:                 THIS.grd_4c_Itens.Refresh
2924:             ENDIF
2925:             IF USED("TmpSaldG") AND PEMSTATUS(THIS, "cnt_4c_Info", 5)
2926:                 THIS.cnt_4c_Info.grd_4c_DispInfo.Refresh
2927:             ENDIF
2928:         CATCH TO loc_oErro
2929:             MsgErro("Erro ao recarregar lista: " + loc_oErro.Message + ;
2930:                 " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
2931:         ENDTRY
2932:         RETURN .T.
2933:     ENDPROC
2934: 
2935:     *==========================================================================
2936:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme modo atual
2937:     * Para form OPERACIONAL, o "modo" e determinado pelo estado dos containers
2938:     * flutuantes (algum visivel = modo sub-painel; nenhum = modo principal).
2939:     *==========================================================================
2940:     PROCEDURE AjustarBotoesPorModo()
2941:         LOCAL loc_lModoPrincipal
2942:         loc_lModoPrincipal = .T.
2943:         IF PEMSTATUS(THIS, "cnt_4c_Disponivel", 5)
2944:             IF THIS.cnt_4c_Disponivel.Visible
2945:                 loc_lModoPrincipal = .F.
2946:             ENDIF
2947:         ENDIF
2948:         IF PEMSTATUS(THIS, "cnt_4c_Estoques", 5)
2949:             IF THIS.cnt_4c_Estoques.Visible
2950:                 loc_lModoPrincipal = .F.
2951:             ENDIF
2952:         ENDIF
2953:         IF PEMSTATUS(THIS, "cnt_4c_Linhas", 5)
2954:             IF THIS.cnt_4c_Linhas.Visible
2955:                 loc_lModoPrincipal = .F.
2956:             ENDIF
2957:         ENDIF
2958:         IF PEMSTATUS(THIS, "cnt_4c_Requisicoes", 5)
2959:             IF THIS.cnt_4c_Requisicoes.Visible
2960:                 loc_lModoPrincipal = .F.
2961:             ENDIF
2962:         ENDIF
2963:         THIS.HabilitarCampos(loc_lModoPrincipal)
2964:         IF loc_lModoPrincipal
2965:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2966:                 THIS.cmd_4c_Cancelar.Enabled = .T.
2967:             ENDIF
2968:             IF PEMSTATUS(THIS, "cmd_4c_Relatorio", 5)
2969:                 THIS.cmd_4c_Relatorio.Enabled = .T.
2970:             ENDIF
2971:         ELSE
2972:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
2973:                 THIS.cmd_4c_Cancelar.Enabled = .F.
2974:             ENDIF
2975:         ENDIF
2976:     ENDPROC
2977: 
2978: ENDDEFINE

