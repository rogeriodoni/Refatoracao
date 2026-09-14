# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 199: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS GRID (1231 linhas total):

*-- Linhas 63 a 92:
63:                 IF USED("cursor_4c_Dados")
64:                     USE IN cursor_4c_Dados
65:                 ENDIF
66:                 SET NULL ON
67:                 CREATE CURSOR cursor_4c_Dados (;
68:                     Checks     N(1)    NULL,;
69:                     grupos     C(10)   NULL,;
70:                     Contas     C(10)   NULL,;
71:                     Rclis      C(30)   NULL,;
72:                     emails     C(50)   NULL,;
73:                     mensagems  M,;
74:                     EmpDopNums C(29)   NULL,;
75:                     prioridade C(15)   NULL;
76:                 )
77:                 SET NULL OFF
78:                 INDEX ON Contas  TAG Contas
79:                 INDEX ON Rclis   TAG Rclis
80:                 INDEX ON emails  TAG Emails
81: 
82:                 *-- Cria estrutura visual (form OPERACIONAL usa layout flat, sem PageFrame real)
83:                 THIS.ConfigurarPageFrame()
84: 
85:                 THIS.TornarControlesVisiveis(THIS)
86: 
87:                 THIS.CarregarDados()
88: 
89:                 *-- Modo automatico: email ja foi enviado, impede exibicao do form
90:                 IF THIS.this_lAutomatico
91:                     loc_lSucesso = .F.
92:                 ENDIF

