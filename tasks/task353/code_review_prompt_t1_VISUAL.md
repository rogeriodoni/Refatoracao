# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Observações' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Observações' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde Tubo, Qtde Canc.. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCAF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1493 linhas total):

*-- Linhas 50 a 67:
50:         loc_lResultado = .F.
51: 
52:         TRY
53:             THIS.Caption = "Cancelamento de OP da Fundi" + CHR(231) + CHR(227) + "o"
54:             THIS.this_oBusinessObject = CREATEOBJECT("CAFBO")
55: 
56:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
57:                 MsgErro("Falha ao criar CAFBO", "Erro")
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60: 
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                     THIS.CarregarLista()
66:                 ENDIF
67: 

*-- Linhas 87 a 104:
87: 
88:         WITH loc_oPgf
89:             .PageCount = 2
90:             .Top       = -29
91:             .Left      = 0
92:             .Width     = THIS.Width
93:             .Height    = THIS.Height + 29
94:             .Tabs      = .F.
95:             .Visible   = .T.
96:             .Page1.Caption   = "Lista"
97:             .Page1.BackColor = RGB(100, 100, 100)
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page2.Caption   = "Dados"
100:             .Page2.BackColor = RGB(100, 100, 100)
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:         ENDWITH
103: 
104:         THIS.ConfigurarPaginaLista()

*-- Linhas 116 a 154:
116:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
117:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
118:         WITH loc_oCab
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oCab.lbl_4c_Sombra
130:             .AutoSize  = .F.
131:             .Caption   = THIS.Caption
132:             .Top       = 15
133:             .Left      = 10
134:             .Width     = THIS.Width
135:             .Height    = 40
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(0, 0, 0)
140:             .BackStyle = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oCab.lbl_4c_Titulo
146:             .AutoSize  = .F.
147:             .Caption   = THIS.Caption
148:             .Top       = 18
149:             .Left      = 10
150:             .Width     = THIS.Width
151:             .Height    = 46
152:             .FontName  = "Tahoma"
153:             .FontSize  = 16
154:             .FontBold  = .T.

*-- Linhas 161 a 185:
161:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
162:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
163:         WITH loc_oBotoes
164:             .Top         = 29
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackColor   = RGB(53, 53, 53)
169:             .BackStyle   = 1
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oBotoes.cmd_4c_Incluir
176:             .Caption         = "Incluir"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .BackColor       = RGB(255, 255, 255)
184:             .ForeColor       = RGB(90, 90, 90)
185:             .FontName        = "Tahoma"

*-- Linhas 194 a 208:
194:             .Visible         = .T.
195:         ENDWITH
196: 
197:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
198:         WITH loc_oBotoes.cmd_4c_Visualizar
199:             .Caption         = "Visualizar"
200:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
201:             .PicturePosition = 13
202:             .Top             = 5
203:             .Left            = 80
204:             .Width           = 75
205:             .Height          = 75
206:             .BackColor       = RGB(255, 255, 255)
207:             .ForeColor       = RGB(90, 90, 90)
208:             .FontName        = "Tahoma"

*-- Linhas 217 a 231:
217:             .Visible         = .T.
218:         ENDWITH
219: 
220:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
221:         WITH loc_oBotoes.cmd_4c_Alterar
222:             .Caption         = "Alterar"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
224:             .PicturePosition = 13
225:             .Top             = 5
226:             .Left            = 155
227:             .Width           = 75
228:             .Height          = 75
229:             .BackColor       = RGB(255, 255, 255)
230:             .ForeColor       = RGB(90, 90, 90)
231:             .FontName        = "Tahoma"

*-- Linhas 240 a 254:
240:             .Visible         = .T.
241:         ENDWITH
242: 
243:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
244:         WITH loc_oBotoes.cmd_4c_Excluir
245:             .Caption         = "Excluir"
246:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
247:             .PicturePosition = 13
248:             .Top             = 5
249:             .Left            = 230
250:             .Width           = 75
251:             .Height          = 75
252:             .BackColor       = RGB(255, 255, 255)
253:             .ForeColor       = RGB(90, 90, 90)
254:             .FontName        = "Tahoma"

*-- Linhas 263 a 277:
263:             .Visible         = .T.
264:         ENDWITH
265: 
266:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oBotoes.cmd_4c_Buscar
268:             .Caption         = "Buscar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .BackColor       = RGB(255, 255, 255)
276:             .ForeColor       = RGB(90, 90, 90)
277:             .FontName        = "Tahoma"

*-- Linhas 286 a 319:
286:             .Visible         = .T.
287:         ENDWITH
288: 
289:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
290:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
294: 
295:         *-- Container Encerrar (canonico: Left=917, Width=90)
296:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
297:         loc_oSaida = loc_oPg1.cnt_4c_Saida
298:         WITH loc_oSaida
299:             .Top         = 29
300:             .Left        = 917
301:             .Width       = 90
302:             .Height      = 85
303:             .BackStyle   = 0
304:             .BorderWidth = 0
305:             .Visible     = .T.
306:         ENDWITH
307: 
308:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oSaida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 5
315:             .Width           = 75
316:             .Height          = 75
317:             .BackColor       = RGB(255, 255, 255)
318:             .ForeColor       = RGB(90, 90, 90)
319:             .FontName        = "Tahoma"

*-- Linhas 328 a 345:
328:             .Visible         = .T.
329:         ENDWITH
330: 
331:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid da lista (codigos/datas/usuars/obss de SIGCDCNF)
334:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
335:         loc_oPg1.grd_4c_Lista.RecordSource = ""
336:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
337: 
338:         WITH loc_oPg1.grd_4c_Lista
339:             .Top                     = 117
340:             .Left                    = 12
341:             .Width                   = 890
342:             .Height                  = 480
343:             .FontName                = "Verdana"
344:             .FontSize                = 8
345:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 363 a 407:
363:             .Column2.ReadOnly        = .T.
364:             .Column3.ReadOnly        = .T.
365:             .Column4.ReadOnly        = .T.
366:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
367:             .Column2.Header1.Caption = "Data"
368:             .Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
369:             .Column4.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"
370:         ENDWITH
371: 
372:         THIS.TornarControlesVisiveis(loc_oPg1)
373:     ENDPROC
374: 
375:     *--------------------------------------------------------------------------
376:     * ConfigurarPaginaDados - Cria campos e grid de OPs da Page2
377:     * Layout preserva coordenadas do SCX legado (+29 por PageFrame.Top=-29)
378:     *--------------------------------------------------------------------------
379:     PROTECTED PROCEDURE ConfigurarPaginaDados()
380:         LOCAL loc_oPg2, loc_oBotoesAcao
381:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
382: 
383:         *-- Botoes Confirmar/Cancelar (Top=4+29=33)
384:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
385:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
386:         WITH loc_oBotoesAcao
387:             .Top         = 33
388:             .Left        = 842
389:             .Width       = 160
390:             .Height      = 85
391:             .BackStyle   = 0
392:             .BorderWidth = 0
393:             .Visible     = .T.
394:         ENDWITH
395: 
396:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
397:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
398:             .Caption         = "Confirmar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 5
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Tahoma"

