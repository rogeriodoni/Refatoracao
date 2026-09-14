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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2595 linhas total):

*-- Linhas 9 a 272:
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
215:             THIS.ConfigurarSaida()
216:             THIS.ConfigurarShape()
217:             THIS.ConfigurarContainer1()
218:             THIS.ConfigurarCamposEntrada()
219:             THIS.ConfigurarOptionGroup()
220:             THIS.VincularEventos()
221:         CATCH TO loc_oErro
222:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
223:                 "Erro ConfigurarLayout")
224:         ENDTRY
225:     ENDPROC
226: 
227:     *==========================================================================
228:     * ConfigurarCabecalho - Container sombra/titulo cinza no topo
229:     * Equivale ao cntSombra do legado (Top=0, Width=800, Height=80)
230:     * No novo sistema: Width = THIS.Width (500px)
231:     *==========================================================================
232:     PROTECTED PROCEDURE ConfigurarCabecalho()
233:         LOCAL loc_oCnt
234: 
235:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
236:         loc_oCnt = THIS.cnt_4c_Cabecalho
237: 
238:         WITH loc_oCnt
239:             .Top         = 0
240:             .Left        = 0
241:             .Width       = THIS.Width
242:             .Height      = 80
243:             .BorderWidth = 0
244:             .BackColor   = RGB(100,100,100)
245: 
246:             .AddObject("lbl_4c_Sombra", "Label")
247:             WITH .lbl_4c_Sombra
248:                 .AutoSize      = .F.
249:                 .FontBold      = .T.
250:                 .FontName      = "Tahoma"
251:                 .FontSize      = 18
252:                 .FontUnderline = .F.
253:                 .WordWrap      = .T.
254:                 .Alignment     = 0
255:                 .BackStyle     = 0
256:                 .Caption       = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
257:                 .Height        = 40
258:                 .Left          = 10
259:                 .Top           = 18
260:                 .Width         = THIS.Width
261:                 .ForeColor     = RGB(0,0,0)
262:             ENDWITH
263: 
264:             .AddObject("lbl_4c_Titulo", "Label")
265:             WITH .lbl_4c_Titulo
266:                 .AutoSize   = .F.
267:                 .FontBold   = .T.
268:                 .FontName   = "Tahoma"
269:                 .FontSize   = 18
270:                 .WordWrap   = .T.
271:                 .Alignment  = 0
272:                 .BackStyle  = 0

