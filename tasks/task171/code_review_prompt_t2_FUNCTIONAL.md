# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterResultado()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExtrairCampoBuf()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarLoopSiTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRDFT.Container1): Top original=14 vs migrado 'lbl_4c_Label11' Top=268 (diff=254px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRDFT.Container1): Left original=18 vs migrado 'lbl_4c_Label11' Left=98 (diff=80px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2597 linhas total):

*-- Linhas 9 a 274:
9: *   BD   -> Usa SigOpFp, SigCdEmp, SigFiMpF para config (schema identico)
10: *   CODE -> Arquitetura em camadas (FormBase / sigprdftBO)
11: *
12: * Chamada: CREATEOBJECT("Formsigprdft", cEndSiTef, nValPago, cCupom, cCaixa,
13: *           cDebCred, cTipPagto, nNumParcs, nIdent, cOpers)
14: * Retorno: ObterResultado() apos Show() ou via Unload
15: *==============================================================================
16: 
17: DEFINE CLASS Formsigprdft AS FormBase
18: 
19:     *-- Dimensoes e propriedades visuais (SCX original: Width=500, Height=370)
20:     Height      = 370
21:     Width       = 500
22:     BorderStyle = 2
23:     AutoCenter  = .T.
24:     Caption     = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
25:     ShowWindow = 1
26:     ControlBox  = .F.
27:     MaxButton   = .F.
28:     MinButton   = .F.
29:     KeyPreview  = .T.
30:     TitleBar    = 0
31:     WindowType  = 1
32:     ShowTips    = .T.
33:     Themes      = .F.
34:     AlwaysOnTop = .T.
35: 
36:     *-- Business Object
37:     this_oBusinessObject = .NULL.
38: 
39:     *-- Propriedades de estado do form TEF
40:     *-- (Convertidas de PUBLIC vars do legado para propriedades encapsuladas)
41:     this_lKeyEsc    = .T.    && pckeyesc - habilita ESC para cancelar
42:     this_lTvenda    = .T.    && pctvenda - habilita selecao de tipo de venda
43:     this_cBandeira  = ""     && pcBandeira - bandeira do cartao (5 digitos)
44:     this_lsCartao   = ""     && lsCartao - primeiros 5 digitos do cartao
45:     this_lAbandona  = .F.    && abandona - flag de abandono da transacao
46:     this_lTipoVenda = .F.    && llTipoVenda - fluxo de selecao de tipo de venda detectado
47: 
48:     *==========================================================================
49:     * Init - Recebe parametros TEF, inicializa BO e chama FormBase.Init
50:     * Equivale ao PROCEDURE Init do legado com PARAMETERS EndSiTef, ValPago, ...
51:     *
52:     * Parametros (via CREATEOBJECT):
53:     *   par_cEndSiTef  - Endereco IP/DNS do servidor SiTef
54:     *   par_nValPago   - Valor da transacao (numerico)
55:     *   par_cCupom     - Numero do cupom fiscal
56:     *   par_cCaixa     - Identificador do caixa/terminal
57:     *   par_cDebCred   - Modalidade: "D"=Debito, "C"=Credito, "P"=Pre-datado
58:     *   par_cTipPagto  - Tipo de pagamento (codigo)
59:     *   par_nNumParcs  - Numero de parcelas
60:     *   par_nIdent     - Identificador da transacao (ltIdent no legado)
61:     *   par_cOpers     - Codigo da forma de pagamento (FPags em SigOpFp)
62:     *==========================================================================
63:     PROCEDURE Init(par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
64:                    par_cDebCred, par_cTipPagto, par_nNumParcs, par_nIdent, par_cOpers)
65:         LOCAL loc_lSucesso, loc_oErro
66:         loc_lSucesso = .F.
67: 
68:         TRY
69:             *-- Instancia o BO antes de DODEFAULT() para que InicializarForm o encontre
70:             THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")
71: 
72:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
73:                 *-- Transfere parametros de entrada para o BO
74:                 THIS.this_oBusinessObject.this_cEndSiTef  = ;
75:                     IIF(VARTYPE(par_cEndSiTef)  = "C", ALLTRIM(par_cEndSiTef),  "")
76:                 THIS.this_oBusinessObject.this_nValPago   = ;
77:                     IIF(VARTYPE(par_nValPago)   = "N", par_nValPago,             0)
78:                 THIS.this_oBusinessObject.this_cCupom     = ;
79:                     IIF(VARTYPE(par_cCupom)     = "C", ;
80:                         TRANSFORM(par_cCupom, "@L 999999"), "")
81:                 THIS.this_oBusinessObject.this_cCaixa     = ;
82:                     IIF(VARTYPE(par_cCaixa)     = "C", par_cCaixa,               "")
83:                 THIS.this_oBusinessObject.this_cDebCred   = ;
84:                     IIF(VARTYPE(par_cDebCred)   = "C", par_cDebCred,             "")
85:                 THIS.this_oBusinessObject.this_cTipPagto  = ;
86:                     IIF(VARTYPE(par_cTipPagto)  = "C", par_cTipPagto,            "")
87:                 THIS.this_oBusinessObject.this_nNumParcs  = ;
88:                     IIF(VARTYPE(par_nNumParcs)  = "N", par_nNumParcs,            0)
89:                 THIS.this_oBusinessObject.this_nIdent     = ;
90:                     IIF(VARTYPE(par_nIdent)     = "N", par_nIdent,               0)
91:                 THIS.this_oBusinessObject.this_cOpers     = ;
92:                     IIF(VARTYPE(par_cOpers)     = "C", par_cOpers,               "")
93: 
94:                 *-- Estado inicial da transacao
95:                 THIS.this_oBusinessObject.this_cParcs  = ;
96:                     TRANSFORM(THIS.this_oBusinessObject.this_nNumParcs, "@L 99")
97:                 THIS.this_oBusinessObject.this_cSaque  = "0,00"
98:                 THIS.this_oBusinessObject.this_dData   = DATE()
99:                 THIS.this_oBusinessObject.this_lDCD    = .F.
100:                 THIS.this_oBusinessObject.this_cBuffer = SPACE(2000)
101:                 THIS.this_oBusinessObject.this_nContinua = 0
102:                 THIS.this_oBusinessObject.this_nCiclos   = 0
103: 
104:                 *-- DODEFAULT() chama FormBase.Init() que chama InicializarForm()
105:                 loc_lSucesso = DODEFAULT()
106:             ELSE
107:                 MsgErro("Erro ao criar sigprdftBO", "Inicializa" + CHR(231) + CHR(227) + "o")
108:             ENDIF
109: 
110:         CATCH TO loc_oErro
111:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
112:                 "Erro Init TEF")
113:         ENDTRY
114: 
115:         RETURN loc_lSucesso
116:     ENDPROC
117: 
118:     *==========================================================================
119:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
120:     * Carrega config do banco, declara DLLs, constroi layout visual
121:     *==========================================================================
122:     PROTECTED PROCEDURE InicializarForm()
123:         LOCAL loc_lSucesso, loc_oErro
124:         loc_lSucesso = .F.
125: 
126:         TRY
127:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
128:                 *-- Modo validacao de UI: apenas constroi layout sem SQL
129:                 THIS.ConfigurarLayout()
130:                 loc_lSucesso = .T.
131:             ELSE
132:                 IF gnConnHandle <= 0
133:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
134:                     "o Com o Servidor de Banco de Dados...", ;
135:                     "Conex" + CHR(227) + "o")
136:             ELSE
137:                 *-- Carrega configuracao SigOpFp (tipo cartao, CDC, garantias, saque)
138:                 THIS.this_oBusinessObject.CarregarConfig( ;
139:                     THIS.this_oBusinessObject.this_cOpers)
140: 
141:                 *-- Carrega numero do caixa de SigFiMpF
142:                 THIS.this_oBusinessObject.CarregarCaixa( ;
143:                     THIS.this_oBusinessObject.this_cCaixa)
144: 
145:                 *-- Declara funcoes da DLL SiTef (equivale ao PROCEDURE Load legado)
146:                 IF THIS.InicializarDLLs()
147:                     *-- Constroi o layout visual (form plano sem PageFrame)
148:                     THIS.ConfigurarLayout()
149: 
150:                     *-- Ajusta estado inicial dos controles conforme config carregada
151:                     THIS.AjustarComportamento()
152: 
153:                     *-- Torna todos os controles visiveis apos AddObject
154:                     THIS.TornarControlesVisiveis()
155: 
156:                     *-- Form de pagamento sempre no topo
157:                     THIS.AlwaysOnTop = .T.
158:                     THIS.ZOrder(0)
159: 
160:                     loc_lSucesso = .T.
161:                 ENDIF
162:                 ENDIF
163:             ENDIF
164:         CATCH TO loc_oErro
165:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
166:                 " PROC=" + loc_oErro.Procedure, "Erro InicializarForm")
167:         ENDTRY
168: 
169:         RETURN loc_lSucesso
170:     ENDPROC
171: 
172:     *==========================================================================
173:     * InicializarDLLs - Declara as funcoes da DLL CliSiTef32I.DLL
174:     * Equivale ao PROCEDURE Load do formulario legado
175:     * Retorna .T. se DLL disponivel, .F. se nao encontrada
176:     *==========================================================================
177:     PROTECTED FUNCTION InicializarDLLs() AS Boolean
178:         LOCAL loc_lSucesso, loc_oErro
179:         loc_lSucesso = .F.
180: 
181:         TRY
182:             DECLARE Integer ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
183:                 String lsEndereco, String lsLoja, String lsTerminal, Integer lnReservado
184: 
185:             DECLARE Integer IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
186:                 Integer lnModalidade, String lsValor, String lsCupom, ;
187:                 String lsData, String lsHorario, String lsOperador, String lsRestricao
188: 
189:             DECLARE Integer ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
190:                 Integer @lnComando, Integer @lnTipo, ;
191:                 Integer @lnMinimo, Integer @lnMaximo, ;
192:                 String @lsBuffer, Integer lnTamanho, Integer lnResultado
193: 
194:             DECLARE Integer FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
195:                 Integer lnConfirma, String lsCupom, String lsData, String lsHorario
196: 
197:             loc_lSucesso = .T.
198:         CATCH TO loc_oErro
199:             MsgErro("DLL SiTef n" + CHR(227) + "o encontrada: " + ;
200:                 loc_oErro.Message, "DLL CliSiTef32I")
201:         ENDTRY
202: 
203:         RETURN loc_lSucesso
204:     ENDFUNC
205: 
206:     *==========================================================================
207:     * ConfigurarLayout - Constroi controles visuais do form plano (sem PageFrame)
208:     * O form legado nao tem PageFrame - e um dialog flat de 500x370
209:     *==========================================================================
210:     PROTECTED PROCEDURE ConfigurarLayout()
211:         LOCAL loc_oErro
212: 
213:         TRY
214:             THIS.ConfigurarCabecalho()
215:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
216:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
217:             THIS.ConfigurarSaida()
218:             THIS.ConfigurarShape()
219:             THIS.ConfigurarContainer1()
220:             THIS.ConfigurarCamposEntrada()
221:             THIS.ConfigurarOptionGroup()
222:             THIS.VincularEventos()
223:         CATCH TO loc_oErro
224:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
225:                 "Erro ConfigurarLayout")
226:         ENDTRY
227:     ENDPROC
228: 
229:     *==========================================================================
230:     * ConfigurarCabecalho - Container sombra/titulo cinza no topo
231:     * Equivale ao cntSombra do legado (Top=0, Width=800, Height=80)
232:     * No novo sistema: Width = THIS.Width (500px)
233:     *==========================================================================
234:     PROTECTED PROCEDURE ConfigurarCabecalho()
235:         LOCAL loc_oCnt
236: 
237:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
238:         loc_oCnt = THIS.cnt_4c_Cabecalho
239: 
240:         WITH loc_oCnt
241:             .Top         = 0
242:             .Left        = 0
243:             .Width       = THIS.Width
244:             .Height      = 80
245:             .BorderWidth = 0
246:             .BackColor   = RGB(100,100,100)
247: 
248:             .AddObject("lbl_4c_Sombra", "Label")
249:             WITH .lbl_4c_Sombra
250:                 .AutoSize      = .F.
251:                 .FontBold      = .T.
252:                 .FontName      = "Tahoma"
253:                 .FontSize      = 18
254:                 .FontUnderline = .F.
255:                 .WordWrap      = .T.
256:                 .Alignment     = 0
257:                 .BackStyle     = 0
258:                 .Caption       = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
259:                 .Height        = 40
260:                 .Left          = 10
261:                 .Top           = 18
262:                 .Width         = THIS.Width
263:                 .ForeColor     = RGB(0,0,0)
264:             ENDWITH
265: 
266:             .AddObject("lbl_4c_Titulo", "Label")
267:             WITH .lbl_4c_Titulo
268:                 .AutoSize   = .F.
269:                 .FontBold   = .T.
270:                 .FontName   = "Tahoma"
271:                 .FontSize   = 18
272:                 .WordWrap   = .T.
273:                 .Alignment  = 0
274:                 .BackStyle  = 0

