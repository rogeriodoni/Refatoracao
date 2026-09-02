# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 180: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 204: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 384: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 407: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1958 linhas total):

*-- Linhas 5 a 13:
5: * Tabela: SigCdRpo
6: * Herda de: FormBase
7: *
8: * PageFrame.Top = -31 (compensação +31 em todos os controles)
9: *==============================================================================
10: 
11: DEFINE CLASS FormRop AS FormBase
12: 
13:     *-- Propriedades visuais (PILAR 1 - UX Fidelity)

*-- Linhas 49 a 57:
49:         loc_lSucesso = .F.
50: 
51:         TRY
52:             THIS.Caption = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
53: 
54:             THIS.this_oBusinessObject = CREATEOBJECT("RopBO")
55:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
56:                 MsgErro("Erro ao criar RopBO.", "FormRop.InicializarForm")
57:             ELSE

*-- Linhas 75 a 103:
75: 
76:     *==========================================================================
77:     * ConfigurarPageFrame - Cria PageFrame com 2 páginas (Lista e Dados)
78:     * Compensação: PageFrame.Top = -31, todos os controles precisam +31 no Top
79:     *==========================================================================
80:     PROTECTED PROCEDURE ConfigurarPageFrame()
81:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
82:         THIS.pgf_4c_Paginas.PageCount = 2
83:         WITH THIS.pgf_4c_Paginas
84:             .Top    = -31
85:             .Left   = -2
86:             .Width  = THIS.Width + 4
87:             .Height = 631
88:             .Tabs   = .F.
89:             .Visible = .T.
90:         ENDWITH
91: 
92:         WITH THIS.pgf_4c_Paginas.Page1
93:             .Caption = "Lista"
94:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
95:         ENDWITH
96: 
97:         WITH THIS.pgf_4c_Paginas.Page2
98:             .Caption = "Dados"
99:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()

*-- Linhas 116 a 150:
116:         *-- Container cabeçalho com título
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 32
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
130:             .Top      = 15
131:             .Left     = 10
132:             .Width    = THIS.Width - 20
133:             .Height   = 46
134:             .FontName = "Tahoma"
135:             .FontSize = 16
136:             .FontBold = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .Visible  = .T.
140:         ENDWITH
141:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
142:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
143:             .Caption  = "Restri" + CHR(231) + CHR(245) + "es Por Opera" + CHR(231) + CHR(227) + "o"
144:             .Top      = 18
145:             .Left     = 10
146:             .Width    = THIS.Width - 20
147:             .Height   = 46
148:             .FontName = "Tahoma"
149:             .FontSize = 16
150:             .FontBold = .T.

