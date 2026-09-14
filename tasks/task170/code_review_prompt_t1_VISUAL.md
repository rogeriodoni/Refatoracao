# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [ALINHAMENTO] Botao 'cmd_4c_Processar' tem Top=7 mas grupo usa Top=5 (diferenca de 2px)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 217: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 241: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 289: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 313: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 349: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 502: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 526: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3612 linhas total):

*-- Linhas 56 a 64:
56: 
57:         TRY
58:             *-- Caption com acentos (CHR codes obrigatorios - CLAUDE.md regra 4)
59:             THIS.Caption = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
60: 
61:             *-- Instanciar Business Object
62:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")
63: 
64:             IF VARTYPE(THIS.this_oBusinessObject) = "O"

*-- Linhas 105 a 187:
105: 
106:     *--------------------------------------------------------------------------
107:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas (Lista/Dados)
108:     * PageFrame.Top = -29 para ocultar abas -> compensacao +29 nos controles
109:     *--------------------------------------------------------------------------
110:     PROTECTED PROCEDURE ConfigurarPageFrame()
111:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
112: 
113:         WITH THIS.pgf_4c_Paginas
114:             .Top       = -29
115:             .Left      = 0
116:             .Width     = THIS.Width
117:             .Height    = THIS.Height + 29
118:             .PageCount = 2
119:             .Tabs      = .F.
120:             .Visible   = .T.
121:         ENDWITH
122: 
123:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
124:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
126: 
127:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
128:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
130: 
131:         THIS.ConfigurarPaginaLista()
132:         THIS.ConfigurarPaginaDados()
133:     ENDPROC
134: 
135:     *--------------------------------------------------------------------------
136:     * ConfigurarPaginaLista - Configura Page1 (Lista)
137:     * Original: SIGPRCTR.Pagina.Lista
138:     * Contem: cabecalho, filtro periodo, botoes CRUD, grd_4c_Lista
139:     * Compensacao PageFrame.Top=-29: todos os controles com Top += 29
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarPaginaLista()
142:         LOCAL loc_oPagina, loc_oGrid
143:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
144:         loc_oGrid   = .NULL.
145: 
146:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
147: 
148:         *-- Container cabecalho com fundo escuro (cntSombra no legado)
149:         *-- Top = 2 + 29 (compensacao PageFrame.Top=-29) = 31
150:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
151:         WITH loc_oPagina.cnt_4c_Cabecalho
152:             .Top         = 31
153:             .Left        = 0
154:             .Width       = THIS.Width
155:             .Height      = 80
156:             .BackColor   = RGB(100, 100, 100)
157:             .BackStyle   = 1
158:             .BorderWidth = 0
159:             .Visible     = .T.
160:         ENDWITH
161: 
162:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
163:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
164:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
165:             .Top       = 15
166:             .Left      = 10
167:             .Width     = THIS.Width - 20
168:             .Height    = 40
169:             .FontName  = "Tahoma"
170:             .FontSize  = 16
171:             .FontBold  = .T.
172:             .ForeColor = RGB(0, 0, 0)
173:             .BackStyle = 0
174:             .AutoSize  = .F.
175:             .Visible   = .T.
176:         ENDWITH
177: 
178:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
179:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
180:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
181:             .Top       = 18
182:             .Left      = 10
183:             .Width     = THIS.Width - 20
184:             .Height    = 46
185:             .FontName  = "Tahoma"
186:             .FontSize  = 16
187:             .FontBold  = .T.

*-- Linhas 195 a 223:
195:         *-- Top = 0 + 29 (compensacao) = 29
196:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
197:         WITH loc_oPagina.cnt_4c_Botoes
198:             .Top         = 29
199:             .Left        = 542
200:             .Width       = 390
201:             .Height      = 85
202:             .BackStyle = 0
203:             .BorderWidth = 0
204:             .Visible     = .T.
205:         ENDWITH
206: 
207:         *-- Botao Incluir (Left=5)
208:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
209:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
210:             .Caption         = "Incluir"
211:             .Top             = 5
212:             .Left            = 5
213:             .Width           = 75
214:             .Height          = 75
215:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
216:             .PicturePosition = 13
217:             .FontName        = "Comic Sans MS"
218:             .FontSize        = 8
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .ForeColor       = RGB(90, 90, 90)
222:             .BackColor       = RGB(255, 255, 255)
223:             .Themes          = .F.

*-- Linhas 229 a 247:
229:         ENDWITH
230: 
231:         *-- Botao Visualizar (Left=80)
232:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
233:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
234:             .Caption         = "Visualizar"
235:             .Top             = 5
236:             .Left            = 80
237:             .Width           = 75
238:             .Height          = 75
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
240:             .PicturePosition = 13
241:             .FontName        = "Comic Sans MS"
242:             .FontSize        = 8
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .ForeColor       = RGB(90, 90, 90)
246:             .BackColor       = RGB(255, 255, 255)
247:             .Themes          = .F.

*-- Linhas 253 a 271:
253:         ENDWITH
254: 
255:         *-- Botao Alterar (Left=155)
256:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
257:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
258:             .Caption         = "Alterar"
259:             .Top             = 5
260:             .Left            = 155
261:             .Width           = 75
262:             .Height          = 75
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
264:             .PicturePosition = 13
265:             .FontName        = "Comic Sans MS"
266:             .FontSize        = 8
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .ForeColor       = RGB(90, 90, 90)
270:             .BackColor       = RGB(255, 255, 255)
271:             .Themes          = .F.

*-- Linhas 277 a 295:
277:         ENDWITH
278: 
279:         *-- Botao Excluir (Left=230)
280:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
281:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
282:             .Caption         = "Excluir"
283:             .Top             = 5
284:             .Left            = 230
285:             .Width           = 75
286:             .Height          = 75
287:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
288:             .PicturePosition = 13
289:             .FontName        = "Comic Sans MS"
290:             .FontSize        = 8
291:             .FontBold        = .T.
292:             .FontItalic      = .T.
293:             .ForeColor       = RGB(90, 90, 90)
294:             .BackColor       = RGB(255, 255, 255)
295:             .Themes          = .F.

*-- Linhas 301 a 319:
301:         ENDWITH
302: 
303:         *-- Botao Buscar (Left=305)
304:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
305:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
306:             .Caption         = "Buscar"
307:             .Top             = 5
308:             .Left            = 305
309:             .Width           = 75
310:             .Height          = 75
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
312:             .PicturePosition = 13
313:             .FontName        = "Comic Sans MS"
314:             .FontSize        = 8
315:             .FontBold        = .T.
316:             .FontItalic      = .T.
317:             .ForeColor       = RGB(90, 90, 90)
318:             .BackColor       = RGB(255, 255, 255)
319:             .Themes          = .F.