*-- Linhas 287 a 430:
287:     * Equivale ao SAIDA commandgroup do legado
288:     * Top=-2 (sobrepoe o cabecalho), Left=420 (borda direita do form 500px)
289:     *==========================================================================
290:     PROTECTED PROCEDURE ConfigurarSaida()
291:         LOCAL loc_oCg
292: 
293:         THIS.AddObject("cnt_4c_Saida", "CommandGroup")
294:         loc_oCg = THIS.cnt_4c_Saida
295: 
296:         WITH loc_oCg
297:             .ButtonCount = 1
298:             .BackStyle   = 0
299:             .BorderStyle = 0
300:             .Value       = 0
301:             .Height      = 85
302:             .Left        = 420
303:             .Top         = -2
304:             .Width       = 85
305:             .TabIndex    = 8
306:             .BackColor   = RGB(255,255,255)
307:             .Themes      = .F.
308: 
309:             WITH .Buttons(1)
310:                 .Top                = 5
311:                 .Left               = 5
312:                 .Height             = 75
313:                 .Width              = 75
314:                 .FontBold           = .T.
315:                 .FontItalic         = .T.
316:                 .FontName           = "Tahoma"
317:                 .FontSize           = 8
318:                 .Picture            = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
319:                 .DisabledPicture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
320:                 .Caption            = "Cancelar"
321:                 .Cancel             = .F.
322:                 .ForeColor          = RGB(90,90,90)
323:                 .BackColor          = RGB(255,255,255)
324:                 .Themes             = .F.
325:                 .SpecialEffect      = 0
326:                 .PicturePosition    = 13
327:                 .MousePointer       = 15
328:                 .WordWrap           = .T.
329:                 .AutoSize           = .F.
330:             ENDWITH
331:         ENDWITH
332:     ENDPROC
333: 
334:     *==========================================================================
335:     * ConfigurarShape - Shape decorativo ao redor dos campos de entrada
336:     * Equivale ao Shape2 do legado (Top=93, Left=17, Height=202, Width=466)
337:     *==========================================================================
338:     PROTECTED PROCEDURE ConfigurarShape()
339:         THIS.AddObject("shp_4c_Shape2", "Shape")
340: 
341:         WITH THIS.shp_4c_Shape2
342:             .Top           = 93
343:             .Left          = 17
344:             .Height        = 202
345:             .Width         = 466
346:             .SpecialEffect = 0
347:         ENDWITH
348:     ENDPROC
349: 
350:     *==========================================================================
351:     * ConfigurarContainer1 - Container de instrucao ao usuario
352:     * Equivale ao Container1 do legado (Top=298, Left=54, Width=392, Height=58)
353:     * Exibe mensagem como "Insira ou Passe o Cartao", "Digite a Senha", etc.
354:     *==========================================================================
355:     PROTECTED PROCEDURE ConfigurarContainer1()
356:         LOCAL loc_oCnt
357: 
358:         THIS.AddObject("cnt_4c_Instrucao", "Container")
359:         loc_oCnt = THIS.cnt_4c_Instrucao
360: 
361:         WITH loc_oCnt
362:             .Top           = 298
363:             .Left          = 54
364:             .Width         = 392
365:             .Height        = 58
366:             .SpecialEffect = 0
367: 
368:             .AddObject("lbl_4c_Instrucao", "Label")
369:             WITH .lbl_4c_Instrucao
370:                 .AutoSize   = .F.
371:                 .FontBold   = .T.
372:                 .FontName   = "Tahoma"
373:                 .FontSize   = 18
374:                 .Alignment  = 2
375:                 .Caption    = "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
376:                 .Height     = 29
377:                 .Left       = 18
378:                 .Top        = 14
379:                 .Width      = 349
380:                 .ForeColor  = RGB(90,90,90)
381:                 .BackStyle  = 0
382:             ENDWITH
383:         ENDWITH
384:     ENDPROC
385: 
386:     *==========================================================================
387:     * AjustarComportamento - Ajusta estado inicial apos carregar config do banco
388:     * Inicializa flags que controlam habilitacao de campos e cancelamento ESC
389:     *==========================================================================
390:     PROTECTED PROCEDURE AjustarComportamento()
391:         LOCAL loc_oBO, loc_oErro
392:         loc_oBO = THIS.this_oBusinessObject
393: 
394:         TRY
395:             THIS.this_lKeyEsc    = .T.
396:             THIS.this_lAbandona  = .F.
397:             THIS.this_lTipoVenda = .F.
398: 
399:             *-- Valor formatado no campo de exibicao (readonly)
400:             IF VARTYPE(THIS.txt_4c_Valor) = "O"
401:                 THIS.txt_4c_Valor.Value = STRTRAN( ;
402:                     ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")
403:             ENDIF
404: 
405:             *-- Data inicial para parcelado/pre-datado
406:             IF VARTYPE(THIS.txt_4c_Datas) = "O"
407:                 THIS.txt_4c_Datas.Value = DATE()
408:             ENDIF
409: 
410:             *-- Numero de parcelas
411:             IF VARTYPE(THIS.txt_4c_Text1) = "O"
412:                 THIS.txt_4c_Text1.Value = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")
413:             ENDIF
414: 
415:             *-- Se cartao fisico disponivel: habilita campo numero do cartao
416:             IF loc_oBO.this_cLCartao = "S"
417:                 IF VARTYPE(THIS.txt_4c_Cartao) = "O"
418:                     THIS.txt_4c_Cartao.Enabled = .T.
419:                 ENDIF
420:                 IF VARTYPE(THIS.lbl_4c_Label2) = "O"
421:                     THIS.lbl_4c_Label2.Caption = "Validade Cart" + CHR(227) + "o :"
422:                 ENDIF
423:             ENDIF
424: 
425:             *-- Instrucao inicial conforme tipo de entrada do cartao
426:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
427:                 IF VARTYPE(THIS.txt_4c_Datas) = "O" AND !THIS.txt_4c_Datas.Enabled
428:                     IF loc_oBO.this_cLCartao = "N"
429:                         THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
430:                             "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"

*-- Linhas 438 a 629:
438:                 ENDIF
439:             ENDIF
440: 
441:             *-- OptionGroup de tipo de venda: desabilitado ate completar handshake SiTef
442:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
443:                 THIS.obj_4c_TipoVenda.Enabled = .F.
444:             ENDIF
445: 
446:             *-- BackColor do campo de digitos: cinza (aguardando GetFocus)
447:             IF VARTYPE(THIS.txt_4c_Digitos) = "O"
448:                 THIS.txt_4c_Digitos.BackColor = 12632256
449:             ENDIF
450: 
451:         CATCH TO loc_oErro
452:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
453:                 "Erro AjustarComportamento")
454:         ENDTRY
455:     ENDPROC
456: 
457:     *==========================================================================
458:     * TornarControlesVisiveis - Torna todos os controles visiveis apos AddObject
459:     * AddObject cria controles com Visible=.F. por default
460:     *==========================================================================
461:     PROCEDURE TornarControlesVisiveis()
462:         LOCAL loc_nI, loc_oCtrl
463: 
464:         FOR loc_nI = 1 TO THIS.ControlCount
465:             loc_oCtrl = THIS.Controls(loc_nI)
466:             IF VARTYPE(loc_oCtrl) = "O"
467:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
468:                     loc_oCtrl.Visible = .T.
469:                 ENDIF
470:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
471:                    loc_oCtrl.ControlCount > 0
472:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
473:                 ENDIF
474:             ENDIF
475:         ENDFOR
476:     ENDPROC
477: 
478:     *==========================================================================
479:     * TornarFilhosVisiveis - Recursao para sub-controles
480:     *==========================================================================
481:     PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
482:         LOCAL loc_nI, loc_oCtrl
483: 
484:         FOR loc_nI = 1 TO par_oContainer.ControlCount
485:             loc_oCtrl = par_oContainer.Controls(loc_nI)
486:             IF VARTYPE(loc_oCtrl) = "O"
487:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
488:                     loc_oCtrl.Visible = .T.
489:                 ENDIF
490:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
491:                    loc_oCtrl.ControlCount > 0
492:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
493:                 ENDIF
494:             ENDIF
495:         ENDFOR
496:     ENDPROC
497: 
498:     *==========================================================================
499:     * KeyPress - Intercepta ESC para cancelar a transacao
500:     * Equivale ao PROCEDURE KeyPress do legado (KeyPreview=.T. na classe)
501:     *==========================================================================
502:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
503: 
504:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
505:             NODEFAULT
506:             IF VARTYPE(THIS.cnt_4c_Saida) = "O"
507:                 THIS.cnt_4c_Saida.Buttons(1).Click()
508:             ENDIF
509:         ENDIF
510:     ENDPROC
511: 
512:     *==========================================================================
513:     * ObterResultado - Retorna resultado da transacao para o chamador
514:     * Formato: "cSaque/nParcs/dData+cBandeira+cCartao"
515:     *==========================================================================
516:     FUNCTION ObterResultado() AS String
517:         LOCAL loc_cResultado
518: 
519:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
520:             loc_cResultado = THIS.this_oBusinessObject.ObterResultadoFinal()
521:         ELSE
522:             loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
523:         ENDIF
524: 
525:         RETURN loc_cResultado
526:     ENDFUNC
527: 
528:     *==========================================================================
529:     * Unload - Retorna resultado ao fechar o form
530:     * Equivale ao PROCEDURE Unload do legado que faz RETURN(lcSaque+...)
531:     *==========================================================================
532:     PROCEDURE Unload()
533:         RETURN THIS.ObterResultado()
534:     ENDPROC
535: 
536:     *==========================================================================
537:     * Destroy - Limpeza ao destruir o formulario
538:     * Equivale ao PROCEDURE Release do legado
539:     *==========================================================================
540:     PROCEDURE Destroy()
541:         LOCAL loc_oErro
542: 
543:         TRY
544:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
545:                 THIS.this_oBusinessObject = .NULL.
546:             ENDIF
547:         CATCH TO loc_oErro
548:             MsgErro(loc_oErro.Message, "Erro Destroy TEF")
549:         ENDTRY
550: 
551:         DODEFAULT()
552:     ENDPROC
553: 
554:     *==========================================================================
555:     * AlternarPagina - Nao aplicavel para form plano TEF (sem PageFrame)
556:     * Metodo requerido pelo pipeline de migracao multi-fase
557:     *==========================================================================
558:     PROCEDURE AlternarPagina(par_nPagina)
559:         *-- Form TEF e plano (sem Pages) - nao ha paginas para alternar
560:         RETURN
561:     ENDPROC
562: 
563:     *==========================================================================
564:     * ConfigurarPaginaLista - Nao aplicavel: form plano OPERACIONAL sem lista/grid
565:     * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 4)
566:     * O layout deste dialog TEF/SiTef eh construido em ConfigurarLayout() e nao
567:     * possui Page1/Grid CRUD (form flat 500x370 com campos de pagamento)
568:     *==========================================================================
569:     PROTECTED PROCEDURE ConfigurarPaginaLista()
570:         *-- No-op: form TEF nao tem lista de registros (dialog modal de transacao)
571:         RETURN
572:     ENDPROC
573: 
574:     *==========================================================================
575:     * ConfigurarPaginaDados - Nao aplicavel: form plano OPERACIONAL sem Page2
576:     * Para forms OPERACIONAIS com layout flat (dialog TEF/SiTef), todos os campos
577:     * sao inicializados em ConfigurarCamposEntrada() e ConfigurarOptionGroup().
578:     * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 5)
579:     *==========================================================================
580:     PROTECTED PROCEDURE ConfigurarPaginaDados()
581:         *-- No-op: form TEF nao tem Page2 (Dados) - dialog flat 500x370
582:         RETURN
583:     ENDPROC
584: 
585:     *==========================================================================
586:     * ConfigurarCamposEntrada - Campos de entrada de dados do cartao e pagamento
587:     * Equivale a GetValor, GetCartao, GetDigitos, Text1, GetDatas + Labels legado
588:     *==========================================================================
589:     PROTECTED PROCEDURE ConfigurarCamposEntrada()
590:         LOCAL loc_oErro
591:         TRY
592:             *-- Label5: VALOR : (SCX original: AutoSize=.T., FontBold=.T.)
593:             THIS.AddObject("lbl_4c_Label5", "Label")
594:             WITH THIS.lbl_4c_Label5
595:                 .AutoSize  = .T.
596:                 .FontBold  = .T.
597:                 .Caption   = "VALOR :"
598:                 .Top       = 102
599:                 .Left      = 175
600:                 .Width     = 45
601:                 .Height    = 15
602:                 .FontName  = "Tahoma"
603:                 .FontSize  = 8
604:                 .ForeColor = RGB(90,90,90)
605:                 .BackStyle = 0
606:             ENDWITH
607: 
608:             *-- GetValor -> txt_4c_Valor: exibe valor formatado
609:             *-- SCX original: Enabled=.F. (nao ReadOnly), FontBold=.T., Alignment=3, InputMask, Value=0
610:             THIS.AddObject("txt_4c_Valor", "TextBox")
611:             WITH THIS.txt_4c_Valor
612:                 .Top       = 99
613:                 .Left      = 222
614:                 .Width     = 100
615:                 .Height    = 23
616:                 .FontBold  = .T.
617:                 .FontName  = "Tahoma"
618:                 .FontSize  = 8
619:                 .Alignment = 3
620:                 .Enabled   = .F.
621:                 .InputMask = "99,999,999.99"
622:                 .ForeColor = RGB(0,0,0)
623:                 .TabIndex  = 1
624:                 .Value     = 0
625:             ENDWITH
626: 
627:             *-- Label8: NUMERO CARTAO : (SCX original: AutoSize=.T., FontBold=.T., sem acento)
628:             THIS.AddObject("lbl_4c_Label8", "Label")
629:             WITH THIS.lbl_4c_Label8