*-- Linhas 136 a 345:
136:     PROTECTED PROCEDURE ConfigurarPaginaDados()
137:         LOCAL loc_oGrid
138: 
139:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
140:             RETURN .F.
141:         ENDIF
142:         loc_oGrid = THIS.grd_4c_Dados
143: 
144:         *-- Sort inicial: Nome (Column3) marcado com cor de destaque teal
145:         *-- Espelha comportamento do Header.Click original (RGB 64,128,128)
146:         loc_oGrid.Column1.Header1.BackColor = RGB(192, 192, 192)
147:         loc_oGrid.Column2.Header1.BackColor = RGB(192, 192, 192)
148:         loc_oGrid.Column3.Header1.BackColor = RGB(64, 128, 128)
149:         loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
150:         loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)
151: 
152:         *-- Alinhamento do header do checkbox (centralizado)
153:         loc_oGrid.Column1.Header1.Alignment = 2
154: 
155:         *-- Modo somente-leitura no grid inteiro exceto checkbox
156:         loc_oGrid.Column2.ReadOnly = .T.
157:         loc_oGrid.Column3.ReadOnly = .T.
158:         loc_oGrid.Column5.ReadOnly = .T.
159: 
160:         RETURN .T.
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
165:     * Layout original:
166:     *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
167:     *   Column5(ordem 1) = CheckBox, Width=17
168:     *   Column1(ordem 2) = Conta,    Width=80
169:     *   Column2(ordem 3) = Nome,     Width=290
170:     *   Column3(ordem 4) = Email,    Width=290
171:     *   Column4(ordem 5) = Mensagem, Width=290
172:     *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg
173:     *   apaga:   Top=84, Left=43, W=40, H=40, Picture=cadastro_excluir_26.jpg
174:     *   btnEmail:Top=3,  Left=850,W=75, H=75, Picture=geral_envelope_60.jpg
175:     *--------------------------------------------------------------------------
176:     PROTECTED PROCEDURE ConfigurarPaginaLista()
177:         LOCAL loc_oGrid, loc_oCol
178: 
179:         *-- Grid principal
180:         THIS.AddObject("grd_4c_Dados", "Grid")
181:         loc_oGrid = THIS.grd_4c_Dados
182:         WITH loc_oGrid
183:             .Top              = 126
184:             .Left             = 3
185:             .Width            = 993
186:             .Height           = 469
187:             .ColumnCount      = 5
188:             .FontName         = "Verdana"
189:             .FontSize         = 8
190:             .RecordMark       = .F.
191:             .DeleteMark       = .F.
192:             .RowHeight        = 18
193:             .GridLines        = 1
194:             .GridLineColor    = RGB(238, 238, 238)
195:             .HighlightBackColor = RGB(255, 255, 255)
196:             .HighlightForeColor = RGB(15, 41, 104)
197:             .HighlightStyle   = 2
198:             .ScrollBars       = 2
199:             .RecordSource     = "cursor_4c_Dados"
200:             .Visible          = .T.
201: 
202:             *-- Coluna 1: CheckBox (selecao)
203:             WITH .Column1
204:                 .Width         = 17
205:                 .ColumnOrder   = 1
206:                 .ReadOnly      = .F.
207:                 .Sparse        = .F.
208:                 .FontName      = "Verdana"
209:                 .FontSize      = 8
210:                 .AddObject("Check1", "CheckBox")
211:                 WITH .Check1
212:                     .Caption   = ""
213:                     .Value     = 0
214:                     .Visible   = .T.
215:                 ENDWITH
216:                 .CurrentControl  = "Check1"
217:                 .ControlSource   = "cursor_4c_Dados.Checks"
218:                 .Header1.Caption = ""
219:                 .Header1.FontName = "Tahoma"
220:                 .Header1.FontSize = 8
221:             ENDWITH
222: 
223:             *-- Coluna 2: Conta
224:             WITH .Column2
225:                 .Width         = 80
226:                 .ColumnOrder   = 2
227:                 .ReadOnly      = .T.
228:                 .FontName      = "Verdana"
229:                 .FontSize      = 8
230:                 .ControlSource = "cursor_4c_Dados.Contas"
231:                 .AddObject("Text1", "TextBox")
232:                 WITH .Text1
233:                     .FontName    = "Verdana"
234:                     .FontSize    = 8
235:                     .BorderStyle = 0
236:                     .Margin      = 0
237:                     .ReadOnly    = .T.
238:                     .ForeColor   = RGB(0, 0, 0)
239:                     .BackColor   = RGB(255, 255, 255)
240:                     .Visible     = .T.
241:                 ENDWITH
242:                 .CurrentControl  = "Text1"
243:                 .Header1.Caption  = " Conta"
244:                 .Header1.FontName = "Tahoma"
245:                 .Header1.FontSize = 8
246:                 .Header1.Alignment = 2
247:             ENDWITH
248: 
249:             *-- Coluna 3: Nome
250:             WITH .Column3
251:                 .Width         = 290
252:                 .ColumnOrder   = 3
253:                 .ReadOnly      = .T.
254:                 .FontName      = "Verdana"
255:                 .FontSize      = 8
256:                 .ControlSource = "cursor_4c_Dados.Rclis"
257:                 .AddObject("Text1", "TextBox")
258:                 WITH .Text1
259:                     .FontName    = "Verdana"
260:                     .FontSize    = 8
261:                     .BorderStyle = 0
262:                     .Margin      = 0
263:                     .ReadOnly    = .T.
264:                     .ForeColor   = RGB(0, 0, 0)
265:                     .BackColor   = RGB(255, 255, 255)
266:                     .Visible     = .T.
267:                 ENDWITH
268:                 .CurrentControl  = "Text1"
269:                 .Header1.Caption  = " Nome"
270:                 .Header1.FontName = "Tahoma"
271:                 .Header1.FontSize = 8
272:                 .Header1.Alignment = 2
273:             ENDWITH
274: 
275:             *-- Coluna 4: Email
276:             WITH .Column4
277:                 .Width         = 290
278:                 .ColumnOrder   = 4
279:                 .ReadOnly      = .F.
280:                 .FontName      = "Verdana"
281:                 .FontSize      = 8
282:                 .ControlSource = "cursor_4c_Dados.emails"
283:                 .AddObject("Text1", "TextBox")
284:                 WITH .Text1
285:                     .FontName    = "Verdana"
286:                     .FontSize    = 8
287:                     .BorderStyle = 0
288:                     .Margin      = 0
289:                     .ReadOnly    = .F.
290:                     .ForeColor   = RGB(0, 0, 0)
291:                     .BackColor   = RGB(255, 255, 255)
292:                     .Visible     = .T.
293:                 ENDWITH
294:                 .CurrentControl  = "Text1"
295:                 .Header1.Caption  = "Email"
296:                 .Header1.FontName = "Tahoma"
297:                 .Header1.FontSize = 8
298:                 .Header1.Alignment = 2
299:             ENDWITH
300: 
301:             *-- Coluna 5: Movimentacao de Estoque (EmpDopNums - identico ao original)
302:             WITH .Column5
303:                 .Width         = 290
304:                 .ColumnOrder   = 5
305:                 .ReadOnly      = .T.
306:                 .Sparse        = .F.
307:                 .FontName      = "Verdana"
308:                 .FontSize      = 8
309:                 .ControlSource = "cursor_4c_Dados.EmpDopNums"
310:                 .AddObject("Edit1", "EditBox")
311:                 WITH .Edit1
312:                     .FontName      = "Verdana"
313:                     .FontSize      = 8
314:                     .BorderStyle   = 0
315:                     .ReadOnly      = .T.
316:                     .SpecialEffect = 1
317:                     .Visible       = .T.
318:                 ENDWITH
319:                 .CurrentControl  = "Edit1"
320:                 .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
321:                 .Header1.FontName = "Tahoma"
322:                 .Header1.FontSize = 8
323:                 .Header1.Alignment = 2
324:             ENDWITH
325:         ENDWITH
326: 
327:         *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
328:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
329:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
330:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
331: 
332:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
333:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
334: 
335:         *-- Botao SelTudo (Marcar Todos)
336:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
337:         WITH THIS.cmd_4c_SelTudo
338:             .Top          = 84
339:             .Left         = 4
340:             .Height       = 40
341:             .Width        = 40
342:             .FontName     = "Verdana"
343:             .FontSize     = 8
344:             .WordWrap     = .T.
345:             .Caption      = ""