*-- Linhas 156 a 333:
156:         *-- Container botões CRUD (canônico Left=520, Width=390)
157:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
158:         WITH loc_oPagina.cnt_4c_Botoes
159:             .Top         = 31
160:             .Left        =  542
161:             .Width       = 390
162:             .Height      = 85
163:             .BackStyle = 0
164:             .BorderWidth = 0
165:             .Visible     = .T.
166:         ENDWITH
167: 
168:         *-- Botão Incluir
169:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
170:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
171:             .Caption         = "Incluir"
172:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
173:             .PicturePosition = 13
174:             .Top             = 5
175:             .Left            = 5
176:             .Width           = 75
177:             .Height          = 75
178:             .BackColor       = RGB(255, 255, 255)
179:             .ForeColor       = RGB(90, 90, 90)
180:             .FontName        = "Comic Sans MS"
181:             .FontBold        = .T.
182:             .FontItalic      = .T.
183:             .FontSize        = 8
184:             .WordWrap        = .T.
185:             .Themes          = .F.
186:             .SpecialEffect   = 0
187:             .MousePointer    = 15
188:             .Visible         = .T.
189:         ENDWITH
190:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
191: 
192:         *-- Botão Visualizar
193:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
194:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
195:             .Caption         = "Visualizar"
196:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
197:             .PicturePosition = 13
198:             .Top             = 5
199:             .Left            = 80
200:             .Width           = 75
201:             .Height          = 75
202:             .BackColor       = RGB(255, 255, 255)
203:             .ForeColor       = RGB(90, 90, 90)
204:             .FontName        = "Comic Sans MS"
205:             .FontBold        = .T.
206:             .FontItalic      = .T.
207:             .FontSize        = 8
208:             .WordWrap        = .T.
209:             .Themes          = .F.
210:             .SpecialEffect   = 0
211:             .MousePointer    = 15
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
215: 
216:         *-- Botão Alterar
217:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
218:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
219:             .Caption         = "Alterar"
220:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
221:             .PicturePosition = 13
222:             .Top             = 5
223:             .Left            = 155
224:             .Width           = 75
225:             .Height          = 75
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .FontName        = "Comic Sans MS"
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .FontSize        = 8
232:             .WordWrap        = .T.
233:             .Themes          = .F.
234:             .SpecialEffect   = 0
235:             .MousePointer    = 15
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:         *-- Botão Excluir
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 230
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Comic Sans MS"
253:             .FontBold        = .T.
254:             .FontItalic      = .T.
255:             .FontSize        = 8
256:             .WordWrap        = .T.
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .MousePointer    = 15
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
263: 
264:         *-- Botão Buscar
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
267:             .Caption         = "Buscar"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 305
272:             .Width           = 75
273:             .Height          = 75
274:             .BackColor       = RGB(255, 255, 255)
275:             .ForeColor       = RGB(90, 90, 90)
276:             .FontName        = "Comic Sans MS"
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .FontSize        = 8
280:             .WordWrap        = .T.
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .MousePointer    = 15
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
287: 
288:         *-- Container Encerrar (canônico Left=917, Width=90)
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 31
292:             .Left        = 917
293:             .Width       = 90
294:             .Height      = 85
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301:             .Caption         = "Encerrar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303:             .PicturePosition = 13
304:             .Top             = 5
305:             .Left            = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .BackColor       = RGB(255, 255, 255)
309:             .ForeColor       = RGB(90, 90, 90)
310:             .FontName        = "Comic Sans MS"
311:             .FontBold        = .T.
312:             .FontItalic      = .T.
313:             .FontSize        = 8
314:             .WordWrap        = .T.
315:             .Themes          = .F.
316:             .SpecialEffect   = 0
317:             .MousePointer    = 15
318:             .Visible         = .T.
319:         ENDWITH
320:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
321: 
322:         *-- Grid de lista (Top=117 = 86+31 compensação PageFrame)
323:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
324:         loc_oGrid = loc_oPagina.grd_4c_Lista
325:         loc_oGrid.ColumnCount = 9
326:         WITH loc_oGrid
327:             .Top                = 117
328:             .Left               = 26
329:             .Width              = 890
330:             .Height             = 470
331:             .FontName           = "Verdana"
332:             .FontSize           = 8
333:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 350 a 431:
350:     *==========================================================================
351:     * ConfigurarPaginaDados - Configura Page2 com campos e botões de edição
352:     * Todos os 10 campos + BINDEVENTs de lookup (F4/LostFocus) completos
353:     * Compensação PageFrame.Top=-31: todos os Tops somam +31
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarPaginaDados()
356:         LOCAL loc_oPagina
357:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
358: 
359:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
360:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
361: 
362:         *-- Container botões Confirmar/Cancelar (canônico: Top=51, Left=842)
363:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
364:         WITH loc_oPagina.cnt_4c_BotoesAcao
365:             .Top         = 51
366:             .Left        = 842
367:             .Width       = 160
368:             .Height      = 85
369:             .BackStyle   = 0
370:             .Visible     = .T.
371:         ENDWITH
372: 
373:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
374:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
375:             .Caption         = "Confirmar"
376:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
377:             .PicturePosition = 13
378:             .Top             = 5
379:             .Left            = 5
380:             .Width           = 75
381:             .Height          = 75
382:             .BackColor       = RGB(255, 255, 255)
383:             .ForeColor       = RGB(90, 90, 90)
384:             .FontName        = "Comic Sans MS"
385:             .FontBold        = .T.
386:             .FontItalic      = .T.
387:             .FontSize        = 8
388:             .WordWrap        = .T.
389:             .Themes          = .F.
390:             .SpecialEffect   = 0
391:             .MousePointer    = 15
392:             .Visible         = .T.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
395: 
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
398:             .Caption         = "Encerrar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 80
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Comic Sans MS"
408:             .FontBold        = .T.
409:             .FontItalic      = .T.
410:             .FontSize        = 8
411:             .WordWrap        = .T.
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .Visible         = .T.
416:         ENDWITH
417:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
418: 
419:         *====================================================================
420:         *-- CAMPO 1: Operação de Produção (Get_Dopp) - original top=98 -> 129
421:         *====================================================================
422:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
423:         WITH loc_oPagina.lbl_4c_Label2
424:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
425:             .Top       = 133
426:             .Left      = 242
427:             .Width     = 85
428:             .Height    = 15
429:             .BackStyle = 0
430:             .ForeColor = RGB(90, 90, 90)
431:             .FontName  = "Tahoma"

