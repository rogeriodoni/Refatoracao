# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRDFT): Top original=298 vs migrado 'cnt_4c_Container1' Top=14 (diff=284px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRDFT): Left original=54 vs migrado 'cnt_4c_Container1' Left=18 (diff=36px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRDFT.Container1): Top original=14 vs migrado 'lbl_4c_Label11' Top=268 (diff=254px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRDFT.Container1): Left original=18 vs migrado 'lbl_4c_Label11' Left=98 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGPRDFT): Top original=200 vs migrado 'obj_4c_Optiongroup1' Top=4 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGPRDFT): Left original=222 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=217px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2124 linhas total):

*-- Linhas 2 a 45:
2: * Formsigprdft.prg - Formulario OPERACIONAL - SiTef Cartao de Debito
3: * Form original: SIGPRDFT.SCX
4: * Tipo: OPERACIONAL - dialogo modal TEF (flat layout, sem PageFrame)
5: * Chamada: loForm = CREATEOBJECT("Formsigprdft", EndSiTef, ValPago, Cupom,
6: *                                 Caixa, DebCred, TipPagto, NumParcs, lcIdent, pcOpers)
7: *          IF VARTYPE(loForm) = "O"
8: *              loForm.Show()
9: *              loc_cResultado = loForm.this_cResultado
10: *          ENDIF
11: *==============================================================================
12: DEFINE CLASS Formsigprdft AS FormBase
13: 
14:     *-- Dimensoes e visual identicos ao original SIGPRDFT
15:     Width       = 500
16:     Height      = 370
17:     AutoCenter  = .T.
18:     BorderStyle = 2
19:     ShowWindow = 1
20:     ControlBox  = .F.
21:     MaxButton   = .F.
22:     MinButton   = .F.
23:     KeyPreview  = .T.
24:     TitleBar    = 0
25:     WindowType  = 1
26: 
27:     *-- Business Object
28:     this_oBusinessObject = .NULL.
29: 
30:     *-- Props customizadas (migrado de pcbandeira/pctvenda/abandona/pckeyesc/lsCartao)
31:     this_cBandeira   = "00000"
32:     this_cCartao     = "00000"
33:     this_lKeyEsc     = .T.
34:     this_lTvenda     = .T.
35:     this_lAbandonou  = .F.
36: 
37:     *-- Estado SiTef (migrado de PUBLIC do legado para propriedades do form)
38:     this_nProxCmd    = 0
39:     this_nTipoCampo  = 0
40:     this_nTamMin     = 0
41:     this_nTamMax     = 0
42:     this_cBuffer     = ""
43:     this_nContinua   = 0
44:     this_nCiclos     = 0
45:     this_nParcs      = 0

*-- Linhas 66 a 234:
66:     * Init - Recebe parametros TEF do chamador e inicializa BO e estado SiTef
67:     * Assinatura identica ao legado SIGPRDFT.Init()
68:     *==========================================================================
69:     PROCEDURE Init(par_sEndSiTef, par_nValPago, par_sCupom, par_sCaixa, ;
70:                    par_sDebCred, par_sTipPagto, par_nNumParcs, par_cIdent, par_cOpers)
71:         LOCAL loc_lSucesso, loc_oErro
72:         loc_lSucesso = .T.
73:         TRY
74:             THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")
75:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
76:                 MsgErro("Erro ao criar BO SiTef", "Erro")
77:                 loc_lSucesso = .F.
78:             ELSE
79:                 THIS.this_oBusinessObject.this_cEndSiTef  = IIF(VARTYPE(par_sEndSiTef)  = "C", ALLTRIM(par_sEndSiTef), "")
80:                 THIS.this_oBusinessObject.this_nValPago   = IIF(VARTYPE(par_nValPago)   = "N", par_nValPago, 0)
81:                 THIS.this_oBusinessObject.this_cCupom     = IIF(VARTYPE(par_sCupom)     = "C", ;
82:                                                                  TRANSFORM(par_sCupom, "@L 999999"), "")
83:                 THIS.this_oBusinessObject.this_cCaixa     = IIF(VARTYPE(par_sCaixa)     = "C", par_sCaixa, "")
84:                 THIS.this_oBusinessObject.this_cDebCred   = IIF(VARTYPE(par_sDebCred)   = "C", par_sDebCred, "")
85:                 THIS.this_oBusinessObject.this_cTipPagto  = IIF(VARTYPE(par_sTipPagto)  = "C", par_sTipPagto, "")
86:                 THIS.this_oBusinessObject.this_nNumParcs  = IIF(VARTYPE(par_nNumParcs)  = "N", par_nNumParcs, 0)
87:                 THIS.this_oBusinessObject.this_cIdent     = IIF(VARTYPE(par_cIdent)     = "C", par_cIdent, "")
88:                 THIS.this_oBusinessObject.this_cOpers     = IIF(VARTYPE(par_cOpers)     = "C", par_cOpers, "")
89: 
90:                 THIS.this_oBusinessObject.InicializarDLLs()
91: 
92:                 THIS.this_nParcs     = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 0)
93:                 THIS.this_dData      = DATE()
94:                 THIS.this_lDCD       = .F.
95:                 THIS.this_nCiclos    = 0
96:                 THIS.this_cSaque     = "0,00"
97:                 THIS.this_cBuffer    = SPACE(2000)
98:                 THIS.this_nContinua  = 0
99:                 THIS.this_lKeyEsc    = .T.
100:                 THIS.this_lAbandonou = .F.
101:             ENDIF
102:         CATCH TO loc_oErro
103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
104:                     " PROC=" + loc_oErro.Procedure, "Erro Init SiTef")
105:             loc_lSucesso = .F.
106:         ENDTRY
107:         IF !loc_lSucesso
108:             RETURN .F.
109:         ENDIF
110:         RETURN DODEFAULT()
111:     ENDPROC
112: 
113:     *==========================================================================
114:     * InicializarForm - Override de FormBase: cria layout plano sem PageFrame
115:     * Este dialogo TEF nao segue padrao CRUD (sem Page1/Page2)
116:     *==========================================================================
117:     PROTECTED PROCEDURE InicializarForm()
118:         LOCAL loc_lSucesso, loc_oErro
119:         loc_lSucesso = .F.
120:         TRY
121:             SET DATE TO BRITISH
122:             SET CENTURY ON
123: 
124:             THIS.Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
125:             THIS.AlwaysOnTop = .T.
126: 
127:             THIS.CarregarDadosOperacao()
128:             THIS.ConfigurarPageFrame()
129:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
130:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
131:             THIS.ConfigurarConteudo()
132:             THIS.InicializarValoresIniciais()
133:             THIS.TornarControlesVisiveis(THIS)
134:             THIS.ZOrder(0)
135:             THIS.Refresh()
136: 
137:             loc_lSucesso = .T.
138:         CATCH TO loc_oErro
139:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
140:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm SiTef")
141:             loc_lSucesso = .F.
142:         ENDTRY
143:         RETURN loc_lSucesso
144:     ENDPROC
145: 
146:     *==========================================================================
147:     * CarregarDadosOperacao - Carrega crSigOpFp e crSigCdEmp via SQL Server
148:     * Migrado de: SIGPRDFT.Init (bloco poDataMgr.SqlExecute)
149:     *==========================================================================
150:     PROTECTED PROCEDURE CarregarDadosOperacao()
151:         LOCAL loc_cSQL, loc_oErro
152:         TRY
153:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
154:                 IF USED("crSigOpFp")
155:                     USE IN crSigOpFp
156:                 ENDIF
157:                 loc_cSQL = "SELECT * FROM SigOpFp WHERE FPags = " + ;
158:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cOpers))
159:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp") < 0
160:                     MsgErro("Erro ao carregar dados da opera" + CHR(231) + CHR(227) + "o SiTef", "Erro SQL")
161:                 ENDIF
162: 
163:                 IF USED("crSigCdEmp")
164:                     USE IN crSigCdEmp
165:                 ENDIF
166:                 loc_cSQL = "SELECT * FROM SigCdEmp WHERE cEmps = " + ;
167:                            EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
168:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp") < 0
169:                     MsgErro("Erro ao carregar dados da empresa", "Erro SQL")
170:                 ENDIF
171: 
172:                 THIS.this_cIdTerminal = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
173:             ELSE
174:                 MsgErro("Conex" + CHR(227) + "o com banco de dados indispon" + CHR(237) + "vel", ;
175:                         "Erro SiTef")
176:             ENDIF
177:         CATCH TO loc_oErro
178:             MsgErro(loc_oErro.Message, "Erro Carregar Dados Opera" + CHR(231) + CHR(227) + "o")
179:         ENDTRY
180:     ENDPROC
181: 
182:     *==========================================================================
183:     * ConfigurarPageFrame - Orquestra layout root do dialogo TEF (flat)
184:     *==========================================================================
185:     PROTECTED PROCEDURE ConfigurarPageFrame()
186:         THIS.ConfigurarCabecalho()
187:         THIS.ConfigurarBotaoCancelar()
188:     ENDPROC
189: 
190:     *==========================================================================
191:     * ConfigurarCabecalho - Container escuro com titulo do dialogo TEF
192:     * Migrado de: SIGPRDFT.cntSombra (adaptado para Width=500 do form)
193:     *==========================================================================
194:     PROTECTED PROCEDURE ConfigurarCabecalho()
195:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
196:         WITH THIS.cnt_4c_Cabecalho
197:             .Top         = 0
198:             .Left        = 0
199:             .Width       = THIS.Width
200:             .Height      = 80
201:             .BorderWidth = 0
202:             .BackStyle   = 1
203:             .BackColor   = RGB(100, 100, 100)
204: 
205:             .AddObject("lbl_4c_Sombra", "Label")
206:             WITH .lbl_4c_Sombra
207:                 .AutoSize  = .F.
208:                 .FontBold  = .T.
209:                 .FontName  = "Tahoma"
210:                 .FontSize  = 18
211:                 .WordWrap  = .T.
212:                 .Alignment = 0
213:                 .BackStyle = 0
214:                 .Caption   = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
215:                 .Height    = 40
216:                 .Left      = 10
217:                 .Top       = 18
218:                 .Width     = THIS.Width
219:                 .ForeColor = RGB(0, 0, 0)
220:             ENDWITH
221: 
222:             .AddObject("lbl_4c_Titulo", "Label")
223:             WITH .lbl_4c_Titulo
224:                 .AutoSize    = .F.
225:                 .FontBold    = .T.
226:                 .FontName    = "Tahoma"
227:                 .FontSize    = 18
228:                 .WordWrap    = .T.
229:                 .Alignment   = 0
230:                 .BackStyle   = 0
231:                 .Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
232:                 .Height      = 46
233:                 .Left        = 10
234:                 .Top         = 17

