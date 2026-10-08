# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.SelecionarTipo()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterMetodoRotina()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CriaPlanilha()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidaCols()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarRotinaImportacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_MvCab' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_MvItn' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_MvIts' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_MvHst' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpCot' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpTotal' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_PrNaoCad' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_PrSemCT' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGPRILA.cntplanilha): Top original=80 vs migrado 'obj_4c_OptTipo' Top=5 (diff=75px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptTipo' (parent: SIGPRILA.cntplanilha): Left original=335 vs migrado 'obj_4c_OptTipo' Left=5 (diff=330px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptPreco' (parent: SIGPRILA.cntplanilha): Top original=140 vs migrado 'obj_4c_OptPreco' Top=5 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptPreco' (parent: SIGPRILA.cntplanilha): Left original=335 vs migrado 'obj_4c_OptPreco' Left=5 (diff=330px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprila.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1276 linhas total):

*-- Linhas 10 a 172:
10: *       (Grupo_Botao), nos moldes de Formsigprsen.
11: * SCX Origem: sigprila.SCX (tasks\task627)
12: *
13: * Eventos do legado ligados por BINDEVENT em ConfigurarEventos:
14: *   Grupo_Botao.cmdok.Click   -> BtnProcessarClick   -> Processamento
15: *   Grupo_Botao.cmdsair.Click -> BtnEncerrarClick    -> Release
16: *   cntplanilha.cmdgetp.Click -> BtnGetPlanilhaClick -> GETFILE
17: *   cmbTipos.InteractiveChange -> CboTiposInteractiveChange -> CompletaLista
18: *   SIGPRILA.KeyPress (ESC)   -> BtnEncerrarClick
19: * As SETE rotinas de importacao que Processamento despacha (ListaPreco/
20: * GeraTransf/AtuaPreco/GeraPedido/Pedidocons/PedidoFab/PedAcesso) sao regra
21: * de negocio e moram em sigprilaBO, alcancadas por ObterMetodoRotina.
22: *
23: * Superficie que esta tela NAO tem (e por isso nao esta migrada): grade de
24: * registros, barra CRUD e modo de edicao cancelavel. O SCX legado nao tem
25: * nenhum dos tres - nem BaseClass grid/pageframe, nem Grupo_Op/frmcadastro,
26: * nem pcEscolha - e os DEZ AddCursor do Init passam '' na posicao do objeto
27: * de grade. O que a tela tem eh criterio digitavel (tipo de importacao,
28: * arquivo, cabecalho na 1a linha, Validar e Preco) mais UM botao de acao que
29: * le o .xls e GRAVA em tabela de verdade, e UM botao que so fecha. Os dois
30: * hooks de transferencia (FormParaBO / BOParaForm) sao o par que liga esse
31: * criterio ao BO nos dois sentidos.
32: *==============================================================================
33: DEFINE CLASS Formsigprila AS FormBase
34: 
35:     *-- Dimensoes pixel-perfect do SCX original (PILAR 1) - layout.json:
36:     *-- form.width=800 / form.height=350 (analise.json trazia 1000x600, mas
37:     *-- esse arquivo nao foi preenchido pela analise desta task - campos/
38:     *-- lookups/labels/grid todos vazios - entao prevalece o dump real)
39:     Width        = 800
40:     Height       = 350
41:     Caption      = "Importa" + CHR(231) + CHR(227) + "o de Planilha"
42:     AutoCenter   = .T.
43:     ShowTips     = .T.
44:     ShowWindow   = 1
45:     WindowType   = 1
46:     ControlBox   = .F.
47:     Closable     = .F.
48:     MaxButton    = .F.
49:     MinButton    = .F.
50:     TitleBar     = 0
51:     ClipControls = .F.
52:     DataSession  = 2
53:     KeyPreview   = .T.
54:     FontName     = "Tahoma"
55:     FontSize     = 8
56: 
57:     *--------------------------------------------------------------------------
58:     * Init - Apenas delega para FormBase.Init() -> InicializarForm()
59:     *--------------------------------------------------------------------------
60:     PROCEDURE Init()
61:         RETURN DODEFAULT()
62:     ENDPROC
63: 
64:     *--------------------------------------------------------------------------
65:     * InicializarForm - Cria o BO, aplica background e monta a casca do layout
66:     *--------------------------------------------------------------------------
67:     PROTECTED PROCEDURE InicializarForm()
68:         LOCAL loc_lSucesso, loc_oErro
69:         loc_lSucesso = .F.
70: 
71:         TRY
72:             THIS.this_oBusinessObject = CREATEOBJECT("sigprilaBO")
73: 
74:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
75:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
76:                 THIS.ConfigurarPageFrame()
77:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
78:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
79:                 THIS.ConfigurarEventos()
80:                 THIS.PreencheTipo()
81:                 *-- Painel abre no estado dos criterios guardados no BO, para
82:                 *-- tela e BO nunca comecarem divergentes. Visualmente nao muda
83:                 *-- nada hoje (os defaults do BO sao os mesmos do SCX: arquivo
84:                 *-- vazio, cabecalho desmarcado, OptTipo/OptPreco na 1a opcao) -
85:                 *-- o ganho eh a fonte unica, que o fim do Processamento usa.
86:                 THIS.BOParaForm()
87:                 THIS.TornarControlesVisiveis(THIS)
88:                 loc_lSucesso = .T.
89:             ELSE
90:                 MsgErro("Erro ao criar sigprilaBO. VARTYPE retornou: " + ;
91:                         VARTYPE(THIS.this_oBusinessObject), "Erro")
92:             ENDIF
93:         CATCH TO loc_oErro
94:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
95:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
96:             loc_lSucesso = .F.
97:         ENDTRY
98: 
99:         RETURN loc_lSucesso
100:     ENDPROC
101: 
102:     *--------------------------------------------------------------------------
103:     * ConfigurarPageFrame - Entry point de layout do form OPERACIONAL.
104:     * Este form nao usa PageFrame (legado sem BaseClass: pageframe) - mantido
105:     * so como ponto de entrada unico, no mesmo padrao de Formsigprsen.
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarPageFrame()
108:         THIS.ConfigurarPaginaLista()
109:         THIS.ConfigurarPaginaDados()
110:     ENDPROC
111: 
112:     *--------------------------------------------------------------------------
113:     * ConfigurarPaginaLista - Cabecalho (cntSombra) + painel do assistente de
114:     * importacao (cntplanilha, com todos os campos do dump)
115:     *--------------------------------------------------------------------------
116:     PROTECTED PROCEDURE ConfigurarPaginaLista()
117:         THIS.ConfigurarCabecalho()
118:         THIS.ConfigurarPainelPlanilha()
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarPaginaDados - Grupo de botoes de acao (Grupo_Botao)
123:     *--------------------------------------------------------------------------
124:     PROTECTED PROCEDURE ConfigurarPaginaDados()
125:         THIS.ConfigurarBotoes()
126:     ENDPROC
127: 
128:     *--------------------------------------------------------------------------
129:     * ConfigurarCabecalho - Container escuro com titulo (cntSombra original)
130:     * Posicoes/tamanhos EXATOS do layout.json (PILAR 1)
131:     *--------------------------------------------------------------------------
132:     PROTECTED PROCEDURE ConfigurarCabecalho()
133:         LOCAL loc_oCab
134: 
135:         THIS.AddObject("cnt_4c_Sombra", "Container")
136:         WITH THIS.cnt_4c_Sombra
137:             .Top         = 0
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = 80
141:             .BackStyle   = 1
142:             .BackColor   = RGB(100, 100, 100)
143:             .BorderWidth = 0
144:             .Visible     = .T.
145:         ENDWITH
146:         loc_oCab = THIS.cnt_4c_Sombra
147: 
148:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
149:         WITH loc_oCab.lbl_4c_LblSombra
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = 769
153:             .Height    = 40
154:             .AutoSize  = .F.
155:             .WordWrap  = .T.
156:             .Alignment = 0
157:             .BackStyle = 0
158:             .FontBold  = .T.
159:             .FontName  = "Tahoma"
160:             .FontSize  = 18
161:             .ForeColor = RGB(0, 0, 0)
162:             .Caption   = THIS.Caption
163:         ENDWITH
164: 
165:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
166:         WITH loc_oCab.lbl_4c_LblTitulo
167:             .Top       = 17
168:             .Left      = 10
169:             .Width     = 769
170:             .Height    = 46
171:             .AutoSize  = .F.
172:             .WordWrap  = .T.

