# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Lista' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ListaTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Estoque' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_EstoqueTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_CabOperas' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_CabOperasTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_ItnOperas' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ItnOperasTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Distribuído' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Distribuído' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Distribuído' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Distribuído' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2805 linhas total):

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

*-- Linhas 315 a 421:
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
374:             .Format      = "D"
375:             .BackColor   = RGB(255, 255, 255)
376:             .ForeColor   = RGB(0, 0, 0)
377:             .BorderStyle = 1
378:             .Visible     = .T.
379:         ENDWITH
380: 
381:         *-- Grid principal (Grade no legado - SigPrDis via cursor_4c_Lista)
382:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
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
393:             .BackColor          = RGB(255, 255, 255)
394:             .GridLineColor      = RGB(238, 238, 238)
395:             .HighlightBackColor = RGB(255, 255, 255)
396:             .HighlightForeColor = RGB(15, 41, 104)
397:             .HighlightStyle     = 2
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .RowHeight          = 16
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

*-- Linhas 680 a 709:
680:                 loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
681:                            " WHERE CAST(Datas AS DATE) BETWEEN" + ;
682:                            " CAST(" + FormatarDataSQL(loc_dDatai) + " AS DATE)" + ;
683:                            " AND CAST(" + FormatarDataSQL(loc_dDataf) + " AS DATE)"
684: 
685:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
686: 
687:                 IF loc_nRet < 0
688:                     MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
689:                     loc_lResultado = .F.
690:                 ELSE
691:                     loc_oGrid.ColumnCount = 2
692:                     loc_oGrid.RecordSource            = "cursor_4c_Lista"
693:                     loc_oGrid.Column1.ControlSource   = "cursor_4c_Lista.Codigos"
694:                     loc_oGrid.Column2.ControlSource   = "cursor_4c_Lista.Datas"
695:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
696:                     loc_oGrid.Column2.Header1.Caption = "Data"
697:                     loc_oGrid.Column1.Width           = 150
698:                     loc_oGrid.Column2.Width           = 150
699:                     THIS.FormatarGridLista(loc_oGrid)
700:                     loc_lResultado = .T.
701:                 ENDIF
702:             ENDIF
703: 
704:         CATCH TO loc_oErro
705:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
706:             loc_lResultado = .F.
707:         ENDTRY
708: 
709:         RETURN loc_lResultado

*-- Linhas 721 a 760:
721:                 loc_lResultado = .T.
722:             ELSE
723:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
724:                 loc_oGrid = loc_oPage.grd_4c_Estoque
725: 
726:                 IF USED("cursor_4c_Estoque")
727:                     USE IN cursor_4c_Estoque
728:                 ENDIF
729: 
730:                 loc_cSQL = "SELECT 0 AS nMarca, Emps, Grupos, Contas" + ;
731:                            " FROM SigCdCeg WHERE TpCads = 3 ORDER BY Emps"
732: 
733:                 loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
734: 
735:                 IF loc_nRet < 0
736:                     MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
737:                     loc_lResultado = .F.
738:                 ELSE
739:                     loc_oGrid.ColumnCount = 4
740:                     loc_oGrid.RecordSource = "cursor_4c_Estoque"
741: 
742:                     loc_oGrid.Column1.chk_4c_nMarca.ControlSource  = "cursor_4c_Estoque.nMarca"
743:                     loc_oGrid.Column2.txt_4c_Empresa.ControlSource  = "cursor_4c_Estoque.Emps"
744:                     loc_oGrid.Column3.txt_4c_Grupo.ControlSource    = "cursor_4c_Estoque.Grupos"
745:                     loc_oGrid.Column4.txt_4c_Conta.ControlSource    = "cursor_4c_Estoque.Contas"
746: 
747:                     loc_oGrid.Column1.Header1.Caption = ""
748:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
749:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
750:                     loc_oGrid.Column4.Header1.Caption = "Conta"
751: 
752:                     loc_lResultado = .T.
753:                 ENDIF
754:             ENDIF
755: 
756:         CATCH TO loc_oErro
757:             MsgErro("Erro em CarregarEstoque:" + CHR(13) + loc_oErro.Message, "Erro")
758:             loc_lResultado = .F.
759:         ENDTRY
760: 

*-- Linhas 829 a 894:
829:     *==========================================================================
830:     * BtnVisualizarClick - Abre Page2 para visualizacao do registro selecionado
831:     *==========================================================================
832:     PROCEDURE BtnVisualizarClick()
833:         LOCAL loc_cCodigo
834:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
835:             MsgAviso("Nenhum registro selecionado.", "Aviso")
836:             RETURN
837:         ENDIF
838: 
839:         SELECT cursor_4c_Lista
840:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
841: 
842:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
843:             THIS.this_cModoAtual = "VISUALIZAR"
844:             THIS.AlternarPagina(2)
845:         ENDIF
846:     ENDPROC
847: 
848:     *==========================================================================
849:     * BtnAlterarClick - Abre Page2 para alterar registro selecionado
850:     *==========================================================================
851:     PROCEDURE BtnAlterarClick()
852:         LOCAL loc_cCodigo
853:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
854:             MsgAviso("Nenhum registro selecionado.", "Aviso")
855:             RETURN
856:         ENDIF
857: 
858:         SELECT cursor_4c_Lista
859:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
860: 
861:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
862:             THIS.this_oBusinessObject.EditarRegistro()
863:             THIS.this_cModoAtual = "ALTERAR"
864:             THIS.AlternarPagina(2)
865:         ENDIF
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
870:     *==========================================================================
871:     PROCEDURE BtnExcluirClick()
872:         LOCAL loc_cCodigo
873:         IF !USED("cursor_4c_Lista") OR EOF("cursor_4c_Lista")
874:             MsgAviso("Nenhum registro selecionado.", "Aviso")
875:             RETURN
876:         ENDIF
877: 
878:         SELECT cursor_4c_Lista
879:         loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
880: 
881:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da distribui" + ;
882:                         CHR(231) + CHR(227) + "o " + loc_cCodigo + "?", ;
883:                         "Confirmar Exclus" + CHR(227) + "o")
884:             RETURN
885:         ENDIF
886: 
887:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
888:             IF THIS.this_oBusinessObject.Excluir()
889:                 MsgInfo("Distribui" + CHR(231) + CHR(227) + "o exclu" + ;
890:                         CHR(237) + "da com sucesso.", "")
891:                 THIS.CarregarLista()
892:             ENDIF
893:         ENDIF
894:     ENDPROC