*-- Linhas 327 a 355:
327:         *-- Container saida - PADRAO CANONICO (CLAUDE.md regra #10: Left=917, Width=90)
328:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
329:         WITH loc_oPagina.cnt_4c_Saida
330:             .Top         = 29
331:             .Left        = 917
332:             .Width       = 90
333:             .Height      = 85
334:             .BackStyle   = 0
335:             .BorderWidth = 0
336:             .Visible     = .T.
337:         ENDWITH
338: 
339:         *-- Botao Encerrar (canonico: Left=5, Width=75, Height=75)
340:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
341:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
342:             .Caption         = "Encerrar"
343:             .Top             = 5
344:             .Left            = 5
345:             .Width           = 75
346:             .Height          = 75
347:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
348:             .PicturePosition = 13
349:             .FontName        = "Comic Sans MS"
350:             .FontSize        = 8
351:             .FontBold        = .T.
352:             .FontItalic      = .T.
353:             .ForeColor       = RGB(90, 90, 90)
354:             .BackColor       = RGB(255, 255, 255)
355:             .Themes          = .F.

*-- Linhas 362 a 374:
362: 
363:         *-- Filtro de periodo (original: Label1/Dt_inicial/Dt_final em Pagina.Lista)
364:         *-- Original top=106 -> compensacao +29 -> top=135
365:         loc_oPagina.AddObject("lbl_4c_LabelPeriodo", "Label")
366:         WITH loc_oPagina.lbl_4c_LabelPeriodo
367:             .Caption   = "Per" + CHR(237) + "odo :"
368:             .Top       = 135
369:             .Left      = 440
370:             .Width     = 50
371:             .Height    = 15
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 380 a 418:
380:         loc_oPagina.AddObject("txt_4c_DtInicio", "TextBox")
381:         WITH loc_oPagina.txt_4c_DtInicio
382:             .Value     = DATE()
383:             .Top       = 131
384:             .Left      = 495
385:             .Width     = 80
386:             .Height    = 21
387:             .FontName  = "Tahoma"
388:             .FontSize  = 8
389:             .ForeColor = RGB(90, 90, 90)
390:             .BackColor = RGB(255, 255, 255)
391:             .Format    = "D"
392:             .Visible   = .T.
393:         ENDWITH
394: 
395:         loc_oPagina.AddObject("lbl_4c_LabelSep", "Label")
396:         WITH loc_oPagina.lbl_4c_LabelSep
397:             .Caption   = "-"
398:             .Top       = 135
399:             .Left      = 582
400:             .Width     = 10
401:             .Height    = 15
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .ForeColor = RGB(90, 90, 90)
405:             .BackStyle = 0
406:             .Visible   = .T.
407:         ENDWITH
408: 
409:         loc_oPagina.AddObject("txt_4c_DtFim", "TextBox")
410:         WITH loc_oPagina.txt_4c_DtFim
411:             .Value     = DATE()
412:             .Top       = 131
413:             .Left      = 598
414:             .Width     = 80
415:             .Height    = 21
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 427 a 436:
427:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
428:         loc_oGrid = loc_oPagina.grd_4c_Lista
429: 
430:         loc_oGrid.Top          = 160
431:         loc_oGrid.Left         = 5
432:         loc_oGrid.Width        = THIS.Width - 15
433:         loc_oGrid.Height       = 450
434:         loc_oGrid.ColumnCount  = 6
435:         loc_oGrid.FontName     = "Verdana"
436:         loc_oGrid.FontSize     = 8

*-- Linhas 448 a 461:
448:         loc_oGrid.Visible      = .T.
449: 
450:         *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
451:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
452:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
453:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
454:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
455:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
456:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
457: 
458:         *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)
459:         BINDEVENT(loc_oPagina.txt_4c_DtInicio, "KeyPress", THIS, "DtInicioLostFocus")
460:         BINDEVENT(loc_oPagina.txt_4c_DtFim,    "KeyPress", THIS, "DtFimLostFocus")
461: 

*-- Linhas 481 a 508:
481:         *-- Top = 4 + 29 (compensacao) = 33; Left = 1030 (lado direito)
482:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
483:         WITH loc_oPagina.cnt_4c_BotoesAcao
484:             .Top         = 33
485:             .Left        = 1030
486:             .Width       = 160
487:             .Height      = 85
488:             .BackStyle   = 0
489:             .Visible     = .T.
490:         ENDWITH
491: 
492:         *-- Botao Confirmar (salvar)
493:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
494:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
495:             .Caption         = "Confirmar"
496:             .Top             = 5
497:             .Left            = 5
498:             .Width           = 75
499:             .Height          = 75
500:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
501:             .PicturePosition = 13
502:             .FontName        = "Comic Sans MS"
503:             .FontSize        = 8
504:             .FontBold        = .T.
505:             .FontItalic      = .T.
506:             .ForeColor       = RGB(90, 90, 90)
507:             .BackColor       = RGB(255, 255, 255)
508:             .Themes          = .F.

*-- Linhas 514 a 532:
514:         ENDWITH
515: 
516:         *-- Botao Cancelar
517:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
518:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
519:             .Caption         = "Encerrar"
520:             .Top             = 5
521:             .Left            = 80
522:             .Width           = 75
523:             .Height          = 75
524:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
525:             .PicturePosition = 13
526:             .FontName        = "Comic Sans MS"
527:             .FontSize        = 8
528:             .FontBold        = .T.
529:             .FontItalic      = .T.
530:             .ForeColor       = RGB(90, 90, 90)
531:             .BackColor       = RGB(255, 255, 255)
532:             .Themes          = .F.

*-- Linhas 538 a 567:
538:         ENDWITH
539: 
540:         *-- BINDEVENTs dos botoes de acao (PUBLIC para BINDEVENT)
541:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
542:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
543: 
544:         *-- PageFrame interno (Pageframe1 no legado: top=3, left=-1, width=1199, height=624)
545:         *-- Top = 3 + 29 (compensacao) = 32
546:         loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
547:         loc_oPgfAbas = loc_oPagina.pgf_4c_Abas
548: 
549:         loc_oPgfAbas.Top       = 32
550:         loc_oPgfAbas.Left      = -1
551:         loc_oPgfAbas.Width     = 1199
552:         loc_oPgfAbas.Height    = 624
553:         loc_oPgfAbas.PageCount = 2
554:         loc_oPgfAbas.Tabs      = .T.
555:         loc_oPgfAbas.Visible   = .T.
556: 
557:         *-- Page1 (Dados): campos do cabecalho da sessao + grdEstoque (Fase 6)
558:         loc_oPgfAbas.Page1.Caption   = "Dados"
559:         loc_oPgfAbas.Page1.BackColor = RGB(255, 255, 255)
560: 
561:         *-- Page2 (Itens): grdDisponivel + grdItemXml (Fase 6)
562:         loc_oPgfAbas.Page2.Caption   = "Itens"
563:         loc_oPgfAbas.Page2.BackColor = RGB(255, 255, 255)
564: 
565:         *-- Fases 5-6: campos das abas Dados e Itens
566:         THIS.ConfigurarAbaDados()
567:         THIS.ConfigurarAbaItens()