*-- Linhas 243 a 325:
243:     * ConfigurarBotaoCancelar - CommandGroup SAIDA com botao CANCELA
244:     * Migrado de: SIGPRDFT.SAIDA (Top=-2, Left=420, Width=85, Height=85)
245:     *==========================================================================
246:     PROTECTED PROCEDURE ConfigurarBotaoCancelar()
247:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
248:         WITH THIS.obj_4c_SAIDA
249:             .ButtonCount = 1
250:             .AutoSize    = .T.
251:             .BackStyle   = 0
252:             .BorderStyle = 0
253:             .Value       = 0
254:             .Height      = 85
255:             .Left        = 420
256:             .Top         = -2
257:             .Width       = 85
258:             .BackColor   = RGB(255, 255, 255)
259:             .Themes      = .F.
260: 
261:             WITH .Buttons(1)
262:                 .Top        = 5
263:                 .Left       = 5
264:                 .Height     = 75
265:                 .Width      = 75
266:                 .FontBold   = .T.
267:                 .FontItalic = .T.
268:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
269:                 .Cancel     = .F.
270:                 .Caption    = CHR(60) + "Cancelar"
271:                 .ForeColor  = RGB(90, 90, 90)
272:                 .BackColor  = RGB(255, 255, 255)
273:                 .Themes     = .F.
274:                 .Name       = "CANCELA"
275:             ENDWITH
276:         ENDWITH
277:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelaClick")
278:     ENDPROC
279: 
280:     *==========================================================================
281:     * ConfigurarConteudo - Cria todos os controles visuais do dialogo TEF
282:     * Migrado de: propriedades dos objetos SIGPRDFT (secao 2 do SCX)
283:     * Fase 4/8: adiciona controles de entrada e instrucao ao usuario
284:     *==========================================================================
285:     PROTECTED PROCEDURE ConfigurarConteudo()
286:         LOCAL loc_oErro
287:         TRY
288:             *-- Shape2: borda decorativa ao redor dos campos de entrada
289:             THIS.AddObject("shp_4c_Shape2", "Shape")
290:             WITH THIS.shp_4c_Shape2
291:                 .Top           = 93
292:                 .Left          = 17
293:                 .Height        = 202
294:                 .Width         = 466
295:                 .SpecialEffect = 0
296:             ENDWITH
297: 
298:             *-- Label5: rotulo "VALOR :"
299:             THIS.AddObject("lbl_4c_Label5", "Label")
300:             WITH THIS.lbl_4c_Label5
301:                 .AutoSize  = .F.
302:                 .FontBold  = .T.
303:                 .FontName  = "Tahoma"
304:                 .FontSize  = 8
305:                 .Alignment = 0
306:                 .BackStyle = 0
307:                 .Caption   = "VALOR :"
308:                 .Height    = 15
309:                 .Left      = 175
310:                 .Top       = 102
311:                 .Width     = 45
312:                 .ForeColor = RGB(90, 90, 90)
313:             ENDWITH
314: 
315:             *-- GetValor: valor da transacao (somente leitura - exibe valor recebido)
316:             THIS.AddObject("txt_4c_Valor", "TextBox")
317:             WITH THIS.txt_4c_Valor
318:                 .FontBold          = .T.
319:                 .FontName          = "Tahoma"
320:                 .FontSize          = 8
321:                 .Alignment         = 3
322:                 .Value             = 0
323:                 .Enabled           = .F.
324:                 .Format            = ""
325:                 .Height            = 23