*-- Linhas 949 a 995:
949:         loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
950: 
951:         TRY
952:             loc_nVal = loc_oPage.cmg_4c_MarcaDesmarca.Value
953: 
954:             IF USED("cursor_4c_Estoque")
955:                 IF loc_nVal = 1
956:                     REPLACE ALL nMarca WITH 1 IN cursor_4c_Estoque
957:                 ELSE
958:                     REPLACE ALL nMarca WITH 0 IN cursor_4c_Estoque
959:                 ENDIF
960:                 loc_oPage.grd_4c_Estoque.Refresh()
961:             ENDIF
962: 
963:         CATCH TO loc_oErro
964:             MsgErro("Erro em CmgMarcaDesmarcaClick:" + CHR(13) + loc_oErro.Message, "Erro")
965:         ENDTRY
966:     ENDPROC
967: 
968:     *==========================================================================
969:     * BtnProcessarClick - Processa selecao de estoques e abre aba Distribuicao
970:     *==========================================================================
971:     PROCEDURE BtnProcessarClick()
972:         LOCAL loc_oErro
973: 
974:         IF !USED("cursor_4c_Estoque") OR RECCOUNT("cursor_4c_Estoque") = 0
975:             MsgAviso("Nenhum estoque dispon" + CHR(237) + "vel para processar.", "Processar")
976:             RETURN
977:         ENDIF
978: 
979:         TRY
980:             IF THIS.this_oBusinessObject.ProcessarDistribuicao("cursor_4c_Estoque")
981:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.Enabled = .T.
982:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.Enabled = .T.
983:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage    = 2
984:                 THIS.CarregarDisponivel()
985:             ENDIF
986: 
987:         CATCH TO loc_oErro
988:             MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message, "Erro")
989:         ENDTRY
990:     ENDPROC
991: 
992:     *==========================================================================
993:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
994:     *==========================================================================
995:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)

*-- Linhas 1036 a 1071:
1036:         *-- Shape borda ao redor da imagem (Shape5: top=5, left=4, width=163, height=93)
1037:         loc_oPage.AddObject("shp_4c_FigBorda", "Shape")
1038:         WITH loc_oPage.shp_4c_FigBorda
1039:             .Top         = 5
1040:             .Left        = 4
1041:             .Width       = 163
1042:             .Height      = 93
1043:             .BorderColor = RGB(128, 128, 128)
1044:             .BorderWidth = 1
1045:             .BorderStyle = 1
1046:             .FillStyle   = 1
1047:             .Visible     = .T.
1048:         ENDWITH
1049: 
1050:         *-- Imagem do produto (FigJpg: top=7, left=6, width=159, height=89)
1051:         loc_oPage.AddObject("img_4c_FigJpg", "Image")
1052:         WITH loc_oPage.img_4c_FigJpg
1053:             .Top     = 7
1054:             .Left    = 6
1055:             .Width   = 159
1056:             .Height  = 89
1057:             .Stretch = 2
1058:             .Visible = .T.
1059:         ENDWITH
1060: 
1061:         *-- Label "Grupo :" (Say9: top=59, left=174, width=38)
1062:         loc_oPage.AddObject("lbl_4c_GrupoDist", "Label")
1063:         WITH loc_oPage.lbl_4c_GrupoDist
1064:             .Caption   = "Grupo :"
1065:             .Top       = 59
1066:             .Left      = 174
1067:             .Width     = 38
1068:             .Height    = 15
1069:             .AutoSize  = .F.
1070:             .FontName  = "Tahoma"
1071:             .FontSize  = 8

*-- Linhas 1078 a 1087:
1078:         loc_oPage.AddObject("txt_4c_CodGrupoDist", "TextBox")
1079:         WITH loc_oPage.txt_4c_CodGrupoDist
1080:             .Value       = ""
1081:             .Top         = 74
1082:             .Left        = 175
1083:             .Width       = 35
1084:             .Height      = 23
1085:             .FontName    = "Tahoma"
1086:             .FontSize    = 8
1087:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1094 a 1119:
1094:         loc_oPage.AddObject("txt_4c_DscGrupoDist", "TextBox")
1095:         WITH loc_oPage.txt_4c_DscGrupoDist
1096:             .Value       = ""
1097:             .Top         = 74
1098:             .Left        = 211
1099:             .Width       = 208
1100:             .Height      = 23
1101:             .FontName    = "Tahoma"
1102:             .FontSize    = 8
1103:             .BackColor   = RGB(255, 255, 255)
1104:             .ForeColor   = RGB(0, 0, 0)
1105:             .BorderStyle = 1
1106:             .Visible     = .T.
1107:         ENDWITH
1108: 
1109:         *-- Label "Subgrupo :" (Say11: top=100, left=174, width=55)
1110:         loc_oPage.AddObject("lbl_4c_SgrupoDist", "Label")
1111:         WITH loc_oPage.lbl_4c_SgrupoDist
1112:             .Caption   = "Subgrupo :"
1113:             .Top       = 100
1114:             .Left      = 174
1115:             .Width     = 55
1116:             .Height    = 15
1117:             .AutoSize  = .F.
1118:             .FontName  = "Tahoma"
1119:             .FontSize  = 8