*-- Linhas 581 a 593:
581:         loc_oOpt  = .NULL.
582: 
583:         *-- Label Fornecedores (Say4: top=69, left=228)
584:         loc_oPage.AddObject("lbl_4c_Fornecedores", "Label")
585:         WITH loc_oPage.lbl_4c_Fornecedores
586:             .Caption   = "Fornecedores:"
587:             .Top       = 69
588:             .Left      = 228
589:             .Width     = 75
590:             .Height    = 17
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 600 a 609:
600:         loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
601:         WITH loc_oPage.txt_4c_Grupo
602:             .Value     = ""
603:             .Top       = 66
604:             .Left      = 307
605:             .Width     = 85
606:             .Height    = 21
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 615 a 624:
615:         loc_oPage.AddObject("txt_4c_Conta", "TextBox")
616:         WITH loc_oPage.txt_4c_Conta
617:             .Value     = ""
618:             .Top       = 66
619:             .Left      = 394
620:             .Width     = 85
621:             .Height    = 21
622:             .FontName  = "Tahoma"
623:             .FontSize  = 8
624:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 630 a 672:
630:         loc_oPage.AddObject("txt_4c_Cpf", "TextBox")
631:         WITH loc_oPage.txt_4c_Cpf
632:             .Value     = ""
633:             .Top       = 66
634:             .Left      = 481
635:             .Width     = 146
636:             .Height    = 21
637:             .FontName  = "Tahoma"
638:             .FontSize  = 8
639:             .ForeColor = RGB(90, 90, 90)
640:             .BackColor = RGB(255, 255, 255)
641:             .Visible   = .T.
642:         ENDWITH
643: 
644:         *-- CommandButton Consulta (Bot_Consulta: top=70, left=667, width=40, height=40)
645:         *-- Standalone icon button: Themes=.T. obrigatorio (memoria)
646:         loc_oPage.AddObject("cmd_4c_Consulta", "CommandButton")
647:         WITH loc_oPage.cmd_4c_Consulta
648:             .Caption         = ""
649:             .Top             = 70
650:             .Left            = 667
651:             .Width           = 40
652:             .Height          = 40
653:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
654:             .PicturePosition = 4
655:             .Themes          = .T.
656:             .SpecialEffect   = 0
657:             .MousePointer    = 15
658:             .ToolTipText     = "Consultar"
659:             .Visible         = .T.
660:         ENDWITH
661: 
662:         *-- CommandButton Cadastros (btnCadastros: top=70, left=708, width=40, height=40)
663:         loc_oPage.AddObject("cmd_4c_Cadastros", "CommandButton")
664:         WITH loc_oPage.cmd_4c_Cadastros
665:             .Caption         = ""
666:             .Top             = 70
667:             .Left            = 708
668:             .Width           = 40
669:             .Height          = 40
670:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
671:             .PicturePosition = 4
672:             .Themes          = .T.

*-- Linhas 680 a 705:
680:         loc_oPage.AddObject("txt_4c_Dconta", "TextBox")
681:         WITH loc_oPage.txt_4c_Dconta
682:             .Value     = ""
683:             .Top       = 89
684:             .Left      = 307
685:             .Width     = 357
686:             .Height    = 21
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackColor = RGB(230, 230, 230)
691:             .ReadOnly  = .T.
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         *-- Label Precificacao (Say1: top=114, left=237)
696:         loc_oPage.AddObject("lbl_4c_Precificacao", "Label")
697:         WITH loc_oPage.lbl_4c_Precificacao
698:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o:"
699:             .Top       = 114
700:             .Left      = 237
701:             .Width     = 65
702:             .Height    = 17
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 713 a 759:
713:         loc_oPage.AddObject("opt_4c_Custo", "OptionGroup")
714:         loc_oOpt = loc_oPage.opt_4c_Custo
715: 
716:         loc_oOpt.Top         = 113
717:         loc_oOpt.Left        = 303
718:         loc_oOpt.Width       = 255
719:         loc_oOpt.Height      = 17
720:         loc_oOpt.ButtonCount = 2
721:         loc_oOpt.Value       = 1
722:         loc_oOpt.BackStyle   = 0
723:         loc_oOpt.Visible     = .T.
724: 
725:         WITH loc_oOpt.Buttons(1)
726:             .Caption   = "Custo"
727:             .Top       = 0
728:             .Left      = 0
729:             .Width     = 120
730:             .Height    = 17
731:             .FontName  = "Tahoma"
732:             .FontSize  = 8
733:             .ForeColor = RGB(90, 90, 90)
734:             .AutoSize  = .F.
735:         ENDWITH
736: 
737:         WITH loc_oOpt.Buttons(2)
738:             .Caption   = "Pre" + CHR(231) + "o de Venda"
739:             .Top       = 0
740:             .Left      = 125
741:             .Width     = 130
742:             .Height    = 17
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(90, 90, 90)
746:             .AutoSize  = .F.
747:         ENDWITH
748: 
749:         *-- Label Moeda (Say3: top=137, left=262)
750:         loc_oPage.AddObject("lbl_4c_Moeda", "Label")
751:         WITH loc_oPage.lbl_4c_Moeda
752:             .Caption   = "Moeda:"
753:             .Top       = 137
754:             .Left      = 262
755:             .Width     = 42
756:             .Height    = 17
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8
759:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 766 a 803:
766:         loc_oPage.AddObject("txt_4c_Moeda", "TextBox")
767:         WITH loc_oPage.txt_4c_Moeda
768:             .Value     = ""
769:             .Top       = 134
770:             .Left      = 307
771:             .Width     = 85
772:             .Height    = 21
773:             .FontName  = "Tahoma"
774:             .FontSize  = 8
775:             .ForeColor = RGB(90, 90, 90)
776:             .BackColor = RGB(255, 255, 255)
777:             .Visible   = .T.
778:         ENDWITH
779: 
780:         *-- Shape1 decorativo (top=2, left=912, width=90, height=110)
781:         loc_oPage.AddObject("shp_4c_Shape1", "Shape")
782:         WITH loc_oPage.shp_4c_Shape1
783:             .Top         = 2
784:             .Left        = 912
785:             .Width       = 90
786:             .Height      = 110
787:             .BackStyle   = 1
788:             .BackColor   = RGB(192, 192, 192)
789:             .BorderStyle = 0
790:             .Visible     = .T.
791:         ENDWITH
792: 
793:         *-- Label Diretorio (Say2: top=160, left=253)
794:         loc_oPage.AddObject("lbl_4c_Diretorio", "Label")
795:         WITH loc_oPage.lbl_4c_Diretorio
796:             .Caption   = "Diret" + CHR(243) + "rio:"
797:             .Top       = 160
798:             .Left      = 253
799:             .Width     = 52
800:             .Height    = 17
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 810 a 850:
810:         loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
811:         WITH loc_oPage.txt_4c_Arquivo
812:             .Value         = ""
813:             .Top           = 157
814:             .Left          = 307
815:             .Width         = 357
816:             .Height        = 21
817:             .FontName      = "Tahoma"
818:             .FontSize      = 8
819:             .ForeColor     = RGB(0, 0, 0)
820:             .BackColor     = RGB(230, 230, 230)
821:             .ReadOnly      = .T.
822:             .SpecialEffect = 1
823:             .Visible       = .T.
824:         ENDWITH
825: 
826:         *-- CommandButton BrowseArquivo (Command12: top=157, left=667, width=20, height=20)
827:         loc_oPage.AddObject("cmd_4c_BrowseArquivo", "CommandButton")
828:         WITH loc_oPage.cmd_4c_BrowseArquivo
829:             .Caption  = "..."
830:             .Top      = 157
831:             .Left     = 667
832:             .Width    = 20
833:             .Height   = 20
834:             .FontName = "Tahoma"
835:             .FontSize = 8
836:             .Themes   = .T.
837:             .Visible  = .T.
838:         ENDWITH
839: 
840:         *-- Label "Carregar produtos que constam nos XML's :" (Label1: top=184, left=55)
841:         loc_oPage.AddObject("lbl_4c_OpcaoFil", "Label")
842:         WITH loc_oPage.lbl_4c_OpcaoFil
843:             .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
844:             .Top       = 184
845:             .Left      = 55
846:             .Width     = 246
847:             .Height    = 15
848:             .FontName  = "Tahoma"
849:             .FontSize  = 8
850:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 858 a 913:
858:         loc_oPage.AddObject("opt_4c_Fil", "OptionGroup")
859:         loc_oOpt = loc_oPage.opt_4c_Fil
860: 
861:         loc_oOpt.Top         = 179
862:         loc_oOpt.Left        = 303
863:         loc_oOpt.Width       = 192
864:         loc_oOpt.Height      = 24
865:         loc_oOpt.ButtonCount = 3
866:         loc_oOpt.Value       = 1
867:         loc_oOpt.BackStyle   = 0
868:         loc_oOpt.Visible     = .T.
869: 
870:         WITH loc_oOpt.Buttons(1)
871:             .Caption   = "Todos"
872:             .Top       = 3
873:             .Left      = 0
874:             .Width     = 58
875:             .Height    = 17
876:             .FontName  = "Tahoma"
877:             .FontSize  = 8
878:             .AutoSize  = .F.
879:         ENDWITH
880: 
881:         WITH loc_oOpt.Buttons(2)
882:             .Caption   = "Cadastrados"
883:             .Top       = 3
884:             .Left      = 60
885:             .Width     = 84
886:             .Height    = 17
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .AutoSize  = .F.
890:         ENDWITH
891: 
892:         WITH loc_oOpt.Buttons(3)
893:             .Caption   = "N" + CHR(227) + "o Cad."
894:             .Top       = 3
895:             .Left      = 146
896:             .Width     = 46
897:             .Height    = 17
898:             .FontName  = "Tahoma"
899:             .FontSize  = 8
900:             .AutoSize  = .F.
901:         ENDWITH
902: 
903:         *-- Label "Movimentacoes:" (Say5: top=204, left=203)
904:         loc_oPage.AddObject("lbl_4c_Movimentacoes", "Label")
905:         WITH loc_oPage.lbl_4c_Movimentacoes
906:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es:"
907:             .Top       = 204
908:             .Left      = 203
909:             .Width     = 100
910:             .Height    = 17
911:             .FontName  = "Tahoma"
912:             .FontSize  = 8
913:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 922 a 931:
922:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
923:         loc_oPage.grd_4c_Estoque.ColumnCount = 6
924:         WITH loc_oPage.grd_4c_Estoque
925:             .Top       = 206
926:             .Left      = 307
927:             .Width     = 545
928:             .Height    = 340
929:             .FontName  = "Tahoma"
930:             .FontSize  = 8
931:             .GridLines = 1

