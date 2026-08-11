# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [FONTNAME-ERRADO] Linha 187: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 211: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 318: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 342: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 435: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 459: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormDES.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1500 linhas total):

*-- Linhas 60 a 69:
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62:                 THIS.ConfigurarPaginaLista()
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65:                 THIS.ConfigurarPaginaDados()
66: 
67:                 IF TYPE("gb_4c_ValidandoUI") <> "L" OR !gb_4c_ValidandoUI
68:                     THIS.CarregarLista()
69:                 ENDIF

*-- Linhas 87 a 156:
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .PageCount = 2
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(255, 255, 255)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.BackColor = RGB(255, 255, 255)
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:         ENDWITH
106:     ENDPROC
107: 
108:     *==========================================================================
109:     * ConfigurarPaginaLista - Page1: Cabecalho + Botoes CRUD + Grid
110:     * Legado: cntSombra.Top=1, Grupo_op.Left=538 Width=389, Grade.Top=131 Left=12
111:     *==========================================================================
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPagina
114:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Cabecalho cinza escuro (cntSombra do legado)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 12
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 163 a 289:
163:         *-- Container de botoes CRUD (Grupo_op do legado - Left=538, Width=389)
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        =  542
168:             .Width       = 389
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .BackColor       = RGB(255, 255, 255)
186:             .ForeColor       = RGB(90, 90, 90)
187:             .FontName        = "Comic Sans MS"
188:             .FontBold        = .T.
189:             .FontItalic      = .T.
190:             .FontSize        = 8
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198: 
199:         *-- Botao Visualizar
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .BackColor       = RGB(255, 255, 255)
210:             .ForeColor       = RGB(90, 90, 90)
211:             .FontName        = "Comic Sans MS"
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .FontSize        = 8
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .MousePointer    = 15
218:             .WordWrap        = .T.
219:             .AutoSize        = .F.
220:             .Visible         = .T.
221:         ENDWITH
222: 
223:         *-- Botao Alterar
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Comic Sans MS"
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .FontSize        = 8
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270: 
271:         *-- Botao Buscar
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .BackColor       = RGB(255, 255, 255)
282:             .ForeColor       = RGB(90, 90, 90)
283:             .FontName        = "Comic Sans MS"
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .FontSize        = 8
287:             .Themes          = .F.
288:             .SpecialEffect   = 0
289:             .MousePointer    = 15

*-- Linhas 295 a 363:
295:         *-- Container Encerrar - padrao canonico (PREVALECE sobre PILAR 1)
296:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
297:         WITH loc_oPagina.cnt_4c_Saida
298:             .Top         = 29
299:             .Left        = 917
300:             .Width       = 90
301:             .Height      = 85
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
309:             .Caption         = "Encerrar"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
311:             .PicturePosition = 13
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .BackColor       = RGB(255, 255, 255)
317:             .ForeColor       = RGB(90, 90, 90)
318:             .FontName        = "Comic Sans MS"
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontSize        = 8
322:             .Themes          = .F.
323:             .SpecialEffect   = 0
324:             .MousePointer    = 15
325:             .WordWrap        = .T.
326:             .AutoSize        = .F.
327:             .Visible         = .T.
328:         ENDWITH
329: 
330:         *-- Botao especial Carrega Cotas (legado: btncarregar, top=4+29=33, left=467)
331:         *-- Inicia oculto (Visible=.F.) conforme legado
332:         loc_oPagina.AddObject("cmd_4c_Btncarregar", "CommandButton")
333:         WITH loc_oPagina.cmd_4c_Btncarregar
334:             .Caption         = "Carrega Cotas"
335:             .PicturePosition = 13
336:             .Top             = 33
337:             .Left            = 467
338:             .Width           = 75
339:             .Height          = 75
340:             .BackColor       = RGB(255, 255, 255)
341:             .ForeColor       = RGB(90, 90, 90)
342:             .FontName        = "Comic Sans MS"
343:             .FontBold        = .T.
344:             .FontItalic      = .T.
345:             .FontSize        = 8
346:             .Themes          = .F.
347:             .SpecialEffect   = 0
348:             .MousePointer    = 15
349:             .WordWrap        = .T.
350:             .AutoSize        = .F.
351:             .Visible         = .F.    && Inicia oculto conforme legado
352:         ENDWITH
353: 
354:         *-- Grid de lista (legado: grade.Top=131 left=12, compensado +29)
355:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
356:         WITH loc_oPagina.grd_4c_Lista
357:             .Top                = 160
358:             .Left               = 12
359:             .Width              = 890
360:             .Height             = 460
361:             .ColumnCount        = 6
362:             .FontName           = "Verdana"
363:             .FontSize           = 8