*-- Linhas 1126 a 1135:
1126:         loc_oPage.AddObject("txt_4c_CodSgrupoDist", "TextBox")
1127:         WITH loc_oPage.txt_4c_CodSgrupoDist
1128:             .Value       = ""
1129:             .Top         = 115
1130:             .Left        = 175
1131:             .Width       = 52
1132:             .Height      = 23
1133:             .FontName    = "Tahoma"
1134:             .FontSize    = 8
1135:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1142 a 1169:
1142:         loc_oPage.AddObject("txt_4c_DscSgrupoDist", "TextBox")
1143:         WITH loc_oPage.txt_4c_DscSgrupoDist
1144:             .Value       = ""
1145:             .Top         = 115
1146:             .Left        = 228
1147:             .Width       = 236
1148:             .Height      = 23
1149:             .FontName    = "Tahoma"
1150:             .FontSize    = 8
1151:             .BackColor   = RGB(255, 255, 255)
1152:             .ForeColor   = RGB(0, 0, 0)
1153:             .BorderStyle = 1
1154:             .Visible     = .T.
1155:         ENDWITH
1156: 
1157:         *-- Botao Filtrar (Filtrar: top=73, left=424, width=40, height=40)
1158:         loc_oPage.AddObject("cmd_4c_Filtrar", "CommandButton")
1159:         WITH loc_oPage.cmd_4c_Filtrar
1160:             .Caption         = "Filtrar"
1161:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
1162:             .PicturePosition = 13
1163:             .Top             = 73
1164:             .Left            = 424
1165:             .Width           = 40
1166:             .Height          = 40
1167:             .FontName        = "Tahoma"
1168:             .FontBold        = .T.
1169:             .FontSize        = 7

*-- Linhas 1178 a 1190:
1178:         ENDWITH
1179: 
1180:         *-- Label "Procurar" (lbl_produto: top=100, left=4, width=43)
1181:         loc_oPage.AddObject("lbl_4c_ProdutoProc", "Label")
1182:         WITH loc_oPage.lbl_4c_ProdutoProc
1183:             .Caption   = "Procurar"
1184:             .Top       = 100
1185:             .Left      = 4
1186:             .Width     = 43
1187:             .Height    = 15
1188:             .AutoSize  = .F.
1189:             .FontName  = "Tahoma"
1190:             .FontSize  = 8

*-- Linhas 1197 a 1206:
1197:         loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
1198:         WITH loc_oPage.txt_4c_ProdutoInicial
1199:             .Value       = ""
1200:             .Top         = 116
1201:             .Left        = 2
1202:             .Width       = 108
1203:             .Height      = 22
1204:             .FontName    = "Tahoma"
1205:             .FontSize    = 8
1206:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 1214 a 1223:
1214:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1215: 
1216:         WITH loc_oPage.grd_4c_Disponivel
1217:             .Top                = 141
1218:             .Left               = 1
1219:             .Width              = 663
1220:             .Height             = 327
1221:             .FontName           = "Verdana"
1222:             .FontSize           = 8
1223:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1232 a 1252:
1232:             .ScrollBars         = 2
1233:             .GridLines          = 3
1234:             .Visible            = .T.
1235:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
1236:             .Column1.Width           = 90
1237:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1238:             .Column2.Width           = 200
1239:             .Column3.Header1.Caption = "Cor"
1240:             .Column3.Width           = 60
1241:             .Column4.Header1.Caption = "Tam"
1242:             .Column4.Width           = 40
1243:             .Column5.Header1.Caption = "Estoque"
1244:             .Column5.Width           = 70
1245:             .Column6.Header1.Caption = "Saldo"
1246:             .Column6.Width           = 70
1247:             .Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
1248:             .Column7.Width           = 70
1249:         ENDWITH
1250: 
1251:         *-- Controles read-only nas colunas (When=.F. no legado)
1252:         loc_oGrid = loc_oPage.grd_4c_Disponivel

*-- Linhas 1284 a 1293:
1284:         loc_oPage.grd_4c_Distribui.ColumnCount = 4
1285: 
1286:         WITH loc_oPage.grd_4c_Distribui
1287:             .Top                = 141
1288:             .Left               = 664
1289:             .Width              = 334
1290:             .Height             = 327
1291:             .FontName           = "Verdana"
1292:             .FontSize           = 8
1293:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 1302 a 1316:
1302:             .ScrollBars         = 2
1303:             .GridLines          = 3
1304:             .Visible            = .T.
1305:             .Column1.Header1.Caption = "Empresa"
1306:             .Column1.Width           = 60
1307:             .Column2.Header1.Caption = "Saldo"
1308:             .Column2.Width           = 70
1309:             .Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1310:             .Column3.Width           = 80
1311:             .Column4.Header1.Caption = "Local"
1312:             .Column4.Width           = 90
1313:         ENDWITH
1314: 
1315:         *-- Col1/Col2 read-only; Col3 editavel (QtdDistr); Col4 editavel com lookup Local
1316:         loc_oGrid = loc_oPage.grd_4c_Distribui

*-- Linhas 1331 a 1595:
1331: 
1332:         *-- Painel de info produto (somente leitura) -- top 470-540
1333:         *-- Row 1: Grupo / Linha (top=470-474)
1334:         loc_oPage.AddObject("lbl_4c_GrupoInfo", "Label")
1335:         WITH loc_oPage.lbl_4c_GrupoInfo
1336:             .Caption   = "Grupo :"
1337:             .Top       = 474
1338:             .Left      = 67
1339:             .Width     = 38
1340:             .Height    = 15
1341:             .AutoSize  = .F.
1342:             .BackStyle = 0
1343:         ENDWITH
1344: 
1345:         loc_oPage.AddObject("txt_4c_CdGrupoInfo", "TextBox")
1346:         WITH loc_oPage.txt_4c_CdGrupoInfo
1347:             .Value    = ""
1348:             .Top      = 470
1349:             .Left     = 116
1350:             .Width    = 65
1351:             .Height   = 21
1352:             .ReadOnly = .T.
1353:         ENDWITH
1354: 
1355:         loc_oPage.AddObject("txt_4c_DsGrupoInfo", "TextBox")
1356:         WITH loc_oPage.txt_4c_DsGrupoInfo
1357:             .Value    = ""
1358:             .Top      = 470
1359:             .Left     = 182
1360:             .Width    = 270
1361:             .Height   = 21
1362:             .ReadOnly = .T.
1363:         ENDWITH
1364: 
1365:         loc_oPage.AddObject("lbl_4c_LinhaInfo", "Label")
1366:         WITH loc_oPage.lbl_4c_LinhaInfo
1367:             .Caption   = "Linha :"
1368:             .Top       = 473
1369:             .Left      = 549
1370:             .Width     = 34
1371:             .Height    = 15
1372:             .AutoSize  = .F.
1373:             .BackStyle = 0
1374:         ENDWITH
1375: 
1376:         loc_oPage.AddObject("txt_4c_CdLinhaInfo", "TextBox")
1377:         WITH loc_oPage.txt_4c_CdLinhaInfo
1378:             .Value    = ""
1379:             .Top      = 470
1380:             .Left     = 593
1381:             .Width    = 80
1382:             .Height   = 21
1383:             .ReadOnly = .T.
1384:         ENDWITH
1385: 
1386:         loc_oPage.AddObject("txt_4c_DsLinhaInfo", "TextBox")
1387:         WITH loc_oPage.txt_4c_DsLinhaInfo
1388:             .Value    = ""
1389:             .Top      = 470
1390:             .Left     = 674
1391:             .Width    = 255
1392:             .Height   = 21
1393:             .ReadOnly = .T.
1394:         ENDWITH
1395: 
1396:         *-- Row 2: Subgrupo / Fornecedor (top=492-497)
1397:         loc_oPage.AddObject("lbl_4c_SgrupoInfo", "Label")
1398:         WITH loc_oPage.lbl_4c_SgrupoInfo
1399:             .Caption   = "Subgrupo :"
1400:             .Top       = 497
1401:             .Left      = 50
1402:             .Width     = 55
1403:             .Height    = 15
1404:             .AutoSize  = .F.
1405:             .BackStyle = 0
1406:         ENDWITH
1407: 
1408:         loc_oPage.AddObject("txt_4c_CdSgrupoInfo", "TextBox")
1409:         WITH loc_oPage.txt_4c_CdSgrupoInfo
1410:             .Value    = ""
1411:             .Top      = 492
1412:             .Left     = 116
1413:             .Width    = 65
1414:             .Height   = 21
1415:             .ReadOnly = .T.
1416:         ENDWITH
1417: 
1418:         loc_oPage.AddObject("txt_4c_DsSgrupoInfo", "TextBox")
1419:         WITH loc_oPage.txt_4c_DsSgrupoInfo
1420:             .Value    = ""
1421:             .Top      = 492
1422:             .Left     = 182
1423:             .Width    = 270
1424:             .Height   = 21
1425:             .ReadOnly = .T.
1426:         ENDWITH
1427: 
1428:         loc_oPage.AddObject("lbl_4c_FornInfo", "Label")
1429:         WITH loc_oPage.lbl_4c_FornInfo
1430:             .Caption   = "Fornecedor :"
1431:             .Top       = 495
1432:             .Left      = 519
1433:             .Width     = 64
1434:             .Height    = 15
1435:             .AutoSize  = .F.
1436:             .BackStyle = 0
1437:         ENDWITH
1438: 
1439:         loc_oPage.AddObject("txt_4c_CdFornInfo", "TextBox")
1440:         WITH loc_oPage.txt_4c_CdFornInfo
1441:             .Value    = ""
1442:             .Top      = 492
1443:             .Left     = 593
1444:             .Width    = 80
1445:             .Height   = 21
1446:             .ReadOnly = .T.
1447:         ENDWITH
1448: 
1449:         loc_oPage.AddObject("txt_4c_DsFornInfo", "TextBox")
1450:         WITH loc_oPage.txt_4c_DsFornInfo
1451:             .Value    = ""
1452:             .Top      = 492
1453:             .Left     = 674
1454:             .Width    = 255
1455:             .Height   = 21
1456:             .ReadOnly = .T.
1457:         ENDWITH
1458: 
1459:         *-- Row 3: Modelo / Ref.Fornecedor (top=514-517)
1460:         loc_oPage.AddObject("lbl_4c_ModeloInfo", "Label")
1461:         WITH loc_oPage.lbl_4c_ModeloInfo
1462:             .Caption   = "Modelo :"
1463:             .Top       = 517
1464:             .Left      = 62
1465:             .Width     = 43
1466:             .Height    = 15
1467:             .AutoSize  = .F.
1468:             .BackStyle = 0
1469:         ENDWITH
1470: 
1471:         loc_oPage.AddObject("txt_4c_CodModeloInfo", "TextBox")
1472:         WITH loc_oPage.txt_4c_CodModeloInfo
1473:             .Value    = ""
1474:             .Top      = 514
1475:             .Left     = 116
1476:             .Width    = 65
1477:             .Height   = 21
1478:             .ReadOnly = .T.
1479:         ENDWITH
1480: 
1481:         loc_oPage.AddObject("txt_4c_DsModeloInfo", "TextBox")
1482:         WITH loc_oPage.txt_4c_DsModeloInfo
1483:             .Value    = ""
1484:             .Top      = 514
1485:             .Left     = 182
1486:             .Width    = 270
1487:             .Height   = 21
1488:             .ReadOnly = .T.
1489:         ENDWITH
1490: 
1491:         loc_oPage.AddObject("lbl_4c_RefFornInfo", "Label")
1492:         WITH loc_oPage.lbl_4c_RefFornInfo
1493:             .Caption   = "Ref. Fornecedor :"
1494:             .Top       = 517
1495:             .Left      = 495
1496:             .Width     = 88
1497:             .Height    = 15
1498:             .AutoSize  = .F.
1499:             .BackStyle = 0
1500:         ENDWITH
1501: 
1502:         loc_oPage.AddObject("txt_4c_RefFornInfo", "TextBox")
1503:         WITH loc_oPage.txt_4c_RefFornInfo
1504:             .Value    = ""
1505:             .Top      = 514
1506:             .Left     = 593
1507:             .Width    = 190
1508:             .Height   = 21
1509:             .ReadOnly = .T.
1510:         ENDWITH
1511: 
1512:         *-- Row 4: Grupo de Venda / Preco Venda / Peso (top=536-540)
1513:         loc_oPage.AddObject("lbl_4c_GrVendaInfo", "Label")
1514:         WITH loc_oPage.lbl_4c_GrVendaInfo
1515:             .Caption   = "Grupo de Venda :"
1516:             .Top       = 540
1517:             .Left      = 19
1518:             .Width     = 86
1519:             .Height    = 15
1520:             .AutoSize  = .F.
1521:             .BackStyle = 0
1522:         ENDWITH
1523: 
1524:         loc_oPage.AddObject("txt_4c_CdGrVendaInfo", "TextBox")
1525:         WITH loc_oPage.txt_4c_CdGrVendaInfo
1526:             .Value    = ""
1527:             .Top      = 537
1528:             .Left     = 116
1529:             .Width    = 80
1530:             .Height   = 21
1531:             .ReadOnly = .T.
1532:         ENDWITH
1533: 
1534:         loc_oPage.AddObject("txt_4c_DsGrVendaInfo", "TextBox")
1535:         WITH loc_oPage.txt_4c_DsGrVendaInfo
1536:             .Value    = ""
1537:             .Top      = 537
1538:             .Left     = 197
1539:             .Width    = 255
1540:             .Height   = 21
1541:             .ReadOnly = .T.
1542:         ENDWITH
1543: 
1544:         loc_oPage.AddObject("lbl_4c_PrVendaInfo", "Label")
1545:         WITH loc_oPage.lbl_4c_PrVendaInfo
1546:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1547:             .Top       = 540
1548:             .Left      = 514
1549:             .Width     = 69
1550:             .Height    = 15
1551:             .AutoSize  = .F.
1552:             .BackStyle = 0
1553:         ENDWITH
1554: 
1555:         loc_oPage.AddObject("txt_4c_PrVendaInfo", "TextBox")
1556:         WITH loc_oPage.txt_4c_PrVendaInfo
1557:             .Value    = ""
1558:             .Top      = 536
1559:             .Left     = 593
1560:             .Width    = 108
1561:             .Height   = 22
1562:             .ReadOnly = .T.
1563:         ENDWITH
1564: 
1565:         loc_oPage.AddObject("txt_4c_PrVendaMoeInfo", "TextBox")
1566:         WITH loc_oPage.txt_4c_PrVendaMoeInfo
1567:             .Value    = ""
1568:             .Top      = 536
1569:             .Left     = 703
1570:             .Width    = 31
1571:             .Height   = 22
1572:             .ReadOnly = .T.
1573:         ENDWITH
1574: 
1575:         loc_oPage.AddObject("lbl_4c_PesoInfo", "Label")
1576:         WITH loc_oPage.lbl_4c_PesoInfo
1577:             .Caption   = "Peso :"
1578:             .Top       = 540
1579:             .Left      = 775
1580:             .Width     = 38
1581:             .Height    = 15
1582:             .AutoSize  = .F.
1583:             .BackStyle = 0
1584:         ENDWITH
1585: 
1586:         loc_oPage.AddObject("txt_4c_PesoMedioInfo", "TextBox")
1587:         WITH loc_oPage.txt_4c_PesoMedioInfo
1588:             .Value    = ""
1589:             .Top      = 537
1590:             .Left     = 816
1591:             .Width    = 75
1592:             .Height   = 21
1593:             .ReadOnly = .T.
1594:         ENDWITH
1595: 