*-- Linhas 938 a 1065:
938:             .Width     = 25
939:             .Resizable = .F.
940:         ENDWITH
941:         loc_oPage.grd_4c_Estoque.Column1.Header1.Caption = ""
942:         WITH loc_oPage.grd_4c_Estoque.Column2
943:             .Width = 65
944:         ENDWITH
945:         loc_oPage.grd_4c_Estoque.Column2.Header1.Caption = "Empresa"
946:         WITH loc_oPage.grd_4c_Estoque.Column3
947:             .Width = 120
948:         ENDWITH
949:         loc_oPage.grd_4c_Estoque.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
950:         WITH loc_oPage.grd_4c_Estoque.Column4
951:             .Width = 80
952:         ENDWITH
953:         loc_oPage.grd_4c_Estoque.Column4.Header1.Caption = "Numero"
954:         WITH loc_oPage.grd_4c_Estoque.Column5
955:             .Width = 130
956:         ENDWITH
957:         loc_oPage.grd_4c_Estoque.Column5.Header1.Caption = "Grupo"
958:         WITH loc_oPage.grd_4c_Estoque.Column6
959:             .Width = 125
960:         ENDWITH
961:         loc_oPage.grd_4c_Estoque.Column6.Header1.Caption = "Conta"
962: 
963:         *-- CommandGroup cgp_4c_Operacao (cmdOperacao: top=334, left=857, width=85, height=85)
964:         loc_oPage.AddObject("cgp_4c_Operacao", "CommandGroup")
965:         WITH loc_oPage.cgp_4c_Operacao
966:             .Top         = 334
967:             .Left        = 857
968:             .Width       = 85
969:             .Height      = 85
970:             .ButtonCount = 1
971:             .BackStyle   = 1
972:             .BackColor   = RGB(192, 192, 192)
973:             .Visible     = .T.
974:         ENDWITH
975:         WITH loc_oPage.cgp_4c_Operacao.Buttons(1)
976:             .Caption  = "Acessar"
977:             .Top      = 5
978:             .Left     = 5
979:             .Width    = 75
980:             .Height   = 75
981:             .FontName = "Tahoma"
982:             .FontSize = 8
983:             .Themes   = .F.
984:         ENDWITH
985: 
986:         *-- CommandButton cmd_4c_Processar (processar: top=7, left=962, standalone/icon)
987:         *-- Standalone CommandButton com picture: Themes=.T. obrigatorio (memoria)
988:         loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
989:         WITH loc_oPage.cmd_4c_Processar
990:             .Caption         = "Processar"
991:             .Top             = 7
992:             .Left            = 962
993:             .Width           = 75
994:             .Height          = 75
995:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
996:             .PicturePosition = 4
997:             .Themes          = .T.
998:             .FontName        = "Tahoma"
999:             .FontSize        = 8
1000:             .Visible         = .T.
1001:         ENDWITH
1002: 
1003:         *-- BINDEVENTs (todos os handlers devem ser PUBLIC para BINDEVENT)
1004:         BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",         THIS, "ValidarGrupoAba")
1005:         BINDEVENT(loc_oPage.txt_4c_Grupo,         "KeyPress",          THIS, "TeclaGrupoAba")
1006:         BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",         THIS, "ValidarContaAba")
1007:         BINDEVENT(loc_oPage.txt_4c_Conta,         "KeyPress",          THIS, "TeclaContaAba")
1008:         BINDEVENT(loc_oPage.txt_4c_Cpf,           "KeyPress",         THIS, "ValidarCpfAba")
1009:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",         THIS, "ValidarMoedaAba")
1010:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",          THIS, "TeclaMoedaAba")
1011:         BINDEVENT(loc_oPage.cmd_4c_Consulta,      "Click",             THIS, "BtnConsultaAbaClick")
1012:         BINDEVENT(loc_oPage.cmd_4c_Cadastros,     "Click",             THIS, "BtnCadastrosAbaClick")
1013:         BINDEVENT(loc_oPage.cmd_4c_BrowseArquivo, "Click",             THIS, "BtnBrowseArquivoClick")
1014:         BINDEVENT(loc_oPage.cmd_4c_Processar,     "Click",             THIS, "BtnProcessarClick")
1015:         BINDEVENT(loc_oPage.cgp_4c_Operacao,      "Click",             THIS, "CgpOperacaoClick")
1016:         BINDEVENT(loc_oPage.grd_4c_Estoque,       "AfterRowColChange", THIS, "GrdEstoqueAfterRowColChange")
1017:         BINDEVENT(loc_oPage.opt_4c_Custo,         "InteractiveChange", THIS, "OptCustoInteractiveChange")
1018:         BINDEVENT(loc_oPage.opt_4c_Fil,           "InteractiveChange", THIS, "OptFilInteractiveChange")
1019:     ENDPROC
1020: 
1021:     *--------------------------------------------------------------------------
1022:     * ConfigurarAbaItens - Configura pgf_4c_Abas.Page2 (Itens) com grids e campos
1023:     * Original: SIGPRCTR.Pagina.Dados.Pageframe1.Page2
1024:     * grd_4c_Disponivel (crMovimentos), grd_4c_ItemXml (crDistribui)
1025:     *--------------------------------------------------------------------------
1026:     PROTECTED PROCEDURE ConfigurarAbaItens()
1027:         LOCAL loc_oPage, loc_oGrd
1028:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
1029:         loc_oGrd  = .NULL.
1030: 
1031:         *-- Shape5 decorativo (top=1, left=424, width=282, height=113)
1032:         loc_oPage.AddObject("shp_4c_Shape5", "Shape")
1033:         WITH loc_oPage.shp_4c_Shape5
1034:             .Top         = 1
1035:             .Left        = 424
1036:             .Width       = 282
1037:             .Height      = 113
1038:             .BackStyle   = 1
1039:             .BackColor   = RGB(192, 192, 192)
1040:             .BorderStyle = 0
1041:             .Visible     = .T.
1042:         ENDWITH
1043: 
1044:         *-- Image FigJpg (top=3, left=426, width=278, height=109)
1045:         loc_oPage.AddObject("img_4c_FigJpg", "Image")
1046:         WITH loc_oPage.img_4c_FigJpg
1047:             .Top      = 3
1048:             .Left     = 426
1049:             .Width    = 278
1050:             .Height   = 109
1051:             .Stretch  = 2
1052:             .Visible  = .T.
1053:         ENDWITH
1054: 
1055:         *-- Label "Procurar Produto :" (lbl_produto: top=74, left=8, width=91)
1056:         loc_oPage.AddObject("lbl_4c_Produto", "Label")
1057:         WITH loc_oPage.lbl_4c_Produto
1058:             .Caption   = "Procurar Produto :"
1059:             .Top       = 74
1060:             .Left      = 8
1061:             .Width     = 108
1062:             .Height    = 17
1063:             .FontName  = "Tahoma"
1064:             .FontSize  = 8
1065:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1072 a 1094:
1072:         loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
1073:         WITH loc_oPage.txt_4c_ProdutoInicial
1074:             .Value    = ""
1075:             .Top      = 90
1076:             .Left     = 8
1077:             .Width    = 108
1078:             .Height   = 21
1079:             .FontName = "Tahoma"
1080:             .FontSize = 8
1081:             .Visible  = .T.
1082:         ENDWITH
1083: 
1084:         *-- TextBox Sistema (readonly, top=113, left=8, width=684, height=20)
1085:         loc_oPage.AddObject("txt_4c_Sistema", "TextBox")
1086:         WITH loc_oPage.txt_4c_Sistema
1087:             .Value     = ""
1088:             .Top       = 113
1089:             .Left      = 8
1090:             .Width     = 684
1091:             .Height    = 20
1092:             .FontName  = "Tahoma"
1093:             .FontSize  = 8
1094:             .ReadOnly  = .T.

