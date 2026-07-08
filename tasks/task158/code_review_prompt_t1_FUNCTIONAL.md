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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1906 linhas total):

*-- Linhas 37 a 164:
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
79:             THIS.ConfigurarCheckboxes()
80:             THIS.ConfigurarBotoesPrincipais()
81:             THIS.ConfigurarContaineresOpcoes()
82:             THIS.ConfigurarPaginaDados()
83:             THIS.ConfigurarBINDEVENTs()
84:             THIS.ConfigurarRodape()
85: 
86:             *-- Tornar controles visiveis (exceto containers de opcoes e LblEnd)
87:             THIS.TornarControlesVisiveis(THIS)
88: 
89:             *-- Aplicar estado inicial: checkboxes off, containers ocultos,
90:             *   contador zerado, botao Processar desabilitado
91:             THIS.ConfigurarPaginaLista()
92: 
93:             loc_lSucesso = .T.
94:         CATCH TO loc_oErro
95:             MsgErro(loc_oErro.Message, "Erro")
96:         ENDTRY
97:         RETURN loc_lSucesso
98:     ENDPROC
99: 
100:     *--------------------------------------------------------------------------
101:     PROTECTED PROCEDURE ConfigurarPageFrame()
102:     *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
103:     *  Ajusta Picture, Caption, dimensoes e centralizacao. Mantem o nome
104:     *  ConfigurarPageFrame por convencao do pipeline de migracao.
105:     *--------------------------------------------------------------------------
106:         LOCAL loc_cImgFundo
107: 
108:         *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
109:         THIS.Caption = "Rec" + CHR(225) + "lculo de Saldos"
110: 
111:         *-- Imagem de fundo do framework
112:         loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
113:         IF FILE(loc_cImgFundo)
114:             THIS.Picture = loc_cImgFundo
115:         ENDIF
116: 
117:         *-- Reforca dimensoes canonicas (escala 1.25x do legado 800x600)
118:         THIS.Width      = 1000
119:         THIS.Height     = 600
120:         THIS.AutoCenter = .T.
121:     ENDPROC
122: 
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarCabecalho()
125:     *  Container cinza escuro com titulo do form
126:     *--------------------------------------------------------------------------
127:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH THIS.cnt_4c_Cabecalho
129:             .Top         = 0
130:             .Left        = 0
131:             .Width       = 1000
132:             .Height      = 80
133:             .BackStyle   = 1
134:             .BackColor   = RGB(100, 100, 100)
135:             .BorderWidth = 0
136:             .Visible     = .T.
137: 
138:             .AddObject("lbl_4c_Sombra", "Label")
139:             WITH .lbl_4c_Sombra
140:                 .Top       = 18
141:                 .Left      = 10
142:                 .Width     = THIS.Width
143:                 .Height    = 40
144:                 .AutoSize  = .F.
145:                 .BackStyle = 0
146:                 .FontBold  = .T.
147:                 .FontName  = "Tahoma"
148:                 .FontSize  = 18
149:                 .ForeColor = RGB(0, 0, 0)
150:                 .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
151:                 .Visible   = .T.
152:             ENDWITH
153: 
154:             .AddObject("lbl_4c_Titulo", "Label")
155:             WITH .lbl_4c_Titulo
156:                 .Top       = 17
157:                 .Left      = 10
158:                 .Width     = THIS.Width
159:                 .Height    = 46
160:                 .AutoSize  = .F.
161:                 .BackStyle = 0
162:                 .FontBold  = .T.
163:                 .FontName  = "Tahoma"
164:                 .FontSize  = 18

*-- Linhas 170 a 213:
170:     ENDPROC
171: 
172:     *--------------------------------------------------------------------------
173:     PROTECTED PROCEDURE ConfigurarCheckboxes()
174:     *  Shape de fundo decorativo + 4 checkboxes de selecao de modulo
175:     *  Posicoes escaladas 1.25x do original (800->1000)
176:     *--------------------------------------------------------------------------
177:         *-- Shape decorativo de fundo dos botoes de acao (direita)
178:         THIS.AddObject("shp_4c_Shape1", "Shape")
179:         WITH THIS.shp_4c_Shape1
180:             .Top         = 7
181:             .Left        = 871
182:             .Height      = 110
183:             .Width       = 112
184:             .BackStyle   = 0
185:             .BorderStyle = 0
186:             .BorderColor = RGB(136, 189, 188)
187:             .Visible     = .T.
188:         ENDWITH
189: 
190:         *-- CheckBox: Conta Corrente (original Left=350 -> 437)
191:         THIS.AddObject("chk_4c_Conta", "CheckBox")
192:         WITH THIS.chk_4c_Conta
193:             .Top           = 3
194:             .Left          = 437
195:             .Height        = 75
196:             .Width         = 75
197:             .FontBold      = .T.
198:             .FontItalic    = .T.
199:             .FontName      = "Comic Sans MS"
200:             .FontSize      = 8
201:             .AutoSize      = .F.
202:             .Alignment     = 1
203:             .BackStyle     = 0
204:             .Caption       = "C.C."
205:             .Value         = 0
206:             .SpecialEffect = 0
207:             .Style         = 1
208:             .ToolTipText   = "Conta Corrente"
209:             .ForeColor     = RGB(90, 90, 90)
210:             .BackColor     = RGB(255, 255, 255)
211:             .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
212:             .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
213:             .Themes        = .F.

*-- Linhas 295 a 338:
295:     ENDPROC
296: 
297:     *--------------------------------------------------------------------------
298:     PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
299:     *  Botoes Processar e Encerrar (original Left=650/725 -> 812/906)
300:     *--------------------------------------------------------------------------
301:         *-- Botao Processar (inicia desabilitado - habilita quando algum checkbox marcado)
302:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
303:         WITH THIS.cmd_4c_Processar
304:             .Top             = 3
305:             .Left            = 812
306:             .Height          = 75
307:             .Width           = 75
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .FontName        = "Comic Sans MS"
311:             .FontSize        = 8
312:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
313:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
314:             .Caption         = "Processar"
315:             .Enabled         = .F.
316:             .ToolTipText     = "Processar"
317:             .SpecialEffect   = 0
318:             .ForeColor       = RGB(90, 90, 90)
319:             .BackColor       = RGB(255, 255, 255)
320:             .Themes          = .T.
321:             .WordWrap        = .T.
322:             .Visible         = .T.
323:         ENDWITH
324: 
325:         *-- Botao Encerrar (Cancel=.T. -> ESC fecha o form)
326:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH THIS.cmd_4c_Encerrar
328:             .Top           = 3
329:             .Left          = 906
330:             .Height        = 75
331:             .Width         = 75
332:             .FontBold      = .T.
333:             .FontItalic    = .T.
334:             .FontName      = "Comic Sans MS"
335:             .FontSize      = 8
336:             .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
337:             .Cancel        = .T.
338:             .Caption       = "Encerrar"

