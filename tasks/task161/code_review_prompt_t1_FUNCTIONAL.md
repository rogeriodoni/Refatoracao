# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Top original=140 vs migrado 'obj_4c_OptCalculo' Top=60 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optCalculo' (parent: SIGPRCFN): Left original=351 vs migrado 'obj_4c_OptCalculo' Left=0 (diff=351px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optDias' (parent: SIGPRCFN): Top original=158 vs migrado 'obj_4c_OptDias' Top=78 (diff=80px, tolerancia=30px)
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCfn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1811 linhas total):

*-- Linhas 2 a 187:
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
110:                 *-- Container overlay do botao Encerrar (sobre o cabecalho)
111:                 THIS.ConfigurarBotoes()
112: 
113:                 *-- Container de botoes de acao (dentro das paginas)
114:                 THIS.ConfigurarBotoesAcao()
115: 
116:                 *-- Conteudo das paginas (Page1=Calculo, Page2=Vencimentos)
117:                 *-- Dispatcher unico compativel com nomenclatura CRUD do pipeline
118:                 THIS.ConfigurarPaginaDados()
119: 
120:                 *-- Preencher campos com parametros recebidos do chamador
121:                 THIS.PreencherParametrosIniciais()
122: 
123:                 *-- Torna todos os controles adicionados visiveis
124:                 THIS.TornarControlesVisiveis(THIS)
125: 
126:                 *-- Ativa primeira pagina do PageFrame
127:                 THIS.pgf_4c_Paginas.Visible   = .T.
128:                 THIS.pgf_4c_Paginas.ActivePage = 1
129: 
130:                 loc_lSucesso = .T.
131:             ELSE
132:                 MsgErro("Erro ao criar SigPrCfnBO.", ;
133:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
134:             ENDIF
135: 
136:         CATCH TO loc_oErro
137:             MsgErro(loc_oErro.Message, "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
138:         ENDTRY
139: 
140:         RETURN loc_lSucesso
141:     ENDPROC
142: 
143:     *===========================================================================
144:     * ConfigurarCabecalho - Cria cnt_4c_Cabecalho (cabecalho cinza com titulo)
145:     * Equivalente ao cntSombra do form original
146:     *===========================================================================
147:     PROTECTED PROCEDURE ConfigurarCabecalho()
148:         LOCAL loc_cCaption, loc_nFormWidth
149: 
150:         loc_cCaption   = "C" + CHR(225) + "lculo de Juros"
151:         loc_nFormWidth = THIS.Width
152: 
153:         *-- Container cabecalho escuro (cntSombra)
154:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
155:         WITH THIS.cnt_4c_Cabecalho
156:             .Top         = 0
157:             .Left        = 0
158:             .Width       = loc_nFormWidth
159:             .Height      = 80
160:             .BackStyle   = 1
161:             .BackColor   = RGB(100, 100, 100)
162:             .BorderWidth = 0
163:             .Visible     = .T.
164: 
165:             *-- Label sombra (preto, deslocado 1px para efeito 3D)
166:             .AddObject("lbl_4c_Sombra", "Label")
167:             WITH .lbl_4c_Sombra
168:                 .FontBold  = .T.
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 18
171:                 .WordWrap  = .T.
172:                 .Alignment = 0
173:                 .BackStyle = 0
174:                 .AutoSize  = .F.
175:                 .Width     = loc_nFormWidth
176:                 .Height    = 40
177:                 .Top       = 18
178:                 .Left      = 10
179:                 .ForeColor = RGB(0, 0, 0)
180:                 .Caption   = loc_cCaption
181:                 .Visible   = .T.
182:             ENDWITH
183: 
184:             *-- Label titulo (branco - texto visivel)
185:             .AddObject("lbl_4c_Titulo", "Label")
186:             WITH .lbl_4c_Titulo
187:                 .FontBold  = .T.

*-- Linhas 208 a 426:
208:     * Page2 = Vencimentos (grid de parcelas)
209:     * Nesta fase (3) o PageFrame eh criado vazio - conteudo entra nas fases 4-6
210:     *===========================================================================
211:     PROTECTED PROCEDURE ConfigurarPageFrame()
212:         LOCAL loc_nTopPgf, loc_nHeightPgf, loc_nWidthPgf
213: 
214:         *-- PageFrame ocupa area abaixo do cabecalho (Top=80) ate rodape
215:         loc_nTopPgf    = 80
216:         loc_nHeightPgf = THIS.Height - loc_nTopPgf
217:         loc_nWidthPgf  = THIS.Width
218: 
219:         *-- Container do PageFrame principal
220:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
221:         WITH THIS.pgf_4c_Paginas
222:             .Top        = loc_nTopPgf
223:             .Left       = 0
224:             .Width      = loc_nWidthPgf
225:             .Height     = loc_nHeightPgf
226:             .PageCount  = 2
227:             .Tabs       = .F.
228:             .BorderWidth = 0
229:             .BackStyle   = 0
230:             .Themes     = .F.
231:             .Visible    = .T.
232: 
233:             *-- Page1: Calculo principal (campos serao adicionados nas Fases 4-6)
234:             WITH .Page1
235:                 .Caption = "C" + CHR(225) + "lculo"
236:             ENDWITH
237: 
238:             *-- Page2: Vencimentos (parcelas serao adicionadas nas Fases 5-6)
239:             WITH .Page2
240:                 .Caption = "Vencimentos"
241:                 .BackColor = RGB(240, 240, 240)
242:             ENDWITH
243: 
244:             .ActivePage = 1
245:         ENDWITH
246:     ENDPROC
247: 
248:     *===========================================================================
249:     * ConfigurarBotoes - Cria container cnt_4c_Botoes overlay com botao Encerrar
250:     * Container transparente sobre o cabecalho no canto superior direito
251:     * Equivalente ao btnOK do form original
252:     *===========================================================================
253:     PROTECTED PROCEDURE ConfigurarBotoes()
254:         LOCAL loc_nFormWidth
255:         loc_nFormWidth = THIS.Width
256: 
257:         *-- Container do botao Encerrar (transparente sobre cabecalho)
258:         THIS.AddObject("cnt_4c_Botoes", "Container")
259:         WITH THIS.cnt_4c_Botoes
260:             .Top         = 0
261:             .Left        = loc_nFormWidth - 90
262:             .Width       = 90
263:             .Height      = 85
264:             .BackStyle   = 0
265:             .BorderWidth = 0
266:             .Visible     = .T.
267: 
268:             .AddObject("cmd_4c_Encerrar", "CommandButton")
269:             WITH .cmd_4c_Encerrar
270:                 .Top             = 5
271:                 .Left            =  542
272:                 .Width           = 75
273:                 .Height          = 75
274:                 .Caption         = "Encerrar"
275:                 .FontName        = "Comic Sans MS"
276:                 .FontBold        = .T.
277:                 .FontItalic      = .T.
278:                 .FontSize        = 8
279:                 .ForeColor       = RGB(90, 90, 90)
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .SpecialEffect   = 0
282:                 .PicturePosition = 13
283:                 .MousePointer    = 15
284:                 .WordWrap        = .T.
285:                 .AutoSize        = .F.
286:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
287:                 .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
288:                 .Cancel          = .T.
289:                 .Visible         = .T.
290:             ENDWITH
291:         ENDWITH
292: 
293:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "CmdEncerrarClick")
294:     ENDPROC
295: 
296:     *===========================================================================
297:     * ConfigurarBotoesAcao - Cria container cnt_4c_BotoesAcao (botoes de acao)
298:     * Container reservado para botoes de acao especificos (adicionados nas Fases 4-7)
299:     * Nesta fase o container eh criado vazio conforme especificacao Fase 3
300:     *===========================================================================
301:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
302:         LOCAL loc_nFormWidth
303:         loc_nFormWidth = THIS.Width
304: 
305:         *-- Container de botoes de acao (posicionado no rodape das paginas)
306:         THIS.AddObject("cnt_4c_BotoesAcao", "Container")
307:         WITH THIS.cnt_4c_BotoesAcao
308:             .Top         = THIS.Height - 40
309:             .Left        = 0
310:             .Width       = loc_nFormWidth
311:             .Height      = 40
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.
315: 
316:             .AddObject("cmd_4c_Limpar", "CommandButton")
317:             WITH .cmd_4c_Limpar
318:                 .Top          = 5
319:                 .Left         = 10
320:                 .Width        = 90
321:                 .Height       = 28
322:                 .Caption      = "Limpar"
323:                 .FontName     = "Tahoma"
324:                 .FontBold     = .T.
325:                 .FontSize     = 8
326:                 .ForeColor    = RGB(90, 90, 90)
327:                 .BackColor    = RGB(240, 240, 240)
328:                 .MousePointer = 15
329:             ENDWITH
330:         ENDWITH
331: 
332:         BINDEVENT(THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar, "Click", THIS, "CmdLimparClick")
333:     ENDPROC
334: 
335:     *===========================================================================
336:     * CmdEncerrarClick - Fecha o formulario (ESC ou clique no botao Encerrar)
337:     *===========================================================================
338:     PROCEDURE CmdEncerrarClick()
339:         THIS.Release()
340:     ENDPROC
341: 
342:     *===========================================================================
343:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
344:     * Necessario apos AddObject (que cria controles com Visible=.F. por padrao)
345:     * Recursa em Pages (PageFrame) e sub-containers
346:     *===========================================================================
347:     PROCEDURE TornarControlesVisiveis(par_oContainer)
348:         LOCAL loc_nI, loc_oObjeto, loc_nP
349: 
350:         FOR loc_nI = 1 TO par_oContainer.ControlCount
351:             loc_oObjeto = par_oContainer.Controls(loc_nI)
352: 
353:             IF VARTYPE(loc_oObjeto) = "O"
354:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
355:                     loc_oObjeto.Visible = .T.
356:                 ENDIF
357: 
358:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
359:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
360:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
361:                     ENDFOR
362:                 ENDIF
363: 
364:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
365:                     THIS.TornarControlesVisiveis(loc_oObjeto)
366:                 ENDIF
367:             ENDIF
368:         ENDFOR
369:     ENDPROC
370: 
371:     *===========================================================================
372:     * ConfigurarPaginaDados - Dispatcher que popula ambas as paginas do form
373:     * Form OPERACIONAL: delega para ConfigurarPaginaCalculo (Page1 - campos de
374:     * calculo) e ConfigurarPaginaVencimentos (Page2 - datas de vencimento).
375:     * Nomenclatura mantida por compatibilidade com o pipeline de migracao.
376:     *===========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaDados()
378:         THIS.ConfigurarPaginaCalculo()
379:         THIS.ConfigurarPaginaVencimentos()
380:     ENDPROC
381: 
382:     *===========================================================================
383:     * ConfigurarPaginaCalculo - Popula Page1 com todos os campos de calculo
384:     * Equivale ao ConfigurarPaginaLista em forms CRUD - eh o conteudo principal
385:     *===========================================================================
386:     PROTECTED PROCEDURE ConfigurarPaginaCalculo()
387:         LOCAL loc_oPagina
388: 
389:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
390: 
391:         *-- Label "Valor Base :"
392:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
393:         WITH loc_oPagina.lbl_4c_Label1
394:             .Top       = 11
395:             .Left      = 36
396:             .AutoSize  = .T.
397:             .BackStyle = 0
398:             .Caption   = "Valor Base :"
399:             .FontName  = "Tahoma"
400:             .FontSize  = 8
401:             .ForeColor = RGB(90, 90, 90)
402:         ENDWITH
403: 
404:         *-- Campo Valor Base
405:         loc_oPagina.AddObject("txt_4c_ValorBase", "TextBox")
406:         WITH loc_oPagina.txt_4c_ValorBase
407:             .Top       = 7
408:             .Left      = 97
409:             .Width     = 115
410:             .Height    = 23
411:             .Value     = 0
412:             .Format    = "NR"
413:             .InputMask = "################.##"
414:             .Alignment = 1
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .ForeColor = RGB(90, 90, 90)
418:         ENDWITH
419: 
420:         *-- Label "Juros/Mes :"
421:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
422:         WITH loc_oPagina.lbl_4c_Label3
423:             .Top       = 39
424:             .Left      = 37
425:             .AutoSize  = .T.
426:             .BackStyle = 0

*-- Linhas 561 a 605:
561:             .ForeColor = RGB(90, 90, 90)
562:         ENDWITH
563: 
564:         *-- OptionGroup tipo de calculo (Simples/Composto)
565:         loc_oPagina.AddObject("obj_4c_OptCalculo", "OptionGroup")
566:         WITH loc_oPagina.obj_4c_OptCalculo
567:             .Top         = 60
568:             .Left        = 351
569:             .Width       = 155
570:             .Height      = 21
571:             .ButtonCount = 2
572:             .BackStyle   = 0
573:             .BorderStyle = 0
574:             .Value       = THIS.this_nParTipoCalculo
575:             .Enabled     = .F.
576: 
577:             WITH .Buttons(1)
578:                 .Caption   = "Simples"
579:                 .BackStyle = 0
580:                 .ForeColor = RGB(90, 90, 90)
581:                 .Width     = 60
582:                 .Left      = 0
583:             ENDWITH
584: 
585:             WITH .Buttons(2)
586:                 .Caption   = "Composto"
587:                 .BackStyle = 0
588:                 .FontName  = "Tahoma"
589:                 .FontSize  = 8
590:                 .ForeColor = RGB(90, 90, 90)
591:                 .Width     = 75
592:                 .Left      = 63
593:             ENDWITH
594:         ENDWITH
595: 
596:         *-- Label "Juros por Dia :"
597:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
598:         WITH loc_oPagina.lbl_4c_Label5
599:             .Top       = 68
600:             .Left      = 23
601:             .AutoSize  = .T.
602:             .BackStyle = 0
603:             .Caption   = "Juros por Dia :"
604:             .FontName  = "Tahoma"
605:             .FontSize  = 8

*-- Linhas 636 a 680:
636:             .ForeColor = RGB(90, 90, 90)
637:         ENDWITH
638: 
639:         *-- OptionGroup tipo de contagem de dias (Corridos/Nao Corridos)
640:         loc_oPagina.AddObject("obj_4c_OptDias", "OptionGroup")
641:         WITH loc_oPagina.obj_4c_OptDias
642:             .Top         = 78
643:             .Left        = 351
644:             .Width       = 175
645:             .Height      = 21
646:             .ButtonCount = 2
647:             .BackStyle   = 0
648:             .BorderStyle = 0
649:             .Value       = 1
650:             .Enabled     = .F.
651: 
652:             WITH .Buttons(1)
653:                 .Caption   = "Corridos"
654:                 .BackStyle = 0
655:                 .ForeColor = RGB(90, 90, 90)
656:                 .Width     = 65
657:                 .Left      = 0
658:             ENDWITH
659: 
660:             WITH .Buttons(2)
661:                 .Caption   = "N" + CHR(227) + "o Corridos"
662:                 .BackStyle = 0
663:                 .FontName  = "Tahoma"
664:                 .FontSize  = 8
665:                 .ForeColor = RGB(90, 90, 90)
666:                 .Width     = 100
667:                 .Left      = 68
668:             ENDWITH
669:         ENDWITH
670: 
671:         *-- Separador visual (equivalente ao Commandgroup1 Height=1 do original)
672:         loc_oPagina.AddObject("lbl_4c_Separador", "Label")
673:         WITH loc_oPagina.lbl_4c_Separador
674:             .Top       = 100
675:             .Left      = 6
676:             .Width     = 586
677:             .Height    = 1
678:             .BackStyle = 1
679:             .BackColor = RGB(180, 180, 180)
680:             .Caption   = ""

*-- Linhas 787 a 864:
787:             .MousePointer = 15
788:         ENDWITH
789: 
790:         BINDEVENT(loc_oPagina.cmd_4c_Vencimentos, "Click",           THIS, "CmdVencimentosClick")
791:         BINDEVENT(loc_oPagina.txt_4c_ValorBase,   "KeyPress",        THIS, "TxtValorBaseKeyPress")
792:         BINDEVENT(loc_oPagina.txt_4c_JurosMes,    "KeyPress",        THIS, "TxtJurosMesKeyPress")
793:         BINDEVENT(loc_oPagina.txt_4c_JurosDia,    "KeyPress",        THIS, "TxtJurosDiaKeyPress")
794:         BINDEVENT(loc_oPagina.txt_4c_DataBase,    "KeyPress",        THIS, "TxtDataBaseKeyPress")
795:         BINDEVENT(loc_oPagina.txt_4c_DataFinal,   "KeyPress",        THIS, "TxtDataFinalKeyPress")
796:         BINDEVENT(loc_oPagina.txt_4c_Dias,        "KeyPress",        THIS, "TxtDiasKeyPress")
797:         BINDEVENT(loc_oPagina.obj_4c_OptCalculo,  "InteractiveChange", THIS, "OptCalculoInteractiveChange")
798:         BINDEVENT(loc_oPagina.obj_4c_OptDias,     "InteractiveChange", THIS, "OptDiasInteractiveChange")
799:     ENDPROC
800: 
801:     *===========================================================================
802:     * AlternarPagina - Navega entre Page1 (Calculo) e Page2 (Vencimentos)
803:     * par_nPagina: 1 ou 2; se omitido, alterna entre a pagina atual
804:     *===========================================================================
805:     PROCEDURE AlternarPagina(par_nPagina)
806:         IF VARTYPE(par_nPagina) = "N" AND INLIST(par_nPagina, 1, 2)
807:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
808:         ELSE
809:             THIS.pgf_4c_Paginas.ActivePage = IIF(THIS.pgf_4c_Paginas.ActivePage = 1, 2, 1)
810:         ENDIF
811:     ENDPROC
812: 
813:     *===========================================================================
814:     * CmdVencimentosClick - Navega para Page2 (Vencimentos)
815:     *===========================================================================
816:     PROCEDURE CmdVencimentosClick()
817:         THIS.AlternarPagina(2)
818:     ENDPROC
819: 
820:     *===========================================================================
821:     * PreencherParametrosIniciais - Preenche campos com parametros do chamador
822:     * Chamado apos ConfigurarPaginaCalculo() para inicializar valores recebidos
823:     *===========================================================================
824:     PROTECTED PROCEDURE PreencherParametrosIniciais()
825:         LOCAL loc_oPagina, loc_lHabilitar
826: 
827:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
828:         loc_lHabilitar = .F.
829: 
830:         IF THIS.this_nParValorBase > 0
831:             loc_oPagina.txt_4c_ValorBase.Value = THIS.this_nParValorBase
832:             loc_lHabilitar = .T.
833:         ENDIF
834: 
835:         THIS.HabilitarCamposEntrada(loc_lHabilitar)
836: 
837:         IF loc_lHabilitar
838:             loc_oPagina.obj_4c_OptCalculo.Value = THIS.this_nParTipoCalculo
839: 
840:             IF THIS.this_nParJurosMes > 0
841:                 loc_oPagina.txt_4c_JurosMes.Value = THIS.this_nParJurosMes
842:                 IF THIS.this_nParTipoCalculo = 1
843:                     loc_oPagina.txt_4c_JurosDia.Value = ROUND(THIS.this_nParJurosMes / 30, 9)
844:                 ELSE
845:                     loc_oPagina.txt_4c_JurosDia.Value = ROUND((((1 + THIS.this_nParJurosMes/100) ^ (1/30)) - 1) * 100, 9)
846:                 ENDIF
847:             ENDIF
848: 
849:             IF THIS.this_nParJurosDia > 0 AND THIS.this_nParJurosMes = 0
850:                 loc_oPagina.txt_4c_JurosDia.Value = THIS.this_nParJurosDia
851:                 IF THIS.this_nParTipoCalculo = 1
852:                     loc_oPagina.txt_4c_JurosMes.Value = ROUND(THIS.this_nParJurosDia * 30, 2)
853:                 ELSE
854:                     loc_oPagina.txt_4c_JurosMes.Value = ROUND((((1 + THIS.this_nParJurosDia/100) ^ 30) - 1) * 100, 2)
855:                 ENDIF
856:             ENDIF
857: 
858:             IF VARTYPE(THIS.this_dParDataBase) = "D" AND !EMPTY(THIS.this_dParDataBase)
859:                 loc_oPagina.txt_4c_DataBase.Value = THIS.this_dParDataBase
860:             ENDIF
861: 
862:             IF VARTYPE(THIS.this_dParDataFinal) = "D" AND !EMPTY(THIS.this_dParDataFinal)
863:                 loc_oPagina.txt_4c_DataFinal.Value = THIS.this_dParDataFinal
864:                 IF !EMPTY(THIS.this_dParDataBase)

*-- Linhas 874 a 939:
874:     * HabilitarCamposEntrada - Habilita ou desabilita campos vinculados
875:     * Chamado quando ValorBase eh preenchido (habilita) ou zerado (desabilita)
876:     *===========================================================================
877:     PROTECTED PROCEDURE HabilitarCamposEntrada(par_lHabilitar)
878:         LOCAL loc_oPagina
879: 
880:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
881: 
882:         WITH loc_oPagina
883:             .obj_4c_OptCalculo.Enabled = par_lHabilitar
884:             .txt_4c_JurosMes.Enabled   = par_lHabilitar
885:             .txt_4c_JurosDia.Enabled   = par_lHabilitar
886:             .txt_4c_DataBase.Enabled   = par_lHabilitar
887:             .txt_4c_DataFinal.Enabled  = par_lHabilitar
888:             .txt_4c_Dias.Enabled       = par_lHabilitar
889:             .obj_4c_OptDias.Enabled    = par_lHabilitar
890:         ENDWITH
891:     ENDPROC
892: 
893:     *===========================================================================
894:     * Calculos - Motor de calculo de juros (logica completa com vencimentos)
895:     * Equivale ao PROCEDURE Calculos() do form SIGPRCFN original
896:     * Chamado sempre que qualquer campo de entrada eh alterado
897:     * Quando ha datas de vencimento em Page2, recalcula juros por parcela
898:     *===========================================================================
899:     PROCEDURE Calculos()
900:         LOCAL loc_oPg1, loc_oPg2, loc_nValorBase, loc_nJurosMes, loc_nJurosDia
901:         LOCAL loc_nDias, loc_nTipoCalculo, loc_nJuros, loc_nTotal
902:         LOCAL loc_nParc, loc_nTotDia, loc_nI, loc_cNomeCampo, loc_dVenc, loc_nDiaVenc
903: 
904:         loc_oPg1         = THIS.pgf_4c_Paginas.Page1
905:         loc_oPg2         = THIS.pgf_4c_Paginas.Page2
906:         loc_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
907:         loc_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
908:         loc_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
909:         loc_nDias        = loc_oPg1.txt_4c_Dias.Value
910:         loc_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
911:         loc_nJuros       = 0
912:         loc_nParc        = 0
913:         loc_nTotDia      = 0
914: 
915:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0 OR ;
916:            (EMPTY(loc_nJurosMes) AND EMPTY(loc_nJurosDia)) OR ;
917:            EMPTY(loc_nDias) OR loc_nDias = 0
918: 
919:             loc_oPg1.txt_4c_ValorJuros.Value = 0
920:             loc_oPg1.txt_4c_ValorTotal.Value = 0
921:             loc_oPg1.txt_4c_Valorpar.Value   = 0
922:             RETURN
923:         ENDIF
924: 
925:         IF loc_nTipoCalculo = 1
926:             *-- Juros Simples: J = PV * (i_mes/100) * (n/30)
927:             loc_nJuros = ROUND(loc_nValorBase * (loc_nJurosMes / 100) * (loc_nDias / 30), 2)
928:         ELSE
929:             *-- Juros Compostos: J = PV * ((1 + i_dia/100)^n - 1)
930:             loc_nJuros = ROUND(loc_nValorBase * (((1 + loc_nJurosDia / 100) ^ loc_nDias) - 1), 2)
931:         ENDIF
932: 
933:         *-- Loop vencimentos: recalcula por parcela quando houver datas preenchidas em Page2
934:         FOR loc_nI = 1 TO 10
935:             loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
936:             IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
937:                 loc_dVenc = EVALUATE("loc_oPg2." + loc_cNomeCampo + ".Value")
938:                 IF !EMPTY(loc_dVenc)
939:                     IF loc_nParc = 0

*-- Linhas 966 a 1259:
966:     * CalcularParcela - Calcula valor da parcela com base nos vencimentos de Page2
967:     * Se Page2 ainda nao tem vencimentos, divide por 10 (padrao 10 parcelas)
968:     *===========================================================================
969:     PROTECTED PROCEDURE CalcularParcela(par_nTotal)
970:         LOCAL loc_nParcelas, loc_nI, loc_cNomeCampo, loc_oPg2, loc_oField
971: 
972:         loc_nParcelas = 0
973: 
974:         IF THIS.pgf_4c_Paginas.PageCount >= 2
975:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
976:             FOR loc_nI = 1 TO 10
977:                 loc_cNomeCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
978:                 IF PEMSTATUS(loc_oPg2, loc_cNomeCampo, 5)
979:                     loc_oField = EVALUATE("loc_oPg2." + loc_cNomeCampo)
980:                     IF !EMPTY(loc_oField.Value)
981:                         loc_nParcelas = loc_nParcelas + 1
982:                     ENDIF
983:                 ENDIF
984:             ENDFOR
985:         ENDIF
986: 
987:         IF loc_nParcelas = 0
988:             RETURN ROUND(par_nTotal / 10, 2)
989:         ENDIF
990: 
991:         RETURN ROUND(par_nTotal / loc_nParcelas, 2)
992:     ENDPROC
993: 
994:     *===========================================================================
995:     * TxtValorBaseKeyPress - Valid para campo Valor Base
996:     * Ao confirmar (ENTER/TAB), valida e habilita/desabilita demais campos
997:     *===========================================================================
998:     PROCEDURE TxtValorBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
999:         LOCAL loc_oPagina, loc_nValor, loc_lHabilitar
1000: 
1001:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1002:             RETURN
1003:         ENDIF
1004: 
1005:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1006:         loc_nValor     = loc_oPagina.txt_4c_ValorBase.Value
1007:         loc_lHabilitar = .F.
1008: 
1009:         IF loc_nValor < 0
1010:             MsgAviso("O Valor Base Precisa Ser Positivo!", "Aten" + CHR(231) + CHR(227) + "o")
1011:             loc_oPagina.txt_4c_ValorBase.SetFocus()
1012:             RETURN
1013:         ENDIF
1014: 
1015:         loc_lHabilitar = (loc_nValor > 0)
1016:         THIS.HabilitarCamposEntrada(loc_lHabilitar)
1017:         THIS.Calculos()
1018:     ENDPROC
1019: 
1020:     *===========================================================================
1021:     * TxtJurosMesKeyPress - Valid para campo Juros/Mes
1022:     * Calcula JurosDia equivalente e recalcula juros
1023:     *===========================================================================
1024:     PROCEDURE TxtJurosMesKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1025:         LOCAL loc_oPagina, loc_nJurosMes, loc_nJurosDia, loc_nTipo
1026: 
1027:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1028:             RETURN
1029:         ENDIF
1030: 
1031:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1032:         loc_nJurosMes = loc_oPagina.txt_4c_JurosMes.Value
1033:         loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value
1034: 
1035:         IF loc_nTipo = 1
1036:             loc_nJurosDia = ROUND(loc_nJurosMes / 30, 9)
1037:         ELSE
1038:             loc_nJurosDia = ROUND((((1 + loc_nJurosMes / 100) ^ (1/30)) - 1) * 100, 9)
1039:         ENDIF
1040: 
1041:         loc_oPagina.txt_4c_JurosDia.Value = loc_nJurosDia
1042:         THIS.Calculos()
1043:     ENDPROC
1044: 
1045:     *===========================================================================
1046:     * TxtJurosDiaKeyPress - Valid para campo Juros por Dia
1047:     * Calcula JurosMes equivalente e recalcula juros
1048:     *===========================================================================
1049:     PROCEDURE TxtJurosDiaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1050:         LOCAL loc_oPagina, loc_nJurosDia, loc_nJurosMes, loc_nTipo
1051: 
1052:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1053:             RETURN
1054:         ENDIF
1055: 
1056:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1057:         loc_nJurosDia = loc_oPagina.txt_4c_JurosDia.Value
1058:         loc_nTipo     = loc_oPagina.obj_4c_OptCalculo.Value
1059: 
1060:         IF loc_nTipo = 1
1061:             loc_nJurosMes = ROUND(loc_nJurosDia * 30, 2)
1062:         ELSE
1063:             loc_nJurosMes = ROUND((((1 + loc_nJurosDia / 100) ^ 30) - 1) * 100, 2)
1064:         ENDIF
1065: 
1066:         loc_oPagina.txt_4c_JurosMes.Value = loc_nJurosMes
1067:         THIS.Calculos()
1068:     ENDPROC
1069: 
1070:     *===========================================================================
1071:     * TxtDataBaseKeyPress - Valid para campo Data Base
1072:     * Valida ordenacao das datas, recalcula dias e chama Calculos()
1073:     *===========================================================================
1074:     PROCEDURE TxtDataBaseKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1075:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1076: 
1077:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1078:             RETURN
1079:         ENDIF
1080: 
1081:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1082:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1083:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1084: 
1085:         IF !EMPTY(loc_dDataFinal) AND !EMPTY(loc_dDataBase)
1086:             IF loc_dDataBase > loc_dDataFinal
1087:                 MsgAviso("A Data Base N" + CHR(227) + "o Pode Ser Maior Que a Data Final!", "Aten" + CHR(231) + CHR(227) + "o")
1088:                 loc_oPagina.txt_4c_DataBase.SetFocus()
1089:                 RETURN
1090:             ENDIF
1091:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1092:         ENDIF
1093: 
1094:         THIS.Calculos()
1095:     ENDPROC
1096: 
1097:     *===========================================================================
1098:     * TxtDataFinalKeyPress - Valid para campo Data Final
1099:     * Valida ordenacao das datas, recalcula dias (uteis ou corridos) e calcula
1100:     *===========================================================================
1101:     PROCEDURE TxtDataFinalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1102:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1103: 
1104:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1105:             RETURN
1106:         ENDIF
1107: 
1108:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1109:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1110:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1111: 
1112:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1113:             IF loc_dDataFinal < loc_dDataBase
1114:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", "Aten" + CHR(231) + CHR(227) + "o")
1115:                 loc_oPagina.txt_4c_DataFinal.SetFocus()
1116:                 RETURN
1117:             ENDIF
1118:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1119:         ENDIF
1120: 
1121:         THIS.Calculos()
1122:     ENDPROC
1123: 
1124:     *===========================================================================
1125:     * TxtDiasKeyPress - Valid para campo Dias
1126:     * Em modo corridos: ajusta DataFinal ou DataBase a partir dos dias informados
1127:     * Em modo uteis: apenas recalcula (datas definem os dias uteis)
1128:     *===========================================================================
1129:     PROCEDURE TxtDiasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1130:         LOCAL loc_oPagina, loc_nDias, loc_dDataBase, loc_dDataFinal, loc_nTipoDias
1131: 
1132:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1133:             RETURN
1134:         ENDIF
1135: 
1136:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1137:         loc_nDias      = loc_oPagina.txt_4c_Dias.Value
1138:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1139:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1140:         loc_nTipoDias  = loc_oPagina.obj_4c_OptDias.Value
1141: 
1142:         IF loc_nTipoDias = 1
1143:             IF !EMPTY(loc_dDataBase)
1144:                 loc_oPagina.txt_4c_DataFinal.Value = loc_dDataBase + loc_nDias
1145:             ELSE
1146:                 IF !EMPTY(loc_dDataFinal)
1147:                     loc_oPagina.txt_4c_DataBase.Value = loc_dDataFinal - loc_nDias
1148:                 ENDIF
1149:             ENDIF
1150:         ELSE
1151:             IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1152:                 loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1153:             ENDIF
1154:         ENDIF
1155: 
1156:         THIS.Calculos()
1157:     ENDPROC
1158: 
1159:     *===========================================================================
1160:     * OptCalculoInteractiveChange - Disparado ao mudar tipo de calculo
1161:     *===========================================================================
1162:     PROCEDURE OptCalculoInteractiveChange()
1163:         THIS.Calculos()
1164:     ENDPROC
1165: 
1166:     *===========================================================================
1167:     * OptDiasInteractiveChange - Disparado ao mudar tipo de contagem de dias
1168:     * Recalcula dias uteis se datas estiverem preenchidas
1169:     *===========================================================================
1170:     PROCEDURE OptDiasInteractiveChange()
1171:         LOCAL loc_oPagina, loc_dDataBase, loc_dDataFinal
1172: 
1173:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
1174:         loc_dDataBase  = loc_oPagina.txt_4c_DataBase.Value
1175:         loc_dDataFinal = loc_oPagina.txt_4c_DataFinal.Value
1176: 
1177:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dDataFinal)
1178:             loc_oPagina.txt_4c_Dias.Value = THIS.CalcularDiasUteis(loc_dDataBase, loc_dDataFinal, loc_oPagina)
1179:         ENDIF
1180: 
1181:         THIS.Calculos()
1182:     ENDPROC
1183: 
1184:     *===========================================================================
1185:     * CalcularDiasUteis - Calcula dias entre duas datas conforme tipo selecionado
1186:     * optDias=1 (Corridos): retorna DataFim - DataInicio (dias corridos)
1187:     * optDias=2 (Nao Corridos): desconta finais de semana (equivale a fChkFeriado)
1188:     *===========================================================================
1189:     PROTECTED PROCEDURE CalcularDiasUteis(par_dDataInicio, par_dDataFim, par_oPagina)
1190:         LOCAL loc_nTipoDias, loc_nDias, loc_dDataAtual
1191: 
1192:         IF VARTYPE(par_oPagina) = "O"
1193:             loc_nTipoDias = par_oPagina.obj_4c_OptDias.Value
1194:         ELSE
1195:             loc_nTipoDias = 1
1196:         ENDIF
1197: 
1198:         loc_nDias = par_dDataFim - par_dDataInicio
1199: 
1200:         IF loc_nDias > 0 AND loc_nTipoDias = 2
1201:             *-- Descontar sabados (DOW=7) e domingos (DOW=1) - equivale a fChkFeriado(d,.T.,.T.,.F.)
1202:             loc_dDataAtual = par_dDataInicio
1203:             DO WHILE loc_dDataAtual <= par_dDataFim
1204:                 IF DOW(loc_dDataAtual) = 1 OR DOW(loc_dDataAtual) = 7
1205:                     loc_nDias = loc_nDias - 1
1206:                 ENDIF
1207:                 loc_dDataAtual = loc_dDataAtual + 1
1208:             ENDDO
1209:         ENDIF
1210: 
1211:         RETURN loc_nDias
1212:     ENDPROC
1213: 
1214:     *===========================================================================
1215:     * ConfigurarPaginaVencimentos - Popula Page2 com campos de datas de vencimento
1216:     * Layout: 5 colunas x 2 linhas (venc1,3,5,7,9 na linha 1; venc2,4,6,8,10 na linha 2)
1217:     * 10 campos de data equivalentes a getvenc1..getvenc10 do original
1218:     *===========================================================================
1219:     PROTECTED PROCEDURE ConfigurarPaginaVencimentos()
1220:         LOCAL loc_oPagina
1221: 
1222:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1223: 
1224:         *-- Botao Voltar (navega de volta para Page1 - Calculo)
1225:         loc_oPagina.AddObject("cmd_4c_Voltar", "CommandButton")
1226:         WITH loc_oPagina.cmd_4c_Voltar
1227:             .Top          = 5
1228:             .Left         = 5
1229:             .Width        = 110
1230:             .Height       = 23
1231:             .Caption      = "< C" + CHR(225) + "lculo"
1232:             .FontName     = "Tahoma"
1233:             .FontBold     = .T.
1234:             .FontSize     = 8
1235:             .ForeColor    = RGB(90, 90, 90)
1236:             .BackColor    = RGB(240, 240, 240)
1237:             .Themes       = .T.
1238:             .MousePointer = 15
1239:         ENDWITH
1240: 
1241:         *-- Label "Vencimentos :"
1242:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1243:         WITH loc_oPagina.lbl_4c_Label11
1244:             .Top       = 75
1245:             .Left      = 26
1246:             .AutoSize  = .T.
1247:             .BackStyle = 0
1248:             .Caption   = "Vencimentos :"
1249:             .FontName  = "Tahoma"
1250:             .FontSize  = 8
1251:             .ForeColor = RGB(90, 90, 90)
1252:         ENDWITH
1253: 
1254:         *-- Coluna 1: venc1 (linha 1) + venc2 (linha 2)
1255:         loc_oPagina.AddObject("txt_4c_Venc1", "TextBox")
1256:         WITH loc_oPagina.txt_4c_Venc1
1257:             .Top       = 71
1258:             .Left      = 97
1259:             .Width     = 80

