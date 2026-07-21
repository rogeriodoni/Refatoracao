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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2848 linhas total):

*-- Linhas 10 a 422:
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
174:             .Visible     = .T.
175: 
176:             .AddObject("lbl_4c_Sombra", "Label")
177:             WITH .lbl_4c_Sombra
178:                 .AutoSize  = .F.
179:                 .Top       = 18
180:                 .Left      = 10
181:                 .Width     = THIS.Width
182:                 .Height    = 40
183:                 .FontBold  = .T.
184:                 .FontName  = "Tahoma"
185:                 .FontSize  = 18
186:                 .BackStyle = 0
187:                 .ForeColor = RGB(0, 0, 0)
188:                 .Caption   = " "
189:             ENDWITH
190: 
191:             .AddObject("lbl_4c_Titulo", "Label")
192:             WITH .lbl_4c_Titulo
193:                 .AutoSize  = .F.
194:                 .Top       = 17
195:                 .Left      = 10
196:                 .Width     = THIS.Width
197:                 .Height    = 46
198:                 .FontBold  = .T.
199:                 .FontName  = "Tahoma"
200:                 .FontSize  = 18
201:                 .BackStyle = 0
202:                 .ForeColor = RGB(255, 255, 255)
203:                 .Caption   = " "
204:             ENDWITH
205:         ENDWITH
206:     ENDPROC
207: 
208:     *==========================================================================
209:     PROTECTED PROCEDURE ConfigurarLayout
210:     *==========================================================================
211:         LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio
212:         LOCAL loc_cImgDisp, loc_cImgLinhas, loc_cImgPedras, loc_cImgEstoque
213: 
214:         loc_cImgProcessar  = gc_4c_CaminhoIcones + "geral_executar_60.jpg"
215:         loc_cImgCancelar   = gc_4c_CaminhoIcones + "cadastro_encerrar_60.jpg"
216:         loc_cImgRelatorio  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
217:         loc_cImgDisp       = gc_4c_CaminhoIcones + "geral_pesquisar_60.jpg"
218:         loc_cImgLinhas     = gc_4c_CaminhoIcones + "geral_lista_60.jpg"
219:         loc_cImgPedras     = gc_4c_CaminhoIcones + "geral_adicionar_60.jpg"
220:         loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"
221: 
222:         *-- Botao Disponiveis (622,3,75,75)
223:         THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
224:         WITH THIS.cmd_4c_Disponivel
225:             .Top         = 3
226:             .Left        = 622
227:             .Width       = 75
228:             .Height      = 75
229:             .Caption     = "\<Dispon" + CHR(237) + "veis"
230:             .FontBold    = .T.
231:             .FontItalic  = .T.
232:             .FontName    = "Tahoma"
233:             .FontSize    = 8
234:             .WordWrap    = .T.
235:             .ForeColor   = RGB(90, 90, 90)
236:             .BackColor   = RGB(255, 255, 255)
237:             .Themes      = .T.
238:             IF FILE(loc_cImgDisp)
239:                 .Picture         = loc_cImgDisp
240:                 .DisabledPicture = loc_cImgDisp
241:             ENDIF
242:         ENDWITH
243:         BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")
244: 
245:         *-- Botao Total/Linhas (697,3,75,75)
246:         THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
247:         WITH THIS.cmd_4c_TotLinha
248:             .Top         = 3
249:             .Left        = 697
250:             .Width       = 75
251:             .Height      = 75
252:             .Caption     = "\<Total/Linhas"
253:             .FontBold    = .T.
254:             .FontItalic  = .T.
255:             .FontName    = "Tahoma"
256:             .FontSize    = 8
257:             .WordWrap    = .T.
258:             .ForeColor   = RGB(90, 90, 90)
259:             .BackColor   = RGB(255, 255, 255)
260:             .Themes      = .T.
261:             IF FILE(loc_cImgLinhas)
262:                 .Picture         = loc_cImgLinhas
263:                 .DisabledPicture = loc_cImgLinhas
264:             ENDIF
265:         ENDWITH
266:         BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
267: 
268:         *-- Botao Pedras/Requisicoes (472,3,75,75)
269:         THIS.AddObject("cmd_4c_Pedras", "CommandButton")
270:         WITH THIS.cmd_4c_Pedras
271:             .Top         = 3
272:             .Left        = 472
273:             .Width       = 75
274:             .Height      = 75
275:             .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
276:             .FontBold    = .T.
277:             .FontItalic  = .T.
278:             .FontName    = "Tahoma"
279:             .FontSize    = 8
280:             .WordWrap    = .T.
281:             .ForeColor   = RGB(90, 90, 90)
282:             .BackColor   = RGB(255, 255, 255)
283:             .Themes      = .T.
284:             IF FILE(loc_cImgPedras)
285:                 .Picture         = loc_cImgPedras
286:                 .DisabledPicture = loc_cImgPedras
287:             ENDIF
288:         ENDWITH
289:         BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
290: 
291:         *-- Botao SelEstoque (547,3,75,75)
292:         THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
293:         WITH THIS.cmd_4c_SelEstoque
294:             .Top         = 3
295:             .Left        = 547
296:             .Width       = 75
297:             .Height      = 75
298:             .Caption     = "\<Estoques"
299:             .FontBold    = .T.
300:             .FontItalic  = .T.
301:             .FontName    = "Tahoma"
302:             .FontSize    = 8
303:             .WordWrap    = .T.
304:             .ForeColor   = RGB(90, 90, 90)
305:             .BackColor   = RGB(255, 255, 255)
306:             .Themes      = .T.
307:             .Enabled     = .F.
308:             IF FILE(loc_cImgEstoque)
309:                 .Picture         = loc_cImgEstoque
310:                 .DisabledPicture = loc_cImgEstoque
311:             ENDIF
312:         ENDWITH
313:         BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
314: 
315:         *-- Botao Relatorio (772,3,75,75)
316:         THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
317:         WITH THIS.cmd_4c_BtnRelatorio
318:             .Top         = 3
319:             .Left        = 772
320:             .Width       = 75
321:             .Height      = 75
322:             .Caption     = "\<Relat" + CHR(243) + "rio"
323:             .FontBold    = .T.
324:             .FontItalic  = .T.
325:             .FontName    = "Tahoma"
326:             .FontSize    = 8
327:             .WordWrap    = .T.
328:             .ForeColor   = RGB(90, 90, 90)
329:             .BackColor   = RGB(255, 255, 255)
330:             .Themes      = .T.
331:             IF FILE(loc_cImgRelatorio)
332:                 .Picture         = loc_cImgRelatorio
333:                 .DisabledPicture = loc_cImgRelatorio
334:             ENDIF
335:         ENDWITH
336:         BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
337: 
338:         *-- Botao Processar (847,3,75,75)
339:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
340:         WITH THIS.cmd_4c_Processar
341:             .Top         = 3
342:             .Left        = 847
343:             .Width       = 75
344:             .Height      = 75
345:             .Caption     = "\<Processar"
346:             .FontBold    = .T.
347:             .FontItalic  = .T.
348:             .FontName    = "Tahoma"
349:             .FontSize    = 8
350:             .WordWrap    = .T.
351:             .ForeColor   = RGB(90, 90, 90)
352:             .BackColor   = RGB(255, 255, 255)
353:             .Themes      = .T.
354:             IF FILE(loc_cImgProcessar)
355:                 .Picture         = loc_cImgProcessar
356:                 .DisabledPicture = loc_cImgProcessar
357:             ENDIF
358:         ENDWITH
359:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
360: 
361:         *-- Botao Sair/Cancelar (922,3,75,75)
362:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
363:         WITH THIS.cmd_4c_Cancelar
364:             .Top         = 3
365:             .Left        = 922
366:             .Width       = 75
367:             .Height      = 75
368:             .Caption     = "Encerrar"
369:             .FontBold    = .T.
370:             .FontItalic  = .T.
371:             .FontName    = "Tahoma"
372:             .FontSize    = 8
373:             .WordWrap    = .T.
374:             .ForeColor   = RGB(90, 90, 90)
375:             .BackColor   = RGB(255, 255, 255)
376:             .Themes      = .T.
377:             IF FILE(loc_cImgCancelar)
378:                 .Picture         = loc_cImgCancelar
379:                 .DisabledPicture = loc_cImgCancelar
380:             ENDIF
381:         ENDWITH
382:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
383: 
384:         *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
385:         THIS.AddObject("grd_4c_Dados", "Grid")
386:         WITH THIS.grd_4c_Dados
387:             .Top              = 125
388:             .Left             = 11
389:             .Width            = 708
390:             .Height           = 224
391:             .ColumnCount      = 9
392:             .AllowHeaderSizing = .F.
393:             .AllowRowSizing    = .F.
394:             .DeleteMark        = .F.
395:             .RecordMark        = .F.
396:             .ScrollBars        = 3
397:             .RowHeight         = 16
398:             .GridLineColor     = RGB(238, 238, 238)
399:             .FontName          = "Tahoma"
400:             .FontSize          = 8
401:             *-- Col1: Produto
402:             WITH .Column1
403:                 .Width          = 80
404:                 .ReadOnly       = .T.
405:                 .Movable        = .F.
406:                 .Resizable      = .F.
407:                 .Header1.Caption = "Produto"
408:                 .Header1.FontName = "Verdana"
409:                 .Header1.FontSize = 8
410:                 .Header1.Alignment = 2
411:                 .Header1.ForeColor = RGB(36, 84, 155)
412:             ENDWITH
413:             *-- Col2: Cor
414:             WITH .Column2
415:                 .Width          = 40
416:                 .ReadOnly       = .T.
417:                 .Movable        = .F.
418:                 .Resizable      = .F.
419:                 .Header1.Caption = "Cor"
420:                 .Header1.FontName = "Verdana"
421:                 .Header1.FontSize = 8
422:                 .Header1.Alignment = 2

