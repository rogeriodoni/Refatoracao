# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [FONTNAME-ERRADO] Linha 189: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 248: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 303: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 436: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 453: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormIBP.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1427 linhas total):

*-- Linhas 49 a 58:
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51: 
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54: 
55:                 THIS.pgf_4c_Paginas.Visible   = .T.
56:                 THIS.pgf_4c_Paginas.ActivePage = 1
57:                 THIS.this_cModoAtual           = "LISTA"
58: 

*-- Linhas 83 a 155:
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
94:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
95:             .Page1.BackColor = RGB(255, 255, 255)
96: 
97:             .Page2.Caption   = "Dados"
98:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         THIS.ConfigurarPaginaLista()
103:         THIS.ConfigurarPaginaDados()
104:     ENDPROC
105: 
106:     *===========================================================================
107:     * ConfigurarPaginaLista - Configura Page1 com Grid e botoes
108:     * IBPT: cnt_4c_Botoes fica OCULTO/DESABILITADO (Grupo_op.Visible=.F. original)
109:     * cmd_4c_BtnCarregar eh o botao principal (btncarregar do legado)
110:     *===========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPagina, loc_oGrid
113:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
114: 
115:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
116:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         *-- Container Cabecalho (cntSombra no legado)
119:         *-- Original: cntSombra.Top=1. Com compensacao +29: Top=31
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackColor   = RGB(100, 100, 100)
127:             .BorderWidth = 0
128:             .Visible     = .T.
129: 
130:             .AddObject("lbl_4c_Sombra", "Label")
131:             WITH .lbl_4c_Sombra
132:                 .Caption   = THIS.Caption
133:                 .Top       = 15
134:                 .Left      = 10
135:                 .Width     = THIS.Width
136:                 .Height    = 40
137:                 .FontName  = "Tahoma"
138:                 .FontSize  = 16
139:                 .FontBold  = .T.
140:                 .ForeColor = RGB(0, 0, 0)
141:                 .BackStyle = 0
142:                 .AutoSize  = .F.
143:                 .Visible   = .T.
144:             ENDWITH
145: 
146:             .AddObject("lbl_4c_Titulo", "Label")
147:             WITH .lbl_4c_Titulo
148:                 .Caption   = THIS.Caption
149:                 .Top       = 18
150:                 .Left      = 10
151:                 .Width     = THIS.Width
152:                 .Height    = 46
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 16
155:                 .FontBold  = .T.