*-- Linhas 416 a 430:
416:             .Visible         = .T.
417:         ENDWITH
418: 
419:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
420:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
421:             .Caption         = "Encerrar"
422:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
423:             .PicturePosition = 13
424:             .Top             = 5
425:             .Left            = 80
426:             .Width           = 75
427:             .Height          = 75
428:             .BackColor       = RGB(255, 255, 255)
429:             .ForeColor       = RGB(90, 90, 90)
430:             .FontName        = "Tahoma"

*-- Linhas 439 a 456:
439:             .Visible         = .T.
440:         ENDWITH
441: 
442:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
443:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
444: 
445:         *-- Linha 1: Cancelamento N? / getCodigos / Data / getDatas / Usuario / Getusu
446:         *-- Say2: Left=139, Top=162 ? +29 = 191
447:         loc_oPg2.AddObject("lbl_4c_LabelCod", "Label")
448:         WITH loc_oPg2.lbl_4c_LabelCod
449:             .Caption   = "Cancelamento N" + CHR(186) + " :"
450:             .Top       = 191
451:             .Left      = 139
452:             .Width     = 115
453:             .Height    = 17
454:             .AutoSize  = .F.
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8

*-- Linhas 465 a 474:
465:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
466:         WITH loc_oPg2.txt_4c_Codigos
467:             .Value         = 0
468:             .Top           = 186
469:             .Left          = 255
470:             .Width         = 52
471:             .Height        = 21
472:             .FontName      = "Tahoma"
473:             .FontSize      = 8
474:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 481 a 493:
481:         ENDWITH
482: 
483:         *-- Say3: "Data :" Left=358, Top=163 ? +29 = 192
484:         loc_oPg2.AddObject("lbl_4c_LabelData", "Label")
485:         WITH loc_oPg2.lbl_4c_LabelData
486:             .Caption   = "Data :"
487:             .Top       = 192
488:             .Left      = 330
489:             .Width     = 65
490:             .Height    = 17
491:             .AutoSize  = .F.
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8

*-- Linhas 502 a 511:
502:         loc_oPg2.AddObject("txt_4c_Datas", "TextBox")
503:         WITH loc_oPg2.txt_4c_Datas
504:             .Value         = DATE()
505:             .Top           = 186
506:             .Left          = 396
507:             .Width         = 90
508:             .Height        = 21
509:             .FontName      = "Tahoma"
510:             .FontSize      = 8
511:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 517 a 529:
517:         ENDWITH
518: 
519:         *-- Say1: "Usuario : " Left=497, Top=162 ? +29 = 191
520:         loc_oPg2.AddObject("lbl_4c_LabelUsu", "Label")
521:         WITH loc_oPg2.lbl_4c_LabelUsu
522:             .Caption   = "Usu" + CHR(225) + "rio :"
523:             .Top       = 191
524:             .Left      = 490
525:             .Width     = 62
526:             .Height    = 17
527:             .AutoSize  = .F.
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8

*-- Linhas 538 a 547:
538:         loc_oPg2.AddObject("txt_4c_Usuarios", "TextBox")
539:         WITH loc_oPg2.txt_4c_Usuarios
540:             .Value         = ""
541:             .Top           = 186
542:             .Left          = 552
543:             .Width         = 90
544:             .Height        = 21
545:             .FontName      = "Tahoma"
546:             .FontSize      = 8
547:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 554 a 566:
554: 
555:         *-- Linha 2: O.P. n? / Get_nop / Componentes: / Get_qtd (total tubos - readonly)
556:         *-- Say5: "O.P. n? : " Left=202, Top=203 ? +29 = 232
557:         loc_oPg2.AddObject("lbl_4c_LabelNop", "Label")
558:         WITH loc_oPg2.lbl_4c_LabelNop
559:             .Caption   = "O.P. n" + CHR(186) + " :"
560:             .Top       = 232
561:             .Left      = 202
562:             .Width     = 55
563:             .Height    = 17
564:             .AutoSize  = .F.
565:             .FontName  = "Tahoma"
566:             .FontSize  = 8

*-- Linhas 575 a 584:
575:         loc_oPg2.AddObject("txt_4c_Nop", "TextBox")
576:         WITH loc_oPg2.txt_4c_Nop
577:             .Value         = 0
578:             .Top           = 230
579:             .Left          = 255
580:             .Width         = 94
581:             .Height        = 21
582:             .FontName      = "Tahoma"
583:             .FontSize      = 8
584:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 591 a 603:
591:         ENDWITH
592: 
593:         *-- Say6: "Componentes:" Left=378, Top=202 ? +29 = 231
594:         loc_oPg2.AddObject("lbl_4c_LabelComp", "Label")
595:         WITH loc_oPg2.lbl_4c_LabelComp
596:             .Caption   = "Componentes:"
597:             .Top       = 231
598:             .Left      = 365
599:             .Width     = 100
600:             .Height    = 17
601:             .AutoSize  = .F.
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8

*-- Linhas 612 a 621:
612:         loc_oPg2.AddObject("txt_4c_Qtd", "TextBox")
613:         WITH loc_oPg2.txt_4c_Qtd
614:             .Value         = 0
615:             .Top           = 229
616:             .Left          = 467
617:             .Width         = 87
618:             .Height        = 21
619:             .FontName      = "Tahoma"
620:             .FontSize      = 8
621:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 629 a 641:
629: 
630:         *-- Linha 3: Qtde Cancelada / Get_QtTb / Qtd. Pecas / Get_pecas (readonly)
631:         *-- Say4: "Qtde Cancelada : " Left=152, Top=224 ? +29 = 253
632:         loc_oPg2.AddObject("lbl_4c_LabelQtd", "Label")
633:         WITH loc_oPg2.lbl_4c_LabelQtd
634:             .Caption   = "Qtde Cancelada :"
635:             .Top       = 253
636:             .Left      = 152
637:             .Width     = 105
638:             .Height    = 17
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8