*-- Linhas 437 a 446:
437:         loc_oPagina.AddObject("txt_4c_Dopp", "TextBox")
438:         WITH loc_oPagina.txt_4c_Dopp
439:             .Value       = ""
440:             .Top         = 129
441:             .Left        = 328
442:             .Width       = 150
443:             .Height      = 23
444:             .MaxLength   = 20
445:             .BackColor   = RGB(255, 255, 255)
446:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 455 a 467:
455:         *====================================================================
456:         *-- CAMPO 2: Tipo de Material (Get_Tpop) - original top=124 -> 155
457:         *====================================================================
458:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
459:         WITH loc_oPagina.lbl_4c_Label1
460:             .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o :"
461:             .Top       = 159
462:             .Left      = 204
463:             .Width     = 120
464:             .Height    = 15
465:             .BackStyle = 0
466:             .ForeColor = RGB(90, 90, 90)
467:             .FontName  = "Tahoma"

*-- Linhas 473 a 482:
473:         loc_oPagina.AddObject("txt_4c_Tpop", "TextBox")
474:         WITH loc_oPagina.txt_4c_Tpop
475:             .Value       = ""
476:             .Top         = 155
477:             .Left        = 328
478:             .Width       = 115
479:             .Height      = 23
480:             .MaxLength   = 15
481:             .BackColor   = RGB(255, 255, 255)
482:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 492 a 504:
492:         *-- CAMPO 3: Grupo de Produto - código (get_Cgru) + desc (get_ds_grupo)
493:         *-- original top=150 -> 181
494:         *====================================================================
495:         loc_oPagina.AddObject("lbl_4c_Lbl_grupo", "Label")
496:         WITH loc_oPagina.lbl_4c_Lbl_grupo
497:             .Caption   = "Grupo de Produto :"
498:             .Top       = 185
499:             .Left      = 226
500:             .Width     = 94
501:             .Height    = 15
502:             .BackStyle = 0
503:             .ForeColor = RGB(90, 90, 90)
504:             .FontName  = "Tahoma"