*-- Linhas 385 a 465:
385:         loc_oPagina.grd_4c_Lista.Column6.Width = 100
386: 
387:         *-- BINDEVENTs - metodos PUBLIC para funcionar com BINDEVENT
388:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
389:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
394:         BINDEVENT(loc_oPagina.cmd_4c_Btncarregar,               "Click", THIS, "BtnBtncarregarClick")
395: 
396:         THIS.TornarControlesVisiveis(loc_oPagina)
397:     ENDPROC
398: 
399:     *==========================================================================
400:     * ConfigurarPaginaDados - Page2: Botoes + Todos os Campos
401:     * Legado: Grupo_Salva.Left=819, Top=9+29=38
402:     * Campos: Codigo, Emps, Dtini, Dtfin, Valmeta, Valcota, Valdes, Pdes
403:     *==========================================================================
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPagina
406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
407: 
408:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
409:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
410: 
411:         *-- Container Salvar/Cancelar (Grupo_Salva do legado - Left=819, Top=38)
412:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
413:         WITH loc_oPagina.cnt_4c_Salva
414:             .Top         = 38
415:             .Left        = 819
416:             .Width       = 160
417:             .Height      = 85
418:             .BackStyle   = 0
419:             .BorderWidth = 0
420:             .Visible     = .T.
421:         ENDWITH
422: 
423:         *-- Botao Confirmar (Salvar)
424:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
425:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
426:             .Caption         = "Confirmar"
427:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
428:             .PicturePosition = 13
429:             .Top             = 5
430:             .Left            = 5
431:             .Width           = 75
432:             .Height          = 75
433:             .BackColor       = RGB(255, 255, 255)
434:             .ForeColor       = RGB(90, 90, 90)
435:             .FontName        = "Comic Sans MS"
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .FontSize        = 8
439:             .Themes          = .F.
440:             .SpecialEffect   = 0
441:             .MousePointer    = 15
442:             .WordWrap        = .T.
443:             .AutoSize        = .F.
444:             .Visible         = .T.
445:         ENDWITH
446: 
447:         *-- Botao Cancelar
448:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
449:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
450:             .Caption         = "Encerrar"
451:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
452:             .PicturePosition = 13
453:             .Top             = 5
454:             .Left            = 80
455:             .Width           = 75
456:             .Height          = 75
457:             .BackColor       = RGB(255, 255, 255)
458:             .ForeColor       = RGB(90, 90, 90)
459:             .FontName        = "Comic Sans MS"
460:             .FontBold        = .T.
461:             .FontItalic      = .T.
462:             .FontSize        = 8
463:             .Themes          = .F.
464:             .SpecialEffect   = 0
465:             .MousePointer    = 15

*-- Linhas 472 a 484:
472:         *-- Posicoes do legado (layout.json) + compensacao PageFrame +29
473: 
474:         *-- Label Codigo (Say7: top=126+29=155, left=445, caption="Codigo :")
475:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
476:         WITH loc_oPagina.lbl_4c_Label7
477:             .Caption   = "C" + CHR(243) + "digo :"
478:             .Top       = 155
479:             .Left      = 445
480:             .Width     = 80
481:             .Height    = 17
482:             .FontName  = "Tahoma"
483:             .FontSize  = 8
484:             .FontBold  = .F.

*-- Linhas 494 a 503:
494:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
495:         WITH loc_oPagina.txt_4c_Codigo
496:             .Value       = ""
497:             .Top         = 150
498:             .Left        = 492
499:             .Width       = 80
500:             .Height      = 24
501:             .FontName    = "Tahoma"
502:             .FontSize    = 8
503:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 509 a 521:
509:         ENDWITH
510: 
511:         *-- Label Empresa (Say1: top=153+29=182, left=437, caption="Empresa : ")
512:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
513:         WITH loc_oPagina.lbl_4c_Label1
514:             .Caption   = "Empresa :"
515:             .Top       = 182
516:             .Left      = 437
517:             .Width     = 80
518:             .Height    = 17
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .FontBold  = .F.

