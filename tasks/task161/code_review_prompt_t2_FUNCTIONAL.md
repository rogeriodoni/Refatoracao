# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Top original=140 vs migrado 'obj_4c_OptCalculo' Top=0 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Left original=351 vs migrado 'obj_4c_OptCalculo' Left=0 (diff=351px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDias' (parent: SIGPRCFN): Top original=158 vs migrado 'obj_4c_OptDias' Top=0 (diff=158px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDias' (parent: SIGPRCFN): Left original=351 vs migrado 'obj_4c_OptDias' Left=0 (diff=351px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1831 linhas total):

*-- Linhas 2 a 191:
2: * FormSigPrCfn.prg - C" + CHR(225) + "lculo de Juros
3: * Herda de: FormBase
4: * Tipo: OPERACIONAL (calculadora de juros - sem tabela BD)
5: * Chamada: CREATEOBJECT("FormSigPrCfn", pVal, pTip, pJMe, pJDi, pDtB, pDtF)
6: *   pVal = Valor Base (N)
7: *   pTip = Tipo de C" + CHR(225) + "lculo (1=Simples; 2=Composto)
8: *   pJMe = Juros ao M" + CHR(234) + "s (N)
9: *   pJDi = Juros ao Dia - relevante somente se pJMe n" + CHR(227) + "o informado (N)
10: *   pDtB = Data Base (D)
11: *   pDtF = Data Final (D) - se vazio usa DATE() quando pDtB informado
12: *
13: * Estrutura (completo):
14: *   - cnt_4c_Cabecalho (header cinza com titulo)
15: *   - pgf_4c_Paginas.Page1: Calculo (ValorBase, Juros, Datas, Dias, resultados)
16: *   - pgf_4c_Paginas.Page2: Vencimentos (10 campos de data - venc1 a venc10)
17: *   - cnt_4c_Botoes (container overlay para botao Encerrar)
18: *   - cnt_4c_BotoesAcao (container de botoes de acao)
19: *===============================================================================
20: 
21: DEFINE CLASS FormSigPrCfn AS FormBase
22: 
23:     Width       = 620
24:     Height      = 350
25:     AutoCenter  = .T.
26:     TitleBar    = 0
27:     ShowWindow = 1
28:     WindowType = 1
29:     ControlBox  = .F.
30:     Closable    = .F.
31:     MaxButton   = .F.
32:     MinButton   = .F.
33:     KeyPreview  = .T.
34:     DataSession = 2
35:     BorderStyle = 2
36: 
37:     *-- Parametros recebidos do chamador (armazenados antes de DODEFAULT)
38:     this_nParValorBase   = 0
39:     this_nParTipoCalculo = 1
40:     this_nParJurosMes    = 0
41:     this_nParJurosDia    = 0
42:     this_dParDataBase    = {}
43:     this_dParDataFinal   = {}
44: 
45:     *-- Business Object de calculo
46:     this_oBusinessObject = .NULL.
47: 
48:     *-- Modo do formulario (calculadora nao muda de modo, mas mantem para compatibilidade)
49:     this_cModoAtual = "CALCULO"
50: 
51:     *===========================================================================
52:     * Init - Recebe parametros do chamador e aciona inicializacao via FormBase
53:     * Armazena os parametros ANTES de DODEFAULT() invocar InicializarForm()
54:     *===========================================================================
55:     PROCEDURE Init(par_nValorBase, par_nTipoCalculo, par_nJurosMes, par_nJurosDia, ;
56:                    par_dDataBase, par_dDataFinal)
57: 
58:         IF VARTYPE(par_nValorBase) = "N" AND par_nValorBase > 0
59:             THIS.this_nParValorBase = par_nValorBase
60:         ENDIF
61: 
62:         IF VARTYPE(par_nTipoCalculo) = "N" AND INLIST(par_nTipoCalculo, 1, 2)
63:             THIS.this_nParTipoCalculo = par_nTipoCalculo
64:         ELSE
65:             THIS.this_nParTipoCalculo = 1
66:         ENDIF
67: 
68:         IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
69:             THIS.this_nParJurosMes = par_nJurosMes
70:         ENDIF
71: 
72:         IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
73:             THIS.this_nParJurosDia = par_nJurosDia
74:         ENDIF
75: 
76:         IF VARTYPE(par_dDataBase) = "D"
77:             THIS.this_dParDataBase = par_dDataBase
78:         ENDIF
79: 
80:         IF VARTYPE(par_dDataFinal) = "D"
81:             THIS.this_dParDataFinal = par_dDataFinal
82:         ENDIF
83: 
84:         RETURN DODEFAULT()
85:     ENDPROC
86: 
87:     *===========================================================================
88:     * InicializarForm - Configuracao do form (chamado por FormBase.Init)
89:     * Cria BO, cabecalho, PageFrame e containers principais
90:     *===========================================================================
91:     PROTECTED PROCEDURE InicializarForm()
92:         LOCAL loc_lSucesso
93: 
94:         loc_lSucesso = .F.
95: 
96:         TRY
97:             *-- Criar BO de calculo
98:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCfnBO")
99: 
100:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
101:                 *-- Definir caption do form
102:                 THIS.Caption = "C" + CHR(225) + "lculo de Juros"
103: 
104:                 *-- Construir cabecalho com titulo
105:                 THIS.ConfigurarCabecalho()
106: 
107:                 *-- Construir PageFrame com Page1 (Calculo) e Page2 (Vencimentos)
108:                 THIS.ConfigurarPageFrame()
109: 
110:                 *-- Propagar titulo do form para labels do cabecalho
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
112:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:                 *-- Container overlay do botao Encerrar (sobre o cabecalho)
115:                 THIS.ConfigurarBotoes()
116: 
117:                 *-- Container de botoes de acao (dentro das paginas)
118:                 THIS.ConfigurarBotoesAcao()
119: 
120:                 *-- Conteudo das paginas (Page1=Calculo, Page2=Vencimentos)
121:                 *-- Dispatcher unico compativel com nomenclatura CRUD do pipeline
122:                 THIS.ConfigurarPaginaDados()
123: 
124:                 *-- Preencher campos com parametros recebidos do chamador
125:                 THIS.PreencherParametrosIniciais()
126: 
127:                 *-- Torna todos os controles adicionados visiveis
128:                 THIS.TornarControlesVisiveis(THIS)
129: 
130:                 *-- Ativa primeira pagina do PageFrame
131:                 THIS.pgf_4c_Paginas.Visible   = .T.
132:                 THIS.pgf_4c_Paginas.ActivePage = 1
133: 
134:                 loc_lSucesso = .T.
135:             ELSE
136:                 MsgErro("Erro ao criar SigPrCfnBO.", ;
137:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
138:             ENDIF
139: 
140:         CATCH TO loc_oErro
141:             MsgErro(loc_oErro.Message, "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
142:         ENDTRY
143: 
144:         RETURN loc_lSucesso
145:     ENDPROC
146: 
147:     *===========================================================================
148:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cabecalho cinza com titulo)
149:     * Equivalente ao cntSombra do form original
150:     *===========================================================================
151:     PROTECTED PROCEDURE ConfigurarCabecalho()
152:         LOCAL loc_cCaption, loc_nFormWidth
153: 
154:         loc_cCaption   = "C" + CHR(225) + "lculo de Juros"
155:         loc_nFormWidth = THIS.Width
156: 
157:         *-- Container cabecalho escuro (cntSombra)
158:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
159:         WITH THIS.cnt_4c_Cabecalho
160:             .Top         = 0
161:             .Left        = 0
162:             .Width       = loc_nFormWidth
163:             .Height      = 80
164:             .BackStyle   = 1
165:             .BackColor   = RGB(100, 100, 100)
166:             .BorderWidth = 0
167:             .Visible     = .T.
168: 
169:             *-- Label sombra (preto, deslocado 1px para efeito 3D)
170:             .AddObject("lbl_4c_Sombra", "Label")
171:             WITH .lbl_4c_Sombra
172:                 .FontBold  = .T.
173:                 .FontName  = "Tahoma"
174:                 .FontSize  = 18
175:                 .WordWrap  = .T.
176:                 .Alignment = 0
177:                 .BackStyle = 0
178:                 .AutoSize  = .F.
179:                 .Width     = loc_nFormWidth
180:                 .Height    = 40
181:                 .Top       = 18
182:                 .Left      = 10
183:                 .ForeColor = RGB(0, 0, 0)
184:                 .Caption   = loc_cCaption
185:                 .Visible   = .T.
186:             ENDWITH
187: 
188:             *-- Label titulo (branco - texto visivel)
189:             .AddObject("lbl_4c_Titulo", "Label")
190:             WITH .lbl_4c_Titulo
191:                 .FontBold  = .T.

*-- Linhas 212 a 430:
212:     * Page2 = Vencimentos (grid de parcelas)
213:     * Nesta fase (3) o PageFrame eh criado vazio - conteudo entra nas fases 4-6
214:     *===========================================================================
215:     PROTECTED PROCEDURE ConfigurarPageFrame()
216:         LOCAL loc_nTopPgf, loc_nHeightPgf, loc_nWidthPgf
217: 
218:         *-- PageFrame ocupa area abaixo do cabecalho (Top=80) ate rodape
219:         loc_nTopPgf    = 80
220:         loc_nHeightPgf = THIS.Height - loc_nTopPgf
221:         loc_nWidthPgf  = THIS.Width
222: 
223:         *-- Container do PageFrame principal
224:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
225:         WITH THIS.pgf_4c_Paginas
226:             .Top        = loc_nTopPgf
227:             .Left       = 0
228:             .Width      = loc_nWidthPgf
229:             .Height     = loc_nHeightPgf
230:             .PageCount  = 2
231:             .Tabs       = .F.
232:             .BorderWidth = 0
233:             .BackStyle   = 0
234:             .Themes     = .F.
235:             .Visible    = .T.
236: 
237:             *-- Page1: Calculo principal (campos serao adicionados nas Fases 4-6)
238:             WITH .Page1
239:                 .Caption = "C" + CHR(225) + "lculo"
240:             ENDWITH
241: 
242:             *-- Page2: Vencimentos (parcelas serao adicionadas nas Fases 5-6)
243:             WITH .Page2
244:                 .Caption = "Vencimentos"
245:                 .BackColor = RGB(240, 240, 240)
246:             ENDWITH
247: 
248:             .ActivePage = 1
249:         ENDWITH
250:     ENDPROC
251: 
252:     *===========================================================================
253:     * ConfigurarBotoes - Cria container cnt_4c_Botoes overlay com botao Encerrar
254:     * Container transparente sobre o cabecalho no canto superior direito
255:     * Equivalente ao btnOK do form original
256:     *===========================================================================
257:     PROTECTED PROCEDURE ConfigurarBotoes()
258:         LOCAL loc_nFormWidth
259:         loc_nFormWidth = THIS.Width
260: 
261:         *-- Container do botao Encerrar (transparente sobre cabecalho)
262:         THIS.AddObject("cnt_4c_Botoes", "Container")
263:         WITH THIS.cnt_4c_Botoes
264:             .Top         = 0
265:             .Left        = loc_nFormWidth - 90
266:             .Width       = 90
267:             .Height      = 85
268:             .BackStyle   = 0
269:             .BorderWidth = 0
270:             .Visible     = .T.
271: 
272:             .AddObject("cmd_4c_Encerrar", "CommandButton")
273:             WITH .cmd_4c_Encerrar
274:                 .Top             = 5
275:                 .Left            =  542
276:                 .Width           = 75
277:                 .Height          = 75
278:                 .Caption         = "Encerrar"
279:                 .FontName        = "Tahoma"
280:                 .FontBold        = .T.
281:                 .FontItalic      = .T.
282:                 .FontSize        = 8
283:                 .ForeColor       = RGB(90, 90, 90)
284:                 .BackColor       = RGB(255, 255, 255)
285:                 .SpecialEffect   = 0
286:                 .PicturePosition = 13
287:                 .MousePointer    = 15
288:                 .WordWrap        = .T.
289:                 .AutoSize        = .F.
290:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
291:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
292:                 .Cancel          = .T.
293:                 .Visible         = .T.
294:             ENDWITH
295:         ENDWITH
296: 
297:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
298:     ENDPROC
299: 
300:     *===========================================================================
301:     * ConfigurarBotoesAcao - Cria container cnt_4c_BotoesAcao (botoes de acao)
302:     * Container reservado para botoes de acao especificos (adicionados nas Fases 4-7)
303:     * Nesta fase o container eh criado vazio conforme especificacao Fase 3
304:     *===========================================================================
305:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
306:         LOCAL loc_nFormWidth
307:         loc_nFormWidth = THIS.Width
308: 
309:         *-- Container de botoes de acao (posicionado no rodape das paginas)
310:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
311:         WITH THIS.cnt_4c_BotoesAcao
312:             .Top         = THIS.Height - 40
313:             .Left        = 0
314:             .Width       = loc_nFormWidth
315:             .Height      = 40
316:             .BackStyle   = 0
317:             .BorderWidth = 0
318:             .Visible     = .T.
319: 
320:             .AddObject("cmd_4c_Limpar", "CommandButton")
321:             WITH .cmd_4c_Limpar
322:                 .Top          = 5
323:                 .Left         = 10
324:                 .Width        = 90
325:                 .Height       = 28
326:                 .Caption      = "Limpar"
327:                 .FontName     = "Tahoma"
328:                 .FontBold     = .T.
329:                 .FontSize     = 8
330:                 .ForeColor    = RGB(90, 90, 90)
331:                 .BackColor    = RGB(240, 240, 240)
332:                 .MousePointer = 15
333:             ENDWITH
334:         ENDWITH
335: 
336:         BINDEVENT(THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar, "Click", THIS, "CmdLimparClick")
337:     ENDPROC
338: 
339:     *===========================================================================
340:     * CmdEncerrarClick - Fecha o formulario (ESC ou clique no botao Encerrar)
341:     *===========================================================================
342:     PROCEDURE CmdEncerrarClick()
343:         THIS.Release()
344:     ENDPROC
345: 
346:     *===========================================================================
347:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
348:     * Necessario apos AddObject (que cria controles com Visible=.F. por padrao)
349:     * Recursa em Pages (PageFrame) e sub-containers
350:     *===========================================================================
351:     PROCEDURE TornarControlesVisiveis(par_oContainer)
352:         LOCAL loc_nI, loc_oObjeto, loc_nP
353: 
354:         FOR loc_nI = 1 TO par_oContainer.ControlCount
355:             loc_oObjeto = par_oContainer.Controls(loc_nI)
356: 
357:             IF VARTYPE(loc_oObjeto) = "O"
358:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
359:                     loc_oObjeto.Visible = .T.
360:                 ENDIF
361: 
362:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
363:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
364:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
365:                     ENDFOR
366:                 ENDIF
367: 
368:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
369:                     THIS.TornarControlesVisiveis(loc_oObjeto)
370:                 ENDIF
371:             ENDIF
372:         ENDFOR
373:     ENDPROC
374: 
375:     *===========================================================================
376:     * ConfigurarPaginaDados - Dispatcher que popula ambas as paginas do form
377:     * Form OPERACIONAL: delega para ConfigurarPaginaCalculo (Page1 - campos de
378:     * calculo) e ConfigurarPaginaVencimentos (Page2 - datas de vencimento).
379:     * Nomenclatura mantida por compatibilidade com o pipeline de migracao.
380:     *===========================================================================
381:     PROTECTED PROCEDURE ConfigurarPaginaDados()
382:         THIS.ConfigurarPaginaCalculo()
383:         THIS.ConfigurarPaginaVencimentos()
384:     ENDPROC
385: 
386:     *===========================================================================
387:     * ConfigurarPaginaCalculo - Popula Page1 com todos os campos de calculo
388:     * Equivale ao ConfigurarPaginaLista em forms CRUD - eh o conteudo principal
389:     *===========================================================================
390:     PROTECTED PROCEDURE ConfigurarPaginaCalculo()
391:         LOCAL loc_oPagina
392: 
393:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
394: 
395:         *-- Label "Valor Base :"
396:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
397:         WITH loc_oPagina.lbl_4c_Label1
398:             .Top       = 11
399:             .Left      = 36
400:             .AutoSize  = .T.
401:             .BackStyle = 0
402:             .Caption   = "Valor Base :"
403:             .FontName  = "Tahoma"
404:             .FontSize  = 8
405:             .ForeColor = RGB(90, 90, 90)
406:         ENDWITH
407: 
408:         *-- Campo Valor Base
409:         loc_oPagina.AddObject("txt_4c_ValorBase", "TextBox")
410:         WITH loc_oPagina.txt_4c_ValorBase
411:             .Top       = 7
412:             .Left      = 97
413:             .Width     = 115
414:             .Height    = 23
415:             .Value     = 0
416:             .Format    = "NR"
417:             .InputMask = "################.##"
418:             .Alignment = 1
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .ForeColor = RGB(90, 90, 90)
422:         ENDWITH
423: 
424:         *-- Label "Juros/Mes :"
425:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
426:         WITH loc_oPagina.lbl_4c_Label3
427:             .Top       = 39
428:             .Left      = 37
429:             .AutoSize  = .T.
430:             .BackStyle = 0

*-- Linhas 565 a 609:
565:             .ForeColor = RGB(90, 90, 90)
566:         ENDWITH
567: 
568:         *-- OptionGroup tipo de calculo (Simples/Composto)
569:         loc_oPagina.AddObject("obj_4c_OptCalculo", "OptionGroup")
570:         WITH loc_oPagina.obj_4c_OptCalculo
571:             .Top         = 60
572:             .Left        = 351
573:             .Width       = 155
574:             .Height      = 21
575:             .ButtonCount = 2
576:             .BackStyle   = 0
577:             .BorderStyle = 0
578:             .Value       = THIS.this_nParTipoCalculo
579:             .Enabled     = .F.
580: 
581:             WITH .Buttons(1)
582:                 .Caption   = "Simples"
583:                 .BackStyle = 0
584:                 .ForeColor = RGB(90, 90, 90)
585:                 .Width     = 60
586:                 .Height    = 21
587:                 .Top       = 0
588:                 .Left      = 0
589:                 .AutoSize  = .F.
590:                 .Themes    = .F.
591:             ENDWITH
592: 
593:             WITH .Buttons(2)
594:                 .Caption   = "Composto"
595:                 .BackStyle = 0
596:                 .FontName  = "Tahoma"
597:                 .FontSize  = 8
598:                 .ForeColor = RGB(90, 90, 90)
599:                 .Width     = 75
600:                 .Height    = 21
601:                 .Top       = 0
602:                 .Left      = 63
603:                 .AutoSize  = .F.
604:                 .Themes    = .F.
605:             ENDWITH
606:         ENDWITH
607: 
608:         *-- Label "Juros por Dia :"
609:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")

*-- Linhas 648 a 692:
648:             .ForeColor = RGB(90, 90, 90)
649:         ENDWITH
650: 
651:         *-- OptionGroup tipo de contagem de dias (Corridos/Nao Corridos)
652:         loc_oPagina.AddObject("obj_4c_OptDias", "OptionGroup")
653:         WITH loc_oPagina.obj_4c_OptDias
654:             .Top         = 78
655:             .Left        = 351
656:             .Width       = 175
657:             .Height      = 21
658:             .ButtonCount = 2
659:             .BackStyle   = 0
660:             .BorderStyle = 0
661:             .Value       = 1
662:             .Enabled     = .F.
663: 
664:             WITH .Buttons(1)
665:                 .Caption   = "Corridos"
666:                 .BackStyle = 0
667:                 .ForeColor = RGB(90, 90, 90)
668:                 .Width     = 65
669:                 .Height    = 21
670:                 .Top       = 0
671:                 .Left      = 0
672:                 .AutoSize  = .F.
673:                 .Themes    = .F.
674:             ENDWITH
675: 
676:             WITH .Buttons(2)
677:                 .Caption   = "N" + CHR(227) + "o Corridos"
678:                 .BackStyle = 0
679:                 .FontName  = "Tahoma"
680:                 .FontSize  = 8
681:                 .ForeColor = RGB(90, 90, 90)
682:                 .Width     = 100
683:                 .Height    = 21
684:                 .Top       = 0
685:                 .Left      = 68
686:                 .AutoSize  = .F.
687:                 .Themes    = .F.
688:             ENDWITH
689:         ENDWITH
690: 
691:         *-- Separador visual (equivalente ao Commandgroup1 Height=1 do original)
692:         loc_oPagina.AddObject("lbl_4c_Separador", "Label")

*-- Linhas 807 a 884:
807:             .MousePointer = 15
808:         ENDWITH
809: 
810:         BINDEVENT(loc_oPagina.cmd_4c_Vencimentos, "Click",           THIS, "CmdVencimentosClick")
811:         BINDEVENT(loc_oPagina.txt_4c_ValorBase,   "KeyPress",        THIS, "TxtValorBaseKeyPress")
812:         BINDEVENT(loc_oPagina.txt_4c_JurosMes,    "KeyPress",        THIS, "TxtJurosMesKeyPress")
813:         BINDEVENT(loc_oPagina.txt_4c_JurosDia,    "KeyPress",        THIS, "TxtJurosDiaKeyPress")
814:         BINDEVENT(loc_oPagina.txt_4c_DataBase,    "KeyPress",        THIS, "TxtDataBaseKeyPress")
815:         BINDEVENT(loc_oPagina.txt_4c_DataFinal,   "KeyPress",        THIS, "TxtDataFinalKeyPress")
816:         BINDEVENT(loc_oPagina.txt_4c_Dias,        "KeyPress",        THIS, "TxtDiasKeyPress")
817:         BINDEVENT(loc_oPagina.obj_4c_OptCalculo,  "InteractiveChange", THIS, "OptCalculoInteractiveChange")
818:         BINDEVENT(loc_oPagina.obj_4c_OptDias,     "InteractiveChange", THIS, "OptDiasInteractiveChange")
819:     ENDPROC
820: 
821:     *===========================================================================
822:     * AlternarPagina - Navega entre Page1 (Calculo) e Page2 (Vencimentos)
823:     * par_nPagina: 1 ou 2; se omitido, alterna entre a pagina atual
824:     *===========================================================================
825:     PROCEDURE AlternarPagina(par_nPagina)
826:         IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
827:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
828:         ELSE
829:             THIS.pgf_4c_Paginas.ActivePage = IIF(THIS.pgf_4c_Paginas.ActivePage = 1, 2, 1)
830:         ENDIF
831:     ENDPROC
832: 
833:     *===========================================================================
834:     * CmdVencimentosClick - Navega para Page2 (Vencimentos)
835:     *===========================================================================
836:     PROCEDURE CmdVencimentosClick()
837:         THIS.AlternarPagina(2)
838:     ENDPROC
839: 
840:     *===========================================================================
841:     * PreencherParametrosIniciais - Preenche campos com parametros do chamador
842:     * Chamado apos ConfigurarPaginaCalculo() para inicializar valores recebidos
843:     *===========================================================================
844:     PROTECTED PROCEDURE PreencherParametrosIniciais()
845:         LOCAL loc_oPagina, loc_lHabilitar
846: 
847:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
848:         loc_lHabilitar = .F.
849: 
850:         IF THIS.this_nParValorBase > 0
851:             loc_oPagina.txt_4c_ValorBase.Value = THIS.this_nParValorBase
852:             loc_lHabilitar = .T.
853:         ENDIF
854: 
855:         THIS.HabilitarCamposEntrada(loc_lHabilitar)
856: 
857:         IF loc_lHabilitar
858:             loc_oPagina.obj_4c_OptCalculo.Value = THIS.this_nParTipoCalculo
859: 
860:             IF THIS.this_nParJurosMes > 0
861:                 loc_oPagina.txt_4c_JurosMes.Value = THIS.this_nParJurosMes
862:                 IF THIS.this_nParTipoCalculo = 1
863:                     loc_oPagina.txt_4c_JurosDia.Value = ROUND(THIS.this_nParJurosMes / 30, 9)
864:                 ELSE
865:                     loc_oPagina.txt_4c_JurosDia.Value = ROUND((((1 + THIS.this_nParJurosMes/100) ^ (1/30)) - 1) * 100, 9)
866:                 ENDIF
867:             ENDIF
868: 
869:             IF THIS.this_nParJurosDia > 0 AND THIS.this_nParJurosMes = 0
870:                 loc_oPagina.txt_4c_JurosDia.Value = THIS.this_nParJurosDia
871:                 IF THIS.this_nParTipoCalculo = 1
872:                     loc_oPagina.txt_4c_JurosMes.Value = ROUND(THIS.this_nParJurosDia * 30, 2)
873:                 ELSE
874:                     loc_oPagina.txt_4c_JurosMes.Value = ROUND((((1 + THIS.this_nParJurosDia/100) ^ 30) - 1) * 100, 2)
875:                 ENDIF
876:             ENDIF
877: 
878:             IF VARTYPE(THIS.this_dParDataBase) = "D" AND !EMPTY(THIS.this_dParDataBase)
879:                 loc_oPagina.txt_4c_DataBase.Value = THIS.this_dParDataBase
880:             ENDIF
881: 
882:             IF VARTYPE(THIS.this_dParDataFinal) = "D" AND !EMPTY(THIS.this_dParDataFinal)
883:                 loc_oPagina.txt_4c_DataFinal.Value = THIS.this_dParDataFinal
884:                 IF !EMPTY(THIS.this_dParDataBase)

*-- Linhas 894 a 959:
894:     * HabilitarCamposEntrada - Habilita ou desabilita campos vinculados
895:     * Chamado quando ValorBase eh preenchido (habilita) ou zerado (desabilita)
896:     *===========================================================================
897:     PROTECTED PROCEDURE HabilitarCamposEntrada(par_lHabilitar)
898:         LOCAL loc_oPagina
899: 
900:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
901: 
902:         WITH loc_oPagina
903:             .obj_4c_OptCalculo.Enabled = par_lHabilitar
904:             .txt_4c_JurosMes.Enabled   = par_lHabilitar
905:             .txt_4c_JurosDia.Enabled   = par_lHabilitar
906:             .txt_4c_DataBase.Enabled   = par_lHabilitar
907:             .txt_4c_DataFinal.Enabled  = par_lHabilitar
908:             .txt_4c_Dias.Enabled       = par_lHabilitar
909:             .obj_4c_OptDias.Enabled    = par_lHabilitar
910:         ENDWITH
911:     ENDPROC
912: 
913:     *===========================================================================
914:     * Calculos - Motor de calculo de juros (logica completa com vencimentos)
915:     * Equivale ao PROCEDURE Calculos() do form SIGPRCFN original
916:     * Chamado sempre que qualquer campo de entrada eh alterado
917:     * Quando ha datas de vencimento em Page2, recalcula juros por parcela
918:     *===========================================================================
919:     PROCEDURE Calculos()
920:         LOCAL loc_oPg1, loc_oPg2, loc_nValorBase, loc_nJurosMes, loc_nJurosDia
921:         LOCAL loc_nDias, loc_nTipoCalculo, loc_nJuros, loc_nTotal
922:         LOCAL loc_nParc, loc_nTotDia, loc_nI, loc_cNomeCampo, loc_dVenc, loc_nDiaVenc
923: 
924:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
925:         loc_oPg2         = THIS.pgf_4c_Paginas.Page2
926:         loc_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
927:         loc_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
928:         loc_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
929:         loc_nDias        = loc_oPg1.txt_4c_Dias.Value
930:         loc_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
931:         loc_nJuros       = 0
932:         loc_nParc        = 0
933:         loc_nTotDia      = 0
934: 
935:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0 OR ;
936:            (EMPTY(loc_nJurosMes) AND EMPTY(loc_nJurosDia)) OR ;
937:            EMPTY(loc_nDias) OR loc_nDias = 0
938: 
939:             loc_oPg1.txt_4c_ValorJuros.Value = 0
940:             loc_oPg1.txt_4c_ValorTotal.Value = 0
941:             loc_oPg1.txt_4c_Valorpar.Value   = 0
942:             RETURN
943:         ENDIF
944: 
945:         IF loc_nTipoCalculo = 1
946:             *-- Juros Simples: J = PV * (i_mes/100) * (n/30)
947:             loc_nJuros = ROUND(loc_nValorBase * (loc_nJurosMes / 100) * (loc_nDias / 30), 2)
948:         ELSE
949:             *-- Juros Compostos: J = PV * ((1 + i_dia/100)^n - 1)
950:             loc_nJuros = ROUND(loc_nValorBase * (((1 + loc_nJurosDia / 100) ^ loc_nDias) - 1), 2)
951:         ENDIF
952: 
953:         *-- Loop vencimentos: recalcula por parcela quando houver datas preenchidas em Page2
954:         FOR loc_nI = 1 TO 10
955:             loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
956:             IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
957:                 loc_dVenc = EVALUATE("loc_oPg2." + loc_cNomeCampo + ".Value")
958:                 IF !EMPTY(loc_dVenc)
959:                     IF loc_nParc = 0

*-- Linhas 986 a 1279:
986:     * CalcularParcela - Calcula valor da parcela com base nos vencimentos de Page2
987:     * Se Page2 ainda nao tem vencimentos, divide por 10 (padrao 10 parcelas)
988:     *===========================================================================
989:     PROTECTED PROCEDURE CalcularParcela(par_nTotal)
990:         LOCAL loc_nParcelas, loc_nI, loc_cNomeCampo, loc_oPg2, loc_oField
991: 
992:         loc_nParcelas = 0
993: 
994:         IF THIS.pgf_4c_Paginas.PageCount >= 2
995:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
996:             FOR loc_nI = 1 TO 10
997:                 loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
998:                 IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
999:                     loc_oField = EVALUATE("loc_oPg2." + loc_cNomeCampo)
1000:                     IF !EMPTY(loc_oField.Value)
1001:                         loc_nParcelas = loc_nParcelas + 1
1002:                     ENDIF
1003:                 ENDIF
1004:             ENDFOR
1005:         ENDIF
1006: 
1007:         IF loc_nParcelas = 0
1008:             RETURN ROUND(par_nTotal / 10, 2)
1009:         ENDIF
1010: 
1011:         RETURN ROUND(par_nTotal / loc_nParcelas, 2)
1012:     ENDPROC
1013: 
1014:     *===========================================================================
1015:     * TxtValorBaseKeyPress - Valid para campo Valor Base
1016:     * Ao confirmar (ENTER/TAB), valida e habilita/desabilita demais campos
1017:     *===========================================================================
1018:     PROCEDURE TxtValorBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1019:         LOCAL loc_oPagina, loc_nValor, loc_lHabilitar
1020: 
1021:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1022:             RETURN
1023:         ENDIF
1024: 
1025:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1026:         loc_nValor     = loc_oPagina.txt_4c_ValorBase.Value
1027:         loc_lHabilitar = .F.
1028: 
1029:         IF loc_nValor < 0
1030:             MsgAviso("O Valor Base Precisa Ser Positivo!", "Aten" + CHR(231) + CHR(227) + "o")
1031:             loc_oPagina.txt_4c_ValorBase.SetFocus()
1032:             RETURN
1033:         ENDIF
1034: 
1035:         loc_lHabilitar = (loc_nValor > 0)
1036:         THIS.HabilitarCamposEntrada(loc_lHabilitar)
1037:         THIS.Calculos()
1038:     ENDPROC
1039: 
1040:     *===========================================================================
1041:     * TxtJurosMesKeyPress - Valid para campo Juros/Mes
1042:     * Calcula JurosDia equivalente e recalcula juros
1043:     *===========================================================================
1044:     PROCEDURE TxtJurosMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1045:         LOCAL loc_oPagina, loc_nJurosMes, loc_nJurosDia, loc_nTipo
1046: 
1047:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1048:             RETURN
1049:         ENDIF
1050: 
1051:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1052:         loc_nJurosMes = loc_oPagina.txt_4c_JurosMes.Value
1053:         loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value
1054: 
1055:         IF loc_nTipo = 1
1056:             loc_nJurosDia = ROUND(loc_nJurosMes / 30, 9)
1057:         ELSE
1058:             loc_nJurosDia = ROUND((((1 + loc_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
1059:         ENDIF
1060: 
1061:         loc_oPagina.txt_4c_JurosDia.Value = loc_nJurosDia
1062:         THIS.Calculos()
1063:     ENDPROC
1064: 
1065:     *===========================================================================
1066:     * TxtJurosDiaKeyPress - Valid para campo Juros por Dia
1067:     * Calcula JurosMes equivalente e recalcula juros
1068:     *===========================================================================
1069:     PROCEDURE TxtJurosDiaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1070:         LOCAL loc_oPagina, loc_nJurosDia, loc_nJurosMes, loc_nTipo
1071: 
1072:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1073:             RETURN
1074:         ENDIF
1075: 
1076:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1077:         loc_nJurosDia = loc_oPagina.txt_4c_JurosDia.Value
1078:         loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value
1079: 
1080:         IF loc_nTipo = 1
1081:             loc_nJurosMes = ROUND(loc_nJurosDia * 30, 2)
1082:         ELSE
1083:             loc_nJurosMes = ROUND((((1 + loc_nJurosDia / 100) ^ 30) - 1) * 100, 2)
1084:         ENDIF
1085: 
1086:         loc_oPagina.txt_4c_JurosMes.Value = loc_nJurosMes
1087:         THIS.Calculos()
1088:     ENDPROC
1089: 
1090:     *===========================================================================
1091:     * TxtDataBaseKeyPress - Valid para campo Data Base
1092:     * Valida ordenacao das datas, recalcula dias e chama Calculos()
1093:     *===========================================================================
1094:     PROCEDURE TxtDataBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1095:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1096: 
1097:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1098:             RETURN
1099:         ENDIF
1100: 
1101:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1102:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1103:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1104: 
1105:         IF !EMPTY(loc_dDataFinal) AND !EMPTY(loc_dDataBase)
1106:             IF loc_dDataBase > loc_dDataFinal
1107:                 MsgAviso("A Data Base N" + CHR(227) + "o Pode Ser Maior Que a Data Final!", "Aten" + CHR(231) + CHR(227) + "o")
1108:                 loc_oPagina.txt_4c_DataBase.SetFocus()
1109:                 RETURN
1110:             ENDIF
1111:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1112:         ENDIF
1113: 
1114:         THIS.Calculos()
1115:     ENDPROC
1116: 
1117:     *===========================================================================
1118:     * TxtDataFinalKeyPress - Valid para campo Data Final
1119:     * Valida ordenacao das datas, recalcula dias (uteis ou corridos) e calcula
1120:     *===========================================================================
1121:     PROCEDURE TxtDataFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1122:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1123: 
1124:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1125:             RETURN
1126:         ENDIF
1127: 
1128:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1129:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1130:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1131: 
1132:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1133:             IF loc_dDataFinal < loc_dDataBase
1134:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", "Aten" + CHR(231) + CHR(227) + "o")
1135:                 loc_oPagina.txt_4c_DataFinal.SetFocus()
1136:                 RETURN
1137:             ENDIF
1138:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1139:         ENDIF
1140: 
1141:         THIS.Calculos()
1142:     ENDPROC
1143: 
1144:     *===========================================================================
1145:     * TxtDiasKeyPress - Valid para campo Dias
1146:     * Em modo corridos: ajusta DataFinal ou DataBase a partir dos dias informados
1147:     * Em modo uteis: apenas recalcula (datas definem os dias uteis)
1148:     *===========================================================================
1149:     PROCEDURE TxtDiasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1150:         LOCAL loc_oPagina, loc_nDias, loc_dDataBase, loc_dDataFinal, loc_nTipoDias
1151: 
1152:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1153:             RETURN
1154:         ENDIF
1155: 
1156:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1157:         loc_nDias      = loc_oPagina.txt_4c_Dias.Value
1158:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1159:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1160:         loc_nTipoDias  = loc_oPagina.obj_4c_OptDias.Value
1161: 
1162:         IF loc_nTipoDias = 1
1163:             IF !EMPTY(loc_dDataBase)
1164:                 loc_oPagina.txt_4c_DataFinal.Value = loc_dDataBase + loc_nDias
1165:             ELSE
1166:                 IF !EMPTY(loc_dDataFinal)
1167:                     loc_oPagina.txt_4c_DataBase.Value = loc_dDataFinal - loc_nDias
1168:                 ENDIF
1169:             ENDIF
1170:         ELSE
1171:             IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1172:                 loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1173:             ENDIF
1174:         ENDIF
1175: 
1176:         THIS.Calculos()
1177:     ENDPROC
1178: 
1179:     *===========================================================================
1180:     * OptCalculoInteractiveChange - Disparado ao mudar tipo de calculo
1181:     *===========================================================================
1182:     PROCEDURE OptCalculoInteractiveChange()
1183:         THIS.Calculos()
1184:     ENDPROC
1185: 
1186:     *===========================================================================
1187:     * OptDiasInteractiveChange - Disparado ao mudar tipo de contagem de dias
1188:     * Recalcula dias uteis se datas estiverem preenchidas
1189:     *===========================================================================
1190:     PROCEDURE OptDiasInteractiveChange()
1191:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1192: 
1193:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1194:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1195:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1196: 
1197:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1198:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1199:         ENDIF
1200: 
1201:         THIS.Calculos()
1202:     ENDPROC
1203: 
1204:     *===========================================================================
1205:     * CalcularDiasUteis - Calcula dias entre duas datas conforme tipo selecionado
1206:     * optDias=1 (Corridos): retorna DataFim - DataInicio (dias corridos)
1207:     * optDias=2 (Nao Corridos): desconta finais de semana (equivale a fChkFeriado)
1208:     *===========================================================================
1209:     PROTECTED PROCEDURE CalcularDiasUteis(par_dDataInicio, par_dDataFim, par_oPagina)
1210:         LOCAL loc_nTipoDias, loc_nDias, loc_dDataAtual
1211: 
1212:         IF VARTYPE(par_oPagina) = "O"
1213:             loc_nTipoDias = par_oPagina.obj_4c_OptDias.Value
1214:         ELSE
1215:             loc_nTipoDias = 1
1216:         ENDIF
1217: 
1218:         loc_nDias = par_dDataFim - par_dDataInicio
1219: 
1220:         IF loc_nDias > 0 AND loc_nTipoDias = 2
1221:             *-- Descontar sabados (DOW=7) e domingos (DOW=1) - equivale a fChkFeriado(d,.T.,.T.,.F.)
1222:             loc_dDataAtual = par_dDataInicio
1223:             DO WHILE loc_dDataAtual <= par_dDataFim
1224:                 IF DOW(loc_dDataAtual) = 1 OR DOW(loc_dDataAtual) = 7
1225:                     loc_nDias = loc_nDias - 1
1226:                 ENDIF
1227:                 loc_dDataAtual = loc_dDataAtual + 1
1228:             ENDDO
1229:         ENDIF
1230: 
1231:         RETURN loc_nDias
1232:     ENDPROC
1233: 
1234:     *===========================================================================
1235:     * ConfigurarPaginaVencimentos - Popula Page2 com campos de datas de vencimento
1236:     * Layout: 5 colunas x 2 linhas (venc1,3,5,7,9 na linha 1; venc2,4,6,8,10 na linha 2)
1237:     * 10 campos de data equivalentes a getvenc1..getvenc10 do original
1238:     *===========================================================================
1239:     PROTECTED PROCEDURE ConfigurarPaginaVencimentos()
1240:         LOCAL loc_oPagina
1241: 
1242:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1243: 
1244:         *-- Botao Voltar (navega de volta para Page1 - Calculo)
1245:         loc_oPagina.AddObject("cmd_4c_Voltar", "CommandButton")
1246:         WITH loc_oPagina.cmd_4c_Voltar
1247:             .Top          = 5
1248:             .Left         = 5
1249:             .Width        = 110
1250:             .Height       = 23
1251:             .Caption      = "< C" + CHR(225) + "lculo"
1252:             .FontName     = "Tahoma"
1253:             .FontBold     = .T.
1254:             .FontSize     = 8
1255:             .ForeColor    = RGB(90, 90, 90)
1256:             .BackColor    = RGB(240, 240, 240)
1257:             .Themes       = .T.
1258:             .MousePointer = 15
1259:         ENDWITH
1260: 
1261:         *-- Label "Vencimentos :"
1262:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1263:         WITH loc_oPagina.lbl_4c_Label11
1264:             .Top       = 75
1265:             .Left      = 26
1266:             .AutoSize  = .T.
1267:             .BackStyle = 0
1268:             .Caption   = "Vencimentos :"
1269:             .FontName  = "Tahoma"
1270:             .FontSize  = 8
1271:             .ForeColor = RGB(90, 90, 90)
1272:         ENDWITH
1273: 
1274:         *-- Coluna 1: venc1 (linha 1) + venc2 (linha 2)
1275:         loc_oPagina.AddObject("txt_4c_Venc1", "TextBox")
1276:         WITH loc_oPagina.txt_4c_Venc1
1277:             .Top       = 71
1278:             .Left      = 97
1279:             .Width     = 80

*-- Linhas 1416 a 1831:
1416:             .ForeColor = RGB(90, 90, 90)
1417:         ENDWITH
1418: 
1419:         BINDEVENT(loc_oPagina.cmd_4c_Voltar,  "Click",    THIS, "CmdVoltarClick")
1420:         BINDEVENT(loc_oPagina.txt_4c_Venc1,   "KeyPress", THIS, "TxtVencKeyPress")
1421:         BINDEVENT(loc_oPagina.txt_4c_Venc2,   "KeyPress", THIS, "TxtVencKeyPress")
1422:         BINDEVENT(loc_oPagina.txt_4c_Venc3,   "KeyPress", THIS, "TxtVencKeyPress")
1423:         BINDEVENT(loc_oPagina.txt_4c_Venc4,   "KeyPress", THIS, "TxtVencKeyPress")
1424:         BINDEVENT(loc_oPagina.txt_4c_Venc5,   "KeyPress", THIS, "TxtVencKeyPress")
1425:         BINDEVENT(loc_oPagina.txt_4c_Venc6,   "KeyPress", THIS, "TxtVencKeyPress")
1426:         BINDEVENT(loc_oPagina.txt_4c_Venc7,   "KeyPress", THIS, "TxtVencKeyPress")
1427:         BINDEVENT(loc_oPagina.txt_4c_Venc8,   "KeyPress", THIS, "TxtVencKeyPress")
1428:         BINDEVENT(loc_oPagina.txt_4c_Venc9,   "KeyPress", THIS, "TxtVencKeyPress")
1429:         BINDEVENT(loc_oPagina.txt_4c_Venc10,  "KeyPress", THIS, "TxtVencKeyPress")
1430:     ENDPROC
1431: 
1432:     *===========================================================================
1433:     * CmdVoltarClick - Navega de volta para Page1 (Calculo)
1434:     *===========================================================================
1435:     PROCEDURE CmdVoltarClick()
1436:         THIS.AlternarPagina(1)
1437:     ENDPROC
1438: 
1439:     *===========================================================================
1440:     * CmdLimparClick - Limpa todos os campos e reinicia a calculadora
1441:     *===========================================================================
1442:     PROCEDURE CmdLimparClick()
1443:         LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc
1444: 
1445:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1446:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1447: 
1448:         loc_oPg1.txt_4c_ValorBase.Value  = 0
1449:         loc_oPg1.txt_4c_JurosMes.Value   = 0
1450:         loc_oPg1.txt_4c_JurosDia.Value   = 0
1451:         loc_oPg1.txt_4c_DataBase.Value   = {}
1452:         loc_oPg1.txt_4c_DataFinal.Value  = {}
1453:         loc_oPg1.txt_4c_Dias.Value       = 0
1454:         loc_oPg1.txt_4c_ValorJuros.Value = 0
1455:         loc_oPg1.txt_4c_ValorTotal.Value = 0
1456:         loc_oPg1.txt_4c_Valorpar.Value   = 0
1457:         loc_oPg1.obj_4c_OptCalculo.Value = 1
1458:         loc_oPg1.obj_4c_OptDias.Value    = 1
1459: 
1460:         FOR loc_nI = 1 TO 10
1461:             loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
1462:             IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
1463:                 loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
1464:                 IF VARTYPE(loc_oVenc) = "O"
1465:                     loc_oVenc.Value = {}
1466:                 ENDIF
1467:             ENDIF
1468:         ENDFOR
1469: 
1470:         THIS.HabilitarCamposEntrada(.F.)
1471:         THIS.pgf_4c_Paginas.ActivePage = 1
1472:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1473:     ENDPROC
1474: 
1475:     *===========================================================================
1476:     * TxtVencKeyPress - Handler compartilhado para todos os campos de vencimento
1477:     * Valida data >= DataBase, atualiza campo Dias e recalcula juros
1478:     * Equivale ao PROCEDURE Valid de cada getvencN no original
1479:     *===========================================================================
1480:     PROCEDURE TxtVencKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1481:         LOCAL loc_oPg1, loc_oPg2, loc_oControl, loc_dVenc, loc_dDataBase
1482: 
1483:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1484:             RETURN
1485:         ENDIF
1486: 
1487:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1488:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1489:         loc_oControl = loc_oPg2.ActiveControl
1490: 
1491:         IF VARTYPE(loc_oControl) != "O"
1492:             THIS.Calculos()
1493:             RETURN
1494:         ENDIF
1495: 
1496:         loc_dVenc     = loc_oControl.Value
1497:         loc_dDataBase = loc_oPg1.txt_4c_DataBase.Value
1498: 
1499:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dVenc)
1500:             IF loc_dVenc < loc_dDataBase
1501:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", ;
1502:                          "Aten" + CHR(231) + CHR(227) + "o")
1503:                 loc_oControl.SetFocus()
1504:                 RETURN
1505:             ENDIF
1506:             loc_oPg1.txt_4c_Dias.Value = loc_dVenc - loc_dDataBase
1507:         ENDIF
1508: 
1509:         THIS.Calculos()
1510:     ENDPROC
1511: 
1512:     *===========================================================================
1513:     * BtnIncluirClick - Nova simulacao (reset completo + habilita entrada)
1514:     * Equivale a "Incluir" em forms CRUD: prepara formulario para nova entrada
1515:     * Reusa CmdLimparClick para zerar campos e HabilitarCamposEntrada para liberar
1516:     *===========================================================================
1517:     PROCEDURE BtnIncluirClick()
1518:         LOCAL loc_oPg1
1519: 
1520:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1521: 
1522:         *-- Zera todos os campos de entrada e resultado, retorna a Page1
1523:         THIS.CmdLimparClick()
1524: 
1525:         *-- Habilita ValorBase para o usuario iniciar nova simulacao
1526:         loc_oPg1.txt_4c_ValorBase.Enabled = .T.
1527:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1528: 
1529:         *-- Modo INCLUIR: campos vinculados so habilitam ao informar ValorBase > 0
1530:         THIS.HabilitarCamposEntrada(.F.)
1531:         THIS.this_cModoAtual = "INCLUIR"
1532: 
1533:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1534:     ENDPROC
1535: 
1536:     *===========================================================================
1537:     * BtnAlterarClick - Habilita edicao dos campos da simulacao atual
1538:     * Equivale a "Alterar" em forms CRUD: libera campos para modificacao
1539:     * Reabilita entrada preservando valores digitados (nao limpa)
1540:     *===========================================================================
1541:     PROCEDURE BtnAlterarClick()
1542:         LOCAL loc_oPg1, loc_nValorBase
1543: 
1544:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1545:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1546: 
1547:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1548:             MsgAviso("Informe o Valor Base para iniciar uma simula" + CHR(231) + CHR(227) + "o.", ;
1549:                      "Aten" + CHR(231) + CHR(227) + "o")
1550:             loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
1551:             loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1552:             loc_oPg1.txt_4c_ValorBase.SetFocus()
1553:             RETURN
1554:         ENDIF
1555: 
1556:         *-- Libera campos de entrada (ValorBase, Juros, Datas, Dias e OptionGroups)
1557:         loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
1558:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1559:         THIS.HabilitarCamposEntrada(.T.)
1560:         THIS.this_cModoAtual = "ALTERAR"
1561: 
1562:         *-- Recalcula com valores atuais para refletir eventuais mudancas
1563:         THIS.Calculos()
1564: 
1565:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1566:     ENDPROC
1567: 
1568:     *===========================================================================
1569:     * BtnVisualizarClick - Modo somente-leitura da simulacao atual
1570:     * Equivale a "Visualizar" em forms CRUD: bloqueia edicao e mostra vencimentos
1571:     * Alterna para Page2 (Vencimentos) apos travar Page1
1572:     *===========================================================================
1573:     PROCEDURE BtnVisualizarClick()
1574:         LOCAL loc_oPg1, loc_nValorBase
1575: 
1576:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1577:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1578: 
1579:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1580:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " simula" + CHR(231) + CHR(227) + ;
1581:                      "o para visualizar. Informe o Valor Base primeiro.", ;
1582:                      "Aten" + CHR(231) + CHR(227) + "o")
1583:             RETURN
1584:         ENDIF
1585: 
1586:         *-- Trava todos os campos de entrada em modo visualizacao
1587:         loc_oPg1.txt_4c_ValorBase.Enabled  = .F.
1588:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .T.
1589:         THIS.HabilitarCamposEntrada(.F.)
1590:         THIS.this_cModoAtual = "VISUALIZAR"
1591: 
1592:         *-- Recalcula para garantir consistencia dos resultados exibidos
1593:         THIS.Calculos()
1594: 
1595:         *-- Navega para Page2 (Vencimentos) para revisao das parcelas
1596:         THIS.AlternarPagina(2)
1597:     ENDPROC
1598: 
1599:     *===========================================================================
1600:     * BtnExcluirClick - Descarta a simulacao atual (limpa todos os dados)
1601:     * Equivale a "Excluir" em forms CRUD: apaga entrada e resultados
1602:     * Confirma com o usuario antes de zerar, evitando perda acidental
1603:     *===========================================================================
1604:     PROCEDURE BtnExcluirClick()
1605:         LOCAL loc_oPg1, loc_nValorBase, loc_lConfirma
1606: 
1607:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1608:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1609: 
1610:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1611:             *-- Nao ha simulacao a descartar; apenas garante estado inicial
1612:             THIS.CmdLimparClick()
1613:             THIS.this_cModoAtual = "CALCULO"
1614:             RETURN
1615:         ENDIF
1616: 
1617:         loc_lConfirma = MsgConfirma("Deseja realmente descartar a simula" + CHR(231) + CHR(227) + ;
1618:                                     "o atual?", ;
1619:                                     "Confirma" + CHR(231) + CHR(227) + "o")
1620: 
1621:         IF !loc_lConfirma
1622:             RETURN
1623:         ENDIF
1624: 
1625:         *-- Zera todos os campos (Page1 + Page2), volta para Page1 e reinicia modo
1626:         THIS.CmdLimparClick()
1627:         THIS.this_cModoAtual = "CALCULO"
1628:     ENDPROC
1629: 
1630:     *===========================================================================
1631:     * CarregarLista - N/A para calculadora (sem lista de registros em BD)
1632:     * Existe para compatibilidade com o pipeline de migracao
1633:     *===========================================================================
1634:     PROCEDURE CarregarLista()
1635:         RETURN .T.
1636:     ENDPROC
1637: 
1638:     *===========================================================================
1639:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1640:     * Para calculadora: habilita Limpar somente quando ha valor base preenchido
1641:     *===========================================================================
1642:     PROCEDURE AjustarBotoesPorModo()
1643:         LOCAL loc_lTemCalculo
1644: 
1645:         loc_lTemCalculo = (THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.Value > 0)
1646: 
1647:         IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "cmd_4c_Limpar", 5)
1648:             THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar.Enabled = loc_lTemCalculo
1649:         ENDIF
1650:     ENDPROC
1651: 
1652:     *===========================================================================
1653:     * LimparCampos - Limpa todos os campos de entrada e resultado
1654:     * Equivalente semantico ao LimparCampos() do pipeline CRUD
1655:     *===========================================================================
1656:     PROCEDURE LimparCampos()
1657:         LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc
1658: 
1659:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1660:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1661: 
1662:         loc_oPg1.txt_4c_ValorBase.Value  = 0
1663:         loc_oPg1.txt_4c_JurosMes.Value   = 0
1664:         loc_oPg1.txt_4c_JurosDia.Value   = 0
1665:         loc_oPg1.txt_4c_DataBase.Value   = {}
1666:         loc_oPg1.txt_4c_DataFinal.Value  = {}
1667:         loc_oPg1.txt_4c_Dias.Value       = 0
1668:         loc_oPg1.txt_4c_ValorJuros.Value = 0
1669:         loc_oPg1.txt_4c_ValorTotal.Value = 0
1670:         loc_oPg1.txt_4c_Valorpar.Value   = 0
1671:         loc_oPg1.obj_4c_OptCalculo.Value = 1
1672:         loc_oPg1.obj_4c_OptDias.Value    = 1
1673: 
1674:         FOR loc_nI = 1 TO 10
1675:             loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
1676:             IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
1677:                 loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
1678:                 IF VARTYPE(loc_oVenc) = "O"
1679:                     loc_oVenc.Value = {}
1680:                 ENDIF
1681:             ENDIF
1682:         ENDFOR
1683: 
1684:         THIS.HabilitarCamposEntrada(.F.)
1685:     ENDPROC
1686: 
1687:     *===========================================================================
1688:     * HabilitarCampos - Habilita ou desabilita todos os campos editaveis
1689:     * Generaliza HabilitarCamposEntrada() incluindo o proprio ValorBase
1690:     * par_lHabilitar: .T. = habilita, .F. = desabilita
1691:     *===========================================================================
1692:     PROCEDURE HabilitarCampos(par_lHabilitar)
1693:         LOCAL loc_oPg1
1694: 
1695:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1696: 
1697:         loc_oPg1.txt_4c_ValorBase.Enabled  = par_lHabilitar
1698:         loc_oPg1.txt_4c_ValorBase.ReadOnly = !par_lHabilitar
1699: 
1700:         THIS.HabilitarCamposEntrada(par_lHabilitar)
1701:     ENDPROC
1702: 
1703:     *===========================================================================
1704:     * FormParaBO - Transfere valores dos campos do form para as propriedades do BO
1705:     * Mapeamento completo: entradas + tipo + vencimentos
1706:     *===========================================================================
1707:     PROTECTED PROCEDURE FormParaBO()
1708:         LOCAL loc_oPg1, loc_oPg2, loc_oBO
1709: 
1710:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1711:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1712:         loc_oBO  = THIS.this_oBusinessObject
1713: 
1714:         loc_oBO.this_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
1715:         loc_oBO.this_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
1716:         loc_oBO.this_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
1717:         loc_oBO.this_dDataBase    = loc_oPg1.txt_4c_DataBase.Value
1718:         loc_oBO.this_dDataFinal   = loc_oPg1.txt_4c_DataFinal.Value
1719:         loc_oBO.this_nDias        = loc_oPg1.txt_4c_Dias.Value
1720:         loc_oBO.this_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
1721:         loc_oBO.this_nTipoDias    = loc_oPg1.obj_4c_OptDias.Value
1722:         loc_oBO.this_dVenc1       = loc_oPg2.txt_4c_Venc1.Value
1723:         loc_oBO.this_dVenc2       = loc_oPg2.txt_4c_Venc2.Value
1724:         loc_oBO.this_dVenc3       = loc_oPg2.txt_4c_Venc3.Value
1725:         loc_oBO.this_dVenc4       = loc_oPg2.txt_4c_Venc4.Value
1726:         loc_oBO.this_dVenc5       = loc_oPg2.txt_4c_Venc5.Value
1727:         loc_oBO.this_dVenc6       = loc_oPg2.txt_4c_Venc6.Value
1728:         loc_oBO.this_dVenc7       = loc_oPg2.txt_4c_Venc7.Value
1729:         loc_oBO.this_dVenc8       = loc_oPg2.txt_4c_Venc8.Value
1730:         loc_oBO.this_dVenc9       = loc_oPg2.txt_4c_Venc9.Value
1731:         loc_oBO.this_dVenc10      = loc_oPg2.txt_4c_Venc10.Value
1732:     ENDPROC
1733: 
1734:     *===========================================================================
1735:     * BOParaForm - Transfere propriedades do BO de volta para os campos do form
1736:     * Carrega entradas + resultados do calculo + vencimentos
1737:     *===========================================================================
1738:     PROTECTED PROCEDURE BOParaForm()
1739:         LOCAL loc_oPg1, loc_oPg2, loc_oBO
1740: 
1741:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1742:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1743:         loc_oBO  = THIS.this_oBusinessObject
1744: 
1745:         loc_oPg1.txt_4c_ValorBase.Value  = loc_oBO.this_nValorBase
1746:         loc_oPg1.txt_4c_JurosMes.Value   = loc_oBO.this_nJurosMes
1747:         loc_oPg1.txt_4c_JurosDia.Value   = loc_oBO.this_nJurosDia
1748:         loc_oPg1.txt_4c_DataBase.Value   = loc_oBO.this_dDataBase
1749:         loc_oPg1.txt_4c_DataFinal.Value  = loc_oBO.this_dDataFinal
1750:         loc_oPg1.txt_4c_Dias.Value       = loc_oBO.this_nDias
1751:         loc_oPg1.obj_4c_OptCalculo.Value = loc_oBO.this_nTipoCalculo
1752:         loc_oPg1.obj_4c_OptDias.Value    = loc_oBO.this_nTipoDias
1753:         loc_oPg1.txt_4c_ValorJuros.Value = loc_oBO.this_nValorJuros
1754:         loc_oPg1.txt_4c_ValorTotal.Value = loc_oBO.this_nValorTotal
1755:         loc_oPg1.txt_4c_Valorpar.Value   = loc_oBO.this_nValorParcela
1756:         loc_oPg2.txt_4c_Venc1.Value      = loc_oBO.this_dVenc1
1757:         loc_oPg2.txt_4c_Venc2.Value      = loc_oBO.this_dVenc2
1758:         loc_oPg2.txt_4c_Venc3.Value      = loc_oBO.this_dVenc3
1759:         loc_oPg2.txt_4c_Venc4.Value      = loc_oBO.this_dVenc4
1760:         loc_oPg2.txt_4c_Venc5.Value      = loc_oBO.this_dVenc5
1761:         loc_oPg2.txt_4c_Venc6.Value      = loc_oBO.this_dVenc6
1762:         loc_oPg2.txt_4c_Venc7.Value      = loc_oBO.this_dVenc7
1763:         loc_oPg2.txt_4c_Venc8.Value      = loc_oBO.this_dVenc8
1764:         loc_oPg2.txt_4c_Venc9.Value      = loc_oBO.this_dVenc9
1765:         loc_oPg2.txt_4c_Venc10.Value     = loc_oBO.this_dVenc10
1766:     ENDPROC
1767: 
1768:     *===========================================================================
1769:     * BtnEncerrarClick - Fecha o formulario (alias CRUD para CmdEncerrarClick)
1770:     *===========================================================================
1771:     PROCEDURE BtnEncerrarClick()
1772:         THIS.CmdEncerrarClick()
1773:     ENDPROC
1774: 
1775:     *===========================================================================
1776:     * BtnBuscarClick - N/A para calculadora (sem lista de registros)
1777:     * Existe para compatibilidade com o pipeline de migracao
1778:     *===========================================================================
1779:     PROCEDURE BtnBuscarClick()
1780:         RETURN
1781:     ENDPROC
1782: 
1783:     *===========================================================================
1784:     * BtnSalvarClick - Executa o calculo via BO (FormParaBO -> Inserir -> BOParaForm)
1785:     * Equivale a "Salvar" em forms CRUD: valida, processa e exibe resultado
1786:     *===========================================================================
1787:     PROCEDURE BtnSalvarClick()
1788:         LOCAL loc_oPg1, loc_lSucesso
1789: 
1790:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
1791:         loc_lSucesso  = .F.
1792: 
1793:         IF loc_oPg1.txt_4c_ValorBase.Value <= 0
1794:             MsgAviso("Informe o Valor Base para calcular.", "Aten" + CHR(231) + CHR(227) + "o")
1795:             loc_oPg1.txt_4c_ValorBase.SetFocus()
1796:             RETURN
1797:         ENDIF
1798: 
1799:         THIS.FormParaBO()
1800:         loc_lSucesso = THIS.this_oBusinessObject.Inserir()
1801: 
1802:         IF loc_lSucesso
1803:             THIS.BOParaForm()
1804:         ENDIF
1805:     ENDPROC
1806: 
1807:     *===========================================================================
1808:     * BtnCancelarClick - Cancela simulacao atual, limpa campos e volta ao inicio
1809:     * Equivale a "Cancelar" em forms CRUD: descarta alteracoes em andamento
1810:     *===========================================================================
1811:     PROCEDURE BtnCancelarClick()
1812:         THIS.LimparCampos()
1813:         THIS.pgf_4c_Paginas.ActivePage = 1
1814:         THIS.this_cModoAtual = "CALCULO"
1815: 
1816:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_ValorBase", 5)
1817:             THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.SetFocus()
1818:         ENDIF
1819:     ENDPROC
1820: 
1821:     *===========================================================================
1822:     * Destroy - Libera recursos ao fechar o formulario
1823:     *===========================================================================
1824:     PROCEDURE Destroy()
1825:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1826:             THIS.this_oBusinessObject = .NULL.
1827:         ENDIF
1828:         DODEFAULT()
1829:     ENDPROC
1830: 
1831: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCfnBO.prg):
*===============================================================================
* SigPrCfnBO.prg - Business Object para Calculo de Juros (SIGPRCFN)
* Herda de: BusinessBase
* Tipo: OPERACIONAL (sem tabela BD - calculo puro)
*===============================================================================

