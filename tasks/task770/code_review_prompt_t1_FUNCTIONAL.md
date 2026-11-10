# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH que define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: que.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpNch.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1534 linhas total):

*-- Linhas 16 a 75:
16: *   ValidarParametros     -> a guarda de conexao do Init legado
17: *                            (If Not .poDatamgr.pnIdconn>0 / Messagebox /
18: *                             Return .f.), com bypass de teste/validacao
19: *   InicializarForm       -> instancia o BO, pinta o fundo, cria o cursor da
20: *                            grade (o PROCEDURE Load legado), monta a tela na
21: *                            ORDEM do dump e dispara a carga
22: *   ConfigurarCabecalho   -> cnt_4c_Sombra + os dois labels (cntSombra do
23: *                            legado), com o Caption propagado como no Init
24: *   ConfigurarDecoracao   -> shp_4c_Shape1, a moldura transparente do SCX
25: *   ConfigurarGrade       -> grd_4c_Dados, 5 colunas (SIGOPNCH.Grade)
26: *   ConfigurarBotoesAcao  -> cmd_4c_Confirmar (btnAlterar do dump) e
27: *                            cmd_4c_Encerrar (btnCancelar), soltos no Form
28: *   CarregarLista         -> funil para CarregarGrade
29: *   CarregarGrade         -> a carga do Init legado (via BO.CarregarDados) e
30: *                            o vinculo da grade ao cursor do BO
31: *   BtnConfirmarClick     -> SIGOPNCH.btnAlterar.Click - ACIONA a gravacao em
32: *                            SigSySeq (via BO.GravarNumeracao) e encerra
33: *   BtnEncerrarClick      -> SIGOPNCH.btnCancelar.Click - ThisForm.Release
34: *   Activate              -> o ".Column5.SetFocus" do fim do Init legado
35: *   TornarControlesVisiveis -> AddObject nasce com Visible = .F.
36: *   Destroy               -> libera o BO e delega ao FormBase
37: *
38: * Esta FASE FINAL acrescenta os eventos auxiliares que faltavam - a validacao
39: * da CELULA do proximo cheque (SIGOPNCH.Grade.Column5.Text1.Valid + When), que
40: * eh quem MARCA a linha como alterada e portanto quem decide o que o Confirmar
41: * grava. Ela nao eh evento de botao: pela regra #46 mora no Valid de um TextBox
42: * instalado na Column (Column.AddObject + CurrentControl + Sparse = .F.), nunca
43: * em AfterRowColChange - cujo nColIndex eh a coluna de DESTINO e que, por isso,
44: * validaria a linha para onde o usuario FOI, nao a que ele editou:
45: *
46: *   TextBoxChequeSigOpNch_4c -> subclasse de TextBox com When/Valid EMBUTIDOS,
47: *                            definida no fim deste arquivo e instalada na
48: *                            Column5, a unica celula editavel da tela
49: *   InstalarCelulaCheque  -> AddObject + CurrentControl + Sparse = .F. na
50: *                            Column5; refeito a cada rebind da grade, porque
51: *                            mexer em RecordSource RECRIA os objetos Column e
52: *                            leva junto o controle instalado
53: *   CelulaChequeWhen      -> SIGOPNCH.Grade.Column5.Text1.When - guarda o valor
54: *                            anterior em this_nAntChqVal
55: *   CelulaChequeValid     -> SIGOPNCH.Grade.Column5.Text1.Valid - recusa numero
56: *                            invalido (restaura e devolve 0, o que PRENDE o
57: *                            foco na celula) e MARCA a linha quando o numero
58: *                            mudou. Fecha o circuito da gravacao: sem ele nada
59: *                            escreve Marcas, o "Scan For Marcas" do BO nao
60: *                            acha linha e o Confirmar encerraria sem gravar
61: *   FormParaBO            -> linha corrente da grade + valor DIGITADO -> BO
62: *   BOParaForm            -> BO -> celula; eh o "This.Value = nAntChqVal" do
63: *                            legado, com o BO como FONTE UNICA do numero em
64: *                            vez de a UI guardar regra propria (PILAR 3)
65: *   BtnCancelarClick      -> segundo nome de entrada do MESMO Click de
66: *                            SIGOPNCH.btnCancelar (ver o comentario do metodo)
67: *
68: * Deliberadamente AUSENTES - o legado nao tem a superficie, e cria-los seria
69: * inventar (viola o PILAR 1) ou escrever metodo vazio (proibido pela regra de
70: * completude):
71: *   PageFrame / paginas e a navegacao entre elas -> o SCX nao declara nenhum
72: *       objeto de BaseClass pageframe; nao ha Lista/Dados a alternar
73: *   modos INCLUIR/ALTERAR/VISUALIZAR e habilitacao de campos por modo -> a
74: *       tela tem UM estado unico: as quatro primeiras celulas da grade tem
75: *       When -> .f. no legado e a quinta eh sempre editavel