*-- Linhas 532 a 541:
532:         loc_oPagina.AddObject("txt_4c_Emps", "TextBox")
533:         WITH loc_oPagina.txt_4c_Emps
534:             .Value       = ""
535:             .Top         = 177
536:             .Left        = 492
537:             .Width       = 33
538:             .Height      = 24
539:             .FontName    = "Tahoma"
540:             .FontSize    = 8
541:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 547 a 559:
547:         ENDWITH
548: 
549:         *-- Label Data Inicial (Say5: top=180+29=209, left=425, caption="Data Inicial : ")
550:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
551:         WITH loc_oPagina.lbl_4c_Label5
552:             .Caption   = "Data Inicial :"
553:             .Top       = 209
554:             .Left      = 425
555:             .Width     = 92
556:             .Height    = 17
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .FontBold  = .F.

*-- Linhas 569 a 578:
569:         loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
570:         WITH loc_oPagina.txt_4c_Dtini
571:             .Value       = {}
572:             .Top         = 204
573:             .Left        = 492
574:             .Width       = 80
575:             .Height      = 24
576:             .FontName    = "Tahoma"
577:             .FontSize    = 8
578:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 584 a 596:
584:         ENDWITH
585: 
586:         *-- Label Data Final (Say6: top=207+29=236, left=430, caption="Data Final : ")
587:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
588:         WITH loc_oPagina.lbl_4c_Label6
589:             .Caption   = "Data Final :"
590:             .Top       = 236
591:             .Left      = 430
592:             .Width     = 87
593:             .Height    = 17
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .FontBold  = .F.

*-- Linhas 606 a 615:
606:         loc_oPagina.AddObject("txt_4c_Dtfin", "TextBox")
607:         WITH loc_oPagina.txt_4c_Dtfin
608:             .Value       = {}
609:             .Top         = 231
610:             .Left        = 492
611:             .Width       = 80
612:             .Height      = 24
613:             .FontName    = "Tahoma"
614:             .FontSize    = 8
615:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 623 a 635:
623:         *-- PARTE 2: Campos de valores monetarios e percentual
624: 
625:         *-- Label Meta de Vendas (Say3: top=234+29=263, left=401)
626:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
627:         WITH loc_oPagina.lbl_4c_Label3
628:             .Caption   = "Meta de Vendas :"
629:             .Top       = 263
630:             .Left      = 401
631:             .Width     = 110
632:             .Height    = 17
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .FontBold  = .F.

*-- Linhas 645 a 654:
645:         loc_oPagina.AddObject("txt_4c_Valmeta", "TextBox")
646:         WITH loc_oPagina.txt_4c_Valmeta
647:             .Value         = 0
648:             .Top           = 258
649:             .Left          = 492
650:             .Width         = 126
651:             .Height        = 24
652:             .FontName      = "Tahoma"
653:             .FontSize      = 8
654:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 662 a 674:
662:         ENDWITH
663: 
664:         *-- Label Cota Desconto $ (Say2: top=261+29=290, left=398)
665:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
666:         WITH loc_oPagina.lbl_4c_Label2
667:             .Caption   = "Cota Desconto $ :"
668:             .Top       = 290
669:             .Left      = 398
670:             .Width     = 113
671:             .Height    = 17
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .FontBold  = .F.

*-- Linhas 684 a 693:
684:         loc_oPagina.AddObject("txt_4c_Valcota", "TextBox")
685:         WITH loc_oPagina.txt_4c_Valcota
686:             .Value         = 0
687:             .Top           = 285
688:             .Left          = 492
689:             .Width         = 126
690:             .Height        = 24
691:             .FontName      = "Tahoma"
692:             .FontSize      = 8
693:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 701 a 713:
701:         ENDWITH
702: 
703:         *-- Label Desconto Aplicado $ (Say8: top=288+29=317, left=381)
704:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
705:         WITH loc_oPagina.lbl_4c_Label8
706:             .Caption   = "Desconto Aplicado $ :"
707:             .Top       = 317
708:             .Left      = 381
709:             .Width     = 130
710:             .Height    = 17
711:             .FontName  = "Tahoma"
712:             .FontSize  = 8
713:             .FontBold  = .F.