*-- Linhas 285 a 428:
285:     * Equivale ao SAIDA commandgroup do legado
286:     * Top=-2 (sobrepoe o cabecalho), Left=420 (borda direita do form 500px)
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarSaida()
289:         LOCAL loc_oCg
290: 
291:         THIS.AddObject("cnt_4c_Saida", "CommandGroup")
292:         loc_oCg = THIS.cnt_4c_Saida
293: 
294:         WITH loc_oCg
295:             .ButtonCount = 1
296:             .BackStyle   = 0
297:             .BorderStyle = 0
298:             .Value       = 0
299:             .Height      = 85
300:             .Left        = 420
301:             .Top         = -2
302:             .Width       = 85
303:             .TabIndex    = 8
304:             .BackColor   = RGB(255,255,255)
305:             .Themes      = .F.
306: 
307:             WITH .Buttons(1)
308:                 .Top                = 5
309:                 .Left               = 5
310:                 .Height             = 75
311:                 .Width              = 75
312:                 .FontBold           = .T.
313:                 .FontItalic         = .T.
314:                 .FontName           = "Comic Sans MS"
315:                 .FontSize           = 8
316:                 .Picture            = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
317:                 .DisabledPicture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
318:                 .Caption            = "Cancelar"
319:                 .Cancel             = .F.
320:                 .ForeColor          = RGB(90,90,90)
321:                 .BackColor          = RGB(255,255,255)
322:                 .Themes             = .F.
323:                 .SpecialEffect      = 0
324:                 .PicturePosition    = 13
325:                 .MousePointer       = 15
326:                 .WordWrap           = .T.
327:                 .AutoSize           = .F.
328:             ENDWITH
329:         ENDWITH
330:     ENDPROC
331: 
332:     *==========================================================================
333:     * ConfigurarShape - Shape decorativo ao redor dos campos de entrada
334:     * Equivale ao Shape2 do legado (Top=93, Left=17, Height=202, Width=466)
335:     *==========================================================================
336:     PROTECTED PROCEDURE ConfigurarShape()
337:         THIS.AddObject("shp_4c_Shape2", "Shape")
338: 
339:         WITH THIS.shp_4c_Shape2
340:             .Top           = 93
341:             .Left          = 17
342:             .Height        = 202
343:             .Width         = 466
344:             .SpecialEffect = 0
345:         ENDWITH
346:     ENDPROC
347: 
348:     *==========================================================================
349:     * ConfigurarContainer1 - Container de instrucao ao usuario
350:     * Equivale ao Container1 do legado (Top=298, Left=54, Width=392, Height=58)
351:     * Exibe mensagem como "Insira ou Passe o Cartao", "Digite a Senha", etc.
352:     *==========================================================================
353:     PROTECTED PROCEDURE ConfigurarContainer1()
354:         LOCAL loc_oCnt
355: 
356:         THIS.AddObject("cnt_4c_Instrucao", "Container")
357:         loc_oCnt = THIS.cnt_4c_Instrucao
358: 
359:         WITH loc_oCnt
360:             .Top           = 298
361:             .Left          = 54
362:             .Width         = 392
363:             .Height        = 58
364:             .SpecialEffect = 0
365: 
366:             .AddObject("lbl_4c_Instrucao", "Label")
367:             WITH .lbl_4c_Instrucao
368:                 .AutoSize   = .F.
369:                 .FontBold   = .T.
370:                 .FontName   = "Tahoma"
371:                 .FontSize   = 18
372:                 .Alignment  = 2
373:                 .Caption    = "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"
374:                 .Height     = 29
375:                 .Left       = 18
376:                 .Top        = 14
377:                 .Width      = 349
378:                 .ForeColor  = RGB(90,90,90)
379:                 .BackStyle  = 0
380:             ENDWITH
381:         ENDWITH
382:     ENDPROC
383: 
384:     *==========================================================================
385:     * AjustarComportamento - Ajusta estado inicial apos carregar config do banco
386:     * Inicializa flags que controlam habilitacao de campos e cancelamento ESC
387:     *==========================================================================
388:     PROTECTED PROCEDURE AjustarComportamento()
389:         LOCAL loc_oBO, loc_oErro
390:         loc_oBO = THIS.this_oBusinessObject
391: 
392:         TRY
393:             THIS.this_lKeyEsc    = .T.
394:             THIS.this_lAbandona  = .F.
395:             THIS.this_lTipoVenda = .F.
396: 
397:             *-- Valor formatado no campo de exibicao (readonly)
398:             IF VARTYPE(THIS.txt_4c_Valor) = "O"
399:                 THIS.txt_4c_Valor.Value = STRTRAN( ;
400:                     ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")
401:             ENDIF
402: 
403:             *-- Data inicial para parcelado/pre-datado
404:             IF VARTYPE(THIS.txt_4c_Datas) = "O"
405:                 THIS.txt_4c_Datas.Value = DATE()
406:             ENDIF
407: 
408:             *-- Numero de parcelas
409:             IF VARTYPE(THIS.txt_4c_Text1) = "O"
410:                 THIS.txt_4c_Text1.Value = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")
411:             ENDIF
412: 
413:             *-- Se cartao fisico disponivel: habilita campo numero do cartao
414:             IF loc_oBO.this_cLCartao = "S"
415:                 IF VARTYPE(THIS.txt_4c_Cartao) = "O"
416:                     THIS.txt_4c_Cartao.Enabled = .T.
417:                 ENDIF
418:                 IF VARTYPE(THIS.lbl_4c_Label2) = "O"
419:                     THIS.lbl_4c_Label2.Caption = "Validade Cart" + CHR(227) + "o :"
420:                 ENDIF
421:             ENDIF
422: 
423:             *-- Instrucao inicial conforme tipo de entrada do cartao
424:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O"
425:                 IF VARTYPE(THIS.txt_4c_Datas) = "O" AND !THIS.txt_4c_Datas.Enabled
426:                     IF loc_oBO.this_cLCartao = "N"
427:                         THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = ;
428:                             "Insira ou Passe" + CHR(13) + "o Cart" + CHR(227) + "o"

*-- Linhas 436 a 627:
436:                 ENDIF
437:             ENDIF
438: 
439:             *-- OptionGroup de tipo de venda: desabilitado ate completar handshake SiTef
440:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
441:                 THIS.obj_4c_TipoVenda.Enabled = .F.
442:             ENDIF
443: 
444:             *-- BackColor do campo de digitos: cinza (aguardando GetFocus)
445:             IF VARTYPE(THIS.txt_4c_Digitos) = "O"
446:                 THIS.txt_4c_Digitos.BackColor = 12632256
447:             ENDIF
448: 
449:         CATCH TO loc_oErro
450:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
451:                 "Erro AjustarComportamento")
452:         ENDTRY
453:     ENDPROC
454: 
455:     *==========================================================================
456:     * TornarControlesVisiveis - Torna todos os controles visiveis apos AddObject
457:     * AddObject cria controles com Visible=.F. por default
458:     *==========================================================================
459:     PROCEDURE TornarControlesVisiveis()
460:         LOCAL loc_nI, loc_oCtrl
461: 
462:         FOR loc_nI = 1 TO THIS.ControlCount
463:             loc_oCtrl = THIS.Controls(loc_nI)
464:             IF VARTYPE(loc_oCtrl) = "O"
465:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
466:                     loc_oCtrl.Visible = .T.
467:                 ENDIF
468:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
469:                    loc_oCtrl.ControlCount > 0
470:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
471:                 ENDIF
472:             ENDIF
473:         ENDFOR
474:     ENDPROC
475: 
476:     *==========================================================================
477:     * TornarFilhosVisiveis - Recursao para sub-controles
478:     *==========================================================================
479:     PROTECTED PROCEDURE TornarFilhosVisiveis(par_oContainer)
480:         LOCAL loc_nI, loc_oCtrl
481: 
482:         FOR loc_nI = 1 TO par_oContainer.ControlCount
483:             loc_oCtrl = par_oContainer.Controls(loc_nI)
484:             IF VARTYPE(loc_oCtrl) = "O"
485:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
486:                     loc_oCtrl.Visible = .T.
487:                 ENDIF
488:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
489:                    loc_oCtrl.ControlCount > 0
490:                     THIS.TornarFilhosVisiveis(loc_oCtrl)
491:                 ENDIF
492:             ENDIF
493:         ENDFOR
494:     ENDPROC
495: 
496:     *==========================================================================
497:     * KeyPress - Intercepta ESC para cancelar a transacao
498:     * Equivale ao PROCEDURE KeyPress do legado (KeyPreview=.T. na classe)
499:     *==========================================================================
500:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
501: 
502:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
503:             NODEFAULT
504:             IF VARTYPE(THIS.cnt_4c_Saida) = "O"
505:                 THIS.cnt_4c_Saida.Buttons(1).Click()
506:             ENDIF
507:         ENDIF
508:     ENDPROC
509: 
510:     *==========================================================================
511:     * ObterResultado - Retorna resultado da transacao para o chamador
512:     * Formato: "cSaque/nParcs/dData+cBandeira+cCartao"
513:     *==========================================================================
514:     FUNCTION ObterResultado() AS String
515:         LOCAL loc_cResultado
516: 
517:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
518:             loc_cResultado = THIS.this_oBusinessObject.ObterResultadoFinal()
519:         ELSE
520:             loc_cResultado = "0,00/00/" + DTOC(DATE()) + "00000" + "00000"
521:         ENDIF
522: 
523:         RETURN loc_cResultado
524:     ENDFUNC
525: 
526:     *==========================================================================
527:     * Unload - Retorna resultado ao fechar o form
528:     * Equivale ao PROCEDURE Unload do legado que faz RETURN(lcSaque+...)
529:     *==========================================================================
530:     PROCEDURE Unload()
531:         RETURN THIS.ObterResultado()
532:     ENDPROC
533: 
534:     *==========================================================================
535:     * Destroy - Limpeza ao destruir o formulario
536:     * Equivale ao PROCEDURE Release do legado
537:     *==========================================================================
538:     PROCEDURE Destroy()
539:         LOCAL loc_oErro
540: 
541:         TRY
542:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
543:                 THIS.this_oBusinessObject = .NULL.
544:             ENDIF
545:         CATCH TO loc_oErro
546:             MsgErro(loc_oErro.Message, "Erro Destroy TEF")
547:         ENDTRY
548: 
549:         DODEFAULT()
550:     ENDPROC
551: 
552:     *==========================================================================
553:     * AlternarPagina - Nao aplicavel para form plano TEF (sem PageFrame)
554:     * Metodo requerido pelo pipeline de migracao multi-fase
555:     *==========================================================================
556:     PROCEDURE AlternarPagina(par_nPagina)
557:         *-- Form TEF e plano (sem Pages) - nao ha paginas para alternar
558:         RETURN
559:     ENDPROC
560: 
561:     *==========================================================================
562:     * ConfigurarPaginaLista - Nao aplicavel: form plano OPERACIONAL sem lista/grid
563:     * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 4)
564:     * O layout deste dialog TEF/SiTef eh construido em ConfigurarLayout() e nao
565:     * possui Page1/Grid CRUD (form flat 500x370 com campos de pagamento)
566:     *==========================================================================
567:     PROTECTED PROCEDURE ConfigurarPaginaLista()
568:         *-- No-op: form TEF nao tem lista de registros (dialog modal de transacao)
569:         RETURN
570:     ENDPROC
571: 
572:     *==========================================================================
573:     * ConfigurarPaginaDados - Nao aplicavel: form plano OPERACIONAL sem Page2
574:     * Para forms OPERACIONAIS com layout flat (dialog TEF/SiTef), todos os campos
575:     * sao inicializados em ConfigurarCamposEntrada() e ConfigurarOptionGroup().
576:     * Metodo declarado apenas para atender o pipeline de migracao multi-fase (Fase 5)
577:     *==========================================================================
578:     PROTECTED PROCEDURE ConfigurarPaginaDados()
579:         *-- No-op: form TEF nao tem Page2 (Dados) - dialog flat 500x370
580:         RETURN
581:     ENDPROC
582: 
583:     *==========================================================================
584:     * ConfigurarCamposEntrada - Campos de entrada de dados do cartao e pagamento
585:     * Equivale a GetValor, GetCartao, GetDigitos, Text1, GetDatas + Labels legado
586:     *==========================================================================
587:     PROTECTED PROCEDURE ConfigurarCamposEntrada()
588:         LOCAL loc_oErro
589:         TRY
590:             *-- Label5: VALOR : (SCX original: AutoSize=.T., FontBold=.T.)
591:             THIS.AddObject("lbl_4c_Label5", "Label")
592:             WITH THIS.lbl_4c_Label5
593:                 .AutoSize  = .T.
594:                 .FontBold  = .T.
595:                 .Caption   = "VALOR :"
596:                 .Top       = 102
597:                 .Left      = 175
598:                 .Width     = 45
599:                 .Height    = 15
600:                 .FontName  = "Tahoma"
601:                 .FontSize  = 8
602:                 .ForeColor = RGB(90,90,90)
603:                 .BackStyle = 0
604:             ENDWITH
605: 
606:             *-- GetValor -> txt_4c_Valor: exibe valor formatado
607:             *-- SCX original: Enabled=.F. (nao ReadOnly), FontBold=.T., Alignment=3, InputMask, Value=0
608:             THIS.AddObject("txt_4c_Valor", "TextBox")
609:             WITH THIS.txt_4c_Valor
610:                 .Top       = 99
611:                 .Left      = 222
612:                 .Width     = 100
613:                 .Height    = 23
614:                 .FontBold  = .T.
615:                 .FontName  = "Tahoma"
616:                 .FontSize  = 8
617:                 .Alignment = 3
618:                 .Enabled   = .F.
619:                 .InputMask = "99,999,999.99"
620:                 .ForeColor = RGB(0,0,0)
621:                 .TabIndex  = 1
622:                 .Value     = 0
623:             ENDWITH
624: 
625:             *-- Label8: NUMERO CARTAO : (SCX original: AutoSize=.T., FontBold=.T., sem acento)
626:             THIS.AddObject("lbl_4c_Label8", "Label")
627:             WITH THIS.lbl_4c_Label8

