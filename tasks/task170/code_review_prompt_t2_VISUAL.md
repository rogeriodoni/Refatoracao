# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (3556 linhas total):

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

*-- Linhas 75 a 84:
75:                 THIS.ConfigurarPageFrame()
76: 
77:                 *-- Propagar titulo para labels do cabecalho
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80: 
81:                 *-- Carregar lista inicial (pular se validando UI sem conexao SQL)
82:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
83:                     IF !THIS.CarregarLista()
84:                         *-- Falha ao carregar nao impede abertura do formulario

*-- Linhas 109 a 191:
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPageFrame - Cria PageFrame externo com 2 paginas (Lista/Dados)
112:     * PageFrame.Top = -29 para ocultar abas -> compensacao +29 nos controles
113:     *--------------------------------------------------------------------------
114:     PROTECTED PROCEDURE ConfigurarPageFrame()
115:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
116: 
117:         WITH THIS.pgf_4c_Paginas
118:             .Top       = -29
119:             .Left      = 0
120:             .Width     = THIS.Width
121:             .Height    = THIS.Height + 29
122:             .PageCount = 2
123:             .Tabs      = .F.
124:             .Visible   = .T.
125:         ENDWITH
126: 
127:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
128:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
130: 
131:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
132:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
133:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
134: 
135:         THIS.ConfigurarPaginaLista()
136:         THIS.ConfigurarPaginaDados()
137:     ENDPROC
138: 
139:     *--------------------------------------------------------------------------
140:     * ConfigurarPaginaLista - Configura Page1 (Lista)
141:     * Original: SIGPRCTR.Pagina.Lista
142:     * Contem: cabecalho, filtro periodo, botoes CRUD, grd_4c_Lista
143:     * Compensacao PageFrame.Top=-29: todos os controles com Top += 29
144:     *--------------------------------------------------------------------------
145:     PROTECTED PROCEDURE ConfigurarPaginaLista()
146:         LOCAL loc_oPagina, loc_oGrid
147:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
148:         loc_oGrid   = .NULL.
149: 
150:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
151: 
152:         *-- Container cabecalho com fundo escuro (cntSombra no legado)
153:         *-- Top = 2 + 29 (compensacao PageFrame.Top=-29) = 31
154:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
155:         WITH loc_oPagina.cnt_4c_Cabecalho
156:             .Top         = 31
157:             .Left        = 0
158:             .Width       = THIS.Width
159:             .Height      = 80
160:             .BackColor   = RGB(100, 100, 100)
161:             .BackStyle   = 1
162:             .BorderWidth = 0
163:             .Visible     = .T.
164:         ENDWITH
165: 
166:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
167:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
168:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
169:             .Top       = 15
170:             .Left      = 10
171:             .Width     = THIS.Width - 20
172:             .Height    = 40
173:             .FontName  = "Tahoma"
174:             .FontSize  = 16
175:             .FontBold  = .T.
176:             .ForeColor = RGB(0, 0, 0)
177:             .BackStyle = 0
178:             .AutoSize  = .F.
179:             .Visible   = .T.
180:         ENDWITH
181: 
182:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
183:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
184:             .Caption   = "Controle de Movimenta" + CHR(231) + CHR(245) + "es por XML"
185:             .Top       = 18
186:             .Left      = 10
187:             .Width     = THIS.Width - 20
188:             .Height    = 46
189:             .FontName  = "Tahoma"
190:             .FontSize  = 16
191:             .FontBold  = .T.

*-- Linhas 199 a 221:
199:         *-- Top = 0 + 29 (compensacao) = 29
200:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
201:         WITH loc_oPagina.cnt_4c_Botoes
202:             .Top         = 29
203:             .Left        = 542
204:             .Width       = 390
205:             .Height      = 85
206:             .BackStyle = 0
207:             .BorderWidth = 0
208:             .Visible     = .T.
209:         ENDWITH
210: 
211:         *-- Botao Incluir (Left=5)
212:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
213:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
214:             .Caption         = "Incluir"
215:             .Top             = 5
216:             .Left            = 5
217:             .Width           = 75
218:             .Height          = 75
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
220:             .PicturePosition = 13
221:             .FontName        = "Tahoma"

*-- Linhas 233 a 245:
233:         ENDWITH
234: 
235:         *-- Botao Visualizar (Left=80)
236:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
237:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
238:             .Caption         = "Visualizar"
239:             .Top             = 5
240:             .Left            = 80
241:             .Width           = 75
242:             .Height          = 75
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
244:             .PicturePosition = 13
245:             .FontName        = "Tahoma"

*-- Linhas 257 a 269:
257:         ENDWITH
258: 
259:         *-- Botao Alterar (Left=155)
260:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
261:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
262:             .Caption         = "Alterar"
263:             .Top             = 5
264:             .Left            = 155
265:             .Width           = 75
266:             .Height          = 75
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
268:             .PicturePosition = 13
269:             .FontName        = "Tahoma"

*-- Linhas 281 a 293:
281:         ENDWITH
282: 
283:         *-- Botao Excluir (Left=230)
284:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
285:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
286:             .Caption         = "Excluir"
287:             .Top             = 5
288:             .Left            = 230
289:             .Width           = 75
290:             .Height          = 75
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
292:             .PicturePosition = 13
293:             .FontName        = "Tahoma"

*-- Linhas 305 a 317:
305:         ENDWITH
306: 
307:         *-- Botao Buscar (Left=305)
308:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
310:             .Caption         = "Buscar"
311:             .Top             = 5
312:             .Left            = 305
313:             .Width           = 75
314:             .Height          = 75
315:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
316:             .PicturePosition = 13
317:             .FontName        = "Tahoma"