*-- Linhas 723 a 732:
723:         loc_oPagina.AddObject("txt_4c_Valdes", "TextBox")
724:         WITH loc_oPagina.txt_4c_Valdes
725:             .Value         = 0
726:             .Top           = 312
727:             .Left          = 492
728:             .Width         = 126
729:             .Height        = 24
730:             .FontName      = "Tahoma"
731:             .FontSize      = 8
732:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 741 a 753:
741:         ENDWITH
742: 
743:         *-- Label Cota Desconto % (Say4: top=315+29=344, left=393)
744:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
745:         WITH loc_oPagina.lbl_4c_Label4
746:             .Caption   = "Cota Desconto % :"
747:             .Top       = 344
748:             .Left      = 393
749:             .Width     = 116
750:             .Height    = 17
751:             .FontName  = "Tahoma"
752:             .FontSize  = 8
753:             .FontBold  = .F.

*-- Linhas 763 a 772:
763:         loc_oPagina.AddObject("txt_4c_Pdes", "TextBox")
764:         WITH loc_oPagina.txt_4c_Pdes
765:             .Value         = 0
766:             .Top           = 339
767:             .Left          = 492
768:             .Width         = 126
769:             .Height        = 24
770:             .FontName      = "Tahoma"
771:             .FontSize      = 8
772:             .BackColor     = RGB(255, 255, 255)

*-- Linhas 781 a 790:
781:         ENDWITH
782: 
783:         *-- BINDEVENTs dos botoes de Page2
784:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
785:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
786: 
787:         *-- BINDEVENT Empresa: validar ao perder foco
788:         BINDEVENT(loc_oPagina.txt_4c_Emps, "KeyPress", THIS, "ValidarEmps")
789: 
790:         *-- BINDEVENT Valmeta/Valcota: recalcular % ao sair do campo

*-- Linhas 877 a 890:
877:                     loc_oGrid.Column6.ControlSource = "crSigCdDes.valdes"
878: 
879:                     *-- Captions APOS ControlSource (RecordSource reseta os captions)
880:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
881:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
882:                     loc_oGrid.Column3.Header1.Caption = "Dt Inicio"
883:                     loc_oGrid.Column4.Header1.Caption = "Dt final"
884:                     loc_oGrid.Column5.Header1.Caption = "Vr Meta"
885:                     loc_oGrid.Column6.Header1.Caption = "Vr Desconto"
886: 
887:                     THIS.FormatarGridLista(loc_oGrid)
888:                 ENDIF
889:                 loc_lResultado = .T.
890:             ENDIF

*-- Linhas 924 a 932:
924: 
925:     *==========================================================================
926:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
927:     * EXCECAO: cmd_4c_Btncarregar inicia oculto (Visible=.F. conforme legado)
928:     * EXCECAO: cnt_4c_Cabecalho gerencia propria visibilidade (nao deve ser forcado)
929:     *==========================================================================
930:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
931:         LOCAL loc_nI, loc_oObjeto, loc_nP, loc_cNome
932: 

*-- Linhas 938 a 946:
938: 
939:                 *-- Pular controles que devem iniciar ocultos ou gerenciam propria visibilidade
940:                 *-- Recursao antes do LOOP para que filhos ainda sejam processados
941:                 IF INLIST(loc_cNome, "CMD_4C_BTNCARREGAR", "CNT_4C_CABECALHO")
942:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
943:                         THIS.TornarControlesVisiveis(loc_oObjeto)
944:                     ENDIF
945:                     LOOP
946:                 ENDIF

*-- Linhas 1022 a 1031:
1022:             THIS.AjustarBotoesPorModo()
1023:             THIS.AlternarPagina(2)
1024: 
1025:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1026:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva.cmd_4c_Confirmar.SetFocus()
1027:             ENDIF
1028:         ENDIF
1029:     ENDPROC
1030: 
1031:     *==========================================================================