*-- Linhas 774 a 906:
774:     ENDPROC
775: 
776:     *==========================================================================
777:     * ConfigurarOptionGroup - OptionGroup tipo de venda (A Vista / Parcelado)
778:     * Equivale ao Optiongroup1 legado (Top=200, Left=222, W=161, H=26)
779:     *==========================================================================
780:     PROTECTED PROCEDURE ConfigurarOptionGroup()
781:         LOCAL loc_oErro
782:         TRY
783:             THIS.AddObject("obj_4c_TipoVenda", "OptionGroup")
784: 
785:             WITH THIS.obj_4c_TipoVenda
786:                 .Top         = 200
787:                 .Left        = 222
788:                 .Width       = 161
789:                 .Height      = 26
790:                 .ButtonCount = 2
791:                 .Value       = 1
792:                 .BackStyle   = 0
793:                 .BorderStyle = 0
794:                 .TabIndex    = 6
795: 
796:                 WITH .Buttons(1)
797:                     .Caption   = CHR(192) + " Vista"
798:                     .Top       = 2
799:                     .Left      = 0
800:                     .Width     = 70
801:                     .Height    = 20
802:                     .BackStyle = 0
803:                     .ForeColor = RGB(90,90,90)
804:                 ENDWITH
805: 
806:                 WITH .Buttons(2)
807:                     .Caption   = "Parcelado"
808:                     .Top       = 2
809:                     .Left      = 75
810:                     .Width     = 80
811:                     .Height    = 20
812:                     .FontName  = "Tahoma"
813:                     .FontSize  = 8
814:                     .BackStyle = 0
815:                     .ForeColor = RGB(90,90,90)
816:                 ENDWITH
817:             ENDWITH
818: 
819:         CATCH TO loc_oErro
820:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
821:                 "Erro ConfigurarOptionGroup")
822:         ENDTRY
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * VincularEventos - BINDEVENT todos os handlers de eventos dos controles
827:     *==========================================================================
828:     PROTECTED PROCEDURE VincularEventos()
829:         LOCAL loc_oErro
830:         TRY
831:             BINDEVENT(THIS.txt_4c_Digitos, "GotFocus",         THIS, "TxtDigitosGotFocus")
832:             BINDEVENT(THIS.txt_4c_Digitos, "KeyPress",         THIS, "TxtDigitosKeyPress")
833:             BINDEVENT(THIS.txt_4c_Text1,   "GotFocus",         THIS, "TxtText1GotFocus")
834:             BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",        THIS, "TxtText1LostFocus")
835:             BINDEVENT(THIS.txt_4c_Text1,   "KeyPress",         THIS, "TxtText1KeyPress")
836:             BINDEVENT(THIS.txt_4c_Datas,   "GotFocus",         THIS, "TxtDatasGotFocus")
837:             BINDEVENT(THIS.txt_4c_Datas,   "KeyPress",         THIS, "TxtDatasKeyPress")
838:             BINDEVENT(THIS.obj_4c_TipoVenda, "InteractiveChange", THIS, "OgTipoVendaInteractiveChange")
839:             BINDEVENT(THIS.obj_4c_TipoVenda, "KeyPress",          THIS, "OgTipoVendaKeyPress")
840:             BINDEVENT(THIS.cnt_4c_Saida.Buttons(1), "Click",  THIS, "CmdCancelaClick")
841:         CATCH TO loc_oErro
842:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
843:                 "Erro VincularEventos")
844:         ENDTRY
845:     ENDPROC
846: 
847:     *==========================================================================
848:     * AtualizarInstrucao - Atualiza label de instrucao ao usuario
849:     * Equivale a ThisForm.Container1.Label1.Caption = ... no legado
850:     *==========================================================================
851:     PROCEDURE AtualizarInstrucao(par_cTexto)
852:         LOCAL loc_oErro
853:         TRY
854:             IF VARTYPE(THIS.cnt_4c_Instrucao) = "O" AND ;
855:                VARTYPE(THIS.cnt_4c_Instrucao.lbl_4c_Instrucao) = "O"
856:                 THIS.cnt_4c_Instrucao.lbl_4c_Instrucao.Caption = par_cTexto
857:             ENDIF
858:         CATCH TO loc_oErro
859:             MsgErro(loc_oErro.Message, "Erro AtualizarInstrucao")
860:         ENDTRY
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * CancelarTransacao - Grava retorno de falha e fecha o form
865:     *==========================================================================
866:     PROCEDURE CancelarTransacao(par_cMensagem)
867:         LOCAL loc_cMsg
868:         loc_cMsg = IIF(EMPTY(par_cMensagem), ;
869:             "Opera" + CHR(231) + CHR(227) + "o Cancelada pelo Usu" + CHR(225) + "rio", ;
870:             par_cMensagem)
871:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
872:             THIS.this_oBusinessObject.RetornoFalha(loc_cMsg, ;
873:                 THIS.this_oBusinessObject.this_nValPago)
874:         ENDIF
875:         THIS.Release()
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * ExecutarLoopSiTef - Loop principal de interacao com ContinuaFuncaoSiTefInterativo
880:     * Roda ate cmd=22 (aguarda entrada usuario) ou cmd=30 (fim transacao)
881:     * par_nContinua: 1000=novo/dado enviado, 0=ack mensagem, -1=cancelar
882:     * Retorna .T. se parou em cmd=22 (esperando entrada), .F. se cmd=30 ou erro
883:     *==========================================================================
884:     FUNCTION ExecutarLoopSiTef(par_nContinua AS Integer) AS Boolean
885:         LOCAL loc_oBO, loc_lParouEmEntrada, loc_oErro
886:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
887:         LOCAL loc_nCont, loc_lFimLoop
888:         loc_lParouEmEntrada = .F.
889:         loc_lFimLoop = .F.
890:         loc_nCont = par_nContinua
891:         loc_oBO = THIS.this_oBusinessObject
892: 
893:         TRY
894:             DO WHILE !loc_lFimLoop
895:                 loc_nCmd  = loc_oBO.this_nProximoComando
896:                 loc_nTipo = loc_oBO.this_nTipoCampo
897:                 loc_nMin  = loc_oBO.this_nTamanhoMinimo
898:                 loc_nMax  = loc_oBO.this_nTamanhoMaximo
899:                 loc_cBuf  = SPACE(2000)
900: 
901:                 loc_nRet = ContinuaFuncaoSiTefInterativo( ;
902:                     @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
903:                     @loc_cBuf, LEN(loc_cBuf), loc_nCont)
904: 
905:                 loc_oBO.this_nProximoComando = loc_nCmd
906:                 loc_oBO.this_nTipoCampo      = loc_nTipo

