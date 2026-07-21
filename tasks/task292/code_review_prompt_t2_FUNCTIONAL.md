# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CONTAINER3, CNT_4C_CONTAINER2, CNT_4C_CONTAINER4, CNT_4C_CONTAINER5. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Container5' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container5' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container5' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container5' Left=284 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container2' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container2' Left=284 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container4' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container4' Top=8 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container4' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container4' Left=229 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container1' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container1' Left=259 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container3' (parent: SIGPRGLP): Top original=373 vs migrado 'cnt_4c_Container3' Top=5 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Qtd' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLP.Container3): Left original=188 vs migrado 'txt_4c_Tot_Qtd' Left=417 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Est' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLP.Container3): Left original=269 vs migrado 'txt_4c_Tot_Est' Left=498 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Prz' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLP.Container3): Left original=350 vs migrado 'txt_4c_Tot_Prz' Left=580 (diff=230px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2856 linhas total):

*-- Linhas 10 a 421:
10: *   CODE -> arquitetura em camadas (FormBase / SigPrGlpBO)
11: *
12: * CHAMADA:
13: *   loForm = CREATEOBJECT("FormSigPrGlp", loFormPai, dData, lReserva, nEmphPdr, lAutom, nNumeroOp)
14: *   loForm.Show()
15: *==============================================================================*
16: 
17: DEFINE CLASS FormSigPrGlp AS FormBase
18: 
19:     *-- Dimensoes identicas ao legado
20:     Height       = 600
21:     Width        = 1000
22:     BorderStyle  = 2
23:     AutoCenter   = .T.
24:     TitleBar     = 0
25:     ShowWindow = 1
26:     WindowType = 1
27:     ControlBox   = .F.
28:     Closable     = .F.
29:     MaxButton    = .F.
30:     MinButton    = .F.
31:     ClipControls = .F.
32:     DataSession  = 2
33:     WindowState  = 0
34:     KeyPreview   = .T.
35:     ShowTips     = .T.
36: 
37:     *-- Referencia ao form pai (datasession compartilhada)
38:     poFormPai        = .NULL.
39:     *-- Flags operacionais
40:     this_lReserva    = .F.
41:     this_lAutomatico = .F.
42:     this_nNumeroDaOp = 0
43:     this_nEmphPdr    = 0
44:     this_dData       = {}
45:     *-- Controle de edicao na coluna Produzir
46:     this_nOldValue   = 0
47: 
48:     *==========================================================================
49:     PROCEDURE Init
50:     *==========================================================================
51:         LPARAMETERS par_loFormPai, par_dData, par_lReservaAuto, par_nEmphPdr, par_lAutom, par_nNumeroOp
52: 
53:         IF VARTYPE(par_loFormPai) = "O"
54:             THIS.poFormPai     = par_loFormPai
55:             THIS.DataSessionId = par_loFormPai.DataSessionId
56:         ENDIF
57: 
58:         THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto)="L", par_lReservaAuto, .F.)
59:         THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)="N",    par_nEmphPdr,    0)
60:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)="L",      par_lAutom,      .F.)
61:         THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)="N",   par_nNumeroOp,   0)
62:         THIS.this_dData       = IIF(VARTYPE(par_dData)="D",       par_dData,       DATE())
63: 
64:         RETURN DODEFAULT()
65:     ENDPROC
66: 
67:     *==========================================================================
68:     PROTECTED PROCEDURE InicializarForm
69:     *==========================================================================
70:         LOCAL loc_lSucesso, loc_nSal, loc_nEst, loc_nPrz
71:         loc_lSucesso = .F.
72:         loc_nSal     = 0
73:         loc_nEst     = 0
74:         loc_nPrz     = 0
75: 
76:         TRY
77:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
78:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
79:                 MsgErro("Falha ao criar SigPrGlpBO", "Erro")
80:             ELSE
81:                 WITH THIS.this_oBusinessObject
82:                     .this_lReserva    = THIS.this_lReserva
83:                     .this_lAutomatico = THIS.this_lAutomatico
84:                     .this_nNumeroDaOp = THIS.this_nNumeroDaOp
85:                     .this_nEmphPdr    = THIS.this_nEmphPdr
86:                     .this_dData       = THIS.this_dData
87:                     IF USED("CrSigCdPac")
88:                         SELECT CrSigCdPac
89:                         .this_cSigKey = TratarNulo(CrSigCdPac.sigKeys, "C")
90:                     ENDIF
91:                 ENDWITH
92: 
93:                 IF THIS.this_lReserva
94:                     THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:                 ELSE
96:                     THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
97:                 ENDIF
98: 
99:                 THIS.ConfigurarPageFrame()
100:                 THIS.ConfigurarCabecalho()
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103: 
104:                 THIS.this_oBusinessObject.InicializarConexaoTemp()
105:                 THIS.this_oBusinessObject.CarregarParametros()
106:                 THIS.this_oBusinessObject.CarregarComposicao()
107:                 THIS.this_oBusinessObject.InicializarTmpSaldU()
108: 
109:                 IF USED("SelPedra")
110:                     SELECT SelPedra
111:                     IF RECCOUNT() = 0
112:                         APPEND BLANK
113:                     ENDIF
114:                 ENDIF
115: 
116:                 THIS.ConfigurarLayout()
117:                 THIS.CarregarDados()
118:                 THIS.TornarControlesVisiveis()
119: 
120:                 *-- Estado inicial do botao Pedras
121:                 THIS.cmd_4c_Pedras.Enabled = .F.
122:                 IF USED("crSigCdPam")
123:                     SELECT crSigCdPam
124:                     IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
125:                        !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
126:                        !THIS.this_lReserva
127:                         THIS.cmd_4c_Pedras.Enabled = .T.
128:                     ENDIF
129:                 ENDIF
130: 
131:                 IF USED("TmpFinal")
132:                     SELECT TmpFinal
133:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
134:                     GO TOP
135:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
136:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
137:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
138:                 ENDIF
139: 
140:                 THIS.Refresh
141:                 loc_lSucesso = .T.
142:             ENDIF
143:         CATCH TO loc_oErro
144:             MsgErro("Erro ao inicializar FormSigPrGlp: " + loc_oErro.Message + ;
145:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
146:                     " Proc=" + loc_oErro.Procedure, "Erro")
147:         ENDTRY
148: 
149:         RETURN loc_lSucesso
150:     ENDPROC
151: 
152:     *==========================================================================
153:     PROTECTED PROCEDURE ConfigurarPageFrame
154:     *==========================================================================
155:         LOCAL loc_cImg
156:         loc_cImg = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
157:         IF FILE(loc_cImg)
158:             THIS.Picture = loc_cImg
159:         ENDIF
160:     ENDPROC
161: 
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarCabecalho
164:     *==========================================================================
165:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
166:         WITH THIS.cnt_4c_Cabecalho
167:             .Top         = 0
168:             .Left        = 0
169:             .Width       = THIS.Width
170:             .Height      = 80
171:             .BackStyle   = 1
172:             .BackColor   = RGB(100, 100, 100)
173:             .BorderWidth = 0
174: 
175:             .AddObject("lbl_4c_Sombra", "Label")
176:             WITH .lbl_4c_Sombra
177:                 .AutoSize  = .F.
178:                 .Top       = 18
179:                 .Left      = 10
180:                 .Width     = THIS.Width
181:                 .Height    = 40
182:                 .FontBold  = .T.
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 18
185:                 .BackStyle = 0
186:                 .ForeColor = RGB(0, 0, 0)
187:                 .Caption   = " "
188:             ENDWITH
189: 
190:             .AddObject("lbl_4c_Titulo", "Label")
191:             WITH .lbl_4c_Titulo
192:                 .AutoSize  = .F.
193:                 .Top       = 17
194:                 .Left      = 10
195:                 .Width     = THIS.Width
196:                 .Height    = 46
197:                 .FontBold  = .T.
198:                 .FontName  = "Tahoma"
199:                 .FontSize  = 18
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .Caption   = " "
203:             ENDWITH
204:         ENDWITH
205:     ENDPROC
206: 
207:     *==========================================================================
208:     PROTECTED PROCEDURE ConfigurarLayout
209:     *==========================================================================
210:         LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio
211:         LOCAL loc_cImgDisp, loc_cImgLinhas, loc_cImgPedras, loc_cImgEstoque
212: 
213:         loc_cImgProcessar  = gc_4c_CaminhoIcones + "geral_executar_60.jpg"
214:         loc_cImgCancelar   = gc_4c_CaminhoIcones + "cadastro_encerrar_60.jpg"
215:         loc_cImgRelatorio  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
216:         loc_cImgDisp       = gc_4c_CaminhoIcones + "geral_pesquisar_60.jpg"
217:         loc_cImgLinhas     = gc_4c_CaminhoIcones + "geral_lista_60.jpg"
218:         loc_cImgPedras     = gc_4c_CaminhoIcones + "geral_adicionar_60.jpg"
219:         loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"
220: 
221:         *-- Botao Disponiveis (622,3,75,75)
222:         THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
223:         WITH THIS.cmd_4c_Disponivel
224:             .Top         = 3
225:             .Left        = 622
226:             .Width       = 75
227:             .Height      = 75
228:             .Caption     = "\<Dispon" + CHR(237) + "veis"
229:             .FontBold    = .T.
230:             .FontItalic  = .T.
231:             .FontName    = "Tahoma"
232:             .FontSize    = 8
233:             .WordWrap    = .T.
234:             .ForeColor   = RGB(90, 90, 90)
235:             .BackColor   = RGB(255, 255, 255)
236:             .Themes      = .T.
237:             IF FILE(loc_cImgDisp)
238:                 .Picture         = loc_cImgDisp
239:                 .DisabledPicture = loc_cImgDisp
240:             ENDIF
241:         ENDWITH
242:         BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")
243: 
244:         *-- Botao Total/Linhas (697,3,75,75)
245:         THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
246:         WITH THIS.cmd_4c_TotLinha
247:             .Top         = 3
248:             .Left        = 697
249:             .Width       = 75
250:             .Height      = 75
251:             .Caption     = "\<Total/Linhas"
252:             .FontBold    = .T.
253:             .FontItalic  = .T.
254:             .FontName    = "Tahoma"
255:             .FontSize    = 8
256:             .WordWrap    = .T.
257:             .ForeColor   = RGB(90, 90, 90)
258:             .BackColor   = RGB(255, 255, 255)
259:             .Themes      = .T.
260:             IF FILE(loc_cImgLinhas)
261:                 .Picture         = loc_cImgLinhas
262:                 .DisabledPicture = loc_cImgLinhas
263:             ENDIF
264:         ENDWITH
265:         BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
266: 
267:         *-- Botao Pedras/Requisicoes (472,3,75,75)
268:         THIS.AddObject("cmd_4c_Pedras", "CommandButton")
269:         WITH THIS.cmd_4c_Pedras
270:             .Top         = 3
271:             .Left        = 472
272:             .Width       = 75
273:             .Height      = 75
274:             .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
275:             .FontBold    = .T.
276:             .FontItalic  = .T.
277:             .FontName    = "Tahoma"
278:             .FontSize    = 8
279:             .WordWrap    = .T.
280:             .ForeColor   = RGB(90, 90, 90)
281:             .BackColor   = RGB(255, 255, 255)
282:             .Themes      = .T.
283:             IF FILE(loc_cImgPedras)
284:                 .Picture         = loc_cImgPedras
285:                 .DisabledPicture = loc_cImgPedras
286:             ENDIF
287:         ENDWITH
288:         BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
289: 
290:         *-- Botao SelEstoque (547,3,75,75)
291:         THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
292:         WITH THIS.cmd_4c_SelEstoque
293:             .Top         = 3
294:             .Left        = 547
295:             .Width       = 75
296:             .Height      = 75
297:             .Caption     = "\<Estoques"
298:             .FontBold    = .T.
299:             .FontItalic  = .T.
300:             .FontName    = "Tahoma"
301:             .FontSize    = 8
302:             .WordWrap    = .T.
303:             .ForeColor   = RGB(90, 90, 90)
304:             .BackColor   = RGB(255, 255, 255)
305:             .Themes      = .T.
306:             .Enabled     = .F.
307:             IF FILE(loc_cImgEstoque)
308:                 .Picture         = loc_cImgEstoque
309:                 .DisabledPicture = loc_cImgEstoque
310:             ENDIF
311:         ENDWITH
312:         BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
313: 
314:         *-- Botao Relatorio (772,3,75,75)
315:         THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
316:         WITH THIS.cmd_4c_BtnRelatorio
317:             .Top         = 3
318:             .Left        = 772
319:             .Width       = 75
320:             .Height      = 75
321:             .Caption     = "\<Relat" + CHR(243) + "rio"
322:             .FontBold    = .T.
323:             .FontItalic  = .T.
324:             .FontName    = "Tahoma"
325:             .FontSize    = 8
326:             .WordWrap    = .T.
327:             .ForeColor   = RGB(90, 90, 90)
328:             .BackColor   = RGB(255, 255, 255)
329:             .Themes      = .T.
330:             IF FILE(loc_cImgRelatorio)
331:                 .Picture         = loc_cImgRelatorio
332:                 .DisabledPicture = loc_cImgRelatorio
333:             ENDIF
334:         ENDWITH
335:         BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
336: 
337:         *-- Botao Processar (847,3,75,75)
338:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
339:         WITH THIS.cmd_4c_Processar
340:             .Top         = 3
341:             .Left        = 847
342:             .Width       = 75
343:             .Height      = 75
344:             .Caption     = "\<Processar"
345:             .FontBold    = .T.
346:             .FontItalic  = .T.
347:             .FontName    = "Tahoma"
348:             .FontSize    = 8
349:             .WordWrap    = .T.
350:             .ForeColor   = RGB(90, 90, 90)
351:             .BackColor   = RGB(255, 255, 255)
352:             .Themes      = .T.
353:             IF FILE(loc_cImgProcessar)
354:                 .Picture         = loc_cImgProcessar
355:                 .DisabledPicture = loc_cImgProcessar
356:             ENDIF
357:         ENDWITH
358:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
359: 
360:         *-- Botao Sair/Cancelar (922,3,75,75)
361:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
362:         WITH THIS.cmd_4c_Cancelar
363:             .Top         = 3
364:             .Left        = 922
365:             .Width       = 75
366:             .Height      = 75
367:             .Caption     = "Encerrar"
368:             .FontBold    = .T.
369:             .FontItalic  = .T.
370:             .FontName    = "Tahoma"
371:             .FontSize    = 8
372:             .WordWrap    = .T.
373:             .ForeColor   = RGB(90, 90, 90)
374:             .BackColor   = RGB(255, 255, 255)
375:             .Themes      = .T.
376:             IF FILE(loc_cImgCancelar)
377:                 .Picture         = loc_cImgCancelar
378:                 .DisabledPicture = loc_cImgCancelar
379:             ENDIF
380:         ENDWITH
381:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
382: 
383:         *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
384:         THIS.AddObject("grd_4c_Dados", "Grid")
385:         WITH THIS.grd_4c_Dados
386:             .Top              = 125
387:             .Left             = 11
388:             .Width            = 708
389:             .Height           = 224
390:             .ColumnCount      = 9
391:             .AllowHeaderSizing = .F.
392:             .AllowRowSizing    = .F.
393:             .DeleteMark        = .F.
394:             .RecordMark        = .F.
395:             .ScrollBars        = 3
396:             .RowHeight         = 16
397:             .GridLineColor     = RGB(238, 238, 238)
398:             .FontName          = "Tahoma"
399:             .FontSize          = 8
400:             *-- Col1: Produto
401:             WITH .Column1
402:                 .Width          = 80
403:                 .ReadOnly       = .T.
404:                 .Movable        = .F.
405:                 .Resizable      = .F.
406:                 .Header1.Caption = "Produto"
407:                 .Header1.FontName = "Verdana"
408:                 .Header1.FontSize = 8
409:                 .Header1.Alignment = 2
410:                 .Header1.ForeColor = RGB(36, 84, 155)
411:             ENDWITH
412:             *-- Col2: Cor
413:             WITH .Column2
414:                 .Width          = 40
415:                 .ReadOnly       = .T.
416:                 .Movable        = .F.
417:                 .Resizable      = .F.
418:                 .Header1.Caption = "Cor"
419:                 .Header1.FontName = "Verdana"
420:                 .Header1.FontSize = 8
421:                 .Header1.Alignment = 2