*-- Linhas 650 a 659:
650:         loc_oPg2.AddObject("txt_4c_QtTb", "TextBox")
651:         WITH loc_oPg2.txt_4c_QtTb
652:             .Value         = 0
653:             .Top           = 251
654:             .Left          = 255
655:             .Width         = 94
656:             .Height        = 21
657:             .FontName      = "Tahoma"
658:             .FontSize      = 8
659:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 666 a 678:
666:         ENDWITH
667: 
668:         *-- Say7: "Qtd. Pecas :" Left=391, Top=223 ? +29 = 252
669:         loc_oPg2.AddObject("lbl_4c_LabelPecas", "Label")
670:         WITH loc_oPg2.lbl_4c_LabelPecas
671:             .Caption   = "Qtd. Pe" + CHR(231) + "as :"
672:             .Top       = 252
673:             .Left      = 365
674:             .Width     = 102
675:             .Height    = 17
676:             .AutoSize  = .F.
677:             .FontName  = "Tahoma"
678:             .FontSize  = 8

*-- Linhas 687 a 696:
687:         loc_oPg2.AddObject("txt_4c_Pecas", "TextBox")
688:         WITH loc_oPg2.txt_4c_Pecas
689:             .Value         = 0
690:             .Top           = 251
691:             .Left          = 467
692:             .Width         = 87
693:             .Height        = 21
694:             .FontName      = "Tahoma"
695:             .FontSize      = 8
696:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 708 a 717:
708:         loc_oPg2.grd_4c_Dados.ColumnCount = 4
709: 
710:         WITH loc_oPg2.grd_4c_Dados
711:             .Top                       = 277
712:             .Left                      = 203
713:             .Width                     = 381
714:             .Height                    = 208
715:             .FontName                  = "Verdana"
716:             .FontSize                  = 8
717:             .ForeColor                 = RGB(0, 0, 0)

*-- Linhas 742 a 772:
742:             .Column4.Movable           = .F.
743:             .Column3.InputMask         = "999,999.999"
744:             .Column4.InputMask         = "999,999.999"
745:             .Column1.Header1.Caption   = "O.P."
746:             .Column1.Header1.Alignment = 2
747:             .Column1.Header1.ForeColor = RGB(36, 84, 155)
748:             .Column2.Header1.Caption   = "Produto"
749:             .Column2.Header1.Alignment = 2
750:             .Column2.Header1.ForeColor = RGB(36, 84, 155)
751:             .Column3.Header1.Caption   = "Qtde Tubo"
752:             .Column3.Header1.Alignment = 2
753:             .Column3.Header1.ForeColor = RGB(36, 84, 155)
754:             .Column4.Header1.Caption   = "Qtde Canc."
755:             .Column4.Header1.Alignment = 2
756:             .Column4.Header1.ForeColor = RGB(36, 84, 155)
757:         ENDWITH
758: 
759:         *-- ApagaItem: Left=587, Top=329 ? +29 = 358; 40x40
760:         loc_oPg2.AddObject("cmd_4c_ApagaItem", "CommandButton")
761:         WITH loc_oPg2.cmd_4c_ApagaItem
762:             .Caption         = ""
763:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
764:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
765:             .PicturePosition = 0
766:             .Top             = 307
767:             .Left            = 587
768:             .Width           = 40
769:             .Height          = 40
770:             .FontName        = "Verdana"
771:             .FontSize        = 7
772:             .FontBold        = .F.

*-- Linhas 781 a 793:
781:         ENDWITH
782: 
783:         *-- Label Observacao: Left=178, Top=467 ? +29 = 496
784:         loc_oPg2.AddObject("lbl_4c_Observacao", "Label")
785:         WITH loc_oPg2.lbl_4c_Observacao
786:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
787:             .Top       = 498
788:             .Left      = 178
789:             .Width     = 120
790:             .Height    = 17
791:             .AutoSize  = .F.
792:             .FontName  = "Verdana"
793:             .FontSize  = 8

*-- Linhas 801 a 810:
801:         loc_oPg2.AddObject("obj_4c_Obs", "EditBox")
802:         WITH loc_oPg2.obj_4c_Obs
803:             .Value       = ""
804:             .Top         = 514
805:             .Left        = 178
806:             .Width       = 423
807:             .Height      = 56
808:             .FontName    = "Tahoma"
809:             .FontSize    = 8
810:             .ForeColor   = RGB(90, 90, 90)

*-- Linhas 816 a 865:
816: 
817:         BINDEVENT(loc_oPg2.txt_4c_Nop,      "KeyPress", THIS, "ValidarNop")
818:         BINDEVENT(loc_oPg2.txt_4c_QtTb,     "KeyPress", THIS, "ConfirmarQtd")
819:         BINDEVENT(loc_oPg2.cmd_4c_ApagaItem, "Click",   THIS, "ApagaItemClick")
820: 
821:         THIS.TornarControlesVisiveis(loc_oPg2)
822:     ENDPROC
823: 
824:     *--------------------------------------------------------------------------
825:     * CarregarLista - Busca cancelamentos e carrega grid da Page1
826:     *--------------------------------------------------------------------------
827:     PROCEDURE CarregarLista()
828:         LOCAL loc_lResultado, loc_oGrid
829:         loc_lResultado = .F.
830: 
831:         TRY
832:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
833:                 CREATE CURSOR cursor_4c_Dados (codigos N(6,0), datas D, usuars C(10), obss C(254))
834:                 loc_lResultado = .T.
835:             ELSE
836:                 IF THIS.this_oBusinessObject.Buscar("")
837:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
838:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
839: 
840:                         loc_oGrid.ColumnCount = 4
841:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
842:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
843:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.datas"
844:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.usuars"
845:                         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.obss"
846: 
847:                         loc_oGrid.Column1.Width = 70
848:                         loc_oGrid.Column2.Width = 140
849:                         loc_oGrid.Column3.Width = 120
850:                         loc_oGrid.Column4.Width = 490
851: 
852:                         loc_oGrid.Column1.ReadOnly = .T.
853:                         loc_oGrid.Column2.ReadOnly = .T.
854:                         loc_oGrid.Column3.ReadOnly = .T.
855:                         loc_oGrid.Column4.ReadOnly = .T.
856: 
857:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
858:                         loc_oGrid.Column2.Header1.Caption = "Data"
859:                         loc_oGrid.Column3.Header1.Caption = "Usu" + CHR(225) + "rio"
860:                         loc_oGrid.Column4.Header1.Caption = "Observa" + CHR(231) + CHR(245) + "es"
861: 
862:                         THIS.FormatarGridLista(loc_oGrid)
863:                     ENDIF
864:                     loc_lResultado = .T.
865:                 ENDIF

