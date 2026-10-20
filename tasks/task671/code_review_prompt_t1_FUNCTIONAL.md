# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPrioridade()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPrioridadeExec()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrRsa.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (901 linhas total):

*-- Linhas 1 a 169:
1: *==============================================================================
2: * FormSigPrRsa.prg - Rec CHR(225) lculo de Saldos de Produto
3: * Form OPERACIONAL - layout plano sem PageFrame (SIGPRRSA.SCX do legado)
4: * Uso interativo  : CREATEOBJECT("FormSigPrRsa").Show()
5: * Uso parametrizado: CREATEOBJECT("FormSigPrRsa", cParam, nPrior).Show()
6: *==============================================================================
7: 
8: DEFINE CLASS FormSigPrRsa AS FormBase
9: 
10:     *-- Parametros de execucao (populados em Init antes de DODEFAULT)
11:     this_cMensagemErro = ""
12:     this_lParametrizado = .F.    && .T. = chamado por Fortyus.Exe (batch)
13:     this_nPrioridade    = 0      && Filtro de prioridade: 0 ou 1
14:     this_lParar         = .F.    && Flag para interromper o loop de processamento
15:     *-- Guarda de reentrancia do funil de validacao: o MsgAviso de
16:     *-- "Prioridade Invalida" eh MODAL, tira o foco do txt_4c_Prioridade e
17:     *-- redispara o proprio LostFocus; o SetFocus() de volta ao campo faz o
18:     *-- mesmo. Sem a guarda, a validacao se empilha e o aviso sai em loop.
19:     this_lEmValidacao   = .F.
20:     *-- Ultimo valor JA avisado como invalido. Sentinela -1 = nada avisado
21:     *-- ainda (a coluna Priors aceita 0 e 1, logo -1 nunca eh valor de tela).
22:     *-- O funil de validacao eh alcancado por DOIS eventos no mesmo gesto do
23:     *-- usuario: o KeyPress de ENTER/TAB roda e, em seguida, o foco sai do
24:     *-- campo e o LostFocus roda de novo; indo com o MOUSE direto ao botao
25:     *-- Processar, LostFocus e BtnProcessarClick fazem o mesmo par. A guarda
26:     *-- this_lEmValidacao nao cobre isso - ela ja foi liberada quando o
27:     *-- segundo evento chega -, entao o "Prioridade Invalida!!!" saia DUAS
28:     *-- vezes para um unico TAB. No legado o Valid devolvendo .F. PRENDE o
29:     *-- foco e descarta o clique, ou seja o aviso sai UMA vez por tentativa.
30:     *-- Zerada pelo InteractiveChange: mexer no campo volta a avisar.
31:     this_nPrioridadeAvisada = -1
32: 
33:     *-- Propriedades visuais (PILAR 1 - identico ao legado SIGPRRSA)
34:     Width        = 580
35:     Height       = 200
36:     AutoCenter   = .T.
37:     BorderStyle  = 2
38:     Caption      = "Recalculo de Saldos de Produto"
39:     ShowTips     = .T.
40:     ShowWindow = 1
41:     ControlBox   = .F.
42:     MaxButton    = .F.
43:     MinButton    = .F.
44:     TitleBar     = 0
45:     WindowType   = 1
46:     DataSession  = 2
47: 
48:     *--------------------------------------------------------------------------
49:     * Init - Armazena parametros ANTES de DODEFAULT (que chama InicializarForm)
50:     *--------------------------------------------------------------------------
51:     PROCEDURE Init(par_cParam, par_nPrior)
52:         THIS.Caption             = "Rec" + CHR(225) + "lculo de Saldos de Produto"
53:         THIS.this_lParametrizado = (TYPE("par_cParam") = "C")
54:         THIS.this_nPrioridade    = IIF(TYPE("par_nPrior") = "N", par_nPrior, 0)
55:         RETURN DODEFAULT()
56:     ENDPROC
57: 
58:     *--------------------------------------------------------------------------
59:     * Activate - Modo parametrizado: dispara processamento automaticamente
60:     *--------------------------------------------------------------------------
61:     PROCEDURE Activate()
62:         IF THIS.this_lParametrizado
63:             THIS.BtnProcessarClick()
64:         ENDIF
65:     ENDPROC
66: 
67:     *--------------------------------------------------------------------------
68:     * ConfigurarPageFrame - Aparencia base do form OPERACIONAL (sem PageFrame)
69:     *--------------------------------------------------------------------------
70:     PROTECTED PROCEDURE ConfigurarPageFrame()
71:         THIS.BackColor  = RGB(212, 208, 200)
72:         THIS.ScrollBars = 0
73:         THIS.Picture    = gc_4c_CaminhoIcones + "new_background.jpg"
74:     ENDPROC
75: 
76:     *--------------------------------------------------------------------------
77:     * InicializarForm - Cria BO e constroi estrutura base do form
78:     *--------------------------------------------------------------------------
79:     PROTECTED PROCEDURE InicializarForm()
80:         LOCAL loc_lSucesso
81:         loc_lSucesso = .F.
82: 
83:         TRY
84:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrRsaBO")
85: 
86:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
87:                 THIS.this_oBusinessObject.this_nPrioridade    = THIS.this_nPrioridade
88:                 THIS.this_oBusinessObject.this_lParametrizado = THIS.this_lParametrizado
89: 
90:                 THIS.ConfigurarPageFrame()
91:                 THIS.ConfigurarCabecalho()
92:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
94:                 *-- ORDEM DOS AddObject = Z-ORDER (o ultimo desenha POR CIMA).
95:                 *-- No SCX legado a ordem de declaracao eh cntSombra ->
96:                 *-- Shape1 -> SAIR -> OK -> Label1 -> Label2 ->
97:                 *-- Get_Prioridade, isto eh, o Shape1 fica ATRAS dos botoes.
98:                 *-- Criando ConfigurarPaginaDados() por ultimo, o Shape1
99:                 *-- (Left 480..528, Top 7..36) ficava SOBRE cmd_4c_Processar
100:                 *-- (430..505) e cmd_4c_Encerrar (505..580): como ele eh
101:                 *-- BackStyle = 0 / BorderStyle = 0, nao pinta nada e o
102:                 *-- defeito eh INVISIVEL em screenshot, mas a caixa
103:                 *-- transparente ainda recebe o mouse e come o clique na
104:                 *-- faixa que cobre os dois botoes. Dai a chamada vir ANTES.
105:                 THIS.ConfigurarPaginaDados()
106:                 THIS.ConfigurarPaginaLista()
107: 
108:                 IF THIS.this_lParametrizado
109:                     THIS.this_oBusinessObject.IniciarLog( ;
110:                         "Iniciando o Processamento : Fortyus.Exe (SigOpClS) - Recalculo de Saldos")
111:                 ENDIF
112: 
113:                 loc_lSucesso = .T.
114:             ELSE
115:                 THIS.this_cMensagemErro = "Erro ao criar SigPrRsaBO."
116:             ENDIF
117:         CATCH TO loc_oErro
118:             THIS.this_cMensagemErro = loc_oErro.Message
119:             MsgErro(loc_oErro.Message, "Erro")
120:         ENDTRY
121: 
122:         RETURN loc_lSucesso
123:     ENDPROC
124: 
125:     *--------------------------------------------------------------------------
126:     * ConfigurarCabecalho - Container de titulo superior (cntSombra do legado)
127:     * AddObject FORA de WITH, depois WITH caminho explicito (anti-ghost props)
128:     *--------------------------------------------------------------------------
129:     PROTECTED PROCEDURE ConfigurarCabecalho()
130:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
131:         WITH THIS.cnt_4c_Cabecalho
132:             .Top         = 0
133:             .Left        = 0
134:             .Width       = THIS.Width
135:             .Height      = 80
136:             .BackColor   = RGB(100, 100, 100)
137:             .BackStyle   = 1
138:             .BorderWidth = 0
139:             .Visible     = .T.
140:         ENDWITH
141: 
142:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
143:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
144:             .AutoSize  = .F.
145:             .BackStyle = 0
146:             .Caption   = THIS.Caption
147:             .FontBold  = .T.
148:             .FontName  = "Tahoma"
149:             .FontSize  = 18
150:             .ForeColor = RGB(0, 0, 0)
151:             .Height    = 40
152:             .Left      = 10
153:             .Top       = 18
154:             *-- THIS.Width - 20 (nao a Width do container, nem o 769 do dump):
155:             *-- com Left = 10, usar a largura cheia do pai joga 10px do label
156:             *-- para fora dele, e filho que extrapola o pai eh RECORTADO sem
157:             *-- erro nenhum. O dump declara 769 porque o cntSombra do Form
158:             *-- Designer tem 800 de largura contra Form.Width = 580.
159:             .Width     = THIS.Width - 20
160:             .WordWrap  = .T.
161:             .Visible   = .T.
162:         ENDWITH
163: 
164:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
165:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
166:             .AutoSize    = .F.
167:             .BackStyle   = 0
168:             .Caption     = THIS.Caption
169:             .FontBold    = .T.