*-- Linhas 405 a 488:
405:     PROCEDURE GrdHeader2Click()
406:         SELECT cursor_4c_Dados
407:         SET ORDER TO TAG Contas
408:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
409:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
410:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
411:         THIS.grd_4c_Dados.Refresh()
412:     ENDPROC
413: 
414:     *--------------------------------------------------------------------------
415:     * GrdHeader3Click - Ordena grid pela coluna Nome
416:     *--------------------------------------------------------------------------
417:     PROCEDURE GrdHeader3Click()
418:         SELECT cursor_4c_Dados
419:         SET ORDER TO TAG Rclis
420:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
421:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
422:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
423:         THIS.grd_4c_Dados.Refresh()
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * GrdHeader4Click - Ordena grid pela coluna Email
428:     *--------------------------------------------------------------------------
429:     PROCEDURE GrdHeader4Click()
430:         SELECT cursor_4c_Dados
431:         SET ORDER TO TAG Emails
432:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
433:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
434:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
435:         THIS.grd_4c_Dados.Refresh()
436:     ENDPROC
437: 
438:     *--------------------------------------------------------------------------
439:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
440:     *--------------------------------------------------------------------------
441:     PROCEDURE ChkSelChange()
442:         LOCAL loc_oChk
443:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
444:         IF USED("cursor_4c_Dados")
445:             SELECT cursor_4c_Dados
446:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
447:         ENDIF
448:     ENDPROC
449: 
450:     *--------------------------------------------------------------------------
451:     * CmdSelTudoClick - Marca todos os registros
452:     *--------------------------------------------------------------------------
453:     PROCEDURE CmdSelTudoClick()
454:         IF USED("cursor_4c_Dados")
455:             SELECT cursor_4c_Dados
456:             GO TOP
457:             REPLACE ALL Checks WITH 1
458:             GO TOP
459:         ENDIF
460:         THIS.grd_4c_Dados.Refresh()
461:     ENDPROC
462: 
463:     *--------------------------------------------------------------------------
464:     * CmdApagaClick - Desmarca todos os registros
465:     *--------------------------------------------------------------------------
466:     PROCEDURE CmdApagaClick()
467:         IF USED("cursor_4c_Dados")
468:             SELECT cursor_4c_Dados
469:             GO TOP
470:             REPLACE ALL Checks WITH 0
471:             GO TOP
472:         ENDIF
473:         THIS.grd_4c_Dados.Refresh()
474:     ENDPROC
475: 
476:     *--------------------------------------------------------------------------
477:     * ConfigurarCabecalho - Cria container de cabecalho superior
478:     *--------------------------------------------------------------------------
479:     PROTECTED PROCEDURE ConfigurarCabecalho()
480:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
481:         WITH THIS.cnt_4c_Cabecalho
482:             .Top         = 0
483:             .Left        = 0
484:             .Width       = THIS.Width
485:             .Height      = 80
486:             .BorderWidth = 0
487:             .BackStyle   = 1
488:             .BackColor   = RGB(100, 100, 100)

*-- Linhas 643 a 662:
643:                 SELECT cursor_4c_Dados
644:                 SET ORDER TO TAG Rclis
645: 
646:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
647:                     THIS.grd_4c_Dados.Refresh()
648:                 ENDIF
649:             ENDIF
650: 
651:             *-- Modo automatico: envia email imediatamente sem interacao
652:             IF THIS.this_lAutomatico
653:                 THIS.CmdBtnEmailClick()
654:             ENDIF
655: 
656:         CATCH TO loc_oErro
657:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
658:                     "Erro ao carregar dados para email")
659:             loc_lResultado = .F.
660:         ENDTRY
661: 
662:         RETURN loc_lResultado

*-- Linhas 1209 a 1228:
1209:             SELECT cursor_4c_Dados
1210:             ZAP
1211:         ENDIF
1212:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1213:             THIS.grd_4c_Dados.Refresh()
1214:         ENDIF
1215:     ENDPROC
1216: 
1217:     *--------------------------------------------------------------------------
1218:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1219:     *--------------------------------------------------------------------------
1220:     PROCEDURE CarregarLista()
1221:         RETURN THIS.CarregarDados()
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD para ajustar
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE AjustarBotoesPorModo()
1228:         RETURN