*-- Linhas 165 a 330:
165:         *-- Original: Left=544, Top=-1. Com compensacao +29: Top=28
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 28
169:             .Left        =  542
170:             .Width       = 385
171:             .Height      = 85
172:             .BackColor   = RGB(100, 100, 100)
173:             .BackStyle   = 1
174:             .BorderWidth = 0
175:             .Visible     = .F.
176:             .Enabled     = .F.
177: 
178:             .AddObject("cmd_4c_Incluir", "CommandButton")
179:             WITH .cmd_4c_Incluir
180:                 .Caption         = "Incluir"
181:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
182:                 .PicturePosition = 13
183:                 .Top             = 5
184:                 .Left            =  542
185:                 .Width           = 75
186:                 .Height          = 75
187:                 .BackColor       = RGB(255,255,255)
188:                 .ForeColor       = RGB(90,90,90)
189:                 .FontName        = "Comic Sans MS"
190:                 .FontSize        = 8
191:                 .FontBold        = .T.
192:                 .FontItalic      = .T.
193:             ENDWITH
194: 
195:             .AddObject("cmd_4c_Visualizar", "CommandButton")
196:             WITH .cmd_4c_Visualizar
197:                 .Caption         = "Visualizar"
198:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
199:                 .PicturePosition = 13
200:                 .Top             = 5
201:                 .Left            =  542
202:                 .Width           = 75
203:                 .Height          = 75
204:                 .BackColor       = RGB(255,255,255)
205:                 .ForeColor       = RGB(90,90,90)
206:                 .FontName        = "Comic Sans MS"
207:                 .FontSize        = 8
208:                 .FontBold        = .T.
209:                 .FontItalic      = .T.
210:                 .Themes          = .F.
211:                 .SpecialEffect   = 0
212:                 .MousePointer    = 15
213:                 .WordWrap        = .T.
214:             ENDWITH
215: 
216:             .AddObject("cmd_4c_Alterar", "CommandButton")
217:             WITH .cmd_4c_Alterar
218:                 .Caption         = "Alterar"
219:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:                 .PicturePosition = 13
221:                 .Top             = 5
222:                 .Left            =  542
223:                 .Width           = 75
224:                 .Height          = 75
225:                 .BackColor       = RGB(255,255,255)
226:                 .ForeColor       = RGB(90,90,90)
227:                 .FontName        = "Comic Sans MS"
228:                 .FontSize        = 8
229:                 .FontBold        = .T.
230:                 .FontItalic      = .T.
231:                 .Themes          = .F.
232:                 .SpecialEffect   = 0
233:                 .MousePointer    = 15
234:                 .WordWrap        = .T.
235:             ENDWITH
236: 
237:             .AddObject("cmd_4c_Excluir", "CommandButton")
238:             WITH .cmd_4c_Excluir
239:                 .Caption         = "Excluir"
240:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:                 .PicturePosition = 13
242:                 .Top             = 5
243:                 .Left            =  542
244:                 .Width           = 75
245:                 .Height          = 75
246:                 .BackColor       = RGB(255,255,255)
247:                 .ForeColor       = RGB(90,90,90)
248:                 .FontName        = "Comic Sans MS"
249:                 .FontSize        = 8
250:                 .FontBold        = .T.
251:                 .FontItalic      = .T.
252:                 .Themes          = .F.
253:                 .SpecialEffect   = 0
254:                 .MousePointer    = 15
255:                 .WordWrap        = .T.
256:             ENDWITH
257: 
258:             .AddObject("cmd_4c_Buscar", "CommandButton")
259:             WITH .cmd_4c_Buscar
260:                 .Caption         = "Buscar"
261:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
262:                 .PicturePosition = 13
263:                 .Top             = 5
264:                 .Left            =  542
265:                 .Width           = 75
266:                 .Height          = 75
267:                 .BackColor       = RGB(255,255,255)
268:                 .ForeColor       = RGB(90,90,90)
269:                 .FontName        = "Comic Sans MS"
270:                 .FontSize        = 8
271:                 .FontBold        = .T.
272:                 .FontItalic      = .T.
273:                 .Themes          = .F.
274:                 .SpecialEffect   = 0
275:                 .MousePointer    = 15
276:                 .WordWrap        = .T.
277:             ENDWITH
278:         ENDWITH
279: 
280:         *-- Container Saida - padrao canonico (CLAUDE.md Regra #10)
281:         *-- Left=917, Width=90, cmd_4c_Encerrar Width=75, Caption="Encerrar"
282:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
283:         WITH loc_oPagina.cnt_4c_Saida
284:             .Top         = 28
285:             .Left        = 917
286:             .Width       = 90
287:             .Height      = 85
288:             .BackStyle   = 0
289:             .BorderWidth = 0
290:             .Visible     = .T.
291: 
292:             .AddObject("cmd_4c_Encerrar", "CommandButton")
293:             WITH .cmd_4c_Encerrar
294:                 .Caption         = "Encerrar"
295:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:                 .PicturePosition = 13
297:                 .Top             = 5
298:                 .Left            = 917
299:                 .Width           = 90
300:                 .Height          = 75
301:                 .BackColor       = RGB(255,255,255)
302:                 .ForeColor       = RGB(90,90,90)
303:                 .FontName        = "Comic Sans MS"
304:                 .FontSize        = 8
305:                 .FontBold        = .T.
306:                 .FontItalic      = .T.
307:             ENDWITH
308:         ENDWITH
309: 
310:         *-- Botao Carregar IBPT (btncarregar no legado)
311:         *-- Original: Top=10 direto no form; +29 de compensacao em Page1 -> Top=39
312:         *-- Original: Left=475, Width=75, Height=75
313:         loc_oPagina.AddObject("cmd_4c_BtnCarregar", "CommandButton")
314:         WITH loc_oPagina.cmd_4c_BtnCarregar
315:             .Caption         = "Carrega ibpt"
316:             .Picture         = gc_4c_CaminhoIcones + "Arrowdown.ico"
317:             .PicturePosition = 13
318:             .Top             = 39
319:             .Left            = 475
320:             .Width           = 75
321:             .Height          = 75
322:             .BackColor       = RGB(255, 255, 255)
323:             .ForeColor       = RGB(90, 90, 90)
324:             .FontName        = "Comic Sans MS"
325:             .FontSize        = 8
326:             .FontBold        = .T.
327:             .FontItalic      = .T.
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .MousePointer    = 15

*-- Linhas 341 a 350:
341:         loc_oGrid.ColumnCount = 9
342: 
343:         WITH loc_oGrid
344:             .Top                = 162
345:             .Left               = 12
346:             .Width              = 940
347:             .Height             = 458
348:             .RowHeight          = 16
349:             .ForeColor          = RGB(90, 90, 90)
350:             .BackColor          = RGB(255, 255, 255)

*-- Linhas 367 a 383:
367:             .Column8.Width  = 75
368:             .Column9.Width  = 75
369: 
370:             .Column1.Header1.Caption = "Estado"
371:             .Column2.Header1.Caption = "Codigo"
372:             .Column3.Header1.Caption = "Data Ini"
373:             .Column4.Header1.Caption = "Data Fim"
374:             .Column5.Header1.Caption = "Aliq Nac Fed"
375:             .Column6.Header1.Caption = "Aliq Imp Fed"
376:             .Column7.Header1.Caption = "Aliq Estadual"
377:             .Column8.Header1.Caption = "Aliq Municipal"
378:             .Column9.Header1.Caption = "Versao"
379: 
380:             .Column1.Alignment = 0
381:             .Column2.Alignment = 0
382:             .Column3.Alignment = 0
383:             .Column4.Alignment = 0

*-- Linhas 389 a 403:
389:         ENDWITH
390: 
391:         *-- BINDEVENT para botoes (Problema 17: handlers devem ser PUBLIC)
392:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,          "Click", THIS, "BtnEncerrarClick")
393:         BINDEVENT(loc_oPagina.cmd_4c_BtnCarregar,                    "Click", THIS, "BtnCarregarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,          "Click", THIS, "BtnIncluirClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,          "Click", THIS, "BtnAlterarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar,       "Click", THIS, "BtnVisualizarClick")
397:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,          "Click", THIS, "BtnExcluirClick")
398:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,           "Click", THIS, "BtnBuscarClick")
399: 
400:         THIS.TornarControlesVisiveis(loc_oPagina)
401:     ENDPROC
402: 
403:     *===========================================================================