*-- Linhas 1003 a 1046:
1003:     * ProcessarFimTransacao - Processa resultado quando cmd=30 (fim transacao)
1004:     * Confirma no SiTef, coleta campos de retorno e grava arquivos de resposta
1005:     *==========================================================================
1006:     PROCEDURE ProcessarFimTransacao()
1007:         LOCAL loc_oBO, loc_cData, loc_cHora, loc_oErro, loc_cBuf
1008:         loc_oBO = THIS.this_oBusinessObject
1009:         TRY
1010:             *-- Data/hora para finalizacao
1011:             loc_cData = STR(YEAR(DATE()), 4) + ;
1012:                         SUBSTR(DTOC(DATE()), 4, 2) + ;
1013:                         SUBSTR(DTOC(DATE()), 1, 2)
1014:             loc_cHora = STRTRAN(TIME(), ":", "")
1015: 
1016:             *-- Confirma transacao no SiTef (1=confirmar)
1017:             FinalizaTransacaoSiTefInterativo(1, loc_oBO.this_cCupom, loc_cData, loc_cHora)
1018: 
1019:             *-- Extrai campos do buffer acumulado no BO (formato SiTef: campos separados por CHR(0))
1020:             loc_cBuf = ALLTRIM(loc_oBO.this_cBuffer)
1021:             IF !EMPTY(loc_cBuf)
1022:                 loc_oBO.this_cTipTran  = THIS.ExtrairCampoBuf(loc_cBuf, 1)
1023:                 loc_oBO.this_cDataHora = THIS.ExtrairCampoBuf(loc_cBuf, 2)
1024:                 loc_oBO.this_cCartao   = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 3)), 5)
1025:                 loc_oBO.this_cNsu      = THIS.ExtrairCampoBuf(loc_cBuf, 4)
1026:                 loc_oBO.this_cAutoriza = THIS.ExtrairCampoBuf(loc_cBuf, 5)
1027:                 loc_oBO.this_cBandeira = LEFT(ALLTRIM(THIS.ExtrairCampoBuf(loc_cBuf, 6)), 5)
1028:                 loc_oBO.this_cFinaliza = THIS.ExtrairCampoBuf(loc_cBuf, 7)
1029:             ENDIF
1030: 
1031:             *-- Grava arquivos de resposta C:\client\Resp\IntPos.*
1032:             loc_oBO.MontarRetorno( ;
1033:                 loc_oBO.this_cTipTran, ;
1034:                 loc_oBO.this_cDataHora, ;
1035:                 loc_oBO.this_cCupom, ;
1036:                 loc_oBO.this_cCartao + loc_oBO.this_cBandeira, ;
1037:                 loc_oBO.this_cNsu, ;
1038:                 loc_oBO.this_cAutoriza, ;
1039:                 loc_oBO.this_cFinaliza, ;
1040:                 loc_oBO.this_nValPago, ;
1041:                 loc_oBO.this_cMRet)
1042: 
1043:             THIS.Release()
1044: 
1045:         CATCH TO loc_oErro
1046:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 1076 a 1119:
1076:     * Inicializa conexao SiTef e executa loop inicial ate pedir entrada
1077:     * Equivale a GetDigitos.GotFocus do legado (231 linhas)
1078:     *==========================================================================
1079:     PROCEDURE TxtDigitosGotFocus()
1080:         LOCAL loc_oBO, loc_cValPago, loc_cIdTerminal, loc_nRet, loc_oErro
1081:         LOCAL loc_cData, loc_cHora, loc_lSucesso
1082:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1083:         LOCAL loc_nCont, loc_nTipo1, loc_cBandeira, loc_nTipoVendaCount
1084:         LOCAL loc_cDataFmt
1085:         loc_oBO = THIS.this_oBusinessObject
1086:         loc_lSucesso = .F.
1087: 
1088:         TRY
1089:             *-- ID do terminal: empresa (4 dig) + caixa (6 dig)
1090:             loc_cIdTerminal = TRANSFORM(loc_oBO.this_nEmps,    "@L 9999") + ;
1091:                               TRANSFORM(loc_oBO.this_nCncaixas, "@L 999999")
1092: 
1093:             *-- Formata valor para SiTef (virgula como separador decimal)
1094:             loc_cValPago = STRTRAN( ;
1095:                 ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ",")
1096: 
1097:             IF VARTYPE(THIS.txt_4c_Valor) = "O"
1098:                 THIS.txt_4c_Valor.Value = loc_cValPago
1099:             ENDIF
1100: 
1101:             *-- Configura interface SiTef (retorna 0 = sucesso)
1102:             loc_nRet = ConfiguraIntSiTefInterativo( ;
1103:                 loc_oBO.this_cEndSiTef, ;
1104:                 loc_cIdTerminal, ;
1105:                 loc_cIdTerminal, ;
1106:                 0)
1107:             IF loc_nRet = 0
1108:                 loc_lSucesso = .T.
1109:             ELSE
1110:                 THIS.CancelarTransacao("Sem comunica" + CHR(231) + CHR(227) + "o com SiTef")
1111:             ENDIF
1112: 
1113:             IF loc_lSucesso
1114:                 *-- Data e hora no formato SiTef (AAAAMMDD e HHMMSS)
1115:                 loc_cData = STR(YEAR(DATE()), 4) + ;
1116:                             SUBSTR(DTOC(DATE()), 4, 2) + ;
1117:                             SUBSTR(DTOC(DATE()), 1, 2)
1118:                 loc_cHora = STRTRAN(TIME(), ":", "")
1119: 