*-- Linhas 510 a 569:
510:                 .Header1.ForeColor = RGB(36, 84, 155)
511:             ENDWITH
512:         ENDWITH
513:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
514:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "When",      THIS, "GrdCol6TextWhen")
515:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "Valid",     THIS, "GrdCol6TextValid")
516:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "KeyPress", THIS, "GrdCol6TextLostFocus")
517:         *-- Redirecionar foco das colunas somente-leitura para Column6 (editavel)
518:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColXGotFocus")
519:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColXGotFocus")
520:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "GrdColXGotFocus")
521:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GrdColXGotFocus")
522:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GrdColXGotFocus")
523:         BINDEVENT(THIS.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "GrdColXGotFocus")
524:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus", THIS, "GrdColXGotFocus")
525: 
526:         *-- Totais abaixo do grid (349,417-662)
527:         THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
528:         WITH THIS.txt_4c_Tot_Qtd
529:             .Top          = 349
530:             .Left         = 417
531:             .Width        = 80
532:             .Height       = 23
533:             .ReadOnly     = .T.
534:             .FontName     = "Tahoma"
535:             .FontSize     = 8
536:             .SpecialEffect = 1
537:             .Value        = 0
538:         ENDWITH
539: 
540:         THIS.AddObject("txt_4c_Tot_Est", "TextBox")
541:         WITH THIS.txt_4c_Tot_Est
542:             .Top          = 349
543:             .Left         = 498
544:             .Width        = 81
545:             .Height       = 23
546:             .ReadOnly     = .T.
547:             .FontName     = "Tahoma"
548:             .FontSize     = 8
549:             .SpecialEffect = 1
550:             .Value        = 0
551:         ENDWITH
552: 
553:         THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
554:         WITH THIS.txt_4c_Tot_Prz
555:             .Top          = 349
556:             .Left         = 580
557:             .Width        = 82
558:             .Height       = 23
559:             .ReadOnly     = .T.
560:             .FontName     = "Tahoma"
561:             .FontSize     = 8
562:             .SpecialEffect = 1
563:             .Value        = 0
564:         ENDWITH
565: 
566:         *-- Label para observacao (726,369)
567:         THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
568:         WITH THIS.lbl_4c_Txt_ObsItens
569:             .Top       = 369

*-- Linhas 599 a 620:
599:             .Height  = 204
600:             .Visible = .F.
601:         ENDWITH
602: 
603:         *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
604:         THIS.AddObject("cnt_4c_Container3", "Container")
605:         WITH THIS.cnt_4c_Container3
606:             .Top           = 373
607:             .Left          = 12
608:             .Width         = 708
609:             .Height        = 205
610:             .BackColor     = RGB(255, 255, 255)
611:             .SpecialEffect = 0
612:             .BorderWidth   = 1
613: 
614:             .AddObject("lbl_4c_Label1", "Label")
615:             WITH .lbl_4c_Label1
616:                 .Top       = 5
617:                 .Left      = 6
618:                 .Width     = 118
619:                 .Height    = 16
620:                 .AutoSize  = .F.

*-- Linhas 711 a 756:
711:                 .ReadOnly     = .T.
712:                 .SpecialEffect = 1
713:                 .FontSize     = 8
714:             ENDWITH
715: 
716:             .AddObject("txt_4c_Tot_Qtd", "TextBox")
717:             WITH .txt_4c_Tot_Qtd
718:                 .Top          = 173
719:                 .Left         = 188
720:                 .Width        = 80
721:                 .Height       = 23
722:                 .ReadOnly     = .T.
723:                 .SpecialEffect = 1
724:                 .FontSize     = 8
725:                 .Value        = 0
726:             ENDWITH
727: 
728:             .AddObject("txt_4c_Tot_Est", "TextBox")
729:             WITH .txt_4c_Tot_Est
730:                 .Top          = 173
731:                 .Left         = 269
732:                 .Width        = 80
733:                 .Height       = 23
734:                 .ReadOnly     = .T.
735:                 .SpecialEffect = 1
736:                 .FontSize     = 8
737:                 .Value        = 0
738:             ENDWITH
739: 
740:             .AddObject("txt_4c_Tot_Prz", "TextBox")
741:             WITH .txt_4c_Tot_Prz
742:                 .Top          = 173
743:                 .Left         = 350
744:                 .Width        = 80
745:                 .Height       = 23
746:                 .ReadOnly     = .T.
747:                 .SpecialEffect = 1
748:                 .FontSize     = 8
749:                 .Value        = 0
750:             ENDWITH
751: 
752:             .AddObject("lbl_4c_Label2", "Label")
753:             WITH .lbl_4c_Label2
754:                 .Top = 90
755:                 .Left = 454
756:                 .Width = 36