*-- Linhas 331 a 353:
331:         *-- Container saida - PADRAO CANONICO (CLAUDE.md regra #10: Left=917, Width=90)
332:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
333:         WITH loc_oPagina.cnt_4c_Saida
334:             .Top         = 29
335:             .Left        = 917
336:             .Width       = 90
337:             .Height      = 85
338:             .BackStyle   = 0
339:             .BorderWidth = 0
340:             .Visible     = .T.
341:         ENDWITH
342: 
343:         *-- Botao Encerrar (canonico: Left=5, Width=75, Height=75)
344:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
345:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
346:             .Caption         = "Encerrar"
347:             .Top             = 5
348:             .Left            = 5
349:             .Width           = 75
350:             .Height          = 75
351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
352:             .PicturePosition = 13
353:             .FontName        = "Tahoma"

*-- Linhas 366 a 378:
366: 
367:         *-- Filtro de periodo (original: Label1/Dt_inicial/Dt_final em Pagina.Lista)
368:         *-- Original top=106 -> compensacao +29 -> top=135
369:         loc_oPagina.AddObject("lbl_4c_LabelPeriodo", "Label")
370:         WITH loc_oPagina.lbl_4c_LabelPeriodo
371:             .Caption   = "Per" + CHR(237) + "odo :"
372:             .Top       = 135
373:             .Left      = 440
374:             .Width     = 50
375:             .Height    = 15
376:             .FontName  = "Tahoma"
377:             .FontSize  = 8
378:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 384 a 422:
384:         loc_oPagina.AddObject("txt_4c_DtInicio", "TextBox")
385:         WITH loc_oPagina.txt_4c_DtInicio
386:             .Value     = DATE()
387:             .Top       = 131
388:             .Left      = 495
389:             .Width     = 80
390:             .Height    = 21
391:             .FontName  = "Tahoma"
392:             .FontSize  = 8
393:             .ForeColor = RGB(90, 90, 90)
394:             .BackColor = RGB(255, 255, 255)
395:             .Format    = "D"
396:             .Visible   = .T.
397:         ENDWITH
398: 
399:         loc_oPagina.AddObject("lbl_4c_LabelSep", "Label")
400:         WITH loc_oPagina.lbl_4c_LabelSep
401:             .Caption   = "-"
402:             .Top       = 135
403:             .Left      = 582
404:             .Width     = 10
405:             .Height    = 15
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .ForeColor = RGB(90, 90, 90)
409:             .BackStyle = 0
410:             .Visible   = .T.
411:         ENDWITH
412: 
413:         loc_oPagina.AddObject("txt_4c_DtFim", "TextBox")
414:         WITH loc_oPagina.txt_4c_DtFim
415:             .Value     = DATE()
416:             .Top       = 131
417:             .Left      = 598
418:             .Width     = 80
419:             .Height    = 21
420:             .FontName  = "Tahoma"
421:             .FontSize  = 8
422:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 431 a 440:
431:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
432:         loc_oGrid = loc_oPagina.grd_4c_Lista
433: 
434:         loc_oGrid.Top          = 160
435:         loc_oGrid.Left         = 5
436:         loc_oGrid.Width        = THIS.Width - 15
437:         loc_oGrid.Height       = 450
438:         loc_oGrid.ColumnCount  = 6
439:         loc_oGrid.FontName     = "Verdana"
440:         loc_oGrid.FontSize     = 8

*-- Linhas 452 a 465:
452:         loc_oGrid.Visible      = .T.
453: 
454:         *-- BINDEVENTs dos botoes CRUD (metodos devem ser PUBLIC para BINDEVENT)
455:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
456:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
457:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
458:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
459:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
460:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
461: 
462:         *-- BINDEVENTs dos filtros de periodo (LostFocus replica Valid/LostFocus do legado)
463:         BINDEVENT(loc_oPagina.txt_4c_DtInicio, "KeyPress", THIS, "DtInicioLostFocus")
464:         BINDEVENT(loc_oPagina.txt_4c_DtFim,    "KeyPress", THIS, "DtFimLostFocus")
465: 

*-- Linhas 485 a 506:
485:         *-- Top = 4 + 29 (compensacao) = 33; Left = 1030 (lado direito)
486:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
487:         WITH loc_oPagina.cnt_4c_BotoesAcao
488:             .Top         = 33
489:             .Left        = 1030
490:             .Width       = 160
491:             .Height      = 85
492:             .BackStyle   = 0
493:             .Visible     = .T.
494:         ENDWITH
495: 
496:         *-- Botao Confirmar (salvar)
497:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
498:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
499:             .Caption         = "Confirmar"
500:             .Top             = 5
501:             .Left            = 5
502:             .Width           = 75
503:             .Height          = 75
504:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
505:             .PicturePosition = 13
506:             .FontName        = "Tahoma"

*-- Linhas 518 a 530:
518:         ENDWITH
519: 
520:         *-- Botao Cancelar
521:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
522:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
523:             .Caption         = "Encerrar"
524:             .Top             = 5
525:             .Left            = 80
526:             .Width           = 75
527:             .Height          = 75
528:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
529:             .PicturePosition = 13
530:             .FontName        = "Tahoma"

*-- Linhas 542 a 571:
542:         ENDWITH
543: 
544:         *-- BINDEVENTs dos botoes de acao (PUBLIC para BINDEVENT)
545:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
546:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
547: 
548:         *-- PageFrame interno (Pageframe1 no legado: top=3, left=-1, width=1199, height=624)
549:         *-- Top = 3 + 29 (compensacao) = 32
550:         loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
551:         loc_oPgfAbas = loc_oPagina.pgf_4c_Abas
552: 
553:         loc_oPgfAbas.Top       = 32
554:         loc_oPgfAbas.Left      = -1
555:         loc_oPgfAbas.Width     = 1199
556:         loc_oPgfAbas.Height    = 624
557:         loc_oPgfAbas.PageCount = 2
558:         loc_oPgfAbas.Tabs      = .T.
559:         loc_oPgfAbas.Visible   = .T.
560: 
561:         *-- Page1 (Dados): campos do cabecalho da sessao + grdEstoque (Fase 6)
562:         loc_oPgfAbas.Page1.Caption   = "Dados"
563:         loc_oPgfAbas.Page1.BackColor = RGB(255, 255, 255)
564: 
565:         *-- Page2 (Itens): grdDisponivel + grdItemXml (Fase 6)
566:         loc_oPgfAbas.Page2.Caption   = "Itens"
567:         loc_oPgfAbas.Page2.BackColor = RGB(255, 255, 255)
568: 
569:         *-- Fases 5-6: campos das abas Dados e Itens
570:         THIS.ConfigurarAbaDados()
571:         THIS.ConfigurarAbaItens()

*-- Linhas 585 a 597:
585:         loc_oOpt  = .NULL.
586: 
587:         *-- Label Fornecedores (Say4: top=69, left=228)
588:         loc_oPage.AddObject("lbl_4c_Fornecedores", "Label")
589:         WITH loc_oPage.lbl_4c_Fornecedores
590:             .Caption   = "Fornecedores:"
591:             .Top       = 69
592:             .Left      = 228
593:             .Width     = 75
594:             .Height    = 17
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 604 a 613:
604:         loc_oPage.AddObject("txt_4c_Grupo", "TextBox")
605:         WITH loc_oPage.txt_4c_Grupo
606:             .Value     = ""
607:             .Top       = 66
608:             .Left      = 307
609:             .Width     = 85
610:             .Height    = 21
611:             .FontName  = "Tahoma"
612:             .FontSize  = 8
613:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 619 a 628:
619:         loc_oPage.AddObject("txt_4c_Conta", "TextBox")
620:         WITH loc_oPage.txt_4c_Conta
621:             .Value     = ""
622:             .Top       = 66
623:             .Left      = 394
624:             .Width     = 85
625:             .Height    = 21
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 634 a 676:
634:         loc_oPage.AddObject("txt_4c_Cpf", "TextBox")
635:         WITH loc_oPage.txt_4c_Cpf
636:             .Value     = ""
637:             .Top       = 66
638:             .Left      = 481
639:             .Width     = 146
640:             .Height    = 21
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .ForeColor = RGB(90, 90, 90)
644:             .BackColor = RGB(255, 255, 255)
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         *-- CommandButton Consulta (Bot_Consulta: top=70, left=667, width=40, height=40)
649:         *-- Standalone icon button: Themes=.T. obrigatorio (memoria)
650:         loc_oPage.AddObject("cmd_4c_Consulta", "CommandButton")
651:         WITH loc_oPage.cmd_4c_Consulta
652:             .Caption         = ""
653:             .Top             = 70
654:             .Left            = 667
655:             .Width           = 40
656:             .Height          = 40
657:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
658:             .PicturePosition = 4
659:             .Themes          = .T.
660:             .SpecialEffect   = 0
661:             .MousePointer    = 15
662:             .ToolTipText     = "Consultar"
663:             .Visible         = .T.
664:         ENDWITH
665: 
666:         *-- CommandButton Cadastros (btnCadastros: top=70, left=708, width=40, height=40)
667:         loc_oPage.AddObject("cmd_4c_Cadastros", "CommandButton")
668:         WITH loc_oPage.cmd_4c_Cadastros
669:             .Caption         = ""
670:             .Top             = 70
671:             .Left            = 708
672:             .Width           = 40
673:             .Height          = 40
674:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
675:             .PicturePosition = 4
676:             .Themes          = .T.

*-- Linhas 684 a 709:
684:         loc_oPage.AddObject("txt_4c_Dconta", "TextBox")
685:         WITH loc_oPage.txt_4c_Dconta
686:             .Value     = ""
687:             .Top       = 89
688:             .Left      = 307
689:             .Width     = 357
690:             .Height    = 21
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .ForeColor = RGB(90, 90, 90)
694:             .BackColor = RGB(230, 230, 230)
695:             .ReadOnly  = .T.
696:             .Visible   = .T.
697:         ENDWITH
698: 
699:         *-- Label Precificacao (Say1: top=114, left=237)
700:         loc_oPage.AddObject("lbl_4c_Precificacao", "Label")
701:         WITH loc_oPage.lbl_4c_Precificacao
702:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o:"
703:             .Top       = 114
704:             .Left      = 237
705:             .Width     = 65
706:             .Height    = 17
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 717 a 763:
717:         loc_oPage.AddObject("opt_4c_Custo", "OptionGroup")
718:         loc_oOpt = loc_oPage.opt_4c_Custo
719: 
720:         loc_oOpt.Top         = 113
721:         loc_oOpt.Left        = 303
722:         loc_oOpt.Width       = 255
723:         loc_oOpt.Height      = 17
724:         loc_oOpt.ButtonCount = 2
725:         loc_oOpt.Value       = 1
726:         loc_oOpt.BackStyle   = 0
727:         loc_oOpt.Visible     = .T.
728: 
729:         WITH loc_oOpt.Buttons(1)
730:             .Caption   = "Custo"
731:             .Top       = 0
732:             .Left      = 0
733:             .Width     = 120
734:             .Height    = 17
735:             .FontName  = "Tahoma"
736:             .FontSize  = 8
737:             .ForeColor = RGB(90, 90, 90)
738:             .AutoSize  = .F.
739:         ENDWITH
740: 
741:         WITH loc_oOpt.Buttons(2)
742:             .Caption   = "Pre" + CHR(231) + "o de Venda"
743:             .Top       = 0
744:             .Left      = 125
745:             .Width     = 130
746:             .Height    = 17
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)
750:             .AutoSize  = .F.
751:         ENDWITH
752: 
753:         *-- Label Moeda (Say3: top=137, left=262)
754:         loc_oPage.AddObject("lbl_4c_Moeda", "Label")
755:         WITH loc_oPage.lbl_4c_Moeda
756:             .Caption   = "Moeda:"
757:             .Top       = 137
758:             .Left      = 262
759:             .Width     = 42
760:             .Height    = 17
761:             .FontName  = "Tahoma"
762:             .FontSize  = 8
763:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 770 a 807:
770:         loc_oPage.AddObject("txt_4c_Moeda", "TextBox")
771:         WITH loc_oPage.txt_4c_Moeda
772:             .Value     = ""
773:             .Top       = 134
774:             .Left      = 307
775:             .Width     = 85
776:             .Height    = 21
777:             .FontName  = "Tahoma"
778:             .FontSize  = 8
779:             .ForeColor = RGB(90, 90, 90)
780:             .BackColor = RGB(255, 255, 255)
781:             .Visible   = .T.
782:         ENDWITH
783: 
784:         *-- Shape1 decorativo (top=2, left=912, width=90, height=110)
785:         loc_oPage.AddObject("shp_4c_Shape1", "Shape")
786:         WITH loc_oPage.shp_4c_Shape1
787:             .Top         = 2
788:             .Left        = 912
789:             .Width       = 90
790:             .Height      = 110
791:             .BackStyle   = 1
792:             .BackColor   = RGB(192, 192, 192)
793:             .BorderStyle = 0
794:             .Visible     = .T.
795:         ENDWITH
796: 
797:         *-- Label Diretorio (Say2: top=160, left=253)
798:         loc_oPage.AddObject("lbl_4c_Diretorio", "Label")
799:         WITH loc_oPage.lbl_4c_Diretorio
800:             .Caption   = "Diret" + CHR(243) + "rio:"
801:             .Top       = 160
802:             .Left      = 253
803:             .Width     = 52
804:             .Height    = 17
805:             .FontName  = "Tahoma"
806:             .FontSize  = 8
807:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 814 a 854:
814:         loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
815:         WITH loc_oPage.txt_4c_Arquivo
816:             .Value         = ""
817:             .Top           = 157
818:             .Left          = 307
819:             .Width         = 357
820:             .Height        = 21
821:             .FontName      = "Tahoma"
822:             .FontSize      = 8
823:             .ForeColor     = RGB(0, 0, 0)
824:             .BackColor     = RGB(230, 230, 230)
825:             .ReadOnly      = .T.
826:             .SpecialEffect = 1
827:             .Visible       = .T.
828:         ENDWITH
829: 
830:         *-- CommandButton BrowseArquivo (Command12: top=157, left=667, width=20, height=20)
831:         loc_oPage.AddObject("cmd_4c_BrowseArquivo", "CommandButton")
832:         WITH loc_oPage.cmd_4c_BrowseArquivo
833:             .Caption  = "..."
834:             .Top      = 157
835:             .Left     = 667
836:             .Width    = 20
837:             .Height   = 20
838:             .FontName = "Tahoma"
839:             .FontSize = 8
840:             .Themes   = .T.
841:             .Visible  = .T.
842:         ENDWITH
843: 
844:         *-- Label "Carregar produtos que constam nos XML's :" (Label1: top=184, left=55)
845:         loc_oPage.AddObject("lbl_4c_OpcaoFil", "Label")
846:         WITH loc_oPage.lbl_4c_OpcaoFil
847:             .Caption   = "Carregar produtos que constam nos XML" + CHR(39) + "s :"
848:             .Top       = 184
849:             .Left      = 55
850:             .Width     = 246
851:             .Height    = 15
852:             .FontName  = "Tahoma"
853:             .FontSize  = 8
854:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 862 a 917:
862:         loc_oPage.AddObject("opt_4c_Fil", "OptionGroup")
863:         loc_oOpt = loc_oPage.opt_4c_Fil
864: 
865:         loc_oOpt.Top         = 179
866:         loc_oOpt.Left        = 303
867:         loc_oOpt.Width       = 192
868:         loc_oOpt.Height      = 24
869:         loc_oOpt.ButtonCount = 3
870:         loc_oOpt.Value       = 1
871:         loc_oOpt.BackStyle   = 0
872:         loc_oOpt.Visible     = .T.
873: 
874:         WITH loc_oOpt.Buttons(1)
875:             .Caption   = "Todos"
876:             .Top       = 3
877:             .Left      = 0
878:             .Width     = 58
879:             .Height    = 17
880:             .FontName  = "Tahoma"
881:             .FontSize  = 8
882:             .AutoSize  = .F.
883:         ENDWITH
884: 
885:         WITH loc_oOpt.Buttons(2)
886:             .Caption   = "Cadastrados"
887:             .Top       = 3
888:             .Left      = 60
889:             .Width     = 84
890:             .Height    = 17
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .AutoSize  = .F.
894:         ENDWITH
895: 
896:         WITH loc_oOpt.Buttons(3)
897:             .Caption   = "N" + CHR(227) + "o Cad."
898:             .Top       = 3
899:             .Left      = 146
900:             .Width     = 46
901:             .Height    = 17
902:             .FontName  = "Tahoma"
903:             .FontSize  = 8
904:             .AutoSize  = .F.
905:         ENDWITH
906: 
907:         *-- Label "Movimentacoes:" (Say5: top=204, left=203)
908:         loc_oPage.AddObject("lbl_4c_Movimentacoes", "Label")
909:         WITH loc_oPage.lbl_4c_Movimentacoes
910:             .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es:"
911:             .Top       = 204
912:             .Left      = 203
913:             .Width     = 100
914:             .Height    = 17
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 926 a 935:
926:         loc_oPage.AddObject("grd_4c_Estoque", "Grid")
927:         loc_oPage.grd_4c_Estoque.ColumnCount = 6
928:         WITH loc_oPage.grd_4c_Estoque
929:             .Top       = 206
930:             .Left      = 307
931:             .Width     = 545
932:             .Height    = 340
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8
935:             .GridLines = 1

*-- Linhas 942 a 1001:
942:             .Width     = 25
943:             .Resizable = .F.
944:         ENDWITH
945:         loc_oPage.grd_4c_Estoque.Column1.Header1.Caption = ""
946:         WITH loc_oPage.grd_4c_Estoque.Column2
947:             .Width = 65
948:         ENDWITH
949:         loc_oPage.grd_4c_Estoque.Column2.Header1.Caption = "Empresa"
950:         WITH loc_oPage.grd_4c_Estoque.Column3
951:             .Width = 120
952:         ENDWITH
953:         loc_oPage.grd_4c_Estoque.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
954:         WITH loc_oPage.grd_4c_Estoque.Column4
955:             .Width = 80
956:         ENDWITH
957:         loc_oPage.grd_4c_Estoque.Column4.Header1.Caption = "Numero"
958:         WITH loc_oPage.grd_4c_Estoque.Column5
959:             .Width = 130
960:         ENDWITH
961:         loc_oPage.grd_4c_Estoque.Column5.Header1.Caption = "Grupo"
962:         WITH loc_oPage.grd_4c_Estoque.Column6
963:             .Width = 125
964:         ENDWITH
965:         loc_oPage.grd_4c_Estoque.Column6.Header1.Caption = "Conta"
966: 
967:         *-- CommandGroup cgp_4c_Operacao (cmdOperacao: top=334, left=857, width=85, height=85)
968:         loc_oPage.AddObject("cgp_4c_Operacao", "CommandGroup")
969:         WITH loc_oPage.cgp_4c_Operacao
970:             .Top         = 334
971:             .Left        = 857
972:             .Width       = 85
973:             .Height      = 85
974:             .ButtonCount = 1
975:             .BackStyle   = 1
976:             .BackColor   = RGB(192, 192, 192)
977:             .Visible     = .T.
978:         ENDWITH
979:         WITH loc_oPage.cgp_4c_Operacao.Buttons(1)
980:             .Caption  = "Acessar"
981:             .Top      = 5
982:             .Left     = 5
983:             .Width    = 75
984:             .Height   = 75
985:             .FontName = "Tahoma"
986:             .FontSize = 8
987:             .Themes   = .F.
988:         ENDWITH
989: 
990:         *-- CommandButton cmd_4c_Processar (processar: top=7, left=962, standalone/icon)
991:         *-- Standalone CommandButton com picture: Themes=.T. obrigatorio (memoria)
992:         loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
993:         WITH loc_oPage.cmd_4c_Processar
994:             .Caption         = "Processar"
995:             .Top             = 5
996:             .Left            = 962
997:             .Width           = 75
998:             .Height          = 75
999:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1000:             .PicturePosition = 4
1001:             .Themes          = .T.