*-- Linhas 776 a 908:
776:     ENDPROC
777: 
778:     *==========================================================================
779:     * ConfigurarOptionGroup - OptionGroup tipo de venda (A Vista / Parcelado)
780:     * Equivale ao Optiongroup1 legado (Top=200, Left=222, W=161, H=26)
781:     *==========================================================================
782:     PROTECTED PROCEDURE ConfigurarOptionGroup()
783:         LOCAL loc_oErro
784:         TRY
785:             THIS.AddObject("obj_4c_TipoVenda", "OptionGroup")
786: 
787:             WITH THIS.obj_4c_TipoVenda
788:                 .Top         = 200
789:                 .Left        = 222
790:                 .Width       = 161
791:                 .Height      = 26
792:                 .ButtonCount = 2
793:                 .Value       = 1
794:                 .BackStyle   = 0
795:                 .BorderStyle = 0
796:                 .TabIndex    = 6
797: 
798:                 WITH .Buttons(1)
799:                     .Caption   = CHR(192) + " Vista"
800:                     .Top       = 2
801:                     .Left      = 0
802:                     .Width     = 70
803:                     .Height    = 20
804:                     .BackStyle = 0
805:                     .ForeColor = RGB(90,90,90)
806:                 ENDWITH
807: 
808:                 WITH .Buttons(2)
809:                     .Caption   = "Parcelado"
810:                     .Top       = 2
811:                     .Left      = 75
812:                     .Width     = 80
813:                     .Height    = 20
814:                     .FontName  = "Tahoma"
815:                     .FontSize  = 8
816:                     .BackStyle = 0
817:                     .ForeColor = RGB(90,90,90)
818:                 ENDWITH
819:             ENDWITH
820: 
821:         CATCH TO loc_oErro
822:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
823:                 "Erro ConfigurarOptionGroup")
824:         ENDTRY
825:     ENDPROC
826: 
827:     *==========================================================================
828:     * VincularEventos - BINDEVENT todos os handlers de eventos dos controles
829:     *==========================================================================
830:     PROTECTED PROCEDURE VincularEventos()
831:         LOCAL loc_oErro
832:         TRY
833:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",         THIS, "TxtDigitosGotFocus")
834:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",         THIS, "TxtDigitosKeyPress")
835:             BINDEVENT(THIS.txt_4c_Text1,   "GotFocus",         THIS, "TxtText1GotFocus")
836:             BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",       THIS, "TxtText1LostFocus")
837:             BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",         THIS, "TxtText1KeyPress")
838:             BINDEVENT(THIS.txt_4c_Datas,   "GotFocus",         THIS, "TxtDatasGotFocus")
839:             BINDEVENT(THIS.txt_4c_Datas,   "KeyPress",         THIS, "TxtDatasKeyPress")
840:             BINDEVENT(THIS.obj_4c_TipoVenda, "InteractiveChange", THIS, "OgTipoVendaInteractiveChange")
841:             BINDEVENT(THIS.obj_4c_TipoVenda, "KeyPress",          THIS, "OgTipoVendaKeyPress")
842:             BINDEVENT(THIS.cnt_4c_Saida.Buttons(1), "Click",  THIS, "CmdCancelaClick")
843:         CATCH TO loc_oErro
844:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
845:                 "Erro VincularEventos")
846:         ENDTRY
847:     ENDPROC
848: 
849:     *==========================================================================
850:     * AtualizarInstrucao - Atualiza label de instrucao ao usuario
851:     * Equivale a ThisForm.Container1.Label1.Caption = ... no legado
852:     *==========================================================================
853:     PROCEDURE AtualizarInstrucao(par_cTexto)
854:         LOCAL loc_oErro
855:         TRY
856:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O" AND ;
857:                VARTYPE(THIS.cnt_4c_Instrucao.lbl_4c_Instrucao) = "O"
858:                 THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = par_cTexto
859:             ENDIF
860:         CATCH TO loc_oErro
861:             MsgErro(loc_oErro.Message, "Erro AtualizarInstrucao")
862:         ENDTRY
863:     ENDPROC
864: 
865:     *==========================================================================
866:     * CancelarTransacao - Grava retorno de falha e fecha o form
867:     *==========================================================================
868:     PROCEDURE CancelarTransacao(par_cMensagem)
869:         LOCAL loc_cMsg
870:         loc_cMsg = IIF(EMPTY(par_cMensagem), ;
871:             "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio", ;
872:             par_cMensagem)
873:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
874:             THIS.this_oBusinessObject.RetornoFalha(loc_cMsg, ;
875:                 THIS.this_oBusinessObject.this_nValPago)
876:         ENDIF
877:         THIS.Release()
878:     ENDPROC
879: 
880:     *==========================================================================
881:     * ExecutarLoopSiTef - Loop principal de interacao com ContinuaFuncaoSiTefInterativo
882:     * Roda ate cmd=22 (aguarda entrada usuario) ou cmd=30 (fim transacao)
883:     * par_nContinua: 1000=novo/dado enviado, 0=ack mensagem, -1=cancelar
884:     * Retorna .T. se parou em cmd=22 (esperando entrada), .F. se cmd=30 ou erro
885:     *==========================================================================
886:     FUNCTION ExecutarLoopSiTef(par_nContinua AS Integer) AS Boolean
887:         LOCAL loc_oBO, loc_lParouEmEntrada, loc_oErro
888:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
889:         LOCAL loc_nCont, loc_lFimLoop
890:         loc_lParouEmEntrada = .F.
891:         loc_lFimLoop = .F.
892:         loc_nCont = par_nContinua
893:         loc_oBO = THIS.this_oBusinessObject
894: 
895:         TRY
896:             DO WHILE !loc_lFimLoop
897:                 loc_nCmd  = loc_oBO.this_nProximoComando
898:                 loc_nTipo = loc_oBO.this_nTipoCampo
899:                 loc_nMin  = loc_oBO.this_nTamanhoMinimo
900:                 loc_nMax  = loc_oBO.this_nTamanhoMaximo
901:                 loc_cBuf  = SPACE(2000)
902: 
903:                 loc_nRet = ContinuaFuncaoSiTefInterativo( ;
904:                     @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
905:                     @loc_cBuf, LEN(loc_cBuf), loc_nCont)
906: 
907:                 loc_oBO.this_nProximoComando = loc_nCmd
908:                 loc_oBO.this_nTipoCampo      = loc_nTipo

*-- Linhas 1005 a 1048:
1005:     * ProcessarFimTransacao - Processa resultado quando cmd=30 (fim transacao)
1006:     * Confirma no SiTef, coleta campos de retorno e grava arquivos de resposta
1007:     *==========================================================================
1008:     PROCEDURE ProcessarFimTransacao()
1009:         LOCAL loc_oBO, loc_cData, loc_cHora, loc_oErro, loc_cBuf
1010:         loc_oBO = THIS.this_oBusinessObject
1011:         TRY
1012:             *-- Data/hora para finalizacao
1013:             loc_cData = STR(YEAR(DATE()), 4) + ;
1014:                         SUBSTR(DTOC(DATE()), 4, 2) + ;
1015:                         SUBSTR(DTOC(DATE()), 1, 2)
1016:             loc_cHora = STRTRAN(TIME(), ":", "")
1017: 
1018:             *-- Confirma transacao no SiTef (1=confirmar)
1019:             FinalizaTransacaoSiTefInterativo(1, loc_oBO.this_cCupom, loc_cData, loc_cHora)
1020: 
1021:             *-- Extrai campos do buffer acumulado no BO (formato SiTef: campos separados por CHR(0))
1022:             loc_cBuf = ALLTRIM(loc_oBO.this_cBuffer)
1023:             IF !EMPTY(loc_cBuf)
1024:                 loc_oBO.this_cTipTran  = THIS.ExtrairCampoBuf(loc_cBuf, 1)
1025:                 loc_oBO.this_cDataHora = THIS.ExtrairCampoBuf(loc_cBuf, 2)
1026:                 loc_oBO.this_cCartao   = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 3)), 5)
1027:                 loc_oBO.this_cNsu      = THIS.ExtrairCampoBuf(loc_cBuf, 4)
1028:                 loc_oBO.this_cAutoriza = THIS.ExtrairCampoBuf(loc_cBuf, 5)
1029:                 loc_oBO.this_cBandeira = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 6)), 5)
1030:                 loc_oBO.this_cFinaliza = THIS.ExtrairCampoBuf(loc_cBuf, 7)
1031:             ENDIF
1032: 
1033:             *-- Grava arquivos de resposta C:\client\Resp\IntPos.*
1034:             loc_oBO.MontarRetorno( ;
1035:                 loc_oBO.this_cTipTran, ;
1036:                 loc_oBO.this_cDataHora, ;
1037:                 loc_oBO.this_cCupom, ;
1038:                 loc_oBO.this_cCartao + loc_oBO.this_cBandeira, ;
1039:                 loc_oBO.this_cNsu, ;
1040:                 loc_oBO.this_cAutoriza, ;
1041:                 loc_oBO.this_cFinaliza, ;
1042:                 loc_oBO.this_nValPago, ;
1043:                 loc_oBO.this_cMRet)
1044: 
1045:             THIS.Release()
1046: 
1047:         CATCH TO loc_oErro
1048:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 1078 a 1121:
1078:     * Inicializa conexao SiTef e executa loop inicial ate pedir entrada
1079:     * Equivale a GetDigitos.GotFocus do legado (231 linhas)
1080:     *==========================================================================
1081:     PROCEDURE TxtDigitosGotFocus()
1082:         LOCAL loc_oBO, loc_cValPago, loc_cIdTerminal, loc_nRet, loc_oErro
1083:         LOCAL loc_cData, loc_cHora, loc_lSucesso
1084:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1085:         LOCAL loc_nCont, loc_nTipo1, loc_cBandeira, loc_nTipoVendaCount
1086:         LOCAL loc_cDataFmt
1087:         loc_oBO = THIS.this_oBusinessObject
1088:         loc_lSucesso = .F.
1089: 
1090:         TRY
1091:             *-- ID do terminal: empresa (4 dig) + caixa (6 dig)
1092:             loc_cIdTerminal = TRANSFORM(loc_oBO.this_nEmps,    "@L 9999") + ;
1093:                               TRANSFORM(loc_oBO.this_nCncaixas, "@L 999999")
1094: 
1095:             *-- Formata valor para SiTef (virgula como separador decimal)
1096:             loc_cValPago = STRTRAN( ;
1097:                 ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")
1098: 
1099:             IF VARTYPE(THIS.txt_4c_Valor) = "O"
1100:                 THIS.txt_4c_Valor.Value = loc_cValPago
1101:             ENDIF
1102: 
1103:             *-- Configura interface SiTef (retorna 0 = sucesso)
1104:             loc_nRet = ConfiguraIntSiTefInterativo( ;
1105:                 loc_oBO.this_cEndSiTef, ;
1106:                 loc_cIdTerminal, ;
1107:                 loc_cIdTerminal, ;
1108:                 0)
1109:             IF loc_nRet = 0
1110:                 loc_lSucesso = .T.
1111:             ELSE
1112:                 THIS.CancelarTransacao("Sem comunica" + CHR(231) + CHR(227) + "o com SiTef")
1113:             ENDIF
1114: 
1115:             IF loc_lSucesso
1116:                 *-- Data e hora no formato SiTef (AAAAMMDD e HHMMSS)
1117:                 loc_cData = STR(YEAR(DATE()), 4) + ;
1118:                             SUBSTR(DTOC(DATE()), 4, 2) + ;
1119:                             SUBSTR(DTOC(DATE()), 1, 2)
1120:                 loc_cHora = STRTRAN(TIME(), ":", "")
1121: 

*-- Linhas 1156 a 1199:
1156:                 loc_oBO.this_cBandeira = ""
1157:                 loc_oBO.this_cMRet     = ""
1158: 
1159:                 *-- OptionGroup desabilitado ate concluir handshake
1160:                 IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
1161:                     THIS.obj_4c_TipoVenda.Enabled = .F.
1162:                 ENDIF
1163: 
1164:                 *-- Loop de inicializacao SiTef (apenas sem leitora fisica: lCartao="N")
1165:                 loc_nRet           = 10000
1166:                 loc_nCont          = 0
1167:                 loc_nTipo1         = 1
1168:                 loc_cBandeira      = ""
1169:                 loc_nTipoVendaCount = 0
1170: 
1171:                 IF loc_oBO.this_cLCartao = "N"
1172:                     DO WHILE loc_nRet = 10000
1173:                         loc_nCmd  = loc_oBO.this_nProximoComando
1174:                         loc_nTipo = loc_oBO.this_nTipoCampo
1175:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1176:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1177:                         loc_cBuf  = SPACE(2000)
1178: 
1179:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1180:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
1181:                             @loc_cBuf, LEN(loc_cBuf), loc_nCont)
1182: 
1183:                         loc_oBO.this_nProximoComando = loc_nCmd
1184:                         loc_oBO.this_nTipoCampo      = loc_nTipo
1185:                         loc_oBO.this_nTamanhoMinimo  = loc_nMin
1186:                         loc_oBO.this_nTamanhoMaximo  = loc_nMax
1187:                         loc_oBO.this_cBuffer         = loc_cBuf
1188: 
1189:                         *-- Deteccao de tipo de venda (string SiTef especifica)
1190:                         IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO"$UPPER(loc_cBuf)
1191:                             IF loc_nTipoVendaCount = 2
1192:                                 THIS.this_lTipoVenda = .T.
1193:                             ELSE
1194:                                 loc_nTipoVendaCount = 2
1195:                             ENDIF
1196:                         ENDIF
1197: 
1198:                         *-- Cancelar: desabilitado durante PIN
1199:                         IF VARTYPE(THIS.cnt_4c_Saida) = "O"