*-- Linhas 510 a 519:
510:         loc_oPagina.AddObject("txt_4c__Cgru", "TextBox")
511:         WITH loc_oPagina.txt_4c__Cgru
512:             .Value       = ""
513:             .Top         = 181
514:             .Left        = 328
515:             .Width       = 31
516:             .Height      = 23
517:             .MaxLength   = 3
518:             .BackColor   = RGB(255, 255, 255)
519:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 528 a 537:
528:         loc_oPagina.AddObject("txt_4c__ds_grupo", "TextBox")
529:         WITH loc_oPagina.txt_4c__ds_grupo
530:             .Value       = ""
531:             .Top         = 181
532:             .Left        = 361
533:             .Width       = 213
534:             .Height      = 23
535:             .MaxLength   = 50
536:             .BackColor   = RGB(255, 255, 255)
537:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 545 a 572:
545:         *====================================================================
546:         *-- CAMPO 4: Operação Estoque E/S (Get_OpPad) - original top=177 -> 208
547:         *====================================================================
548:         loc_oPagina.AddObject("lbl_4c_Label39", "Label")
549:         WITH loc_oPagina.lbl_4c_Label39
550:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o Estoque :"
551:             .Top       = 211
552:             .Left      = 222
553:             .Width     = 98
554:             .Height    = 15
555:             .BackStyle = 0
556:             .ForeColor = RGB(90, 90, 90)
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .Alignment = 1
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         loc_oPagina.AddObject("lbl_4c_Label40", "Label")
564:         WITH loc_oPagina.lbl_4c_Label40
565:             .Caption   = "(E / S)"
566:             .Top       = 211
567:             .Left      = 352
568:             .Width     = 32
569:             .Height    = 15
570:             .BackStyle = 0
571:             .ForeColor = RGB(90, 90, 90)
572:             .FontName  = "Tahoma"

*-- Linhas 578 a 587:
578:         loc_oPagina.AddObject("txt_4c_OpPad", "TextBox")
579:         WITH loc_oPagina.txt_4c_OpPad
580:             .Value       = ""
581:             .Top         = 208
582:             .Left        = 328
583:             .Width       = 17
584:             .Height      = 20
585:             .MaxLength   = 1
586:             .BackColor   = RGB(255, 255, 255)
587:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 599 a 608:
599:         loc_oPagina.AddObject("txt_4c_Gde", "TextBox")
600:         WITH loc_oPagina.txt_4c_Gde
601:             .Value       = ""
602:             .Top         = 231
603:             .Left        = 328
604:             .Width       = 33
605:             .Height      = 23
606:             .MaxLength   = 3
607:             .BackColor   = RGB(255, 255, 255)
608:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 614 a 626:
614:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress", THIS, "ValidarGde")
615:         BINDEVENT(loc_oPagina.txt_4c_Gde, "KeyPress",  THIS, "TeclaPressionadaGde")
616: 
617:         loc_oPagina.AddObject("lbl_4c_Lbl_gde_grupo", "Label")
618:         WITH loc_oPagina.lbl_4c_Lbl_gde_grupo
619:             .Caption   = "Grande Grupo :"
620:             .Top       = 235
621:             .Left      = 244
622:             .Width     = 76
623:             .Height    = 15
624:             .BackStyle = 0
625:             .ForeColor = RGB(90, 90, 90)
626:             .FontName  = "Tahoma"

*-- Linhas 633 a 645:
633:         *-- CAMPO 6: Grupo Contábil código (Get_Grupos) + desc (Get_Dgrupos)
634:         *-- original top=226 -> 257 | Say4 original top=230 -> 261
635:         *====================================================================
636:         loc_oPagina.AddObject("lbl_4c_Say4", "Label")
637:         WITH loc_oPagina.lbl_4c_Say4
638:             .Caption   = "Grupo :"
639:             .Top       = 261
640:             .Left      = 282
641:             .Width     = 43
642:             .Height    = 15
643:             .BackStyle = 0
644:             .ForeColor = RGB(90, 90, 90)
645:             .FontName  = "Tahoma"