*-- Linhas 1012 a 1023:
1012:         BINDEVENT(loc_oPage.txt_4c_Cpf,           "KeyPress",         THIS, "ValidarCpfAba")
1013:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",         THIS, "ValidarMoedaAba")
1014:         BINDEVENT(loc_oPage.txt_4c_Moeda,         "KeyPress",          THIS, "TeclaMoedaAba")
1015:         BINDEVENT(loc_oPage.cmd_4c_Consulta,      "Click",             THIS, "BtnConsultaAbaClick")
1016:         BINDEVENT(loc_oPage.cmd_4c_Cadastros,     "Click",             THIS, "BtnCadastrosAbaClick")
1017:         BINDEVENT(loc_oPage.cmd_4c_BrowseArquivo, "Click",             THIS, "BtnBrowseArquivoClick")
1018:         BINDEVENT(loc_oPage.cmd_4c_Processar,     "Click",             THIS, "BtnProcessarClick")
1019:         BINDEVENT(loc_oPage.cgp_4c_Operacao,      "Click",             THIS, "CgpOperacaoClick")
1020:         BINDEVENT(loc_oPage.grd_4c_Estoque,       "AfterRowColChange", THIS, "GrdEstoqueAfterRowColChange")
1021:         BINDEVENT(loc_oPage.opt_4c_Custo,         "InteractiveChange", THIS, "OptCustoInteractiveChange")
1022:         BINDEVENT(loc_oPage.opt_4c_Fil,           "InteractiveChange", THIS, "OptFilInteractiveChange")
1023:     ENDPROC