*-- Linhas 185 a 275:
185:     * original). Campos criados em duas partes, seguindo mapeamento.json.
186:     * Posicao/tamanho EXATOS do layout.json (PILAR 1)
187:     *--------------------------------------------------------------------------
188:     PROTECTED PROCEDURE ConfigurarPainelPlanilha()
189:         THIS.AddObject("cnt_4c_planilha", "Container")
190:         WITH THIS.cnt_4c_planilha
191:             .Top         = 96
192:             .Left        = 167
193:             .Width       = 466
194:             .Height      = 221
195:             .BackStyle   = 0
196:             .BorderWidth = 0
197:             .Visible     = .T.
198:         ENDWITH
199: 
200:         THIS.ConfigurarCamposPlanilhaParte1()
201:         THIS.ConfigurarCamposPlanilhaParte2()
202:     ENDPROC
203: 
204:     *--------------------------------------------------------------------------
205:     * ConfigurarCamposPlanilhaParte1 - primeira metade dos campos de
206:     * cnt_4c_planilha (Say3/cmbTipos/Say4/GetPlanilha/cmdgetp/Say1 do dump
207:     * original). Posicoes/propriedades EXATAS de
208:     * tasks\task627\sigprila_form_codigo_fonte.txt (SECAO 2). Segunda metade
209:     * (List1/Say2/chkCabecalho/Say5/OptTipo/Say6/OptPreco) em
210:     * ConfigurarCamposPlanilhaParte2 (abaixo).
211:     *--------------------------------------------------------------------------
212:     PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte1()
213:         LOCAL loc_oPnl
214:         loc_oPnl = THIS.cnt_4c_planilha
215: 
216:         *-- Say3 -> lbl_4c_Label3 ("Tipo:")
217:         loc_oPnl.AddObject("lbl_4c_Label3", "Label")
218:         WITH loc_oPnl.lbl_4c_Label3
219:             .Top       = 15
220:             .Left      = 54
221:             .Width     = 29
222:             .Height    = 15
223:             .AutoSize  = .F.
224:             .Alignment = 0
225:             .BackStyle = 0
226:             .FontBold  = .T.
227:             .FontName  = "Tahoma"
228:             .FontSize  = 8
229:             .ForeColor = RGB(90, 90, 90)
230:             .Caption   = "Tipo:"
231:         ENDWITH
232: 
233:         *-- cmbTipos -> cbo_4c_CmbTipos (fwcombo, Style=2 dropdown list;
234:         *-- RowSource eh ligado ao cursor ComboTipo em PreencheTipo, chamado
235:         *-- pelo InicializarForm - igual ao Init do legado)
236:         loc_oPnl.AddObject("cbo_4c_CmbTipos", "ComboBox")
237:         WITH loc_oPnl.cbo_4c_CmbTipos
238:             .Top          = 12
239:             .Left         = 85
240:             .Width        = 187
241:             .Height       = 23
242:             .Style        = 2
243:             .ColumnCount  = 1
244:             .ColumnWidths = "100"
245:             .RowSourceType = 6
246:             .RowSource    = ""
247:             .FontName     = "Tahoma"
248:             .FontSize     = 8
249:             .ForeColor    = RGB(0, 0, 0)
250:         ENDWITH
251: 
252:         *-- Say4 -> lbl_4c_Label4 ("Planilha:")
253:         loc_oPnl.AddObject("lbl_4c_Label4", "Label")
254:         WITH loc_oPnl.lbl_4c_Label4
255:             .Top       = 40
256:             .Left      = 34
257:             .Width     = 49
258:             .Height    = 15
259:             .AutoSize  = .F.
260:             .Alignment = 0
261:             .BackStyle = 0
262:             .FontBold  = .T.
263:             .FontName  = "Tahoma"
264:             .FontSize  = 8
265:             .ForeColor = RGB(90, 90, 90)
266:             .Caption   = "Planilha:"
267:         ENDWITH
268: 
269:         *-- GetPlanilha -> txt_4c_Planilha (fwget, preenchido via GetFile() no
270:         *-- Click de cmdgetp - ReadOnly/Enabled=.F. iguais ao dump original)
271:         loc_oPnl.AddObject("txt_4c_Planilha", "TextBox")
272:         WITH loc_oPnl.txt_4c_Planilha
273:             .Top               = 37
274:             .Left              = 85
275:             .Width             = 336