*-- Linhas 1396 a 1811:
1396:             .ForeColor = RGB(90, 90, 90)
1397:         ENDWITH
1398: 
1399:         BINDEVENT(loc_oPagina.cmd_4c_Voltar,  "Click",    THIS, "CmdVoltarClick")
1400:         BINDEVENT(loc_oPagina.txt_4c_Venc1,   "KeyPress", THIS, "TxtVencKeyPress")
1401:         BINDEVENT(loc_oPagina.txt_4c_Venc2,   "KeyPress", THIS, "TxtVencKeyPress")
1402:         BINDEVENT(loc_oPagina.txt_4c_Venc3,   "KeyPress", THIS, "TxtVencKeyPress")
1403:         BINDEVENT(loc_oPagina.txt_4c_Venc4,   "KeyPress", THIS, "TxtVencKeyPress")
1404:         BINDEVENT(loc_oPagina.txt_4c_Venc5,   "KeyPress", THIS, "TxtVencKeyPress")
1405:         BINDEVENT(loc_oPagina.txt_4c_Venc6,   "KeyPress", THIS, "TxtVencKeyPress")
1406:         BINDEVENT(loc_oPagina.txt_4c_Venc7,   "KeyPress", THIS, "TxtVencKeyPress")
1407:         BINDEVENT(loc_oPagina.txt_4c_Venc8,   "KeyPress", THIS, "TxtVencKeyPress")
1408:         BINDEVENT(loc_oPagina.txt_4c_Venc9,   "KeyPress", THIS, "TxtVencKeyPress")
1409:         BINDEVENT(loc_oPagina.txt_4c_Venc10,  "KeyPress", THIS, "TxtVencKeyPress")
1410:     ENDPROC
1411: 
1412:     *===========================================================================
1413:     * CmdVoltarClick - Navega de volta para Page1 (Calculo)
1414:     *===========================================================================
1415:     PROCEDURE CmdVoltarClick()
1416:         THIS.AlternarPagina(1)
1417:     ENDPROC
1418: 
1419:     *===========================================================================
1420:     * CmdLimparClick - Limpa todos os campos e reinicia a calculadora
1421:     *===========================================================================
1422:     PROCEDURE CmdLimparClick()
1423:         LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc
1424: 
1425:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1426:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1427: 
1428:         loc_oPg1.txt_4c_ValorBase.Value  = 0
1429:         loc_oPg1.txt_4c_JurosMes.Value   = 0
1430:         loc_oPg1.txt_4c_JurosDia.Value   = 0
1431:         loc_oPg1.txt_4c_DataBase.Value   = {}
1432:         loc_oPg1.txt_4c_DataFinal.Value  = {}
1433:         loc_oPg1.txt_4c_Dias.Value       = 0
1434:         loc_oPg1.txt_4c_ValorJuros.Value = 0
1435:         loc_oPg1.txt_4c_ValorTotal.Value = 0
1436:         loc_oPg1.txt_4c_Valorpar.Value   = 0
1437:         loc_oPg1.obj_4c_OptCalculo.Value = 1
1438:         loc_oPg1.obj_4c_OptDias.Value    = 1
1439: 
1440:         FOR loc_nI = 1 TO 10
1441:             loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
1442:             IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
1443:                 loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
1444:                 IF VARTYPE(loc_oVenc) = "O"
1445:                     loc_oVenc.Value = {}
1446:                 ENDIF
1447:             ENDIF
1448:         ENDFOR
1449: 
1450:         THIS.HabilitarCamposEntrada(.F.)
1451:         THIS.pgf_4c_Paginas.ActivePage = 1
1452:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1453:     ENDPROC
1454: 
1455:     *===========================================================================
1456:     * TxtVencKeyPress - Handler compartilhado para todos os campos de vencimento
1457:     * Valida data >= DataBase, atualiza campo Dias e recalcula juros
1458:     * Equivale ao PROCEDURE Valid de cada getvencN no original
1459:     *===========================================================================
1460:     PROCEDURE TxtVencKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1461:         LOCAL loc_oPg1, loc_oPg2, loc_oControl, loc_dVenc, loc_dDataBase
1462: 
1463:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1464:             RETURN
1465:         ENDIF
1466: 
1467:         loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1468:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
1469:         loc_oControl = loc_oPg2.ActiveControl
1470: 
1471:         IF VARTYPE(loc_oControl) != "O"
1472:             THIS.Calculos()
1473:             RETURN
1474:         ENDIF
1475: 
1476:         loc_dVenc     = loc_oControl.Value
1477:         loc_dDataBase = loc_oPg1.txt_4c_DataBase.Value
1478: 
1479:         IF !EMPTY(loc_dDataBase) AND !EMPTY(loc_dVenc)
1480:             IF loc_dVenc < loc_dDataBase
1481:                 MsgAviso("A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Data Base!", ;
1482:                          "Aten" + CHR(231) + CHR(227) + "o")
1483:                 loc_oControl.SetFocus()
1484:                 RETURN
1485:             ENDIF
1486:             loc_oPg1.txt_4c_Dias.Value = loc_dVenc - loc_dDataBase
1487:         ENDIF
1488: 
1489:         THIS.Calculos()
1490:     ENDPROC
1491: 
1492:     *===========================================================================
1493:     * BtnIncluirClick - Nova simulacao (reset completo + habilita entrada)
1494:     * Equivale a "Incluir" em forms CRUD: prepara formulario para nova entrada
1495:     * Reusa CmdLimparClick para zerar campos e HabilitarCamposEntrada para liberar
1496:     *===========================================================================
1497:     PROCEDURE BtnIncluirClick()
1498:         LOCAL loc_oPg1
1499: 
1500:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1501: 
1502:         *-- Zera todos os campos de entrada e resultado, retorna a Page1
1503:         THIS.CmdLimparClick()
1504: 
1505:         *-- Habilita ValorBase para o usuario iniciar nova simulacao
1506:         loc_oPg1.txt_4c_ValorBase.Enabled = .T.
1507:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1508: 
1509:         *-- Modo INCLUIR: campos vinculados so habilitam ao informar ValorBase > 0
1510:         THIS.HabilitarCamposEntrada(.F.)
1511:         THIS.this_cModoAtual = "INCLUIR"
1512: 
1513:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1514:     ENDPROC
1515: 
1516:     *===========================================================================
1517:     * BtnAlterarClick - Habilita edicao dos campos da simulacao atual
1518:     * Equivale a "Alterar" em forms CRUD: libera campos para modificacao
1519:     * Reabilita entrada preservando valores digitados (nao limpa)
1520:     *===========================================================================
1521:     PROCEDURE BtnAlterarClick()
1522:         LOCAL loc_oPg1, loc_nValorBase
1523: 
1524:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1525:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1526: 
1527:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1528:             MsgAviso("Informe o Valor Base para iniciar uma simula" + CHR(231) + CHR(227) + "o.", ;
1529:                      "Aten" + CHR(231) + CHR(227) + "o")
1530:             loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
1531:             loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1532:             loc_oPg1.txt_4c_ValorBase.SetFocus()
1533:             RETURN
1534:         ENDIF
1535: 
1536:         *-- Libera campos de entrada (ValorBase, Juros, Datas, Dias e OptionGroups)
1537:         loc_oPg1.txt_4c_ValorBase.Enabled  = .T.
1538:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .F.
1539:         THIS.HabilitarCamposEntrada(.T.)
1540:         THIS.this_cModoAtual = "ALTERAR"
1541: 
1542:         *-- Recalcula com valores atuais para refletir eventuais mudancas
1543:         THIS.Calculos()
1544: 
1545:         loc_oPg1.txt_4c_ValorBase.SetFocus()
1546:     ENDPROC
1547: 
1548:     *===========================================================================
1549:     * BtnVisualizarClick - Modo somente-leitura da simulacao atual
1550:     * Equivale a "Visualizar" em forms CRUD: bloqueia edicao e mostra vencimentos
1551:     * Alterna para Page2 (Vencimentos) apos travar Page1
1552:     *===========================================================================
1553:     PROCEDURE BtnVisualizarClick()
1554:         LOCAL loc_oPg1, loc_nValorBase
1555: 
1556:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1557:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1558: 
1559:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1560:             MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " simula" + CHR(231) + CHR(227) + ;
1561:                      "o para visualizar. Informe o Valor Base primeiro.", ;
1562:                      "Aten" + CHR(231) + CHR(227) + "o")
1563:             RETURN
1564:         ENDIF
1565: 
1566:         *-- Trava todos os campos de entrada em modo visualizacao
1567:         loc_oPg1.txt_4c_ValorBase.Enabled  = .F.
1568:         loc_oPg1.txt_4c_ValorBase.ReadOnly = .T.
1569:         THIS.HabilitarCamposEntrada(.F.)
1570:         THIS.this_cModoAtual = "VISUALIZAR"
1571: 
1572:         *-- Recalcula para garantir consistencia dos resultados exibidos
1573:         THIS.Calculos()
1574: 
1575:         *-- Navega para Page2 (Vencimentos) para revisao das parcelas
1576:         THIS.AlternarPagina(2)
1577:     ENDPROC
1578: 
1579:     *===========================================================================
1580:     * BtnExcluirClick - Descarta a simulacao atual (limpa todos os dados)
1581:     * Equivale a "Excluir" em forms CRUD: apaga entrada e resultados
1582:     * Confirma com o usuario antes de zerar, evitando perda acidental
1583:     *===========================================================================
1584:     PROCEDURE BtnExcluirClick()
1585:         LOCAL loc_oPg1, loc_nValorBase, loc_lConfirma
1586: 
1587:         loc_oPg1       = THIS.pgf_4c_Paginas.Page1
1588:         loc_nValorBase = loc_oPg1.txt_4c_ValorBase.Value
1589: 
1590:         IF EMPTY(loc_nValorBase) OR loc_nValorBase = 0
1591:             *-- Nao ha simulacao a descartar; apenas garante estado inicial
1592:             THIS.CmdLimparClick()
1593:             THIS.this_cModoAtual = "CALCULO"
1594:             RETURN
1595:         ENDIF
1596: 
1597:         loc_lConfirma = MsgConfirma("Deseja realmente descartar a simula" + CHR(231) + CHR(227) + ;
1598:                                     "o atual?", ;
1599:                                     "Confirma" + CHR(231) + CHR(227) + "o")
1600: 
1601:         IF !loc_lConfirma
1602:             RETURN
1603:         ENDIF
1604: 
1605:         *-- Zera todos os campos (Page1 + Page2), volta para Page1 e reinicia modo
1606:         THIS.CmdLimparClick()
1607:         THIS.this_cModoAtual = "CALCULO"
1608:     ENDPROC
1609: 
1610:     *===========================================================================
1611:     * CarregarLista - N/A para calculadora (sem lista de registros em BD)
1612:     * Existe para compatibilidade com o pipeline de migracao
1613:     *===========================================================================
1614:     PROCEDURE CarregarLista()
1615:         RETURN .T.
1616:     ENDPROC
1617: 
1618:     *===========================================================================
1619:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
1620:     * Para calculadora: habilita Limpar somente quando ha valor base preenchido
1621:     *===========================================================================
1622:     PROCEDURE AjustarBotoesPorModo()
1623:         LOCAL loc_lTemCalculo
1624: 
1625:         loc_lTemCalculo = (THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.Value > 0)
1626: 
1627:         IF PEMSTATUS(THIS.cnt_4c_BotoesAcao, "cmd_4c_Limpar", 5)
1628:             THIS.cnt_4c_BotoesAcao.cmd_4c_Limpar.Enabled = loc_lTemCalculo
1629:         ENDIF
1630:     ENDPROC
1631: 
1632:     *===========================================================================
1633:     * LimparCampos - Limpa todos os campos de entrada e resultado
1634:     * Equivalente semantico ao LimparCampos() do pipeline CRUD
1635:     *===========================================================================
1636:     PROCEDURE LimparCampos()
1637:         LOCAL loc_oPg1, loc_oPg2, loc_nI, loc_cCampo, loc_oVenc
1638: 
1639:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1640:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1641: 
1642:         loc_oPg1.txt_4c_ValorBase.Value  = 0
1643:         loc_oPg1.txt_4c_JurosMes.Value   = 0
1644:         loc_oPg1.txt_4c_JurosDia.Value   = 0
1645:         loc_oPg1.txt_4c_DataBase.Value   = {}
1646:         loc_oPg1.txt_4c_DataFinal.Value  = {}
1647:         loc_oPg1.txt_4c_Dias.Value       = 0
1648:         loc_oPg1.txt_4c_ValorJuros.Value = 0
1649:         loc_oPg1.txt_4c_ValorTotal.Value = 0
1650:         loc_oPg1.txt_4c_Valorpar.Value   = 0
1651:         loc_oPg1.obj_4c_OptCalculo.Value = 1
1652:         loc_oPg1.obj_4c_OptDias.Value    = 1
1653: 
1654:         FOR loc_nI = 1 TO 10
1655:             loc_cCampo = "txt_4c_Venc" + TRANSFORM(loc_nI)
1656:             IF PEMSTATUS(loc_oPg2, loc_cCampo, 5)
1657:                 loc_oVenc = EVALUATE("loc_oPg2." + loc_cCampo)
1658:                 IF VARTYPE(loc_oVenc) = "O"
1659:                     loc_oVenc.Value = {}
1660:                 ENDIF
1661:             ENDIF
1662:         ENDFOR
1663: 
1664:         THIS.HabilitarCamposEntrada(.F.)
1665:     ENDPROC
1666: 
1667:     *===========================================================================
1668:     * HabilitarCampos - Habilita ou desabilita todos os campos editaveis
1669:     * Generaliza HabilitarCamposEntrada() incluindo o proprio ValorBase
1670:     * par_lHabilitar: .T. = habilita, .F. = desabilita
1671:     *===========================================================================
1672:     PROCEDURE HabilitarCampos(par_lHabilitar)
1673:         LOCAL loc_oPg1
1674: 
1675:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1676: 
1677:         loc_oPg1.txt_4c_ValorBase.Enabled  = par_lHabilitar
1678:         loc_oPg1.txt_4c_ValorBase.ReadOnly = !par_lHabilitar
1679: 
1680:         THIS.HabilitarCamposEntrada(par_lHabilitar)
1681:     ENDPROC
1682: 
1683:     *===========================================================================
1684:     * FormParaBO - Transfere valores dos campos do form para as propriedades do BO
1685:     * Mapeamento completo: entradas + tipo + vencimentos
1686:     *===========================================================================
1687:     PROTECTED PROCEDURE FormParaBO()
1688:         LOCAL loc_oPg1, loc_oPg2, loc_oBO
1689: 
1690:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1691:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1692:         loc_oBO  = THIS.this_oBusinessObject
1693: 
1694:         loc_oBO.this_nValorBase   = loc_oPg1.txt_4c_ValorBase.Value
1695:         loc_oBO.this_nJurosMes    = loc_oPg1.txt_4c_JurosMes.Value
1696:         loc_oBO.this_nJurosDia    = loc_oPg1.txt_4c_JurosDia.Value
1697:         loc_oBO.this_dDataBase    = loc_oPg1.txt_4c_DataBase.Value
1698:         loc_oBO.this_dDataFinal   = loc_oPg1.txt_4c_DataFinal.Value
1699:         loc_oBO.this_nDias        = loc_oPg1.txt_4c_Dias.Value
1700:         loc_oBO.this_nTipoCalculo = loc_oPg1.obj_4c_OptCalculo.Value
1701:         loc_oBO.this_nTipoDias    = loc_oPg1.obj_4c_OptDias.Value
1702:         loc_oBO.this_dVenc1       = loc_oPg2.txt_4c_Venc1.Value
1703:         loc_oBO.this_dVenc2       = loc_oPg2.txt_4c_Venc2.Value
1704:         loc_oBO.this_dVenc3       = loc_oPg2.txt_4c_Venc3.Value
1705:         loc_oBO.this_dVenc4       = loc_oPg2.txt_4c_Venc4.Value
1706:         loc_oBO.this_dVenc5       = loc_oPg2.txt_4c_Venc5.Value
1707:         loc_oBO.this_dVenc6       = loc_oPg2.txt_4c_Venc6.Value
1708:         loc_oBO.this_dVenc7       = loc_oPg2.txt_4c_Venc7.Value
1709:         loc_oBO.this_dVenc8       = loc_oPg2.txt_4c_Venc8.Value
1710:         loc_oBO.this_dVenc9       = loc_oPg2.txt_4c_Venc9.Value
1711:         loc_oBO.this_dVenc10      = loc_oPg2.txt_4c_Venc10.Value
1712:     ENDPROC
1713: 
1714:     *===========================================================================
1715:     * BOParaForm - Transfere propriedades do BO de volta para os campos do form
1716:     * Carrega entradas + resultados do calculo + vencimentos
1717:     *===========================================================================
1718:     PROTECTED PROCEDURE BOParaForm()
1719:         LOCAL loc_oPg1, loc_oPg2, loc_oBO
1720: 
1721:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1722:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1723:         loc_oBO  = THIS.this_oBusinessObject
1724: 
1725:         loc_oPg1.txt_4c_ValorBase.Value  = loc_oBO.this_nValorBase
1726:         loc_oPg1.txt_4c_JurosMes.Value   = loc_oBO.this_nJurosMes
1727:         loc_oPg1.txt_4c_JurosDia.Value   = loc_oBO.this_nJurosDia
1728:         loc_oPg1.txt_4c_DataBase.Value   = loc_oBO.this_dDataBase
1729:         loc_oPg1.txt_4c_DataFinal.Value  = loc_oBO.this_dDataFinal
1730:         loc_oPg1.txt_4c_Dias.Value       = loc_oBO.this_nDias
1731:         loc_oPg1.obj_4c_OptCalculo.Value = loc_oBO.this_nTipoCalculo
1732:         loc_oPg1.obj_4c_OptDias.Value    = loc_oBO.this_nTipoDias
1733:         loc_oPg1.txt_4c_ValorJuros.Value = loc_oBO.this_nValorJuros
1734:         loc_oPg1.txt_4c_ValorTotal.Value = loc_oBO.this_nValorTotal
1735:         loc_oPg1.txt_4c_Valorpar.Value   = loc_oBO.this_nValorParcela
1736:         loc_oPg2.txt_4c_Venc1.Value      = loc_oBO.this_dVenc1
1737:         loc_oPg2.txt_4c_Venc2.Value      = loc_oBO.this_dVenc2
1738:         loc_oPg2.txt_4c_Venc3.Value      = loc_oBO.this_dVenc3
1739:         loc_oPg2.txt_4c_Venc4.Value      = loc_oBO.this_dVenc4
1740:         loc_oPg2.txt_4c_Venc5.Value      = loc_oBO.this_dVenc5
1741:         loc_oPg2.txt_4c_Venc6.Value      = loc_oBO.this_dVenc6
1742:         loc_oPg2.txt_4c_Venc7.Value      = loc_oBO.this_dVenc7
1743:         loc_oPg2.txt_4c_Venc8.Value      = loc_oBO.this_dVenc8
1744:         loc_oPg2.txt_4c_Venc9.Value      = loc_oBO.this_dVenc9
1745:         loc_oPg2.txt_4c_Venc10.Value     = loc_oBO.this_dVenc10
1746:     ENDPROC
1747: 
1748:     *===========================================================================
1749:     * BtnEncerrarClick - Fecha o formulario (alias CRUD para CmdEncerrarClick)
1750:     *===========================================================================
1751:     PROCEDURE BtnEncerrarClick()
1752:         THIS.CmdEncerrarClick()
1753:     ENDPROC
1754: 
1755:     *===========================================================================
1756:     * BtnBuscarClick - N/A para calculadora (sem lista de registros)
1757:     * Existe para compatibilidade com o pipeline de migracao
1758:     *===========================================================================
1759:     PROCEDURE BtnBuscarClick()
1760:         RETURN
1761:     ENDPROC
1762: 
1763:     *===========================================================================
1764:     * BtnSalvarClick - Executa o calculo via BO (FormParaBO -> Inserir -> BOParaForm)
1765:     * Equivale a "Salvar" em forms CRUD: valida, processa e exibe resultado
1766:     *===========================================================================
1767:     PROCEDURE BtnSalvarClick()
1768:         LOCAL loc_oPg1, loc_lSucesso
1769: 
1770:         loc_oPg1      = THIS.pgf_4c_Paginas.Page1
1771:         loc_lSucesso  = .F.
1772: 
1773:         IF loc_oPg1.txt_4c_ValorBase.Value <= 0
1774:             MsgAviso("Informe o Valor Base para calcular.", "Aten" + CHR(231) + CHR(227) + "o")
1775:             loc_oPg1.txt_4c_ValorBase.SetFocus()
1776:             RETURN
1777:         ENDIF
1778: 
1779:         THIS.FormParaBO()
1780:         loc_lSucesso = THIS.this_oBusinessObject.Inserir()
1781: 
1782:         IF loc_lSucesso
1783:             THIS.BOParaForm()
1784:         ENDIF
1785:     ENDPROC
1786: 
1787:     *===========================================================================
1788:     * BtnCancelarClick - Cancela simulacao atual, limpa campos e volta ao inicio
1789:     * Equivale a "Cancelar" em forms CRUD: descarta alteracoes em andamento
1790:     *===========================================================================
1791:     PROCEDURE BtnCancelarClick()
1792:         THIS.LimparCampos()
1793:         THIS.pgf_4c_Paginas.ActivePage = 1
1794:         THIS.this_cModoAtual = "CALCULO"
1795: 
1796:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "txt_4c_ValorBase", 5)
1797:             THIS.pgf_4c_Paginas.Page1.txt_4c_ValorBase.SetFocus()
1798:         ENDIF
1799:     ENDPROC
1800: 
1801:     *===========================================================================
1802:     * Destroy - Libera recursos ao fechar o formulario
1803:     *===========================================================================
1804:     PROCEDURE Destroy()
1805:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1806:             THIS.this_oBusinessObject = .NULL.
1807:         ENDIF
1808:         DODEFAULT()
1809:     ENDPROC
1810: 
1811: ENDDEFINE


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

