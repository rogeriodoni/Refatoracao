# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_OPESTOQUE, CNT_4C_OPCUSTO, CNT_4C_OPCOMPRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [INIT-DUPLICADO] Init() chama DODEFAULT() E THIS.InicializarForm(). FormBase.Init() ja chama InicializarForm() internamente. Isso causa 'A member object with this name already exists' porque ConfigurarPageFrame/AddObject executa 2 vezes. CORRIGIR: Remover THIS.InicializarForm() do Init() - DODEFAULT() ja faz isso.
- [LAYOUT-POSITION] Controle 'Processa' (parent: SIGPRCCC): Left original=650 vs migrado 'cmd_4c_Processar' Left=812 (diff=162px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpEstoque' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpEstoque' Left=173 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpConta' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpConta' Left=173 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'LblEnd' (parent: SIGPRCCC): Left original=361 vs migrado 'lbl_4c_LblEnd' Left=451 (diff=90px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGPRCCC): Top original=3 vs migrado 'txt_4c_EstoqueEst' Top=62 (diff=59px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGPRCCC): Left original=425 vs migrado 'txt_4c_EstoqueEst' Left=112 (diff=313px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGPRCCC): Left original=350 vs migrado 'txt_4c_EmpresaConta' Left=93 (diff=257px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCusto' (parent: SIGPRCCC): Left original=500 vs migrado 'chk_4c_BtnCusto' Left=625 (diff=125px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCusto' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpCusto' Left=173 (diff=34px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnCompra' (parent: SIGPRCCC): Left original=575 vs migrado 'chk_4c_BtnCompra' Left=718 (diff=143px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OpCompra' (parent: SIGPRCCC): Left original=139 vs migrado 'cnt_4c_OpCompra' Left=173 (diff=34px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1912 linhas total):

*-- Linhas 37 a 166:
37:     this_oBusinessObject = .NULL.
38: 
39:     *--------------------------------------------------------------------------
40:     PROCEDURE Init()
41:     *  DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
42:     *--------------------------------------------------------------------------
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     PROCEDURE InicializarForm()
48:     *  Cria toda a estrutura visual do form OPERACIONAL
49:     *--------------------------------------------------------------------------
50:         LOCAL loc_lSucesso
51:         loc_lSucesso = .F.
52:         TRY
53:             *-- Modo validacao UI: nao executa SQL
54:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
55:                 loc_lSucesso = .T.
56:             ENDIF
57: 
58:             *-- Verificar conexao principal
59:             IF gnConnHandle <= 0
60:                 MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
61:                         "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
62:                 loc_lSucesso = .F.
63:             ENDIF
64: 
65:             *-- Criar Business Object
66:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
67:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
68:                 MsgErro("Falha ao criar objeto de neg" + CHR(243) + "cios.", "Erro")
69:                 loc_lSucesso = .F.
70:             ENDIF
71: 
72:             *-- Configuracao base do form (Picture, dimensoes, caption)
73:             *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
74:             *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
75:             THIS.ConfigurarPageFrame()
76: 
77:             *-- Criar estrutura visual
78:             THIS.ConfigurarCabecalho()
79:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
80:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
81:             THIS.ConfigurarCheckboxes()
82:             THIS.ConfigurarBotoesPrincipais()
83:             THIS.ConfigurarContaineresOpcoes()
84:             THIS.ConfigurarPaginaDados()
85:             THIS.ConfigurarBINDEVENTs()
86:             THIS.ConfigurarRodape()
87: 
88:             *-- Tornar controles visiveis (exceto containers de opcoes e LblEnd)
89:             THIS.TornarControlesVisiveis(THIS)
90: 
91:             *-- Aplicar estado inicial: checkboxes off, containers ocultos,
92:             *   contador zerado, botao Processar desabilitado
93:             THIS.ConfigurarPaginaLista()
94: 
95:             loc_lSucesso = .T.
96:         CATCH TO loc_oErro
97:             MsgErro(loc_oErro.Message, "Erro")
98:         ENDTRY
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:     *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
105:     *  Ajusta Picture, Caption, dimensoes e centralizacao. Mantem o nome
106:     *  ConfigurarPageFrame por convencao do pipeline de migracao.
107:     *--------------------------------------------------------------------------
108:         LOCAL loc_cImgFundo
109: 
110:         *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
111:         THIS.Caption = "Rec" + CHR(225) + "lculo de Saldos"
112: 
113:         *-- Imagem de fundo do framework
114:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
115:         IF FILE(loc_cImgFundo)
116:             THIS.Picture = loc_cImgFundo
117:         ENDIF
118: 
119:         *-- Reforca dimensoes canonicas (escala 1.25x do legado 800x600)
120:         THIS.Width      = 1000
121:         THIS.Height     = 600
122:         THIS.AutoCenter = .T.
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     PROTECTED PROCEDURE ConfigurarCabecalho()
127:     *  Container cinza escuro com titulo do form
128:     *--------------------------------------------------------------------------
129:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
130:         WITH THIS.cnt_4c_Cabecalho
131:             .Top         = 0
132:             .Left        = 0
133:             .Width       = 1000
134:             .Height      = 80
135:             .BackStyle   = 1
136:             .BackColor   = RGB(100, 100, 100)
137:             .BorderWidth = 0
138:             .Visible     = .T.
139: 
140:             .AddObject("lbl_4c_Sombra", "Label")
141:             WITH .lbl_4c_Sombra
142:                 .Top       = 18
143:                 .Left      = 10
144:                 .Width     = THIS.Width
145:                 .Height    = 40
146:                 .AutoSize  = .F.
147:                 .BackStyle = 0
148:                 .FontBold  = .T.
149:                 .FontName  = "Tahoma"
150:                 .FontSize  = 18
151:                 .ForeColor = RGB(0, 0, 0)
152:                 .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
153:                 .Visible   = .T.
154:             ENDWITH
155: 
156:             .AddObject("lbl_4c_Titulo", "Label")
157:             WITH .lbl_4c_Titulo
158:                 .Top       = 17
159:                 .Left      = 10
160:                 .Width     = THIS.Width
161:                 .Height    = 46
162:                 .AutoSize  = .F.
163:                 .BackStyle = 0
164:                 .FontBold  = .T.
165:                 .FontName  = "Tahoma"
166:                 .FontSize  = 18

*-- Linhas 172 a 215:
172:     ENDPROC
173: 
174:     *--------------------------------------------------------------------------
175:     PROTECTED PROCEDURE ConfigurarCheckboxes()
176:     *  Shape de fundo decorativo + 4 checkboxes de selecao de modulo
177:     *  Posicoes escaladas 1.25x do original (800->1000)
178:     *--------------------------------------------------------------------------
179:         *-- Shape decorativo de fundo dos botoes de acao (direita)
180:         THIS.AddObject("shp_4c_Shape1", "Shape")
181:         WITH THIS.shp_4c_Shape1
182:             .Top         = 7
183:             .Left        = 871
184:             .Height      = 110
185:             .Width       = 112
186:             .BackStyle   = 0
187:             .BorderStyle = 0
188:             .BorderColor = RGB(136, 189, 188)
189:             .Visible     = .T.
190:         ENDWITH
191: 
192:         *-- CheckBox: Conta Corrente (original Left=350 -> 437)
193:         THIS.AddObject("chk_4c_Conta", "CheckBox")
194:         WITH THIS.chk_4c_Conta
195:             .Top           = 3
196:             .Left          = 437
197:             .Height        = 75
198:             .Width         = 75
199:             .FontBold      = .T.
200:             .FontItalic    = .T.
201:             .FontName      = "Tahoma"
202:             .FontSize      = 8
203:             .AutoSize      = .F.
204:             .Alignment     = 1
205:             .BackStyle     = 0
206:             .Caption       = "C.C."
207:             .Value         = 0
208:             .SpecialEffect = 0
209:             .Style         = 1
210:             .ToolTipText   = "Conta Corrente"
211:             .ForeColor     = RGB(90, 90, 90)
212:             .BackColor     = RGB(255, 255, 255)
213:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
214:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
215:             .Themes        = .F.

*-- Linhas 297 a 340:
297:     ENDPROC
298: 
299:     *--------------------------------------------------------------------------
300:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
301:     *  Botoes Processar e Encerrar (original Left=650/725 -> 812/906)
302:     *--------------------------------------------------------------------------
303:         *-- Botao Processar (inicia desabilitado - habilita quando algum checkbox marcado)
304:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
305:         WITH THIS.cmd_4c_Processar
306:             .Top             = 3
307:             .Left            = 812
308:             .Height          = 75
309:             .Width           = 75
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .FontName        = "Tahoma"
313:             .FontSize        = 8
314:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
315:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
316:             .Caption         = "Processar"
317:             .Enabled         = .F.
318:             .ToolTipText     = "Processar"
319:             .SpecialEffect   = 0
320:             .ForeColor       = RGB(90, 90, 90)
321:             .BackColor       = RGB(255, 255, 255)
322:             .Themes          = .T.
323:             .WordWrap        = .T.
324:             .Visible         = .T.
325:         ENDWITH
326: 
327:         *-- Botao Encerrar (Cancel=.T. -> ESC fecha o form)
328:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
329:         WITH THIS.cmd_4c_Encerrar
330:             .Top           = 3
331:             .Left          = 906
332:             .Height        = 75
333:             .Width         = 75
334:             .FontBold      = .T.
335:             .FontItalic    = .T.
336:             .FontName      = "Tahoma"
337:             .FontSize      = 8
338:             .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
339:             .Cancel        = .T.
340:             .Caption       = "Encerrar"

*-- Linhas 349 a 459:
349:     ENDPROC
350: 
351:     *--------------------------------------------------------------------------
352:     PROTECTED PROCEDURE ConfigurarContaineresOpcoes()
353:     *  4 containers de parametros - iniciam ocultos, toggled pelos checkboxes
354:     *  Posicoes escaladas 1.25x: Left=139->173, Width=536->670
355:     *--------------------------------------------------------------------------
356: 
357:         *-- Container: Opcoes de Conta Corrente (original Top=114)
358:         THIS.AddObject("cnt_4c_OpConta", "Container")
359:         WITH THIS.cnt_4c_OpConta
360:             .Top           = 114
361:             .Left          = 173
362:             .Width         = 670
363:             .Height        = 81
364:             .BackStyle     = 0
365:             .BorderWidth   = 2
366:             .SpecialEffect = 2
367:             .BackColor     = RGB(192, 192, 255)
368:             .BorderColor   = RGB(90, 90, 90)
369:             .Visible       = .F.
370:         ENDWITH
371: 
372:         *-- Container: Opcoes de Estoque (original Top=200)
373:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
374:         WITH THIS.cnt_4c_OpEstoque
375:             .Top           = 200
376:             .Left          = 173
377:             .Width         = 670
378:             .Height        = 143
379:             .BackStyle     = 0
380:             .BorderWidth   = 2
381:             .SpecialEffect = 2
382:             .BackColor     = RGB(192, 192, 255)
383:             .BorderColor   = RGB(90, 90, 90)
384:             .Visible       = .F.
385:         ENDWITH
386: 
387:         *-- Container: Opcoes de Custo de Produto (original Top=349)
388:         THIS.AddObject("cnt_4c_OpCusto", "Container")
389:         WITH THIS.cnt_4c_OpCusto
390:             .Top           = 349
391:             .Left          = 173
392:             .Width         = 670
393:             .Height        = 92
394:             .BackStyle     = 0
395:             .BorderWidth   = 2
396:             .SpecialEffect = 2
397:             .BackColor     = RGB(192, 192, 255)
398:             .BorderColor   = RGB(90, 90, 90)
399:             .Visible       = .F.
400:         ENDWITH
401: 
402:         *-- Container: Opcoes de Ultima Compra (original Top=447)
403:         THIS.AddObject("cnt_4c_OpCompra", "Container")
404:         WITH THIS.cnt_4c_OpCompra
405:             .Top           = 447
406:             .Left          = 173
407:             .Width         = 670
408:             .Height        = 91
409:             .BackStyle     = 0
410:             .BorderWidth   = 2
411:             .SpecialEffect = 2
412:             .BackColor     = RGB(192, 192, 255)
413:             .BorderColor   = RGB(90, 90, 90)
414:             .Visible       = .F.
415:         ENDWITH
416:     ENDPROC
417: 
418:     *--------------------------------------------------------------------------
419:     PROTECTED PROCEDURE ConfigurarRodape()
420:     *  Label "Registros:", contador numerico e label de conclusao
421:     *  Posicoes escaladas 1.25x do original
422:     *--------------------------------------------------------------------------
423:         *-- Label "Registros : " (original Left=171 -> 213)
424:         THIS.AddObject("lbl_4c_Registros", "Label")
425:         WITH THIS.lbl_4c_Registros
426:             .Top       = 547
427:             .Left      = 213
428:             .Width     = 65
429:             .Height    = 15
430:             .AutoSize  = .T.
431:             .BackStyle = 0
432:             .FontBold  = .T.
433:             .FontName  = "Tahoma"
434:             .FontSize  = 8
435:             .ForeColor = RGB(90, 90, 90)
436:             .Caption   = "Registros : "
437:             .Visible   = .T.
438:         ENDWITH
439: 
440:         *-- TextBox contador (original Left=238 -> 297, Width=93 -> 116)
441:         *  ReadOnly: legado usa When=Return .F. para impedir foco
442:         THIS.AddObject("txt_4c_Registro", "TextBox")
443:         WITH THIS.txt_4c_Registro
444:             .Top           = 543
445:             .Left          = 297
446:             .Width         = 116
447:             .Height        = 23
448:             .FontName      = "Tahoma"
449:             .FontSize      = 8
450:             .InputMask     = "999,999,999"
451:             .SpecialEffect = 1
452:             .ForeColor     = RGB(0, 0, 0)
453:             .Value         = 0
454:             .ReadOnly      = .T.
455:             .TabStop       = .F.
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         *-- Label conclusao (oculto, exibido ao terminar processamento)

*-- Linhas 476 a 529:
476:         ENDWITH
477:     ENDPROC
478: 
479:     *--------------------------------------------------------------------------
480:     PROTECTED PROCEDURE ConfigurarConteudoOpConta()
481:     *  Sub-controles de cnt_4c_OpConta (Opcoes Conta Corrente)
482:     *--------------------------------------------------------------------------
483:         LOCAL loc_oCnt
484:         loc_oCnt = THIS.cnt_4c_OpConta
485: 
486:         loc_oCnt.AddObject("lbl_4c_TituloConta", "Label")
487:         WITH loc_oCnt.lbl_4c_TituloConta
488:             .Top       = 2
489:             .Left      = 213
490:             .AutoSize  = .T.
491:             .BackStyle = 0
492:             .FontBold  = .T.
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .ForeColor = RGB(0, 0, 128)
496:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         loc_oCnt.AddObject("lbl_4c_EmpresaConta", "Label")
501:         WITH loc_oCnt.lbl_4c_EmpresaConta
502:             .Top       = 23
503:             .Left      = 20
504:             .Width     = 71
505:             .Height    = 15
506:             .AutoSize  = .F.
507:             .BackStyle = 0
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .Caption   = "Empresa :"
511:             .Visible   = .T.
512:         ENDWITH
513:         loc_oCnt.AddObject("txt_4c_EmpresaConta", "TextBox")
514:         WITH loc_oCnt.txt_4c_EmpresaConta
515:             .Top       = 20
516:             .Left      = 93
517:             .Width     = 38
518:             .Height    = 23
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .Value     = ""
522:             .Visible   = .T.
523:         ENDWITH
524: 
525:         loc_oCnt.AddObject("lbl_4c_GruposConta", "Label")
526:         WITH loc_oCnt.lbl_4c_GruposConta
527:             .Top       = 24
528:             .Left      = 152
529:             .Width     = 52

*-- Linhas 623 a 667:
623:         ENDWITH
624:     ENDPROC
625: 
626:     *--------------------------------------------------------------------------
627:     PROTECTED PROCEDURE ConfigurarConteudoOpEstoque()
628:     *  Sub-controles de cnt_4c_OpEstoque (Opcoes de Estoque)
629:     *--------------------------------------------------------------------------
630:         LOCAL loc_oCnt
631:         loc_oCnt = THIS.cnt_4c_OpEstoque
632: 
633:         loc_oCnt.AddObject("lbl_4c_TituloEst", "Label")
634:         WITH loc_oCnt.lbl_4c_TituloEst
635:             .Top       = 2
636:             .Left      = 227
637:             .AutoSize  = .T.
638:             .BackStyle = 0
639:             .FontBold  = .T.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .ForeColor = RGB(0, 0, 128)
643:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
644:             .Visible   = .T.
645:         ENDWITH
646: 
647:         loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
648:         WITH loc_oCnt.lbl_4c_EmpresaEst
649:             .Top       = 15
650:             .Left      = 38
651:             .Width     = 71
652:             .Height    = 15
653:             .AutoSize  = .F.
654:             .BackStyle = 0
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .Caption   = "Empresa :"
658:             .Visible   = .T.
659:         ENDWITH
660:         loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
661:         WITH loc_oCnt.txt_4c_EmpresaEst
662:             .Top       = 12
663:             .Left      = 112
664:             .Width     = 38
665:             .Height    = 23
666:             .FontName  = "Tahoma"
667:             .FontSize  = 8

*-- Linhas 705 a 726:
705:             .FontName  = "Tahoma"
706:             .FontSize  = 8
707:             .Caption   = "Estoque :"
708:             .Visible   = .T.
709:         ENDWITH
710:         loc_oCnt.AddObject("txt_4c_EstoqueEst", "TextBox")
711:         WITH loc_oCnt.txt_4c_EstoqueEst
712:             .Top       = 62
713:             .Left      = 112
714:             .Width     = 100
715:             .Height    = 23
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .Value     = ""
719:             .Visible   = .T.
720:         ENDWITH
721: 
722:         loc_oCnt.AddObject("lbl_4c_ProdutoEst", "Label")
723:         WITH loc_oCnt.lbl_4c_ProdutoEst
724:             .Top       = 90
725:             .Left      = 43
726:             .Width     = 66

*-- Linhas 781 a 825:
781:         ENDWITH
782:     ENDPROC
783: 
784:     *--------------------------------------------------------------------------
785:     PROTECTED PROCEDURE ConfigurarConteudoOpCusto()
786:     *  Sub-controles de cnt_4c_OpCusto (Opcoes de Custo de Produto)
787:     *--------------------------------------------------------------------------
788:         LOCAL loc_oCnt
789:         loc_oCnt = THIS.cnt_4c_OpCusto
790: 
791:         loc_oCnt.AddObject("lbl_4c_TituloCusto", "Label")
792:         WITH loc_oCnt.lbl_4c_TituloCusto
793:             .Top       = 2
794:             .Left      = 193
795:             .AutoSize  = .T.
796:             .BackStyle = 0
797:             .FontBold  = .T.
798:             .FontName  = "Tahoma"
799:             .FontSize  = 8
800:             .ForeColor = RGB(0, 0, 128)
801:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
802:             .Visible   = .T.
803:         ENDWITH
804: 
805:         loc_oCnt.AddObject("lbl_4c_EmpresaCusto", "Label")
806:         WITH loc_oCnt.lbl_4c_EmpresaCusto
807:             .Top       = 14
808:             .Left      = 38
809:             .Width     = 71
810:             .Height    = 15
811:             .AutoSize  = .F.
812:             .BackStyle = 0
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .Caption   = "Empresa :"
816:             .Visible   = .T.
817:         ENDWITH
818:         loc_oCnt.AddObject("txt_4c_EmpresaCusto", "TextBox")
819:         WITH loc_oCnt.txt_4c_EmpresaCusto
820:             .Top       = 11
821:             .Left      = 112
822:             .Width     = 38
823:             .Height    = 23
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8

*-- Linhas 889 a 933:
889:         ENDWITH
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     PROTECTED PROCEDURE ConfigurarConteudoOpCompra()
894:     *  Sub-controles de cnt_4c_OpCompra (Opcoes de Ultima Compra)
895:     *--------------------------------------------------------------------------
896:         LOCAL loc_oCnt
897:         loc_oCnt = THIS.cnt_4c_OpCompra
898: 
899:         loc_oCnt.AddObject("lbl_4c_TituloCompra", "Label")
900:         WITH loc_oCnt.lbl_4c_TituloCompra
901:             .Top       = 2
902:             .Left      = 175
903:             .AutoSize  = .T.
904:             .BackStyle = 0
905:             .FontBold  = .T.
906:             .FontName  = "Tahoma"
907:             .FontSize  = 8
908:             .ForeColor = RGB(0, 0, 128)
909:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
910:             .Visible   = .T.
911:         ENDWITH
912: 
913:         loc_oCnt.AddObject("lbl_4c_EmpresaCompra", "Label")
914:         WITH loc_oCnt.lbl_4c_EmpresaCompra
915:             .Top       = 14
916:             .Left      = 38
917:             .Width     = 71
918:             .Height    = 15
919:             .AutoSize  = .F.
920:             .BackStyle = 0
921:             .FontName  = "Tahoma"
922:             .FontSize  = 8
923:             .Caption   = "Empresa :"
924:             .Visible   = .T.
925:         ENDWITH
926:         loc_oCnt.AddObject("txt_4c_EmpresaCompra", "TextBox")
927:         WITH loc_oCnt.txt_4c_EmpresaCompra
928:             .Top       = 10
929:             .Left      = 112
930:             .Width     = 38
931:             .Height    = 23
932:             .FontName  = "Tahoma"
933:             .FontSize  = 8

*-- Linhas 998 a 1912:
998:     ENDPROC
999: 
1000:     *--------------------------------------------------------------------------
1001:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1002:     *--------------------------------------------------------------------------
1003:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1004:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1005:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkBtnCustoClick")
1006:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")
1007: 
1008:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1009:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")
1010: 
1011:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "KeyPress", THIS, "TxtEmpresaContaKeyPress")
1012:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "DblClick", THIS, "TxtEmpresaContaDblClick")
1013:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "KeyPress", THIS, "TxtMoedasContaKeyPress")
1014:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "DblClick", THIS, "TxtMoedasContaDblClick")
1015: 
1016:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "KeyPress", THIS, "TxtEmpresaEstKeyPress")
1017:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "DblClick", THIS, "TxtEmpresaEstDblClick")
1018:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "KeyPress", THIS, "TxtProdutoEstKeyPress")
1019:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "DblClick", THIS, "TxtProdutoEstDblClick")
1020:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "KeyPress", THIS, "TxtDescsEstKeyPress")
1021:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "DblClick", THIS, "TxtDescsEstDblClick")
1022: 
1023:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "KeyPress", THIS, "TxtEmpresaCustoKeyPress")
1024:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "DblClick", THIS, "TxtEmpresaCustoDblClick")
1025:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "KeyPress", THIS, "TxtProdutoCustoKeyPress")
1026:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "DblClick", THIS, "TxtProdutoCustoDblClick")
1027:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "KeyPress", THIS, "TxtDescsCustoKeyPress")
1028:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "DblClick", THIS, "TxtDescsCustoDblClick")
1029: 
1030:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "KeyPress", THIS, "TxtEmpresaCompraKeyPress")
1031:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "DblClick", THIS, "TxtEmpresaCompraDblClick")
1032:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "KeyPress", THIS, "TxtProdutoCompraKeyPress")
1033:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "DblClick", THIS, "TxtProdutoCompraDblClick")
1034:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "KeyPress", THIS, "TxtDescsCompraKeyPress")
1035:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "DblClick", THIS, "TxtDescsCompraDblClick")
1036:     ENDPROC
1037: 
1038:     *--------------------------------------------------------------------------
1039:     PROTECTED PROCEDURE AtualizarBotaoProcessar()
1040:     *--------------------------------------------------------------------------
1041:         THIS.cmd_4c_Processar.Enabled = (THIS.chk_4c_Conta.Value     = 1 OR ;
1042:                                          THIS.chk_4c_Estoque.Value   = 1 OR ;
1043:                                          THIS.chk_4c_BtnCusto.Value  = 1 OR ;
1044:                                          THIS.chk_4c_BtnCompra.Value = 1)
1045:     ENDPROC
1046: 
1047:     *--------------------------------------------------------------------------
1048:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1049:     *  Reset do estado inicial (equivalente a Page1/LISTA em forms CRUD,
1050:     *  adaptado para o form OPERACIONAL flat): reseta checkboxes de selecao
1051:     *  de modulos, oculta containers de opcoes, esconde label de conclusao
1052:     *  e zera contador de registros processados.
1053:     *--------------------------------------------------------------------------
1054:         *-- Checkboxes de selecao de modulos: desmarcados
1055:         THIS.chk_4c_Conta.Value       = 0
1056:         THIS.chk_4c_Estoque.Value     = 0
1057:         THIS.chk_4c_BtnCusto.Value    = 0
1058:         THIS.chk_4c_BtnCompra.Value   = 0
1059: 
1060:         *-- Containers de opcoes ocultos (togglados pelos checkboxes)
1061:         THIS.cnt_4c_OpConta.Visible   = .F.
1062:         THIS.cnt_4c_OpEstoque.Visible = .F.
1063:         THIS.cnt_4c_OpCusto.Visible   = .F.
1064:         THIS.cnt_4c_OpCompra.Visible  = .F.
1065: 
1066:         *-- Rodape: label de conclusao oculto e contador zerado
1067:         THIS.lbl_4c_LblEnd.Visible    = .F.
1068:         THIS.txt_4c_Registro.Value    = 0
1069: 
1070:         *-- Botao Processar inicia desabilitado (nenhum modulo selecionado)
1071:         THIS.AtualizarBotaoProcessar()
1072:     ENDPROC
1073: 
1074:     *--------------------------------------------------------------------------
1075:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1076:     *  Fachada que agrupa a construcao dos "campos de dados" do form OPERACIONAL.
1077:     *  Este form nao possui PageFrame CRUD; a entrada de parametros pelo usuario
1078:     *  ocorre dentro dos 4 containers flutuantes de opcoes (Conta Corrente,
1079:     *  Estoque, Custo, Ultima Compra), cada um com seus TextBoxes de empresa,
1080:     *  grupo, conta, moeda, produto, descricao e data. Esta rotina cria todos
1081:     *  esses campos de entrada, agrupando as chamadas ConfigurarConteudoOp*.
1082:     *  Equivale, na semantica CRUD, ao "Page2 Dados" onde o usuario preenche
1083:     *  os campos para a operacao.
1084:     *--------------------------------------------------------------------------
1085:         *-- Container OpConta: Empresa, Grupo, Conta, Moeda, Data
1086:         THIS.ConfigurarConteudoOpConta()
1087: 
1088:         *-- Container OpEstoque: Empresa, Grupo, Estoque, Produto, Descricao, Data
1089:         THIS.ConfigurarConteudoOpEstoque()
1090: 
1091:         *-- Container OpCusto: Empresa, Produto, Descricao, Data
1092:         THIS.ConfigurarConteudoOpCusto()
1093: 
1094:         *-- Container OpCompra: Empresa, Produto, Descricao, Data
1095:         THIS.ConfigurarConteudoOpCompra()
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE AlternarPagina(par_nPagina)
1100:     *  Alterna entre modos operacionais (adaptacao do padrao AlternarPagina
1101:     *  dos forms CRUD para o form OPERACIONAL flat):
1102:     *     par_nPagina = 1 -> Modo SELECAO: usuario escolhe modulos e opcoes
1103:     *     par_nPagina = 2 -> Modo PROCESSAMENTO: controles bloqueados
1104:     *--------------------------------------------------------------------------
1105:         DO CASE
1106:         CASE par_nPagina = 2
1107:             *-- Modo PROCESSAMENTO: bloqueia todos os controles
1108:             THIS.chk_4c_Conta.Enabled     = .F.
1109:             THIS.chk_4c_Estoque.Enabled   = .F.
1110:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1111:             THIS.chk_4c_BtnCompra.Enabled = .F.
1112:             THIS.cmd_4c_Processar.Enabled = .F.
1113:             THIS.cmd_4c_Encerrar.Enabled  = .F.
1114:             THIS.lbl_4c_LblEnd.Visible    = .F.
1115:             THIS.txt_4c_Registro.Value    = 0
1116:         OTHERWISE
1117:             *-- Modo SELECAO (par_nPagina = 1 ou omitido)
1118:             THIS.chk_4c_Conta.Enabled     = .T.
1119:             THIS.chk_4c_Estoque.Enabled   = .T.
1120:             THIS.chk_4c_BtnCusto.Enabled  = .T.
1121:             THIS.chk_4c_BtnCompra.Enabled = .T.
1122:             THIS.cmd_4c_Encerrar.Enabled  = .T.
1123:             THIS.AtualizarBotaoProcessar()
1124:         ENDCASE
1125:     ENDPROC
1126: 
1127:     *--------------------------------------------------------------------------
1128:     PROCEDURE ChkContaClick()
1129:     *--------------------------------------------------------------------------
1130:         THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
1131:         THIS.AtualizarBotaoProcessar()
1132:     ENDPROC
1133: 
1134:     *--------------------------------------------------------------------------
1135:     PROCEDURE ChkEstoqueClick()
1136:     *--------------------------------------------------------------------------
1137:         THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
1138:         THIS.AtualizarBotaoProcessar()
1139:     ENDPROC
1140: 
1141:     *--------------------------------------------------------------------------
1142:     PROCEDURE ChkBtnCustoClick()
1143:     *--------------------------------------------------------------------------
1144:         THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
1145:         THIS.AtualizarBotaoProcessar()
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     PROCEDURE ChkBtnCompraClick()
1150:     *--------------------------------------------------------------------------
1151:         THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
1152:         THIS.AtualizarBotaoProcessar()
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     PROCEDURE CmdProcessarClick()
1157:     *--------------------------------------------------------------------------
1158:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
1159:         loc_oBO      = THIS.this_oBusinessObject
1160:         loc_lSucesso = .F.
1161: 
1162:         loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
1163:         loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
1164:         loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
1165:         loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)
1166: 
1167:         IF loc_oBO.this_lProcessarConta
1168:             loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
1169:             loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
1170:             loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
1171:             loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
1172:             loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
1173:         ENDIF
1174:         IF loc_oBO.this_lProcessarEstoque
1175:             loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
1176:             loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
1177:             loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
1178:             loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1179:             loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
1180:             loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
1181:         ENDIF
1182:         IF loc_oBO.this_lProcessarCusto
1183:             loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
1184:             loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1185:             loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
1186:             loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
1187:         ENDIF
1188:         IF loc_oBO.this_lProcessarCompra
1189:             loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
1190:             loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1191:             loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
1192:             loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
1193:         ENDIF
1194: 
1195:         *-- Modo PROCESSAMENTO: bloqueia controles durante execucao
1196:         THIS.AlternarPagina(2)
1197: 
1198:         TRY
1199:             loc_lSucesso = loc_oBO.Processar(THIS)
1200:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1201:             IF loc_lSucesso
1202:                 THIS.lbl_4c_LblEnd.Visible = .T.
1203:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", ;
1204:                         "Rec" + CHR(225) + "lculo de Saldos")
1205:             ELSE
1206:                 MsgAviso("Processamento conclu" + CHR(237) + "do com erros.", ;
1207:                          "Rec" + CHR(225) + "lculo de Saldos")
1208:             ENDIF
1209:         CATCH TO loc_oErro
1210:             MsgErro(loc_oErro.Message, "Erro ao Processar")
1211:         ENDTRY
1212: 
1213:         *-- Volta para modo SELECAO
1214:         THIS.AlternarPagina(1)
1215:     ENDPROC
1216: 
1217:     *--------------------------------------------------------------------------
1218:     PROCEDURE CmdEncerrarClick()
1219:     *--------------------------------------------------------------------------
1220:         THIS.Release()
1221:     ENDPROC
1222: 
1223:     *--------------------------------------------------------------------------
1224:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
1225:     *  Lookup generico de empresa (SigCdEmp -> Cemps, Razas)
1226:     *--------------------------------------------------------------------------
1227:         LOCAL loc_oForm, loc_cValor
1228:         TRY
1229:             loc_cValor = ALLTRIM(par_oTxt.Value)
1230:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1231:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1232:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa")
1233:             IF ISNULL(loc_oForm)
1234:                 RETURN
1235:             ENDIF
1236:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1237:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1238:             ELSE
1239:                 IF !loc_oForm.this_lAchouRegistro
1240:                 loc_oForm.mAddColuna("Cemps", "XXXXXX", "C" + CHR(243) + "digo")
1241:                 loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1242:                 loc_oForm.Show()
1243:                 IF loc_oForm.this_lSelecionou
1244:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1245:                 ENDIF
1246:                 ENDIF
1247:             ENDIF
1248:             IF USED("cursor_4c_BuscaEmp")
1249:                 USE IN cursor_4c_BuscaEmp
1250:             ENDIF
1251:             loc_oForm.Release()
1252:         CATCH TO loc_oErro
1253:             MsgErro(loc_oErro.Message, "Erro")
1254:         ENDTRY
1255:     ENDPROC
1256: 
1257:     *--------------------------------------------------------------------------
1258:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtCod, par_oTxtDesc)
1259:     *  Lookup de produto por codigo (SigCdPro -> CPros, DPros)
1260:     *--------------------------------------------------------------------------
1261:         LOCAL loc_oForm, loc_cValor
1262:         TRY
1263:             loc_cValor = ALLTRIM(par_oTxtCod.Value)
1264:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1265:                 "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
1266:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
1267:             IF ISNULL(loc_oForm)
1268:                 RETURN
1269:             ENDIF
1270:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1271:                 par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1272:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1273:             ELSE
1274:                 IF !loc_oForm.this_lAchouRegistro
1275:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1276:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1277:                 loc_oForm.Show()
1278:                 IF loc_oForm.this_lSelecionou
1279:                     par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1280:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1281:                 ENDIF
1282:                 ENDIF
1283:             ENDIF
1284:             IF USED("cursor_4c_BuscaPro")
1285:                 USE IN cursor_4c_BuscaPro
1286:             ENDIF
1287:             loc_oForm.Release()
1288:         CATCH TO loc_oErro
1289:             MsgErro(loc_oErro.Message, "Erro")
1290:         ENDTRY
1291:     ENDPROC
1292: 
1293:     *--------------------------------------------------------------------------
1294:     PROTECTED PROCEDURE AbrirLookupDescricao(par_oTxtCod, par_oTxtDesc)
1295:     *  Lookup de produto por descricao (SigCdPro -> DPros, CPros)
1296:     *--------------------------------------------------------------------------
1297:         LOCAL loc_oForm, loc_cValor
1298:         TRY
1299:             loc_cValor = ALLTRIM(par_oTxtDesc.Value)
1300:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1301:                 "SigCdPro", "cursor_4c_BuscaDesc", "DPros", loc_cValor, ;
1302:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
1303:             IF ISNULL(loc_oForm)
1304:                 RETURN
1305:             ENDIF
1306:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1307:                 par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
1308:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
1309:             ELSE
1310:                 IF !loc_oForm.this_lAchouRegistro
1311:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1312:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1313:                 loc_oForm.Show()
1314:                 IF loc_oForm.this_lSelecionou
1315:                     par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
1316:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
1317:                 ENDIF
1318:                 ENDIF
1319:             ENDIF
1320:             IF USED("cursor_4c_BuscaDesc")
1321:                 USE IN cursor_4c_BuscaDesc
1322:             ENDIF
1323:             loc_oForm.Release()
1324:         CATCH TO loc_oErro
1325:             MsgErro(loc_oErro.Message, "Erro")
1326:         ENDTRY
1327:     ENDPROC
1328: 
1329:     *--------------------------------------------------------------------------
1330:     PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
1331:     *  Lookup de moeda (SigCdMoe -> Cmoes, Dmoes)
1332:     *--------------------------------------------------------------------------
1333:         LOCAL loc_oForm, loc_cValor
1334:         TRY
1335:             loc_cValor = ALLTRIM(par_oTxt.Value)
1336:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1337:                 "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", loc_cValor, ;
1338:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1339:             IF ISNULL(loc_oForm)
1340:                 RETURN
1341:             ENDIF
1342:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1343:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
1344:             ELSE
1345:                 IF !loc_oForm.this_lAchouRegistro
1346:                 loc_oForm.mAddColuna("Cmoes", "", "Moe")
1347:                 loc_oForm.mAddColuna("Dmoes", "", "Nome")
1348:                 loc_oForm.Show()
1349:                 IF loc_oForm.this_lSelecionou
1350:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
1351:                 ENDIF
1352:                 ENDIF
1353:             ENDIF
1354:             IF USED("cursor_4c_BuscaMoe")
1355:                 USE IN cursor_4c_BuscaMoe
1356:             ENDIF
1357:             loc_oForm.Release()
1358:         CATCH TO loc_oErro
1359:             MsgErro(loc_oErro.Message, "Erro")
1360:         ENDTRY
1361:     ENDPROC
1362: 
1363:     *--- Handlers: cnt_4c_OpConta ---
1364:     PROCEDURE TxtEmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1365:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1366:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
1367:         ENDIF
1368:     ENDPROC
1369: 
1370:     PROCEDURE TxtEmpresaContaDblClick()
1371:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
1372:     ENDPROC
1373: 
1374:     PROCEDURE TxtMoedasContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1375:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1376:             THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     PROCEDURE TxtMoedasContaDblClick()
1381:         THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
1382:     ENDPROC
1383: 
1384:     *--- Handlers: cnt_4c_OpEstoque ---
1385:     PROCEDURE TxtEmpresaEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1386:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1387:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
1388:         ENDIF
1389:     ENDPROC
1390: 
1391:     PROCEDURE TxtEmpresaEstDblClick()
1392:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
1393:     ENDPROC
1394: 
1395:     PROCEDURE TxtProdutoEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1396:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1397:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1398:                                     THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1399:         ENDIF
1400:     ENDPROC
1401: 
1402:     PROCEDURE TxtProdutoEstDblClick()
1403:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1404:                                 THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1405:     ENDPROC
1406: 
1407:     PROCEDURE TxtDescsEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1408:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1409:             IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1410:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1411:                                           THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1412:             ENDIF
1413:         ENDIF
1414:     ENDPROC
1415: 
1416:     PROCEDURE TxtDescsEstDblClick()
1417:         IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1418:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1419:                                       THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1420:         ENDIF
1421:     ENDPROC
1422: 
1423:     *--- Handlers: cnt_4c_OpCusto ---
1424:     PROCEDURE TxtEmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1425:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1426:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
1427:         ENDIF
1428:     ENDPROC
1429: 
1430:     PROCEDURE TxtEmpresaCustoDblClick()
1431:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
1432:     ENDPROC
1433: 
1434:     PROCEDURE TxtProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1435:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1436:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1437:                                     THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1438:         ENDIF
1439:     ENDPROC
1440: 
1441:     PROCEDURE TxtProdutoCustoDblClick()
1442:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1443:                                 THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1444:     ENDPROC
1445: 
1446:     PROCEDURE TxtDescsCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1447:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1448:             IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1449:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1450:                                           THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1451:             ENDIF
1452:         ENDIF
1453:     ENDPROC
1454: 
1455:     PROCEDURE TxtDescsCustoDblClick()
1456:         IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1457:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1458:                                       THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1459:         ENDIF
1460:     ENDPROC
1461: 
1462:     *--- Handlers: cnt_4c_OpCompra ---
1463:     PROCEDURE TxtEmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1464:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1465:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
1466:         ENDIF
1467:     ENDPROC
1468: 
1469:     PROCEDURE TxtEmpresaCompraDblClick()
1470:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
1471:     ENDPROC
1472: 
1473:     PROCEDURE TxtProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1474:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1475:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1476:                                     THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1477:         ENDIF
1478:     ENDPROC
1479: 
1480:     PROCEDURE TxtProdutoCompraDblClick()
1481:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1482:                                 THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1483:     ENDPROC
1484: 
1485:     PROCEDURE TxtDescsCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1486:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1487:             IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1488:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1489:                                           THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1490:             ENDIF
1491:         ENDIF
1492:     ENDPROC
1493: 
1494:     PROCEDURE TxtDescsCompraDblClick()
1495:         IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1496:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1497:                                       THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1498:         ENDIF
1499:     ENDPROC
1500: 
1501:     *--------------------------------------------------------------------------
1502:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1503:     *  Torna controles visiveis recursivamente.
1504:     *  EXCECOES (permanecem ocultos apos InicializarForm):
1505:     *    - cnt_4c_OpConta/OpEstoque/OpCusto/OpCompra: toggled pelos checkboxes
1506:     *    - lbl_4c_LblEnd: exibido apenas ao concluir processamento
1507:     *--------------------------------------------------------------------------
1508:         LOCAL loc_i, loc_p, loc_oControl
1509:         FOR loc_i = 1 TO par_oContainer.ControlCount
1510:             loc_oControl = par_oContainer.Controls(loc_i)
1511:             IF VARTYPE(loc_oControl) != "O"
1512:                 LOOP
1513:             ENDIF
1514: 
1515:             *-- Containers gerenciados: nao forcar .Visible via este metodo
1516:             *  - CNT_4C_CABECALHO: visivel mas recursao ja garante filhos visiveis
1517:             *  - CNT_4C_OPCONTA/OPESTOQUE/OPCUSTO/OPCOMPRA: toggled pelos checkboxes (inicia .F.)
1518:             *  - LBL_4C_LBLEND: exibido apenas ao concluir processamento (inicia .F.)
1519:             IF INLIST(UPPER(loc_oControl.Name), ;
1520:                 "CNT_4C_CABECALHO", ;
1521:                 "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1522:                 "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA", ;
1523:                 "LBL_4C_LBLEND")
1524:                 *-- Recursao nos filhos para que fiquem prontos quando container tornar visivel
1525:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1526:                     THIS.TornarControlesVisiveis(loc_oControl)
1527:                 ENDIF
1528:                 LOOP
1529:             ENDIF
1530: 
1531:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1532:                 loc_oControl.Visible = .T.
1533:             ENDIF
1534: 
1535:             *-- Recursao para PageFrame (nao usado neste form, mas por padrao)
1536:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1537:                 FOR loc_p = 1 TO loc_oControl.PageCount
1538:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
1539:                 ENDFOR
1540:             ENDIF
1541: 
1542:             *-- Recursao para containers com filhos
1543:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1544:                 THIS.TornarControlesVisiveis(loc_oControl)
1545:             ENDIF
1546:         ENDFOR
1547:     ENDPROC
1548: 
1549:     *--------------------------------------------------------------------------
1550:     * BtnIncluirClick - Inicia um novo ciclo de recalculo de saldos
1551:     * Form OPERACIONAL: mapeado para o disparo do processamento (equivalente
1552:     * a "incluir" uma nova execucao). Delega para CmdProcessarClick.
1553:     *--------------------------------------------------------------------------
1554:     PROCEDURE BtnIncluirClick()
1555:         LOCAL loc_oErro
1556:         TRY
1557:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1558:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1559:                 MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de processamento (Conta, Estoque, Custo ou " + CHR(250) + "lt. Compra).", ;
1560:                          "Rec" + CHR(225) + "lculo de Saldos")
1561:                 RETURN
1562:             ENDIF
1563:             THIS.lbl_4c_LblEnd.Visible = .F.
1564:             THIS.txt_4c_Registro.Value = 0
1565:             THIS.CmdProcessarClick()
1566:         CATCH TO loc_oErro
1567:             MsgErro(loc_oErro.Message, "Erro ao iniciar processamento")
1568:         ENDTRY
1569:     ENDPROC
1570: 
1571:     *--------------------------------------------------------------------------
1572:     * BtnAlterarClick - Reexecuta o processamento com as opcoes atuais
1573:     * Form OPERACIONAL: equivalente a "alterar" parametros e reprocessar.
1574:     * Requer que pelo menos uma opcao esteja marcada.
1575:     *--------------------------------------------------------------------------
1576:     PROCEDURE BtnAlterarClick()
1577:         LOCAL loc_oErro
1578:         TRY
1579:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1580:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1581:                 MsgAviso("Nenhuma op" + CHR(231) + CHR(227) + "o marcada para reprocessar.", ;
1582:                          "Rec" + CHR(225) + "lculo de Saldos")
1583:                 RETURN
1584:             ENDIF
1585:             IF MsgConfirma("Reexecutar o processamento com as op" + CHR(231) + CHR(245) + "es atuais?", ;
1586:                            "Rec" + CHR(225) + "lculo de Saldos")
1587:                 THIS.lbl_4c_LblEnd.Visible = .F.
1588:                 THIS.txt_4c_Registro.Value = 0
1589:                 THIS.CmdProcessarClick()
1590:             ENDIF
1591:         CATCH TO loc_oErro
1592:             MsgErro(loc_oErro.Message, "Erro ao reexecutar processamento")
1593:         ENDTRY
1594:     ENDPROC
1595: 
1596:     *--------------------------------------------------------------------------
1597:     * BtnVisualizarClick - Exibe o resumo do ultimo processamento
1598:     * Form OPERACIONAL: mostra os totais processados sem reexecutar.
1599:     *--------------------------------------------------------------------------
1600:     PROCEDURE BtnVisualizarClick()
1601:         LOCAL loc_oBO, loc_nRegistros, loc_cMsg, loc_oErro
1602:         TRY
1603:             loc_oBO = THIS.this_oBusinessObject
1604:             loc_nRegistros = 0
1605:             IF VARTYPE(loc_oBO) = "O" AND !ISNULL(loc_oBO)
1606:                 loc_nRegistros = loc_oBO.this_nRegistros
1607:             ENDIF
1608:             THIS.txt_4c_Registro.Value = loc_nRegistros
1609: 
1610:             loc_cMsg = "Resumo do " + CHR(250) + "ltimo processamento:" + CHR(13) + CHR(13) + ;
1611:                        "Registros processados: " + TRANSFORM(loc_nRegistros) + CHR(13) + ;
1612:                        "Conta Corrente......: " + IIF(THIS.chk_4c_Conta.Value    = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1613:                        "Estoque.............: " + IIF(THIS.chk_4c_Estoque.Value  = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1614:                        "Custo...............: " + IIF(THIS.chk_4c_BtnCusto.Value = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1615:                        CHR(250) + "lt. Compra..........: " + IIF(THIS.chk_4c_BtnCompra.Value = 1, "SIM", "N" + CHR(227) + "O")
1616: 
1617:             THIS.lbl_4c_LblEnd.Visible = (loc_nRegistros > 0)
1618:             MsgInfo(loc_cMsg, "Rec" + CHR(225) + "lculo de Saldos")
1619:         CATCH TO loc_oErro
1620:             MsgErro(loc_oErro.Message, "Erro ao visualizar resumo")
1621:         ENDTRY
1622:     ENDPROC
1623: 
1624:     *--------------------------------------------------------------------------
1625:     * BtnExcluirClick - Cancela / reinicia a selecao de opcoes
1626:     * Form OPERACIONAL: nao ha exclusao de dados; a acao reseta os
1627:     * checkboxes, esconde os paineis flutuantes e zera o contador.
1628:     *--------------------------------------------------------------------------
1629:     PROCEDURE BtnExcluirClick()
1630:         LOCAL loc_oErro
1631:         TRY
1632:             IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + "es selecionadas?", ;
1633:                             "Rec" + CHR(225) + "lculo de Saldos")
1634:                 RETURN
1635:             ENDIF
1636: 
1637:             THIS.chk_4c_Conta.Value     = 0
1638:             THIS.chk_4c_Estoque.Value   = 0
1639:             THIS.chk_4c_BtnCusto.Value  = 0
1640:             THIS.chk_4c_BtnCompra.Value = 0
1641: 
1642:             THIS.cnt_4c_OpConta.Visible   = .F.
1643:             THIS.cnt_4c_OpEstoque.Visible = .F.
1644:             THIS.cnt_4c_OpCusto.Visible   = .F.
1645:             THIS.cnt_4c_OpCompra.Visible  = .F.
1646: 
1647:             THIS.txt_4c_Registro.Value = 0
1648:             THIS.lbl_4c_LblEnd.Visible = .F.
1649: 
1650:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1651:                 THIS.this_oBusinessObject.this_nRegistros = 0
1652:             ENDIF
1653: 
1654:             THIS.AtualizarBotaoProcessar()
1655:             THIS.Refresh()
1656:         CATCH TO loc_oErro
1657:             MsgErro(loc_oErro.Message, "Erro ao limpar op" + CHR(231) + CHR(245) + "es")
1658:         ENDTRY
1659:     ENDPROC
1660: 
1661:     *--------------------------------------------------------------------------
1662:     PROCEDURE FormParaBO()
1663:     *  Transfere os valores dos campos visuais para as propriedades do BO.
1664:     *  Para o form OPERACIONAL: copia flags dos checkboxes e parametros
1665:     *  de cada secao ativa para as propriedades this_* do BO.
1666:     *--------------------------------------------------------------------------
1667:         LOCAL loc_oBO, loc_oErro
1668:         TRY
1669:             loc_oBO = THIS.this_oBusinessObject
1670:             IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
1671:                 RETURN
1672:             ENDIF
1673: 
1674:             loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
1675:             loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
1676:             loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
1677:             loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)
1678: 
1679:             IF loc_oBO.this_lProcessarConta
1680:                 loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
1681:                 loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
1682:                 loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
1683:                 loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
1684:                 loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
1685:             ENDIF
1686: 
1687:             IF loc_oBO.this_lProcessarEstoque
1688:                 loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
1689:                 loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
1690:                 loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
1691:                 loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1692:                 loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
1693:                 loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
1694:             ENDIF
1695: 
1696:             IF loc_oBO.this_lProcessarCusto
1697:                 loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
1698:                 loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1699:                 loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
1700:                 loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
1701:             ENDIF
1702: 
1703:             IF loc_oBO.this_lProcessarCompra
1704:                 loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
1705:                 loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1706:                 loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
1707:                 loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
1708:             ENDIF
1709:         CATCH TO loc_oErro
1710:             MsgErro(loc_oErro.Message, "Erro")
1711:         ENDTRY
1712:     ENDPROC
1713: 
1714:     *--------------------------------------------------------------------------
1715:     PROCEDURE BOParaForm()
1716:     *  Transfere resultados do BO de volta para os campos visuais.
1717:     *  Para o form OPERACIONAL: exibe o contador de registros processados
1718:     *  e o label de conclusao quando houver resultado.
1719:     *--------------------------------------------------------------------------
1720:         LOCAL loc_oBO, loc_oErro
1721:         TRY
1722:             loc_oBO = THIS.this_oBusinessObject
1723:             IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
1724:                 RETURN
1725:             ENDIF
1726:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1727:             THIS.lbl_4c_LblEnd.Visible = (loc_oBO.this_nRegistros > 0)
1728:         CATCH TO loc_oErro
1729:             MsgErro(loc_oErro.Message, "Erro")
1730:         ENDTRY
1731:     ENDPROC
1732: 
1733:     *--------------------------------------------------------------------------
1734:     PROCEDURE LimparCampos()
1735:     *  Limpa todos os campos de entrada nos 4 containers de opcoes e
1736:     *  redefine flags/checkboxes para o estado inicial (sem selecao).
1737:     *--------------------------------------------------------------------------
1738:         LOCAL loc_oErro
1739:         TRY
1740:             *-- Checkboxes
1741:             THIS.chk_4c_Conta.Value     = 0
1742:             THIS.chk_4c_Estoque.Value   = 0
1743:             THIS.chk_4c_BtnCusto.Value  = 0
1744:             THIS.chk_4c_BtnCompra.Value = 0
1745: 
1746:             *-- Campos de Conta Corrente
1747:             THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value = ""
1748:             THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value  = ""
1749:             THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value  = ""
1750:             THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value  = ""
1751:             THIS.cnt_4c_OpConta.txt_4c_DataConta.Value    = {}
1752: 
1753:             *-- Campos de Estoque
1754:             THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value = ""
1755:             THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value  = ""
1756:             THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value = ""
1757:             THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value = ""
1758:             THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value   = ""
1759:             THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value    = {}
1760: 
1761:             *-- Campos de Custo
1762:             THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value = ""
1763:             THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value = ""
1764:             THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value   = ""
1765:             THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value    = {}
1766: 
1767:             *-- Campos de Ultima Compra
1768:             THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value = ""
1769:             THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value = ""
1770:             THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value   = ""
1771:             THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value    = {}
1772: 
1773:             *-- Rodape
1774:             THIS.txt_4c_Registro.Value = 0
1775:             THIS.lbl_4c_LblEnd.Visible = .F.
1776: 
1777:             *-- Oculta containers flutuantes
1778:             THIS.cnt_4c_OpConta.Visible   = .F.
1779:             THIS.cnt_4c_OpEstoque.Visible = .F.
1780:             THIS.cnt_4c_OpCusto.Visible   = .F.
1781:             THIS.cnt_4c_OpCompra.Visible  = .F.
1782: 
1783:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1784:                 THIS.this_oBusinessObject.this_nRegistros = 0
1785:             ENDIF
1786:         CATCH TO loc_oErro
1787:             MsgErro(loc_oErro.Message, "Erro")
1788:         ENDTRY
1789:     ENDPROC
1790: 
1791:     *--------------------------------------------------------------------------
1792:     PROCEDURE HabilitarCampos(par_lHabilitar)
1793:     *  Habilita ou desabilita todos os controles de entrada do form.
1794:     *  Chamado por AlternarPagina para bloquear durante o processamento.
1795:     *--------------------------------------------------------------------------
1796:         LOCAL loc_oErro
1797:         TRY
1798:             THIS.chk_4c_Conta.Enabled     = par_lHabilitar
1799:             THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
1800:             THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
1801:             THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
1802:             THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
1803: 
1804:             IF par_lHabilitar
1805:                 *-- Ao habilitar, Processar depende da selecao dos checkboxes
1806:                 THIS.AtualizarBotaoProcessar()
1807:             ELSE
1808:                 THIS.cmd_4c_Processar.Enabled = .F.
1809:             ENDIF
1810:         CATCH TO loc_oErro
1811:             MsgErro(loc_oErro.Message, "Erro")
1812:         ENDTRY
1813:     ENDPROC
1814: 
1815:     *--------------------------------------------------------------------------
1816:     PROCEDURE AjustarBotoesPorModo()
1817:     *  Atualiza o estado do botao Processar conforme selecao atual.
1818:     *  Alias de AtualizarBotaoProcessar() para compatibilidade com
1819:     *  o padrao do pipeline de migracao.
1820:     *--------------------------------------------------------------------------
1821:         THIS.AtualizarBotaoProcessar()
1822:     ENDPROC
1823: 
1824:     *--------------------------------------------------------------------------
1825:     PROCEDURE CarregarLista()
1826:     *  Reinicia o form para o estado inicial: desmarca checkboxes, oculta
1827:     *  containers de opcoes e zera o contador. Equivalente ao "recarregar
1828:     *  a lista" nos forms CRUD, adaptado para o form OPERACIONAL flat.
1829:     *--------------------------------------------------------------------------
1830:         LOCAL loc_oErro
1831:         TRY
1832:             THIS.ConfigurarPaginaLista()
1833:             THIS.Refresh()
1834:         CATCH TO loc_oErro
1835:             MsgErro(loc_oErro.Message, "Erro")
1836:         ENDTRY
1837:     ENDPROC
1838: 
1839:     *--------------------------------------------------------------------------
1840:     PROCEDURE BtnBuscarClick()
1841:     *  Para o form OPERACIONAL: exibe o resumo do estado atual (opcoes
1842:     *  selecionadas e registros do ultimo processamento). Equivalente ao
1843:     *  "Buscar / Visualizar" nos forms CRUD.
1844:     *--------------------------------------------------------------------------
1845:         THIS.BtnVisualizarClick()
1846:     ENDPROC
1847: 
1848:     *--------------------------------------------------------------------------
1849:     PROCEDURE BtnEncerrarClick()
1850:     *  Fecha o form OPERACIONAL. Alias de CmdEncerrarClick() para
1851:     *  compatibilidade com o padrao do pipeline de migracao.
1852:     *--------------------------------------------------------------------------
1853:         THIS.CmdEncerrarClick()
1854:     ENDPROC
1855: 
1856:     *--------------------------------------------------------------------------
1857:     PROCEDURE BtnSalvarClick()
1858:     *  Para o form OPERACIONAL: dispara o processamento de recalculo.
1859:     *  Equivale ao "Salvar" nos forms CRUD, adaptado para este contexto.
1860:     *  Valida selecao antes de processar.
1861:     *--------------------------------------------------------------------------
1862:         LOCAL loc_oErro
1863:         TRY
1864:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1865:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1866:                 MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + ;
1867:                          "o de processamento.", "Rec" + CHR(225) + "lculo de Saldos")
1868:                 RETURN
1869:             ENDIF
1870:             THIS.FormParaBO()
1871:             THIS.lbl_4c_LblEnd.Visible = .F.
1872:             THIS.txt_4c_Registro.Value = 0
1873:             THIS.CmdProcessarClick()
1874:         CATCH TO loc_oErro
1875:             MsgErro(loc_oErro.Message, "Erro ao processar")
1876:         ENDTRY
1877:     ENDPROC
1878: 
1879:     *--------------------------------------------------------------------------
1880:     PROCEDURE BtnCancelarClick()
1881:     *  Para o form OPERACIONAL: limpa todas as selecoes e reinicia o form
1882:     *  para o estado inicial. Equivale ao "Cancelar" nos forms CRUD.
1883:     *--------------------------------------------------------------------------
1884:         LOCAL loc_oErro
1885:         TRY
1886:             IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + ;
1887:                             "es e reiniciar?", "Rec" + CHR(225) + "lculo de Saldos")
1888:                 RETURN
1889:             ENDIF
1890:             THIS.LimparCampos()
1891:             THIS.AjustarBotoesPorModo()
1892:             THIS.Refresh()
1893:         CATCH TO loc_oErro
1894:             MsgErro(loc_oErro.Message, "Erro ao cancelar")
1895:         ENDTRY
1896:     ENDPROC
1897: 
1898:     *--------------------------------------------------------------------------
1899:     PROCEDURE Destroy()
1900:     *--------------------------------------------------------------------------
1901:         LOCAL loc_oErro
1902:         TRY
1903:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1904:                 THIS.this_oBusinessObject = .NULL.
1905:             ENDIF
1906:         CATCH TO loc_oErro
1907:             MsgErro(loc_oErro.Message, "Erro")
1908:         ENDTRY
1909:         DODEFAULT()
1910:     ENDPROC
1911: 
1912: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Rec?lculo de Saldos
* Herda de: BusinessBase
* Entidade: SigPrCcc
* Tabela principal: SigOpClU (ultima compra por cliente/produto)
*==============================================================================
DEFINE CLASS SigPrCccBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *-- Filtros secao Conta Corrente (OpConta)
    this_cEmpConta     = ""
    this_cGruposConta  = ""
    this_cContasConta  = ""
    this_cMoedasConta  = ""
    this_dDataConta    = {}

    *-- Filtros secao Estoque (OpEstoque)
    this_cEmpEstoque       = ""
    this_cGruposEstoque    = ""
    this_cEstoqueEstoque   = ""
    this_cProdutoEstoque   = ""
    this_cDescricaoEstoque = ""
    this_dDataEstoque      = {}

    *-- Filtros secao Custo de Produto (OpCusto)
    this_cEmpCusto       = ""
    this_cProdutoCusto   = ""
    this_cDescricaoCusto = ""
    this_dDataCusto      = {}

    *-- Filtros secao Ultima Compra (OpCompra)
    this_cEmpCompra       = ""
    this_cProdutoCompra   = ""
    this_cDescricaoCompra = ""
    this_dDataCompra      = {}

    *-- Flags de processamento (estado dos checkboxes)
    this_lProcessarConta   = .F.
    this_lProcessarEstoque = .F.
    this_lProcessarCusto   = .F.
    this_lProcessarCompra  = .F.

    *-- Contador de registros (exibido no txt_4c_Registro)
    this_nRegistros = 0

    *-- Conexao legada para funcoes de recalculo do Framework
    this_oDataMgr = .NULL.

    *-- Campos da tabela SigOpClU (para CRUD direto)
    this_cCidchaves   = ""
    this_cCpros       = ""
    this_dDatas       = {}
    this_cDopes       = ""
    this_cEmpdopnums  = ""
    this_cEmps        = ""
    this_cIclis       = ""
    this_cMoedas      = ""
    this_nNumes       = 0
    this_nValors      = 0
    this_nQtds        = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *  Retorna a chave primaria (CidChaves) do registro atual.
    *  Se estiver vazia (novo registro), gera nova via SYS(2015)+SYS(2015).
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidchaves)
            RETURN SYS(2015) + SYS(2015)
        ENDIF
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
    *  Limpa propriedades da tabela SigOpClU (novo registro)
    *--------------------------------------------------------------------------
        THIS.this_cCidchaves   = ""
        THIS.this_cCpros       = ""
        THIS.this_dDatas       = {}
        THIS.this_cDopes       = ""
        THIS.this_cEmpdopnums  = ""
        THIS.this_cEmps        = ""
        THIS.this_cIclis       = ""
        THIS.this_cMoedas      = ""
        THIS.this_nNumes       = 0
        THIS.this_nValors      = 0
        THIS.this_nQtds        = 0
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Carrega dados de SigOpClU do cursor para as propriedades this_*.
    *  Segue padrao canonico: SELECT (alias) + acesso direto aos campos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCpros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cDopes      = TratarNulo(dopes,      "C")
            THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cIclis      = TratarNulo(iclis,      "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_nNumes      = TratarNulo(numes,      "N")
            THIS.this_nValors     = TratarNulo(valors,     "N")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *  Valida campos obrigatorios de SigOpClU antes de INSERT/UPDATE.
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDopes)
            THIS.this_cMensagemErro = "Documento " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nNumes <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpdopnums)
            THIS.this_cEmpdopnums = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *  INSERT INTO SigOpClU. Gera nova CidChaves se vazia.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                       "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                       " emps, iclis, moedas, numes, valors, qtds) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)        + ")"

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *  UPDATE SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClU SET " + ;
                       "cpros = "      + EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       "datas = "      + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "dopes = "      + EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       "empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       "emps = "       + EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       "iclis = "      + EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       "moedas = "     + EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       "valors = "     + FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       "qtds = "       + FormatarNumeroSQL(THIS.this_nQtds)        + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *  DELETE FROM SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigOpClU WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexao()
    *  Cria conexao legada para funcoes de recalculo do Framework (fSqlConector)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oDataMgr) != "O" OR ISNULL(THIS.this_oDataMgr)
                THIS.this_oDataMgr = CREATEOBJECT('fSqlConector', 'RECSALDO', .T.)
                IF THIS.this_oDataMgr.pnIdConn > 0
                    THIS.this_oDataMgr.AddCursor('SigOpClU', 'CidChaves', 'CrSigOpClU')
                    THIS.this_oDataMgr.Cursorquery('SigCdPam', 'CrSigCdPam', .F., .F., ;
                        'GrupoRecs,GrupoPags,ContaRecs,ContaPags,MoeCentral')
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + ;
                            "o com o servidor de banco de dados.", "Erro de Conex" + CHR(227) + "o")
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oForm)
    *  Metodo principal: executa todos os recalculos selecionados via flags
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarConexao()
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.

                IF THIS.this_lProcessarConta
                    IF !THIS.ProcessarContaCorrente(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarEstoque
                    IF !THIS.ProcessarEstoque(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCusto
                    IF !THIS.ProcessarCusto(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCompra
                    IF !THIS.ProcessarUltimaCompra(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarContaCorrente(par_oForm)
    *  Recalcula saldos de Conta Corrente em SigMvCcr via fRecalculaS
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_dData, loc_cGcm, loc_llConc, loc_cWhere, loc_cWherC
        LOCAL loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta, loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEmp   = PADR(THIS.this_cEmpConta,    3)
            loc_cGrupo = PADR(THIS.this_cGruposConta, 10)
            loc_cConta = PADR(THIS.this_cContasConta, 10)
            loc_cMoeda = PADR(THIS.this_cMoedasConta,  3)
            loc_dData  = THIS.this_dDataConta
            loc_llConc = .T.
            loc_pData  = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)
            loc_cGcm   = IIF(!EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cConta) .AND. !EMPTY(loc_cMoeda), ;
                             loc_cGrupo + loc_cConta + loc_cMoeda, SPACE(23))

            loc_cWhere = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '" + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '" + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '" + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"   + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And Datas >= "  + FormatarDataSQL(loc_dData) + " ", " ")

            loc_cWherC = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '"    + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '"    + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '"    + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"      + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And DataConcs >= " + FormatarDataSQL(loc_dData) + " ", " ") + ;
                "And Concs = 1 "

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
            CREATE CURSOR TmpConta (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))
            INDEX ON CidChaves TAG CidChaves

            DO WHILE .T.
                IF !EMPTY(loc_cGcm)
                    IF EMPTY(loc_cEmp)
                        loc_cQuery = "Select Cemps From SigCdEmp"
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEmps') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TmpEmps)", "Erro")
                            EXIT
                        ENDIF
                        SELECT TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                                VALUES (TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                        loc_cMoeda, SYS(2015)+SYS(2015))
                            SELECT TmpEmps
                        ENDSCAN
                        IF USED("TmpEmps")
                            USE IN TmpEmps
                        ENDIF
                    ELSE
                        INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                            VALUES (loc_cEmp, loc_cGrupo, loc_cConta, ;
                                    loc_cMoeda, SYS(2015)+SYS(2015))
                    ENDIF
                ELSE
                    loc_cQuery = "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWhere + ;
                                 " Union all " + ;
                                 "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWherC
                    IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpConta') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TmpConta)", "Erro")
                        EXIT
                    ENDIF
                    SELECT TmpConta
                    REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                    INDEX ON CidChaves TAG Cidchaves
                ENDIF

                *-- Processa os registros de TmpConta
                DO WHILE .T.
                    SELECT * FROM TmpConta INTO CURSOR Selecao ORDER BY Emps, Grupos, Contas, Moedas
                    SELECT Selecao
                    IF RECCOUNT() = 0
                        EXIT
                    ENDIF

                    loc_nReg      = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo de Conta Corrente', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)
                        loc_oProgConta.SubTitulo.Caption = ALLTRIM(Selecao.Grupos) + " : " + ;
                            ALLTRIM(Selecao.Contas) + "-" + ALLTRIM(Selecao.Moedas)

                        =fRecalculaS(Selecao.Grupos, Selecao.Contas, loc_pData, Selecao.Moedas)
                        loc_lOk = fRecalculaS(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpConta
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque(par_oForm)
    *  Recalcula saldos de Estoque em SigMvHst via fRecalculaP
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEstoque, loc_cEmpresa, loc_cGrupo, loc_cProduto
        LOCAL loc_dData, loc_cWhere, loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni, loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEmpEstoque,     3)
            loc_cGrupo   = PADR(THIS.this_cGruposEstoque,  10)
            loc_cProduto = PADR(THIS.this_cProdutoEstoque, 14)
            loc_dData    = THIS.this_dDataEstoque
            loc_pData    = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) .AND. !EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = '" + loc_cEmpresa + loc_cGrupo + loc_cEstoque + "' "
                CASE EMPTY(loc_cEmpresa) .AND. EMPTY(loc_cGrupo) .AND. EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque),  SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque),  REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere  = "EmpGruEsts Between '" + ;
                                  loc_cEmpIni + loc_cGruIni + loc_cEstIni + "' And '" + ;
                                  loc_cEmpFin + loc_cGruFin + loc_cEstFin + "' "
            ENDCASE

            loc_cWhere = IIF(!EMPTY(loc_cProduto), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " CPros = '" + ALLTRIM(loc_cProduto) + "' ", loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_dData), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " Datas >= " + FormatarDataSQL(loc_dData), loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_cWhere), "Where " + loc_cWhere, "")

            loc_cQuery = "Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                         "Space(20) as CidChaves From SigMvHst " + loc_cWhere

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEst') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEst)", "Erro")
                    EXIT
                ENDIF

                SELECT TmpEst
                REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    SELECT * FROM TmpEst INTO CURSOR Selecao
                    IF RECCOUNT('Selecao') = 0
                        EXIT
                    ENDIF

                    SELECT Selecao
                    loc_nReg       = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo do Estoque', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)

                        =fRecalculaP(Selecao.Emps, Selecao.Grupos, Selecao.Estos, ;
                                     Selecao.CPros, loc_pData, Selecao.CodCors, ;
                                     Selecao.CodTams, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaP(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpEst
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T., .T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarCusto(par_oForm)
    *  Recalcula custo de produtos via fRecalculaC
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cQuery
        LOCAL loc_llEmp, loc_nReg, loc_lOk, loc_oCusto, loc_lParou

        loc_lSucesso = .F.
        TRY
            loc_cEmp = PADR(THIS.this_cEmpCusto,    3)
            loc_cPro = PADR(THIS.this_cProdutoCusto, 14)
            loc_dDat = THIS.this_dDataCusto

            loc_cQuery = "Select Cemps From SigCdEmp " + ;
                         "Where Not Cemps = Space(3)" + ;
                         IIF(EMPTY(loc_cEmp), "", " And Cemps = '" + ALLTRIM(loc_cEmp) + "'")

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalEmp') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalEmp)", "Erro")
                    EXIT
                ENDIF

                loc_cQuery = "Select Calccustos From SigCdPac"
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalParac') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalParac)", "Erro")
                    EXIT
                ENDIF
                loc_llEmp = (LocalParac.CalcCustos <> 1)

                loc_cQuery = "Select Cpros From SigCdPro " + ;
                             "Where Not Cpros = Space(14)" + ;
                             IIF(EMPTY(loc_cPro), "", " And Cpros = '" + ALLTRIM(loc_cPro) + "'")
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro2') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalPro2)", "Erro")
                    EXIT
                ENDIF

                loc_lParou = .F.
                SELECT LocalEmp
                SCAN
                    IF loc_llEmp
                        loc_cQuery = "Select Distinct Cpros From SigMvEst " + ;
                                     "Where Emps = " + EscaparSQL(ALLTRIM(LocalEmp.Cemps)) + " " + ;
                                     "And Not Cpros = Space(14)" + ;
                                     IIF(EMPTY(loc_cPro), "", " And Cpros = " + EscaparSQL(ALLTRIM(loc_cPro)) + " ")
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (LocalPro)", "Erro")
                            loc_lParou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM LocalPro2 INTO CURSOR LocalPro READWRITE
                    ENDIF

                    loc_nReg  = RECCOUNT('LocalPro')
                    loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                        'Preparando Arquivo de Rec' + CHR(225) + 'lculo do Custo de Produtos', ;
                        loc_nReg)
                    loc_oCusto.Titulo.FontBold = .T.
                    loc_oCusto.Show

                    SELECT LocalPro
                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oCusto.SubTitulo.Caption = "Empresa : " + LocalEmp.Cemps + ;
                                                        " - Produto : " + LocalPro.CPros
                        loc_oCusto.Update(.T.)

                        =fRecalculaC(LocalEmp.Cemps, LocalPro.CPros, loc_dDat, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaC(.T., .T., .F., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                    ENDSCAN

                    loc_oCusto.Complete(.T., .T.)

                    IF USED("LocalPro")
                        USE IN LocalPro
                    ENDIF
                    IF !loc_llEmp
                        EXIT
                    ENDIF
                ENDSCAN

                IF USED("LocalEmp")
                    USE IN LocalEmp
                ENDIF
                IF USED("LocalPro2")
                    USE IN LocalPro2
                ENDIF
                IF USED("LocalParac")
                    USE IN LocalParac
                ENDIF

                IF !loc_lParou
                    loc_lSucesso = .T.
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarUltimaCompra(par_oForm)
    *  Reconstroi SigOpClU e atualiza SigCdCli/SigCdPro com ultima compra
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cSql
        LOCAL loc_nReg, loc_oCusto, loc_cConta, loc_lOk
        LOCAL loc_lnCotaCentral, loc_lnCotaOperac, loc_lnValorCentral, loc_lnValor
        LOCAL loc_cMoeda, loc_ldData, loc_cUpDate

        loc_lSucesso = .F.
        TRY
            *-- Limpa cursor principal de ultima compra
            IF USED("CrSigOpClU")
                SELECT CrSigOpClU
                ZAP
            ENDIF

            loc_cEmp = PADR(THIS.this_cEmpCompra,    3)
            loc_cPro = PADR(THIS.this_cProdutoCompra, 14)
            loc_dDat = THIS.this_dDataCompra

            DO WHILE .T.
                *-- Seleciona movimentos de cabecalho com operacoes de compra
                loc_cSql = "Select a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.Contads, a.ContaOs, " + ;
                           "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                           "From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "((c.GerGdmis = 1 And c.TpGdmis = 1) Or " + ;
                           "(c.GerGdmis = 2 And c.AtuCompras = 1)) " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "")
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TprMvCab') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TprMvCab)", "Erro")
                    EXIT
                ENDIF

                *-- Seleciona itens dos movimentos de compra por produto
                loc_cSql = "Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                           "From SigMvItn " + ;
                           "Where EmpDopNums in (" + ;
                           "Select EmpDopNums From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "c.GerGdmis = 2 And c.AtuCompras = 1 " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "") + ;
                           ") "
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'crTpmMvItn') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crTpmMvItn)", "Erro")
                    EXIT
                ENDIF

                *-- Carrega registros existentes em SigOpClU para verificar duplicidade
                loc_cSql = "Select EmpDopNums From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocCalcU') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocCalcU)", "Erro")
                    EXIT
                ENDIF

                SELECT LocCalcU
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT TprMvCab
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT crTpmMvItn
                INDEX ON EmpDopNums TAG EmpDopNums

                loc_nReg  = RECCOUNT('TprMvCab')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Preparando Arquivo de Atualiza' + CHR(231) + CHR(227) + ;
                    'o da Ultima Compra', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT TprMvCab
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = TprMvCab.Emps + " " + ;
                        TprMvCab.Dopes + " " + STR(TprMvCab.Numes, 6)
                    loc_oCusto.Update(.T.)

                    IF SEEK(TprMvCab.EmpDopNums, 'LocCalcU', 'EmpdopNums')
                        LOOP
                    ENDIF

                    *-- Tipo 1: movimento de conta corrente
                    IF (TprMvCab.GerGdmis = 1 .AND. TprMvCab.TpGdmis = 1)
                        loc_cConta = IIF(TprMvCab.Copers = 1, TprMvCab.Contads, TprMvCab.Contaos)

                        IF USED("crSigCdPam") .AND. TprMvCab.CMoes # crSigCdPam.MoeCentral
                            loc_lnCotaCentral  = fBuscarCotacao(crSigCdPam.MoeCentral, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnCotaOperac   = fBuscarCotacao(TprMvCab.CMoes, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnValorCentral = ROUND(TprMvCab.Valos * loc_lnCotaOperac / ;
                                                       loc_lnCotaCentral, 2)
                        ELSE
                            loc_lnValorCentral = TprMvCab.Valos
                        ENDIF

                        loc_ldData = TprMvCab.Datas
                        INSERT INTO CrSigOpClU ;
                            (Emps, Dopes, Numes, EmpdopNums, iclis, Valors, Datas, Cidchaves) ;
                            VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                    TprMvCab.EmpdopNums, loc_cConta, loc_lnValorCentral, ;
                                    loc_ldData, fUniqueIds())
                    ENDIF

                    *-- Tipo 2: movimento de itens (produtos)
                    IF (TprMvCab.GerGdmis = 2 .AND. TprMvCab.AtuCompras = 1)
                        SELECT crTpmMvItn
                        =SEEK(TprMvCab.EmpDopNums)
                        SCAN WHILE EmpdopNums = TprMvCab.EmpDopNums
                            IF EMPTY(Cpros)
                                LOOP
                            ENDIF

                            loc_cSql = "Select Cpros, UltComps From SigCdPro " + ;
                                       "Where Cpros = '" + ALLTRIM(crTpmMvItn.Cpros) + "'"
                            IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TmpPro') < 1
                                MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro)", "Erro")
                                LOOP
                            ENDIF

                            loc_ldData  = TprMvCab.Datas
                            loc_lnValor = crTpmMvItn.Units
                            loc_cMoeda  = crTpmMvItn.Moedas

                            INSERT INTO CrSigOpClU ;
                                (Emps, Dopes, Numes, empDopNums, cpros, Valors, ;
                                 Datas, Moedas, Cidchaves) ;
                                VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                        TprMvCab.EmpdopNums, crTpmMvItn.Cpros, loc_lnValor, ;
                                        loc_ldData, loc_cMoeda, fUniqueIds())
                        ENDSCAN
                    ENDIF
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                *-- Persiste CrSigOpClU no banco
                IF !THIS.this_oDataMgr.Update('CrSigOpClU')
                    MsgErro("Falha na conex" + CHR(227) + "o (Update CrSigOpClU)", "Erro")
                    EXIT
                ENDIF
                THIS.this_oDataMgr.Commit()

                *-- Atualiza SigCdCli: ultima compra por cliente
                loc_cSql = "Select * From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'CsSelecao') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (CsSelecao)", "Erro")
                    EXIT
                ENDIF

                SELECT DISTINCT Iclis FROM CsSelecao INTO CURSOR SelecaoIclis

                loc_nReg  = RECCOUNT('SelecaoIclis')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Clientes ', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoIclis
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Cliente " + SelecaoIclis.Iclis
                    loc_oCusto.Update(.T.)

                    loc_cConta = SelecaoIclis.Iclis

                    *-- Ultima compra pela data mais recente
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Data)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli)", "Erro")
                        LOOP
                    ENDIF

                    *-- Ultima compra pelo maior valor
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Valors Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Valor)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set dtfats = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", mfats = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli dtfats)", "Erro")
                        LOOP
                    ENDIF

                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                *-- Atualiza SigCdPro: ultima compra por produto
                SELECT DISTINCT Cpros FROM CsSelecao INTO CURSOR SelecaoCpros

                loc_nReg  = RECCOUNT('SelecaoCpros')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Produtos', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoCpros
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Produto " + SelecaoCpros.Cpros
                    loc_oCusto.Update(.T.)

                    loc_cSql = "Select Top 1 Cpros, Datas, Valors, Moedas From SigOpClU " + ;
                               "Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "' " + ;
                               "Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Produto)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData  = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_lnValor = IIF(RECCOUNT('LocalCalcU') = 0, 0,     LocalCalcU.Valors)
                    loc_cMoeda  = IIF(RECCOUNT('LocalCalcU') = 0, "",    ALLTRIM(LocalCalcU.Moedas))

                    loc_cUpDate = "Update SigCdPro Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + STR(loc_lnValor, 12, 2) + ;
                                  ", mUltComps = '" + loc_cMoeda + "'" + ;
                                  " Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPro)", "Erro")
                        LOOP
                    ENDIF
                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF
                IF USED("crTpmMvItn")
                    USE IN crTpmMvItn
                ENDIF
                IF USED("LocCalcU")
                    USE IN LocCalcU
                ENDIF
                IF USED("CsSelecao")
                    USE IN CsSelecao
                ENDIF
                IF USED("SelecaoIclis")
                    USE IN SelecaoIclis
                ENDIF
                IF USED("SelecaoCpros")
                    USE IN SelecaoCpros
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