DEFINE CLASS SigPrCfnBO AS BusinessBase

    *-- Identificacao (sem tabela BD - form de calculo)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Entradas do calculo
    this_nValorBase    = 0
    this_nJurosMes     = 0
    this_nJurosDia     = 0
    this_dDataBase     = {}
    this_dDataFinal    = {}
    this_nDias         = 0
    this_nTipoCalculo  = 1  && 1=Simples, 2=Composto
    this_nTipoDias     = 1  && 1=Corridos, 2=Uteis

    *-- Resultados do calculo
    this_nValorJuros   = 0
    this_nValorTotal   = 0
    this_nValorParcela = 0

    *-- Vencimentos (ate 10 parcelas)
    this_dVenc1  = {}
    this_dVenc2  = {}
    this_dVenc3  = {}
    this_dVenc4  = {}
    this_dVenc5  = {}
    this_dVenc6  = {}
    this_dVenc7  = {}
    this_dVenc8  = {}
    this_dVenc9  = {}
    this_dVenc10 = {}

    *---------------------------------------------------------------------------
    * Init - Inicializa o BO de calculo de juros
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            this.this_cTabela     = ""
            this.this_cCampoChave = ""

            this.LimparPropriedades()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * LimparPropriedades - Reseta todas as propriedades para valores iniciais
    *---------------------------------------------------------------------------
    PROCEDURE LimparPropriedades()
        THIS.this_nValorBase    = 0
        THIS.this_nJurosMes     = 0
        THIS.this_nJurosDia     = 0
        THIS.this_dDataBase     = {}
        THIS.this_dDataFinal    = {}
        THIS.this_nDias         = 0
        THIS.this_nTipoCalculo  = 1
        THIS.this_nTipoDias     = 1
        THIS.this_nValorJuros   = 0
        THIS.this_nValorTotal   = 0
        THIS.this_nValorParcela = 0
        THIS.this_dVenc1        = {}
        THIS.this_dVenc2        = {}
        THIS.this_dVenc3        = {}
        THIS.this_dVenc4        = {}
        THIS.this_dVenc5        = {}
        THIS.this_dVenc6        = {}
        THIS.this_dVenc7        = {}
        THIS.this_dVenc8        = {}
        THIS.this_dVenc9        = {}
        THIS.this_dVenc10       = {}
    ENDPROC


    *---------------------------------------------------------------------------
    * InicializarComParametros - Recebe parametros do chamador e prepara calculo
    * Logica identica ao Init do SIGPRCFN original (pVal, pTip, pJMe, pJDi, pDtB, pDtF)
    *---------------------------------------------------------------------------
    PROCEDURE InicializarComParametros(par_nValorBase, par_nTipoCalculo, ;
                                        par_nJurosMes, par_nJurosDia, ;
                                        par_dDataBase, par_dDataFinal)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            THIS.LimparPropriedades()

            IF VARTYPE(par_nValorBase) = "N" AND par_nValorBase > 0
                THIS.this_nValorBase = par_nValorBase
            ENDIF

            IF VARTYPE(par_nTipoCalculo) = "N" AND INLIST(par_nTipoCalculo, 1, 2)
                THIS.this_nTipoCalculo = par_nTipoCalculo
            ENDIF

            IF VARTYPE(par_nJurosMes) = "N" AND par_nJurosMes > 0
                THIS.this_nJurosMes = par_nJurosMes
                THIS.ConverterJurosMesParaDia()
            ELSE
                IF VARTYPE(par_nJurosDia) = "N" AND par_nJurosDia > 0
                    THIS.this_nJurosDia = par_nJurosDia
                    THIS.ConverterJurosDiaParaMes()
                ENDIF
            ENDIF

            IF VARTYPE(par_dDataBase) = "D"
                THIS.this_dDataBase = par_dDataBase
            ENDIF

            IF VARTYPE(par_dDataFinal) = "D"
                THIS.this_dDataFinal = par_dDataFinal
            ELSE
                IF !EMPTY(THIS.this_dDataBase)
                    THIS.this_dDataFinal = DATE()
                ENDIF
            ENDIF

            IF !EMPTY(THIS.this_dDataBase) AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularJuros - Executa calculo de juros com as propriedades atuais
    * Logica identica ao metodo Calculos() do SIGPRCFN original
    * Retorna: .T. se calculo realizado, .F. se entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE CalcularJuros()
        LOCAL loc_lSucesso, loc_nJuros, loc_nParc, loc_nTotDia, loc_nI, loc_nDia
        LOCAL ARRAY loc_aVenc[10]

        loc_lSucesso = .F.
        loc_nJuros   = 0
        loc_nParc    = 0
        loc_nTotDia  = 0

        TRY
            *-- Se algum campo obrigatorio estiver vazio, zerar resultados
            IF THIS.this_nValorBase = 0 OR ;
               THIS.this_nJurosMes  = 0 OR ;
               THIS.this_nJurosDia  = 0 OR ;
               EMPTY(THIS.this_dDataBase)  OR ;
               EMPTY(THIS.this_dDataFinal) OR ;
               THIS.this_nDias = 0
                THIS.this_nValorJuros   = 0
                THIS.this_nValorTotal   = 0
                THIS.this_nValorParcela = 0
                loc_lSucesso = .F.
            ENDIF

            *-- Calculo base (sem vencimentos)
            IF THIS.this_nTipoCalculo = 1
                *-- Juros Simples: J = PV * (i_mes/100) * (dias/30)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (THIS.this_nJurosMes / 100) * ;
                                  (THIS.this_nDias / 30), 2)
            ELSE
                *-- Juros Compostos: J = PV * ((1 + i_dia/100)^dias - 1)
                loc_nJuros = ROUND(THIS.this_nValorBase * ;
                                  (((1 + THIS.this_nJurosDia / 100) ^ THIS.this_nDias) - 1), 2)
            ENDIF

            *-- Verificar vencimentos: se algum informado, recalcular por parcela
            loc_aVenc[1]  = THIS.this_dVenc1
            loc_aVenc[2]  = THIS.this_dVenc2
            loc_aVenc[3]  = THIS.this_dVenc3
            loc_aVenc[4]  = THIS.this_dVenc4
            loc_aVenc[5]  = THIS.this_dVenc5
            loc_aVenc[6]  = THIS.this_dVenc6
            loc_aVenc[7]  = THIS.this_dVenc7
            loc_aVenc[8]  = THIS.this_dVenc8
            loc_aVenc[9]  = THIS.this_dVenc9
            loc_aVenc[10] = THIS.this_dVenc10

            FOR loc_nI = 1 TO 10
                IF !EMPTY(loc_aVenc[loc_nI])
                    IF loc_nParc = 0
                        *-- Primeira parcela encontrada: zera calculo base e recalcula por vencimento
                        loc_nJuros = 0
                    ENDIF

                    loc_nDia = loc_aVenc[loc_nI] - THIS.this_dDataBase

                    IF THIS.this_nTipoCalculo = 1
                        *-- Juros Simples por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (THIS.this_nJurosMes / 100) * ;
                                                       (loc_nDia / 30), 2)
                    ELSE
                        *-- Juros Compostos por vencimento
                        loc_nJuros = loc_nJuros + ROUND(THIS.this_nValorBase * ;
                                                       (((1 + THIS.this_nJurosDia / 100) ^ loc_nDia) - 1), 2)
                    ENDIF

                    loc_nTotDia = loc_nDia
                    loc_nParc   = loc_nParc + 1
                ENDIF
            ENDFOR

            *-- Se vencimentos preenchidos, atualizar this_nDias com o ultimo vencimento
            IF loc_nTotDia > 0
                THIS.this_nDias = loc_nTotDia
            ENDIF

            THIS.this_nValorJuros   = loc_nJuros
            THIS.this_nValorTotal   = THIS.this_nValorBase + loc_nJuros
            THIS.this_nValorParcela = THIS.this_nValorTotal / IIF(loc_nParc <> 0, loc_nParc, 1)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosMesParaDia - Converte taxa mensal para diaria e atualiza this_nJurosDia
    * Logica identica ao Valid de getJurosMes do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosMesParaDia()
        LOCAL loc_nJurosDia

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_dia = i_mes / 30
            loc_nJurosDia = ROUND(THIS.this_nJurosMes / 30, 9)
        ELSE
            *-- Composto: i_dia = ((1 + i_mes/100)^(1/30) - 1) * 100
            loc_nJurosDia = ROUND((((1 + THIS.this_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
        ENDIF

        THIS.this_nJurosDia = loc_nJurosDia
    ENDPROC

    *---------------------------------------------------------------------------
    * ConverterJurosDiaParaMes - Converte taxa diaria para mensal e atualiza this_nJurosMes
    * Logica identica ao Valid de getJurosDia do SIGPRCFN original
    *---------------------------------------------------------------------------
    PROCEDURE ConverterJurosDiaParaMes()
        LOCAL loc_nJurosMes

        IF THIS.this_nTipoCalculo = 1
            *-- Simples: i_mes = i_dia * 30
            loc_nJurosMes = ROUND(THIS.this_nJurosDia * 30, 2)
        ELSE
            *-- Composto: i_mes = ((1 + i_dia/100)^30 - 1) * 100
            loc_nJurosMes = ROUND((((1 + THIS.this_nJurosDia / 100) ^ 30) - 1) * 100, 2)
        ENDIF

        THIS.this_nJurosMes = loc_nJurosMes
    ENDPROC

    *---------------------------------------------------------------------------
    * CalcularDias - Calcula dias entre data base e data final aplicando TipoDias
    * TipoDias 1=Corridos, 2=Uteis (desconta fins de semana e feriados)
    * Logica identica ao calculo de fChkFeriado do SIGPRCFN original
    * Atualiza this_nDias com o resultado
    *---------------------------------------------------------------------------
    PROCEDURE CalcularDias()
        LOCAL loc_nDias, loc_dAtual

        IF EMPTY(THIS.this_dDataBase) OR EMPTY(THIS.this_dDataFinal)
            THIS.this_nDias = 0
            RETURN
        ENDIF

        IF THIS.this_dDataFinal < THIS.this_dDataBase
            THIS.this_nDias = 0
            RETURN
        ENDIF

        *-- Calculo base: dias corridos
        loc_nDias = THIS.this_dDataFinal - THIS.this_dDataBase

        IF THIS.this_nTipoDias = 2 AND loc_nDias > 0
            *-- Subtrair dias nao uteis (fins de semana e feriados)
            loc_dAtual = THIS.this_dDataBase
            DO WHILE loc_dAtual <= THIS.this_dDataFinal
                IF !THIS.VerificarDiaUtil(loc_dAtual)
                    loc_nDias = loc_nDias - 1
                ENDIF
                loc_dAtual = loc_dAtual + 1
            ENDDO
        ENDIF

        THIS.this_nDias = loc_nDias
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarDiaUtil - Verifica se a data e um dia util
    * par_dData - Data a verificar
    * Retorna: .T. se util, .F. se sabado ou domingo
    * Equivale a fChkFeriado(d,.T.,.T.,.F.) do legado (desconta apenas fins de semana)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDiaUtil(par_dData)
        LOCAL loc_nDow

        loc_nDow = DOW(par_dData)
        IF loc_nDow = 1 OR loc_nDow = 7
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria (N/A - form de calculo sem tabela)
    *---------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do calculo a partir de um cursor
    * Util para chamadas em batch onde parametros vem de outro cursor/tabela
    * Mapeia colunas conhecidas (se existirem) para as propriedades do BO
    * par_cAliasCursor: alias do cursor contendo os parametros
    * Retorna .T. em caso de sucesso, .F. se cursor invalido
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            *-- Mapear cada coluna somente se existir no cursor (permite cursores
            *-- parciais). Uso de TYPE() para checar existencia da coluna.
            IF TYPE(par_cAliasCursor + ".ValorBase") != "U"
                THIS.this_nValorBase = TratarNulo(EVALUATE(par_cAliasCursor + ".ValorBase"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosMes") != "U"
                THIS.this_nJurosMes = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosMes"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".JurosDia") != "U"
                THIS.this_nJurosDia = TratarNulo(EVALUATE(par_cAliasCursor + ".JurosDia"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataBase") != "U"
                THIS.this_dDataBase = TratarNulo(EVALUATE(par_cAliasCursor + ".DataBase"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".DataFinal") != "U"
                THIS.this_dDataFinal = TratarNulo(EVALUATE(par_cAliasCursor + ".DataFinal"), "D")
            ENDIF
            IF TYPE(par_cAliasCursor + ".Dias") != "U"
                THIS.this_nDias = TratarNulo(EVALUATE(par_cAliasCursor + ".Dias"), "N")
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoCalculo") != "U"
                THIS.this_nTipoCalculo = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoCalculo"), "N")
                IF !INLIST(THIS.this_nTipoCalculo, 1, 2)
                    THIS.this_nTipoCalculo = 1
                ENDIF
            ENDIF
            IF TYPE(par_cAliasCursor + ".TipoDias") != "U"
                THIS.this_nTipoDias = TratarNulo(EVALUATE(par_cAliasCursor + ".TipoDias"), "N")
                IF !INLIST(THIS.this_nTipoDias, 1, 2)
                    THIS.this_nTipoDias = 1
                ENDIF
            ENDIF

            *-- Se DataBase e DataFinal preenchidas mas Dias vazio, calcular
            IF THIS.this_nDias = 0 AND !EMPTY(THIS.this_dDataBase) ;
                                  AND !EMPTY(THIS.this_dDataFinal)
                THIS.this_nDias = THIS.this_dDataFinal - THIS.this_dDataBase
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - Executa calculo e retorna resultado
    * Form de calculo puro (sem tabela BD): Inserir corresponde a executar
    * o calculo de juros com os parametros atuais. Nao ha persistencia em
    * tabela propria porque este BO representa uma calculadora, nao entidade
    * de dominio. O resultado fica nas propriedades this_nValorJuros,
    * this_nValorTotal e this_nValorParcela para consulta pelo chamador.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        TRY
            *-- Valida entradas minimas
            IF THIS.this_nValorBase <= 0
                MsgAviso("Valor Base deve ser informado.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataBase)
                MsgAviso("Data Base deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(THIS.this_dDataFinal)
                MsgAviso("Data Final deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nJurosMes <= 0 AND THIS.this_nJurosDia <= 0
                MsgAviso("Taxa de juros deve ser informada.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Garante coerencia entre taxas mes/dia
            IF THIS.this_nJurosMes > 0 AND THIS.this_nJurosDia = 0
                THIS.ConverterJurosMesParaDia()
            ENDIF
            IF THIS.this_nJurosDia > 0 AND THIS.this_nJurosMes = 0
                THIS.ConverterJurosDiaParaMes()
            ENDIF

            *-- Recalcula dias conforme tipo (corridos/uteis)
            THIS.CalcularDias()

            *-- Executa o calculo principal
            loc_lSucesso = THIS.CalcularJuros()

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - Reexecuta calculo com parametros atualizados
    * Form de calculo puro: Atualizar corresponde a recalcular apos alteracao
    * de qualquer parametro (Valor Base, Taxa, Datas, Vencimentos). Delega a
    * Inserir() pois a semantica eh identica para uma calculadora.
    * Retorna .T. se calculo executado, .F. em caso de entradas invalidas
    *---------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE

