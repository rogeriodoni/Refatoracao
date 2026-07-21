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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2118 linhas total):

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

*-- Linhas 66 a 232:
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
129:             THIS.ConfigurarConteudo()
130:             THIS.InicializarValoresIniciais()
131:             THIS.TornarControlesVisiveis(THIS)
132:             THIS.ZOrder(0)
133:             THIS.Refresh()
134: 
135:             loc_lSucesso = .T.
136:         CATCH TO loc_oErro
137:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
138:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm SiTef")
139:             loc_lSucesso = .F.
140:         ENDTRY
141:         RETURN loc_lSucesso
142:     ENDPROC
143: 
144:     *==========================================================================
145:     * CarregarDadosOperacao - Carrega crSigOpFp e crSigCdEmp via SQL Server
146:     * Migrado de: SIGPRDFT.Init (bloco poDataMgr.SqlExecute)
147:     *==========================================================================
148:     PROTECTED PROCEDURE CarregarDadosOperacao()
149:         LOCAL loc_cSQL, loc_oErro
150:         TRY
151:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
152:                 IF USED("crSigOpFp")
153:                     USE IN crSigOpFp
154:                 ENDIF
155:                 loc_cSQL = "SELECT * FROM SigOpFp WHERE FPags = " + ;
156:                            EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cOpers))
157:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp") < 0
158:                     MsgErro("Erro ao carregar dados da opera" + CHR(231) + CHR(227) + "o SiTef", "Erro SQL")
159:                 ENDIF
160: 
161:                 IF USED("crSigCdEmp")
162:                     USE IN crSigCdEmp
163:                 ENDIF
164:                 loc_cSQL = "SELECT * FROM SigCdEmp WHERE cEmps = " + ;
165:                            EscaparSQL(ALLTRIM(go_4c_Sistema.cCodEmpresa))
166:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmp") < 0
167:                     MsgErro("Erro ao carregar dados da empresa", "Erro SQL")
168:                 ENDIF
169: 
170:                 THIS.this_cIdTerminal = "00000" + ALLTRIM(go_4c_Sistema.cCodEmpresa)
171:             ELSE
172:                 MsgErro("Conex" + CHR(227) + "o com banco de dados indispon" + CHR(237) + "vel", ;
173:                         "Erro SiTef")
174:             ENDIF
175:         CATCH TO loc_oErro
176:             MsgErro(loc_oErro.Message, "Erro Carregar Dados Opera" + CHR(231) + CHR(227) + "o")
177:         ENDTRY
178:     ENDPROC
179: 
180:     *==========================================================================
181:     * ConfigurarPageFrame - Orquestra layout root do dialogo TEF (flat)
182:     *==========================================================================
183:     PROTECTED PROCEDURE ConfigurarPageFrame()
184:         THIS.ConfigurarCabecalho()
185:         THIS.ConfigurarBotaoCancelar()
186:     ENDPROC
187: 
188:     *==========================================================================
189:     * ConfigurarCabecalho - Container escuro com titulo do dialogo TEF
190:     * Migrado de: SIGPRDFT.cntSombra (adaptado para Width=500 do form)
191:     *==========================================================================
192:     PROTECTED PROCEDURE ConfigurarCabecalho()
193:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
194:         WITH THIS.cnt_4c_Cabecalho
195:             .Top         = 0
196:             .Left        = 0
197:             .Width       = THIS.Width
198:             .Height      = 80
199:             .BorderWidth = 0
200:             .BackStyle   = 1
201:             .BackColor   = RGB(100, 100, 100)
202: 
203:             .AddObject("lbl_4c_Sombra", "Label")
204:             WITH .lbl_4c_Sombra
205:                 .AutoSize  = .F.
206:                 .FontBold  = .T.
207:                 .FontName  = "Tahoma"
208:                 .FontSize  = 18
209:                 .WordWrap  = .T.
210:                 .Alignment = 0
211:                 .BackStyle = 0
212:                 .Caption   = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
213:                 .Height    = 40
214:                 .Left      = 10
215:                 .Top       = 18
216:                 .Width     = THIS.Width
217:                 .ForeColor = RGB(0, 0, 0)
218:             ENDWITH
219: 
220:             .AddObject("lbl_4c_Titulo", "Label")
221:             WITH .lbl_4c_Titulo
222:                 .AutoSize    = .F.
223:                 .FontBold    = .T.
224:                 .FontName    = "Tahoma"
225:                 .FontSize    = 18
226:                 .WordWrap    = .T.
227:                 .Alignment   = 0
228:                 .BackStyle   = 0
229:                 .Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
230:                 .Height      = 46
231:                 .Left        = 10
232:                 .Top         = 17

*-- Linhas 241 a 323:
241:     * ConfigurarBotaoCancelar - CommandGroup SAIDA com botao CANCELA
242:     * Migrado de: SIGPRDFT.SAIDA (Top=-2, Left=420, Width=85, Height=85)
243:     *==========================================================================
244:     PROTECTED PROCEDURE ConfigurarBotaoCancelar()
245:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
246:         WITH THIS.obj_4c_SAIDA
247:             .ButtonCount = 1
248:             .AutoSize    = .T.
249:             .BackStyle   = 0
250:             .BorderStyle = 0
251:             .Value       = 0
252:             .Height      = 85
253:             .Left        = 420
254:             .Top         = -2
255:             .Width       = 85
256:             .BackColor   = RGB(255, 255, 255)
257:             .Themes      = .F.
258: 
259:             WITH .Buttons(1)
260:                 .Top        = 5
261:                 .Left       = 5
262:                 .Height     = 75
263:                 .Width      = 75
264:                 .FontBold   = .T.
265:                 .FontItalic = .T.
266:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
267:                 .Cancel     = .F.
268:                 .Caption    = CHR(60) + "Cancelar"
269:                 .ForeColor  = RGB(90, 90, 90)
270:                 .BackColor  = RGB(255, 255, 255)
271:                 .Themes     = .F.
272:                 .Name       = "CANCELA"
273:             ENDWITH
274:         ENDWITH
275:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelaClick")
276:     ENDPROC
277: 
278:     *==========================================================================
279:     * ConfigurarConteudo - Cria todos os controles visuais do dialogo TEF
280:     * Migrado de: propriedades dos objetos SIGPRDFT (secao 2 do SCX)
281:     * Fase 4/8: adiciona controles de entrada e instrucao ao usuario
282:     *==========================================================================
283:     PROTECTED PROCEDURE ConfigurarConteudo()
284:         LOCAL loc_oErro
285:         TRY
286:             *-- Shape2: borda decorativa ao redor dos campos de entrada
287:             THIS.AddObject("shp_4c_Shape2", "Shape")
288:             WITH THIS.shp_4c_Shape2
289:                 .Top           = 93
290:                 .Left          = 17
291:                 .Height        = 202
292:                 .Width         = 466
293:                 .SpecialEffect = 0
294:             ENDWITH
295: 
296:             *-- Label5: rotulo "VALOR :"
297:             THIS.AddObject("lbl_4c_Label5", "Label")
298:             WITH THIS.lbl_4c_Label5
299:                 .AutoSize  = .F.
300:                 .FontBold  = .T.
301:                 .FontName  = "Tahoma"
302:                 .FontSize  = 8
303:                 .Alignment = 0
304:                 .BackStyle = 0
305:                 .Caption   = "VALOR :"
306:                 .Height    = 15
307:                 .Left      = 175
308:                 .Top       = 102
309:                 .Width     = 45
310:                 .ForeColor = RGB(90, 90, 90)
311:             ENDWITH
312: 
313:             *-- GetValor: valor da transacao (somente leitura - exibe valor recebido)
314:             THIS.AddObject("txt_4c_Valor", "TextBox")
315:             WITH THIS.txt_4c_Valor
316:                 .FontBold          = .T.
317:                 .FontName          = "Tahoma"
318:                 .FontSize          = 8
319:                 .Alignment         = 3
320:                 .Value             = 0
321:                 .Enabled           = .F.
322:                 .Format            = ""
323:                 .Height            = 23