*-- Linhas 511 a 570:
511:                 .Header1.ForeColor = RGB(36, 84, 155)
512:             ENDWITH
513:         ENDWITH
514:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
515:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "When",      THIS, "GrdCol6TextWhen")
516:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "Valid",     THIS, "GrdCol6TextValid")
517:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "KeyPress", THIS, "GrdCol6TextLostFocus")
518:         *-- Redirecionar foco das colunas somente-leitura para Column6 (editavel)
519:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColXGotFocus")
520:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColXGotFocus")
521:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "GrdColXGotFocus")
522:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GrdColXGotFocus")
523:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GrdColXGotFocus")
524:         BINDEVENT(THIS.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "GrdColXGotFocus")
525:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus", THIS, "GrdColXGotFocus")
526: 
527:         *-- Totais abaixo do grid (349,417-662)
528:         THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
529:         WITH THIS.txt_4c_Tot_Qtd
530:             .Top          = 349
531:             .Left         = 417
532:             .Width        = 80
533:             .Height       = 23
534:             .ReadOnly     = .T.
535:             .FontName     = "Tahoma"
536:             .FontSize     = 8
537:             .SpecialEffect = 1
538:             .Value        = 0
539:         ENDWITH
540: 
541:         THIS.AddObject("txt_4c_Tot_Est", "TextBox")
542:         WITH THIS.txt_4c_Tot_Est
543:             .Top          = 349
544:             .Left         = 498
545:             .Width        = 81
546:             .Height       = 23
547:             .ReadOnly     = .T.
548:             .FontName     = "Tahoma"
549:             .FontSize     = 8
550:             .SpecialEffect = 1
551:             .Value        = 0
552:         ENDWITH
553: 
554:         THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
555:         WITH THIS.txt_4c_Tot_Prz
556:             .Top          = 349
557:             .Left         = 580
558:             .Width        = 82
559:             .Height       = 23
560:             .ReadOnly     = .T.
561:             .FontName     = "Tahoma"
562:             .FontSize     = 8
563:             .SpecialEffect = 1
564:             .Value        = 0
565:         ENDWITH
566: 
567:         *-- Label para observacao (726,369)
568:         THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
569:         WITH THIS.lbl_4c_Txt_ObsItens
570:             .Top       = 369

*-- Linhas 600 a 621:
600:             .Height  = 204
601:             .Visible = .F.
602:         ENDWITH
603: 
604:         *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
605:         THIS.AddObject("cnt_4c_Container3", "Container")
606:         WITH THIS.cnt_4c_Container3
607:             .Top           = 373
608:             .Left          = 12
609:             .Width         = 708
610:             .Height        = 205
611:             .BackColor     = RGB(255, 255, 255)
612:             .SpecialEffect = 0
613:             .BorderWidth   = 1
614:             .Visible       = .T.
615: 
616:             .AddObject("lbl_4c_Label1", "Label")
617:             WITH .lbl_4c_Label1
618:                 .Top       = 5
619:                 .Left      = 6
620:                 .Width     = 118
621:                 .Height    = 16

*-- Linhas 713 a 758:
713:                 .ReadOnly     = .T.
714:                 .SpecialEffect = 1
715:                 .FontSize     = 8
716:             ENDWITH
717: 
718:             .AddObject("txt_4c_Tot_Qtd", "TextBox")
719:             WITH .txt_4c_Tot_Qtd
720:                 .Top          = 173
721:                 .Left         = 188
722:                 .Width        = 80
723:                 .Height       = 23
724:                 .ReadOnly     = .T.
725:                 .SpecialEffect = 1
726:                 .FontSize     = 8
727:                 .Value        = 0
728:             ENDWITH
729: 
730:             .AddObject("txt_4c_Tot_Est", "TextBox")
731:             WITH .txt_4c_Tot_Est
732:                 .Top          = 173
733:                 .Left         = 269
734:                 .Width        = 80
735:                 .Height       = 23
736:                 .ReadOnly     = .T.
737:                 .SpecialEffect = 1
738:                 .FontSize     = 8
739:                 .Value        = 0
740:             ENDWITH
741: 
742:             .AddObject("txt_4c_Tot_Prz", "TextBox")
743:             WITH .txt_4c_Tot_Prz
744:                 .Top          = 173
745:                 .Left         = 350
746:                 .Width        = 80
747:                 .Height       = 23
748:                 .ReadOnly     = .T.
749:                 .SpecialEffect = 1
750:                 .FontSize     = 8
751:                 .Value        = 0
752:             ENDWITH
753: 
754:             .AddObject("lbl_4c_Label2", "Label")
755:             WITH .lbl_4c_Label2
756:                 .Top = 90
757:                 .Left = 454
758:                 .Width = 36

*-- Linhas 775 a 820:
775:                 .Caption = "Conta"
776:                 .FontSize = 8
777:                 .ForeColor = RGB(90, 90, 90)
778:             ENDWITH
779:         ENDWITH
780:         BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")
781: 
782:         *-- Container1: totais por linha (Visible=.F., sobreposicao)
783:         THIS.AddObject("cnt_4c_Container1", "Container")
784:         WITH THIS.cnt_4c_Container1
785:             .Top           = 125
786:             .Left          = 12
787:             .Width         = 708
788:             .Height        = 465
789:             .BackColor     = RGB(255, 255, 255)
790:             .BackStyle     = 1
791:             .SpecialEffect = 0
792:             .Visible       = .F.
793: 
794:             .AddObject("lbl_4c_Label1", "Label")
795:             WITH .lbl_4c_Label1
796:                 .Top = 10
797:                 .Left = 259
798:                 .Width = 170
799:                 .Height = 18
800:                 .AutoSize = .F.
801:                 .BackStyle = 0
802:                 .FontBold = .T.
803:                 .FontName = "Tahoma"
804:                 .FontSize = 10
805:                 .ForeColor = RGB(90, 90, 90)
806:                 .Caption = "Pe" + CHR(231) + "as a produzir por linha"
807:             ENDWITH
808: 
809:             .AddObject("cmd_4c_CancelaLin", "CommandButton")
810:             WITH .cmd_4c_CancelaLin
811:                 .Top = 3
812:                 .Left = 620
813:                 .Width = 75
814:                 .Height = 75
815:                 .Caption = "OK"
816:                 .FontBold = .T.
817:                 .FontItalic = .T.
818:                 .FontName = "Tahoma"
819:                 .FontSize = 8
820:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 868 a 913:
868:                     .Header1.FontSize = 8
869:                     .Header1.ForeColor = RGB(36, 84, 155)
870:                 ENDWITH
871:             ENDWITH
872:         ENDWITH
873:         BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")
874: 
875:         *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
876:         THIS.AddObject("cnt_4c_Container2", "Container")
877:         WITH THIS.cnt_4c_Container2
878:             .Top = 125
879:             .Left = 12
880:             .Width = 708
881:             .Height = 465
882:             .BackColor = RGB(255, 255, 255)
883:             .BackStyle = 1
884:             .SpecialEffect = 0
885:             .Visible = .F.
886: 
887:             .AddObject("lbl_4c_Label1", "Label")
888:             WITH .lbl_4c_Label1
889:                 .Top = 10
890:                 .Left = 284
891:                 .Width = 123
892:                 .Height = 18
893:                 .AutoSize = .F.
894:                 .BackStyle = 0
895:                 .FontBold = .T.
896:                 .FontName = "Tahoma"
897:                 .FontSize = 10
898:                 .ForeColor = RGB(90, 90, 90)
899:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
900:             ENDWITH
901: 
902:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
903:             WITH .cmd_4c_CancelaDisp
904:                 .Top = 3
905:                 .Left = 620
906:                 .Width = 75
907:                 .Height = 75
908:                 .Caption = "Sair"
909:                 .FontBold = .T.
910:                 .FontItalic = .T.
911:                 .FontName = "Tahoma"
912:                 .FontSize = 8
913:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 973 a 1018:
973:                     .Text1.BorderStyle = 0
974:                     .Text1.Alignment = 3
975:                     .Text1.Value = 0
976:                 ENDWITH
977:             ENDWITH
978:             BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")
979: 
980:             .AddObject("lbl_4c_Label2", "Label")
981:             WITH .lbl_4c_Label2
982:                 .Top = 432
983:                 .Left = 168
984:                 .Width = 84
985:                 .Height = 15
986:                 .AutoSize = .F.
987:                 .BackStyle = 0
988:                 .FontSize = 8
989:                 .ForeColor = RGB(90, 90, 90)
990:                 .Caption = "Qtde " + CHR(224) + " Produzir :"
991:             ENDWITH
992: 
993:             .AddObject("lbl_4c_Label3", "Label")
994:             WITH .lbl_4c_Label3
995:                 .Top = 431
996:                 .Left = 365
997:                 .Width = 109
998:                 .Height = 17
999:                 .AutoSize = .F.
1000:                 .BackStyle = 0
1001:                 .FontSize = 8
1002:                 .ForeColor = RGB(90, 90, 90)
1003:                 .Caption = "Qtde " + CHR(224) + " Utilizar :"
1004:             ENDWITH
1005: 
1006:             .AddObject("txt_4c_Qt_pedida", "TextBox")
1007:             WITH .txt_4c_Qt_pedida
1008:                 .Top = 428
1009:                 .Left = 268
1010:                 .Width = 80
1011:                 .Height = 23
1012:                 .ReadOnly = .T.
1013:                 .SpecialEffect = 1
1014:                 .FontSize = 8
1015:                 .Value = 0
1016:             ENDWITH
1017: 
1018:             .AddObject("txt_4c_Qt_Selec", "TextBox")

