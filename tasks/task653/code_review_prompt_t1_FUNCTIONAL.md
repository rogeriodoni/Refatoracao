# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [METODO-INEXISTENTE] Metodo 'THIS.ExtrairDescricaoTamanhoFolha()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarTamanhoFolhaComFonte()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCBL): Top original=142 vs migrado 'lbl_4c_Label15' Top=271 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGOPCBL): Left original=109 vs migrado 'lbl_4c_Label15' Left=232 (diff=123px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGOPCBL): Top original=156 vs migrado 'txt_4c_Text19' Top=286 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGOPCBL): Left original=109 vs migrado 'txt_4c_Text19' Left=342 (diff=233px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGOPCBL): Top original=158 vs migrado 'lbl_4c_Label20' Top=287 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGOPCBL): Left original=151 vs migrado 'lbl_4c_Label20' Left=494 (diff=343px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGOPCBL): Top original=142 vs migrado 'lbl_4c_Label33' Top=404 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGOPCBL): Left original=235 vs migrado 'lbl_4c_Label33' Left=122 (diff=113px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGOPCBL): Top original=156 vs migrado 'txt_4c_Text31' Top=418 (diff=262px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGOPCBL): Left original=235 vs migrado 'txt_4c_Text31' Left=323 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGOPCBL): Top original=156 vs migrado 'txt_4c_Text40' Top=481 (diff=325px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGOPCBL): Left original=284 vs migrado 'txt_4c_Text40' Left=124 (diff=160px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCbl.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2052 linhas total):

*-- Linhas 35 a 162:
35:     this_lEmDialogo = .F.
36: 
37:     *--------------------------------------------------------------------------
38:     * Init - FormBase.Init() ja chama THIS.InicializarForm() via DODEFAULT().
39:     * Regra CLAUDE.md "Problema 8": nunca chamar InicializarForm() de novo aqui.
40:     *--------------------------------------------------------------------------
41:     PROCEDURE Init()
42:         RETURN DODEFAULT()
43:     ENDPROC
44: 
45:     *--------------------------------------------------------------------------
46:     * InicializarForm - Cria o Business Object, carrega o registro UNICO de
47:     * SigCnFBl (regra CLAUDE.md OPERACIONAL: tabela de configuracao unica) e
48:     * monta a estrutura visual (cabecalho + botoes Confirmar/Encerrar).
49:     *
50:     * Equivalente ao Init legado: ".AddCursor('SigCnFBl', ... lcQryCfgBl)" +
51:     * ".poDataMgr.ReQuery(...)" + "Go Top" + "If Eof() / Append Blank / EndIf"
52:     * -> aqui replicado por SigOpCblBO.CarregarRegistroUnico(), que carrega o
53:     * registro existente (modo ALTERAR) ou prepara um novo quando a tabela
54:     * esta vazia (modo INCLUIR), sem nunca deixar o form sem registro
55:     * corrente. THIS.BOParaForm() espelha o registro carregado nos campos ja
56:     * ligados (FASE 5/8: primeira metade - Text1..Text16/Text40); a segunda
57:     * metade entra na fase seguinte do pipeline.
58:     *--------------------------------------------------------------------------
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lSucesso, loc_oErro
61:         loc_lSucesso = .F.
62: 
63:         TRY
64:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCblBO")
65: 
66:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
67:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
68:                 THIS.ConfigurarPageFrame()
69: 
70:                 *-- Guard gb_4c_ValidandoUI/gb_4c_ModoTeste (padrao FormSigOpAlC):
71:                 *-- em validacao de UI ou teste headless nao ha gnConnHandle real,
72:                 *-- e SQLEXEC com handle invalido dispara EXCECAO (nao apenas
73:                 *-- devolve erro) - pular a carga preserva a instanciacao do form
74:                 *-- para o harness inspecionar os controles. Sem conexao, o
75:                 *-- BOParaForm sozinho ja espelha os defaults das properties do
76:                 *-- BO (equivalente ao registro em branco do Append Blank legado).
77:                 IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
78:                         (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste)
79:                     THIS.CarregarLista()
80:                 ELSE
81:                     THIS.BOParaForm()
82:                 ENDIF
83: 
84:                 THIS.TornarControlesVisiveis(THIS)
85:                 loc_lSucesso = .T.
86:             ELSE
87:                 MsgErro("Erro ao criar SigOpCblBO. VARTYPE retornou: " + ;
88:                         VARTYPE(THIS.this_oBusinessObject), "Erro")
89:             ENDIF
90:         CATCH TO loc_oErro
91:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
92:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
93:             loc_lSucesso = .F.
94:         ENDTRY
95: 
96:         RETURN loc_lSucesso
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * ConfigurarPageFrame - Entry point de layout. Este form OPERACIONAL nao
101:     * usa PageFrame (tela unica de parametrizacao, igual ao SIGOPCBL.SCX
102:     * original): cabecalho + area de campos + grupo Confirmar/Encerrar.
103:     *--------------------------------------------------------------------------
104:     PROTECTED PROCEDURE ConfigurarPageFrame()
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *--------------------------------------------------------------------------
110:     * ConfigurarPaginaLista - Monta o cabecalho (cntSombra do SCX original) e
111:     * reserva a area do grupo de botoes Confirmar/Encerrar (os botoes em si
112:     * sao adicionados na fase de botoes do pipeline).
113:     *--------------------------------------------------------------------------
114:     PROTECTED PROCEDURE ConfigurarPaginaLista()
115:         THIS.ConfigurarCabecalho()
116:         THIS.ConfigurarBotoes()
117:     ENDPROC
118: 
119:     *--------------------------------------------------------------------------
120:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra do SCX)
121:     *--------------------------------------------------------------------------
122:     PROTECTED PROCEDURE ConfigurarCabecalho()
123:         LOCAL loc_oCab
124: 
125:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
126:         WITH THIS.cnt_4c_Cabecalho
127:             .Top         = 0
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackStyle   = 1
132:             .BackColor   = RGB(100, 100, 100)
133:             .BorderWidth = 0
134:             .Visible     = .T.
135:         ENDWITH
136:         loc_oCab = THIS.cnt_4c_Cabecalho
137: 
138:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oCab.lbl_4c_Sombra
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = loc_oCab.Width - 20
143:             .Height    = 40
144:             .AutoSize  = .F.
145:             .WordWrap  = .T.
146:             .Alignment = 0
147:             .BackStyle = 0
148:             .FontBold  = .T.
149:             .FontName  = "Tahoma"
150:             .FontSize  = 18
151:             .ForeColor = RGB(0, 0, 0)
152:             .Caption   = THIS.Caption
153:         ENDWITH
154: 
155:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
156:         WITH loc_oCab.lbl_4c_Titulo
157:             .Top       = 17
158:             .Left      = 10
159:             .Width     = loc_oCab.Width - 20
160:             .Height    = 46
161:             .AutoSize  = .F.
162:             .WordWrap  = .T.

*-- Linhas 180 a 223:
180:     * [[feedback_standalone_commandbutton_themes]] - sem isso o icone nao
181:     * renderiza em runtime).
182:     *--------------------------------------------------------------------------
183:     PROTECTED PROCEDURE ConfigurarBotoes()
184:         THIS.AddObject("cnt_4c_Botoes", "Container")
185:         WITH THIS.cnt_4c_Botoes
186:             .Top         = -2
187:             .Left        = 643
188:             .Width       = 160
189:             .Height      = 85
190:             .BackStyle   = 0
191:             .BorderWidth = 0
192:             .Visible     = .T.
193:         ENDWITH
194: 
195:         *-- Command1 (cmdOk) do cmdGsalva legado - "Confirma a Configuracao do Boleto?"
196:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
197:         WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
198:             .Top             = 5
199:             .Left            = 5
200:             .Width           = 75
201:             .Height          = 75
202:             .Caption         = "Confirmar"
203:             .ToolTipText     = "Confirmar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
205:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
206:             .FontName        = "Comic Sans MS"
207:             .FontBold        = .T.
208:             .FontItalic      = .T.
209:             .FontSize        = 8
210:             .ForeColor       = RGB(90, 90, 90)
211:             .BackColor       = RGB(255, 255, 255)
212:             .Themes          = .T.
213:             .SpecialEffect   = 0
214:             .PicturePosition = 13
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .Visible         = .T.
218:         ENDWITH
219: 
220:         *-- Command2 (cmdCancelar) do cmdGsalva legado - "Deseja Abandonar as Alteracoes Realizadas?"
221:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
222:         WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
223:             .Top             = 5

