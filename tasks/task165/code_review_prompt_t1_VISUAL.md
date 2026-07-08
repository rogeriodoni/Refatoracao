# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [GRID-HEADER] Header Caption 'Cód. Produto' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Referência' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Desc. Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Produto, Qtde. Máx., Tam, Cor, Departamento, Emp, Qtde. Máxima, Tamanho. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2486 linhas total):

*-- Linhas 76 a 96:
76: 
77:         TRY
78:             *-- Caption com acento correto (CHR() obrigatorio em .PRG)
79:             THIS.Caption = "Estoque M" + CHR(225) + "ximo"
80: 
81:             *-- Criar Business Object
82:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcomBO")
83: 
84:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
85:                 MsgErro("Falha ao criar sigprcomBO!", "Erro Cr" + CHR(237) + "tico")
86:                 loc_lSucesso = .F.
87:             ELSE
88:                 *-- Configurar estrutura de paginas
89:                 THIS.ConfigurarPageFrame()
90:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
91:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
92: 
93:                 *-- Carregar lista inicial (pula se validando UI sem conexao SQL)
94:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
95:                     THIS.CarregarLista()
96:                 ENDIF

*-- Linhas 109 a 146:
109: 
110:     *==========================================================================
111:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
112:     * PageFrame.Top = -29 para ocultar abas; todos controles internos +29 no Top
113:     *==========================================================================
114:     PROTECTED PROCEDURE ConfigurarPageFrame()
115:         LOCAL loc_oPgf, loc_oPg1, loc_oPg2
116: 
117:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
118:         loc_oPgf = THIS.pgf_4c_Paginas
119: 
120:         WITH loc_oPgf
121:             .Top       = -29
122:             .Left      = 0
123:             .Width     = THIS.Width
124:             .Height    = THIS.Height + 29
125:             .PageCount = 2
126:             .Tabs      = .F.
127:             .Visible   = .T.
128:         ENDWITH
129: 
130:         *-- Page1 (Lista) - background do framework
131:         loc_oPg1 = loc_oPgf.Page1
132:         WITH loc_oPg1
133:             .Caption = "Lista"
134:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
135:             .Visible = .T.
136:         ENDWITH
137: 
138:         *-- Page2 (Dados) - background do framework
139:         loc_oPg2 = loc_oPgf.Page2
140:         WITH loc_oPg2
141:             .Caption = "Dados"
142:             .Picture = gc_4c_CaminhoIcones + "new_background.jpg"
143:             .Visible = .T.
144:         ENDWITH
145: 
146:         *-- Configurar containers em cada pagina

*-- Linhas 163 a 204:
163:         *----------------------------------------------------------------------
164:         loc_oPag.AddObject("cnt_4c_Cabecalho", "Container")
165:         WITH loc_oPag.cnt_4c_Cabecalho
166:             .Top           = 30
167:             .Left          = -1
168:             .Width         = THIS.Width + 2
169:             .Height        = 80
170:             .BackColor     = RGB(100, 100, 100)
171:             .SpecialEffect = 0
172:             .BorderWidth   = 0
173:             .Visible       = .T.
174:         ENDWITH
175: 
176:         *-- Label sombra (offset de 3px cria efeito de sombra)
177:         loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
178:         WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Sombra
179:             .AutoSize  = .F.
180:             .Caption   = THIS.Caption
181:             .Top       = 15
182:             .Left      = 10
183:             .Width     = THIS.Width - 10
184:             .Height    = 40
185:             .FontName  = "Tahoma"
186:             .FontSize  = 16
187:             .FontBold  = .T.
188:             .ForeColor = RGB(0, 0, 0)
189:             .BackStyle = 0
190:             .Visible   = .T.
191:         ENDWITH
192: 
193:         *-- Label titulo principal (branco, sobre a sombra preta)
194:         loc_oPag.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
195:         WITH loc_oPag.cnt_4c_Cabecalho.lbl_4c_Titulo
196:             .AutoSize  = .F.
197:             .Caption   = THIS.Caption
198:             .Top       = 18
199:             .Left      = 10
200:             .Width     = THIS.Width - 10
201:             .Height    = 46
202:             .FontName  = "Tahoma"
203:             .FontSize  = 16
204:             .FontBold  = .T.

*-- Linhas 215 a 236:
215:         *----------------------------------------------------------------------
216:         loc_oPag.AddObject("cnt_4c_Botoes", "Container")
217:         WITH loc_oPag.cnt_4c_Botoes
218:             .Top         = 28
219:             .Left        =  542
220:             .Width       = 390
221:             .Height      = 85
222:             .BackStyle = 0
223:             .BorderWidth = 0
224:             .Visible     = .T.
225:         ENDWITH
226: 
227:         loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
228:         WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir
229:             .Caption         = "Incluir"
230:             .Top             = 5
231:             .Left            = 5
232:             .Width           = 75
233:             .Height          = 75
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
235:             .PicturePosition = 13
236:             .FontName        = "Tahoma"

*-- Linhas 246 a 260:
246:             .AutoSize        = .F.
247:             .Visible         = .T.
248:         ENDWITH
249:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
250: 
251:         loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
252:         WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar
253:             .Caption         = "Visualizar"
254:             .Top             = 5
255:             .Left            = 80
256:             .Width           = 75
257:             .Height          = 75
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
259:             .PicturePosition = 13
260:             .FontName        = "Tahoma"

*-- Linhas 270 a 284:
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
274: 
275:         loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
276:         WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar
277:             .Caption         = "Alterar"
278:             .Top             = 5
279:             .Left            = 155
280:             .Width           = 75
281:             .Height          = 75
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
283:             .PicturePosition = 13
284:             .FontName        = "Tahoma"

*-- Linhas 294 a 308:
294:             .AutoSize        = .F.
295:             .Visible         = .T.
296:         ENDWITH
297:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
298: 
299:         loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
300:         WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir
301:             .Caption         = "Excluir"
302:             .Top             = 5
303:             .Left            = 230
304:             .Width           = 75
305:             .Height          = 75
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
307:             .PicturePosition = 13
308:             .FontName        = "Tahoma"

*-- Linhas 318 a 332:
318:             .AutoSize        = .F.
319:             .Visible         = .T.
320:         ENDWITH
321:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
322: 
323:         loc_oPag.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
324:         WITH loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar
325:             .Caption         = "Buscar"
326:             .Top             = 5
327:             .Left            = 305
328:             .Width           = 75
329:             .Height          = 75
330:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
331:             .PicturePosition = 13
332:             .FontName        = "Tahoma"

