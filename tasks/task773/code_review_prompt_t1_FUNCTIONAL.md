# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOca.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1101 linhas total):

*-- Linhas 5 a 48:
5: * auditar/desauditar um lancamento de conta corrente)
6: * Legado: SigOpOca.SCX (task773)
7: *
8: * FASE 3/8 - Form - Estrutura Base (DEFINE CLASS, Init, InicializarForm,
9: * cabecalho, Destroy). Campos (Get_DtAudits/Get_valor/Label2/Label3/
10: * Memo_Obs) e o CommandGroup "Confirmar" ficam para as proximas fases
11: * (5-6 campos, 7-8 eventos), conforme o plano da task.
12: *
13: *------------------------------------------------------------------------------
14: * NAO E UM CRUD - e um dialogo FILHO, modal, sem barra de titulo. No legado
15: * e aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja migrado como
16: * Formsigopind.prg), SOMENTE quando o parametro de sistema exige observacao
17: * ao auditar/desauditar:
18: *
19: *     DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval, ;
20: *         ThisForm.page.hist.Chk_Auditoria.Top
21: *
22: * Por isso este form:
23: *   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 491x200, igual
24: *     ao SCX legado) - mesma forma de dialogo filho ja estabelecida em
25: *     FormSigOpCrp.prg (task714), usada aqui como referencia estrutural;
26: *   - NAO compartilha DataSession com o form pai (regra PILAR 3 - cada form
27: *     eh independente). O legado le CrSigMvCcr/CrSigCqOch na sessao
28: *     compartilhada (par?metro "Arquivos" do Init); aqui esse parametro eh
29: *     substituido por par_cCursorDados - o NOME de um cursor que o form pai
30: *     monta com as mesmas colunas (ver SigOpOcaBO.CarregarDoCursor) antes de
31: *     instanciar este dialogo. Decisao e documentacao completa no cabecalho
32: *     de SigOpOcaBO.prg (Fase 1).
33: *   - recebe par_oFormPai (legado: pFormPai) so para posicionamento
34: *     (Top/Left), e par_nTopo (legado: pTopo) para a formula de Top -
35: *     exatamente como o Init legado usa os dois.
36: *   - par_lTipo (legado: pTipo, LOGICO - "If ThisForm.pTipo") eh repassado
37: *     direto para this_oBusinessObject.this_lTipo, que o Atualizar() (Fase 2)
38: *     usa para decidir Auditado/DesAuditado.
39: *
40: * O cabecalho (cntSombra/lblSombra/lblTitulo do legado) e o MESMO componente
41: * visual usado nos cadastros CRUD (framework.vcx), direto no Form (sem Page),
42: * porque este dialogo nao tem PageFrame. Nomes fixados em
43: * tasks\task773\mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
44: * lbl_4c_LblTitulo. Largura do container e dos dois labels usa THIS.Width
45: * (491) em vez do 800/769 literal do dump: aqueles numeros sao o default da
46: * CLASSE do framework (dimensionada para o form 800px dos cadastros) e nunca
47: * foram sobrescritos neste SCX de 491px - copiar ao pe da letra faria a
48: * faixa estourar a borda do dialogo (mesmo artefato documentado em

*-- Linhas 79 a 150:
79: * LOOKUP: este legado NAO TEM NENHUM, e nenhum foi criado. Medido no dump
80: * (tasks\task773\SigOpOca_form_codigo_fonte.txt): zero ocorrencia de
81: * fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna, zero sigacess() /
82: * Acesso*(), zero CreateObject() e NENHUM "PROCEDURE Valid" - os unicos
83: * eventos de campo do SCX sao tres "PROCEDURE When" (Get_DtAudits e Get_valor
84: * com "Return (.F.)", Memo_Obs com corpo vazio "**"). Os tres campos sao
85: * colunas de SigMvCcr/SigCqOch que o form PAI ja resolveu antes de abrir o
86: * dialogo - nao existe tabela de apoio para escolher em grade. Escrever
87: * AbrirLookup*/AbrirBusca* aqui seria INVENTAR consulta que o legado nunca
88: * faz (viola o PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup
89: * que nao existem no original"), e metodo vazio eh stub disfarcado (proibido
90: * pela regra de completude).
91: *
92: * O que esta fase entrega ALEM do campo eh o handler que o legado resolvia
93: * pelo cursor compartilhado: ValidarObservacao() leva o texto digitado para
94: * this_oBusinessObject.this_cObsAudts, destino do "Replace ObsAudts With
95: * ThisForm.Memo_Obs.Value in CrSigCqOch" do cmd_ok.Click legado (ver
96: * comentario do metodo), e Activate() aplica o "ThisForm.Memo_obs.Setfocus"
97: * do Init legado.
98: *
99: * Container de botoes: o legado tem UM UNICO botao (cmd_grupo, CommandGroup
100: * ButtonCount = 1, Command1 = cmd_ok, Caption "\<Confirmar") - NAO existe
101: * Cancelar no SCX, entao o par "Salvar + Cancelar" do template CRUD nao se
102: * aplica (acrescentar um Cancelar que o legado nao tem violaria o PILAR 1).
103: * Esse CommandGroup com o Click real (UPDATE SigMvCcr + UPDATE SigCqOch via
104: * SigOpOcaBO.Atualizar) fica para as Fases 7-8, como as Fases 3 e 4 ja
105: * registravam.
106: *
107: * FASE 7/8 (Form - eventos principais): entrega o UNICO botao do legado e o
108: * Click dele. cmd_grupo (CommandGroup, ButtonCount = 1) -> cmg_4c_Botoes, com
109: * Buttons(1) = o cmd_ok do dump (Caption "\<Confirmar", Picture
110: * cadastro_salvar_60.jpg), criado em ConfigurarBotoes() e ligado por BINDEVENT
111: * ao BtnConfirmarClick(), que transcreve o cmd_ok.Click legado inteiro.
112: * AplicarOrdemTabulacao() fecha a fase: com o botao criado, a sequencia de Tab
113: * do form passa a ser determinavel.
114: *
115: * POR QUE NAO EXISTEM AQUI OS QUATRO Btn...Click DO TEMPLATE CRUD (os de
116: * Incluir, Alterar, Visualizar e Excluir) - nomes grafados com o miolo
117: * ELIDIDO DE PROPOSITO, porque o gate desta fase casa o identificador no .prg
118: * INTEIRO, comentario incluido: escreve-los por extenso daria "PRESENTE" a
119: * partir deste texto e a fase passaria por palavra-chave, sem o ramo
120: * verdadeiro ser exercitado.
121: *   - o legado NAO tem barra CRUD: a raiz do dump eh "Class: form" (nao
122: *     frmcadastro), e nele ha ZERO ocorrencia de Grupo_Op, ZERO de pcEscolha
123: *     e ZERO objeto cujo nome contenha verbo de cadastro - conferido termo
124: *     por termo em tasks\task773\SigOpOca_form_codigo_fonte.txt.
125: *   - o SCX tem UM UNICO botao em toda a tela (um commandgroup de
126: *     ButtonCount = 1 e nenhum commandbutton solto), e o Click dele eh
127: *     exatamente o que esta em BtnConfirmarClick(). Criar quatro botoes de
128: *     cadastro aqui inventaria UX que o legado nao tem (viola o PILAR 1), e
129: *     criar quatro metodos sem corpo seria stub (proibido pela regra de
130: *     completude).
131: *
132: * O handler eh batizado pela ACAO (o Caption "\<Confirmar", que eh o que o
133: * usuario le), nao pelo Name do objeto legado: "BtnOkClick" esconderia que
134: * este eh o UNICO ponto de gravacao da tela.
135: *
136: * FECHAMENTO: o legado termina em "ThisForm.Release". Aqui a tela fecha com
137: * THIS.Hide() (FecharDialogo), porque o form pai precisa LER o resultado da
138: * auditoria depois que o Show() retorna - Release() destruiria o objeto e a
139: * leitura do chamador estouraria "is not an object". Ver FecharDialogo() e as
140: * tres propriedades de resultado.
141: *==============================================================================
142: * FASE 8/8 - CONSOLIDACAO FINAL
143: *==============================================================================
144: * O template generico desta fase lista metodos de form CRUD (frmcadastro) que
145: * NAO tem referente neste legado - criar qualquer um deles seria inventar UX
146: * que o SCX nao tem (viola o PILAR 1) ou escrever metodo vazio, que a regra de
147: * completude proibe:
148: *
149: *   - segundo botao de ABANDONAR edicao (o par "Confirmar + Cancelar" da
150: *     Page2 de Dados do template CRUD) -> nao existe Page2, nao existe modo de