*-- Linhas 367 a 721:
367:                 .ForeColor         = RGB(0, 0, 0)
368:                 .DisabledForeColor = RGB(0, 0, 0)
369:             ENDWITH
370:             BINDEVENT(THIS.txt_4c_Cartao, "GotFocus", THIS, "TxtCartaoGotFocus")
371: 
372:             *-- Label2: rotulo "4 ULTIMOS DIGITOS :" (muda para "Validade Cartao :" quando lCartao="S")
373:             THIS.AddObject("lbl_4c_Label2", "Label")
374:             WITH THIS.lbl_4c_Label2
375:                 .AutoSize  = .F.
376:                 .FontBold  = .T.
377:                 .FontName  = "Tahoma"
378:                 .FontSize  = 8
379:                 .Alignment = 0
380:                 .BackStyle = 0
381:                 .Caption   = "4 ULTIMOS DIGITOS :"
382:                 .Height    = 17
383:                 .Left      = 101
384:                 .Top       = 171
385:                 .Width     = 119
386:                 .ForeColor = RGB(90, 90, 90)
387:             ENDWITH
388: 
389:             *-- GetDigitos: 4 ultimos digitos do cartao (GotFocus inicia sessao TEF)
390:             THIS.AddObject("txt_4c_Digitos", "TextBox")
391:             WITH THIS.txt_4c_Digitos
392:                 .FontBold  = .T.
393:                 .FontName  = "Tahoma"
394:                 .FontSize  = 8
395:                 .Enabled   = .T.
396:                 .Height    = 23
397:                 .InputMask = "9999"
398:                 .Left      = 222
399:                 .TabIndex  = 3
400:                 .Top       = 168
401:                 .Width     = 40
402:                 .ForeColor = RGB(0, 0, 0)
403:                 .BackColor = RGB(212, 208, 200)
404:             ENDWITH
405:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "TxtDigitosGotFocus")
406:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "TxtDigitosKeyPress")
407: 
408:             *-- Label4: rotulo "TIPO DE VENDA :"
409:             THIS.AddObject("lbl_4c_Label4", "Label")
410:             WITH THIS.lbl_4c_Label4
411:                 .AutoSize  = .F.
412:                 .FontBold  = .T.
413:                 .FontName  = "Tahoma"
414:                 .FontSize  = 8
415:                 .Alignment = 0
416:                 .BackStyle = 0
417:                 .Caption   = "TIPO DE VENDA :"
418:                 .Height    = 15
419:                 .Left      = 129
420:                 .Top       = 204
421:                 .Width     = 91
422:                 .ForeColor = RGB(90, 90, 90)
423:             ENDWITH
424: 
425:             *-- Optiongroup1: selecao "A vista" / "Predatado"
426:             THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
427:             WITH THIS.obj_4c_Optiongroup1
428:                 .ButtonCount = 2
429:                 .Enabled     = .T.
430:                 .Height      = 26
431:                 .Left        = 222
432:                 .Top         = 200
433:                 .Width       = 161
434:                 .TabIndex    = 5
435:                 WITH .Buttons(1)
436:                     .FontBold  = .T.
437:                     .Caption   = " A vista"
438:                     .Height    = 17
439:                     .Left      = 5
440:                     .Top       = 4
441:                     .Width     = 61
442:                     .ForeColor = RGB(90, 90, 90)
443:                     .BackStyle = 0
444:                 ENDWITH
445:                 WITH .Buttons(2)
446:                     .FontBold  = .T.
447:                     .FontName  = "Tahoma"
448:                     .FontSize  = 8
449:                     .Caption   = " Predatado"
450:                     .Height    = 15
451:                     .Left      = 73
452:                     .Top       = 5
453:                     .Width     = 80
454:                     .ForeColor = RGB(90, 90, 90)
455:                     .BackStyle = 0
456:                 ENDWITH
457:             ENDWITH
458:             THIS.obj_4c_Optiongroup1.Value = 1
459:             BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptGrupoInteractiveChange")
460:             BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptGrupoOption1KeyPress")
461:             BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptGrupoOption1GotFocus")
462: 
463:             *-- Label6: rotulo "N? PARCELAS :"
464:             THIS.AddObject("lbl_4c_Label6", "Label")
465:             WITH THIS.lbl_4c_Label6
466:                 .AutoSize  = .F.
467:                 .FontBold  = .T.
468:                 .FontName  = "Tahoma"
469:                 .FontSize  = 8
470:                 .Alignment = 0
471:                 .BackStyle = 0
472:                 .Caption   = "N" + CHR(186) + " PARCELAS :"
473:                 .Height    = 15
474:                 .Left      = 139
475:                 .Top       = 238
476:                 .Width     = 81
477:                 .ForeColor = RGB(90, 90, 90)
478:             ENDWITH
479: 
480:             *-- Text1: numero de parcelas (habilitado pelo TEF quando aplicavel)
481:             THIS.AddObject("txt_4c_Text1", "TextBox")
482:             WITH THIS.txt_4c_Text1
483:                 .FontBold          = .T.
484:                 .FontName          = "Tahoma"
485:                 .FontSize          = 8
486:                 .Enabled           = .F.
487:                 .Format            = ""
488:                 .Height            = 23
489:                 .InputMask         = "99"
490:                 .Left              = 222
491:                 .TabIndex          = 6
492:                 .Top               = 235
493:                 .Width             = 27
494:                 .ForeColor         = RGB(0, 0, 0)
495:                 .DisabledForeColor = RGB(0, 0, 0)
496:                 .Value             = ""
497:             ENDWITH
498:             BINDEVENT(THIS.txt_4c_Text1, "GotFocus",  THIS, "TxtText1GotFocus")
499:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",   THIS, "TxtText1KeyPress")
500:             BINDEVENT(THIS.txt_4c_Text1, "KeyPress",  THIS, "TxtText1LostFocus")
501: 
502:             *-- Label11: rotulo "1a PARCELA/VENCTO :"
503:             THIS.AddObject("lbl_4c_Label11", "Label")
504:             WITH THIS.lbl_4c_Label11
505:                 .AutoSize  = .F.
506:                 .FontBold  = .T.
507:                 .FontName  = "Tahoma"
508:                 .FontSize  = 8
509:                 .Alignment = 0
510:                 .BackStyle = 0
511:                 .Caption   = "1" + CHR(186) + " PARCELA/VENCTO :"
512:                 .Height    = 15
513:                 .Left      = 98
514:                 .Top       = 268
515:                 .Width     = 122
516:                 .ForeColor = RGB(90, 90, 90)
517:             ENDWITH
518: 
519:             *-- GetDatas: data da primeira parcela ou vencimento
520:             THIS.AddObject("txt_4c_Datas", "TextBox")
521:             WITH THIS.txt_4c_Datas
522:                 .FontBold          = .T.
523:                 .FontName          = "Tahoma"
524:                 .FontSize          = 8
525:                 .Alignment         = 3
526:                 .Value             = {}
527:                 .Enabled           = .F.
528:                 .Format            = ""
529:                 .Height            = 23
530:                 .InputMask         = ""
531:                 .Left              = 222
532:                 .TabIndex          = 7
533:                 .Top               = 266
534:                 .Width             = 75
535:                 .ForeColor         = RGB(0, 0, 0)
536:                 .DisabledForeColor = RGB(0, 0, 0)
537:             ENDWITH
538:             BINDEVENT(THIS.txt_4c_Datas, "GotFocus",  THIS, "TxtDatasGotFocus")
539:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",   THIS, "TxtDatasKeyPress")
540:             BINDEVENT(THIS.txt_4c_Datas, "KeyPress",  THIS, "TxtDatasLostFocus")
541: 
542:             *-- Container1: exibe mensagem de instrucao ao usuario (tipo "Insira o Cartao")
543:             THIS.AddObject("cnt_4c_Container1", "Container")
544:             WITH THIS.cnt_4c_Container1
545:                 .Top           = 298
546:                 .Left          = 54
547:                 .Width         = 392
548:                 .Height        = 58
549:                 .SpecialEffect = 0
550:                 .BackStyle     = 1
551:                 .BackColor     = RGB(255, 255, 255)
552: 
553:                 .AddObject("lbl_4c_Label1", "Label")
554:                 WITH .lbl_4c_Label1
555:                     .AutoSize  = .F.
556:                     .FontBold  = .T.
557:                     .FontName  = "Tahoma"
558:                     .FontSize  = 18
559:                     .Alignment = 2
560:                     .BackStyle = 0
561:                     .Caption   = "Insira ou Passe o Cartao"
562:                     .Height    = 29
563:                     .Left      = 18
564:                     .Top       = 14
565:                     .Width     = 349
566:                     .ForeColor = RGB(90, 90, 90)
567:                 ENDWITH
568:             ENDWITH
569: 
570:         CATCH TO loc_oErro
571:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
572:                     " PROC=" + loc_oErro.Procedure, "Erro ConfigurarConteudo SiTef")
573:         ENDTRY
574:     ENDPROC
575: 
576:     *==========================================================================
577:     * InicializarValoresIniciais - Define valores iniciais nos controles
578:     * Migrado de: bloco final de SIGPRDFT.Init (apos WITH Thisform ... EndWith)
579:     *==========================================================================
580:     PROTECTED PROCEDURE InicializarValoresIniciais()
581:         LOCAL loc_oErro
582:         TRY
583:             THIS.txt_4c_Valor.Value  = THIS.this_oBusinessObject.this_nValPago
584:             THIS.txt_4c_Datas.Value  = DATE()
585:             THIS.this_dData          = DATE()
586:             THIS.txt_4c_Text1.Value  = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
587:             THIS.this_nParcs         = THIS.this_oBusinessObject.this_nNumParcs
588: 
589:             IF USED("crSigOpFp")
590:                 IF crSigOpFp.lCartao = "S"
591:                     THIS.txt_4c_Cartao.Enabled = .T.
592:                     THIS.lbl_4c_Label2.Caption  = "Validade Cart" + CHR(227) + "o :"
593:                 ENDIF
594:             ENDIF
595: 
596:             IF !THIS.txt_4c_Datas.Enabled
597:                 IF USED("crSigOpFp") AND crSigOpFp.lCartao = "N"
598:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
599:                 ELSE
600:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
601:                 ENDIF
602:             ELSE
603:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
604:             ENDIF
605: 
606:             THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
607: 
608:         CATCH TO loc_oErro
609:             MsgErro(loc_oErro.Message, "Erro InicializarValoresIniciais SiTef")
610:         ENDTRY
611:     ENDPROC
612: 
613:     *==========================================================================
614:     * BtnCancelaClick - Cancela transacao SiTef e libera o dialogo
615:     * Migrado de: SIGPRDFT.SAIDA.CANCELA.Click
616:     *==========================================================================
617:     PROCEDURE BtnCancelaClick()
618:         LOCAL loc_nRetorno, loc_oErro
619:         TRY
620:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
621:                 @THIS.this_nProxCmd,   @THIS.this_nTipoCampo, ;
622:                 @THIS.this_nTamMin,    @THIS.this_nTamMax, ;
623:                 @THIS.this_cBuffer,    LEN(THIS.this_cBuffer), -1)
624:             THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)", ;
625:                               THIS.this_oBusinessObject.this_nValPago)
626:         CATCH TO loc_oErro
627:             MsgErro(loc_oErro.Message, "Erro Cancelar SiTef")
628:         ENDTRY
629:         THIS.Release()
630:     ENDPROC
631: 
632:     *==========================================================================
633:     * KeyPress - Captura ESC no nivel do form (KeyPreview=.T.) para cancelar
634:     * Migrado de: SIGPRDFT.KeyPress
635:     *==========================================================================
636:     PROCEDURE KeyPress()
637:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
638:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
639:             NODEFAULT
640:             THIS.BtnCancelaClick()
641:         ENDIF
642:     ENDPROC
643: 
644:     *==========================================================================
645:     * ErroTef - Delega tratamento de erros SiTef para o BO
646:     * Migrado de: SIGPRDFT.errotef
647:     *==========================================================================
648:     PROCEDURE ErroTef(par_nRetorno)
649:         THIS.this_oBusinessObject.ErroTef(par_nRetorno)
650:     ENDPROC
651: 
652:     *==========================================================================
653:     * RetornoFalha - Grava arquivo de falha SiTef e seta resultado do form
654:     * Migrado de: SIGPRDFT.retornofalha (via delegacao ao BO)
655:     *==========================================================================
656:     PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
657:         THIS.this_oBusinessObject.RetornoFalha(par_cMensagem, par_nValPago)
658:         THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
659:             THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
660:     ENDPROC
661: 
662:     *==========================================================================
663:     * MontaRetorno - Grava arquivo de sucesso SiTef e seta resultado do form
664:     * Migrado de: SIGPRDFT.montaretorno (via delegacao ao BO)
665:     *==========================================================================
666:     PROCEDURE MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, par_sCartao, ;
667:                             par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
668:         THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
669:         THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
670:         THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
671:         THIS.this_oBusinessObject.MontaRetorno(par_sTipTran, par_sDataHora, par_sCupom, ;
672:             par_sCartao, par_sNsu, par_sAutoriza, par_sFinaliza, par_nValPago, par_sMenRet)
673:         THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
674:             THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
675:     ENDPROC
676: 
677:     *==========================================================================
678:     * TxtDigitosGotFocus - Inicia sessao TEF ao focar GetDigitos
679:     * Migrado de: SIGPRDFT.GetDigitos.GotFocus (~231 linhas)
680:     *==========================================================================
681:     PROCEDURE TxtDigitosGotFocus()
682:         LOCAL loc_cIdTerminal, loc_cValPago, loc_cData, loc_cHora
683:         LOCAL loc_nRetorno, loc_nTipo
684:         LOCAL loc_lTipoVenda, loc_nTipoVenda, loc_cBandeira, loc_lContinua
685:         LOCAL loc_nCaixas, loc_cDateStr, loc_nEmp
686: 
687:         THIS.this_cNsu      = ""
688:         THIS.this_cAutoriza = ""
689:         THIS.this_cDataHora = ""
690:         THIS.this_cTipTran  = ""
691:         THIS.this_cCupomTef = ""
692:         THIS.this_cFinaliza = ""
693:         THIS.this_cMRet     = ""
694:         THIS.this_cMensagem = ""
695: 
696:         IF USED("crSigFiMpF") AND TYPE("crSigFiMpF.Cncaixas") = "N"
697:             loc_nCaixas = VAL(ALLTRIM(STR(crSigFiMpF.Cncaixas)))
698:         ELSE
699:             loc_nCaixas = 1
700:         ENDIF
701:         IF USED("crSigCdEmp") AND TYPE("crSigCdEmp.nEmps") = "N"
702:             loc_nEmp = crSigCdEmp.nEmps
703:         ELSE
704:             loc_nEmp = 0
705:         ENDIF
706:         loc_cIdTerminal = ALLTRIM(STR(loc_nEmp)) + TRANSFORM(loc_nCaixas, "@L 999999")
707: 
708:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nValPago, "99999999.99")), ".", ",")
709: 
710:         IF ConfiguraIntSiTefInterativo(THIS.this_oBusinessObject.this_cEndSiTef, ;
711:                                        loc_cIdTerminal, loc_cIdTerminal, 0) <> 0
712:             THIS.RetornoFalha("Sem comunicacao com SiTef", THIS.this_oBusinessObject.this_nValPago)
713:             THIS.Release()
714:             RETURN
715:         ENDIF
716: 
717:         loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
718:         loc_cHora = STRTRAN(TIME(), ":", "")
719: 
720:         IF IniciaFuncaoSiTefInterativo(0, loc_cValPago, THIS.this_oBusinessObject.this_cCupom, ;
721:                                         loc_cData, loc_cHora, THIS.this_oBusinessObject.this_cCaixa, ;

*-- Linhas 741 a 818:
741:         loc_nTipoVenda        = 0
742:         loc_lContinua         = IIF(USED("crSigOpFp") AND crSigOpFp.lCartao = "N", .T., .F.)
743: 
744:         THIS.obj_4c_Optiongroup1.Enabled = .F.
745: 
746:         DO WHILE loc_lContinua
747:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
748:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
749:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
750:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
751: 
752:             IF LASTKEY() = 27
753:                 ContinuaFuncaoSiTefInterativo( ;
754:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
755:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
756:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
757:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
758:                                   THIS.this_oBusinessObject.this_nValPago)
759:                 THIS.Release()
760:                 RETURN
761:             ENDIF
762: 
763:             IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(THIS.this_cBuffer)
764:                 IF loc_nTipoVenda = 2
765:                     loc_lTipoVenda = .T.
766:                 ELSE
767:                     loc_nTipoVenda = 2
768:                 ENDIF
769:             ENDIF
770: 
771:             IF THIS.this_nProxCmd = 23
772:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
773:             ELSE
774:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
775:             ENDIF
776: 
777:             IF THIS.this_nProxCmd = 22 AND LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
778:                 MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
779:                          ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
780:                 ContinuaFuncaoSiTefInterativo( ;
781:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
782:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
783:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
784:                 loc_nRetorno = -1
785:                 EXIT
786:             ENDIF
787: 
788:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
789:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
790:             ENDIF
791: 
792:             IF loc_nRetorno = 0
793:                 EXIT
794:             ENDIF
795:             IF loc_nRetorno < 0
796:                 THIS.ErroTef(loc_nRetorno)
797:                 THIS.Release()
798:                 EXIT
799:             ENDIF
800: 
801:             IF THIS.this_nProxCmd = 3
802:                 THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
803:             ENDIF
804:             IF THIS.this_nTipoCampo = 100
805:                 THIS.this_cTipTran = THIS.this_cBuffer
806:                 THIS.this_cBuffer  = SPACE(2000)
807:                 THIS.this_nContinua = 0
808:                 LOOP
809:             ENDIF
810:             IF THIS.this_nTipoCampo = 105
811:                 THIS.this_cDataHora = THIS.this_cBuffer
812:                 THIS.this_cBuffer   = SPACE(2000)
813:                 LOOP
814:             ENDIF
815:             IF THIS.this_nTipoCampo = 121
816:                 THIS.this_cCupomTef = THIS.this_cBuffer
817:                 THIS.this_cBuffer   = SPACE(2000)
818:                 LOOP

*-- Linhas 917 a 1081:
917:                 THIS.this_cBuffer     = SPACE(2000)
918:                 THIS.this_nContinua   = 0
919:             ENDIF
920:         ENDDO
921: 
922:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
923: 
924:         IF loc_nRetorno < 0 OR THIS.this_lAbandonou
925:             THIS.Release()
926:             RETURN
927:         ENDIF
928: 
929:         IF !EMPTY(THIS.this_cNsu)
930:             THIS.MontaRetorno(THIS.this_cTipTran, THIS.this_cDataHora, THIS.this_cCupomTef, ;
931:                 THIS.this_cBandeira, THIS.this_cNsu, THIS.this_cNsu, THIS.this_cFinaliza, ;
932:                 THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
933:             THIS.Release()
934:             RETURN
935:         ENDIF
936: 
937:         THIS.txt_4c_Digitos.BackColor = RGB(255, 255, 255)
938:         THIS.txt_4c_Cartao.Value      = "#### #### #### ####"
939: 
940:         IF loc_lTipoVenda
941:             IF !THIS.txt_4c_Text1.Enabled
942:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
943:                 THIS.txt_4c_Digitos.Enabled          = .F.
944:                 THIS.obj_4c_Optiongroup1.Enabled     = .T.
945:                 THIS.txt_4c_Datas.Enabled            = .T.
946:             ENDIF
947:         ELSE
948:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
949:             THIS.obj_4c_Optiongroup1.Enabled             = .T.
950:         ENDIF
951: 
952:         THIS.obj_4c_SAIDA.Enabled = .T.
953:     ENDPROC
954: 
955:     *==========================================================================
956:     * TxtDigitosKeyPress - Processa os 4 digitos ao pressionar Enter/Tab
957:     * Migrado de: SIGPRDFT.GetDigitos.Valid (~185 linhas)
958:     *==========================================================================
959:     PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
960: 
961:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
962:             RETURN
963:         ENDIF
964: 
965:         IF THIS.this_lAbandonou
966:             THIS.Release()
967:             RETURN
968:         ENDIF
969: 
970:         LOCAL loc_cVal, loc_nRetorno, loc_nCampo
971:         loc_cVal = ALLTRIM(THIS.txt_4c_Digitos.Value)
972: 
973:         IF LEN(loc_cVal) <> 4 AND !EMPTY(loc_cVal)
974:             MsgAviso("Quantidade de Digitos Invalida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
975:             THIS.txt_4c_Digitos.Value = ""
976:             RETURN
977:         ENDIF
978: 
979:         IF EMPTY(loc_cVal)
980:             RETURN
981:         ENDIF
982: 
983:         THIS.this_lParcelas = .F.
984:         THIS.this_cMensagem = ""
985:         THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 2000 - LEN(loc_cVal))
986:         THIS.this_nContinua = 1000
987:         loc_nRetorno        = 10000
988:         loc_nCampo          = 1
989: 
990:         DO WHILE loc_nRetorno = 10000
991:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
992:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
993:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
994:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
995: 
996:             IF LASTKEY() = 27
997:                 ContinuaFuncaoSiTefInterativo( ;
998:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
999:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1000:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1001:                 THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1002:                                   THIS.this_oBusinessObject.this_nValPago)
1003:                 THIS.Release()
1004:                 RETURN
1005:             ENDIF
1006: 
1007:             IF THIS.this_nProxCmd = 23
1008:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1009:             ELSE
1010:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1011:             ENDIF
1012: 
1013:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1014:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1015:             ENDIF
1016: 
1017:             IF loc_nRetorno = 0
1018:                 EXIT
1019:             ENDIF
1020:             IF loc_nRetorno < 0
1021:                 THIS.ErroTef(loc_nRetorno)
1022:                 THIS.Release()
1023:                 RETURN
1024:             ENDIF
1025: 
1026:             IF THIS.this_nProxCmd = 22
1027:                 MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1028:                          ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1029:                 ContinuaFuncaoSiTefInterativo( ;
1030:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1031:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1032:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1033:                 IF loc_nRetorno <> 10000
1034:                     EXIT
1035:                 ELSE
1036:                     IF THIS.this_lParcelas
1037:                         THIS.txt_4c_Text1.Enabled        = .T.
1038:                         THIS.obj_4c_Optiongroup1.Enabled = .F.
1039:                         THIS.txt_4c_Digitos.Value        = ""
1040:                         RETURN
1041:                     ELSE
1042:                         RETURN
1043:                     ENDIF
1044:                 ENDIF
1045:             ENDIF
1046: 
1047:             IF THIS.this_nProxCmd = 23
1048:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1049:             ELSE
1050:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1051:             ENDIF
1052: 
1053:             IF THIS.this_nProxCmd = 21
1054:                 THIS.this_cBuffer = IIF(THIS.this_oBusinessObject.this_nNumParcs = 1, ;
1055:                     IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), ;
1056:                     IIF(THIS.this_oBusinessObject.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
1057:                 IF THIS.this_cBuffer = "1"
1058:                     EXIT
1059:                 ENDIF
1060:                 THIS.this_lDCD      = .T.
1061:                 THIS.this_nContinua = 1000
1062:                 LOOP
1063:             ENDIF
1064: 
1065:             IF THIS.this_nProxCmd = 23
1066:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1067:             ENDIF
1068: 
1069:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
1070:                 THIS.this_cBuffer = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
1071:                     "1", "2") + REPLICATE(CHR(0), 1999)
1072:                 THIS.this_nContinua = 1000
1073:             ENDIF
1074: 
1075:             IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
1076:                 THIS.this_cSaque  = "0,00"
1077:                 THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
1078:                 THIS.this_nContinua = 1000
1079:                 LOOP
1080:             ENDIF
1081: 

*-- Linhas 1096 a 1116:
1096:                     EXIT
1097:                 ENDIF
1098:             ENDIF
1099: 
1100:             IF UPPER(ALLTRIM(THIS.this_cBuffer)) = "DIGITE A SENHA"
1101:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1102:             ENDIF
1103: 
1104:             IF THIS.this_nProxCmd = 3
1105:                 THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
1106:             ENDIF
1107:             IF THIS.this_nTipoCampo = 100
1108:                 THIS.this_cTipTran = THIS.this_cBuffer
1109:             ENDIF
1110:             IF THIS.this_nTipoCampo = 105
1111:                 THIS.this_cDataHora = THIS.this_cBuffer
1112:             ENDIF
1113:             IF THIS.this_nTipoCampo = 121
1114:                 THIS.this_cCupomTef = THIS.this_cBuffer
1115:             ENDIF
1116:             IF THIS.this_nTipoCampo = 131

*-- Linhas 1156 a 1441:
1156:             THIS.Release()
1157:             RETURN
1158:         ENDIF
1159: 
1160:         IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 514
1161:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1162:         ELSE
1163:             IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND !THIS.this_lDCD
1164:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1165:                 THIS.obj_4c_Optiongroup1.Enabled             = .T.
1166:                 THIS.txt_4c_Datas.Enabled                    = .T.
1167:             ELSE
1168:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1169:             ENDIF
1170:         ENDIF
1171: 
1172:         THIS.txt_4c_Digitos.Enabled      = .F.
1173:         THIS.obj_4c_Optiongroup1.Enabled = .T.
1174:     ENDPROC
1175: 
1176:     *==========================================================================
1177:     * TxtCartaoGotFocus - Foco no campo numero do cartao
1178:     * Garante que instrucao esteja visivel para cartao manual
1179:     *==========================================================================
1180:     PROCEDURE TxtCartaoGotFocus()
1181:         THIS.cnt_4c_Container1.lbl_4c_Label1.Visible = .T.
1182:     ENDPROC
1183: 
1184:     *==========================================================================
1185:     * OptGrupoInteractiveChange - Habilita GetDatas ao mudar tipo de venda
1186:     * Migrado de: SIGPRDFT.Optiongroup1.InteractiveChange
1187:     *==========================================================================
1188:     PROCEDURE OptGrupoInteractiveChange()
1189:         THIS.txt_4c_Datas.Enabled = .T.
1190:         IF THIS.obj_4c_Optiongroup1.Value = 1
1191:             THIS.txt_4c_Datas.Value = DATE()
1192:         ELSE
1193:             THIS.txt_4c_Datas.Value = CTOD("")
1194:         ENDIF
1195:     ENDPROC
1196: 
1197:     *==========================================================================
1198:     * OptGrupoOption1KeyPress - ENTER no Option1 simula TAB (avanca campo)
1199:     * Migrado de: SIGPRDFT.Optiongroup1.Option1.KeyPress
1200:     *==========================================================================
1201:     PROCEDURE OptGrupoOption1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1202:         IF par_nKeyCode = 13
1203:             KEYBOARD "{TAB}"
1204:         ENDIF
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * OptGrupoOption1GotFocus - Habilita GetDatas ao focar Option1
1209:     * Migrado de: SIGPRDFT.Optiongroup1.Option1.GotFocus
1210:     *==========================================================================
1211:     PROCEDURE OptGrupoOption1GotFocus()
1212:         THIS.txt_4c_Datas.Enabled = .T.
1213:     ENDPROC
1214: 
1215:     *==========================================================================
1216:     * TxtText1GotFocus - Define tvenda=.F. ao entrar em parcelas
1217:     * Migrado de: SIGPRDFT.Text1.GotFocus
1218:     *==========================================================================
1219:     PROCEDURE TxtText1GotFocus()
1220:         THIS.this_lTvenda = .F.
1221:     ENDPROC
1222: 
1223:     *==========================================================================
1224:     * TxtText1KeyPress - Processa numero de parcelas ao pressionar Enter/Tab
1225:     * Migrado de: SIGPRDFT.Text1.Valid
1226:     *==========================================================================
1227:     PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1228: 
1229:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1230:             RETURN
1231:         ENDIF
1232: 
1233:         IF EMPTY(THIS.txt_4c_Text1.Value)
1234:             RETURN
1235:         ENDIF
1236: 
1237:         LOCAL loc_cVal, loc_nRetorno
1238:         loc_cVal = ALLTRIM(THIS.txt_4c_Text1.Value)
1239: 
1240:         THIS.this_nParcs    = VAL(loc_cVal)
1241:         THIS.this_cBuffer   = loc_cVal + REPLICATE(CHR(0), 1990)
1242:         THIS.this_nContinua = 1000
1243: 
1244:         loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1245:             @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1246:             @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1247:             @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1248: 
1249:         IF THIS.this_nProxCmd = 23
1250:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1251:         ELSE
1252:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1253:         ENDIF
1254: 
1255:         IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1256:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1257:         ENDIF
1258: 
1259:         IF THIS.this_nProxCmd = 22
1260:             MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1261:                      ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1262:             ContinuaFuncaoSiTefInterativo( ;
1263:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1264:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1265:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1266:             RETURN
1267:         ENDIF
1268: 
1269:         THIS.this_cBuffer   = ""
1270:         THIS.this_nContinua = 0
1271:     ENDPROC
1272: 
1273:     *==========================================================================
1274:     * TxtText1LostFocus - Formata parcelas, desabilita campo e habilita GetDatas
1275:     * Migrado de: SIGPRDFT.Text1.LostFocus
1276:     *==========================================================================
1277:     PROCEDURE TxtText1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1278:         THIS.txt_4c_Text1.Value    = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
1279:         THIS.txt_4c_Text1.Enabled  = .F.
1280:         THIS.txt_4c_Datas.Enabled  = .T.
1281:     ENDPROC
1282: 
1283:     *==========================================================================
1284:     * TxtDatasGotFocus - Processa estado TEF ao entrar no campo de data
1285:     * Migrado de: SIGPRDFT.GetDatas.GotFocus (~188 linhas)
1286:     *==========================================================================
1287:     PROCEDURE TxtDatasGotFocus()
1288:         LOCAL loc_nRetorno, loc_cDateStr, loc_oErro
1289: 
1290:         THIS.this_lTvenda   = .F.
1291:         THIS.this_cTipTran  = ""
1292:         THIS.this_cDataHora = ""
1293:         THIS.this_cCupomTef = ""
1294:         THIS.this_cCartao   = ""
1295:         THIS.this_cNsu      = ""
1296:         THIS.this_cAutoriza = ""
1297:         THIS.this_cFinaliza = ""
1298:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1299:         THIS.this_cMRet     = ""
1300: 
1301:         IF THIS.this_oBusinessObject.this_cDebCred <> "P" AND ;
1302:            !THIS.this_lDCD AND ;
1303:            USED("crSigOpFp") AND crSigOpFp.Tcdc <> "S"
1304: 
1305:             loc_nRetorno        = 10000
1306:             THIS.this_cMensagem = ""
1307: 
1308:             IF THIS.obj_4c_Optiongroup1.Enabled
1309:                 THIS.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
1310:             ELSE
1311:                 DO WHILE THIS.this_nProxCmd <> 30
1312:                     loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1313:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1314:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1315:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1316:                     IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1317:                         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1318:                     ENDIF
1319:                     IF THIS.this_nProxCmd = 23
1320:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1321:                     ELSE
1322:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1323:                     ENDIF
1324:                     IF loc_nRetorno < 0
1325:                         THIS.ErroTef(loc_nRetorno)
1326:                         THIS.Release()
1327:                         RETURN
1328:                     ENDIF
1329:                 ENDDO
1330:                 THIS.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + REPLICATE(CHR(0), 1998)
1331:             ENDIF
1332: 
1333:             THIS.this_nContinua   = 1000
1334:             THIS.this_cAutoriza   = ""
1335: 
1336:             DO WHILE loc_nRetorno = 10000
1337:                 loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1338:                     @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1339:                     @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1340:                     @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1341: 
1342:                 IF LASTKEY() = 27
1343:                     ContinuaFuncaoSiTefInterativo( ;
1344:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1345:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1346:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1347:                     THIS.RetornoFalha("Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usuario", ;
1348:                                       THIS.this_oBusinessObject.this_nValPago)
1349:                     THIS.Release()
1350:                     RETURN
1351:                 ENDIF
1352: 
1353:                 IF THIS.this_nProxCmd = 23
1354:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1355:                 ELSE
1356:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1357:                 ENDIF
1358:                 IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1359:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1360:                 ENDIF
1361:                 IF loc_nRetorno < 0
1362:                     THIS.ErroTef(loc_nRetorno)
1363:                     THIS.Release()
1364:                     RETURN
1365:                 ENDIF
1366: 
1367:                 IF THIS.this_nProxCmd = 22
1368:                     MsgAviso(ALLTRIM(SUBSTR(THIS.this_cBuffer, 1, 32)) + CHR(13) + ;
1369:                              ALLTRIM(SUBSTR(THIS.this_cBuffer, 33, 32)), "Erro na Transa" + CHR(231) + CHR(227) + "o")
1370:                     IF "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1371:                         ContinuaFuncaoSiTefInterativo( ;
1372:                             @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1373:                             @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1374:                             @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1375:                         loc_nRetorno = -8
1376:                         EXIT
1377:                     ENDIF
1378:                     ContinuaFuncaoSiTefInterativo( ;
1379:                         @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1380:                         @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1381:                         @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1382:                     IF loc_nRetorno <> 10000
1383:                         THIS.Release()
1384:                         RETURN
1385:                     ELSE
1386:                         RETURN
1387:                     ENDIF
1388:                     IF THIS.this_nProxCmd = 23
1389:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1390:                     ELSE
1391:                         THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1392:                     ENDIF
1393:                 ENDIF
1394: 
1395:                 IF loc_nRetorno < 0
1396:                     THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
1397:                                          THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
1398:                     EXIT
1399:                 ENDIF
1400: 
1401:                 IF THIS.this_nProxCmd = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
1402:                     IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 510
1403:                         THIS.this_cBuffer   = IIF(USED("crSigOpFp") AND crSigOpFp.Garantias = "S", ;
1404:                             "1", "2") + REPLICATE(CHR(0), 1999)
1405:                         THIS.this_nContinua = 1000
1406:                         LOOP
1407:                     ENDIF
1408:                     EXIT
1409:                 ENDIF
1410: 
1411:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 506
1412:                     loc_cDateStr = DTOC(THIS.txt_4c_Datas.Value)
1413:                     THIS.this_cBuffer = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
1414:                                         ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
1415:                                         ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
1416:                     THIS.this_nContinua = 1000
1417:                     LOOP
1418:                 ENDIF
1419:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 505
1420:                     THIS.this_cBuffer   = ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
1421:                     THIS.this_nContinua = 1000
1422:                     LOOP
1423:                 ENDIF
1424:                 IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 507
1425:                     IF MsgConfirma("Primeira Parcela A Vista")
1426:                         THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1427:                     ELSE
1428:                         THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1429:                     ENDIF
1430:                     THIS.this_nContinua = 1000
1431:                     LOOP
1432:                 ENDIF
1433:                 IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 508
1434:                     THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.Dias)), "0") + REPLICATE(CHR(0), 1998)
1435:                     THIS.this_nContinua = 1000
1436:                     LOOP
1437:                 ENDIF
1438:                 IF THIS.this_nProxCmd = 20 AND THIS.this_nTipoCampo = 509
1439:                     THIS.this_cBuffer   = IIF(USED("crSigOpFp"), ALLTRIM(STR(crSigOpFp.MesFec - 1)), "0") + REPLICATE(CHR(0), 1999)
1440:                     THIS.this_nContinua = 1000
1441:                     LOOP

*-- Linhas 1448 a 1468:
1448:                 ENDIF
1449:                 IF loc_nRetorno <> 0
1450:                     THIS.this_cFinaliza = THIS.this_cBuffer
1451:                 ENDIF
1452:                 IF UPPER(ALLTRIM(THIS.this_cBuffer)) $ "DIGITE A SENHA"
1453:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1454:                 ENDIF
1455:                 IF THIS.this_nProxCmd = 34 AND THIS.this_nTipoCampo = 130
1456:                     THIS.this_cSaque  = "0,00"
1457:                     THIS.this_cBuffer = THIS.this_cSaque + REPLICATE(CHR(0), 2000 - LEN(THIS.this_cSaque))
1458:                     THIS.this_nContinua = 1000
1459:                     LOOP
1460:                 ENDIF
1461:                 IF THIS.this_nProxCmd = 3
1462:                     THIS.this_cMRet = ALLTRIM(THIS.this_cBuffer)
1463:                 ENDIF
1464:                 IF THIS.this_nTipoCampo = 100
1465:                     THIS.this_cTipTran = THIS.this_cBuffer
1466:                 ENDIF
1467:                 IF THIS.this_nTipoCampo = 105
1468:                     THIS.this_cDataHora = THIS.this_cBuffer

*-- Linhas 1499 a 1570:
1499:                         THIS.this_cAutoriza, THIS.this_cFinaliza, ;
1500:                         THIS.this_oBusinessObject.this_nValPago, THIS.this_cMRet)
1501:                     THIS.Release()
1502:                 ENDIF
1503:             ENDIF
1504:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1505:         ENDIF
1506:     ENDPROC
1507: 
1508:     *==========================================================================
1509:     * TxtDatasKeyPress - Processa data de vencimento ao pressionar Enter/Tab
1510:     * Migrado de: SIGPRDFT.GetDatas.Valid (~183 linhas)
1511:     *==========================================================================
1512:     PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1513: 
1514:         IF par_nKeyCode = 27
1515:             RETURN
1516:         ENDIF
1517: 
1518:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1519:             RETURN
1520:         ENDIF
1521: 
1522:         LOCAL loc_ldData, loc_nRetorno, loc_cDateStr
1523: 
1524:         loc_ldData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
1525:         THIS.txt_4c_Datas.Value = loc_ldData
1526:         THIS.this_dData         = loc_ldData
1527: 
1528:         IF THIS.obj_4c_Optiongroup1.Value = 2 AND THIS.txt_4c_Datas.Value <= DATE() AND ;
1529:            !EMPTY(THIS.txt_4c_Datas.Value)
1530:             MsgAviso("Data Inv" + CHR(225) + "lida", "Erro na Transa" + CHR(231) + CHR(227) + "o")
1531:             RETURN
1532:         ENDIF
1533: 
1534:         DO WHILE THIS.this_nProxCmd <> 30
1535:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1536:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1537:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1538:                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), THIS.this_nContinua)
1539:             IF THIS.this_nProxCmd = 23
1540:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1541:             ELSE
1542:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1543:             ENDIF
1544:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1545:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1546:             ENDIF
1547:             IF loc_nRetorno < 0
1548:                 THIS.ErroTef(loc_nRetorno)
1549:                 THIS.Release()
1550:                 RETURN
1551:             ENDIF
1552:         ENDDO
1553: 
1554:         LOCAL loc_nPrimo
1555:         loc_nPrimo          = 1
1556:         THIS.this_cAutoriza = ""
1557:         loc_nRetorno        = 10000
1558:         THIS.this_cMensagem = ""
1559:         loc_cDateStr        = DTOC(THIS.txt_4c_Datas.Value)
1560:         THIS.this_cBuffer   = ALLTRIM(SUBSTR(loc_cDateStr, 1, 2)) + ;
1561:                               ALLTRIM(SUBSTR(loc_cDateStr, 4, 2)) + ;
1562:                               ALLTRIM(SUBSTR(loc_cDateStr, 7, 4)) + REPLICATE(CHR(0), 1992)
1563:         THIS.this_nContinua = 1000
1564:         THIS.this_cAutoriza = ""
1565:         THIS.this_nCiclos   = 0
1566: 
1567:         DO WHILE loc_nRetorno = 10000
1568:             loc_nRetorno = ContinuaFuncaoSiTefInterativo( ;
1569:                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1570:                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;

*-- Linhas 1585 a 1647:
1585:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
1586:             ELSE
1587:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
1588:             ENDIF
1589:             IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR THIS.this_nProxCmd = 23
1590:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1591:             ENDIF
1592:             IF loc_nRetorno < 0
1593:                 THIS.ErroTef(loc_nRetorno)
1594:                 THIS.Release()
1595:                 RETURN
1596:             ENDIF
1597: 
1598:             IF THIS.this_nProxCmd = 22
1599:                 IF THIS.this_oBusinessObject.this_cDebCred <> "P"
1600:                     IF LEN(ALLTRIM(THIS.this_cBuffer)) <> 0
1601:                         LOCAL loc_cMsg22
1602:                         loc_cMsg22 = IIF(UPPER(ALLTRIM(THIS.this_cBuffer)) = "AGUARDE, EM PROCESSAMENTO", ;
1603:                             "TRANSACAO CANCELADA", ALLTRIM(THIS.this_cBuffer))
1604:                         MsgAviso(loc_cMsg22, "Erro na Transa" + CHR(231) + CHR(227) + "o")
1605:                         IF "SENHA" $ UPPER(ALLTRIM(THIS.this_cBuffer)) OR "CANC. CLIENTE" $ UPPER(ALLTRIM(THIS.this_cBuffer))
1606:                             ContinuaFuncaoSiTefInterativo( ;
1607:                                 @THIS.this_nProxCmd, @THIS.this_nTipoCampo, ;
1608:                                 @THIS.this_nTamMin,  @THIS.this_nTamMax, ;
1609:                                 @THIS.this_cBuffer,  LEN(THIS.this_cBuffer), -1)
1610:                             loc_nRetorno = -8
1611:                             EXIT
1612:                         ENDIF
1613:                         RETURN
1614:                     ELSE
1615:                         loc_nRetorno = 0
1616:                         EXIT
1617:                     ENDIF
1618:                 ELSE
1619:                     THIS.this_cCupomTef = ALLTRIM(THIS.this_cBuffer)
1620:                     loc_nRetorno = -1
1621:                     EXIT
1622:                 ENDIF
1623:             ENDIF
1624: 
1625:             IF loc_nRetorno <> 10000
1626:                 THIS.RetornoFalha(IIF(EMPTY(THIS.this_cMensagem), "Operacao Cancelada pelo Usuario", ;
1627:                                       THIS.this_cMensagem), THIS.this_oBusinessObject.this_nValPago)
1628:                 EXIT
1629:             ENDIF
1630: 
1631:             IF THIS.this_nProxCmd = 23
1632:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1633:             ENDIF
1634: 
1635:             IF THIS.this_nProxCmd = 30 AND THIS.this_nTipoCampo = 500
1636:                 MsgInfo("Senha solicitada - terminal de senha necessario")
1637:                 THIS.RetornoFalha("Operacao Cancelada pelo Usuario", THIS.this_oBusinessObject.this_nValPago)
1638:                 loc_nRetorno = -2
1639:                 EXIT
1640:             ENDIF
1641: 
1642:             IF UPPER(THIS.this_cBuffer) = "ASSUME GARANTIA" AND loc_nPrimo = 1
1643:                 IF MsgConfirma("Assume Invers" + CHR(227) + "o de Risco ?")
1644:                     THIS.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1645:                 ELSE
1646:                     THIS.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1647:                 ENDIF

*-- Linhas 1721 a 2118:
1721:     * TxtDatasLostFocus - Restaura comportamento de confirmacao normal
1722:     * Migrado de: SIGPRDFT.GetDatas.LostFocus
1723:     *==========================================================================
1724:     PROCEDURE TxtDatasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1725:         SET CONFIRM ON
1726:     ENDPROC
1727: 
1728:     *==========================================================================
1729:     * TornarControlesVisiveis - Recursivo: torna todos os controles visiveis
1730:     *==========================================================================
1731:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1732:         LOCAL loc_i, loc_oControl
1733:         FOR loc_i = 1 TO par_oContainer.ControlCount
1734:             loc_oControl = par_oContainer.Controls(loc_i)
1735:             IF VARTYPE(loc_oControl) = "O"
1736:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1737:                     loc_oControl.Visible = .T.
1738:                 ENDIF
1739:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1740:                     THIS.TornarControlesVisiveis(loc_oControl)
1741:                 ENDIF
1742:             ENDIF
1743:         ENDFOR
1744:     ENDPROC
1745: 
1746:     *==========================================================================
1747:     * ConfigurarPaginaLista - Compat CRUD para dialogo OPERACIONAL flat
1748:     * Form SiTef nao possui Page1=Lista/Page2=Dados. Metodo mantido para
1749:     * compatibilidade com a arquitetura CRUD e delega a montagem visual
1750:     * (Cabecalho, botao Cancelar, campos TEF e Container1 de mensagens) para
1751:     * ConfigurarPageFrame + ConfigurarConteudo. Idempotente: so remonta se
1752:     * o Container1 (marcador de conteudo montado) ainda nao existe.
1753:     *==========================================================================
1754:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1755:         IF !PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1756:             THIS.ConfigurarPageFrame()
1757:             THIS.ConfigurarConteudo()
1758:             THIS.InicializarValoresIniciais()
1759:             THIS.TornarControlesVisiveis(THIS)
1760:         ENDIF
1761:     ENDPROC
1762: 
1763:     *==========================================================================
1764:     * ConfigurarPaginaDados - Compat CRUD para dialogo OPERACIONAL flat
1765:     * Form SiTef nao possui Page2/Dados separada. Todos os controles de
1766:     * entrada (Valor, Cartao, Digitos, OptionGroup, Parcelas, Data, Instrucao)
1767:     * estao em ConfigurarConteudo() com layout plano flat identico ao legado.
1768:     * Controles mapeados (mapeamento.json):
1769:     *   txt_4c_Valor      - GetValor  (valor da transacao, read-only)
1770:     *   txt_4c_Cartao     - GetCartao (numero do cartao, 19 digitos)
1771:     *   txt_4c_Digitos    - GetDigitos (4 ultimos digitos, inicia sessao TEF)
1772:     *   obj_4c_Optiongroup1 - Optiongroup1 (A vista / Predatado)
1773:     *   txt_4c_Text1      - Text1 (numero de parcelas)
1774:     *   txt_4c_Datas      - GetDatas (data 1a parcela / vencimento)
1775:     *   cnt_4c_Container1 - Container1 (instrucao dinamica ao usuario)
1776:     * Metodo mantido por compatibilidade com a arquitetura FormBase CRUD.
1777:     *==========================================================================
1778:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1779:         RETURN .T.
1780:     ENDPROC
1781: 
1782:     *==========================================================================
1783:     * AlternarPagina - Alterna mensagem do Container1 conforme fase da transacao
1784:     * Form SiTef flat sem PageFrame: reproduz o comportamento do legado que
1785:     * alterava Container1.Label1.Caption durante o fluxo TEF (GetCartao ->
1786:     * GetDigitos -> Senha -> Datas -> Autorizacao). par_nPagina indica a fase.
1787:     *==========================================================================
1788:     PROCEDURE AlternarPagina(par_nPagina)
1789:         LOCAL loc_cMsg
1790:         DO CASE
1791:             CASE par_nPagina = 1
1792:                 loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
1793:             CASE par_nPagina = 2
1794:                 loc_cMsg = "Digite os 4 " + CHR(250) + "ltimos d" + CHR(237) + "gitos"
1795:             CASE par_nPagina = 3
1796:                 loc_cMsg = "Digite a Senha"
1797:             CASE par_nPagina = 4
1798:                 loc_cMsg = "Digite a Data" + CHR(13) + "de Vencimento"
1799:             CASE par_nPagina = 5
1800:                 loc_cMsg = "Aguarde autoriza" + CHR(231) + CHR(227) + "o..."
1801:             OTHERWISE
1802:                 loc_cMsg = "Insira ou Passe o Cart" + CHR(227) + "o"
1803:         ENDCASE
1804:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5) AND ;
1805:            PEMSTATUS(THIS.cnt_4c_Container1, "lbl_4c_Label1", 5)
1806:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = loc_cMsg
1807:             THIS.cnt_4c_Container1.lbl_4c_Label1.Refresh()
1808:         ENDIF
1809:     ENDPROC
1810: 
1811:     *==========================================================================
1812:     * BtnIncluirClick - Inicia nova sess" + CHR(227) + "o TEF
1813:     * Form OPERACIONAL: "Incluir" equivale a reiniciar o fluxo TEF
1814:     * Posiciona foco em GetDigitos que via GotFocus inicia ConfiguraIntSiTefInterativo
1815:     *==========================================================================
1816:     PROCEDURE BtnIncluirClick()
1817:         LOCAL loc_oErro
1818:         TRY
1819:             THIS.this_lAbandonou = .F.
1820:             THIS.this_cBuffer    = SPACE(2000)
1821:             THIS.this_nContinua  = 0
1822:             THIS.this_nCiclos    = 0
1823:             THIS.this_cResultado = ""
1824:             THIS.txt_4c_Digitos.Value   = ""
1825:             THIS.txt_4c_Digitos.Enabled = .T.
1826:             THIS.txt_4c_Digitos.BackColor = RGB(212, 208, 200)
1827:             THIS.txt_4c_Digitos.SetFocus()
1828:         CATCH TO loc_oErro
1829:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
1830:         ENDTRY
1831:     ENDPROC
1832: 
1833:     *==========================================================================
1834:     * BtnAlterarClick - Continua fluxo TEF a partir do proximo campo ativo
1835:     * Form OPERACIONAL: "Alterar" = retomar transacao em andamento
1836:     * Direciona para GetDatas (data vencimento) se habilitado, caso contrario
1837:     * para Text1 (parcelas), mantendo o estado SiTef atual
1838:     *==========================================================================
1839:     PROCEDURE BtnAlterarClick()
1840:         LOCAL loc_oErro
1841:         TRY
1842:             IF THIS.txt_4c_Datas.Enabled
1843:                 THIS.txt_4c_Datas.SetFocus()
1844:             ELSE
1845:                 IF THIS.txt_4c_Text1.Enabled
1846:                 THIS.txt_4c_Text1.SetFocus()
1847:             ELSE
1848:                 IF THIS.txt_4c_Digitos.Enabled
1849:                 THIS.txt_4c_Digitos.SetFocus()
1850:                 ENDIF
1851:                 ENDIF
1852:             ENDIF
1853:         CATCH TO loc_oErro
1854:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
1855:         ENDTRY
1856:     ENDPROC
1857: 
1858:     *==========================================================================
1859:     * BtnVisualizarClick - Exibe resultado da transa" + CHR(231) + CHR(227) + "o TEF atual
1860:     * Form OPERACIONAL: "Visualizar" = consultar estado/resultado da sess" + CHR(227) + "o
1861:     * Exibe this_cResultado se j" + CHR(225) + " foi gerado, ou informa aguardando
1862:     *==========================================================================
1863:     PROCEDURE BtnVisualizarClick()
1864:         LOCAL loc_oErro, loc_cMsg
1865:         TRY
1866:             IF !EMPTY(THIS.this_cResultado)
1867:                 MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado")
1868:             ELSE
1869:                 IF !EMPTY(THIS.this_cMensagem)
1870:                 MsgInfo("Mensagem SiTef: " + THIS.this_cMensagem, "SiTef")
1871:             ELSE
1872:                 MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento.", "SiTef")
1873:                 ENDIF
1874:             ENDIF
1875:         CATCH TO loc_oErro
1876:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
1877:         ENDTRY
1878:     ENDPROC
1879: 
1880:     *==========================================================================
1881:     * BtnExcluirClick - Cancela transa" + CHR(231) + CHR(227) + "o TEF e fecha o di" + CHR(225) + "logo
1882:     * Form OPERACIONAL: "Excluir" equivale ao bot" + CHR(227) + "o Cancelar do original
1883:     * Delega para BtnCancelaClick que invoca ContinuaFuncaoSiTefInterativo(-1)
1884:     *==========================================================================
1885:     PROCEDURE BtnExcluirClick()
1886:         LOCAL loc_oErro
1887:         TRY
1888:             THIS.BtnCancelaClick()
1889:         CATCH TO loc_oErro
1890:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
1891:         ENDTRY
1892:     ENDPROC
1893: 
1894:     *==========================================================================
1895:     * BtnBuscarClick - Exibe status da transacao TEF (form OPERACIONAL flat)
1896:     * Form SiTef: "Buscar" consulta estado corrente do fluxo TEF
1897:     *==========================================================================
1898:     PROCEDURE BtnBuscarClick()
1899:         LOCAL loc_oErro
1900:         TRY
1901:             IF !EMPTY(THIS.this_cResultado)
1902:                 MsgInfo("Resultado TEF: " + THIS.this_cResultado, "Resultado TEF")
1903:             ELSE
1904:                 IF !EMPTY(THIS.this_cMensagem)
1905:                 MsgInfo("Status SiTef: " + THIS.this_cMensagem, "SiTef")
1906:             ELSE
1907:                 MsgInfo("Transa" + CHR(231) + CHR(227) + "o em andamento." + CHR(13) + ;
1908:                         "Preencha os campos solicitados.", "SiTef")
1909:                 ENDIF
1910:             ENDIF
1911:         CATCH TO loc_oErro
1912:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
1913:         ENDTRY
1914:     ENDPROC
1915: 
1916:     *==========================================================================
1917:     * BtnEncerrarClick - Encerra o dialogo TEF e cancela transacao em curso
1918:     * Padrao canonico do sistema novo: delega para BtnCancelaClick
1919:     *==========================================================================
1920:     PROCEDURE BtnEncerrarClick()
1921:         LOCAL loc_oErro
1922:         TRY
1923:             THIS.BtnCancelaClick()
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message, "Erro BtnEncerrarClick")
1926:         ENDTRY
1927:     ENDPROC
1928: 
1929:     *==========================================================================
1930:     * BtnSalvarClick - Confirma dados e avanca no fluxo TEF
1931:     * Form OPERACIONAL: sincroniza BO e foca proximo campo ativo
1932:     *==========================================================================
1933:     PROCEDURE BtnSalvarClick()
1934:         LOCAL loc_oErro
1935:         TRY
1936:             THIS.FormParaBO()
1937:             IF THIS.txt_4c_Digitos.Enabled
1938:                 THIS.txt_4c_Digitos.SetFocus()
1939:             ELSE
1940:                 IF THIS.txt_4c_Text1.Enabled
1941:                 THIS.txt_4c_Text1.SetFocus()
1942:             ELSE
1943:                 IF THIS.txt_4c_Datas.Enabled
1944:                 THIS.txt_4c_Datas.SetFocus()
1945:                 ENDIF
1946:                 ENDIF
1947:             ENDIF
1948:         CATCH TO loc_oErro
1949:             MsgErro(loc_oErro.Message, "Erro BtnSalvarClick")
1950:         ENDTRY
1951:     ENDPROC
1952: 
1953:     *==========================================================================
1954:     * BtnCancelarClick - Cancela transacao TEF e fecha o dialogo
1955:     * Alias de BtnCancelaClick para compatibilidade com arquitetura FormBase
1956:     *==========================================================================
1957:     PROCEDURE BtnCancelarClick()
1958:         LOCAL loc_oErro
1959:         TRY
1960:             THIS.BtnCancelaClick()
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966:     *==========================================================================
1967:     * FormParaBO - Sincroniza controles visuais para o Business Object
1968:     * Form OPERACIONAL TEF: parcelas, data, bandeira e cartao
1969:     *==========================================================================
1970:     PROCEDURE FormParaBO()
1971:         LOCAL loc_oErro
1972:         TRY
1973:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1974:                 THIS.this_oBusinessObject.this_nNumParcs = IIF(EMPTY(THIS.txt_4c_Text1.Value), ;
1975:                     0, VAL(ALLTRIM(THIS.txt_4c_Text1.Value)))
1976:                 THIS.this_oBusinessObject.this_cBandeira = THIS.this_cBandeira
1977:                 THIS.this_oBusinessObject.this_cCartao   = THIS.this_cCartao
1978:                 THIS.this_oBusinessObject.this_nParcelas = THIS.this_nParcs
1979:                 THIS.this_oBusinessObject.this_dData     = IIF(!EMPTY(THIS.txt_4c_Datas.Value), ;
1980:                     THIS.txt_4c_Datas.Value, DATE())
1981:             ENDIF
1982:         CATCH TO loc_oErro
1983:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
1984:         ENDTRY
1985:     ENDPROC
1986: 
1987:     *==========================================================================
1988:     * BOParaForm - Sincroniza Business Object para controles visuais
1989:     * Form OPERACIONAL TEF: carrega valor, parcelas e data do BO
1990:     *==========================================================================
1991:     PROCEDURE BOParaForm()
1992:         LOCAL loc_oErro
1993:         TRY
1994:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1995:                 THIS.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValPago
1996:                 IF THIS.this_oBusinessObject.this_nNumParcs > 0
1997:                     THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
1998:                 ELSE
1999:                     THIS.txt_4c_Text1.Value = ""
2000:                 ENDIF
2001:                 THIS.txt_4c_Datas.Value = IIF(!EMPTY(THIS.this_dData), THIS.this_dData, DATE())
2002:             ENDIF
2003:         CATCH TO loc_oErro
2004:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
2005:         ENDTRY
2006:     ENDPROC
2007: 
2008:     *==========================================================================
2009:     * HabilitarCampos - Habilita/desabilita campos conforme fase TEF
2010:     * par_lHabilitar=.T. reseta para estado inicial (digitos ativos)
2011:     *==========================================================================
2012:     PROCEDURE HabilitarCampos(par_lHabilitar)
2013:         LOCAL loc_oErro
2014:         TRY
2015:             THIS.txt_4c_Digitos.Enabled = par_lHabilitar
2016:             IF par_lHabilitar
2017:                 THIS.txt_4c_Datas.Enabled            = .F.
2018:                 THIS.txt_4c_Text1.Enabled             = .F.
2019:                 THIS.obj_4c_Optiongroup1.Enabled      = .F.
2020:             ENDIF
2021:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = par_lHabilitar
2022:         CATCH TO loc_oErro
2023:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
2024:         ENDTRY
2025:     ENDPROC
2026: 
2027:     *==========================================================================
2028:     * LimparCampos - Reseta todos os campos e estado TEF para nova transacao
2029:     *==========================================================================
2030:     PROCEDURE LimparCampos()
2031:         LOCAL loc_oErro
2032:         TRY
2033:             THIS.txt_4c_Digitos.Value              = ""
2034:             THIS.txt_4c_Cartao.Value               = ""
2035:             THIS.txt_4c_Text1.Value                = ""
2036:             THIS.txt_4c_Datas.Value                = DATE()
2037:             THIS.this_cBandeira                    = "00000"
2038:             THIS.this_cCartao                      = "00000"
2039:             THIS.this_cNsu                         = ""
2040:             THIS.this_cAutoriza                    = ""
2041:             THIS.this_cDataHora                    = ""
2042:             THIS.this_cTipTran                     = ""
2043:             THIS.this_cCupomTef                    = ""
2044:             THIS.this_cFinaliza                    = ""
2045:             THIS.this_cMRet                        = ""
2046:             THIS.this_cMensagem                    = ""
2047:             THIS.this_cResultado                   = ""
2048:             THIS.this_cBuffer                      = SPACE(2000)
2049:             THIS.this_nContinua                    = 0
2050:             THIS.this_nProxCmd                     = 0
2051:             THIS.this_nTipoCampo                   = 0
2052:             THIS.this_nTamMin                      = 0
2053:             THIS.this_nTamMax                      = 0
2054:             THIS.this_nCiclos                      = 0
2055:             THIS.this_lAbandonou                   = .F.
2056:             THIS.this_lParcelas                    = .F.
2057:             THIS.this_lDCD                         = .F.
2058:             THIS.obj_4c_Optiongroup1.Value         = 1
2059:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe o Cart" + CHR(227) + "o"
2060:         CATCH TO loc_oErro
2061:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
2062:         ENDTRY
2063:     ENDPROC
2064: 
2065:     *==========================================================================
2066:     * CarregarLista - Compatibilidade FormBase: dialogo TEF nao tem lista
2067:     * Retorna .T. (sem carregamento de dados tabulares neste dialogo flat)
2068:     *==========================================================================
2069:     PROCEDURE CarregarLista()
2070:         RETURN .T.
2071:     ENDPROC
2072: 
2073:     *==========================================================================
2074:     * AjustarBotoesPorModo - Ajusta botao Cancelar conforme estado TEF
2075:     * ProxCmd=23 (PIN/Senha): desabilita Cancelar; outros estados: habilita
2076:     *==========================================================================
2077:     PROCEDURE AjustarBotoesPorModo()
2078:         LOCAL loc_oErro
2079:         TRY
2080:             IF THIS.this_nProxCmd = 23
2081:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .F.
2082:             ELSE
2083:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = .T.
2084:             ENDIF
2085:         CATCH TO loc_oErro
2086:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
2087:         ENDTRY
2088:     ENDPROC
2089: 
2090:     *==========================================================================
2091:     * Destroy - Libera recursos ao fechar o dialogo
2092:     *==========================================================================
2093:     PROCEDURE Destroy()
2094:         LOCAL loc_oErro
2095:         TRY
2096:             IF EMPTY(THIS.this_cResultado)
2097:                 THIS.this_cResultado = THIS.this_oBusinessObject.ObterRetornoStr( ;
2098:                     THIS.this_cSaque, THIS.this_nParcs, THIS.this_dData)
2099:             ENDIF
2100:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2101:                 THIS.this_oBusinessObject = .NULL.
2102:             ENDIF
2103:             IF USED("crSigOpFp")
2104:                 USE IN crSigOpFp
2105:             ENDIF
2106:             IF USED("crSigCdEmp")
2107:                 USE IN crSigCdEmp
2108:             ENDIF
2109:             IF USED("crSiTef")
2110:                 USE IN crSiTef
2111:             ENDIF
2112:         CATCH TO loc_oErro
2113:             *-- Silencioso: Destroy nao deve abrir dialogs (pode causar erros em cascata)
2114:         ENDTRY
2115:         DODEFAULT()
2116:     ENDPROC
2117: 
2118: ENDDEFINE


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