*-- Linhas 347 a 457:
347:     ENDPROC
348: 
349:     *--------------------------------------------------------------------------
350:     PROTECTED PROCEDURE ConfigurarContaineresOpcoes()
351:     *  4 containers de parametros - iniciam ocultos, toggled pelos checkboxes
352:     *  Posicoes escaladas 1.25x: Left=139->173, Width=536->670
353:     *--------------------------------------------------------------------------
354: 
355:         *-- Container: Opcoes de Conta Corrente (original Top=114)
356:         THIS.AddObject("cnt_4c_OpConta", "Container")
357:         WITH THIS.cnt_4c_OpConta
358:             .Top           = 114
359:             .Left          = 173
360:             .Width         = 670
361:             .Height        = 81
362:             .BackStyle     = 0
363:             .BorderWidth   = 2
364:             .SpecialEffect = 2
365:             .BackColor     = RGB(192, 192, 255)
366:             .BorderColor   = RGB(90, 90, 90)
367:             .Visible       = .F.
368:         ENDWITH
369: 
370:         *-- Container: Opcoes de Estoque (original Top=200)
371:         THIS.AddObject("cnt_4c_OpEstoque", "Container")
372:         WITH THIS.cnt_4c_OpEstoque
373:             .Top           = 200
374:             .Left          = 173
375:             .Width         = 670
376:             .Height        = 143
377:             .BackStyle     = 0
378:             .BorderWidth   = 2
379:             .SpecialEffect = 2
380:             .BackColor     = RGB(192, 192, 255)
381:             .BorderColor   = RGB(90, 90, 90)
382:             .Visible       = .F.
383:         ENDWITH
384: 
385:         *-- Container: Opcoes de Custo de Produto (original Top=349)
386:         THIS.AddObject("cnt_4c_OpCusto", "Container")
387:         WITH THIS.cnt_4c_OpCusto
388:             .Top           = 349
389:             .Left          = 173
390:             .Width         = 670
391:             .Height        = 92
392:             .BackStyle     = 0
393:             .BorderWidth   = 2
394:             .SpecialEffect = 2
395:             .BackColor     = RGB(192, 192, 255)
396:             .BorderColor   = RGB(90, 90, 90)
397:             .Visible       = .F.
398:         ENDWITH
399: 
400:         *-- Container: Opcoes de Ultima Compra (original Top=447)
401:         THIS.AddObject("cnt_4c_OpCompra", "Container")
402:         WITH THIS.cnt_4c_OpCompra
403:             .Top           = 447
404:             .Left          = 173
405:             .Width         = 670
406:             .Height        = 91
407:             .BackStyle     = 0
408:             .BorderWidth   = 2
409:             .SpecialEffect = 2
410:             .BackColor     = RGB(192, 192, 255)
411:             .BorderColor   = RGB(90, 90, 90)
412:             .Visible       = .F.
413:         ENDWITH
414:     ENDPROC
415: 
416:     *--------------------------------------------------------------------------
417:     PROTECTED PROCEDURE ConfigurarRodape()
418:     *  Label "Registros:", contador numerico e label de conclusao
419:     *  Posicoes escaladas 1.25x do original
420:     *--------------------------------------------------------------------------
421:         *-- Label "Registros : " (original Left=171 -> 213)
422:         THIS.AddObject("lbl_4c_Registros", "Label")
423:         WITH THIS.lbl_4c_Registros
424:             .Top       = 547
425:             .Left      = 213
426:             .Width     = 65
427:             .Height    = 15
428:             .AutoSize  = .T.
429:             .BackStyle = 0
430:             .FontBold  = .T.
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .ForeColor = RGB(90, 90, 90)
434:             .Caption   = "Registros : "
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         *-- TextBox contador (original Left=238 -> 297, Width=93 -> 116)
439:         *  ReadOnly: legado usa When=Return .F. para impedir foco
440:         THIS.AddObject("txt_4c_Registro", "TextBox")
441:         WITH THIS.txt_4c_Registro
442:             .Top           = 543
443:             .Left          = 297
444:             .Width         = 116
445:             .Height        = 23
446:             .FontName      = "Tahoma"
447:             .FontSize      = 8
448:             .InputMask     = "999,999,999"
449:             .SpecialEffect = 1
450:             .ForeColor     = RGB(0, 0, 0)
451:             .Value         = 0
452:             .ReadOnly      = .T.
453:             .TabStop       = .F.
454:             .Visible       = .T.
455:         ENDWITH
456: 
457:         *-- Label conclusao (oculto, exibido ao terminar processamento)

*-- Linhas 474 a 527:
474:         ENDWITH
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     PROTECTED PROCEDURE ConfigurarConteudoOpConta()
479:     *  Sub-controles de cnt_4c_OpConta (Opcoes Conta Corrente)
480:     *--------------------------------------------------------------------------
481:         LOCAL loc_oCnt
482:         loc_oCnt = THIS.cnt_4c_OpConta
483: 
484:         loc_oCnt.AddObject("lbl_4c_TituloConta", "Label")
485:         WITH loc_oCnt.lbl_4c_TituloConta
486:             .Top       = 2
487:             .Left      = 213
488:             .AutoSize  = .T.
489:             .BackStyle = 0
490:             .FontBold  = .T.
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .ForeColor = RGB(0, 0, 128)
494:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
495:             .Visible   = .T.
496:         ENDWITH
497: 
498:         loc_oCnt.AddObject("lbl_4c_EmpresaConta", "Label")
499:         WITH loc_oCnt.lbl_4c_EmpresaConta
500:             .Top       = 23
501:             .Left      = 20
502:             .Width     = 71
503:             .Height    = 15
504:             .AutoSize  = .F.
505:             .BackStyle = 0
506:             .FontName  = "Tahoma"
507:             .FontSize  = 8
508:             .Caption   = "Empresa :"
509:             .Visible   = .T.
510:         ENDWITH
511:         loc_oCnt.AddObject("txt_4c_EmpresaConta", "TextBox")
512:         WITH loc_oCnt.txt_4c_EmpresaConta
513:             .Top       = 20
514:             .Left      = 93
515:             .Width     = 38
516:             .Height    = 23
517:             .FontName  = "Tahoma"
518:             .FontSize  = 8
519:             .Value     = ""
520:             .Visible   = .T.
521:         ENDWITH
522: 
523:         loc_oCnt.AddObject("lbl_4c_GruposConta", "Label")
524:         WITH loc_oCnt.lbl_4c_GruposConta
525:             .Top       = 24
526:             .Left      = 152
527:             .Width     = 52

*-- Linhas 621 a 665:
621:         ENDWITH
622:     ENDPROC
623: 
624:     *--------------------------------------------------------------------------
625:     PROTECTED PROCEDURE ConfigurarConteudoOpEstoque()
626:     *  Sub-controles de cnt_4c_OpEstoque (Opcoes de Estoque)
627:     *--------------------------------------------------------------------------
628:         LOCAL loc_oCnt
629:         loc_oCnt = THIS.cnt_4c_OpEstoque
630: 
631:         loc_oCnt.AddObject("lbl_4c_TituloEst", "Label")
632:         WITH loc_oCnt.lbl_4c_TituloEst
633:             .Top       = 2
634:             .Left      = 227
635:             .AutoSize  = .T.
636:             .BackStyle = 0
637:             .FontBold  = .T.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8
640:             .ForeColor = RGB(0, 0, 128)
641:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
646:         WITH loc_oCnt.lbl_4c_EmpresaEst
647:             .Top       = 15
648:             .Left      = 38
649:             .Width     = 71
650:             .Height    = 15
651:             .AutoSize  = .F.
652:             .BackStyle = 0
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .Caption   = "Empresa :"
656:             .Visible   = .T.
657:         ENDWITH
658:         loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
659:         WITH loc_oCnt.txt_4c_EmpresaEst
660:             .Top       = 12
661:             .Left      = 112
662:             .Width     = 38
663:             .Height    = 23
664:             .FontName  = "Tahoma"
665:             .FontSize  = 8