*-- Linhas 415 a 474:
415:         *-- Original: Left=819, Top=9. Com compensacao +29: Top=38
416:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
417:         WITH loc_oPagina.cnt_4c_Salva
418:             .Top         = 38
419:             .Left        = 842
420:             .Width       = 160
421:             .Height      = 85
422:             .BackStyle   = 0
423:             .Visible     = .T.
424: 
425:             .AddObject("cmd_4c_Confirmar", "CommandButton")
426:             WITH .cmd_4c_Confirmar
427:                 .Caption         = "Confirmar"
428:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
429:                 .PicturePosition = 13
430:                 .Top             = 5
431:                 .Left            = 5
432:                 .Width           = 75
433:                 .Height          = 75
434:                 .BackColor       = RGB(255,255,255)
435:                 .ForeColor       = RGB(90,90,90)
436:                 .FontName        = "Comic Sans MS"
437:                 .FontSize        = 8
438:                 .FontBold        = .T.
439:                 .FontItalic      = .T.
440:             ENDWITH
441: 
442:             .AddObject("cmd_4c_Cancelar", "CommandButton")
443:             WITH .cmd_4c_Cancelar
444:                 .Caption         = "Encerrar"
445:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
446:                 .PicturePosition = 13
447:                 .Top             = 5
448:                 .Left            = 80
449:                 .Width           = 75
450:                 .Height          = 75
451:                 .BackColor       = RGB(255,255,255)
452:                 .ForeColor       = RGB(90,90,90)
453:                 .FontName        = "Comic Sans MS"
454:                 .FontSize        = 8
455:                 .FontBold        = .T.
456:                 .FontItalic      = .T.
457:                 .Themes          = .F.
458:                 .SpecialEffect   = 0
459:                 .MousePointer    = 15
460:                 .WordWrap        = .T.
461:             ENDWITH
462:         ENDWITH
463: 
464:         *-- Campo UFS (Estado) - char(2)
465:         loc_oPagina.AddObject("lbl_4c_Ufs", "Label")
466:         WITH loc_oPagina.lbl_4c_Ufs
467:             .Caption   = "Estado :"
468:             .Top       = 138
469:             .Left      = 10
470:             .Width     = 100
471:             .Height    = 17
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .FontBold  = .F.

*-- Linhas 481 a 506:
481:         loc_oPagina.AddObject("txt_4c_Ufs", "TextBox")
482:         WITH loc_oPagina.txt_4c_Ufs
483:             .Value     = ""
484:             .Top       = 135
485:             .Left      = 115
486:             .Width     = 45
487:             .Height    = 20
488:             .FontName  = "Tahoma"
489:             .FontSize  = 8
490:             .ForeColor = RGB(90, 90, 90)
491:             .BackColor = RGB(255, 255, 255)
492:             .MaxLength = 2
493:             .Visible   = .T.
494:         ENDWITH
495: 
496:         *-- Campo Codigo - char(10)
497:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
498:         WITH loc_oPagina.lbl_4c_Codigo
499:             .Caption   = "C" + CHR(243) + "digo :"
500:             .Top       = 163
501:             .Left      = 10
502:             .Width     = 100
503:             .Height    = 17
504:             .FontName  = "Tahoma"
505:             .FontSize  = 8
506:             .FontBold  = .F.

*-- Linhas 513 a 538:
513:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
514:         WITH loc_oPagina.txt_4c_Codigo
515:             .Value     = ""
516:             .Top       = 160
517:             .Left      = 115
518:             .Width     = 120
519:             .Height    = 20
520:             .FontName  = "Tahoma"
521:             .FontSize  = 8
522:             .ForeColor = RGB(90, 90, 90)
523:             .BackColor = RGB(255, 255, 255)
524:             .MaxLength = 10
525:             .Visible   = .T.
526:         ENDWITH
527: 
528:         *-- Campo Ex - char(3)
529:         loc_oPagina.AddObject("lbl_4c_Ex", "Label")
530:         WITH loc_oPagina.lbl_4c_Ex
531:             .Caption   = "Ex :"
532:             .Top       = 188
533:             .Left      = 10
534:             .Width     = 100
535:             .Height    = 17
536:             .FontName  = "Tahoma"
537:             .FontSize  = 8
538:             .FontBold  = .F.

*-- Linhas 545 a 570:
545:         loc_oPagina.AddObject("txt_4c_Ex", "TextBox")
546:         WITH loc_oPagina.txt_4c_Ex
547:             .Value     = ""
548:             .Top       = 185
549:             .Left      = 115
550:             .Width     = 45
551:             .Height    = 20
552:             .FontName  = "Tahoma"
553:             .FontSize  = 8
554:             .ForeColor = RGB(90, 90, 90)
555:             .BackColor = RGB(255, 255, 255)
556:             .MaxLength = 3
557:             .Visible   = .T.
558:         ENDWITH
559: 
560:         *-- Campo Tipo - numeric(3,0)
561:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
562:         WITH loc_oPagina.lbl_4c_Tipo
563:             .Caption   = "Tipo :"
564:             .Top       = 213
565:             .Left      = 10
566:             .Width     = 100
567:             .Height    = 17
568:             .FontName  = "Tahoma"
569:             .FontSize  = 8
570:             .FontBold  = .F.

*-- Linhas 577 a 602:
577:         loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
578:         WITH loc_oPagina.txt_4c_Tipo
579:             .Value     = 0
580:             .Top       = 210
581:             .Left      = 115
582:             .Width     = 60
583:             .Height    = 20
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .ForeColor = RGB(90, 90, 90)
587:             .BackColor = RGB(255, 255, 255)
588:             .InputMask = "999"
589:             .Visible   = .T.
590:         ENDWITH
591: 
592:         *-- Campo Descricao - text/memo (EditBox)
593:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
594:         WITH loc_oPagina.lbl_4c_Descricao
595:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
596:             .Top       = 238
597:             .Left      = 10
598:             .Width     = 100
599:             .Height    = 17
600:             .FontName  = "Tahoma"
601:             .FontSize  = 8
602:             .FontBold  = .F.

*-- Linhas 609 a 633:
609:         loc_oPagina.AddObject("edt_4c_Descricao", "EditBox")
610:         WITH loc_oPagina.edt_4c_Descricao
611:             .Value     = ""
612:             .Top       = 235
613:             .Left      = 115
614:             .Width     = 600
615:             .Height    = 55
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8
618:             .ForeColor = RGB(90, 90, 90)
619:             .BackColor = RGB(255, 255, 255)
620:             .Visible   = .T.
621:         ENDWITH
622: 
623:         *-- Campo Data Ini - datetime
624:         loc_oPagina.AddObject("lbl_4c_DatIni", "Label")
625:         WITH loc_oPagina.lbl_4c_DatIni
626:             .Caption   = "Data Ini :"
627:             .Top       = 298
628:             .Left      = 10
629:             .Width     = 100
630:             .Height    = 17
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .FontBold  = .F.

*-- Linhas 640 a 664:
640:         loc_oPagina.AddObject("txt_4c_DatIni", "TextBox")
641:         WITH loc_oPagina.txt_4c_DatIni
642:             .Value     = {}
643:             .Top       = 295
644:             .Left      = 115
645:             .Width     = 130
646:             .Height    = 20
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .ForeColor = RGB(90, 90, 90)
650:             .BackColor = RGB(255, 255, 255)
651:             .Visible   = .T.
652:         ENDWITH
653: 
654:         *-- Campo Data Fim - datetime
655:         loc_oPagina.AddObject("lbl_4c_DatFin", "Label")
656:         WITH loc_oPagina.lbl_4c_DatFin
657:             .Caption   = "Data Fim :"
658:             .Top       = 323
659:             .Left      = 10
660:             .Width     = 100
661:             .Height    = 17
662:             .FontName  = "Tahoma"
663:             .FontSize  = 8
664:             .FontBold  = .F.

*-- Linhas 671 a 695:
671:         loc_oPagina.AddObject("txt_4c_DatFin", "TextBox")
672:         WITH loc_oPagina.txt_4c_DatFin
673:             .Value     = {}
674:             .Top       = 320
675:             .Left      = 115
676:             .Width     = 130
677:             .Height    = 20
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .ForeColor = RGB(90, 90, 90)
681:             .BackColor = RGB(255, 255, 255)
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         *-- Coluna 2: Aliquotas (nacfederal, impfederal, estadual, municipal)
686:         loc_oPagina.AddObject("lbl_4c_NacFederal", "Label")
687:         WITH loc_oPagina.lbl_4c_NacFederal
688:             .Caption   = "Aliq Nac Fed :"
689:             .Top       = 138
690:             .Left      = 360
691:             .Width     = 105
692:             .Height    = 17
693:             .FontName  = "Tahoma"
694:             .FontSize  = 8
695:             .FontBold  = .F.

*-- Linhas 702 a 726:
702:         loc_oPagina.AddObject("txt_4c_NacFederal", "TextBox")
703:         WITH loc_oPagina.txt_4c_NacFederal
704:             .Value     = 0
705:             .Top       = 135
706:             .Left      = 470
707:             .Width     = 80
708:             .Height    = 20
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .ForeColor = RGB(90, 90, 90)
712:             .BackColor = RGB(255, 255, 255)
713:             .InputMask = "99.99"
714:             .Visible   = .T.
715:         ENDWITH
716: 
717:         loc_oPagina.AddObject("lbl_4c_ImpFederal", "Label")
718:         WITH loc_oPagina.lbl_4c_ImpFederal
719:             .Caption   = "Aliq Imp Fed :"
720:             .Top       = 163
721:             .Left      = 360
722:             .Width     = 105
723:             .Height    = 17
724:             .FontName  = "Tahoma"
725:             .FontSize  = 8
726:             .FontBold  = .F.