*-- Linhas 1025 a 1075:
1025:                 .SpecialEffect = 1
1026:                 .FontSize = 8
1027:                 .Value = 0
1028:             ENDWITH
1029:         ENDWITH
1030:         BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
1031:         *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
1032:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1033:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1034:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1035:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1036: 
1037:         *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
1038:         THIS.AddObject("cnt_4c_Container4", "Container")
1039:         WITH THIS.cnt_4c_Container4
1040:             .Top = 125
1041:             .Left = 12
1042:             .Width = 708
1043:             .Height = 465
1044:             .BackColor = RGB(255, 255, 255)
1045:             .BackStyle = 1
1046:             .SpecialEffect = 0
1047:             .Visible = .F.
1048: 
1049:             .AddObject("lbl_4c_Label1", "Label")
1050:             WITH .lbl_4c_Label1
1051:                 .Top = 8
1052:                 .Left = 229
1053:                 .Width = 249
1054:                 .Height = 18
1055:                 .AutoSize = .F.
1056:                 .BackStyle = 0
1057:                 .FontBold = .T.
1058:                 .FontName = "Tahoma"
1059:                 .FontSize = 10
1060:                 .ForeColor = RGB(90, 90, 90)
1061:                 .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1062:             ENDWITH
1063: 
1064:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1065:             WITH .cmd_4c_CancelaDisp
1066:                 .Top = 3
1067:                 .Left = 620
1068:                 .Width = 75
1069:                 .Height = 75
1070:                 .Caption = "Sair"
1071:                 .FontBold = .T.
1072:                 .FontItalic = .T.
1073:                 .FontName = "Tahoma"
1074:                 .FontSize = 8
1075:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1131 a 1180:
1131:                     .Header1.FontSize = 8
1132:                     .Header1.ForeColor = RGB(36, 84, 155)
1133:                 ENDWITH
1134:             ENDWITH
1135:         ENDWITH
1136:         BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
1137:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
1138:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
1139:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
1140:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")
1141: 
1142:         *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
1143:         THIS.AddObject("cnt_4c_Container5", "Container")
1144:         WITH THIS.cnt_4c_Container5
1145:             .Top = 125
1146:             .Left = 12
1147:             .Width = 708
1148:             .Height = 465
1149:             .BackColor = RGB(255, 255, 255)
1150:             .BackStyle = 1
1151:             .SpecialEffect = 0
1152:             .Visible = .F.
1153: 
1154:             .AddObject("lbl_4c_Label1", "Label")
1155:             WITH .lbl_4c_Label1
1156:                 .Top = 10
1157:                 .Left = 284
1158:                 .Width = 123
1159:                 .Height = 18
1160:                 .AutoSize = .F.
1161:                 .BackStyle = 0
1162:                 .FontBold = .T.
1163:                 .FontName = "Tahoma"
1164:                 .FontSize = 10
1165:                 .ForeColor = RGB(90, 90, 90)
1166:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
1167:             ENDWITH
1168: 
1169:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1170:             WITH .cmd_4c_CancelaDisp
1171:                 .Top = 3
1172:                 .Left = 620
1173:                 .Width = 75
1174:                 .Height = 75
1175:                 .Caption = "OK"
1176:                 .FontBold = .T.
1177:                 .FontItalic = .T.
1178:                 .FontName = "Tahoma"
1179:                 .FontSize = 8
1180:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1240 a 1286:
1240:                     .Text1.BorderStyle = 0
1241:                     .Text1.Alignment = 3
1242:                     .Text1.Value = 0
1243:                 ENDWITH
1244:             ENDWITH
1245:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
1246:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")
1247: 
1248:             .AddObject("lbl_4c_Label2", "Label")
1249:             WITH .lbl_4c_Label2
1250:                 .Top = 413
1251:                 .Left = 428
1252:                 .Width = 48
1253:                 .Height = 15
1254:                 .AutoSize = .F.
1255:                 .BackStyle = 0
1256:                 .FontSize = 8
1257:                 .ForeColor = RGB(90, 90, 90)
1258:                 .Caption = "Produzir :"
1259:             ENDWITH
1260: 
1261:             .AddObject("lbl_4c_Label3", "Label")
1262:             WITH .lbl_4c_Label3
1263:                 .Top = 438
1264:                 .Left = 435
1265:                 .Width = 41
1266:                 .Height = 15
1267:                 .AutoSize = .F.
1268:                 .BackStyle = 0
1269:                 .FontSize = 8
1270:                 .ForeColor = RGB(90, 90, 90)
1271:                 .Caption = "Utilizar :"
1272:             ENDWITH
1273: 
1274:             .AddObject("lbl_4c_Label4", "Label")
1275:             WITH .lbl_4c_Label4
1276:                 .Top = 413
1277:                 .Left = 93
1278:                 .Width = 38
1279:                 .Height = 15
1280:                 .AutoSize = .F.
1281:                 .BackStyle = 0
1282:                 .FontSize = 8
1283:                 .ForeColor = RGB(90, 90, 90)
1284:                 .Caption = "Grupo :"
1285:             ENDWITH
1286: 

*-- Linhas 1341 a 1423:
1341:                 .SpecialEffect = 1
1342:                 .FontSize = 8
1343:                 .Value = 0
1344:             ENDWITH
1345:         ENDWITH
1346:         BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")
1347: 
1348:         *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
1349:         THIS.AddObject("shp_4c_Shape2", "Shape")
1350:         WITH THIS.shp_4c_Shape2
1351:             .Top         = 9
1352:             .Left        = 9
1353:             .Width       = 279
1354:             .Height      = 51
1355:             .BackStyle   = 0
1356:             .BorderColor = RGB(255, 255, 255)
1357:             .BorderWidth = 2
1358:             .SpecialEffect = 0
1359:         ENDWITH
1360: 
1361:         *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
1362:         THIS.AddObject("shp_4c_Shape3", "Shape")
1363:         WITH THIS.shp_4c_Shape3
1364:             .Top         = 10
1365:             .Left        = 820
1366:             .Width       = 116
1367:             .Height      = 38
1368:             .BackStyle   = 0
1369:             .BorderColor = RGB(255, 255, 255)
1370:             .BorderWidth = 2
1371:             .SpecialEffect = 0
1372:         ENDWITH
1373:     ENDPROC
1374: 
1375:     *==========================================================================
1376:     * ConfigurarPaginaLista - Restaura a visao principal do form
1377:     *
1378:     * OPERACIONAL: nao ha PageFrame com Page1/Page2 como em CRUD. A "pagina
1379:     * lista" aqui eh o conjunto: grid principal (grd_4c_Dados / TmpFinal) +
1380:     * totais + Container3 (saldo por grupo/conta, sempre visivel). Os overlays
1381:     * (Container1/2/4/5) sao escondidos e as acoes principais reabilitadas.
1382:     *==========================================================================
1383:     PROTECTED PROCEDURE ConfigurarPaginaLista
1384:         LOCAL loc_lPodeAcao
1385: 
1386:         *-- Ocultar overlays flutuantes
1387:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1388:             THIS.cnt_4c_Container1.Visible = .F.
1389:         ENDIF
1390:         IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
1391:             THIS.cnt_4c_Container2.Visible = .F.
1392:         ENDIF
1393:         IF PEMSTATUS(THIS, "cnt_4c_Container4", 5)
1394:             THIS.cnt_4c_Container4.Visible = .F.
1395:         ENDIF
1396:         IF PEMSTATUS(THIS, "cnt_4c_Container5", 5)
1397:             THIS.cnt_4c_Container5.Visible = .F.
1398:         ENDIF
1399: 
1400:         *-- Grid principal e Container3 (saldo) sempre acessiveis
1401:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1402:             THIS.grd_4c_Dados.Enabled = .T.
1403:             THIS.grd_4c_Dados.ZOrder
1404:         ENDIF
1405:         IF PEMSTATUS(THIS, "cnt_4c_Container3", 5)
1406:             THIS.cnt_4c_Container3.Enabled = .T.
1407:         ENDIF
1408: 
1409:         *-- Reabilitar botoes de acao principal
1410:         THIS.cmd_4c_Processar.Enabled  = .T.
1411:         THIS.cmd_4c_Cancelar.Enabled   = .T.
1412:         THIS.cmd_4c_TotLinha.Enabled   = .T.
1413:         THIS.cmd_4c_Disponivel.Enabled = .T.
1414:         THIS.cmd_4c_BtnRelatorio.Enabled = .T.
1415: 
1416:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1417:         loc_lPodeAcao = .F.
1418:         IF USED("crSigCdPam")
1419:             SELECT crSigCdPam
1420:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1421:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1422:                             !THIS.this_lReserva
1423:         ENDIF