*-- Linhas 369 a 727:
369:                 .ForeColor         = RGB(0, 0, 0)
370:                 .DisabledForeColor = RGB(0, 0, 0)
371:             ENDWITH
372:             BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "TxtCartaoGotFocus")
373: 
374:             *-- Label2: rotulo "4 ULTIMOS DIGITOS :" (muda para "Validade Cartao :" quando lCartao="S")
375:             THIS.AddObject("lbl_4c_Label2", "Label")
376:             WITH THIS.lbl_4c_Label2
377:                 .AutoSize  = .F.
378:                 .FontBold  = .T.
379:                 .FontName  = "Tahoma"
380:                 .FontSize  = 8
381:                 .Alignment = 0
382:                 .BackStyle = 0
383:                 .Caption   = "4 ULTIMOS DIGITOS :"
384:                 .Height    = 17
385:                 .Left      = 101
386:                 .Top       = 171
387:                 .Width     = 119
388:                 .ForeColor = RGB(90, 90, 90)
389:             ENDWITH
390: 
391:             *-- GetDigitos: 4 ultimos digitos do cartao (GotFocus inicia sessao TEF)
392:             THIS.AddObject("txt_4c_Digitos", "TextBox")
393:             WITH THIS.txt_4c_Digitos
394:                 .FontBold  = .T.
395:                 .FontName  = "Tahoma"
396:                 .FontSize  = 8
397:                 .Enabled   = .T.
398:                 .Height    = 23
399:                 .InputMask = "9999"
400:                 .Left      = 222
401:                 .TabIndex  = 3
402:                 .Top       = 168
403:                 .Width     = 40
404:                 .ForeColor = RGB(0, 0, 0)
405:                 .BackColor = RGB(212, 208, 200)
406:             ENDWITH
407:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "TxtDigitosGotFocus")
408:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "TxtDigitosKeyPress")
409: 
410:             *-- Label4: rotulo "TIPO DE VENDA :"
411:             THIS.AddObject("lbl_4c_Label4", "Label")
412:             WITH THIS.lbl_4c_Label4
413:                 .AutoSize  = .F.
414:                 .FontBold  = .T.
415:                 .FontName  = "Tahoma"
416:                 .FontSize  = 8
417:                 .Alignment = 0
418:                 .BackStyle = 0
419:                 .Caption   = "TIPO DE VENDA :"
420:                 .Height    = 15
421:                 .Left      = 129
422:                 .Top       = 204
423:                 .Width     = 91
424:                 .ForeColor = RGB(90, 90, 90)
425:             ENDWITH
426: 
427:             *-- Optiongroup1: selecao "A vista" / "Predatado"
428:             THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
429:             WITH THIS.obj_4c_Optiongroup1
430:                 .ButtonCount = 2
431:                 .Enabled     = .T.
432:                 .Height      = 26
433:                 .Left        = 222
434:                 .Top         = 200
435:                 .Width       = 161
436:                 .TabIndex    = 5
437:                 WITH .Buttons(1)
438:                     .FontBold  = .T.
439:                     .Caption   = " A vista"
440:                     .Height    = 17
441:                     .Left      = 5
442:                     .Top       = 4
443:                     .Width     = 61
444:                     .ForeColor = RGB(90, 90, 90)
445:                     .BackStyle = 0
446:                     .AutoSize  = .F.
447:                     .Themes    = .F.
448:                 ENDWITH
449:                 WITH .Buttons(2)
450:                     .FontBold  = .T.
451:                     .FontName  = "Tahoma"
452:                     .FontSize  = 8
453:                     .Caption   = " Predatado"
454:                     .Height    = 15
455:                     .Left      = 73
456:                     .Top       = 5
457:                     .Width     = 80
458:                     .ForeColor = RGB(90, 90, 90)
459:                     .BackStyle = 0
460:                     .AutoSize  = .F.
461:                     .Themes    = .F.
462:                 ENDWITH
463:             ENDWITH
464:             THIS.obj_4c_Optiongroup1.Value = 1
465:             BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptGrupoInteractiveChange")
466:             BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptGrupoOption1KeyPress")
467:             BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptGrupoOption1GotFocus")
468: 
469:             *-- Label6: rotulo "N? PARCELAS :"
470:             THIS.AddObject("lbl_4c_Label6", "Label")
471:             WITH THIS.lbl_4c_Label6
472:                 .AutoSize  = .F.
473:                 .FontBold  = .T.
474:                 .FontName  = "Tahoma"
475:                 .FontSize  = 8
476:                 .Alignment = 0
477:                 .BackStyle = 0
478:                 .Caption   = "N" + CHR(186) + " PARCELAS :"
479:                 .Height    = 15
480:                 .Left      = 139
481:                 .Top       = 238
482:                 .Width     = 81
483:                 .ForeColor = RGB(90, 90, 90)
484:             ENDWITH
485: 
486:             *-- Text1: numero de parcelas (habilitado pelo TEF quando aplicavel)
487:             THIS.AddObject("txt_4c_Text1", "TextBox")
488:             WITH THIS.txt_4c_Text1
489:                 .FontBold          = .T.
490:                 .FontName          = "Tahoma"
491:                 .FontSize          = 8
492:                 .Enabled           = .F.
493:                 .Format            = ""
494:                 .Height            = 23
495:                 .InputMask         = "99"
496:                 .Left              = 222
497:                 .TabIndex          = 6
498:                 .Top               = 235
499:                 .Width             = 27
500:                 .ForeColor         = RGB(0, 0, 0)
501:                 .DisabledForeColor = RGB(0, 0, 0)
502:                 .Value             = ""
503:             ENDWITH
504:             BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "TxtText1GotFocus")
505:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",   THIS, "TxtText1KeyPress")
506:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "TxtText1LostFocus")
507: 
508:             *-- Label11: rotulo "1a PARCELA/VENCTO :"
509:             THIS.AddObject("lbl_4c_Label11", "Label")
510:             WITH THIS.lbl_4c_Label11
511:                 .AutoSize  = .F.
512:                 .FontBold  = .T.
513:                 .FontName  = "Tahoma"
514:                 .FontSize  = 8
515:                 .Alignment = 0
516:                 .BackStyle = 0
517:                 .Caption   = "1" + CHR(186) + " PARCELA/VENCTO :"
518:                 .Height    = 15
519:                 .Left      = 98
520:                 .Top       = 268
521:                 .Width     = 122
522:                 .ForeColor = RGB(90, 90, 90)
523:             ENDWITH
524: 
525:             *-- GetDatas: data da primeira parcela ou vencimento
526:             THIS.AddObject("txt_4c_Datas", "TextBox")
527:             WITH THIS.txt_4c_Datas
528:                 .FontBold          = .T.
529:                 .FontName          = "Tahoma"
530:                 .FontSize          = 8
531:                 .Alignment         = 3
532:                 .Value             = {}
533:                 .Enabled           = .F.
534:                 .Format            = ""
535:                 .Height            = 23
536:                 .InputMask         = ""
537:                 .Left              = 222
538:                 .TabIndex          = 7
539:                 .Top               = 266
540:                 .Width             = 75
541:                 .ForeColor         = RGB(0, 0, 0)
542:                 .DisabledForeColor = RGB(0, 0, 0)
543:             ENDWITH
544:             BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "TxtDatasGotFocus")
545:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",   THIS, "TxtDatasKeyPress")
546:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "TxtDatasLostFocus")
547: 
548:             *-- Container1: exibe mensagem de instrucao ao usuario (tipo "Insira o Cartao")
549:             THIS.AddObject("cnt_4c_Container1", "Container")
550:             WITH THIS.cnt_4c_Container1
551:                 .Top           = 298
552:                 .Left          = 54
553:                 .Width         = 392
554:                 .Height        = 58
555:                 .SpecialEffect = 0
556:                 .BackStyle     = 1
557:                 .BackColor     = RGB(255, 255, 255)
558: 
559:                 .AddObject("lbl_4c_Label1", "Label")
560:                 WITH .lbl_4c_Label1
561:                     .AutoSize  = .F.
562:                     .FontBold  = .T.
563:                     .FontName  = "Tahoma"
564:                     .FontSize  = 18
565:                     .Alignment = 2
566:                     .BackStyle = 0
567:                     .Caption   = "Insira ou Passe o Cartao"
568:                     .Height    = 29
569:                     .Left      = 18
570:                     .Top       = 14
571:                     .Width     = 349
572:                     .ForeColor = RGB(90, 90, 90)
573:                 ENDWITH
574:             ENDWITH
575: 
576:         CATCH TO loc_oErro
577:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
578:                     " PROC=" + loc_oErro.Procedure, "Erro ConfigurarConteudo SiTef")
579:         ENDTRY
580:     ENDPROC
581: 
582:     *==========================================================================
583:     * InicializarValoresIniciais - Define valores iniciais nos controles
584:     * Migrado de: bloco final de SIGPRDFT.Init (apos WITH Thisform ... EndWith)
585:     *==========================================================================
586:     PROTECTED PROCEDURE InicializarValoresIniciais()
587:         LOCAL loc_oErro
588:         TRY
589:             THIS.txt_4c_Valor.Value  = THIS.this_oBusinessObject.this_nValPago
590:             THIS.txt_4c_Datas.Value  = DATE()
591:             THIS.this_dData          = DATE()
592:             THIS.txt_4c_Text1.Value  = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
593:             THIS.this_nParcs         = THIS.this_oBusinessObject.this_nNumParcs
594: 
595:             IF USED("crSigOpFp")
596:                 IF crSigOpFp.lCartao = "S"
597:                     THIS.txt_4c_Cartao.Enabled = .T.
598:                     THIS.lbl_4c_Label2.Caption  = "Validade Cart" + CHR(227) + "o :"
599:                 ENDIF
600:             ENDIF
601: 
602:             IF !THIS.txt_4c_Datas.Enabled
603:                 IF USED("crSigOpFp") AND crSigOpFp.lCartao = "N"
604:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
605:                 ELSE
606:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
607:                 ENDIF
608:             ELSE
609:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
610:             ENDIF
611: 
612:             THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
613: 
614:         CATCH TO loc_oErro
615:             MsgErro(loc_oErro.Message, "Erro InicializarValoresIniciais SiTef")
616:         ENDTRY
617:     ENDPROC
618: 
619:     *==========================================================================
620:     * BtnCancelaClick - Cancela transacao SiTef e libera o dialogo
621:     * Migrado de: SIGPRDFT.SAIDA.CANCELA.Click
622:     *==========================================================================
623:     PROCEDURE BtnCancelaClick()
624:         LOCAL loc_nRetorno, loc_oErro
625:         TRY
626:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
627:                 @THIS.this_nProxCmd,   @THIS.this_nTipoCampo, ;
628:                 @THIS.this_nTamMin,    @THIS.this_nTamMax, ;
629:                 @THIS.this_cBuffer,    LEN(THIS.this_cBuffer), -1)
630:             THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", ;
631:                               THIS.this_oBusinessObject.this_nValPago)
632:         CATCH TO loc_oErro
633:             MsgErro(loc_oErro.Message, "Erro Cancelar SiTef")
634:         ENDTRY
635:         THIS.Release()
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * KeyPress - Captura ESC no nivel do form (KeyPreview=.T.) para cancelar
640:     * Migrado de: SIGPRDFT.KeyPress
641:     *==========================================================================
642:     PROCEDURE KeyPress()
643:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
644:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
645:             NODEFAULT
646:             THIS.BtnCancelaClick()
647:         ENDIF
648:     ENDPROC
649: 
650:     *==========================================================================
651:     * ErroTef - Delega tratamento de erros SiTef para o BO
652:     * Migrado de: SIGPRDFT.errotef
653:     *==========================================================================
654:     PROCEDURE ErroTef(par_nRetorno)
655:         THIS.this_oBusinessObject.ErroTef(par_nRetorno)
656:     ENDPROC
657: 
658:     *==========================================================================
659:     * RetornoFalha - Grava arquivo de falha SiTef e seta resultado do form
660:     * Migrado de: SIGPRDFT.retornofalha (via delegacao ao BO)
661:     *==========================================================================
662:     PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
663:         THIS.this_oBusinessObject.RetornoFalha(par_cMensagem, par_nValPago)
664:         THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
665:             THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
666:     ENDPROC
667: 
668:     *==========================================================================
669:     * MontaRetorno - Grava arquivo de sucesso SiTef e seta resultado do form
670:     * Migrado de: SIGPRDFT.montaretorno (via delegacao ao BO)
671:     *==========================================================================
672:     PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
673:                             par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
674:         THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
675:         THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
676:         THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
677:         THIS.this_oBusinessObject.MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, ;
678:             par_sCartao, par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
679:         THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
680:             THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
681:     ENDPROC
682: 
683:     *==========================================================================
684:     * TxtDigitosGotFocus - Inicia sessao TEF ao focar GetDigitos
685:     * Migrado de: SIGPRDFT.GetDigitos.GotFocus (~231 linhas)
686:     *==========================================================================
687:     PROCEDURE TxtDigitosGotFocus()
688:         LOCAL loc_cIdTerminal, loc_cValPago, loc_cData, loc_cHora
689:         LOCAL loc_nRetorno, loc_nTipo
690:         LOCAL loc_lTipoVenda, loc_nTipoVenda, loc_cBandeira, loc_lContinua
691:         LOCAL loc_nCaixas, loc_cDateStr, loc_nEmp
692: 
693:         THIS.this_cNsu      = ""
694:         THIS.this_cAutoriza = ""
695:         THIS.this_cDataHora = ""
696:         THIS.this_cTipTran  = ""
697:         THIS.this_cCupomTef = ""
698:         THIS.this_cFinaliza = ""
699:         THIS.this_cMRet     = ""
700:         THIS.this_cMensagem = ""
701: 
702:         IF USED("crSigFiMpF") AND TYPE("crSigFiMpF.Cncaixas") = "N"
703:             loc_nCaixas = VAL(ALLTRIM(STR(crSigFiMpF.Cncaixas)))
704:         ELSE
705:             loc_nCaixas = 1
706:         ENDIF
707:         IF USED("crSigCdEmp") AND TYPE("crSigCdEmp.nEmps") = "N"
708:             loc_nEmp = crSigCdEmp.nEmps
709:         ELSE
710:             loc_nEmp = 0
711:         ENDIF
712:         loc_cIdTerminal = ALLTRIM(STR(loc_nEmp)) + TRANSFORM(loc_nCaixas, "@L 999999")
713: 
714:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nValPago, "99999999.99")), ".", ",")
715: 
716:         IF ConfiguraIntSiTefInterativo(THIS.this_oBusinessObject.this_cEndSiTef, ;
717:                                        loc_cIdTerminal, loc_cIdTerminal, 0) <> 0
718:             THIS.RetornoFalha("Sem comunicacao com SiTef", THIS.this_oBusinessObject.this_nValPago)
719:             THIS.Release()
720:             RETURN
721:         ENDIF
722: 
723:         loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
724:         loc_cHora = STRTRAN(TIME(), ":", "")
725: 
726:         IF IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_oBusinessObject.this_cCupom, ;
727:                                         loc_cData, loc_cHora, THIS.this_oBusinessObject.this_cCaixa, ;