*-- Linhas 1604 a 1612:
1604:         BINDEVENT(loc_oPage.txt_4c_DscGrupoDist,   "KeyPress", THIS, "GrupoDscDistValid")
1605:         BINDEVENT(loc_oPage.txt_4c_CodSgrupoDist,  "KeyPress", THIS, "SgrupoCodDistValid")
1606:         BINDEVENT(loc_oPage.txt_4c_DscSgrupoDist,  "KeyPress", THIS, "SgrupoDscDistValid")
1607:         BINDEVENT(loc_oPage.cmd_4c_Filtrar,        "Click", THIS, "FiltrarDisponivelClick")
1608:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProdutoInicialValid")
1609: 
1610:         THIS.TornarControlesVisiveis(loc_oPage)
1611:     ENDPROC
1612: 

*-- Linhas 1636 a 1650:
1636:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1637:                 loc_oGrid.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1638: 
1639:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1640:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1641:                 loc_oGrid.Column3.Header1.Caption = "Cor"
1642:                 loc_oGrid.Column4.Header1.Caption = "Tam"
1643:                 loc_oGrid.Column5.Header1.Caption = "Estoque"
1644:                 loc_oGrid.Column6.Header1.Caption = "Saldo"
1645:                 loc_oGrid.Column7.Header1.Caption = "Distribu" + CHR(237) + "do"
1646: 
1647:                 THIS.FormatarGridLista(loc_oGrid)
1648:                 loc_oGrid.Refresh()
1649: 
1650:                 THIS.CarregarDistribui()

*-- Linhas 1684 a 1695:
1684:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1685:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Distribui.CidChaves"
1686: 
1687:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1688:                 loc_oGrid.Column2.Header1.Caption = "Saldo"
1689:                 loc_oGrid.Column3.Header1.Caption = "Distribu" + CHR(237) + "do"
1690:                 loc_oGrid.Column4.Header1.Caption = "Local"
1691: 
1692:                 THIS.FormatarGridLista(loc_oGrid)
1693:                 loc_oGrid.Refresh()
1694: 
1695:                 loc_lResultado = .T.