*-- Linhas 703 a 724:
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .Caption   = "Estoque :"
706:             .Visible   = .T.
707:         ENDWITH
708:         loc_oCnt.AddObject("txt_4c_EstoqueEst", "TextBox")
709:         WITH loc_oCnt.txt_4c_EstoqueEst
710:             .Top       = 62
711:             .Left      = 112
712:             .Width     = 100
713:             .Height    = 23
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .Value     = ""
717:             .Visible   = .T.
718:         ENDWITH
719: 
720:         loc_oCnt.AddObject("lbl_4c_ProdutoEst", "Label")
721:         WITH loc_oCnt.lbl_4c_ProdutoEst
722:             .Top       = 90
723:             .Left      = 43
724:             .Width     = 66

*-- Linhas 779 a 823:
779:         ENDWITH
780:     ENDPROC
781: 
782:     *--------------------------------------------------------------------------
783:     PROTECTED PROCEDURE ConfigurarConteudoOpCusto()
784:     *  Sub-controles de cnt_4c_OpCusto (Opcoes de Custo de Produto)
785:     *--------------------------------------------------------------------------
786:         LOCAL loc_oCnt
787:         loc_oCnt = THIS.cnt_4c_OpCusto
788: 
789:         loc_oCnt.AddObject("lbl_4c_TituloCusto", "Label")
790:         WITH loc_oCnt.lbl_4c_TituloCusto
791:             .Top       = 2
792:             .Left      = 193
793:             .AutoSize  = .T.
794:             .BackStyle = 0
795:             .FontBold  = .T.
796:             .FontName  = "Tahoma"
797:             .FontSize  = 8
798:             .ForeColor = RGB(0, 0, 128)
799:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
800:             .Visible   = .T.
801:         ENDWITH
802: 
803:         loc_oCnt.AddObject("lbl_4c_EmpresaCusto", "Label")
804:         WITH loc_oCnt.lbl_4c_EmpresaCusto
805:             .Top       = 14
806:             .Left      = 38
807:             .Width     = 71
808:             .Height    = 15
809:             .AutoSize  = .F.
810:             .BackStyle = 0
811:             .FontName  = "Tahoma"
812:             .FontSize  = 8
813:             .Caption   = "Empresa :"
814:             .Visible   = .T.
815:         ENDWITH
816:         loc_oCnt.AddObject("txt_4c_EmpresaCusto", "TextBox")
817:         WITH loc_oCnt.txt_4c_EmpresaCusto
818:             .Top       = 11
819:             .Left      = 112
820:             .Width     = 38
821:             .Height    = 23
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8

*-- Linhas 887 a 931:
887:         ENDWITH
888:     ENDPROC
889: 
890:     *--------------------------------------------------------------------------
891:     PROTECTED PROCEDURE ConfigurarConteudoOpCompra()
892:     *  Sub-controles de cnt_4c_OpCompra (Opcoes de Ultima Compra)
893:     *--------------------------------------------------------------------------
894:         LOCAL loc_oCnt
895:         loc_oCnt = THIS.cnt_4c_OpCompra
896: 
897:         loc_oCnt.AddObject("lbl_4c_TituloCompra", "Label")
898:         WITH loc_oCnt.lbl_4c_TituloCompra
899:             .Top       = 2
900:             .Left      = 175
901:             .AutoSize  = .T.
902:             .BackStyle = 0
903:             .FontBold  = .T.
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .ForeColor = RGB(0, 0, 128)
907:             .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
908:             .Visible   = .T.
909:         ENDWITH
910: 
911:         loc_oCnt.AddObject("lbl_4c_EmpresaCompra", "Label")
912:         WITH loc_oCnt.lbl_4c_EmpresaCompra
913:             .Top       = 14
914:             .Left      = 38
915:             .Width     = 71
916:             .Height    = 15
917:             .AutoSize  = .F.
918:             .BackStyle = 0
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .Caption   = "Empresa :"
922:             .Visible   = .T.
923:         ENDWITH
924:         loc_oCnt.AddObject("txt_4c_EmpresaCompra", "TextBox")
925:         WITH loc_oCnt.txt_4c_EmpresaCompra
926:             .Top       = 10
927:             .Left      = 112
928:             .Width     = 38
929:             .Height    = 23
930:             .FontName  = "Tahoma"
931:             .FontSize  = 8

