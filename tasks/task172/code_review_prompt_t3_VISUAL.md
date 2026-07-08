# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2878 linhas total):

*-- Linhas 39 a 59:
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.Caption = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
43: 
44:             THIS.this_oBusinessObject = CREATEOBJECT("sigprdisBO")
45: 
46:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
47:                 MsgErro("Erro ao criar Business Object sigprdisBO." + CHR(13) + ;
48:                          "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
49:                          "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52:                 THIS.ConfigurarPaginaLista()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.ConfigurarPaginaDados()
56: 
57:                 THIS.pgf_4c_Paginas.Visible = .T.
58:                 THIS.pgf_4c_Paginas.ActivePage = 1
59:                 THIS.this_cModoAtual = "LISTA"

*-- Linhas 80 a 96:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount       = 2
83:             .Top             = -29
84:             .Left            = 0
85:             .Width           = THIS.Width
86:             .Height          = THIS.Height + 29
87:             .Tabs            = .F.
88:             .Visible         = .T.
89:             .Page1.Caption   = "Lista"
90:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
91:             .Page2.Caption   = "Dados"
92:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page1.BackColor = RGB(224, 224, 224)
94:             .Page2.BackColor = RGB(224, 224, 224)
95:         ENDWITH
96:     ENDPROC

*-- Linhas 108 a 145:
108:         *-- Cabecalho cinza escuro (cntSombra no legado)
109:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH loc_oPagina.cnt_4c_Cabecalho
111:             .Top         = 31
112:             .Left        = 0
113:             .Width       = THIS.Width
114:             .Height      = 80
115:             .BackColor   = RGB(100, 100, 100)
116:             .BorderWidth = 0
117:             .Visible     = .T.
118:         ENDWITH
119: 
120:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
121:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
122:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
123:             .Top       = 15
124:             .Left      = 12
125:             .Width     = THIS.Width - 20
126:             .Height    = 40
127:             .AutoSize  = .F.
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .Visible   = .T.
134:         ENDWITH
135: 
136:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
137:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
138:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
139:             .Top       = 18
140:             .Left      = 10
141:             .Width     = THIS.Width - 20
142:             .Height    = 46
143:             .AutoSize  = .F.
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16

*-- Linhas 152 a 178:
152:         *-- Botoes CRUD lado direito (Grupo_Op no legado: Left=542)
153:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
154:         WITH loc_oPagina.cnt_4c_Botoes
155:             .Top         = 29
156:             .Left        = 542
157:             .Width       = 390
158:             .Height      = 85
159:             .BackStyle   = 1
160:             .BackColor   = RGB(53, 53, 53)
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
166: 
167:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
168:         WITH loc_oCnt.cmd_4c_Incluir
169:             .Caption         = "Incluir"
170:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
171:             .PicturePosition = 13
172:             .Top             = 5
173:             .Left            = 5
174:             .Width           = 75
175:             .Height          = 75
176:             .FontName        = "Tahoma"
177:             .FontBold        = .T.
178:             .FontItalic      = .T.

*-- Linhas 187 a 201:
187:             .Visible         = .T.
188:         ENDWITH
189: 
190:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
191:         WITH loc_oCnt.cmd_4c_Visualizar
192:             .Caption         = "Visualizar"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
194:             .PicturePosition = 13
195:             .Top             = 5
196:             .Left            = 80
197:             .Width           = 75
198:             .Height          = 75
199:             .FontName        = "Tahoma"
200:             .FontBold        = .T.
201:             .FontItalic      = .T.

*-- Linhas 210 a 224:
210:             .Visible         = .T.
211:         ENDWITH
212: 
213:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
214:         WITH loc_oCnt.cmd_4c_Alterar
215:             .Caption         = "Alterar"
216:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
217:             .PicturePosition = 13
218:             .Top             = 5
219:             .Left            = 155
220:             .Width           = 75
221:             .Height          = 75
222:             .FontName        = "Tahoma"
223:             .FontBold        = .T.
224:             .FontItalic      = .T.

*-- Linhas 233 a 247:
233:             .Visible         = .T.
234:         ENDWITH
235: 
236:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
237:         WITH loc_oCnt.cmd_4c_Excluir
238:             .Caption         = "Excluir"
239:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
240:             .PicturePosition = 13
241:             .Top             = 5
242:             .Left            = 230
243:             .Width           = 75
244:             .Height          = 75
245:             .FontName        = "Tahoma"
246:             .FontBold        = .T.
247:             .FontItalic      = .T.

*-- Linhas 256 a 270:
256:             .Visible         = .T.
257:         ENDWITH
258: 
259:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
260:         WITH loc_oCnt.cmd_4c_Buscar
261:             .Caption         = "Buscar"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 305
266:             .Width           = 75
267:             .Height          = 75
268:             .FontName        = "Tahoma"
269:             .FontBold        = .T.
270:             .FontItalic      = .T.

*-- Linhas 282 a 306:
282:         *-- Container Encerrar - padrao canonico (Left=917 prevalece sobre SCX legado)
283:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
284:         WITH loc_oPagina.cnt_4c_Saida
285:             .Top         = 29
286:             .Left        = 917
287:             .Width       = 90
288:             .Height      = 85
289:             .BackStyle = 1
290:             .BackColor = RGB(255, 255, 255)
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294: 
295:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
296:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
297:             .Caption         = "Encerrar"
298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
299:             .PicturePosition = 13
300:             .Top             = 5
301:             .Left            = 5
302:             .Width           = 75
303:             .Height          = 75
304:             .FontName        = "Tahoma"
305:             .FontBold        = .T.
306:             .FontItalic      = .T.

*-- Linhas 315 a 373:
315:             .Visible         = .T.
316:         ENDWITH
317: 
318:         *-- Filtro de periodo (Label1.Top=89, Dt_inicial.Top=108, com compensacao +29)
319:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
320:         WITH loc_oPagina.lbl_4c_Periodo
321:             .Caption   = "Per" + CHR(237) + "odo :"
322:             .Top       = 118
323:             .Left      = 35
324:             .Width     = 45
325:             .Height    = 15
326:             .FontName  = "Tahoma"
327:             .FontSize  = 8
328:             .ForeColor = RGB(90, 90, 90)
329:             .BackStyle = 0
330:             .Visible   = .T.
331:         ENDWITH
332: 
333:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
334:         WITH loc_oPagina.txt_4c_DtInicial
335:             .Value       = DATE()
336:             .Top         = 137
337:             .Left        = 103
338:             .Width       = 80
339:             .Height      = 22
340:             .FontName    = "Tahoma"
341:             .FontSize    = 8
342:             .InputMask   = "99/99/9999"
343:             .Format      = "D"
344:             .BackColor   = RGB(255, 255, 255)
345:             .ForeColor   = RGB(0, 0, 0)
346:             .BorderStyle = 1
347:             .Visible     = .T.
348:         ENDWITH
349: 
350:         loc_oPagina.AddObject("lbl_4c_Separador", "Label")
351:         WITH loc_oPagina.lbl_4c_Separador
352:             .Caption   = "a"
353:             .Top       = 141
354:             .Left      = 190
355:             .Width     = 10
356:             .Height    = 15
357:             .FontName  = "Tahoma"
358:             .FontSize  = 8
359:             .ForeColor = RGB(90, 90, 90)
360:             .BackStyle = 0
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         loc_oPagina.AddObject("txt_4c_DtFinal", "TextBox")
365:         WITH loc_oPagina.txt_4c_DtFinal
366:             .Value       = DATE()
367:             .Top         = 137
368:             .Left        = 206
369:             .Width       = 80
370:             .Height      = 22
371:             .FontName    = "Tahoma"
372:             .FontSize    = 8
373:             .InputMask   = "99/99/9999"

*-- Linhas 383 a 392:
383:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
384: 
385:         WITH loc_oPagina.grd_4c_Lista
386:             .Top                = 165
387:             .Left               = 24
388:             .Width              = 900
389:             .Height             = 420
390:             .FontName           = "Verdana"
391:             .FontSize           = 8
392:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 401 a 421:
401:             .ScrollBars         = 2
402:             .GridLines          = 3
403:             .Visible            = .T.
404:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
405:             .Column1.Width           = 150
406:             .Column2.Header1.Caption = "Data"
407:             .Column2.Width           = 150
408:         ENDWITH
409: 
410:         *-- BINDEVENTs
411:         BINDEVENT(loc_oCnt.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
412:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
413:         BINDEVENT(loc_oCnt.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
414:         BINDEVENT(loc_oCnt.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
415:         BINDEVENT(loc_oCnt.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
416:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
417:         BINDEVENT(loc_oPagina.txt_4c_DtInicial, "LostFocus",     THIS, "DtInicialValid")
418:         BINDEVENT(loc_oPagina.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
419: 
420:         THIS.TornarControlesVisiveis(loc_oPagina)
421:     ENDPROC

*-- Linhas 433 a 458:
433:         *-- Botoes Confirmar/Cancelar (Grupo_Salva no legado: Left=842)
434:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
435:         WITH loc_oPagina.cnt_4c_BotoesAcao
436:             .Top         = 33
437:             .Left        = 842
438:             .Width       = 160
439:             .Height      = 85
440:             .BackStyle   = 0
441:             .BorderWidth = 0
442:             .Visible     = .T.
443:         ENDWITH
444: 
445:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
446: 
447:         loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
448:         WITH loc_oCnt.cmd_4c_Salvar
449:             .Caption         = "Confirmar"
450:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
451:             .PicturePosition = 13
452:             .Top             = 5
453:             .Left            = 5
454:             .Width           = 75
455:             .Height          = 75
456:             .FontName        = "Tahoma"
457:             .FontBold        = .T.
458:             .FontItalic      = .T.

*-- Linhas 467 a 481:
467:             .Visible         = .T.
468:         ENDWITH
469: 
470:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
471:         WITH loc_oCnt.cmd_4c_Cancelar
472:             .Caption         = "Encerrar"
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
474:             .PicturePosition = 13
475:             .Top             = 5
476:             .Left            = 80
477:             .Width           = 75
478:             .Height          = 75
479:             .FontName        = "Tahoma"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.

*-- Linhas 490 a 513:
490:             .Visible         = .T.
491:         ENDWITH
492: 
493:         BINDEVENT(loc_oCnt.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
494:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
495: 
496:         *-- Sub-PageFrame 3 abas (Pageframe1 no legado: Top=6+29=35, Height=600)
497:         loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
498:         WITH loc_oPagina.pgf_4c_Dados
499:             .PageCount       = 3
500:             .Top             = 35
501:             .Left            = 0
502:             .Width           = THIS.Width
503:             .Height          = 600
504:             .Tabs            = .T.
505:             .Visible         = .T.
506:             .Page1.Caption   = "Estoques"
507:             .Page2.Caption   = "Distribui" + CHR(231) + CHR(227) + "o"
508:             .Page3.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
509:             .Page1.BackColor = RGB(224, 224, 224)
510:             .Page2.BackColor = RGB(224, 224, 224)
511:             .Page3.BackColor = RGB(224, 224, 224)
512:             .Page2.Enabled   = .F.
513:             .Page3.Enabled   = .F.

*-- Linhas 528 a 542:
528:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
529: 
530:         *-- Botao Processar (top-right da aba - processar no legado: top=10, left=733)
531:         loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
532:         WITH loc_oPage.cmd_4c_Processar
533:             .Caption         = "Processar"
534:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
535:             .PicturePosition = 13
536:             .Top             = 5
537:             .Left            = 733
538:             .Width           = 80
539:             .Height          = 75
540:             .FontName        = "Tahoma"
541:             .FontBold        = .T.
542:             .FontItalic      = .T.

*-- Linhas 551 a 566:
551:             .Visible         = .T.
552:         ENDWITH
553: 
554:         BINDEVENT(loc_oPage.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
555: 
556:         *-- Label titulo da secao de estoques (Say5 no legado: top=189, left=338)
557:         loc_oPage.AddObject("lbl_4c_EstoquesTit", "Label")
558:         WITH loc_oPage.lbl_4c_EstoquesTit
559:             .Caption   = "Estoques para distribuir"
560:             .Top       = 189
561:             .Left      = 338
562:             .Width     = 200
563:             .Height    = 14
564:             .AutoSize  = .F.
565:             .FontName  = "Tahoma"
566:             .FontBold  = .T.

*-- Linhas 575 a 584:
575:         loc_oPage.grd_4c_Estoque.ColumnCount = 4
576: 
577:         WITH loc_oPage.grd_4c_Estoque
578:             .Top                = 207
579:             .Left               = 335
580:             .Width              = 271
581:             .Height             = 244
582:             .FontName           = "Verdana"
583:             .FontSize           = 8
584:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 593 a 619:
593:             .ScrollBars         = 2
594:             .GridLines          = 3
595:             .Visible            = .T.
596:             .Column1.Header1.Caption = ""
597:             .Column1.Width           = 25
598:             .Column2.Header1.Caption = "Empresa"
599:             .Column2.Width           = 80
600:             .Column3.Header1.Caption = "Grupo"
601:             .Column3.Width           = 80
602:             .Column4.Header1.Caption = "Conta"
603:             .Column4.Width           = 80
604:         ENDWITH
605: 
606:         *-- CheckBox em Column1 para toggle nMarca (Check1 no legado)
607:         loc_oGrid = loc_oPage.grd_4c_Estoque
608:         loc_oGrid.Column1.AddObject("chk_4c_nMarca", "CheckBox")
609:         WITH loc_oGrid.Column1.chk_4c_nMarca
610:             .Caption = ""
611:             .Width   = 22
612:             .Height  = 17
613:             .Left    = 2
614:             .Top     = 1
615:             .Value   = 0
616:             .Visible = .T.
617:         ENDWITH
618:         loc_oGrid.Column1.CurrentControl = "chk_4c_nMarca"
619: 

*-- Linhas 634 a 657:
634:         loc_oPage.AddObject("cmg_4c_MarcaDesmarca", "CommandGroup")
635:         WITH loc_oPage.cmg_4c_MarcaDesmarca
636:             .ButtonCount         = 2
637:             .Top                 = 351
638:             .Left                = 617
639:             .Width               = 160
640:             .Height              = 100
641:             .Visible             = .T.
642:             .Buttons(1).Caption  = "Marcar" + CHR(13) + "Todos"
643:             .Buttons(1).Left     = 5
644:             .Buttons(1).Top      = 10
645:             .Buttons(1).Width    = 70
646:             .Buttons(1).Height   = 80
647:             .Buttons(1).FontName = "Tahoma"
648:             .Buttons(1).FontBold = .T.
649:             .Buttons(1).FontSize = 8
650:             .Buttons(2).Caption  = "Desmarcar" + CHR(13) + "Todos"
651:             .Buttons(2).Left     = 82
652:             .Buttons(2).Top      = 10
653:             .Buttons(2).Width    = 70
654:             .Buttons(2).Height   = 80
655:             .Buttons(2).FontName = "Tahoma"
656:             .Buttons(2).FontBold = .T.
657:             .Buttons(2).FontSize = 8

*-- Linhas 706 a 715:
706:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
707:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
708:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
709:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
710:                     loc_oGrid.Column2.Header1.Caption = "Data"
711:                     loc_oGrid.Column1.Width           = 150
712:                     loc_oGrid.Column2.Width           = 150
713:                     THIS.FormatarGridLista(loc_oGrid)
714:                     loc_lResultado = .T.
715:                 ENDIF

*-- Linhas 770 a 781:
770:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
771:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
772: 
773:                     loc_oGrid.Column1.Header1.Caption = ""
774:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
775:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
776:                     loc_oGrid.Column4.Header1.Caption = "Conta"
777: 
778:                     loc_lResultado = .T.
779:                 ENDIF
780:             ENDIF
781: 

*-- Linhas 1062 a 1097:
1062:         *-- Shape borda ao redor da imagem (Shape5: top=5, left=4, width=163, height=93)
1063:         loc_oPage.AddObject("shp_4c_FigBorda", "Shape")
1064:         WITH loc_oPage.shp_4c_FigBorda
1065:             .Top         = 5
1066:             .Left        = 4
1067:             .Width       = 163
1068:             .Height      = 93
1069:             .BorderColor = RGB(128, 128, 128)
1070:             .BorderWidth = 1
1071:             .BorderStyle = 1
1072:             .FillStyle   = 1
1073:             .Visible     = .T.
1074:         ENDWITH
1075: 
1076:         *-- Imagem do produto (FigJpg: top=7, left=6, width=159, height=89)
1077:         loc_oPage.AddObject("img_4c_FigJpg", "Image")
1078:         WITH loc_oPage.img_4c_FigJpg
1079:             .Top     = 7
1080:             .Left    = 6
1081:             .Width   = 159
1082:             .Height  = 89
1083:             .Stretch = 2
1084:             .Visible = .T.
1085:         ENDWITH
1086: 
1087:         *-- Label "Grupo :" (Say9: top=59, left=174, width=38)
1088:         loc_oPage.AddObject("lbl_4c_GrupoDist", "Label")
1089:         WITH loc_oPage.lbl_4c_GrupoDist
1090:             .Caption   = "Grupo :"
1091:             .Top       = 59
1092:             .Left      = 174
1093:             .Width     = 38
1094:             .Height    = 15
1095:             .AutoSize  = .F.
1096:             .FontName  = "Tahoma"
1097:             .FontSize  = 8

*-- Linhas 1104 a 1113:
1104:         loc_oPage.AddObject("txt_4c_CodGrupoDist", "TextBox")
1105:         WITH loc_oPage.txt_4c_CodGrupoDist
1106:             .Value       = ""
1107:             .Top         = 74
1108:             .Left        = 175
1109:             .Width       = 35
1110:             .Height      = 23
1111:             .FontName    = "Tahoma"
1112:             .FontSize    = 8
1113:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1120 a 1145:
1120:         loc_oPage.AddObject("txt_4c_DscGrupoDist", "TextBox")
1121:         WITH loc_oPage.txt_4c_DscGrupoDist
1122:             .Value       = ""
1123:             .Top         = 74
1124:             .Left        = 211
1125:             .Width       = 208
1126:             .Height      = 23
1127:             .FontName    = "Tahoma"
1128:             .FontSize    = 8
1129:             .BackColor   = RGB(255, 255, 255)
1130:             .ForeColor   = RGB(0, 0, 0)
1131:             .BorderStyle = 1
1132:             .Visible     = .T.
1133:         ENDWITH
1134: 
1135:         *-- Label "Subgrupo :" (Say11: top=100, left=174, width=55)
1136:         loc_oPage.AddObject("lbl_4c_SgrupoDist", "Label")
1137:         WITH loc_oPage.lbl_4c_SgrupoDist
1138:             .Caption   = "Subgrupo :"
1139:             .Top       = 100
1140:             .Left      = 174
1141:             .Width     = 55
1142:             .Height    = 15
1143:             .AutoSize  = .F.
1144:             .FontName  = "Tahoma"
1145:             .FontSize  = 8

*-- Linhas 1152 a 1161:
1152:         loc_oPage.AddObject("txt_4c_CodSgrupoDist", "TextBox")
1153:         WITH loc_oPage.txt_4c_CodSgrupoDist
1154:             .Value       = ""
1155:             .Top         = 115
1156:             .Left        = 175
1157:             .Width       = 52
1158:             .Height      = 23
1159:             .FontName    = "Tahoma"
1160:             .FontSize    = 8
1161:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1168 a 1195:
1168:         loc_oPage.AddObject("txt_4c_DscSgrupoDist", "TextBox")
1169:         WITH loc_oPage.txt_4c_DscSgrupoDist
1170:             .Value       = ""
1171:             .Top         = 115
1172:             .Left        = 228
1173:             .Width       = 236
1174:             .Height      = 23
1175:             .FontName    = "Tahoma"
1176:             .FontSize    = 8
1177:             .BackColor   = RGB(255, 255, 255)
1178:             .ForeColor   = RGB(0, 0, 0)
1179:             .BorderStyle = 1
1180:             .Visible     = .T.
1181:         ENDWITH
1182: 
1183:         *-- Botao Filtrar (Filtrar: top=73, left=424, width=40, height=40)
1184:         loc_oPage.AddObject("cmd_4c_Filtrar", "CommandButton")
1185:         WITH loc_oPage.cmd_4c_Filtrar
1186:             .Caption         = "Filtrar"
1187:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1188:             .PicturePosition = 13
1189:             .Top             = 73
1190:             .Left            = 424
1191:             .Width           = 40
1192:             .Height          = 40
1193:             .FontName        = "Tahoma"
1194:             .FontBold        = .T.
1195:             .FontSize        = 7

*-- Linhas 1204 a 1216:
1204:         ENDWITH
1205: 
1206:         *-- Label "Procurar" (lbl_produto: top=100, left=4, width=43)
1207:         loc_oPage.AddObject("lbl_4c_ProdutoProc", "Label")
1208:         WITH loc_oPage.lbl_4c_ProdutoProc
1209:             .Caption   = "Procurar"
1210:             .Top       = 100
1211:             .Left      = 4
1212:             .Width     = 43
1213:             .Height    = 15
1214:             .AutoSize  = .F.
1215:             .FontName  = "Tahoma"
1216:             .FontSize  = 8

*-- Linhas 1223 a 1232:
1223:         loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
1224:         WITH loc_oPage.txt_4c_ProdutoInicial
1225:             .Value       = ""
1226:             .Top         = 116
1227:             .Left        = 2
1228:             .Width       = 108
1229:             .Height      = 22
1230:             .FontName    = "Tahoma"
1231:             .FontSize    = 8
1232:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1240 a 1249:
1240:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1241: 
1242:         WITH loc_oPage.grd_4c_Disponivel
1243:             .Top                = 141
1244:             .Left               = 1
1245:             .Width              = 663
1246:             .Height             = 327
1247:             .FontName           = "Verdana"
1248:             .FontSize           = 8
1249:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1258 a 1278:
1258:             .ScrollBars         = 2
1259:             .GridLines          = 3
1260:             .Visible            = .T.
1261:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1262:             .Column1.Width           = 90
1263:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1264:             .Column2.Width           = 200
1265:             .Column3.Header1.Caption = "Cor"
1266:             .Column3.Width           = 60
1267:             .Column4.Header1.Caption = "Tam"
1268:             .Column4.Width           = 40
1269:             .Column5.Header1.Caption = "Estoque"
1270:             .Column5.Width           = 70
1271:             .Column6.Header1.Caption = "Saldo"
1272:             .Column6.Width           = 70
1273:             .Column7.Header1.Caption = "Distribuido"
1274:             .Column7.Width           = 70
1275:         ENDWITH
1276: 
1277:         *-- Controles read-only nas colunas (When=.F. no legado)
1278:         loc_oGrid = loc_oPage.grd_4c_Disponivel

*-- Linhas 1310 a 1319:
1310:         loc_oPage.grd_4c_Distribui.ColumnCount = 4
1311: 
1312:         WITH loc_oPage.grd_4c_Distribui
1313:             .Top                = 141
1314:             .Left               = 664
1315:             .Width              = 334
1316:             .Height             = 327
1317:             .FontName           = "Verdana"
1318:             .FontSize           = 8
1319:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1328 a 1342:
1328:             .ScrollBars         = 2
1329:             .GridLines          = 3
1330:             .Visible            = .T.
1331:             .Column1.Header1.Caption = "Empresa"
1332:             .Column1.Width           = 60
1333:             .Column2.Header1.Caption = "Saldo"
1334:             .Column2.Width           = 70
1335:             .Column3.Header1.Caption = "Distribuido"
1336:             .Column3.Width           = 80
1337:             .Column4.Header1.Caption = "Local"
1338:             .Column4.Width           = 90
1339:         ENDWITH
1340: 
1341:         *-- Col1/Col2 read-only; Col3 editavel (QtdDistr); Col4 editavel com lookup Local
1342:         loc_oGrid = loc_oPage.grd_4c_Distribui

*-- Linhas 1357 a 1621:
1357: 
1358:         *-- Painel de info produto (somente leitura) -- top 470-540
1359:         *-- Row 1: Grupo / Linha (top=470-474)
1360:         loc_oPage.AddObject("lbl_4c_GrupoInfo", "Label")
1361:         WITH loc_oPage.lbl_4c_GrupoInfo
1362:             .Caption   = "Grupo :"
1363:             .Top       = 474
1364:             .Left      = 67
1365:             .Width     = 38
1366:             .Height    = 15
1367:             .AutoSize  = .F.
1368:             .BackStyle = 0
1369:         ENDWITH
1370: 
1371:         loc_oPage.AddObject("txt_4c_CdGrupoInfo", "TextBox")
1372:         WITH loc_oPage.txt_4c_CdGrupoInfo
1373:             .Value    = ""
1374:             .Top      = 470
1375:             .Left     = 116
1376:             .Width    = 65
1377:             .Height   = 21
1378:             .ReadOnly = .T.
1379:         ENDWITH
1380: 
1381:         loc_oPage.AddObject("txt_4c_DsGrupoInfo", "TextBox")
1382:         WITH loc_oPage.txt_4c_DsGrupoInfo
1383:             .Value    = ""
1384:             .Top      = 470
1385:             .Left     = 182
1386:             .Width    = 270
1387:             .Height   = 21
1388:             .ReadOnly = .T.
1389:         ENDWITH
1390: 
1391:         loc_oPage.AddObject("lbl_4c_LinhaInfo", "Label")
1392:         WITH loc_oPage.lbl_4c_LinhaInfo
1393:             .Caption   = "Linha :"
1394:             .Top       = 473
1395:             .Left      = 549
1396:             .Width     = 34
1397:             .Height    = 15
1398:             .AutoSize  = .F.
1399:             .BackStyle = 0
1400:         ENDWITH
1401: 
1402:         loc_oPage.AddObject("txt_4c_CdLinhaInfo", "TextBox")
1403:         WITH loc_oPage.txt_4c_CdLinhaInfo
1404:             .Value    = ""
1405:             .Top      = 470
1406:             .Left     = 593
1407:             .Width    = 80
1408:             .Height   = 21
1409:             .ReadOnly = .T.
1410:         ENDWITH
1411: 
1412:         loc_oPage.AddObject("txt_4c_DsLinhaInfo", "TextBox")
1413:         WITH loc_oPage.txt_4c_DsLinhaInfo
1414:             .Value    = ""
1415:             .Top      = 470
1416:             .Left     = 674
1417:             .Width    = 255
1418:             .Height   = 21
1419:             .ReadOnly = .T.
1420:         ENDWITH
1421: 
1422:         *-- Row 2: Subgrupo / Fornecedor (top=492-497)
1423:         loc_oPage.AddObject("lbl_4c_SgrupoInfo", "Label")
1424:         WITH loc_oPage.lbl_4c_SgrupoInfo
1425:             .Caption   = "Subgrupo :"
1426:             .Top       = 497
1427:             .Left      = 50
1428:             .Width     = 55
1429:             .Height    = 15
1430:             .AutoSize  = .F.
1431:             .BackStyle = 0
1432:         ENDWITH
1433: 
1434:         loc_oPage.AddObject("txt_4c_CdSgrupoInfo", "TextBox")
1435:         WITH loc_oPage.txt_4c_CdSgrupoInfo
1436:             .Value    = ""
1437:             .Top      = 492
1438:             .Left     = 116
1439:             .Width    = 65
1440:             .Height   = 21
1441:             .ReadOnly = .T.
1442:         ENDWITH
1443: 
1444:         loc_oPage.AddObject("txt_4c_DsSgrupoInfo", "TextBox")
1445:         WITH loc_oPage.txt_4c_DsSgrupoInfo
1446:             .Value    = ""
1447:             .Top      = 492
1448:             .Left     = 182
1449:             .Width    = 270
1450:             .Height   = 21
1451:             .ReadOnly = .T.
1452:         ENDWITH
1453: 
1454:         loc_oPage.AddObject("lbl_4c_FornInfo", "Label")
1455:         WITH loc_oPage.lbl_4c_FornInfo
1456:             .Caption   = "Fornecedor :"
1457:             .Top       = 495
1458:             .Left      = 519
1459:             .Width     = 64
1460:             .Height    = 15
1461:             .AutoSize  = .F.
1462:             .BackStyle = 0
1463:         ENDWITH
1464: 
1465:         loc_oPage.AddObject("txt_4c_CdFornInfo", "TextBox")
1466:         WITH loc_oPage.txt_4c_CdFornInfo
1467:             .Value    = ""
1468:             .Top      = 492
1469:             .Left     = 593
1470:             .Width    = 80
1471:             .Height   = 21
1472:             .ReadOnly = .T.
1473:         ENDWITH
1474: 
1475:         loc_oPage.AddObject("txt_4c_DsFornInfo", "TextBox")
1476:         WITH loc_oPage.txt_4c_DsFornInfo
1477:             .Value    = ""
1478:             .Top      = 492
1479:             .Left     = 674
1480:             .Width    = 255
1481:             .Height   = 21
1482:             .ReadOnly = .T.
1483:         ENDWITH
1484: 
1485:         *-- Row 3: Modelo / Ref.Fornecedor (top=514-517)
1486:         loc_oPage.AddObject("lbl_4c_ModeloInfo", "Label")
1487:         WITH loc_oPage.lbl_4c_ModeloInfo
1488:             .Caption   = "Modelo :"
1489:             .Top       = 517
1490:             .Left      = 62
1491:             .Width     = 43
1492:             .Height    = 15
1493:             .AutoSize  = .F.
1494:             .BackStyle = 0
1495:         ENDWITH
1496: 
1497:         loc_oPage.AddObject("txt_4c_CodModeloInfo", "TextBox")
1498:         WITH loc_oPage.txt_4c_CodModeloInfo
1499:             .Value    = ""
1500:             .Top      = 514
1501:             .Left     = 116
1502:             .Width    = 65
1503:             .Height   = 21
1504:             .ReadOnly = .T.
1505:         ENDWITH
1506: 
1507:         loc_oPage.AddObject("txt_4c_DsModeloInfo", "TextBox")
1508:         WITH loc_oPage.txt_4c_DsModeloInfo
1509:             .Value    = ""
1510:             .Top      = 514
1511:             .Left     = 182
1512:             .Width    = 270
1513:             .Height   = 21
1514:             .ReadOnly = .T.
1515:         ENDWITH
1516: 
1517:         loc_oPage.AddObject("lbl_4c_RefFornInfo", "Label")
1518:         WITH loc_oPage.lbl_4c_RefFornInfo
1519:             .Caption   = "Ref. Fornecedor :"
1520:             .Top       = 517
1521:             .Left      = 495
1522:             .Width     = 88
1523:             .Height    = 15
1524:             .AutoSize  = .F.
1525:             .BackStyle = 0
1526:         ENDWITH
1527: 
1528:         loc_oPage.AddObject("txt_4c_RefFornInfo", "TextBox")
1529:         WITH loc_oPage.txt_4c_RefFornInfo
1530:             .Value    = ""
1531:             .Top      = 514
1532:             .Left     = 593
1533:             .Width    = 190
1534:             .Height   = 21
1535:             .ReadOnly = .T.
1536:         ENDWITH
1537: 
1538:         *-- Row 4: Grupo de Venda / Preco Venda / Peso (top=536-540)
1539:         loc_oPage.AddObject("lbl_4c_GrVendaInfo", "Label")
1540:         WITH loc_oPage.lbl_4c_GrVendaInfo
1541:             .Caption   = "Grupo de Venda :"
1542:             .Top       = 540
1543:             .Left      = 19
1544:             .Width     = 86
1545:             .Height    = 15
1546:             .AutoSize  = .F.
1547:             .BackStyle = 0
1548:         ENDWITH
1549: 
1550:         loc_oPage.AddObject("txt_4c_CdGrVendaInfo", "TextBox")
1551:         WITH loc_oPage.txt_4c_CdGrVendaInfo
1552:             .Value    = ""
1553:             .Top      = 537
1554:             .Left     = 116
1555:             .Width    = 80
1556:             .Height   = 21
1557:             .ReadOnly = .T.
1558:         ENDWITH
1559: 
1560:         loc_oPage.AddObject("txt_4c_DsGrVendaInfo", "TextBox")
1561:         WITH loc_oPage.txt_4c_DsGrVendaInfo
1562:             .Value    = ""
1563:             .Top      = 537
1564:             .Left     = 197
1565:             .Width    = 255
1566:             .Height   = 21
1567:             .ReadOnly = .T.
1568:         ENDWITH
1569: 
1570:         loc_oPage.AddObject("lbl_4c_PrVendaInfo", "Label")
1571:         WITH loc_oPage.lbl_4c_PrVendaInfo
1572:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1573:             .Top       = 540
1574:             .Left      = 514
1575:             .Width     = 69
1576:             .Height    = 15
1577:             .AutoSize  = .F.
1578:             .BackStyle = 0
1579:         ENDWITH
1580: 
1581:         loc_oPage.AddObject("txt_4c_PrVendaInfo", "TextBox")
1582:         WITH loc_oPage.txt_4c_PrVendaInfo
1583:             .Value    = ""
1584:             .Top      = 536
1585:             .Left     = 593
1586:             .Width    = 108
1587:             .Height   = 22
1588:             .ReadOnly = .T.
1589:         ENDWITH
1590: 
1591:         loc_oPage.AddObject("txt_4c_PrVendaMoeInfo", "TextBox")
1592:         WITH loc_oPage.txt_4c_PrVendaMoeInfo
1593:             .Value    = ""
1594:             .Top      = 536
1595:             .Left     = 703
1596:             .Width    = 31
1597:             .Height   = 22
1598:             .ReadOnly = .T.
1599:         ENDWITH
1600: 
1601:         loc_oPage.AddObject("lbl_4c_PesoInfo", "Label")
1602:         WITH loc_oPage.lbl_4c_PesoInfo
1603:             .Caption   = "Peso :"
1604:             .Top       = 540
1605:             .Left      = 775
1606:             .Width     = 38
1607:             .Height    = 15
1608:             .AutoSize  = .F.
1609:             .BackStyle = 0
1610:         ENDWITH
1611: 
1612:         loc_oPage.AddObject("txt_4c_PesoMedioInfo", "TextBox")
1613:         WITH loc_oPage.txt_4c_PesoMedioInfo
1614:             .Value    = ""
1615:             .Top      = 537
1616:             .Left     = 816
1617:             .Width    = 75
1618:             .Height   = 21
1619:             .ReadOnly = .T.
1620:         ENDWITH
1621: 

*-- Linhas 1630 a 1638:
1630:         BINDEVENT(loc_oPage.txt_4c_DscGrupoDist,   "KeyPress", THIS, "GrupoDscDistValid")
1631:         BINDEVENT(loc_oPage.txt_4c_CodSgrupoDist,  "KeyPress", THIS, "SgrupoCodDistValid")
1632:         BINDEVENT(loc_oPage.txt_4c_DscSgrupoDist,  "KeyPress", THIS, "SgrupoDscDistValid")
1633:         BINDEVENT(loc_oPage.cmd_4c_Filtrar,        "Click", THIS, "FiltrarDisponivelClick")
1634:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProdutoInicialValid")
1635: 
1636:         THIS.TornarControlesVisiveis(loc_oPage)
1637:     ENDPROC
1638: 

*-- Linhas 1662 a 1676:
1662:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1663:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1664: 
1665:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1666:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1667:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1668:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1669:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1670:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1671:                 loc_oGrid.Column7.Header1.Caption = "Distribuido"
1672: 
1673:                 THIS.FormatarGridLista(loc_oGrid)
1674:                 loc_oGrid.Refresh()
1675: 
1676:                 THIS.CarregarDistribui()

*-- Linhas 1710 a 1721:
1710:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1711:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1712: 
1713:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1714:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1715:                 loc_oGrid.Column3.Header1.Caption = "Distribuido"
1716:                 loc_oGrid.Column4.Header1.Caption = "Local"
1717: 
1718:                 THIS.FormatarGridLista(loc_oGrid)
1719:                 loc_oGrid.Refresh()
1720: 
1721:                 loc_lResultado = .T.

*-- Linhas 2224 a 2283:
2224:         *-- Container de Observacao (cntOperacao: top=13, left=3, width=564, height=165)
2225:         loc_oPage.AddObject("cnt_4c_Operacao", "Container")
2226:         WITH loc_oPage.cnt_4c_Operacao
2227:             .Top       = 13
2228:             .Left      = 3
2229:             .Width     = 564
2230:             .Height    = 165
2231:             .BackStyle = 0
2232:             .Visible   = .T.
2233:         ENDWITH
2234:         loc_oCnt = loc_oPage.cnt_4c_Operacao
2235: 
2236:         loc_oCnt.AddObject("lbl_4c_Obs", "Label")
2237:         WITH loc_oCnt.lbl_4c_Obs
2238:             .Caption   = "Obs:"
2239:             .Top       = 10
2240:             .Left      = 12
2241:             .Width     = 35
2242:             .Height    = 15
2243:             .AutoSize  = .F.
2244:             .BackStyle = 0
2245:             .FontName  = "Tahoma"
2246:             .FontSize  = 8
2247:             .Visible   = .T.
2248:         ENDWITH
2249: 
2250:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
2251:         WITH loc_oCnt.txt_4c_CodObs
2252:             .Value    = ""
2253:             .Top      = 8
2254:             .Left     = 52
2255:             .Width    = 27
2256:             .Height   = 20
2257:             .Visible  = .T.
2258:         ENDWITH
2259: 
2260:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
2261:         WITH loc_oCnt.edt_4c_Obs
2262:             .Value     = ""
2263:             .Top       = 8
2264:             .Left      = 83
2265:             .Width     = 407
2266:             .Height    = 112
2267:             .ScrollBars = 2
2268:             .Visible   = .T.
2269:         ENDWITH
2270: 
2271:         *-- Botao Processar Final (cmdProcessar: top=11, left=733, width=105, height=122)
2272:         loc_oPage.AddObject("cmd_4c_ProcessarFinal", "CommandButton")
2273:         WITH loc_oPage.cmd_4c_ProcessarFinal
2274:             .Caption         = "Processar"
2275:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
2276:             .PicturePosition = 13
2277:             .Top             = 11
2278:             .Left            = 733
2279:             .Width           = 105
2280:             .Height          = 122
2281:             .FontName        = "Tahoma"
2282:             .FontBold        = .T.
2283:             .FontItalic      = .T.

*-- Linhas 2292 a 2325:
2292:             .Visible         = .T.
2293:         ENDWITH
2294: 
2295:         BINDEVENT(loc_oPage.cmd_4c_ProcessarFinal, "Click", THIS, "BtnProcessarFinalClick")
2296: 
2297:         *-- Sub-PageFrame Operacoes (pgOperacoes: top=191, left=1, width=997, height=377)
2298:         loc_oPage.AddObject("pgf_4c_Operacoes", "PageFrame")
2299:         WITH loc_oPage.pgf_4c_Operacoes
2300:             .Top      = 191
2301:             .Left     = 1
2302:             .Width    = 997
2303:             .Height   = 377
2304:             .PageCount = 2
2305:             .Tabs     = .T.
2306:             .Visible  = .T.
2307:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
2308:             .Page2.Caption   = "Itens"
2309:             .Page1.BackColor = RGB(224, 224, 224)
2310:             .Page2.BackColor = RGB(224, 224, 224)
2311:         ENDWITH
2312:         loc_oPgfOp = loc_oPage.pgf_4c_Operacoes
2313: 
2314:         *-- grd_4c_CabOperas na Page1 (grdCabOperas: 8 cols, top=6, left=9, width=975, height=339)
2315:         loc_oPgfOp.Page1.AddObject("grd_4c_CabOperas", "Grid")
2316:         loc_oPgfOp.Page1.grd_4c_CabOperas.ColumnCount = 8
2317: 
2318:         WITH loc_oPgfOp.Page1.grd_4c_CabOperas
2319:             .Top                = 6
2320:             .Left               = 9
2321:             .Width              = 975
2322:             .Height             = 339
2323:             .FontName           = "Verdana"
2324:             .FontSize           = 8
2325:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2335 a 2357:
2335:             .GridLines          = 3
2336:             .ReadOnly           = .T.
2337:             .Visible            = .T.
2338:             .Column1.Header1.Caption = "Emp O"
2339:             .Column1.Width           = 55
2340:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2341:             .Column2.Width           = 110
2342:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2343:             .Column3.Width           = 130
2344:             .Column4.Header1.Caption = "Emp D"
2345:             .Column4.Width           = 55
2346:             .Column5.Header1.Caption = "Grupo Orig"
2347:             .Column5.Width           = 105
2348:             .Column6.Header1.Caption = "Conta Orig"
2349:             .Column6.Width           = 105
2350:             .Column7.Header1.Caption = "Grupo Dest"
2351:             .Column7.Width           = 105
2352:             .Column8.Header1.Caption = "Conta Dest"
2353:             .Column8.Width           = 105
2354:         ENDWITH
2355: 
2356:         loc_oGrid = loc_oPgfOp.Page1.grd_4c_CabOperas
2357:         loc_oGrid.Column1.AddObject("txt_4c_Col01", "TextBox")

*-- Linhas 2384 a 2393:
2384:         loc_oPgfOp.Page2.grd_4c_ItnOperas.ColumnCount = 9
2385: 
2386:         WITH loc_oPgfOp.Page2.grd_4c_ItnOperas
2387:             .Top                = 5
2388:             .Left               = 9
2389:             .Width              = 975
2390:             .Height             = 340
2391:             .FontName           = "Verdana"
2392:             .FontSize           = 8
2393:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2403 a 2427:
2403:             .GridLines          = 3
2404:             .ReadOnly           = .T.
2405:             .Visible            = .T.
2406:             .Column1.Header1.Caption = "Item"
2407:             .Column1.Width           = 50
2408:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2409:             .Column2.Width           = 100
2410:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2411:             .Column3.Width           = 200
2412:             .Column4.Header1.Caption = "Uni"
2413:             .Column4.Width           = 40
2414:             .Column5.Header1.Caption = "Quantidade"
2415:             .Column5.Width           = 90
2416:             .Column6.Header1.Caption = "Unit" + CHR(225) + "rio"
2417:             .Column6.Width           = 90
2418:             .Column7.Header1.Caption = "Total"
2419:             .Column7.Width           = 90
2420:             .Column8.Header1.Caption = "Cor"
2421:             .Column8.Width           = 60
2422:             .Column9.Header1.Caption = "Tam"
2423:             .Column9.Width           = 60
2424:         ENDWITH
2425: 
2426:         loc_oGrid = loc_oPgfOp.Page2.grd_4c_ItnOperas
2427:         loc_oGrid.Column1.AddObject("txt_4c_Itn01", "TextBox")

*-- Linhas 2750 a 2771:
2750:                 IF VARTYPE(loc_oPage2Dados.txt_4c_ProdutoInicial) = "O"
2751:                     loc_oPage2Dados.txt_4c_ProdutoInicial.ReadOnly = !par_lHabilitar
2752:                 ENDIF
2753:                 IF VARTYPE(loc_oPage2Dados.cmd_4c_Filtrar)        = "O"
2754:                     loc_oPage2Dados.cmd_4c_Filtrar.Enabled         = par_lHabilitar
2755:                 ENDIF
2756:                 loc_oGrid = loc_oPage2Dados.grd_4c_Distribui
2757:                 IF VARTYPE(loc_oGrid) = "O"
2758:                     loc_oGrid.Column3.txt_4c_Dis03.ReadOnly = !par_lHabilitar
2759:                     loc_oGrid.Column4.txt_4c_Loc04.ReadOnly = !par_lHabilitar
2760:                 ENDIF
2761:             ENDIF
2762:             *-- Aba1 Estoques: processar e marca/desmarca
2763:             loc_oPage1Aba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2764:             IF VARTYPE(loc_oPage1Aba) = "O"
2765:                 IF VARTYPE(loc_oPage1Aba.cmd_4c_Processar)      = "O"
2766:                     loc_oPage1Aba.cmd_4c_Processar.Enabled      = par_lHabilitar
2767:                 ENDIF
2768:                 IF VARTYPE(loc_oPage1Aba.cmg_4c_MarcaDesmarca)  = "O"
2769:                     loc_oPage1Aba.cmg_4c_MarcaDesmarca.Enabled  = par_lHabilitar
2770:                 ENDIF
2771:             ENDIF

*-- Linhas 2862 a 2874:
2862:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2863:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2864:             IF VARTYPE(loc_oCnt) = "O"
2865:                 IF VARTYPE(loc_oCnt.cmd_4c_Salvar)   = "O"
2866:                     loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lEditar
2867:                 ENDIF
2868:                 IF VARTYPE(loc_oCnt.cmd_4c_Cancelar) = "O"
2869:                     loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
2870:                 ENDIF
2871:             ENDIF
2872:             THIS.HabilitarCampos(loc_lEditar)
2873:         CATCH TO loc_oErro
2874:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*==============================================================================
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
* Data: 2026-07-02
* Tabela: sigprdis | PK: cidchaves | Chave negocio: codigos (lote)
*
* ATENCAO: Esta tabela opera em modo LOTE (batch):
* - Um lote (codigos) possui N linhas (uma por empresa/produto/cor/tamanho)
* - cidchaves = chave unica por linha (gerada via fUniqueIds)
* - codigos   = identificador do lote de distribuicao
* - Excluir() apaga TODAS as linhas do lote (WHERE codigos = ...)
* - Inserir() insere MULTIPLAS linhas por lote
*==============================================================================

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Campos da tabela sigprdis
    this_cCidChaves  = ""   && cidchaves  CHAR(20)    - Chave unica por linha (PK)
    this_cCodigos    = ""   && codigos    CHAR(10)    - Codigo do lote de distribuicao
    this_cCpros      = ""   && cpros      CHAR(14)    - Codigo do produto
    this_cCodCors    = ""   && codcors    CHAR(4)     - Codigo da cor
    this_cCodTams    = ""   && codtams    CHAR(4)     - Codigo do tamanho
    this_dDatas      = {}   && datas      DATETIME    - Data da distribuicao
    this_dDtAlts     = {}   && dtalts     DATETIME    - Data da ultima alteracao
    this_cEmpDopNums = ""   && empdopnums CHAR(29)    - Numero do pedido destino
    this_cEmpDs      = ""   && empds      CHAR(3)     - Empresa destino
    this_cEmpGruEsts = ""   && empgruests CHAR(23)    - Empresa/Grupo/Estoque marcado
    this_cLocals     = ""   && locals     CHAR(10)    - Localizacao de destino
    this_nQtdOs      = 0    && qtdos      NUMERIC(10,2) - Quantidade original em estoque
    this_nQtds       = 0    && qtds       NUMERIC(10,2) - Quantidade distribuida
    this_cUsualts    = ""   && usualts    CHAR(10)    - Usuario da ultima alteracao
    this_cUsuars     = ""   && usuars     CHAR(10)    - Usuario criador
    this_cOriDopNums = ""   && oridopnums CHAR(29)    - Numero do pedido origem

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprdis"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
                THIS.this_cCodigos    = TratarNulo(codigos,    "C")
                THIS.this_cCpros      = TratarNulo(cpros,      "C")
                THIS.this_cCodCors    = TratarNulo(codcors,    "C")
                THIS.this_cCodTams    = TratarNulo(codtams,    "C")
                THIS.this_dDatas      = NVL(datas,      {})
                THIS.this_dDtAlts     = NVL(dtalts,     {})
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_cEmpDs      = TratarNulo(empds,      "C")
                THIS.this_cEmpGruEsts = TratarNulo(empgruests, "C")
                THIS.this_cLocals     = TratarNulo(locals,     "C")
                THIS.this_nQtdOs      = TratarNulo(qtdos,      "N")
                THIS.this_nQtds       = TratarNulo(qtds,       "N")
                THIS.this_cUsualts    = TratarNulo(usualts,    "C")
                THIS.this_cUsuars     = TratarNulo(usuars,     "C")
                THIS.this_cOriDopNums = TratarNulo(oridopnums, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao (suporta filtro WHERE opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar lotes: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorData - Carrega lotes filtrados por intervalo de data/hora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorData(par_dDataIni, par_dDataFim)
        LOCAL loc_cSQL, loc_cDataIni, loc_cDataFim, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_dDataIni) != "T" OR EMPTY(par_dDataIni)
                par_dDataIni = CTOT(DTOC(DATE()) + " 00:00:00")
            ENDIF
            IF VARTYPE(par_dDataFim) != "T" OR EMPTY(par_dDataFim)
                par_dDataFim = CTOT(DTOC(DATE()) + " 23:59:59")
            ENDIF

            loc_cDataIni = FormatarDataSQL(par_dDataIni)
            loc_cDataFim = FormatarDataSQL(par_dDataFim)

            loc_cSQL = "SELECT DISTINCT codigos, datas FROM sigprdis" + ;
                       " WHERE datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " ORDER BY datas DESC, codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar por data: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeiro item de um lote (para edicao)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensPorCodigos - Carrega todos os itens de um lote em cursor
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensPorCodigos(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT * FROM sigprdis WHERE codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItensPrdis")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar itens do lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO sigprdis (" + ;
                       "cidchaves, codigos, cpros, codcors, codtams, datas, dtalts," + ;
                       " empdopnums, empds, empgruests, locals, qtdos, qtds," + ;
                       " usualts, usuars, oridopnums" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)    + ", " + ;
                       EscaparSQL(THIS.this_cCodigos)      + ", " + ;
                       EscaparSQL(THIS.this_cCpros)        + ", " + ;
                       EscaparSQL(THIS.this_cCodCors)      + ", " + ;
                       EscaparSQL(THIS.this_cCodTams)      + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlts)  + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNums)   + ", " + ;
                       EscaparSQL(THIS.this_cEmpDs)        + ", " + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)   + ", " + ;
                       EscaparSQL(THIS.this_cLocals)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)  + ", " + ;
                       EscaparSQL(THIS.this_cUsualts)      + ", " + ;
                       EscaparSQL(THIS.this_cUsuars)       + ", " + ;
                       EscaparSQL(THIS.this_cOriDopNums)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza uma linha de distribuicao no banco de dados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE sigprdis SET" + ;
                       " codigos    = " + EscaparSQL(THIS.this_cCodigos)      + "," + ;
                       " cpros      = " + EscaparSQL(THIS.this_cCpros)        + "," + ;
                       " codcors    = " + EscaparSQL(THIS.this_cCodCors)      + "," + ;
                       " codtams    = " + EscaparSQL(THIS.this_cCodTams)      + "," + ;
                       " datas      = " + FormatarDataSQL(THIS.this_dDatas)   + "," + ;
                       " dtalts     = " + FormatarDataSQL(THIS.this_dDtAlts)  + "," + ;
                       " empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)   + "," + ;
                       " empds      = " + EscaparSQL(THIS.this_cEmpDs)        + "," + ;
                       " empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)   + "," + ;
                       " locals     = " + EscaparSQL(THIS.this_cLocals)       + "," + ;
                       " qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs) + "," + ;
                       " qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)  + "," + ;
                       " usualts    = " + EscaparSQL(THIS.this_cUsualts)      + "," + ;
                       " usuars     = " + EscaparSQL(THIS.this_cUsuars)       + "," + ;
                       " oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)   + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + "o: " + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui todos os itens de um lote (WHERE codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM sigprdis WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir lote: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Sobrescreve BusinessBase.Salvar() para delegar ao SalvarLote()
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !THIS.this_lEmEdicao
            THIS.this_cMensagemErro = "N" + CHR(227) + "o est" + CHR(225) + ;
                                      " em modo de edi" + CHR(231) + CHR(227) + "o"
        ELSE
            loc_lResultado = THIS.SalvarLote()
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Insere multiplas linhas de distribui" + CHR(231) + CHR(227) + "o em lote
    * Usa cursor_4c_Distribui e cursor_4c_Disponivel (devem existir no ambiente)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote()
        LOCAL loc_cCodigos, loc_nTotal, loc_nNeg, loc_lOK, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF !USED("cursor_4c_Distribui")
                MsgErro("Cursor de distribui" + CHR(231) + CHR(227) + ;
                        "o n" + CHR(227) + "o encontrado.", "Erro")
            ELSE
                *-- Contar registros com quantidade a distribuir
                SELECT cursor_4c_Distribui
                COUNT FOR QtdDistr != 0 TO loc_nTotal

                IF loc_nTotal = 0
                    MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
                ELSE
                    *-- Verificar saldo negativo
                    loc_nNeg = 0
                    IF USED("cursor_4c_Disponivel")
                        SELECT cursor_4c_Disponivel
                        COUNT FOR QtdSaldo < 0 TO loc_nNeg
                    ENDIF

                    IF loc_nNeg > 0
                        MsgAviso("Existem produtos distribu" + CHR(237) + "dos com saldo negativo." + ;
                                 CHR(13) + "Favor checar antes de processar.", "Saldo Negativo")
                    ELSE
                        *-- Gerar codigo do lote (novo ou reutilizar existente para alteracao)
                        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                            loc_cCodigos = ALLTRIM(STR(fGerUniqueKey("sigprdis"), 10))
                        ELSE
                            loc_cCodigos = ALLTRIM(THIS.this_cCodigos)
                            THIS.ExecutarExclusao()
                        ENDIF

                        *-- Inserir cada linha com QtdDistr != 0
                        loc_lOK = .T.
                        SELECT cursor_4c_Distribui
                        GO TOP IN cursor_4c_Distribui

                        DO WHILE !EOF("cursor_4c_Distribui") AND loc_lOK
                            IF cursor_4c_Distribui.QtdDistr != 0
                                THIS.this_cCidChaves  = fUniqueIds()
                                THIS.this_cCodigos    = loc_cCodigos
                                THIS.this_cCpros      = ALLTRIM(cursor_4c_Distribui.Cpros)
                                THIS.this_cCodCors    = ALLTRIM(cursor_4c_Distribui.CodCors)
                                THIS.this_cCodTams    = ALLTRIM(cursor_4c_Distribui.CodTams)
                                THIS.this_dDatas      = DATETIME()
                                THIS.this_dDtAlts     = DATETIME()
                                THIS.this_cEmpDs      = ALLTRIM(cursor_4c_Distribui.Cemps)
                                THIS.this_cEmpGruEsts = ALLTRIM(cursor_4c_Distribui.empgruests)
                                THIS.this_cLocals     = ALLTRIM(cursor_4c_Distribui.CidChaves)
                                THIS.this_nQtdOs      = cursor_4c_Distribui.QtdSaldo
                                THIS.this_nQtds       = cursor_4c_Distribui.QtdDistr
                                THIS.this_cUsualts    = gc_4c_UsuarioLogado
                                THIS.this_cUsuars     = gc_4c_UsuarioLogado
                                THIS.this_cEmpDopNums = ""
                                THIS.this_cOriDopNums = ""
                                IF !THIS.Inserir()
                                    loc_lOK = .F.
                                ENDIF
                            ENDIF
                            IF loc_lOK
                                SKIP IN cursor_4c_Distribui
                            ENDIF
                        ENDDO

                        IF loc_lOK
                            THIS.this_cCodigos      = loc_cCodigos
                            THIS.this_lNovoRegistro = .F.
                            THIS.this_lEmEdicao     = .F.
                            loc_lResultado          = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao - Cria cursor_4c_Disponivel e cursor_4c_Distribui
    * par_cAlias = alias do cursor de estoques selecionados (cursor_4c_Estoque)
    *              Campos: nMarca (N), Emps (C3), Grupos (C10), Contas (C10)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cAlias)
        LOCAL loc_cIN, loc_cSQL, loc_nRet, loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cAlias) != "C" OR !USED(par_cAlias)
                MsgErro("Alias inv" + CHR(225) + "lido para processar distribui" + ;
                        CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                *-- Montar IN clause com os estoques marcados
                SELECT (par_cAlias)
                GO TOP
                loc_cIN = ""
                SCAN
                    IF nMarca = 1
                        IF !EMPTY(loc_cIN)
                            loc_cIN = loc_cIN + ","
                        ENDIF
                        loc_cIN = loc_cIN + "'" + ALLTRIM(Emps) + "|" + ;
                                  ALLTRIM(Grupos) + "|" + ALLTRIM(Contas) + "'"
                    ENDIF
                ENDSCAN

                IF EMPTY(loc_cIN)
                    MsgAviso("Nenhum estoque selecionado para processar.", "Processar")
                ELSE
                    *-- cursor_4c_Disponivel: estoque agregado por produto/cor/tamanho
                    loc_cSQL = "SELECT RTRIM(m.cpros) AS Cpros, " + ;
                               "RTRIM(ISNULL(p.dpros,'')) AS Dpros, " + ;
                               "RTRIM(m.codcors) AS CodCors, " + ;
                               "RTRIM(m.codtams) AS CodTams, " + ;
                               "SUM(m.sqtds) AS Sqtds, " + ;
                               "CAST(0 AS NUMERIC(11,3)) AS QtdSaida, " + ;
                               "SUM(m.sqtds) AS QtdSaldo, " + ;
                               "RTRIM(ISNULL(p.cgrus,'')) AS Cgrus, " + ;
                               "RTRIM(ISNULL(p.sgrus,'')) AS Sgrus " + ;
                               "FROM SigMvEst m " + ;
                               "JOIN SigCdPro p ON RTRIM(p.cpros) = RTRIM(m.cpros) " + ;
                               "WHERE (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                               " IN (" + loc_cIN + ") " + ;
                               "GROUP BY m.cpros, p.dpros, m.codcors, m.codtams, p.cgrus, p.sgrus " + ;
                               "ORDER BY m.cpros, m.codcors, m.codtams"

                    IF USED("cursor_4c_Disponivel")
                        USE IN cursor_4c_Disponivel
                    ENDIF

                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")

                    IF loc_nRet < 0
                        MsgErro("Erro ao carregar estoque dispon" + CHR(237) + "vel:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- cursor_4c_Distribui: uma linha por empresa x produto/cor/tamanho
                        loc_cSQL = "SELECT RTRIM(m.emps) AS Cemps, " + ;
                                   "RTRIM(m.grupos) AS CGrus, " + ;
                                   "RTRIM(m.estos) AS CCons, " + ;
                                   "RTRIM(m.cpros) AS Cpros, " + ;
                                   "RTRIM(m.codcors) AS CodCors, " + ;
                                   "RTRIM(m.codtams) AS CodTams, " + ;
                                   "m.sqtds AS QtdSaldo, " + ;
                                   "CAST(0 AS NUMERIC(11,3)) AS QtdDistr, " + ;
                                   "RTRIM(m.empgruests) AS empgruests, " + ;
                                   "REPLICATE(' ', 20) AS CidChaves " + ;
                                   "FROM SigMvEst m " + ;
                                   "WHERE (RTRIM(m.emps) + '|' + RTRIM(m.grupos) + '|' + RTRIM(m.estos))" + ;
                                   " IN (" + loc_cIN + ") " + ;
                                   "ORDER BY m.cpros, m.codcors, m.codtams, m.emps"

                        IF USED("cursor_4c_Distribui")
                            USE IN cursor_4c_Distribui
                        ENDIF

                        loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Distribui")

                        IF loc_nRet < 0
                            MsgErro("Erro ao montar distribui" + CHR(231) + CHR(227) + "o:" + ;
                                    CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