*-- Linhas 773 a 818:
773:                 .Caption = "Conta"
774:                 .FontSize = 8
775:                 .ForeColor = RGB(90, 90, 90)
776:             ENDWITH
777:         ENDWITH
778:         BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")
779: 
780:         *-- Container1: totais por linha (Visible=.F., sobreposicao)
781:         THIS.AddObject("cnt_4c_Container1", "Container")
782:         WITH THIS.cnt_4c_Container1
783:             .Top           = 125
784:             .Left          = 12
785:             .Width         = 708
786:             .Height        = 465
787:             .BackColor     = RGB(255, 255, 255)
788:             .BackStyle     = 1
789:             .SpecialEffect = 0
790:             .Visible       = .F.
791: 
792:             .AddObject("lbl_4c_Label1", "Label")
793:             WITH .lbl_4c_Label1
794:                 .Top = 10
795:                 .Left = 259
796:                 .Width = 170
797:                 .Height = 18
798:                 .AutoSize = .F.
799:                 .BackStyle = 0
800:                 .FontBold = .T.
801:                 .FontName = "Tahoma"
802:                 .FontSize = 10
803:                 .ForeColor = RGB(90, 90, 90)
804:                 .Caption = "Pe" + CHR(231) + "as a produzir por linha"
805:             ENDWITH
806: 
807:             .AddObject("cmd_4c_CancelaLin", "CommandButton")
808:             WITH .cmd_4c_CancelaLin
809:                 .Top = 3
810:                 .Left = 620
811:                 .Width = 75
812:                 .Height = 75
813:                 .Caption = "OK"
814:                 .FontBold = .T.
815:                 .FontItalic = .T.
816:                 .FontName = "Tahoma"
817:                 .FontSize = 8
818:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 866 a 911:
866:                     .Header1.FontSize = 8
867:                     .Header1.ForeColor = RGB(36, 84, 155)
868:                 ENDWITH
869:             ENDWITH
870:         ENDWITH
871:         BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")
872: 
873:         *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
874:         THIS.AddObject("cnt_4c_Container2", "Container")
875:         WITH THIS.cnt_4c_Container2
876:             .Top = 125
877:             .Left = 12
878:             .Width = 708
879:             .Height = 465
880:             .BackColor = RGB(255, 255, 255)
881:             .BackStyle = 1
882:             .SpecialEffect = 0
883:             .Visible = .F.
884: 
885:             .AddObject("lbl_4c_Label1", "Label")
886:             WITH .lbl_4c_Label1
887:                 .Top = 10
888:                 .Left = 284
889:                 .Width = 123
890:                 .Height = 18
891:                 .AutoSize = .F.
892:                 .BackStyle = 0
893:                 .FontBold = .T.
894:                 .FontName = "Tahoma"
895:                 .FontSize = 10
896:                 .ForeColor = RGB(90, 90, 90)
897:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
898:             ENDWITH
899: 
900:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
901:             WITH .cmd_4c_CancelaDisp
902:                 .Top = 3
903:                 .Left = 620
904:                 .Width = 75
905:                 .Height = 75
906:                 .Caption = "Sair"
907:                 .FontBold = .T.
908:                 .FontItalic = .T.
909:                 .FontName = "Tahoma"
910:                 .FontSize = 8
911:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 971 a 1016:
971:                     .Text1.BorderStyle = 0
972:                     .Text1.Alignment = 3
973:                     .Text1.Value = 0
974:                 ENDWITH
975:             ENDWITH
976:             BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")
977: 
978:             .AddObject("lbl_4c_Label2", "Label")
979:             WITH .lbl_4c_Label2
980:                 .Top = 432
981:                 .Left = 168
982:                 .Width = 84
983:                 .Height = 15
984:                 .AutoSize = .F.
985:                 .BackStyle = 0
986:                 .FontSize = 8
987:                 .ForeColor = RGB(90, 90, 90)
988:                 .Caption = "Qtde " + CHR(224) + " Produzir :"
989:             ENDWITH
990: 
991:             .AddObject("lbl_4c_Label3", "Label")
992:             WITH .lbl_4c_Label3
993:                 .Top = 431
994:                 .Left = 365
995:                 .Width = 109
996:                 .Height = 17
997:                 .AutoSize = .F.
998:                 .BackStyle = 0
999:                 .FontSize = 8
1000:                 .ForeColor = RGB(90, 90, 90)
1001:                 .Caption = "Qtde " + CHR(224) + " Utilizar :"
1002:             ENDWITH
1003: 
1004:             .AddObject("txt_4c_Qt_pedida", "TextBox")
1005:             WITH .txt_4c_Qt_pedida
1006:                 .Top = 428
1007:                 .Left = 268
1008:                 .Width = 80
1009:                 .Height = 23
1010:                 .ReadOnly = .T.
1011:                 .SpecialEffect = 1
1012:                 .FontSize = 8
1013:                 .Value = 0
1014:             ENDWITH
1015: 
1016:             .AddObject("txt_4c_Qt_Selec", "TextBox")

*-- Linhas 1023 a 1073:
1023:                 .SpecialEffect = 1
1024:                 .FontSize = 8
1025:                 .Value = 0
1026:             ENDWITH
1027:         ENDWITH
1028:         BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
1029:         *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
1030:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1031:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1032:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1033:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1034: 
1035:         *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
1036:         THIS.AddObject("cnt_4c_Container4", "Container")
1037:         WITH THIS.cnt_4c_Container4
1038:             .Top = 125
1039:             .Left = 12
1040:             .Width = 708
1041:             .Height = 465
1042:             .BackColor = RGB(255, 255, 255)
1043:             .BackStyle = 1
1044:             .SpecialEffect = 0
1045:             .Visible = .F.
1046: 
1047:             .AddObject("lbl_4c_Label1", "Label")
1048:             WITH .lbl_4c_Label1
1049:                 .Top = 8
1050:                 .Left = 229
1051:                 .Width = 249
1052:                 .Height = 18
1053:                 .AutoSize = .F.
1054:                 .BackStyle = 0
1055:                 .FontBold = .T.
1056:                 .FontName = "Tahoma"
1057:                 .FontSize = 10
1058:                 .ForeColor = RGB(90, 90, 90)
1059:                 .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1060:             ENDWITH
1061: 
1062:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1063:             WITH .cmd_4c_CancelaDisp
1064:                 .Top = 3
1065:                 .Left = 620
1066:                 .Width = 75
1067:                 .Height = 75
1068:                 .Caption = "Sair"
1069:                 .FontBold = .T.
1070:                 .FontItalic = .T.
1071:                 .FontName = "Tahoma"
1072:                 .FontSize = 8
1073:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1129 a 1178:
1129:                     .Header1.FontSize = 8
1130:                     .Header1.ForeColor = RGB(36, 84, 155)
1131:                 ENDWITH
1132:             ENDWITH
1133:         ENDWITH
1134:         BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
1135:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
1136:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
1137:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
1138:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")
1139: 
1140:         *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
1141:         THIS.AddObject("cnt_4c_Container5", "Container")
1142:         WITH THIS.cnt_4c_Container5
1143:             .Top = 125
1144:             .Left = 12
1145:             .Width = 708
1146:             .Height = 465
1147:             .BackColor = RGB(255, 255, 255)
1148:             .BackStyle = 1
1149:             .SpecialEffect = 0
1150:             .Visible = .F.
1151: 
1152:             .AddObject("lbl_4c_Label1", "Label")
1153:             WITH .lbl_4c_Label1
1154:                 .Top = 10
1155:                 .Left = 284
1156:                 .Width = 123
1157:                 .Height = 18
1158:                 .AutoSize = .F.
1159:                 .BackStyle = 0
1160:                 .FontBold = .T.
1161:                 .FontName = "Tahoma"
1162:                 .FontSize = 10
1163:                 .ForeColor = RGB(90, 90, 90)
1164:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
1165:             ENDWITH
1166: 
1167:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1168:             WITH .cmd_4c_CancelaDisp
1169:                 .Top = 3
1170:                 .Left = 620
1171:                 .Width = 75
1172:                 .Height = 75
1173:                 .Caption = "OK"
1174:                 .FontBold = .T.
1175:                 .FontItalic = .T.
1176:                 .FontName = "Tahoma"
1177:                 .FontSize = 8
1178:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1238 a 1284:
1238:                     .Text1.BorderStyle = 0
1239:                     .Text1.Alignment = 3
1240:                     .Text1.Value = 0
1241:                 ENDWITH
1242:             ENDWITH
1243:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
1244:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")
1245: 
1246:             .AddObject("lbl_4c_Label2", "Label")
1247:             WITH .lbl_4c_Label2
1248:                 .Top = 413
1249:                 .Left = 428
1250:                 .Width = 48
1251:                 .Height = 15
1252:                 .AutoSize = .F.
1253:                 .BackStyle = 0
1254:                 .FontSize = 8
1255:                 .ForeColor = RGB(90, 90, 90)
1256:                 .Caption = "Produzir :"
1257:             ENDWITH
1258: 
1259:             .AddObject("lbl_4c_Label3", "Label")
1260:             WITH .lbl_4c_Label3
1261:                 .Top = 438
1262:                 .Left = 435
1263:                 .Width = 41
1264:                 .Height = 15
1265:                 .AutoSize = .F.
1266:                 .BackStyle = 0
1267:                 .FontSize = 8
1268:                 .ForeColor = RGB(90, 90, 90)
1269:                 .Caption = "Utilizar :"
1270:             ENDWITH
1271: 
1272:             .AddObject("lbl_4c_Label4", "Label")
1273:             WITH .lbl_4c_Label4
1274:                 .Top = 413
1275:                 .Left = 93
1276:                 .Width = 38
1277:                 .Height = 15
1278:                 .AutoSize = .F.
1279:                 .BackStyle = 0
1280:                 .FontSize = 8
1281:                 .ForeColor = RGB(90, 90, 90)
1282:                 .Caption = "Grupo :"
1283:             ENDWITH
1284: 