*-- Linhas 1154 a 1197:
1154:                 loc_oBO.this_cBandeira = ""
1155:                 loc_oBO.this_cMRet     = ""
1156: 
1157:                 *-- OptionGroup desabilitado ate concluir handshake
1158:                 IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
1159:                     THIS.obj_4c_TipoVenda.Enabled = .F.
1160:                 ENDIF
1161: 
1162:                 *-- Loop de inicializacao SiTef (apenas sem leitora fisica: lCartao="N")
1163:                 loc_nRet           = 10000
1164:                 loc_nCont          = 0
1165:                 loc_nTipo1         = 1
1166:                 loc_cBandeira      = ""
1167:                 loc_nTipoVendaCount = 0
1168: 
1169:                 IF loc_oBO.this_cLCartao = "N"
1170:                     DO WHILE loc_nRet = 10000
1171:                         loc_nCmd  = loc_oBO.this_nProximoComando
1172:                         loc_nTipo = loc_oBO.this_nTipoCampo
1173:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1174:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1175:                         loc_cBuf  = SPACE(2000)
1176: 
1177:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1178:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
1179:                             @loc_cBuf, LEN(loc_cBuf), loc_nCont)
1180: 
1181:                         loc_oBO.this_nProximoComando = loc_nCmd
1182:                         loc_oBO.this_nTipoCampo      = loc_nTipo
1183:                         loc_oBO.this_nTamanhoMinimo  = loc_nMin
1184:                         loc_oBO.this_nTamanhoMaximo  = loc_nMax
1185:                         loc_oBO.this_cBuffer         = loc_cBuf
1186: 
1187:                         *-- Deteccao de tipo de venda (string SiTef especifica)
1188:                         IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO"$UPPER(loc_cBuf)
1189:                             IF loc_nTipoVendaCount = 2
1190:                                 THIS.this_lTipoVenda = .T.
1191:                             ELSE
1192:                                 loc_nTipoVendaCount = 2
1193:                             ENDIF
1194:                         ENDIF
1195: 
1196:                         *-- Cancelar: desabilitado durante PIN
1197:                         IF VARTYPE(THIS.cnt_4c_Saida) = "O"

*-- Linhas 1434 a 1477:
1434:     * Envia os 4 digitos ao SiTef e continua o loop de transacao
1435:     * Equivale a GetDigitos.Valid do legado (185 linhas)
1436:     *==========================================================================
1437:     PROCEDURE TxtDigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1438:         LOCAL loc_oBO, loc_cValDigitos, loc_oErro
1439:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1440:         LOCAL loc_nRet, loc_nCont, loc_lParcelas, loc_nCampo
1441: 
1442:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1443:             RETURN
1444:         ENDIF
1445: 
1446:         loc_oBO = THIS.this_oBusinessObject
1447: 
1448:         TRY
1449:             IF THIS.this_lAbandona
1450:                 THIS.Release()
1451:             ELSE
1452:                 loc_cValDigitos = ALLTRIM(THIS.txt_4c_Digitos.Value)
1453: 
1454:                 IF LEN(loc_cValDigitos) <> 4 AND !EMPTY(loc_cValDigitos)
1455:                     MsgErro("Quantidade de D" + CHR(237) + "gitos Inv" + CHR(225) + "lida", ;
1456:                         "Erro na Transa" + CHR(231) + CHR(227) + "o")
1457:                     THIS.txt_4c_Digitos.Value = ""
1458:                 ELSE
1459:                     IF !EMPTY(loc_cValDigitos)
1460:                     *-- Prepara buffer com os 4 digitos + padding
1461:                     loc_oBO.this_cBuffer = loc_cValDigitos + ;
1462:                         REPLICATE(CHR(0), 2000 - LEN(loc_cValDigitos))
1463:                     loc_oBO.this_nCiclos = 0
1464:                     loc_nRet     = 10000
1465:                     loc_nCont    = 1000
1466:                     loc_lParcelas = .F.
1467:                     loc_nCampo   = 1
1468: 
1469:                     DO WHILE loc_nRet = 10000
1470:                         loc_nCmd  = loc_oBO.this_nProximoComando
1471:                         loc_nTipo = loc_oBO.this_nTipoCampo
1472:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1473:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1474:                         loc_cBuf  = loc_oBO.this_cBuffer
1475: 
1476:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1477:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;