*-- Linhas 1100 a 1109:
1100:         loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
1101:         WITH loc_oPage.txt_4c_Arquivo
1102:             .Value     = ""
1103:             .Top       = 113
1104:             .Left      = 691
1105:             .Width     = 495
1106:             .Height    = 20
1107:             .FontName  = "Tahoma"
1108:             .FontSize  = 8
1109:             .ReadOnly  = .T.

*-- Linhas 1116 a 1125:
1116:         loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
1117:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1118:         WITH loc_oPage.grd_4c_Disponivel
1119:             .Top       = 134
1120:             .Left      = 8
1121:             .Width     = 684
1122:             .Height    = 344
1123:             .FontName  = "Tahoma"
1124:             .FontSize  = 8
1125:             .GridLines = 1

*-- Linhas 1153 a 1162:
1153:         loc_oPage.AddObject("grd_4c_ItemXml", "Grid")
1154:         loc_oPage.grd_4c_ItemXml.ColumnCount = 4
1155:         WITH loc_oPage.grd_4c_ItemXml
1156:             .Top       = 134
1157:             .Left      = 693
1158:             .Width     = 493
1159:             .Height    = 344
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:             .GridLines = 1

*-- Linhas 1178 a 1220:
1178:         ENDWITH
1179: 
1180:         *-- CommandButton btnExcluirSis (top=479, left=663, width=40, height=37)
1181:         loc_oPage.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
1182:         WITH loc_oPage.cmd_4c_BtnExcluirSis
1183:             .Caption         = ""
1184:             .Top             = 479
1185:             .Left            = 663
1186:             .Width           = 40
1187:             .Height          = 37
1188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1189:             .PicturePosition = 4
1190:             .Themes          = .T.
1191:             .ToolTipText     = "Remover produto da lista"
1192:             .Visible         = .T.
1193:         ENDWITH
1194: 
1195:         *-- CommandButton btnExcluirArq (top=479, left=1146, width=40, height=37)
1196:         loc_oPage.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
1197:         WITH loc_oPage.cmd_4c_BtnExcluirArq
1198:             .Caption         = ""
1199:             .Top             = 479
1200:             .Left            = 1146
1201:             .Width           = 40
1202:             .Height          = 37
1203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1204:             .PicturePosition = 4
1205:             .Themes          = .T.
1206:             .ToolTipText     = "Remover item XML da lista"
1207:             .Visible         = .T.
1208:         ENDWITH
1209: 
1210:         *-- Label "Movimentacao :" (Say3: top=483, left=40, width=78)
1211:         loc_oPage.AddObject("lbl_4c_Movimentacao", "Label")
1212:         WITH loc_oPage.lbl_4c_Movimentacao
1213:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1214:             .Top       = 483
1215:             .Left      = 40
1216:             .Width     = 90
1217:             .Height    = 15
1218:             .FontName  = "Tahoma"
1219:             .FontSize  = 8
1220:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1227 a 1236:
1227:         loc_oPage.AddObject("txt_4c_Emps", "TextBox")
1228:         WITH loc_oPage.txt_4c_Emps
1229:             .Value     = ""
1230:             .Top       = 480
1231:             .Left      = 122
1232:             .Width     = 65
1233:             .Height    = 21
1234:             .FontName  = "Tahoma"
1235:             .FontSize  = 8
1236:             .ReadOnly  = .T.

*-- Linhas 1242 a 1251:
1242:         loc_oPage.AddObject("txt_4c_Dopes", "TextBox")
1243:         WITH loc_oPage.txt_4c_Dopes
1244:             .Value     = ""
1245:             .Top       = 480
1246:             .Left      = 188
1247:             .Width     = 205
1248:             .Height    = 21
1249:             .FontName  = "Tahoma"
1250:             .FontSize  = 8
1251:             .ReadOnly  = .T.