*-- Linhas 1339 a 1421:
1339:                 .SpecialEffect = 1
1340:                 .FontSize = 8
1341:                 .Value = 0
1342:             ENDWITH
1343:         ENDWITH
1344:         BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")
1345: 
1346:         *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
1347:         THIS.AddObject("shp_4c_Shape2", "Shape")
1348:         WITH THIS.shp_4c_Shape2
1349:             .Top         = 9
1350:             .Left        = 9
1351:             .Width       = 279
1352:             .Height      = 51
1353:             .BackStyle   = 0
1354:             .BorderColor = RGB(255, 255, 255)
1355:             .BorderWidth = 2
1356:             .SpecialEffect = 0
1357:         ENDWITH
1358: 
1359:         *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
1360:         THIS.AddObject("shp_4c_Shape3", "Shape")
1361:         WITH THIS.shp_4c_Shape3
1362:             .Top         = 10
1363:             .Left        = 820
1364:             .Width       = 116
1365:             .Height      = 38
1366:             .BackStyle   = 0
1367:             .BorderColor = RGB(255, 255, 255)
1368:             .BorderWidth = 2
1369:             .SpecialEffect = 0
1370:         ENDWITH
1371:     ENDPROC
1372: 
1373:     *==========================================================================
1374:     * ConfigurarPaginaLista - Restaura a visao principal do form
1375:     *
1376:     * OPERACIONAL: nao ha PageFrame com Page1/Page2 como em CRUD. A "pagina
1377:     * lista" aqui eh o conjunto: grid principal (grd_4c_Dados / TmpFinal) +
1378:     * totais + Container3 (saldo por grupo/conta, sempre visivel). Os overlays
1379:     * (Container1/2/4/5) sao escondidos e as acoes principais reabilitadas.
1380:     *==========================================================================
1381:     PROTECTED PROCEDURE ConfigurarPaginaLista
1382:         LOCAL loc_lPodeAcao
1383: 
1384:         *-- Ocultar overlays flutuantes
1385:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1386:             THIS.cnt_4c_Container1.Visible = .F.
1387:         ENDIF
1388:         IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
1389:             THIS.cnt_4c_Container2.Visible = .F.
1390:         ENDIF
1391:         IF PEMSTATUS(THIS, "cnt_4c_Container4", 5)
1392:             THIS.cnt_4c_Container4.Visible = .F.
1393:         ENDIF
1394:         IF PEMSTATUS(THIS, "cnt_4c_Container5", 5)
1395:             THIS.cnt_4c_Container5.Visible = .F.
1396:         ENDIF
1397: 
1398:         *-- Grid principal e Container3 (saldo) sempre acessiveis
1399:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1400:             THIS.grd_4c_Dados.Enabled = .T.
1401:             THIS.grd_4c_Dados.ZOrder
1402:         ENDIF
1403:         IF PEMSTATUS(THIS, "cnt_4c_Container3", 5)
1404:             THIS.cnt_4c_Container3.Enabled = .T.
1405:         ENDIF
1406: 
1407:         *-- Reabilitar botoes de acao principal
1408:         THIS.cmd_4c_Processar.Enabled  = .T.
1409:         THIS.cmd_4c_Cancelar.Enabled   = .T.
1410:         THIS.cmd_4c_TotLinha.Enabled   = .T.
1411:         THIS.cmd_4c_Disponivel.Enabled = .T.
1412:         THIS.cmd_4c_BtnRelatorio.Enabled = .T.
1413: 
1414:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1415:         loc_lPodeAcao = .F.
1416:         IF USED("crSigCdPam")
1417:             SELECT crSigCdPam
1418:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1419:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1420:                             !THIS.this_lReserva
1421:         ENDIF