*-- Linhas 1711 a 1784:
1711:     * TxtText1GotFocus - GotFocus do campo de numero de parcelas
1712:     * Equivale a Text1.GotFocus do legado
1713:     *==========================================================================
1714:     PROCEDURE TxtText1GotFocus()
1715:         THIS.this_lTvenda = .F.
1716:     ENDPROC
1717: 
1718:     *==========================================================================
1719:     * TxtText1LostFocus - LostFocus do campo de numero de parcelas
1720:     * Formata o valor e habilita campo de data de vencimento
1721:     * Equivale a Text1.LostFocus do legado
1722:     *==========================================================================
1723:     PROCEDURE TxtText1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1724:         LOCAL loc_oErro
1725:         TRY
1726:             IF VARTYPE(THIS.txt_4c_Text1) = "O"
1727:                 THIS.txt_4c_Text1.Value = ;
1728:                     TRANSFORM(VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value))), "@L 99")
1729:                 THIS.txt_4c_Text1.Enabled = .F.
1730:                 IF VARTYPE(THIS.txt_4c_Datas) = "O"
1731:                     THIS.txt_4c_Datas.Enabled = .T.
1732:                 ENDIF
1733:             ENDIF
1734:         CATCH TO loc_oErro
1735:             MsgErro(loc_oErro.Message, "Erro TEF Text1 LostFocus")
1736:         ENDTRY
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * TxtText1KeyPress - Simula Valid de Text1 via ENTER/TAB (numero de parcelas)
1741:     * Envia contagem de parcelas ao SiTef e continua loop
1742:     * Equivale a Text1.Valid do legado (22 linhas)
1743:     *==========================================================================
1744:     PROCEDURE TxtText1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1745:         LOCAL loc_oBO, loc_nParcs, loc_oErro
1746: 
1747:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
1748:             RETURN
1749:         ENDIF
1750: 
1751:         loc_oBO = THIS.this_oBusinessObject
1752: 
1753:         TRY
1754:             IF VARTYPE(THIS.txt_4c_Text1) = "O" AND !EMPTY(THIS.txt_4c_Text1.Value)
1755:                 loc_nParcs = VAL(ALLTRIM(TRANSFORM(THIS.txt_4c_Text1.Value)))
1756:                 loc_oBO.this_nNumParcs = loc_nParcs
1757: 
1758:                 *-- Envia numero de parcelas ao SiTef no Buffer
1759:                 loc_oBO.this_cBuffer   = TRANSFORM(loc_nParcs, "@L 99") + ;
1760:                     REPLICATE(CHR(0), 1990)
1761:                 loc_oBO.this_nContinua = 1000
1762:                 loc_oBO.this_nCiclos   = 0
1763: 
1764:                 THIS.ExecutarLoopSiTef(1000)
1765: 
1766:                 IF loc_oBO.this_nProximoComando = 23
1767:                     IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1768:                         THIS.cnt_4c_Saida.Buttons(1).Enabled = .F.
1769:                     ENDIF
1770:                     THIS.AtualizarInstrucao("Digite a Senha")
1771:                 ELSE
1772:                     IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1773:                         THIS.cnt_4c_Saida.Buttons(1).Enabled = .T.
1774:                     ENDIF
1775:                 ENDIF
1776: 
1777:                 IF loc_oBO.this_nProximoComando = 30
1778:                     THIS.ProcessarFimTransacao()
1779:                 ENDIF
1780:             ENDIF
1781: 
1782:         CATCH TO loc_oErro
1783:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
1784:                 "Erro TEF Parcelas KeyPress")

*-- Linhas 1790 a 1867:
1790:     * Inicia fluxo SiTef para modalidade pre-datada ou parcelada com data
1791:     * Equivale a GetDatas.GotFocus do legado (188 linhas)
1792:     *==========================================================================
1793:     PROCEDURE TxtDatasGotFocus()
1794:         LOCAL loc_oBO, loc_oErro
1795:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
1796:         LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo
1797:         loc_oBO = THIS.this_oBusinessObject
1798: 
1799:         TRY
1800:             THIS.this_lTipoVenda = .F.
1801: 
1802:             *-- Zera campos de resultado acumulados no ciclo anterior
1803:             loc_oBO.this_cTipTran  = ""
1804:             loc_oBO.this_cDataHora = ""
1805:             loc_oBO.this_cNsu      = ""
1806:             loc_oBO.this_cAutoriza = ""
1807:             loc_oBO.this_cFinaliza = ""
1808:             loc_oBO.this_cCartao   = ""
1809:             loc_oBO.this_cBandeira = ""
1810:             loc_oBO.this_cMRet     = ""
1811: 
1812:             THIS.AtualizarInstrucao("Digite a Data" + CHR(13) + "de Vencimento")
1813: 
1814:             *-- Fluxo de tipo de venda: somente para debito simples (nao pre-datado, nao DCD, nao CDC)
1815:             IF loc_oBO.this_cDebCred <> "P" AND ;
1816:                !loc_oBO.this_lDCD AND ;
1817:                loc_oBO.this_cTcdc <> "S"
1818: 
1819:                 loc_nRet  = 10000
1820:                 loc_nCont = 1000
1821: 
1822:                 IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND THIS.obj_4c_TipoVenda.Enabled
1823:                     *-- OptionGroup habilitado: envia selecao do usuario
1824:                     loc_oBO.this_cBuffer = STR(THIS.obj_4c_TipoVenda.Value, 1) + ;
1825:                         REPLICATE(CHR(0), 1999)
1826:                 ELSE
1827:                     *-- OptionGroup desabilitado: aguarda SiTef chegar ao cmd=30 primeiro
1828:                     DO WHILE loc_oBO.this_nProximoComando <> 30
1829:                         loc_nCmd  = loc_oBO.this_nProximoComando
1830:                         loc_nTipo = loc_oBO.this_nTipoCampo
1831:                         loc_nMin  = loc_oBO.this_nTamanhoMinimo
1832:                         loc_nMax  = loc_oBO.this_nTamanhoMaximo
1833:                         loc_cBuf  = SPACE(2000)
1834: 
1835:                         loc_nRet = ContinuaFuncaoSiTefInterativo( ;
1836:                             @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
1837:                             @loc_cBuf, LEN(loc_cBuf), loc_nCont)
1838: 
1839:                         loc_oBO.this_nProximoComando = loc_nCmd
1840:                         loc_oBO.this_nTipoCampo      = loc_nTipo
1841:                         loc_oBO.this_nTamanhoMinimo  = loc_nMin
1842:                         loc_oBO.this_nTamanhoMaximo  = loc_nMax
1843:                         loc_oBO.this_cBuffer         = loc_cBuf
1844: 
1845:                         IF "SENHA"$UPPER(ALLTRIM(loc_cBuf)) OR loc_nCmd = 23
1846:                             THIS.AtualizarInstrucao("Digite a Senha")
1847:                         ENDIF
1848:                         IF VARTYPE(THIS.cnt_4c_Saida) = "O"
1849:                             THIS.cnt_4c_Saida.Buttons(1).Enabled = (loc_nCmd <> 23)
1850:                         ENDIF
1851:                         IF loc_nRet < 0
1852:                             THIS.ErroTef(loc_nRet)
1853:                             EXIT
1854:                         ENDIF
1855:                     ENDDO
1856: 
1857:                     IF !THIS.this_lAbandona
1858:                         *-- Envia numero de parcelas do Text1 (campo de parcelas)
1859:                         IF VARTYPE(THIS.txt_4c_Text1) = "O"
1860:                             loc_oBO.this_cBuffer = ALLTRIM(THIS.txt_4c_Text1.Value) + ;
1861:                                 REPLICATE(CHR(0), 1998)
1862:                         ELSE
1863:                             loc_oBO.this_cBuffer = "01" + REPLICATE(CHR(0), 1998)
1864:                         ENDIF
1865:                     ENDIF
1866:                 ENDIF
1867: 

