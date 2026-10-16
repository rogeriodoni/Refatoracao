# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_BARRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1698 linhas total):

*-- Linhas 25 a 294:
25: *   - BtnExportaClick   -> Exporta.Click      (IMPORTA planilha XLS - nome legado)
26: *   - BtnProcessarClick -> btnProcessar.Click (troca em lote / so representantes)
27: *   - BtnSairClick      -> btnSair.Click      (ThisForm.Release)
28: * Todos PUBLIC (regra #3/#51: BINDEVENT e chamada externa falham em PROTECTED) e
29: * ligados por BINDEVENT em ConfigurarBotoes(). O DELETE local da grade depende do
30: * `SET DELETED ON` reposto em InicializarForm (regra #9.4: DataSession = 2 nasce
31: * no default do VFP e nao herda o SET do config.prg).
32: *==============================================================================
33: 
34: DEFINE CLASS FormSigPrMdc AS FormBase
35: 
36:     Width       = 800
37:     Height      = 340
38:     Caption     = "Muda Conta"
39:     ShowWindow  = 1
40:     WindowType  = 1
41:     TitleBar    = 0
42:     ControlBox  = .F.
43:     Closable    = .F.
44:     MaxButton   = .F.
45:     MinButton   = .F.
46:     AutoCenter  = .T.
47:     BorderStyle = 2
48:     Themes      = .F.
49:     DataSession = 2
50:     KeyPreview  = .T.
51: 
52:     *-- Business Object
53:     this_oBusinessObject = .NULL.
54: 
55:     *-- Flag de controle (legado: Lparameters pCheckCad / ThisForm.Checkcadpro)
56:     this_lCheckCadPro = .F.
57: 
58:     *-- Caminho do ArqDBF (tabela FoxPro de catalogo de campos usada no
59:     *-- processamento em lote)
60:     this_cArqDBFPath = ""
61: 
62:     *-- Estado da tela. O legado NAO tem pcEscolha (nao herda de frmcadastro e
63:     *-- nao tem modos CRUD): os unicos dois estados reais sao "EDICAO" (usuario
64:     *-- monta a lista de pares) e "PROCESSANDO" (SCAN multi-tabela em curso, com
65:     *-- grade e botoes travados). AjustarBotoesPorModo eh o funil desses dois.
66:     this_cModoAtual = "EDICAO"
67: 
68:     *==========================================================================
69:     * Init - Legado: "Lparameters pCheckCad / ThisForm.Checkcadpro = pCheckCad".
70:     * O parametro vem de quem abre a tela e decide se os codigos digitados sao
71:     * conferidos contra SigCdCli: com .T. o lookup da coluna "Conta Antiga" eh
72:     * pulado e a importacao de planilha aceita conta que nao existe no cadastro.
73:     * Tem de ser atribuido ANTES do DODEFAULT: eh dentro dele que FormBase.Init
74:     * chama InicializarForm, que ja leva o valor para o BO via FormParaBO.
75:     *==========================================================================
76:     PROCEDURE Init(par_lCheckCad)
77:     *==========================================================================
78:         THIS.this_lCheckCadPro = IIF(VARTYPE(par_lCheckCad) = "L", par_lCheckCad, .F.)
79: 
80:         RETURN DODEFAULT()
81:     ENDPROC
82: 
83:     *==========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:     *==========================================================================
86:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
87:         THIS.ScrollBars = 0
88:         THIS.ShowTips   = .T.
89:     ENDPROC
90: 
91:     *==========================================================================
92:     PROTECTED PROCEDURE InicializarForm()
93:     *==========================================================================
94:         LOCAL loc_lSucesso, loc_oErro, loc_cArquivo
95:         loc_lSucesso = .F.
96: 
97:         TRY
98:             THIS.ConfigurarPageFrame()
99: 
100:             *-- DataSession=2 nasce no default do VFP (regra #9.4 / DELETED e
101:             *-- EXACT nao herdam o SET DELETED ON do config.prg): sem isto o
102:             *-- DELETE local em cursor_4c_Contas nao some da grade em BtnExcluirClick
103:             SET DELETED ON
104: 
105:             *-- Legado: primeira linha do Load eh "=fConfigGeral()" (carrega os
106:             *-- parametros gerais do sistema que o processamento consome).
107:             *-- Wrapper portado em projeto\app\utils\fconfiggeral.prg
108:             TRY
109:                 = fConfigGeral()
110:             CATCH TO loc_oErro
111:                 MsgAviso("Falha ao carregar a configura" + CHR(231) + CHR(227) + ;
112:                     "o geral: " + loc_oErro.Message, "Aten" + CHR(231) + CHR(227) + "o")
113:             ENDTRY
114: 
115:             *-- Verificar existencia do ArqDBF (catalogo de campos do
116:             *-- processamento em lote): aviso informativo, nao bloqueia o Init
117:             loc_cArquivo = SYS(5) + SYS(2003) + "\ArqDBF"
118:             IF FILE(loc_cArquivo + ".dbf")
119:                 THIS.this_cArqDBFPath = loc_cArquivo
120:             ELSE
121:                 MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + " no diret" + CHR(243) + "rio do Sistema!!!", ;
122:                     "Aten" + CHR(231) + CHR(227) + "o")
123:             ENDIF
124: 
125:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrMdcBO")
126:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
127:                 MsgErro("Erro ao criar SigPrMdcBO.", "Erro InicializarForm")
128:             ELSE
129:                 IF !THIS.this_oBusinessObject.InicializarCursorContas()
130:                     MsgErro("Falha ao inicializar cursor de substitui" + CHR(231) + CHR(245) + "es.", ;
131:                         "Erro InicializarForm")
132:                 ELSE
133:                     THIS.ConfigurarCabecalho()
134:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
135:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
136: 
137:                     THIS.ConfigurarBotoes()
138:                     THIS.ConfigurarGrid()
139:                     THIS.ConfigurarCheckboxes()
140:                     THIS.ConfigurarPainelResultado()
141:                     THIS.ConfigurarTabIndex()
142: 
143:                     THIS.TornarControlesVisiveis(THIS)
144: 
145:                     *-- Pintura inicial da grade pelo mesmo funil usado pelos
146:                     *-- demais caminhos (cursor ja populado por
147:                     *-- InicializarCursorContas, chamado acima)
148:                     THIS.CarregarLista("TOPO")
149: 
150:                     *-- Estado inicial pelo funil: aplica tambem a dependencia do
151:                     *-- Chk_DelCT.When do legado (so clicavel com chkReps = 0)
152:                     THIS.this_cModoAtual = "EDICAO"
153:                     THIS.AjustarBotoesPorModo()
154: 
155:                     *-- Sincroniza o BO com o estado inicial da tela (os dois
156:                     *-- flags de processamento, CheckCadPro e o caminho do ArqDBF)
157:                     THIS.FormParaBO()
158: 
159:                     *-- Legado: "ThisForm.Grade.Column1.SetFocus" no fim do Init.
160:                     *-- O Init roda ANTES do Show, entao a janela ainda pode nao
161:                     *-- estar visivel e o VFP9 recusa o foco ("Cannot SetFocus to
162:                     *-- an invisible or disabled object"). Falhar aqui eh inocuo -
163:                     *-- o foco certo vem do TabIndex = 1 da grade - e NAO deve
164:                     *-- abrir dialogo de erro na abertura da tela
165:                     TRY
166:                         THIS.grd_4c_Dados.Column1.SetFocus
167:                     CATCH TO loc_oErro
168:                         *-- foco inicial indisponivel antes do Show: ignorado de
169:                         *-- proposito (TabIndex = 1 ja poe o cursor na grade)
170:                     ENDTRY
171: 
172:                     loc_lSucesso = .T.
173:                 ENDIF
174:             ENDIF
175:         CATCH TO loc_oErro
176:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
177:                 " PROC=" + loc_oErro.Procedure, "Erro InicializarForm FormSigPrMdc")
178:         ENDTRY
179: 
180:         RETURN loc_lSucesso
181:     ENDPROC
182: 
183:     *==========================================================================
184:     * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com os
185:     * dois labels empilhados (lblSombra = sombra / lblTitulo = texto visivel)
186:     *==========================================================================
187:     PROTECTED PROCEDURE ConfigurarCabecalho()
188:     *==========================================================================
189:         LOCAL loc_oErro
190: 
191:         TRY
192:             *-- Container do cabecalho (cntSombra do legado)
193:             THIS.AddObject("cnt_4c_Sombra", "Container")
194:             WITH THIS.cnt_4c_Sombra
195:                 .Top         = 0
196:                 .Left        = 0
197:                 .Width       = THIS.Width
198:                 .Height      = 80
199:                 .BackStyle   = 1
200:                 .BackColor   = RGB(100, 100, 100)
201:                 .BorderWidth = 0
202:                 .Visible     = .T.
203:             ENDWITH
204: 
205:             *-- Label sombra - efeito de sombra no titulo (lblSombra do legado)
206:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
207:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
208:                 .AutoSize  = .F.
209:                 .FontBold  = .T.
210:                 .FontName  = "Tahoma"
211:                 .FontSize  = 18
212:                 .WordWrap  = .T.
213:                 .Alignment = 0
214:                 .BackStyle = 0
215:                 .Caption   = THIS.Caption
216:                 .Height    = 40
217:                 .Left      = 10
218:                 .Top       = 18
219:                 .Width     = THIS.cnt_4c_Sombra.Width
220:                 .ForeColor = RGB(0, 0, 0)
221:             ENDWITH
222: 
223:             *-- Label titulo - texto visivel sobre a sombra (lblTitulo do legado)
224:             THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
225:             WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
226:                 .AutoSize    = .F.
227:                 .FontBold    = .T.
228:                 .FontName    = "Tahoma"
229:                 .FontSize    = 18
230:                 .WordWrap    = .T.
231:                 .Alignment   = 0
232:                 .BackStyle   = 0
233:                 .Caption     = THIS.Caption
234:                 .Height      = 46
235:                 .Left        = 10
236:                 .Top         = 17
237:                 .Width       = THIS.cnt_4c_Sombra.Width
238:                 .ForeColor   = RGB(255, 255, 255)
239:                 .ToolTipText = "T" + CHR(237) + "tulo"
240:             ENDWITH
241: 
242:         CATCH TO loc_oErro
243:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
244:                 "Erro ConfigurarCabecalho FormSigPrMdc")
245:         ENDTRY
246:     ENDPROC
247: 
248:     *==========================================================================
249:     * ConfigurarBotoes - Molduras decorativas (Commandgroup1/3 do legado, sem
250:     * botoes internos - ButtonCount=0 no SCX) + os 5 CommandButtons standalone
251:     * (btnIncluir/btnExcluir/Exporta/btnProcessar/btnSair do legado), todos
252:     * filhos diretos do form, posicionados sobre as molduras
253:     *==========================================================================
254:     PROTECTED PROCEDURE ConfigurarBotoes()
255:     *==========================================================================
256:         LOCAL loc_oErro
257: 
258:         TRY
259:             *-- Moldura decorativa em volta de Incluir/Excluir/Importar/Processar
260:             THIS.AddObject("obj_4c_Commandgroup1", "Container")
261:             WITH THIS.obj_4c_Commandgroup1
262:                 .Top         = 8
263:                 .Left        = 329
264:                 .Width       = 331
265:                 .Height      = 110
266:                 .BackStyle   = 0
267:                 .BorderWidth = 0
268:                 .Visible     = .T.
269:             ENDWITH
270: 
271:             *-- Moldura decorativa em volta do Sair/Encerrar
272:             THIS.AddObject("obj_4c_Commandgroup3", "Container")
273:             WITH THIS.obj_4c_Commandgroup3
274:                 .Top         = 8
275:                 .Left        = 703
276:                 .Width       = 90
277:                 .Height      = 110
278:                 .BackStyle   = 0
279:                 .BorderWidth = 0
280:                 .Visible     = .T.
281:             ENDWITH
282: 
283:             THIS.AddObject("cmd_4c_BtnIncluir", "CommandButton")
284:             WITH THIS.cmd_4c_BtnIncluir
285:                 .Top        = 3
286:                 .Left       = 425
287:                 .Width      = 80
288:                 .Height     = 100
289:                 .FontBold   = .T.
290:                 .FontItalic = .T.
291:                 .FontName   = "Comic Sans MS"
292:                 .FontSize   = 8
293:                 .WordWrap   = .T.
294:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 381 a 440:
381:                 .Visible    = .T.
382:             ENDWITH
383: 
384:             BINDEVENT(THIS.cmd_4c_BtnIncluir,   "Click", THIS, "BtnIncluirClick")
385:             BINDEVENT(THIS.cmd_4c_BtnExcluir,   "Click", THIS, "BtnExcluirClick")
386:             BINDEVENT(THIS.cmd_4c_Exporta,      "Click", THIS, "BtnExportaClick")
387:             BINDEVENT(THIS.cmd_4c_BtnProcessar, "Click", THIS, "BtnProcessarClick")
388:             BINDEVENT(THIS.cmd_4c_BtnSair,      "Click", THIS, "BtnSairClick")
389: 
390:         CATCH TO loc_oErro
391:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
392:                 "Erro ConfigurarBotoes FormSigPrMdc")
393:         ENDTRY
394:     ENDPROC
395: 
396:     *==========================================================================
397:     * ConfigurarGrid - Grade de pares Conta Antiga/Conta Nova (Grade do legado),
398:     * ligada ao cursor cursor_4c_Contas criado por SigPrMdcBO.InicializarCursorContas()
399:     *==========================================================================
400:     PROTECTED PROCEDURE ConfigurarGrid()
401:     *==========================================================================
402:         LOCAL loc_oErro
403: 
404:         TRY
405:             THIS.AddObject("grd_4c_Dados", "Grid")
406:             WITH THIS.grd_4c_Dados
407:                 .Top                = 111
408:                 .Left               = 170
409:                 .Width              = 213
410:                 .Height             = 201
411:                 .ColumnCount        = 2
412:                 .AllowHeaderSizing  = .F.
413:                 .AllowRowSizing     = .F.
414:                 .DeleteMark         = .F.
415:                 .RecordMark         = .F.
416:                 .HeaderHeight       = 18
417:                 .RowHeight          = 18
418:                 .ScrollBars         = 2
419:                 .FontName           = "Tahoma"
420:                 .FontSize           = 8
421:                 .GridLineColor      = RGB(238, 238, 238)
422:                 .HighlightBackColor = RGB(90, 90, 90)
423:                 .RecordSource       = "cursor_4c_Contas"
424: 
425:                 WITH .Column1
426:                     .ControlSource = "cursor_4c_Contas.ContaAnt"
427:                     .Width         = 90
428:                     WITH .Header1
429:                         .FontName  = "Tahoma"
430:                         .FontSize  = 8
431:                         .Alignment = 2
432:                         .Caption   = "Conta Antiga"
433:                         .ForeColor = RGB(0, 0, 0)
434:                     ENDWITH
435:                     WITH .Text1
436:                         .BorderStyle = 0
437:                         .Margin      = 0
438:                         .ForeColor   = RGB(0, 0, 0)
439:                         .BackColor   = RGB(255, 255, 255)
440:                     ENDWITH