*-- Linhas 1436 a 1479:
1436:     * Envia os 4 digitos ao SiTef e continua o loop de transacao
1437:     * Equivale a GetDigitos.Valid do legado (185 linhas)
1438:     *==========================================================================
1439:     PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1440:         LOCAL loc_oBO, loc_cValDigitos, loc_oErro
1441:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1442:         LOCAL loc_nRet, loc_nCont, loc_lParcelas, loc_nCampo
1443: 
1444:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1445:             RETURN
1446:         ENDIF
1447: 
1448:         loc_oBO = THIS.this_oBusinessObject
1449: 
1450:         TRY
1451:             IF THIS.this_lAbandona
1452:                 THIS.Release()
1453:             ELSE
1454:                 loc_cValDigitos = ALLTRIM(THIS.txt_4c_Digitos.Value)
1455: 
1456:                 IF LEN(loc_cValDigitos) <> 4 AND !EMPTY(loc_cValDigitos)
1457:                     MsgErro("Quantidade de D" + CHR(237) + "gitos Inv" + CHR(225) + "lida", ;
1458:                         "Erro na Transa" + CHR(231) + CHR(227) + "o")
1459:                     THIS.txt_4c_Digitos.Value = ""
1460:                 ELSE
1461:                     IF !EMPTY(loc_cValDigitos)
1462:                     *-- Prepara buffer com os 4 digitos + padding
1463:                     loc_oBO.this_cBuffer = loc_cValDigitos + ;
1464:                         REPLICATE(CHR(0), 2000 - LEN(loc_cValDigitos))
1465:                     loc_oBO.this_nCiclos = 0
1466:                     loc_nRet     = 10000
1467:                     loc_nCont    = 1000
1468:                     loc_lParcelas = .F.
1469:                     loc_nCampo   = 1
1470: 
1471:                     DO WHILE loc_nRet = 10000
1472:                         loc_nCmd  = loc_oBO.this_nProximoComando
1473:                         loc_nTipo = loc_oBO.this_nTipoCampo
1474:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1475:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1476:                         loc_cBuf  = loc_oBO.this_cBuffer
1477: 
1478:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1479:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;

*-- Linhas 1713 a 1786:
1713:     * TxtText1GotFocus - GotFocus do campo de numero de parcelas
1714:     * Equivale a Text1.GotFocus do legado
1715:     *==========================================================================
1716:     PROCEDURE TxtText1GotFocus()
1717:         THIS.this_lTvenda = .F.
1718:     ENDPROC
1719: 
1720:     *==========================================================================
1721:     * TxtText1LostFocus - LostFocus do campo de numero de parcelas
1722:     * Formata o valor e habilita campo de data de vencimento
1723:     * Equivale a Text1.LostFocus do legado
1724:     *==========================================================================
1725:     PROCEDURE TxtText1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1726:         LOCAL loc_oErro
1727:         TRY
1728:             IF VARTYPE(THIS.txt_4c_Text1) = "O"
1729:                 THIS.txt_4c_Text1.Value = ;
1730:                     TRANSFORM(VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value))), "@L 99")
1731:                 THIS.txt_4c_Text1.Enabled = .F.
1732:                 IF VARTYPE(THIS.txt_4c_Datas) = "O"
1733:                     THIS.txt_4c_Datas.Enabled = .T.
1734:                 ENDIF
1735:             ENDIF
1736:         CATCH TO loc_oErro
1737:             MsgErro(loc_oErro.Message, "Erro TEF Text1 LostFocus")
1738:         ENDTRY
1739:     ENDPROC
1740: 
1741:     *==========================================================================
1742:     * TxtText1KeyPress - Simula Valid de Text1 via ENTER/TAB (numero de parcelas)
1743:     * Envia contagem de parcelas ao SiTef e continua loop
1744:     * Equivale a Text1.Valid do legado (22 linhas)
1745:     *==========================================================================
1746:     PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1747:         LOCAL loc_oBO, loc_nParcs, loc_oErro
1748: 
1749:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1750:             RETURN
1751:         ENDIF
1752: 
1753:         loc_oBO = THIS.this_oBusinessObject
1754: 
1755:         TRY
1756:             IF VARTYPE(THIS.txt_4c_Text1) = "O" AND !EMPTY(THIS.txt_4c_Text1.Value)
1757:                 loc_nParcs = VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value)))
1758:                 loc_oBO.this_nNumParcs = loc_nParcs
1759: 
1760:                 *-- Envia numero de parcelas ao SiTef no Buffer
1761:                 loc_oBO.this_cBuffer   = TRANSFORM(loc_nParcs, "@L 99") + ;
1762:                     REPLICATE(CHR(0), 1990)
1763:                 loc_oBO.this_nContinua = 1000
1764:                 loc_oBO.this_nCiclos   = 0
1765: 
1766:                 THIS.ExecutarLoopSiTef(1000)
1767: 
1768:                 IF loc_oBO.this_nProximoComando = 23
1769:                     IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1770:                         THIS.cnt_4c_Saida.Buttons(1).Enabled = .F.
1771:                     ENDIF
1772:                     THIS.AtualizarInstrucao("Digite a Senha")
1773:                 ELSE
1774:                     IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1775:                         THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
1776:                     ENDIF
1777:                 ENDIF
1778: 
1779:                 IF loc_oBO.this_nProximoComando = 30
1780:                     THIS.ProcessarFimTransacao()
1781:                 ENDIF
1782:             ENDIF
1783: 
1784:         CATCH TO loc_oErro
1785:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1786:                 "Erro TEF Parcelas KeyPress")