*-- Linhas 1257 a 1266:
1257:         loc_oPage.AddObject("txt_4c_Numes", "TextBox")
1258:         WITH loc_oPage.txt_4c_Numes
1259:             .Value     = ""
1260:             .Top       = 480
1261:             .Left      = 393
1262:             .Width     = 65
1263:             .Height    = 21
1264:             .FontName  = "Tahoma"
1265:             .FontSize  = 8
1266:             .ReadOnly  = .T.

*-- Linhas 1272 a 1296:
1272:         loc_oPage.AddObject("txt_4c_CIdChaves", "TextBox")
1273:         WITH loc_oPage.txt_4c_CIdChaves
1274:             .Value     = ""
1275:             .Top       = 480
1276:             .Left      = 459
1277:             .Width     = 173
1278:             .Height    = 21
1279:             .FontName  = "Tahoma"
1280:             .FontSize  = 8
1281:             .ReadOnly  = .T.
1282:             .BackColor = RGB(240, 240, 240)
1283:             .Visible   = .T.
1284:         ENDWITH
1285: 
1286:         *-- Label "Ref. Fornecedor :" (lbl_ref_fornecedor: top=505, left=30, width=88)
1287:         loc_oPage.AddObject("lbl_4c_RefFornecedor", "Label")
1288:         WITH loc_oPage.lbl_4c_RefFornecedor
1289:             .Caption   = "Ref. Fornecedor :"
1290:             .Top       = 505
1291:             .Left      = 30
1292:             .Width     = 90
1293:             .Height    = 15
1294:             .FontName  = "Tahoma"
1295:             .FontSize  = 8
1296:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1303 a 1327:
1303:         loc_oPage.AddObject("txt_4c_RefFornecedor", "TextBox")
1304:         WITH loc_oPage.txt_4c_RefFornecedor
1305:             .Value     = ""
1306:             .Top       = 502
1307:             .Left      = 122
1308:             .Width     = 190
1309:             .Height    = 21
1310:             .FontName  = "Tahoma"
1311:             .FontSize  = 8
1312:             .ReadOnly  = .T.
1313:             .BackColor = RGB(240, 240, 240)
1314:             .Visible   = .T.
1315:         ENDWITH
1316: 
1317:         *-- Label "Custo :" (Say5: top=527, left=81, width=37)
1318:         loc_oPage.AddObject("lbl_4c_Custo", "Label")
1319:         WITH loc_oPage.lbl_4c_Custo
1320:             .Caption   = "Custo :"
1321:             .Top       = 527
1322:             .Left      = 81
1323:             .Width     = 40
1324:             .Height    = 15
1325:             .FontName  = "Tahoma"
1326:             .FontSize  = 8
1327:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1334 a 1358:
1334:         loc_oPage.AddObject("txt_4c_PrecoMov", "TextBox")
1335:         WITH loc_oPage.txt_4c_PrecoMov
1336:             .Value     = 0
1337:             .Top       = 524
1338:             .Left      = 122
1339:             .Width     = 108
1340:             .Height    = 21
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8
1343:             .ReadOnly  = .T.
1344:             .BackColor = RGB(240, 240, 240)
1345:             .Visible   = .T.
1346:         ENDWITH
1347: 
1348:         *-- Label "Preco Venda :" (lbl_pr_venda: top=549, left=49, width=69)
1349:         loc_oPage.AddObject("lbl_4c_PrVenda", "Label")
1350:         WITH loc_oPage.lbl_4c_PrVenda
1351:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1352:             .Top       = 549
1353:             .Left      = 49
1354:             .Width     = 75
1355:             .Height    = 15
1356:             .FontName  = "Tahoma"
1357:             .FontSize  = 8
1358:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1365 a 1374:
1365:         loc_oPage.AddObject("txt_4c_PrVenda", "TextBox")
1366:         WITH loc_oPage.txt_4c_PrVenda
1367:             .Value     = 0
1368:             .Top       = 546
1369:             .Left      = 122
1370:             .Width     = 108
1371:             .Height    = 21
1372:             .FontName  = "Tahoma"
1373:             .FontSize  = 8
1374:             .ReadOnly  = .T.

*-- Linhas 1380 a 1404:
1380:         loc_oPage.AddObject("txt_4c_PrVendaMoeda", "TextBox")
1381:         WITH loc_oPage.txt_4c_PrVendaMoeda
1382:             .Value     = ""
1383:             .Top       = 546
1384:             .Left      = 231
1385:             .Width     = 31
1386:             .Height    = 21
1387:             .FontName  = "Tahoma"
1388:             .FontSize  = 8
1389:             .ReadOnly  = .T.
1390:             .BackColor = RGB(240, 240, 240)
1391:             .Visible   = .T.
1392:         ENDWITH
1393: 
1394:         *-- Label "Peso :" (Say1: top=550, left=348, width=32)
1395:         loc_oPage.AddObject("lbl_4c_Peso", "Label")
1396:         WITH loc_oPage.lbl_4c_Peso
1397:             .Caption   = "Peso :"
1398:             .Top       = 550
1399:             .Left      = 348
1400:             .Width     = 35
1401:             .Height    = 15
1402:             .FontName  = "Tahoma"
1403:             .FontSize  = 8
1404:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1411 a 1435:
1411:         loc_oPage.AddObject("txt_4c_PesoMedio", "TextBox")
1412:         WITH loc_oPage.txt_4c_PesoMedio
1413:             .Value     = 0
1414:             .Top       = 547
1415:             .Left      = 383
1416:             .Width     = 75
1417:             .Height    = 21
1418:             .FontName  = "Tahoma"
1419:             .FontSize  = 8
1420:             .ReadOnly  = .T.
1421:             .BackColor = RGB(240, 240, 240)
1422:             .Visible   = .T.
1423:         ENDWITH
1424: 
1425:         *-- Label "Preco Custo :" (Say2: top=571, left=51, width=67)
1426:         loc_oPage.AddObject("lbl_4c_PrecoCusto", "Label")
1427:         WITH loc_oPage.lbl_4c_PrecoCusto
1428:             .Caption   = "Pre" + CHR(231) + "o Custo :"
1429:             .Top       = 571
1430:             .Left      = 51
1431:             .Width     = 70
1432:             .Height    = 15
1433:             .FontName  = "Tahoma"
1434:             .FontSize  = 8
1435:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1442 a 1451:
1442:         loc_oPage.AddObject("txt_4c_Custofs", "TextBox")
1443:         WITH loc_oPage.txt_4c_Custofs
1444:             .Value     = 0
1445:             .Top       = 568
1446:             .Left      = 122
1447:             .Width     = 108
1448:             .Height    = 21
1449:             .FontName  = "Tahoma"
1450:             .FontSize  = 8
1451:             .ReadOnly  = .T.

*-- Linhas 1457 a 1479:
1457:         loc_oPage.AddObject("txt_4c_Moecusfs", "TextBox")
1458:         WITH loc_oPage.txt_4c_Moecusfs
1459:             .Value     = ""
1460:             .Top       = 568
1461:             .Left      = 231
1462:             .Width     = 31
1463:             .Height    = 21
1464:             .FontName  = "Tahoma"
1465:             .FontSize  = 8
1466:             .ReadOnly  = .T.
1467:             .BackColor = RGB(240, 240, 240)
1468:             .Visible   = .T.
1469:         ENDWITH
1470: 
1471:         *-- BINDEVENTs de Page2 (Itens)
1472:         BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
1473:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirSis, "Click",          THIS, "BtnExcluirSisClick")
1474:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirArq, "Click",          THIS, "BtnExcluirArqClick")
1475:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "KeyPress",     THIS, "ProdutoInicialLostFocus")
1476:         BINDEVENT(loc_oPage.img_4c_FigJpg,        "Click",          THIS, "ImgFigJpgClick")
1477:     ENDPROC
1478: 
1479:     *==========================================================================