*-- Linhas 461 a 571:
461:                 .Visible = .T.
462:             ENDWITH
463: 
464:             BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtContaAntKeyPress")
465:             BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtContaNovKeyPress")
466: 
467:         CATCH TO loc_oErro
468:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
469:                 "Erro ConfigurarGrid FormSigPrMdc")
470:         ENDTRY
471:     ENDPROC
472: 
473:     *==========================================================================
474:     * ConfigurarCheckboxes - Chk_DelCT (apagar conta antiga) e chkReps (trocar
475:     * so representantes) do legado. AutoSize=.T. no SCX e no-op em CheckBox
476:     * criado por AddObject - Width/Height ja sao os valores auto-calculados
477:     * pelo Form Designer, transcritos literalmente.
478:     *==========================================================================
479:     PROTECTED PROCEDURE ConfigurarCheckboxes()
480:     *==========================================================================
481:         LOCAL loc_oErro
482: 
483:         TRY
484:             THIS.AddObject("chk_4c_Chk_DelCT", "CheckBox")
485:             WITH THIS.chk_4c_Chk_DelCT
486:                 .Top       = 278
487:                 .Left      = 393
488:                 .Width     = 190
489:                 .Height    = 15
490:                 .FontName  = "Tahoma"
491:                 .FontSize  = 8
492:                 .AutoSize  = .F.
493:                 .Alignment = 0
494:                 .BackStyle = 0
495:                 .Caption   = "Apagar a Conta Antiga do Cadastro"
496:                 .Value     = 0
497:                 .ForeColor = RGB(90, 90, 90)
498:                 .Visible   = .T.
499:             ENDWITH
500: 
501:             THIS.AddObject("chk_4c_ChkReps", "CheckBox")
502:             WITH THIS.chk_4c_ChkReps
503:                 .Top       = 297
504:                 .Left      = 393
505:                 .Width     = 168
506:                 .Height    = 15
507:                 .FontName  = "Tahoma"
508:                 .FontSize  = 8
509:                 .AutoSize  = .F.
510:                 .Alignment = 0
511:                 .BackStyle = 0
512:                 .Caption   = "Trocar Apenas Representantes"
513:                 .Value     = 0
514:                 .ForeColor = RGB(90, 90, 90)
515:                 .Visible   = .T.
516:             ENDWITH
517: 
518:             BINDEVENT(THIS.chk_4c_ChkReps, "Click", THIS, "ChkRepsClick")
519: 
520:         CATCH TO loc_oErro
521:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
522:                 "Erro ConfigurarCheckboxes FormSigPrMdc")
523:         ENDTRY
524:     ENDPROC
525: 
526:     *==========================================================================
527:     * ConfigurarPainelResultado - Painel de progresso (cntResult do legado),
528:     * oculto por padrao (regra containers flutuantes) e exibido so durante
529:     * BtnProcessarClick
530:     *==========================================================================
531:     PROTECTED PROCEDURE ConfigurarPainelResultado()
532:     *==========================================================================
533:         LOCAL loc_oErro
534: 
535:         TRY
536:             THIS.AddObject("cnt_4c_Result", "Container")
537:             WITH THIS.cnt_4c_Result
538:                 .Top           = 112
539:                 .Left          = 393
540:                 .Width         = 237
541:                 .Height        = 146
542:                 .SpecialEffect = 0
543:                 .BackStyle     = 1
544:                 .BackColor     = RGB(255, 255, 255)
545:                 .Visible       = .F.
546:             ENDWITH
547: 
548:             THIS.cnt_4c_Result.AddObject("lbl_4c_Label5", "Label")
549:             WITH THIS.cnt_4c_Result.lbl_4c_Label5
550:                 .Top       = 9
551:                 .Left      = 7
552:                 .Width     = 110
553:                 .Height    = 14
554:                 .FontName  = "Tahoma"
555:                 .FontSize  = 8
556:                 .AutoSize  = .F.
557:                 .Alignment = 0
558:                 .BackStyle = 0
559:                 .Caption   = "Arquivo/Campo :"
560:                 .ForeColor = RGB(90, 90, 90)
561:             ENDWITH
562: 
563:             THIS.cnt_4c_Result.AddObject("txt_4c_Arquivo", "TextBox")
564:             WITH THIS.cnt_4c_Result.txt_4c_Arquivo
565:                 .Top               = 26
566:                 .Left              = 7
567:                 .Width             = 222
568:                 .Height            = 24
569:                 .FontName          = "Tahoma"
570:                 .FontSize          = 8
571:                 .Alignment         = 3