*-- Linhas 335 a 380:
335:     * tabela. cmbTipos eh populado localmente a partir do cursor ComboTipo
336:     * (array aComboTipo, montado no Init do form legado) e GetPlanilha eh
337:     * preenchido via GetFile() no Click de cmdgetp - nenhum dos dois abre
338:     * FormBuscaAuxiliar. Portanto esta fase nao adiciona BINDEVENT de F4/F5.
339:     *--------------------------------------------------------------------------
340:     PROTECTED PROCEDURE ConfigurarCamposPlanilhaParte2()
341:         LOCAL loc_oPnl
342:         loc_oPnl = THIS.cnt_4c_planilha
343: 
344:         *-- List1 -> obj_4c_List1 (listbox MoverBars para reordenar colunas da
345:         *-- planilha; RowSource real eh montado em runtime por CompletaLista,
346:         *-- e CriaPlanilha le a coluna 2 de cada item para criar TmpPlanilha)
347:         loc_oPnl.AddObject("obj_4c_List1", "ListBox")
348:         WITH loc_oPnl.obj_4c_List1
349:             .Top            = 78
350:             .Left           = 82
351:             .Width          = 191
352:             .Height         = 124
353:             .FontName       = "Tahoma"
354:             .FontSize       = 8
355:             .BoundColumn    = 2
356:             .ColumnCount    = 2
357:             .ColumnWidths   = "172,70"
358:             .RowSourceType  = 1
359:             .RowSource      = ""
360:             .MoverBars      = .T.
361:             .SpecialEffect  = 0
362:         ENDWITH
363: 
364:         *-- Say2 -> lbl_4c_Label2 ("Clique e Arraste para Mudar")
365:         loc_oPnl.AddObject("lbl_4c_Label2", "Label")
366:         WITH loc_oPnl.lbl_4c_Label2
367:             .Top       = 204
368:             .Left      = 83
369:             .Width     = 160
370:             .Height    = 15
371:             .AutoSize  = .F.
372:             .Alignment = 0
373:             .BackStyle = 0
374:             .FontBold  = .T.
375:             .FontName  = "Tahoma"
376:             .FontSize  = 8
377:             .ForeColor = RGB(90, 90, 90)
378:             .Caption   = "Clique e Arraste para Mudar"
379:         ENDWITH
380: 

*-- Linhas 413 a 459:
413:             .Caption   = "Validar :"
414:         ENDWITH
415: 
416:         *-- OptTipo -> obj_4c_OptTipo (optiongroup: Codigo/Descritivo/
417:         *-- Referencia Forn. - define qual coluna de SigCdPro casa com o
418:         *-- produto da planilha; mapeia para sigprilaBO.this_nTipoBusca)
419:         loc_oPnl.AddObject("obj_4c_OptTipo", "OptionGroup")
420:         WITH loc_oPnl.obj_4c_OptTipo
421:             .Top         = 80
422:             .Left        = 335
423:             .Width       = 123
424:             .Height      = 65
425:             .ButtonCount = 3
426:             .BackStyle   = 0
427:             .Themes      = .T.
428: 
429:             WITH .Buttons(1)
430:                 .Top       = 5
431:                 .Left      = 5
432:                 .Width     = 51
433:                 .Height    = 15
434:                 .AutoSize  = .T.
435:                 .BackStyle = 0
436:                 .FontName  = "Tahoma"
437:                 .FontSize  = 8
438:                 .ForeColor = RGB(90, 90, 90)
439:                 .Themes    = .F.
440:                 .Caption   = "C" + CHR(243) + "digo"
441:             ENDWITH
442: 
443:             WITH .Buttons(2)
444:                 .Top       = 22
445:                 .Left      = 5
446:                 .Width     = 65
447:                 .Height    = 15
448:                 .AutoSize  = .T.
449:                 .BackStyle = 0
450:                 .FontName  = "Tahoma"
451:                 .FontSize  = 8
452:                 .ForeColor = RGB(90, 90, 90)
453:                 .Themes    = .F.
454:                 .Caption   = "Descritivo"
455:             ENDWITH
456: 
457:             WITH .Buttons(3)
458:                 .Top       = 41
459:                 .Left      = 5