*-- Linhas 2198 a 2257:
2198:         *-- Container de Observacao (cntOperacao: top=13, left=3, width=564, height=165)
2199:         loc_oPage.AddObject("cnt_4c_Operacao", "Container")
2200:         WITH loc_oPage.cnt_4c_Operacao
2201:             .Top       = 13
2202:             .Left      = 3
2203:             .Width     = 564
2204:             .Height    = 165
2205:             .BackStyle = 0
2206:             .Visible   = .T.
2207:         ENDWITH
2208:         loc_oCnt = loc_oPage.cnt_4c_Operacao
2209: 
2210:         loc_oCnt.AddObject("lbl_4c_Obs", "Label")
2211:         WITH loc_oCnt.lbl_4c_Obs
2212:             .Caption   = "Obs:"
2213:             .Top       = 10
2214:             .Left      = 12
2215:             .Width     = 35
2216:             .Height    = 15
2217:             .AutoSize  = .F.
2218:             .BackStyle = 0
2219:             .FontName  = "Tahoma"
2220:             .FontSize  = 8
2221:             .Visible   = .T.
2222:         ENDWITH
2223: 
2224:         loc_oCnt.AddObject("txt_4c_CodObs", "TextBox")
2225:         WITH loc_oCnt.txt_4c_CodObs
2226:             .Value    = ""
2227:             .Top      = 8
2228:             .Left     = 52
2229:             .Width    = 27
2230:             .Height   = 20
2231:             .Visible  = .T.
2232:         ENDWITH
2233: 
2234:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
2235:         WITH loc_oCnt.edt_4c_Obs
2236:             .Value     = ""
2237:             .Top       = 8
2238:             .Left      = 83
2239:             .Width     = 407
2240:             .Height    = 112
2241:             .ScrollBars = 2
2242:             .Visible   = .T.
2243:         ENDWITH
2244: 
2245:         *-- Botao Processar Final (cmdProcessar: top=11, left=733, width=105, height=122)
2246:         loc_oPage.AddObject("cmd_4c_ProcessarFinal", "CommandButton")
2247:         WITH loc_oPage.cmd_4c_ProcessarFinal
2248:             .Caption         = "Processar"
2249:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
2250:             .PicturePosition = 13
2251:             .Top             = 11
2252:             .Left            = 733
2253:             .Width           = 105
2254:             .Height          = 122
2255:             .FontName        = "Tahoma"
2256:             .FontBold        = .T.
2257:             .FontItalic      = .T.

*-- Linhas 2266 a 2299:
2266:             .Visible         = .T.
2267:         ENDWITH
2268: 
2269:         BINDEVENT(loc_oPage.cmd_4c_ProcessarFinal, "Click", THIS, "BtnProcessarFinalClick")
2270: 
2271:         *-- Sub-PageFrame Operacoes (pgOperacoes: top=191, left=1, width=997, height=377)
2272:         loc_oPage.AddObject("pgf_4c_Operacoes", "PageFrame")
2273:         WITH loc_oPage.pgf_4c_Operacoes
2274:             .Top      = 191
2275:             .Left     = 1
2276:             .Width    = 997
2277:             .Height   = 377
2278:             .PageCount = 2
2279:             .Tabs     = .T.
2280:             .Visible  = .T.
2281:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es"
2282:             .Page2.Caption   = "Itens"
2283:             .Page1.BackColor = RGB(224, 224, 224)
2284:             .Page2.BackColor = RGB(224, 224, 224)
2285:         ENDWITH
2286:         loc_oPgfOp = loc_oPage.pgf_4c_Operacoes
2287: 
2288:         *-- grd_4c_CabOperas na Page1 (grdCabOperas: 8 cols, top=6, left=9, width=975, height=339)
2289:         loc_oPgfOp.Page1.AddObject("grd_4c_CabOperas", "Grid")
2290:         loc_oPgfOp.Page1.grd_4c_CabOperas.ColumnCount = 8
2291: 
2292:         WITH loc_oPgfOp.Page1.grd_4c_CabOperas
2293:             .Top                = 6
2294:             .Left               = 9
2295:             .Width              = 975
2296:             .Height             = 339
2297:             .FontName           = "Verdana"
2298:             .FontSize           = 8
2299:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2309 a 2331:
2309:             .GridLines          = 3
2310:             .ReadOnly           = .T.
2311:             .Visible            = .T.
2312:             .Column1.Header1.Caption = "Emp O"
2313:             .Column1.Width           = 55
2314:             .Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2315:             .Column2.Width           = 110
2316:             .Column3.Header1.Caption = "C" + CHR(243) + "digo"
2317:             .Column3.Width           = 130
2318:             .Column4.Header1.Caption = "Emp D"
2319:             .Column4.Width           = 55
2320:             .Column5.Header1.Caption = "Grupo Orig"
2321:             .Column5.Width           = 105
2322:             .Column6.Header1.Caption = "Conta Orig"
2323:             .Column6.Width           = 105
2324:             .Column7.Header1.Caption = "Grupo Dest"
2325:             .Column7.Width           = 105
2326:             .Column8.Header1.Caption = "Conta Dest"
2327:             .Column8.Width           = 105
2328:         ENDWITH
2329: 
2330:         loc_oGrid = loc_oPgfOp.Page1.grd_4c_CabOperas
2331:         loc_oGrid.Column1.AddObject("txt_4c_Col01", "TextBox")

*-- Linhas 2358 a 2367:
2358:         loc_oPgfOp.Page2.grd_4c_ItnOperas.ColumnCount = 9
2359: 
2360:         WITH loc_oPgfOp.Page2.grd_4c_ItnOperas
2361:             .Top                = 5
2362:             .Left               = 9
2363:             .Width              = 975
2364:             .Height             = 340
2365:             .FontName           = "Verdana"
2366:             .FontSize           = 8
2367:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 2377 a 2401:
2377:             .GridLines          = 3
2378:             .ReadOnly           = .T.
2379:             .Visible            = .T.
2380:             .Column1.Header1.Caption = "Item"
2381:             .Column1.Width           = 50
2382:             .Column2.Header1.Caption = "C" + CHR(243) + "digo"
2383:             .Column2.Width           = 100
2384:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2385:             .Column3.Width           = 200
2386:             .Column4.Header1.Caption = "Uni"
2387:             .Column4.Width           = 40
2388:             .Column5.Header1.Caption = "Quantidade"
2389:             .Column5.Width           = 90
2390:             .Column6.Header1.Caption = "Unit" + CHR(225) + "rio"
2391:             .Column6.Width           = 90
2392:             .Column7.Header1.Caption = "Total"
2393:             .Column7.Width           = 90
2394:             .Column8.Header1.Caption = "Cor"
2395:             .Column8.Width           = 60
2396:             .Column9.Header1.Caption = "Tam"
2397:             .Column9.Width           = 60
2398:         ENDWITH
2399: 
2400:         loc_oGrid = loc_oPgfOp.Page2.grd_4c_ItnOperas
2401:         loc_oGrid.Column1.AddObject("txt_4c_Itn01", "TextBox")