*-- Linhas 1438 a 1969:
1438:     * atualiza os bindings e valores exibidos para o registro corrente do grid
1439:     * principal (TmpFinal). E chamado apos mudanca de linha no grid principal.
1440:     *==========================================================================
1441:     PROTECTED PROCEDURE ConfigurarPaginaDados
1442:         LOCAL loc_nSaldo, loc_nEstoque, loc_nProduzir
1443: 
1444:         loc_nSaldo    = 0
1445:         loc_nEstoque  = 0
1446:         loc_nProduzir = 0
1447: 
1448:         *-- Requer TmpFinal e TmpSaldG carregados
1449:         IF !USED("TmpFinal") OR !USED("TmpSaldG")
1450:             RETURN
1451:         ENDIF
1452: 
1453:         *-- Reposicionar TmpSaldG conforme item corrente do grid principal
1454:         SELECT TmpSaldG
1455:         SET ORDER TO Cpros
1456:         SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1457:         GO TOP
1458: 
1459:         *-- Vincular Container3 grid ao cursor de saldo detalhado
1460:         THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1461:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1462:             .Column1.ControlSource = "TmpSaldG.Grupos"
1463:             .Column2.ControlSource = "TmpSaldG.Estos"
1464:             .Column3.ControlSource = "TmpSaldG.Saldo"
1465:             .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1466:             .Column5.ControlSource = "TmpSaldG.Disps"
1467:             .Column6.ControlSource = "TmpSaldG.Emps"
1468:             .SetAll("ReadOnly", .T.)
1469:             .Refresh
1470:         ENDWITH
1471: 
1472:         *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
1473:         IF USED("TmpGrupo")
1474:             THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
1475:         ENDIF
1476:         IF USED("TmpConta")
1477:             THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
1478:         ENDIF
1479: 
1480:         *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
1481:         IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1482:             loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)
1483:             loc_nEstoque  = NVL(TmpSaldo.Saldo, 0) - NVL(TmpSaldo.Disps, 0)
1484:             loc_nProduzir = NVL(TmpSaldo.Disps, 0)
1485:         ENDIF
1486:         THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = loc_nSaldo
1487:         THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = loc_nEstoque
1488:         THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir
1489: 
1490:         *-- Rebind da EditBox de observacao ao item corrente
1491:         THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1492:         THIS.obj_4c_ObsItens.Refresh
1493: 
1494:         *-- Rotulo dinamico da observacao
1495:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1496:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * AlternarPagina - Alterna entre a visao principal e os overlays
1501:     *
1502:     * Parametros: par_nPagina
1503:     *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
1504:     *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
1505:     *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
1506:     *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista
1507:     *   4 -> Container4 (Requisicoes)      - equivalente a BtnPedrasClick
1508:     *   5 -> Container5 (Selecao Estoque)  - equivalente a BtnSelEstoqueClick
1509:     *==========================================================================
1510:     PROCEDURE AlternarPagina(par_nPagina)
1511:         LOCAL loc_nPag
1512:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)
1513: 
1514:         DO CASE
1515:             CASE loc_nPag = 1
1516:                 THIS.BtnTotLinhaClick()
1517:             CASE loc_nPag = 2
1518:                 THIS.BtnDisponiveiClick()
1519:             CASE loc_nPag = 4
1520:                 THIS.BtnPedrasClick()
1521:             CASE loc_nPag = 5
1522:                 THIS.BtnSelEstoqueClick()
1523:             OTHERWISE
1524:                 *-- Pagina 0 ou 3: restaurar visao principal
1525:                 THIS.ConfigurarPaginaLista()
1526:         ENDCASE
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     PROTECTED PROCEDURE CarregarDados
1531:     *==========================================================================
1532:         LOCAL loc_lReadOnly
1533: 
1534:         *-- Grid principal: vincular ao TmpFinal
1535:         IF USED("TmpFinal")
1536:             THIS.grd_4c_Dados.RecordSource = "TmpFinal"
1537:             WITH THIS.grd_4c_Dados
1538:                 .Column1.ControlSource = "TmpFinal.Cpros"
1539:                 .Column2.ControlSource = "TmpFinal.CodCors"
1540:                 .Column3.ControlSource = "TmpFinal.Dopes"
1541:                 .Column4.ControlSource = "TmpFinal.Numes"
1542:                 .Column5.ControlSource = "TmpFinal.Saldo"
1543:                 .Column6.ControlSource = "TmpFinal.Produzir"
1544:                 .Column7.ControlSource = "TmpFinal.Estoque"
1545:                 .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
1546:                 .Column9.ControlSource = "TmpFinal.CodTams"
1547:             ENDWITH
1548: 
1549:             *-- Se nao ha operacao de transferencia, grid fica somente leitura
1550:             IF USED("crSigCdPam")
1551:                 SELECT crSigCdPam
1552:                 IF EMPTY(crSigCdPam.TransfRes)
1553:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
1554:                 ENDIF
1555:             ENDIF
1556:         ENDIF
1557: 
1558:         *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
1559:         IF USED("TmpSaldG") AND USED("TmpFinal")
1560:             SELECT TmpSaldG
1561:             SET ORDER TO Cpros
1562:             GO TOP
1563:             IF !EOF("TmpFinal")
1564:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1565:             ENDIF
1566:             GO TOP
1567: 
1568:             THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1569:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1570:                 .Column1.ControlSource = "TmpSaldG.Grupos"
1571:                 .Column2.ControlSource = "TmpSaldG.Estos"
1572:                 .Column3.ControlSource = "TmpSaldG.Saldo"
1573:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1574:                 .Column5.ControlSource = "TmpSaldG.Disps"
1575:                 .Column6.ControlSource = "TmpSaldG.Emps"
1576:                 .SetAll("ReadOnly", .T.)
1577:             ENDWITH
1578:         ENDIF
1579: 
1580:         *-- ObsItens: vincula ao campo de observacao do item corrente
1581:         IF USED("TmpFinal")
1582:             THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1583:         ENDIF
1584:     ENDPROC
1585: 
1586:     *==========================================================================
1587:     PROTECTED PROCEDURE TornarControlesVisiveis
1588:     *==========================================================================
1589:         LOCAL loc_nI, loc_oCtrl
1590:         FOR loc_nI = 1 TO THIS.ControlCount
1591:             loc_oCtrl = THIS.Controls(loc_nI)
1592:             *-- Overlays ocultos: manter Visible=.F., mas tornar sub-controles visiveis
1593:             IF INLIST(loc_oCtrl.Name, ;
1594:                       "cnt_4c_Container1", ;
1595:                       "cnt_4c_Container2", ;
1596:                       "cnt_4c_Container4", ;
1597:                       "cnt_4c_Container5", ;
1598:                       "img_4c_ImgFigJpg")
1599:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1600:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
1601:                 ENDIF
1602:                 LOOP
1603:             ENDIF
1604:             *-- Containers visiveis gerenciados: tornar visivel explicitamente e processar sub-controles
1605:             IF INLIST(loc_oCtrl.Name, "cnt_4c_Cabecalho", "cnt_4c_Container3")
1606:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1607:                     loc_oCtrl.Visible = .T.
1608:                 ENDIF
1609:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1610:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
1611:                 ENDIF
1612:                 LOOP
1613:             ENDIF
1614:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1615:                 loc_oCtrl.Visible = .T.
1616:             ENDIF
1617:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1618:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1619:             ENDIF
1620:         ENDFOR
1621:     ENDPROC
1622: 
1623:     *==========================================================================
1624:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1625:     *==========================================================================
1626:         LOCAL loc_nI, loc_oCtrl
1627:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1628:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1629:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1630:                 loc_oCtrl.Visible = .T.
1631:             ENDIF
1632:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1633:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1634:             ENDIF
1635:         ENDFOR
1636:     ENDPROC
1637: 
1638:     *==========================================================================
1639:     PROCEDURE Destroy
1640:     *==========================================================================
1641:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1642:             THIS.this_oBusinessObject.LiberarConexaoTemp()
1643:         ENDIF
1644:         DODEFAULT()
1645:     ENDPROC
1646: 
1647:     *==========================================================================
1648:     * HANDLERS DE EVENTOS DOS BOTOES PRINCIPAIS
1649:     *==========================================================================
1650: 
1651:     PROCEDURE BtnDisponiveiClick
1652:         LOCAL loc_cCpro, loc_cCor
1653: 
1654:         TRY
1655:             IF USED("TmpFinal")
1656:                 loc_cCpro = TmpFinal.Cpros
1657:                 loc_cCor  = TmpFinal.CodCors
1658: 
1659:                 IF USED("TmpDisp")
1660:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = ""
1661:                     USE IN TmpDisp
1662:                 ENDIF
1663: 
1664:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1665:                   FROM TmpSaldo ;
1666:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1667:                  ORDER BY Cpros, CodCors, CodTams ;
1668:                   INTO CURSOR TmpDisp READWRITE
1669: 
1670:                 THIS.grd_4c_Dados.Enabled = .F.
1671: 
1672:                 IF _Tally = 0
1673:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1674:                     THIS.BtnCancelaDisp2Click()
1675:                 ELSE
1676:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
1677:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1678:                         .Column1.ControlSource = "TmpDisp.Cpros"
1679:                         .Column2.ControlSource = "TmpDisp.CodCors"
1680:                         .Column3.ControlSource = "TmpDisp.CodTams"
1681:                         .Column4.ControlSource = "TmpDisp.Disps"
1682:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1683:                     ENDWITH
1684: 
1685:                     WITH THIS.cnt_4c_Container2
1686:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1687:                         .txt_4c_Qt_Selec.Value  = 0
1688:                         .Visible     = .T.
1689:                     ENDWITH
1690: 
1691:                     THIS.cmd_4c_Processar.Enabled  = .F.
1692:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1693:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1694:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1695:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1696:                     THIS.cnt_4c_Container3.Enabled = .F.
1697:                     THIS.cnt_4c_Container2.Visible = .T.
1698:                     THIS.cnt_4c_Container2.ZOrder
1699:                     THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
1700:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus
1701:                 ENDIF
1702:             ENDIF
1703:         CATCH TO loc_oErro
1704:             MsgErro(loc_oErro.Message, "Erro")
1705:         ENDTRY
1706:     ENDPROC
1707: 
1708:     PROCEDURE BtnTotLinhaClick
1709:         TRY
1710:             IF USED("TmpLinha")
1711:                 THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = ""
1712:                 USE IN TmpLinha
1713:             ENDIF
1714: 
1715:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1716:               FROM TmpFinal ;
1717:              GROUP BY 1 ;
1718:              UNION ALL ;
1719:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1720:               FROM TmpFinal ;
1721:              GROUP BY 1 ;
1722:               INTO CURSOR TmpLinha ;
1723:              ORDER BY 2, 1
1724: 
1725:             THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
1726:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1727:                 .Column1.ControlSource = "TmpLinha.Linhas"
1728:                 .Column2.ControlSource = "TmpLinha.Saldo"
1729:                 .Column3.ControlSource = "TmpLinha.Estoque"
1730:                 .Column4.ControlSource = "TmpLinha.Produzir"
1731:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1732:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1733:             ENDWITH
1734: 
1735:             THIS.cmd_4c_Processar.Enabled  = .F.
1736:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1737:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1738:             THIS.cmd_4c_Pedras.Enabled     = .F.
1739:             THIS.cmd_4c_Disponivel.Enabled = .F.
1740:             THIS.grd_4c_Dados.Enabled      = .F.
1741:             THIS.cnt_4c_Container3.Enabled = .F.
1742:             THIS.cnt_4c_Container1.Visible = .T.
1743:             THIS.cnt_4c_Container1.ZOrder
1744:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1745:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus
1746:         CATCH TO loc_oErro
1747:             MsgErro(loc_oErro.Message, "Erro")
1748:         ENDTRY
1749:     ENDPROC
1750: 
1751:     PROCEDURE BtnPedrasClick
1752:         TRY
1753:             IF USED("SelPedra")
1754:                 THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = ""
1755:             ENDIF
1756: 
1757:             THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
1758:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1759:                 .Column1.ControlSource = "SelPedra.Cpros"
1760:                 .Column2.ControlSource = "SelPedra.Dpros"
1761:                 .Column3.ControlSource = "SelPedra.Cunis"
1762:                 .Column4.ControlSource = "SelPedra.Qtds"
1763:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1764:             ENDWITH
1765: 
1766:             THIS.cmd_4c_Processar.Enabled  = .F.
1767:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1768:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1769:             THIS.cmd_4c_Pedras.Enabled     = .F.
1770:             THIS.cmd_4c_Disponivel.Enabled = .F.
1771:             THIS.grd_4c_Dados.Enabled      = .F.
1772:             THIS.cnt_4c_Container3.Enabled = .F.
1773:             THIS.cnt_4c_Container4.Visible = .T.
1774:             THIS.cnt_4c_Container4.ZOrder
1775:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1776:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1777:         CATCH TO loc_oErro
1778:             MsgErro(loc_oErro.Message, "Erro")
1779:         ENDTRY
1780:     ENDPROC
1781: 
1782:     PROCEDURE BtnSelEstoqueClick
1783:         LOCAL loc_cCpro, loc_cCor, loc_cTam
1784: 
1785:         TRY
1786:             IF USED("TmpFinal")
1787:                 loc_cCpro = TmpFinal.Cpros
1788:                 loc_cCor  = TmpFinal.CodCors
1789:                 loc_cTam  = TmpFinal.CodTams
1790: 
1791:                 IF USED("TmpDisp")
1792:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = ""
1793:                     USE IN TmpDisp
1794:                 ENDIF
1795: 
1796:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1797:                        000000000.000 AS Utilizar ;
1798:                   FROM TmpSaldG ;
1799:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1800:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1801:                 SELECT 0
1802:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1803:                 USE IN Resultado
1804: 
1805:                 THIS.grd_4c_Dados.Enabled = .F.
1806: 
1807:                 IF _Tally = 0
1808:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1809:                     THIS.BtnCancelaDisp5Click()
1810:                 ELSE
1811:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
1812:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1813:                         .Column1.ControlSource = "TmpDisp.Grupos"
1814:                         .Column2.ControlSource = "TmpDisp.Estos"
1815:                         .Column3.ControlSource = "TmpDisp.Priors"
1816:                         .Column4.ControlSource = "TmpDisp.Disps"
1817:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1818:                     ENDWITH
1819: 
1820:                     WITH THIS.cnt_4c_Container5
1821:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1822:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1823:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1824:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1825:                         .txt_4c_Qt_Selec.Value  = 0
1826:                         .Visible     = .T.
1827:                     ENDWITH
1828: 
1829:                     THIS.cmd_4c_Processar.Enabled  = .F.
1830:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1831:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1832:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1833:                     THIS.cmd_4c_SelEstoque.Enabled = .F.
1834:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1835:                     THIS.cnt_4c_Container3.Enabled = .F.
1836:                     THIS.cnt_4c_Container5.Visible = .T.
1837:                     THIS.cnt_4c_Container5.ZOrder
1838:                     THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
1839:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus
1840:                 ENDIF
1841:             ENDIF
1842:         CATCH TO loc_oErro
1843:             MsgErro(loc_oErro.Message, "Erro")
1844:         ENDTRY
1845:     ENDPROC
1846: 
1847:     PROCEDURE BtnCancelarClick
1848:         TRY
1849:             IF VARTYPE(THIS.poFormPai) = "O"
1850:                 THIS.poFormPai.Enabled = .T.
1851:             ENDIF
1852:             THIS.Release
1853:         CATCH TO loc_oErro
1854:             MsgErro(loc_oErro.Message, "Erro")
1855:         ENDTRY
1856:     ENDPROC
1857: 
1858:     PROCEDURE BtnProcessarClick
1859:         LOCAL loc_dPrevisao, loc_dGeracao, loc_lSucesso
1860: 
1861:         loc_dPrevisao = DATE()
1862:         loc_dGeracao  = THIS.this_dData
1863:         loc_lSucesso  = .F.
1864: 
1865:         TRY
1866:             *-- Tentar obter datas do formulario pai/av?
1867:             IF VARTYPE(THIS.poFormPai) = "O"
1868:                 TRY
1869:                     IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
1870:                         loc_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
1871:                         loc_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
1872:                     ENDIF
1873:                 CATCH
1874:                 ENDTRY
1875:             ENDIF
1876: 
1877:             WITH THIS.this_oBusinessObject
1878:                 .this_lReserva    = THIS.this_lReserva
1879:                 .this_lAutomatico = THIS.this_lAutomatico
1880:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
1881:                 .this_dPrevisao   = loc_dPrevisao
1882:                 .this_dGeracao    = loc_dGeracao
1883:             ENDWITH
1884: 
1885:             loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dPrevisao, loc_dGeracao)
1886: 
1887:             IF loc_lSucesso
1888:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso!", "Informa" + CHR(231) + CHR(227) + "o")
1889:                 IF VARTYPE(THIS.poFormPai) = "O"
1890:                     THIS.poFormPai.Enabled = .T.
1891:                 ENDIF
1892:                 THIS.Release
1893:             ENDIF
1894:         CATCH TO loc_oErro
1895:             MsgErro(loc_oErro.Message, "Erro")
1896:         ENDTRY
1897:     ENDPROC
1898: 
1899:     PROCEDURE BtnRelatorioClick
1900:         TRY
1901:             IF THIS.this_oBusinessObject.GerarRelatorio()
1902:                 THIS.ExecutarReportForm("SigPrGlp", "PRINTER_PROMPT", "crImpressao")
1903:             ENDIF
1904:         CATCH TO loc_oErro
1905:             MsgErro(loc_oErro.Message, "Erro")
1906:         ENDTRY
1907:     ENDPROC
1908: 
1909:     *==========================================================================
1910:     * HANDLERS DE EVENTOS DOS CONTAINERS OVERLAY
1911:     *==========================================================================
1912: 
1913:     PROCEDURE BtnCancelaLin1Click
1914:         WITH THIS
1915:             .cmd_4c_Processar.Enabled  = .T.
1916:             .cmd_4c_Cancelar.Enabled   = .T.
1917:             .cmd_4c_Pedras.Enabled     = .T.
1918:             .cmd_4c_TotLinha.Enabled   = .T.
1919:             .cmd_4c_Disponivel.Enabled = .T.
1920:             .cnt_4c_Container1.Visible = .F.
1921:             .cnt_4c_Container3.Enabled = .T.
1922:             .grd_4c_Dados.Enabled      = .T.
1923:             .grd_4c_Dados.ZOrder
1924:             .grd_4c_Dados.Refresh
1925:             .grd_4c_Dados.Column6.SetFocus
1926:         ENDWITH
1927:     ENDPROC
1928: 
1929:     PROCEDURE BtnCancelaDisp2Click
1930:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
1931:         LOCAL loc_lSucesso
1932:         loc_lSucesso = .F.
1933: 
1934:         TRY
1935:             IF USED("TmpDisp") AND USED("TmpFinal")
1936:                 SELECT TmpDisp
1937:                 SUM Utilizar TO loc_nQtdUtil
1938: 
1939:                 IF loc_nQtdUtil > 0
1940:                     SELECT TmpDisp
1941:                     SCAN
1942:                         IF Utilizar = 0
1943:                             LOOP
1944:                         ENDIF
1945:                         loc_nQtUtil = Utilizar
1946:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1947:                         SELECT TmpFinal
1948:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1949:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1950: 
1951:                         SELECT TmpSaldo
1952:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1953: 
1954:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1955:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1956:                         ENDIF
1957:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1958: 
1959:                         SELECT TmpSaldG
1960:                         SET ORDER TO Cpros
1961:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1962:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1963: 
1964:                         SELECT TmpDisp
1965:                     ENDSCAN
1966:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1967:                 ENDIF
1968:                 loc_lSucesso = .T.
1969:             ENDIF

