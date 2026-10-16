# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_BARRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrMdc.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1700 linhas total):

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
703:                 WITH loc_oGrid
704:                     .RecordSource = "cursor_4c_Contas"
705: 
706:                     .Column1.ControlSource        = "cursor_4c_Contas.ContaAnt"
707:                     .Column1.Width                = 90
708:                     .Column1.Header1.Caption      = "Conta Antiga"
709: 
710:                     .Column2.ControlSource        = "cursor_4c_Contas.ContaNov"
711:                     .Column2.Width                = 90
712:                     .Column2.Header1.Caption      = "Conta Nova"
713:                 ENDWITH
714: 
715:                 SELECT cursor_4c_Contas
716:                 DO CASE
717:                     CASE loc_cPos == "TOPO"
718:                         GO TOP
719:                     CASE loc_cPos == "FIM"
720:                         GO BOTTOM
721:                 ENDCASE
722: 
723:                 loc_oGrid.Refresh
724:                 loc_lSucesso = .T.

*-- Linhas 735 a 1114:
735:     * BtnIncluirClick - Acrescenta uma linha vazia ao cursor de pares (so se o
736:     * ultimo par ja estiver completo), e foca a primeira coluna da nova linha
737:     *==========================================================================
738:     PROCEDURE BtnIncluirClick()
739:     *==========================================================================
740:         LOCAL loc_oErro, loc_nRec
741: 
742:         TRY
743:             loc_nRec = 0
744: 
745:             IF USED("cursor_4c_Contas")
746:                 SELECT cursor_4c_Contas
747:                 IF !EMPTY(ALLTRIM(NVL(ContaAnt, ""))) AND !EMPTY(ALLTRIM(NVL(ContaNov, "")))
748:                     APPEND BLANK
749:                 ENDIF
750:                 *-- O legado fecha com "Grade.Refresh", que NAO move o ponteiro:
751:                 *-- depois do APPEND BLANK ele fica na linha NOVA, e eh nela que o
752:                 *-- SetFocus abaixo poe o usuario para digitar. CarregarLista
753:                 *-- reatribui o RecordSource, e isso devolve o ponteiro ao registro
754:                 *-- 1 (medido no VFP9) - sem guardar/repor o RECNO o usuario clica
755:                 *-- Incluir e cai na PRIMEIRA linha, ja preenchida, em vez da nova.
756:                 *-- Vale nos dois ramos: quando a guarda acima bloqueia o APPEND, o
757:                 *-- legado tambem deixa o ponteiro onde estava.
758:                 loc_nRec = RECNO()
759:             ENDIF
760: 
761:             THIS.CarregarLista("")
762: 
763:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
764:                 SELECT cursor_4c_Contas
765:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
766:                     GO loc_nRec
767:                 ENDIF
768:             ENDIF
769: 
770:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
771:         CATCH TO loc_oErro
772:             MsgErro(loc_oErro.Message, "Erro ao incluir linha")
773:         ENDTRY
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * BtnExcluirClick - Remove a linha corrente do cursor de pares
778:     *==========================================================================
779:     PROCEDURE BtnExcluirClick()
780:     *==========================================================================
781:         LOCAL loc_oErro, loc_nRec
782: 
783:         TRY
784:             loc_nRec = 0
785: 
786:             IF USED("cursor_4c_Contas")
787:                 SELECT cursor_4c_Contas
788:                 IF !EOF()
789:                     DELETE
790:                 ENDIF
791:                 *-- Mesma razao do BtnIncluirClick: o "Grade.Refresh" do legado
792:                 *-- nao move o ponteiro, mas CarregarLista reatribui o
793:                 *-- RecordSource e o devolve ao registro 1. Repor o RECNO mantem
794:                 *-- o usuario na vizinhanca da linha que ele acabou de apagar
795:                 *-- (com SET DELETED ON a propria linha apagada ja nao eh
796:                 *-- navegavel, e a grade passa a mostrar a seguinte)
797:                 loc_nRec = RECNO()
798:             ENDIF
799: 
800:             THIS.CarregarLista("")
801: 
802:             IF loc_nRec > 0 AND USED("cursor_4c_Contas")
803:                 SELECT cursor_4c_Contas
804:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
805:                     GO loc_nRec
806:                 ENDIF
807:             ENDIF
808: 
809:             THIS.grd_4c_Dados.Column1.Text1.SetFocus
810:         CATCH TO loc_oErro
811:             MsgErro(loc_oErro.Message, "Erro ao excluir linha")
812:         ENDTRY
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * BtnSairClick - Encerra o form (btnSair.Click do legado)
817:     *==========================================================================
818:     PROCEDURE BtnSairClick()
819:     *==========================================================================
820:         THIS.Release
821:     ENDPROC
822: 
823:     *==========================================================================
824:     * ChkRepsClick - Ligar "Trocar Apenas Representantes" desliga e desabilita
825:     * "Apagar a Conta Antiga do Cadastro" (chkReps.Click + Chk_DelCT.When do
826:     * legado: Chk_DelCT so pode ser marcado quando chkReps = 0)
827:     *==========================================================================
828:     PROCEDURE ChkRepsClick()
829:     *==========================================================================
830:         IF THIS.chk_4c_ChkReps.Value = 1
831:             THIS.chk_4c_Chk_DelCT.Value = 0
832:         ENDIF
833:         THIS.chk_4c_Chk_DelCT.Enabled = (THIS.chk_4c_ChkReps.Value = 0)
834:     ENDPROC
835: 
836:     *==========================================================================
837:     * TxtContaAntKeyPress - Lookup de conta na coluna "Conta Antiga" (Column1).
838:     * Legado: Valid do Column1.Text1, pulado quando this_lCheckCadPro = .T.
839:     *==========================================================================
840:     PROCEDURE TxtContaAntKeyPress
841:     *==========================================================================
842:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
843: 
844:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
845:             RETURN
846:         ENDIF
847: 
848:         IF THIS.this_lCheckCadPro
849:             RETURN
850:         ENDIF
851: 
852:         THIS.ValidarCelulaConta(1)
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * TxtContaNovKeyPress - Lookup de conta na coluna "Conta Nova" (Column2).
857:     * Legado: Valid do Column2.Text1, sempre executa (sem guarda de CheckCadPro)
858:     *==========================================================================
859:     PROCEDURE TxtContaNovKeyPress
860:     *==========================================================================
861:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
862: 
863:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9 AND par_nKeyCode <> 115
864:             RETURN
865:         ENDIF
866: 
867:         THIS.ValidarCelulaConta(2)
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * ValidarCelulaConta - Valida o codigo digitado na celula (1=ContaAnt,
872:     * 2=ContaNov) contra SigCdCli; achando, grava no cursor; nao achando, abre
873:     * o picker (FormBuscaAuxiliar) com o digitado como prefixo
874:     *==========================================================================
875:     PROCEDURE ValidarCelulaConta(par_nColuna)
876:     *==========================================================================
877:         LOCAL loc_cVal, loc_oErro, loc_oColuna, loc_cCampo
878: 
879:         IF par_nColuna = 1
880:             loc_oColuna = THIS.grd_4c_Dados.Column1
881:             loc_cCampo  = "ContaAnt"
882:         ELSE
883:             loc_oColuna = THIS.grd_4c_Dados.Column2
884:             loc_cCampo  = "ContaNov"
885:         ENDIF
886: 
887:         loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))
888: 
889:         TRY
890:             IF EMPTY(loc_cVal)
891:                 SELECT cursor_4c_Contas
892:                 REPLACE (loc_cCampo) WITH ""
893:             ELSE
894:                 *-- ValidarCodigoConta devolve o CODIGO achado (string) ou "",
895:                 *-- nunca um logico: usar o retorno direto num IF estouraria
896:                 *-- "Operator/operand type mismatch"
897:                 IF !EMPTY(THIS.this_oBusinessObject.ValidarCodigoConta(loc_cVal))
898:                     SELECT cursor_4c_Contas
899:                     REPLACE (loc_cCampo) WITH loc_cVal
900:                 ELSE
901:                     *-- Universo vazio / codigo inexistente NAO eh erro: o legado
902:                     *-- nao avisa nem apaga o digitado, so abre o browse com o
903:                     *-- valor como prefixo (regra #50)
904:                     THIS.AbrirBuscaConta(par_nColuna)
905:                 ENDIF
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "Erro ao validar conta")
909:         ENDTRY
910:     ENDPROC
911: 
912:     *==========================================================================
913:     * AbrirBuscaConta - Abre FormBuscaAuxiliar para selecao de conta (SigCdCli),
914:     * equivalente ao fwBuscaExt do Valid de Column1/Column2.Text1 do legado
915:     *==========================================================================
916:     PROCEDURE AbrirBuscaConta(par_nColuna)
917:     *==========================================================================
918:         LOCAL loc_oLookup, loc_cVal, loc_oErro, loc_oColuna, loc_cCampo
919: 
920:         IF par_nColuna = 1
921:             loc_oColuna = THIS.grd_4c_Dados.Column1
922:             loc_cCampo  = "ContaAnt"
923:         ELSE
924:             loc_oColuna = THIS.grd_4c_Dados.Column2
925:             loc_cCampo  = "ContaNov"
926:         ENDIF
927: 
928:         loc_cVal = ALLTRIM(NVL(loc_oColuna.Text1.Value, ""))
929: 
930:         TRY
931:             loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
932:                 "cursor_4c_BuscaConta", "Iclis", loc_cVal, ;
933:                 "Sele" + CHR(231) + CHR(227) + "o", .T., .T., "")
934: 
935:             IF VARTYPE(loc_oLookup) <> "O"
936:                 MsgErro("Erro ao abrir busca de conta.", "Erro")
937:             ELSE
938:                 loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
939:                 loc_oLookup.mAddColuna("Rclis", "", "Descri" + CHR(231) + CHR(227) + "o")
940:                 loc_oLookup.mAddColuna("Grupos", "", "Grupo")
941:                 loc_oLookup.Show()
942: 
943:                 IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_BuscaConta")
944:                     SELECT cursor_4c_BuscaConta
945:                     loc_cVal = ALLTRIM(NVL(cursor_4c_BuscaConta.Iclis, ""))
946:                     USE IN cursor_4c_BuscaConta
947: 
948:                     SELECT cursor_4c_Contas
949:                     REPLACE (loc_cCampo) WITH loc_cVal
950:                     loc_oColuna.Text1.Value = loc_cVal
951:                 ELSE
952:                     IF USED("cursor_4c_BuscaConta")
953:                         USE IN cursor_4c_BuscaConta
954:                     ENDIF
955:                 ENDIF
956:             ENDIF
957:         CATCH TO loc_oErro
958:             IF USED("cursor_4c_BuscaConta")
959:                 USE IN cursor_4c_BuscaConta
960:             ENDIF
961:             MsgErro(loc_oErro.Message, "Erro ao buscar conta")
962:         ENDTRY
963:     ENDPROC
964: 
965:     *==========================================================================
966:     * BtnExportaClick - Importa pares Conta Antiga/Conta Nova de planilha XLS
967:     * para cursor_4c_Contas (Exporta.Click do legado - nome legado, funcao de import)
968:     *==========================================================================
969:     PROCEDURE BtnExportaClick()
970:     *==========================================================================
971:         LOCAL loc_cArquivo, loc_nImportados, loc_oErro, loc_nAntes, loc_lOk
972: 
973:         loc_nImportados = 0
974:         loc_nAntes      = 0
975:         loc_lOk         = .F.
976: 
977:         TRY
978:             loc_cArquivo = GETFILE("XLS")
979: 
980:             IF EMPTY(loc_cArquivo)
981:                 MsgAviso("Arquivo para Importa" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
982:                     "o informado!!!", "Aviso")
983:             ELSE
984:                 IF !FILE(loc_cArquivo)
985:                     MsgErro("O Arquivo [" + ALLTRIM(loc_cArquivo) + "]" + CHR(13) + ;
986:                         "N" + CHR(227) + "o Foi Encontrado ou o Acesso Foi Negado!!! Verifique!!!", "Erro")
987:                 ELSE
988:                     *-- FormParaBO leva CheckCadPro (que decide se a importacao
989:                     *-- valida ContaAnt contra SigCdCli) e os dois checkboxes
990:                     THIS.FormParaBO()
991: 
992:                     *-- ImportarDeXLS devolve LOGICO, nao a contagem: o numero de
993:                     *-- pares aceitos eh a variacao do RECCOUNT do cursor, que eh
994:                     *-- onde o BO deduplica via TAG Duplica
995:                     loc_nAntes = IIF(USED("cursor_4c_Contas"), RECCOUNT("cursor_4c_Contas"), 0)
996: 
997:                     loc_lOk = THIS.this_oBusinessObject.ImportarDeXLS(loc_cArquivo)
998: 
999:                     loc_nImportados = IIF(USED("cursor_4c_Contas"), ;
1000:                         RECCOUNT("cursor_4c_Contas") - loc_nAntes, 0)
1001: 
1002:                     *-- Legado fecha com "Go bott / Grade.Refresh"
1003:                     THIS.CarregarLista("FIM")
1004: 
1005:                     IF loc_lOk AND loc_nImportados > 0
1006:                         MsgInfo(TRANSFORM(loc_nImportados) + " par(es) importado(s) com sucesso.", ;
1007:                             "Importa" + CHR(231) + CHR(227) + "o")
1008:                     ELSE
1009:                         IF loc_lOk
1010:                             MsgAviso("Nenhum par v" + CHR(225) + "lido encontrado na planilha.", ;
1011:                                 "Importa" + CHR(231) + CHR(227) + "o")
1012:                         ENDIF
1013:                     ENDIF
1014:                 ENDIF
1015:             ENDIF
1016:         CATCH TO loc_oErro
1017:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1018:                 "Erro BtnExportaClick FormSigPrMdc")
1019:         ENDTRY
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * BtnProcessarClick - Processa a troca de contas (btnProcessar.Click do
1024:     * legado). Com chkReps=1 troca so SigCdCli.ContaVens (representantes); caso
1025:     * contrario percorre o catalogo ArqDBF e atualiza/exclui em todos os
1026:     * arquivos elegiveis. fRecalculaP/fRecalculaC nao portadas (regra #27 -
1027:     * funcoes de CALCULO de saldo nunca recebem stub; recalculo omitido, igual
1028:     * ao padrao ja adotado em Formsigprmdp.prg/sigprmdpBO.prg).
1029:     *==========================================================================
1030:     PROCEDURE BtnProcessarClick()
1031:     *==========================================================================
1032:         LOCAL loc_cMensagem, loc_oErro, loc_lOk, loc_lManual
1033:         LOCAL loc_nErro, loc_nRec, loc_nCnt, loc_nPct
1034:         LOCAL loc_cArq, loc_cCpo, loc_cSql, loc_cWhere, loc_lContaNovaExiste
1035:         LOCAL loc_lReiniciar
1036: 
1037:         loc_cMensagem = ""
1038: 
1039:         *-- A conexao do projeto nasce com Transactions = 2 (MANUAL), e eh por
1040:         *-- isso que o COMMIT/ROLLBACK abaixo tem de ser feito com SQLCOMMIT/
1041:         *-- SQLROLLBACK do VFP e nao com "COMMIT TRANSACTION" via SQLEXEC (que
1042:         *-- so aninharia @@TRANCOUNT sem efetivar nada). Handle invalido faz
1043:         *-- SQLGETPROP estourar FORA de TRY - dai a guarda, senao o usuario
1044:         *-- veria o Program Error cru do VFP ao clicar Processar.
1045:         loc_lManual = .F.
1046:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1047:             TRY
1048:                 loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
1049:             CATCH TO loc_oErro
1050:                 loc_lManual = .F.
1051:             ENDTRY
1052:         ENDIF
1053: 
1054:         *-- loc_lReiniciar reproduz o "Return 0" do legado no ramo de falha do
1055:         *-- processamento de arquivos: ali o legado NAO exibe a mensagem final e
1056:         *-- NAO reseta a lista de pares (deixa o painel visivel com a barra em 0
1057:         *-- e a mensagem "Favor reinicializar o processo"), para o usuario poder
1058:         *-- corrigir e tentar de novo sem redigitar tudo. Como RETURN dentro de
1059:         *-- TRY/CATCH eh proibido (regra #1), o early-exit vira esta flag.
1060:         loc_lReiniciar = .F.
1061: 
1062:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1063:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro")
1064:             RETURN
1065:         ENDIF
1066: 
1067:         *-- ValidarParesContas devolve LOGICO e escreve a mensagem no parametro:
1068:         *-- VFP9 passa por VALOR em chamada de metodo, entao o @ eh OBRIGATORIO
1069:         *-- (sem ele loc_cMensagem volta vazia e o aviso do legado desaparece)
1070:         IF !THIS.this_oBusinessObject.ValidarParesContas(@loc_cMensagem)
1071:             IF EMPTY(loc_cMensagem)
1072:                 loc_cMensagem = "N" + CHR(227) + "o Existem Contas a Serem Processadas!!!"
1073:             ENDIF
1074:             MsgAviso(loc_cMensagem, "Aten" + CHR(231) + CHR(227) + "o!!!")
1075:             THIS.grd_4c_Dados.Column1.SetFocus
1076:             RETURN
1077:         ENDIF
1078: 
1079:         IF !MsgConfirma("Confirma a Troca das Contas ?", ;
1080:                 "Confirma" + CHR(231) + CHR(227) + "o do Processamento!!!")
1081:             THIS.cmd_4c_BtnSair.SetFocus
1082:             RETURN
1083:         ENDIF
1084: 
1085:         *-- Leva os dois checkboxes e o CheckCadPro para o BO antes de processar
1086:         THIS.FormParaBO()
1087: 
1088:         loc_lOk = .T.
1089: 
1090:         IF THIS.chk_4c_ChkReps.Value = 1
1091:             *-- Trocar Apenas Representantes (ThisForm.TrocarReps() do legado):
1092:             *-- o BO percorre o proprio cursor_4c_Contas, sem parametro
1093:             loc_lOk = THIS.this_oBusinessObject.TrocarContaRepresentantes()
1094:         ELSE
1095:             *-- Catalogo de campos: quem resolve e valida o caminho eh o BO
1096:             *-- (ValidarArqDBF ja exibe o aviso do legado "O ArqDBF nao esta no
1097:             *-- diretorio do Sistema!!!"); BOParaForm traz o caminho resolvido
1098:             *-- de volta para this_cArqDBFPath, usado no USE ... ALIAS ArqDBF
1099:             IF !THIS.this_oBusinessObject.ValidarArqDBF()
1100:                 RETURN
1101:             ENDIF
1102: 
1103:             THIS.BOParaForm()
1104: 
1105:             IF EMPTY(THIS.this_cArqDBFPath) OR !FILE(THIS.this_cArqDBFPath + ".dbf")
1106:                 MsgErro("ArqDBF n" + CHR(227) + "o localizado para processamento.", ;
1107:                     "Erro de Configura" + CHR(231) + CHR(227) + "o")
1108:                 RETURN
1109:             ENDIF
1110: 
1111:             loc_nErro = 1
1112: 
1113:             *-- Funil unico de estado: PROCESSANDO desabilita grade e botoes para
1114:             *-- o usuario nao reentrar no SCAN multi-tabela (regra #40 - quem

*-- Linhas 1373 a 1535:
1373:             IF loc_lOk
1374:                 MsgInfo("Todas as Contas Foram Alteradas!!!", "Processamento Encerrado!!!")
1375:             ELSE
1376:                 MsgAviso("As Contas N" + CHR(227) + "o Foram Alteradas!!!", ;
1377:                     "Processamento Encerrado!!!")
1378:             ENDIF
1379: 
1380:             *-- Reseta a lista de pares para o proximo lote (Zap + Append Blank
1381:             *-- do legado). NAO roda no ramo de reinicializacao: ali o legado
1382:             *-- preserva os pares para o usuario corrigir e reprocessar
1383:             THIS.LimparCampos()
1384:         ENDIF
1385: 
1386:         THIS.grd_4c_Dados.Column1.SetFocus
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * HabilitarCampos - Habilita/desabilita grid e botoes durante processamento,
1391:     * para evitar cliques enquanto o SCAN multi-tabela esta em andamento.
1392:     * O botao Encerrar NAO entra: o legado nunca o desabilita, e trava-lo
1393:     * deixaria a tela sem saida durante um lote longo.
1394:     *
1395:     * Chk_DelCT carrega tambem a dependencia do Chk_DelCT.When do legado
1396:     * ("Return (ThisForm.chkReps.Value = 0)"): ele so eh clicavel enquanto
1397:     * "Trocar Apenas Representantes" estiver desmarcado.
1398:     *==========================================================================
1399:     PROCEDURE HabilitarCampos(par_lHabilitar)
1400:     *==========================================================================
1401:         LOCAL loc_lHab
1402:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1403: 
1404:         THIS.grd_4c_Dados.Enabled        = loc_lHab
1405:         THIS.cmd_4c_BtnIncluir.Enabled   = loc_lHab
1406:         THIS.cmd_4c_BtnExcluir.Enabled   = loc_lHab
1407:         THIS.cmd_4c_Exporta.Enabled      = loc_lHab
1408:         THIS.cmd_4c_BtnProcessar.Enabled = loc_lHab
1409:         THIS.chk_4c_ChkReps.Enabled      = loc_lHab
1410:         THIS.chk_4c_Chk_DelCT.Enabled    = loc_lHab AND (THIS.chk_4c_ChkReps.Value = 0)
1411:     ENDPROC
1412: 
1413:     *==========================================================================
1414:     * AjustarBotoesPorModo - FUNIL UNICO do estado da tela. Chamado tanto na
1415:     * IDA (BtnProcessarClick, modo "PROCESSANDO") quanto na VOLTA (fim do
1416:     * processamento e LimparCampos, modo "EDICAO"): regra #40 - quem desabilita
1417:     * botao tem de reabilitar no funil de volta, senao a tela fica inutilizavel
1418:     * depois do primeiro processamento e so volta ao normal se for reaberta.
1419:     *
1420:     * NAO existem modos CRUD aqui: o legado herda de `form` (nao de
1421:     * frmcadastro), nao tem pcEscolha nem os botoes Incluir/Alterar/Visualizar/
1422:     * Excluir/Buscar de cadastro - inventa-los violaria o PILAR 1.
1423:     *==========================================================================
1424:     PROCEDURE AjustarBotoesPorModo()
1425:     *==========================================================================
1426:         LOCAL loc_lEdicao
1427: 
1428:         *-- Qualquer valor que nao seja "PROCESSANDO" eh tratado como edicao:
1429:         *-- assim um modo nao previsto nunca deixa a tela travada
1430:         loc_lEdicao = !(UPPER(ALLTRIM(THIS.this_cModoAtual)) == "PROCESSANDO")
1431: 
1432:         THIS.HabilitarCampos(loc_lEdicao)
1433:     ENDPROC
1434: 
1435:     *==========================================================================
1436:     * AtualizarProgresso - FUNIL UNICO do painel de progresso (cntResult do
1437:     * legado). Tambem eh o metodo que o SigPrMdcBO.ProcessarMudancaContas
1438:     * espera encontrar no form que recebe por par_oForm - sem ele aquela
1439:     * chamada estoura "Property ATUALIZARPROGRESSO is not found" em runtime.
1440:     *
1441:     * par_cArquivo: texto do campo "Arquivo/Campo" ("" mantem o atual)
1442:     * par_nPct    : 0..100 reposiciona a barra; valor negativo (ou ausente)
1443:     *               mantem a barra como esta - usado nos dois SCAN internos,
1444:     *               que no legado atualizam SO o texto do arquivo/campo
1445:     * PUBLIC de proposito: chamado de fora da classe pelo BO (regra #3/#51).
1446:     *==========================================================================
1447:     PROCEDURE AtualizarProgresso(par_cArquivo, par_nPct)
1448:     *==========================================================================
1449:         LOCAL loc_cArq, loc_nPct, loc_oErro
1450: 
1451:         loc_cArq = IIF(VARTYPE(par_cArquivo) = "C", par_cArquivo, "")
1452:         loc_nPct = IIF(VARTYPE(par_nPct) = "N", par_nPct, -1)
1453: 
1454:         TRY
1455:             IF !EMPTY(loc_cArq)
1456:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Value = loc_cArq
1457:                 THIS.cnt_4c_Result.txt_4c_Arquivo.Refresh
1458:             ENDIF
1459: 
1460:             IF loc_nPct >= 0
1461:                 IF loc_nPct > 100
1462:                     loc_nPct = 100
1463:                 ENDIF
1464:                 *-- Barra interna tem 222px uteis: 2px por ponto percentual,
1465:                 *-- como no legado (Int((lnRec*100)/lnCnt) * 2)
1466:                 THIS.cnt_4c_Result.cnt_4c_Barra.shp_4c_ShpBarra.Width      = loc_nPct * 2
1467:                 THIS.cnt_4c_Result.cnt_4c_Barra.lbl_4c_LblPorcento.Caption = ;
1468:                     ALLTRIM(STR(loc_nPct)) + " %"
1469:                 THIS.cnt_4c_Result.cnt_4c_Barra.Refresh
1470:             ENDIF
1471:         CATCH TO loc_oErro
1472:             MsgErro(loc_oErro.Message, "Erro AtualizarProgresso FormSigPrMdc")
1473:         ENDTRY
1474:     ENDPROC
1475: 
1476:     *==========================================================================
1477:     * LimparCampos - Reseta a lista de pares para o proximo lote ("Select
1478:     * csContas / Set Order To / Zap / Append Blank" do fim do btnProcessar.Click
1479:     * legado) e devolve a tela ao estado de edicao.
1480:     *
1481:     * Os dois checkboxes NAO sao zerados: o legado tambem nao os zera no fim do
1482:     * processamento, e mexer neles mudaria o comportamento que o usuario ve
1483:     * (PILAR 1). Quem precisa dos valores sincronizados chama FormParaBO.
1484:     *
1485:     * PROTECTED EXPLICITO: FormBase declara LimparCampos / FormParaBO /
1486:     * BOParaForm como PROTECTED e o VFP9 NAO deixa a subclasse alargar o escopo
1487:     * - escrever "PROCEDURE" sem o modificador nao torna o metodo publico, so
1488:     * esconde que ele continua protegido (medido: chamada de fora estoura
1489:     * "Property LIMPARCAMPOS is not found", mas PEMSTATUS(...,5) devolve .T. e
1490:     * mente). Chamar SEMPRE por THIS. de dentro da classe. Metodo que precise
1491:     * ser alcancado de fora nao pode usar um desses tres nomes - eh por isso que
1492:     * o funil do painel de progresso se chama AtualizarProgresso (nome ausente
1493:     * em FormBase, logo publico de verdade) e eh ele que o BO recebe em par_oForm.
1494:     *==========================================================================
1495:     PROTECTED PROCEDURE LimparCampos()
1496:     *==========================================================================
1497:         LOCAL loc_cSafety, loc_oErro, loc_lSucesso
1498:         loc_lSucesso = .F.
1499: 
1500:         TRY
1501:             IF !USED("cursor_4c_Contas")
1502:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1503:                     THIS.this_oBusinessObject.InicializarCursorContas()
1504:                 ENDIF
1505:             ELSE
1506:                 *-- DataSession privada (=2) nasce com SET SAFETY ON (nao herda o
1507:                 *-- OFF do main.prg): sem a guarda o ZAP abre dialogo modal de
1508:                 *-- confirmacao e congela o processo em execucao desassistida
1509:                 loc_cSafety = SET("SAFETY")
1510:                 SET SAFETY OFF
1511:                 SELECT cursor_4c_Contas
1512:                 SET ORDER TO
1513:                 ZAP
1514:                 APPEND BLANK
1515:                 IF loc_cSafety == "ON"
1516:                     SET SAFETY ON
1517:                 ENDIF
1518:             ENDIF
1519: 
1520:             *-- Zerar o cursor NAO repinta a grade (regra #21): repintura pelo
1521:             *-- mesmo funil usado por todos os outros caminhos
1522:             THIS.CarregarLista("TOPO")
1523: 
1524:             THIS.this_cModoAtual = "EDICAO"
1525:             THIS.AjustarBotoesPorModo()
1526: 
1527:             *-- Par corrente do BO acompanha o cursor recem-zerado
1528:             THIS.FormParaBO()
1529: 
1530:             loc_lSucesso = .T.
1531:         CATCH TO loc_oErro
1532:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1533:                 "Erro LimparCampos FormSigPrMdc")
1534:         ENDTRY
1535: 

*-- Linhas 1552 a 1700:
1552:     * atribuir direto trocaria o tipo da property e estouraria "Data type
1553:     * mismatch" no primeiro AND do BO - a conversao "= 1" eh obrigatoria.
1554:     *==========================================================================
1555:     PROTECTED PROCEDURE FormParaBO()
1556:     *==========================================================================
1557:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1558:         loc_lSucesso = .F.
1559: 
1560:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1561:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro FormParaBO")
1562:         ELSE
1563:             TRY
1564:                 loc_oBO = THIS.this_oBusinessObject
1565: 
1566:                 loc_oBO.this_lTrocarReps        = (THIS.chk_4c_ChkReps.Value = 1)
1567:                 loc_oBO.this_lApagarContaAntiga = (THIS.chk_4c_Chk_DelCT.Value = 1)
1568:                 loc_oBO.this_lCheckCadPro       = THIS.this_lCheckCadPro
1569:                 loc_oBO.this_cArqDBFPath        = THIS.this_cArqDBFPath
1570: 
1571:                 *-- Par corrente (a grade eh a unica "entrada de dados" da tela)
1572:                 IF USED("cursor_4c_Contas") AND !EOF("cursor_4c_Contas")
1573:                     loc_oBO.this_cContaAnt = TratarNulo(cursor_4c_Contas.ContaAnt, "")
1574:                     loc_oBO.this_cContaNov = TratarNulo(cursor_4c_Contas.ContaNov, "")
1575:                 ELSE
1576:                     loc_oBO.this_cContaAnt = ""
1577:                     loc_oBO.this_cContaNov = ""
1578:                 ENDIF
1579: 
1580:                 loc_lSucesso = .T.
1581:             CATCH TO loc_oErro
1582:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1583:                     "Erro FormParaBO FormSigPrMdc")
1584:             ENDTRY
1585:         ENDIF
1586: 
1587:         RETURN loc_lSucesso
1588:     ENDPROC
1589: 
1590:     *==========================================================================
1591:     * BOParaForm - Caminho inverso do FormParaBO: reflete na tela o estado que
1592:     * o BO detem. Usado quando o BO decide o estado (ex.: ValidarArqDBF, que
1593:     * resolve o caminho do catalogo, e os dois flags de processamento).
1594:     *
1595:     * O par de contas NAO eh escrito de volta na grade: a linha corrente eh do
1596:     * cursor, e sobrescrever a celula aqui apagaria o que o usuario digitou e
1597:     * ainda nao confirmou. Quem grava no cursor eh ValidarCelulaConta/
1598:     * AbrirBuscaConta, que tem o valor resolvido.
1599:     *==========================================================================
1600:     PROTECTED PROCEDURE BOParaForm()
1601:     *==========================================================================
1602:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1603:         loc_lSucesso = .F.
1604: 
1605:         IF VARTYPE(THIS.this_oBusinessObject) <> "O"
1606:             MsgErro("BO n" + CHR(227) + "o inicializado.", "Erro BOParaForm")
1607:         ELSE
1608:             TRY
1609:                 loc_oBO = THIS.this_oBusinessObject
1610: 
1611:                 *-- Propriedade LOGICA do BO -> CheckBox.Value NUMERICO
1612:                 THIS.chk_4c_ChkReps.Value   = IIF(loc_oBO.this_lTrocarReps, 1, 0)
1613:                 THIS.chk_4c_Chk_DelCT.Value = IIF(loc_oBO.this_lApagarContaAntiga, 1, 0)
1614: 
1615:                 THIS.this_lCheckCadPro = loc_oBO.this_lCheckCadPro
1616: 
1617:                 IF !EMPTY(loc_oBO.this_cArqDBFPath)
1618:                     THIS.this_cArqDBFPath = loc_oBO.this_cArqDBFPath
1619:                 ENDIF
1620: 
1621:                 *-- Dependencia do Chk_DelCT.When do legado tem de ser reaplicada
1622:                 *-- depois de mexer no Value dos dois checkboxes
1623:                 THIS.ChkRepsClick()
1624: 
1625:                 loc_lSucesso = .T.
1626:             CATCH TO loc_oErro
1627:                 MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1628:                     "Erro BOParaForm FormSigPrMdc")
1629:             ENDTRY
1630:         ENDIF
1631: 
1632:         RETURN loc_lSucesso
1633:     ENDPROC
1634: 
1635:     *==========================================================================
1636:     * TornarControlesVisiveis - Torna visiveis os controles criados por
1637:     * AddObject (nascem com Visible=.F.), recursando em Pages e Containers.
1638:     * cnt_4c_Result eh container flutuante (painel de progresso oculto por
1639:     * padrao) - recursa nos filhos mas NAO forca Visible=.T. no proprio
1640:     * container, preservando o estado definido em ConfigurarPainelResultado.
1641:     *==========================================================================
1642:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1643:     *==========================================================================
1644:         LOCAL loc_nI, loc_oControle
1645: 
1646:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1647:             loc_oControle = par_oContainer.Controls(loc_nI)
1648: 
1649:             IF VARTYPE(loc_oControle) != "O"
1650:                 LOOP
1651:             ENDIF
1652: 
1653:             IF UPPER(loc_oControle.Name) = "CNT_4C_RESULT"
1654:                 IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1655:                     THIS.TornarControlesVisiveis(loc_oControle)
1656:                 ENDIF
1657:                 LOOP
1658:             ENDIF
1659: 
1660:             IF PEMSTATUS(loc_oControle, "Visible", 5)
1661:                 loc_oControle.Visible = .T.
1662:             ENDIF
1663: 
1664:             IF UPPER(loc_oControle.BaseClass) = "PAGEFRAME"
1665:                 LOCAL loc_nP
1666:                 FOR loc_nP = 1 TO loc_oControle.PageCount
1667:                     THIS.TornarControlesVisiveis(loc_oControle.Pages(loc_nP))
1668:                 ENDFOR
1669:             ENDIF
1670: 
1671:             IF PEMSTATUS(loc_oControle, "ControlCount", 5)
1672:                 THIS.TornarControlesVisiveis(loc_oControle)
1673:             ENDIF
1674:         ENDFOR
1675:     ENDPROC
1676: 
1677:     *==========================================================================
1678:     PROCEDURE Destroy()
1679:     *==========================================================================
1680:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1681:             THIS.this_oBusinessObject = .NULL.
1682:         ENDIF
1683: 
1684:         IF USED("cursor_4c_Contas")
1685:             USE IN cursor_4c_Contas
1686:         ENDIF
1687:         IF USED("csCampos")
1688:             USE IN csCampos
1689:         ENDIF
1690:         IF USED("csArquivos")
1691:             USE IN csArquivos
1692:         ENDIF
1693:         IF USED("ArqDBF")
1694:             USE IN ArqDBF
1695:         ENDIF
1696: 
1697:         DODEFAULT()
1698:     ENDPROC
1699: 
1700: ENDDEFINE


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