*-- Linhas 1035 a 1069:
1035:         *-- Shape5 decorativo (top=1, left=424, width=282, height=113)
1036:         loc_oPage.AddObject("shp_4c_Shape5", "Shape")
1037:         WITH loc_oPage.shp_4c_Shape5
1038:             .Top         = 1
1039:             .Left        = 424
1040:             .Width       = 282
1041:             .Height      = 113
1042:             .BackStyle   = 1
1043:             .BackColor   = RGB(192, 192, 192)
1044:             .BorderStyle = 0
1045:             .Visible     = .T.
1046:         ENDWITH
1047: 
1048:         *-- Image FigJpg (top=3, left=426, width=278, height=109)
1049:         loc_oPage.AddObject("img_4c_FigJpg", "Image")
1050:         WITH loc_oPage.img_4c_FigJpg
1051:             .Top      = 3
1052:             .Left     = 426
1053:             .Width    = 278
1054:             .Height   = 109
1055:             .Stretch  = 2
1056:             .Visible  = .T.
1057:         ENDWITH
1058: 
1059:         *-- Label "Procurar Produto :" (lbl_produto: top=74, left=8, width=91)
1060:         loc_oPage.AddObject("lbl_4c_Produto", "Label")
1061:         WITH loc_oPage.lbl_4c_Produto
1062:             .Caption   = "Procurar Produto :"
1063:             .Top       = 74
1064:             .Left      = 8
1065:             .Width     = 108
1066:             .Height    = 17
1067:             .FontName  = "Tahoma"
1068:             .FontSize  = 8
1069:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1076 a 1098:
1076:         loc_oPage.AddObject("txt_4c_ProdutoInicial", "TextBox")
1077:         WITH loc_oPage.txt_4c_ProdutoInicial
1078:             .Value    = ""
1079:             .Top      = 90
1080:             .Left     = 8
1081:             .Width    = 108
1082:             .Height   = 21
1083:             .FontName = "Tahoma"
1084:             .FontSize = 8
1085:             .Visible  = .T.
1086:         ENDWITH
1087: 
1088:         *-- TextBox Sistema (readonly, top=113, left=8, width=684, height=20)
1089:         loc_oPage.AddObject("txt_4c_Sistema", "TextBox")
1090:         WITH loc_oPage.txt_4c_Sistema
1091:             .Value     = ""
1092:             .Top       = 113
1093:             .Left      = 8
1094:             .Width     = 684
1095:             .Height    = 20
1096:             .FontName  = "Tahoma"
1097:             .FontSize  = 8
1098:             .ReadOnly  = .T.