*-- Linhas 1202 a 1215:
1202: 
1203:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1204: 
1205:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1206:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = !loc_lVisualizar
1207:         ENDIF
1208: 
1209:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Cancelar", 5)
1210:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1211:         ENDIF
1212:     ENDPROC
1213: 
1214:     *==========================================================================
1215:     * HabilitarCampos - Habilita/desabilita campos conforme modo


### BO (C:\4c\projeto\app\classes\DESBO.prg):
*==============================================================================
* DESBO.prg - Business Object para Cadastro de Cotas de Desconto por Periodo
* Tabela : sigcddes
* Herda de: BusinessBase
* Fase 1 : Propriedades e Init
*==============================================================================

DEFINE CLASS DESBO AS BusinessBase

    *-- Propriedades da tabela sigcddes
    this_cCodigo   = ""    && codigo   char(10) PK (auto-gerado no Inserir)
    this_cEmps     = ""    && emps     char(3)
    this_dDtini    = {}    && dtini    datetime
    this_dDtfin    = {}    && dtfin    datetime
    this_nValmeta  = 0     && valmeta  numeric(11,2)
    this_nValcota  = 0     && valcota  numeric(11,2) cota desconto R$
    this_nValcotac = 0     && valcotac numeric(11,2) cota (outra moeda)
    this_nValdes   = 0     && valdes   numeric(11,2) desconto aplicado R$ (readonly)
    this_cUsualts  = ""    && usualts  char(10)
    this_dDtalts   = {}    && dtalts   datetime

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcddes"
        THIS.this_cCampoChave = "codigo"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = TratarNulo(codigo,   "C")
            THIS.this_cEmps     = TratarNulo(emps,     "C")
            THIS.this_dDtini    = TratarNulo(dtini,    "T")
            THIS.this_dDtfin    = TratarNulo(dtfin,    "T")
            THIS.this_nValmeta  = TratarNulo(valmeta,  "N")
            THIS.this_nValcota  = TratarNulo(valcota,  "N")
            THIS.this_nValcotac = TratarNulo(valcotac, "N")
            THIS.this_nValdes   = TratarNulo(valdes,   "N")
            THIS.this_cUsualts  = TratarNulo(usualts,  "C")
            THIS.this_dDtalts   = TratarNulo(dtalts,   "T")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da chave primaria para auditoria
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *==========================================================================
    * GerarCodigo - Gera codigo unico: emps(3) + YYMM(4) + seq(3) = 10 chars
    *==========================================================================
    PROTECTED FUNCTION GerarCodigo()
        LOCAL loc_cPrefixo, loc_cSQL, loc_nSeq, loc_cCodigo
        loc_cCodigo = ""

        TRY
            loc_cPrefixo = ALLTRIM(THIS.this_cEmps) + ;
                SUBSTR(ALLTRIM(STR(YEAR(DATE()))), 3) + ;
                PADL(ALLTRIM(STR(MONTH(DATE()))), 2, "0")

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes WHERE codigo LIKE '" + ;
                loc_cPrefixo + "%'"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_nSeq = cursor_4c_GerarCod.cnt + 1
                loc_cCodigo = loc_cPrefixo + PADL(ALLTRIM(STR(loc_nSeq)), 3, "0")
            ENDIF

            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao gerar c" + CHR(243) + "digo")
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF
        ENDTRY

        RETURN loc_cCodigo
    ENDFUNC

    *==========================================================================
    * ValidarSobreposicaoPeriodo - Verifica sobreposicao de periodo por empresa
    * par_cCodigoExcluir: codigo a excluir da verificacao (para Atualizar)
    *==========================================================================
    PROTECTED FUNCTION ValidarSobreposicaoPeriodo(par_cEmps, par_dIni, par_dFin, par_cCodigoExcluir)
        LOCAL loc_cSQL, loc_cFiltroExcluir, loc_lSobrepoe
        loc_lSobrepoe = .F.

        TRY
            loc_cFiltroExcluir = ""
            IF !EMPTY(ALLTRIM(par_cCodigoExcluir))
                loc_cFiltroExcluir = " AND codigo <> " + EscaparSQL(par_cCodigoExcluir)
            ENDIF

            loc_cSQL = "SELECT COUNT(*) AS cnt FROM sigcddes" + ;
                " WHERE emps = " + EscaparSQL(par_cEmps) + ;
                " AND CONVERT(DATE, dtini) <= CONVERT(DATE, " + FormatarDataSQL(par_dFin) + ")" + ;
                " AND CONVERT(DATE, dtfin) >= CONVERT(DATE, " + FormatarDataSQL(par_dIni) + ")" + ;
                loc_cFiltroExcluir

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Sobrepoe") > 0
                SELECT cursor_4c_Sobrepoe
                loc_lSobrepoe = (cursor_4c_Sobrepoe.cnt > 0)
            ENDIF

            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao validar per" + CHR(237) + "odo")
            IF USED("cursor_4c_Sobrepoe")
                USE IN cursor_4c_Sobrepoe
            ENDIF
        ENDTRY

        RETURN loc_lSobrepoe
    ENDFUNC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios e regras de negocio
    * par_lNovoRegistro: .T. = Inserir, .F. = Atualizar
    *==========================================================================
    PROTECTED FUNCTION ValidarDados(par_lNovoRegistro)
        IF EMPTY(ALLTRIM(THIS.this_cEmps))
            MsgAviso("Empresa n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtini)
            MsgAviso("Data Inicial n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_dDtfin)
            MsgAviso("Data final n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF THIS.this_dDtini > THIS.this_dDtfin
            MsgAviso("As datas est" + CHR(227) + "o incompat" + CHR(237) + "veis!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        LOCAL loc_cCodigoExcluir
        loc_cCodigoExcluir = IIF(par_lNovoRegistro, "", THIS.this_cCodigo)

        IF THIS.ValidarSobreposicaoPeriodo(THIS.this_cEmps, THIS.this_dDtini, THIS.this_dDtfin, loc_cCodigoExcluir)
            MsgAviso("Esse intervalo j" + CHR(225) + " est" + CHR(225) + " cadastrado para essa empresa!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT em sigcddes
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCodigo
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.T.)
            RETURN .F.
        ENDIF

        TRY
            loc_cCodigo = THIS.GerarCodigo()
            IF EMPTY(loc_cCodigo)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar c" + CHR(243) + "digo.", "Erro")
            ELSE
                THIS.this_cCodigo  = loc_cCodigo
                THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

                loc_cSQL = "INSERT INTO sigcddes" + ;
                    " (codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)          + ", " + ;
                    EscaparSQL(THIS.this_cEmps)            + ", " + ;
                    FormatarDataSQL(THIS.this_dDtini)      + ", " + ;
                    FormatarDataSQL(THIS.this_dDtfin)      + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValmeta)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcota)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValcotac) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nValdes)   + ", " + ;
                    EscaparSQL(THIS.this_cUsualts)         + ", " + ;
                    "GETDATE())"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE em sigcddes
    * Nota: emps/dtini/dtfin NAO editaveis apos criacao (When=INSERIR only)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF !THIS.ValidarDados(.F.)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_cUsualts = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE sigcddes SET" + ;
                " valmeta  = " + FormatarNumeroSQL(THIS.this_nValmeta)  + "," + ;
                " valcota  = " + FormatarNumeroSQL(THIS.this_nValcota)  + "," + ;
                " valcotac = " + FormatarNumeroSQL(THIS.this_nValcotac) + "," + ;
                " usualts  = " + EscaparSQL(THIS.this_cUsualts) + "," + ;
                " dtalts   = GETDATE()" + ;
                " WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - DELETE de sigcddes (chamado por BusinessBase.Excluir)
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF THIS.this_nValdes > 0
            MsgAviso("Exclus" + CHR(227) + "o n" + CHR(227) + "o permitida. Cota j" + CHR(225) + " utilizada!", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM sigcddes WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao excluir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT para grid (cursor crSigCdDes)
    * par_cFiltro: codigo de empresa para filtrar (vazio = todos)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = ""
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE emps = " + EscaparSQL(ALLTRIM(par_cFiltro))
            ENDIF

            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valdes, usualts, dtalts" + ;
                " FROM sigcddes" + loc_cWhere + ;
                " ORDER BY emps, dtini"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdDes") >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT por chave primaria
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigo, emps, dtini, dtfin, valmeta, valcota, valcotac, valdes, usualts, dtalts" + ;
                " FROM sigcddes WHERE codigo = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Registro n" + CHR(227) + "o encontrado.", "")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro ao carregar")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

