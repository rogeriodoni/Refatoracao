# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 201: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS GRID (1240 linhas total):

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
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
86: 
87:                 THIS.TornarControlesVisiveis(THIS)
88: 
89:                 THIS.CarregarDados()
90: 
91:                 *-- Modo automatico: email ja foi enviado, impede exibicao do form
92:                 IF THIS.this_lAutomatico

*-- Linhas 138 a 354:
138:     PROTECTED PROCEDURE ConfigurarPaginaDados()
139:         LOCAL loc_oGrid
140: 
141:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
142:             RETURN .F.
143:         ENDIF
144:         loc_oGrid = THIS.grd_4c_Dados
145: 
146:         *-- Sort inicial: Nome (Column3) marcado com cor de destaque teal
147:         *-- Espelha comportamento do Header.Click original (RGB 64,128,128)
148:         loc_oGrid.Column1.Header1.BackColor = RGB(192, 192, 192)
149:         loc_oGrid.Column2.Header1.BackColor = RGB(192, 192, 192)
150:         loc_oGrid.Column3.Header1.BackColor = RGB(64, 128, 128)
151:         loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
152:         loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)
153: 
154:         *-- Alinhamento do header do checkbox (centralizado)
155:         loc_oGrid.Column1.Header1.Alignment = 2
156: 
157:         *-- Modo somente-leitura no grid inteiro exceto checkbox
158:         loc_oGrid.Column2.ReadOnly = .T.
159:         loc_oGrid.Column3.ReadOnly = .T.
160:         loc_oGrid.Column5.ReadOnly = .T.
161: 
162:         RETURN .T.
163:     ENDPROC
164: 
165:     *--------------------------------------------------------------------------
166:     * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
167:     * Layout original:
168:     *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
169:     *   Column5(ordem 1) = CheckBox, Width=17
170:     *   Column1(ordem 2) = Conta,    Width=80
171:     *   Column2(ordem 3) = Nome,     Width=290
172:     *   Column3(ordem 4) = Email,    Width=290
173:     *   Column4(ordem 5) = Mensagem, Width=290
174:     *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg
175:     *   apaga:   Top=84, Left=43, W=40, H=40, Picture=cadastro_excluir_26.jpg
176:     *   btnEmail:Top=3,  Left=850,W=75, H=75, Picture=geral_envelope_60.jpg
177:     *--------------------------------------------------------------------------
178:     PROTECTED PROCEDURE ConfigurarPaginaLista()
179:         LOCAL loc_oGrid, loc_oCol
180: 
181:         *-- Grid principal
182:         THIS.AddObject("grd_4c_Dados", "Grid")
183:         loc_oGrid = THIS.grd_4c_Dados
184:         WITH loc_oGrid
185:             .Top              = 126
186:             .Left             = 3
187:             .Width            = 993
188:             .Height           = 469
189:             .ColumnCount      = 5
190:             .FontName         = "Verdana"
191:             .FontSize         = 8
192:             .RecordMark       = .F.
193:             .DeleteMark       = .F.
194:             .RowHeight        = 18
195:             .GridLines        = 1
196:             .GridLineColor    = RGB(238, 238, 238)
197:             .HighlightBackColor = RGB(255, 255, 255)
198:             .HighlightForeColor = RGB(15, 41, 104)
199:             .HighlightStyle   = 2
200:             .ScrollBars       = 2
201:             .RecordSource     = "cursor_4c_Dados"
202:             .Visible          = .T.
203: 
204:             *-- Coluna 1: CheckBox (selecao)
205:             WITH .Column1
206:                 .Width         = 17
207:                 .ColumnOrder   = 1
208:                 .ReadOnly      = .F.
209:                 .Sparse        = .F.
210:                 .FontName      = "Verdana"
211:                 .FontSize      = 8
212:                 .AddObject("Check1", "CheckBox")
213:                 WITH .Check1
214:                     .Caption   = ""
215:                     .Value     = 0
216:                     .Visible   = .T.
217:                 ENDWITH
218:                 .CurrentControl  = "Check1"
219:                 .ControlSource   = "cursor_4c_Dados.Checks"
220:                 .Header1.Caption = ""
221:                 .Header1.FontName = "Tahoma"
222:                 .Header1.FontSize = 8
223:             ENDWITH
224: 
225:             *-- Coluna 2: Conta
226:             WITH .Column2
227:                 .Width         = 80
228:                 .ColumnOrder   = 2
229:                 .ReadOnly      = .T.
230:                 .FontName      = "Verdana"
231:                 .FontSize      = 8
232:                 .ControlSource = "cursor_4c_Dados.Contas"
233:                 .AddObject("Text1", "TextBox")
234:                 WITH .Text1
235:                     .FontName    = "Verdana"
236:                     .FontSize    = 8
237:                     .BorderStyle = 0
238:                     .Margin      = 0
239:                     .ReadOnly    = .T.
240:                     .ForeColor   = RGB(0, 0, 0)
241:                     .BackColor   = RGB(255, 255, 255)
242:                     .Visible     = .T.
243:                 ENDWITH
244:                 .CurrentControl  = "Text1"
245:                 .Header1.Caption  = "Conta"
246:                 .Header1.FontName = "Tahoma"
247:                 .Header1.FontSize = 8
248:                 .Header1.Alignment = 2
249:             ENDWITH
250: 
251:             *-- Coluna 3: Nome
252:             WITH .Column3
253:                 .Width         = 290
254:                 .ColumnOrder   = 3
255:                 .ReadOnly      = .T.
256:                 .FontName      = "Verdana"
257:                 .FontSize      = 8
258:                 .ControlSource = "cursor_4c_Dados.Rclis"
259:                 .AddObject("Text1", "TextBox")
260:                 WITH .Text1
261:                     .FontName    = "Verdana"
262:                     .FontSize    = 8
263:                     .BorderStyle = 0
264:                     .Margin      = 0
265:                     .ReadOnly    = .T.
266:                     .ForeColor   = RGB(0, 0, 0)
267:                     .BackColor   = RGB(255, 255, 255)
268:                     .Visible     = .T.
269:                 ENDWITH
270:                 .CurrentControl  = "Text1"
271:                 .Header1.Caption  = "Nome"
272:                 .Header1.FontName = "Tahoma"
273:                 .Header1.FontSize = 8
274:                 .Header1.Alignment = 2
275:             ENDWITH
276: 
277:             *-- Coluna 4: Email
278:             WITH .Column4
279:                 .Width         = 290
280:                 .ColumnOrder   = 4
281:                 .ReadOnly      = .F.
282:                 .FontName      = "Verdana"
283:                 .FontSize      = 8
284:                 .ControlSource = "cursor_4c_Dados.emails"
285:                 .AddObject("Text1", "TextBox")
286:                 WITH .Text1
287:                     .FontName    = "Verdana"
288:                     .FontSize    = 8
289:                     .BorderStyle = 0
290:                     .Margin      = 0
291:                     .ReadOnly    = .F.
292:                     .ForeColor   = RGB(0, 0, 0)
293:                     .BackColor   = RGB(255, 255, 255)
294:                     .Visible     = .T.
295:                 ENDWITH
296:                 .CurrentControl  = "Text1"
297:                 .Header1.Caption  = "Email"
298:                 .Header1.FontName = "Tahoma"
299:                 .Header1.FontSize = 8
300:                 .Header1.Alignment = 2
301:             ENDWITH
302: 
303:             *-- Coluna 5: Movimentacao de Estoque (EmpDopNums - identico ao original)
304:             WITH .Column5
305:                 .Width         = 290
306:                 .ColumnOrder   = 5
307:                 .ReadOnly      = .T.
308:                 .Sparse        = .F.
309:                 .FontName      = "Verdana"
310:                 .FontSize      = 8
311:                 .ControlSource = "cursor_4c_Dados.EmpDopNums"
312:                 .AddObject("Edit1", "EditBox")
313:                 WITH .Edit1
314:                     .FontName      = "Verdana"
315:                     .FontSize      = 8
316:                     .BorderStyle   = 0
317:                     .ReadOnly      = .T.
318:                     .SpecialEffect = 1
319:                     .Visible       = .T.
320:                 ENDWITH
321:                 .CurrentControl  = "Edit1"
322:                 .Header1.Caption  = "Movimenta" + CHR(231) + CHR(227) + "o de Estoque"
323:                 .Header1.FontName = "Tahoma"
324:                 .Header1.FontSize = 8
325:                 .Header1.Alignment = 2
326:             ENDWITH
327:         ENDWITH
328: 
329:         *-- Re-definir ControlSource apos RecordSource (evita auto-bind por posicao de campo)
330:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Checks"
331:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Contas"
332:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Rclis"
333:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emails"
334:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
335: 
336:         *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
337:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
338:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
339:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
340: 
341:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
342:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
343: 
344:         *-- Botao SelTudo (Marcar Todos)
345:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
346:         WITH THIS.cmd_4c_SelTudo
347:             .Top          = 84
348:             .Left         = 4
349:             .Height       = 40
350:             .Width        = 40
351:             .FontName     = "Verdana"
352:             .FontSize     = 8
353:             .WordWrap     = .T.
354:             .Caption      = ""