*-- Linhas 2436 a 2457:
2436:     *==========================================================================
2437:     PROCEDURE PgItensActivate()
2438:         LOCAL loc_oPage, loc_oErro
2439: 
2440:         TRY
2441:             IF USED("cursor_4c_ItnOperas")
2442:                 GO TOP IN cursor_4c_ItnOperas
2443:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2444:                 IF VARTYPE(loc_oPage) = "O" AND VARTYPE(loc_oPage.grd_4c_ItnOperas) = "O"
2445:                     loc_oPage.grd_4c_ItnOperas.Refresh()
2446:                 ENDIF
2447:             ENDIF
2448: 
2449:         CATCH TO loc_oErro
2450:             MsgErro("Erro em PgItensActivate:" + CHR(13) + loc_oErro.Message, "Erro")
2451:         ENDTRY
2452:     ENDPROC
2453: 
2454:     *==========================================================================
2455:     * BtnProcessarFinalClick - Valida, salva lote em sigprdis e exibe operacoes
2456:     *==========================================================================
2457:     PROCEDURE BtnProcessarFinalClick()

*-- Linhas 2484 a 2623:
2484:         TRY
2485:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page1
2486:             loc_oGrid   = loc_oPage.grd_4c_CabOperas
2487:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2488: 
2489:             IF USED("cursor_4c_CabOperas")
2490:                 USE IN cursor_4c_CabOperas
2491:             ENDIF
2492: 
2493:             loc_cSQL = "SELECT DISTINCT RTRIM(c.emps) AS emps, " + ;
2494:                        "RTRIM(c.dopes) AS dopes, " + ;
2495:                        "c.numes AS numes, " + ;
2496:                        "RTRIM(c.empds) AS empds, " + ;
2497:                        "RTRIM(c.grupoos) AS grupoos, RTRIM(c.contaos) AS contaos, " + ;
2498:                        "RTRIM(c.grupods) AS grupods, RTRIM(c.contads) AS contads " + ;
2499:                        "FROM SigMvCab c " + ;
2500:                        "WHERE EXISTS (" + ;
2501:                        " SELECT 1 FROM sigprdis d WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2502:                        " AND (RTRIM(d.empdopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2503:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)" + ;
2504:                        " OR RTRIM(d.oridopnums) = RTRIM(c.emps) + RTRIM(c.dopes)" + ;
2505:                        "  + RIGHT(REPLICATE('0',6) + LTRIM(STR(c.numes,6)),6)))" + ;
2506:                        " ORDER BY c.emps, c.dopes"
2507: 
2508:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOperas")
2509: 
2510:             IF loc_nRet < 0
2511:                 MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + ;
2512:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2513:             ELSE
2514:                 loc_oGrid.ColumnCount = 8
2515:                 loc_oGrid.RecordSource = "cursor_4c_CabOperas"
2516:                 loc_oGrid.Column1.txt_4c_Col01.ControlSource = "cursor_4c_CabOperas.emps"
2517:                 loc_oGrid.Column2.txt_4c_Col02.ControlSource = "cursor_4c_CabOperas.dopes"
2518:                 loc_oGrid.Column3.txt_4c_Col03.ControlSource = "cursor_4c_CabOperas.numes"
2519:                 loc_oGrid.Column4.txt_4c_Col04.ControlSource = "cursor_4c_CabOperas.empds"
2520:                 loc_oGrid.Column5.txt_4c_Col05.ControlSource = "cursor_4c_CabOperas.grupoos"
2521:                 loc_oGrid.Column6.txt_4c_Col06.ControlSource = "cursor_4c_CabOperas.contaos"
2522:                 loc_oGrid.Column7.txt_4c_Col07.ControlSource = "cursor_4c_CabOperas.grupods"
2523:                 loc_oGrid.Column8.txt_4c_Col08.ControlSource = "cursor_4c_CabOperas.contads"
2524:                 loc_oGrid.Refresh()
2525:             ENDIF
2526: 
2527:         CATCH TO loc_oErro
2528:             MsgErro("Erro em CarregarCabOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2529:         ENDTRY
2530:     ENDPROC
2531: 
2532:     *==========================================================================
2533:     * CarregarItnOperas - Carrega grd_4c_ItnOperas com itens de movimentos do lote
2534:     *==========================================================================
2535:     PROTECTED PROCEDURE CarregarItnOperas()
2536:         LOCAL loc_cCodigos, loc_cSQL, loc_nRet, loc_oGrid, loc_oPage, loc_oErro
2537:         loc_oErro = .NULL.
2538: 
2539:         TRY
2540:             loc_oPage   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page3.pgf_4c_Operacoes.Page2
2541:             loc_oGrid   = loc_oPage.grd_4c_ItnOperas
2542:             loc_cCodigos = ALLTRIM(THIS.this_oBusinessObject.this_cCodigos)
2543: 
2544:             IF USED("cursor_4c_ItnOperas")
2545:                 USE IN cursor_4c_ItnOperas
2546:             ENDIF
2547: 
2548:             loc_cSQL = "SELECT RTRIM(b.cItens) AS Citens, RTRIM(b.CPros) AS CPros, " + ;
2549:                        "RTRIM(ISNULL(b.DPros,'')) AS Dpros, " + ;
2550:                        "RTRIM(b.Cunis) AS CUnis, b.Qtds, b.Units, b.totas, " + ;
2551:                        "RTRIM(c.CodCors) AS CodCors, RTRIM(c.CodTams) AS CodTams " + ;
2552:                        "FROM (SELECT DISTINCT d.EmpDopNums FROM sigprdis d" + ;
2553:                        " WHERE d.codigos = " + EscaparSQL(loc_cCodigos) + ;
2554:                        " AND RTRIM(d.EmpDopNums) <> '') x " + ;
2555:                        "INNER JOIN SigMvItn b ON x.EmpDopNums = b.EmpDopNums " + ;
2556:                        "INNER JOIN SigMvIts c ON b.EmpDopNums = c.EmpDopNums" + ;
2557:                        " AND b.cItens = c.Citens " + ;
2558:                        "ORDER BY b.cItens"
2559: 
2560:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOperas")
2561: 
2562:             IF loc_nRet < 0
2563:                 MsgErro("Erro ao carregar itens de opera" + CHR(231) + CHR(245) + "es:" + ;
2564:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
2565:             ELSE
2566:                 loc_oGrid.ColumnCount = 9
2567:                 loc_oGrid.RecordSource = "cursor_4c_ItnOperas"
2568:                 loc_oGrid.Column1.txt_4c_Itn01.ControlSource = "cursor_4c_ItnOperas.Citens"
2569:                 loc_oGrid.Column2.txt_4c_Itn02.ControlSource = "cursor_4c_ItnOperas.CPros"
2570:                 loc_oGrid.Column3.txt_4c_Itn03.ControlSource = "cursor_4c_ItnOperas.Dpros"
2571:                 loc_oGrid.Column4.txt_4c_Itn04.ControlSource = "cursor_4c_ItnOperas.CUnis"
2572:                 loc_oGrid.Column5.txt_4c_Itn05.ControlSource = "cursor_4c_ItnOperas.Qtds"
2573:                 loc_oGrid.Column6.txt_4c_Itn06.ControlSource = "cursor_4c_ItnOperas.Units"
2574:                 loc_oGrid.Column7.txt_4c_Itn07.ControlSource = "cursor_4c_ItnOperas.totas"
2575:                 loc_oGrid.Column8.txt_4c_Itn08.ControlSource = "cursor_4c_ItnOperas.CodCors"
2576:                 loc_oGrid.Column9.txt_4c_Itn09.ControlSource = "cursor_4c_ItnOperas.CodTams"
2577:                 loc_oGrid.Refresh()
2578:             ENDIF
2579: 
2580:         CATCH TO loc_oErro
2581:             MsgErro("Erro em CarregarItnOperas:" + CHR(13) + loc_oErro.Message, "Erro")
2582:         ENDTRY
2583:     ENDPROC
2584: 
2585:     *==========================================================================
2586:     * Destroy - Libera recursos ao fechar
2587:     *==========================================================================
2588:     PROCEDURE Destroy()
2589:         IF USED("cursor_4c_Lista")
2590:             USE IN cursor_4c_Lista
2591:         ENDIF
2592:         IF USED("cursor_4c_Estoque")
2593:             USE IN cursor_4c_Estoque
2594:         ENDIF
2595:         IF USED("cursor_4c_Disponivel")
2596:             USE IN cursor_4c_Disponivel
2597:         ENDIF
2598:         IF USED("cursor_4c_Distribui")
2599:             USE IN cursor_4c_Distribui
2600:         ENDIF
2601:         IF USED("cursor_4c_InfoPro")
2602:             USE IN cursor_4c_InfoPro
2603:         ENDIF
2604:         IF USED("cursor_4c_CabOperas")
2605:             USE IN cursor_4c_CabOperas
2606:         ENDIF
2607:         IF USED("cursor_4c_ItnOperas")
2608:             USE IN cursor_4c_ItnOperas
2609:         ENDIF
2610:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2611:             THIS.this_oBusinessObject = .NULL.
2612:         ENDIF
2613:         DODEFAULT()
2614:     ENDPROC
2615: 
2616:     *==========================================================================
2617:     * FormParaBO - Transfere periodo de filtro do form para o BO
2618:     *==========================================================================
2619:     PROCEDURE FormParaBO()
2620:         LOCAL loc_oPage1, loc_oErro
2621:         TRY
2622:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
2623:             IF VARTYPE(loc_oPage1) = "O"

*-- Linhas 2677 a 2698:
2677:                 IF VARTYPE(loc_oPage2Dados.txt_4c_ProdutoInicial) = "O"
2678:                     loc_oPage2Dados.txt_4c_ProdutoInicial.ReadOnly = !par_lHabilitar
2679:                 ENDIF
2680:                 IF VARTYPE(loc_oPage2Dados.cmd_4c_Filtrar)        = "O"
2681:                     loc_oPage2Dados.cmd_4c_Filtrar.Enabled         = par_lHabilitar
2682:                 ENDIF
2683:                 loc_oGrid = loc_oPage2Dados.grd_4c_Distribui
2684:                 IF VARTYPE(loc_oGrid) = "O"
2685:                     loc_oGrid.Column3.txt_4c_Dis03.ReadOnly = !par_lHabilitar
2686:                     loc_oGrid.Column4.txt_4c_Loc04.ReadOnly = !par_lHabilitar
2687:                 ENDIF
2688:             ENDIF
2689:             *-- Aba1 Estoques: processar e marca/desmarca
2690:             loc_oPage1Aba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2691:             IF VARTYPE(loc_oPage1Aba) = "O"
2692:                 IF VARTYPE(loc_oPage1Aba.cmd_4c_Processar)      = "O"
2693:                     loc_oPage1Aba.cmd_4c_Processar.Enabled      = par_lHabilitar
2694:                 ENDIF
2695:                 IF VARTYPE(loc_oPage1Aba.cmg_4c_MarcaDesmarca)  = "O"
2696:                     loc_oPage1Aba.cmg_4c_MarcaDesmarca.Enabled  = par_lHabilitar
2697:                 ENDIF
2698:             ENDIF

*-- Linhas 2789 a 2801:
2789:             loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2790:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2791:             IF VARTYPE(loc_oCnt) = "O"
2792:                 IF VARTYPE(loc_oCnt.cmd_4c_Salvar)   = "O"
2793:                     loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lEditar
2794:                 ENDIF
2795:                 IF VARTYPE(loc_oCnt.cmd_4c_Cancelar) = "O"
2796:                     loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
2797:                 ENDIF
2798:             ENDIF
2799:             THIS.HabilitarCampos(loc_lEditar)
2800:         CATCH TO loc_oErro
2801:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")


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