*-- Linhas 2128 a 2141:
2128:                 loc_oGrd.RecordSource = "cursor_4c_Estoque"
2129: 
2130:                 *-- Headers APOS RecordSource (Problema 32)
2131:                 loc_oGrd.Column1.Header1.Caption = ""
2132:                 loc_oGrd.Column2.Header1.Caption = "Empresa"
2133:                 loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2134:                 loc_oGrd.Column4.Header1.Caption = "Numero"
2135:                 loc_oGrd.Column5.Header1.Caption = "Grupo"
2136:                 loc_oGrd.Column6.Header1.Caption = "Conta"
2137: 
2138:                 *-- ControlSource APOS RecordSource (Problema 48)
2139:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
2140:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
2141:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"

*-- Linhas 2454 a 2468:
2454:             loc_oGrd.RecordSource = "crMovimentos"
2455: 
2456:             *-- Problema 32: Headers APOS RecordSource
2457:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2458:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2459:             loc_oGrd.Column3.Header1.Caption = "Valor"
2460:             loc_oGrd.Column4.Header1.Caption = "Quantidade"
2461:             loc_oGrd.Column5.Header1.Caption = "Baixado"
2462:             loc_oGrd.Column6.Header1.Caption = "Reservado"
2463:             loc_oGrd.Column7.Header1.Caption = "Saldo"
2464: 
2465:             *-- Problema 48: ControlSource APOS RecordSource
2466:             loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
2467:             loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
2468:             loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"

*-- Linhas 2515 a 2526:
2515:             loc_oGrd.ColumnCount  = 4
2516:             loc_oGrd.RecordSource = "crDistribui"
2517: 
2518:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2519:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2520:             loc_oGrd.Column3.Header1.Caption = "Quantidade"
2521:             loc_oGrd.Column4.Header1.Caption = "Valor"
2522: 
2523:             loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
2524:             loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
2525:             loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
2526:             loc_oGrd.Column4.ControlSource = "crDistribui.Valor"

*-- Linhas 3022 a 3035:
3022:                         loc_oGrid.Column6.Width = 680
3023: 
3024:                         *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
3025:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
3026:                         loc_oGrid.Column2.Header1.Caption = "Data"
3027:                         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
3028:                         loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
3029:                         loc_oGrid.Column5.Header1.Caption = "Fornecedor"
3030:                         loc_oGrid.Column6.Header1.Caption = "Nome"
3031: 
3032:                         THIS.FormatarGridLista(loc_oGrid)
3033:                         loc_lResultado = .T.
3034:                     ELSE
3035:                         loc_lResultado = .F.

*-- Linhas 3381 a 3426:
3381:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
3382:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3383: 
3384:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar") = "O"
3385:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3386:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3387:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3388:         ENDIF
3389:     ENDPROC
3390: 
3391:     *--------------------------------------------------------------------------
3392:     * HabilitarCampos - Habilita ou desabilita campos de Page2 por modo
3393:     * par_lHabilitar: .T. = editar; .F. = somente leitura
3394:     *--------------------------------------------------------------------------
3395:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3396:         LOCAL loc_oPg2, loc_oPage
3397:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3398:         loc_oPage = loc_oPg2.pgf_4c_Abas.Page1
3399: 
3400:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3401:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3402:         ENDIF
3403: 
3404:         *-- Campos de pgf_4c_Abas.Page1 (Fases 5-6)
3405:         *-- Nota: cmd_4c_Consulta/Cadastros/Processar (icon-only) NAO desabilitar (icone some)
3406:         IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
3407:             loc_oPage.txt_4c_Grupo.Enabled        = par_lHabilitar
3408:             loc_oPage.txt_4c_Conta.Enabled        = par_lHabilitar
3409:             loc_oPage.txt_4c_Cpf.Enabled          = par_lHabilitar
3410:             loc_oPage.txt_4c_Moeda.Enabled        = par_lHabilitar
3411:             loc_oPage.opt_4c_Custo.Enabled        = par_lHabilitar
3412:         ENDIF
3413:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
3414:             loc_oPage.opt_4c_Fil.Enabled          = par_lHabilitar
3415:             loc_oPage.cmd_4c_BrowseArquivo.Enabled = par_lHabilitar
3416:         ENDIF
3417: 
3418:         *-- Habilitar botoes de excluir em Page2 (Itens)
3419:         LOCAL loc_oPage2
3420:         loc_oPage2 = loc_oPg2.pgf_4c_Abas.Page2
3421:         IF TYPE("loc_oPage2.cmd_4c_BtnExcluirSis") = "O"
3422:         ENDIF
3423:     ENDPROC
3424: 
3425:     *--------------------------------------------------------------------------
3426:     * FormParaBO - Transfere dados dos campos de Page2 para o Business Object