*-- Linhas 651 a 660:
651:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
652:         WITH loc_oPagina.txt_4c_Grupo
653:             .Value       = ""
654:             .Top         = 257
655:             .Left        = 328
656:             .Width       = 80
657:             .Height      = 23
658:             .MaxLength   = 10
659:             .BackColor   = RGB(255, 255, 255)
660:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 669 a 678:
669:         loc_oPagina.AddObject("txt_4c_Dgrupos", "TextBox")
670:         WITH loc_oPagina.txt_4c_Dgrupos
671:             .Value       = ""
672:             .Top         = 257
673:             .Left        = 411
674:             .Width       = 162
675:             .Height      = 23
676:             .MaxLength   = 50
677:             .BackColor   = RGB(255, 255, 255)
678:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 687 a 699:
687:         *-- CAMPO 7: Conta Destino (Get_Conta) - original top=252 -> 283
688:         *-- Say34 original top=255 -> 286
689:         *====================================================================
690:         loc_oPagina.AddObject("lbl_4c_Say34", "Label")
691:         WITH loc_oPagina.lbl_4c_Say34
692:             .Caption   = "Conta Destino :"
693:             .Top       = 286
694:             .Left      = 243
695:             .Width     = 82
696:             .Height    = 15
697:             .BackStyle = 0
698:             .ForeColor = RGB(90, 90, 90)
699:             .FontName  = "Tahoma"

*-- Linhas 705 a 714:
705:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
706:         WITH loc_oPagina.txt_4c_Conta
707:             .Value       = ""
708:             .Top         = 283
709:             .Left        = 328
710:             .Width       = 80
711:             .Height      = 21
712:             .MaxLength   = 10
713:             .BackColor   = RGB(255, 255, 255)
714:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 724 a 736:
724:         *-- CAMPO 8: Conta Origem (Get_ContaOrig) - original top=276 -> 307
725:         *-- Say3 original top=279 -> 310
726:         *====================================================================
727:         loc_oPagina.AddObject("lbl_4c_Say3", "Label")
728:         WITH loc_oPagina.lbl_4c_Say3
729:             .Caption   = "Conta Origem :"
730:             .Top       = 310
731:             .Left      = 245
732:             .Width     = 80
733:             .Height    = 15
734:             .BackStyle = 0
735:             .ForeColor = RGB(90, 90, 90)
736:             .FontName  = "Tahoma"

*-- Linhas 742 a 751:
742:         loc_oPagina.AddObject("txt_4c_ContaOrig", "TextBox")
743:         WITH loc_oPagina.txt_4c_ContaOrig
744:             .Value       = ""
745:             .Top         = 307
746:             .Left        = 328
747:             .Width       = 80
748:             .Height      = 21
749:             .MaxLength   = 10
750:             .BackColor   = RGB(255, 255, 255)
751:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 761 a 773:
761:         *-- CAMPO 9: Cor (getCor/SigCdCor.Cods) - original top=300 -> 331
762:         *-- Say42 original top=304 -> 335
763:         *====================================================================
764:         loc_oPagina.AddObject("lbl_4c_Say42", "Label")
765:         WITH loc_oPagina.lbl_4c_Say42
766:             .Caption   = "Cor :"
767:             .Top       = 335
768:             .Left      = 294
769:             .Width     = 31
770:             .Height    = 15
771:             .BackStyle = 0
772:             .ForeColor = RGB(90, 90, 90)
773:             .FontName  = "Tahoma"