*-- Linhas 488 a 534:
488:             .Caption   = "Pre" + CHR(231) + "o :"
489:         ENDWITH
490: 
491:         *-- OptPreco -> obj_4c_OptPreco (optiongroup: Venda/Custo - define se
492:         *-- o valor gravado no movimento vem de PVens/Moevs ou de
493:         *-- custofs/moecusfs; mapeia para sigprilaBO.this_nTipoPreco)
494:         loc_oPnl.AddObject("obj_4c_OptPreco", "OptionGroup")
495:         WITH loc_oPnl.obj_4c_OptPreco
496:             .Top         = 140
497:             .Left        = 335
498:             .Width       = 123
499:             .Height      = 44
500:             .ButtonCount = 2
501:             .BackStyle   = 0
502:             .Themes      = .T.
503: 
504:             WITH .Buttons(1)
505:                 .Top       = 5
506:                 .Left      = 5
507:                 .Width     = 48
508:                 .Height    = 15
509:                 .AutoSize  = .T.
510:                 .BackStyle = 0
511:                 .FontName  = "Tahoma"
512:                 .FontSize  = 8
513:                 .ForeColor = RGB(90, 90, 90)
514:                 .Themes    = .F.
515:                 .Caption   = "Venda"
516:             ENDWITH
517: 
518:             WITH .Buttons(2)
519:                 .Top       = 22
520:                 .Left      = 5
521:                 .Width     = 46
522:                 .Height    = 15
523:                 .AutoSize  = .T.
524:                 .BackStyle = 0
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 8
527:                 .ForeColor = RGB(90, 90, 90)
528:                 .Themes    = .F.
529:                 .Caption   = "Custo"
530:             ENDWITH
531: 
532:             .Value = 1
533:         ENDWITH
534: 

*-- Linhas 546 a 592:
546:     * ConfigurarBotoes - CommandGroup de acao (Grupo_Botao original). Buttons(1)
547:     * "\<Processar" (cmdok) e Buttons(2) "Encerrar" (cmdsair) com Caption/
548:     * Picture/fontes/cores EXATOS do dump (SECAO 2, Grupo_Botao). Os Click
549:     * sao ligados por BINDEVENT em ConfigurarEventos: Buttons(1) ->
550:     * BtnProcessarClick e Buttons(2) -> BtnEncerrarClick.
551:     *--------------------------------------------------------------------------
552:     PROTECTED PROCEDURE ConfigurarBotoes()
553:         THIS.AddObject("obj_4c_Grupo_Botao", "CommandGroup")
554:         WITH THIS.obj_4c_Grupo_Botao
555:             .Top           = -2
556:             .Left          = 645
557:             .Width         = 160
558:             .Height        = 85
559:             .ButtonCount   = 2
560:             .BackStyle     = 0
561:             .BorderStyle   = 0
562:             .BorderColor   = RGB(136, 189, 188)
563:             .SpecialEffect = 1
564:             .Visible       = .T.
565: 
566:             WITH .Buttons(1)
567:                 .Top        = 5
568:                 .Left       = 5
569:                 .Width      = 75
570:                 .Height     = 75
571:                 .FontName   = "Comic Sans MS"
572:                 .FontSize   = 8
573:                 .FontBold   = .T.
574:                 .FontItalic = .T.
575:                 .WordWrap   = .T.
576:                 .Picture    = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
577:                 .Caption    = "\<Processar"
578:                 .ForeColor  = RGB(90, 90, 90)
579:                 .BackColor  = RGB(255, 255, 255)
580:                 .Themes     = .F.
581:             ENDWITH
582: 
583:             WITH .Buttons(2)
584:                 .Top        = 5
585:                 .Left       = 80
586:                 .Width      = 75
587:                 .Height     = 75
588:                 .FontName   = "Comic Sans MS"
589:                 .FontSize   = 8
590:                 .FontBold   = .T.
591:                 .FontItalic = .T.
592:                 .WordWrap   = .T.