*-- Linhas 1440 a 1961:
1440:     * atualiza os bindings e valores exibidos para o registro corrente do grid
1441:     * principal (TmpFinal). E chamado apos mudanca de linha no grid principal.
1442:     *==========================================================================
1443:     PROTECTED PROCEDURE ConfigurarPaginaDados
1444:         LOCAL loc_nSaldo, loc_nEstoque, loc_nProduzir
1445: 
1446:         loc_nSaldo    = 0
1447:         loc_nEstoque  = 0
1448:         loc_nProduzir = 0
1449: 
1450:         *-- Requer TmpFinal e TmpSaldG carregados
1451:         IF !USED("TmpFinal") OR !USED("TmpSaldG")
1452:             RETURN
1453:         ENDIF
1454: 
1455:         *-- Reposicionar TmpSaldG conforme item corrente do grid principal
1456:         SELECT TmpSaldG
1457:         SET ORDER TO Cpros
1458:         SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1459:         GO TOP
1460: 
1461:         *-- Vincular Container3 grid ao cursor de saldo detalhado
1462:         THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1463:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1464:             .Column1.ControlSource = "TmpSaldG.Grupos"
1465:             .Column2.ControlSource = "TmpSaldG.Estos"
1466:             .Column3.ControlSource = "TmpSaldG.Saldo"
1467:             .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1468:             .Column5.ControlSource = "TmpSaldG.Disps"
1469:             .Column6.ControlSource = "TmpSaldG.Emps"
1470:             .SetAll("ReadOnly", .T.)
1471:             .Refresh
1472:         ENDWITH
1473: 
1474:         *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
1475:         IF USED("TmpGrupo")
1476:             THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
1477:         ENDIF
1478:         IF USED("TmpConta")
1479:             THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
1480:         ENDIF
1481: 
1482:         *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
1483:         IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1484:             loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)
1485:             loc_nEstoque  = NVL(TmpSaldo.Saldo, 0) - NVL(TmpSaldo.Disps, 0)
1486:             loc_nProduzir = NVL(TmpSaldo.Disps, 0)
1487:         ENDIF
1488:         THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = loc_nSaldo
1489:         THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = loc_nEstoque
1490:         THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir
1491: 
1492:         *-- Rebind da EditBox de observacao ao item corrente
1493:         THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1494:         THIS.obj_4c_ObsItens.Refresh
1495: 
1496:         *-- Rotulo dinamico da observacao
1497:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1498:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1499:     ENDPROC
1500: 
1501:     *==========================================================================
1502:     * AlternarPagina - Alterna entre a visao principal e os overlays
1503:     *
1504:     * Parametros: par_nPagina
1505:     *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
1506:     *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
1507:     *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
1508:     *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista
1509:     *   4 -> Container4 (Requisicoes)      - equivalente a BtnPedrasClick
1510:     *   5 -> Container5 (Selecao Estoque)  - equivalente a BtnSelEstoqueClick
1511:     *==========================================================================
1512:     PROCEDURE AlternarPagina(par_nPagina)
1513:         LOCAL loc_nPag
1514:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)
1515: 
1516:         DO CASE
1517:             CASE loc_nPag = 1
1518:                 THIS.BtnTotLinhaClick()
1519:             CASE loc_nPag = 2
1520:                 THIS.BtnDisponiveiClick()
1521:             CASE loc_nPag = 4
1522:                 THIS.BtnPedrasClick()
1523:             CASE loc_nPag = 5
1524:                 THIS.BtnSelEstoqueClick()
1525:             OTHERWISE
1526:                 *-- Pagina 0 ou 3: restaurar visao principal
1527:                 THIS.ConfigurarPaginaLista()
1528:         ENDCASE
1529:     ENDPROC
1530: 
1531:     *==========================================================================
1532:     PROTECTED PROCEDURE CarregarDados
1533:     *==========================================================================
1534:         LOCAL loc_lReadOnly
1535: 
1536:         *-- Grid principal: vincular ao TmpFinal
1537:         IF USED("TmpFinal")
1538:             THIS.grd_4c_Dados.RecordSource = "TmpFinal"
1539:             WITH THIS.grd_4c_Dados
1540:                 .Column1.ControlSource = "TmpFinal.Cpros"
1541:                 .Column2.ControlSource = "TmpFinal.CodCors"
1542:                 .Column3.ControlSource = "TmpFinal.Dopes"
1543:                 .Column4.ControlSource = "TmpFinal.Numes"
1544:                 .Column5.ControlSource = "TmpFinal.Saldo"
1545:                 .Column6.ControlSource = "TmpFinal.Produzir"
1546:                 .Column7.ControlSource = "TmpFinal.Estoque"
1547:                 .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
1548:                 .Column9.ControlSource = "TmpFinal.CodTams"
1549:             ENDWITH
1550: 
1551:             *-- Se nao ha operacao de transferencia, grid fica somente leitura
1552:             IF USED("crSigCdPam")
1553:                 SELECT crSigCdPam
1554:                 IF EMPTY(crSigCdPam.TransfRes)
1555:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
1556:                 ENDIF
1557:             ENDIF
1558:         ENDIF
1559: 
1560:         *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
1561:         IF USED("TmpSaldG") AND USED("TmpFinal")
1562:             SELECT TmpSaldG
1563:             SET ORDER TO Cpros
1564:             GO TOP
1565:             IF !EOF("TmpFinal")
1566:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1567:             ENDIF
1568:             GO TOP
1569: 
1570:             THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource = "TmpSaldG"
1571:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1572:                 .Column1.ControlSource = "TmpSaldG.Grupos"
1573:                 .Column2.ControlSource = "TmpSaldG.Estos"
1574:                 .Column3.ControlSource = "TmpSaldG.Saldo"
1575:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1576:                 .Column5.ControlSource = "TmpSaldG.Disps"
1577:                 .Column6.ControlSource = "TmpSaldG.Emps"
1578:                 .SetAll("ReadOnly", .T.)
1579:             ENDWITH
1580:         ENDIF
1581: 
1582:         *-- ObsItens: vincula ao campo de observacao do item corrente
1583:         IF USED("TmpFinal")
1584:             THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1585:         ENDIF
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     PROTECTED PROCEDURE TornarControlesVisiveis
1590:     *==========================================================================
1591:         LOCAL loc_nI, loc_oCtrl
1592:         FOR loc_nI = 1 TO THIS.ControlCount
1593:             loc_oCtrl = THIS.Controls(loc_nI)
1594:             *-- Overlays ocultos (Visible=.F.): processar sub-controles mas manter container oculto
1595:             IF INLIST(UPPER(loc_oCtrl.Name), ;
1596:                       "CNT_4C_CONTAINER1", ;
1597:                       "CNT_4C_CONTAINER2", ;
1598:                       "CNT_4C_CONTAINER4", ;
1599:                       "CNT_4C_CONTAINER5", ;
1600:                       "IMG_4C_IMGFIGJPG")
1601:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1602:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
1603:                 ENDIF
1604:                 LOOP
1605:             ENDIF
1606:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1607:                 loc_oCtrl.Visible = .T.
1608:             ENDIF
1609:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1610:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1611:             ENDIF
1612:         ENDFOR
1613:     ENDPROC
1614: 
1615:     *==========================================================================
1616:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1617:     *==========================================================================
1618:         LOCAL loc_nI, loc_oCtrl
1619:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1620:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1621:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1622:                 loc_oCtrl.Visible = .T.
1623:             ENDIF
1624:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1625:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1626:             ENDIF
1627:         ENDFOR
1628:     ENDPROC
1629: 
1630:     *==========================================================================
1631:     PROCEDURE Destroy
1632:     *==========================================================================
1633:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1634:             THIS.this_oBusinessObject.LiberarConexaoTemp()
1635:         ENDIF
1636:         DODEFAULT()
1637:     ENDPROC
1638: 
1639:     *==========================================================================
1640:     * HANDLERS DE EVENTOS DOS BOTOES PRINCIPAIS
1641:     *==========================================================================
1642: 
1643:     PROCEDURE BtnDisponiveiClick
1644:         LOCAL loc_cCpro, loc_cCor
1645: 
1646:         TRY
1647:             IF USED("TmpFinal")
1648:                 loc_cCpro = TmpFinal.Cpros
1649:                 loc_cCor  = TmpFinal.CodCors
1650: 
1651:                 IF USED("TmpDisp")
1652:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = ""
1653:                     USE IN TmpDisp
1654:                 ENDIF
1655: 
1656:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1657:                   FROM TmpSaldo ;
1658:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1659:                  ORDER BY Cpros, CodCors, CodTams ;
1660:                   INTO CURSOR TmpDisp READWRITE
1661: 
1662:                 THIS.grd_4c_Dados.Enabled = .F.
1663: 
1664:                 IF _Tally = 0
1665:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1666:                     THIS.BtnCancelaDisp2Click()
1667:                 ELSE
1668:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = "TmpDisp"
1669:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1670:                         .Column1.ControlSource = "TmpDisp.Cpros"
1671:                         .Column2.ControlSource = "TmpDisp.CodCors"
1672:                         .Column3.ControlSource = "TmpDisp.CodTams"
1673:                         .Column4.ControlSource = "TmpDisp.Disps"
1674:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1675:                     ENDWITH
1676: 
1677:                     WITH THIS.cnt_4c_Container2
1678:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1679:                         .txt_4c_Qt_Selec.Value  = 0
1680:                         .Visible     = .T.
1681:                     ENDWITH
1682: 
1683:                     THIS.cmd_4c_Processar.Enabled  = .F.
1684:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1685:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1686:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1687:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1688:                     THIS.cnt_4c_Container3.Enabled = .F.
1689:                     THIS.cnt_4c_Container2.Visible = .T.
1690:                     THIS.cnt_4c_Container2.ZOrder
1691:                     THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
1692:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus
1693:                 ENDIF
1694:             ENDIF
1695:         CATCH TO loc_oErro
1696:             MsgErro(loc_oErro.Message, "Erro")
1697:         ENDTRY
1698:     ENDPROC
1699: 
1700:     PROCEDURE BtnTotLinhaClick
1701:         TRY
1702:             IF USED("TmpLinha")
1703:                 THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = ""
1704:                 USE IN TmpLinha
1705:             ENDIF
1706: 
1707:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1708:               FROM TmpFinal ;
1709:              GROUP BY 1 ;
1710:              UNION ALL ;
1711:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1712:               FROM TmpFinal ;
1713:              GROUP BY 1 ;
1714:               INTO CURSOR TmpLinha ;
1715:              ORDER BY 2, 1
1716: 
1717:             THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = "TmpLinha"
1718:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1719:                 .Column1.ControlSource = "TmpLinha.Linhas"
1720:                 .Column2.ControlSource = "TmpLinha.Saldo"
1721:                 .Column3.ControlSource = "TmpLinha.Estoque"
1722:                 .Column4.ControlSource = "TmpLinha.Produzir"
1723:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1724:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1725:             ENDWITH
1726: 
1727:             THIS.cmd_4c_Processar.Enabled  = .F.
1728:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1729:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1730:             THIS.cmd_4c_Pedras.Enabled     = .F.
1731:             THIS.cmd_4c_Disponivel.Enabled = .F.
1732:             THIS.grd_4c_Dados.Enabled      = .F.
1733:             THIS.cnt_4c_Container3.Enabled = .F.
1734:             THIS.cnt_4c_Container1.Visible = .T.
1735:             THIS.cnt_4c_Container1.ZOrder
1736:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1737:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus
1738:         CATCH TO loc_oErro
1739:             MsgErro(loc_oErro.Message, "Erro")
1740:         ENDTRY
1741:     ENDPROC
1742: 
1743:     PROCEDURE BtnPedrasClick
1744:         TRY
1745:             IF USED("SelPedra")
1746:                 THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = ""
1747:             ENDIF
1748: 
1749:             THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = "SelPedra"
1750:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1751:                 .Column1.ControlSource = "SelPedra.Cpros"
1752:                 .Column2.ControlSource = "SelPedra.Dpros"
1753:                 .Column3.ControlSource = "SelPedra.Cunis"
1754:                 .Column4.ControlSource = "SelPedra.Qtds"
1755:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1756:             ENDWITH
1757: 
1758:             THIS.cmd_4c_Processar.Enabled  = .F.
1759:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1760:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1761:             THIS.cmd_4c_Pedras.Enabled     = .F.
1762:             THIS.cmd_4c_Disponivel.Enabled = .F.
1763:             THIS.grd_4c_Dados.Enabled      = .F.
1764:             THIS.cnt_4c_Container3.Enabled = .F.
1765:             THIS.cnt_4c_Container4.Visible = .T.
1766:             THIS.cnt_4c_Container4.ZOrder
1767:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1768:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1769:         CATCH TO loc_oErro
1770:             MsgErro(loc_oErro.Message, "Erro")
1771:         ENDTRY
1772:     ENDPROC
1773: 
1774:     PROCEDURE BtnSelEstoqueClick
1775:         LOCAL loc_cCpro, loc_cCor, loc_cTam
1776: 
1777:         TRY
1778:             IF USED("TmpFinal")
1779:                 loc_cCpro = TmpFinal.Cpros
1780:                 loc_cCor  = TmpFinal.CodCors
1781:                 loc_cTam  = TmpFinal.CodTams
1782: 
1783:                 IF USED("TmpDisp")
1784:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = ""
1785:                     USE IN TmpDisp
1786:                 ENDIF
1787: 
1788:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1789:                        000000000.000 AS Utilizar ;
1790:                   FROM TmpSaldG ;
1791:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1792:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1793:                 SELECT 0
1794:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1795:                 USE IN Resultado
1796: 
1797:                 THIS.grd_4c_Dados.Enabled = .F.
1798: 
1799:                 IF _Tally = 0
1800:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1801:                     THIS.BtnCancelaDisp5Click()
1802:                 ELSE
1803:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = "TmpDisp"
1804:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1805:                         .Column1.ControlSource = "TmpDisp.Grupos"
1806:                         .Column2.ControlSource = "TmpDisp.Estos"
1807:                         .Column3.ControlSource = "TmpDisp.Priors"
1808:                         .Column4.ControlSource = "TmpDisp.Disps"
1809:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1810:                     ENDWITH
1811: 
1812:                     WITH THIS.cnt_4c_Container5
1813:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1814:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1815:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1816:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1817:                         .txt_4c_Qt_Selec.Value  = 0
1818:                         .Visible     = .T.
1819:                     ENDWITH
1820: 
1821:                     THIS.cmd_4c_Processar.Enabled  = .F.
1822:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1823:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1824:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1825:                     THIS.cmd_4c_SelEstoque.Enabled = .F.
1826:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1827:                     THIS.cnt_4c_Container3.Enabled = .F.
1828:                     THIS.cnt_4c_Container5.Visible = .T.
1829:                     THIS.cnt_4c_Container5.ZOrder
1830:                     THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
1831:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus
1832:                 ENDIF
1833:             ENDIF
1834:         CATCH TO loc_oErro
1835:             MsgErro(loc_oErro.Message, "Erro")
1836:         ENDTRY
1837:     ENDPROC
1838: 
1839:     PROCEDURE BtnCancelarClick
1840:         TRY
1841:             IF VARTYPE(THIS.poFormPai) = "O"
1842:                 THIS.poFormPai.Enabled = .T.
1843:             ENDIF
1844:             THIS.Release
1845:         CATCH TO loc_oErro
1846:             MsgErro(loc_oErro.Message, "Erro")
1847:         ENDTRY
1848:     ENDPROC
1849: 
1850:     PROCEDURE BtnProcessarClick
1851:         LOCAL loc_dPrevisao, loc_dGeracao, loc_lSucesso
1852: 
1853:         loc_dPrevisao = DATE()
1854:         loc_dGeracao  = THIS.this_dData
1855:         loc_lSucesso  = .F.
1856: 
1857:         TRY
1858:             *-- Tentar obter datas do formulario pai/av?
1859:             IF VARTYPE(THIS.poFormPai) = "O"
1860:                 TRY
1861:                     IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
1862:                         loc_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
1863:                         loc_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
1864:                     ENDIF
1865:                 CATCH
1866:                 ENDTRY
1867:             ENDIF
1868: 
1869:             WITH THIS.this_oBusinessObject
1870:                 .this_lReserva    = THIS.this_lReserva
1871:                 .this_lAutomatico = THIS.this_lAutomatico
1872:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
1873:                 .this_dPrevisao   = loc_dPrevisao
1874:                 .this_dGeracao    = loc_dGeracao
1875:             ENDWITH
1876: 
1877:             loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dPrevisao, loc_dGeracao)
1878: 
1879:             IF loc_lSucesso
1880:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso!", "Informa" + CHR(231) + CHR(227) + "o")
1881:                 IF VARTYPE(THIS.poFormPai) = "O"
1882:                     THIS.poFormPai.Enabled = .T.
1883:                 ENDIF
1884:                 THIS.Release
1885:             ENDIF
1886:         CATCH TO loc_oErro
1887:             MsgErro(loc_oErro.Message, "Erro")
1888:         ENDTRY
1889:     ENDPROC
1890: 
1891:     PROCEDURE BtnRelatorioClick
1892:         TRY
1893:             IF THIS.this_oBusinessObject.GerarRelatorio()
1894:                 THIS.ExecutarReportForm("SigPrGlp", "PRINTER_PROMPT", "crImpressao")
1895:             ENDIF
1896:         CATCH TO loc_oErro
1897:             MsgErro(loc_oErro.Message, "Erro")
1898:         ENDTRY
1899:     ENDPROC
1900: 
1901:     *==========================================================================
1902:     * HANDLERS DE EVENTOS DOS CONTAINERS OVERLAY
1903:     *==========================================================================
1904: 
1905:     PROCEDURE BtnCancelaLin1Click
1906:         WITH THIS
1907:             .cmd_4c_Processar.Enabled  = .T.
1908:             .cmd_4c_Cancelar.Enabled   = .T.
1909:             .cmd_4c_Pedras.Enabled     = .T.
1910:             .cmd_4c_TotLinha.Enabled   = .T.
1911:             .cmd_4c_Disponivel.Enabled = .T.
1912:             .cnt_4c_Container1.Visible = .F.
1913:             .cnt_4c_Container3.Enabled = .T.
1914:             .grd_4c_Dados.Enabled      = .T.
1915:             .grd_4c_Dados.ZOrder
1916:             .grd_4c_Dados.Refresh
1917:             .grd_4c_Dados.Column6.SetFocus
1918:         ENDWITH
1919:     ENDPROC
1920: 
1921:     PROCEDURE BtnCancelaDisp2Click
1922:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
1923:         LOCAL loc_lSucesso
1924:         loc_lSucesso = .F.
1925: 
1926:         TRY
1927:             IF USED("TmpDisp") AND USED("TmpFinal")
1928:                 SELECT TmpDisp
1929:                 SUM Utilizar TO loc_nQtdUtil
1930: 
1931:                 IF loc_nQtdUtil > 0
1932:                     SELECT TmpDisp
1933:                     SCAN
1934:                         IF Utilizar = 0
1935:                             LOOP
1936:                         ENDIF
1937:                         loc_nQtUtil = Utilizar
1938:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1939:                         SELECT TmpFinal
1940:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1941:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1942: 
1943:                         SELECT TmpSaldo
1944:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1945: 
1946:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1947:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1948:                         ENDIF
1949:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1950: 
1951:                         SELECT TmpSaldG
1952:                         SET ORDER TO Cpros
1953:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1954:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1955: 
1956:                         SELECT TmpDisp
1957:                     ENDSCAN
1958:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1959:                 ENDIF
1960:                 loc_lSucesso = .T.
1961:             ENDIF