*-- Linhas 733 a 757:
733:         loc_oPagina.AddObject("txt_4c_ImpFederal", "TextBox")
734:         WITH loc_oPagina.txt_4c_ImpFederal
735:             .Value     = 0
736:             .Top       = 160
737:             .Left      = 470
738:             .Width     = 80
739:             .Height    = 20
740:             .FontName  = "Tahoma"
741:             .FontSize  = 8
742:             .ForeColor = RGB(90, 90, 90)
743:             .BackColor = RGB(255, 255, 255)
744:             .InputMask = "99.99"
745:             .Visible   = .T.
746:         ENDWITH
747: 
748:         loc_oPagina.AddObject("lbl_4c_Estadual", "Label")
749:         WITH loc_oPagina.lbl_4c_Estadual
750:             .Caption   = "Aliq Estadual :"
751:             .Top       = 188
752:             .Left      = 360
753:             .Width     = 105
754:             .Height    = 17
755:             .FontName  = "Tahoma"
756:             .FontSize  = 8
757:             .FontBold  = .F.

*-- Linhas 764 a 788:
764:         loc_oPagina.AddObject("txt_4c_Estadual", "TextBox")
765:         WITH loc_oPagina.txt_4c_Estadual
766:             .Value     = 0
767:             .Top       = 185
768:             .Left      = 470
769:             .Width     = 80
770:             .Height    = 20
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .ForeColor = RGB(90, 90, 90)
774:             .BackColor = RGB(255, 255, 255)
775:             .InputMask = "99.99"
776:             .Visible   = .T.
777:         ENDWITH
778: 
779:         loc_oPagina.AddObject("lbl_4c_Municipal", "Label")
780:         WITH loc_oPagina.lbl_4c_Municipal
781:             .Caption   = "Aliq Municipal :"
782:             .Top       = 213
783:             .Left      = 360
784:             .Width     = 105
785:             .Height    = 17
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .FontBold  = .F.

*-- Linhas 795 a 820:
795:         loc_oPagina.AddObject("txt_4c_Municipal", "TextBox")
796:         WITH loc_oPagina.txt_4c_Municipal
797:             .Value     = 0
798:             .Top       = 210
799:             .Left      = 470
800:             .Width     = 80
801:             .Height    = 20
802:             .FontName  = "Tahoma"
803:             .FontSize  = 8
804:             .ForeColor = RGB(90, 90, 90)
805:             .BackColor = RGB(255, 255, 255)
806:             .InputMask = "99.99"
807:             .Visible   = .T.
808:         ENDWITH
809: 
810:         *-- Coluna 1 (continuacao apos datfin): chave, versao, fonte
811:         loc_oPagina.AddObject("lbl_4c_Chave", "Label")
812:         WITH loc_oPagina.lbl_4c_Chave
813:             .Caption   = "Chave :"
814:             .Top       = 348
815:             .Left      = 10
816:             .Width     = 100
817:             .Height    = 17
818:             .FontName  = "Tahoma"
819:             .FontSize  = 8
820:             .FontBold  = .F.

*-- Linhas 827 a 851:
827:         loc_oPagina.AddObject("txt_4c_Chave", "TextBox")
828:         WITH loc_oPagina.txt_4c_Chave
829:             .Value     = ""
830:             .Top       = 345
831:             .Left      = 115
832:             .Width     = 120
833:             .Height    = 20
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .ForeColor = RGB(90, 90, 90)
837:             .BackColor = RGB(255, 255, 255)
838:             .MaxLength = 10
839:             .Visible   = .T.
840:         ENDWITH
841: 
842:         loc_oPagina.AddObject("lbl_4c_Versao", "Label")
843:         WITH loc_oPagina.lbl_4c_Versao
844:             .Caption   = "Vers" + CHR(227) + "o :"
845:             .Top       = 373
846:             .Left      = 10
847:             .Width     = 100
848:             .Height    = 17
849:             .FontName  = "Tahoma"
850:             .FontSize  = 8
851:             .FontBold  = .F.

*-- Linhas 858 a 882:
858:         loc_oPagina.AddObject("txt_4c_Versao", "TextBox")
859:         WITH loc_oPagina.txt_4c_Versao
860:             .Value     = ""
861:             .Top       = 370
862:             .Left      = 115
863:             .Width     = 120
864:             .Height    = 20
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:             .ForeColor = RGB(90, 90, 90)
868:             .BackColor = RGB(255, 255, 255)
869:             .MaxLength = 10
870:             .Visible   = .T.
871:         ENDWITH
872: 
873:         loc_oPagina.AddObject("lbl_4c_Fonte", "Label")
874:         WITH loc_oPagina.lbl_4c_Fonte
875:             .Caption   = "Fonte :"
876:             .Top       = 398
877:             .Left      = 10
878:             .Width     = 100
879:             .Height    = 17
880:             .FontName  = "Tahoma"
881:             .FontSize  = 8
882:             .FontBold  = .F.