*-- Linhas 945 a 971:
945:     *--------------------------------------------------------------------------
946:     PROCEDURE BtnVisualizarClick()
947:         LOCAL loc_nCodigos, loc_lResultado
948:         loc_lResultado = .F.
949: 
950:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
951:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
952:             RETURN .F.
953:         ENDIF
954: 
955:         SELECT cursor_4c_Dados
956:         loc_nCodigos = cursor_4c_Dados.codigos
957: 
958:         TRY
959:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
960:                 THIS.this_oBusinessObject.CarregarItens(loc_nCodigos)
961:                 THIS.BOParaForm()
962:                 THIS.this_cModoAtual = "VISUALIZAR"
963:                 THIS.HabilitarCampos(.F.)
964:                 THIS.AjustarBotoesPorModo()
965:                 THIS.ConfigurarGridDados()
966:                 THIS.AlternarPagina(2)
967:                 loc_lResultado = .T.
968:             ENDIF
969:         CATCH TO loc_oErro
970:             MsgErro(loc_oErro.Message, "FormCAF.BtnVisualizarClick")
971:         ENDTRY

*-- Linhas 978 a 1004:
978:     *--------------------------------------------------------------------------
979:     PROCEDURE BtnAlterarClick()
980:         LOCAL loc_nCodigos, loc_lResultado
981:         loc_lResultado = .F.
982: 
983:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
984:             MsgAviso("Nenhum registro selecionado.", "Alterar")
985:             RETURN .F.
986:         ENDIF
987: 
988:         SELECT cursor_4c_Dados
989:         loc_nCodigos = cursor_4c_Dados.codigos
990: 
991:         TRY
992:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
993:                 THIS.this_oBusinessObject.EditarRegistro()
994:                 THIS.this_oBusinessObject.CarregarItens(loc_nCodigos)
995:                 THIS.BOParaForm()
996:                 THIS.this_cModoAtual = "ALTERAR"
997:                 THIS.HabilitarCampos(.T.)
998:                 THIS.AjustarBotoesPorModo()
999:                 THIS.ConfigurarGridDados()
1000:                 THIS.AlternarPagina(2)
1001:                 loc_lResultado = .T.
1002:             ENDIF
1003:         CATCH TO loc_oErro
1004:             MsgErro(loc_oErro.Message, "FormCAF.BtnAlterarClick")

*-- Linhas 1012 a 1038:
1012:     *--------------------------------------------------------------------------
1013:     PROCEDURE BtnExcluirClick()
1014:         LOCAL loc_nCodigos, loc_lResultado
1015:         loc_lResultado = .F.
1016: 
1017:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1018:             MsgAviso("Nenhum registro selecionado.", "Excluir")
1019:             RETURN .F.
1020:         ENDIF
1021: 
1022:         SELECT cursor_4c_Dados
1023:         loc_nCodigos = cursor_4c_Dados.codigos
1024: 
1025:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1026:             RETURN .F.
1027:         ENDIF
1028: 
1029:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cancelamento " + ;
1030:                         TRANSFORM(loc_nCodigos) + "?", "Excluir")
1031:             RETURN .F.
1032:         ENDIF
1033: 
1034:         TRY
1035:             IF THIS.this_oBusinessObject.Excluir()
1036:                 MsgInfo("Cancelamento exclu" + CHR(237) + "do com sucesso!")
1037:                 THIS.CarregarLista()
1038:                 loc_lResultado = .T.

*-- Linhas 1088 a 1110:
1088:             ELSE
1089:                 loc_nCodBusca = 0
1090:             ENDIF
1091:             THIS.this_cModoAtual = "LISTA"
1092:             THIS.AlternarPagina(1)
1093:             IF USED("cursor_4c_Dados") AND loc_nCodBusca > 0
1094:                 SELECT cursor_4c_Dados
1095:                 LOCATE FOR cursor_4c_Dados.codigos = loc_nCodBusca
1096:             ENDIF
1097:             RETURN .T.
1098:         ENDIF
1099: 
1100:         *-- Em INCLUIR/ALTERAR: exige ao menos um item com Qtds > 0
1101:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1102:             loc_cCursor   = THIS.this_oBusinessObject.this_cCursorOps
1103:             loc_lTemItens = .F.
1104:             IF USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
1105:                 SELECT (loc_cCursor)
1106:                 GO TOP
1107:                 DO WHILE !EOF(loc_cCursor)
1108:                     SELECT (loc_cCursor)
1109:                     IF Qtds > 0
1110:                         loc_lTemItens = .T.

*-- Linhas 1266 a 1274:
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * ApagaItemClick - Remove item selecionado no grid do cursor de OPs
1269:     * Ativado por BINDEVENT Click em cmd_4c_ApagaItem
1270:     *--------------------------------------------------------------------------
1271:     PROCEDURE ApagaItemClick()
1272:         LOCAL loc_cCursor, loc_oPg2
1273:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorOps
1274:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1402 a 1411:
1402:                 loc_oPg2.txt_4c_QtTb.ReadOnly = !loc_lEditMode
1403:             ENDIF
1404:             *-- Botao apagar item: apenas em INCLUIR/ALTERAR
1405:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ApagaItem", 5)
1406:                 loc_oPg2.cmd_4c_ApagaItem.Enabled = loc_lEditMode
1407:             ENDIF
1408:             *-- Observacao: editavel em INCLUIR/ALTERAR
1409:             IF PEMSTATUS(loc_oPg2, "obj_4c_Obs", 5)
1410:                 loc_oPg2.obj_4c_Obs.Enabled  = loc_lEditMode
1411:                 loc_oPg2.obj_4c_Obs.ReadOnly = !loc_lEditMode