*-- Linhas 1976 a 2109:
1976:             .cmd_4c_Cancelar.Enabled   = .T.
1977:             .cmd_4c_TotLinha.Enabled   = .T.
1978:             .cmd_4c_SelEstoque.Enabled = .T.
1979:             .cmd_4c_Pedras.Enabled     = .T.
1980:             .cmd_4c_Disponivel.Enabled = .T.
1981:             .cnt_4c_Container3.Enabled = .T.
1982:             .cnt_4c_Container2.Visible = .F.
1983:             .grd_4c_Dados.Enabled      = .T.
1984:             .grd_4c_Dados.ZOrder
1985:             .grd_4c_Dados.Refresh
1986:             .grd_4c_Dados.Column6.SetFocus
1987:         ENDWITH
1988:     ENDPROC
1989: 
1990:     PROCEDURE BtnCancelaDisp4Click
1991:         WITH THIS
1992:             .cmd_4c_Processar.Enabled  = .T.
1993:             .cmd_4c_Cancelar.Enabled   = .T.
1994:             .cmd_4c_TotLinha.Enabled   = .T.
1995:             .cmd_4c_Pedras.Enabled     = .T.
1996:             .cmd_4c_Disponivel.Enabled = .T.
1997:             .cnt_4c_Container3.Enabled = .T.
1998:             .cnt_4c_Container4.Visible = .F.
1999:             .grd_4c_Dados.Enabled      = .T.
2000:             .grd_4c_Dados.ZOrder
2001:             .grd_4c_Dados.Refresh
2002:             .grd_4c_Dados.Column6.SetFocus
2003:         ENDWITH
2004:     ENDPROC
2005: 
2006:     PROCEDURE BtnCancelaDisp5Click
2007:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
2008: 
2009:         TRY
2010:             IF USED("TmpDisp") AND USED("TmpFinal")
2011:                 SELECT TmpDisp
2012:                 SUM Utilizar TO loc_nQtdUtil
2013: 
2014:                 IF loc_nQtdUtil > 0
2015:                     SELECT TmpDisp
2016:                     SCAN
2017:                         IF Utilizar = 0
2018:                             LOOP
2019:                         ENDIF
2020:                         loc_nQtUtil = Utilizar
2021:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2022: 
2023:                         SELECT TmpFinal
2024:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2025:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2026: 
2027:                         SELECT TmpSaldo
2028:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2029: 
2030:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2031:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2032:                         ENDIF
2033:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2034: 
2035:                         SELECT TmpSaldG
2036:                         SET ORDER TO Cpros
2037:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2038:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2039: 
2040:                         SELECT TmpDisp
2041:                     ENDSCAN
2042:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2043:                 ENDIF
2044:             ENDIF
2045:         CATCH TO loc_oErro
2046:             MsgErro(loc_oErro.Message, "Erro")
2047:         ENDTRY
2048: 
2049:         WITH THIS
2050:             .cmd_4c_Processar.Enabled  = .T.
2051:             .cmd_4c_Cancelar.Enabled   = .T.
2052:             .cmd_4c_TotLinha.Enabled   = .T.
2053:             .cmd_4c_Disponivel.Enabled = .T.
2054:             .cmd_4c_SelEstoque.Enabled = .T.
2055:             .cmd_4c_Pedras.Enabled     = .T.
2056:             .cnt_4c_Container3.Enabled = .T.
2057:             .cnt_4c_Container5.Visible = .F.
2058:             .grd_4c_Dados.Enabled      = .T.
2059:             .grd_4c_Dados.ZOrder
2060:             .grd_4c_Dados.Refresh
2061:             .grd_4c_Dados.Column6.SetFocus
2062:         ENDWITH
2063:     ENDPROC
2064: 
2065:     *==========================================================================
2066:     * HANDLERS DE EVENTOS DO GRID PRINCIPAL (GradeItens)
2067:     *==========================================================================
2068: 
2069:     PROCEDURE GradeItensAfterRowColChange
2070:         LPARAMETERS par_nColIndex
2071:         LOCAL loc_cSQL, loc_lcArquivo, loc_lcFoto, loc_nSal, loc_nEst, loc_nPrz
2072: 
2073:         TRY
2074:             IF !USED("TmpFinal") OR EOF("TmpFinal")
2075:                 RETURN
2076:             ENDIF
2077: 
2078:             THIS.obj_4c_ObsItens.Refresh
2079:             THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
2080: 
2081:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2082: 
2083:             SELECT TmpSaldG
2084:             SET ORDER TO Cpros
2085:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2086:             GO TOP
2087: 
2088:             WITH THIS.cnt_4c_Container3
2089:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2090:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2091:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2092:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2093:                 ENDIF
2094: 
2095:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2096:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2097:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2098: 
2099:                 .grd_4c_Dados.Refresh
2100:                 .Visible     = .T.
2101:             ENDWITH
2102: 
2103:             *-- Foto do produto
2104:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2105:                        ALLTRIM(TmpFinal.CPros) + "'"
2106:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2107:                 CLEAR RESOURCES
2108:                 THIS.img_4c_ImgFigJpg.Picture = ""
2109:                 THIS.img_4c_ImgFigJpg.Visible = .F.