*-- Linhas 889 a 911:
889:         loc_oPagina.AddObject("txt_4c_Fonte", "TextBox")
890:         WITH loc_oPagina.txt_4c_Fonte
891:             .Value     = ""
892:             .Top       = 395
893:             .Left      = 115
894:             .Width     = 120
895:             .Height    = 20
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:             .ForeColor = RGB(90, 90, 90)
899:             .BackColor = RGB(255, 255, 255)
900:             .MaxLength = 10
901:             .Visible   = .T.
902:         ENDWITH
903: 
904:         *-- BINDEVENT para botoes de Page2
905:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
906:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
907: 
908:         THIS.TornarControlesVisiveis(loc_oPagina)
909:     ENDPROC
910: 
911:     *===========================================================================

*-- Linhas 940 a 956:
940:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
941: 
942:                         *-- Problema 32: Reconfigurar Headers APOS RecordSource
943:                         .Column1.Header1.Caption = "Estado"
944:                         .Column2.Header1.Caption = "Codigo"
945:                         .Column3.Header1.Caption = "Data Ini"
946:                         .Column4.Header1.Caption = "Data Fim"
947:                         .Column5.Header1.Caption = "Aliq Nac Fed"
948:                         .Column6.Header1.Caption = "Aliq Imp Fed"
949:                         .Column7.Header1.Caption = "Aliq Estadual"
950:                         .Column8.Header1.Caption = "Aliq Municipal"
951:                         .Column9.Header1.Caption = "Versao"
952: 
953:                         .Column1.Width = 75
954:                         .Column2.Width = 100
955:                         .Column3.Width = 75
956:                         .Column4.Width = 75

*-- Linhas 1353 a 1369:
1353:                         .Column8.ControlSource = "cursor_4c_Dados.municipal"
1354:                         .Column9.ControlSource = "cursor_4c_Dados.versao"
1355: 
1356:                         .Column1.Header1.Caption = "Estado"
1357:                         .Column2.Header1.Caption = "Codigo"
1358:                         .Column3.Header1.Caption = "Data Ini"
1359:                         .Column4.Header1.Caption = "Data Fim"
1360:                         .Column5.Header1.Caption = "Aliq Nac Fed"
1361:                         .Column6.Header1.Caption = "Aliq Imp Fed"
1362:                         .Column7.Header1.Caption = "Aliq Estadual"
1363:                         .Column8.Header1.Caption = "Aliq Municipal"
1364:                         .Column9.Header1.Caption = "Versao"
1365: 
1366:                         .Column1.Width = 75
1367:                         .Column2.Width = 100
1368:                         .Column3.Width = 75
1369:                         .Column4.Width = 75

*-- Linhas 1395 a 1414:
1395:         loc_lModoVisualizacao  = (THIS.this_cModoAtual = "VISUALIZAR")
1396: 
1397:         *-- Botao Confirmar: habilitado apenas em edicao
1398:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar, "Enabled", 5)
1399:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lModoEdicao
1400:         ENDIF
1401: 
1402:         *-- Botao Cancelar: habilitado em edicao e visualizacao
1403:         IF PEMSTATUS(loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar, "Enabled", 5)
1404:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = (loc_lModoEdicao OR loc_lModoVisualizacao)
1405:         ENDIF
1406: 
1407:         *-- Botao BtnCarregar: habilitado apenas na lista
1408:         IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar) = "O"
1409:             THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnCarregar.Enabled = (THIS.this_cModoAtual = "LISTA")
1410:         ENDIF
1411:     ENDPROC
1412: 
1413:     *===========================================================================
1414:     * Destroy - Libera recursos


### BO (C:\4c\projeto\app\classes\IBPBO.prg):
*------------------------------------------------------------------------------
* IBPBO.prg - Business Object para SigCdIbp (Cadastro IBPT)
* Herda de BusinessBase
* Tabela: SigCdIbp / PK: cidchaves
*------------------------------------------------------------------------------