*-- Linhas 602 a 697:
602:     *--------------------------------------------------------------------------
603:     * ConfigurarEventos - Liga os eventos do legado aos handlers deste form.
604:     *
605:     * BINDEVENT exige metodo PUBLIC (regra #3 do CLAUDE.md) - por isso os
606:     * handlers Btn*Click/Cbo*InteractiveChange abaixo nao levam PROTECTED.
607:     *
608:     * Legado (SECAO 3 de tasks\task627\sigprila_form_codigo_fonte.txt):
609:     *   Grupo_Botao.cmdok.Click                -> ChecaPlanilha()/Processamento()
610:     *   Grupo_Botao.cmdsair.Click              -> thisform.Release
611:     *   cntplanilha.cmdgetp.Click              -> GetFile('xls','Planilha','Importar')
612:     *   cntplanilha.cmbTipos.InteractiveChange -> ThisForm.Completalista()
613:     *   cntplanilha.GetPlanilha.When           -> corpo VAZIO no dump (nada a ligar)
614:     *
615:     * O legado tem UM Click por BOTAO do CommandGroup, entao a ligacao eh em
616:     * Buttons(1)/Buttons(2) (padrao do projeto: FormGr1/FormCliente), nao no
617:     * Click do grupo - assim cada botao mantem o handler que o dump declara.
618:     *--------------------------------------------------------------------------
619:     PROTECTED PROCEDURE ConfigurarEventos()
620:         LOCAL loc_oPnl, loc_oGrp
621: 
622:         loc_oGrp = THIS.obj_4c_Grupo_Botao
623:         IF VARTYPE(loc_oGrp) = "O"
624:             IF loc_oGrp.ButtonCount >= 2
625:                 BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnProcessarClick")
626:                 BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnEncerrarClick")
627:             ENDIF
628:         ENDIF
629: 
630:         loc_oPnl = THIS.cnt_4c_planilha
631:         IF VARTYPE(loc_oPnl) = "O"
632:             IF PEMSTATUS(loc_oPnl, "cmd_4c_Cmdgetp", 5)
633:                 BINDEVENT(loc_oPnl.cmd_4c_Cmdgetp, "Click", THIS, "BtnGetPlanilhaClick")
634:             ENDIF
635:             IF PEMSTATUS(loc_oPnl, "cbo_4c_CmbTipos", 5)
636:                 BINDEVENT(loc_oPnl.cbo_4c_CmbTipos, "InteractiveChange", ;
637:                           THIS, "CboTiposInteractiveChange")
638:             ENDIF
639:         ENDIF
640:     ENDPROC
641: 
642:     *--------------------------------------------------------------------------
643:     * PreencheTipo - Monta o cursor ComboTipo (as 7 rotinas de importacao) e
644:     * liga cmbTipos a ele. Transcricao literal de SIGPRILA.PreencheTipo
645:     * (dump, linha 2129): o array aComboTipo tem 3 colunas por rotina -
646:     *   1) Titulo exibido no combo
647:     *   2) Nome da rotina (tambem a chave de acesso em fChecaAcesso)
648:     *   3) Lista "Titulo da coluna,Campo <tipo>" que define a ORDEM das
649:     *      colunas da planilha e a estrutura de TmpPlanilha ("|" eh virgula
650:     *      escapada, trocada por "," em CriaPlanilha)
651:     *
652:     * As strings da coluna 3 sao REGRA DE NEGOCIO (definem a leitura do .xls
653:     * posicao por posicao) e estao transcritas caractere a caractere do dump,
654:     * inclusive os espacos em sobra dos titulos - mudar qualquer uma delas
655:     * desloca a leitura da planilha inteira.
656:     *--------------------------------------------------------------------------
657:     PROTECTED PROCEDURE PreencheTipo()
658:         LOCAL loc_nI, loc_oCombo
659:         LOCAL ARRAY loc_aComboTipo[7, 3]
660: 
661:         IF USED("ComboTipo")
662:             USE IN ComboTipo
663:         ENDIF
664:         CREATE CURSOR ComboTipo (Titulo C(20), Rotina C(20), ColunaLi M)
665: 
666:         loc_aComboTipo[1, 1] = "Lista de Pre" + CHR(231) + "o"
667:         loc_aComboTipo[1, 2] = "ListaPreco"
668:         loc_aComboTipo[1, 3] = "Empresa,Emps c(3), Nome da Lista,NomeLista c(20)," + ;
669:                                "C" + CHR(243) + "digo Produto,cPros c(14),Valor ,Valor c(16)," + ;
670:                                "Data Inicial,DataIni d,Data Final,DataFim d,Preco De ,PrecoDe c(16)"
671: 
672:         loc_aComboTipo[2, 1] = "Transferencia"
673:         loc_aComboTipo[2, 2] = "GeraTransf"
674:         loc_aComboTipo[2, 3] = "Empresa Origem,EmpresaO c(6),Empresa Destino,EmpresaD c(6)," + ;
675:                                "Categoria ,Categoria c(10),Colecao,Colecao c(20),Produto,cpros c(20)," + ;
676:                                "Quantidade,Qtds n(10|3),Grupo,Grupo c(10),Prazo Entrega ,prazo d," + ;
677:                                "Codigo Barra,CBars n(14|0),Cor,Cors c(4),Tamanho,Tams c(4) "
678: 
679:         loc_aComboTipo[3, 1] = "Precificacao"
680:         loc_aComboTipo[3, 2] = "AtuaPreco"
681:         loc_aComboTipo[3, 3] = "Referencia,Referencia c(20),Data Inicio,dtInicial d," + ;
682:                                "Data Termino,dtFinal d,Valor Venda,PrecoVen c(16)," + ;
683:                                "Preco Especial,PrecoEsp c(16),Produto Off,ProdOff c(1)"
684: 
685:         loc_aComboTipo[4, 1] = "Pedido Terceiro"
686:         loc_aComboTipo[4, 2] = "GeraPedido"
687:         loc_aComboTipo[4, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
688:                                "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
689:                                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
690:                                "Peso,Pesos n(12|5),Data Recebimento ,prazo d "
691: 
692:         loc_aComboTipo[5, 1] = "Pedido Consignado"
693:         loc_aComboTipo[5, 2] = "Pedidocons"
694:         loc_aComboTipo[5, 3] = "Empresa Origem,Emps c(6),Empresa Destino,Empds c(6)," + ;
695:                                "Conta Origem ,ContaOs c(10),Produto,cpros c(20)," + ;
696:                                "Quantidade,Qtds n(10|3),Cor,Cors c(4),Tamanho,Tams c(4)," + ;
697:                                "Peso,Pesos n(12|5),Data Recebimento ,prazo d "

*-- Linhas 782 a 825:
782:     *   Validar (Say5/OptTipo)  -> Transferencia, Precificacao e os 4 Pedidos
783:     *   Preco   (Say6/OptPreco) -> somente os 4 Pedidos
784:     *--------------------------------------------------------------------------
785:     PROCEDURE CompletaLista()
786:         LOCAL loc_cTitulo, loc_oPnl
787: 
788:         IF !USED("ComboTipo")
789:             RETURN
790:         ENDIF
791: 
792:         THIS.SelecionarTipo()
793: 
794:         loc_oPnl    = THIS.cnt_4c_planilha
795:         loc_cTitulo = UPPER(ALLTRIM(ComboTipo.Titulo))
796: 
797:         loc_oPnl.obj_4c_List1.RowSourceType = 1
798:         loc_oPnl.obj_4c_List1.RowSource     = ALLTRIM(ComboTipo.ColunaLi)
799: 
800:         IF INLIST(loc_cTitulo, "TRANSFERENCIA", "PRECIFICACAO", "PEDIDO TERCEIRO", ;
801:                                "PEDIDO CONSIGNADO", "PEDIDO FABRICA", "PEDIDO ACESSORIO")
802:             loc_oPnl.lbl_4c_Label5.Visible  = .T.
803:             loc_oPnl.obj_4c_OptTipo.Visible = .T.
804:         ELSE
805:             loc_oPnl.lbl_4c_Label5.Visible  = .F.
806:             loc_oPnl.obj_4c_OptTipo.Visible = .F.
807:         ENDIF
808: 
809:         IF INLIST(loc_cTitulo, "PEDIDO TERCEIRO", "PEDIDO CONSIGNADO", ;
810:                                "PEDIDO FABRICA", "PEDIDO ACESSORIO")
811:             loc_oPnl.lbl_4c_Label6.Visible   = .T.
812:             loc_oPnl.obj_4c_OptPreco.Visible = .T.
813:         ELSE
814:             loc_oPnl.lbl_4c_Label6.Visible   = .F.
815:             loc_oPnl.obj_4c_OptPreco.Visible = .F.
816:         ENDIF
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * CriaPlanilha - Transcricao de SIGPRILA.CriaPlanilha (dump, linha 769).
821:     * Valida tipo e arquivo, monta TmpPlanilha com a estrutura da coluna 2 da
822:     * List1 (trocando "|" por ",") e importa o .xls com APPEND FROM ... TYPE
823:     * XL5. Descarta a 1a linha quando ChkCabecalho esta marcado.
824:     *
825:     * SET SAFETY eh salvo/desligado/restaurado em volta do CREATE TABLE: o

*-- Linhas 991 a 1060:
991:             CATCH TO loc_oErro
992:                 MsgErro(loc_oErro.Message + CHR(13) + ;
993:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
994:                         "Procedure: " + loc_oErro.Procedure, ;
995:                         "Erro na importa" + CHR(231) + CHR(227) + "o da planilha")
996:                 loc_lSucesso = .F.
997:             ENDTRY
998:         ENDIF
999: 
1000:         RETURN loc_lSucesso
1001:     ENDFUNC
1002: 
1003:     *--------------------------------------------------------------------------
1004:     * Processamento - Transcricao de SIGPRILA.Processamento (dump, linha 2203):
1005:     *   If ThisForm.CriaPlanilha()
1006:     *       If ThisForm.ValidaCols(ThisForm, Alltrim(ComboTipo.Rotina))
1007:     *           If MessageBox(<aviso de ordem das colunas>,4+64+256,'') = 6
1008:     *               &('ThisForm.'+Rotina+'()')
1009:     *           EndIf
1010:     *       Else
1011:     *           MessageBox('Metodo '+Rotina+' nao localizado',16,'')
1012:     *       EndIf
1013:     *   EndIf
1014:     *   thisform.cntplanilha.getPlanilha.Value = ''
1015:     *
1016:     * O texto do aviso eh literal do legado (4+64+256 = Sim/Nao com default no
1017:     * Nao -> MsgConfirma, que devolve LOGICAL, regra #7) e a limpeza final do
1018:     * campo Planilha roda em QUALQUER caminho, igual ao dump.
1019:     *--------------------------------------------------------------------------
1020:     PROCEDURE Processamento()
1021:         LOCAL loc_cRotina, loc_cAviso
1022: 
1023:         *-- FormParaBO ANTES do CriaPlanilha (o legado nao tem este hook: le os
1024:         *-- controles direto, em cada rotina). Transferir primeiro garante que o
1025:         *-- BO espelhe a tela em TODO caminho - inclusive quando CriaPlanilha
1026:         *-- recusa o tipo/arquivo -, o que o BOParaForm do fim depende para nao
1027:         *-- devolver criterio de uma execucao ANTERIOR por cima do que o usuario
1028:         *-- acabou de marcar. Nenhuma mudanca de comportamento: CriaPlanilha le
1029:         *-- cbo_4c_CmbTipos/List1/txt_4c_Planilha, nao o ponteiro de ComboTipo.
1030:         THIS.FormParaBO()
1031: 
1032:         IF THIS.CriaPlanilha()
1033:             loc_cRotina = ALLTRIM(THIS.this_oBusinessObject.this_cRotina)
1034: 
1035:             IF THIS.ValidaCols(THIS.this_oBusinessObject, loc_cRotina)
1036:                 loc_cAviso = "Aten" + CHR(231) + CHR(227) + "o, a ordem das colunas " + ;
1037:                              CHR(233) + " muito importante. Certifique-se que elas est" + ;
1038:                              CHR(227) + "o corretas." + CHR(13) + ;
1039:                              "Ordem incorreta resultar" + CHR(225) + " em uma importa" + ;
1040:                              CHR(231) + CHR(227) + "o incorreta, e este processo " + ;
1041:                              CHR(233) + " irrevers" + CHR(237) + "vel." + CHR(13) + ;
1042:                              "Tem certeza que deseja continuar a importa" + CHR(231) + ;
1043:                              CHR(227) + "o com a ordem selecionada"
1044: 
1045:                 IF MsgConfirma(loc_cAviso, "")
1046:                     THIS.ExecutarRotinaImportacao(loc_cRotina)
1047:                 ENDIF
1048:             ELSE
1049:                 MsgErro("M" + CHR(233) + "todo " + loc_cRotina + " n" + CHR(227) + ;
1050:                         "o localizado", "")
1051:             ENDIF
1052:         ENDIF
1053: 
1054:         *-- "thisform.cntplanilha.getPlanilha.Value = ''" do legado, em UM lugar
1055:         *-- so: limpa a property e deixa o BOParaForm espelhar no campo. Antes a
1056:         *-- limpeza era escrita DUAS vezes (campo e property), que eh a origem da
1057:         *-- divergencia silenciosa entre tela e BO.
1058:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1059:             THIS.this_oBusinessObject.this_cArquivoPlanilha = ""
1060:         ENDIF

*-- Linhas 1068 a 1276:
1068:     *
1069:     * chk_4c_ChkCabecalho.Value eh NUMERICO (0/1) e vai para uma property
1070:     * LOGICA do BO - a conversao eh explicita, nunca atribuicao direta.
1071:     * OptionGroup.Value ja eh o INDICE 1-based das opcoes (OptTipo 1..3,
1072:     * OptPreco 1..2), igual ao que o legado le em lnTipo/lnTpPre.
1073:     *--------------------------------------------------------------------------
1074:     PROTECTED PROCEDURE FormParaBO()
1075:         LOCAL loc_oPnl, loc_oBO
1076: 
1077:         loc_oBO = THIS.this_oBusinessObject
1078:         IF VARTYPE(loc_oBO) = "O"
1079:             *-- Rotina/ColunaLi vem da linha corrente de ComboTipo
1080:             THIS.SelecionarTipo()
1081: 
1082:             loc_oPnl = THIS.cnt_4c_planilha
1083:             loc_oBO.this_cArquivoPlanilha = ALLTRIM(loc_oPnl.txt_4c_Planilha.Value)
1084:             loc_oBO.this_lIncluiCabecalho = (loc_oPnl.chk_4c_ChkCabecalho.Value = 1)
1085:             loc_oBO.this_nTipoBusca       = loc_oPnl.obj_4c_OptTipo.Value
1086:             loc_oBO.this_nTipoPreco       = loc_oPnl.obj_4c_OptPreco.Value
1087:         ENDIF
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * BOParaForm - Caminho inverso do FormParaBO: devolve a tela o estado dos
1092:     * criterios guardado em sigprilaBO. PROTECTED EXPLICITO: FormBase declara
1093:     * este hook como PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo
1094:     * (o mesmo motivo do FormParaBO acima).
1095:     *
1096:     * O legado nao tem este hook - cada rotina le os controles direto
1097:     * (ThisForm.cntplanilha.OptTipo.Value, ...), entao tela e criterio sao a
1098:     * MESMA coisa la. Na arquitetura em camadas o criterio mora no BO, e quem
1099:     * o altera fora da tela precisa de um caminho de volta: eh o que o fim do
1100:     * Processamento usa para reproduzir o "getPlanilha.Value = ''" do legado
1101:     * sem escrever a limpeza duas vezes, e o que o InicializarForm usa para o
1102:     * painel abrir no estado do BO.
1103:     *
1104:     * Conversoes espelhadas, nunca atribuicao direta (regras do CLAUDE.md):
1105:     *   property LOGICA -> chk_4c_ChkCabecalho.Value, que eh NUMERICO (0/1);
1106:     *   OptionGroup.Value eh INDICE 1-based - valor fora de faixa (0, vindo de
1107:     *   property nao inicializada) atribuido a um OptionGroup deixa TODOS os
1108:     *   botoes desmarcados, por isso o piso de 1 e o teto do ButtonCount.
1109:     *--------------------------------------------------------------------------
1110:     PROTECTED PROCEDURE BOParaForm()
1111:         LOCAL loc_oPnl, loc_oBO, loc_nTipo, loc_nPreco
1112: 
1113:         loc_oBO = THIS.this_oBusinessObject
1114:         IF VARTYPE(loc_oBO) != "O"
1115:             RETURN
1116:         ENDIF
1117: 
1118:         loc_oPnl = THIS.cnt_4c_planilha
1119:         IF VARTYPE(loc_oPnl) != "O"
1120:             RETURN
1121:         ENDIF
1122: 
1123:         loc_oPnl.txt_4c_Planilha.Value = ALLTRIM(loc_oBO.this_cArquivoPlanilha)
1124:         loc_oPnl.chk_4c_ChkCabecalho.Value = IIF(loc_oBO.this_lIncluiCabecalho, 1, 0)
1125: 
1126:         loc_nTipo = loc_oBO.this_nTipoBusca
1127:         IF loc_nTipo < 1 OR loc_nTipo > loc_oPnl.obj_4c_OptTipo.ButtonCount
1128:             loc_nTipo = 1
1129:         ENDIF
1130:         loc_oPnl.obj_4c_OptTipo.Value = loc_nTipo
1131: 
1132:         loc_nPreco = loc_oBO.this_nTipoPreco
1133:         IF loc_nPreco < 1 OR loc_nPreco > loc_oPnl.obj_4c_OptPreco.ButtonCount
1134:             loc_nPreco = 1
1135:         ENDIF
1136:         loc_oPnl.obj_4c_OptPreco.Value = loc_nPreco
1137:     ENDPROC
1138: 
1139:     *--------------------------------------------------------------------------
1140:     * BtnProcessarClick - Legado: Grupo_Botao.cmdok.Click
1141:     *     If Thisform.Planilha / ThisForm.ChecaPlanilha() / Else /
1142:     *     ThisForm.Processamento() / EndIf
1143:     *
1144:     * O ramo .T. eh MORTO no legado: ThisForm.Planilha (espelhado em
1145:     * sigprilaBO.this_lPlanilha) nasce .F. e nao eh atribuido em lugar nenhum
1146:     * do dump, e o metodo ChecaPlanilha NAO EXISTE no SCX (nao aparece na
1147:     * SECAO 3). Transcrever a chamada produziria exatamente o defeito da
1148:     * regra #13 do CLAUDE.md - nome desconhecido compila limpo e estoura em
1149:     * runtime procurando "checaplanilha.prg" -, entao so o caminho vivo
1150:     * (Processamento) eh portado, com o estado morto preservado como
1151:     * propriedade do BO para fidelidade de PILAR 1.
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE BtnProcessarClick()
1154:         LOCAL loc_oErro
1155: 
1156:         TRY
1157:             THIS.Processamento()
1158:         CATCH TO loc_oErro
1159:             MsgErro(loc_oErro.Message + CHR(13) + ;
1160:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1161:                     "Procedure: " + loc_oErro.Procedure, ;
1162:                     "Erro ao processar a planilha")
1163:         ENDTRY
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * BtnEncerrarClick - Legado: Grupo_Botao.cmdsair.Click -> thisform.Release
1168:     * Fecha a tela. Tambem eh o destino do ESC (KeyPress do form), como no
1169:     * legado, que chama "thisform.grupo_Botao.cmdsair.Click".
1170:     *--------------------------------------------------------------------------
1171:     PROCEDURE BtnEncerrarClick()
1172:         THIS.Release()
1173:     ENDPROC
1174: 
1175:     *--------------------------------------------------------------------------
1176:     * BtnGetPlanilhaClick - Legado: cntplanilha.cmdgetp.Click
1177:     *     This.Parent.getPlanilha.Value = GetFile('xls','Planilha','Importar')
1178:     * GETFILE devolve "" quando o usuario cancela - o legado grava esse vazio
1179:     * no campo, limpando a selecao anterior, e esse comportamento eh mantido.
1180:     *--------------------------------------------------------------------------
1181:     PROCEDURE BtnGetPlanilhaClick()
1182:         LOCAL loc_cArquivo, loc_oErro
1183: 
1184:         TRY
1185:             loc_cArquivo = GETFILE("xls", "Planilha", "Importar")
1186:             THIS.cnt_4c_planilha.txt_4c_Planilha.Value = loc_cArquivo
1187: 
1188:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1189:                 THIS.this_oBusinessObject.this_cArquivoPlanilha = ALLTRIM(loc_cArquivo)
1190:             ENDIF
1191:         CATCH TO loc_oErro
1192:             MsgErro(loc_oErro.Message, "Erro ao selecionar a planilha")
1193:         ENDTRY
1194:     ENDPROC
1195: 
1196:     *--------------------------------------------------------------------------
1197:     * CboTiposInteractiveChange - Legado: cntplanilha.cmbTipos.
1198:     * InteractiveChange -> ThisForm.Completalista()
1199:     *--------------------------------------------------------------------------
1200:     PROCEDURE CboTiposInteractiveChange()
1201:         LOCAL loc_oErro
1202: 
1203:         TRY
1204:             THIS.CompletaLista()
1205:         CATCH TO loc_oErro
1206:             MsgErro(loc_oErro.Message, "Erro ao trocar o tipo de importa" + ;
1207:                     CHR(231) + CHR(227) + "o")
1208:         ENDTRY
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * KeyPress - Legado: SIGPRILA.KeyPress
1213:     *     LPARAMETERS nKeyCode, nShiftAltCtrl
1214:     *     If nKeyCode = 27 / thisform.grupo_Botao.cmdsair.Click / EndIf
1215:     * KeyPreview = .T. na classe garante que o FORM veja a tecla antes dos
1216:     * controles - o SCX nao declara a propriedade (fica no default .F.), mas
1217:     * sem ela o handler de ESC que o legado escreveu nunca dispararia com o
1218:     * foco dentro do combo/lista/campo, e o ESC eh a saida que o usuario
1219:     * espera desta tela (PILAR 1 - comportamento pretendido pelo legado).
1220:     *--------------------------------------------------------------------------
1221:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1222:         IF par_nKeyCode = 27
1223:             THIS.BtnEncerrarClick()
1224:         ENDIF
1225:     ENDPROC
1226: 
1227:     *--------------------------------------------------------------------------
1228:     * TornarControlesVisiveis - Torna todos os controles visiveis apos
1229:     * AddObject (que os cria com Visible = .F. por padrao).
1230:     *
1231:     * EXCECAO: lbl_4c_Label5/obj_4c_OptTipo/lbl_4c_Label6/obj_4c_OptPreco
1232:     * nascem com Visible = .F. de proposito (ConfigurarCamposPlanilhaParte2 -
1233:     * CompletaLista() do legado so os exibe para tipos de importacao
1234:     * especificos). Pular a atribuicao de Visible para esses nomes, mas
1235:     * continuar recursando dentro deles (caso de obj_4c_OptTipo/obj_4c_OptPreco,
1236:     * que sao containers com Buttons filhos) para nao deixar os filhos
1237:     * Visible = .F. quando a visibilidade do grupo for restaurada depois.
1238:     *--------------------------------------------------------------------------
1239:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1240:         LOCAL loc_i, loc_oControl, loc_p, loc_lPularVisible
1241: 
1242:         FOR loc_i = 1 TO par_oContainer.ControlCount
1243:             loc_oControl = par_oContainer.Controls(loc_i)
1244: 
1245:             IF VARTYPE(loc_oControl) = "O"
1246:                 loc_lPularVisible = INLIST(UPPER(loc_oControl.Name), ;
1247:                     "LBL_4C_LABEL5", "OBJ_4C_OPTTIPO", ;
1248:                     "LBL_4C_LABEL6", "OBJ_4C_OPTPRECO")
1249: 
1250:                 IF !loc_lPularVisible AND PEMSTATUS(loc_oControl, "Visible", 5)
1251:                     loc_oControl.Visible = .T.
1252:                 ENDIF
1253: 
1254:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1255:                     FOR loc_p = 1 TO loc_oControl.PageCount
1256:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
1257:                     ENDFOR
1258:                 ENDIF
1259: 
1260:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5)
1261:                     IF loc_oControl.ControlCount > 0
1262:                         THIS.TornarControlesVisiveis(loc_oControl)
1263:                     ENDIF
1264:                 ENDIF
1265:             ENDIF
1266:         ENDFOR
1267:     ENDPROC
1268: 
1269:     *--------------------------------------------------------------------------
1270:     * Destroy - Encerramento padrao (restauracao de menu herdada de FormBase)
1271:     *--------------------------------------------------------------------------
1272:     PROCEDURE Destroy()
1273:         DODEFAULT()
1274:     ENDPROC
1275: 
1276: ENDDEFINE