*-- Linhas 1939 a 1982:
1939:                             EXIT
1940:                         ENDIF
1941: 
1942:                         *-- cmd=30 + optiongroup=2 (parcelado): inversao de risco ou EXIT
1943:                         IF loc_nCmd = 30 AND VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
1944:                            THIS.obj_4c_TipoVenda.Value = 2
1945:                             IF loc_nTipo = 510
1946:                                 IF loc_oBO.this_cGarantias = "S"
1947:                                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1948:                                 ELSE
1949:                                     loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
1950:                                 ENDIF
1951:                                 loc_nCont = 1000
1952:                                 LOOP
1953:                             ENDIF
1954:                             EXIT
1955:                         ENDIF
1956: 
1957:                         *-- cmd=30 + TipoCampo=506: envia data DDMMAAAA
1958:                         IF loc_nCmd = 30 AND loc_nTipo = 506
1959:                             IF VARTYPE(THIS.txt_4c_Datas) = "O"
1960:                                 loc_cDataFmt = DTOC(THIS.txt_4c_Datas.Value)
1961:                                 loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(loc_cDataFmt, 1, 2)) + ;
1962:                                     ALLTRIM(SUBSTR(loc_cDataFmt, 4, 2)) + ;
1963:                                     ALLTRIM(SUBSTR(loc_cDataFmt, 7, 4)) + ;
1964:                                     REPLICATE(CHR(0), 1992)
1965:                             ELSE
1966:                                 loc_oBO.this_cBuffer = REPLICATE(CHR(0), 2000)
1967:                             ENDIF
1968:                             loc_nCont = 1000
1969:                             LOOP
1970:                         ENDIF
1971: 
1972:                         *-- cmd=30 + TipoCampo=505: envia parcelas
1973:                         IF loc_nCmd = 30 AND loc_nTipo = 505
1974:                             loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + ;
1975:                                 REPLICATE(CHR(0), 1998)
1976:                             loc_nCont = 1000
1977:                             LOOP
1978:                         ENDIF
1979: 
1980:                         *-- cmd=20 + TipoCampo=507: primeira parcela a vista
1981:                         IF loc_nCmd = 20 AND loc_nTipo = 507
1982:                             IF MsgConfirma("Primeira Parcela A Vista")