*-- Linhas 1104 a 1113:
1104:         loc_oPage.AddObject("txt_4c_Arquivo", "TextBox")
1105:         WITH loc_oPage.txt_4c_Arquivo
1106:             .Value     = ""
1107:             .Top       = 113
1108:             .Left      = 691
1109:             .Width     = 495
1110:             .Height    = 20
1111:             .FontName  = "Tahoma"
1112:             .FontSize  = 8
1113:             .ReadOnly  = .T.

*-- Linhas 1120 a 1129:
1120:         loc_oPage.AddObject("grd_4c_Disponivel", "Grid")
1121:         loc_oPage.grd_4c_Disponivel.ColumnCount = 7
1122:         WITH loc_oPage.grd_4c_Disponivel
1123:             .Top       = 134
1124:             .Left      = 8
1125:             .Width     = 684
1126:             .Height    = 344
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 8
1129:             .GridLines = 1

*-- Linhas 1157 a 1166:
1157:         loc_oPage.AddObject("grd_4c_ItemXml", "Grid")
1158:         loc_oPage.grd_4c_ItemXml.ColumnCount = 4
1159:         WITH loc_oPage.grd_4c_ItemXml
1160:             .Top       = 134
1161:             .Left      = 693
1162:             .Width     = 493
1163:             .Height    = 344
1164:             .FontName  = "Tahoma"
1165:             .FontSize  = 8
1166:             .GridLines = 1

*-- Linhas 1182 a 1224:
1182:         ENDWITH
1183: 
1184:         *-- CommandButton btnExcluirSis (top=479, left=663, width=40, height=37)
1185:         loc_oPage.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
1186:         WITH loc_oPage.cmd_4c_BtnExcluirSis
1187:             .Caption         = ""
1188:             .Top             = 479
1189:             .Left            = 663
1190:             .Width           = 40
1191:             .Height          = 37
1192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1193:             .PicturePosition = 4
1194:             .Themes          = .T.
1195:             .ToolTipText     = "Remover produto da lista"
1196:             .Visible         = .T.
1197:         ENDWITH
1198: 
1199:         *-- CommandButton btnExcluirArq (top=479, left=1146, width=40, height=37)
1200:         loc_oPage.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
1201:         WITH loc_oPage.cmd_4c_BtnExcluirArq
1202:             .Caption         = ""
1203:             .Top             = 479
1204:             .Left            = 1146
1205:             .Width           = 40
1206:             .Height          = 37
1207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1208:             .PicturePosition = 4
1209:             .Themes          = .T.
1210:             .ToolTipText     = "Remover item XML da lista"
1211:             .Visible         = .T.
1212:         ENDWITH
1213: 
1214:         *-- Label "Movimentacao :" (Say3: top=483, left=40, width=78)
1215:         loc_oPage.AddObject("lbl_4c_Movimentacao", "Label")
1216:         WITH loc_oPage.lbl_4c_Movimentacao
1217:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1218:             .Top       = 483
1219:             .Left      = 40
1220:             .Width     = 90
1221:             .Height    = 15
1222:             .FontName  = "Tahoma"
1223:             .FontSize  = 8
1224:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1231 a 1240:
1231:         loc_oPage.AddObject("txt_4c_Emps", "TextBox")
1232:         WITH loc_oPage.txt_4c_Emps
1233:             .Value     = ""
1234:             .Top       = 480
1235:             .Left      = 122
1236:             .Width     = 65
1237:             .Height    = 21
1238:             .FontName  = "Tahoma"
1239:             .FontSize  = 8
1240:             .ReadOnly  = .T.

*-- Linhas 1246 a 1255:
1246:         loc_oPage.AddObject("txt_4c_Dopes", "TextBox")
1247:         WITH loc_oPage.txt_4c_Dopes
1248:             .Value     = ""
1249:             .Top       = 480
1250:             .Left      = 188
1251:             .Width     = 205
1252:             .Height    = 21
1253:             .FontName  = "Tahoma"
1254:             .FontSize  = 8
1255:             .ReadOnly  = .T.

*-- Linhas 1261 a 1270:
1261:         loc_oPage.AddObject("txt_4c_Numes", "TextBox")
1262:         WITH loc_oPage.txt_4c_Numes
1263:             .Value     = ""
1264:             .Top       = 480
1265:             .Left      = 393
1266:             .Width     = 65
1267:             .Height    = 21
1268:             .FontName  = "Tahoma"
1269:             .FontSize  = 8
1270:             .ReadOnly  = .T.