*-- Linhas 83 a 126:
83: *       declara DOIS CommandButton, e nenhum deles eh busca ou CRUD; o que
84: *       grava eh o Confirmar, ja entregue como BtnConfirmarClick
85: *
86: * poDataMgr do legado (CreateObject('fSqlConector',...) + AddCursor/Requery/
87: * UpDate/Commit/RollBack) NAO tem equivalente aqui de proposito (PILAR 3): o
88: * acesso a dados mora no SigOpNchBO / DataAccess.
89: *==============================================================================
90: 
91: DEFINE CLASS FormSigOpNch AS FormBase
92: 
93:     *--------------------------------------------------------------------------
94:     * Propriedades visuais TRANSCRITAS do dump (SECAO 2, "PROPRIEDADES DE:
95:     * SIGOPNCH"). Caption fica no Init porque leva acento e esta classe nao
96:     * pode ter literal acentuado (regra #4).
97:     *--------------------------------------------------------------------------
98:     this_cMensagemErro = ""
99:     Height       = 370
100:     Width        = 800
101:     AutoCenter   = .T.
102:     BorderStyle  = 2
103:     ShowTips     = .T.
104:     ClipControls = .F.
105:     ControlBox   = .F.
106:     Closable     = .F.
107:     TitleBar     = 0
108: 
109:     *-- MaxButton/MinButton = .F. acompanham TitleBar = 0 + ControlBox = .F.:
110:     *-- sem barra de titulo nao ha onde desenhar os botoes, e o FormBase os
111:     *-- declara .T.. Nao eh invencao de UX - eh coerencia com o dump, que
112:     *-- tambem nao os declara justamente porque ficaram irrelevantes.
113:     MaxButton    = .F.
114:     MinButton    = .F.
115: 
116:     *-- DataSession = 2 TRANSCRITO do dump: os cursores desta tela (as formas
117:     *-- de pagamento, a sequencia de numeros e a propria grade) vivem numa
118:     *-- sessao privada, como no legado. FormBase.Init repoe SET DATE BRITISH /
119:     *-- CENTURY ON / SAFETY OFF, que a sessao privada reseta para o default do
120:     *-- VFP (regra #9.4) - por isso Init() DEVE chamar DODEFAULT().
121:     DataSession  = 2
122: 
123:     FontName     = "Tahoma"
124:     FontSize     = 8
125: 
126:     *-- Dialogo modal top-level, como o legado (TitleBar = 0, Closable = .F.,

*-- Linhas 145 a 389:
145:     * O Init legado termina com "With ThisForm.Grade / .Refresh /
146:     * .Column5.SetFocus / EndWith", isto eh, a tela abre com o cursor
147:     * piscando na coluna do proximo cheque - a UNICA coluna digitavel. Esse
148:     * SetFocus NAO pode sair do InicializarForm: ele roda ANTES do Show e o
149:     * VFP recusa foco em controle de form que ainda nao apareceu. O lugar
150:     * certo eh o Activate, que dispara a cada volta de foco a tela - esta
151:     * flag eh o que faz o foco ser dado so na PRIMEIRA vez, para nao
152:     * sequestrar o cursor do usuario toda vez que ele dispensa um dialogo.
153:     *--------------------------------------------------------------------------
154:     this_lFocoInicialDado = .F.
155: 
156:     *--------------------------------------------------------------------------
157:     * Init - define o Caption (acentos via CHR(), regra #4) e delega ao
158:     * FormBase, que chama InicializarForm.
159:     *
160:     * Apenas Caption + DODEFAULT(): chamar THIS.InicializarForm() aqui faria a
161:     * montagem rodar DUAS vezes e o segundo AddObject estouraria "a member
162:     * object with this name already exists".
163:     *--------------------------------------------------------------------------
164:     PROCEDURE Init()
165:         THIS.Caption = "Numera" + CHR(231) + CHR(227) + "o de Cheques"
166: 
167:         RETURN DODEFAULT()
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * ValidarParametros - a guarda de conexao do Init legado:
172:     *
173:     *   .poDatamgr = CreateObject('fSqlConector', thisform.Name)
174:     *   If Not .poDatamgr.pnIdconn > 0
175:     *       Messagebox('Impossivel Efetuar Conexao com Servidor de Banco de
176:     *                   Dados.', (0+48), 'Erro')
177:     *       Return(.f.)
178:     *   Endif
179:     *
180:     * PUBLIC de proposito: o harness TesteAutomatico.prg alcanca metodos do
181:     * form de FORA da classe, e PROTECTED falharia em runtime (regra #3).
182:     *
183:     * O bypass de teste/validacao vem ANTES da checagem: TesteAutomatico.prg
184:     * define gnConnHandle = 0 como SENTINELA (nao tenta conexao real, para nao
185:     * pagar o timeout TCP), e ValidarUIFidelity.prg define gnConnHandle = -1.
186:     * Sem o bypass, a guarda devolveria .F. SEMPRE nessas etapas, o
187:     * InicializarForm devolveria .F. e CREATEOBJECT("FormSigOpNch") devolveria
188:     * .F. em vez de objeto - reprovando a instanciacao por um erro que nao
189:     * existe.
190:     *--------------------------------------------------------------------------
191:     PROCEDURE ValidarParametros()
192:         LOCAL loc_lValido
193:         loc_lValido = .T.
194: 
195:         IF TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste
196:             RETURN .T.
197:         ENDIF
198: 
199:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
200:             RETURN .T.
201:         ENDIF
202: 
203:         DO CASE
204:             CASE TYPE("gnConnHandle") != "N"
205:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
206:                         "o com Servidor de Banco de Dados.", "Erro")
207:                 loc_lValido = .F.
208: 
209:             CASE gnConnHandle <= 0
210:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
211:                         "o com Servidor de Banco de Dados.", "Erro")
212:                 loc_lValido = .F.
213:         ENDCASE
214: 
215:         RETURN loc_lValido
216:     ENDPROC
217: 
218:     *--------------------------------------------------------------------------
219:     * InicializarForm - monta a estrutura base deste form OPERACIONAL.
220:     *
221:     * NAO existe "IF gb_4c_ValidandoUI / RETURN" no topo: esse gate pularia a
222:     * montagem visual inteira e tornaria qualquer diferenca de UI Fidelity
223:     * irrecuperavel, porque o metodo que escreve a propriedade nunca rodaria
224:     * durante a validacao. O bypass de SQL/rede fica onde o SQL esta - aqui,
225:     * nesta fase, nada depende de rede: o cabecalho eh AddObject puro e o
226:     * cursor da grade eh CREATE CURSOR local.
227:     *
228:     * O RETURN da guarda fica FORA de qualquer TRY (regra #1).
229:     *--------------------------------------------------------------------------
230:     PROTECTED PROCEDURE InicializarForm()
231:         LOCAL loc_lSucesso, loc_oErro
232:         loc_lSucesso = .F.
233: 
234:         IF !THIS.ValidarParametros()
235:             RETURN .F.
236:         ENDIF
237: 
238:         TRY
239:             *-- Equivalente a Thisform.nAntChqVal = 0 do Init legado
240:             THIS.this_nAntChqVal = 0
241: 
242:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpNchBO")
243: 
244:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
245:                 MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio " + ;
246:                         "SigOpNchBO.", "Erro em InicializarForm")
247:             ELSE
248:                 *-- Picture = ..\framework\imagens\new_background.jpg no dump.
249:                 *-- No sistema novo a imagem vive em vbmp\, resolvida por
250:                 *-- gc_4c_CaminhoIcones - nunca reconstruir o caminho a partir
251:                 *-- de gc_4c_CaminhoBase (regra do Pattern #156/#170).
252:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
253: 
254:                 THIS.ConfigurarCabecalho()
255: 
256:                 *-- Equivalente literal as duas primeiras linhas do Init
257:                 *-- legado:
258:                 *--   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
259:                 *--   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
260:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
261:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
262: 
263:                 *-- Equivalente ao PROCEDURE Load legado, que roda ANTES do
264:                 *-- Init e cria o cursor da grade:
265:                 *--   Create Cursor csCheques (FPags C(12), Bancos C(3),
266:                 *--       Agencias C(4), NContas C(10), Cheques N(6),
267:                 *--       Marcas L(1))
268:                 *--   Index On Fpags Tag FPags
269:                 *-- Mora no BO (SigOpNchBO.CriarCursorCheques, que transcreve
270:                 *-- essa estrutura campo a campo) e eh criado JA NESTA FASE
271:                 *-- porque a grade da fase seguinte liga ControlSource nele -
272:                 *-- e ControlSource de cursor inexistente derruba o Init
273:                 *-- inteiro com "Alias not found" (regra #41).
274:                 *--
275:                 *-- A outra metade do Load legado, =fConfigGeral(), nao se
276:                 *-- reproduz: na arquitetura nova a configuracao global ja
277:                 *-- aconteceu em config.prg/main.prg, e utils\fconfiggeral.prg
278:                 *-- eh um no-op que existe APENAS para o p-code dos VCX legado.
279:                 IF !THIS.this_oBusinessObject.CriarCursorCheques()
280:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;
281:                             "vel preparar a grade de cheques.", ;
282:                             "Erro em InicializarForm")
283:                 ELSE
284:                     *-- Ordem dos AddObject = ordem dos objetos no dump
285:                     *-- (cntSombra -> Shape1 -> Grade -> btnAlterar ->
286:                     *-- btnCancelar). Nao eh estetica, sao duas regras de
287:                     *-- z-order: Shape1 eh BackStyle = 0 / BorderStyle = 0,
288:                     *-- ou seja uma caixa TRANSPARENTE de 173x110 - criada
289:                     *-- depois da grade ou dos botoes, bloquearia o clique de
290:                     *-- quem ficasse por baixo (mesma armadilha da caixa
291:                     *-- larga de Label, regra #23); e o cabecalho, criado em
292:                     *-- ConfigurarCabecalho logo acima, COBRIRIA os dois
293:                     *-- botoes se viesse depois, porque eles ficam em
294:                     *-- Top = 3..78, dentro da faixa de 80px (regra #11).
295:                     THIS.ConfigurarDecoracao()
296:                     THIS.ConfigurarGrade()
297:                     THIS.ConfigurarBotoesAcao()
298: 
299:                     *-- AddObject cria todo controle com Visible = .F.
300:                     THIS.TornarControlesVisiveis(THIS)
301: 
302:                     *-- Carga DEPOIS de tornar visivel: Refresh em controle
303:                     *-- invisivel nao pinta (regra #21/#46), e a grade ficaria
304:                     *-- vazia com o cursor cheio.
305:                     *--
306:                     *-- O retorno NAO aborta a abertura: grade sem linha eh
307:                     *-- estado legitimo (nenhuma forma de pagamento tipo
308:                     *-- cheque com conta bancaria configurada) e o BO ja
309:                     *-- exibiu a falha, se houve SQL que falhou - o form
310:                     *-- continua utilizavel para fechar.
311:                     THIS.CarregarLista()
312: 
313:                     loc_lSucesso = .T.
314:                 ENDIF
315:             ENDIF
316: 
317:         CATCH TO loc_oErro
318:             THIS.this_cMensagemErro = loc_oErro.Message
319:             MsgErro(loc_oErro.Message + CHR(13) + ;
320:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
321:                     "Procedure: " + loc_oErro.Procedure, ;
322:                     "Erro em InicializarForm")
323:         ENDTRY
324: 
325:         RETURN loc_lSucesso
326:     ENDPROC
327: 
328:     *--------------------------------------------------------------------------
329:     * ConfigurarCabecalho - cria cnt_4c_Sombra (cntSombra do legado) com os
330:     * dois labels sobrepostos que formam o titulo com sombra: lbl_4c_LblSombra
331:     * (preto, Top = 18) desenhado PRIMEIRO e lbl_4c_LblTitulo (branco,
332:     * Top = 17) por cima, deslocado 1px - a ordem dos AddObject eh o que
333:     * produz o efeito; invertida, o titulo branco ficaria por baixo.
334:     *
335:     * Dump (SIGOPNCH.cntSombra): Top = 0, Left = 0, Width = 804, Height = 80,
336:     * BorderWidth = 0, BackColor = 100,100,100.
337:     *
338:     * Width = THIS.Width (800) em vez do literal 804: o Form Designer desenhou
339:     * o container 4px MAIS LARGO que a propria janela (SIGOPNCH.Width = 800),
340:     * artefato ja catalogado - container de cabecalho nunca fica hardcoded
341:     * diferente do form (regra #11/#88/#89). Os labels, ao contrario, cabem na
342:     * area visivel (Left 10 + Width 769 = 779 < 800) e por isso ficam com o
343:     * literal do dump, sem risco de serem recortados (regra #30).
344:     *
345:     * BackStyle = 1 explicito: a faixa precisa ser OPACA para o cinza
346:     * RGB(100,100,100) aparecer por tras do titulo branco; transparente, o
347:     * cabecalho sumiria sobre o fundo claro do form.
348:     *--------------------------------------------------------------------------
349:     PROTECTED PROCEDURE ConfigurarCabecalho()
350:         LOCAL loc_oCab
351: 
352:         THIS.AddObject("cnt_4c_Sombra", "Container")
353:         loc_oCab = THIS.cnt_4c_Sombra
354:         WITH loc_oCab
355:             .Top         = 0
356:             .Left        = 0
357:             .Width       = THIS.Width
358:             .Height      = 80
359:             .BackStyle   = 1
360:             .BackColor   = RGB(100, 100, 100)
361:             .BorderWidth = 0
362:         ENDWITH
363: 
364:         *-- FontSize 18 TRANSCRITO do dump (lblSombra/lblTitulo declaram
365:         *-- FontSize = 18). O 16 da tabela canonica da regra #11 vale para a
366:         *-- faixa INJETADA nas Pages de form CRUD, nao para o cntSombra que
367:         *-- este OPERACIONAL transcreve do proprio SCX.
368:         *--
369:         *-- AutoSize = .F. explicito com Width E Height do dump: em Label
370:         *-- criado por AddObject o auto-size fica ADIADO ate o controle ficar
371:         *-- visivel, e com WordWrap = .T. ele DESCARTA a Height e colapsa o
372:         *-- texto para uma linha (regra #23). Os 769x40 / 769x46 do SCX JA SAO
373:         *-- o auto-size que o Form Designer calculou - fixa-los eh reproducao
374:         *-- fiel, nao desvio do PILAR 1.
375:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
376:         WITH loc_oCab.lbl_4c_LblSombra
377:             .AutoSize      = .F.
378:             .Top           = 18
379:             .Left          = 10
380:             .Width         = 769
381:             .Height        = 40
382:             .FontName      = "Tahoma"
383:             .FontSize      = 18
384:             .FontBold      = .T.
385:             .FontUnderline = .F.
386:             .Alignment     = 0
387:             .BackStyle     = 0
388:             .WordWrap      = .T.
389:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 413 a 503:
413:     ENDPROC
414: 
415:     *--------------------------------------------------------------------------
416:     * TornarControlesVisiveis - torna visiveis, recursivamente, os controles
417:     * criados por AddObject (que nascem com Visible = .F.).
418:     *
419:     * SEM lista de excecao: este form nao tem container flutuante nem controle
420:     * que o SCX declare Visible = .F. - todos os objetos do dump sao visiveis.
421:     * Se alguma fase seguinte acrescentar controle que nasce oculto, o nome
422:     * dele tem de ser filtrado aqui, senao esta varredura o expoe.
423:     *--------------------------------------------------------------------------
424:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
425:         LOCAL loc_nI, loc_oControl
426: 
427:         FOR loc_nI = 1 TO par_oContainer.ControlCount
428:             loc_oControl = par_oContainer.Controls(loc_nI)
429: 
430:             IF VARTYPE(loc_oControl) = "O"
431:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
432:                     loc_oControl.Visible = .T.
433:                 ENDIF
434: 
435:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
436:                    loc_oControl.ControlCount > 0
437:                     THIS.TornarControlesVisiveis(loc_oControl)
438:                 ENDIF
439:             ENDIF
440:         ENDFOR
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     * ConfigurarDecoracao - shp_4c_Shape1 (SIGOPNCH.Shape1 do dump).
445:     *
446:     * Dump: Top = 7, Left = 612, Width = 173, Height = 110, BackStyle = 0,
447:     * BorderStyle = 0, BorderColor = 136,189,188.
448:     *
449:     * Com BackStyle = 0 (sem preenchimento) E BorderStyle = 0 (sem traco) a
450:     * figura nao DESENHA nada, e o BorderColor fica inerte: eh moldura morta
451:     * que o Form Designer deixou no SCX atras dos dois botoes. Esta aqui por
452:     * fidelidade (PILAR 1) - omitida, o ValidarUIFidelity acusa objeto
453:     * ausente -, e por isso mesmo nao se "conserta" dando borda a ela.
454:     *
455:     * BorderColor transcrito mesmo sem efeito visivel porque a propriedade
456:     * EXISTE em Shape; ForeColor eh que NAO existe (regra #33), e por isso
457:     * nao aparece aqui - o dump do legado tambem nunca a declara.
458:     *
459:     * Left 612 + Width 173 = 785 < 800 (Form.Width) e Top 7 + Height 110 =
460:     * 117 < 370: a figura cabe inteira na area visivel, nao ha recorte
461:     * (regra #30).
462:     *--------------------------------------------------------------------------
463:     PROTECTED PROCEDURE ConfigurarDecoracao()
464:         THIS.AddObject("shp_4c_Shape1", "Shape")
465: 
466:         WITH THIS.shp_4c_Shape1
467:             .Top         = 7
468:             .Left        = 612
469:             .Width       = 173
470:             .Height      = 110
471:             .BackStyle   = 0
472:             .BorderStyle = 0
473:             .BorderColor = RGB(136, 189, 188)
474:         ENDWITH
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     * ConfigurarGrade - grd_4c_Dados (SIGOPNCH.Grade do dump, classe fwgrade
479:     * de framework.vcx): a UNICA lista da tela. Uma linha por forma de
480:     * pagamento tipo cheque com conta bancaria, e o proximo numero de cheque
481:     * editavel na ultima coluna.
482:     *
483:     * Dump (SIGOPNCH.Grade): ColumnCount = 5, Top = 104, Left = 183,
484:     * Width = 434, Height = 238, RowHeight = 16, FontName = "Tahoma",
485:     * FontSize = 8. As cinco larguras do dump (123 + 35 + 55 + 80 + 105)
486:     * somam 398 e cabem nos 434 do grid.
487:     *
488:     * SO a estrutura visual: RecordSource/ControlSource ficam em
489:     * CarregarGrade, unico ponto de vinculo. Nao eh preferencia de
490:     * organizacao - mexer em RecordSource RECRIA os objetos Column e devolve
491:     * Width ao default 90, zera Header1.Caption e faz o ReadOnly da coluna
492:     * voltar a herdar o do Grid (Problema 48 do FormCor), entao o que fosse
493:     * ligado aqui se perderia na primeira carga.
494:     *
495:     * O .ReadOnly do GRID vem ANTES do das colunas: o do grid PROPAGA e
496:     * sobrescreveria o delas. .F. aqui porque a Column5 (proximo cheque) eh
497:     * editavel no legado; as outras quatro recebem .ReadOnly = .T., que eh
498:     * como o dump as declara.
499:     *
500:     * Essas quatro trazem a MESMA intencao dita duas vezes no legado:
501:     * Column.ReadOnly = .T. no dump E um When devolvendo .f. no Text1.
502:     * Reproduzida pelo ReadOnly da coluna e do Text1 - nao ha metodo When a
503:     * portar, porque ele nao faz nada alem de recusar o foco.

*-- Linhas 511 a 554:
511:     * "Tahoma" do dump PREVALECE sobre o "Verdana" canonico - eh override
512:     * explicito do proprio SCX.
513:     *--------------------------------------------------------------------------
514:     PROTECTED PROCEDURE ConfigurarGrade()
515:         THIS.AddObject("grd_4c_Dados", "Grid")
516: 
517:         WITH THIS.grd_4c_Dados
518:             .Top                = 104
519:             .Left               = 183
520:             .Width              = 434
521:             .Height             = 238
522:             .ColumnCount        = 5
523:             .FontName           = "Tahoma"
524:             .FontSize           = 8
525:             .RowHeight          = 16
526:             .ScrollBars         = 2
527:             .DeleteMark         = .F.
528:             .RecordMark         = .F.
529:             .BackColor          = RGB(255, 255, 255)
530:             .ForeColor          = RGB(90, 90, 90)
531:             .GridLineColor      = RGB(238, 238, 238)
532:             .HighlightStyle     = 2
533:             .HighlightBackColor = RGB(255, 255, 255)
534:             .HighlightForeColor = RGB(15, 41, 104)
535:             *-- ANTES das colunas: Grid.ReadOnly propaga para elas
536:             .ReadOnly           = .F.
537:         ENDWITH
538: 
539:         *-- Column1 "Forma de Pagamento" (csCheques.FPags -> SigOpFp.fpags,
540:         *-- char(12)) - travada no legado
541:         WITH THIS.grd_4c_Dados.Column1
542:             .Width     = 123
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .Movable   = .F.
546:             .Resizable = .F.
547:             .ReadOnly  = .T.
548:         ENDWITH
549:         WITH THIS.grd_4c_Dados.Column1.Header1
550:             .FontName  = "Tahoma"
551:             .FontSize  = 8
552:             .Alignment = 2
553:             .Caption   = "Forma de Pagamento"
554:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 736 a 881:
736:     * (o dump nao tem pcEscolha), nao tem par de paginas Lista/Dados e nao tem
737:     * irmao Incluir/Visualizar/Excluir algum.
738:     *
739:     * BINDEVENT so AGORA, com os dois handlers ja escritos mais abaixo: bind
740:     * apontando para metodo inexistente estoura no PROPRIO BINDEVENT, dentro
741:     * do Init, e a tela nao abriria. Os handlers sao PUBLIC (sem PROTECTED) -
742:     * com metodo PROTECTED o BINDEVENT falha em SILENCIO (regra #3).
743:     *--------------------------------------------------------------------------
744:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
745: 
746:         *-- btnAlterar (fwbtng) - "Confirmar": grava as linhas marcadas
747:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
748:         WITH THIS.cmd_4c_Confirmar
749:             .Top             = 3
750:             .Left            = 650
751:             .Width           = 75
752:             .Height          = 75
753:             .Caption         = "\<Confirmar"
754:             .FontName        = "Comic Sans MS"
755:             .FontSize        = 8
756:             .FontBold        = .T.
757:             .FontItalic      = .T.
758:             .ForeColor       = RGB(90, 90, 90)
759:             .BackColor       = RGB(255, 255, 255)
760:             .Themes          = .T.
761:             .SpecialEffect   = 0
762:             .PicturePosition = 13
763:             .MousePointer    = 15
764:             .WordWrap        = .T.
765:             .AutoSize        = .F.
766:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
767:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
768:         ENDWITH
769: 
770:         BINDEVENT(THIS.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
771: 
772:         *-- btnCancelar (fwbtng) - "Encerrar": fecha a tela sem gravar
773:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
774:         WITH THIS.cmd_4c_Encerrar
775:             .Top             = 3
776:             .Left            = 725
777:             .Width           = 75
778:             .Height          = 75
779:             .Caption         = "Encerrar"
780:             .Cancel          = .T.
781:             .FontName        = "Comic Sans MS"
782:             .FontSize        = 8
783:             .FontBold        = .T.
784:             .FontItalic      = .T.
785:             .ForeColor       = RGB(90, 90, 90)
786:             .BackColor       = RGB(255, 255, 255)
787:             .Themes          = .T.
788:             .SpecialEffect   = 0
789:             .PicturePosition = 13
790:             .MousePointer    = 15
791:             .WordWrap        = .T.
792:             .AutoSize        = .F.
793:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
794:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
795:         ENDWITH
796: 
797:         BINDEVENT(THIS.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
798:     ENDPROC
799: 
800:     *--------------------------------------------------------------------------
801:     * CarregarGrade - funil UNICO de carga e vinculo da grade. Transcreve o
802:     * trecho final do Init legado:
803:     *
804:     *   (o Scan que monta csCheques - hoje SigOpNchBO.CarregarDados)
805:     *   Select csCheques
806:     *   Go Top
807:     *   With ThisForm.Grade
808:     *       .Refresh
809:     *       .Column5.SetFocus
810:     *   EndWith
811:     *
812:     * Ordem OBRIGATORIA: RecordSource -> ControlSource -> Width ->
813:     * Header1.Caption -> ReadOnly da coluna. Mexer em RecordSource RECRIA os
814:     * objetos Column: a Width volta ao default 90, o Header1.Caption eh
815:     * zerado e o ReadOnly da coluna volta a herdar o do Grid - por isso os
816:     * tres sao reaplicados AQUI, e nao apenas em ConfigurarGrade
817:     * (Problema 48 do FormCor). O InputMask da coluna editavel entra na
818:     * mesma lista por ser FUNCIONAL: perdido, o campo passaria a aceitar
819:     * mais de 6 digitos (regra #49).
820:     *
821:     * RecordSource fica FORA do WITH do grid: dentro do MESMO WITH que
822:     * acabou de atribui-lo, acessar .Column1 estoura "Unknown member
823:     * COLUMN1", porque os objetos acabaram de ser recriados.
824:     *
825:     * O SetFocus do legado NAO vem para ca: InicializarForm roda ANTES do
826:     * Show e o VFP recusa foco em controle de form que ainda nao apareceu.
827:     * Ele mora no Activate, guardado por this_lFocoInicialDado.
828:     *
829:     * PUBLIC de proposito (regras #3/#51): o harness de teste chama
830:     * CarregarLista/CarregarGrade de FORA da classe, e PEMSTATUS(...,5)
831:     * devolve .T. tambem para metodo PROTECTED - o teste entraria no branch
832:     * e a chamada falharia em runtime.
833:     *
834:     * Bypass de SQL em modo teste/ValidarUIFidelity: CarregarDados do BO faz
835:     * SQLEXEC em SigOpFp/SigSySeq, inalcancavel em instanciacao headless. A
836:     * grade fica com a estrutura montada e LIGADA ao cursor vazio que
837:     * InicializarForm criou - basta para a validacao de UI, e em nenhum
838:     * cenario a grade fica sem RecordSource (grade sem RecordSource vira um
839:     * retangulo branco, sem cabecalho e sem coluna).
840:     *--------------------------------------------------------------------------
841:     PROCEDURE CarregarGrade()
842:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_cCursor, loc_oErro
843: 
844:         loc_lSucesso = .F.
845: 
846:         TRY
847:             loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
848:                                (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
849: 
850:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
851: 
852:             IF !loc_lBypassTeste
853:                 THIS.this_oBusinessObject.CarregarDados()
854:             ENDIF
855: 
856:             IF USED(loc_cCursor)
857:                 *-- FORA do WITH (ver cabecalho): recria os objetos Column
858:                 THIS.grd_4c_Dados.RecordSource = loc_cCursor
859: 
860:                 *-- Mapeamento coluna -> campo transcrito do dump, que liga
861:                 *-- por csCheques.<campo>; aqui pelo cursor do BO, que
862:                 *-- reproduz a MESMA estrutura campo a campo
863:                 *-- (SigOpNchBO.CriarCursorCheques)
864:                 WITH THIS.grd_4c_Dados
865:                     .Column1.ControlSource = loc_cCursor + ".FPags"
866:                     .Column2.ControlSource = loc_cCursor + ".Bancos"
867:                     .Column3.ControlSource = loc_cCursor + ".Agencias"
868:                     .Column4.ControlSource = loc_cCursor + ".NContas"
869:                     .Column5.ControlSource = loc_cCursor + ".Cheques"
870:                 ENDWITH
871: 
872:                 *-- Marcas (L(1), 6o campo do cursor) NAO ganha coluna: o
873:                 *-- legado tem ColumnCount = 5 e usa Marcas apenas como flag
874:                 *-- interna de "linha tocada pelo usuario", lida pelo
875:                 *-- Confirmar. Uma 6a coluna exporia na tela um controle que
876:                 *-- o legado nao tem.
877: 
878:                 WITH THIS.grd_4c_Dados
879:                     .Column1.Width = 123
880:                     .Column2.Width = 35
881:                     .Column3.Width = 55

*-- Linhas 909 a 982:
909:                 *-- RecordSource: ele RECRIA os objetos Column e levaria
910:                 *-- junto qualquer controle instalado antes (por isso o
911:                 *-- metodo eh idempotente e roda em TODA carga, nao uma vez
912:                 *-- so no InicializarForm).
913:                 THIS.InstalarCelulaCheque(THIS.grd_4c_Dados)
914: 
915:                 *-- Legado: "Select csCheques / Go Top" ANTES do
916:                 *-- "Grade.Refresh" - popular o cursor nao repinta a grade
917:                 *-- sozinho (regra #21a), e sem o Go Top a linha corrente
918:                 *-- ficaria onde o Scan do BO a deixou
919:                 SELECT (loc_cCursor)
920:                 GO TOP
921:                 THIS.grd_4c_Dados.Refresh()
922: 
923:                 loc_lSucesso = .T.
924:             ENDIF
925: 
926:         CATCH TO loc_oErro
927:             THIS.this_cMensagemErro = loc_oErro.Message
928:             MsgErro(loc_oErro.Message + CHR(13) + ;
929:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
930:                     "Procedure: " + loc_oErro.Procedure, ;
931:                     "Erro em FormSigOpNch.CarregarGrade")
932:         ENDTRY
933: 
934:         RETURN loc_lSucesso
935:     ENDPROC
936: 
937:     *--------------------------------------------------------------------------
938:     * CarregarLista - nome canonico de carga do projeto; funil unico para
939:     * CarregarGrade(). PUBLIC pelo mesmo motivo (o harness de teste chama de
940:     * fora da classe - regra #3).
941:     *--------------------------------------------------------------------------
942:     PROCEDURE CarregarLista()
943:         RETURN THIS.CarregarGrade()
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * BtnConfirmarClick - transcricao de SIGOPNCH.btnAlterar.Click, o UNICO
948:     * ponto de gravacao desta tela.
949:     *
950:     * Legado, na ordem:
951:     *
952:     *   Select csCheques
953:     *   Scan For Marcas
954:     *       If !IsEmpty(csCheques.Cheques)
955:     *           lcChave = PADR(Bancos + Agencias + NContas, 25)
956:     *           Locate em crAutoriza For valor = lcChave
957:     *             achou     -> Replace Conteudo With csCheques.Cheques - 1
958:     *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
959:     *                          Values (lcChave, csCheques.Cheques - 1)
960:     *       Endif
961:     *   EndScan
962:     *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
963:     *   If Not m.lnErro1 > 0
964:     *       = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.', 48)
965:     *   EndIf
966:     *   ThisForm.Release
967:     *
968:     * O LACO, a chave POSICIONAL de 25 (regra #42), o "- 1", o
969:     * update-ou-insert e a transacao (UpDate/Commit/RollBack) vivem INTEIROS
970:     * em SigOpNchBO.GravarNumeracao - o poDataMgr do legado nao se reproduz
971:     * aqui de proposito (PILAR 3): o acesso a dados mora no BO/DataAccess.
972:     * Este handler eh o GATILHO, e isso eh tudo o que ele faz.
973:     *
974:     * NAO ha "Valid da celula" a chamar antes: ao clicar o botao (ou disparar
975:     * o ALT+C do Caption) o foco SAI da Column5, e o VFP roda o Valid dela
976:     * ANTES do Click - era assim que o legado contava com a linha ja marcada.
977:     * Forcar um SetFocus aqui seria inventar passo que o legado nao tem.
978:     *
979:     * A mensagem de erro eh a do legado, LITERAL, e so aparece quando o BO
980:     * ainda nao exibiu nada (regra #20: GravarNumeracao ja reporta a falha e
981:     * marca this_lErroExibido - sem a guarda o usuario levaria o mesmo erro
982:     * duas vezes).

*-- Linhas 989 a 1534:
989:     * BO dentro: nada de RETURN/saida dentro de TRY/CATCH (regra #1), e o
990:     * encerramento precisa valer tambem no caminho do CATCH.
991:     *
992:     * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT, que falha em SILENCIO com
993:     * metodo PROTECTED (regra #3), e metodo chamado de fora da classe nunca
994:     * pode ser protegido (regra #51).
995:     *--------------------------------------------------------------------------
996:     PROCEDURE BtnConfirmarClick()
997:         LOCAL loc_cCursor, loc_lGravou, loc_oErro
998: 
999:         TRY
1000:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1001:             loc_lGravou = THIS.this_oBusinessObject.GravarNumeracao(loc_cCursor)
1002: 
1003:             IF !loc_lGravou AND !THIS.this_oBusinessObject.this_lErroExibido
1004:                 MsgErro("Erro na Grava" + CHR(231) + CHR(227) + "o dos Dados " + ;
1005:                         "do Cadastro de Opera" + CHR(231) + CHR(245) + "es.", ;
1006:                         "Erro")
1007:             ENDIF
1008: 
1009:         CATCH TO loc_oErro
1010:             THIS.this_cMensagemErro = loc_oErro.Message
1011:             MsgErro(loc_oErro.Message + CHR(13) + ;
1012:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1013:                     "Procedure: " + loc_oErro.Procedure, ;
1014:                     "Erro em FormSigOpNch.BtnConfirmarClick")
1015:         ENDTRY
1016: 
1017:         THIS.Release()
1018:     ENDPROC
1019: 
1020:     *--------------------------------------------------------------------------
1021:     * BtnEncerrarClick - transcricao de SIGOPNCH.btnCancelar.Click, que eh uma
1022:     * linha so:
1023:     *
1024:     *   ThisForm.Release
1025:     *
1026:     * Nada mais: o legado NAO pergunta "descartar as alteracoes?" e NAO
1027:     * desfaz nada. As edicoes vivem no cursor LOCAL csCheques, que morre junto
1028:     * com a tela, entao fechar JA eh o descarte - e inventar uma confirmacao
1029:     * que o usuario nunca viu violaria o PILAR 1.
1030:     *
1031:     * Release, e nao Hide: este form eh de topo, aberto pelo menu, e nao
1032:     * devolve resultado a chamador nenhum - Hide so se aplica a dialogo filho
1033:     * cujo pai le algo depois de fechar.
1034:     *
1035:     * Sem TRY/CATCH: o corpo eh uma unica chamada sem caminho de falha a
1036:     * tratar, e um CATCH aqui jogaria um dialogo de erro em cima de uma tela
1037:     * que o usuario acabou de mandar fechar.
1038:     *
1039:     * Este eh tambem o destino do ESC - cmd_4c_Encerrar tem Cancel = .T.
1040:     * (transcrito do dump) - e, com TitleBar = 0 / ControlBox = .F. /
1041:     * Closable = .F., eh a UNICA saida da tela.
1042:     *
1043:     * PUBLIC pelo mesmo motivo do irmao (alvo de BINDEVENT - regra #3).
1044:     *--------------------------------------------------------------------------
1045:     PROCEDURE BtnEncerrarClick()
1046:         THIS.Release()
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     * InstalarCelulaCheque - poe TextBoxChequeSigOpNch_4c na Column5, a UNICA
1051:     * celula que o legado dota de evento (Valid + When). As outras quatro
1052:     * colunas seguem com o Text1 nativo: o dump so lhes da "When / Return .f.",
1053:     * que eh recusa de foco - ja reproduzida pelo ReadOnly da coluna e do Text1
1054:     * em ConfigurarGrade. Instalar celula nelas seria acrescentar superficie
1055:     * que o legado nao tem (PILAR 1).
1056:     *
1057:     * As TRES linhas finais sao obrigatorias JUNTAS (regra #18):
1058:     *     AddObject      - cria o objeto, mas a coluna segue desenhando o Text1
1059:     *     CurrentControl - eh o que faz a coluna DESENHAR o novo controle
1060:     *     Sparse = .F.   - senao ele so aparece na linha ATIVA
1061:     * Faltando o CurrentControl, o controle existe, responde a PEMSTATUS e
1062:     * NUNCA aparece - e o Valid nunca roda, sem erro e sem log.
1063:     *
1064:     * Column.ReadOnly por ULTIMO: o ReadOnly do GRID propaga para as colunas e
1065:     * sobrescreveria este (regra #18).
1066:     *
1067:     * As propriedades de Text1 do dump sao REAPLICADAS aqui porque
1068:     * ConfigurarGrade as escreveu no .Text1, que nesta coluna deixou de ser o
1069:     * controle exibido - sem repetir, a celula sairia com borda, margem e fonte
1070:     * diferentes das outras quatro. O InputMask = "999999" entra na lista por
1071:     * ser FUNCIONAL: a mascara da COLUNA nao chega ao TextBox instalado, e
1072:     * perdida ela o campo passaria a aceitar mais de 6 digitos (regra #49).
1073:     *
1074:     * IDEMPOTENTE (guard PEMSTATUS): eh chamado de CarregarGrade, que roda em
1075:     * toda carga, e AddObject com nome repetido estoura "Object ... is already
1076:     * defined" e derrubaria a tela.
1077:     *
1078:     * O .Value = 0 so na CRIACAO: nascido assim o controle eh NUMERICO desde o
1079:     * inicio (TextBox nasce com .Value = "" caractere, e o When compararia
1080:     * tipos diferentes). Na reinstalacao ele NAO se repete - ali o controle ja
1081:     * eh o CurrentControl da coluna, logo esta ligado ao ControlSource, e
1082:     * atribuir .Value sujaria o registro corrente do cursor.
1083:     *--------------------------------------------------------------------------
1084:     PROTECTED PROCEDURE InstalarCelulaCheque(par_oGrade)
1085:         LOCAL loc_lSucesso, loc_oColuna, loc_oErro
1086: 
1087:         loc_lSucesso = .F.
1088: 
1089:         IF VARTYPE(par_oGrade) != "O"
1090:             RETURN .F.
1091:         ENDIF
1092: 
1093:         TRY
1094:             IF par_oGrade.ColumnCount >= 5
1095:                 loc_oColuna = par_oGrade.Columns(5)
1096: 
1097:                 IF !PEMSTATUS(loc_oColuna, "txt_4c_Celula", 5)
1098:                     loc_oColuna.AddObject("txt_4c_Celula", "TextBoxChequeSigOpNch_4c")
1099:                     loc_oColuna.txt_4c_Celula.Value = 0
1100:                 ENDIF
1101: 
1102:                 *-- Text1 do dump (SIGOPNCH.Grade.Column5.Text1), celula a celula
1103:                 WITH loc_oColuna.txt_4c_Celula
1104:                     .FontName    = "Tahoma"
1105:                     .FontSize    = 8
1106:                     .BorderStyle = 0
1107:                     .Margin      = 0
1108:                     .InputMask   = "999999"
1109:                     .ReadOnly    = .F.
1110:                     .ForeColor   = RGB(0, 0, 0)
1111:                     .BackColor   = RGB(255, 255, 255)
1112:                     .Visible     = .T.
1113:                 ENDWITH
1114: 
1115:                 *-- Sem estas duas a celula nao aparece / aparece so na linha ativa
1116:                 loc_oColuna.CurrentControl = "txt_4c_Celula"
1117:                 loc_oColuna.Sparse         = .F.
1118: 
1119:                 *-- DEPOIS do Grid.ReadOnly, que propaga para as colunas
1120:                 loc_oColuna.ReadOnly       = .F.
1121: 
1122:                 loc_lSucesso = .T.
1123:             ENDIF
1124: 
1125:         CATCH TO loc_oErro
1126:             THIS.this_cMensagemErro = loc_oErro.Message
1127:             MsgErro(loc_oErro.Message + CHR(13) + ;
1128:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1129:                     "Procedure: " + loc_oErro.Procedure, ;
1130:                     "Erro em FormSigOpNch.InstalarCelulaCheque")
1131:         ENDTRY
1132: 
1133:         RETURN loc_lSucesso
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * CelulaChequeWhen - transcricao de SIGOPNCH.Grade.Column5.Text1.When:
1138:     *
1139:     *   Thisform.nAntChqVal = This.Value
1140:     *   Return( .T. )
1141:     *
1142:     * Guarda o numero que a celula tinha ANTES da digitacao. Eh o unico ponto
1143:     * que escreve this_nAntChqVal, e o Valid depende dele para duas coisas:
1144:     * restaurar o valor quando a digitacao eh invalida e decidir se a linha de
1145:     * fato mudou (e portanto se deve ser marcada para gravacao).
1146:     *
1147:     * O When devolve .T. SEMPRE, como o legado: aqui ele nao eh porta de
1148:     * entrada - quem recusa a edicao das outras colunas eh o ReadOnly delas.
1149:     *
1150:     * O guard de VARTYPE existe porque a celula pode ser visitada com a grade
1151:     * ainda sem linha (cursor vazio): ali o .Value do controle eh o 0 de
1152:     * nascimento, e nao ha anterior real a guardar.
1153:     *
1154:     * PUBLIC (sem PROTECTED): eh chamado de FORA da classe do form - pela
1155:     * subclasse do TextBox - e metodo PROTECTED falharia em runtime com
1156:     * "Property ... is not found" (regras #3 e #51).
1157:     *--------------------------------------------------------------------------
1158:     PROCEDURE CelulaChequeWhen(par_oTxt)
1159:         IF VARTYPE(par_oTxt) = "O" AND VARTYPE(par_oTxt.Value) = "N"
1160:             THIS.this_nAntChqVal = par_oTxt.Value
1161:         ELSE
1162:             THIS.this_nAntChqVal = 0
1163:         ENDIF
1164: 
1165:         RETURN .T.
1166:     ENDPROC
1167: 
1168:     *--------------------------------------------------------------------------
1169:     * CelulaChequeValid - transcricao de SIGOPNCH.Grade.Column5.Text1.Valid:
1170:     *
1171:     *   If This.Value < 0
1172:     *       MessageBox("Numero do Cheque Invalido.", 48, "")
1173:     *       This.Value = Thisform.nAntChqVal
1174:     *       Return 0
1175:     *   EndIf
1176:     *
1177:     *   If This.Value # Thisform.nAntChqVal
1178:     *       Select csCheques
1179:     *       Replace csCheques.Marcas With .T.
1180:     *   EndIf
1181:     *
1182:     * Este metodo FECHA O CIRCUITO da tela: Marcas eh a flag que o
1183:     * "Scan For Marcas" do Confirmar le, entao sem ele nenhuma linha seria
1184:     * gravada por mais que o usuario digitasse.
1185:     *
1186:     * O valor digitado esta em par_oTxt.Value e AINDA NAO chegou ao cursor - o
1187:     * ControlSource da coluna so escreve depois de o Valid passar (regra #46).
1188:     * Ler o cursor aqui validaria o valor ANTIGO; por isso FormParaBO recebe a
1189:     * celula e deixa que ela PREVALECA sobre o que esta gravado na linha.
1190:     *
1191:     * Quem decide se o numero presta eh o BO (ValidarNumeroCheque), nao a
1192:     * tela: a regra - e a mensagem - sao de negocio e tem fonte unica, a mesma
1193:     * que GravarNumeracao consulta antes de montar o lote. Duplicar o
1194:     * "If This.Value < 0" aqui criaria um segundo lugar para a regra divergir.
1195:     *
1196:     * MsgAviso, e nao MsgErro: o legado usa MessageBox com icone 48
1197:     * (exclamacao), que eh validacao de entrada do usuario - MsgErro abre o
1198:     * dialogo vermelho, reservado a excecao tecnica. O titulo vazio do legado
1199:     * vira o canonico "Atencao" do projeto (MsgAviso com titulo vazio).
1200:     *
1201:     * RETURN 0 (numerico) no caminho invalido eh o que PRENDE o foco na celula,
1202:     * obrigando o usuario a corrigir - exatamente o "Return 0" do legado. Nao
1203:     * ha laco de dialogo: o valor acabou de ser restaurado para o anterior, que
1204:     * por construcao eh valido, entao a proxima saida da celula passa.
1205:     *
1206:     * O 0 eh devolvido FORA do TRY, por flag (regra #1) - e a flag nasce .T.
1207:     * para que uma falha inesperada NAO prenda o usuario na celula.
1208:     *
1209:     * PUBLIC pelo mesmo motivo do irmao (chamado pela subclasse do TextBox, de
1210:     * fora da classe do form - regras #3 e #51).
1211:     *--------------------------------------------------------------------------
1212:     PROCEDURE CelulaChequeValid(par_oTxt)
1213:         LOCAL loc_uRetorno, loc_nDigitado, loc_oBO, loc_oErro
1214: 
1215:         loc_uRetorno = .T.
1216: 
1217:         TRY
1218:             loc_oBO = THIS.this_oBusinessObject
1219: 
1220:             IF VARTYPE(par_oTxt) = "O" AND VARTYPE(loc_oBO) = "O" ;
1221:                     AND THIS.FormParaBO(par_oTxt)
1222: 
1223:                 loc_nDigitado = loc_oBO.this_nProxCheque
1224: 
1225:                 IF !loc_oBO.ValidarNumeroCheque(loc_nDigitado)
1226:                     MsgAviso(loc_oBO.this_cMensagemErro, "")
1227: 
1228:                     *-- "This.Value = Thisform.nAntChqVal": o BO volta ao
1229:                     *-- numero anterior e BOParaForm espelha na celula. O
1230:                     *-- CURSOR nao eh tocado - ele ainda tem o valor antigo,
1231:                     *-- porque o ControlSource so grava apos um Valid que
1232:                     *-- passe, e eh justamente esse que esta sendo recusado.
1233:                     loc_oBO.this_nProxCheque = THIS.this_nAntChqVal
1234:                     loc_oBO.this_nConteudo   = THIS.this_nAntChqVal - 1
1235: 
1236:                     THIS.BOParaForm(par_oTxt)
1237: 
1238:                     loc_uRetorno = 0
1239:                 ELSE
1240:                     *-- "If This.Value # Thisform.nAntChqVal": so a linha que
1241:                     *-- o usuario de fato mudou eh marcada. Sem a comparacao,
1242:                     *-- apenas passar o foco pela celula marcaria a linha e o
1243:                     *-- Confirmar regravaria contas que ninguem editou.
1244:                     IF loc_nDigitado != THIS.this_nAntChqVal
1245:                         loc_oBO.MarcarChequeAlterado(loc_oBO.this_cCursorCheques)
1246:                     ENDIF
1247:                 ENDIF
1248:             ENDIF
1249: 
1250:         CATCH TO loc_oErro
1251:             THIS.this_cMensagemErro = loc_oErro.Message
1252:             MsgErro(loc_oErro.Message + CHR(13) + ;
1253:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1254:                     "Procedure: " + loc_oErro.Procedure, ;
1255:                     "Erro em FormSigOpNch.CelulaChequeValid")
1256:         ENDTRY
1257: 
1258:         RETURN loc_uRetorno
1259:     ENDPROC
1260: 
1261:     *--------------------------------------------------------------------------
1262:     * FormParaBO - transfere para o BO o que esta na TELA.
1263:     *
1264:     * A superficie editavel desta tela eh UMA so: a celula "Proximo Chq." da
1265:     * linha corrente da grade. Entao o mapeamento eh a linha corrente de
1266:     * cursor_4c_Cheques (identidade da conta: FPags / Bancos / Agencias /
1267:     * NContas) MAIS o numero que esta na celula.
1268:     *
1269:     * A identidade vem de BO.CarregarChequeDoCursor, que ja monta a chave
1270:     * POSICIONAL de 25 (regra #42) e deriva this_nConteudo - fonte unica, a
1271:     * mesma que o Confirmar usa. O que este metodo acrescenta eh o valor
1272:     * DIGITADO: durante o Valid ele ainda nao chegou ao cursor (o ControlSource
1273:     * so grava depois), entao a celula PREVALECE sobre a coluna quando ela eh
1274:     * passada. Chamado sem a celula, fica valendo o que o cursor tem - que eh o
1275:     * estado ja confirmado da linha.
1276:     *
1277:     * NAO existem aqui os dezenas de campos de um FormParaBO de cadastro: o
1278:     * SCX nao declara TextBox/ComboBox/CheckBox nenhum fora da grade. Inventar
1279:     * campos para a tela "parecer" um CRUD violaria o PILAR 1.
1280:     *
1281:     * PROTECTED, e nao PUBLIC: FormBase declara este hook PROTECTED, e em VFP9
1282:     * o override NAO alarga o escopo - o metodo fica protegido mesmo escrito sem
1283:     * modificador (regra #51). Declarado assim explicitamente para o codigo
1284:     * dizer a verdade sobre o proprio escopo. O unico chamador eh o Valid da
1285:     * celula, que roda DENTRO da classe, entao nada quebra; um harness que
1286:     * precise exercita-lo tem de subclassar o form, como ja fazem os probes.
1287:     *--------------------------------------------------------------------------
1288:     PROTECTED PROCEDURE FormParaBO(par_oTxt)
1289:         LOCAL loc_lSucesso, loc_cCursor, loc_oBO, loc_oErro
1290: 
1291:         loc_lSucesso = .F.
1292: 
1293:         TRY
1294:             loc_oBO = THIS.this_oBusinessObject
1295: 
1296:             IF VARTYPE(loc_oBO) = "O"
1297:                 loc_cCursor = loc_oBO.this_cCursorCheques
1298: 
1299:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1300:                     *-- identidade da conta + numero JA gravado na linha
1301:                     loc_lSucesso = loc_oBO.CarregarChequeDoCursor(loc_cCursor)
1302: 
1303:                     IF loc_lSucesso AND VARTYPE(par_oTxt) = "O"
1304:                         IF VARTYPE(par_oTxt.Value) = "N"
1305:                             loc_oBO.this_nProxCheque = par_oTxt.Value
1306: 
1307:                             *-- SigSySeq.conteudo = ULTIMO emitido = proximo - 1
1308:                             *-- (a mesma derivacao de CarregarChequeDoCursor,
1309:                             *-- refeita porque o numero acabou de mudar)
1310:                             loc_oBO.this_nConteudo = par_oTxt.Value - 1
1311:                         ENDIF
1312:                     ENDIF
1313:                 ENDIF
1314:             ENDIF
1315: 
1316:         CATCH TO loc_oErro
1317:             THIS.this_cMensagemErro = loc_oErro.Message
1318:             MsgErro(loc_oErro.Message + CHR(13) + ;
1319:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1320:                     "Procedure: " + loc_oErro.Procedure, ;
1321:                     "Erro em FormSigOpNch.FormParaBO")
1322:         ENDTRY
1323: 
1324:         RETURN loc_lSucesso
1325:     ENDPROC
1326: 
1327:     *--------------------------------------------------------------------------
1328:     * BOParaForm - espelha na TELA o que esta no BO.
1329:     *
1330:     * Reciproco de FormParaBO, e com a mesma superficie unica: escreve
1331:     * this_nProxCheque na celula "Proximo Chq.". Eh o
1332:     * "This.Value = Thisform.nAntChqVal" do Valid legado, com uma diferenca de
1333:     * ARQUITETURA e nenhuma de comportamento: quem guarda o numero eh o BO, e a
1334:     * tela so espelha (PILAR 3) - o form nao mantem regra propria.
1335:     *
1336:     * NAO toca no cursor de proposito. O unico chamador real eh o caminho de
1337:     * recusa do Valid, onde o cursor AINDA tem o valor antigo e correto: o
1338:     * ControlSource so grava depois de um Valid que passe, e eh exatamente esse
1339:     * que esta sendo recusado. Escrever no cursor aqui gravaria o mesmo valor
1340:     * por dois caminhos diferentes.
1341:     *
1342:     * A celula pode vir por parametro (o caminho do Valid, que ja a tem em
1343:     * maos) ou ser resolvida na Column5 - assim o metodo tambem funciona
1344:     * chamado de fora, sem argumento. A resolucao eh guardada por PEMSTATUS
1345:     * porque a celula so existe depois de InstalarCelulaCheque, e esse so roda
1346:     * quando a grade tem cursor.
1347:     *
1348:     * PROTECTED pelo mesmo motivo do irmao: o hook eh PROTECTED em FormBase e o
1349:     * override nao alarga o escopo (regra #51).
1350:     *--------------------------------------------------------------------------
1351:     PROTECTED PROCEDURE BOParaForm(par_oTxt)
1352:         LOCAL loc_lSucesso, loc_oBO, loc_oCelula, loc_oColuna, loc_oErro
1353: 
1354:         loc_lSucesso = .F.
1355: 
1356:         TRY
1357:             loc_oBO     = THIS.this_oBusinessObject
1358:             loc_oCelula = .NULL.
1359: 
1360:             IF VARTYPE(par_oTxt) = "O"
1361:                 loc_oCelula = par_oTxt
1362:             ELSE
1363:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND ;
1364:                    THIS.grd_4c_Dados.ColumnCount >= 5
1365: 
1366:                     loc_oColuna = THIS.grd_4c_Dados.Columns(5)
1367: 
1368:                     IF PEMSTATUS(loc_oColuna, "txt_4c_Celula", 5)
1369:                         loc_oCelula = loc_oColuna.txt_4c_Celula
1370:                     ENDIF
1371:                 ENDIF
1372:             ENDIF
1373: 
1374:             IF VARTYPE(loc_oBO) = "O" AND VARTYPE(loc_oCelula) = "O"
1375:                 loc_oCelula.Value = loc_oBO.this_nProxCheque
1376:                 loc_lSucesso = .T.
1377:             ENDIF
1378: 
1379:         CATCH TO loc_oErro
1380:             THIS.this_cMensagemErro = loc_oErro.Message
1381:             MsgErro(loc_oErro.Message + CHR(13) + ;
1382:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1383:                     "Procedure: " + loc_oErro.Procedure, ;
1384:                     "Erro em FormSigOpNch.BOParaForm")
1385:         ENDTRY
1386: 
1387:         RETURN loc_lSucesso
1388:     ENDPROC
1389: 
1390:     *--------------------------------------------------------------------------
1391:     * BtnCancelarClick - a MESMA acao de BtnEncerrarClick, e de proposito o
1392:     * mesmo corpo em um funil so.
1393:     *
1394:     * O objeto do legado chama-se "btnCancelar" e seu Click eh uma linha so
1395:     * (ThisForm.Release); o Caption que o usuario le eh "Encerrar", e eh dele
1396:     * que sai o nome canonico do projeto para esse botao - cmd_4c_Encerrar /
1397:     * BtnEncerrarClick (regra #10). Os dois nomes descrevem corretamente a
1398:     * mesma acao: abandonar sem gravar. Diferente do irmao btnAlterar, cujo
1399:     * nome MENTE (ele grava, e por isso virou Confirmar), aqui nao ha
1400:     * ambiguidade a desfazer.
1401:     *
1402:     * Mantidos os DOIS nomes, com UM corpo: BtnEncerrarClick eh o que o
1403:     * BINDEVENT liga ao botao - seguir o Caption eh o que o projeto padroniza -
1404:     * e este eh o nome pelo qual o Click de SIGOPNCH.btnCancelar eh procurado
1405:     * por quem vem do legado. Duplicar a linha nos dois, em vez de encadear,
1406:     * criaria duas versoes para divergir no primeiro ajuste.
1407:     *
1408:     * PUBLIC (sem PROTECTED): eh ponto de entrada chamado de fora da classe
1409:     * (regras #3 e #51).
1410:     *--------------------------------------------------------------------------
1411:     PROCEDURE BtnCancelarClick()
1412:         THIS.BtnEncerrarClick()
1413:     ENDPROC
1414: 
1415:     *--------------------------------------------------------------------------
1416:     * Activate - da o foco inicial a coluna digitavel, uma UNICA vez.
1417:     *
1418:     * Legado, ultima linha do Init: "With ThisForm.Grade / .Refresh /
1419:     * .Column5.SetFocus / EndWith" - a tela abre com o cursor piscando na
1420:     * coluna do proximo cheque, a unica digitavel. Esse SetFocus nao pode
1421:     * ficar em InicializarForm, que roda ANTES do Show: o VFP recusa foco em
1422:     * controle de form que ainda nao apareceu. No Activate o form ja esta
1423:     * visivel, e this_lFocoInicialDado faz o foco ser dado so na PRIMEIRA
1424:     * ativacao - sem a flag, cada volta de foco a tela (ao dispensar um
1425:     * dialogo, por exemplo) arrancaria o cursor do usuario de onde ele
1426:     * estava e o jogaria de volta na coluna 5.
1427:     *
1428:     * Tres guardas, nenhuma decorativa: PEMSTATUS porque o Activate pode
1429:     * disparar com a montagem incompleta se o InicializarForm tiver falhado;
1430:     * ColumnCount >= 5 porque um rebind futuro poderia reduzir a grade; e
1431:     * !EOF porque SetFocus em grade SEM LINHA nao tem celula onde pousar.
1432:     * Com as guardas no lugar nao ha excecao a capturar - e por isso nao ha
1433:     * TRY/CATCH aqui: um CATCH neste ponto jogaria um dialogo de erro em
1434:     * cima da tela recem-aberta por causa de um detalhe de foco.
1435:     *
1436:     * DODEFAULT() na PRIMEIRA linha: o comportamento padrao de Activate tem
1437:     * de acontecer antes de mexer no foco.
1438:     *--------------------------------------------------------------------------
1439:     PROCEDURE Activate()
1440:         LOCAL loc_cCursor
1441: 
1442:         DODEFAULT()
1443: 
1444:         IF !THIS.this_lFocoInicialDado AND PEMSTATUS(THIS, "grd_4c_Dados", 5)
1445:             THIS.this_lFocoInicialDado = .T.
1446: 
1447:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorCheques
1448: 
1449:             IF THIS.grd_4c_Dados.Visible AND THIS.grd_4c_Dados.ColumnCount >= 5 ;
1450:                     AND USED(loc_cCursor) AND !EOF(loc_cCursor)
1451:                 THIS.grd_4c_Dados.Column5.SetFocus()
1452:             ENDIF
1453:         ENDIF
1454:     ENDPROC
1455: 
1456:     *--------------------------------------------------------------------------
1457:     * Destroy - libera o BO (que fecha no proprio Destroy os cursores que
1458:     * abriu) e delega ao FormBase.
1459:     *
1460:     * DODEFAULT() na ULTIMA linha eh obrigatorio: FormBase.Destroy reconstroi
1461:     * os popups do menu principal, e sem ele o menu do sistema aparece
1462:     * encolhido depois de fechar esta tela (Pattern #145).
1463:     *--------------------------------------------------------------------------
1464:     PROCEDURE Destroy()
1465:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1466:             THIS.this_oBusinessObject = .NULL.
1467:         ENDIF
1468: 
1469:         DODEFAULT()
1470:     ENDPROC
1471: 
1472: ENDDEFINE
1473: 
1474: 
1475: *==============================================================================
1476: * TextBoxChequeSigOpNch_4c - a celula COM EVENTO da Column5 (Proximo Chq.)
1477: *
1478: * Transcreve os DOIS metodos que o legado pendura em
1479: * SIGOPNCH.Grade.Column5.Text1 - e so nessa celula: as outras quatro colunas
1480: * tem apenas "When / Return .f.", que eh recusa de foco ja reproduzida pelo
1481: * ReadOnly da coluna, sem metodo a portar.
1482: *
1483: * POR QUE SUBCLASSE E NAO BINDEVENT: BINDEVENT em evento de TextBox dentro de
1484: * Column nao dispara de forma confiavel no VFP9 - eh a razao de existir
1485: * classes\TextBoxGridLookup.prg, que documenta isso no proprio cabecalho. O
1486: * caminho canonico do projeto (regra #46, referencia FormLpr) eh um TextBox
1487: * subclasse com o evento EMBUTIDO delegando a metodo PUBLIC do form.
1488: *
1489: * Os dois metodos sao finos de proposito: so delegam. A regra de negocio
1490: * (validar o numero, restaurar o anterior, marcar a linha) mora no form e no
1491: * BO, nunca na classe do controle - assim o mesmo comportamento continua
1492: * alcancavel pelo harness de teste, que nao tem como simular digitacao.
1493: *
1494: * O guard PEMSTATUS existe porque esta classe eh instalada por AddObject numa
1495: * Column: se um rebind futuro recriar a coluna enquanto o form esta sendo
1496: * liberado, THISFORM pode ja nao ter os metodos - sem o guard, o Valid
1497: * estouraria "Property ... is not found" em cima de uma tela que esta
1498: * fechando.
1499: *
1500: * O Valid devolve o que o form devolver, SEM normalizar para logico: o legado
1501: * devolve 0 (numerico) para PRENDER o foco na celula quando o numero eh
1502: * invalido, e converter esse 0 em .F. mudaria o comportamento - em VFP9 o
1503: * .F. tambem retem o foco, mas descarta a diferenca semantica e, sobretudo,
1504: * faria o retorno deixar de ser transcricao.
1505: *==============================================================================
1506: DEFINE CLASS TextBoxChequeSigOpNch_4c AS TextBox
1507: 
1508:     *-- Legado: PROCEDURE When / Thisform.nAntChqVal = This.Value / Return(.T.)
1509:     PROCEDURE When()
1510:         LOCAL loc_lRetorno
1511: 
1512:         loc_lRetorno = .T.
1513: 
1514:         IF PEMSTATUS(THISFORM, "CelulaChequeWhen", 5)
1515:             loc_lRetorno = THISFORM.CelulaChequeWhen(THIS)
1516:         ENDIF
1517: 
1518:         RETURN loc_lRetorno
1519:     ENDPROC
1520: 
1521:     *-- Legado: PROCEDURE Valid (ver FormSigOpNch.CelulaChequeValid)
1522:     PROCEDURE Valid()
1523:         LOCAL loc_uRetorno
1524: 
1525:         loc_uRetorno = .T.
1526: 
1527:         IF PEMSTATUS(THISFORM, "CelulaChequeValid", 5)
1528:             loc_uRetorno = THISFORM.CelulaChequeValid(THIS)
1529:         ENDIF
1530: 
1531:         RETURN loc_uRetorno
1532:     ENDPROC
1533: 
1534: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpNchBO.prg):
*==============================================================================
* SigOpNchBO.prg - Business Object para SigOpNch (Numeracao de Cheques)
*
* Form OPERACIONAL (SIGOPNCH.SCX, Caption "Numeracao de Cheques"). Nao eh
* cadastro CRUD: lista, numa unica grade editavel, todas as formas de
* pagamento (SigOpFp) do tipo cheque com conta bancaria configurada, mostra
* o PROXIMO numero de cheque de cada conta e grava apenas as linhas que o
* usuario alterou.
*
* Fluxo do legado (reproduzir em fases seguintes):
*   Init do form -> para cada linha de SigOpFp com Infos = 'C' And
*     EmiChqs = 1 And Bancos/Agencias/NContas preenchidos:
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza (SigSySeq) For valor = lcChave
*         achou  -> csCheques.Cheques = crAutoriza.Conteudo + 1
*         nao achou -> csCheques.Cheques = 1
*   btnAlterar.Click (Confirmar) -> Scan csCheques For Marcas (linhas
*     tocadas pelo usuario no Valid da coluna 5):
*       lcChave = PADR(Bancos + Agencias + NContas, 25)
*       Locate em crAutoriza For valor = lcChave
*         achou     -> Replace Conteudo With Cheques - 1
*         nao achou -> Insert Into crAutoriza (Valor, Conteudo) Values
*                      (lcChave, Cheques - 1)
*     Grava tudo numa UNICA transacao (UpDate/Commit/RollBack do poDataMgr).
*
* Tabelas (nomes/colunas conferidos em docs/schema.sql - UTF-16, Get-Content
* -Raw, regra #14 do CLAUDE.md):
*   SigSySeq  valor char(25) PK, conteudo numeric(13,0), digchecks
*             numeric(1,0) NOT NULL. Guarda o ULTIMO numero de cheque
*             emitido (gravado = proximo numero - 1), chave por conta
*             bancaria. digchecks nao aparece em nenhum lugar do codigo
*             legado (nem Init, nem Click) - o Insert do legado so grava
*             Valor/Conteudo porque o cursor crAutoriza (AddCursor) ja tem
*             0 como valor de buffer para a coluna; a Fase 2 precisa gravar
*             esse 0 explicitamente no INSERT para nao violar o NOT NULL.
*   SigOpFp   fpags char(12) PK, bancos char(3), agencias char(4),
*             ncontas char(10), infos char(1), emichqs numeric(1,0).
*             infos = 'C' identifica forma de pagamento tipo Cheque.
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao real (Fase 2) sera um metodo proprio que resolve,
* por chave, update-ou-insert em SigSySeq para cada linha alterada da
* grade - por isso this_cTabela/this_cCampoChave apontam para SigSySeq.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNchBO AS BusinessBase

    *==========================================================================
    * Linha corrente de SigSySeq (crAutoriza no legado) - sequencia generica
    * de "proximo numero". Aqui guarda o ULTIMO cheque emitido por conta
    * bancaria (proximo numero exibido na grade = this_nConteudo + 1).
    *==========================================================================
    this_cValor     = ""   && SigSySeq.valor     char(25) PK - PADR(Bancos+Agencias+NContas,25)
    this_nConteudo  = 0    && SigSySeq.conteudo  numeric(13,0) - ultimo cheque emitido
    this_nDigChecks = 0    && SigSySeq.digchecks numeric(1,0) - nao exibido na tela; grava 0 (default do cursor legado)

    *==========================================================================
    * Linha corrente de SigOpFp (forma de pagamento associada a conta
    * bancaria) - usada para montar a chave acima e exibir Bco./Agencia/Conta
    *==========================================================================
    this_cFPags    = ""    && SigOpFp.fpags    char(12) - codigo da forma de pagamento
    this_cBancos   = ""    && SigOpFp.bancos   char(3)
    this_cAgencias = ""    && SigOpFp.agencias char(4)
    this_cNContas  = ""    && SigOpFp.ncontas  char(10)

    *==========================================================================
    * Proximo numero de cheque editado na grade (csCheques.Cheques no
    * legado) - valor exibido/editado pelo usuario antes de Confirmar.
    * Gravado em SigSySeq.conteudo como this_nProxCheque - 1.
    *==========================================================================
    this_nProxCheque = 0

    *==========================================================================
    * Nomes de cursor usados pelo form (mantidos como property para o Form
    * nao repetir literais - mesmo padrao de SigOpLimBO)
    *==========================================================================
    this_cCursorFormasPagto = "cursor_4c_FormasPagto"  && SigOpFp filtradas (Infos='C' And EmiChqs=1, com conta bancaria)
    this_cCursorAutoriza    = "cursor_4c_Autoriza"     && SigSySeq (crAutoriza no legado)
    this_cCursorCheques     = "cursor_4c_Cheques"      && csCheques no legado - grade editavel (FPags/Bancos/Agencias/NContas/Cheques/Marcas)

    *==========================================================================
    * Init - Configura tabela/chave principal (SigSySeq / crAutoriza)
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela principal gravada por este BO: sequencia de proximo
            *-- numero de cheque por conta bancaria (crAutoriza no legado)
            THIS.this_cTabela     = "SigSySeq"
            THIS.this_cCampoChave = "valor"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNchBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarChaveConta - Monta a chave POSICIONAL de SigSySeq.valor char(25)
    *
    * Legado (Init e btnAlterar.Click, as DUAS montagens identicas):
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *
    * A chave eh POSICIONAL (regra #42 do CLAUDE.md): o padding de cada coluna
    * char FAZ PARTE da chave. No legado o padding vem de graca porque os
    * valores sao lidos CRUS do cursor (bancos char(3), agencias char(4),
    * ncontas char(10) - todos NOT NULL no schema, logo sempre na largura
    * cheia). Aqui as partes podem chegar de property/parametro JA com ALLTRIM,
    * entao o PADR de cada parte eh OBRIGATORIO - sem ele a chave encurta, o
    * WHERE nao casa e o UPDATE roda SEM ERRO afetando ZERO linha.
    *
    * CONFERENCIA de largura: 3 + 4 + 10 = 17, completado com PADR ate 25 =
    * exatamente a largura de SigSySeq.valor char(25).
    *==========================================================================
    PROCEDURE MontarChaveConta(par_cBancos, par_cAgencias, par_cNContas)
        LOCAL loc_cChave

        loc_cChave = PADR(IIF(VARTYPE(par_cBancos)   = "C", par_cBancos,   ""),  3) + ;
                     PADR(IIF(VARTYPE(par_cAgencias) = "C", par_cAgencias, ""),  4) + ;
                     PADR(IIF(VARTYPE(par_cNContas)  = "C", par_cNContas,  ""), 10)

        RETURN PADR(loc_cChave, 25)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigSySeq (crAutoriza no
    * legado) nas properties deste BO. Mapeia TODAS as colunas da tabela:
    * valor char(25), conteudo numeric(13,0), digchecks numeric(1,0).
    *
    * this_nProxCheque eh derivado aqui pela MESMA conta do Init legado
    * ("crAutoriza.Conteudo + 1"): SigSySeq guarda o ULTIMO cheque emitido e
    * a grade exibe o PROXIMO.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cValor     = TratarNulo(valor, "")
                THIS.this_nConteudo  = TratarNulo(conteudo, 0)
                THIS.this_nDigChecks = TratarNulo(digchecks, 0)

                *-- Legado: Insert ... Values (..., crAutoriza.Conteudo + 1)
                THIS.this_nProxCheque = THIS.this_nConteudo + 1

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarChequeDoCursor - Carrega a linha corrente da GRADE
    * (cursor_4c_Cheques / csCheques no legado) nas properties, resolvendo a
    * chave de SigSySeq e o conteudo a gravar.
    *
    * Legado (btnAlterar.Click):
    *   lcChave  = PADR(csCheques.Bancos + csCheques.Agencias + csCheques.NContas, 25)
    *   Conteudo = csCheques.Cheques - 1
    *
    * As colunas sao lidas CRUAS (sem ALLTRIM) justamente porque alimentam a
    * chave posicional - ver MontarChaveConta.
    *==========================================================================
    PROCEDURE CarregarChequeDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cFPags    = TratarNulo(FPags, "")
                THIS.this_cBancos   = TratarNulo(Bancos, "")
                THIS.this_cAgencias = TratarNulo(Agencias, "")
                THIS.this_cNContas  = TratarNulo(NContas, "")

                THIS.this_nProxCheque = TratarNulo(Cheques, 0)

                THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                         THIS.this_cAgencias, ;
                                                         THIS.this_cNContas)

                *-- SigSySeq.conteudo = ULTIMO cheque emitido = proximo - 1
                THIS.this_nConteudo = THIS.this_nProxCheque - 1

                *-- digchecks nao aparece em NENHUM ponto do codigo legado (nem
                *-- no Init, nem no Click). O "Insert Into crAutoriza (Valor,
                *-- Conteudo)" grava 0 ali porque esse eh o valor de buffer do
                *-- cursor criado pelo AddCursor; como a coluna eh NOT NULL sem
                *-- DEFAULT, este BO grava o mesmo 0 EXPLICITAMENTE (regra #22).
                THIS.this_nDigChecks = 0

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave de SigSySeq usada na auditoria
    *
    * ALLTRIM aqui eh INOFENSIVO e proposital: a chave JA esta montada (o
    * padding INTERIOR esta preservado) e este retorno so alimenta
    * LogAuditoria.ChaveRegistro - nunca volta a ser usado em WHERE.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cValor)
    ENDPROC

    *==========================================================================
    * ValidarNumeroCheque - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value < 0
    *       MessageBox('Numero do Cheque Invalido.', 48, '')
    *       This.Value = Thisform.nAntChqVal
    *       Return 0
    *   EndIf
    *
    * So devolve o veredito; quem exibe a mensagem e restaura o valor anterior
    * eh o Form (que eh quem guarda o nAntChqVal). NAO ha limite SUPERIOR no
    * legado - a largura N(6) do cursor da grade eh que limita, e inventar um
    * teto aqui violaria o PILAR 1.
    *==========================================================================
    PROCEDURE ValidarNumeroCheque(par_nValor)
        LOCAL loc_lValido

        loc_lValido = .T.

        IF VARTYPE(par_nValor) != "N"
            loc_lValido = .F.
        ELSE
            IF par_nValor < 0
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF !loc_lValido
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                      CHR(225) + "lido."
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * ValidarDados - Chamado por BusinessBase.Salvar() e por GravarNumeracao
    * antes de incluir cada linha no lote.
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido

        loc_lValido = .F.
        THIS.this_cMensagemErro = ""

        DO CASE
            CASE EMPTY(THIS.this_cValor)
                THIS.this_cMensagemErro = "Conta banc" + CHR(225) + "ria n" + ;
                    CHR(227) + "o identificada (Banco / Ag" + CHR(234) + ;
                    "ncia / Conta)."

            CASE !THIS.ValidarNumeroCheque(THIS.this_nProxCheque)
                *-- ValidarNumeroCheque ja preencheu this_cMensagemErro

            CASE THIS.this_nConteudo < 0
                THIS.this_cMensagemErro = "N" + CHR(250) + "mero do Cheque Inv" + ;
                                          CHR(225) + "lido."

            OTHERWISE
                loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * MontarInsertSequencia / MontarUpdateSequencia
    *
    * FONTE UNICA do SQL de gravacao de SigSySeq: Inserir()/Atualizar() usam
    * esses textos para o caminho de UMA linha, e GravarNumeracao() usa os
    * MESMOS textos para montar o lote atomico de varias linhas. Sem a fonte
    * unica os dois caminhos divergiriam em silencio.
    *
    * SigSySeq tem TRES colunas e TODAS sao NOT NULL sem DEFAULT (conferido em
    * docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
    * valor, conteudo, digchecks. O INSERT cobre as tres - omitir digchecks
    * faria o SQL Server recusar a inclusao inteira (regra #22).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertSequencia()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigSySeq (valor, conteudo, digchecks) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cValor, 25)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nDigChecks, 0) + ")"

        RETURN loc_cSQL
    ENDPROC

    PROTECTED PROCEDURE MontarUpdateSequencia()
        LOCAL loc_cSQL

        *-- Legado (btnAlterar.Click): "Replace Conteudo With csCheques.Cheques - 1"
        *-- - so o conteudo muda; digchecks eh preservado no registro existente.
        loc_cSQL = "UPDATE SigSySeq SET conteudo = " + ;
                   FormatarNumeroSQL(THIS.this_nConteudo, 0) + ;
                   " WHERE valor = " + EscaparSQL(LEFT(THIS.this_cValor, 25))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UMA sequencia em SigSySeq (caminho BusinessBase.Salvar)
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarInsertSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE de UMA sequencia em SigSySeq
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                loc_cSQL = THIS.MontarUpdateSequencia()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o dos Dados do Cadastro de Opera" + CHR(231) + CHR(245) + ;
                        "es." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarFormasPagtoCheque - Popula this_cCursorFormasPagto (crSigOpFp)
    *
    * Legado: .AddCursor('SigOpFp','FPags','crSigOpFp','FPags',.f.) + Requery
    * (traz SigOpFp inteira, ordenada por FPags) e o Scan do Init descarta
    * tudo que nao casa com:
    *   Infos = 'C' And EmiChqs = 1 And Not IsEmpty(Bancos) And
    *   Not IsEmpty(Agencias) And Not IsEmpty(NContas)
    *
    * O filtro vai para o WHERE (resultado identico, sem trafegar a tabela
    * inteira). Nomes de coluna conferidos em docs/schema.sql: fpags char(12),
    * bancos char(3), agencias char(4), ncontas char(10), infos char(1),
    * emichqs numeric(1,0).
    *
    * NAO ha filtro por empresa: o legado nao filtra (AddCursor sem query) e
    * inventar um WHERE emps mudaria o conteudo da grade (PILAR 1).
    *==========================================================================
    PROCEDURE CarregarFormasPagtoCheque()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorFormasPagto)
                    USE IN (THIS.this_cCursorFormasPagto)
                ENDIF

                loc_cSQL = "SELECT fpags, bancos, agencias, ncontas" + ;
                           " FROM SigOpFp" + ;
                           " WHERE infos = 'C'" + ;
                           "   AND emichqs = 1" + ;
                           "   AND RTRIM(bancos) <> ''" + ;
                           "   AND RTRIM(agencias) <> ''" + ;
                           "   AND RTRIM(ncontas) <> ''" + ;
                           " ORDER BY fpags"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorFormasPagto)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorFormasPagto)
                    THIS.this_cMensagemErro = "Erro ao carregar as Formas de " + ;
                        "Pagamento." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorFormasPagto)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarFormasPagtoCheque")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarAutoriza - Popula this_cCursorAutoriza (crAutoriza no legado)
    * com SigSySeq. Legado:
    *   .AddCursor('SigSySeq','Valor','crAutoriza','Valor',.f.) + Requery
    *
    * Traz as TRES colunas da tabela (valor/conteudo/digchecks) para que o
    * LOCATE do Init legado e a conferencia de existencia funcionem sem ida
    * extra ao banco.
    *==========================================================================
    PROCEDURE CarregarAutoriza()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF USED(THIS.this_cCursorAutoriza)
                    USE IN (THIS.this_cCursorAutoriza)
                ENDIF

                loc_cSQL = "SELECT valor, conteudo, digchecks" + ;
                           " FROM SigSySeq" + ;
                           " ORDER BY valor"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorAutoriza)

                IF loc_nResultado < 0 OR !USED(THIS.this_cCursorAutoriza)
                    THIS.this_cMensagemErro = "Erro ao carregar a numera" + CHR(231) + ;
                        CHR(227) + "o de cheques." + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    SELECT (THIS.this_cCursorAutoriza)
                    GO TOP
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CarregarAutoriza")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * LocalizarSequencia - Legado (Init e Click, as duas vezes igual):
    *   Select crAutoriza
    *   LOCATE FOR valor = lcChave
    *   IF ! EOF() ...
    *
    * Deixa o cursor POSICIONADO na linha achada (o legado le
    * crAutoriza.Conteudo logo depois) e devolve .T./.F.
    *
    * Compara com "==" sobre as DUAS pontas padronizadas em 25 chars, nunca
    * com "=": o "=" depende de SET EXACT, e a datasession privada do form
    * (DataSession = 2) reseta os SETs para o default do VFP - o LOCATE do
    * legado casava por um comportamento de SET que aqui nao esta garantido.
    *==========================================================================
    PROCEDURE LocalizarSequencia(par_cChave)
        LOCAL loc_lAchou, loc_cChave

        loc_lAchou = .F.

        IF VARTYPE(par_cChave) = "C" AND USED(THIS.this_cCursorAutoriza)
            loc_cChave = PADR(par_cChave, 25)

            SELECT (THIS.this_cCursorAutoriza)
            LOCATE FOR PADR(valor, 25) == loc_cChave

            loc_lAchou = !EOF()
        ENDIF

        RETURN loc_lAchou
    ENDPROC

    *==========================================================================
    * CriarCursorCheques - Cria o cursor da GRADE (csCheques no legado)
    *
    * Legado (PROCEDURE Load):
    *   Create Cursor csCheques ( FPags C(12), Bancos C(3), Agencias C(4),
    *                             NContas C(10), Cheques N(6), Marcas L(1) )
    *   Index On Fpags Tag FPags
    *
    * Esta eh a UNICA criacao do cursor no projeto (a recarga em MontarCheques
    * usa ZAP, nao CREATE) - assim a ordem/largura das colunas nao tem como
    * divergir entre dois pontos, e o RecordSource/ControlSource do Grid nao eh
    * destruido a cada carga.
    *
    * Idempotente: se o cursor ja existe, nao recria.
    *==========================================================================
    PROCEDURE CriarCursorCheques()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCheques)
                loc_lSucesso = .T.
            ELSE
                CREATE CURSOR (THIS.this_cCursorCheques) ( ;
                    FPags    C(12), ;
                    Bancos   C(3),  ;
                    Agencias C(4),  ;
                    NContas  C(10), ;
                    Cheques  N(6),  ;
                    Marcas   L(1))

                SELECT (THIS.this_cCursorCheques)
                INDEX ON FPags TAG FPags

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.CriarCursorCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarCheques - Reproduz o Scan do Init legado: para cada forma de
    * pagamento tipo cheque com conta bancaria, insere na grade o PROXIMO
    * numero de cheque.
    *
    *   lcChave = PADR(Bancos + Agencias + NContas, 25)
    *   Locate em crAutoriza For valor = lcChave
    *     achou     -> Cheques = crAutoriza.Conteudo + 1
    *     nao achou -> Cheques = 1
    *
    * Marcas nasce .F.: so o Valid da coluna 5 marca a linha, e o Confirmar
    * grava APENAS as marcadas.
    *
    * O ZAP vai GUARDADO por SET SAFETY: SAFETY eh escopado por data session e
    * o form eh DataSession = 2, onde ele volta a valer ON mesmo com o
    * SET SAFETY OFF do main.prg - com SAFETY ON o ZAP abre um dialogo modal
    * que ninguem ve e CONGELA a tela.
    *==========================================================================
    PROCEDURE MontarCheques()
        LOCAL loc_lSucesso, loc_cSafety, loc_nProx, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF !THIS.CriarCursorCheques()
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel preparar a grade de cheques."
            ELSE
                loc_cSafety = SET("SAFETY")
                SET SAFETY OFF
                SELECT (THIS.this_cCursorCheques)
                ZAP
                IF loc_cSafety = "ON"
                    SET SAFETY ON
                ENDIF

                IF USED(THIS.this_cCursorFormasPagto)
                    SELECT (THIS.this_cCursorFormasPagto)
                    SCAN
                        *-- Valores lidos CRUS - alimentam a chave posicional
                        THIS.this_cFPags    = TratarNulo(fpags, "")
                        THIS.this_cBancos   = TratarNulo(bancos, "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas, "")

                        THIS.this_cValor = THIS.MontarChaveConta(THIS.this_cBancos, ;
                                                                 THIS.this_cAgencias, ;
                                                                 THIS.this_cNContas)

                        IF THIS.LocalizarSequencia(THIS.this_cValor)
                            SELECT (THIS.this_cCursorAutoriza)
                            loc_nProx = TratarNulo(conteudo, 0) + 1
                        ELSE
                            loc_nProx = 1
                        ENDIF

                        INSERT INTO (THIS.this_cCursorCheques) ;
                            (FPags, Bancos, Agencias, NContas, Cheques, Marcas) ;
                            VALUES (THIS.this_cFPags, THIS.this_cBancos, ;
                                    THIS.this_cAgencias, THIS.this_cNContas, ;
                                    loc_nProx, .F.)

                        SELECT (THIS.this_cCursorFormasPagto)
                    ENDSCAN
                ENDIF

                *-- Legado: "Select csCheques / Go Top" antes do Grade.Refresh
                SELECT (THIS.this_cCursorCheques)
                GO TOP

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.MontarCheques")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDados - Funil UNICO de carga: formas de pagamento + sequencias +
    * montagem da grade. Equivale ao bloco de Requery/Scan do Init legado.
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.CarregarFormasPagtoCheque()
            IF THIS.CarregarAutoriza()
                loc_lSucesso = THIS.MontarCheques()
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MarcarChequeAlterado - Legado: SIGOPNCH.Grade.Column5.Text1.Valid
    *
    *   If This.Value # Thisform.nAntChqVal
    *       Select csCheques
    *       Replace csCheques.Marcas With .T.
    *   EndIf
    *
    * Marca a linha CORRENTE da grade. O Replace do legado roda sobre o
    * registro corrente de csCheques, nao sobre todos.
    *==========================================================================
    PROCEDURE MarcarChequeAlterado(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor

        loc_lSucesso = .F.
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)

            IF !EOF()
                REPLACE Marcas WITH .T. IN (loc_cCursor)
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarChequesAlterados - Quantas linhas da grade o usuario tocou
    * (o "Scan For Marcas" do legado com o "If !IsEmpty(csCheques.Cheques)"
    * que descarta numero zerado; Cheques eh N(6), logo IsEmpty equivale a = 0).
    *
    * Repoe o RECNO no fim: SCAN move o ponteiro e quem chama costuma estar no
    * meio da propria navegacao da grade.
    *==========================================================================
    PROCEDURE ContarChequesAlterados(par_cCursorCheques)
        LOCAL loc_cCursor, loc_nTotal, loc_nRecno

        loc_nTotal = 0
        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        IF USED(loc_cCursor)
            SELECT (loc_cCursor)
            loc_nRecno = IIF(EOF(), 0, RECNO())

            SCAN FOR Marcas AND Cheques <> 0
                loc_nTotal = loc_nTotal + 1
            ENDSCAN

            IF loc_nRecno > 0 AND loc_nRecno <= RECCOUNT(loc_cCursor)
                GO (loc_nRecno) IN (loc_cCursor)
            ELSE
                GO TOP IN (loc_cCursor)
            ENDIF
        ENDIF

        RETURN loc_nTotal
    ENDPROC

    *==========================================================================
    * GravarNumeracao - Legado: SIGOPNCH.btnAlterar.Click
    *
    *   Scan For Marcas
    *       If !IsEmpty(csCheques.Cheques)
    *           lcChave = PADR(Bancos + Agencias + NContas, 25)
    *           Locate em crAutoriza For valor = lcChave
    *             achou     -> Replace Conteudo With csCheques.Cheques - 1
    *             nao achou -> Insert Into crAutoriza (Valor, Conteudo)
    *                          Values (lcChave, csCheques.Cheques - 1)
    *       Endif
    *   EndScan
    *   .poDataMgr.UpDate('crAutoriza') -> .Commit()   (erro -> .RollBack())
    *
    * ATOMICIDADE: o legado grava as N linhas numa UNICA transacao. Mandar
    * BEGIN/COMMIT TRANSACTION em SQLEXEC separados NAO protege nada - a
    * conexao nasce com Transactions = 2 e @@TRANCOUNT ja vale 1, entao o par
    * so ANINHA e o COMMIT nao efetiva. Por isso o lote INTEIRO vai num SQLEXEC
    * unico, com o controle de transacao em T-SQL e SAVE TRANSACTION para o
    * caso (normal) de ja haver transacao aberta. O THROW faz o erro chegar ao
    * SQLEXEC, que devolve -1 e deixa CapturarErroSQL() com a mensagem real.
    *
    * O "UPDATE ... IF @@ROWCOUNT = 0 INSERT ..." resolve no servidor o mesmo
    * update-ou-insert que o legado decidia pelo LOCATE no cursor - sem
    * depender de um cursor que pode estar desatualizado.
    *
    * O Commit() do legado eh um PASSO COM CAMINHO DE FALHA PROPRIO, nao
    * detalhe de infra (o legado o testa separadamente do UpDate): reproduzido
    * com SQLCOMMIT/SQLROLLBACK, inertes quando a conexao esta em auto-commit.
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)" - VFP9 nao faz
    * curto-circuito e chamaria o commit do mesmo jeito.
    *==========================================================================
    PROCEDURE GravarNumeracao(par_cCursorCheques)
        LOCAL loc_lSucesso, loc_cCursor, loc_cLote, loc_cStmts, loc_nLinhas, ;
              loc_nResultado, loc_lManual, loc_cErro, loc_oErro
        LOCAL ARRAY loc_aChaves[1]

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.
        loc_lManual = .F.

        loc_cCursor = IIF(VARTYPE(par_cCursorCheques) = "C" AND !EMPTY(par_cCursorCheques), ;
                          par_cCursorCheques, THIS.this_cCursorCheques)

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "Erro")
                THIS.this_lErroExibido = .T.

            ELSE
                IF !USED(loc_cCursor)
                    THIS.this_cMensagemErro = "Grade de cheques n" + CHR(227) + ;
                        "o dispon" + CHR(237) + "vel."
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
                    loc_cStmts  = ""
                    loc_nLinhas = 0

                    SELECT (loc_cCursor)
                    SCAN FOR Marcas AND Cheques <> 0
                        *-- Le a linha corrente da grade: monta a chave
                        *-- posicional e resolve conteudo = Cheques - 1
                        IF THIS.CarregarChequeDoCursor(loc_cCursor)
                            IF THIS.ValidarDados()
                                loc_nLinhas = loc_nLinhas + 1
                                DIMENSION loc_aChaves[loc_nLinhas]
                                loc_aChaves[loc_nLinhas] = THIS.this_cValor

                                loc_cStmts = loc_cStmts + ;
                                    THIS.MontarUpdateSequencia() + "; " + ;
                                    "IF @@ROWCOUNT = 0 " + ;
                                    THIS.MontarInsertSequencia() + "; "
                            ELSE
                                *-- ValidarDados preencheu this_cMensagemErro.
                                *-- Aborta o lote INTEIRO, como o RollBack do
                                *-- legado - gravar parte das linhas deixaria a
                                *-- numeracao de algumas contas certa e de
                                *-- outras nao, sem o usuario saber quais.
                                loc_nLinhas = 0
                                loc_cStmts  = ""
                                EXIT
                            ENDIF
                        ENDIF

                        SELECT (loc_cCursor)
                    ENDSCAN

                    DO CASE
                        CASE !EMPTY(THIS.this_cMensagemErro)
                            MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                            THIS.this_lErroExibido = .T.

                        CASE loc_nLinhas = 0
                            *-- Nada marcado: o legado tambem segue em frente
                            *-- (UpDate/Commit sem alteracao nenhuma) e encerra
                            *-- a tela sem reclamar. NAO inventar aviso aqui.
                            loc_lSucesso = .T.

                        OTHERWISE
                            loc_cLote = "SET NOCOUNT ON; " + ;
                                "DECLARE @nivel int = @@TRANCOUNT; " + ;
                                "IF @nivel = 0 BEGIN TRANSACTION " + ;
                                "ELSE SAVE TRANSACTION Nch4c; " + ;
                                "BEGIN TRY " + ;
                                loc_cStmts + ;
                                "IF @nivel = 0 COMMIT TRANSACTION; " + ;
                                "END TRY " + ;
                                "BEGIN CATCH " + ;
                                "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END " + ;
                                "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Nch4c; END; " + ;
                                "THROW; " + ;
                                "END CATCH"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cLote)

                            IF loc_nResultado < 0
                                loc_cErro = CapturarErroSQL()

                                IF loc_lManual
                                    = SQLROLLBACK(gnConnHandle)
                                ENDIF

                                THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + ;
                                    CHR(227) + "o dos Dados do Cadastro de Opera" + ;
                                    CHR(231) + CHR(245) + "es." + CHR(13) + loc_cErro
                                MsgErro(THIS.this_cMensagemErro, "Erro")
                                THIS.this_lErroExibido = .T.
                            ELSE
                                *-- Commit do legado (.poDataMgr.Commit())
                                loc_lSucesso = .T.

                                IF loc_lManual
                                    IF SQLCOMMIT(gnConnHandle) < 1
                                        = SQLROLLBACK(gnConnHandle)
                                        THIS.this_cMensagemErro = "Erro na Grava" + ;
                                            CHR(231) + CHR(227) + "o dos Dados do " + ;
                                            "Cadastro de Opera" + CHR(231) + CHR(245) + ;
                                            "es." + CHR(13) + CapturarErroSQL()
                                        MsgErro(THIS.this_cMensagemErro, "Erro")
                                        THIS.this_lErroExibido = .T.
                                        loc_lSucesso = .F.
                                    ENDIF
                                ENDIF

                                IF loc_lSucesso
                                    THIS.RegistrarAuditoriaLote(@loc_aChaves, loc_nLinhas)

                                    *-- O cursor de sequencias passa a divergir
                                    *-- do banco depois de gravar: recarregar
                                    *-- para um segundo Confirmar nao tentar
                                    *-- inserir chave que agora existe.
                                    THIS.CarregarAutoriza()
                                ENDIF
                            ENDIF
                    ENDCASE

                    IF USED(loc_cCursor)
                        SELECT (loc_cCursor)
                        GO TOP
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            IF loc_lManual
                = SQLROLLBACK(gnConnHandle)
            ENDIF

            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNchBO.GravarNumeracao")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * RegistrarAuditoriaLote - Grava em LogAuditoria uma linha por conta
    * bancaria afetada pelo lote de GravarNumeracao.
    *
    * Roda DEPOIS do commit, nunca dentro do lote: o lote eh montado para ser
    * atomico sobre SigSySeq e a auditoria nao pode poder derruba-lo.
    *==========================================================================
    PROTECTED PROCEDURE RegistrarAuditoriaLote(par_aChaves, par_nLinhas)
        LOCAL loc_nI, loc_cValorAnterior, loc_lResultado

        loc_lResultado = .F.

        IF VARTYPE(par_nLinhas) = "N" AND par_nLinhas > 0
            loc_cValorAnterior = THIS.this_cValor

            FOR loc_nI = 1 TO par_nLinhas
                THIS.this_cValor = par_aChaves[loc_nI]
                THIS.RegistrarAuditoria("UPDATE")
            ENDFOR

            THIS.this_cValor = loc_cValorAnterior
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * LimparDados - Zera as properties (usado por BusinessBase.NovoRegistro)
    *==========================================================================
    PROCEDURE LimparDados()
        THIS.this_cValor      = ""
        THIS.this_nConteudo   = 0
        THIS.this_nDigChecks  = 0

        THIS.this_cFPags      = ""
        THIS.this_cBancos     = ""
        THIS.this_cAgencias   = ""
        THIS.this_cNContas    = ""

        THIS.this_nProxCheque = 0

        RETURN .T.
    ENDPROC

    *==========================================================================
    * Destroy - Fecha os cursores que este BO abriu
    *==========================================================================
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorFormasPagto)
            USE IN (THIS.this_cCursorFormasPagto)
        ENDIF

        IF USED(THIS.this_cCursorAutoriza)
            USE IN (THIS.this_cCursorAutoriza)
        ENDIF

        IF USED(THIS.this_cCursorCheques)
            USE IN (THIS.this_cCursorCheques)
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