*-- Linhas 747 a 824:
747:         loc_nTipoVenda        = 0
748:         loc_lContinua         = IIF(USED("crSigOpFp") AND crSigOpFp.lCartao = "N", .T., .F.)
749: 
750:         THIS.obj_4c_Optiongroup1.Enabled = .F.
751: 
752:         DO WHILE loc_lContinua
753:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
754:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
755:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
756:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
757: 
758:             IF LASTKEY() = 27
759:                 ContinuaFuncaoSiTefInterativo( ;
760:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
761:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
762:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
763:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
764:                                   THIS.this_oBusinessObject.this_nValPago)
765:                 THIS.Release()
766:                 RETURN
767:             ENDIF
768: 
769:             IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(THIS.this_cBuffer)
770:                 IF loc_nTipoVenda = 2
771:                     loc_lTipoVenda = .T.
772:                 ELSE
773:                     loc_nTipoVenda = 2
774:                 ENDIF
775:             ENDIF
776: 
777:             IF THIS.this_nProxCmd = 23
778:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
779:             ELSE
780:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
781:             ENDIF
782: 
783:             IF THIS.this_nProxCmd = 22 AND LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
784:                 MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
785:                          ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
786:                 ContinuaFuncaoSiTefInterativo( ;
787:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
788:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
789:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
790:                 loc_nRetorno = -1
791:                 EXIT
792:             ENDIF
793: 
794:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
795:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
796:             ENDIF
797: 
798:             IF loc_nRetorno = 0
799:                 EXIT
800:             ENDIF
801:             IF loc_nRetorno < 0
802:                 THIS.ErroTef(loc_nRetorno)
803:                 THIS.Release()
804:                 EXIT
805:             ENDIF
806: 
807:             IF THIS.this_nProxCmd = 3
808:                 THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
809:             ENDIF
810:             IF THIS.this_nTipoCampo = 100
811:                 THIS.this_cTipTran = THIS.this_cBuffer
812:                 THIS.this_cBuffer  = SPACE(2000)
813:                 THIS.this_nContinua = 0
814:                 LOOP
815:             ENDIF
816:             IF THIS.this_nTipoCampo = 105
817:                 THIS.this_cDataHora = THIS.this_cBuffer
818:                 THIS.this_cBuffer   = SPACE(2000)
819:                 LOOP
820:             ENDIF
821:             IF THIS.this_nTipoCampo = 121
822:                 THIS.this_cCupomTef = THIS.this_cBuffer
823:                 THIS.this_cBuffer   = SPACE(2000)
824:                 LOOP

*-- Linhas 923 a 1087:
923:                 THIS.this_cBuffer     = SPACE(2000)
924:                 THIS.this_nContinua   = 0
925:             ENDIF
926:         ENDDO
927: 
928:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
929: 
930:         IF loc_nRetorno < 0 OR THIS.this_lAbandonou
931:             THIS.Release()
932:             RETURN
933:         ENDIF
934: 
935:         IF !EMPTY(THIS.this_cNsu)
936:             THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, THIS.this_cCupomTef, ;
937:                 THIS.this_cBandeira, THIS.this_cNsu, THIS.this_cNsu, THIS.this_cFinaliza, ;
938:                 THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
939:             THIS.Release()
940:             RETURN
941:         ENDIF
942: 
943:         THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
944:         THIS.txt_4c_Cartao.Value      = "#### #### #### ####"
945: 
946:         IF loc_lTipoVenda
947:             IF !THIS.txt_4c_Text1.Enabled
948:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
949:                 THIS.txt_4c_Digitos.Enabled          = .F.
950:                 THIS.obj_4c_Optiongroup1.Enabled     = .T.
951:                 THIS.txt_4c_Datas.Enabled            = .T.
952:             ENDIF
953:         ELSE
954:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
955:             THIS.obj_4c_Optiongroup1.Enabled             = .T.
956:         ENDIF
957: 
958:         THIS.obj_4c_SAIDA.Enabled = .T.
959:     ENDPROC
960: 
961:     *==========================================================================
962:     * TxtDigitosKeyPress - Processa os 4 digitos ao pressionar Enter/Tab
963:     * Migrado de: SIGPRDFT.GetDigitos.Valid (~185 linhas)
964:     *==========================================================================
965:     PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
966: 
967:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
968:             RETURN
969:         ENDIF
970: 
971:         IF THIS.this_lAbandonou
972:             THIS.Release()
973:             RETURN
974:         ENDIF
975: 
976:         LOCAL loc_cVal, loc_nRetorno, loc_nCampo
977:         loc_cVal = ALLTRIM(THIS.txt_4c_Digitos.Value)
978: 
979:         IF LEN(loc_cVal) <> 4 AND !EMPTY(loc_cVal)
980:             MsgAviso("Quantidade de Digitos Invalida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
981:             THIS.txt_4c_Digitos.Value = ""
982:             RETURN
983:         ENDIF
984: 
985:         IF EMPTY(loc_cVal)
986:             RETURN
987:         ENDIF
988: 
989:         THIS.this_lParcelas = .F.
990:         THIS.this_cMensagem = ""
991:         THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 2000 - LEN(loc_cVal))
992:         THIS.this_nContinua = 1000
993:         loc_nRetorno        = 10000
994:         loc_nCampo          = 1
995: 
996:         DO WHILE loc_nRetorno = 10000
997:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
998:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
999:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1000:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1001: 
1002:             IF LASTKEY() = 27
1003:                 ContinuaFuncaoSiTefInterativo( ;
1004:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1005:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1006:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1007:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1008:                                   THIS.this_oBusinessObject.this_nValPago)
1009:                 THIS.Release()
1010:                 RETURN
1011:             ENDIF
1012: 
1013:             IF THIS.this_nProxCmd = 23
1014:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1015:             ELSE
1016:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1017:             ENDIF
1018: 
1019:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1020:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1021:             ENDIF
1022: 
1023:             IF loc_nRetorno = 0
1024:                 EXIT
1025:             ENDIF
1026:             IF loc_nRetorno < 0
1027:                 THIS.ErroTef(loc_nRetorno)
1028:                 THIS.Release()
1029:                 RETURN
1030:             ENDIF
1031: 
1032:             IF THIS.this_nProxCmd = 22
1033:                 MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1034:                          ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1035:                 ContinuaFuncaoSiTefInterativo( ;
1036:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1037:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1038:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1039:                 IF loc_nRetorno <> 10000
1040:                     EXIT
1041:                 ELSE
1042:                     IF THIS.this_lParcelas
1043:                         THIS.txt_4c_Text1.Enabled        = .T.
1044:                         THIS.obj_4c_Optiongroup1.Enabled = .F.
1045:                         THIS.txt_4c_Digitos.Value        = ""
1046:                         RETURN
1047:                     ELSE
1048:                         RETURN
1049:                     ENDIF
1050:                 ENDIF
1051:             ENDIF
1052: 
1053:             IF THIS.this_nProxCmd = 23
1054:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1055:             ELSE
1056:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1057:             ENDIF
1058: 
1059:             IF THIS.this_nProxCmd = 21
1060:                 THIS.this_cBuffer = IIF(THIS.this_oBusinessObject.this_nNumParcs = 1, ;
1061:                     IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), ;
1062:                     IIF(THIS.this_oBusinessObject.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
1063:                 IF THIS.this_cBuffer = "1"
1064:                     EXIT
1065:                 ENDIF
1066:                 THIS.this_lDCD      = .T.
1067:                 THIS.this_nContinua = 1000
1068:                 LOOP
1069:             ENDIF
1070: 
1071:             IF THIS.this_nProxCmd = 23
1072:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1073:             ENDIF
1074: 
1075:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
1076:                 THIS.this_cBuffer = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
1077:                     "1", "2") + REPLICATE(CHR(0), 1999)
1078:                 THIS.this_nContinua = 1000
1079:             ENDIF
1080: 
1081:             IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
1082:                 THIS.this_cSaque  = "0,00"
1083:                 THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
1084:                 THIS.this_nContinua = 1000
1085:                 LOOP
1086:             ENDIF
1087: 

*-- Linhas 1102 a 1122:
1102:                     EXIT
1103:                 ENDIF
1104:             ENDIF
1105: 
1106:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
1107:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1108:             ENDIF
1109: 
1110:             IF THIS.this_nProxCmd = 3
1111:                 THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
1112:             ENDIF
1113:             IF THIS.this_nTipoCampo = 100
1114:                 THIS.this_cTipTran = THIS.this_cBuffer
1115:             ENDIF
1116:             IF THIS.this_nTipoCampo = 105
1117:                 THIS.this_cDataHora = THIS.this_cBuffer
1118:             ENDIF
1119:             IF THIS.this_nTipoCampo = 121
1120:                 THIS.this_cCupomTef = THIS.this_cBuffer
1121:             ENDIF
1122:             IF THIS.this_nTipoCampo = 131

*-- Linhas 1162 a 1447:
1162:             THIS.Release()
1163:             RETURN
1164:         ENDIF
1165: 
1166:         IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 514
1167:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1168:         ELSE
1169:             IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND !THIS.this_lDCD
1170:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1171:                 THIS.obj_4c_Optiongroup1.Enabled             = .T.
1172:                 THIS.txt_4c_Datas.Enabled                    = .T.
1173:             ELSE
1174:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1175:             ENDIF
1176:         ENDIF
1177: 
1178:         THIS.txt_4c_Digitos.Enabled      = .F.
1179:         THIS.obj_4c_Optiongroup1.Enabled = .T.
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * TxtCartaoGotFocus - Foco no campo numero do cartao
1184:     * Garante que instrucao esteja visivel para cartao manual
1185:     *==========================================================================
1186:     PROCEDURE TxtCartaoGotFocus()
1187:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * OptGrupoInteractiveChange - Habilita GetDatas ao mudar tipo de venda
1192:     * Migrado de: SIGPRDFT.Optiongroup1.InteractiveChange
1193:     *==========================================================================
1194:     PROCEDURE OptGrupoInteractiveChange()
1195:         THIS.txt_4c_Datas.Enabled = .T.
1196:         IF THIS.obj_4c_Optiongroup1.Value = 1
1197:             THIS.txt_4c_Datas.Value = DATE()
1198:         ELSE
1199:             THIS.txt_4c_Datas.Value = CTOD("")
1200:         ENDIF
1201:     ENDPROC
1202: 
1203:     *==========================================================================
1204:     * OptGrupoOption1KeyPress - ENTER no Option1 simula TAB (avanca campo)
1205:     * Migrado de: SIGPRDFT.Optiongroup1.Option1.KeyPress
1206:     *==========================================================================
1207:     PROCEDURE OptGrupoOption1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1208:         IF par_nKeyCode = 13
1209:             KEYBOARD "{TAB}"
1210:         ENDIF
1211:     ENDPROC
1212: 
1213:     *==========================================================================
1214:     * OptGrupoOption1GotFocus - Habilita GetDatas ao focar Option1
1215:     * Migrado de: SIGPRDFT.Optiongroup1.Option1.GotFocus
1216:     *==========================================================================
1217:     PROCEDURE OptGrupoOption1GotFocus()
1218:         THIS.txt_4c_Datas.Enabled = .T.
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * TxtText1GotFocus - Define tvenda=.F. ao entrar em parcelas
1223:     * Migrado de: SIGPRDFT.Text1.GotFocus
1224:     *==========================================================================
1225:     PROCEDURE TxtText1GotFocus()
1226:         THIS.this_lTvenda = .F.
1227:     ENDPROC
1228: 
1229:     *==========================================================================
1230:     * TxtText1KeyPress - Processa numero de parcelas ao pressionar Enter/Tab
1231:     * Migrado de: SIGPRDFT.Text1.Valid
1232:     *==========================================================================
1233:     PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1234: 
1235:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1236:             RETURN
1237:         ENDIF
1238: 
1239:         IF EMPTY(THIS.txt_4c_Text1.Value)
1240:             RETURN
1241:         ENDIF
1242: 
1243:         LOCAL loc_cVal, loc_nRetorno
1244:         loc_cVal = ALLTRIM(THIS.txt_4c_Text1.Value)
1245: 
1246:         THIS.this_nParcs    = VAL(loc_cVal)
1247:         THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 1990)
1248:         THIS.this_nContinua = 1000
1249: 
1250:         loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1251:             @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1252:             @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1253:             @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1254: 
1255:         IF THIS.this_nProxCmd = 23
1256:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1257:         ELSE
1258:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1259:         ENDIF
1260: 
1261:         IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1262:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1263:         ENDIF
1264: 
1265:         IF THIS.this_nProxCmd = 22
1266:             MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1267:                      ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1268:             ContinuaFuncaoSiTefInterativo( ;
1269:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1270:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1271:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1272:             RETURN
1273:         ENDIF
1274: 
1275:         THIS.this_cBuffer   = ""
1276:         THIS.this_nContinua = 0
1277:     ENDPROC
1278: 
1279:     *==========================================================================
1280:     * TxtText1LostFocus - Formata parcelas, desabilita campo e habilita GetDatas
1281:     * Migrado de: SIGPRDFT.Text1.LostFocus
1282:     *==========================================================================
1283:     PROCEDURE TxtText1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1284:         THIS.txt_4c_Text1.Value    = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
1285:         THIS.txt_4c_Text1.Enabled  = .F.
1286:         THIS.txt_4c_Datas.Enabled  = .T.
1287:     ENDPROC
1288: 
1289:     *==========================================================================
1290:     * TxtDatasGotFocus - Processa estado TEF ao entrar no campo de data
1291:     * Migrado de: SIGPRDFT.GetDatas.GotFocus (~188 linhas)
1292:     *==========================================================================
1293:     PROCEDURE TxtDatasGotFocus()
1294:         LOCAL loc_nRetorno, loc_cDateStr, loc_oErro
1295: 
1296:         THIS.this_lTvenda   = .F.
1297:         THIS.this_cTipTran  = ""
1298:         THIS.this_cDataHora = ""
1299:         THIS.this_cCupomTef = ""
1300:         THIS.this_cCartao   = ""
1301:         THIS.this_cNsu      = ""
1302:         THIS.this_cAutoriza = ""
1303:         THIS.this_cFinaliza = ""
1304:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1305:         THIS.this_cMRet     = ""
1306: 
1307:         IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND ;
1308:            !THIS.this_lDCD AND ;
1309:            USED("crSigOpFp") AND crSigOpFp.Tcdc <> "S"
1310: 
1311:             loc_nRetorno        = 10000
1312:             THIS.this_cMensagem = ""
1313: 
1314:             IF THIS.obj_4c_Optiongroup1.Enabled
1315:                 THIS.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
1316:             ELSE
1317:                 DO WHILE THIS.this_nProxCmd <> 30
1318:                     loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1319:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1320:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1321:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1322:                     IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1323:                         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1324:                     ENDIF
1325:                     IF THIS.this_nProxCmd = 23
1326:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1327:                     ELSE
1328:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1329:                     ENDIF
1330:                     IF loc_nRetorno < 0
1331:                         THIS.ErroTef(loc_nRetorno)
1332:                         THIS.Release()
1333:                         RETURN
1334:                     ENDIF
1335:                 ENDDO
1336:                 THIS.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + REPLICATE(CHR(0), 1998)
1337:             ENDIF
1338: 
1339:             THIS.this_nContinua   = 1000
1340:             THIS.this_cAutoriza   = ""
1341: 
1342:             DO WHILE loc_nRetorno = 10000
1343:                 loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1344:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1345:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1346:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1347: 
1348:                 IF LASTKEY() = 27
1349:                     ContinuaFuncaoSiTefInterativo( ;
1350:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1351:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1352:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1353:                     THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1354:                                       THIS.this_oBusinessObject.this_nValPago)
1355:                     THIS.Release()
1356:                     RETURN
1357:                 ENDIF
1358: 
1359:                 IF THIS.this_nProxCmd = 23
1360:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1361:                 ELSE
1362:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1363:                 ENDIF
1364:                 IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1365:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1366:                 ENDIF
1367:                 IF loc_nRetorno < 0
1368:                     THIS.ErroTef(loc_nRetorno)
1369:                     THIS.Release()
1370:                     RETURN
1371:                 ENDIF
1372: 
1373:                 IF THIS.this_nProxCmd = 22
1374:                     MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1375:                              ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1376:                     IF "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1377:                         ContinuaFuncaoSiTefInterativo( ;
1378:                             @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1379:                             @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1380:                             @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1381:                         loc_nRetorno = -8
1382:                         EXIT
1383:                     ENDIF
1384:                     ContinuaFuncaoSiTefInterativo( ;
1385:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1386:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1387:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1388:                     IF loc_nRetorno <> 10000
1389:                         THIS.Release()
1390:                         RETURN
1391:                     ELSE
1392:                         RETURN
1393:                     ENDIF
1394:                     IF THIS.this_nProxCmd = 23
1395:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1396:                     ELSE
1397:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1398:                     ENDIF
1399:                 ENDIF
1400: 
1401:                 IF loc_nRetorno < 0
1402:                     THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
1403:                                          THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
1404:                     EXIT
1405:                 ENDIF
1406: 
1407:                 IF THIS.this_nProxCmd = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
1408:                     IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
1409:                         THIS.this_cBuffer   = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
1410:                             "1", "2") + REPLICATE(CHR(0), 1999)
1411:                         THIS.this_nContinua = 1000
1412:                         LOOP
1413:                     ENDIF
1414:                     EXIT
1415:                 ENDIF
1416: 
1417:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 506
1418:                     loc_cDateStr = DTOC(THIS.txt_4c_Datas.Value)
1419:                     THIS.this_cBuffer = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
1420:                                         ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
1421:                                         ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
1422:                     THIS.this_nContinua = 1000
1423:                     LOOP
1424:                 ENDIF
1425:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 505
1426:                     THIS.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
1427:                     THIS.this_nContinua = 1000
1428:                     LOOP
1429:                 ENDIF
1430:                 IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 507
1431:                     IF MsgConfirma("Primeira Parcela A Vista")
1432:                         THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1433:                     ELSE
1434:                         THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1435:                     ENDIF
1436:                     THIS.this_nContinua = 1000
1437:                     LOOP
1438:                 ENDIF
1439:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 508
1440:                     THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.Dias)), "0") + REPLICATE(CHR(0), 1998)
1441:                     THIS.this_nContinua = 1000
1442:                     LOOP
1443:                 ENDIF
1444:                 IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 509
1445:                     THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.MesFec - 1)), "0") + REPLICATE(CHR(0), 1999)
1446:                     THIS.this_nContinua = 1000
1447:                     LOOP