*-- Linhas 3543 a 3562:
3543:         loc_lEditar      = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3544: 
3545:         *-- Botoes CRUD na Page1
3546:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir") = "O"
3547:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
3548:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3549:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3550:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3551:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
3552:         ENDIF
3553: 
3554:         *-- Botoes de acao na Page2 (Confirmar so habilitado ao editar)
3555:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3556:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
3557:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
3558:         ENDIF
3559:     ENDPROC
3560: 
3561:     *--------------------------------------------------------------------------
3562:     * Destroy - Limpeza de recursos ao fechar o formulario


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*==============================================================================
* SigPrCtrBO.prg - Business Object: Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Chave: Codigos (identificador de sessao de processamento)
*
* Cada sessao (Codigos) agrupa multiplas linhas em SigPrCtr,
* uma por produto processado no XML. O padrao de gravacao e:
*   DELETE todas as linhas do Codigos + INSERT novas linhas.
*==============================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Identificacao da sessao de processamento (grupo de linhas)
    this_cCodigos   = ""    && C(10) - Chave da sessao (PK do grupo)

    *-- Chave individual de cada linha
    this_cPkChave   = ""    && C(15) - Chave unica por linha (fUniqueIds)

    *-- Produto
    this_cCpros     = ""    && C(15) - Codigo do produto
    this_cCodCors   = ""    && C(6)  - Codigo da cor
    this_cCodTams   = ""    && C(6)  - Codigo do tamanho

    *-- Movimento de origem
    this_cOriDopNums = ""   && C(30) - Numero(s) de DOP de origem
    this_cFkChaves   = ""   && C(15) - FK para SigMvItn.cidchaves

    *-- Quantidades
    this_nQtds   = 0        && N(12,2) - Quantidade total do XML
    this_nQtdOs  = 0        && N(12,2) - Quantidade disponivel/OS

    *-- Identificacao do fornecedor/conta
    this_cContas = ""       && C(10) - Codigo da conta (fornecedor)

    *-- Arquivo XML processado
    this_cArquivo = ""      && C(255) - Caminho do arquivo XML

    *-- Moeda e precificacao
    this_cMoedas  = ""      && C(10) - Codigo da moeda
    this_nPrecific = 0      && N(2,0) - Opcao de precificacao (1=Custo Total, 2=Composicao)

    *-- Auditoria de insercao
    this_dDatas  = {/ /}    && T - Data/hora de processamento (INSERT)
    this_cUsuars = ""       && C(6)  - Usuario que processou (INSERT)

    *-- Auditoria de alteracao
    this_dDtAlts  = {/ /}   && T - Data/hora da alteracao
    this_cUsuAlts = ""       && C(6)  - Usuario que alterou

    *-- Filtros de periodo para Buscar()
    this_dFiltroInicio = {}  && Data inicial do filtro
    this_dFiltroFim    = {}  && Data final do filtro

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCtr"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista sessoes agrupadas por periodo
    * par_cFiltro: filtro adicional de data (formato "ldDatai" e "ldDataf")
    * Retorna cursor_4c_Dados: Codigos, Datas, OriDopNums, Usuars, Contas, Rclis
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        LOCAL ldDatai, ldDataf
        loc_lSucesso = .F.

        TRY
            ldDatai = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroInicio), THIS.this_dFiltroInicio, DATE()))
            ldDataf = FormatarDataSQL(IIF(!EMPTY(THIS.this_dFiltroFim), THIS.this_dFiltroFim, DATE()))

            loc_cSQL = "SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas," + ;
                       " a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " FROM SigPrCtr a" + ;
                       " JOIN SigCdCli b ON a.Contas = b.Iclis" + ;
                       " WHERE a.Datas >= " + ldDatai + ;
                       " AND a.Datas < DATEADD(day, 1, " + ldDataf + ")"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis" + ;
                       " ORDER BY MAX(a.Datas) DESC"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar sessoes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarLinhasSessao - Carrega todas as linhas de uma sessao (para grid Page1)
    * Retorna cursor_4c_Linhas: todas as colunas de SigPrCtr para o Codigos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY a.Cpros"

            IF USED("cursor_4c_Linhas")
                USE IN cursor_4c_Linhas
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Linhas")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.BuscarLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega a primeira linha de uma sessao pelo Codigos
    * Usado para validacao e para preencher campos de cabecalho da sessao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 a.Codigos, a.PkChave, a.Cpros, a.CodCors, a.CodTams," + ;
                       " a.OriDopNums, a.Qtds, a.QtdOs, a.Contas, a.Arquivo," + ;
                       " a.Moedas, a.Precific, a.fkChaves," + ;
                       " a.Datas, a.Usuars, a.DtAlts, a.UsuAlts" + ;
                       " FROM SigPrCtr a" + ;
                       " WHERE a.Codigos = " + EscaparSQL(par_cCodigos)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigos    = TratarNulo(Codigos,    "C")
                THIS.this_cPkChave    = TratarNulo(PkChave,    "C")
                THIS.this_cCpros      = TratarNulo(Cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(CodCors,    "C")
                THIS.this_cCodTams    = TratarNulo(CodTams,    "C")
                THIS.this_cOriDopNums = TratarNulo(OriDopNums, "C")
                THIS.this_nQtds       = TratarNulo(Qtds,       "N")
                THIS.this_nQtdOs      = TratarNulo(QtdOs,      "N")
                THIS.this_cContas     = TratarNulo(Contas,     "C")
                THIS.this_cArquivo    = TratarNulo(Arquivo,    "C")
                THIS.this_cMoedas     = TratarNulo(Moedas,     "C")
                THIS.this_nPrecific   = TratarNulo(Precific,   "N")
                THIS.this_cFkChaves   = TratarNulo(fkChaves,   "C")
                THIS.this_dDatas      = TratarNulo(Datas,      "T")
                THIS.this_cUsuars     = TratarNulo(Usuars,     "C")
                THIS.this_dDtAlts     = TratarNulo(DtAlts,     "T")
                THIS.this_cUsuAlts    = TratarNulo(UsuAlts,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere UMA linha na tabela SigPrCtr (chamada em loop pela form)
    * PROTECTED - chamado por BusinessBase.Salvar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = PADR(ALLTRIM(SYS(2015)), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigPrCtr" + ;
                       " (Codigos, PkChave, Cpros, CodCors, CodTams," + ;
                       "  OriDopNums, Qtds, QtdOs, Contas, Arquivo," + ;
                       "  Moedas, Precific, fkChaves, Datas, Usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cPkChave)) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cCodCors) + ", " + ;
                       EscaparSQL(THIS.this_cCodTams) + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       EscaparSQL(THIS.this_cContas) + ", " + ;
                       EscaparSQL(THIS.this_cArquivo) + ", " + ;
                       EscaparSQL(THIS.this_cMoedas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecific) + ", " + ;
                       EscaparSQL(THIS.this_cFkChaves) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao inserir linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza campos de auditoria de uma linha existente
    * PROTECTED - Para o padrao de edicao: DELETE + re-INSERT via GravarSessao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCtr SET" + ;
                       " Qtds = " + FormatarNumeroSQL(THIS.this_nQtds) + "," + ;
                       " QtdOs = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Arquivo = " + EscaparSQL(THIS.this_cArquivo) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Precific = " + FormatarNumeroSQL(THIS.this_nPrecific) + "," + ;
                       " DtAlts = GETDATE()," + ;
                       " UsuAlts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE PkChave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove TODAS as linhas da sessao (PROTECTED)
    * Chamado por BusinessBase.Excluir()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult < 0
                MsgErro("Erro ao excluir sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhasSessao - Remove TODAS as linhas de uma sessao (PUBLIC)
    * Usado pela form no inicio do ciclo de gravacao (ALTERAR)
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhasSessao(par_cCodigos)
        LOCAL loc_cSQL, loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigos))
                MsgErro("Codigos nao informado para exclusao de linhas.", "Erro")
            ELSE
                loc_cSQL = "DELETE FROM SigPrCtr WHERE Codigos = " + EscaparSQL(par_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir linhas da sessao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.ExcluirLinhasSessao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarNovoCodigos - Gera um novo identificador numerico de sessao
    * Retorna string C(10) com numero sequencial unico para SigPrCtr
    *--------------------------------------------------------------------------
    PROCEDURE GerarNovoCodigos()
        LOCAL loc_cCodigos, loc_cSQL, loc_nResult, loc_nMaxCod
        loc_cCodigos = ""
        loc_nMaxCod  = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(CAST(LTRIM(RTRIM(Codigos)) AS BIGINT)), 0) + 1" + ;
                       " AS NovoCodigos FROM SigPrCtr"

            IF USED("cursor_4c_NovoCod")
                USE IN cursor_4c_NovoCod
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NovoCod")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_NovoCod") > 0
                SELECT cursor_4c_NovoCod
                loc_nMaxCod = cursor_4c_NovoCod.NovoCodigos
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigPrCtrBO.GerarNovoCodigos")
        ENDTRY

        IF USED("cursor_4c_NovoCod")
            USE IN cursor_4c_NovoCod
        ENDIF

        IF loc_nMaxCod > 0
            loc_cCodigos = ALLTRIM(STR(loc_nMaxCod, 10))
        ENDIF

        RETURN loc_cCodigos
    ENDPROC

ENDDEFINE