*-- Linhas 779 a 788:
779:         loc_oPagina.AddObject("txt_4c_Cor", "TextBox")
780:         WITH loc_oPagina.txt_4c_Cor
781:             .Value       = ""
782:             .Top         = 331
783:             .Left        = 328
784:             .Width       = 38
785:             .Height      = 23
786:             .MaxLength   = 6
787:             .BackColor   = RGB(255, 255, 255)
788:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 798 a 849:
798:         *-- CAMPO 10: Exclusivo (opt_Exclusivo) - original top=325 -> 356
799:         *-- Say6 original top=329 -> 360
800:         *====================================================================
801:         loc_oPagina.AddObject("lbl_4c_Say6", "Label")
802:         WITH loc_oPagina.lbl_4c_Say6
803:             .Caption   = "Exclusivo :"
804:             .Top       = 360
805:             .Left      = 267
806:             .Width     = 53
807:             .Height    = 15
808:             .BackStyle = 0
809:             .ForeColor = RGB(90, 90, 90)
810:             .FontName  = "Tahoma"
811:             .FontSize  = 8
812:             .Alignment = 1
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         loc_oPagina.AddObject("obj_4c_Opt_Exclusivo", "OptionGroup")
817:         WITH loc_oPagina.obj_4c_Opt_Exclusivo
818:             .Top         = 356
819:             .Left        = 326
820:             .Width       = 86
821:             .Height      = 23
822:             .ButtonCount = 2
823:             .BackStyle   = 0
824:             .BorderStyle = 0
825:             .Value       = 2
826:             .Visible     = .T.
827:         ENDWITH
828:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option1
829:             .Caption   = "Sim"
830:             .Left      = 2
831:             .Top       = 4
832:             .Width     = 34
833:             .Height    = 15
834:             .BackStyle = 0
835:             .ForeColor = RGB(90, 90, 90)
836:             .FontName  = "Tahoma"
837:             .FontSize  = 8
838:             .AutoSize  = .F.
839:             .Visible   = .T.
840:         ENDWITH
841:         WITH loc_oPagina.obj_4c_Opt_Exclusivo.Option2
842:             .Caption   = "N" + CHR(227) + "o"
843:             .Left      = 44
844:             .Top       = 4
845:             .Width     = 37
846:             .Height    = 15
847:             .BackStyle = 0
848:             .ForeColor = RGB(90, 90, 90)
849:             .FontName  = "Tahoma"

*-- Linhas 892 a 908:
892:                     loc_oGrid.Column8.Width = 100
893:                     loc_oGrid.Column9.Width = 60
894: 
895:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
896:                     loc_oGrid.Column2.Header1.Caption = "Tipo de Material"
897:                     loc_oGrid.Column3.Header1.Caption = "Grp.Produto"
898:                     loc_oGrid.Column4.Header1.Caption = "Op.Est."
899:                     loc_oGrid.Column5.Header1.Caption = "Grande Grp."
900:                     loc_oGrid.Column6.Header1.Caption = "Gr.Conta"
901:                     loc_oGrid.Column7.Header1.Caption = "Conta Dest."
902:                     loc_oGrid.Column8.Header1.Caption = "Conta Orig."
903:                     loc_oGrid.Column9.Header1.Caption = "Cor"
904: 
905:                     THIS.FormatarGridLista(loc_oGrid)
906:                     loc_lResultado = .T.
907:                 ENDIF
908:             ENDIF

*-- Linhas 1209 a 1217:
1209:         loc_oPagina.obj_4c_Opt_Exclusivo.Enabled  = par_lHabilitar
1210: 
1211:         *-- Confirmar habilitado em modo edição ou exclusão
1212:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
1213:             par_lHabilitar OR (THIS.this_cModoAtual = "EXCLUIR")
1214:     ENDPROC
1215: 
1216:     *==========================================================================
1217:     * ValidarDopp - Valida campo Operação ao perder foco

*-- Linhas 1934 a 1949:
1934: 
1935:         DO CASE
1936:             CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
1937:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1938:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1939:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1940:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1941:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1942:             OTHERWISE
1943:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1944:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1945:         ENDCASE
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     * Destroy - Libera recursos ao fechar o formulário


### BO (C:\4c\projeto\app\classes\RopBO.prg):
*==============================================================================
* RopBO.prg
*
* Business Object para Cadastro de Restricoes Por Operacao
* Tabela: SigCdRpo
* Herda de: BusinessBase
*
* Colunas da tabela SigCdRpo:
*   cidchaves  char(20)    PK - Chave unica gerada via NEWID
*   cgrus      char(3)     Grupo de Produto
*   dopps      char(20)    Operacao de Producao
*   doptpgrus  char(48)    Composto: Dopp+TpOp+Cgru+Mercs+Grupos
*   tpops      char(15)    Tipo de Material/Operacao
*   mercs      char(3)     Grande Grupo
*   opers      char(1)     Operacao Estoque (E/S)
*   grupos     char(10)    Grupo de Conta Contabil
*   exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
*   contas     char(10)    Conta Destino
*   codcors    char(4)     Codigo da Cor
*   contaorig  char(10)    Conta Origem
*==============================================================================