*-- Linhas 1792 a 1869:
1792:     * Inicia fluxo SiTef para modalidade pre-datada ou parcelada com data
1793:     * Equivale a GetDatas.GotFocus do legado (188 linhas)
1794:     *==========================================================================
1795:     PROCEDURE TxtDatasGotFocus()
1796:         LOCAL loc_oBO, loc_oErro
1797:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1798:         LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo
1799:         loc_oBO = THIS.this_oBusinessObject
1800: 
1801:         TRY
1802:             THIS.this_lTipoVenda = .F.
1803: 
1804:             *-- Zera campos de resultado acumulados no ciclo anterior
1805:             loc_oBO.this_cTipTran  = ""
1806:             loc_oBO.this_cDataHora = ""
1807:             loc_oBO.this_cNsu      = ""
1808:             loc_oBO.this_cAutoriza = ""
1809:             loc_oBO.this_cFinaliza = ""
1810:             loc_oBO.this_cCartao   = ""
1811:             loc_oBO.this_cBandeira = ""
1812:             loc_oBO.this_cMRet     = ""
1813: 
1814:             THIS.AtualizarInstrucao("Digite a Data" + CHR(13) + "de Vencimento")
1815: 
1816:             *-- Fluxo de tipo de venda: somente para debito simples (nao pre-datado, nao DCD, nao CDC)
1817:             IF loc_oBO.this_cDebCred <> "P" AND ;
1818:                !loc_oBO.this_lDCD AND ;
1819:                loc_oBO.this_cTcdc <> "S"
1820: 
1821:                 loc_nRet  = 10000
1822:                 loc_nCont = 1000
1823: 
1824:                 IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND THIS.obj_4c_TipoVenda.Enabled
1825:                     *-- OptionGroup habilitado: envia selecao do usuario
1826:                     loc_oBO.this_cBuffer = STR(THIS.obj_4c_TipoVenda.Value, 1) + ;
1827:                         REPLICATE(CHR(0), 1999)
1828:                 ELSE
1829:                     *-- OptionGroup desabilitado: aguarda SiTef chegar ao cmd=30 primeiro
1830:                     DO WHILE loc_oBO.this_nProximoComando <> 30
1831:                         loc_nCmd  = loc_oBO.this_nProximoComando
1832:                         loc_nTipo = loc_oBO.this_nTipoCampo
1833:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1834:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1835:                         loc_cBuf  = SPACE(2000)
1836: 
1837:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1838:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
1839:                             @loc_cBuf, LEN(loc_cBuf), loc_nCont)
1840: 
1841:                         loc_oBO.this_nProximoComando = loc_nCmd
1842:                         loc_oBO.this_nTipoCampo      = loc_nTipo
1843:                         loc_oBO.this_nTamanhoMinimo  = loc_nMin
1844:                         loc_oBO.this_nTamanhoMaximo  = loc_nMax
1845:                         loc_oBO.this_cBuffer         = loc_cBuf
1846: 
1847:                         IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
1848:                             THIS.AtualizarInstrucao("Digite a Senha")
1849:                         ENDIF
1850:                         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1851:                             THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
1852:                         ENDIF
1853:                         IF loc_nRet < 0
1854:                             THIS.ErroTef(loc_nRet)
1855:                             EXIT
1856:                         ENDIF
1857:                     ENDDO
1858: 
1859:                     IF !THIS.this_lAbandona
1860:                         *-- Envia numero de parcelas do Text1 (campo de parcelas)
1861:                         IF VARTYPE(THIS.txt_4c_Text1) = "O"
1862:                             loc_oBO.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + ;
1863:                                 REPLICATE(CHR(0), 1998)
1864:                         ELSE
1865:                             loc_oBO.this_cBuffer = "01" + REPLICATE(CHR(0), 1998)
1866:                         ENDIF
1867:                     ENDIF
1868:                 ENDIF
1869: 

*-- Linhas 1941 a 1984:
1941:                             EXIT
1942:                         ENDIF
1943: 
1944:                         *-- cmd=30 + optiongroup=2 (parcelado): inversao de risco ou EXIT
1945:                         IF loc_nCmd = 30 AND VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
1946:                            THIS.obj_4c_TipoVenda.Value = 2
1947:                             IF loc_nTipo = 510
1948:                                 IF loc_oBO.this_cGarantias = "S"
1949:                                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1950:                                 ELSE
1951:                                     loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
1952:                                 ENDIF
1953:                                 loc_nCont = 1000
1954:                                 LOOP
1955:                             ENDIF
1956:                             EXIT
1957:                         ENDIF
1958: 
1959:                         *-- cmd=30 + TipoCampo=506: envia data DDMMAAAA
1960:                         IF loc_nCmd = 30 AND loc_nTipo = 506
1961:                             IF VARTYPE(THIS.txt_4c_Datas) = "O"
1962:                                 loc_cDataFmt = DTOC(THIS.txt_4c_Datas.Value)
1963:                                 loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
1964:                                     ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
1965:                                     ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
1966:                                     REPLICATE(CHR(0), 1992)
1967:                             ELSE
1968:                                 loc_oBO.this_cBuffer = REPLICATE(CHR(0), 2000)
1969:                             ENDIF
1970:                             loc_nCont = 1000
1971:                             LOOP
1972:                         ENDIF
1973: 
1974:                         *-- cmd=30 + TipoCampo=505: envia parcelas
1975:                         IF loc_nCmd = 30 AND loc_nTipo = 505
1976:                             loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
1977:                                 REPLICATE(CHR(0), 1998)
1978:                             loc_nCont = 1000
1979:                             LOOP
1980:                         ENDIF
1981: 
1982:                         *-- cmd=20 + TipoCampo=507: primeira parcela a vista
1983:                         IF loc_nCmd = 20 AND loc_nTipo = 507
1984:                             IF MsgConfirma("Primeira Parcela A Vista")