*-- Linhas 996 a 1906:
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
1000:     *--------------------------------------------------------------------------
1001:         BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
1002:         BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
1003:         BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkBtnCustoClick")
1004:         BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")
1005: 
1006:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1007:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")
1008: 
1009:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "KeyPress", THIS, "TxtEmpresaContaKeyPress")
1010:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "DblClick", THIS, "TxtEmpresaContaDblClick")
1011:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "KeyPress", THIS, "TxtMoedasContaKeyPress")
1012:         BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "DblClick", THIS, "TxtMoedasContaDblClick")
1013: 
1014:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "KeyPress", THIS, "TxtEmpresaEstKeyPress")
1015:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "DblClick", THIS, "TxtEmpresaEstDblClick")
1016:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "KeyPress", THIS, "TxtProdutoEstKeyPress")
1017:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "DblClick", THIS, "TxtProdutoEstDblClick")
1018:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "KeyPress", THIS, "TxtDescsEstKeyPress")
1019:         BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "DblClick", THIS, "TxtDescsEstDblClick")
1020: 
1021:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "KeyPress", THIS, "TxtEmpresaCustoKeyPress")
1022:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "DblClick", THIS, "TxtEmpresaCustoDblClick")
1023:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "KeyPress", THIS, "TxtProdutoCustoKeyPress")
1024:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "DblClick", THIS, "TxtProdutoCustoDblClick")
1025:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "KeyPress", THIS, "TxtDescsCustoKeyPress")
1026:         BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "DblClick", THIS, "TxtDescsCustoDblClick")
1027: 
1028:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "KeyPress", THIS, "TxtEmpresaCompraKeyPress")
1029:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "DblClick", THIS, "TxtEmpresaCompraDblClick")
1030:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "KeyPress", THIS, "TxtProdutoCompraKeyPress")
1031:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "DblClick", THIS, "TxtProdutoCompraDblClick")
1032:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "KeyPress", THIS, "TxtDescsCompraKeyPress")
1033:         BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "DblClick", THIS, "TxtDescsCompraDblClick")
1034:     ENDPROC
1035: 
1036:     *--------------------------------------------------------------------------
1037:     PROTECTED PROCEDURE AtualizarBotaoProcessar()
1038:     *--------------------------------------------------------------------------
1039:         THIS.cmd_4c_Processar.Enabled = (THIS.chk_4c_Conta.Value     = 1 OR ;
1040:                                          THIS.chk_4c_Estoque.Value   = 1 OR ;
1041:                                          THIS.chk_4c_BtnCusto.Value  = 1 OR ;
1042:                                          THIS.chk_4c_BtnCompra.Value = 1)
1043:     ENDPROC
1044: 
1045:     *--------------------------------------------------------------------------
1046:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1047:     *  Reset do estado inicial (equivalente a Page1/LISTA em forms CRUD,
1048:     *  adaptado para o form OPERACIONAL flat): reseta checkboxes de selecao
1049:     *  de modulos, oculta containers de opcoes, esconde label de conclusao
1050:     *  e zera contador de registros processados.
1051:     *--------------------------------------------------------------------------
1052:         *-- Checkboxes de selecao de modulos: desmarcados
1053:         THIS.chk_4c_Conta.Value       = 0
1054:         THIS.chk_4c_Estoque.Value     = 0
1055:         THIS.chk_4c_BtnCusto.Value    = 0
1056:         THIS.chk_4c_BtnCompra.Value   = 0
1057: 
1058:         *-- Containers de opcoes ocultos (togglados pelos checkboxes)
1059:         THIS.cnt_4c_OpConta.Visible   = .F.
1060:         THIS.cnt_4c_OpEstoque.Visible = .F.
1061:         THIS.cnt_4c_OpCusto.Visible   = .F.
1062:         THIS.cnt_4c_OpCompra.Visible  = .F.
1063: 
1064:         *-- Rodape: label de conclusao oculto e contador zerado
1065:         THIS.lbl_4c_LblEnd.Visible    = .F.
1066:         THIS.txt_4c_Registro.Value    = 0
1067: 
1068:         *-- Botao Processar inicia desabilitado (nenhum modulo selecionado)
1069:         THIS.AtualizarBotaoProcessar()
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1074:     *  Fachada que agrupa a construcao dos "campos de dados" do form OPERACIONAL.
1075:     *  Este form nao possui PageFrame CRUD; a entrada de parametros pelo usuario
1076:     *  ocorre dentro dos 4 containers flutuantes de opcoes (Conta Corrente,
1077:     *  Estoque, Custo, Ultima Compra), cada um com seus TextBoxes de empresa,
1078:     *  grupo, conta, moeda, produto, descricao e data. Esta rotina cria todos
1079:     *  esses campos de entrada, agrupando as chamadas ConfigurarConteudoOp*.
1080:     *  Equivale, na semantica CRUD, ao "Page2 Dados" onde o usuario preenche
1081:     *  os campos para a operacao.
1082:     *--------------------------------------------------------------------------
1083:         *-- Container OpConta: Empresa, Grupo, Conta, Moeda, Data
1084:         THIS.ConfigurarConteudoOpConta()
1085: 
1086:         *-- Container OpEstoque: Empresa, Grupo, Estoque, Produto, Descricao, Data
1087:         THIS.ConfigurarConteudoOpEstoque()
1088: 
1089:         *-- Container OpCusto: Empresa, Produto, Descricao, Data
1090:         THIS.ConfigurarConteudoOpCusto()
1091: 
1092:         *-- Container OpCompra: Empresa, Produto, Descricao, Data
1093:         THIS.ConfigurarConteudoOpCompra()
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     PROCEDURE AlternarPagina(par_nPagina)
1098:     *  Alterna entre modos operacionais (adaptacao do padrao AlternarPagina
1099:     *  dos forms CRUD para o form OPERACIONAL flat):
1100:     *     par_nPagina = 1 -> Modo SELECAO: usuario escolhe modulos e opcoes
1101:     *     par_nPagina = 2 -> Modo PROCESSAMENTO: controles bloqueados
1102:     *--------------------------------------------------------------------------
1103:         DO CASE
1104:         CASE par_nPagina = 2
1105:             *-- Modo PROCESSAMENTO: bloqueia todos os controles
1106:             THIS.chk_4c_Conta.Enabled     = .F.
1107:             THIS.chk_4c_Estoque.Enabled   = .F.
1108:             THIS.chk_4c_BtnCusto.Enabled  = .F.
1109:             THIS.chk_4c_BtnCompra.Enabled = .F.
1110:             THIS.cmd_4c_Processar.Enabled = .F.
1111:             THIS.cmd_4c_Encerrar.Enabled  = .F.
1112:             THIS.lbl_4c_LblEnd.Visible    = .F.
1113:             THIS.txt_4c_Registro.Value    = 0
1114:         OTHERWISE
1115:             *-- Modo SELECAO (par_nPagina = 1 ou omitido)
1116:             THIS.chk_4c_Conta.Enabled     = .T.
1117:             THIS.chk_4c_Estoque.Enabled   = .T.
1118:             THIS.chk_4c_BtnCusto.Enabled  = .T.
1119:             THIS.chk_4c_BtnCompra.Enabled = .T.
1120:             THIS.cmd_4c_Encerrar.Enabled  = .T.
1121:             THIS.AtualizarBotaoProcessar()
1122:         ENDCASE
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------
1126:     PROCEDURE ChkContaClick()
1127:     *--------------------------------------------------------------------------
1128:         THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
1129:         THIS.AtualizarBotaoProcessar()
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------
1133:     PROCEDURE ChkEstoqueClick()
1134:     *--------------------------------------------------------------------------
1135:         THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
1136:         THIS.AtualizarBotaoProcessar()
1137:     ENDPROC
1138: 
1139:     *--------------------------------------------------------------------------
1140:     PROCEDURE ChkBtnCustoClick()
1141:     *--------------------------------------------------------------------------
1142:         THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
1143:         THIS.AtualizarBotaoProcessar()
1144:     ENDPROC
1145: 
1146:     *--------------------------------------------------------------------------
1147:     PROCEDURE ChkBtnCompraClick()
1148:     *--------------------------------------------------------------------------
1149:         THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
1150:         THIS.AtualizarBotaoProcessar()
1151:     ENDPROC
1152: 
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE CmdProcessarClick()
1155:     *--------------------------------------------------------------------------
1156:         LOCAL loc_lSucesso, loc_oBO, loc_oErro
1157:         loc_oBO      = THIS.this_oBusinessObject
1158:         loc_lSucesso = .F.
1159: 
1160:         loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
1161:         loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
1162:         loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
1163:         loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)
1164: 
1165:         IF loc_oBO.this_lProcessarConta
1166:             loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
1167:             loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
1168:             loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
1169:             loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
1170:             loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
1171:         ENDIF
1172:         IF loc_oBO.this_lProcessarEstoque
1173:             loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
1174:             loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
1175:             loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
1176:             loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1177:             loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
1178:             loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
1179:         ENDIF
1180:         IF loc_oBO.this_lProcessarCusto
1181:             loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
1182:             loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1183:             loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
1184:             loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
1185:         ENDIF
1186:         IF loc_oBO.this_lProcessarCompra
1187:             loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
1188:             loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1189:             loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
1190:             loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
1191:         ENDIF
1192: 
1193:         *-- Modo PROCESSAMENTO: bloqueia controles durante execucao
1194:         THIS.AlternarPagina(2)
1195: 
1196:         TRY
1197:             loc_lSucesso = loc_oBO.Processar(THIS)
1198:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1199:             IF loc_lSucesso
1200:                 THIS.lbl_4c_LblEnd.Visible = .T.
1201:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", ;
1202:                         "Rec" + CHR(225) + "lculo de Saldos")
1203:             ELSE
1204:                 MsgAviso("Processamento conclu" + CHR(237) + "do com erros.", ;
1205:                          "Rec" + CHR(225) + "lculo de Saldos")
1206:             ENDIF
1207:         CATCH TO loc_oErro
1208:             MsgErro(loc_oErro.Message, "Erro ao Processar")
1209:         ENDTRY
1210: 
1211:         *-- Volta para modo SELECAO
1212:         THIS.AlternarPagina(1)
1213:     ENDPROC
1214: 
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE CmdEncerrarClick()
1217:     *--------------------------------------------------------------------------
1218:         THIS.Release()
1219:     ENDPROC
1220: 
1221:     *--------------------------------------------------------------------------
1222:     PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
1223:     *  Lookup generico de empresa (SigCdEmp -> Cemps, Razas)
1224:     *--------------------------------------------------------------------------
1225:         LOCAL loc_oForm, loc_cValor
1226:         TRY
1227:             loc_cValor = ALLTRIM(par_oTxt.Value)
1228:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1229:                 "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
1230:                 "Sele" + CHR(231) + CHR(227) + "o de Empresa")
1231:             IF ISNULL(loc_oForm)
1232:                 RETURN
1233:             ENDIF
1234:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1235:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1236:             ELSE
1237:                 IF !loc_oForm.this_lAchouRegistro
1238:                 loc_oForm.mAddColuna("Cemps", "XXXXXX", "C" + CHR(243) + "digo")
1239:                 loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1240:                 loc_oForm.Show()
1241:                 IF loc_oForm.this_lSelecionou
1242:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
1243:                 ENDIF
1244:                 ENDIF
1245:             ENDIF
1246:             IF USED("cursor_4c_BuscaEmp")
1247:                 USE IN cursor_4c_BuscaEmp
1248:             ENDIF
1249:             loc_oForm.Release()
1250:         CATCH TO loc_oErro
1251:             MsgErro(loc_oErro.Message, "Erro")
1252:         ENDTRY
1253:     ENDPROC
1254: 
1255:     *--------------------------------------------------------------------------
1256:     PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtCod, par_oTxtDesc)
1257:     *  Lookup de produto por codigo (SigCdPro -> CPros, DPros)
1258:     *--------------------------------------------------------------------------
1259:         LOCAL loc_oForm, loc_cValor
1260:         TRY
1261:             loc_cValor = ALLTRIM(par_oTxtCod.Value)
1262:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1263:                 "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
1264:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
1265:             IF ISNULL(loc_oForm)
1266:                 RETURN
1267:             ENDIF
1268:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1269:                 par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1270:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1271:             ELSE
1272:                 IF !loc_oForm.this_lAchouRegistro
1273:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1274:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1275:                 loc_oForm.Show()
1276:                 IF loc_oForm.this_lSelecionou
1277:                     par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
1278:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
1279:                 ENDIF
1280:                 ENDIF
1281:             ENDIF
1282:             IF USED("cursor_4c_BuscaPro")
1283:                 USE IN cursor_4c_BuscaPro
1284:             ENDIF
1285:             loc_oForm.Release()
1286:         CATCH TO loc_oErro
1287:             MsgErro(loc_oErro.Message, "Erro")
1288:         ENDTRY
1289:     ENDPROC
1290: 
1291:     *--------------------------------------------------------------------------
1292:     PROTECTED PROCEDURE AbrirLookupDescricao(par_oTxtCod, par_oTxtDesc)
1293:     *  Lookup de produto por descricao (SigCdPro -> DPros, CPros)
1294:     *--------------------------------------------------------------------------
1295:         LOCAL loc_oForm, loc_cValor
1296:         TRY
1297:             loc_cValor = ALLTRIM(par_oTxtDesc.Value)
1298:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1299:                 "SigCdPro", "cursor_4c_BuscaDesc", "DPros", loc_cValor, ;
1300:                 "Sele" + CHR(231) + CHR(227) + "o de Produto")
1301:             IF ISNULL(loc_oForm)
1302:                 RETURN
1303:             ENDIF
1304:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1305:                 par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
1306:                 par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
1307:             ELSE
1308:                 IF !loc_oForm.this_lAchouRegistro
1309:                 loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
1310:                 loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
1311:                 loc_oForm.Show()
1312:                 IF loc_oForm.this_lSelecionou
1313:                     par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
1314:                     par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
1315:                 ENDIF
1316:                 ENDIF
1317:             ENDIF
1318:             IF USED("cursor_4c_BuscaDesc")
1319:                 USE IN cursor_4c_BuscaDesc
1320:             ENDIF
1321:             loc_oForm.Release()
1322:         CATCH TO loc_oErro
1323:             MsgErro(loc_oErro.Message, "Erro")
1324:         ENDTRY
1325:     ENDPROC
1326: 
1327:     *--------------------------------------------------------------------------
1328:     PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
1329:     *  Lookup de moeda (SigCdMoe -> Cmoes, Dmoes)
1330:     *--------------------------------------------------------------------------
1331:         LOCAL loc_oForm, loc_cValor
1332:         TRY
1333:             loc_cValor = ALLTRIM(par_oTxt.Value)
1334:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1335:                 "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", loc_cValor, ;
1336:                 "Sele" + CHR(231) + CHR(227) + "o de Moeda")
1337:             IF ISNULL(loc_oForm)
1338:                 RETURN
1339:             ENDIF
1340:             IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1341:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
1342:             ELSE
1343:                 IF !loc_oForm.this_lAchouRegistro
1344:                 loc_oForm.mAddColuna("Cmoes", "", "Moe")
1345:                 loc_oForm.mAddColuna("Dmoes", "", "Nome")
1346:                 loc_oForm.Show()
1347:                 IF loc_oForm.this_lSelecionou
1348:                     par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
1349:                 ENDIF
1350:                 ENDIF
1351:             ENDIF
1352:             IF USED("cursor_4c_BuscaMoe")
1353:                 USE IN cursor_4c_BuscaMoe
1354:             ENDIF
1355:             loc_oForm.Release()
1356:         CATCH TO loc_oErro
1357:             MsgErro(loc_oErro.Message, "Erro")
1358:         ENDTRY
1359:     ENDPROC
1360: 
1361:     *--- Handlers: cnt_4c_OpConta ---
1362:     PROCEDURE TxtEmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1363:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1364:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
1365:         ENDIF
1366:     ENDPROC
1367: 
1368:     PROCEDURE TxtEmpresaContaDblClick()
1369:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
1370:     ENDPROC
1371: 
1372:     PROCEDURE TxtMoedasContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1373:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1374:             THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
1375:         ENDIF
1376:     ENDPROC
1377: 
1378:     PROCEDURE TxtMoedasContaDblClick()
1379:         THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
1380:     ENDPROC
1381: 
1382:     *--- Handlers: cnt_4c_OpEstoque ---
1383:     PROCEDURE TxtEmpresaEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1384:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1385:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
1386:         ENDIF
1387:     ENDPROC
1388: 
1389:     PROCEDURE TxtEmpresaEstDblClick()
1390:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
1391:     ENDPROC
1392: 
1393:     PROCEDURE TxtProdutoEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1394:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1395:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1396:                                     THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1397:         ENDIF
1398:     ENDPROC
1399: 
1400:     PROCEDURE TxtProdutoEstDblClick()
1401:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1402:                                 THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1403:     ENDPROC
1404: 
1405:     PROCEDURE TxtDescsEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1406:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1407:             IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1408:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1409:                                           THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1410:             ENDIF
1411:         ENDIF
1412:     ENDPROC
1413: 
1414:     PROCEDURE TxtDescsEstDblClick()
1415:         IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1416:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
1417:                                       THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
1418:         ENDIF
1419:     ENDPROC
1420: 
1421:     *--- Handlers: cnt_4c_OpCusto ---
1422:     PROCEDURE TxtEmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1423:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1424:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
1425:         ENDIF
1426:     ENDPROC
1427: 
1428:     PROCEDURE TxtEmpresaCustoDblClick()
1429:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
1430:     ENDPROC
1431: 
1432:     PROCEDURE TxtProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1433:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1434:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1435:                                     THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1436:         ENDIF
1437:     ENDPROC
1438: 
1439:     PROCEDURE TxtProdutoCustoDblClick()
1440:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1441:                                 THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1442:     ENDPROC
1443: 
1444:     PROCEDURE TxtDescsCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1445:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1446:             IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1447:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1448:                                           THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1449:             ENDIF
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     PROCEDURE TxtDescsCustoDblClick()
1454:         IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1455:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
1456:                                       THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
1457:         ENDIF
1458:     ENDPROC
1459: 
1460:     *--- Handlers: cnt_4c_OpCompra ---
1461:     PROCEDURE TxtEmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1462:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1463:             THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
1464:         ENDIF
1465:     ENDPROC
1466: 
1467:     PROCEDURE TxtEmpresaCompraDblClick()
1468:         THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
1469:     ENDPROC
1470: 
1471:     PROCEDURE TxtProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1472:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1473:             THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1474:                                     THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1475:         ENDIF
1476:     ENDPROC
1477: 
1478:     PROCEDURE TxtProdutoCompraDblClick()
1479:         THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1480:                                 THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1481:     ENDPROC
1482: 
1483:     PROCEDURE TxtDescsCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1484:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1485:             IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1486:                 THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1487:                                           THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1488:             ENDIF
1489:         ENDIF
1490:     ENDPROC
1491: 
1492:     PROCEDURE TxtDescsCompraDblClick()
1493:         IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1494:             THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
1495:                                       THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
1496:         ENDIF
1497:     ENDPROC
1498: 
1499:     *--------------------------------------------------------------------------
1500:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1501:     *  Torna controles visiveis recursivamente.
1502:     *  EXCECOES (permanecem ocultos apos InicializarForm):
1503:     *    - cnt_4c_OpConta/OpEstoque/OpCusto/OpCompra: toggled pelos checkboxes
1504:     *    - lbl_4c_LblEnd: exibido apenas ao concluir processamento
1505:     *--------------------------------------------------------------------------
1506:         LOCAL loc_i, loc_p, loc_oControl
1507:         FOR loc_i = 1 TO par_oContainer.ControlCount
1508:             loc_oControl = par_oContainer.Controls(loc_i)
1509:             IF VARTYPE(loc_oControl) != "O"
1510:                 LOOP
1511:             ENDIF
1512: 
1513:             *-- Containers e labels que devem permanecer ocultos
1514:             IF INLIST(UPPER(loc_oControl.Name), ;
1515:                 "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
1516:                 "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA", ;
1517:                 "LBL_4C_LBLEND")
1518:                 *-- Recursao nos filhos para que fiquem prontos quando container tornar visivel
1519:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1520:                     THIS.TornarControlesVisiveis(loc_oControl)
1521:                 ENDIF
1522:                 LOOP
1523:             ENDIF
1524: 
1525:             IF PEMSTATUS(loc_oControl, "Visible", 5)
1526:                 loc_oControl.Visible = .T.
1527:             ENDIF
1528: 
1529:             *-- Recursao para PageFrame (nao usado neste form, mas por padrao)
1530:             IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1531:                 FOR loc_p = 1 TO loc_oControl.PageCount
1532:                     THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
1533:                 ENDFOR
1534:             ENDIF
1535: 
1536:             *-- Recursao para containers com filhos
1537:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1538:                 THIS.TornarControlesVisiveis(loc_oControl)
1539:             ENDIF
1540:         ENDFOR
1541:     ENDPROC
1542: 
1543:     *--------------------------------------------------------------------------
1544:     * BtnIncluirClick - Inicia um novo ciclo de recalculo de saldos
1545:     * Form OPERACIONAL: mapeado para o disparo do processamento (equivalente
1546:     * a "incluir" uma nova execucao). Delega para CmdProcessarClick.
1547:     *--------------------------------------------------------------------------
1548:     PROCEDURE BtnIncluirClick()
1549:         LOCAL loc_oErro
1550:         TRY
1551:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1552:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1553:                 MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de processamento (Conta, Estoque, Custo ou " + CHR(250) + "lt. Compra).", ;
1554:                          "Rec" + CHR(225) + "lculo de Saldos")
1555:                 RETURN
1556:             ENDIF
1557:             THIS.lbl_4c_LblEnd.Visible = .F.
1558:             THIS.txt_4c_Registro.Value = 0
1559:             THIS.CmdProcessarClick()
1560:         CATCH TO loc_oErro
1561:             MsgErro(loc_oErro.Message, "Erro ao iniciar processamento")
1562:         ENDTRY
1563:     ENDPROC
1564: 
1565:     *--------------------------------------------------------------------------
1566:     * BtnAlterarClick - Reexecuta o processamento com as opcoes atuais
1567:     * Form OPERACIONAL: equivalente a "alterar" parametros e reprocessar.
1568:     * Requer que pelo menos uma opcao esteja marcada.
1569:     *--------------------------------------------------------------------------
1570:     PROCEDURE BtnAlterarClick()
1571:         LOCAL loc_oErro
1572:         TRY
1573:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1574:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1575:                 MsgAviso("Nenhuma op" + CHR(231) + CHR(227) + "o marcada para reprocessar.", ;
1576:                          "Rec" + CHR(225) + "lculo de Saldos")
1577:                 RETURN
1578:             ENDIF
1579:             IF MsgConfirma("Reexecutar o processamento com as op" + CHR(231) + CHR(245) + "es atuais?", ;
1580:                            "Rec" + CHR(225) + "lculo de Saldos")
1581:                 THIS.lbl_4c_LblEnd.Visible = .F.
1582:                 THIS.txt_4c_Registro.Value = 0
1583:                 THIS.CmdProcessarClick()
1584:             ENDIF
1585:         CATCH TO loc_oErro
1586:             MsgErro(loc_oErro.Message, "Erro ao reexecutar processamento")
1587:         ENDTRY
1588:     ENDPROC
1589: 
1590:     *--------------------------------------------------------------------------
1591:     * BtnVisualizarClick - Exibe o resumo do ultimo processamento
1592:     * Form OPERACIONAL: mostra os totais processados sem reexecutar.
1593:     *--------------------------------------------------------------------------
1594:     PROCEDURE BtnVisualizarClick()
1595:         LOCAL loc_oBO, loc_nRegistros, loc_cMsg, loc_oErro
1596:         TRY
1597:             loc_oBO = THIS.this_oBusinessObject
1598:             loc_nRegistros = 0
1599:             IF VARTYPE(loc_oBO) = "O" AND !ISNULL(loc_oBO)
1600:                 loc_nRegistros = loc_oBO.this_nRegistros
1601:             ENDIF
1602:             THIS.txt_4c_Registro.Value = loc_nRegistros
1603: 
1604:             loc_cMsg = "Resumo do " + CHR(250) + "ltimo processamento:" + CHR(13) + CHR(13) + ;
1605:                        "Registros processados: " + TRANSFORM(loc_nRegistros) + CHR(13) + ;
1606:                        "Conta Corrente......: " + IIF(THIS.chk_4c_Conta.Value    = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1607:                        "Estoque.............: " + IIF(THIS.chk_4c_Estoque.Value  = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1608:                        "Custo...............: " + IIF(THIS.chk_4c_BtnCusto.Value = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
1609:                        CHR(250) + "lt. Compra..........: " + IIF(THIS.chk_4c_BtnCompra.Value = 1, "SIM", "N" + CHR(227) + "O")
1610: 
1611:             THIS.lbl_4c_LblEnd.Visible = (loc_nRegistros > 0)
1612:             MsgInfo(loc_cMsg, "Rec" + CHR(225) + "lculo de Saldos")
1613:         CATCH TO loc_oErro
1614:             MsgErro(loc_oErro.Message, "Erro ao visualizar resumo")
1615:         ENDTRY
1616:     ENDPROC
1617: 
1618:     *--------------------------------------------------------------------------
1619:     * BtnExcluirClick - Cancela / reinicia a selecao de opcoes
1620:     * Form OPERACIONAL: nao ha exclusao de dados; a acao reseta os
1621:     * checkboxes, esconde os paineis flutuantes e zera o contador.
1622:     *--------------------------------------------------------------------------
1623:     PROCEDURE BtnExcluirClick()
1624:         LOCAL loc_oErro
1625:         TRY
1626:             IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + "es selecionadas?", ;
1627:                             "Rec" + CHR(225) + "lculo de Saldos")
1628:                 RETURN
1629:             ENDIF
1630: 
1631:             THIS.chk_4c_Conta.Value     = 0
1632:             THIS.chk_4c_Estoque.Value   = 0
1633:             THIS.chk_4c_BtnCusto.Value  = 0
1634:             THIS.chk_4c_BtnCompra.Value = 0
1635: 
1636:             THIS.cnt_4c_OpConta.Visible   = .F.
1637:             THIS.cnt_4c_OpEstoque.Visible = .F.
1638:             THIS.cnt_4c_OpCusto.Visible   = .F.
1639:             THIS.cnt_4c_OpCompra.Visible  = .F.
1640: 
1641:             THIS.txt_4c_Registro.Value = 0
1642:             THIS.lbl_4c_LblEnd.Visible = .F.
1643: 
1644:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1645:                 THIS.this_oBusinessObject.this_nRegistros = 0
1646:             ENDIF
1647: 
1648:             THIS.AtualizarBotaoProcessar()
1649:             THIS.Refresh()
1650:         CATCH TO loc_oErro
1651:             MsgErro(loc_oErro.Message, "Erro ao limpar op" + CHR(231) + CHR(245) + "es")
1652:         ENDTRY
1653:     ENDPROC
1654: 
1655:     *--------------------------------------------------------------------------
1656:     PROCEDURE FormParaBO()
1657:     *  Transfere os valores dos campos visuais para as propriedades do BO.
1658:     *  Para o form OPERACIONAL: copia flags dos checkboxes e parametros
1659:     *  de cada secao ativa para as propriedades this_* do BO.
1660:     *--------------------------------------------------------------------------
1661:         LOCAL loc_oBO, loc_oErro
1662:         TRY
1663:             loc_oBO = THIS.this_oBusinessObject
1664:             IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
1665:                 RETURN
1666:             ENDIF
1667: 
1668:             loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
1669:             loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
1670:             loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
1671:             loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)
1672: 
1673:             IF loc_oBO.this_lProcessarConta
1674:                 loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
1675:                 loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
1676:                 loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
1677:                 loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
1678:                 loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
1679:             ENDIF
1680: 
1681:             IF loc_oBO.this_lProcessarEstoque
1682:                 loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
1683:                 loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
1684:                 loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
1685:                 loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
1686:                 loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
1687:                 loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
1688:             ENDIF
1689: 
1690:             IF loc_oBO.this_lProcessarCusto
1691:                 loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
1692:                 loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
1693:                 loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
1694:                 loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
1695:             ENDIF
1696: 
1697:             IF loc_oBO.this_lProcessarCompra
1698:                 loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
1699:                 loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
1700:                 loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
1701:                 loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
1702:             ENDIF
1703:         CATCH TO loc_oErro
1704:             MsgErro(loc_oErro.Message, "Erro")
1705:         ENDTRY
1706:     ENDPROC
1707: 
1708:     *--------------------------------------------------------------------------
1709:     PROCEDURE BOParaForm()
1710:     *  Transfere resultados do BO de volta para os campos visuais.
1711:     *  Para o form OPERACIONAL: exibe o contador de registros processados
1712:     *  e o label de conclusao quando houver resultado.
1713:     *--------------------------------------------------------------------------
1714:         LOCAL loc_oBO, loc_oErro
1715:         TRY
1716:             loc_oBO = THIS.this_oBusinessObject
1717:             IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
1718:                 RETURN
1719:             ENDIF
1720:             THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
1721:             THIS.lbl_4c_LblEnd.Visible = (loc_oBO.this_nRegistros > 0)
1722:         CATCH TO loc_oErro
1723:             MsgErro(loc_oErro.Message, "Erro")
1724:         ENDTRY
1725:     ENDPROC
1726: 
1727:     *--------------------------------------------------------------------------
1728:     PROCEDURE LimparCampos()
1729:     *  Limpa todos os campos de entrada nos 4 containers de opcoes e
1730:     *  redefine flags/checkboxes para o estado inicial (sem selecao).
1731:     *--------------------------------------------------------------------------
1732:         LOCAL loc_oErro
1733:         TRY
1734:             *-- Checkboxes
1735:             THIS.chk_4c_Conta.Value     = 0
1736:             THIS.chk_4c_Estoque.Value   = 0
1737:             THIS.chk_4c_BtnCusto.Value  = 0
1738:             THIS.chk_4c_BtnCompra.Value = 0
1739: 
1740:             *-- Campos de Conta Corrente
1741:             THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value = ""
1742:             THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value  = ""
1743:             THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value  = ""
1744:             THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value  = ""
1745:             THIS.cnt_4c_OpConta.txt_4c_DataConta.Value    = {}
1746: 
1747:             *-- Campos de Estoque
1748:             THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value = ""
1749:             THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value  = ""
1750:             THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value = ""
1751:             THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value = ""
1752:             THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value   = ""
1753:             THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value    = {}
1754: 
1755:             *-- Campos de Custo
1756:             THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value = ""
1757:             THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value = ""
1758:             THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value   = ""
1759:             THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value    = {}
1760: 
1761:             *-- Campos de Ultima Compra
1762:             THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value = ""
1763:             THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value = ""
1764:             THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value   = ""
1765:             THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value    = {}
1766: 
1767:             *-- Rodape
1768:             THIS.txt_4c_Registro.Value = 0
1769:             THIS.lbl_4c_LblEnd.Visible = .F.
1770: 
1771:             *-- Oculta containers flutuantes
1772:             THIS.cnt_4c_OpConta.Visible   = .F.
1773:             THIS.cnt_4c_OpEstoque.Visible = .F.
1774:             THIS.cnt_4c_OpCusto.Visible   = .F.
1775:             THIS.cnt_4c_OpCompra.Visible  = .F.
1776: 
1777:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1778:                 THIS.this_oBusinessObject.this_nRegistros = 0
1779:             ENDIF
1780:         CATCH TO loc_oErro
1781:             MsgErro(loc_oErro.Message, "Erro")
1782:         ENDTRY
1783:     ENDPROC
1784: 
1785:     *--------------------------------------------------------------------------
1786:     PROCEDURE HabilitarCampos(par_lHabilitar)
1787:     *  Habilita ou desabilita todos os controles de entrada do form.
1788:     *  Chamado por AlternarPagina para bloquear durante o processamento.
1789:     *--------------------------------------------------------------------------
1790:         LOCAL loc_oErro
1791:         TRY
1792:             THIS.chk_4c_Conta.Enabled     = par_lHabilitar
1793:             THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
1794:             THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
1795:             THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
1796:             THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar
1797: 
1798:             IF par_lHabilitar
1799:                 *-- Ao habilitar, Processar depende da selecao dos checkboxes
1800:                 THIS.AtualizarBotaoProcessar()
1801:             ELSE
1802:                 THIS.cmd_4c_Processar.Enabled = .F.
1803:             ENDIF
1804:         CATCH TO loc_oErro
1805:             MsgErro(loc_oErro.Message, "Erro")
1806:         ENDTRY
1807:     ENDPROC
1808: 
1809:     *--------------------------------------------------------------------------
1810:     PROCEDURE AjustarBotoesPorModo()
1811:     *  Atualiza o estado do botao Processar conforme selecao atual.
1812:     *  Alias de AtualizarBotaoProcessar() para compatibilidade com
1813:     *  o padrao do pipeline de migracao.
1814:     *--------------------------------------------------------------------------
1815:         THIS.AtualizarBotaoProcessar()
1816:     ENDPROC
1817: 
1818:     *--------------------------------------------------------------------------
1819:     PROCEDURE CarregarLista()
1820:     *  Reinicia o form para o estado inicial: desmarca checkboxes, oculta
1821:     *  containers de opcoes e zera o contador. Equivalente ao "recarregar
1822:     *  a lista" nos forms CRUD, adaptado para o form OPERACIONAL flat.
1823:     *--------------------------------------------------------------------------
1824:         LOCAL loc_oErro
1825:         TRY
1826:             THIS.ConfigurarPaginaLista()
1827:             THIS.Refresh()
1828:         CATCH TO loc_oErro
1829:             MsgErro(loc_oErro.Message, "Erro")
1830:         ENDTRY
1831:     ENDPROC
1832: 
1833:     *--------------------------------------------------------------------------
1834:     PROCEDURE BtnBuscarClick()
1835:     *  Para o form OPERACIONAL: exibe o resumo do estado atual (opcoes
1836:     *  selecionadas e registros do ultimo processamento). Equivalente ao
1837:     *  "Buscar / Visualizar" nos forms CRUD.
1838:     *--------------------------------------------------------------------------
1839:         THIS.BtnVisualizarClick()
1840:     ENDPROC
1841: 
1842:     *--------------------------------------------------------------------------
1843:     PROCEDURE BtnEncerrarClick()
1844:     *  Fecha o form OPERACIONAL. Alias de CmdEncerrarClick() para
1845:     *  compatibilidade com o padrao do pipeline de migracao.
1846:     *--------------------------------------------------------------------------
1847:         THIS.CmdEncerrarClick()
1848:     ENDPROC
1849: 
1850:     *--------------------------------------------------------------------------
1851:     PROCEDURE BtnSalvarClick()
1852:     *  Para o form OPERACIONAL: dispara o processamento de recalculo.
1853:     *  Equivale ao "Salvar" nos forms CRUD, adaptado para este contexto.
1854:     *  Valida selecao antes de processar.
1855:     *--------------------------------------------------------------------------
1856:         LOCAL loc_oErro
1857:         TRY
1858:             IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
1859:                THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
1860:                 MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + ;
1861:                          "o de processamento.", "Rec" + CHR(225) + "lculo de Saldos")
1862:                 RETURN
1863:             ENDIF
1864:             THIS.FormParaBO()
1865:             THIS.lbl_4c_LblEnd.Visible = .F.
1866:             THIS.txt_4c_Registro.Value = 0
1867:             THIS.CmdProcessarClick()
1868:         CATCH TO loc_oErro
1869:             MsgErro(loc_oErro.Message, "Erro ao processar")
1870:         ENDTRY
1871:     ENDPROC
1872: 
1873:     *--------------------------------------------------------------------------
1874:     PROCEDURE BtnCancelarClick()
1875:     *  Para o form OPERACIONAL: limpa todas as selecoes e reinicia o form
1876:     *  para o estado inicial. Equivale ao "Cancelar" nos forms CRUD.
1877:     *--------------------------------------------------------------------------
1878:         LOCAL loc_oErro
1879:         TRY
1880:             IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + ;
1881:                             "es e reiniciar?", "Rec" + CHR(225) + "lculo de Saldos")
1882:                 RETURN
1883:             ENDIF
1884:             THIS.LimparCampos()
1885:             THIS.AjustarBotoesPorModo()
1886:             THIS.Refresh()
1887:         CATCH TO loc_oErro
1888:             MsgErro(loc_oErro.Message, "Erro ao cancelar")
1889:         ENDTRY
1890:     ENDPROC
1891: 
1892:     *--------------------------------------------------------------------------
1893:     PROCEDURE Destroy()
1894:     *--------------------------------------------------------------------------
1895:         LOCAL loc_oErro
1896:         TRY
1897:             IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
1898:                 THIS.this_oBusinessObject = .NULL.
1899:             ENDIF
1900:         CATCH TO loc_oErro
1901:             MsgErro(loc_oErro.Message, "Erro")
1902:         ENDTRY
1903:         DODEFAULT()
1904:     ENDPROC
1905: 
1906: ENDDEFINE


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