*-- Linhas 1423 a 1432:
1423:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1424: 
1425:         TRY
1426:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1427:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1428:         CATCH TO loc_oErro
1429:             MsgErro(loc_oErro.Message, "FormCAF.AjustarBotoesPorModo")
1430:         ENDTRY
1431:     ENDPROC
1432: 

*-- Linhas 1478 a 1493:
1478:                 IF USED(loc_cCursor)
1479:                     USE IN (loc_cCursor)
1480:                 ENDIF
1481:                 THIS.this_oBusinessObject = .NULL.
1482:             ENDIF
1483:             IF USED("cursor_4c_Dados")
1484:                 USE IN cursor_4c_Dados
1485:             ENDIF
1486:         CATCH TO loc_oErro
1487:             MsgErro(loc_oErro.Message, "FormCAF.Destroy")
1488:         ENDTRY
1489: 
1490:         DODEFAULT()
1491:     ENDPROC
1492: 
1493: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CAFBO.prg):
*====================================================================
* CAFBO.prg
* Business Object para Cancelamento de OP da Fundicao
* Tabela principal : SIGCDCNF
* Tabelas secundarias: SigCdCaf (itens), SigOpPic (ordens afetadas)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CAFBO AS BusinessBase

	*-- Propriedades da entidade principal (SIGCDCNF)
	this_nCodigos   = 0     && codigos numeric(6,0) - PK auto-gerado
	this_dDatas     = {}    && datas datetime NULL - data do cancelamento
	this_cEmps      = ""    && emps char(3) - codigo da empresa
	this_cObss      = ""    && obss text NULL - observacoes
	this_cUsuars    = ""    && usuars char(10) - usuario que registrou

	*-- Nome do cursor de trabalho das OPs a cancelar (equivalente ao TmpNop legado)
	*-- Campos: Nops n(10), Cpros c(14), Qtds n(10,3), Qtdos n(10,3), nFunds n(6), DtFunds d
	this_cCursorOps = "cursor_4c_OpsCanc"

	*-- Dados retornados por ValidarOP para uso do Form
	this_nUltimaOpQtdTubos = 0
	this_nUltimaOpQtdPecas = 0
	this_nUltimaOpNFunds   = 0
	this_dUltimaOpDtFunds  = {}
	this_cUltimaOpCpros    = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCNF"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Lista cancelamentos da empresa atual para o grid da Page1
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF
			loc_cSQL = "SELECT codigos, datas, usuars," + ;
				" CAST(obss AS VARCHAR(500)) AS obss" + ;
				" FROM SIGCDCNF" + ;
				" WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
				" ORDER BY codigos DESC"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResult > 0
				GO TOP IN cursor_4c_Dados
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cancelamentos: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Buscar")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega cancelamento pelo codigo PK
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
			loc_cSQL = "SELECT codigos, datas, emps, usuars," + ;
				" CAST(obss AS VARCHAR(4000)) AS obss" + ;
				" FROM SIGCDCNF WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				GO TOP IN cursor_4c_Carrega
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				IF loc_lSucesso
					THIS.this_lNovoRegistro = .F.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.CarregarPorCodigo")
		ENDTRY
		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia cursor para propriedades do BO
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos  = TratarNulo(codigos, "N")
			THIS.this_dDatas    = TratarNulo(datas,   "D")
			THIS.this_cEmps     = ALLTRIM(TratarNulo(emps,   "C"))
			THIS.this_cObss     = ALLTRIM(TratarNulo(obss,   "C"))
			THIS.this_cUsuars   = ALLTRIM(TratarNulo(usuars, "C"))
			loc_lSucesso = .T.
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursorOps - Cria cursor vazio para edicao de OPs
	* Equivalente ao CREATE CURSOR TmpNop do original
	*====================================================================
	PROCEDURE InicializarCursorOps()
		LOCAL loc_cCursor, loc_lSucesso
		loc_cCursor = THIS.this_cCursorOps
		loc_lSucesso = .F.
		TRY
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			SET NULL ON
			CREATE CURSOR (loc_cCursor) ;
				(Nops N(10), Cpros C(14), Qtds N(10,3), Qtdos N(10,3), nFunds N(6), DtFunds D)
			SET NULL OFF
			INDEX ON Nops TAG Nops
			loc_lSucesso = .T.
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.InicializarCursorOps")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarItens - Carrega itens de SigCdCaf para cursor_4c_OpsCanc
	* Usado ao selecionar registro para ALTERAR/CONSULTAR/EXCLUIR
	* Qtdos = qtdtubos atual em SigOpPic + qtds ja cancelados (= original disponivel)
	*====================================================================
	PROCEDURE CarregarItens(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cCursor
		LOCAL loc_nNops, loc_cCpros, loc_nQtds, loc_nQtdos
		LOCAL loc_nFunds, loc_dDtFunds
		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorOps

		TRY
			IF USED(loc_cCursor)
				USE IN (loc_cCursor)
			ENDIF
			IF USED("cursor_4c_ItemsTemp")
				USE IN cursor_4c_ItemsTemp
			ENDIF

			loc_cSQL = "SELECT a.nops," + ;
				" (SELECT TOP 1 cpros FROM SigOpPic WHERE nops = a.nops) AS cpros," + ;
				" a.qtds," + ;
				" ISNULL((SELECT SUM(qtdtubos) FROM SigOpPic WHERE nops = a.nops),0)" + ;
				" + a.qtds AS qtdos," + ;
				" a.nfunds, a.dtfunds" + ;
				" FROM SigCdCaf a" + ;
				" WHERE a.codigos = " + FormatarNumeroSQL(par_nCodigos)

			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItemsTemp")

			IF loc_nResult > 0
				SET NULL ON
				CREATE CURSOR (loc_cCursor) ;
					(Nops N(10), Cpros C(14), Qtds N(10,3), Qtdos N(10,3), nFunds N(6), DtFunds D)
				SET NULL OFF
				INDEX ON Nops TAG Nops

				IF RECCOUNT("cursor_4c_ItemsTemp") > 0
					SELECT cursor_4c_ItemsTemp
					GO TOP
					DO WHILE !EOF("cursor_4c_ItemsTemp")
						SELECT cursor_4c_ItemsTemp
						loc_nNops    = cursor_4c_ItemsTemp.nops
						loc_cCpros   = ALLTRIM(NVL(cursor_4c_ItemsTemp.cpros, ""))
						loc_nQtds    = NVL(cursor_4c_ItemsTemp.qtds, 0)
						loc_nQtdos   = NVL(cursor_4c_ItemsTemp.qtdos, 0)
						loc_nFunds   = NVL(cursor_4c_ItemsTemp.nfunds, 0)
						loc_dDtFunds = cursor_4c_ItemsTemp.dtfunds

						SELECT (loc_cCursor)
						APPEND BLANK
						REPLACE Nops    WITH loc_nNops
						REPLACE Cpros   WITH loc_cCpros
						REPLACE Qtds    WITH loc_nQtds
						REPLACE Qtdos   WITH loc_nQtdos
						REPLACE nFunds  WITH loc_nFunds
						REPLACE DtFunds WITH loc_dDtFunds

						SKIP IN cursor_4c_ItemsTemp
					ENDDO
				ENDIF

				SELECT (loc_cCursor)
				GO TOP
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar itens: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.CarregarItens")
		ENDTRY

		IF USED("cursor_4c_ItemsTemp")
			USE IN cursor_4c_ItemsTemp
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarOP - Valida OP e popula propriedades this_nUltimaOp*
	* Equivalente ao evento Valid de Get_nop no legado
	* Retorna .T. se OP valida e tem qtdtubos disponivel
	*====================================================================
	PROCEDURE ValidarOP(par_nNops)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nQtdT, loc_nQtdP, loc_nFunds, loc_dDtFunds, loc_cCpros
		loc_lSucesso = .F.
		THIS.this_nUltimaOpQtdTubos = 0
		THIS.this_nUltimaOpQtdPecas = 0
		THIS.this_nUltimaOpNFunds   = 0
		THIS.this_dUltimaOpDtFunds  = {}
		THIS.this_cUltimaOpCpros    = ""

		TRY
			IF par_nNops <= 0
				MsgAviso("OP inv" + CHR(225) + "lida!", "")
			ELSE
				IF USED("cursor_4c_OPValida")
					USE IN cursor_4c_OPValida
				ENDIF

				loc_cSQL = "SELECT nops, cpros, emps, qtdtubos," + ;
					" qtdcpnts, qtds, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops)

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPValida")

				IF loc_nResult > 0 AND RECCOUNT("cursor_4c_OPValida") > 0
					SELECT cursor_4c_OPValida
					GO TOP
					IF ALLTRIM(cursor_4c_OPValida.emps) == ALLTRIM(go_4c_Sistema.cCodEmpresa)
						loc_nQtdT    = 0
						loc_nQtdP    = 0
						loc_cCpros   = ALLTRIM(cursor_4c_OPValida.cpros)
						loc_nFunds   = NVL(cursor_4c_OPValida.nfunds, 0)
						loc_dDtFunds = cursor_4c_OPValida.dtfunds

						DO WHILE !EOF("cursor_4c_OPValida")
							SELECT cursor_4c_OPValida
							loc_nQtdT = loc_nQtdT + NVL(cursor_4c_OPValida.qtdtubos, 0)
							loc_nQtdP = loc_nQtdP + NVL(cursor_4c_OPValida.qtds, 0)
							SKIP IN cursor_4c_OPValida
						ENDDO

						IF loc_nQtdT <= 0
							MsgAviso("Nenhum Componente com Processo de Fundi" + CHR(231) + CHR(227) + "o!", "")
						ELSE
							THIS.this_nUltimaOpQtdTubos = loc_nQtdT
							THIS.this_nUltimaOpQtdPecas = loc_nQtdP
							THIS.this_nUltimaOpNFunds   = loc_nFunds
							THIS.this_dUltimaOpDtFunds  = loc_dDtFunds
							THIS.this_cUltimaOpCpros    = loc_cCpros
							loc_lSucesso = .T.
						ENDIF
					ELSE
						MsgAviso("OP n" + CHR(227) + "o encontrada!", "")
					ENDIF
				ELSE
					MsgAviso("OP n" + CHR(227) + "o encontrada!", "")
				ENDIF

				IF USED("cursor_4c_OPValida")
					USE IN cursor_4c_OPValida
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.ValidarOP")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Gera proximo codigo unico para SIGCDCNF
	* Equivalente ao fGerUniqueKey('SigCdCnf') do legado
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo()
		LOCAL loc_cSQL, loc_nResult, loc_nCodigo
		loc_nCodigo = 0
		TRY
			IF USED("cursor_4c_MaxCod")
				USE IN cursor_4c_MaxCod
			ENDIF
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS ProxCod FROM SIGCDCNF"
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxCod")
			IF loc_nResult > 0 AND RECCOUNT("cursor_4c_MaxCod") > 0
				SELECT cursor_4c_MaxCod
				GO TOP
				loc_nCodigo = NVL(cursor_4c_MaxCod.ProxCod, 1)
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.GerarProximoCodigo")
		ENDTRY
		IF USED("cursor_4c_MaxCod")
			USE IN cursor_4c_MaxCod
		ENDIF
		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* GerarCidChavesCAF - Gera cidchaves unico para linha de SigCdCaf
	* Formato: codigos (10 digitos zero-padded) + nops (10 digitos zero-padded)
	*====================================================================
	PROTECTED PROCEDURE GerarCidChavesCAF(par_nCodigos, par_nNops)
		LOCAL loc_cChave
		loc_cChave = PADL(ALLTRIM(STR(par_nCodigos, 10)), 10, "0") + ;
			PADL(ALLTRIM(STR(par_nNops, 10)), 10, "0")
		RETURN loc_cChave
	ENDPROC

	*====================================================================
	* AtualizarOpsCancelamento - Reduz qtdtubos em SigOpPic (ao cancelar)
	* Percorre linhas da OP por nops+cpros e reduz qtdtubos ate esgotar lnQtd
	*====================================================================
	PROTECTED PROCEDURE AtualizarOpsCancelamento(par_nNops, par_nQtds)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nQtdRestante
		LOCAL loc_nQtdTubos, loc_nNovoQtd, loc_cCpros
		loc_lSucesso = .F.
		TRY
			IF par_nQtds <= 0
				loc_lSucesso = .T.
			ELSE
				IF USED("cursor_4c_OPRows")
					USE IN cursor_4c_OPRows
				ENDIF
				loc_cSQL = "SELECT cpros, qtdtubos, qtdcpnts, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
					" ORDER BY cpros"
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPRows")
				IF loc_nResult > 0
					loc_nQtdRestante = par_nQtds
					loc_lSucesso     = .T.
					SELECT cursor_4c_OPRows
					GO TOP
					DO WHILE !EOF("cursor_4c_OPRows") AND loc_nQtdRestante > 0
						SELECT cursor_4c_OPRows
						loc_nQtdTubos = NVL(cursor_4c_OPRows.qtdtubos, 0)
						loc_cCpros    = ALLTRIM(cursor_4c_OPRows.cpros)

						IF loc_nQtdTubos <= loc_nQtdRestante
							loc_nQtdRestante = loc_nQtdRestante - loc_nQtdTubos
							loc_nNovoQtd     = 0
						ELSE
							loc_nNovoQtd     = loc_nQtdTubos - loc_nQtdRestante
							loc_nQtdRestante = 0
						ENDIF

						loc_cSQL = "UPDATE SigOpPic SET qtdtubos = " + ;
							FormatarNumeroSQL(loc_nNovoQtd) + ;
							" WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
							" AND cpros = " + EscaparSQL(loc_cCpros)

						IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
							MsgErro("Erro ao atualizar SigOpPic (OP " + ;
								TRANSFORM(par_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
							EXIT
						ENDIF

						SKIP IN cursor_4c_OPRows
					ENDDO

					IF USED("cursor_4c_OPRows")
						USE IN cursor_4c_OPRows
					ENDIF
				ELSE
					MsgErro("Erro ao buscar linhas da OP " + ;
						TRANSFORM(par_nNops) + ": " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.AtualizarOpsCancelamento")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestaurarOpsCancelamento - Restaura qtdtubos em SigOpPic (ao desfazer)
	* Adiciona de volta ate qtdcpnts (maximo) ou ate esgotar a quantidade
	*====================================================================
	PROTECTED PROCEDURE RestaurarOpsCancelamento(par_nNops, par_nQtds)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nQtdRestante
		LOCAL loc_nQtdTubos, loc_nQtdCpnts, loc_nNovoQtd, loc_nDiff, loc_cCpros
		loc_lSucesso = .F.
		TRY
			IF par_nQtds <= 0
				loc_lSucesso = .T.
			ELSE
				IF USED("cursor_4c_OPRowsR")
					USE IN cursor_4c_OPRowsR
				ENDIF
				loc_cSQL = "SELECT cpros, qtdtubos, qtdcpnts, nfunds, dtfunds" + ;
					" FROM SigOpPic WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
					" ORDER BY cpros"
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OPRowsR")
				IF loc_nResult > 0
					loc_nQtdRestante = par_nQtds
					loc_lSucesso     = .T.
					SELECT cursor_4c_OPRowsR
					GO TOP
					DO WHILE !EOF("cursor_4c_OPRowsR") AND loc_nQtdRestante > 0
						SELECT cursor_4c_OPRowsR
						loc_nQtdTubos = NVL(cursor_4c_OPRowsR.qtdtubos, 0)
						loc_nQtdCpnts = NVL(cursor_4c_OPRowsR.qtdcpnts, 0)
						loc_cCpros    = ALLTRIM(cursor_4c_OPRowsR.cpros)

						*-- Espaco disponivel para restaurar nesta linha
						loc_nDiff = loc_nQtdCpnts - loc_nQtdTubos
						IF loc_nDiff <= 0
							SKIP IN cursor_4c_OPRowsR
							LOOP
						ENDIF

						IF loc_nDiff <= loc_nQtdRestante
							loc_nQtdRestante = loc_nQtdRestante - loc_nDiff
							loc_nNovoQtd     = loc_nQtdCpnts  && Restaura ao maximo
						ELSE
							loc_nNovoQtd     = loc_nQtdTubos + loc_nQtdRestante
							loc_nQtdRestante = 0
						ENDIF

						loc_cSQL = "UPDATE SigOpPic SET qtdtubos = " + ;
							FormatarNumeroSQL(loc_nNovoQtd) + ;
							" WHERE nops = " + FormatarNumeroSQL(par_nNops) + ;
							" AND cpros = " + EscaparSQL(loc_cCpros)

						IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
							MsgErro("Erro ao restaurar SigOpPic (OP " + ;
								TRANSFORM(par_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
							EXIT
						ENDIF

						SKIP IN cursor_4c_OPRowsR
					ENDDO

					IF USED("cursor_4c_OPRowsR")
						USE IN cursor_4c_OPRowsR
					ENDIF
				ELSE
					MsgErro("Erro ao buscar linhas da OP para restaurar " + ;
						TRANSFORM(par_nNops) + ": " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.RestaurarOpsCancelamento")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* RestaurarItensCancelamento - Carrega SigCdCaf e restaura SigOpPic
	* Usado antes de ALTERAR (para rebuild) e em ExecutarExclusao
	*====================================================================
	PROTECTED PROCEDURE RestaurarItensCancelamento(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nNops, loc_nQtds
		loc_lSucesso = .F.
		TRY
			IF USED("cursor_4c_ItensAntigos")
				USE IN cursor_4c_ItensAntigos
			ENDIF
			loc_cSQL = "SELECT nops, qtds FROM SigCdCaf" + ;
				" WHERE codigos = " + FormatarNumeroSQL(par_nCodigos)
			loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensAntigos")
			IF loc_nResult > 0
				loc_lSucesso = .T.
				SELECT cursor_4c_ItensAntigos
				GO TOP
				DO WHILE !EOF("cursor_4c_ItensAntigos") AND loc_lSucesso
					SELECT cursor_4c_ItensAntigos
					loc_nNops = cursor_4c_ItensAntigos.nops
					loc_nQtds = NVL(cursor_4c_ItensAntigos.qtds, 0)

					IF loc_nNops > 0 AND loc_nQtds > 0
						IF !THIS.RestaurarOpsCancelamento(loc_nNops, loc_nQtds)
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SKIP IN cursor_4c_ItensAntigos
				ENDDO
			ELSE
				MsgErro("Erro ao carregar itens para restaurar: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.RestaurarItensCancelamento")
			loc_lSucesso = .F.
		ENDTRY
		IF USED("cursor_4c_ItensAntigos")
			USE IN cursor_4c_ItensAntigos
		ENDIF
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InserirItensCancelamento - Insere itens do cursor em SigCdCaf
	* e atualiza SigOpPic reduzindo qtdtubos
	* Pula linhas com Nops=0 ou Qtds=0 (marcadores invalidos)
	*====================================================================
	PROTECTED PROCEDURE InserirItensCancelamento(par_nCodigos)
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		LOCAL loc_nNops, loc_nQtds, loc_nFunds, loc_dDtFunds, loc_cCidChaves
		LOCAL loc_cCursor
		loc_lSucesso = .F.
		loc_cCursor  = THIS.this_cCursorOps

		TRY
			IF !USED(loc_cCursor)
				MsgErro("Cursor de OPs n" + CHR(227) + "o encontrado: " + loc_cCursor, "Erro")
			ELSE
				loc_lSucesso = .T.
				SELECT (loc_cCursor)
				GO TOP
				DO WHILE !EOF(loc_cCursor) AND loc_lSucesso
					SELECT (loc_cCursor)
					loc_nNops    = Nops
					loc_nQtds    = Qtds
					loc_nFunds   = NVL(nFunds, 0)
					loc_dDtFunds = DtFunds

					SKIP IN (loc_cCursor)

					IF DELETED() OR loc_nNops <= 0 OR loc_nQtds <= 0
						LOOP
					ENDIF

					*-- Gera cidchaves unico para SigCdCaf
					loc_cCidChaves = THIS.GerarCidChavesCAF(par_nCodigos, loc_nNops)

					*-- INSERT em SigCdCaf
					loc_cSQL = "INSERT INTO SigCdCaf" + ;
						" (codigos, nops, qtds, nfunds, dtfunds, cidchaves)" + ;
						" VALUES (" + ;
						FormatarNumeroSQL(par_nCodigos) + ", " + ;
						FormatarNumeroSQL(loc_nNops) + ", " + ;
						FormatarNumeroSQL(loc_nQtds) + ", " + ;
						FormatarNumeroSQL(loc_nFunds) + ", " + ;
						IIF(EMPTY(loc_dDtFunds), "NULL", FormatarDataSQL(loc_dDtFunds)) + ", " + ;
						EscaparSQL(loc_cCidChaves) + ;
						")"

					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult < 0
						MsgErro("Erro ao inserir item de cancelamento (OP " + ;
							TRANSFORM(loc_nNops) + "): " + CapturarErroSQL(), "Erro SQL")
						loc_lSucesso = .F.
					ELSE
						*-- Atualiza SigOpPic reduzindo qtdtubos
						IF !THIS.AtualizarOpsCancelamento(loc_nNops, loc_nQtds)
							loc_lSucesso = .F.
						ENDIF
					ENDIF
				ENDDO
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.InserirItensCancelamento")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SIGCDCNF + SigCdCaf + atualiza SigOpPic
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_nCodigos
		loc_lSucesso = .F.
		TRY
			loc_nCodigos = THIS.GerarProximoCodigo()
			IF loc_nCodigos <= 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo de cancelamento.", "Erro")
			ELSE
				THIS.this_nCodigos = loc_nCodigos
				THIS.this_cEmps    = go_4c_Sistema.cCodEmpresa
				THIS.this_cUsuars  = gc_4c_UsuarioLogado

				loc_cSQL = "INSERT INTO SIGCDCNF (codigos, datas, emps, usuars, obss)" + ;
					" VALUES (" + ;
					FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
					"GETDATE(), " + ;
					EscaparSQL(THIS.this_cEmps) + ", " + ;
					EscaparSQL(THIS.this_cUsuars) + ", " + ;
					EscaparSQL(THIS.this_cObss) + ;
					")"

				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult >= 0
					loc_lSucesso = THIS.InserirItensCancelamento(THIS.this_nCodigos)
					IF loc_lSucesso
						THIS.RegistrarAuditoria("INSERT")
					ENDIF
				ELSE
					MsgErro("Erro ao inserir cancelamento: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Inserir")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE SIGCDCNF + rebuild SigCdCaf + atualiza SigOpPic
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			*-- 1. Restaura SigOpPic com base nos itens anteriores de SigCdCaf
			IF !THIS.RestaurarItensCancelamento(THIS.this_nCodigos)
				MsgErro("Erro ao restaurar OPs para altera" + CHR(231) + CHR(227) + "o.", "Erro")
			ELSE
				*-- 2. Remove itens antigos de SigCdCaf
				loc_cSQL = "DELETE FROM SigCdCaf WHERE codigos = " + ;
					FormatarNumeroSQL(THIS.this_nCodigos)
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult < 0
					MsgErro("Erro ao remover itens antigos: " + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Re-insere itens do cursor + atualiza SigOpPic
					IF THIS.InserirItensCancelamento(THIS.this_nCodigos)
						*-- 4. UPDATE no cabecalho SIGCDCNF
						loc_cSQL = "UPDATE SIGCDCNF SET" + ;
							" datas = GETDATE()," + ;
							" usuars = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
							" obss = " + EscaparSQL(THIS.this_cObss) + ;
							" WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)
						loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResult >= 0
							THIS.RegistrarAuditoria("UPDATE")
							loc_lSucesso = .T.
						ELSE
							MsgErro("Erro ao atualizar cabe" + CHR(231) + "alho: " + ;
								CapturarErroSQL(), "Erro SQL")
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.Atualizar")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Restaura OPs e exclui cancelamento em cascata
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResult, loc_lSucesso
		loc_lSucesso = .F.
		TRY
			*-- 1. Restaura SigOpPic a partir dos itens de SigCdCaf
			IF !THIS.RestaurarItensCancelamento(THIS.this_nCodigos)
				MsgErro("Erro ao restaurar OPs para exclus" + CHR(227) + "o.", "Erro")
			ELSE
				*-- 2. Remove itens de SigCdCaf
				loc_cSQL = "DELETE FROM SigCdCaf WHERE codigos = " + ;
					FormatarNumeroSQL(THIS.this_nCodigos)
				loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResult < 0
					MsgErro("Erro ao excluir itens: " + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Remove cabecalho SIGCDCNF
					loc_cSQL = "DELETE FROM SIGCDCNF WHERE codigos = " + ;
						FormatarNumeroSQL(THIS.this_nCodigos)
					loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResult >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cancelamento: " + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MostrarErro(loc_oErro, "CAFBO.ExecutarExclusao")
			loc_lSucesso = .F.
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