*-- Linhas 2099 a 2142:
2099:     * Valida data e envia ao SiTef para transacao pre-datada
2100:     * Equivale a GetDatas.Valid do legado (183 linhas)
2101:     *==========================================================================
2102:     PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2103:         LOCAL loc_oBO, loc_dData, loc_oErro
2104:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
2105:         LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo
2106: 
2107:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2108:             RETURN
2109:         ENDIF
2110: 
2111:         IF LASTKEY() = 27
2112:             RETURN
2113:         ENDIF
2114: 
2115:         loc_oBO = THIS.this_oBusinessObject
2116: 
2117:         TRY
2118:             *-- Determina data (default: hoje + 30 dias se campo vazio)
2119:             loc_dData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
2120:             THIS.txt_4c_Datas.Value = loc_dData
2121:             THIS.txt_4c_Datas.Refresh()
2122: 
2123:             *-- Para parcelado (Value=2): data futura obrigatoria
2124:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
2125:                THIS.obj_4c_TipoVenda.Value = 2 AND ;
2126:                !EMPTY(THIS.txt_4c_Datas.Value) AND ;
2127:                loc_dData <= DATE()
2128:                 MsgErro("Data Inv" + CHR(225) + "lida", ;
2129:                     "Erro na Transa" + CHR(231) + CHR(227) + "o")
2130:             ELSE
2131:                 loc_oBO.this_dData = loc_dData
2132: 
2133:                 *-- Pre-loop: aguarda SiTef chegar ao cmd=30 (safety, normalmente ja esta la)
2134:                 loc_nCont = 0
2135:                 DO WHILE loc_oBO.this_nProximoComando <> 30
2136:                     loc_nCmd  = loc_oBO.this_nProximoComando
2137:                     loc_nTipo = loc_oBO.this_nTipoCampo
2138:                     loc_nMin  = loc_oBO.this_nTamanhoMinimo
2139:                     loc_nMax  = loc_oBO.this_nTamanhoMaximo
2140:                     loc_cBuf  = SPACE(2000)
2141: 
2142:                     loc_nRet = ContinuaFuncaoSiTefInterativo( ;

*-- Linhas 2394 a 2597:
2394:     ENDPROC
2395: 
2396:     *==========================================================================
2397:     * OgTipoVendaInteractiveChange - InteractiveChange do OptionGroup tipo de venda
2398:     * Habilita txt_4c_Datas e define data inicial conforme selecao
2399:     * Equivale a Optiongroup1.InteractiveChange do legado
2400:     *==========================================================================
2401:     PROCEDURE OgTipoVendaInteractiveChange()
2402:         LOCAL loc_oErro
2403:         TRY
2404:             IF VARTYPE(THIS.txt_4c_Datas) = "O"
2405:                 THIS.txt_4c_Datas.Enabled = .T.
2406:             ENDIF
2407:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
2408:                 IF THIS.obj_4c_TipoVenda.Value = 1
2409:                     IF VARTYPE(THIS.txt_4c_Datas) = "O"
2410:                         THIS.txt_4c_Datas.Value = DATE()
2411:                     ENDIF
2412:                 ELSE
2413:                     IF VARTYPE(THIS.txt_4c_Datas) = "O"
2414:                         THIS.txt_4c_Datas.Value = CTOD("")
2415:                     ENDIF
2416:                 ENDIF
2417:             ENDIF
2418:         CATCH TO loc_oErro
2419:             MsgErro(loc_oErro.Message, "Erro TEF TipoVenda InteractiveChange")
2420:         ENDTRY
2421:     ENDPROC
2422: 
2423:     *==========================================================================
2424:     * OgTipoVendaKeyPress - KeyPress do OptionGroup (avanca com ENTER)
2425:     * Equivale a Optiongroup1.KeyPress do legado
2426:     *==========================================================================
2427:     PROCEDURE OgTipoVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2428:         IF par_nKeyCode = 13
2429:             KEYBOARD "{TAB}"
2430:         ENDIF
2431:     ENDPROC
2432: 
2433:     *==========================================================================
2434:     * CmdCancelaClick - Click do botao CANCELA (cnt_4c_Saida.Buttons(1))
2435:     * Cancela transacao SiTef em andamento e fecha o form
2436:     * Equivale a SAIDA.CANCELA.Click do legado
2437:     *==========================================================================
2438:     PROCEDURE CmdCancelaClick()
2439:         LOCAL loc_oBO, loc_oErro
2440:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
2441:         loc_oBO = THIS.this_oBusinessObject
2442: 
2443:         TRY
2444:             loc_nCmd  = loc_oBO.this_nProximoComando
2445:             loc_nTipo = loc_oBO.this_nTipoCampo
2446:             loc_nMin  = loc_oBO.this_nTamanhoMinimo
2447:             loc_nMax  = loc_oBO.this_nTamanhoMaximo
2448:             loc_cBuf  = SPACE(2000)
2449: 
2450:             *-- Envia -1 para cancelar transacao em andamento
2451:             loc_nRet = ContinuaFuncaoSiTefInterativo( ;
2452:                 @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
2453:                 @loc_cBuf, LEN(loc_cBuf), -1)
2454: 
2455:             loc_oBO.this_nProximoComando = loc_nCmd
2456:             loc_oBO.this_cBuffer         = loc_cBuf
2457: 
2458:             loc_oBO.RetornoFalha( ;
2459:                 "Oper. Cancelada pelo Usu" + CHR(225) + "rio(1)", ;
2460:                 loc_oBO.this_nValPago)
2461: 
2462:         CATCH TO loc_oErro
2463:             MsgErro(loc_oErro.Message, "Erro ao cancelar TEF")
2464:         ENDTRY
2465: 
2466:         THIS.Release()
2467:     ENDPROC
2468: 
2469:     *==========================================================================
2470:     * ErroTef - Trata erro SiTef: delega ao BO e sinaliza abandono
2471:     * Equivale a PROCEDURE errotef do legado
2472:     * NAO chama Release() - chamador decide se fecha o form
2473:     *==========================================================================
2474:     PROCEDURE ErroTef(par_nRetorno)
2475:         LOCAL loc_oErro
2476:         TRY
2477:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2478:                 THIS.this_oBusinessObject.ErroTef(par_nRetorno)
2479:             ENDIF
2480:             THIS.this_lAbandona = .T.
2481:         CATCH TO loc_oErro
2482:             MsgErro(loc_oErro.Message, "Erro ErroTef")
2483:         ENDTRY
2484:     ENDPROC
2485: 
2486:     *==========================================================================
2487:     * BtnIncluirClick - Nao aplicavel a este form
2488:     * SIGPRDFT e um dialog modal de transacao TEF/SiTef (form OPERACIONAL plano).
2489:     * Nao possui estrutura CRUD (sem grid, sem Page1/Page2, sem registros).
2490:     * Toda interacao ocorre via protocolo SiTef (TxtDigitosGotFocus/KeyPress,
2491:     * TxtDatasGotFocus/KeyPress, CmdCancelaClick).
2492:     *==========================================================================
2493:     PROCEDURE BtnIncluirClick()
2494:         NODEFAULT
2495:     ENDPROC
2496: 
2497:     *==========================================================================
2498:     * BtnAlterarClick - Nao aplicavel a este form
2499:     * Ver BtnIncluirClick para explicacao.
2500:     *==========================================================================
2501:     PROCEDURE BtnAlterarClick()
2502:         NODEFAULT
2503:     ENDPROC
2504: 
2505:     *==========================================================================
2506:     * BtnVisualizarClick - Nao aplicavel a este form
2507:     * Ver BtnIncluirClick para explicacao.
2508:     *==========================================================================
2509:     PROCEDURE BtnVisualizarClick()
2510:         NODEFAULT
2511:     ENDPROC
2512: 
2513:     *==========================================================================
2514:     * BtnExcluirClick - Nao aplicavel a este form
2515:     * Ver BtnIncluirClick para explicacao.
2516:     *==========================================================================
2517:     PROCEDURE BtnExcluirClick()
2518:         NODEFAULT
2519:     ENDPROC
2520: 
2521:     *==========================================================================
2522:     * BtnBuscarClick - Nao aplicavel a este form
2523:     * Ver BtnIncluirClick para explicacao.
2524:     *==========================================================================
2525:     PROCEDURE BtnBuscarClick()
2526:         NODEFAULT
2527:     ENDPROC
2528: 
2529:     *==========================================================================
2530:     * BtnEncerrarClick - Cancela a transacao TEF e fecha o form
2531:     * Form TEF usa botao Cancelar (cnt_4c_Saida) como mecanismo de saida.
2532:     * BtnEncerrarClick delega ao mesmo comportamento de cancelamento.
2533:     *==========================================================================
2534:     PROCEDURE BtnEncerrarClick()
2535:         THIS.CmdCancelaClick()
2536:     ENDPROC
2537: 
2538:     *==========================================================================
2539:     * BtnSalvarClick - Nao aplicavel a este form
2540:     * Ver BtnIncluirClick para explicacao.
2541:     *==========================================================================
2542:     PROCEDURE BtnSalvarClick()
2543:         NODEFAULT
2544:     ENDPROC
2545: 
2546:     *==========================================================================
2547:     * BtnCancelarClick - Cancela a transacao TEF e fecha o form
2548:     * Equivalente a BtnEncerrarClick para compatibilidade com o pipeline.
2549:     *==========================================================================
2550:     PROCEDURE BtnCancelarClick()
2551:         THIS.CmdCancelaClick()
2552:     ENDPROC
2553: 
2554:     *==========================================================================
2555:     * FormParaBO - Nao aplicavel a este form
2556:     * Form TEF nao tem campos de cadastro para transferir ao BO.
2557:     * Os parametros da transacao sao passados via CREATEOBJECT (Init).
2558:     *==========================================================================
2559:     PROTECTED PROCEDURE FormParaBO()
2560:         RETURN
2561:     ENDPROC
2562: 
2563:     *==========================================================================
2564:     * BOParaForm - Nao aplicavel a este form
2565:     * Form TEF nao tem campos de cadastro para carregar do BO.
2566:     * O estado da transacao e gerenciado diretamente pelo protocolo SiTef.
2567:     *==========================================================================
2568:     PROTECTED PROCEDURE BOParaForm()
2569:         RETURN
2570:     ENDPROC
2571: 
2572:     *==========================================================================
2573:     * HabilitarCampos - Nao aplicavel a este form
2574:     * Habilitacao dos campos e controlada pelo protocolo SiTef (GotFocus/Valid).
2575:     *==========================================================================
2576:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2577:         RETURN
2578:     ENDPROC
2579: 
2580:     *==========================================================================
2581:     * CarregarLista - Nao aplicavel a este form
2582:     * Form TEF nao tem grid de lista de registros.
2583:     * Retorna .T. para compatibilidade com FormBase.
2584:     *==========================================================================
2585:     PROTECTED FUNCTION CarregarLista() AS Boolean
2586:         RETURN .T.
2587:     ENDFUNC
2588: 
2589:     *==========================================================================
2590:     * AjustarBotoesPorModo - Nao aplicavel a este form
2591:     * Form TEF nao tem botoes CRUD que precisam ser ajustados por modo.
2592:     *==========================================================================
2593:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2594:         RETURN
2595:     ENDPROC
2596: 
2597: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* sigprdftBO.prg - Business Object para TEF SiTef Cartao de Debito
* Herda de BusinessBase
* Formulario original: SIGPRDFT.SCX
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada (recebidos do chamador)
    this_cEndSiTef       = ""   && Endereco do servidor SiTef
    this_nValPago        = 0    && Valor a pagar
    this_cCupom          = ""   && Numero do cupom
    this_cCaixa          = ""   && Identificador do caixa
    this_cDebCred        = ""   && Debito/Credito/Pre-datado (D/C/P)
    this_cTipPagto       = ""   && Tipo de pagamento
    this_nNumParcs       = 0    && Numero de parcelas
    this_nIdent          = 0    && Identificador da transacao (ltIdent)
    this_cOpers          = ""   && Codigo da operacao/forma de pagamento (FPags)

    *-- Estado da transacao SiTef (variaveis PUBLIC no legado)
    this_cIdTerminal     = ""   && ID do terminal SiTef (lsIdTerminal)
    this_lDCD            = .F.  && Flag data credito/debito (DCD)
    this_dData           = {}   && Data da transacao (ldData)
    this_nProximoComando = 0    && Proximo comando SiTef (ProximoComando)
    this_nTipoCampo      = 0    && Tipo de campo SiTef (TipoCampo)
    this_nTamanhoMinimo  = 0    && Tamanho minimo do campo (TamanhoMinimo)
    this_nTamanhoMaximo  = 0    && Tamanho maximo do campo (TamanhoMaximo)
    this_cBuffer         = ""   && Buffer de comunicacao SiTef 2000 chars (Buffer)
    this_nContinua       = 0    && Flag/resultado de continuacao (lnContinua)
    this_nCiclos         = 0    && Contador de ciclos (lnCiclos)
    this_cParcs          = ""   && Parcelas formatadas "@L 99" (lnParcs string)

    *-- Resultados da transacao
    this_cBandeira       = ""   && Bandeira do cartao - codigo (pcBandeira)
    this_cCartao         = ""   && 5 primeiros digitos do cartao (lsCartao)
    this_cSaque          = ""   && Valor do saque formato "0,00" (lcSaque)
    this_cTipTran        = ""   && Tipo de transacao retornado pelo SiTef (lsTipTran)
    this_cDataHora       = ""   && Data e hora da transacao (lsDataHora)
    this_cNsu            = ""   && NSU da transacao (lsNsu)
    this_cAutoriza       = ""   && Codigo de autorizacao (lsAutoriza)
    this_cFinaliza       = ""   && Buffer de finalizacao (lsFinaliza)
    this_cMensagem       = ""   && Mensagem da transacao (lsMensagem)
    this_cMRet           = ""   && Mensagem de retorno adicional (lsMRet)

    *-- Estado do formulario (propriedades customizadas do form legado)
    this_lTvenda         = .T.  && Habilita selecao de tipo de venda (pctvenda)
    this_lKeyEsc         = .T.  && Habilita tecla ESC (pckeyesc)
    this_lAbandona       = .F.  && Flag de abandono da operacao (abandona)

    *-- Dados do registro SigOpFp (forma de pagamento)
    this_cFPags          = ""   && Codigo da forma de pagamento (FPags)
    this_cTcdc           = ""   && Tipo CDC - controla fluxo parcelado (Tcdc)
    this_cGarantias      = ""   && Habilita inversao de risco (Garantias S/N)
    this_cLSaque         = ""   && Permite operacao de saque (lSaque S/N)
    this_cLCartao        = ""   && Cartao numerico (lCartao S/N)
    this_nDias           = 0    && Dias para pre-datado (Dias)
    this_nMesFec         = 0    && Mes de fechamento CDC (MesFec)

    *-- Dados da empresa SigCdEmp
    this_nEmps           = 0    && Numero da empresa para compor terminal (nEmps)
    this_cEmpresa        = ""   && Codigo da empresa (cEmps)

    *-- Dados do caixa SigFiMpF
    this_nCncaixas       = 0    && Numero do caixa para compor ID terminal (Cncaixas)

    *==========================================================================
    * Init - Inicializa o BO de integracao SiTef
    *==========================================================================
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades de SigOpFp do cursor informado
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cFPags     = TratarNulo(FPags,      "C")
                THIS.this_cTcdc      = TratarNulo(Tcdc,       "C")
                THIS.this_cGarantias = TratarNulo(Garantias,  "C")
                THIS.this_cLSaque    = TratarNulo(lSaque,     "C")
                THIS.this_cLCartao   = TratarNulo(lCartao,    "C")
                THIS.this_nDias      = TratarNulo(Dias,       "N")
                THIS.this_nMesFec    = TratarNulo(MesFec,     "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfig - SQLEXEC para carregar SigOpFp e SigCdEmp
    *==========================================================================
    PROCEDURE CarregarConfig(par_cOpers)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            *-- Forma de pagamento
            loc_cSQL = "SELECT FPags, Tcdc, Garantias, lSaque, lCartao, Dias, MesFec " + ;
                       "FROM SigOpFp WHERE FPags = " + EscaparSQL(ALLTRIM(par_cOpers))
            IF USED("cursor_4c_SigOpFp")
                TABLEREVERT(.T., "cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpFp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigOpFp")
                THIS.CarregarDoCursor("cursor_4c_SigOpFp")
            ENDIF

            *-- Empresa
            loc_cSQL = "SELECT cEmps, nEmps FROM SigCdEmp " + ;
                       "WHERE cEmps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                TABLEREVERT(.T., "cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdEmp")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                THIS.this_nEmps    = TratarNulo(nEmps, "N")
                THIS.this_cEmpresa = TratarNulo(cEmps, "C")
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(227) + "o SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCaixa - SQLEXEC para carregar numero do caixa (SigFiMpF)
    *==========================================================================
    PROCEDURE CarregarCaixa(par_cCaixa)
        LOCAL loc_lSucesso, loc_cSQL, loc_nRet
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Cncaixas FROM SigFiMpF"
            IF USED("cursor_4c_SigFiMpF")
                TABLEREVERT(.T., "cursor_4c_SigFiMpF")
                USE IN cursor_4c_SigFiMpF
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigFiMpF")
            IF loc_nRet > 0 AND !EOF("cursor_4c_SigFiMpF")
                SELECT cursor_4c_SigFiMpF
                THIS.this_nCncaixas = TratarNulo(Cncaixas, "N")
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar dados do caixa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarRetorno - Monta cursor crSiTef e escreve arquivos de retorno de sucesso
    * Equivale ao PROCEDURE montaretorno do legado
    *==========================================================================
    PROCEDURE MontarRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartaoBandeira, ;
                             par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
        LOCAL loc_lSucesso, loc_cValPago, loc_cBandIdx, loc_nPos, loc_nLinha, loc_cCupom
        LOCAL ARRAY loc_aCartao[11]
        loc_lSucesso = .F.
        TRY
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            loc_aCartao[1]  = "Outro, nao definido"
            loc_aCartao[2]  = "Visa"
            loc_aCartao[3]  = "Mastercard"
            loc_aCartao[4]  = "Diners"
            loc_aCartao[5]  = "American Express"
            loc_aCartao[6]  = "Sollo"
            loc_aCartao[7]  = "Sidecard (Redecard)"
            loc_aCartao[8]  = "Private Label (Redecard)"
            loc_aCartao[9]  = "Redeshop"
            loc_aCartao[10] = ""
            loc_aCartao[11] = "Fininvest"

            IF VAL(THIS.this_cBandeira) > 10 .OR. VAL(THIS.this_cBandeira) < 0
                loc_cBandIdx = "0"
            ELSE
                loc_cBandIdx = THIS.this_cBandeira
            ENDIF

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = " + loc_aCartao[VAL(loc_cBandIdx) + 1])
            INSERT INTO crSiTef (Tef) VALUES ("011-000 = " + par_cTipTran)
            INSERT INTO crSiTef (Tef) VALUES ("012-000 = " + par_cNsu)
            INSERT INTO crSiTef (Tef) VALUES ("013-000 = " + par_cAutoriza)
            INSERT INTO crSiTef (Tef) VALUES ("015-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("018-000 = " + ;
                ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")))
            INSERT INTO crSiTef (Tef) VALUES ("017-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("019-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("020-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("021-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("022-000 = " + ;
                SUBSTR(par_cDataHora, 7, 2) + ;
                SUBSTR(par_cDataHora, 5, 2) + ;
                SUBSTR(par_cDataHora, 1, 4))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + SUBSTR(par_cDataHora, 9, 6))
            INSERT INTO crSiTef (Tef) VALUES ("023-000 = " + par_cFinaliza)
            INSERT INTO crSiTef (Tef) VALUES ("027-000 = " + SUBSTR(par_cDataHora, 9, 6))

            loc_cCupom = par_cCupom
            loc_nPos   = 1
            loc_nLinha = 1
            DO WHILE loc_nPos <> 0
                loc_nPos = AT(CHR(10), loc_cCupom)
                INSERT INTO crSiTef (Tef) VALUES ("029-" + TRANSFORM(loc_nLinha, "@L 999") + ;
                    " = " + IIF(loc_nPos <> 0, SUBSTR(loc_cCupom, 1, loc_nPos - 1), loc_cCupom))
                loc_cCupom = SUBSTR(loc_cCupom, loc_nPos + 1)
                loc_nLinha = loc_nLinha + 1
            ENDDO
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = " + ALLTRIM(STR(loc_nLinha - 2)))
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + par_cMenRet)
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RetornoFalha - Monta cursor crSiTef e escreve arquivos de retorno de falha
    * Equivale ao PROCEDURE retornofalha do legado
    *==========================================================================
    PROCEDURE RetornoFalha(par_cMensagem, par_nValPago)
        LOCAL loc_lSucesso, loc_cValPago, loc_cMensagem
        loc_lSucesso = .F.
        TRY
            loc_cMensagem = IIF(EMPTY(par_cMensagem), ;
                "Opera" + CHR(231) + CHR(227) + "o Cancelada Pelo Usuario", par_cMensagem)
            loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")

            IF USED("crSiTef")
                USE IN crSiTef
            ENDIF
            CREATE CURSOR crSiTef (tef C(100))

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
            INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
            INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
            INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
            INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
            INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + ;
                IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
            INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            SELECT crSiTef
            SET SAFETY OFF
            COPY TO C:\client\Resp\IntPos.001 SDF
            ZAP

            INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
            INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(THIS.this_nIdent, 10))
            INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")

            COPY TO C:\client\Resp\IntPos.STS SDF
            SET SAFETY ON

            USE IN crSiTef

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            SET SAFETY ON
            MsgErro(loc_oErro.Message, "Erro ao montar retorno de falha SiTef")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ErroTef - Trata codigos de erro retornados pelo SiTef (-1 a -5)
    * Equivale ao PROCEDURE errotef do legado
    *==========================================================================
    PROCEDURE ErroTef(par_nRetorno)
        LOCAL loc_oErro
        TRY
            IF VARTYPE(par_nRetorno) = "N" AND ;
               (par_nRetorno > -1 OR par_nRetorno < -5)
                THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
            ELSE
                DO CASE
                    CASE par_nRetorno = -1
                        THIS.RetornoFalha("Modulo Nao Iniciado", 0)
                    CASE par_nRetorno = -2
                        THIS.RetornoFalha("Operacao Cancelada pelo Usuario", 0)
                    CASE par_nRetorno = -3
                        THIS.RetornoFalha("Fornecida uma Modalidade Invalida", 0)
                    CASE par_nRetorno = -4
                        THIS.RetornoFalha("Falta Memoria para Rodar a Funcao", 0)
                    CASE par_nRetorno = -5
                        THIS.RetornoFalha("Sem Comunicacao com o SiTef", 0)
                ENDCASE
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao tratar erro SiTef")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ObterResultadoFinal - Retorna string de resultado da transacao
    * Equivale ao PROCEDURE Unload do legado
    * Formato: "lcSaque/lnParcs/DTOC(ldData)+pcBandeira+lsCartao"
    *==========================================================================
    FUNCTION ObterResultadoFinal()
        LOCAL loc_cBandeira, loc_cCartao, loc_cResultado
        loc_cResultado = ""
        TRY
            loc_cBandeira = IIF(VARTYPE(THIS.this_cBandeira) <> "C" .OR. EMPTY(THIS.this_cBandeira), ;
                "00000", THIS.this_cBandeira)
            loc_cCartao   = IIF(VARTYPE(THIS.this_cCartao) <> "C" .OR. EMPTY(THIS.this_cCartao), ;
                "00000", THIS.this_cCartao)
            loc_cResultado = THIS.this_cSaque + "/" + ;
                             ALLTRIM(TRANSFORM(THIS.this_nNumParcs, "@L 99")) + "/" + ;
                             DTOC(THIS.this_dData) + ;
                             loc_cBandeira + ;
                             loc_cCartao
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao obter resultado final SiTef")
            loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
        ENDTRY
        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * Inserir - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * Atualizar - Nao aplicavel para form TEF (sem tabela SQL Server)
    *==========================================================================
    FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave da forma de pagamento
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cFPags
    ENDFUNC

ENDDEFINE

