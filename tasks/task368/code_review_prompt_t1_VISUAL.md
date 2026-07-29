# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 256: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 280: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 316: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 399: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCHM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1599 linhas total):

*-- Linhas 46 a 61:
46:                             "Erro Cr" + CHR(237) + "tico")
47:                 loc_lSucesso = .F.
48:             ELSE
49:                 THIS.Caption = "Cadastro de Configura" + CHR(231) + CHR(227) + ;
50:                                "o do Cheque - Matricial"
51: 
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.ConfigurarPaginaLista()
54:                 THIS.ConfigurarPaginaDados()
55: 
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
57:                     THIS.Caption
58: 
59:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
60:                     THIS.CarregarLista()
61:                 ENDIF

*-- Linhas 78 a 112:
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Configura o PageFrame principal
81:     * Legado: Pagina.Top=-29 (oculta abas), Width=1003, Height=629
82:     *--------------------------------------------------------------------------
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .Top       = -29
88:             .Left      = 0
89:             .Width     = 1003
90:             .Height    = 629
91:             .PageCount = 2
92:             .Tabs      = .F.
93:             .Visible   = .T.
94: 
95:             .Page1.Caption   = "Lista"
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page1.BackColor = RGB(255, 255, 255)
98: 
99:             .Page2.Caption   = "Dados"
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.BackColor = RGB(255, 255, 255)
102:         ENDWITH
103:     ENDPROC
104: 
105:     *--------------------------------------------------------------------------
106:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e Botoes CRUD
107:     * Compensacao PageFrame.Top=-29: Top_original + 29
108:     * Grade legado: top=119+29=148, left=32, width=940, height=470
109:     * cnt_4c_Botoes canonico: Left=542, Top=29
110:     * cnt_4c_Saida canonico: Left=917 (Rule #10)
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()

*-- Linhas 118 a 155:
118:         *-- Container de cabecalho (cntSombra: Top=2+29=31)
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackStyle   = 0
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 16
134:             .Left      = 11
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .AutoSize  = .F.
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .BackStyle = 0
142:             .ForeColor = RGB(0, 0, 0)
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46
153:             .AutoSize  = .F.
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16

*-- Linhas 162 a 190:
162:         *-- Container de botoes CRUD (canonico Left=542, Top=29)
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPagina.cnt_4c_Botoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle   = 0
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         *-- Botao Incluir (Left=5)
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
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontSize        = 8
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .Themes          = .F.

*-- Linhas 196 a 214:
196:         ENDWITH
197: 
198:         *-- Botao Visualizar (Left=80)
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .FontName        = "Comic Sans MS"
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .FontSize        = 8
212:             .ForeColor       = RGB(90, 90, 90)
213:             .BackColor       = RGB(255, 255, 255)
214:             .Themes          = .F.

*-- Linhas 220 a 238:
220:         ENDWITH
221: 
222:         *-- Botao Alterar (Left=155)
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .FontSize        = 8
236:             .ForeColor       = RGB(90, 90, 90)
237:             .BackColor       = RGB(255, 255, 255)
238:             .Themes          = .F.

*-- Linhas 244 a 262:
244:         ENDWITH
245: 
246:         *-- Botao Excluir (Left=230)
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
249:             .Caption         = "Excluir"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
251:             .PicturePosition = 13
252:             .Top             = 5
253:             .Left            = 230
254:             .Width           = 75
255:             .Height          = 75
256:             .FontName        = "Comic Sans MS"
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .FontSize        = 8
260:             .ForeColor       = RGB(90, 90, 90)
261:             .BackColor       = RGB(255, 255, 255)
262:             .Themes          = .F.

*-- Linhas 268 a 286:
268:         ENDWITH
269: 
270:         *-- Botao Buscar (Left=305)
271:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .FontName        = "Comic Sans MS"
281:             .FontBold        = .T.
282:             .FontItalic      = .T.
283:             .FontSize        = 8
284:             .ForeColor       = RGB(90, 90, 90)
285:             .BackColor       = RGB(255, 255, 255)
286:             .Themes          = .F.

*-- Linhas 294 a 322:
294:         *-- Container de saida/encerrar (canonico Left=917, Width=90, Rule #10)
295:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
296:         WITH loc_oPagina.cnt_4c_Saida
297:             .Top         = 29
298:             .Left        = 917
299:             .Width       = 90
300:             .Height      = 85
301:             .BackStyle   = 0
302:             .BorderWidth = 0
303:             .Visible     = .T.
304:         ENDWITH
305: 
306:         *-- Botao Encerrar (canonico Width=75, Height=75, Caption="Encerrar")
307:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
308:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
309:             .Caption         = "Encerrar"
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
311:             .PicturePosition = 13
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .FontName        = "Comic Sans MS"
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontSize        = 8
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .F.

*-- Linhas 331 a 340:
331:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
332:         loc_oGrid = loc_oPagina.grd_4c_Lista
333: 
334:         loc_oGrid.Top                = 148
335:         loc_oGrid.Left               = 32
336:         loc_oGrid.Width              = 940
337:         loc_oGrid.Height             = 470
338:         loc_oGrid.FontName           = "Verdana"
339:         loc_oGrid.FontSize           = 8
340:         loc_oGrid.ForeColor          = RGB(90, 90, 90)

*-- Linhas 352 a 452:
352:         loc_oGrid.Visible            = .T.
353: 
354:         *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - BINDEVENT exige PUBLIC)
355:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
358:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
361: 
362:         THIS.TornarControlesVisiveis(loc_oPagina)
363:     ENDPROC
364: 
365:     *--------------------------------------------------------------------------
366:     * ConfigurarPaginaDados - Configura Page2 (Dados)
367:     * Compensacao PageFrame.Top=-29: Top_original + 29
368:     * Legado: Grupo_Salva.Left=627, Top=6+29=35, Width=172, Height=85
369:     * Fase 5/8: Botoes Confirmar/Cancelar + 1a metade dos campos
370:     *--------------------------------------------------------------------------
371:     PROTECTED PROCEDURE ConfigurarPaginaDados()
372:         LOCAL loc_oPagina
373:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
374: 
375:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
376: 
377:         *-- Container botoes Salvar/Cancelar (Grupo_Salva.Left=627, Top=6+29=35)
378:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
379:         WITH loc_oPagina.cnt_4c_BotoesDados
380:             .Top         = 35
381:             .Left        = 627
382:             .Width       = 172
383:             .Height      = 85
384:             .BackStyle   = 0
385:             .BorderWidth = 0
386:             .Visible     = .T.
387:         ENDWITH
388: 
389:         *-- Botao Confirmar (Salva.Left=11, Top=5)
390:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 11
397:             .Width           = 75
398:             .Height          = 75
399:             .FontName        = "Comic Sans MS"
400:             .FontBold        = .T.
401:             .FontItalic      = .T.
402:             .FontSize        = 8
403:             .ForeColor       = RGB(90, 90, 90)
404:             .BackColor       = RGB(255, 255, 255)
405:             .Themes          = .F.
406:             .SpecialEffect   = 0
407:             .MousePointer    = 15
408:             .WordWrap        = .T.
409:             .AutoSize        = .F.
410:             .Visible         = .T.
411:         ENDWITH
412: 
413:         *-- Botao Cancelar (Cancelar.Left=88, Top=5)
414:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
415:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
416:             .Caption         = "Encerrar"
417:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
418:             .PicturePosition = 13
419:             .Top             = 5
420:             .Left            = 88
421:             .Width           = 75
422:             .Height          = 75
423:             .FontName        = "Comic Sans MS"
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .FontSize        = 8
427:             .ForeColor       = RGB(90, 90, 90)
428:             .BackColor       = RGB(255, 255, 255)
429:             .Themes          = .F.
430:             .SpecialEffect   = 0
431:             .MousePointer    = 15
432:             .WordWrap        = .T.
433:             .AutoSize        = .F.
434:             .Visible         = .T.
435:         ENDWITH
436: 
437:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
438:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
439: 
440:         *----------------------------------------------------------------------
441:         *  BANCO (Get_Banco: top=66+29=95, left=251, width=45)
442:         *----------------------------------------------------------------------
443:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
444:         WITH loc_oPagina.lbl_4c_Label2
445:             .Caption   = "Banco :"
446:             .Top       = 99
447:             .Left      = 204
448:             .Width     = 42
449:             .Height    = 15
450:             .AutoSize  = .T.
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8

*-- Linhas 459 a 468:
459:         loc_oPagina.AddObject("txt_4c_Banco", "TextBox")
460:         WITH loc_oPagina.txt_4c_Banco
461:             .Value        = ""
462:             .Top          = 95
463:             .Left         = 251
464:             .Width        = 45
465:             .Height       = 23
466:             .FontName     = "Tahoma"
467:             .FontSize     = 8
468:             .MaxLength    = 10

*-- Linhas 475 a 503:
475:         *  CABECALHOS DAS COLUNAS (Label3 Linha / Label4 Coluna)
476:         *  top=116+29=145 / top=115+29=144
477:         *----------------------------------------------------------------------
478:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
479:         WITH loc_oPagina.lbl_4c_Label3
480:             .Caption   = "Linha"
481:             .Top       = 145
482:             .Left      = 254
483:             .Width     = 32
484:             .Height    = 15
485:             .AutoSize  = .T.
486:             .FontName  = "Tahoma"
487:             .FontSize  = 8
488:             .FontBold  = .T.
489:             .BackStyle = 0
490:             .ForeColor = RGB(90, 90, 90)
491:             .Visible   = .T.
492:         ENDWITH
493: 
494:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
495:         WITH loc_oPagina.lbl_4c_Label4
496:             .Caption   = "Coluna"
497:             .Top       = 144
498:             .Left      = 336
499:             .Width     = 40
500:             .Height    = 15
501:             .AutoSize  = .T.
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8

*-- Linhas 510 a 522:
510:         *----------------------------------------------------------------------
511:         *  VALOR (Label1: top=137+29=166; fwget1/2: top=133+29=162)
512:         *----------------------------------------------------------------------
513:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
514:         WITH loc_oPagina.lbl_4c_Label1
515:             .Caption   = "Valor :"
516:             .Top       = 166
517:             .Left      = 213
518:             .Width     = 33
519:             .Height    = 15
520:             .AutoSize  = .T.
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8

*-- Linhas 529 a 569:
529:         loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
530:         WITH loc_oPagina.txt_4c_Fwget1
531:             .Value     = 0
532:             .Top       = 162
533:             .Left      = 250
534:             .Width     = 51
535:             .Height    = 23
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .BackColor = RGB(255, 255, 255)
539:             .ForeColor = RGB(90, 90, 90)
540:             .Visible   = .T.
541:         ENDWITH
542: 
543:         loc_oPagina.AddObject("txt_4c_Fwget2", "TextBox")
544:         WITH loc_oPagina.txt_4c_Fwget2
545:             .Value     = 0
546:             .Top       = 162
547:             .Left      = 335
548:             .Width     = 51
549:             .Height    = 23
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .BackColor = RGB(255, 255, 255)
553:             .ForeColor = RGB(90, 90, 90)
554:             .Visible   = .T.
555:         ENDWITH
556: 
557:         *----------------------------------------------------------------------
558:         *  VALOR EXTENSO 1 (Label5: top=163+29=192; fwget3/4: top=159+29=188)
559:         *----------------------------------------------------------------------
560:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
561:         WITH loc_oPagina.lbl_4c_Label5
562:             .Caption   = "Valor Extenso 1 :"
563:             .Top       = 192
564:             .Left      = 162
565:             .Width     = 84
566:             .Height    = 15
567:             .AutoSize  = .T.
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8

*-- Linhas 576 a 616:
576:         loc_oPagina.AddObject("txt_4c_Fwget3", "TextBox")
577:         WITH loc_oPagina.txt_4c_Fwget3
578:             .Value     = 0
579:             .Top       = 188
580:             .Left      = 250
581:             .Width     = 51
582:             .Height    = 23
583:             .FontName  = "Tahoma"
584:             .FontSize  = 8
585:             .BackColor = RGB(255, 255, 255)
586:             .ForeColor = RGB(90, 90, 90)
587:             .Visible   = .T.
588:         ENDWITH
589: 
590:         loc_oPagina.AddObject("txt_4c_Fwget4", "TextBox")
591:         WITH loc_oPagina.txt_4c_Fwget4
592:             .Value     = 0
593:             .Top       = 188
594:             .Left      = 335
595:             .Width     = 51
596:             .Height    = 23
597:             .FontName  = "Tahoma"
598:             .FontSize  = 8
599:             .BackColor = RGB(255, 255, 255)
600:             .ForeColor = RGB(90, 90, 90)
601:             .Visible   = .T.
602:         ENDWITH
603: 
604:         *----------------------------------------------------------------------
605:         *  VALOR EXTENSO 2 (Label6: top=189+29=218; fwget5/6: top=185+29=214)
606:         *----------------------------------------------------------------------
607:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
608:         WITH loc_oPagina.lbl_4c_Label6
609:             .Caption   = "Valor Extenso 2 :"
610:             .Top       = 218
611:             .Left      = 162
612:             .Width     = 84
613:             .Height    = 15
614:             .AutoSize  = .T.
615:             .FontName  = "Tahoma"
616:             .FontSize  = 8

*-- Linhas 623 a 663:
623:         loc_oPagina.AddObject("txt_4c_Fwget5", "TextBox")
624:         WITH loc_oPagina.txt_4c_Fwget5
625:             .Value     = 0
626:             .Top       = 214
627:             .Left      = 250
628:             .Width     = 51
629:             .Height    = 23
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .BackColor = RGB(255, 255, 255)
633:             .ForeColor = RGB(90, 90, 90)
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         loc_oPagina.AddObject("txt_4c_Fwget6", "TextBox")
638:         WITH loc_oPagina.txt_4c_Fwget6
639:             .Value     = 0
640:             .Top       = 214
641:             .Left      = 335
642:             .Width     = 51
643:             .Height    = 23
644:             .FontName  = "Tahoma"
645:             .FontSize  = 8
646:             .BackColor = RGB(255, 255, 255)
647:             .ForeColor = RGB(90, 90, 90)
648:             .Visible   = .T.
649:         ENDWITH
650: 
651:         *----------------------------------------------------------------------
652:         *  FAVORECIDO (Label7: top=215+29=244; fwget7/8: top=211+29=240)
653:         *----------------------------------------------------------------------
654:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
655:         WITH loc_oPagina.lbl_4c_Label7
656:             .Caption   = "Favorecido :"
657:             .Top       = 244
658:             .Left      = 184
659:             .Width     = 62
660:             .Height    = 15
661:             .AutoSize  = .T.
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8

*-- Linhas 670 a 710:
670:         loc_oPagina.AddObject("txt_4c_Fwget7", "TextBox")
671:         WITH loc_oPagina.txt_4c_Fwget7
672:             .Value     = 0
673:             .Top       = 240
674:             .Left      = 250
675:             .Width     = 51
676:             .Height    = 23
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8
679:             .BackColor = RGB(255, 255, 255)
680:             .ForeColor = RGB(90, 90, 90)
681:             .Visible   = .T.
682:         ENDWITH
683: 
684:         loc_oPagina.AddObject("txt_4c_Fwget8", "TextBox")
685:         WITH loc_oPagina.txt_4c_Fwget8
686:             .Value     = 0
687:             .Top       = 240
688:             .Left      = 335
689:             .Width     = 51
690:             .Height    = 23
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .BackColor = RGB(255, 255, 255)
694:             .ForeColor = RGB(90, 90, 90)
695:             .Visible   = .T.
696:         ENDWITH
697: 
698:         *----------------------------------------------------------------------
699:         *  LOCALIDADE (Label8: top=241+29=270; fwget9/10: top=236+29=265)
700:         *----------------------------------------------------------------------
701:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
702:         WITH loc_oPagina.lbl_4c_Label8
703:             .Caption   = "Localidade :"
704:             .Top       = 270
705:             .Left      = 187
706:             .Width     = 59
707:             .Height    = 15
708:             .AutoSize  = .T.
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8

*-- Linhas 717 a 757:
717:         loc_oPagina.AddObject("txt_4c_Fwget9", "TextBox")
718:         WITH loc_oPagina.txt_4c_Fwget9
719:             .Value     = 0
720:             .Top       = 265
721:             .Left      = 250
722:             .Width     = 51
723:             .Height    = 23
724:             .FontName  = "Tahoma"
725:             .FontSize  = 8
726:             .BackColor = RGB(255, 255, 255)
727:             .ForeColor = RGB(90, 90, 90)
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         loc_oPagina.AddObject("txt_4c_Fwget10", "TextBox")
732:         WITH loc_oPagina.txt_4c_Fwget10
733:             .Value     = 0
734:             .Top       = 265
735:             .Left      = 335
736:             .Width     = 51
737:             .Height    = 23
738:             .FontName  = "Tahoma"
739:             .FontSize  = 8
740:             .BackColor = RGB(255, 255, 255)
741:             .ForeColor = RGB(90, 90, 90)
742:             .Visible   = .T.
743:         ENDWITH
744: 
745:         *----------------------------------------------------------------------
746:         *  DIA (Label9: top=266+29=295; fwget11/12: top=261+29=290)
747:         *----------------------------------------------------------------------
748:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
749:         WITH loc_oPagina.lbl_4c_Label9
750:             .Caption   = "Dia :"
751:             .Top       = 295
752:             .Left      = 222
753:             .Width     = 24
754:             .Height    = 15
755:             .AutoSize  = .T.
756:             .FontName  = "Tahoma"
757:             .FontSize  = 8

*-- Linhas 764 a 804:
764:         loc_oPagina.AddObject("txt_4c_Fwget11", "TextBox")
765:         WITH loc_oPagina.txt_4c_Fwget11
766:             .Value     = 0
767:             .Top       = 290
768:             .Left      = 250
769:             .Width     = 51
770:             .Height    = 23
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .BackColor = RGB(255, 255, 255)
774:             .ForeColor = RGB(90, 90, 90)
775:             .Visible   = .T.
776:         ENDWITH
777: 
778:         loc_oPagina.AddObject("txt_4c_Fwget12", "TextBox")
779:         WITH loc_oPagina.txt_4c_Fwget12
780:             .Value     = 0
781:             .Top       = 290
782:             .Left      = 335
783:             .Width     = 51
784:             .Height    = 23
785:             .FontName  = "Tahoma"
786:             .FontSize  = 8
787:             .BackColor = RGB(255, 255, 255)
788:             .ForeColor = RGB(90, 90, 90)
789:             .Visible   = .T.
790:         ENDWITH
791: 
792:         *----------------------------------------------------------------------
793:         *  MES (Label10: top=291+29=320; fwget13/14: top=286+29=315)
794:         *----------------------------------------------------------------------
795:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
796:         WITH loc_oPagina.lbl_4c_Label10
797:             .Caption   = "Mes :"
798:             .Top       = 320
799:             .Left      = 218
800:             .Width     = 28
801:             .Height    = 15
802:             .AutoSize  = .T.
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8

*-- Linhas 811 a 851:
811:         loc_oPagina.AddObject("txt_4c_Fwget13", "TextBox")
812:         WITH loc_oPagina.txt_4c_Fwget13
813:             .Value     = 0
814:             .Top       = 315
815:             .Left      = 250
816:             .Width     = 51
817:             .Height    = 23
818:             .FontName  = "Tahoma"
819:             .FontSize  = 8
820:             .BackColor = RGB(255, 255, 255)
821:             .ForeColor = RGB(90, 90, 90)
822:             .Visible   = .T.
823:         ENDWITH
824: 
825:         loc_oPagina.AddObject("txt_4c_Fwget14", "TextBox")
826:         WITH loc_oPagina.txt_4c_Fwget14
827:             .Value     = 0
828:             .Top       = 315
829:             .Left      = 335
830:             .Width     = 51
831:             .Height    = 23
832:             .FontName  = "Tahoma"
833:             .FontSize  = 8
834:             .BackColor = RGB(255, 255, 255)
835:             .ForeColor = RGB(90, 90, 90)
836:             .Visible   = .T.
837:         ENDWITH
838: 
839:         *----------------------------------------------------------------------
840:         *  ANO (Label11: top=316+29=345; fwget15/16: top=311+29=340)
841:         *----------------------------------------------------------------------
842:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
843:         WITH loc_oPagina.lbl_4c_Label11
844:             .Caption   = "Ano :"
845:             .Top       = 345
846:             .Left      = 218
847:             .Width     = 28
848:             .Height    = 15
849:             .AutoSize  = .T.
850:             .FontName  = "Tahoma"
851:             .FontSize  = 8

*-- Linhas 858 a 898:
858:         loc_oPagina.AddObject("txt_4c_Fwget15", "TextBox")
859:         WITH loc_oPagina.txt_4c_Fwget15
860:             .Value     = 0
861:             .Top       = 340
862:             .Left      = 250
863:             .Width     = 51
864:             .Height    = 23
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:             .BackColor = RGB(255, 255, 255)
868:             .ForeColor = RGB(90, 90, 90)
869:             .Visible   = .T.
870:         ENDWITH
871: 
872:         loc_oPagina.AddObject("txt_4c_Fwget16", "TextBox")
873:         WITH loc_oPagina.txt_4c_Fwget16
874:             .Value     = 0
875:             .Top       = 340
876:             .Left      = 335
877:             .Width     = 51
878:             .Height    = 23
879:             .FontName  = "Tahoma"
880:             .FontSize  = 8
881:             .BackColor = RGB(255, 255, 255)
882:             .ForeColor = RGB(90, 90, 90)
883:             .Visible   = .T.
884:         ENDWITH
885: 
886:         *----------------------------------------------------------------------
887:         *  LOCAL (Label12: top=340+29=369; fwget17: top=337+29=366)
888:         *----------------------------------------------------------------------
889:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
890:         WITH loc_oPagina.lbl_4c_Label12
891:             .Caption   = "Local :"
892:             .Top       = 369
893:             .Left      = 213
894:             .Width     = 33
895:             .Height    = 15
896:             .AutoSize  = .T.
897:             .FontName  = "Tahoma"
898:             .FontSize  = 8

*-- Linhas 905 a 914:
905:         loc_oPagina.AddObject("txt_4c_Fwget17", "TextBox")
906:         WITH loc_oPagina.txt_4c_Fwget17
907:             .Value     = ""
908:             .Top       = 366
909:             .Left      = 250
910:             .Width     = 160
911:             .Height    = 23
912:             .MaxLength = 20
913:             .FontName  = "Tahoma"
914:             .FontSize  = 8

*-- Linhas 921 a 933:
921:         *  TAMANHO FOLHA (Label13: top=364+29=393; fwget18: top=362+29=391)
922:         *  Legado: fwget18.Valid -> GetPaperSize() quando vazio (ValidarTamanhoFolha)
923:         *----------------------------------------------------------------------
924:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
925:         WITH loc_oPagina.lbl_4c_Label13
926:             .Caption   = "Tamanho Folha :"
927:             .Top       = 393
928:             .Left      = 164
929:             .Width     = 82
930:             .Height    = 15
931:             .AutoSize  = .T.
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8

*-- Linhas 940 a 949:
940:         loc_oPagina.AddObject("txt_4c_Fwget18", "TextBox")
941:         WITH loc_oPagina.txt_4c_Fwget18
942:             .Value     = ""
943:             .Top       = 391
944:             .Left      = 250
945:             .Width     = 244
946:             .Height    = 23
947:             .MaxLength = 50
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8

*-- Linhas 958 a 970:
958:         *  NOME IMPRESSORA (Label14: top=392+29=421; fwget19: top=387+29=416)
959:         *  Legado: fwget19.Valid -> GetPrinter() quando vazio (ValidarNomeImpressora)
960:         *----------------------------------------------------------------------
961:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
962:         WITH loc_oPagina.lbl_4c_Label14
963:             .Caption   = "Nome Impressora :"
964:             .Top       = 421
965:             .Left      = 153
966:             .Width     = 93
967:             .Height    = 15
968:             .AutoSize  = .T.
969:             .FontName  = "Tahoma"
970:             .FontSize  = 8

*-- Linhas 977 a 986:
977:         loc_oPagina.AddObject("txt_4c_Fwget19", "TextBox")
978:         WITH loc_oPagina.txt_4c_Fwget19
979:             .Value     = ""
980:             .Top       = 416
981:             .Left      = 250
982:             .Width     = 319
983:             .Height    = 23
984:             .MaxLength = 40
985:             .FontName  = "Tahoma"
986:             .FontSize  = 8

*-- Linhas 1019 a 1042:
1019:                     WITH loc_oGrid
1020:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1021:                         .Column1.Width           = 80
1022:                         .Column1.Header1.Caption = "Banco"
1023:                         .Column1.ReadOnly        = .T.
1024: 
1025:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1026:                         .Column2.Width           = 160
1027:                         .Column2.Header1.Caption = "Local"
1028:                         .Column2.ReadOnly        = .T.
1029: 
1030:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1031:                         .Column3.Width           = 200
1032:                         .Column3.Header1.Caption = "Tamanho Folha"
1033:                         .Column3.ReadOnly        = .T.
1034: 
1035:                         .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
1036:                         .Column4.Width           = 300
1037:                         .Column4.Header1.Caption = "Nome Impressora"
1038:                         .Column4.ReadOnly        = .T.
1039:                     ENDWITH
1040: 
1041:                     THIS.FormatarGridLista(loc_oGrid)
1042:                     loc_lResultado = .T.

*-- Linhas 1157 a 1165:
1157:             THIS.AlternarPagina(2)
1158: 
1159:             TRY
1160:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Cancelar.SetFocus
1161:             CATCH TO loException
1162:                 MsgErro("Erro ao focar Cancelar: " + loException.Message, "Erro")
1163:             ENDTRY
1164:         ELSE
1165:             MsgAviso("Erro ao carregar o registro selecionado.", "Erro")

*-- Linhas 1254 a 1268:
1254:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1255:                     WITH loc_oGrid
1256:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1257:                         .Column1.Header1.Caption = "Banco"
1258:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1259:                         .Column2.Header1.Caption = "Local"
1260:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1261:                         .Column3.Header1.Caption = "Tamanho Folha"
1262:                         .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
1263:                         .Column4.Header1.Caption = "Nome Impressora"
1264:                     ENDWITH
1265:                 ENDIF
1266:             ENDIF
1267: 
1268:             loc_oBusca.Release()

*-- Linhas 1503 a 1522:
1503: 
1504:             DO CASE
1505:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1506:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1507:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .T.
1508:                 ENDIF
1509:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1510:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1511:                 ENDIF
1512:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1513:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1514:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .F.
1515:                 ENDIF
1516:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1517:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1518:                 ENDIF
1519:             ENDCASE
1520:         CATCH TO loException
1521:             MsgErro("Erro em AjustarBotoesPorModo: " + loException.Message, "Erro")
1522:         ENDTRY


### BO (C:\4c\projeto\app\classes\CHMBO.prg):
*==============================================================================
* CHMBO.prg - Business Object: Configura??o do Cheque Matricial
* Tabela: SigCqMat
* PK: banco (C3)
* Gerado: 2026-07-28 - Fase 1/8
*==============================================================================
DEFINE CLASS CHMBO AS BusinessBase

    *-- Chave prim?ria
    this_cBanco     = ""   && banco C(3)

    *-- Posi??es de impress?o - Valor
    this_nLvlr      = 0    && lvlr  N - Linha  Valor
    this_nCvlr      = 0    && cvlr  N - Coluna Valor

    *-- Posi??es de impress?o - Valor Extenso 1
    this_nLvext1    = 0    && lvext1 N - Linha  Valor Extenso 1
    this_nCvext1    = 0    && cvext1 N - Coluna Valor Extenso 1

    *-- Posi??es de impress?o - Valor Extenso 2
    this_nLvext2    = 0    && lvext2 N - Linha  Valor Extenso 2
    this_nCvext2    = 0    && cvext2 N - Coluna Valor Extenso 2

    *-- Posi??es de impress?o - Favorecido
    this_nLfavo     = 0    && lfavo N - Linha  Favorecido
    this_nCfavo     = 0    && cfavo N - Coluna Favorecido

    *-- Posi??es de impress?o - Localidade
    this_nLlocal    = 0    && llocal N - Linha  Localidade
    this_nClocal    = 0    && clocal N - Coluna Localidade

    *-- Posi??es de impress?o - Dia
    this_nLdia      = 0    && ldia N - Linha  Dia
    this_nCdia      = 0    && cdia N - Coluna Dia

    *-- Posi??es de impress?o - M?s
    this_nLmes      = 0    && lmes N - Linha  M?s
    this_nCmes      = 0    && cmes N - Coluna M?s

    *-- Posi??es de impress?o - Ano
    this_nLano      = 0    && lano N - Linha  Ano
    this_nCano      = 0    && cano N - Coluna Ano

    *-- Campos de configura??o da impressora
    this_cLocal     = ""   && local      C(20) - Local de emiss?o
    this_cTamanho   = ""   && ctamanho   C(50) - Tamanho da folha
    this_cNomImpre  = ""   && cNomImpre  C(40) - Nome da impressora

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SigCqMat"
        THIS.this_cCampoChave  = "banco"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cBanco
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " WHERE banco LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY banco"
            ELSE
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " ORDER BY banco"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cBanco)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT banco, lvlr, cvlr, lvext1, cvext1," + ;
                       " lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                       " ldia, cdia, lmes, cmes, lano, cano," + ;
                       " [local], ctamanho, cnomimpre" + ;
                       " FROM SigCqMat" + ;
                       " WHERE banco = " + EscaparSQL(par_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBanco    = TratarNulo(banco,    "C")
            THIS.this_nLvlr     = TratarNulo(lvlr,     "N")
            THIS.this_nCvlr     = TratarNulo(cvlr,     "N")
            THIS.this_nLvext1   = TratarNulo(lvext1,   "N")
            THIS.this_nCvext1   = TratarNulo(cvext1,   "N")
            THIS.this_nLvext2   = TratarNulo(lvext2,   "N")
            THIS.this_nCvext2   = TratarNulo(cvext2,   "N")
            THIS.this_nLfavo    = TratarNulo(lfavo,    "N")
            THIS.this_nCfavo    = TratarNulo(cfavo,    "N")
            THIS.this_nLlocal   = TratarNulo(llocal,   "N")
            THIS.this_nClocal   = TratarNulo(clocal,   "N")
            THIS.this_nLdia     = TratarNulo(ldia,     "N")
            THIS.this_nCdia     = TratarNulo(cdia,     "N")
            THIS.this_nLmes     = TratarNulo(lmes,     "N")
            THIS.this_nCmes     = TratarNulo(cmes,     "N")
            THIS.this_nLano     = TratarNulo(lano,     "N")
            THIS.this_nCano     = TratarNulo(cano,     "N")
            THIS.this_cLocal    = TratarNulo(EVALUATE(par_cAliasCursor + ".local"), "C")
            THIS.this_cTamanho  = TratarNulo(ctamanho, "C")
            THIS.this_cNomImpre = TratarNulo(cnomimpre,"C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_cChkSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChkSQL = "SELECT COUNT(*) AS total FROM SigCqMat" + ;
                          " WHERE banco = " + EscaparSQL(THIS.this_cBanco)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkDup")

            IF cursor_4c_ChkDup.total > 0
                MsgAviso("Existe esse Banco J" + CHR(225) + " Cadastrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_ChkDup
            ELSE
                USE IN cursor_4c_ChkDup
                loc_cSQL = "INSERT INTO SigCqMat" + ;
                           " (banco, lvlr, cvlr, lvext1, cvext1," + ;
                           "  lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                           "  ldia, cdia, lmes, cmes, lano, cano," + ;
                           "  [local], ctamanho, cnomimpre)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cBanco) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLlocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nClocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLano) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCano) + ", " + ;
                           EscaparSQL(THIS.this_cLocal) + ", " + ;
                           EscaparSQL(THIS.this_cTamanho) + ", " + ;
                           EscaparSQL(THIS.this_cNomImpre) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Insert")
                    TABLEREVERT(.T., "cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

                IF loc_nResultado > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqMat SET" + ;
                       " lvlr = "    + FormatarNumeroSQL(THIS.this_nLvlr)   + "," + ;
                       " cvlr = "    + FormatarNumeroSQL(THIS.this_nCvlr)   + "," + ;
                       " lvext1 = "  + FormatarNumeroSQL(THIS.this_nLvext1) + "," + ;
                       " cvext1 = "  + FormatarNumeroSQL(THIS.this_nCvext1) + "," + ;
                       " lvext2 = "  + FormatarNumeroSQL(THIS.this_nLvext2) + "," + ;
                       " cvext2 = "  + FormatarNumeroSQL(THIS.this_nCvext2) + "," + ;
                       " lfavo = "   + FormatarNumeroSQL(THIS.this_nLfavo)  + "," + ;
                       " cfavo = "   + FormatarNumeroSQL(THIS.this_nCfavo)  + "," + ;
                       " llocal = "  + FormatarNumeroSQL(THIS.this_nLlocal) + "," + ;
                       " clocal = "  + FormatarNumeroSQL(THIS.this_nClocal) + "," + ;
                       " ldia = "    + FormatarNumeroSQL(THIS.this_nLdia)   + "," + ;
                       " cdia = "    + FormatarNumeroSQL(THIS.this_nCdia)   + "," + ;
                       " lmes = "    + FormatarNumeroSQL(THIS.this_nLmes)   + "," + ;
                       " cmes = "    + FormatarNumeroSQL(THIS.this_nCmes)   + "," + ;
                       " lano = "    + FormatarNumeroSQL(THIS.this_nLano)   + "," + ;
                       " cano = "    + FormatarNumeroSQL(THIS.this_nCano)   + "," + ;
                       " [local] = " + EscaparSQL(THIS.this_cLocal)         + "," + ;
                       " ctamanho = "+ EscaparSQL(THIS.this_cTamanho)       + "," + ;
                       " cnomimpre ="+ EscaparSQL(THIS.this_cNomImpre) + ;
                       " WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCqMat WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