DEFINE CLASS RopBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdRpo)
    this_cCidChaves  = ""   && cidchaves  char(20)    PK
    this_cCgrus      = ""   && cgrus      char(3)     Grupo de Produto
    this_cDopps      = ""   && dopps      char(20)    Operacao
    this_cDoptpgrus  = ""   && doptpgrus  char(48)    Composto (auto-gerado)
    this_cTpops      = ""   && tpops      char(15)    Tipo de Material
    this_cMercs      = ""   && mercs      char(3)     Grande Grupo
    this_cOpers      = ""   && opers      char(1)     Op.Estoque E/S
    this_cGrupos     = ""   && grupos     char(10)    Grupo Conta
    this_nExclus     = 2    && exclus     numeric(1)  Exclusivo (1=Sim, 2=Nao)
    this_cContas     = ""   && contas     char(10)    Conta Destino
    this_cCodcors    = ""   && codcors    char(4)     Cor
    this_cContaorig  = ""   && contaorig  char(10)    Conta Origem

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRpo"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "RopBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCgrus      = TratarNulo(cgrus,      "C")
                THIS.this_cDopps      = TratarNulo(dopps,      "C")
                THIS.this_cDoptpgrus  = TratarNulo(doptpgrus,  "C")
                THIS.this_cTpops      = TratarNulo(tpops,      "C")
                THIS.this_cMercs      = TratarNulo(mercs,      "C")
                THIS.this_cOpers      = TratarNulo(opers,      "C")
                THIS.this_cGrupos     = TratarNulo(grupos,     "C")
                THIS.this_nExclus     = TratarNulo(exclus,     "N")
                THIS.this_cContas     = TratarNulo(contas,     "C")
                THIS.this_cCodcors    = TratarNulo(codcors,    "C")
                THIS.this_cContaorig  = TratarNulo(contaorig,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves  = ""
        THIS.this_cCgrus      = ""
        THIS.this_cDopps      = ""
        THIS.this_cDoptpgrus  = ""
        THIS.this_cTpops      = ""
        THIS.this_cMercs      = ""
        THIS.this_cOpers      = ""
        THIS.this_cGrupos     = ""
        THIS.this_nExclus     = 2
        THIS.this_cContas     = ""
        THIS.this_cCodcors    = ""
        THIS.this_cContaorig  = ""
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cDopps)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar a Opera" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(THIS.this_cTpops) AND EMPTY(THIS.this_cCgrus) AND ;
               EMPTY(THIS.this_cMercs) AND EMPTY(THIS.this_cGrupos)
                MsgAviso("Obrigat" + CHR(243) + "rio Informar o Tipo de Material Ou " + ;
                    "Grupo de Produto Ou Grande Grupo Ou Grupo Conta")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND !EMPTY(ALLTRIM(THIS.this_cOpers))
            IF !INLIST(UPPER(ALLTRIM(THIS.this_cOpers)), "E", "S")
                MsgAviso("Op" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida. " + ;
                    "Digite Apenas [E] ou [S] ou [ ] !!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido
            IF THIS.VerificarDuplicidade()
                MsgAviso("Restri" + CHR(231) + CHR(227) + "o j" + CHR(225) + " cadastrada...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica restricao ja cadastrada com mesmos campos
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRpo" + ;
                " WHERE Dopps    = " + EscaparSQL(THIS.this_cDopps) + ;
                " AND   TpOps    = " + EscaparSQL(THIS.this_cTpops) + ;
                " AND   CGrus    = " + EscaparSQL(THIS.this_cCgrus) + ;
                " AND   Mercs    = " + EscaparSQL(THIS.this_cMercs) + ;
                " AND   Grupos   = " + EscaparSQL(THIS.this_cGrupos) + ;
                " AND   Contas   = " + EscaparSQL(THIS.this_cContas) + ;
                " AND   ContaOrig= " + EscaparSQL(THIS.this_cContaorig) + ;
                " AND   CodCors  = " + EscaparSQL(THIS.this_cCodcors) + ;
                " AND   cidchaves <> " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RopBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult, loc_cSQL
        loc_cChave = ""

        TRY
            loc_cSQL = "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RopBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RopBO.Inserir")
            ELSE
                THIS.this_cDoptpgrus = LEFT( ;
                    ALLTRIM(THIS.this_cDopps)  + ;
                    ALLTRIM(THIS.this_cTpops)  + ;
                    ALLTRIM(THIS.this_cCgrus)  + ;
                    ALLTRIM(THIS.this_cMercs)  + ;
                    ALLTRIM(THIS.this_cGrupos) + ;
                    SPACE(48), 48)

                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    INSERT INTO SigCdRpo (
                        cidchaves, cgrus, dopps, doptpgrus, tpops,
                        mercs, opers, grupos, exclus, contas, codcors, contaorig
                    ) VALUES (
                        <<EscaparSQL(THIS.this_cCidChaves)>>,
                        <<EscaparSQL(THIS.this_cCgrus)>>,
                        <<EscaparSQL(THIS.this_cDopps)>>,
                        <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                        <<EscaparSQL(THIS.this_cTpops)>>,
                        <<EscaparSQL(THIS.this_cMercs)>>,
                        <<EscaparSQL(THIS.this_cOpers)>>,
                        <<EscaparSQL(THIS.this_cGrupos)>>,
                        <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                        <<EscaparSQL(THIS.this_cContas)>>,
                        <<EscaparSQL(THIS.this_cCodcors)>>,
                        <<EscaparSQL(THIS.this_cContaorig)>>
                    )
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RopBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cDoptpgrus = LEFT( ;
                ALLTRIM(THIS.this_cDopps)  + ;
                ALLTRIM(THIS.this_cTpops)  + ;
                ALLTRIM(THIS.this_cCgrus)  + ;
                ALLTRIM(THIS.this_cMercs)  + ;
                ALLTRIM(THIS.this_cGrupos) + ;
                SPACE(48), 48)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdRpo SET
                    cgrus      = <<EscaparSQL(THIS.this_cCgrus)>>,
                    dopps      = <<EscaparSQL(THIS.this_cDopps)>>,
                    doptpgrus  = <<EscaparSQL(THIS.this_cDoptpgrus)>>,
                    tpops      = <<EscaparSQL(THIS.this_cTpops)>>,
                    mercs      = <<EscaparSQL(THIS.this_cMercs)>>,
                    opers      = <<EscaparSQL(THIS.this_cOpers)>>,
                    grupos     = <<EscaparSQL(THIS.this_cGrupos)>>,
                    exclus     = <<FormatarNumeroSQL(THIS.this_nExclus, 0)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    codcors    = <<EscaparSQL(THIS.this_cCodcors)>>,
                    contaorig  = <<EscaparSQL(THIS.this_cContaorig)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RopBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRpo
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRpo WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RopBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colunas para o grid (ordem identica ao legado)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        dopps     C(20), ;
                        tpops     C(15), ;
                        cgrus     C(3),  ;
                        opers     C(1),  ;
                        mercs     C(3),  ;
                        grupos    C(10), ;
                        contas    C(10), ;
                        contaorig C(10), ;
                        codcors   C(4),  ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT dopps, tpops, cgrus, opers, mercs," + ;
                    " grupos, contas, contaorig, codcors, cidchaves" + ;
                    " FROM SigCdRpo"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY dopps, tpops, cgrus"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RopBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cgrus, dopps, doptpgrus, tpops," + ;
                " mercs, opers, grupos, exclus, contas, codcors, contaorig" + ;
                " FROM SigCdRpo WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RopBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