*-- Linhas 189 a 253:
189:     * botoes Processar/Encerrar + label de progresso + campo de prioridade
190:     * (equivalente estrutural a "Page1" dos forms CRUD).
191:     *--------------------------------------------------------------------------
192:     PROTECTED PROCEDURE ConfigurarPaginaLista()
193:         THIS.ConfigurarBotoes()
194:         THIS.ConfigurarLabelProgresso()
195:         THIS.ConfigurarCampoPrioridade()
196:     ENDPROC
197: 
198:     *--------------------------------------------------------------------------
199:     * AlternarPagina - Compatibilidade com contrato dos forms CRUD.
200:     * Form OPERACIONAL nao tem PageFrame, entao nao ha alternancia de paginas:
201:     * ao ser invocada, garante foco no campo de prioridade (unico input).
202:     *--------------------------------------------------------------------------
203:     PROCEDURE AlternarPagina(par_nPagina)
204:         IF TYPE("THIS.txt_4c_Prioridade") = "O" AND !THIS.this_lParametrizado
205:             THIS.txt_4c_Prioridade.SetFocus()
206:         ENDIF
207:     ENDPROC
208: 
209:     *--------------------------------------------------------------------------
210:     * ConfigurarBotoes - Botoes Processar e Encerrar sobrepostos ao cabecalho
211:     * Standalone com Picture: Themes=.T. + DisabledPicture obrigatorio
212:     *--------------------------------------------------------------------------
213:     PROTECTED PROCEDURE ConfigurarBotoes()
214:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
215:         WITH THIS.cmd_4c_Processar
216:             .Top             = 3
217:             .Left            = 430
218:             .Height          = 75
219:             .Width           = 75
220:             .Caption         = "Processar"
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .FontName        = "Comic Sans MS"
224:             .FontSize        = 8
225:             .ForeColor       = RGB(90, 90, 90)
226:             .BackColor       = RGB(255, 255, 255)
227:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
228:             .Themes          = .T.
229:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
230:             .ToolTipText     = "Processar"
231:             .TabIndex        = 2
232:             .Cancel          = .F.
233:             .Visible         = .T.
234:         ENDWITH
235: 
236:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
237:         WITH THIS.cmd_4c_Encerrar
238:             .Top             = 3
239:             *-- 505 eh o Left do SAIR no dump (termina em 505+75=580, a borda
240:             *-- direita do form, logo a direita do Processar em 430). Estava
241:             *-- como "5": o 5 eh o Left canonico de botao dentro do
242:             *-- cnt_4c_Botoes/cnt_4c_Saida de form CRUD, e aqui o botao eh
243:             *-- filho DIRETO do Form - com 5 ele ia para o canto superior
244:             *-- esquerdo, por cima da faixa do cabecalho, deixando o bloco da
245:             *-- direita vazio.
246:             .Left            = 505
247:             .Height          = 75
248:             .Width           = 75
249:             .Caption         = "Encerrar"
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .FontName        = "Comic Sans MS"
253:             .FontSize        = 8

