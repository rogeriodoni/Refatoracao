# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 234: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 284: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 440: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 465: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFNF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1151 linhas total):

*-- Linhas 39 a 59:
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.Caption = "Finalizadoras n" + CHR(227) + "o Fiscal"
43: 
44:             THIS.this_oBusinessObject = CREATEOBJECT("FNFBO")
45: 
46:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
47:                 MostrarErro("Erro ao criar FNFBO" + CHR(13) + ;
48:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
49:                     "FormFNF.InicializarForm")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55: 
56:                 THIS.pgf_4c_Paginas.Visible   = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 

*-- Linhas 83 a 102:
83: 
84:         WITH THIS.pgf_4c_Paginas
85:             .PageCount = 2
86:             .Top       = -29
87:             .Left      = 0
88:             .Width     = THIS.Width
89:             .Height    = THIS.Height + 29
90:             .Tabs      = .F.
91:             .Visible   = .T.
92: 
93:             .Page1.Caption   = "Lista"
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()

*-- Linhas 117 a 155:
117:         *-- Cabecalho (cntSombra legado): Top=30 (1+29 compensacao PageFrame)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 30
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BackStyle   = 1
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width - 20
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width - 20
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 349:
162:         *-- Container Botoes CRUD (Grupo_Op legado): Top=29 (0+29), Left=542
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPagina.cnt_4c_Botoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle = 0
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         *-- Botao Incluir: Left=5
175:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .FontName        = "Comic Sans MS"
185:             .FontSize        = 8
186:             .FontBold        = .T.
187:             .FontItalic      = .T.
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .MousePointer    = 15
193:             .WordWrap        = .T.
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         *-- Botao Visualizar: Left=80
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .FontName        = "Comic Sans MS"
210:             .FontSize        = 8
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .ForeColor       = RGB(90, 90, 90)
214:             .BackColor       = RGB(255, 255, 255)
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .MousePointer    = 15
218:             .WordWrap        = .T.
219:             .AutoSize        = .F.
220:             .Visible         = .T.
221:         ENDWITH
222:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
223: 
224:         *-- Botao Alterar: Left=155
225:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
226:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
227:             .Caption         = "Alterar"
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .FontName        = "Comic Sans MS"
235:             .FontSize        = 8
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .ForeColor       = RGB(90, 90, 90)
239:             .BackColor       = RGB(255, 255, 255)
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .MousePointer    = 15
243:             .WordWrap        = .T.
244:             .AutoSize        = .F.
245:             .Visible         = .T.
246:         ENDWITH
247:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
248: 
249:         *-- Botao Excluir: Left=230
250:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
251:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
252:             .Caption         = "Excluir"
253:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
254:             .PicturePosition = 13
255:             .Top             = 5
256:             .Left            = 230
257:             .Width           = 75
258:             .Height          = 75
259:             .FontName        = "Comic Sans MS"
260:             .FontSize        = 8
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .ForeColor       = RGB(90, 90, 90)
264:             .BackColor       = RGB(255, 255, 255)
265:             .Themes          = .F.
266:             .SpecialEffect   = 0
267:             .MousePointer    = 15
268:             .WordWrap        = .T.
269:             .AutoSize        = .F.
270:             .Visible         = .T.
271:         ENDWITH
272:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
273: 
274:         *-- Botao Buscar: Left=305
275:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
276:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
277:             .Caption         = "Buscar"
278:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
279:             .PicturePosition = 13
280:             .Top             = 5
281:             .Left            = 305
282:             .Width           = 75
283:             .Height          = 75
284:             .FontName        = "Comic Sans MS"
285:             .FontSize        = 8
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .ForeColor       = RGB(90, 90, 90)
289:             .BackColor       = RGB(255, 255, 255)
290:             .Themes          = .F.
291:             .SpecialEffect   = 0
292:             .MousePointer    = 15
293:             .WordWrap        = .T.
294:             .AutoSize        = .F.
295:             .Visible         = .T.
296:         ENDWITH
297:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
298: 
299:         *-- Container Encerrar (padrao canonico CLAUDE.md #10): Left=917, Width=90
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         WITH loc_oPagina.cnt_4c_Saida
302:             .Top         = 29
303:             .Left        = 917
304:             .Width       = 90
305:             .Height      = 85
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .FontBold        = .T.
323:             .FontItalic      = .T.
324:             .ForeColor       = RGB(90, 90, 90)
325:             .BackColor       = RGB(255, 255, 255)
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid lista (Grupo_Grade legado): Top=117 (88+29), Left=26, Width=890
336:         *-- RecordSource e ColumnCount FORA do WITH (Problema #36)
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         loc_oGrid = loc_oPagina.grd_4c_Lista
339:         loc_oGrid.RecordSource = ""
340:         loc_oGrid.ColumnCount  = 4
341: 
342:         WITH loc_oGrid
343:             .Top                = 117
344:             .Left               = 26
345:             .Width              = 890
346:             .Height             = 498
347:             .FontName           = "Verdana"
348:             .FontSize           = 8
349:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 365 a 504:
365:         WITH loc_oGrid.Column1
366:             .Width           = 160
367:             .ReadOnly        = .T.
368:             .Header1.Caption = "Impressora"
369:         ENDWITH
370: 
371:         *-- Column2: ordems (Ordem, 80px) alinhado a direita (numerico)
372:         WITH loc_oGrid.Column2
373:             .Width           = 80
374:             .ReadOnly        = .T.
375:             .Alignment       = 2
376:             .Header1.Caption = "Ordem"
377:         ENDWITH
378: 
379:         *-- Column3: descrs (Descricao, 337px)
380:         WITH loc_oGrid.Column3
381:             .Width           = 337
382:             .ReadOnly        = .T.
383:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
384:         ENDWITH
385: 
386:         *-- Column4: nfixos (Fixo, 50px) - CheckBox visual para campo 0/1
387:         WITH loc_oGrid.Column4
388:             .Width           = 50
389:             .ReadOnly        = .T.
390:             .Sparse          = .F.
391:             .Header1.Caption = "Fixo"
392:         ENDWITH
393:         loc_oGrid.Column4.AddObject("Check1", "CheckBox")
394:         WITH loc_oGrid.Column4.Check1
395:             .Alignment = 0
396:             .ReadOnly  = .T.
397:             .Visible   = .T.
398:             .Top       = 9
399:             .Left      = 2
400:             .Height    = 17
401:             .Width     = 22
402:         ENDWITH
403: 
404:         THIS.TornarControlesVisiveis(loc_oPagina)
405:     ENDPROC
406: 
407:     *===========================================================================
408:     * ConfigurarPaginaDados - Page2: botoes acao + todos os campos do legado
409:     * Coords = original + 29 (compensacao PageFrame.Top=-29)
410:     *===========================================================================
411:     PROTECTED PROCEDURE ConfigurarPaginaDados()
412:         LOCAL loc_oPagina
413:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
414: 
415:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
416:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
417: 
418:         *-- Container botoes acao (Grupo_Salva legado): Top=33 (4+29), Left=842
419:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
420:         WITH loc_oPagina.cnt_4c_BotoesAcao
421:             .Top         = 33
422:             .Left        = 842
423:             .Width       = 160
424:             .Height      = 85
425:             .BackStyle   = 0
426:             .BorderWidth = 0
427:             .Visible     = .T.
428:         ENDWITH
429: 
430:         *-- Botao Confirmar (Salva legado): Left=5, Top=5
431:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
432:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
433:             .Caption         = "Confirmar"
434:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
435:             .PicturePosition = 13
436:             .Top             = 5
437:             .Left            = 5
438:             .Width           = 75
439:             .Height          = 75
440:             .FontName        = "Comic Sans MS"
441:             .FontSize        = 8
442:             .FontBold        = .T.
443:             .FontItalic      = .T.
444:             .ForeColor       = RGB(90, 90, 90)
445:             .BackColor       = RGB(255, 255, 255)
446:             .Themes          = .F.
447:             .SpecialEffect   = 0
448:             .MousePointer    = 15
449:             .WordWrap        = .T.
450:             .AutoSize        = .F.
451:             .Visible         = .T.
452:         ENDWITH
453:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
454: 
455:         *-- Botao Cancelar: Left=88, Top=5
456:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
457:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
458:             .Caption         = "Encerrar"
459:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
460:             .PicturePosition = 13
461:             .Top             = 5
462:             .Left            = 88
463:             .Width           = 75
464:             .Height          = 75
465:             .FontName        = "Comic Sans MS"
466:             .FontSize        = 8
467:             .FontBold        = .T.
468:             .FontItalic      = .T.
469:             .ForeColor       = RGB(90, 90, 90)
470:             .BackColor       = RGB(255, 255, 255)
471:             .Themes          = .F.
472:             .SpecialEffect   = 0
473:             .MousePointer    = 15
474:             .WordWrap        = .T.
475:             .AutoSize        = .F.
476:             .Visible         = .T.
477:         ENDWITH
478:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
479: 
480:         *-- Say6 (Impressora): Top=162 (133+29), Left=123 ForeColor=RGB(36,84,155)
481:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
482:         WITH loc_oPagina.lbl_4c_Label6
483:             .Caption   = "Impressora : "
484:             .Top       = 162
485:             .Left      = 123
486:             .FontName  = "Verdana"
487:             .FontSize  = 8
488:             .ForeColor = RGB(36, 84, 155)
489:             .BackStyle = 0
490:             .AutoSize  = .T.
491:             .Visible   = .T.
492:         ENDWITH
493: 
494:         *-- Cmb_Imp (Impressora): Top=158 (129+29), Left=203, Width=105, Height=24
495:         *-- RowSourceType=0 populado com AddItem (lista fixa do legado)
496:         loc_oPagina.AddObject("cbo_4c_Imps", "ComboBox")
497:         WITH loc_oPagina.cbo_4c_Imps
498:             .Top           = 158
499:             .Left          = 203
500:             .Width         = 105
501:             .Height        = 24
502:             .RowSourceType = 0
503:             .RowSource     = ""
504:             .Style         = 0

*-- Linhas 520 a 645:
520:         BINDEVENT(loc_oPagina.cbo_4c_Imps, "InteractiveChange", THIS, "ImpInteractiveChange")
521: 
522:         *-- Say1 (Ordem): Top=187 (158+29), Left=150
523:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
524:         WITH loc_oPagina.lbl_4c_Label1
525:             .Caption   = "Ordem : "
526:             .Top       = 187
527:             .Left      = 150
528:             .FontName  = "Verdana"
529:             .FontSize  = 8
530:             .ForeColor = RGB(36, 84, 155)
531:             .BackStyle = 0
532:             .AutoSize  = .T.
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         *-- Get_ordem (Ordem): Top=184 (155+29), Left=203, Width=24, InputMask="99"
537:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
538:         WITH loc_oPagina.txt_4c_Ordem
539:             .Top       = 184
540:             .Left      = 203
541:             .Width     = 24
542:             .Height    = 22
543:             .Value     = 0
544:             .InputMask = "99"
545:             .FontName  = "Verdana"
546:             .FontSize  = 8
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         *-- Say4 (Cod.Operacao): Top=212 (183+29), Left=107
551:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
552:         WITH loc_oPagina.lbl_4c_Label4
553:             .Caption   = "Cod.Opera" + CHR(231) + CHR(227) + "o : "
554:             .Top       = 212
555:             .Left      = 107
556:             .FontName  = "Verdana"
557:             .FontSize  = 8
558:             .ForeColor = RGB(36, 84, 155)
559:             .BackStyle = 0
560:             .AutoSize  = .T.
561:             .Visible   = .T.
562:         ENDWITH
563: 
564:         *-- Get_Opernf (Cod.Operacao): Top=209 (180+29), Left=203, Width=24, MaxLength=2
565:         loc_oPagina.AddObject("txt_4c_Opernf", "TextBox")
566:         WITH loc_oPagina.txt_4c_Opernf
567:             .Top       = 209
568:             .Left      = 203
569:             .Width     = 24
570:             .Height    = 22
571:             .Value     = ""
572:             .MaxLength = 2
573:             .FontName  = "Verdana"
574:             .FontSize  = 8
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         *-- Say5 (Cod.Abertura): Top=212 (183+29), Left=254
579:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
580:         WITH loc_oPagina.lbl_4c_Label5
581:             .Caption   = "Cod.Abertura : "
582:             .Top       = 212
583:             .Left      = 254
584:             .FontName  = "Verdana"
585:             .FontSize  = 8
586:             .ForeColor = RGB(36, 84, 155)
587:             .BackStyle = 0
588:             .AutoSize  = .T.
589:             .Visible   = .T.
590:         ENDWITH
591: 
592:         *-- fwget1 (Cod.Abertura): Top=209 (180+29), Left=346, Width=24, MaxLength=2
593:         *-- When event do legado: habilitado APENAS para SWEDA/NSWEDA
594:         loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
595:         WITH loc_oPagina.txt_4c_Fwget1
596:             .Top       = 209
597:             .Left      = 346
598:             .Width     = 24
599:             .Height    = 22
600:             .Value     = ""
601:             .MaxLength = 2
602:             .ReadOnly  = .T.
603:             .FontName  = "Verdana"
604:             .FontSize  = 8
605:             .Visible   = .T.
606:         ENDWITH
607: 
608:         *-- Say2 (Descricao): Top=237 (208+29), Left=133
609:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
610:         WITH loc_oPagina.lbl_4c_Label2
611:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
612:             .Top       = 237
613:             .Left      = 133
614:             .FontName  = "Verdana"
615:             .FontSize  = 8
616:             .ForeColor = RGB(36, 84, 155)
617:             .BackStyle = 0
618:             .AutoSize  = .T.
619:             .Visible   = .T.
620:         ENDWITH
621: 
622:         *-- Get_descr (Descricao): Top=234 (205+29), Left=203, Width=360
623:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
624:         WITH loc_oPagina.txt_4c_Descr
625:             .Top       = 234
626:             .Left      = 203
627:             .Width     = 360
628:             .Height    = 22
629:             .Value     = ""
630:             .FontName  = "Verdana"
631:             .FontSize  = 8
632:             .Visible   = .T.
633:         ENDWITH
634: 
635:         *-- Say3 (Fixo): Top=265 (236+29), Left=166
636:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
637:         WITH loc_oPagina.lbl_4c_Label3
638:             .Caption   = "Fixo : "
639:             .Top       = 265
640:             .Left      = 166
641:             .FontName  = "Verdana"
642:             .FontSize  = 8
643:             .ForeColor = RGB(36, 84, 155)
644:             .BackStyle = 0
645:             .AutoSize  = .T.

*-- Linhas 651 a 682:
651:         loc_oPagina.AddObject("opt_4c_Opc_fixo", "OptionGroup")
652:         WITH loc_oPagina.opt_4c_Opc_fixo
653:             .ButtonCount = 2
654:             .Top         = 260
655:             .Left        = 199
656:             .Width       = 100
657:             .Height      = 26
658:             .Value       = 2
659:             .BackStyle   = 0
660:             .BorderStyle = 0
661:             .Visible     = .T.
662:         ENDWITH
663:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(1)
664:             .Caption   = "Sim"
665:             .Left      = 5
666:             .Top       = 5
667:             .AutoSize  = .T.
668:             .FontName  = "Verdana"
669:             .FontSize  = 8
670:             .ForeColor = RGB(36, 84, 155)
671:             .BackStyle = 0
672:             .Themes    = .F.
673:         ENDWITH
674:         WITH loc_oPagina.opt_4c_Opc_fixo.Buttons(2)
675:             .Caption   = "N" + CHR(227) + "o"
676:             .Left      = 47
677:             .Top       = 5
678:             .AutoSize  = .T.
679:             .FontName  = "Verdana"
680:             .FontSize  = 8
681:             .ForeColor = RGB(36, 84, 155)
682:             .BackStyle = 0

*-- Linhas 712 a 723:
712:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.nfixos"
713: 
714:                 *-- Redefinir Headers APOS RecordSource (resets ao auto-bind)
715:                 loc_oGrid.Column1.Header1.Caption = "Impressora"
716:                 loc_oGrid.Column2.Header1.Caption = "Ordem"
717:                 loc_oGrid.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
718:                 loc_oGrid.Column4.Header1.Caption = "Fixo"
719: 
720:                 THIS.FormatarGridLista(loc_oGrid)
721:                 loc_lResultado = .T.
722:             ENDIF
723:         CATCH TO loException

*-- Linhas 1089 a 1110:
1089:         loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1090: 
1091:         TRY
1092:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1093:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1094:                     .cmd_4c_Incluir.Enabled    = loc_lNaLista
1095:                     .cmd_4c_Visualizar.Enabled = loc_lNaLista
1096:                     .cmd_4c_Alterar.Enabled    = loc_lNaLista
1097:                     .cmd_4c_Excluir.Enabled    = loc_lNaLista
1098:                     .cmd_4c_Buscar.Enabled     = loc_lNaLista
1099:                     .Visible     = .T.
1100:                 ENDWITH
1101:             ENDIF
1102: 
1103:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1104:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
1105:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1106:             ENDIF
1107:         CATCH TO loException
1108:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, "Erro")
1109:         ENDTRY
1110:     ENDPROC


### BO (C:\4c\projeto\app\classes\FNFBO.prg):
*==============================================================================
* FNFBO.prg - Business Object para Finalizadoras n" + CHR(227) + "o Fiscal
* Tabela: SIGFINTB
* PK: cidchaves (char 20 - gerado via NEWID SQL Server)
*==============================================================================
DEFINE CLASS FNFBO AS BusinessBase

    *-- Propriedades herdadas (sobrescrever em Init)
    this_cTabela      = "SIGFINTB"
    this_cCampoChave  = "cidchaves"

    *-- Campos de SIGFINTB
    this_cCidChaves   = ""   && char(20) PK
    this_cImps        = ""   && char(20) Impressora
    this_nOrdems      = 0    && numeric(2,0) Ordem
    this_cOpernf      = ""   && char(2) Cod.Opera" + CHR(231) + CHR(227) + "o NF
    this_cOpernf2     = ""   && char(2) Cod.Abertura (s" + CHR(243) + " SWEDA/NSWEDA)
    this_cDescrs      = ""   && char(50) Descri" + CHR(231) + CHR(227) + "o
    this_nNfixos         = 0    && numeric(1,0) Fixo: 1=Sim 0=N" + CHR(227) + "o
    this_cImpsOriginal   = ""   && imps carregado do BD (antes de edicao)
    this_nOrdemsOriginal = 0    && ordems carregado do BD (antes de edicao)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGFINTB"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista finalizadoras n" + CHR(227) + "o fiscais
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.imps, a.ordems, a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " ORDER BY a.imps, a.ordems"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar finalizadoras:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega finalizadora por Impressora+Ordem (chave natural)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cImps, par_nOrdems)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.imps, a.ordems, a.opernf, a.opernf2," + ;
                       " a.descrs, a.nfixos" + ;
                       " FROM SIGFINTB a" + ;
                       " WHERE a.imps = " + EscaparSQL(par_cImps) + ;
                       " AND a.ordems = " + FormatarNumeroSQL(par_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves      = TratarNulo(cidchaves, "C")
            THIS.this_cImps           = TratarNulo(imps,      "C")
            THIS.this_nOrdems         = TratarNulo(ordems,    "N")
            THIS.this_cImpsOriginal   = THIS.this_cImps
            THIS.this_nOrdemsOriginal = THIS.this_nOrdems
            THIS.this_cOpernf         = TratarNulo(opernf,    "C")
            THIS.this_cOpernf2        = TratarNulo(opernf2,   "C")
            THIS.this_cDescrs         = TratarNulo(descrs,    "C")
            THIS.this_nNfixos         = TratarNulo(nfixos,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarUnicidade - Verifica se Impressora+Ordem j" + CHR(225) + " existe
    * Retorna .T. se combinacao esta disponivel (sem duplicata)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarUnicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDisponivel
        loc_lDisponivel = .T.

        *-- Se editando sem alterar chave composta, nao ha conflito de unicidade
        IF !THIS.this_lNovoRegistro AND ;
           ALLTRIM(THIS.this_cImps) = ALLTRIM(THIS.this_cImpsOriginal) AND ;
           THIS.this_nOrdems = THIS.this_nOrdemsOriginal
            RETURN .T.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS cnt FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImps) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdems)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Unic")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Unic") > 0
                SELECT cursor_4c_Unic
                IF cursor_4c_Unic.cnt > 0
                    MsgAviso("Impressora / Ordem j" + CHR(225) + " cadastrada!", "Aten" + CHR(231) + CHR(227) + "o")
                    loc_lDisponivel = .F.
                ENDIF
            ENDIF

            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Unic")
                USE IN cursor_4c_Unic
            ENDIF
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar chave unica via NEWID do SQL Server
            THIS.this_cCidChaves = ""
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGFINTB" + ;
                           " (cidchaves, imps, ordems, opernf, opernf2, descrs, nfixos)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                           EscaparSQL(THIS.this_cImps) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf) + ", " + ;
                           EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                           EscaparSQL(THIS.this_cDescrs) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nNfixos) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGFINTB
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        *-- Validar duplicidade Impressora+Ordem (excluindo registro atual) ANTES do TRY
        IF !THIS.ValidarUnicidade()
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SIGFINTB SET" + ;
                       " imps = " + EscaparSQL(THIS.this_cImps) + ", " + ;
                       " ordems = " + FormatarNumeroSQL(THIS.this_nOrdems) + ", " + ;
                       " opernf = " + EscaparSQL(THIS.this_cOpernf) + ", " + ;
                       " opernf2 = " + EscaparSQL(THIS.this_cOpernf2) + ", " + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       " nfixos = " + FormatarNumeroSQL(THIS.this_nNfixos) + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE da finalizadora por chave natural imps+ordems
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGFINTB" + ;
                       " WHERE imps = " + EscaparSQL(THIS.this_cImpsOriginal) + ;
                       " AND ordems = " + FormatarNumeroSQL(THIS.this_nOrdemsOriginal)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir finalizadora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir finalizadora:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