*-- Linhas 1968 a 2101:
1968:             .cmd_4c_Cancelar.Enabled   = .T.
1969:             .cmd_4c_TotLinha.Enabled   = .T.
1970:             .cmd_4c_SelEstoque.Enabled = .T.
1971:             .cmd_4c_Pedras.Enabled     = .T.
1972:             .cmd_4c_Disponivel.Enabled = .T.
1973:             .cnt_4c_Container3.Enabled = .T.
1974:             .cnt_4c_Container2.Visible = .F.
1975:             .grd_4c_Dados.Enabled      = .T.
1976:             .grd_4c_Dados.ZOrder
1977:             .grd_4c_Dados.Refresh
1978:             .grd_4c_Dados.Column6.SetFocus
1979:         ENDWITH
1980:     ENDPROC
1981: 
1982:     PROCEDURE BtnCancelaDisp4Click
1983:         WITH THIS
1984:             .cmd_4c_Processar.Enabled  = .T.
1985:             .cmd_4c_Cancelar.Enabled   = .T.
1986:             .cmd_4c_TotLinha.Enabled   = .T.
1987:             .cmd_4c_Pedras.Enabled     = .T.
1988:             .cmd_4c_Disponivel.Enabled = .T.
1989:             .cnt_4c_Container3.Enabled = .T.
1990:             .cnt_4c_Container4.Visible = .F.
1991:             .grd_4c_Dados.Enabled      = .T.
1992:             .grd_4c_Dados.ZOrder
1993:             .grd_4c_Dados.Refresh
1994:             .grd_4c_Dados.Column6.SetFocus
1995:         ENDWITH
1996:     ENDPROC
1997: 
1998:     PROCEDURE BtnCancelaDisp5Click
1999:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
2000: 
2001:         TRY
2002:             IF USED("TmpDisp") AND USED("TmpFinal")
2003:                 SELECT TmpDisp
2004:                 SUM Utilizar TO loc_nQtdUtil
2005: 
2006:                 IF loc_nQtdUtil > 0
2007:                     SELECT TmpDisp
2008:                     SCAN
2009:                         IF Utilizar = 0
2010:                             LOOP
2011:                         ENDIF
2012:                         loc_nQtUtil = Utilizar
2013:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2014: 
2015:                         SELECT TmpFinal
2016:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2017:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2018: 
2019:                         SELECT TmpSaldo
2020:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2021: 
2022:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2023:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2024:                         ENDIF
2025:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2026: 
2027:                         SELECT TmpSaldG
2028:                         SET ORDER TO Cpros
2029:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2030:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2031: 
2032:                         SELECT TmpDisp
2033:                     ENDSCAN
2034:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2035:                 ENDIF
2036:             ENDIF
2037:         CATCH TO loc_oErro
2038:             MsgErro(loc_oErro.Message, "Erro")
2039:         ENDTRY
2040: 
2041:         WITH THIS
2042:             .cmd_4c_Processar.Enabled  = .T.
2043:             .cmd_4c_Cancelar.Enabled   = .T.
2044:             .cmd_4c_TotLinha.Enabled   = .T.
2045:             .cmd_4c_Disponivel.Enabled = .T.
2046:             .cmd_4c_SelEstoque.Enabled = .T.
2047:             .cmd_4c_Pedras.Enabled     = .T.
2048:             .cnt_4c_Container3.Enabled = .T.
2049:             .cnt_4c_Container5.Visible = .F.
2050:             .grd_4c_Dados.Enabled      = .T.
2051:             .grd_4c_Dados.ZOrder
2052:             .grd_4c_Dados.Refresh
2053:             .grd_4c_Dados.Column6.SetFocus
2054:         ENDWITH
2055:     ENDPROC
2056: 
2057:     *==========================================================================
2058:     * HANDLERS DE EVENTOS DO GRID PRINCIPAL (GradeItens)
2059:     *==========================================================================
2060: 
2061:     PROCEDURE GradeItensAfterRowColChange
2062:         LPARAMETERS par_nColIndex
2063:         LOCAL loc_cSQL, loc_lcArquivo, loc_lcFoto, loc_nSal, loc_nEst, loc_nPrz
2064: 
2065:         TRY
2066:             IF !USED("TmpFinal") OR EOF("TmpFinal")
2067:                 RETURN
2068:             ENDIF
2069: 
2070:             THIS.obj_4c_ObsItens.Refresh
2071:             THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
2072: 
2073:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2074: 
2075:             SELECT TmpSaldG
2076:             SET ORDER TO Cpros
2077:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2078:             GO TOP
2079: 
2080:             WITH THIS.cnt_4c_Container3
2081:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2082:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2083:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2084:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2085:                 ENDIF
2086: 
2087:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2088:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2089:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2090: 
2091:                 .grd_4c_Dados.Refresh
2092:                 .Visible     = .T.
2093:             ENDWITH
2094: 
2095:             *-- Foto do produto
2096:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2097:                        ALLTRIM(TmpFinal.CPros) + "'"
2098:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2099:                 CLEAR RESOURCES
2100:                 THIS.img_4c_ImgFigJpg.Picture = ""
2101:                 THIS.img_4c_ImgFigJpg.Visible = .F.