DEFINE CLASS IBPBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves  = ""   && char(20) NOT NULL

    *-- Campos da tabela SigCdIbp
    this_cUfs        = ""   && char(2)
    this_cCodigo     = ""   && char(10)
    this_cEx         = ""   && char(3)
    this_nTipo       = 0    && numeric(3,0)
    this_cDescricao  = ""   && text (memo)
    this_dDatIni     = {}   && datetime
    this_dDatFin     = {}   && datetime
    this_nNacFederal = 0    && numeric(5,2)
    this_nImpFederal = 0    && numeric(5,2)
    this_nEstadual   = 0    && numeric(5,2)
    this_nMunicipal  = 0    && numeric(5,2)
    this_cChave      = ""   && char(10)
    this_cVersao     = ""   && char(10)
    this_cFonte      = ""   && char(10)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdIbp"
        THIS.this_cCampoChave  = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtro opcional; cursor_4c_Dados para o grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("par_cFiltro") = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                loc_cWhere = ""
            ENDIF

            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       loc_cWhere + ;
                       " ORDER BY ufs, codigo, versao"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - SELECT por cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       " datini, datfin, nacfederal, impfederal, estadual," + ;
                       " municipal, chave, versao, fonte" + ;
                       " FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(par_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            TRY
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cUfs        = TratarNulo(ufs,        "C")
                THIS.this_cCodigo     = TratarNulo(codigo,     "C")
                THIS.this_cEx         = TratarNulo(ex,         "C")
                THIS.this_nTipo       = TratarNulo(tipo,       "N")
                THIS.this_cDescricao  = TratarNulo(descricao,  "C")
                THIS.this_dDatIni     = TratarNulo(datini,     "D")
                THIS.this_dDatFin     = TratarNulo(datfin,     "D")
                THIS.this_nNacFederal = TratarNulo(nacfederal, "N")
                THIS.this_nImpFederal = TratarNulo(impfederal, "N")
                THIS.this_nEstadual   = TratarNulo(estadual,   "N")
                THIS.this_nMunicipal  = TratarNulo(municipal,  "N")
                THIS.this_cChave      = TratarNulo(chave,      "C")
                THIS.this_cVersao     = TratarNulo(versao,     "C")
                THIS.this_cFonte      = TratarNulo(fonte,      "C")
                loc_lSucesso = .T.
            CATCH TO loException
                MsgErro("Erro em IBPBO.CarregarDoCursor:" + CHR(13) + loException.Message, "Erro")
            ENDTRY
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro via CRUD standard
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
                SELECT cursor_4c_Uuid
                THIS.this_cCidChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
            ENDIF
            IF USED("cursor_4c_Uuid")
                USE IN cursor_4c_Uuid
            ENDIF

            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdIbp" + ;
                       " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                       "  datini, datfin, nacfederal, impfederal," + ;
                       "  estadual, municipal, chave, versao, fonte)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cUfs) + "," + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cEx) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       EscaparSQL(THIS.this_cDescricao) + "," + ;
                       FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       EscaparSQL(THIS.this_cChave) + "," + ;
                       EscaparSQL(THIS.this_cVersao) + "," + ;
                       EscaparSQL(THIS.this_cFonte) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdIbp SET" + ;
                       " ufs        = " + EscaparSQL(THIS.this_cUfs) + "," + ;
                       " codigo     = " + EscaparSQL(THIS.this_cCodigo) + "," + ;
                       " ex         = " + EscaparSQL(THIS.this_cEx) + "," + ;
                       " tipo       = " + FormatarNumeroSQL(THIS.this_nTipo) + "," + ;
                       " descricao  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " datini     = " + FormatarDataSQL(THIS.this_dDatIni) + "," + ;
                       " datfin     = " + FormatarDataSQL(THIS.this_dDatFin) + "," + ;
                       " nacfederal = " + FormatarNumeroSQL(THIS.this_nNacFederal) + "," + ;
                       " impfederal = " + FormatarNumeroSQL(THIS.this_nImpFederal) + "," + ;
                       " estadual   = " + FormatarNumeroSQL(THIS.this_nEstadual) + "," + ;
                       " municipal  = " + FormatarNumeroSQL(THIS.this_nMunicipal) + "," + ;
                       " chave      = " + EscaparSQL(THIS.this_cChave) + "," + ;
                       " versao     = " + EscaparSQL(THIS.this_cVersao) + "," + ;
                       " fonte      = " + EscaparSQL(THIS.this_cFonte) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE pelo cidchaves
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdIbp" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir IBPT:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em IBPBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarPlanilha - Importa dados IBPT de arquivos CSV de uma pasta
    * Portado de SIGCDIBP.importaplan
    * CSV: c1=codigo, c2=ex(skip se !empty), c4=descricao, c5=nacfed, c6=impfed,
    *       c7=estadual, c8=municipal, c9=datini, c10=datfin, c11=chave,
    *       c12=versao, c13=fonte. UF extraida do nome do arquivo (pos 13-14).
    *--------------------------------------------------------------------------
    FUNCTION ImportarPlanilha()
        LOCAL loc_lSucesso, loc_lOk, loc_lcDir, loc_nQtdArq
        LOCAL loc_lcArq, loc_lcUf, loc_lcCodigo, loc_lcDesc
        LOCAL loc_lnAliq5, loc_lnAliq6, loc_lnAliq7, loc_lnAliq8
        LOCAL loc_ldDatIni, loc_ldDatFin
        LOCAL loc_lcChave, loc_lcVersao, loc_lcFonte
        LOCAL loc_lcCidChaves, loc_lcQuery, loc_nResult, loc_i
        loc_lSucesso = .F.
        loc_lOk      = .F.

        *-- Selecionar pasta (fora do TRY - RETURN .F. e valido aqui)
        loc_lcDir = GETDIR([], "Selecione a Pasta com os Arquivos CSV do IBPT", ;
                           "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios", 2)
        IF EMPTY(loc_lcDir)
            RETURN .F.
        ENDIF

        DIMENSION loc_laArqs[1, 5]
        loc_nQtdArq = ADIR(loc_laArqs, loc_lcDir + "*.csv")
        IF loc_nQtdArq = 0
            MsgAviso("Nenhum arquivo CSV encontrado na pasta selecionada.", "Aviso")
            RETURN .F.
        ENDIF

        loc_lOk = .T.

        TRY
            CREATE CURSOR localIbpt (c1 c(10), c2 c(50), c3 c(50), c4 c(100), ;
                c5 c(50), c6 c(50), c7 c(50), c8 c(50), ;
                c9 c(50), c10 c(50), c11 c(50), c12 c(50), c13 c(50))

            FOR loc_i = 1 TO loc_nQtdArq
                loc_lcArq = loc_lcDir + loc_laArqs[loc_i, 1]
                IF EMPTY(loc_lcArq)
                    LOOP
                ENDIF

                *-- UF extraida do nome do arquivo (posicoes 13-14 do nome original)
                loc_lcUf = SUBSTR(ALLTRIM(loc_laArqs[loc_i, 1]), 13, 2)

                SELECT localIbpt
                ZAP
                APPEND FROM (loc_lcArq) DELIMITED WITH CHARACTER ";"
                GO TOP
                DELETE
                DELETE ALL FOR !EMPTY(c2)
                GO TOP

                SCAN
                    loc_lcCodigo = ALLTRIM(c1)
                    loc_lcDesc   = ALLTRIM(c4)
                    loc_lnAliq5  = VAL(ALLTRIM(c5))
                    loc_lnAliq6  = VAL(ALLTRIM(c6))
                    loc_lnAliq7  = VAL(ALLTRIM(c7))
                    loc_lnAliq8  = VAL(ALLTRIM(c8))
                    loc_ldDatIni = DTOT(CTOD(ALLTRIM(c9)))
                    loc_ldDatFin = DTOT(CTOD(ALLTRIM(c10)))
                    loc_lcChave  = ALLTRIM(c11)
                    loc_lcVersao = ALLTRIM(c12)
                    loc_lcFonte  = ALLTRIM(c13)

                    loc_lcQuery = "SELECT cidchaves FROM SigCdIbp" + ;
                                  " WHERE ufs    = " + EscaparSQL(loc_lcUf) + ;
                                  " AND   codigo = " + EscaparSQL(loc_lcCodigo) + ;
                                  " AND   chave  = " + EscaparSQL(loc_lcChave) + ;
                                  " AND   versao = " + EscaparSQL(loc_lcVersao)

                    *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                    IF USED("cursor_4c_AuxIbp")
                        TABLEREVERT(.T., "cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "cursor_4c_AuxIbp")
                    IF loc_nResult < 0
                        MsgErro("Imposs" + CHR(237) + "vel conectar ao servidor de banco de dados.", "Erro")
                        loc_lOk = .F.
                        IF USED("cursor_4c_AuxIbp")
                            USE IN cursor_4c_AuxIbp
                        ENDIF
                        EXIT
                    ENDIF

                    IF RECCOUNT("cursor_4c_AuxIbp") = 0
                        *-- Novo registro
                        loc_lcCidChaves = LEFT(fUniqueIds(), 20)
                        loc_lcQuery = "INSERT INTO SigCdIbp" + ;
                                      " (cidchaves, ufs, codigo, ex, tipo, descricao," + ;
                                      "  datini, datfin, nacfederal, impfederal," + ;
                                      "  estadual, municipal, chave, versao, fonte)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(loc_lcCidChaves) + "," + ;
                                      EscaparSQL(loc_lcUf) + "," + ;
                                      EscaparSQL(loc_lcCodigo) + "," + ;
                                      EscaparSQL("") + "," + ;
                                      "0," + ;
                                      EscaparSQL(loc_lcDesc) + "," + ;
                                      FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      EscaparSQL(loc_lcChave) + "," + ;
                                      EscaparSQL(loc_lcVersao) + "," + ;
                                      EscaparSQL(loc_lcFonte) + ;
                                      ")"
                    ELSE
                        *-- Registro existente - atualizar aliquotas e datas
                        SELECT cursor_4c_AuxIbp
                        loc_lcCidChaves = ALLTRIM(cursor_4c_AuxIbp.cidchaves)
                        loc_lcQuery = "UPDATE SigCdIbp SET" + ;
                                      " descricao  = " + EscaparSQL(loc_lcDesc) + "," + ;
                                      " datini     = " + FormatarDataSQL(loc_ldDatIni) + "," + ;
                                      " datfin     = " + FormatarDataSQL(loc_ldDatFin) + "," + ;
                                      " nacfederal = " + FormatarNumeroSQL(loc_lnAliq5) + "," + ;
                                      " impfederal = " + FormatarNumeroSQL(loc_lnAliq6) + "," + ;
                                      " estadual   = " + FormatarNumeroSQL(loc_lnAliq7) + "," + ;
                                      " municipal  = " + FormatarNumeroSQL(loc_lnAliq8) + "," + ;
                                      " fonte      = " + EscaparSQL(loc_lcFonte) + ;
                                      " WHERE cidchaves = " + EscaparSQL(loc_lcCidChaves)
                    ENDIF

                    IF USED("cursor_4c_AuxIbp")
                        USE IN cursor_4c_AuxIbp
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery)
                    IF loc_nResult < 0
                        MsgErro("Erro ao importar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lOk = .F.
                        EXIT
                    ENDIF

                    SELECT localIbpt
                ENDSCAN

                IF !loc_lOk
                    EXIT
                ENDIF
            ENDFOR

            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF

            loc_lSucesso = loc_lOk
        CATCH TO loException
            MsgErro("Erro em IBPBO.ImportarPlanilha:" + CHR(13) + loException.Message, "Erro")
            IF USED("localIbpt")
                USE IN localIbpt
            ENDIF
            IF USED("cursor_4c_AuxIbp")
                USE IN cursor_4c_AuxIbp
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