*-- Linhas 643 a 724:
643:     * legado (Grade primeiro - mesmo foco inicial do Init legado - depois a
644:     * barra de botoes esquerda->direita, depois os checkboxes de cima->baixo)
645:     *==========================================================================
646:     PROTECTED PROCEDURE ConfigurarTabIndex()
647:     *==========================================================================
648:         THIS.grd_4c_Dados.TabIndex        = 1
649:         THIS.cmd_4c_BtnIncluir.TabIndex    = 2
650:         THIS.cmd_4c_BtnExcluir.TabIndex    = 3
651:         THIS.cmd_4c_Exporta.TabIndex       = 4
652:         THIS.cmd_4c_BtnProcessar.TabIndex  = 5
653:         THIS.cmd_4c_BtnSair.TabIndex       = 6
654:         THIS.chk_4c_Chk_DelCT.TabIndex     = 7
655:         THIS.chk_4c_ChkReps.TabIndex       = 8
656:     ENDPROC
657: 
658:     *==========================================================================
659:     * CarregarLista - FUNIL UNICO de (re)vinculo e repintura da grade de pares.
660:     * Popular/alterar o cursor NAO repinta a grade sozinho: o legado fecha todo
661:     * caminho que mexe em cursor_4c_Contas com Grade.Refresh (btnIncluir/btnExcluir/
662:     * Exporta/btnProcessar). Centralizado aqui para que nenhum caminho fique
663:     * sem repintura - os Valid de Column1/Column2.Text1 do legado faziam
664:     * REPLACE no cursor e dependiam da repintura da grade para o valor
665:     * resolvido aparecer na celula.
666:     *
667:     * Reaplica ControlSource/Width/Header1.Caption DEPOIS do RecordSource:
668:     * atribuir RecordSource recalcula as larguras para o default 90 e zera os
669:     * captions para "Header1" (Problema 48), entao a apresentacao canonica tem
670:     * de ser restaurada no MESMO lugar, na ordem RecordSource -> ControlSource
671:     * -> Width -> Header1.Caption.
672:     *
673:     * ColumnCount NAO eh reatribuido aqui: qualquer atribuicao a ColumnCount
674:     * recria os objetos Column e derrubaria os BINDEVENT instalados em
675:     * Column1.Text1/Column2.Text1 por ConfigurarGrid (os lookups de celula).
676:     *
677:     * par_cPosicao reproduz o posicionamento de CADA caminho do legado:
678:     *   "TOPO" -> Go Top  (reset do lote em btnProcessar.Click)
679:     *   "FIM"  -> Go Bott (fim da importacao de planilha, Exporta.Click)
680:     *   ""     -> mantem o registro corrente (btnIncluir/btnExcluir/Valid, que
681:     *             no legado chamam Grade.Refresh sem reposicionar - um Go Top
682:     *             indevido tiraria o foco da linha recem-incluida)
683:     *==========================================================================
684:     PROCEDURE CarregarLista(par_cPosicao)
685:     *==========================================================================
686:         LOCAL loc_lSucesso, loc_cPos, loc_oGrid, loc_oErro
687:         loc_lSucesso = .F.
688: 
689:         loc_cPos = IIF(VARTYPE(par_cPosicao) = "C", UPPER(ALLTRIM(par_cPosicao)), "")
690: 
691:         TRY
692:             *-- Cursor ausente (form reaberto / alias fechado por outro fluxo):
693:             *-- recriar pelo BO, que eh quem detem a estrutura e os indices
694:             IF !USED("cursor_4c_Contas")
695:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
696:                     THIS.this_oBusinessObject.InicializarCursorContas()
697:                 ENDIF
698:             ENDIF
699: 
700:             IF USED("cursor_4c_Contas")
701:                 loc_oGrid = THIS.grd_4c_Dados
702: 
703:                 loc_oGrid.RecordSource = "cursor_4c_Contas"
704: 
705:                 loc_oGrid.Column1.ControlSource   = "cursor_4c_Contas.ContaAnt"
706:                 loc_oGrid.Column1.Width           = 90
707:                 loc_oGrid.Column1.Header1.Caption = "Conta Antiga"
708: 
709:                 loc_oGrid.Column2.ControlSource   = "cursor_4c_Contas.ContaNov"
710:                 loc_oGrid.Column2.Width           = 90
711:                 loc_oGrid.Column2.Header1.Caption = "Conta Nova"
712: 
713:                 SELECT cursor_4c_Contas
714:                 DO CASE
715:                     CASE loc_cPos == "TOPO"
716:                         GO TOP
717:                     CASE loc_cPos == "FIM"
718:                         GO BOTTOM
719:                 ENDCASE
720: 
721:                 loc_oGrid.Refresh
722:                 loc_lSucesso = .T.
723:             ENDIF
724:         CATCH TO loc_oErro