*-- Linhas 2130 a 2856:
2130:         ENDTRY
2131:     ENDPROC
2132: 
2133:     PROCEDURE GrdCol6TextWhen
2134:         LOCAL loc_lPermite
2135:         loc_lPermite = .T.
2136: 
2137:         TRY
2138:             IF USED("TmpFinal")
2139:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2140: 
2141:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2142:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2143:                                ALLTRIM(TmpFinal.CPros) + "'"
2144:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2145:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2146:                                    ALLTRIM(xTempPro.CGrus) + "'"
2147:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2148:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2149:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2150:                             ENDIF
2151:                             IF USED("xTempGru")
2152:                                 USE IN xTempGru
2153:                             ENDIF
2154:                         ENDIF
2155:                         IF USED("xTempPro")
2156:                             USE IN xTempPro
2157:                         ENDIF
2158:                     ENDIF
2159:                 ENDIF
2160:             ENDIF
2161:         CATCH TO loc_oErro
2162:             MsgErro(loc_oErro.Message, "Erro")
2163:         ENDTRY
2164: 
2165:         RETURN loc_lPermite
2166:     ENDPROC
2167: 
2168:     PROCEDURE GrdCol6TextValid
2169:         LOCAL loc_lValido, loc_nNewValue, loc_nOld, loc_xBaixa
2170: 
2171:         loc_lValido  = .T.
2172:         loc_nNewValue = THIS.grd_4c_Dados.Column6.Text1.Value
2173:         loc_nOld      = THIS.this_nOldValue
2174: 
2175:         TRY
2176:             IF !USED("TmpFinal") OR !USED("TmpSaldo")
2177:                 loc_lResultado = .T.
2178:             ENDIF
2179: 
2180:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2181:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2182:             ENDIF
2183: 
2184:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2185:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2186:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2187:                     *-- Continue
2188:                 ELSE
2189:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2190:                     loc_lValido = .F.
2191:                 ENDIF
2192:             ENDIF
2193: 
2194:             IF loc_lValido
2195:                 DO CASE
2196:                     CASE loc_nNewValue = loc_nOld
2197:                         *-- nada a fazer
2198:                     CASE loc_nNewValue < 0
2199:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
2200:                         THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2201:                     CASE loc_nNewValue > TmpFinal.Saldo
2202:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
2203:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
2204:                     CASE !SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") AND ;
2205:                          TmpFinal.Produzir <> TmpFinal.Saldo
2206:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2207:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo
2208:                     OTHERWISE
2209:                         IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNewValue
2210:                             REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
2211:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2212:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2213: 
2214:                             SELECT TmpSaldo
2215:                             loc_xBaixa = Saldo - Disps
2216:                             SELECT TmpSaldG
2217:                             SET ORDER TO Cpros
2218:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2219:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2220:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2221:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2222:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2223:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2224:                                     m.loc_xBaixa = 0
2225:                                 ELSE
2226:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2227:                                     REPLACE TmpSaldG.Disps WITH 0
2228:                                 ENDIF
2229:                             ENDSCAN
2230:                         ELSE
2231:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2232:                             THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2233:                         ENDIF
2234:                 ENDCASE
2235:             ENDIF
2236:         CATCH TO loc_oErro
2237:             MsgErro(loc_oErro.Message, "Erro")
2238:         ENDTRY
2239: 
2240:         RETURN loc_lValido
2241:     ENDPROC
2242: 
2243:     PROCEDURE GrdCol6TextLostFocus
2244:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2245:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz
2246: 
2247:         TRY
2248:             IF USED("TmpFinal")
2249:                 SELECT TmpFinal
2250:                 loc_nRecno = RECNO()
2251:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2252:                 GO loc_nRecno
2253:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2254:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2255:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2256:                 THIS.txt_4c_Tot_Qtd.Refresh
2257:                 THIS.txt_4c_Tot_Est.Refresh
2258:                 THIS.txt_4c_Tot_Prz.Refresh
2259:                 THIS.Refresh
2260:             ENDIF
2261:         CATCH TO loc_oErro
2262:             MsgErro(loc_oErro.Message, "Erro")
2263:         ENDTRY
2264:     ENDPROC
2265: 
2266:     *==========================================================================
2267:     * HANDLERS DOS GRIDS DE CONTAINERS OVERLAY
2268:     *==========================================================================
2269: 
2270:     PROCEDURE Cnt5GradeAfterRowColChange
2271:         LPARAMETERS par_nColIndex
2272:         LOCAL loc_cSQL
2273: 
2274:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2275:     ENDPROC
2276: 
2277:     PROCEDURE Cnt5Col5TextValid
2278:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2279: 
2280:         loc_lValido = .T.
2281: 
2282:         TRY
2283:             loc_nVal = THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value
2284: 
2285:             IF loc_nVal > TmpDisp.Disps
2286:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Disponivel...", "")
2287:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2288:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2289:                 loc_lValido = .F.
2290:             ELSE
2291:                 IF loc_nVal < 0
2292:                     MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
2293:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2294:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2295:                     loc_lValido = .F.
2296:                 ELSE
2297:                     loc_nRecno = RECNO("TmpDisp")
2298:                     SUM TmpDisp.Utilizar TO loc_nQtdUtil
2299:                     GO loc_nRecno IN TmpDisp
2300:                     IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo - TmpFinal.Estoque
2301:                         MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
2302:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2303:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2304:                         loc_lValido = .F.
2305:                     ELSE
2306:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2307:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Refresh
2308:                     ENDIF
2309:                 ENDIF
2310:             ENDIF
2311:         CATCH TO loc_oErro
2312:             MsgErro(loc_oErro.Message, "Erro")
2313:         ENDTRY
2314: 
2315:         RETURN loc_lValido
2316:     ENDPROC
2317: 
2318:     PROCEDURE Cnt2Col5TextValid
2319:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2320: 
2321:         loc_lValido = .T.
2322: 
2323:         TRY
2324:             loc_nVal = THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value
2325: 
2326:             IF loc_nVal > TmpDisp.Disps
2327:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
2328:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2329:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2330:                 loc_lValido = .F.
2331:             ELSE
2332:                 loc_nRecno = RECNO("TmpDisp")
2333:                 SUM TmpDisp.Utilizar TO loc_nQtdUtil
2334:                 GO loc_nRecno IN TmpDisp
2335:                 IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo
2336:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
2337:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2338:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2339:                     loc_lValido = .F.
2340:                 ELSE
2341:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2342:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Refresh
2343:                 ENDIF
2344:             ENDIF
2345:         CATCH TO loc_oErro
2346:             MsgErro(loc_oErro.Message, "Erro")
2347:         ENDTRY
2348: 
2349:         RETURN loc_lValido
2350:     ENDPROC
2351: 
2352:     PROCEDURE Cnt4Col1TextValid
2353:         LOCAL loc_lValido, loc_cVal, loc_cSQL
2354: 
2355:         loc_lValido = .T.
2356: 
2357:         TRY
2358:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2359:             IF !EMPTY(loc_cVal)
2360:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2361:                            EscaparSQL(loc_cVal)
2362:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2363:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2364:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2365:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2366:                 ELSE
2367:                     *-- Abrir picker (FormBuscaAuxiliar)
2368:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2369:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2370:                                              "CPros", "DPros"
2371:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2372:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2373:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2374:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2375:                     ENDIF
2376:                 ENDIF
2377:                 IF USED("crListaRemota")
2378:                     USE IN crListaRemota
2379:                 ENDIF
2380:                 THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
2381:             ENDIF
2382:         CATCH TO loc_oErro
2383:             MsgErro(loc_oErro.Message, "Erro")
2384:         ENDTRY
2385: 
2386:         RETURN loc_lValido
2387:     ENDPROC
2388: 
2389:     *==========================================================================
2390:     PROCEDURE GrdColXGotFocus
2391:     *==========================================================================
2392:         IF VARTYPE(THIS.grd_4c_Dados) = "O" AND VARTYPE(THIS.grd_4c_Dados.Column6) = "O"
2393:             THIS.grd_4c_Dados.Column6.Text1.SetFocus()
2394:         ENDIF
2395:     ENDPROC
2396: 
2397:     *==========================================================================
2398:     PROCEDURE Cnt2GrdColXGotFocus
2399:     *==========================================================================
2400:         LOCAL loc_oGrd
2401:         loc_oGrd = THIS.cnt_4c_Container2.grd_4c_Dados
2402:         IF VARTYPE(loc_oGrd) = "O" AND VARTYPE(loc_oGrd.Column5) = "O"
2403:             loc_oGrd.Column5.Text1.SetFocus()
2404:         ENDIF
2405:     ENDPROC
2406: 
2407:     *==========================================================================
2408:     PROCEDURE Cnt4Col4TextWhen
2409:     *==========================================================================
2410:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2411:     ENDPROC
2412: 
2413:     *==========================================================================
2414:     PROCEDURE Cnt4Col5TextWhen
2415:     *==========================================================================
2416:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2417:     ENDPROC
2418: 
2419:     *==========================================================================
2420:     PROCEDURE Cnt4Col5TextValid
2421:     *==========================================================================
2422:         LOCAL loc_lValido, loc_cVal, loc_cSQL, loc_oBusca
2423:         loc_lValido = .T.
2424: 
2425:         TRY
2426:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2427:             IF !EMPTY(loc_cVal)
2428:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2429:                            EscaparSQL(loc_cVal)
2430:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2431:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2432:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2433:                 ELSE
2434:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2435:                                              "crListaPro2", "CPros", loc_cVal, ;
2436:                                              "Produto Substituto")
2437:                     IF VARTYPE(loc_oBusca) = "O"
2438:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2439:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2440:                         loc_oBusca.Show()
2441:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2442:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2443:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2444:                         ELSE
2445:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""
2446:                             REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2447:                         ENDIF
2448:                         loc_oBusca = .NULL.
2449:                     ENDIF
2450:                 ENDIF
2451:                 IF USED("crListaPro2")
2452:                     USE IN crListaPro2
2453:                 ENDIF
2454:             ELSE
2455:                 REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2456:             ENDIF
2457:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh()
2458:         CATCH TO loc_oErro
2459:             MsgErro(loc_oErro.Message, "Erro")
2460:         ENDTRY
2461: 
2462:         RETURN loc_lValido
2463:     ENDPROC
2464: 
2465:     *==========================================================================
2466:     * Cnt3GradeAfterRowColChange - Atualiza descricoes de grupo/conta ao mudar
2467:     * de linha no grid de saldo (Container3.grd_4c_Dados / TmpSaldG)
2468:     *==========================================================================
2469:     PROCEDURE Cnt3GradeAfterRowColChange
2470:         LPARAMETERS par_nColIndex
2471:         LOCAL loc_cSQL
2472: 
2473:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2474:     ENDPROC
2475: 
2476:     *==========================================================================
2477:     * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
2478:     * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
2479:     * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)
2480:     * par_cModo          : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
2481:     * par_cCursorDados   : alias do cursor de dados (opcional - verifica se vazio)
2482:     *==========================================================================
2483:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
2484:         LOCAL loc_cArqFrx, loc_cOldPoint, loc_cOldSep, loc_oErro
2485: 
2486:         par_cRelatorioBase = STRTRAN(UPPER(par_cRelatorioBase), ".FRX", "")
2487:         loc_cArqFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
2488: 
2489:         IF !FILE(loc_cArqFrx)
2490:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
2491:                     loc_cArqFrx, "Relat" + CHR(243) + "rio")
2492:             RETURN
2493:         ENDIF
2494: 
2495:         IF !EMPTY(par_cCursorDados)
2496:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2497:                 MsgAviso("Nenhum dado para exibir.")
2498:                 RETURN
2499:             ENDIF
2500:         ENDIF
2501: 
2502:         loc_cOldPoint = SET("POINT")
2503:         loc_cOldSep   = SET("SEPARATOR")
2504: 
2505:         TRY
2506:             SET POINT TO "."
2507:             SET SEPARATOR TO ","
2508:             SET REPORTBEHAVIOR 80
2509:             DO CASE
2510:                 CASE par_cModo = "PREVIEW"
2511:                     REPORT FORM (loc_cArqFrx) PREVIEW
2512:                 CASE par_cModo = "PRINTER_PROMPT"
2513:                     REPORT FORM (loc_cArqFrx) TO PRINTER PROMPT
2514:                 CASE par_cModo = "PRINTER"
2515:                     REPORT FORM (loc_cArqFrx) TO PRINTER
2516:                 OTHERWISE
2517:                     REPORT FORM (loc_cArqFrx) PREVIEW
2518:             ENDCASE
2519:         CATCH TO loc_oErro
2520:             MsgErro("Erro relat" + CHR(243) + "rio: " + loc_oErro.Message, "Relat" + CHR(243) + "rio")
2521:         ENDTRY
2522: 
2523:         SET POINT TO (loc_cOldPoint)
2524:         SET SEPARATOR TO (loc_cOldSep)
2525:     ENDPROC
2526: 
2527:     *==========================================================================
2528:     * EVENTOS PRINCIPAIS (CRUD-nomeados) - Form OPERACIONAL "Previa da Globalizacao"
2529:     * Este form nao possui botoes CRUD literais (Incluir/Alterar/Visualizar/Excluir),
2530:     * mas os handlers sao expostos como aliases das acoes operacionais equivalentes
2531:     * para uso por integradores externos (menus, chamadas automatizadas, testes).
2532:     *==========================================================================
2533: 
2534:     PROCEDURE BtnIncluirClick
2535:         *-- INCLUIR (novo processamento): executa Processar (fluxo principal)
2536:         TRY
2537:             THIS.BtnProcessarClick()
2538:         CATCH TO loc_oErro
2539:             MsgErro(loc_oErro.Message, "Erro")
2540:         ENDTRY
2541:     ENDPROC
2542: 
2543:     PROCEDURE BtnAlterarClick
2544:         *-- ALTERAR (recalcular totais da grade principal a partir de TmpFinal)
2545:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2546: 
2547:         TRY
2548:             IF USED("TmpFinal")
2549:                 SELECT TmpFinal
2550:                 loc_nRecno = RECNO()
2551:                 loc_nSal = 0
2552:                 loc_nEst = 0
2553:                 loc_nPrz = 0
2554:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2555:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2556:                     GO loc_nRecno IN TmpFinal
2557:                 ENDIF
2558: 
2559:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2560:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2561:                     THIS.txt_4c_Tot_Qtd.Refresh()
2562:                 ENDIF
2563:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2564:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
2565:                     THIS.txt_4c_Tot_Est.Refresh()
2566:                 ENDIF
2567:                 IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2568:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2569:                     THIS.txt_4c_Tot_Prz.Refresh()
2570:                 ENDIF
2571:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
2572:                     THIS.grd_4c_Dados.Refresh()
2573:                 ENDIF
2574:                 THIS.Refresh()
2575:             ENDIF
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     PROCEDURE BtnVisualizarClick
2582:         *-- VISUALIZAR: emite o relatorio da previa (equivalente ao btnRelatorio)
2583:         TRY
2584:             THIS.BtnRelatorioClick()
2585:         CATCH TO loc_oErro
2586:             MsgErro(loc_oErro.Message, "Erro")
2587:         ENDTRY
2588:     ENDPROC
2589: 
2590:     PROCEDURE BtnExcluirClick
2591:         *-- EXCLUIR (cancelar processamento em andamento): rollback + release
2592:         TRY
2593:             IF MsgConfirma("Cancelar o processamento atual?", "Confirma" + CHR(231) + CHR(227) + "o")
2594:                 THIS.BtnCancelarClick()
2595:             ENDIF
2596:         CATCH TO loc_oErro
2597:             MsgErro(loc_oErro.Message, "Erro")
2598:         ENDTRY
2599:     ENDPROC
2600: 
2601:     *==========================================================================
2602:     * BtnBuscarClick - Rebusca / reexibe os dados atuais
2603:     * Para form OPERACIONAL sem filtros editaveis pelo usuario, "Buscar"
2604:     * equivale a atualizar os totais e o binding do grid principal a partir
2605:     * dos cursores TmpFinal/TmpSaldo/TmpSaldG ja carregados pelo form pai.
2606:     *==========================================================================
2607:     PROCEDURE BtnBuscarClick
2608:         TRY
2609:             THIS.CarregarDados()
2610:             IF USED("TmpFinal")
2611:                 LOCAL loc_nSal, loc_nEst, loc_nPrz
2612:                 loc_nSal = 0
2613:                 loc_nEst = 0
2614:                 loc_nPrz = 0
2615:                 SELECT TmpFinal
2616:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2617:                 GO TOP
2618:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2619:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2620:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2621:             ENDIF
2622:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2623:                 THIS.grd_4c_Dados.Refresh()
2624:             ENDIF
2625:         CATCH TO loc_oErro
2626:             MsgErro(loc_oErro.Message, "Erro")
2627:         ENDTRY
2628:     ENDPROC
2629: 
2630:     *==========================================================================
2631:     * BtnEncerrarClick - Encerra / fecha o form sem processar
2632:     * Equivalente ao botao Sair/Cancelar do legado.
2633:     *==========================================================================
2634:     PROCEDURE BtnEncerrarClick
2635:         TRY
2636:             IF VARTYPE(THIS.poFormPai) = "O"
2637:                 THIS.poFormPai.Enabled = .T.
2638:             ENDIF
2639:             THIS.Release
2640:         CATCH TO loc_oErro
2641:             MsgErro(loc_oErro.Message, "Erro")
2642:         ENDTRY
2643:     ENDPROC
2644: 
2645:     *==========================================================================
2646:     * BtnSalvarClick - Salva / confirma o processamento
2647:     * Para form OPERACIONAL "Previa da Globalizacao", salvar equivale a
2648:     * executar o processamento completo (botao Processar do legado).
2649:     *==========================================================================
2650:     PROCEDURE BtnSalvarClick
2651:         TRY
2652:             THIS.BtnProcessarClick()
2653:         CATCH TO loc_oErro
2654:             MsgErro(loc_oErro.Message, "Erro")
2655:         ENDTRY
2656:     ENDPROC
2657: 
2658:     *==========================================================================
2659:     * CarregarLista - Alias canonico para CarregarDados (compatibilidade FormBase)
2660:     * Forms CRUD chamam CarregarLista; em OPERACIONAL delega para CarregarDados.
2661:     *==========================================================================
2662:     PROCEDURE CarregarLista
2663:         TRY
2664:             THIS.CarregarDados()
2665:         CATCH TO loc_oErro
2666:             MsgErro(loc_oErro.Message, "Erro")
2667:         ENDTRY
2668:     ENDPROC
2669: 
2670:     *==========================================================================
2671:     * FormParaBO - Transfere estado do form para o BO
2672:     * Em form OPERACIONAL as propriedades relevantes sao flags de contexto
2673:     * (lReserva, lAutomatico, nNumeroDaOp) e datas obtidas do form pai.
2674:     *==========================================================================
2675:     PROCEDURE FormParaBO
2676:         TRY
2677:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2678:                 RETURN
2679:             ENDIF
2680:             WITH THIS.this_oBusinessObject
2681:                 .this_lReserva    = THIS.this_lReserva
2682:                 .this_lAutomatico = THIS.this_lAutomatico
2683:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
2684:                 .this_nEmphPdr    = THIS.this_nEmphPdr
2685:                 .this_dData       = THIS.this_dData
2686: 
2687:                 *-- Datas de previsao/geracao obtidas do form avo (se existir)
2688:                 IF VARTYPE(THIS.poFormPai) = "O"
2689:                     TRY
2690:                         IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
2691:                             .this_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
2692:                             .this_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
2693:                         ENDIF
2694:                     CATCH
2695:                     ENDTRY
2696:                 ENDIF
2697:             ENDWITH
2698:         CATCH TO loc_oErro
2699:             MsgErro(loc_oErro.Message, "Erro")
2700:         ENDTRY
2701:     ENDPROC
2702: 
2703:     *==========================================================================
2704:     * BOParaForm - Atualiza o form com dados/estado do BO
2705:     * Em form OPERACIONAL rebinda grids e atualiza totais a partir dos
2706:     * cursores calculados pelo BO (TmpFinal/TmpSaldo/TmpSaldG).
2707:     *==========================================================================
2708:     PROCEDURE BOParaForm
2709:         LOCAL loc_nSal, loc_nEst, loc_nPrz
2710:         loc_nSal = 0
2711:         loc_nEst = 0
2712:         loc_nPrz = 0
2713: 
2714:         TRY
2715:             THIS.CarregarDados()
2716: 
2717:             IF USED("TmpFinal")
2718:                 SELECT TmpFinal
2719:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2720:                 GO TOP
2721:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2722:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2723:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2724:             ENDIF
2725: 
2726:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2727:                 THIS.grd_4c_Dados.Refresh()
2728:             ENDIF
2729:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2730:                 THIS.cnt_4c_Container3.Refresh()
2731:             ENDIF
2732:             THIS.Refresh()
2733:         CATCH TO loc_oErro
2734:             MsgErro(loc_oErro.Message, "Erro")
2735:         ENDTRY
2736:     ENDPROC
2737: 
2738:     *==========================================================================
2739:     * HabilitarCampos - Habilita ou desabilita controles conforme contexto
2740:     * par_lHabilitar : .T. = habilitar controles editaveis, .F. = somente leitura
2741:     * Para form OPERACIONAL o unico campo editavel pelo usuario e a coluna
2742:     * Produzir (Column6) do grid principal.
2743:     *==========================================================================
2744:     PROCEDURE HabilitarCampos(par_lHabilitar)
2745:         LOCAL loc_lHab
2746:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2747: 
2748:         TRY
2749:             *-- Coluna Produzir do grid principal
2750:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2751:                 IF loc_lHab
2752:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2753:                     IF USED("crSigCdPam")
2754:                         SELECT crSigCdPam
2755:                         IF EMPTY(crSigCdPam.TransfRes)
2756:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2757:                         ELSE
2758:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2759:                         ENDIF
2760:                     ELSE
2761:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2762:                     ENDIF
2763:                 ELSE
2764:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2765:                 ENDIF
2766:             ENDIF
2767: 
2768:             *-- Botoes de acao
2769:             THIS.AjustarBotoesPorModo()
2770:         CATCH TO loc_oErro
2771:             MsgErro(loc_oErro.Message, "Erro")
2772:         ENDTRY
2773:     ENDPROC
2774: 
2775:     *==========================================================================
2776:     * LimparCampos - Zera totais do form sem liberar cursores do form pai
2777:     * Em form OPERACIONAL os cursores pertencem ao form pai; este metodo
2778:     * apenas zera a exibicao de totais e limpa os overlays.
2779:     *==========================================================================
2780:     PROCEDURE LimparCampos
2781:         TRY
2782:             *-- Zerar totalizadores
2783:             IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2784:                 THIS.txt_4c_Tot_Qtd.Value = 0
2785:             ENDIF
2786:             IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2787:                 THIS.txt_4c_Tot_Est.Value = 0
2788:             ENDIF
2789:             IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2790:                 THIS.txt_4c_Tot_Prz.Value = 0
2791:             ENDIF
2792: 
2793:             *-- Zerar totalizadores do Container3 (saldo por grupo/conta)
2794:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2795:                 THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = 0
2796:                 THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = 0
2797:                 THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = 0
2798:                 THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = ""
2799:                 THIS.cnt_4c_Container3.txt_4c__dconta.Value = ""
2800:             ENDIF
2801: 
2802:             *-- Limpar label de observacao
2803:             IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
2804:                 THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2805:             ENDIF
2806: 
2807:             *-- Ocultar overlays flutuantes
2808:             THIS.ConfigurarPaginaLista()
2809:         CATCH TO loc_oErro
2810:             MsgErro(loc_oErro.Message, "Erro")
2811:         ENDTRY
2812:     ENDPROC
2813: 
2814:     *==========================================================================
2815:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme contexto atual
2816:     * Em form OPERACIONAL o "modo" eh determinado pelo estado dos cursores:
2817:     *   - Sem TmpFinal    -> apenas Cancelar disponivel
2818:     *   - Com TmpFinal    -> todos os botoes operacionais disponiveis
2819:     *   - Overlay ativo   -> botoes principais desabilitados (gerenciado pelos
2820:     *                        handlers Btn*Click individuais)
2821:     *==========================================================================
2822:     PROCEDURE AjustarBotoesPorModo
2823:         LOCAL loc_lTemDados, loc_lPodeAcao
2824:         loc_lTemDados = .F.
2825:         loc_lPodeAcao = .F.
2826: 
2827:         TRY
2828:             *-- Verificar se ha dados carregados
2829:             IF USED("TmpFinal")
2830:                 loc_lTemDados = RECCOUNT("TmpFinal") > 0
2831:             ENDIF
2832: 
2833:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2834:             IF loc_lTemDados AND USED("crSigCdPam")
2835:                 SELECT crSigCdPam
2836:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2837:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2838:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2839:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2840:                                 !THIS.this_lReserva
2841:             ENDIF
2842: 
2843:             *-- Aplicar estado aos botoes
2844:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2845:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2846:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2847:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2848:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2849:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2850:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
2851:         CATCH TO loc_oErro
2852:             MsgErro(loc_oErro.Message, "Erro")
2853:         ENDTRY
2854:     ENDPROC
2855: 
2856: ENDDEFINE