*-- Linhas 243 a 316:
243:             .Visible         = .T.
244:         ENDWITH
245: 
246:         *-- BINDEVENT exige metodo PUBLIC (regra CLAUDE.md #3) - BtnConfirmarClick
247:         *-- e BtnEncerrarClick estao declarados mais abaixo nesta mesma classe.
248:         *-- BtnEncerrarClick delega para BtnCancelarClick, que guarda o corpo
249:         *-- do Click legado: o objeto do SCX chama-se cmdCancelar mas tem
250:         *-- Caption "Encerrar" (PILAR 1 - a legenda eh a do legado).
251:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
252:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
253:     ENDPROC
254: 
255:     *--------------------------------------------------------------------------
256:     * ConfigurarPaginaDados - Campos de posicionamento de impressao do boleto
257:     * (linha x coluna de cada bloco), transcritos do SIGOPCBL.SCX direto no
258:     * Form (layout FLAT - tela unica, sem PageFrame/paginas).
259:     *
260:     * Secoes: Cabecalho, Local de Pagamento, Vencimento, Data Documento,
261:     * Numero do Documento, Valor do Documento, Texto de Responsabilidade do
262:     * Cedente (posicao + Numero de Linhas/Colunas), Sacado (Razao Social,
263:     * C.G.C./C.P.F., Endereco, Bairro, Cidade, U.F., C.E.P.), Impressora/
264:     * Fonte (Nome da Impressora, Fonte Padrao + Tamanho) e Folha (Text40,
265:     * fwget no legado). Analise.json confirma lookups=[] para este form -
266:     * nao ha FormBuscaAuxiliar: os unicos campos com validacao em tempo de
267:     * UI sao Text29/Text30/Text40 (impressora/fonte/papel), tratados com
268:     * BINDEVENT "LostFocus" apos o AddObject de cada um.
269:     *
270:     * Os campos de posicao (nlnXxx/nclXxx) sao numeric(5,2) no schema -
271:     * InputMask "999.99"; Numero de Linhas/Colunas (ntxtlins/ntxtcols) sao
272:     * numeric(3,0) - InputMask "999". Labels sem Width/Alignment no dump do
273:     * legado (classe say) usam Alignment=0 (regra CLAUDE.md #23); os que o
274:     * SCX declara com Width usam a largura exata do dump.
275:     *--------------------------------------------------------------------------
276:     PROTECTED PROCEDURE ConfigurarPaginaDados()
277:         *-- Secao "Cabecalho"
278:         THIS.AddObject("lbl_4c_Label27", "Label")
279:         WITH THIS.lbl_4c_Label27
280:             .Top       = 119
281:             .Left      = 122
282:             .Width     = 60
283:             .Height    = 15
284:             .Alignment = 0
285:             .BackStyle = 0
286:             .FontBold  = .T.
287:             .FontName  = "Tahoma"
288:             .FontSize  = 8
289:             .ForeColor = RGB(90, 90, 90)
290:             .Caption   = "Cabe" + CHR(231) + "alho"
291:             .Visible   = .T.
292:         ENDWITH
293: 
294:         THIS.AddObject("shp_4c_Shape1", "Shape")
295:         WITH THIS.shp_4c_Shape1
296:             .Top        = 135
297:             .Left       = 109
298:             .Width      = 570
299:             .Height     = 2
300:             .BackStyle  = 1
301:             .BackColor  = RGB(192, 192, 192)
302:             .BorderStyle = 0
303:             .Visible    = .T.
304:         ENDWITH
305: 
306:         *-- Local de Pagamento (nlnlocals x ncllocals)
307:         THIS.AddObject("lbl_4c_Label1", "Label")
308:         WITH THIS.lbl_4c_Label1
309:             .Top       = 142
310:             .Left      = 109
311:             .Width     = 98
312:             .Height    = 15
313:             .Alignment = 0
314:             .BackStyle = 0
315:             .FontName  = "Tahoma"
316:             .FontSize  = 8

*-- Linhas 904 a 925:
904:             .ForeColor = RGB(90, 90, 90)
905:             .Caption   = "Endere" + CHR(231) + "o"
906:             .Visible   = .T.
907:         ENDWITH
908: 
909:         THIS.AddObject("txt_4c_Text19", "TextBox")
910:         WITH THIS.txt_4c_Text19
911:             .Top       = 286
912:             .Left      = 342
913:             .Width     = 41
914:             .Height    = 18
915:             .Value     = 0
916:             .InputMask = "999.99"
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .Visible   = .T.
920:             .Format    = "K"
921:         ENDWITH
922: 
923:         THIS.AddObject("lbl_4c_Label18", "Label")
924:         WITH THIS.lbl_4c_Label18
925:             .Top       = 287

*-- Linhas 1258 a 1332:
1258:             .Visible   = .T.
1259:             .Format    = "K"
1260:         ENDWITH
1261:         BINDEVENT(THIS.txt_4c_Text29, "LostFocus", THIS, "Text29LostFocus")
1262: 
1263:         *-- Fonte Padrao (cfontepdrs) - validada em Text30LostFocus
1264:         THIS.AddObject("lbl_4c_Label33", "Label")
1265:         WITH THIS.lbl_4c_Label33
1266:             .Top       = 404
1267:             .Left      = 122
1268:             .Width     = 67
1269:             .Height    = 15
1270:             .Alignment = 0
1271:             .BackStyle = 0
1272:             .FontName  = "Tahoma"
1273:             .FontSize  = 8
1274:             .ForeColor = RGB(90, 90, 90)
1275:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1276:             .Visible   = .T.
1277:         ENDWITH
1278: 
1279:         THIS.AddObject("txt_4c_Text30", "TextBox")
1280:         WITH THIS.txt_4c_Text30
1281:             .Top       = 418
1282:             .Left      = 122
1283:             .Width     = 192
1284:             .Height    = 18
1285:             .Value     = ""
1286:             .MaxLength = 128
1287:             .FontName  = "Tahoma"
1288:             .FontSize  = 8
1289:             .Visible   = .T.
1290:             .Format    = "K"
1291:         ENDWITH
1292:         BINDEVENT(THIS.txt_4c_Text30, "LostFocus", THIS, "Text30LostFocus")
1293: 
1294:         *-- Tamanho da fonte (ntamfontes) - atualizado automaticamente por Text30LostFocus
1295:         THIS.AddObject("lbl_4c_Label34", "Label")
1296:         WITH THIS.lbl_4c_Label34
1297:             .Top       = 404
1298:             .Left      = 323
1299:             .Width     = 46
1300:             .Height    = 15
1301:             .Alignment = 0
1302:             .BackStyle = 0
1303:             .FontName  = "Tahoma"
1304:             .FontSize  = 8
1305:             .ForeColor = RGB(90, 90, 90)
1306:             .Caption   = "Tamanho"
1307:             .Visible   = .T.
1308:         ENDWITH
1309: 
1310:         THIS.AddObject("txt_4c_Text31", "TextBox")
1311:         WITH THIS.txt_4c_Text31
1312:             .Top       = 418
1313:             .Left      = 323
1314:             .Width     = 41
1315:             .Height    = 18
1316:             .Value     = 0
1317:             .InputMask = "999"
1318:             .FontName  = "Tahoma"
1319:             .FontSize  = 8
1320:             .Visible   = .T.
1321:             .Format    = "K"
1322:         ENDWITH
1323: 
1324:         *-- Secao "Folha" - Tamanho da Folha (ctamfolha, fwget no legado)
1325:         THIS.AddObject("lbl_4c_Label39", "Label")
1326:         WITH THIS.lbl_4c_Label39
1327:             .Top       = 446
1328:             .Left      = 126
1329:             .Width     = 32
1330:             .Height    = 15
1331:             .Alignment = 0
1332:             .BackStyle = 0

*-- Linhas 1363 a 1549:
1363:             .ForeColor = RGB(90, 90, 90)
1364:             .Caption   = "Tamanho Folha"
1365:             .Visible   = .T.
1366:         ENDWITH
1367: 
1368:         THIS.AddObject("txt_4c_Text40", "TextBox")
1369:         WITH THIS.txt_4c_Text40
1370:             .Top       = 481
1371:             .Left      = 124
1372:             .Width     = 244
1373:             .Height    = 19
1374:             .Value     = ""
1375:             .MaxLength = 50
1376:             .FontName  = "Tahoma"
1377:             .FontSize  = 8
1378:             .Visible   = .T.
1379:             .Format    = "K"
1380:         ENDWITH
1381:         BINDEVENT(THIS.txt_4c_Text40, "LostFocus", THIS, "Text40LostFocus")
1382:     ENDPROC
1383: 
1384:     *--------------------------------------------------------------------------
1385:     * CarregarLista - carga de dados da tela. Este form OPERACIONAL nao tem
1386:     * grade nem pagina de Lista: a "lista" dele eh o registro UNICO de
1387:     * SigCnFBl (uma configuracao de boleto por instalacao), por isso o metodo
1388:     * canonico de carga do projeto aqui recarrega esse registro e espelha nos
1389:     * campos.
1390:     *
1391:     * Equivalente ao bloco de carga do Init legado:
1392:     *
1393:     *   .AddCursor('SigCnFBl', 'cIdChaves', 'crSigCnFBl', '', '', lcQryCfgBl)
1394:     *   .poDataMgr.ReQuery('crSigCnFBl')
1395:     *   Select crSigCnFBl / Go Top
1396:     *   If Eof() / Append Blank / EndIf
1397:     *   ... ThisForm.Text40.value = <descricao de ctamfolha> ...
1398:     *   ThisForm.Refresh
1399:     *   ThisForm.Text1.SetFocus
1400:     *
1401:     * SigOpCblBO.CarregarRegistroUnico() cobre o AddCursor/ReQuery/Go Top e o
1402:     * "Append Blank" (tabela vazia -> NovoRegistro(), com os defaults das
1403:     * properties, que eh o equivalente do registro em branco do cursor legado);
1404:     * THIS.BOParaForm() cobre o espelhamento dos campos, inclusive o Text40
1405:     * (ExtrairDescricaoTamanhoFolha). PUBLIC de proposito: o harness
1406:     * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
1407:     * e PROTECTED falharia em runtime (regra CLAUDE.md #3).
1408:     *--------------------------------------------------------------------------
1409:     PROCEDURE CarregarLista()
1410:         LOCAL loc_lSucesso, loc_oErro
1411: 
1412:         loc_lSucesso = .F.
1413: 
1414:         TRY
1415:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1416:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarRegistroUnico()
1417: 
1418:                 *-- Mesmo quando a carga falha (erro de SQL - a propria
1419:                 *-- CarregarRegistroUnico ja exibiu a mensagem), espelhar o BO
1420:                 *-- mantem a tela coerente com o estado dele em vez de deixar
1421:                 *-- os campos com valor de outra carga.
1422:                 THIS.BOParaForm()
1423:                 THIS.Refresh()
1424: 
1425:                 *-- "ThisForm.Text1.SetFocus" do Init legado. So com a tela JA
1426:                 *-- visivel: chamado de dentro do Init (form ainda nao exibido)
1427:                 *-- SetFocus estoura. O guard por THIS.Visible evita o CATCH
1428:                 *-- vazio que a regra CLAUDE.md #9 proibe - e na primeira carga
1429:                 *-- nada se perde, porque o TabIndex = 1 do Text1 ja lhe da o
1430:                 *-- foco inicial quando o form abre.
1431:                 IF THIS.Visible
1432:                     THIS.txt_4c_Text1.SetFocus()
1433:                 ENDIF
1434:             ENDIF
1435:         CATCH TO loc_oErro
1436:             MsgErro(loc_oErro.Message + CHR(13) + ;
1437:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1438:                 "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
1439:             loc_lSucesso = .F.
1440:         ENDTRY
1441: 
1442:         RETURN loc_lSucesso
1443:     ENDPROC
1444: 
1445:     *--------------------------------------------------------------------------
1446:     * BOParaForm - transfere TODOS os campos do Business Object para os
1447:     * controles da tela. Chamado em InicializarForm() apos ConfigurarPageFrame().
1448:     *--------------------------------------------------------------------------
1449:     PROTECTED PROCEDURE BOParaForm()
1450:         LOCAL loc_oBO
1451:         loc_oBO = THIS.this_oBusinessObject
1452: 
1453:         IF VARTYPE(loc_oBO) != "O"
1454:             RETURN
1455:         ENDIF
1456: 
1457:         THIS.txt_4c_Text1.Value  = loc_oBO.this_nNlnlocals
1458:         THIS.txt_4c_Text2.Value  = loc_oBO.this_nNcllocals
1459:         THIS.txt_4c_Text3.Value  = loc_oBO.this_nNlndtvencs
1460:         THIS.txt_4c_Text4.Value  = loc_oBO.this_nNcldtvencs
1461:         THIS.txt_4c_Text5.Value  = loc_oBO.this_nNlndtdocs
1462:         THIS.txt_4c_Text6.Value  = loc_oBO.this_nNcldtdocs
1463:         THIS.txt_4c_Text7.Value  = loc_oBO.this_nNlnnrdocs
1464:         THIS.txt_4c_Text8.Value  = loc_oBO.this_nNclnrdocs
1465:         THIS.txt_4c_Text9.Value  = loc_oBO.this_nNlnvldocs
1466:         THIS.txt_4c_Text10.Value = loc_oBO.this_nNclvldocs
1467:         THIS.txt_4c_Text11.Value = loc_oBO.this_nNlntxtcds
1468:         THIS.txt_4c_Text12.Value = loc_oBO.this_nNcltxtcds
1469:         THIS.txt_4c_Text13.Value = loc_oBO.this_nNtxtcols
1470:         THIS.txt_4c_Text14.Value = loc_oBO.this_nNtxtlins
1471:         THIS.txt_4c_Text15.Value = loc_oBO.this_nNlnrazclis
1472:         THIS.txt_4c_Text16.Value = loc_oBO.this_nNclrazclis
1473:         THIS.txt_4c_Text17.Value = loc_oBO.this_nNlncgcclis
1474:         THIS.txt_4c_Text18.Value = loc_oBO.this_nNclcgcclis
1475:         THIS.txt_4c_Text19.Value = loc_oBO.this_nNlnendcobs
1476:         THIS.txt_4c_Text20.Value = loc_oBO.this_nNclendcobs
1477:         THIS.txt_4c_Text21.Value = loc_oBO.this_nNlnbaicobs
1478:         THIS.txt_4c_Text22.Value = loc_oBO.this_nNclbaicobs
1479:         THIS.txt_4c_Text23.Value = loc_oBO.this_nNlncidcobs
1480:         THIS.txt_4c_Text24.Value = loc_oBO.this_nNclcidcobs
1481:         THIS.txt_4c_Text25.Value = loc_oBO.this_nNlnestcobs
1482:         THIS.txt_4c_Text26.Value = loc_oBO.this_nNclestcobs
1483:         THIS.txt_4c_Text27.Value = loc_oBO.this_nNlncepcobs
1484:         THIS.txt_4c_Text28.Value = loc_oBO.this_nNclcepcobs
1485:         THIS.txt_4c_Text29.Value = loc_oBO.this_cNomeimps
1486:         THIS.txt_4c_Text30.Value = loc_oBO.this_cFontepdrs
1487:         THIS.txt_4c_Text31.Value = loc_oBO.this_nTamfontes
1488:         THIS.txt_4c_Text40.Value = THIS.ExtrairDescricaoTamanhoFolha(loc_oBO.this_cTamfolha)
1489:     ENDPROC
1490: 
1491:     *--------------------------------------------------------------------------
1492:     * FormParaBO - transfere TODOS os campos dos controles da tela para o
1493:     * Business Object. Chamado em BtnConfirmarClick() antes de Salvar().
1494:     *--------------------------------------------------------------------------
1495:     PROTECTED PROCEDURE FormParaBO()
1496:         LOCAL loc_oBO
1497:         loc_oBO = THIS.this_oBusinessObject
1498: 
1499:         IF VARTYPE(loc_oBO) != "O"
1500:             RETURN
1501:         ENDIF
1502: 
1503:         loc_oBO.this_nNlnlocals  = THIS.txt_4c_Text1.Value
1504:         loc_oBO.this_nNcllocals  = THIS.txt_4c_Text2.Value
1505:         loc_oBO.this_nNlndtvencs = THIS.txt_4c_Text3.Value
1506:         loc_oBO.this_nNcldtvencs = THIS.txt_4c_Text4.Value
1507:         loc_oBO.this_nNlndtdocs  = THIS.txt_4c_Text5.Value
1508:         loc_oBO.this_nNcldtdocs  = THIS.txt_4c_Text6.Value
1509:         loc_oBO.this_nNlnnrdocs  = THIS.txt_4c_Text7.Value
1510:         loc_oBO.this_nNclnrdocs  = THIS.txt_4c_Text8.Value
1511:         loc_oBO.this_nNlnvldocs  = THIS.txt_4c_Text9.Value
1512:         loc_oBO.this_nNclvldocs  = THIS.txt_4c_Text10.Value
1513:         loc_oBO.this_nNlntxtcds  = THIS.txt_4c_Text11.Value
1514:         loc_oBO.this_nNcltxtcds  = THIS.txt_4c_Text12.Value
1515:         loc_oBO.this_nNtxtcols   = THIS.txt_4c_Text13.Value
1516:         loc_oBO.this_nNtxtlins   = THIS.txt_4c_Text14.Value
1517:         loc_oBO.this_nNlnrazclis = THIS.txt_4c_Text15.Value
1518:         loc_oBO.this_nNclrazclis = THIS.txt_4c_Text16.Value
1519:         loc_oBO.this_nNlncgcclis = THIS.txt_4c_Text17.Value
1520:         loc_oBO.this_nNclcgcclis = THIS.txt_4c_Text18.Value
1521:         loc_oBO.this_nNlnendcobs = THIS.txt_4c_Text19.Value
1522:         loc_oBO.this_nNclendcobs = THIS.txt_4c_Text20.Value
1523:         loc_oBO.this_nNlnbaicobs = THIS.txt_4c_Text21.Value
1524:         loc_oBO.this_nNclbaicobs = THIS.txt_4c_Text22.Value
1525:         loc_oBO.this_nNlncidcobs = THIS.txt_4c_Text23.Value
1526:         loc_oBO.this_nNclcidcobs = THIS.txt_4c_Text24.Value
1527:         loc_oBO.this_nNlnestcobs = THIS.txt_4c_Text25.Value
1528:         loc_oBO.this_nNclestcobs = THIS.txt_4c_Text26.Value
1529:         loc_oBO.this_nNlncepcobs = THIS.txt_4c_Text27.Value
1530:         loc_oBO.this_nNclcepcobs = THIS.txt_4c_Text28.Value
1531:         loc_oBO.this_cNomeimps   = ALLTRIM(THIS.txt_4c_Text29.Value)
1532:         loc_oBO.this_cFontepdrs  = ALLTRIM(THIS.txt_4c_Text30.Value)
1533:         loc_oBO.this_nTamfontes  = THIS.txt_4c_Text31.Value
1534:         *-- this_cTamfolha NAO vem de txt_4c_Text40.Value: o TextBox so exibe a
1535:         *-- DESCRICAO (3o segmento de "Fonte/Codigo/Descricao" - ver
1536:         *-- ExtrairDescricaoTamanhoFolha). O valor completo eh mantido por
1537:         *-- Text40LostFocus (GetPaperSize) e remontado em
1538:         *-- MontarTamanhoFolhaComFonte, chamado por BtnConfirmarClick.
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * ExtrairDescricaoTamanhoFolha - equivalente ao bloco do Init legado que
1543:     * calcula ThisForm.Text40.value a partir de crSigCnFBl.ctamfolha, que
1544:     * guarda o composto "Fonte/Codigo/Descricao" (3 segmentos separados por
1545:     * "/"). Devolve so a Descricao (3o segmento); "" quando o composto nao
1546:     * tem os 3 segmentos (registro novo ou ainda no formato cru do
1547:     * GetPaperSize(), sem nenhum "/").
1548:     *--------------------------------------------------------------------------
1549:     PROTECTED FUNCTION ExtrairDescricaoTamanhoFolha(par_cTamFolha)

*-- Linhas 1640 a 2052:
1640:     * array" em RUNTIME (o .prg compila limpo). O legado escapava porque usava
1641:     * "Declare laPrinters[1]".
1642:     *--------------------------------------------------------------------------
1643:     PROCEDURE Text29LostFocus()
1644:         IF THIS.this_lEmDialogo
1645:             RETURN
1646:         ENDIF
1647: 
1648:         THIS.this_lEmDialogo = .T.
1649:         THIS.Text29LostFocusExec()
1650:         THIS.this_lEmDialogo = .F.
1651:     ENDPROC
1652: 
1653:     *--------------------------------------------------------------------------
1654:     * Text29LostFocusExec - corpo do handler acima. Separado para que a guarda
1655:     * de reentrancia seja liberada mesmo quando o corpo sai por RETURN
1656:     * antecipado ou por CATCH (regra CLAUDE.md #47 - flag presa ligada MATA o
1657:     * campo pelo resto da vida do form).
1658:     *--------------------------------------------------------------------------
1659:     PROCEDURE Text29LostFocusExec()
1660:         LOCAL ARRAY loc_aPrinters[1]
1661:         LOCAL loc_cNome, loc_nQtd, loc_nI, loc_lNaoTem, loc_cImpressora, loc_oErro
1662: 
1663:         TRY
1664:             loc_cNome = ALLTRIM(THIS.txt_4c_Text29.Value)
1665:             loc_nQtd  = APRINTERS(loc_aPrinters)
1666: 
1667:             IF loc_nQtd > 0
1668:                 loc_lNaoTem = .T.
1669: 
1670:                 FOR loc_nI = 1 TO ALEN(loc_aPrinters, 1)
1671:                     IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(loc_cNome)
1672:                         loc_lNaoTem = .F.
1673:                         EXIT
1674:                     ENDIF
1675:                 ENDFOR
1676: 
1677:                 IF loc_lNaoTem
1678:                     *-- Impressora invalida/vazia: seletor de impressoras do
1679:                     *-- Windows. GETPRINTER() devolve "" quando o usuario
1680:                     *-- cancela - nesse caso o campo fica como estava.
1681:                     loc_cImpressora = GETPRINTER()
1682:                     IF !EMPTY(loc_cImpressora)
1683:                         THIS.txt_4c_Text29.Value = loc_cImpressora
1684:                     ENDIF
1685:                 ENDIF
1686:             ELSE
1687:                 MsgAviso("Nenhuma Impressora Instalada.", "Aten" + CHR(231) + CHR(227) + "o")
1688:                 THIS.txt_4c_Text29.Value = ""
1689:             ENDIF
1690: 
1691:             THIS.txt_4c_Text29.Refresh()
1692:         CATCH TO loc_oErro
1693:             MsgErro(loc_oErro.Message + CHR(13) + ;
1694:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1695:                 "Procedure: " + loc_oErro.Procedure, "Erro em Text29LostFocus")
1696:         ENDTRY
1697:     ENDPROC
1698: 
1699:     *--------------------------------------------------------------------------
1700:     * Text30LostFocus - valida a fonte padrao ao sair do campo e atualiza o
1701:     * tamanho em Text31. Transcricao do Valid legado de Text30:
1702:     *
1703:     *   ThisForm.LockScreen = .t.
1704:     *   Declare laFonts[1]
1705:     *   = Afont(m.laFonts)
1706:     *   m.llNtem = .t.
1707:     *   For ... If Upper(AllTrim(laFonts[i]))==Upper(AllTrim(This.Value))
1708:     *               m.llNtem = .f. ... EndIf ... EndFor
1709:     *   If m.llNtem
1710:     *       m.lcFonte    = GetFont()
1711:     *       m.lnPos1     = At(",",m.lcFonte,1)
1712:     *       m.lnPos2     = At(",",m.lcFonte,2)
1713:     *       m.nTamFontes = Val(SubStr(m.lcFonte,(m.lnPos1+1),(m.lnPos2-1)))
1714:     *       m.cFontePdrs = Left(m.lcFonte,(m.lnPos1-1))
1715:     *       Select crSigCnFBl
1716:     *       Gather Memvar Fields cFontePdrs,nTamFontes
1717:     *       This.Refresh / ThisForm.Text31.Refresh
1718:     *   EndIf
1719:     *   ThisForm.LockScreen = .f.
1720:     *
1721:     * O "Gather Memvar Fields cFontePdrs,nTamFontes" do legado grava os dois
1722:     * campos no registro corrente; aqui o equivalente eh escrever nos dois
1723:     * controles (Text30/Text31), que o FormParaBO leva ao BO na gravacao.
1724:     *
1725:     * DOIS detalhes medidos no VFP9 em 2026-10-17, ambos defeito no codigo que
1726:     * vinha das fases anteriores:
1727:     *   1. AFONT() devolve LOGICO (.T./.F.), NAO contagem - "IF <logico> > 0"
1728:     *      estoura erro 107 "Operator/operand type mismatch" em RUNTIME. A
1729:     *      contagem vem de ALEN(array, 1), exatamente como o legado faz.
1730:     *   2. AFONT exige destino LOCAL ARRAY (erro 232 com LOCAL simples).
1731:     *--------------------------------------------------------------------------
1732:     PROCEDURE Text30LostFocus()
1733:         IF THIS.this_lEmDialogo
1734:             RETURN
1735:         ENDIF
1736: 
1737:         THIS.this_lEmDialogo = .T.
1738:         THIS.Text30LostFocusExec()
1739:         THIS.this_lEmDialogo = .F.
1740:     ENDPROC
1741: 
1742:     *--------------------------------------------------------------------------
1743:     * Text30LostFocusExec - corpo do handler acima (ver Text29LostFocusExec
1744:     * para o motivo da separacao). O LockScreen eh reposto em TODOS os
1745:     * caminhos, inclusive depois do CATCH: deixa-lo ligado congela a tela.
1746:     *--------------------------------------------------------------------------
1747:     PROCEDURE Text30LostFocusExec()
1748:         LOCAL ARRAY loc_aFontes[1]
1749:         LOCAL loc_cFonte, loc_nI, loc_lNaoTem, loc_cResultado
1750:         LOCAL loc_nPos1, loc_nPos2, loc_nTam, loc_oErro
1751: 
1752:         TRY
1753:             THIS.LockScreen = .T.
1754: 
1755:             loc_cFonte = ALLTRIM(THIS.txt_4c_Text30.Value)
1756:             = AFONT(loc_aFontes)
1757:             loc_lNaoTem = .T.
1758: 
1759:             FOR loc_nI = 1 TO ALEN(loc_aFontes, 1)
1760:                 IF UPPER(ALLTRIM(loc_aFontes[loc_nI])) == UPPER(loc_cFonte)
1761:                     loc_lNaoTem = .F.
1762:                     EXIT
1763:                 ENDIF
1764:             ENDFOR
1765: 
1766:             IF loc_lNaoTem
1767:                 *-- Fonte invalida/vazia: seletor de fontes do Windows.
1768:                 *-- GETFONT() devolve "Nome,Tamanho,Estilo" (ou "" se cancelar).
1769:                 loc_cResultado = GETFONT()
1770: 
1771:                 IF !EMPTY(loc_cResultado)
1772:                     loc_nPos1 = AT(",", loc_cResultado, 1)
1773:                     loc_nPos2 = AT(",", loc_cResultado, 2)
1774: 
1775:                     IF loc_nPos1 > 0
1776:                         THIS.txt_4c_Text30.Value = LEFT(loc_cResultado, loc_nPos1 - 1)
1777: 
1778:                         IF loc_nPos2 > loc_nPos1
1779:                             loc_nTam = VAL(SUBSTR(loc_cResultado, loc_nPos1 + 1, ;
1780:                                 loc_nPos2 - loc_nPos1 - 1))
1781:                             THIS.txt_4c_Text31.Value = loc_nTam
1782:                         ENDIF
1783: 
1784:                         THIS.txt_4c_Text30.Refresh()
1785:                         THIS.txt_4c_Text31.Refresh()
1786:                     ENDIF
1787:                 ENDIF
1788:             ENDIF
1789:         CATCH TO loc_oErro
1790:             MsgErro(loc_oErro.Message + CHR(13) + ;
1791:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1792:                 "Procedure: " + loc_oErro.Procedure, "Erro em Text30LostFocus")
1793:         ENDTRY
1794: 
1795:         THIS.LockScreen = .F.
1796:     ENDPROC
1797: 
1798:     *--------------------------------------------------------------------------
1799:     * Text40LostFocus - tamanho de folha. Transcricao do Valid legado de
1800:     * Text40 (classe fwget):
1801:     *
1802:     *   m.lcTamFolha = ""
1803:     *   If IsEmpty(This.Value)
1804:     *       m.lcTamFolha = GetPaperSize()
1805:     *       If IsEmpty(m.lcTamFolha)
1806:     *           m.lcTamFolha = (Str(256,10)+"Personalizado")
1807:     *       EndIf
1808:     *       This.Value = SubStr(m.lcTamFolha,11)
1809:     *   EndIf
1810:     *   If (Not Eof("crSigCnFBl")) And (Not IsEmpty(m.lcTamFolha))
1811:     *       Replace ctamfolha With m.lcTamFolha In crSigCnFBl
1812:     *   EndIf
1813:     *
1814:     * lcTamFolha so eh preenchido DENTRO do If, entao o Replace acontece
1815:     * apenas quando o campo estava vazio - comportamento reproduzido aqui.
1816:     * GetPaperSize() devolve codigo(10 chars) + descricao SEM separador: o
1817:     * TextBox exibe so a descricao (SUBSTR a partir de 11) e o composto CRU
1818:     * inteiro vai para this_cTamfolha (equivalente ao Replace no cursor);
1819:     * MontarTamanhoFolhaComFonte, chamado no Confirmar, eh quem acrescenta a
1820:     * Fonte e os separadores na gravacao final.
1821:     *
1822:     * O fallback STR(256,10)+"Personalizado" (256 = DMPAPER_USER) eh
1823:     * OBRIGATORIO e faltava: sem ele, impressora sem papel reportado deixa o
1824:     * campo vazio para sempre e o dialogo reabre a cada saida do campo.
1825:     * Medido no VFP9: SUBSTR(STR(256,10)+"Personalizado", 11) = "Personalizado".
1826:     *
1827:     * GetPaperSize() NAO eh funcao nativa do VFP9 nem veio no acervo legado -
1828:     * foi definida como wrapper de contrato em utils\functions.prg (regra
1829:     * CLAUDE.md #13/#27); sem ela a chamada estoura "File
1830:     * getpapersize.prg does not exist" em RUNTIME.
1831:     *--------------------------------------------------------------------------
1832:     PROCEDURE Text40LostFocus()
1833:         IF THIS.this_lEmDialogo
1834:             RETURN
1835:         ENDIF
1836: 
1837:         THIS.this_lEmDialogo = .T.
1838:         THIS.Text40LostFocusExec()
1839:         THIS.this_lEmDialogo = .F.
1840:     ENDPROC
1841: 
1842:     *--------------------------------------------------------------------------
1843:     * Text40LostFocusExec - corpo do handler acima (ver Text29LostFocusExec
1844:     * para o motivo da separacao).
1845:     *--------------------------------------------------------------------------
1846:     PROCEDURE Text40LostFocusExec()
1847:         LOCAL loc_cTam, loc_oErro
1848: 
1849:         TRY
1850:             IF EMPTY(ALLTRIM(THIS.txt_4c_Text40.Value))
1851:                 loc_cTam = GetPaperSize()
1852: 
1853:                 IF EMPTY(loc_cTam)
1854:                     loc_cTam = STR(256, 10) + "Personalizado"
1855:                 ENDIF
1856: 
1857:                 THIS.txt_4c_Text40.Value = SUBSTR(loc_cTam, 11)
1858: 
1859:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1860:                     THIS.this_oBusinessObject.this_cTamfolha = loc_cTam
1861:                 ENDIF
1862: 
1863:                 THIS.txt_4c_Text40.Refresh()
1864:             ENDIF
1865:         CATCH TO loc_oErro
1866:             MsgErro(loc_oErro.Message + CHR(13) + ;
1867:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1868:                 "Procedure: " + loc_oErro.Procedure, "Erro em Text40LostFocus")
1869:         ENDTRY
1870:     ENDPROC
1871: 
1872:     *--------------------------------------------------------------------------
1873:     * BtnConfirmarClick - equivalente ao cmdOk.Click (Command1) do legado:
1874:     *
1875:     *   ThisForm.LockScreen = .t.
1876:     *   If MessageBox("Confirma a Configuracao do Boleto?",32+4,...)==6
1877:     *       ... remonta m.ctamfolha (Fonte+Codigo+Descricao)
1878:     *       ... Gather dDatas,cHoras,cUsuarios,ctamfolha / Update / Commit
1879:     *       ... Update SigCqMat Set ctamanho=<ctamfolha> (quando ha registro)
1880:     *       ThisForm.Release
1881:     *   Else
1882:     *       ThisForm.Text1.SetFocus
1883:     *   EndIf
1884:     *   ThisForm.LockScreen = .f.
1885:     *
1886:     * THIS.FormParaBO() ja transfere TODOS os campos do boleto
1887:     * (Text1..Text31); this_cTamfolha eh remontado aqui com
1888:     * MontarTamanhoFolhaComFonte (regra CLAUDE.md #17 - formula do legado
1889:     * transcrita literalmente, nunca reescrita) antes de Salvar().
1890:     *
1891:     * Cada falha do legado faz "Return 0" SEM Release - a tela fica aberta com
1892:     * os dados na mao do usuario. Reproduzido aqui: Release() so acontece
1893:     * quando Salvar() E SincronizarTamanhoFolhaSigCqMat() tiverem sucesso.
1894:     *
1895:     * FALHA NUNCA EH MUDA (regra CLAUDE.md #20): BusinessBase.Salvar() ja
1896:     * chama ExibirFalha()/MsgErro() em todo caminho de recusa - por isso nao
1897:     * ha ELSE no IF Salvar(). SincronizarTamanhoFolhaSigCqMat ja exibe a
1898:     * mensagem do legado ("Favor Reinicializar o Processo!!!") quando falha.
1899:     *--------------------------------------------------------------------------
1900:     PROCEDURE BtnConfirmarClick()
1901:         LOCAL loc_oErro, loc_lSucesso, loc_cTamFolha, loc_lLiberou
1902: 
1903:         loc_lLiberou = .F.
1904: 
1905:         TRY
1906:             THIS.LockScreen = .T.
1907: 
1908:             IF MsgConfirma("Confirma a Configura" + CHR(231) + CHR(227) + "o do Boleto?", ;
1909:                     "Confirma" + CHR(231) + CHR(227) + "o")
1910: 
1911:                 THIS.FormParaBO()
1912: 
1913:                 loc_cTamFolha = THIS.MontarTamanhoFolhaComFonte(THIS.txt_4c_Text30.Value, ;
1914:                     THIS.this_oBusinessObject.this_cTamfolha)
1915:                 THIS.this_oBusinessObject.this_cTamfolha = loc_cTamFolha
1916: 
1917:                 loc_lSucesso = THIS.this_oBusinessObject.Salvar()
1918: 
1919:                 IF loc_lSucesso
1920:                     loc_lSucesso = THIS.this_oBusinessObject.SincronizarTamanhoFolhaSigCqMat(loc_cTamFolha)
1921:                 ENDIF
1922: 
1923:                 IF loc_lSucesso
1924:                     *-- LockScreen reposto ANTES do Release: depois dele nao se
1925:                     *-- toca mais no form (loc_lLiberou impede o reset final).
1926:                     THIS.LockScreen = .F.
1927:                     loc_lLiberou = .T.
1928:                     THIS.Release()
1929:                 ENDIF
1930:             ELSE
1931:                 THIS.txt_4c_Text1.SetFocus()
1932:             ENDIF
1933:         CATCH TO loc_oErro
1934:             MsgErro(loc_oErro.Message + CHR(13) + ;
1935:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1936:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
1937:         ENDTRY
1938: 
1939:         *-- Reposto em TODO caminho que NAO liberou o form (recusa na
1940:         *-- confirmacao, falha na gravacao, CATCH): LockScreen ligado congela
1941:         *-- a tela. No caminho do Release o reset ja aconteceu antes dele.
1942:         IF !loc_lLiberou
1943:             THIS.LockScreen = .F.
1944:         ENDIF
1945:     ENDPROC
1946: 
1947:     *--------------------------------------------------------------------------
1948:     * BtnCancelarClick - equivalente ao cmdCancelar.Click (Command2) do legado:
1949:     *
1950:     *   ThisForm.LockScreen = .t.
1951:     *   If Messagebox("Deseja Abandonar as Alteracoes Realizadas?",4+32+256,...)==6
1952:     *       ThisForm.Release
1953:     *   EndIf
1954:     *
1955:     * Unico caminho de saida da tela (form OPERACIONAL flat, sem Page2/Dados
1956:     * para "cancelar a edicao" - abandonar aqui EH fechar). O nome segue o
1957:     * objeto do legado, cmdCancelar; o CommandButton que o dispara chama-se
1958:     * cmd_4c_Encerrar porque "Encerrar" eh a Caption que o SCX declara em
1959:     * Command2 (regra PILAR 1 - a legenda eh a do legado).
1960:     *
1961:     * Recusar a confirmacao mantem a tela aberta, igual ao legado (nao ha
1962:     * ELSE no If dele).
1963:     *--------------------------------------------------------------------------
1964:     PROCEDURE BtnCancelarClick()
1965:         THIS.LockScreen = .T.
1966: 
1967:         IF MsgConfirma("Deseja Abandonar as Altera" + CHR(231) + CHR(245) + "es Realizadas?", ;
1968:                 "Confirma" + CHR(231) + CHR(227) + "o")
1969:             THIS.LockScreen = .F.
1970:             THIS.Release()
1971:         ELSE
1972:             THIS.LockScreen = .F.
1973:         ENDIF
1974:     ENDPROC
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * BtnEncerrarClick - o MESMO botao, pelo outro nome que ele tem.
1978:     *
1979:     * O objeto do SCX legado tem duas identidades: Name = "cmdCancelar" (de
1980:     * onde sai BtnCancelarClick, que guarda o corpo transcrito do Click) e
1981:     * Caption = "Encerrar" (de onde sai o nome do controle migrado,
1982:     * cmd_4c_Encerrar, e este metodo). Nao ha dois comportamentos: esta tela
1983:     * eh FLAT, sem Page2/modo de edicao, entao "abandonar as alteracoes" e
1984:     * "encerrar" sao a mesma acao - por isso aqui se DELEGA em vez de
1985:     * duplicar a logica (dois corpos iguais divergiriam na primeira mudanca).
1986:     *
1987:     * Os dois nomes existem porque as duas convencoes do projeto apontam para
1988:     * identidades diferentes do mesmo objeto: 88 dos 112 forms OPERACIONAIS
1989:     * declaram os dois, e o harness TesteAutomatico.prg procura justamente por
1990:     * BtnEncerrarClick/BtnFecharClick/BtnSairClick.
1991:     *--------------------------------------------------------------------------
1992:     PROCEDURE BtnEncerrarClick()
1993:         THIS.BtnCancelarClick()
1994:     ENDPROC
1995: 
1996:     *--------------------------------------------------------------------------
1997:     * TornarControlesVisiveis - Torna todos os controles visiveis apos
1998:     * AddObject (que os cria com Visible=.F. por padrao). Percorre Pages de
1999:     * PageFrame e Controls de Container recursivamente.
2000:     *--------------------------------------------------------------------------
2001:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2002:         LOCAL loc_i, loc_oControl, loc_p
2003: 
2004:         FOR loc_i = 1 TO par_oContainer.ControlCount
2005:             loc_oControl = par_oContainer.Controls(loc_i)
2006: 
2007:             IF VARTYPE(loc_oControl) = "O"
2008:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2009:                     loc_oControl.Visible = .T.
2010:                 ENDIF
2011: 
2012:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
2013:                     FOR loc_p = 1 TO loc_oControl.PageCount
2014:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
2015:                     ENDFOR
2016:                 ENDIF
2017: 
2018:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
2019:                     IF loc_oControl.ControlCount > 0
2020:                         THIS.TornarControlesVisiveis(loc_oControl)
2021:                     ENDIF
2022:                 ENDIF
2023:             ENDIF
2024:         ENDFOR
2025:     ENDPROC
2026: 
2027:     *--------------------------------------------------------------------------
2028:     * Destroy - DODEFAULT() libera this_oBusinessObject e restaura o menu
2029:     * principal (FormBase.Destroy). Regra CLAUDE.md #145: DODEFAULT() sempre
2030:     * como ultima linha do override.
2031:     *
2032:     * Equivalente ao "PROCEDURE Release" do legado
2033:     * ("ThisForm.poDataMgr.Release" + "=DoDefault()"): o poDataMgr era o
2034:     * gerenciador de conexao/cursores do Framework Fortyus, substituido pela
2035:     * dupla BO + DataAccess - quem libera o BO eh FormBase.Destroy, via o
2036:     * DODEFAULT() abaixo. Os cursores desta tela (cursor_4c_Dados,
2037:     * cursor_4c_SigCqMat) sao fechados pelo proprio SigOpCblBO no fim de cada
2038:     * metodo que os abre, por isso nao ha USE IN aqui.
2039:     *
2040:     * O "PROCEDURE Load" do legado ("=fConfigGeral()") NAO tem equivalente
2041:     * neste form de proposito: fConfigGeral era a inicializacao global da
2042:     * aplicacao legado, que na arquitetura nova acontece ANTES, em
2043:     * start\config.prg (SETs, paths, variaveis globais) e start\main.prg
2044:     * (conexao, empresa). O utils\fconfiggeral.prg existe APENAS como wrapper
2045:     * para o p-code dos VCX legado e o proprio arquivo documenta que codigo
2046:     * NOSSO nunca deve chama-lo (regra CLAUDE.md #27).
2047:     *--------------------------------------------------------------------------
2048:     PROCEDURE Destroy()
2049:         DODEFAULT()
2050:     ENDPROC
2051: 
2052: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCblBO.prg):
*====================================================================
* SIGOPCBLBO.prg
*
* Business Object para Configuracao de Boletos Bancarios
* Tabela: SigCnFBl (registro unico de configuracao de impressao)
* Herda de: BusinessBase
* Form legado: SIGOPCBL.SCX
*====================================================================

DEFINE CLASS SigOpCblBO AS BusinessBase

	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica)

	*-- Identificacao / auditoria do registro
	this_cEmps       = ""   && cemps char(3) - empresa
	this_dDatas      = {}   && ddatas datetime - data da configuracao
	this_cHoras      = ""   && choras char(8) - hora da configuracao
	this_cUsuarios   = ""   && cusuarios char(20) - usuario que configurou
	this_cFpags      = ""   && fpags char(12) - forma de pagamento

	*-- Texto de responsabilidade do cedente e local de pagamento
	this_cTxtcds     = ""   && ctxtcds text - texto de responsabilidade do cedente
	this_cLocals     = ""   && clocals char(100) - texto do local de pagamento
	this_nNtxtlins   = 0    && ntxtlins numeric(3,0) - numero de linhas do texto do cedente
	this_nNtxtcols   = 0    && ntxtcols numeric(3,0) - numero de colunas do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Local de Pagamento
	this_nNlnlocals  = 0    && nlnlocals numeric(5,2) - linha de impressao do local de pagamento
	this_nNcllocals  = 0    && ncllocals numeric(5,2) - coluna de impressao do local de pagamento

	*-- Posicao de impressao (linha/coluna) - Vencimento
	this_nNlndtvencs = 0    && nlndtvencs numeric(5,2) - linha de impressao do vencimento
	this_nNcldtvencs = 0    && ncldtvencs numeric(5,2) - coluna de impressao do vencimento

	*-- Posicao de impressao (linha/coluna) - Data do Documento
	this_nNlndtdocs  = 0    && nlndtdocs numeric(5,2) - linha de impressao da data do documento
	this_nNcldtdocs  = 0    && ncldtdocs numeric(5,2) - coluna de impressao da data do documento

	*-- Posicao de impressao (linha/coluna) - Numero do Documento
	this_nNlnnrdocs  = 0    && nlnnrdocs numeric(5,2) - linha de impressao do numero do documento
	this_nNclnrdocs  = 0    && nclnrdocs numeric(5,2) - coluna de impressao do numero do documento

	*-- Posicao de impressao (linha/coluna) - Valor do Documento
	this_nNlnvldocs  = 0    && nlnvldocs numeric(5,2) - linha de impressao do valor do documento
	this_nNclvldocs  = 0    && nclvldocs numeric(5,2) - coluna de impressao do valor do documento

	*-- Posicao de impressao (linha/coluna) - Texto do Cedente
	this_nNlntxtcds  = 0    && nlntxtcds numeric(5,2) - linha de impressao do texto do cedente
	this_nNcltxtcds  = 0    && ncltxtcds numeric(5,2) - coluna de impressao do texto do cedente

	*-- Posicao de impressao (linha/coluna) - Sacado: Razao Social
	this_nNlnrazclis = 0    && nlnrazclis numeric(5,2) - linha de impressao da razao social
	this_nNclrazclis = 0    && nclrazclis numeric(5,2) - coluna de impressao da razao social

	*-- Posicao de impressao (linha/coluna) - Sacado: C.G.C./C.P.F.
	this_nNlncgcclis = 0    && nlncgcclis numeric(5,2) - linha de impressao do CGC/CPF
	this_nNclcgcclis = 0    && nclcgcclis numeric(5,2) - coluna de impressao do CGC/CPF

	*-- Posicao de impressao (linha/coluna) - Sacado: Endereco
	this_nNlnendcobs = 0    && nlnendcobs numeric(5,2) - linha de impressao do endereco
	this_nNclendcobs = 0    && nclendcobs numeric(5,2) - coluna de impressao do endereco

	*-- Posicao de impressao (linha/coluna) - Sacado: Bairro
	this_nNlnbaicobs = 0    && nlnbaicobs numeric(5,2) - linha de impressao do bairro
	this_nNclbaicobs = 0    && nclbaicobs numeric(5,2) - coluna de impressao do bairro

	*-- Posicao de impressao (linha/coluna) - Sacado: Cidade
	this_nNlncidcobs = 0    && nlncidcobs numeric(5,2) - linha de impressao da cidade
	this_nNclcidcobs = 0    && nclcidcobs numeric(5,2) - coluna de impressao da cidade

	*-- Posicao de impressao (linha/coluna) - Sacado: U.F.
	this_nNlnestcobs = 0    && nlnestcobs numeric(5,2) - linha de impressao da UF
	this_nNclestcobs = 0    && nclestcobs numeric(5,2) - coluna de impressao da UF

	*-- Posicao de impressao (linha/coluna) - Sacado: C.E.P.
	this_nNlncepcobs = 0    && nlncepcobs numeric(5,2) - linha de impressao do CEP
	this_nNclcepcobs = 0    && nclcepcobs numeric(5,2) - coluna de impressao do CEP

	*-- Impressora / Fonte padrao
	this_cNomeimps   = ""   && cnomeimps char(128) - nome da impressora padrao
	this_cFontepdrs  = ""   && cfontepdrs char(128) - fonte padrao de impressao
	this_nTamfontes  = 0    && ntamfontes numeric(3,0) - tamanho da fonte padrao

	*-- Tamanho da folha (driver/codigo/descricao concatenados)
	this_cTamfolha   = ""   && ctamfolha char(50) - tamanho de folha configurado na impressora

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCnFBl"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - cidchaves eh a PK real de SigCnFBl (constraint
	* sigcnfbl_cidchaves em docs\schema.sql), usada pelo RegistrarAuditoria
	* herdado da BusinessBase.
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
	ENDPROC

	*====================================================================
	* CarregarRegistroUnico - Replica o Init legado: "Select * From SigCnFBl"
	* + "Go Top" + "If Eof() / Append Blank / EndIf". SigCnFBl eh tabela de
	* configuracao UNICA (um boleto por empresa) - se ja existe o registro,
	* carrega e entra em modo EDICAO; se a tabela estiver vazia (1a execucao
	* no ambiente), entra em modo INCLUSAO com os defaults da classe (equivalente
	* ao Append Blank do legado, que cria a linha em branco no cursor).
	*====================================================================
	PROCEDURE CarregarRegistroUnico()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_cSQL = "SELECT * FROM SigCnFBl"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Dados") > 0
					SELECT cursor_4c_Dados
					GO TOP
					THIS.CarregarDoCursor("cursor_4c_Dados")
					THIS.EditarRegistro()
				ELSE
					THIS.NovoRegistro()
				ENDIF
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao carregar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia as 40 colunas de SigCnFBl (par_cAliasCursor)
	* para as properties do BO.
	*
	* Regra CLAUDE.md #8: SELECT (par_cAliasCursor) antes de acessar campos.
	* [[feedback_tratarnulo_2o_arg_eh_valor_padrao]]: o 2o argumento de
	* TratarNulo() eh o VALOR PADRAO do tipo da coluna, nunca um codigo de
	* tipo - "" para char, 0 para numeric, {} para date/datetime.
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)

				THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
				THIS.this_cEmps       = TratarNulo(cemps, "")
				THIS.this_dDatas      = TratarNulo(ddatas, {})
				THIS.this_cHoras      = TratarNulo(choras, "")
				THIS.this_cUsuarios   = TratarNulo(cusuarios, "")
				THIS.this_cFpags      = TratarNulo(fpags, "")

				THIS.this_cTxtcds     = TratarNulo(ctxtcds, "")
				THIS.this_cLocals     = TratarNulo(clocals, "")
				THIS.this_nNtxtlins   = TratarNulo(ntxtlins, 0)
				THIS.this_nNtxtcols   = TratarNulo(ntxtcols, 0)

				THIS.this_nNlnlocals  = TratarNulo(nlnlocals, 0)
				THIS.this_nNcllocals  = TratarNulo(ncllocals, 0)

				THIS.this_nNlndtvencs = TratarNulo(nlndtvencs, 0)
				THIS.this_nNcldtvencs = TratarNulo(ncldtvencs, 0)

				THIS.this_nNlndtdocs  = TratarNulo(nlndtdocs, 0)
				THIS.this_nNcldtdocs  = TratarNulo(ncldtdocs, 0)

				THIS.this_nNlnnrdocs  = TratarNulo(nlnnrdocs, 0)
				THIS.this_nNclnrdocs  = TratarNulo(nclnrdocs, 0)

				THIS.this_nNlnvldocs  = TratarNulo(nlnvldocs, 0)
				THIS.this_nNclvldocs  = TratarNulo(nclvldocs, 0)

				THIS.this_nNlntxtcds  = TratarNulo(nlntxtcds, 0)
				THIS.this_nNcltxtcds  = TratarNulo(ncltxtcds, 0)

				THIS.this_nNlnrazclis = TratarNulo(nlnrazclis, 0)
				THIS.this_nNclrazclis = TratarNulo(nclrazclis, 0)

				THIS.this_nNlncgcclis = TratarNulo(nlncgcclis, 0)
				THIS.this_nNclcgcclis = TratarNulo(nclcgcclis, 0)

				THIS.this_nNlnendcobs = TratarNulo(nlnendcobs, 0)
				THIS.this_nNclendcobs = TratarNulo(nclendcobs, 0)

				THIS.this_nNlnbaicobs = TratarNulo(nlnbaicobs, 0)
				THIS.this_nNclbaicobs = TratarNulo(nclbaicobs, 0)

				THIS.this_nNlncidcobs = TratarNulo(nlncidcobs, 0)
				THIS.this_nNclcidcobs = TratarNulo(nclcidcobs, 0)

				THIS.this_nNlnestcobs = TratarNulo(nlnestcobs, 0)
				THIS.this_nNclestcobs = TratarNulo(nclestcobs, 0)

				THIS.this_nNlncepcobs = TratarNulo(nlncepcobs, 0)
				THIS.this_nNclcepcobs = TratarNulo(nclcepcobs, 0)

				THIS.this_cNomeimps   = TratarNulo(cnomeimps, "")
				THIS.this_cFontepdrs  = TratarNulo(cfontepdrs, "")
				THIS.this_nTamfontes  = TratarNulo(ntamfontes, 0)

				THIS.this_cTamfolha   = TratarNulo(ctamfolha, "")

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - grava a configuracao de boletos quando ainda nao existe
	* nenhum registro em SigCnFBl (tabela de configuracao unica - Init do
	* legado faz Append Blank so quando a tabela esta vazia).
	*
	* Regra CLAUDE.md #22 - cidchaves (PK Fortyus) nunca vai em branco,
	* senao um segundo registro colidiria no indice unico; gerar com
	* fUniqueIds() quando a property ainda nao tem valor.
	*
	* Os campos de auditoria (Datas/Horas/Usuarios) sao preenchidos aqui
	* na gravacao, igual ao legado (cmdOk.Click: m.dDatas = Date(),
	* m.cHoras = Time(), m.cUsuarios = m.Usuar).
	*====================================================================
	PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
				THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
			ENDIF

			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "INSERT INTO SigCnFBl (" + ;
				"cidchaves, cemps, ddatas, choras, cusuarios, fpags, " + ;
				"ctxtcds, clocals, ntxtlins, ntxtcols, " + ;
				"nlnlocals, ncllocals, nlndtvencs, ncldtvencs, " + ;
				"nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs, " + ;
				"nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, " + ;
				"nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis, " + ;
				"nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs, " + ;
				"nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs, " + ;
				"nlncepcobs, nclcepcobs, cnomeimps, cfontepdrs, " + ;
				"ntamfontes, ctamfolha) VALUES (" + ;
				EscaparSQL(THIS.this_cCidchaves) + ", " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				FormatarDataSQL(THIS.this_dDatas) + ", " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				EscaparSQL(THIS.this_cUsuarios) + ", " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				EscaparSQL(THIS.this_cTxtcds) + ", " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", " + ;
				FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				EscaparSQL(THIS.this_cNomeimps) + ", " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + EscaparSQL(THIS.this_cTamfolha) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao gravar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - grava alteracoes na configuracao de boletos ja existente
	* (caminho normal: SigCnFBl tem sempre um unico registro, confirmado
	* pelo Init legado que aparece apos o primeiro Confirmar).
	*====================================================================
	PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .F.

		THIS.this_cMensagemErro = ""
		THIS.this_lErroExibido  = .F.

		TRY
			THIS.this_dDatas = DATE()
			THIS.this_cHoras = TIME()
			IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuarios, ""))) AND TYPE("gc_4c_UsuarioLogado") = "C"
				THIS.this_cUsuarios = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)
			ENDIF

			loc_cSQL = "UPDATE SigCnFBl SET " + ;
				"cemps = " + EscaparSQL(THIS.this_cEmps) + ", " + ;
				"ddatas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
				"choras = " + EscaparSQL(THIS.this_cHoras) + ", " + ;
				"cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + ", " + ;
				"fpags = " + EscaparSQL(THIS.this_cFpags) + ", "

			loc_cSQL = loc_cSQL + ;
				"ctxtcds = " + EscaparSQL(THIS.this_cTxtcds) + ", " + ;
				"clocals = " + EscaparSQL(THIS.this_cLocals) + ", " + ;
				"ntxtlins = " + FormatarNumeroSQL(THIS.this_nNtxtlins, 0) + ", " + ;
				"ntxtcols = " + FormatarNumeroSQL(THIS.this_nNtxtcols, 0) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnlocals, 2) + ", " + ;
				"ncllocals = " + FormatarNumeroSQL(THIS.this_nNcllocals, 2) + ", " + ;
				"nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlndtvencs, 2) + ", " + ;
				"ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNcldtvencs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlndtdocs, 2) + ", " + ;
				"ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNcldtdocs, 2) + ", " + ;
				"nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnnrdocs, 2) + ", " + ;
				"nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclnrdocs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnvldocs, 2) + ", " + ;
				"nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclvldocs, 2) + ", " + ;
				"nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlntxtcds, 2) + ", " + ;
				"ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNcltxtcds, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnrazclis, 2) + ", " + ;
				"nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclrazclis, 2) + ", " + ;
				"nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlncgcclis, 2) + ", " + ;
				"nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclcgcclis, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnendcobs, 2) + ", " + ;
				"nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclendcobs, 2) + ", " + ;
				"nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnbaicobs, 2) + ", " + ;
				"nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclbaicobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlncidcobs, 2) + ", " + ;
				"nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclcidcobs, 2) + ", " + ;
				"nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnestcobs, 2) + ", " + ;
				"nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclestcobs, 2) + ", "

			loc_cSQL = loc_cSQL + ;
				"nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlncepcobs, 2) + ", " + ;
				"nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclcepcobs, 2) + ", " + ;
				"cnomeimps = " + EscaparSQL(THIS.this_cNomeimps) + ", " + ;
				"cfontepdrs = " + EscaparSQL(THIS.this_cFontepdrs) + ", "

			loc_cSQL = loc_cSQL + ;
				"ntamfontes = " + FormatarNumeroSQL(THIS.this_nTamfontes, 0) + ", " + ;
				"ctamfolha = " + EscaparSQL(THIS.this_cTamfolha) + ;
				" WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				THIS.this_cMensagemErro = "Erro ao atualizar a configura" + CHR(231) + CHR(227) + "o de boletos:" + CHR(13) + CapturarErroSQL()
				MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
				THIS.this_lErroExibido = .T.
			ENDIF
		CATCH TO loc_oErro
			THIS.this_cMensagemErro = loc_oErro.Message
			MsgErro(loc_oErro.Message, "Erro")
			THIS.this_lErroExibido = .T.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SincronizarTamanhoFolhaSigCqMat - replica o update de SigCqMat feito
	* dentro do cmdOk.Click legado, APOS o Update de crSigCnFBL:
	*
	*   lcQuery = [Select * ] + [From SigCqMat]
	*   If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'csSigCqMat') < 1)
	*       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
	*       Return 0
	*   EndIf
	*   If (Not Eof('csSigCqMat') And Not IsEmpty(m.lcTamFolha))
	*       lcQuery = [Update SigCqMat Set ctamanho=']+m.lcTamFolha+[']
	*       ... SqlExecute ...
	*   EndIf
	*
	* SigCqMat eh tabela de OUTRO modulo (controle de qualidade) - nao faz
	* parte do schema de SigCnFBl, mas o legado sincroniza o tamanho de
	* folha configurado aqui com o registro de la, quando ele existe.
	*====================================================================
	PROCEDURE SincronizarTamanhoFolhaSigCqMat(par_cTamFolha)
		LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResultado

		loc_lSucesso = .T.

		TRY
			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF

			loc_cSQL = "SELECT * FROM SigCqMat"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCqMat")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_SigCqMat") > 0 AND !EMPTY(par_cTamFolha)
					loc_cSQL = "UPDATE SigCqMat SET ctamanho = " + EscaparSQL(par_cTamFolha)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

					IF loc_nResultado < 0
						MostrarErro("Favor Reinicializar o Processo!!!", ;
							"Falha na Conex" + CHR(227) + "o (SigCqMat)")
						loc_lSucesso = .F.
					ENDIF
				ENDIF
			ELSE
				MostrarErro("Favor Reinicializar o Processo!!!", ;
					"Falha na Conex" + CHR(227) + "o (SigCqMat)")
				loc_lSucesso = .F.
			ENDIF

			IF USED("cursor_4c_SigCqMat")
				USE IN cursor_4c_SigCqMat
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