*-- Linhas 1454 a 1474:
1454:                 ENDIF
1455:                 IF loc_nRetorno <> 0
1456:                     THIS.this_cFinaliza = THIS.this_cBuffer
1457:                 ENDIF
1458:                 IF UPPER(ALLTRIM(THIS.this_cBuffer)) $ "DIGITE A SENHA"
1459:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1460:                 ENDIF
1461:                 IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
1462:                     THIS.this_cSaque  = "0,00"
1463:                     THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
1464:                     THIS.this_nContinua = 1000
1465:                     LOOP
1466:                 ENDIF
1467:                 IF THIS.this_nProxCmd = 3
1468:                     THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
1469:                 ENDIF
1470:                 IF THIS.this_nTipoCampo = 100
1471:                     THIS.this_cTipTran = THIS.this_cBuffer
1472:                 ENDIF
1473:                 IF THIS.this_nTipoCampo = 105
1474:                     THIS.this_cDataHora = THIS.this_cBuffer

*-- Linhas 1505 a 1576:
1505:                         THIS.this_cAutoriza, THIS.this_cFinaliza, ;
1506:                         THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
1507:                     THIS.Release()
1508:                 ENDIF
1509:             ENDIF
1510:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1511:         ENDIF
1512:     ENDPROC
1513: 
1514:     *==========================================================================
1515:     * TxtDatasKeyPress - Processa data de vencimento ao pressionar Enter/Tab
1516:     * Migrado de: SIGPRDFT.GetDatas.Valid (~183 linhas)
1517:     *==========================================================================
1518:     PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1519: 
1520:         IF par_nKeyCode = 27
1521:             RETURN
1522:         ENDIF
1523: 
1524:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1525:             RETURN
1526:         ENDIF
1527: 
1528:         LOCAL loc_ldData, loc_nRetorno, loc_cDateStr
1529: 
1530:         loc_ldData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
1531:         THIS.txt_4c_Datas.Value = loc_ldData
1532:         THIS.this_dData         = loc_ldData
1533: 
1534:         IF THIS.obj_4c_Optiongroup1.Value = 2 AND THIS.txt_4c_Datas.Value <= DATE() AND ;
1535:            !EMPTY(THIS.txt_4c_Datas.Value)
1536:             MsgAviso("Data Inv" + CHR(225) + "lida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
1537:             RETURN
1538:         ENDIF
1539: 
1540:         DO WHILE THIS.this_nProxCmd <> 30
1541:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1542:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1543:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1544:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1545:             IF THIS.this_nProxCmd = 23
1546:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1547:             ELSE
1548:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1549:             ENDIF
1550:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1551:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1552:             ENDIF
1553:             IF loc_nRetorno < 0
1554:                 THIS.ErroTef(loc_nRetorno)
1555:                 THIS.Release()
1556:                 RETURN
1557:             ENDIF
1558:         ENDDO
1559: 
1560:         LOCAL loc_nPrimo
1561:         loc_nPrimo          = 1
1562:         THIS.this_cAutoriza = ""
1563:         loc_nRetorno        = 10000
1564:         THIS.this_cMensagem = ""
1565:         loc_cDateStr        = DTOC(THIS.txt_4c_Datas.Value)
1566:         THIS.this_cBuffer   = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
1567:                               ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
1568:                               ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
1569:         THIS.this_nContinua = 1000
1570:         THIS.this_cAutoriza = ""
1571:         THIS.this_nCiclos   = 0
1572: 
1573:         DO WHILE loc_nRetorno = 10000
1574:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1575:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1576:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;

*-- Linhas 1591 a 1653:
1591:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1592:             ELSE
1593:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1594:             ENDIF
1595:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1596:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1597:             ENDIF
1598:             IF loc_nRetorno < 0
1599:                 THIS.ErroTef(loc_nRetorno)
1600:                 THIS.Release()
1601:                 RETURN
1602:             ENDIF
1603: 
1604:             IF THIS.this_nProxCmd = 22
1605:                 IF THIS.this_oBusinessObject.this_cDebCred <> "P"
1606:                     IF LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
1607:                         LOCAL loc_cMsg22
1608:                         loc_cMsg22 = IIF(UPPER(ALLTRIM(THIS.this_cBuffer)) = "AGUARDE, EM PROCESSAMENTO", ;
1609:                             "TRANSACAO CANCELADA", ALLTRIM(THIS.this_cBuffer))
1610:                         MsgAviso(loc_cMsg22, "Erro na Transa" + CHR(231) + CHR(227) + "o")
1611:                         IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1612:                             ContinuaFuncaoSiTefInterativo( ;
1613:                                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1614:                                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1615:                                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1616:                             loc_nRetorno = -8
1617:                             EXIT
1618:                         ENDIF
1619:                         RETURN
1620:                     ELSE
1621:                         loc_nRetorno = 0
1622:                         EXIT
1623:                     ENDIF
1624:                 ELSE
1625:                     THIS.this_cCupomTef = ALLTRIM(THIS.this_cBuffer)
1626:                     loc_nRetorno = -1
1627:                     EXIT
1628:                 ENDIF
1629:             ENDIF
1630: 
1631:             IF loc_nRetorno <> 10000
1632:                 THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
1633:                                       THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
1634:                 EXIT
1635:             ENDIF
1636: 
1637:             IF THIS.this_nProxCmd = 23
1638:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1639:             ENDIF
1640: 
1641:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 500
1642:                 MsgInfo("Senha solicitada - terminal de senha necessario")
1643:                 THIS.RetornoFalha("Operacao Cancelada pelo Usuario", THIS.this_oBusinessObject.this_nValPago)
1644:                 loc_nRetorno = -2
1645:                 EXIT
1646:             ENDIF
1647: 
1648:             IF UPPER(THIS.this_cBuffer) = "ASSUME GARANTIA" AND loc_nPrimo = 1
1649:                 IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?")
1650:                     THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1651:                 ELSE
1652:                     THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1653:                 ENDIF

*-- Linhas 1727 a 2124:
1727:     * TxtDatasLostFocus - Restaura comportamento de confirmacao normal
1728:     * Migrado de: SIGPRDFT.GetDatas.LostFocus
1729:     *==========================================================================
1730:     PROCEDURE TxtDatasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1731:         SET CONFIRM ON
1732:     ENDPROC
1733: 
1734:     *==========================================================================
1735:     * TornarControlesVisiveis - Recursivo: torna todos os controles visiveis
1736:     *==========================================================================
1737:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1738:         LOCAL loc_i, loc_oControl
1739:         FOR loc_i = 1 TO par_oContainer.ControlCount
1740:             loc_oControl = par_oContainer.Controls(loc_i)
1741:             IF VARTYPE(loc_oControl) = "O"
1742:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1743:                     loc_oControl.Visible = .T.
1744:                 ENDIF
1745:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1746:                     THIS.TornarControlesVisiveis(loc_oControl)
1747:                 ENDIF
1748:             ENDIF
1749:         ENDFOR
1750:     ENDPROC
1751: 
1752:     *==========================================================================
1753:     * ConfigurarPaginaLista - Compat CRUD para dialogo OPERACIONAL flat
1754:     * Form SiTef nao possui Page1=Lista/Page2=Dados. Metodo mantido para
1755:     * compatibilidade com a arquitetura CRUD e delega a montagem visual
1756:     * (Cabecalho, botao Cancelar, campos TEF e Container1 de mensagens) para
1757:     * ConfigurarPageFrame + ConfigurarConteudo. Idempotente: so remonta se
1758:     * o Container1 (marcador de conteudo montado) ainda nao existe.
1759:     *==========================================================================
1760:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1761:         IF !PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1762:             THIS.ConfigurarPageFrame()
1763:             THIS.ConfigurarConteudo()
1764:             THIS.InicializarValoresIniciais()
1765:             THIS.TornarControlesVisiveis(THIS)
1766:         ENDIF
1767:     ENDPROC
1768: 
1769:     *==========================================================================
1770:     * ConfigurarPaginaDados - Compat CRUD para dialogo OPERACIONAL flat
1771:     * Form SiTef nao possui Page2/Dados separada. Todos os controles de
1772:     * entrada (Valor, Cartao, Digitos, OptionGroup, Parcelas, Data, Instrucao)
1773:     * estao em ConfigurarConteudo() com layout plano flat identico ao legado.
1774:     * Controles mapeados (mapeamento.json):
1775:     *   txt_4c_Valor      - GetValor  (valor da transacao, read-only)
1776:     *   txt_4c_Cartao     - GetCartao (numero do cartao, 19 digitos)
1777:     *   txt_4c_Digitos    - GetDigitos (4 ultimos digitos, inicia sessao TEF)
1778:     *   obj_4c_Optiongroup1 - Optiongroup1 (A vista / Predatado)
1779:     *   txt_4c_Text1      - Text1 (numero de parcelas)
1780:     *   txt_4c_Datas      - GetDatas (data 1a parcela / vencimento)
1781:     *   cnt_4c_Container1 - Container1 (instrucao dinamica ao usuario)
1782:     * Metodo mantido por compatibilidade com a arquitetura FormBase CRUD.
1783:     *==========================================================================
1784:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1785:         RETURN .T.
1786:     ENDPROC
1787: 
1788:     *==========================================================================
1789:     * AlternarPagina - Alterna mensagem do Container1 conforme fase da transacao
1790:     * Form SiTef flat sem PageFrame: reproduz o comportamento do legado que
1791:     * alterava Container1.Label1.Caption durante o fluxo TEF (GetCartao ->
1792:     * GetDigitos -> Senha -> Datas -> Autorizacao). par_nPagina indica a fase.
1793:     *==========================================================================
1794:     PROCEDURE AlternarPagina(par_nPagina)
1795:         LOCAL loc_cMsg
1796:         DO CASE
1797:             CASE par_nPagina = 1
1798:                 loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
1799:             CASE par_nPagina = 2
1800:                 loc_cMsg = "Digite os 4 " + CHR(250) + "ltimos d" + CHR(237) + "gitos"
1801:             CASE par_nPagina = 3
1802:                 loc_cMsg = "Digite a Senha"
1803:             CASE par_nPagina = 4
1804:                 loc_cMsg = "Digite a Data" + CHR(13) + "de Vencimento"
1805:             CASE par_nPagina = 5
1806:                 loc_cMsg = "Aguarde autoriza" + CHR(231) + CHR(227) + "o..."
1807:             OTHERWISE
1808:                 loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
1809:         ENDCASE
1810:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5) AND ;
1811:            PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
1812:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = loc_cMsg
1813:             THIS.cnt_4c_Container1.lbl_4c_Label1.Refresh()
1814:         ENDIF
1815:     ENDPROC
1816: 
1817:     *==========================================================================
1818:     * BtnIncluirClick - Inicia nova sess" + CHR(227) + "o TEF
1819:     * Form OPERACIONAL: "Incluir" equivale a reiniciar o fluxo TEF
1820:     * Posiciona foco em GetDigitos que via GotFocus inicia ConfiguraIntSiTefInterativo
1821:     *==========================================================================
1822:     PROCEDURE BtnIncluirClick()
1823:         LOCAL loc_oErro
1824:         TRY
1825:             THIS.this_lAbandonou = .F.
1826:             THIS.this_cBuffer    = SPACE(2000)
1827:             THIS.this_nContinua  = 0
1828:             THIS.this_nCiclos    = 0
1829:             THIS.this_cResultado = ""
1830:             THIS.txt_4c_Digitos.Value   = ""
1831:             THIS.txt_4c_Digitos.Enabled = .T.
1832:             THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
1833:             THIS.txt_4c_Digitos.SetFocus()
1834:         CATCH TO loc_oErro
1835:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1836:         ENDTRY
1837:     ENDPROC
1838: 
1839:     *==========================================================================
1840:     * BtnAlterarClick - Continua fluxo TEF a partir do proximo campo ativo
1841:     * Form OPERACIONAL: "Alterar" = retomar transacao em andamento
1842:     * Direciona para GetDatas (data vencimento) se habilitado, caso contrario
1843:     * para Text1 (parcelas), mantendo o estado SiTef atual
1844:     *==========================================================================
1845:     PROCEDURE BtnAlterarClick()
1846:         LOCAL loc_oErro
1847:         TRY
1848:             IF THIS.txt_4c_Datas.Enabled
1849:                 THIS.txt_4c_Datas.SetFocus()
1850:             ELSE
1851:                 IF THIS.txt_4c_Text1.Enabled
1852:                 THIS.txt_4c_Text1.SetFocus()
1853:             ELSE
1854:                 IF THIS.txt_4c_Digitos.Enabled
1855:                 THIS.txt_4c_Digitos.SetFocus()
1856:                 ENDIF
1857:                 ENDIF
1858:             ENDIF
1859:         CATCH TO loc_oErro
1860:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1861:         ENDTRY
1862:     ENDPROC
1863: 
1864:     *==========================================================================
1865:     * BtnVisualizarClick - Exibe resultado da transa" + CHR(231) + CHR(227) + "o TEF atual
1866:     * Form OPERACIONAL: "Visualizar" = consultar estado/resultado da sess" + CHR(227) + "o
1867:     * Exibe this_cResultado se j" + CHR(225) + " foi gerado, ou informa aguardando
1868:     *==========================================================================
1869:     PROCEDURE BtnVisualizarClick()
1870:         LOCAL loc_oErro, loc_cMsg
1871:         TRY
1872:             IF !EMPTY(THIS.this_cResultado)
1873:                 MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado")
1874:             ELSE
1875:                 IF !EMPTY(THIS.this_cMensagem)
1876:                 MsgInfo("Mensagem SiTef: " + THIS.this_cMensagem, "SiTef")
1877:             ELSE
1878:                 MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento.", "SiTef")
1879:                 ENDIF
1880:             ENDIF
1881:         CATCH TO loc_oErro
1882:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1883:         ENDTRY
1884:     ENDPROC
1885: 
1886:     *==========================================================================
1887:     * BtnExcluirClick - Cancela transa" + CHR(231) + CHR(227) + "o TEF e fecha o di" + CHR(225) + "logo
1888:     * Form OPERACIONAL: "Excluir" equivale ao bot" + CHR(227) + "o Cancelar do original
1889:     * Delega para BtnCancelaClick que invoca ContinuaFuncaoSiTefInterativo(-1)
1890:     *==========================================================================
1891:     PROCEDURE BtnExcluirClick()
1892:         LOCAL loc_oErro
1893:         TRY
1894:             THIS.BtnCancelaClick()
1895:         CATCH TO loc_oErro
1896:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
1897:         ENDTRY
1898:     ENDPROC
1899: 
1900:     *==========================================================================
1901:     * BtnBuscarClick - Exibe status da transacao TEF (form OPERACIONAL flat)
1902:     * Form SiTef: "Buscar" consulta estado corrente do fluxo TEF
1903:     *==========================================================================
1904:     PROCEDURE BtnBuscarClick()
1905:         LOCAL loc_oErro
1906:         TRY
1907:             IF !EMPTY(THIS.this_cResultado)
1908:                 MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado TEF")
1909:             ELSE
1910:                 IF !EMPTY(THIS.this_cMensagem)
1911:                 MsgInfo("Status SiTef: " + THIS.this_cMensagem, "SiTef")
1912:             ELSE
1913:                 MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento." + CHR(13) + ;
1914:                         "Preencha os campos solicitados.", "SiTef")
1915:                 ENDIF
1916:             ENDIF
1917:         CATCH TO loc_oErro
1918:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1919:         ENDTRY
1920:     ENDPROC
1921: 
1922:     *==========================================================================
1923:     * BtnEncerrarClick - Encerra o dialogo TEF e cancela transacao em curso
1924:     * Padrao canonico do sistema novo: delega para BtnCancelaClick
1925:     *==========================================================================
1926:     PROCEDURE BtnEncerrarClick()
1927:         LOCAL loc_oErro
1928:         TRY
1929:             THIS.BtnCancelaClick()
1930:         CATCH TO loc_oErro
1931:             MsgErro(loc_oErro.Message, "Erro BtnEncerrarClick")
1932:         ENDTRY
1933:     ENDPROC
1934: 
1935:     *==========================================================================
1936:     * BtnSalvarClick - Confirma dados e avanca no fluxo TEF
1937:     * Form OPERACIONAL: sincroniza BO e foca proximo campo ativo
1938:     *==========================================================================
1939:     PROCEDURE BtnSalvarClick()
1940:         LOCAL loc_oErro
1941:         TRY
1942:             THIS.FormParaBO()
1943:             IF THIS.txt_4c_Digitos.Enabled
1944:                 THIS.txt_4c_Digitos.SetFocus()
1945:             ELSE
1946:                 IF THIS.txt_4c_Text1.Enabled
1947:                 THIS.txt_4c_Text1.SetFocus()
1948:             ELSE
1949:                 IF THIS.txt_4c_Datas.Enabled
1950:                 THIS.txt_4c_Datas.SetFocus()
1951:                 ENDIF
1952:                 ENDIF
1953:             ENDIF
1954:         CATCH TO loc_oErro
1955:             MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
1956:         ENDTRY
1957:     ENDPROC
1958: 
1959:     *==========================================================================
1960:     * BtnCancelarClick - Cancela transacao TEF e fecha o dialogo
1961:     * Alias de BtnCancelaClick para compatibilidade com arquitetura FormBase
1962:     *==========================================================================
1963:     PROCEDURE BtnCancelarClick()
1964:         LOCAL loc_oErro
1965:         TRY
1966:             THIS.BtnCancelaClick()
1967:         CATCH TO loc_oErro
1968:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
1969:         ENDTRY
1970:     ENDPROC
1971: 
1972:     *==========================================================================
1973:     * FormParaBO - Sincroniza controles visuais para o Business Object
1974:     * Form OPERACIONAL TEF: parcelas, data, bandeira e cartao
1975:     *==========================================================================
1976:     PROCEDURE FormParaBO()
1977:         LOCAL loc_oErro
1978:         TRY
1979:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1980:                 THIS.this_oBusinessObject.this_nNumParcs = IIF(EMPTY(THIS.txt_4c_Text1.Value), ;
1981:                     0, VAL(ALLTRIM(THIS.txt_4c_Text1.Value)))
1982:                 THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
1983:                 THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
1984:                 THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
1985:                 THIS.this_oBusinessObject.this_dData     = IIF(!EMPTY(THIS.txt_4c_Datas.Value), ;
1986:                     THIS.txt_4c_Datas.Value, DATE())
1987:             ENDIF
1988:         CATCH TO loc_oErro
1989:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
1990:         ENDTRY
1991:     ENDPROC
1992: 
1993:     *==========================================================================
1994:     * BOParaForm - Sincroniza Business Object para controles visuais
1995:     * Form OPERACIONAL TEF: carrega valor, parcelas e data do BO
1996:     *==========================================================================
1997:     PROCEDURE BOParaForm()
1998:         LOCAL loc_oErro
1999:         TRY
2000:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2001:                 THIS.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValPago
2002:                 IF THIS.this_oBusinessObject.this_nNumParcs > 0
2003:                     THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
2004:                 ELSE
2005:                     THIS.txt_4c_Text1.Value = ""
2006:                 ENDIF
2007:                 THIS.txt_4c_Datas.Value = IIF(!EMPTY(THIS.this_dData), THIS.this_dData, DATE())
2008:             ENDIF
2009:         CATCH TO loc_oErro
2010:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
2011:         ENDTRY
2012:     ENDPROC
2013: 
2014:     *==========================================================================
2015:     * HabilitarCampos - Habilita/desabilita campos conforme fase TEF
2016:     * par_lHabilitar=.T. reseta para estado inicial (digitos ativos)
2017:     *==========================================================================
2018:     PROCEDURE HabilitarCampos(par_lHabilitar)
2019:         LOCAL loc_oErro
2020:         TRY
2021:             THIS.txt_4c_Digitos.Enabled = par_lHabilitar
2022:             IF par_lHabilitar
2023:                 THIS.txt_4c_Datas.Enabled            = .F.
2024:                 THIS.txt_4c_Text1.Enabled             = .F.
2025:                 THIS.obj_4c_Optiongroup1.Enabled      = .F.
2026:             ENDIF
2027:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = par_lHabilitar
2028:         CATCH TO loc_oErro
2029:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
2030:         ENDTRY
2031:     ENDPROC
2032: 
2033:     *==========================================================================
2034:     * LimparCampos - Reseta todos os campos e estado TEF para nova transacao
2035:     *==========================================================================
2036:     PROCEDURE LimparCampos()
2037:         LOCAL loc_oErro
2038:         TRY
2039:             THIS.txt_4c_Digitos.Value              = ""
2040:             THIS.txt_4c_Cartao.Value               = ""
2041:             THIS.txt_4c_Text1.Value                = ""
2042:             THIS.txt_4c_Datas.Value                = DATE()
2043:             THIS.this_cBandeira                    = "00000"
2044:             THIS.this_cCartao                      = "00000"
2045:             THIS.this_cNsu                         = ""
2046:             THIS.this_cAutoriza                    = ""
2047:             THIS.this_cDataHora                    = ""
2048:             THIS.this_cTipTran                     = ""
2049:             THIS.this_cCupomTef                    = ""
2050:             THIS.this_cFinaliza                    = ""
2051:             THIS.this_cMRet                        = ""
2052:             THIS.this_cMensagem                    = ""
2053:             THIS.this_cResultado                   = ""
2054:             THIS.this_cBuffer                      = SPACE(2000)
2055:             THIS.this_nContinua                    = 0
2056:             THIS.this_nProxCmd                     = 0
2057:             THIS.this_nTipoCampo                   = 0
2058:             THIS.this_nTamMin                      = 0
2059:             THIS.this_nTamMax                      = 0
2060:             THIS.this_nCiclos                      = 0
2061:             THIS.this_lAbandonou                   = .F.
2062:             THIS.this_lParcelas                    = .F.
2063:             THIS.this_lDCD                         = .F.
2064:             THIS.obj_4c_Optiongroup1.Value         = 1
2065:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
2066:         CATCH TO loc_oErro
2067:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
2068:         ENDTRY
2069:     ENDPROC
2070: 
2071:     *==========================================================================
2072:     * CarregarLista - Compatibilidade FormBase: dialogo TEF nao tem lista
2073:     * Retorna .T. (sem carregamento de dados tabulares neste dialogo flat)
2074:     *==========================================================================
2075:     PROCEDURE CarregarLista()
2076:         RETURN .T.
2077:     ENDPROC
2078: 
2079:     *==========================================================================
2080:     * AjustarBotoesPorModo - Ajusta botao Cancelar conforme estado TEF
2081:     * ProxCmd=23 (PIN/Senha): desabilita Cancelar; outros estados: habilita
2082:     *==========================================================================
2083:     PROCEDURE AjustarBotoesPorModo()
2084:         LOCAL loc_oErro
2085:         TRY
2086:             IF THIS.this_nProxCmd = 23
2087:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
2088:             ELSE
2089:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
2090:             ENDIF
2091:         CATCH TO loc_oErro
2092:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
2093:         ENDTRY
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * Destroy - Libera recursos ao fechar o dialogo
2098:     *==========================================================================
2099:     PROCEDURE Destroy()
2100:         LOCAL loc_oErro
2101:         TRY
2102:             IF EMPTY(THIS.this_cResultado)
2103:                 THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
2104:                     THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
2105:             ENDIF
2106:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2107:                 THIS.this_oBusinessObject = .NULL.
2108:             ENDIF
2109:             IF USED("crSigOpFp")
2110:                 USE IN crSigOpFp
2111:             ENDIF
2112:             IF USED("crSigCdEmp")
2113:                 USE IN crSigCdEmp
2114:             ENDIF
2115:             IF USED("crSiTef")
2116:                 USE IN crSiTef
2117:             ENDIF
2118:         CATCH TO loc_oErro
2119:             *-- Silencioso: Destroy nao deve abrir dialogs (pode causar erros em cascata)
2120:         ENDTRY
2121:         DODEFAULT()
2122:     ENDPROC
2123: 
2124: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para integracao SiTef (Cartao de Debito)
* Form original: SIGPRDFT.SCX
* Tipo: OPERACIONAL - dialogo modal de transacao TEF
*==============================================================================
DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Identificacao da entidade (sem tabela CRUD - form operacional)
    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Parametros de inicializacao recebidos via Init do form
    this_cEndSiTef   = ""
    this_nValPago    = 0
    this_cCupom      = ""
    this_cCaixa      = ""
    this_cDebCred    = ""
    this_cTipPagto   = ""
    this_nNumParcs   = 0
    this_cIdent      = ""
    this_cOpers      = ""

    *-- Dados retornados pelo SiTef apos a transacao
    this_cBandeira   = ""
    this_cCartao     = ""
    this_cNsu        = ""
    this_cAutoriza   = ""
    this_cDataHora   = ""
    this_cTipTran    = ""
    this_cFinaliza   = ""
    this_cMsgRetorno = ""

    *-- Flags e estado da transacao
    this_lAbandonou  = .F.
    this_lDCD        = .F.
    this_cSaqueValor = ""
    this_nParcelas   = 0

    *-- Dados do terminal calculados em runtime
    this_cIdTerminal = ""
    this_cValorStr   = ""

    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Override obrigatorio de BusinessBase
    * Form OPERACIONAL (dialogo SiTef) nao possui tabela CRUD. Os dados
    * persistidos sao os arquivos IntPos.001/IntPos.STS gerados por
    * MontaRetorno/RetornoFalha, portanto este metodo eh no-op.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                IF TYPE(par_cAliasCursor + ".ValPago") = "N"
                    THIS.this_nValPago = NVL(&par_cAliasCursor..ValPago, 0)
                ENDIF
                IF TYPE(par_cAliasCursor + ".Cupom") = "C"
                    THIS.this_cCupom = NVL(&par_cAliasCursor..Cupom, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Caixa") = "C"
                    THIS.this_cCaixa = NVL(&par_cAliasCursor..Caixa, "")
                ENDIF
                IF TYPE(par_cAliasCursor + ".Ident") = "C"
                    THIS.this_cIdent = NVL(&par_cAliasCursor..Ident, "")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarDoCursor SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. A persistencia ocorre via arquivos IntPos.001/
    * IntPos.STS gerados por MontaRetorno() apos a transacao SiTef ter
    * sucesso. Este metodo apenas registra a auditoria da operacao.
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("INSERT_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Inserir SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Override de BusinessBase para form OPERACIONAL (SiTef)
    * Nao ha tabela CRUD. Transacoes SiTef nao sao atualizadas apos
    * confirmacao (o protocolo TEF eh append-only). Este metodo apenas
    * registra a auditoria caso seja chamado.
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        TRY
            THIS.RegistrarAuditoria("UPDATE_TEF")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro Atualizar SiTef")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoria - Registra auditoria da transacao SiTef em LogAuditoria
    * Override que grava informacoes relevantes da transacao mesmo sem tabela
    * de destino (usa NSU + autorizacao como chave logica).
    *==========================================================================
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lOk, loc_oErro

        loc_lOk = .T.
        TRY
            loc_cChave   = ALLTRIM(THIS.this_cNsu) + "|" + ALLTRIM(THIS.this_cAutoriza)
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ALLTRIM(gc_4c_UsuarioLogado), "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Operacao, Tabela, ChavePrimaria, Detalhes) " + ;
                       "VALUES (" + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(loc_cUsuario, 50)) + ", " + ;
                       EscaparSQL(LEFT(par_cOperacao, 20)) + ", " + ;
                       EscaparSQL("SIGPRDFT_SITEF") + ", " + ;
                       EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                       EscaparSQL(LEFT("Valor=" + TRANSFORM(THIS.this_nValPago, "@$ 999,999.99") + ;
                                       " Cupom=" + ALLTRIM(THIS.this_cCupom) + ;
                                       " Bandeira=" + ALLTRIM(THIS.this_cBandeira), 500)) + ;
                       ")"

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
                    loc_lOk = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lOk = .F.
        ENDTRY
        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * InicializarDLLs - Declara funcoes da DLL CliSiTef32I
    * Migrado de: SIGPRDFT.Load
    *==========================================================================
    PROCEDURE InicializarDLLs()
        LOCAL loc_oErro
        TRY
            DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
            DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnModalidade, String lsValor, String lsCupom, ;
                String lsData, String lsHorario, String lsOperador, String lsRestricao
            DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer @lnComando, Integer @lnTipo, Integer @lnMinimo, Integer @lnMaximo, ;
                String @lsBuffer, Integer lnTamanho, Integer lnResultado
            DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                Integer lnConfirma, String lsCupom, String lsData, String lsHorario
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro DLL SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo protocolo SiTef
    * Migrado de: SIGPRDFT.errotef
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_cMsgPadrao
        loc_cMsgPadrao = "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio"

        IF TYPE("par_nRetorno") <> "N"
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        IF par_nRetorno > -1 OR par_nRetorno < -5
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
            RETURN
        ENDIF

        DO CASE
        CASE par_nRetorno = -1
            THIS.RetornoFalha("Modulo Nao Iniciado", THIS.this_nValPago)
        CASE par_nRetorno = -2
            THIS.RetornoFalha(loc_cMsgPadrao, THIS.this_nValPago)
        CASE par_nRetorno = -3
            THIS.RetornoFalha("Fornecida uma Modalidade Invalida", THIS.this_nValPago)
        CASE par_nRetorno = -4
            THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", THIS.this_nValPago)
        CASE par_nRetorno = -5
            THIS.RetornoFalha("Sem Comunicacao com o SiTef", THIS.this_nValPago)
        ENDCASE
    ENDPROC

    *==========================================================================
    * MontaRetorno - Monta cursor crSiTef e grava arquivos de resposta de SUCESSO
    * Migrado de: SIGPRDFT.montaretorno
    * Par: par_sTipTran  = tipo da transacao (TipoCampo 100)
    *      par_sDataHora = data/hora no formato SiTef (TipoCampo 105)
    *      par_sCupom    = cupom fiscal com linhas separadas por CHR(10)
    *      par_sCartao   = codigo da bandeira selecionada
    *      par_sNsu      = NSU da transacao (TipoCampo 134)
    *      par_sAutoriza = codigo de autorizacao (TipoCampo 135)
    *      par_sFinaliza = dados de finalizacao
    *      par_nValPago  = valor da transacao
    *      par_sMenRet   = mensagem de retorno
    *==========================================================================
    PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
                           par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
        LOCAL loc_sValPago, loc_sCartaoSel, loc_sCupomWork, loc_sPos, loc_nLinha
        LOCAL loc_laCartao[11]

        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        loc_laCartao[1]  = "Outro, nao definido"
        loc_laCartao[2]  = "Visa"
        loc_laCartao[3]  = "Mastercard"
        loc_laCartao[4]  = "Diners"
        loc_laCartao[5]  = "American Express"
        loc_laCartao[6]  = "Sollo"
        loc_laCartao[7]  = "Sidecard (Redecard)"
        loc_laCartao[8]  = "Private Label (Redecard)"
        loc_laCartao[9]  = "Redeshop"
        loc_laCartao[10] = ""
        loc_laCartao[11] = "Fininvest"

        IF VAL(THIS.this_cBandeira) > 10 OR VAL(THIS.this_cBandeira) < 0
            loc_sCartaoSel = "0"
        ELSE
            loc_sCartaoSel = THIS.this_cBandeira
        ENDIF

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_laCartao[VAL(loc_sCartaoSel) + 1])
        INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_sTipTran)
        INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_sNsu)
        INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_sAutoriza)
        INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ALLTRIM(TRANSFORM(THIS.this_nParcelas, "@L 99")))
        INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
            SUBSTR(par_sDataHora, 7, 2) + SUBSTR(par_sDataHora, 5, 2) + SUBSTR(par_sDataHora, 1, 4))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_sDataHora, 9, 6))
        INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_sFinaliza)
        INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_sDataHora, 9, 6))

        loc_sPos       = 1
        loc_nLinha     = 1
        loc_sCupomWork = par_sCupom
        DO WHILE loc_sPos <> 0
            loc_sPos = AT(CHR(10), loc_sCupomWork)
            INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + " = " + ;
                IIF(loc_sPos <> 0, SUBSTR(loc_sCupomWork, 1, loc_sPos - 1), loc_sCupomWork))
            loc_sCupomWork = SUBSTR(loc_sCupomWork, loc_sPos + 1)
            loc_nLinha = loc_nLinha + 1
        ENDDO
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_sMenRet)
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e grava arquivos de resposta de FALHA
    * Migrado de: SIGPRDFT.retornofalha
    * Par: par_cMensagem = mensagem descritiva da falha
    *      par_nValPago  = valor da transacao (para registro no arquivo)
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_cMensagem, loc_sValPago

        loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
            "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", ;
            par_cMensagem)
        loc_sValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

        IF USED("crSiTef")
            USE IN crSiTef
        ENDIF
        CREATE CURSOR crSiTef (tef c(100))

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
        INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_sValPago)
        INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
        INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
        INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
        INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
            IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
        INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        SET SAFETY OFF
        SELECT crSiTef
        COPY TO C:\client\Resp\IntPos.001 SDF
        ZAP

        INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
        INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
        INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

        COPY TO C:\client\Resp\IntPos.STS SDF
        SET SAFETY ON

        USE IN crSiTef
    ENDPROC

    *==========================================================================
    * ObterRetornoStr - Retorna string de saida do form para o processo chamador
    * Migrado de: SIGPRDFT.Unload (logica de RETURN)
    * Formato: "saque/parcelas/data+bandeira+cartao"
    * Par: par_cSaque   = valor do saque formatado (ex: "0,00")
    *      par_nParcs   = numero de parcelas confirmadas
    *      par_dData    = data da parcela/vencimento
    *==========================================================================
    FUNCTION ObterRetornoStr(par_cSaque, par_nParcs, par_dData)
        LOCAL loc_cSaque, loc_cBandeira, loc_cCartao

        loc_cSaque    = IIF(EMPTY(par_cSaque), "0,00", par_cSaque)
        loc_cBandeira = IIF(EMPTY(THIS.this_cBandeira), "00000", LEFT(THIS.this_cBandeira + "00000", 5))
        loc_cCartao   = IIF(EMPTY(THIS.this_cCartao), "00000", LEFT(THIS.this_cCartao + "00000", 5))

        RETURN loc_cSaque + "/" + ;
               ALLTRIM(TRANSFORM(par_nParcs, "@L 99")) + "/" + ;
               DTOC(par_dData) + ;
               loc_cBandeira + ;
               loc_cCartao
    ENDPROC

ENDDEFINE