*-- Linhas 1276 a 1300:
1276:         loc_oPage.AddObject("txt_4c_CIdChaves", "TextBox")
1277:         WITH loc_oPage.txt_4c_CIdChaves
1278:             .Value     = ""
1279:             .Top       = 480
1280:             .Left      = 459
1281:             .Width     = 173
1282:             .Height    = 21
1283:             .FontName  = "Tahoma"
1284:             .FontSize  = 8
1285:             .ReadOnly  = .T.
1286:             .BackColor = RGB(240, 240, 240)
1287:             .Visible   = .T.
1288:         ENDWITH
1289: 
1290:         *-- Label "Ref. Fornecedor :" (lbl_ref_fornecedor: top=505, left=30, width=88)
1291:         loc_oPage.AddObject("lbl_4c_RefFornecedor", "Label")
1292:         WITH loc_oPage.lbl_4c_RefFornecedor
1293:             .Caption   = "Ref. Fornecedor :"
1294:             .Top       = 505
1295:             .Left      = 30
1296:             .Width     = 90
1297:             .Height    = 15
1298:             .FontName  = "Tahoma"
1299:             .FontSize  = 8
1300:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1307 a 1331:
1307:         loc_oPage.AddObject("txt_4c_RefFornecedor", "TextBox")
1308:         WITH loc_oPage.txt_4c_RefFornecedor
1309:             .Value     = ""
1310:             .Top       = 502
1311:             .Left      = 122
1312:             .Width     = 190
1313:             .Height    = 21
1314:             .FontName  = "Tahoma"
1315:             .FontSize  = 8
1316:             .ReadOnly  = .T.
1317:             .BackColor = RGB(240, 240, 240)
1318:             .Visible   = .T.
1319:         ENDWITH
1320: 
1321:         *-- Label "Custo :" (Say5: top=527, left=81, width=37)
1322:         loc_oPage.AddObject("lbl_4c_Custo", "Label")
1323:         WITH loc_oPage.lbl_4c_Custo
1324:             .Caption   = "Custo :"
1325:             .Top       = 527
1326:             .Left      = 81
1327:             .Width     = 40
1328:             .Height    = 15
1329:             .FontName  = "Tahoma"
1330:             .FontSize  = 8
1331:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1338 a 1362:
1338:         loc_oPage.AddObject("txt_4c_PrecoMov", "TextBox")
1339:         WITH loc_oPage.txt_4c_PrecoMov
1340:             .Value     = 0
1341:             .Top       = 524
1342:             .Left      = 122
1343:             .Width     = 108
1344:             .Height    = 21
1345:             .FontName  = "Tahoma"
1346:             .FontSize  = 8
1347:             .ReadOnly  = .T.
1348:             .BackColor = RGB(240, 240, 240)
1349:             .Visible   = .T.
1350:         ENDWITH
1351: 
1352:         *-- Label "Preco Venda :" (lbl_pr_venda: top=549, left=49, width=69)
1353:         loc_oPage.AddObject("lbl_4c_PrVenda", "Label")
1354:         WITH loc_oPage.lbl_4c_PrVenda
1355:             .Caption   = "Pre" + CHR(231) + "o Venda :"
1356:             .Top       = 549
1357:             .Left      = 49
1358:             .Width     = 75
1359:             .Height    = 15
1360:             .FontName  = "Tahoma"
1361:             .FontSize  = 8
1362:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1369 a 1378:
1369:         loc_oPage.AddObject("txt_4c_PrVenda", "TextBox")
1370:         WITH loc_oPage.txt_4c_PrVenda
1371:             .Value     = 0
1372:             .Top       = 546
1373:             .Left      = 122
1374:             .Width     = 108
1375:             .Height    = 21
1376:             .FontName  = "Tahoma"
1377:             .FontSize  = 8
1378:             .ReadOnly  = .T.

*-- Linhas 1384 a 1408:
1384:         loc_oPage.AddObject("txt_4c_PrVendaMoeda", "TextBox")
1385:         WITH loc_oPage.txt_4c_PrVendaMoeda
1386:             .Value     = ""
1387:             .Top       = 546
1388:             .Left      = 231
1389:             .Width     = 31
1390:             .Height    = 21
1391:             .FontName  = "Tahoma"
1392:             .FontSize  = 8
1393:             .ReadOnly  = .T.
1394:             .BackColor = RGB(240, 240, 240)
1395:             .Visible   = .T.
1396:         ENDWITH
1397: 
1398:         *-- Label "Peso :" (Say1: top=550, left=348, width=32)
1399:         loc_oPage.AddObject("lbl_4c_Peso", "Label")
1400:         WITH loc_oPage.lbl_4c_Peso
1401:             .Caption   = "Peso :"
1402:             .Top       = 550
1403:             .Left      = 348
1404:             .Width     = 35
1405:             .Height    = 15
1406:             .FontName  = "Tahoma"
1407:             .FontSize  = 8
1408:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1415 a 1439:
1415:         loc_oPage.AddObject("txt_4c_PesoMedio", "TextBox")
1416:         WITH loc_oPage.txt_4c_PesoMedio
1417:             .Value     = 0
1418:             .Top       = 547
1419:             .Left      = 383
1420:             .Width     = 75
1421:             .Height    = 21
1422:             .FontName  = "Tahoma"
1423:             .FontSize  = 8
1424:             .ReadOnly  = .T.
1425:             .BackColor = RGB(240, 240, 240)
1426:             .Visible   = .T.
1427:         ENDWITH
1428: 
1429:         *-- Label "Preco Custo :" (Say2: top=571, left=51, width=67)
1430:         loc_oPage.AddObject("lbl_4c_PrecoCusto", "Label")
1431:         WITH loc_oPage.lbl_4c_PrecoCusto
1432:             .Caption   = "Pre" + CHR(231) + "o Custo :"
1433:             .Top       = 571
1434:             .Left      = 51
1435:             .Width     = 70
1436:             .Height    = 15
1437:             .FontName  = "Tahoma"
1438:             .FontSize  = 8
1439:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1446 a 1455:
1446:         loc_oPage.AddObject("txt_4c_Custofs", "TextBox")
1447:         WITH loc_oPage.txt_4c_Custofs
1448:             .Value     = 0
1449:             .Top       = 568
1450:             .Left      = 122
1451:             .Width     = 108
1452:             .Height    = 21
1453:             .FontName  = "Tahoma"
1454:             .FontSize  = 8
1455:             .ReadOnly  = .T.

*-- Linhas 1461 a 1483:
1461:         loc_oPage.AddObject("txt_4c_Moecusfs", "TextBox")
1462:         WITH loc_oPage.txt_4c_Moecusfs
1463:             .Value     = ""
1464:             .Top       = 568
1465:             .Left      = 231
1466:             .Width     = 31
1467:             .Height    = 21
1468:             .FontName  = "Tahoma"
1469:             .FontSize  = 8
1470:             .ReadOnly  = .T.
1471:             .BackColor = RGB(240, 240, 240)
1472:             .Visible   = .T.
1473:         ENDWITH
1474: 
1475:         *-- BINDEVENTs de Page2 (Itens)
1476:         BINDEVENT(loc_oPage.grd_4c_Disponivel, "AfterRowColChange", THIS, "GrdDisponivelAfterRowColChange")
1477:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirSis, "Click",          THIS, "BtnExcluirSisClick")
1478:         BINDEVENT(loc_oPage.cmd_4c_BtnExcluirArq, "Click",          THIS, "BtnExcluirArqClick")
1479:         BINDEVENT(loc_oPage.txt_4c_ProdutoInicial, "KeyPress",     THIS, "ProdutoInicialLostFocus")
1480:         BINDEVENT(loc_oPage.img_4c_FigJpg,        "Click",          THIS, "ImgFigJpgClick")
1481:     ENDPROC
1482: 
1483:     *==========================================================================