*-- Linhas 414 a 497:
414:     PROCEDURE GrdHeader2Click()
415:         SELECT cursor_4c_Dados
416:         SET ORDER TO TAG Contas
417:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
418:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
419:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
420:         THIS.grd_4c_Dados.Refresh()
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * GrdHeader3Click - Ordena grid pela coluna Nome
425:     *--------------------------------------------------------------------------
426:     PROCEDURE GrdHeader3Click()
427:         SELECT cursor_4c_Dados
428:         SET ORDER TO TAG Rclis
429:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
430:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
431:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
432:         THIS.grd_4c_Dados.Refresh()
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * GrdHeader4Click - Ordena grid pela coluna Email
437:     *--------------------------------------------------------------------------
438:     PROCEDURE GrdHeader4Click()
439:         SELECT cursor_4c_Dados
440:         SET ORDER TO TAG Emails
441:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
442:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
443:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
444:         THIS.grd_4c_Dados.Refresh()
445:     ENDPROC
446: 
447:     *--------------------------------------------------------------------------
448:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
449:     *--------------------------------------------------------------------------
450:     PROCEDURE ChkSelChange()
451:         LOCAL loc_oChk
452:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
453:         IF USED("cursor_4c_Dados")
454:             SELECT cursor_4c_Dados
455:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
456:         ENDIF
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * CmdSelTudoClick - Marca todos os registros
461:     *--------------------------------------------------------------------------
462:     PROCEDURE CmdSelTudoClick()
463:         IF USED("cursor_4c_Dados")
464:             SELECT cursor_4c_Dados
465:             GO TOP
466:             REPLACE ALL Checks WITH 1
467:             GO TOP
468:         ENDIF
469:         THIS.grd_4c_Dados.Refresh()
470:     ENDPROC
471: 
472:     *--------------------------------------------------------------------------
473:     * CmdApagaClick - Desmarca todos os registros
474:     *--------------------------------------------------------------------------
475:     PROCEDURE CmdApagaClick()
476:         IF USED("cursor_4c_Dados")
477:             SELECT cursor_4c_Dados
478:             GO TOP
479:             REPLACE ALL Checks WITH 0
480:             GO TOP
481:         ENDIF
482:         THIS.grd_4c_Dados.Refresh()
483:     ENDPROC
484: 
485:     *--------------------------------------------------------------------------
486:     * ConfigurarCabecalho - Cria container de cabecalho superior
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarCabecalho()
489:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
490:         WITH THIS.cnt_4c_Cabecalho
491:             .Top         = 0
492:             .Left        = 0
493:             .Width       = THIS.Width
494:             .Height      = 80
495:             .BorderWidth = 0
496:             .BackStyle   = 1
497:             .BackColor   = RGB(100, 100, 100)

*-- Linhas 652 a 671:
652:                 SELECT cursor_4c_Dados
653:                 SET ORDER TO TAG Rclis
654: 
655:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
656:                     THIS.grd_4c_Dados.Refresh()
657:                 ENDIF
658:             ENDIF
659: 
660:             *-- Modo automatico: envia email imediatamente sem interacao
661:             IF THIS.this_lAutomatico
662:                 THIS.CmdBtnEmailClick()
663:             ENDIF
664: 
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
667:                     "Erro ao carregar dados para email")
668:             loc_lResultado = .F.
669:         ENDTRY
670: 
671:         RETURN loc_lResultado

*-- Linhas 1218 a 1237:
1218:             SELECT cursor_4c_Dados
1219:             ZAP
1220:         ENDIF
1221:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1222:             THIS.grd_4c_Dados.Refresh()
1223:         ENDIF
1224:     ENDPROC
1225: 
1226:     *--------------------------------------------------------------------------
1227:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1228:     *--------------------------------------------------------------------------
1229:     PROCEDURE CarregarLista()
1230:         RETURN THIS.CarregarDados()
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------
1234:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD para ajustar
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE AjustarBotoesPorModo()
1237:         RETURN