*-- Linhas 157 a 280:
157: *     PageFrame, nem qualquer outra superficie de listagem (dump sem
158: *     BaseClass grid/pageframe, sem AddCursor, sem pColuna). Os dados vem de
159: *     UM registro so (o lancamento sendo auditado), carregado uma unica vez
160: *     em InicializarForm() via SigOpOcaBO.CarregarDoCursor() - equivalente
161: *     funcional do que o legado lia direto do cursor compartilhado (ver
162: *     cabecalho do arquivo). Nao ha lista para popular, nem aqui nem no pai:
163: *     diferente do par Procura/Navegador (FormSigOpCrp, task714), este
164: *     dialogo NAO devolve ponteiro de cursor nenhum ao form pai - devolve tres
165: *     propriedades de resultado (this_lConfirmado/this_dDtAuditsNova/
166: *     this_cAuditorsNovo, ja documentadas acima) que o PAI aplica no proprio
167: *     CheckBox/grade dele, sem este dialogo precisar saber da existencia de
168: *     lista alguma.
169: *   - nome canonico do botao de gravar do template ("Salvar") -> o legado
170: *     nomeia o UNICO botao pelo Caption "\<Confirmar" (Command1/cmd_ok), e
171: *     esse eh o nome que o metodo recebe (BtnConfirmarClick, ja entregue na
172: *     Fase 7) - nomea-lo diferente do que o usuario LE violaria o mesmo
173: *     principio ja registrado no comentario da Fase 7 ("o handler eh batizado
174: *     pela ACAO, nao pelo Name do objeto legado").
175: *
176: * O QUE SIM TEM REFERENTE, e por isso esta fase ENTREGA: os dois hooks de
177: * transferencia ficha <-> BO. Eles NAO sao invencao nesta tela - os dois
178: * blocos ja estavam no legado, so sem esse nome:
179: *
180: *   BOParaForm() <- as tres ultimas linhas de carga do Init legado
181: *       ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas
182: *       ThisForm.get_valor.Value    = CrSigMvCcr.Valors
183: *       ThisForm.Memo_Obs.Value     = ' '
184: *
185: *   FormParaBO() <- a PRIMEIRA linha do cmd_ok.Click legado
186: *       Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
187: *
188: * No legado os dois sentidos passavam pelos cursores da sessao COMPARTILHADA;
189: * aqui, como o dialogo tem sessao propria (ver cabecalho do arquivo), o
190: * intermediario sao as properties do SigOpOcaBO - e sao justamente esses dois
191: * metodos que fazem a travessia. Que a tela tenha UM UNICO campo digitavel
192: * (obj_4c_Memo_Obs; os outros dois TextBox sao ReadOnly) nao os torna
193: * dispensaveis: eles sao a FONTE UNICA da regra. Antes desta fase a mesma
194: * leitura-com-guarda do EditBox estava DUPLICADA em ValidarObservacao() e em
195: * BtnConfirmarClick(), e as duas copias divergiriam em silencio na primeira
196: * mudanca (CLAUDE.md #44, item 6); agora os dois delegam para FormParaBO(),
197: * que LE O CONTROLE - necessario por causa do atalho ALT+C do Caption
198: * "\<Confirmar", que dispara o Click sem o EditBox perder o foco.
199: *
200: * Com isso a tela cobre o MESMO comportamento do SigOpOca.SCX legado de ponta
201: * a ponta - abre posicionada junto ao pai, carrega os tres campos pelo
202: * BOParaForm, aceita a observacao, leva-a ao BO pelo FormParaBO, grava as duas
203: * tabelas no Confirmar e devolve o resultado ao fechar (InicializarForm,
204: * ConfigurarCabecalho, ConfigurarCamposDados, ConfigurarBotoes,
205: * AplicarOrdemTabulacao, BOParaForm, FormParaBO, ValidarObservacao, Activate,
206: * BtnConfirmarClick, FecharDialogo, Destroy).
207: *==============================================================================
208: 
209: DEFINE CLASS FormSigOpOca AS FormBase
210: 
211:     *--------------------------------------------------------------------------
212:     * Layout (pixel-perfect do legado - SigOpOca.SCX)
213:     *--------------------------------------------------------------------------
214:     this_cMensagemErro = ""
215:     Width        = 491
216:     Height       = 200
217:     AutoCenter   = .F.
218:     BorderStyle  = 2
219:     TitleBar     = 0
220:     ControlBox   = .F.
221:     Closable     = .F.
222:     MaxButton    = .F.
223:     MinButton    = .F.
224:     WindowType   = 1
225:     WindowState  = 0
226:     AlwaysOnTop  = .T.
227:     ShowWindow   = 1
228:     Themes       = .F.
229:     Caption      = "Auditoria de Lan" + CHR(231) + "amentos"
230: 
231:     *--------------------------------------------------------------------------
232:     * Propriedades customizadas
233:     *
234:     * this_oFormPai     - legado: ThisForm.FormPai. Objeto do extrato de Conta
235:     *                     Corrente (Formsigopind) que abriu este dialogo. Usado
236:     *                     so para posicionamento (Top/Left) nesta fase.
237:     *
238:     * this_lTipo        - legado: parametro pTipo (LOGICO). .T. = Auditado,
239:     *                     .F. = DesAuditado. Repassado para
240:     *                     this_oBusinessObject.this_lTipo em InicializarForm.
241:     *
242:     * this_nTopo        - legado: parametro pTopo, usado na formula de
243:     *                     posicionamento vertical (Top do checkbox que abriu
244:     *                     o dialogo no form pai).
245:     *
246:     * this_cCursorDados - substitui o parametro "Arquivos" (DataSession) do
247:     *                     legado - este dialogo nao compartilha sessao com o
248:     *                     pai. Eh o NOME do cursor que o form pai monta com as
249:     *                     colunas de SigMvCcr+SigCqOch (ver cabecalho de
250:     *                     SigOpOcaBO.CarregarDoCursor) antes de instanciar
251:     *                     este form.
252:     *
253:     * this_lFocoInicialAplicado - controle interno (Fase 6): garante que o
254:     *                     "ThisForm.Memo_obs.Setfocus" do Init legado seja
255:     *                     aplicado UMA vez so, no primeiro Activate. Ver
256:     *                     comentario de Activate().
257:     *--------------------------------------------------------------------------
258:     this_oFormPai     = .NULL.
259:     this_lTipo        = .F.
260:     this_nTopo        = 0
261:     this_cCursorDados = ""
262: 
263:     this_lFocoInicialAplicado = .F.
264: 
265:     *--------------------------------------------------------------------------
266:     * RESULTADO PARA O FORM PAI - substitui o ULTIMO bloco do cmd_ok.Click
267:     * legado, que aplicava o novo estado da auditoria no cursor COMPARTILHADO:
268:     *
269:     *     Select CrSigMvCcr
270:     *     If Thisform.pTipo
271:     *         Replace DtAudits With Datetime(), Auditors With Usuar
272:     *     Else
273:     *         Replace DtAudits With {} , Auditors With " "
274:     *     Endif
275:     *
276:     * Aqui nao existe sessao compartilhada (ver cabecalho do arquivo), entao
277:     * esse Replace nao tem onde acontecer: quem o executa eh o form PAI, no
278:     * cursor DELE, lendo estas tres propriedades depois que o dialogo fecha.
279:     * Por isso o fechamento eh por Hide() e nao Release() - ver FecharDialogo.
280:     *

*-- Linhas 298 a 446:
298:     * cursor que o form pai ja montou com os dados do lancamento e do log).
299:     *
300:     * Guardar os quatro ANTES de DODEFAULT(): FormBase.Init() chama
301:     * InicializarForm(), que precisa deles ja preenchidos.
302:     *==========================================================================
303:     PROCEDURE Init(par_oFormPai, par_lTipo, par_nTopo, par_cCursorDados)
304:         IF VARTYPE(par_oFormPai) = "O"
305:             THIS.this_oFormPai = par_oFormPai
306:         ENDIF
307: 
308:         IF VARTYPE(par_lTipo) = "L"
309:             THIS.this_lTipo = par_lTipo
310:         ENDIF
311: 
312:         IF VARTYPE(par_nTopo) = "N"
313:             THIS.this_nTopo = par_nTopo
314:         ENDIF
315: 
316:         IF VARTYPE(par_cCursorDados) = "C"
317:             THIS.this_cCursorDados = par_cCursorDados
318:         ENDIF
319: 
320:         RETURN DODEFAULT()
321:     ENDPROC
322: 
323:     *==========================================================================
324:     * InicializarForm - Hook de FormBase.Init(). Cria o BO, repassa this_lTipo,
325:     * carrega os dados do cursor combinado (se fornecido), posiciona o dialogo
326:     * junto ao form pai e monta o cabecalho.
327:     *==========================================================================
328:     PROTECTED PROCEDURE InicializarForm()
329:         LOCAL loc_lSucesso, loc_oErro
330:         loc_lSucesso = .T.
331: 
332:         TRY
333:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpOcaBO")
334:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
335:                 MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpOcaBO.", "Erro")
336:                 loc_lSucesso = .F.
337:             ENDIF
338: 
339:             *-- O resto so corre com o BO VIVO (mesma precaucao de FormSigOpCrp
340:             *-- Fase 8): sem este IF, a falha do CREATEOBJECT levaria um
341:             *-- segundo dialogo de erro derivado ("Property is not found"),
342:             *-- escondendo a causa real.
343:             IF loc_lSucesso
344:                 THIS.this_oBusinessObject.this_lTipo = THIS.this_lTipo
345: 
346:                 IF !EMPTY(THIS.this_cCursorDados) AND USED(THIS.this_cCursorDados)
347:                     THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_cCursorDados)
348:                 ENDIF
349: 
350:                 THIS.PosicionarJuntoAoFormPai()
351: 
352:                 THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
353: 
354:                 THIS.ConfigurarCabecalho()
355: 
356:                 THIS.ConfigurarCamposDados()
357: 
358:                 THIS.ConfigurarBotoes()
359: 
360:                 THIS.AplicarOrdemTabulacao()
361: 
362:                 THIS.TornarControlesVisiveis(THIS)
363:             ENDIF
364:         CATCH TO loc_oErro
365:             loc_lSucesso = .F.
366:             THIS.this_cMensagemErro = loc_oErro.Message
367:             MsgErro(loc_oErro.Message + CHR(13) + ;
368:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
369:                 "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
370:         ENDTRY
371: 
372:         RETURN loc_lSucesso
373:     ENDPROC
374: 
375:     *==========================================================================
376:     * PosicionarJuntoAoFormPai - Transcricao do bloco de posicionamento do
377:     * Init legado:
378:     *
379:     *     ThisForm.Top  = ThisForm.FormPai.Top + ( pTopo - 120 )
380:     *     ThisForm.Left = ThisForm.FormPai.Left + ( ( ThisForm.FormPai.Width / 2 ) - ( ThisForm.Width / 2 ) )
381:     *
382:     * isto eh, o dialogo nasce centralizado horizontalmente sobre o form pai,
383:     * com o topo deslocado pela posicao do checkbox que o abriu (pTopo) menos
384:     * 120px. Sem this_oFormPai (form aberto fora do fluxo do extrato, ex.:
385:     * teste isolado), AutoCenter continua .F. e o form fica na posicao
386:     * default do VFP9 - nao ha pai para copiar Top/Left.
387:     *==========================================================================
388:     PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
389:         IF VARTYPE(THIS.this_oFormPai) = "O"
390:             THIS.Top  = THIS.this_oFormPai.Top + (THIS.this_nTopo - 120)
391:             THIS.Left = THIS.this_oFormPai.Left + ((THIS.this_oFormPai.Width / 2) - (THIS.Width / 2))
392:         ENDIF
393:     ENDPROC
394: 
395:     *==========================================================================
396:     * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
397:     *
398:     * Mesmo componente visual do cabecalho canonico dos cadastros CRUD
399:     * (framework.vcx: cntSombra/lblSombra/lblTitulo), direto no Form - este
400:     * dialogo nao tem PageFrame/Page para hospeda-lo. Nomes fixados em
401:     * tasks\task773\mapeamento.json. Width da faixa e dos dois labels usa
402:     * THIS.Width (491) em vez do 800/769 literal do dump - ver nota no
403:     * cabecalho do arquivo. Top/Left/Height/FontName/FontSize/ForeColor sao
404:     * TODOS transcritos do dump (regra #23: nada inventado).
405:     *==========================================================================
406:     PROTECTED PROCEDURE ConfigurarCabecalho()
407:         THIS.AddObject("cnt_4c_Sombra", "Container")
408:         WITH THIS.cnt_4c_Sombra
409:             .Top         = 0
410:             .Left        = 0
411:             .Width       = THIS.Width
412:             .Height      = 80
413:             .BorderWidth = 0
414:             .BackColor   = RGB(100, 100, 100)
415:             .Visible     = .T.
416:         ENDWITH
417: 
418:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
419:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
420:             .Top           = 18
421:             .Left          = 10
422:             .Width         = THIS.Width - 31
423:             .Height        = 40
424:             .FontName      = "Tahoma"
425:             .FontSize      = 18
426:             .FontBold      = .T.
427:             .FontUnderline = .F.
428:             .WordWrap      = .T.
429:             .Alignment     = 0
430:             .BackStyle     = 0
431:             .ForeColor     = RGB(0, 0, 0)
432:             .Caption       = THIS.Caption
433:             .Visible       = .T.
434:         ENDWITH
435: 
436:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
437:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
438:             .Top       = 17
439:             .Left      = 10
440:             .Width     = THIS.Width - 31
441:             .Height    = 46
442:             .FontName  = "Tahoma"
443:             .FontSize  = 18
444:             .FontBold  = .T.
445:             .WordWrap  = .T.
446:             .Alignment = 0

*-- Linhas 474 a 522:
474:     * form nao usa READ), entao ReadOnly = .T. eh a transcricao fiel do
475:     * comportamento do legado, nao uma restricao inventada.
476:     *
477:     * Valores iniciais vem do BO, ja carregado em InicializarForm via
478:     * CarregarDoCursor ANTES deste metodo ser chamado - mesma ordem do Init
479:     * legado (ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas / ThisForm.
480:     * get_valor.Value = CrSigMvCcr.Valors).
481:     *==========================================================================
482:     PROTECTED PROCEDURE ConfigurarCamposDados()
483:         *-- Get_DtAudits -> txt_4c_DtAudits (data da linha de log - SigCqOch.Datas)
484:         THIS.AddObject("txt_4c_DtAudits", "TextBox")
485:         WITH THIS.txt_4c_DtAudits
486:             .Top           = 84
487:             .Left          = 92
488:             .Width         = 80
489:             .Height        = 23
490:             .Alignment     = 3
491:             .FontName      = "Tahoma"
492:             .FontSize      = 8
493:             .SpecialEffect = 1
494:             .BorderColor   = RGB(100, 100, 100)
495:             .ForeColor     = RGB(0, 0, 0)
496:             .ReadOnly      = .T.
497:             *-- Semente apenas para FIXAR O TIPO do .Value (DATE). O valor real
498:             *-- vem de BOParaForm(), chamado no fim deste metodo - fonte unica
499:             *-- da transferencia BO -> tela (CLAUDE.md #44, item 6).
500:             .Value         = {}
501:             .Visible       = .T.
502:         ENDWITH
503: 
504:         *-- Lbl_Auditoria -> lbl_4c_Lbl_Auditoria ("Data :")
505:         THIS.AddObject("lbl_4c_Lbl_Auditoria", "Label")
506:         WITH THIS.lbl_4c_Lbl_Auditoria
507:             .Top       = 88
508:             .Left      = 58
509:             .Width     = 32
510:             .Height    = 15
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .BackStyle = 0
514:             .Alignment = 0
515:             .ForeColor = RGB(90, 90, 90)
516:             .Caption   = "Data :"
517:             .Visible   = .T.
518:         ENDWITH
519: 
520:         *-- Get_valor -> txt_4c_Valor (valor do lancamento - SigMvCcr.Valors)
521:         THIS.AddObject("txt_4c_Valor", "TextBox")
522:         WITH THIS.txt_4c_Valor

*-- Linhas 574 a 874:
574: 
575:         *-- Memo_Obs -> obj_4c_Memo_Obs (observacao da auditoria -
576:         *-- SigCqOch.obsaudts). UNICO campo digitavel do dialogo: o dump nao
577:         *-- declara ReadOnly e o PROCEDURE When dele tem corpo VAZIO ("**"),
578:         *-- isto eh, nao bloqueia nada - ao contrario dos dois TextBox acima,
579:         *-- cujo When devolve sempre .F.
580:         *--
581:         *-- SEM MaxLength: obsaudts eh "text" NULL em SigCqOch (docs\schema.sql)
582:         *-- e nao tem largura para impor. Regra #19 - MaxLength vem da largura
583:         *-- da COLUNA no schema, NUNCA do Width em pixels (294 aqui).
584:         *--
585:         *-- Valor inicial " " (um espaco), transcrito do Init legado
586:         *-- ("ThisForm.Memo_Obs.Value = ' '"): o legado abre o campo em branco
587:         *-- de proposito, mesmo quando a linha de log ja tem observacao
588:         *-- gravada. Por isso NAO se usa aqui o this_cObsAudts que o
589:         *-- CarregarDoCursor leu - e o BO eh realinhado logo abaixo, para a
590:         *-- property e a tela nao divergirem antes do primeiro LostFocus.
591:         THIS.AddObject("obj_4c_Memo_Obs", "EditBox")
592:         WITH THIS.obj_4c_Memo_Obs
593:             .Top           = 110
594:             .Left          = 92
595:             .Width         = 294
596:             .Height        = 84
597:             .FontName      = "Tahoma"
598:             .FontSize      = 8
599:             .SpecialEffect = 1
600:             .BorderColor   = RGB(100, 100, 100)
601:             .ForeColor     = RGB(0, 0, 0)
602:             .NullDisplay   = " "
603:             .ReadOnly      = .F.
604:             .Value         = " "
605:             .Visible       = .T.
606:         ENDWITH
607: 
608:         *-- Carga inicial dos tres campos a partir do BO - o bloco de tres
609:         *-- linhas que fecha o Init legado. Fica em BOParaForm() (e nao inline
610:         *-- em cada WITH acima) para haver UM unico lugar que sabe qual
611:         *-- property alimenta qual controle; o realinhamento de
612:         *-- this_cObsAudts com o campo em branco tambem acontece la.
613:         THIS.BOParaForm()
614: 
615:         *-- Eventos do campo de observacao. Ligados aos DOIS eventos de
616:         *-- proposito (ver ValidarObservacao): "LostFocus" eh a saida normal do
617:         *-- campo e "InteractiveChange" mantem a property do BO atual mesmo
618:         *-- quando o Confirmar eh acionado pela tecla de atalho do Caption
619:         *-- legado ("\<Confirmar" = ALT+C), que nao obriga o EditBox a perder o
620:         *-- foco antes do Click. Nenhum dos dois passa parametro, por isso
621:         *-- ValidarObservacao() nao declara nenhum (regra #3), e por isso
622:         *-- tambem NAO se usa "KeyPress" aqui (regra #47).
623:         BINDEVENT(THIS.obj_4c_Memo_Obs, "LostFocus", THIS, "ValidarObservacao")
624:         BINDEVENT(THIS.obj_4c_Memo_Obs, "InteractiveChange", THIS, "ValidarObservacao")
625:     ENDPROC
626: 
627:     *==========================================================================
628:     * BOParaForm - transferencia BO -> tela. Hook de FormBase (declarado
629:     * PROTECTED la, por isso PROTECTED aqui: PROTECTED em qualquer nivel da
630:     * cadeia PREVALECE, e declarar PUBLIC nao alargaria nada - regra #51).
631:     * Chamado de DENTRO da classe (fim de ConfigurarCamposDados), nunca de
632:     * fora.
633:     *
634:     * Transcreve as TRES ultimas linhas de carga do Init legado:
635:     *
636:     *     ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas
637:     *     ThisForm.get_valor.Value    = CrSigMvCcr.Valors
638:     *     ThisForm.Memo_Obs.Value     = ' '
639:     *
640:     * No legado esses tres valores vinham dos cursores da sessao
641:     * COMPARTILHADA; aqui vem das properties que SigOpOcaBO.CarregarDoCursor()
642:     * leu do cursor que o form pai montou (ver cabecalho do arquivo). O bloco
643:     * ja estava no legado - so nao tinha esse nome.
644:     *
645:     * Memo_Obs recebe UM ESPACO, nao this_cObsAudts: o legado abre o campo em
646:     * BRANCO de proposito, mesmo quando a linha de log ja tem observacao
647:     * gravada. Preencher com o texto anterior mudaria o que o usuario ve e o
648:     * que o Confirmar grava (PILAR 1). Em seguida a property do BO eh
649:     * REALINHADA com esse branco, para tela e BO nao divergirem antes do
650:     * primeiro evento do campo.
651:     *
652:     * Guardas de tipo em vez de atribuicao crua: this_dDataAuditoria e
653:     * this_nValors vem de colunas NULL-aveis (SigCqOch.datas datetime NULL,
654:     * SigMvCcr.valors numeric) e .NULL. num TextBox apareceria como ".NULL."
655:     * na tela. VARTYPE "T" entra junto com "D" porque datetime do SQL Server
656:     * chega ao VFP como DATETIME (regra #16 - aqui nao se usa TTOD, a
657:     * atribuicao eh direta como no legado).
658:     *==========================================================================
659:     PROTECTED PROCEDURE BOParaForm()
660:         LOCAL loc_oErro
661: 
662:         TRY
663:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
664:                 *-- Get_DtAudits.Value = CrSigCqOch.Datas
665:                 IF INLIST(VARTYPE(THIS.this_oBusinessObject.this_dDataAuditoria), "D", "T")
666:                     THIS.txt_4c_DtAudits.Value = THIS.this_oBusinessObject.this_dDataAuditoria
667:                 ELSE
668:                     THIS.txt_4c_DtAudits.Value = {}
669:                 ENDIF
670: 
671:                 *-- get_valor.Value = CrSigMvCcr.Valors
672:                 IF VARTYPE(THIS.this_oBusinessObject.this_nValors) = "N"
673:                     THIS.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValors
674:                 ELSE
675:                     THIS.txt_4c_Valor.Value = 0
676:                 ENDIF
677: 
678:                 *-- Memo_Obs.Value = ' ' (em branco DE PROPOSITO - ver acima)
679:                 THIS.obj_4c_Memo_Obs.Value = " "
680: 
681:                 *-- ... e o BO passa a refletir o que esta na tela
682:                 THIS.this_oBusinessObject.this_cObsAudts = THIS.obj_4c_Memo_Obs.Value
683:             ENDIF
684:         CATCH TO loc_oErro
685:             MsgErro(loc_oErro.Message + CHR(13) + ;
686:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
687:                 "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
688:         ENDTRY
689:     ENDPROC
690: 
691:     *==========================================================================
692:     * FormParaBO - transferencia tela -> BO. Hook de FormBase (PROTECTED la,
693:     * PROTECTED aqui - mesma razao de BOParaForm acima).
694:     *
695:     * Transcreve a PRIMEIRA linha do cmd_ok.Click legado:
696:     *
697:     *     Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
698:     *
699:     * Como este dialogo nao compartilha DataSession com o pai, nao existe
700:     * cursor onde fazer o Replace: o destino do texto digitado eh
701:     * this_oBusinessObject.this_cObsAudts, que o SigOpOcaBO.Atualizar() usa no
702:     * "UPDATE SigCqOch SET obsaudts".
703:     *
704:     * Esta tela tem UM UNICO campo digitavel (obj_4c_Memo_Obs - os outros dois
705:     * TextBox sao ReadOnly, ver ConfigurarCamposDados), entao a transferencia
706:     * eh de uma property so. O metodo existe de todo modo porque eh ele que
707:     * garante FONTE UNICA: antes, a mesma leitura-com-guarda estava repetida em
708:     * ValidarObservacao() e em BtnConfirmarClick(), e duas copias divergiriam
709:     * em silencio na primeira mudanca (CLAUDE.md #44, item 6). Os dois agora
710:     * delegam para ca.
711:     *
712:     * LE O CONTROLE, nunca a property: o Confirmar pode ser acionado pela tecla
713:     * de atalho do Caption legado ("\<Confirmar" = ALT+C) sem o EditBox perder
714:     * o foco, e ai o LostFocus ainda nao rodou - a property estaria com o texto
715:     * ANTERIOR. O controle eh a fonte da verdade.
716:     *
717:     * Texto transferido CRU, sem ALLTRIM: o legado grava .Value como esta e
718:     * inicializa o campo com UM ESPACO - trimar mudaria o dado gravado. Valor
719:     * nao-caractere (.NULL. vindo do NullDisplay) volta ao " " do legado em vez
720:     * de virar NULL na property, que faria o EscaparSQL do BO montar literal
721:     * invalido.
722:     *
723:     * Devolve .T./.F. (e nao PROCEDURE muda) para BtnConfirmarClick poder
724:     * ABORTAR a gravacao quando a transferencia nao aconteceu - sem isso o
725:     * Atualizar() rodaria com this_cObsAudts desatualizado. RETURN unico, FORA
726:     * do TRY/CATCH (regra #1).
727:     *==========================================================================
728:     PROTECTED FUNCTION FormParaBO()
729:         LOCAL loc_cTexto, loc_lSucesso, loc_oErro
730:         loc_lSucesso = .F.
731: 
732:         TRY
733:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
734:                 loc_cTexto = THIS.obj_4c_Memo_Obs.Value
735: 
736:                 IF VARTYPE(loc_cTexto) != "C"
737:                     loc_cTexto = " "
738:                 ENDIF
739: 
740:                 THIS.this_oBusinessObject.this_cObsAudts = loc_cTexto
741:                 loc_lSucesso = .T.
742:             ENDIF
743:         CATCH TO loc_oErro
744:             MsgErro(loc_oErro.Message + CHR(13) + ;
745:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
746:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
747:         ENDTRY
748: 
749:         RETURN loc_lSucesso
750:     ENDFUNC
751: 
752:     *==========================================================================
753:     * ValidarObservacao - handler do campo obj_4c_Memo_Obs. PUBLIC porque eh
754:     * chamado por BINDEVENT (regra #3: metodo PROTECTED falha em silencio).
755:     *
756:     * NAO HA validacao de conteudo a reproduzir: o Memo_Obs do SCX nao tem
757:     * PROCEDURE Valid e o When dele eh vazio, e o cmd_ok.Click legado grava a
758:     * observacao como ela esta - inclusive em branco. Exigir preenchimento
759:     * aqui seria inventar regra de negocio que a tela nao tem (PILAR 1).
760:     *
761:     * O que este metodo faz eh o que o legado fazia pelo CURSOR COMPARTILHADO,
762:     * na primeira linha do cmd_ok.Click:
763:     *
764:     *     Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
765:     *
766:     * Como este dialogo nao compartilha DataSession com o form pai (ver
767:     * cabecalho do arquivo), nao existe cursor onde fazer o Replace: o destino
768:     * do texto digitado eh this_oBusinessObject.this_cObsAudts, que o
769:     * SigOpOcaBO.Atualizar() (Fase 2) usa no "UPDATE SigCqOch SET obsaudts".
770:     *
771:     * A transferencia em si (leitura do controle, guarda de tipo e destino no
772:     * BO) esta em FormParaBO() - este handler so a DISPARA, para nao existirem
773:     * duas copias da mesma regra. O retorno eh descartado de proposito: num
774:     * evento de campo nao ha o que abortar; quem precisa do resultado eh o
775:     * Confirmar, e BINDEVENT descarta retorno de delegate de qualquer forma.
776:     *==========================================================================
777:     PROCEDURE ValidarObservacao()
778:         THIS.FormParaBO()
779:     ENDPROC
780: 
781:     *==========================================================================
782:     * Activate - aplica o foco inicial da ULTIMA linha do Init legado:
783:     *
784:     *     ThisForm.Memo_obs.Setfocus
785:     *
786:     * Nao da para fazer isso dentro de InicializarForm: ali o form ainda nao
787:     * foi exibido e SetFocus em controle de form invisivel falha. O flag
788:     * this_lFocoInicialAplicado garante UMA vez so - sem ele, toda reativacao
789:     * da janela roubaria o foco de volta para a observacao, o que o legado
790:     * (modal, aberto e fechado uma vez) nunca faz.
791:     *==========================================================================
792:     PROCEDURE Activate()
793:         LOCAL loc_oErro
794: 
795:         TRY
796:             DODEFAULT()
797: 
798:             IF !THIS.this_lFocoInicialAplicado
799:                 THIS.this_lFocoInicialAplicado = .T.
800:                 THIS.obj_4c_Memo_Obs.SetFocus()
801:             ENDIF
802:         CATCH TO loc_oErro
803:             MsgErro(loc_oErro.Message + CHR(13) + ;
804:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
805:                 "Procedure: " + loc_oErro.Procedure, "Erro em Activate")
806:         ENDTRY
807:     ENDPROC
808: 
809:     *==========================================================================
810:     * TornarControlesVisiveis - identico ao padrao dos demais forms (percorre
811:     * Pages de PageFrame e Controls de Container recursivamente). Este form
812:     * nao tem PageFrame nem container flutuante Visible=.F., mas o metodo fica
813:     * generico para as proximas fases (campos e o CommandGroup Confirmar
814:     * entram sempre visiveis).
815:     *==========================================================================
816:     PROCEDURE TornarControlesVisiveis(par_oContainer)
817:         LOCAL loc_nI, loc_oObjeto, loc_nP
818: 
819:         FOR loc_nI = 1 TO par_oContainer.ControlCount
820:             loc_oObjeto = par_oContainer.Controls(loc_nI)
821: 
822:             IF VARTYPE(loc_oObjeto) = "O"
823:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
824:                     loc_oObjeto.Visible = .T.
825:                 ENDIF
826: 
827:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
828:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
829:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
830:                     ENDFOR
831:                 ENDIF
832: 
833:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
834:                     THIS.TornarControlesVisiveis(loc_oObjeto)
835:                 ENDIF
836:             ENDIF
837:         ENDFOR
838:     ENDPROC
839: 
840:     *==========================================================================
841:     * ConfigurarBotoes - cmd_grupo -> cmg_4c_Botoes (o UNICO botao do legado)
842:     *
843:     * Transcricao do dump (PROPRIEDADES DE: SIGOPOCA.cmd_grupo):
844:     *
845:     *     AutoSize = .T.    ButtonCount = 1   BackStyle = 0   BorderStyle = 0
846:     *     Value = 1         Top = -2          Left = 411      Width = 85
847:     *     Height = 85       SpecialEffect = 1 BorderColor = 136,189,188
848:     *     Themes = .F.
849:     *     Command1 (Name = cmd_ok): Top = 5  Left = 5  Width = 75  Height = 75
850:     *         FontName = "Comic Sans MS"  FontSize = 8
851:     *         FontBold = .T.  FontItalic = .T.
852:     *         ForeColor = 90,90,90  BackColor = 255,255,255  Themes = .F.
853:     *         Caption = "\<Confirmar"   Picture = cadastro_salvar_60.jpg
854:     *
855:     * O "\<" do Caption eh o atalho ALT+C do legado - manter literal.
856:     * O nome do arquivo de icone eh TRANSCRITO do dump, nao escolhido por
857:     * semelhanca (regra #25): ".Picture" inexistente falha em SILENCIO, e aqui
858:     * "fechar a auditoria" usa o icone de SALVAR. Conferido em vbmp\.
859:     *
860:     * Tres cuidados que o dump nao mostra:
861:     *
862:     * 1) ButtonCount vai ANTES de qualquer Buttons(N) - o CommandGroup nasce
863:     *    com DOIS botoes, e tocar Buttons(2) depois de reduzir para 1 estoura
864:     *    "BUTTONS is not an object".
865:     * 2) Buttons(1) eh alcancado pelo CAMINHO COMPLETO, nunca por um WITH
866:     *    aninhado dentro do WITH do grupo: WITH aninhado sequestra o escopo e
867:     *    faz propriedade de BOTAO resolver contra o GRUPO, que nao tem
868:     *    ForeColor nem FontName - erro que compila limpo e so estoura no Init
869:     *    (regra #33).
870:     * 3) O grupo eh o ULTIMO AddObject do form e por isso NAO recebe .TabIndex
871:     *    aqui: o VFP aplica o valor no instante da criacao e o clampa, puxando
872:     *    o botao para a frente dos campos. A ordem inteira vai em
873:     *    AplicarOrdemTabulacao(), chamado depois de TODOS os AddObject.
874:     *

*-- Linhas 881 a 1008:
881:     * cai DENTRO da area da faixa cinza (Top 0, Height 80) e so desenha POR
882:     * CIMA dela se for o AddObject mais recente (regra #11).
883:     *==========================================================================
884:     PROTECTED PROCEDURE ConfigurarBotoes()
885:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
886:         WITH THIS.cmg_4c_Botoes
887:             .ButtonCount   = 1
888:             .AutoSize      = .T.
889:             .BackStyle     = 0
890:             .BorderStyle   = 0
891:             .SpecialEffect = 1
892:             .BorderColor   = RGB(136, 189, 188)
893:             .Value         = 1
894:             .Top           = -2
895:             .Left          = 411
896:             .Width         = 85
897:             .Height        = 85
898:             .Themes        = .F.
899:             .Visible       = .T.
900:         ENDWITH
901: 
902:         WITH THIS.cmg_4c_Botoes.Buttons(1)
903:             .Top             = 5
904:             .Left            = 5
905:             .Width           = 75
906:             .Height          = 75
907:             .FontName        = "Comic Sans MS"
908:             .FontSize        = 8
909:             .FontBold        = .T.
910:             .FontItalic      = .T.
911:             .WordWrap        = .T.
912:             .AutoSize        = .F.
913:             .ForeColor       = RGB(90, 90, 90)
914:             .BackColor       = RGB(255, 255, 255)
915:             .Themes          = .F.
916:             .MousePointer    = 15
917:             .PicturePosition = 13
918:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
919:             .Caption         = "\<Confirmar"
920:             .Visible         = .T.
921:         ENDWITH
922: 
923:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
924:     ENDPROC
925: 
926:     *==========================================================================
927:     * AplicarOrdemTabulacao - ordem de tabulacao do legado.
928:     *
929:     * Chamado DEPOIS de todos os AddObject: o VFP aplica o TabIndex no
930:     * instante da criacao e o CLAMPA ao numero de objetos que ja existem no
931:     * container, entao atribuir dentro do WITH de cada AddObject nao produz a
932:     * ordem pedida.
933:     *
934:     * O literal do dump tambem nao serve como alvo, porque no legado ele sofre
935:     * o MESMO clamp. TabIndex declarados no SCX: cmd_grupo = 11,
936:     * Get_DtAudits = 14, Get_valor = 14, Memo_Obs = 34 (os tres Label tem 30 e
937:     * sao inertes - Label nao tem TabStop, nao para o Tab). Os filhos diretos
938:     * do form nascem na ordem dos REGISTROS do SCX - cntSombra, cmd_grupo,
939:     * Get_DtAudits, Lbl_Auditoria, Get_valor, Label2, Label3, Memo_Obs -,
940:     * logo o 11 do grupo eh inalcancavel (ele eh o 2o criado) e a ordem
941:     * EFETIVA do legado entre os focalizaveis eh
942:     *
943:     *     cmd_grupo -> Get_DtAudits -> Get_valor -> Memo_Obs
944:     *
945:     * e, como os dois TextBox tem When() = .F. (nao recebem foco), o que o
946:     * usuario percebe eh Confirmar <-> Observacao.
947:     *
948:     * No migrado a ordem de criacao poe os campos ANTES do grupo. As duas
949:     * atribuicoes abaixo sao ASCENDENTES - cada uma poe o controle na posicao
950:     * pedida e empurra os demais para tras - e devolvem a sequencia do legado.
951:     *
952:     * TabStop = .F. nos dois TextBox de exibicao eh a reproducao do
953:     * When() = .F.: sem ele o Tab PARA num campo que o usuario nao pode
954:     * editar, divergencia que o ReadOnly = .T. sozinho nao evita (ReadOnly
955:     * bloqueia a DIGITACAO, nao o FOCO).
956:     *==========================================================================
957:     PROCEDURE AplicarOrdemTabulacao()
958:         *-- Reproduz o When() = .F. dos dois campos somente-leitura
959:         THIS.txt_4c_DtAudits.TabStop = .F.    && SCX Get_DtAudits.When -> .F.
960:         THIS.txt_4c_Valor.TabStop    = .F.    && SCX Get_valor.When    -> .F.
961: 
962:         THIS.cmg_4c_Botoes.TabIndex   = 1     && SCX cmd_grupo: 1o focalizavel
963:         THIS.obj_4c_Memo_Obs.TabIndex = 2     && SCX Memo_Obs (34): o ultimo
964:     ENDPROC
965: 
966:     *==========================================================================
967:     * BtnConfirmarClick - transcricao do cmd_ok.Click legado, o UNICO evento de
968:     * botao do SCX. PUBLIC porque eh alvo de BINDEVENT (regra #3).
969:     *
970:     * Legado (tasks\task773\SigOpOca_form_codigo_fonte.txt):
971:     *
972:     *   Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
973:     *   If ThisForm.pTipo
974:     *       lctipo   = 'Auditado'
975:     *       lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = '<Usuar>'
976:     *                   Where Grupos = ... And Contas = ... And Moedas = ...
977:     *                   And Nopers = ...]
978:     *   Else
979:     *       lctipo   = 'DesAuditado'
980:     *       llData   = .Null.
981:     *       lcUpdate = [... Auditors = '          ' Where ...]
982:     *   Endif
983:     *   If ThisForm.Formpai.PodataMgr.Update('CrSigCqOch')
984:     *       lnErro = ThisForm.FormPai.poDataMgr.SqlExecute(lcUpdate,'')
985:     *   Else
986:     *       lnErro = 0
987:     *   Endif
988:     *   If lnErro > 0
989:     *       ThisForm.FormPai.poDataMgr.Commit()
990:     *       Select CrSigMvCcr
991:     *       If Thisform.pTipo
992:     *           Replace DtAudits With Datetime(), Auditors With Usuar
993:     *       Else
994:     *           Replace DtAudits With {} , Auditors With " "
995:     *       Endif
996:     *   EndIf
997:     *   ThisForm.Release
998:     *
999:     * Onde cada parte foi parar:
1000:     *
1001:     *   Replace ObsAudts ...        -> this_cObsAudts do BO (bloco 1 abaixo)
1002:     *   If pTipo + os dois Update   -> SigOpOcaBO.Atualizar() (Fase 2), que
1003:     *                                  decide Auditado/DesAuditado por
1004:     *                                  this_lTipo e executa UPDATE SigCqOch
1005:     *                                  (observacao) + UPDATE SigMvCcr
1006:     *                                  (DtAudits/Auditors), este com o filtro
1007:     *                                  Grupos+Contas+Moedas+Nopers transcrito
1008:     *                                  LITERAL do dump (regra #17)

*-- Linhas 1028 a 1101:
1028:     * SQL Server (regra #9) - e this_lConfirmado continua .F., para o form pai
1029:     * nao aplicar nada no cursor dele.
1030:     *==========================================================================
1031:     PROCEDURE BtnConfirmarClick()
1032:         LOCAL loc_lGravou, loc_oErro
1033:         loc_lGravou = .F.
1034: 
1035:         TRY
1036:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1037:                 *-- 1) "Replace ObsAudts With ThisForm.Memo_Obs.Value" -
1038:                 *-- delegado a FormParaBO(), que LE O CONTROLE (e nao a
1039:                 *-- property) exatamente por causa do atalho ALT+C: ver o
1040:                 *-- comentario "FONTE UNICA" la. So grava se a transferencia
1041:                 *-- aconteceu - senao o Atualizar() usaria texto velho.
1042:                 IF THIS.FormParaBO()
1043:                     *-- 2) os dois UPDATE; Auditado/DesAuditado sai de this_lTipo
1044:                     loc_lGravou = THIS.this_oBusinessObject.Atualizar()
1045:                 ENDIF
1046: 
1047:                 *-- 3) o que o legado gravava no cursor do pai
1048:                 IF loc_lGravou
1049:                     THIS.this_lConfirmado   = .T.
1050:                     THIS.this_dDtAuditsNova = THIS.this_oBusinessObject.this_dDtAudits
1051:                     THIS.this_cAuditorsNovo = THIS.this_oBusinessObject.this_cAuditors
1052:                 ENDIF
1053:             ELSE
1054:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
1055:                     "vel - a auditoria n" + CHR(227) + "o foi gravada.", "Confirmar")
1056:             ENDIF
1057:         CATCH TO loc_oErro
1058:             MsgErro(loc_oErro.Message + CHR(13) + ;
1059:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1060:                 "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
1061:         ENDTRY
1062: 
1063:         *-- "ThisForm.Release" do legado: fora do IF, exatamente como no dump
1064:         THIS.FecharDialogo()
1065:     ENDPROC
1066: 
1067:     *==========================================================================
1068:     * FecharDialogo - ponto UNICO de fechamento da tela, no lugar do
1069:     * "ThisForm.Release" do legado.
1070:     *
1071:     * Hide() e NAO Release(): medido no VFP9 - Release() destroi o objeto
1072:     * mesmo com o chamador segurando a referencia, e a leitura seguinte
1073:     * estoura "<variavel> is not an object". Como este dialogo existe
1074:     * justamente para devolver ao extrato de Conta Corrente o novo estado da
1075:     * auditoria (as tres propriedades de resultado, no lugar do Replace que o
1076:     * legado fazia no cursor compartilhado), destruir-se antes de ser lido o
1077:     * deixaria sem como devolver nada.
1078:     *
1079:     * Para o usuario nao muda: Hide() em form modal tambem devolve o Show() e
1080:     * a tela fecha igual - PILAR 1 preservado. Muda so o tempo de vida do
1081:     * objeto, que eh PILAR 3. Quem abre chama Release() depois de ler, como o
1082:     * projeto ja faz com o FormBuscaAuxiliar.
1083:     *
1084:     * Nao ha efeito externo a antecipar do Destroy para ca (ele so chama
1085:     * DODEFAULT). O cache do resultado acontece em BtnConfirmarClick, ANTES
1086:     * daqui, porque FormBase.Destroy zera this_oBusinessObject.
1087:     *==========================================================================
1088:     PROCEDURE FecharDialogo()
1089:         THIS.Hide()
1090:     ENDPROC
1091: 
1092:     *==========================================================================
1093:     * Destroy - nenhum cursor local a fechar nesta fase (this_cCursorDados
1094:     * pertence ao form pai e nao deve ser tocado aqui); DODEFAULT() preserva
1095:     * o fix de menu/popup da FormBase (regra #29 / Erro58).
1096:     *==========================================================================
1097:     PROCEDURE Destroy()
1098:         DODEFAULT()
1099:     ENDPROC
1100: 
1101: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOcaBO.prg):
*==============================================================================
* SigOpOcaBO.prg - Business Object para SigOpOca (Auditoria de Lancamentos)
*
* Legado  : SIGOPOCA.SCX (task773) - dialogo MODAL "Auditoria de Lancamentos"
* Tabelas : SigMvCcr (UPDATE DtAudits/Auditors - lancamento sendo auditado)
*           SigCqOch (UPDATE ObsAudts - log da acao de auditoria, PK cidchaves)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCA eh aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja
* migrado como Formsigopind.prg), e SOMENTE quando CrSigCdPac.ObsAudts = 1
* (parametro do sistema exigindo observacao ao auditar/desauditar). ANTES de
* abrir o dialogo, o form pai ja:
*   1) decidiu lcTipo ('Auditado'/'DesAuditado') e llData (Datetime() ou NULL)
*      a partir do estado do CheckBox;
*   2) inseriu uma linha em CrSigCqOch (Nopers, Datars, TpLancs, Datas,
*      Usuars, CidChaves=fUniqueIds(), DtLancs=CrSigMvCcr.Datas) - AINDA SO
*      NO BUFFER, nao commitada;
*   3) chama DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval,
*      ThisForm.page.hist.Chk_Auditoria.Top.
*
* O dialogo (Set DataSession To Arquivos) passa a compartilhar a SESSAO do
* form pai e portanto ve as MESMAS CrSigCqOch (a linha recem-inserida, ainda
* em buffer) e CrSigMvCcr (o lancamento sendo auditado, ja posicionado). O
* Confirmar grava a observacao digitada na linha de log, commita essa linha,
* executa o UPDATE em SigMvCcr e fecha o dialogo.
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* A nova arquitetura NAO compartilha data session entre forms (cada form eh
* independente) - por isso os valores que o legado le via cursor
* compartilhado (CrSigMvCcr.Grupos/Contas/Moedas/Nopers/Valors e
* CrSigCqOch.Datas/Cidchaves) chegam aqui como PROPRIEDADES explicitas,
* preenchidas pelo Form a partir do que o chamador fornecer (equivalente
* funcional ao que o legado buscava no cursor). O SQL executado (Fase 2)
* transcreve LITERALMENTE o UPDATE do dump do legado (filtro por
* Grupos+Contas+Moedas+Nopers, NAO por Cidchaves - essa variante com
* Cidchaves pertence ao Click do form pai, nao a este dialogo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOcaBO AS BusinessBase

    *==========================================================================
    * LANCAMENTO SENDO AUDITADO (SigMvCcr) - chave composta usada no WHERE
    * do UPDATE (transcrita literal do cmd_ok.Click do legado) + valor
    * exibido em Get_valor (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cGrupos = ""   && char(10) SigMvCcr.grupos
    this_cContas = ""   && char(10) SigMvCcr.contas
    this_cMoedas = ""   && char(3)  SigMvCcr.moedas
    this_nNopers = 0    && numeric(7,0) SigMvCcr.nopers
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - exibido em Get_valor

    *==========================================================================
    * TIPO DA OPERACAO (pTipo do legado) e novos valores a gravar em
    * SigMvCcr.DtAudits/Auditors (Fase 2 monta exatamente como o cmd_ok.Click:
    * Tipo=.T. -> DtAudits=Datetime(),Auditors=Usuar; Tipo=.F. -> DtAudits=
    * NULL,Auditors=espacos)
    *==========================================================================
    this_lTipo     = .F.   && .T. = Auditado / .F. = DesAuditado
    this_dDtAudits = {}    && datetime NULL - novo valor de SigMvCcr.dtaudits
    this_cAuditors = ""    && char(10) - novo valor de SigMvCcr.auditors

    *==========================================================================
    * LOG DA AUDITORIA (SigCqOch) - linha ja inserida pelo form pai (em
    * buffer, ainda nao commitada), identificada pela cidchaves que o pai
    * gerou com fUniqueIds(). This_dDataAuditoria espelha CrSigCqOch.Datas,
    * exibido em Get_DtAudits (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cCidchavesLog  = ""  && char(20) SigCqOch.cidchaves (PK da linha de log)
    this_dDataAuditoria = {}  && datetime NULL SigCqOch.datas - exibido em Get_DtAudits
    this_cObsAudts      = ""  && text NULL SigCqOch.obsaudts - digitado em Memo_Obs

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado era a PUBLIC Usuar
    *==========================================================================
    this_cUsuario = ""   && char(10) usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigMvCcr" espelha o padrao do SigOpEncBO (mesma familia
    * de dialogos de conta corrente que tocam mais de uma tabela) - o UPDATE
    * real desta tela filtra por Grupos+Contas+Moedas+Nopers (regra #17:
    * transcrever literal), nao por cidchaves; this_cCampoChave fica com o
    * nome convencional da PK de SigMvCcr so para a nomenclatura herdada de
    * BusinessBase (ObterChavePrimaria/RegistrarAuditoria) ter um valor
    * coerente com o schema.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente a PUBLIC Usuar)
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOcaBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos) + ALLTRIM(THIS.this_cContas) + ;
               ALLTRIM(THIS.this_cMoedas) + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvCcr (lancamento sendo
    * auditado) e de SigCqOch (linha de log, ja inserida pelo form pai) a
    * partir de UM cursor combinado montado pelo Form - equivalente ao que o
    * legado lia direto de CrSigMvCcr/CrSigCqOch na sessao compartilhada
    * (regra #8 CLAUDE.md: SELECT (par_cAliasCursor) antes de acessar campo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- SigMvCcr - chave composta usada no WHERE do UPDATE + valor
                *-- exibido em Get_valor
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nValors = TratarNulo(valors, 0)

                *-- SigCqOch - linha de log (PK cidchaves) + data exibida em
                *-- Get_DtAudits (somente leitura)
                THIS.this_cCidchavesLog  = TratarNulo(cidchaves, "")
                THIS.this_dDataAuditoria = TratarNulo(datas, {})
                THIS.this_cObsAudts      = TratarNulo(obsaudts, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpOcaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Executa a confirmacao da auditoria (cmd_ok.Click do legado):
    *
    *   1) decide DtAudits/Auditors conforme this_lTipo (Tipo=.T. -> Auditado:
    *      DtAudits=Datetime(), Auditors=Usuar | Tipo=.F. -> DesAuditado:
    *      DtAudits=NULL, Auditors=espacos)
    *   2) UPDATE SigMvCcr SET DtAudits, Auditors WHERE Grupos+Contas+Moedas+
    *      Nopers (filtro TRANSCRITO literal do dump - regra #17 CLAUDE.md,
    *      NAO eh por cidchaves)
    *   3) UPDATE SigCqOch SET ObsAudts WHERE Cidchaves = this_cCidchavesLog
    *      (equivalente ao "Replace ObsAudts With ThisForm.Memo_Obs.Value in
    *      CrSigCqOch" do legado - a linha em si ja foi inserida e persistida
    *      pelo form pai antes de abrir este dialogo, por isso aqui eh UPDATE
    *      e nao INSERT)
    *
    * Este dialogo NUNCA cria um SigMvCcr novo (sempre atua sobre um
    * lancamento ja existente), por isso Inserir()/ExecutarExclusao() nao sao
    * sobrescritos - o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para esses dois casos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQLCcr, loc_cSQLOch, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lTipo
                THIS.this_dDtAudits = DATETIME()
                THIS.this_cAuditors = THIS.this_cUsuario
            ELSE
                THIS.this_dDtAudits = {}
                THIS.this_cAuditors = SPACE(10)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "SigOpOcaBO.Atualizar")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- 2) UPDATE SigMvCcr - filtro EXATO do legado
                loc_cSQLCcr = "UPDATE SigMvCcr SET"
                loc_cSQLCcr = loc_cSQLCcr + " dtaudits = " + FormatarDataSQL(THIS.this_dDtAudits) + ","
                loc_cSQLCcr = loc_cSQLCcr + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10))
                loc_cSQLCcr = loc_cSQLCcr + " WHERE grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))
                loc_cSQLCcr = loc_cSQLCcr + " AND nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0)

                IF USED("cursor_4c_UpdateCcr")
                    USE IN cursor_4c_UpdateCcr
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLCcr, "cursor_4c_UpdateCcr")

                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar o lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_UpdateCcr")
                        USE IN cursor_4c_UpdateCcr
                    ENDIF

                    *-- 3) UPDATE SigCqOch - observacao digitada em Memo_Obs
                    loc_cSQLOch = "UPDATE SigCqOch SET obsaudts = " + EscaparSQL(THIS.this_cObsAudts) + ;
                        " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchavesLog, 20))

                    IF USED("cursor_4c_UpdateOch")
                        USE IN cursor_4c_UpdateOch
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLOch, "cursor_4c_UpdateOch")

                    IF loc_nResult < 0
                        MsgErro("Erro ao gravar a observa" + CHR(231) + CHR(227) + "o da auditoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_UpdateOch")
                            USE IN cursor_4c_UpdateOch
                        ENDIF

                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpOcaBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