*-- Linhas 733 a 1112:
733:     * BtnIncluirClick - Acrescenta uma linha vazia ao cursor de pares (so se o
734:     * ultimo par ja estiver completo), e foca a primeira coluna da nova linha
735:     *==========================================================================
736:     PROCEDURE BtnIncluirClick()
737:     *==========================================================================
738:         LOCAL loc_oErro, loc_nRec
739: 
740:         TRY
741:             loc_nRec = 0
742: 
743:             IF USED("cursor_4c_Contas")
744:                 SELECT cursor_4c_Contas
745:                 IF !EMPTY(ALLTRIM(NVL(ContaAnt, ""))) AND !EMPTY(ALLTRIM(NVL(ContaNov, "")))
746:                     APPEND BLANK
747:                 ENDIF
748:                 *-- O legado fecha com "Grade.Refresh", que NAO move o ponteiro:
749:                 *-- depois do APPEND BLANK ele fica na linha NOVA, e eh nela que o
750:                 *-- SetFocus abaixo poe o usuario para digitar. CarregarLista
751:                 *-- reatribui o RecordSource, e isso devolve o ponteiro ao registro
752:                 *-- 1 (medido no VFP9) - sem guardar/repor o RECNO o usuario clica
753:                 *-- Incluir e cai na PRIMEIRA linha, ja preenchida, em vez da nova.
754:                 *-- Vale nos dois ramos: quando a guarda acima bloqueia o APPEND, o
755:                 *-- legado tambem deixa o ponteiro onde estava.
756:                 loc_nRec = RECNO()
757:             ENDIF
758: 
759:             THIS.CarregarLista("")
760: 
761:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
762:                 SELECT cursor_4c_Contas
763:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
764:                     GO loc_nRec
765:                 ENDIF
766:             ENDIF
767: 
768:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
769:         CATCH TO loc_oErro
770:             MsgErro(loc_oErro.Message, "Erro ao incluir linha")
771:         ENDTRY
772:     ENDPROC
773: 
774:     *==========================================================================
775:     * BtnExcluirClick - Remove a linha corrente do cursor de pares
776:     *==========================================================================
777:     PROCEDURE BtnExcluirClick()
778:     *==========================================================================
779:         LOCAL loc_oErro, loc_nRec
780: 
781:         TRY
782:             loc_nRec = 0
783: 
784:             IF USED("cursor_4c_Contas")
785:                 SELECT cursor_4c_Contas
786:                 IF !EOF()
787:                     DELETE
788:                 ENDIF
789:                 *-- Mesma razao do BtnIncluirClick: o "Grade.Refresh" do legado
790:                 *-- nao move o ponteiro, mas CarregarLista reatribui o
791:                 *-- RecordSource e o devolve ao registro 1. Repor o RECNO mantem
792:                 *-- o usuario na vizinhanca da linha que ele acabou de apagar
793:                 *-- (com SET DELETED ON a propria linha apagada ja nao eh
794:                 *-- navegavel, e a grade passa a mostrar a seguinte)
795:                 loc_nRec = RECNO()
796:             ENDIF
797: 
798:             THIS.CarregarLista("")
799: 
800:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
801:                 SELECT cursor_4c_Contas
802:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
803:                     GO loc_nRec
804:                 ENDIF
805:             ENDIF
806: 
807:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
808:         CATCH TO loc_oErro
809:             MsgErro(loc_oErro.Message, "Erro ao excluir linha")
810:         ENDTRY
811:     ENDPROC
812: 
813:     *==========================================================================
814:     * BtnSairClick - Encerra o form (btnSair.Click do legado)
815:     *==========================================================================
816:     PROCEDURE BtnSairClick()
817:     *==========================================================================
818:         THIS.Release
819:     ENDPROC
820: 
821:     *==========================================================================
822:     * ChkRepsClick - Ligar "Trocar Apenas Representantes" desliga e desabilita
823:     * "Apagar a Conta Antiga do Cadastro" (chkReps.Click + Chk_DelCT.When do
824:     * legado: Chk_DelCT so pode ser marcado quando chkReps = 0)
825:     *==========================================================================
826:     PROCEDURE ChkRepsClick()
827:     *==========================================================================
828:         IF THIS.chk_4c_ChkReps.Value = 1
829:             THIS.chk_4c_Chk_DelCT.Value = 0
830:         ENDIF
831:         THIS.chk_4c_Chk_DelCT.Enabled = (THIS.chk_4c_ChkReps.Value = 0)
832:     ENDPROC
833: 
834:     *==========================================================================
835:     * TxtContaAntKeyPress - Lookup de conta na coluna "Conta Antiga" (Column1).
836:     * Legado: Valid do Column1.Text1, pulado quando this_lCheckCadPro = .T.
837:     *==========================================================================
838:     PROCEDURE TxtContaAntKeyPress
839:     *==========================================================================
840:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
841: 
842:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
843:             RETURN
844:         ENDIF
845: 
846:         IF THIS.this_lCheckCadPro
847:             RETURN
848:         ENDIF
849: 
850:         THIS.ValidarCelulaConta(1)
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * TxtContaNovKeyPress - Lookup de conta na coluna "Conta Nova" (Column2).
855:     * Legado: Valid do Column2.Text1, sempre executa (sem guarda de CheckCadPro)
856:     *==========================================================================
857:     PROCEDURE TxtContaNovKeyPress
858:     *==========================================================================
859:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
860: 
861:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
862:             RETURN
863:         ENDIF
864: 
865:         THIS.ValidarCelulaConta(2)
866:     ENDPROC
867: 
868:     *==========================================================================
869:     * ValidarCelulaConta - Valida o codigo digitado na celula (1=ContaAnt,
870:     * 2=ContaNov) contra SigCdCli; achando, grava no cursor; nao achando, abre
871:     * o picker (FormBuscaAuxiliar) com o digitado como prefixo
872:     *==========================================================================
873:     PROCEDURE ValidarCelulaConta(par_nColuna)
874:     *==========================================================================
875:         LOCAL loc_cVal, loc_oErro, loc_oColuna, loc_cCampo
876: 
877:         IF par_nColuna = 1
878:             loc_oColuna = THIS.grd_4c_Dados.Column1
879:             loc_cCampo  = "ContaAnt"
880:         ELSE
881:             loc_oColuna = THIS.grd_4c_Dados.Column2
882:             loc_cCampo  = "ContaNov"
883:         ENDIF
884: 
885:         loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))
886: 
887:         TRY
888:             IF EMPTY(loc_cVal)
889:                 SELECT cursor_4c_Contas
890:                 REPLACE (loc_cCampo) WITH ""
891:             ELSE
892:                 *-- ValidarCodigoConta devolve o CODIGO achado (string) ou "",
893:                 *-- nunca um logico: usar o retorno direto num IF estouraria
894:                 *-- "Operator/operand type mismatch"
895:                 IF !EMPTY(THIS.this_oBusinessObject.ValidarCodigoConta(loc_cVal))
896:                     SELECT cursor_4c_Contas
897:                     REPLACE (loc_cCampo) WITH loc_cVal
898:                 ELSE
899:                     *-- Universo vazio / codigo inexistente NAO eh erro: o legado
900:                     *-- nao avisa nem apaga o digitado, so abre o browse com o
901:                     *-- valor como prefixo (regra #50)
902:                     THIS.AbrirBuscaConta(par_nColuna)
903:                 ENDIF
904:             ENDIF
905:         CATCH TO loc_oErro
906:             MsgErro(loc_oErro.Message, "Erro ao validar conta")
907:         ENDTRY
908:     ENDPROC
909: 
910:     *==========================================================================
911:     * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecao de conta (SigCdCli),
912:     * equivalente ao fwBuscaExt do Valid de Column1/Column2.Text1 do legado
913:     *==========================================================================
914:     PROCEDURE AbrirBuscaConta(par_nColuna)
915:     *==========================================================================
916:         LOCAL loc_oLookup, loc_cVal, loc_oErro, loc_oColuna, loc_cCampo
917: 
918:         IF par_nColuna = 1
919:             loc_oColuna = THIS.grd_4c_Dados.Column1
920:             loc_cCampo  = "ContaAnt"
921:         ELSE
922:             loc_oColuna = THIS.grd_4c_Dados.Column2
923:             loc_cCampo  = "ContaNov"
924:         ENDIF
925: 
926:         loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))
927: 
928:         TRY
929:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
930:                 "cursor_4c_BuscaConta", "Iclis", loc_cVal, ;
931:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
932: 
933:             IF VARTYPE(loc_oLookup) <> "O"
934:                 MsgErro("Erro ao abrir busca de conta.", "Erro")
935:             ELSE
936:                 loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
937:                 loc_oLookup.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
938:                 loc_oLookup.mAddColuna("Grupos", "", "Grupo")
939:                 loc_oLookup.Show()
940: 
941:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaConta")
942:                     SELECT cursor_4c_BuscaConta
943:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaConta.Iclis, ""))
944:                     USE IN cursor_4c_BuscaConta
945: 
946:                     SELECT cursor_4c_Contas
947:                     REPLACE (loc_cCampo) WITH loc_cVal
948:                     loc_oColuna.Text1.Value = loc_cVal
949:                 ELSE
950:                     IF USED("cursor_4c_BuscaConta")
951:                         USE IN cursor_4c_BuscaConta
952:                     ENDIF
953:                 ENDIF
954:             ENDIF
955:         CATCH TO loc_oErro
956:             IF USED("cursor_4c_BuscaConta")
957:                 USE IN cursor_4c_BuscaConta
958:             ENDIF
959:             MsgErro(loc_oErro.Message, "Erro ao buscar conta")
960:         ENDTRY
961:     ENDPROC
962: 
963:     *==========================================================================
964:     * BtnExportaClick - Importa pares Conta Antiga/Conta Nova de planilha XLS
965:     * para cursor_4c_Contas (Exporta.Click do legado - nome legado, funcao de import)
966:     *==========================================================================
967:     PROCEDURE BtnExportaClick()
968:     *==========================================================================
969:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro, loc_nAntes, loc_lOk
970: 
971:         loc_nImportados = 0
972:         loc_nAntes      = 0
973:         loc_lOk         = .F.
974: 
975:         TRY
976:             loc_cArquivo = GETFILE("XLS")
977: 
978:             IF EMPTY(loc_cArquivo)
979:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
980:                     "o informado!!!", "Aviso")
981:             ELSE
982:                 IF !FILE(loc_cArquivo)
983:                     MsgErro("O Arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
984:                         "N" + CHR(227) + "o Foi Encontrado ou o Acesso Foi Negado!!! Verifique!!!", "Erro")
985:                 ELSE
986:                     *-- FormParaBO leva CheckCadPro (que decide se a importacao
987:                     *-- valida ContaAnt contra SigCdCli) e os dois checkboxes
988:                     THIS.FormParaBO()
989: 
990:                     *-- ImportarDeXLS devolve LOGICO, nao a contagem: o numero de
991:                     *-- pares aceitos eh a variacao do RECCOUNT do cursor, que eh
992:                     *-- onde o BO deduplica via TAG Duplica
993:                     loc_nAntes = IIF(USED("cursor_4c_Contas"), RECCOUNT("cursor_4c_Contas"), 0)
994: 
995:                     loc_lOk = THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
996: 
997:                     loc_nImportados = IIF(USED("cursor_4c_Contas"), ;
998:                         RECCOUNT("cursor_4c_Contas") - loc_nAntes, 0)
999: 
1000:                     *-- Legado fecha com "Go bott / Grade.Refresh"
1001:                     THIS.CarregarLista("FIM")
1002: 
1003:                     IF loc_lOk AND loc_nImportados > 0
1004:                         MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
1005:                             "Importa" + CHR(231) + CHR(227) + "o")
1006:                     ELSE
1007:                         IF loc_lOk
1008:                             MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
1009:                                 "Importa" + CHR(231) + CHR(227) + "o")
1010:                         ENDIF
1011:                     ENDIF
1012:                 ENDIF
1013:             ENDIF
1014:         CATCH TO loc_oErro
1015:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1016:                 "Erro BtnExportaClick FormSigPrMdc")
1017:         ENDTRY
1018:     ENDPROC
1019: 
1020:     *==========================================================================
1021:     * BtnProcessarClick - Processa a troca de contas (btnProcessar.Click do
1022:     * legado). Com chkReps=1 troca so SigCdCli.ContaVens (representantes); caso
1023:     * contrario percorre o catalogo ArqDBF e atualiza/exclui em todos os
1024:     * arquivos elegiveis. fRecalculaP/fRecalculaC nao portadas (regra #27 -
1025:     * funcoes de CALCULO de saldo nunca recebem stub; recalculo omitido, igual
1026:     * ao padrao ja adotado em Formsigprmdp.prg/sigprmdpBO.prg).
1027:     *==========================================================================
1028:     PROCEDURE BtnProcessarClick()
1029:     *==========================================================================
1030:         LOCAL loc_cMensagem, loc_oErro, loc_lOk, loc_lManual
1031:         LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nPct
1032:         LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cWhere, loc_lContaNovaExiste
1033:         LOCAL loc_lReiniciar
1034: 
1035:         loc_cMensagem = ""
1036: 
1037:         *-- A conexao do projeto nasce com Transactions = 2 (MANUAL), e eh por
1038:         *-- isso que o COMMIT/ROLLBACK abaixo tem de ser feito com SQLCOMMIT/
1039:         *-- SQLROLLBACK do VFP e nao com "COMMIT TRANSACTION" via SQLEXEC (que
1040:         *-- so aninharia @@TRANCOUNT sem efetivar nada). Handle invalido faz
1041:         *-- SQLGETPROP estourar FORA de TRY - dai a guarda, senao o usuario
1042:         *-- veria o Program Error cru do VFP ao clicar Processar.
1043:         loc_lManual = .F.
1044:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1045:             TRY
1046:                 loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
1047:             CATCH TO loc_oErro
1048:                 loc_lManual = .F.
1049:             ENDTRY
1050:         ENDIF
1051: 
1052:         *-- loc_lReiniciar reproduz o "Return 0" do legado no ramo de falha do
1053:         *-- processamento de arquivos: ali o legado NAO exibe a mensagem final e
1054:         *-- NAO reseta a lista de pares (deixa o painel visivel com a barra em 0
1055:         *-- e a mensagem "Favor reinicializar o processo"), para o usuario poder
1056:         *-- corrigir e tentar de novo sem redigitar tudo. Como RETURN dentro de
1057:         *-- TRY/CATCH eh proibido (regra #1), o early-exit vira esta flag.
1058:         loc_lReiniciar = .F.
1059: 
1060:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1061:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
1062:             RETURN
1063:         ENDIF
1064: 
1065:         *-- ValidarParesContas devolve LOGICO e escreve a mensagem no parametro:
1066:         *-- VFP9 passa por VALOR em chamada de metodo, entao o @ eh OBRIGATORIO
1067:         *-- (sem ele loc_cMensagem volta vazia e o aviso do legado desaparece)
1068:         IF !THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
1069:             IF EMPTY(loc_cMensagem)
1070:                 loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
1071:             ENDIF
1072:             MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
1073:             THIS.grd_4c_Dados.Column1.SetFocus
1074:             RETURN
1075:         ENDIF
1076: 
1077:         IF !MsgConfirma("Confirma a Troca das Contas ?", ;
1078:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
1079:             THIS.cmd_4c_BtnSair.SetFocus
1080:             RETURN
1081:         ENDIF
1082: 
1083:         *-- Leva os dois checkboxes e o CheckCadPro para o BO antes de processar
1084:         THIS.FormParaBO()
1085: 
1086:         loc_lOk = .T.
1087: 
1088:         IF THIS.chk_4c_ChkReps.Value = 1
1089:             *-- Trocar Apenas Representantes (ThisForm.TrocarReps() do legado):
1090:             *-- o BO percorre o proprio cursor_4c_Contas, sem parametro
1091:             loc_lOk = THIS.this_oBusinessObject.TrocarContaRepresentantes()
1092:         ELSE
1093:             *-- Catalogo de campos: quem resolve e valida o caminho eh o BO
1094:             *-- (ValidarArqDBF ja exibe o aviso do legado "O ArqDBF nao esta no
1095:             *-- diretorio do Sistema!!!"); BOParaForm traz o caminho resolvido
1096:             *-- de volta para this_cArqDBFPath, usado no USE ... ALIAS ArqDBF
1097:             IF !THIS.this_oBusinessObject.ValidarArqDBF()
1098:                 RETURN
1099:             ENDIF
1100: 
1101:             THIS.BOParaForm()
1102: 
1103:             IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
1104:                 MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
1105:                     "Erro de Configura" + CHR(231) + CHR(227) + "o")
1106:                 RETURN
1107:             ENDIF
1108: 
1109:             loc_nErro = 1
1110: 
1111:             *-- Funil unico de estado: PROCESSANDO desabilita grade e botoes para
1112:             *-- o usuario nao reentrar no SCAN multi-tabela (regra #40 - quem

*-- Linhas 1371 a 1533:
1371:             IF loc_lOk
1372:                 MsgInfo("Todas as Contas Foram Alteradas!!!", "Processamento Encerrado!!!")
1373:             ELSE
1374:                 MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
1375:                     "Processamento Encerrado!!!")
1376:             ENDIF
1377: 
1378:             *-- Reseta a lista de pares para o proximo lote (Zap + Append Blank
1379:             *-- do legado). NAO roda no ramo de reinicializacao: ali o legado
1380:             *-- preserva os pares para o usuario corrigir e reprocessar
1381:             THIS.LimparCampos()
1382:         ENDIF
1383: 
1384:         THIS.grd_4c_Dados.Column1.SetFocus
1385:     ENDPROC
1386: 
1387:     *==========================================================================
1388:     * HabilitarCampos - Habilita/desabilita grid e botoes durante processamento,
1389:     * para evitar cliques enquanto o SCAN multi-tabela esta em andamento.
1390:     * O botao Encerrar NAO entra: o legado nunca o desabilita, e trava-lo
1391:     * deixaria a tela sem saida durante um lote longo.
1392:     *
1393:     * Chk_DelCT carrega tambem a dependencia do Chk_DelCT.When do legado
1394:     * ("Return (ThisForm.chkReps.Value = 0)"): ele so eh clicavel enquanto
1395:     * "Trocar Apenas Representantes" estiver desmarcado.
1396:     *==========================================================================
1397:     PROCEDURE HabilitarCampos(par_lHabilitar)
1398:     *==========================================================================
1399:         LOCAL loc_lHab
1400:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1401: 
1402:         THIS.grd_4c_Dados.Enabled        = loc_lHab
1403:         THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHab
1404:         THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHab
1405:         THIS.cmd_4c_Exporta.Enabled      = loc_lHab
1406:         THIS.cmd_4c_BtnProcessar.Enabled = loc_lHab
1407:         THIS.chk_4c_ChkReps.Enabled      = loc_lHab
1408:         THIS.chk_4c_Chk_DelCT.Enabled    = loc_lHab AND (THIS.chk_4c_ChkReps.Value = 0)
1409:     ENDPROC
1410: 
1411:     *==========================================================================
1412:     * AjustarBotoesPorModo - FUNIL UNICO do estado da tela. Chamado tanto na
1413:     * IDA (BtnProcessarClick, modo "PROCESSANDO") quanto na VOLTA (fim do
1414:     * processamento e LimparCampos, modo "EDICAO"): regra #40 - quem desabilita
1415:     * botao tem de reabilitar no funil de volta, senao a tela fica inutilizavel
1416:     * depois do primeiro processamento e so volta ao normal se for reaberta.
1417:     *
1418:     * NAO existem modos CRUD aqui: o legado herda de `form` (nao de
1419:     * frmcadastro), nao tem pcEscolha nem os botoes Incluir/Alterar/Visualizar/
1420:     * Excluir/Buscar de cadastro - inventa-los violaria o PILAR 1.
1421:     *==========================================================================
1422:     PROCEDURE AjustarBotoesPorModo()
1423:     *==========================================================================
1424:         LOCAL loc_lEdicao
1425: 
1426:         *-- Qualquer valor que nao seja "PROCESSANDO" eh tratado como edicao:
1427:         *-- assim um modo nao previsto nunca deixa a tela travada
1428:         loc_lEdicao = !(UPPER(ALLTRIM(THIS.this_cModoAtual)) == "PROCESSANDO")
1429: 
1430:         THIS.HabilitarCampos(loc_lEdicao)
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * AtualizarProgresso - FUNIL UNICO do painel de progresso (cntResult do
1435:     * legado). Tambem eh o metodo que o SigPrMdcBO.ProcessarMudancaContas
1436:     * espera encontrar no form que recebe por par_oForm - sem ele aquela
1437:     * chamada estoura "Property ATUALIZARPROGRESSO is not found" em runtime.
1438:     *
1439:     * par_cArquivo: texto do campo "Arquivo/Campo" ("" mantem o atual)
1440:     * par_nPct    : 0..100 reposiciona a barra; valor negativo (ou ausente)
1441:     *               mantem a barra como esta - usado nos dois SCAN internos,
1442:     *               que no legado atualizam SO o texto do arquivo/campo
1443:     * PUBLIC de proposito: chamado de fora da classe pelo BO (regra #3/#51).
1444:     *==========================================================================
1445:     PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
1446:     *==========================================================================
1447:         LOCAL loc_cArq, loc_nPct, loc_oErro
1448: 
1449:         loc_cArq = IIF(VARTYPE(par_cArquivo) = "C", par_cArquivo, "")
1450:         loc_nPct = IIF(VARTYPE(par_nPct) = "N", par_nPct, -1)
1451: 
1452:         TRY
1453:             IF !EMPTY(loc_cArq)
1454:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
1455:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
1456:             ENDIF
1457: 
1458:             IF loc_nPct >= 0
1459:                 IF loc_nPct > 100
1460:                     loc_nPct = 100
1461:                 ENDIF
1462:                 *-- Barra interna tem 222px uteis: 2px por ponto percentual,
1463:                 *-- como no legado (Int((lnRec*100)/lnCnt) * 2)
1464:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = loc_nPct * 2
1465:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
1466:                     ALLTRIM(STR(loc_nPct)) + " %"
1467:                 THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
1468:             ENDIF
1469:         CATCH TO loc_oErro
1470:             MsgErro(loc_oErro.Message, "Erro AtualizarProgresso FormSigPrMdc")
1471:         ENDTRY
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * LimparCampos - Reseta a lista de pares para o proximo lote ("Select
1476:     * csContas / Set Order To / Zap / Append Blank" do fim do btnProcessar.Click
1477:     * legado) e devolve a tela ao estado de edicao.
1478:     *
1479:     * Os dois checkboxes NAO sao zerados: o legado tambem nao os zera no fim do
1480:     * processamento, e mexer neles mudaria o comportamento que o usuario ve
1481:     * (PILAR 1). Quem precisa dos valores sincronizados chama FormParaBO.
1482:     *
1483:     * PROTECTED EXPLICITO: FormBase declara LimparCampos / FormParaBO /
1484:     * BOParaForm como PROTECTED e o VFP9 NAO deixa a subclasse alargar o escopo
1485:     * - escrever "PROCEDURE" sem o modificador nao torna o metodo publico, so
1486:     * esconde que ele continua protegido (medido: chamada de fora estoura
1487:     * "Property LIMPARCAMPOS is not found", mas PEMSTATUS(...,5) devolve .T. e
1488:     * mente). Chamar SEMPRE por THIS. de dentro da classe. Metodo que precise
1489:     * ser alcancado de fora nao pode usar um desses tres nomes - eh por isso que
1490:     * o funil do painel de progresso se chama AtualizarProgresso (nome ausente
1491:     * em FormBase, logo publico de verdade) e eh ele que o BO recebe em par_oForm.
1492:     *==========================================================================
1493:     PROTECTED PROCEDURE LimparCampos()
1494:     *==========================================================================
1495:         LOCAL loc_cSafety, loc_oErro, loc_lSucesso
1496:         loc_lSucesso = .F.
1497: 
1498:         TRY
1499:             IF !USED("cursor_4c_Contas")
1500:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1501:                     THIS.this_oBusinessObject.InicializarCursorContas()
1502:                 ENDIF
1503:             ELSE
1504:                 *-- DataSession privada (=2) nasce com SET SAFETY ON (nao herda o
1505:                 *-- OFF do main.prg): sem a guarda o ZAP abre dialogo modal de
1506:                 *-- confirmacao e congela o processo em execucao desassistida
1507:                 loc_cSafety = SET("SAFETY")
1508:                 SET SAFETY OFF
1509:                 SELECT cursor_4c_Contas
1510:                 SET ORDER TO
1511:                 ZAP
1512:                 APPEND BLANK
1513:                 IF loc_cSafety == "ON"
1514:                     SET SAFETY ON
1515:                 ENDIF
1516:             ENDIF
1517: 
1518:             *-- Zerar o cursor NAO repinta a grade (regra #21): repintura pelo
1519:             *-- mesmo funil usado por todos os outros caminhos
1520:             THIS.CarregarLista("TOPO")
1521: 
1522:             THIS.this_cModoAtual = "EDICAO"
1523:             THIS.AjustarBotoesPorModo()
1524: 
1525:             *-- Par corrente do BO acompanha o cursor recem-zerado
1526:             THIS.FormParaBO()
1527: 
1528:             loc_lSucesso = .T.
1529:         CATCH TO loc_oErro
1530:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1531:                 "Erro LimparCampos FormSigPrMdc")
1532:         ENDTRY
1533: 

*-- Linhas 1550 a 1698:
1550:     * atribuir direto trocaria o tipo da property e estouraria "Data type
1551:     * mismatch" no primeiro AND do BO - a conversao "= 1" eh obrigatoria.
1552:     *==========================================================================
1553:     PROTECTED PROCEDURE FormParaBO()
1554:     *==========================================================================
1555:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1556:         loc_lSucesso = .F.
1557: 
1558:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1559:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro FormParaBO")
1560:         ELSE
1561:             TRY
1562:                 loc_oBO = THIS.this_oBusinessObject
1563: 
1564:                 loc_oBO.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
1565:                 loc_oBO.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
1566:                 loc_oBO.this_lCheckCadPro       = THIS.this_lCheckCadPro
1567:                 loc_oBO.this_cArqDBFPath        = THIS.this_cArqDBFPath
1568: 
1569:                 *-- Par corrente (a grade eh a unica "entrada de dados" da tela)
1570:                 IF USED("cursor_4c_Contas") AND !EOF("cursor_4c_Contas")
1571:                     loc_oBO.this_cContaAnt = TratarNulo(cursor_4c_Contas.ContaAnt, "")
1572:                     loc_oBO.this_cContaNov = TratarNulo(cursor_4c_Contas.ContaNov, "")
1573:                 ELSE
1574:                     loc_oBO.this_cContaAnt = ""
1575:                     loc_oBO.this_cContaNov = ""
1576:                 ENDIF
1577: 
1578:                 loc_lSucesso = .T.
1579:             CATCH TO loc_oErro
1580:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1581:                     "Erro FormParaBO FormSigPrMdc")
1582:             ENDTRY
1583:         ENDIF
1584: 
1585:         RETURN loc_lSucesso
1586:     ENDPROC
1587: 
1588:     *==========================================================================
1589:     * BOParaForm - Caminho inverso do FormParaBO: reflete na tela o estado que
1590:     * o BO detem. Usado quando o BO decide o estado (ex.: ValidarArqDBF, que
1591:     * resolve o caminho do catalogo, e os dois flags de processamento).
1592:     *
1593:     * O par de contas NAO eh escrito de volta na grade: a linha corrente eh do
1594:     * cursor, e sobrescrever a celula aqui apagaria o que o usuario digitou e
1595:     * ainda nao confirmou. Quem grava no cursor eh ValidarCelulaConta/
1596:     * AbrirBuscaConta, que tem o valor resolvido.
1597:     *==========================================================================
1598:     PROTECTED PROCEDURE BOParaForm()
1599:     *==========================================================================
1600:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1601:         loc_lSucesso = .F.
1602: 
1603:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1604:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro BOParaForm")
1605:         ELSE
1606:             TRY
1607:                 loc_oBO = THIS.this_oBusinessObject
1608: 
1609:                 *-- Propriedade LOGICA do BO -> CheckBox.Value NUMERICO
1610:                 THIS.chk_4c_ChkReps.Value   = IIF(loc_oBO.this_lTrocarReps, 1, 0)
1611:                 THIS.chk_4c_Chk_DelCT.Value = IIF(loc_oBO.this_lApagarContaAntiga, 1, 0)
1612: 
1613:                 THIS.this_lCheckCadPro = loc_oBO.this_lCheckCadPro
1614: 
1615:                 IF !EMPTY(loc_oBO.this_cArqDBFPath)
1616:                     THIS.this_cArqDBFPath = loc_oBO.this_cArqDBFPath
1617:                 ENDIF
1618: 
1619:                 *-- Dependencia do Chk_DelCT.When do legado tem de ser reaplicada
1620:                 *-- depois de mexer no Value dos dois checkboxes
1621:                 THIS.ChkRepsClick()
1622: 
1623:                 loc_lSucesso = .T.
1624:             CATCH TO loc_oErro
1625:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1626:                     "Erro BOParaForm FormSigPrMdc")
1627:             ENDTRY
1628:         ENDIF
1629: 
1630:         RETURN loc_lSucesso
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * TornarControlesVisiveis - Torna visiveis os controles criados por
1635:     * AddObject (nascem com Visible=.F.), recursando em Pages e Containers.
1636:     * cnt_4c_Result eh container flutuante (painel de progresso oculto por
1637:     * padrao) - recursa nos filhos mas NAO forca Visible=.T. no proprio
1638:     * container, preservando o estado definido em ConfigurarPainelResultado.
1639:     *==========================================================================
1640:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1641:     *==========================================================================
1642:         LOCAL loc_nI, loc_oControle
1643: 
1644:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1645:             loc_oControle = par_oContainer.Controls(loc_nI)
1646: 
1647:             IF VARTYPE(loc_oControle) != "O"
1648:                 LOOP
1649:             ENDIF
1650: 
1651:             IF UPPER(loc_oControle.Name) = "CNT_4C_RESULT"
1652:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1653:                     THIS.TornarControlesVisiveis(loc_oControle)
1654:                 ENDIF
1655:                 LOOP
1656:             ENDIF
1657: 
1658:             IF PEMSTATUS(loc_oControle, "Visible", 5)
1659:                 loc_oControle.Visible = .T.
1660:             ENDIF
1661: 
1662:             IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
1663:                 LOCAL loc_nP
1664:                 FOR loc_nP = 1 TO loc_oControle.PageCount
1665:                     THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
1666:                 ENDFOR
1667:             ENDIF
1668: 
1669:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1670:                 THIS.TornarControlesVisiveis(loc_oControle)
1671:             ENDIF
1672:         ENDFOR
1673:     ENDPROC
1674: 
1675:     *==========================================================================
1676:     PROCEDURE Destroy()
1677:     *==========================================================================
1678:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1679:             THIS.this_oBusinessObject = .NULL.
1680:         ENDIF
1681: 
1682:         IF USED("cursor_4c_Contas")
1683:             USE IN cursor_4c_Contas
1684:         ENDIF
1685:         IF USED("csCampos")
1686:             USE IN csCampos
1687:         ENDIF
1688:         IF USED("csArquivos")
1689:             USE IN csArquivos
1690:         ENDIF
1691:         IF USED("ArqDBF")
1692:             USE IN ArqDBF
1693:         ENDIF
1694: 
1695:         DODEFAULT()
1696:     ENDPROC
1697: 
1698: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrMdcBO.prg):
*==============================================================================
* Classe  : SigPrMdcBO
* Herda de: BusinessBase
* Descricao: BO para processamento de mudanca de conta (Muda Conta)
*            Valida pares ContaAnt/ContaNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF.
*            Form OPERACIONAL - sem CRUD padrao, sem this_cTabela/CampoChave.
*==============================================================================
DEFINE CLASS SigPrMdcBO AS BusinessBase

    *-- Flags de configuracao do processamento
    this_lCheckCadPro       = .F.   && Validar codigo de conta contra SigCdCli
    this_lTrocarReps        = .F.   && Trocar apenas representantes (ContaVens em SigCdCli)
    this_lApagarContaAntiga = .F.   && Apagar conta antiga de SigCdCli apos troca

    *-- Estado do progresso (lido pelo Form para atualizar UI)
    this_cArquivoAtual      = ""    && Arquivo/campo em processamento
    this_nProgresso         = 0     && Progresso 0-100

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath        = ""

    *-- Par corrente de contas (usado por CarregarDoCursor/Inserir/Atualizar)
    this_cContaAnt          = ""
    this_cContaNov          = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - override para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "MUDACONTA"
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursorContas
    * Cria cursor_4c_Contas com estrutura e registro inicial em branco.
    * Deve ser chamado por FormSigPrMdc.InicializarForm().
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION InicializarCursorContas()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Contas")
                USE IN cursor_4c_Contas
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Contas (ContaAnt C(10) NULL, ContaNov C(10) NULL)
            SET NULL OFF
            INDEX ON ContaAnt + ContaNov TAG Duplica
            INDEX ON ContaAnt            TAG ContaAnt
            INDEX ON ContaNov            TAG ContaNov
            SET ORDER TO
            INSERT INTO cursor_4c_Contas (ContaAnt, ContaNov) VALUES ('', '')
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarArqDBF
    * Verifica se ArqDBF.DBF existe no diretorio corrente do sistema.
    * Seta this_cArqDBFPath com caminho completo (sem extensao).
    * Returns: .T. se existe, .F. se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarArqDBF()
        LOCAL loc_lSucesso, loc_cCaminho
        loc_lSucesso = .F.
        loc_cCaminho = ""
        TRY
            loc_cCaminho = SYS(5) + SYS(2003) + "\ArqDBF"
            IF NOT FILE(loc_cCaminho + ".dbf")
                MsgAviso("O ArqDBF n" + CHR(227) + "o est" + CHR(225) + ;
                    " no diret" + CHR(243) + "rio do Sistema!!!", "Aviso")
            ELSE
                THIS.this_cArqDBFPath = loc_cCaminho
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * IncluirParConta
    * Adiciona linha em branco ao cursor_4c_Contas somente se a linha
    * corrente ja estiver preenchida (ContaAnt e ContaNov nao vazios).
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION IncluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            IF !EMPTY(cursor_4c_Contas.ContaAnt) .AND. !EMPTY(cursor_4c_Contas.ContaNov)
                APPEND BLANK
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirParConta
    * Marca o registro corrente de cursor_4c_Contas como excluido.
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ExcluirParConta()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            SELECT cursor_4c_Contas
            DELETE
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParesContas
    * Valida todos os pares em cursor_4c_Contas:
    *   - Nao pode estar vazio (ContaAnt ou ContaNov)
    *   - Nao pode ter ContaAnt = ContaNov
    * par_cMensagem: [BYREF] mensagem de erro se houver
    * Returns: .T. se todos validos, .F. se houver erro
    *--------------------------------------------------------------------------
    FUNCTION ValidarParesContas(par_cMensagem)
        LOCAL loc_lValido
        loc_lValido   = .F.
        par_cMensagem = ""
        TRY
            SELECT cursor_4c_Contas
            GO TOP
            IF EOF()
                par_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
            ELSE
                loc_lValido = .T.
                SCAN
                    IF EMPTY(cursor_4c_Contas.ContaAnt)
                        par_cMensagem = "Existe Uma Conta Antiga Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF EMPTY(cursor_4c_Contas.ContaNov)
                        par_cMensagem = "Existe Uma Conta Nova Inv" + CHR(225) + "lida!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                    IF cursor_4c_Contas.ContaAnt = cursor_4c_Contas.ContaNov
                        par_cMensagem = "Existe Uma Conta Antiga e Uma Conta Nova " + ;
                            "Com o Mesmo C" + CHR(243) + "digo!!!"
                        loc_lValido   = .F.
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarCodigoConta
    * Verifica se um codigo de conta existe em SigCdCli.
    * par_cConta: codigo a validar
    * Returns: ALLTRIM(Iclis) se encontrado, "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_ValidCli") > 0
                    SELECT cursor_4c_ValidCli
                    loc_cResultado = ALLTRIM(cursor_4c_ValidCli.Iclis)
                ENDIF
                IF USED("cursor_4c_ValidCli")
                    USE IN cursor_4c_ValidCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ValidCli")
                USE IN cursor_4c_ValidCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta
    * Retorna a Razao Social (Rclis) da conta em SigCdCli. String vazia se
    * conta nao existir. Usada por BtnVisualizarClick do Form.
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        LOCAL loc_cResultado, loc_cSQL, loc_nRet
        loc_cResultado = ""
        TRY
            IF NOT EMPTY(par_cConta)
                loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCli")
                IF loc_nRet >= 1 .AND. RECCOUNT("cursor_4c_DescCli") > 0
                    SELECT cursor_4c_DescCli
                    loc_cResultado = ALLTRIM(NVL(cursor_4c_DescCli.Rclis, ""))
                ENDIF
                IF USED("cursor_4c_DescCli")
                    USE IN cursor_4c_DescCli
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_DescCli")
                USE IN cursor_4c_DescCli
            ENDIF
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExcluirContaAntiga
    * Apaga a conta antiga de SigCdCli. Reproduz o ramo
    * "If lcArq == 'SIGCDCLI' And lcCpo = 'ICLIS' And Chk_DelCT.Value = 1" do
    * btnProcessar.Click legado, que exclui a conta de origem quando a conta de
    * destino JA existe no cadastro (nesse caso nao ha o que renomear).
    * par_cConta: codigo da conta a excluir (Iclis)
    * Returns: .T. se o DELETE foi aceito pelo servidor, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION ExcluirContaAntiga(par_cConta)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        loc_cSQL     = ""
        loc_nRet     = 0
        TRY
            IF EMPTY(par_cConta)
                MsgAviso("Conta antiga inv" + CHR(225) + "lida para exclus" + ;
                    CHR(227) + "o.", "Aviso")
            ELSE
                loc_cSQL = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                    EscaparSQL(ALLTRIM(par_cConta))
                loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRet < 1
                    MsgErro("Falha ao excluir a conta antiga [" + ;
                        ALLTRIM(par_cConta) + "]." + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("EXCLUSAO_CONTA: " + ALLTRIM(par_cConta))
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao excluir conta antiga")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ImportarDeXLS
    * Importa arquivo XLS e carrega pares em cursor_4c_Contas.
    * Valida ContaAnt contra SigCdCli (se this_lCheckCadPro = .F.).
    * Deduplica via TAG Duplica antes de inserir.
    * par_cArquivo: caminho completo do arquivo XLS (ja validado pela UI)
    * Returns: .T. em sucesso
    *--------------------------------------------------------------------------
    FUNCTION ImportarDeXLS(par_cArquivo)
        LOCAL loc_lSucesso, loc_nTotal, loc_nCont
        LOCAL loc_cContaAnt, loc_cContaNov, loc_cSQL, loc_nRet
        loc_lSucesso  = .F.
        loc_nTotal    = 0
        loc_nCont     = 0
        loc_cContaAnt = ""
        loc_cContaNov = ""
        loc_cSQL      = ""
        loc_nRet      = 0
        TRY
            IF EMPTY(par_cArquivo)
                MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + ;
                    "o n" + CHR(227) + "o informado!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT FILE(par_cArquivo)
                MsgAviso("O Arquivo [" + ALLTRIM(par_cArquivo) + "]" + CHR(13) + ;
                    "N" + CHR(227) + "o Foi Encontrado ou o Acesso " + ;
                    "Foi Negado!!! Verifique!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Cursor temporario de importacao
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            CREATE CURSOR cursor_4c_Importa (ContaAnt C(10), ContaNov C(10))
            INDEX ON ContaAnt TAG Contas
            SET ORDER TO

            *-- Importar registros do XLS
            SELECT cursor_4c_Importa
            APPEND FROM (par_cArquivo) TYPE XLS

            loc_nTotal = RECCOUNT("cursor_4c_Importa")
            loc_nCont  = 0

            SELECT cursor_4c_Importa
            SCAN
                loc_nCont     = loc_nCont + 1
                loc_cContaAnt = cursor_4c_Importa.ContaAnt
                loc_cContaNov = cursor_4c_Importa.ContaNov

                IF EMPTY(loc_cContaAnt) OR EMPTY(loc_cContaNov)
                    LOOP
                ENDIF
                IF loc_cContaAnt = loc_cContaNov
                    LOOP
                ENDIF

                *-- Validar ContaAnt contra SigCdCli se nao em modo CheckCadPro
                IF NOT THIS.this_lCheckCadPro
                    loc_cSQL = "SELECT Iclis FROM SigCdCli WHERE Iclis = " + ;
                        EscaparSQL(ALLTRIM(loc_cContaAnt))
                    loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliImp")
                    IF loc_nRet < 1 OR RECCOUNT("cursor_4c_CliImp") = 0
                        IF USED("cursor_4c_CliImp")
                            USE IN cursor_4c_CliImp
                        ENDIF
                        LOOP
                    ENDIF
                    IF USED("cursor_4c_CliImp")
                        USE IN cursor_4c_CliImp
                    ENDIF
                ENDIF

                *-- Inserir em cursor_4c_Contas somente se nao duplicado
                SELECT cursor_4c_Contas
                SET ORDER TO Duplica
                IF NOT SEEK(m.loc_cContaAnt + m.loc_cContaNov)
                    APPEND BLANK
                    REPLACE cursor_4c_Contas.ContaAnt WITH loc_cContaAnt, ;
                            cursor_4c_Contas.ContaNov WITH loc_cContaNov
                ENDIF

                *-- Restaurar para o cursor de importacao (proxima iteracao SCAN)
                SELECT cursor_4c_Importa
            ENDSCAN

            *-- Posicionar no final e limpar ordem
            SELECT cursor_4c_Contas
            SET ORDER TO
            GO BOTTOM

            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Importa")
                USE IN cursor_4c_Importa
            ENDIF
            IF USED("cursor_4c_CliImp")
                USE IN cursor_4c_CliImp
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * TrocarContaRepresentantes
    * Troca ContaVens em SigCdCli para todos os pares em cursor_4c_Contas.
    * Executa em transacao SQL Server (COMMIT em sucesso, ROLLBACK em falha).
    * Permite retry interativo em caso de falha (mesma logica do legado).
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION TrocarContaRepresentantes()
        LOCAL loc_lSucesso, loc_cUpdate, loc_nErro
        loc_lSucesso = .F.
        loc_nErro    = 1
        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            SELECT cursor_4c_Contas
            SCAN
                loc_cUpdate = "UPDATE SigCdCli SET ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov)) + ;
                    " WHERE ContaVens = " + ;
                    EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))

                loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_TrocaRet")
                IF USED("cursor_4c_TrocaRet")
                    USE IN cursor_4c_TrocaRet
                ENDIF

                IF loc_nErro < 1
                    IF MsgConfirma("Falha ao Tentar Trocar a Conta '" + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + "'" + CHR(13) + ;
                        "Deseja Tentar Novamente?", "Aten" + CHR(231) + CHR(227) + "o!!!")
                        SELECT cursor_4c_Contas
                        SKIP -1
                        LOOP
                    ELSE
                        EXIT
                    ENDIF
                ENDIF
            ENDSCAN

            IF loc_nErro < 1
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA_REP: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + " -> " + ;
                        ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMudancaContas
    * Processamento principal: itera sobre o catalogo ArqDBF.DBF e aplica
    * UPDATE (ou DELETE para SIGMVSLC/SIGMVEST) em todos os campos de todas
    * as tabelas que referenciam os codigos de conta em cursor_4c_Contas.
    *
    * Casos especiais:
    *   SIGMVCCR/CONTAS   -> atualiza GruConMoes + chama fRecalculaS
    *   SIGCDCLI/ICLIS    -> verifica se ContaNov existe; deleta ContaAnt se par_lApagarContaAntiga
    *   SIGMVHST/ESTOS    -> atualiza EmpGruEsts (fRecalculaP/fRecalculaC do legado
    *                        NAO portadas e sem stub - regra #27; recalculo omitido)
    *   SIGCDCLH/ICLIS    -> atualiza GruContas
    *   SIGMVSLC/SIGMVEST -> DELETE (nao UPDATE)
    *
    * par_lApagarContaAntiga: apagar ContaAnt de SigCdCli apos troca
    * par_oForm: referencia ao Form para atualizacao de progresso (opcional)
    *            O Form deve ter PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
    * Returns: .T. em sucesso (COMMIT), .F. em falha (ROLLBACK)
    *--------------------------------------------------------------------------
    FUNCTION ProcessarMudancaContas(par_lApagarContaAntiga, par_oForm)
        LOCAL loc_lSucesso, loc_nErro, loc_nRec, loc_nCnt
        LOCAL loc_cArq, loc_cCpo, loc_cUpdate, loc_cDelete, loc_cWhere
        LOCAL loc_cContaNovSalvo, loc_lContaNovExiste, loc_nChkRet, loc_cChkSQL
        loc_lSucesso        = .F.
        loc_nErro           = 1
        loc_nRec            = 0
        loc_nCnt            = 0
        loc_cArq            = ""
        loc_cCpo            = ""
        loc_cUpdate         = ""
        loc_cDelete         = ""
        loc_cWhere          = ""
        loc_cContaNovSalvo  = ""
        loc_lContaNovExiste = .F.
        loc_nChkRet         = 0
        loc_cChkSQL         = ""
        TRY
            IF NOT THIS.ValidarArqDBF()
                loc_lSucesso = .F.
            ENDIF

            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

            *-- Fechar cursores anteriores se abertos
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

            *-- Consultar catalogo ArqDBF (SELECT VFP local sobre DBF)
            SELECT Arquivos, Campos ;
            FROM (THIS.this_cArqDBFPath) ;
            WHERE (Tamanhos = 10 OR UPPER(Campos) = 'CLIFORS') AND ;
                  UPPER(Tipos) = 'C' AND ;
                  NOT EMPTY(Dbcs) AND ;
                  Arquivos # 'ArqDBF.DBF' AND ;
                  UPPER(Arquivos) # 'SIGTEMPC.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGCDCEE.DBF' AND ;
                  UPPER(Arquivos) # 'SIGALERT.DBF' AND ;
                  INLIST(UPPER(SUBS(Arquivos, 1, 3)), 'SIG') AND ;
                  (AT('CON',    UPPER(Campos)) # 0 OR ;
                   AT('IFOR',   UPPER(Campos)) # 0 OR ;
                   AT('ESTOS',  UPPER(Campos)) # 0 OR ;
                   AT('CLI',    UPPER(Campos)) # 0 OR ;
                   AT('VEN',    UPPER(Campos)) # 0 OR ;
                   AT('RESP',   UPPER(Campos)) # 0) AND ;
                  AT('USU',     UPPER(Campos)) = 0 AND ;
                  AT('GR',      UPPER(Campos)) = 0 AND ;
                  AT('NCONTAS', UPPER(Campos)) = 0 AND ;
                  AT('NRCONS',  UPPER(Campos)) = 0 AND ;
                  AT('CCUSTOS', UPPER(Campos)) = 0 ;
            ORDER BY Arquivos ;
            INTO CURSOR csCampos READWRITE
            INDEX ON Arquivos + Campos TAG ArqCpo

            SELECT DISTINCT Arquivos ;
            FROM csCampos ;
            ORDER BY Arquivos ;
            INTO CURSOR csArquivos READWRITE

            loc_nCnt               = RECCOUNT("csArquivos")
            THIS.this_nProgresso   = 0
            THIS.this_cArquivoAtual = ""

            *-- SCAN externo: cada arquivo do catalogo
            SELECT csArquivos
            SCAN
                loc_cArq = ALLTRIM(STRTRAN(csArquivos.Arquivos, '.DBF', ''))
                THIS.this_cArquivoAtual = loc_cArq
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(loc_cArq, THIS.this_nProgresso)
                ENDIF

                *-- SCAN medio: cada campo deste arquivo
                SELECT csCampos
                SEEK csArquivos.Arquivos
                SCAN WHILE csArquivos.Arquivos = csCampos.Arquivos .AND. !EOF()
                    loc_cCpo = ALLTRIM(csCampos.Campos)
                    THIS.this_cArquivoAtual = loc_cArq + ' / ' + loc_cCpo
                    IF VARTYPE(par_oForm) = "O"
                        par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                    ENDIF

                    *-- SCAN interno: cada par de contas
                    SELECT cursor_4c_Contas
                    SCAN
                        *-- Caso especial: SIGMVCCR/CONTAS -> recalcular saldo antes de UPDATE
                        IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                            loc_cWhere = "SELECT DISTINCT Emps, Grupos, Contas, Moedas " + ;
                                "FROM SigMvCcr WHERE " + loc_cCpo + " = '" + ;
                                PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                            SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_Mccr")
                            IF USED("cursor_4c_Mccr") AND RECCOUNT("cursor_4c_Mccr") > 0
                                loc_cContaNovSalvo = cursor_4c_Contas.ContaNov
                                SELECT cursor_4c_Mccr
                                SCAN
                                    *-- fRecalculaS ESTA portada (utils\functions.prg):
                                    *-- chamada de verdade, SEM TRY que engula o erro.
                                    *-- Aqui ela roda em "modo registro" (1o parametro
                                    *-- CARACTERE): so acumula a entrada no cursor
                                    *-- crRecalculaS; o recalculo efetivo acontece na
                                    *-- chamada em "modo processamento" (1o parametro
                                    *-- logico) depois do SCAN de arquivos.
                                    =fRecalculaS(cursor_4c_Mccr.Grupos, ;
                                        m.loc_cContaNovSalvo, ;
                                        CTOD('01/01/1900'), ;
                                        cursor_4c_Mccr.Moedas, ;
                                        gnConnHandle)
                                ENDSCAN
                                IF USED("cursor_4c_Mccr")
                                    USE IN cursor_4c_Mccr
                                ENDIF
                            ENDIF
                        ENDIF

                        *-- Caso especial: SIGCDCLI/ICLIS
                        *-- Verifica se ContaNov ja existe; se sim, deleta ContaAnt e pula UPDATE
                        IF loc_cArq == 'SIGCDCLI' AND loc_cCpo = 'ICLIS'
                            loc_cChkSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli " + ;
                                "WHERE Iclis = " + EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaNov))
                            loc_nChkRet = SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkCli")
                            loc_lContaNovExiste = .F.
                            IF loc_nChkRet >= 1 AND RECCOUNT("cursor_4c_ChkCli") > 0
                                SELECT cursor_4c_ChkCli
                                loc_lContaNovExiste = (NVL(cursor_4c_ChkCli.nExiste, 0) > 0)
                            ENDIF
                            IF USED("cursor_4c_ChkCli")
                                USE IN cursor_4c_ChkCli
                            ENDIF

                            IF loc_lContaNovExiste
                                *-- ContaNov ja existe: deletar ContaAnt se solicitado
                                IF par_lApagarContaAntiga
                                    loc_cDelete = "DELETE FROM SigCdCli WHERE Iclis = " + ;
                                        EscaparSQL(ALLTRIM(cursor_4c_Contas.ContaAnt))
                                    SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelCli")
                                    IF USED("cursor_4c_DelCli")
                                        USE IN cursor_4c_DelCli
                                    ENDIF
                                ENDIF
                                SELECT cursor_4c_Contas
                                LOOP
                            ENDIF
                            *-- ContaNov nao existe: cai no UPDATE padrao abaixo (UPDATE ICLIS)
                        ENDIF

                        *-- Caso especial: SIGMVSLC ou SIGMVEST -> DELETE em vez de UPDATE
                        IF loc_cArq == 'SIGMVSLC' OR loc_cArq == 'SIGMVEST'
                            loc_cDelete = "DELETE FROM " + loc_cArq + ;
                                " WHERE " + loc_cCpo + " = '" + ;
                                cursor_4c_Contas.ContaAnt + "'"
                            loc_nErro = SQLEXEC(gnConnHandle, loc_cDelete, "cursor_4c_DelRet")
                            IF USED("cursor_4c_DelRet")
                                USE IN cursor_4c_DelRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ELSE
                            *-- UPDATE padrao (casos gerais e casos especiais com campos extras)
                            IF loc_cArq == 'SIGMVCCR' AND loc_cCpo = 'CONTAS'
                                loc_cUpdate = "UPDATE " + loc_cArq + ;
                                    " SET " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "', GruConMoes = Grupos + '" + ;
                                    cursor_4c_Contas.ContaNov + ;
                                    "' + Moedas WHERE " + loc_cCpo + " = '" + ;
                                    cursor_4c_Contas.ContaAnt + "'"
                            ELSE
                                IF loc_cArq == 'SIGMVHST' AND loc_cCpo = 'ESTOS'
                                    *-- Recalcular historico antes de UPDATE
                                    loc_cWhere = "SELECT DISTINCT Emps, Grupos, Estos, " + ;
                                        "Cpros, CodCors, CodTams FROM SigMvHst WHERE " + ;
                                        loc_cCpo + " = '" + ;
                                        PADR(cursor_4c_Contas.ContaAnt, 10) + "'"
                                    SQLEXEC(gnConnHandle, loc_cWhere, "cursor_4c_His")
                                    IF USED("cursor_4c_His")
                                        *-- O legado percorre este cursor chamando
                                        *-- fRecalculaP (saldo por produto/cor/tamanho)
                                        *-- e fRecalculaC (custo), que NAO foram
                                        *-- portadas e NAO recebem stub: devolver um
                                        *-- valor fixo para calculo de saldo gravaria
                                        *-- numero errado em silencio (regra #27).
                                        *-- O recalculo fica OMITIDO e VISIVEL aqui,
                                        *-- nunca escondido num CATCH - o UPDATE do
                                        *-- codigo abaixo continua sendo aplicado.
                                        USE IN cursor_4c_His
                                    ENDIF
                                    SELECT cursor_4c_Contas
                                    loc_cUpdate = "UPDATE " + loc_cArq + ;
                                        " SET " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "', EmpGruEsts = Emps + Grupos + '" + ;
                                        cursor_4c_Contas.ContaNov + ;
                                        "' WHERE " + loc_cCpo + " = '" + ;
                                        cursor_4c_Contas.ContaAnt + "'"
                                ELSE
                                    IF loc_cArq == 'SIGCDCLH' AND loc_cCpo = 'ICLIS'
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "', GruContas = Grupos + '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ELSE
                                        loc_cUpdate = "UPDATE " + loc_cArq + ;
                                            " SET " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaNov + ;
                                            "' WHERE " + loc_cCpo + " = '" + ;
                                            cursor_4c_Contas.ContaAnt + "'"
                                    ENDIF
                                ENDIF
                            ENDIF

                            loc_nErro = SQLEXEC(gnConnHandle, loc_cUpdate, "cursor_4c_UpdRet")
                            IF USED("cursor_4c_UpdRet")
                                USE IN cursor_4c_UpdRet
                            ENDIF
                            IF loc_nErro < 1
                                IF MsgConfirma("Falha de Conex" + CHR(227) + "o!!! " + ;
                                    "Tentar Novamente?", "Erro de Processamento")
                                    SELECT cursor_4c_Contas
                                    SKIP -1
                                    LOOP
                                ELSE
                                    EXIT
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDSCAN  && cursor_4c_Contas

                    IF loc_nErro < 1
                        EXIT
                    ENDIF
                ENDSCAN  && csCampos WHILE

                IF loc_nErro < 1
                    EXIT
                ENDIF

                *-- Atualizar progresso
                SELECT csArquivos
                loc_nRec             = loc_nRec + 1
                THIS.this_nProgresso  = INT((loc_nRec * 100) / IIF(loc_nCnt > 0, loc_nCnt, 1))
                IF VARTYPE(par_oForm) = "O"
                    par_oForm.AtualizarProgresso(THIS.this_cArquivoAtual, THIS.this_nProgresso)
                ENDIF
            ENDSCAN  && csArquivos

            *-- Recalculo final em "modo processamento" (1o parametro logico),
            *-- fechando o lote registrado pelas chamadas em "modo registro" do
            *-- SCAN acima. fRecalculaS ESTA portada (utils\functions.prg) -
            *-- chamada de verdade e SEM TRY que engula o resultado: se ela
            *-- recusar, o lote tem de ir para ROLLBACK.
            IF loc_nErro > 0
                IF NOT fRecalculaS(.T., gnConnHandle, .T.)
                    loc_nErro = -1
                ENDIF
            ENDIF

            *-- fRecalculaP / fRecalculaC do legado NAO foram portadas e NAO
            *-- recebem stub (regra #27: funcao que devolve VALOR DE CALCULO de
            *-- saldo nunca pode ser substituida por um retorno fixo - gravaria
            *-- numero errado em silencio). A ausencia fica VISIVEL aqui, nao
            *-- escondida num CATCH vazio; mesmo tratamento dado ao caminho
            *-- equivalente de Formsigprmdp.prg/sigprmdpBO.prg.

            *-- Commit ou Rollback
            IF loc_nErro < 1
                MsgAviso("Favor reinicializar o processo.", ;
                    "Falha na Conex" + CHR(227) + "o")
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            ELSE
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 COMMIT TRANSACTION")
                *-- Auditoria de todas as trocas realizadas
                SELECT cursor_4c_Contas
                SCAN
                    THIS.RegistrarAuditoria("TROCA: " + ;
                        ALLTRIM(cursor_4c_Contas.ContaAnt) + ;
                        IIF(par_lApagarContaAntiga, ;
                            " (Exclu" + CHR(237) + "da)", "") + ;
                        " -> " + ALLTRIM(cursor_4c_Contas.ContaNov))
                ENDSCAN
                loc_lSucesso = .T.
            ENDIF

            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Processamento")
            TRY
                SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION")
            CATCH TO loc_oErroTran
                *-- ignorar erro de rollback
            ENDTRY
            IF USED("csCampos")
                USE IN csCampos
            ENDIF
            IF USED("csArquivos")
                USE IN csArquivos
            ENDIF
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor
    * Carrega o par (ContaAnt, ContaNov) do registro corrente de um cursor
    * (tipicamente cursor_4c_Contas) para as propriedades da instancia.
    * Usado antes de operacoes de auditoria/edicao individual do par.
    * par_cAliasCursor: nome do cursor (default "cursor_4c_Contas")
    * Returns: .T. em sucesso, .F. se cursor nao existe ou EOF
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        loc_cAlias   = IIF(EMPTY(par_cAliasCursor), "cursor_4c_Contas", par_cAliasCursor)
        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)
                IF NOT EOF() AND NOT BOF()
                    THIS.this_cContaAnt = NVL(EVALUATE(loc_cAlias + ".ContaAnt"), "")
                    THIS.this_cContaNov = NVL(EVALUATE(loc_cAlias + ".ContaNov"), "")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir
    * Insere o par (this_cContaAnt, this_cContaNov) em cursor_4c_Contas apos
    * validar duplicidade via TAG Duplica e igualdade de codigos.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            IF NOT USED("cursor_4c_Contas")
                THIS.InicializarCursorContas()
            ENDIF

            SELECT cursor_4c_Contas
            SET ORDER TO Duplica
            IF SEEK(THIS.this_cContaAnt + THIS.this_cContaNov)
                SET ORDER TO
                MsgAviso("Par de Contas j" + CHR(225) + " existe na lista.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            SET ORDER TO

            APPEND BLANK
            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("INCLUSAO_PAR: " + ;
                ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Incluir")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar
    * Atualiza o registro corrente de cursor_4c_Contas com
    * (this_cContaAnt, this_cContaNov) apos validar duplicidade e igualdade.
    * Registra auditoria no LogAuditoria em caso de sucesso.
    * Returns: .T. em sucesso, .F. se invalido, EOF ou duplicado
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAntigoAnt, loc_cAntigoNov
        loc_lSucesso  = .F.
        loc_cAntigoAnt = ""
        loc_cAntigoNov = ""
        TRY
            IF EMPTY(THIS.this_cContaAnt) OR EMPTY(THIS.this_cContaNov)
                MsgAviso("Informe Conta Antiga e Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF ALLTRIM(THIS.this_cContaAnt) == ALLTRIM(THIS.this_cContaNov)
                MsgAviso("Conta Antiga n" + CHR(227) + "o pode ser igual " + ;
                    "" + CHR(224) + " Conta Nova.", "Aviso")
                loc_lSucesso = .F.
            ENDIF
            IF NOT USED("cursor_4c_Contas")
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Contas
            IF EOF() OR BOF()
                MsgAviso("Nenhum registro selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cAntigoAnt = cursor_4c_Contas.ContaAnt
            loc_cAntigoNov = cursor_4c_Contas.ContaNov

            *-- Se par nao mudou, nada a fazer
            IF loc_cAntigoAnt == THIS.this_cContaAnt AND ;
               loc_cAntigoNov == THIS.this_cContaNov
                loc_lSucesso = .T.
            ENDIF

            REPLACE cursor_4c_Contas.ContaAnt WITH THIS.this_cContaAnt, ;
                    cursor_4c_Contas.ContaNov WITH THIS.this_cContaNov

            THIS.RegistrarAuditoria("ALTERACAO_PAR: (" + ;
                ALLTRIM(loc_cAntigoAnt) + " -> " + ALLTRIM(loc_cAntigoNov) + ;
                ") para (" + ALLTRIM(THIS.this_cContaAnt) + " -> " + ;
                ALLTRIM(THIS.this_cContaNov) + ")")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