*-- Linhas 2122 a 2848:
2122:         ENDTRY
2123:     ENDPROC
2124: 
2125:     PROCEDURE GrdCol6TextWhen
2126:         LOCAL loc_lPermite
2127:         loc_lPermite = .T.
2128: 
2129:         TRY
2130:             IF USED("TmpFinal")
2131:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2132: 
2133:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2134:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2135:                                ALLTRIM(TmpFinal.CPros) + "'"
2136:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2137:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2138:                                    ALLTRIM(xTempPro.CGrus) + "'"
2139:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2140:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2141:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2142:                             ENDIF
2143:                             IF USED("xTempGru")
2144:                                 USE IN xTempGru
2145:                             ENDIF
2146:                         ENDIF
2147:                         IF USED("xTempPro")
2148:                             USE IN xTempPro
2149:                         ENDIF
2150:                     ENDIF
2151:                 ENDIF
2152:             ENDIF
2153:         CATCH TO loc_oErro
2154:             MsgErro(loc_oErro.Message, "Erro")
2155:         ENDTRY
2156: 
2157:         RETURN loc_lPermite
2158:     ENDPROC
2159: 
2160:     PROCEDURE GrdCol6TextValid
2161:         LOCAL loc_lValido, loc_nNewValue, loc_nOld, loc_xBaixa
2162: 
2163:         loc_lValido  = .T.
2164:         loc_nNewValue = THIS.grd_4c_Dados.Column6.Text1.Value
2165:         loc_nOld      = THIS.this_nOldValue
2166: 
2167:         TRY
2168:             IF !USED("TmpFinal") OR !USED("TmpSaldo")
2169:                 loc_lResultado = .T.
2170:             ENDIF
2171: 
2172:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2173:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2174:             ENDIF
2175: 
2176:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2177:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2178:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2179:                     *-- Continue
2180:                 ELSE
2181:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2182:                     loc_lValido = .F.
2183:                 ENDIF
2184:             ENDIF
2185: 
2186:             IF loc_lValido
2187:                 DO CASE
2188:                     CASE loc_nNewValue = loc_nOld
2189:                         *-- nada a fazer
2190:                     CASE loc_nNewValue < 0
2191:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
2192:                         THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2193:                     CASE loc_nNewValue > TmpFinal.Saldo
2194:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
2195:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
2196:                     CASE !SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") AND ;
2197:                          TmpFinal.Produzir <> TmpFinal.Saldo
2198:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2199:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo
2200:                     OTHERWISE
2201:                         IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNewValue
2202:                             REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
2203:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2204:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2205: 
2206:                             SELECT TmpSaldo
2207:                             loc_xBaixa = Saldo - Disps
2208:                             SELECT TmpSaldG
2209:                             SET ORDER TO Cpros
2210:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2211:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2212:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2213:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2214:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2215:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2216:                                     m.loc_xBaixa = 0
2217:                                 ELSE
2218:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2219:                                     REPLACE TmpSaldG.Disps WITH 0
2220:                                 ENDIF
2221:                             ENDSCAN
2222:                         ELSE
2223:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2224:                             THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2225:                         ENDIF
2226:                 ENDCASE
2227:             ENDIF
2228:         CATCH TO loc_oErro
2229:             MsgErro(loc_oErro.Message, "Erro")
2230:         ENDTRY
2231: 
2232:         RETURN loc_lValido
2233:     ENDPROC
2234: 
2235:     PROCEDURE GrdCol6TextLostFocus
2236:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2237:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz
2238: 
2239:         TRY
2240:             IF USED("TmpFinal")
2241:                 SELECT TmpFinal
2242:                 loc_nRecno = RECNO()
2243:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2244:                 GO loc_nRecno
2245:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2246:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2247:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2248:                 THIS.txt_4c_Tot_Qtd.Refresh
2249:                 THIS.txt_4c_Tot_Est.Refresh
2250:                 THIS.txt_4c_Tot_Prz.Refresh
2251:                 THIS.Refresh
2252:             ENDIF
2253:         CATCH TO loc_oErro
2254:             MsgErro(loc_oErro.Message, "Erro")
2255:         ENDTRY
2256:     ENDPROC
2257: 
2258:     *==========================================================================
2259:     * HANDLERS DOS GRIDS DE CONTAINERS OVERLAY
2260:     *==========================================================================
2261: 
2262:     PROCEDURE Cnt5GradeAfterRowColChange
2263:         LPARAMETERS par_nColIndex
2264:         LOCAL loc_cSQL
2265: 
2266:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2267:     ENDPROC
2268: 
2269:     PROCEDURE Cnt5Col5TextValid
2270:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2271: 
2272:         loc_lValido = .T.
2273: 
2274:         TRY
2275:             loc_nVal = THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value
2276: 
2277:             IF loc_nVal > TmpDisp.Disps
2278:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Disponivel...", "")
2279:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2280:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2281:                 loc_lValido = .F.
2282:             ELSE
2283:                 IF loc_nVal < 0
2284:                     MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
2285:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2286:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2287:                     loc_lValido = .F.
2288:                 ELSE
2289:                     loc_nRecno = RECNO("TmpDisp")
2290:                     SUM TmpDisp.Utilizar TO loc_nQtdUtil
2291:                     GO loc_nRecno IN TmpDisp
2292:                     IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo - TmpFinal.Estoque
2293:                         MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
2294:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2295:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2296:                         loc_lValido = .F.
2297:                     ELSE
2298:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2299:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Refresh
2300:                     ENDIF
2301:                 ENDIF
2302:             ENDIF
2303:         CATCH TO loc_oErro
2304:             MsgErro(loc_oErro.Message, "Erro")
2305:         ENDTRY
2306: 
2307:         RETURN loc_lValido
2308:     ENDPROC
2309: 
2310:     PROCEDURE Cnt2Col5TextValid
2311:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2312: 
2313:         loc_lValido = .T.
2314: 
2315:         TRY
2316:             loc_nVal = THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value
2317: 
2318:             IF loc_nVal > TmpDisp.Disps
2319:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
2320:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2321:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2322:                 loc_lValido = .F.
2323:             ELSE
2324:                 loc_nRecno = RECNO("TmpDisp")
2325:                 SUM TmpDisp.Utilizar TO loc_nQtdUtil
2326:                 GO loc_nRecno IN TmpDisp
2327:                 IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo
2328:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
2329:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2330:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2331:                     loc_lValido = .F.
2332:                 ELSE
2333:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2334:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Refresh
2335:                 ENDIF
2336:             ENDIF
2337:         CATCH TO loc_oErro
2338:             MsgErro(loc_oErro.Message, "Erro")
2339:         ENDTRY
2340: 
2341:         RETURN loc_lValido
2342:     ENDPROC
2343: 
2344:     PROCEDURE Cnt4Col1TextValid
2345:         LOCAL loc_lValido, loc_cVal, loc_cSQL
2346: 
2347:         loc_lValido = .T.
2348: 
2349:         TRY
2350:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2351:             IF !EMPTY(loc_cVal)
2352:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2353:                            EscaparSQL(loc_cVal)
2354:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2355:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2356:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2357:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2358:                 ELSE
2359:                     *-- Abrir picker (FormBuscaAuxiliar)
2360:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2361:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2362:                                              "CPros", "DPros"
2363:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2364:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2365:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2366:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2367:                     ENDIF
2368:                 ENDIF
2369:                 IF USED("crListaRemota")
2370:                     USE IN crListaRemota
2371:                 ENDIF
2372:                 THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
2373:             ENDIF
2374:         CATCH TO loc_oErro
2375:             MsgErro(loc_oErro.Message, "Erro")
2376:         ENDTRY
2377: 
2378:         RETURN loc_lValido
2379:     ENDPROC
2380: 
2381:     *==========================================================================
2382:     PROCEDURE GrdColXGotFocus
2383:     *==========================================================================
2384:         IF VARTYPE(THIS.grd_4c_Dados) = "O" AND VARTYPE(THIS.grd_4c_Dados.Column6) = "O"
2385:             THIS.grd_4c_Dados.Column6.Text1.SetFocus()
2386:         ENDIF
2387:     ENDPROC
2388: 
2389:     *==========================================================================
2390:     PROCEDURE Cnt2GrdColXGotFocus
2391:     *==========================================================================
2392:         LOCAL loc_oGrd
2393:         loc_oGrd = THIS.cnt_4c_Container2.grd_4c_Dados
2394:         IF VARTYPE(loc_oGrd) = "O" AND VARTYPE(loc_oGrd.Column5) = "O"
2395:             loc_oGrd.Column5.Text1.SetFocus()
2396:         ENDIF
2397:     ENDPROC
2398: 
2399:     *==========================================================================
2400:     PROCEDURE Cnt4Col4TextWhen
2401:     *==========================================================================
2402:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2403:     ENDPROC
2404: 
2405:     *==========================================================================
2406:     PROCEDURE Cnt4Col5TextWhen
2407:     *==========================================================================
2408:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2409:     ENDPROC
2410: 
2411:     *==========================================================================
2412:     PROCEDURE Cnt4Col5TextValid
2413:     *==========================================================================
2414:         LOCAL loc_lValido, loc_cVal, loc_cSQL, loc_oBusca
2415:         loc_lValido = .T.
2416: 
2417:         TRY
2418:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2419:             IF !EMPTY(loc_cVal)
2420:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2421:                            EscaparSQL(loc_cVal)
2422:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2423:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2424:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2425:                 ELSE
2426:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2427:                                              "crListaPro2", "CPros", loc_cVal, ;
2428:                                              "Produto Substituto")
2429:                     IF VARTYPE(loc_oBusca) = "O"
2430:                         loc_oBusca.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2431:                         loc_oBusca.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2432:                         loc_oBusca.Show()
2433:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2434:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2435:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2436:                         ELSE
2437:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""
2438:                             REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2439:                         ENDIF
2440:                         loc_oBusca = .NULL.
2441:                     ENDIF
2442:                 ENDIF
2443:                 IF USED("crListaPro2")
2444:                     USE IN crListaPro2
2445:                 ENDIF
2446:             ELSE
2447:                 REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2448:             ENDIF
2449:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh()
2450:         CATCH TO loc_oErro
2451:             MsgErro(loc_oErro.Message, "Erro")
2452:         ENDTRY
2453: 
2454:         RETURN loc_lValido
2455:     ENDPROC
2456: 
2457:     *==========================================================================
2458:     * Cnt3GradeAfterRowColChange - Atualiza descricoes de grupo/conta ao mudar
2459:     * de linha no grid de saldo (Container3.grd_4c_Dados / TmpSaldG)
2460:     *==========================================================================
2461:     PROCEDURE Cnt3GradeAfterRowColChange
2462:         LPARAMETERS par_nColIndex
2463:         LOCAL loc_cSQL
2464: 
2465:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2466:     ENDPROC
2467: 
2468:     *==========================================================================
2469:     * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
2470:     * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
2471:     * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)
2472:     * par_cModo          : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
2473:     * par_cCursorDados   : alias do cursor de dados (opcional - verifica se vazio)
2474:     *==========================================================================
2475:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
2476:         LOCAL loc_cArqFrx, loc_cOldPoint, loc_cOldSep, loc_oErro
2477: 
2478:         par_cRelatorioBase = STRTRAN(UPPER(par_cRelatorioBase), ".FRX", "")
2479:         loc_cArqFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
2480: 
2481:         IF !FILE(loc_cArqFrx)
2482:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
2483:                     loc_cArqFrx, "Relat" + CHR(243) + "rio")
2484:             RETURN
2485:         ENDIF
2486: 
2487:         IF !EMPTY(par_cCursorDados)
2488:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2489:                 MsgAviso("Nenhum dado para exibir.")
2490:                 RETURN
2491:             ENDIF
2492:         ENDIF
2493: 
2494:         loc_cOldPoint = SET("POINT")
2495:         loc_cOldSep   = SET("SEPARATOR")
2496: 
2497:         TRY
2498:             SET POINT TO "."
2499:             SET SEPARATOR TO ","
2500:             SET REPORTBEHAVIOR 80
2501:             DO CASE
2502:                 CASE par_cModo = "PREVIEW"
2503:                     REPORT FORM (loc_cArqFrx) PREVIEW
2504:                 CASE par_cModo = "PRINTER_PROMPT"
2505:                     REPORT FORM (loc_cArqFrx) TO PRINTER PROMPT
2506:                 CASE par_cModo = "PRINTER"
2507:                     REPORT FORM (loc_cArqFrx) TO PRINTER
2508:                 OTHERWISE
2509:                     REPORT FORM (loc_cArqFrx) PREVIEW
2510:             ENDCASE
2511:         CATCH TO loc_oErro
2512:             MsgErro("Erro relat" + CHR(243) + "rio: " + loc_oErro.Message, "Relat" + CHR(243) + "rio")
2513:         ENDTRY
2514: 
2515:         SET POINT TO (loc_cOldPoint)
2516:         SET SEPARATOR TO (loc_cOldSep)
2517:     ENDPROC
2518: 
2519:     *==========================================================================
2520:     * EVENTOS PRINCIPAIS (CRUD-nomeados) - Form OPERACIONAL "Previa da Globalizacao"
2521:     * Este form nao possui botoes CRUD literais (Incluir/Alterar/Visualizar/Excluir),
2522:     * mas os handlers sao expostos como aliases das acoes operacionais equivalentes
2523:     * para uso por integradores externos (menus, chamadas automatizadas, testes).
2524:     *==========================================================================
2525: 
2526:     PROCEDURE BtnIncluirClick
2527:         *-- INCLUIR (novo processamento): executa Processar (fluxo principal)
2528:         TRY
2529:             THIS.BtnProcessarClick()
2530:         CATCH TO loc_oErro
2531:             MsgErro(loc_oErro.Message, "Erro")
2532:         ENDTRY
2533:     ENDPROC
2534: 
2535:     PROCEDURE BtnAlterarClick
2536:         *-- ALTERAR (recalcular totais da grade principal a partir de TmpFinal)
2537:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2538: 
2539:         TRY
2540:             IF USED("TmpFinal")
2541:                 SELECT TmpFinal
2542:                 loc_nRecno = RECNO()
2543:                 loc_nSal = 0
2544:                 loc_nEst = 0
2545:                 loc_nPrz = 0
2546:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2547:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2548:                     GO loc_nRecno IN TmpFinal
2549:                 ENDIF
2550: 
2551:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2552:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2553:                     THIS.txt_4c_Tot_Qtd.Refresh()
2554:                 ENDIF
2555:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2556:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
2557:                     THIS.txt_4c_Tot_Est.Refresh()
2558:                 ENDIF
2559:                 IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2560:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2561:                     THIS.txt_4c_Tot_Prz.Refresh()
2562:                 ENDIF
2563:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
2564:                     THIS.grd_4c_Dados.Refresh()
2565:                 ENDIF
2566:                 THIS.Refresh()
2567:             ENDIF
2568:         CATCH TO loc_oErro
2569:             MsgErro(loc_oErro.Message, "Erro")
2570:         ENDTRY
2571:     ENDPROC
2572: 
2573:     PROCEDURE BtnVisualizarClick
2574:         *-- VISUALIZAR: emite o relatorio da previa (equivalente ao btnRelatorio)
2575:         TRY
2576:             THIS.BtnRelatorioClick()
2577:         CATCH TO loc_oErro
2578:             MsgErro(loc_oErro.Message, "Erro")
2579:         ENDTRY
2580:     ENDPROC
2581: 
2582:     PROCEDURE BtnExcluirClick
2583:         *-- EXCLUIR (cancelar processamento em andamento): rollback + release
2584:         TRY
2585:             IF MsgConfirma("Cancelar o processamento atual?", "Confirma" + CHR(231) + CHR(227) + "o")
2586:                 THIS.BtnCancelarClick()
2587:             ENDIF
2588:         CATCH TO loc_oErro
2589:             MsgErro(loc_oErro.Message, "Erro")
2590:         ENDTRY
2591:     ENDPROC
2592: 
2593:     *==========================================================================
2594:     * BtnBuscarClick - Rebusca / reexibe os dados atuais
2595:     * Para form OPERACIONAL sem filtros editaveis pelo usuario, "Buscar"
2596:     * equivale a atualizar os totais e o binding do grid principal a partir
2597:     * dos cursores TmpFinal/TmpSaldo/TmpSaldG ja carregados pelo form pai.
2598:     *==========================================================================
2599:     PROCEDURE BtnBuscarClick
2600:         TRY
2601:             THIS.CarregarDados()
2602:             IF USED("TmpFinal")
2603:                 LOCAL loc_nSal, loc_nEst, loc_nPrz
2604:                 loc_nSal = 0
2605:                 loc_nEst = 0
2606:                 loc_nPrz = 0
2607:                 SELECT TmpFinal
2608:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2609:                 GO TOP
2610:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2611:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2612:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2613:             ENDIF
2614:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2615:                 THIS.grd_4c_Dados.Refresh()
2616:             ENDIF
2617:         CATCH TO loc_oErro
2618:             MsgErro(loc_oErro.Message, "Erro")
2619:         ENDTRY
2620:     ENDPROC
2621: 
2622:     *==========================================================================
2623:     * BtnEncerrarClick - Encerra / fecha o form sem processar
2624:     * Equivalente ao botao Sair/Cancelar do legado.
2625:     *==========================================================================
2626:     PROCEDURE BtnEncerrarClick
2627:         TRY
2628:             IF VARTYPE(THIS.poFormPai) = "O"
2629:                 THIS.poFormPai.Enabled = .T.
2630:             ENDIF
2631:             THIS.Release
2632:         CATCH TO loc_oErro
2633:             MsgErro(loc_oErro.Message, "Erro")
2634:         ENDTRY
2635:     ENDPROC
2636: 
2637:     *==========================================================================
2638:     * BtnSalvarClick - Salva / confirma o processamento
2639:     * Para form OPERACIONAL "Previa da Globalizacao", salvar equivale a
2640:     * executar o processamento completo (botao Processar do legado).
2641:     *==========================================================================
2642:     PROCEDURE BtnSalvarClick
2643:         TRY
2644:             THIS.BtnProcessarClick()
2645:         CATCH TO loc_oErro
2646:             MsgErro(loc_oErro.Message, "Erro")
2647:         ENDTRY
2648:     ENDPROC
2649: 
2650:     *==========================================================================
2651:     * CarregarLista - Alias canonico para CarregarDados (compatibilidade FormBase)
2652:     * Forms CRUD chamam CarregarLista; em OPERACIONAL delega para CarregarDados.
2653:     *==========================================================================
2654:     PROCEDURE CarregarLista
2655:         TRY
2656:             THIS.CarregarDados()
2657:         CATCH TO loc_oErro
2658:             MsgErro(loc_oErro.Message, "Erro")
2659:         ENDTRY
2660:     ENDPROC
2661: 
2662:     *==========================================================================
2663:     * FormParaBO - Transfere estado do form para o BO
2664:     * Em form OPERACIONAL as propriedades relevantes sao flags de contexto
2665:     * (lReserva, lAutomatico, nNumeroDaOp) e datas obtidas do form pai.
2666:     *==========================================================================
2667:     PROCEDURE FormParaBO
2668:         TRY
2669:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2670:                 RETURN
2671:             ENDIF
2672:             WITH THIS.this_oBusinessObject
2673:                 .this_lReserva    = THIS.this_lReserva
2674:                 .this_lAutomatico = THIS.this_lAutomatico
2675:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
2676:                 .this_nEmphPdr    = THIS.this_nEmphPdr
2677:                 .this_dData       = THIS.this_dData
2678: 
2679:                 *-- Datas de previsao/geracao obtidas do form avo (se existir)
2680:                 IF VARTYPE(THIS.poFormPai) = "O"
2681:                     TRY
2682:                         IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
2683:                             .this_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
2684:                             .this_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
2685:                         ENDIF
2686:                     CATCH
2687:                     ENDTRY
2688:                 ENDIF
2689:             ENDWITH
2690:         CATCH TO loc_oErro
2691:             MsgErro(loc_oErro.Message, "Erro")
2692:         ENDTRY
2693:     ENDPROC
2694: 
2695:     *==========================================================================
2696:     * BOParaForm - Atualiza o form com dados/estado do BO
2697:     * Em form OPERACIONAL rebinda grids e atualiza totais a partir dos
2698:     * cursores calculados pelo BO (TmpFinal/TmpSaldo/TmpSaldG).
2699:     *==========================================================================
2700:     PROCEDURE BOParaForm
2701:         LOCAL loc_nSal, loc_nEst, loc_nPrz
2702:         loc_nSal = 0
2703:         loc_nEst = 0
2704:         loc_nPrz = 0
2705: 
2706:         TRY
2707:             THIS.CarregarDados()
2708: 
2709:             IF USED("TmpFinal")
2710:                 SELECT TmpFinal
2711:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2712:                 GO TOP
2713:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2714:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2715:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2716:             ENDIF
2717: 
2718:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2719:                 THIS.grd_4c_Dados.Refresh()
2720:             ENDIF
2721:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2722:                 THIS.cnt_4c_Container3.Refresh()
2723:             ENDIF
2724:             THIS.Refresh()
2725:         CATCH TO loc_oErro
2726:             MsgErro(loc_oErro.Message, "Erro")
2727:         ENDTRY
2728:     ENDPROC
2729: 
2730:     *==========================================================================
2731:     * HabilitarCampos - Habilita ou desabilita controles conforme contexto
2732:     * par_lHabilitar : .T. = habilitar controles editaveis, .F. = somente leitura
2733:     * Para form OPERACIONAL o unico campo editavel pelo usuario e a coluna
2734:     * Produzir (Column6) do grid principal.
2735:     *==========================================================================
2736:     PROCEDURE HabilitarCampos(par_lHabilitar)
2737:         LOCAL loc_lHab
2738:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2739: 
2740:         TRY
2741:             *-- Coluna Produzir do grid principal
2742:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2743:                 IF loc_lHab
2744:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2745:                     IF USED("crSigCdPam")
2746:                         SELECT crSigCdPam
2747:                         IF EMPTY(crSigCdPam.TransfRes)
2748:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2749:                         ELSE
2750:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2751:                         ENDIF
2752:                     ELSE
2753:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2754:                     ENDIF
2755:                 ELSE
2756:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2757:                 ENDIF
2758:             ENDIF
2759: 
2760:             *-- Botoes de acao
2761:             THIS.AjustarBotoesPorModo()
2762:         CATCH TO loc_oErro
2763:             MsgErro(loc_oErro.Message, "Erro")
2764:         ENDTRY
2765:     ENDPROC
2766: 
2767:     *==========================================================================
2768:     * LimparCampos - Zera totais do form sem liberar cursores do form pai
2769:     * Em form OPERACIONAL os cursores pertencem ao form pai; este metodo
2770:     * apenas zera a exibicao de totais e limpa os overlays.
2771:     *==========================================================================
2772:     PROCEDURE LimparCampos
2773:         TRY
2774:             *-- Zerar totalizadores
2775:             IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2776:                 THIS.txt_4c_Tot_Qtd.Value = 0
2777:             ENDIF
2778:             IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2779:                 THIS.txt_4c_Tot_Est.Value = 0
2780:             ENDIF
2781:             IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2782:                 THIS.txt_4c_Tot_Prz.Value = 0
2783:             ENDIF
2784: 
2785:             *-- Zerar totalizadores do Container3 (saldo por grupo/conta)
2786:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2787:                 THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = 0
2788:                 THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = 0
2789:                 THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = 0
2790:                 THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = ""
2791:                 THIS.cnt_4c_Container3.txt_4c__dconta.Value = ""
2792:             ENDIF
2793: 
2794:             *-- Limpar label de observacao
2795:             IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
2796:                 THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2797:             ENDIF
2798: 
2799:             *-- Ocultar overlays flutuantes
2800:             THIS.ConfigurarPaginaLista()
2801:         CATCH TO loc_oErro
2802:             MsgErro(loc_oErro.Message, "Erro")
2803:         ENDTRY
2804:     ENDPROC
2805: 
2806:     *==========================================================================
2807:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme contexto atual
2808:     * Em form OPERACIONAL o "modo" eh determinado pelo estado dos cursores:
2809:     *   - Sem TmpFinal    -> apenas Cancelar disponivel
2810:     *   - Com TmpFinal    -> todos os botoes operacionais disponiveis
2811:     *   - Overlay ativo   -> botoes principais desabilitados (gerenciado pelos
2812:     *                        handlers Btn*Click individuais)
2813:     *==========================================================================
2814:     PROCEDURE AjustarBotoesPorModo
2815:         LOCAL loc_lTemDados, loc_lPodeAcao
2816:         loc_lTemDados = .F.
2817:         loc_lPodeAcao = .F.
2818: 
2819:         TRY
2820:             *-- Verificar se ha dados carregados
2821:             IF USED("TmpFinal")
2822:                 loc_lTemDados = RECCOUNT("TmpFinal") > 0
2823:             ENDIF
2824: 
2825:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2826:             IF loc_lTemDados AND USED("crSigCdPam")
2827:                 SELECT crSigCdPam
2828:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2829:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2830:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2831:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2832:                                 !THIS.this_lReserva
2833:             ENDIF
2834: 
2835:             *-- Aplicar estado aos botoes
2836:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2837:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2838:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2839:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2840:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2841:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2842:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
2843:         CATCH TO loc_oErro
2844:             MsgErro(loc_oErro.Message, "Erro")
2845:         ENDTRY
2846:     ENDPROC
2847: 
2848: ENDDEFINE