*-- Linhas 342 a 373:
342:             .AutoSize        = .F.
343:             .Visible         = .T.
344:         ENDWITH
345:         BINDEVENT(loc_oPag.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
346: 
347:         *----------------------------------------------------------------------
348:         * Container Saida - PADRAO CANONICO (prevalece sobre PILAR 1)
349:         * Original Grupo_Saida: Left=919, Top=-1 -> canonico: Left=917, Top=29
350:         * BackStyle=0 (transparente): fundo vem da Page.Picture
351:         *----------------------------------------------------------------------
352:         loc_oPag.AddObject("cnt_4c_Saida", "Container")
353:         WITH loc_oPag.cnt_4c_Saida
354:             .Top         = 29
355:             .Left        = 917
356:             .Width       = 90
357:             .Height      = 85
358:             .BackStyle   = 0
359:             .BorderWidth = 0
360:             .Visible     = .T.
361:         ENDWITH
362: 
363:         *-- Botao Encerrar (PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75)
364:         loc_oPag.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
365:         WITH loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar
366:             .Caption         = "Encerrar"
367:             .Top             = 5
368:             .Left            = 5
369:             .Width           = 75
370:             .Height          = 75
371:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
372:             .PicturePosition = 13
373:             .FontName        = "Tahoma"

*-- Linhas 384 a 402:
384:             .Visible         = .T.
385:         ENDWITH
386: 
387:         BINDEVENT(loc_oPag.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
388: 
389:         *----------------------------------------------------------------------
390:         * Botao Copiar Produto (standalone, sobre o cabecalho)
391:         * Original btnCopiar: Top=4, Left=474 -> Com compensacao: Top=33
392:         *----------------------------------------------------------------------
393:         loc_oPag.AddObject("cmd_4c_BtnCopiar", "CommandButton")
394:         WITH loc_oPag.cmd_4c_BtnCopiar
395:             .Caption         = "Copiar Produto"
396:             .Top             = 33
397:             .Left            = 474
398:             .Width           = 75
399:             .Height          = 75
400:             .Picture         = gc_4c_CaminhoIcones + "geral_copiar_60.jpg"
401:             .PicturePosition = 13
402:             .FontName        = "Tahoma"

*-- Linhas 413 a 433:
413:             .Enabled         = THIS.this_lAcCopiar
414:             .Visible         = .T.
415:         ENDWITH
416:         BINDEVENT(loc_oPag.cmd_4c_BtnCopiar, "Click", THIS, "BtnCopiarClick")
417: 
418:         *----------------------------------------------------------------------
419:         * Grid principal de listagem (Grade do legado)
420:         * Original: Top=102, Left=14, Width=971, Height=553
421:         * Com compensacao PageFrame -29: Top = 102 + 29 = 131
422:         * ColumnCount OBRIGATORIO fora de WITH (Problema 36)
423:         *----------------------------------------------------------------------
424:         loc_oPag.AddObject("grd_4c_Lista", "Grid")
425:         loc_oPag.grd_4c_Lista.ColumnCount = 7
426:         WITH loc_oPag.grd_4c_Lista
427:             .Top           = 131
428:             .Left          = 14
429:             .Width         = 971
430:             .Height        = 553
431:             .ReadOnly      = .T.
432:             .FontName      = "Tahoma"
433:             .FontSize      = 8

*-- Linhas 448 a 475:
448:         *----------------------------------------------------------------------
449:         loc_oPag.AddObject("cnt_4c_Copia", "Container")
450:         WITH loc_oPag.cnt_4c_Copia
451:             .Top           = 190
452:             .Left          = 256
453:             .Width         = 486
454:             .Height        = 373
455:             .BackStyle     = 1
456:             .BackColor     = RGB(210, 210, 210)
457:             .SpecialEffect = 0
458:             .BorderWidth   = 1
459:             .Visible       = .F.
460:         ENDWITH
461: 
462:         LOCAL loc_oCopia
463:         loc_oCopia = loc_oPag.cnt_4c_Copia
464: 
465:         *-- Botao Processar (cmd_4c_CmdProcessa)
466:         loc_oCopia.AddObject("cmd_4c_CmdProcessa", "CommandButton")
467:         WITH loc_oCopia.cmd_4c_CmdProcessa
468:             .Caption         = "Processar"
469:             .Top             = 5
470:             .Left            = 256
471:             .Width           = 75
472:             .Height          = 75
473:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
474:             .PicturePosition = 13
475:             .FontName        = "Tahoma"

*-- Linhas 485 a 500:
485:             .AutoSize        = .F.
486:             .Visible         = .T.
487:         ENDWITH
488:         BINDEVENT(loc_oCopia.cmd_4c_CmdProcessa, "Click", THIS, "CmdProcessaClick")
489: 
490:         *-- Botao Confirmar copia (cmd_4c_CmdCopiar)
491:         loc_oCopia.AddObject("cmd_4c_CmdCopiar", "CommandButton")
492:         WITH loc_oCopia.cmd_4c_CmdCopiar
493:             .Caption         = "Confirmar"
494:             .Top             = 5
495:             .Left            = 332
496:             .Width           = 75
497:             .Height          = 75
498:             .Picture         = gc_4c_CaminhoIcones + "geral_copiar_60.jpg"
499:             .PicturePosition = 13
500:             .FontName        = "Tahoma"

*-- Linhas 510 a 525:
510:             .AutoSize        = .F.
511:             .Visible         = .T.
512:         ENDWITH
513:         BINDEVENT(loc_oCopia.cmd_4c_CmdCopiar, "Click", THIS, "CmdCopiarClick")
514: 
515:         *-- Botao Sair do painel de copia (cmd_4c_CmdSair)
516:         loc_oCopia.AddObject("cmd_4c_CmdSair", "CommandButton")
517:         WITH loc_oCopia.cmd_4c_CmdSair
518:             .Caption         = "Encerrar"
519:             .Top             = 5
520:             .Left            = 407
521:             .Width           = 75
522:             .Height          = 75
523:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
524:             .PicturePosition = 13
525:             .FontName        = "Tahoma"

*-- Linhas 535 a 747:
535:             .AutoSize        = .F.
536:             .Visible         = .T.
537:         ENDWITH
538:         BINDEVENT(loc_oCopia.cmd_4c_CmdSair, "Click", THIS, "CmdSairCopiaClick")
539: 
540:         *-- Label "Empresa Origem :" (lbl_empresa original)
541:         loc_oCopia.AddObject("lbl_4c_Lbl_empresa", "Label")
542:         WITH loc_oCopia.lbl_4c_Lbl_empresa
543:             .AutoSize  = .F.
544:             .Caption   = "Empresa Origem :"
545:             .Top       = 35
546:             .Left      = 35
547:             .Width     = 87
548:             .Height    = 18
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .BackStyle = 0
552:             .Visible   = .T.
553:         ENDWITH
554: 
555:         *-- Label "Empresa Destino :" (Say2 original)
556:         loc_oCopia.AddObject("lbl_4c_Label2", "Label")
557:         WITH loc_oCopia.lbl_4c_Label2
558:             .AutoSize  = .F.
559:             .Caption   = "Empresa Destino :"
560:             .Top       = 60
561:             .Left      = 33
562:             .Width     = 89
563:             .Height    = 18
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8
566:             .BackStyle = 0
567:             .Visible   = .T.
568:         ENDWITH
569: 
570:         *-- TextBox Empresa Origem (GetEmpOs original)
571:         loc_oCopia.AddObject("txt_4c_EmpOs", "TextBox")
572:         WITH loc_oCopia.txt_4c_EmpOs
573:             .Top     = 31
574:             .Left    = 124
575:             .Width   = 31
576:             .Height  = 23
577:             .Value   = ""
578:             .Visible = .T.
579:         ENDWITH
580:         BINDEVENT(loc_oCopia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOrigLostFocus")
581: 
582:         *-- TextBox Empresa Destino (GetEmpDs original) - inicia desabilitada
583:         loc_oCopia.AddObject("txt_4c_EmpDs", "TextBox")
584:         WITH loc_oCopia.txt_4c_EmpDs
585:             .Top     = 56
586:             .Left    = 124
587:             .Width   = 31
588:             .Height  = 23
589:             .Value   = ""
590:             .Enabled = .F.
591:             .Visible = .T.
592:         ENDWITH
593:         BINDEVENT(loc_oCopia.txt_4c_EmpDs, "KeyPress", THIS, "EmpDestLostFocus")
594: 
595:         *-- Label "Procura Produto :" (Say1 original)
596:         loc_oCopia.AddObject("lbl_4c_Label1", "Label")
597:         WITH loc_oCopia.lbl_4c_Label1
598:             .AutoSize  = .F.
599:             .Caption   = "Procura Produto :"
600:             .Top       = 85
601:             .Left      = 35
602:             .Width     = 89
603:             .Height    = 18
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8
606:             .BackStyle = 0
607:             .Visible   = .T.
608:         ENDWITH
609: 
610:         *-- TextBox Produto filtro de copia (GetProduto original)
611:         loc_oCopia.AddObject("txt_4c_Produto", "TextBox")
612:         WITH loc_oCopia.txt_4c_Produto
613:             .Top     = 81
614:             .Left    = 124
615:             .Width   = 108
616:             .Height  = 23
617:             .Value   = ""
618:             .Visible = .T.
619:         ENDWITH
620:         BINDEVENT(loc_oCopia.txt_4c_Produto, "KeyPress", THIS, "ProdutoCopiaLostFocus")
621: 
622:         *-- Botao Marcar (Marcar original) - oculto, revelado apos Processar
623:         loc_oCopia.AddObject("cmd_4c_Marcar", "CommandButton")
624:         WITH loc_oCopia.cmd_4c_Marcar
625:             .Caption       = ""
626:             .Top           = 234
627:             .Left          = 434
628:             .Width         = 40
629:             .Height        = 40
630:             .SpecialEffect = 0
631:             .Visible       = .F.
632:         ENDWITH
633:         BINDEVENT(loc_oCopia.cmd_4c_Marcar, "Click", THIS, "CmdMarcarClick")
634: 
635:         *-- Botao Desmarcar (Desmarcar original) - oculto, revelado apos Processar
636:         loc_oCopia.AddObject("cmd_4c_Desmarcar", "CommandButton")
637:         WITH loc_oCopia.cmd_4c_Desmarcar
638:             .Caption       = ""
639:             .Top           = 274
640:             .Left          = 434
641:             .Width         = 40
642:             .Height        = 40
643:             .SpecialEffect = 0
644:             .Visible       = .F.
645:         ENDWITH
646:         BINDEVENT(loc_oCopia.cmd_4c_Desmarcar, "Click", THIS, "CmdDesmarcarClick")
647: 
648:         *-- Labels de legenda de cores (Say3-Say8 do legado)
649:         loc_oCopia.AddObject("lbl_4c_Label3", "Label")
650:         WITH loc_oCopia.lbl_4c_Label3
651:             .AutoSize  = .F.
652:             .Caption   = "Vermelho : "
653:             .Top       = 317
654:             .Left      = 40
655:             .Width     = 74
656:             .Height    = 15
657:             .FontName  = "Tahoma"
658:             .FontSize  = 8
659:             .ForeColor = RGB(192, 0, 0)
660:             .BackStyle = 0
661:             .Visible   = .T.
662:         ENDWITH
663: 
664:         loc_oCopia.AddObject("lbl_4c_Label4", "Label")
665:         WITH loc_oCopia.lbl_4c_Label4
666:             .AutoSize  = .F.
667:             .Caption   = "Produtos existem na Origem e no Destino."
668:             .Top       = 317
669:             .Left      = 118
670:             .Width     = 204
671:             .Height    = 15
672:             .FontName  = "Tahoma"
673:             .FontSize  = 8
674:             .BackStyle = 0
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         loc_oCopia.AddObject("lbl_4c_Label6", "Label")
679:         WITH loc_oCopia.lbl_4c_Label6
680:             .AutoSize  = .F.
681:             .Caption   = "Azul : "
682:             .Top       = 333
683:             .Left      = 45
684:             .Width     = 70
685:             .Height    = 15
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .ForeColor = RGB(0, 0, 192)
689:             .BackStyle = 0
690:             .Visible   = .T.
691:         ENDWITH
692: 
693:         loc_oCopia.AddObject("lbl_4c_Label5", "Label")
694:         WITH loc_oCopia.lbl_4c_Label5
695:             .AutoSize  = .F.
696:             .Caption   = "Produtos existem no Destino mas n" + CHR(227) + "o existem na Origem"
697:             .Top       = 333
698:             .Left      = 118
699:             .Width     = 274
700:             .Height    = 15
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .BackStyle = 0
704:             .Visible   = .T.
705:         ENDWITH
706: 
707:         loc_oCopia.AddObject("lbl_4c_Label7", "Label")
708:         WITH loc_oCopia.lbl_4c_Label7
709:             .AutoSize  = .F.
710:             .Caption   = "Preto : "
711:             .Top       = 349
712:             .Left      = 45
713:             .Width     = 70
714:             .Height    = 15
715:             .FontName  = "Tahoma"
716:             .FontSize  = 8
717:             .BackStyle = 0
718:             .Visible   = .T.
719:         ENDWITH
720: 
721:         loc_oCopia.AddObject("lbl_4c_Label8", "Label")
722:         WITH loc_oCopia.lbl_4c_Label8
723:             .AutoSize  = .F.
724:             .Caption   = "Produtos existem na Origem mas n" + CHR(227) + "o existem no Destino"
725:             .Top       = 349
726:             .Left      = 118
727:             .Width     = 274
728:             .Height    = 15
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .BackStyle = 0
732:             .Visible   = .T.
733:         ENDWITH
734: 
735:         *-- Grid de itens para copia (GrdItens original)
736:         *-- ColumnCount OBRIGATORIO fora de WITH (Problema 36)
737:         *-- Column1 tem CheckBox; ReadOnly=.F. para permitir marcar registros
738:         loc_oCopia.AddObject("grd_4c_Dados", "Grid")
739:         loc_oCopia.grd_4c_Dados.ColumnCount = 6
740:         WITH loc_oCopia.grd_4c_Dados
741:             .Top           = 131
742:             .Left          = 27
743:             .Width         = 403
744:             .Height        = 184
745:             .ReadOnly      = .F.
746:             .FontName      = "Tahoma"
747:             .FontSize      = 8

*-- Linhas 753 a 774:
753:             .DeleteMark   = .F.
754:         ENDWITH
755: 
756:         *-- CheckBox na Column1 (Check1 original): marca registro para copia
757:         loc_oCopia.grd_4c_Dados.Column1.AddObject("chk_4c_Check1", "CheckBox")
758:         WITH loc_oCopia.grd_4c_Dados.Column1
759:             .CurrentControl = "chk_4c_Check1"
760:             .Sparse         = .F.
761:             .Width          = 30
762:             .ReadOnly       = .F.
763:         ENDWITH
764:         WITH loc_oCopia.grd_4c_Dados.Column1.chk_4c_Check1
765:             .Caption = ""
766:             .Width   = 25
767:             .Height  = 17
768:         ENDWITH
769:         loc_oCopia.grd_4c_Dados.Column1.Header1.Caption = ""
770: 
771:         *-- Tornar controles visiveis (cnt_4c_Copia permanece oculto)
772:         THIS.TornarControlesVisiveis(loc_oPag)
773:     ENDPROC
774: 

*-- Linhas 787 a 809:
787:         *----------------------------------------------------------------------
788:         loc_oPag.AddObject("cnt_4c_BotoesAcao", "Container")
789:         WITH loc_oPag.cnt_4c_BotoesAcao
790:             .Top         = 26
791:             .Left        = 843
792:             .Width       = 160
793:             .Height      = 85
794:             .BackStyle   = 0
795:             .BorderWidth = 0
796:             .Visible     = .T.
797:         ENDWITH
798: 
799:         *-- Botao Confirmar (salva dados do grid de estoque maximo)
800:         loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
801:         WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar
802:             .Caption         = "Confirmar"
803:             .Top             = 5
804:             .Left            = 5
805:             .Width           = 75
806:             .Height          = 75
807:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
808:             .PicturePosition = 13
809:             .FontName        = "Tahoma"

*-- Linhas 819 a 834:
819:             .AutoSize        = .F.
820:             .Visible         = .T.
821:         ENDWITH
822:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
823: 
824:         *-- Botao Cancelar (descarta e volta para lista)
825:         loc_oPag.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
826:         WITH loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar
827:             .Caption         = "Encerrar"
828:             .Top             = 5
829:             .Left            = 80
830:             .Width           = 75
831:             .Height          = 75
832:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
833:             .PicturePosition = 13
834:             .FontName        = "Tahoma"

*-- Linhas 844 a 890:
844:             .AutoSize        = .F.
845:             .Visible         = .T.
846:         ENDWITH
847:         BINDEVENT(loc_oPag.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
848: 
849:         *----------------------------------------------------------------------
850:         * Label "Produto :" e campos de produto
851:         * Say1: Top=79+29=108, Left=260, Width=47, Height=15
852:         * get_produto: Top=75+29=104, Left=309, Width=108, Height=23
853:         * getDpro:     Top=75+29=104, Left=419, Width=360, Height=23
854:         * get_produto: When=INSERIR/PROCURAR sem produto externo; Valid=lookup SigCdPro
855:         * getDpro: When=INSERIR/PROCURAR sem codigo; Valid=lookup SigCdPro por descricao
856:         *----------------------------------------------------------------------
857:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
858:         WITH loc_oPag.lbl_4c_Label1
859:             .AutoSize  = .F.
860:             .Caption   = "Produto :"
861:             .Top       = 108
862:             .Left      = 260
863:             .Width     = 47
864:             .Height    = 15
865:             .FontName  = "Tahoma"
866:             .FontSize  = 8
867:             .BackStyle = 0
868:             .Visible   = .T.
869:         ENDWITH
870: 
871:         loc_oPag.AddObject("txt_4c__produto", "TextBox")
872:         WITH loc_oPag.txt_4c__produto
873:             .Top     = 104
874:             .Left    = 309
875:             .Width   = 108
876:             .Height  = 23
877:             .Value   = ""
878:             .Visible = .T.
879:         ENDWITH
880:         BINDEVENT(loc_oPag.txt_4c__produto, "KeyPress", THIS, "ValidarProdutoCodigo")
881: 
882:         loc_oPag.AddObject("txt_4c_Dpro", "TextBox")
883:         WITH loc_oPag.txt_4c_Dpro
884:             .Top     = 104
885:             .Left    = 419
886:             .Width   = 360
887:             .Height  = 23
888:             .Value   = ""
889:             .Visible = .T.
890:         ENDWITH

*-- Linhas 897 a 934:
897:         * getDgru: Top=101+29=130, Left=343, Width=150, Height=23 (When=.F.)
898:         * Ambos os campos de grupo sao sempre somente-leitura (When retorna .F.)
899:         *----------------------------------------------------------------------
900:         loc_oPag.AddObject("lbl_4c_Label8", "Label")
901:         WITH loc_oPag.lbl_4c_Label8
902:             .AutoSize  = .F.
903:             .Caption   = "Grupo :"
904:             .Top       = 134
905:             .Left      = 269
906:             .Width     = 38
907:             .Height    = 15
908:             .FontName  = "Tahoma"
909:             .FontSize  = 8
910:             .BackStyle = 0
911:             .Visible   = .T.
912:         ENDWITH
913: 
914:         loc_oPag.AddObject("txt_4c_Cgru", "TextBox")
915:         WITH loc_oPag.txt_4c_Cgru
916:             .Top      = 130
917:             .Left     = 309
918:             .Width    = 31
919:             .Height   = 23
920:             .Value    = ""
921:             .ReadOnly = .T.
922:             .Enabled  = .F.
923:             .Visible  = .T.
924:         ENDWITH
925: 
926:         loc_oPag.AddObject("txt_4c_Dgru", "TextBox")
927:         WITH loc_oPag.txt_4c_Dgru
928:             .Top      = 130
929:             .Left     = 343
930:             .Width    = 150
931:             .Height   = 23
932:             .Value    = ""
933:             .ReadOnly = .T.
934:             .Enabled  = .F.

*-- Linhas 941 a 978:
941:         * getIfor: Top=127+29=156, Left=309, Width=80 (When=.F. -> sempre somente-leitura)
942:         * getDfor: Top=127+29=156, Left=392, Width=220 (When=.F. -> sempre somente-leitura)
943:         *----------------------------------------------------------------------
944:         loc_oPag.AddObject("lbl_4c_Label11", "Label")
945:         WITH loc_oPag.lbl_4c_Label11
946:             .AutoSize  = .F.
947:             .Caption   = "Fornecedor :"
948:             .Top       = 159
949:             .Left      = 243
950:             .Width     = 64
951:             .Height    = 15
952:             .FontName  = "Tahoma"
953:             .FontSize  = 8
954:             .BackStyle = 0
955:             .Visible   = .T.
956:         ENDWITH
957: 
958:         loc_oPag.AddObject("txt_4c_Ifor", "TextBox")
959:         WITH loc_oPag.txt_4c_Ifor
960:             .Top      = 156
961:             .Left     = 309
962:             .Width    = 80
963:             .Height   = 23
964:             .Value    = ""
965:             .ReadOnly = .T.
966:             .Enabled  = .F.
967:             .Visible  = .T.
968:         ENDWITH
969: 
970:         loc_oPag.AddObject("txt_4c_Dfor", "TextBox")
971:         WITH loc_oPag.txt_4c_Dfor
972:             .Top      = 156
973:             .Left     = 392
974:             .Width    = 220
975:             .Height   = 23
976:             .Value    = ""
977:             .ReadOnly = .T.
978:             .Enabled  = .F.

*-- Linhas 984 a 1009:
984:         * Say12: Top=156+29=185, Left=219, Width=88, Height=15
985:         * getRefs: Top=153+29=182, Left=309, Width=150 (When=.F. -> somente-leitura)
986:         *----------------------------------------------------------------------
987:         loc_oPag.AddObject("lbl_4c_Label12", "Label")
988:         WITH loc_oPag.lbl_4c_Label12
989:             .AutoSize  = .F.
990:             .Caption   = "Ref. Fornecedor :"
991:             .Top       = 185
992:             .Left      = 219
993:             .Width     = 88
994:             .Height    = 15
995:             .FontName  = "Tahoma"
996:             .FontSize  = 8
997:             .BackStyle = 0
998:             .Visible   = .T.
999:         ENDWITH
1000: 
1001:         loc_oPag.AddObject("txt_4c_Refs", "TextBox")
1002:         WITH loc_oPag.txt_4c_Refs
1003:             .Top      = 182
1004:             .Left     = 309
1005:             .Width    = 150
1006:             .Height   = 23
1007:             .Value    = ""
1008:             .ReadOnly = .T.
1009:             .Enabled  = .F.

*-- Linhas 1017 a 1068:
1017:         * Problema 30: cada Button precisa de Left, Top, AutoSize (evita sobreposicao)
1018:         * Regra 9.1: NAO usar PUBLIC em DEFINE CLASS; .Value so no OptionGroup (nao em Buttons)
1019:         *----------------------------------------------------------------------
1020:         loc_oPag.AddObject("lbl_4c_Label19", "Label")
1021:         WITH loc_oPag.lbl_4c_Label19
1022:             .AutoSize  = .F.
1023:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
1024:             .Top       = 134
1025:             .Left      = 505
1026:             .Width     = 70
1027:             .Height    = 15
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .BackStyle = 0
1031:             .Visible   = .T.
1032:         ENDWITH
1033: 
1034:         loc_oPag.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1035:         WITH loc_oPag.obj_4c_Opc_situacao
1036:             .ButtonCount = 2
1037:             .Top         = 129
1038:             .Left        = 555
1039:             .Width       = 122
1040:             .Height      = 25
1041:             .BackStyle   = 0
1042:             .BorderStyle = 0
1043:             .Enabled     = .F.
1044:             .Value       = 1
1045:             .Visible     = .T.
1046:         ENDWITH
1047:         WITH loc_oPag.obj_4c_Opc_situacao.Buttons(1)
1048:             .Caption   = "Ativo"
1049:             .BackStyle = 0
1050:             .Left      = 5
1051:             .Top       = 5
1052:             .Width     = 50
1053:             .AutoSize  = .T.
1054:             .FontName  = "Tahoma"
1055:             .FontSize  = 8
1056:             .ForeColor = RGB(90, 90, 90)
1057:             .Themes    = .F.
1058:         ENDWITH
1059:         WITH loc_oPag.obj_4c_Opc_situacao.Buttons(2)
1060:             .Caption   = "Inativo"
1061:             .BackStyle = 0
1062:             .Left      = 62
1063:             .Top       = 5
1064:             .Width     = 50
1065:             .AutoSize  = .T.
1066:             .FontName  = "Tahoma"
1067:             .FontSize  = 8
1068:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1076 a 1088:
1076:         * Memory: standalone cmd icone-only: Themes=.T. para renderizar icone sem texto
1077:         * Visible=.F. inicialmente; setado .T. em BtnIncluirClick e BtnAlterarClick
1078:         *----------------------------------------------------------------------
1079:         loc_oPag.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1080:         WITH loc_oPag.cmd_4c_BtnExcluir
1081:             .Caption         = ""
1082:             .Top             = 414
1083:             .Left            = 700
1084:             .Width           = 40
1085:             .Height          = 40
1086:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1087:             .PicturePosition = 13
1088:             .FontName        = "Tahoma"

*-- Linhas 1095 a 1103:
1095:             .AutoSize        = .F.
1096:             .Visible         = .F.
1097:         ENDWITH
1098:         BINDEVENT(loc_oPag.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLinhaClick")
1099: 
1100:         *----------------------------------------------------------------------
1101:         * Grid editavel de estoque maximo (gradei original)
1102:         * Top=181+29=210, Left=309, Width=387, Height=472, ColumnCount=5
1103:         * ReadOnly=.F.: usuario edita empresa/qtde/tamanho/cor/departamento

*-- Linhas 1110 a 1119:
1110:         loc_oPag.AddObject("grd_4c_Dados", "Grid")
1111:         loc_oPag.grd_4c_Dados.ColumnCount = 5
1112:         WITH loc_oPag.grd_4c_Dados
1113:             .Top           = 210
1114:             .Left          = 309
1115:             .Width         = 387
1116:             .Height        = 472
1117:             .ReadOnly      = .F.
1118:             .FontName      = "Tahoma"
1119:             .FontSize      = 8

*-- Linhas 1242 a 1256:
1242:                 ENDWITH
1243: 
1244:                 *-- Problema 32: Header captions APOS RecordSource
1245:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Produto"
1246:                 loc_oGrd.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1247:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
1248:                 loc_oGrd.Column4.Header1.Caption = "Fornecedor"
1249:                 loc_oGrd.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
1250:                 loc_oGrd.Column6.Header1.Caption = "Grupo"
1251:                 loc_oGrd.Column7.Header1.Caption = "Desc. Grupo"
1252: 
1253:                 *-- Larguras das colunas (total = 950, cabe em Width=971)
1254:                 WITH loc_oGrd
1255:                     .Column1.Width = 100
1256:                     .Column2.Width = 280

*-- Linhas 1304 a 1312:
1304:             THIS.this_lTemTam    = .F.
1305:             THIS.this_nTipoEstos = 0
1306:             THIS.LimparPage2()
1307:             THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .T.
1308:             THIS.AlternarPagina(2)
1309:         CATCH TO loException
1310:             MsgErro("Erro em BtnIncluirClick: " + loException.Message, "Erro")
1311:         ENDTRY
1312:     ENDPROC

*-- Linhas 1337 a 1345:
1337:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1338:                     THIS.PreencherCabecalhoProduto()
1339:                     THIS.VincularGridPage2()
1340:                     THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .F.
1341:                     THIS.AlternarPagina(2)
1342:                 ENDIF
1343:             ELSE
1344:                 MsgAviso("Selecione um produto para visualizar.", "Aviso")
1345:             ENDIF

*-- Linhas 1374 a 1382:
1374:                     THIS.pgf_4c_Paginas.Page2.txt_4c__produto.Value    = ALLTRIM(loc_cCpros)
1375:                     THIS.PreencherCabecalhoProduto()
1376:                     THIS.VincularGridPage2()
1377:                     THIS.pgf_4c_Paginas.Page2.cmd_4c_BtnExcluir.Visible = .T.
1378:                     THIS.AlternarPagina(2)
1379:                 ENDIF
1380:             ELSE
1381:                 MsgAviso("Selecione um produto para alterar.", "Aviso")
1382:             ENDIF

*-- Linhas 1470 a 1478:
1470:             IF !loc_oPag1.cnt_4c_Copia.Visible
1471:                 *-- Mostrar painel: desabilitar controles principais
1472:                 loc_oPag1.cnt_4c_Copia.Visible       = .T.
1473:                 loc_oPag1.cmd_4c_BtnCopiar.Enabled   = .F.
1474:                 loc_oPag1.grd_4c_Lista.Enabled        = .F.
1475:                 loc_oPag1.cnt_4c_Botoes.Enabled       = .F.
1476:                 loc_oPag1.cnt_4c_Saida.Enabled        = .F.
1477:             ELSE
1478:                 THIS.CmdSairCopiaClick()

*-- Linhas 1492 a 1512:
1492:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
1493: 
1494:             loc_oPag1.cnt_4c_Copia.Visible       = .F.
1495:             loc_oPag1.cmd_4c_BtnCopiar.Enabled   = THIS.this_lAcCopiar
1496:             loc_oPag1.grd_4c_Lista.Enabled        = .T.
1497:             loc_oPag1.cnt_4c_Botoes.Enabled       = .T.
1498:             loc_oPag1.cnt_4c_Saida.Enabled        = .T.
1499: 
1500:             WITH loc_oPag1.cnt_4c_Copia
1501:                 .txt_4c_EmpOs.Value       = ""
1502:                 .txt_4c_EmpDs.Value       = ""
1503:                 .txt_4c_EmpDs.Enabled     = .F.
1504:                 .txt_4c_Produto.Value     = ""
1505:                 .grd_4c_Dados.RecordSource = ""
1506:                 .cmd_4c_Marcar.Visible    = .F.
1507:                 .cmd_4c_Desmarcar.Visible = .F.
1508:             ENDWITH
1509: 
1510:             IF USED("cursor_4c_Copia")
1511:                 USE IN cursor_4c_Copia
1512:             ENDIF

*-- Linhas 1624 a 1637:
1624:                         loc_oGrd.Column6.ControlSource = "cursor_4c_Copia.deptos"
1625: 
1626:                         *-- Problema 32: Header captions APOS RecordSource
1627:                         loc_oGrd.Column1.Header1.Caption = ""
1628:                         loc_oGrd.Column2.Header1.Caption = "Produto"
1629:                         loc_oGrd.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1630:                         loc_oGrd.Column4.Header1.Caption = "Tam"
1631:                         loc_oGrd.Column5.Header1.Caption = "Cor"
1632:                         loc_oGrd.Column6.Header1.Caption = "Departamento"
1633: 
1634:                         WITH loc_oGrd
1635:                             .Column1.Width = 30
1636:                             .Column2.Width = 100
1637:                             .Column3.Width = 70

*-- Linhas 1643 a 1652:
1643:                         loc_oGrd.Refresh
1644: 
1645:                         *-- Revelar botoes de marcacao em massa
1646:                         loc_oCopia.cmd_4c_Marcar.Visible    = .T.
1647:                         loc_oCopia.cmd_4c_Desmarcar.Visible = .T.
1648:                     ENDIF
1649:                 ENDIF
1650:             ENDIF
1651:         CATCH TO loException
1652:             MsgErro("Erro em CmdProcessaClick: " + loException.Message, "Erro")

*-- Linhas 1721 a 1731:
1721: 
1722:             loc_oPag1 = THIS.pgf_4c_Paginas.Page1
1723: 
1724:             loc_oPag1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1725:             loc_oPag1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1726:             loc_oPag1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1727:         CATCH TO loException
1728:             MsgErro("Erro em GridListaAfterRowColChange: " + loException.Message, "Erro")
1729:         ENDTRY
1730:     ENDPROC
1731: 

*-- Linhas 1906 a 1918:
1906:             loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1907: 
1908:             WITH THIS.this_oBusinessObject
1909:                 loc_oPag2.txt_4c_Cgru.Value               = .this_cCgrus
1910:                 loc_oPag2.txt_4c_Dgru.Value               = .this_cDgrus
1911:                 loc_oPag2.txt_4c_Ifor.Value               = .this_cIfors
1912:                 loc_oPag2.txt_4c_Dfor.Value               = .this_cRclis
1913:                 loc_oPag2.txt_4c_Refs.Value               = .this_cReffs
1914:                 loc_oPag2.obj_4c_Opc_situacao.Value       = IIF(.this_nSituas = 2, 2, 1)
1915:             ENDWITH
1916:         CATCH TO loException
1917:             MsgErro("Erro em PreencherCabecalhoProduto: " + loException.Message, "Erro")
1918:         ENDTRY

*-- Linhas 1984 a 1996:
1984:                 loc_oGrd.Column5.ControlSource = "cursor_4c_MaxProduto.deptos"
1985: 
1986:                 *-- Problema 32: Header captions APOS RecordSource
1987:                 loc_oGrd.Column1.Header1.Caption = "Empresa"
1988:                 loc_oGrd.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1989:                 loc_oGrd.Column3.Header1.Caption = "Tam"
1990:                 loc_oGrd.Column4.Header1.Caption = "Cor"
1991:                 loc_oGrd.Column5.Header1.Caption = "Departamento"
1992: 
1993:                 WITH loc_oGrd
1994:                     .Column1.Width = 40
1995:                     .Column2.Width = 80
1996:                     .Column3.Width = 70

*-- Linhas 2021 a 2029:
2021: 
2022:     *==========================================================================
2023:     * BtnExcluirLinhaClick - Exclui linha da empresa corrente no grid de estoque
2024:     * Disponivel apenas em INSERIR/ALTERAR (cmd_4c_BtnExcluir.Visible=.F. em CONSULTAR)
2025:     *==========================================================================
2026:     PROCEDURE BtnExcluirLinhaClick()
2027:         LOCAL loc_lConfirma, loc_cCpros, loc_cEmps, loc_lSucesso
2028:         loc_lConfirma = .F.
2029:         loc_cCpros    = ""

*-- Linhas 2402 a 2439:
2402:             loc_oPag2.obj_4c_Opc_situacao.Enabled      = .F.
2403: 
2404:             *-- Botao Excluir linha: visivel apenas em INSERIR/ALTERAR
2405:             loc_oPag2.cmd_4c_BtnExcluir.Visible = ;
2406:                 INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2407:         CATCH TO loException
2408:             MsgErro("Erro em HabilitarCampos: " + loException.Message, "Erro")
2409:         ENDTRY
2410:     ENDPROC
2411: 
2412:     *==========================================================================
2413:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme this_cPcEscolha
2414:     * LISTA: botoes CRUD habilitados, botoes acao Page2 ocultos
2415:     * INSERIR/ALTERAR: botoes acao Page2 habilitados; cmd_4c_BtnExcluir visivel
2416:     * CONSULTAR: grid somente-leitura; cmd_4c_BtnExcluir oculto
2417:     *==========================================================================
2418:     PROCEDURE AjustarBotoesPorModo()
2419:         LOCAL loc_oPag2, loc_lEdicao
2420:         loc_oPag2  = .NULL.
2421:         loc_lEdicao = .F.
2422: 
2423:         TRY
2424:             loc_oPag2   = THIS.pgf_4c_Paginas.Page2
2425:             loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
2426: 
2427:             *-- Botao Confirmar: sempre habilitado quando na Page2
2428:             loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
2429: 
2430:             *-- Botao Cancelar: sempre habilitado
2431:             loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
2432: 
2433:             *-- Botao Excluir linha: visivel apenas em edicao
2434:             loc_oPag2.cmd_4c_BtnExcluir.Visible = loc_lEdicao
2435: 
2436:             *-- Grid editavel/readonly conforme modo
2437:             IF THIS.this_cPcEscolha = "CONSULTAR"
2438:                 WITH loc_oPag2.grd_4c_Dados
2439:                     .Column1.ReadOnly = .T.


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object: Estoque M?ximo
* Tabela: SigCdMax
* PK: cidchaves (CHAR 20 - UUID)
* Autor: Migra??o VFP9 - task165
*==============================================================================

*------------------------------------------------------------------------------
* DEFINE CLASS sigprcomBO AS BusinessBase
*------------------------------------------------------------------------------
DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da tabela SigCdMax (schema.sql)
    this_cCidchaves = ""    && cidchaves CHAR(20) PK - UUID
    this_cCpros     = ""    && cpros     CHAR(14) - C?digo do produto
    this_cEmps      = ""    && emps      CHAR(3)  - C?digo da empresa
    this_nQmaxs     = 0     && qmaxs     NUMERIC(7,2) - Qtde. m?xima
    this_cCodtams   = ""    && codtams   CHAR(4)  - C?digo do tamanho
    this_cCodcores  = ""    && codcores  CHAR(4)  - C?digo da cor
    this_cDeptos    = ""    && deptos    CHAR(10) - C?digo do departamento
    this_cOrdems    = ""    && ordems    CHAR(1)  - Ordem

    *-- Propriedades de exibi??o (joins com SigCdPro, SigCdCli, SigCdGrp)
    this_cDpros     = ""    && SigCdPro.dpros   - Descri??o do produto
    this_cIfors     = ""    && SigCdPro.ifors   - C?digo do fornecedor
    this_cReffs     = ""    && SigCdPro.reffs   - Refer?ncia do fornecedor
    this_cCgrus     = ""    && SigCdPro.cgrus   - C?digo do grupo
    this_nSituas    = 1     && SigCdPro.situas  - Situa??o (1=Ativo, 2=Inativo)
    this_cRclis     = ""    && SigCdCli.rclis   - Nome do fornecedor
    this_cDgrus     = ""    && SigCdGrp.dgrus   - Descri??o do grupo

    *-- Flags de configura??o do produto (carregados de SigCdPro/SigCdGrp)
    this_lTemCor    = .F.   && Produto tem controle de cor
    this_lTemTam    = .F.   && Produto tem controle de tamanho
    this_nTipoEstos = 0     && Tipo de estoque (SigCdGrp.tipoestos)

    *--------------------------------------------------------------------------
    * Init - Inicializa??o do BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave prim?ria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidchaves
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista produtos com estoque m?ximo (SELECT principal da Page1)
    * par_cFiltro: filtro adicional WHERE (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cFiltro") != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    GOTO TOP IN cursor_4c_Dados
                ELSE
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar produtos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorProduto - Carrega linhas de SigCdMax para um produto espec?fico
    * Popula cursor_4c_MaxProduto com emps/qmaxs/codtams/codcores/deptos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, emps, qmaxs, codtams, codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCpros)) + ;
                       " ORDER BY emps, codtams, codcores"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxProduto")

            IF loc_nResultado >= 0
                IF !EMPTY(ALLTRIM(par_cCpros))
                    THIS.CarregarFlagsTemCorTam(par_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar estoque m?ximo: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarPorProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCabecalhoProduto - Carrega dados do cabe?alho para um produto
    * Popula cursor_4c_Cabecalho com campos do produto + fornecedor + grupo
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCabecalhoProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT" + ;
                       " a.cpros, b.dpros, b.ifors, b.reffs," + ;
                       " b.cgrus, b.situas, c.rclis, g.dgrus, a.qmaxs" + ;
                       " FROM SigCdMax a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " LEFT JOIN SigCdCli c ON b.ifors = c.iclis" + ;
                       " LEFT JOIN SigCdGrp g ON b.cgrus = g.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Cabecalho")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Cabecalho") > 0
                    GO TOP IN cursor_4c_Cabecalho
                    SELECT cursor_4c_Cabecalho
                    THIS.this_cCpros   = ALLTRIM(cpros)
                    THIS.this_cDpros   = ALLTRIM(dpros)
                    THIS.this_cIfors   = ALLTRIM(ifors)
                    THIS.this_cRclis   = ALLTRIM(rclis)
                    THIS.this_cReffs   = ALLTRIM(reffs)
                    THIS.this_cCgrus   = ALLTRIM(cgrus)
                    THIS.this_cDgrus   = ALLTRIM(dgrus)
                    THIS.this_nSituas  = NVL(situas, 1)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar cabe?alho: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarCabecalhoProduto: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega uma linha de SigCdMax pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCidchaves") != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT cidchaves, cpros, emps, qmaxs, codtams," + ;
                       " codcores, deptos, ordems" + ;
                       " FROM SigCdMax" + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * REGRA: SEMPRE usar SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
            THIS.this_cCpros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cCodtams   = TratarNulo(codtams,   "C")
            THIS.this_cCodcores  = TratarNulo(codcores,  "C")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFlagsTemCorTam - Verifica se produto tem cor/tamanho ativos
    * Popula this_lTemCor, this_lTemTam, this_nTipoEstos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFlagsTemCorTam(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.cores, b.tams, b.tipoestos" + ;
                       " FROM SigCdPro a" + ;
                       " INNER JOIN SigCdGrp b ON b.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProGru")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProGru") > 0
                GO TOP IN cursor_4c_ProGru
                SELECT cursor_4c_ProGru
                THIS.this_nTipoEstos = NVL(tipoestos, 0)
                THIS.this_lTemCor = INLIST(THIS.this_nTipoEstos, 2, 4) OR NVL(cores, 0) = 1
                THIS.this_lTemTam = INLIST(THIS.this_nTipoEstos, 3, 4) OR NVL(tams, 0) = 1
                loc_lSucesso = .T.
            ELSE
                THIS.this_lTemCor    = .F.
                THIS.this_lTemTam    = .F.
                THIS.this_nTipoEstos = 0
            ENDIF

            IF USED("cursor_4c_ProGru")
                USE IN cursor_4c_ProGru
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarFlagsTemCorTam: " + loException.Message, "Erro")
            THIS.this_lTemCor    = .F.
            THIS.this_lTemTam    = .F.
            THIS.this_nTipoEstos = 0
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InserirLinhaCursorLocal - Insere nova linha no cursor local de estoque
    * Usado para adicionar linha vazia no grid (nova empresa)
    *--------------------------------------------------------------------------
    PROCEDURE InserirLinhaCursorLocal(par_cCpros)
        LOCAL loc_lSucesso, loc_cCidchave
        loc_lSucesso = .F.

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY

            loc_cCidchave = GerarUUID()

            INSERT INTO cursor_4c_MaxProduto ;
                (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems) ;
                VALUES (loc_cCidchave, par_cCpros, "", 0, "", "", "", "")

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em InserirLinhaCursorLocal: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarUUID - Gera identificador ?nico (substitui fUniqueIds do legado)
    *--------------------------------------------------------------------------
    PROCEDURE GerarUUID()
        RETURN SUBSTR(SYS(3), 1, 20)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir (PROTECTED) - Insere uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Gerar cidchaves se vazio
            IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                THIS.this_cCidchaves = THIS.GerarUUID()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCidchaves), 20)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros),     14)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),       3)) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQmaxs)                  + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),    4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores),   4)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),    10)) + "," + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),     1)) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar (PROTECTED) - Atualiza uma linha de SigCdMax no banco
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " emps    = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cEmps),     3)) + "," + ;
                       " qmaxs   = " + FormatarNumeroSQL(THIS.this_nQmaxs)               + "," + ;
                       " codtams = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodtams),  4)) + "," + ;
                       " codcores= " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCodcores), 4)) + "," + ;
                       " deptos  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cDeptos),  10)) + "," + ;
                       " ordems  = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cOrdems),   1)) + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao (PROTECTED) - Remove todas as linhas de um produto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND EMPTY(ALLTRIM(THIS.this_cCpros))
            MsgAviso("Nenhum registro selecionado para exclus" + CHR(227) + "o!")
            RETURN .F.
        ENDIF

        TRY

            *-- Excluir pelo cidchaves (linha espec?fica)
            IF !EMPTY(ALLTRIM(THIS.this_cCidchaves))
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
            ELSE
                *-- Excluir todas as linhas do produto
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(THIS.this_cCpros), 14))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGridEstoque - Persiste o cursor_4c_MaxProduto no banco (UPDATE/INSERT)
    * Chamado ao salvar o grid de estoque m?ximo por produto
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGridEstoque(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_MaxProduto")
            RETURN .F.
        ENDIF

        TRY
            *-- Remover linhas vazias (sem empresa) antes de salvar
            loc_cSQL = "DELETE FROM SigCdMax" + ;
                       " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                       " AND emps = '   '"
            SQLEXEC(gnConnHandle, loc_cSQL)

            *-- Iterar sobre o cursor e salvar cada linha
            SELECT cursor_4c_MaxProduto
            GO TOP

            DO WHILE !EOF("cursor_4c_MaxProduto")
                SELECT cursor_4c_MaxProduto

                IF !EMPTY(ALLTRIM(emps))
                    THIS.this_cCidchaves = ALLTRIM(cidchaves)
                    THIS.this_cCpros     = PADR(ALLTRIM(par_cCpros), 14)
                    THIS.this_cEmps      = ALLTRIM(emps)
                    THIS.this_nQmaxs     = NVL(qmaxs, 0)
                    THIS.this_cCodtams   = ALLTRIM(codtams)
                    THIS.this_cCodcores  = ALLTRIM(codcores)
                    THIS.this_cDeptos    = ALLTRIM(deptos)
                    THIS.this_cOrdems    = ALLTRIM(ordems)

                    *-- Verificar se j? existe no banco
                    LOCAL loc_nCheck
                    loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdMax" + ;
                               " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                    loc_nCheck = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Check")

                    LOCAL loc_lExiste
                    loc_lExiste = .F.
                    IF loc_nCheck >= 0 AND RECCOUNT("cursor_4c_Check") > 0
                        SELECT cursor_4c_Check
                        loc_lExiste = (NVL(qtd, 0) > 0)
                    ENDIF

                    IF USED("cursor_4c_Check")
                        USE IN cursor_4c_Check
                    ENDIF

                    IF loc_lExiste
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        THIS.this_lNovoRegistro = .T.
                        IF EMPTY(ALLTRIM(THIS.this_cCidchaves))
                            THIS.this_cCidchaves = THIS.GerarUUID()
                        ENDIF
                    ENDIF

                    IF !THIS.Salvar()
                        loc_lSucesso = .F.
                        EXIT
                    ENDIF
                ENDIF

                SELECT cursor_4c_MaxProduto
                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("SAVE_GRID")
        CATCH TO loException
            MsgErro("Erro em SalvarGridEstoque: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirLinhaEmpresa - Remove linha de estoque m?ximo de uma empresa
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirLinhaEmpresa(par_cCpros, par_cEmps)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("par_cCpros") != "C" OR EMPTY(ALLTRIM(par_cCpros))
            RETURN .F.
        ENDIF

        TRY
            IF EMPTY(ALLTRIM(par_cEmps))
                *-- Excluir todas as linhas do produto sem empresa
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND RTRIM(emps) = ''"
            ELSE
                *-- Excluir linhas da empresa espec?fica
                loc_cSQL = "DELETE FROM SigCdMax" + ;
                           " WHERE cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14)) + ;
                           " AND emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmps), 3))
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir empresa: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExcluirLinhaEmpresa: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarEstoqueProduto - Copia registros de estoque entre empresas
    * par_cCpros: produto a copiar (vazio = todos)
    * par_cEmpO: empresa de origem
    * par_cEmpD: empresa de destino
    * Retorna n?mero de registros copiados
    *--------------------------------------------------------------------------
    PROCEDURE CopiarEstoqueProduto(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_nCopiados, loc_lSucesso
        loc_lSucesso  = .F.
        loc_nCopiados = 0

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            MsgErro("Empresa origem e destino s" + CHR(227) + "o obrigat" + CHR(243) + "rias!", "Aviso")
            RETURN .F.
        ENDIF

        IF ALLTRIM(par_cEmpO) = ALLTRIM(par_cEmpD)
            MsgErro("Empresa destino n" + CHR(227) + "o pode ser igual " + CHR(224) + " empresa origem!", "Aviso")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            SELECT cursor_4c_Copia
            GO TOP

            DO WHILE !EOF("cursor_4c_Copia")
                SELECT cursor_4c_Copia

                IF NVL(marcas, 0) = 1 AND NVL(existes, 0) = 0
                    LOCAL loc_cNovoId
                    loc_cNovoId = THIS.GerarUUID()

                    loc_cSQL = "INSERT INTO SigCdMax" + ;
                               " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoId)                              + "," + ;
                               EscaparSQL(PADR(ALLTRIM(cpros),       14))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(par_cEmpD),    3))           + "," + ;
                               FormatarNumeroSQL(NVL(qmaxs, 0))                     + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codtams),      4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(codcores),     4))           + "," + ;
                               EscaparSQL(PADR(ALLTRIM(deptos),      10))           + "," + ;
                               EscaparSQL(" ")                                      + ;
                               ")"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        loc_nCopiados = loc_nCopiados + 1
                    ENDIF
                ENDIF

                SKIP
            ENDDO

            loc_lSucesso = .T.
            THIS.RegistrarAuditoria("COPY")
        CATCH TO loException
            MsgErro("Erro em CopiarEstoqueProduto: " + loException.Message, "Erro")
        ENDTRY

        *-- Retornar n?mero de copiados via propriedade
        THIS.this_nQmaxs = loc_nCopiados

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCursorCopia - Carrega cursor_4c_Copia para copiar entre empresas
    * Mostra quais produtos existem na origem e compara com o destino
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCursorCopia(par_cCpros, par_cEmpO, par_cEmpD)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cEmpO)) OR EMPTY(ALLTRIM(par_cEmpD))
            RETURN .F.
        ENDIF

        TRY
            *-- Union: nao existem no destino | existem em ambos | existem no destino mas nao na origem
            loc_cSQL = "SELECT 1 AS marcas, 0 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND (a.cpros + a.codtams + a.codcores) NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 1 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3)) + ")" + ;
                       " UNION ALL" + ;
                       " SELECT 0 AS marcas, 2 AS existes," + ;
                       " a.cpros, a.emps, a.qmaxs, a.codtams, a.codcores, a.deptos, a.cidchaves" + ;
                       " FROM SigCdMax a" + ;
                       " WHERE a.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpD), 3))

            IF !EMPTY(ALLTRIM(par_cCpros))
                loc_cSQL = loc_cSQL + " AND a.cpros = " + EscaparSQL(PADR(ALLTRIM(par_cCpros), 14))
            ENDIF

            loc_cSQL = loc_cSQL + ;
                       " AND a.cpros + a.codtams + a.codcores NOT IN (" + ;
                       " SELECT b.cpros + b.codtams + b.codcores FROM SigCdMax b" + ;
                       " WHERE b.emps = " + EscaparSQL(PADR(ALLTRIM(par_cEmpO), 3)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")

            IF loc_nResultado >= 0
                GO TOP IN cursor_4c_Copia
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar c" + CHR(243) + "pia: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarCursorCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodosParaCopia - Marca/desmarca todos registros do cursor_4c_Copia
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodosParaCopia(par_lMarcar)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED("cursor_4c_Copia")
            RETURN .F.
        ENDIF

        TRY
            LOCAL loc_nMarca
            loc_nMarca = IIF(par_lMarcar, 1, 0)

            UPDATE cursor_4c_Copia SET marcas = loc_nMarca WHERE existes = 0

            GO TOP IN cursor_4c_Copia
            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em MarcarTodosParaCopia: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