*-- Linhas 262 a 424:
262:             .Visible         = .T.
263:         ENDWITH
264: 
265:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
266:         BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
267:     ENDPROC
268: 
269:     *--------------------------------------------------------------------------
270:     * ConfigurarLabelProgresso - Label1 do legado: status do processamento
271:     *--------------------------------------------------------------------------
272:     PROTECTED PROCEDURE ConfigurarLabelProgresso()
273:         THIS.AddObject("lbl_4c_Progresso", "Label")
274:         WITH THIS.lbl_4c_Progresso
275:             .AutoSize    = .F.
276:             .BackStyle   = 0
277:             .BackColor   = RGB(255, 255, 234)
278:             .BorderStyle = 0
279:             .Caption     = ""
280:             .FontBold    = .T.
281:             .FontName    = "Tahoma"
282:             .FontSize    = 8
283:             .ForeColor   = RGB(90, 90, 90)
284:             .Height      = 20
285:             .Left        = 136
286:             .Top         = 99
287:             .Width       = 309
288:             .TabIndex    = 4
289:             .Visible     = .T.
290:         ENDWITH
291:     ENDPROC
292: 
293:     *--------------------------------------------------------------------------
294:     * ConfigurarCampoPrioridade - Label2 + txt_4c_Prioridade (Get_Prioridade)
295:     * Modo parametrizado: TextBox ReadOnly (simula PROCEDURE When Return .F.)
296:     * BINDEVENT "Valid" nao funciona em TextBox - usar KeyPress
297:     *--------------------------------------------------------------------------
298:     PROTECTED PROCEDURE ConfigurarCampoPrioridade()
299:         THIS.AddObject("lbl_4c_LblPrioridade", "Label")
300:         WITH THIS.lbl_4c_LblPrioridade
301:             *-- O dump declara AutoSize = .T. (classe say), mas em Label criado
302:             *-- por AddObject o AutoSize eh NO-OP (a Width fica no default) e,
303:             *-- com WordWrap, ele chega a DESCARTAR a Height. A Width/Height do
304:             *-- dump JA SAO o auto-size calculado pelo Form Designer, logo
305:             *-- fixa-las com AutoSize = .F. eh reproducao fiel (regra #23).
306:             .AutoSize    = .F.
307:             .BackStyle   = 0
308:             .BorderStyle = 0
309:             .Caption     = "Prioridade (0/1) : "
310:             .FontBold    = .T.
311:             .FontName    = "Tahoma"
312:             .FontSize    = 8
313:             .ForeColor   = RGB(90, 90, 90)
314:             .Height      = 15
315:             .Left        = 134
316:             .Top         = 154
317:             .Width       = 102
318:             .TabIndex    = 5
319:             .Visible     = .T.
320:         ENDWITH
321: 
322:         THIS.AddObject("txt_4c_Prioridade", "TextBox")
323:         WITH THIS.txt_4c_Prioridade
324:             .FontBold  = .T.
325:             .FontName  = "Tahoma"
326:             .FontSize  = 8
327:             .Height    = 23
328:             .InputMask = "9"
329:             .Left      = 238
330:             .MaxLength = 1
331:             .TabIndex  = 1
332:             .Top       = 150
333:             .Width     = 17
334:             .Value     = THIS.this_nPrioridade
335:             .ReadOnly  = THIS.this_lParametrizado
336:             .Visible   = .T.
337:         ENDWITH
338: 
339:         *-- O legado valida no Valid de Get_Prioridade, ou seja ao SAIR do
340:         *-- campo - inclusive quando o usuario vai direto para o botao
341:         *-- Processar com o MOUSE, sem passar por ENTER/TAB. So "KeyPress"
342:         *-- nao cobre esse caminho: o campo exibia o valor digitado e
343:         *-- this_nPrioridade seguia com o valor antigo, entao o lote rodava
344:         *-- com uma prioridade diferente da que esta na tela, sem erro
345:         *-- nenhum. "LostFocus" eh o evento equivalente ao Valid (BINDEVENT
346:         *-- em "Valid" nao dispara de forma confiavel em TextBox).
347:         BINDEVENT(THIS.txt_4c_Prioridade, "LostFocus", THIS, "ValidarPrioridade")
348:         BINDEVENT(THIS.txt_4c_Prioridade, "KeyPress", THIS, "TxtPrioridadeKeyPress")
349:         *-- Zera o memo do aviso: enquanto o usuario nao mexe no campo, o
350:         *-- "Prioridade Invalida!!!" sai UMA vez (e nao uma por evento do par
351:         *-- KeyPress/LostFocus); digitando outro valor, volta a avisar.
352:         BINDEVENT(THIS.txt_4c_Prioridade, "InteractiveChange", THIS, "TxtPrioridadeInteractiveChange")
353:     ENDPROC
354: 
355:     *--------------------------------------------------------------------------
356:     * ConfigurarPaginaDados - Elementos visuais complementares do form plano
357:     * Form OPERACIONAL (sem Page2 CRUD). Migra Shape1 do legado: elemento
358:     * decorativo de fundo atras dos botoes Processar/Encerrar.
359:     *--------------------------------------------------------------------------
360:     PROTECTED PROCEDURE ConfigurarPaginaDados()
361:         THIS.AddObject("shp_4c_Shape1", "Shape")
362:         WITH THIS.shp_4c_Shape1
363:             .Top         = 7
364:             .Left        = 480
365:             .Height      = 29
366:             .Width       = 48
367:             .BackStyle   = 0
368:             .BorderStyle = 0
369:             .BorderColor = RGB(136, 189, 188)
370:             .Visible     = .T.
371:         ENDWITH
372:     ENDPROC
373: 
374:     *--------------------------------------------------------------------------
375:     * BtnProcessarClick - Loop principal de processamento da fila SigOpClP
376:     * Transcreve o OK.Click legado. Pontos em que a transcricao e explicita:
377:     *   - Commit/Rollback: o legado tem DOIS Commit() e SETE Rollback(); eles
378:     *     moram no BO (ProcessarItem/ExecutarExclusao/MarcarEmProcessamento) e
379:     *     o Rollback incondicional do fim de cada passada esta aqui embaixo.
380:     *   - lock otimista: THIS.this_oBusinessObject.MarcarEmProcessamento(), que
381:     *     devolve o resultado NUMERICO porque o legado distingue -3 (queda de
382:     *     conexao -> Exit do Scan) de qualquer outra falha (-> Loop).
383:     *--------------------------------------------------------------------------
384:     PROCEDURE BtnProcessarClick()
385:         LOCAL loc_lOk, loc_nMov, loc_lErroCnx, loc_lProcessando
386:         LOCAL loc_nResult, loc_nTotal, loc_nProcessado
387:         LOCAL loc_nKey, loc_nError, loc_cErro
388:         LOCAL loc_lSemRecalculo, loc_cMsgFalha
389: 
390:         *-- O txt_4c_Prioridade eh FONTE UNICA enquanto esta visivel na tela:
391:         *-- revalidar aqui garante que o valor exibido eh o que vai para o
392:         *-- BuscarFila, mesmo que o usuario tenha ido do campo direto ao botao
393:         *-- com o mouse. Sem isso o lote rodava com a prioridade antiga.
394:         *-- RETURN seguro: este metodo nao tem TRY/CATCH (regra #1).
395:         IF !THIS.ValidarPrioridade()
396:             RETURN
397:         ENDIF
398: 
399:         THIS.cmd_4c_Processar.Enabled = .F.
400:         THIS.this_lParar = .F.
401:         SET CURSOR OFF
402: 
403:         *-- Keyboard {LEFTARROW} do legado: injeta uma tecla inocua para que o
404:         *-- INKEY() da primeira passada encontre o buffer num estado conhecido,
405:         *-- em vez de consumir alguma tecla sobrada do gesto do usuario
406:         *-- (o ENTER/TAB vindo do campo Prioridade) e trata-la como pedido de
407:         *-- parada.
408:         KEYBOARD "{LEFTARROW}"
409: 
410:         loc_nMov          = 1
411:         loc_lErroCnx      = .F.
412:         loc_lProcessando  = .T.
413:         loc_lSemRecalculo = .F.
414:         loc_cMsgFalha     = ""
415: 
416:         DO WHILE loc_lProcessando AND !THIS.this_lParar
417: 
418:             THIS.cmd_4c_Encerrar.Enabled = .F.
419: 
420:             THIS.lbl_4c_Progresso.Caption = "Aguardando Produtos Para Processar" + ;
421:                                              REPLICATE(".", loc_nMov)
422:             loc_nMov = IIF(loc_nMov < 5, loc_nMov + 1, 1)
423: 
424:             loc_lOk = THIS.this_oBusinessObject.BuscarFila(THIS.this_nPrioridade)

*-- Linhas 557 a 901:
557:     * PUBLIC: chamado por BtnProcessarClick dentro da propria classe, mas
558:     * tambem util a um chamador programatico que queira reaproveitar o canal.
559:     *--------------------------------------------------------------------------
560:     PROCEDURE ReportarFalhaProcessamento(par_cMensagem, par_lAbortou)
561:         LOCAL loc_cTitulo, loc_cPrefixo
562: 
563:         IF EMPTY(par_cMensagem)
564:             RETURN
565:         ENDIF
566: 
567:         IF THIS.this_lParametrizado
568:             loc_cPrefixo = IIF(par_lAbortou, "ABORTADO: ", "AVISO: ")
569:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
570:                 THIS.this_oBusinessObject.GravarLog(loc_cPrefixo + par_cMensagem)
571:             ENDIF
572:         ELSE
573:             loc_cTitulo = "Rec" + CHR(225) + "lculo de Saldos"
574:             IF par_lAbortou
575:                 MsgErro(par_cMensagem, loc_cTitulo)
576:             ELSE
577:                 MsgAviso(par_cMensagem, loc_cTitulo)
578:             ENDIF
579:         ENDIF
580:     ENDPROC
581: 
582:     *--------------------------------------------------------------------------
583:     * BtnEncerrarClick - Fecha form ou sinaliza parada do loop
584:     * Se Processar Enabled = nao estamos no loop -> Release imediato
585:     * Se Processar Disabled = estamos no loop    -> apenas seta flag; loop sai e Release
586:     *--------------------------------------------------------------------------
587:     PROCEDURE BtnEncerrarClick()
588:         THIS.this_lParar = .T.
589:         IF THIS.cmd_4c_Processar.Enabled
590:             THIS.Release()
591:         ENDIF
592:     ENDPROC
593: 
594:     *--------------------------------------------------------------------------
595:     * TxtPrioridadeKeyPress - Valida prioridade ao ENTER(13) ou TAB(9)
596:     *--------------------------------------------------------------------------
597:     PROCEDURE TxtPrioridadeKeyPress(par_nKeyCode, par_nShiftAltCtrl)
598:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
599:             RETURN
600:         ENDIF
601:         THIS.ValidarPrioridade()
602:     ENDPROC
603: 
604:     *--------------------------------------------------------------------------
605:     * TxtPrioridadeInteractiveChange - Libera o memo do aviso de invalido
606:     * Qualquer digitacao no campo faz a proxima saida avisar de novo, mesmo que
607:     * o valor digitado seja o MESMO que acabou de ser recusado.
608:     * PUBLIC: BINDEVENT so funciona com metodo PUBLIC (regra #3).
609:     *--------------------------------------------------------------------------
610:     PROCEDURE TxtPrioridadeInteractiveChange()
611:         THIS.this_nPrioridadeAvisada = -1
612:     ENDPROC
613: 
614:     *--------------------------------------------------------------------------
615:     * ValidarPrioridade - Funil UNICO de validacao do campo Prioridade
616:     * Equivale ao "PROCEDURE Valid" de Get_Prioridade no legado:
617:     *     If Not InList(This.Value,0,1)
618:     *         MessageBox('Prioridade Invalida!!!',0+64,'')
619:     *         Return .f.
620:     *     EndIf
621:     *     ThisForm.Prioridade = This.Value
622:     * Ligado a "LostFocus" (saida do campo, inclusive por clique de mouse) e
623:     * chamado por TxtPrioridadeKeyPress (ENTER/TAB) e por BtnProcessarClick.
624:     * PUBLIC: BINDEVENT so funciona com metodo PUBLIC (regra #3).
625:     * Wrapper fino + corpo em ValidarPrioridadeExec: o corpo tem RETURN
626:     * antecipado, e limpar a flag "no fim do corpo" a deixaria presa em .T.,
627:     * matando a validacao pelo resto da vida do form (regra #47).
628:     *--------------------------------------------------------------------------
629:     FUNCTION ValidarPrioridade()
630:         LOCAL loc_lValido
631: 
632:         IF THIS.this_lEmValidacao
633:             RETURN .T.
634:         ENDIF
635: 
636:         THIS.this_lEmValidacao = .T.
637:         loc_lValido = THIS.ValidarPrioridadeExec()
638:         THIS.this_lEmValidacao = .F.
639: 
640:         RETURN loc_lValido
641:     ENDFUNC
642: 
643:     *--------------------------------------------------------------------------
644:     * ValidarPrioridadeExec - Corpo da validacao (ver ValidarPrioridade)
645:     *--------------------------------------------------------------------------
646:     FUNCTION ValidarPrioridadeExec()
647:         LOCAL loc_nValor, loc_lValido
648: 
649:         loc_lValido = .T.
650: 
651:         *-- Modo parametrizado: o legado trava o campo com
652:         *-- "PROCEDURE When / Return (Not ThisForm.Parametrizado)", entao o
653:         *-- Valid NUNCA roda em lote - e o valor vem do chamador
654:         *-- (Fortyus.Exe), que nao passa pela tela. Validar aqui abortaria o
655:         *-- processamento automatico com um modal que ninguem veria.
656:         IF THIS.this_lParametrizado OR VARTYPE(THIS.txt_4c_Prioridade) != "O"
657:             RETURN .T.
658:         ENDIF
659: 
660:         loc_nValor = THIS.txt_4c_Prioridade.Value
661: 
662:         *-- O TextBox nasce com .Value numerico (InputMask = "9"), mas tolerar
663:         *-- Caractere eh barato e evita "Operator/operand type mismatch" caso
664:         *-- algum caminho atribua string ao campo.
665:         IF VARTYPE(loc_nValor) = "C"
666:             loc_nValor = VAL(ALLTRIM(loc_nValor))
667:         ENDIF
668: 
669:         IF !INLIST(loc_nValor, 0, 1)
670:             *-- Um aviso por TENTATIVA do usuario, nao um por evento: o par
671:             *-- KeyPress+LostFocus (TAB/ENTER) e o par LostFocus+Click (mouse
672:             *-- indo direto ao Processar) chegam aqui DUAS vezes com o MESMO
673:             *-- valor, e a guarda this_lEmValidacao nao cobre isso porque ja
674:             *-- foi liberada quando o segundo evento chega. No legado o Valid
675:             *-- devolvendo .F. prende o foco e descarta o clique, logo o
676:             *-- MessageBox sai UMA vez por tentativa.
677:             IF loc_nValor != THIS.this_nPrioridadeAvisada
678:                 MsgAviso("Prioridade Inv" + CHR(225) + "lida!!!", ;
679:                          "Valida" + CHR(231) + CHR(227) + "o")
680:             ENDIF
681:             THIS.this_nPrioridadeAvisada = loc_nValor
682:             *-- O legado devolve .F. do Valid, o que PRENDE o foco no campo e
683:             *-- PRESERVA o que foi digitado - nao apagar nem restaurar o valor
684:             *-- anterior, senao o usuario perde o que escreveu (regra #50).
685:             THIS.txt_4c_Prioridade.SetFocus()
686:             loc_lValido = .F.
687:         ELSE
688:             *-- "ThisForm.Prioridade = This.Value" do legado, propagado tambem
689:             *-- ao BO: BuscarFila() le this_nPrioridade do BO, e o form passa
690:             *-- THIS.this_nPrioridade - as duas copias tem de andar juntas.
691:             THIS.this_nPrioridade = loc_nValor
692:             *-- Valor aceito: libera o memo, para que um invalido digitado
693:             *-- depois volte a avisar.
694:             THIS.this_nPrioridadeAvisada = -1
695:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
696:                 THIS.this_oBusinessObject.this_nPrioridade = loc_nValor
697:             ENDIF
698:         ENDIF
699: 
700:         RETURN loc_lValido
701:     ENDFUNC
702: 
703:     *--------------------------------------------------------------------------
704:     * Destroy - Libera Business Object e encerra SET CURSOR normal
705:     *--------------------------------------------------------------------------
706:     PROCEDURE Destroy()
707:         SET CURSOR ON
708:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
709:             THIS.this_oBusinessObject = .NULL.
710:         ENDIF
711:         DODEFAULT()
712:     ENDPROC
713: 
714:     *==========================================================================
715:     * Eventos CRUD - contrato do pipeline (form OPERACIONAL sem CRUD)
716:     *
717:     * SIGPRRSA (legado) e um form de PROCESSAMENTO em lote: o dump declara
718:     * APENAS cntSombra/lblSombra/lblTitulo/Shape1/SAIR/OK/Label1/Label2/
719:     * Get_Prioridade - sem grid, sem lista de registros e sem barra CRUD
720:     * (nao herda de frmcadastro, nao tem Grupo_Op nem pcEscolha). A unica
721:     * acao operacional e Processar (loop sobre SigOpClP), em BtnProcessarClick.
722:     *
723:     * Os quatro metodos abaixo existem SO para manter o contrato de nomes
724:     * esperado pelo OrquestradorMigracao (Fase 7). Sao no-op SILENCIOSO de
725:     * proposito, pelas mesmas razoes dos metodos de contrato da Fase 8 logo
726:     * adiante - e NAO exibem MsgAviso:
727:     *
728:     *   1. Nenhum cmd_4c_Incluir/Alterar/Visualizar/Excluir e criado por
729:     *      AddObject neste form (os 9 AddObject reproduzem exatamente os
730:     *      objetos do SCX legado - PILAR 1), entao nao existe caminho de UI
731:     *      que alcance estes metodos: a mensagem seria codigo morto.
732:     *   2. Em modo de teste MsgAviso nao abre dialogo - ela GRAVA a mensagem
733:     *      em gc_4c_ArquivoErroTeste (messages.prg -> EscreverErroParaArquivo)
734:     *      e ecoa "ERRO_TESTE:" no console. Avisar aqui contaminaria o
735:     *      arquivo de ERRO do harness com um nao-erro.
736:     *   3. A regra de completude do pipeline proibe Btn*Click que so exibe
737:     *      MsgAviso (stub disfarcado).
738:     *
739:     * Retornam .T. (sucesso/no-op) para que qualquer chamador programatico
740:     * siga o fluxo normal, igual a BtnBuscarClick/BtnSalvarClick/
741:     * BtnCancelarClick.
742:     *==========================================================================
743: 
744:     *--------------------------------------------------------------------------
745:     * BtnIncluirClick - No-op silencioso (legado sem inclusao de registros)
746:     *--------------------------------------------------------------------------
747:     PROCEDURE BtnIncluirClick()
748:         RETURN .T.
749:     ENDPROC
750: 
751:     *--------------------------------------------------------------------------
752:     * BtnAlterarClick - No-op silencioso (legado sem alteracao de registros)
753:     *--------------------------------------------------------------------------
754:     PROCEDURE BtnAlterarClick()
755:         RETURN .T.
756:     ENDPROC
757: 
758:     *--------------------------------------------------------------------------
759:     * BtnVisualizarClick - No-op silencioso (legado sem visualizacao de registros)
760:     *--------------------------------------------------------------------------
761:     PROCEDURE BtnVisualizarClick()
762:         RETURN .T.
763:     ENDPROC
764: 
765:     *--------------------------------------------------------------------------
766:     * BtnExcluirClick - No-op silencioso (legado sem exclusao de registros)
767:     *--------------------------------------------------------------------------
768:     PROCEDURE BtnExcluirClick()
769:         RETURN .T.
770:     ENDPROC
771: 
772:     *==========================================================================
773:     * Metodos de contrato Fase 8 - form OPERACIONAL sem CRUD
774:     * Os metodos abaixo existem para satisfazer o contrato do OrquestradorMigracao.
775:     * SIGPRRSA e um form de processamento em lote; nao tem lista, dados CRUD
776:     * nem modos Incluir/Alterar/Visualizar. Apenas Processar e Encerrar.
777:     *==========================================================================
778: 
779:     *--------------------------------------------------------------------------
780:     * BtnBuscarClick - Sem-operacao (form OPERACIONAL sem lista de registros)
781:     *--------------------------------------------------------------------------
782:     PROCEDURE BtnBuscarClick()
783:         RETURN .T.
784:     ENDPROC
785: 
786:     *--------------------------------------------------------------------------
787:     * BtnSalvarClick - Sem-operacao (form OPERACIONAL sem modo de edicao CRUD)
788:     *--------------------------------------------------------------------------
789:     PROCEDURE BtnSalvarClick()
790:         RETURN .T.
791:     ENDPROC
792: 
793:     *--------------------------------------------------------------------------
794:     * BtnCancelarClick - Sem-operacao (form OPERACIONAL sem modo de edicao)
795:     *--------------------------------------------------------------------------
796:     PROCEDURE BtnCancelarClick()
797:         RETURN .T.
798:     ENDPROC
799: 
800:     *--------------------------------------------------------------------------
801:     * CarregarLista - Sem-operacao (form OPERACIONAL sem grade de registros)
802:     *--------------------------------------------------------------------------
803:     PROCEDURE CarregarLista()
804:         RETURN .T.
805:     ENDPROC
806: 
807:     *--------------------------------------------------------------------------
808:     * AjustarBotoesPorModo - Sem-operacao (form OPERACIONAL sem modos CRUD)
809:     *--------------------------------------------------------------------------
810:     PROCEDURE AjustarBotoesPorModo()
811:         RETURN
812:     ENDPROC
813: 
814:     *--------------------------------------------------------------------------
815:     * FormParaBO - Sincroniza prioridade do campo visual para o BO
816:     * PROTECTED EXPLICITO: FormBase.prg declara "PROTECTED PROCEDURE FormParaBO"
817:     * e o VFP9 NAO deixa a subclasse ALARGAR o escopo herdado - omitir o
818:     * modificador aqui nao tornaria o metodo publico, so esconderia que ele
819:     * continua protegido (medido: oForm.FormParaBO() de fora da classe estoura
820:     * "Property FORMPARABO is not found", enquanto PEMSTATUS(...,5) devolve .T.
821:     * porque so verifica EXISTENCIA). Chamar sempre por THIS., de dentro.
822:     *--------------------------------------------------------------------------
823:     PROTECTED PROCEDURE FormParaBO()
824:         LOCAL loc_nValor
825: 
826:         IF VARTYPE(THIS.txt_4c_Prioridade) = "O" AND ;
827:            VARTYPE(THIS.this_oBusinessObject) = "O"
828:             loc_nValor = THIS.txt_4c_Prioridade.Value
829: 
830:             *-- Tolerar Caractere: o campo nasce numerico (InputMask = "9"),
831:             *-- mas se algum caminho atribuir string, comparar com INLIST
832:             *-- numerico estouraria "Operator/operand type mismatch".
833:             IF VARTYPE(loc_nValor) = "C"
834:                 loc_nValor = VAL(ALLTRIM(loc_nValor))
835:             ENDIF
836: 
837:             *-- No legado, "ThisForm.Prioridade = This.Value" mora DENTRO do
838:             *-- Valid e so roda DEPOIS do "If Not InList(This.Value,0,1)" -
839:             *-- isto e, valor fora de 0/1 NUNCA chega a prioridade efetiva.
840:             *-- Copiar o .Value cru aqui abria um segundo caminho, sem a
841:             *-- checagem, pelo qual a coluna Priors (numeric(1,0)) receberia
842:             *-- um filtro que nao casa linha nenhuma - o lote rodaria "sem
843:             *-- erro" e sem processar nada.
844:             IF INLIST(loc_nValor, 0, 1)
845:                 THIS.this_nPrioridade = loc_nValor
846:                 THIS.this_oBusinessObject.this_nPrioridade = THIS.this_nPrioridade
847:             ENDIF
848:         ENDIF
849:     ENDPROC
850: 
851:     *--------------------------------------------------------------------------
852:     * BOParaForm - Sincroniza prioridade do BO para o campo visual
853:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
854:     * heranca de FormBase e nao pode ser alargado aqui.
855:     *--------------------------------------------------------------------------
856:     PROTECTED PROCEDURE BOParaForm()
857:         IF VARTYPE(THIS.txt_4c_Prioridade) = "O" AND ;
858:            VARTYPE(THIS.this_oBusinessObject) = "O"
859:             THIS.this_nPrioridade = THIS.this_oBusinessObject.this_nPrioridade
860:             THIS.txt_4c_Prioridade.Value = THIS.this_nPrioridade
861:         ENDIF
862:     ENDPROC
863: 
864:     *--------------------------------------------------------------------------
865:     * HabilitarCampos - Gerencia estado editavel do campo de prioridade
866:     * Modo parametrizado: campo sempre ReadOnly (ignora par_lHabilitar)
867:     *--------------------------------------------------------------------------
868:     PROCEDURE HabilitarCampos(par_lHabilitar)
869:         IF VARTYPE(THIS.txt_4c_Prioridade) = "O"
870:             THIS.txt_4c_Prioridade.ReadOnly = THIS.this_lParametrizado OR !par_lHabilitar
871:         ENDIF
872:         IF VARTYPE(THIS.cmd_4c_Processar) = "O"
873:             *-- NAO condicionar ao this_lParametrizado: o modo parametrizado eh
874:             *-- justamente quando o Activate() CLICA o Processar sozinho (o
875:             *-- legado faz "If ThisForm.Parametrizado / ThisForm.OK.Click()").
876:             *-- Desabilitar o botao por modo deixava o lote sem o unico
877:             *-- caminho de execucao, e nada o reabilitava (regra #40: quem
878:             *-- desabilita tem de reabilitar no funil de volta). No legado o
879:             *-- OK so fica Enabled = .F. DURANTE o loop ("This.Enabled = .F."
880:             *-- no inicio do Click), e volta a .T. no fim dele - que eh
881:             *-- exatamente o que BtnProcessarClick ja faz.
882:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
883:         ENDIF
884:     ENDPROC
885: 
886:     *--------------------------------------------------------------------------
887:     * LimparCampos - Restaura prioridade ao valor padrao (0)
888:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO: o escopo vem da
889:     * heranca de FormBase e nao pode ser alargado aqui.
890:     *--------------------------------------------------------------------------
891:     PROTECTED PROCEDURE LimparCampos()
892:         THIS.this_nPrioridade = 0
893:         IF VARTYPE(THIS.txt_4c_Prioridade) = "O"
894:             THIS.txt_4c_Prioridade.Value = 0
895:         ENDIF
896:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
897:             THIS.this_oBusinessObject.this_nPrioridade = 0
898:         ENDIF
899:     ENDPROC
900: 
901: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrRsaBO.prg):
*==============================================================================
* Classe  : SigPrRsaBO
* Herda de: BusinessBase
* Descricao: BO para recalculo de saldos de produto (SIGPRRSA)
*            Form OPERACIONAL - processa fila SigOpClP chamando fRecalculaP
*            para cada produto na fila, fazendo commit/rollback por item.
*            Suporta modo parametrizado (batch) e modo interativo (loop continuo).
*
* NOTA DE ESCOPO - fRecalculaP
*   O OK.Click legado chama fRecalculaP duas vezes por item (recalculo do
*   saldo do produto e consolidacao). A funcao NAO existe no acervo - nem
*   como .prg, nem no Framework, nem no p-code dos VCX. Pela regra CLAUDE.md
*   #27 (3a linha da tabela: funcao que devolve VALOR DE CALCULO fica AUSENTE
*   e visivel, nunca vira stub) as chamadas foram mantidas como estao: um
*   stub devolvendo .T. faria a tela anunciar sucesso e DRENAR A FILA sem
*   recalcular saldo nenhum, e um stub devolvendo 0 gravaria saldo errado em
*   silencio. Mesmo tratamento ja adotado em SigOpBcbBO, SigPrGlpBO,
*   SigPrGlxBO, SigPrCccBO e dmoBO.
*
*   Diferenca em relacao a esses outros BOs: aqui o retorno GATEIA o loop (la
*   ele eh descartado). Como a chamada mora em TRY/CATCH, a ausencia virava um
*   MsgErro MODAL POR ITEM da fila - e no modo parametrizado (Fortyus.Exe, sem
*   ninguem na frente da tela) o lote TRAVAVA no primeiro dialogo. Por isso
*   ProcessarItem() mede a disponibilidade UMA vez (classificando o erro 1 do
*   VFP9) e o form aborta a passada com UMA mensagem. Ver this_lRecalculoDisponivel.
*
* NOTA DE ESCOPO - SigPrSlP (CrSigPrSlP)
*   Ver comentario em ExecutarExclusao: o Scatter/Zap/Append/Gather que o
*   legado faz sobre esse cursor nao chega ao banco (a linha Update esta
*   COMENTADA no proprio fonte legado e o buffer eh descartado pelo Rollback
*   seguinte), por isso nao foi migrado INSERT/UPDATE em SigPrSlP.
*==============================================================================
DEFINE CLASS SigPrRsaBO AS BusinessBase

    *-- Parametros de execucao
    this_nPrioridade    = 0     && Filtro de prioridade: 0 ou 1
    this_lParametrizado = .F.   && .T. = chamado de batch (Fortyus.Exe), quit apos processar

    *-- Estado do processamento (lido pelo Form para atualizar Label1)
    this_cStatusMsg     = ""    && Mensagem de progresso para o form exibir
    this_nTotalFila     = 0     && Total de registros na fila antes de processar
    this_nProcessados   = 0     && Quantidade processada na iteracao corrente

    *-- Campos do registro corrente de SigOpClP
    this_cCidChaves = ""        && cidchaves char(20) - PK da fila
    this_nPriors    = 0         && priors numeric(1,0) - prioridade (0 ou 1)
    this_cEmps      = ""        && emps char(3) - empresa
    this_cGrupos    = ""        && grupos char(10) - grupo de estoque
    this_cEstos     = ""        && estos char(10) - estoque/localizacao
    this_cCpros     = ""        && cpros char(14) - codigo do produto
    this_dDatas     = {}        && datas datetime - data do movimento
    this_cCodCors   = ""        && codcors char(4) - codigo da cor
    this_cCodTams   = ""        && codtams char(4) - codigo do tamanho
    this_cUsuars    = ""        && usuars char(20) - usuario processador
    this_nTipoestos = 0         && tipoestos numeric(1,0) - tipo de estoque
    this_cEmpestpros = ""       && empestpros char(37) - composite emps+estos+cpros

    *-- Controle de TRANSACAO MANUAL (regra: o migrador descarta o Commit()
    *-- do legado e a gravacao fica presa na transacao aberta). Medido neste
    *-- ambiente: SQLGETPROP(h, "Transactions") ja vale 2 (MANUAL) numa
    *-- conexao virgem, e nem BusinessBase nem DataAccess dao SQLCOMMIT. O
    *-- OK.Click legado tem DOIS Commit() e SETE Rollback() - sem eles o
    *-- DELETE FROM SigOpClP nunca eh efetivado, a fila NAO drena e o lote
    *-- reprocessa os MESMOS itens a cada passada do DO WHILE, para sempre.
    this_lTransacaoManual = .F.

    *-- fRecalculaP (recalculo de saldo/posicao de estoque) NAO existe no
    *-- acervo - nem como .prg, nem no Framework, nem no p-code dos VCX. Pela
    *-- regra #27 (funcao que devolve VALOR DE CALCULO fica AUSENTE e
    *-- visivel, nunca vira stub) NAO se cria stub: devolver .T. faria a tela
    *-- anunciar sucesso e drenar a fila sem recalcular saldo nenhum, e
    *-- devolver 0 gravaria saldo errado em silencio. Mesmo tratamento ja
    *-- adotado em SigOpBcbBO, SigPrGlpBO, SigPrGlxBO e dmoBO.
    *--
    *-- A diferenca aqui eh que o retorno GATEIA o loop (nos outros BOs ele
    *-- eh descartado): a chamada mora dentro de TRY/CATCH, entao a ausencia
    *-- virava UM MsgErro MODAL POR ITEM da fila - e em modo parametrizado
    *-- (Fortyus.Exe, sem ninguem na frente da tela) o lote TRAVAVA no
    *-- primeiro dialogo. Por isso a disponibilidade eh medida UMA vez, no
    *-- primeiro item, classificando o erro 1 (File does not exist) do VFP9:
    *-- medir eh melhor que adivinhar por FILE(), porque a funcao tambem
    *-- poderia vir de um SET PROCEDURE e ai FILE() daria falso negativo.
    this_lRecalculoDisponivel = .T.

    *--------------------------------------------------------------------------
    * Init - e carrega o cursor global de parametros do sistema (CrSigCdPam),
    * que o Init do form legado montava com
    *   Podatamgr.Cursorquery('SigCdPam','CrSigCdPam',.f.,.f.,
    *                         [GrupoRecs,GrupoPags,ContaRecs,ContaPags])
    * O sistema novo nao pre-carrega os cursores globais do Fortyus no
    * startup, entao cada BO responsavel por um form que depende deles tem de
    * popula-lo aqui, depois do DODEFAULT().
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        DODEFAULT()
        THIS.DetectarTransacaoManual()
        THIS.CarregarParametrosSistema()
    ENDPROC

    *--------------------------------------------------------------------------
    * DetectarTransacaoManual - mede UMA vez se a conexao esta em transacao
    * manual (SQLGETPROP "Transactions" = 2) ou em auto-commit (1).
    *
    * Medir em vez de presumir deixa o par Commit/Rollback INERTE quando a
    * conexao estiver em auto-commit, que eh a forma segura ja usada no
    * projeto (SIGPRCNBBO.prg:471) - commitar em auto-commit nao eh erro, mas
    * o IF torna o codigo correto nos dois ambientes sem precisar saber qual
    * deles esta ativo.
    *
    * SQLGETPROP com handle invalido DISPARA EXCECAO (nao devolve -1), e o
    * harness de teste define gnConnHandle = 0 de proposito; por isso a
    * guarda de tipo/valor ANTES e o TRY em volta. Sem conexao o resultado
    * eh .F. (par inerte), nunca uma falha de instanciacao do BO.
    *--------------------------------------------------------------------------
    PROCEDURE DetectarTransacaoManual()
        LOCAL loc_oErro
        THIS.this_lTransacaoManual = .F.
        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                THIS.this_lTransacaoManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_lTransacaoManual = .F.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfirmarTransacao - SQLCOMMIT, equivalente ao poDataMgr.Commit() do
    * legado. O OK.Click chama Commit() em DOIS pontos, cada um com caminho
    * de falha proprio (If Not llOk / Rollback / Loop) - ou seja o commit eh
    * um PASSO da regra, nao detalhe de infra, e devolver o sucesso dele eh
    * necessario para reproduzir esses desvios.
    *
    * Inerte quando a conexao esta em auto-commit: devolve .T. sem chamar
    * nada, porque nesse modo o statement ja foi efetivado.
    *--------------------------------------------------------------------------
    FUNCTION ConfirmarTransacao()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.
        IF THIS.this_lTransacaoManual
            TRY
                loc_lSucesso = (SQLCOMMIT(gnConnHandle) > 0)
                IF !loc_lSucesso
                    THIS.this_cMensagemErro = "Falha ao confirmar a transa" + CHR(231) + CHR(227) + ;
                        "o no banco de dados."
                ENDIF
            CATCH TO loc_oErro
                THIS.this_cMensagemErro = loc_oErro.Message
                loc_lSucesso = .F.
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * DesfazerTransacao - SQLROLLBACK, equivalente ao poDataMgr.Rollback() do
    * legado (SETE chamadas no OK.Click: uma por caminho de falha, mais a
    * incondicional depois do EndScan, que descarta o que sobrou aberto na
    * passada). Sem retorno util: o legado tambem descarta o dele.
    *--------------------------------------------------------------------------
    PROCEDURE DesfazerTransacao()
        LOCAL loc_oErro
        IF THIS.this_lTransacaoManual
            TRY
                SQLROLLBACK(gnConnHandle)
            CATCH TO loc_oErro
                *-- Rollback que falha nao tem desdobramento: a transacao ja
                *-- esta perdida e o item sera reprocessado na proxima passada
                *-- (a fila so drena apos o DELETE confirmado). Registrar a
                *-- mensagem permite que o chamador a exiba se quiser, sem
                *-- abrir dialogo aqui - este metodo roda DENTRO do loop e um
                *-- modal por item travaria o modo parametrizado.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarEmProcessamento - lock otimista do item corrente, transcrito de
    *   lcUpdate = [ Update SigOpClP Set Usuars = Usuars Where CidChaves = '..']
    *   lnErro1  = ThisForm.poDataMgr.SqlExecute(lcUpdate , '', 1 )
    * no OK.Click legado. Devolve o RESULTADO NUMERICO do SQLEXEC porque o
    * legado distingue dois desvios a partir dele: -3 (queda de conexao) faz
    * Exit do Scan, qualquer outra falha faz apenas Loop para o item seguinte.
    * Devolver logico apagaria essa diferenca.
    *
    * PUBLIC de proposito: eh o form que percorre o cursor da fila e precisa
    * chamar isto item a item. ExecutarAtualizacao() roda o MESMO UPDATE mas
    * eh PROTECTED (contrato de BusinessBase) e nao pode ser chamado de fora -
    * chamar la de fora estouraria "Property EXECUTARATUALIZACAO is not
    * found" (regra #51). Por isso o SQL mora aqui, uma vez, em vez de ficar
    * duplicado no .prg do form.
    *--------------------------------------------------------------------------
    FUNCTION MarcarEmProcessamento()
        LOCAL loc_nResult, loc_cSQL, loc_oErro
        loc_nResult = 0
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "UPDATE SigOpClP SET usuars = usuars " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult <= 0
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" do legado
                    THIS.DesfazerTransacao()
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao marcar item como processando."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
            loc_nResult = 0
        ENDTRY
        RETURN loc_nResult
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametrosSistema - Popula o cursor global CrSigCdPam com as
    * quatro colunas que o legado pedia no Cursorquery do Init. SigCdPam eh
    * tabela de UMA linha (parametros gerais) e NAO tem coluna de empresa -
    * nenhum filtro WHERE.
    *
    * Nunca derruba a instanciacao do BO: em modo teste/validacao de UI o
    * harness define gnConnHandle = 0 de proposito, e qualquer falha de
    * consulta cai no cursor vazio criado localmente (APPEND BLANK), de forma
    * que quem le CrSigCdPam encontre a estrutura esperada em vez de alias
    * inexistente.
    *--------------------------------------------------------------------------
    FUNCTION CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("CrSigCdPam")
                USE IN CrSigCdPam
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                loc_cSQL = "SELECT gruporecs, grupopags, contarecs, contapags" + ;
                    " FROM SigCdPam"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamTmp")

                IF loc_nResultado > 0 AND USED("cursor_4c_PamTmp")
                    SELECT * FROM cursor_4c_PamTmp INTO CURSOR CrSigCdPam READWRITE
                    USE IN cursor_4c_PamTmp
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

            IF !loc_lSucesso
                IF USED("cursor_4c_PamTmp")
                    USE IN cursor_4c_PamTmp
                ENDIF
                CREATE CURSOR CrSigCdPam ( ;
                    GrupoRecs C(10), GrupoPags C(10), ;
                    ContaRecs C(10), ContaPags C(10))
                APPEND BLANK
            ENDIF

            IF USED("CrSigCdPam") AND RECCOUNT("CrSigCdPam") > 0
                SELECT CrSigCdPam
                GO TOP
            ENDIF

        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            IF !USED("CrSigCdPam")
                CREATE CURSOR CrSigCdPam ( ;
                    GrupoRecs C(10), GrupoPags C(10), ;
                    ContaRecs C(10), ContaPags C(10))
                APPEND BLANK
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - identificador para auditoria operacional
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN "RECALCPRSLP"
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - popula propriedades do BO a partir do cursor CrSigOpClP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = NVL(cidchaves, "")
                THIS.this_nPriors    = NVL(priors, 0)
                THIS.this_cEmps      = NVL(emps, "")
                THIS.this_cGrupos    = NVL(grupos, "")
                THIS.this_cEstos     = NVL(estos, "")
                THIS.this_cCpros     = NVL(cpros, "")
                THIS.this_dDatas     = IIF(VARTYPE(datas) = "T", datas, {})
                THIS.this_cCodCors   = NVL(codcors, "")
                THIS.this_cCodTams   = NVL(codtams, "")
                THIS.this_cUsuars    = NVL(usuars, "")
                IF TYPE("tipoestos") != "U"
                    THIS.this_nTipoestos = NVL(tipoestos, 0)
                ENDIF
                IF TYPE("empestpros") != "U"
                    THIS.this_cEmpestpros = NVL(empestpros, "")
                ELSE
                    THIS.this_cEmpestpros = ALLTRIM(THIS.this_cEmps) + ;
                                            ALLTRIM(THIS.this_cEstos) + ;
                                            ALLTRIM(THIS.this_cCpros)
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarFila - SELECT de SigOpClP filtrado por prioridade em CrSigOpClP
    *--------------------------------------------------------------------------
    FUNCTION BuscarFila(par_nPrioridade)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigOpClP")
                USE IN CrSigOpClP
            ENDIF
            loc_cSQL = "SELECT cidchaves, codcors, codtams, cpros, datas, emps, " + ;
                       "estos, grupos, tipoestos, usuars, priors " + ;
                       "FROM SigOpClP " + ;
                       "WHERE priors = " + FormatarNumeroSQL(par_nPrioridade, 0) + " " + ;
                       "ORDER BY emps, grupos, estos"
            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL, "CrSigOpClP") > 0)
            IF loc_lSucesso
                THIS.this_nTotalFila = RECCOUNT("CrSigOpClP")
            ELSE
                THIS.this_nTotalFila = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigOpClP (enfileira item para recalculo de saldo)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = SYS(2015)
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                THIS.this_cUsuars = gc_4c_UsuarioLogado
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF
            loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                             PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                             PADR(ALLTRIM(THIS.this_cCpros), 14)
            THIS.this_cEmpestpros = loc_cEmpEstPro
            loc_cSQL = "INSERT INTO SigOpClP " + ;
                       "(cidchaves, codcors, codtams, cpros, datas, empestpros, " + ;
                       "emps, estos, grupos, tipoestos, usuars, priors) VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(loc_cEmpEstPro) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPriors, 0) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                *-- Commit explicito: BusinessBase nao da SQLCOMMIT e a conexao
                *-- nasce em transacao MANUAL neste ambiente, entao sem isto o
                *-- INSERT fica preso e some ao fim do processo.
                loc_lSucesso = THIS.ConfirmarTransacao()
                IF loc_lSucesso
                    THIS.RegistrarAuditoria("INSERT")
                ELSE
                    THIS.DesfazerTransacao()
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir item na fila de recalculo (SigOpClP)."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigOpClP com todos os campos do item corrente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEmpEstPro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cEmpEstPro = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                 PADR(ALLTRIM(THIS.this_cEstos), 10) + ;
                                 PADR(ALLTRIM(THIS.this_cCpros), 14)
                THIS.this_cEmpestpros = loc_cEmpEstPro
                loc_cSQL = "UPDATE SigOpClP SET " + ;
                           "codcors = " + EscaparSQL(ALLTRIM(THIS.this_cCodCors)) + ", " + ;
                           "codtams = " + EscaparSQL(ALLTRIM(THIS.this_cCodTams)) + ", " + ;
                           "cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ", " + ;
                           "datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                           "empestpros = " + EscaparSQL(loc_cEmpEstPro) + ", " + ;
                           "emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmps)) + ", " + ;
                           "estos = " + EscaparSQL(ALLTRIM(THIS.this_cEstos)) + ", " + ;
                           "grupos = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ", " + ;
                           "tipoestos = " + FormatarNumeroSQL(THIS.this_nTipoestos, 0) + ", " + ;
                           "usuars = " + EscaparSQL(ALLTRIM(THIS.this_cUsuars)) + ", " + ;
                           "priors = " + FormatarNumeroSQL(THIS.this_nPriors, 0) + " " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- Commit explicito (ver nota em Inserir)
                    loc_lSucesso = THIS.ConfirmarTransacao()
                    IF loc_lSucesso
                        THIS.RegistrarAuditoria("UPDATE")
                    ELSE
                        THIS.DesfazerTransacao()
                    ENDIF
                ELSE
                    IF loc_nResult = -3
                    THIS.this_cMensagemErro = "Conex" + CHR(227) + "o perdida com o banco de dados."
                ELSE
                    THIS.this_cMensagemErro = "Erro ao atualizar item da fila de recalculo (SigOpClP)."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarAtualizacao - UPDATE SigOpClP marcando item como sendo processado
    * Delega a MarcarEmProcessamento() para que o SQL do lock otimista e o
    * Rollback associado existam em UM lugar so: este metodo eh PROTECTED
    * (contrato de BusinessBase) e o form, que percorre a fila, precisa chamar
    * a versao PUBLIC. Duplicar o UPDATE nos dois deixava o par livre para
    * divergir - foi o que aconteceu antes, quando o form tinha a sua propria
    * copia inline, sem Rollback.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarAtualizacao()
        RETURN (THIS.MarcarEmProcessamento() > 0)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - remove o item da fila e CONFIRMA, transcrevendo:
    *
    *   lcDelete = [ Delete From SigOpClP Where CidChaves = '..' ]
    *   llOk = ( poDataMgr.SqlExecute(lcDelete, '', 1 ) > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = llOk And ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *
    * Este eh o Commit MAIS CRITICO do form: eh ele que efetiva a saida do
    * item da fila. Sem ele, com a conexao em transacao manual, o DELETE fica
    * preso, o SELECT da passada seguinte traz os MESMOS registros e o lote
    * reprocessa a fila inteira indefinidamente - sem erro na tela.
    *
    * NOTA DE ESCOPO - gravacao em SigPrSlP (CrSigPrSlP)
    *   Entre a checagem de movimento e o DELETE, o legado faz
    *     Select CrSigOpClP / Scatter Memvar
    *     Select CrSigPrSlP / Zap / Append Blank / Gather Memvar
    *   sobre o cursor que o Init declara com
    *     .AddCursor('SigPrSlP','CidChaves','CrSigPrSlP','')
    *   mas a linha que o persistiria esta COMENTADA no proprio fonte legado
    *     (*  llOk = Thisform.Podatamgr.Update('CrSigPrSlP'))
    *   e o que sobra no buffer eh descartado pelo Rollback() que vem depois
    *   do EndScan. Ou seja: esse bloco NAO grava em SigPrSlP - eh um vestigio
    *   de buffer local, de uma linha so, que ninguem le depois (as duas
    *   chamadas a fRecalculaP acontecem ANTES dele). Por isso NAO foi migrado
    *   um INSERT/UPDATE em SigPrSlP: inventar aqui uma gravacao que o legado
    *   nao faz violaria o PILAR 2 tanto quanto perder uma que ele faz.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cMensagemErro = "CidChaves n" + CHR(227) + "o informado."
            ELSE
                loc_cSQL = "DELETE FROM SigOpClP " + ;
                           "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    *-- "llOk = llOk And ( PodataMgr.Commit() > 0 )" do legado
                    loc_lSucesso = THIS.ConfirmarTransacao()
                ELSE
                    IF loc_nResult = -3
                        THIS.this_cMensagemErro = "Conex" + CHR(227) + ;
                            "o perdida com o banco de dados."
                    ELSE
                        THIS.this_cMensagemErro = "Erro ao remover item da fila de processamento."
                    ENDIF
                ENDIF

                IF !loc_lSucesso
                    *-- "If Not llOk / ThisForm.Podatamgr.Rollback()" - vale
                    *-- para a falha do DELETE E para a falha do Commit.
                    THIS.DesfazerTransacao()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.DesfazerTransacao()
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarItem - chama fRecalculaP para o item carregado em this_c* e
    * CONFIRMA a transacao, transcrevendo este trecho do OK.Click legado:
    *
    *   If Used('crRecalculaP') / USE in crRecalculaP / Endif
    *   llOk = fRecalculaP(Emps,grupos,estos,cpros,Datas,CodCors,CodTams, Podatamgr)
    *   If Not llOk / Podatamgr.Rollback() / Loop / Endif
    *   llOk = fRecalculaP(.t., Podatamgr, .t.,.f.,.f.,.f.,.f.,.f.,.t.)
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *   llOk = ( PodataMgr.Commit() > 0 )
    *   If Not llOk / Podatamgr.Rollback() / Loop / EndIf
    *
    * O Commit() eh o TERCEIRO passo, com caminho de falha proprio - nao eh
    * detalhe de infra. Descartado, a transacao manual fica aberta e o
    * recalculo nao chega ao banco.
    *
    * A ARIDADE das duas chamadas segue o legado (8 e 9 argumentos), com
    * gnConnHandle no lugar do poDataMgr - a mesma substituicao que o
    * SigPrCccBO ja faz. A versao anterior passava 7 e 1 argumentos: como a
    * funcao devolve VALOR DE CALCULO, argumento faltando nao estoura, so
    * muda em silencio o que ela calcula (regra #17).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarItem()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Ja medimos que fRecalculaP nao esta no acervo: nao chamar de novo.
        *-- Sem esta porta, cada item da fila repetia a excecao e (antes) um
        *-- MsgErro modal - no modo parametrizado o lote travava no primeiro.
        IF !THIS.this_lRecalculoDisponivel
            RETURN .F.
        ENDIF

        TRY
            IF USED("crRecalculaP")
                USE IN crRecalculaP
            ENDIF

            *-- Primeira chamada: recalcula o saldo do produto especifico
            loc_lSucesso = fRecalculaP( ;
                THIS.this_cEmps, ;
                THIS.this_cGrupos, ;
                THIS.this_cEstos, ;
                THIS.this_cCpros, ;
                THIS.this_dDatas, ;
                THIS.this_cCodCors, ;
                THIS.this_cCodTams, ;
                gnConnHandle )

            IF loc_lSucesso
                *-- Segunda chamada: consolida os saldos recalculados
                loc_lSucesso = fRecalculaP(.T., gnConnHandle, .T., .F., .F., .F., .F., .F., .T.)
            ENDIF

            IF loc_lSucesso
                *-- "llOk = ( ThisForm.PodataMgr.Commit() > 0 )" do legado
                loc_lSucesso = THIS.ConfirmarTransacao()
            ENDIF

            IF !loc_lSucesso
                THIS.DesfazerTransacao()
            ENDIF
        CATCH TO loc_oErro
            THIS.DesfazerTransacao()
            loc_lSucesso = .F.

            *-- Classificar o erro em vez de exibi-lo: o erro 1 do VFP9
            *-- ("File 'x' does not exist.") eh como uma funcao global AUSENTE
            *-- se manifesta, porque nome desconhecido seguido de "(" nao eh
            *-- erro de compilacao - o interpretador procura <nome>.prg no
            *-- PATH e so falha em RUNTIME (regra #13). Medir assim cobre
            *-- TODAS as formas de resolucao: se fRecalculaP vier de um SET
            *-- PROCEDURE, a chamada simplesmente funciona, enquanto um teste
            *-- por FILE() daria falso negativo e abortaria o lote bom.
            IF loc_oErro.ErrorNo = 1 AND "FRECALCULAP" $ UPPER(loc_oErro.Message)
                THIS.this_lRecalculoDisponivel = .F.
                THIS.this_cMensagemErro = "A fun" + CHR(231) + CHR(227) + "o de rec" + CHR(225) + ;
                    "lculo de saldo (fRecalculaP) n" + CHR(227) + "o est" + CHR(225) + ;
                    " dispon" + CHR(237) + "vel nesta instala" + CHR(231) + CHR(227) + "o." + ;
                    CHR(13) + "Nenhum saldo foi recalculado e a fila foi preservada."
            ELSE
                *-- Erro REAL do recalculo (SQL, dado, conexao): registrar para
                *-- o chamador exibir UMA vez no fim da passada. Exibir aqui
                *-- abriria um dialogo por item e travaria o modo parametrizado.
                THIS.this_cMensagemErro = loc_oErro.Message
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarMovimento - retorna .T. se deve pular exclusao da fila
    *   .T. = nao tem movimento em SigMvEst E tem historico em SigMvHst (loop)
    *   .F. = tem movimento em SigMvEst OU nao tem historico -> pode excluir da fila
    *--------------------------------------------------------------------------
    FUNCTION VerificarMovimento()
        LOCAL loc_lDeveLoop, loc_cChave, loc_cSQL, loc_nResult
        loc_lDeveLoop = .F.
        TRY
            loc_cChave = ALLTRIM(THIS.this_cEmps) + ;
                         ALLTRIM(THIS.this_cGrupos) + ;
                         ALLTRIM(THIS.this_cEstos)
            loc_cSQL = "SELECT cidchaves FROM SigMvEst " + ;
                       "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                       "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1 OR RECCOUNT("TmpEst") = 0
                *-- Sem registro em SigMvEst: verificar SigMvHst
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                loc_cSQL = "SELECT empgruests, SUM(1) AS TT FROM SigMvHst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + " " + ;
                           "AND cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + " " + ;
                           "GROUP BY empgruests"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpHis")
                IF loc_nResult < 1
                    loc_lDeveLoop = .T.
                ELSE
                    IF USED("TmpHis") AND RECCOUNT("TmpHis") > 0
                    SELECT TmpHis
                    IF NVL(TT, 0) > 0
                        loc_lDeveLoop = .T.
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
            IF USED("TmpHis")
                USE IN TmpHis
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lDeveLoop = .T.
        ENDTRY
        RETURN loc_lDeveLoop
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravarLog - escreve linha no Fortyus.Log (modo parametrizado)
    *--------------------------------------------------------------------------
    PROCEDURE GravarLog(par_cMensagem)
        LOCAL loc_cArquivo
        loc_cArquivo = "Fortyus.Log"
        TRY
            IF !EMPTY(par_cMensagem)
                STRTOFILE(par_cMensagem + CHR(10), loc_cArquivo, .T.)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarLog - cria/limpa Fortyus.Log e grava cabecalho de inicio
    *--------------------------------------------------------------------------
    PROCEDURE IniciarLog(par_cMensagem)
        TRY
            STRTOFILE("", "Fortyus.Log", .T.)
            THIS.GravarLog(REPLICATE("=", 80))
            THIS.GravarLog(par_cMensagem)
            THIS.GravarLog("Data : " + DTOC(DATE()) + " - Hora : " + TIME())
            THIS.GravarLog(REPLICATE("=", 80))
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - override para log operacional de recalculo de saldos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Tabela, Operacao, ChaveRegistro, DataHora) VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL("SigOpClP") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

ENDDEFINE