*-- Linhas 2097 a 2140:
2097:     * Valida data e envia ao SiTef para transacao pre-datada
2098:     * Equivale a GetDatas.Valid do legado (183 linhas)
2099:     *==========================================================================
2100:     PROCEDURE TxtDatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2101:         LOCAL loc_oBO, loc_dData, loc_oErro
2102:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf
2103:         LOCAL loc_nRet, loc_nCont, loc_cDataFmt, loc_lPrimo
2104: 
2105:         IF par_nKeyCode <> 13 AND par_nKeyCode <> 9
2106:             RETURN
2107:         ENDIF
2108: 
2109:         IF LASTKEY() = 27
2110:             RETURN
2111:         ENDIF
2112: 
2113:         loc_oBO = THIS.this_oBusinessObject
2114: 
2115:         TRY
2116:             *-- Determina data (default: hoje + 30 dias se campo vazio)
2117:             loc_dData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
2118:             THIS.txt_4c_Datas.Value = loc_dData
2119:             THIS.txt_4c_Datas.Refresh()
2120: 
2121:             *-- Para parcelado (Value=2): data futura obrigatoria
2122:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O" AND ;
2123:                THIS.obj_4c_TipoVenda.Value = 2 AND ;
2124:                !EMPTY(THIS.txt_4c_Datas.Value) AND ;
2125:                loc_dData <= DATE()
2126:                 MsgErro("Data Inv" + CHR(225) + "lida", ;
2127:                     "Erro na Transa" + CHR(231) + CHR(227) + "o")
2128:             ELSE
2129:                 loc_oBO.this_dData = loc_dData
2130: 
2131:                 *-- Pre-loop: aguarda SiTef chegar ao cmd=30 (safety, normalmente ja esta la)
2132:                 loc_nCont = 0
2133:                 DO WHILE loc_oBO.this_nProximoComando <> 30
2134:                     loc_nCmd  = loc_oBO.this_nProximoComando
2135:                     loc_nTipo = loc_oBO.this_nTipoCampo
2136:                     loc_nMin  = loc_oBO.this_nTamanhoMinimo
2137:                     loc_nMax  = loc_oBO.this_nTamanhoMaximo
2138:                     loc_cBuf  = SPACE(2000)
2139: 
2140:                     loc_nRet = ContinuaFuncaoSiTefInterativo( ;

*-- Linhas 2392 a 2595:
2392:     ENDPROC
2393: 
2394:     *==========================================================================
2395:     * OgTipoVendaInteractiveChange - InteractiveChange do OptionGroup tipo de venda
2396:     * Habilita txt_4c_Datas e define data inicial conforme selecao
2397:     * Equivale a Optiongroup1.InteractiveChange do legado
2398:     *==========================================================================
2399:     PROCEDURE OgTipoVendaInteractiveChange()
2400:         LOCAL loc_oErro
2401:         TRY
2402:             IF VARTYPE(THIS.txt_4c_Datas) = "O"
2403:                 THIS.txt_4c_Datas.Enabled = .T.
2404:             ENDIF
2405:             IF VARTYPE(THIS.obj_4c_TipoVenda) = "O"
2406:                 IF THIS.obj_4c_TipoVenda.Value = 1
2407:                     IF VARTYPE(THIS.txt_4c_Datas) = "O"
2408:                         THIS.txt_4c_Datas.Value = DATE()
2409:                     ENDIF
2410:                 ELSE
2411:                     IF VARTYPE(THIS.txt_4c_Datas) = "O"
2412:                         THIS.txt_4c_Datas.Value = CTOD("")
2413:                     ENDIF
2414:                 ENDIF
2415:             ENDIF
2416:         CATCH TO loc_oErro
2417:             MsgErro(loc_oErro.Message, "Erro TEF TipoVenda InteractiveChange")
2418:         ENDTRY
2419:     ENDPROC
2420: 
2421:     *==========================================================================
2422:     * OgTipoVendaKeyPress - KeyPress do OptionGroup (avanca com ENTER)
2423:     * Equivale a Optiongroup1.KeyPress do legado
2424:     *==========================================================================
2425:     PROCEDURE OgTipoVendaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2426:         IF par_nKeyCode = 13
2427:             KEYBOARD "{TAB}"
2428:         ENDIF
2429:     ENDPROC
2430: 
2431:     *==========================================================================
2432:     * CmdCancelaClick - Click do botao CANCELA (cnt_4c_Saida.Buttons(1))
2433:     * Cancela transacao SiTef em andamento e fecha o form
2434:     * Equivale a SAIDA.CANCELA.Click do legado
2435:     *==========================================================================
2436:     PROCEDURE CmdCancelaClick()
2437:         LOCAL loc_oBO, loc_oErro
2438:         LOCAL loc_nCmd, loc_nTipo, loc_nMin, loc_nMax, loc_cBuf, loc_nRet
2439:         loc_oBO = THIS.this_oBusinessObject
2440: 
2441:         TRY
2442:             loc_nCmd  = loc_oBO.this_nProximoComando
2443:             loc_nTipo = loc_oBO.this_nTipoCampo
2444:             loc_nMin  = loc_oBO.this_nTamanhoMinimo
2445:             loc_nMax  = loc_oBO.this_nTamanhoMaximo
2446:             loc_cBuf  = SPACE(2000)
2447: 
2448:             *-- Envia -1 para cancelar transacao em andamento
2449:             loc_nRet = ContinuaFuncaoSiTefInterativo( ;
2450:                 @loc_nCmd, @loc_nTipo, @loc_nMin, @loc_nMax, ;
2451:                 @loc_cBuf, LEN(loc_cBuf), -1)
2452: 
2453:             loc_oBO.this_nProximoComando = loc_nCmd
2454:             loc_oBO.this_cBuffer         = loc_cBuf
2455: 
2456:             loc_oBO.RetornoFalha( ;
2457:                 "Oper. Cancelada pelo Usu" + CHR(225) + "rio(1)", ;
2458:                 loc_oBO.this_nValPago)
2459: 
2460:         CATCH TO loc_oErro
2461:             MsgErro(loc_oErro.Message, "Erro ao cancelar TEF")
2462:         ENDTRY
2463: 
2464:         THIS.Release()
2465:     ENDPROC
2466: 
2467:     *==========================================================================
2468:     * ErroTef - Trata erro SiTef: delega ao BO e sinaliza abandono
2469:     * Equivale a PROCEDURE errotef do legado
2470:     * NAO chama Release() - chamador decide se fecha o form
2471:     *==========================================================================
2472:     PROCEDURE ErroTef(par_nRetorno)
2473:         LOCAL loc_oErro
2474:         TRY
2475:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
2476:                 THIS.this_oBusinessObject.ErroTef(par_nRetorno)
2477:             ENDIF
2478:             THIS.this_lAbandona = .T.
2479:         CATCH TO loc_oErro
2480:             MsgErro(loc_oErro.Message, "Erro ErroTef")
2481:         ENDTRY
2482:     ENDPROC
2483: 
2484:     *==========================================================================
2485:     * BtnIncluirClick - Nao aplicavel a este form
2486:     * SIGPRDFT e um dialog modal de transacao TEF/SiTef (form OPERACIONAL plano).
2487:     * Nao possui estrutura CRUD (sem grid, sem Page1/Page2, sem registros).
2488:     * Toda interacao ocorre via protocolo SiTef (TxtDigitosGotFocus/KeyPress,
2489:     * TxtDatasGotFocus/KeyPress, CmdCancelaClick).
2490:     *==========================================================================
2491:     PROCEDURE BtnIncluirClick()
2492:         NODEFAULT
2493:     ENDPROC
2494: 
2495:     *==========================================================================
2496:     * BtnAlterarClick - Nao aplicavel a este form
2497:     * Ver BtnIncluirClick para explicacao.
2498:     *==========================================================================
2499:     PROCEDURE BtnAlterarClick()
2500:         NODEFAULT
2501:     ENDPROC
2502: 
2503:     *==========================================================================
2504:     * BtnVisualizarClick - Nao aplicavel a este form
2505:     * Ver BtnIncluirClick para explicacao.
2506:     *==========================================================================
2507:     PROCEDURE BtnVisualizarClick()
2508:         NODEFAULT
2509:     ENDPROC
2510: 
2511:     *==========================================================================
2512:     * BtnExcluirClick - Nao aplicavel a este form
2513:     * Ver BtnIncluirClick para explicacao.
2514:     *==========================================================================
2515:     PROCEDURE BtnExcluirClick()
2516:         NODEFAULT
2517:     ENDPROC
2518: 
2519:     *==========================================================================
2520:     * BtnBuscarClick - Nao aplicavel a este form
2521:     * Ver BtnIncluirClick para explicacao.
2522:     *==========================================================================
2523:     PROCEDURE BtnBuscarClick()
2524:         NODEFAULT
2525:     ENDPROC
2526: 
2527:     *==========================================================================
2528:     * BtnEncerrarClick - Cancela a transacao TEF e fecha o form
2529:     * Form TEF usa botao Cancelar (cnt_4c_Saida) como mecanismo de saida.
2530:     * BtnEncerrarClick delega ao mesmo comportamento de cancelamento.
2531:     *==========================================================================
2532:     PROCEDURE BtnEncerrarClick()
2533:         THIS.CmdCancelaClick()
2534:     ENDPROC
2535: 
2536:     *==========================================================================
2537:     * BtnSalvarClick - Nao aplicavel a este form
2538:     * Ver BtnIncluirClick para explicacao.
2539:     *==========================================================================
2540:     PROCEDURE BtnSalvarClick()
2541:         NODEFAULT
2542:     ENDPROC
2543: 
2544:     *==========================================================================
2545:     * BtnCancelarClick - Cancela a transacao TEF e fecha o form
2546:     * Equivalente a BtnEncerrarClick para compatibilidade com o pipeline.
2547:     *==========================================================================
2548:     PROCEDURE BtnCancelarClick()
2549:         THIS.CmdCancelaClick()
2550:     ENDPROC
2551: 
2552:     *==========================================================================
2553:     * FormParaBO - Nao aplicavel a este form
2554:     * Form TEF nao tem campos de cadastro para transferir ao BO.
2555:     * Os parametros da transacao sao passados via CREATEOBJECT (Init).
2556:     *==========================================================================
2557:     PROTECTED PROCEDURE FormParaBO()
2558:         RETURN
2559:     ENDPROC
2560: 
2561:     *==========================================================================
2562:     * BOParaForm - Nao aplicavel a este form
2563:     * Form TEF nao tem campos de cadastro para carregar do BO.
2564:     * O estado da transacao e gerenciado diretamente pelo protocolo SiTef.
2565:     *==========================================================================
2566:     PROTECTED PROCEDURE BOParaForm()
2567:         RETURN
2568:     ENDPROC
2569: 
2570:     *==========================================================================
2571:     * HabilitarCampos - Nao aplicavel a este form
2572:     * Habilitacao dos campos e controlada pelo protocolo SiTef (GotFocus/Valid).
2573:     *==========================================================================
2574:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2575:         RETURN
2576:     ENDPROC
2577: 
2578:     *==========================================================================
2579:     * CarregarLista - Nao aplicavel a este form
2580:     * Form TEF nao tem grid de lista de registros.
2581:     * Retorna .T. para compatibilidade com FormBase.
2582:     *==========================================================================
2583:     PROTECTED FUNCTION CarregarLista() AS Boolean
2584:         RETURN .T.
2585:     ENDFUNC
2586: 
2587:     *==========================================================================
2588:     * AjustarBotoesPorModo - Nao aplicavel a este form
2589:     * Form TEF nao tem botoes CRUD que precisam ser ajustados por modo.
2590:     *==========================================================================
2591:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2592:         RETURN
2593:     ENDPROC
2594: 
2595: ENDDEFINE


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