*-- Linhas 2070 a 2083:
2070:                 loc_oGrd.RecordSource = "cursor_4c_Estoque"
2071: 
2072:                 *-- Headers APOS RecordSource (Problema 32)
2073:                 loc_oGrd.Column1.Header1.Caption = ""
2074:                 loc_oGrd.Column2.Header1.Caption = "Empresa"
2075:                 loc_oGrd.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2076:                 loc_oGrd.Column4.Header1.Caption = "Numero"
2077:                 loc_oGrd.Column5.Header1.Caption = "Grupo"
2078:                 loc_oGrd.Column6.Header1.Caption = "Conta"
2079: 
2080:                 *-- ControlSource APOS RecordSource (Problema 48)
2081:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Estoque.nMarca"
2082:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Estoque.Emps"
2083:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Estoque.Dopes"

*-- Linhas 2396 a 2410:
2396:             loc_oGrd.RecordSource = "crMovimentos"
2397: 
2398:             *-- Problema 32: Headers APOS RecordSource
2399:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2400:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2401:             loc_oGrd.Column3.Header1.Caption = "Valor"
2402:             loc_oGrd.Column4.Header1.Caption = "Quantidade"
2403:             loc_oGrd.Column5.Header1.Caption = "Baixado"
2404:             loc_oGrd.Column6.Header1.Caption = "Reservado"
2405:             loc_oGrd.Column7.Header1.Caption = "Saldo"
2406: 
2407:             *-- Problema 48: ControlSource APOS RecordSource
2408:             loc_oGrd.Column1.ControlSource = "crMovimentos.Cpros"
2409:             loc_oGrd.Column2.ControlSource = "crMovimentos.Dpros"
2410:             loc_oGrd.Column3.ControlSource = "crMovimentos.pvens"

*-- Linhas 2457 a 2468:
2457:             loc_oGrd.ColumnCount  = 4
2458:             loc_oGrd.RecordSource = "crDistribui"
2459: 
2460:             loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2461:             loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2462:             loc_oGrd.Column3.Header1.Caption = "Quantidade"
2463:             loc_oGrd.Column4.Header1.Caption = "Valor"
2464: 
2465:             loc_oGrd.Column1.ControlSource = "crDistribui.refForn"
2466:             loc_oGrd.Column2.ControlSource = "crDistribui.Descr"
2467:             loc_oGrd.Column3.ControlSource = "crDistribui.Qtds"
2468:             loc_oGrd.Column4.ControlSource = "crDistribui.Valor"

*-- Linhas 2964 a 2977:
2964:                         loc_oGrid.Column6.Width = 680
2965: 
2966:                         *-- Cabecalhos APOS RecordSource (Problema 2/32: reset automatico)
2967:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2968:                         loc_oGrid.Column2.Header1.Caption = "Data"
2969:                         loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2970:                         loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
2971:                         loc_oGrid.Column5.Header1.Caption = "Fornecedor"
2972:                         loc_oGrid.Column6.Header1.Caption = "Nome"
2973: 
2974:                         THIS.FormatarGridLista(loc_oGrid)
2975:                         loc_lResultado = .T.
2976:                     ELSE
2977:                         loc_lResultado = .F.

*-- Linhas 3323 a 3368:
3323:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
3324:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
3325: 
3326:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar") = "O"
3327:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3328:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3329:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3330:         ENDIF
3331:     ENDPROC
3332: 
3333:     *--------------------------------------------------------------------------
3334:     * HabilitarCampos - Habilita ou desabilita campos de Page2 por modo
3335:     * par_lHabilitar: .T. = editar; .F. = somente leitura
3336:     *--------------------------------------------------------------------------
3337:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
3338:         LOCAL loc_oPg2, loc_oPage
3339:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3340:         loc_oPage = loc_oPg2.pgf_4c_Abas.Page1
3341: 
3342:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3343:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
3344:         ENDIF
3345: 
3346:         *-- Campos de pgf_4c_Abas.Page1 (Fases 5-6)
3347:         *-- Nota: cmd_4c_Consulta/Cadastros/Processar (icon-only) NAO desabilitar (icone some)
3348:         IF TYPE("loc_oPage.txt_4c_Grupo") = "O"
3349:             loc_oPage.txt_4c_Grupo.Enabled        = par_lHabilitar
3350:             loc_oPage.txt_4c_Conta.Enabled        = par_lHabilitar
3351:             loc_oPage.txt_4c_Cpf.Enabled          = par_lHabilitar
3352:             loc_oPage.txt_4c_Moeda.Enabled        = par_lHabilitar
3353:             loc_oPage.opt_4c_Custo.Enabled        = par_lHabilitar
3354:         ENDIF
3355:         IF TYPE("loc_oPage.opt_4c_Fil") = "O"
3356:             loc_oPage.opt_4c_Fil.Enabled          = par_lHabilitar
3357:             loc_oPage.cmd_4c_BrowseArquivo.Enabled = par_lHabilitar
3358:         ENDIF
3359: 
3360:         *-- Habilitar botoes de excluir em Page2 (Itens)
3361:         LOCAL loc_oPage2
3362:         loc_oPage2 = loc_oPg2.pgf_4c_Abas.Page2
3363:         IF TYPE("loc_oPage2.cmd_4c_BtnExcluirSis") = "O"
3364:         ENDIF
3365:     ENDPROC
3366: 
3367:     *--------------------------------------------------------------------------
3368:     * FormParaBO - Transfere dados dos campos de Page2 para o Business Object

*-- Linhas 3487 a 3506:
3487:         loc_lEditar      = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3488: 
3489:         *-- Botoes CRUD na Page1
3490:         IF TYPE("loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir") = "O"
3491:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
3492:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
3493:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
3494:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
3495:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
3496:         ENDIF
3497: 
3498:         *-- Botoes de acao na Page2 (Confirmar so habilitado ao editar)
3499:         IF TYPE("loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar") = "O"
3500:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
3501:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
3502:         ENDIF
3503:     ENDPROC
3504: 
3505:     *--------------------------------------------------------------------------
3506:     * Destroy - Limpeza de recursos ao fechar o formulario


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
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

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

